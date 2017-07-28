//package dockingstation
//  class BLEDSHandler
package handler.dockingstation 
{
    import com.logging.*;
    import core.units.*;
    import flash.events.*;
    import flash.utils.*;
    import handler.event.*;
    import service.*;
    import service.usb.event.*;
    
    public class BLEDSHandler extends handler.dockingstation.DockingStationHandler
    {
        public function BLEDSHandler(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
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
            if (arg1 != "loadUnitInformation") 
            {
                if (arg1 != "loadSerialnumberInformation") 
                {
                    if (arg1 == "loadSerialnumberBackupInformation") 
                    {
                        currentCommand = "83 D0 FF 00 0B 00 A2";
                        currentBytesToReceive = 12;
                        currentReceiveChecksumLength = 4;
                    }
                }
                else 
                {
                    currentCommand = "83 E0 FF 0 0B 0 92";
                    currentBytesToReceive = 12;
                    currentReceiveChecksumLength = 4;
                }
            }
            else 
            {
                currentCommand = "83 F0 FF 0 7 0 86";
                currentBytesToReceive = 8;
                currentReceiveChecksumLength = 4;
            }
            service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBuffer(currentCommand), this);
            return;
        }

        protected function generateNativeProzessBuffer(arg1:String, arg2:Array=null):flash.utils.ByteArray
        {
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=new flash.utils.ByteArray();
            var loc5:*;
            var loc1:*=(loc5 = arg1.split(" ")).length;
            loc2 = 0;
            while (loc2 < loc1) 
            {
                loc4.writeByte(parseInt(loc5[loc2], 16));
                ++loc2;
            }
            if (arg2 != null) 
            {
                loc3 = 0;
                while (loc3 < arg2.length) 
                {
                    loc4.writeByte(arg2[loc3]);
                    ++loc3;
                }
            }
            return loc4;
        }

        internal function onLoaded(arg1:service.usb.event.DeviceDataCompleteEvent):void
        {
            service.DeviceCommunicationHandler.getInstance().removeEventListener("usbComplete", onLoaded);
            if (arg1.command != "83 F0 FF 0 7 0 86") 
            {
                if (arg1.command != "83 E0 FF 0 0B 0 92") 
                {
                    if (arg1.command == "83 D0 FF 00 0B 00 A2") 
                    {
                        if (!_unitInitialised) 
                        {
                            decodeSerialNumberInformation(arg1.data, true);
                            if (unit.serialNumber != null) 
                            {
                                _unitInitialised = true;
                                dispatchEvent(new handler.event.UnitEvent("unitInitialisedEvent", unit));
                            }
                        }
                    }
                }
                else if (!_unitInitialised) 
                {
                    decodeSerialNumberInformation(arg1.data);
                    if (unit.serialNumber == null) 
                    {
                        loadFromDC("83 D0 FF 00 0B 00 A2");
                    }
                    else 
                    {
                        _unitInitialised = true;
                        dispatchEvent(new handler.event.UnitEvent("unitInitialisedEvent", unit));
                    }
                }
            }
            else if (!_unitInitialised) 
            {
                unit = decodeUnitInformation(arg1.data) as core.units.Unit;
                if (unit == null) 
                {
                    dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 118, "BLEHandler > onLoaded: usb service, read failed!"));
                }
                else 
                {
                    loadFromDC("loadSerialnumberInformation");
                }
            }
            return;
        }

        internal function decodeUnitInformation(arg1:Object):core.units.Unit
        {
            var loc1:*=null;
            var loc6:*=0;
            var loc4:*;
            var loc7:*;
        }

        internal function decodeSerialNumberInformation(arg1:Object, arg2:Boolean=false):void
        {
            var loc5:*=0;
            var loc1:*=arg1 as Array;
            var loc4:*="";
            var loc2:*=arg1[2] << 16 | arg1[1] << 8 | arg1[0];
            var loc6:*=arg1[8] == 17 && arg1[9] == 32 && arg1[10] == 17 && arg1[11] == 20;
            var loc3:*=arg1[8] == 161 && arg1[9] == 162 && arg1[10] == 163 && arg1[11] == 164;
            var loc7:*=0;
            loc5 = 0;
            while (loc5 < 7) 
            {
                loc7 = loc7 + arg1[loc5];
                ++loc5;
            }
            if ((loc7 = loc7 & 255) == arg1[7] && (loc6 || loc3)) 
            {
                unit.serialNumber = loc2.toString();
            }
            else 
            {
                if (!arg2) 
                {
                };
                unit.serialNumber = null;
            }
            return;
        }

        public static const LOAD_CHECKSUMM_BYTES_TO_RECEIVE:uint=4;

        public static const LOAD_INITIALINFORMATION_BYTES_TO_RECEIVE:uint=8;

        public static const LOAD_INITIALINFORMATION_COMMAND:String="83 F0 FF 0 7 0 86";

        public static const LOAD_SERIALNUMBER_BACKUP_BYTES_TO_RECEIVE:uint=12;

        public static const LOAD_SERIALNUMBER_BACKUP_COMMAND:String="83 D0 FF 00 0B 00 A2";

        public static const LOAD_SERIALNUMBER_BYTES_TO_RECEIVE:uint=12;

        public static const LOAD_SERIALNUMBER_COMMAND:String="83 E0 FF 0 0B 0 92";

        internal var unit:core.units.Unit;
    }
}


//  class BLERox11DSHandler
package handler.dockingstation 
{
    import flash.events.*;
    
    public class BLERox11DSHandler extends handler.dockingstation.Rox110DSHandler
    {
        public function BLERox11DSHandler(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            return;
        }
    }
}


//  class DockingStationHandler
package handler.dockingstation 
{
    import com.logging.*;
    import flash.events.*;
    import flash.utils.*;
    import handler.*;
    import service.*;
    
    public class DockingStationHandler extends handler.DeviceHandler
    {
        public function DockingStationHandler(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            return;
        }

        protected function resolveDSVersion(arg1:Object):uint
        {
            return 0;
        }

        public function get dsMode():String
        {
            return _dsMode;
        }

        public function set dsMode(arg1:String):void
        {
            _dsMode = arg1;
            return;
        }

        public function getDSVersionString():String
        {
            return "0";
        }

        public function get dsVersion():uint
        {
            return _dsVersion;
        }

        public function set dsVersion(arg1:uint):void
        {
            _dsVersion = arg1;
            return;
        }

        public override function destructor():void
        {
            flash.utils.clearTimeout(_scanDocingstationTimeOutId);
            unitInitialised = false;
            super.destructor();
            return;
        }

        public function checkConnectionTimeout():void
        {
            removeEvents();
            service.DeviceCommunicationHandler.getInstance().resetCommunicationService();
            dispatchEvent(new com.logging.ErrorLoggingEvent("loggingInfoEvent", 120, "Unit Handler > checkConnectionTimeout "));
            return;
        }

        public function loadUnitInformation():void
        {
            return;
        }

        public function scanDockingStation():void
        {
            return;
        }

        public function stopScanDockingStation():void
        {
            scanDockingStationStopped = true;
            return;
        }

        public function startScanDockingStation():void
        {
            scanDockingStationStopped = false;
            return;
        }

        public function get unitInitialised():Boolean
        {
            return _unitInitialised;
        }

        public function set unitInitialised(arg1:Boolean):void
        {
            _unitInitialised = arg1;
            return;
        }

        public function getValidFileRows():int
        {
            return 0;
        }

        public function isBLEHandler():Boolean
        {
            return this is handler.dockingstation.BLEDSHandler || this is handler.dockingstation.BLERox11DSHandler;
        }

        public function goToBootloader():void
        {
            return;
        }

        public function startUpdate(arg1:Array):void
        {
            return;
        }

        public function isValidFWFile(arg1:Array):Boolean
        {
            return false;
        }

        public static const BOOTLOADER_MODE_CHANGED_EVENT:String="bootloaderModeChangedEvent";

        public static const CHECK_DS_VERSION:String="checkDSVersion";

        public static const CHECK_UNIT_CONNECTED:String="checkUnitConnected";

        public static const DS_MODE_BOOTLOADER:String="bootloaderMode";

        public static const DS_MODE_NORMAL:String="normalMode";

        public static const DS_MODE_UNKNOWN:String="unknownMode";

        public static const END_PROG_AND_RUN_EVENT:String="endProgAndRunEvent";

        public static const ERASE_FLASH_ROM_EVENT:String="eraseFlashRomEvent";

        public static const LOAD_SERIALNUMBER_BACKUP_INFORMATION:String="loadSerialnumberBackupInformation";

        public static const LOAD_SERIALNUMBER_INFORMATION:String="loadSerialnumberInformation";

        public static const LOAD_UNIT_INFORMATION:String="loadUnitInformation";

        public static const SEND_A_LINE_EVENT:String="sendALineEvent";

        public static const START_PROGRAM_EVENT:String="startProgramEvent";

        public static const START_SCAN_DOCKING_STATION:String="startScanDockingStationEvent";

        public static const START_VERIFICATION_EVENT:String="startVerificationEvent";

        public static const STOP_SCAN_DOCKING_STATION:String="stopScanDockingStationEvent";

        public static const UNIT_CONNECTED_EVENT:String="unitConnectedEvent";

        public static const UNIT_DISCONNECTED_EVENT:String="unitDisconnectedEvent";

        public static const UNIT_INITIALISED_EVENT:String="unitInitialisedEvent";

        internal var _dsMode:String="unknownMode";

        internal var _dsVersion:uint=0;

        public var installUpdateProgress:Function;

        public var installUpdateSuccess:Function;

        public var installVerificationProgress:Function;

        public var readyForFWUpdate:Boolean=false;

        public var scanDockingStationStopped:Boolean=false;

        protected var _unitInitialised:Boolean;

        protected var _scanDocingstationTimeOutId:uint=0;

        protected var afterVerification:Boolean=false;

        protected var linesSentCount:int=0;

        protected var updateFileArray:Array;
    }
}


