package de.pagecon.bleane.cc2540;

import android.app.Activity;
import android.os.Handler;
import android.os.Looper;
import android.util.SparseArray;
import com.sigmasport.misc.NfcProprietaryCmd;
import de.pagecon.bleane.cc2540.CharOpTask.CharOpState;
import de.pagecon.bleane.cc2540.CharOpTask.CharOpType;
import de.pagecon.bleane.cc2540.usb.SigmaUsbDevice;
import de.pagecon.bleane.cc2540.usb.UsbManager;
import de.pagecon.bleane.cc2540.usb.UsbManagerListener;
import de.pagecon.bleane.cc2540.usb.VIDPIDPair;
import de.pagecon.bleane.extension.Manager;
import de.pagecon.bleane.util.Helper;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Locale;

public class DongleManager implements UsbManagerListener {
    private static /* synthetic */ int[] $SWITCH_TABLE$de$pagecon$bleane$cc2540$CharOpTask$CharOpState = null;
    private static /* synthetic */ int[] $SWITCH_TABLE$de$pagecon$bleane$cc2540$CharOpTask$CharOpType = null;
    private static final int ATT_ErrorRsp = 1281;
    private static final int ATT_ExchangeMTUReq = 1282;
    private static final int ATT_ExchangeMTURsp = 1283;
    private static final int ATT_ExecuteWriteReq = 1304;
    private static final int ATT_ExecuteWriteRsp = 1305;
    private static final int ATT_FindByTypeValueReq = 1286;
    private static final int ATT_FindByTypeValueRsp = 1287;
    private static final int ATT_FindInfoReq = 1284;
    private static final int ATT_FindInfoRsp = 1285;
    private static final int ATT_HandleValueConfirmation = 1310;
    private static final int ATT_HandleValueIndication = 1309;
    private static final int ATT_HandleValueNotification = 1307;
    private static final int ATT_PrepareWriteReq = 1302;
    private static final int ATT_PrepareWriteRsp = 1303;
    private static final int ATT_ReadBlobReq = 1292;
    private static final int ATT_ReadBlobRsp = 1293;
    private static final int ATT_ReadByGrpTypeReq = 1296;
    private static final int ATT_ReadByGrpTypeRsp = 1297;
    private static final int ATT_ReadByTypeReq = 1288;
    private static final int ATT_ReadByTypeRsp = 1289;
    private static final int ATT_ReadMultiReq = 1294;
    private static final int ATT_ReadMultiRsp = 1295;
    private static final int ATT_ReadReq = 1290;
    private static final int ATT_ReadRsp = 1291;
    private static final int ATT_WriteReq = 1298;
    private static final int ATT_WriteRsp = 1299;
    private static final int GAP_AdvertDataUpdate = 1538;
    private static final int GAP_Authenticate = 65035;
    private static final int GAP_AuthenticationComplete = 1546;
    private static final int GAP_Bond = 65039;
    private static final int GAP_BondComplete = 1550;
    private static final int GAP_BondGetParam = 65079;
    private static final int GAP_BondSetParam = 65078;
    private static final int GAP_ConfigDeviceAddr = 65027;
    private static final int GAP_DeviceDiscoveryCancel = 65029;
    private static final int GAP_DeviceDiscoveryDone = 1537;
    private static final int GAP_DeviceDiscoveryRequest = 65028;
    private static final int GAP_DeviceInformation = 1549;
    private static final int GAP_DeviceInit = 65024;
    private static final int GAP_DeviceInitDone = 1536;
    private static final int GAP_EndDiscoverable = 1540;
    private static final int GAP_EstablishLink = 1541;
    private static final int GAP_EstablishLinkRequest = 65033;
    private static final int GAP_GetParam = 65073;
    private static final int GAP_HCI_ExtentionCommandStatus = 1663;
    private static final int GAP_LinkParamUpdate = 1543;
    private static final int GAP_MakeDiscoverable = 1539;
    private static final int GAP_PairingRequested = 1551;
    private static final int GAP_PasskeyNeeded = 1547;
    private static final int GAP_PasskeyUpdate = 65036;
    private static final int GAP_RandomAddressChange = 1544;
    private static final int GAP_RemoveAdvToken = 65076;
    private static final int GAP_ResolvePrivateAddr = 65074;
    private static final int GAP_SetAdvToken = 65075;
    private static final int GAP_SetParam = 65072;
    private static final int GAP_Signable = 65038;
    private static final int GAP_SignatureUpdate = 1545;
    private static final int GAP_SlaveRequestedSecurity = 1548;
    private static final int GAP_SlaveSecurityRequest = 65037;
    private static final int GAP_TerminateAuth = 65040;
    private static final int GAP_TerminateLink = 1542;
    private static final int GAP_TerminateLinkRequest = 65034;
    private static final int GAP_UpdateAdvTokens = 65077;
    private static final int GAP_UpdateAdvertisingData = 65031;
    private static final int GATT_AddAttribute = 65022;
    private static final int GATT_AddService = 65020;
    private static final int GATT_DelService = 65021;
    private static final int GATT_DiscCharsByUUID = 64904;
    private static final int GATT_ReadCharValue = 64906;
    private static final int GATT_WriteCharValue = 64914;
    private static final int GATT_WriteLong = 64918;
    private static final int HCIExt_ClkDivideOnHalt = 64515;
    private static final int HCIExt_ClkDivideOnHaltDone = 1027;
    private static final int HCIExt_Decrypt = 64517;
    private static final int HCIExt_DecryptDone = 1029;
    private static final int HCIExt_DelayPostProc = 64516;
    private static final int HCIExt_DelayPostProcDone = 1028;
    private static final int HCIExt_EndModemTest = 64523;
    private static final int HCIExt_EndModemTestDone = 1035;
    private static final int HCIExt_ModemHopTestTx = 64521;
    private static final int HCIExt_ModemHopTestTxDone = 1033;
    private static final int HCIExt_ModemTestRx = 64522;
    private static final int HCIExt_ModemTestRxDone = 1034;
    private static final int HCIExt_ModemTestTx = 64520;
    private static final int HCIExt_ModemTestTxDone = 1032;
    private static final int HCIExt_OnePktPerEvt = 64514;
    private static final int HCIExt_OnePktPerEvtDone = 1026;
    private static final int HCIExt_SetBDADDRCmd = 64524;
    private static final int HCIExt_SetBDADDRCmdDone = 1036;
    private static final int HCIExt_SetFastTxRespTime = 64519;
    private static final int HCIExt_SetFastTxRespTimeDone = 1031;
    private static final int HCIExt_SetLocalSupportedFeatures = 64518;
    private static final int HCIExt_SetLocalSupportedFeaturesDone = 1030;
    private static final int HCIExt_SetRxGain = 64512;
    private static final int HCIExt_SetRxGainDone = 1024;
    private static final int HCIExt_SetTxPower = 64513;
    private static final int HCIExt_SetTxPowerDone = 1025;
    private static final int HCIStatus_ReadRSSI = 5125;
    private static final int HCI_AMP_ReceiverReportEvent = 75;
    private static final int HCI_AMP_StartTestEvent = 73;
    private static final int HCI_AMP_StatusChangeEvent = 77;
    private static final int HCI_AMP_TestEndEvent = 74;
    private static final int HCI_AuthenticationCompleteEvent = 6;
    private static final int HCI_ChangeConnectionLinkKeyCompleteEvent = 9;
    private static final int HCI_ChannelSelectedEvent = 65;
    private static final int HCI_CommandCompleteEvent = 14;
    private static final int HCI_CommandStatusEvent = 15;
    private static final int HCI_ConnectionCompleteEvent = 3;
    private static final int HCI_ConnectionPacketTypeChangedEvent = 29;
    private static final int HCI_ConnectionRequestEvent = 4;
    private static final int HCI_DataBufferOverflowEvent = 26;
    private static final int HCI_DisconnectionCompleteEvent = 5;
    private static final int HCI_DisconnectionLogicalLinkCompleteEvent = 70;
    private static final int HCI_DisconnectionPhysicalLinkCompleteEvent = 66;
    private static final int HCI_EncryptionChangeEvent = 8;
    private static final int HCI_EncryptionKeyRefreshCompleteEvent = 48;
    private static final int HCI_EnhancedFlushCompleteEvent = 57;
    private static final int HCI_ExtendedInquiryResultEvent = 47;
    private static final int HCI_FlowSpecModifyCompleteEvent = 71;
    private static final int HCI_FlowSpecificationCompleteEvent = 33;
    private static final int HCI_FlushOccurredEvent = 17;
    private static final int HCI_HardwareErrorEvent = 16;
    private static final int HCI_IOCapabilityRequestEvent = 49;
    private static final int HCI_IOCapabilityResponseEvent = 50;
    private static final int HCI_InquiryCompleteEvent = 1;
    private static final int HCI_InquiryResultEvent = 2;
    private static final int HCI_InquiryResultWithRSSIEvent = 34;
    private static final int HCI_KeypressNotificationEvent = 60;
    private static final int HCI_LE_AdvertisingReportEvent = 62;
    private static final int HCI_LE_ConnectionCompleteEvent = 62;
    private static final int HCI_LE_ConnectionUpdateCompleteEvent = 62;
    private static final int HCI_LE_ExtEvent = 255;
    private static final int HCI_LE_LongTermKeyRequestEvent = 62;
    private static final int HCI_LE_ReadRemoteUsedFeaturesCompleteEvent = 62;
    private static final int HCI_LinkKeyNotificationEvent = 24;
    private static final int HCI_LinkKeyRequestEvent = 23;
    private static final int HCI_LinkSupervisionTimeoutChangedEvent = 56;
    private static final int HCI_LogicalLinkCompleteEvent = 69;
    private static final int HCI_LoopbackCommandEvent = 25;
    private static final int HCI_MasterLinkKeyCompleteEvent = 10;
    private static final int HCI_MaxSlotsChangeEvent = 27;
    private static final int HCI_ModeChangeEvent = 20;
    private static final int HCI_NumberOfCompletedDataBlocksEvent = 72;
    private static final int HCI_NumberOfCompletedPacketsEvent = 19;
    private static final int HCI_PINCodeRequestEvent = 22;
    private static final int HCI_PageScanModeChangeEvent = 31;
    private static final int HCI_PageScanRepetitionModeChangeEvent = 32;
    private static final int HCI_PhysicalLinkCompleteEvent = 64;
    private static final int HCI_PhysicalLinkLossEarlyWarningEvent = 67;
    private static final int HCI_PhysicalLinkRecoveryEvent = 68;
    private static final int HCI_QoSSetupCompleteEvent = 13;
    private static final int HCI_QoSViolationEvent = 30;
    private static final int HCI_ReadClockOffsetCompleteEvent = 28;
    private static final int HCI_ReadRemoteExtendedFeaturesCompleteEvent = 35;
    private static final int HCI_ReadRemoteSupportedFeaturesCompleteEvent = 11;
    private static final int HCI_ReadRemoteVersionInformationCompleteEvent = 12;
    private static final int HCI_RemoteHostSupportedFeaturesNotificationEvent = 61;
    private static final int HCI_RemoteNameRequestCompleteEvent = 7;
    private static final int HCI_RemoteOOBDataRequestEvent = 53;
    private static final int HCI_RemoteOobResponseEvent = 55;
    private static final int HCI_ReturnLinkKeysEvent = 21;
    private static final int HCI_RoleChangeEvent = 18;
    private static final int HCI_ShortRangeModeChangeCompleteEvent = 76;
    private static final int HCI_SimplePairingCompleteEvent = 54;
    private static final int HCI_SniffRequestEvent = 58;
    private static final int HCI_SniffSubratingEvent = 46;
    private static final int HCI_SynchronousConnectionChangedEvent = 45;
    private static final int HCI_SynchronousConnectionCompleteEvent = 44;
    private static final int HCI_UserConfirmationRequestEvent = 51;
    private static final int HCI_UserPasskeyNotificationEvent = 59;
    private static final int HCI_UserPasskeyRequestEvent = 52;
    private static final int L2CAP_CmdReject = 1153;
    private static final int L2CAP_ConnParamUpdateReq = 64658;
    private static final int L2CAP_ConnParamUpdateRsp = 1171;
    private static final int L2CAP_InfoReq = 64650;
    private static final int L2CAP_InfoRsp = 1163;
    private static final int UTIL_NVRead = 65153;
    private static final int UTIL_NVWrite = 65154;
    private static final int UTIL_Reset = 65152;
    private static final char[] hexArray = "0123456789ABCDEF".toCharArray();
    public static DongleManager instance = null;
    byte[] CMD_ADD_TO_WHITELIST;
    byte[] CMD_CLEAR_WHITELIST;
    byte[] CMD_GAP_DeviceDiscoveryCancel;
    byte[] CMD_GAP_DeviceDiscoveryRequest;
    byte[] CMD_GAP_DeviceInit;
    byte[] CMD_GAP_DiscoverCharacteristicByUuid;
    byte[] CMD_GAP_ESTABLISH;
    byte[] CMD_GAP_ReadCharacteristic;
    byte[] CMD_GAP_SetParam1;
    byte[] CMD_GAP_SetParam2;
    byte[] CMD_GAP_SetParam3;
    byte[] CMD_GAP_SetParam4;
    byte[] CMD_GAP_SetParam5;
    byte[] CMD_GAP_SetParam6;
    byte[] CMD_GAP_TERMINATE_ESTABLISH_LINK_REQUEST_REQUEST;
    byte[] CMD_GAP_TERMINATE_LINK_REQUEST;
    byte[] CMD_HCI_HardReset;
    byte[] CMD_READ_WHITELIST_SIZE;
    private Activity activity;
    private TS_BleDeviceList discoveredDevices;
    private SigmaUsbDevice dongle;
    private SparseArray<String> gAttErrorConstantsMap = new SparseArray();
    private SparseArray<String> gHciStringConstantsMap = new SparseArray();
    private SparseArray<String> gHostErrorCodesMap = new SparseArray();
    private Boolean gScanning;
    private TS_BleDeviceList knownDevices;
    public DongleManagerListener listener;
    private DataReceiveHandler receiveHandler;
    private TS_StringList serviceUuids;
    private CharOpTaskQueue taskQueue;
    private UsbManager usbManager;
    private TS_BleDeviceList whiteList;

