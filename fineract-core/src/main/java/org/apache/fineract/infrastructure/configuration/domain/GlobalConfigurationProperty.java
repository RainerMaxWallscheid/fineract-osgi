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
package org.apache.fineract.infrastructure.configuration.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import java.time.LocalDate;
import org.apache.fineract.infrastructure.configuration.data.GlobalConfigurationPropertyData;
import org.apache.fineract.infrastructure.core.domain.AbstractPersistableCustom;

@Entity
@Table(name = "c_configuration")
public class GlobalConfigurationProperty extends AbstractPersistableCustom<Long> {
    @Column(name = "name", nullable = false)
    private String name;
    @Column(name = "enabled", nullable = false)
    private boolean enabled;
    @Column(name = "value", nullable = true)
    private Long value;
    @Column(name = "date_value", nullable = true)
    private LocalDate dateValue;
    @Column(name = "string_value", nullable = true)
    private String stringValue;
    @Column(name = "description", nullable = true)
    private String description;
    @Column(name = "is_trap_door", nullable = false)
    private boolean isTrapDoor;

    public static GlobalConfigurationProperty newSurveyConfiguration(final String name) {
        return new GlobalConfigurationProperty().setName(name);
    }

    public GlobalConfigurationPropertyData toData() {
        return new GlobalConfigurationPropertyData().setName(getName()).setEnabled(isEnabled()).setValue(getValue()).setDateValue(getDateValue()).setStringValue(getStringValue()).setId(this.getId()).setDescription(this.description).setTrapDoor(this.isTrapDoor);
    }

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
        public String getDescription() {
        return this.description;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isTrapDoor() {
        return this.isTrapDoor;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public GlobalConfigurationProperty setName(final String name) {
        this.name = name;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public GlobalConfigurationProperty setEnabled(final boolean enabled) {
        this.enabled = enabled;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public GlobalConfigurationProperty setValue(final Long value) {
        this.value = value;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public GlobalConfigurationProperty setDateValue(final LocalDate dateValue) {
        this.dateValue = dateValue;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public GlobalConfigurationProperty setStringValue(final String stringValue) {
        this.stringValue = stringValue;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public GlobalConfigurationProperty setDescription(final String description) {
        this.description = description;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public GlobalConfigurationProperty setTrapDoor(final boolean isTrapDoor) {
        this.isTrapDoor = isTrapDoor;
        return this;
    }

    @java.lang.SuppressWarnings("all")
        public GlobalConfigurationProperty() {
    }
}
