package com.facebook.share.model;

import android.net.Uri;
import android.os.Parcel;
import android.os.Parcelable.Creator;

public final class ShareLinkContent extends ShareContent<ShareLinkContent, Builder> {
    public static final Creator<ShareLinkContent> CREATOR = new C03511();
    private final String contentDescription;
    private final String contentTitle;
    private final Uri imageUrl;
    private final String quote;

    final class C03511 implements Creator<ShareLinkContent> {
        C03511() {
        }

        public final ShareLinkContent createFromParcel(Parcel parcel) {
            return new ShareLinkContent(parcel);
        }

        public final ShareLinkContent[] newArray(int i) {
            return new ShareLinkContent[i];
        }
    }

    public static final class Builder extends com.facebook.share.model.ShareContent.Builder<ShareLinkContent, Builder> {
        private String contentDescription;
        private String contentTitle;
        private Uri imageUrl;
        private String quote;

        public final ShareLinkContent build() {
            return new ShareLinkContent();
        }

        public final Builder readFrom(ShareLinkContent shareLinkContent) {
            return shareLinkContent == null ? this : ((Builder) super.readFrom((ShareContent) shareLinkContent)).setContentDescription(shareLinkContent.getContentDescription()).setImageUrl(shareLinkContent.getImageUrl()).setContentTitle(shareLinkContent.getContentTitle()).setQuote(shareLinkContent.getQuote());
        }

        public final Builder setContentDescription(String str) {
            this.contentDescription = str;
            return this;
        }

        public final Builder setContentTitle(String str) {
            this.contentTitle = str;
            return this;
        }

        public final Builder setImageUrl(Uri uri) {
            this.imageUrl = uri;
            return this;
        }

        public final Builder setQuote(String str) {
            this.quote = str;
            return this;
        }
    }

    ShareLinkContent(Parcel parcel) {
        super(parcel);
        this.contentDescription = parcel.readString();
        this.contentTitle = parcel.readString();
        this.imageUrl = (Uri) parcel.readParcelable(Uri.class.getClassLoader());
        this.quote = parcel.readString();
    }

    private ShareLinkContent(Builder builder) {
        super((com.facebook.share.model.ShareContent.Builder) builder);
        this.contentDescription = builder.contentDescription;
        this.contentTitle = builder.contentTitle;
        this.imageUrl = builder.imageUrl;
        this.quote = builder.quote;
    }

    public final int describeContents() {
        return 0;
    }

    public final String getContentDescription() {
        return this.contentDescription;
    }

    public final String getContentTitle() {
        return this.contentTitle;
    }

    public final Uri getImageUrl() {
        return this.imageUrl;
    }

    public final String getQuote() {
        return this.quote;
    }

    public final void writeToParcel(Parcel parcel, int i) {
        super.writeToParcel(parcel, i);
        parcel.writeString(this.contentDescription);
        parcel.writeString(this.contentTitle);
        parcel.writeParcelable(this.imageUrl, 0);
        parcel.writeString(this.quote);
    }
}