    class DataReceiveHandler {
        private static final byte HCI_PACKETTYPE_EVENT = (byte) 4;
        byte[] buf = new byte[131088];
        int buf_index_insert = 0;
        int buf_index_read = 0;
        final int buf_length = 131088;

        DataReceiveHandler() {
        }

        void dataReceived(byte[] receivedData) {
            if (length > 0) {
                byte packetType = receivedData[0];
                byte hciEventCode = receivedData[1];
                if (packetType == (byte) 4 && (hciEventCode == (byte) -1 || hciEventCode == NfcProprietaryCmd.SET_AS3953_NDEF_MSG_RQST_CMD)) {
                    int i;
                    for (byte b : receivedData) {
                        this.buf[this.buf_index_insert % 131088] = b;
                        this.buf_index_insert++;
                    }
                    if (this.buf_index_insert < this.buf_index_read + 3) {
                        Manager.cLog("SCHEIßE 1!");
                        return;
                    }
                    while (this.buf_index_insert >= this.buf_index_read + 3) {
                        byte type = this.buf[(this.buf_index_read + 0) % 131088];
                        byte eventCode = this.buf[(this.buf_index_read + 1) % 131088];
                        byte dataLength = this.buf[(this.buf_index_read + 2) % 131088];
                        if (this.buf_index_insert < (this.buf_index_read + 3) + dataLength) {
                            Manager.cLog("SCHEIßE 2!");
                            break;
                        }
                        byte[] data = new byte[dataLength];
                        for (byte j = (byte) 0; j < dataLength; j++) {
                            data[j] = this.buf[((this.buf_index_read + 3) + j) % 131088];
                        }
                        if (eventCode == (byte) -1) {
                            new HciEvent(type, eventCode, data).handle();
                        } else if (eventCode == NfcProprietaryCmd.SET_AS3953_NDEF_MSG_RQST_CMD) {
                            if (dataLength >= (byte) 4 && data[0] == (byte) 1 && data[1] == (byte) 16 && data[2] == (byte) 32) {
                                if (data[3] != (byte) 0) {
                                    DongleManager.this.whiteList.clear();
                                } else if (DongleManager.this.whiteList.getSize() > 0) {
                                    Boolean start = Boolean.valueOf(false);
                                    for (int j2 = 0; j2 < DongleManager.this.whiteList.getSize(); j2++) {
                                        BleDevice device = DongleManager.this.whiteList.getDeviceAtIndex(j2);
                                        if (device != null) {
                                            for (i = 0; i < 6; i++) {
                                                DongleManager.this.CMD_ADD_TO_WHITELIST[i + 5] = device.getHwAddress()[5 - i];
                                            }
                                            DongleManager.this.dongle.sendData(DongleManager.this.CMD_ADD_TO_WHITELIST);
                                            if (!device.isConnected().booleanValue()) {
                                                start = Boolean.valueOf(true);
                                            }
                                        }
                                    }
                                    DongleManager.this.whiteList.clear();
                                    if (start.booleanValue()) {
                                        DongleManager.this.dongle.sendData(DongleManager.this.CMD_GAP_ESTABLISH);
                                    }
                                }
                            }
                            Manager.cLog("packetType: " + type + ", eventCode: " + eventCode + " dataLength: " + dataLength + "\n" + "data: " + DongleManager.dataToFormattedHexString(data));
                        }
                        this.buf_index_read += dataLength + 3;
                    }
                    DongleManager.this.chexecuteTask();
                    return;
                }
                Manager.cLog("UNEXPECTED PACKET TYPE RECEIVED, packet type: " + packetType + "\n" + "That means we are probably out of sync with the event borders. Result is we will lose all events up to the next read of the com-buffer.");
                return;
            }
            Manager.cLog("Packet with zero length received");
        }
    }

    class HciEvent {
        private byte[] data;
        private int dataLength;
        private byte eventCode;
        private byte type;

        public int getValueFromUInt16(byte b1, byte b2) {
            return ((b2 << 8) & 65535) | (b1 & DongleManager.HCI_LE_ExtEvent);
        }

        public HciEvent(byte type, byte eventCode, byte[] data) {
            this.type = type;
            this.eventCode = eventCode;
            this.data = data;
            this.dataLength = data.length;
        }

