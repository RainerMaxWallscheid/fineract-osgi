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
package org.apache.fineract.accounting.producttoaccountmapping.data;

import java.io.Serializable;
import org.apache.fineract.accounting.glaccount.data.GLAccountData;
import org.apache.fineract.portfolio.charge.data.ChargeData;

public class ChargeToGLAccountMapper implements Serializable {
    private static final long serialVersionUID = 1L;
    private ChargeData charge;
    private GLAccountData incomeAccount;

    @java.lang.SuppressWarnings("all")
        public ChargeToGLAccountMapper() {
    }

    @java.lang.SuppressWarnings("all")
        public ChargeData getCharge() {
        return this.charge;
    }

    @java.lang.SuppressWarnings("all")
        public GLAccountData getIncomeAccount() {
        return this.incomeAccount;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ChargeToGLAccountMapper setCharge(final ChargeData charge) {
        this.charge = charge;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ChargeToGLAccountMapper setIncomeAccount(final GLAccountData incomeAccount) {
        this.incomeAccount = incomeAccount;
        return this;
    }
}
