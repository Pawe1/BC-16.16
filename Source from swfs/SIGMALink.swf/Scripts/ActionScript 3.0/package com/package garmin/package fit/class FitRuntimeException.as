//class FitRuntimeException
package com.garmin.fit 
{
    public class FitRuntimeException extends Object
    {
        public function FitRuntimeException(arg1:String="", arg2:*=null, arg3:String="", arg4:Object=null, arg5:Boolean=false, arg6:Boolean=false)
        {
            var loc2:*=null;
            var loc1:*=null;
            super();
            if (arg2 is Error) 
            {
                loc2 = arg1 != "" ? arg1 + "\t" : "";
                loc1 = arg2 != null ? arg2.message : "";
                _event = "loggingErrorEvent";
                _code = 1800001;
                _description = "FITEncoding > Logical Error:  " + loc2 + " " + loc1;
            }
            else if (arg2 is int) 
            {
                _event = arg1;
                _code = arg2;
                _description = arg3;
            }
            else if (arg2 == null && !(arg1 == "")) 
            {
                _event = "loggingErrorEvent";
                _code = 1800000;
                _description = "FitEncoding:  " + arg1;
            }
            return;
        }

        public function get code():int
        {
            return _code;
        }

        public function get event():String
        {
            return _event;
        }

        public function get message():String
        {
            return _description;
        }

        internal static const serialVersionUID:Number=9.70213851172e+017;

        internal var _event:String;

        internal var _code:int;

        internal var _description:String;
    }
}


