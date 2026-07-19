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
package org.apache.fineract.infrastructure.contentstore.processor;

import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;

public final class ContentProcessorContext {
    @java.lang.SuppressWarnings("all")
        private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(ContentProcessorContext.class);
    private final InputStream inputStream;
    private final Map<String, Object> parameters;
    private final Map<String, Object> results;

    public ContentProcessorContext(InputStream inputStream) {
        this(inputStream, Map.of(), new HashMap<>());
    }

    public ContentProcessorContext(InputStream inputStream, Map<String, Object> parameters) {
        this(inputStream, parameters, new HashMap<>());
    }

    ContentProcessorContext(InputStream inputStream, Map<String, Object> parameters, Map<String, Object> results) {
        this.inputStream = inputStream;
        this.parameters = parameters;
        this.results = results;
    }

    public <R> R getParameter(String key, Class<R> type) {
        return getParameter(key, type, null);
    }

    public <R> R getParameter(String key, Class<R> type, R defaultValue) {
        final var val = parameters.get(key);
        return type != null && val != null ? type.cast(val) : defaultValue;
    }

    public void setResult(String key, Object value) {
        results.put(key, value);
    }

    public <R> R getResult(String key, Class<R> type) {
        return getResult(key, type, null);
    }

    public <R> R getResult(String key, Class<R> type, R defaultValue) {
        final var val = results.get(key);
        return type != null && val != null ? type.cast(val) : defaultValue;
    }

    public ContentProcessorContext clone(InputStream inputStream) {
        return new ContentProcessorContext(inputStream, this.parameters, this.results);
    }

    @java.lang.SuppressWarnings("all")
        public InputStream getInputStream() {
        return this.inputStream;
    }

    @java.lang.SuppressWarnings("all")
        public Map<String, Object> getParameters() {
        return this.parameters;
    }

    @java.lang.SuppressWarnings("all")
        public Map<String, Object> getResults() {
        return this.results;
    }
}
