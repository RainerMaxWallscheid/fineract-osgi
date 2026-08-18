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

import org.apache.fineract.infrastructure.springbatch.PropertyService;

/** Composition-root hosted partition properties for the Equinox bridge smoke. */
final class HostedPropertyService implements PropertyService {

    static final int HOSTED_SIZE = 1;

    @Override
    public Integer getPartitionSize(final String jobName) {
        return HOSTED_SIZE;
    }

    @Override
    public Integer getChunkSize(final String jobName) {
        return HOSTED_SIZE;
    }

    @Override
    public Integer getRetryLimit(final String jobName) {
        return HOSTED_SIZE;
    }

    @Override
    public Integer getThreadPoolCorePoolSize(final String jobName) {
        return HOSTED_SIZE;
    }

    @Override
    public Integer getThreadPoolMaxPoolSize(final String jobName) {
        return HOSTED_SIZE;
    }

    @Override
    public Integer getThreadPoolQueueCapacity(final String jobName) {
        return HOSTED_SIZE;
    }

    @Override
    public Integer getPollInterval(final String jobName) {
        return HOSTED_SIZE;
    }
}
