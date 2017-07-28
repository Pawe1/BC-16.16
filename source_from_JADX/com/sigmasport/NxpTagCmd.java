package com.sigmasport;

public class NxpTagCmd extends RecordsBase {
    public static final int METHOD_CLOSE = 20;
    public static final int METHOD_CONNECT = 10;
    public static final int METHOD_FAST_READ = 31;
    public static final int METHOD_ISCONNECTED = 11;
    public static final int METHOD_READ_SRAM = 41;
    public static final int METHOD_UNKNOWN = 0;
    public static final int METHOD_WRITE = 30;
    public static final int METHOD_WRITE_SRAM = 40;
    private int _nxpMethod;
    public int block;
    public byte[] data;
    public int readDelay;
    public Object retData;

    public void setNxpMethod(int nxpMethod) {
        switch (nxpMethod) {
            case 10:
            case 11:
            case 20:
            case METHOD_WRITE /*30*/:
            case METHOD_FAST_READ /*31*/:
            case METHOD_WRITE_SRAM /*40*/:
            case METHOD_READ_SRAM /*41*/:
                this._nxpMethod = nxpMethod;
                return;
            default:
                this._nxpMethod = 0;
                return;
        }
    }

    public int getNxpMethod() {
        return this._nxpMethod;
    }

    public NxpTagCmd() {
        super(0, 0);
    }
}
