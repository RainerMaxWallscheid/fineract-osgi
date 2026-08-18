/**
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements. See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership. The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License. You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.ServiceLoader;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import org.apache.fineract.portfolio.charge.moduleapi.ChargeDefinitionPort;
import org.osgi.framework.Bundle;
import org.osgi.framework.BundleContext;
import org.osgi.framework.Constants;
import org.osgi.framework.ServiceReference;
import org.osgi.framework.launch.Framework;
import org.osgi.framework.launch.FrameworkFactory;
import org.osgi.framework.wiring.FrameworkWiring;

/**
 * Start the staged catalog, then register a composition-root hosted
 * {@link ChargeDefinitionPort}. Proves ranking over the empty charge
 * activator without staging Spring.
 */
public final class EquinoxSpringBridgeSmoke {

    private static final Pattern BUNDLE_REF = Pattern.compile("reference:file:([^@,\\s]+)(?:@[^,]*)?");
    private static final String CHARGE_PORT = ChargeDefinitionPort.class.getName();

    private EquinoxSpringBridgeSmoke() {}

    public static void main(String[] args) throws Exception {
        String dirArg = args.length > 0 && !args[0].startsWith("-") ? args[0] : ".";
        Path osgiDir = Path.of(dirArg).toAbsolutePath();
        Path configIni = osgiDir.resolve("config").resolve("config.ini");
        if (!Files.isRegularFile(configIni)) {
            System.err.println("Missing " + configIni + " — run ./gradlew osgiStageBundles");
            System.exit(2);
        }
        List<String> locations = parseBundleLocations(Files.readString(configIni));
        if (locations.isEmpty()) {
            System.err.println("No osgi.bundles entries in " + configIni);
            System.exit(2);
        }

        Path storage = Files.createTempDirectory("fineract-equinox-bridge-smoke-");
        Map<String, String> cfg = new HashMap<>();
        cfg.put(Constants.FRAMEWORK_STORAGE, storage.toString());
        cfg.put(Constants.FRAMEWORK_STORAGE_CLEAN, Constants.FRAMEWORK_STORAGE_CLEAN_ONFIRSTINIT);
        cfg.put("osgi.console.enable.builtin", "false");

        FrameworkFactory factory = ServiceLoader.load(FrameworkFactory.class).iterator().next();
        Framework framework = factory.newFramework(cfg);
        framework.init();
        BundleContext ctx = framework.getBundleContext();
        int installFailures = 0;
        for (String location : locations) {
            try {
                ctx.installBundle(location);
            } catch (Exception ex) {
                installFailures++;
                System.err.println("INSTALL_FAIL " + location + " " + ex.getMessage());
            }
        }
        framework.start();
        FrameworkWiring wiring = ctx.getBundle().adapt(FrameworkWiring.class);
        if (wiring != null) {
            wiring.resolveBundles(null);
        }

        int startFailures = 0;
        for (Bundle bundle : ctx.getBundles()) {
            if (bundle.getBundleId() == 0) {
                continue;
            }
            try {
                bundle.start();
            } catch (Exception ex) {
                startFailures++;
                System.err.println("START_FAIL " + bundle.getSymbolicName() + " " + explain(ex));
            }
        }

        CompositionRootOsgiBridge bridge = new CompositionRootOsgiBridge(ctx, new HostedChargeDefinitionPort());
        bridge.start();

        ServiceReference<?>[] all = ctx.getServiceReferences(CHARGE_PORT, null);
        int count = all == null ? 0 : all.length;
        System.out.println("SERVICE " + CHARGE_PORT + " " + count);

        ServiceReference<?> selected = ctx.getServiceReference(CHARGE_PORT);
        boolean hostedWins = false;
        if (selected != null) {
            Object provider = selected.getProperty("provider");
            Object ranking = selected.getProperty(Constants.SERVICE_RANKING);
            System.out.println("SELECTED provider=" + provider + " ranking=" + ranking);
            Object service = ctx.getService(selected);
            if (service instanceof ChargeDefinitionPort port) {
                hostedWins = port.existsActiveCharge(HostedChargeDefinitionPort.HOSTED_ID);
                System.out.println("HOSTED existsActiveCharge(" + HostedChargeDefinitionPort.HOSTED_ID + ") " + hostedWins);
                ctx.ungetService(selected);
            } else {
                System.out.println("SELECTED_TYPE " + (service == null ? "null" : service.getClass().getName()));
            }
        } else {
            System.out.println("SELECTED none");
        }

        bridge.stop();
        framework.stop();
        framework.waitForStop(10_000);

        // System classpath ChargeDefinitionPort is not assignable to the bundle
        // stub's Class, so this context sees only the hosted registration.
        boolean ok = installFailures == 0 && startFailures == 0 && hostedWins;
        System.out.println("SUMMARY staged=" + locations.size() + " installFailures=" + installFailures + " startFailures="
                + startFailures + " chargeServices=" + count + " hostedWins=" + hostedWins);
        System.exit(ok ? 0 : 1);
    }

    private static List<String> parseBundleLocations(String ini) {
        String bundlesLine = null;
        for (String raw : ini.split("\\R")) {
            if (raw.startsWith("osgi.bundles=")) {
                bundlesLine = raw.substring("osgi.bundles=".length());
                break;
            }
        }
        if (bundlesLine == null) {
            return List.of();
        }
        List<String> locations = new ArrayList<>();
        Matcher matcher = BUNDLE_REF.matcher(bundlesLine);
        while (matcher.find()) {
            locations.add("reference:file:" + matcher.group(1));
        }
        return locations;
    }

    private static String explain(Throwable error) {
        StringBuilder out = new StringBuilder();
        for (Throwable current = error; current != null; current = current.getCause()) {
            if (out.length() > 0) {
                out.append(" caused by ");
            }
            out.append(current.getClass().getSimpleName());
            if (current.getMessage() != null && !current.getMessage().isBlank()) {
                out.append(": ").append(current.getMessage());
            }
        }
        return out.toString();
    }
}
