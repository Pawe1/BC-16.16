//class Rox100DSHandler
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


