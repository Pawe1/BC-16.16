//package ane
//  package networkInfo
//    class AirNetworkInfo
package de.pagecon.ane.networkInfo 
{
    import __AS3__.vec.*;
    import flash.events.*;
    import flash.external.*;
    import flash.net.*;
    import flash.system.*;
    
    public class AirNetworkInfo extends flash.events.EventDispatcher
    {
        public function AirNetworkInfo()
        {
            super();
            extContext = flash.external.ExtensionContext.createExtensionContext("de.pagecon.ane.networkInfo", "net");
            if (useNativeExtension()) 
            {
                if (extContext) 
                {
                    extContext.addEventListener("status", onStatusEvent);
                }
            }
            else 
            {
                flash.net.NetworkInfo.networkInfo.addEventListener("networkChange", onNetworkChange);
            }
            return;
        }

        internal function onStatusEvent(arg1:flash.events.StatusEvent):void
        {
            this.dispatchEvent(new flash.events.Event(arg1.code));
            return;
        }

        internal function onNetworkChange(arg1:flash.events.Event):void
        {
            this.dispatchEvent(arg1);
            return;
        }

        public function setLogging(arg1:Boolean):void
        {
            doLogging = arg1;
            if (this.useNativeExtension()) 
            {
                extContext.call("setLogging", doLogging);
            }
            return;
        }

        public function isConnected():Boolean
        {
            if (this.useNativeExtension()) 
            {
                return hasNativeActiveConnection();
            }
            return hasActiveConnection();
        }

        public function isConnectedWithWIFI():Boolean
        {
            if (this.useNativeExtension()) 
            {
                return isNativeConnectedWithWIFI();
            }
            return isNotNativeConnectedWithWIFI();
        }

        internal function isNativeConnectedWithWIFI():Boolean
        {
            var loc2:*=0;
            var loc1:*=this.findInterfaces();
            loc2 = 0;
            while (loc2 < loc1.length) 
            {
                if (doLogging) 
                {
                    trace("[Network Info][isNativeConnectedWithWIFI]", loc1[loc2].toString());
                }
                if (loc1[loc2].active && loc1[loc2].name.toLocaleLowerCase() == "en0") 
                {
                    return true;
                }
                ++loc2;
            }
            return false;
        }

        internal function isNotNativeConnectedWithWIFI():Boolean
        {
            var loc2:*=0;
            var loc1:*=flash.net.NetworkInfo.networkInfo.findInterfaces();
            loc2 = 0;
            while (loc2 < loc1.length) 
            {
                if (doLogging) 
                {
                    trace("[Network Info][isNotNativeConnectedWithWIFI]", loc1[loc2].toString());
                }
                if (loc1[loc2].active && ["en0", "wifi"].indexOf(loc1[loc2].name.toLocaleLowerCase()) > -1) 
                {
                    return true;
                }
                ++loc2;
            }
            return false;
        }

        internal function hasNativeActiveConnection():Boolean
        {
            var loc2:*=0;
            var loc1:*=this.findInterfaces();
            if (loc1.length == 0) 
            {
                return true;
            }
            loc2 = 0;
            while (loc2 < loc1.length) 
            {
                if (doLogging) 
                {
                    trace("[Network Info][hasNativeActiveConnection]", loc1[loc2].toString());
                }
                if (loc1[loc2].active) 
                {
                    return true;
                }
                ++loc2;
            }
            return false;
        }

        internal function hasActiveConnection():Boolean
        {
            var loc2:*=0;
            var loc1:*=flash.net.NetworkInfo.networkInfo.findInterfaces();
            loc2 = 0;
            while (loc2 < loc1.length) 
            {
                if (doLogging) 
                {
                    trace("[Network Info][hasActiveConnection]", loc1[loc2].toString());
                }
                if (loc1[loc2].active) 
                {
                    return true;
                }
                ++loc2;
            }
            return false;
        }

        public function findInterfaces():__AS3__.vec.Vector.<de.pagecon.ane.networkInfo.NativeNetworkInterface>
        {
            var loc2:*=undefined;
            var loc1:*=extContext.call("getInterfaces") as Array;
            var loc3:*=0;
            loc2 = __AS3__.vec.Vector.<de.pagecon.ane.networkInfo.NativeNetworkInterface>(loc1);
            return loc2;
        }

        internal function useNativeExtension():Boolean
        {
            return flash.system.Capabilities.manufacturer.indexOf("iOS") > -1;
        }

        public static function get networkInfo():de.pagecon.ane.networkInfo.AirNetworkInfo
        {
            if (_instance == null) 
            {
                _instance = new AirNetworkInfo();
            }
            return _instance;
        }

        internal static var _instance:de.pagecon.ane.networkInfo.AirNetworkInfo=null;

        internal static var doLogging:Boolean=false;

        internal static var extContext:flash.external.ExtensionContext=null;
    }
}


