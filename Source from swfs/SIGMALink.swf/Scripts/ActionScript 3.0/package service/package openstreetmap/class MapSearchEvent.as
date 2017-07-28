//class MapSearchEvent
package service.openstreetmap 
{
    import flash.events.*;
    
    public class MapSearchEvent extends flash.events.Event
    {
        public function MapSearchEvent(arg1:String, arg2:Boolean=false, arg3:Object=null)
        {
            super(arg1, arg2, false);
            _data = arg3;
            return;
        }

        public function get data():Object
        {
            return _data;
        }

        public function set data(arg1:Object):void
        {
            _data = arg1;
            return;
        }

        public static const SEARCH_ERROR:String="searchError";

        public static const SEARCH_RESULT:String="searchResult";

        public static const SEARCH_REVERSE_RESULT:String="searchReverseResult";

        internal var _data:Object;
    }
}