        public void handle() {
            int event = getValueFromUInt16(this.data[0], this.data[1]);
            int connHandle;
            CharOpTask task;
            BleDevice device;
            int status;
            byte[] receivedData;
            String addrStr;
            BleDevice bleDevice;
            switch (event) {
                case DongleManager.ATT_ErrorRsp /*1281*/:
                    connHandle = getValueFromUInt16(this.data[3], this.data[4]);
                    task = DongleManager.this.taskQueue.getTask();
                    device = DongleManager.this.knownDevices.findDevice(connHandle);
                    if (device == null || task == null || device != task.device) {
                        Manager.cLog("###\n###\n###\n###\n###\n###\n###\n###\n###\n###\n###\n###\n###\n###\n###\n###\n###\n###\n###\n###\n###\n###\n###\n###do stimmt was net in ATT_ErrorRsp");
                        return;
                    }
                    int errCode = this.data[9];
                    Manager.cLog("packetType: " + this.type + ", eventCode: " + this.eventCode + " dataLength: " + this.dataLength + "\n" + "event: " + ((String) DongleManager.this.gHciStringConstantsMap.get(event)) + "\n" + "Error: " + ((String) DongleManager.this.gAttErrorConstantsMap.get(errCode)) + "\n" + "Device: " + device.getDeviceId() + "\n" + "Service: " + task.serviceUuid + "\n" + "Characteristic: " + task.charUuid);
                    DongleManager.this.notifyError(-3, (String) DongleManager.this.gAttErrorConstantsMap.get(errCode), device.getDeviceId(), task.serviceUuid, task.charUuid);
                    DongleManager.this.taskQueue.dequeueTask();
                    return;
                case DongleManager.ATT_ReadByTypeRsp /*1289*/:
                    status = this.data[2];
                    connHandle = getValueFromUInt16(this.data[3], this.data[4]);
                    task = DongleManager.this.taskQueue.getTask();
                    device = DongleManager.this.knownDevices.findDevice(connHandle);
                    if (task == null) {
                        return;
                    }
                    if (device == null || device != task.device) {
                        Manager.cLog("###\n###\n###\n###\n###\n###\n###\n###\n###\n###\n###\n###\n###\n###\n###\n###\n###\n###\n###\n###\n###\n###\n###\n###do stimmt was net in ATT_ReadByTypeRsp");
                        return;
                    } else if (status == 0) {
                        task.charHandle = this.data[7];
                        Manager.cLog("packetType: " + this.type + ", eventCode: " + this.eventCode + " dataLength: " + this.dataLength + "\n" + "event: " + ((String) DongleManager.this.gHciStringConstantsMap.get(event)) + "\n" + "Status: " + ((String) DongleManager.this.gHostErrorCodesMap.get(status)) + "\n" + "char handle discovered");
                        return;
                    } else if (status == 26) {
                        if (task.charHandle != 65535) {
                            device.addCharacteristicHandle(task.charUuid, task.charHandle);
                        }
                        Manager.cLog("packetType: " + this.type + ", eventCode: " + this.eventCode + " dataLength: " + this.dataLength + "\n" + "event: " + ((String) DongleManager.this.gHciStringConstantsMap.get(event)) + "\n" + "procedure completed");
                        return;
                    } else {
                        Manager.cLog("packetType: " + this.type + ", eventCode: " + this.eventCode + " dataLength: " + this.dataLength + "\n" + "event: " + ((String) DongleManager.this.gHciStringConstantsMap.get(event)) + "\n" + "Status: " + ((String) DongleManager.this.gHostErrorCodesMap.get(status)));
                        return;
                    }
                case DongleManager.ATT_ReadRsp /*1291*/:
                    status = this.data[2];
                    connHandle = getValueFromUInt16(this.data[3], this.data[4]);
                    task = DongleManager.this.taskQueue.getTask();
                    device = DongleManager.this.knownDevices.findDevice(connHandle);
                    if (task == null) {
                        return;
                    }
                    if (device == null || device != task.device) {
                        Manager.cLog("###\n###\n###\n###\n###\n###\n###\n###\n###\n###\n###\n###\n###\n###\n###\n###\n###\n###\n###\n###\n###\n###\n###\n###do stimmt was net in Att_ReadRsp");
                        return;
                    }
                    if (status == 0) {
                        int pduLength = this.data[5];
                        receivedData = new byte[pduLength];
                        if (pduLength > 0) {
                            receivedData = Arrays.copyOfRange(this.data, 6, pduLength + 6);
                        }
                        DongleManager.this.notifyDataReceived(device.getDeviceId(), task.serviceUuid, task.charUuid, receivedData);
                        Manager.cLog("packetType: " + this.type + ", eventCode: " + this.eventCode + " dataLength: " + this.dataLength + "\n" + "event: " + ((String) DongleManager.this.gHciStringConstantsMap.get(event)) + "\n" + "value: " + DongleManager.dataToFormattedHexString(receivedData));
                    } else {
                        Manager.cLog("packetType: " + this.type + ", eventCode: " + this.eventCode + " dataLength: " + this.dataLength + "\n" + "event: " + ((String) DongleManager.this.gHciStringConstantsMap.get(event)) + "\n" + "Status: " + ((String) DongleManager.this.gHostErrorCodesMap.get(status)));
                    }
                    DongleManager.this.taskQueue.dequeueTask();
                    return;
                case DongleManager.ATT_WriteRsp /*1299*/:
                    status = this.data[2];
                    connHandle = getValueFromUInt16(this.data[3], this.data[4]);
                    task = DongleManager.this.taskQueue.getTask();
                    device = DongleManager.this.knownDevices.findDevice(connHandle);
                    if (task == null) {
                        return;
                    }
                    if (device == null || device != task.device || task.type == CharOpType.CharOpTypeRead) {
                        Manager.cLog("###\n###\n###\n###\n###\n###\n###\n###\n###\n###\n###\n###\n###\n###\n###\n###\n###\n###\n###\n###\n###\n###\n###\n###do stimmt was net in Att_WriteRsp");
                        return;
                    }
                    if (status != 0) {
                        DongleManager.this.notifyError(-3, (String) DongleManager.this.gHostErrorCodesMap.get(status), task.device.getDeviceId(), task.serviceUuid, task.charUuid);
                    } else if (task.type == CharOpType.CharOpTypeWrite) {
                        DongleManager.this.notifyDataWritten(task.device.getDeviceId(), task.serviceUuid, task.charUuid);
                    }
                    Manager.cLog("packetType: " + this.type + ", eventCode: " + this.eventCode + " dataLength: " + this.dataLength + "\n" + "event: " + ((String) DongleManager.this.gHciStringConstantsMap.get(event)) + "\n" + "Status: " + ((String) DongleManager.this.gHostErrorCodesMap.get(status)));
                    DongleManager.this.taskQueue.dequeueTask();
                    return;
                case DongleManager.ATT_HandleValueNotification /*1307*/:
                    status = this.data[2];
                    device = DongleManager.this.knownDevices.findDevice(getValueFromUInt16(this.data[3], this.data[4]));
                    if (device == null) {
                        Manager.cLog("received notification from unknown device");
                        return;
                    } else if (status == 0) {
                        int dataLength = this.data[5] - 2;
                        receivedData = (byte[]) null;
                        String charUuid = device.getCharacteristicUuidForHandle(getValueFromUInt16(this.data[6], this.data[7]) - 1);
                        if (charUuid.equals("")) {
                            Manager.cLog("received notification from unknown characteristic");
                            return;
                        }
                        if (dataLength > 0) {
                            receivedData = Arrays.copyOfRange(this.data, 8, dataLength + 8);
                        }
                        DongleManager.this.notifyDataReceived(device.getDeviceId(), "", charUuid, receivedData);
                        return;
                    } else {
                        Manager.cLog("packetType: " + this.type + ", eventCode: " + this.eventCode + " dataLength: " + this.dataLength + "\n" + "event: " + ((String) DongleManager.this.gHciStringConstantsMap.get(event)) + "\n" + "Status: " + ((String) DongleManager.this.gHostErrorCodesMap.get(status)));
                        return;
                    }
                case DongleManager.GAP_DeviceInitDone /*1536*/:
                    Manager.cLog("packetType: " + this.type + ", eventCode: " + this.eventCode + " dataLength: " + this.dataLength + "\n" + "event: " + ((String) DongleManager.this.gHciStringConstantsMap.get(event)) + "\n" + "Status: " + ((String) DongleManager.this.gHostErrorCodesMap.get(this.data[2])));
                    return;
                case DongleManager.GAP_DeviceDiscoveryDone /*1537*/:
                    status = this.data[2];
                    DongleManager.this.gScanning = Boolean.valueOf(false);
                    DongleManager.this.notifyScanningStateChanged(DongleManager.this.gScanning.booleanValue());
                    Manager.cLog("packetType: " + this.type + ", eventCode: " + this.eventCode + " dataLength: " + this.dataLength + "\n" + "event: " + ((String) DongleManager.this.gHciStringConstantsMap.get(event)) + "\n" + "Status: " + ((String) DongleManager.this.gHostErrorCodesMap.get(status)));
                    return;
                case DongleManager.GAP_EstablishLink /*1541*/:
                    status = this.data[2];
                    addrStr = BleDevice.byteArrayToAddressString(new byte[]{this.data[4], this.data[5], this.data[6], this.data[7], this.data[8], this.data[9]});
                    connHandle = getValueFromUInt16(this.data[10], this.data[11]);
                    Manager.cLog("packetType: " + this.type + ", eventCode: " + this.eventCode + " dataLength: " + this.dataLength + "\n" + "event: " + ((String) DongleManager.this.gHciStringConstantsMap.get(event)) + "\n" + "devAddr: " + addrStr + "\n" + "connHandle: " + DongleManager.dataToFormattedHexString(new byte[]{this.data[10], this.data[11]}) + "\n" + "Status: " + ((String) DongleManager.this.gHostErrorCodesMap.get(status)));
                    if (status == 49) {
                        DongleManager.this.notifyConnectionRequestsCanceled();
                        return;
                    } else if (status != 0) {
                        DongleManager.this.notifyError(-7, "Connection failed", addrStr, "", "");
                        return;
                    } else {
                        bleDevice = DongleManager.this.knownDevices.findDevice(addrStr);
                        if (bleDevice != null) {
                            bleDevice.setConnectionHandle(connHandle);
                        }
                        DongleManager.this.notifyDeviceConnected(bleDevice.getDeviceId(), null);
                        return;
                    }
                case DongleManager.GAP_TerminateLink /*1542*/:
                    status = this.data[2];
                    bleDevice = DongleManager.this.knownDevices.findDevice(getValueFromUInt16(this.data[3], this.data[4]));
                    if (bleDevice != null) {
                        bleDevice.setConnectionHandle(65535);
                        DongleManager.this.taskQueue.clearTasksOfDevice(bleDevice);
                        DongleManager.this.notifyDeviceDisconnected(bleDevice.getDeviceId());
                    }
                    Manager.cLog("packetType: " + this.type + ", eventCode: " + this.eventCode + " dataLength: " + this.dataLength + "\n" + "event: " + ((String) DongleManager.this.gHciStringConstantsMap.get(event)) + "\n" + "Status: " + ((String) DongleManager.this.gHostErrorCodesMap.get(status)));
                    return;
                case DongleManager.GAP_LinkParamUpdate /*1543*/:
                    Manager.cLog("packetType: " + this.type + ", eventCode: " + this.eventCode + " dataLength: " + this.dataLength + "\n" + "event: " + ((String) DongleManager.this.gHciStringConstantsMap.get(event)) + "\n" + "Status: " + ((String) DongleManager.this.gHostErrorCodesMap.get(this.data[2])));
                    return;
                case DongleManager.GAP_DeviceInformation /*1549*/:
                    int i;
                    status = this.data[2];
                    String eventTypeStr = "";
                    switch (this.data[3]) {
                        case (byte) 0:
                            eventTypeStr = "Connectable undirected advertisement";
                            break;
                        case (byte) 1:
                            eventTypeStr = "Connectable directed advertisement";
                            break;
                        case (byte) 2:
                            eventTypeStr = "Discoverable undirected advertisement";
                            break;
                        case (byte) 3:
                            eventTypeStr = "Non-Connectable undirected advertisement";
                            break;
                        case (byte) 4:
                            eventTypeStr = "Scan response";
                            break;
                        default:
                            eventTypeStr = "";
                            break;
                    }
                    byte[] address = new byte[]{this.data[5], this.data[6], this.data[7], this.data[8], this.data[9], this.data[10]};
                    byte dataLen = this.data[12];
                    byte[] name = null;
                    List<String> primaryServiceUUIDs = new ArrayList();
                    if (dataLen != (byte) 0) {
                        byte currentIndex = (byte) 0;
                        while (currentIndex < dataLen) {
                            byte length = this.data[13 + currentIndex];
                            byte type = this.data[(13 + currentIndex) + 1];
                            if (type == (byte) 8 || type == (byte) 9) {
                                name = Arrays.copyOfRange(this.data, (13 + currentIndex) + 2, (((13 + currentIndex) + 2) + length) - 1);
                            } else if (type == (byte) 2 || type == (byte) 3 || type == (byte) 4 || type == (byte) 5 || type == (byte) 6 || type == (byte) 7) {
                                int serviceUUIDLength = 0;
                                if (type == (byte) 2 || type == (byte) 3) {
                                    serviceUUIDLength = 2;
                                }
                                if (type == (byte) 4 || type == (byte) 5) {
                                    serviceUUIDLength = 4;
                                }
                                if (type == (byte) 6 || type == (byte) 7) {
                                    serviceUUIDLength = 16;
                                }
                                for (int currentServiceIndex = currentIndex + 2; currentServiceIndex < currentIndex + length; currentServiceIndex += serviceUUIDLength) {
                                    byte[] serviceUuid = Arrays.copyOfRange(this.data, 13 + currentServiceIndex, (13 + currentServiceIndex) + serviceUUIDLength);
                                    int serviceUuidBytesLength = serviceUuid.length;
                                    byte[] reversedServiceUuid = new byte[serviceUuidBytesLength];
                                    for (i = 0; i < serviceUuidBytesLength; i++) {
                                        reversedServiceUuid[i] = serviceUuid[(serviceUuidBytesLength - 1) - i];
                                    }
                                    primaryServiceUUIDs.add(DongleManager.createUuid(reversedServiceUuid));
                                }
                            }
                            currentIndex = (currentIndex + length) + 1;
                            if (currentIndex < dataLen) {
                                if (this.data[13 + currentIndex] == (byte) 0) {
                                }
                            }
                        }
                    }
                    addrStr = BleDevice.byteArrayToAddressString(address);
                    bleDevice = DongleManager.this.discoveredDevices.findDevice(addrStr);
                    if (bleDevice == null) {
                        bleDevice = DongleManager.this.knownDevices.findDevice(addrStr);
                        if (bleDevice == null) {
                            bleDevice = new BleDevice();
                            bleDevice.setHwAddress(address);
                        }
                        DongleManager.this.discoveredDevices.addDevice(bleDevice);
                        if (DongleManager.this.knownDevices.findDevice(addrStr) == null) {
                            DongleManager.this.knownDevices.addDevice(bleDevice);
                        }
                    }
                    if (primaryServiceUUIDs.size() > 0) {
                        if (DongleManager.this.serviceUuids.getSize() > 0) {
                            boolean z;
                            Boolean serviceUuidFound = Boolean.valueOf(false);
                            i = 0;
                            while (i < DongleManager.this.serviceUuids.getSize()) {
                                String serviceUuid2 = DongleManager.this.serviceUuids.getString(i);
                                int j = 0;
                                while (j < primaryServiceUUIDs.size()) {
                                    String foundServiceUuid = (String) primaryServiceUUIDs.get(j);
                                    if (Helper.stringEqualsIgnoreCase(serviceUuid2, foundServiceUuid)) {
                                        bleDevice.primaryServiceUuid = foundServiceUuid;
                                        serviceUuidFound = Boolean.valueOf(true);
                                        if (serviceUuidFound.booleanValue()) {
                                            i++;
                                        } else {
                                            if (!serviceUuidFound.booleanValue() || bleDevice.notifyDiscovery.booleanValue()) {
                                                z = true;
                                            } else {
                                                z = false;
                                            }
                                            bleDevice.notifyDiscovery = Boolean.valueOf(z);
                                        }
                                    } else {
                                        j++;
                                    }
                                }
                                if (serviceUuidFound.booleanValue()) {
                                    if (serviceUuidFound.booleanValue()) {
                                        break;
                                    }
                                    z = true;
                                    bleDevice.notifyDiscovery = Boolean.valueOf(z);
                                } else {
                                    i++;
                                }
                            }
                            if (serviceUuidFound.booleanValue()) {
                            }
                            z = true;
                            bleDevice.notifyDiscovery = Boolean.valueOf(z);
                        } else {
                            bleDevice.primaryServiceUuid = (String) primaryServiceUUIDs.get(0);
                            bleDevice.notifyDiscovery = Boolean.valueOf(true);
                        }
                    }
                    if (name != null) {
                        try {
                            bleDevice.name = new String(name, "UTF-8");
                        } catch (UnsupportedEncodingException e) {
                            Manager.cLog("couldn't convert byte array to device name string");
                            e.printStackTrace();
                        }
                    }
                    if (bleDevice.isScanInfoComplete().booleanValue() && !bleDevice.discoveryNotified.booleanValue() && bleDevice.notifyDiscovery.booleanValue()) {
                        DongleManager.this.notifyDeviceDiscovered(bleDevice.getDeviceId(), bleDevice.primaryServiceUuid, bleDevice.name);
                        bleDevice.discoveryNotified = Boolean.valueOf(true);
                    }
                    Manager.cLog("packetType: " + this.type + ", eventCode: " + this.eventCode + " dataLength: " + this.dataLength + "\n" + "event: " + ((String) DongleManager.this.gHciStringConstantsMap.get(event)) + " eventType: " + eventTypeStr + "\n" + "name: " + bleDevice.name + "\n" + "address: " + bleDevice.getDeviceId() + "\n" + "Status: " + ((String) DongleManager.this.gHostErrorCodesMap.get(status)));
                    Manager.cLog("Primary Service: " + bleDevice.primaryServiceUuid);
                    return;
                case DongleManager.GAP_HCI_ExtentionCommandStatus /*1663*/:
                    status = this.data[2];
                    int opCode = getValueFromUInt16(this.data[3], this.data[4]);
                    if (status != 0) {
                        if (opCode == DongleManager.GAP_DeviceDiscoveryRequest) {
                            DongleManager.this.notifyError(-18, "couldn't start scan (already started?)", "", "", "");
                        } else if (opCode == DongleManager.GAP_DeviceDiscoveryCancel) {
                            DongleManager.this.notifyError(-19, "couldn't stop scan (already stopped?)", "", "", "");
                        } else if (opCode == DongleManager.GATT_DiscCharsByUUID) {
                            task = DongleManager.this.taskQueue.getTask();
                            if (task != null) {
                                if (task.state != CharOpState.CharOpStateDisc) {
                                    Manager.cLog("###\n###\n###\n###\n###\n###\n###\n###\n###\n###\n###\n###\n###\n###\n###\n###\n###\ndiscovery failed for discover task that is not in CharOpStateDisc");
                                }
                                DongleManager.this.notifyError(-3, "couldn't discover characteristic: " + ((String) DongleManager.this.gHostErrorCodesMap.get(status)), task.device.getDeviceId(), task.serviceUuid, task.charUuid);
                                DongleManager.this.taskQueue.dequeueTask();
                            } else {
                                return;
                            }
                        } else if (opCode == DongleManager.GATT_ReadCharValue) {
                            task = DongleManager.this.taskQueue.getTask();
                            if (task != null) {
                                if (!(task.state == CharOpState.CharOpStateRunning && task.type == CharOpType.CharOpTypeRead)) {
                                    Manager.cLog("###\n###\n###\n###\n###\n###\n###\n###\n###\n###\n###\n###\n###\n###\n###\n###\n###\nich wes a net");
                                }
                                DongleManager.this.notifyError(-3, (String) DongleManager.this.gHostErrorCodesMap.get(status), task.device.getDeviceId(), task.serviceUuid, task.charUuid);
                                DongleManager.this.taskQueue.dequeueTask();
                            } else {
                                return;
                            }
                        } else if (opCode == DongleManager.GAP_TerminateLinkRequest) {
                            DongleManager.this.notifyConnectionRequestsCanceled();
                        } else {
                            DongleManager.this.notifyError(-1000, "not implemented yet: event: " + ((String) DongleManager.this.gHciStringConstantsMap.get(event)) + " opCode: " + ((String) DongleManager.this.gHciStringConstantsMap.get(opCode)) + " Status: " + ((String) DongleManager.this.gHostErrorCodesMap.get(status)), "", "", "");
                        }
                    } else if (opCode == DongleManager.GAP_DeviceDiscoveryRequest) {
                        DongleManager.this.discoveredDevices.clear();
                        DongleManager.this.gScanning = Boolean.valueOf(true);
                        DongleManager.this.notifyScanningStateChanged(DongleManager.this.gScanning.booleanValue());
                    }
                    Manager.cLog("packetType: " + this.type + ", eventCode: " + this.eventCode + " dataLength: " + this.dataLength + "\n" + "event: " + ((String) DongleManager.this.gHciStringConstantsMap.get(event)) + "\n" + "opCode: " + ((String) DongleManager.this.gHciStringConstantsMap.get(opCode)) + "\n" + "Status: " + ((String) DongleManager.this.gHostErrorCodesMap.get(status)));
                    return;
                default:
                    Manager.cLog("event not found");
                    return;
            }
        }
    }

