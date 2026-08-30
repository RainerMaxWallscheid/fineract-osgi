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
package org.apache.fineract.portfolio.delinquency.service;

import java.util.Collections;
import java.util.List;
import org.apache.fineract.portfolio.delinquency.data.DelinquencyBucketData;
import org.apache.fineract.portfolio.delinquency.data.DelinquencyMinimumPaymentPeriodAndRuleData;
import org.apache.fineract.portfolio.delinquency.data.DelinquencyRangeData;
import org.apache.fineract.portfolio.delinquency.domain.DelinquencyBucket;
import org.apache.fineract.portfolio.delinquency.domain.DelinquencyBucketRepository;
import org.apache.fineract.portfolio.delinquency.domain.DelinquencyMinimumPaymentPeriodAndRuleRepository;
import org.apache.fineract.portfolio.delinquency.domain.DelinquencyRangeRepository;
import org.apache.fineract.portfolio.delinquency.exception.DelinquencyBucketNotFoundException;
import org.apache.fineract.portfolio.delinquency.exception.DelinquencyRangeNotFoundException;
import org.apache.fineract.portfolio.delinquency.mapper.DelinquencyBucketMapper;
import org.apache.fineract.portfolio.delinquency.mapper.DelinquencyRangeMapper;
import org.apache.fineract.portfolio.loanaccount.moduleapi.DelinquencyCatalogPort;
import org.springframework.stereotype.Service;

@Service
public class DelinquencyCatalogPortAdapter implements DelinquencyCatalogPort {

    private final DelinquencyReadPlatformService delinquencyReadPlatformService;
    private final DelinquencyBucketRepository bucketRepository;
    private final DelinquencyRangeRepository rangeRepository;
    private final DelinquencyMinimumPaymentPeriodAndRuleRepository minimumPaymentPeriodAndRuleRepository;
    private final DelinquencyRangeMapper rangeMapper;
    private final DelinquencyBucketMapper bucketMapper;

    public DelinquencyCatalogPortAdapter(final DelinquencyReadPlatformService delinquencyReadPlatformService,
            final DelinquencyBucketRepository bucketRepository, final DelinquencyRangeRepository rangeRepository,
            final DelinquencyMinimumPaymentPeriodAndRuleRepository minimumPaymentPeriodAndRuleRepository,
            final DelinquencyRangeMapper rangeMapper, final DelinquencyBucketMapper bucketMapper) {
        this.delinquencyReadPlatformService = delinquencyReadPlatformService;
        this.bucketRepository = bucketRepository;
        this.rangeRepository = rangeRepository;
        this.minimumPaymentPeriodAndRuleRepository = minimumPaymentPeriodAndRuleRepository;
        this.rangeMapper = rangeMapper;
        this.bucketMapper = bucketMapper;
    }

    @Override
    public List<DelinquencyBucketData> retrieveAllBuckets() {
        return delinquencyReadPlatformService.retrieveAllDelinquencyBuckets();
    }

    @Override
    public DelinquencyBucketData retrieveBucket(final Long bucketId) {
        if (bucketId == null) {
            return null;
        }
        return delinquencyReadPlatformService.retrieveDelinquencyBucket(bucketId);
    }

    @Override
    public boolean bucketExists(final Long bucketId) {
        return bucketId != null && bucketRepository.existsById(bucketId);
    }

    @Override
    public List<DelinquencyRangeData> rangesOfBucket(final Long bucketId) {
        if (bucketId == null) {
            return Collections.emptyList();
        }
        final DelinquencyBucket bucket = bucketRepository.findById(bucketId)
                .orElseThrow(() -> DelinquencyBucketNotFoundException.notFound(bucketId));
        return rangeMapper.map(bucket.getRanges());
    }

    @Override
    public DelinquencyRangeData retrieveRange(final Long rangeId) {
        if (rangeId == null) {
            return null;
        }
        return rangeMapper.map(rangeRepository.findById(rangeId).orElseThrow(() -> DelinquencyRangeNotFoundException.notFound(rangeId)));
    }

    @Override
    public DelinquencyMinimumPaymentPeriodAndRuleData minimumPaymentRuleOfBucket(final Long bucketId) {
        if (bucketId == null) {
            return null;
        }
        return minimumPaymentPeriodAndRuleRepository.findByBucketId(bucketId).map(bucketMapper::map).orElse(null);
    }
}
