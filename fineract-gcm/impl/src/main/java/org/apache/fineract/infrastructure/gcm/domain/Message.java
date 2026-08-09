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
package org.apache.fineract.infrastructure.gcm.domain;

import java.io.Serializable;
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.Map;
import org.apache.fineract.infrastructure.gcm.GcmConstants;

/**
 * GCM message.
 *
 * <p>
 * Instances of this class are immutable and should be created using a {@link Builder}. Examples:
 *
 * <strong>Simplest message:</strong>
 *
 * <pre>
 * <code>
 * Message message = new Message.Builder().build();
 * </pre>
 *
 * </code>
 *
 * <strong>Message with optional attributes:</strong>
 *
 * <pre>
 * <code>
 * Message message = new Message.Builder()
 *    .collapseKey(collapseKey)
 *    .timeToLive(3)
 *    .delayWhileIdle(true)
 *    .dryRun(true)
 *    .restrictedPackageName(restrictedPackageName)
 *    .build();
 * </pre>
 *
 * </code>
 *
 * <strong>Message with optional attributes and payload data:</strong>
 *
 * <pre>
 * <code>
 * Message message = new Message.Builder()
 *    .priority("normal")
 *    .collapseKey(collapseKey)
 *    .timeToLive(3)
 *    .delayWhileIdle(true)
 *    .dryRun(true)
 *    .restrictedPackageName(restrictedPackageName)
 *    .addData("key1", "value1")
 *    .addData("key2", "value2")
 *    .build();
 * </pre>
 *
 * </code>
 */
public final class Message implements Serializable {
    private static final long serialVersionUID = 1L;
    private String collapseKey;
    private Boolean delayWhileIdle;
    private Integer timeToLive;
    private Map<String, String> data;
    private Boolean dryRun;
    private String restrictedPackageName;
    private String priority;
    private Boolean contentAvailable;
    private Notification notification;


    public enum Priority {
        NORMAL,  //
        HIGH //
        ;
    }


    public static final class Builder {
        private final Map<String, String> data;
        // optional parameters
        private String collapseKey;
        private Boolean delayWhileIdle;
        private Integer timeToLive;
        private Boolean dryRun;
        private String restrictedPackageName;
        private String priority;
        private Boolean contentAvailable;
        private Notification notification;

        public Builder() {
            this.data = new LinkedHashMap<>();
        }

        /**
         * Sets the collapseKey property.
         */
        public Builder collapseKey(String value) {
            collapseKey = value;
            return this;
        }

        /**
         * Sets the delayWhileIdle property (default value is {@literal false}).
         */
        public Builder delayWhileIdle(boolean value) {
            delayWhileIdle = value;
            return this;
        }

        /**
         * Sets the time to live, in seconds.
         */
        public Builder timeToLive(int value) {
            timeToLive = value;
            return this;
        }

        /**
         * Adds a key/value pair to the payload data.
         */
        public Builder addData(String key, String value) {
            data.put(key, value);
            return this;
        }

        /**
         * Sets the dryRun property (default value is {@literal false}).
         */
        public Builder dryRun(boolean value) {
            dryRun = value;
            return this;
        }

        /**
         * Sets the restrictedPackageName property.
         */
        public Builder restrictedPackageName(String value) {
            restrictedPackageName = value;
            return this;
        }

        /**
         * Sets the priority property.
         */
        public Builder priority(Priority value) {
            switch (value) {
            case NORMAL: 
                priority = GcmConstants.MESSAGE_PRIORITY_NORMAL;
                break;
            case HIGH: 
                priority = GcmConstants.MESSAGE_PRIORITY_HIGH;
                break;
            }
            return this;
        }

        /**
         * Sets the notification property.
         */
        public Builder notification(Notification value) {
            notification = value;
            return this;
        }

        /**
         * Sets the contentAvailable property
         */
        public Builder contentAvailable(Boolean value) {
            contentAvailable = value;
            return this;
        }

        public Message build() {
            return new Message(this);
        }
    }

