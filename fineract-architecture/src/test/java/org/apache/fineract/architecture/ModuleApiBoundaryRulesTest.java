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

import static com.tngtech.archunit.lang.syntax.ArchRuleDefinition.noClasses;
import static com.tngtech.archunit.library.freeze.FreezingArchRule.freeze;
import static org.apache.fineract.architecture.ArchitecturePackages.ACCOUNTING_INTERNAL;
import static org.apache.fineract.architecture.ArchitecturePackages.ACCOUNTING_OWNED;
import static org.apache.fineract.architecture.ArchitecturePackages.BASE;
import static org.apache.fineract.architecture.ArchitecturePackages.CHARGE_INTERNAL;
import static org.apache.fineract.architecture.ArchitecturePackages.CLIENT_INTERNAL;
import static org.apache.fineract.architecture.ArchitecturePackages.INVESTOR_OWNED;
import static org.apache.fineract.architecture.ArchitecturePackages.LOAN_INTERNAL;
import static org.apache.fineract.architecture.ArchitecturePackages.LOAN_OWNED;
import static org.apache.fineract.architecture.ArchitecturePackages.SAVINGS_INTERNAL;
import static org.apache.fineract.architecture.ArchitecturePackages.SAVINGS_OWNED;
import static org.apache.fineract.architecture.ArchitecturePackages.TAX_INTERNAL;

import com.tngtech.archunit.core.importer.ImportOption;
import com.tngtech.archunit.junit.AnalyzeClasses;
import com.tngtech.archunit.junit.ArchTest;
import com.tngtech.archunit.lang.ArchRule;

/**
 * Enforces ADR-021: domain subprojects communicate only via Module API ({@code ..moduleapi..}), events and Shared
 * Kernel — not via foreign domain/service/handler internals.
 *
 * <p>
 * Legacy coupling is frozen; new dependencies on foreign internals fail the build.
 * </p>
 *
 * @see docs/arc42/decisions/ADR-021-modul-kommunikation-nur-ueber-module-api.md
 * @see docs/arc42/14_module_api_boundaries.md
 */
@AnalyzeClasses(packages = BASE, importOptions = ImportOption.DoNotIncludeTests.class)
class ModuleApiBoundaryRulesTest {

    // -------------------------------------------------------------------------
    // Loan slice must not use foreign internals
    // -------------------------------------------------------------------------

    @ArchTest
    static final ArchRule loan_must_not_depend_on_charge_internals = freeze(noClasses().that().resideInAnyPackage(LOAN_OWNED).should()
            .dependOnClassesThat().resideInAnyPackage(CHARGE_INTERNAL)
            .because("Loan may only use Charge Module API / events (ADR-021), not charge.domain or charge.service"));

    @ArchTest
    static final ArchRule loan_must_not_depend_on_savings_internals = freeze(noClasses().that().resideInAnyPackage(LOAN_OWNED).should()
            .dependOnClassesThat().resideInAnyPackage(SAVINGS_INTERNAL)
            .because("Loan and Savings integrate via Module API / process orchestration / events (ADR-021)"));

    @ArchTest
    static final ArchRule loan_must_not_depend_on_accounting_internals = freeze(noClasses().that().resideInAnyPackage(LOAN_OWNED).should()
            .dependOnClassesThat().resideInAnyPackage(ACCOUNTING_INTERNAL)
            .because("Loan publishes facts; Accounting consumes via Module API / projectors (ADR-021)"));

    @ArchTest
    static final ArchRule loan_must_not_depend_on_tax_internals = freeze(noClasses().that().resideInAnyPackage(LOAN_OWNED).should()
            .dependOnClassesThat().resideInAnyPackage(TAX_INTERNAL)
            .because("Tax is a supporting catalog; use Tax Module API (ADR-021)"));

    @ArchTest
    static final ArchRule loan_must_not_depend_on_client_internals = freeze(noClasses().that().resideInAnyPackage(LOAN_OWNED).should()
            .dependOnClassesThat().resideInAnyPackage(CLIENT_INTERNAL)
            .because("Client is upstream Party BC; Loan uses ClientId / Client Module API (ADR-021)"));

    // -------------------------------------------------------------------------
    // Savings slice
    // -------------------------------------------------------------------------

    @ArchTest
    static final ArchRule savings_must_not_depend_on_loan_internals = freeze(noClasses().that().resideInAnyPackage(SAVINGS_OWNED).should()
            .dependOnClassesThat().resideInAnyPackage(LOAN_INTERNAL)
            .because("Savings must not import Loan internals (ADR-021)"));

    @ArchTest
    static final ArchRule savings_must_not_depend_on_charge_internals = freeze(noClasses().that().resideInAnyPackage(SAVINGS_OWNED).should()
            .dependOnClassesThat().resideInAnyPackage(CHARGE_INTERNAL)
            .because("Savings may only use Charge Module API (ADR-021)"));

    @ArchTest
    static final ArchRule savings_must_not_depend_on_accounting_internals = freeze(noClasses().that().resideInAnyPackage(SAVINGS_OWNED)
            .should().dependOnClassesThat().resideInAnyPackage(ACCOUNTING_INTERNAL)
            .because("Savings → Accounting only via Module API / events (ADR-021)"));

    @ArchTest
    static final ArchRule savings_must_not_depend_on_client_internals = freeze(noClasses().that().resideInAnyPackage(SAVINGS_OWNED).should()
            .dependOnClassesThat().resideInAnyPackage(CLIENT_INTERNAL)
            .because("Savings uses ClientId / Client Module API (ADR-021)"));

    // -------------------------------------------------------------------------
    // Accounting slice
    // -------------------------------------------------------------------------

    @ArchTest
    static final ArchRule accounting_must_not_depend_on_loan_internals = freeze(noClasses().that().resideInAnyPackage(ACCOUNTING_OWNED)
            .should().dependOnClassesThat().resideInAnyPackage(LOAN_INTERNAL)
            .because("Accounting must not depend on Loan domain/service (ADR-021)"));

    @ArchTest
    static final ArchRule accounting_must_not_depend_on_savings_internals = freeze(noClasses().that().resideInAnyPackage(ACCOUNTING_OWNED)
            .should().dependOnClassesThat().resideInAnyPackage(SAVINGS_INTERNAL)
            .because("Accounting must not depend on Savings domain/service (ADR-021)"));

    @ArchTest
    static final ArchRule accounting_must_not_depend_on_client_internals = freeze(noClasses().that().resideInAnyPackage(ACCOUNTING_OWNED)
            .should().dependOnClassesThat().resideInAnyPackage(CLIENT_INTERNAL)
            .because("Accounting must not depend on Client domain (ADR-021)"));

    // -------------------------------------------------------------------------
    // Investor / secondary market
    // -------------------------------------------------------------------------

    @ArchTest
    static final ArchRule investor_must_not_depend_on_loan_internals = freeze(noClasses().that().resideInAnyPackage(INVESTOR_OWNED).should()
            .dependOnClassesThat().resideInAnyPackage(LOAN_INTERNAL)
            .because("Investor uses Loan Module API / ownership events, not Loan entities (ADR-021)"));

    @ArchTest
    static final ArchRule investor_must_not_depend_on_accounting_internals = freeze(noClasses().that().resideInAnyPackage(INVESTOR_OWNED)
            .should().dependOnClassesThat().resideInAnyPackage(ACCOUNTING_INTERNAL)
            .because("Investor accounting goes through Accounting Module API / events (ADR-021)"));
}
