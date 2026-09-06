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
import java.io.OutputStream;
import java.nio.charset.StandardCharsets;
import org.apache.fineract.infrastructure.contentstore.moduleapi.ContentStreamPort;

/**
 * Composition-root hosted content stream for the Equinox bridge smoke.
 * In-memory marker bytes — not a JDK pipe.
 */
final class HostedContentStreamPort implements ContentStreamPort {

    static final byte[] HOSTED_BYTES = "hosted".getBytes(StandardCharsets.UTF_8);

    @Override
    public InputStream pipe(final OutputStreamWriter writer) {
        return new ByteArrayInputStream(HOSTED_BYTES);
    }

    @Override
    public InputStream pipe(final InputStream input, final InputOutputStreamTransformer transformer) {
        return new ByteArrayInputStream(HOSTED_BYTES);
    }

    @Override
    public void write(final InputStream input, final OutputStream output, final byte[] buffer) throws IOException {
        output.write(HOSTED_BYTES);
    }
}
