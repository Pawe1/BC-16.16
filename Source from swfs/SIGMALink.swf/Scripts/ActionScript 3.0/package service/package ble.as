//package ble
//  package event
//    class BLEDeviceEvent
package service.ble.event 
{
    import core.units.interfaces.*;
    import flash.events.*;
    
    public class BLEDeviceEvent extends flash.events.Event
    {
        public function BLEDeviceEvent(arg1:String, arg2:core.units.interfaces.IBLEDeviceInfo, arg3:Boolean=false, arg4:Boolean=false)
        {
            bleDevice = arg2;
            super(arg1, arg3, arg4);
            return;
        }

        public static const DEVICE_ALREADY_CONNECTED:String="bleDeviceAlreadyConnectedEvent";

        public static const DEVICE_CONNECTED:String="bleDeviceConnectedEvent";

        public static const DEVICE_DISCONNECTED:String="bleDeviceDisconnectedEvent";

        public static const DEVICE_FOUND:String="bleDeviceFoundEvent";

        public var bleDevice:core.units.interfaces.IBLEDeviceInfo;
    }
}


//  class BLEDevice
package service.ble 
{
    import core.units.interfaces.*;
    
    public class BLEDevice extends Object implements core.units.interfaces.IBLEDeviceInfo
    {
        public function BLEDevice(arg1:String, arg2:String, arg3:String)
        {
            super();
            _deviceID = arg1;
            _primaryServiceUUID = arg2;
            _localName = arg3;
            return;
        }

        public function get deviceID():String
        {
            return _deviceID;
        }

        public function set deviceID(arg1:String):void
        {
            _deviceID = arg1;
            return;
        }

        public function get dsHandler():String
        {
            return _dsHandler;
        }

        public function set dsHandler(arg1:String):void
        {
            _dsHandler = arg1;
            return;
        }

        public function get localName():String
        {
            return _localName;
        }

        public function set localName(arg1:String):void
        {
            _localName = arg1;
            return;
        }

        public function get primaryServiceUUID():String
        {
            return _primaryServiceUUID;
        }

        public function set primaryServiceUUID(arg1:String):void
        {
            _primaryServiceUUID = arg1;
            return;
        }

        public function toString():String
        {
            return _localName + "\nDevice: " + _deviceID + "\nPrimary Service: " + _primaryServiceUUID;
        }

        internal var _deviceID:String="";

        internal var _dsHandler:String;

        internal var _localName:String="";

        internal var _primaryServiceUUID:String="";
    }
}


