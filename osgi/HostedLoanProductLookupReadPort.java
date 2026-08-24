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

import java.util.Collection;
import java.util.List;
import org.apache.fineract.portfolio.loanproduct.data.LoanProductLookupData;
import org.apache.fineract.portfolio.loanproduct.service.LoanProductLookupReadPort;

/** Composition-root hosted loan-product lookup for the Equinox bridge smoke. */
final class HostedLoanProductLookupReadPort implements LoanProductLookupReadPort {

    static final long HOSTED_ID = 1L;

    @Override
    public Collection<LoanProductLookupData> retrieveAllLoanProductsForLookup() {
        return retrieveAllLoanProductsForLookup(false);
    }

    @Override
    public Collection<LoanProductLookupData> retrieveAllLoanProductsForLookup(final boolean activeOnly) {
        return List.of(LoanProductLookupData.lookup(HOSTED_ID, "hosted", false));
    }

    @Override
    public String nameById(final Long loanProductId) {
        return HOSTED_ID == loanProductId ? "hosted" : null;
    }

    @Override
    public String loanEnumerationValue(final String typeName, final int id) {
        return null;
    }

    @Override
    public Collection<LoanProductLookupData> findAllByNameIgnoreCase(final Collection<String> names) {
        return List.of();
    }
}
