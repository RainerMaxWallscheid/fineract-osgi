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
import java.util.List;
import org.apache.fineract.mix.data.MixTaxonomyData;
import org.apache.fineract.mix.service.MixTaxonomyReadService;

/**
 * Composition-root hosted MIX taxonomy for the Equinox bridge smoke.
 * Not JPA — {@code MixTaxonomyReadServiceImpl} stays on the Boot classpath.
 */
final class HostedMixTaxonomyReadService implements MixTaxonomyReadService {

    static final long HOSTED_ID = 1L;

    private final MixTaxonomyData hosted = MixTaxonomyData.builder().id(HOSTED_ID).name("hosted").namespace("hosted")
            .type(MixTaxonomyData.PORTFOLIO).description("hosted").build();

    @Override
    public List<MixTaxonomyData> retrieveAll() {
        return List.of(hosted);
    }

    @Override
    public MixTaxonomyData retrieveOne(final Long id) {
        if (Long.valueOf(HOSTED_ID).equals(id)) {
            return hosted;
        }
        return null;
    }
}
