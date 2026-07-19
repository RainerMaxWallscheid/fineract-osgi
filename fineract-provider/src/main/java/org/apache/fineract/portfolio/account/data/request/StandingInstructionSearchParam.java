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
package org.apache.fineract.portfolio.account.data.request;

import jakarta.ws.rs.QueryParam;
import java.io.Serial;
import java.io.Serializable;

public class StandingInstructionSearchParam extends AccountTransSearchParam implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    @QueryParam("transferType")
    private Integer transferType;

    @java.lang.SuppressWarnings("all")
        public Integer getTransferType() {
        return this.transferType;
    }

    @java.lang.SuppressWarnings("all")
        public StandingInstructionSearchParam() {
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof StandingInstructionSearchParam)) return false;
        final StandingInstructionSearchParam other = (StandingInstructionSearchParam) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        if (!super.equals(o)) return false;
        final java.lang.Object this$transferType = this.getTransferType();
        final java.lang.Object other$transferType = other.getTransferType();
        if (this$transferType == null ? other$transferType != null : !this$transferType.equals(other$transferType)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof StandingInstructionSearchParam;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = super.hashCode();
        final java.lang.Object $transferType = this.getTransferType();
        result = result * PRIME + ($transferType == null ? 43 : $transferType.hashCode());
        return result;
    }

    @java.lang.SuppressWarnings("all")
        public StandingInstructionSearchParam(final Integer transferType) {
        this.transferType = transferType;
    }
}
