//class FileExtension
package utils.file 
{
    public class FileExtension extends Object
    {
        public function FileExtension()
        {
            super();
            return;
        }

        public static function createFileName(arg1:String):String
        {
            var loc1:*=createRandomNumber(1, 100);
            var loc3:*;
            var loc2:*=(loc3 = new Date()).date.toString() + loc3.month.toString() + loc3.fullYear.toString() + loc3.hours.toString() + loc3.minutes.toString() + loc3.seconds.toString() + loc3.milliseconds.toString() + loc1;
            return loc2 + "." + arg1;
        }

        public static function createRandomNumber(arg1:Number, arg2:Number):Number
        {
            var loc1:*=Math.floor(Math.random() * (arg2 - arg1 + 1)) + arg1;
            return loc1;
        }

        public static const CSV_FILE:String="csv";

        public static const FILTER_FILE:String="sff";

        public static const FIT_FILE:String="fit";

        public static const GPX_FILE:String="gpx";

        public static const KML_FILE:String="kml";

        public static const KMZ_FILE:String="kmz";

        public static const LOG_FILE:String="slf";

        public static const MEMORY_FILE:String="smf";

        public static const POINT_NAVIGATION:String="spn";

        public static const SETTING_FILE:String="ssf";

        public static const SPORTPROFILE:String="ssp";

        public static const TCX_FILE:String="tcx";

        public static const TRACK_FILE:String="stf";

        public static const TRAININGPROGRAM_FILE:String="spf";

        public static const XLSX_FILE:String="xlsx";
    }
}


