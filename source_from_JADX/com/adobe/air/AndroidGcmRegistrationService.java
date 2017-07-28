package com.adobe.air;

import android.app.IntentService;
import android.content.ComponentName;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.SharedPreferences.Editor;
import android.content.pm.PackageManager.NameNotFoundException;
import android.location.Address;
import android.location.Geocoder;
import android.location.Location;
import android.location.LocationManager;
import android.os.AsyncTask;
import android.os.Build;
import android.os.Build.VERSION;
import android.os.Bundle;
import android.os.ResultReceiver;
import android.preference.PreferenceManager;
import android.util.Log;
import com.amazonaws.AmazonClientException;
import com.amazonaws.AmazonServiceException;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.regions.Region;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.sns.AmazonSNS;
import com.amazonaws.services.sns.AmazonSNSClient;
import com.amazonaws.services.sns.model.CreatePlatformEndpointRequest;
import com.amazonaws.services.sns.model.CreatePlatformEndpointResult;
import com.amazonaws.services.sns.model.InternalErrorException;
import com.amazonaws.services.sns.model.InvalidParameterException;
import com.amazonaws.services.sns.model.SetEndpointAttributesRequest;
import com.facebook.internal.ServerProtocol;
import com.google.android.gms.common.GooglePlayServicesUtil;
import com.google.android.gms.gcm.GoogleCloudMessaging;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import org.json.JSONObject;

public class AndroidGcmRegistrationService extends IntentService {
    private static String ACCESS_KEY = "";
    private static String APPLICATION_ARN = "arn:aws:sns:us-west-2:502492504188:app/GCM/AdobeAIRGCM";
    private static final String CUSTOM_USER_DATA = "CustomUserData";
    private static final String ENABLED = "Enabled";
    private static final String ENABLE_LOGGING = "enableLogging";
    private static final int MAX_RETRIES = 10;
    private static final String PROPERTY_APP_VERSION = "appVersion";
    private static final String PROPERTY_ENDPOINT_ARN = "endpointArn";
    private static final String RATE_LIMIT = "rateLimit";
    private static final int RETRY_TIME = 300000;
    private static String SECRET_KEY = "";
    private static String SENDER_ID = "233437466354";
    private static final String TAG = "AndroidGcmRegistrationService";
    private static final String TEST_ACCESS_KEY = "";
    private static final String TEST_APPLICATION_ARN = "arn:aws:sns:us-west-2:413177889857:app/GCM/airruntimetestapp";
    private static final String TEST_ENV = "testEnv";
    private static final String TEST_SECRET_KEY = "";
    private static final String TEST_SENDER_ID = "1078258869814";
    private static final String TOKEN = "Token";
    private AmazonSNS mClient = null;
    private boolean mEnableLogging = false;
    private String mEndpointArn = null;
    private GoogleCloudMessaging mGcm = null;
    private String mRegId = null;
    private ResultReceiver mResultReceiver = null;
    private int mRetryCount = 0;
    private boolean mTestEnv = false;

    private class AsyncTaskRunner extends AsyncTask<Integer, Void, Void> {
        private AsyncTaskRunner() {
        }

        protected Void doInBackground(Integer... numArr) {
            try {
                Thread.sleep((long) numArr[0].intValue());
                AndroidGcmRegistrationService.this.mRegId = AndroidGcmRegistrationService.this.mGcm.register(new String[]{AndroidGcmRegistrationService.SENDER_ID});
                if (AndroidGcmRegistrationService.this.mRegId == null) {
                    AndroidGcmRegistrationService.this.registerInBackground(AndroidGcmRegistrationService.RETRY_TIME);
                } else {
                    AndroidGcmRegistrationService.this.sendRegistrationIdToAws();
                }
            } catch (Exception e) {
                AndroidGcmRegistrationService.this.registerInBackground(AndroidGcmRegistrationService.RETRY_TIME);
            }
            return null;
        }
    }

    public AndroidGcmRegistrationService() {
        super(TAG);
    }

    protected void onHandleIntent(Intent intent) {
        this.mResultReceiver = (ResultReceiver) intent.getParcelableExtra(AdobeAIRMainActivity.RESULT_RECEIVER);
        registerForNotifications();
    }

