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
import java.math.BigDecimal;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.ServiceLoader;
import java.util.function.Predicate;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import org.apache.fineract.accounting.closure.service.GLClosureReadPlatformService;
import org.apache.fineract.adhocquery.service.AdHocReadPlatformService;
import org.apache.fineract.cob.service.ConfigJobParameterService;
import org.apache.fineract.command.core.Command;
import org.apache.fineract.command.core.CommandDispatcher;
import org.apache.fineract.infrastructure.accountnumberformat.service.AccountNumberFormatReadPlatformService;
import org.apache.fineract.infrastructure.businessdate.domain.BusinessDateType;
import org.apache.fineract.infrastructure.businessdate.service.BusinessDateReadPlatformService;
import org.apache.fineract.infrastructure.cache.domain.CacheType;
import org.apache.fineract.infrastructure.cache.service.CacheWritePlatformService;
import org.apache.fineract.infrastructure.campaigns.sms.service.SmsCampaignDropdownReadPlatformService;
import org.apache.fineract.infrastructure.codes.service.CodeReadPlatformService;
import org.apache.fineract.infrastructure.configuration.service.ExternalServicesReadPlatformService;
import org.apache.fineract.infrastructure.contentstore.service.ContentStoreService;
import org.apache.fineract.infrastructure.core.data.CommandProcessingResult;
import org.apache.fineract.infrastructure.creditbureau.service.CreditBureauReadPlatformService;
import org.apache.fineract.infrastructure.dataqueries.service.ReportWritePlatformService;
import org.apache.fineract.infrastructure.entityaccess.service.FineractEntityAccessReadService;
import org.apache.fineract.infrastructure.gcm.service.NotificationConfigurationReadService;
import org.apache.fineract.infrastructure.hooks.service.HookReadPlatformService;
import org.apache.fineract.infrastructure.jobs.service.StuckJobExecutorService;
import org.apache.fineract.infrastructure.reportmailingjob.service.ReportMailingJobConfigurationReadPlatformService;
import org.apache.fineract.infrastructure.security.service.AccessTokenGenerationService;
import org.apache.fineract.infrastructure.sms.service.SmsWritePlatformService;
import org.apache.fineract.infrastructure.springbatch.PropertyService;
import org.apache.fineract.infrastructure.survey.service.ReadLikelihoodService;
import org.apache.fineract.investor.service.DelayedSettlementAttributeService;
import org.apache.fineract.mix.service.MixTaxonomyReadService;
import org.apache.fineract.notification.service.UserNotificationService;
import org.apache.fineract.organisation.monetary.data.CurrencyUpdateRequest;
import org.apache.fineract.organisation.monetary.service.CurrencyWritePlatformService;
import org.apache.fineract.organisation.provisioning.service.ProvisioningCategoryReadPlatformService;
import org.apache.fineract.organisation.teller.moduleapi.CashierTxnValidationPort;
import org.apache.fineract.portfolio.account.service.StandingInstructionWritePlatformService;
import org.apache.fineract.portfolio.address.service.FieldConfigurationReadPlatformService;
import org.apache.fineract.portfolio.calendar.service.CalendarDropdownReadPlatformService;
import org.apache.fineract.portfolio.charge.moduleapi.ChargeDefinitionPort;
import org.apache.fineract.portfolio.client.service.ClientIdentifierWritePlatformService;
import org.apache.fineract.portfolio.collateral.service.CollateralWritePlatformService;
import org.apache.fineract.portfolio.collateralmanagement.service.CollateralManagementReadService;
import org.apache.fineract.portfolio.collectionsheet.service.CollectionSheetWritePlatformService;
import org.apache.fineract.portfolio.floatingrates.moduleapi.FloatingRatePort;
import org.apache.fineract.portfolio.fund.service.FundReadPlatformService;
import org.apache.fineract.portfolio.group.service.GroupLevelReadPlatformService;
import org.apache.fineract.portfolio.loanaccount.progressiveloan.service.BuyDownFeeReadPlatformService;
import org.apache.fineract.portfolio.loanorigination.service.LoanOriginatorReadPlatformService;
import org.apache.fineract.portfolio.loanproduct.service.LoanProductLookupReadPort;
import org.apache.fineract.portfolio.meeting.service.MeetingAttendanceDropdownReadService;
import org.apache.fineract.portfolio.note.service.NoteReadPlatformService;
import org.apache.fineract.portfolio.paymenttype.service.PaymentTypeReadService;
import org.apache.fineract.portfolio.products.service.ProductCommandsService;
import org.apache.fineract.portfolio.repaymentwithpostdatedchecks.service.RepaymentWithPostDatedChecksWritePlatformService;
import org.apache.fineract.portfolio.savings.service.SavingsDropdownReadPlatformService;
import org.apache.fineract.portfolio.search.data.SearchConditions;
import org.apache.fineract.portfolio.search.service.SearchReadService;
import org.apache.fineract.portfolio.tax.moduleapi.TaxCatalogPort;
import org.apache.fineract.portfolio.transfer.service.TransferWritePlatformService;
import org.apache.fineract.portfolio.workingcapitalloan.service.WorkingCapitalLoanPeriodPaymentRateChangeReadService;
import org.apache.fineract.shares.shareproducts.service.ShareProductDropdownReadPlatformService;
import org.apache.fineract.spm.service.ScorecardReadPlatformService;
import org.apache.fineract.template.data.TemplateData;
import org.apache.fineract.template.service.TemplateMergeService;
import org.apache.fineract.useradministration.service.PasswordValidationPolicyReadPlatformService;
import org.osgi.framework.Bundle;
import org.osgi.framework.BundleContext;
import org.osgi.framework.Constants;
import org.osgi.framework.ServiceReference;
import org.osgi.framework.launch.Framework;
import org.osgi.framework.launch.FrameworkFactory;
import org.osgi.framework.wiring.FrameworkWiring;

