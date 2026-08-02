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
package org.apache.fineract.mix.domain;

import java.io.Serial;
import java.io.Serializable;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.Table;

@Table("mix_xbrl_namespace")
public class MixReportXBRLNamespace implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    @Id
    @Column("id")
    private Long id;
    @Column("prefix")
    private String prefix;
    @Column("url")
    private String url;

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public String getPrefix() {
        return this.prefix;
    }

    @java.lang.SuppressWarnings("all")
        public String getUrl() {
        return this.url;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public MixReportXBRLNamespace setId(final Long id) {
        this.id = id;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public MixReportXBRLNamespace setPrefix(final String prefix) {
        this.prefix = prefix;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public MixReportXBRLNamespace setUrl(final String url) {
        this.url = url;
        return this;
    }

    @java.lang.SuppressWarnings("all")
        public MixReportXBRLNamespace() {
    }
}
