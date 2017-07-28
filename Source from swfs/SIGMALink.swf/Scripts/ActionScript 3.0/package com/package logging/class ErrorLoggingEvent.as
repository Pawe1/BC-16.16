//class ErrorLoggingEvent
package com.logging 
{
    import flash.events.*;
    
    public class ErrorLoggingEvent extends flash.events.Event
    {
        public function ErrorLoggingEvent(arg1:String, arg2:int, arg3:String="", arg4:Object=null, arg5:Boolean=false, arg6:Boolean=false)
        {
            super(arg1, arg5, arg6);
            errorTarget = arg4;
            errorType = arg2;
            message = arg3;
            return;
        }

        public static const ERROR:String="loggingErrorEvent";

        public static const WARNING:String="loggingWarningEvent";

        public static const INFO:String="loggingInfoEvent";

        public static const DEBUG:String="loggingDebugEvent";

        public static const FATAL:String="loggingFatalEvent";

        public var errorType:int;

        public var message:String;

        public var errorTarget:Object;
    }
}


