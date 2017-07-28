//package core
//  class DecodeError
package decoder.core 
{
    import core.activities.*;
    
    public class DecodeError extends Error
    {
        public function DecodeError(arg1:*="", arg2:*=0)
        {
            super(arg1, arg2);
            _id = arg2 as String;
            if (_id == null) 
            {
                _id = "";
            }
            _message = arg1 as String;
            if (_message == null) 
            {
                _message = "";
            }
            return;
        }

        public function toString():String
        {
            return "[#" + _id + "] " + _message;
        }

        public var activity:core.activities.Activity;

        internal var _id:String="";

        internal var _message:String="";
    }
}


