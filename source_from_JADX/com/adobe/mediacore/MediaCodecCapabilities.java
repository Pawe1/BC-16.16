package com.adobe.mediacore;

import android.media.MediaCodecInfo;
import android.media.MediaCodecInfo.CodecCapabilities;
import android.media.MediaCodecList;
import android.os.Build.VERSION;
import android.util.Log;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class MediaCodecCapabilities {
    private static final String TAG = "MediaCodecCapabilities(j)";
    private static Map<String, CodecCapabilities> capabilitiesMap = new HashMap();
    private static ArrayList<MediaCodecInfo> codecInfoList = new ArrayList();

    public static void PreloadCodecInfoList(String str) {
        if (VERSION.SDK_INT >= 19) {
            Log.w(TAG, "PreloadCodecInfoList for mime" + str);
            if (codecInfoList.isEmpty()) {
                getCodecInfos(str);
            }
            if (codecInfoList.isEmpty()) {
                Log.w(TAG, "no codeInfo for mime " + str);
                return;
            }
            for (int i = 0; i < codecInfoList.size(); i++) {
                MediaCodecInfo mediaCodecInfo = (MediaCodecInfo) codecInfoList.get(i);
                try {
                    capabilitiesMap.put(mediaCodecInfo.getName(), mediaCodecInfo.getCapabilitiesForType(str));
                } catch (Exception e) {
                    Log.w(TAG, "caught exception");
                }
            }
        }
    }

    public static boolean IsProfileLevelSupported(String str, int i, int i2) {
        boolean z = false;
        if (codecInfoList.isEmpty()) {
            getCodecInfos(str);
        }
        if (codecInfoList.isEmpty()) {
            Log.w(TAG, "no codeInfo for mime " + str);
        } else {
            boolean z2;
            if (capabilitiesMap.keySet().isEmpty()) {
                z2 = false;
                for (int i3 = 0; i3 < codecInfoList.size(); i3++) {
                    MediaCodecInfo mediaCodecInfo = (MediaCodecInfo) codecInfoList.get(i3);
                    CodecCapabilities codecCapabilities = null;
                    try {
                        codecCapabilities = mediaCodecInfo.getCapabilitiesForType(new String("video/avc"));
                    } catch (Exception e) {
                        Log.w(TAG, "caught exception");
                    }
                    if (codecCapabilities != null && isProfileLevelSupportedByCapacities(codecCapabilities, i, i2, mediaCodecInfo.getName())) {
                        z2 = true;
                    }
                }
                z = z2;
            } else {
                z2 = false;
                for (String str2 : capabilitiesMap.keySet()) {
                    CodecCapabilities codecCapabilities2 = (CodecCapabilities) capabilitiesMap.get(str2);
                    if (codecCapabilities2 != null) {
                        if (isProfileLevelSupportedByCapacities(codecCapabilities2, i, i2, str2)) {
                            z = true;
                        } else {
                            z = z2;
                        }
                        z2 = z;
                    }
                }
                z = z2;
            }
            if (!z) {
                Log.w(TAG, "profile " + i + " and level " + i2 + "not supported");
            }
        }
        return z;
    }

    public static boolean IsABRSupportedByMediaCodec(String str) {
        if (VERSION.SDK_INT < 19) {
            return false;
        }
        int codecCount;
        if (codecInfoList.isEmpty() || capabilitiesMap.keySet().isEmpty() || !str.equalsIgnoreCase("video/avc")) {
            codecCount = MediaCodecList.getCodecCount();
            for (int i = 0; i < codecCount; i++) {
                MediaCodecInfo codecInfoAt = MediaCodecList.getCodecInfoAt(i);
                if (!codecInfoAt.isEncoder()) {
                    String[] supportedTypes = codecInfoAt.getSupportedTypes();
                    for (int i2 = 0; i2 < supportedTypes.length; i2++) {
                        if (supportedTypes[i2].equalsIgnoreCase(str)) {
                            boolean isFeatureSupported = codecInfoAt.getCapabilitiesForType(supportedTypes[i2]).isFeatureSupported("adaptive-playback");
                            Log.w(TAG, "IsCodecSupported (video/avc) : info = " + codecInfoAt.getName() + "AdaptivePlayback supported = " + isFeatureSupported);
                            if (isFeatureSupported) {
                                return true;
                            }
                        }
                    }
                    continue;
                }
            }
            return false;
        }
        for (codecCount = 0; codecCount < codecInfoList.size(); codecCount++) {
            MediaCodecInfo mediaCodecInfo = (MediaCodecInfo) codecInfoList.get(codecCount);
            CodecCapabilities codecCapabilities = (CodecCapabilities) capabilitiesMap.get(mediaCodecInfo.getName());
            if (codecCapabilities != null) {
                boolean isFeatureSupported2 = codecCapabilities.isFeatureSupported("adaptive-playback");
                Log.w(TAG, "IsCodecSupported (video/avc) : info = " + mediaCodecInfo.getName() + "AdaptivePlayback supported = " + isFeatureSupported2);
                if (isFeatureSupported2) {
                    return true;
                }
            }
        }
        return false;
    }

    public static void PrintCodecList() {
        int codecCount = MediaCodecList.getCodecCount();
        Log.w(TAG, "PrintCodecList ---------");
        for (int i = 0; i < codecCount; i++) {
            MediaCodecInfo codecInfoAt = MediaCodecList.getCodecInfoAt(i);
            if (!codecInfoAt.isEncoder()) {
                Log.w(TAG, "    Name = [" + codecInfoAt.getName() + "]");
                String[] supportedTypes = codecInfoAt.getSupportedTypes();
                for (int i2 = 0; i2 < supportedTypes.length; i2++) {
                    Log.w(TAG, "        SupportedType[" + i2 + "] = [" + supportedTypes[i2] + "]");
                }
            }
        }
        Log.w(TAG, "-------------------------------");
    }

    public static boolean IsCodecSupported(String str) {
        int codecCount = MediaCodecList.getCodecCount();
        for (int i = 0; i < codecCount; i++) {
            MediaCodecInfo codecInfoAt = MediaCodecList.getCodecInfoAt(i);
            if (!codecInfoAt.isEncoder()) {
                String[] supportedTypes = codecInfoAt.getSupportedTypes();
                for (String equalsIgnoreCase : supportedTypes) {
                    if (equalsIgnoreCase.equalsIgnoreCase(str)) {
                        Log.w(TAG, "IsCodecSupported (" + str + ") : info = " + codecInfoAt.getName() + " : yes, it's supported");
                        return true;
                    }
                }
                continue;
            }
        }
        Log.w(TAG, "IsCodecSupported (" + str + ") : no, it's not supported");
        return false;
    }

    private static void getCodecInfos(String str) {
        int codecCount = MediaCodecList.getCodecCount();
        for (int i = 0; i < codecCount; i++) {
            MediaCodecInfo codecInfoAt = MediaCodecList.getCodecInfoAt(i);
            if (!codecInfoAt.isEncoder()) {
                String[] supportedTypes = codecInfoAt.getSupportedTypes();
                for (String equalsIgnoreCase : supportedTypes) {
                    if (equalsIgnoreCase.equalsIgnoreCase(str)) {
                        codecInfoList.add(codecInfoAt);
                        Log.w(TAG, "info = " + codecInfoAt.getName());
                    }
                }
            }
        }
    }

    private static boolean isProfileLevelSupportedByCapacities(CodecCapabilities codecCapabilities, int i, int i2, String str) {
        int i3 = 0;
        StringBuilder stringBuilder = new StringBuilder();
        boolean z = false;
        while (i3 < codecCapabilities.profileLevels.length) {
            if (i3 > 0) {
                stringBuilder.append(", ");
            }
            stringBuilder.append(codecCapabilities.profileLevels[i3].profile + " / " + codecCapabilities.profileLevels[i3].level);
            if (codecCapabilities.profileLevels[i3].profile >= i && codecCapabilities.profileLevels[i3].level >= i2) {
                Log.w(TAG, "IsProfileLevelSupported suppported: caps.profileLevels[k].profile: " + codecCapabilities.profileLevels[i3].profile + " >= profile: " + i + " and caps.profileLevels[k].level: " + codecCapabilities.profileLevels[i3].level + " >= level: " + i2);
                z = true;
            }
            i3++;
        }
        Log.d(TAG, "codecName " + str + "    profiles/levels: " + stringBuilder);
        return z;
    }
}
