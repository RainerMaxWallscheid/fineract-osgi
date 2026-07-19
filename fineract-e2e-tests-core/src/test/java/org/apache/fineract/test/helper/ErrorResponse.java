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
package org.apache.fineract.test.helper;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.IOException;
import java.util.List;
import org.apache.fineract.client.feign.ObjectMapperFactory;
import retrofit2.Response;

public class ErrorResponse {
    private static final ObjectMapper OBJECT_MAPPER = ObjectMapperFactory.getShared();
    private String developerMessage;
    private Integer httpStatusCode;
    private List<ErrorDetail> errors;

    public ErrorDetail getSingleError() {
        if (hasTopLevelErrorOnly()) {
            return createErrorFromDeveloperMessage();
        }
        if (errors == null || errors.isEmpty()) {
            if (this.developerMessage != null) {
                return createErrorFromDeveloperMessage();
            }
            throw new IllegalStateException("No errors found in response");
        }
        if (errors.size() != 1) {
            throw new IllegalStateException("Multiple errors found");
        }
        return errors.iterator().next();
    }

    private boolean hasTopLevelErrorOnly() {
        return this.httpStatusCode != null && this.httpStatusCode == 400 && this.developerMessage != null && this.developerMessage.contains("invalid") && (this.errors == null || this.errors.isEmpty());
    }

    private ErrorDetail createErrorFromDeveloperMessage() {
        ErrorDetail error = new ErrorDetail();
        error.setDeveloperMessage(this.developerMessage);
        return error;
    }

    public static ErrorResponse from(Response retrofitResponse) {
        try {
            String errorBody = retrofitResponse.errorBody().string();
            return OBJECT_MAPPER.readValue(errorBody, ErrorResponse.class);
        } catch (IOException e) {
            throw new RuntimeException("Error while parsing the error body", e);
        }
    }

    public static ErrorResponse fromFeignException(feign.FeignException feignException) {
        try {
            String errorBody = feignException.contentUTF8();
            return OBJECT_MAPPER.readValue(errorBody, ErrorResponse.class);
        } catch (JsonProcessingException e) {
            throw new RuntimeException("Error while parsing the error body", e);
        }
    }

    public static ErrorResponse fromFeignException(org.apache.fineract.client.feign.FeignException feignException) {
        try {
            String errorBody = feignException.responseBodyAsString();
            ErrorResponse errorResponse = OBJECT_MAPPER.readValue(errorBody, ErrorResponse.class);
            errorResponse.setHttpStatusCode(feignException.status());
            return errorResponse;
        } catch (JsonProcessingException e) {
            throw new RuntimeException("Error while parsing the error body", e);
        }
    }


    public static class ErrorDetail {
        private String developerMessage;
        private List<ErrorMessageArg> args;

        public String getDeveloperMessageWithoutPrefix() {
            if (developerMessage == null) {
                return null;
            }
            if (developerMessage.startsWith("[") && developerMessage.contains("] ")) {
                return developerMessage.substring(developerMessage.indexOf("] ") + 2);
            }
            return developerMessage;
        }

        @java.lang.SuppressWarnings("all")
                public ErrorDetail() {
        }

        @java.lang.SuppressWarnings("all")
                public String getDeveloperMessage() {
            return this.developerMessage;
        }

        @java.lang.SuppressWarnings("all")
                public List<ErrorMessageArg> getArgs() {
            return this.args;
        }

        @java.lang.SuppressWarnings("all")
                public void setDeveloperMessage(final String developerMessage) {
            this.developerMessage = developerMessage;
        }

        @java.lang.SuppressWarnings("all")
                public void setArgs(final List<ErrorMessageArg> args) {
            this.args = args;
        }
    }


    public static class ErrorMessageArg {
        private Object value;

        @java.lang.SuppressWarnings("all")
                public ErrorMessageArg() {
        }

        @java.lang.SuppressWarnings("all")
                public Object getValue() {
            return this.value;
        }

        @java.lang.SuppressWarnings("all")
                public void setValue(final Object value) {
            this.value = value;
        }
    }

    @java.lang.SuppressWarnings("all")
        public ErrorResponse() {
    }

    @java.lang.SuppressWarnings("all")
        public String getDeveloperMessage() {
        return this.developerMessage;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getHttpStatusCode() {
        return this.httpStatusCode;
    }

    @java.lang.SuppressWarnings("all")
        public List<ErrorDetail> getErrors() {
        return this.errors;
    }

    @java.lang.SuppressWarnings("all")
        public void setDeveloperMessage(final String developerMessage) {
        this.developerMessage = developerMessage;
    }

    @java.lang.SuppressWarnings("all")
        public void setHttpStatusCode(final Integer httpStatusCode) {
        this.httpStatusCode = httpStatusCode;
    }

    @java.lang.SuppressWarnings("all")
        public void setErrors(final List<ErrorDetail> errors) {
        this.errors = errors;
    }
}