    static /* synthetic */ int[] $SWITCH_TABLE$de$pagecon$bleane$cc2540$CharOpTask$CharOpState() {
        int[] iArr = $SWITCH_TABLE$de$pagecon$bleane$cc2540$CharOpTask$CharOpState;
        if (iArr == null) {
            iArr = new int[CharOpState.values().length];
            try {
                iArr[CharOpState.CharOpStateDisc.ordinal()] = 2;
            } catch (NoSuchFieldError e) {
            }
            try {
                iArr[CharOpState.CharOpStateInitial.ordinal()] = 1;
            } catch (NoSuchFieldError e2) {
            }
            try {
                iArr[CharOpState.CharOpStateRunning.ordinal()] = 3;
            } catch (NoSuchFieldError e3) {
            }
            $SWITCH_TABLE$de$pagecon$bleane$cc2540$CharOpTask$CharOpState = iArr;
        }
        return iArr;
    }

    static /* synthetic */ int[] $SWITCH_TABLE$de$pagecon$bleane$cc2540$CharOpTask$CharOpType() {
        int[] iArr = $SWITCH_TABLE$de$pagecon$bleane$cc2540$CharOpTask$CharOpType;
        if (iArr == null) {
            iArr = new int[CharOpType.values().length];
            try {
                iArr[CharOpType.CharOpTypeNotify.ordinal()] = 3;
            } catch (NoSuchFieldError e) {
            }
            try {
                iArr[CharOpType.CharOpTypeRead.ordinal()] = 1;
            } catch (NoSuchFieldError e2) {
            }
            try {
                iArr[CharOpType.CharOpTypeWrite.ordinal()] = 2;
            } catch (NoSuchFieldError e3) {
            }
            $SWITCH_TABLE$de$pagecon$bleane$cc2540$CharOpTask$CharOpType = iArr;
        }
        return iArr;
    }

