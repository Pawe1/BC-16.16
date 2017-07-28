//package service
//  package ble
//    package event
//      class BLEDeviceEvent
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


//    class BLEDevice
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


//    class BLEHandler
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


//  package cloud
//    class CloudAction
package service.cloud 
{
    import core.general.interfaces.*;
    import flash.events.*;
    import flash.filesystem.*;
    import flash.net.*;
    
    public class CloudAction extends Object
    {
        public function CloudAction(arg1:Function, arg2:String, arg3:String=null, arg4:Object=null, arg5:core.general.interfaces.ISynchronisable=null)
        {
            super();
            func = arg1;
            type = arg3;
            data = arg4;
            action = arg2;
            dataObject = arg5;
            return;
        }

        public function loadData(arg1:Function):void
        {
            completeCallback = arg1;
            if (dispatcher) 
            {
                dispatcher.addEventListener(completeEvent, onLoadDataComplete);
                func();
            }
            else 
            {
                func();
                completeCallback();
            }
            return;
        }

        internal function onLoadDataComplete(arg1:flash.events.Event):void
        {
            dispatcher.removeEventListener(completeEvent, onLoadDataComplete);
            if (completeCallback != null) 
            {
                completeCallback();
            }
            return;
        }

        public static function loadDataAction(arg1:flash.events.IEventDispatcher, arg2:Function, arg3:String=""):service.cloud.CloudAction
        {
            var loc1:*;
            (loc1 = new CloudAction(arg2, "loadData")).dispatcher = arg1;
            loc1.completeEvent = arg3;
            return loc1;
        }

        public static const ACTION_DELETE:String="actionDelete";

        public static const ACTION_DOWNLOAD:String="actionDownload";

        public static const ACTION_UPLOAD:String="actionUpload";

        public static const LOAD_DATA:String="loadData";

        public var action:String;

        public var completeCallback:Function;

        public var completeEvent:String;

        public var data:Object;

        public var dataObject:core.general.interfaces.ISynchronisable;

        public var deleteList:Array;

        public var dispatcher:flash.events.IEventDispatcher;

        public var file:flash.filesystem.File;

        public var func:Function;

        public var type:String;

        public var urlRequest:flash.net.URLRequest;

        public var urlStream:service.cloud.CloudURLStream;
    }
}


//    class CloudConfig
package service.cloud 
{
    public class CloudConfig extends Object
    {
        public function CloudConfig()
        {
            super();
            return;
        }

        public static const ACTIVITY_SYNC_COMPLETE:String="activitySyncComplete";

        public static const AUTO_SYNC_CHANGED:String="autoSyncChanged";

        public static const BASE_URL:String="https://www.sigma-data-cloud.com";

        public static const CLIENT_ID_ANDROID:String="dfed306c44564f565065687d534d6ec1";

        public static const CLIENT_ID_IOS:String="fd3d306c44564f5fd065687d534d6ea1";

        public static const CLIENT_ID_MAC:String="de3d306c44114f565065687d534d6efa";

        public static const CLIENT_ID_WINDOWS:String="653d306c44564f565065687d534d6e14";

        public static const CLIENT_SECRET_ANDROID:String="edffc4f97ed15a2c2ae4ea49d545e42c";

        public static const CLIENT_SECRET_IOS:String="1a9dcaf97ed15adeefe4ead9d545e4d1";

        public static const CLIENT_SECRET_MAC:String="d145ca897ed15ade3feffad9d545e4ef";

        public static const CLIENT_SECRET_WINDOWS:String="f869c4f97ed15ade2ae4ea49d545e46f";

        public static const DEVICE_DATA_SYNC_COMPLETE:String="deviceDataSyncComplete";

        public static const DEVICE_SYNC_COMPLETE:String="deviceSyncComplete";

        public static const DEVICE_TOTALS_SYNC_COMPLETE:String="deviceTotalsSyncComplete";

        public static const LOGIN_URL:String="https://www.sigma-data-cloud.com/portal/#/login";

        public static const PING_URL:String="https://www.sigma-data-cloud.com/portal";

        public static const REGISTRATION_URL:String="https://www.sigma-data-cloud.com/portal/#/login";

        public static const STATUS_DELETE:String="DELETE";

        public static const STATUS_DOWNLOAD:String="DOWNLOAD";

        public static const STATUS_UPLOAD:String="UPLOAD";

        public static const SYNC_COMPLETE:String="syncCompleteEvent";

        public static const SYNC_END:String="onSyncEnd";

        public static const SYNC_ERROR:String="syncErrorEvent";

        public static const SYNC_MESSAGE_CHANGED:String="syncMessageEvent";

        public static const SYNC_PROGRESS:String="syncProgressEvent";

        public static const SYNC_REQUEST_IOERROR:String="syncRequestIOError";

        public static const SYNC_STARTED:String="syncStartedEvent";

        public static const SYNC_UPDATE_CACHE:String="updateCacheEvent";

        public static const SYNC_URL:String="https://www.sigma-data-cloud.com/sync";

        public static const TRACK_SYNC_COMPLETE:String="trackSyncComplete";

        public static const TRAINING_PROGRAM_SYNC_COMPLETE:String="trainingProgramSyncComplete";

        public static const TYPE_ACTIVITY:String="ACTIVITY";

        public static const TYPE_DEVICE:String="DEVICE";

        public static const TYPE_DEVICE_SETTING:String="DEVICE_SETTING";

        public static const TYPE_DEVICE_TOTALS:String="DEVICE_TOTALS";

        public static const TYPE_TRACK:String="TRACK";

        public static const TYPE_TRAINING_PROGRAM:String="TRAINING_PROGRAM";

        public static const UPLOAD_ACTIVITY_URL:String="https://www.sigma-data-cloud.com/sync/upload/activity";

        public static const UPLOAD_DEVICE_SETTINGS_URL:String="https://www.sigma-data-cloud.com/sync/upload/device_settings";

        public static const UPLOAD_DEVICE_TOTALS_URL:String="https://www.sigma-data-cloud.com/sync/upload/device_totals";

        public static const UPLOAD_DEVICE_URL:String="https://www.sigma-data-cloud.com/sync/upload/device";

        public static const UPLOAD_TRACK_URL:String="https://www.sigma-data-cloud.com/sync/upload/track";

        public static const UPLOAD_TRAINING_PROGRAM_URL:String="https://www.sigma-data-cloud.com/sync/upload/training_program";
    }
}


//    class CloudEvent
package service.cloud 
{
    import flash.events.*;
    
    public class CloudEvent extends flash.events.Event
    {
        public function CloudEvent(arg1:String, arg2:String="", arg3:Object=null, arg4:String="", arg5:Number=NaN, arg6:Boolean=false, arg7:Boolean=false)
        {
            super(arg1, arg6, arg7);
            dataType = arg2;
            data = arg3;
            GUID = arg4;
            modificationDate = arg5;
            return;
        }

        public static function fromObject(arg1:Object):service.cloud.CloudEvent
        {
            var loc1:*=new CloudEvent(arg1.type, arg1.dataType, arg1.data, arg1.GUID, arg1.modificationDate, arg1.bubbles, arg1.cancelable);
            loc1.access_token = arg1.access_token;
            loc1.displayLabel = arg1.displayLabel;
            loc1.syncStatus = arg1.syncStatus;
            loc1.syncStatusType = arg1.syncStatusType;
            return loc1;
        }

        public static function toObject(arg1:service.cloud.CloudEvent):Object
        {
            return {"type":arg1.type, "dataType":arg1.dataType, "displayLabel":arg1.displayLabel, "data":arg1.data, "GUID":arg1.GUID, "modificationDate":arg1.modificationDate, "access_token":arg1.access_token, "bubbles":arg1.bubbles, "cancelable":arg1.cancelable, "syncStatus":arg1.syncStatus, "syncStatusType":arg1.syncStatusType};
        }

        public static const DATA_CHANGED:String="dataChangedEvent";

        public static const DELETE_RESULT:String="deleteResult";

        public static const DOWNLOAD_RESULT:String="downloadResult";

        public static const PROGRESS:String="progressEvent";

        public static const START_SYNC:String="startSyncEvent";

        public static const SYNC_LIST_LOADED:String="syncListLoaded";

        public var GUID:String;

        public var access_token:String;

        public var data:Object;

        public var dataType:String;

        public var displayLabel:String;

        public var modificationDate:Number;

        public var syncStatus:Array;

        public var syncStatusType:String;
    }
}


//    class CloudURLStream
package service.cloud 
{
    import flash.net.*;
    
    public class CloudURLStream extends flash.net.URLStream
    {
        public function CloudURLStream()
        {
            super();
            return;
        }

        public var data:Object;

        public var type:String;
    }
}


