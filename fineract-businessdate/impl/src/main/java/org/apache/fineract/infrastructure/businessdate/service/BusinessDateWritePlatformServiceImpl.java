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
package org.apache.fineract.infrastructure.businessdate.service;

import jakarta.persistence.EntityManager;
import jakarta.persistence.OptimisticLockException;
import jakarta.persistence.PersistenceContext;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import org.apache.fineract.infrastructure.businessdate.data.service.BusinessDateDTO;
import org.apache.fineract.infrastructure.businessdate.domain.BusinessDate;
import org.apache.fineract.infrastructure.businessdate.domain.BusinessDateRepository;
import org.apache.fineract.infrastructure.businessdate.domain.BusinessDateType;
import org.apache.fineract.infrastructure.businessdate.exception.BusinessDateActionException;
import org.apache.fineract.infrastructure.configuration.domain.ConfigurationDomainService;
import org.apache.fineract.infrastructure.core.data.ApiParameterError;
import org.apache.fineract.infrastructure.core.exception.AbstractPlatformDomainRuleException;
import org.apache.fineract.infrastructure.core.exception.PlatformApiDataValidationException;
import org.apache.fineract.infrastructure.core.service.DateUtils;
import org.apache.fineract.infrastructure.jobs.exception.JobExecutionException;
import org.springframework.dao.OptimisticLockingFailureException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.support.TransactionTemplate;

@Service
public class BusinessDateWritePlatformServiceImpl implements BusinessDateWritePlatformService {
    @java.lang.SuppressWarnings("all")
        private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(BusinessDateWritePlatformServiceImpl.class);

    /**
     * Serializes BUSINESS_DATE / COB_DATE writes in a single JVM. Scheduler jobs (increase business date / COB date)
     * run in parallel and would otherwise race on {@code m_business_date} {@code @Version}.
     */
    private final Object businessDateWriteLock = new Object();

    private static final int OPTIMISTIC_LOCK_MAX_ATTEMPTS = 5;

    private final BusinessDateRepository repository;
    private final ConfigurationDomainService configurationDomainService;
    private final TransactionTemplate transactionTemplate;

    @PersistenceContext
    private EntityManager entityManager;

    public BusinessDateWritePlatformServiceImpl(final BusinessDateRepository repository,
            final ConfigurationDomainService configurationDomainService, final PlatformTransactionManager transactionManager) {
        this.repository = repository;
        this.configurationDomainService = configurationDomainService;
        this.transactionTemplate = new TransactionTemplate(transactionManager);
        // Independent short TX so batch job TX is not marked rollback-only on lock retry,
        // and so commit completes while still holding businessDateWriteLock.
        this.transactionTemplate.setPropagationBehavior(TransactionTemplate.PROPAGATION_REQUIRES_NEW);
    }

    @Override
    public BusinessDateDTO updateBusinessDate(BusinessDateDTO businessDateDto) {
        synchronized (businessDateWriteLock) {
            return transactionTemplate.execute(status -> {
                adjustDate(businessDateDto);
                return businessDateDto;
            });
        }
    }

    @Override
    public void increaseDateByTypeByOneDay(BusinessDateType businessDateType) throws JobExecutionException {
        List<Throwable> exceptions = new ArrayList<>();
        try {
            synchronized (businessDateWriteLock) {
                transactionTemplate.executeWithoutResult(status -> {
                    Optional<BusinessDate> businessDateEntity = repository.findByType(businessDateType);
                    LocalDate businessDate = businessDateEntity.map(BusinessDate::getDate).orElse(DateUtils.getLocalDateOfTenant());
                    businessDate = businessDate.plusDays(1);
                    BusinessDateDTO response = BusinessDateDTO.builder().type(businessDateType)
                            .description(businessDateType.getDescription()).date(businessDate).build();
                    adjustDate(response);
                });
            }
        } catch (final PlatformApiDataValidationException e) {
            final List<ApiParameterError> errors = e.getErrors();
            for (final ApiParameterError error : errors) {
                log.error("Increasing {} by 1 day failed due to: {}", businessDateType.getDescription(), error.getDeveloperMessage());
            }
            exceptions.add(e);
        } catch (final AbstractPlatformDomainRuleException e) {
            log.error("Increasing {} by 1 day failed due to: {}", businessDateType.getDescription(), e.getDefaultUserMessage());
            exceptions.add(e);
        } catch (Exception e) {
            log.error("Increasing {} by 1 day failed due to: {}", businessDateType.getDescription(), e.getMessage());
            exceptions.add(e);
        }
        if (!exceptions.isEmpty()) {
            throw new JobExecutionException(exceptions);
        }
    }

    private void adjustDate(BusinessDateDTO businessDateDto) {
        boolean isCOBDateAdjustmentEnabled = configurationDomainService.isCOBDateAdjustmentEnabled();
        boolean isBusinessDateEnabled = configurationDomainService.isBusinessDateEnabled();
        if (!isBusinessDateEnabled) {
            log.error("Business date functionality is not enabled!");
            throw new BusinessDateActionException("business.date.is.not.enabled", "Business date functionality is not enabled");
        }
        updateOrCreateBusinessDate(businessDateDto);
        if (isCOBDateAdjustmentEnabled && BusinessDateType.BUSINESS_DATE.equals(businessDateDto.getType())) {
            BusinessDateDTO res = BusinessDateDTO.builder().type(BusinessDateType.COB_DATE)
                    .description(BusinessDateType.COB_DATE.getDescription()).date(businessDateDto.getDate().minusDays(1)).build();
            updateOrCreateBusinessDate(res);
            businessDateDto.addAllChanges(res.getChanges());
        }
    }

    private void updateOrCreateBusinessDate(BusinessDateDTO businessDateDto) {
        for (int attempt = 1; attempt <= OPTIMISTIC_LOCK_MAX_ATTEMPTS; attempt++) {
            try {
                doUpdateOrCreateBusinessDate(businessDateDto);
                return;
            } catch (OptimisticLockingFailureException | OptimisticLockException ex) {
                if (attempt == OPTIMISTIC_LOCK_MAX_ATTEMPTS) {
                    throw ex;
                }
                log.warn("Optimistic lock updating BusinessDate type={} (attempt {}/{}): {}", businessDateDto.getType(), attempt,
                        OPTIMISTIC_LOCK_MAX_ATTEMPTS, ex.toString());
                clearPersistenceContext();
            }
        }
    }

    private void doUpdateOrCreateBusinessDate(BusinessDateDTO businessDateDto) {
        BusinessDateType businessDateType = businessDateDto.getType();
        Optional<BusinessDate> businessDate = repository.findByType(businessDateType);
        if (businessDate.isEmpty()) {
            BusinessDate newBusinessDate = BusinessDate.instance(businessDateType, businessDateDto.getDate());
            repository.saveAndFlush(newBusinessDate);
            businessDateDto.addChange(businessDateType, newBusinessDate.getDate());
        } else {
            updateBusinessDate(businessDate.get(), businessDateDto);
        }
    }

    private void updateBusinessDate(BusinessDate businessDate, BusinessDateDTO businessDateDto) {
        if (DateUtils.isEqual(businessDate.getDate(), businessDateDto.getDate())) {
            return;
        }
        businessDate.setDate(businessDateDto.getDate());
        repository.saveAndFlush(businessDate);
        businessDateDto.addChange(businessDate.getType(), businessDateDto.getDate());
    }

    private void clearPersistenceContext() {
        if (entityManager != null) {
            try {
                entityManager.clear();
            } catch (RuntimeException ex) {
                log.debug("Could not clear EntityManager after optimistic lock: {}", ex.toString());
            }
        }
    }
}
