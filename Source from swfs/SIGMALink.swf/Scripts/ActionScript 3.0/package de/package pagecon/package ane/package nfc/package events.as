//package events
//  class NfcEvent
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