    void initializeContantsMap() {
        this.gHciStringConstantsMap.put(1, "HCI_InquiryCompleteEvent");
        this.gHciStringConstantsMap.put(2, "HCI_InquiryResultEvent");
        this.gHciStringConstantsMap.put(3, "HCI_ConnectionCompleteEvent");
        this.gHciStringConstantsMap.put(4, "HCI_ConnectionRequestEvent");
        this.gHciStringConstantsMap.put(5, "HCI_DisconnectionCompleteEvent");
        this.gHciStringConstantsMap.put(6, "HCI_AuthenticationCompleteEvent");
        this.gHciStringConstantsMap.put(7, "HCI_RemoteNameRequestCompleteEvent");
        this.gHciStringConstantsMap.put(8, "HCI_EncryptionChangeEvent");
        this.gHciStringConstantsMap.put(9, "HCI_ChangeConnectionLinkKeyCompleteEvent");
        this.gHciStringConstantsMap.put(10, "HCI_MasterLinkKeyCompleteEvent");
        this.gHciStringConstantsMap.put(11, "HCI_ReadRemoteSupportedFeaturesCompleteEvent");
        this.gHciStringConstantsMap.put(12, "HCI_ReadRemoteVersionInformationCompleteEvent");
        this.gHciStringConstantsMap.put(13, "HCI_QoSSetupCompleteEvent");
        this.gHciStringConstantsMap.put(14, "HCI_CommandCompleteEvent");
        this.gHciStringConstantsMap.put(15, "HCI_CommandStatusEvent");
        this.gHciStringConstantsMap.put(16, "HCI_HardwareErrorEvent");
        this.gHciStringConstantsMap.put(17, "HCI_FlushOccurredEvent");
        this.gHciStringConstantsMap.put(18, "HCI_RoleChangeEvent");
        this.gHciStringConstantsMap.put(19, "HCI_NumberOfCompletedPacketsEvent");
        this.gHciStringConstantsMap.put(20, "HCI_ModeChangeEvent");
        this.gHciStringConstantsMap.put(21, "HCI_ReturnLinkKeysEvent");
        this.gHciStringConstantsMap.put(22, "HCI_PINCodeRequestEvent");
        this.gHciStringConstantsMap.put(23, "HCI_LinkKeyRequestEvent");
        this.gHciStringConstantsMap.put(24, "HCI_LinkKeyNotificationEvent");
        this.gHciStringConstantsMap.put(25, "HCI_LoopbackCommandEvent");
        this.gHciStringConstantsMap.put(26, "HCI_DataBufferOverflowEvent");
        this.gHciStringConstantsMap.put(27, "HCI_MaxSlotsChangeEvent");
        this.gHciStringConstantsMap.put(28, "HCI_ReadClockOffsetCompleteEvent");
        this.gHciStringConstantsMap.put(29, "HCI_ConnectionPacketTypeChangedEvent");
        this.gHciStringConstantsMap.put(30, "HCI_QoSViolationEvent");
        this.gHciStringConstantsMap.put(31, "HCI_PageScanModeChangeEvent");
        this.gHciStringConstantsMap.put(32, "HCI_PageScanRepetitionModeChangeEvent");
        this.gHciStringConstantsMap.put(33, "HCI_FlowSpecificationCompleteEvent");
        this.gHciStringConstantsMap.put(34, "HCI_InquiryResultWithRSSIEvent");
        this.gHciStringConstantsMap.put(35, "HCI_ReadRemoteExtendedFeaturesCompleteEvent");
        this.gHciStringConstantsMap.put(44, "HCI_SynchronousConnectionCompleteEvent");
        this.gHciStringConstantsMap.put(45, "HCI_SynchronousConnectionChangedEvent");
        this.gHciStringConstantsMap.put(46, "HCI_SniffSubratingEvent");
        this.gHciStringConstantsMap.put(47, "HCI_ExtendedInquiryResultEvent");
        this.gHciStringConstantsMap.put(48, "HCI_EncryptionKeyRefreshCompleteEvent");
        this.gHciStringConstantsMap.put(49, "HCI_IOCapabilityRequestEvent");
        this.gHciStringConstantsMap.put(50, "HCI_IOCapabilityResponseEvent");
        this.gHciStringConstantsMap.put(51, "HCI_UserConfirmationRequestEvent");
        this.gHciStringConstantsMap.put(52, "HCI_UserPasskeyRequestEvent");
        this.gHciStringConstantsMap.put(53, "HCI_RemoteOOBDataRequestEvent");
        this.gHciStringConstantsMap.put(54, "HCI_SimplePairingCompleteEvent");
        this.gHciStringConstantsMap.put(55, "HCI_RemoteOobResponseEvent");
        this.gHciStringConstantsMap.put(56, "HCI_LinkSupervisionTimeoutChangedEvent");
        this.gHciStringConstantsMap.put(57, "HCI_EnhancedFlushCompleteEvent");
        this.gHciStringConstantsMap.put(58, "HCI_SniffRequestEvent");
        this.gHciStringConstantsMap.put(59, "HCI_UserPasskeyNotificationEvent");
        this.gHciStringConstantsMap.put(60, "HCI_KeypressNotificationEvent");
        this.gHciStringConstantsMap.put(61, "HCI_RemoteHostSupportedFeaturesNotificationEvent");
        this.gHciStringConstantsMap.put(64, "HCI_PhysicalLinkCompleteEvent");
        this.gHciStringConstantsMap.put(65, "HCI_ChannelSelectedEvent");
        this.gHciStringConstantsMap.put(66, "HCI_DisconnectionPhysicalLinkCompleteEvent");
        this.gHciStringConstantsMap.put(67, "HCI_PhysicalLinkLossEarlyWarningEvent");
        this.gHciStringConstantsMap.put(68, "HCI_PhysicalLinkRecoveryEvent");
        this.gHciStringConstantsMap.put(69, "HCI_LogicalLinkCompleteEvent");
        this.gHciStringConstantsMap.put(70, "HCI_DisconnectionLogicalLinkCompleteEvent");
        this.gHciStringConstantsMap.put(71, "HCI_FlowSpecModifyCompleteEvent");
        this.gHciStringConstantsMap.put(72, "HCI_NumberOfCompletedDataBlocksEvent");
        this.gHciStringConstantsMap.put(76, "HCI_ShortRangeModeChangeCompleteEvent");
        this.gHciStringConstantsMap.put(77, "HCI_AMP_StatusChangeEvent");
        this.gHciStringConstantsMap.put(73, "HCI_AMP_StartTestEvent");
        this.gHciStringConstantsMap.put(74, "HCI_AMP_TestEndEvent");
        this.gHciStringConstantsMap.put(75, "HCI_AMP_ReceiverReportEvent");
        this.gHciStringConstantsMap.put(62, "HCI_LE_ConnectionCompleteEvent");
        this.gHciStringConstantsMap.put(62, "HCI_LE_AdvertisingReportEvent");
        this.gHciStringConstantsMap.put(62, "HCI_LE_ConnectionUpdateCompleteEvent");
        this.gHciStringConstantsMap.put(62, "HCI_LE_ReadRemoteUsedFeaturesCompleteEvent");
        this.gHciStringConstantsMap.put(62, "HCI_LE_LongTermKeyRequestEvent");
        this.gHciStringConstantsMap.put(HCI_LE_ExtEvent, "HCI_LE_ExtEvent");
        this.gHciStringConstantsMap.put(HCIExt_SetRxGainDone, "HCIExt_SetRxGainDone");
        this.gHciStringConstantsMap.put(HCIExt_SetTxPowerDone, "HCIExt_SetTxPowerDone");
        this.gHciStringConstantsMap.put(HCIExt_OnePktPerEvtDone, "HCIExt_OnePktPerEvtDone");
        this.gHciStringConstantsMap.put(HCIExt_ClkDivideOnHaltDone, "HCIExt_ClkDivideOnHaltDone");
        this.gHciStringConstantsMap.put(HCIExt_DelayPostProcDone, "HCIExt_DelayPostProcDone");
        this.gHciStringConstantsMap.put(HCIExt_DecryptDone, "HCIExt_DecryptDone");
        this.gHciStringConstantsMap.put(HCIExt_SetLocalSupportedFeaturesDone, "HCIExt_SetLocalSupportedFeaturesDone");
        this.gHciStringConstantsMap.put(HCIExt_SetFastTxRespTimeDone, "HCIExt_SetFastTxRespTimeDone");
        this.gHciStringConstantsMap.put(HCIExt_ModemTestTxDone, "HCIExt_ModemTestTxDone");
        this.gHciStringConstantsMap.put(HCIExt_ModemHopTestTxDone, "HCIExt_ModemHopTestTxDone");
        this.gHciStringConstantsMap.put(HCIExt_ModemTestRxDone, "HCIExt_ModemTestRxDone");
        this.gHciStringConstantsMap.put(HCIExt_EndModemTestDone, "HCIExt_EndModemTestDone");
        this.gHciStringConstantsMap.put(HCIExt_SetBDADDRCmdDone, "HCIExt_SetBDADDRCmdDone");
        this.gHciStringConstantsMap.put(L2CAP_CmdReject, "L2CAP_CmdReject");
        this.gHciStringConstantsMap.put(L2CAP_InfoRsp, "L2CAP_InfoRsp");
        this.gHciStringConstantsMap.put(L2CAP_ConnParamUpdateRsp, "L2CAP_ConnParamUpdateRsp");
        this.gHciStringConstantsMap.put(ATT_ErrorRsp, "ATT_ErrorRsp");
        this.gHciStringConstantsMap.put(ATT_ExchangeMTUReq, "ATT_ExchangeMTUReq");
        this.gHciStringConstantsMap.put(ATT_ExchangeMTURsp, "ATT_ExchangeMTURsp");
        this.gHciStringConstantsMap.put(ATT_FindInfoReq, "ATT_FindInfoReq");
        this.gHciStringConstantsMap.put(ATT_FindInfoRsp, "ATT_FindInfoRsp");
        this.gHciStringConstantsMap.put(ATT_FindByTypeValueReq, "ATT_FindByTypeValueReq");
        this.gHciStringConstantsMap.put(ATT_FindByTypeValueRsp, "ATT_FindByTypeValueRsp");
        this.gHciStringConstantsMap.put(ATT_ReadByTypeReq, "ATT_ReadByTypeReq");
        this.gHciStringConstantsMap.put(ATT_ReadByTypeRsp, "ATT_ReadByTypeRsp");
        this.gHciStringConstantsMap.put(ATT_ReadReq, "ATT_ReadReq");
        this.gHciStringConstantsMap.put(ATT_ReadRsp, "ATT_ReadRsp");
        this.gHciStringConstantsMap.put(ATT_ReadBlobReq, "ATT_ReadBlobReq");
        this.gHciStringConstantsMap.put(ATT_ReadBlobRsp, "ATT_ReadBlobRsp");
        this.gHciStringConstantsMap.put(ATT_ReadMultiReq, "ATT_ReadMultiReq");
        this.gHciStringConstantsMap.put(ATT_ReadMultiRsp, "ATT_ReadMultiRsp");
        this.gHciStringConstantsMap.put(ATT_ReadByGrpTypeReq, "ATT_ReadByGrpTypeReq");
        this.gHciStringConstantsMap.put(ATT_ReadByGrpTypeRsp, "ATT_ReadByGrpTypeRsp");
        this.gHciStringConstantsMap.put(ATT_WriteReq, "ATT_WriteReq");
        this.gHciStringConstantsMap.put(ATT_WriteRsp, "ATT_WriteRsp");
        this.gHciStringConstantsMap.put(ATT_PrepareWriteReq, "ATT_PrepareWriteReq");
        this.gHciStringConstantsMap.put(ATT_PrepareWriteRsp, "ATT_PrepareWriteRsp");
        this.gHciStringConstantsMap.put(ATT_ExecuteWriteReq, "ATT_ExecuteWriteReq");
        this.gHciStringConstantsMap.put(ATT_ExecuteWriteRsp, "ATT_ExecuteWriteRsp");
        this.gHciStringConstantsMap.put(ATT_HandleValueNotification, "ATT_HandleValueNotification");
        this.gHciStringConstantsMap.put(ATT_HandleValueIndication, "ATT_HandleValueIndication");
        this.gHciStringConstantsMap.put(ATT_HandleValueConfirmation, "ATT_HandleValueConfirmation");
        this.gHciStringConstantsMap.put(GAP_DeviceInitDone, "GAP_DeviceInitDone");
        this.gHciStringConstantsMap.put(GAP_DeviceDiscoveryDone, "GAP_DeviceDiscoveryDone");
        this.gHciStringConstantsMap.put(GAP_AdvertDataUpdate, "GAP_AdvertDataUpdate");
        this.gHciStringConstantsMap.put(GAP_MakeDiscoverable, "GAP_MakeDiscoverable");
        this.gHciStringConstantsMap.put(GAP_EndDiscoverable, "GAP_EndDiscoverable");
        this.gHciStringConstantsMap.put(GAP_EstablishLink, "GAP_EstablishLink");
        this.gHciStringConstantsMap.put(GAP_TerminateLink, "GAP_TerminateLink");
        this.gHciStringConstantsMap.put(GAP_LinkParamUpdate, "GAP_LinkParamUpdate");
        this.gHciStringConstantsMap.put(GAP_RandomAddressChange, "GAP_RandomAddressChange");
        this.gHciStringConstantsMap.put(GAP_SignatureUpdate, "GAP_SignatureUpdate");
        this.gHciStringConstantsMap.put(GAP_AuthenticationComplete, "GAP_AuthenticationComplete");
        this.gHciStringConstantsMap.put(GAP_PasskeyNeeded, "GAP_PasskeyNeeded");
        this.gHciStringConstantsMap.put(GAP_SlaveRequestedSecurity, "GAP_SlaveRequestedSecurity");
        this.gHciStringConstantsMap.put(GAP_DeviceInformation, "GAP_DeviceInformation");
        this.gHciStringConstantsMap.put(GAP_BondComplete, "GAP_BondComplete");
        this.gHciStringConstantsMap.put(GAP_PairingRequested, "GAP_PairingRequested");
        this.gHciStringConstantsMap.put(GAP_HCI_ExtentionCommandStatus, "GAP_HCI_ExtentionCommandStatus");
        this.gHciStringConstantsMap.put(HCIExt_SetRxGain, "HCIExt_SetRxGain");
        this.gHciStringConstantsMap.put(HCIExt_SetTxPower, "HCIExt_SetTxPower");
        this.gHciStringConstantsMap.put(HCIExt_OnePktPerEvt, "HCIExt_OnePktPerEvt");
        this.gHciStringConstantsMap.put(HCIExt_ClkDivideOnHalt, "HCIExt_ClkDivideOnHalt");
        this.gHciStringConstantsMap.put(HCIExt_DelayPostProc, "HCIExt_DelayPostProc");
        this.gHciStringConstantsMap.put(HCIExt_Decrypt, "HCIExt_Decrypt");
        this.gHciStringConstantsMap.put(HCIExt_SetLocalSupportedFeatures, "HCIExt_SetLocalSupportedFeatures");
        this.gHciStringConstantsMap.put(HCIExt_SetFastTxRespTime, "HCIExt_SetFastTxRespTime");
        this.gHciStringConstantsMap.put(HCIExt_ModemTestTx, "HCIExt_ModemTestTx");
        this.gHciStringConstantsMap.put(HCIExt_ModemHopTestTx, "HCIExt_ModemHopTestTx");
        this.gHciStringConstantsMap.put(HCIExt_ModemTestRx, "HCIExt_ModemTestRx");
        this.gHciStringConstantsMap.put(HCIExt_EndModemTest, "HCIExt_EndModemTest");
        this.gHciStringConstantsMap.put(HCIExt_SetBDADDRCmd, "HCIExt_SetBDADDRCmd");
        this.gHciStringConstantsMap.put(L2CAP_InfoReq, "L2CAP_InfoReq");
        this.gHciStringConstantsMap.put(L2CAP_ConnParamUpdateReq, "L2CAP_ConnParamUpdateReq");
        this.gHciStringConstantsMap.put(ATT_ErrorRsp, "ATT_ErrorRsp");
        this.gHciStringConstantsMap.put(ATT_ExchangeMTUReq, "ATT_ExchangeMTUReq");
        this.gHciStringConstantsMap.put(ATT_ExchangeMTURsp, "ATT_ExchangeMTURsp");
        this.gHciStringConstantsMap.put(ATT_FindInfoReq, "ATT_FindInfoReq");
        this.gHciStringConstantsMap.put(ATT_FindInfoRsp, "ATT_FindInfoRsp");
        this.gHciStringConstantsMap.put(ATT_FindByTypeValueReq, "ATT_FindByTypeValueReq");
        this.gHciStringConstantsMap.put(ATT_FindByTypeValueRsp, "ATT_FindByTypeValueRsp");
        this.gHciStringConstantsMap.put(ATT_ReadByTypeReq, "ATT_ReadByTypeReq");
        this.gHciStringConstantsMap.put(ATT_ReadByTypeRsp, "ATT_ReadByTypeRsp");
        this.gHciStringConstantsMap.put(ATT_ReadReq, "ATT_ReadReq");
        this.gHciStringConstantsMap.put(ATT_ReadRsp, "ATT_ReadRsp");
        this.gHciStringConstantsMap.put(ATT_ReadBlobReq, "ATT_ReadBlobReq");
        this.gHciStringConstantsMap.put(ATT_ReadBlobRsp, "ATT_ReadBlobRsp");
        this.gHciStringConstantsMap.put(ATT_ReadMultiReq, "ATT_ReadMultiReq");
        this.gHciStringConstantsMap.put(ATT_ReadMultiRsp, "ATT_ReadMultiRsp");
        this.gHciStringConstantsMap.put(ATT_ReadByGrpTypeReq, "ATT_ReadByGrpTypeReq");
        this.gHciStringConstantsMap.put(ATT_ReadByGrpTypeRsp, "ATT_ReadByGrpTypeRsp");
        this.gHciStringConstantsMap.put(ATT_WriteReq, "ATT_WriteReq");
        this.gHciStringConstantsMap.put(ATT_WriteRsp, "ATT_WriteRsp");
        this.gHciStringConstantsMap.put(ATT_PrepareWriteReq, "ATT_PrepareWriteReq");
        this.gHciStringConstantsMap.put(ATT_PrepareWriteRsp, "ATT_PrepareWriteRsp");
        this.gHciStringConstantsMap.put(ATT_ExecuteWriteReq, "ATT_ExecuteWriteReq");
        this.gHciStringConstantsMap.put(ATT_ExecuteWriteRsp, "ATT_ExecuteWriteRsp");
        this.gHciStringConstantsMap.put(ATT_HandleValueNotification, "ATT_HandleValueNotification");
        this.gHciStringConstantsMap.put(ATT_HandleValueIndication, "ATT_HandleValueIndication");
        this.gHciStringConstantsMap.put(ATT_HandleValueConfirmation, "ATT_HandleValueConfirmation");
        this.gHciStringConstantsMap.put(GATT_ReadCharValue, "GATT_ReadCharValue");
        this.gHciStringConstantsMap.put(GATT_DiscCharsByUUID, "GATT_DiscCharsByUUID");
        this.gHciStringConstantsMap.put(GATT_WriteLong, "GATT_WriteLong");
        this.gHciStringConstantsMap.put(GATT_AddService, "GATT_AddService");
        this.gHciStringConstantsMap.put(GATT_DelService, "GATT_DelService");
        this.gHciStringConstantsMap.put(GATT_AddAttribute, "GATT_AddAttribute");
        this.gHciStringConstantsMap.put(GATT_WriteCharValue, "GATT_WriteCharValue");
        this.gHciStringConstantsMap.put(GAP_DeviceInit, "GAP_DeviceInit");
        this.gHciStringConstantsMap.put(GAP_ConfigDeviceAddr, "GAP_ConfigDeviceAddr");
        this.gHciStringConstantsMap.put(GAP_DeviceDiscoveryRequest, "GAP_DeviceDiscoveryRequest");
        this.gHciStringConstantsMap.put(GAP_DeviceDiscoveryCancel, "GAP_DeviceDiscoveryCancel");
        this.gHciStringConstantsMap.put(GAP_MakeDiscoverable, "GAP_MakeDiscoverable");
        this.gHciStringConstantsMap.put(GAP_UpdateAdvertisingData, "GAP_UpdateAdvertisingData");
        this.gHciStringConstantsMap.put(GAP_EndDiscoverable, "GAP_EndDiscoverable");
        this.gHciStringConstantsMap.put(GAP_EstablishLinkRequest, "GAP_EstablishLinkRequest");
        this.gHciStringConstantsMap.put(GAP_TerminateLinkRequest, "GAP_TerminateLinkRequest");
        this.gHciStringConstantsMap.put(GAP_Authenticate, "GAP_Authenticate");
        this.gHciStringConstantsMap.put(GAP_PasskeyUpdate, "GAP_PasskeyUpdate");
        this.gHciStringConstantsMap.put(GAP_SlaveSecurityRequest, "GAP_SlaveSecurityRequest");
        this.gHciStringConstantsMap.put(GAP_Signable, "GAP_Signable");
        this.gHciStringConstantsMap.put(GAP_Bond, "GAP_Bond");
        this.gHciStringConstantsMap.put(GAP_TerminateAuth, "GAP_TerminateAuth");
        this.gHciStringConstantsMap.put(GAP_SetParam, "GAP_SetParam");
        this.gHciStringConstantsMap.put(GAP_GetParam, "GAP_GetParam");
        this.gHciStringConstantsMap.put(GAP_ResolvePrivateAddr, "GAP_ResolvePrivateAddr");
        this.gHciStringConstantsMap.put(GAP_SetAdvToken, "GAP_SetAdvToken");
        this.gHciStringConstantsMap.put(GAP_RemoveAdvToken, "GAP_RemoveAdvToken");
        this.gHciStringConstantsMap.put(GAP_UpdateAdvTokens, "GAP_UpdateAdvTokens");
        this.gHciStringConstantsMap.put(GAP_BondSetParam, "GAP_BondSetParam");
        this.gHciStringConstantsMap.put(GAP_BondGetParam, "GAP_BondGetParam");
        this.gHciStringConstantsMap.put(UTIL_Reset, "UTIL_Reset");
        this.gHciStringConstantsMap.put(UTIL_NVRead, "UTIL_NVRead");
        this.gHciStringConstantsMap.put(UTIL_NVWrite, "UTIL_NVWrite");
        this.gHciStringConstantsMap.put(HCIStatus_ReadRSSI, "HCIStatus_ReadRSSI");
        this.gAttErrorConstantsMap.put(1, "The attribute handle given was not valid on this server.");
        this.gAttErrorConstantsMap.put(2, "The attribute cannot be read.");
        this.gAttErrorConstantsMap.put(3, "The attribute cannot be written.");
        this.gAttErrorConstantsMap.put(4, "The attribute PDU was invalid.");
        this.gAttErrorConstantsMap.put(5, "The attribute requires authentication before it can be read or written.");
        this.gAttErrorConstantsMap.put(6, "Attribute server does not support the request received from the client.");
        this.gAttErrorConstantsMap.put(7, "Offset specified was past the end of the attribute.");
        this.gAttErrorConstantsMap.put(8, "The attribute requires authorization before it can be read or written.");
        this.gAttErrorConstantsMap.put(9, "Too many prepare writes have been queued.");
        this.gAttErrorConstantsMap.put(10, "No attribute found within the given attribute handle range.");
        this.gAttErrorConstantsMap.put(11, "The attribute cannot be read or written using the Read Blob Request.");
        this.gAttErrorConstantsMap.put(12, "The Encryption Key Size used for encrypting this link is insufficient.");
        this.gAttErrorConstantsMap.put(13, "The attribute value length is invalid for the operation.");
        this.gAttErrorConstantsMap.put(14, "The attribute request that was requested has encountered an error that was unlikely, and therefore could not be completed as requested.");
        this.gAttErrorConstantsMap.put(15, "The attribute requires encryption before it can be read or written.");
        this.gAttErrorConstantsMap.put(16, "The attribute type is not a supported grouping attribute as defined by a higher layer specification.");
        this.gAttErrorConstantsMap.put(17, "Insufficient Resources to complete the request.");
        this.gAttErrorConstantsMap.put(128, "The attribute value is invalid for the operation.");
        this.gHostErrorCodesMap.put(0, "SUCCESS");
        this.gHostErrorCodesMap.put(1, "FAILURE");
        this.gHostErrorCodesMap.put(2, "INVALIDPARAMETER");
        this.gHostErrorCodesMap.put(3, "INVALID_TASK");
        this.gHostErrorCodesMap.put(4, "MSG_BUFFER_NOT_AVAIL");
        this.gHostErrorCodesMap.put(5, "INVALID_MSG_POINTER");
        this.gHostErrorCodesMap.put(6, "INVALID_EVENT_ID");
        this.gHostErrorCodesMap.put(7, "INVALID_INTERRUPT_ID");
        this.gHostErrorCodesMap.put(8, "NO_TIMER_AVAIL");
        this.gHostErrorCodesMap.put(9, "NV_ITEM_UNINIT");
        this.gHostErrorCodesMap.put(10, "NV_OPER_FAILED");
        this.gHostErrorCodesMap.put(11, "INVALID_MEM_SIZE");
        this.gHostErrorCodesMap.put(12, "NV_BAD_ITEM_LEN");
        this.gHostErrorCodesMap.put(16, "bleNotReady");
        this.gHostErrorCodesMap.put(17, "bleAlreadyInRequestedMode");
        this.gHostErrorCodesMap.put(18, "bleIncorrectMode");
        this.gHostErrorCodesMap.put(19, "bleMemAllocError");
        this.gHostErrorCodesMap.put(20, "bleNotConnected");
        this.gHostErrorCodesMap.put(21, "bleNoResources");
        this.gHostErrorCodesMap.put(22, "blePending");
        this.gHostErrorCodesMap.put(23, "bleTimeout");
        this.gHostErrorCodesMap.put(24, "bleInvalidRange");
        this.gHostErrorCodesMap.put(25, "bleLinkEncrypted");
        this.gHostErrorCodesMap.put(26, "bleProcedureComplete");
        this.gHostErrorCodesMap.put(48, "bleGAPUserCanceled");
        this.gHostErrorCodesMap.put(49, "bleGAPConnNotAcceptable");
        this.gHostErrorCodesMap.put(50, "bleGAPBondRejected");
        this.gHostErrorCodesMap.put(64, "bleInvalidPDU");
        this.gHostErrorCodesMap.put(65, "bleInsufficientAuthen");
        this.gHostErrorCodesMap.put(66, "bleInsufficientEncrypt");
        this.gHostErrorCodesMap.put(67, "bleInsufficientKeySize");
        this.gHostErrorCodesMap.put(HCI_LE_ExtEvent, "INVALID_TASK_ID");
    }

