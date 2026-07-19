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
package org.apache.fineract.organisation.staff.data;

import io.swagger.v3.oas.annotations.media.Schema;
import java.io.File;
import java.io.InputStream;
import java.io.Serial;
import java.io.Serializable;
import org.glassfish.jersey.media.multipart.FormDataContentDisposition;
import org.glassfish.jersey.media.multipart.FormDataParam;

public class StaffUploadRequest implements Serializable {
    // TODO: prefixing attributes with "upload" when we are already in a class named "XXXUploadXXX" is inconvenient; I'd
    // just name it "data"; we don't have to replicate the data types in the attribute names
    @Serial
    private static final long serialVersionUID = 1L;
    @Schema(type = "string", format = "binary")
    @FormDataParam("file")
    private InputStream uploadedInputStream;
    @Schema(implementation = File.class, hidden = true)
    @FormDataParam("file")
    private File file;
    @Schema(implementation = FormDataContentDisposition.class, hidden = true)
    @FormDataParam("file")
    private FormDataContentDisposition fileDetail;
    @Schema(name = "locale")
    @FormDataParam("locale")
    private String locale;
    @Schema(name = "dateFormat")
    @FormDataParam("dateFormat")
    private String dateFormat;


    @java.lang.SuppressWarnings("all")
        public static class StaffUploadRequestBuilder {
        @java.lang.SuppressWarnings("all")
                private InputStream uploadedInputStream;
        @java.lang.SuppressWarnings("all")
                private File file;
        @java.lang.SuppressWarnings("all")
                private FormDataContentDisposition fileDetail;
        @java.lang.SuppressWarnings("all")
                private String locale;
        @java.lang.SuppressWarnings("all")
                private String dateFormat;

        @java.lang.SuppressWarnings("all")
                StaffUploadRequestBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public StaffUploadRequest.StaffUploadRequestBuilder uploadedInputStream(final InputStream uploadedInputStream) {
            this.uploadedInputStream = uploadedInputStream;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public StaffUploadRequest.StaffUploadRequestBuilder file(final File file) {
            this.file = file;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public StaffUploadRequest.StaffUploadRequestBuilder fileDetail(final FormDataContentDisposition fileDetail) {
            this.fileDetail = fileDetail;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public StaffUploadRequest.StaffUploadRequestBuilder locale(final String locale) {
            this.locale = locale;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public StaffUploadRequest.StaffUploadRequestBuilder dateFormat(final String dateFormat) {
            this.dateFormat = dateFormat;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public StaffUploadRequest build() {
            return new StaffUploadRequest(this.uploadedInputStream, this.file, this.fileDetail, this.locale, this.dateFormat);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "StaffUploadRequest.StaffUploadRequestBuilder(uploadedInputStream=" + this.uploadedInputStream + ", file=" + this.file + ", fileDetail=" + this.fileDetail + ", locale=" + this.locale + ", dateFormat=" + this.dateFormat + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static StaffUploadRequest.StaffUploadRequestBuilder builder() {
        return new StaffUploadRequest.StaffUploadRequestBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public InputStream getUploadedInputStream() {
        return this.uploadedInputStream;
    }

    @java.lang.SuppressWarnings("all")
        public File getFile() {
        return this.file;
    }

    @java.lang.SuppressWarnings("all")
        public FormDataContentDisposition getFileDetail() {
        return this.fileDetail;
    }

    @java.lang.SuppressWarnings("all")
        public String getLocale() {
        return this.locale;
    }

    @java.lang.SuppressWarnings("all")
        public String getDateFormat() {
        return this.dateFormat;
    }

    @java.lang.SuppressWarnings("all")
        public void setUploadedInputStream(final InputStream uploadedInputStream) {
        this.uploadedInputStream = uploadedInputStream;
    }

    @java.lang.SuppressWarnings("all")
        public void setFile(final File file) {
        this.file = file;
    }

    @java.lang.SuppressWarnings("all")
        public void setFileDetail(final FormDataContentDisposition fileDetail) {
        this.fileDetail = fileDetail;
    }

    @java.lang.SuppressWarnings("all")
        public void setLocale(final String locale) {
        this.locale = locale;
    }

    @java.lang.SuppressWarnings("all")
        public void setDateFormat(final String dateFormat) {
        this.dateFormat = dateFormat;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof StaffUploadRequest)) return false;
        final StaffUploadRequest other = (StaffUploadRequest) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$uploadedInputStream = this.getUploadedInputStream();
        final java.lang.Object other$uploadedInputStream = other.getUploadedInputStream();
        if (this$uploadedInputStream == null ? other$uploadedInputStream != null : !this$uploadedInputStream.equals(other$uploadedInputStream)) return false;
        final java.lang.Object this$file = this.getFile();
        final java.lang.Object other$file = other.getFile();
        if (this$file == null ? other$file != null : !this$file.equals(other$file)) return false;
        final java.lang.Object this$fileDetail = this.getFileDetail();
        final java.lang.Object other$fileDetail = other.getFileDetail();
        if (this$fileDetail == null ? other$fileDetail != null : !this$fileDetail.equals(other$fileDetail)) return false;
        final java.lang.Object this$locale = this.getLocale();
        final java.lang.Object other$locale = other.getLocale();
        if (this$locale == null ? other$locale != null : !this$locale.equals(other$locale)) return false;
        final java.lang.Object this$dateFormat = this.getDateFormat();
        final java.lang.Object other$dateFormat = other.getDateFormat();
        if (this$dateFormat == null ? other$dateFormat != null : !this$dateFormat.equals(other$dateFormat)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof StaffUploadRequest;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $uploadedInputStream = this.getUploadedInputStream();
        result = result * PRIME + ($uploadedInputStream == null ? 43 : $uploadedInputStream.hashCode());
        final java.lang.Object $file = this.getFile();
        result = result * PRIME + ($file == null ? 43 : $file.hashCode());
        final java.lang.Object $fileDetail = this.getFileDetail();
        result = result * PRIME + ($fileDetail == null ? 43 : $fileDetail.hashCode());
        final java.lang.Object $locale = this.getLocale();
        result = result * PRIME + ($locale == null ? 43 : $locale.hashCode());
        final java.lang.Object $dateFormat = this.getDateFormat();
        result = result * PRIME + ($dateFormat == null ? 43 : $dateFormat.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "StaffUploadRequest(uploadedInputStream=" + this.getUploadedInputStream() + ", file=" + this.getFile() + ", fileDetail=" + this.getFileDetail() + ", locale=" + this.getLocale() + ", dateFormat=" + this.getDateFormat() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public StaffUploadRequest() {
    }

    @java.lang.SuppressWarnings("all")
        public StaffUploadRequest(final InputStream uploadedInputStream, final File file, final FormDataContentDisposition fileDetail, final String locale, final String dateFormat) {
        this.uploadedInputStream = uploadedInputStream;
        this.file = file;
        this.fileDetail = fileDetail;
        this.locale = locale;
        this.dateFormat = dateFormat;
    }
}
