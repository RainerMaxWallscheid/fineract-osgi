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
import org.apache.fineract.infrastructure.businessdate.domain.BusinessDateType;
import org.apache.fineract.infrastructure.core.jersey.serializer.legacy.JsonLocalDateArrayFormat;

@JsonLocalDateArrayFormat
public class BusinessDateResponse implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private String description;
    private BusinessDateType type;
    private LocalDate date;


    @java.lang.SuppressWarnings("all")
        public static class BusinessDateResponseBuilder {
        @java.lang.SuppressWarnings("all")
                private String description;
        @java.lang.SuppressWarnings("all")
                private BusinessDateType type;
        @java.lang.SuppressWarnings("all")
                private LocalDate date;

        @java.lang.SuppressWarnings("all")
                BusinessDateResponseBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public BusinessDateResponse.BusinessDateResponseBuilder description(final String description) {
            this.description = description;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public BusinessDateResponse.BusinessDateResponseBuilder type(final BusinessDateType type) {
            this.type = type;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public BusinessDateResponse.BusinessDateResponseBuilder date(final LocalDate date) {
            this.date = date;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public BusinessDateResponse build() {
            return new BusinessDateResponse(this.description, this.type, this.date);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "BusinessDateResponse.BusinessDateResponseBuilder(description=" + this.description + ", type=" + this.type + ", date=" + this.date + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static BusinessDateResponse.BusinessDateResponseBuilder builder() {
        return new BusinessDateResponse.BusinessDateResponseBuilder();
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

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof BusinessDateResponse)) return false;
        final BusinessDateResponse other = (BusinessDateResponse) o;
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
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof BusinessDateResponse;
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
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "BusinessDateResponse(description=" + this.getDescription() + ", type=" + this.getType() + ", date=" + this.getDate() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public BusinessDateResponse() {
    }

    @java.lang.SuppressWarnings("all")
        public BusinessDateResponse(final String description, final BusinessDateType type, final LocalDate date) {
        this.description = description;
        this.type = type;
        this.date = date;
    }
}
