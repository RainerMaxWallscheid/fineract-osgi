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

public class SMTPCredentialsData {
    private String username;
    private String password;
    private String host;
    private String port;
    private boolean useTLS;
    private String fromEmail;
    private String fromName;

    public String getFromEmail() {
        return fromEmail != null ? fromEmail : username;
    }

    public String getFromName() {
        return fromName != null ? fromName : username;
    }

    @java.lang.SuppressWarnings("all")
        public String getUsername() {
        return this.username;
    }

    @java.lang.SuppressWarnings("all")
        public String getPassword() {
        return this.password;
    }

    @java.lang.SuppressWarnings("all")
        public String getHost() {
        return this.host;
    }

    @java.lang.SuppressWarnings("all")
        public String getPort() {
        return this.port;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isUseTLS() {
        return this.useTLS;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public SMTPCredentialsData setUsername(final String username) {
        this.username = username;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public SMTPCredentialsData setPassword(final String password) {
        this.password = password;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public SMTPCredentialsData setHost(final String host) {
        this.host = host;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public SMTPCredentialsData setPort(final String port) {
        this.port = port;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public SMTPCredentialsData setUseTLS(final boolean useTLS) {
        this.useTLS = useTLS;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public SMTPCredentialsData setFromEmail(final String fromEmail) {
        this.fromEmail = fromEmail;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public SMTPCredentialsData setFromName(final String fromName) {
        this.fromName = fromName;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof SMTPCredentialsData)) return false;
        final SMTPCredentialsData other = (SMTPCredentialsData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        if (this.isUseTLS() != other.isUseTLS()) return false;
        final java.lang.Object this$username = this.getUsername();
        final java.lang.Object other$username = other.getUsername();
        if (this$username == null ? other$username != null : !this$username.equals(other$username)) return false;
        final java.lang.Object this$password = this.getPassword();
        final java.lang.Object other$password = other.getPassword();
        if (this$password == null ? other$password != null : !this$password.equals(other$password)) return false;
        final java.lang.Object this$host = this.getHost();
        final java.lang.Object other$host = other.getHost();
        if (this$host == null ? other$host != null : !this$host.equals(other$host)) return false;
        final java.lang.Object this$port = this.getPort();
        final java.lang.Object other$port = other.getPort();
        if (this$port == null ? other$port != null : !this$port.equals(other$port)) return false;
        final java.lang.Object this$fromEmail = this.getFromEmail();
        final java.lang.Object other$fromEmail = other.getFromEmail();
        if (this$fromEmail == null ? other$fromEmail != null : !this$fromEmail.equals(other$fromEmail)) return false;
        final java.lang.Object this$fromName = this.getFromName();
        final java.lang.Object other$fromName = other.getFromName();
        if (this$fromName == null ? other$fromName != null : !this$fromName.equals(other$fromName)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof SMTPCredentialsData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        result = result * PRIME + (this.isUseTLS() ? 79 : 97);
        final java.lang.Object $username = this.getUsername();
        result = result * PRIME + ($username == null ? 43 : $username.hashCode());
        final java.lang.Object $password = this.getPassword();
        result = result * PRIME + ($password == null ? 43 : $password.hashCode());
        final java.lang.Object $host = this.getHost();
        result = result * PRIME + ($host == null ? 43 : $host.hashCode());
        final java.lang.Object $port = this.getPort();
        result = result * PRIME + ($port == null ? 43 : $port.hashCode());
        final java.lang.Object $fromEmail = this.getFromEmail();
        result = result * PRIME + ($fromEmail == null ? 43 : $fromEmail.hashCode());
        final java.lang.Object $fromName = this.getFromName();
        result = result * PRIME + ($fromName == null ? 43 : $fromName.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "SMTPCredentialsData(username=" + this.getUsername() + ", password=" + this.getPassword() + ", host=" + this.getHost() + ", port=" + this.getPort() + ", useTLS=" + this.isUseTLS() + ", fromEmail=" + this.getFromEmail() + ", fromName=" + this.getFromName() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public SMTPCredentialsData() {
    }
}
