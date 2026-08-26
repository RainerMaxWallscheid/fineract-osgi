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
package org.apache.fineract.portfolio.loanaccount.service;

import java.util.function.Consumer;
import org.apache.fineract.infrastructure.event.business.domain.loan.LoanAccountSnapshotBusinessEvent;
import org.apache.fineract.infrastructure.event.business.domain.loan.LoanStatusChangedBusinessEvent;
import org.apache.fineract.infrastructure.event.business.service.BusinessEventNotifierService;
import org.apache.fineract.portfolio.loanaccount.domain.Loan;
import org.apache.fineract.portfolio.loanaccount.moduleapi.LoanAccountSnapshotEventPort;
import org.springframework.stereotype.Service;

@Service
public class LoanAccountSnapshotEventPortAdapter implements LoanAccountSnapshotEventPort {

    private final BusinessEventNotifierService businessEventNotifierService;

    public LoanAccountSnapshotEventPortAdapter(final BusinessEventNotifierService businessEventNotifierService) {
        this.businessEventNotifierService = businessEventNotifierService;
    }

    @Override
    public void notifySnapshot(final Object loan) {
        businessEventNotifierService.notifyPostBusinessEvent(new LoanAccountSnapshotBusinessEvent((Loan) loan));
    }

    @Override
    public void onClosedOrOverpaid(final Consumer<Object> handler) {
        businessEventNotifierService.addPostBusinessEventListener(LoanStatusChangedBusinessEvent.class, event -> {
            if (event.wasActive() && event.isNowClosedOrOverpaid()) {
                handler.accept(event.get());
            }
        });
    }
}
