package com.facebook;

import android.content.Intent;
import com.facebook.internal.Utility;
import com.facebook.internal.Validate;
import p000c.p001m.p002x.p003a.gv.ax;

final class ProfileManager {
    static final String ACTION_CURRENT_PROFILE_CHANGED = "com.facebook.sdk.ACTION_CURRENT_PROFILE_CHANGED";
    static final String EXTRA_NEW_PROFILE = "com.facebook.sdk.EXTRA_NEW_PROFILE";
    static final String EXTRA_OLD_PROFILE = "com.facebook.sdk.EXTRA_OLD_PROFILE";
    private static volatile ProfileManager instance;
    private Profile currentProfile;
    private final ax localBroadcastManager;
    private final ProfileCache profileCache;

    ProfileManager(ax axVar, ProfileCache profileCache) {
        Validate.notNull(axVar, "localBroadcastManager");
        Validate.notNull(profileCache, "profileCache");
        this.localBroadcastManager = axVar;
        this.profileCache = profileCache;
    }

    static ProfileManager getInstance() {
        if (instance == null) {
            synchronized (ProfileManager.class) {
                if (instance == null) {
                    instance = new ProfileManager(ax.m123a(FacebookSdk.getApplicationContext()), new ProfileCache());
                }
            }
        }
        return instance;
    }

    private void sendCurrentProfileChangedBroadcast(Profile profile, Profile profile2) {
        Intent intent = new Intent(ACTION_CURRENT_PROFILE_CHANGED);
        intent.putExtra(EXTRA_OLD_PROFILE, profile);
        intent.putExtra(EXTRA_NEW_PROFILE, profile2);
        this.localBroadcastManager.m127a(intent);
    }

    private void setCurrentProfile(Profile profile, boolean z) {
        Profile profile2 = this.currentProfile;
        this.currentProfile = profile;
        if (z) {
            if (profile != null) {
                this.profileCache.save(profile);
            } else {
                this.profileCache.clear();
            }
        }
        if (!Utility.areObjectsEqual(profile2, profile)) {
            sendCurrentProfileChangedBroadcast(profile2, profile);
        }
    }

    final Profile getCurrentProfile() {
        return this.currentProfile;
    }

    final boolean loadCurrentProfile() {
        Profile load = this.profileCache.load();
        if (load == null) {
            return false;
        }
        setCurrentProfile(load, false);
        return true;
    }

    final void setCurrentProfile(Profile profile) {
        setCurrentProfile(profile, true);
    }
}
