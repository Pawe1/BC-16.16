package com.facebook.share.model;

import android.os.Parcel;
import android.os.Parcelable.Creator;

public final class AppGroupCreationContent implements ShareModel {
    public static final Creator<AppGroupCreationContent> CREATOR = new C03471();
    private final String description;
    private final String name;
    private AppGroupPrivacy privacy;

    final class C03471 implements Creator<AppGroupCreationContent> {
        C03471() {
        }

        public final AppGroupCreationContent createFromParcel(Parcel parcel) {
            return new AppGroupCreationContent(parcel);
        }

        public final AppGroupCreationContent[] newArray(int i) {
            return new AppGroupCreationContent[i];
        }
    }

    public enum AppGroupPrivacy {
        Open,
        Closed
    }

    public static class Builder implements ShareModelBuilder<AppGroupCreationContent, Builder> {
        private String description;
        private String name;
        private AppGroupPrivacy privacy;

        public AppGroupCreationContent build() {
            return new AppGroupCreationContent();
        }

        public Builder readFrom(AppGroupCreationContent appGroupCreationContent) {
            return appGroupCreationContent == null ? this : setName(appGroupCreationContent.getName()).setDescription(appGroupCreationContent.getDescription()).setAppGroupPrivacy(appGroupCreationContent.getAppGroupPrivacy());
        }

        public Builder setAppGroupPrivacy(AppGroupPrivacy appGroupPrivacy) {
            this.privacy = appGroupPrivacy;
            return this;
        }

        public Builder setDescription(String str) {
            this.description = str;
            return this;
        }

        public Builder setName(String str) {
            this.name = str;
            return this;
        }
    }

    AppGroupCreationContent(Parcel parcel) {
        this.name = parcel.readString();
        this.description = parcel.readString();
        this.privacy = (AppGroupPrivacy) parcel.readSerializable();
    }

    private AppGroupCreationContent(Builder builder) {
        this.name = builder.name;
        this.description = builder.description;
        this.privacy = builder.privacy;
    }

    public final int describeContents() {
        return 0;
    }

    public final AppGroupPrivacy getAppGroupPrivacy() {
        return this.privacy;
    }

    public final String getDescription() {
        return this.description;
    }

    public final String getName() {
        return this.name;
    }

    public final void writeToParcel(Parcel parcel, int i) {
        parcel.writeString(this.name);
        parcel.writeString(this.description);
        parcel.writeSerializable(this.privacy);
    }
}
