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
package org.apache.fineract.infrastructure.contentstore.service;

import static java.util.Objects.requireNonNull;
import java.io.InputStream;
import org.apache.fineract.infrastructure.contentstore.data.ContentStoreType;
import org.apache.fineract.infrastructure.contentstore.detector.ContentDetectorManager;
import org.apache.fineract.infrastructure.contentstore.exception.ContentPolicyException;
import org.apache.fineract.infrastructure.contentstore.exception.ContentStoreException;
import org.apache.fineract.infrastructure.contentstore.policy.ContentPolicyContext;
import org.apache.fineract.infrastructure.contentstore.policy.DefaultDeleteContentPolicy;
import org.apache.fineract.infrastructure.contentstore.policy.DefaultDownloadContentPolicy;
import org.apache.fineract.infrastructure.contentstore.policy.DefaultPostUploadContentPolicy;
import org.apache.fineract.infrastructure.contentstore.policy.DefaultPreUploadContentPolicy;
import org.apache.fineract.infrastructure.contentstore.util.ContentPathSanitizer;
import org.apache.fineract.infrastructure.core.config.FineractProperties;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.stereotype.Service;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.core.sync.ResponseTransformer;
import software.amazon.awssdk.http.ContentStreamProvider;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.GetObjectRequest;

@Service
@ConditionalOnProperty(name = "fineract.content.s3.enabled", havingValue = "true")
public class S3ContentStoreService implements ContentStoreService {
    @java.lang.SuppressWarnings("all")
        private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(S3ContentStoreService.class);
    private final S3Client s3Client;
    private final ContentPathSanitizer pathSanitizer;
    private final DefaultDownloadContentPolicy downloadContentPolicy;
    private final DefaultPreUploadContentPolicy preUploadContentPolicy;
    private final DefaultPostUploadContentPolicy postUploadContentPolicy;
    private final DefaultDeleteContentPolicy deleteContentPolicy;
    private final ContentDetectorManager contentDetectorManager;
    private final FineractProperties properties;

    @Override
    public InputStream download(String path) {
        downloadContentPolicy.check(ContentPolicyContext.builder().path(path).build());
        final var safePath = pathSanitizer.sanitize(path);
        try {
            return s3Client.getObject(GetObjectRequest.builder().bucket(properties.getContent().getS3().getBucketName()).key(safePath).build(), ResponseTransformer.toBytes()).asInputStream();
        } catch (Exception e) {
            throw new ContentStoreException(e);
        }
    }

    @Override
    public String upload(String path, InputStream is, String mimeType) {
        requireNonNull(path, "Path missing");
        requireNonNull(is, "Data missing");
        preUploadContentPolicy.check(ContentPolicyContext.builder().path(path).mimeType(mimeType).build());
        var safePath = pathSanitizer.sanitize(path);
        try {
            final var p = safePath;
            s3Client.putObject(builder -> builder.bucket(properties.getContent().getS3().getBucketName()).key(p), RequestBody.fromContentProvider(ContentStreamProvider.fromInputStream(is), mimeType));
        } catch (Exception e) {
            throw new ContentStoreException(e);
        }
        try {
            // TODO: verify if this is working; maybe there is a better way (e.g. temporary storage on file system)
            postUploadContentPolicy.check(ContentPolicyContext.builder().path(path).inputStream(download(safePath)).mimeType(mimeType).build());
        } catch (ContentPolicyException e) {
            log.warn("Delete file because it didn\'t comply with the post-upload policy check: {} - {}", safePath, e.getMessage());
            delete(safePath);
            throw e;
        }
        return safePath;
    }

    @Override
    public void delete(String path) {
        deleteContentPolicy.check(ContentPolicyContext.builder().path(path).build());
        final var safePath = pathSanitizer.sanitize(path);
        try {
            s3Client.deleteObject(builder -> builder.bucket(properties.getContent().getS3().getBucketName()).key(safePath));
        } catch (Exception e) {
            throw new ContentStoreException(e);
        }
    }

    @Override
    public ContentStoreType getType() {
        return ContentStoreType.S3;
    }

    @java.lang.SuppressWarnings("all")
        public S3ContentStoreService(final S3Client s3Client, final ContentPathSanitizer pathSanitizer, final DefaultDownloadContentPolicy downloadContentPolicy, final DefaultPreUploadContentPolicy preUploadContentPolicy, final DefaultPostUploadContentPolicy postUploadContentPolicy, final DefaultDeleteContentPolicy deleteContentPolicy, final ContentDetectorManager contentDetectorManager, final FineractProperties properties) {
        this.s3Client = s3Client;
        this.pathSanitizer = pathSanitizer;
        this.downloadContentPolicy = downloadContentPolicy;
        this.preUploadContentPolicy = preUploadContentPolicy;
        this.postUploadContentPolicy = postUploadContentPolicy;
        this.deleteContentPolicy = deleteContentPolicy;
        this.contentDetectorManager = contentDetectorManager;
        this.properties = properties;
    }
}