//    class NativeNetworkInterface
package de.pagecon.ane.networkInfo 
{
    public class NativeNetworkInterface extends Object
    {
        public function NativeNetworkInterface(arg1:String, arg2:String, arg3:int, arg4:Boolean, arg5:String, arg6:Array)
        {
            super();
            _name = arg1;
            _displayName = arg2;
            _mtu = arg3;
            _hardwareAddress = arg5;
            _active = arg4;
            return;
        }

        public function get active():Boolean
        {
            return _active;
        }

        public function get displayName():String
        {
            return _displayName;
        }

        public function get hardwareAddress():String
        {
            return _hardwareAddress;
        }

        public function get mtu():int
        {
            return _mtu;
        }

        public function get name():String
        {
            return _name;
        }

        public function toString():String
        {
            return "[NativeNetworkInterface] Name: " + name + " ::: displayName: " + displayName + " ::: hardwareAddress: " + hardwareAddress + " ::: mtu: " + mtu + " ::: active: " + active;
        }

        internal var _active:Boolean=false;

        internal var _displayName:String="";

        internal var _hardwareAddress:String="";

        internal var _mtu:int=-1;

        internal var _name:String="";
    }
}


//  package nfc
//    package debug
//      class Debug
package de.pagecon.ane.nfc.debug 
{
    import flash.globalization.*;
    
    public class Debug extends Object
    {
        public function Debug()
        {
            super();
            return;
        }

        public static function addlog(... rest):void
        {
            var loc7:*=0;
            if (!DEBUG_MODE) 
            {
                return;
            }
            var loc1:*="";
            var loc12:*="";
            var loc3:*="";
            var loc6:*="";
            var loc2:*="";
            var loc4:*="";
            var loc5:*;
            var loc10:*;
            var loc11:*;
            if ((loc11 = (loc10 = (loc5 = new Error()).getStackTrace()).split("\n")).hasOwnProperty(2)) 
            {
                loc6 = (loc12 = loc11[2].slice(4, loc11[2].length)).split("/")[0] + " ::: ";
                loc4 = loc12.split("()")[0] + "() -> ";
                if (loc11.hasOwnProperty(3)) 
                {
                    loc1 = loc11[3].slice(4, loc11[3].length);
                    loc3 = loc1.split("/")[0] + " ::: ";
                    loc2 = loc1.split("()")[0] + "() -> ";
                }
            }
            var loc9:*=new flash.globalization.DateTimeFormatter("i-default", "short", "none");
            var loc8:*="HH:mm:ss";
            loc9.setDateTimePattern(loc8);
            loc7 = 0;
            while (loc7 < rest.length) 
            {
                trace("[" + loc9.format(new Date()) + "] [NFCANE] ::: " + loc2 + loc4 + rest[loc7].toString());
                ++loc7;
            }
            return;
        }

        public static var DEBUG_MODE:Boolean=true;
    }
}


//    package events
//      class NfcEvent
package de.pagecon.ane.nfc.events 
{
    import flash.events.*;
    
    public class NfcEvent extends flash.events.Event
    {
        public function NfcEvent(arg1:String, arg2:Object=null, arg3:Boolean=false, arg4:Boolean=false)
        {
            super(arg1, arg3, arg4);
            this.optionalParameters = arg2;
            var loc2:*=0;
            var loc1:*=params.length;
            if (optionalParameters != null) 
            {
                while (loc2 < loc1) 
                {
                    if (optionalParameters.hasOwnProperty(params[loc2]) && this.hasOwnProperty(params[loc2])) 
                    {
                        this[params[loc2]] = optionalParameters[params[loc2]];
                    }
                    ++loc2;
                }
            }
            return;
        }

        public function get byteString():String
        {
            return _byteString;
        }

        public function set byteString(arg1:String):void
        {
            _byteString = arg1;
            rArray = _byteString.split(" ");
            return;
        }

        public override function clone():flash.events.Event
        {
            return new de.pagecon.ane.nfc.events.NfcEvent(type, optionalParameters, bubbles, cancelable);
        }

        public override function toString():String
        {
            return "[NfcEvent] " + type + "\t\t" + JSON.stringify(this);
        }

        
        {
            params = new Array("byteString", "endAddr", "errorCode", "errorMessage", "startAddr");
        }

        public static const EVENT_NFC_CLOSE_TAG_READY:String="eventNfcCloseTagReady";

        public static const EVENT_NFC_DEVICE_CONNECTED:String="eventNfcDeviceConnected";

        public static const EVENT_NFC_ERROR:String="eventNfcError";

        public static const EVENT_NFC_ON_INVOKE:String="eventNfcOnInvoke";

        public static const EVENT_NFC_READ_EEPROM_READY:String="eventNfcReadEepromReady";

        public static const EVENT_NFC_READ_FLASH_READY:String="eventNfcReadFlashReady";

        public static const EVENT_NFC_STATUS_CHANGED:String="eventNfcStatusChanged";

        public static const EVENT_NFC_STEP_RESULT_READY:String="eventNfcStepResultReady";

        public static const EVENT_NFC_STEP_RESULT_RESET:String="eventNfcStepResultReset";

        public static const EVENT_NFC_WRITE_EEPROM_READY:String="eventNfcWriteEepromReady";

        public static const EVENT_NFC_WRITE_FLASH_READY:String="eventNfcWriteFlashReady";

        public static const PARAM_NAME_BYTE_STRING:String="byteString";

        public static const PARAM_NAME_END_ADDR:String="endAddr";

        public static const PARAM_NAME_ERROR_CODE:String="errorCode";

        public static const PARAM_NAME_ERROR_MESSAGE:String="errorMessage";

        public static const PARAM_NAME_START_ADDR:String="startAddr";

        internal var _byteString:String;

        public var data:String;

        public var endAddr:uint;

        public var errorCode:uint;

        public var errorMessage:String;

        public var optionalParameters:Object;

        public var rArray:Array;

        public var startAddr:uint;

        public var writeStatus:String;

        public static var params:Array;
    }
}


