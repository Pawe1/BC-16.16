//class Gps10Handler
package handler 
{
    import __AS3__.vec.*;
    import com.logging.*;
    import core.activities.*;
    import core.settings.*;
    import core.totals.*;
    import core.units.*;
    import debug.*;
    import decoder.*;
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;
    import handler.event.*;
    import handler.interfaces.*;
    import helper.*;
    import service.*;
    import service.event.*;
    import service.nfc.*;
    import service.usb.event.*;
    import utils.*;
    
    public class Gps10Handler extends handler.UnitHandler implements handler.interfaces.IHandlerDispose, handler.interfaces.IHandlerNfc
    {
        public function Gps10Handler()
        {
            _updateFlagData = UPDATE_FLAGS_DEFAULT_DATA;
            super();
            return;
        }

        internal function generateUpdateFlagData(arg1:uint, arg2:Boolean=false):Array
        {
            if (arg2) 
            {
                _updateFlagData = UPDATE_FLAGS_DEFAULT_DATA;
            }
            var loc4:*=arg1;
            while (3 === loc4) 
            {
                var loc3:*=0;
                loc4 = _updateFlagData[loc3] | arg1;
                _updateFlagData[loc3] = loc4;
            }
        }

        public override function get unit():core.units.Unit
        {
            return _unit;
        }

        public override function set unit(arg1:core.units.Unit):void
        {
            if (!(arg1 is core.units.UnitGps10)) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 548, "GPS10Handler > load data from unit: wrong unit"));
                return;
            }
            if (_unit != null) 
            {
                debug.Debug.debug("Unit changed from:\t" + _unit.type.toString() + "\tto:\t" + arg1.type.toString());
            }
            else 
            {
                debug.Debug.debug("Unit initialized:\t" + arg1.type.toString());
            }
            _unit = arg1 as core.units.UnitGps10;
            return;
        }

        internal function get AGPS_FILE_URL():String
        {
            var loc1:*="http://offline-live1.services.u-blox.com/GetOfflineData.ashx?token=DU-wSuNZVESn2ngmYtCZAA;gnss=gps;period=2;resolution=1";
            var loc2:*=service.DeviceCommunicationHandler.getInstance().connectionMode;
            while ("connectionModeNFC" === loc2) 
            {
                loc1 = "http://online-live1.services.u-blox.com/GetOnlineData.ashx?token=DU-wSuNZVESn2ngmYtCZAA;gnss=gps;datatype=eph,alm,aux,pos";
            }
            loc1 = _loadAgpsFileRetryCount != 0 ? "http://offline-live2.services.u-blox.com/GetOfflineData.ashx?token=DU-wSuNZVESn2ngmYtCZAA;gnss=gps;period=2;resolution=1" : "http://offline-live1.services.u-blox.com/GetOfflineData.ashx?token=DU-wSuNZVESn2ngmYtCZAA;gnss=gps;period=2;resolution=1";
            return loc1;
        }

        public static function getInternalFWString(arg1:String):String
        {
            var loc1:*=arg1.split(".");
            var loc2:*="0";
            if (loc1.length == 2) 
            {
                loc2 = loc1[0] + "";
                if (loc1[1] < 10) 
                {
                    loc2 = loc2 + "0";
                }
                loc2 = loc2 + loc1[1];
                loc2 = loc2 + "00";
            }
            return loc2;
        }

        internal function onAgpsFileLoaded(arg1:flash.events.Event):void
        {
            _agpsFileLoaded = true;
            sendNextStep();
            return;
        }

        internal function loadAgpsFile():void
        {
            if (_loadAgpsFileRetryCount > 1) 
            {
                return;
            }
            var loc3:*=AGPS_FILE_URL;
            debug.Debug.debug("LOADING AGPS FILE: " + loc3);
            var loc1:*=new flash.net.URLRequest(loc3);
            loc1.url = loc3;
            var loc2:*=new flash.net.URLStream();
            loc2.addEventListener("complete", onURLStreamComplete);
            loc2.addEventListener("ioError", onURLStreamIOError);
            loc2.addEventListener("securityError", onURLStreamSecurityError);
            loc2.load(loc1);
            return;
        }

        internal function onURLStreamComplete(arg1:flash.events.Event):void
        {
            var loc3:*=0;
            var loc2:*=arg1.target as flash.net.URLStream;
            loc2.removeEventListener("complete", onURLStreamComplete);
            loc2.removeEventListener("ioError", onURLStreamIOError);
            loc2.removeEventListener("securityError", onURLStreamSecurityError);
            var loc1:*=Math.min(loc2.bytesAvailable, 32760);
            debug.Debug.debug("preparing " + loc1 + " bytes of AGPS data");
            _tmpData = decoder.Gps10Decoder.fillArray(loc1);
            while (loc2.bytesAvailable && loc3 < loc1) 
            {
                _tmpData[loc3++] = loc2.readUnsignedByte();
            }
            dispatchEvent(new flash.events.Event("eventAgpsFileLoaded"));
            return;
        }

        internal function dispatchURLStreamError(arg1:String):void
        {
            dispatchEvent(new flash.events.Event("downloadError"));
            dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 1058, "FirmwareUpdateHandler > The download of the A-GPS update file failed. " + arg1));
            ++_loadAgpsFileRetryCount;
            loadAgpsFile();
            return;
        }

        internal function get _myGps10Unit():core.units.UnitGps10
        {
            return unit as core.units.UnitGps10;
        }

        internal function onURLStreamIOError(arg1:flash.events.IOErrorEvent):void
        {
            var loc1:*=arg1.target as flash.net.URLStream;
            loc1.removeEventListener("complete", onURLStreamComplete);
            loc1.removeEventListener("ioError", onURLStreamIOError);
            loc1.removeEventListener("securityError", onURLStreamSecurityError);
            dispatchURLStreamError(arg1.text);
            return;
        }

        internal function onURLStreamSecurityError(arg1:flash.events.SecurityErrorEvent):void
        {
            var loc1:*=arg1.target as flash.net.URLStream;
            loc1.removeEventListener("complete", onURLStreamComplete);
            loc1.removeEventListener("ioError", onURLStreamIOError);
            loc1.removeEventListener("securityError", onURLStreamSecurityError);
            dispatchURLStreamError(arg1.text);
            return;
        }

        internal function checkUnit(arg1:core.units.Unit):Boolean
        {
            if (arg1 == null) 
            {
                clear();
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 10001, "CurrentUnitHandler > onLoaded: Can not create unit"));
                return false;
            }
            if (_myGps10Unit.type != arg1.type) 
            {
                clear();
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 10010, "Topline2016Handler > onLoaded: Unit do not match"));
                dispatchEvent(new flash.events.Event("eventUnitTypeDoNotMatch"));
                return false;
            }
            if (currentType != "loadUnitInformation") 
            {
                if (_myGps10Unit.serialNumber != arg1.serialNumber) 
                {
                    clear();
                    dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 10010, "Topline2016Handler > onLoaded: Unit do not match"));
                    dispatchEvent(new flash.events.Event("eventUnitSerialNumberDoNotMatch"));
                    return false;
                }
            }
            return true;
        }

        internal function onLoaded(arg1:service.usb.event.DeviceDataCompleteEvent):void
        {
            var loc2:*=null;
            var loc6:*=null;
            var loc3:*=null;
            var loc7:*=null;
            var loc10:*=null;
            var loc1:*=null;
            var loc11:*=null;
            var loc5:*=null;
            var loc8:*=null;
            var loc12:*=null;
            var loc13:*=NaN;
            ++_onLoadedCount;
            debug.Debug.debug("onLoaded (" + _onLoadedCount + ") command: " + arg1.command + " \t currentType: " + currentType + "\t Unit: " + _myGps10Unit.type.toString());
            service.DeviceCommunicationHandler.getInstance().checkUnitConnected = true;
            var loc4:*=0;
            var loc9:*=arg1.data as Array;
        }

        internal function sendNextStep(arg1:Boolean=false):void
        {
            var loc1:*=_sendStep;
            if (arg1) 
            {
                _sendStep = 4;
            }
            else 
            {
                ++_sendStep;
            }
            debug.Debug.debug(loc1 + " => " + _sendStep);
            sendToDC(currentType);
            return;
        }

        internal function updateGetLogDataProgress():void
        {
            var loc1:*=100 * _myGps10Unit.loadedLogs.length / _totalLogsToLoad;
            var loc3:*=_myGps10Unit.loadedLogs.length;
            var loc2:*=_totalLogsToLoad;
            dispatchEvent(new handler.event.ProgressStatusEvent("progressbarEvent", loc1, loc3, loc2));
            return;
        }

        internal function encodeEepromAndDispatchCompleteEvent(arg1:core.units.Unit):void
        {
            var loc2:*=null;
            var loc1:*=null;
            var loc3:*=currentType;
            while ("loadUnitInformation" === loc3) 
            {
                _myGps10Unit.serialNumber = arg1.serialNumber;
                _myGps10Unit.softwareRevision = arg1.softwareRevision;
                dispatchEvent(new handler.event.UnitEvent("unitInitialisedEvent", _myGps10Unit));
            }
        }

        internal function checkSendResponseOk(arg1:Array):Boolean
        {
            if (arg1 == null) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 900001, "Gps10Handler > Send-Response Check failed... > No Data"));
                return false;
            }
            if (arg1.length < 7) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 900002, "Gps10Handler > Send-Response Check failed... > Less Data"));
                return false;
            }
            return true;
        }

        internal function clear():void
        {
            _numberOfLogHeader = 0;
            _onLoadedCount = 0;
            _onLoadedCountExpected = 0;
            _logHeaderLengthLoaded = false;
            _agpsFileLoaded = false;
            _loadAgpsFileRetryCount = 0;
            _reloadFromDC = false;
            _resetLastReceivedData = false;
            _sendDataInitialized = false;
            _sendDataLength = 0;
            _sendStep = 0;
            _totalLogsToLoad = 0;
            service.DeviceCommunicationHandler.getInstance().removeEventListener("usbComplete", onLoaded);
            return;
        }

        public override function sendToDC(arg1:String):void
        {
            if (service.DeviceCommunicationHandler.getInstance().connectionMode == "connectionModeUSB") 
            {
                if (!_eeprom) 
                {
                    debug.Debug.debug("erst eeprom auslesen");
                    _resendToDSType = arg1;
                    loadFromDC("86 12 0 0 0 0 0 0 255 3 0 100");
                    return;
                }
                _resendToDSType = null;
            }
            if (service.DeviceCommunicationHandler.getInstance().nativeProcessIsBusy) 
            {
                debug.Debug.debug("nativeProcessIsBusy == true");
                service.DeviceCommunicationHandler.getInstance().addToCommandQueue(arg1, "sendCommand", this);
                return;
            }
            if (!service.DeviceCommunicationHandler.getInstance().hasEventListener("usbComplete")) 
            {
                service.DeviceCommunicationHandler.getInstance().addEventListener("usbComplete", onLoaded, false, 0, false);
            }
            currentType = arg1;
            currentCommand = "";
            currentBytesToReceive = 0;
            _loadAgpsFileRetryCount = 0;
            debug.Debug.debug("_sendStep: " + _sendStep);
        }

        public function sendToDCNFC(arg1:String):void
        {
            var loc1:*=null;
            var loc5:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc9:*=null;
            var loc8:*=null;
            debug.Debug.debug("sendToDCNFC => " + arg1 + " // _sendStep: " + _sendStep);
            _eeprom = null;
            _onLoadedCount = 0;
            var loc4:*=new flash.utils.ByteArray();
            var loc7:*=0;
            var loc6:*=new __AS3__.vec.Vector.<service.nfc.NfcQueObj>();
        }

        public function sendToDCDS(arg1:String):void
        {
            var loc1:*=0;
            debug.Debug.debug("sendToDCDS => " + arg1 + " // _sendStep: " + _sendStep);
        }

        public static function getFWOutputString(arg1:String):String
        {
            var loc3:*=0;
            var loc1:*=[];
            var loc2:*=arg1;
            loc2 = loc2.substring(0, loc2.length - 2);
            if (loc2.length != 3) 
            {
                loc1.push(loc2.substr(0, 2).toString());
                loc3 = 2;
            }
            else 
            {
                loc1.push(loc2.substr(0, 1).toString());
                loc3 = 1;
            }
            loc1.push(loc2.substr(loc3, 2).toString());
            return loc1.join(".");
        }

        public override function destructor():void
        {
            super.destructor();
            service.DeviceCommunicationHandler.getInstance().removeEventListener("usbComplete", onLoaded, false);
            return;
        }

        public override function loadFromDC(arg1:String):void
        {
            debug.Debug.debug("type: " + arg1 + "\tUnit: " + _myGps10Unit.type.toString());
            debug.Debug.debug("nativeProcessIsBusy: " + service.DeviceCommunicationHandler.getInstance().nativeProcessIsBusy);
            if (service.DeviceCommunicationHandler.getInstance().nativeProcessIsBusy) 
            {
                service.DeviceCommunicationHandler.getInstance().addToCommandQueue(arg1, "loadCommand", this);
                return;
            }
            currentType = arg1;
            currentCommand = "";
            currentBytesToReceive = 0;
            debug.Debug.debug("connectionMode: " + service.DeviceCommunicationHandler.getInstance().connectionMode);
            if (!service.DeviceCommunicationHandler.getInstance().hasEventListener("usbComplete")) 
            {
                service.DeviceCommunicationHandler.getInstance().addEventListener("usbComplete", onLoaded, false, 0, false);
            }
            var loc1:*=service.DeviceCommunicationHandler.getInstance().connectionMode;
            while ("connectionModeNFC" === loc1) 
            {
                loadFromDCNFC(arg1);
            }
        }

        public function loadFromDCDS(arg1:String):void
        {
            var loc3:*=null;
            var loc4:*=0;
            var loc6:*=0;
            var loc1:*=0;
            var loc7:*=null;
            var loc5:*=null;
            var loc2:*=null;
            debug.Debug.debug("loadFromDCDS => " + arg1);
        }

        public function loadFromDCNFC(arg1:String):void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc7:*=null;
            var loc8:*=0;
            var loc10:*=0;
            var loc3:*=0;
            var loc4:*=null;
            debug.Debug.debug("loadFromDCNFC => " + arg1);
            _eeprom = null;
            var loc5:*=new flash.utils.ByteArray();
            var loc9:*=0;
            var loc6:*=new __AS3__.vec.Vector.<service.nfc.NfcQueObj>();
            var loc12:*=arg1;
            while ("loadUnitlogDataHeader" === loc12) 
            {
                _myGps10Unit.activitiesToDecode = new __AS3__.vec.Vector.<core.activities.Activity>();
                if (_numberOfLogHeader != 0) 
                {
                    currentBytesToReceive = 65 * _numberOfLogHeader;
                    currentCommand = "getNfcLogHeader";
                    loc1 = "1E " + service.nfc.NFCHandler.createBlockHexAddress(1) + " " + service.nfc.NFCHandler.createBlockHexAddress(currentBytesToReceive);
                    loc5 = service.nfc.NFCHandler.generateNativeProzessBufferNfc(loc1, service.nfc.NFCHandler.createNfcFlashCmd(3, 0, 0));
                    loc6.push(new service.nfc.NfcQueObj(loc5, 2, false));
                }
                else 
                {
                    currentBytesToReceive = 3;
                    currentCommand = "getNfcLogHeaderCount";
                    loc1 = "1E " + service.nfc.NFCHandler.createBlockHexAddress(0) + " " + service.nfc.NFCHandler.createBlockHexAddress(1);
                    loc5 = service.nfc.NFCHandler.generateNativeProzessBufferNfc(loc1, service.nfc.NFCHandler.createNfcFlashCmd(1, 0, 0));
                    loc6.push(new service.nfc.NfcQueObj(loc5, 2, false));
                }
            }
        }

        public function disposeHandler():void
        {
            clear();
            return;
        }

        internal static const POSITION_UPDATE_FLAG:uint=80;

        internal static const SEND_STEP_0_INIT:uint=0;

        internal static const CMD_TRANSFER_SUCCESS:String="87 8 0 0 0 2 1 98";

        internal static const SEND_STEP_2_STARTWRITE:uint=2;

        internal static const SEND_STEP_3_DATA_AND_STOPWRITE:uint=3;

        internal static const SEND_STEP_4_READY:uint=4;

        internal static const UPDATE_FIFO_ONLY:uint=0;

        internal static const UPDATE_FLAGS_DEFAULT_DATA:Array=new Array(0, 2, 0, 3);

        internal static const UPDATE_FLAG_BATTERY:uint=64;

        internal static const UPDATE_FLAG_NOTHING:uint=0;

        internal static const UPDATE_FLAG_POINT_NAVIGATION:uint=128;

        internal static const UPDATE_FLAG_POWER_MODE:uint=3;

        internal static const UPDATE_FLAG_SETTINGS:uint=16;

        internal static const UPDATE_FLAG_SLEEP_SCREEN:uint=8;

        internal static const UPDATE_FLAG_TOTALS:uint=32;

        internal static const UPDATE_FLAG_TRIP_DATA_RESET:uint=4;

        internal static const SEND_STEP_1_STARTSTOPADDR:uint=1;

        public static const LENGTH_INITIAL_INFORMATION:uint=6;

        public static const LENGTH_LOG_HEADER_COUNT:uint=3;

        public static const LENGTH_POINT_NAVIGATION:uint=27;

        public static const LENGTH_SERIAL_NUMBER:uint=6;

        public static const LENGTH_SETTINGS:uint=32;

        public static const LENGTH_TOTALS:uint=20;

        public static const POSITION_INITIAL_INFORMATION:uint=64;

        public static const POSITION_SERIAL_NUMBER:uint=0;

        public static const SEND_AGPS_NFC_COMMAND:String="249 6 0 0 0";

        internal static const AGPS_FILE_URL_OFFLINE_1:String="http://offline-live1.services.u-blox.com/GetOfflineData.ashx?token=DU-wSuNZVESn2ngmYtCZAA;gnss=gps;period=2;resolution=1";

        internal static const AGPS_FILE_URL_OFFLINE_2:String="http://offline-live2.services.u-blox.com/GetOfflineData.ashx?token=DU-wSuNZVESn2ngmYtCZAA;gnss=gps;period=2;resolution=1";

        internal static const AGPS_FILE_URL_ONLINE:String="http://online-live1.services.u-blox.com/GetOnlineData.ashx?token=DU-wSuNZVESn2ngmYtCZAA;gnss=gps;datatype=eph,alm,aux,pos";

        internal static const BYTES_TO_RECEIVE_GET_LOG_HEADER_COUNT:int=8;

        internal static const BYTES_TO_RECEIVE_GET_LOG_HEADER_COUNT_NFC:int=3;

        internal static const BYTES_TO_RECEIVE_SEND_END:uint=9;

        internal static const BYTES_TO_RECEIVE_SEND_NFC_DATA:int=1;

        internal static const BYTES_TO_RECEIVE_SEND_SETTINGS:int=1;

        internal static const BYTES_TO_RECEIVE_SEND_START:uint=9;

        internal static const BYTES_TO_RECEIVE_SEND_STEP_1:uint=8;

        internal static const CMD_GET_COMPLETE_EEPROM:String="86 12 0 0 0 0 0 0 255 3 0 100";

        internal static const CMD_GET_COMPLETE_EEPROM_NFC:String="14 00 00 00 00 00 00 03 78";

        internal static const CMD_GET_LOGDATA_NFC:String="getLogData";

        internal static const CMD_GET_LOG_DATA_PREFIX:String="86 12 0 0 0";

        internal static const CMD_GET_LOG_HEADER_COUNT:String="84 12 0 0 0 0 0 0 0 0 0 96";

        internal static const CMD_GET_LOG_HEADER_COUNT_NFC:String="getNfcLogHeaderCount";

        internal static const CMD_GET_LOG_HEADER_DATA_PREFIX:String="86 12 0 0 0";

        internal static const CMD_GET_LOG_HEADER_NFC:String="getNfcLogHeader";

        internal static const CMD_NFCONLY_CLOSE_NFC:String="5A 00 00 00 00 00 00 00 00";

        internal static const CMD_NFCONLY_CLOSE_NFC_TAG:String="closeNfcTag";

        internal static const CMD_SEND_AGPS:String="82 12 0 0 0 248 127 0 0 16 0 229";

        internal static const CMD_SEND_AGPS_NFC:String="sendAgpsNfc";

        internal static const CMD_SEND_EEPROM:String="82 12 0 0 0 0 4 0 0 0 0 98";

        internal static const CMD_SEND_EEPROM_POINT_NAVIGATION_NFC:String="0A 00 00 00 54 00 00 00 00";

        internal static const CMD_SEND_EEPROM_SETTINGS_NFC:String="0A 00 00 00 44 00 00 00 00";

        internal static const CMD_SEND_EEPROM_SLEEP_SCREEN_NFC:String="0A 00 00 00 18 00 00 00 00";

        internal static const CMD_SEND_EEPROM_TOTALS_NFC:String="0A 00 00 00 4C 00 00 00 00";

        internal static const CMD_SEND_EEPROM_TOUR_DATA_RESET_NFC:String="tourDataReset";

        internal static const CMD_SEND_EEPROM_UPDATE_FLAGS_NFC:String="0A 00 00 00 14 00 00 00 00";

        internal static const CMD_SEND_END:String="171 8 0 0 0 1 2 182";

        internal static const CMD_SEND_START:String="83 8 0 0 0 0 0 91";

        internal static const CMD_TRANSFER_FAILED:String="87 8 0 0 0 3 1 99";

        internal static const CMD_TRANSFER_STARTED:String="87 8 0 0 0 0 1 96";

        internal static const LENGTH_AGPS_UPLOAD:uint=32760;

        internal static const LENGTH_CHECKSUM:uint=1;

        internal static const LENGTH_EEPROM:uint=1024;

        internal static const LENGTH_LOG_HEADER:uint=65;

        internal static const LENGTH_PAYLOAD:uint=5;

        internal static const LENGTH_SEND_BLOCK:uint=64;

        internal static const LOG_HEADER_END:int=2088959;

        internal static const POSITION_LOG_HEADER_COUNT:uint=576;

        internal static const POSITION_POINT_NAVIGATION:uint=336;

        internal static const POSITION_SETTINGS:uint=272;

        internal static const POSITION_SLEEPSCREEN:uint=96;

        internal static const POSITION_TOTALS:uint=304;

        internal var _unit:core.units.UnitGps10;

        internal var _agpsFileLoaded:Boolean=false;

        internal var _currenLogToLoad:core.activities.Activity;

        internal var _eeprom:Array;

        internal var _loadAgpsFileRetryCount:uint=0;

        internal var _logHeaderLengthLoaded:Boolean=false;

        internal var _numberOfLogHeader:uint=0;

        internal var _onLoadedCount:uint=0;

        internal var _onLoadedCountExpected:uint=0;

        internal var _reloadFromDC:Boolean=false;

        internal var _resetLastReceivedData:Boolean=false;

        internal var _sendData:Array;

        internal var _sendDataInitialized:Boolean=false;

        internal var _sendDataLength:int=0;

        internal var _sendStep:uint=0;

        internal var _tmpData:Array;

        internal var _totalLogsToLoad:int=0;

        internal var _resendToDSType:String;

        internal static var CMD_DYNAMIC_GET_LOG_HEADER_DATA:String="";

        internal var _updateFlagData:Array;

        internal static var CMD_DYNAMIC_GET_LOG_DATA:String="";
    }
}


