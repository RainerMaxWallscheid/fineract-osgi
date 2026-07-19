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
package org.apache.fineract.command.disruptor;

import com.lmax.disruptor.dsl.ProducerType;
import java.io.Serial;
import java.io.Serializable;
import org.springframework.boot.context.properties.ConfigurationProperties;

@ConfigurationProperties(prefix = "fineract.command.disruptor")
public final class DisruptorCommandProperties implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private Boolean enabled;
    private Integer ringBufferSize;
    private ProducerType producerType;

    @java.lang.SuppressWarnings("all")
        private static Boolean $default$enabled() {
        return false;
    }

    @java.lang.SuppressWarnings("all")
        private static Integer $default$ringBufferSize() {
        return 1024;
    }

    @java.lang.SuppressWarnings("all")
        private static ProducerType $default$producerType() {
        return ProducerType.SINGLE;
    }


    @java.lang.SuppressWarnings("all")
        public static class DisruptorCommandPropertiesBuilder {
        @java.lang.SuppressWarnings("all")
                private boolean enabled$set;
        @java.lang.SuppressWarnings("all")
                private Boolean enabled$value;
        @java.lang.SuppressWarnings("all")
                private boolean ringBufferSize$set;
        @java.lang.SuppressWarnings("all")
                private Integer ringBufferSize$value;
        @java.lang.SuppressWarnings("all")
                private boolean producerType$set;
        @java.lang.SuppressWarnings("all")
                private ProducerType producerType$value;

        @java.lang.SuppressWarnings("all")
                DisruptorCommandPropertiesBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public DisruptorCommandProperties.DisruptorCommandPropertiesBuilder enabled(final Boolean enabled) {
            this.enabled$value = enabled;
            enabled$set = true;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public DisruptorCommandProperties.DisruptorCommandPropertiesBuilder ringBufferSize(final Integer ringBufferSize) {
            this.ringBufferSize$value = ringBufferSize;
            ringBufferSize$set = true;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public DisruptorCommandProperties.DisruptorCommandPropertiesBuilder producerType(final ProducerType producerType) {
            this.producerType$value = producerType;
            producerType$set = true;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public DisruptorCommandProperties build() {
            Boolean enabled$value = this.enabled$value;
            if (!this.enabled$set) enabled$value = DisruptorCommandProperties.$default$enabled();
            Integer ringBufferSize$value = this.ringBufferSize$value;
            if (!this.ringBufferSize$set) ringBufferSize$value = DisruptorCommandProperties.$default$ringBufferSize();
            ProducerType producerType$value = this.producerType$value;
            if (!this.producerType$set) producerType$value = DisruptorCommandProperties.$default$producerType();
            return new DisruptorCommandProperties(enabled$value, ringBufferSize$value, producerType$value);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "DisruptorCommandProperties.DisruptorCommandPropertiesBuilder(enabled$value=" + this.enabled$value + ", ringBufferSize$value=" + this.ringBufferSize$value + ", producerType$value=" + this.producerType$value + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static DisruptorCommandProperties.DisruptorCommandPropertiesBuilder builder() {
        return new DisruptorCommandProperties.DisruptorCommandPropertiesBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getEnabled() {
        return this.enabled;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getRingBufferSize() {
        return this.ringBufferSize;
    }

    @java.lang.SuppressWarnings("all")
        public ProducerType getProducerType() {
        return this.producerType;
    }

    @java.lang.SuppressWarnings("all")
        public void setEnabled(final Boolean enabled) {
        this.enabled = enabled;
    }

    @java.lang.SuppressWarnings("all")
        public void setRingBufferSize(final Integer ringBufferSize) {
        this.ringBufferSize = ringBufferSize;
    }

    @java.lang.SuppressWarnings("all")
        public void setProducerType(final ProducerType producerType) {
        this.producerType = producerType;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof DisruptorCommandProperties)) return false;
        final DisruptorCommandProperties other = (DisruptorCommandProperties) o;
        final java.lang.Object this$enabled = this.getEnabled();
        final java.lang.Object other$enabled = other.getEnabled();
        if (this$enabled == null ? other$enabled != null : !this$enabled.equals(other$enabled)) return false;
        final java.lang.Object this$ringBufferSize = this.getRingBufferSize();
        final java.lang.Object other$ringBufferSize = other.getRingBufferSize();
        if (this$ringBufferSize == null ? other$ringBufferSize != null : !this$ringBufferSize.equals(other$ringBufferSize)) return false;
        final java.lang.Object this$producerType = this.getProducerType();
        final java.lang.Object other$producerType = other.getProducerType();
        if (this$producerType == null ? other$producerType != null : !this$producerType.equals(other$producerType)) return false;
        return true;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $enabled = this.getEnabled();
        result = result * PRIME + ($enabled == null ? 43 : $enabled.hashCode());
        final java.lang.Object $ringBufferSize = this.getRingBufferSize();
        result = result * PRIME + ($ringBufferSize == null ? 43 : $ringBufferSize.hashCode());
        final java.lang.Object $producerType = this.getProducerType();
        result = result * PRIME + ($producerType == null ? 43 : $producerType.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "DisruptorCommandProperties(enabled=" + this.getEnabled() + ", ringBufferSize=" + this.getRingBufferSize() + ", producerType=" + this.getProducerType() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public DisruptorCommandProperties() {
        this.enabled = DisruptorCommandProperties.$default$enabled();
        this.ringBufferSize = DisruptorCommandProperties.$default$ringBufferSize();
        this.producerType = DisruptorCommandProperties.$default$producerType();
    }

    @java.lang.SuppressWarnings("all")
        public DisruptorCommandProperties(final Boolean enabled, final Integer ringBufferSize, final ProducerType producerType) {
        this.enabled = enabled;
        this.ringBufferSize = ringBufferSize;
        this.producerType = producerType;
    }


    @java.lang.SuppressWarnings("all")
        public static final class Fields {
        public static final java.lang.String enabled = "enabled";
        public static final java.lang.String ringBufferSize = "ringBufferSize";
        public static final java.lang.String producerType = "producerType";
    }
}
