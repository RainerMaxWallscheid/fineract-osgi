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
import org.apache.fineract.portfolio.floatingrates.moduleapi.FloatingRatePort;
import org.apache.fineract.portfolio.tax.moduleapi.TaxCatalogPort;
import org.osgi.framework.Bundle;
import org.osgi.framework.BundleContext;
import org.osgi.framework.Constants;
import org.osgi.framework.ServiceReference;
import org.osgi.framework.launch.Framework;
import org.osgi.framework.launch.FrameworkFactory;
import org.osgi.framework.wiring.FrameworkWiring;

/**
 * Start the staged catalog, then register composition-root hosted Wave-1
 * catalog ports. Proves ranking over empty activators without staging Spring.
 */
public final class EquinoxSpringBridgeSmoke {

    private static final Pattern BUNDLE_REF = Pattern.compile("reference:file:([^@,\\s]+)(?:@[^,]*)?");
    private static final String CHARGE_PORT = ChargeDefinitionPort.class.getName();
    private static final String RATES_PORT = FloatingRatePort.class.getName();
    private static final String TAX_PORT = TaxCatalogPort.class.getName();

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

        CompositionRootOsgiBridge bridge = new CompositionRootOsgiBridge(ctx, new HostedChargeDefinitionPort(),
                new HostedFloatingRatePort(), new HostedTaxCatalogPort());
        bridge.start();

        boolean chargeWins = probeCharge(ctx);
        boolean ratesWins = probeRates(ctx);
        boolean taxWins = probeTax(ctx);

        bridge.stop();
        framework.stop();
        framework.waitForStop(10_000);

        // System classpath port types are not assignable to the bundle stubs'
        // Class objects, so this context sees only the hosted registrations.
        boolean ok = installFailures == 0 && startFailures == 0 && chargeWins && ratesWins && taxWins;
        System.out.println("SUMMARY staged=" + locations.size() + " installFailures=" + installFailures + " startFailures="
                + startFailures + " chargeWins=" + chargeWins + " ratesWins=" + ratesWins + " taxWins=" + taxWins);
        System.exit(ok ? 0 : 1);
    }

    private static boolean probeCharge(final BundleContext ctx) throws Exception {
        return probe(ctx, CHARGE_PORT, service -> service instanceof ChargeDefinitionPort port
                && port.existsActiveCharge(HostedChargeDefinitionPort.HOSTED_ID));
    }

    private static boolean probeRates(final BundleContext ctx) throws Exception {
        return probe(ctx, RATES_PORT, service -> service instanceof FloatingRatePort port
                && port.findFloatingRate(HostedFloatingRatePort.HOSTED_ID).isPresent());
    }

    private static boolean probeTax(final BundleContext ctx) throws Exception {
        return probe(ctx, TAX_PORT, service -> service instanceof TaxCatalogPort port
                && port.findTaxGroup(HostedTaxCatalogPort.HOSTED_ID).isPresent());
    }

    private static boolean probe(final BundleContext ctx, final String typeName, final java.util.function.Predicate<Object> hosted)
            throws Exception {
        ServiceReference<?>[] all = ctx.getServiceReferences(typeName, null);
        int count = all == null ? 0 : all.length;
        System.out.println("SERVICE " + typeName + " " + count);
        ServiceReference<?> selected = ctx.getServiceReference(typeName);
        boolean wins = false;
        if (selected != null) {
            Object provider = selected.getProperty("provider");
            Object ranking = selected.getProperty(Constants.SERVICE_RANKING);
            System.out.println("SELECTED " + typeName + " provider=" + provider + " ranking=" + ranking);
            Object service = ctx.getService(selected);
            wins = hosted.test(service);
            System.out.println("HOSTED " + typeName + " " + wins);
            ctx.ungetService(selected);
        } else {
            System.out.println("SELECTED " + typeName + " none");
        }
        return wins;
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
