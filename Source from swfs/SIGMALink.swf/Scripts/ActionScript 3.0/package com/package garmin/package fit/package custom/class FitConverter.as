//class FitConverter
package com.garmin.fit.custom 
{
    public class FitConverter extends Object
    {
        public function FitConverter()
        {
            super();
            return;
        }

        public static function convertDegreeToSemicircles(arg1:Number):int
        {
            var loc1:*=arg1 / (180 / Math.pow(2, 31));
            return loc1;
        }

        public static function convertSemicirclesToDegree(arg1:int):Number
        {
            return arg1 * (180 / Math.pow(2, 31) as Number);
        }

        public static function convertKilometersPerHourToMetersPerSecond(arg1:Number):Number
        {
            return arg1 * 1 / 3.6;
        }

        public static function convertMetersPerSecondToKilometersPerHour(arg1:Number):Number
        {
            return arg1 / 3600000;
        }
    }
}


