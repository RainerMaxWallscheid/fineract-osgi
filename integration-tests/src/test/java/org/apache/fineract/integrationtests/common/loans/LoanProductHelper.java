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
package org.apache.fineract.integrationtests.common.loans;

import java.util.Collection;
import org.apache.fineract.client.models.GetLoanProductsProductIdResponse;
import org.apache.fineract.client.models.GetLoanProductsTemplateResponse;
import org.apache.fineract.client.models.LoanProductBasicDetailsData;
import org.apache.fineract.client.models.PostLoanProductsRequest;
import org.apache.fineract.client.models.PostLoanProductsResponse;
import org.apache.fineract.client.models.PutLoanProductsProductIdRequest;
import org.apache.fineract.client.models.PutLoanProductsProductIdResponse;
import org.apache.fineract.client.util.CallFailedRuntimeException;
import org.apache.fineract.client.util.Calls;
import org.apache.fineract.integrationtests.common.FineractClientHelper;
import org.apache.fineract.integrationtests.common.Utils;

public class LoanProductHelper {

    public LoanProductHelper() {}

    /**
     * Create a loan product, retrying with a fresh short name on duplicate-short-name
     * collisions. Integration tests share a DB and short names are only 4 characters,
     * so process-local uniqueness alone is not enough against leftover products.
     */
    public PostLoanProductsResponse createLoanProduct(PostLoanProductsRequest request) {
        final int maxAttempts = 5;
        CallFailedRuntimeException lastFailure = null;
        for (int attempt = 0; attempt < maxAttempts; attempt++) {
            try {
                return Calls.ok(FineractClientHelper.getFineractClient().loanProducts.createLoanProduct(request));
            } catch (final CallFailedRuntimeException ex) {
                lastFailure = ex;
                if (!isDuplicateLoanProductShortName(ex) || attempt == maxAttempts - 1) {
                    throw ex;
                }
                request.shortName(Utils.uniqueRandomStringGenerator("", 4));
                if (request.getName() != null) {
                    request.name(Utils.uniqueRandomStringGenerator("LP_", 8));
                }
            }
        }
        throw lastFailure;
    }

    private static boolean isDuplicateLoanProductShortName(final CallFailedRuntimeException ex) {
        final String message = ex.getMessage();
        return message != null && message.contains("error.msg.product.loan.duplicate.short.name");
    }

    public GetLoanProductsProductIdResponse retrieveLoanProductByExternalId(String externalId) {
        return Calls.ok(FineractClientHelper.getFineractClient().loanProducts.retrieveLoanProductDetailsByExternalId(externalId));
    }

    public GetLoanProductsProductIdResponse retrieveLoanProductById(Long loanProductId) {
        return Calls.ok(FineractClientHelper.getFineractClient().loanProducts.retrieveOneLoanProduct(loanProductId));
    }

    public PutLoanProductsProductIdResponse updateLoanProductByExternalId(String externalId, PutLoanProductsProductIdRequest request) {
        return Calls.ok(FineractClientHelper.getFineractClient().loanProducts.updateLoanProductByExternalId(externalId, request));
    }

    public PutLoanProductsProductIdResponse updateLoanProductById(Long loanProductId, PutLoanProductsProductIdRequest request) {
        return Calls.ok(FineractClientHelper.getFineractClient().loanProducts.updateLoanProduct(loanProductId, request));
    }

    public GetLoanProductsTemplateResponse getLoanProductTemplate(boolean isProductMixTemplate) {
        return Calls.ok(FineractClientHelper.getFineractClient().loanProducts.retrieveTemplateLoanProduct(isProductMixTemplate));
    }

    public static Collection<LoanProductBasicDetailsData> fetchProductBasicDetailsList() {
        return Calls.ok(FineractClientHelper.getFineractClient().loanProductsDetails.retrieveAllLoanProductsDetails());
    }
}
