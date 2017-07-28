//class SQLUpdateEvent
package database.update 
{
    import flash.events.*;
    
    public class SQLUpdateEvent extends flash.events.Event
    {
        public function SQLUpdateEvent(arg1:String, arg2:Boolean=false, arg3:Boolean=false)
        {
            super(arg1, arg2, arg3);
            return;
        }

        public static const EXECUTED:String="executedEvent";

        public static const STATUS:String="statusEvent";

        public var maximum:Number;

        public var status:String;

        public var value:Number;
    }
}