    private void notifyDataReceived(String id, String serviceUUID, String charUUID, byte[] data) {
        final String str = id;
        final String str2 = serviceUUID;
        final String str3 = charUUID;
        final byte[] bArr = data;
        new Handler(Looper.getMainLooper()).post(new Runnable() {
            public void run() {
                DongleManager.this.listener.dataReceived(str, str2, str3, bArr);
            }
        });
    }

    private void notifyDataWritten(final String id, final String serviceUUID, final String charUUID) {
        new Handler(Looper.getMainLooper()).post(new Runnable() {
            public void run() {
                DongleManager.this.listener.dataWritten(id, serviceUUID, charUUID);
            }
        });
    }

    private void notifyDeviceConnected(final String id, final String primaryServiceUUID) {
        new Handler(Looper.getMainLooper()).post(new Runnable() {
            public void run() {
                DongleManager.this.listener.deviceConnected(id, primaryServiceUUID);
            }
        });
    }

    private void notifyDeviceDiscovered(final String id, final String primaryServiceUUID, final String name) {
        new Handler(Looper.getMainLooper()).post(new Runnable() {
            public void run() {
                DongleManager.this.listener.deviceDiscovered(id, primaryServiceUUID, name);
            }
        });
    }

    private void notifyError(int errCode, String message, String id, String serviceUUID, String charUUID) {
        final int i = errCode;
        final String str = message;
        final String str2 = id;
        final String str3 = serviceUUID;
        final String str4 = charUUID;
        new Handler(Looper.getMainLooper()).post(new Runnable() {
            public void run() {
                DongleManager.this.listener.error(i, str, str2, str3, str4);
            }
        });
    }

