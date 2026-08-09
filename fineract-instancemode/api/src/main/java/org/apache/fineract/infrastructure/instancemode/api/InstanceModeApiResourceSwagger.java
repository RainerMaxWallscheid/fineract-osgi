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
package org.apache.fineract.infrastructure.instancemode.api;

import io.swagger.v3.oas.annotations.media.Schema;

public class InstanceModeApiResourceSwagger {

    @Schema(description = "ChangeInstanceModeRequest")
    public static final class ChangeInstanceModeRequest {
        @Schema(requiredMode = Schema.RequiredMode.REQUIRED, example = "true")
        public boolean readEnabled;
        @Schema(requiredMode = Schema.RequiredMode.REQUIRED, example = "true")
        public boolean writeEnabled;
        @Schema(requiredMode = Schema.RequiredMode.REQUIRED, example = "true")
        public boolean batchWorkerEnabled;
        @Schema(requiredMode = Schema.RequiredMode.REQUIRED, example = "true")
        public boolean batchManagerEnabled;

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "InstanceModeApiResourceSwagger.ChangeInstanceModeRequest(readEnabled=" + this.isReadEnabled() + ", writeEnabled=" + this.isWriteEnabled() + ", batchWorkerEnabled=" + this.isBatchWorkerEnabled() + ", batchManagerEnabled=" + this.isBatchManagerEnabled() + ")";
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
    }
}