//    class CommonCloudHandler
package service.cloud 
{
    import com.adobe.serialization.json.*;
    import configCache.*;
    import debug.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;
    import mx.events.*;
    import utils.*;
    
    public class CommonCloudHandler extends flash.events.EventDispatcher
    {
        public function CommonCloudHandler(arg1:flash.events.IEventDispatcher=null)
        {
            syncRunning = false;
            _urlLoader = new flash.net.URLLoader();
            _intitialSyncStatus = [0, 0, 0, 0, 0, 0, 0];
            _syncSequence = ["ACTIVITY", "TRACK", "DEVICE", "TRAINING_PROGRAM", "DEVICE_SETTING", "DEVICE_TOTALS"];
            super(arg1);
            return;
        }

        public function startTrainingProgramSynchronisation():void
        {
            logSyncStatus("startTrainingProgramSynchronisation");
            var loc1:*=new service.cloud.CloudEvent("startSyncEvent");
            loc1.syncStatus = _intitialSyncStatus;
            loc1.dataType = "TRAINING_PROGRAM";
            loc1.displayLabel = utils.LanguageManager.getString("CLOUD_SYNC_TYPE_TRAINING_PROGRAMS");
            dispatchEvent(loc1);
            sendSyncRequest(createSyncRequestString("TRAINING_PROGRAM"));
            return;
        }

        public function onError(arg1:flash.events.IOErrorEvent):void
        {
            _urlLoader.removeEventListener("complete", answerReady);
            _urlLoader.removeEventListener("ioError", onError);
            var loc1:*=arg1.text;
            logSyncStatus("Error: " + loc1);
            stopSync();
            dispatchEvent(new flash.events.Event("syncRequestIOError"));
            return;
        }

        public function get syncRunning():Boolean
        {
            return this.syncRunning;
        }

        public function set syncRunning(arg1:Boolean):void
        {
            var loc1:*=this.syncRunning;
            if (loc1 !== arg1) 
            {
                this.syncRunning = arg1;
                if (this.hasEventListener("propertyChange")) 
                {
                    this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "syncRunning", loc1, arg1));
                }
            }
            return;
        }

        public function answerReady(arg1:flash.events.Event):void
        {
            _urlLoader.removeEventListener("complete", answerReady);
            _urlLoader.removeEventListener("ioError", onError);
            var loc2:*=(arg1.target as flash.net.URLLoader).data;
            logSyncStatus("Antwort: " + loc2.toString().substr(0, 200));
            var loc1:*=new service.cloud.CloudEvent("onSyncAnswerReady", null, loc2);
            loc1.access_token = configCache.ConfigCache.getInstance().configCacheObject.accessToken();
            dispatchEvent(loc1);
            return;
        }

        public function startAutoSync(arg1:service.cloud.CloudEvent):void
        {
            if (!configCache.ConfigCache.getInstance().configCacheObject.autoSync()) 
            {
                return;
            }
            if (syncRunning) 
            {
                flash.utils.setTimeout(startAutoSync, _autoSyncOnDataChangeInterval, arg1);
                return;
            }
            if (_currentSyncTimeout == 0) 
            {
                logSyncStatus("startAutoSync");
            }
            else 
            {
                logSyncStatus("startAutoSync (reset)");
                flash.utils.clearTimeout(_currentSyncTimeout);
                _currentSyncTimeout = 0;
            }
            _syncSequenceIndex = 0;
            _currentSyncTimeout = flash.utils.setTimeout(doSync, _autoSyncOnDataChangeInterval);
            return;
        }

        public function onSyncError(arg1:String):void
        {
            logSyncStatus("onSyncError: " + arg1);
            stopSync();
            dispatchEvent(new flash.events.Event("syncRequestIOError"));
            return;
        }

        protected function addAutoSyncEventListener():void
        {
            return;
        }

        protected function removeAutoSyncEventListener():void
        {
            return;
        }

        protected function createSyncRequestString(arg1:String):String
        {
            return "";
        }

        protected function generateSyncList(arg1:*, arg2:String):String
        {
            var loc1:*=null;
            var loc3:*=null;
            var loc2:*=arg1;
            var loc4:*=[];
            var loc5:*=configCache.ConfigCache.getInstance().configCacheObject.lastSyncDate();
            logSyncStatus("generateSyncList: " + arg2 + ", lastSyncDate: " + loc5);
            var loc6:*;
            (loc6 = {}).dataList = {};
            loc6.dataList.type = arg2;
            loc6.dataList.lastSync = loc5;
            var loc8:*=0;
            var loc7:*=loc2;
            for each (loc3 in loc7) 
            {
                loc1 = {};
                if (!(!(loc3.GUID == "") && (loc3.modificationDate > loc5 || loc3.isDeleted))) 
                {
                    continue;
                }
                loc1.GUID = loc3.GUID;
                loc1.modificationDate = loc3.modificationDate;
                loc1.toDelete = loc3.isDeleted;
                loc4.push(loc1);
            }
            loc6.dataList.list = loc4;
            return com.adobe.serialization.json.JSON.encode(loc6);
        }

        protected function repeatSync():void
        {
            _syncStopped = true;
            _syncSequenceIndex = 0;
            flash.utils.clearTimeout(_currentSyncTimeout);
            _currentSyncTimeout = 0;
            flash.utils.clearTimeout(_maxSyncDurationTimeout);
            _maxSyncDurationTimeout = 0;
            syncRunning = false;
            logSyncStatus("repeatSync");
            dispatchEvent(new flash.events.Event("syncCompleteEvent"));
            dispatchEvent(new service.cloud.CloudEvent("onSyncStopped"));
            _currentSyncTimeout = flash.utils.setTimeout(doSync, 2000);
            return;
        }

        internal function doSync():void
        {
            logSyncStatus("doSync - sync running: " + syncRunning);
            if (_syncSequenceIndex >= _syncSequence.length || loggedOut) 
            {
                logSyncStatus("\n< sync complete");
                if (!loggedOut) 
                {
                    configCache.ConfigCache.getInstance().updateLastSyncDate();
                }
                stopSync();
                if (configCache.ConfigCache.getInstance().configCacheObject.autoSync() && !loggedOut) 
                {
                    _currentSyncTimeout = flash.utils.setTimeout(doSync, _autoSyncWithoutChangesInterval);
                }
                return;
            }
            if (_syncSequenceIndex == 0) 
            {
                logSyncStatus("sync started >");
                _maxSyncDurationTimeout = flash.utils.setTimeout(repeatSync, _maxSyncDuration);
                syncRunning = true;
                dispatchEvent(new flash.events.Event("syncStartedEvent"));
            }
            var loc1:*=_syncSequence[_syncSequenceIndex];
            logSyncStatus("\n- sync: " + loc1);
            var loc2:*=loc1;
            while ("ACTIVITY" === loc2) 
            {
                addEventListener("activitySyncComplete", onTypeSyncComplete);
                startActivitySynchronisation();
            }
        }

        internal function sendSyncRequest(arg1:String):void
        {
            var loc1:*=new flash.net.URLRequest("https://www.sigma-data-cloud.com/sync?access_token=" + configCache.ConfigCache.getInstance().configCacheObject.accessToken());
            loc1.idleTimeout = 300000;
            loc1.data = arg1;
            loc1.method = "POST";
            loc1.contentType = "application/json";
            logSyncStatus("sendSyncRequest - Anfrage: " + arg1);
            _urlLoader.addEventListener("complete", answerReady);
            _urlLoader.addEventListener("ioError", onError);
            return;
        }

        public static function getInstance():service.cloud.CommonCloudHandler
        {
            if (_instance == null) 
            {
                _instance = new CommonCloudHandler();
            }
            return _instance;
        }

        public static function setInstance(arg1:service.cloud.CommonCloudHandler):void
        {
            _instance = arg1;
            return;
        }

        public function logSyncStatus(arg1:String):void
        {
            debug.Debug.cloud("[CommonCloudHandler] " + arg1);
            return;
        }

        public function initAccoutEvents(arg1:flash.display.Stage):void
        {
            logSyncStatus("initAccoutEvents");
            return;
        }

        public function onLoggedIn(arg1:flash.events.Event):void
        {
            if (loggedOut) 
            {
                loggedOut = false;
                logSyncStatus("onLoggedIn: " + arg1.toString());
                startFirstSync();
                addAutoSyncEventListener();
            }
            return;
        }

        public function onLoggedOut(arg1:flash.events.Event):void
        {
            if (!loggedOut) 
            {
                loggedOut = true;
                logSyncStatus("onLoggedOut: " + arg1.toString());
                stopSync();
                configCache.ConfigCache.getInstance().resetLastSyncDate();
                removeAutoSyncEventListener();
            }
            return;
        }

        public function startFullManualSync():void
        {
            configCache.ConfigCache.getInstance().resetLastSyncDate();
            if (_currentSyncTimeout != 0) 
            {
                flash.utils.clearTimeout(_currentSyncTimeout);
                _currentSyncTimeout = 0;
            }
            doSync();
            return;
        }

        public function startFirstSync():void
        {
            if (!configCache.ConfigCache.getInstance().configCacheObject.autoSync() || syncRunning) 
            {
                return;
            }
            if (_currentSyncTimeout != 0) 
            {
                flash.utils.clearTimeout(_currentSyncTimeout);
                _currentSyncTimeout = 0;
            }
            _syncSequenceIndex = 0;
            _currentSyncTimeout = flash.utils.setTimeout(doSync, _firstSyncInterval);
            return;
        }

        public function startManualSync():void
        {
            if (_currentSyncTimeout != 0) 
            {
                flash.utils.clearTimeout(_currentSyncTimeout);
                _currentSyncTimeout = 0;
            }
            _syncSequenceIndex = 0;
            doSync();
            return;
        }

        public function setAutoSync(arg1:Boolean):void
        {
            autoSync = arg1;
            if (!arg1) 
            {
                if (syncRunning) 
                {
                    stopSync();
                }
                else if (_currentSyncTimeout != 0) 
                {
                    flash.utils.clearTimeout(_currentSyncTimeout);
                    _currentSyncTimeout = 0;
                }
            }
            configCache.ConfigCache.getInstance().configCacheObject.setProperty("autoSync", arg1);
            configCache.ConfigCache.getInstance().saveCache();
            if (!syncRunning && arg1) 
            {
                startFirstSync();
            }
            dispatchEvent(new flash.events.Event("autoSyncChanged"));
            return;
        }

        internal function onTypeSyncComplete(arg1:flash.events.Event):void
        {
            logSyncStatus("onTypeSyncComplete: " + arg1.type + ", syncRunning: " + syncRunning + ", syncStopped: " + _syncStopped);
            var loc1:*=arg1.type;
            while ("activitySyncComplete" === loc1) 
            {
                removeEventListener("activitySyncComplete", onTypeSyncComplete);
            }
        }

        public function stopSync():void
        {
            var loc1:*=null;
            logSyncStatus("stopSync");
            _syncSequenceIndex = 0;
            flash.utils.clearTimeout(_currentSyncTimeout);
            _currentSyncTimeout = 0;
            flash.utils.clearTimeout(_maxSyncDurationTimeout);
            _maxSyncDurationTimeout = 0;
            if (syncRunning) 
            {
                syncRunning = false;
                dispatchEvent(new flash.events.Event("syncCompleteEvent"));
                loc1 = new service.cloud.CloudEvent("onSyncStopped");
                dispatchEvent(loc1);
            }
            return;
        }

        public function getCurrentTypeDisplayLabel():String
        {
            var loc1:*="";
            var loc2:*=_syncSequence[_syncSequenceIndex];
            while ("ACTIVITY" === loc2) 
            {
                loc1 = utils.LanguageManager.getString("CLOUD_SYNC_TYPE_ACTIVITY");
            }
        }

        public function startActivitySynchronisation():void
        {
            logSyncStatus("startActivitySynchronisation");
            var loc1:*=new service.cloud.CloudEvent("startSyncEvent");
            loc1.syncStatus = _intitialSyncStatus;
            loc1.dataType = "ACTIVITY";
            loc1.displayLabel = utils.LanguageManager.getString("CLOUD_SYNC_TYPE_ACTIVITY");
            dispatchEvent(loc1);
            sendSyncRequest(createSyncRequestString("ACTIVITY"));
            return;
        }

        public function startTrackSynchronisation():void
        {
            logSyncStatus("startTrackSynchronisation");
            var loc1:*=new service.cloud.CloudEvent("startSyncEvent");
            loc1.syncStatus = _intitialSyncStatus;
            loc1.dataType = "TRACK";
            loc1.displayLabel = utils.LanguageManager.getString("CLOUD_SYNC_TYPE_TRACKS");
            dispatchEvent(loc1);
            sendSyncRequest(createSyncRequestString("TRACK"));
            return;
        }

        public function startDeviceSynchronisation():void
        {
            logSyncStatus("startDeviceSynchronisation");
            var loc1:*=new service.cloud.CloudEvent("startSyncEvent");
            loc1.syncStatus = _intitialSyncStatus;
            loc1.dataType = "DEVICE";
            loc1.displayLabel = utils.LanguageManager.getString("CLOUD_SYNC_TYPE_DEVICES");
            dispatchEvent(loc1);
            sendSyncRequest(createSyncRequestString("DEVICE"));
            return;
        }

        public function startDeviceTotalsSynchronisation():void
        {
            logSyncStatus("startDeviceTotalsSynchronisation");
            var loc1:*=new service.cloud.CloudEvent("startSyncEvent");
            loc1.syncStatus = _intitialSyncStatus;
            loc1.dataType = "DEVICE_TOTALS";
            loc1.displayLabel = utils.LanguageManager.getString("CLOUD_SYNC_TYPE_DEVICE_TOTALS");
            dispatchEvent(loc1);
            sendSyncRequest(createSyncRequestString("DEVICE_TOTALS"));
            return;
        }

        public function startDeviceDataSynchronisation():void
        {
            logSyncStatus("startDeviceSettingsSynchronisation");
            var loc1:*=new service.cloud.CloudEvent("startSyncEvent");
            loc1.syncStatus = _intitialSyncStatus;
            loc1.dataType = "DEVICE_SETTING";
            loc1.displayLabel = utils.LanguageManager.getString("CLOUD_SYNC_TYPE_DEVICE_DATA");
            dispatchEvent(loc1);
            sendSyncRequest(createSyncRequestString("DEVICE_SETTING"));
            return;
        }

        public static const SYNC_ANSWER_READY:String="onSyncAnswerReady";

        public static const STOP_SYNC:String="onSyncStopped";

        public var autoSync:Boolean=true;

        internal var syncRunning:Boolean;

        protected var _firstSyncInterval:int=3000;

        internal var _autoSyncOnDataChangeInterval:int=20000;

        internal var _autoSyncWithoutChangesInterval:int=300000;

        internal var _currentSyncTimeout:int=0;

        internal var _intitialSyncStatus:Array;

        internal var _maxSyncDuration:int=5400000;

        internal var _maxSyncDurationTimeout:int=0;

        internal var _syncSequence:Array;

        internal var _syncSequenceIndex:uint=0;

        internal var _syncStopped:Boolean=false;

        internal var loggedOut:Boolean=true;

        internal static var _instance:service.cloud.CommonCloudHandler;

        protected var _urlLoader:flash.net.URLLoader;
    }
}