//    class NfcController
package de.pagecon.ane.nfc 
{
    import __AS3__.vec.*;
    import de.pagecon.ane.nfc.debug.*;
    import de.pagecon.ane.nfc.events.*;
    import de.pagecon.ane.nxptag.*;
    import flash.desktop.*;
    import flash.events.*;
    import flash.external.*;
    
    public class NfcController extends flash.events.EventDispatcher
    {
        public function NfcController(arg1:flash.events.IEventDispatcher=null)
        {
            _blockedListeners = new Array("eventNfcError", "eventNfcOnInvoke", "eventNfcStatusChanged");
            _listeners = new __AS3__.vec.Vector.<Array>();
            super(arg1);
            if (_shouldCreateInstance) 
            {
                de.pagecon.ane.nfc.debug.Debug.addlog("Please use NfcController.instance instead!");
                throw new Error("Please use NfcController.instance instead!");
                return;
            }
            try 
            {
                _extContext = flash.external.ExtensionContext.createExtensionContext("de.pagecon.ane.nfc", "nfc");
                _extContext.addEventListener("status", onStatus);
                flash.desktop.NativeApplication.nativeApplication.addEventListener("activate", onActivate);
                flash.desktop.NativeApplication.nativeApplication.addEventListener("deactivate", onDeactivate);
                flash.desktop.NativeApplication.nativeApplication.addEventListener("invoke", onInvoke);
            }
            catch (error:Error)
            {
                de.pagecon.ane.nfc.debug.Debug.addlog("error: " + error);
            }
            return;
        }

        public function set debugMode(arg1:Boolean):void
        {
            de.pagecon.ane.nfc.debug.Debug.DEBUG_MODE = arg1;
            if (_extContext != null) 
            {
                _extContext.call("setDebugMode", arg1);
            }
            return;
        }

        public function get nxpTag():de.pagecon.ane.nxptag.NxpTag
        {
            if (_nxpTag == null) 
            {
                _nxpTag = new de.pagecon.ane.nxptag.NxpTag();
            }
            return _nxpTag;
        }

        public final function handleNxpTag(... rest):void
        {
            de.pagecon.ane.nfc.debug.Debug.addlog("handleNxpTag");
            if (_extContext != null) 
            {
                _extContext.call("handleNxpTag", rest);
            }
            return;
        }

        public override function addEventListener(arg1:String, arg2:Function, arg3:Boolean=false, arg4:int=0, arg5:Boolean=false):void
        {
            var loc1:*=0;
            while (loc1 < _listeners.length) 
            {
                if (_listeners[loc1][0] == arg1 && _listeners[loc1][1] == arg2) 
                {
                    return;
                }
                ++loc1;
            }
            de.pagecon.ane.nfc.debug.Debug.addlog("[addEventListener] " + arg1);
            _listeners.push(new Array(arg1, arg2));
            super.addEventListener(arg1, arg2, arg3, arg4, arg5);
            return;
        }

        public override function removeEventListener(arg1:String, arg2:Function, arg3:Boolean=false):void
        {
            var loc1:*=0;
            while (loc1 < _listeners.length) 
            {
                if (_listeners[loc1][0] == arg1 && _listeners[loc1][1] == arg2) 
                {
                    de.pagecon.ane.nfc.debug.Debug.addlog("[removeEventListener] " + arg1);
                    _listeners.removeAt(loc1);
                    super.removeEventListener(arg1, arg2, arg3);
                    return;
                }
                ++loc1;
            }
            return;
        }

        public function removeListeners():void
        {
            var loc2:*=null;
            de.pagecon.ane.nfc.debug.Debug.addlog("[removeListeners]");
            var loc1:*=0;
            while (loc1 < _listeners.length) 
            {
                loc2 = _listeners[loc1][0] as String;
                if (_blockedListeners.indexOf(loc2) < 0) 
                {
                    removeEventListener(loc2, _listeners[loc1][1] as Function);
                }
                ++loc1;
            }
            return;
        }

        internal function onActivate(arg1:flash.events.Event):void
        {
            de.pagecon.ane.nfc.debug.Debug.addlog("onActivate");
            if (_extContext != null) 
            {
                _extContext.call("nativeResume");
            }
            return;
        }

        public function getAneVersion():String
        {
            if (_extContext != null) 
            {
                return "[Native Version: " + (_extContext.call("getNativeNfcAneVersion") as String) + "] [AS Version: " + "1.6" + "]";
            }
            return "[Native Version: unknown] [AS Version: 1.6]";
        }

        public function dispose():void
        {
            _nxpTag = null;
            de.pagecon.ane.nfc.debug.Debug.addlog("dispose");
            return;
        }

        internal function onStatus(arg1:flash.events.StatusEvent):void
        {
            var loc2:*=arg1.code;
            var loc1:*=arg1.level;
            var loc4:*=null;
            var loc3:*=null;
            if (loc1) 
            {
                loc4 = JSON.parse(loc1) as Object;
            }
            loc3 = new de.pagecon.ane.nfc.events.NfcEvent(loc2, loc4);
            dispatchEvent(loc3);
            if (loc3 != null) 
            {
                de.pagecon.ane.nfc.debug.Debug.addlog(loc3.toString());
            }
            return;
        }

        internal function initNfc():void
        {
            de.pagecon.ane.nfc.debug.Debug.addlog("initNfc");
            if (_extContext != null) 
            {
                _extContext.call("initNfc");
            }
            return;
        }

        public function isNfcSupported():Boolean
        {
            de.pagecon.ane.nfc.debug.Debug.addlog("isNfcSupported");
            return _extContext == null ? false : _extContext.call("isNfcSupported") as Boolean;
        }

        public function isNfcEnabled():Boolean
        {
            de.pagecon.ane.nfc.debug.Debug.addlog("isNfcEnabled");
            return _extContext == null ? false : _extContext.call("isNfcEnabled") as Boolean;
        }

        public static function get instance():de.pagecon.ane.nfc.NfcController
        {
            if (!_instance) 
            {
                _shouldCreateInstance = false;
                _instance = new NfcController();
                _instance.initNfc();
            }
            return _instance;
        }

        internal function onDeactivate(arg1:flash.events.Event):void
        {
            de.pagecon.ane.nfc.debug.Debug.addlog("onDeactivate");
            if (_extContext != null) 
            {
                _extContext.call("nativePause");
            }
            return;
        }

        internal function onInvoke(arg1:flash.events.InvokeEvent):void
        {
            var loc1:*=null;
            if (!(arg1.arguments == null) && (!(arg1.arguments.indexOf("android.nfc.action.NDEF_DISCOVERED") == -1) || !(arg1.arguments.indexOf("android.nfc.action.TAG_DISCOVERED") == -1))) 
            {
                de.pagecon.ane.nfc.debug.Debug.addlog("onInvoke: " + JSON.stringify(arg1.arguments));
                loc1 = new de.pagecon.ane.nfc.events.NfcEvent("eventNfcOnInvoke");
                dispatchEvent(loc1);
            }
            return;
        }

        public function readEeprom(arg1:Number, arg2:Number):void
        {
            de.pagecon.ane.nfc.debug.Debug.addlog("readNfcEeprom");
            _startAddr = arg1;
            _endAddr = arg2;
            if (_extContext != null) 
            {
                _extContext.call("readNfcEeprom", _startAddr, _endAddr);
            }
            return;
        }

        public function writeEeprom(arg1:Number, arg2:String, arg3:Boolean=false):void
        {
            de.pagecon.ane.nfc.debug.Debug.addlog("writeNfcEeprom");
            if (_extContext != null) 
            {
                _extContext.call("writeNfcEeprom", arg1, arg2, arg3);
            }
            return;
        }

        public function readFlash(arg1:Number, arg2:Number, arg3:String, arg4:Boolean=false, arg5:uint=6, arg6:uint=1, arg7:uint=4):void
        {
            de.pagecon.ane.nfc.debug.Debug.addlog("readNfcFlash");
            if (_extContext != null) 
            {
                _extContext.call("readNfcFlash", arg1, arg2, arg3, arg4, arg5, arg6, arg7);
            }
            return;
        }

        public function writeFlash(arg1:String, arg2:Boolean=false, arg3:uint=6, arg4:uint=1):void
        {
            de.pagecon.ane.nfc.debug.Debug.addlog("writeNfcFlash");
            if (_extContext != null) 
            {
                _extContext.call("writeNfcFlash", arg1, arg2, arg3, arg4);
            }
            return;
        }

        public function askForNfc():void
        {
            de.pagecon.ane.nfc.debug.Debug.addlog("askForNfc");
            if (_extContext != null) 
            {
                _extContext.call("askForNfc");
            }
            return;
        }

        public function closeTag():void
        {
            de.pagecon.ane.nfc.debug.Debug.addlog("closeNfcTag");
            if (_extContext != null) 
            {
                _extContext.call("closeNfcTag");
            }
            return;
        }

        public static const FIFO_BIT_8:uint=128;

        public static const FIFO_BIT_DEFAULT:uint=1;

        public static const READ_BLOCK_DELAY_DEFAULT:uint=4;

        public static const READ_DELAY_DEFAULT:uint=6;

        public static const ANE_AS_VERSION:String="1.6";

        public static const COMMAND_ASK_FOR_NFC:String="askForNfc";

        public static const COMMAND_CLOSE_TAG:String="closeNfcTag";

        public static const COMMAND_GET_NATIVE_NFC_ANE_VERSION:String="getNativeNfcAneVersion";

        public static const COMMAND_HANDLE_NXPTAG:String="handleNxpTag";

        public static const COMMAND_INIT_NFC:String="initNfc";

        public static const COMMAND_NATIVE_PAUSE:String="nativePause";

        public static const COMMAND_NATIVE_RESUME:String="nativeResume";

        public static const COMMAND_NFC_ENABLED:String="isNfcEnabled";

        public static const COMMAND_NFC_SUPPORTED:String="isNfcSupported";

        public static const COMMAND_READ_EEPROM:String="readNfcEeprom";

        public static const COMMAND_READ_FLASH:String="readNfcFlash";

        public static const COMMAND_SET_DEBUG_MODE:String="setDebugMode";

        public static const COMMAND_WRITE_EEPROM:String="writeNfcEeprom";

        public static const COMMAND_WRITE_FLASH:String="writeNfcFlash";

        public static const FIFO_BIT_1:uint=1;

        public static const FIFO_BIT_2:uint=2;

        public static const FIFO_BIT_3:uint=4;

        public static const FIFO_BIT_4:uint=8;

        public static const FIFO_BIT_5:uint=16;

        public static const FIFO_BIT_6:uint=32;

        public static const FIFO_BIT_7:uint=64;

        internal var _blockedListeners:Array;

        internal var _endAddr:Number=0;

        internal var _extContext:flash.external.ExtensionContext;

        internal var _listeners:__AS3__.vec.Vector.<Array>;

        internal static var _instance:de.pagecon.ane.nfc.NfcController;

        internal var _startAddr:Number=0;

        internal static var _nxpTag:de.pagecon.ane.nxptag.NxpTag;

        internal static var _shouldCreateInstance:Boolean=true;
    }
}


