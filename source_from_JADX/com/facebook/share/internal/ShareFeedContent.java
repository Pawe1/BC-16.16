package com.facebook.share.internal;

import android.os.Parcel;
import android.os.Parcelable.Creator;
import com.facebook.share.model.ShareContent;

public class ShareFeedContent extends ShareContent<ShareFeedContent, Builder> {
    public static final Creator<ShareFeedContent> CREATOR = new C02731();
    private final String link;
    private final String linkCaption;
    private final String linkDescription;
    private final String linkName;
    private final String mediaSource;
    private final String picture;
    private final String toId;

    final class C02731 implements Creator<ShareFeedContent> {
        C02731() {
        }

        public final ShareFeedContent createFromParcel(Parcel parcel) {
            return new ShareFeedContent(parcel);
        }

        public final ShareFeedContent[] newArray(int i) {
            return new ShareFeedContent[i];
        }
    }

    public static final class Builder extends com.facebook.share.model.ShareContent.Builder<ShareFeedContent, Builder> {
        private String link;
        private String linkCaption;
        private String linkDescription;
        private String linkName;
        private String mediaSource;
        private String picture;
        private String toId;

        public final ShareFeedContent build() {
            return new ShareFeedContent();
        }

        public final Builder readFrom(Parcel parcel) {
            return readFrom((ShareFeedContent) parcel.readParcelable(ShareFeedContent.class.getClassLoader()));
        }

        public final Builder readFrom(ShareFeedContent shareFeedContent) {
            return shareFeedContent == null ? this : ((Builder) super.readFrom((ShareContent) shareFeedContent)).setToId(shareFeedContent.getToId()).setLink(shareFeedContent.getLink()).setLinkName(shareFeedContent.getLinkName()).setLinkCaption(shareFeedContent.getLinkCaption()).setLinkDescription(shareFeedContent.getLinkDescription()).setPicture(shareFeedContent.getPicture()).setMediaSource(shareFeedContent.getMediaSource());
        }

        public final Builder setLink(String str) {
            this.link = str;
            return this;
        }

        public final Builder setLinkCaption(String str) {
            this.linkCaption = str;
            return this;
        }

        public final Builder setLinkDescription(String str) {
            this.linkDescription = str;
            return this;
        }

        public final Builder setLinkName(String str) {
            this.linkName = str;
            return this;
        }

        public final Builder setMediaSource(String str) {
            this.mediaSource = str;
            return this;
        }

        public final Builder setPicture(String str) {
            this.picture = str;
            return this;
        }

        public final Builder setToId(String str) {
            this.toId = str;
            return this;
        }
    }

    ShareFeedContent(Parcel parcel) {
        super(parcel);
        this.toId = parcel.readString();
        this.link = parcel.readString();
        this.linkName = parcel.readString();
        this.linkCaption = parcel.readString();
        this.linkDescription = parcel.readString();
        this.picture = parcel.readString();
        this.mediaSource = parcel.readString();
    }

    private ShareFeedContent(Builder builder) {
        super((com.facebook.share.model.ShareContent.Builder) builder);
        this.toId = builder.toId;
        this.link = builder.link;
        this.linkName = builder.linkName;
        this.linkCaption = builder.linkCaption;
        this.linkDescription = builder.linkDescription;
        this.picture = builder.picture;
        this.mediaSource = builder.mediaSource;
    }

    public int describeContents() {
        return 0;
    }

    public String getLink() {
        return this.link;
    }

    public String getLinkCaption() {
        return this.linkCaption;
    }

    public String getLinkDescription() {
        return this.linkDescription;
    }

    public String getLinkName() {
        return this.linkName;
    }

    public String getMediaSource() {
        return this.mediaSource;
    }

    public String getPicture() {
        return this.picture;
    }

    public String getToId() {
        return this.toId;
    }

    public void writeToParcel(Parcel parcel, int i) {
        super.writeToParcel(parcel, i);
        parcel.writeString(this.toId);
        parcel.writeString(this.link);
        parcel.writeString(this.linkName);
        parcel.writeString(this.linkCaption);
        parcel.writeString(this.linkDescription);
        parcel.writeString(this.picture);
        parcel.writeString(this.mediaSource);
    }
}
