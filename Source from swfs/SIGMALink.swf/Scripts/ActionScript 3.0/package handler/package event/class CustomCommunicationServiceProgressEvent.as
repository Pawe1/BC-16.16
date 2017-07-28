//class CustomCommunicationServiceProgressEvent
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