//  package event
//    class DeviceCommunicationEvent
package service.event 
{
    import flash.events.*;
    
    public class DeviceCommunicationEvent extends flash.events.Event
    {
        public function DeviceCommunicationEvent(arg1:String, arg2:String="")
        {
            super(arg1);
            message = arg2;
            return;
        }

        public static const EVENT_COMMUNICATION_ERROR:String="eventCommunicationError";

        public var message:String="";
    }
}


//    class DeviceConnectionEvent
package service.event 
{
    import flash.events.*;
    
    public class DeviceConnectionEvent extends flash.events.Event
    {
        public function DeviceConnectionEvent(arg1:String, arg2:String, arg3:String, arg4:Boolean=false, arg5:Boolean=false)
        {
            super(arg1, arg4, arg5);
            _connectedDevicePort = arg2;
            _dockingStation = arg3;
            return;
        }

        public function get dockingStation():String
        {
            return _dockingStation;
        }

        public function set dockingStation(arg1:String):void
        {
            _dockingStation = arg1;
            return;
        }

        public function get usbPort():String
        {
            return _connectedDevicePort;
        }

        public function set usbPort(arg1:String):void
        {
            _connectedDevicePort = arg1;
            return;
        }

        public static const DEVICE_ALREADY_CONNECTED:String="deviceAlreadyConnected";

        public static const DEVICE_CONNECTED:String="deviceConnected";

        public static const DEVICE_DISCONNECTED:String="deviceDisconnected";

        public static const DEVICE_FOUND:String="deviceFound";

        internal var _dockingStation:String;

        internal var _connectedDevicePort:String;
    }
}


//  package nfc
//    class NFCHandler
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


//    class NfcProtocolCmd
package service.nfc 
{
    public class NfcProtocolCmd extends Object
    {
        public function NfcProtocolCmd()
        {
            super();
            return;
        }

        public static const NFC_CHECKSUM_CONST:uint=1;

        public static const NFC_GET_CMD:uint=250;

        public static const NFC_GET_LIST_PH_CMD:uint=1;

        public static const NFC_GET_LIST_PH_CMD_RQST_LEN:uint=9;

        public static const NFC_GET_LIST_PH_CMD_RSP_LEN:uint=7;

        public static const NFC_GET_LOG_DATA_CMD:uint=4;

        public static const NFC_GET_LOG_DATA_CMD_RQST_LEN:uint=9;

        public static const NFC_GET_PH_INFO_CMD:uint=3;

        public static const NFC_GET_PH_INFO_CMD_RQST_LEN:uint=9;

        public static const NFC_GET_PH_INFO_CMD_RSP_LEN:uint=71;
    }
}


