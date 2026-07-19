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
package org.apache.fineract.test.data.codevalue;

import static org.apache.fineract.client.feign.util.FeignCalls.ok;
import java.util.List;
import java.util.Map;
import org.apache.fineract.client.feign.FineractFeignClient;
import org.apache.fineract.client.models.GetCodeValuesDataResponse;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Component;

@Component
public class CodeValueResolver {
    @java.lang.SuppressWarnings("all")
        private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(CodeValueResolver.class);
    private final FineractFeignClient fineractClient;

    @Cacheable(key = "#codeId + \'-\' + #codeValue", value = "codeValuesByName")
    public long resolve(Long codeId, CodeValue codeValue) {
        String codeValueName = codeValue.getName();
        log.debug("Resolving code value by code id and name [{}]", codeValue);
        List<GetCodeValuesDataResponse> codeValuesResponses = ok(() -> fineractClient.codeValues().retrieveAllCodeValues(codeId, Map.of()));
        GetCodeValuesDataResponse foundPtr = codeValuesResponses.stream().filter(ptr -> codeValueName.equals(ptr.getName())).findAny().orElseThrow(() -> new IllegalArgumentException("Code Value [%s] not found for Code [%s]".formatted(codeValueName, codeId)));
        return foundPtr.getId();
    }

    @Cacheable(key = "#codeName + \'-\' + #codeValue", value = "codeValuesByName")
    public long resolve(String codeName, String codeValue) {
        log.debug("Resolving code value by code id and name [{}]", codeValue);
        List<GetCodeValuesDataResponse> codeValuesResponses = ok(() -> fineractClient.codeValues().retrieveAllCodeValuesByCodeName(codeName, Map.of()));
        GetCodeValuesDataResponse foundPtr = codeValuesResponses.stream().filter(ptr -> codeValue.equals(ptr.getName())).findAny().orElseThrow(() -> new IllegalArgumentException("Code Value [%s] not found for Code [%s]".formatted(codeValue, codeName)));
        return foundPtr.getId();
    }

    @java.lang.SuppressWarnings("all")
        public CodeValueResolver(final FineractFeignClient fineractClient) {
        this.fineractClient = fineractClient;
    }
}
