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
package org.apache.fineract.infrastructure.campaigns.email.data;

import java.io.File;
import java.util.List;

public final class EmailMessageWithAttachmentData {
    private String to;
    private String text;
    private String subject;
    private List<File> attachments;

    public static EmailMessageWithAttachmentData createNew(final String to, final String text, final String subject, final List<File> attachments) {
        return new EmailMessageWithAttachmentData().setTo(to).setText(text).setSubject(subject).setAttachments(attachments);
    }

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
        public List<File> getAttachments() {
        return this.attachments;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public EmailMessageWithAttachmentData setTo(final String to) {
        this.to = to;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public EmailMessageWithAttachmentData setText(final String text) {
        this.text = text;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public EmailMessageWithAttachmentData setSubject(final String subject) {
        this.subject = subject;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public EmailMessageWithAttachmentData setAttachments(final List<File> attachments) {
        this.attachments = attachments;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof EmailMessageWithAttachmentData)) return false;
        final EmailMessageWithAttachmentData other = (EmailMessageWithAttachmentData) o;
        final java.lang.Object this$to = this.getTo();
        final java.lang.Object other$to = other.getTo();
        if (this$to == null ? other$to != null : !this$to.equals(other$to)) return false;
        final java.lang.Object this$text = this.getText();
        final java.lang.Object other$text = other.getText();
        if (this$text == null ? other$text != null : !this$text.equals(other$text)) return false;
        final java.lang.Object this$subject = this.getSubject();
        final java.lang.Object other$subject = other.getSubject();
        if (this$subject == null ? other$subject != null : !this$subject.equals(other$subject)) return false;
        final java.lang.Object this$attachments = this.getAttachments();
        final java.lang.Object other$attachments = other.getAttachments();
        if (this$attachments == null ? other$attachments != null : !this$attachments.equals(other$attachments)) return false;
        return true;
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
        final java.lang.Object $attachments = this.getAttachments();
        result = result * PRIME + ($attachments == null ? 43 : $attachments.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "EmailMessageWithAttachmentData(to=" + this.getTo() + ", text=" + this.getText() + ", subject=" + this.getSubject() + ", attachments=" + this.getAttachments() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public EmailMessageWithAttachmentData() {
    }
}
