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
package org.apache.fineract.infrastructure.core.config;

import java.io.Serial;
import java.io.Serializable;
import java.time.Duration;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.commons.lang3.StringUtils;
import org.apache.fineract.infrastructure.security.domain.OidcFederationType;
import org.springframework.boot.context.properties.ConfigurationProperties;

@ConfigurationProperties(prefix = "fineract")
public class FineractProperties {
    private String nodeId;
    private String idempotencyKeyHeaderName;
    private Boolean insecureHttpClient;
    private long clientConnectTimeout;
    private long clientReadTimeout;
    private long clientWriteTimeout;
    private FineractTenantProperties tenant;
    private FineractModeProperties mode;
    private FineractCorrelationProperties correlation;
    private FineractIpTrackingProperties ipTracking;
    private FineractPartitionedJob partitionedJob;
    private FineractRemoteJobMessageHandlerProperties remoteJobMessageHandler;
    private FineractEventsProperties events;
    private FineractTaskExecutor taskExecutor;
    private FineractContentProperties content;
    private FineractReportProperties report;
    private FineractJobProperties job;
    private FineractTemplateProperties template;
    private FineractJpaProperties jpa;
    private FineractDatabaseProperties database;
    private FineractQueryProperties query;
    private FineractApiProperties api;
    private FineractSecurityProperties security;
    private FineractNotificationProperties notification;
    private FineractLoanProperties loan;
    private FineractSamplingProperties sampling;
    private FineractModulesProperties module;
    private FineractSqlValidationProperties sqlValidation;
    private FineractInputValidationProperties inputValidation;
    private FineractCache cache;
    private RetryProperties retry;
    private FineractDefaultValues defaults;


    public static class FineractTenantProperties {
        private String host;
        private Integer port;
        private String username;
        private String password;
        private String parameters;
        private String timezone;
        private String identifier;
        private String name;
        private String description;
        private String masterPassword;
        private String encryption;
        private String readOnlyHost;
        private Integer readOnlyPort;
        private String readOnlyUsername;
        private String readOnlyPassword;
        private String readOnlyParameters;
        private String readOnlyName;
        private FineractConfigProperties config;

        @java.lang.SuppressWarnings("all")
                public String getHost() {
            return this.host;
        }

        @java.lang.SuppressWarnings("all")
                public Integer getPort() {
            return this.port;
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
                public String getParameters() {
            return this.parameters;
        }

        @java.lang.SuppressWarnings("all")
                public String getTimezone() {
            return this.timezone;
        }

        @java.lang.SuppressWarnings("all")
                public String getIdentifier() {
            return this.identifier;
        }

        @java.lang.SuppressWarnings("all")
                public String getName() {
            return this.name;
        }

        @java.lang.SuppressWarnings("all")
                public String getDescription() {
            return this.description;
        }

        @java.lang.SuppressWarnings("all")
                public String getMasterPassword() {
            return this.masterPassword;
        }

        @java.lang.SuppressWarnings("all")
                public String getEncryption() {
            return this.encryption;
        }

        @java.lang.SuppressWarnings("all")
                public String getReadOnlyHost() {
            return this.readOnlyHost;
        }

        @java.lang.SuppressWarnings("all")
                public Integer getReadOnlyPort() {
            return this.readOnlyPort;
        }

        @java.lang.SuppressWarnings("all")
                public String getReadOnlyUsername() {
            return this.readOnlyUsername;
        }

        @java.lang.SuppressWarnings("all")
                public String getReadOnlyPassword() {
            return this.readOnlyPassword;
        }

        @java.lang.SuppressWarnings("all")
                public String getReadOnlyParameters() {
            return this.readOnlyParameters;
        }

        @java.lang.SuppressWarnings("all")
                public String getReadOnlyName() {
            return this.readOnlyName;
        }

        @java.lang.SuppressWarnings("all")
                public FineractConfigProperties getConfig() {
            return this.config;
        }

        @java.lang.SuppressWarnings("all")
                public void setHost(final String host) {
            this.host = host;
        }

        @java.lang.SuppressWarnings("all")
                public void setPort(final Integer port) {
            this.port = port;
        }

        @java.lang.SuppressWarnings("all")
                public void setUsername(final String username) {
            this.username = username;
        }

        @java.lang.SuppressWarnings("all")
                public void setPassword(final String password) {
            this.password = password;
        }

        @java.lang.SuppressWarnings("all")
                public void setParameters(final String parameters) {
            this.parameters = parameters;
        }

        @java.lang.SuppressWarnings("all")
                public void setTimezone(final String timezone) {
            this.timezone = timezone;
        }

        @java.lang.SuppressWarnings("all")
                public void setIdentifier(final String identifier) {
            this.identifier = identifier;
        }

        @java.lang.SuppressWarnings("all")
                public void setName(final String name) {
            this.name = name;
        }

        @java.lang.SuppressWarnings("all")
                public void setDescription(final String description) {
            this.description = description;
        }

        @java.lang.SuppressWarnings("all")
                public void setMasterPassword(final String masterPassword) {
            this.masterPassword = masterPassword;
        }

        @java.lang.SuppressWarnings("all")
                public void setEncryption(final String encryption) {
            this.encryption = encryption;
        }

        @java.lang.SuppressWarnings("all")
                public void setReadOnlyHost(final String readOnlyHost) {
            this.readOnlyHost = readOnlyHost;
        }

        @java.lang.SuppressWarnings("all")
                public void setReadOnlyPort(final Integer readOnlyPort) {
            this.readOnlyPort = readOnlyPort;
        }

        @java.lang.SuppressWarnings("all")
                public void setReadOnlyUsername(final String readOnlyUsername) {
            this.readOnlyUsername = readOnlyUsername;
        }

        @java.lang.SuppressWarnings("all")
                public void setReadOnlyPassword(final String readOnlyPassword) {
            this.readOnlyPassword = readOnlyPassword;
        }

        @java.lang.SuppressWarnings("all")
                public void setReadOnlyParameters(final String readOnlyParameters) {
            this.readOnlyParameters = readOnlyParameters;
        }

        @java.lang.SuppressWarnings("all")
                public void setReadOnlyName(final String readOnlyName) {
            this.readOnlyName = readOnlyName;
        }

        @java.lang.SuppressWarnings("all")
                public void setConfig(final FineractConfigProperties config) {
            this.config = config;
        }
    }


    /**
     * Configuration properties to override configurations stored in the tenants database
     */
    public static class FineractConfigProperties {
        private int minPoolSize;
        private int maxPoolSize;
        private long leakDetectionThreshold;

        public boolean isMinPoolSizeSet() {
            return minPoolSize != -1;
        }

        public boolean isMaxPoolSizeSet() {
            return maxPoolSize != -1;
        }

        public boolean isLeakDetectionThresholdSet() {
            return leakDetectionThreshold > 0;
        }

        @java.lang.SuppressWarnings("all")
                public int getMinPoolSize() {
            return this.minPoolSize;
        }

        @java.lang.SuppressWarnings("all")
                public int getMaxPoolSize() {
            return this.maxPoolSize;
        }

        @java.lang.SuppressWarnings("all")
                public long getLeakDetectionThreshold() {
            return this.leakDetectionThreshold;
        }

        @java.lang.SuppressWarnings("all")
                public void setMinPoolSize(final int minPoolSize) {
            this.minPoolSize = minPoolSize;
        }

        @java.lang.SuppressWarnings("all")
                public void setMaxPoolSize(final int maxPoolSize) {
            this.maxPoolSize = maxPoolSize;
        }

        @java.lang.SuppressWarnings("all")
                public void setLeakDetectionThreshold(final long leakDetectionThreshold) {
            this.leakDetectionThreshold = leakDetectionThreshold;
        }
    }


    public static class FineractModeProperties {
        private boolean readEnabled;
        private boolean writeEnabled;
        private boolean batchWorkerEnabled;
        private boolean batchManagerEnabled;

        public boolean isReadOnlyMode() {
            return readEnabled && !writeEnabled && !batchWorkerEnabled && !batchManagerEnabled;
        }

        @java.lang.SuppressWarnings("all")
                public boolean isReadEnabled() {
            return this.readEnabled;
        }

        @java.lang.SuppressWarnings("all")
                public boolean isWriteEnabled() {
            return this.writeEnabled;
        }

        @java.lang.SuppressWarnings("all")
                public boolean isBatchWorkerEnabled() {
            return this.batchWorkerEnabled;
        }

        @java.lang.SuppressWarnings("all")
                public boolean isBatchManagerEnabled() {
            return this.batchManagerEnabled;
        }

        @java.lang.SuppressWarnings("all")
                public void setReadEnabled(final boolean readEnabled) {
            this.readEnabled = readEnabled;
        }

        @java.lang.SuppressWarnings("all")
                public void setWriteEnabled(final boolean writeEnabled) {
            this.writeEnabled = writeEnabled;
        }

        @java.lang.SuppressWarnings("all")
                public void setBatchWorkerEnabled(final boolean batchWorkerEnabled) {
            this.batchWorkerEnabled = batchWorkerEnabled;
        }

        @java.lang.SuppressWarnings("all")
                public void setBatchManagerEnabled(final boolean batchManagerEnabled) {
            this.batchManagerEnabled = batchManagerEnabled;
        }
    }


    public static class FineractCorrelationProperties {
        private boolean enabled;
        private String headerName;

        @java.lang.SuppressWarnings("all")
                public boolean isEnabled() {
            return this.enabled;
        }

        @java.lang.SuppressWarnings("all")
                public String getHeaderName() {
            return this.headerName;
        }

        @java.lang.SuppressWarnings("all")
                public void setEnabled(final boolean enabled) {
            this.enabled = enabled;
        }

        @java.lang.SuppressWarnings("all")
                public void setHeaderName(final String headerName) {
            this.headerName = headerName;
        }
    }


    public static class FineractIpTrackingProperties {
        private boolean enabled;

        @java.lang.SuppressWarnings("all")
                public boolean isEnabled() {
            return this.enabled;
        }

        @java.lang.SuppressWarnings("all")
                public void setEnabled(final boolean enabled) {
            this.enabled = enabled;
        }
    }


    public static class FineractPartitionedJob {
        // TODO should be used without wrapper class
        private List<PartitionedJobProperty> partitionedJobProperties;

        @java.lang.SuppressWarnings("all")
                public List<PartitionedJobProperty> getPartitionedJobProperties() {
            return this.partitionedJobProperties;
        }

        @java.lang.SuppressWarnings("all")
                public void setPartitionedJobProperties(final List<PartitionedJobProperty> partitionedJobProperties) {
            this.partitionedJobProperties = partitionedJobProperties;
        }
    }


    public static class PartitionedJobProperty {
        private String jobName;
        private Integer chunkSize;
        private Integer partitionSize;
        private Integer threadPoolCorePoolSize;
        private Integer threadPoolMaxPoolSize;
        private Integer threadPoolQueueCapacity;
        private Integer retryLimit;
        private Integer pollInterval;

        @java.lang.SuppressWarnings("all")
                public String getJobName() {
            return this.jobName;
        }

