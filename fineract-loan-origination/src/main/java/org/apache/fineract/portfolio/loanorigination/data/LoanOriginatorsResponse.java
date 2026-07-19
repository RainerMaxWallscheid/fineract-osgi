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
package org.apache.fineract.portfolio.loanorigination.data;

import java.io.Serial;
import java.io.Serializable;
import java.util.List;

public class LoanOriginatorsResponse implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private List<LoanOriginatorData> originators;

    public static LoanOriginatorsResponse of(List<LoanOriginatorData> originators) {
        return new LoanOriginatorsResponse(originators);
    }

    @java.lang.SuppressWarnings("all")
        public List<LoanOriginatorData> getOriginators() {
        return this.originators;
    }

    @java.lang.SuppressWarnings("all")
        public void setOriginators(final List<LoanOriginatorData> originators) {
        this.originators = originators;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof LoanOriginatorsResponse)) return false;
        final LoanOriginatorsResponse other = (LoanOriginatorsResponse) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$originators = this.getOriginators();
        final java.lang.Object other$originators = other.getOriginators();
        if (this$originators == null ? other$originators != null : !this$originators.equals(other$originators)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof LoanOriginatorsResponse;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $originators = this.getOriginators();
        result = result * PRIME + ($originators == null ? 43 : $originators.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "LoanOriginatorsResponse(originators=" + this.getOriginators() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public LoanOriginatorsResponse() {
    }

    @java.lang.SuppressWarnings("all")
        public LoanOriginatorsResponse(final List<LoanOriginatorData> originators) {
        this.originators = originators;
    }
}
