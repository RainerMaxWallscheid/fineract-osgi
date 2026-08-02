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
package org.apache.fineract.infrastructure.security.data;

import jakarta.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import org.apache.commons.lang3.time.StopWatch;

/**
 * Immutable data object representing platform API request used for logging/debugging.
 */
public final class PlatformRequestLog {
    @SuppressWarnings("unused")
    private long startTime;
    @SuppressWarnings("unused")
    private long totalTime;
    @SuppressWarnings("unused")
    private String method;
    @SuppressWarnings("unused")
    private String url;
    @SuppressWarnings("unused")
    private Map<String, String[]> parameters;

    public static PlatformRequestLog from(final StopWatch task, final HttpServletRequest request) throws IOException {
        final String requestUrl = request.getRequestURL().toString();
        final Map<String, String[]> parameters = new HashMap<>(request.getParameterMap());
        parameters.remove("password");
        parameters.remove("_");
        return new PlatformRequestLog().setStartTime(task.getStartInstant().toEpochMilli()).setTotalTime(task.getTime()).setMethod(request.getMethod()).setUrl(requestUrl).setParameters(parameters);
    }

    @java.lang.SuppressWarnings("all")
        public long getStartTime() {
        return this.startTime;
    }

    @java.lang.SuppressWarnings("all")
        public long getTotalTime() {
        return this.totalTime;
    }

    @java.lang.SuppressWarnings("all")
        public String getMethod() {
        return this.method;
    }

    @java.lang.SuppressWarnings("all")
        public String getUrl() {
        return this.url;
    }

    @java.lang.SuppressWarnings("all")
        public Map<String, String[]> getParameters() {
        return this.parameters;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public PlatformRequestLog setStartTime(final long startTime) {
        this.startTime = startTime;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public PlatformRequestLog setTotalTime(final long totalTime) {
        this.totalTime = totalTime;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public PlatformRequestLog setMethod(final String method) {
        this.method = method;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public PlatformRequestLog setUrl(final String url) {
        this.url = url;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public PlatformRequestLog setParameters(final Map<String, String[]> parameters) {
        this.parameters = parameters;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof PlatformRequestLog)) return false;
        final PlatformRequestLog other = (PlatformRequestLog) o;
        if (this.getStartTime() != other.getStartTime()) return false;
        if (this.getTotalTime() != other.getTotalTime()) return false;
        final java.lang.Object this$method = this.getMethod();
        final java.lang.Object other$method = other.getMethod();
        if (this$method == null ? other$method != null : !this$method.equals(other$method)) return false;
        final java.lang.Object this$url = this.getUrl();
        final java.lang.Object other$url = other.getUrl();
        if (this$url == null ? other$url != null : !this$url.equals(other$url)) return false;
        final java.lang.Object this$parameters = this.getParameters();
        final java.lang.Object other$parameters = other.getParameters();
        if (this$parameters == null ? other$parameters != null : !this$parameters.equals(other$parameters)) return false;
        return true;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final long $startTime = this.getStartTime();
        result = result * PRIME + (int) ($startTime >>> 32 ^ $startTime);
        final long $totalTime = this.getTotalTime();
        result = result * PRIME + (int) ($totalTime >>> 32 ^ $totalTime);
        final java.lang.Object $method = this.getMethod();
        result = result * PRIME + ($method == null ? 43 : $method.hashCode());
        final java.lang.Object $url = this.getUrl();
        result = result * PRIME + ($url == null ? 43 : $url.hashCode());
        final java.lang.Object $parameters = this.getParameters();
        result = result * PRIME + ($parameters == null ? 43 : $parameters.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "PlatformRequestLog(startTime=" + this.getStartTime() + ", totalTime=" + this.getTotalTime() + ", method=" + this.getMethod() + ", url=" + this.getUrl() + ", parameters=" + this.getParameters() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public PlatformRequestLog() {
    }
}
