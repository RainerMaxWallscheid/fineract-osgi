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

import static org.junit.jupiter.api.Assertions.assertArrayEquals;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.nio.charset.StandardCharsets;
import org.junit.jupiter.api.Test;

class OsgiContentStreamPortTest {

    private final OsgiContentStreamPort port = new OsgiContentStreamPort();

    @Test
    void writeCopiesBytes() throws Exception {
        final byte[] payload = "hello".getBytes(StandardCharsets.UTF_8);
        final ByteArrayOutputStream out = new ByteArrayOutputStream();
        port.write(new ByteArrayInputStream(payload), out, new byte[8]);
        assertArrayEquals(payload, out.toByteArray());
    }

    @Test
    void pipeWriterIsReadable() throws Exception {
        final byte[] payload = "hello".getBytes(StandardCharsets.UTF_8);
        try (var in = port.pipe(output -> output.write(payload))) {
            assertArrayEquals(payload, in.readAllBytes());
        }
    }
}
