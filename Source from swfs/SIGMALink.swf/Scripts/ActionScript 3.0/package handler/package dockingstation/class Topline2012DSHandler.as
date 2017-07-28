//class Topline2012DSHandler
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