//  package notificationlistenerservice
//    package debug
//      class Debug
package de.pagecon.ane.notificationlistenerservice.debug 
{
    import flash.globalization.*;
    
    public class Debug extends Object
    {
        public function Debug()
        {
            super();
            return;
        }

        public static function addlog(... rest):void
        {
            var loc8:*=0;
            if (!DEBUG_MODE) 
            {
                return;
            }
            var loc2:*="";
            var loc3:*="";
            var loc5:*="";
            var loc1:*="";
            var loc7:*="";
            var loc4:*="";
            var loc11:*;
            var loc12:*;
            var loc6:*;
            if ((loc6 = (loc12 = (loc11 = new Error()).getStackTrace()).split("\n")).hasOwnProperty(2)) 
            {
                loc1 = (loc3 = loc6[2].slice(4, loc6[2].length)).split("/")[0] + " ::: ";
                loc4 = loc3.split("()")[0] + "() -> ";
                if (loc6.hasOwnProperty(3)) 
                {
                    loc2 = loc6[3].slice(4, loc6[3].length);
                    loc5 = loc2.split("/")[0] + " ::: ";
                    loc7 = loc2.split("()")[0] + "() -> ";
                }
            }
            var loc9:*=new flash.globalization.DateTimeFormatter("i-default", "short", "none");
            var loc10:*="HH:mm:ss";
            loc9.setDateTimePattern(loc10);
            loc8 = 0;
            while (loc8 < rest.length) 
            {
                trace("[" + loc9.format(new Date()) + "] [NOTIFICATION LISTENER SERVICE ANE] ::: " + loc7 + loc4 + rest[loc8].toString());
                ++loc8;
            }
            return;
        }

        public static var DEBUG_MODE:Boolean=true;
    }
}


