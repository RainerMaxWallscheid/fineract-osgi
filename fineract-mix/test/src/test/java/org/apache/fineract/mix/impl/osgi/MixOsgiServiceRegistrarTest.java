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
package org.apache.fineract.mix.impl.osgi;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import org.apache.fineract.mix.service.MixReportXBRLNamespaceReadService;
import org.apache.fineract.mix.service.MixReportXBRLResultService;
import org.apache.fineract.mix.service.MixTaxonomyMappingReadService;
import org.apache.fineract.mix.service.MixTaxonomyMappingWriteService;
import org.apache.fineract.mix.service.MixTaxonomyReadService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.ObjectProvider;

/**
 * Without OSGi on the classpath the registrar must no-op (same pattern as branch/loan-origination).
 */
class MixOsgiServiceRegistrarTest {

    @Test
    void afterPropertiesSet_noOpsWithoutOsgi() {
        @SuppressWarnings("unchecked")
        final ObjectProvider<MixTaxonomyReadService> taxonomyRead = mock(ObjectProvider.class);
        @SuppressWarnings("unchecked")
        final ObjectProvider<MixTaxonomyMappingReadService> mappingRead = mock(ObjectProvider.class);
        @SuppressWarnings("unchecked")
        final ObjectProvider<MixTaxonomyMappingWriteService> mappingWrite = mock(ObjectProvider.class);
        @SuppressWarnings("unchecked")
        final ObjectProvider<MixReportXBRLResultService> xbrlResult = mock(ObjectProvider.class);
        @SuppressWarnings("unchecked")
        final ObjectProvider<MixReportXBRLNamespaceReadService> namespaceRead = mock(ObjectProvider.class);
        when(taxonomyRead.getIfAvailable()).thenReturn(mock(MixTaxonomyReadService.class));
        when(mappingRead.getIfAvailable()).thenReturn(mock(MixTaxonomyMappingReadService.class));
        when(mappingWrite.getIfAvailable()).thenReturn(mock(MixTaxonomyMappingWriteService.class));
        when(xbrlResult.getIfAvailable()).thenReturn(mock(MixReportXBRLResultService.class));
        when(namespaceRead.getIfAvailable()).thenReturn(mock(MixReportXBRLNamespaceReadService.class));

        final MixOsgiServiceRegistrar registrar = new MixOsgiServiceRegistrar(taxonomyRead, mappingRead, mappingWrite, xbrlResult,
                namespaceRead);
        assertDoesNotThrow(registrar::afterPropertiesSet);
        assertDoesNotThrow(registrar::destroy);
    }
}
