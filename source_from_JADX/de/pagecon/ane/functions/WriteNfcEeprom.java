package de.pagecon.ane.functions;

import android.annotation.TargetApi;
import android.content.Intent;
import android.nfc.Tag;
import android.os.AsyncTask;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREInvalidObjectException;
import com.adobe.fre.FREObject;
import com.adobe.fre.FRETypeMismatchException;
import com.adobe.fre.FREWrongThreadException;
import com.sigmasport.EepromRecords;
import com.sigmasport.RecordsBase;
import com.sigmasport.nfctag.NfcTag;
import de.pagecon.ane.nfc.ExtensionContext;
import de.pagecon.ane.nfc.Manager;
import java.io.IOException;

@TargetApi(10)
public class WriteNfcEeprom implements FREFunction {
    private NfcTag mNfcTag;
    private Tag mTag;

    private class WriteTagTask extends AsyncTask<EepromRecords, Void, EepromRecords> {
        private WriteTagTask() {
        }

        protected EepromRecords doInBackground(EepromRecords... params) {
            EepromRecords eepromRecord = params[0];
            try {
                Thread.sleep((long) Manager.instance.mReadSettingDataDelay);
                try {
                    WriteNfcEeprom.this.mNfcTag.connect();
                    if (WriteNfcEeprom.this.mNfcTag.getTagManufacturer() == 1) {
                        WriteNfcEeprom.this.mNfcTag.writeEepromBlock(eepromRecord.startAddr, eepromRecord.getBytes());
                        Manager.dispatchNfcResult(eepromRecord, ExtensionContext.EVENT_NFC_WRITE_EEPROM_READY);
                    } else {
                        eepromRecord.errorMessage = "Wrong manufacturer...";
                        Manager.dispatchNfcError(eepromRecord);
                    }
                    WriteNfcEeprom.this.mNfcTag.close();
                } catch (IOException e) {
                    e.printStackTrace();
                    WriteNfcEeprom.this.mNfcTag = null;
                    WriteNfcEeprom.this.mTag = null;
                    eepromRecord.errorMessage = e.getMessage();
                    Manager.dispatchNfcError(eepromRecord);
                }
            } catch (InterruptedException e2) {
                e2.printStackTrace();
                eepromRecord.errorMessage = e2.getMessage();
                Manager.dispatchNfcError(eepromRecord);
            }
            return null;
        }
    }

    public FREObject call(FREContext freContext, FREObject[] freObjects) {
        Intent mintent = freContext.getActivity().getIntent();
        this.mTag = (Tag) mintent.getParcelableExtra("android.nfc.extra.TAG");
        EepromRecords eepromRecords = new EepromRecords(0, 0);
        if (mintent != null) {
            try {
                if (this.mTag != null) {
                    this.mNfcTag = new NfcTag(this.mTag);
                    if (this.mNfcTag != null) {
                        EepromRecords eepromRecords2 = new EepromRecords(freObjects[0].getAsInt(), 0);
                        try {
                            eepromRecords2.setByteString(RecordsBase.convertIntToHexByteString(freObjects[1].getAsString()));
                            new WriteTagTask().execute(new EepromRecords[]{eepromRecords2});
                            eepromRecords = eepromRecords2;
                        } catch (IllegalStateException e) {
                            IllegalStateException e2 = e;
                            eepromRecords = eepromRecords2;
                            eepromRecords.errorMessage = e2.getMessage();
                            Manager.dispatchNfcError(eepromRecords);
                            e2.printStackTrace();
                            return null;
                        } catch (FRETypeMismatchException e3) {
                            FRETypeMismatchException e4 = e3;
                            eepromRecords = eepromRecords2;
                            eepromRecords.errorMessage = e4.getMessage();
                            Manager.dispatchNfcError(eepromRecords);
                            e4.printStackTrace();
                            return null;
                        } catch (FREInvalidObjectException e5) {
                            FREInvalidObjectException e6 = e5;
                            eepromRecords = eepromRecords2;
                            eepromRecords.errorMessage = e6.getMessage();
                            Manager.dispatchNfcError(eepromRecords);
                            e6.printStackTrace();
                            return null;
                        } catch (FREWrongThreadException e7) {
                            FREWrongThreadException e8 = e7;
                            eepromRecords = eepromRecords2;
                            eepromRecords.errorMessage = e8.getMessage();
                            Manager.dispatchNfcError(eepromRecords);
                            e8.printStackTrace();
                            return null;
                        }
                    }
                }
            } catch (IllegalStateException e9) {
                e2 = e9;
                eepromRecords.errorMessage = e2.getMessage();
                Manager.dispatchNfcError(eepromRecords);
                e2.printStackTrace();
                return null;
            } catch (FRETypeMismatchException e10) {
                e4 = e10;
                eepromRecords.errorMessage = e4.getMessage();
                Manager.dispatchNfcError(eepromRecords);
                e4.printStackTrace();
                return null;
            } catch (FREInvalidObjectException e11) {
                e6 = e11;
                eepromRecords.errorMessage = e6.getMessage();
                Manager.dispatchNfcError(eepromRecords);
                e6.printStackTrace();
                return null;
            } catch (FREWrongThreadException e12) {
                e8 = e12;
                eepromRecords.errorMessage = e8.getMessage();
                Manager.dispatchNfcError(eepromRecords);
                e8.printStackTrace();
                return null;
            }
        }
        return null;
    }
}
