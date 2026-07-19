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
package org.apache.fineract.command.core;

import com.google.common.reflect.TypeToken;

public interface CommandHandler<REQ, RES> {
    RES handle(Command<REQ> command);

    default RES fallback(Command<REQ> command, Throwable t) {
        // NOTE: any command handler can override this default to implement more specialized fallbacks.
        // Re-throw platform/runtime exceptions as-is so Jersey mappers still produce 404/400/etc.
        // (Delombok of @SneakyThrows used to wrap every Throwable in RuntimeException → HTTP 500.)
        if (t instanceof RuntimeException runtimeException) {
            throw runtimeException;
        }
        if (t instanceof Error error) {
            throw error;
        }
        throw new RuntimeException(t);
    }

    default boolean matches(Command<REQ> command) {
        TypeToken<REQ> handlerType = new TypeToken<>(getClass()) {
        };
        return handlerType.getRawType().isAssignableFrom(command.getPayload().getClass());
    }
}