//  class BLEHandler
package service.ble 
{
    import com.logging.*;
    import core.general.*;
    import core.units.interfaces.*;
    import de.pagecon.bleane.*;
    import debug.*;
    import flash.events.*;
    import flash.utils.*;
    import handler.*;
    import handler.dockingstation.*;
    import handler.event.*;
    import helper.*;
    import service.*;
    import service.ble.event.*;
    import service.event.*;
    import service.usb.event.*;
    import utils.*;
    
    public class BLEHandler extends flash.events.EventDispatcher implements service.ICommunicationService
    {
        public function BLEHandler(arg1:flash.events.IEventDispatcher=null)
        {
            bleDeviceList = new flash.utils.Dictionary();
            _receiveBuffer = [];
            super(arg1);
            supportedBLEDevices = ["cc141a56-0b20-41f8-9b2b-f92ccc9b555f"];
            if (!helper.Capabilities_helper.isDesktop()) 
            {
                supportedBLEDevices.push("5762");
            }
            _bleController = new de.pagecon.bleane.BleController();
            isBLEsupported = _bleController.isBleSupported();
            return;
        }

        internal function sendLoop(arg1:flash.utils.ByteArray, arg2:uint, arg3:uint, arg4:uint):void
        {
            var loc4:*=0;
            debug.Debug.ble("[sendLoop] " + arg1.bytesAvailable + " " + arg2 + " " + arg3);
            if (!currentDeviceHandler) 
            {
                return;
            }
            dispatchEvent(new handler.event.CustomCommunicationServiceProgressEvent("EVENT_BLE_TRANSFER_PROGRESS", 100 / _bufferSize * (_bufferSize - arg1.bytesAvailable)));
            if (arg1.bytesAvailable == 0) 
            {
                if (currentDeviceHandler.currentBytesToReceive == 0) 
                {
                    dispatchEvent(new service.usb.event.DeviceDataCompleteEvent("usbComplete", currentDeviceHandler.currentCommand.toString(), [], currentDeviceHandler.currentStartAdrr));
                }
                return;
            }
            var loc3:*=[];
            var loc2:*=0;
            var loc1:*=0;
            loc4 = 0;
            while (loc4 < arg2) 
            {
                if (arg1.bytesAvailable >= 1) 
                {
                    loc1 = arg1.readUnsignedByte();
                    loc3.push(loc1);
                    ++loc2;
                }
                ++loc4;
            }
            send(helper.ByteArray_helper.fromArray(loc3), currentDeviceHandler);
            ++arg3;
            return;
        }

        internal function resolveResult(arg1:int):String
        {
            var loc1:*="";
            var loc2:*=arg1;
            while (0 === loc2) 
            {
                loc1 = loc1 + "SUCCESS";
            }
        }

        public function get currentDeviceHandler():handler.DeviceHandler
        {
            return _currentDeviceHandler;
        }

        public function set currentDeviceHandler(arg1:handler.DeviceHandler):void
        {
            _currentDeviceHandler = arg1;
            return;
        }

        internal function byteArrayToArray(arg1:flash.utils.ByteArray):Array
        {
            var loc2:*=[];
            var loc1:*=0;
            arg1.position = 0;
            while (arg1.bytesAvailable) 
            {
                loc1 = arg1.readUnsignedByte();
                loc2[loc2.length] = loc1;
            }
            return loc2;
        }

        internal function datasendToDevice(arg1:de.pagecon.bleane.BleEvent):void
        {
            service.DeviceCommunicationHandler.getInstance().nativeProcessIsBusy = false;
            dispatchEvent(new flash.events.Event("writeSuccessEvent"));
            return;
        }

        internal function connectToDevicesStart():void
        {
            debug.Debug.ble("[connectToDevicesStart]");
            _bleController.addEventListener("DEVICE_CONNECTED", onBLEDeviceConnected);
            var loc1:*=[];
            var loc5:*=0;
            var loc4:*=bleDeviceList;
            for (var loc3:* in loc4) 
            {
                loc1.push(loc3);
            }
            var loc2:*=_bleController.connect(loc1);
            debug.Debug.ble("connectResult: " + resolveResult(loc2) + " [" + loc1.join(" | ") + "]");
            if (loc2 == -5) 
            {
                onBLEDeviceConnected(new de.pagecon.bleane.BleEvent("DEVICE_CONNECTED", [loc3, true]));
            }
            return;
        }

        internal function dataReceivedFromDevice(arg1:de.pagecon.bleane.BleEvent):void
        {
            if (currentDeviceHandler == null) 
            {
                debug.Debug.error("dataReceivedFromDevice error...");
                dispatchEvent(new service.event.DeviceCommunicationEvent("eventCommunicationError", ""));
                return;
            }
            if (currentDeviceHandler is handler.Rox110Handler || currentDeviceHandler is handler.dockingstation.Rox110DSHandler) 
            {
                dataReceivedFromDeviceRox110(arg1);
            }
            else 
            {
                dataReceivedFromDeviceRcMove(arg1);
            }
            return;
        }

        internal function dataReceivedFromDeviceRox110(arg1:de.pagecon.bleane.BleEvent):void
        {
            var loc3:*=0;
            var loc4:*=null;
            if (currentDeviceHandler == null) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 117, "USB > standardOutputDataHandler: current unit handler is null, "));
                dispatchEvent(new service.event.DeviceCommunicationEvent("eventCommunicationError", ""));
                return;
            }
            _receiveBuffer = _receiveBuffer.concat(arg1.content[3]);
            var loc2:*=_receiveBuffer.length;
            loc3 = 0;
            while (loc3 < loc2) 
            {
                if (_receiveBuffer[loc3] < 0) 
                {
                    var loc5:*=loc3;
                    var loc6:*=_receiveBuffer[loc5] + 256;
                    _receiveBuffer[loc5] = loc6;
                }
                ++loc3;
            }
            if (_packageCount == 0) 
            {
                dispatchEvent(new flash.events.Event("EVENT_BLE_TRANSFER_START"));
            }
            ++_packageCount;
            var loc1:*=currentDeviceHandler.currentBytesToReceive + currentDeviceHandler.currentReceiveChecksumLength;
            dispatchEvent(new handler.event.CustomCommunicationServiceProgressEvent("EVENT_BLE_TRANSFER_PROGRESS", 100 / loc2 * loc1));
            if (_receiveBuffer.length != loc1) 
            {
                if (_receiveBuffer.length > currentDeviceHandler.currentBytesToReceive) 
                {
                    _receiveBuffer = [];
                    dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 115, "USB > standardOutputDataHandler: , unitHandler: " + currentDeviceHandler.toString()));
                    dispatchEvent(new service.event.DeviceCommunicationEvent("eventCommunicationError", ""));
                }
                else 
                {
                    dispatchEvent(new flash.events.Event("waitForDataEvent"));
                }
            }
            else 
            {
                loc4 = new service.usb.event.DeviceDataCompleteEvent("usbComplete", currentDeviceHandler.currentCommand.toString(), _receiveBuffer, currentDeviceHandler.currentStartAdrr);
                _receiveBuffer = [];
                dispatchEvent(loc4);
                dispatchEvent(new flash.events.Event("EVENT_BLE_TRANSFER_END"));
            }
            return;
        }

        internal function dataReceivedFromDeviceRcMove(arg1:de.pagecon.bleane.BleEvent):void
        {
            var loc4:*=null;
            var loc5:*=null;
            var loc2:*=null;
            var loc1:*=0;
            var loc3:*=null;
            if (_waitForConfirmation) 
            {
                loc4 = arg1.content[3] as Array;
                _waitForConfirmation = false;
                if (loc4[0] == 240 && loc4[1] == 15) 
                {
                    dispatchEvent(new flash.events.Event("commandOkEvent"));
                    dispatchEvent(new flash.events.Event("EVENT_BLE_TRANSFER_START"));
                }
                else if (loc4[0] == 241 && loc4[1] == 14) 
                {
                    service.DeviceCommunicationHandler.getInstance().nativeProcessIsBusy = false;
                    dispatchEvent(new flash.events.Event("writeSuccessEvent"));
                }
                else if (loc4[0] == 252 && loc4[1] == 3) 
                {
                    debug.Debug.error("Unknown Command");
                    _stopAfterError = true;
                }
                else if (loc4[0] == 253 && loc4[1] == 2) 
                {
                    debug.Debug.error("Host MCU does not get the message from BLE Module");
                }
                else if (loc4[0] == 255 && loc4[1] == 0) 
                {
                    debug.Debug.error("Checksum Error");
                    _stopAfterError = true;
                    dispatchEvent(new flash.events.Event("stopWaitForDataEvent"));
                }
                else 
                {
                    _stopAfterError = true;
                    dispatchEvent(new flash.events.Event("stopWaitForDataEvent"));
                }
            }
            else if (!_stopAfterError) 
            {
                loc2 = (loc5 = arg1.content[3]).slice(3, (loc5.length - 1));
                _receiveBuffer = _receiveBuffer.concat(loc2);
                dispatchEvent(new flash.events.Event("waitForDataEvent"));
                loc1 = currentDeviceHandler.currentBytesToReceive;
                service.DeviceCommunicationHandler.getInstance().dispatchEvent(new flash.events.ProgressEvent("progressReadWriteEvent", false, false, _receiveBuffer.length, loc1));
                dispatchEvent(new handler.event.CustomCommunicationServiceProgressEvent("EVENT_BLE_TRANSFER_PROGRESS", 100 / _receiveBuffer.length * loc1));
                if (_receiveBuffer.length != loc1) 
                {
                    if (_receiveBuffer.length > currentDeviceHandler.currentBytesToReceive) 
                    {
                        debug.Debug.error("_stopAfterError error...");
                    }
                }
                else 
                {
                    dispatchEvent(new flash.events.Event("EVENT_BLE_TRANSFER_END"));
                    loc3 = new service.usb.event.DeviceDataCompleteEvent("usbComplete", currentDeviceHandler.currentCommand.toString(), _receiveBuffer, currentDeviceHandler.currentStartAdrr);
                    _receiveBuffer = [];
                    dispatchEvent(loc3);
                }
            }
            return;
        }

        public function disconnect(arg1:core.units.interfaces.IBLEDeviceInfo):void
        {
            _bleController.disconnect(arg1.deviceID);
            return;
        }

        public function resetBLEService():void
        {
            if (currentDeviceHandler == null || !(currentDeviceHandler is service.ble.BLEHandler)) 
            {
                return;
            }
            debug.Debug.ble(" --------- resetBLEService  --------- ");
            isConnected = false;
            _packageCount = 0;
            if (_bleController) 
            {
                _bleController.stopScan();
                _bleController.reset();
            }
            currentDeviceHandler = null;
            return;
        }

        internal function onDevcieDisconnected(arg1:de.pagecon.bleane.BleEvent):void
        {
            var loc1:*=null;
            if (isConnected) 
            {
                isConnected = false;
                loc1 = arg1.content[0];
                dispatchEvent(new service.ble.event.BLEDeviceEvent("bleDeviceDisconnectedEvent", bleDeviceList[loc1]));
                if (_autoConnect) 
                {
                    _connectTimeoutId = flash.utils.setTimeout(connectToDevicesStart, 2000);
                }
            }
            return;
        }

        internal function onError(arg1:de.pagecon.bleane.BleEvent):void
        {
            debug.Debug.error("ERROR\t " + arg1.content.toString());
            dispatchEvent(new service.event.DeviceCommunicationEvent("eventCommunicationError", arg1.content.toString()));
            resetBLEService();
            return;
        }

        public function getBLEStatus():int
        {
            return _bleController.getEnabledBleHw();
        }

        public function initBLEService(arg1:Boolean=true):void
        {
            _autoConnect = arg1;
            _bleController.addEventListener("DATA_RECEIVED", dataReceivedFromDevice);
            _bleController.addEventListener("DATA_WRITTEN", datasendToDevice);
            _bleController.addEventListener("ERROR", onError);
            _bleController.addEventListener("DEVICE_DISCONNECTED", onDevcieDisconnected);
            _bleController.addEventListener("ENABLED_STATE_CHANGED", onEnabledStateChanged);
            _bleController.addEventListener("DEVICE_PAIRED", onDevicePaired);
            _bleController.addEventListener("DEVICE_NOT_PAIRED", onDeviceNotPaired);
            if (_autoConnect) 
            {
                checkIDsAndConnect();
            }
            return;
        }

        public function destroy():void
        {
            flash.utils.clearTimeout(_connectTimeoutId);
            _bleController.removeEventListener("DATA_RECEIVED", dataReceivedFromDevice);
            _bleController.removeEventListener("DATA_WRITTEN", datasendToDevice);
            _bleController.removeEventListener("ERROR", onError);
            _bleController.removeEventListener("DEVICE_DISCONNECTED", onDevcieDisconnected);
            _bleController.removeEventListener("ENABLED_STATE_CHANGED", onEnabledStateChanged);
            _bleController.removeEventListener("DEVICE_PAIRED", onDevicePaired);
            _bleController.removeEventListener("DEVICE_NOT_PAIRED", onDeviceNotPaired);
            _bleController.reset();
            return;
        }

        public function askUserToEnableBLE():void
        {
            _bleController.askUserToEnableBle();
            return;
        }

        internal function onDevicePaired(arg1:de.pagecon.bleane.BleEvent):void
        {
            debug.Debug.ble("[DEVICE PAIRED] " + arg1.toString());
            dispatchEvent(new flash.events.Event("EVENT_BLE_DEVICE_PAIRED"));
            return;
        }

        internal function onDeviceNotPaired(arg1:de.pagecon.bleane.BleEvent):void
        {
            debug.Debug.ble("[DEVICE NOT PAIRED] " + arg1.toString());
            dispatchEvent(new flash.events.Event("EVENT_BLE_DEVICE_NOT_PAIRED"));
            return;
        }

        internal function onEnabledStateChanged(arg1:de.pagecon.bleane.BleEvent):void
        {
            var loc1:*=arg1.content[0];
            if (loc1 == 2 || loc1 == 1 || loc1 == 3) 
            {
                checkIDsAndConnect();
            }
            else if (loc1 == 0) 
            {
                if (currentDeviceHandler != null) 
                {
                    isConnected = false;
                    dispatchEvent(new service.ble.event.BLEDeviceEvent("bleDeviceDisconnectedEvent", bleDeviceList[currentDeviceHandler.port]));
                }
            }
            return;
        }

        public function startScanForNewDevices(arg1:Array=null):void
        {
            var loc2:*=0;
            var loc1:*=0;
            if (arg1 == null) 
            {
                arg1 = supportedBLEDevices;
            }
            var loc3:*=false;
            if (_bleController.isBleSupported()) 
            {
                loc2 = _bleController.getSelectedBleHw();
                if (loc2 != 2) 
                {
                    if (loc2 == 1) 
                    {
                        loc1 = _bleController.askUserToEnableBle();
                        if (loc1 != -20) 
                        {
                            loc3 = true;
                        }
                    }
                }
                else 
                {
                    loc3 = true;
                }
            }
            if (loc3) 
            {
                _bleController.addEventListener("DEVICE_DISCOVERED", onDeviceDiscovered);
                discoveredBleDevicesId = new flash.utils.Dictionary();
                _bleController.startScan(arg1);
            }
            else 
            {
                debug.Debug.warning("keine BLE unterstützung aktiv");
            }
            return;
        }

        public function stopScanForNewDevices():void
        {
            _bleController.stopScan();
            return;
        }

        internal function onDeviceDiscovered(arg1:de.pagecon.bleane.BleEvent):void
        {
            var loc5:*;
            var loc4:*=(loc5 = arg1.content as Array)[0] as String;
            var loc1:*=loc5[1] as String;
            var loc3:*=loc5[2] as String;
            if (supportedBLEDevices.indexOf(loc1) == -1) 
            {
                return;
            }
            debug.Debug.ble("ble device discovered - id: " + loc4 + ", name: " + loc3 + ", primary serice uuid: " + loc1);
            var loc2:*=new service.ble.BLEDevice(loc4, loc1, loc3);
            loc2.dsHandler = resolveDSHanlder(loc1);
            discoveredBleDevicesId[loc4] = loc2;
            dispatchEvent(new service.ble.event.BLEDeviceEvent("bleDeviceFoundEvent", loc2));
            return;
        }

        internal function resolveDSHanlder(arg1:String):String
        {
            var loc1:*=null;
            var loc2:*=arg1;
            while ("cc141a56-0b20-41f8-9b2b-f92ccc9b555f" === loc2) 
            {
                loc1 = "DS_BLE";
            }
        }

        public function addDeviceToDeviceList(arg1:core.units.interfaces.IBLEDeviceInfo):void
        {
            if (arg1 && !(arg1.deviceID == "")) 
            {
                if (supportedBLEDevices.indexOf(arg1.primaryServiceUUID) != -1) 
                {
                    debug.Debug.ble("addDeviceToDeviceList ::: " + arg1.deviceID + " " + arg1.localName + " " + arg1.dsHandler);
                    bleDeviceList[arg1.deviceID] = arg1;
                }
            }
            return;
        }

        public function removeDeviceFromDeviceList(arg1:core.units.interfaces.IBLEDeviceInfo):void
        {
            if (arg1) 
            {
                delete bleDeviceList[arg1.deviceID];
                debug.Debug.ble("removeDeviceFromDeviceList ::: " + arg1.deviceID + " " + arg1.localName + " " + arg1.dsHandler);
            }
            return;
        }

        public function stopScanAndConnect():void
        {
            debug.Debug.ble("[stopScanAndConnect]");
            _bleController.addEventListener("SCANNING_STATE_CHANGED", onStopedForConnect);
            _bleController.stopScan();
            return;
        }

        internal function onStopedForConnect(arg1:de.pagecon.bleane.BleEvent):void
        {
            debug.Debug.ble("[onStopedForConnect]");
            _bleController.removeEventListener("SCANNING_STATE_CHANGED", onStopedForConnect);
            _bleController.addEventListener("CONNECTION_REQUESTS_CANCELLED", onConnectionRequestCancelled);
            _bleController.cancelConnectionRequests();
            return;
        }

        internal function onConnectionRequestCancelled(arg1:de.pagecon.bleane.BleEvent):void
        {
            debug.Debug.ble("[onConnectionRequestCancelled]");
            _bleController.removeEventListener("CONNECTION_REQUESTS_CANCELLED", onConnectionRequestCancelled);
            _connectTimeoutId = flash.utils.setTimeout(connectToDevicesStart, 2000);
            return;
        }

        
        {
            supportedBLEDevices = [];
        }

        public function checkIDsAndConnect():void
        {
            flash.utils.clearTimeout(_connectTimeoutId);
            debug.Debug.ble("checkIDsAndConnect");
            _bleController.addEventListener("IDS_CHECKED", onIdsChecked);
            var loc1:*=[];
            var loc4:*=0;
            var loc3:*=bleDeviceList;
            for (var loc2:* in loc3) 
            {
                debug.Debug.ble("check: " + loc2);
                loc1.push(loc2);
            }
            debug.Debug.ble("deviceIdArray (" + loc1.length + ") " + loc1.join(" "));
            if (loc1.length > 0) 
            {
                _bleController.checkIds(loc1);
            }
            return;
        }

        internal function onIdsChecked(arg1:de.pagecon.bleane.BleEvent):void
        {
            debug.Debug.ble("onIdsChecked");
            _bleController.removeEventListener("IDS_CHECKED", onIdsChecked);
            _connectTimeoutId = flash.utils.setTimeout(connectToDevicesStart, 2000);
            return;
        }

        public function onBLEDeviceConnected(arg1:de.pagecon.bleane.BleEvent):void
        {
            var loc3:*=null;
            var loc4:*=0;
            var loc2:*=null;
            debug.Debug.ble("[onBLEDeviceConnected] " + arg1.type);
            var loc5:*=arg1.content[0] as String;
            var loc1:*=false;
            isConnected = true;
            if (arg1.content.hasOwnProperty(1)) 
            {
                loc1 = arg1.content[1] as Boolean;
            }
            debug.Debug.ble("alreadyConnected: " + loc1);
        }

        public function send(arg1:flash.utils.ByteArray, arg2:handler.DeviceHandler):int
        {
            var loc2:*=null;
            var loc1:*=0;
            if (arg2 == null) 
            {
                debug.Debug.ble("p_handler is null");
                return -17;
            }
            _waitForConfirmation = true;
            _stopAfterError = false;
            _packageCount = 0;
            currentDeviceHandler = arg2;
            var loc3:*=helper.ByteArray_helper.toArray(arg1);
            if (currentDeviceHandler is handler.UnitHandler && (currentDeviceHandler as handler.UnitHandler).unit is core.units.interfaces.IBLEDeviceInfo) 
            {
                if ((currentDeviceHandler as handler.UnitHandler).unit.type != core.general.UnitType.PC2814) 
                {
                    loc2 = bleDeviceList[((currentDeviceHandler as handler.UnitHandler).unit as core.units.interfaces.IBLEDeviceInfo).deviceID];
                }
                else 
                {
                    loc2 = bleDeviceList[(handler.HandlerFactory.getImplementationFromDS("DS_BLE") as handler.dockingstation.BLEDSHandler).port];
                }
            }
            else if (currentDeviceHandler is handler.dockingstation.DockingStationHandler && (currentDeviceHandler as handler.dockingstation.DockingStationHandler).isBLEHandler()) 
            {
                loc2 = bleDeviceList[currentDeviceHandler.port];
            }
            if (!loc2) 
            {
                debug.Debug.ble("bleDevie is null");
                return -17;
            }
            var loc4:*=loc2.primaryServiceUUID;
            while ("cc141a56-0b20-41f8-9b2b-f92ccc9b555f" === loc4) 
            {
                loc1 = _bleController.write(arg2.port, "cc141a56-0b20-41f8-9b2b-f92ccc9b555f", "b789edf9-12d0-412a-b34e-fe0f2998a0ad", loc3);
            }
        }

        public function sendMultipackage(arg1:flash.utils.ByteArray, arg2:handler.DeviceHandler, arg3:uint, arg4:uint):void
        {
            currentDeviceHandler = arg2;
            if (currentDeviceHandler.currentBytesToReceive > 0) 
            {
                dispatchEvent(new flash.events.Event("waitForDataEvent"));
            }
            _receiveBuffer = [];
            arg1.position = 0;
            _bufferSize = arg1.bytesAvailable;
            sendLoop(arg1, arg3, 1, arg4);
            return;
        }

        public static const CONNECTION_TIMEOUT:uint=10000;

        public static const EVENT_BLE_DEVICE_NOT_PAIRED:String="EVENT_BLE_DEVICE_NOT_PAIRED";

        public static const EVENT_BLE_DEVICE_PAIRED:String="EVENT_BLE_DEVICE_PAIRED";

        public static const EVENT_BLE_TRANSFER_END:String="EVENT_BLE_TRANSFER_END";

        public static const EVENT_BLE_TRANSFER_PROGRESS:String="EVENT_BLE_TRANSFER_PROGRESS";

        public static const EVENT_BLE_TRANSFER_START:String="EVENT_BLE_TRANSFER_START";

        internal static const BATTERY_LEVEL_CHARACTERISTIC_UUID:String="2a19";

        internal static const BATTERY_SERVICE_UUID:String="180f";

        internal static const HR_MEASUREMENT_CHARACTERISTIC_UUID:String="2a37";

        public static const HR_PRIMARY_SERVICE_UUID:String="180d";

        public var bleDeviceList:flash.utils.Dictionary;

        internal var _currentDeviceHandler:handler.DeviceHandler;

        public var isBLEsupported:Boolean=false;

        public var isConnected:Boolean=false;

        internal var _bleController:de.pagecon.bleane.BleController;

        internal var _bufferSize:uint=0;

        internal var _connectTimeoutId:uint=0;

        internal var _packageCount:uint=0;

        internal var _receiveBuffer:Array;

        internal var _receivedDataUncompleteTimer:flash.utils.Timer;

        internal var _stopAfterError:Boolean=false;

        internal var _waitForConfirmation:Boolean=true;

        internal var _autoConnect:Boolean=true;

        public static var loadUnitInformationOnConnect:Boolean=true;

        internal static var discoveredBleDevicesId:flash.utils.Dictionary;

        internal static var supportedBLEDevices:Array;
    }
}


