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

public class FineractEntityRelationData implements Serializable {
    private static final long serialVersionUID = 1L;
    @SuppressWarnings("unused")
    private Long id;
    @SuppressWarnings("unused")
    private Integer fromEntityType;
    @SuppressWarnings("unused")
    private Integer toEntityType;
    @SuppressWarnings("unused")
    private String mappingTypes;

    public static FineractEntityRelationData getMappingTypes(final Long id, final String mappingTypes) {
        Integer fromEntityType = null;
        final Integer toEntityType = null;
        return new FineractEntityRelationData().setId(id).setFromEntityType(fromEntityType).setToEntityType(toEntityType).setMappingTypes(mappingTypes);
    }

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getFromEntityType() {
        return this.fromEntityType;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getToEntityType() {
        return this.toEntityType;
    }

    @java.lang.SuppressWarnings("all")
        public String getMappingTypes() {
        return this.mappingTypes;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public FineractEntityRelationData setId(final Long id) {
        this.id = id;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public FineractEntityRelationData setFromEntityType(final Integer fromEntityType) {
        this.fromEntityType = fromEntityType;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public FineractEntityRelationData setToEntityType(final Integer toEntityType) {
        this.toEntityType = toEntityType;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public FineractEntityRelationData setMappingTypes(final String mappingTypes) {
        this.mappingTypes = mappingTypes;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof FineractEntityRelationData)) return false;
        final FineractEntityRelationData other = (FineractEntityRelationData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$id = this.getId();
        final java.lang.Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        final java.lang.Object this$fromEntityType = this.getFromEntityType();
        final java.lang.Object other$fromEntityType = other.getFromEntityType();
        if (this$fromEntityType == null ? other$fromEntityType != null : !this$fromEntityType.equals(other$fromEntityType)) return false;
        final java.lang.Object this$toEntityType = this.getToEntityType();
        final java.lang.Object other$toEntityType = other.getToEntityType();
        if (this$toEntityType == null ? other$toEntityType != null : !this$toEntityType.equals(other$toEntityType)) return false;
        final java.lang.Object this$mappingTypes = this.getMappingTypes();
        final java.lang.Object other$mappingTypes = other.getMappingTypes();
        if (this$mappingTypes == null ? other$mappingTypes != null : !this$mappingTypes.equals(other$mappingTypes)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof FineractEntityRelationData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $id = this.getId();
        result = result * PRIME + ($id == null ? 43 : $id.hashCode());
        final java.lang.Object $fromEntityType = this.getFromEntityType();
        result = result * PRIME + ($fromEntityType == null ? 43 : $fromEntityType.hashCode());
        final java.lang.Object $toEntityType = this.getToEntityType();
        result = result * PRIME + ($toEntityType == null ? 43 : $toEntityType.hashCode());
        final java.lang.Object $mappingTypes = this.getMappingTypes();
        result = result * PRIME + ($mappingTypes == null ? 43 : $mappingTypes.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "FineractEntityRelationData(id=" + this.getId() + ", fromEntityType=" + this.getFromEntityType() + ", toEntityType=" + this.getToEntityType() + ", mappingTypes=" + this.getMappingTypes() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public FineractEntityRelationData() {
    }
}
