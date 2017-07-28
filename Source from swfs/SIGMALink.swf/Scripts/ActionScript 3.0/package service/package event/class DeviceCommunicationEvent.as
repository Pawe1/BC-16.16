//class DeviceCommunicationEvent
package service.event 
{
    import flash.events.*;
    
    public class DeviceCommunicationEvent extends flash.events.Event
    {
        public function DeviceCommunicationEvent(arg1:String, arg2:String="")
        {
            super(arg1);
            message = arg2;
            return;
        }

        public static const EVENT_COMMUNICATION_ERROR:String="eventCommunicationError";

        public var message:String="";
    }
}


