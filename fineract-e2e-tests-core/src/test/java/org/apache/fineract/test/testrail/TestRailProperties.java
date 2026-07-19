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
package org.apache.fineract.test.testrail;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class TestRailProperties {
    @Value("${fineract-test.testrail.enabled}")
    private boolean enabled;
    @Value("${fineract-test.testrail.base-url}")
    private String baseUrl;
    @Value("${fineract-test.testrail.username}")
    private String username;
    @Value("${fineract-test.testrail.password}")
    private String password;
    @Value("${fineract-test.testrail.run-id}")
    private int runId;

    @java.lang.SuppressWarnings("all")
        public boolean isEnabled() {
        return this.enabled;
    }

    @java.lang.SuppressWarnings("all")
        public String getBaseUrl() {
        return this.baseUrl;
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
        public int getRunId() {
        return this.runId;
    }
}