//    package events
//      class ApplicationStateChangedEvent
package de.pagecon.ane.notificationlistenerservice.events 
{
    import flash.events.*;
    
    public class ApplicationStateChangedEvent extends flash.events.Event
    {
        public function ApplicationStateChangedEvent(arg1:String, arg2:String, arg3:String)
        {
            super(arg1, bubbles, cancelable);
            this.activityName = arg3;
            var loc1:*=arg2;
            while ("create" === loc1) 
            {
                this.state = arg2;
            }
        }

        public override function clone():flash.events.Event
        {
            return new de.pagecon.ane.notificationlistenerservice.events.ApplicationStateChangedEvent(type, state, activityName);
        }

        public override function toString():String
        {
            return "[ApplicationStateChangedEvent] " + type + "\t\t" + JSON.stringify(this);
        }

        public static const APPLICATION_STATE_CREATE:String="create";

        public static const APPLICATION_STATE_DESTROY:String="destroy";

        public static const APPLICATION_STATE_PAUSE:String="pause";

        public static const APPLICATION_STATE_RESUME:String="resume";

        public static const APPLICATION_STATE_SAVEINSTANCE:String="saveinstance";

        public static const APPLICATION_STATE_START:String="start";

        public static const APPLICATION_STATE_STOP:String="stop";

        public static const APPLICATION_STATE_UNKNOWN:String="unknown";

        public var activityName:String;

        public var state:String;
    }
}


