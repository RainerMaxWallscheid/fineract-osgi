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

import java.util.List;

/**
 * Created by Cieyou on 3/11/14.
 */
public class PpiPovertyLineData {
    String ppi;
    List<LikeliHoodPovertyLineData> likeliHoodPovertyLineData;

    @java.lang.SuppressWarnings("all")
        public String getPpi() {
        return this.ppi;
    }

    @java.lang.SuppressWarnings("all")
        public List<LikeliHoodPovertyLineData> getLikeliHoodPovertyLineData() {
        return this.likeliHoodPovertyLineData;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public PpiPovertyLineData setPpi(final String ppi) {
        this.ppi = ppi;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public PpiPovertyLineData setLikeliHoodPovertyLineData(final List<LikeliHoodPovertyLineData> likeliHoodPovertyLineData) {
        this.likeliHoodPovertyLineData = likeliHoodPovertyLineData;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof PpiPovertyLineData)) return false;
        final PpiPovertyLineData other = (PpiPovertyLineData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$ppi = this.getPpi();
        final java.lang.Object other$ppi = other.getPpi();
        if (this$ppi == null ? other$ppi != null : !this$ppi.equals(other$ppi)) return false;
        final java.lang.Object this$likeliHoodPovertyLineData = this.getLikeliHoodPovertyLineData();
        final java.lang.Object other$likeliHoodPovertyLineData = other.getLikeliHoodPovertyLineData();
        if (this$likeliHoodPovertyLineData == null ? other$likeliHoodPovertyLineData != null : !this$likeliHoodPovertyLineData.equals(other$likeliHoodPovertyLineData)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof PpiPovertyLineData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $ppi = this.getPpi();
        result = result * PRIME + ($ppi == null ? 43 : $ppi.hashCode());
        final java.lang.Object $likeliHoodPovertyLineData = this.getLikeliHoodPovertyLineData();
        result = result * PRIME + ($likeliHoodPovertyLineData == null ? 43 : $likeliHoodPovertyLineData.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "PpiPovertyLineData(ppi=" + this.getPpi() + ", likeliHoodPovertyLineData=" + this.getLikeliHoodPovertyLineData() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public PpiPovertyLineData() {
    }
}