/**
 * Start the staged catalog, then register every composition-root hosted
 * PILOT_PORT (in-memory, not JPA / Spring). {@link org.apache.fineract.infrastructure.contentstore.moduleapi.ContentStreamPort}
 * stays empty-catalog only. Proves ranking over empty activators.
 */
public final class EquinoxSpringBridgeSmoke {

    private static final Pattern BUNDLE_REF = Pattern.compile("reference:file:([^@,\\s]+)(?:@[^,]*)?");

    private record NamedProbe(String typeName, Predicate<Object> hosted) {}

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

        CompositionRootOsgiBridge bridge = new CompositionRootOsgiBridge(ctx);
        bridge.start();

        int hostedWins = 0;
        int hostedFails = 0;
        for (NamedProbe named : probes()) {
            if (probe(ctx, named.typeName, named.hosted)) {
                hostedWins++;
            } else {
                hostedFails++;
            }
        }

        bridge.stop();
        framework.stop();
        framework.waitForStop(10_000);

        boolean ok = installFailures == 0 && startFailures == 0 && hostedFails == 0;
        System.out.println("SUMMARY staged=" + locations.size() + " installFailures=" + installFailures + " startFailures="
                + startFailures + " hostedWins=" + hostedWins + " hostedFails=" + hostedFails);
        System.exit(ok ? 0 : 1);
    }

    private static List<NamedProbe> probes() {
        return List.of(
                probeOf(ChargeDefinitionPort.class, s -> s instanceof ChargeDefinitionPort p
                        && p.existsActiveCharge(HostedChargeDefinitionPort.HOSTED_ID)),
                probeOf(FloatingRatePort.class, s -> s instanceof FloatingRatePort p
                        && p.findFloatingRate(HostedFloatingRatePort.HOSTED_ID).isPresent()),
                probeOf(TaxCatalogPort.class, s -> s instanceof TaxCatalogPort p
                        && p.findTaxGroup(HostedTaxCatalogPort.HOSTED_ID).isPresent()),
                probeOf(ContentStoreService.class, EquinoxSpringBridgeSmoke::contentWins),
                probeOf(CashierTxnValidationPort.class, EquinoxSpringBridgeSmoke::cashierWins),
                probeOf(LoanOriginatorReadPlatformService.class, s -> s instanceof LoanOriginatorReadPlatformService p
                        && HostedLoanOriginatorReadPlatformService.HOSTED_ID == p
                                .retrieveById(HostedLoanOriginatorReadPlatformService.HOSTED_ID).getId()),
                probeOf(MixTaxonomyReadService.class, s -> {
                    if (!(s instanceof MixTaxonomyReadService p)) {
                        return false;
                    }
                    final var row = p.retrieveOne(HostedMixTaxonomyReadService.HOSTED_ID);
                    return row != null && HostedMixTaxonomyReadService.HOSTED_ID == row.getId();
                }),
                probeOf(DelayedSettlementAttributeService.class, s -> s instanceof DelayedSettlementAttributeService p
                        && p.isEnabled(HostedDelayedSettlementAttributeService.HOSTED_PRODUCT_ID)),
                probeOf(CommandDispatcher.class, EquinoxSpringBridgeSmoke::commandWins),
                probeOf(GLClosureReadPlatformService.class, s -> s instanceof GLClosureReadPlatformService p
                        && HostedGLClosureReadPlatformService.HOSTED_ID == p.retrieveGLClosureById(1L).getId()),
                probeOf(SavingsDropdownReadPlatformService.class, s -> s instanceof SavingsDropdownReadPlatformService p
                        && HostedSavingsDropdownReadPlatformService.HOSTED_ID == p.retrieveLockinPeriodFrequencyTypeOptions().iterator()
                                .next().getId()),
                probeOf(LoanProductLookupReadPort.class, s -> s instanceof LoanProductLookupReadPort p
                        && HostedLoanProductLookupReadPort.HOSTED_ID == p.retrieveAllLoanProductsForLookup().iterator().next().getId()),
                probeOf(BuyDownFeeReadPlatformService.class, s -> s instanceof BuyDownFeeReadPlatformService p
                        && HostedBuyDownFeeReadPlatformService.HOSTED_ID == p.retrieveLoanBuyDownFeeAmortizationDetails(1L).get(0).id()),
                probeOf(WorkingCapitalLoanPeriodPaymentRateChangeReadService.class,
                        s -> s instanceof WorkingCapitalLoanPeriodPaymentRateChangeReadService p
                                && HostedWorkingCapitalLoanPeriodPaymentRateChangeReadService.HOSTED_ID == p.retrieveRateChangeHistory(1L)
                                        .get(0).id()),
                probeOf(ConfigJobParameterService.class, s -> s instanceof ConfigJobParameterService p
                        && p.getAllConfiguredJobNames().contains(HostedConfigJobParameterService.HOSTED_JOB)),
                probeOf(AccessTokenGenerationService.class, s -> s instanceof AccessTokenGenerationService p
                        && HostedAccessTokenGenerationService.HOSTED.equals(p.generateRandomToken())),
                probeOf(BusinessDateReadPlatformService.class, s -> s instanceof BusinessDateReadPlatformService p
                        && BusinessDateType.BUSINESS_DATE == p.findByType(BusinessDateType.BUSINESS_DATE.name()).getType()),
                probeOf(CodeReadPlatformService.class, s -> s instanceof CodeReadPlatformService p
                        && HostedCodeReadPlatformService.HOSTED_ID == p.retrieveCode(1L).getId()),
                probeOf(ProvisioningCategoryReadPlatformService.class, s -> s instanceof ProvisioningCategoryReadPlatformService p
                        && HostedProvisioningCategoryReadPlatformService.HOSTED_ID == p.retrieveAllProvisionCategories().get(0).getId()),
                probeOf(CurrencyWritePlatformService.class, s -> s instanceof CurrencyWritePlatformService p
                        && p.updateAllowedCurrencies(new CurrencyUpdateRequest(List.of("USD"))).getCurrencies()
                                .contains(HostedCurrencyWritePlatformService.HOSTED)),
                probeOf(PasswordValidationPolicyReadPlatformService.class, s -> s instanceof PasswordValidationPolicyReadPlatformService p
                        && p.retrieveActiveValidationPolicy() != null && p.retrieveAll().size() == 1),
                probeOf(AdHocReadPlatformService.class, s -> s instanceof AdHocReadPlatformService p
                        && HostedAdHocReadPlatformService.HOSTED_ID == p.retrieveOne(1L).getId()),
                probeOf(TemplateMergeService.class, s -> s instanceof TemplateMergeService p
                        && HostedTemplateMergeService.HOSTED.equals(p.compile(TemplateData.builder().id(1L).name("hosted").text("hosted")
                                .build(), Map.of()))),
                probeOf(UserNotificationService.class, s -> s instanceof UserNotificationService p
                        && p.hasUnreadUserNotifications(HostedUserNotificationService.HOSTED_USER_ID)),
                probeOf(ScorecardReadPlatformService.class, s -> s instanceof ScorecardReadPlatformService p
                        && HostedScorecardReadPlatformService.HOSTED_ID == p.retrieveScorecardByClient(1L).iterator().next().getId()),
                probeOf(FundReadPlatformService.class, s -> s instanceof FundReadPlatformService p
                        && HostedFundReadPlatformService.HOSTED_ID == p.retrieveFund(1L).getId()),
                probeOf(AccountNumberFormatReadPlatformService.class, s -> s instanceof AccountNumberFormatReadPlatformService p
                        && HostedAccountNumberFormatReadPlatformService.HOSTED_ID == p.getAccountNumberFormat(1L).getId()),
                probeOf(ReadLikelihoodService.class, s -> s instanceof ReadLikelihoodService p
                        && HostedReadLikelihoodService.HOSTED_ID == p.retrieve(1L).getResourceId()),
                probeOf(TransferWritePlatformService.class, s -> s instanceof TransferWritePlatformService p
                        && HostedTransferWritePlatformService.HOSTED_ID == p.proposeClientTransfer(1L, null).getResourceId()),
                probeOf(PaymentTypeReadService.class, s -> s instanceof PaymentTypeReadService p
                        && HostedPaymentTypeReadService.HOSTED_ID == p.retrieveOne(1L).getId()),
                probeOf(SearchReadService.class, s -> s instanceof SearchReadService p
                        && HostedSearchReadService.HOSTED_ID == p.retriveMatchingData(new SearchConditions("hosted", "clients", false, "."))
                                .get(0).getEntityId()),
                probeOf(CollectionSheetWritePlatformService.class, s -> s instanceof CollectionSheetWritePlatformService p
                        && HostedCollectionSheetWritePlatformService.HOSTED_ID == p.updateCollectionSheet(null).getResourceId()),
                probeOf(StandingInstructionWritePlatformService.class, s -> s instanceof StandingInstructionWritePlatformService p
                        && HostedStandingInstructionWritePlatformService.HOSTED_ID == p.create(null).getResourceId()),
                probeOf(ShareProductDropdownReadPlatformService.class, s -> s instanceof ShareProductDropdownReadPlatformService p
                        && HostedShareProductDropdownReadPlatformService.HOSTED_ID == p.retrieveLockinPeriodFrequencyTypeOptions()
                                .iterator().next().getId()),
                probeOf(GroupLevelReadPlatformService.class, s -> s instanceof GroupLevelReadPlatformService p
                        && HostedGroupLevelReadPlatformService.HOSTED_ID == p.retrieveAllLevels().get(0).getLevelId()),
                probeOf(ClientIdentifierWritePlatformService.class, s -> s instanceof ClientIdentifierWritePlatformService p
                        && HostedClientIdentifierWritePlatformService.HOSTED_ID == p.addClientIdentifier(1L, null).getResourceId()),
                probeOf(RepaymentWithPostDatedChecksWritePlatformService.class,
                        s -> s instanceof RepaymentWithPostDatedChecksWritePlatformService p
                                && HostedRepaymentWithPostDatedChecksWritePlatformService.HOSTED_ID == p.updatePostDatedChecks(null)
                                        .getResourceId()),
                probeOf(ProductCommandsService.class, s -> s instanceof ProductCommandsService p
                        && HostedProductCommandsService.HOSTED_ID == ((CommandProcessingResult) p.handleCommand(1L, "hosted", "{}"))
                                .getResourceId()),
                probeOf(CacheWritePlatformService.class, s -> s instanceof CacheWritePlatformService p
                        && Integer.valueOf(HostedCacheWritePlatformService.HOSTED_TYPE).equals(p.switchToCache(CacheType.NO_CACHE)
                                .get("cacheType"))),
                probeOf(FineractEntityAccessReadService.class, s -> s instanceof FineractEntityAccessReadService p
                        && HostedFineractEntityAccessReadService.HOSTED_SQL.equals(p.getSQLQueryInClauseIDList_ForChargesForOffice(1L,
                                false))),
                probeOf(CalendarDropdownReadPlatformService.class, s -> s instanceof CalendarDropdownReadPlatformService p
                        && HostedCalendarDropdownReadPlatformService.HOSTED_ID == p.retrieveCalendarTypeOptions().get(0).getId()),
                probeOf(MeetingAttendanceDropdownReadService.class, s -> s instanceof MeetingAttendanceDropdownReadService p
                        && HostedMeetingAttendanceDropdownReadService.HOSTED_ID == p.retrieveAttendanceTypeOptions().get(0).getId()),
                probeOf(FieldConfigurationReadPlatformService.class, s -> s instanceof FieldConfigurationReadPlatformService p
                        && HostedFieldConfigurationReadPlatformService.HOSTED_ID == p.retrieveFieldConfiguration("hosted").get(0)
                                .fieldConfigurationId()),
                probeOf(CreditBureauReadPlatformService.class, s -> s instanceof CreditBureauReadPlatformService p
                        && HostedCreditBureauReadPlatformService.HOSTED_ID == p.retrieveCreditBureau().iterator().next()
                                .getCreditBureauId()),
                probeOf(CollateralWritePlatformService.class, s -> s instanceof CollateralWritePlatformService p
                        && HostedCollateralWritePlatformService.HOSTED_ID == p.addCollateral(1L, null).getResourceId()),
                probeOf(CollateralManagementReadService.class, s -> s instanceof CollateralManagementReadService p
                        && HostedCollateralManagementReadService.HOSTED_ID == p.getCollateralProduct(1L).getId()),
                probeOf(NoteReadPlatformService.class, s -> s instanceof NoteReadPlatformService p
                        && HostedNoteReadPlatformService.HOSTED_ID == p.retrieveNote(1L, 1L, 1).getId()),
                probeOf(HookReadPlatformService.class, s -> s instanceof HookReadPlatformService p
                        && HostedHookReadPlatformService.HOSTED_ID == p.retrieveHook(1L).getId()),
                probeOf(SmsWritePlatformService.class, s -> s instanceof SmsWritePlatformService p
                        && HostedSmsWritePlatformService.HOSTED_ID == p.create(null).getResourceId()),
                probeOf(ReportMailingJobConfigurationReadPlatformService.class,
                        s -> s instanceof ReportMailingJobConfigurationReadPlatformService p
                                && HostedReportMailingJobConfigurationReadPlatformService.HOSTED_ID == p
                                        .retrieveReportMailingJobConfiguration("hosted").getId()),
                probeOf(SmsCampaignDropdownReadPlatformService.class, s -> s instanceof SmsCampaignDropdownReadPlatformService p
                        && HostedSmsCampaignDropdownReadPlatformService.HOSTED_ID == p.retrieveSmsProviders().iterator().next().getId()),
                probeOf(NotificationConfigurationReadService.class, s -> s instanceof NotificationConfigurationReadService p
                        && HostedNotificationConfigurationReadService.HOSTED_ID == p.getNotificationConfiguration().getId()),
                probeOf(ReportWritePlatformService.class, s -> s instanceof ReportWritePlatformService p
                        && HostedReportWritePlatformService.HOSTED_ID == p.createReport(null).getResourceId()),
                probeOf(ExternalServicesReadPlatformService.class, s -> s instanceof ExternalServicesReadPlatformService p
                        && HostedExternalServicesReadPlatformService.HOSTED_ID == p.getExternalServiceDetailsByServiceName("hosted")
                                .getId()),
                probeOf(StuckJobExecutorService.class, EquinoxSpringBridgeSmoke::stuckJobWins),
                probeOf(PropertyService.class, s -> s instanceof PropertyService p
                        && HostedPropertyService.HOSTED_SIZE == p.getPartitionSize("hosted")));
    }

    private static NamedProbe probeOf(final Class<?> type, final Predicate<Object> hosted) {
        return new NamedProbe(type.getName(), hosted);
    }

    private static boolean contentWins(final Object service) {
        if (!(service instanceof ContentStoreService port)) {
            return false;
        }
        try (var in = port.download(HostedContentStoreService.HOSTED_PATH)) {
            return Arrays.equals(in.readAllBytes(), HostedContentStoreService.HOSTED_BYTES);
        } catch (final Exception ex) {
            return false;
        }
    }

    private static boolean cashierWins(final Object service) {
        if (!(service instanceof HostedCashierTxnValidationPort port)) {
            return false;
        }
        port.validateOnLoanDisbursal(HostedCashierTxnValidationPort.HOSTED_STAFF_ID, "USD", BigDecimal.TEN);
        return HostedCashierTxnValidationPort.HOSTED_STAFF_ID == port.lastStaffId();
    }

    private static boolean commandWins(final Object service) {
        if (!(service instanceof CommandDispatcher port)) {
            return false;
        }
        return HostedCommandDispatcher.HOSTED.equals(port.dispatch(new Command<String>()).get());
    }

    private static boolean stuckJobWins(final Object service) {
        if (!(service instanceof HostedStuckJobExecutorService port)) {
            return false;
        }
        port.resumeStuckJob(HostedStuckJobExecutorService.HOSTED_JOB);
        return HostedStuckJobExecutorService.HOSTED_JOB.equals(port.lastJobName());
    }

    private static boolean probe(final BundleContext ctx, final String typeName, final Predicate<Object> hosted) throws Exception {
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