        @java.lang.SuppressWarnings("all")
                public Integer getChunkSize() {
            return this.chunkSize;
        }

        @java.lang.SuppressWarnings("all")
                public Integer getPartitionSize() {
            return this.partitionSize;
        }

        @java.lang.SuppressWarnings("all")
                public Integer getThreadPoolCorePoolSize() {
            return this.threadPoolCorePoolSize;
        }

        @java.lang.SuppressWarnings("all")
                public Integer getThreadPoolMaxPoolSize() {
            return this.threadPoolMaxPoolSize;
        }

        @java.lang.SuppressWarnings("all")
                public Integer getThreadPoolQueueCapacity() {
            return this.threadPoolQueueCapacity;
        }

        @java.lang.SuppressWarnings("all")
                public Integer getRetryLimit() {
            return this.retryLimit;
        }

        @java.lang.SuppressWarnings("all")
                public Integer getPollInterval() {
            return this.pollInterval;
        }

        @java.lang.SuppressWarnings("all")
                public void setJobName(final String jobName) {
            this.jobName = jobName;
        }

        @java.lang.SuppressWarnings("all")
                public void setChunkSize(final Integer chunkSize) {
            this.chunkSize = chunkSize;
        }

        @java.lang.SuppressWarnings("all")
                public void setPartitionSize(final Integer partitionSize) {
            this.partitionSize = partitionSize;
        }

        @java.lang.SuppressWarnings("all")
                public void setThreadPoolCorePoolSize(final Integer threadPoolCorePoolSize) {
            this.threadPoolCorePoolSize = threadPoolCorePoolSize;
        }

        @java.lang.SuppressWarnings("all")
                public void setThreadPoolMaxPoolSize(final Integer threadPoolMaxPoolSize) {
            this.threadPoolMaxPoolSize = threadPoolMaxPoolSize;
        }

        @java.lang.SuppressWarnings("all")
                public void setThreadPoolQueueCapacity(final Integer threadPoolQueueCapacity) {
            this.threadPoolQueueCapacity = threadPoolQueueCapacity;
        }

        @java.lang.SuppressWarnings("all")
                public void setRetryLimit(final Integer retryLimit) {
            this.retryLimit = retryLimit;
        }

        @java.lang.SuppressWarnings("all")
                public void setPollInterval(final Integer pollInterval) {
            this.pollInterval = pollInterval;
        }
    }


    public static class FineractRemoteJobMessageHandlerProperties {
        private FineractRemoteJobMessageHandlerSpringEventsProperties springEvents;
        private FineractRemoteJobMessageHandlerJmsProperties jms;
        private FineractRemoteJobMessageHandlerKafkaProperties kafka;

        @java.lang.SuppressWarnings("all")
                public FineractRemoteJobMessageHandlerSpringEventsProperties getSpringEvents() {
            return this.springEvents;
        }

        @java.lang.SuppressWarnings("all")
                public FineractRemoteJobMessageHandlerJmsProperties getJms() {
            return this.jms;
        }

        @java.lang.SuppressWarnings("all")
                public FineractRemoteJobMessageHandlerKafkaProperties getKafka() {
            return this.kafka;
        }

        @java.lang.SuppressWarnings("all")
                public void setSpringEvents(final FineractRemoteJobMessageHandlerSpringEventsProperties springEvents) {
            this.springEvents = springEvents;
        }

        @java.lang.SuppressWarnings("all")
                public void setJms(final FineractRemoteJobMessageHandlerJmsProperties jms) {
            this.jms = jms;
        }

        @java.lang.SuppressWarnings("all")
                public void setKafka(final FineractRemoteJobMessageHandlerKafkaProperties kafka) {
            this.kafka = kafka;
        }
    }


    public static class FineractRemoteJobMessageHandlerSpringEventsProperties {
        private boolean enabled;

        @java.lang.SuppressWarnings("all")
                public boolean isEnabled() {
            return this.enabled;
        }

        @java.lang.SuppressWarnings("all")
                public void setEnabled(final boolean enabled) {
            this.enabled = enabled;
        }
    }


    public static class FineractRemoteJobMessageHandlerJmsProperties {
        private boolean enabled;
        private String requestQueueName;
        private String brokerUrl;
        private String brokerUsername;
        private String brokerPassword;

        public boolean isBrokerPasswordProtected() {
            return StringUtils.isNotBlank(brokerUsername) || StringUtils.isNotBlank(brokerPassword);
        }

        @java.lang.SuppressWarnings("all")
                public boolean isEnabled() {
            return this.enabled;
        }

        @java.lang.SuppressWarnings("all")
                public String getRequestQueueName() {
            return this.requestQueueName;
        }

        @java.lang.SuppressWarnings("all")
                public String getBrokerUrl() {
            return this.brokerUrl;
        }

        @java.lang.SuppressWarnings("all")
                public String getBrokerUsername() {
            return this.brokerUsername;
        }

        @java.lang.SuppressWarnings("all")
                public String getBrokerPassword() {
            return this.brokerPassword;
        }

        @java.lang.SuppressWarnings("all")
                public void setEnabled(final boolean enabled) {
            this.enabled = enabled;
        }

        @java.lang.SuppressWarnings("all")
                public void setRequestQueueName(final String requestQueueName) {
            this.requestQueueName = requestQueueName;
        }

        @java.lang.SuppressWarnings("all")
                public void setBrokerUrl(final String brokerUrl) {
            this.brokerUrl = brokerUrl;
        }

        @java.lang.SuppressWarnings("all")
                public void setBrokerUsername(final String brokerUsername) {
            this.brokerUsername = brokerUsername;
        }

        @java.lang.SuppressWarnings("all")
                public void setBrokerPassword(final String brokerPassword) {
            this.brokerPassword = brokerPassword;
        }
    }


    public static class FineractRemoteJobMessageHandlerKafkaProperties {
        private boolean enabled;
        private String bootstrapServers;
        private KafkaTopicProperties topic;
        private KafkaConsumerProperties consumer;
        private KafkaProperties producer;
        private KafkaProperties admin;

        @java.lang.SuppressWarnings("all")
                public boolean isEnabled() {
            return this.enabled;
        }

        @java.lang.SuppressWarnings("all")
                public String getBootstrapServers() {
            return this.bootstrapServers;
        }

        @java.lang.SuppressWarnings("all")
                public KafkaTopicProperties getTopic() {
            return this.topic;
        }

        @java.lang.SuppressWarnings("all")
                public KafkaConsumerProperties getConsumer() {
            return this.consumer;
        }

        @java.lang.SuppressWarnings("all")
                public KafkaProperties getProducer() {
            return this.producer;
        }

        @java.lang.SuppressWarnings("all")
                public KafkaProperties getAdmin() {
            return this.admin;
        }

        @java.lang.SuppressWarnings("all")
                public void setEnabled(final boolean enabled) {
            this.enabled = enabled;
        }

        @java.lang.SuppressWarnings("all")
                public void setBootstrapServers(final String bootstrapServers) {
            this.bootstrapServers = bootstrapServers;
        }

        @java.lang.SuppressWarnings("all")
                public void setTopic(final KafkaTopicProperties topic) {
            this.topic = topic;
        }

        @java.lang.SuppressWarnings("all")
                public void setConsumer(final KafkaConsumerProperties consumer) {
            this.consumer = consumer;
        }

        @java.lang.SuppressWarnings("all")
                public void setProducer(final KafkaProperties producer) {
            this.producer = producer;
        }

        @java.lang.SuppressWarnings("all")
                public void setAdmin(final KafkaProperties admin) {
            this.admin = admin;
        }
    }


    public static class KafkaTopicProperties {
        private boolean autoCreate;
        private String name;
        private int replicas;
        private int partitions;

        @java.lang.SuppressWarnings("all")
                public boolean isAutoCreate() {
            return this.autoCreate;
        }

        @java.lang.SuppressWarnings("all")
                public String getName() {
            return this.name;
        }

        @java.lang.SuppressWarnings("all")
                public int getReplicas() {
            return this.replicas;
        }

        @java.lang.SuppressWarnings("all")
                public int getPartitions() {
            return this.partitions;
        }

        @java.lang.SuppressWarnings("all")
                public void setAutoCreate(final boolean autoCreate) {
            this.autoCreate = autoCreate;
        }

        @java.lang.SuppressWarnings("all")
                public void setName(final String name) {
            this.name = name;
        }

        @java.lang.SuppressWarnings("all")
                public void setReplicas(final int replicas) {
            this.replicas = replicas;
        }

        @java.lang.SuppressWarnings("all")
                public void setPartitions(final int partitions) {
            this.partitions = partitions;
        }
    }


    public static class KafkaConsumerProperties extends KafkaProperties {
        private String groupId;

        @java.lang.SuppressWarnings("all")
                public String getGroupId() {
            return this.groupId;
        }

        @java.lang.SuppressWarnings("all")
                public void setGroupId(final String groupId) {
            this.groupId = groupId;
        }
    }


    public static class KafkaProperties {
        @java.lang.SuppressWarnings("all")
                private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(KafkaProperties.class);
        private String extraPropertiesKeyValueSeparator;
        private String extraPropertiesSeparator;
        private String extraProperties;

        public Map<String, String> getExtraPropertiesMap() {
            Map<String, String> map = new HashMap<>();
            if (StringUtils.isNotEmpty(getExtraProperties()) && validateSeparators()) {
                String[] lines = StringUtils.split(getExtraProperties(), extraPropertiesSeparator);
                Arrays.stream(lines).forEach(line -> {
                    String[] keyAndValue = StringUtils.split(line, extraPropertiesKeyValueSeparator);
                    if (keyAndValue.length == 2) {
                        map.put(keyAndValue[0], keyAndValue[1]);
                    } else {
                        log.warn("Invalid property: {}", line);
                    }
                });
            }
            return map;
        }

        private boolean validateSeparators() {
            boolean valid = (StringUtils.isNotEmpty(extraPropertiesSeparator) && extraPropertiesSeparator.length() == 1 && StringUtils.isNotEmpty(extraPropertiesKeyValueSeparator) && extraPropertiesKeyValueSeparator.length() == 1 && !extraPropertiesSeparator.equals(extraPropertiesKeyValueSeparator));
            if (!valid) {
                log.warn("Invalid KafkaProperties configuration, lineSeparator \'{}\' and keyValueSeparator \'{}\'", extraPropertiesSeparator, extraPropertiesKeyValueSeparator);
            }
            return valid;
        }

        @java.lang.SuppressWarnings("all")
                public String getExtraPropertiesKeyValueSeparator() {
            return this.extraPropertiesKeyValueSeparator;
        }

        @java.lang.SuppressWarnings("all")
                public String getExtraPropertiesSeparator() {
            return this.extraPropertiesSeparator;
        }

        @java.lang.SuppressWarnings("all")
                public String getExtraProperties() {
            return this.extraProperties;
        }

        @java.lang.SuppressWarnings("all")
                public void setExtraPropertiesKeyValueSeparator(final String extraPropertiesKeyValueSeparator) {
            this.extraPropertiesKeyValueSeparator = extraPropertiesKeyValueSeparator;
        }