//    class NfcQueObj
package service.nfc 
{
    import __AS3__.vec.*;
    import core.activities.*;
    import flash.utils.*;
    import helper.*;
    
    public class NfcQueObj extends Object
    {
        public function NfcQueObj(arg1:flash.utils.ByteArray, arg2:uint=0, arg3:Boolean=true, arg4:uint=0, arg5:Boolean=false)
        {
            packages = new __AS3__.vec.Vector.<service.nfc.NfcQuePackage>();
            resultBytes = [];
            super();
            sendCommand = arg1;
            queSize = arg2;
            waitForAllCommands = arg3;
            delay = arg4;
            keepTagOpen = arg5;
            return;
        }

        public function get length():Number
        {
            return _length;
        }

        public function set length(arg1:Number):void
        {
            _length = arg1;
            return;
        }

        public function get queSize():uint
        {
            return _queSize;
        }

        public function set queSize(arg1:uint):void
        {
            _queSize = arg1 < 1 ? 1 : arg1;
            return;
        }

        public function getProgress():uint
        {
            if (length == 0) 
            {
                return 0;
            }
            var loc1:*=length / 64;
            return 100 / loc1 * packages.length;
        }

        public function toString():String
        {
            var loc1:*="[NfcQueObj] ";
            loc1 = loc1 + ("\n\t ::: queSize: " + queSize);
            loc1 = loc1 + ("\n\t ::: sendCommand: " + helper.ByteArray_helper.toArray(sendCommand).join(" "));
            loc1 = loc1 + ("\n\t ::: waitForAllCommands: " + waitForAllCommands.toString());
            loc1 = loc1 + ("\n\t ::: readDelay: " + readDelay.toString());
            loc1 = loc1 + ("\n\t ::: readBlockDelayay: " + readBlockDelay.toString());
            loc1 = loc1 + ("\n\t ::: fifoBit: " + fifoBit.toString());
            if (buffer != null) 
            {
                loc1 = loc1 + ("\n\t ::: buffer size: " + buffer.bytesAvailable);
                loc1 = loc1 + ("\n\t ::: buffer length: " + buffer.length);
            }
            if (startBlock > 0) 
            {
                loc1 = loc1 + ("\n\t ::: startBlock: " + startBlock);
            }
            if (endBlock > 0) 
            {
                loc1 = loc1 + ("\n\t ::: endBlock: " + endBlock);
            }
            if (length > 0) 
            {
                loc1 = loc1 + ("\n\t ::: length: " + length);
            }
            if (dataByteString.length > 0) 
            {
                loc1 = loc1 + ("\n\t ::: dataByteString: " + dataByteString);
            }
            if (guid != "") 
            {
                loc1 = loc1 + ("\n\t ::: guid: " + guid);
            }
            return loc1;
        }

        public var activity:core.activities.Activity;

        public var buffer:flash.utils.ByteArray;

        public var command:uint=0;

        public var corruptedStartBlock:uint=0;

        public var currentEndBlock:uint=0;

        public var dataByteString:String="";

        public var delay:uint=0;

        public var endBlock:uint=0;

        public var errorOnBlock:uint=0;

        public var fifoBit:uint=1;

        public var guid:String="";

        public var keepTagOpen:Boolean=false;

        internal var _length:Number=0;

        public var packages:__AS3__.vec.Vector.<service.nfc.NfcQuePackage>;

        internal var _queSize:uint;

        public var readBlockDelay:uint=4;

        public var readDelay:uint=6;

        public var result:String="";

        public var resultBytes:Array;

        public var sendCommand:flash.utils.ByteArray;

        public var startBlock:uint=0;

        public var waitForAllCommands:Boolean=true;
    }
}


//    class NfcQuePackage
package service.nfc 
{
    import de.pagecon.ane.nfc.events.*;
    
    public class NfcQuePackage extends Object
    {
        public function NfcQuePackage(arg1:de.pagecon.ane.nfc.events.NfcEvent=null)
        {
            super();
            if (arg1 != null) 
            {
                byteString = arg1.byteString;
                endAddr = arg1.endAddr;
                errorCode = arg1.errorCode;
                errorMessage = arg1.errorMessage;
                rArray = arg1.rArray;
                startAddr = arg1.startAddr;
            }
            return;
        }

        public var byteString:String;

        public var endAddr:uint;

        public var errorCode:uint;

        public var errorMessage:String;

        public var rArray:Array;

        public var startAddr:uint;
    }
}


