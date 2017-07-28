//class Topline2016DSHandler
package handler.dockingstation 
{
    import com.logging.*;
    import core.units.*;
    import debug.*;
    import flash.events.*;
    import flash.utils.*;
    import handler.event.*;
    import service.*;
    import service.event.*;
    import service.usb.event.*;
    
    public class Topline2016DSHandler extends handler.dockingstation.DockingStationHandler
    {
        public function Topline2016DSHandler(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
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
            if (arg1.length == 43) 
            {
                currentCommand = 58;
                currentBytesToReceive = 1;
                loc1 = new flash.utils.ByteArray();
                loc1.writeUTFBytes(arg1);
                service.DeviceCommunicationHandler.getInstance().sendToDevice(loc1, this);
            }
            return;
        }

        public override function scanDockingStation():void
        {
            if (useTimeoutOnScanDockingStation) 
            {
                useTimeoutOnScanDockingStation = false;
                debug.Debug.debug("wait... useTimeoutOnScanDockingStation");
                flash.utils.setTimeout(scanDockingStation, 2000);
                return;
            }
            if (dsMode == "unknownMode") 
            {
                loadFromDC(247.toString());
                return;
            }
            if (dsMode == "normalMode") 
            {
                if (dsVersion == 0) 
                {
                    loadFromDC("checkDSVersion");
                    return;
                }
                addEventListener("unitConnectedEvent", onUnitConnected, false, 0, true);
                loadFromDC("checkUnitConnected");
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

        protected function onUnitConnected(arg1:flash.events.Event):void
        {
            if (!_unitInitialised) 
            {
                service.DeviceCommunicationHandler.getInstance().checkUnitConnected = false;
                flash.utils.setTimeout(loadFromDC, 1500, "loadUnitInformation");
            }
            _unitIsConnected = true;
            return;
        }

        internal function onLoaded(arg1:service.usb.event.DeviceDataCompleteEvent):void
        {
            var loc3:*=null;
            var loc2:*=0;
            var loc1:*=null;
            service.DeviceCommunicationHandler.getInstance().removeEventListener("usbComplete", onLoaded, false);
            if (arg1.command != 244.toString()) 
            {
                if (arg1.command != 254.toString()) 
                {
                    if (arg1.command == 245.toString()) 
                    {
                        dsVersion = resolveDSVersion(arg1.data);
                        trace("dsVersion:" + dsVersion);
                        scanDockingStation();
                        return;
                    }
                    if (arg1.command == 247.toString()) 
                    {
                        if (arg1.data[0] != 0) 
                        {
                            if (arg1.data[0] == 1) 
                            {
                                dsMode = "bootloaderMode";
                            }
                        }
                        else 
                        {
                            dsMode = "normalMode";
                        }
                        scanDockingStation();
                        return;
                    }
                    if (arg1.command == 246.toString()) 
                    {
                        if (arg1.data[0] != 0) 
                        {
                            dsMode = "unknownMode";
                        }
                        else 
                        {
                            dsMode = "bootloaderMode";
                        }
                        service.DeviceCommunicationHandler.getInstance().dispatchEvent(new flash.events.Event("bootloaderModeChangedEvent"));
                        return;
                    }
                    if (arg1.command != 115.toString()) 
                    {
                        if (arg1.command != 101.toString()) 
                        {
                            if (arg1.command != 118.toString()) 
                            {
                                if (arg1.command != 69.toString()) 
                                {
                                    if (arg1.command == 58.toString()) 
                                    {
                                        if (arg1.data[0] != 89) 
                                        {
                                            service.DeviceCommunicationHandler.getInstance().dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 0, "SEND_A_LINE"));
                                        }
                                        else 
                                        {
                                            service.DeviceCommunicationHandler.getInstance().dispatchEvent(new flash.events.Event("sendALineEvent"));
                                        }
                                    }
                                }
                                else if (arg1.data[0] != 89) 
                                {
                                    service.DeviceCommunicationHandler.getInstance().dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 0, "END_PROG_AND_RUN"));
                                }
                                else 
                                {
                                    service.DeviceCommunicationHandler.getInstance().dispatchEvent(new flash.events.Event("endProgAndRunEvent"));
                                }
                            }
                            else if (arg1.data[0] != 89) 
                            {
                                service.DeviceCommunicationHandler.getInstance().dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 0, "START_VERIFICATION"));
                            }
                            else 
                            {
                                service.DeviceCommunicationHandler.getInstance().dispatchEvent(new flash.events.Event("startVerificationEvent"));
                            }
                        }
                        else if (arg1.data[0] != 89) 
                        {
                            service.DeviceCommunicationHandler.getInstance().dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 0, "ERASE_FLASH_ROM_SUCCESS"));
                        }
                        else 
                        {
                            service.DeviceCommunicationHandler.getInstance().dispatchEvent(new flash.events.Event("eraseFlashRomEvent"));
                        }
                    }
                    else if (arg1.data[0] != 89) 
                    {
                        service.DeviceCommunicationHandler.getInstance().dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 0, "START_PROGRAM"));
                    }
                    else 
                    {
                        service.DeviceCommunicationHandler.getInstance().dispatchEvent(new flash.events.Event("startProgramEvent"));
                    }
                }
                else 
                {
                    loc1 = decodeUnitInformation(arg1.data) as core.units.UnitBikeComputer;
                    if (loc1 != null) 
                    {
                        service.DeviceCommunicationHandler.getInstance().checkUnitConnected = true;
                        wrongVersionDataCount = 0;
                        _unitInitialised = true;
                        dispatchEvent(new handler.event.UnitEvent("unitInitialisedEvent", loc1));
                    }
                    else 
                    {
                        ++wrongVersionDataCount;
                        trace("wrongVersionDataCount:" + wrongVersionDataCount);
                        _unitIsConnected = false;
                        _unitInitialised = false;
                        service.DeviceCommunicationHandler.getInstance().stopAndShowError(new service.event.DeviceCommunicationEvent("eventCommunicationError", "CurrentUnitHandler > onLoaded: Can not create unit"));
                        dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 10001, "CurrentUnitHandler > onLoaded: Can not create unit"));
                    }
                }
            }
            else 
            {
                resetCheckConnectionTimeOut();
                if (!scanDockingStationStopped) 
                {
                    _scanDocingstationTimeOutId = flash.utils.setTimeout(loadFromDC, _scanDockingStationInterval, "checkUnitConnected");
                }
                loc2 = 0;
                if (arg1.data[0] != 1) 
                {
                    _unitInitialised = false;
                    loc3 = new flash.events.Event("unitDisconnectedEvent");
                    dispatchEvent(loc3);
                    _unitIsConnected = false;
                }
                else 
                {
                    loc3 = new flash.events.Event("unitConnectedEvent");
                    dispatchEvent(loc3);
                }
            }
            service.DeviceCommunicationHandler.getInstance().processNextCommandFromQueue();
            return;
        }

        internal function decodeUnitInformation(arg1:Object):core.units.Unit
        {
            var loc2:*=null;
            var loc1:*=parseInt((arg1[1] as int).toString(16), 10);
        }

        protected override function resolveDSVersion(arg1:Object):uint
        {
            var loc1:*=arg1 as Array;
            var loc2:*="0";
            if (loc1.length == 2) 
            {
                loc2 = loc1[0] + "";
                if (loc1[1] < 10) 
                {
                    loc2 = loc2 + "0";
                }
                loc2 = loc2 + loc1[1];
                loc2 = loc2 + "00";
            }
            return parseInt(loc2);
        }

        public override function getDSVersionString():String
        {
            var loc3:*=0;
            if (dsVersion.toString().length < 5) 
            {
                return "0";
            }
            var loc1:*=[];
            var loc2:*=dsVersion.toString();
            loc2 = loc2.substring(0, loc2.length - 2);
            if (loc2.length != 3) 
            {
                loc1.push(loc2.substr(0, 2).toString());
                loc3 = 2;
            }
            else 
            {
                loc1.push(loc2.substr(0, 1).toString());
                loc3 = 1;
            }
            loc1.push(loc2.substr(loc3, 2).toString());
            return "ver" + loc1.join(".");
        }

        public override function destructor():void
        {
            super.destructor();
            service.DeviceCommunicationHandler.getInstance().removeEventListener("usbComplete", onLoaded);
            return;
        }

        public override function loadFromDC(arg1:String):void
        {
            if (service.DeviceCommunicationHandler.getInstance().nativeProcessIsBusy) 
            {
                trace("checkUnitConnected nativeProcessIsBusy");
                service.DeviceCommunicationHandler.getInstance().addToCommandQueue(arg1, "loadCommand", this);
                return;
            }
            service.DeviceCommunicationHandler.getInstance().addEventListener("usbComplete", onLoaded, false, 0, true);
            currentReceiveChecksumLength = 0;
            currentStartAdrr = "";
            if (arg1 != "checkUnitConnected") 
            {
                if (arg1 != "loadUnitInformation") 
                {
                    if (arg1 != "checkDSVersion") 
                    {
                        if (arg1 != 247.toString()) 
                        {
                            if (arg1 != 246.toString()) 
                            {
                                if (arg1 != 115.toString()) 
                                {
                                    if (arg1 != 101.toString()) 
                                    {
                                        if (arg1 != 118.toString()) 
                                        {
                                            if (arg1 != 69.toString()) 
                                            {
                                                debug.Debug.error("unknown command!!");
                                            }
                                            else 
                                            {
                                                currentCommand = 69;
                                                currentBytesToReceive = 1;
                                            }
                                        }
                                        else 
                                        {
                                            currentCommand = 118;
                                            currentBytesToReceive = 1;
                                        }
                                    }
                                    else 
                                    {
                                        currentCommand = 101;
                                        currentBytesToReceive = 1;
                                    }
                                }
                                else 
                                {
                                    currentCommand = 115;
                                    currentBytesToReceive = 1;
                                }
                            }
                            else 
                            {
                                currentCommand = 246;
                                currentBytesToReceive = 1;
                            }
                        }
                        else 
                        {
                            currentCommand = 247;
                            currentBytesToReceive = 1;
                        }
                    }
                    else 
                    {
                        currentCommand = 245;
                        currentBytesToReceive = 2;
                    }
                }
                else 
                {
                    currentCommand = 254;
                    currentBytesToReceive = 11;
                }
            }
            else 
            {
                currentCommand = 244;
                currentBytesToReceive = 1;
                if (service.DeviceCommunicationHandler.getInstance().checkUnitConnected) 
                {
                    _checkConnectionTimeOutId = flash.utils.setTimeout(checkConnectionTimeout, connectionTimeoutInterval);
                }
                else 
                {
                    debug.Debug.debug("checkUnitConnected disabled");
                    service.DeviceCommunicationHandler.getInstance().removeEventListener("usbComplete", onLoaded);
                    _scanDocingstationTimeOutId = flash.utils.setTimeout(loadFromDC, _scanDockingStationInterval, "checkUnitConnected");
                    return;
                }
            }
            service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBuffer(currentCommand), this);
            return;
        }

        public override function getValidFileRows():int
        {
            return 1792;
        }

        public override function isValidFWFile(arg1:Array):Boolean
        {
            var loc1:*=true;
            if (arg1.length != getValidFileRows()) 
            {
                loc1 = false;
            }
            else 
            {
                var loc4:*=0;
                var loc3:*=arg1;
                for each (var loc2:* in loc3) 
                {
                    if (loc2.charAt(0) == ":") 
                    {
                        if (loc2.length != 43) 
                        {
                            loc1 = false;
                            break;
                        }
                        continue;
                    }
                    loc1 = false;
                    break;
                }
            }
            return loc1;
        }

        public override function goToBootloader():void
        {
            if (dsMode == "bootloaderMode") 
            {
                service.DeviceCommunicationHandler.getInstance().dispatchEvent(new flash.events.Event("bootloaderModeChangedEvent"));
            }
            else 
            {
                loadFromDC(246.toString());
            }
            return;
        }

        public override function startUpdate(arg1:Array):void
        {
            updateFileArray = arg1;
            service.DeviceCommunicationHandler.getInstance().addEventListener("startProgramEvent", handleProgramStarted);
            dsVersion = 0;
            dsMode = "unknownMode";
            afterVerification = false;
            linesSentCount = 0;
            useTimeoutOnScanDockingStation = true;
            loadFromDC(115.toString());
            return;
        }

        internal function handleProgramStarted(arg1:flash.events.Event):void
        {
            debug.Debug.debug("handleProgramStarted");
            service.DeviceCommunicationHandler.getInstance().removeEventListener("startProgramEvent", handleProgramStarted);
            eraseFlashRomUFSB();
            return;
        }

        internal function eraseFlashRomUFSB():void
        {
            debug.Debug.debug("eraseFlashRomUFSB");
            service.DeviceCommunicationHandler.getInstance().addEventListener("eraseFlashRomEvent", handleEraseFlashRom);
            loadFromDC(101.toString());
            return;
        }

        internal function handleEraseFlashRom(arg1:flash.events.Event):void
        {
            debug.Debug.debug("handleEraseFlashRom");
            service.DeviceCommunicationHandler.getInstance().removeEventListener("eraseFlashRomEvent", handleEraseFlashRom);
            timeOutId = flash.utils.setTimeout(sendLines, 1000);
            return;
        }

        internal function sendLines():void
        {
            debug.Debug.debug("sendLines");
            service.DeviceCommunicationHandler.getInstance().addEventListener("sendALineEvent", handleLineSent);
            var loc1:*=updateFileArray[linesSentCount];
            sendToDC(loc1);
            return;
        }

        internal function handleLineSent(arg1:flash.events.Event):void
        {
            debug.Debug.debug("handleLineSent");
            if (afterVerification) 
            {
                installVerificationProgress(linesSentCount);
            }
            else 
            {
                installUpdateProgress(linesSentCount);
            }
            if (linesSentCount != (1792 - 1)) 
            {
                ++linesSentCount;
                if (linesSentCount < updateFileArray.length) 
                {
                    sendLines();
                }
            }
            else 
            {
                service.DeviceCommunicationHandler.getInstance().removeEventListener("sendALineEvent", handleLineSent);
                linesSentCount = 0;
                if (afterVerification) 
                {
                    endProgramAndRun();
                }
                else 
                {
                    startVerification();
                }
            }
            return;
        }

        internal function endProgramAndRun():void
        {
            debug.Debug.debug("endProgramAndRun");
            service.DeviceCommunicationHandler.getInstance().addEventListener("endProgAndRunEvent", handleProgramEnded);
            loadFromDC(69.toString());
            return;
        }

        internal function handleProgramEnded(arg1:flash.events.Event):void
        {
            debug.Debug.debug("handleProgramEnded");
            service.DeviceCommunicationHandler.getInstance().removeEventListener("endProgAndRunEvent", handleProgramEnded);
            if (afterVerification) 
            {
                installUpdateSuccess();
            }
            else 
            {
                startVerification();
            }
            return;
        }

        internal function startVerification():void
        {
            debug.Debug.debug("startVerification");
            service.DeviceCommunicationHandler.getInstance().addEventListener("startVerificationEvent", handleStartVerification);
            loadFromDC(118.toString());
            return;
        }

        internal function handleStartVerification(arg1:flash.events.Event):void
        {
            debug.Debug.debug("handleStartVerification");
            service.DeviceCommunicationHandler.getInstance().removeEventListener("startVerificationEvent", handleStartVerification);
            afterVerification = true;
            linesSentCount = 0;
            sendLines();
            return;
        }

        public static const UNIT_STOP_COMMUNICATION_COMMAND:uint=220;

        public static const UNIT_STOP_COMMUNICATION_COMMAND_BYTES_TO_RECEIVE:uint=2;

        public static const VALID_FILE_BYTES_IN_ROW:int=43;

        public static const VALID_FILE_EXTENSION:String="ufsb";

        public static const VALID_FILE_ROWS:int=1792;

        public static const VALID_FILE_ROW_BEGIN:String=":";

        public static const END_PROG_AND_RUN:uint=69;

        public static const END_PROG_AND_RUN_BYTES_TO_RECEIVE:uint=1;

        public static const END_PROG_AND_RUN_SUCCESS:uint=89;

        public static const ERASE_FLASH_ROM:uint=101;

        public static const ERASE_FLASH_ROM_SUCCESS:uint=89;

        public static const GET_DS_CURRENT_MODE_BYTES_TO_RECEIVE:uint=1;

        public static const GET_DS_CURRENT_MODE_COMMAND:uint=247;

        public static const GET_DS_VERSION_BYTES_TO_RECEIVE:uint=2;

        public static const GET_DS_VERSION_COMMAND:uint=245;

        public static const GET_VERSION_DATA_BYTES_TO_RECEIVE:uint=11;

        public static const GET_VERSION_DATA_COMMAND:uint=254;

        public static const GO_TO_BOOTLOADER_BYTES_TO_RECEIVE:uint=1;

        public static const GO_TO_BOOTLOADER_COMMAND:uint=246;

        public static const SEND_A_LINE:uint=58;

        public static const SEND_A_LINE_BYTES_TO_RECEIVE:uint=1;

        public static const SEND_A_LINE_LENGTH:int=43;

        public static const SEND_A_LINE_SUCCESS:uint=89;

        public static const START_PROGRAM:uint=115;

        public static const START_PROGRAM_BYTES_TO_RECEIVE:uint=1;

        public static const START_PROGRAM_SUCCESS:uint=89;

        public static const START_VERIFICATION:uint=118;

        public static const START_VERIFICATION_BYTES_TO_RECEIVE:uint=1;

        public static const START_VERIFICATION_SUCCESS:uint=89;

        public static const UNIT_CONNECTED_COMMAND:uint=244;

        public static const UNIT_CONNECTED_COMMAND_BYTES_TO_RECEIVE:uint=1;

        internal var _readErrorRepeats:int=0;

        internal var _scanDockingStationInterval:uint=1000;

        internal var _unitIsConnected:Boolean=false;

        internal var timeOutId:uint;

        internal var useTimeoutOnScanDockingStation:Boolean=false;

        internal var wrongVersionDataCount:uint=0;
    }
}