//      class NotificationServiceControllerEvent
package de.pagecon.ane.notificationlistenerservice.events 
{
    import flash.events.*;
    
    public class NotificationServiceControllerEvent extends flash.events.Event
    {
        public function NotificationServiceControllerEvent(arg1:String, arg2:Object=null, arg3:Boolean=false, arg4:Boolean=false)
        {
            super(arg1, arg3, arg4);
            this.optionalParameters = arg2;
            var loc2:*=0;
            var loc1:*=params.length;
            if (optionalParameters != null) 
            {
                while (loc2 < loc1) 
                {
                    if (optionalParameters.hasOwnProperty(params[loc2]) && this.hasOwnProperty(params[loc2])) 
                    {
                        this[params[loc2]] = optionalParameters[params[loc2]];
                    }
                    ++loc2;
                }
            }
            return;
        }

        public override function toString():String
        {
            return "[NotificationServiceControllerEvent] " + type + "\t\t" + JSON.stringify(this);
        }

        
        {
            params = new Array("id", "tickerText", "infoText", "subText", "extraTextLines", "summaryText", "title", "titleBig", "text", "textBig", "packageName", "postTime", "tag", "groupKey", "group", "sdk", "category", "errorCode", "errorMessage");
        }

        public override function clone():flash.events.Event
        {
            return new de.pagecon.ane.notificationlistenerservice.events.NotificationServiceControllerEvent(type, optionalParameters, bubbles, cancelable);
        }

        public static const PARAM_NAME_ERROR_MESSAGE:String="errorMessage";

        public static const PARAM_NAME_NOTIFICATION_CATEGORY:String="category";

        public static const PARAM_NAME_NOTIFICATION_EXTRA_TEXT_LINES:String="extraTextLines";

        public static const PARAM_NAME_NOTIFICATION_GROUPKEY:String="groupKey";

        public static const PARAM_NAME_NOTIFICATION_GROUP:String="group";

        public static const PARAM_NAME_NOTIFICATION_ID:String="id";

        public static const PARAM_NAME_NOTIFICATION_INFO_TEXT:String="infoText";

        public static const PARAM_NAME_NOTIFICATION_MESSAGE:String="tickerText";

        public static const PARAM_NAME_NOTIFICATION_PACKAGENAME:String="packageName";

        public static const PARAM_NAME_NOTIFICATION_SDK:String="sdk";

        public static const PARAM_NAME_NOTIFICATION_SUB_TEXT:String="subText";

        public static const PARAM_NAME_NOTIFICATION_SUMMARY_TEXT:String="summaryText";

        public static const PARAM_NAME_NOTIFICATION_TAG:String="tag";

        public static const PARAM_NAME_NOTIFICATION_TEXT_BIG:String="textBig";

        public static const PARAM_NAME_NOTIFICATION_TITLE:String="title";

        public static const PARAM_NAME_NOTIFICATION_TITLE_BIG:String="titleBig";

        public static const PARAM_NAME_NOTIFICATION_TEXT:String="text";

        public static const PARAM_NAME_NOTIFICATION_POSTTIME:String="postTime";

        public static const PARAM_NAME_ERROR_CODE:String="errorCode";

        public var category:String;

        public var errorCode:uint;

        public var errorMessage:String;

        public var extraTextLines:String;

        public var groupKey:String;

        public var id:uint;

        public var optionalParameters:Object;

        public var packageName:String;

        public var postTime:uint;

        public var sdk:uint;

        public var subText:String;

        public var summaryText:String;

        public var tag:String;

        public var text:String;

        public var tickerText:String;

        public var title:String;

        public var titleBig:String;

        public var group:String;

        public static var params:Array;

        public var textBig:String;
    }
}


