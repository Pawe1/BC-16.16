//class Rox2010Handler
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
    import handler.interfaces.*;
    import service.*;
    import service.usb.*;
    import service.usb.event.*;
    
    public class Rox2010Handler extends handler.UnitHandler implements handler.interfaces.IGhostRaceLog
    {
        public function Rox2010Handler(arg1:flash.events.IEventDispatcher=null)
        {
            super();
            return;
        }

        internal function onDataSend(arg1:flash.events.TimerEvent):void
        {
            (arg1.currentTarget as service.usb.USBSendTimer).sentBytes = (arg1.currentTarget as service.usb.USBSendTimer).sentBytes - 256;
            if ((arg1.currentTarget as service.usb.USBSendTimer).sentBytes <= 0) 
            {
                (arg1.currentTarget as service.usb.USBSendTimer).removeEventListener("timer", onDataSend);
                service.DeviceCommunicationHandler.getInstance().nativeProcessIsBusy = false;
                service.DeviceCommunicationHandler.getInstance().processNextCommandFromQueue();
                flash.utils.setTimeout(dispatchEvent, 1000, new flash.events.Event("sendGhostRaceComplete", false, false));
            }
            else 
            {
                dispatchEvent(new flash.events.ProgressEvent("sendGhostRaceProgress", false, false, 20500 - (arg1.currentTarget as service.usb.USBSendTimer).sentBytes, 20500));
            }
            return;
        }

        public function get ghostRaceLog():core.activities.Activity
        {
            return _ghostRaceLog;
        }

        public function set ghostRaceLog(arg1:core.activities.Activity):void
        {
            _ghostRaceLog = arg1;
            return;
        }

        public override function get unit():core.units.Unit
        {
            return _myUnit;
        }

        public override function set unit(arg1:core.units.Unit):void
        {
            _myUnit = arg1 as core.units.UnitROX2010;
            return;
        }

        internal function onUnitOnlineChange(arg1:flash.events.Event):void
        {
            _myUnit.removeEventListener("isOnlineChange", onUnitOnlineChange);
            if (_timer != null) 
            {
                _timer.removeEventListener("timer", onDataSend);
                _timer.stop();
                service.DeviceCommunicationHandler.getInstance().nativeProcessIsBusy = false;
                dispatchEvent(new flash.events.Event("sendGhostRaceError", false, false));
            }
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
            var loc1:*=NaN;
            var loc5:*=0;
            var loc8:*=null;
            var loc9:*=0;
            var loc2:*=0;
            var loc4:*=0;
            var loc10:*=0;
            var loc12:*=0;
            var loc6:*=0;
            var loc7:*=0;
            var loc11:*=0;
            var loc3:*=10865;
            (unit as core.units.interfaces.ILogStatus).maxPackages = loc3;
            if ((unit as core.units.interfaces.ILogList).loadedLogs.length > 0) 
            {
                loc1 = 0;
                loc5 = 0;
                while (loc5 < (unit as core.units.interfaces.ILogList).loadedLogs.length) 
                {
                    loc8 = (unit as core.units.interfaces.ILogList).loadedLogs[loc5];
                    loc1 = loc1 + (loc8.stopAdress - loc8.startAdress);
                    loc1 = loc1 + 39;
                    ++loc5;
                }
                loc4 = 109743 - loc1;
            }
            else 
            {
                loc9 = 21104;
                loc2 = 130847;
                loc4 = (loc2 - loc9 - 1);
            }
            loc10 = Math.floor(loc4 / 101);
            if ((loc12 = loc4 % 101) > 11) 
            {
                loc7 = 1;
                if (loc12 - 11 > 10) 
                {
                    loc6 = Math.floor((loc12 - 11) / 10);
                }
            }
            loc11 = loc10 * 10 + loc6 + loc7;
            (unit as core.units.interfaces.ILogStatus).freePackages = loc11;
            (unit as core.units.interfaces.ILogTime5Sec).logTime5Sec = loc11 * 5;
            (unit as core.units.interfaces.ILogTime10Sec).logTime10Sec = loc11 * 10;
            (unit as core.units.interfaces.ILogTime20Sec).logTime20Sec = loc11 * 20;
            (unit as core.units.interfaces.ILogTime30Sec).logTime30Sec = loc11 * 30;
            return;
        }

        public override function toString():String
        {
            return "Rox2010Handler";
        }

        public override function destructor():void
        {
            super.destructor();
            service.DeviceCommunicationHandler.getInstance().removeEventListener("usbComplete", onLoaded);
            return;
        }

        internal function onLoaded(arg1:service.usb.event.DeviceDataCompleteEvent):void
        {
            var loc5:*=null;
            var loc1:*=0;
            var loc6:*=0;
            var loc8:*=null;
            var loc4:*=null;
            var loc2:*=0;
            var loc7:*=null;
            var loc3:*=null;
            service.DeviceCommunicationHandler.getInstance().removeEventListener("usbComplete", onLoaded, false);
            if (arg1.command == 30.toString() && currentType == "loadUnitSettings") 
            {
                _myUnit.currentSettings = decoder.Rox2010Decoder.getInstance().decodeSettings(arg1.data, _myUnit);
                dispatchEvent(new flash.events.Event("settingsLoadedFromUnitComplete"));
                dispatchEvent(new flash.events.Event("batteryInformationLoadedFromUnitComplete", false, false));
            }
            if (arg1.command == 30.toString() && currentType == "loadTotalValues") 
            {
                _myUnit.currentTotals = decoder.Rox2010Decoder.getInstance().decodeTotals(arg1.data, _myUnit);
                dispatchEvent(new flash.events.Event("totalsLoadComplete"));
            }
            else if (arg1.command != 31.toString()) 
            {
                if (arg1.command != 33.toString()) 
                {
                    if (arg1.command == 34.toString()) 
                    {
                        loc2 = 0;
                        while (loc2 < _numberOfPages) 
                        {
                            loc7 = (_myUnit as core.units.UnitROX91).loadedLogs[loc2] as core.activities.Activity;
                            loc3 = arg1.data.slice(loc7.startAdress + 3 - 21104, loc7.stopAdress + 3 - 21104);
                            loc7.unit = _myUnit;
                            core.activities.ActivityFactory.applyZoneValues(loc7, true, true);
                            decoder.Rox2010Decoder.getInstance().decodeLog(loc7, loc3);
                            loc7.statistic = false;
                            ++loc2;
                        }
                        dispatchEvent(new flash.events.Event("logsLoadedFromUnitComplete"));
                    }
                }
                else 
                {
                    if (_numberOfPages == -1) 
                    {
                        _numberOfPages = decoder.Rox2010Decoder.getInstance().decodeNumberOfPages(arg1.data);
                        if (_numberOfPages == 0) 
                        {
                            if (_myUnit != null) 
                            {
                                (_myUnit as core.units.UnitROX91).loadedLogs = new __AS3__.vec.Vector.<core.activities.Activity>();
                            }
                            calculateAvailableLogTime();
                            dispatchEvent(new flash.events.Event("pageHeaderChange", false, false));
                            service.DeviceCommunicationHandler.getInstance().processNextCommandFromQueue();
                            return;
                        }
                        service.DeviceCommunicationHandler.getInstance().addEventListener("usbComplete", onLoaded, false, 0, false);
                        currentCommand = 33;
                        currentBytesToReceive = _numberOfPages * 39;
                        service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBuffer(33), this, true);
                        return;
                    }
                    loc5 = new Array(_numberOfPages);
                    (_myUnit as core.units.UnitROX91).loadedLogs = new __AS3__.vec.Vector.<core.activities.Activity>();
                    loc1 = 0;
                    while (loc1 < _numberOfPages) 
                    {
                        (_myUnit as core.units.UnitROX91).loadedLogs.push(null);
                        ++loc1;
                    }
                    loc6 = (_numberOfPages - 1);
                    while (loc6 >= 0) 
                    {
                        loc8 = arg1.data.slice(loc6 * 39, (loc6 + 1) * 39);
                        (loc4 = decoder.Rox2010Decoder.getInstance().decodePageHeaderInformation(loc8, _myUnit)).unit = _myUnit;
                        (_myUnit as core.units.UnitROX91).loadedLogs[loc6] = loc4;
                        --loc6;
                    }
                    calculateAvailableLogTime();
                    dispatchEvent(new flash.events.Event("pageHeaderChange", false, false));
                }
            }
            else 
            {
                _myUnit.loadedMemories = decoder.Rox2010Decoder.getInstance().decodeMemory(arg1.data, _myUnit);
                dispatchEvent(new flash.events.Event("memoriesLoadedFromUnitComplete"));
            }
            service.DeviceCommunicationHandler.getInstance().processNextCommandFromQueue();
            return;
        }

        protected override function removeEvents():void
        {
            service.DeviceCommunicationHandler.getInstance().removeEventListener("usbComplete", onLoaded, false);
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
                                loc2 = 21104;
                                loc1 = (_myUnit as core.units.UnitROX91).loadedLogs[0].stopAdress;
                                currentCommand = 34;
                                currentBytesToReceive = loc1 - loc2 + 4;
                            }
                        }
                        else 
                        {
                            currentCommand = 33;
                            currentBytesToReceive = 2;
                            _numberOfPages = -1;
                        }
                    }
                    else 
                    {
                        currentCommand = 31;
                        currentBytesToReceive = 624;
                    }
                }
                else 
                {
                    currentCommand = 30;
                    currentBytesToReceive = 170;
                }
            }
            else 
            {
                currentCommand = 30;
                currentBytesToReceive = 170;
            }
            service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBuffer(currentCommand), this);
            return;
        }

        public override function sendToDC(arg1:String):void
        {
            var loc3:*=null;
            var loc6:*=null;
            var loc4:*=null;
            var loc1:*=null;
            var loc2:*=null;
            var loc5:*=null;
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
                    if (arg1 != "deleteUnitlogData") 
                    {
                        if (arg1 == "writeGhostRace") 
                        {
                            if ((loc5 = decoder.Rox2010Decoder.getInstance().encodeGhostRace(ghostRaceLog)) == null) 
                            {
                                dispatchEvent(new flash.events.Event("sendGhostRaceComplete", false, false));
                            }
                            else 
                            {
                                currentCommand = 35;
                                currentBytesToReceive = 0;
                                service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBuffer(currentCommand, loc5), this, false, 256, 500);
                                _myUnit.addEventListener("isOnlineChange", onUnitOnlineChange);
                                _timer = new service.usb.USBSendTimer(600);
                                _timer.sentBytes = 20500;
                                _timer.addEventListener("timer", onDataSend);
                                _timer.start();
                            }
                        }
                    }
                    else 
                    {
                        currentCommand = 42;
                        currentBytesToReceive = 0;
                        service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBuffer(currentCommand), this);
                        loc2 = new flash.utils.Timer(1000, 1);
                        loc2.addEventListener("timerComplete", fakeDeleteLogsComplete);
                        loc2.start();
                    }
                }
                else if ((loc4 = decoder.Rox2010Decoder.getInstance().encodeUnitInformation(unit)) == null) 
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
                loc3 = decoder.Rox2010Decoder.getInstance().encodeSettings(_myUnit);
                currentCommand = 36;
                currentBytesToReceive = 0;
                service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBuffer(currentCommand, loc3), this);
                (loc6 = new flash.utils.Timer(1000, 1)).addEventListener("timerComplete", fakeSettingSend);
                loc6.start();
            }
            return;
        }

        internal function fakeDeleteLogsComplete(arg1:flash.events.TimerEvent):void
        {
            (arg1.target as flash.utils.Timer).removeEventListener("timerComplete", fakeDeleteLogsComplete);
            (arg1.target as flash.utils.Timer).stop();
            service.DeviceCommunicationHandler.getInstance().nativeProcessIsBusy = false;
            service.DeviceCommunicationHandler.getInstance().processNextCommandFromQueue();
            dispatchEvent(new flash.events.Event("logDeleteCompleteEvent", false, false));
            if (unit is core.units.interfaces.ILogList) 
            {
                (unit as core.units.interfaces.ILogList).loadedLogs = new __AS3__.vec.Vector.<core.activities.Activity>();
            }
            return;
        }

        internal function fakeSettingSend(arg1:flash.events.TimerEvent):void
        {
            (arg1.target as flash.utils.Timer).removeEventListener("timerComplete", fakeSettingSend);
            (arg1.target as flash.utils.Timer).stop();
            service.DeviceCommunicationHandler.getInstance().nativeProcessIsBusy = false;
            service.DeviceCommunicationHandler.getInstance().processNextCommandFromQueue();
            dispatchEvent(new flash.events.Event("settingsSendComplete", false, false));
            return;
        }

        internal function fakeWriteInitialInformationComplete(arg1:flash.events.TimerEvent):void
        {
            (arg1.target as flash.utils.Timer).removeEventListener("timerComplete", fakeWriteInitialInformationComplete);
            (arg1.target as flash.utils.Timer).stop();
            service.DeviceCommunicationHandler.getInstance().nativeProcessIsBusy = false;
            service.DeviceCommunicationHandler.getInstance().processNextCommandFromQueue();
            dispatchEvent(new flash.events.Event("writeUnitInformationComplete", false, false));
            return;
        }

        public static const DELETE_LOGS_COMMAND:uint=42;

        public static const GHOST_RACE_BYTES_TO_SEND:uint=20500;

        public static const LOAD_INITIALINFORMATION_BYTES_TO_RECEIVE:uint=16;

        public static const LOAD_INITIALINFORMATION_COMMAND:uint=70;

        public static const LOAD_LOG_DATA_COMMAND:uint=34;

        public static const LOAD_PAGE_HEADER_BYTES_TO_RECEIVE:uint=2;

        public static const LOAD_PAGE_HEADER_DATA_COMMAND:uint=33;

        public static const LOAD_SETTINGS_BYTES_TO_RECEIVE:uint=170;

        public static const LOAD_SETTINGS_COMMAND:uint=30;

        public static const LOAD_TRIPS_BYTES_TO_RECEIVE:uint=624;

        public static const LOAD_TRIP_DATA_COMMAND:uint=31;

        public static const ROX_COMMAND_VALUE:uint=255;

        public static const UNIT_CONNECTED_COMMAND:uint=114;

        public static const WRITE_GHOST_RACE_COMMAND:uint=35;

        public static const WRITE_INITIALINFORMATION_COMMAND:uint=96;

        public static const WRITE_SETTINGS_COMMAND:uint=36;

        internal var _ghostRaceLog:core.activities.Activity;

        internal var _myUnit:core.units.UnitROX2010;

        internal var _myUnitSettings:core.settings.SettingsROX2010;

        internal var _numberOfPages:int=-1;

        internal var _timer:service.usb.USBSendTimer;
    }
}