    private void notifyDeviceDisconnected(final String id) {
        new Handler(Looper.getMainLooper()).post(new Runnable() {
            public void run() {
                DongleManager.this.listener.deviceDisconnected(id);
            }
        });
    }

    public void notifyInfo(final String info) {
        new Handler(Looper.getMainLooper()).post(new Runnable() {
            public void run() {
                DongleManager.this.listener.info(info);
            }
        });
    }

    private void notifyBleEnabledStateChanged(final boolean enabled) {
        new Handler(Looper.getMainLooper()).post(new Runnable() {
            public void run() {
                DongleManager.this.listener.bleEnabledStateChanged(enabled);
            }
        });
    }

    private void notifyScanningStateChanged(final boolean scanningState) {
        new Handler(Looper.getMainLooper()).post(new Runnable() {
            public void run() {
                DongleManager.this.listener.scanningStateChanged(scanningState);
            }
        });
    }

    private void notifyConnectionRequestsCanceled() {
        new Handler(Looper.getMainLooper()).post(new Runnable() {
            public void run() {
                DongleManager.this.listener.connectionRequestsCanceled();
            }
        });
    }

    public static Boolean checkBluetoothAddress(String address) {
        if (address.length() != 17) {
            return Boolean.valueOf(false);
        }
        for (int i = 0; i < 17; i++) {
            char c = address.charAt(i);
            switch (i % 3) {
                case 0:
                case 1:
                    if ((c < '0' || c > '9') && ((c < 'A' || c > 'F') && (c < 'a' || c > 'f'))) {
                        return Boolean.valueOf(false);
                    }
                case 2:
                    if (c == ':') {
                        break;
                    }
                    return Boolean.valueOf(false);
                default:
                    break;
            }
        }
        return Boolean.valueOf(true);
    }

    public static String createUuid(byte[] data) {
        int length = data.length;
        String uuidString = dataToHexString(data);
        if (length == 2 || length == 4 || length != 16) {
            return uuidString;
        }
        String s1 = uuidString.substring(0, 8);
        String s2 = uuidString.substring(8, 12);
        String s3 = uuidString.substring(12, 16);
        String s4 = uuidString.substring(16, 20);
        return new StringBuilder(String.valueOf(s1)).append("-").append(s2).append("-").append(s3).append("-").append(s4).append("-").append(uuidString.substring(20, 32)).toString();
    }

    public static String dataToFormattedHexString(byte[] data) {
        char[] hexString = new char[(data.length * 2)];
        for (int j = 0; j < data.length; j++) {
            int v = data[j] & HCI_LE_ExtEvent;
            hexString[j * 2] = hexArray[v >>> 4];
            hexString[(j * 2) + 1] = hexArray[v & 15];
        }
        return new String(hexString);
    }

    public static String dataToHexString(byte[] data) {
        char[] hexString = new char[(data.length * 2)];
        for (int j = 0; j < data.length; j++) {
            int v = data[j] & HCI_LE_ExtEvent;
            hexString[j * 2] = hexArray[v >>> 4];
            hexString[(j * 2) + 1] = hexArray[v & 15];
        }
        return new String(hexString);
    }

    public static DongleManager create(Activity activity, DongleManagerListener listener) {
        if (instance == null) {
            instance = new DongleManager(activity, listener);
        }
        return instance;
    }

    private DongleManager(Activity activity, DongleManagerListener listener) {
        byte[] bArr = new byte[4];
        bArr[0] = (byte) 1;
        bArr[1] = Byte.MIN_VALUE;
        bArr[2] = (byte) -2;
        this.CMD_HCI_HardReset = bArr;
        bArr = new byte[42];
        this.CMD_GAP_DeviceInit = bArr;
        bArr = new byte[7];
        bArr[0] = (byte) 1;
        bArr[1] = (byte) 4;
        bArr[2] = (byte) -2;
        bArr[3] = (byte) 3;
        bArr[4] = (byte) 3;
        bArr[5] = (byte) 1;
        this.CMD_GAP_DeviceDiscoveryRequest = bArr;
        bArr = new byte[4];
        bArr[0] = (byte) 1;
        bArr[1] = (byte) 5;
        bArr[2] = (byte) -2;
        this.CMD_GAP_DeviceDiscoveryCancel = bArr;
        bArr = new byte[4];
        bArr[0] = (byte) 1;
        bArr[1] = (byte) 16;
        bArr[2] = (byte) 32;
        this.CMD_CLEAR_WHITELIST = bArr;
        bArr = new byte[4];
        bArr[0] = (byte) 1;
        bArr[1] = (byte) 15;
        bArr[2] = (byte) 32;
        this.CMD_READ_WHITELIST_SIZE = bArr;
        bArr = new byte[11];
        this.CMD_ADD_TO_WHITELIST = bArr;
        bArr = new byte[13];
        bArr[0] = (byte) 1;
        bArr[1] = (byte) 9;
        bArr[2] = (byte) -2;
        bArr[3] = (byte) 9;
        bArr[5] = (byte) 1;
        this.CMD_GAP_ESTABLISH = bArr;
        bArr = new byte[6];
        bArr[0] = (byte) 1;
        bArr[1] = (byte) 10;
        bArr[2] = (byte) -2;
        bArr[3] = (byte) 2;
        this.CMD_GAP_TERMINATE_LINK_REQUEST = bArr;
        this.CMD_GAP_TERMINATE_ESTABLISH_LINK_REQUEST_REQUEST = new byte[]{(byte) 1, (byte) 10, (byte) -2, (byte) 2, (byte) -2, (byte) -1};
        bArr = new byte[7];
        bArr[0] = (byte) 1;
        bArr[1] = (byte) 48;
        bArr[2] = (byte) -2;
        bArr[3] = (byte) 3;
        bArr[4] = (byte) 21;
        bArr[5] = (byte) 16;
        this.CMD_GAP_SetParam1 = bArr;
        bArr = new byte[7];
        bArr[0] = (byte) 1;
        bArr[1] = (byte) 48;
        bArr[2] = (byte) -2;
        bArr[3] = (byte) 3;
        bArr[4] = (byte) 22;
        bArr[5] = (byte) 16;
        this.CMD_GAP_SetParam2 = bArr;
        bArr = new byte[7];
        bArr[0] = (byte) 1;
        bArr[1] = (byte) 48;
        bArr[2] = (byte) -2;
        bArr[3] = (byte) 3;
        bArr[4] = (byte) 26;
        this.CMD_GAP_SetParam3 = bArr;
        this.CMD_GAP_SetParam4 = new byte[]{(byte) 1, (byte) 48, (byte) -2, (byte) 3, (byte) 25, (byte) -12, (byte) 1};
        this.CMD_GAP_SetParam5 = new byte[]{(byte) 1, (byte) 48, (byte) -2, (byte) 3, (byte) 2, (byte) -2, (byte) -1};
        this.CMD_GAP_SetParam6 = new byte[]{(byte) 1, (byte) 48, (byte) -2, (byte) 3, (byte) 3, (byte) -2, (byte) -1};
        bArr = new byte[8];
        this.CMD_GAP_ReadCharacteristic = bArr;
        bArr = new byte[12];
        bArr[0] = (byte) 1;
        bArr[1] = (byte) -120;
        bArr[2] = (byte) -3;
        bArr[3] = (byte) 8;
        bArr[6] = (byte) 1;
        bArr[8] = (byte) -1;
        bArr[9] = (byte) -1;
        this.CMD_GAP_DiscoverCharacteristicByUuid = bArr;
        this.discoveredDevices = new TS_BleDeviceList();
        this.knownDevices = new TS_BleDeviceList();
        this.whiteList = new TS_BleDeviceList();
        this.serviceUuids = new TS_StringList();
        this.taskQueue = new CharOpTaskQueue();
        this.gScanning = Boolean.valueOf(false);
        this.receiveHandler = new DataReceiveHandler();
        initializeContantsMap();
        this.activity = activity;
        this.listener = listener;
        initialise();
    }

    private void chexecuteTask() {
        if (this.taskQueue != null) {
            CharOpTask task = this.taskQueue.getTask();
            if (task != null) {
                switch ($SWITCH_TABLE$de$pagecon$bleane$cc2540$CharOpTask$CharOpState()[task.state.ordinal()]) {
                    case 1:
                        BleDevice device = task.device;
                        Integer charHandle = device.getHandleForCharacteristicUuid(task.charUuid);
                        if (charHandle != null) {
                            task.state = CharOpState.CharOpStateRunning;
                            switch ($SWITCH_TABLE$de$pagecon$bleane$cc2540$CharOpTask$CharOpType()[task.type.ordinal()]) {
                                case 1:
                                    readCharacteristicValue(task.device.getConnectionHandle(), charHandle.intValue());
                                    return;
                                case 2:
                                    writeCharactersiticValue(task.device.getConnectionHandle(), charHandle.intValue(), task.bytesToWrite);
                                    return;
                                case 3:
                                    setNotify(task.device.getConnectionHandle(), charHandle.intValue(), task.enableNotify);
                                    return;
                                default:
                                    return;
                            }
                        }
                        task.state = CharOpState.CharOpStateDisc;
                        this.dongle.sendData(getDiscoverCharacteristicByUuidCommand(device.getConnectionHandle(), task.charUuid));
                        return;
                    case 2:
                        if (task.device.getHandleForCharacteristicUuid(task.charUuid) != null) {
                            task.state = CharOpState.CharOpStateRunning;
                            switch ($SWITCH_TABLE$de$pagecon$bleane$cc2540$CharOpTask$CharOpType()[task.type.ordinal()]) {
                                case 1:
                                    readCharacteristicValue(task.device.getConnectionHandle(), task.charHandle);
                                    return;
                                case 2:
                                    writeCharactersiticValue(task.device.getConnectionHandle(), task.charHandle, task.bytesToWrite);
                                    return;
                                case 3:
                                    setNotify(task.device.getConnectionHandle(), task.charHandle, task.enableNotify);
                                    return;
                                default:
                                    return;
                            }
                        }
                        return;
                    default:
                        return;
                }
            }
        }
    }

    private byte[] getDiscoverCharacteristicByUuidCommand(int connHandle, String charUuid) {
        int i;
        charUuid = charUuid.replace("-", "");
        byte[] charUuidByteArray = new byte[(charUuid.length() / 2)];
        for (i = 0; i + 1 < charUuid.length(); i += 2) {
            charUuidByteArray[i / 2] = (byte) ((Character.digit(charUuid.charAt(i), 16) << 4) + Character.digit(charUuid.charAt(i + 1), 16));
        }
        int cmdLength = charUuidByteArray.length + 10;
        byte[] cmd = new byte[cmdLength];
        cmd[0] = (byte) 1;
        cmd[1] = (byte) -120;
        cmd[2] = (byte) -3;
        cmd[3] = (byte) (cmdLength - 4);
        cmd[4] = (byte) (connHandle & HCI_LE_ExtEvent);
        cmd[5] = (byte) ((connHandle >> 8) & HCI_LE_ExtEvent);
        cmd[6] = (byte) 1;
        cmd[7] = (byte) 0;
        cmd[8] = (byte) -1;
        cmd[9] = (byte) -1;
        for (i = 0; i < charUuidByteArray.length; i++) {
            cmd[(cmdLength - 1) - i] = charUuidByteArray[i];
        }
        return cmd;
    }

