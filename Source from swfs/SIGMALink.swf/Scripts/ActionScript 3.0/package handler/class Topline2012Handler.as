//class Topline2012Handler
package handler 
{
    import __AS3__.vec.*;
    import com.logging.*;
    import core.activities.*;
    import core.settings.*;
    import core.units.*;
    import core.units.interfaces.*;
    import decoder.*;
    import flash.events.*;
    import flash.utils.*;
    import service.*;
    import service.usb.event.*;
    
    public class Topline2012Handler extends handler.UnitHandler
    {
        public function Topline2012Handler()
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
            _myUnit = arg1 as core.units.UnitTopline2012;
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
            service.DeviceCommunicationHandler.getInstance().removeEventListener("usbComplete", onLoaded, false);
            if (arg1.command == 253.toString()) 
            {
                _myUnit.currentSettings = decoder.Topline2012Decoder.getInstance().decodeSettings(arg1.data, _myUnit);
                if (_myUnit.currentSettings != null) 
                {
                    dispatchEvent(new flash.events.Event("settingsLoadedFromUnitComplete"));
                }
                else 
                {
                    dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 10002, "CurrentUnitHandler > onLoaded: Can not create setting data"));
                }
            }
            if (arg1.command != 242.toString()) 
            {
                if (arg1.command != 251.toString()) 
                {
                    if (arg1.command != 252.toString()) 
                    {
                        if (arg1.command != 241.toString()) 
                        {
                            if (arg1.command == 240.toString()) 
                            {
                                if (arg1.data[0] != 1) 
                                {
                                };
                                unit.loadedMemories = new __AS3__.vec.Vector.<core.activities.Activity>();
                                dispatchEvent(new flash.events.Event("sendResetMomoryToDeviceComplete", false, false));
                                if (unit is core.units.interfaces.ILogList) 
                                {
                                    (unit as core.units.interfaces.ILogList).loadedLogs = new __AS3__.vec.Vector.<core.activities.Activity>();
                                }
                                dispatchEvent(new flash.events.Event("logDeleteCompleteEvent", false, false));
                            }
                        }
                        else 
                        {
                            dispatchEvent(new flash.events.Event("sendTotalValuesComplete", false, false));
                        }
                    }
                    else 
                    {
                        dispatchEvent(new flash.events.Event("settingsSendComplete", false, false));
                    }
                }
                else 
                {
                    _myUnit.loadedMemories = decoder.Topline2012Decoder.getInstance().decodeMemory(arg1.data, _myUnit);
                    if (_myUnit.loadedMemories != null) 
                    {
                        dispatchEvent(new flash.events.Event("memoriesLoadedFromUnitComplete"));
                    }
                }
            }
            else 
            {
                _myUnit.currentTotals = decoder.Topline2012Decoder.getInstance().decodeTotals(arg1.data, _myUnit);
                if (_myUnit.currentTotals != null) 
                {
                    dispatchEvent(new flash.events.Event("totalsLoadComplete"));
                }
                else 
                {
                    dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 10002, "CurrentUnitHandler > onLoaded: Can not create setting data"));
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
            if (arg1 != "loadUnitSettings") 
            {
                if (arg1 != "loadUnitTripData") 
                {
                    if (arg1 == "loadTotalValues") 
                    {
                        currentCommand = 242;
                        currentBytesToReceive = 23;
                    }
                }
                else 
                {
                    currentCommand = 251;
                    currentBytesToReceive = 27;
                }
            }
            else 
            {
                currentCommand = 253;
                currentBytesToReceive = 25;
            }
            service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBuffer(currentCommand), this);
            return;
        }

        public override function sendToDC(arg1:String):void
        {
            var loc2:*=0;
            var loc1:*=null;
            if (service.DeviceCommunicationHandler.getInstance().nativeProcessIsBusy) 
            {
                service.DeviceCommunicationHandler.getInstance().addToCommandQueue(arg1, "sendCommand", this);
                return;
            }
            service.DeviceCommunicationHandler.getInstance().addEventListener("usbComplete", onLoaded, false, 0, false);
            if (arg1 != "writeUnitSettings") 
            {
                if (arg1 != "writeTotalValues") 
                {
                    if (arg1 == "deleteUnitMemoryData") 
                    {
                        loc1 = [];
                        loc1[0] = 2;
                        loc2 = 1;
                        currentCommand = 240;
                        currentBytesToReceive = 1;
                        service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBuffer(currentCommand, loc1), this);
                    }
                }
                else 
                {
                    loc1 = decoder.Topline2012Decoder.getInstance().encodeTotals((unit as core.units.interfaces.ITotalsList).currentTotals);
                    loc2 = 1;
                    currentCommand = 241;
                    currentBytesToReceive = 1;
                    service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBuffer(currentCommand, loc1), this);
                }
            }
            else 
            {
                loc1 = decoder.Topline2012Decoder.getInstance().encodeSettings(unit);
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

        public static const GET_BC_TOTALS_BYTES_TO_RECEIVE:uint=23;

        public static const GET_BC_TOTALS_COMMAND:uint=242;

        public static const GET_SETTINGS_DATA_BYTES_TO_RECEIVE:uint=25;

        public static const GET_SETTINGS_DATA_COMMAND:uint=253;

        public static const GET_TRIP_DATA_BYTES_TO_RECEIVE:uint=27;

        public static const GET_TRIP_DATA_COMMAND:uint=251;

        public static const RESET_AT_EL_COUNT_COMMAND:uint=248;

        public static const SEND_BC_POWERMODE_COMMAND:uint=240;

        public static const SEND_BC_RESET_MEMORY_BYTES_TO_RECEIVE:uint=1;

        public static const SEND_BC_TOTALS_BYTES_TO_RECEIVE:uint=1;

        public static const SEND_BC_TOTALS_COMMAND:uint=241;

        public static const SEND_SETTINGS_DATA_BYTES_TO_RECEIVE:uint=1;

        public static const SEND_SETTINGS_DATA_COMMAND:uint=252;

        public static const SET_SERIAL_NUMBER_COMMAND:uint=250;

        internal var _myUnit:core.units.UnitTopline2012;

        internal var _myUnitSettings:core.settings.SettingsBikeComputer;
    }
}


