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
package org.apache.fineract.infrastructure.reportmailingjob.data;

/**
 * Immutable data object representing report mailing job configuration data.
 */
public final class ReportMailingJobConfigurationData {
    private int id;
    private String name;
    private String value;

    /**
     * creates an instance of the ReportMailingJobConfigurationData class
     *
     * @return ReportMailingJobConfigurationData object
     */
    public static ReportMailingJobConfigurationData newInstance(final int id, final String name, final String value) {
        return new ReportMailingJobConfigurationData().setId(id).setName(name).setValue(value);
    }

    @java.lang.SuppressWarnings("all")
        public int getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public String getName() {
        return this.name;
    }

    @java.lang.SuppressWarnings("all")
        public String getValue() {
        return this.value;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ReportMailingJobConfigurationData setId(final int id) {
        this.id = id;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ReportMailingJobConfigurationData setName(final String name) {
        this.name = name;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ReportMailingJobConfigurationData setValue(final String value) {
        this.value = value;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof ReportMailingJobConfigurationData)) return false;
        final ReportMailingJobConfigurationData other = (ReportMailingJobConfigurationData) o;
        if (this.getId() != other.getId()) return false;
        final java.lang.Object this$name = this.getName();
        final java.lang.Object other$name = other.getName();
        if (this$name == null ? other$name != null : !this$name.equals(other$name)) return false;
        final java.lang.Object this$value = this.getValue();
        final java.lang.Object other$value = other.getValue();
        if (this$value == null ? other$value != null : !this$value.equals(other$value)) return false;
        return true;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        result = result * PRIME + this.getId();
        final java.lang.Object $name = this.getName();
        result = result * PRIME + ($name == null ? 43 : $name.hashCode());
        final java.lang.Object $value = this.getValue();
        result = result * PRIME + ($value == null ? 43 : $value.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "ReportMailingJobConfigurationData(id=" + this.getId() + ", name=" + this.getName() + ", value=" + this.getValue() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public ReportMailingJobConfigurationData() {
    }
}
