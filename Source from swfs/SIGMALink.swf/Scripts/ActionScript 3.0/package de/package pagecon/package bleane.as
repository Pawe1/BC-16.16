//package bleane
//  class BleController
package de.pagecon.bleane 
{
    import flash.events.*;
    import flash.external.*;
    
    public class BleController extends flash.events.EventDispatcher
    {
        public function BleController(arg1:flash.events.IEventDispatcher=null)
        {
            super();
            extContext = flash.external.ExtensionContext.createExtensionContext("de.pagecon.bleane", null);
            if (extContext != null) 
            {
                extContext.addEventListener("status", onStatus);
            }
            return;
        }

        internal function onStatus(arg1:flash.events.StatusEvent):void
        {
            var loc5:*=null;
            var loc11:*=0;
            var loc1:*=null;
            var loc7:*=0;
            var loc4:*=0;
            var loc13:*=null;
            var loc3:*=0;
            var loc2:*=null;
            var loc8:*=0;
            var loc14:*=null;
            var loc12:*=arg1.code;
            var loc6:*=arg1.level;
            var loc9:*=null;
            var loc10:*=null;
            var loc15:*=null;
            trace("[BleController] onStatus: " + loc12 + " ::: " + loc6);
            if (loc12 != "deviceDiscovered") 
            {
                if (loc12 != "dataReceived") 
                {
                    if (loc12 != "dataSend") 
                    {
                        if (loc12 != "deviceConnected") 
                        {
                            if (loc12 != "devicePaired") 
                            {
                                if (loc12 != "deviceNotPaired") 
                                {
                                    if (loc12 != "deviceDisconnected") 
                                    {
                                        if (loc12 != "error") 
                                        {
                                            if (loc12 != "idsChecked") 
                                            {
                                                if (loc12 != "info") 
                                                {
                                                    if (loc12 != "enabledStateChanged") 
                                                    {
                                                        if (loc12 != "selectedStateChanged") 
                                                        {
                                                            if (loc12 != "scanningStateChanged") 
                                                            {
                                                                if (loc12 == "connectionRequestsCanceled") 
                                                                {
                                                                    loc15 = new de.pagecon.bleane.BleEvent("CONNECTION_REQUESTS_CANCELLED", null);
                                                                    dispatchEvent(loc15);
                                                                }
                                                            }
                                                            else 
                                                            {
                                                                loc9 = JSON.parse(loc6) as Object;
                                                                (loc10 = []).push(loc9["scanningState"]);
                                                                loc15 = new de.pagecon.bleane.BleEvent("SCANNING_STATE_CHANGED", loc10);
                                                                dispatchEvent(loc15);
                                                            }
                                                        }
                                                        else 
                                                        {
                                                            loc9 = JSON.parse(loc6) as Object;
                                                            (loc10 = []).push(loc9["selectedState"]);
                                                            loc15 = new de.pagecon.bleane.BleEvent("SELECTED_STATE_CHANGED", loc10);
                                                            dispatchEvent(loc15);
                                                        }
                                                    }
                                                    else 
                                                    {
                                                        loc9 = JSON.parse(loc6) as Object;
                                                        (loc10 = []).push(loc9["enabledState"]);
                                                        loc15 = new de.pagecon.bleane.BleEvent("ENABLED_STATE_CHANGED", loc10);
                                                        dispatchEvent(loc15);
                                                    }
                                                }
                                                else 
                                                {
                                                    if (!false) 
                                                    {
                                                        return;
                                                    }
                                                    loc9 = JSON.parse(loc6) as Object;
                                                    (loc10 = []).push(loc9["info"]);
                                                    loc15 = new de.pagecon.bleane.BleEvent("INFO", loc10);
                                                    dispatchEvent(loc15);
                                                }
                                            }
                                            else 
                                            {
                                                loc9 = JSON.parse(loc6) as Object;
                                                loc10 = [];
                                                loc3 = (loc13 = loc9["ids"] as Array).length;
                                                loc2 = [];
                                                loc8 = 0;
                                                while (loc8 < loc3) 
                                                {
                                                    loc14 = loc13[loc8] as String;
                                                    loc2.push(loc14);
                                                    ++loc8;
                                                }
                                                loc10.push(loc2);
                                                loc15 = new de.pagecon.bleane.BleEvent("IDS_CHECKED", loc10);
                                                dispatchEvent(loc15);
                                            }
                                        }
                                        else 
                                        {
                                            loc9 = JSON.parse(loc6) as Object;
                                            (loc10 = []).push(loc9["err"]);
                                            loc10.push(loc9["msg"]);
                                            loc10.push(loc9["did"]);
                                            loc10.push(loc9["suuid"]);
                                            loc10.push(loc9["cuuid"]);
                                            loc15 = new de.pagecon.bleane.BleEvent("ERROR", loc10);
                                            dispatchEvent(loc15);
                                        }
                                    }
                                    else 
                                    {
                                        loc9 = JSON.parse(loc6) as Object;
                                        (loc10 = []).push(loc9["did"]);
                                        loc15 = new de.pagecon.bleane.BleEvent("DEVICE_DISCONNECTED", loc10);
                                        dispatchEvent(loc15);
                                    }
                                }
                                else 
                                {
                                    loc9 = JSON.parse(loc6) as Object;
                                    (loc10 = []).push(loc9["did"]);
                                    loc15 = new de.pagecon.bleane.BleEvent("DEVICE_NOT_PAIRED", loc10);
                                    dispatchEvent(loc15);
                                }
                            }
                            else 
                            {
                                loc9 = JSON.parse(loc6) as Object;
                                (loc10 = []).push(loc9["did"]);
                                loc15 = new de.pagecon.bleane.BleEvent("DEVICE_PAIRED", loc10);
                                dispatchEvent(loc15);
                            }
                        }
                        else 
                        {
                            loc9 = JSON.parse(loc6) as Object;
                            (loc10 = []).push(loc9["did"]);
                            loc15 = new de.pagecon.bleane.BleEvent("DEVICE_CONNECTED", loc10);
                            dispatchEvent(loc15);
                        }
                    }
                    else 
                    {
                        loc9 = JSON.parse(loc6) as Object;
                        (loc10 = []).push(loc9["did"]);
                        loc10.push(loc9["suuid"]);
                        loc10.push(loc9["cuuid"]);
                        loc15 = new de.pagecon.bleane.BleEvent("DATA_WRITTEN", loc10);
                        dispatchEvent(loc15);
                    }
                }
                else 
                {
                    loc9 = JSON.parse(loc6) as Object;
                    (loc10 = []).push(loc9["did"]);
                    loc10.push(loc9["suuid"]);
                    loc10.push(loc9["cuuid"]);
                    loc11 = (loc5 = loc9["data"] as Array).length;
                    loc1 = [];
                    loc7 = 0;
                    while (loc7 < loc11) 
                    {
                        if ((loc4 = loc5[loc7] as int) < 0) 
                        {
                            loc4 = 256 + loc4;
                        }
                        loc1.push(loc4);
                        ++loc7;
                    }
                    loc10.push(loc1);
                    loc15 = new de.pagecon.bleane.BleEvent("DATA_RECEIVED", loc10);
                    dispatchEvent(loc15);
                }
            }
            else 
            {
                loc9 = JSON.parse(loc6) as Object;
                (loc10 = []).push(loc9["did"]);
                loc10.push(loc9["psuuid"]);
                loc10.push(loc9["name"]);
                loc15 = new de.pagecon.bleane.BleEvent("DEVICE_DISCOVERED", loc10);
                dispatchEvent(loc15);
            }
            return;
        }

        public function reset():void
        {
            extContext.call("reset");
            return;
        }

        public function isBleSupported():Boolean
        {
            return extContext.call("isBleSupported") as Boolean;
        }

        public function getEnabledBleHw():int
        {
            return extContext.call("getEnabledBleHw") as int;
        }

        public function getSelectedBleHw():int
        {
            return extContext.call("getSelectedBleHw") as int;
        }

        public function setBleNotificationFilterParams(arg1:Boolean, arg2:int):void
        {
            extContext.call("setBleNotificationFilterParams", arg1, arg2);
            return;
        }

        public function askUserToEnableBle():int
        {
            return extContext.call("askUserToEnableBle") as int;
        }

        public function startScan(arg1:Array):int
        {
            return extContext.call("startScan", arg1) as int;
        }

        public function stopScan():void
        {
            extContext.call("stopScan");
            return;
        }

        public function connect(arg1:Array):int
        {
            return extContext.call("connect", arg1) as int;
        }

        public function cancelConnectionRequests():int
        {
            return extContext.call("cancelConnectionRequests") as int;
        }

        public function disconnect(arg1:String):int
        {
            return extContext.call("disconnect", arg1) as int;
        }

        public function read(arg1:String, arg2:String, arg3:String):int
        {
            return extContext.call("read", arg1, arg2, arg3) as int;
        }

        public function write(arg1:String, arg2:String, arg3:String, arg4:Array):int
        {
            return extContext.call("write", arg1, arg2, arg3, arg4) as int;
        }

        public function setNotify(arg1:String, arg2:String, arg3:String, arg4:Boolean):int
        {
            return extContext.call("setNotify", arg1, arg2, arg3, arg4) as int;
        }

        public function checkIds(arg1:Array):void
        {
            extContext.call("checkIds", arg1);
            return;
        }

        internal static const SERVICE_UUID:String="suuid";

        public static const DONGLE_BLE_HW_ENABLED:int=2;

        public static const DONGLE_BLE_HW_SELECTED:int=2;

        public static const ERROR_BLE_ALREADY_ENABLED:int=-13;

        public static const ERROR_BLE_CONNECT_FAILED:int=-7;

        public static const ERROR_BLE_DEVICE_ALREADY_CONNECTED:int=-5;

        public static const ERROR_BLE_DEVICE_NOT_CONNECTED:int=-6;

        public static const ERROR_BLE_DEVICE_NOT_CONTAINING_SPECIFIED_CHARACTERISTIC_OR_SERVICE:int=-14;

        public static const ERROR_BLE_DEVICE_UNKNOWN:int=-17;

        public static const ERROR_BLE_DISCONNECT_FAILED:int=-8;

        public static const ERROR_BLE_INVALID_CHARACTERISTIC_UUID:int=-16;

        public static const ERROR_BLE_INVALID_DEVICE_ID:int=-4;

        public static const ERROR_BLE_INVALID_SERVICE_UUID:int=-15;

        public static const ERROR_BLE_NOT_ENABLED:int=-2;

        public static const ERROR_BLE_NOT_SUPPORTED:int=-1;

        public static const ERROR_BLE_OPERATION_FAILED:int=-3;

        public static const ERROR_BLE_OPERATION_NOT_SUPPORTED:int=-20;

        public static const ERROR_BLE_READ_FAILED:int=-11;

        public static const ERROR_BLE_START_SCAN_FAILED:int=-18;

        public static const ERROR_BLE_STILL_SCANNING:int=-21;

        public static const ERROR_BLE_STOP_SCAN_FAILED:int=-19;

        public static const ERROR_BLE_WRITE_FAILED:int=-12;

        public static const INTERNAL_AND_DONGLE_BLE_HW_ENABLED:int=3;

        public static const INTERNAL_BLE_HW_ENABLED:int=1;

        public static const INTERNAL_BLE_HW_SELECTED:int=1;

        public static const NO_BLE_HW_ENABLED:int=0;

        public static const NO_BLE_HW_SELECTED:int=0;

        public static const SUCCESS:int=0;

        internal static const ACTION_CONNECTION_REQUESTS_CANCELED:String="connectionRequestsCanceled";

        internal static const ACTION_DATA_RECEIVED:String="dataReceived";

        internal static const ACTION_DATA_SEND:String="dataSend";

        internal static const ACTION_DEVICE_CONNECTED:String="deviceConnected";

        internal static const ACTION_DEVICE_DISCONNECTED:String="deviceDisconnected";

        internal static const ACTION_DEVICE_DISCOVERED:String="deviceDiscovered";

        internal static const ACTION_DEVICE_NOT_PAIRED:String="deviceNotPaired";

        internal static const ACTION_DEVICE_PAIRED:String="devicePaired";

        internal static const ACTION_ENABLED_STATE_CHANGED:String="enabledStateChanged";

        internal static const ACTION_ERROR:String="error";

        internal static const ACTION_IDS_CHECKED:String="idsChecked";

        internal static const ACTION_INFO:String="info";

        internal static const ACTION_SCANNING_STATE_CHANGED:String="scanningStateChanged";

        internal static const ACTION_SELECTED_STATE_CHANGED:String="selectedStateChanged";

        internal static const CHARACTERISTIC_UUID:String="cuuid";

        internal static const DATA:String="data";

        internal static const DEBUG_MODE:Boolean=false;

        internal static const DEVICE_ID:String="did";

        internal static const DEVICE_NAME:String="name";

        internal static const ENABLED_STATE:String="enabledState";

        internal static const ERROR_CODE:String="err";

        internal static const IDS:String="ids";

        internal static const INFO:String="info";

        internal static const MSG:String="msg";

        internal static const PRIMARY_SERVICE_UUID:String="psuuid";

        internal static const SCANNING_STATE:String="scanningState";

        internal static const SELECTED_STATE:String="selectedState";

        internal var extContext:flash.external.ExtensionContext;
    }
}


