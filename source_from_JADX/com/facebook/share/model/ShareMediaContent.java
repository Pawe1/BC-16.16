package com.facebook.share.model;

import android.os.Parcel;
import android.os.Parcelable.Creator;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

public final class ShareMediaContent extends ShareContent<ShareMediaContent, Builder> {
    public static final Creator<ShareMediaContent> CREATOR = new C03521();
    private final List<ShareMedia> media;

    final class C03521 implements Creator<ShareMediaContent> {
        C03521() {
        }

        public final ShareMediaContent createFromParcel(Parcel parcel) {
            return new ShareMediaContent(parcel);
        }

        public final ShareMediaContent[] newArray(int i) {
            return new ShareMediaContent[i];
        }
    }

    public static class Builder extends com.facebook.share.model.ShareContent.Builder<ShareMediaContent, Builder> {
        private final List<ShareMedia> media = new ArrayList();

        public Builder addMedia(List<ShareMedia> list) {
            if (list != null) {
                for (ShareMedia addMedium : list) {
                    addMedium(addMedium);
                }
            }
            return this;
        }

        public Builder addMedium(ShareMedia shareMedia) {
            if (shareMedia != null) {
                Object build;
                if (shareMedia instanceof SharePhoto) {
                    build = new com.facebook.share.model.SharePhoto.Builder().readFrom((SharePhoto) shareMedia).build();
                } else if (shareMedia instanceof ShareVideo) {
                    build = new com.facebook.share.model.ShareVideo.Builder().readFrom((ShareVideo) shareMedia).build();
                } else {
                    throw new IllegalArgumentException("medium must be either a SharePhoto or ShareVideo");
                }
                this.media.add(build);
            }
            return this;
        }

        public ShareMediaContent build() {
            return new ShareMediaContent();
        }

        public Builder readFrom(ShareMediaContent shareMediaContent) {
            return shareMediaContent == null ? this : ((Builder) super.readFrom((ShareContent) shareMediaContent)).addMedia(shareMediaContent.getMedia());
        }

        public Builder setMedia(List<ShareMedia> list) {
            this.media.clear();
            addMedia(list);
            return this;
        }
    }

    ShareMediaContent(Parcel parcel) {
        super(parcel);
        this.media = Arrays.asList((ShareMedia[]) parcel.readParcelableArray(ShareMedia.class.getClassLoader()));
    }

    private ShareMediaContent(Builder builder) {
        super((com.facebook.share.model.ShareContent.Builder) builder);
        this.media = Collections.unmodifiableList(builder.media);
    }

    public final int describeContents() {
        return 0;
    }

    public final List<ShareMedia> getMedia() {
        return this.media;
    }

    public final void writeToParcel(Parcel parcel, int i) {
        super.writeToParcel(parcel, i);
        parcel.writeParcelableArray((ShareMedia[]) this.media.toArray(), i);
    }
}
