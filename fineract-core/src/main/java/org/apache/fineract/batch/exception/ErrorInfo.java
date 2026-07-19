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
package org.apache.fineract.batch.exception;

import java.util.Set;
import org.apache.fineract.batch.domain.Header;
import org.apache.fineract.infrastructure.core.exception.ErrorHandler;

/**
 * Provides members to hold the basic information about the exceptions raised in commandStrategy classes.
 *
 * @author Rishabh Shukla
 *
 * @see ErrorHandler
 */
public final class ErrorInfo {
    private Integer statusCode;
    private Integer errorCode;
    private String message;
    private Set<Header> headers;

    @java.lang.SuppressWarnings("all")
        public Integer getStatusCode() {
        return this.statusCode;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getErrorCode() {
        return this.errorCode;
    }

    @java.lang.SuppressWarnings("all")
        public String getMessage() {
        return this.message;
    }

    @java.lang.SuppressWarnings("all")
        public Set<Header> getHeaders() {
        return this.headers;
    }

    @java.lang.SuppressWarnings("all")
        protected void setStatusCode(final Integer statusCode) {
        this.statusCode = statusCode;
    }

    @java.lang.SuppressWarnings("all")
        protected void setErrorCode(final Integer errorCode) {
        this.errorCode = errorCode;
    }

    @java.lang.SuppressWarnings("all")
        protected void setMessage(final String message) {
        this.message = message;
    }

    @java.lang.SuppressWarnings("all")
        protected void setHeaders(final Set<Header> headers) {
        this.headers = headers;
    }

    @java.lang.SuppressWarnings("all")
        protected ErrorInfo() {
    }

    @java.lang.SuppressWarnings("all")
        public ErrorInfo(final Integer statusCode, final Integer errorCode, final String message, final Set<Header> headers) {
        this.statusCode = statusCode;
        this.errorCode = errorCode;
        this.message = message;
        this.headers = headers;
    }
}