    private void readCharacteristicValue(int connHandle, int characteristicHandle) {
        int characteristicValueHandle = characteristicHandle + 1;
        this.CMD_GAP_ReadCharacteristic[4] = (byte) (connHandle & HCI_LE_ExtEvent);
        this.CMD_GAP_ReadCharacteristic[5] = (byte) ((connHandle >> 8) & HCI_LE_ExtEvent);
        this.CMD_GAP_ReadCharacteristic[6] = (byte) (characteristicValueHandle & HCI_LE_ExtEvent);
        this.CMD_GAP_ReadCharacteristic[7] = (byte) ((characteristicValueHandle >> 8) & HCI_LE_ExtEvent);
        this.dongle.sendData(this.CMD_GAP_ReadCharacteristic);
    }

    private void writeCharactersiticValue(int connHandle, int characteristicHandle, byte[] data) {
        int characteristicValueHandle = characteristicHandle + 1;
        int length = data.length;
        byte[] packet = new byte[(length + 8)];
        packet[0] = (byte) 1;
        packet[1] = (byte) -110;
        packet[2] = (byte) -3;
        packet[3] = (byte) (length + 4);
        packet[4] = (byte) (connHandle & HCI_LE_ExtEvent);
        packet[5] = (byte) ((connHandle >> 8) & HCI_LE_ExtEvent);
        packet[6] = (byte) (characteristicValueHandle & HCI_LE_ExtEvent);
        packet[7] = (byte) ((characteristicValueHandle >> 8) & HCI_LE_ExtEvent);
        for (int i = 0; i < length; i++) {
            packet[i + 8] = data[i];
        }
        this.dongle.sendData(packet);
    }

    private void setNotify(int connHandle, int characteristicHandle, Boolean notify) {
        byte[] data = new byte[2];
        if (notify.booleanValue()) {
            data[0] = (byte) 1;
            data[1] = (byte) 0;
        } else {
            data[0] = (byte) 0;
            data[1] = (byte) 0;
        }
        writeCharactersiticValue(connHandle, characteristicHandle + 1, data);
    }

    public void initialise() {
        this.gScanning = Boolean.valueOf(false);
        this.knownDevices.clear();
        this.discoveredDevices.clear();
        this.whiteList.clear();
        this.taskQueue.clear();
        if (isBleSupported()) {
            if (this.usbManager == null) {
                this.usbManager = UsbManager.createManager(this.activity, this);
                ArrayList<VIDPIDPair> supportedDevices = new ArrayList();
                supportedDevices.add(new VIDPIDPair(1105, 5802));
                this.usbManager.setSupportedDeviceIDs(supportedDevices);
            }
            if (this.dongle == null) {
                List<SigmaUsbDevice> connectedDevices = this.usbManager.getConnectedDevices();
                if (connectedDevices == null || connectedDevices.size() <= 0) {
                    List<SigmaUsbDevice> attachedDevices = this.usbManager.getAttachedDevices();
                    if (attachedDevices != null && attachedDevices.size() > 0) {
                        this.usbManager.connectDevice(((SigmaUsbDevice) attachedDevices.get(0)).getID().intValue());
                        return;
                    }
                    return;
                }
                this.dongle = (SigmaUsbDevice) connectedDevices.get(0);
                initializeDongle();
                return;
            }
            chexecuteTask();
        }
    }

    private void initializeDongle() {
        if (this.dongle != null) {
            this.dongle.sendData(null);
            this.dongle.sendData(this.CMD_HCI_HardReset);
            this.dongle.sendData(null);
            this.dongle.sendData(this.CMD_GAP_DeviceInit);
            this.dongle.sendData(null);
            this.dongle.sendData(this.CMD_GAP_SetParam1);
            this.dongle.sendData(this.CMD_GAP_SetParam2);
            this.dongle.sendData(this.CMD_GAP_SetParam3);
            this.dongle.sendData(this.CMD_GAP_SetParam4);
            this.dongle.sendData(this.CMD_GAP_SetParam5);
            this.dongle.sendData(this.CMD_GAP_SetParam6);
            notifyBleEnabledStateChanged(true);
            chexecuteTask();
        }
    }

    public void finalise(boolean shutDown) {
        this.gScanning = Boolean.valueOf(false);
        if (this.dongle != null) {
            this.dongle.sendData(this.CMD_HCI_HardReset);
        }
        for (int i = 0; i < this.knownDevices.getSize(); i++) {
            BleDevice bleDevice = this.knownDevices.getDeviceAtIndex(i);
            if (bleDevice.isConnected().booleanValue()) {
                notifyDeviceDisconnected(bleDevice.getDeviceId());
            }
        }
        this.knownDevices.clear();
        this.discoveredDevices.clear();
        this.whiteList.clear();
        this.taskQueue.clear();
        if (shutDown) {
            this.usbManager.shutDown();
            this.dongle = null;
            this.usbManager = null;
        }
    }

    public void reset() {
        this.dongle = null;
        finalise(false);
        initialise();
    }

    public boolean isBleSupported() {
        return Boolean.valueOf(this.activity.getPackageManager().hasSystemFeature("android.hardware.usb.host")).booleanValue();
    }

    public boolean isBleEnabled() {
        return this.dongle != null;
    }

    public int askUserToEnableBle() {
        return -20;
    }

    public int startScan(List<String> serviceUUIDs) {
        if (!isBleEnabled()) {
            return -2;
        }
        this.serviceUuids.clear();
        for (String serviceUuid : serviceUUIDs) {
            this.serviceUuids.add(serviceUuid);
        }
        this.gScanning = Boolean.valueOf(true);
        this.dongle.sendData(this.CMD_GAP_DeviceDiscoveryRequest);
        return 0;
    }

    public void stopScan() {
        this.dongle.sendData(this.CMD_GAP_DeviceDiscoveryCancel);
    }

    public int connect(List<String> deviceIds) {
        if (!isBleEnabled()) {
            return -2;
        }
        if (this.gScanning.booleanValue()) {
            return -21;
        }
        Boolean updatePending = Boolean.valueOf(false);
        if (this.whiteList.getSize() > 0) {
            this.whiteList.clear();
            updatePending = Boolean.valueOf(true);
        }
        for (String deviceId : deviceIds) {
            if (!checkBluetoothAddress(deviceId.toUpperCase(Locale.US)).booleanValue()) {
                return -4;
            }
            BleDevice device = this.knownDevices.findDevice(deviceId);
            if (device == null) {
                device = new BleDevice();
                device.setDeviceId(deviceId);
                this.knownDevices.addDevice(device);
            }
            this.whiteList.addDevice(device);
        }
        if (this.whiteList.getSize() <= 0 || updatePending.booleanValue()) {
            return 0;
        }
        this.dongle.sendData(this.CMD_CLEAR_WHITELIST);
        return 0;
    }

    public int cancelConnectionRequests() {
        if (!isBleEnabled()) {
            return -2;
        }
        if (this.gScanning.booleanValue()) {
            return -21;
        }
        this.dongle.sendData(this.CMD_GAP_TERMINATE_ESTABLISH_LINK_REQUEST_REQUEST);
        this.dongle.sendData(null);
        return 0;
    }

    public int disconnect(String id) {
        if (!isBleEnabled()) {
            return -2;
        }
        if (!checkBluetoothAddress(id.toUpperCase(Locale.US)).booleanValue()) {
            return -4;
        }
        BleDevice device = this.knownDevices.findDevice(id);
        if (device != null && device.isConnected().booleanValue()) {
            int value = device.getConnectionHandle();
            byte b2 = (byte) (value >> 8);
            this.CMD_GAP_TERMINATE_LINK_REQUEST[4] = (byte) value;
            this.CMD_GAP_TERMINATE_LINK_REQUEST[5] = b2;
            this.dongle.sendData(this.CMD_GAP_TERMINATE_LINK_REQUEST);
        }
        return 0;
    }

    public int read(String id, String serviceUUID, String charUUID) {
        if (!isBleEnabled()) {
            return -2;
        }
        if (!checkBluetoothAddress(id.toUpperCase(Locale.US)).booleanValue()) {
            return -4;
        }
        BleDevice device = this.knownDevices.findDevice(id);
        if (device == null || !device.isConnected().booleanValue()) {
            return -6;
        }
        CharOpTask cot = new CharOpTask();
        cot.device = device;
        cot.serviceUuid = serviceUUID;
        cot.charUuid = charUUID;
        cot.type = CharOpType.CharOpTypeRead;
        this.taskQueue.queueTask(cot);
        chexecuteTask();
        return 0;
    }

    public int write(String id, String serviceUUID, String charUUID, byte[] data) {
        if (!isBleEnabled()) {
            return -2;
        }
        if (!checkBluetoothAddress(id.toUpperCase(Locale.US)).booleanValue()) {
            return -4;
        }
        BleDevice device = this.knownDevices.findDevice(id);
        if (device == null || !device.isConnected().booleanValue()) {
            return -6;
        }
        CharOpTask cot = new CharOpTask();
        cot.device = device;
        cot.serviceUuid = serviceUUID;
        cot.charUuid = charUUID;
        cot.type = CharOpType.CharOpTypeWrite;
        cot.bytesToWrite = data;
        this.taskQueue.queueTask(cot);
        chexecuteTask();
        return 0;
    }

    public int setNotify(String id, String serviceUUID, String charUUID, boolean enabled) {
        if (!isBleEnabled()) {
            return -2;
        }
        if (!checkBluetoothAddress(id.toUpperCase(Locale.US)).booleanValue()) {
            return -4;
        }
        BleDevice device = this.knownDevices.findDevice(id);
        if (device == null || !device.isConnected().booleanValue()) {
            return -6;
        }
        CharOpTask cot = new CharOpTask();
        cot.device = device;
        cot.serviceUuid = serviceUUID;
        cot.charUuid = charUUID;
        cot.type = CharOpType.CharOpTypeNotify;
        cot.enableNotify = Boolean.valueOf(enabled);
        this.taskQueue.queueTask(cot);
        chexecuteTask();
        return 0;
    }

    public void dataReceived(int deviceID, byte[] data) {
        this.receiveHandler.dataReceived(data);
    }

    public void deviceConnected(SigmaUsbDevice sd) {
        if (this.dongle == null) {
            this.dongle = sd;
            initializeDongle();
        }
    }

    public void deviceDisconnected(SigmaUsbDevice sd) {
        if (this.dongle != null && this.dongle == sd) {
            this.dongle = null;
            finalise(false);
            notifyBleEnabledStateChanged(false);
        }
    }

    public void deviceConnectionLost(SigmaUsbDevice sd) {
        if (this.dongle != null && this.dongle == sd) {
            this.dongle = null;
            finalise(false);
            notifyBleEnabledStateChanged(false);
        }
    }

    public void deviceConnectionFailed(SigmaUsbDevice sd) {
    }

    public void deviceAttached(SigmaUsbDevice sd) {
        if (this.dongle == null) {
            this.usbManager.connectDevice(sd.getID().intValue());
        }
    }

    public void deviceDetached(SigmaUsbDevice sd) {
        if (this.dongle != null && this.dongle == sd) {
            this.dongle = null;
            finalise(false);
            notifyBleEnabledStateChanged(false);
        }
    }

    public void debugInfo(String info) {
    }
}
