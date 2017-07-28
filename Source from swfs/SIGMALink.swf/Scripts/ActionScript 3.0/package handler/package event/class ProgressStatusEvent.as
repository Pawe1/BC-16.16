//class ProgressStatusEvent
package handler.event 
{
    import flash.events.*;
    
    public class ProgressStatusEvent extends flash.events.Event
    {
        public function ProgressStatusEvent(arg1:String, arg2:uint, arg3:uint=1, arg4:uint=1, arg5:String=null, arg6:Boolean=false, arg7:Boolean=false)
        {
            super(arg1, arg6, arg7);
            _statusPercentCurrentLog = arg2;
            _currentLogIndex = arg3;
            _logSize = arg4;
            _description = arg5 != null ? arg5 : "";
            return;
        }

        public function get currentLogIndex():uint
        {
            return _currentLogIndex;
        }

        public function get description():String
        {
            return _description;
        }

        public function get logSize():uint
        {
            return _logSize;
        }

        public function get statusPercentCurrentLog():uint
        {
            return _statusPercentCurrentLog;
        }

        public static const PROGRESS:String="progressbarEvent";

        internal var _currentLogIndex:uint=0;

        internal var _description:String="";

        internal var _logSize:uint=0;

        internal var _statusPercentCurrentLog:uint=0;
    }
}


