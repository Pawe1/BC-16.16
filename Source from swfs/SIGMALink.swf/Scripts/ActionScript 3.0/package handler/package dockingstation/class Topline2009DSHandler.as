//class Topline2009DSHandler
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