        @java.lang.SuppressWarnings("all")
                public void setExtraPropertiesSeparator(final String extraPropertiesSeparator) {
            this.extraPropertiesSeparator = extraPropertiesSeparator;
        }

        @java.lang.SuppressWarnings("all")
                public void setExtraProperties(final String extraProperties) {
            this.extraProperties = extraProperties;
        }
    }


    public static class FineractEventsProperties {
        private FineractExternalEventsProperties external;

        @java.lang.SuppressWarnings("all")
                public FineractExternalEventsProperties getExternal() {
            return this.external;
        }

        @java.lang.SuppressWarnings("all")
                public void setExternal(final FineractExternalEventsProperties external) {
            this.external = external;
        }
    }


    public static class FineractTaskExecutor {
        private int defaultTaskExecutorCorePoolSize;
        private int defaultTaskExecutorMaxPoolSize;
        private int tenantUpgradeTaskExecutorCorePoolSize;
        private int tenantUpgradeTaskExecutorMaxPoolSize;
        private int tenantUpgradeTaskExecutorQueueCapacity;

        @java.lang.SuppressWarnings("all")
                public int getDefaultTaskExecutorCorePoolSize() {
            return this.defaultTaskExecutorCorePoolSize;
        }

        @java.lang.SuppressWarnings("all")
                public int getDefaultTaskExecutorMaxPoolSize() {
            return this.defaultTaskExecutorMaxPoolSize;
        }

        @java.lang.SuppressWarnings("all")
                public int getTenantUpgradeTaskExecutorCorePoolSize() {
            return this.tenantUpgradeTaskExecutorCorePoolSize;
        }

        @java.lang.SuppressWarnings("all")
                public int getTenantUpgradeTaskExecutorMaxPoolSize() {
            return this.tenantUpgradeTaskExecutorMaxPoolSize;
        }

        @java.lang.SuppressWarnings("all")
                public int getTenantUpgradeTaskExecutorQueueCapacity() {
            return this.tenantUpgradeTaskExecutorQueueCapacity;
        }

        @java.lang.SuppressWarnings("all")
                public void setDefaultTaskExecutorCorePoolSize(final int defaultTaskExecutorCorePoolSize) {
            this.defaultTaskExecutorCorePoolSize = defaultTaskExecutorCorePoolSize;
        }

        @java.lang.SuppressWarnings("all")
                public void setDefaultTaskExecutorMaxPoolSize(final int defaultTaskExecutorMaxPoolSize) {
            this.defaultTaskExecutorMaxPoolSize = defaultTaskExecutorMaxPoolSize;
        }

        @java.lang.SuppressWarnings("all")
                public void setTenantUpgradeTaskExecutorCorePoolSize(final int tenantUpgradeTaskExecutorCorePoolSize) {
            this.tenantUpgradeTaskExecutorCorePoolSize = tenantUpgradeTaskExecutorCorePoolSize;
        }

        @java.lang.SuppressWarnings("all")
                public void setTenantUpgradeTaskExecutorMaxPoolSize(final int tenantUpgradeTaskExecutorMaxPoolSize) {
            this.tenantUpgradeTaskExecutorMaxPoolSize = tenantUpgradeTaskExecutorMaxPoolSize;
        }

        @java.lang.SuppressWarnings("all")
                public void setTenantUpgradeTaskExecutorQueueCapacity(final int tenantUpgradeTaskExecutorQueueCapacity) {
            this.tenantUpgradeTaskExecutorQueueCapacity = tenantUpgradeTaskExecutorQueueCapacity;
        }
    }


    public static class FineractExternalEventsProperties {
        private boolean enabled;
        private FineractExternalEventsProducerProperties producer;
        private int partitionSize;
        private int threadPoolCorePoolSize;
        private int threadPoolMaxPoolSize;
        private int threadPoolQueueCapacity;

        @java.lang.SuppressWarnings("all")
                public boolean isEnabled() {
            return this.enabled;
        }

        @java.lang.SuppressWarnings("all")
                public FineractExternalEventsProducerProperties getProducer() {
            return this.producer;
        }

        @java.lang.SuppressWarnings("all")
                public int getPartitionSize() {
            return this.partitionSize;
        }

        @java.lang.SuppressWarnings("all")
                public int getThreadPoolCorePoolSize() {
            return this.threadPoolCorePoolSize;
        }

        @java.lang.SuppressWarnings("all")
                public int getThreadPoolMaxPoolSize() {
            return this.threadPoolMaxPoolSize;
        }

        @java.lang.SuppressWarnings("all")
                public int getThreadPoolQueueCapacity() {
            return this.threadPoolQueueCapacity;
        }

        @java.lang.SuppressWarnings("all")
                public void setEnabled(final boolean enabled) {
            this.enabled = enabled;
        }

        @java.lang.SuppressWarnings("all")
                public void setProducer(final FineractExternalEventsProducerProperties producer) {
            this.producer = producer;
        }

        @java.lang.SuppressWarnings("all")
                public void setPartitionSize(final int partitionSize) {
            this.partitionSize = partitionSize;
        }

        @java.lang.SuppressWarnings("all")
                public void setThreadPoolCorePoolSize(final int threadPoolCorePoolSize) {
            this.threadPoolCorePoolSize = threadPoolCorePoolSize;
        }

        @java.lang.SuppressWarnings("all")
                public void setThreadPoolMaxPoolSize(final int threadPoolMaxPoolSize) {
            this.threadPoolMaxPoolSize = threadPoolMaxPoolSize;
        }

        @java.lang.SuppressWarnings("all")
                public void setThreadPoolQueueCapacity(final int threadPoolQueueCapacity) {
            this.threadPoolQueueCapacity = threadPoolQueueCapacity;
        }
    }


    public static class FineractExternalEventsProducerProperties {
        private FineractExternalEventsProducerJmsProperties jms;
        private FineractExternalEventsProducerKafkaProperties kafka;

        @java.lang.SuppressWarnings("all")
                public FineractExternalEventsProducerJmsProperties getJms() {
            return this.jms;
        }

        @java.lang.SuppressWarnings("all")
                public FineractExternalEventsProducerKafkaProperties getKafka() {
            return this.kafka;
        }

        @java.lang.SuppressWarnings("all")
                public void setJms(final FineractExternalEventsProducerJmsProperties jms) {
            this.jms = jms;
        }

        @java.lang.SuppressWarnings("all")
                public void setKafka(final FineractExternalEventsProducerKafkaProperties kafka) {
            this.kafka = kafka;
        }
    }


    public static class FineractExternalEventsProducerJmsProperties {
        private boolean enabled;
        private String eventQueueName;
        private String eventTopicName;
        private String brokerUrl;
        private String brokerUsername;
        private String brokerPassword;
        private int producerCount;
        private boolean asyncSendEnabled;
        private int threadPoolTaskExecutorCorePoolSize;
        private int threadPoolTaskExecutorMaxPoolSize;

        public boolean isBrokerPasswordProtected() {
            return StringUtils.isNotBlank(brokerUsername) || StringUtils.isNotBlank(brokerPassword);
        }

        @java.lang.SuppressWarnings("all")
                public boolean isEnabled() {
            return this.enabled;
        }

        @java.lang.SuppressWarnings("all")
                public String getEventQueueName() {
            return this.eventQueueName;
        }

        @java.lang.SuppressWarnings("all")
                public String getEventTopicName() {
            return this.eventTopicName;
        }

        @java.lang.SuppressWarnings("all")
                public String getBrokerUrl() {
            return this.brokerUrl;
        }

        @java.lang.SuppressWarnings("all")
                public String getBrokerUsername() {
            return this.brokerUsername;
        }

        @java.lang.SuppressWarnings("all")
                public String getBrokerPassword() {
            return this.brokerPassword;
        }

        @java.lang.SuppressWarnings("all")
                public int getProducerCount() {
            return this.producerCount;
        }

        @java.lang.SuppressWarnings("all")
                public boolean isAsyncSendEnabled() {
            return this.asyncSendEnabled;
        }

        @java.lang.SuppressWarnings("all")
                public int getThreadPoolTaskExecutorCorePoolSize() {
            return this.threadPoolTaskExecutorCorePoolSize;
        }

        @java.lang.SuppressWarnings("all")
                public int getThreadPoolTaskExecutorMaxPoolSize() {
            return this.threadPoolTaskExecutorMaxPoolSize;
        }

        @java.lang.SuppressWarnings("all")
                public void setEnabled(final boolean enabled) {
            this.enabled = enabled;
        }

        @java.lang.SuppressWarnings("all")
                public void setEventQueueName(final String eventQueueName) {
            this.eventQueueName = eventQueueName;
        }

        @java.lang.SuppressWarnings("all")
                public void setEventTopicName(final String eventTopicName) {
            this.eventTopicName = eventTopicName;
        }

        @java.lang.SuppressWarnings("all")
                public void setBrokerUrl(final String brokerUrl) {
            this.brokerUrl = brokerUrl;
        }

        @java.lang.SuppressWarnings("all")
                public void setBrokerUsername(final String brokerUsername) {
            this.brokerUsername = brokerUsername;
        }

        @java.lang.SuppressWarnings("all")
                public void setBrokerPassword(final String brokerPassword) {
            this.brokerPassword = brokerPassword;
        }

        @java.lang.SuppressWarnings("all")
                public void setProducerCount(final int producerCount) {
            this.producerCount = producerCount;
        }

        @java.lang.SuppressWarnings("all")
                public void setAsyncSendEnabled(final boolean asyncSendEnabled) {
            this.asyncSendEnabled = asyncSendEnabled;
        }

        @java.lang.SuppressWarnings("all")
                public void setThreadPoolTaskExecutorCorePoolSize(final int threadPoolTaskExecutorCorePoolSize) {
            this.threadPoolTaskExecutorCorePoolSize = threadPoolTaskExecutorCorePoolSize;
        }

        @java.lang.SuppressWarnings("all")
                public void setThreadPoolTaskExecutorMaxPoolSize(final int threadPoolTaskExecutorMaxPoolSize) {
            this.threadPoolTaskExecutorMaxPoolSize = threadPoolTaskExecutorMaxPoolSize;
        }
    }


    public static class FineractExternalEventsProducerKafkaProperties {
        private boolean enabled;
        private String bootstrapServers;
        private KafkaTopicProperties topic;
        private KafkaProperties producer;
        private KafkaProperties admin;
        private int timeoutInSeconds;

        @java.lang.SuppressWarnings("all")
                public boolean isEnabled() {
            return this.enabled;
        }

        @java.lang.SuppressWarnings("all")
                public String getBootstrapServers() {
            return this.bootstrapServers;
        }

        @java.lang.SuppressWarnings("all")
                public KafkaTopicProperties getTopic() {
            return this.topic;
        }

        @java.lang.SuppressWarnings("all")
                public KafkaProperties getProducer() {
            return this.producer;
        }

        @java.lang.SuppressWarnings("all")
                public KafkaProperties getAdmin() {
            return this.admin;
        }

        @java.lang.SuppressWarnings("all")
                public int getTimeoutInSeconds() {
            return this.timeoutInSeconds;
        }

