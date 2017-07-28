//class GVShareEvent
package com.milkmangames.nativeextensions.events 
{
    import flash.events.*;
    
    public class GVShareEvent extends flash.events.Event
    {
        public function GVShareEvent(arg1:String, arg2:Boolean=false, arg3:Boolean=false)
        {
            super(arg1, arg2, arg3);
            return;
        }

        public override function clone():flash.events.Event
        {
            return new com.milkmangames.nativeextensions.events.GVShareEvent(type, bubbles, cancelable);
        }

        public override function toString():String
        {
            return formatToString("GVShareEvent", "type", "bubbles", "cancelable", "eventPhase");
        }

        public static const GENERIC_MESSAGE_SHARED:String="gvGenericShared";

        public static const SOCIAL_COMPOSER_FINISHED:String="gvSocialFinished";

        public static const SOCIAL_COMPOSER_CANCELED:String="gvSocialCanceled";

        public var socialServiceType:String;
    }
}