    private Message(Builder builder) {
        collapseKey = builder.collapseKey;
        delayWhileIdle = builder.delayWhileIdle;
        data = Collections.unmodifiableMap(builder.data);
        timeToLive = builder.timeToLive;
        dryRun = builder.dryRun;
        restrictedPackageName = builder.restrictedPackageName;
        priority = builder.priority;
        contentAvailable = builder.contentAvailable;
        notification = builder.notification;
    }

    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder("Message(");
        if (priority != null) {
            builder.append("priority=").append(priority).append(", ");
        }
        if (contentAvailable != null) {
            builder.append("contentAvailable=").append(contentAvailable).append(", ");
        }
        if (collapseKey != null) {
            builder.append("collapseKey=").append(collapseKey).append(", ");
        }
        if (timeToLive != null) {
            builder.append("timeToLive=").append(timeToLive).append(", ");
        }
        if (delayWhileIdle != null) {
            builder.append("delayWhileIdle=").append(delayWhileIdle).append(", ");
        }
        if (dryRun != null) {
            builder.append("dryRun=").append(dryRun).append(", ");
        }
        if (restrictedPackageName != null) {
            builder.append("restrictedPackageName=").append(restrictedPackageName).append(", ");
        }
        if (notification != null) {
            builder.append("notification: ").append(notification).append(", ");
        }
        if (!data.isEmpty()) {
            builder.append("data: {");
            for (Map.Entry<String, String> entry : data.entrySet()) {
                builder.append(entry.getKey()).append("=").append(entry.getValue()).append(",");
            }
            builder.delete(builder.length() - 1, builder.length());
            builder.append("}");
        }
        if (builder.charAt(builder.length() - 1) == ' ') {
            builder.delete(builder.length() - 2, builder.length());
        }
        builder.append(")");
        return builder.toString();
    }

    @java.lang.SuppressWarnings("all")
        public String getCollapseKey() {
        return this.collapseKey;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getDelayWhileIdle() {
        return this.delayWhileIdle;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getTimeToLive() {
        return this.timeToLive;
    }

    @java.lang.SuppressWarnings("all")
        public Map<String, String> getData() {
        return this.data;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getDryRun() {
        return this.dryRun;
    }

    @java.lang.SuppressWarnings("all")
        public String getRestrictedPackageName() {
        return this.restrictedPackageName;
    }

    @java.lang.SuppressWarnings("all")
        public String getPriority() {
        return this.priority;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getContentAvailable() {
        return this.contentAvailable;
    }

    @java.lang.SuppressWarnings("all")
        public Notification getNotification() {
        return this.notification;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Message setCollapseKey(final String collapseKey) {
        this.collapseKey = collapseKey;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Message setDelayWhileIdle(final Boolean delayWhileIdle) {
        this.delayWhileIdle = delayWhileIdle;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Message setTimeToLive(final Integer timeToLive) {
        this.timeToLive = timeToLive;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Message setData(final Map<String, String> data) {
        this.data = data;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Message setDryRun(final Boolean dryRun) {
        this.dryRun = dryRun;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Message setRestrictedPackageName(final String restrictedPackageName) {
        this.restrictedPackageName = restrictedPackageName;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Message setPriority(final String priority) {
        this.priority = priority;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Message setContentAvailable(final Boolean contentAvailable) {
        this.contentAvailable = contentAvailable;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Message setNotification(final Notification notification) {
        this.notification = notification;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof Message)) return false;
        final Message other = (Message) o;
        final java.lang.Object this$delayWhileIdle = this.getDelayWhileIdle();
        final java.lang.Object other$delayWhileIdle = other.getDelayWhileIdle();
        if (this$delayWhileIdle == null ? other$delayWhileIdle != null : !this$delayWhileIdle.equals(other$delayWhileIdle)) return false;
        final java.lang.Object this$timeToLive = this.getTimeToLive();
        final java.lang.Object other$timeToLive = other.getTimeToLive();
        if (this$timeToLive == null ? other$timeToLive != null : !this$timeToLive.equals(other$timeToLive)) return false;
        final java.lang.Object this$dryRun = this.getDryRun();
        final java.lang.Object other$dryRun = other.getDryRun();
        if (this$dryRun == null ? other$dryRun != null : !this$dryRun.equals(other$dryRun)) return false;
        final java.lang.Object this$contentAvailable = this.getContentAvailable();
        final java.lang.Object other$contentAvailable = other.getContentAvailable();
        if (this$contentAvailable == null ? other$contentAvailable != null : !this$contentAvailable.equals(other$contentAvailable)) return false;
        final java.lang.Object this$collapseKey = this.getCollapseKey();
        final java.lang.Object other$collapseKey = other.getCollapseKey();
        if (this$collapseKey == null ? other$collapseKey != null : !this$collapseKey.equals(other$collapseKey)) return false;
        final java.lang.Object this$data = this.getData();
        final java.lang.Object other$data = other.getData();
        if (this$data == null ? other$data != null : !this$data.equals(other$data)) return false;
        final java.lang.Object this$restrictedPackageName = this.getRestrictedPackageName();
        final java.lang.Object other$restrictedPackageName = other.getRestrictedPackageName();
        if (this$restrictedPackageName == null ? other$restrictedPackageName != null : !this$restrictedPackageName.equals(other$restrictedPackageName)) return false;
        final java.lang.Object this$priority = this.getPriority();
        final java.lang.Object other$priority = other.getPriority();
        if (this$priority == null ? other$priority != null : !this$priority.equals(other$priority)) return false;
        final java.lang.Object this$notification = this.getNotification();
        final java.lang.Object other$notification = other.getNotification();
        if (this$notification == null ? other$notification != null : !this$notification.equals(other$notification)) return false;
        return true;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $delayWhileIdle = this.getDelayWhileIdle();
        result = result * PRIME + ($delayWhileIdle == null ? 43 : $delayWhileIdle.hashCode());
        final java.lang.Object $timeToLive = this.getTimeToLive();
        result = result * PRIME + ($timeToLive == null ? 43 : $timeToLive.hashCode());
        final java.lang.Object $dryRun = this.getDryRun();
        result = result * PRIME + ($dryRun == null ? 43 : $dryRun.hashCode());
        final java.lang.Object $contentAvailable = this.getContentAvailable();
        result = result * PRIME + ($contentAvailable == null ? 43 : $contentAvailable.hashCode());
        final java.lang.Object $collapseKey = this.getCollapseKey();
        result = result * PRIME + ($collapseKey == null ? 43 : $collapseKey.hashCode());
        final java.lang.Object $data = this.getData();
        result = result * PRIME + ($data == null ? 43 : $data.hashCode());
        final java.lang.Object $restrictedPackageName = this.getRestrictedPackageName();
        result = result * PRIME + ($restrictedPackageName == null ? 43 : $restrictedPackageName.hashCode());
        final java.lang.Object $priority = this.getPriority();
        result = result * PRIME + ($priority == null ? 43 : $priority.hashCode());
        final java.lang.Object $notification = this.getNotification();
        result = result * PRIME + ($notification == null ? 43 : $notification.hashCode());
        return result;
    }

    @java.lang.SuppressWarnings("all")
        public Message() {
    }
}
