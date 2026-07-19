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
package org.apache.fineract.mix.data;

import java.io.Serial;
import java.io.Serializable;

public class MixReportXBRLNamespaceData implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private Long id;
    private String prefix;
    private String url;


    @java.lang.SuppressWarnings("all")
        public static class MixReportXBRLNamespaceDataBuilder {
        @java.lang.SuppressWarnings("all")
                private Long id;
        @java.lang.SuppressWarnings("all")
                private String prefix;
        @java.lang.SuppressWarnings("all")
                private String url;

        @java.lang.SuppressWarnings("all")
                MixReportXBRLNamespaceDataBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public MixReportXBRLNamespaceData.MixReportXBRLNamespaceDataBuilder id(final Long id) {
            this.id = id;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public MixReportXBRLNamespaceData.MixReportXBRLNamespaceDataBuilder prefix(final String prefix) {
            this.prefix = prefix;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public MixReportXBRLNamespaceData.MixReportXBRLNamespaceDataBuilder url(final String url) {
            this.url = url;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public MixReportXBRLNamespaceData build() {
            return new MixReportXBRLNamespaceData(this.id, this.prefix, this.url);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "MixReportXBRLNamespaceData.MixReportXBRLNamespaceDataBuilder(id=" + this.id + ", prefix=" + this.prefix + ", url=" + this.url + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static MixReportXBRLNamespaceData.MixReportXBRLNamespaceDataBuilder builder() {
        return new MixReportXBRLNamespaceData.MixReportXBRLNamespaceDataBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public String getPrefix() {
        return this.prefix;
    }

    @java.lang.SuppressWarnings("all")
        public String getUrl() {
        return this.url;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public MixReportXBRLNamespaceData setId(final Long id) {
        this.id = id;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public MixReportXBRLNamespaceData setPrefix(final String prefix) {
        this.prefix = prefix;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public MixReportXBRLNamespaceData setUrl(final String url) {
        this.url = url;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof MixReportXBRLNamespaceData)) return false;
        final MixReportXBRLNamespaceData other = (MixReportXBRLNamespaceData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$id = this.getId();
        final java.lang.Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        final java.lang.Object this$prefix = this.getPrefix();
        final java.lang.Object other$prefix = other.getPrefix();
        if (this$prefix == null ? other$prefix != null : !this$prefix.equals(other$prefix)) return false;
        final java.lang.Object this$url = this.getUrl();
        final java.lang.Object other$url = other.getUrl();
        if (this$url == null ? other$url != null : !this$url.equals(other$url)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof MixReportXBRLNamespaceData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $id = this.getId();
        result = result * PRIME + ($id == null ? 43 : $id.hashCode());
        final java.lang.Object $prefix = this.getPrefix();
        result = result * PRIME + ($prefix == null ? 43 : $prefix.hashCode());
        final java.lang.Object $url = this.getUrl();
        result = result * PRIME + ($url == null ? 43 : $url.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "MixReportXBRLNamespaceData(id=" + this.getId() + ", prefix=" + this.getPrefix() + ", url=" + this.getUrl() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public MixReportXBRLNamespaceData() {
    }

    @java.lang.SuppressWarnings("all")
        public MixReportXBRLNamespaceData(final Long id, final String prefix, final String url) {
        this.id = id;
        this.prefix = prefix;
        this.url = url;
    }
}
