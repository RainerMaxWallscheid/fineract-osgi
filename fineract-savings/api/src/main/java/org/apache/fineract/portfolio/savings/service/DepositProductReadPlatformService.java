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
package org.apache.fineract.portfolio.savings.service;

import java.util.Collection;
import org.apache.fineract.portfolio.savings.DepositAccountType;
import org.apache.fineract.portfolio.savings.data.DepositProductData;

public interface DepositProductReadPlatformService {

    /**
     * Full product rows for the given deposit type. Concrete element type is
     * {@link org.apache.fineract.portfolio.savings.data.FixedDepositProductData} or
     * {@link org.apache.fineract.portfolio.savings.data.RecurringDepositProductData}.
     */
    Collection<?> retrieveAll(DepositAccountType depositAccountType);

    Collection<DepositProductData> retrieveAllForLookup(DepositAccountType depositAccountType);

    /**
     * Full product for the given deposit type. Concrete type is Fixed or Recurring product data.
     */
    Object retrieveOne(DepositAccountType depositAccountType, Long productId);

    /**
     * Full product including interest charts. Concrete type is Fixed or Recurring product data.
     */
    Object retrieveOneWithChartSlabs(DepositAccountType depositAccountType, Long productId);

}
