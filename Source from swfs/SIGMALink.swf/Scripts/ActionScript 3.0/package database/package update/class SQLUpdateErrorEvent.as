//class SQLUpdateErrorEvent
package database.update 
{
    import flash.events.*;
    
    public class SQLUpdateErrorEvent extends flash.events.Event
    {
        public function SQLUpdateErrorEvent(arg1:String, arg2:String, arg3:Boolean=false, arg4:Boolean=false)
        {
            super(arg1, arg3, arg4);
            message = arg2;
            return;
        }

        public static const EVENT_ERROR:String="sqlUpdateEventError";

        public var message:String="";
    }
}


