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
package org.apache.fineract.template.data;

import java.io.Serial;
import java.io.Serializable;

public final class TemplateMapperData implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private int mapperorder;
    private String mapperkey;
    private String mappervalue;


    @java.lang.SuppressWarnings("all")
        public static class TemplateMapperDataBuilder {
        @java.lang.SuppressWarnings("all")
                private int mapperorder;
        @java.lang.SuppressWarnings("all")
                private String mapperkey;
        @java.lang.SuppressWarnings("all")
                private String mappervalue;

        @java.lang.SuppressWarnings("all")
                TemplateMapperDataBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public TemplateMapperData.TemplateMapperDataBuilder mapperorder(final int mapperorder) {
            this.mapperorder = mapperorder;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public TemplateMapperData.TemplateMapperDataBuilder mapperkey(final String mapperkey) {
            this.mapperkey = mapperkey;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public TemplateMapperData.TemplateMapperDataBuilder mappervalue(final String mappervalue) {
            this.mappervalue = mappervalue;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public TemplateMapperData build() {
            return new TemplateMapperData(this.mapperorder, this.mapperkey, this.mappervalue);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "TemplateMapperData.TemplateMapperDataBuilder(mapperorder=" + this.mapperorder + ", mapperkey=" + this.mapperkey + ", mappervalue=" + this.mappervalue + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static TemplateMapperData.TemplateMapperDataBuilder builder() {
        return new TemplateMapperData.TemplateMapperDataBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public int getMapperorder() {
        return this.mapperorder;
    }

    @java.lang.SuppressWarnings("all")
        public String getMapperkey() {
        return this.mapperkey;
    }

    @java.lang.SuppressWarnings("all")
        public String getMappervalue() {
        return this.mappervalue;
    }

    @java.lang.SuppressWarnings("all")
        public void setMapperorder(final int mapperorder) {
        this.mapperorder = mapperorder;
    }

    @java.lang.SuppressWarnings("all")
        public void setMapperkey(final String mapperkey) {
        this.mapperkey = mapperkey;
    }

    @java.lang.SuppressWarnings("all")
        public void setMappervalue(final String mappervalue) {
        this.mappervalue = mappervalue;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof TemplateMapperData)) return false;
        final TemplateMapperData other = (TemplateMapperData) o;
        if (this.getMapperorder() != other.getMapperorder()) return false;
        final java.lang.Object this$mapperkey = this.getMapperkey();
        final java.lang.Object other$mapperkey = other.getMapperkey();
        if (this$mapperkey == null ? other$mapperkey != null : !this$mapperkey.equals(other$mapperkey)) return false;
        final java.lang.Object this$mappervalue = this.getMappervalue();
        final java.lang.Object other$mappervalue = other.getMappervalue();
        if (this$mappervalue == null ? other$mappervalue != null : !this$mappervalue.equals(other$mappervalue)) return false;
        return true;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        result = result * PRIME + this.getMapperorder();
        final java.lang.Object $mapperkey = this.getMapperkey();
        result = result * PRIME + ($mapperkey == null ? 43 : $mapperkey.hashCode());
        final java.lang.Object $mappervalue = this.getMappervalue();
        result = result * PRIME + ($mappervalue == null ? 43 : $mappervalue.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "TemplateMapperData(mapperorder=" + this.getMapperorder() + ", mapperkey=" + this.getMapperkey() + ", mappervalue=" + this.getMappervalue() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public TemplateMapperData() {
    }

    @java.lang.SuppressWarnings("all")
        public TemplateMapperData(final int mapperorder, final String mapperkey, final String mappervalue) {
        this.mapperorder = mapperorder;
        this.mapperkey = mapperkey;
        this.mappervalue = mappervalue;
    }
}
