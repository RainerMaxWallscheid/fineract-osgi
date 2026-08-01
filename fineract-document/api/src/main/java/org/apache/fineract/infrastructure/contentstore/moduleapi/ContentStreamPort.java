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
package org.apache.fineract.infrastructure.contentstore.moduleapi;

import java.io.InputStream;
import java.io.OutputStream;

/**
 * Module API port for async stream piping (e.g. write a workbook to an {@link InputStream}
 * without buffering the entire payload in memory).
 *
 * <p>Implementation lives in document-impl ({@code ContentPipe}). Foreign BCs should depend on this
 * port instead of impl utility types.
 *
 * @see docs/arc42/15_osgi_bundle_refactoring_fineract-document.md
 */
public interface ContentStreamPort {

    /**
     * Runs {@code writer} on a worker thread writing to a pipe; returns the readable end.
     */
    InputStream pipe(OutputStreamWriter writer);

    /**
     * Runs {@code transformer} on a worker thread reading {@code input} and writing to a pipe.
     */
    InputStream pipe(InputStream input, InputOutputStreamTransformer transformer);

    /**
     * Copy {@code input} to {@code output} using {@code buffer}.
     */
    void write(InputStream input, OutputStream output, byte[] buffer) throws java.io.IOException;

    @FunctionalInterface
    interface OutputStreamWriter {

        void writeTo(OutputStream output) throws Exception;
    }

    @FunctionalInterface
    interface InputOutputStreamTransformer {

        void transform(InputStream input, OutputStream output) throws Exception;
    }
}
