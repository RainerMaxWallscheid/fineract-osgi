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
package org.apache.fineract.portfolio.loanaccount.data;

import java.util.Map;

public class LoanDelinquencyData {
    private CollectionData loanCollectionData;
    private Map<Long, CollectionData> loanInstallmentsCollectionData;

    @java.lang.SuppressWarnings("all")
        public LoanDelinquencyData(final CollectionData loanCollectionData, final Map<Long, CollectionData> loanInstallmentsCollectionData) {
        this.loanCollectionData = loanCollectionData;
        this.loanInstallmentsCollectionData = loanInstallmentsCollectionData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "LoanDelinquencyData(loanCollectionData=" + this.getLoanCollectionData() + ", loanInstallmentsCollectionData=" + this.getLoanInstallmentsCollectionData() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public CollectionData getLoanCollectionData() {
        return this.loanCollectionData;
    }

    @java.lang.SuppressWarnings("all")
        public Map<Long, CollectionData> getLoanInstallmentsCollectionData() {
        return this.loanInstallmentsCollectionData;
    }

    @java.lang.SuppressWarnings("all")
        public void setLoanCollectionData(final CollectionData loanCollectionData) {
        this.loanCollectionData = loanCollectionData;
    }

    @java.lang.SuppressWarnings("all")
        public void setLoanInstallmentsCollectionData(final Map<Long, CollectionData> loanInstallmentsCollectionData) {
        this.loanInstallmentsCollectionData = loanInstallmentsCollectionData;
    }
}