//  class BleEvent
package de.pagecon.bleane 
{
    import flash.events.*;
    
    public class BleEvent extends flash.events.Event
    {
        public function BleEvent(arg1:String, arg2:Object, arg3:Boolean=true, arg4:Boolean=true)
        {
            super(arg1, arg3, arg4);
            this.content = arg2;
            return;
        }

        public override function clone():flash.events.Event
        {
            return new de.pagecon.bleane.BleEvent(type, content);
        }

        public static const CONNECTION_REQUESTS_CANCELLED:String="CONNECTION_REQUESTS_CANCELLED";

        public static const DATA_RECEIVED:String="DATA_RECEIVED";

        public static const DATA_SEND:String="DATA_WRITTEN";

        public static const DEVICE_CONNECTED:String="DEVICE_CONNECTED";

        public static const DEVICE_DISCONNECTED:String="DEVICE_DISCONNECTED";

        public static const DEVICE_DISCOVERED:String="DEVICE_DISCOVERED";

        public static const DEVICE_NOT_PAIRED:String="DEVICE_NOT_PAIRED";

        public static const DEVICE_PAIRED:String="DEVICE_PAIRED";

        public static const ENABLED_STATE_CHANGED:String="ENABLED_STATE_CHANGED";

        public static const ERROR:String="ERROR";

        public static const IDS_CHECKED:String="IDS_CHECKED";

        public static const INFO:String="INFO";

        public static const SCANNING_STATE_CHANGED:String="SCANNING_STATE_CHANGED";

        public static const SELECTED_STATE_CHANGED:String="SELECTED_STATE_CHANGED";

        public var content:Object;
    }
}


