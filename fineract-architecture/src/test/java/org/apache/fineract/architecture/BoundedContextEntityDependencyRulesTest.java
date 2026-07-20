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
package org.apache.fineract.architecture;

import static com.tngtech.archunit.core.domain.JavaClass.Predicates.resideInAnyPackage;
import static com.tngtech.archunit.lang.syntax.ArchRuleDefinition.noClasses;
import static com.tngtech.archunit.library.freeze.FreezingArchRule.freeze;
import static org.apache.fineract.architecture.ArchitecturePackages.ACCOUNTING_DOMAIN;
import static org.apache.fineract.architecture.ArchitecturePackages.BASE;
import static org.apache.fineract.architecture.ArchitecturePackages.CLIENT_DOMAIN;
import static org.apache.fineract.architecture.ArchitecturePackages.GROUP_DOMAIN;
import static org.apache.fineract.architecture.ArchitecturePackages.JOURNAL_ENTRY_DOMAIN;
import static org.apache.fineract.architecture.ArchitecturePackages.LOAN_ACCOUNT_DOMAIN;
import static org.apache.fineract.architecture.ArchitecturePackages.LOAN_ORIGINATION_DOMAIN;
import static org.apache.fineract.architecture.ArchitecturePackages.LOAN_PRODUCT_DOMAIN;
import static org.apache.fineract.architecture.ArchitecturePackages.REST_RESOURCE_PACKAGES;
import static org.apache.fineract.architecture.ArchitecturePackages.SAVINGS_DOMAIN;
import static org.apache.fineract.architecture.ArchitecturePackages.WORKING_CAPITAL_DOMAIN;

import com.tngtech.archunit.base.DescribedPredicate;
import com.tngtech.archunit.core.domain.JavaClass;
import com.tngtech.archunit.core.importer.ImportOption;
import com.tngtech.archunit.junit.AnalyzeClasses;
import com.tngtech.archunit.junit.ArchTest;
import com.tngtech.archunit.lang.ArchRule;

/**
 * ArchUnit rules that protect Bounded Context boundaries at the <strong>domain entity</strong> layer.
 *
 * <p>
 * Target (ADR-019 / Context Map): domain packages integrate via IDs, application ports and events — not by importing
 * foreign JPA entities.
 * </p>
 *
 * <p>
 * Legacy violations are <strong>frozen</strong> ({@link com.tngtech.archunit.library.freeze.FreezingArchRule}): existing
 * debt may remain, but <em>new</em> illegal dependencies fail the build. When you remove a violation, re-run tests so
 * the freeze store shrinks ({@code archunit.properties} allows store updates).
 * </p>
 *
 * See {@code docs/arc42/10_domain_context_map.md} and {@code docs/arc42/13_archunit_bounded_context_rules.md}.
 */
@AnalyzeClasses(packages = BASE, importOptions = ImportOption.DoNotIncludeTests.class)
class BoundedContextEntityDependencyRulesTest {

    /** REST resource packages only (not {@code infrastructure.core.api.JsonCommand}). */
    private static final DescribedPredicate<JavaClass> FINERACT_REST_API = resideInAnyPackage(REST_RESOURCE_PACKAGES);

    // -------------------------------------------------------------------------
    // Loan Servicing domain must not own Client / Group / Savings entities
    // -------------------------------------------------------------------------

    @ArchTest
    static final ArchRule loan_account_domain_must_not_depend_on_client_domain = freeze(noClasses().that()
            .resideInAPackage(LOAN_ACCOUNT_DOMAIN).should().dependOnClassesThat().resideInAPackage(CLIENT_DOMAIN)
            .because("Loan BC references clients by ClientId only (Context Map: Client → Loan is U/D via IDs)"));

    @ArchTest
    static final ArchRule loan_account_domain_must_not_depend_on_group_domain = freeze(noClasses().that()
            .resideInAPackage(LOAN_ACCOUNT_DOMAIN).should().dependOnClassesThat().resideInAPackage(GROUP_DOMAIN)
            .because("Loan BC references groups by GroupId only"));

    @ArchTest
    static final ArchRule loan_account_domain_must_not_depend_on_savings_domain = freeze(noClasses().that()
            .resideInAPackage(LOAN_ACCOUNT_DOMAIN).should().dependOnClassesThat().resideInAPackage(SAVINGS_DOMAIN)
            .because("Loan and Savings are separate BCs; transfers are process orchestration, not entity graphs"));

    @ArchTest
    static final ArchRule loan_account_domain_must_not_depend_on_journal_entry_domain = freeze(noClasses().that()
            .resideInAPackage(LOAN_ACCOUNT_DOMAIN).should().dependOnClassesThat().resideInAPackage(JOURNAL_ENTRY_DOMAIN)
            .because("Accounting journals are projections of loan domain events, not part of the Loan aggregate"));

    // -------------------------------------------------------------------------
    // Savings domain
    // -------------------------------------------------------------------------

    @ArchTest
    static final ArchRule savings_domain_must_not_depend_on_loan_account_domain = freeze(noClasses().that()
            .resideInAPackage(SAVINGS_DOMAIN).should().dependOnClassesThat().resideInAPackage(LOAN_ACCOUNT_DOMAIN)
            .because("Savings BC must not import Loan entities"));

