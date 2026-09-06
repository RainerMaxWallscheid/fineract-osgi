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
package org.apache.fineract.infrastructure.bulkimport.impl.osgi;

import java.io.InputStream;
import java.util.Collection;
import org.apache.fineract.infrastructure.bulkimport.data.GlobalEntityType;
import org.apache.fineract.infrastructure.bulkimport.data.ImportData;
import org.apache.fineract.infrastructure.bulkimport.service.BulkImportWorkbookService;

/**
 * Empty workbook-import port for Equinox without Spring/JPA. Published by {@code OSGI-INF/bulkimport-workbook.xml}
 * (ADR-022 B6).
 */
public final class OsgiBulkImportWorkbookService implements BulkImportWorkbookService {

    @Override
    public Long importWorkbook(final String entityType, final InputStream inputStream, final Object fileDetail, final String locale,
            final String dateFormat) {
        return null;
    }

    @Override
    public Collection<ImportData> getImports(final GlobalEntityType type) {
        return null;
    }

    @Override
    public ImportData getImport(final Long id) {
        return null;
    }
}
