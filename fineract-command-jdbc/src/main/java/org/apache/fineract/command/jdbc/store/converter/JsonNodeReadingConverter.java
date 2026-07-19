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
package org.apache.fineract.command.jdbc.store.converter;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.core.convert.converter.Converter;
import org.springframework.data.convert.ReadingConverter;
import org.springframework.stereotype.Component;

@Component
@ReadingConverter
public class JsonNodeReadingConverter implements Converter<String, JsonNode> {
    private final ObjectMapper mapper;

    @Override
    public JsonNode convert(String source) {
        try {
            return mapper.readTree(source);
        } catch (final java.lang.Throwable $ex) {
            throw new java.lang.RuntimeException($ex);
        }
    }

    @java.lang.SuppressWarnings("all")
        public JsonNodeReadingConverter(final ObjectMapper mapper) {
        this.mapper = mapper;
    }
}