//  package oauth
//    class CommonOAuth
package service.oauth 
{
    import com.adobe.protocols.oauth2.*;
    import com.adobe.protocols.oauth2.event.*;
    import com.adobe.protocols.oauth2.grant.*;
    import configCache.*;
    import debug.*;
    import flash.display.*;
    import flash.events.*;
    import flash.media.*;
    import flash.net.*;
    import mx.events.*;
    import org.as3commons.logging.setup.*;
    import utils.*;
    
    public class CommonOAuth extends flash.events.EventDispatcher
    {
        public function CommonOAuth(arg1:flash.events.IEventDispatcher=null)
        {
            popupTitle = "";
            super(arg1);
            return;
        }

        public function set popupTitle(arg1:String):void
        {
            var loc1:*=this.popupTitle;
            if (loc1 !== arg1) 
            {
                this.popupTitle = arg1;
                if (this.hasEventListener("propertyChange")) 
                {
                    this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "popupTitle", loc1, arg1));
                }
            }
            return;
        }

        public function get refreshToken():String
        {
            _refreshToken = configCache.ConfigCache.getInstance().getValue(className + "refreshToken", null);
            return _refreshToken;
        }

        public function get popupTitle():String
        {
            return this.popupTitle;
        }

        public function get label():String
        {
            return this.label;
        }

        public function set label(arg1:String):void
        {
            var loc1:*=this.label;
            if (loc1 !== arg1) 
            {
                this.label = arg1;
                if (this.hasEventListener("propertyChange")) 
                {
                    this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "label", loc1, arg1));
                }
            }
            return;
        }

        public function set refreshToken(arg1:String):void
        {
            if (_refreshToken != arg1) 
            {
                _refreshToken = arg1;
                configCache.ConfigCache.getInstance().setValue(className + "refreshToken", arg1);
            }
            return;
        }

        public function get loggedOut():Boolean
        {
            return _loggedOut;
        }

        public function set loggedOut(arg1:Boolean):void
        {
            _loggedOut = arg1;
            if (_loggedOut) 
            {
                debug("user logged out");
                dispatchEvent(new flash.events.Event("loggedOutEvent"));
            }
            else 
            {
                debug("user logged in");
                dispatchEvent(new flash.events.Event("loggedInEvent"));
            }
            return;
        }

        protected function doOAuthCall(arg1:flash.media.StageWebView):void
        {
            var loc1:*=null;
            var loc2:*=new com.adobe.protocols.oauth2.OAuth2(AUTHORIZE_URL, TOKEN_URL, org.as3commons.logging.setup.LogSetupLevel.NONE);
            loc2.requestHeader = requestHeader;
            loc2.useURLDecode = useURLDecode;
            if (implicitGrant) 
            {
                loc1 = new com.adobe.protocols.oauth2.grant.ImplicitGrant(arg1, CLIENT_ID, REDIRECT_URI, SCOPE, STATE, PARAMS);
            }
            else 
            {
                loc1 = new com.adobe.protocols.oauth2.grant.AuthorizationCodeGrant(arg1, CLIENT_ID, CLIENT_SECRET, REDIRECT_URI, SCOPE, STATE, PARAMS);
            }
            loc2.addEventListener("getAccessToken", onGetAccessToken);
            loc2.addEventListener("progressEvent", onAuthorizeProgress);
            loc2.getAccessToken(loc1);
            return;
        }

        public function get accessToken():String
        {
            _accessToken = configCache.ConfigCache.getInstance().getValue(className + "token", null);
            return _accessToken;
        }

        public function set accessToken(arg1:String):void
        {
            if (_accessToken != arg1) 
            {
                _accessToken = arg1;
                configCache.ConfigCache.getInstance().setValue(className + "token", arg1);
            }
            return;
        }

        public function get requestHeader():flash.net.URLRequestHeader
        {
            return _requestHeader;
        }

        public function set requestHeader(arg1:flash.net.URLRequestHeader):void
        {
            _requestHeader = arg1;
            return;
        }

        protected function refresh_token():void
        {
            var loc1:*=new com.adobe.protocols.oauth2.OAuth2(AUTHORIZE_URL, TOKEN_URL, org.as3commons.logging.setup.LogSetupLevel.NONE);
            loc1.requestHeader = requestHeader;
            loc1.addEventListener("refreshAccessToken", onRefreshAccessToken);
            loc1.refreshAccessToken(refreshToken, CLIENT_ID, CLIENT_SECRET, SCOPE);
            return;
        }

        protected function onRefreshAccessToken(arg1:com.adobe.protocols.oauth2.event.RefreshAccessTokenEvent):void
        {
            var loc1:*=null;
            (arg1.currentTarget as com.adobe.protocols.oauth2.OAuth2).removeEventListener("refreshAccessToken", onRefreshAccessToken);
            if (arg1.errorCode == null && arg1.errorMessage == null) 
            {
                if (arg1.accessToken) 
                {
                    accessToken = arg1.accessToken;
                    debug.Debug.info("----------------------- " + className + ": ACCESS TOKEN REFRESHED !!!! ---------------------------");
                    loggedOut = false;
                    loc1 = new Date();
                    loc1.setSeconds(loc1.seconds + arg1.expiresIn);
                    setAccessTokenExpiresIn_timestamp(loc1.time);
                    return;
                }
            }
            else 
            {
                debug.Debug.error("----------------------- " + className + ": REFRESH ACCESS TOKEN ERROR !!!! ---------------------------");
                loggedOut = true;
                accessToken = null;
                checkUserLogin();
            }
            return;
        }

        protected function doLogout():void
        {
            accessToken = null;
            authorizationCode = null;
            loggedOut = true;
            setAccessTokenExpiresIn_timestamp(0);
            refreshToken = null;
            debug("logout complete");
            return;
        }

        public function destructor():void
        {
            return;
        }

        public function showWebViewer(arg1:Boolean):void
        {
            return;
        }

        public function logout():void
        {
            return;
        }

        public function getAccessTokenExpiresIn_timestamp():Number
        {
            return configCache.ConfigCache.getInstance().getValue(className + "tokenExpirationTimestamp", 0);
        }

        public function setAccessTokenExpiresIn_timestamp(arg1:Number):void
        {
            configCache.ConfigCache.getInstance().setValue(className + "tokenExpirationTimestamp", arg1);
            return;
        }

        public function checkLogin(arg1:flash.display.Stage, arg2:Boolean):void
        {
            debug("check login state");
            _stage = arg1;
            showWebViewOnCheckLogin = arg2;
            checkUserLogin();
            return;
        }

        public function hideWebViewer():void
        {
            debug("hideWebViewer");
            destructor();
            return;
        }

        public function getCompleteHTTPStatus():int
        {
            return 200;
        }

        public function getErrorMessage(arg1:int):String
        {
            return utils.LanguageManager.getString("SHARING_STATUS_GENERAL_ERROR");
        }

        protected function getStageWebView():flash.media.StageWebView
        {
            return null;
        }

        protected function initWebView():void
        {
            return;
        }

        protected function debug(arg1:String=""):void
        {
            debug.Debug.debug("CLASS: " + className + "\t message: " + arg1 + "\n\t\tSTATUS - authorizationCode: " + authorizationCode + "\taccessToken: " + accessToken + "\trefreshToken: " + refreshToken + "\tloggedOut: " + loggedOut + "\tlastLocation: " + lastLocation);
            return;
        }

        protected function checkUserLogin():void
        {
            var loc1:*=null;
            if (checkAccessToken()) 
            {
                return;
            }
            _loggedOut = true;
            initWebView();
            showWebViewer(false);
            try 
            {
                loc1 = getStageWebView();
                doOAuthCall(loc1);
            }
            catch (e:Error)
            {
            };
            return;
        }

        protected function onGetAccessToken(arg1:com.adobe.protocols.oauth2.event.GetAccessTokenEvent):void
        {
            var loc1:*=null;
            if (arg1.errorCode == null && arg1.errorMessage == null) 
            {
                if (arg1.accessToken) 
                {
                    accessToken = arg1.accessToken;
                    refreshToken = arg1.refreshToken;
                    loggedOut = false;
                    loc1 = new Date();
                    loc1.setSeconds(loc1.seconds + arg1.expiresIn);
                    setAccessTokenExpiresIn_timestamp(loc1.time);
                }
                debug("onGetAccessToken");
            }
            else 
            {
                debug("onGetAccessToken error: " + arg1.errorMessage);
            }
            if (!loggedOut) 
            {
                hideWebViewer();
            }
            return;
        }

        protected function onAuthorizeProgress(arg1:com.adobe.protocols.oauth2.event.OAut2ProgressEvent):void
        {
            if (arg1.authorizationCode) 
            {
                authorizationCode = arg1.authorizationCode;
            }
            if (arg1.accessToken) 
            {
                accessToken = arg1.accessToken;
            }
            debug("onAuthorizeProgress");
            return;
        }

        protected function checkAccessToken():Boolean
        {
            if (!accessToken) 
            {
                return false;
            }
            var loc1:*=getAccessTokenExpiresIn_timestamp();
            if (loc1 < new Date().time) 
            {
                refresh_token();
            }
            else 
            {
                loggedOut = false;
            }
            return true;
        }

        protected const REFRESH_TOKEN:String="refreshToken";

        protected const TOKEN:String="token";

        protected const TOKEN_EXPIRATION_TIMESTAMP:String="tokenExpirationTimestamp";

        public static const LOGGED_IN:String="loggedInEvent";

        public static const LOGGED_OUT:String="loggedOutEvent";

        public static const LOGGED_OUT_COMPLETE:String="loggedOutComplete";

        public var AUTHORIZE_URL:String="";

        public var CLIENT_ID:String="";

        public var CLIENT_SECRET:String="";

        public var DASHBOARD_URL:String="";

        protected var _stage:flash.display.Stage;

        protected var implicitGrant:Boolean=false;

        protected var lastLocation:String="";

        protected var showWebViewOnCheckLogin:Boolean=true;

        protected var useURLDecode:Boolean=false;

        internal var _isDebug:Boolean=false;

        public var DEAUTHORIZE_URL:String="";

        public var HOME_URL:String="";

        public var INIT_URL:String="";

        public var LOGOUT_COMPLETE_URL:String="";

        public var LOGOUT_URL:String="";

        public var PARAMS:Object=null;

        public var REDIRECT_URI:String="";

        public var REGISTER_URL:String;

        public var SCOPE:String="";

        public var STATE:String="";

        public var TOKEN_URL:String="";

        public var UPLOAD_URL:String="";

        internal var _accessToken:String=null;

        internal var _loggedOut:Boolean=true;

        public var authorizationCode:String;

        public var className:String;

        internal var label:String;

        public var popupCancelFunc:Function;

        internal var popupTitle:String;

        internal var _refreshToken:String=null;

        public var LOGIN_URL:String="";

        internal var _requestHeader:flash.net.URLRequestHeader;

        public var ACCOUNT_RECOVER:String;
    }
}


//    class PostRequest
package service.oauth 
{
    import flash.utils.*;
    
    public class PostRequest extends Object
    {
        public function PostRequest()
        {
            super();
            createPostData();
            return;
        }

        public function createPostData():void
        {
            postData = new flash.utils.ByteArray();
            postData.endian = "bigEndian";
            return;
        }

        public function writePostData(arg1:String, arg2:String):void
        {
            var loc1:*=null;
            var loc2:*=NaN;
            writeBoundary();
            writeLineBreak();
            loc1 = "Content-Disposition: form-data; name=\"" + arg1 + "\"";
            var loc3:*=loc1.length;
            loc2 = 0;
            while (loc2 < loc3) 
            {
                postData.writeByte(loc1.charCodeAt(loc2));
                ++loc2;
            }
            writeLineBreak();
            writeLineBreak();
            postData.writeUTFBytes(arg2);
            writeLineBreak();
            return;
        }

        public function writeFileData(arg1:String, arg2:flash.utils.ByteArray, arg3:String):void
        {
            var loc1:*=null;
            var loc3:*=0;
            var loc2:*=0;
            writeBoundary();
            writeLineBreak();
            loc3 = (loc1 = "Content-Disposition: form-data; name=\"" + arg1 + "\"; filename=\"" + arg1 + "\";").length;
            loc2 = 0;
            while (loc2 < loc3) 
            {
                postData.writeByte(loc1.charCodeAt(loc2));
                ++loc2;
            }
            postData.writeUTFBytes(arg1);
            writeQuotationMark();
            writeLineBreak();
            loc3 = (loc1 = arg3 || "application/octet-stream").length;
            loc2 = 0;
            while (loc2 < loc3) 
            {
                postData.writeByte(loc1.charCodeAt(loc2));
                ++loc2;
            }
            writeLineBreak();
            writeLineBreak();
            arg2.position = 0;
            postData.writeBytes(arg2, 0, arg2.length);
            writeLineBreak();
            return;
        }

        public function getPostData():flash.utils.ByteArray
        {
            postData.position = 0;
            return postData;
        }

        public function close():void
        {
            writeBoundary();
            writeDoubleDash();
            return;
        }

        protected function writeLineBreak():void
        {
            postData.writeShort(3338);
            return;
        }

        protected function writeQuotationMark():void
        {
            postData.writeByte(34);
            return;
        }

        protected function writeDoubleDash():void
        {
            postData.writeShort(11565);
            return;
        }

        protected function writeBoundary():void
        {
            var loc1:*=0;
            writeDoubleDash();
            var loc2:*=boundary.length;
            loc1 = 0;
            while (loc1 < loc2) 
            {
                postData.writeByte(boundary.charCodeAt(loc1));
                ++loc1;
            }
            return;
        }

        public var boundary:String="-----";

        protected var postData:flash.utils.ByteArray;
    }
}


