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
package org.apache.fineract.test.messaging;

import java.time.LocalDate;

public class EventMessage<T> {
    private final String type;
    private final LocalDate businessDate;
    private final T data;
    private final String idempotencyKey;

    @java.lang.SuppressWarnings("all")
        public EventMessage(final String type, final LocalDate businessDate, final T data, final String idempotencyKey) {
        this.type = type;
        this.businessDate = businessDate;
        this.data = data;
        this.idempotencyKey = idempotencyKey;
    }

    @java.lang.SuppressWarnings("all")
        public String getType() {
        return this.type;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getBusinessDate() {
        return this.businessDate;
    }

    @java.lang.SuppressWarnings("all")
        public T getData() {
        return this.data;
    }

    @java.lang.SuppressWarnings("all")
        public String getIdempotencyKey() {
        return this.idempotencyKey;
    }
}
