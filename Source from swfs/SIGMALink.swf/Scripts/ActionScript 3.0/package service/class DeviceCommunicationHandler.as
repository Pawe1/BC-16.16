//class DeviceCommunicationHandler
package service 
{
    import __AS3__.vec.*;
    import com.logging.*;
    import core.units.interfaces.*;
    import de.pagecon.ane.nfc.events.*;
    import de.pagecon.usb.*;
    import debug.*;
    import flash.events.*;
    import flash.utils.*;
    import handler.*;
    import handler.event.*;
    import helper.*;
    import service.ble.*;
    import service.ble.event.*;
    import service.event.*;
    import service.nfc.*;
    import service.usb.*;
    import service.usb.event.*;
    
    public class DeviceCommunicationHandler extends flash.events.EventDispatcher
    {
        public function DeviceCommunicationHandler(arg1:flash.events.IEventDispatcher=null)
        {
            _commandQueue = new __AS3__.vec.Vector.<service.Queueitem>();
            _receiveBuffer = [];
            super(arg1);
            com.logging.ErrorLogging.getInstance().addTarget(this);
            _usbHandler = new service.usb.USBHandler();
            _bleHandler = new service.ble.BLEHandler();
            initServices();
            return;
        }

        public function clearCommandQueue():void
        {
            _commandQueue = new __AS3__.vec.Vector.<service.Queueitem>();
            if (nativeProcessIsBusy) 
            {
                resetLastReceveidData();
            }
            return;
        }

        public function startScanForNewWirelessDevices(arg1:Array=null):void
        {
            _bleHandler.addEventListener("bleDeviceFoundEvent", onBLEDeviceFound);
            _bleHandler.startScanForNewDevices(arg1);
            return;
        }

        public function stopScanForNewWirelessDevices():void
        {
            debug.Debug.debug("[stopScanForNewWirelessDevices]");
            _bleHandler.stopScanForNewDevices();
            return;
        }

        public function get connectionMode():String
        {
            return _connectionMode;
        }

        public function set connectionMode(arg1:String):void
        {
            debug.Debug.debug("changed connectionMode: " + arg1);
            _connectionMode = arg1;
            return;
        }

        protected function onBLEDeviceFound(arg1:service.ble.event.BLEDeviceEvent):void
        {
            debug.Debug.debug("[onBLEDeviceFound] " + arg1.bleDevice.deviceID + " " + arg1.bleDevice.localName + " " + arg1.bleDevice.primaryServiceUUID);
            dispatchEvent(new service.ble.event.BLEDeviceEvent("bleDeviceFoundEvent", arg1.bleDevice));
            return;
        }

        public function connectToDevicesStart():void
        {
            debug.Debug.debug("[connectToDevicesStart]");
            _bleHandler.addEventListener("DEVICE_CONNECTED", onBLEDeviceConnected);
            _bleHandler.stopScanAndConnect();
            return;
        }

        public function get nativeProcessIsBusy():Boolean
        {
            return _nativeProcessIsBusy;
        }

        public function set nativeProcessIsBusy(arg1:Boolean):void
        {
            if (arg1 != _nativeProcessIsBusy) 
            {
                _nativeProcessIsBusy = arg1;
            }
            return;
        }

        internal function onBLEDeviceConnected(arg1:service.ble.event.BLEDeviceEvent):void
        {
            debug.Debug.debug("[onBLEDeviceConnected] " + arg1.bleDevice.deviceID);
            dispatchEvent(new service.ble.event.BLEDeviceEvent("bleDeviceConnectedEvent", arg1.bleDevice));
            return;
        }

        public function get receivedDataUncompleteInterval():int
        {
            return _receivedDataUncompleteInterval;
        }

        public function set receivedDataUncompleteInterval(arg1:int):void
        {
            _receivedDataUncompleteInterval = arg1;
            validateUncompleteTimer();
            return;
        }

        public function addDeviceToDeviceList(arg1:core.units.interfaces.IBLEDeviceInfo):void
        {
            debug.Debug.debug("[addDeviceToDeviceList] " + arg1.localName + " " + arg1.deviceID);
            _bleHandler.addDeviceToDeviceList(arg1);
            return;
        }

        public function removeDeviceFromDeviceList(arg1:core.units.interfaces.IBLEDeviceInfo):void
        {
            debug.Debug.debug("[removeDeviceFromDeviceList] " + arg1.localName + " " + arg1.deviceID);
            _bleHandler.removeDeviceFromDeviceList(arg1);
            return;
        }

        protected function get currentCommunicationHandler():*
        {
            return _currentCommunicationHandler;
        }

        protected function set currentCommunicationHandler(arg1:*):void
        {
            debug.Debug.debug("+++ new currentCommunicationHandler +++ " + arg1);
            _currentCommunicationHandler = arg1;
            return;
        }

        public function checkIDsAndConnect():void
        {
            _bleHandler.checkIDsAndConnect();
            return;
        }

        public function checkConnectedUSBDevice():void
        {
            _usbHandler.searchAttachedDevices();
            return;
        }

        public function getBLEStatus():int
        {
            return _bleHandler.getBLEStatus();
        }

        public static function setInstance(arg1:service.DeviceCommunicationHandler):void
        {
            _instance = arg1;
            return;
        }

        public static function getInstance():service.DeviceCommunicationHandler
        {
            if (_instance == null) 
            {
                _instance = new DeviceCommunicationHandler();
            }
            return _instance;
        }

        protected function initServices():void
        {
            if (!helper.Capabilities_helper.isIOS()) 
            {
                initUSBService(false);
                initNFCService();
            }
            initBLEService(false);
            return;
        }

        public function useNfcCommunicationHandler():void
        {
            debug.Debug.debug("useNfcCommunicationHandler()");
            currentCommunicationHandler = service.nfc.NFCHandler.getInstance();
            return;
        }

        internal function onTransferStart(arg1:flash.events.Event):void
        {
            dispatchEvent(new flash.events.Event("EVENT_TRANSFER_START"));
            return;
        }

        internal function onTransferEnd(arg1:flash.events.Event):void
        {
            dispatchEvent(new flash.events.Event("EVENT_TRANSFER_END"));
            return;
        }

        internal function onBleDevicePaired(arg1:flash.events.Event):void
        {
            dispatchEvent(new flash.events.Event("EVENT_BLE_DEVICE_PAIRED"));
            return;
        }

        internal function onBleDeviceNotPaired(arg1:flash.events.Event):void
        {
            dispatchEvent(new flash.events.Event("EVENT_BLE_DEVICE_NOT_PAIRED"));
            return;
        }

        internal function onTransferInterupted(arg1:flash.events.Event):void
        {
            dispatchEvent(new flash.events.Event("EVENT_TRANSFER_INTERUPTED"));
            return;
        }

        internal function onTransferContinued(arg1:flash.events.Event):void
        {
            dispatchEvent(new flash.events.Event("EVENT_TRANSFER_CONTINUED"));
            return;
        }

        internal function onTransferError(arg1:service.event.DeviceCommunicationEvent):void
        {
            debug.Debug.error("[onTransferError] " + arg1.type);
            dispatchEvent(new service.event.DeviceCommunicationEvent("eventCommunicationError", arg1.message));
            return;
        }

        public function stopAndShowError(arg1:service.event.DeviceCommunicationEvent):void
        {
            debug.Debug.error("[showError] " + arg1.type);
            dispatchEvent(new service.event.DeviceCommunicationEvent("eventCommunicationError", arg1.message));
            return;
        }

        internal function onTransferProgress(arg1:handler.event.CustomCommunicationServiceProgressEvent):void
        {
            var loc1:*=new handler.event.CustomCommunicationServiceProgressEvent("EVENT_TRANSFER_PROGRESS_AUTOMATIC", arg1.progress);
            if (arg1.currentTarget is service.ICommunicationService) 
            {
                loc1.resolveCommunicationHandler(arg1.currentTarget as service.ICommunicationService);
            }
            dispatchEvent(loc1);
            return;
        }

        public function setTransferProgressManual(arg1:uint):void
        {
            debug.Debug.debug(arg1.toString());
            dispatchEvent(new handler.event.CustomCommunicationServiceProgressEvent("EVENT_TRANSFER_PROGRESS_MANUAL", arg1));
            return;
        }

        internal function validateUncompleteTimer():void
        {
            if (_receivedDataUncompleteTimer) 
            {
                onStopWaitForData();
                _receivedDataUncompleteTimer.removeEventListener("timer", receivedDataUncomplete);
            }
            _receivedDataUncompleteTimer = new flash.utils.Timer(receivedDataUncompleteInterval, 1);
            _receivedDataUncompleteTimer.addEventListener("timer", receivedDataUncomplete);
            return;
        }

        internal function receivedDataUncomplete(arg1:flash.events.TimerEvent):void
        {
            dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 110, "USB > receivedDataUncomplete:  > timeout receivedDataUncomplete"));
            resetCommunicationService();
            return;
        }

        public function resetCommunicationService():void
        {
            debug.Debug.debug("------------### resetCommunicationService ###------------");
            clearCommandQueue();
            resetLastReceveidData();
            currentCommunicationHandler = null;
            isBleConnected = false;
            connectionMode = "connectionModeNone";
            checkUnitConnected = true;
            if (_usbHandler) 
            {
                if (_usbHandler.currentDeviceHandler) 
                {
                    _usbHandler.currentDeviceHandler.resetCheckConnectionTimeOut();
                    _usbHandler.currentDeviceHandler.destructor();
                }
                _usbHandler.resetUSBService();
            }
            if (_bleHandler) 
            {
                if (_bleHandler.currentDeviceHandler) 
                {
                    _bleHandler.currentDeviceHandler.destructor();
                }
                _bleHandler.resetBLEService();
            }
            if (service.nfc.NFCHandler.getInstance() && service.nfc.NFCHandler.getInstance().currentDeviceHandler) 
            {
                service.nfc.NFCHandler.getInstance().currentDeviceHandler.destructor();
                service.nfc.NFCHandler.getInstance().resetNFCService();
            }
            return;
        }

        public function disconnect(arg1:core.units.interfaces.IBLEDeviceInfo):void
        {
            if (!_bleHandler) 
            {
                return;
            }
            _bleHandler.disconnect(arg1);
            debug.Debug.debug("diconnect bleDevice");
            return;
        }

        public function resetLastReceveidData():void
        {
            if (_usbHandler) 
            {
                _usbHandler.resetLastReceveidData();
            }
            onStopWaitForData();
            nativeProcessIsBusy = false;
            return;
        }

        public function getLastReceivedData():Array
        {
            return _usbHandler ? _usbHandler.getLastReceivedData() : [];
        }

        public function initCommunicationServices(arg1:Boolean=true):void
        {
            validateUncompleteTimer();
            initUSBService(arg1);
            initBLEService(arg1);
            initNFCService();
            return;
        }

        public function initUSBService(arg1:Boolean=true):void
        {
            _usbHandler.addEventListener("EVENT_USB_TRANSFER_START", onTransferStart);
            _usbHandler.addEventListener("EVENT_USB_TRANSFER_PROGRESS", onTransferProgress);
            _usbHandler.addEventListener("EVENT_USB_TRANSFER_END", onTransferEnd);
            _usbHandler.addEventListener("eventCommunicationError", onTransferError);
            _usbHandler.addEventListener("waitForDataEvent", onWaitForData);
            _usbHandler.addEventListener("stopWaitForDataEvent", onStopWaitForData);
            _usbHandler.addEventListener("usbConnected", onDeviceConnected);
            _usbHandler.addEventListener("usbDisconnected", onDeviceDisconnected);
            _usbHandler.addEventListener("usbComplete", onDeviceDataComplete);
            if (_usbHandler) 
            {
                try 
                {
                    _usbHandler.initMobileUSBService(arg1);
                }
                catch (e:Error)
                {
                    if (e.errorID == de.pagecon.usb.UsbController.PLATFORM_NOT_SUPPORTED) 
                    {
                        debug.Debug.error("USBHost ist auf dieser Platform nicht unterstützt");
                    }
                }
            }
            return;
        }

        public function initBLEService(arg1:Boolean=true):void
        {
            if (_bleHandler.isBLEsupported) 
            {
                _bleHandler.addEventListener("EVENT_BLE_TRANSFER_START", onTransferStart);
                _bleHandler.addEventListener("EVENT_BLE_TRANSFER_PROGRESS", onTransferProgress);
                _bleHandler.addEventListener("EVENT_BLE_TRANSFER_END", onTransferEnd);
                _bleHandler.addEventListener("EVENT_BLE_DEVICE_PAIRED", onBleDevicePaired);
                _bleHandler.addEventListener("EVENT_BLE_DEVICE_NOT_PAIRED", onBleDeviceNotPaired);
                _bleHandler.addEventListener("eventCommunicationError", onTransferError);
                _bleHandler.addEventListener("bleDeviceConnectedEvent", onDeviceConnected);
                _bleHandler.addEventListener("bleDeviceAlreadyConnectedEvent", onDeviceConnected);
                _bleHandler.addEventListener("bleDeviceDisconnectedEvent", onDeviceDisconnected);
                _bleHandler.addEventListener("usbComplete", onDeviceDataComplete);
                _bleHandler.addEventListener("waitForDataEvent", onWaitForData);
                _bleHandler.addEventListener("stopWaitForDataEvent", onStopWaitForData);
                _bleHandler.addEventListener("commandOkEvent", forwardEvent);
                _bleHandler.addEventListener("writeSuccessEvent", forwardEvent);
                _bleHandler.initBLEService(arg1);
            }
            return;
        }

        public function initNFCService():void
        {
            if (service.nfc.NFCHandler.getInstance().isNfcSupported) 
            {
                service.nfc.NFCHandler.getInstance().addEventListener("EVENT_NFC_TRANSFER_START", onTransferStart);
                service.nfc.NFCHandler.getInstance().addEventListener("EVENT_NFC_TRANSFER_PROGRESS", onTransferProgress);
                service.nfc.NFCHandler.getInstance().addEventListener("EVENT_NFC_TRANSFER_END", onTransferEnd);
                service.nfc.NFCHandler.getInstance().addEventListener("EVENT_NFC_TRANSFER_INTERUPTED", onTransferInterupted);
                service.nfc.NFCHandler.getInstance().addEventListener("EVENT_NFC_TRANSFER_CONTINUED", onTransferContinued);
                service.nfc.NFCHandler.getInstance().addEventListener("eventCommunicationError", onTransferError);
                service.nfc.NFCHandler.getInstance().addEventListener("eventNfcDeviceConnected", onDeviceConnected);
                service.nfc.NFCHandler.getInstance().addEventListener("stopWaitForDataEvent", onStopWaitForData);
                service.nfc.NFCHandler.getInstance().addEventListener("usbComplete", onDeviceDataComplete);
                service.nfc.NFCHandler.getInstance().initNFCService();
            }
            return;
        }

        public function destroyBLEService():void
        {
            if (_bleHandler) 
            {
                _bleHandler.removeEventListener("EVENT_BLE_TRANSFER_START", onTransferStart);
                _bleHandler.removeEventListener("EVENT_BLE_TRANSFER_PROGRESS", onTransferProgress);
                _bleHandler.removeEventListener("EVENT_BLE_TRANSFER_END", onTransferEnd);
                _bleHandler.removeEventListener("eventCommunicationError", onTransferError);
                _bleHandler.removeEventListener("bleDeviceConnectedEvent", onDeviceConnected);
                _bleHandler.removeEventListener("bleDeviceAlreadyConnectedEvent", onDeviceConnected);
                _bleHandler.removeEventListener("bleDeviceDisconnectedEvent", onDeviceDisconnected);
                _bleHandler.removeEventListener("usbComplete", onDeviceDataComplete);
                _bleHandler.removeEventListener("waitForDataEvent", onWaitForData);
                _bleHandler.removeEventListener("stopWaitForDataEvent", onStopWaitForData);
                _bleHandler.removeEventListener("commandOkEvent", forwardEvent);
                _bleHandler.removeEventListener("writeSuccessEvent", forwardEvent);
                _bleHandler.destroy();
            }
            return;
        }

        public function destroyNFCService():void
        {
            service.nfc.NFCHandler.getInstance().removeEventListener("EVENT_NFC_TRANSFER_START", onTransferStart);
            service.nfc.NFCHandler.getInstance().removeEventListener("EVENT_NFC_TRANSFER_PROGRESS", onTransferProgress);
            service.nfc.NFCHandler.getInstance().removeEventListener("EVENT_NFC_TRANSFER_END", onTransferEnd);
            service.nfc.NFCHandler.getInstance().removeEventListener("EVENT_NFC_TRANSFER_INTERUPTED", onTransferInterupted);
            service.nfc.NFCHandler.getInstance().removeEventListener("EVENT_NFC_TRANSFER_CONTINUED", onTransferContinued);
            service.nfc.NFCHandler.getInstance().removeEventListener("eventCommunicationError", onTransferError);
            service.nfc.NFCHandler.getInstance().removeEventListener("eventNfcDeviceConnected", onDeviceConnected);
            service.nfc.NFCHandler.getInstance().removeEventListener("stopWaitForDataEvent", onStopWaitForData);
            service.nfc.NFCHandler.getInstance().removeEventListener("usbComplete", onDeviceDataComplete);
            service.nfc.NFCHandler.getInstance().destroy();
            return;
        }

        public function destroyUSBService():void
        {
            if (_usbHandler) 
            {
                _usbHandler.removeEventListener("EVENT_USB_TRANSFER_START", onTransferStart);
                _usbHandler.removeEventListener("EVENT_USB_TRANSFER_PROGRESS", onTransferProgress);
                _usbHandler.removeEventListener("EVENT_USB_TRANSFER_END", onTransferEnd);
                _usbHandler.removeEventListener("eventCommunicationError", onTransferError);
                _usbHandler.removeEventListener("waitForDataEvent", onWaitForData);
                _usbHandler.removeEventListener("stopWaitForDataEvent", onStopWaitForData);
                _usbHandler.removeEventListener("usbConnected", onDeviceConnected);
                _usbHandler.removeEventListener("usbDisconnected", onDeviceDisconnected);
                _usbHandler.removeEventListener("usbComplete", onDeviceDataComplete);
                _usbHandler.destroyUSBController();
            }
            return;
        }

        public function askUserToEnableBLE():void
        {
            _bleHandler.askUserToEnableBLE();
            return;
        }

        public function isBLEEnabled():Boolean
        {
            return _bleHandler.getBLEStatus() == 1;
        }

        public function isBleSupported():Boolean
        {
            return _bleHandler.isBLEsupported;
        }

        public function isNfcSupported():Boolean
        {
            return service.nfc.NFCHandler.getInstance().isNfcSupported;
        }

        public function isNFCEnabled():Boolean
        {
            return service.nfc.NFCHandler.getInstance().isNfcEnabled;
        }

        public function isUsbSupported():Boolean
        {
            return _usbHandler.isSupported();
        }

        protected function forwardEvent(arg1:flash.events.Event):void
        {
            dispatchEvent(new flash.events.Event(arg1.type));
            return;
        }

        public function onStopWaitForData(arg1:flash.events.Event=null):void
        {
            if (_receivedDataUncompleteTimer) 
            {
                _receivedDataUncompleteTimer.stop();
                _receivedDataUncompleteTimer.reset();
            }
            return;
        }

        protected function onWaitForData(arg1:flash.events.Event=null):void
        {
            validateUncompleteTimer();
            return;
        }

        internal function onDeviceConnected(arg1:flash.events.Event):void
        {
            var loc2:*=null;
            debug.Debug.debug("[onDeviceConnected] " + arg1.type);
            var loc1:*=arg1.currentTarget;
            if (loc1 is service.usb.USBHandler && currentCommunicationHandler is service.ble.BLEHandler) 
            {
                if ((currentCommunicationHandler as service.ble.BLEHandler).currentDeviceHandler != null) 
                {
                    debug.Debug.error("ble handler in use - usb device not connected....");
                    return;
                }
            }
            else if (loc1 is service.ble.BLEHandler && currentCommunicationHandler is service.usb.USBHandler) 
            {
                if ((currentCommunicationHandler as service.usb.USBHandler).currentDeviceHandler != null) 
                {
                    debug.Debug.error("usb handler in use - ble device not connected....");
                    return;
                }
            }
            else if (loc1 is service.nfc.NFCHandler && (currentCommunicationHandler is service.usb.USBHandler || currentCommunicationHandler is service.ble.BLEHandler)) 
            {
                if (!((currentCommunicationHandler as service.ble.BLEHandler).currentDeviceHandler == null) || !((currentCommunicationHandler as service.usb.USBHandler).currentDeviceHandler == null)) 
                {
                    debug.Debug.error("ble/usb handler in use - nfc device not connected....");
                    return;
                }
            }
            isBleConnected = false;
        }

        protected function onDeviceDisconnected(arg1:flash.events.Event):void
        {
            var loc1:*=null;
            debug.Debug.debug("onDeviceDisconnected");
            isBleConnected = false;
            if (currentCommunicationHandler is service.usb.USBHandler) 
            {
                if ((currentCommunicationHandler as service.usb.USBHandler).currentDeviceHandler) 
                {
                    (currentCommunicationHandler as service.usb.USBHandler).currentDeviceHandler.resetCheckConnectionTimeOut();
                }
                if (arg1 is service.usb.event.USBConnectedEvent) 
                {
                    dispatchEvent(new service.event.DeviceConnectionEvent("deviceDisconnected", (arg1 as service.usb.event.USBConnectedEvent).usbPort.toString(), (arg1 as service.usb.event.USBConnectedEvent).dockingStation));
                }
            }
            else if (currentCommunicationHandler is service.ble.BLEHandler) 
            {
                if ((currentCommunicationHandler as service.ble.BLEHandler).currentDeviceHandler) 
                {
                    (currentCommunicationHandler as service.ble.BLEHandler).currentDeviceHandler.resetCheckConnectionTimeOut();
                }
                if (arg1 is service.ble.event.BLEDeviceEvent) 
                {
                    loc1 = (arg1 as service.ble.event.BLEDeviceEvent).bleDevice;
                    if (loc1) 
                    {
                        dispatchEvent(new service.event.DeviceConnectionEvent("deviceDisconnected", loc1.deviceID, loc1.dsHandler));
                    }
                }
            }
            else 
            {
                debug.Debug.error("no currentCommunicationHandler");
            }
            if (currentCommunicationHandler) 
            {
                resetCommunicationService();
            }
            return;
        }

        internal function onDeviceDataComplete(arg1:service.usb.event.DeviceDataCompleteEvent):void
        {
            nativeProcessIsBusy = false;
            onStopWaitForData();
            var loc1:*=new service.usb.event.DeviceDataCompleteEvent("usbComplete", arg1.command, arg1.data, arg1.startAdress);
            dispatchEvent(loc1);
            return;
        }

        public function addToCommandQueue(arg1:String, arg2:String, arg3:handler.DeviceHandler):void
        {
            var loc3:*=new service.Queueitem(arg1, arg2, arg3);
            var loc1:*=false;
            var loc5:*=0;
            var loc4:*=_commandQueue;
            for each (var loc2:* in loc4) 
            {
                if (!(loc2.type == loc3.type && loc2.commandMode == loc3.commandMode && loc2.deviceHandler == loc3.deviceHandler)) 
                {
                    continue;
                }
                loc1 = true;
                break;
            }
            if (!loc1) 
            {
                _commandQueue.push(loc3);
            }
            return;
        }

        public function sendToDevice(arg1:flash.utils.ByteArray, arg2:handler.DeviceHandler, arg3:Boolean=false, arg4:uint=0, arg5:uint=0, arg6:Object=null):void
        {
            var loc1:*=null;
            if (nativeProcessIsBusy == false && !(currentCommunicationHandler == null)) 
            {
                nativeProcessIsBusy = true;
                if (connectionMode == "connectionModeUSB" && currentCommunicationHandler is service.usb.USBHandler) 
                {
                    if (arg4 == 0 && arg5 == 0) 
                    {
                        _usbHandler.send(arg1, arg2, arg3);
                    }
                    else 
                    {
                        _usbHandler.sendMultipackage(arg1, arg2, arg4, arg5);
                    }
                }
                else if (connectionMode == "connectionModeBLE" && currentCommunicationHandler is service.ble.BLEHandler) 
                {
                    if (arg4 == 0 && arg5 == 0) 
                    {
                        nativeProcessIsBusy = _bleHandler.send(arg1, arg2) == 0;
                    }
                    else 
                    {
                        _bleHandler.sendMultipackage(arg1, arg2, arg4, arg5);
                    }
                }
                else if (connectionMode == "connectionModeNFC" && currentCommunicationHandler is service.nfc.NFCHandler) 
                {
                    service.nfc.NFCHandler.getInstance().clear();
                    if (!(arg6 == null) && arg6 is service.nfc.NfcQueObj) 
                    {
                        loc1 = arg6 as service.nfc.NfcQueObj;
                    }
                    if (loc1.delay > 0) 
                    {
                        nativeProcessIsBusy = true;
                        flash.utils.setTimeout(sendNfcCommand, loc1.delay, arg1, arg2, loc1);
                    }
                    else 
                    {
                        sendNfcCommand(arg1, arg2, loc1);
                    }
                }
            }
            else if (currentCommunicationHandler == null) 
            {
                debug.Debug.error("currentCommunicationHandler is null");
            }
            else 
            {
                flash.utils.setTimeout(sendToDevice, 1000, arg1, arg2, arg3, arg4, arg5, arg6);
            }
            return;
        }

        internal function sendNfcCommand(arg1:flash.utils.ByteArray, arg2:handler.DeviceHandler, arg3:service.nfc.NfcQueObj):void
        {
            service.nfc.NFCHandler.getInstance().send(arg1, arg2, arg3);
            nativeProcessIsBusy = false;
            return;
        }

        public function processNextCommandFromQueue():void
        {
            var loc1:*=null;
            if (currentCommunicationHandler != null) 
            {
                if (_commandQueue.length > 0) 
                {
                    if (nativeProcessIsBusy) 
                    {
                        flash.utils.setTimeout(processNextCommandFromQueue, _nextQueueCommandInterval);
                        return;
                    }
                    loc1 = _commandQueue.shift();
                    if (loc1.commandMode != "loadCommand") 
                    {
                        if (loc1.commandMode == "sendCommand") 
                        {
                            (loc1.deviceHandler as handler.DeviceHandler).sendToDC(loc1.type as String);
                        }
                    }
                    else 
                    {
                        (loc1.deviceHandler as handler.DeviceHandler).loadFromDC(loc1.type as String);
                    }
                }
            }
            return;
        }

        public static const CONNECTION_MODE_USB:String="connectionModeUSB";

        public static const EVENT_BLE_DEVICE_PAIRED:String="EVENT_BLE_DEVICE_PAIRED";

        public static const EVENT_TRANSFER_CONTINUED:String="EVENT_TRANSFER_CONTINUED";

        public static const COMMAND_MODE_LOAD:String="loadCommand";

        public static const EVENT_TRANSFER_INTERUPTED:String="EVENT_TRANSFER_INTERUPTED";

        public static const EVENT_TRANSFER_PROGRESS_AUTOMATIC:String="EVENT_TRANSFER_PROGRESS_AUTOMATIC";

        public static const EVENT_TRANSFER_PROGRESS_MANUAL:String="EVENT_TRANSFER_PROGRESS_MANUAL";

        public static const EVENT_TRANSFER_START:String="EVENT_TRANSFER_START";

        public static const PROGRESS_READ_WRITE:String="progressReadWriteEvent";

        public static const STOP_WAIT_FOR_DATA_EVENT:String="stopWaitForDataEvent";

        public static const WAIT_FOR_DATA_EVENT:String="waitForDataEvent";

        public static const WRITE_SUCCESS:String="writeSuccessEvent";

        public static const COMMAND_MODE_SEND:String="sendCommand";

        public static const COMMAND_OK:String="commandOkEvent";

        public static const CONNECTION_MODE_BLE:String="connectionModeBLE";

        public static const CONNECTION_MODE_NFC:String="connectionModeNFC";

        public static const CONNECTION_MODE_NONE:String="connectionModeNone";

        public static const EVENT_TRANSFER_END:String="EVENT_TRANSFER_END";

        public static const EVENT_BLE_DEVICE_NOT_PAIRED:String="EVENT_BLE_DEVICE_NOT_PAIRED";

        public var connectedDevicePort:String="";

        internal var _connectionMode:String="connectionModeNone";

        public var isBleConnected:Boolean=false;

        internal var _nativeProcessIsBusy:Boolean=false;

        internal var _receivedDataUncompleteInterval:int=20000;

        protected var _usbHandler:service.usb.USBHandler;

        internal var _currentCommunicationHandler:*;

        internal var _bleHandler:service.ble.BLEHandler;

        internal var _commandQueue:__AS3__.vec.Vector.<service.Queueitem>;

        internal var _nextQueueCommandInterval:uint=1000;

        internal var _receiveBuffer:Array;

        internal var _receivedDataUncompleteTimer:flash.utils.Timer;

        internal static var _instance:service.DeviceCommunicationHandler;

        public static var handleConnectionModeAutomatically:Boolean=true;

        public var checkUnitConnected:Boolean=true;
    }
}


