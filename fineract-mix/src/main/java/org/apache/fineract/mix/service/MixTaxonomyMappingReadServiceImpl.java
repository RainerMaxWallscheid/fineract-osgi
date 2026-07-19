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
package org.apache.fineract.mix.service;

import org.apache.fineract.mix.data.MixTaxonomyMappingData;
import org.apache.fineract.mix.domain.MixTaxonomyMappingRepository;
import org.apache.fineract.mix.mapping.MixTaxonomyMappingMapper;
import org.springframework.stereotype.Service;

@Service
public class MixTaxonomyMappingReadServiceImpl implements MixTaxonomyMappingReadService {
    @java.lang.SuppressWarnings("all")
        private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(MixTaxonomyMappingReadServiceImpl.class);
    private final MixTaxonomyMappingRepository repository;
    private final MixTaxonomyMappingMapper mapper;

    @Override
    public MixTaxonomyMappingData retrieveTaxonomyMapping() {
        return repository.findAll().stream().findFirst().map(mapper::map).orElse(null);
    }

    @java.lang.SuppressWarnings("all")
        public MixTaxonomyMappingReadServiceImpl(final MixTaxonomyMappingRepository repository, final MixTaxonomyMappingMapper mapper) {
        this.repository = repository;
        this.mapper = mapper;
    }
}
