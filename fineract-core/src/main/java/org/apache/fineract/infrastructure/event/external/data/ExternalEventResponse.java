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
package org.apache.fineract.infrastructure.event.external.data;

import java.io.Serial;
import java.io.Serializable;
import java.time.LocalDate;
import java.time.OffsetDateTime;
import java.util.Map;

public class ExternalEventResponse implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private Long eventId;
    private String type;
    private String category;
    private OffsetDateTime createdAt;
    private Map<String, Object> payLoad;
    private LocalDate businessDate;
    private String schema;
    private Long aggregateRootId;


    @java.lang.SuppressWarnings("all")
        public static class ExternalEventResponseBuilder {
        @java.lang.SuppressWarnings("all")
                private Long eventId;
        @java.lang.SuppressWarnings("all")
                private String type;
        @java.lang.SuppressWarnings("all")
                private String category;
        @java.lang.SuppressWarnings("all")
                private OffsetDateTime createdAt;
        @java.lang.SuppressWarnings("all")
                private Map<String, Object> payLoad;
        @java.lang.SuppressWarnings("all")
                private LocalDate businessDate;
        @java.lang.SuppressWarnings("all")
                private String schema;
        @java.lang.SuppressWarnings("all")
                private Long aggregateRootId;

        @java.lang.SuppressWarnings("all")
                ExternalEventResponseBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ExternalEventResponse.ExternalEventResponseBuilder eventId(final Long eventId) {
            this.eventId = eventId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ExternalEventResponse.ExternalEventResponseBuilder type(final String type) {
            this.type = type;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ExternalEventResponse.ExternalEventResponseBuilder category(final String category) {
            this.category = category;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ExternalEventResponse.ExternalEventResponseBuilder createdAt(final OffsetDateTime createdAt) {
            this.createdAt = createdAt;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ExternalEventResponse.ExternalEventResponseBuilder payLoad(final Map<String, Object> payLoad) {
            this.payLoad = payLoad;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ExternalEventResponse.ExternalEventResponseBuilder businessDate(final LocalDate businessDate) {
            this.businessDate = businessDate;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ExternalEventResponse.ExternalEventResponseBuilder schema(final String schema) {
            this.schema = schema;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ExternalEventResponse.ExternalEventResponseBuilder aggregateRootId(final Long aggregateRootId) {
            this.aggregateRootId = aggregateRootId;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public ExternalEventResponse build() {
            return new ExternalEventResponse(this.eventId, this.type, this.category, this.createdAt, this.payLoad, this.businessDate, this.schema, this.aggregateRootId);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "ExternalEventResponse.ExternalEventResponseBuilder(eventId=" + this.eventId + ", type=" + this.type + ", category=" + this.category + ", createdAt=" + this.createdAt + ", payLoad=" + this.payLoad + ", businessDate=" + this.businessDate + ", schema=" + this.schema + ", aggregateRootId=" + this.aggregateRootId + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static ExternalEventResponse.ExternalEventResponseBuilder builder() {
        return new ExternalEventResponse.ExternalEventResponseBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public Long getEventId() {
        return this.eventId;
    }

    @java.lang.SuppressWarnings("all")
        public String getType() {
        return this.type;
    }

    @java.lang.SuppressWarnings("all")
        public String getCategory() {
        return this.category;
    }

    @java.lang.SuppressWarnings("all")
        public OffsetDateTime getCreatedAt() {
        return this.createdAt;
    }

    @java.lang.SuppressWarnings("all")
        public Map<String, Object> getPayLoad() {
        return this.payLoad;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getBusinessDate() {
        return this.businessDate;
    }

    @java.lang.SuppressWarnings("all")
        public String getSchema() {
        return this.schema;
    }

    @java.lang.SuppressWarnings("all")
        public Long getAggregateRootId() {
        return this.aggregateRootId;
    }

    @java.lang.SuppressWarnings("all")
        public void setEventId(final Long eventId) {
        this.eventId = eventId;
    }

    @java.lang.SuppressWarnings("all")
        public void setType(final String type) {
        this.type = type;
    }

    @java.lang.SuppressWarnings("all")
        public void setCategory(final String category) {
        this.category = category;
    }

    @java.lang.SuppressWarnings("all")
        public void setCreatedAt(final OffsetDateTime createdAt) {
        this.createdAt = createdAt;
    }

    @java.lang.SuppressWarnings("all")
        public void setPayLoad(final Map<String, Object> payLoad) {
        this.payLoad = payLoad;
    }

    @java.lang.SuppressWarnings("all")
        public void setBusinessDate(final LocalDate businessDate) {
        this.businessDate = businessDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setSchema(final String schema) {
        this.schema = schema;
    }

    @java.lang.SuppressWarnings("all")
        public void setAggregateRootId(final Long aggregateRootId) {
        this.aggregateRootId = aggregateRootId;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof ExternalEventResponse)) return false;
        final ExternalEventResponse other = (ExternalEventResponse) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$eventId = this.getEventId();
        final java.lang.Object other$eventId = other.getEventId();
        if (this$eventId == null ? other$eventId != null : !this$eventId.equals(other$eventId)) return false;
        final java.lang.Object this$aggregateRootId = this.getAggregateRootId();
        final java.lang.Object other$aggregateRootId = other.getAggregateRootId();
        if (this$aggregateRootId == null ? other$aggregateRootId != null : !this$aggregateRootId.equals(other$aggregateRootId)) return false;
        final java.lang.Object this$type = this.getType();
        final java.lang.Object other$type = other.getType();
        if (this$type == null ? other$type != null : !this$type.equals(other$type)) return false;
        final java.lang.Object this$category = this.getCategory();
        final java.lang.Object other$category = other.getCategory();
        if (this$category == null ? other$category != null : !this$category.equals(other$category)) return false;
        final java.lang.Object this$createdAt = this.getCreatedAt();
        final java.lang.Object other$createdAt = other.getCreatedAt();
        if (this$createdAt == null ? other$createdAt != null : !this$createdAt.equals(other$createdAt)) return false;
        final java.lang.Object this$payLoad = this.getPayLoad();
        final java.lang.Object other$payLoad = other.getPayLoad();
        if (this$payLoad == null ? other$payLoad != null : !this$payLoad.equals(other$payLoad)) return false;
        final java.lang.Object this$businessDate = this.getBusinessDate();
        final java.lang.Object other$businessDate = other.getBusinessDate();
        if (this$businessDate == null ? other$businessDate != null : !this$businessDate.equals(other$businessDate)) return false;
        final java.lang.Object this$schema = this.getSchema();
        final java.lang.Object other$schema = other.getSchema();
        if (this$schema == null ? other$schema != null : !this$schema.equals(other$schema)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof ExternalEventResponse;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $eventId = this.getEventId();
        result = result * PRIME + ($eventId == null ? 43 : $eventId.hashCode());
        final java.lang.Object $aggregateRootId = this.getAggregateRootId();
        result = result * PRIME + ($aggregateRootId == null ? 43 : $aggregateRootId.hashCode());
        final java.lang.Object $type = this.getType();
        result = result * PRIME + ($type == null ? 43 : $type.hashCode());
        final java.lang.Object $category = this.getCategory();
        result = result * PRIME + ($category == null ? 43 : $category.hashCode());
        final java.lang.Object $createdAt = this.getCreatedAt();
        result = result * PRIME + ($createdAt == null ? 43 : $createdAt.hashCode());
        final java.lang.Object $payLoad = this.getPayLoad();
        result = result * PRIME + ($payLoad == null ? 43 : $payLoad.hashCode());
        final java.lang.Object $businessDate = this.getBusinessDate();
        result = result * PRIME + ($businessDate == null ? 43 : $businessDate.hashCode());
        final java.lang.Object $schema = this.getSchema();
        result = result * PRIME + ($schema == null ? 43 : $schema.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "ExternalEventResponse(eventId=" + this.getEventId() + ", type=" + this.getType() + ", category=" + this.getCategory() + ", createdAt=" + this.getCreatedAt() + ", payLoad=" + this.getPayLoad() + ", businessDate=" + this.getBusinessDate() + ", schema=" + this.getSchema() + ", aggregateRootId=" + this.getAggregateRootId() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public ExternalEventResponse() {
    }

    @java.lang.SuppressWarnings("all")
        public ExternalEventResponse(final Long eventId, final String type, final String category, final OffsetDateTime createdAt, final Map<String, Object> payLoad, final LocalDate businessDate, final String schema, final Long aggregateRootId) {
        this.eventId = eventId;
        this.type = type;
        this.category = category;
        this.createdAt = createdAt;
        this.payLoad = payLoad;
        this.businessDate = businessDate;
        this.schema = schema;
        this.aggregateRootId = aggregateRootId;
    }
}
