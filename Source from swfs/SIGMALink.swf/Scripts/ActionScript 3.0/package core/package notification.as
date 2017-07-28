//package notification
//  class NotificationEvent
package core.notification 
{
    import flash.events.*;
    
    public class NotificationEvent extends flash.events.EventDispatcher
    {
        public function NotificationEvent(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            return;
        }

        public var category:String;

        public var errorCode:uint;

        public var errorMessage:String;

        public var group:String;

        public var groupKey:String;

        public var id:uint;

        public var optionalParameters:Object;

        public var packageName:String;

        public var postTime:uint;

        public var repeatSendCounter:int=5;

        public var repeatSendNotification:Boolean=true;

        public var sdk:uint;

        public var tag:String;

        public var text:String;

        public var tickerText:String;

        public var title:String;

        public var transferError:Boolean=false;
    }
}


