//class NotificationStatusChangedEvent
package de.pagecon.ane.notificationlistenerservice.events 
{
    import flash.events.*;
    
    public class NotificationStatusChangedEvent extends flash.events.Event
    {
        public function NotificationStatusChangedEvent(arg1:String, arg2:Boolean, arg3:Boolean=false, arg4:Boolean=false)
        {
            super(arg1, arg3, arg4);
            this.notificationsEnabled = notificationsEnabled;
            return;
        }

        public override function clone():flash.events.Event
        {
            return new de.pagecon.ane.notificationlistenerservice.events.NotificationServiceControllerEvent(type, notificationsEnabled, bubbles, cancelable);
        }

        public override function toString():String
        {
            return "[NotificationStatusChangedEvent] " + type + "\t\t" + JSON.stringify(this);
        }

        public var notificationsEnabled:Boolean;
    }
}


