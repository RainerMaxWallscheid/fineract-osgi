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

import java.time.LocalDate;

/**
 * Immutable data object for global configuration property.
 */
public class GlobalConfigurationPropertyData {
    @SuppressWarnings("unused")
    private String name;
    @SuppressWarnings("unused")
    private boolean enabled;
    @SuppressWarnings("unused")
    private Long value;
    @SuppressWarnings("unused")
    private LocalDate dateValue;
    private String stringValue;
    @SuppressWarnings("unused")
    private Long id;
    @SuppressWarnings("unused")
    private String description;
    @SuppressWarnings("unused")
    private boolean trapDoor;

    @java.lang.SuppressWarnings("all")
        public String getName() {
        return this.name;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isEnabled() {
        return this.enabled;
    }

    @java.lang.SuppressWarnings("all")
        public Long getValue() {
        return this.value;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getDateValue() {
        return this.dateValue;
    }

    @java.lang.SuppressWarnings("all")
        public String getStringValue() {
        return this.stringValue;
    }

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public String getDescription() {
        return this.description;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isTrapDoor() {
        return this.trapDoor;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public GlobalConfigurationPropertyData setName(final String name) {
        this.name = name;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public GlobalConfigurationPropertyData setEnabled(final boolean enabled) {
        this.enabled = enabled;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public GlobalConfigurationPropertyData setValue(final Long value) {
        this.value = value;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public GlobalConfigurationPropertyData setDateValue(final LocalDate dateValue) {
        this.dateValue = dateValue;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public GlobalConfigurationPropertyData setStringValue(final String stringValue) {
        this.stringValue = stringValue;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public GlobalConfigurationPropertyData setId(final Long id) {
        this.id = id;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public GlobalConfigurationPropertyData setDescription(final String description) {
        this.description = description;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public GlobalConfigurationPropertyData setTrapDoor(final boolean trapDoor) {
        this.trapDoor = trapDoor;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof GlobalConfigurationPropertyData)) return false;
        final GlobalConfigurationPropertyData other = (GlobalConfigurationPropertyData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        if (this.isEnabled() != other.isEnabled()) return false;
        if (this.isTrapDoor() != other.isTrapDoor()) return false;
        final java.lang.Object this$value = this.getValue();
        final java.lang.Object other$value = other.getValue();
        if (this$value == null ? other$value != null : !this$value.equals(other$value)) return false;
        final java.lang.Object this$id = this.getId();
        final java.lang.Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        final java.lang.Object this$name = this.getName();
        final java.lang.Object other$name = other.getName();
        if (this$name == null ? other$name != null : !this$name.equals(other$name)) return false;
        final java.lang.Object this$dateValue = this.getDateValue();
        final java.lang.Object other$dateValue = other.getDateValue();
        if (this$dateValue == null ? other$dateValue != null : !this$dateValue.equals(other$dateValue)) return false;
        final java.lang.Object this$stringValue = this.getStringValue();
        final java.lang.Object other$stringValue = other.getStringValue();
        if (this$stringValue == null ? other$stringValue != null : !this$stringValue.equals(other$stringValue)) return false;
        final java.lang.Object this$description = this.getDescription();
        final java.lang.Object other$description = other.getDescription();
        if (this$description == null ? other$description != null : !this$description.equals(other$description)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof GlobalConfigurationPropertyData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        result = result * PRIME + (this.isEnabled() ? 79 : 97);
        result = result * PRIME + (this.isTrapDoor() ? 79 : 97);
        final java.lang.Object $value = this.getValue();
        result = result * PRIME + ($value == null ? 43 : $value.hashCode());
        final java.lang.Object $id = this.getId();
        result = result * PRIME + ($id == null ? 43 : $id.hashCode());
        final java.lang.Object $name = this.getName();
        result = result * PRIME + ($name == null ? 43 : $name.hashCode());
        final java.lang.Object $dateValue = this.getDateValue();
        result = result * PRIME + ($dateValue == null ? 43 : $dateValue.hashCode());
        final java.lang.Object $stringValue = this.getStringValue();
        result = result * PRIME + ($stringValue == null ? 43 : $stringValue.hashCode());
        final java.lang.Object $description = this.getDescription();
        result = result * PRIME + ($description == null ? 43 : $description.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "GlobalConfigurationPropertyData(name=" + this.getName() + ", enabled=" + this.isEnabled() + ", value=" + this.getValue() + ", dateValue=" + this.getDateValue() + ", stringValue=" + this.getStringValue() + ", id=" + this.getId() + ", description=" + this.getDescription() + ", trapDoor=" + this.isTrapDoor() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public GlobalConfigurationPropertyData() {
    }
}