        @java.lang.SuppressWarnings("all")
                public void setEnabled(final boolean enabled) {
            this.enabled = enabled;
        }

        @java.lang.SuppressWarnings("all")
                public void setBootstrapServers(final String bootstrapServers) {
            this.bootstrapServers = bootstrapServers;
        }

        @java.lang.SuppressWarnings("all")
                public void setTopic(final KafkaTopicProperties topic) {
            this.topic = topic;
        }

        @java.lang.SuppressWarnings("all")
                public void setProducer(final KafkaProperties producer) {
            this.producer = producer;
        }

        @java.lang.SuppressWarnings("all")
                public void setAdmin(final KafkaProperties admin) {
            this.admin = admin;
        }

        @java.lang.SuppressWarnings("all")
                public void setTimeoutInSeconds(final int timeoutInSeconds) {
            this.timeoutInSeconds = timeoutInSeconds;
        }
    }


    public static class FineractContentProperties {
        private boolean regexWhitelistEnabled;
        private List<String> regexWhitelist;
        private boolean mimeWhitelistEnabled;
        private List<String> mimeWhitelist;
        private Integer defaultBufferSize;
        private FineractContentFilesystemProperties filesystem;
        private FineractContentS3Properties s3;

        @java.lang.SuppressWarnings("all")
                public boolean isRegexWhitelistEnabled() {
            return this.regexWhitelistEnabled;
        }

        @java.lang.SuppressWarnings("all")
                public List<String> getRegexWhitelist() {
            return this.regexWhitelist;
        }

        @java.lang.SuppressWarnings("all")
                public boolean isMimeWhitelistEnabled() {
            return this.mimeWhitelistEnabled;
        }

        @java.lang.SuppressWarnings("all")
                public List<String> getMimeWhitelist() {
            return this.mimeWhitelist;
        }

        @java.lang.SuppressWarnings("all")
                public Integer getDefaultBufferSize() {
            return this.defaultBufferSize;
        }

        @java.lang.SuppressWarnings("all")
                public FineractContentFilesystemProperties getFilesystem() {
            return this.filesystem;
        }

        @java.lang.SuppressWarnings("all")
                public FineractContentS3Properties getS3() {
            return this.s3;
        }

        @java.lang.SuppressWarnings("all")
                public void setRegexWhitelistEnabled(final boolean regexWhitelistEnabled) {
            this.regexWhitelistEnabled = regexWhitelistEnabled;
        }

        @java.lang.SuppressWarnings("all")
                public void setRegexWhitelist(final List<String> regexWhitelist) {
            this.regexWhitelist = regexWhitelist;
        }

        @java.lang.SuppressWarnings("all")
                public void setMimeWhitelistEnabled(final boolean mimeWhitelistEnabled) {
            this.mimeWhitelistEnabled = mimeWhitelistEnabled;
        }

        @java.lang.SuppressWarnings("all")
                public void setMimeWhitelist(final List<String> mimeWhitelist) {
            this.mimeWhitelist = mimeWhitelist;
        }

        @java.lang.SuppressWarnings("all")
                public void setDefaultBufferSize(final Integer defaultBufferSize) {
            this.defaultBufferSize = defaultBufferSize;
        }

        @java.lang.SuppressWarnings("all")
                public void setFilesystem(final FineractContentFilesystemProperties filesystem) {
            this.filesystem = filesystem;
        }

        @java.lang.SuppressWarnings("all")
                public void setS3(final FineractContentS3Properties s3) {
            this.s3 = s3;
        }
    }


    public static class FineractContentFilesystemProperties {
        private Boolean enabled;
        private String rootFolder;

        @java.lang.SuppressWarnings("all")
                public Boolean getEnabled() {
            return this.enabled;
        }

        @java.lang.SuppressWarnings("all")
                public String getRootFolder() {
            return this.rootFolder;
        }

        @java.lang.SuppressWarnings("all")
                public void setEnabled(final Boolean enabled) {
            this.enabled = enabled;
        }

        @java.lang.SuppressWarnings("all")
                public void setRootFolder(final String rootFolder) {
            this.rootFolder = rootFolder;
        }
    }


    public static class FineractContentS3Properties {
        private Boolean enabled;
        private String bucketName;
        private String accessKey;
        private String secretKey;
        private String region;
        private String endpoint;
        private Boolean pathStyleAddressingEnabled;

        @java.lang.SuppressWarnings("all")
                public Boolean getEnabled() {
            return this.enabled;
        }

        @java.lang.SuppressWarnings("all")
                public String getBucketName() {
            return this.bucketName;
        }

        @java.lang.SuppressWarnings("all")
                public String getAccessKey() {
            return this.accessKey;
        }

        @java.lang.SuppressWarnings("all")
                public String getSecretKey() {
            return this.secretKey;
        }

        @java.lang.SuppressWarnings("all")
                public String getRegion() {
            return this.region;
        }

        @java.lang.SuppressWarnings("all")
                public String getEndpoint() {
            return this.endpoint;
        }

        @java.lang.SuppressWarnings("all")
                public Boolean getPathStyleAddressingEnabled() {
            return this.pathStyleAddressingEnabled;
        }

        @java.lang.SuppressWarnings("all")
                public void setEnabled(final Boolean enabled) {
            this.enabled = enabled;
        }

        @java.lang.SuppressWarnings("all")
                public void setBucketName(final String bucketName) {
            this.bucketName = bucketName;
        }

        @java.lang.SuppressWarnings("all")
                public void setAccessKey(final String accessKey) {
            this.accessKey = accessKey;
        }

        @java.lang.SuppressWarnings("all")
                public void setSecretKey(final String secretKey) {
            this.secretKey = secretKey;
        }

        @java.lang.SuppressWarnings("all")
                public void setRegion(final String region) {
            this.region = region;
        }

        @java.lang.SuppressWarnings("all")
                public void setEndpoint(final String endpoint) {
            this.endpoint = endpoint;
        }

        @java.lang.SuppressWarnings("all")
                public void setPathStyleAddressingEnabled(final Boolean pathStyleAddressingEnabled) {
            this.pathStyleAddressingEnabled = pathStyleAddressingEnabled;
        }
    }


    public static class FineractReportProperties {
        private FineractExportProperties export;

        @java.lang.SuppressWarnings("all")
                public FineractExportProperties getExport() {
            return this.export;
        }

        @java.lang.SuppressWarnings("all")
                public void setExport(final FineractExportProperties export) {
            this.export = export;
        }
    }


    public static class FineractExportProperties {
        private FineractExportS3Properties s3;

        @java.lang.SuppressWarnings("all")
                public FineractExportS3Properties getS3() {
            return this.s3;
        }

        @java.lang.SuppressWarnings("all")
                public void setS3(final FineractExportS3Properties s3) {
            this.s3 = s3;
        }
    }


    public static class FineractExportS3Properties {
        private String bucketName;
        private Boolean enabled;

        @java.lang.SuppressWarnings("all")
                public String getBucketName() {
            return this.bucketName;
        }

        @java.lang.SuppressWarnings("all")
                public Boolean getEnabled() {
            return this.enabled;
        }

        @java.lang.SuppressWarnings("all")
                public void setBucketName(final String bucketName) {
            this.bucketName = bucketName;
        }

        @java.lang.SuppressWarnings("all")
                public void setEnabled(final Boolean enabled) {
            this.enabled = enabled;
        }
    }


    public static class FineractJobProperties {
        private int stuckRetryThreshold;
        private boolean loanCobEnabled;
        private FineractJournalEntryAggregationProperties journalEntryAggregation;
        private int retainedEarningChunkSize;

        @java.lang.SuppressWarnings("all")
                public int getStuckRetryThreshold() {
            return this.stuckRetryThreshold;
        }

        @java.lang.SuppressWarnings("all")
                public boolean isLoanCobEnabled() {
            return this.loanCobEnabled;
        }

        @java.lang.SuppressWarnings("all")
                public FineractJournalEntryAggregationProperties getJournalEntryAggregation() {
            return this.journalEntryAggregation;
        }

        @java.lang.SuppressWarnings("all")
                public int getRetainedEarningChunkSize() {
            return this.retainedEarningChunkSize;
        }

        @java.lang.SuppressWarnings("all")
                public void setStuckRetryThreshold(final int stuckRetryThreshold) {
            this.stuckRetryThreshold = stuckRetryThreshold;
        }

        @java.lang.SuppressWarnings("all")
                public void setLoanCobEnabled(final boolean loanCobEnabled) {
            this.loanCobEnabled = loanCobEnabled;
        }

        @java.lang.SuppressWarnings("all")
                public void setJournalEntryAggregation(final FineractJournalEntryAggregationProperties journalEntryAggregation) {
            this.journalEntryAggregation = journalEntryAggregation;
        }

        @java.lang.SuppressWarnings("all")
                public void setRetainedEarningChunkSize(final int retainedEarningChunkSize) {
            this.retainedEarningChunkSize = retainedEarningChunkSize;
        }
    }


    public static class FineractJournalEntryAggregationProperties {
        private Integer excludeRecentNDays;
        private boolean enabled;
        private Integer chunkSize;

        @java.lang.SuppressWarnings("all")
                public Integer getExcludeRecentNDays() {
            return this.excludeRecentNDays;
        }

        @java.lang.SuppressWarnings("all")
                public boolean isEnabled() {
            return this.enabled;
        }

        @java.lang.SuppressWarnings("all")
                public Integer getChunkSize() {
            return this.chunkSize;
        }

        @java.lang.SuppressWarnings("all")
                public void setExcludeRecentNDays(final Integer excludeRecentNDays) {
            this.excludeRecentNDays = excludeRecentNDays;
        }

        @java.lang.SuppressWarnings("all")
                public void setEnabled(final boolean enabled) {
            this.enabled = enabled;
        }

        @java.lang.SuppressWarnings("all")
                public void setChunkSize(final Integer chunkSize) {
            this.chunkSize = chunkSize;
        }
    }


    public static class FineractTemplateProperties {
        private boolean regexWhitelistEnabled;
        private List<String> regexWhitelist;

        @java.lang.SuppressWarnings("all")
                public boolean isRegexWhitelistEnabled() {
            return this.regexWhitelistEnabled;
        }

        @java.lang.SuppressWarnings("all")
                public List<String> getRegexWhitelist() {
            return this.regexWhitelist;
        }

        @java.lang.SuppressWarnings("all")
                public void setRegexWhitelistEnabled(final boolean regexWhitelistEnabled) {
            this.regexWhitelistEnabled = regexWhitelistEnabled;
        }

        @java.lang.SuppressWarnings("all")
                public void setRegexWhitelist(final List<String> regexWhitelist) {
            this.regexWhitelist = regexWhitelist;
        }
    }


    public static class FineractJpaProperties {
        private boolean statementLoggingEnabled;

        @java.lang.SuppressWarnings("all")
                public boolean isStatementLoggingEnabled() {
            return this.statementLoggingEnabled;
        }

        @java.lang.SuppressWarnings("all")
                public void setStatementLoggingEnabled(final boolean statementLoggingEnabled) {
            this.statementLoggingEnabled = statementLoggingEnabled;
        }
    }


