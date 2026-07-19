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
package org.apache.fineract.infrastructure.security.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;
import java.time.LocalDateTime;
import org.apache.fineract.infrastructure.core.domain.AbstractPersistableCustom;
import org.apache.fineract.infrastructure.core.service.DateUtils;
import org.apache.fineract.infrastructure.security.data.AccessTokenData;
import org.apache.fineract.useradministration.domain.AppUser;

@Entity
@Table(name = "twofactor_access_token", uniqueConstraints = {@UniqueConstraint(columnNames = {"token", "appuser_id"}, name = "token_appuser_UNIQUE")})
public class TFAccessToken extends AbstractPersistableCustom<Long> {
    @Column(name = "token", nullable = false, length = 32)
    private String token;
    @ManyToOne
    @JoinColumn(name = "appuser_id", nullable = false)
    private AppUser user;
    @Column(name = "valid_from", nullable = false)
    private LocalDateTime validFrom;
    @Column(name = "valid_to", nullable = false)
    private LocalDateTime validTo;
    @Column(name = "enabled", nullable = false)
    private boolean enabled;

    public static TFAccessToken create(String token, AppUser user, int tokenLiveTimeInSec) {
        LocalDateTime validFrom = DateUtils.getLocalDateTimeOfTenant();
        LocalDateTime validTo = validFrom.plusSeconds(tokenLiveTimeInSec);
        return new TFAccessToken().setToken(token).setUser(user).setValidFrom(validFrom).setValidTo(validTo).setEnabled(true);
    }

    public boolean isValid() {
        // valid_from is in the past inclusive, valid_to is in the future exclusive
        return this.enabled && !DateUtils.isAfterTenantDateTime(getValidFrom()) && DateUtils.isAfterTenantDateTime(getValidTo());
    }

    public AccessTokenData toTokenData() {
        return new AccessTokenData().setToken(this.token).setValidFrom(getValidFrom().atZone(DateUtils.getDateTimeZoneOfTenant())).setValidTo(getValidTo().atZone(DateUtils.getDateTimeZoneOfTenant()));
    }

    @java.lang.SuppressWarnings("all")
        public String getToken() {
        return this.token;
    }

    @java.lang.SuppressWarnings("all")
        public AppUser getUser() {
        return this.user;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDateTime getValidFrom() {
        return this.validFrom;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDateTime getValidTo() {
        return this.validTo;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isEnabled() {
        return this.enabled;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public TFAccessToken setToken(final String token) {
        this.token = token;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public TFAccessToken setUser(final AppUser user) {
        this.user = user;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public TFAccessToken setValidFrom(final LocalDateTime validFrom) {
        this.validFrom = validFrom;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public TFAccessToken setValidTo(final LocalDateTime validTo) {
        this.validTo = validTo;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public TFAccessToken setEnabled(final boolean enabled) {
        this.enabled = enabled;
        return this;
    }

    @java.lang.SuppressWarnings("all")
        public TFAccessToken() {
    }
}
