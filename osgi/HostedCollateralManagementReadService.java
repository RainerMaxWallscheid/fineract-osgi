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
import java.util.List;
import org.apache.fineract.portfolio.collateralmanagement.data.CollateralManagementData;
import org.apache.fineract.portfolio.collateralmanagement.service.CollateralManagementReadService;

/** Composition-root hosted collateral-management catalog for the Equinox bridge smoke. */
final class HostedCollateralManagementReadService implements CollateralManagementReadService {

    static final long HOSTED_ID = 1L;

    private final CollateralManagementData hosted = CollateralManagementData.createNew("hosted", BigDecimal.ONE, "hosted", BigDecimal.ONE,
            "USD", "hosted", HOSTED_ID);

    @Override
    public CollateralManagementData getCollateralProduct(final Long collateralId) {
        return Long.valueOf(HOSTED_ID).equals(collateralId) ? hosted : null;
    }

    @Override
    public List<CollateralManagementData> getAllCollateralProducts() {
        return List.of(hosted);
    }
}
