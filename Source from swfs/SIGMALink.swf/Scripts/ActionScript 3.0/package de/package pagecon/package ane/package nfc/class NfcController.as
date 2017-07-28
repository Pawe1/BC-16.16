//class NfcController
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


