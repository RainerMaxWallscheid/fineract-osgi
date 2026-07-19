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
package org.apache.fineract.investor.domain;

public class ExternalAssetOwnerLoanProductAttribute implements AttributeKey {
    public static final ExternalAssetOwnerLoanProductAttribute TOTAL_OUTSTANDING_INTEREST_STRATEGY = new ExternalAssetOwnerLoanProductAttribute("OUTSTANDING_INTEREST_STRATEGY", "TOTAL_OUTSTANDING", "During external owner transfer the total (due + not yet due + projected) interest participate");
    public static final ExternalAssetOwnerLoanProductAttribute PAYABLE_OUTSTANDING_INTEREST_STRATEGY = new ExternalAssetOwnerLoanProductAttribute("OUTSTANDING_INTEREST_STRATEGY", "PAYABLE_OUTSTANDING", "During external owner transfer the total (due + not yet due) interest participate");
    private final String key;
    private final String value;
    private final String description;

    @java.lang.SuppressWarnings("all")
        public ExternalAssetOwnerLoanProductAttribute(final String key, final String value, final String description) {
        this.key = key;
        this.value = value;
        this.description = description;
    }

    @java.lang.SuppressWarnings("all")
        public String getKey() {
        return this.key;
    }

    @java.lang.SuppressWarnings("all")
        public String getValue() {
        return this.value;
    }

    @java.lang.SuppressWarnings("all")
        public String getDescription() {
        return this.description;
    }
}
