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
package org.apache.fineract.infrastructure.survey.data;

/**
 * Created by Cieyou on 3/12/14.
 */
public class LikelihoodData {
    long resourceId;
    String likeliHoodName;
    String likeliHoodCode;
    long enabled;

    @java.lang.SuppressWarnings("all")
        public long getResourceId() {
        return this.resourceId;
    }

    @java.lang.SuppressWarnings("all")
        public String getLikeliHoodName() {
        return this.likeliHoodName;
    }

    @java.lang.SuppressWarnings("all")
        public String getLikeliHoodCode() {
        return this.likeliHoodCode;
    }

    @java.lang.SuppressWarnings("all")
        public long getEnabled() {
        return this.enabled;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LikelihoodData setResourceId(final long resourceId) {
        this.resourceId = resourceId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LikelihoodData setLikeliHoodName(final String likeliHoodName) {
        this.likeliHoodName = likeliHoodName;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LikelihoodData setLikeliHoodCode(final String likeliHoodCode) {
        this.likeliHoodCode = likeliHoodCode;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LikelihoodData setEnabled(final long enabled) {
        this.enabled = enabled;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof LikelihoodData)) return false;
        final LikelihoodData other = (LikelihoodData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        if (this.getResourceId() != other.getResourceId()) return false;
        if (this.getEnabled() != other.getEnabled()) return false;
        final java.lang.Object this$likeliHoodName = this.getLikeliHoodName();
        final java.lang.Object other$likeliHoodName = other.getLikeliHoodName();
        if (this$likeliHoodName == null ? other$likeliHoodName != null : !this$likeliHoodName.equals(other$likeliHoodName)) return false;
        final java.lang.Object this$likeliHoodCode = this.getLikeliHoodCode();
        final java.lang.Object other$likeliHoodCode = other.getLikeliHoodCode();
        if (this$likeliHoodCode == null ? other$likeliHoodCode != null : !this$likeliHoodCode.equals(other$likeliHoodCode)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof LikelihoodData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final long $resourceId = this.getResourceId();
        result = result * PRIME + (int) ($resourceId >>> 32 ^ $resourceId);
        final long $enabled = this.getEnabled();
        result = result * PRIME + (int) ($enabled >>> 32 ^ $enabled);
        final java.lang.Object $likeliHoodName = this.getLikeliHoodName();
        result = result * PRIME + ($likeliHoodName == null ? 43 : $likeliHoodName.hashCode());
        final java.lang.Object $likeliHoodCode = this.getLikeliHoodCode();
        result = result * PRIME + ($likeliHoodCode == null ? 43 : $likeliHoodCode.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "LikelihoodData(resourceId=" + this.getResourceId() + ", likeliHoodName=" + this.getLikeliHoodName() + ", likeliHoodCode=" + this.getLikeliHoodCode() + ", enabled=" + this.getEnabled() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public LikelihoodData() {
    }
}
