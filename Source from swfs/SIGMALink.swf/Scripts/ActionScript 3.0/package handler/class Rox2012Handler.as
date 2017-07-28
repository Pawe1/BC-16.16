//class Rox2012Handler
package handler 
{
    import __AS3__.vec.*;
    import com.logging.*;
    import core.activities.*;
    import core.units.*;
    import core.units.interfaces.*;
    import debug.*;
    import decoder.*;
    import flash.events.*;
    import flash.utils.*;
    import handler.event.*;
    import service.*;
    import service.usb.event.*;
    
    public class Rox2012Handler extends handler.UnitHandler
    {
        public function Rox2012Handler()
        {
            loadedLoggingBytes = [];
            super();
            return;
        }

        public override function get unit():core.units.Unit
        {
            return this._myUnit;
        }

        public override function set unit(arg1:core.units.Unit):void
        {
            this._myUnit = arg1 as core.units.UnitROX2012;
            return;
        }

        internal function addToLoadedLogsIfNotEmpty(arg1:core.activities.Activity):void
        {
            if (arg1 != null) 
            {
                arg1.unit = _myUnit;
                arg1.statistic = true;
                arg1.serialNumber = _myUnit.serialNumber;
                arg1.importFromDevice = true;
                if (arg1.trainingTime > 0) 
                {
                    (_myUnit as core.units.interfaces.ILogList).loadedLogs.push(arg1);
                }
            }
            return;
        }

        internal function isMaximumPackageSizeAdress(arg1:Number):Boolean
        {
            var loc1:*=arg1 << 8 & 65280 | arg1 >> 8;
            return (loc1 - 166) % 768 == 0;
        }

        internal function readDataSuccess(arg1:Array):Boolean
        {
            var loc1:*=arg1[0];
            var loc3:*=arg1[1];
            var loc2:*=255 - loc1;
            if (loc3 == loc2 && loc1 == 0) 
            {
                _readErrorRepeats = 0;
                return true;
            }
            return false;
        }

        internal function repeatReadCommand(arg1:String):void
        {
            if (_readErrorRepeats < _repeatsOnError) 
            {
                ++_readErrorRepeats;
                service.DeviceCommunicationHandler.getInstance().addToCommandQueue(arg1, "loadCommand", this);
                service.DeviceCommunicationHandler.getInstance().processNextCommandFromQueue();
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingInfoEvent", 122, "RC2011Handler > read data error... repeat command - " + arg1));
            }
            else 
            {
                _readErrorRepeats = 0;
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 118, "RC2011Handler > onLoaded: usb service, read failed! - " + arg1));
                if (_myUnit != null) 
                {
                    if ((_myUnit as core.units.UnitROX2012).loadedLogs != null) 
                    {
                        (_myUnit as core.units.UnitROX2012).loadedLogs.length = 0;
                    }
                }
                service.DeviceCommunicationHandler.getInstance().processNextCommandFromQueue();
            }
            return;
        }

        public override function sendToDC(arg1:String):void
        {
            var loc1:*=null;
            if (service.DeviceCommunicationHandler.getInstance().nativeProcessIsBusy) 
            {
                service.DeviceCommunicationHandler.getInstance().addToCommandQueue(arg1, "sendCommand", this);
                return;
            }
            service.DeviceCommunicationHandler.getInstance().addEventListener("usbComplete", onLoaded, false, 0, false);
            if (arg1 != "writeTotalValues") 
            {
                if (arg1 != "writeUnitSettings") 
                {
                    if (arg1 != "deleteUnitMemoryData") 
                    {
                        debug.Debug.error("Unknown CommandType: " + arg1);
                        return;
                    }
                    else 
                    {
                        loc1 = [];
                        loc1[0] = 34;
                        currentCommand = 238;
                        currentStartAdrr = "1F00";
                        currentBytesToReceive = 0;
                        currentReceiveChecksumLength = 2;
                    }
                }
                else 
                {
                    loc1 = decoder.Rox2012Decoder.getInstance().encodeSettingInfos(_myUnit.currentSettings);
                    currentCommand = 238;
                    currentStartAdrr = "2000";
                    currentBytesToReceive = 0;
                    currentReceiveChecksumLength = 2;
                }
            }
            else 
            {
                loc1 = decoder.Rox2012Decoder.getInstance().encodeTotals(_myUnit.currentTotals);
                currentCommand = 238;
                currentStartAdrr = "4200";
                currentBytesToReceive = 0;
                currentReceiveChecksumLength = 2;
            }
            service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBuffer(currentCommand, currentStartAdrr, currentBytesToReceive, loc1), this);
            return;
        }

        protected function generateNativeProzessBuffer(arg1:uint, arg2:String, arg3:int=0, arg4:Array=null):flash.utils.ByteArray
        {
            var loc6:*=null;
            var loc4:*=null;
            var loc5:*=null;
            var loc7:*=null;
            var loc10:*=null;
            var loc1:*=null;
            var loc3:*=0;
            var loc2:*=0;
            var loc8:*;
            (loc8 = new flash.utils.ByteArray()).writeByte(arg1);
            var loc9:*=arg2.split("");
            if (arg4 != null) 
            {
                if (arg2 == "2000" || arg2 == "4200" || arg2 == "1F00") 
                {
                    loc8.writeByte(1);
                }
                else 
                {
                    loc8.writeByte(0);
                }
                if (loc9.length == 4) 
                {
                    loc6 = parseInt(loc9[0] + loc9[1], 16).toString();
                    loc4 = parseInt(loc9[2] + loc9[3], 16).toString();
                }
                loc8.writeByte(loc6);
                loc8.writeByte(loc4);
                loc8.writeByte(arg4.length);
                loc3 = 0;
                while (loc3 < arg4.length) 
                {
                    loc2 = arg4[loc3];
                    loc8.writeByte(loc2);
                    ++loc3;
                }
            }
            else 
            {
                if (loc9.length == 0) 
                {
                    return loc8;
                }
                if (loc9.length == 4) 
                {
                    loc6 = parseInt(loc9[0] + loc9[1], 16).toString();
                    loc4 = parseInt(loc9[2] + loc9[3], 16).toString();
                }
                loc8.writeByte(loc6);
                loc8.writeByte(loc4);
                loc10 = arg3.toString(16);
                while (loc10.length < 4) 
                {
                    loc10 = "0" + loc10;
                }
                loc1 = loc10.split("");
                loc5 = parseInt(loc1[2] + loc1[3], 16).toString();
                loc7 = parseInt(loc1[0] + loc1[1], 16).toString();
                loc8.writeByte(loc5);
                loc8.writeByte(loc7);
            }
            return loc8;
        }

        public override function toString():String
        {
            return "Rox2012Handler";
        }

        public override function destructor():void
        {
            super.destructor();
            service.DeviceCommunicationHandler.getInstance().removeEventListener("usbComplete", onLoaded, false);
            return;
        }

        public override function loadFromDC(arg1:String):void
        {
            var loc2:*=0;
            var loc3:*=0;
            var loc1:*=null;
            if (service.DeviceCommunicationHandler.getInstance().nativeProcessIsBusy) 
            {
                service.DeviceCommunicationHandler.getInstance().addToCommandQueue(arg1, "loadCommand", this);
                return;
            }
            service.DeviceCommunicationHandler.getInstance().addEventListener("usbComplete", onLoaded, false, 0, false);
            if (arg1 != "loadUnitlogDataHeader") 
            {
                if (arg1 != "loadBatteryInformation") 
                {
                    if (arg1 != "loadUnitSettings") 
                    {
                        if (arg1 != "loadTotalValues") 
                        {
                            if (arg1 != "loadUnitlogData") 
                            {
                                if (arg1 != "loadUnitlogDataNextPackage") 
                                {
                                    debug.Debug.error("unknown loadFromDC command");
                                    return;
                                }
                                else 
                                {
                                    currentCommand = 239;
                                    if (totalBytesToLoad - loadedLoggingBytes.length > 768) 
                                    {
                                        currentBytesToReceive = 768;
                                    }
                                    else 
                                    {
                                        currentBytesToReceive = totalBytesToLoad - loadedLoggingBytes.length;
                                    }
                                    currentReceiveChecksumLength = 2;
                                    loc1 = ((loc3 = 166 + loadedLoggingBytes.length) << 8 & 65535 | loc3 >> 8).toString(16);
                                    currentStartAdrr = loc1;
                                }
                            }
                            else 
                            {
                                loadedLoggingBytes = [];
                                currentCommand = 239;
                                loc2 = _myUnit.loadedLogs[0].stopAdress;
                                totalBytesToLoad = loc2 - 166 + 1;
                                if (totalBytesToLoad > 768) 
                                {
                                    currentBytesToReceive = 768;
                                }
                                else 
                                {
                                    currentBytesToReceive = totalBytesToLoad;
                                }
                                currentReceiveChecksumLength = 2;
                                currentStartAdrr = "A600";
                            }
                        }
                        else 
                        {
                            currentCommand = 239;
                            currentBytesToReceive = 40;
                            currentReceiveChecksumLength = 2;
                            currentStartAdrr = "4200";
                        }
                    }
                    else 
                    {
                        currentCommand = 239;
                        currentBytesToReceive = 34;
                        currentReceiveChecksumLength = 2;
                        currentStartAdrr = "2000";
                    }
                }
                else 
                {
                    currentCommand = 239;
                    currentBytesToReceive = 7;
                    currentReceiveChecksumLength = 2;
                    currentStartAdrr = "6A00";
                }
            }
            else 
            {
                currentCommand = 239;
                currentBytesToReceive = 53;
                currentReceiveChecksumLength = 2;
                currentStartAdrr = "7100";
            }
            service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBuffer(currentCommand, currentStartAdrr, currentBytesToReceive, null), this);
            return;
        }

        internal function onLoaded(arg1:service.usb.event.DeviceDataCompleteEvent):void
        {
            var loc3:*=null;
            var loc1:*=null;
            var loc2:*=null;
            service.DeviceCommunicationHandler.getInstance().removeEventListener("usbComplete", onLoaded, false);
            if (arg1.command != 239.toString()) 
            {
                if (arg1.command != 238.toString()) 
                {
                    debug.Debug.error("Unknown onLoaded command \'" + arg1.command + "\'\t\tstartAdress \'" + arg1.startAdress + "\'");
                }
                else if (arg1.startAdress != "4200") 
                {
                    if (arg1.startAdress != "2000") 
                    {
                        if (arg1.startAdress != "1F00") 
                        {
                            debug.Debug.error("Unknown start adress for setData: " + arg1.startAdress);
                        }
                        else if (readDataSuccess([arg1.data[arg1.data.length - 2], arg1.data[(arg1.data.length - 1)]])) 
                        {
                            dataDeleted = true;
                            _myUnit.loadedLogs = new __AS3__.vec.Vector.<core.activities.Activity>();
                            dispatchEvent(new flash.events.Event("logDeleteCompleteEvent", false, false));
                            if (unit is core.units.interfaces.ILogList) 
                            {
                                (unit as core.units.interfaces.ILogList).loadedLogs = new __AS3__.vec.Vector.<core.activities.Activity>();
                            }
                        }
                    }
                    else if (readDataSuccess([arg1.data[arg1.data.length - 2], arg1.data[(arg1.data.length - 1)]])) 
                    {
                        dispatchEvent(new flash.events.Event("settingsSendComplete", false, false));
                    }
                }
                else if (readDataSuccess([arg1.data[arg1.data.length - 2], arg1.data[(arg1.data.length - 1)]])) 
                {
                    dispatchEvent(new flash.events.Event("sendTotalValuesComplete", false, false));
                }
            }
            else if (arg1.startAdress != "7100") 
            {
                if (arg1.startAdress != "6A00") 
                {
                    if (arg1.startAdress != "2000") 
                    {
                        if (arg1.startAdress != "4200") 
                        {
                            if (arg1.startAdress == "A600" || isMaximumPackageSizeAdress(parseInt("0x" + arg1.startAdress, 16))) 
                            {
                                if (readDataSuccess([arg1.data[arg1.data.length - 2], arg1.data[(arg1.data.length - 1)]])) 
                                {
                                    loadedLoggingBytes = loadedLoggingBytes.concat(arg1.data.slice(0, arg1.data.length - currentReceiveChecksumLength));
                                    if (loadedLoggingBytes.length != totalBytesToLoad) 
                                    {
                                        dispatchEvent(new handler.event.ProgressStatusEvent("progressbarEvent", loadedLoggingBytes.length / totalBytesToLoad * 100, 1, 1, "", false, false));
                                        flash.utils.setTimeout(loadFromDC, 100, "loadUnitlogDataNextPackage");
                                        return;
                                    }
                                    else 
                                    {
                                        if ((_myUnit.loadedLogs[0] as core.activities.Activity).importFromDevice) 
                                        {
                                            (_myUnit.loadedLogs[0] as core.activities.Activity).entries.length = 0;
                                            decoder.Rox2012Decoder.getInstance().decodeLog(_myUnit.loadedLogs[0], loadedLoggingBytes);
                                        }
                                        if (_myUnit.loadedLogs.length == 2 && (_myUnit.loadedLogs[1] as core.activities.Activity).importFromDevice) 
                                        {
                                            (_myUnit.loadedLogs[1] as core.activities.Activity).entries.length = 0;
                                            decoder.Rox2012Decoder.getInstance().decodeLog(_myUnit.loadedLogs[1], loadedLoggingBytes);
                                        }
                                        dispatchEvent(new handler.event.ProgressStatusEvent("progressbarEvent", 100, 1, 1, "", false, false));
                                        dispatchEvent(new flash.events.Event("logsLoadedFromUnitComplete", false, false));
                                    }
                                }
                                else 
                                {
                                    if (loadedLoggingBytes.length == 0) 
                                    {
                                        repeatReadCommand("loadUnitlogData");
                                    }
                                    else 
                                    {
                                        repeatReadCommand("loadUnitlogDataNextPackage");
                                    }
                                    return;
                                }
                            }
                            else 
                            {
                                debug.Debug.error("Unknown start adress for getData: " + arg1.startAdress);
                            }
                        }
                        else if (readDataSuccess([arg1.data[arg1.data.length - 2], arg1.data[(arg1.data.length - 1)]])) 
                        {
                            loc3 = arg1.data.slice(0, 40);
                            _myUnit.currentTotals = decoder.Rox2012Decoder.getInstance().decodeTotals(loc3, _myUnit);
                            _myUnit.currentTotals.unit = _myUnit;
                            dispatchEvent(new flash.events.Event("totalsLoadComplete", false, false));
                        }
                        else 
                        {
                            repeatReadCommand("loadTotalValues");
                            return;
                        }
                    }
                    else if (readDataSuccess([arg1.data[arg1.data.length - 2], arg1.data[(arg1.data.length - 1)]])) 
                    {
                        loc3 = arg1.data.slice(0, 34);
                        _myUnit.currentSettings = decoder.Rox2012Decoder.getInstance().decodeSettings(loc3, _myUnit);
                        _myUnit.currentSettings.unit = _myUnit;
                        dispatchEvent(new flash.events.Event("settingsLoadedFromUnitComplete", false, false));
                    }
                    else 
                    {
                        repeatReadCommand("loadUnitSettings");
                        return;
                    }
                }
                else if (readDataSuccess([arg1.data[arg1.data.length - 2], arg1.data[(arg1.data.length - 1)]])) 
                {
                    loc3 = arg1.data.slice(0, 7);
                    decoder.Rox2012Decoder.getInstance().decodeBatteryInformation(_myUnit, loc3);
                    dispatchEvent(new flash.events.Event("batteryInformationLoadedFromUnitComplete", false, false));
                }
                else 
                {
                    repeatReadCommand("loadBatteryInformation");
                    return;
                }
            }
            else if (readDataSuccess([arg1.data[arg1.data.length - 2], arg1.data[(arg1.data.length - 1)]])) 
            {
                loc3 = arg1.data.slice(0, 53);
                (_myUnit as core.units.interfaces.ILogList).loadedLogs = new __AS3__.vec.Vector.<core.activities.Activity>();
                if (!dataDeleted) 
                {
                    loc1 = decoder.Rox2012Decoder.getInstance().decodePageHeaderInformationPulse(loc3, _myUnit);
                }
                addToLoadedLogsIfNotEmpty(loc1);
                if (!dataDeleted) 
                {
                    loc2 = decoder.Rox2012Decoder.getInstance().decodePageHeaderInformationCycling(loc3, _myUnit);
                }
                addToLoadedLogsIfNotEmpty(loc2);
                dataDeleted = false;
                dispatchEvent(new flash.events.Event("pageHeaderChange", false, false));
            }
            else 
            {
                repeatReadCommand("loadUnitlogDataHeader");
                return;
            }
            service.DeviceCommunicationHandler.getInstance().processNextCommandFromQueue();
            return;
        }

        public static const SETTING_INFO_NORMAL_POWERMODE_STARTADDRESS:String="1F00";

        public static const SETTING_INFO_NORMAL_POWERMODE_TO_RECEIVE:uint=1;

        public static const SETTING_INFO_NORMAL_STARTADDRESS:String="2000";

        public static const SETTING_INFO_NORMAL_STOPADDRESS:String="4100";

        public static const SETTING_INFO_TOTALS_STARTADDRESS:String="4200";

        public static const SETTING_INFO_TOTALS_STOPADDRESS:String="6900";

        public static const SET_DATA_BY_ADDR:uint=238;

        public static const BATT_INFO_STARTADDRESS:String="6A00";

        public static const BATT_INFO_STOPADDRESS:String="7000";

        public static const GET_BATT_INFO_BYTES_TO_RECEIVE:uint=7;

        public static const GET_DATA_BY_ADDR:uint=239;

        public static const GET_LOGGING_DATA_TOTALS_BYTES_TO_RECEIVE:uint=65370;

        public static const GET_PAGE_HEADER_ADDR_LIST_BYTES_TO_RECEIVE:uint=53;

        public static const GET_SETTING_INFO_NORMAL_BYTES_TO_RECEIVE:uint=34;

        public static const GET_SETTING_INFO_TOTALS_BYTES_TO_RECEIVE:uint=40;

        public static const LOAD_UNIT_LOG_DATA_NEXT_PACKAGE_FROM_DEVICE:String="loadUnitlogDataNextPackage";

        public static const LOGGING_DATA_MAX_PACKAGESIZE:int=768;

        public static const LOGGING_DATA_STARTADDRESS:String="A600";

        public static const LOGGING_DATA_STOPADDRESS:String="FFFF";

        public static const PAGE_HEADER_STARTADDRESS:String="7100";

        public static const PAGE_HEADER_STOPADDRESS:String="A500";

        internal var _myUnit:core.units.UnitROX2012;

        internal var _readErrorRepeats:int=0;

        internal var _repeatsOnError:int=1;

        internal var _writeErrorRepeats:int=0;

        internal var dataDeleted:Boolean=false;

        internal var loadedLoggingBytes:Array;

        internal var totalBytesToLoad:int=0;
    }
}