    @ArchTest
    static final ArchRule savings_domain_must_not_depend_on_client_domain = freeze(noClasses().that().resideInAPackage(SAVINGS_DOMAIN)
            .should().dependOnClassesThat().resideInAPackage(CLIENT_DOMAIN)
            .because("Savings BC references clients by ClientId only"));

    @ArchTest
    static final ArchRule savings_domain_must_not_depend_on_group_domain = freeze(noClasses().that().resideInAPackage(SAVINGS_DOMAIN)
            .should().dependOnClassesThat().resideInAPackage(GROUP_DOMAIN).because("Savings BC references groups by GroupId only"));

    @ArchTest
    static final ArchRule savings_domain_must_not_depend_on_journal_entry_domain = freeze(noClasses().that()
            .resideInAPackage(SAVINGS_DOMAIN).should().dependOnClassesThat().resideInAPackage(JOURNAL_ENTRY_DOMAIN)
            .because("Accounting journals are projections of savings domain events"));

    // -------------------------------------------------------------------------
    // Accounting domain must not pull portfolio aggregates
    // -------------------------------------------------------------------------

    @ArchTest
    static final ArchRule accounting_domain_must_not_depend_on_loan_account_domain = freeze(noClasses().that()
            .resideInAPackage(ACCOUNTING_DOMAIN).should().dependOnClassesThat().resideInAPackage(LOAN_ACCOUNT_DOMAIN)
            .because("Accounting consumes published loan facts/events, not Loan JPA entities"));

    @ArchTest
    static final ArchRule accounting_domain_must_not_depend_on_savings_domain = freeze(noClasses().that()
            .resideInAPackage(ACCOUNTING_DOMAIN).should().dependOnClassesThat().resideInAPackage(SAVINGS_DOMAIN)
            .because("Accounting consumes published savings facts/events, not SavingsAccount entities"));

    @ArchTest
    static final ArchRule accounting_domain_must_not_depend_on_client_domain = freeze(noClasses().that()
            .resideInAPackage(ACCOUNTING_DOMAIN).should().dependOnClassesThat().resideInAPackage(CLIENT_DOMAIN)
            .because("Accounting must not couple to Client aggregate entities"));

    // -------------------------------------------------------------------------
    // Loan product / origination / WC domain
    // -------------------------------------------------------------------------

    @ArchTest
    static final ArchRule loan_product_domain_must_not_depend_on_client_domain = freeze(noClasses().that()
            .resideInAPackage(LOAN_PRODUCT_DOMAIN).should().dependOnClassesThat().resideInAPackage(CLIENT_DOMAIN)
            .because("Product catalog is configuration, not party data"));

    @ArchTest
    static final ArchRule loan_origination_domain_must_not_depend_on_savings_domain = freeze(noClasses().that()
            .resideInAPackage(LOAN_ORIGINATION_DOMAIN).should().dependOnClassesThat().resideInAPackage(SAVINGS_DOMAIN)
            .because("Origination hand-off is to Loan Servicing, not Savings entities"));

    @ArchTest
    static final ArchRule working_capital_domain_must_not_depend_on_client_domain = freeze(noClasses().that()
            .resideInAPackage(WORKING_CAPITAL_DOMAIN).should().dependOnClassesThat().resideInAPackage(CLIENT_DOMAIN)
            .because("WC loan extensions reference party by ID only"));

    // -------------------------------------------------------------------------
    // Hexagon: domain packages must not depend on REST resource packages
    // (excludes infrastructure.core.api / JsonCommand — separate cleanup track)
    // -------------------------------------------------------------------------

    @ArchTest
    static final ArchRule loan_account_domain_must_not_depend_on_rest_api = freeze(noClasses().that()
            .resideInAPackage(LOAN_ACCOUNT_DOMAIN).should().dependOnClassesThat(FINERACT_REST_API)
            .because("Hexagon dependency rule: domain must not depend on REST driving adapters (ADR-017)"));

    @ArchTest
    static final ArchRule savings_domain_must_not_depend_on_rest_api = freeze(noClasses().that().resideInAPackage(SAVINGS_DOMAIN).should()
            .dependOnClassesThat(FINERACT_REST_API)
            .because("Hexagon dependency rule: domain must not depend on REST driving adapters (ADR-017)"));

    @ArchTest
    static final ArchRule client_domain_must_not_depend_on_rest_api = freeze(noClasses().that().resideInAPackage(CLIENT_DOMAIN).should()
            .dependOnClassesThat(FINERACT_REST_API)
            .because("Hexagon dependency rule: domain must not depend on REST driving adapters (ADR-017)"));

    @ArchTest
    static final ArchRule accounting_domain_must_not_depend_on_rest_api = freeze(noClasses().that().resideInAPackage(ACCOUNTING_DOMAIN)
            .should().dependOnClassesThat(FINERACT_REST_API)
            .because("Hexagon dependency rule: domain must not depend on REST driving adapters (ADR-017)"));
}
