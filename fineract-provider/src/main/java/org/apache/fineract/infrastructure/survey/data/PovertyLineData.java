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
 * Created by Cieyou on 3/11/14.
 */
public class PovertyLineData {
    Long resourceId;
    Long scoreFrom;
    Long scoreTo;
    Double povertyLine;

    @java.lang.SuppressWarnings("all")
        public Long getResourceId() {
        return this.resourceId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getScoreFrom() {
        return this.scoreFrom;
    }

    @java.lang.SuppressWarnings("all")
        public Long getScoreTo() {
        return this.scoreTo;
    }

    @java.lang.SuppressWarnings("all")
        public Double getPovertyLine() {
        return this.povertyLine;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public PovertyLineData setResourceId(final Long resourceId) {
        this.resourceId = resourceId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public PovertyLineData setScoreFrom(final Long scoreFrom) {
        this.scoreFrom = scoreFrom;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public PovertyLineData setScoreTo(final Long scoreTo) {
        this.scoreTo = scoreTo;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public PovertyLineData setPovertyLine(final Double povertyLine) {
        this.povertyLine = povertyLine;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof PovertyLineData)) return false;
        final PovertyLineData other = (PovertyLineData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$resourceId = this.getResourceId();
        final java.lang.Object other$resourceId = other.getResourceId();
        if (this$resourceId == null ? other$resourceId != null : !this$resourceId.equals(other$resourceId)) return false;
        final java.lang.Object this$scoreFrom = this.getScoreFrom();
        final java.lang.Object other$scoreFrom = other.getScoreFrom();
        if (this$scoreFrom == null ? other$scoreFrom != null : !this$scoreFrom.equals(other$scoreFrom)) return false;
        final java.lang.Object this$scoreTo = this.getScoreTo();
        final java.lang.Object other$scoreTo = other.getScoreTo();
        if (this$scoreTo == null ? other$scoreTo != null : !this$scoreTo.equals(other$scoreTo)) return false;
        final java.lang.Object this$povertyLine = this.getPovertyLine();
        final java.lang.Object other$povertyLine = other.getPovertyLine();
        if (this$povertyLine == null ? other$povertyLine != null : !this$povertyLine.equals(other$povertyLine)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof PovertyLineData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $resourceId = this.getResourceId();
        result = result * PRIME + ($resourceId == null ? 43 : $resourceId.hashCode());
        final java.lang.Object $scoreFrom = this.getScoreFrom();
        result = result * PRIME + ($scoreFrom == null ? 43 : $scoreFrom.hashCode());
        final java.lang.Object $scoreTo = this.getScoreTo();
        result = result * PRIME + ($scoreTo == null ? 43 : $scoreTo.hashCode());
        final java.lang.Object $povertyLine = this.getPovertyLine();
        result = result * PRIME + ($povertyLine == null ? 43 : $povertyLine.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "PovertyLineData(resourceId=" + this.getResourceId() + ", scoreFrom=" + this.getScoreFrom() + ", scoreTo=" + this.getScoreTo() + ", povertyLine=" + this.getPovertyLine() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public PovertyLineData() {
    }
}
