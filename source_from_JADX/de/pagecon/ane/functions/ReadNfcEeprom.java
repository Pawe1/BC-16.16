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
import com.sigmasport.nfctag.NfcTag;
import de.pagecon.ane.ErrorCodes;
import de.pagecon.ane.nfc.ExtensionContext;
import de.pagecon.ane.nfc.Manager;
import java.io.IOException;

@TargetApi(10)
public class ReadNfcEeprom implements FREFunction {
    private NfcTag mNfcTag;
    private Tag mTag;

    private class ReadTagTask extends AsyncTask<EepromRecords, Void, EepromRecords> {
        private ReadTagTask() {
        }

        protected EepromRecords doInBackground(EepromRecords... params) {
            EepromRecords eepromRecord = params[0];
            try {
                int start = (int) Math.ceil((double) (eepromRecord.startAddr / 4));
                int end = (int) Math.ceil((double) (eepromRecord.endAddr / 4));
                try {
                    Thread.sleep((long) Manager.instance.mReadSettingDataDelay);
                    ReadNfcEeprom.this.mNfcTag.connect();
                    if (ReadNfcEeprom.this.mNfcTag.getTagManufacturer() == 1) {
                        for (int i = start; i <= end; i += 16) {
                            int currentStartBlock = i;
                            int currentEndBlock = (i + 16) - 1;
                            if (currentEndBlock > end) {
                                currentEndBlock = end;
                            }
                            byte[] byteBlock = ReadNfcEeprom.this.mNfcTag.getEepromBlock(currentStartBlock, currentEndBlock);
                            eepromRecord.appendBytes(byteBlock);
                            EepromRecords tmpEepromRecord = new EepromRecords(currentStartBlock * 4, ((currentEndBlock + 1) * 4) - 1);
                            tmpEepromRecord.setBytes(byteBlock);
                            Manager.dispatchNfcStepResult(tmpEepromRecord);
                        }
                        Manager.dispatchNfcResult(eepromRecord, ExtensionContext.EVENT_NFC_READ_EEPROM_READY);
                    } else {
                        eepromRecord.errorMessage = "Wrong manufacturer...";
                        eepromRecord.errorCode = ErrorCodes.ERR_WRONG_MANUFACTURER;
                        Manager.dispatchNfcError(eepromRecord);
                    }
                    ReadNfcEeprom.this.mNfcTag.close();
                } catch (InterruptedException e) {
                    e.printStackTrace();
                    eepromRecord.errorMessage = e.getMessage();
                    eepromRecord.errorCode = 102;
                    Manager.dispatchNfcError(eepromRecord);
                }
            } catch (IOException e2) {
                e2.printStackTrace();
                ReadNfcEeprom.this.mNfcTag = null;
                ReadNfcEeprom.this.mTag = null;
                eepromRecord.errorMessage = e2.getMessage();
                eepromRecord.errorCode = 100;
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
                        EepromRecords eepromRecords2 = new EepromRecords(freObjects[0].getAsInt(), freObjects[1].getAsInt());
                        try {
                            new ReadTagTask().execute(new EepromRecords[]{eepromRecords2});
                            eepromRecords = eepromRecords2;
                        } catch (IllegalStateException e) {
                            IllegalStateException e2 = e;
                            eepromRecords = eepromRecords2;
                            eepromRecords.errorMessage = e2.getMessage();
                            eepromRecords.errorCode = 10;
                            Manager.dispatchNfcError(eepromRecords);
                            e2.printStackTrace();
                            return null;
                        } catch (FRETypeMismatchException e3) {
                            FRETypeMismatchException e4 = e3;
                            eepromRecords = eepromRecords2;
                            eepromRecords.errorMessage = e4.getMessage();
                            eepromRecords.errorCode = 11;
                            Manager.dispatchNfcError(eepromRecords);
                            e4.printStackTrace();
                            return null;
                        } catch (FREInvalidObjectException e5) {
                            FREInvalidObjectException e6 = e5;
                            eepromRecords = eepromRecords2;
                            eepromRecords.errorMessage = e6.getMessage();
                            eepromRecords.errorCode = 12;
                            Manager.dispatchNfcError(eepromRecords);
                            e6.printStackTrace();
                            return null;
                        } catch (FREWrongThreadException e7) {
                            FREWrongThreadException e8 = e7;
                            eepromRecords = eepromRecords2;
                            eepromRecords.errorMessage = e8.getMessage();
                            eepromRecords.errorCode = 13;
                            Manager.dispatchNfcError(eepromRecords);
                            e8.printStackTrace();
                            return null;
                        }
                    }
                }
            } catch (IllegalStateException e9) {
                e2 = e9;
                eepromRecords.errorMessage = e2.getMessage();
                eepromRecords.errorCode = 10;
                Manager.dispatchNfcError(eepromRecords);
                e2.printStackTrace();
                return null;
            } catch (FRETypeMismatchException e10) {
                e4 = e10;
                eepromRecords.errorMessage = e4.getMessage();
                eepromRecords.errorCode = 11;
                Manager.dispatchNfcError(eepromRecords);
                e4.printStackTrace();
                return null;
            } catch (FREInvalidObjectException e11) {
                e6 = e11;
                eepromRecords.errorMessage = e6.getMessage();
                eepromRecords.errorCode = 12;
                Manager.dispatchNfcError(eepromRecords);
                e6.printStackTrace();
                return null;
            } catch (FREWrongThreadException e12) {
                e8 = e12;
                eepromRecords.errorMessage = e8.getMessage();
                eepromRecords.errorCode = 13;
                Manager.dispatchNfcError(eepromRecords);
                e8.printStackTrace();
                return null;
            }
        }
        return null;
    }
}
