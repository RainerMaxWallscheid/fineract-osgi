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

import java.time.LocalDate;

/**
 * Created by Cieyou on 3/18/14.
 */
public class ClientScoresOverview {
    @SuppressWarnings("unused")
    private String surveyName;
    @SuppressWarnings("unused")
    private long id;
    @SuppressWarnings("unused")
    private String likelihoodCode;
    @SuppressWarnings("unused")
    private String likelihoodName;
    @SuppressWarnings("unused")
    private long score;
    @SuppressWarnings("unused")
    private Double povertyLine;
    @SuppressWarnings("unused")
    private LocalDate date;

    @java.lang.SuppressWarnings("all")
        public String getSurveyName() {
        return this.surveyName;
    }

    @java.lang.SuppressWarnings("all")
        public long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public String getLikelihoodCode() {
        return this.likelihoodCode;
    }

    @java.lang.SuppressWarnings("all")
        public String getLikelihoodName() {
        return this.likelihoodName;
    }

    @java.lang.SuppressWarnings("all")
        public long getScore() {
        return this.score;
    }

    @java.lang.SuppressWarnings("all")
        public Double getPovertyLine() {
        return this.povertyLine;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getDate() {
        return this.date;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ClientScoresOverview setSurveyName(final String surveyName) {
        this.surveyName = surveyName;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ClientScoresOverview setId(final long id) {
        this.id = id;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ClientScoresOverview setLikelihoodCode(final String likelihoodCode) {
        this.likelihoodCode = likelihoodCode;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ClientScoresOverview setLikelihoodName(final String likelihoodName) {
        this.likelihoodName = likelihoodName;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ClientScoresOverview setScore(final long score) {
        this.score = score;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ClientScoresOverview setPovertyLine(final Double povertyLine) {
        this.povertyLine = povertyLine;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ClientScoresOverview setDate(final LocalDate date) {
        this.date = date;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof ClientScoresOverview)) return false;
        final ClientScoresOverview other = (ClientScoresOverview) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        if (this.getId() != other.getId()) return false;
        if (this.getScore() != other.getScore()) return false;
        final java.lang.Object this$povertyLine = this.getPovertyLine();
        final java.lang.Object other$povertyLine = other.getPovertyLine();
        if (this$povertyLine == null ? other$povertyLine != null : !this$povertyLine.equals(other$povertyLine)) return false;
        final java.lang.Object this$surveyName = this.getSurveyName();
        final java.lang.Object other$surveyName = other.getSurveyName();
        if (this$surveyName == null ? other$surveyName != null : !this$surveyName.equals(other$surveyName)) return false;
        final java.lang.Object this$likelihoodCode = this.getLikelihoodCode();
        final java.lang.Object other$likelihoodCode = other.getLikelihoodCode();
        if (this$likelihoodCode == null ? other$likelihoodCode != null : !this$likelihoodCode.equals(other$likelihoodCode)) return false;
        final java.lang.Object this$likelihoodName = this.getLikelihoodName();
        final java.lang.Object other$likelihoodName = other.getLikelihoodName();
        if (this$likelihoodName == null ? other$likelihoodName != null : !this$likelihoodName.equals(other$likelihoodName)) return false;
        final java.lang.Object this$date = this.getDate();
        final java.lang.Object other$date = other.getDate();
        if (this$date == null ? other$date != null : !this$date.equals(other$date)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof ClientScoresOverview;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final long $id = this.getId();
        result = result * PRIME + (int) ($id >>> 32 ^ $id);
        final long $score = this.getScore();
        result = result * PRIME + (int) ($score >>> 32 ^ $score);
        final java.lang.Object $povertyLine = this.getPovertyLine();
        result = result * PRIME + ($povertyLine == null ? 43 : $povertyLine.hashCode());
        final java.lang.Object $surveyName = this.getSurveyName();
        result = result * PRIME + ($surveyName == null ? 43 : $surveyName.hashCode());
        final java.lang.Object $likelihoodCode = this.getLikelihoodCode();
        result = result * PRIME + ($likelihoodCode == null ? 43 : $likelihoodCode.hashCode());
        final java.lang.Object $likelihoodName = this.getLikelihoodName();
        result = result * PRIME + ($likelihoodName == null ? 43 : $likelihoodName.hashCode());
        final java.lang.Object $date = this.getDate();
        result = result * PRIME + ($date == null ? 43 : $date.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "ClientScoresOverview(surveyName=" + this.getSurveyName() + ", id=" + this.getId() + ", likelihoodCode=" + this.getLikelihoodCode() + ", likelihoodName=" + this.getLikelihoodName() + ", score=" + this.getScore() + ", povertyLine=" + this.getPovertyLine() + ", date=" + this.getDate() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public ClientScoresOverview() {
    }
}
