//class RCDS2011Handler
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


