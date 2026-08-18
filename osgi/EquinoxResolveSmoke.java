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
 * Install the staged catalog and resolve it. With {@code --start}, also start
 * every non-system bundle and probe a few Module API ports in the Service
 * Registry. Starting does not run Spring, so registrars do not fire.
 */
public final class EquinoxResolveSmoke {
    private static final Pattern BUNDLE_REF = Pattern
            .compile("reference:file:([^@,\\s]+)(?:@[^,]*)?");

    private static final String[] PILOT_PORTS = {
            "org.apache.fineract.command.core.CommandDispatcher",
            "org.apache.fineract.portfolio.charge.moduleapi.ChargeDefinitionPort",
            "org.apache.fineract.portfolio.floatingrates.moduleapi.FloatingRatePort",
            "org.apache.fineract.portfolio.tax.moduleapi.TaxCatalogPort",
            "org.apache.fineract.infrastructure.contentstore.service.ContentStoreService",
            "org.apache.fineract.infrastructure.contentstore.moduleapi.ContentStreamPort",
            "org.apache.fineract.organisation.teller.moduleapi.CashierTxnValidationPort",
            "org.apache.fineract.portfolio.loanorigination.service.LoanOriginatorReadPlatformService",
            "org.apache.fineract.mix.service.MixTaxonomyReadService",
            "org.apache.fineract.investor.service.DelayedSettlementAttributeService",
            "org.apache.fineract.accounting.closure.service.GLClosureReadPlatformService",
            "org.apache.fineract.portfolio.savings.service.SavingsDropdownReadPlatformService",
            "org.apache.fineract.portfolio.loanproduct.service.LoanProductLookupReadPort",
            "org.apache.fineract.portfolio.loanaccount.progressiveloan.service.BuyDownFeeReadPlatformService",
            "org.apache.fineract.portfolio.workingcapitalloan.service.WorkingCapitalLoanPeriodPaymentRateChangeReadService",
            "org.apache.fineract.cob.service.ConfigJobParameterService",
            "org.apache.fineract.infrastructure.security.service.AccessTokenGenerationService",
            "org.apache.fineract.infrastructure.businessdate.service.BusinessDateReadPlatformService",
            "org.apache.fineract.infrastructure.codes.service.CodeReadPlatformService",
            "org.apache.fineract.organisation.provisioning.service.ProvisioningCategoryReadPlatformService",
            "org.apache.fineract.organisation.monetary.service.CurrencyWritePlatformService",
            "org.apache.fineract.useradministration.service.PasswordValidationPolicyReadPlatformService",
            "org.apache.fineract.adhocquery.service.AdHocReadPlatformService",
            "org.apache.fineract.template.service.TemplateMergeService",
            "org.apache.fineract.notification.service.UserNotificationService",
            "org.apache.fineract.spm.service.ScorecardReadPlatformService",
            "org.apache.fineract.portfolio.fund.service.FundReadPlatformService",
            "org.apache.fineract.infrastructure.accountnumberformat.service.AccountNumberFormatReadPlatformService",
            "org.apache.fineract.infrastructure.survey.service.ReadLikelihoodService",
            "org.apache.fineract.portfolio.transfer.service.TransferWritePlatformService",
            "org.apache.fineract.portfolio.paymenttype.service.PaymentTypeReadService",
            "org.apache.fineract.portfolio.search.service.SearchReadService",
            "org.apache.fineract.portfolio.collectionsheet.service.CollectionSheetWritePlatformService",
            "org.apache.fineract.portfolio.account.service.StandingInstructionWritePlatformService",
            "org.apache.fineract.shares.shareproducts.service.ShareProductDropdownReadPlatformService",
            "org.apache.fineract.portfolio.group.service.GroupLevelReadPlatformService",
            "org.apache.fineract.portfolio.client.service.ClientIdentifierWritePlatformService",
            "org.apache.fineract.portfolio.repaymentwithpostdatedchecks.service.RepaymentWithPostDatedChecksWritePlatformService"
    };

    private EquinoxResolveSmoke() {}

    public static void main(String[] args) throws Exception {
        boolean start = false;
        String dirArg = ".";
        for (String arg : args) {
            if ("--start".equals(arg)) {
                start = true;
            } else if (!arg.startsWith("-")) {
                dirArg = arg;
            }
        }
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

        int startFailures = 0;
        if (start) {
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
        if (start) {
            for (String typeName : PILOT_PORTS) {
                var refs = ctx.getServiceReferences(typeName, null);
                int count = refs == null ? 0 : refs.length;
                System.out.println("SERVICE " + typeName + " " + count);
            }
        }
        System.out.println("SUMMARY staged=" + locations.size() + " fineract=" + fineract
                + " INSTALLED=" + installed + " RESOLVED=" + resolved + " ACTIVE=" + active
                + " installFailures=" + installFailures + " startFailures=" + startFailures
                + " started=" + start);
        framework.stop();
        framework.waitForStop(10_000);
        System.exit(installFailures == 0 && startFailures == 0 ? 0 : 1);
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
