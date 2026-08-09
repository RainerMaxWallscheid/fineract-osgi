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
package org.apache.fineract.infrastructure.configuration.data;

public class S3CredentialsData {
    private String bucketName;
    private String accessKey;
    private String secretKey;

    @java.lang.SuppressWarnings("all")
        public String getBucketName() {
        return this.bucketName;
    }

    @java.lang.SuppressWarnings("all")
        public String getAccessKey() {
        return this.accessKey;
    }

    @java.lang.SuppressWarnings("all")
        public String getSecretKey() {
        return this.secretKey;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public S3CredentialsData setBucketName(final String bucketName) {
        this.bucketName = bucketName;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public S3CredentialsData setAccessKey(final String accessKey) {
        this.accessKey = accessKey;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public S3CredentialsData setSecretKey(final String secretKey) {
        this.secretKey = secretKey;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof S3CredentialsData)) return false;
        final S3CredentialsData other = (S3CredentialsData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$bucketName = this.getBucketName();
        final java.lang.Object other$bucketName = other.getBucketName();
        if (this$bucketName == null ? other$bucketName != null : !this$bucketName.equals(other$bucketName)) return false;
        final java.lang.Object this$accessKey = this.getAccessKey();
        final java.lang.Object other$accessKey = other.getAccessKey();
        if (this$accessKey == null ? other$accessKey != null : !this$accessKey.equals(other$accessKey)) return false;
        final java.lang.Object this$secretKey = this.getSecretKey();
        final java.lang.Object other$secretKey = other.getSecretKey();
        if (this$secretKey == null ? other$secretKey != null : !this$secretKey.equals(other$secretKey)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof S3CredentialsData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $bucketName = this.getBucketName();
        result = result * PRIME + ($bucketName == null ? 43 : $bucketName.hashCode());
        final java.lang.Object $accessKey = this.getAccessKey();
        result = result * PRIME + ($accessKey == null ? 43 : $accessKey.hashCode());
        final java.lang.Object $secretKey = this.getSecretKey();
        result = result * PRIME + ($secretKey == null ? 43 : $secretKey.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "S3CredentialsData(bucketName=" + this.getBucketName() + ", accessKey=" + this.getAccessKey() + ", secretKey=" + this.getSecretKey() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public S3CredentialsData() {
    }
}
