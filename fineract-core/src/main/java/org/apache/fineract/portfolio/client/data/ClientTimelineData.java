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
package org.apache.fineract.portfolio.client.data;

import java.io.Serializable;
import java.time.LocalDate;

/**
 * Immutable data object represent the important time-line events of a loan application and loan.
 */
@SuppressWarnings("unused")
public class ClientTimelineData implements Serializable {
    private final LocalDate submittedOnDate;
    private final String submittedByUsername;
    private final String submittedByFirstname;
    private final String submittedByLastname;
    private final LocalDate activatedOnDate;
    private final String activatedByUsername;
    private final String activatedByFirstname;
    private final String activatedByLastname;
    private final LocalDate closedOnDate;
    private final String closedByUsername;
    private final String closedByFirstname;
    private final String closedByLastname;

    @java.lang.SuppressWarnings("all")
        public LocalDate getSubmittedOnDate() {
        return this.submittedOnDate;
    }

    @java.lang.SuppressWarnings("all")
        public String getSubmittedByUsername() {
        return this.submittedByUsername;
    }

    @java.lang.SuppressWarnings("all")
        public String getSubmittedByFirstname() {
        return this.submittedByFirstname;
    }

    @java.lang.SuppressWarnings("all")
        public String getSubmittedByLastname() {
        return this.submittedByLastname;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getActivatedOnDate() {
        return this.activatedOnDate;
    }

    @java.lang.SuppressWarnings("all")
        public String getActivatedByUsername() {
        return this.activatedByUsername;
    }

    @java.lang.SuppressWarnings("all")
        public String getActivatedByFirstname() {
        return this.activatedByFirstname;
    }

    @java.lang.SuppressWarnings("all")
        public String getActivatedByLastname() {
        return this.activatedByLastname;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getClosedOnDate() {
        return this.closedOnDate;
    }

    @java.lang.SuppressWarnings("all")
        public String getClosedByUsername() {
        return this.closedByUsername;
    }

    @java.lang.SuppressWarnings("all")
        public String getClosedByFirstname() {
        return this.closedByFirstname;
    }

    @java.lang.SuppressWarnings("all")
        public String getClosedByLastname() {
        return this.closedByLastname;
    }

    @java.lang.SuppressWarnings("all")
        public ClientTimelineData(final LocalDate submittedOnDate, final String submittedByUsername, final String submittedByFirstname, final String submittedByLastname, final LocalDate activatedOnDate, final String activatedByUsername, final String activatedByFirstname, final String activatedByLastname, final LocalDate closedOnDate, final String closedByUsername, final String closedByFirstname, final String closedByLastname) {
        this.submittedOnDate = submittedOnDate;
        this.submittedByUsername = submittedByUsername;
        this.submittedByFirstname = submittedByFirstname;
        this.submittedByLastname = submittedByLastname;
        this.activatedOnDate = activatedOnDate;
        this.activatedByUsername = activatedByUsername;
        this.activatedByFirstname = activatedByFirstname;
        this.activatedByLastname = activatedByLastname;
        this.closedOnDate = closedOnDate;
        this.closedByUsername = closedByUsername;
        this.closedByFirstname = closedByFirstname;
        this.closedByLastname = closedByLastname;
    }
}
