//class GVMailEvent
package com.milkmangames.nativeextensions.events 
{
    import flash.events.*;
    
    public class GVMailEvent extends flash.events.Event
    {
        public function GVMailEvent(arg1:String, arg2:Boolean=false, arg3:Boolean=false)
        {
            super(arg1, arg2, arg3);
            return;
        }

        public override function clone():flash.events.Event
        {
            return new com.milkmangames.nativeextensions.events.GVMailEvent(type, bubbles, cancelable);
        }

        public override function toString():String
        {
            return formatToString("GVMailEvent", "type", "bubbles", "cancelable", "eventPhase");
        }

        public static const MAIL_CANCELED:String="gvMailCancelled";

        public static const MAIL_SAVED:String="gvMailSaved";

        public static const MAIL_SENT:String="gvMailSent";

        public static const MAIL_FAILED:String="gvMailFailed";

        public var errorCode:int;

        public var errorMessage:String;
    }
}


