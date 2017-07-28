//class SelectableListEvent
package frontend.components.list 
{
    import starling.events.*;
    
    public class SelectableListEvent extends starling.events.Event
    {
        public function SelectableListEvent(arg1:String, arg2:String, arg3:Boolean=false, arg4:Boolean=false)
        {
            super(arg1, arg3, arg4);
            this.newState = arg2;
            return;
        }

        public static const CHANGE_STATE:String="changeStateEvent";

        public static const STATE_SELECTABLE:String="selectableState";

        public static const STATE_NORMAL:String="normalState";

        public var newState:String;
    }
}


