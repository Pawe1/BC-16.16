//class Topline2016Handler
package handler 
{
    import __AS3__.vec.*;
    import com.logging.*;
    import core.activities.*;
    import core.settings.*;
    import core.units.*;
    import core.units.interfaces.*;
    import debug.*;
    import decoder.*;
    import flash.events.*;
    import flash.utils.*;
    import handler.event.*;
    import handler.interfaces.*;
    import service.*;
    import service.event.*;
    import service.nfc.*;
    import service.usb.*;
    import service.usb.event.*;
    import utils.*;
    
    public class Topline2016Handler extends handler.UnitHandler implements handler.interfaces.IGhostRaceLog, handler.interfaces.IHandlerNfc, handler.interfaces.IHandlerDockingStation
    {
        public function Topline2016Handler()
        {
            debug.Debug.debug("CREATE NEW Topline2016Handler()");
            super();
            return;
        }

        public function disposeDs():void
        {
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

        public function loadFromDCDS(arg1:String):void
        {
            var loc1:*=0;
            var loc8:*=0;
            var loc9:*=0;
            var loc10:*=0;
            var loc4:*=null;
            var loc2:*=null;
            var loc13:*=0;
            var loc15:*=0;
            var loc7:*=0;
            var loc6:*=0;
            var loc5:*=0;
            var loc16:*=0;
            var loc11:*=0;
            var loc12:*=0;
            var loc3:*=null;
            var loc14:*=null;
        }

        public override function get unit():core.units.Unit
        {
            return _unit;
        }

        public override function set unit(arg1:core.units.Unit):void
        {
            if (_unit != null) 
            {
                debug.Debug.debug("Unit changed from:\t" + _unit.type.toString() + "\tto:\t" + arg1.type.toString());
            }
            else 
            {
                debug.Debug.debug("Unit initialized:\t" + arg1.type.toString());
            }
            _unit = arg1 as core.units.UnitTopline2016;
            return;
        }

        public override function destructor():void
        {
            super.destructor();
            service.DeviceCommunicationHandler.getInstance().removeEventListener("usbComplete", onLoaded, false);
            return;
        }

        public override function loadFromDC(arg1:String):void
        {
            debug.Debug.debug("type: " + arg1 + "\tUnit: " + unit.type.toString());
            debug.Debug.debug("nativeProcessIsBusy: " + service.DeviceCommunicationHandler.getInstance().nativeProcessIsBusy);
            if (service.DeviceCommunicationHandler.getInstance().nativeProcessIsBusy) 
            {
                service.DeviceCommunicationHandler.getInstance().addToCommandQueue(arg1, "loadCommand", this);
                return;
            }
            service.DeviceCommunicationHandler.getInstance().checkUnitConnected = false;
            debug.Debug.debug("connectionMode: " + service.DeviceCommunicationHandler.getInstance().connectionMode);
            if (!service.DeviceCommunicationHandler.getInstance().hasEventListener("usbComplete")) 
            {
                service.DeviceCommunicationHandler.getInstance().addEventListener("usbComplete", onLoaded, false, 0, false);
            }
            var loc1:*=service.DeviceCommunicationHandler.getInstance().connectionMode;
            while ("connectionModeNFC" === loc1) 
            {
                loadFromDCNFC(arg1);
            }
        }

        public function loadFromDCNFC(arg1:String):void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=new flash.utils.ByteArray();
            var loc6:*=0;
            var loc5:*=new __AS3__.vec.Vector.<service.nfc.NfcQueObj>();
            currentType = arg1;
            var loc8:*=arg1;
            while ("loadUnitlogDataHeader" === loc8) 
            {
                if (unit is core.units.interfaces.ILogList) 
                {
                    debug.Debug.debug("[LOAD_UNIT_LOG_DATA_HEADER_FROM_DEVICE]");
                    (unit as core.units.interfaces.IDataToDecode).activitiesToDecode = new __AS3__.vec.Vector.<core.activities.Activity>();
                    if (_numberOfPageHeader != 0) 
                    {
                        currentBytesToReceive = 83 * _numberOfPageHeader;
                        currentCommand = "getNfcPageHeader";
                        debug.Debug.debug("[LOAD_UNIT_LOG_DATA_HEADER_FROM_DEVICE]\t [GET_BC_PAGEHEADER_NFC_COMMAND]\t Lade PageHeader: " + currentBytesToReceive + " bytes");
                        loc1 = "1E " + service.nfc.NFCHandler.createBlockHexAddress(1) + " " + service.nfc.NFCHandler.createBlockHexAddress(currentBytesToReceive);
                        loc4 = service.nfc.NFCHandler.generateNativeProzessBufferNfc(loc1, service.nfc.NFCHandler.createNfcFlashCmd(3, 0, 0));
                        loc5.push(new service.nfc.NfcQueObj(loc4, 2, false));
                    }
                    else 
                    {
                        currentBytesToReceive = 3;
                        currentCommand = "getNfcPageHeaderCount";
                        debug.Debug.debug("[LOAD_UNIT_LOG_DATA_HEADER_FROM_DEVICE]\t [GET_BC_PAGEHEADERCOUNT_NFC_COMMAND]\t Lade Anzahl der PageHeader!");
                        loc1 = "1E " + service.nfc.NFCHandler.createBlockHexAddress(0) + " " + service.nfc.NFCHandler.createBlockHexAddress(1);
                        loc4 = service.nfc.NFCHandler.generateNativeProzessBufferNfc(loc1, service.nfc.NFCHandler.createNfcFlashCmd(1, 0, 0));
                        loc5.push(new service.nfc.NfcQueObj(loc4, 2, false));
                    }
                }
            }
        }

        public override function sendToDC(arg1:String):void
        {
            if (service.DeviceCommunicationHandler.getInstance().nativeProcessIsBusy) 
            {
                debug.Debug.debug("nativeProcessIsBusy == true");
                service.DeviceCommunicationHandler.getInstance().addToCommandQueue(arg1, "sendCommand", this);
                return;
            }
            if (!service.DeviceCommunicationHandler.getInstance().hasEventListener("usbComplete")) 
            {
                service.DeviceCommunicationHandler.getInstance().addEventListener("usbComplete", onLoaded, false, 0, false);
            }
            var loc1:*=service.DeviceCommunicationHandler.getInstance().connectionMode;
            while ("connectionModeNFC" === loc1) 
            {
                sendToDCNFC(arg1);
            }
        }

        public function sendToDCNFC(arg1:String):void
        {
            var loc2:*=null;
            var loc5:*=null;
            var loc3:*=null;
            var loc7:*=null;
            var loc1:*=null;
            var loc6:*=null;
            var loc11:*=null;
            var loc16:*=null;
            var loc13:*=0;
            var loc17:*=null;
            var loc10:*=null;
            var loc9:*=null;
            var loc12:*=null;
            var loc4:*=null;
            var loc14:*=new flash.utils.ByteArray();
            var loc8:*=0;
            var loc15:*=new __AS3__.vec.Vector.<service.nfc.NfcQueObj>();
            _onLoadedCount = 0;
            currentType = arg1;
            var loc18:*=arg1;
            while ("writeUnitSettings" === loc18) 
            {
                debug.Debug.debug("[UnitHandler.WRITE_UNIT_SETTINGS_TO_DEVICE]");
                _onLoadedCountExpected = 3;
                currentBytesToReceive = 1;
                currentCommand = "commandSendSettingsUpdate";
                loc5 = decoder.Topline2016Decoder.getInstance().encodeSettingsNFC(unit);
                loc7 = service.nfc.NFCHandler.generateNativeProzessBufferNfc("0A 00 00 00 38 00 00 00 00", loc5, false);
                debug.Debug.debug("TopLine2016 (Unit: \'" + (unit ? unit.type.data : "?") + "\') \t BASIC SETTINGS \t loadCommand: " + arg1 + " \t byteString: " + loc5.join(" "));
                loc15.push(new service.nfc.NfcQueObj(loc7, _onLoadedCountExpected, false));
                loc5 = unit is core.units.UnitBC2316STS ? decoder.Topline2016Decoder.getInstance().encodeAdvancedSettingsBC2316NFC(unit) : decoder.Topline2016Decoder.getInstance().encodeAdvancedSettingsNFC(unit);
                loc1 = service.nfc.NFCHandler.generateNativeProzessBufferNfc("0A 00 00 00 48 00 00 00 00", loc5, false);
                debug.Debug.debug("TopLine2016 (Unit: \'" + (unit ? unit.type.data : "?") + "\') \t ADVANCED SETTINGS \t loadCommand: " + arg1 + " \t byteString: " + loc5.join(" "));
                loc15.push(new service.nfc.NfcQueObj(loc1, _onLoadedCountExpected, false));
                loc6 = service.nfc.NFCHandler.generateNativeProzessBufferNfc("0A 00 00 00 14 00 00 00 00", "50 20 02 73".split(" "), true);
                loc15.push(new service.nfc.NfcQueObj(loc6, _onLoadedCountExpected, false));
            }
        }

        internal function calculateChecksumm(arg1:Array):Array
        {
            var loc3:*=0;
            var loc2:*=0;
            var loc1:*=(arg1.length - 1);
            while (loc3 <= loc1) 
            {
                loc2 = loc2 + arg1[loc3];
                ++loc3;
            }
            ++loc2;
            loc2 = loc2 & 255;
            arg1.push(loc2);
            return arg1;
        }

        public function sendToDCDS(arg1:String):void
        {
            var loc3:*=null;
            var loc10:*=null;
            var loc5:*=null;
            var loc6:*=null;
            var loc8:*=null;
            var loc1:*=0;
            var loc7:*=null;
            var loc9:*=null;
            var loc4:*=null;
            var loc2:*=NaN;
        }

        internal function prepareCommandByteStringToArray(arg1:String):Array
        {
            var loc1:*=null;
            var loc6:*=0;
            var loc4:*=[];
            var loc5:*;
            var loc2:*=(loc5 = arg1.split(" ")).length;
            var loc3:*=0;
            loc3 = 0;
            while (loc3 < loc2) 
            {
                loc1 = loc5[loc3];
                loc6 = parseInt(loc1, 16);
                loc4.push(loc6);
                ++loc3;
            }
            return loc4;
        }

        internal function onLoaded(arg1:service.usb.event.DeviceDataCompleteEvent):void
        {
            var loc12:*=null;
            var loc23:*=null;
            var loc18:*=null;
            var loc24:*=null;
            var loc9:*=null;
            var loc3:*=null;
            var loc20:*=null;
            var loc26:*=null;
            var loc22:*=null;
            var loc1:*=null;
            var loc25:*=0;
            var loc14:*=0;
            var loc11:*=0;
            var loc7:*=null;
            var loc4:*=null;
            var loc15:*=null;
            var loc8:*=null;
            var loc19:*=null;
            var loc5:*=null;
            var loc2:*=null;
            var loc27:*=null;
            var loc10:*=null;
            var loc13:*=null;
            var loc28:*=null;
            var loc16:*=null;
            var loc29:*=NaN;
            var loc17:*=null;
            var loc6:*=null;
            ++_onLoadedCount;
            debug.Debug.debug("onLoaded (" + _onLoadedCount + ") command: " + arg1.command + " \t currentType: " + currentType + "\t Unit: " + unit.type.toString());
            service.DeviceCommunicationHandler.getInstance().checkUnitConnected = true;
            var loc21:*=0;
            if (arg1.command == "14 00 00 00 00 00 00 02 00") 
            {
                loc18 = (loc23 = (loc12 = arg1.data[0]).resultBytes).slice(0, 16);
                loc24 = loc23.slice(64, 69);
                if ((loc9 = decoder.Topline2016Decoder.getInstance().decodeInitialInformationNFC(loc18, loc24)) == null) 
                {
                    clear();
                    dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 10001, "CurrentUnitHandler > onLoaded: Can not create unit"));
                    return;
                }
                if (unit.type != loc9.type) 
                {
                    clear();
                    dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 10010, "Topline2016Handler > onLoaded: Unit do not match"));
                    dispatchEvent(new flash.events.Event("eventUnitTypeDoNotMatch"));
                    return;
                }
                if (!(currentType == "loadUnitInformation") && !(unit.serialNumber == loc9.serialNumber)) 
                {
                    clear();
                    dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 10010, "Topline2016Handler > onLoaded: Unit do not match"));
                    dispatchEvent(new flash.events.Event("eventUnitSerialNumberDoNotMatch"));
                    return;
                }
            }
            if (arg1.command != 253.toString()) 
            {
                if (arg1.command != "239 00 06 00 00 00 00 00 00 246".toString()) 
                {
                    if (arg1.command != 237.toString()) 
                    {
                        if (arg1.command != "239 00 08 00 00 00 00 00 00 248".toString()) 
                        {
                            if (arg1.command != 242.toString()) 
                            {
                                if (arg1.command != 235.toString()) 
                                {
                                    if (arg1.command != "239 00 07 00 00 00 00 00 00 247".toString()) 
                                    {
                                        if (arg1.command != "239 00 09 00 00 00 00 00 00 249".toString()) 
                                        {
                                            if (arg1.command != 251.toString()) 
                                            {
                                                if (arg1.command != "239 00 15 00 00 00 00 00 00 255") 
                                                {
                                                    if (arg1.command != GET_PAGE_HEADER_BC2316_COMMAND_DYNAMIC) 
                                                    {
                                                        if (arg1.command != GET_LOG_DATA_BC2316_COMMAND_DYNAMIC) 
                                                        {
                                                            if (arg1.command == "219 1 0 0") 
                                                            {
                                                                deleteGhostDataFirst = false;
                                                                sendToDC("writeGhostRace");
                                                                return;
                                                            }
                                                            if (arg1.command == SEND_GHOST_RACE_COMMAND_DYNAMIC) 
                                                            {
                                                                sendToDC("writeGhostRace");
                                                                return;
                                                            }
                                                            if (arg1.command != "249 5 0 0 0") 
                                                            {
                                                                if (arg1.command == 252.toString() || arg1.command == "238 00 06 00 00 00 17 00 00") 
                                                                {
                                                                    flash.utils.setTimeout(sendToDC, 2000, "writeUnitAdvancedSettings");
                                                                }
                                                                else if (arg1.command == 236.toString() || arg1.command == "238 00 08 00 00 00 37 00 00") 
                                                                {
                                                                    dispatchEvent(new flash.events.Event("settingsSendComplete"));
                                                                }
                                                                else if (arg1.command != "238 00 07 00 00 00 27 00 00") 
                                                                {
                                                                    if (arg1.command != "238 00 09 00 00 00 37 00 00") 
                                                                    {
                                                                        if (arg1.command != 241.toString()) 
                                                                        {
                                                                            if (arg1.command != 234.toString()) 
                                                                            {
                                                                                if (arg1.command != "commandSendSleepScreenUpdate") 
                                                                                {
                                                                                    if (arg1.command != 240.toString()) 
                                                                                    {
                                                                                        if (arg1.command == "14 00 00 00 00 00 00 02 00" && currentType == "loadUnitInformation") 
                                                                                        {
                                                                                            unit.serialNumber = loc9.serialNumber;
                                                                                            unit.softwareRevision = loc9.softwareRevision;
                                                                                            dispatchEvent(new handler.event.UnitEvent("unitInitialisedEvent", unit));
                                                                                        }
                                                                                        else if (arg1.command == "14 00 00 00 00 00 00 02 00" && currentType == "loadUnitSettings") 
                                                                                        {
                                                                                            loc15 = (loc4 = (loc12 = arg1.data[0]).resultBytes).slice(224, 256);
                                                                                            unit.currentSettings = decoder.Topline2016Decoder.getInstance().decodeSettingsNFC(loc15, unit);
                                                                                            if (unit is core.units.UnitBC2316STS) 
                                                                                            {
                                                                                                loc8 = loc4.slice(288, 324);
                                                                                                unit.currentSettings = decoder.Topline2016Decoder.getInstance().decodeAdvancedSettingsNFCBC2316(loc8, unit.currentSettings);
                                                                                            }
                                                                                            else 
                                                                                            {
                                                                                                loc8 = loc4.slice(288, 336);
                                                                                                unit.currentSettings = decoder.Topline2016Decoder.getInstance().decodeAdvancedSettingsNFC(loc8, unit.currentSettings);
                                                                                            }
                                                                                            if (unit.currentSettings != null) 
                                                                                            {
                                                                                                loadingSettingsFailedCounter = 0;
                                                                                                dispatchEvent(new flash.events.Event("settingsLoadedFromUnitComplete"));
                                                                                            }
                                                                                            else 
                                                                                            {
                                                                                                ++loadingSettingsFailedCounter;
                                                                                                dispatchEvent(new handler.event.ProgressStatusEvent("progressbarEvent", 0, 1, 1, "Received invalid data. Retry " + loadingSettingsFailedCounter + " of " + retriesAfterLoadSettingsFailed + ".", false, false));
                                                                                                if (loadingSettingsFailedCounter <= retriesAfterLoadSettingsFailed) 
                                                                                                {
                                                                                                    loadFromDC("loadUnitSettings");
                                                                                                    debug.Debug.error("Loading Seetings failed!  (" + loadingSettingsFailedCounter + " of " + retriesAfterLoadSettingsFailed + " tries)");
                                                                                                }
                                                                                            }
                                                                                        }
                                                                                        else if (arg1.command == "14 00 00 00 00 00 00 02 00" && currentType == "loadTotalValues") 
                                                                                        {
                                                                                            loc5 = (loc19 = (loc12 = arg1.data[0]).resultBytes).slice(256, 288);
                                                                                            loc2 = loc19.slice(320, 336);
                                                                                            (unit as core.units.UnitTopline2016).currentTotals = decoder.Topline2016Decoder.getInstance().decodeTotalsNFC(loc5, unit);
                                                                                            (unit as core.units.UnitTopline2016).currentTotals = decoder.Topline2016Decoder.getInstance().decodeTotalsAdvancedNFC(loc2, (unit as core.units.UnitTopline2016).currentTotals);
                                                                                            if ((unit as core.units.interfaces.ITotalsList).currentTotals != null) 
                                                                                            {
                                                                                                dispatchEvent(new flash.events.Event("totalsLoadComplete"));
                                                                                            }
                                                                                            else 
                                                                                            {
                                                                                                ++loadingTotalsFailedCounter;
                                                                                                dispatchEvent(new handler.event.ProgressStatusEvent("progressbarEvent", 0, 1, 1, "Received invalid data. Retrying " + loadingTotalsFailedCounter + " of " + retriesAfterLoadTotalsFailed + ".", false, false));
                                                                                                if (loadingSettingsFailedCounter <= retriesAfterLoadTotalsFailed) 
                                                                                                {
                                                                                                    loadFromDC("loadTotalValues");
                                                                                                    debug.Debug.error("Loading Totals failed!  (" + loadingSettingsFailedCounter + " of " + retriesAfterLoadTotalsFailed + " tries)");
                                                                                                }
                                                                                            }
                                                                                        }
                                                                                        else if (arg1.command == "getNfcPageHeaderCount" && currentType == "loadUnitlogDataHeader") 
                                                                                        {
                                                                                            debug.Debug.debug("[BC23.16] Anzahl der Header ermitteln");
                                                                                            loc12 = arg1.data[0];
                                                                                            _numberOfPageHeader = decoder.Topline2016Decoder.getInstance().decodePageHeaderCount(loc12.resultBytes);
                                                                                            debug.Debug.debug("numberOfPageHeader: " + _numberOfPageHeader);
                                                                                            if (_numberOfPageHeader > 0) 
                                                                                            {
                                                                                                loadFromDC("loadUnitlogDataHeader");
                                                                                            }
                                                                                            else 
                                                                                            {
                                                                                                service.DeviceCommunicationHandler.getInstance().stopAndShowError(new service.event.DeviceCommunicationEvent("eventCommunicationError", utils.LanguageManager.getString("INFO_POPUP.NO_LOG_ON_DEVICE")));
                                                                                            }
                                                                                        }
                                                                                        else if (arg1.command == "getNfcPageHeader" && currentType == "loadUnitlogDataHeader") 
                                                                                        {
                                                                                            debug.Debug.debug("[BC23.16] Header holen");
                                                                                            if (unit is core.units.interfaces.ILogList && _numberOfPageHeader > 0) 
                                                                                            {
                                                                                                loc27 = (loc12 = arg1.data[0]).resultBytes.slice(4, currentBytesToReceive + 4);
                                                                                                (unit as core.units.interfaces.ILogList).loadedLogs = new __AS3__.vec.Vector.<core.activities.Activity>();
                                                                                                loc21 = 0;
                                                                                                while (loc21 < _numberOfPageHeader) 
                                                                                                {
                                                                                                    debug.Debug.debug("PageHeader " + (loc21 + 1) + "/" + _numberOfPageHeader);
                                                                                                    try 
                                                                                                    {
                                                                                                        loc10 = loc27.slice(0, 83);
                                                                                                        loc27 = loc27.slice(83);
                                                                                                        loc13 = decoder.Topline2016Decoder.getInstance().decodeLogHeader(loc10, unit);
                                                                                                        (unit as core.units.interfaces.ILogList).loadedLogs.push(loc13);
                                                                                                    }
                                                                                                    catch (error:Error)
                                                                                                    {
                                                                                                        debug.Debug.error("Fehler beim Decoding: " + error.message);
                                                                                                        return;
                                                                                                    }
                                                                                                    ++loc21;
                                                                                                }
                                                                                                (unit as core.units.interfaces.IDataToDecode).activitiesToDecode = new __AS3__.vec.Vector.<core.activities.Activity>();
                                                                                                _numberOfPageHeader = 0;
                                                                                                _logsToDecode = 0;
                                                                                                sendToDC("closeNfcTag");
                                                                                            }
                                                                                            else 
                                                                                            {
                                                                                                _numberOfPageHeader = 0;
                                                                                                _logsToDecode = 0;
                                                                                            }
                                                                                        }
                                                                                        else if (arg1.command == "5A 00 00 00 00 00 00 00 00" && currentType == "closeNfcTag") 
                                                                                        {
                                                                                            debug.Debug.debug("[BC 23.16] NFC Tag schließen");
                                                                                            dispatchEvent(new flash.events.Event("pageHeaderChange"));
                                                                                        }
                                                                                        else if (arg1.command == "getLogData" && currentType == "loadUnitlogData") 
                                                                                        {
                                                                                            debug.Debug.debug("[BC 23.16] Logs holen");
                                                                                            if (arg1.data[0] is service.nfc.NfcQueObj) 
                                                                                            {
                                                                                                loc12 = arg1.data[0];
                                                                                                if ((loc29 = (unit as core.units.interfaces.IDataToDecode).activitiesToDecode.indexOf(loc12.activity)) >= 0) 
                                                                                                {
                                                                                                    loc16 = loc12.resultBytes.slice(4, -1);
                                                                                                    loc28 = (unit as core.units.interfaces.IDataToDecode).activitiesToDecode[loc29];
                                                                                                    core.activities.ActivityFactory.applyZoneValues(loc28, false, true);
                                                                                                    if (decoder.Topline2016Decoder.getInstance().decodeLog(loc28, loc16)) 
                                                                                                    {
                                                                                                        if ((unit as core.units.interfaces.ILogList).loadedLogs.indexOf(loc28) == -1) 
                                                                                                        {
                                                                                                            (unit as core.units.interfaces.ILogList).loadedLogs.push(loc28);
                                                                                                        }
                                                                                                    }
                                                                                                    (unit as core.units.interfaces.IDataToDecode).activitiesToDecode.removeAt(loc29);
                                                                                                }
                                                                                                if ((unit as core.units.interfaces.IDataToDecode).activitiesToDecode.length == 0) 
                                                                                                {
                                                                                                    (unit as core.units.interfaces.IDataToDecode).activitiesToDecode = (unit as core.units.interfaces.ILogList).loadedLogs;
                                                                                                    dispatchEvent(new flash.events.Event("logsLoadedFromUnitComplete"));
                                                                                                }
                                                                                            }
                                                                                        }
                                                                                        else if (arg1.command == "14 00 00 00 00 00 00 02 00" && currentType == "loadUnitTripData") 
                                                                                        {
                                                                                            loc6 = (loc17 = (loc12 = arg1.data[0]).resultBytes).slice(416, 448);
                                                                                            if (unit is core.units.interfaces.ILogList) 
                                                                                            {
                                                                                                (unit as core.units.interfaces.ILogList).loadedLogs = decoder.Topline2016Decoder.getInstance().decodeActivityNFC(loc6, unit);
                                                                                            }
                                                                                            else 
                                                                                            {
                                                                                                unit.loadedMemories = decoder.Topline2016Decoder.getInstance().decodeActivityNFC(loc6, unit);
                                                                                            }
                                                                                            dispatchEvent(new flash.events.Event("memoriesLoadedFromUnitComplete"));
                                                                                        }
                                                                                        else if (arg1.command == "commandSendSettingsUpdate") 
                                                                                        {
                                                                                            if (_onLoadedCount == _onLoadedCountExpected) 
                                                                                            {
                                                                                                dispatchEvent(new flash.events.Event("settingsSendComplete"));
                                                                                            }
                                                                                        }
                                                                                    }
                                                                                    else 
                                                                                    {
                                                                                        if (arg1.data[0] == 1) 
                                                                                        {
                                                                                            debug.Debug.error("Fehler beim reset");
                                                                                        }
                                                                                        dispatchEvent(new flash.events.Event("sendResetMomoryToDeviceComplete"));
                                                                                        if (unit is core.units.interfaces.ILogList) 
                                                                                        {
                                                                                            (unit as core.units.interfaces.ILogList).loadedLogs = new __AS3__.vec.Vector.<core.activities.Activity>();
                                                                                        }
                                                                                        else 
                                                                                        {
                                                                                            unit.loadedMemories = new __AS3__.vec.Vector.<core.activities.Activity>();
                                                                                        }
                                                                                        dispatchEvent(new flash.events.Event("logDeleteCompleteEvent"));
                                                                                    }
                                                                                }
                                                                                else if (_onLoadedCount == _onLoadedCountExpected) 
                                                                                {
                                                                                    dispatchEvent(new flash.events.Event("sleepScreenSendComplete"));
                                                                                }
                                                                            }
                                                                            else 
                                                                            {
                                                                                dispatchEvent(new flash.events.Event("sendTotalValuesComplete"));
                                                                            }
                                                                        }
                                                                        else if (unit is core.units.UnitBC1616STS || unit is core.units.UnitBC1616 || unit is core.units.UnitBC1416STS || unit is core.units.UnitBC1416) 
                                                                        {
                                                                            flash.utils.setTimeout(sendToDC, 3000, "writeAdvancedTotalValues");
                                                                        }
                                                                        else 
                                                                        {
                                                                            dispatchEvent(new flash.events.Event("sendTotalValuesComplete"));
                                                                        }
                                                                    }
                                                                    else 
                                                                    {
                                                                        dispatchEvent(new flash.events.Event("sendTotalValuesComplete"));
                                                                    }
                                                                }
                                                                else 
                                                                {
                                                                    flash.utils.setTimeout(sendToDC, 1500, "writeAdvancedTotalValues");
                                                                }
                                                            }
                                                            else 
                                                            {
                                                                trace("nfc ghost complete");
                                                                encodedGhostRace = [];
                                                                deleteGhostDataFirst = true;
                                                                encodedGhostRaceBytes = 0;
                                                                sendToDC("closeNfcTag");
                                                                dispatchEvent(new handler.event.ProgressStatusEvent("progressbarEvent", 100, 1, 1));
                                                                dispatchEvent(new flash.events.Event("sendGhostRaceComplete"));
                                                            }
                                                        }
                                                        else 
                                                        {
                                                            _logDataBuffer = _logDataBuffer.concat(arg1.data.slice(4, -1));
                                                            loc14 = 100 * _loadLogPakageCount / _totalLogPackages;
                                                            loc11 = 100 / (_logsToDecode * 100) * ((_logToLoadNum - 1) * 100 + loc14);
                                                            dispatchEvent(new handler.event.ProgressStatusEvent("progressbarEvent", loc11, _logToLoadNum, _logsToDecode, "", false, false));
                                                            debug.Debug.info("[ " + loc11 + " | " + _logToLoadNum + " | " + _logsToDecode + " ]");
                                                            if (_loadLogPakageCount < _totalLogPackages) 
                                                            {
                                                                ++_loadLogPakageCount;
                                                                flash.utils.setTimeout(loadFromDC, 1500, "loadUnitlogData");
                                                            }
                                                            else 
                                                            {
                                                                loc7 = (unit as core.units.interfaces.IDataToDecode).activitiesToDecode.shift();
                                                                core.activities.ActivityFactory.applyZoneValues(loc7, false, true);
                                                                decoder.Topline2016Decoder.getInstance().decodeLog(loc7, _logDataBuffer);
                                                                _logDataBuffer = [];
                                                                _loadLogPakageCount = 1;
                                                                _totalLogPackages = 1;
                                                                if ((unit as core.units.interfaces.IDataToDecode).activitiesToDecode.length > 0) 
                                                                {
                                                                    ++_logToLoadNum;
                                                                    flash.utils.setTimeout(loadFromDC, 1500, "loadUnitlogData");
                                                                }
                                                                else 
                                                                {
                                                                    dispatchEvent(new handler.event.ProgressStatusEvent("progressbarEvent", 100, _logToLoadNum, _logsToDecode, "", false, false));
                                                                    _logToLoadNum = 1;
                                                                    _logsToDecode = 0;
                                                                    dispatchEvent(new flash.events.Event("logsLoadedFromUnitComplete", false, false));
                                                                }
                                                            }
                                                        }
                                                    }
                                                    else 
                                                    {
                                                        _pageHeaderLengthLoaded = false;
                                                        (unit as core.units.interfaces.ILogList).loadedLogs = new __AS3__.vec.Vector.<core.activities.Activity>();
                                                        loc1 = (arg1.data as Array).slice(4, -1);
                                                        loc25 = 0;
                                                        loc21 = 0;
                                                        while (loc21 < _numberOfPageHeader) 
                                                        {
                                                            (unit as core.units.interfaces.ILogList).loadedLogs.push(decoder.Topline2016Decoder.getInstance().decodeLogHeader(loc1.slice(0, 83), unit));
                                                            loc1 = loc1.slice(83);
                                                            ++loc21;
                                                        }
                                                        _logDataBuffer = [];
                                                        _loadLogPakageCount = 1;
                                                        _totalLogPackages = 1;
                                                        _logToLoadNum = 1;
                                                        _numberOfPageHeader = 0;
                                                        _logsToDecode = 0;
                                                        dispatchEvent(new flash.events.Event("pageHeaderChange", false, false));
                                                    }
                                                }
                                                else 
                                                {
                                                    _numberOfPageHeader = arg1.data[4];
                                                    if (_numberOfPageHeader != 0) 
                                                    {
                                                        _pageHeaderLengthLoaded = true;
                                                        flash.utils.setTimeout(loadFromDC, 1500, "loadUnitlogDataHeader");
                                                    }
                                                    else 
                                                    {
                                                        _pageHeaderLengthLoaded = false;
                                                        (unit as core.units.interfaces.ILogList).loadedLogs = new __AS3__.vec.Vector.<core.activities.Activity>();
                                                        dispatchEvent(new flash.events.Event("pageHeaderChange", false, false));
                                                    }
                                                }
                                            }
                                            else if (unit is core.units.interfaces.ILogList) 
                                            {
                                                if (dataDeleted) 
                                                {
                                                    dataDeleted = false;
                                                    dispatchEvent(new flash.events.Event("memoriesLoadedFromUnitComplete"));
                                                }
                                                else 
                                                {
                                                    (unit as core.units.interfaces.ILogList).loadedLogs = decoder.Topline2016Decoder.getInstance().decodeActivity(arg1.data, unit);
                                                    if ((unit as core.units.interfaces.ILogList).loadedLogs != null) 
                                                    {
                                                        dataDeleted = false;
                                                        dispatchEvent(new flash.events.Event("memoriesLoadedFromUnitComplete"));
                                                    }
                                                }
                                            }
                                            else if (dataDeleted) 
                                            {
                                                dataDeleted = false;
                                                dispatchEvent(new flash.events.Event("memoriesLoadedFromUnitComplete"));
                                            }
                                            else 
                                            {
                                                unit.loadedMemories = decoder.Topline2016Decoder.getInstance().decodeActivity(arg1.data, unit);
                                                if (unit.loadedMemories != null) 
                                                {
                                                    dataDeleted = false;
                                                    dispatchEvent(new flash.events.Event("memoriesLoadedFromUnitComplete"));
                                                }
                                            }
                                        }
                                        else 
                                        {
                                            loc22 = arg1.data.slice(4, -1);
                                            (unit as core.units.interfaces.ITotalsList).currentTotals = decoder.Topline2016Decoder.getInstance().decodeTotalsAdvancedNFC(loc22, (unit as core.units.interfaces.ITotalsList).currentTotals);
                                            if ((unit as core.units.interfaces.ITotalsList).currentTotals != null) 
                                            {
                                                dispatchEvent(new flash.events.Event("totalsLoadComplete"));
                                            }
                                            else 
                                            {
                                                ++loadingTotalsFailedCounter;
                                                dispatchEvent(new handler.event.ProgressStatusEvent("progressbarEvent", 0, 1, 1, "Received invalid data. Retrying " + loadingTotalsFailedCounter + " of " + retriesAfterLoadTotalsFailed + ".", false, false));
                                                if (loadingSettingsFailedCounter <= retriesAfterLoadTotalsFailed) 
                                                {
                                                    loadFromDC("loadTotalAdvancedValues");
                                                    debug.Debug.error("Loading Totals failed!  (" + loadingSettingsFailedCounter + " of " + retriesAfterLoadTotalsFailed + " tries)");
                                                }
                                            }
                                        }
                                    }
                                    else 
                                    {
                                        loc26 = arg1.data.slice(4, -1);
                                        (unit as core.units.interfaces.ITotalsList).currentTotals = decoder.Topline2016Decoder.getInstance().decodeTotalsNFC(loc26, unit);
                                        if ((unit as core.units.interfaces.ITotalsList).currentTotals != null) 
                                        {
                                            flash.utils.setTimeout(loadFromDC, 3000, "loadTotalAdvancedValues");
                                        }
                                        else 
                                        {
                                            ++loadingTotalsFailedCounter;
                                            dispatchEvent(new handler.event.ProgressStatusEvent("progressbarEvent", 0, 1, 1, "Received invalid data. Retrying " + loadingTotalsFailedCounter + " of " + retriesAfterLoadTotalsFailed + ".", false, false));
                                            if (loadingSettingsFailedCounter <= retriesAfterLoadTotalsFailed) 
                                            {
                                                loadFromDC("loadTotalValues");
                                                debug.Debug.error("Loading Totals failed!  (" + loadingSettingsFailedCounter + " of " + retriesAfterLoadTotalsFailed + " tries)");
                                            }
                                        }
                                    }
                                }
                                else 
                                {
                                    (unit as core.units.interfaces.ITotalsList).currentTotals = decoder.Topline2016Decoder.getInstance().decodeTotalsAdvanced(arg1.data, (unit as core.units.interfaces.ITotalsList).currentTotals);
                                    if ((unit as core.units.interfaces.ITotalsList).currentTotals != null) 
                                    {
                                        dispatchEvent(new flash.events.Event("totalsLoadComplete"));
                                    }
                                    else 
                                    {
                                        ++loadingTotalsFailedCounter;
                                        dispatchEvent(new handler.event.ProgressStatusEvent("progressbarEvent", 0, 1, 1, "Received invalid data. Retrying " + loadingTotalsFailedCounter + " of " + retriesAfterLoadTotalsFailed + ".", false, false));
                                        if (loadingSettingsFailedCounter <= retriesAfterLoadTotalsFailed) 
                                        {
                                            loadFromDC("loadTotalAdvancedValues");
                                            debug.Debug.error("Loading Totals failed!  (" + loadingSettingsFailedCounter + " of " + retriesAfterLoadTotalsFailed + " tries)");
                                        }
                                    }
                                }
                            }
                            else 
                            {
                                (unit as core.units.interfaces.ITotalsList).currentTotals = decoder.Topline2016Decoder.getInstance().decodeTotals(arg1.data, unit);
                                if ((unit as core.units.interfaces.ITotalsList).currentTotals != null) 
                                {
                                    if (unit is core.units.UnitBC1616STS || unit is core.units.UnitBC1616 || unit is core.units.UnitBC1416STS || unit is core.units.UnitBC1416) 
                                    {
                                        flash.utils.setTimeout(loadFromDC, 3000, "loadTotalAdvancedValues");
                                    }
                                    else 
                                    {
                                        dispatchEvent(new flash.events.Event("totalsLoadComplete"));
                                    }
                                }
                                else 
                                {
                                    ++loadingTotalsFailedCounter;
                                    dispatchEvent(new handler.event.ProgressStatusEvent("progressbarEvent", 0, 1, 1, "Received invalid data. Retrying " + loadingTotalsFailedCounter + " of " + retriesAfterLoadTotalsFailed + ".", false, false));
                                    if (loadingSettingsFailedCounter <= retriesAfterLoadTotalsFailed) 
                                    {
                                        loadFromDC("loadTotalValues");
                                        debug.Debug.error("Loading Totals failed!  (" + loadingSettingsFailedCounter + " of " + retriesAfterLoadTotalsFailed + " tries)");
                                    }
                                }
                            }
                        }
                        else 
                        {
                            loc20 = arg1.data.slice(4, -1);
                            unit.currentSettings = decoder.Topline2016Decoder.getInstance().decodeAdvancedSettingsNFCBC2316(loc20, unit.currentSettings);
                            if (unit.currentSettings != null) 
                            {
                                loadingSettingsFailedCounter = 0;
                                dispatchEvent(new flash.events.Event("settingsLoadedFromUnitComplete"));
                            }
                            else 
                            {
                                ++loadingSettingsFailedCounter;
                                dispatchEvent(new handler.event.ProgressStatusEvent("progressbarEvent", 0, 1, 1, "Received invalid data. Retry " + loadingSettingsFailedCounter + " of " + retriesAfterLoadSettingsFailed + ".", false, false));
                                if (loadingSettingsFailedCounter <= retriesAfterLoadSettingsFailed) 
                                {
                                    flash.utils.setTimeout(loadFromDC, 3000, "loadUnitAdvancedSettings");
                                    debug.Debug.error("Loading Advanced Settings failed!  (" + loadingSettingsFailedCounter + " of " + retriesAfterLoadSettingsFailed + " tries)");
                                }
                            }
                        }
                    }
                    else 
                    {
                        unit.currentSettings = decoder.Topline2016Decoder.getInstance().decodeAdvancedSettings(arg1.data, unit.currentSettings);
                        if (unit.currentSettings != null) 
                        {
                            loadingSettingsFailedCounter = 0;
                            dispatchEvent(new flash.events.Event("settingsLoadedFromUnitComplete"));
                        }
                        else 
                        {
                            ++loadingSettingsFailedCounter;
                            dispatchEvent(new handler.event.ProgressStatusEvent("progressbarEvent", 0, 1, 1, "Received invalid data. Retry " + loadingSettingsFailedCounter + " of " + retriesAfterLoadSettingsFailed + ".", false, false));
                            if (loadingSettingsFailedCounter <= retriesAfterLoadSettingsFailed) 
                            {
                                flash.utils.setTimeout(loadFromDC, 3000, "loadUnitAdvancedSettings");
                                debug.Debug.error("Loading Advanced Settings failed!  (" + loadingSettingsFailedCounter + " of " + retriesAfterLoadSettingsFailed + " tries)");
                            }
                        }
                    }
                }
                else 
                {
                    loc3 = arg1.data.slice(4, -1);
                    unit.currentSettings = decoder.Topline2016Decoder.getInstance().decodeSettingsNFC(loc3, unit);
                    if (unit.currentSettings != null) 
                    {
                        loadingSettingsFailedCounter = 0;
                        flash.utils.setTimeout(loadFromDC, 3000, "loadUnitAdvancedSettings");
                    }
                    else 
                    {
                        ++loadingSettingsFailedCounter;
                        dispatchEvent(new handler.event.ProgressStatusEvent("progressbarEvent", 0, 1, 1, "Received invalid data. Retry " + loadingSettingsFailedCounter + " of " + retriesAfterLoadSettingsFailed + ".", false, false));
                        if (loadingSettingsFailedCounter <= retriesAfterLoadSettingsFailed) 
                        {
                            loadFromDC("loadUnitSettings");
                            debug.Debug.error("Loading Settings failed!  (" + loadingSettingsFailedCounter + " of " + retriesAfterLoadSettingsFailed + " tries)");
                        }
                    }
                }
            }
            else 
            {
                unit.currentSettings = decoder.Topline2016Decoder.getInstance().decodeSettings(arg1.data, unit);
                if (unit.currentSettings != null) 
                {
                    loadingSettingsFailedCounter = 0;
                    if (unit is core.units.UnitBC1616STS || unit is core.units.UnitBC1616 || unit is core.units.UnitBC1416STS || unit is core.units.UnitBC1416) 
                    {
                        flash.utils.setTimeout(loadFromDC, 3000, "loadUnitAdvancedSettings");
                    }
                    else 
                    {
                        dispatchEvent(new flash.events.Event("settingsLoadedFromUnitComplete"));
                    }
                }
                else 
                {
                    ++loadingSettingsFailedCounter;
                    dispatchEvent(new handler.event.ProgressStatusEvent("progressbarEvent", 0, 1, 1, "Received invalid data. Retry " + loadingSettingsFailedCounter + " of " + retriesAfterLoadSettingsFailed + ".", false, false));
                    if (loadingSettingsFailedCounter <= retriesAfterLoadSettingsFailed) 
                    {
                        loadFromDC("loadUnitSettings");
                        debug.Debug.error("Loading Settings failed!  (" + loadingSettingsFailedCounter + " of " + retriesAfterLoadSettingsFailed + " tries)");
                    }
                }
            }
            service.DeviceCommunicationHandler.getInstance().processNextCommandFromQueue();
            return;
        }

        internal function clear():void
        {
            _onLoadedCount = 0;
            _onLoadedCountExpected = 0;
            service.DeviceCommunicationHandler.getInstance().removeEventListener("usbComplete", onLoaded);
            return;
        }

        public static const SEND_BC_TOTALS_BC2316_COMMAND:String="238 00 07 00 00 00 27 00 00";

        public static const SEND_BC_TOTALS_BYTES_TO_RECEIVE:int=1;

        public static const SEND_BC_TOTALS_COMMAND:int=241;

        public static const SEND_BC_TOTAL_ADVANCE_SETTINGS_BYTES_TO_RECEIVE:int=1;

        public static const SEND_BC_TOTAL_ADVANCE_SETTINGS_COMMAND:int=234;

        public static const SEND_GHOST_RACE_COMMAND:String="238 1 5";

        public static const SEND_GHOST_RACE_COMMAND_BYTES_TO_RECEIVE:int=4;

        public static const SEND_GHOST_RACE_NFC_COMMAND:String="249 5 0 0 0";

        public static const SEND_SETTINGS_ADVANCED_DATA_NFC_COMMAND:String="0A 00 00 00 48 00 00 00 00";

        public static const SEND_SETTINGS_BASIC_DATA_NFC_COMMAND:String="0A 00 00 00 38 00 00 00 00";

        public static const SEND_SETTINGS_DATA_BC2316_BYTES_TO_RECEIVE:int=3;

        public static const SEND_SETTINGS_DATA_BC2316_COMMAND:String="238 00 06 00 00 00 17 00 00";

        public static const SEND_SETTINGS_DATA_BYTES_TO_RECEIVE:int=1;

        public static const SEND_SETTINGS_DATA_COMMAND:int=252;

        public static const SEND_SETTINGS_DATA_NFC_UPDATE_FLAGS:String="50 20 02 73";

        public static const SEND_SLEEP_SCREEN_DATA_BYTES_TO_RECEIVE:int=1;

        public static const SEND_SLEEP_SCREEN_DATA_NFC_COMMAND:String="0A 00 00 00 18 00 00 00 00";

        public static const SEND_SLEEP_SCREEN_DATA_NFC_UPDATE_FLAGS:Array=[8, 32, 1, 42];

        public static const SEND_UPDATE_FLAGS_DATA_NFC_COMMAND:String="0A 00 00 00 14 00 00 00 00";

        internal static const COMMAND_NFCONLY_CLOSE_NFC:String="5A 00 00 00 00 00 00 00 00";

        internal static const COMMAND_SEND_SETTINGS_UPDATE:String="commandSendSettingsUpdate";

        internal static const COMMAND_SEND_SLEEP_SCREEN_UPDATE:String="commandSendSleepScreenUpdate";

        internal static const PAGE_HEADER_LAST_BYTE_2316:uint=2080767;

        internal static const PAGE_HEADER_SIZE_2316:uint=83;

        internal static const PAGE_HEADER_SIZE_2316_CALC:uint=128;

        public static const DELETE_GHOST_RACE_COMMAND:String="219 1 0 0";

        public static const DELETE_GHOST_RACE_COMMAND_BYTES_TO_RECEIVE:int=3;

        public static const DELETE_GHOST_RACE_NFC_COMMAND:String="245 1 0 0 247";

        public static const GET_AT_EL_COUNT_COMMAND:int=249;

        public static const GET_BC_ALL_DATA_NFC_BYTES_TO_RECEIVE:int=387;

        public static const GET_BC_ALL_DATA_NFC_COMMAND:String="14 00 00 00 00 00 00 02 00";

        public static const GET_BC_ANT_BLE_SETTING_BYTES_TO_RECEIVE:int=45;

        public static const GET_BC_ANT_BLE_SETTING_COMMAND:int=233;

        public static const GET_BC_BATTERY_INFORMATION_BYTES_TO_RECEIVE:int=3;

        public static const GET_BC_BATTERY_INFORMATION_COMMAND:int=229;

        public static const GET_BC_LOGDATA_NFC_COMMAND:String="getLogData";

        public static const GET_BC_NORMAL_ADVANCE_SETTINGS_BC2316_BYTES_TO_RECEIVE:int=42;

        public static const GET_BC_NORMAL_ADVANCE_SETTINGS_BC2316_COMMAND:String="239 00 08 00 00 00 00 00 00 248";

        public static const GET_BC_NORMAL_ADVANCE_SETTINGS_BYTES_TO_RECEIVE:int=28;

        public static const GET_BC_NORMAL_ADVANCE_SETTINGS_COMMAND:int=237;

        public static const GET_BC_PAGEHEADERCOUNT_NFC_BYTES_TO_RECEIVE:int=3;

        public static const GET_BC_PAGEHEADERCOUNT_NFC_COMMAND:String="getNfcPageHeaderCount";

        public static const GET_BC_PAGEHEADER_NFC_COMMAND:String="getNfcPageHeader";

        public static const GET_BC_TOTALS_BYTES_TO_RECEIVE:int=23;

        public static const GET_BC_TOTALS_COMMAND:int=242;

        public static const GET_BC_TOTAL_ADVANCE_SETTINGS_BYTES_TO_RECEIVE:int=13;

        public static const GET_BC_TOTAL_ADVANCE_SETTINGS_COMMAND:int=235;

        public static const GET_BC_TRAINING_DIARY_DATA_BYTES_TO_RECEIVE:int=360;

        public static const GET_BC_TRAINING_DIARY_DATA_COMMAND:int=231;

        public static const GET_DS_CURRENT_MODE:int=247;

        public static const GET_DS_VERSION:int=245;

        public static const GET_LOG_DATA_BC2316_COMMAND:String="239 01 04";

        public static const GET_NUMBER_OF_PAGES_BC2316_BYTES_TO_RECEIVE:int=8;

        public static const GET_NUMBER_OF_PAGES_BC2316_COMMAND:String="239 00 15 00 00 00 00 00 00 255";

        public static const GET_PAGE_HEADER_BC2316_COMMAND:String="239 01 03 01 00 00";

        public static const GET_PAGE_HEADER_BC2316_COMMAND_BYTES_TO_RECEIVE:int=83;

        public static const GET_SETTINGS_DATA_BC2316_BYTES_TO_RECEIVE:int=22;

        public static const GET_SETTINGS_DATA_BC2316_COMMAND:String="239 00 06 00 00 00 00 00 00 246";

        public static const GET_SETTINGS_DATA_BYTES_TO_RECEIVE:int=34;

        public static const GET_SETTINGS_DATA_COMMAND:int=253;

        public static const GET_TOTAL_ADVANCED_DATA_BC2316_BYTES_TO_RECEIVE:int=42;

        public static const GET_TOTAL_ADVANCED_DATA_BC2316_COMMAND:String="239 00 09 00 00 00 00 00 00 249";

        public static const GET_TOTAL_DATA_BC2316_BYTES_TO_RECEIVE:int=32;

        public static const GET_TOTAL_DATA_BC2316_COMMAND:String="239 00 07 00 00 00 00 00 00 247";

        public static const GET_TRIP_DATA_BYTES_TO_RECEIVE:int=36;

        public static const GET_TRIP_DATA_COMMAND:int=251;

        public static const GOTO_DS_BOOTLOADER:int=246;

        public static const NFCONLY_CLOSE_NFC_TAG:String="closeNfcTag";

        public static const RESET_AT_EL_COUNT_COMMAND:int=248;

        public static const SEND_ADVANCED_SETTINGS_DATA_BC2316_BYTES_TO_RECEIVE:int=3;

        public static const SEND_ADVANCED_SETTINGS_DATA_BC2316_COMMAND:String="238 00 08 00 00 00 37 00 00";

        public static const SEND_BC_ANT_BLE_SETTING_BYTES_TO_RECEIVE:int=1;

        public static const SEND_BC_ANT_BLE_SETTING_COMMAND:int=232;

        public static const SEND_BC_BATTERY_INFORMATION_BYTES_TO_RECEIVE:int=1;

        public static const SEND_BC_BATTERY_INFORMATION_COMMAND:int=230;

        public static const SEND_BC_NORMAL_ADVANCE_SETTINGS_BYTES_TO_RECEIVE:int=1;

        public static const SEND_BC_NORMAL_ADVANCE_SETTINGS_COMMAND:int=236;

        public static const SEND_BC_POWERMODE_BYTES_TO_RECEIVE:int=1;

        public static const SEND_BC_POWERMODE_COMMAND:int=240;

        public static const SEND_BC_RESET_MEMORY_BYTES_TO_RECEIVE:int=1;

        public static const SEND_BC_TOTALS_ADVANCED_BC2316_BYTES_TO_RECEIVE:int=3;

        public static const SEND_BC_TOTALS_ADVANCED_BC2316_COMMAND:String="238 00 09 00 00 00 37 00 00";

        public static const SEND_BC_TOTALS_BC2316_BYTES_TO_RECEIVE:int=3;

        internal var _ghostRaceLog:core.activities.Activity;

        internal var _unit:core.units.UnitTopline2016;

        internal var _loadLogPakageCount:uint=1;

        internal var _logDataBuffer:Array;

        internal var _logQueue:__AS3__.vec.Vector.<core.activities.Activity>;

        internal var _logToLoadNum:int=1;

        internal var _logsToDecode:uint=0;

        internal var _myUnitSettings:core.settings.SettingsBikeComputer;

        internal var _numberOfPageHeader:uint=0;

        internal var _onLoadedCount:uint=0;

        internal var _onLoadedCountExpected:uint=0;

        internal var _settingsSavedCommandsReady:Array;

        internal var _timer:service.usb.USBSendTimer;

        internal var _totalLogPackages:uint=1;

        internal var dataDeleted:Boolean=false;

        internal var deleteGhostDataFirst:Boolean=true;

        internal var encodedGhostRace:Array;

        internal var encodedGhostRaceBytes:uint=0;

        internal var encodedGhostRaceLength:int;

        internal var ghostDataPackageCount:uint=0;

        internal var loadingSettingsFailedCounter:uint=0;

        internal var loadingTotalsFailedCounter:uint=0;

        internal var retriesAfterLoadSettingsFailed:uint=3;

        internal var retriesAfterLoadTotalsFailed:uint=3;

        internal var _pageHeaderLengthLoaded:Boolean=false;

        public static var GET_LOG_DATA_BC2316_COMMAND_DYNAMIC:String;

        public static var GET_PAGE_HEADER_BC2316_COMMAND_DYNAMIC:String;

        public static var SEND_GHOST_RACE_COMMAND_DYNAMIC:String;
    }
}


