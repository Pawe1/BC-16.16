//class BLEDSHandler
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