//      class NotificationStatusChangedEvent
package de.pagecon.ane.notificationlistenerservice.events 
{
    import flash.events.*;
    
    public class NotificationStatusChangedEvent extends flash.events.Event
    {
        public function NotificationStatusChangedEvent(arg1:String, arg2:Boolean, arg3:Boolean=false, arg4:Boolean=false)
        {
            super(arg1, arg3, arg4);
            this.notificationsEnabled = notificationsEnabled;
            return;
        }

        public override function clone():flash.events.Event
        {
            return new de.pagecon.ane.notificationlistenerservice.events.NotificationServiceControllerEvent(type, notificationsEnabled, bubbles, cancelable);
        }

        public override function toString():String
        {
            return "[NotificationStatusChangedEvent] " + type + "\t\t" + JSON.stringify(this);
        }

        public var notificationsEnabled:Boolean;
    }
}


//    class NotificationServiceController
package de.pagecon.ane.notificationlistenerservice 
{
    import __AS3__.vec.*;
    import de.pagecon.ane.notificationlistenerservice.debug.*;
    import de.pagecon.ane.notificationlistenerservice.events.*;
    import flash.events.*;
    import flash.external.*;
    
    public class NotificationServiceController extends flash.events.EventDispatcher
    {
        public function NotificationServiceController(arg1:flash.events.IEventDispatcher=null)
        {
            _blockedListeners = [];
            _listeners = new __AS3__.vec.Vector.<Array>();
            super(arg1);
            if (_shouldCreateInstance) 
            {
                de.pagecon.ane.notificationlistenerservice.debug.Debug.addlog("Please use NotificationServiceController.instance instead!");
                throw new Error("Please use NotificationServiceController.instance instead!");
                return;
            }
            try 
            {
                _extContext = flash.external.ExtensionContext.createExtensionContext("de.pagecon.ane.notificationlistenerservice", "notificationlistenerservice");
                if (_extContext == null) 
                {
                    de.pagecon.ane.notificationlistenerservice.debug.Debug.addlog("ExtensionContext is null");
                    throw new Error("ExtensionContext is null");
                }
                _extContext.addEventListener("status", onStatus);
            }
            catch (error:Error)
            {
                de.pagecon.ane.notificationlistenerservice.debug.Debug.addlog("error: " + error);
            }
            return;
        }

        public function set debugMode(arg1:Boolean):void
        {
            de.pagecon.ane.notificationlistenerservice.debug.Debug.DEBUG_MODE = arg1;
            if (_extContext != null) 
            {
                _extContext.call("setNotificationDebugMode", arg1);
            }
            return;
        }

        public function openSecuritySettings():void
        {
            if (_extContext != null) 
            {
                _extContext.call("openSecuritySettings");
            }
            return;
        }

        public function getNotificationsEnabled():Boolean
        {
            if (_extContext != null) 
            {
                return _extContext.call("getNotificationsEnabled");
            }
            return false;
        }

        public function getNativeAneVersion():uint
        {
            if (_extContext != null) 
            {
                return _extContext.call("getNativeAneVersion") as uint;
            }
            return 0;
        }

        internal function onStatus(arg1:flash.events.StatusEvent):void
        {
            var loc3:*=arg1.code;
            var loc1:*=arg1.level;
            var loc4:*=null;
            var loc2:*=null;
            if (loc1) 
            {
                loc4 = JSON.parse(loc1) as Object;
            }
            var loc5:*=loc3;
            while ("eventNotification" === loc5) 
            {
                loc2 = new de.pagecon.ane.notificationlistenerservice.events.NotificationServiceControllerEvent(loc3, loc4);
            }
        }

        internal function initialize():void
        {
            if (_extContext != null) 
            {
                _extContext.call("initialize");
            }
            return;
        }

        public override function addEventListener(arg1:String, arg2:Function, arg3:Boolean=false, arg4:int=0, arg5:Boolean=false):void
        {
            var loc1:*=0;
            while (loc1 < _listeners.length) 
            {
                if (_listeners[loc1][0] == arg1 && _listeners[loc1][1] == arg2) 
                {
                    return;
                }
                ++loc1;
            }
            _listeners.push(new Array(arg1, arg2));
            super.addEventListener(arg1, arg2, arg3, arg4, arg5);
            return;
        }

        public override function removeEventListener(arg1:String, arg2:Function, arg3:Boolean=false):void
        {
            var loc1:*=0;
            while (loc1 < _listeners.length) 
            {
                if (_listeners[loc1][0] == arg1 && _listeners[loc1][1] == arg2) 
                {
                    _listeners.removeAt(loc1);
                    super.removeEventListener(arg1, arg2, arg3);
                    return;
                }
                ++loc1;
            }
            return;
        }

        public function removeListeners():void
        {
            var loc1:*=null;
            var loc2:*=0;
            while (loc2 < _listeners.length) 
            {
                loc1 = _listeners[loc2][0] as String;
                if (_blockedListeners.indexOf(loc1) < 0) 
                {
                    removeEventListener(loc1, _listeners[loc2][1] as Function);
                }
                ++loc2;
            }
            return;
        }

        public static function get instance():de.pagecon.ane.notificationlistenerservice.NotificationServiceController
        {
            if (!_instance) 
            {
                _shouldCreateInstance = false;
                _instance = new NotificationServiceController();
                _instance.initialize();
            }
            return _instance;
        }

        public static const COMMAND_GET_NATIVE_ANE_VERSION:String="getNativeAneVersion";

        public static const COMMAND_GET_NOTIFICATIONS_ENABLED:String="getNotificationsEnabled";

        public static const COMMAND_INIT:String="initialize";

        public static const COMMAND_OPEN_SECURITY_SETTINGS:String="openSecuritySettings";

        public static const COMMAND_SET_DEBUG_MODE:String="setNotificationDebugMode";

        public static const EVENT_APPLICATION_STATE_CHANGED:String="eventApplicationStateChanged";

        public static const EVENT_NOTIFICATION:String="eventNotification";

        public static const EVENT_STATUS_CHANGED:String="eventNotificationStatusChanged";

        public static const FIELD_STATE_CHANGED_ACTIVITYNAME:String="activityName";

        public static const FIELD_STATE_CHANGED_STATE:String="state";

        internal var _blockedListeners:Array;

        internal var _extContext:flash.external.ExtensionContext;

        internal var _listeners:__AS3__.vec.Vector.<Array>;

        internal static var _instance:de.pagecon.ane.notificationlistenerservice.NotificationServiceController;

        internal static var _shouldCreateInstance:Boolean=true;
    }
}