    public static class FineractDatabaseProperties {
        private String defaultMasterPassword;

        @java.lang.SuppressWarnings("all")
                public String getDefaultMasterPassword() {
            return this.defaultMasterPassword;
        }

        @java.lang.SuppressWarnings("all")
                public void setDefaultMasterPassword(final String defaultMasterPassword) {
            this.defaultMasterPassword = defaultMasterPassword;
        }
    }


    public static class FineractQueryProperties {
        private int inClauseParameterSizeLimit;

        @java.lang.SuppressWarnings("all")
                public int getInClauseParameterSizeLimit() {
            return this.inClauseParameterSizeLimit;
        }

        @java.lang.SuppressWarnings("all")
                public void setInClauseParameterSizeLimit(final int inClauseParameterSizeLimit) {
            this.inClauseParameterSizeLimit = inClauseParameterSizeLimit;
        }
    }


    public static class FineractApiProperties {
        private FineractBodyItemSizeLimitProperties bodyItemSizeLimit;

        @java.lang.SuppressWarnings("all")
                public FineractBodyItemSizeLimitProperties getBodyItemSizeLimit() {
            return this.bodyItemSizeLimit;
        }

        @java.lang.SuppressWarnings("all")
                public void setBodyItemSizeLimit(final FineractBodyItemSizeLimitProperties bodyItemSizeLimit) {
            this.bodyItemSizeLimit = bodyItemSizeLimit;
        }
    }


    public static class FineractBodyItemSizeLimitProperties {
        private int inlineLoanCob;

        @java.lang.SuppressWarnings("all")
                public int getInlineLoanCob() {
            return this.inlineLoanCob;
        }

        @java.lang.SuppressWarnings("all")
                public void setInlineLoanCob(final int inlineLoanCob) {
            this.inlineLoanCob = inlineLoanCob;
        }
    }


    public static class FineractNotificationProperties {
        private UserNotificationSystemProperties userNotificationSystem;

        @java.lang.SuppressWarnings("all")
                public UserNotificationSystemProperties getUserNotificationSystem() {
            return this.userNotificationSystem;
        }

        @java.lang.SuppressWarnings("all")
                public void setUserNotificationSystem(final UserNotificationSystemProperties userNotificationSystem) {
            this.userNotificationSystem = userNotificationSystem;
        }
    }


    public static class UserNotificationSystemProperties {
        private boolean enabled;

        @java.lang.SuppressWarnings("all")
                public boolean isEnabled() {
            return this.enabled;
        }

        @java.lang.SuppressWarnings("all")
                public void setEnabled(final boolean enabled) {
            this.enabled = enabled;
        }
    }


    public static class FineractLoanProperties {
        private FineractTransactionProcessorProperties transactionProcessor;
        private String statusChangeHistoryStatuses;

        @java.lang.SuppressWarnings("all")
                public FineractTransactionProcessorProperties getTransactionProcessor() {
            return this.transactionProcessor;
        }

        @java.lang.SuppressWarnings("all")
                public String getStatusChangeHistoryStatuses() {
            return this.statusChangeHistoryStatuses;
        }

        @java.lang.SuppressWarnings("all")
                public void setTransactionProcessor(final FineractTransactionProcessorProperties transactionProcessor) {
            this.transactionProcessor = transactionProcessor;
        }

        @java.lang.SuppressWarnings("all")
                public void setStatusChangeHistoryStatuses(final String statusChangeHistoryStatuses) {
            this.statusChangeHistoryStatuses = statusChangeHistoryStatuses;
        }
    }


    public static class FineractTransactionProcessorProperties {
        private FineractTransactionProcessorItemProperties creocore;
        private FineractTransactionProcessorItemProperties earlyRepayment;
        private FineractTransactionProcessorItemProperties mifosStandard;
        private FineractTransactionProcessorItemProperties heavensFamily;
        private FineractTransactionProcessorItemProperties interestPrincipalPenaltiesFees;
        private FineractTransactionProcessorItemProperties principalInterestPenaltiesFees;
        private FineractTransactionProcessorItemProperties rbiIndia;
        private FineractTransactionProcessorItemProperties duePenaltyFeeInterestPrincipalInAdvancePrincipalPenaltyFeeInterest;
        private FineractTransactionProcessorItemProperties duePenaltyInterestPrincipalFeeInAdvancePenaltyInterestPrincipalFee;
        private FineractTransactionProcessorItemProperties advancedPaymentStrategy;
        private boolean errorNotFoundFail;

        @java.lang.SuppressWarnings("all")
                public FineractTransactionProcessorItemProperties getCreocore() {
            return this.creocore;
        }

        @java.lang.SuppressWarnings("all")
                public FineractTransactionProcessorItemProperties getEarlyRepayment() {
            return this.earlyRepayment;
        }

        @java.lang.SuppressWarnings("all")
                public FineractTransactionProcessorItemProperties getMifosStandard() {
            return this.mifosStandard;
        }

        @java.lang.SuppressWarnings("all")
                public FineractTransactionProcessorItemProperties getHeavensFamily() {
            return this.heavensFamily;
        }

        @java.lang.SuppressWarnings("all")
                public FineractTransactionProcessorItemProperties getInterestPrincipalPenaltiesFees() {
            return this.interestPrincipalPenaltiesFees;
        }

        @java.lang.SuppressWarnings("all")
                public FineractTransactionProcessorItemProperties getPrincipalInterestPenaltiesFees() {
            return this.principalInterestPenaltiesFees;
        }

        @java.lang.SuppressWarnings("all")
                public FineractTransactionProcessorItemProperties getRbiIndia() {
            return this.rbiIndia;
        }

        @java.lang.SuppressWarnings("all")
                public FineractTransactionProcessorItemProperties getDuePenaltyFeeInterestPrincipalInAdvancePrincipalPenaltyFeeInterest() {
            return this.duePenaltyFeeInterestPrincipalInAdvancePrincipalPenaltyFeeInterest;
        }

        @java.lang.SuppressWarnings("all")
                public FineractTransactionProcessorItemProperties getDuePenaltyInterestPrincipalFeeInAdvancePenaltyInterestPrincipalFee() {
            return this.duePenaltyInterestPrincipalFeeInAdvancePenaltyInterestPrincipalFee;
        }

        @java.lang.SuppressWarnings("all")
                public FineractTransactionProcessorItemProperties getAdvancedPaymentStrategy() {
            return this.advancedPaymentStrategy;
        }

        @java.lang.SuppressWarnings("all")
                public boolean isErrorNotFoundFail() {
            return this.errorNotFoundFail;
        }

        @java.lang.SuppressWarnings("all")
                public void setCreocore(final FineractTransactionProcessorItemProperties creocore) {
            this.creocore = creocore;
        }

        @java.lang.SuppressWarnings("all")
                public void setEarlyRepayment(final FineractTransactionProcessorItemProperties earlyRepayment) {
            this.earlyRepayment = earlyRepayment;
        }

        @java.lang.SuppressWarnings("all")
                public void setMifosStandard(final FineractTransactionProcessorItemProperties mifosStandard) {
            this.mifosStandard = mifosStandard;
        }

        @java.lang.SuppressWarnings("all")
                public void setHeavensFamily(final FineractTransactionProcessorItemProperties heavensFamily) {
            this.heavensFamily = heavensFamily;
        }

        @java.lang.SuppressWarnings("all")
                public void setInterestPrincipalPenaltiesFees(final FineractTransactionProcessorItemProperties interestPrincipalPenaltiesFees) {
            this.interestPrincipalPenaltiesFees = interestPrincipalPenaltiesFees;
        }

        @java.lang.SuppressWarnings("all")
                public void setPrincipalInterestPenaltiesFees(final FineractTransactionProcessorItemProperties principalInterestPenaltiesFees) {
            this.principalInterestPenaltiesFees = principalInterestPenaltiesFees;
        }

        @java.lang.SuppressWarnings("all")
                public void setRbiIndia(final FineractTransactionProcessorItemProperties rbiIndia) {
            this.rbiIndia = rbiIndia;
        }

        @java.lang.SuppressWarnings("all")
                public void setDuePenaltyFeeInterestPrincipalInAdvancePrincipalPenaltyFeeInterest(final FineractTransactionProcessorItemProperties duePenaltyFeeInterestPrincipalInAdvancePrincipalPenaltyFeeInterest) {
            this.duePenaltyFeeInterestPrincipalInAdvancePrincipalPenaltyFeeInterest = duePenaltyFeeInterestPrincipalInAdvancePrincipalPenaltyFeeInterest;
        }

        @java.lang.SuppressWarnings("all")
                public void setDuePenaltyInterestPrincipalFeeInAdvancePenaltyInterestPrincipalFee(final FineractTransactionProcessorItemProperties duePenaltyInterestPrincipalFeeInAdvancePenaltyInterestPrincipalFee) {
            this.duePenaltyInterestPrincipalFeeInAdvancePenaltyInterestPrincipalFee = duePenaltyInterestPrincipalFeeInAdvancePenaltyInterestPrincipalFee;
        }

        @java.lang.SuppressWarnings("all")
                public void setAdvancedPaymentStrategy(final FineractTransactionProcessorItemProperties advancedPaymentStrategy) {
            this.advancedPaymentStrategy = advancedPaymentStrategy;
        }

        @java.lang.SuppressWarnings("all")
                public void setErrorNotFoundFail(final boolean errorNotFoundFail) {
            this.errorNotFoundFail = errorNotFoundFail;
        }
    }


    public static class FineractSecurityProperties {
        private FineractSecurityBasicAuth basicauth;
        private FineractSecurityTwoFactorAuth twoFactor;
        private FineractSecurityHsts hsts;
        private FineractSecurityOAuth2Properties oauth2;
        private FineractSecurityOidcFederationProperties oidcFederation;
        private CorsProperties cors;

        public void set2fa(FineractSecurityTwoFactorAuth twoFactor) {
            this.twoFactor = twoFactor;
        }


        public static class FineractSecurityOAuth2Properties {
            private boolean enabled;
            private ClientProperties client;


            public static class ClientProperties implements Serializable {
                @Serial
                private static final long serialVersionUID = 1L;
                private Map<String, Registration> registrations = new HashMap<>();


                public static final class Registration implements Serializable {
                    @Serial
                    private static final long serialVersionUID = 1L;
                    private String clientId;
                    private List<String> scopes = new ArrayList<>();
                    private List<String> authorizationGrantTypes = new ArrayList<>();
                    private List<String> redirectUris = new ArrayList<>();
                    private boolean requireAuthorizationConsent = true;

                    @java.lang.SuppressWarnings("all")
                                        public String getClientId() {
                        return this.clientId;
                    }

                    @java.lang.SuppressWarnings("all")
                                        public List<String> getScopes() {
                        return this.scopes;
                    }

                    @java.lang.SuppressWarnings("all")
                                        public List<String> getAuthorizationGrantTypes() {
                        return this.authorizationGrantTypes;
                    }

                    @java.lang.SuppressWarnings("all")
                                        public List<String> getRedirectUris() {
                        return this.redirectUris;
                    }

