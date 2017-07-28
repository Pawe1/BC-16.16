//class NFCHandler
package service.nfc 
{
    import __AS3__.vec.*;
    import com.logging.*;
    import de.pagecon.ane.nfc.*;
    import de.pagecon.ane.nfc.events.*;
    import debug.*;
    import flash.events.*;
    import flash.system.*;
    import flash.utils.*;
    import handler.*;
    import handler.event.*;
    import helper.*;
    import mx.events.*;
    import mx.utils.*;
    import service.*;
    import service.event.*;
    import service.usb.event.*;
    import utils.*;
    
    public class NFCHandler extends flash.events.EventDispatcher implements service.ICommunicationService
    {
        public function NFCHandler()
        {
            isNfcEnabled = false;
            isNfcSupported = false;
            _nfcQueObjectsReady = new __AS3__.vec.Vector.<service.nfc.NfcQueObj>();
            _nfcQueObjectsTodo = new __AS3__.vec.Vector.<service.nfc.NfcQueObj>();
            super();
            de.pagecon.ane.nfc.NfcController.instance.debugMode = flash.system.Capabilities.isDebugger;
            debug.Debug.nfc("[NFC ANE VERSION] " + de.pagecon.ane.nfc.NfcController.instance.getAneVersion());
            validateNFCStatus();
            return;
        }

        internal function sendCommand():void
        {
            var loc1:*=_currentNfcQueObject.corruptedStartBlock > 0 ? _currentNfcQueObject.corruptedStartBlock : _currentNfcQueObject.startBlock;
            var loc2:*=_currentNfcQueObject.command;
            while (20 === loc2) 
            {
                de.pagecon.ane.nfc.NfcController.instance.readEeprom(loc1, _currentNfcQueObject.endBlock);
            }
        }

        public function get currentDeviceHandler():handler.DeviceHandler
        {
            return _currentDeviceHandler;
        }

        internal function onProgressActive(arg1:de.pagecon.ane.nfc.events.NfcEvent):void
        {
            _currentNfcQueObject.currentEndBlock = arg1.endAddr;
            _currentNfcQueObject.packages.push(new service.nfc.NfcQuePackage(arg1));
            var loc1:*=100 / _multiQueSize;
            _progress = loc1 * _nfcQueObjectsReady.length + loc1 / 100 * _currentNfcQueObject.getProgress();
            dispatchEvent(new handler.event.CustomCommunicationServiceProgressEvent("EVENT_NFC_TRANSFER_PROGRESS", _progress));
            return;
        }

        public function get isNfcEnabled():Boolean
        {
            return this.isNfcEnabled;
        }

        public function set isNfcEnabled(arg1:Boolean):void
        {
            var loc1:*=this.isNfcEnabled;
            if (loc1 !== arg1) 
            {
                this.isNfcEnabled = arg1;
                if (this.hasEventListener("propertyChange")) 
                {
                    this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "isNfcEnabled", loc1, arg1));
                }
            }
            return;
        }

        internal function onDataReady(arg1:de.pagecon.ane.nfc.events.NfcEvent):void
        {
            var loc3:*=null;
            debug.Debug.nfc("[ONDATAREADY]: " + arg1.toString());
            _currentNfcQueObject.result = _currentNfcQueObject.result + arg1.byteString;
            _currentNfcQueObject.resultBytes = _currentNfcQueObject.resultBytes.concat(arg1.rArray);
            _nfcQueObjectsReady.push(_currentNfcQueObject);
            _progress = 100 / _multiQueSize * _nfcQueObjectsReady.length;
            dispatchEvent(new handler.event.CustomCommunicationServiceProgressEvent("EVENT_NFC_TRANSFER_PROGRESS", _progress));
            var loc1:*=_currentNfcQueObject.resultBytes.length;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                _currentNfcQueObject.resultBytes[loc2] = parseInt(_currentNfcQueObject.resultBytes[loc2], 16);
                ++loc2;
            }
            if (_nfcQueObjectsReady.length == _multiQueSize) 
            {
                reset();
                dispatchEvent(new flash.events.Event("EVENT_NFC_TRANSFER_END"));
            }
            if (_currentDeviceHandler) 
            {
                loc3 = new service.usb.event.DeviceDataCompleteEvent("usbComplete", _currentDeviceHandler.currentCommand.toString(), [_currentNfcQueObject], _currentDeviceHandler.currentStartAdrr);
                dispatchEvent(loc3);
            }
            if (_nfcQueObjectsReady.length < _multiQueSize) 
            {
                prepareCommand();
            }
            return;
        }

        public function get isNfcSupported():Boolean
        {
            return this.isNfcSupported;
        }

        public function set isNfcSupported(arg1:Boolean):void
        {
            var loc1:*=this.isNfcSupported;
            if (loc1 !== arg1) 
            {
                this.isNfcSupported = arg1;
                if (this.hasEventListener("propertyChange")) 
                {
                    this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "isNfcSupported", loc1, arg1));
                }
            }
            return;
        }

        public function reset():void
        {
            debug.Debug.nfc("+++ reset NFCHandler...");
            _multiQueSize = 0;
            _transferStarted = false;
            flash.utils.clearTimeout(_queTimer);
            _progress = 0;
            _commandCount = 0;
            _waitForAllCommands = true;
            _errorMessage = "";
            _retries = 1;
            _nfcQueObjectsReady = new __AS3__.vec.Vector.<service.nfc.NfcQueObj>();
            _nfcQueObjectsTodo = new __AS3__.vec.Vector.<service.nfc.NfcQueObj>();
            de.pagecon.ane.nfc.NfcController.instance.closeTag();
            de.pagecon.ane.nfc.NfcController.instance.removeListeners();
            return;
        }

        public function get transferStarted():Boolean
        {
            return _transferStarted;
        }

        public function set transferStarted(arg1:Boolean):void
        {
            _transferStarted = arg1;
            return;
        }

        public function resetNFCService(arg1:Boolean=true):void
        {
            if (currentDeviceHandler == null || !(currentDeviceHandler is service.nfc.NFCHandler)) 
            {
                return;
            }
            debug.Debug.usb(" --------- resetNFCService  --------- ( and restart:" + arg1);
            reset();
            if (_currentDeviceHandler != null) 
            {
                _currentDeviceHandler.destructor();
                _currentDeviceHandler = null;
            }
            return;
        }

        internal function onErrorEvent(arg1:de.pagecon.ane.nfc.events.NfcEvent):void
        {
            debug.Debug.error("+++ onErrorEvent: " + arg1.toString());
            _currentNfcQueObject.corruptedStartBlock = arg1.startAddr;
            _currentNfcQueObject.errorOnBlock = arg1.startAddr;
            _errorMessage = arg1.errorMessage;
            dispatchEvent(new service.event.DeviceCommunicationEvent("eventCommunicationError", arg1.errorMessage));
            dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 216, arg1.errorMessage));
            return;
        }

        internal function retry(arg1:de.pagecon.ane.nfc.events.NfcEvent=null):void
        {
            var loc1:*=null;
            de.pagecon.ane.nfc.NfcController.instance.removeEventListener("eventNfcOnInvoke", retry);
            dispatchEvent(new flash.events.Event("EVENT_NFC_TRANSFER_CONTINUED"));
            var loc2:*=0;
            while (loc2 < _currentNfcQueObject.packages.length) 
            {
                loc1 = _currentNfcQueObject.packages[loc2];
                _currentNfcQueObject.result = _currentNfcQueObject.result + loc1.byteString;
                _currentNfcQueObject.resultBytes = _currentNfcQueObject.resultBytes.concat(loc1.rArray);
                ++loc2;
            }
            sendCommand();
            return;
        }

        public function cancel():void
        {
            dispatchEvent(new service.event.DeviceCommunicationEvent("eventCommunicationError", _errorMessage));
            reset();
            dispatchEvent(new flash.events.Event("EVENT_NFC_TRANSFER_END"));
            return;
        }

        internal function onNfcStatusChanged(arg1:de.pagecon.ane.nfc.events.NfcEvent):void
        {
            validateNFCStatus();
            debug.Debug.nfc("+++ onNfcStatusChanged: " + arg1.toString());
            return;
        }

        public function clear():void
        {
            debug.Debug.nfc("clear");
            de.pagecon.ane.nfc.NfcController.instance.removeEventListener("eventNfcOnInvoke", onNfcInvoke);
            return;
        }

        public static function createNfcFlashCmd(arg1:uint, arg2:uint=0, arg3:uint=0):Array
        {
            var loc1:*=0;
            var loc2:*=[];
            if (arg3 != arg2) 
            {
                if (arg3 > arg2) 
                {
                    loc1 = arg3 - arg2 + 1;
                }
                else 
                {
                    loc1 = 0;
                }
            }
            else 
            {
                loc1 = 0;
            }
            loc2[0] = 250;
            loc2[1] = arg1;
            loc2[2] = arg2 & 255;
            loc2[3] = (arg2 & 65280) >> 8;
            loc2[4] = (arg2 & 16711680) >> 16;
            loc2[5] = loc1 & 255;
            loc2[6] = (loc1 & 65280) >> 8;
            loc2[7] = (loc1 & 16711680) >> 16;
            loc2[8] = utils.ChecksumUtil.calculateCrcValue(loc2, 1);
            return loc2;
        }

        public static function getInstance():service.nfc.NFCHandler
        {
            if (!_instance) 
            {
                _instance = new NFCHandler();
            }
            return _instance;
        }

        public static function generateNativeProzessBufferNfc(arg1:String, arg2:Array=null, arg3:Boolean=false):flash.utils.ByteArray
        {
            var loc1:*=null;
            var loc6:*=0;
            var loc4:*=new flash.utils.ByteArray();
            var loc5:*;
            var loc2:*=(loc5 = arg1.split(" ")).length;
            var loc3:*=0;
            loc3 = 0;
            while (loc3 < loc2) 
            {
                loc1 = loc5[loc3];
                loc6 = parseInt(loc1, 16);
                loc4.writeByte(loc6);
                ++loc3;
            }
            if (arg2 != null) 
            {
                loc3 = 0;
                while (loc3 < arg2.length) 
                {
                    if (arg3) 
                    {
                        loc1 = arg2[loc3];
                        loc6 = parseInt(loc1, 16);
                    }
                    else 
                    {
                        loc6 = arg2[loc3];
                    }
                    loc4.writeByte(loc6);
                    ++loc3;
                }
            }
            loc4.position = 0;
            return loc4;
        }

        public static function createBlockHexAddress(arg1:uint):String
        {
            var loc2:*=null;
            loc2 = "00000000";
            var loc1:*="";
            var loc4:*=arg1.toString(16);
            var loc3:*=loc2.length;
            var loc5:*=0;
            loc2 = loc2.substr(0, loc2.length - loc4.length) + loc4;
            while (loc5 < loc3) 
            {
                loc1 = loc1 + loc2.charAt(loc5);
                if ((loc5 + 1) % 2 == 0) 
                {
                    loc1 = loc1 + " ";
                }
                ++loc5;
            }
            return mx.utils.StringUtil.trim(loc1);
        }

        public function validateNFCStatus():void
        {
            isNfcEnabled = de.pagecon.ane.nfc.NfcController.instance.isNfcEnabled();
            isNfcSupported = de.pagecon.ane.nfc.NfcController.instance.isNfcSupported();
            return;
        }

        public function initNFCService():void
        {
            debug.Debug.nfc("initNFCService");
            de.pagecon.ane.nfc.NfcController.instance.addEventListener("eventNfcError", onErrorEvent);
            de.pagecon.ane.nfc.NfcController.instance.addEventListener("eventNfcOnInvoke", onNfcInvoke);
            de.pagecon.ane.nfc.NfcController.instance.addEventListener("eventNfcStatusChanged", onNfcStatusChanged);
            return;
        }

        public function destroy():void
        {
            de.pagecon.ane.nfc.NfcController.instance.removeEventListener("eventNfcError", onErrorEvent);
            de.pagecon.ane.nfc.NfcController.instance.removeEventListener("eventNfcOnInvoke", onNfcInvoke);
            de.pagecon.ane.nfc.NfcController.instance.removeEventListener("eventNfcStatusChanged", onNfcStatusChanged);
            de.pagecon.ane.nfc.NfcController.instance.removeEventListener("eventNfcStepResultReady", onProgressActive);
            de.pagecon.ane.nfc.NfcController.instance.removeEventListener("eventNfcReadEepromReady", onDataReady);
            de.pagecon.ane.nfc.NfcController.instance.removeEventListener("eventNfcWriteEepromReady", onDataReady);
            de.pagecon.ane.nfc.NfcController.instance.removeEventListener("eventNfcReadFlashReady", onDataReady);
            de.pagecon.ane.nfc.NfcController.instance.removeEventListener("eventNfcWriteFlashReady", onDataReady);
            de.pagecon.ane.nfc.NfcController.instance.removeEventListener("eventNfcCloseTagReady", onDataReady);
            return;
        }

        public function send(arg1:flash.utils.ByteArray, arg2:handler.DeviceHandler, arg3:service.nfc.NfcQueObj):void
        {
            arg3.buffer = arg1;
            debug.Debug.nfc("send (" + _commandCount + "): " + arg3.toString());
            if (_commandCount == 0) 
            {
                debug.Debug.nfc("[FIRST COMMAND] initializing NFC Handler...");
                _currentDeviceHandler = arg2;
                _waitForAllCommands = arg3.waitForAllCommands;
                _multiQueSize = 0;
                _progress = 0;
                _transferStarted = false;
                flash.utils.clearTimeout(_queTimer);
                _retries = 1;
                _nfcQueObjectsReady = new __AS3__.vec.Vector.<service.nfc.NfcQueObj>();
                _nfcQueObjectsTodo = new __AS3__.vec.Vector.<service.nfc.NfcQueObj>();
                de.pagecon.ane.nfc.NfcController.instance.removeListeners();
            }
            _nfcQueObjectsTodo.push(arg3);
            _multiQueSize = arg3.queSize;
            ++_commandCount;
            if (_multiQueSize == _nfcQueObjectsTodo.length || !_waitForAllCommands) 
            {
                onNfcInvoke();
            }
            return;
        }

        internal function onNfcInvoke(arg1:de.pagecon.ane.nfc.events.NfcEvent=null):void
        {
            debug.Debug.nfc("+++ onNfcInvoke: " + (arg1 != null ? arg1.toString() : "without NfcEvent"));
            de.pagecon.ane.nfc.NfcController.instance.removeEventListener("eventNfcOnInvoke", onNfcInvoke);
            _transferStarted = false;
            if (!(_nfcQueObjectsTodo == null) && _nfcQueObjectsTodo.length > 0) 
            {
                prepareCommand();
            }
            else 
            {
                dispatchEvent(new de.pagecon.ane.nfc.events.NfcEvent("eventNfcDeviceConnected"));
            }
            return;
        }

        internal function prepareCommand():void
        {
            var loc1:*=null;
            if (_nfcQueObjectsTodo.length == 0) 
            {
                flash.utils.clearTimeout(_queTimer);
                ++_retries;
                if (_retries < 40) 
                {
                    _queTimer = flash.utils.setTimeout(prepareCommand, 250);
                }
                return;
            }
            debug.Debug.nfc("_nfcQueObjects.length: " + _nfcQueObjectsTodo.length + "\t_multiQueSize: " + _multiQueSize + "\t_waitForAllCommands: " + _waitForAllCommands.toString());
            _retries = 0;
            flash.utils.clearTimeout(_queTimer);
            if (!_transferStarted) 
            {
                _transferStarted = true;
                dispatchEvent(new flash.events.Event("EVENT_NFC_TRANSFER_START"));
            }
            _currentNfcQueObject = _nfcQueObjectsTodo.shift();
            if (_currentNfcQueObject.buffer != null) 
            {
                _currentNfcQueObject.buffer.position = 0;
            }
            if (_currentNfcQueObject.buffer == null || _currentNfcQueObject.buffer.bytesAvailable < 9) 
            {
                flash.utils.clearTimeout(_queTimer);
                debug.Debug.error("Fehler in Buffer que...");
                dispatchEvent(new service.event.DeviceCommunicationEvent("eventCommunicationError", ""));
                return;
            }
            loc1 = new flash.utils.ByteArray();
            _currentNfcQueObject.buffer.readBytes(loc1, 0, 1);
            _currentNfcQueObject.command = loc1.readByte();
            loc1 = new flash.utils.ByteArray();
            _currentNfcQueObject.buffer.readBytes(loc1, 0, 4);
            _currentNfcQueObject.startBlock = loc1.readInt();
            loc1 = new flash.utils.ByteArray();
            _currentNfcQueObject.buffer.readBytes(loc1, 0, 4);
            _currentNfcQueObject.endBlock = loc1.readInt();
            if (_currentNfcQueObject.endBlock > _currentNfcQueObject.startBlock) 
            {
                _currentNfcQueObject.length = _currentNfcQueObject.endBlock - _currentNfcQueObject.startBlock + 1;
            }
            var loc2:*=_currentNfcQueObject.command;
            while (20 === loc2) 
            {
                de.pagecon.ane.nfc.NfcController.instance.addEventListener("eventNfcStepResultReady", onProgressActive);
                de.pagecon.ane.nfc.NfcController.instance.addEventListener("eventNfcReadEepromReady", onDataReady);
            }
        }

        public static const NFC_COMMAND_CLOSE_TAG_HEX:String="5A";

        public static const EVENT_NFC_TRANSFER_CONTINUED:String="EVENT_NFC_TRANSFER_CONTINUED";

        public static const NFC_COMMAND_READ_FLASH:uint=30;

        public static const NFC_COMMAND_READ_FLASH_HEX:String="1E";

        public static const NFC_COMMAND_WRITE_EEPROM:uint=10;

        public static const NFC_COMMAND_WRITE_EEPROM_HEX:String="0A";

        public static const NFC_COMMAND_WRITE_FLASH:uint=40;

        public static const NFC_COMMAND_WRITE_FLASH_HEX:String="28";

        public static const NFC_COMMAND_READ_EEPROM_HEX:String="14";

        internal static const LEADING_ZEROES:String="00000000";

        internal static const MAX_RETRIES:uint=40;

        public static const EVENT_NFC_TRANSFER_END:String="EVENT_NFC_TRANSFER_END";

        public static const EVENT_NFC_TRANSFER_INTERUPTED:String="EVENT_NFC_TRANSFER_INTERUPTED";

        public static const EVENT_NFC_TRANSFER_PROGRESS:String="EVENT_NFC_TRANSFER_PROGRESS";

        public static const EVENT_NFC_TRANSFER_START:String="EVENT_NFC_TRANSFER_START";

        public static const NFC_COMMAND_CLOSE_TAG:uint=90;

        internal static const ERROR_UNSUPPORTED_NFC_COMMAND:String="unsupportet Nfc command";

        public static const NFC_COMMAND_READ_EEPROM:uint=20;

        internal var isNfcEnabled:Boolean;

        internal var isNfcSupported:Boolean;

        internal var _transferStarted:Boolean=false;

        internal var _commandCount:uint=0;

        internal var _currentNfcQueObject:service.nfc.NfcQueObj;

        internal var _errorMessage:String="";

        internal var _multiQueSize:uint=0;

        internal var _nfcQueObjectsReady:__AS3__.vec.Vector.<service.nfc.NfcQueObj>;

        internal var _nfcQueObjectsTodo:__AS3__.vec.Vector.<service.nfc.NfcQueObj>;

        internal var _progress:uint=0;

        internal var _queTimer:uint;

        internal var _retries:uint=1;

        internal var _waitForAllCommands:Boolean=true;

        internal static var _instance:service.nfc.NFCHandler;

        internal var _currentDeviceHandler:handler.DeviceHandler;
    }
}


