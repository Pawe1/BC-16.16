//class ClockFormat
package utils.format 
{
    import core.general.interfaces.*;
    import init.*;
    import utils.interfaces.*;
    
    public class ClockFormat extends Object
    {
        public function ClockFormat()
        {
            super();
            return;
        }

        public static function GET_CLOCKFORMAT(arg1:String):String
        {
            var loc1:*=CLOCK_FORMATS.indexOf(arg1);
            return CLOCK_FORMATS[loc1];
        }

        public static function formatClock(arg1:Object, arg2:String=null, arg3:String=null):String
        {
            var loc1:*=null;
            if (arg1 is core.general.interfaces.IGeneralDataInformation) 
            {
                loc1 = (arg1 as core.general.interfaces.IGeneralDataInformation).startDate;
            }
            else if (arg1 is core.general.interfaces.IDate) 
            {
                loc1 = (arg1 as core.general.interfaces.IDate).date;
            }
            else if (arg1 is Date) 
            {
                loc1 = arg1 as Date;
            }
            var loc2:*=init.BackendInitializer.getInstance().createDateFormatterMx();
            return loc2.format(loc1);
        }

        public static const AM:String="AM";

        public static const CLOCK_12H:String="12";

        public static const CLOCK_24H:String="24";

        public static const CLOCK_FORMATS:Array=["24", "12"];

        public static const PM:String="PM";
    }
}