                    @java.lang.SuppressWarnings("all")
                                        public boolean isRequireAuthorizationConsent() {
                        return this.requireAuthorizationConsent;
                    }

                    @java.lang.SuppressWarnings("all")
                                        public void setClientId(final String clientId) {
                        this.clientId = clientId;
                    }

                    @java.lang.SuppressWarnings("all")
                                        public void setScopes(final List<String> scopes) {
                        this.scopes = scopes;
                    }

                    @java.lang.SuppressWarnings("all")
                                        public void setAuthorizationGrantTypes(final List<String> authorizationGrantTypes) {
                        this.authorizationGrantTypes = authorizationGrantTypes;
                    }

                    @java.lang.SuppressWarnings("all")
                                        public void setRedirectUris(final List<String> redirectUris) {
                        this.redirectUris = redirectUris;
                    }

                    @java.lang.SuppressWarnings("all")
                                        public void setRequireAuthorizationConsent(final boolean requireAuthorizationConsent) {
                        this.requireAuthorizationConsent = requireAuthorizationConsent;
                    }
                }

                @java.lang.SuppressWarnings("all")
                                public Map<String, Registration> getRegistrations() {
                    return this.registrations;
                }

                @java.lang.SuppressWarnings("all")
                                public void setRegistrations(final Map<String, Registration> registrations) {
                    this.registrations = registrations;
                }
            }

            @java.lang.SuppressWarnings("all")
                        public boolean isEnabled() {
                return this.enabled;
            }

            @java.lang.SuppressWarnings("all")
                        public ClientProperties getClient() {
                return this.client;
            }

            @java.lang.SuppressWarnings("all")
                        public void setEnabled(final boolean enabled) {
                this.enabled = enabled;
            }

            @java.lang.SuppressWarnings("all")
                        public void setClient(final ClientProperties client) {
                this.client = client;
            }
        }


        public static class FineractSecurityOidcFederationProperties {
            private boolean enabled;
            // JWT claim name used to resolve the Fineract tenant ID.
            // Falls back to HTTP header / query param if absent.
            private String tenantClaimName = "fineract_tenant";
            // Claim used as the Fineract username. Common values: preferred_username, email, sub.
            private String usernameClaim = "preferred_username";
            // When true, creates a Fineract AppUser on first successful OIDC login.
            private boolean autoCreateUser = false;
            // Comma-separated role names assigned to auto-created users.
            private String defaultRoles = "";
            // Controls the RP-Initiated Logout URL format.
            // Values: keycloak | azure_ad | okta | auth0 | generic (default)
            private OidcFederationType provider = OidcFederationType.GENERIC;
            // Redirect URI sent to the IdP after successful logout.
            private String postLogoutRedirectUri;
            // Static per-issuer tenant mapping (YAML fallback).
            // Used when the master DB has no m_tenant_oidc_config record for an incoming issuer.
            // Priority: DB config > issuers[] > tenantClaimName claim.
            private List<OidcIssuerProperties> issuers = new ArrayList<>();


            public static class OidcIssuerProperties {
                // Exact value expected in the JWT 'iss' claim.
                private String issuerUri;
                // Fineract tenant identifier this issuer maps to.
                private String tenantId;
                // Optional: if absent, derived from issuerUri via OIDC discovery.
                private String jwksUri;
                // Optional: per-issuer override for the username claim.
                private String usernameClaim;

                @java.lang.SuppressWarnings("all")
                                public String getIssuerUri() {
                    return this.issuerUri;
                }

                @java.lang.SuppressWarnings("all")
                                public String getTenantId() {
                    return this.tenantId;
                }

                @java.lang.SuppressWarnings("all")
                                public String getJwksUri() {
                    return this.jwksUri;
                }

                @java.lang.SuppressWarnings("all")
                                public String getUsernameClaim() {
                    return this.usernameClaim;
                }

                @java.lang.SuppressWarnings("all")
                                public void setIssuerUri(final String issuerUri) {
                    this.issuerUri = issuerUri;
                }

                @java.lang.SuppressWarnings("all")
                                public void setTenantId(final String tenantId) {
                    this.tenantId = tenantId;
                }

                @java.lang.SuppressWarnings("all")
                                public void setJwksUri(final String jwksUri) {
                    this.jwksUri = jwksUri;
                }

                @java.lang.SuppressWarnings("all")
                                public void setUsernameClaim(final String usernameClaim) {
                    this.usernameClaim = usernameClaim;
                }
            }

            @java.lang.SuppressWarnings("all")
                        public boolean isEnabled() {
                return this.enabled;
            }

            @java.lang.SuppressWarnings("all")
                        public String getTenantClaimName() {
                return this.tenantClaimName;
            }

            @java.lang.SuppressWarnings("all")
                        public String getUsernameClaim() {
                return this.usernameClaim;
            }

            @java.lang.SuppressWarnings("all")
                        public boolean isAutoCreateUser() {
                return this.autoCreateUser;
            }

            @java.lang.SuppressWarnings("all")
                        public String getDefaultRoles() {
                return this.defaultRoles;
            }

            @java.lang.SuppressWarnings("all")
                        public OidcFederationType getProvider() {
                return this.provider;
            }

            @java.lang.SuppressWarnings("all")
                        public String getPostLogoutRedirectUri() {
                return this.postLogoutRedirectUri;
            }

            @java.lang.SuppressWarnings("all")
                        public List<OidcIssuerProperties> getIssuers() {
                return this.issuers;
            }

            @java.lang.SuppressWarnings("all")
                        public void setEnabled(final boolean enabled) {
                this.enabled = enabled;
            }

            @java.lang.SuppressWarnings("all")
                        public void setTenantClaimName(final String tenantClaimName) {
                this.tenantClaimName = tenantClaimName;
            }

            @java.lang.SuppressWarnings("all")
                        public void setUsernameClaim(final String usernameClaim) {
                this.usernameClaim = usernameClaim;
            }

            @java.lang.SuppressWarnings("all")
                        public void setAutoCreateUser(final boolean autoCreateUser) {
                this.autoCreateUser = autoCreateUser;
            }

            @java.lang.SuppressWarnings("all")
                        public void setDefaultRoles(final String defaultRoles) {
                this.defaultRoles = defaultRoles;
            }

            @java.lang.SuppressWarnings("all")
                        public void setProvider(final OidcFederationType provider) {
                this.provider = provider;
            }

            @java.lang.SuppressWarnings("all")
                        public void setPostLogoutRedirectUri(final String postLogoutRedirectUri) {
                this.postLogoutRedirectUri = postLogoutRedirectUri;
            }

            @java.lang.SuppressWarnings("all")
                        public void setIssuers(final List<OidcIssuerProperties> issuers) {
                this.issuers = issuers;
            }
        }


        public static class FineractSecurityBasicAuth {
            private boolean enabled;

            @java.lang.SuppressWarnings("all")
                        public boolean isEnabled() {
                return this.enabled;
            }

            @java.lang.SuppressWarnings("all")
                        public void setEnabled(final boolean enabled) {
                this.enabled = enabled;
            }
        }


        public static class FineractSecurityTwoFactorAuth {
            private boolean enabled;

            @java.lang.SuppressWarnings("all")
                        public boolean isEnabled() {
                return this.enabled;
            }

            @java.lang.SuppressWarnings("all")
                        public void setEnabled(final boolean enabled) {
                this.enabled = enabled;
            }
        }


        public static class FineractSecurityHsts {
            private boolean enabled;

            @java.lang.SuppressWarnings("all")
                        public boolean isEnabled() {
                return this.enabled;
            }

            @java.lang.SuppressWarnings("all")
                        public void setEnabled(final boolean enabled) {
                this.enabled = enabled;
            }
        }

        @java.lang.SuppressWarnings("all")
                public FineractSecurityBasicAuth getBasicauth() {
            return this.basicauth;
        }

        @java.lang.SuppressWarnings("all")
                public FineractSecurityTwoFactorAuth getTwoFactor() {
            return this.twoFactor;
        }

        @java.lang.SuppressWarnings("all")
                public FineractSecurityHsts getHsts() {
            return this.hsts;
        }

        @java.lang.SuppressWarnings("all")
                public FineractSecurityOAuth2Properties getOauth2() {
            return this.oauth2;
        }

        @java.lang.SuppressWarnings("all")
                public FineractSecurityOidcFederationProperties getOidcFederation() {
            return this.oidcFederation;
        }

        @java.lang.SuppressWarnings("all")
                public CorsProperties getCors() {
            return this.cors;
        }

        @java.lang.SuppressWarnings("all")
                public void setBasicauth(final FineractSecurityBasicAuth basicauth) {
            this.basicauth = basicauth;
        }

        @java.lang.SuppressWarnings("all")
                public void setTwoFactor(final FineractSecurityTwoFactorAuth twoFactor) {
            this.twoFactor = twoFactor;
        }

        @java.lang.SuppressWarnings("all")
                public void setHsts(final FineractSecurityHsts hsts) {
            this.hsts = hsts;
        }

        @java.lang.SuppressWarnings("all")
                public void setOauth2(final FineractSecurityOAuth2Properties oauth2) {
            this.oauth2 = oauth2;
        }

        @java.lang.SuppressWarnings("all")
                public void setOidcFederation(final FineractSecurityOidcFederationProperties oidcFederation) {
            this.oidcFederation = oidcFederation;
        }

        @java.lang.SuppressWarnings("all")
                public void setCors(final CorsProperties cors) {
            this.cors = cors;
        }
    }


    public static class FineractTransactionProcessorItemProperties {
        private boolean enabled;

        @java.lang.SuppressWarnings("all")
                public boolean isEnabled() {
            return this.enabled;
        }

        @java.lang.SuppressWarnings("all")
                public void setEnabled(final boolean enabled) {
            this.enabled = enabled;
        }
    }


    public static class FineractSamplingProperties {
        private boolean enabled;
        private int samplingRate;
        private String sampledClasses;
        private int resetPeriodSec;

        @java.lang.SuppressWarnings("all")
                public boolean isEnabled() {
            return this.enabled;
        }

        @java.lang.SuppressWarnings("all")
                public int getSamplingRate() {
            return this.samplingRate;
        }

        @java.lang.SuppressWarnings("all")
                public String getSampledClasses() {
            return this.sampledClasses;
        }

        @java.lang.SuppressWarnings("all")
                public int getResetPeriodSec() {
            return this.resetPeriodSec;
        }

        @java.lang.SuppressWarnings("all")
                public void setEnabled(final boolean enabled) {
            this.enabled = enabled;
        }

        @java.lang.SuppressWarnings("all")
                public void setSamplingRate(final int samplingRate) {
            this.samplingRate = samplingRate;
        }

        @java.lang.SuppressWarnings("all")
                public void setSampledClasses(final String sampledClasses) {
            this.sampledClasses = sampledClasses;
        }

        @java.lang.SuppressWarnings("all")
                public void setResetPeriodSec(final int resetPeriodSec) {
            this.resetPeriodSec = resetPeriodSec;
        }
    }