    private void registerForNotifications() {
        if (!isAppRegistered() && checkPlayServices()) {
            configureTestEnv();
            registerInBackground(0);
        }
    }

    private boolean checkPlayServices() {
        int isGooglePlayServicesAvailable = GooglePlayServicesUtil.isGooglePlayServicesAvailable(this);
        if (isGooglePlayServicesAvailable == 0) {
            return true;
        }
        if (GooglePlayServicesUtil.isUserRecoverableError(isGooglePlayServicesAvailable) && this.mResultReceiver != null) {
            this.mResultReceiver.send(isGooglePlayServicesAvailable, null);
        }
        return false;
    }

    private boolean isAppRegistered() {
        int i = PreferenceManager.getDefaultSharedPreferences(getApplicationContext()).getInt(PROPERTY_APP_VERSION, Integer.MIN_VALUE);
        int appVersion = getAppVersion();
        if (i == Integer.MIN_VALUE || i != appVersion) {
            return false;
        }
        return true;
    }

    private void configureTestEnv() {
        try {
            Bundle bundle = getPackageManager().getServiceInfo(new ComponentName(this, getClass()), 128).metaData;
            if (bundle != null) {
                this.mEnableLogging = bundle.getBoolean(ENABLE_LOGGING);
                this.mTestEnv = bundle.getBoolean(TEST_ENV);
                if (this.mTestEnv) {
                    SENDER_ID = TEST_SENDER_ID;
                    APPLICATION_ARN = TEST_APPLICATION_ARN;
                    ACCESS_KEY = "";
                    SECRET_KEY = "";
                    int i = bundle.getInt(RATE_LIMIT, Integer.MIN_VALUE);
                    if (i != Integer.MIN_VALUE) {
                        AdobeAIRMainActivity.RATE_LIMIT = (long) i;
                    }
                }
            }
        } catch (NameNotFoundException e) {
        }
    }

    private void registerInBackground(int i) {
        if (this.mRetryCount < 10) {
            if (i != 0) {
                this.mRetryCount++;
            }
            if (this.mGcm == null) {
                this.mGcm = GoogleCloudMessaging.getInstance(this);
            }
            new AsyncTaskRunner().execute(new Integer[]{Integer.valueOf(i)});
        }
    }

    private int getAppVersion() {
        int i = 0;
        try {
            return getPackageManager().getPackageInfo(getPackageName(), 0).versionCode;
        } catch (NameNotFoundException e) {
            return i;
        }
    }

    private void sendRegistrationIdToAws() {
        try {
            BasicAWSCredentials basicAWSCredentials = new BasicAWSCredentials(ACCESS_KEY, SECRET_KEY);
            Region region = Region.getRegion(Regions.US_WEST_2);
            this.mClient = new AmazonSNSClient(basicAWSCredentials);
            this.mClient.setRegion(region);
            try {
                CreatePlatformEndpointRequest createPlatformEndpointRequest = new CreatePlatformEndpointRequest();
                createPlatformEndpointRequest.setPlatformApplicationArn(APPLICATION_ARN);
                createPlatformEndpointRequest.setToken(this.mRegId);
                createPlatformEndpointRequest.setCustomUserData(getCustomData());
                CreatePlatformEndpointResult createPlatformEndpoint = this.mClient.createPlatformEndpoint(createPlatformEndpointRequest);
                if (createPlatformEndpoint != null && createPlatformEndpoint.getEndpointArn() != null) {
                    this.mEndpointArn = createPlatformEndpoint.getEndpointArn();
                    if (this.mEnableLogging) {
                        Log.i(TAG, "Creation EndpointArn = " + this.mEndpointArn);
                    }
                    updateSharedPref();
                }
            } catch (InternalErrorException e) {
                registerInBackground(RETRY_TIME);
            } catch (InvalidParameterException e2) {
                updateEndpointAttributes();
            } catch (AmazonServiceException e3) {
            } catch (AmazonClientException e4) {
            }
        } catch (Exception e5) {
        }
    }

