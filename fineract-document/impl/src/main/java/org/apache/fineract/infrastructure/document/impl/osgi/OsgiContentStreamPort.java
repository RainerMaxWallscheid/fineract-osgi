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
import java.io.OutputStream;
import java.io.PipedInputStream;
import java.io.PipedOutputStream;
import org.apache.fineract.infrastructure.contentstore.exception.ContentProcessorException;
import org.apache.fineract.infrastructure.contentstore.moduleapi.ContentStreamPort;

/**
 * JDK pipe for Equinox without Spring. Same contract as {@code ContentPipe},
 * using a daemon thread instead of the Boot executor.
 * Published by {@code OSGI-INF/document-stream.xml} (ADR-022 B6).
 */
public final class OsgiContentStreamPort implements ContentStreamPort {

    private static final int BUFFER_SIZE = 8192;

    @Override
    public InputStream pipe(final OutputStreamWriter writer) {
        final PipedInputStream in = new PipedInputStream(BUFFER_SIZE);
        final PipedOutputStream out = open(in);
        startDaemon(() -> {
            try (out) {
                writer.writeTo(out);
            } catch (final Exception ex) {
                throw new ContentProcessorException(ex);
            }
        });
        return in;
    }

    @Override
    public InputStream pipe(final InputStream input, final InputOutputStreamTransformer transformer) {
        final PipedInputStream in = new PipedInputStream(BUFFER_SIZE);
        final PipedOutputStream out = open(in);
        startDaemon(() -> {
            try (out; input) {
                transformer.transform(input, out);
            } catch (final Exception ex) {
                throw new ContentProcessorException(ex);
            }
        });
        return in;
    }

    @Override
    public void write(final InputStream input, final OutputStream output, final byte[] buffer) throws IOException {
        int bytesRead;
        while ((bytesRead = input.read(buffer)) != -1) {
            output.write(buffer, 0, bytesRead);
        }
    }

    private static PipedOutputStream open(final PipedInputStream in) {
        try {
            return new PipedOutputStream(in);
        } catch (final IOException ex) {
            throw new ContentProcessorException(ex);
        }
    }

    private static void startDaemon(final Runnable work) {
        final Thread thread = new Thread(work, "osgi-content-pipe");
        thread.setDaemon(true);
        thread.start();
    }
}
