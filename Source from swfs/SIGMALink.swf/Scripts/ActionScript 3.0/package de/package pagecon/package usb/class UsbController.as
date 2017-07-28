//class UsbController
package de.pagecon.usb 
{
    import flash.events.*;
    import flash.external.*;
    import flash.system.*;
    
    public class UsbController extends flash.events.EventDispatcher
    {
        public function UsbController(arg1:flash.events.IEventDispatcher=null)
        {
            super();
            extContext = flash.external.ExtensionContext.createExtensionContext("de.pagecon.usb", "");
            this.debugMode = false;
            return;
        }

        public function set debugMode(arg1:Boolean):void
        {
            mDebugMode = arg1;
            debug("setDebugMode: " + arg1.toString());
            extContext.call("setDebugMode", arg1);
            return;
        }

        public function set usbListener(arg1:de.pagecon.usb.UsbListener):void
        {
            mUsbListener = arg1;
            if (mUsbListener == null) 
            {
                debug("remove usbListener");
                extContext.removeEventListener("status", onStatus);
            }
            else 
            {
                debug("add usbListener");
                extContext.addEventListener("status", onStatus);
            }
            return;
        }

        public function disconnectDevice(arg1:int):void
        {
            debug("disconnectDevice: " + arg1.toString());
            extContext.call("disconnectDevice", arg1);
            return;
        }

        public function sendData(arg1:int, arg2:Array):Boolean
        {
            debug("sendData: " + arg1.toString());
            var loc1:*=extContext.call("sendData", arg1, JSON.stringify(arg2)) as Boolean;
            return loc1;
        }

        public function getConnectedDevices():Array
        {
            var loc6:*=null;
            var loc5:*=0;
            debug("getConnectedDevices");
            var loc1:*=[];
            var loc4:*=extContext.call("getConnectedDevices") as String;
            var loc2:*=JSON.parse(loc4) as Array;
            var loc3:*=loc2.length;
            loc5 = 0;
            while (loc5 < loc3) 
            {
                loc6 = loc2[loc5];
                loc1.push(new de.pagecon.usb.SigmaDevice(loc6["deviceVID"], loc6["devicePID"], loc6["deviceID"]));
                ++loc5;
            }
            return loc1;
        }

        internal function debug(arg1:String):void
        {
            if (mDebugMode) 
            {
                trace("[UcbController] " + arg1);
            }
            return;
        }

        public function isSupported():Boolean
        {
            var loc2:*=false;
            var loc1:*=flash.system.Capabilities.os;
            var loc3:*=flash.system.Capabilities.version;
            if (loc1.indexOf("Windows") >= 0) 
            {
                loc2 = true;
            }
            else if (loc1.indexOf("Mac") >= 0) 
            {
                loc2 = true;
            }
            else if (loc3.indexOf("AND") >= 0) 
            {
                loc2 = extContext.call("isSupported") as Boolean;
            }
            debug("isSupported: " + loc2.toString());
            return loc2;
        }

        public function setSupportedDevices(arg1:Array):void
        {
            var loc2:*=0;
            var loc3:*=null;
            var loc1:*=[];
            loc2 = 0;
            while (loc2 < arg1.length) 
            {
                loc3 = arg1[loc2] as de.pagecon.usb.SigmaDevice;
                loc1.push(loc3.vid, loc3.pid);
                ++loc2;
            }
            debug("setSupportedDevices: " + JSON.stringify(loc1));
            extContext.call("setSupportedDevices", JSON.stringify(loc1));
            return;
        }

        public function getAttachedDevices():Array
        {
            var loc6:*=null;
            var loc5:*=0;
            debug("getAttachedDevices");
            var loc1:*=[];
            var loc4:*=extContext.call("getAttachedDevices") as String;
            var loc2:*=JSON.parse(loc4) as Array;
            var loc3:*=loc2.length;
            loc5 = 0;
            while (loc5 < loc3) 
            {
                loc6 = loc2[loc5];
                loc1.push(new de.pagecon.usb.SigmaDevice(loc6["deviceVID"], loc6["devicePID"], loc6["deviceID"]));
                ++loc5;
            }
            return loc1;
        }

        internal function onStatus(arg1:flash.events.StatusEvent):void
        {
            var loc3:*=null;
            var loc8:*=0;
            var loc1:*=null;
            var loc6:*=0;
            var loc2:*=0;
            var loc5:*=arg1.code;
            var loc4:*=arg1.level;
            var loc7:*=null;
            if (mUsbListener == null) 
            {
                return;
            }
            if (loc5 != "deviceConnected") 
            {
                if (loc5 != "deviceConnectionFailed") 
                {
                    if (loc5 != "deviceDisconnected") 
                    {
                        if (loc5 != "deviceConnectionLost") 
                        {
                            if (loc5 != "deviceAttached") 
                            {
                                if (loc5 != "deviceDetached") 
                                {
                                    if (loc5 != "dataReceived") 
                                    {
                                        if (loc5 == "debugInfo") 
                                        {
                                            mUsbListener.debugInfo(loc4);
                                        }
                                    }
                                    else 
                                    {
                                        loc8 = (loc3 = (loc7 = JSON.parse(loc4) as Object).data as Array).length;
                                        loc1 = [];
                                        loc6 = 0;
                                        while (loc6 < loc8) 
                                        {
                                            loc2 = loc3[loc6] as int;
                                            if (loc2 < 0) 
                                            {
                                                loc2 = 256 + loc2;
                                            }
                                            loc1.push(loc2);
                                            ++loc6;
                                        }
                                        mUsbListener.dataReceived(loc7.deviceID, loc1);
                                    }
                                }
                                else 
                                {
                                    loc7 = JSON.parse(loc4) as Object;
                                    mUsbListener.connectionEvent(6, new de.pagecon.usb.SigmaDevice(loc7["deviceVID"], loc7["devicePID"], loc7["deviceID"]));
                                }
                            }
                            else 
                            {
                                loc7 = JSON.parse(loc4) as Object;
                                mUsbListener.connectionEvent(5, new de.pagecon.usb.SigmaDevice(loc7["deviceVID"], loc7["devicePID"], loc7["deviceID"]));
                            }
                        }
                        else 
                        {
                            loc7 = JSON.parse(loc4) as Object;
                            mUsbListener.connectionEvent(4, new de.pagecon.usb.SigmaDevice(loc7["deviceVID"], loc7["devicePID"], loc7["deviceID"]));
                        }
                    }
                    else 
                    {
                        loc7 = JSON.parse(loc4) as Object;
                        mUsbListener.connectionEvent(3, new de.pagecon.usb.SigmaDevice(loc7["deviceVID"], loc7["devicePID"], loc7["deviceID"]));
                    }
                }
                else 
                {
                    loc7 = JSON.parse(loc4) as Object;
                    mUsbListener.connectionEvent(2, new de.pagecon.usb.SigmaDevice(loc7["deviceVID"], loc7["devicePID"], loc7["deviceID"]));
                }
            }
            else 
            {
                loc7 = JSON.parse(loc4) as Object;
                mUsbListener.connectionEvent(1, new de.pagecon.usb.SigmaDevice(loc7["deviceVID"], loc7["devicePID"], loc7["deviceID"]));
            }
            return;
        }

        public function connectDevice(arg1:int):int
        {
            debug("connectDevice: " + arg1.toString());
            return extContext.call("connectDevice", arg1) as int;
        }

        internal static const DEVICE_ID:String="deviceID";

        internal static const DEVICE_PID:String="devicePID";

        internal static const DEVICE_VID:String="deviceVID";

        public static const ALREADY_CONNECTED:int=11;

        public static const COMMAND_CONNECT_DEVICE:String="connectDevice";

        public static const COMMAND_DISCONNECT_DEVICE:String="disconnectDevice";

        public static const COMMAND_GET_ATTACHED_DEVICES:String="getAttachedDevices";

        public static const COMMAND_GET_CONNECTED_DEVICES:String="getConnectedDevices";

        public static const COMMAND_IS_SUPPORTED:String="isSupported";

        public static const COMMAND_SEND_DATA:String="sendData";

        public static const COMMAND_SET_DEBUG_MODE:String="setDebugMode";

        public static const COMMAND_SET_SUPPORTED_DEVICES:String="setSupportedDevices";

        public static const DEVICE_ATTACHED:int=5;

        public static const DEVICE_CONNECTED:int=1;

        public static const DEVICE_CONNECTION_FAILED:int=2;

        public static const DEVICE_CONNECTION_LOST:int=4;

        public static const DEVICE_DETACHED:int=6;

        public static const DEVICE_DISCONNECTED:int=3;

        public static const DEVICE_NOT_FOUND:int=14;

        public static const REQUESTING_PERMISSION:int=13;

        public static const TRYING_TO_CONNECT:int=12;

        internal static const ACTION_DATA_RECEIVED:String="dataReceived";

        internal static const ACTION_DEBUG_INFO:String="debugInfo";

        internal static const ACTION_DEVICE_ATTACHED:String="deviceAttached";

        internal static const ACTION_DEVICE_CONNECTED:String="deviceConnected";

        internal static const ACTION_DEVICE_CONNECTION_FAILED:String="deviceConnectionFailed";

        internal static const ACTION_DEVICE_CONNECTION_LOST:String="deviceConnectionLost";

        internal static const ACTION_DEVICE_DETACHED:String="deviceDetached";

        internal static const ACTION_DEVICE_DISCONNECTED:String="deviceDisconnected";

        internal static const DATA:String="data";

        internal var extContext:flash.external.ExtensionContext;

        internal var mDebugMode:Boolean=false;

        internal var mUsbListener:de.pagecon.usb.UsbListener=null;

        public static var PLATFORM_NOT_SUPPORTED:int=1337;

        internal static var _instance:de.pagecon.usb.UsbController;
    }
}


