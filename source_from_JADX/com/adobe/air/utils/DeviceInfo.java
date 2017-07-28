package com.adobe.air.utils;

import java.io.IOException;
import java.io.InputStream;

public class DeviceInfo {
    static String getHardwareInfo() {
        try {
            ProcessBuilder processBuilder = new ProcessBuilder(new String[]{"/system/bin/cat", "/proc/cpuinfo"});
            byte[] bArr = new byte[1024];
            InputStream inputStream = processBuilder.start().getInputStream();
            int read = inputStream.read(bArr, 0, 1024);
            if (read >= 0) {
                String str = new String(bArr, 0, read);
                int indexOf = str.indexOf("Hardware");
                if (indexOf >= 0) {
                    indexOf = str.indexOf(58, indexOf);
                    if (indexOf >= 0) {
                        return str.substring(indexOf + 1, str.indexOf(10, indexOf + 1)).trim();
                    }
                }
            }
            inputStream.close();
        } catch (IOException e) {
        }
        return new String("");
    }

    static String getTotalMemory() {
        try {
            ProcessBuilder processBuilder = new ProcessBuilder(new String[]{"/system/bin/cat", "/proc/meminfo"});
            byte[] bArr = new byte[1024];
            InputStream inputStream = processBuilder.start().getInputStream();
            int read = inputStream.read(bArr, 0, 1024);
            if (read >= 0) {
                String str = new String(bArr, 0, read);
                int indexOf = str.indexOf("MemTotal");
                if (indexOf >= 0) {
                    indexOf = str.indexOf(58, indexOf);
                    if (indexOf >= 0) {
                        return str.substring(indexOf + 1, str.indexOf(10, indexOf + 1)).trim();
                    }
                }
            }
            inputStream.close();
        } catch (IOException e) {
        }
        return new String("");
    }

    static String getCPUCount() {
        try {
            ProcessBuilder processBuilder = new ProcessBuilder(new String[]{"/system/bin/cat", "/sys/devices/system/cpu/present"});
            byte[] bArr = new byte[1024];
            InputStream inputStream = processBuilder.start().getInputStream();
            int read = inputStream.read(bArr, 0, 1024);
            if (read >= 0) {
                String str = new String(bArr, 0, read);
                int indexOf = str.indexOf("-");
                if (indexOf >= 0) {
                    return Integer.toString(Integer.parseInt(str.substring(indexOf + 1, indexOf + 2)) + 1);
                }
                return Integer.toString(Integer.parseInt(str.substring(0, 1)) + 1);
            }
            inputStream.close();
            return new String("");
        } catch (IOException e) {
        }
    }
}
