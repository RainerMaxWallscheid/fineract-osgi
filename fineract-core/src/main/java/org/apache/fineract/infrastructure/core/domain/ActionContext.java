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
package org.apache.fineract.infrastructure.core.domain;

import org.apache.fineract.infrastructure.businessdate.domain.BusinessDateType;

public enum ActionContext {
    DEFAULT(0, "Default context", BusinessDateType.BUSINESS_DATE),  //
    COB(1, "Close of Business context", BusinessDateType.COB_DATE);
    //
    private final int order;
    private final String description;
    private final BusinessDateType businessDateType;

    @java.lang.SuppressWarnings("all")
        public int getOrder() {
        return this.order;
    }

    @java.lang.SuppressWarnings("all")
        public String getDescription() {
        return this.description;
    }

    @java.lang.SuppressWarnings("all")
        public BusinessDateType getBusinessDateType() {
        return this.businessDateType;
    }

    @java.lang.SuppressWarnings("all")
        private ActionContext(final int order, final String description, final BusinessDateType businessDateType) {
        this.order = order;
        this.description = description;
        this.businessDateType = businessDateType;
    }
}
