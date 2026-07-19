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

import org.apache.fineract.infrastructure.entityaccess.domain.FineractEntity;
import org.apache.fineract.infrastructure.entityaccess.domain.FineractEntityAccessType;

public class FineractEntityAccessData {
    private FineractEntity firstEntity;
    private FineractEntityAccessType accessType;
    private FineractEntity secondEntity;

    @java.lang.SuppressWarnings("all")
        public FineractEntity getFirstEntity() {
        return this.firstEntity;
    }

    @java.lang.SuppressWarnings("all")
        public FineractEntityAccessType getAccessType() {
        return this.accessType;
    }

    @java.lang.SuppressWarnings("all")
        public FineractEntity getSecondEntity() {
        return this.secondEntity;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public FineractEntityAccessData setFirstEntity(final FineractEntity firstEntity) {
        this.firstEntity = firstEntity;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public FineractEntityAccessData setAccessType(final FineractEntityAccessType accessType) {
        this.accessType = accessType;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public FineractEntityAccessData setSecondEntity(final FineractEntity secondEntity) {
        this.secondEntity = secondEntity;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof FineractEntityAccessData)) return false;
        final FineractEntityAccessData other = (FineractEntityAccessData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$firstEntity = this.getFirstEntity();
        final java.lang.Object other$firstEntity = other.getFirstEntity();
        if (this$firstEntity == null ? other$firstEntity != null : !this$firstEntity.equals(other$firstEntity)) return false;
        final java.lang.Object this$accessType = this.getAccessType();
        final java.lang.Object other$accessType = other.getAccessType();
        if (this$accessType == null ? other$accessType != null : !this$accessType.equals(other$accessType)) return false;
        final java.lang.Object this$secondEntity = this.getSecondEntity();
        final java.lang.Object other$secondEntity = other.getSecondEntity();
        if (this$secondEntity == null ? other$secondEntity != null : !this$secondEntity.equals(other$secondEntity)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof FineractEntityAccessData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $firstEntity = this.getFirstEntity();
        result = result * PRIME + ($firstEntity == null ? 43 : $firstEntity.hashCode());
        final java.lang.Object $accessType = this.getAccessType();
        result = result * PRIME + ($accessType == null ? 43 : $accessType.hashCode());
        final java.lang.Object $secondEntity = this.getSecondEntity();
        result = result * PRIME + ($secondEntity == null ? 43 : $secondEntity.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "FineractEntityAccessData(firstEntity=" + this.getFirstEntity() + ", accessType=" + this.getAccessType() + ", secondEntity=" + this.getSecondEntity() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public FineractEntityAccessData() {
    }
}
