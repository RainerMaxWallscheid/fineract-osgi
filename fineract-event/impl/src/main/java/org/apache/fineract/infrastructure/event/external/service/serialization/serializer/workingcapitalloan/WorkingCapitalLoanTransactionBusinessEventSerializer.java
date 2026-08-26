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
package org.apache.fineract.infrastructure.event.external.service.serialization.serializer.workingcapitalloan;

import org.apache.avro.generic.GenericContainer;
import org.apache.fineract.avro.generator.ByteBufferSerializable;
import org.apache.fineract.avro.workingcapitalloan.v1.WorkingCapitalLoanTransactionDataV1;
import org.apache.fineract.infrastructure.event.business.domain.BusinessEvent;
import org.apache.fineract.infrastructure.event.external.service.serialization.mapper.workingcapitalloan.WorkingCapitalLoanTransactionDataMapper;
import org.apache.fineract.infrastructure.event.external.service.serialization.serializer.BusinessEventSerializer;
import org.apache.fineract.portfolio.workingcapitalloan.data.WorkingCapitalLoanTransactionData;
import org.apache.fineract.portfolio.workingcapitalloan.moduleapi.WorkingCapitalLoanTransactionEventDataPort;
import org.springframework.stereotype.Component;

@Component
public class WorkingCapitalLoanTransactionBusinessEventSerializer implements BusinessEventSerializer {
    private final WorkingCapitalLoanTransactionEventDataPort eventDataPort;
    private final WorkingCapitalLoanTransactionDataMapper mapper;

    @Override
    public <T> boolean canSerialize(BusinessEvent<T> event) {
        return eventDataPort.isTransactionEvent(event);
    }

    @Override
    public <T> ByteBufferSerializable toAvroDTO(BusinessEvent<T> rawEvent) {
        final WorkingCapitalLoanTransactionData data = eventDataPort.retrieveForEvent(rawEvent);
        return mapper.map(data);
    }

    @Override
    public Class<? extends GenericContainer> getSupportedSchema() {
        return WorkingCapitalLoanTransactionDataV1.class;
    }

    @java.lang.SuppressWarnings("all")
        public WorkingCapitalLoanTransactionBusinessEventSerializer(final WorkingCapitalLoanTransactionEventDataPort eventDataPort, final WorkingCapitalLoanTransactionDataMapper mapper) {
        this.eventDataPort = eventDataPort;
        this.mapper = mapper;
    }
}
