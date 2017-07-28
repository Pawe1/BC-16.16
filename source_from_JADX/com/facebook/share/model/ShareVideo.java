package com.facebook.share.model;

import android.net.Uri;
import android.os.Parcel;
import android.os.Parcelable.Creator;
import com.facebook.share.model.ShareMedia.Type;

public final class ShareVideo extends ShareMedia {
    public static final Creator<ShareVideo> CREATOR = new C03581();
    private final Uri localUrl;

    final class C03581 implements Creator<ShareVideo> {
        C03581() {
        }

        public final ShareVideo createFromParcel(Parcel parcel) {
            return new ShareVideo(parcel);
        }

        public final ShareVideo[] newArray(int i) {
            return new ShareVideo[i];
        }
    }

    public static final class Builder extends com.facebook.share.model.ShareMedia.Builder<ShareVideo, Builder> {
        private Uri localUrl;

        public final ShareVideo build() {
            return new ShareVideo();
        }

        final Builder readFrom(Parcel parcel) {
            return readFrom((ShareVideo) parcel.readParcelable(ShareVideo.class.getClassLoader()));
        }

        public final Builder readFrom(ShareVideo shareVideo) {
            return shareVideo == null ? this : ((Builder) super.readFrom((ShareMedia) shareVideo)).setLocalUrl(shareVideo.getLocalUrl());
        }

        public final Builder setLocalUrl(Uri uri) {
            this.localUrl = uri;
            return this;
        }
    }

    ShareVideo(Parcel parcel) {
        super(parcel);
        this.localUrl = (Uri) parcel.readParcelable(Uri.class.getClassLoader());
    }

    private ShareVideo(Builder builder) {
        super((com.facebook.share.model.ShareMedia.Builder) builder);
        this.localUrl = builder.localUrl;
    }

    public final int describeContents() {
        return 0;
    }

    public final Uri getLocalUrl() {
        return this.localUrl;
    }

    public final Type getMediaType() {
        return Type.VIDEO;
    }

    public final void writeToParcel(Parcel parcel, int i) {
        super.writeToParcel(parcel, i);
        parcel.writeParcelable(this.localUrl, 0);
    }
}
