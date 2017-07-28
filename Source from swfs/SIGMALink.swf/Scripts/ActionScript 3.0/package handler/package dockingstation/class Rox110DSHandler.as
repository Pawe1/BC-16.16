//class Rox110DSHandler
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


