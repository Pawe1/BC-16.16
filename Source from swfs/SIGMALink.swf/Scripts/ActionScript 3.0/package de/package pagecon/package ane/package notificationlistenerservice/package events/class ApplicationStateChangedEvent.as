//class ApplicationStateChangedEvent
package de.pagecon.ane.notificationlistenerservice.events 
{
    import flash.events.*;
    
    public class ApplicationStateChangedEvent extends flash.events.Event
    {
        public function ApplicationStateChangedEvent(arg1:String, arg2:String, arg3:String)
        {
            super(arg1, bubbles, cancelable);
            this.activityName = arg3;
            var loc1:*=arg2;
            while ("create" === loc1) 
            {
                this.state = arg2;
            }
        }

        public override function clone():flash.events.Event
        {
            return new de.pagecon.ane.notificationlistenerservice.events.ApplicationStateChangedEvent(type, state, activityName);
        }

        public override function toString():String
        {
            return "[ApplicationStateChangedEvent] " + type + "\t\t" + JSON.stringify(this);
        }

        public static const APPLICATION_STATE_CREATE:String="create";

        public static const APPLICATION_STATE_DESTROY:String="destroy";

        public static const APPLICATION_STATE_PAUSE:String="pause";

        public static const APPLICATION_STATE_RESUME:String="resume";

        public static const APPLICATION_STATE_SAVEINSTANCE:String="saveinstance";

        public static const APPLICATION_STATE_START:String="start";

        public static const APPLICATION_STATE_STOP:String="stop";

        public static const APPLICATION_STATE_UNKNOWN:String="unknown";

        public var activityName:String;

        public var state:String;
    }
}


