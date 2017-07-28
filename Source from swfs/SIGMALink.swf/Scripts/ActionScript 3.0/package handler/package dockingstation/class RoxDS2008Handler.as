//class RoxDS2008Handler
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


