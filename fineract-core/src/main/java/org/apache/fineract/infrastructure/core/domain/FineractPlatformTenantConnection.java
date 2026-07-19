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

import java.io.Serializable;
import org.apache.commons.lang3.StringUtils;

/**
 * Holds Tenant's DB server connection connection details.
 */
@com.fasterxml.jackson.databind.annotation.JsonDeserialize(builder = FineractPlatformTenantConnection.FineractPlatformTenantConnectionBuilder.class)
public class FineractPlatformTenantConnection implements Serializable {
    private final Long connectionId;
    private final String schemaServer;
    private final String schemaServerPort;
    private final String schemaConnectionParameters;
    private final String schemaUsername;
    private final String schemaPassword;
    private final String schemaName;
    private final String readOnlySchemaServer;
    private final String readOnlySchemaServerPort;
    private final String readOnlySchemaName;
    private final String readOnlySchemaUsername;
    private final String readOnlySchemaPassword;
    private final String readOnlySchemaConnectionParameters;
    private final boolean autoUpdateEnabled;
    private final int initialSize;
    private final long validationInterval;
    private final boolean removeAbandoned;
    private final int removeAbandonedTimeout;
    private final boolean logAbandoned;
    private final int abandonWhenPercentageFull;
    private final int maxActive;
    private final int minIdle;
    private final int maxIdle;
    private final int suspectTimeout;
    private final int timeBetweenEvictionRunsMillis;
    private final int minEvictableIdleTimeMillis;
    private final boolean testOnBorrow;
    private final String masterPasswordHash;

    public FineractPlatformTenantConnection(final Long connectionId, final String schemaName, String schemaServer, final String schemaServerPort, final String schemaConnectionParameters, final String schemaUsername, final String schemaPassword, final boolean autoUpdateEnabled, final int initialSize, final long validationInterval, final boolean removeAbandoned, final int removeAbandonedTimeout, final boolean logAbandoned, final int abandonWhenPercentageFull, final int maxActive, final int minIdle, final int maxIdle, final int suspectTimeout, final int timeBetweenEvictionRunsMillis, final int minEvictableIdleTimeMillis, final boolean tesOnBorrow, final String readOnlySchemaServer, final String readOnlySchemaServerPort, final String readOnlySchemaName, final String readOnlySchemaUsername, final String readOnlySchemaPassword, final String readOnlySchemaConnectionParameters, final String masterPasswordHash) {
        this.connectionId = connectionId;
        this.schemaName = schemaName;
        this.schemaServer = schemaServer;
        this.schemaServerPort = schemaServerPort;
        this.schemaConnectionParameters = schemaConnectionParameters;
        this.schemaUsername = schemaUsername;
        this.schemaPassword = schemaPassword;
        this.autoUpdateEnabled = autoUpdateEnabled;
        this.initialSize = initialSize;
        this.validationInterval = validationInterval;
        this.removeAbandoned = removeAbandoned;
        this.removeAbandonedTimeout = removeAbandonedTimeout;
        this.logAbandoned = logAbandoned;
        this.abandonWhenPercentageFull = abandonWhenPercentageFull;
        this.maxActive = maxActive;
        this.minIdle = minIdle;
        this.maxIdle = maxIdle;
        this.suspectTimeout = suspectTimeout;
        this.timeBetweenEvictionRunsMillis = timeBetweenEvictionRunsMillis;
        this.minEvictableIdleTimeMillis = minEvictableIdleTimeMillis;
        this.testOnBorrow = tesOnBorrow;
        this.readOnlySchemaServer = readOnlySchemaServer;
        this.readOnlySchemaServerPort = readOnlySchemaServerPort;
        this.readOnlySchemaName = readOnlySchemaName;
        this.readOnlySchemaUsername = readOnlySchemaUsername;
        this.readOnlySchemaPassword = readOnlySchemaPassword;
        this.readOnlySchemaConnectionParameters = readOnlySchemaConnectionParameters;
        this.masterPasswordHash = masterPasswordHash;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder(this.schemaName).append(":").append(this.schemaServer).append(":").append(this.schemaServerPort);
        if (this.schemaConnectionParameters != null && !this.schemaConnectionParameters.isEmpty()) {
            sb.append('?').append(this.schemaConnectionParameters);
        }
        return sb.toString();
    }