//  class Gps10DSHandler
package handler.dockingstation 
{
    import com.logging.*;
    import core.units.*;
    import debug.*;
    import decoder.*;
    import flash.events.*;
    import flash.utils.*;
    import handler.event.*;
    import service.*;
    import service.usb.event.*;
    
    public class Gps10DSHandler extends handler.dockingstation.DockingStationHandler
    {
        public function Gps10DSHandler(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            return;
        }

        public override function stopScanDockingStation():void
        {
            super.stopScanDockingStation();
            return;
        }

        public override function destructor():void
        {
            super.destructor();
            removeEventListener("unitConnectedEvent", onUnitConnected);
            service.DeviceCommunicationHandler.getInstance().removeEventListener("usbComplete", onLoaded);
            return;
        }

        public override function startScanDockingStation():void
        {
            super.startScanDockingStation();
            _scanDockingStationId = flash.utils.setTimeout(loadFromDC, _scanDockingStationInterval, "checkUnitConnected");
            return;
        }

        public override function scanDockingStation():void
        {
            addEventListener("unitConnectedEvent", onUnitConnected);
            loadFromDC("checkUnitConnected");
            return;
        }

        protected function onUnitConnected(arg1:flash.events.Event):void
        {
            if (!unitInitialised) 
            {
                loadFromDC("loadUnitInformation");
            }
            return;
        }

        public override function loadFromDC(arg1:String):void
        {
            var loc1:*=null;
            debug.Debug.debug("[loadFromDC] " + arg1);
            if (service.DeviceCommunicationHandler.getInstance().nativeProcessIsBusy) 
            {
                debug.Debug.debug("nativeProcessIsBusy");
                service.DeviceCommunicationHandler.getInstance().addToCommandQueue(arg1, "loadCommand", this);
                return;
            }
            service.DeviceCommunicationHandler.getInstance().addEventListener("usbComplete", onLoaded, false, 0, false);
            if (arg1 == "checkUnitConnected") 
            {
                loc1 = new flash.events.Event("unitConnectedEvent");
                dispatchEvent(loc1);
                return;
                currentCommand = "244";
                currentBytesToReceive = 4;
                _checkConnectionTimeOutId = flash.utils.setTimeout(checkConnectionTimeout, connectionTimeoutInterval);
            }
            if (arg1 != "loadUnitInformation") 
            {
                debug.Debug.error("UNKNOWN COMMAND IN [loadFromDC]");
                service.DeviceCommunicationHandler.getInstance().removeEventListener("usbComplete", onLoaded);
                return;
            }
            else 
            {
                currentCommand = "86 12 0 0 0 0 0 0 69 0 0 167";
                currentBytesToReceive = 76;
            }
            service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBuffer(currentCommand), this);
            return;
        }

        protected function generateNativeProzessBuffer(arg1:String, arg2:Array=null):flash.utils.ByteArray
        {
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=new flash.utils.ByteArray();
            var loc5:*;
            var loc1:*=(loc5 = arg1.split(" ")).length;
            loc2 = 0;
            while (loc2 < loc1) 
            {
                loc4.writeByte(loc5[loc2]);
                ++loc2;
            }
            if (arg2 != null) 
            {
                loc3 = 0;
                while (loc3 < arg2.length) 
                {
                    loc4.writeByte(arg2[loc3]);
                    ++loc3;
                }
            }
            return loc4;
        }

        internal function onLoaded(arg1:service.usb.event.DeviceDataCompleteEvent):void
        {
            var loc2:*=null;
            var loc1:*=null;
            debug.Debug.debug("[onLoaded] " + arg1.command);
            service.DeviceCommunicationHandler.getInstance().removeEventListener("usbComplete", onLoaded, false);
            if (arg1.command != "244") 
            {
                if (arg1.command == "86 12 0 0 0 0 0 0 69 0 0 167") 
                {
                    if (!unitInitialised) 
                    {
                        loc1 = decodeUnitInformation(arg1.data) as core.units.Unit;
                        if (loc1 == null) 
                        {
                            dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 118, "RC2011Handler > onLoaded: usb service, read failed!"));
                        }
                        else 
                        {
                            unitInitialised = true;
                            decoder.Rox110Decoder.getInstance().unit = loc1;
                            dispatchEvent(new handler.event.UnitEvent("unitInitialisedEvent", loc1));
                        }
                    }
                    return;
                }
            }
            else 
            {
                if (!scanDockingStationStopped) 
                {
                    _scanDockingStationId = flash.utils.setTimeout(loadFromDC, _scanDockingStationInterval, "checkUnitConnected");
                }
                resetCheckConnectionTimeOut();
                if (arg1.data.length == 4 && arg1.data[0] == 17) 
                {
                    loc2 = new flash.events.Event("unitConnectedEvent");
                    dispatchEvent(loc2);
                }
                else 
                {
                    unitInitialised = false;
                    loc2 = new flash.events.Event("unitDisconnectedEvent");
                    dispatchEvent(loc2);
                }
            }
            service.DeviceCommunicationHandler.getInstance().processNextCommandFromQueue();
            return;
        }

        internal function decodeUnitInformation(arg1:Object):core.units.Unit
        {
            var loc3:*=arg1 as Array;
            if (!decoder.Gps10Decoder.isValidChecksum(loc3, 0)) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 533, "GPS10DSHandler > decodeUnitInformation: wrong crc"));
                return null;
            }
            loc3.splice(0, 5);
            loc3.pop();
            var loc2:*=loc3.slice(0, 0 + 6);
            var loc4:*=loc3.slice(64, 64 + 6);
            var loc1:*=decoder.Gps10Decoder.getInstance().decodeInitialInformation(loc2, loc4) as core.units.UnitGps10;
            debug.Debug.debug("serial: " + loc1.serialNumber + ", firmware: " + loc1.softwareRevision);
            return loc1;
        }

        public static const LOAD_INITIALINFORMATION_BYTES_TO_RECEIVE:uint=76;

        public static const LOAD_INITIALINFORMATION_COMMAND:String="86 12 0 0 0 0 0 0 69 0 0 167";

        public static const UNIT_CONNECTED_BYTES_TO_RECEIVE:uint=4;

        public static const UNIT_CONNECTED_COMMAND:String="244";

        internal var _scanDockingStationId:uint=0;

        internal var _scanDockingStationInterval:uint=2000;
    }
}


//  class NFCDSHandler
package handler.dockingstation 
{
    import com.logging.*;
    import core.units.*;
    import core.units.interfaces.*;
    import flash.events.*;
    import flash.utils.*;
    import service.*;
    import service.usb.event.*;
    
    public class NFCDSHandler extends handler.dockingstation.DockingStationHandler
    {
        public function NFCDSHandler(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
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
            if (arg1 == "loadUnitInformation") 
            {
                currentCommand = "14 00 00 00 00 00 00 FF 00";
                currentBytesToReceive = 8;
                currentReceiveChecksumLength = 4;
            }
            service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBuffer(currentCommand), this);
            return;
        }

        protected function generateNativeProzessBuffer(arg1:String, arg2:Array=null):flash.utils.ByteArray
        {
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=new flash.utils.ByteArray();
            var loc5:*;
            var loc1:*=(loc5 = arg1.split(" ")).length;
            loc2 = 0;
            while (loc2 < loc1) 
            {
                loc4.writeByte(parseInt(loc5[loc2], 16));
                ++loc2;
            }
            if (arg2 != null) 
            {
                loc3 = 0;
                while (loc3 < arg2.length) 
                {
                    loc4.writeByte(arg2[loc3]);
                    ++loc3;
                }
            }
            return loc4;
        }

        internal function onLoaded(arg1:service.usb.event.DeviceDataCompleteEvent):void
        {
            service.DeviceCommunicationHandler.getInstance().removeEventListener("usbComplete", onLoaded);
            if (arg1.command == "14 00 00 00 00 00 00 FF 00") 
            {
                if (!_unitInitialised) 
                {
                    (unit as core.units.interfaces.IBLEDeviceInfo).deviceID = port;
                    if (unit == null) 
                    {
                        dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 118, "BLEHandler > onLoaded: usb service, read failed!"));
                    }
                    else 
                    {
                        loadFromDC("loadSerialnumberInformation");
                    }
                }
            }
            return;
        }

        public static const LOAD_CHECKSUMM_BYTES_TO_RECEIVE:uint=4;

        public static const LOAD_INITIALINFORMATION_BYTES_TO_RECEIVE:uint=8;

        public static const LOAD_INITIALINFORMATION_COMMAND:String="14 00 00 00 00 00 00 FF 00";

        internal var unit:core.units.Unit;
    }
}


