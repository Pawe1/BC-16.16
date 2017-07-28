package de.pagecon.bleane.cc2540;

public class CharOpTask {
    public byte[] bytesToWrite = null;
    public int charHandle = 65535;
    public String charUuid = null;
    public BleDevice device = null;
    public Boolean enableNotify = Boolean.valueOf(false);
    public String serviceUuid = null;
    public CharOpState state = CharOpState.CharOpStateInitial;
    public CharOpType type;

    public enum CharOpState {
        CharOpStateInitial,
        CharOpStateDisc,
        CharOpStateRunning
    }

    public enum CharOpType {
        CharOpTypeRead,
        CharOpTypeWrite,
        CharOpTypeNotify
    }
}