    public static String toJdbcUrl(String protocol, String host, String port, String db, String parameters) {
        StringBuilder sb = new StringBuilder(protocol).append("://").append(host).append(":").append(port).append('/').append(db);
        if (!StringUtils.isEmpty(parameters)) {
            sb.append('?').append(parameters);
        }
        return sb.toString();
    }

    public static String resolveProtocol(String driver) {
        if ("org.postgresql.Driver".equals(driver)) {
            return "jdbc:postgresql";
        }
        if ("com.mysql.cj.jdbc.Driver".equals(driver)) {
            return "jdbc:mysql";
        }
        if ("org.mariadb.jdbc.Driver".equals(driver)) {
            return "jdbc:mariadb";
        }
        throw new IllegalStateException("Unsupported JDBC driver: " + driver);
    }


    @java.lang.SuppressWarnings("all")
        @com.fasterxml.jackson.databind.annotation.JsonPOJOBuilder(withPrefix = "", buildMethodName = "build")
    public static class FineractPlatformTenantConnectionBuilder {
        @java.lang.SuppressWarnings("all")
                private Long connectionId;
        @java.lang.SuppressWarnings("all")
                private String schemaServer;
        @java.lang.SuppressWarnings("all")
                private String schemaServerPort;
        @java.lang.SuppressWarnings("all")
                private String schemaConnectionParameters;
        @java.lang.SuppressWarnings("all")
                private String schemaUsername;
        @java.lang.SuppressWarnings("all")
                private String schemaPassword;
        @java.lang.SuppressWarnings("all")
                private String schemaName;
        @java.lang.SuppressWarnings("all")
                private String readOnlySchemaServer;
        @java.lang.SuppressWarnings("all")
                private String readOnlySchemaServerPort;
        @java.lang.SuppressWarnings("all")
                private String readOnlySchemaName;
        @java.lang.SuppressWarnings("all")
                private String readOnlySchemaUsername;
        @java.lang.SuppressWarnings("all")
                private String readOnlySchemaPassword;
        @java.lang.SuppressWarnings("all")
                private String readOnlySchemaConnectionParameters;
        @java.lang.SuppressWarnings("all")
                private boolean autoUpdateEnabled;
        @java.lang.SuppressWarnings("all")
                private int initialSize;
        @java.lang.SuppressWarnings("all")
                private long validationInterval;
        @java.lang.SuppressWarnings("all")
                private boolean removeAbandoned;
        @java.lang.SuppressWarnings("all")
                private int removeAbandonedTimeout;
        @java.lang.SuppressWarnings("all")
                private boolean logAbandoned;
        @java.lang.SuppressWarnings("all")
                private int abandonWhenPercentageFull;
        @java.lang.SuppressWarnings("all")
                private int maxActive;
        @java.lang.SuppressWarnings("all")
                private int minIdle;
        @java.lang.SuppressWarnings("all")
                private int maxIdle;
        @java.lang.SuppressWarnings("all")
                private int suspectTimeout;
        @java.lang.SuppressWarnings("all")
                private int timeBetweenEvictionRunsMillis;
        @java.lang.SuppressWarnings("all")
                private int minEvictableIdleTimeMillis;
        @java.lang.SuppressWarnings("all")
                private boolean testOnBorrow;
        @java.lang.SuppressWarnings("all")
                private String masterPasswordHash;

