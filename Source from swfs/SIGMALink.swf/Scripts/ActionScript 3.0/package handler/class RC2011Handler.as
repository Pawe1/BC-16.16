//class RC2011Handler
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
    
    public class RC2011Handler extends handler.UnitHandler
    {
        public function RC2011Handler()
        {
            super();
            return;
        }

        internal function writeDataSuccess(arg1:Array):Boolean
        {
            var loc1:*=arg1[0];
            var loc3:*=arg1[1];
            var loc2:*=255 - loc1;
            if (loc3 == loc2 && loc1 == 0) 
            {
                _writeErrorRepeats = 0;
                return true;
            }
            return false;
        }

        public function set pageHeaderAddrList(arg1:Object):void
        {
            _pageHeaderAddrList = arg1;
            return;
        }

        public override function get unit():core.units.Unit
        {
            return _myUnit;
        }

        public override function set unit(arg1:core.units.Unit):void
        {
            _myUnit = arg1 as core.units.UnitRC2011;
            return;
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

        internal function encodeCommand(arg1:int):String
        {
            var loc1:*=(255 - arg1).toString(16);
            if (loc1.length == 1) 
            {
                loc1 = "0" + loc1;
            }
            return arg1.toString(16) + loc1;
        }

        public override function toString():String
        {
            return "RC2011Handler extends UnitHandler";
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
                    if ((_myUnit as core.units.UnitRC1411).loadedLogs != null) 
                    {
                        (_myUnit as core.units.UnitRC1411).loadedLogs.length = 0;
                    }
                }
                _pageHeaderAddrList = null;
                service.DeviceCommunicationHandler.getInstance().processNextCommandFromQueue();
            }
            return;
        }

        internal function repeatWriteCommand(arg1:String):void
        {
            if (_writeErrorRepeats < _repeatsOnError) 
            {
                ++_writeErrorRepeats;
                service.DeviceCommunicationHandler.getInstance().addToCommandQueue(arg1, "sendCommand", this);
                service.DeviceCommunicationHandler.getInstance().processNextCommandFromQueue();
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingInfoEvent", 121, "RC2011Handler > write data error... repeat command - " + arg1));
                return;
            }
            _writeErrorRepeats = 0;
            dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 108, "RC2011Handler > onSent: write data error, checksum incorrect - " + arg1));
            service.DeviceCommunicationHandler.getInstance().processNextCommandFromQueue();
            return;
        }

        protected function generateNativeProzessBuffer(arg1:uint, arg2:String, arg3:int=0, arg4:Array=null):flash.utils.ByteArray
        {
            var loc7:*=null;
            var loc5:*=null;
            var loc4:*=null;
            var loc6:*=null;
            var loc9:*=null;
            var loc8:*=null;
            var loc12:*=null;
            var loc1:*=null;
            var loc13:*=null;
            var loc3:*=0;
            var loc2:*=0;
            var loc10:*;
            (loc10 = new flash.utils.ByteArray()).writeByte(arg1);
            loc10.writeByte(255 - arg1);
            var loc11:*=arg2.split("");
            if (arg4 != null) 
            {
                if (arg2 == "50FF00" || arg2 == "70FF00") 
                {
                    loc10.writeByte(1);
                }
                else 
                {
                    loc10.writeByte(0);
                }
                if (loc11.length == 6) 
                {
                    loc7 = parseInt(loc11[0] + loc11[1], 16).toString();
                    loc5 = parseInt(loc11[2] + loc11[3], 16).toString();
                    loc4 = parseInt(loc11[4] + loc11[5], 16).toString();
                }
                loc10.writeByte(loc7);
                loc10.writeByte(loc5);
                loc10.writeByte(loc4);
                loc13 = arg4.length.toString(16);
                while (loc13.length < 6) 
                {
                    loc13 = "0" + loc13;
                }
                loc10.writeByte(arg4.length);
                loc3 = 0;
                while (loc3 < arg4.length) 
                {
                    loc2 = arg4[loc3];
                    loc10.writeByte(loc2);
                    ++loc3;
                }
            }
            else 
            {
                if (loc11.length == 0) 
                {
                    return loc10;
                }
                if (loc11.length == 6) 
                {
                    loc7 = parseInt(loc11[0] + loc11[1], 16).toString();
                    loc5 = parseInt(loc11[2] + loc11[3], 16).toString();
                    loc4 = parseInt(loc11[4] + loc11[5], 16).toString();
                }
                loc10.writeByte(loc7);
                loc10.writeByte(loc5);
                loc10.writeByte(loc4);
                loc12 = arg3.toString(16);
                while (loc12.length < 6) 
                {
                    loc12 = "0" + loc12;
                }
                loc1 = loc12.split("");
                loc6 = parseInt(loc1[4] + loc1[5], 16).toString();
                loc9 = parseInt(loc1[2] + loc1[3], 16).toString();
                loc8 = parseInt(loc1[0] + loc1[1], 16).toString();
                loc10.writeByte(loc6);
                loc10.writeByte(loc9);
                loc10.writeByte(loc8);
            }
            return loc10;
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
            if (arg1 != "writeUnitSettings") 
            {
                if (arg1 != "writeTotalValues") 
                {
                    if (arg1 != "deleteUnitlogData") 
                    {
                        if (arg1 != "writeUnitInformation") 
                        {
                        };
                    }
                    else 
                    {
                        currentCommand = 231;
                        currentBytesToReceive = 2;
                        currentReceiveChecksumLength = 0;
                        currentStartAdrr = "30FF00";
                        loc1 = decoder.RC2011Decoder.getInstance().encodePageHeaderAddrList(unit);
                        service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBuffer(currentCommand, currentStartAdrr, currentBytesToReceive, loc1), this);
                    }
                }
                else 
                {
                    loc1 = decoder.RC2011Decoder.getInstance().encodeTotals((unit as core.units.interfaces.ITotalsList).currentTotals);
                    currentCommand = 231;
                    currentBytesToReceive = 2;
                    currentReceiveChecksumLength = 0;
                    currentStartAdrr = "70FF00";
                    service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBuffer(currentCommand, currentStartAdrr, currentBytesToReceive, loc1), this);
                }
            }
            else 
            {
                loc1 = decoder.RC2011Decoder.getInstance().encodeSettings(unit);
                currentCommand = 231;
                currentBytesToReceive = 2;
                currentReceiveChecksumLength = 0;
                currentStartAdrr = "50FF00";
                service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBuffer(currentCommand, currentStartAdrr, currentBytesToReceive, loc1), this);
            }
            return;
        }

        public override function destructor():void
        {
            super.destructor();
            pageHeaderAddrList = null;
            service.DeviceCommunicationHandler.getInstance().removeEventListener("usbComplete", onLoaded);
            decoder.RC2011Decoder.getInstance().removeEventListener("openTrainingFound", onOpenTrainingFound);
            return;
        }

        internal function onLoaded(arg1:service.usb.event.DeviceDataCompleteEvent):void
        {
            var loc11:*=null;
            var loc10:*=null;
            var loc6:*=0;
            var loc3:*=0;
            var loc7:*=null;
            var loc4:*=null;
            var loc1:*=0;
            var loc12:*=null;
            var loc8:*=0;
            var loc5:*=0;
            var loc9:*=0;
            var loc2:*=null;
            service.DeviceCommunicationHandler.getInstance().removeEventListener("usbComplete", onLoaded, false);
            if (arg1.command == 231.toString() && arg1.startAdress == "50FF00") 
            {
                if (!writeDataSuccess(arg1.data)) 
                {
                    repeatWriteCommand("writeUnitSettings");
                    return;
                }
                dispatchEvent(new flash.events.Event("settingsSendComplete", false, false));
            }
            else if (arg1.command == 231.toString() && arg1.startAdress == "70FF00") 
            {
                if (!writeDataSuccess(arg1.data)) 
                {
                    repeatWriteCommand("writeTotalValues");
                    return;
                }
                dispatchEvent(new flash.events.Event("sendTotalValuesComplete", false, false));
            }
            else if (!(arg1.command == 231.toString() && arg1.startAdress == "E0FF00")) 
            {
                if (arg1.command == 231.toString() && arg1.startAdress == "30FF00") 
                {
                    pageHeaderAddrList = null;
                    dispatchEvent(new flash.events.Event("logDeleteCompleteEvent", false, false));
                    if (unit is core.units.interfaces.ILogList) 
                    {
                        (unit as core.units.interfaces.ILogList).loadedLogs = new __AS3__.vec.Vector.<core.activities.Activity>();
                    }
                }
                else if (arg1.startAdress != "70FF00") 
                {
                    if (arg1.startAdress != "50FF00") 
                    {
                        if (arg1.startAdress != "86FF00") 
                        {
                            if (arg1.startAdress != "36FF00") 
                            {
                                if (arg1.startAdress != "30FF00") 
                                {
                                    if (arg1.startAdress != getPageHeaderStartAddress()) 
                                    {
                                        if (arg1.startAdress == "000000" || arg1.startAdress == "010000") 
                                        {
                                            if (!(_pageHeaderAddrList == null) || !((_myUnit as core.units.UnitRC1411).loadedLogs == null)) 
                                            {
                                                if (readDataSuccess([arg1.data[arg1.data.length - 2], arg1.data[(arg1.data.length - 1)]])) 
                                                {
                                                    loc1 = 0;
                                                    while (loc1 < (_myUnit as core.units.UnitRC1411).loadedLogs.length) 
                                                    {
                                                        if ((loc12 = (_myUnit as core.units.UnitRC1411).loadedLogs[loc1] as core.activities.Activity) != null) 
                                                        {
                                                            if (arg1.data.length > loc12.startAdress) 
                                                            {
                                                                loc8 = getLogDecodingStartAddress();
                                                                loc5 = loc12.startAdress - loc8;
                                                                loc9 = loc12.stopAdress - loc8;
                                                                loc2 = arg1.data.slice(loc5, loc9 + 1);
                                                                core.activities.ActivityFactory.applyZoneValues(loc12, true, false);
                                                                loc12 = decoder.RC2011Decoder.getInstance().decodeLog(loc12, loc2) as core.activities.Activity;
                                                            }
                                                        }
                                                        ++loc1;
                                                    }
                                                }
                                                else 
                                                {
                                                    repeatReadCommand("loadUnitlogData");
                                                    return;
                                                }
                                            }
                                            dispatchEvent(new flash.events.Event("logsLoadedFromUnitComplete"));
                                        }
                                    }
                                    else 
                                    {
                                        if (readDataSuccess([arg1.data[arg1.data.length - 2], arg1.data[(arg1.data.length - 1)]])) 
                                        {
                                            decoder.RC2011Decoder.getInstance().addEventListener("openTrainingFound", onOpenTrainingFound);
                                            loc10 = new Array(_pageHeaderAddrList.numberOfPages);
                                            (_myUnit as core.units.UnitRC1411).loadedLogs = new __AS3__.vec.Vector.<core.activities.Activity>();
                                            loc6 = 0;
                                            while (loc6 < _pageHeaderAddrList.numberOfPages) 
                                            {
                                                loc3 = loc6 * _pageHeaderSize;
                                                loc7 = arg1.data.slice(loc3, loc3 + _pageHeaderSize);
                                                if ((loc4 = decoder.RC2011Decoder.getInstance().decodePageHeaderInformation(loc7, _myUnit)) != null) 
                                                {
                                                    loc4.statistic = true;
                                                    if (loc4.startAdress < loc4.stopAdress) 
                                                    {
                                                        loc4.unit = _myUnit;
                                                        (_myUnit as core.units.UnitRC1411).loadedLogs.push(loc4);
                                                    }
                                                }
                                                ++loc6;
                                            }
                                        }
                                        else 
                                        {
                                            repeatReadCommand("loadUnitlogDataHeader");
                                            return;
                                        }
                                        dispatchEvent(new flash.events.Event("pageHeaderChange", false, false));
                                        decoder.RC2011Decoder.getInstance().removeEventListener("openTrainingFound", onOpenTrainingFound);
                                        if (_openTrainingFound) 
                                        {
                                            dispatchEvent(new flash.events.Event("openTrainingFound"));
                                            _openTrainingFound = false;
                                        }
                                    }
                                }
                                else 
                                {
                                    if (readDataSuccess([arg1.data[arg1.data.length - 2], arg1.data[(arg1.data.length - 1)]])) 
                                    {
                                        _pageHeaderAddrList = decoder.RC2011Decoder.getInstance().decodeListOfAdressOfPageHeader(arg1.data, _myUnit);
                                    }
                                    else 
                                    {
                                        repeatReadCommand("loadUnitlogDataHeader");
                                        return;
                                    }
                                    if (_pageHeaderAddrList.numberOfPages != 0) 
                                    {
                                        service.DeviceCommunicationHandler.getInstance().addEventListener("usbComplete", onLoaded, false, 0, false);
                                        service.DeviceCommunicationHandler.getInstance().addToCommandQueue("loadUnitlogDataHeader", "loadCommand", this);
                                        service.DeviceCommunicationHandler.getInstance().processNextCommandFromQueue();
                                        return;
                                    }
                                    else 
                                    {
                                        _pageHeaderAddrList = null;
                                        if (_myUnit != null) 
                                        {
                                            (_myUnit as core.units.UnitRC1411).loadedLogs = new __AS3__.vec.Vector.<core.activities.Activity>();
                                        }
                                        dispatchEvent(new flash.events.Event("pageHeaderChange", false, false));
                                    }
                                }
                            }
                            else if (readDataSuccess([arg1.data[arg1.data.length - 2], arg1.data[(arg1.data.length - 1)]])) 
                            {
                                decoder.RC2011Decoder.getInstance().decodeFreeLoggingTime(arg1.data, _myUnit);
                            }
                            else 
                            {
                                repeatReadCommand("loadFreeLoggingTimeInformation");
                                return;
                            }
                        }
                        else 
                        {
                            if (readDataSuccess([arg1.data[arg1.data.length - 2], arg1.data[(arg1.data.length - 1)]])) 
                            {
                                decoder.RC2011Decoder.getInstance().decodeBatteryInformation(arg1.data, _myUnit);
                            }
                            else 
                            {
                                repeatReadCommand("loadBatteryInformation");
                                return;
                            }
                            dispatchEvent(new flash.events.Event("batteryInformationLoadedFromUnitComplete", false, false));
                        }
                    }
                    else 
                    {
                        if (readDataSuccess([arg1.data[arg1.data.length - 2], arg1.data[(arg1.data.length - 1)]])) 
                        {
                            loc11 = arg1.data.slice(0, 30);
                            _myUnit.currentSettings = decoder.RC2011Decoder.getInstance().decodeSettings(loc11, _myUnit);
                            loc11 = arg1.data.slice(32, 32 + 18);
                            _myUnit.currentTotals = decoder.RC2011Decoder.getInstance().decodeTotals(loc11, _myUnit);
                        }
                        else 
                        {
                            repeatReadCommand("loadUnitSettings");
                            return;
                        }
                        dispatchEvent(new flash.events.Event("settingsLoadedFromUnitComplete"));
                    }
                }
                else if (readDataSuccess([arg1.data[arg1.data.length - 2], arg1.data[(arg1.data.length - 1)]])) 
                {
                    _myUnit.currentTotals = decoder.RC2011Decoder.getInstance().decodeTotals(arg1.data, _myUnit);
                    dispatchEvent(new flash.events.Event("totalsLoadComplete"));
                }
                else 
                {
                    repeatReadCommand("loadTotalValues");
                    return;
                }
            }
            service.DeviceCommunicationHandler.getInstance().processNextCommandFromQueue();
            return;
        }

        internal function onOpenTrainingFound(arg1:flash.events.Event):void
        {
            decoder.RC2011Decoder.getInstance().removeEventListener("openTrainingFound", onOpenTrainingFound);
            _openTrainingFound = true;
            return;
        }

        public override function loadFromDC(arg1:String):void
        {
            var loc2:*=undefined;
            var loc6:*=NaN;
            var loc3:*=0;
            var loc4:*=0;
            var loc1:*=null;
            var loc5:*=0;
            if (service.DeviceCommunicationHandler.getInstance().nativeProcessIsBusy) 
            {
                service.DeviceCommunicationHandler.getInstance().addToCommandQueue(arg1, "loadCommand", this);
                return;
            }
            service.DeviceCommunicationHandler.getInstance().addEventListener("usbComplete", onLoaded, false, 0, false);
            if (arg1 != "loadTotalValues") 
            {
                if (arg1 != "loadUnitSettings") 
                {
                    if (arg1 != "loadBatteryInformation") 
                    {
                        if (arg1 != "loadUnitlogDataHeader") 
                        {
                            if (arg1 != "loadUnitlogData") 
                            {
                                if (arg1 == "loadFreeLoggingTimeInformation") 
                                {
                                    currentCommand = 232;
                                    currentBytesToReceive = 8;
                                    currentReceiveChecksumLength = 2;
                                    currentStartAdrr = "36FF00";
                                }
                            }
                            else 
                            {
                                loc2 = (_myUnit as core.units.UnitRC1411).loadedLogs;
                                loc6 = 0;
                                loc3 = 99;
                                loc4 = 0;
                                while (loc4 < loc2.length) 
                                {
                                    loc1 = loc2[loc4];
                                    loc6 = loc6 + (loc1.stopAdress - loc1.startAdress + 1);
                                    loc3 = Math.min(loc3, loc1.startAdress);
                                    ++loc4;
                                }
                                loc5 = loc2[(loc2.length - 1)].stopAdress;
                                currentCommand = 232;
                                currentBytesToReceive = loc6;
                                currentReceiveChecksumLength = 2;
                                if (loc3 != 1) 
                                {
                                    currentStartAdrr = "000000";
                                }
                                else 
                                {
                                    currentStartAdrr = "010000";
                                }
                            }
                        }
                        else if (_pageHeaderAddrList != null) 
                        {
                            currentCommand = 232;
                            currentBytesToReceive = _pageHeaderAddrList.numberOfPages * _pageHeaderSize;
                            currentReceiveChecksumLength = 2;
                            currentStartAdrr = getPageHeaderStartAddress();
                        }
                        else 
                        {
                            currentCommand = 232;
                            currentBytesToReceive = 19;
                            currentReceiveChecksumLength = 2;
                            currentStartAdrr = "30FF00";
                        }
                    }
                    else 
                    {
                        currentCommand = 232;
                        currentBytesToReceive = 14;
                        currentReceiveChecksumLength = 2;
                        currentStartAdrr = "86FF00";
                    }
                }
                else 
                {
                    currentCommand = 232;
                    currentBytesToReceive = 55;
                    currentReceiveChecksumLength = 2;
                    currentStartAdrr = "50FF00";
                }
            }
            else 
            {
                currentCommand = 232;
                currentBytesToReceive = 18;
                currentReceiveChecksumLength = 2;
                currentStartAdrr = "70FF00";
            }
            service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBuffer(currentCommand, currentStartAdrr, currentBytesToReceive, null), this);
            return;
        }

        internal function getPageHeaderStartAddress():String
        {
            if (_pageHeaderAddrList == null) 
            {
                return "";
            }
            var loc1:*=65327 - _pageHeaderAddrList.numberOfPages * _pageHeaderSize + 1;
            var loc3:*="00" + loc1.toString(16);
            var loc2:*=loc3.split("");
            var loc4:*;
            return loc4 = loc2[4] + loc2[5] + loc2[2] + loc2[3] + loc2[0] + loc2[1];
        }

        internal function getLogDecodingStartAddress():uint
        {
            var loc2:*=0;
            var loc4:*=0;
            var loc1:*=(_myUnit as core.units.UnitRC1411).loadedLogs;
            var loc3:*=0;
            loc2 = 0;
            while (loc2 < loc1.length) 
            {
                loc4 = loc1[loc2].startAdress;
                if (loc2 != 0) 
                {
                    if (loc4 < loc3) 
                    {
                        loc3 = loc4;
                    }
                }
                else 
                {
                    loc3 = loc4;
                }
                ++loc2;
            }
            return loc3;
        }

        internal function decodeCommand(arg1:String):int
        {
            var loc1:*=parseInt(arg1, 16);
            var loc2:*=loc1 & 255;
            var loc3:*;
            return loc3 = 255 - loc2;
        }

        public static const SN_INFO_ENDADDRESS:String="EFFF00";

        public static const SN_INFO_STARTADDRESS:String="E0FF00";

        public static const SN_INFO_TOTAL_SIZE:uint=16;

        public static const TOTAL_VALUE_ENDADDRESS:String="85FF00";

        public static const TOTAL_VALUE_STARTADDRESS:String="70FF00";

        public static const TOTAL_VALUE_TOTAL_SIZE:uint=27;

        public static const UNIT_CONNECTED_COMMAND:uint=255;

        public static const UNIT_CONNECTED_COMMAND_BYTES_TO_RECEIVE:uint=1;

        public static const ALL_PAGE_HEADERS_STARTADDRESS:uint=65327;

        public static const BACKUP_SN_INFO_ENDADDRESS:String="DFFF00";

        public static const BACKUP_SN_INFO_STARTADDRESS:String="D0FF00";

        public static const BATT_INFO_STARTADDRESS:String="86FF00";

        public static const BATT_INFO_STOPADDRESS:String="9FFF00";

        public static const DELETE_LOGS_BYTES_TO_RECEIVE:uint=2;

        public static const DELETE_LOGS_COMMAND:uint=231;

        public static const DELETE_LOGS_ENDADDRESS:String="42FF00";

        public static const DELETE_LOGS_STARTADDRESS:String="30FF00";

        public static const FREE_LOGGING_TIME_ENDADDRESS:String="3DFF00";

        public static const FREE_LOGGING_TIME_STARTADDRESS:String="36FF00";

        public static const GET_ALL_PAGE_HEADERS:uint=232;

        public static const GET_BACKUP_SN_INFO:uint=232;

        public static const GET_BACKUP_SN_INFO_BYTES_TO_RECEIVE:uint=12;

        public static const GET_BATT_INFO:uint=232;

        public static const GET_BATT_INFO_BYTES_TO_RECEIVE:uint=14;

        public static const GET_FREE_LOGGING_TIME:uint=232;

        public static const GET_FREE_LOGGING_TIME_BYTES_TO_RECEIVE:uint=8;

        public static const GET_INITIAL_AND_SN_INFO:uint=232;

        public static const GET_INITIAL_AND_SN_INFO_BYTES_TO_RECEIVE:uint=24;

        public static const GET_INITIAL_INFO:uint=232;

        public static const GET_INITIAL_INFO_BYTES_TO_RECEIVE:uint=8;

        public static const GET_LOG_DATA:uint=232;

        public static const GET_NORMAL_SETTING:uint=232;

        public static const GET_NORMAL_SETTING_BYTES_TO_RECEIVE:uint=30;

        public static const GET_NORMAL_SETTING_WITH_TOTAL:uint=232;

        public static const GET_NORMAL_SETTING_WITH_TOTAL_BYTES_TO_RECEIVE:uint=55;

        public static const GET_PAGE_HEADER_ADDR_LIST:uint=232;

        public static const GET_PAGE_HEADER_ADDR_LIST_BYTES_TO_RECEIVE:uint=19;

        public static const GET_SN_INFO:uint=232;

        public static const GET_SN_INFO_BYTES_TO_RECEIVE:uint=12;

        public static const GET_TOTAL_VALUE:uint=232;

        public static const GET_TOTAL_VALUE_BYTES_TO_RECEIVE:uint=18;

        public static const INITIAL_AND_SN_INFO_ENDADDRESS:String="FFFF00";

        public static const INITIAL_AND_SN_INFO_STARTADDRESS:String="E0FF00";

        public static const INITIAL_INFO_ENDADDRESS:String="FFFF00";

        public static const INITIAL_INFO_STARTADDRESS:String="F0FF00";

        public static const INITIAL_INFO_TOTAL_SIZE:uint=16;

        public static const LOG_DATA_STARTADDRESS:String="000000";

        public static const LOG_DATA_STARTADDRESS_ALTERNATIVE:String="010000";

        public static const NORMAL_SETTING_ENDADDRESS:String="6FFF00";

        public static const NORMAL_SETTING_STARTADDRESS:String="50FF00";

        public static const NORMAL_SETTING_TOTAL_SIZE:uint=32;

        public static const NORMAL_SETTING_WITH_TOTAL_ENDADDRESS:String="85FF00";

        public static const NORMAL_SETTING_WITH_TOTAL_STARTADDRESS:String="50FF00";

        public static const PAGE_HEADER_STARTADDRESS:String="30FF00";

        public static const PAGE_HEADER_STOPADDRESS:String="4FFF00";

        public static const SET_BACKUP_SN_INFO:uint=231;

        public static const SET_BATT_INFO:uint=231;

        public static const SET_INITIAL_INFO:uint=231;

        public static const SET_NORMAL_SETTING:uint=231;

        public static const SET_NORMAL_SETTING_BYTES_TO_RECEIVE:uint=2;

        public static const SET_PAGE_HEADER_ADDR_LIST:uint=231;

        public static const SET_SN_INFO:uint=231;

        public static const SET_SN_INFO_BYTES_TO_RECEIVE:uint=2;

        public static const SET_TOTAL_VALUE:uint=231;

        public static const SET_TOTAL_VALUE_BYTES_TO_RESEIVE:uint=2;

        internal var _pageHeaderAddrList:Object;

        internal var _myUnit:core.units.UnitRC2011;

        internal var _myUnitSettings:core.settings.SettingsRunningComputer;

        internal var _openTrainingFound:Boolean=false;

        internal var _pageHeaderSize:uint=48;

        internal var _readErrorRepeats:int=0;

        internal var _repeatsOnError:int=1;

        internal var _writeErrorRepeats:int=0;
    }
}


