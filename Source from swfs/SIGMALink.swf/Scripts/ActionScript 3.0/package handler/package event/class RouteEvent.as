//class RouteEvent
package handler.event 
{
    import __AS3__.vec.*;
    import core.route.*;
    import flash.events.*;
    
    public class RouteEvent extends flash.events.Event
    {
        public function RouteEvent(arg1:String, arg2:Boolean=false, arg3:Boolean=false)
        {
            super(arg1, arg2, arg3);
            return;
        }

        public var route:core.route.Route;

        public var routes:__AS3__.vec.Vector.<core.route.Route>;

        public var track:*;
    }
}


