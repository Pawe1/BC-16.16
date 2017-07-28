//package date
//  class CalendarUtil
package utils.date 
{
    import flash.utils.*;
    
    public class CalendarUtil extends Object
    {
        public function CalendarUtil()
        {
            super();
            return;
        }

        public static function calculateCalendarWeek(arg1:Date):uint
        {
            var loc8:*=0;
            var loc4:*=0;
            var loc9:*=null;
            var loc11:*=0;
            var loc14:*=false;
            var loc17:*=null;
            var loc10:*=0;
            var loc1:*=false;
            var loc7:*=0;
            var loc13:*;
            var loc6:*=(loc13 = new Date(arg1.fullYear, arg1.month, arg1.date)).time + "_" + weekCalculationStandard;
            if (kwCalculated[loc6] != undefined) 
            {
                ++reuseCalculatedCalendarWeekCount;
                return kwCalculated[loc6];
            }
            ++calculateCalendarWeekCount;
            loc13.hours = 12;
            var loc2:*=daysFromBeginningDate(loc13);
            var loc12:*=new Date(loc13.fullYear, 0, 1, 12);
            var loc15:*=daysFromBeginningDate(loc12);
            var loc16:*=new Date(loc13.fullYear, 0, 4, 12);
            var loc3:*=daysFromBeginningDate(loc16);
            var loc5:*=1;
            var loc18:*=weekCalculationStandard;
            while ("i" === loc18) 
            {
                loc5 = isoWeekNumber(loc13);
            }
        }

        public static function calculateMaxCalendarWeek(arg1:Date):int
        {
            var loc2:*=new Date(arg1.fullYear, 11, 31);
            var loc1:*=calculateCalendarWeek(loc2);
            if (loc1 == 1) 
            {
                loc2.date = loc2.date - 7;
                loc1 = calculateCalendarWeek(loc2);
            }
            return loc1;
        }

        public static function calculateCalendarWeekObject(arg1:Date):utils.date.Week
        {
            var loc2:*=null;
            var loc4:*=0;
            var loc1:*=0;
            var loc3:*=calculateCalendarWeek(arg1);
            if (arg1.month == 11 || arg1.month == 0) 
            {
                loc4 = calculateFirstWeekOfMonth(0, arg1.fullYear + 1);
                loc1 = calculateMaxCalendarWeek(new Date((arg1.fullYear - 1), 11, 31, 12));
                if (weekCalculationStandard != "i") 
                {
                    if (weekCalculationStandard == "a") 
                    {
                        loc2 = new utils.date.Week(loc3, arg1.fullYear);
                    }
                }
                else if (loc3 == loc4 && arg1.month == 11) 
                {
                    loc2 = new utils.date.Week(loc3, arg1.fullYear + 1);
                }
                else if (loc3 == loc1 && arg1.month == 0) 
                {
                    loc2 = new utils.date.Week(loc3, (arg1.fullYear - 1));
                }
                else 
                {
                    loc2 = new utils.date.Week(loc3, arg1.fullYear);
                }
            }
            else 
            {
                loc2 = new utils.date.Week(loc3, arg1.fullYear);
            }
            return loc2;
        }

        public static function calculateMaxCalendarWeekObject(arg1:Date):utils.date.Week
        {
            var loc2:*=calculateMaxCalendarWeek(arg1);
            var loc1:*=new utils.date.Week(loc2, arg1.fullYear);
            return loc1;
        }

        public static function calculateWeekYear(arg1:Date):utils.date.Week
        {
            var loc3:*=new Date(arg1.fullYear, arg1.month, arg1.date - 3);
            while (loc3.day != 4) 
            {
                --loc3.date;
            }
            var loc1:*=calculateCalendarWeek(arg1);
            var loc2:*=new utils.date.Week(loc1, loc3.fullYear);
            return loc2;
        }

        public static function thursday(arg1:Date):Date
        {
            var loc1:*=new Date();
            loc1.setTime(arg1.getTime() + (3 - (arg1.getDay() + 6) % 7) * 86400000);
            return loc1;
        }

        public static function scrubTimeValue(arg1:Object):Object
        {
            var loc1:*=null;
            if (arg1 is Date) 
            {
                return new Date(arg1.getFullYear(), arg1.getMonth(), arg1.getDate());
            }
            if (arg1 is Object) 
            {
                loc1 = {};
                if (arg1.rangeStart) 
                {
                    loc1.rangeStart = new Date(arg1.rangeStart.getFullYear(), arg1.rangeStart.getMonth(), arg1.rangeStart.getDate());
                }
                if (arg1.rangeEnd) 
                {
                    loc1.rangeEnd = new Date(arg1.rangeEnd.getFullYear(), arg1.rangeEnd.getMonth(), arg1.rangeEnd.getDate());
                }
                return loc1;
            }
            return null;
        }

        public static function scrubTimeValues(arg1:Array):Array
        {
            var loc1:*=0;
            var loc2:*=[];
            loc1 = 0;
            while (loc1 < arg1.length) 
            {
                loc2[loc1] = scrubTimeValue(arg1[loc1]);
                ++loc1;
            }
            return loc2;
        }

        public static function getNumberOfDaysInMonth(arg1:int, arg2:int):int
        {
            var loc1:*=0;
            if (arg2 != 1) 
            {
                if (arg2 == 3 || arg2 == 5 || arg2 == 8 || arg2 == 10) 
                {
                    loc1 = 30;
                }
                else 
                {
                    loc1 = 31;
                }
            }
            else if (arg1 % 4 == 0 && !(arg1 % 100 == 0) || arg1 % 400 == 0) 
            {
                loc1 = 29;
            }
            else 
            {
                loc1 = 28;
            }
            return loc1;
        }

        public static function maxMonthDaysTest(arg1:Date):uint
        {
            var loc2:*=31;
            var loc1:*=new Date(arg1.fullYear, arg1.month, loc2);
            while (loc1.date != loc2) 
            {
                --loc2;
                loc1 = new Date(arg1.fullYear, arg1.month, loc2);
            }
            return loc2;
        }

        public static function calculateCalendarWeekMondayDate(arg1:uint, arg2:uint):Date
        {
            var loc2:*=firstMonday(arg2);
            var loc1:*=calculateCalendarWeek(loc2);
            if (loc1 > arg1) 
            {
                loc2.date = loc2.date - 7;
                loc1 = calculateCalendarWeek(loc2);
            }
            loc2.time = loc2.time + 604800000 * (arg1 - loc1);
            return loc2;
        }

        public static function calculateCalendarWeekSundayDate(arg1:uint, arg2:uint):Date
        {
            var loc2:*=firstSunday(arg2);
            var loc1:*=calculateCalendarWeek(loc2);
            if (loc1 > arg1) 
            {
                if (loc2.fullYear == arg2) 
                {
                    loc2.date = loc2.date - 7;
                    loc1 = calculateCalendarWeek(loc2);
                    if (loc2.fullYear < arg2) 
                    {
                        return loc2;
                    }
                }
            }
            loc2.time = loc2.time + 604800000 * (arg1 - loc1);
            return loc2;
        }

        public static function calculateFirstWeekOfMonth(arg1:int, arg2:int):int
        {
            var loc1:*=null;
            if (arg1 == 0) 
            {
                return 1;
            }
            loc1 = new Date(arg2, arg1, 1, 12);
            return calculateCalendarWeek(loc1);
        }

        public static function calculateDayOfYear(arg1:Date):uint
        {
            var loc2:*=new Date(arg1.fullYear, 0, 1);
            var loc1:*=(arg1.time - loc2.time) / 86400000;
            ++loc1;
            return loc1;
        }

        public static function calculateDateFromDayOfYear(arg1:uint, arg2:uint):Date
        {
            var loc1:*=new Date(arg2, 0, 1);
            --arg1;
            loc1.time = loc1.time + arg1 * 86400000;
            return loc1;
        }

        internal static function isoWeekNumber(arg1:Date):int
        {
            var loc3:*=0;
            var loc8:*=null;
            arg1.hours = 12;
            var loc2:*=daysFromBeginningDate(arg1);
            var loc10:*=new Date(arg1.fullYear, 0, 1, 12);
            var loc4:*=daysFromBeginningDate(loc10);
            var loc11:*=new Date(arg1.fullYear, 11, 31, 12);
            var loc6:*=daysFromBeginningDate(loc11);
            var loc5:*=loc10.day <= 1 ? 1 - loc10.day : 8 - loc10.day;
            var loc12:*;
            (loc12 = new Date()).time = loc10.time + 86400000 * loc5;
            var loc9:*;
            var loc1:*=(loc9 = daysFromBeginningDate(loc12)) > 4;
            var loc7:*=loc11.day < 4;
            if (loc2 >= loc9) 
            {
                if (loc7 && loc2 > loc6 - loc11.day) 
                {
                    return 1;
                }
                loc3 = Math.floor((loc2 - loc9) / 7);
                return loc1 ? loc3 + 2 : loc3 + 1;
            }
            if (loc1) 
            {
                return 1;
            }
            loc8 = new Date((arg1.fullYear - 1), 11, 31, 12);
            return isoWeekNumber(loc8);
        }

        internal static function leapGregorian(arg1:int):Boolean
        {
            return arg1 % 4 == 0 && !(arg1 % 100 == 0 && !(arg1 % 400 == 0));
        }

        internal static function daysFromBeginningDate(arg1:Date):int
        {
            return daysFromBeginning(arg1.fullYear, arg1.month, arg1.date);
        }

        internal static function daysFromBeginning(arg1:int, arg2:int, arg3:int):int
        {
            var loc3:*=0;
            var loc4:*=0;
            var loc2:*=[31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
            var loc1:*=0;
            loc3 = 0;
            while (loc3 < arg2) 
            {
                loc4 = loc2[loc3];
                if (1 == loc3 && leapGregorian(arg1)) 
                {
                    ++loc4;
                }
                loc1 = loc1 + loc4;
                ++loc3;
            }
            return loc1 = loc1 + arg3;
        }

        internal static function firstMonday(arg1:uint):Date
        {
            var loc1:*=new Date(arg1, 0, 1);
            if (loc1.day > 1) 
            {
                loc1.date = loc1.date + (7 - (loc1.day - 1));
            }
            else if (loc1.day < 1) 
            {
                loc1.date = loc1.date + 1;
            }
            return loc1;
        }

        internal static function firstSunday(arg1:uint):Date
        {
            var loc1:*=new Date(arg1, 0, 1);
            if (loc1.day > 0) 
            {
                loc1.date = loc1.date + (7 - loc1.day);
            }
            return loc1;
        }

        
        {
            kwCalculated = new flash.utils.Dictionary();
        }

        public static const NUMBERING_FIRST_DAY_IS_MONDAY:String="j";

        public static const NUMBERING_FIRST_DAY_IS_SUNDAY:String="a";

        public static const NUMBERING_SIMPLE:String="s";

        public static const NUMBERING_STANDARD_ISO_8601:String="i";

        public static var weekCalculationStandard:String="i";

        internal static var calculateCalendarWeekCount:int=0;

        internal static var kwCalculated:flash.utils.Dictionary;

        internal static var reuseCalculatedCalendarWeekCount:int=0;
    }
}


//  class DateUtilCommon
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


//  class Week
package utils.date 
{
    public class Week extends Object
    {
        public function Week(arg1:uint=0, arg2:uint=0)
        {
            super();
            week = arg1;
            year = arg2;
            return;
        }

        public var week:uint;

        public var year:uint;
    }
}


