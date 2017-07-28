//class GVTwitterEvent
package com.milkmangames.nativeextensions.events 
{
    import flash.events.*;
    
    public class GVTwitterEvent extends flash.events.Event
    {
        public function GVTwitterEvent(arg1:String, arg2:Boolean=false, arg3:Boolean=false)
        {
            super(arg1, arg2, arg3);
            return;
        }

        public override function clone():flash.events.Event
        {
            return new com.milkmangames.nativeextensions.events.GVTwitterEvent(type, bubbles, cancelable);
        }

        public override function toString():String
        {
            return formatToString("GVTwitterEvent", "type", "bubbles", "cancelable", "eventPhase");
        }

        public static const TW_DIALOG_FINISHED:String="gvTwDialogFinished";

        public static const TW_DIALOG_CANCELED:String="gvTwDialogCancelled";

        public static const TW_DIALOG_FAILED:String="gvTwDialogFailed";

        public var errorCode:int;

        public var errorMessage:String;
    }
}


