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
package org.apache.fineract.organisation.provisioning.data;

import java.io.Serializable;

/**
 * Immutable object representing organization's provision category data
 */
public class ProvisioningCategoryData implements Comparable<ProvisioningCategoryData>, Serializable {
    private static final long serialVersionUID = 1L;
    private Long id;
    private String categoryName;
    private String categoryDescription;

    @Override
    public boolean equals(final Object obj) {
        if (!(obj instanceof ProvisioningCategoryData)) {
            return false;
        }
        final ProvisioningCategoryData provisionCategoryData = (ProvisioningCategoryData) obj;
        return provisionCategoryData.id.equals(this.id);
    }

    @Override
    public int hashCode() {
        return this.id.hashCode();
    }

    @Override
    public int compareTo(ProvisioningCategoryData obj) {
        if (obj == null) {
            return -1;
        }
        return obj.id.compareTo(this.id);
    }

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public String getCategoryName() {
        return this.categoryName;
    }

    @java.lang.SuppressWarnings("all")
        public String getCategoryDescription() {
        return this.categoryDescription;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ProvisioningCategoryData setId(final Long id) {
        this.id = id;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ProvisioningCategoryData setCategoryName(final String categoryName) {
        this.categoryName = categoryName;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ProvisioningCategoryData setCategoryDescription(final String categoryDescription) {
        this.categoryDescription = categoryDescription;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "ProvisioningCategoryData(id=" + this.getId() + ", categoryName=" + this.getCategoryName() + ", categoryDescription=" + this.getCategoryDescription() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public ProvisioningCategoryData() {
    }
}
