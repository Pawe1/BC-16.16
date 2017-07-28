//class FitErrorLoggingTyp
package com.garmin.fit.custom 
{
    public class FitErrorLoggingTyp extends Object
    {
        public function FitErrorLoggingTyp()
        {
            super();
            return;
        }

        public static const ERROR_ENCODING_CODE:int=1800000;

        public static const ERROR_ENCODING_DESC:String="FitEncoding: ";

        public static const ERROR_ENCODING_VALUE_OUT_OF_RANGE_CODE:int=1800003;

        public static const ERROR_ENCODING_VALUE_OUT_OF_RANGE_DESC:String="FitEncoding > Field > Value to encode is out of its defined range: ";

        public static const ERROR_LOGICAL_CODE:int=1800001;

        public static const ERROR_LOGICAL_DESC:String="FITEncoding > Logical Error: ";

        public static const ERROR_CLOSING_FITFILE_CODE:int=1800002;

        public static const ERROR_CLOSING_FITFILE_DESC:String="FitEncoding > generateFitFile: Unable to close the File after Writing";

        public static const ERROR_DECODING_FITFILE_CODE:int=1800003;

        public static const ERROR_DECODING_FITFILE_DESC:String="FitDecoding > generateLogFile: Unable to create LogFile";

        public static const ERROR_DECODING_FITFILE_VERIFICATIONTEST_FAILED_CODE:int=1800004;

        public static const ERROR_DECODING_FITFILE_VERIFICATIONTEST_FAILED_DESC:String="FitDecoding > FIT file verification failure.";

        public static const ERROR_DECODING_FITFILE_INTEGRATIONTEST_FAILED_CODE:int=1800005;

        public static const ERROR_DECODING_FITFILE_INTEGRATIONTEST_FAILED_DESC:String="FitDecoding > FIT file integrity failure.";
    }
}