//  class RCDS2011Handler
package handler.dockingstation 
{
    import com.logging.*;
    import core.units.*;
    import flash.events.*;
    import flash.utils.*;
    import handler.event.*;
    import service.*;
    import service.usb.event.*;
    
    public class RCDS2011Handler extends handler.dockingstation.DockingStationHandler
    {
        public function RCDS2011Handler(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            return;
        }

        protected function decodeUnitInformation(arg1:Object):core.units.Unit
        {
            var loc6:*=arg1 as Array;
            var loc5:*=0;
            var loc13:*;
            if ((loc13 = loc6[2] & 63) == 1) 
            {
                _myUnit = new core.units.UnitRC1411();
            }
            if (_myUnit == null) 
            {
                return null;
            }
            var loc11:*;
            var loc2:*=((loc11 = loc6[0]) & 240) >> 4;
            var loc3:*=loc11 & 15;
            var loc1:*=loc2.toString() + loc3.toString();
            var loc12:*;
            var loc10:*=((loc12 = loc6[1]) & 240) >> 4;
            var loc7:*=loc12 & 15;
            var loc4:*=loc10.toString() + loc7.toString();
            _myUnit.softwareRevision = loc4;
            var loc15:*=parseInt(loc6[3]);
            var loc9:*=0;
            loc5 = 0;
            while (loc5 < 3) 
            {
                loc9 = loc9 + loc6[loc5];
                ++loc5;
            }
            if ((loc9 = loc9 & 255) != loc15) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 10100, "RC2011Decoder > decodeUnitInformation: incorrect checksum2"));
                _myUnit = null;
                return null;
            }
            var loc14:*="14112011";
            var loc8:*="";
            loc5 = 7;
            while (loc5 > 3) 
            {
                loc8 = loc8 + loc6[loc5].toString(16);
                --loc5;
            }
            if (loc8 != loc14) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 10101, "RC2011Decoder > decodeUnitInformation: incorrect checksum1"));
                _myUnit = null;
                return null;
            }
            return _myUnit;
        }

        protected function decodeSerialNumberInformation(arg1:Object):core.units.Unit
        {
            if (_myUnit == null) 
            {
                return null;
            }
            var loc7:*=arg1 as Array;
            var loc6:*=0;
            var loc8:*=0;
            loc8 = (loc8 = (loc8 = (loc8 = loc7[2] << 16) | loc7[1] << 8) | loc7[0]) >> 1;
            _myUnit.serialNumber = loc8.toString();
            var loc12:*;
            var loc2:*=(loc12 = loc7[0] & 1) != 1 ? false : true;
            var loc4:*=loc7[5];
            var loc11:*=loc7[4];
            var loc14:*=loc7[3];
            var loc5:*=new Date("20" + loc4, (loc11 - 1), loc14);
            _myUnit.dateCode = loc5;
            var loc10:*=(loc7[6] & 128) >> 7;
            var loc1:*=(loc7[6] & 64) >> 6;
            var loc15:*=loc7[7];
            var loc9:*=0;
            loc6 = 0;
            while (loc6 < 7) 
            {
                loc9 = loc9 + loc7[loc6];
                ++loc6;
            }
            if ((loc9 = loc9 & 255) != loc15) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 10102, "RC2011Decoder > decodeSerialNumberInformation: incorrect checksum2"));
                _myUnit = null;
                return null;
            }
            var loc3:*="15122112";
            var loc13:*="";
            loc6 = 11;
            while (loc6 > 7) 
            {
                loc13 = loc13 + loc7[loc6].toString(16);
                --loc6;
            }
            if (loc13 != loc3) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 10103, "RC2011Decoder > decodeSerialNumberInformation: incorrect checksum5"));
                _myUnit = null;
                return null;
            }
            return _myUnit;
        }

        public override function scanDockingStation():void
        {
            addEventListener("unitConnectedEvent", onUnitConnected, false, 0, true);
            loadFromDC("checkUnitConnected");
            return;
        }

        protected function onUnitConnected(arg1:flash.events.Event):void
        {
            if (!_unitInitialised) 
            {
                loadFromDC("loadUnitInformation");
            }
            return;
        }

        public override function destructor():void
        {
            super.destructor();
            removeEventListener("unitConnectedEvent", onUnitConnected);
            service.DeviceCommunicationHandler.getInstance().removeEventListener("usbComplete", onLoaded);
            return;
        }

        internal function onLoaded(arg1:service.usb.event.DeviceDataCompleteEvent):void
        {
            var loc2:*=null;
            var loc4:*=NaN;
            var loc1:*=null;
            var loc3:*=null;
            service.DeviceCommunicationHandler.getInstance().removeEventListener("usbComplete", onLoaded, false);
            if (!(arg1.command == 231.toString() && arg1.startAdress == "E0FF00")) 
            {
                if (arg1.command != 255.toString()) 
                {
                    if (arg1.startAdress == "E0FF00") 
                    {
                        if (readDataSuccess([arg1.data[arg1.data.length - 2], arg1.data[(arg1.data.length - 1)]])) 
                        {
                            loc2 = arg1.data.slice(16, 16 + 8);
                            if ((loc3 = decodeUnitInformation(loc2) as core.units.UnitRC2011) != null) 
                            {
                                loc2 = arg1.data.slice(0, 12);
                                loc3 = decodeSerialNumberInformation(loc2) as core.units.UnitRC2011;
                            }
                            if (loc3 == null) 
                            {
                                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 109, "RC2011Decoder > decodeUnitInformation: Unit not in silence mode"));
                            }
                            else 
                            {
                                _unitInitialised = true;
                                dispatchEvent(new handler.event.UnitEvent("unitInitialisedEvent", loc3));
                            }
                        }
                        else 
                        {
                            repeatReadCommand("loadUnitInformation");
                            return;
                        }
                    }
                }
                else 
                {
                    if (!scanDockingStationStopped) 
                    {
                        _scanDocingstationTimeOutId = flash.utils.setTimeout(loadFromDC, _scanDockingStationInterval, "checkUnitConnected");
                    }
                    resetCheckConnectionTimeOut();
                    if ((loc4 = arg1.data.toString()) != 1) 
                    {
                        _unitInitialised = false;
                        loc1 = new flash.events.Event("unitDisconnectedEvent");
                        dispatchEvent(loc1);
                    }
                    else 
                    {
                        loc1 = new flash.events.Event("unitConnectedEvent");
                        dispatchEvent(loc1);
                    }
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
            if (arg1 != "checkUnitConnected") 
            {
                if (arg1 == "loadUnitInformation") 
                {
                    currentCommand = 232;
                    currentBytesToReceive = 24;
                    currentReceiveChecksumLength = 2;
                    currentStartAdrr = "E0FF00";
                }
            }
            else 
            {
                currentCommand = 255;
                currentBytesToReceive = 1;
                currentReceiveChecksumLength = 0;
                currentStartAdrr = "";
                _checkConnectionTimeOutId = flash.utils.setTimeout(checkConnectionTimeout, connectionTimeoutInterval);
            }
            service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBuffer(currentCommand, currentStartAdrr, currentBytesToReceive, null), this);
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
                loc10.writeByte(0);
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
                service.DeviceCommunicationHandler.getInstance().processNextCommandFromQueue();
            }
            return;
        }

        public static const SN_INFO_STARTADDRESS:String="E0FF00";

        public static const SN_INFO_TOTAL_SIZE:uint=16;

        public static const UNIT_CONNECTED_COMMAND:uint=255;

        public static const UNIT_CONNECTED_COMMAND_BYTES_TO_RECEIVE:uint=1;

        public static const GET_INITIAL_AND_SN_INFO:uint=232;

        public static const GET_INITIAL_AND_SN_INFO_BYTES_TO_RECEIVE:uint=24;

        public static const GET_INITIAL_INFO:uint=232;

        public static const GET_INITIAL_INFO_BYTES_TO_RECEIVE:uint=8;

        public static const GET_SN_INFO:uint=232;

        public static const GET_SN_INFO_BYTES_TO_RECEIVE:uint=12;

        public static const INITIAL_AND_SN_INFO_ENDADDRESS:String="FFFF00";

        public static const INITIAL_AND_SN_INFO_STARTADDRESS:String="E0FF00";

        public static const INITIAL_INFO_ENDADDRESS:String="FFFF00";

        public static const INITIAL_INFO_STARTADDRESS:String="F0FF00";

        public static const INITIAL_INFO_TOTAL_SIZE:uint=16;

        public static const SET_INITIAL_INFO:uint=231;

        public static const SET_SN_INFO:uint=231;

        public static const SET_SN_INFO_BYTES_TO_RECEIVE:uint=2;

        public static const SN_INFO_ENDADDRESS:String="EFFF00";

        internal var _myUnit:core.units.UnitRC2011;

        internal var _readErrorRepeats:int=0;

        internal var _repeatsOnError:int=1;

        internal var _scanDockingStationInterval:uint=1000;
    }
}