    private void updateEndpointAttributes() {
        try {
            SetEndpointAttributesRequest setEndpointAttributesRequest = new SetEndpointAttributesRequest();
            if (this.mEndpointArn == null) {
                this.mEndpointArn = PreferenceManager.getDefaultSharedPreferences(getApplicationContext()).getString(PROPERTY_ENDPOINT_ARN, "");
                if (this.mEnableLogging) {
                    Log.i(TAG, "Update EndpointArn = " + this.mEndpointArn);
                }
            }
            setEndpointAttributesRequest.setEndpointArn(this.mEndpointArn);
            Map hashMap = new HashMap();
            hashMap.put(CUSTOM_USER_DATA, getCustomData());
            hashMap.put(ENABLED, ServerProtocol.DIALOG_RETURN_SCOPES_TRUE);
            hashMap.put(TOKEN, this.mRegId);
            setEndpointAttributesRequest.setAttributes(hashMap);
            this.mClient.setEndpointAttributes(setEndpointAttributesRequest);
            updateSharedPref();
        } catch (AmazonServiceException e) {
        } catch (AmazonClientException e2) {
        }
    }

    private String getCustomData() {
        try {
            Object countryName;
            JSONObject jSONObject = new JSONObject();
            jSONObject.put("osVersion", VERSION.RELEASE);
            jSONObject.put("airVersion", getPackageManager().getPackageInfo(getPackageName(), 0).versionName);
            jSONObject.put("deviceInfo", Build.MODEL + "&" + Build.MANUFACTURER + "&" + Integer.toString(SystemCapabilities.GetScreenHRes(this)) + "&" + Integer.toString(SystemCapabilities.GetScreenVRes(this)) + "&" + Integer.toString(SystemCapabilities.GetScreenDPI(this)));
            Locale locale = Locale.getDefault();
            jSONObject.put("locale", locale.toString());
            String displayCountry = locale.getDisplayCountry(Locale.ENGLISH);
            String str;
            try {
                LocationManager locationManager = (LocationManager) getSystemService("location");
                if (locationManager.isProviderEnabled("network")) {
                    Location lastKnownLocation = locationManager.getLastKnownLocation("network");
                    Geocoder geocoder = new Geocoder(this, Locale.ENGLISH);
                    if (!(lastKnownLocation == null || geocoder == null || !Geocoder.isPresent())) {
                        countryName = ((Address) geocoder.getFromLocation(lastKnownLocation.getLatitude(), lastKnownLocation.getLongitude(), 1).get(0)).getCountryName();
                        jSONObject.put("geo", countryName);
                        jSONObject.put("timestamp", String.valueOf(System.currentTimeMillis()));
                        if (PreferenceManager.getDefaultSharedPreferences(getApplicationContext()).getBoolean(AdobeAIRMainActivity.PROPERTY_DEFAULT_ACTIVITY, true)) {
                            jSONObject.put(AdobeAIRMainActivity.PROPERTY_DEFAULT_ACTIVITY, "PP");
                        } else {
                            jSONObject.put(AdobeAIRMainActivity.PROPERTY_DEFAULT_ACTIVITY, "GL");
                        }
                        return jSONObject.toString();
                    }
                }
                str = displayCountry;
            } catch (Exception e) {
                str = displayCountry;
            }
            jSONObject.put("geo", countryName);
            jSONObject.put("timestamp", String.valueOf(System.currentTimeMillis()));
            if (PreferenceManager.getDefaultSharedPreferences(getApplicationContext()).getBoolean(AdobeAIRMainActivity.PROPERTY_DEFAULT_ACTIVITY, true)) {
                jSONObject.put(AdobeAIRMainActivity.PROPERTY_DEFAULT_ACTIVITY, "PP");
            } else {
                jSONObject.put(AdobeAIRMainActivity.PROPERTY_DEFAULT_ACTIVITY, "GL");
            }
            return jSONObject.toString();
        } catch (Exception e2) {
            return "";
        }
    }

    private void updateSharedPref() {
        SharedPreferences defaultSharedPreferences = PreferenceManager.getDefaultSharedPreferences(getApplicationContext());
        int appVersion = getAppVersion();
        Editor edit = defaultSharedPreferences.edit();
        edit.putInt(PROPERTY_APP_VERSION, appVersion);
        edit.putString(PROPERTY_ENDPOINT_ARN, this.mEndpointArn);
        edit.commit();
    }
}
