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

import com.tngtech.archunit.base.DescribedPredicate;
import com.tngtech.archunit.core.domain.JavaClass;

/**
 * Package constants for ArchUnit rules aligned with the Domain Context Map
 * ({@code docs/arc42/10_domain_context_map.md}).
 */
public final class ArchitecturePackages {

    public static final String BASE = "org.apache.fineract";

    // --- Domain packages (entity / aggregate roots) ---
    public static final String LOAN_ACCOUNT_DOMAIN = "..portfolio.loanaccount.domain..";
    public static final String LOAN_PRODUCT_DOMAIN = "..portfolio.loanproduct.domain..";
    public static final String SAVINGS_DOMAIN = "..portfolio.savings.domain..";
    public static final String CLIENT_DOMAIN = "..portfolio.client.domain..";
    public static final String GROUP_DOMAIN = "..portfolio.group.domain..";
    public static final String CHARGE_DOMAIN = "..portfolio.charge.domain..";
    public static final String TAX_DOMAIN = "..portfolio.tax.domain..";
    public static final String ACCOUNTING_DOMAIN = "..accounting..domain..";
    public static final String JOURNAL_ENTRY_DOMAIN = "..accounting.journalentry.domain..";
    public static final String WORKING_CAPITAL_DOMAIN = "..portfolio.workingcapitalloan.domain..";
    public static final String LOAN_ORIGINATION_DOMAIN = "..portfolio.loanorigination.domain..";

    /**
     * Public inter-module surface (ADR-021). Not the same as REST {@code ..api..} packages.
     */
    public static final String MODULE_API = "..moduleapi..";

    // --- Logical module ownership (package slices ≈ Gradle domain modules) ---

    /** Packages that belong to the Loan Servicing / Loan Product slice. */
    public static final String[] LOAN_OWNED = { //
            "..portfolio.loanaccount..", //
            "..portfolio.loanproduct..", //
            "..portfolio.delinquency..", //
            "..portfolio.interestpauses..", //
            "..portfolio.collateral..", //
            "..portfolio.collateralmanagement..", //
            "..portfolio.loanorigination..", //
            "..portfolio.workingcapitalloan..", //
            "..portfolio.workingcapitalloanproduct..", //
            "..portfolio.workingcapitalloanbreach..", //
            "..portfolio.workingcapitalloannearbreach..", //
    };

    public static final String[] SAVINGS_OWNED = { //
            "..portfolio.savings..", //
            "..portfolio.interestratechart..", //
    };

    public static final String[] ACCOUNTING_OWNED = { //
            "..accounting..", //
    };

    public static final String[] CHARGE_OWNED = { //
            "..portfolio.charge..", //
    };

    public static final String[] INVESTOR_OWNED = { //
            "..investor..", //
    };

    // --- Module-internal packages (must not be depended on by foreign slices) ---
    // Intentionally excludes: moduleapi, data (DTO transition), exception, business events.

    public static final String[] LOAN_INTERNAL = { //
            "..portfolio.loanaccount.domain..", //
            "..portfolio.loanaccount.service..", //
            "..portfolio.loanaccount.handler..", //
            "..portfolio.loanproduct.domain..", //
            "..portfolio.loanproduct.service..", //
            "..portfolio.loanproduct.handler..", //
            "..portfolio.delinquency.domain..", //
            "..portfolio.delinquency.service..", //
            "..portfolio.delinquency.handler..", //
            "..portfolio.loanorigination.domain..", //
            "..portfolio.loanorigination.service..", //
            "..portfolio.loanorigination.handler..", //
            "..portfolio.workingcapitalloan.domain..", //
            "..portfolio.workingcapitalloan.service..", //
            "..portfolio.workingcapitalloan.handler..", //
    };

    public static final String[] SAVINGS_INTERNAL = { //
            "..portfolio.savings.domain..", //
            "..portfolio.savings.service..", //
            "..portfolio.savings.handler..", //
            "..portfolio.interestratechart.domain..", //
            "..portfolio.interestratechart.service..", //
    };

    public static final String[] ACCOUNTING_INTERNAL = { //
            "..accounting..domain..", //
            "..accounting..service..", //
            "..accounting..handler..", //
            "..accounting..serialization..", //
    };

    /**
     * Charge packages that are internal to the catalog BC. Public catalog types live under
     * {@code ..portfolio.charge.moduleapi..} (charge-api / core shared-kernel) and are <em>not</em>
     * listed here.
     */
    public static final String[] CHARGE_INTERNAL_PACKAGES = { //
            "..portfolio.charge.domain..", // JPA Charge entity + repositories (impl)
            "..portfolio.charge.service..", // write/impl services (impl); not ChargeReadPlatformService
            "..portfolio.charge.handler..", //
            "..portfolio.charge.serialization..", //
    };

    /**
     * @deprecated use {@link #CHARGE_INTERNAL_PACKAGES} or {@link #IS_CHARGE_INTERNAL}
     */
    @Deprecated
    public static final String[] CHARGE_INTERNAL = CHARGE_INTERNAL_PACKAGES;

    /**
     * True charge internals for ADR-021: JPA entity, repositories, write/impl services, handlers,
     * serialization. Pure catalog enums / read contract are under {@code moduleapi}.
     */
    public static final DescribedPredicate<JavaClass> IS_CHARGE_INTERNAL = resideInAnyPackage(CHARGE_INTERNAL_PACKAGES)
            .as("charge internals (entity/repos/write services/handlers under domain/service/handler/serialization)");

    public static final String[] CLIENT_INTERNAL = { //
            "..portfolio.client.domain..", //
            "..portfolio.client.service..", //
            "..portfolio.client.handler..", //
    };

    public static final String[] TAX_INTERNAL = { //
            "..portfolio.tax.domain..", //
            "..portfolio.tax.service..", //
            "..portfolio.tax.handler..", //
    };

    /**
     * REST/JAX-RS resource packages (module {@code ..api..} under functional areas).
     * Intentionally <strong>excludes</strong> {@code infrastructure.core.api} ({@code JsonCommand}) —
     * that is application infrastructure, tracked separately if needed.
     * Do not use bare {@code ..api..} (matches {@code jakarta.ws.rs.api}).
     * <p>
     * Distinct from {@link #MODULE_API} (inter-module ports).
     */
    public static final String[] REST_RESOURCE_PACKAGES = { //
            "..portfolio..api..", //
            "..accounting..api..", //
            "..organisation..api..", //
            "..useradministration..api..", //
            "..spm..api..", //
            "..mix..api..", //
            "..notification..api..", //
            "..interoperation..api..", //
            "..investor..api..", //
            "..infrastructure.jobs.api..", //
            "..infrastructure.campaigns..api..", //
            "..infrastructure.hooks.api..", //
            "..infrastructure.report.api..", //
            "..infrastructure.configuration.api..", //
            "..infrastructure.documentmanagement.api..", //
            "..infrastructure.codes.api..", //
            "..infrastructure.surveys.api..", //
            "..infrastructure.bulkimport.api..", //
            "..infrastructure.dataqueries.api..", //
            "..infrastructure.accountnumberformat.api..", //
            "..infrastructure.creditbureau.api..", //
    };

    private ArchitecturePackages() {}
}