//  class Rox100DSHandler
package handler.dockingstation 
{
    import com.hurlant.util.*;
    import com.logging.*;
    import core.units.*;
    import decoder.*;
    import flash.events.*;
    import flash.utils.*;
    import handler.event.*;
    import service.*;
    import service.usb.event.*;
    
    public class Rox100DSHandler extends handler.dockingstation.DockingStationHandler
    {
        public function Rox100DSHandler(arg1:flash.events.IEventDispatcher=null)
        {
            super();
            connectionTimeoutInterval = 1000;
            return;
        }

        public override function destructor():void
        {
            super.destructor();
            removeEventListener("unitConnectedEvent", onUnitConnected);
            service.DeviceCommunicationHandler.getInstance().removeEventListener("usbComplete", onLoaded);
            return;
        }

        public override function stopScanDockingStation():void
        {
            super.stopScanDockingStation();
            return;
        }

        public override function startScanDockingStation():void
        {
            super.startScanDockingStation();
            _scanDockingStationId = flash.utils.setTimeout(loadFromDC, _scanDockingStationInterval, "checkUnitConnected");
            return;
        }

        internal function onLoaded(arg1:service.usb.event.DeviceDataCompleteEvent):void
        {
            var loc2:*=null;
            var loc1:*=null;
            service.DeviceCommunicationHandler.getInstance().removeEventListener("usbComplete", onLoaded, false);
            if (arg1.command != "2 0 1 17 16".toString()) 
            {
                if (arg1.command == "2 0 1 133 132") 
                {
                    if (!_unitInitialised) 
                    {
                        loc1 = decodeUnitInformation(arg1.data) as core.units.Unit;
                        if (loc1 == null) 
                        {
                            dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 118, "RC2011Handler > onLoaded: usb service, read failed!"));
                        }
                        else 
                        {
                            unitInitialised = true;
                            decoder.Rox100Decoder.getInstance().unit = loc1;
                            dispatchEvent(new handler.event.UnitEvent("unitInitialisedEvent", loc1));
                        }
                    }
                    return;
                }
            }
            else 
            {
                if (!scanDockingStationStopped) 
                {
                    _scanDockingStationId = flash.utils.setTimeout(loadFromDC, _scanDockingStationInterval, "checkUnitConnected");
                }
                resetCheckConnectionTimeOut();
                if (arg1.data.length == 4 && arg1.data[0] == 17) 
                {
                    loc2 = new flash.events.Event("unitConnectedEvent");
                    dispatchEvent(loc2);
                }
                else 
                {
                    unitInitialised = false;
                    loc2 = new flash.events.Event("unitDisconnectedEvent");
                    dispatchEvent(loc2);
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
            if (arg1 != "checkUnitConnected") 
            {
                if (arg1 != "loadUnitInformation") 
                {
                    return;
                }
                else 
                {
                    currentCommand = "2 0 1 133 132";
                    currentBytesToReceive = 66;
                }
            }
            else 
            {
                currentCommand = "2 0 1 17 16";
                currentBytesToReceive = 4;
                _checkConnectionTimeOutId = flash.utils.setTimeout(checkConnectionTimeout, connectionTimeoutInterval);
            }
            service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBuffer(currentCommand), this);
            return;
        }

        protected function generateNativeProzessBuffer(arg1:String, arg2:Array=null):flash.utils.ByteArray
        {
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=new flash.utils.ByteArray();
            var loc5:*;
            var loc1:*=(loc5 = arg1.split(" ")).length;
            loc2 = 0;
            while (loc2 < loc1) 
            {
                loc4.writeByte(loc5[loc2]);
                ++loc2;
            }
            if (arg2 != null) 
            {
                loc3 = 0;
                while (loc3 < arg2.length) 
                {
                    loc4.writeByte(arg2[loc3]);
                    ++loc3;
                }
            }
            return loc4;
        }

        internal function decodeUnitInformation(arg1:Object):core.units.Unit
        {
            var loc5:*=arg1 as Array;
            if (!decoder.Rox100Decoder.isValidCheckSum(loc5)) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 511, "ROX100DSHandler > decodeUnitInformation: wrong crc"));
                return null;
            }
            loc5.splice(0, 3);
            loc5.pop();
            var loc8:*=0;
            var loc2:*=new core.units.UnitROX100();
            var loc6:*=26;
            var loc3:*=12;
            loc8 = loc6;
            while (loc8 < loc6 + loc3) 
            {
                loc2.serialNumber = loc2.serialNumber + com.hurlant.util.Hex.toString(loc5[loc8].toString(16));
                ++loc8;
            }
            var loc1:*=42;
            var loc4:*=17;
            loc8 = loc1;
            while (loc8 < loc1 + loc4) 
            {
                loc2.softwareRevision = loc2.softwareRevision + com.hurlant.util.Hex.toString(loc5[loc8].toString(16));
                ++loc8;
            }
            var loc7:*=0;
            loc7 = (loc7 = (loc7 = loc5[60]) | loc5[61] << 8) / 10;
            loc2.memoryMapVersion = loc7.toString();
            return loc2;
        }

        public override function scanDockingStation():void
        {
            addEventListener("unitConnectedEvent", onUnitConnected);
            loadFromDC("checkUnitConnected");
            return;
        }

        protected function onUnitConnected(arg1:flash.events.Event):void
        {
            if (!unitInitialised) 
            {
                loadFromDC("loadUnitInformation");
            }
            return;
        }

        public static const LOAD_INITIALINFORMATION_BYTES_TO_RECEIVE:uint=66;

        public static const LOAD_INITIALINFORMATION_COMMAND:String="2 0 1 133 132";

        public static const UNIT_CONNECTED_BYTES_TO_RECEIVE:uint=4;

        public static const UNIT_CONNECTED_COMMAND:String="2 0 1 17 16";

        internal var _scanDockingStationId:uint=0;

        internal var _scanDockingStationInterval:uint=2000;
    }
}


//  class Rox110DSHandler
package handler.dockingstation 
{
    import com.hurlant.util.*;
    import com.logging.*;
    import core.units.*;
    import core.units.interfaces.*;
    import debug.*;
    import decoder.*;
    import flash.events.*;
    import flash.utils.*;
    import handler.event.*;
    import service.*;
    import service.usb.event.*;
    
    public class Rox110DSHandler extends handler.dockingstation.DockingStationHandler
    {
        public function Rox110DSHandler(arg1:flash.events.IEventDispatcher=null)
        {
            super();
            connectionTimeoutInterval = 1000;
            return;
        }

        public override function destructor():void
        {
            super.destructor();
            removeEventListener("unitConnectedEvent", onUnitConnected);
            service.DeviceCommunicationHandler.getInstance().removeEventListener("usbComplete", onLoaded);
            return;
        }

        public override function stopScanDockingStation():void
        {
            super.stopScanDockingStation();
            return;
        }

        public override function startScanDockingStation():void
        {
            super.startScanDockingStation();
            _scanDockingStationId = flash.utils.setTimeout(loadFromDC, _scanDockingStationInterval, "checkUnitConnected");
            return;
        }

        internal function onLoaded(arg1:service.usb.event.DeviceDataCompleteEvent):void
        {
            var loc2:*=null;
            var loc1:*=null;
            debug.Debug.debug("[onLoaded] " + arg1.command);
            service.DeviceCommunicationHandler.getInstance().removeEventListener("usbComplete", onLoaded, false);
            if (arg1.command != "2 0 1 17 16") 
            {
                if (arg1.command == "2 0 1 133 132") 
                {
                    if (!unitInitialised) 
                    {
                        loc1 = decodeUnitInformation(arg1.data) as core.units.Unit;
                        if (loc1 == null) 
                        {
                            dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 118, "RC2011Handler > onLoaded: usb service, read failed!"));
                        }
                        else 
                        {
                            unitInitialised = true;
                            decoder.Rox110Decoder.getInstance().unit = loc1;
                            (loc1 as core.units.interfaces.IBLEDeviceInfo).deviceID = port;
                            dispatchEvent(new handler.event.UnitEvent("unitInitialisedEvent", loc1));
                        }
                    }
                    return;
                }
            }
            else 
            {
                if (!scanDockingStationStopped) 
                {
                    _scanDockingStationId = flash.utils.setTimeout(loadFromDC, _scanDockingStationInterval, "checkUnitConnected");
                }
                resetCheckConnectionTimeOut();
                if (arg1.data.length == 4 && arg1.data[0] == 17) 
                {
                    loc2 = new flash.events.Event("unitConnectedEvent");
                    dispatchEvent(loc2);
                }
                else 
                {
                    unitInitialised = false;
                    loc2 = new flash.events.Event("unitDisconnectedEvent");
                    dispatchEvent(loc2);
                }
            }
            service.DeviceCommunicationHandler.getInstance().processNextCommandFromQueue();
            return;
        }

        public override function loadFromDC(arg1:String):void
        {
            debug.Debug.debug("[loadFromDC] " + arg1);
            if (service.DeviceCommunicationHandler.getInstance().nativeProcessIsBusy) 
            {
                debug.Debug.debug("nativeProcessIsBusy");
                service.DeviceCommunicationHandler.getInstance().addToCommandQueue(arg1, "loadCommand", this);
                return;
            }
            service.DeviceCommunicationHandler.getInstance().addEventListener("usbComplete", onLoaded, false, 0, false);
            if (arg1 != "checkUnitConnected") 
            {
                if (arg1 != "loadUnitInformation") 
                {
                    debug.Debug.error("UNKNOWN COMMAND IN [loadFromDC]");
                    service.DeviceCommunicationHandler.getInstance().removeEventListener("usbComplete", onLoaded);
                    return;
                }
                else 
                {
                    currentCommand = "2 0 1 133 132";
                    currentBytesToReceive = 120;
                }
            }
            else 
            {
                currentCommand = "2 0 1 17 16";
                currentBytesToReceive = 4;
                _checkConnectionTimeOutId = flash.utils.setTimeout(checkConnectionTimeout, connectionTimeoutInterval);
            }
            service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBuffer(currentCommand), this);
            return;
        }

        protected function generateNativeProzessBuffer(arg1:String, arg2:Array=null):flash.utils.ByteArray
        {
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=new flash.utils.ByteArray();
            var loc5:*;
            var loc1:*=(loc5 = arg1.split(" ")).length;
            loc2 = 0;
            while (loc2 < loc1) 
            {
                loc4.writeByte(loc5[loc2]);
                ++loc2;
            }
            if (arg2 != null) 
            {
                loc3 = 0;
                while (loc3 < arg2.length) 
                {
                    loc4.writeByte(arg2[loc3]);
                    ++loc3;
                }
            }
            return loc4;
        }

        internal function decodeUnitInformation(arg1:Object):core.units.Unit
        {
            var loc6:*=arg1 as Array;
            if (!decoder.Rox70Decoder.isValidCheckSum(loc6)) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 533, "ROX100DSHandler > decodeUnitInformation: wrong crc"));
                return null;
            }
            loc6.splice(0, 3);
            loc6.pop();
            var loc10:*=0;
            var loc2:*=new core.units.UnitROX110();
            var loc7:*=21;
            var loc3:*=11;
            loc10 = loc7;
            while (loc10 < loc7 + loc3) 
            {
                loc2.serialNumber = loc2.serialNumber + com.hurlant.util.Hex.toString(loc6[loc10].toString(16));
                ++loc10;
            }
            var loc1:*=70;
            var loc4:*=17;
            loc10 = loc1;
            while (loc10 < loc1 + loc4) 
            {
                loc2.softwareRevision = loc2.softwareRevision + com.hurlant.util.Hex.toString(loc6[loc10].toString(16));
                ++loc10;
            }
            var loc5:*=87;
            var loc8:*=17;
            loc10 = loc5;
            while (loc10 < loc5 + loc8) 
            {
                loc2.bleFirmwareVersion = loc2.bleFirmwareVersion + com.hurlant.util.Hex.toString(loc6[loc10].toString(16));
                ++loc10;
            }
            var loc9:*=0;
            loc9 = (loc9 = (loc9 = loc6[104]) | loc6[105] << 8) / 10;
            loc2.memoryMapVersion = loc9.toString();
            return loc2;
        }

        public override function scanDockingStation():void
        {
            addEventListener("unitConnectedEvent", onUnitConnected);
            loadFromDC("checkUnitConnected");
            return;
        }

        protected function onUnitConnected(arg1:flash.events.Event):void
        {
            if (!unitInitialised) 
            {
                loadFromDC("loadUnitInformation");
            }
            return;
        }

        public static const LOAD_INITIALINFORMATION_BYTES_TO_RECEIVE:uint=120;

        public static const LOAD_INITIALINFORMATION_COMMAND:String="2 0 1 133 132";

        public static const UNIT_CONNECTED_BYTES_TO_RECEIVE:uint=4;

        public static const UNIT_CONNECTED_COMMAND:String="2 0 1 17 16";

        internal var _scanDockingStationId:uint=0;

        internal var _scanDockingStationInterval:uint=2000;
    }
}


