//class RoxDS2010Handler
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


