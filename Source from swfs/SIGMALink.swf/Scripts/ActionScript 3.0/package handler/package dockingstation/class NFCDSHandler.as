//class NFCDSHandler
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


