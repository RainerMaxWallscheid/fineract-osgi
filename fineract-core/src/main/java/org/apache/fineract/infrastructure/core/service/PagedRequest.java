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
package org.apache.fineract.infrastructure.core.service;

import static org.apache.commons.collections4.CollectionUtils.isEmpty;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;

public class PagedRequest<T> {
    public static final int DEFAULT_PAGE_SIZE = 50;
    private T request;
    private int page;
    private int size = DEFAULT_PAGE_SIZE;
    private final List<SortOrder> sorts = new ArrayList<>();

    public Optional<T> getRequest() {
        return Optional.ofNullable(request);
    }

    public PageRequest toPageable() {
        if (isEmpty(sorts)) {
            return PageRequest.of(page, size);
        } else {
            List<Sort.Order> orders = sorts.stream().map(SortOrder::toOrder).toList();
            return PageRequest.of(page, size, Sort.by(orders));
        }
    }


    @SuppressWarnings({"unused"})
    private static final class SortOrder {
        private Sort.Direction direction;
        private String property;

        private Sort.Order toOrder() {
            return new Sort.Order(direction, property);
        }

        @java.lang.SuppressWarnings("all")
                public SortOrder() {
        }

        @java.lang.SuppressWarnings("all")
                public Sort.Direction getDirection() {
            return this.direction;
        }

        @java.lang.SuppressWarnings("all")
                public String getProperty() {
            return this.property;
        }

        @java.lang.SuppressWarnings("all")
                public void setDirection(final Sort.Direction direction) {
            this.direction = direction;
        }

        @java.lang.SuppressWarnings("all")
                public void setProperty(final String property) {
            this.property = property;
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public boolean equals(final java.lang.Object o) {
            if (o == this) return true;
            if (!(o instanceof PagedRequest.SortOrder)) return false;
            final PagedRequest.SortOrder other = (PagedRequest.SortOrder) o;
            final java.lang.Object this$direction = this.getDirection();
            final java.lang.Object other$direction = other.getDirection();
            if (this$direction == null ? other$direction != null : !this$direction.equals(other$direction)) return false;
            final java.lang.Object this$property = this.getProperty();
            final java.lang.Object other$property = other.getProperty();
            if (this$property == null ? other$property != null : !this$property.equals(other$property)) return false;
            return true;
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public int hashCode() {
            final int PRIME = 59;
            int result = 1;
            final java.lang.Object $direction = this.getDirection();
            result = result * PRIME + ($direction == null ? 43 : $direction.hashCode());
            final java.lang.Object $property = this.getProperty();
            result = result * PRIME + ($property == null ? 43 : $property.hashCode());
            return result;
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "PagedRequest.SortOrder(direction=" + this.getDirection() + ", property=" + this.getProperty() + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public PagedRequest() {
    }

    @java.lang.SuppressWarnings("all")
        public int getPage() {
        return this.page;
    }

    @java.lang.SuppressWarnings("all")
        public int getSize() {
        return this.size;
    }

    @java.lang.SuppressWarnings("all")
        public List<SortOrder> getSorts() {
        return this.sorts;
    }

    @java.lang.SuppressWarnings("all")
        public void setRequest(final T request) {
        this.request = request;
    }

    @java.lang.SuppressWarnings("all")
        public void setPage(final int page) {
        this.page = page;
    }

    @java.lang.SuppressWarnings("all")
        public void setSize(final int size) {
        this.size = size;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof PagedRequest)) return false;
        final PagedRequest<?> other = (PagedRequest<?>) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        if (this.getPage() != other.getPage()) return false;
        if (this.getSize() != other.getSize()) return false;
        final java.lang.Object this$request = this.getRequest();
        final java.lang.Object other$request = other.getRequest();
        if (this$request == null ? other$request != null : !this$request.equals(other$request)) return false;
        final java.lang.Object this$sorts = this.getSorts();
        final java.lang.Object other$sorts = other.getSorts();
        if (this$sorts == null ? other$sorts != null : !this$sorts.equals(other$sorts)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof PagedRequest;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        result = result * PRIME + this.getPage();
        result = result * PRIME + this.getSize();
        final java.lang.Object $request = this.getRequest();
        result = result * PRIME + ($request == null ? 43 : $request.hashCode());
        final java.lang.Object $sorts = this.getSorts();
        result = result * PRIME + ($sorts == null ? 43 : $sorts.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "PagedRequest(request=" + this.getRequest() + ", page=" + this.getPage() + ", size=" + this.getSize() + ", sorts=" + this.getSorts() + ")";
    }
}
