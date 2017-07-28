//package events
//  class TweenEvent
package com.greensock.events 
{
    import flash.events.*;
    
    public class TweenEvent extends flash.events.Event
    {
        public function TweenEvent(arg1:String, arg2:Boolean=false, arg3:Boolean=false)
        {
            super(arg1, arg2, arg3);
            return;
        }

        public override function clone():flash.events.Event
        {
            return new com.greensock.events.TweenEvent(this.type, this.bubbles, this.cancelable);
        }

        public static const COMPLETE:String="complete";

        public static const START:String="start";

        public static const UPDATE:String="change";

        public static const REVERSE_COMPLETE:String="reverseComplete";

        public static const INIT:String="init";

        public static const VERSION:Number=1.1;

        public static const REPEAT:String="repeat";
    }
}


