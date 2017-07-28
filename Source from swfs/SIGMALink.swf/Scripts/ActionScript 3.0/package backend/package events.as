//package events
//  class UnitDataEvent
package backend.events 
{
    import flash.events.*;
    
    public class UnitDataEvent extends flash.events.Event
    {
        public function UnitDataEvent(arg1:String, arg2:Object, arg3:Boolean=false, arg4:Boolean=false)
        {
            super(arg1, arg3, arg4);
            this.data = arg2;
            return;
        }

        public function get data():Object
        {
            return this._data;
        }

        public function set data(arg1:Object):void
        {
            this._data = arg1;
            return;
        }

        public static const DATA_ADDED:String="dataAddedEvent";

        public static const DATA_CHANGED:String="dataChangeEvent";

        public static const DATA_REMOVED:String="dataRemovedEvent";

        public static const SHARING_DATA_ADDED:String="sharingDataAddedEvent";

        internal var _data:Object;
    }
}


