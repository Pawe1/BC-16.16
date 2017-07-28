//package event
//  class CustomCommunicationServiceProgressEvent
package handler.event 
{
    import flash.events.*;
    import service.*;
    import service.ble.*;
    import service.nfc.*;
    import service.usb.*;
    
    public class CustomCommunicationServiceProgressEvent extends flash.events.Event
    {
        public function CustomCommunicationServiceProgressEvent(arg1:String, arg2:uint)
        {
            super(arg1);
            this.progress = arg2;
            return;
        }

        public function get isBleCommunication():Boolean
        {
            return _communicationHandlerType == "ble";
        }

        public function get isNfcCommunication():Boolean
        {
            return _communicationHandlerType == "nfc";
        }

        public function get isUsbCommunication():Boolean
        {
            return _communicationHandlerType == "usb";
        }

        public function resolveCommunicationHandler(arg1:service.ICommunicationService):void
        {
            if (arg1 is service.nfc.NFCHandler) 
            {
                _communicationHandlerType = "nfc";
            }
            if (arg1 is service.usb.USBHandler) 
            {
                _communicationHandlerType = "usb";
            }
            if (arg1 is service.ble.BLEHandler) 
            {
                _communicationHandlerType = "ble";
            }
            return;
        }

        public static const COMMUNICATION_HANDLER_BLE:String="ble";

        public static const COMMUNICATION_HANDLER_NFC:String="nfc";

        public static const COMMUNICATION_HANDLER_UNKNOWN:String="unknown";

        public static const COMMUNICATION_HANDLER_USB:String="usb";

        public var message:String;

        public var progress:uint=0;

        internal var _communicationHandlerType:String="unknown";
    }
}


//  class ProgressStatusEvent
package handler.event 
{
    import flash.events.*;
    
    public class ProgressStatusEvent extends flash.events.Event
    {
        public function ProgressStatusEvent(arg1:String, arg2:uint, arg3:uint=1, arg4:uint=1, arg5:String=null, arg6:Boolean=false, arg7:Boolean=false)
        {
            super(arg1, arg6, arg7);
            _statusPercentCurrentLog = arg2;
            _currentLogIndex = arg3;
            _logSize = arg4;
            _description = arg5 != null ? arg5 : "";
            return;
        }

        public function get currentLogIndex():uint
        {
            return _currentLogIndex;
        }

        public function get description():String
        {
            return _description;
        }

        public function get logSize():uint
        {
            return _logSize;
        }

        public function get statusPercentCurrentLog():uint
        {
            return _statusPercentCurrentLog;
        }

        public static const PROGRESS:String="progressbarEvent";

        internal var _currentLogIndex:uint=0;

        internal var _description:String="";

        internal var _logSize:uint=0;

        internal var _statusPercentCurrentLog:uint=0;
    }
}


//  class RouteEvent
package handler.event 
{
    import __AS3__.vec.*;
    import core.route.*;
    import flash.events.*;
    
    public class RouteEvent extends flash.events.Event
    {
        public function RouteEvent(arg1:String, arg2:Boolean=false, arg3:Boolean=false)
        {
            super(arg1, arg2, arg3);
            return;
        }

        public var route:core.route.Route;

        public var routes:__AS3__.vec.Vector.<core.route.Route>;

        public var track:*;
    }
}


//  class UnitEvent
package handler.event 
{
    import core.units.*;
    import flash.events.*;
    
    public class UnitEvent extends flash.events.Event
    {
        public function UnitEvent(arg1:String, arg2:core.units.Unit, arg3:Boolean=false, arg4:Boolean=false)
        {
            super(arg1, arg3, arg4);
            unit = arg2;
            return;
        }

        public function get unit():core.units.Unit
        {
            return _unit;
        }

        public function set unit(arg1:core.units.Unit):void
        {
            _unit = arg1;
            return;
        }

        internal var _unit:core.units.Unit;
    }
}


