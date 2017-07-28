//package formatter
//  class DateFormatterMx
package utils.formatter 
{
    import utils.interfaces.*;
    
    public class DateFormatterMx extends Object implements utils.interfaces.ICustomFormatter
    {
        public function DateFormatterMx()
        {
            super();
            return;
        }

        public function get formatString():String
        {
            return _formatString;
        }

        public function set formatString(arg1:String):void
        {
            _formatString = arg1;
            return;
        }

        public function format(arg1:Object):String
        {
            var loc4:*=null;
            var loc1:*=null;
            if (arg1 is Number) 
            {
                (loc4 = new Date()).setTime(arg1 as Number);
                arg1 = loc4;
            }
            if (arg1 is Date) 
            {
                loc1 = arg1 as Date;
                var loc5:*=loc1.month + 1;
                var loc7:*=loc1.date;
                var loc6:*=loc1.hours;
                var loc8:*=loc1.minutes;
                var loc3:*=loc1.seconds;
                var loc2:*=formatString;
                if (loc2.indexOf("YYYY") == -1) 
                {
                    if (loc2.indexOf("YY") != -1) 
                    {
                        loc2 = loc2.replace("YYYY", loc1.fullYear.toString().substr(2, 2));
                    }
                }
                else 
                {
                    loc2 = loc2.replace("YYYY", loc1.fullYear);
                }
                loc2 = loc2.replace("MM", loc5 < 10 ? "0" + loc5 : loc5);
                loc2 = loc2.replace("DD", loc7 < 10 ? "0" + loc7 : loc7);
                if (formatString.indexOf("12") == -1) 
                {
                    loc2 = loc2.replace("JJ", loc6 < 10 ? "0" + loc6 : loc6);
                    loc2 = loc2.replace("NN", loc8 < 10 ? "0" + loc8 : loc8);
                    loc2 = loc2.replace("SS", loc3 < 10 ? "0" + loc3 : loc3);
                }
                else 
                {
                    if (loc6 != 0) 
                    {
                        if (loc6 >= 1 && loc6 <= 11) 
                        {
                            loc2 = loc2.replace("12", "AM");
                        }
                        else if (loc6 != 12) 
                        {
                            if (loc6 >= 13 && loc6 <= 23) 
                            {
                                loc6 = loc6 - 12;
                                loc2 = loc2.replace("12", "PM");
                            }
                        }
                        else 
                        {
                            loc6 = 12;
                            loc2 = loc2.replace("12", "PM");
                        }
                    }
                    else 
                    {
                        loc6 = 12;
                        loc2 = loc2.replace("12", "AM");
                    }
                    loc2 = loc2.replace("JJ", loc6);
                    loc2 = loc2.replace("NN", loc8 < 10 ? "0" + loc8 : loc8);
                    loc2 = loc2.replace("SS", loc3 < 10 ? "0" + loc3 : loc3);
                }
                return loc2;
            }
            return null;
        }

        public static const CLOCK_12:String="JJ:NN 12";

        public static const CLOCK_24:String="JJ:NN";

        public static const EU_FORMAT:String="DD.MM.YYYY";

        public static const US_FORMAT:String="MM/DD/YYYY";

        internal var _formatString:String="MM/DD/YYYY";
    }
}