//  class Rox70DSHandler
package handler.dockingstation 
{
    import com.hurlant.util.*;
    import com.logging.*;
    import core.units.*;
    import decoder.*;
    import flash.events.*;
    import flash.utils.*;
    import handler.event.*;
    import service.*;
    import service.usb.event.*;
    
    public class Rox70DSHandler extends handler.dockingstation.DockingStationHandler
    {
        public function Rox70DSHandler(arg1:flash.events.IEventDispatcher=null)
        {
            super();
            connectionTimeoutInterval = 1000;
            return;
        }

        public override function destructor():void
        {
            super.destructor();
            removeEventListener("unitConnectedEvent", onUnitConnected);
            service.DeviceCommunicationHandler.getInstance().removeEventListener("usbComplete", onLoaded);
            return;
        }

        public override function stopScanDockingStation():void
        {
            super.stopScanDockingStation();
            return;
        }

        public override function startScanDockingStation():void
        {
            super.startScanDockingStation();
            _scanDockingStationId = flash.utils.setTimeout(loadFromDC, _scanDockingStationInterval, "checkUnitConnected");
            return;
        }

        internal function onLoaded(arg1:service.usb.event.DeviceDataCompleteEvent):void
        {
            var loc2:*=null;
            var loc1:*=null;
            service.DeviceCommunicationHandler.getInstance().removeEventListener("usbComplete", onLoaded, false);
            if (arg1.command != "2 0 1 17 16".toString()) 
            {
                if (arg1.command == "2 0 1 133 132") 
                {
                    if (!_unitInitialised) 
                    {
                        loc1 = decodeUnitInformation(arg1.data) as core.units.Unit;
                        if (loc1 == null) 
                        {
                            dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 118, "RC2011Handler > onLoaded: usb service, read failed!"));
                        }
                        else 
                        {
                            unitInitialised = true;
                            decoder.Rox70Decoder.getInstance().unit = loc1;
                            dispatchEvent(new handler.event.UnitEvent("unitInitialisedEvent", loc1));
                        }
                    }
                    return;
                }
            }
            else 
            {
                if (!scanDockingStationStopped) 
                {
                    _scanDockingStationId = flash.utils.setTimeout(loadFromDC, _scanDockingStationInterval, "checkUnitConnected");
                }
                resetCheckConnectionTimeOut();
                if (arg1.data.length == 4 && arg1.data[0] == 17) 
                {
                    loc2 = new flash.events.Event("unitConnectedEvent");
                    dispatchEvent(loc2);
                }
                else 
                {
                    unitInitialised = false;
                    loc2 = new flash.events.Event("unitDisconnectedEvent");
                    dispatchEvent(loc2);
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
            if (arg1 != "checkUnitConnected") 
            {
                if (arg1 != "loadUnitInformation") 
                {
                    service.DeviceCommunicationHandler.getInstance().removeEventListener("usbComplete", onLoaded);
                    return;
                }
                else 
                {
                    currentCommand = "2 0 1 133 132";
                    currentBytesToReceive = 120;
                }
            }
            else 
            {
                currentCommand = "2 0 1 17 16";
                currentBytesToReceive = 4;
                _checkConnectionTimeOutId = flash.utils.setTimeout(checkConnectionTimeout, connectionTimeoutInterval);
            }
            service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBuffer(currentCommand), this);
            return;
        }

        protected function generateNativeProzessBuffer(arg1:String, arg2:Array=null):flash.utils.ByteArray
        {
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=new flash.utils.ByteArray();
            var loc5:*;
            var loc1:*=(loc5 = arg1.split(" ")).length;
            loc2 = 0;
            while (loc2 < loc1) 
            {
                loc4.writeByte(loc5[loc2]);
                ++loc2;
            }
            if (arg2 != null) 
            {
                loc3 = 0;
                while (loc3 < arg2.length) 
                {
                    loc4.writeByte(arg2[loc3]);
                    ++loc3;
                }
            }
            return loc4;
        }

        internal function decodeUnitInformation(arg1:Object):core.units.Unit
        {
            var loc5:*=arg1 as Array;
            if (!decoder.Rox70Decoder.isValidCheckSum(loc5)) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 533, "ROX100DSHandler > decodeUnitInformation: wrong crc"));
                return null;
            }
            loc5.splice(0, 3);
            loc5.pop();
            var loc8:*=0;
            var loc2:*=new core.units.UnitROX70();
            var loc6:*=21;
            var loc3:*=11;
            loc8 = loc6;
            while (loc8 < loc6 + loc3) 
            {
                loc2.serialNumber = loc2.serialNumber + com.hurlant.util.Hex.toString(loc5[loc8].toString(16));
                ++loc8;
            }
            var loc1:*=70;
            var loc4:*=17;
            loc8 = loc1;
            while (loc8 < loc1 + loc4) 
            {
                loc2.softwareRevision = loc2.softwareRevision + com.hurlant.util.Hex.toString(loc5[loc8].toString(16));
                ++loc8;
            }
            var loc7:*=0;
            loc7 = (loc7 = (loc7 = loc5[104]) | loc5[105] << 8) / 10;
            loc2.memoryMapVersion = loc7.toString();
            return loc2;
        }

        public override function scanDockingStation():void
        {
            addEventListener("unitConnectedEvent", onUnitConnected);
            loadFromDC("checkUnitConnected");
            return;
        }

        protected function onUnitConnected(arg1:flash.events.Event):void
        {
            if (!unitInitialised) 
            {
                loadFromDC("loadUnitInformation");
            }
            return;
        }

        public static const LOAD_INITIALINFORMATION_BYTES_TO_RECEIVE:uint=120;

        public static const LOAD_INITIALINFORMATION_COMMAND:String="2 0 1 133 132";

        public static const UNIT_CONNECTED_BYTES_TO_RECEIVE:uint=4;

        public static const UNIT_CONNECTED_COMMAND:String="2 0 1 17 16";

        internal var _scanDockingStationId:uint=0;

        internal var _scanDockingStationInterval:uint=2000;
    }
}