//    class UploadPostHelper
package service.oauth 
{
    import flash.utils.*;
    
    public class UploadPostHelper extends Object
    {
        public function UploadPostHelper()
        {
            super();
            return;
        }

        public static function getBoundary():String
        {
            var loc1:*=0;
            if (_boundary.length == 0) 
            {
                loc1 = 0;
                while (loc1 < 32) 
                {
                    _boundary = _boundary + String.fromCharCode(97 + Math.random() * 25);
                    ++loc1;
                }
            }
            return _boundary;
        }

        public static function getPostData(arg1:String, arg2:flash.utils.ByteArray, arg3:Object=null):flash.utils.ByteArray
        {
            var loc3:*=0;
            var loc1:*=null;
            var loc4:*;
            (loc4 = new flash.utils.ByteArray()).endian = "bigEndian";
            if (arg3 == null) 
            {
                arg3 = {};
            }
            arg3.Filename = arg1;
            var loc6:*=0;
            var loc5:*=arg3;
            for (var loc2:* in loc5) 
            {
                loc4 = BOUNDARY(loc4);
                loc4 = LINEBREAK(loc4);
                loc1 = "Content-Disposition: form-data; name=\"" + loc2 + "\"";
                loc3 = 0;
                while (loc3 < loc1.length) 
                {
                    loc4.writeByte(loc1.charCodeAt(loc3));
                    ++loc3;
                }
                loc4 = LINEBREAK(loc4);
                (loc4 = LINEBREAK(loc4)).writeUTFBytes(arg3[loc2]);
                loc4 = LINEBREAK(loc4);
            }
            loc4 = BOUNDARY(loc4);
            loc4 = LINEBREAK(loc4);
            loc1 = "Content-Disposition: form-data; name=\"file\"; filename=\"";
            loc3 = 0;
            while (loc3 < loc1.length) 
            {
                loc4.writeByte(loc1.charCodeAt(loc3));
                ++loc3;
            }
            loc4.writeUTFBytes(arg1);
            loc4 = QUOTATIONMARK(loc4);
            loc4 = LINEBREAK(loc4);
            loc1 = "Content-Type: application/octet-stream";
            loc3 = 0;
            while (loc3 < loc1.length) 
            {
                loc4.writeByte(loc1.charCodeAt(loc3));
                ++loc3;
            }
            loc4 = LINEBREAK(loc4);
            (loc4 = LINEBREAK(loc4)).writeBytes(arg2, 0, arg2.length);
            loc4 = LINEBREAK(loc4);
            loc4 = LINEBREAK(loc4);
            loc4 = BOUNDARY(loc4);
            loc4 = LINEBREAK(loc4);
            loc1 = "Content-Disposition: form-data; name=\"Upload\"";
            loc3 = 0;
            while (loc3 < loc1.length) 
            {
                loc4.writeByte(loc1.charCodeAt(loc3));
                ++loc3;
            }
            loc4 = LINEBREAK(loc4);
            loc4 = LINEBREAK(loc4);
            loc1 = "Submit Query";
            loc3 = 0;
            while (loc3 < loc1.length) 
            {
                loc4.writeByte(loc1.charCodeAt(loc3));
                ++loc3;
            }
            loc4 = LINEBREAK(loc4);
            loc4 = BOUNDARY(loc4);
            return loc4 = DOUBLEDASH(loc4);
        }

        internal static function BOUNDARY(arg1:flash.utils.ByteArray):flash.utils.ByteArray
        {
            var loc1:*=0;
            var loc2:*=UploadPostHelper.getBoundary().length;
            arg1 = DOUBLEDASH(arg1);
            loc1 = 0;
            while (loc1 < loc2) 
            {
                arg1.writeByte(_boundary.charCodeAt(loc1));
                ++loc1;
            }
            return arg1;
        }

        internal static function LINEBREAK(arg1:flash.utils.ByteArray):flash.utils.ByteArray
        {
            arg1.writeShort(3338);
            return arg1;
        }

        internal static function QUOTATIONMARK(arg1:flash.utils.ByteArray):flash.utils.ByteArray
        {
            arg1.writeByte(34);
            return arg1;
        }

        internal static function DOUBLEDASH(arg1:flash.utils.ByteArray):flash.utils.ByteArray
        {
            arg1.writeShort(11565);
            return arg1;
        }

        internal static var _boundary:String="";
    }
}


//  package openstreetmap
//    class MapSearchEngine
package service.openstreetmap 
{
    import __AS3__.vec.*;
    import com.adobe.serialization.json.*;
    import debug.*;
    import flash.events.*;
    import flash.net.*;
    
    public class MapSearchEngine extends flash.events.EventDispatcher
    {
        public function MapSearchEngine()
        {
            super();
            return;
        }

        public function search(arg1:String):void
        {
            var loc1:*=new flash.net.URLRequest(buildSearchRequest(arg1));
            startSearch(loc1);
            return;
        }

        public function searchReverse(arg1:Number, arg2:Number):void
        {
            var loc1:*=new flash.net.URLRequest(buildSearchReverseRequest(arg1, arg2));
            startSearch(loc1);
            return;
        }

        internal function startSearch(arg1:flash.net.URLRequest):void
        {
            var loc1:*=new service.openstreetmap.MapSearchURLLoader();
            loc1.addEventListener("complete", onSearchComplete);
            loc1.addEventListener("ioError", onSearchIOError);
            loc1.load(arg1);
            return;
        }

        internal function buildSearchRequest(arg1:String):String
        {
            var loc1:*="https://nominatim.openstreetmap.org/search?";
            loc1 = loc1 + ("q=" + arg1);
            loc1 = loc1 + "&format=json";
            loc1 = loc1 + "&polygon_geojson=1";
            loc1 = loc1 + "&bounded=0";
            loc1 = loc1 + "&addressdetails=1";
            debug.Debug.debug("buildSearchRequest: " + loc1);
            return loc1;
        }

        internal function buildSearchReverseRequest(arg1:Number, arg2:Number):String
        {
            var loc1:*="https://nominatim.openstreetmap.org/reverse.php?";
            loc1 = loc1 + "&format=json";
            loc1 = loc1 + ("&lat=" + arg1.toString());
            loc1 = loc1 + ("&lon=" + arg2.toString());
            loc1 = loc1 + "&zoom=16";
            debug.Debug.debug("buildSearchReverseRequest: " + loc1);
            return loc1;
        }

        internal function onSearchComplete(arg1:flash.events.Event):void
        {
            var loc4:*;
            (loc4 = arg1.target as service.openstreetmap.MapSearchURLLoader).removeEventListener("ioError", onSearchIOError);
            loc4.removeEventListener("complete", onSearchComplete);
            var loc1:*=com.adobe.serialization.json.JSON.decode(loc4.data as String);
            var loc3:*=new __AS3__.vec.Vector.<service.openstreetmap.MapSearchResult>();
            if (loc1 is Array) 
            {
                var loc6:*=0;
                var loc5:*=loc1;
                for each (var loc2:* in loc5) 
                {
                    loc3.push(mapResultFromObject(loc2));
                }
                dispatchEvent(new service.openstreetmap.MapSearchEvent("searchResult", false, loc3));
            }
            else 
            {
                loc3.push(mapResultFromObject(loc1));
                dispatchEvent(new service.openstreetmap.MapSearchEvent("searchReverseResult", false, loc3));
            }
            return;
        }

        internal function mapResultFromObject(arg1:Object):service.openstreetmap.MapSearchResult
        {
            var loc1:*=new service.openstreetmap.MapSearchResult();
            loc1.latitude = arg1.lat;
            loc1.longitude = arg1.lon;
            loc1.formattedAddress = "";
            var loc2:*=arg1.address;
            if (arg1.hasOwnProperty("display_name")) 
            {
                loc1.formattedAddress = arg1.display_name;
            }
            if (loc2.hasOwnProperty("road")) 
            {
                loc1.road = loc2.road;
            }
            if (loc2.hasOwnProperty("house_number")) 
            {
                loc1.houseNumber = loc2.house_number;
            }
            if (loc2.hasOwnProperty("postcode")) 
            {
                loc1.postalCode = loc2.postcode;
            }
            if (loc2.hasOwnProperty("village")) 
            {
                loc1.village = loc2.village;
            }
            if (loc2.hasOwnProperty("town")) 
            {
                loc1.town = loc2.town;
            }
            if (loc2.hasOwnProperty("city")) 
            {
                loc1.city = loc2.city;
            }
            if (loc2.hasOwnProperty("state")) 
            {
                loc1.state = loc2.state;
            }
            if (loc2.hasOwnProperty("country")) 
            {
                loc1.country = loc2.country;
            }
            return loc1;
        }

        internal function onSearchIOError(arg1:flash.events.IOErrorEvent):void
        {
            var loc1:*=arg1.target as service.openstreetmap.MapSearchURLLoader;
            loc1.removeEventListener("ioError", onSearchIOError);
            loc1.removeEventListener("complete", onSearchComplete);
            dispatchEvent(new service.openstreetmap.MapSearchEvent("searchError"));
            return;
        }

        internal static const BASE_SEARCH_URL:String="https://nominatim.openstreetmap.org/search?";

        internal static const REVERSE_SEARCH_URL:String="https://nominatim.openstreetmap.org/reverse.php?";
    }
}


