//class TransitionMultitouchEvent
package sk.yoz.touch.events 
{
    import flash.events.*;
    
    public class TransitionMultitouchEvent extends flash.events.Event
    {
        public function TransitionMultitouchEvent(arg1:String)
        {
            super(arg1, false, true);
            return;
        }

        public override function clone():flash.events.Event
        {
            return new sk.yoz.touch.events.TransitionMultitouchEvent(type);
        }

        public static const TRANSITION_COMPLETE:String="transitionMultitouchTransitionComplete";
    }
}