    public static class FineractModulesProperties {
        private FineractInvestorModuleProperties investor;
        private FineractLoanOriginationModuleProperties loanOrigination;

        @java.lang.SuppressWarnings("all")
                public FineractInvestorModuleProperties getInvestor() {
            return this.investor;
        }

        @java.lang.SuppressWarnings("all")
                public FineractLoanOriginationModuleProperties getLoanOrigination() {
            return this.loanOrigination;
        }

        @java.lang.SuppressWarnings("all")
                public void setInvestor(final FineractInvestorModuleProperties investor) {
            this.investor = investor;
        }

        @java.lang.SuppressWarnings("all")
                public void setLoanOrigination(final FineractLoanOriginationModuleProperties loanOrigination) {
            this.loanOrigination = loanOrigination;
        }
    }


    public static class FineractInvestorModuleProperties extends AbstractFineractModuleProperties {
    }


    public static class FineractLoanOriginationModuleProperties extends AbstractFineractModuleProperties {
    }


    public static class FineractSqlValidationProperties {
        private List<FineractSqlValidationPatternProperties> patterns;
        private List<FineractSqlValidationProfileProperties> profiles;

        @java.lang.SuppressWarnings("all")
                public List<FineractSqlValidationPatternProperties> getPatterns() {
            return this.patterns;
        }

        @java.lang.SuppressWarnings("all")
                public List<FineractSqlValidationProfileProperties> getProfiles() {
            return this.profiles;
        }

        @java.lang.SuppressWarnings("all")
                public void setPatterns(final List<FineractSqlValidationPatternProperties> patterns) {
            this.patterns = patterns;
        }

        @java.lang.SuppressWarnings("all")
                public void setProfiles(final List<FineractSqlValidationProfileProperties> profiles) {
            this.profiles = profiles;
        }
    }


    public static class FineractSqlValidationProfileProperties {
        private String name;
        private String description;
        private List<FineractSqlValidationPatternReferenceProperties> patternRefs;
        private Boolean enabled = true;

        @java.lang.SuppressWarnings("all")
                public String getName() {
            return this.name;
        }

        @java.lang.SuppressWarnings("all")
                public String getDescription() {
            return this.description;
        }

        @java.lang.SuppressWarnings("all")
                public List<FineractSqlValidationPatternReferenceProperties> getPatternRefs() {
            return this.patternRefs;
        }

        @java.lang.SuppressWarnings("all")
                public Boolean getEnabled() {
            return this.enabled;
        }

        @java.lang.SuppressWarnings("all")
                public void setName(final String name) {
            this.name = name;
        }

        @java.lang.SuppressWarnings("all")
                public void setDescription(final String description) {
            this.description = description;
        }

        @java.lang.SuppressWarnings("all")
                public void setPatternRefs(final List<FineractSqlValidationPatternReferenceProperties> patternRefs) {
            this.patternRefs = patternRefs;
        }

        @java.lang.SuppressWarnings("all")
                public void setEnabled(final Boolean enabled) {
            this.enabled = enabled;
        }
    }


    public static class FineractSqlValidationPatternReferenceProperties {
        private String name;
        private Integer order;

        @java.lang.SuppressWarnings("all")
                public String getName() {
            return this.name;
        }

        @java.lang.SuppressWarnings("all")
                public Integer getOrder() {
            return this.order;
        }

        @java.lang.SuppressWarnings("all")
                public void setName(final String name) {
            this.name = name;
        }

        @java.lang.SuppressWarnings("all")
                public void setOrder(final Integer order) {
            this.order = order;
        }
    }


    public static class FineractSqlValidationPatternProperties {
        private String name;
        private String pattern;

        @java.lang.SuppressWarnings("all")
                public String getName() {
            return this.name;
        }

        @java.lang.SuppressWarnings("all")
                public String getPattern() {
            return this.pattern;
        }

        @java.lang.SuppressWarnings("all")
                public void setName(final String name) {
            this.name = name;
        }

        @java.lang.SuppressWarnings("all")
                public void setPattern(final String pattern) {
            this.pattern = pattern;
        }
    }


    public static class FineractInputValidationProperties {
        private List<FineractInputValidationPatternProperties> patterns;
        private List<FineractInputValidationProfileProperties> profiles;

        @java.lang.SuppressWarnings("all")
                public List<FineractInputValidationPatternProperties> getPatterns() {
            return this.patterns;
        }

        @java.lang.SuppressWarnings("all")
                public List<FineractInputValidationProfileProperties> getProfiles() {
            return this.profiles;
        }

        @java.lang.SuppressWarnings("all")
                public void setPatterns(final List<FineractInputValidationPatternProperties> patterns) {
            this.patterns = patterns;
        }

        @java.lang.SuppressWarnings("all")
                public void setProfiles(final List<FineractInputValidationProfileProperties> profiles) {
            this.profiles = profiles;
        }
    }


    public static class FineractInputValidationProfileProperties {
        private String name;
        private String description;
        private List<FineractInputValidationPatternReferenceProperties> patternRefs;
        private Boolean enabled = true;

        @java.lang.SuppressWarnings("all")
                public String getName() {
            return this.name;
        }

        @java.lang.SuppressWarnings("all")
                public String getDescription() {
            return this.description;
        }

        @java.lang.SuppressWarnings("all")
                public List<FineractInputValidationPatternReferenceProperties> getPatternRefs() {
            return this.patternRefs;
        }

        @java.lang.SuppressWarnings("all")
                public Boolean getEnabled() {
            return this.enabled;
        }

        @java.lang.SuppressWarnings("all")
                public void setName(final String name) {
            this.name = name;
        }

        @java.lang.SuppressWarnings("all")
                public void setDescription(final String description) {
            this.description = description;
        }

        @java.lang.SuppressWarnings("all")
                public void setPatternRefs(final List<FineractInputValidationPatternReferenceProperties> patternRefs) {
            this.patternRefs = patternRefs;
        }

        @java.lang.SuppressWarnings("all")
                public void setEnabled(final Boolean enabled) {
            this.enabled = enabled;
        }
    }


    public static class FineractInputValidationPatternReferenceProperties {
        private String name;
        private Integer order;

        @java.lang.SuppressWarnings("all")
                public String getName() {
            return this.name;
        }

        @java.lang.SuppressWarnings("all")
                public Integer getOrder() {
            return this.order;
        }

        @java.lang.SuppressWarnings("all")
                public void setName(final String name) {
            this.name = name;
        }

        @java.lang.SuppressWarnings("all")
                public void setOrder(final Integer order) {
            this.order = order;
        }
    }


    public static class FineractInputValidationPatternProperties {
        private String name;
        private String pattern;

        @java.lang.SuppressWarnings("all")
                public String getName() {
            return this.name;
        }

        @java.lang.SuppressWarnings("all")
                public String getPattern() {
            return this.pattern;
        }

        @java.lang.SuppressWarnings("all")
                public void setName(final String name) {
            this.name = name;
        }

        @java.lang.SuppressWarnings("all")
                public void setPattern(final String pattern) {
            this.pattern = pattern;
        }
    }


    public static class FineractCache {
        private FineractCacheDetails defaultTemplate;
        private Map<String, FineractCacheDetails> customTemplates = new HashMap<>();

        @java.lang.SuppressWarnings("all")
                public FineractCacheDetails getDefaultTemplate() {
            return this.defaultTemplate;
        }

        @java.lang.SuppressWarnings("all")
                public Map<String, FineractCacheDetails> getCustomTemplates() {
            return this.customTemplates;
        }

        @java.lang.SuppressWarnings("all")
                public void setDefaultTemplate(final FineractCacheDetails defaultTemplate) {
            this.defaultTemplate = defaultTemplate;
        }

        @java.lang.SuppressWarnings("all")
                public void setCustomTemplates(final Map<String, FineractCacheDetails> customTemplates) {
            this.customTemplates = customTemplates;
        }
    }


    public static class FineractCacheDetails {
        private Duration ttl;
        private Integer maximumEntries;

        @java.lang.SuppressWarnings("all")
                public Duration getTtl() {
            return this.ttl;
        }

        @java.lang.SuppressWarnings("all")
                public Integer getMaximumEntries() {
            return this.maximumEntries;
        }

        @java.lang.SuppressWarnings("all")
                public void setTtl(final Duration ttl) {
            this.ttl = ttl;
        }

        @java.lang.SuppressWarnings("all")
                public void setMaximumEntries(final Integer maximumEntries) {
            this.maximumEntries = maximumEntries;
        }
    }


    public static class RetryProperties {
        private InstancesProperties instances;


        public static class InstancesProperties {
            private ExecuteCommandProperties executeCommand;


            public static class ExecuteCommandProperties {
                private Class<? extends Throwable>[] retryExceptions;
                private Integer maxAttempts;
                private Boolean enableExponentialBackoff;
                private Double exponentialBackoffMultiplier;
                private Duration waitDuration;

                @java.lang.SuppressWarnings("all")
                                public Class<? extends Throwable>[] getRetryExceptions() {
                    return this.retryExceptions;
                }

                @java.lang.SuppressWarnings("all")
                                public Integer getMaxAttempts() {
                    return this.maxAttempts;
                }

                @java.lang.SuppressWarnings("all")
                                public Boolean getEnableExponentialBackoff() {
                    return this.enableExponentialBackoff;
                }

                @java.lang.SuppressWarnings("all")
                                public Double getExponentialBackoffMultiplier() {
                    return this.exponentialBackoffMultiplier;
                }

                @java.lang.SuppressWarnings("all")
                                public Duration getWaitDuration() {
                    return this.waitDuration;
                }

                @java.lang.SuppressWarnings("all")
                                public void setRetryExceptions(final Class<? extends Throwable>[] retryExceptions) {
                    this.retryExceptions = retryExceptions;
                }

                @java.lang.SuppressWarnings("all")
                                public void setMaxAttempts(final Integer maxAttempts) {
                    this.maxAttempts = maxAttempts;
                }

                @java.lang.SuppressWarnings("all")
                                public void setEnableExponentialBackoff(final Boolean enableExponentialBackoff) {
                    this.enableExponentialBackoff = enableExponentialBackoff;
                }

                @java.lang.SuppressWarnings("all")
                                public void setExponentialBackoffMultiplier(final Double exponentialBackoffMultiplier) {
                    this.exponentialBackoffMultiplier = exponentialBackoffMultiplier;
                }

                @java.lang.SuppressWarnings("all")
                                public void setWaitDuration(final Duration waitDuration) {
                    this.waitDuration = waitDuration;
                }
            }

            @java.lang.SuppressWarnings("all")
                        public void setExecuteCommand(final ExecuteCommandProperties executeCommand) {
                this.executeCommand = executeCommand;
            }

            @java.lang.SuppressWarnings("all")
                        public ExecuteCommandProperties getExecuteCommand() {
                return this.executeCommand;
            }
        }

        @java.lang.SuppressWarnings("all")
                public void setInstances(final InstancesProperties instances) {
            this.instances = instances;
        }

        @java.lang.SuppressWarnings("all")
                public InstancesProperties getInstances() {
            return this.instances;
        }
    }