//    class MapSearchEvent
package service.openstreetmap 
{
    import flash.events.*;
    
    public class MapSearchEvent extends flash.events.Event
    {
        public function MapSearchEvent(arg1:String, arg2:Boolean=false, arg3:Object=null)
        {
            super(arg1, arg2, false);
            _data = arg3;
            return;
        }

        public function get data():Object
        {
            return _data;
        }

        public function set data(arg1:Object):void
        {
            _data = arg1;
            return;
        }

        public static const SEARCH_ERROR:String="searchError";

        public static const SEARCH_RESULT:String="searchResult";

        public static const SEARCH_REVERSE_RESULT:String="searchReverseResult";

        internal var _data:Object;
    }
}


//    class MapSearchResult
package service.openstreetmap 
{
    public class MapSearchResult extends Object
    {
        public function MapSearchResult()
        {
            super();
            return;
        }

        public var city:String=null;

        public var confidence:String=null;

        public var country:String=null;

        public var formattedAddress:String=null;

        public var houseNumber:String="";

        public var latitude:Number;

        public var longitude:Number;

        public var name:String=null;

        public var postalCode:String=null;

        public var precision:Number=-1;

        public var road:String=null;

        public var state:String=null;

        public var town:String=null;

        public var village:String=null;
    }
}


//    class MapSearchURLLoader
package service.openstreetmap 
{
    import flash.net.*;
    
    public class MapSearchURLLoader extends flash.net.URLLoader
    {
        public function MapSearchURLLoader(arg1:flash.net.URLRequest=null)
        {
            super(arg1);
            return;
        }
    }
}


//  package usb
//    package event
//      class DeviceDataCompleteEvent
package service.usb.event 
{
    import flash.events.*;
    
    public class DeviceDataCompleteEvent extends flash.events.Event
    {
        public function DeviceDataCompleteEvent(arg1:String, arg2:String, arg3:Array, arg4:String=null, arg5:Boolean=false)
        {
            super(arg1, arg5);
            command = arg2;
            data = arg3;
            startAdress = arg4;
            return;
        }

        public override function toString():String
        {
            return "[DataCompleteEvent extends Event]";
        }

        public static const DATA_COMPLETE:String="usbComplete";

        public var command:String;

        public var data:Array;

        public var startAdress:String;
    }
}


//      class USBConnectedEvent
package service.usb.event 
{
    import flash.events.*;
    
    public class USBConnectedEvent extends flash.events.Event
    {
        public function USBConnectedEvent(arg1:String, arg2:uint, arg3:String, arg4:Boolean=false, arg5:Boolean=false)
        {
            super(arg1, arg4, arg5);
            _usbPort = arg2;
            _dockingStation = arg3;
            return;
        }

        public function get dockingStation():String
        {
            return _dockingStation;
        }

        public function set dockingStation(arg1:String):void
        {
            _dockingStation = arg1;
            return;
        }

        public function get usbPort():uint
        {
            return _usbPort;
        }

        public function set usbPort(arg1:uint):void
        {
            _usbPort = arg1;
            return;
        }

        public static const USB_CONNECTED:String="usbConnected";

        public static const USB_DISCONNECTED:String="usbDisconnected";

        internal var _dockingStation:String;

        internal var _usbPort:uint;
    }
}


