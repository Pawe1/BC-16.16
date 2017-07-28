//class Topline2009Handler
package handler 
{
    import __AS3__.vec.*;
    import com.logging.*;
    import core.units.*;
    import decoder.*;
    import flash.events.*;
    import flash.utils.*;
    import service.*;
    import service.usb.event.*;
    
    public class Topline2009Handler extends handler.UnitHandler
    {
        public function Topline2009Handler()
        {
            super();
            return;
        }

        public override function get unit():core.units.Unit
        {
            return _myUnit;
        }

        public override function set unit(arg1:core.units.Unit):void
        {
            _myUnit = arg1 as core.units.UnitTopline2009;
            return;
        }

        public override function destructor():void
        {
            super.destructor();
            service.DeviceCommunicationHandler.getInstance().removeEventListener("usbComplete", onLoaded, false);
            return;
        }

        internal function onLoaded(arg1:service.usb.event.DeviceDataCompleteEvent):void
        {
            var loc1:*=undefined;
            service.DeviceCommunicationHandler.getInstance().removeEventListener("usbComplete", onLoaded, false);
            if (arg1.command == 253.toString() && currentType == "loadUnitSettings") 
            {
                _myUnit.currentSettings = decoder.Topline2009Decoder.getInstance().decodeSettings(arg1.data, _myUnit);
                if (_myUnit.currentSettings == null) 
                {
                    dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 10002, "CurrentUnitHandler > onLoaded: Can not create setting data"));
                }
                else 
                {
                    dispatchEvent(new flash.events.Event("settingsLoadedFromUnitComplete"));
                }
            }
            if (arg1.command == 253.toString() && currentType == "loadTotalValues") 
            {
                _myUnit.currentTotals = decoder.Topline2009Decoder.getInstance().decodeTotals(arg1.data, _myUnit);
                if (_myUnit.currentTotals == null) 
                {
                    dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 10002, "CurrentUnitHandler > onLoaded: Can not create setting data"));
                }
                else 
                {
                    dispatchEvent(new flash.events.Event("totalsLoadComplete"));
                }
            }
            else if (arg1.command != 251.toString()) 
            {
                if (arg1.command == 252.toString()) 
                {
                    dispatchEvent(new flash.events.Event("settingsSendComplete", false, false));
                }
            }
            else 
            {
                loc1 = decoder.Topline2009Decoder.getInstance().decodeMemory(arg1.data, _myUnit);
                if (loc1 != null) 
                {
                    _myUnit.loadedMemories = loc1;
                    dispatchEvent(new flash.events.Event("memoriesLoadedFromUnitComplete"));
                }
            }
            service.DeviceCommunicationHandler.getInstance().processNextCommandFromQueue();
            return;
        }

        public override function loadFromDC(arg1:String):void
        {
            if (service.DeviceCommunicationHandler.getInstance().nativeProcessIsBusy) 
            {
                service.DeviceCommunicationHandler.getInstance().addToCommandQueue(arg1, "loadCommand", this);
                return;
            }
            service.DeviceCommunicationHandler.getInstance().addEventListener("usbComplete", onLoaded, false, 0, false);
            currentType = arg1;
            if (arg1 == "loadUnitSettings") 
            {
                currentCommand = 253;
                currentBytesToReceive = 99;
            }
            if (arg1 != "loadTotalValues") 
            {
                if (arg1 == "loadUnitTripData") 
                {
                    currentCommand = 251;
                    currentBytesToReceive = 48;
                }
            }
            else 
            {
                currentCommand = 253;
                currentBytesToReceive = 99;
            }
            service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBuffer(currentCommand), this);
            return;
        }

        public override function sendToDC(arg1:String):void
        {
            var loc3:*=null;
            var loc2:*=0;
            var loc1:*=null;
            if (service.DeviceCommunicationHandler.getInstance().nativeProcessIsBusy) 
            {
                service.DeviceCommunicationHandler.getInstance().addToCommandQueue(arg1, "sendCommand", this);
                return;
            }
            service.DeviceCommunicationHandler.getInstance().addEventListener("usbComplete", onLoaded, false, 0, false);
            if (arg1 == "writeUnitSettings") 
            {
                loc1 = decoder.Topline2009Decoder.getInstance().encodeSettings(unit);
                loc3 = 252.toString(16);
                loc2 = 1;
                currentCommand = 252;
                currentBytesToReceive = 1;
                service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBuffer(currentCommand, loc1), this);
            }
            return;
        }

        protected function generateNativeProzessBuffer(arg1:uint, arg2:Array=null):flash.utils.ByteArray
        {
            var loc1:*=0;
            var loc2:*;
            (loc2 = new flash.utils.ByteArray()).writeByte(arg1);
            if (arg2 != null) 
            {
                loc1 = 0;
                while (loc1 < arg2.length) 
                {
                    loc2.writeByte(arg2[loc1]);
                    ++loc1;
                }
            }
            return loc2;
        }

        public override function toString():String
        {
            return "ToplineHandler";
        }

        public static const GET_AT_EL_COUNT_COMMAND:uint=249;

        public static const GET_SETTINGS_DATA_BYTES_TO_RECEIVE:uint=99;

        public static const GET_SETTINGS_DATA_COMMAND:uint=253;

        public static const GET_TRIP_DATA_BYTES_TO_RECEIVE:uint=48;

        public static const GET_TRIP_DATA_COMMAND:uint=251;

        public static const GET_VERSION_DATA_COMMAND:uint=254;

        public static const IS_BC_ONLINE_COMMAND:uint=255;

        public static const RESET_AT_EL_COUNT_COMMAND:uint=248;

        public static const SEND_SETTINGS_DATA_BYTES_TO_RECEIVE:uint=1;

        public static const SEND_SETTINGS_DATA_COMMAND:uint=252;

        public static const SET_SERIAL_NUMBER_COMMAND:uint=250;

        public static const UNIT_CONNECTED_COMMAND:uint=244;

        internal var _myUnit:core.units.UnitTopline2009;
    }
}