//  class RoxDS2008Handler
package handler.dockingstation 
{
    import com.logging.*;
    import core.units.*;
    import flash.events.*;
    import flash.utils.*;
    import handler.event.*;
    import service.*;
    import service.usb.event.*;
    
    public class RoxDS2008Handler extends handler.dockingstation.DockingStationHandler
    {
        public function RoxDS2008Handler()
        {
            super();
            return;
        }

        public override function destructor():void
        {
            super.destructor();
            removeEventListener("unitConnectedEvent", onUnitConnected);
            service.DeviceCommunicationHandler.getInstance().removeEventListener("usbComplete", onLoaded);
            return;
        }

        internal function onLoaded(arg1:service.usb.event.DeviceDataCompleteEvent):void
        {
            var loc2:*=null;
            var loc1:*=null;
            service.DeviceCommunicationHandler.getInstance().removeEventListener("usbComplete", onLoaded);
            if (arg1.command != 114.toString()) 
            {
                if (arg1.command == 70.toString()) 
                {
                    loc1 = decodeUnitInformation(arg1.data) as core.units.UnitROX;
                    if (loc1 == null) 
                    {
                        dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 118, "RC2011Handler > onLoaded: usb service, read failed!"));
                    }
                    else 
                    {
                        _unitInitialised = true;
                        dispatchEvent(new handler.event.UnitEvent("unitInitialisedEvent", loc1));
                    }
                }
            }
            else 
            {
                if (!scanDockingStationStopped) 
                {
                    _scanDocingstationTimeOutId = flash.utils.setTimeout(loadFromDC, _scanDockingStationInterval, "checkUnitConnected");
                }
                resetCheckConnectionTimeOut();
                if (arg1.data[0] != 17) 
                {
                    if (arg1.data[0] != 16) 
                    {
                        _unitInitialised = false;
                        loc2 = new flash.events.Event("unitDisconnectedEvent");
                        dispatchEvent(loc2);
                    }
                    else 
                    {
                        dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 123, "ROX on wrong menu"));
                    }
                }
                else 
                {
                    loc2 = new flash.events.Event("unitConnectedEvent");
                    dispatchEvent(loc2);
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
            service.DeviceCommunicationHandler.getInstance().addEventListener("usbComplete", onLoaded);
            if (arg1 != "checkUnitConnected") 
            {
                if (arg1 == "loadUnitInformation") 
                {
                    currentCommand = 70;
                    currentBytesToReceive = 16;
                }
            }
            else 
            {
                currentCommand = 114;
                currentBytesToReceive = 1;
                _checkConnectionTimeOutId = flash.utils.setTimeout(checkConnectionTimeout, connectionTimeoutInterval);
            }
            service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBuffer(currentCommand), this);
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

        internal function decodeUnitInformation(arg1:Object):core.units.Unit
        {
            var loc1:*=null;
            var loc34:*=NaN;
            var loc8:*=false;
            var loc9:*=arg1 as Array;
            var loc10:*=0;
            loc34 = 0;
            while (loc34 < 11) 
            {
                loc10 = loc10 + loc9[loc34];
                ++loc34;
            }
            loc10 = loc10 & 255;
            var loc28:*=parseInt(loc9[11]);
            var loc16:*=0;
            loc16 = (loc16 = (loc16 = loc9[2] << 16) | loc9[1] << 8) | loc9[0];
            var loc31:*=0;
            var loc12:*;
            if ((loc12 = (loc9[2] & 128) >> 7) != 0) 
            {
                if (loc12 == 1) 
                {
                    loc1 = new core.units.UnitROX9();
                    loc31 = loc16 - 9437184 + 90000000;
                }
            }
            else 
            {
                loc1 = new core.units.UnitROX8();
                loc31 = loc16 - 1048576 + 10000000;
            }
            loc1.serialNumber = loc31.toString();
            var loc4:*=(loc9[5] & 240) >> 4;
            var loc25:*=loc9[5] & 15;
            var loc29:*=(loc9[4] & 240) >> 4;
            var loc32:*=loc9[4] & 15;
            var loc6:*=(loc9[3] & 240) >> 4;
            var loc3:*=loc9[3] & 15;
            var loc21:*=loc6.toString(10) + loc3.toString(10);
            var loc39:*=loc29.toString(10) + loc32.toString(10);
            var loc5:*=loc4.toString(10) + loc25.toString(10);
            var loc33:*=new Date(parseInt("20" + loc5), (parseInt(loc39) - 1), parseInt(loc21));
            loc1.dateCode = loc33;
            var loc13:*;
            var loc17:*=(loc13 = parseInt(loc9[9])) & 15;
            var loc38:*=(loc9[8] & 240) >> 4;
            var loc37:*=loc9[8] & 15;
            var loc11:*=(loc9[7] & 240) >> 4;
            var loc14:*=loc9[7] & 15;
            var loc36:*=(loc9[6] & 240) >> 4;
            var loc35:*=loc9[6] & 15;
            var loc30:*=(loc30 = (loc30 = (loc30 = loc17.toString(16)) + (loc38.toString(16) + loc37.toString(16))) + (loc11.toString(16) + loc14.toString(16))) + (loc36.toString(16) + loc35.toString(16));
            loc1.maskingCode = loc30;
            var loc20:*;
            var loc18:*;
            var loc2:*=(loc18 = ((loc20 = parseInt(loc9[9])) & 240) >> 4).toString(16);
            loc1.initialWakeUpInfo = loc2;
            var loc40:*;
            var loc19:*=((loc40 = loc9[10]) & 240) >> 4;
            var loc15:*=loc40 & 15;
            var loc7:*=loc19.toString() + "." + loc15.toString();
            loc1.softwareRevision = loc7;
            var loc22:*=loc9[15].toString(16).toUpperCase();
            var loc24:*=loc9[14].toString(16).toUpperCase();
            var loc23:*=loc9[13].toString(16).toUpperCase();
            var loc26:*=loc9[12].toString(16).toUpperCase();
            var loc27:*;
            if ((loc27 = loc22 + loc24 + loc23 + loc26) != "359474D4") 
            {
                if (loc27 != "46A585E5") 
                {
                    dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 10120, "ROXDecoder > decodeUnitInformation: incorrect checksum1"));
                }
                else 
                {
                    dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 10122, "ROXDecoder > decodeUnitInformation: ROX 8.1 / 9.1 on DS 2008 is not supported"));
                }
                return null;
            }
            if (!loc8) 
            {
            };
            return loc1;
        }

        public override function scanDockingStation():void
        {
            addEventListener("unitConnectedEvent", onUnitConnected);
            loadFromDC("checkUnitConnected");
            return;
        }

        protected function onUnitConnected(arg1:flash.events.Event):void
        {
            if (!_unitInitialised) 
            {
                loadFromDC("loadUnitInformation");
            }
            return;
        }

        public static const LOAD_INITIALINFORMATION_BYTES_TO_RECEIVE:uint=16;

        public static const LOAD_INITIALINFORMATION_COMMAND:uint=70;

        public static const ROX_COMMAND_VALUE:uint=255;

        public static const UNIT_CONNECTED_COMMAND:uint=114;

        internal var _scanDockingStationInterval:uint=1000;
    }
}


//  class RoxDS2010Handler
package handler.dockingstation 
{
    import com.logging.*;
    import core.units.*;
    import core.units.interfaces.*;
    import flash.events.*;
    import flash.utils.*;
    import handler.event.*;
    import service.*;
    import service.usb.event.*;
    
    public class RoxDS2010Handler extends handler.dockingstation.DockingStationHandler
    {
        public function RoxDS2010Handler(arg1:flash.events.IEventDispatcher=null)
        {
            super();
            return;
        }

        public override function destructor():void
        {
            super.destructor();
            removeEventListener("unitConnectedEvent", onUnitConnected);
            service.DeviceCommunicationHandler.getInstance().removeEventListener("usbComplete", onLoaded);
            return;
        }

        internal function onLoaded(arg1:service.usb.event.DeviceDataCompleteEvent):void
        {
            var loc2:*=null;
            var loc1:*=null;
            service.DeviceCommunicationHandler.getInstance().removeEventListener("usbComplete", onLoaded, false);
            if (arg1.command != 114.toString()) 
            {
                if (arg1.command == 70.toString()) 
                {
                    loc1 = decodeUnitInformation(arg1.data) as core.units.Unit;
                    if (loc1 == null) 
                    {
                        dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 118, "RC2011Handler > onLoaded: usb service, read failed!"));
                    }
                    else 
                    {
                        _unitInitialised = true;
                        dispatchEvent(new handler.event.UnitEvent("unitInitialisedEvent", loc1));
                    }
                }
            }
            else 
            {
                if (!scanDockingStationStopped) 
                {
                    _scanDocingstationTimeOutId = flash.utils.setTimeout(loadFromDC, _scanDockingStationInterval, "checkUnitConnected");
                }
                resetCheckConnectionTimeOut();
                if (arg1.data[0] != 17) 
                {
                    if (arg1.data[0] != 16) 
                    {
                        _unitInitialised = false;
                        loc2 = new flash.events.Event("unitDisconnectedEvent");
                        dispatchEvent(loc2);
                    }
                    else 
                    {
                        dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 123, "ROX on wrong menu"));
                    }
                }
                else 
                {
                    loc2 = new flash.events.Event("unitConnectedEvent");
                    dispatchEvent(loc2);
                }
            }
            service.DeviceCommunicationHandler.getInstance().processNextCommandFromQueue();
            return;
        }

        public override function loadFromDC(arg1:String):void
        {
            var loc1:*=service.DeviceCommunicationHandler.getInstance();
            if (loc1.nativeProcessIsBusy) 
            {
                loc1.addToCommandQueue(arg1, "loadCommand", this);
                return;
            }
            service.DeviceCommunicationHandler.getInstance().addEventListener("usbComplete", onLoaded, false, 0, false);
            if (arg1 != "checkUnitConnected") 
            {
                if (arg1 == "loadUnitInformation") 
                {
                    currentCommand = 70;
                    currentBytesToReceive = 16;
                }
            }
            else 
            {
                currentCommand = 114;
                currentBytesToReceive = 1;
                _checkConnectionTimeOutId = flash.utils.setTimeout(checkConnectionTimeout, connectionTimeoutInterval);
            }
            service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBuffer(currentCommand), this);
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

        internal function decodeUnitInformation(arg1:Object):core.units.Unit
        {
            var loc1:*=null;
            var loc33:*=NaN;
            var loc8:*=true;
            var loc9:*=arg1 as Array;
            var loc15:*=0;
            loc15 = (loc15 = (loc15 = loc9[2] << 16) | loc9[1] << 8) | loc9[0];
            var loc20:*=loc9[15].toString(16).toUpperCase();
            var loc23:*=loc9[14].toString(16).toUpperCase();
            var loc22:*=loc9[13].toString(16).toUpperCase();
            var loc25:*=loc9[12].toString(16).toUpperCase();
            var loc26:*=loc20 + loc23 + loc22 + loc25;
            var loc30:*=0;
            var loc11:*=(loc9[2] & 128) >> 7;
            if (loc26 != "46A585E5") 
            {
                if (loc26 != "359474D4") 
                {
                    dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 10118, "ROX2010Decoder > decodeUnitInformation: incorrect checksum1"));
                }
                else if (loc11 != 0) 
                {
                    if (loc11 == 1) 
                    {
                        loc1 = new core.units.UnitROX9();
                        loc30 = loc15 - 9437184 + 90000000;
                    }
                }
                else 
                {
                    loc1 = new core.units.UnitROX8();
                    loc30 = loc15 - 1048576 + 10000000;
                }
            }
            else if (loc11 != 0) 
            {
                loc1 = new core.units.UnitROX91();
                loc30 = loc15 - 9437184 + 90000000;
            }
            else 
            {
                loc1 = new core.units.UnitROX81();
                loc30 = loc15 - 1048576 + 10000000;
            }
            loc1.serialNumber = loc30.toString();
            var loc4:*=(loc9[5] & 240) >> 4;
            var loc24:*=loc9[5] & 15;
            var loc28:*=(loc9[4] & 240) >> 4;
            var loc31:*=loc9[4] & 15;
            var loc6:*=(loc9[3] & 240) >> 4;
            var loc3:*=loc9[3] & 15;
            var loc21:*=loc6.toString(10) + loc3.toString(10);
            var loc39:*=loc28.toString(10) + loc31.toString(10);
            var loc5:*=loc4.toString(10) + loc24.toString(10);
            var loc32:*=new Date(parseInt("20" + loc5), (parseInt(loc39) - 1), parseInt(loc21));
            (loc1 as core.units.interfaces.IDateCode).dateCode = loc32;
            var loc12:*;
            var loc16:*=(loc12 = parseInt(loc9[9])) & 15;
            var loc37:*=(loc9[8] & 240) >> 4;
            var loc36:*=loc9[8] & 15;
            var loc10:*=(loc9[7] & 240) >> 4;
            var loc13:*=loc9[7] & 15;
            var loc35:*=(loc9[6] & 240) >> 4;
            var loc34:*=loc9[6] & 15;
            var loc29:*=(loc29 = (loc29 = (loc29 = loc16.toString(16)) + (loc37.toString(16) + loc36.toString(16))) + (loc10.toString(16) + loc13.toString(16))) + (loc35.toString(16) + loc34.toString(16));
            var loc19:*;
            var loc17:*;
            var loc2:*=(loc17 = ((loc19 = parseInt(loc9[9])) & 240) >> 4).toString(16);
            var loc40:*;
            var loc18:*=((loc40 = loc9[10]) & 240) >> 4;
            var loc14:*=loc40 & 15;
            var loc7:*=loc18.toString() + "." + loc14.toString();
            loc1.softwareRevision = loc7;
            var loc38:*=0;
            loc33 = 0;
            while (loc33 < 11) 
            {
                loc38 = loc38 + loc9[loc33];
                ++loc33;
            }
            loc38 = loc38 & 255;
            var loc27:*=parseInt(loc9[11]);
            if (loc38 != loc27) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 10119, "ROX2010Decoder > decodeUnitInformation: incorrect checksum2"));
            }
            if (!loc8) 
            {
            };
            return loc1;
        }

        public override function scanDockingStation():void
        {
            addEventListener("unitConnectedEvent", onUnitConnected);
            loadFromDC("checkUnitConnected");
            return;
        }

        protected function onUnitConnected(arg1:flash.events.Event):void
        {
            if (!_unitInitialised) 
            {
                loadFromDC("loadUnitInformation");
            }
            return;
        }

        public static const LOAD_INITIALINFORMATION_BYTES_TO_RECEIVE:uint=16;

        public static const LOAD_INITIALINFORMATION_COMMAND:uint=70;

        public static const ROX_COMMAND_VALUE:uint=255;

        public static const UNIT_CONNECTED_COMMAND:uint=114;

        public static const WRITE_INITIALINFORMATION_COMMAND:uint=96;

        internal var _scanDockingStationInterval:uint=1000;
    }
}


