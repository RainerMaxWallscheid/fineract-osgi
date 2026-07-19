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
package org.apache.fineract.infrastructure.codes.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;
import java.util.LinkedHashMap;
import java.util.Map;
import org.apache.commons.lang3.StringUtils;
import org.apache.fineract.infrastructure.codes.CodeConstants.CodevalueJSONinputParams;
import org.apache.fineract.infrastructure.codes.data.CodeValueData;
import org.apache.fineract.infrastructure.core.api.JsonCommand;
import org.apache.fineract.infrastructure.core.domain.AbstractPersistableCustom;

@Entity
@Table(name = "m_code_value", uniqueConstraints = {@UniqueConstraint(columnNames = {"code_id", "code_value"}, name = "code_value_duplicate")})
public class CodeValue extends AbstractPersistableCustom<Long> {
    @Column(name = "code_value", length = 100)
    private String label;
    @Column(name = "order_position")
    private int position;
    @Column(name = "code_description")
    private String description;
    @ManyToOne
    @JoinColumn(name = "code_id", nullable = false)
    private Code code;
    @Column(name = "is_active")
    private boolean isActive;
    @Column(name = "is_mandatory")
    private boolean mandatory;

    public static CodeValue createNew(final Code code, final String label, final int position, final String description, final boolean isActive, final boolean mandatory) {
        return new CodeValue().setCode(code).setLabel(StringUtils.defaultIfEmpty(label, null)).setPosition(position).setDescription(description).setActive(isActive).setMandatory(mandatory);
    }

    public static CodeValue fromJson(final Code code, final JsonCommand command) {
        final String label = command.stringValueOfParameterNamed(CodevalueJSONinputParams.NAME.getValue());
        Integer position = command.integerValueSansLocaleOfParameterNamed(CodevalueJSONinputParams.POSITION.getValue());
        String description = command.stringValueOfParameterNamed(CodevalueJSONinputParams.DESCRIPTION.getValue());
        Boolean isActiveObj = command.booleanObjectValueOfParameterNamed(CodevalueJSONinputParams.IS_ACTIVE.getValue());
        boolean isActive = true;
        if (isActiveObj != null) {
            isActive = isActiveObj;
        }
        if (position == null) {
            position = 0;
        }
        Boolean mandatory = command.booleanPrimitiveValueOfParameterNamed(CodevalueJSONinputParams.IS_MANDATORY.getValue());
        return new CodeValue().setCode(code).setLabel(StringUtils.defaultIfEmpty(label, null)).setPosition(position).setDescription(description).setActive(isActive).setMandatory(mandatory);
    }

    public Map<String, Object> update(final JsonCommand command) {
        final Map<String, Object> actualChanges = new LinkedHashMap<>(2);
        final String labelParamName = CodevalueJSONinputParams.NAME.getValue();
        if (command.isChangeInStringParameterNamed(labelParamName, this.label)) {
            final String newValue = command.stringValueOfParameterNamed(labelParamName);
            actualChanges.put(labelParamName, newValue);
            this.label = StringUtils.defaultIfEmpty(newValue, null);
        }
        final String decriptionParamName = CodevalueJSONinputParams.DESCRIPTION.getValue();
        if (command.isChangeInStringParameterNamed(decriptionParamName, this.description)) {
            final String newValue = command.stringValueOfParameterNamed(decriptionParamName);
            actualChanges.put(decriptionParamName, newValue);
            this.description = StringUtils.defaultIfEmpty(newValue, null);
        }
        final String positionParamName = CodevalueJSONinputParams.POSITION.getValue();
        if (command.isChangeInIntegerSansLocaleParameterNamed(positionParamName, this.position)) {
            final Integer newValue = command.integerValueSansLocaleOfParameterNamed(positionParamName);
            actualChanges.put(positionParamName, newValue);
            this.position = newValue;
        }
        final String isActiveParamName = CodevalueJSONinputParams.IS_ACTIVE.getValue();
        if (command.isChangeInBooleanParameterNamed(isActiveParamName, this.isActive)) {
            final Boolean newValue = command.booleanPrimitiveValueOfParameterNamed(isActiveParamName);
            actualChanges.put(isActiveParamName, newValue);
            this.isActive = newValue;
        }
        return actualChanges;
    }

    public CodeValueData toData() {
        return CodeValueData.instance(getId(), this.label, this.description, this.position, this.isActive, this.mandatory);
    }

    @java.lang.SuppressWarnings("all")
        public String getLabel() {
        return this.label;
    }

    @java.lang.SuppressWarnings("all")
        public int getPosition() {
        return this.position;
    }

    @java.lang.SuppressWarnings("all")
        public String getDescription() {
        return this.description;
    }

    @java.lang.SuppressWarnings("all")
        public Code getCode() {
        return this.code;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isActive() {
        return this.isActive;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isMandatory() {
        return this.mandatory;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CodeValue setLabel(final String label) {
        this.label = label;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CodeValue setPosition(final int position) {
        this.position = position;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CodeValue setDescription(final String description) {
        this.description = description;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CodeValue setCode(final Code code) {
        this.code = code;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CodeValue setActive(final boolean isActive) {
        this.isActive = isActive;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CodeValue setMandatory(final boolean mandatory) {
        this.mandatory = mandatory;
        return this;
    }

    @java.lang.SuppressWarnings("all")
        public CodeValue() {
    }
}
