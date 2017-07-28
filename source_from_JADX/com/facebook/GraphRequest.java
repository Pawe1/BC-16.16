package com.facebook;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.Bitmap.CompressFormat;
import android.location.Location;
import android.net.Uri;
import android.net.Uri.Builder;
import android.os.Bundle;
import android.os.Handler;
import android.os.Parcel;
import android.os.ParcelFileDescriptor;
import android.os.ParcelFileDescriptor.AutoCloseInputStream;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import android.text.TextUtils;
import android.util.Log;
import android.util.Pair;
import com.facebook.appevents.AppEventsConstants;
import com.facebook.internal.AttributionIdentifiers;
import com.facebook.internal.InternalSettings;
import com.facebook.internal.Logger;
import com.facebook.internal.ServerProtocol;
import com.facebook.internal.Utility;
import com.facebook.internal.Validate;
import com.facebook.share.internal.OpenGraphJSONUtility;
import com.facebook.share.internal.OpenGraphJSONUtility.PhotoJSONProcessor;
import com.facebook.share.internal.ShareConstants;
import com.facebook.share.model.ShareOpenGraphObject;
import com.facebook.share.model.SharePhoto;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.zip.GZIPOutputStream;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class GraphRequest {
    private static final String ACCEPT_LANGUAGE_HEADER = "Accept-Language";
    public static final String ACCESS_TOKEN_PARAM = "access_token";
    private static final String ATTACHED_FILES_PARAM = "attached_files";
    private static final String ATTACHMENT_FILENAME_PREFIX = "file";
    private static final String BATCH_APP_ID_PARAM = "batch_app_id";
    private static final String BATCH_BODY_PARAM = "body";
    private static final String BATCH_ENTRY_DEPENDS_ON_PARAM = "depends_on";
    private static final String BATCH_ENTRY_NAME_PARAM = "name";
    private static final String BATCH_ENTRY_OMIT_RESPONSE_ON_SUCCESS_PARAM = "omit_response_on_success";
    private static final String BATCH_METHOD_PARAM = "method";
    private static final String BATCH_PARAM = "batch";
    private static final String BATCH_RELATIVE_URL_PARAM = "relative_url";
    private static final String CAPTION_PARAM = "caption";
    private static final String CONTENT_ENCODING_HEADER = "Content-Encoding";
    private static final String CONTENT_TYPE_HEADER = "Content-Type";
    private static final String DEBUG_KEY = "__debug__";
    private static final String DEBUG_MESSAGES_KEY = "messages";
    private static final String DEBUG_MESSAGE_KEY = "message";
    private static final String DEBUG_MESSAGE_LINK_KEY = "link";
    private static final String DEBUG_MESSAGE_TYPE_KEY = "type";
    private static final String DEBUG_PARAM = "debug";
    private static final String DEBUG_SEVERITY_INFO = "info";
    private static final String DEBUG_SEVERITY_WARNING = "warning";
    public static final String FIELDS_PARAM = "fields";
    private static final String FORMAT_JSON = "json";
    private static final String FORMAT_PARAM = "format";
    private static final String GRAPH_PATH_FORMAT = "%s/%s";
    private static final String ISO_8601_FORMAT_STRING = "yyyy-MM-dd'T'HH:mm:ssZ";
    public static final int MAXIMUM_BATCH_SIZE = 50;
    private static final String ME = "me";
    private static final String MIME_BOUNDARY = "3i2ndDfv2rTHiSisAbouNdArYfORhtTPEefj3q2f";
    private static final String MY_FRIENDS = "me/friends";
    private static final String MY_PHOTOS = "me/photos";
    private static final String PICTURE_PARAM = "picture";
    private static final String SDK_ANDROID = "android";
    private static final String SDK_PARAM = "sdk";
    private static final String SEARCH = "search";
    public static final String TAG = GraphRequest.class.getSimpleName();
    private static final String USER_AGENT_BASE = "FBAndroidSDK";
    private static final String USER_AGENT_HEADER = "User-Agent";
    private static final String VIDEOS_SUFFIX = "/videos";
    private static String defaultBatchApplicationId;
    private static volatile String userAgent;
    private static Pattern versionPattern = Pattern.compile("^/?v\\d+\\.\\d+/(.*)");
    private AccessToken accessToken;
    private String batchEntryDependsOn;
    private String batchEntryName;
    private boolean batchEntryOmitResultOnSuccess;
    private Callback callback;
    private JSONObject graphObject;
    private String graphPath;
    private HttpMethod httpMethod;
    private String overriddenURL;
    private Bundle parameters;
    private boolean skipClientToken;
    private Object tag;
    private String version;

    public interface Callback {
        void onCompleted(GraphResponse graphResponse);
    }

    final class C01841 implements Callback {
        final /* synthetic */ GraphJSONObjectCallback val$callback;

        C01841(GraphJSONObjectCallback graphJSONObjectCallback) {
            this.val$callback = graphJSONObjectCallback;
        }

        public final void onCompleted(GraphResponse graphResponse) {
            if (this.val$callback != null) {
                this.val$callback.onCompleted(graphResponse.getJSONObject(), graphResponse);
            }
        }
    }

    final class C01852 implements Callback {
        final /* synthetic */ GraphJSONArrayCallback val$callback;

        C01852(GraphJSONArrayCallback graphJSONArrayCallback) {
            this.val$callback = graphJSONArrayCallback;
        }

        public final void onCompleted(GraphResponse graphResponse) {
            if (this.val$callback != null) {
                JSONObject jSONObject = graphResponse.getJSONObject();
                this.val$callback.onCompleted(jSONObject != null ? jSONObject.optJSONArray(ShareConstants.WEB_DIALOG_PARAM_DATA) : null, graphResponse);
            }
        }
    }

    final class C01863 implements Callback {
        final /* synthetic */ GraphJSONArrayCallback val$callback;

        C01863(GraphJSONArrayCallback graphJSONArrayCallback) {
            this.val$callback = graphJSONArrayCallback;
        }

        public final void onCompleted(GraphResponse graphResponse) {
            if (this.val$callback != null) {
                JSONObject jSONObject = graphResponse.getJSONObject();
                this.val$callback.onCompleted(jSONObject != null ? jSONObject.optJSONArray(ShareConstants.WEB_DIALOG_PARAM_DATA) : null, graphResponse);
            }
        }
    }

    final class C01885 implements Runnable {
        final /* synthetic */ ArrayList val$callbacks;
        final /* synthetic */ GraphRequestBatch val$requests;

        C01885(ArrayList arrayList, GraphRequestBatch graphRequestBatch) {
            this.val$callbacks = arrayList;
            this.val$requests = graphRequestBatch;
        }

        public final void run() {
            Iterator it = this.val$callbacks.iterator();
            while (it.hasNext()) {
                Pair pair = (Pair) it.next();
                ((Callback) pair.first).onCompleted((GraphResponse) pair.second);
            }
            for (com.facebook.GraphRequestBatch.Callback onBatchCompleted : this.val$requests.getCallbacks()) {
                onBatchCompleted.onBatchCompleted(this.val$requests);
            }
        }
    }

    private interface KeyValueSerializer {
        void writeString(String str, String str2);
    }

    final class C01907 implements PhotoJSONProcessor {
        C01907() {
        }

        public final JSONObject toJSONObject(SharePhoto sharePhoto) {
            Uri imageUrl = sharePhoto.getImageUrl();
            JSONObject jSONObject = new JSONObject();
            try {
                jSONObject.put("url", imageUrl.toString());
                return jSONObject;
            } catch (Throwable e) {
                throw new FacebookException("Unable to attach images", e);
            }
        }
    }

    private static class Attachment {
        private final GraphRequest request;
        private final Object value;

        public Attachment(GraphRequest graphRequest, Object obj) {
            this.request = graphRequest;
            this.value = obj;
        }

        public GraphRequest getRequest() {
            return this.request;
        }

        public Object getValue() {
            return this.value;
        }
    }

    public interface GraphJSONArrayCallback {
        void onCompleted(JSONArray jSONArray, GraphResponse graphResponse);
    }

    public interface GraphJSONObjectCallback {
        void onCompleted(JSONObject jSONObject, GraphResponse graphResponse);
    }

    public interface OnProgressCallback extends Callback {
        void onProgress(long j, long j2);
    }

    public static class ParcelableResourceWithMimeType<RESOURCE extends Parcelable> implements Parcelable {
        public static final Creator<ParcelableResourceWithMimeType> CREATOR = new C01911();
        private final String mimeType;
        private final RESOURCE resource;

        final class C01911 implements Creator<ParcelableResourceWithMimeType> {
            C01911() {
            }

            public final ParcelableResourceWithMimeType createFromParcel(Parcel parcel) {
                return new ParcelableResourceWithMimeType(parcel);
            }

            public final ParcelableResourceWithMimeType[] newArray(int i) {
                return new ParcelableResourceWithMimeType[i];
            }
        }

        private ParcelableResourceWithMimeType(Parcel parcel) {
            this.mimeType = parcel.readString();
            this.resource = parcel.readParcelable(FacebookSdk.getApplicationContext().getClassLoader());
        }

        public ParcelableResourceWithMimeType(RESOURCE resource, String str) {
            this.mimeType = str;
            this.resource = resource;
        }

        public int describeContents() {
            return 1;
        }

        public String getMimeType() {
            return this.mimeType;
        }

        public RESOURCE getResource() {
            return this.resource;
        }

        public void writeToParcel(Parcel parcel, int i) {
            parcel.writeString(this.mimeType);
            parcel.writeParcelable(this.resource, i);
        }
    }

    private static class Serializer implements KeyValueSerializer {
        private boolean firstWrite = true;
        private final Logger logger;
        private final OutputStream outputStream;
        private boolean useUrlEncode = false;

        public Serializer(OutputStream outputStream, Logger logger, boolean z) {
            this.outputStream = outputStream;
            this.logger = logger;
            this.useUrlEncode = z;
        }

        private RuntimeException getInvalidTypeError() {
            return new IllegalArgumentException("value is not a supported type.");
        }

        public void write(String str, Object... objArr) {
            if (this.useUrlEncode) {
                this.outputStream.write(URLEncoder.encode(String.format(Locale.US, str, objArr), "UTF-8").getBytes());
                return;
            }
            if (this.firstWrite) {
                this.outputStream.write("--".getBytes());
                this.outputStream.write(GraphRequest.MIME_BOUNDARY.getBytes());
                this.outputStream.write("\r\n".getBytes());
                this.firstWrite = false;
            }
            this.outputStream.write(String.format(str, objArr).getBytes());
        }

        public void writeBitmap(String str, Bitmap bitmap) {
            writeContentDisposition(str, str, "image/png");
            bitmap.compress(CompressFormat.PNG, 100, this.outputStream);
            writeLine("", new Object[0]);
            writeRecordBoundary();
            if (this.logger != null) {
                this.logger.appendKeyValue("    " + str, "<Image>");
            }
        }

        public void writeBytes(String str, byte[] bArr) {
            writeContentDisposition(str, str, "content/unknown");
            this.outputStream.write(bArr);
            writeLine("", new Object[0]);
            writeRecordBoundary();
            if (this.logger != null) {
                this.logger.appendKeyValue("    " + str, String.format(Locale.ROOT, "<Data: %d>", new Object[]{Integer.valueOf(bArr.length)}));
            }
        }

        public void writeContentDisposition(String str, String str2, String str3) {
            if (this.useUrlEncode) {
                this.outputStream.write(String.format("%s=", new Object[]{str}).getBytes());
                return;
            }
            write("Content-Disposition: form-data; name=\"%s\"", str);
            if (str2 != null) {
                write("; filename=\"%s\"", str2);
            }
            writeLine("", new Object[0]);
            if (str3 != null) {
                writeLine("%s: %s", GraphRequest.CONTENT_TYPE_HEADER, str3);
            }
            writeLine("", new Object[0]);
        }

        public void writeContentUri(String str, Uri uri, String str2) {
            int i;
            if (str2 == null) {
                str2 = "content/unknown";
            }
            writeContentDisposition(str, str, str2);
            if (this.outputStream instanceof ProgressNoopOutputStream) {
                ((ProgressNoopOutputStream) this.outputStream).addProgress(Utility.getContentSize(uri));
                i = 0;
            } else {
                i = Utility.copyAndCloseInputStream(FacebookSdk.getApplicationContext().getContentResolver().openInputStream(uri), this.outputStream) + 0;
            }
            writeLine("", new Object[0]);
            writeRecordBoundary();
            if (this.logger != null) {
                this.logger.appendKeyValue("    " + str, String.format(Locale.ROOT, "<Data: %d>", new Object[]{Integer.valueOf(i)}));
            }
        }

        public void writeFile(String str, ParcelFileDescriptor parcelFileDescriptor, String str2) {
            int i;
            if (str2 == null) {
                str2 = "content/unknown";
            }
            writeContentDisposition(str, str, str2);
            if (this.outputStream instanceof ProgressNoopOutputStream) {
                ((ProgressNoopOutputStream) this.outputStream).addProgress(parcelFileDescriptor.getStatSize());
                i = 0;
            } else {
                i = Utility.copyAndCloseInputStream(new AutoCloseInputStream(parcelFileDescriptor), this.outputStream) + 0;
            }
            writeLine("", new Object[0]);
            writeRecordBoundary();
            if (this.logger != null) {
                this.logger.appendKeyValue("    " + str, String.format(Locale.ROOT, "<Data: %d>", new Object[]{Integer.valueOf(i)}));
            }
        }

        public void writeLine(String str, Object... objArr) {
            write(str, objArr);
            if (!this.useUrlEncode) {
                write("\r\n", new Object[0]);
            }
        }

        public void writeObject(String str, Object obj, GraphRequest graphRequest) {
            if (this.outputStream instanceof RequestOutputStream) {
                ((RequestOutputStream) this.outputStream).setCurrentRequest(graphRequest);
            }
            if (GraphRequest.isSupportedParameterType(obj)) {
                writeString(str, GraphRequest.parameterToString(obj));
            } else if (obj instanceof Bitmap) {
                writeBitmap(str, (Bitmap) obj);
            } else if (obj instanceof byte[]) {
                writeBytes(str, (byte[]) obj);
            } else if (obj instanceof Uri) {
                writeContentUri(str, (Uri) obj, null);
            } else if (obj instanceof ParcelFileDescriptor) {
                writeFile(str, (ParcelFileDescriptor) obj, null);
            } else if (obj instanceof ParcelableResourceWithMimeType) {
                ParcelableResourceWithMimeType parcelableResourceWithMimeType = (ParcelableResourceWithMimeType) obj;
                Parcelable resource = parcelableResourceWithMimeType.getResource();
                String mimeType = parcelableResourceWithMimeType.getMimeType();
                if (resource instanceof ParcelFileDescriptor) {
                    writeFile(str, (ParcelFileDescriptor) resource, mimeType);
                } else if (resource instanceof Uri) {
                    writeContentUri(str, (Uri) resource, mimeType);
                } else {
                    throw getInvalidTypeError();
                }
            } else {
                throw getInvalidTypeError();
            }
        }

        public void writeRecordBoundary() {
            if (this.useUrlEncode) {
                this.outputStream.write("&".getBytes());
                return;
            }
            writeLine("--%s", GraphRequest.MIME_BOUNDARY);
        }

        public void writeRequestsAsJson(String str, JSONArray jSONArray, Collection<GraphRequest> collection) {
            if (this.outputStream instanceof RequestOutputStream) {
                RequestOutputStream requestOutputStream = (RequestOutputStream) this.outputStream;
                writeContentDisposition(str, null, null);
                write("[", new Object[0]);
                int i = 0;
                for (GraphRequest graphRequest : collection) {
                    JSONObject jSONObject = jSONArray.getJSONObject(i);
                    requestOutputStream.setCurrentRequest(graphRequest);
                    if (i > 0) {
                        write(",%s", jSONObject.toString());
                    } else {
                        write("%s", jSONObject.toString());
                    }
                    i++;
                }
                write("]", new Object[0]);
                if (this.logger != null) {
                    this.logger.appendKeyValue("    " + str, jSONArray.toString());
                    return;
                }
                return;
            }
            writeString(str, jSONArray.toString());
        }

        public void writeString(String str, String str2) {
            writeContentDisposition(str, null, null);
            writeLine("%s", str2);
            writeRecordBoundary();
            if (this.logger != null) {
                this.logger.appendKeyValue("    " + str, str2);
            }
        }
    }

    public GraphRequest() {
        this(null, null, null, null, null);
    }

    public GraphRequest(AccessToken accessToken, String str) {
        this(accessToken, str, null, null, null);
    }

    public GraphRequest(AccessToken accessToken, String str, Bundle bundle, HttpMethod httpMethod) {
        this(accessToken, str, bundle, httpMethod, null);
    }

    public GraphRequest(AccessToken accessToken, String str, Bundle bundle, HttpMethod httpMethod, Callback callback) {
        this(accessToken, str, bundle, httpMethod, callback, null);
    }

    public GraphRequest(AccessToken accessToken, String str, Bundle bundle, HttpMethod httpMethod, Callback callback, String str2) {
        this.batchEntryOmitResultOnSuccess = true;
        this.skipClientToken = false;
        this.accessToken = accessToken;
        this.graphPath = str;
        this.version = str2;
        setCallback(callback);
        setHttpMethod(httpMethod);
        if (bundle != null) {
            this.parameters = new Bundle(bundle);
        } else {
            this.parameters = new Bundle();
        }
        if (this.version == null) {
            this.version = FacebookSdk.getGraphApiVersion();
        }
    }

    GraphRequest(AccessToken accessToken, URL url) {
        this.batchEntryOmitResultOnSuccess = true;
        this.skipClientToken = false;
        this.accessToken = accessToken;
        this.overriddenURL = url.toString();
        setHttpMethod(HttpMethod.GET);
        this.parameters = new Bundle();
    }

    private void addCommonParameters() {
        String token;
        if (this.accessToken != null) {
            if (!this.parameters.containsKey("access_token")) {
                token = this.accessToken.getToken();
                Logger.registerAccessToken(token);
                this.parameters.putString("access_token", token);
            }
        } else if (!(this.skipClientToken || this.parameters.containsKey("access_token"))) {
            token = FacebookSdk.getApplicationId();
            String clientToken = FacebookSdk.getClientToken();
            if (Utility.isNullOrEmpty(token) || Utility.isNullOrEmpty(clientToken)) {
                Log.d(TAG, "Warning: Request without access token missing application ID or client token.");
            } else {
                this.parameters.putString("access_token", token + "|" + clientToken);
            }
        }
        this.parameters.putString("sdk", SDK_ANDROID);
        this.parameters.putString(FORMAT_PARAM, FORMAT_JSON);
        if (FacebookSdk.isLoggingBehaviorEnabled(LoggingBehavior.GRAPH_API_DEBUG_INFO)) {
            this.parameters.putString(DEBUG_PARAM, DEBUG_SEVERITY_INFO);
        } else if (FacebookSdk.isLoggingBehaviorEnabled(LoggingBehavior.GRAPH_API_DEBUG_WARNING)) {
            this.parameters.putString(DEBUG_PARAM, DEBUG_SEVERITY_WARNING);
        }
    }

    private String appendParametersToBaseUrl(String str) {
        Builder buildUpon = Uri.parse(str).buildUpon();
        for (String str2 : this.parameters.keySet()) {
            Object obj = this.parameters.get(str2);
            if (obj == null) {
                obj = "";
            }
            if (isSupportedParameterType(obj)) {
                buildUpon.appendQueryParameter(str2, parameterToString(obj).toString());
            } else if (this.httpMethod == HttpMethod.GET) {
                throw new IllegalArgumentException(String.format(Locale.US, "Unsupported parameter type for GET request: %s", new Object[]{obj.getClass().getSimpleName()}));
            }
        }
        return buildUpon.toString();
    }

    private static HttpURLConnection createConnection(URL url) {
        HttpURLConnection httpURLConnection = (HttpURLConnection) url.openConnection();
        httpURLConnection.setRequestProperty(USER_AGENT_HEADER, getUserAgent());
        httpURLConnection.setRequestProperty(ACCEPT_LANGUAGE_HEADER, Locale.getDefault().toString());
        httpURLConnection.setChunkedStreamingMode(0);
        return httpURLConnection;
    }

    public static GraphRequest createOpenGraphObject(ShareOpenGraphObject shareOpenGraphObject) {
        String string = shareOpenGraphObject.getString("type");
        if ((string == null ? shareOpenGraphObject.getString("og:type") : string) == null) {
            throw new FacebookException("Open graph object type cannot be null");
        }
        try {
            JSONObject jSONObject = (JSONObject) OpenGraphJSONUtility.toJSONValue(shareOpenGraphObject, new C01907());
            Bundle bundle = new Bundle();
            bundle.putString("object", jSONObject.toString());
            return new GraphRequest(AccessToken.getCurrentAccessToken(), String.format(Locale.ROOT, GRAPH_PATH_FORMAT, new Object[]{ME, "objects/" + r1}), bundle, HttpMethod.POST);
        } catch (JSONException e) {
            throw new FacebookException(e.getMessage());
        }
    }

    public static GraphResponse executeAndWait(GraphRequest graphRequest) {
        List executeBatchAndWait = executeBatchAndWait(graphRequest);
        if (executeBatchAndWait != null && executeBatchAndWait.size() == 1) {
            return (GraphResponse) executeBatchAndWait.get(0);
        }
        throw new FacebookException("invalid state: expected a single response");
    }

    public static List<GraphResponse> executeBatchAndWait(GraphRequestBatch graphRequestBatch) {
        List<GraphResponse> executeConnectionAndWait;
        URLConnection uRLConnection = null;
        Validate.notEmptyAndContainsNoNulls(graphRequestBatch, "requests");
        try {
            uRLConnection = toHttpConnection(graphRequestBatch);
            executeConnectionAndWait = executeConnectionAndWait((HttpURLConnection) uRLConnection, graphRequestBatch);
        } catch (Throwable e) {
            executeConnectionAndWait = GraphResponse.constructErrorResponses(graphRequestBatch.getRequests(), null, new FacebookException(e));
            runCallbacks(graphRequestBatch, executeConnectionAndWait);
        } finally {
            Utility.disconnectQuietly(uRLConnection);
        }
        return executeConnectionAndWait;
    }

    public static List<GraphResponse> executeBatchAndWait(Collection<GraphRequest> collection) {
        return executeBatchAndWait(new GraphRequestBatch((Collection) collection));
    }

    public static List<GraphResponse> executeBatchAndWait(GraphRequest... graphRequestArr) {
        Validate.notNull(graphRequestArr, "requests");
        return executeBatchAndWait(Arrays.asList(graphRequestArr));
    }

    public static GraphRequestAsyncTask executeBatchAsync(GraphRequestBatch graphRequestBatch) {
        Validate.notEmptyAndContainsNoNulls(graphRequestBatch, "requests");
        GraphRequestAsyncTask graphRequestAsyncTask = new GraphRequestAsyncTask(graphRequestBatch);
        graphRequestAsyncTask.executeOnExecutor(FacebookSdk.getExecutor(), new Void[0]);
        return graphRequestAsyncTask;
    }

    public static GraphRequestAsyncTask executeBatchAsync(Collection<GraphRequest> collection) {
        return executeBatchAsync(new GraphRequestBatch((Collection) collection));
    }

    public static GraphRequestAsyncTask executeBatchAsync(GraphRequest... graphRequestArr) {
        Validate.notNull(graphRequestArr, "requests");
        return executeBatchAsync(Arrays.asList(graphRequestArr));
    }

    public static List<GraphResponse> executeConnectionAndWait(HttpURLConnection httpURLConnection, GraphRequestBatch graphRequestBatch) {
        List<GraphResponse> fromHttpConnection = GraphResponse.fromHttpConnection(httpURLConnection, graphRequestBatch);
        Utility.disconnectQuietly(httpURLConnection);
        if (graphRequestBatch.size() != fromHttpConnection.size()) {
            throw new FacebookException(String.format(Locale.US, "Received %d responses while expecting %d", new Object[]{Integer.valueOf(fromHttpConnection.size()), Integer.valueOf(graphRequestBatch.size())}));
        }
        runCallbacks(graphRequestBatch, fromHttpConnection);
        AccessTokenManager.getInstance().extendAccessTokenIfNeeded();
        return fromHttpConnection;
    }

    public static List<GraphResponse> executeConnectionAndWait(HttpURLConnection httpURLConnection, Collection<GraphRequest> collection) {
        return executeConnectionAndWait(httpURLConnection, new GraphRequestBatch((Collection) collection));
    }

    public static GraphRequestAsyncTask executeConnectionAsync(Handler handler, HttpURLConnection httpURLConnection, GraphRequestBatch graphRequestBatch) {
        Validate.notNull(httpURLConnection, "connection");
        GraphRequestAsyncTask graphRequestAsyncTask = new GraphRequestAsyncTask(httpURLConnection, graphRequestBatch);
        graphRequestBatch.setCallbackHandler(handler);
        graphRequestAsyncTask.executeOnExecutor(FacebookSdk.getExecutor(), new Void[0]);
        return graphRequestAsyncTask;
    }

    public static GraphRequestAsyncTask executeConnectionAsync(HttpURLConnection httpURLConnection, GraphRequestBatch graphRequestBatch) {
        return executeConnectionAsync(null, httpURLConnection, graphRequestBatch);
    }

    private static String getBatchAppId(GraphRequestBatch graphRequestBatch) {
        if (!Utility.isNullOrEmpty(graphRequestBatch.getBatchApplicationId())) {
            return graphRequestBatch.getBatchApplicationId();
        }
        Iterator it = graphRequestBatch.iterator();
        while (it.hasNext()) {
            AccessToken accessToken = ((GraphRequest) it.next()).accessToken;
            if (accessToken != null) {
                String applicationId = accessToken.getApplicationId();
                if (applicationId != null) {
                    return applicationId;
                }
            }
        }
        return !Utility.isNullOrEmpty(defaultBatchApplicationId) ? defaultBatchApplicationId : FacebookSdk.getApplicationId();
    }

    public static final String getDefaultBatchApplicationId() {
        return defaultBatchApplicationId;
    }

    private static String getDefaultPhotoPathIfNull(String str) {
        return str == null ? "me/photos" : str;
    }

    private String getGraphPathWithVersion() {
        if (versionPattern.matcher(this.graphPath).matches()) {
            return this.graphPath;
        }
        return String.format(GRAPH_PATH_FORMAT, new Object[]{this.version, this.graphPath});
    }

    private static String getMimeContentType() {
        return String.format("multipart/form-data; boundary=%s", new Object[]{MIME_BOUNDARY});
    }

    private static String getUserAgent() {
        if (userAgent == null) {
            userAgent = String.format("%s.%s", new Object[]{USER_AGENT_BASE, FacebookSdkVersion.BUILD});
            if (!Utility.isNullOrEmpty(InternalSettings.getCustomUserAgent())) {
                userAgent = String.format(Locale.ROOT, GRAPH_PATH_FORMAT, new Object[]{userAgent, r0});
            }
        }
        return userAgent;
    }

    private static boolean hasOnProgressCallbacks(GraphRequestBatch graphRequestBatch) {
        for (com.facebook.GraphRequestBatch.Callback callback : graphRequestBatch.getCallbacks()) {
            if (callback instanceof com.facebook.GraphRequestBatch.OnProgressCallback) {
                return true;
            }
        }
        Iterator it = graphRequestBatch.iterator();
        while (it.hasNext()) {
            if (((GraphRequest) it.next()).getCallback() instanceof OnProgressCallback) {
                return true;
            }
        }
        return false;
    }

    private static boolean isGzipCompressible(GraphRequestBatch graphRequestBatch) {
        Iterator it = graphRequestBatch.iterator();
        while (it.hasNext()) {
            GraphRequest graphRequest = (GraphRequest) it.next();
            for (String str : graphRequest.parameters.keySet()) {
                if (isSupportedAttachmentType(graphRequest.parameters.get(str))) {
                    return false;
                }
            }
        }
        return true;
    }

    private static boolean isMeRequest(String str) {
        Matcher matcher = versionPattern.matcher(str);
        if (matcher.matches()) {
            str = matcher.group(1);
        }
        return str.startsWith("me/") || str.startsWith("/me/");
    }

    private static boolean isSupportedAttachmentType(Object obj) {
        return (obj instanceof Bitmap) || (obj instanceof byte[]) || (obj instanceof Uri) || (obj instanceof ParcelFileDescriptor) || (obj instanceof ParcelableResourceWithMimeType);
    }

    private static boolean isSupportedParameterType(Object obj) {
        return (obj instanceof String) || (obj instanceof Boolean) || (obj instanceof Number) || (obj instanceof Date);
    }

    public static GraphRequest newCustomAudienceThirdPartyIdRequest(AccessToken accessToken, Context context, Callback callback) {
        return newCustomAudienceThirdPartyIdRequest(accessToken, context, null, callback);
    }

    public static GraphRequest newCustomAudienceThirdPartyIdRequest(AccessToken accessToken, Context context, String str, Callback callback) {
        String applicationId = (str != null || accessToken == null) ? str : accessToken.getApplicationId();
        if (applicationId == null) {
            applicationId = Utility.getMetadataApplicationId(context);
        }
        if (applicationId == null) {
            throw new FacebookException("Facebook App ID cannot be determined");
        }
        String str2 = applicationId + "/custom_audience_third_party_id";
        AttributionIdentifiers attributionIdentifiers = AttributionIdentifiers.getAttributionIdentifiers(context);
        Bundle bundle = new Bundle();
        if (accessToken == null) {
            if (attributionIdentifiers == null) {
                throw new FacebookException("There is no access token and attribution identifiers could not be retrieved");
            }
            applicationId = attributionIdentifiers.getAttributionId() != null ? attributionIdentifiers.getAttributionId() : attributionIdentifiers.getAndroidAdvertiserId();
            if (attributionIdentifiers.getAttributionId() != null) {
                bundle.putString("udid", applicationId);
            }
        }
        if (FacebookSdk.getLimitEventAndDataUsage(context) || (attributionIdentifiers != null && attributionIdentifiers.isTrackingLimited())) {
            bundle.putString("limit_event_usage", AppEventsConstants.EVENT_PARAM_VALUE_YES);
        }
        return new GraphRequest(accessToken, str2, bundle, HttpMethod.GET, callback);
    }

    public static GraphRequest newDeleteObjectRequest(AccessToken accessToken, String str, Callback callback) {
        return new GraphRequest(accessToken, str, null, HttpMethod.DELETE, callback);
    }

    public static GraphRequest newGraphPathRequest(AccessToken accessToken, String str, Callback callback) {
        return new GraphRequest(accessToken, str, null, null, callback);
    }

    public static GraphRequest newMeRequest(AccessToken accessToken, GraphJSONObjectCallback graphJSONObjectCallback) {
        return new GraphRequest(accessToken, ME, null, null, new C01841(graphJSONObjectCallback));
    }

    public static GraphRequest newMyFriendsRequest(AccessToken accessToken, GraphJSONArrayCallback graphJSONArrayCallback) {
        return new GraphRequest(accessToken, MY_FRIENDS, null, null, new C01852(graphJSONArrayCallback));
    }

    public static GraphRequest newPlacesSearchRequest(AccessToken accessToken, Location location, int i, int i2, String str, GraphJSONArrayCallback graphJSONArrayCallback) {
        if (location == null && Utility.isNullOrEmpty(str)) {
            throw new FacebookException("Either location or searchText must be specified.");
        }
        Bundle bundle = new Bundle(5);
        bundle.putString("type", "place");
        bundle.putInt("limit", i2);
        if (location != null) {
            bundle.putString("center", String.format(Locale.US, "%f,%f", new Object[]{Double.valueOf(location.getLatitude()), Double.valueOf(location.getLongitude())}));
            bundle.putInt("distance", i);
        }
        if (!Utility.isNullOrEmpty(str)) {
            bundle.putString("q", str);
        }
        return new GraphRequest(accessToken, SEARCH, bundle, HttpMethod.GET, new C01863(graphJSONArrayCallback));
    }

    public static GraphRequest newPostRequest(AccessToken accessToken, String str, JSONObject jSONObject, Callback callback) {
        GraphRequest graphRequest = new GraphRequest(accessToken, str, null, HttpMethod.POST, callback);
        graphRequest.graphObject = jSONObject;
        return graphRequest;
    }

    public static GraphRequest newUploadPhotoRequest(AccessToken accessToken, String str, Bitmap bitmap, String str2, Bundle bundle, Callback callback) {
        String defaultPhotoPathIfNull = getDefaultPhotoPathIfNull(str);
        Bundle bundle2 = new Bundle();
        if (bundle != null) {
            bundle2.putAll(bundle);
        }
        bundle2.putParcelable("picture", bitmap);
        if (!(str2 == null || str2.isEmpty())) {
            bundle2.putString("caption", str2);
        }
        return new GraphRequest(accessToken, defaultPhotoPathIfNull, bundle2, HttpMethod.POST, callback);
    }

    public static GraphRequest newUploadPhotoRequest(AccessToken accessToken, String str, Uri uri, String str2, Bundle bundle, Callback callback) {
        String defaultPhotoPathIfNull = getDefaultPhotoPathIfNull(str);
        if (Utility.isFileUri(uri)) {
            return newUploadPhotoRequest(accessToken, defaultPhotoPathIfNull, new File(uri.getPath()), str2, bundle, callback);
        } else if (Utility.isContentUri(uri)) {
            Bundle bundle2 = new Bundle();
            if (bundle != null) {
                bundle2.putAll(bundle);
            }
            bundle2.putParcelable("picture", uri);
            if (!(str2 == null || str2.isEmpty())) {
                bundle2.putString("caption", str2);
            }
            return new GraphRequest(accessToken, defaultPhotoPathIfNull, bundle2, HttpMethod.POST, callback);
        } else {
            throw new FacebookException("The photo Uri must be either a file:// or content:// Uri");
        }
    }

    public static GraphRequest newUploadPhotoRequest(AccessToken accessToken, String str, File file, String str2, Bundle bundle, Callback callback) {
        String defaultPhotoPathIfNull = getDefaultPhotoPathIfNull(str);
        Parcelable open = ParcelFileDescriptor.open(file, 268435456);
        Bundle bundle2 = new Bundle();
        if (bundle != null) {
            bundle2.putAll(bundle);
        }
        bundle2.putParcelable("picture", open);
        if (!(str2 == null || str2.isEmpty())) {
            bundle2.putString("caption", str2);
        }
        return new GraphRequest(accessToken, defaultPhotoPathIfNull, bundle2, HttpMethod.POST, callback);
    }

    private static String parameterToString(Object obj) {
        if (obj instanceof String) {
            return (String) obj;
        }
        if ((obj instanceof Boolean) || (obj instanceof Number)) {
            return obj.toString();
        }
        if (obj instanceof Date) {
            return new SimpleDateFormat(ISO_8601_FORMAT_STRING, Locale.US).format(obj);
        }
        throw new IllegalArgumentException("Unsupported parameter type.");
    }

    private static void processGraphObject(JSONObject jSONObject, String str, KeyValueSerializer keyValueSerializer) {
        Object obj;
        if (isMeRequest(str)) {
            int indexOf = str.indexOf(":");
            int indexOf2 = str.indexOf("?");
            Object obj2 = (indexOf <= 3 || (indexOf2 != -1 && indexOf >= indexOf2)) ? null : 1;
            obj = obj2;
        } else {
            obj = null;
        }
        Iterator keys = jSONObject.keys();
        while (keys.hasNext()) {
            String str2 = (String) keys.next();
            Object opt = jSONObject.opt(str2);
            boolean z = obj != null && str2.equalsIgnoreCase("image");
            processGraphObjectProperty(str2, opt, keyValueSerializer, z);
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private static void processGraphObjectProperty(java.lang.String r10, java.lang.Object r11, com.facebook.GraphRequest.KeyValueSerializer r12, boolean r13) {
        /*
        r9 = 2;
        r8 = 1;
        r2 = 0;
        r0 = r11;
    L_0x0004:
        r1 = r0.getClass();
        r3 = org.json.JSONObject.class;
        r3 = r3.isAssignableFrom(r1);
        if (r3 == 0) goto L_0x0063;
    L_0x0010:
        r0 = (org.json.JSONObject) r0;
        if (r13 == 0) goto L_0x0038;
    L_0x0014:
        r3 = r0.keys();
    L_0x0018:
        r1 = r3.hasNext();
        if (r1 == 0) goto L_0x00af;
    L_0x001e:
        r1 = r3.next();
        r1 = (java.lang.String) r1;
        r4 = "%s[%s]";
        r5 = new java.lang.Object[r9];
        r5[r2] = r10;
        r5[r8] = r1;
        r4 = java.lang.String.format(r4, r5);
        r1 = r0.opt(r1);
        processGraphObjectProperty(r4, r1, r12, r13);
        goto L_0x0018;
    L_0x0038:
        r1 = "id";
        r1 = r0.has(r1);
        if (r1 == 0) goto L_0x0047;
    L_0x0040:
        r1 = "id";
        r0 = r0.optString(r1);
        goto L_0x0004;
    L_0x0047:
        r1 = "url";
        r1 = r0.has(r1);
        if (r1 == 0) goto L_0x0056;
    L_0x004f:
        r1 = "url";
        r0 = r0.optString(r1);
        goto L_0x0004;
    L_0x0056:
        r1 = "fbsdk:create_object";
        r1 = r0.has(r1);
        if (r1 == 0) goto L_0x00af;
    L_0x005e:
        r0 = r0.toString();
        goto L_0x0004;
    L_0x0063:
        r3 = org.json.JSONArray.class;
        r3 = r3.isAssignableFrom(r1);
        if (r3 == 0) goto L_0x0090;
    L_0x006b:
        r0 = (org.json.JSONArray) r0;
        r3 = r0.length();
        r1 = r2;
    L_0x0072:
        if (r1 >= r3) goto L_0x00af;
    L_0x0074:
        r4 = java.util.Locale.ROOT;
        r5 = "%s[%d]";
        r6 = new java.lang.Object[r9];
        r6[r2] = r10;
        r7 = java.lang.Integer.valueOf(r1);
        r6[r8] = r7;
        r4 = java.lang.String.format(r4, r5, r6);
        r5 = r0.opt(r1);
        processGraphObjectProperty(r4, r5, r12, r13);
        r1 = r1 + 1;
        goto L_0x0072;
    L_0x0090:
        r2 = java.lang.String.class;
        r2 = r2.isAssignableFrom(r1);
        if (r2 != 0) goto L_0x00a8;
    L_0x0098:
        r2 = java.lang.Number.class;
        r2 = r2.isAssignableFrom(r1);
        if (r2 != 0) goto L_0x00a8;
    L_0x00a0:
        r2 = java.lang.Boolean.class;
        r2 = r2.isAssignableFrom(r1);
        if (r2 == 0) goto L_0x00b0;
    L_0x00a8:
        r0 = r0.toString();
        r12.writeString(r10, r0);
    L_0x00af:
        return;
    L_0x00b0:
        r2 = java.util.Date.class;
        r1 = r2.isAssignableFrom(r1);
        if (r1 == 0) goto L_0x00af;
    L_0x00b8:
        r0 = (java.util.Date) r0;
        r1 = new java.text.SimpleDateFormat;
        r2 = "yyyy-MM-dd'T'HH:mm:ssZ";
        r3 = java.util.Locale.US;
        r1.<init>(r2, r3);
        r0 = r1.format(r0);
        r12.writeString(r10, r0);
        goto L_0x00af;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.facebook.GraphRequest.processGraphObjectProperty(java.lang.String, java.lang.Object, com.facebook.GraphRequest$KeyValueSerializer, boolean):void");
    }

    private static void processRequest(GraphRequestBatch graphRequestBatch, Logger logger, int i, URL url, OutputStream outputStream, boolean z) {
        Serializer serializer = new Serializer(outputStream, logger, z);
        String batchAppId;
        if (i == 1) {
            GraphRequest graphRequest = graphRequestBatch.get(0);
            Map hashMap = new HashMap();
            for (String batchAppId2 : graphRequest.parameters.keySet()) {
                Object obj = graphRequest.parameters.get(batchAppId2);
                if (isSupportedAttachmentType(obj)) {
                    hashMap.put(batchAppId2, new Attachment(graphRequest, obj));
                }
            }
            if (logger != null) {
                logger.append("  Parameters:\n");
            }
            serializeParameters(graphRequest.parameters, serializer, graphRequest);
            if (logger != null) {
                logger.append("  Attachments:\n");
            }
            serializeAttachments(hashMap, serializer);
            if (graphRequest.graphObject != null) {
                processGraphObject(graphRequest.graphObject, url.getPath(), serializer);
                return;
            }
            return;
        }
        batchAppId2 = getBatchAppId(graphRequestBatch);
        if (Utility.isNullOrEmpty(batchAppId2)) {
            throw new FacebookException("App ID was not specified at the request or Settings.");
        }
        serializer.writeString(BATCH_APP_ID_PARAM, batchAppId2);
        Map hashMap2 = new HashMap();
        serializeRequestsAsJSON(serializer, graphRequestBatch, hashMap2);
        if (logger != null) {
            logger.append("  Attachments:\n");
        }
        serializeAttachments(hashMap2, serializer);
    }

    static void runCallbacks(GraphRequestBatch graphRequestBatch, List<GraphResponse> list) {
        int size = graphRequestBatch.size();
        ArrayList arrayList = new ArrayList();
        for (int i = 0; i < size; i++) {
            GraphRequest graphRequest = graphRequestBatch.get(i);
            if (graphRequest.callback != null) {
                arrayList.add(new Pair(graphRequest.callback, list.get(i)));
            }
        }
        if (arrayList.size() > 0) {
            Runnable c01885 = new C01885(arrayList, graphRequestBatch);
            Handler callbackHandler = graphRequestBatch.getCallbackHandler();
            if (callbackHandler == null) {
                c01885.run();
            } else {
                callbackHandler.post(c01885);
            }
        }
    }

    private static void serializeAttachments(Map<String, Attachment> map, Serializer serializer) {
        for (String str : map.keySet()) {
            Attachment attachment = (Attachment) map.get(str);
            if (isSupportedAttachmentType(attachment.getValue())) {
                serializer.writeObject(str, attachment.getValue(), attachment.getRequest());
            }
        }
    }

    private static void serializeParameters(Bundle bundle, Serializer serializer, GraphRequest graphRequest) {
        for (String str : bundle.keySet()) {
            Object obj = bundle.get(str);
            if (isSupportedParameterType(obj)) {
                serializer.writeObject(str, obj, graphRequest);
            }
        }
    }

    private static void serializeRequestsAsJSON(Serializer serializer, Collection<GraphRequest> collection, Map<String, Attachment> map) {
        JSONArray jSONArray = new JSONArray();
        for (GraphRequest serializeToBatch : collection) {
            serializeToBatch.serializeToBatch(jSONArray, map);
        }
        serializer.writeRequestsAsJson(BATCH_PARAM, jSONArray, collection);
    }

    private void serializeToBatch(JSONArray jSONArray, Map<String, Attachment> map) {
        JSONObject jSONObject = new JSONObject();
        if (this.batchEntryName != null) {
            jSONObject.put("name", this.batchEntryName);
            jSONObject.put(BATCH_ENTRY_OMIT_RESPONSE_ON_SUCCESS_PARAM, this.batchEntryOmitResultOnSuccess);
        }
        if (this.batchEntryDependsOn != null) {
            jSONObject.put(BATCH_ENTRY_DEPENDS_ON_PARAM, this.batchEntryDependsOn);
        }
        String relativeUrlForBatchedRequest = getRelativeUrlForBatchedRequest();
        jSONObject.put(BATCH_RELATIVE_URL_PARAM, relativeUrlForBatchedRequest);
        jSONObject.put(BATCH_METHOD_PARAM, this.httpMethod);
        if (this.accessToken != null) {
            Logger.registerAccessToken(this.accessToken.getToken());
        }
        Iterable arrayList = new ArrayList();
        for (String str : this.parameters.keySet()) {
            Object obj = this.parameters.get(str);
            if (isSupportedAttachmentType(obj)) {
                String format = String.format(Locale.ROOT, "%s%d", new Object[]{ATTACHMENT_FILENAME_PREFIX, Integer.valueOf(map.size())});
                arrayList.add(format);
                map.put(format, new Attachment(this, obj));
            }
        }
        if (!arrayList.isEmpty()) {
            jSONObject.put(ATTACHED_FILES_PARAM, TextUtils.join(",", arrayList));
        }
        if (this.graphObject != null) {
            final Iterable arrayList2 = new ArrayList();
            processGraphObject(this.graphObject, relativeUrlForBatchedRequest, new KeyValueSerializer() {
                public void writeString(String str, String str2) {
                    arrayList2.add(String.format(Locale.US, "%s=%s", new Object[]{str, URLEncoder.encode(str2, "UTF-8")}));
                }
            });
            jSONObject.put(BATCH_BODY_PARAM, TextUtils.join("&", arrayList2));
        }
        jSONArray.put(jSONObject);
    }

    static final void serializeToUrlConnection(GraphRequestBatch graphRequestBatch, HttpURLConnection httpURLConnection) {
        OutputStream bufferedOutputStream;
        Throwable th;
        Logger logger = new Logger(LoggingBehavior.REQUESTS, "Request");
        int size = graphRequestBatch.size();
        boolean isGzipCompressible = isGzipCompressible(graphRequestBatch);
        HttpMethod httpMethod = size == 1 ? graphRequestBatch.get(0).httpMethod : HttpMethod.POST;
        httpURLConnection.setRequestMethod(httpMethod.name());
        setConnectionContentType(httpURLConnection, isGzipCompressible);
        URL url = httpURLConnection.getURL();
        logger.append("Request:\n");
        logger.appendKeyValue("Id", graphRequestBatch.getId());
        logger.appendKeyValue("URL", url);
        logger.appendKeyValue("Method", httpURLConnection.getRequestMethod());
        logger.appendKeyValue(USER_AGENT_HEADER, httpURLConnection.getRequestProperty(USER_AGENT_HEADER));
        logger.appendKeyValue(CONTENT_TYPE_HEADER, httpURLConnection.getRequestProperty(CONTENT_TYPE_HEADER));
        httpURLConnection.setConnectTimeout(graphRequestBatch.getTimeout());
        httpURLConnection.setReadTimeout(graphRequestBatch.getTimeout());
        if (httpMethod == HttpMethod.POST) {
            httpURLConnection.setDoOutput(true);
            try {
                OutputStream progressNoopOutputStream;
                bufferedOutputStream = new BufferedOutputStream(httpURLConnection.getOutputStream());
                if (isGzipCompressible) {
                    try {
                        bufferedOutputStream = new GZIPOutputStream(bufferedOutputStream);
                    } catch (Throwable th2) {
                        th = th2;
                        if (bufferedOutputStream != null) {
                            bufferedOutputStream.close();
                        }
                        throw th;
                    }
                }
                if (hasOnProgressCallbacks(graphRequestBatch)) {
                    progressNoopOutputStream = new ProgressNoopOutputStream(graphRequestBatch.getCallbackHandler());
                    processRequest(graphRequestBatch, null, size, url, progressNoopOutputStream, isGzipCompressible);
                    progressNoopOutputStream = new ProgressOutputStream(bufferedOutputStream, graphRequestBatch, progressNoopOutputStream.getProgressMap(), (long) progressNoopOutputStream.getMaxProgress());
                } else {
                    progressNoopOutputStream = bufferedOutputStream;
                }
                try {
                    processRequest(graphRequestBatch, logger, size, url, progressNoopOutputStream, isGzipCompressible);
                    progressNoopOutputStream.close();
                    logger.log();
                    return;
                } catch (Throwable th3) {
                    th = th3;
                    bufferedOutputStream = progressNoopOutputStream;
                    if (bufferedOutputStream != null) {
                        bufferedOutputStream.close();
                    }
                    throw th;
                }
            } catch (Throwable th4) {
                th = th4;
                bufferedOutputStream = null;
                if (bufferedOutputStream != null) {
                    bufferedOutputStream.close();
                }
                throw th;
            }
        }
        logger.log();
    }

    private static void setConnectionContentType(HttpURLConnection httpURLConnection, boolean z) {
        if (z) {
            httpURLConnection.setRequestProperty(CONTENT_TYPE_HEADER, "application/x-www-form-urlencoded");
            httpURLConnection.setRequestProperty(CONTENT_ENCODING_HEADER, "gzip");
            return;
        }
        httpURLConnection.setRequestProperty(CONTENT_TYPE_HEADER, getMimeContentType());
    }

    public static final void setDefaultBatchApplicationId(String str) {
        defaultBatchApplicationId = str;
    }

    static final boolean shouldWarnOnMissingFieldsParam(GraphRequest graphRequest) {
        String version = graphRequest.getVersion();
        if (Utility.isNullOrEmpty(version)) {
            return true;
        }
        if (version.startsWith("v")) {
            version = version.substring(1);
        }
        String[] split = version.split("\\.");
        return (split.length >= 2 && Integer.parseInt(split[0]) > 2) || (Integer.parseInt(split[0]) >= 2 && Integer.parseInt(split[1]) >= 4);
    }

    public static HttpURLConnection toHttpConnection(GraphRequestBatch graphRequestBatch) {
        Throwable e;
        validateFieldsParamForGetRequests(graphRequestBatch);
        try {
            URLConnection uRLConnection = null;
            try {
                uRLConnection = createConnection(graphRequestBatch.size() == 1 ? new URL(graphRequestBatch.get(0).getUrlForSingleRequest()) : new URL(ServerProtocol.getGraphUrlBase()));
                serializeToUrlConnection(graphRequestBatch, uRLConnection);
                return uRLConnection;
            } catch (IOException e2) {
                e = e2;
                Utility.disconnectQuietly(uRLConnection);
                throw new FacebookException("could not construct request body", e);
            } catch (JSONException e3) {
                e = e3;
                Utility.disconnectQuietly(uRLConnection);
                throw new FacebookException("could not construct request body", e);
            }
        } catch (Throwable e4) {
            throw new FacebookException("could not construct URL for request", e4);
        }
    }

    public static HttpURLConnection toHttpConnection(Collection<GraphRequest> collection) {
        Validate.notEmptyAndContainsNoNulls(collection, "requests");
        return toHttpConnection(new GraphRequestBatch((Collection) collection));
    }

    public static HttpURLConnection toHttpConnection(GraphRequest... graphRequestArr) {
        return toHttpConnection(Arrays.asList(graphRequestArr));
    }

    static final void validateFieldsParamForGetRequests(GraphRequestBatch graphRequestBatch) {
        Iterator it = graphRequestBatch.iterator();
        while (it.hasNext()) {
            GraphRequest graphRequest = (GraphRequest) it.next();
            if (HttpMethod.GET.equals(graphRequest.getHttpMethod()) && shouldWarnOnMissingFieldsParam(graphRequest)) {
                Bundle parameters = graphRequest.getParameters();
                if (!parameters.containsKey(FIELDS_PARAM) || Utility.isNullOrEmpty(parameters.getString(FIELDS_PARAM))) {
                    Logger.log(LoggingBehavior.DEVELOPER_ERRORS, 5, "Request", "starting with Graph API v2.4, GET requests for /%s should contain an explicit \"fields\" parameter.", graphRequest.getGraphPath());
                }
            }
        }
    }

    public final GraphResponse executeAndWait() {
        return executeAndWait(this);
    }

    public final GraphRequestAsyncTask executeAsync() {
        return executeBatchAsync(this);
    }

    public final AccessToken getAccessToken() {
        return this.accessToken;
    }

    public final String getBatchEntryDependsOn() {
        return this.batchEntryDependsOn;
    }

    public final String getBatchEntryName() {
        return this.batchEntryName;
    }

    public final boolean getBatchEntryOmitResultOnSuccess() {
        return this.batchEntryOmitResultOnSuccess;
    }

    public final Callback getCallback() {
        return this.callback;
    }

    public final JSONObject getGraphObject() {
        return this.graphObject;
    }

    public final String getGraphPath() {
        return this.graphPath;
    }

    public final HttpMethod getHttpMethod() {
        return this.httpMethod;
    }

    public final Bundle getParameters() {
        return this.parameters;
    }

    final String getRelativeUrlForBatchedRequest() {
        if (this.overriddenURL != null) {
            throw new FacebookException("Can't override URL for a batch request");
        }
        String format = String.format(GRAPH_PATH_FORMAT, new Object[]{ServerProtocol.getGraphUrlBase(), getGraphPathWithVersion()});
        addCommonParameters();
        Uri parse = Uri.parse(appendParametersToBaseUrl(format));
        return String.format("%s?%s", new Object[]{parse.getPath(), parse.getQuery()});
    }

    public final Object getTag() {
        return this.tag;
    }

    final String getUrlForSingleRequest() {
        if (this.overriddenURL != null) {
            return this.overriddenURL.toString();
        }
        String graphVideoUrlBase = (getHttpMethod() == HttpMethod.POST && this.graphPath != null && this.graphPath.endsWith(VIDEOS_SUFFIX)) ? ServerProtocol.getGraphVideoUrlBase() : ServerProtocol.getGraphUrlBase();
        graphVideoUrlBase = String.format(GRAPH_PATH_FORMAT, new Object[]{graphVideoUrlBase, getGraphPathWithVersion()});
        addCommonParameters();
        return appendParametersToBaseUrl(graphVideoUrlBase);
    }

    public final String getVersion() {
        return this.version;
    }

    public final void setAccessToken(AccessToken accessToken) {
        this.accessToken = accessToken;
    }

    public final void setBatchEntryDependsOn(String str) {
        this.batchEntryDependsOn = str;
    }

    public final void setBatchEntryName(String str) {
        this.batchEntryName = str;
    }

    public final void setBatchEntryOmitResultOnSuccess(boolean z) {
        this.batchEntryOmitResultOnSuccess = z;
    }

    public final void setCallback(final Callback callback) {
        if (FacebookSdk.isLoggingBehaviorEnabled(LoggingBehavior.GRAPH_API_DEBUG_INFO) || FacebookSdk.isLoggingBehaviorEnabled(LoggingBehavior.GRAPH_API_DEBUG_WARNING)) {
            this.callback = new Callback() {
                public void onCompleted(GraphResponse graphResponse) {
                    JSONObject jSONObject = graphResponse.getJSONObject();
                    jSONObject = jSONObject != null ? jSONObject.optJSONObject(GraphRequest.DEBUG_KEY) : null;
                    JSONArray optJSONArray = jSONObject != null ? jSONObject.optJSONArray(GraphRequest.DEBUG_MESSAGES_KEY) : null;
                    if (optJSONArray != null) {
                        for (int i = 0; i < optJSONArray.length(); i++) {
                            JSONObject optJSONObject = optJSONArray.optJSONObject(i);
                            String optString = optJSONObject != null ? optJSONObject.optString("message") : null;
                            String optString2 = optJSONObject != null ? optJSONObject.optString("type") : null;
                            String optString3 = optJSONObject != null ? optJSONObject.optString("link") : null;
                            if (!(optString == null || optString2 == null)) {
                                LoggingBehavior loggingBehavior = LoggingBehavior.GRAPH_API_DEBUG_INFO;
                                if (optString2.equals(GraphRequest.DEBUG_SEVERITY_WARNING)) {
                                    loggingBehavior = LoggingBehavior.GRAPH_API_DEBUG_WARNING;
                                }
                                if (!Utility.isNullOrEmpty(optString3)) {
                                    optString = optString + " Link: " + optString3;
                                }
                                Logger.log(loggingBehavior, GraphRequest.TAG, optString);
                            }
                        }
                    }
                    if (callback != null) {
                        callback.onCompleted(graphResponse);
                    }
                }
            };
        } else {
            this.callback = callback;
        }
    }

    public final void setGraphObject(JSONObject jSONObject) {
        this.graphObject = jSONObject;
    }

    public final void setGraphPath(String str) {
        this.graphPath = str;
    }

    public final void setHttpMethod(HttpMethod httpMethod) {
        if (this.overriddenURL == null || httpMethod == HttpMethod.GET) {
            if (httpMethod == null) {
                httpMethod = HttpMethod.GET;
            }
            this.httpMethod = httpMethod;
            return;
        }
        throw new FacebookException("Can't change HTTP method on request with overridden URL.");
    }

    public final void setParameters(Bundle bundle) {
        this.parameters = bundle;
    }

    public final void setSkipClientToken(boolean z) {
        this.skipClientToken = z;
    }

    public final void setTag(Object obj) {
        this.tag = obj;
    }

    public final void setVersion(String str) {
        this.version = str;
    }

    public final String toString() {
        return "{Request:  accessToken: " + (this.accessToken == null ? "null" : this.accessToken) + ", graphPath: " + this.graphPath + ", graphObject: " + this.graphObject + ", httpMethod: " + this.httpMethod + ", parameters: " + this.parameters + "}";
    }
}
