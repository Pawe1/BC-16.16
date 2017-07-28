//class DateUtilCommon
package utils.date 
{
    import init.*;
    import utils.interfaces.*;
    
    public class DateUtilCommon extends Object
    {
        public function DateUtilCommon()
        {
            super();
            return;
        }

        public static function clearTime(arg1:Date):Date
        {
            arg1.hours = 0;
            arg1.minutes = 0;
            arg1.seconds = 0;
            arg1.milliseconds = 0;
            return arg1;
        }

        public static function copyDate(arg1:Date):Date
        {
            return new Date(arg1.getTime());
        }

        public static function setTime(arg1:Date, arg2:Number):Date
        {
            arg1.hours = Math.floor(arg2 / 3600000 % 24);
            arg1.minutes = Math.floor(arg2 / 60000 % 60);
            arg1.seconds = Math.floor(arg2 / 1000 % 60);
            arg1.milliseconds = Math.floor(arg2 % 1000);
            return arg1;
        }

        public static function addTime(arg1:Date, arg2:Number):Date
        {
            arg1.milliseconds = arg1.milliseconds + arg2;
            return arg1;
        }

        public static function dateToMySqlFormat(arg1:Date=null, arg2:Boolean=false):String
        {
            formattedDate.formatString = arg2 ? "YYYY-MM-DD" : "YYYY-MM-DD JJ:NN:SS";
            if (arg1 == null) 
            {
                arg1 = new Date();
            }
            return formattedDate.format(arg1);
        }

        public static function dateFromMySqlFormat(arg1:String):Date
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*;
            if ((loc4 = arg1.split(" ")).length != 2) 
            {
                loc1 = new Date(Date.parse(arg1));
            }
            else 
            {
                loc2 = loc4[0].toString().split("-");
                loc3 = loc4[1].toString().split(":");
                if (loc2.length == 3 && loc3.length == 3) 
                {
                    loc1 = new Date();
                    loc1.setFullYear(loc2[0], (loc2[1] - 1), loc2[2]);
                    loc1.setHours(loc3[0], loc3[1], loc3[2], 0);
                }
            }
            return loc1;
        }

        
        {
            formattedDate = init.BackendInitializer.getInstance().createDateFormatterMx();
        }

        public static const CENTURY_IN_MILLISECONDS:Number=3.1104e+012;

        public static const DAY_IN_MILLISECONDS:Number=86400000;

        public static const HOUR_IN_MILLISECONDS:Number=3600000;

        public static const MILLENIUM_IN_MILLISECONDS:Number=3.1104e+015;

        public static const MINUTE_IN_MILLISECONDS:Number=60000;

        public static const MONTH_IN_MILLISECONDS:Number=2592000000;

        public static const WEEK_IN_MILLISECONDS:Number=604800000;

        public static const YEAR_IN_MILLISECONDS:Number=31104000000;

        public static var formattedDate:utils.interfaces.ICustomFormatter;
    }
}


