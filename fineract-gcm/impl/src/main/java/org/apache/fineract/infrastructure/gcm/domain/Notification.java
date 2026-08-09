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
package org.apache.fineract.infrastructure.gcm.domain;

import java.io.Serializable;
import java.util.Collections;
import java.util.List;

/**
 * GCM message notification part.
 *
 * <p>
 * Instances of this class are immutable and should be created using a {@link Builder}. Examples:
 *
 * <strong>Simplest notification:</strong>
 *
 * <pre>
 * <code>
 * Notification notification = new Notification.Builder("myicon").build();
 * </pre>
 *
 * </code>
 *
 * <strong>Notification with optional attributes:</strong>
 *
 * <pre>
 * <code>
 * Notification notification = new Notification.Builder("myicon")
 *    .title("Hello world!")
 *    .body("Here is a more detailed description")
 *    .build();
 * </pre>
 *
 * </code>
 */
public final class Notification implements Serializable {
    private static final long serialVersionUID = 1L;
    private String title;
    private String body;
    private String icon;
    private String sound;
    private Integer badge;
    private String tag;
    private String color;
    private String clickAction;
    private String bodyLocKey;
    private List<String> bodyLocArgs;
    private String titleLocKey;
    private List<String> titleLocArgs;


    public static final class Builder {
        // required parameters
        private final String icon;
        // optional parameters
        private String title;
        private String body;
        private String sound;
        private Integer badge;
        private String tag;
        private String color;
        private String clickAction;
        private String bodyLocKey;
        private List<String> bodyLocArgs;
        private String titleLocKey;
        private List<String> titleLocArgs;

        public Builder(String icon) {
            this.icon = icon;
            this.sound = "default"; // the only currently supported value
        }

        /**
         * Sets the title property.
         */
        public Builder title(String value) {
            title = value;
            return this;
        }

        /**
         * Sets the body property.
         */
        public Builder body(String value) {
            body = value;
            return this;
        }

        /**
         * Sets the sound property (default value is {@literal default}).
         */
        public Builder sound(String value) {
            sound = value;
            return this;
        }

        /**
         * Sets the badge property.
         */
        public Builder badge(int value) {
            badge = value;
            return this;
        }

        /**
         * Sets the tag property.
         */
        public Builder tag(String value) {
            tag = value;
            return this;
        }

        /**
         * Sets the color property in {@literal #rrggbb} format.
         */
        public Builder color(String value) {
            color = value;
            return this;
        }

        /**
         * Sets the click action property.
         */
        public Builder clickAction(String value) {
            clickAction = value;
            return this;
        }

        /**
         * Sets the body localization key property.
         */
        public Builder bodyLocKey(String value) {
            bodyLocKey = value;
            return this;
        }

        /**
         * Sets the body localization values property.
         */
        public Builder bodyLocArgs(List<String> value) {
            bodyLocArgs = Collections.unmodifiableList(value);
            return this;
        }

        /**
         * Sets the title localization key property.
         */
        public Builder titleLocKey(String value) {
            titleLocKey = value;
            return this;
        }

        /**
         * Sets the title localization values property.
         */
        public Builder titleLocArgs(List<String> value) {
            titleLocArgs = Collections.unmodifiableList(value);
            return this;
        }

        public Notification build() {
            return new Notification(this);
        }
    }