//  package nxptag
//    class NxpTag
package de.pagecon.ane.nxptag 
{
    import de.pagecon.ane.nfc.*;
    import flash.events.*;
    
    public class NxpTag extends flash.events.EventDispatcher
    {
        public function NxpTag()
        {
            super();
            init();
            return;
        }

        internal function init():void
        {
            return;
        }

        public function connect():void
        {
            de.pagecon.ane.nfc.NfcController.instance.handleNxpTag(10);
            return;
        }

        public function isConnected():void
        {
            de.pagecon.ane.nfc.NfcController.instance.handleNxpTag(11);
            return;
        }

        public function close():void
        {
            de.pagecon.ane.nfc.NfcController.instance.handleNxpTag(20);
            return;
        }

        public function fast_read():void
        {
            de.pagecon.ane.nfc.NfcController.instance.handleNxpTag(31);
            return;
        }

        public function write():void
        {
            de.pagecon.ane.nfc.NfcController.instance.handleNxpTag(30);
            return;
        }

        public function write_SRAM():void
        {
            de.pagecon.ane.nfc.NfcController.instance.handleNxpTag(40);
            return;
        }

        public function read_SRam():void
        {
            de.pagecon.ane.nfc.NfcController.instance.handleNxpTag(41);
            return;
        }

        public static function nxpCommandValid(arg1:uint):Boolean
        {
            var loc1:*=false;
            var loc2:*=arg1;
            while (10 === loc2) 
            {
                loc1 = true;
            }
        }

        public static const METHOD_CLOSE:uint=20;

        public static const METHOD_CONNECT:uint=10;

        public static const METHOD_FAST_READ:uint=31;

        public static const METHOD_ISCONNECTED:uint=11;

        public static const METHOD_READ_SRAM:uint=41;

        public static const METHOD_UNKNOWN:uint=0;

        public static const METHOD_WRITE:uint=30;

        public static const METHOD_WRITE_SRAM:uint=40;

        internal var _nfcController:de.pagecon.ane.nfc.NfcController;
    }
}


