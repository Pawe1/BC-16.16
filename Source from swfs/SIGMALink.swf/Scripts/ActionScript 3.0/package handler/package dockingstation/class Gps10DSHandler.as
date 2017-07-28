//class Gps10DSHandler
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


