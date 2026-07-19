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
package org.apache.fineract.infrastructure.reportmailingjob.data;

import java.io.File;

/**
 * Immutable data object representing report mailing job email data.
 */
public class ReportMailingJobEmailData {
    private String to;
    private String text;
    private String subject;
    private File attachment;

    @java.lang.SuppressWarnings("all")
        public String getTo() {
        return this.to;
    }

    @java.lang.SuppressWarnings("all")
        public String getText() {
        return this.text;
    }

    @java.lang.SuppressWarnings("all")
        public String getSubject() {
        return this.subject;
    }

    @java.lang.SuppressWarnings("all")
        public File getAttachment() {
        return this.attachment;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ReportMailingJobEmailData setTo(final String to) {
        this.to = to;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ReportMailingJobEmailData setText(final String text) {
        this.text = text;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ReportMailingJobEmailData setSubject(final String subject) {
        this.subject = subject;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ReportMailingJobEmailData setAttachment(final File attachment) {
        this.attachment = attachment;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof ReportMailingJobEmailData)) return false;
        final ReportMailingJobEmailData other = (ReportMailingJobEmailData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$to = this.getTo();
        final java.lang.Object other$to = other.getTo();
        if (this$to == null ? other$to != null : !this$to.equals(other$to)) return false;
        final java.lang.Object this$text = this.getText();
        final java.lang.Object other$text = other.getText();
        if (this$text == null ? other$text != null : !this$text.equals(other$text)) return false;
        final java.lang.Object this$subject = this.getSubject();
        final java.lang.Object other$subject = other.getSubject();
        if (this$subject == null ? other$subject != null : !this$subject.equals(other$subject)) return false;
        final java.lang.Object this$attachment = this.getAttachment();
        final java.lang.Object other$attachment = other.getAttachment();
        if (this$attachment == null ? other$attachment != null : !this$attachment.equals(other$attachment)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof ReportMailingJobEmailData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $to = this.getTo();
        result = result * PRIME + ($to == null ? 43 : $to.hashCode());
        final java.lang.Object $text = this.getText();
        result = result * PRIME + ($text == null ? 43 : $text.hashCode());
        final java.lang.Object $subject = this.getSubject();
        result = result * PRIME + ($subject == null ? 43 : $subject.hashCode());
        final java.lang.Object $attachment = this.getAttachment();
        result = result * PRIME + ($attachment == null ? 43 : $attachment.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "ReportMailingJobEmailData(to=" + this.getTo() + ", text=" + this.getText() + ", subject=" + this.getSubject() + ", attachment=" + this.getAttachment() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public ReportMailingJobEmailData() {
    }
}
