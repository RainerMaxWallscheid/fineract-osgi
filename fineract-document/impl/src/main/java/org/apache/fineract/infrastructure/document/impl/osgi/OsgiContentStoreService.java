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
package org.apache.fineract.infrastructure.document.impl.osgi;

import java.io.IOException;
import java.io.InputStream;
import org.apache.fineract.infrastructure.contentstore.data.ContentStoreType;
import org.apache.fineract.infrastructure.contentstore.exception.ContentStoreException;
import org.apache.fineract.infrastructure.contentstore.service.ContentStoreService;

/**
 * Empty content store for Equinox without Spring/FS/S3. Same outcome as a
 * filesystem store that has no objects.
 */
final class OsgiContentStoreService implements ContentStoreService {

    @Override
    public InputStream download(final String path) {
        throw new ContentStoreException(new IOException("no content store"));
    }

    @Override
    public String upload(final String path, final InputStream is, final String mimeType) {
        throw new ContentStoreException(new IOException("no content store"));
    }

    @Override
    public void delete(final String path) {
        // nothing stored
    }

    @Override
    public ContentStoreType getType() {
        return ContentStoreType.FILE_SYSTEM;
    }
}