//  class Topline2009DSHandler
package handler.dockingstation 
{
    import com.logging.*;
    import core.units.*;
    import flash.events.*;
    import flash.utils.*;
    import handler.event.*;
    import service.*;
    import service.usb.event.*;
    
    public class Topline2009DSHandler extends handler.dockingstation.DockingStationHandler
    {
        public function Topline2009DSHandler(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            return;
        }

        public override function destructor():void
        {
            super.destructor();
            removeEventListener("unitConnectedEvent", onUnitConnected);
            service.DeviceCommunicationHandler.getInstance().removeEventListener("usbComplete", onLoaded);
            return;
        }

        internal function onLoaded(arg1:service.usb.event.DeviceDataCompleteEvent):void
        {
            var loc2:*=null;
            var loc1:*=null;
            service.DeviceCommunicationHandler.getInstance().removeEventListener("usbComplete", onLoaded, false);
            if (arg1.command != 244.toString()) 
            {
                if (arg1.command == 254.toString()) 
                {
                    loc1 = decodeUnitInformation(arg1.data) as core.units.UnitTopline2009;
                    if (loc1 != null) 
                    {
                        _unitInitialised = true;
                        dispatchEvent(new handler.event.UnitEvent("unitInitialisedEvent", loc1));
                    }
                    else 
                    {
                        dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 10001, "CurrentUnitHandler > onLoaded: Can not create unit"));
                    }
                }
            }
            else 
            {
                if (!scanDockingStationStopped) 
                {
                    _scanDocingstationTimeOutId = flash.utils.setTimeout(loadFromDC, _scanDockingStationInterval, "checkUnitConnected");
                }
                resetCheckConnectionTimeOut();
                if (arg1.data[0] != 1) 
                {
                    _unitInitialised = false;
                    loc2 = new flash.events.Event("unitDisconnectedEvent");
                    dispatchEvent(loc2);
                    _unitIsConnected = false;
                }
                else 
                {
                    loc2 = new flash.events.Event("unitConnectedEvent");
                    dispatchEvent(loc2);
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
            if (arg1 != "checkUnitConnected") 
            {
                if (arg1 == "loadUnitInformation") 
                {
                    currentCommand = 254;
                    currentBytesToReceive = 11;
                }
            }
            else 
            {
                currentCommand = 244;
                currentBytesToReceive = 1;
                _checkConnectionTimeOutId = flash.utils.setTimeout(checkConnectionTimeout, connectionTimeoutInterval);
            }
            service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBuffer(currentCommand), this);
            return;
        }

        internal function decodeUnitInformation(arg1:Object):core.units.Unit
        {
            var loc2:*=null;
            var loc7:*=true;
            var loc3:*=false;
            var loc4:*;
            if (!(loc3 = (loc4 = arg1[0]) == 0)) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 100, "ToplineDecoder > decodeUnitInformation: Unit in sleep mode"));
                return null;
            }
            var loc1:*=arg1[1];
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

        public override function scanDockingStation():void
        {
            addEventListener("unitConnectedEvent", onUnitConnected);
            loadFromDC("checkUnitConnected");
            return;
        }

        protected function onUnitConnected(arg1:flash.events.Event):void
        {
            _unitIsConnected = true;
            if (!_unitInitialised) 
            {
                loadFromDC("loadUnitInformation");
            }
            return;
        }

        public static const GET_VERSION_DATA_BYTES_TO_RECEIVE:uint=11;

        public static const GET_VERSION_DATA_COMMAND:uint=254;

        public static const IS_BC_ONLINE_COMMAND:uint=255;

        public static const UNIT_CONNECTED_COMMAND:uint=244;

        public static const UNIT_CONNECTED_COMMAND_BYTES_TO_RECEIVE:uint=1;

        internal var _scanDockingStationInterval:uint=1000;

        internal var _unitIsConnected:Boolean=false;
    }
}


