//class MyTracksListEvent
package frontend.screen.tracks.tabs.list 
{
    import core.route.*;
    import flash.events.*;
    
    public class MyTracksListEvent extends flash.events.Event
    {
        public function MyTracksListEvent(arg1:String, arg2:core.route.Route=null, arg3:Boolean=false, arg4:Boolean=false)
        {
            super(arg1, arg3, arg4);
            this.route = arg2;
            return;
        }

        public static const DELETE:String="deleteTrackEvent";

        public static const RELOAD:String="reloadTracksEvent";

        public static const UPDATE:String="updateTrackEvent";

        public var route:core.route.Route;
    }
}


