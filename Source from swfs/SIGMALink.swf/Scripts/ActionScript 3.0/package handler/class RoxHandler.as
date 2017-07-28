//class RoxHandler
package handler 
{
    import __AS3__.vec.*;
    import core.activities.*;
    import core.settings.*;
    import core.units.*;
    import core.units.interfaces.*;
    import decoder.*;
    import flash.events.*;
    import flash.utils.*;
    import service.*;
    import service.usb.event.*;
    
    public class RoxHandler extends handler.UnitHandler
    {
        public function RoxHandler(arg1:flash.events.IEventDispatcher=null)
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
            _myUnit = arg1 as core.units.UnitROX;
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
            var loc4:*=0;
            var loc6:*=null;
            var loc3:*=null;
            var loc1:*=0;
            var loc5:*=null;
            var loc2:*=null;
            service.DeviceCommunicationHandler.getInstance().removeEventListener("usbComplete", onLoaded, false);
            if (arg1.command == 71.toString() && currentType == "loadUnitSettings") 
            {
                _myUnit.currentSettings = decoder.RoxDecoder.getInstance().decodeSettings(arg1.data, _myUnit);
                dispatchEvent(new flash.events.Event("settingsLoadedFromUnitComplete"));
                dispatchEvent(new flash.events.Event("batteryInformationLoadedFromUnitComplete", false, false));
            }
            else if (arg1.command == 71.toString() && currentType == "loadTotalValues") 
            {
                _myUnit.currentTotals = decoder.RoxDecoder.getInstance().decodeTotals(arg1.data, _myUnit);
                dispatchEvent(new flash.events.Event("totalsLoadComplete"));
            }
            else if (arg1.command != 72.toString()) 
            {
                if (arg1.command != 74.toString()) 
                {
                    if (arg1.command == 75.toString()) 
                    {
                        loc1 = 0;
                        while (loc1 < _numberOfPages) 
                        {
                            loc5 = (_myUnit as core.units.UnitROX9).loadedLogs[loc1];
                            loc2 = arg1.data.slice(2 + loc5.startAdress - 2608, loc5.stopAdress + 3 - 2608);
                            core.activities.ActivityFactory.applyZoneValues(loc5, true, false);
                            decoder.RoxDecoder.getInstance().decodeLog(loc5, loc2);
                            loc5.statistic = false;
                            ++loc1;
                        }
                        dispatchEvent(new flash.events.Event("logsLoadedFromUnitComplete"));
                    }
                }
                else 
                {
                    if (_numberOfPages == -1) 
                    {
                        _numberOfPages = decoder.RoxDecoder.getInstance().decodeNumberOfPages(arg1.data);
                        if (_numberOfPages == 0) 
                        {
                            if (_myUnit != null) 
                            {
                                (_myUnit as core.units.UnitROX9).loadedLogs = new __AS3__.vec.Vector.<core.activities.Activity>();
                            }
                            calculateAvailableLogTime();
                            dispatchEvent(new flash.events.Event("pageHeaderChange", false, false));
                            service.DeviceCommunicationHandler.getInstance().processNextCommandFromQueue();
                            return;
                        }
                        service.DeviceCommunicationHandler.getInstance().addEventListener("usbComplete", onLoaded, false, 0, false);
                        currentCommand = 74;
                        currentBytesToReceive = _numberOfPages * 27;
                        service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBuffer(74), this, true);
                        return;
                    }
                    (_myUnit as core.units.UnitROX9).loadedLogs = new __AS3__.vec.Vector.<core.activities.Activity>(_numberOfPages);
                    loc4 = (_numberOfPages - 1);
                    while (loc4 >= 0) 
                    {
                        loc6 = arg1.data.slice(loc4 * 27, (loc4 + 1) * 27);
                        loc3 = decoder.RoxDecoder.getInstance().decodePageHeaderInformation(loc6, _myUnit);
                        (_myUnit as core.units.UnitROX9).loadedLogs[loc4] = loc3;
                        --loc4;
                    }
                    calculateAvailableLogTime();
                    dispatchEvent(new flash.events.Event("pageHeaderChange", false, false));
                }
            }
            else 
            {
                _myUnit.loadedMemories = decoder.RoxDecoder.getInstance().decodeMemory(arg1.data, _myUnit);
                dispatchEvent(new flash.events.Event("memoriesLoadedFromUnitComplete", false, false));
            }
            service.DeviceCommunicationHandler.getInstance().processNextCommandFromQueue();
            return;
        }

        public override function loadFromDC(arg1:String):void
        {
            var loc2:*=0;
            var loc1:*=0;
            if (service.DeviceCommunicationHandler.getInstance().nativeProcessIsBusy) 
            {
                service.DeviceCommunicationHandler.getInstance().addToCommandQueue(arg1, "loadCommand", this);
                return;
            }
            service.DeviceCommunicationHandler.getInstance().addEventListener("usbComplete", onLoaded, false, 0, false);
            currentType = arg1;
            if (arg1 != "loadUnitSettings") 
            {
                if (arg1 != "loadTotalValues") 
                {
                    if (arg1 != "loadUnitTripData") 
                    {
                        if (arg1 != "loadUnitlogDataHeader") 
                        {
                            if (arg1 == "loadUnitlogData") 
                            {
                                loc2 = 2608;
                                loc1 = (_myUnit as core.units.UnitROX9).loadedLogs[0].stopAdress;
                                currentCommand = 75;
                                currentBytesToReceive = loc1 - loc2 + 3;
                            }
                        }
                        else 
                        {
                            currentCommand = 74;
                            currentBytesToReceive = 2;
                            _numberOfPages = -1;
                        }
                    }
                    else 
                    {
                        currentCommand = 72;
                        currentBytesToReceive = 560;
                    }
                }
                else 
                {
                    currentCommand = 71;
                    currentBytesToReceive = 142;
                }
            }
            else 
            {
                currentCommand = 71;
                currentBytesToReceive = 142;
            }
            service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBuffer(currentCommand), this);
            return;
        }

        public override function sendToDC(arg1:String):void
        {
            var loc3:*=null;
            var loc5:*=null;
            var loc4:*=null;
            var loc1:*=null;
            var loc2:*=null;
            if (service.DeviceCommunicationHandler.getInstance().nativeProcessIsBusy) 
            {
                service.DeviceCommunicationHandler.getInstance().addToCommandQueue(arg1, "sendCommand", this);
                return;
            }
            service.DeviceCommunicationHandler.getInstance().addEventListener("usbComplete", onLoaded, false, 0, false);
            if (arg1 != "writeUnitSettings") 
            {
                if (arg1 != "writeUnitInformation") 
                {
                    if (arg1 == "deleteUnitlogData") 
                    {
                        currentCommand = 95;
                        currentBytesToReceive = 0;
                        service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBuffer(currentCommand), this);
                        loc2 = new flash.utils.Timer(500, 1);
                        loc2.addEventListener("timerComplete", fakeDeleteLogsComplete);
                        loc2.start();
                    }
                }
                else if ((loc4 = decoder.RoxDecoder.getInstance().encodeUnitInformation(unit as core.units.UnitROX)) == null) 
                {
                    dispatchEvent(new flash.events.Event("writeUnitInformationComplete", false, false));
                }
                else 
                {
                    currentCommand = 96;
                    currentBytesToReceive = 0;
                    service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBuffer(currentCommand, loc4), this);
                    loc1 = new flash.utils.Timer(500, 1);
                    loc1.addEventListener("timerComplete", fakeWriteInitialInformationComplete);
                    loc1.start();
                }
            }
            else 
            {
                loc3 = decoder.RoxDecoder.getInstance().encodeSettings(unit);
                currentCommand = 91;
                currentBytesToReceive = 0;
                service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBuffer(currentCommand, loc3), this);
                (loc5 = new flash.utils.Timer(1000, 1)).addEventListener("timerComplete", fakeSettingSend);
                loc5.start();
            }
            return;
        }

        internal function fakeDeleteLogsComplete(arg1:flash.events.TimerEvent):void
        {
            (arg1.target as flash.utils.Timer).removeEventListener("timerComplete", fakeDeleteLogsComplete);
            (arg1.target as flash.utils.Timer).stop();
            dispatchEvent(new flash.events.Event("logDeleteCompleteEvent", false, false));
            if (unit is core.units.interfaces.ILogList) 
            {
                (unit as core.units.interfaces.ILogList).loadedLogs = new __AS3__.vec.Vector.<core.activities.Activity>();
            }
            service.DeviceCommunicationHandler.getInstance().nativeProcessIsBusy = false;
            service.DeviceCommunicationHandler.getInstance().processNextCommandFromQueue();
            return;
        }

        internal function fakeSettingSend(arg1:flash.events.TimerEvent):void
        {
            (arg1.target as flash.utils.Timer).removeEventListener("timerComplete", fakeSettingSend);
            (arg1.target as flash.utils.Timer).stop();
            dispatchEvent(new flash.events.Event("settingsSendComplete", false, false));
            service.DeviceCommunicationHandler.getInstance().nativeProcessIsBusy = false;
            service.DeviceCommunicationHandler.getInstance().processNextCommandFromQueue();
            return;
        }

        internal function fakeWriteInitialInformationComplete(arg1:flash.events.TimerEvent):void
        {
            (arg1.target as flash.utils.Timer).removeEventListener("timerComplete", fakeWriteInitialInformationComplete);
            (arg1.target as flash.utils.Timer).stop();
            dispatchEvent(new flash.events.Event("writeUnitInformationComplete", false, false));
            service.DeviceCommunicationHandler.getInstance().nativeProcessIsBusy = false;
            service.DeviceCommunicationHandler.getInstance().processNextCommandFromQueue();
            return;
        }

        protected function generateNativeProzessBuffer(arg1:uint, arg2:Array=null):flash.utils.ByteArray
        {
            var loc1:*=0;
            var loc2:*;
            (loc2 = new flash.utils.ByteArray()).writeByte(arg1);
            loc2.writeByte(255 - arg1);
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

        internal function calculateAvailableLogTime():void
        {
            var loc5:*=null;
            var loc1:*=0;
            var loc3:*=0;
            var loc4:*=0;
            var loc2:*=0;
            var loc9:*=0;
            var loc8:*=0;
            var loc10:*=0;
            var loc6:*=0;
            var loc7:*=0;
            loc1 = 10282;
            (unit as core.units.interfaces.ILogStatus).maxPackages = loc1;
            if ((unit as core.units.interfaces.ILogList).loadedLogs.length > 0) 
            {
                loc4 = (loc5 = (unit as core.units.interfaces.ILogList).loadedLogs[0]).stopAdress;
                loc3 = 65333 - (unit as core.units.interfaces.ILogList).loadedLogs.length * 27;
            }
            else 
            {
                loc4 = 2608;
                loc3 = 65333;
            }
            if ((loc3 - loc4 - 1) > 0) 
            {
                loc2 = (loc3 - loc4 - 1);
            }
            loc8 = Math.floor(loc2 / 61);
            if ((loc10 = loc2 % 61) > 7) 
            {
                loc7 = 1;
                if (loc10 - 7 > 6) 
                {
                    loc6 = Math.floor((loc10 - 7) / 6);
                }
            }
            loc9 = loc8 * 10 + loc6 + loc7;
            (unit as core.units.interfaces.ILogStatus).freePackages = loc9;
            (unit as core.units.interfaces.ILogTime5Sec).logTime5Sec = loc9 * 5;
            (unit as core.units.interfaces.ILogTime10Sec).logTime10Sec = loc9 * 10;
            (unit as core.units.interfaces.ILogTime20Sec).logTime20Sec = loc9 * 20;
            (unit as core.units.interfaces.ILogTime30Sec).logTime30Sec = loc9 * 30;
            return;
        }

        public override function toString():String
        {
            return "RoxHandler";
        }

        public static const DELETE_LOGS_COMMAND:uint=95;

        public static const LOAD_INITIALINFORMATION_BYTES_TO_RECEIVE:uint=16;

        public static const LOAD_INITIALINFORMATION_COMMAND:uint=70;

        public static const LOAD_LOG_DATA_COMMAND:uint=75;

        public static const LOAD_PAGE_HEADER_BYTES_TO_RECEIVE:uint=2;

        public static const LOAD_PAGE_HEADER_DATA_COMMAND:uint=74;

        public static const LOAD_SETTINGS_BYTES_TO_RECEIVE:uint=142;

        public static const LOAD_SETTINGS_COMMAND:uint=71;

        public static const LOAD_TRIPS_BYTES_TO_RECEIVE:uint=560;

        public static const LOAD_TRIP_DATA_COMMAND:uint=72;

        public static const ROX_COMMAND_VALUE:uint=255;

        public static const UNIT_CONNECTED_COMMAND:uint=114;

        public static const WRITE_INITIALINFORMATION_COMMAND:uint=96;

        public static const WRITE_SETTINGS_COMMAND:uint=91;

        internal var _myUnit:core.units.UnitROX;

        internal var _myUnitSettings:core.settings.SettingsROX;

        internal var _numberOfPages:int=-1;
    }
}


