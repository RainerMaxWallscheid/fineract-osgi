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
package org.apache.fineract.integrationtests.common.externalevents;

import jakarta.validation.constraints.NotNull;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Objects;
import org.apache.fineract.infrastructure.event.external.data.ExternalEventResponse;

public class BusinessEvent {
    protected String type;
    protected String businessDate;

    public boolean verify(@NotNull ExternalEventResponse externalEvent, DateTimeFormatter formatter) {
        var businessDate = LocalDate.parse(getBusinessDate(), formatter);
        return Objects.equals(externalEvent.getType(), getType()) && Objects.equals(externalEvent.getBusinessDate(), businessDate);
    }

    @java.lang.SuppressWarnings("all")
        public String getType() {
        return this.type;
    }

    @java.lang.SuppressWarnings("all")
        public String getBusinessDate() {
        return this.businessDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setType(final String type) {
        this.type = type;
    }

    @java.lang.SuppressWarnings("all")
        public void setBusinessDate(final String businessDate) {
        this.businessDate = businessDate;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof BusinessEvent)) return false;
        final BusinessEvent other = (BusinessEvent) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$type = this.getType();
        final java.lang.Object other$type = other.getType();
        if (this$type == null ? other$type != null : !this$type.equals(other$type)) return false;
        final java.lang.Object this$businessDate = this.getBusinessDate();
        final java.lang.Object other$businessDate = other.getBusinessDate();
        if (this$businessDate == null ? other$businessDate != null : !this$businessDate.equals(other$businessDate)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof BusinessEvent;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $type = this.getType();
        result = result * PRIME + ($type == null ? 43 : $type.hashCode());
        final java.lang.Object $businessDate = this.getBusinessDate();
        result = result * PRIME + ($businessDate == null ? 43 : $businessDate.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "BusinessEvent(type=" + this.getType() + ", businessDate=" + this.getBusinessDate() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public BusinessEvent(final String type, final String businessDate) {
        this.type = type;
        this.businessDate = businessDate;
    }

    @java.lang.SuppressWarnings("all")
        public BusinessEvent() {
    }
}