    public static class CorsProperties {
        private boolean enabled;
        private List<String> allowedOriginPatterns;
        private List<String> allowedMethods;
        private List<String> allowedHeaders;
        private List<String> exposedHeaders;
        private boolean allowCredentials;

        @java.lang.SuppressWarnings("all")
                public boolean isEnabled() {
            return this.enabled;
        }

        @java.lang.SuppressWarnings("all")
                public List<String> getAllowedOriginPatterns() {
            return this.allowedOriginPatterns;
        }

        @java.lang.SuppressWarnings("all")
                public List<String> getAllowedMethods() {
            return this.allowedMethods;
        }

        @java.lang.SuppressWarnings("all")
                public List<String> getAllowedHeaders() {
            return this.allowedHeaders;
        }

        @java.lang.SuppressWarnings("all")
                public List<String> getExposedHeaders() {
            return this.exposedHeaders;
        }

        @java.lang.SuppressWarnings("all")
                public boolean isAllowCredentials() {
            return this.allowCredentials;
        }

        @java.lang.SuppressWarnings("all")
                public void setEnabled(final boolean enabled) {
            this.enabled = enabled;
        }

        @java.lang.SuppressWarnings("all")
                public void setAllowedOriginPatterns(final List<String> allowedOriginPatterns) {
            this.allowedOriginPatterns = allowedOriginPatterns;
        }

        @java.lang.SuppressWarnings("all")
                public void setAllowedMethods(final List<String> allowedMethods) {
            this.allowedMethods = allowedMethods;
        }

        @java.lang.SuppressWarnings("all")
                public void setAllowedHeaders(final List<String> allowedHeaders) {
            this.allowedHeaders = allowedHeaders;
        }

        @java.lang.SuppressWarnings("all")
                public void setExposedHeaders(final List<String> exposedHeaders) {
            this.exposedHeaders = exposedHeaders;
        }

        @java.lang.SuppressWarnings("all")
                public void setAllowCredentials(final boolean allowCredentials) {
            this.allowCredentials = allowCredentials;
        }
    }


    public static class FineractDefaultValues {
        private Long officeId;

        @java.lang.SuppressWarnings("all")
                public Long getOfficeId() {
            return this.officeId;
        }

        @java.lang.SuppressWarnings("all")
                public void setOfficeId(final Long officeId) {
            this.officeId = officeId;
        }
    }

    @java.lang.SuppressWarnings("all")
        public String getNodeId() {
        return this.nodeId;
    }

    @java.lang.SuppressWarnings("all")
        public String getIdempotencyKeyHeaderName() {
        return this.idempotencyKeyHeaderName;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getInsecureHttpClient() {
        return this.insecureHttpClient;
    }

    @java.lang.SuppressWarnings("all")
        public long getClientConnectTimeout() {
        return this.clientConnectTimeout;
    }

    @java.lang.SuppressWarnings("all")
        public long getClientReadTimeout() {
        return this.clientReadTimeout;
    }

    @java.lang.SuppressWarnings("all")
        public long getClientWriteTimeout() {
        return this.clientWriteTimeout;
    }

    @java.lang.SuppressWarnings("all")
        public FineractTenantProperties getTenant() {
        return this.tenant;
    }

    @java.lang.SuppressWarnings("all")
        public FineractModeProperties getMode() {
        return this.mode;
    }

    @java.lang.SuppressWarnings("all")
        public FineractCorrelationProperties getCorrelation() {
        return this.correlation;
    }

    @java.lang.SuppressWarnings("all")
        public FineractIpTrackingProperties getIpTracking() {
        return this.ipTracking;
    }

    @java.lang.SuppressWarnings("all")
        public FineractPartitionedJob getPartitionedJob() {
        return this.partitionedJob;
    }

    @java.lang.SuppressWarnings("all")
        public FineractRemoteJobMessageHandlerProperties getRemoteJobMessageHandler() {
        return this.remoteJobMessageHandler;
    }

    @java.lang.SuppressWarnings("all")
        public FineractEventsProperties getEvents() {
        return this.events;
    }

    @java.lang.SuppressWarnings("all")
        public FineractTaskExecutor getTaskExecutor() {
        return this.taskExecutor;
    }

    @java.lang.SuppressWarnings("all")
        public FineractContentProperties getContent() {
        return this.content;
    }

    @java.lang.SuppressWarnings("all")
        public FineractReportProperties getReport() {
        return this.report;
    }

    @java.lang.SuppressWarnings("all")
        public FineractJobProperties getJob() {
        return this.job;
    }

    @java.lang.SuppressWarnings("all")
        public FineractTemplateProperties getTemplate() {
        return this.template;
    }

    @java.lang.SuppressWarnings("all")
        public FineractJpaProperties getJpa() {
        return this.jpa;
    }

    @java.lang.SuppressWarnings("all")
        public FineractDatabaseProperties getDatabase() {
        return this.database;
    }

    @java.lang.SuppressWarnings("all")
        public FineractQueryProperties getQuery() {
        return this.query;
    }

    @java.lang.SuppressWarnings("all")
        public FineractApiProperties getApi() {
        return this.api;
    }

    @java.lang.SuppressWarnings("all")
        public FineractSecurityProperties getSecurity() {
        return this.security;
    }

    @java.lang.SuppressWarnings("all")
        public FineractNotificationProperties getNotification() {
        return this.notification;
    }

    @java.lang.SuppressWarnings("all")
        public FineractLoanProperties getLoan() {
        return this.loan;
    }

    @java.lang.SuppressWarnings("all")
        public FineractSamplingProperties getSampling() {
        return this.sampling;
    }

    @java.lang.SuppressWarnings("all")
        public FineractModulesProperties getModule() {
        return this.module;
    }

    @java.lang.SuppressWarnings("all")
        public FineractSqlValidationProperties getSqlValidation() {
        return this.sqlValidation;
    }

    @java.lang.SuppressWarnings("all")
        public FineractInputValidationProperties getInputValidation() {
        return this.inputValidation;
    }

    @java.lang.SuppressWarnings("all")
        public FineractCache getCache() {
        return this.cache;
    }

    @java.lang.SuppressWarnings("all")
        public RetryProperties getRetry() {
        return this.retry;
    }

    @java.lang.SuppressWarnings("all")
        public FineractDefaultValues getDefaults() {
        return this.defaults;
    }

    @java.lang.SuppressWarnings("all")
        public void setNodeId(final String nodeId) {
        this.nodeId = nodeId;
    }

    @java.lang.SuppressWarnings("all")
        public void setIdempotencyKeyHeaderName(final String idempotencyKeyHeaderName) {
        this.idempotencyKeyHeaderName = idempotencyKeyHeaderName;
    }

    @java.lang.SuppressWarnings("all")
        public void setInsecureHttpClient(final Boolean insecureHttpClient) {
        this.insecureHttpClient = insecureHttpClient;
    }

    @java.lang.SuppressWarnings("all")
        public void setClientConnectTimeout(final long clientConnectTimeout) {
        this.clientConnectTimeout = clientConnectTimeout;
    }

    @java.lang.SuppressWarnings("all")
        public void setClientReadTimeout(final long clientReadTimeout) {
        this.clientReadTimeout = clientReadTimeout;
    }

    @java.lang.SuppressWarnings("all")
        public void setClientWriteTimeout(final long clientWriteTimeout) {
        this.clientWriteTimeout = clientWriteTimeout;
    }

    @java.lang.SuppressWarnings("all")
        public void setTenant(final FineractTenantProperties tenant) {
        this.tenant = tenant;
    }

    @java.lang.SuppressWarnings("all")
        public void setMode(final FineractModeProperties mode) {
        this.mode = mode;
    }

    @java.lang.SuppressWarnings("all")
        public void setCorrelation(final FineractCorrelationProperties correlation) {
        this.correlation = correlation;
    }

    @java.lang.SuppressWarnings("all")
        public void setIpTracking(final FineractIpTrackingProperties ipTracking) {
        this.ipTracking = ipTracking;
    }

    @java.lang.SuppressWarnings("all")
        public void setPartitionedJob(final FineractPartitionedJob partitionedJob) {
        this.partitionedJob = partitionedJob;
    }

    @java.lang.SuppressWarnings("all")
        public void setRemoteJobMessageHandler(final FineractRemoteJobMessageHandlerProperties remoteJobMessageHandler) {
        this.remoteJobMessageHandler = remoteJobMessageHandler;
    }

    @java.lang.SuppressWarnings("all")
        public void setEvents(final FineractEventsProperties events) {
        this.events = events;
    }

    @java.lang.SuppressWarnings("all")
        public void setTaskExecutor(final FineractTaskExecutor taskExecutor) {
        this.taskExecutor = taskExecutor;
    }

    @java.lang.SuppressWarnings("all")
        public void setContent(final FineractContentProperties content) {
        this.content = content;
    }

    @java.lang.SuppressWarnings("all")
        public void setReport(final FineractReportProperties report) {
        this.report = report;
    }

    @java.lang.SuppressWarnings("all")
        public void setJob(final FineractJobProperties job) {
        this.job = job;
    }

    @java.lang.SuppressWarnings("all")
        public void setTemplate(final FineractTemplateProperties template) {
        this.template = template;
    }

    @java.lang.SuppressWarnings("all")
        public void setJpa(final FineractJpaProperties jpa) {
        this.jpa = jpa;
    }

    @java.lang.SuppressWarnings("all")
        public void setDatabase(final FineractDatabaseProperties database) {
        this.database = database;
    }

    @java.lang.SuppressWarnings("all")
        public void setQuery(final FineractQueryProperties query) {
        this.query = query;
    }

    @java.lang.SuppressWarnings("all")
        public void setApi(final FineractApiProperties api) {
        this.api = api;
    }

    @java.lang.SuppressWarnings("all")
        public void setSecurity(final FineractSecurityProperties security) {
        this.security = security;
    }

    @java.lang.SuppressWarnings("all")
        public void setNotification(final FineractNotificationProperties notification) {
        this.notification = notification;
    }

    @java.lang.SuppressWarnings("all")
        public void setLoan(final FineractLoanProperties loan) {
        this.loan = loan;
    }

    @java.lang.SuppressWarnings("all")
        public void setSampling(final FineractSamplingProperties sampling) {
        this.sampling = sampling;
    }

    @java.lang.SuppressWarnings("all")
        public void setModule(final FineractModulesProperties module) {
        this.module = module;
    }

    @java.lang.SuppressWarnings("all")
        public void setSqlValidation(final FineractSqlValidationProperties sqlValidation) {
        this.sqlValidation = sqlValidation;
    }

    @java.lang.SuppressWarnings("all")
        public void setInputValidation(final FineractInputValidationProperties inputValidation) {
        this.inputValidation = inputValidation;
    }

    @java.lang.SuppressWarnings("all")
        public void setCache(final FineractCache cache) {
        this.cache = cache;
    }

    @java.lang.SuppressWarnings("all")
        public void setRetry(final RetryProperties retry) {
        this.retry = retry;
    }

    @java.lang.SuppressWarnings("all")
        public void setDefaults(final FineractDefaultValues defaults) {
        this.defaults = defaults;
    }
}
