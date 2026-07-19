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
package org.apache.fineract.portfolio.delinquency.api.data;

import java.util.List;
import org.apache.fineract.infrastructure.core.data.StringEnumOptionData;

public class DelinquencyBucketTemplateResponse {
    private final List<DelinquencyRangeResponse> rangesOptions;
    private final List<StringEnumOptionData> bucketTypeOptions;
    private final List<StringEnumOptionData> frequencyTypeOptions;
    private final List<StringEnumOptionData> minimumPaymentOptions;

    @java.lang.SuppressWarnings("all")
        public DelinquencyBucketTemplateResponse(final List<DelinquencyRangeResponse> rangesOptions, final List<StringEnumOptionData> bucketTypeOptions, final List<StringEnumOptionData> frequencyTypeOptions, final List<StringEnumOptionData> minimumPaymentOptions) {
        this.rangesOptions = rangesOptions;
        this.bucketTypeOptions = bucketTypeOptions;
        this.frequencyTypeOptions = frequencyTypeOptions;
        this.minimumPaymentOptions = minimumPaymentOptions;
    }

    @java.lang.SuppressWarnings("all")
        public List<DelinquencyRangeResponse> getRangesOptions() {
        return this.rangesOptions;
    }

    @java.lang.SuppressWarnings("all")
        public List<StringEnumOptionData> getBucketTypeOptions() {
        return this.bucketTypeOptions;
    }

    @java.lang.SuppressWarnings("all")
        public List<StringEnumOptionData> getFrequencyTypeOptions() {
        return this.frequencyTypeOptions;
    }

    @java.lang.SuppressWarnings("all")
        public List<StringEnumOptionData> getMinimumPaymentOptions() {
        return this.minimumPaymentOptions;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof DelinquencyBucketTemplateResponse)) return false;
        final DelinquencyBucketTemplateResponse other = (DelinquencyBucketTemplateResponse) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$rangesOptions = this.getRangesOptions();
        final java.lang.Object other$rangesOptions = other.getRangesOptions();
        if (this$rangesOptions == null ? other$rangesOptions != null : !this$rangesOptions.equals(other$rangesOptions)) return false;
        final java.lang.Object this$bucketTypeOptions = this.getBucketTypeOptions();
        final java.lang.Object other$bucketTypeOptions = other.getBucketTypeOptions();
        if (this$bucketTypeOptions == null ? other$bucketTypeOptions != null : !this$bucketTypeOptions.equals(other$bucketTypeOptions)) return false;
        final java.lang.Object this$frequencyTypeOptions = this.getFrequencyTypeOptions();
        final java.lang.Object other$frequencyTypeOptions = other.getFrequencyTypeOptions();
        if (this$frequencyTypeOptions == null ? other$frequencyTypeOptions != null : !this$frequencyTypeOptions.equals(other$frequencyTypeOptions)) return false;
        final java.lang.Object this$minimumPaymentOptions = this.getMinimumPaymentOptions();
        final java.lang.Object other$minimumPaymentOptions = other.getMinimumPaymentOptions();
        if (this$minimumPaymentOptions == null ? other$minimumPaymentOptions != null : !this$minimumPaymentOptions.equals(other$minimumPaymentOptions)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof DelinquencyBucketTemplateResponse;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $rangesOptions = this.getRangesOptions();
        result = result * PRIME + ($rangesOptions == null ? 43 : $rangesOptions.hashCode());
        final java.lang.Object $bucketTypeOptions = this.getBucketTypeOptions();
        result = result * PRIME + ($bucketTypeOptions == null ? 43 : $bucketTypeOptions.hashCode());
        final java.lang.Object $frequencyTypeOptions = this.getFrequencyTypeOptions();
        result = result * PRIME + ($frequencyTypeOptions == null ? 43 : $frequencyTypeOptions.hashCode());
        final java.lang.Object $minimumPaymentOptions = this.getMinimumPaymentOptions();
        result = result * PRIME + ($minimumPaymentOptions == null ? 43 : $minimumPaymentOptions.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "DelinquencyBucketTemplateResponse(rangesOptions=" + this.getRangesOptions() + ", bucketTypeOptions=" + this.getBucketTypeOptions() + ", frequencyTypeOptions=" + this.getFrequencyTypeOptions() + ", minimumPaymentOptions=" + this.getMinimumPaymentOptions() + ")";
    }
}
