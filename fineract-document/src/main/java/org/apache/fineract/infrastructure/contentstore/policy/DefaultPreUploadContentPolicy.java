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
package org.apache.fineract.infrastructure.contentstore.policy;

import org.springframework.stereotype.Component;

@Component
public class DefaultPreUploadContentPolicy implements ContentPolicy {
    @java.lang.SuppressWarnings("all")
        private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(DefaultPreUploadContentPolicy.class);
    private final WhitelistContentPolicy whitelistContentPolicy;
    private final TraversalContentPolicy traversalContentPolicy;

    @Override
    public void check(ContentPolicyContext ctx) {
        traversalContentPolicy.check(ctx);
        whitelistContentPolicy.check(ctx);
    }

    @java.lang.SuppressWarnings("all")
        public DefaultPreUploadContentPolicy(final WhitelistContentPolicy whitelistContentPolicy, final TraversalContentPolicy traversalContentPolicy) {
        this.whitelistContentPolicy = whitelistContentPolicy;
        this.traversalContentPolicy = traversalContentPolicy;
    }
}
