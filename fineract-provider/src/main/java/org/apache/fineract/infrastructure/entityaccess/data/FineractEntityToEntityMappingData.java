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
package org.apache.fineract.infrastructure.entityaccess.data;

import java.io.Serializable;
import java.time.LocalDate;

public class FineractEntityToEntityMappingData implements Serializable {
    private static final long serialVersionUID = 1L;
    @SuppressWarnings("unused")
    private Long mapId;
    @SuppressWarnings("unused")
    private Long relationId;
    @SuppressWarnings("unused")
    private Long fromId;
    @SuppressWarnings("unused")
    private Long toId;
    @SuppressWarnings("unused")
    private LocalDate startDate;
    @SuppressWarnings("unused")
    private LocalDate endDate;
    @SuppressWarnings("unused")
    private String fromEntity;
    @SuppressWarnings("unused")
    private String toEntity;

    public static FineractEntityToEntityMappingData getRelatedEntities(final Long mapId, final Long relationId, final Long fromId, final Long toId, final LocalDate startDate, final LocalDate endDate, final String fromEntity, final String toEntity) {
        return new FineractEntityToEntityMappingData().setMapId(mapId).setRelationId(relationId).setFromId(fromId).setToId(toId).setStartDate(startDate).setEndDate(endDate).setFromEntity(fromEntity).setToEntity(toEntity);
    }

    public static FineractEntityToEntityMappingData getRelatedEntities(final Long relationId, final Long fromId, final Long toId, final LocalDate startDate, final LocalDate endDate) {
        final Long mapId = null;
        final String fromEntity = null;
        final String toEntity = null;
        return new FineractEntityToEntityMappingData().setMapId(mapId).setRelationId(relationId).setFromId(fromId).setToId(toId).setStartDate(startDate).setEndDate(endDate).setFromEntity(fromEntity).setToEntity(toEntity);
    }

    @java.lang.SuppressWarnings("all")
        public Long getMapId() {
        return this.mapId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getRelationId() {
        return this.relationId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getFromId() {
        return this.fromId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getToId() {
        return this.toId;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getStartDate() {
        return this.startDate;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getEndDate() {
        return this.endDate;
    }

    @java.lang.SuppressWarnings("all")
        public String getFromEntity() {
        return this.fromEntity;
    }

    @java.lang.SuppressWarnings("all")
        public String getToEntity() {
        return this.toEntity;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public FineractEntityToEntityMappingData setMapId(final Long mapId) {
        this.mapId = mapId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public FineractEntityToEntityMappingData setRelationId(final Long relationId) {
        this.relationId = relationId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public FineractEntityToEntityMappingData setFromId(final Long fromId) {
        this.fromId = fromId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public FineractEntityToEntityMappingData setToId(final Long toId) {
        this.toId = toId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public FineractEntityToEntityMappingData setStartDate(final LocalDate startDate) {
        this.startDate = startDate;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public FineractEntityToEntityMappingData setEndDate(final LocalDate endDate) {
        this.endDate = endDate;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public FineractEntityToEntityMappingData setFromEntity(final String fromEntity) {
        this.fromEntity = fromEntity;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public FineractEntityToEntityMappingData setToEntity(final String toEntity) {
        this.toEntity = toEntity;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof FineractEntityToEntityMappingData)) return false;
        final FineractEntityToEntityMappingData other = (FineractEntityToEntityMappingData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$mapId = this.getMapId();
        final java.lang.Object other$mapId = other.getMapId();
        if (this$mapId == null ? other$mapId != null : !this$mapId.equals(other$mapId)) return false;
        final java.lang.Object this$relationId = this.getRelationId();
        final java.lang.Object other$relationId = other.getRelationId();
        if (this$relationId == null ? other$relationId != null : !this$relationId.equals(other$relationId)) return false;
        final java.lang.Object this$fromId = this.getFromId();
        final java.lang.Object other$fromId = other.getFromId();
        if (this$fromId == null ? other$fromId != null : !this$fromId.equals(other$fromId)) return false;
        final java.lang.Object this$toId = this.getToId();
        final java.lang.Object other$toId = other.getToId();
        if (this$toId == null ? other$toId != null : !this$toId.equals(other$toId)) return false;
        final java.lang.Object this$startDate = this.getStartDate();
        final java.lang.Object other$startDate = other.getStartDate();
        if (this$startDate == null ? other$startDate != null : !this$startDate.equals(other$startDate)) return false;
        final java.lang.Object this$endDate = this.getEndDate();
        final java.lang.Object other$endDate = other.getEndDate();
        if (this$endDate == null ? other$endDate != null : !this$endDate.equals(other$endDate)) return false;
        final java.lang.Object this$fromEntity = this.getFromEntity();
        final java.lang.Object other$fromEntity = other.getFromEntity();
        if (this$fromEntity == null ? other$fromEntity != null : !this$fromEntity.equals(other$fromEntity)) return false;
        final java.lang.Object this$toEntity = this.getToEntity();
        final java.lang.Object other$toEntity = other.getToEntity();
        if (this$toEntity == null ? other$toEntity != null : !this$toEntity.equals(other$toEntity)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof FineractEntityToEntityMappingData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $mapId = this.getMapId();
        result = result * PRIME + ($mapId == null ? 43 : $mapId.hashCode());
        final java.lang.Object $relationId = this.getRelationId();
        result = result * PRIME + ($relationId == null ? 43 : $relationId.hashCode());
        final java.lang.Object $fromId = this.getFromId();
        result = result * PRIME + ($fromId == null ? 43 : $fromId.hashCode());
        final java.lang.Object $toId = this.getToId();
        result = result * PRIME + ($toId == null ? 43 : $toId.hashCode());
        final java.lang.Object $startDate = this.getStartDate();
        result = result * PRIME + ($startDate == null ? 43 : $startDate.hashCode());
        final java.lang.Object $endDate = this.getEndDate();
        result = result * PRIME + ($endDate == null ? 43 : $endDate.hashCode());
        final java.lang.Object $fromEntity = this.getFromEntity();
        result = result * PRIME + ($fromEntity == null ? 43 : $fromEntity.hashCode());
        final java.lang.Object $toEntity = this.getToEntity();
        result = result * PRIME + ($toEntity == null ? 43 : $toEntity.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "FineractEntityToEntityMappingData(mapId=" + this.getMapId() + ", relationId=" + this.getRelationId() + ", fromId=" + this.getFromId() + ", toId=" + this.getToId() + ", startDate=" + this.getStartDate() + ", endDate=" + this.getEndDate() + ", fromEntity=" + this.getFromEntity() + ", toEntity=" + this.getToEntity() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public FineractEntityToEntityMappingData() {
    }
}
