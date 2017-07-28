package com.facebook.share.internal;

import android.os.Bundle;
import com.facebook.FacebookException;
import com.facebook.internal.Utility;
import com.facebook.internal.Validate;
import com.facebook.share.model.ShareContent;
import com.facebook.share.model.ShareLinkContent;
import com.facebook.share.model.ShareOpenGraphContent;
import com.facebook.share.model.SharePhotoContent;
import com.facebook.share.model.ShareVideoContent;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.UUID;
import org.json.JSONException;
import org.json.JSONObject;

public class NativeDialogParameters {
    private static Bundle create(ShareLinkContent shareLinkContent, boolean z) {
        Bundle createBaseParameters = createBaseParameters(shareLinkContent, z);
        Utility.putNonEmptyString(createBaseParameters, ShareConstants.TITLE, shareLinkContent.getContentTitle());
        Utility.putNonEmptyString(createBaseParameters, ShareConstants.DESCRIPTION, shareLinkContent.getContentDescription());
        Utility.putUri(createBaseParameters, ShareConstants.IMAGE_URL, shareLinkContent.getImageUrl());
        return createBaseParameters;
    }

    private static Bundle create(ShareOpenGraphContent shareOpenGraphContent, JSONObject jSONObject, boolean z) {
        Bundle createBaseParameters = createBaseParameters(shareOpenGraphContent, z);
        Utility.putNonEmptyString(createBaseParameters, ShareConstants.PREVIEW_PROPERTY_NAME, (String) ShareInternalUtility.getFieldNameAndNamespaceFromFullName(shareOpenGraphContent.getPreviewPropertyName()).second);
        Utility.putNonEmptyString(createBaseParameters, ShareConstants.ACTION_TYPE, shareOpenGraphContent.getAction().getActionType());
        Utility.putNonEmptyString(createBaseParameters, ShareConstants.ACTION, jSONObject.toString());
        return createBaseParameters;
    }

    private static Bundle create(SharePhotoContent sharePhotoContent, List<String> list, boolean z) {
        Bundle createBaseParameters = createBaseParameters(sharePhotoContent, z);
        createBaseParameters.putStringArrayList(ShareConstants.PHOTOS, new ArrayList(list));
        return createBaseParameters;
    }

    private static Bundle create(ShareVideoContent shareVideoContent, String str, boolean z) {
        Bundle createBaseParameters = createBaseParameters(shareVideoContent, z);
        Utility.putNonEmptyString(createBaseParameters, ShareConstants.TITLE, shareVideoContent.getContentTitle());
        Utility.putNonEmptyString(createBaseParameters, ShareConstants.DESCRIPTION, shareVideoContent.getContentDescription());
        Utility.putNonEmptyString(createBaseParameters, ShareConstants.VIDEO_URL, str);
        return createBaseParameters;
    }

    public static Bundle create(UUID uuid, ShareContent shareContent, boolean z) {
        Validate.notNull(shareContent, "shareContent");
        Validate.notNull(uuid, "callId");
        if (shareContent instanceof ShareLinkContent) {
            return create((ShareLinkContent) shareContent, z);
        }
        if (shareContent instanceof SharePhotoContent) {
            SharePhotoContent sharePhotoContent = (SharePhotoContent) shareContent;
            return create(sharePhotoContent, ShareInternalUtility.getPhotoUrls(sharePhotoContent, uuid), z);
        } else if (shareContent instanceof ShareVideoContent) {
            ShareVideoContent shareVideoContent = (ShareVideoContent) shareContent;
            return create(shareVideoContent, ShareInternalUtility.getVideoUrl(shareVideoContent, uuid), z);
        } else if (!(shareContent instanceof ShareOpenGraphContent)) {
            return null;
        } else {
            ShareOpenGraphContent shareOpenGraphContent = (ShareOpenGraphContent) shareContent;
            try {
                return create(shareOpenGraphContent, ShareInternalUtility.removeNamespacesFromOGJsonObject(ShareInternalUtility.toJSONObjectForCall(uuid, shareOpenGraphContent), false), z);
            } catch (JSONException e) {
                throw new FacebookException("Unable to create a JSON Object from the provided ShareOpenGraphContent: " + e.getMessage());
            }
        }
    }

    private static Bundle createBaseParameters(ShareContent shareContent, boolean z) {
        Bundle bundle = new Bundle();
        Utility.putUri(bundle, ShareConstants.CONTENT_URL, shareContent.getContentUrl());
        Utility.putNonEmptyString(bundle, ShareConstants.PLACE_ID, shareContent.getPlaceId());
        Utility.putNonEmptyString(bundle, ShareConstants.REF, shareContent.getRef());
        bundle.putBoolean(ShareConstants.DATA_FAILURES_FATAL, z);
        Collection peopleIds = shareContent.getPeopleIds();
        if (!Utility.isNullOrEmpty(peopleIds)) {
            bundle.putStringArrayList(ShareConstants.PEOPLE_IDS, new ArrayList(peopleIds));
        }
        return bundle;
    }
}
