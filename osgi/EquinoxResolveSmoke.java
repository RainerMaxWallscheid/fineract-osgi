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
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.ServiceLoader;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import org.osgi.framework.Bundle;
import org.osgi.framework.BundleContext;
import org.osgi.framework.Constants;
import org.osgi.framework.launch.Framework;
import org.osgi.framework.launch.FrameworkFactory;
import org.osgi.framework.wiring.FrameworkWiring;

/**
 * Install the staged catalog and resolve it. Does not start fineract bundles
 * (no Spring / DS). Prints one {@code STATE BSN} line per bundle.
 */
public final class EquinoxResolveSmoke {
    private static final Pattern BUNDLE_REF = Pattern
            .compile("reference:file:([^@,\\s]+)(?:@[^,]*)?");

    private EquinoxResolveSmoke() {}

    public static void main(String[] args) throws Exception {
        Path osgiDir = Path.of(args.length > 0 ? args[0] : ".").toAbsolutePath();
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

        Path storage = Files.createTempDirectory("fineract-equinox-smoke-");
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

        List<Bundle> bundles = new ArrayList<>(List.of(ctx.getBundles()));
        bundles.sort(Comparator.comparing(b -> String.valueOf(b.getSymbolicName())));
        int fineract = 0;
        int installed = 0;
        int resolved = 0;
        int active = 0;
        for (Bundle bundle : bundles) {
            String bsn = bundle.getSymbolicName();
            String state = stateName(bundle.getState());
            System.out.println(state + " " + bsn);
            if (bsn != null && bsn.startsWith("org.apache.fineract.")) {
                fineract++;
                if (bundle.getState() == Bundle.INSTALLED) {
                    installed++;
                } else if (bundle.getState() == Bundle.RESOLVED) {
                    resolved++;
                } else if (bundle.getState() == Bundle.ACTIVE) {
                    active++;
                }
            }
        }
        System.out.println("SUMMARY staged=" + locations.size() + " fineract=" + fineract
                + " INSTALLED=" + installed + " RESOLVED=" + resolved + " ACTIVE=" + active
                + " installFailures=" + installFailures);
        framework.stop();
        framework.waitForStop(10_000);
        System.exit(installFailures == 0 ? 0 : 1);
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

    private static String stateName(int state) {
        return switch (state) {
            case Bundle.UNINSTALLED -> "UNINSTALLED";
            case Bundle.INSTALLED -> "INSTALLED";
            case Bundle.RESOLVED -> "RESOLVED";
            case Bundle.STARTING -> "STARTING";
            case Bundle.STOPPING -> "STOPPING";
            case Bundle.ACTIVE -> "ACTIVE";
            default -> "STATE_" + state;
        };
    }
}
