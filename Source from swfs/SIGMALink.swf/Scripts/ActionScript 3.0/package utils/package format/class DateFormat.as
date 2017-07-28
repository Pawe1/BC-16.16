//class DateFormat
package utils.format 
{
    public class DateFormat extends Object
    {
        public function DateFormat()
        {
            super();
            return;
        }

        public static function GET_DATEFORMAT(arg1:String):String
        {
            var loc1:*=DATEFORMATS.indexOf(arg1);
            return DATEFORMAT_FORMATS[loc1];
        }

        public static function GET_DATEFORMAT_SPARK(arg1:String):String
        {
            var loc1:*=DATEFORMATS.indexOf(arg1);
            return DATEFORMAT_FORMATS_SPARK[loc1];
        }

        public static const AMERICAN:String="us";

        public static const AMERICAN_FORMAT:String="MM/DD/YYYY";

        public static const AMERICAN_FORMAT_SHORT:String="MM/dd";

        public static const AMERICAN_FORMAT_SPARK:String="MM/dd/yyyy";

        public static const DATEFORMATS:Array=["eu", "us"];

        public static const DATEFORMAT_FORMATS:Array=["DD.MM.YYYY", "MM/DD/YYYY"];

        public static const DATEFORMAT_FORMATS_SPARK:Array=["dd.MM.yyyy", "MM/dd/yyyy"];

        public static const DD_MM_YY:String="dd.MM.yy";

        public static const EUROPEAN:String="eu";

        public static const EUROPEAN_FORMAT:String="DD.MM.YYYY";

        public static const EUROPEAN_FORMAT_SHORT:String="dd.MM";

        public static const EUROPEAN_FORMAT_SPARK:String="dd.MM.yyyy";

        public static const MM_DD_YY:String="MM/dd/yy";
    }
}


