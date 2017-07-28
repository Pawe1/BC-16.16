//class ISO8601Util
package utils 
{
    public class ISO8601Util extends Object
    {
        public function ISO8601Util()
        {
            super();
            return;
        }

        public function formatExtendedDateTime(arg1:Date):String
        {
            return formatExtendedDate(arg1) + "T" + formatExtendedTime(arg1) + "Z";
        }

        public function formatBasicDateTime(arg1:Date):String
        {
            return formatBasicDate(arg1) + "T" + formatBasicTime(arg1) + "Z";
        }

        public function parseDateTimeString(arg1:String):Date
        {
            arg1 = arg1.replace(new RegExp("-|:|T|Z", "g"), "");
            var loc1:*=parseBasicDate(arg1.substr(0, 8));
            loc1 = parseBasicTime(arg1.substr(8, 6), loc1);
            return loc1;
        }

        public function parseBasicDate(arg1:String, arg2:Date=null):Date
        {
            if (arg2 == null) 
            {
                arg2 = new Date();
            }
            arg2.setUTCFullYear(convertYear(arg1), convertMonth(arg1), convertDate(arg1));
            return arg2;
        }

        public function parseBasicTime(arg1:String, arg2:Date=null):Date
        {
            if (arg2 == null) 
            {
                arg2 = new Date();
            }
            arg2.setUTCHours(convertHours(arg1), convertMinutes(arg1), convertSeconds(arg1));
            return arg2;
        }

        public function formatExtendedDate(arg1:Date):String
        {
            return formatYear(arg1.getUTCFullYear()) + "-" + formatMonth(arg1.getUTCMonth()) + "-" + formatDate(arg1.getUTCDate());
        }

        public function formatBasicDate(arg1:Date):String
        {
            return formatYear(arg1.getUTCFullYear()) + formatMonth(arg1.getUTCMonth()) + formatDate(arg1.getUTCDate());
        }

        public function formatExtendedTime(arg1:Date):String
        {
            return formatTimeChunk(arg1.getUTCHours()) + ":" + formatTimeChunk(arg1.getUTCMinutes()) + ":" + formatTimeChunk(arg1.getUTCSeconds());
        }

        public function formatBasicTime(arg1:Date):String
        {
            return formatTimeChunk(arg1.getUTCHours()) + formatTimeChunk(arg1.getUTCMinutes()) + formatTimeChunk(arg1.getUTCSeconds());
        }

        internal function convertYear(arg1:String):int
        {
            arg1 = arg1.substr(0, 4);
            return parseInt(arg1);
        }

        internal function convertMonth(arg1:String):int
        {
            arg1 = arg1.substr(4, 2);
            var loc1:*=(parseInt(arg1) - 1);
            return loc1;
        }

        internal function convertDate(arg1:String):int
        {
            arg1 = arg1.substr(6, 2);
            return parseInt(arg1);
        }

        internal function convertHours(arg1:String):int
        {
            arg1 = arg1.substr(0, 2);
            return parseInt(arg1);
        }

        internal function convertMinutes(arg1:String):int
        {
            arg1 = arg1.substr(2, 2);
            return parseInt(arg1);
        }

        internal function convertSeconds(arg1:String):int
        {
            arg1 = arg1.substr(4, 2);
            return parseInt(arg1);
        }

        internal function formatYear(arg1:int):String
        {
            var loc1:*=arg1.toString();
            if (arg1 < 10) 
            {
                loc1 = "0" + "0" + "0" + loc1;
            }
            else if (arg1 < 100) 
            {
                loc1 = "0" + "0" + loc1;
            }
            else if (arg1 < 1000) 
            {
                loc1 = "0" + loc1;
            }
            return loc1;
        }

        internal function formatMonth(arg1:int):String
        {
            ++arg1;
            var loc1:*=arg1.toString();
            if (arg1 < 10) 
            {
                loc1 = "0" + loc1;
            }
            return loc1;
        }

        internal function formatDate(arg1:int):String
        {
            var loc1:*=arg1.toString();
            if (arg1 < 10) 
            {
                loc1 = "0" + loc1;
            }
            return loc1;
        }

        internal function formatTimeChunk(arg1:int):String
        {
            var loc1:*=arg1.toString();
            if (arg1 < 10) 
            {
                loc1 = "0" + loc1;
            }
            return loc1;
        }

        internal const COLON:String=":";

        internal const DASH:String="-";

        internal const T:String="T";

        internal const ZERO:String="0";

        internal const ZULU:String="Z";
    }
}


