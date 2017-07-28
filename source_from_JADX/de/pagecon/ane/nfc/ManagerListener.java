package de.pagecon.ane.nfc;

public interface ManagerListener {
    void dispatchNfcResult(String str, String str2);

    void nfcStatusChanged(Boolean bool);
}