        @java.lang.SuppressWarnings("all")
                FineractPlatformTenantConnectionBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public FineractPlatformTenantConnection.FineractPlatformTenantConnectionBuilder connectionId(final Long connectionId) {
            this.connectionId = connectionId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public FineractPlatformTenantConnection.FineractPlatformTenantConnectionBuilder schemaServer(final String schemaServer) {
            this.schemaServer = schemaServer;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public FineractPlatformTenantConnection.FineractPlatformTenantConnectionBuilder schemaServerPort(final String schemaServerPort) {
            this.schemaServerPort = schemaServerPort;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public FineractPlatformTenantConnection.FineractPlatformTenantConnectionBuilder schemaConnectionParameters(final String schemaConnectionParameters) {
            this.schemaConnectionParameters = schemaConnectionParameters;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public FineractPlatformTenantConnection.FineractPlatformTenantConnectionBuilder schemaUsername(final String schemaUsername) {
            this.schemaUsername = schemaUsername;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public FineractPlatformTenantConnection.FineractPlatformTenantConnectionBuilder schemaPassword(final String schemaPassword) {
            this.schemaPassword = schemaPassword;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public FineractPlatformTenantConnection.FineractPlatformTenantConnectionBuilder schemaName(final String schemaName) {
            this.schemaName = schemaName;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public FineractPlatformTenantConnection.FineractPlatformTenantConnectionBuilder readOnlySchemaServer(final String readOnlySchemaServer) {
            this.readOnlySchemaServer = readOnlySchemaServer;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public FineractPlatformTenantConnection.FineractPlatformTenantConnectionBuilder readOnlySchemaServerPort(final String readOnlySchemaServerPort) {
            this.readOnlySchemaServerPort = readOnlySchemaServerPort;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public FineractPlatformTenantConnection.FineractPlatformTenantConnectionBuilder readOnlySchemaName(final String readOnlySchemaName) {
            this.readOnlySchemaName = readOnlySchemaName;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public FineractPlatformTenantConnection.FineractPlatformTenantConnectionBuilder readOnlySchemaUsername(final String readOnlySchemaUsername) {
            this.readOnlySchemaUsername = readOnlySchemaUsername;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public FineractPlatformTenantConnection.FineractPlatformTenantConnectionBuilder readOnlySchemaPassword(final String readOnlySchemaPassword) {
            this.readOnlySchemaPassword = readOnlySchemaPassword;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public FineractPlatformTenantConnection.FineractPlatformTenantConnectionBuilder readOnlySchemaConnectionParameters(final String readOnlySchemaConnectionParameters) {
            this.readOnlySchemaConnectionParameters = readOnlySchemaConnectionParameters;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public FineractPlatformTenantConnection.FineractPlatformTenantConnectionBuilder autoUpdateEnabled(final boolean autoUpdateEnabled) {
            this.autoUpdateEnabled = autoUpdateEnabled;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public FineractPlatformTenantConnection.FineractPlatformTenantConnectionBuilder initialSize(final int initialSize) {
            this.initialSize = initialSize;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public FineractPlatformTenantConnection.FineractPlatformTenantConnectionBuilder validationInterval(final long validationInterval) {
            this.validationInterval = validationInterval;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public FineractPlatformTenantConnection.FineractPlatformTenantConnectionBuilder removeAbandoned(final boolean removeAbandoned) {
            this.removeAbandoned = removeAbandoned;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public FineractPlatformTenantConnection.FineractPlatformTenantConnectionBuilder removeAbandonedTimeout(final int removeAbandonedTimeout) {
            this.removeAbandonedTimeout = removeAbandonedTimeout;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public FineractPlatformTenantConnection.FineractPlatformTenantConnectionBuilder logAbandoned(final boolean logAbandoned) {
            this.logAbandoned = logAbandoned;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public FineractPlatformTenantConnection.FineractPlatformTenantConnectionBuilder abandonWhenPercentageFull(final int abandonWhenPercentageFull) {
            this.abandonWhenPercentageFull = abandonWhenPercentageFull;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public FineractPlatformTenantConnection.FineractPlatformTenantConnectionBuilder maxActive(final int maxActive) {
            this.maxActive = maxActive;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public FineractPlatformTenantConnection.FineractPlatformTenantConnectionBuilder minIdle(final int minIdle) {
            this.minIdle = minIdle;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public FineractPlatformTenantConnection.FineractPlatformTenantConnectionBuilder maxIdle(final int maxIdle) {
            this.maxIdle = maxIdle;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public FineractPlatformTenantConnection.FineractPlatformTenantConnectionBuilder suspectTimeout(final int suspectTimeout) {
            this.suspectTimeout = suspectTimeout;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public FineractPlatformTenantConnection.FineractPlatformTenantConnectionBuilder timeBetweenEvictionRunsMillis(final int timeBetweenEvictionRunsMillis) {
            this.timeBetweenEvictionRunsMillis = timeBetweenEvictionRunsMillis;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public FineractPlatformTenantConnection.FineractPlatformTenantConnectionBuilder minEvictableIdleTimeMillis(final int minEvictableIdleTimeMillis) {
            this.minEvictableIdleTimeMillis = minEvictableIdleTimeMillis;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public FineractPlatformTenantConnection.FineractPlatformTenantConnectionBuilder testOnBorrow(final boolean testOnBorrow) {
            this.testOnBorrow = testOnBorrow;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public FineractPlatformTenantConnection.FineractPlatformTenantConnectionBuilder masterPasswordHash(final String masterPasswordHash) {
            this.masterPasswordHash = masterPasswordHash;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public FineractPlatformTenantConnection build() {
            return new FineractPlatformTenantConnection(this.connectionId, this.schemaServer, this.schemaServerPort, this.schemaConnectionParameters, this.schemaUsername, this.schemaPassword, this.schemaName, this.readOnlySchemaServer, this.readOnlySchemaServerPort, this.readOnlySchemaName, this.readOnlySchemaUsername, this.readOnlySchemaPassword, this.readOnlySchemaConnectionParameters, this.autoUpdateEnabled, this.initialSize, this.validationInterval, this.removeAbandoned, this.removeAbandonedTimeout, this.logAbandoned, this.abandonWhenPercentageFull, this.maxActive, this.minIdle, this.maxIdle, this.suspectTimeout, this.timeBetweenEvictionRunsMillis, this.minEvictableIdleTimeMillis, this.testOnBorrow, this.masterPasswordHash);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "FineractPlatformTenantConnection.FineractPlatformTenantConnectionBuilder(connectionId=" + this.connectionId + ", schemaServer=" + this.schemaServer + ", schemaServerPort=" + this.schemaServerPort + ", schemaConnectionParameters=" + this.schemaConnectionParameters + ", schemaUsername=" + this.schemaUsername + ", schemaPassword=" + this.schemaPassword + ", schemaName=" + this.schemaName + ", readOnlySchemaServer=" + this.readOnlySchemaServer + ", readOnlySchemaServerPort=" + this.readOnlySchemaServerPort + ", readOnlySchemaName=" + this.readOnlySchemaName + ", readOnlySchemaUsername=" + this.readOnlySchemaUsername + ", readOnlySchemaPassword=" + this.readOnlySchemaPassword + ", readOnlySchemaConnectionParameters=" + this.readOnlySchemaConnectionParameters + ", autoUpdateEnabled=" + this.autoUpdateEnabled + ", initialSize=" + this.initialSize + ", validationInterval=" + this.validationInterval + ", removeAbandoned=" + this.removeAbandoned + ", removeAbandonedTimeout=" + this.removeAbandonedTimeout + ", logAbandoned=" + this.logAbandoned + ", abandonWhenPercentageFull=" + this.abandonWhenPercentageFull + ", maxActive=" + this.maxActive + ", minIdle=" + this.minIdle + ", maxIdle=" + this.maxIdle + ", suspectTimeout=" + this.suspectTimeout + ", timeBetweenEvictionRunsMillis=" + this.timeBetweenEvictionRunsMillis + ", minEvictableIdleTimeMillis=" + this.minEvictableIdleTimeMillis + ", testOnBorrow=" + this.testOnBorrow + ", masterPasswordHash=" + this.masterPasswordHash + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static FineractPlatformTenantConnection.FineractPlatformTenantConnectionBuilder builder() {
        return new FineractPlatformTenantConnection.FineractPlatformTenantConnectionBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public Long getConnectionId() {
        return this.connectionId;
    }

    @java.lang.SuppressWarnings("all")
        public String getSchemaServer() {
        return this.schemaServer;
    }

    @java.lang.SuppressWarnings("all")
        public String getSchemaServerPort() {
        return this.schemaServerPort;
    }

    @java.lang.SuppressWarnings("all")
        public String getSchemaConnectionParameters() {
        return this.schemaConnectionParameters;
    }

    @java.lang.SuppressWarnings("all")
        public String getSchemaUsername() {
        return this.schemaUsername;
    }

    @java.lang.SuppressWarnings("all")
        public String getSchemaPassword() {
        return this.schemaPassword;
    }

    @java.lang.SuppressWarnings("all")
        public String getSchemaName() {
        return this.schemaName;
    }

    @java.lang.SuppressWarnings("all")
        public String getReadOnlySchemaServer() {
        return this.readOnlySchemaServer;
    }

    @java.lang.SuppressWarnings("all")
        public String getReadOnlySchemaServerPort() {
        return this.readOnlySchemaServerPort;
    }

    @java.lang.SuppressWarnings("all")
        public String getReadOnlySchemaName() {
        return this.readOnlySchemaName;
    }

    @java.lang.SuppressWarnings("all")
        public String getReadOnlySchemaUsername() {
        return this.readOnlySchemaUsername;
    }

    @java.lang.SuppressWarnings("all")
        public String getReadOnlySchemaPassword() {
        return this.readOnlySchemaPassword;
    }

    @java.lang.SuppressWarnings("all")
        public String getReadOnlySchemaConnectionParameters() {
        return this.readOnlySchemaConnectionParameters;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isAutoUpdateEnabled() {
        return this.autoUpdateEnabled;
    }

    @java.lang.SuppressWarnings("all")
        public int getInitialSize() {
        return this.initialSize;
    }

    @java.lang.SuppressWarnings("all")
        public long getValidationInterval() {
        return this.validationInterval;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isRemoveAbandoned() {
        return this.removeAbandoned;
    }

    @java.lang.SuppressWarnings("all")
        public int getRemoveAbandonedTimeout() {
        return this.removeAbandonedTimeout;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isLogAbandoned() {
        return this.logAbandoned;
    }

    @java.lang.SuppressWarnings("all")
        public int getAbandonWhenPercentageFull() {
        return this.abandonWhenPercentageFull;
    }

    @java.lang.SuppressWarnings("all")
        public int getMaxActive() {
        return this.maxActive;
    }

    @java.lang.SuppressWarnings("all")
        public int getMinIdle() {
        return this.minIdle;
    }

    @java.lang.SuppressWarnings("all")
        public int getMaxIdle() {
        return this.maxIdle;
    }

    @java.lang.SuppressWarnings("all")
        public int getSuspectTimeout() {
        return this.suspectTimeout;
    }

    @java.lang.SuppressWarnings("all")
        public int getTimeBetweenEvictionRunsMillis() {
        return this.timeBetweenEvictionRunsMillis;
    }

    @java.lang.SuppressWarnings("all")
        public int getMinEvictableIdleTimeMillis() {
        return this.minEvictableIdleTimeMillis;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isTestOnBorrow() {
        return this.testOnBorrow;
    }

    @java.lang.SuppressWarnings("all")
        public String getMasterPasswordHash() {
        return this.masterPasswordHash;
    }

    @java.lang.SuppressWarnings("all")
        public FineractPlatformTenantConnection(final Long connectionId, final String schemaServer, final String schemaServerPort, final String schemaConnectionParameters, final String schemaUsername, final String schemaPassword, final String schemaName, final String readOnlySchemaServer, final String readOnlySchemaServerPort, final String readOnlySchemaName, final String readOnlySchemaUsername, final String readOnlySchemaPassword, final String readOnlySchemaConnectionParameters, final boolean autoUpdateEnabled, final int initialSize, final long validationInterval, final boolean removeAbandoned, final int removeAbandonedTimeout, final boolean logAbandoned, final int abandonWhenPercentageFull, final int maxActive, final int minIdle, final int maxIdle, final int suspectTimeout, final int timeBetweenEvictionRunsMillis, final int minEvictableIdleTimeMillis, final boolean testOnBorrow, final String masterPasswordHash) {
        this.connectionId = connectionId;
        this.schemaServer = schemaServer;
        this.schemaServerPort = schemaServerPort;
        this.schemaConnectionParameters = schemaConnectionParameters;
        this.schemaUsername = schemaUsername;
        this.schemaPassword = schemaPassword;
        this.schemaName = schemaName;
        this.readOnlySchemaServer = readOnlySchemaServer;
        this.readOnlySchemaServerPort = readOnlySchemaServerPort;
        this.readOnlySchemaName = readOnlySchemaName;
        this.readOnlySchemaUsername = readOnlySchemaUsername;
        this.readOnlySchemaPassword = readOnlySchemaPassword;
        this.readOnlySchemaConnectionParameters = readOnlySchemaConnectionParameters;
        this.autoUpdateEnabled = autoUpdateEnabled;
        this.initialSize = initialSize;
        this.validationInterval = validationInterval;
        this.removeAbandoned = removeAbandoned;
        this.removeAbandonedTimeout = removeAbandonedTimeout;
        this.logAbandoned = logAbandoned;
        this.abandonWhenPercentageFull = abandonWhenPercentageFull;
        this.maxActive = maxActive;
        this.minIdle = minIdle;
        this.maxIdle = maxIdle;
        this.suspectTimeout = suspectTimeout;
        this.timeBetweenEvictionRunsMillis = timeBetweenEvictionRunsMillis;
        this.minEvictableIdleTimeMillis = minEvictableIdleTimeMillis;
        this.testOnBorrow = testOnBorrow;
        this.masterPasswordHash = masterPasswordHash;
    }
}
