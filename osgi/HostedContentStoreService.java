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
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import org.apache.fineract.infrastructure.contentstore.data.ContentStoreType;
import org.apache.fineract.infrastructure.contentstore.exception.ContentStoreException;
import org.apache.fineract.infrastructure.contentstore.service.ContentStoreService;

/**
 * Composition-root hosted content store for the Equinox bridge smoke. Not FS/S3.
 */
final class HostedContentStoreService implements ContentStoreService {

    static final String HOSTED_PATH = "hosted/hello.txt";
    static final byte[] HOSTED_BYTES = "hello".getBytes(StandardCharsets.UTF_8);

    private final Map<String, byte[]> objects = new ConcurrentHashMap<>();

    HostedContentStoreService() {
        objects.put(HOSTED_PATH, HOSTED_BYTES);
    }

    @Override
    public InputStream download(final String path) {
        final byte[] bytes = path == null ? null : objects.get(path);
        if (bytes == null) {
            throw new ContentStoreException(new IOException("no content: " + path));
        }
        return new ByteArrayInputStream(bytes);
    }

    @Override
    public String upload(final String path, final InputStream is, final String mimeType) {
        try {
            objects.put(path, is.readAllBytes());
        } catch (final IOException ex) {
            throw new ContentStoreException(ex);
        }
        return path;
    }

    @Override
    public void delete(final String path) {
        if (path != null) {
            objects.remove(path);
        }
    }

    @Override
    public ContentStoreType getType() {
        return ContentStoreType.FILE_SYSTEM;
    }
}
