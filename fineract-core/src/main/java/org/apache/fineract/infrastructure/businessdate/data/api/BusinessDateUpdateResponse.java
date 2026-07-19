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
package org.apache.fineract.infrastructure.businessdate.data.api;

import java.io.Serial;
import java.io.Serializable;
import java.time.LocalDate;
import java.util.Map;
import org.apache.fineract.infrastructure.businessdate.domain.BusinessDateType;
import org.apache.fineract.infrastructure.core.jersey.serializer.legacy.JsonLocalDateArrayFormat;

@JsonLocalDateArrayFormat
public class BusinessDateUpdateResponse implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private String description;
    private BusinessDateType type;
    private LocalDate date;
    private Map<BusinessDateType, LocalDate> changes;


    @java.lang.SuppressWarnings("all")
        public static class BusinessDateUpdateResponseBuilder {
        @java.lang.SuppressWarnings("all")
                private String description;
        @java.lang.SuppressWarnings("all")
                private BusinessDateType type;
        @java.lang.SuppressWarnings("all")
                private LocalDate date;
        @java.lang.SuppressWarnings("all")
                private Map<BusinessDateType, LocalDate> changes;

        @java.lang.SuppressWarnings("all")
                BusinessDateUpdateResponseBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public BusinessDateUpdateResponse.BusinessDateUpdateResponseBuilder description(final String description) {
            this.description = description;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public BusinessDateUpdateResponse.BusinessDateUpdateResponseBuilder type(final BusinessDateType type) {
            this.type = type;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public BusinessDateUpdateResponse.BusinessDateUpdateResponseBuilder date(final LocalDate date) {
            this.date = date;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public BusinessDateUpdateResponse.BusinessDateUpdateResponseBuilder changes(final Map<BusinessDateType, LocalDate> changes) {
            this.changes = changes;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public BusinessDateUpdateResponse build() {
            return new BusinessDateUpdateResponse(this.description, this.type, this.date, this.changes);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "BusinessDateUpdateResponse.BusinessDateUpdateResponseBuilder(description=" + this.description + ", type=" + this.type + ", date=" + this.date + ", changes=" + this.changes + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static BusinessDateUpdateResponse.BusinessDateUpdateResponseBuilder builder() {
        return new BusinessDateUpdateResponse.BusinessDateUpdateResponseBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public String getDescription() {
        return this.description;
    }

    @java.lang.SuppressWarnings("all")
        public BusinessDateType getType() {
        return this.type;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getDate() {
        return this.date;
    }

    @java.lang.SuppressWarnings("all")
        public Map<BusinessDateType, LocalDate> getChanges() {
        return this.changes;
    }

    @java.lang.SuppressWarnings("all")
        public void setDescription(final String description) {
        this.description = description;
    }

    @java.lang.SuppressWarnings("all")
        public void setType(final BusinessDateType type) {
        this.type = type;
    }

    @java.lang.SuppressWarnings("all")
        public void setDate(final LocalDate date) {
        this.date = date;
    }

    @java.lang.SuppressWarnings("all")
        public void setChanges(final Map<BusinessDateType, LocalDate> changes) {
        this.changes = changes;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof BusinessDateUpdateResponse)) return false;
        final BusinessDateUpdateResponse other = (BusinessDateUpdateResponse) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$description = this.getDescription();
        final java.lang.Object other$description = other.getDescription();
        if (this$description == null ? other$description != null : !this$description.equals(other$description)) return false;
        final java.lang.Object this$type = this.getType();
        final java.lang.Object other$type = other.getType();
        if (this$type == null ? other$type != null : !this$type.equals(other$type)) return false;
        final java.lang.Object this$date = this.getDate();
        final java.lang.Object other$date = other.getDate();
        if (this$date == null ? other$date != null : !this$date.equals(other$date)) return false;
        final java.lang.Object this$changes = this.getChanges();
        final java.lang.Object other$changes = other.getChanges();
        if (this$changes == null ? other$changes != null : !this$changes.equals(other$changes)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof BusinessDateUpdateResponse;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $description = this.getDescription();
        result = result * PRIME + ($description == null ? 43 : $description.hashCode());
        final java.lang.Object $type = this.getType();
        result = result * PRIME + ($type == null ? 43 : $type.hashCode());
        final java.lang.Object $date = this.getDate();
        result = result * PRIME + ($date == null ? 43 : $date.hashCode());
        final java.lang.Object $changes = this.getChanges();
        result = result * PRIME + ($changes == null ? 43 : $changes.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "BusinessDateUpdateResponse(description=" + this.getDescription() + ", type=" + this.getType() + ", date=" + this.getDate() + ", changes=" + this.getChanges() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public BusinessDateUpdateResponse() {
    }

    @java.lang.SuppressWarnings("all")
        public BusinessDateUpdateResponse(final String description, final BusinessDateType type, final LocalDate date, final Map<BusinessDateType, LocalDate> changes) {
        this.description = description;
        this.type = type;
        this.date = date;
        this.changes = changes;
    }
}
