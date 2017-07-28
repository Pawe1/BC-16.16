//class ActivityListEvent
package frontend.screen.activities.list 
{
    import core.activities.*;
    import flash.events.*;
    
    public class ActivityListEvent extends flash.events.Event
    {
        public function ActivityListEvent(arg1:String, arg2:core.activities.Activity=null, arg3:String="", arg4:Boolean=false, arg5:Boolean=false)
        {
            super(arg1, arg4, arg5);
            this.activity = arg2;
            this.GUID = arg3;
            return;
        }

        public static const DELETE:String="deleteActivityEvent";

        public static const RELOAD:String="reloadActivitiesEvent";

        public static const UPDATE:String="updateActivityInListEvent";

        public var GUID:String="";

        public var activity:core.activities.Activity;

        public var resetLastScrollPosition:Boolean=false;
    }
}


