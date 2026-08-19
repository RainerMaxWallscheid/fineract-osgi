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
package org.apache.fineract.portfolio.search.impl.osgi;

import java.util.List;
import org.apache.fineract.portfolio.search.data.AdHocQuerySearchRequest;
import org.apache.fineract.portfolio.search.data.AdHocSearchQueryData;
import org.apache.fineract.portfolio.search.data.SearchConditions;
import org.apache.fineract.portfolio.search.data.SearchData;
import org.apache.fineract.portfolio.search.service.SearchReadService;

/**
 * Empty search catalog for Equinox without Spring/JPA.
 * Published by {@code OSGI-INF/search.xml} (ADR-022 B6).
 */
public final class OsgiSearchReadService implements SearchReadService {

    @Override
    public List<SearchData> retriveMatchingData(final SearchConditions searchConditions) {
        return List.of();
    }

    @Override
    public AdHocSearchQueryData retrieveAdHocQueryTemplate() {
        return null;
    }

    @Override
    public List<AdHocSearchQueryData> retrieveAdHocQueryMatchingData(final AdHocQuerySearchRequest request) {
        return List.of();
    }
}