    private Notification(Builder builder) {
        title = builder.title;
        body = builder.body;
        icon = builder.icon;
        sound = builder.sound;
        badge = builder.badge;
        tag = builder.tag;
        color = builder.color;
        clickAction = builder.clickAction;
        bodyLocKey = builder.bodyLocKey;
        bodyLocArgs = builder.bodyLocArgs;
        titleLocKey = builder.titleLocKey;
        titleLocArgs = builder.titleLocArgs;
    }

    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder("Notification(");
        if (title != null) {
            builder.append("title=").append(title).append(", ");
        }
        if (body != null) {
            builder.append("body=").append(body).append(", ");
        }
        if (icon != null) {
            builder.append("icon=").append(icon).append(", ");
        }
        if (sound != null) {
            builder.append("sound=").append(sound).append(", ");
        }
        if (badge != null) {
            builder.append("badge=").append(badge).append(", ");
        }
        if (tag != null) {
            builder.append("tag=").append(tag).append(", ");
        }
        if (color != null) {
            builder.append("color=").append(color).append(", ");
        }
        if (clickAction != null) {
            builder.append("clickAction=").append(clickAction).append(", ");
        }
        if (bodyLocKey != null) {
            builder.append("bodyLocKey=").append(bodyLocKey).append(", ");
        }
        if (bodyLocArgs != null) {
            builder.append("bodyLocArgs=").append(bodyLocArgs).append(", ");
        }
        if (titleLocKey != null) {
            builder.append("titleLocKey=").append(titleLocKey).append(", ");
        }
        if (titleLocArgs != null) {
            builder.append("titleLocArgs=").append(titleLocArgs).append(", ");
        }
        if (builder.charAt(builder.length() - 1) == ' ') {
            builder.delete(builder.length() - 2, builder.length());
        }
        builder.append(")");
        return builder.toString();
    }

    @java.lang.SuppressWarnings("all")
        public String getTitle() {
        return this.title;
    }

    @java.lang.SuppressWarnings("all")
        public String getBody() {
        return this.body;
    }

    @java.lang.SuppressWarnings("all")
        public String getIcon() {
        return this.icon;
    }

    @java.lang.SuppressWarnings("all")
        public String getSound() {
        return this.sound;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getBadge() {
        return this.badge;
    }

    @java.lang.SuppressWarnings("all")
        public String getTag() {
        return this.tag;
    }

    @java.lang.SuppressWarnings("all")
        public String getColor() {
        return this.color;
    }

    @java.lang.SuppressWarnings("all")
        public String getClickAction() {
        return this.clickAction;
    }

    @java.lang.SuppressWarnings("all")
        public String getBodyLocKey() {
        return this.bodyLocKey;
    }

    @java.lang.SuppressWarnings("all")
        public List<String> getBodyLocArgs() {
        return this.bodyLocArgs;
    }

    @java.lang.SuppressWarnings("all")
        public String getTitleLocKey() {
        return this.titleLocKey;
    }

    @java.lang.SuppressWarnings("all")
        public List<String> getTitleLocArgs() {
        return this.titleLocArgs;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Notification setTitle(final String title) {
        this.title = title;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Notification setBody(final String body) {
        this.body = body;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Notification setIcon(final String icon) {
        this.icon = icon;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Notification setSound(final String sound) {
        this.sound = sound;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Notification setBadge(final Integer badge) {
        this.badge = badge;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Notification setTag(final String tag) {
        this.tag = tag;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Notification setColor(final String color) {
        this.color = color;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Notification setClickAction(final String clickAction) {
        this.clickAction = clickAction;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Notification setBodyLocKey(final String bodyLocKey) {
        this.bodyLocKey = bodyLocKey;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Notification setBodyLocArgs(final List<String> bodyLocArgs) {
        this.bodyLocArgs = bodyLocArgs;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Notification setTitleLocKey(final String titleLocKey) {
        this.titleLocKey = titleLocKey;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Notification setTitleLocArgs(final List<String> titleLocArgs) {
        this.titleLocArgs = titleLocArgs;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof Notification)) return false;
        final Notification other = (Notification) o;
        final java.lang.Object this$badge = this.getBadge();
        final java.lang.Object other$badge = other.getBadge();
        if (this$badge == null ? other$badge != null : !this$badge.equals(other$badge)) return false;
        final java.lang.Object this$title = this.getTitle();
        final java.lang.Object other$title = other.getTitle();
        if (this$title == null ? other$title != null : !this$title.equals(other$title)) return false;
        final java.lang.Object this$body = this.getBody();
        final java.lang.Object other$body = other.getBody();
        if (this$body == null ? other$body != null : !this$body.equals(other$body)) return false;
        final java.lang.Object this$icon = this.getIcon();
        final java.lang.Object other$icon = other.getIcon();
        if (this$icon == null ? other$icon != null : !this$icon.equals(other$icon)) return false;
        final java.lang.Object this$sound = this.getSound();
        final java.lang.Object other$sound = other.getSound();
        if (this$sound == null ? other$sound != null : !this$sound.equals(other$sound)) return false;
        final java.lang.Object this$tag = this.getTag();
        final java.lang.Object other$tag = other.getTag();
        if (this$tag == null ? other$tag != null : !this$tag.equals(other$tag)) return false;
        final java.lang.Object this$color = this.getColor();
        final java.lang.Object other$color = other.getColor();
        if (this$color == null ? other$color != null : !this$color.equals(other$color)) return false;
        final java.lang.Object this$clickAction = this.getClickAction();
        final java.lang.Object other$clickAction = other.getClickAction();
        if (this$clickAction == null ? other$clickAction != null : !this$clickAction.equals(other$clickAction)) return false;
        final java.lang.Object this$bodyLocKey = this.getBodyLocKey();
        final java.lang.Object other$bodyLocKey = other.getBodyLocKey();
        if (this$bodyLocKey == null ? other$bodyLocKey != null : !this$bodyLocKey.equals(other$bodyLocKey)) return false;
        final java.lang.Object this$bodyLocArgs = this.getBodyLocArgs();
        final java.lang.Object other$bodyLocArgs = other.getBodyLocArgs();
        if (this$bodyLocArgs == null ? other$bodyLocArgs != null : !this$bodyLocArgs.equals(other$bodyLocArgs)) return false;
        final java.lang.Object this$titleLocKey = this.getTitleLocKey();
        final java.lang.Object other$titleLocKey = other.getTitleLocKey();
        if (this$titleLocKey == null ? other$titleLocKey != null : !this$titleLocKey.equals(other$titleLocKey)) return false;
        final java.lang.Object this$titleLocArgs = this.getTitleLocArgs();
        final java.lang.Object other$titleLocArgs = other.getTitleLocArgs();
        if (this$titleLocArgs == null ? other$titleLocArgs != null : !this$titleLocArgs.equals(other$titleLocArgs)) return false;
        return true;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $badge = this.getBadge();
        result = result * PRIME + ($badge == null ? 43 : $badge.hashCode());
        final java.lang.Object $title = this.getTitle();
        result = result * PRIME + ($title == null ? 43 : $title.hashCode());
        final java.lang.Object $body = this.getBody();
        result = result * PRIME + ($body == null ? 43 : $body.hashCode());
        final java.lang.Object $icon = this.getIcon();
        result = result * PRIME + ($icon == null ? 43 : $icon.hashCode());
        final java.lang.Object $sound = this.getSound();
        result = result * PRIME + ($sound == null ? 43 : $sound.hashCode());
        final java.lang.Object $tag = this.getTag();
        result = result * PRIME + ($tag == null ? 43 : $tag.hashCode());
        final java.lang.Object $color = this.getColor();
        result = result * PRIME + ($color == null ? 43 : $color.hashCode());
        final java.lang.Object $clickAction = this.getClickAction();
        result = result * PRIME + ($clickAction == null ? 43 : $clickAction.hashCode());
        final java.lang.Object $bodyLocKey = this.getBodyLocKey();
        result = result * PRIME + ($bodyLocKey == null ? 43 : $bodyLocKey.hashCode());
        final java.lang.Object $bodyLocArgs = this.getBodyLocArgs();
        result = result * PRIME + ($bodyLocArgs == null ? 43 : $bodyLocArgs.hashCode());
        final java.lang.Object $titleLocKey = this.getTitleLocKey();
        result = result * PRIME + ($titleLocKey == null ? 43 : $titleLocKey.hashCode());
        final java.lang.Object $titleLocArgs = this.getTitleLocArgs();
        result = result * PRIME + ($titleLocArgs == null ? 43 : $titleLocArgs.hashCode());
        return result;
    }

    @java.lang.SuppressWarnings("all")
        public Notification() {
    }
}
