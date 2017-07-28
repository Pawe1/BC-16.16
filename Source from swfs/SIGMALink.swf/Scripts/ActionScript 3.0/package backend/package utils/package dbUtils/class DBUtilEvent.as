//class DBUtilEvent
package backend.utils.dbUtils 
{
    import flash.events.*;
    
    public class DBUtilEvent extends flash.events.Event
    {
        public function DBUtilEvent(arg1:String, arg2:backend.utils.dbUtils.DBUtilObject=null, arg3:Boolean=false, arg4:Boolean=false)
        {
            super(arg1, arg3, arg4);
            this.data = arg2;
            return;
        }

        public function getResult():Array
        {
            return this.data.result is Array ? this.data.result as Array : [];
        }

        public static const COMPLETE:String="executeCompleteEvent";

        public static const ERROR:String="executeErrorEvent";

        public var data:backend.utils.dbUtils.DBUtilObject;

        public var message:String;
    }
}