//    class USBHandler
package service.usb 
{
    import avmplus.*;
    import com.logging.*;
    import de.pagecon.usb.*;
    import debug.*;
    import flash.events.*;
    import flash.utils.*;
    import handler.*;
    import handler.event.*;
    import helper.*;
    import service.*;
    import service.event.*;
    import service.usb.event.*;
    
    public class USBHandler extends flash.events.EventDispatcher implements de.pagecon.usb.UsbListener, service.ICommunicationService
    {
        public function USBHandler(arg1:flash.events.IEventDispatcher=null)
        {
            var loc1:*=null;
            _receiveBuffer = [];
            commandArray = [];
            super(arg1);
            _usbController = new de.pagecon.usb.UsbController();
            _usbController.debugMode = false;
            if (_usbController.isSupported()) 
            {
                loc1 = [];
                loc1.push(new de.pagecon.usb.SigmaDevice(7581, 4112, 269491613), new de.pagecon.usb.SigmaDevice(7581, 4113, 269557149), new de.pagecon.usb.SigmaDevice(7581, 4114, 269622685), new de.pagecon.usb.SigmaDevice(1155, 22336, 1463813251), new de.pagecon.usb.SigmaDevice(7581, 4176, 273685917), new de.pagecon.usb.SigmaDevice(7581, 4177, 273751453), new de.pagecon.usb.SigmaDevice(7581, 4096, 268443037), new de.pagecon.usb.SigmaDevice(7581, 4144, 271588765), new de.pagecon.usb.SigmaDevice(7581, 8192, 536878493), new de.pagecon.usb.SigmaDevice(7581, 4129, 270605725), new de.pagecon.usb.SigmaDevice(7581, 4178, 273816989));
                _usbController.setSupportedDevices(loc1);
            }
            return;
        }

        public function resetLastReceveidData():void
        {
            debug.Debug.usb("_receiveBuffer on reset: " + _receiveBuffer.toString());
            _receiveBuffer = [];
            return;
        }

        public function get connectedDevice():de.pagecon.usb.SigmaDevice
        {
            return _connectedDevice;
        }

        public function set connectedDevice(arg1:de.pagecon.usb.SigmaDevice):void
        {
            _connectedDevice = arg1;
            return;
        }

        public function getLastReceivedData():Array
        {
            return _receiveBuffer;
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

        public function reset():void
        {
            resetUSBService();
            return;
        }

        public function get dockingStation():String
        {
            return _dockingStation;
        }

        internal function connectMobilDevice(arg1:de.pagecon.usb.SigmaDevice):void
        {
            if (!_usbController) 
            {
                return;
            }
            var loc1:*=_usbController.connectDevice(arg1.id);
        }

        public function get port():int
        {
            return _port;
        }

        public function closeApplication():void
        {
            return;
        }

        public function isReady():Boolean
        {
            return false;
        }

        public function initMobileUSBService(arg1:Boolean=true):void
        {
            _autoConnect = arg1;
            if (helper.Capabilities_helper.isAndroid() || helper.Capabilities_helper.isWindows() || helper.Capabilities_helper.isMac()) 
            {
                _usbController.usbListener = this;
                if (arg1) 
                {
                    searchAttachedDevices();
                }
            }
            else 
            {
                debug.Debug.usb("Keine USB unterstützung vorhanden");
            }
            return;
        }

        public function destroyUSBController():void
        {
            if (!_usbController) 
            {
                return;
            }
            if (_connectedDevice) 
            {
                _usbController.disconnectDevice(_connectedDevice.id);
            }
            _usbController.usbListener = null;
            return;
        }

        public function searchAttachedDevices():void
        {
            if (!_usbController) 
            {
                return;
            }
            var loc1:*=_usbController.getAttachedDevices();
            if (loc1.length == 1) 
            {
                _doActionTimeout = flash.utils.setTimeout(connectMobilDevice, 1000, loc1[0]);
            }
            return;
        }

        public function dataReceived(arg1:int, arg2:Array):void
        {
            var loc3:*=0;
            var loc4:*=null;
            if (currentDeviceHandler == null) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 117, "USB > standardOutputDataHandler: current unit handler is null, , ds: " + _dockingStation + ", port: " + _port));
                dispatchEvent(new service.event.DeviceCommunicationEvent("eventCommunicationError", ""));
                return;
            }
            _receiveBuffer = _receiveBuffer.concat(arg2);
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
            var loc1:*=currentDeviceHandler.currentBytesToReceive + currentDeviceHandler.currentReceiveChecksumLength;
            dispatchEvent(new handler.event.CustomCommunicationServiceProgressEvent("EVENT_USB_TRANSFER_PROGRESS", 100 / _receiveBuffer.length * loc1));
            if (currentDeviceHandler.currentCommand != 244) 
            {
                debug.Debug.usb("Received data \tfrom \t" + arg1 + " \t(" + avmplus.getQualifiedClassName(currentDeviceHandler) + "): " + "\tCommand: " + currentDeviceHandler.currentCommand + " \treceived length: " + _receiveBuffer.length + " - expected length: " + loc1 + "\n" + "\t\t\tdata: [" + arg2 + "]");
            }
            if (_receiveBuffer.length != loc1) 
            {
                if (_receiveBuffer.length > currentDeviceHandler.currentBytesToReceive) 
                {
                    dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 115, "USB > standardOutputDataHandler: , ds: " + _dockingStation + ", port: " + _port + ", unitHandler: " + currentDeviceHandler.toString()));
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
                dispatchEvent(new flash.events.Event("EVENT_USB_TRANSFER_END"));
            }
            return;
        }

        public function connectionEvent(arg1:int, arg2:de.pagecon.usb.SigmaDevice):void
        {
            var loc1:*=null;
            flash.utils.clearTimeout(_doActionTimeout);
        }

        internal function disconnect(arg1:de.pagecon.usb.SigmaDevice):void
        {
            if (_usbController) 
            {
                _usbController.disconnectDevice(arg1.id);
            }
            _connectedDevice = null;
            return;
        }

        public function debugInfo(arg1:String):void
        {
            debug.Debug.usb("[UsbListener] " + arg1);
            return;
        }

        public function isSupported():Boolean
        {
            return _usbController.isSupported();
        }

        internal function onErrorPopupClose(arg1:flash.events.Event):void
        {
            _tooManyDSPopupVisible = false;
            return;
        }

        public function resetUSBService(arg1:Boolean=true):void
        {
            if (currentDeviceHandler == null || !(currentDeviceHandler is service.usb.USBHandler)) 
            {
                return;
            }
            debug.Debug.usb(" --------- resetUSBService  --------- ( and restart:" + arg1);
            if (!(_connectedDevice == null) && _usbController) 
            {
                _usbController.disconnectDevice(_connectedDevice.id);
            }
            if (currentDeviceHandler != null) 
            {
                currentDeviceHandler.destructor();
                currentDeviceHandler = null;
            }
            return;
        }

        public function send(arg1:flash.utils.ByteArray, arg2:handler.DeviceHandler, arg3:Boolean=false):void
        {
            var loc3:*=null;
            var loc1:*=0;
            var loc2:*=false;
            if (connectedDevice == null) 
            {
                arg2.resetCheckConnectionTimeOut();
            }
            else 
            {
                currentDeviceHandler = arg2;
                if (currentDeviceHandler.currentBytesToReceive > 0) 
                {
                    dispatchEvent(new flash.events.Event("waitForDataEvent"));
                }
                _receiveBuffer = [];
                if (!arg3) 
                {
                    try 
                    {
                        dispatchEvent(new flash.events.Event("EVENT_USB_TRANSFER_START"));
                        loc3 = [];
                        loc1 = 0;
                        arg1.position = 0;
                        while (arg1.bytesAvailable) 
                        {
                            loc1 = arg1.readUnsignedByte();
                            loc3[loc3.length] = loc1;
                        }
                        loc2 = _usbController.sendData(currentDeviceHandler.port, loc3);
                        if (loc1 != 244) 
                        {
                            debug.Debug.usb("Sending data \tto  \t" + arg2.port + " \t(" + avmplus.getQualifiedClassName(arg2) + "): " + "\tCommand: [" + loc3.toString() + "]");
                        }
                        commandArray.push(loc3.toString());
                    }
                    catch (e:Error)
                    {
                        dispatchEvent(new service.event.DeviceCommunicationEvent("eventCommunicationError", e.message));
                        dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 116, e.message));
                    }
                }
            }
            return;
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
            sendLoop(arg1, arg3, 1, arg4);
            return;
        }

        internal function sendLoop(arg1:flash.utils.ByteArray, arg2:uint, arg3:uint, arg4:uint):void
        {
            var loc5:*=0;
            if (arg1.bytesAvailable == 0) 
            {
                return;
            }
            var loc4:*=[];
            var loc6:*=new flash.utils.ByteArray();
            var loc2:*=0;
            var loc1:*=0;
            loc5 = 0;
            while (loc5 < arg2) 
            {
                if (arg1.bytesAvailable >= 1) 
                {
                    loc1 = arg1.readUnsignedByte();
                    loc6.writeByte(loc1);
                    loc4.push(loc1);
                    ++loc2;
                }
                ++loc5;
            }
            var loc3:*=_usbController.sendData(currentDeviceHandler.port, loc4);
            ++arg3;
            return;
        }

        public static const VID_PID_ROX:uint=268443037;

        public static const VID_PID_ROX_10:uint=1463813251;

        public static const VID_PID_ROX_2011:uint=271588765;

        public static const VID_PID_ROX_7:uint=273685917;

        public static const VID_PID_RUN1:uint=537927069;

        public static const VID_PID_RUN2:uint=537992605;

        public static const VID_PID_TOPLINE_2009:uint=269491613;

        public static const VID_PID_TOPLINE_2012:uint=269557149;

        public static const VID_PID_TOPLINE_2016:uint=269622685;

        public static const VID_PID_UFSB:uint=270605725;

        public static const VID_SIGMASPORT:uint=7581;

        public static const VID_PID_ROX_11:uint=273751453;

        public static const COMMAND_MODE_LOAD:String="loadCommand";

        public static const COMMAND_MODE_SEND:String="sendCommand";

        public static const EVENT_USB_TRANSFER_END:String="EVENT_USB_TRANSFER_END";

        public static const EVENT_USB_TRANSFER_PROGRESS:String="EVENT_USB_TRANSFER_PROGRESS";

        public static const EVENT_USB_TRANSFER_START:String="EVENT_USB_TRANSFER_START";

        public static const PID_GPS_10:uint=4178;

        public static const PID_RC_2011:uint=8192;

        public static const PID_ROX:uint=4096;

        public static const PID_ROX_10:uint=22336;

        public static const PID_ROX_11:uint=4177;

        public static const PID_ROX_2011:uint=4144;

        public static const PID_ROX_7:uint=4176;

        public static const PID_TOPLINE_2009:uint=4112;

        public static const PID_TOPLINE_2012:uint=4113;

        public static const PID_TOPLINE_2016:uint=4114;

        public static const PID_UFSB:uint=4129;

        public static const TOO_MANY_DOCKING_STATIONS_CONNECTED:String="tooManyDockingStationsConnected";

        public static const USB_SERVICE_CLOSED:String="usbServiceClosed";

        public static const USB_SERVICE_FOUND:String="usbServiceFound";

        public static const USB_SERVICE_NOT_FOUND:String="usbServiceNotFound";

        public static const VID_PID_ACTIVO_HEALTH:uint=538975645;

        public static const VID_PID_GPS_10:uint=273816989;

        public static const VID_PID_RC_2011:uint=536878493;

        internal var _connectedDevice:de.pagecon.usb.SigmaDevice;

        internal var _currentDeviceHandler:handler.DeviceHandler;

        internal var _dockingStation:String="";

        internal var _autoConnect:Boolean=true;

        internal var _doActionTimeout:uint=0;

        internal var _nextQueueCommandInterval:uint=1000;

        internal var _receiveBuffer:Array;

        internal var _scanDockingStationInterval:uint=1000;

        internal var _scanUSBPortInterval:uint=1000;

        internal var _tooManyDSPopupVisible:Boolean=false;

        internal var _usbController:de.pagecon.usb.UsbController;

        internal var _port:int=-1;

        internal var commandArray:Array;
    }
}


//    class USBSendTimer
package service.usb 
{
    import flash.utils.*;
    
    public class USBSendTimer extends flash.utils.Timer
    {
        public function USBSendTimer(arg1:Number, arg2:uint=0, arg3:String="", arg4:int=0, arg5:Array=null, arg6:int=0, arg7:int=0)
        {
            super(arg1, arg7);
            usbPort = arg2;
            command = arg3;
            bytesToReceive = arg4;
            packageSize = arg6;
            data = arg5;
            return;
        }

        public var bytesToReceive:int;

        public var command:String;

        public var data:Array;

        public var packageSize:int;

        public var sentBytes:int=0;

        public var usbPort:uint;
    }
}


//  class DeviceCommunicationHandler
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


//  class ICommunicationService
package service 
{
    public dynamic interface ICommunicationService
    {
    }
}


//  class Queueitem
package service 
{
    import handler.*;
    
    public class Queueitem extends Object
    {
        public function Queueitem(arg1:String, arg2:String, arg3:handler.DeviceHandler)
        {
            super();
            type = arg1;
            commandMode = arg2;
            deviceHandler = arg3;
            return;
        }

        public var commandMode:String;

        public var deviceHandler:handler.DeviceHandler;

        public var type:String;
    }
}