//  class Topline2012DSHandler
package handler.dockingstation 
{
    import com.logging.*;
    import core.units.*;
    import flash.events.*;
    import flash.utils.*;
    import handler.event.*;
    import service.*;
    import service.usb.event.*;
    
    public class Topline2012DSHandler extends handler.dockingstation.DockingStationHandler
    {
        public function Topline2012DSHandler(arg1:flash.events.IEventDispatcher=null)
        {
            listeners = [];
            super(arg1);
            return;
        }

        public override function destructor():void
        {
            super.destructor();
            service.DeviceCommunicationHandler.getInstance().removeEventListener("usbComplete", onLoaded);
            return;
        }

        internal function onLoaded(arg1:service.usb.event.DeviceDataCompleteEvent):void
        {
            var loc3:*=null;
            var loc1:*=null;
            var loc4:*=null;
            var loc2:*=null;
            service.DeviceCommunicationHandler.getInstance().removeEventListener("usbComplete", onLoaded, false);
            if (arg1.command != 244.toString()) 
            {
                if (arg1.command != 254.toString()) 
                {
                    if (arg1.command == 239.toString() && arg1.startAdress == "0700") 
                    {
                        if (readDataSuccess([arg1.data[arg1.data.length - 2], arg1.data[(arg1.data.length - 1)]])) 
                        {
                            loc4 = arg1.data.slice(0, 12);
                            unit.serialNumber = decodeSerialNmumber(loc4, false);
                            if (unit.serialNumber == null) 
                            {
                                loadFromDC("loadUnitBackupSerialNumber");
                            }
                            else 
                            {
                                _unitInitialised = true;
                                dispatchEvent(new handler.event.UnitEvent("unitInitialisedEvent", unit));
                            }
                        }
                    }
                    else if (arg1.command == 239.toString() && arg1.startAdress == "1300") 
                    {
                        if (readDataSuccess([arg1.data[arg1.data.length - 2], arg1.data[(arg1.data.length - 1)]])) 
                        {
                            loc2 = arg1.data.slice(0, 12);
                            unit.serialNumber = decodeSerialNmumber(loc2, true);
                            if (unit.serialNumber == null) 
                            {
                                unit.serialNumber = _dsSerialNumber;
                                _unitInitialised = true;
                                dispatchEvent(new handler.event.UnitEvent("unitInitialisedEvent", unit));
                            }
                            else 
                            {
                                _unitInitialised = true;
                                dispatchEvent(new handler.event.UnitEvent("unitInitialisedEvent", unit));
                            }
                        }
                    }
                }
                else 
                {
                    loc1 = decodeUnitInformation(arg1.data) as core.units.UnitBikeComputer;
                    unit = null;
                    if (loc1 != null) 
                    {
                        if (loc1 is core.units.UnitROX2012) 
                        {
                            _dsSerialNumber = loc1.serialNumber;
                            unit = loc1;
                            loadFromDC("loadUnitSerialNumber");
                        }
                        else 
                        {
                            _unitInitialised = true;
                            dispatchEvent(new handler.event.UnitEvent("unitInitialisedEvent", loc1));
                        }
                    }
                    else 
                    {
                        dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 10001, "CurrentUnitHandler > onLoaded: Can not create unit"));
                    }
                }
            }
            else 
            {
                if (!scanDockingStationStopped) 
                {
                    _scanDocingstationTimeOutId = flash.utils.setTimeout(loadFromDC, _scanDockingStationInterval, "checkUnitConnected");
                }
                resetCheckConnectionTimeOut();
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

        public override function loadFromDC(arg1:String):void
        {
            if (service.DeviceCommunicationHandler.getInstance().nativeProcessIsBusy) 
            {
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
                    if (arg1 == "loadUnitSerialNumber") 
                    {
                        currentCommand = 239;
                        currentBytesToReceive = 12;
                        currentReceiveChecksumLength = 2;
                        currentStartAdrr = "0700";
                        service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBufferROX2012(currentCommand, currentStartAdrr, currentBytesToReceive, null), this);
                        return;
                    }
                    if (arg1 == "loadUnitBackupSerialNumber") 
                    {
                        currentCommand = 239;
                        currentBytesToReceive = 12;
                        currentReceiveChecksumLength = 2;
                        currentStartAdrr = "1300";
                        service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBufferROX2012(currentCommand, currentStartAdrr, currentBytesToReceive, null), this);
                        return;
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
                _checkConnectionTimeOutId = flash.utils.setTimeout(checkConnectionTimeout, connectionTimeoutInterval);
            }
            service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBuffer(currentCommand), this);
            return;
        }

        internal function decodeSerialNmumber(arg1:Array, arg2:Boolean=false):String
        {
            var loc3:*=0;
            var loc2:*="";
            var loc1:*=(arg1[3] & 3) << 24 | arg1[2] << 16 | arg1[1] << 8 | arg1[0];
            var loc4:*=arg1[8] == 161 && arg1[9] == 162 && arg1[10] == 163 && arg1[11] == 164;
            var loc5:*=0;
            loc3 = 0;
            while (loc3 < 7) 
            {
                loc5 = loc5 + arg1[loc3];
                ++loc3;
            }
            if (!((loc5 = loc5 & 255) == arg1[7]) || !loc4) 
            {
                if (arg2) 
                {
                    dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 522, "Topline2012Decoder > decode serialnumber: wrong crc"));
                }
                else 
                {
                    dispatchEvent(new com.logging.ErrorLoggingEvent("loggingWarningEvent", 522, "Topline2012Decoder > decode serialnumber: wrong crc"));
                }
                return null;
            }
            return loc2 = loc1.toString();
        }

        internal function decodeUnitInformation(arg1:Object):core.units.Unit
        {
            var loc2:*=null;
            var loc7:*=false;
            var loc3:*=false;
            var loc4:*=0;
            var loc5:*=0;
            var loc1:*=parseInt((arg1[1] as int).toString(16), 10);
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

        protected function generateNativeProzessBufferROX2012(arg1:uint, arg2:String, arg3:int=0, arg4:Array=null):flash.utils.ByteArray
        {
            var loc4:*=null;
            var loc1:*=null;
            var loc2:*=null;
            var loc5:*=null;
            var loc8:*=null;
            var loc3:*=null;
            var loc6:*;
            (loc6 = new flash.utils.ByteArray()).writeByte(arg1);
            var loc7:*=arg2.split("");
            if (arg4 == null) 
            {
                if (loc7.length == 0) 
                {
                    return loc6;
                }
                if (loc7.length == 4) 
                {
                    loc4 = parseInt(loc7[0] + loc7[1], 16).toString();
                    loc1 = parseInt(loc7[2] + loc7[3], 16).toString();
                }
                loc6.writeByte(loc4);
                loc6.writeByte(loc1);
                loc8 = arg3.toString(16);
                while (loc8.length < 4) 
                {
                    loc8 = "0" + loc8;
                }
                loc3 = loc8.split("");
                loc2 = parseInt(loc3[2] + loc3[3], 16).toString();
                loc5 = parseInt(loc3[0] + loc3[1], 16).toString();
                loc6.writeByte(loc2);
                loc6.writeByte(loc5);
            }
            return loc6;
        }

        public override function scanDockingStation():void
        {
            addEventListener("unitConnectedEvent", onUnitConnected, false, 0, true);
            loadFromDC("checkUnitConnected");
            return;
        }

        protected function onUnitConnected(arg1:flash.events.Event):void
        {
            if (!_unitInitialised) 
            {
                loadFromDC("loadUnitInformation");
            }
            _unitIsConnected = true;
            return;
        }

        public static const BACKUP_SERIAL_NUMBER_STARTADDRESS:String="1300";

        public static const GET_DATA_BY_ADDR:uint=239;

        public static const GET_VERSION_DATA_BYTES_TO_RECEIVE:uint=11;

        public static const GET_VERSION_DATA_COMMAND:uint=254;

        public static const LOAD_UNIT_BACKUP_SERIAL_NUMBER_FROM_DEVICE:String="loadUnitBackupSerialNumber";

        public static const LOAD_UNIT_SERIAL_NUMBER_FROM_DEVICE:String="loadUnitSerialNumber";

        public static const SERIAL_NUMBER_BYTES_TO_RECEIVE:uint=12;

        public static const SERIAL_NUMBER_STARTADDRESS:String="0700";

        public static const SERIAL_NUMBER_STOPADDRESS:String="1200";

        public static const UNIT_CONNECTED_COMMAND:uint=244;

        public static const UNIT_CONNECTED_COMMAND_BYTES_TO_RECEIVE:uint=1;

        internal var _dsSerialNumber:String="";

        internal var _readErrorRepeats:int=0;

        internal var _scanDockingStationInterval:uint=1000;

        internal var _unitIsConnected:Boolean=false;

        internal var listeners:Array;

        internal var unit:core.units.Unit;
    }
}


//  class Topline2016DSHandler
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


//  class UFSBHandler
package handler.dockingstation 
{
    import com.logging.*;
    import core.units.*;
    import flash.events.*;
    import flash.utils.*;
    import service.*;
    import service.usb.event.*;
    
    public class UFSBHandler extends handler.dockingstation.DockingStationHandler
    {
        public function UFSBHandler(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
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
            if (arg1 != 115.toString()) 
            {
                if (arg1 != 101.toString()) 
                {
                    if (arg1 != 118.toString()) 
                    {
                        if (arg1 == 69.toString()) 
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
            service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBuffer(currentCommand), this);
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

        internal function onLoaded(arg1:service.usb.event.DeviceDataCompleteEvent):void
        {
            service.DeviceCommunicationHandler.getInstance().removeEventListener("usbComplete", onLoaded);
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
                                    service.DeviceCommunicationHandler.getInstance().dispatchEvent(new flash.events.Event("dc.units.handler.UFSBHandler.sendALineEvent"));
                                }
                            }
                        }
                        else if (arg1.data[0] != 89) 
                        {
                            service.DeviceCommunicationHandler.getInstance().dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 0, "END_PROG_AND_RUN"));
                        }
                        else 
                        {
                            service.DeviceCommunicationHandler.getInstance().dispatchEvent(new flash.events.Event("dc.units.handler.UFSBHandler.endProgAndRunEvent"));
                        }
                    }
                    else if (arg1.data[0] != 89) 
                    {
                        service.DeviceCommunicationHandler.getInstance().dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 0, "START_VERIFICATION"));
                    }
                    else 
                    {
                        service.DeviceCommunicationHandler.getInstance().dispatchEvent(new flash.events.Event("dc.units.handler.UFSBHandler.startVerificationEvent"));
                    }
                }
                else if (arg1.data[0] != 89) 
                {
                    service.DeviceCommunicationHandler.getInstance().dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 0, "ERASE_FLASH_ROM_SUCCESS"));
                }
                else 
                {
                    service.DeviceCommunicationHandler.getInstance().dispatchEvent(new flash.events.Event("dc.units.handler.UFSBHandler.eraseFlashRomEvent"));
                }
            }
            else if (arg1.data[0] != 89) 
            {
                service.DeviceCommunicationHandler.getInstance().dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 0, "START_PROGRAM"));
            }
            else 
            {
                service.DeviceCommunicationHandler.getInstance().dispatchEvent(new flash.events.Event("dc.units.handler.UFSBHandler.startProgramEvent"));
            }
            service.DeviceCommunicationHandler.getInstance().processNextCommandFromQueue();
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

        public static const CHECKSUM_ERROR:uint=78;

        public static const END_PROG_AND_RUN:uint=69;

        public static const END_PROG_AND_RUN_BYTES_TO_RECEIVE:uint=1;

        public static const END_PROG_AND_RUN_EVENT:String="dc.units.handler.UFSBHandler.endProgAndRunEvent";

        public static const END_PROG_AND_RUN_SUCCESS:uint=89;

        public static const ERASE_FLASH_ROM:uint=101;

        public static const ERASE_FLASH_ROM_BYTES_TO_RECEIVE:uint=1;

        public static const ERASE_FLASH_ROM_EVENT:String="dc.units.handler.UFSBHandler.eraseFlashRomEvent";

        public static const ERASE_FLASH_ROM_SUCCESS:uint=89;

        public static const LOAD_CHECKSUMM_BYTES_TO_RECEIVE:uint=4;

        public static const LOAD_INITIALINFORMATION_BYTES_TO_RECEIVE:uint=8;

        public static const SEND_A_LINE:uint=58;

        public static const SEND_A_LINE_BYTES_TO_RECEIVE:uint=1;

        public static const SEND_A_LINE_EVENT:String="dc.units.handler.UFSBHandler.sendALineEvent";

        public static const SEND_A_LINE_LENGTH:int=43;

        public static const SEND_A_LINE_SUCCESS:uint=89;

        public static const START_PROGRAM:uint=115;

        public static const START_PROGRAM_BYTES_TO_RECEIVE:uint=1;

        public static const START_PROGRAM_EVENT:String="dc.units.handler.UFSBHandler.startProgramEvent";

        public static const START_PROGRAM_SUCCESS:uint=89;

        public static const START_VERIFICATION:uint=118;

        public static const START_VERIFICATION_BYTES_TO_RECEIVE:uint=1;

        public static const START_VERIFICATION_EVENT:String="dc.units.handler.UFSBHandler.startVerificationEvent";

        public static const START_VERIFICATION_SUCCESS:uint=89;

        internal var unit:core.units.Unit;
    }
}


