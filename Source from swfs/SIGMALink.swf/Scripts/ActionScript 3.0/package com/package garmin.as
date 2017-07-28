//package garmin
//  package fit
//    package custom
//      package rox100
//        class SigmaBreakMesg
package com.garmin.fit.custom.rox100 
{
    import com.garmin.fit.*;
    
    public class SigmaBreakMesg extends com.garmin.fit.custom.rox100.SigmaMarkerROX100Mesg
    {
        public function SigmaBreakMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(65283));
            return;
        }

        public function getMarkerDuration():Number
        {
            return getFieldDoubleValue(1, 0, 65535);
        }

        public function setMarkerDuration(arg1:Number):void
        {
            setFieldValue(1, 0, arg1, 65535);
            return;
        }

        public function getMarkerAltitudeDownhill():int
        {
            return getFieldDoubleValue(21, 0, 65535);
        }

        public function setMarkerAltitudeDownhill(arg1:int):void
        {
            setFieldValue(21, 0, arg1, 65535);
            return;
        }

        public function getMarkerAltitudeUphill():int
        {
            return getFieldDoubleValue(22, 0, 65535);
        }

        public function setMarkerAltitudeUphill(arg1:int):void
        {
            setFieldValue(22, 0, arg1, 65535);
            return;
        }

        public function getMarkerAverageAltitude():Number
        {
            return getFieldDoubleValue(40, 0, 65535);
        }

        public function setMarkerAverageAltitude(arg1:Number):void
        {
            setFieldValue(40, 0, arg1, 65535);
            return;
        }

        public function getMarkerMaximumAltitude():Number
        {
            return getFieldDoubleValue(41, 0, 65535);
        }

        public function setMarkerMaximumAltitude(arg1:Number):void
        {
            setFieldValue(41, 0, arg1, 65535);
            return;
        }

        public function getMarkerAverageCadence():int
        {
            return getFieldIntegerValue(50, 0, 65535);
        }

        public function setMarkerAverageCadence(arg1:int):void
        {
            setFieldValue(50, 0, arg1, 65535);
            return;
        }

        public function getMarkerMaximumCadence():int
        {
            return getFieldIntegerValue(51, 0, 65535);
        }

        public function setMarkerMaximumCadence(arg1:int):void
        {
            setFieldValue(51, 0, arg1, 65535);
            return;
        }

        public function getMarkerMinimumHeartrate():int
        {
            return getFieldIntegerValue(60, 0, 65535);
        }

        public function setMarkerMinimumHeartrate(arg1:int):void
        {
            setFieldValue(60, 0, arg1, 65535);
            return;
        }

        public function getMarkerAverageHeartrate():int
        {
            return getFieldIntegerValue(61, 0, 65535);
        }

        public function setMarkerAverageHeartrate(arg1:int):void
        {
            setFieldValue(61, 0, arg1, 65535);
            return;
        }

        public function getMarkerMaximumHeartrate():int
        {
            return getFieldIntegerValue(62, 0, 65535);
        }

        public function setMarkerMaximumHeartrate(arg1:int):void
        {
            setFieldValue(62, 0, arg1, 65535);
            return;
        }

        public function getMarkerAverageSpeed():Number
        {
            return getFieldDoubleValue(70, 0, 65535);
        }

        public function setMarkerAverageSpeed(arg1:Number):void
        {
            setFieldValue(70, 0, arg1, 65535);
            return;
        }

        public function getMarkerMaximumSpeed():Number
        {
            return getFieldDoubleValue(71, 0, 65535);
        }

        public function setMarkerMaximumSpeed(arg1:Number):void
        {
            setFieldValue(71, 0, arg1, 65535);
            return;
        }

        public function getMarkerAverageInclineUphill():Number
        {
            return getFieldDoubleValue(80, 0, 65535);
        }

        public function setMarkerAverageInclineUphill(arg1:Number):void
        {
            setFieldValue(80, 0, arg1, 65535);
            return;
        }

        public function getMarkerMaximumInclineUphill():Number
        {
            return getFieldDoubleValue(81, 0, 65535);
        }

        public function setMarkerMaximumInclineUphill(arg1:Number):void
        {
            setFieldValue(81, 0, arg1, 65535);
            return;
        }

        public function getMarkerAverageInclineDownhill():Number
        {
            return getFieldDoubleValue(82, 0, 65535);
        }

        public function setMarkerAverageInclineDownhill(arg1:Number):void
        {
            setFieldValue(82, 0, arg1, 65535);
            return;
        }

        public function getMarkerMaximumInclineDownhill():Number
        {
            return getFieldDoubleValue(83, 0, 65535);
        }

        public function setMarkerMaximumInclineDownhill(arg1:Number):void
        {
            setFieldValue(83, 0, arg1, 65535);
            return;
        }

        public function getMarkerAveragePower():int
        {
            return getFieldIntegerValue(90, 0, 65535);
        }

        public function setMarkerAveragePower(arg1:int):void
        {
            setFieldValue(90, 0, arg1, 65535);
            return;
        }

        public function getMarkerMaximumPower():int
        {
            return getFieldIntegerValue(91, 0, 65535);
        }

        public function setMarkerMaximumPower(arg1:int):void
        {
            setFieldValue(91, 0, arg1, 65535);
            return;
        }

        public function getMarkerCalories():int
        {
            return getFieldIntegerValue(100, 0, 65535);
        }

        public function setMarkerCalories(arg1:int):void
        {
            setFieldValue(100, 0, arg1, 65535);
            return;
        }

        public function getMarkerLatitude():int
        {
            return getFieldIntegerValue(110, 0, 65535);
        }

        public function setMarkerLatitude(arg1:int):void
        {
            setFieldValue(110, 0, arg1, 65535);
            return;
        }

        public function getMarkerLongitude():int
        {
            return getFieldIntegerValue(111, 0, 65535);
        }

        public function setMarkerLongitude(arg1:int):void
        {
            setFieldValue(111, 0, arg1, 65535);
            return;
        }

        public function getMarkerDistance():Number
        {
            return getFieldDoubleValue(120, 0, 65535);
        }

        public function setMarkerDistance(arg1:Number):void
        {
            setFieldValue(120, 0, arg1, 65535);
            return;
        }

        public static function get markerROX100MBreakMesg():com.garmin.fit.Mesg
        {
            return _markerROX100Mesg;
        }

        
        {
            _markerROX100Mesg = new com.garmin.fit.Mesg("sigmaBreak", 65283);
            _markerROX100Mesg.addField(createDescription());
            _markerROX100Mesg.addField(createMarkerTime());
            _markerROX100Mesg.addField(createTitle());
            _markerROX100Mesg.addField(new com.garmin.fit.Field("duration", 1, 134, 1, 0, "s"));
            _markerROX100Mesg.addField(createMarkerDistanceAbsolute());
            _markerROX100Mesg.addField(createMarkerDistanceDownhill());
            _markerROX100Mesg.addField(createMarkerDistanceUphill());
            _markerROX100Mesg.addField(createMarkerTimeAbsolute());
            _markerROX100Mesg.addField(new com.garmin.fit.Field("altitudeDownhill", 21, 134, 1, 0, "mm"));
            _markerROX100Mesg.addField(new com.garmin.fit.Field("altitudeUphill", 22, 134, 1, 0, "mm"));
            _markerROX100Mesg.addField(createMarkerMinimumSpeed());
            _markerROX100Mesg.addField(createMarkerTimeDownhill());
            _markerROX100Mesg.addField(createMarkerTimeUphill());
            _markerROX100Mesg.addField(new com.garmin.fit.Field("averageAltitude", 40, 133, 1, 0, "mm"));
            _markerROX100Mesg.addField(new com.garmin.fit.Field("maximumAltitude", 41, 133, 1, 0, "mm"));
            _markerROX100Mesg.addField(new com.garmin.fit.Field("averageCadence", 50, 132, 1000, 0, "rpm"));
            _markerROX100Mesg.addField(new com.garmin.fit.Field("maximumCadence", 51, 2, 1, 0, "rpm"));
            _markerROX100Mesg.addField(new com.garmin.fit.Field("minimumHeartrate", 60, 2, 1, 0, "bpm"));
            _markerROX100Mesg.addField(new com.garmin.fit.Field("averageHeartrate", 61, 2, 1, 0, "bpm"));
            _markerROX100Mesg.addField(new com.garmin.fit.Field("maximumHeartrate", 62, 2, 1, 0, "bpm"));
            _markerROX100Mesg.addField(new com.garmin.fit.Field("averageSpeed", 70, 132, 1000, 0, "m/s"));
            _markerROX100Mesg.addField(new com.garmin.fit.Field("maximumSpeed", 71, 132, 1000, 0, "m/s"));
            _markerROX100Mesg.addField(new com.garmin.fit.Field("averageInclineUphill", 80, 134, 10000, 1, "%"));
            _markerROX100Mesg.addField(new com.garmin.fit.Field("maximumInclineUphill", 81, 132, 100, 0, "%"));
            _markerROX100Mesg.addField(new com.garmin.fit.Field("averageInclineDownhill", 82, 134, 10000, 0, "%"));
            _markerROX100Mesg.addField(new com.garmin.fit.Field("maximumInclineDownhill", 83, 131, 100, 0, "%"));
            _markerROX100Mesg.addField(new com.garmin.fit.Field("averagePower", 90, 132, 1, 0, "watts"));
            _markerROX100Mesg.addField(new com.garmin.fit.Field("maximumPower", 91, 132, 1, 0, "watts"));
            _markerROX100Mesg.addField(new com.garmin.fit.Field("calories", 100, 132, 1, 0, "kcal"));
            _markerROX100Mesg.addField(new com.garmin.fit.Field("latitude", 110, 133, 1, 0, "semicircles"));
            _markerROX100Mesg.addField(new com.garmin.fit.Field("longitude", 111, 133, 1, 0, "semicircles"));
            _markerROX100Mesg.addField(new com.garmin.fit.Field("distance", 120, 134, 100, 1, "m"));
        }

        internal static var _markerROX100Mesg:com.garmin.fit.Mesg;
    }
}


//        class SigmaLapMesg
package com.garmin.fit.custom.rox100 
{
    import com.garmin.fit.*;
    
    public class SigmaLapMesg extends com.garmin.fit.custom.rox100.SigmaMarkerROX100Mesg
    {
        public function SigmaLapMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(65282));
            return;
        }

        public static function get markerROX100LapMesg():com.garmin.fit.Mesg
        {
            return _markerROX100Mesg;
        }

        
        {
            _markerROX100Mesg = new com.garmin.fit.Mesg("sigmaLap", 65282);
            _markerROX100Mesg.addField(createDescription());
            _markerROX100Mesg.addField(createMarkerTime());
            _markerROX100Mesg.addField(createTitle());
            _markerROX100Mesg.addField(createMarkerDistanceAbsolute());
            _markerROX100Mesg.addField(createMarkerDistanceDownhill());
            _markerROX100Mesg.addField(createMarkerDistanceUphill());
            _markerROX100Mesg.addField(createMarkerTimeAbsolute());
            _markerROX100Mesg.addField(createMarkerMinimumSpeed());
            _markerROX100Mesg.addField(createMarkerTimeDownhill());
            _markerROX100Mesg.addField(createMarkerTimeUphill());
        }

        internal static var _markerROX100Mesg:com.garmin.fit.Mesg;
    }
}


//        class SigmaLogMesg
package com.garmin.fit.custom.rox100 
{
    import com.garmin.fit.*;
    
    public class SigmaLogMesg extends com.garmin.fit.Mesg
    {
        public function SigmaLogMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(65281));
            return;
        }

        public function getDistance():Number
        {
            return getFieldDoubleValue(0, 0, 65535);
        }

        public function setDistance(arg1:Number):void
        {
            setFieldValue(0, 0, arg1, 65535);
            return;
        }

        public function getWheelSize():int
        {
            return getFieldDoubleValue(1, 0, 65535);
        }

        public function setWheelSize(arg1:int):void
        {
            setFieldValue(1, 0, arg1, 65535);
            return;
        }

        public function getMinimumSpeed():Number
        {
            return getFieldDoubleValue(2, 0, 65535);
        }

        public function setMinimumSpeed(arg1:Number):void
        {
            setFieldValue(2, 0, arg1, 65535);
            return;
        }

        public function getMeasurement():String
        {
            return getFieldStringValue(3, 0, 65535);
        }

        public function setMeasurement(arg1:String):void
        {
            setFieldValue(3, 0, arg1, 65535);
            return;
        }

        public function getExerciseTime():Number
        {
            return getFieldDoubleValue(79, 0, 65535);
        }

        public function setExerciseTime(arg1:Number):void
        {
            setFieldValue(79, 0, arg1, 65535);
            return;
        }

        public function getHrMax():int
        {
            return getFieldIntegerValue(4, 0, 65535);
        }

        public function setHrMax(arg1:int):void
        {
            setFieldValue(4, 0, arg1, 65535);
            return;
        }

        public function getLatitudeStart():int
        {
            return getFieldIntegerValue(5, 0, 65535);
        }

        public function setLatitudeStart(arg1:int):void
        {
            setFieldValue(5, 0, arg1, 65535);
            return;
        }

        public function getLatitudeEnd():int
        {
            return getFieldIntegerValue(6, 0, 65535);
        }

        public function setLatitudeEnd(arg1:int):void
        {
            setFieldValue(6, 0, arg1, 65535);
            return;
        }

        public function getLongitudeStart():int
        {
            return getFieldIntegerValue(7, 0, 65535);
        }

        public function setLongitudeStart(arg1:int):void
        {
            setFieldValue(7, 0, arg1, 65535);
            return;
        }

        public function getLongitudeEnd():int
        {
            return getFieldIntegerValue(8, 0, 65535);
        }

        public function setLongitudeEnd(arg1:int):void
        {
            setFieldValue(8, 0, arg1, 65535);
            return;
        }

        public function getIntensityZone1Start():int
        {
            return getFieldIntegerValue(9, 0, 65535);
        }

        public function setIntensityZone1Start(arg1:int):void
        {
            setFieldValue(9, 0, arg1, 65535);
            return;
        }

        public function getIntensityZone2Start():int
        {
            return getFieldIntegerValue(10, 0, 65535);
        }

        public function setIntensityZone2Start(arg1:int):void
        {
            setFieldValue(10, 0, arg1, 65535);
            return;
        }

        public function getIntensityZone3Start():int
        {
            return getFieldIntegerValue(11, 0, 65535);
        }

        public function setIntensityZone3Start(arg1:int):void
        {
            setFieldValue(11, 0, arg1, 65535);
            return;
        }

        public function getIntensityZone4Start():int
        {
            return getFieldIntegerValue(12, 0, 65535);
        }

        public function setIntensityZone4Start(arg1:int):void
        {
            setFieldValue(12, 0, arg1, 65535);
            return;
        }

        public function getTimeInIntensityZone1():Number
        {
            return getFieldDoubleValue(13, 0, 65535);
        }

        public function setTimeInIntensityZone1(arg1:Number):void
        {
            setFieldValue(13, 0, arg1, 65535);
            return;
        }

        public function getTimeInIntensityZone2():Number
        {
            return getFieldDoubleValue(14, 0, 65535);
        }

        public function setTimeInIntensityZone2(arg1:Number):void
        {
            setFieldValue(14, 0, arg1, 65535);
            return;
        }

        public function getTimeInIntensityZone3():Number
        {
            return getFieldDoubleValue(15, 0, 65535);
        }

        public function setTimeInIntensityZone3(arg1:Number):void
        {
            setFieldValue(15, 0, arg1, 65535);
            return;
        }

        public function getTimeInIntensityZone4():Number
        {
            return getFieldDoubleValue(16, 0, 65535);
        }

        public function setTimeInIntensityZone4(arg1:Number):void
        {
            setFieldValue(16, 0, arg1, 65535);
            return;
        }

        public function getTimeUnderIntensityZone():Number
        {
            return getFieldDoubleValue(17, 0, 65535);
        }

        public function setTimeUnderIntensityZone(arg1:Number):void
        {
            setFieldValue(17, 0, arg1, 65535);
            return;
        }

        public function getTimeOverIntensityZone():Number
        {
            return getFieldDoubleValue(18, 0, 65535);
        }

        public function setTimeOverIntensityZone(arg1:Number):void
        {
            setFieldValue(18, 0, arg1, 65535);
            return;
        }

        public function getTrainingZone():String
        {
            return getFieldStringValue(19, 0, 65535);
        }

        public function setTrainingZone(arg1:String):void
        {
            setFieldValue(19, 0, arg1, 65535);
            return;
        }

        public function getLowerLimit():int
        {
            return getFieldIntegerValue(20, 0, 65535);
        }

        public function setLowerLimit(arg1:int):void
        {
            setFieldValue(20, 0, arg1, 65535);
            return;
        }

        public function getUpperLimit():int
        {
            return getFieldIntegerValue(21, 0, 65535);
        }

        public function setUpperLimit(arg1:int):void
        {
            setFieldValue(21, 0, arg1, 65535);
            return;
        }

        public function getTimeInZone():Number
        {
            return getFieldDoubleValue(22, 0, 65535);
        }

        public function setTimeInZone(arg1:Number):void
        {
            setFieldValue(22, 0, arg1, 65535);
            return;
        }

        public function getTimeOverZone():Number
        {
            return getFieldDoubleValue(23, 0, 65535);
        }

        public function setTimeOverZone(arg1:Number):void
        {
            setFieldValue(23, 0, arg1, 65535);
            return;
        }

        public function gettimeUnderZone():Number
        {
            return getFieldDoubleValue(24, 0, 65535);
        }

        public function settimeUnderZone(arg1:Number):void
        {
            setFieldValue(24, 0, arg1, 65535);
            return;
        }

        public function getCaloriesDifferenceFactor():Number
        {
            return getFieldDoubleValue(25, 0, 65535);
        }

        public function setCaloriesDifferenceFactor(arg1:Number):void
        {
            setFieldValue(25, 0, arg1, 65535);
            return;
        }

        public function getWorkInKJ():Number
        {
            return getFieldDoubleValue(26, 0, 65535);
        }

        public function setWorkInKJ(arg1:Number):void
        {
            setFieldValue(26, 0, arg1, 65535);
            return;
        }

        public function getAvgPowerWattPerKG():Number
        {
            return getFieldDoubleValue(27, 0, 65535);
        }

        public function setAvgPowerWattPerKG(arg1:Number):void
        {
            setFieldValue(27, 0, arg1, 65535);
            return;
        }

        public function getAveragePercentHRMax():Number
        {
            return getFieldDoubleValue(28, 0, 65535);
        }

        public function setAveragePercentHRMax(arg1:Number):void
        {
            setFieldValue(28, 0, arg1, 65535);
            return;
        }

        public function getMinimumPercentHRMax():Number
        {
            return getFieldDoubleValue(29, 0, 65535);
        }

        public function setMinimumPercentHRMax(arg1:Number):void
        {
            setFieldValue(29, 0, arg1, 65535);
            return;
        }

        public function getMaximumPercentHRMax():Number
        {
            return getFieldDoubleValue(30, 0, 65535);
        }

        public function setMaximumPercentHRMax(arg1:Number):void
        {
            setFieldValue(30, 0, arg1, 65535);
            return;
        }

        public function getMinimumAltitude():Number
        {
            return getFieldDoubleValue(31, 0, 65535);
        }

        public function setMinimumAltitude(arg1:Number):void
        {
            setFieldValue(31, 0, arg1, 65535);
            return;
        }

        public function getAverageTemperature():Number
        {
            return getFieldDoubleValue(32, 0, 65535);
        }

        public function setAverageTemperature(arg1:Number):void
        {
            setFieldValue(32, 0, arg1, 65535);
            return;
        }

        public function getMinimumTemperature():Number
        {
            return getFieldDoubleValue(33, 0, 65535);
        }

        public function setMinimumTemperature(arg1:Number):void
        {
            setFieldValue(33, 0, arg1, 65535);
            return;
        }

        public function getMaximumTemperature():Number
        {
            return getFieldDoubleValue(34, 0, 65535);
        }

        public function setMaximumTemperature(arg1:Number):void
        {
            setFieldValue(34, 0, arg1, 65535);
            return;
        }

        public function getMinimumIncline():Number
        {
            return getFieldDoubleValue(35, 0, 65535);
        }

        public function setMinimumIncline(arg1:Number):void
        {
            setFieldValue(35, 0, arg1, 65535);
            return;
        }

        public function getAverageRiseRate():Number
        {
            return getFieldDoubleValue(36, 0, 65535);
        }

        public function setAverageRiseRate(arg1:Number):void
        {
            setFieldValue(36, 0, arg1, 65535);
            return;
        }

        public function getMinimumRiseRate():Number
        {
            return getFieldDoubleValue(37, 0, 65535);
        }

        public function setMinimumRiseRate(arg1:Number):void
        {
            setFieldValue(37, 0, arg1, 65535);
            return;
        }

        public function getMaximumRiseRate():Number
        {
            return getFieldDoubleValue(38, 0, 65535);
        }

        public function setMaximumRiseRate(arg1:Number):void
        {
            setFieldValue(38, 0, arg1, 65535);
            return;
        }

        public function getMinimumCadence():int
        {
            return getFieldIntegerValue(39, 0, 65535);
        }

        public function setMinimumCadence(arg1:int):void
        {
            setFieldValue(39, 0, arg1, 65535);
            return;
        }

        public function getMinimumPower():int
        {
            return getFieldIntegerValue(40, 0, 65535);
        }

        public function setMinimumPower(arg1:int):void
        {
            setFieldValue(40, 0, arg1, 65535);
            return;
        }

        public function getDistanceUphill():Number
        {
            return getFieldDoubleValue(41, 0, 65535);
        }

        public function setDistanceUphill(arg1:Number):void
        {
            setFieldValue(41, 0, arg1, 65535);
            return;
        }

        public function getDistanceDownhill():Number
        {
            return getFieldDoubleValue(42, 0, 65535);
        }

        public function setDistanceDownhill(arg1:Number):void
        {
            setFieldValue(42, 0, arg1, 65535);
            return;
        }

        public function getRideTimeUphill():Number
        {
            return getFieldDoubleValue(43, 0, 65535);
        }

        public function setRideTimeUphill(arg1:Number):void
        {
            setFieldValue(43, 0, arg1, 65535);
            return;
        }

        public function getRideTimeDownhill():Number
        {
            return getFieldDoubleValue(44, 0, 65535);
        }

        public function setRrideTimeDownhill(arg1:Number):void
        {
            setFieldValue(44, 0, arg1, 65535);
            return;
        }

        public function getBike():String
        {
            return getFieldStringValue(45, 0, 65535);
        }

        public function setBike(arg1:String):void
        {
            setFieldValue(45, 0, arg1, 65535);
            return;
        }

        public function getBikeType1():String
        {
            return getFieldStringValue(46, 0, 65535);
        }

        public function setBikeType1(arg1:String):void
        {
            setFieldValue(46, 0, arg1, 65535);
            return;
        }

        public function getBikeWeight1():Number
        {
            return getFieldDoubleValue(47, 0, 65535);
        }

        public function setBikeWeight1(arg1:Number):void
        {
            setFieldValue(47, 0, arg1, 65535);
            return;
        }

        public function getBikeWeight1Unit():String
        {
            return getFieldStringValue(48, 0, 65535);
        }

        public function setBikeWeight1Unit(arg1:String):void
        {
            setFieldValue(48, 0, arg1, 65535);
            return;
        }

        public function getBikeType2():String
        {
            return getFieldStringValue(49, 0, 65535);
        }

        public function setBikeType2(arg1:String):void
        {
            setFieldValue(49, 0, arg1, 65535);
            return;
        }

        public function getBikeWeight2():Number
        {
            return getFieldDoubleValue(50, 0, 65535);
        }

        public function setBikeWeight2(arg1:Number):void
        {
            setFieldValue(50, 0, arg1, 65535);
            return;
        }

        public function getBikeWeight2Unit():String
        {
            return getFieldStringValue(51, 0, 65535);
        }

        public function setBikeWeight2Unit(arg1:String):void
        {
            setFieldValue(51, 0, arg1, 65535);
            return;
        }

        public function getBodyHeight():Number
        {
            return getFieldDoubleValue(52, 0, 65535);
        }

        public function setBodyHeight(arg1:Number):void
        {
            setFieldValue(52, 0, arg1, 65535);
            return;
        }

        public function getBodyHeightUnit():String
        {
            return getFieldStringValue(53, 0, 65535);
        }

        public function setBodyHeightUnit(arg1:String):void
        {
            setFieldValue(53, 0, arg1, 65535);
            return;
        }

        public function getShoulderWidth():Number
        {
            return getFieldDoubleValue(54, 0, 65535);
        }

        public function setShoulderWidth(arg1:Number):void
        {
            setFieldValue(54, 0, arg1, 65535);
            return;
        }

        public function getShoulderWidthUnit():String
        {
            return getFieldStringValue(55, 0, 65535);
        }

        public function setShoulderWidthUnit(arg1:String):void
        {
            setFieldValue(55, 0, arg1, 65535);
            return;
        }

        public function getGender():String
        {
            return getFieldStringValue(56, 0, 65535);
        }

        public function setGender(arg1:String):void
        {
            setFieldValue(56, 0, arg1, 65535);
            return;
        }

        public function getAge():int
        {
            return getFieldDoubleValue(57, 0, 65535);
        }

        public function setAge(arg1:int):void
        {
            setFieldValue(57, 0, arg1, 65535);
            return;
        }

        public function getBodyWeight():Number
        {
            return getFieldDoubleValue(58, 0, 65535);
        }

        public function setBodyWeight(arg1:Number):void
        {
            setFieldValue(58, 0, arg1, 65535);
            return;
        }

        public function getBodyWeightUnit():String
        {
            return getFieldStringValue(59, 0, 65535);
        }

        public function setBodyWeightUnit(arg1:String):void
        {
            setFieldValue(59, 0, arg1, 65535);
            return;
        }

        public function getLogVersion():String
        {
            return getFieldStringValue(60, 0, 65535);
        }

        public function setLogVersion(arg1:String):void
        {
            setFieldValue(60, 0, arg1, 65535);
            return;
        }

        public function getLogType():String
        {
            return getFieldStringValue(61, 0, 65535);
        }

        public function setLogType(arg1:String):void
        {
            setFieldValue(61, 0, arg1, 65535);
            return;
        }

        public function getLogName():String
        {
            return getFieldStringValue(62, 0, 65535);
        }

        public function setLogName(arg1:String):void
        {
            setFieldValue(62, 0, arg1, 65535);
            return;
        }

        public function getDescription():String
        {
            return getFieldStringValue(63, 0, 65535);
        }

        public function setDescription(arg1:String):void
        {
            setFieldValue(63, 0, arg1, 65535);
            return;
        }

        public function getStartDate():String
        {
            return getFieldStringValue(64, 0, 65535);
        }

        public function setStartDate(arg1:String):void
        {
            setFieldValue(64, 0, arg1, 65535);
            return;
        }

        public function getStatistic():String
        {
            return getFieldStringValue(65, 0, 65535);
        }

        public function setStatistic(arg1:String):void
        {
            setFieldValue(65, 0, arg1, 65535);
            return;
        }

        public function getRating():int
        {
            return getFieldIntegerValue(66, 0, 65535);
        }

        public function setRating(arg1:int):void
        {
            setFieldValue(66, 0, arg1, 65535);
            return;
        }

        public function getWeather():int
        {
            return getFieldIntegerValue(67, 0, 65535);
        }

        public function setWeather(arg1:int):void
        {
            setFieldValue(67, 0, arg1, 65535);
            return;
        }

        public function getWind():int
        {
            return getFieldIntegerValue(68, 0, 65535);
        }

        public function setWind(arg1:int):void
        {
            setFieldValue(68, 0, arg1, 65535);
            return;
        }

        public function getTrackProfile():int
        {
            return getFieldIntegerValue(69, 0, 65535);
        }

        public function setTrackProfile(arg1:int):void
        {
            setFieldValue(69, 0, arg1, 65535);
            return;
        }

        public function getTrainingType():String
        {
            return getFieldStringValue(70, 0, 65535);
        }

        public function setTrainingType(arg1:String):void
        {
            setFieldValue(70, 0, arg1, 65535);
            return;
        }

        public function getManualTemperature():Number
        {
            return getFieldDoubleValue(71, 0, 65535);
        }

        public function setManualTemperature(arg1:Number):void
        {
            setFieldValue(71, 0, arg1, 65535);
            return;
        }

        public function getTrainingTime():Number
        {
            return getFieldDoubleValue(72, 0, 65535);
        }

        public function setTrainingTime(arg1:Number):void
        {
            setFieldValue(72, 0, arg1, 65535);
            return;
        }

        public function getSamplingRate():Number
        {
            return getFieldDoubleValue(73, 0, 65535);
        }

        public function setSamplingRate(arg1:Number):void
        {
            setFieldValue(73, 0, arg1, 65535);
            return;
        }

        public function getPauseTime():Number
        {
            return getFieldDoubleValue(74, 0, 65535);
        }

        public function setPauseTime(arg1:Number):void
        {
            setFieldValue(74, 0, arg1, 65535);
            return;
        }

        public function getExternalLink():String
        {
            return getFieldStringValue(75, 0, 65535);
        }

        public function setExternalLink(arg1:String):void
        {
            setFieldValue(75, 0, arg1, 65535);
            return;
        }

        public function getDateCode():String
        {
            return getFieldStringValue(76, 0, 65535);
        }

        public function setDateCode(arg1:String):void
        {
            setFieldValue(76, 0, arg1, 65535);
            return;
        }

        public function getFirmware():String
        {
            return getFieldStringValue(77, 0, 65535);
        }

        public function setFirmware(arg1:String):void
        {
            setFieldValue(77, 0, arg1, 65535);
            return;
        }

        public function getUnitType():String
        {
            return getFieldStringValue(78, 0, 65535);
        }

        public function setUnitType(arg1:String):void
        {
            setFieldValue(78, 0, arg1, 65535);
            return;
        }

        public function getSerialNumber():String
        {
            return getFieldStringValue(80, 0, 65535);
        }

        public function setSerialNumber(arg1:String):void
        {
            setFieldValue(80, 0, arg1, 65535);
            return;
        }

        public static function get logMesg():com.garmin.fit.Mesg
        {
            return _logMesg;
        }

        
        {
            _logMesg = new com.garmin.fit.Mesg("sigmaLog", 65281);
            _logMesg.addField(new com.garmin.fit.Field("distance", 0, 134, 100, 0, "m"));
            _logMesg.addField(new com.garmin.fit.Field("wheelSize", 1, 132, 1, 0, "mm"));
            _logMesg.addField(new com.garmin.fit.Field("minimumSpeed", 2, 132, 1000, 0, "m/s"));
            _logMesg.addField(new com.garmin.fit.Field("measurement", 3, 7, 1, 0, ""));
            _logMesg.addField(new com.garmin.fit.Field("exerciseTime", 79, 134, 10, 0, "s"));
            _logMesg.addField(new com.garmin.fit.Field("hrMax", 4, 2, 1, 0, "bpm"));
            _logMesg.addField(new com.garmin.fit.Field("latitudeStart", 5, 133, 1, 0, "semicircles"));
            _logMesg.addField(new com.garmin.fit.Field("latitudeEnd", 6, 133, 1, 0, "semicircles"));
            _logMesg.addField(new com.garmin.fit.Field("longitudeStart", 7, 133, 1, 0, "semicircles"));
            _logMesg.addField(new com.garmin.fit.Field("longitudeEnd", 8, 133, 1, 0, "semicircles"));
            _logMesg.addField(new com.garmin.fit.Field("intensityZone1Start", 9, 2, 1, 0, "bpm"));
            _logMesg.addField(new com.garmin.fit.Field("intensityZone2Start", 10, 2, 1, 0, "bpm"));
            _logMesg.addField(new com.garmin.fit.Field("intensityZone3Start", 11, 2, 1, 0, "bpm"));
            _logMesg.addField(new com.garmin.fit.Field("intensityZone4Start", 12, 2, 1, 0, "bpm"));
            _logMesg.addField(new com.garmin.fit.Field("timeInIntensityZone1", 13, 134, 100, 0, "s"));
            _logMesg.addField(new com.garmin.fit.Field("timeInIntensityZone2", 14, 134, 100, 0, "s"));
            _logMesg.addField(new com.garmin.fit.Field("timeInIntensityZone3", 15, 134, 100, 0, "s"));
            _logMesg.addField(new com.garmin.fit.Field("timeInIntensityZone4", 16, 134, 100, 0, "s"));
            _logMesg.addField(new com.garmin.fit.Field("timeUnderIntensityZone", 17, 134, 100, 0, "s"));
            _logMesg.addField(new com.garmin.fit.Field("timeOverIntensityZone", 18, 134, 100, 0, "s"));
            _logMesg.addField(new com.garmin.fit.Field("trainingZone", 19, 7, 1, 0, ""));
            _logMesg.addField(new com.garmin.fit.Field("lowerLimit", 20, 2, 1, 0, "bpm"));
            _logMesg.addField(new com.garmin.fit.Field("upperLimit", 21, 2, 1, 0, "bpm"));
            _logMesg.addField(new com.garmin.fit.Field("timeInZone", 22, 134, 100, 0, "s"));
            _logMesg.addField(new com.garmin.fit.Field("timeOverZone", 23, 134, 100, 0, "s"));
            _logMesg.addField(new com.garmin.fit.Field("timeUnderZone", 24, 134, 100, 0, "s"));
            _logMesg.addField(new com.garmin.fit.Field("caloriesDifferenceFactor", 25, 133, 10000, 0, ""));
            _logMesg.addField(new com.garmin.fit.Field("workInKJ", 26, 134, 10000, 0, "kJ"));
            _logMesg.addField(new com.garmin.fit.Field("avgPowerWattPerKG", 27, 134, 10000, 0, "W/kg"));
            _logMesg.addField(new com.garmin.fit.Field("averagePercentHRMax", 28, 134, 10000, 0, "%"));
            _logMesg.addField(new com.garmin.fit.Field("minimumPercentHRMax", 29, 134, 10000, 0, "%"));
            _logMesg.addField(new com.garmin.fit.Field("maximumPercentHRMax", 30, 134, 10000, 0, "%"));
            _logMesg.addField(new com.garmin.fit.Field("minimumAltitude", 31, 133, 1, 0, "mm"));
            _logMesg.addField(new com.garmin.fit.Field("averageTemperature", 32, 133, 10000, 0, "°C"));
            _logMesg.addField(new com.garmin.fit.Field("minimumTemperature", 33, 131, 100, 0, "°C"));
            _logMesg.addField(new com.garmin.fit.Field("maximumTemperature", 34, 131, 100, 0, "°C"));
            _logMesg.addField(new com.garmin.fit.Field("minimumIncline", 35, 131, 100, 0, "%"));
            _logMesg.addField(new com.garmin.fit.Field("averageRiseRate", 36, 133, 10, 0, "mm/min"));
            _logMesg.addField(new com.garmin.fit.Field("minimumRiseRate", 37, 133, 10, 0, "mm/min"));
            _logMesg.addField(new com.garmin.fit.Field("maximumRiseRate", 38, 133, 10, 0, "mm/min"));
            _logMesg.addField(new com.garmin.fit.Field("minimumCadence", 39, 2, 1, 0, "rpm"));
            _logMesg.addField(new com.garmin.fit.Field("minimumPower", 40, 2, 1, 0, "W"));
            _logMesg.addField(new com.garmin.fit.Field("distanceUphill", 41, 134, 10, 0, "m"));
            _logMesg.addField(new com.garmin.fit.Field("distanceDownhill", 42, 134, 10, 0, "m"));
            _logMesg.addField(new com.garmin.fit.Field("rideTimeUphill", 43, 134, 100, 0, "s"));
            _logMesg.addField(new com.garmin.fit.Field("rideTimeDownhill", 44, 134, 100, 0, "s"));
            _logMesg.addField(new com.garmin.fit.Field("bike", 45, 7, 1, 0, ""));
            _logMesg.addField(new com.garmin.fit.Field("bikeType1", 46, 7, 1, 0, ""));
            _logMesg.addField(new com.garmin.fit.Field("bikeWeight1", 47, 134, 100, 0, ""));
            _logMesg.addField(new com.garmin.fit.Field("bikeWeight1Unit", 48, 7, 1, 0, ""));
            _logMesg.addField(new com.garmin.fit.Field("bikeType2", 49, 7, 1, 0, ""));
            _logMesg.addField(new com.garmin.fit.Field("bikeWeight2", 50, 134, 100, 0, ""));
            _logMesg.addField(new com.garmin.fit.Field("bikeWeight2Unit", 51, 7, 1, 0, ""));
            _logMesg.addField(new com.garmin.fit.Field("bodyHeight", 52, 134, 100, 0, ""));
            _logMesg.addField(new com.garmin.fit.Field("bodyHeightUnit", 53, 7, 1, 0, ""));
            _logMesg.addField(new com.garmin.fit.Field("shoulderWidth", 54, 134, 100, 0, ""));
            _logMesg.addField(new com.garmin.fit.Field("shoulderWidthUnit", 55, 7, 1, 0, ""));
            _logMesg.addField(new com.garmin.fit.Field("gender", 56, 7, 1, 0, ""));
            _logMesg.addField(new com.garmin.fit.Field("age", 57, 2, 1, 0, "years"));
            _logMesg.addField(new com.garmin.fit.Field("bodyWeight", 58, 134, 1, 0, ""));
            _logMesg.addField(new com.garmin.fit.Field("bodyWeightUnit", 59, 7, 1, 0, ""));
            _logMesg.addField(new com.garmin.fit.Field("logVersion", 60, 7, 1, 0, ""));
            _logMesg.addField(new com.garmin.fit.Field("logType", 61, 7, 1, 0, ""));
            _logMesg.addField(new com.garmin.fit.Field("logName", 62, 7, 1, 0, ""));
            _logMesg.addField(new com.garmin.fit.Field("description", 63, 7, 1, 0, ""));
            _logMesg.addField(new com.garmin.fit.Field("startDate", 64, 7, 1, 0, ""));
            _logMesg.addField(new com.garmin.fit.Field("statistic", 65, 7, 1, 0, ""));
            _logMesg.addField(new com.garmin.fit.Field("rating", 66, 2, 1, 0, "stars"));
            _logMesg.addField(new com.garmin.fit.Field("weather", 67, 2, 1, 0, ""));
            _logMesg.addField(new com.garmin.fit.Field("wind", 68, 2, 1, 0, ""));
            _logMesg.addField(new com.garmin.fit.Field("trackProfile", 69, 2, 1, 0, ""));
            _logMesg.addField(new com.garmin.fit.Field("trainingType", 70, 7, 1, 0, ""));
            _logMesg.addField(new com.garmin.fit.Field("manualTemperature", 71, 131, 100, 0, "°C"));
            _logMesg.addField(new com.garmin.fit.Field("trainingTime", 72, 134, 100, 0, "s"));
            _logMesg.addField(new com.garmin.fit.Field("samplingRate", 73, 132, 100, 0, "s"));
            _logMesg.addField(new com.garmin.fit.Field("pauseTime", 74, 134, 10, 0, "s"));
            _logMesg.addField(new com.garmin.fit.Field("externalLink", 75, 7, 1, 0, "url"));
            _logMesg.addField(new com.garmin.fit.Field("dateCode", 76, 7, 1, 0, ""));
            _logMesg.addField(new com.garmin.fit.Field("firmware", 77, 7, 1, 0, ""));
            _logMesg.addField(new com.garmin.fit.Field("unitType", 78, 7, 1, 0, ""));
            _logMesg.addField(new com.garmin.fit.Field("serialNumber", 80, 7, 1, 0, ""));
        }

        internal static var _logMesg:com.garmin.fit.Mesg;
    }
}


//        class SigmaMarkerROX100Mesg
package com.garmin.fit.custom.rox100 
{
    import com.garmin.fit.*;
    
    public class SigmaMarkerROX100Mesg extends com.garmin.fit.Mesg
    {
        public function SigmaMarkerROX100Mesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1);
            return;
        }

        public function getMarkerTimeAbsolute():Number
        {
            return getFieldDoubleValue(20, 0, 65535);
        }

        public function setMarkerTimeAbsolute(arg1:Number):void
        {
            setFieldValue(20, 0, arg1, 65535);
            return;
        }

        public function getMarkerMinimumSpeed():Number
        {
            return getFieldDoubleValue(23, 0, 65535);
        }

        public function setMarkerMinimumSpeed(arg1:Number):void
        {
            setFieldValue(23, 0, arg1, 65535);
            return;
        }

        public function getMarkerTimeDownhill():Number
        {
            return getFieldDoubleValue(24, 0, 65535);
        }

        public function setMarkerTimeDownhill(arg1:Number):void
        {
            setFieldValue(24, 0, arg1, 65535);
            return;
        }

        public function getMarkerTimeUphill():int
        {
            return getFieldDoubleValue(25, 0, 65535);
        }

        public function setMarkerTimeUphill(arg1:int):void
        {
            setFieldValue(25, 0, arg1, 65535);
            return;
        }

        public function getMarkerDistanceAbsolute():Number
        {
            return getFieldDoubleValue(10, 0, 65535);
        }

        public function setMarkerDistanceAbsolute(arg1:Number):void
        {
            setFieldValue(10, 0, arg1, 65535);
            return;
        }

        public function getMarkerDistanceDownhill():Number
        {
            return getFieldDoubleValue(11, 0, 65535);
        }

        public function setMarkerDistanceDownhill(arg1:Number):void
        {
            setFieldValue(11, 0, arg1, 65535);
            return;
        }

        public function getMarkerDistanceUphill():Number
        {
            return getFieldDoubleValue(12, 0, 65535);
        }

        public function setMarkerDistanceUphill(arg1:Number):void
        {
            setFieldValue(12, 0, arg1, 65535);
            return;
        }

        public function getDescription():String
        {
            return getFieldStringValue(0, 0, 65535);
        }

        public function setDescription(arg1:String):void
        {
            setFieldValue(0, 0, arg1, 65535);
            return;
        }

        public function getMarkerTime():int
        {
            return getFieldDoubleValue(2, 0, 65535);
        }

        public function setMarkerTime(arg1:int):void
        {
            setFieldValue(2, 0, arg1, 65535);
            return;
        }

        public function getTitle():String
        {
            return getFieldStringValue(3, 0, 65535);
        }

        public function setTitle(arg1:String):void
        {
            setFieldValue(3, 0, arg1, 65535);
            return;
        }

        protected static function createDescription():com.garmin.fit.Field
        {
            return new com.garmin.fit.Field("description", 0, 7, 1, 0, "");
        }

        protected static function createMarkerTime():com.garmin.fit.Field
        {
            return new com.garmin.fit.Field("markerTime", 2, 134, 100, 0, "s");
        }

        protected static function createTitle():com.garmin.fit.Field
        {
            return new com.garmin.fit.Field("title", 3, 7, 1, 0, "");
        }

        protected static function createMarkerDistanceAbsolute():com.garmin.fit.Field
        {
            return new com.garmin.fit.Field("distanceAbsolute", 10, 134, 100, 0, "m");
        }

        protected static function createMarkerDistanceDownhill():com.garmin.fit.Field
        {
            return new com.garmin.fit.Field("distanceDownhill", 11, 7, 1, 0, "");
        }

        protected static function createMarkerDistanceUphill():com.garmin.fit.Field
        {
            return new com.garmin.fit.Field("distanceUphill", 12, 7, 1, 0, "");
        }

        protected static function createMarkerTimeAbsolute():com.garmin.fit.Field
        {
            return new com.garmin.fit.Field("timeAbsolute", 20, 134, 100, 0, "s");
        }

        protected static function createMarkerMinimumSpeed():com.garmin.fit.Field
        {
            return new com.garmin.fit.Field("minimumSpeed", 23, 131, 1000, 0, "m/s");
        }

        protected static function createMarkerTimeDownhill():com.garmin.fit.Field
        {
            return new com.garmin.fit.Field("timeDownhill", 24, 134, 1, 0, "s");
        }

        protected static function createMarkerTimeUphill():com.garmin.fit.Field
        {
            return new com.garmin.fit.Field("timeUphill", 25, 134, 1, 0, "s");
        }
    }
}


//        class SigmaRecordMesg
package com.garmin.fit.custom.rox100 
{
    import com.garmin.fit.*;
    
    public class SigmaRecordMesg extends com.garmin.fit.Mesg
    {
        public function SigmaRecordMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(65280));
            return;
        }

        public function getTrainigTimeAbsolute():Number
        {
            return getFieldDoubleValue(0, 0, 65535);
        }

        public function setTrainigTimeAbsolute(arg1:Number):void
        {
            setFieldValue(0, 0, arg1, 65535);
            return;
        }

        public function getAltitudeDifferencesDownhill():int
        {
            return getFieldDoubleValue(1, 0, 65535);
        }

        public function setAltitudeDifferencesDownhill(arg1:int):void
        {
            setFieldValue(1, 0, arg1, 65535);
            return;
        }

        public function getAltitudeDifferencesUphill():int
        {
            return getFieldDoubleValue(2, 0, 65535);
        }

        public function setAltitudeDifferencesUphill(arg1:int):void
        {
            setFieldValue(2, 0, arg1, 65535);
            return;
        }

        public function getDistance():Number
        {
            return getFieldDoubleValue(3, 0, 65535);
        }

        public function setDistance(arg1:Number):void
        {
            setFieldValue(3, 0, arg1, 65535);
            return;
        }

        public function getDistanceDownhill():Number
        {
            return getFieldDoubleValue(4, 0, 65535);
        }

        public function setDistanceDownhill(arg1:Number):void
        {
            setFieldValue(4, 0, arg1, 65535);
            return;
        }

        public function getDistanceUphill():Number
        {
            return getFieldDoubleValue(5, 0, 65535);
        }

        public function setDistanceUphill(arg1:Number):void
        {
            setFieldValue(5, 0, arg1, 65535);
            return;
        }

        public function getPercentHRMax():Number
        {
            return getFieldDoubleValue(6, 0, 65535);
        }

        public function setPercentHRMax(arg1:Number):void
        {
            setFieldValue(6, 0, arg1, 65535);
            return;
        }

        public function getAvgPowerPerKG():int
        {
            return getFieldDoubleValue(7, 0, 65535);
        }

        public function setAvgPowerPerKG(arg1:int):void
        {
            setFieldValue(7, 0, arg1, 65535);
            return;
        }

        public function getRideTimeDownhill():Number
        {
            return getFieldDoubleValue(8, 0, 65535);
        }

        public function setRideTimeDownhill(arg1:Number):void
        {
            setFieldValue(8, 0, arg1, 65535);
            return;
        }

        public function getRideTimeUphill():Number
        {
            return getFieldDoubleValue(9, 0, 65535);
        }

        public function setRideTimeUphill(arg1:Number):void
        {
            setFieldValue(9, 0, arg1, 65535);
            return;
        }

        public function getRiseRate():Number
        {
            return getFieldDoubleValue(10, 0, 65535);
        }

        public function setRiseRate(arg1:Number):void
        {
            setFieldValue(10, 0, arg1, 65535);
            return;
        }

        public function getSpeedReference():String
        {
            return getFieldStringValue(11, 0, 65535);
        }

        public function setSpeedReference(arg1:String):void
        {
            setFieldValue(11, 0, arg1, 65535);
            return;
        }

        public function getTargetZone():int
        {
            return getFieldDoubleValue(12, 0, 65535);
        }

        public function setTargetZone(arg1:int):void
        {
            setFieldValue(12, 0, arg1, 65535);
            return;
        }

        public function getTrainigTime():Number
        {
            return getFieldDoubleValue(13, 0, 65535);
        }

        public function setTrainigTime(arg1:Number):void
        {
            setFieldValue(13, 0, arg1, 65535);
            return;
        }

        public function getWork():Number
        {
            return getFieldDoubleValue(14, 0, 65535);
        }

        public function setWork(arg1:Number):void
        {
            setFieldValue(14, 0, arg1, 65535);
            return;
        }

        public function getIntensityZone():int
        {
            return getFieldDoubleValue(15, 0, 65535);
        }

        public function setIntensityZone(arg1:int):void
        {
            setFieldValue(15, 0, arg1, 65535);
            return;
        }

        public static function get logEntryMesg():com.garmin.fit.Mesg
        {
            return _logEntryMesg;
        }

        
        {
            _logEntryMesg = new com.garmin.fit.Mesg("sigmaRecord", 65280);
            _logEntryMesg.addField(new com.garmin.fit.Field("trainigTimeAbsolute", 0, 134, 100, 0, "s"));
            _logEntryMesg.addField(new com.garmin.fit.Field("altitudeDifferencesDownhill", 1, 2, 1, 0, "m"));
            _logEntryMesg.addField(new com.garmin.fit.Field("altitudeDifferencesUphill", 2, 2, 1, 0, "m"));
            _logEntryMesg.addField(new com.garmin.fit.Field("distance", 3, 134, 100, 1, "m"));
            _logEntryMesg.addField(new com.garmin.fit.Field("distanceDownhill", 4, 134, 100, 0, "m"));
            _logEntryMesg.addField(new com.garmin.fit.Field("distanceUphill", 5, 134, 100, 0, "m"));
            _logEntryMesg.addField(new com.garmin.fit.Field("percentHRMax", 6, 131, 100, 0, "%"));
            _logEntryMesg.addField(new com.garmin.fit.Field("avgPowerPerKG", 7, 132, 1, 0, "W/kg"));
            _logEntryMesg.addField(new com.garmin.fit.Field("rideTimeDownhill", 8, 132, 100, 0, "s"));
            _logEntryMesg.addField(new com.garmin.fit.Field("rideTimeUphill", 9, 132, 100, 0, "s"));
            _logEntryMesg.addField(new com.garmin.fit.Field("riseRate", 10, 133, 1, 0, "mm/min"));
            _logEntryMesg.addField(new com.garmin.fit.Field("speedReference", 11, 7, 1, 0, "device"));
            _logEntryMesg.addField(new com.garmin.fit.Field("targetZone", 12, 2, 1, 0, ""));
            _logEntryMesg.addField(new com.garmin.fit.Field("trainigTime", 13, 132, 100, 0, "s"));
            _logEntryMesg.addField(new com.garmin.fit.Field("work", 14, 134, 10000, 0, "kJ"));
            _logEntryMesg.addField(new com.garmin.fit.Field("intensityZone", 15, 2, 1, 0, ""));
        }

        internal static var _logEntryMesg:com.garmin.fit.Mesg;
    }
}


//      class BaseType
package com.garmin.fit.custom 
{
    import __AS3__.vec.*;
    
    public class BaseType extends Object
    {
        public function BaseType()
        {
            super();
            return;
        }

        public function getByValue():uint
        {
            return null;
        }

        public static function getByValue(arg1:uint):com.garmin.fit.custom.BaseType
        {
            var loc3:*=0;
            var loc2:*=getAllValues();
            for each (var loc1:* in loc2) 
            {
                if (!(arg1 == loc1.getByValue())) 
                {
                    continue;
                }
                return loc1;
            }
            return getInvalid();
        }

        public static function getAllValues():__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>
        {
            return null;
        }

        public static function getInvalid():com.garmin.fit.custom.BaseType
        {
            return null;
        }

        protected var value:uint;
    }
}


//      class FitConverter
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


//      class FitErrorLoggingTyp
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


//      class SigmaMesgNum
package com.garmin.fit.custom 
{
    public class SigmaMesgNum extends Object
    {
        public function SigmaMesgNum()
        {
            super();
            return;
        }

        public static const LOG:int=1980;

        public static const BREAK:int=1981;

        public static const LAP:int=1982;

        public static const RECORD:int=1983;
    }
}


//    class Activity
package com.garmin.fit 
{
    import __AS3__.vec.*;
    import avmplus.*;
    import com.garmin.fit.custom.*;
    import flash.errors.*;
    
    public class Activity extends com.garmin.fit.custom.BaseType
    {
        public function Activity(arg1:Object, arg2:uint)
        {
            super();
            if (arg1 != SINGLETON_ENFORCER) 
            {
                throw new flash.errors.IllegalOperationError("IllegalOperation: Manipulation of type " + avmplus.getQualifiedClassName(this));
            }
            this.value = arg2;
            return;
        }

        public function getAllValues():__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>
        {
            return VALUES;
        }

        public function getInvalid():com.garmin.fit.custom.BaseType
        {
            return INVALID;
        }

        public function getValue():uint
        {
            return value;
        }

        public static function getByValue(arg1:uint):com.garmin.fit.Activity
        {
            return com.garmin.fit.custom.BaseType.getByValue(arg1) as Activity;
        }

        
        {
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(3)[0] = MANUAL;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(3)[1] = AUTO_MULTI_SPORT;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(3)[2] = INVALID;
        }

        internal static const SINGLETON_ENFORCER:Object={};

        public static const MANUAL:com.garmin.fit.Activity=new Activity(SINGLETON_ENFORCER, 0);

        public static const AUTO_MULTI_SPORT:com.garmin.fit.Activity=new Activity(SINGLETON_ENFORCER, 1);

        public static const INVALID:com.garmin.fit.Activity=new Activity(SINGLETON_ENFORCER, 255);

        public static const VALUES:__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>=new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(3);
    }
}


//    class ActivityClass
package com.garmin.fit 
{
    import __AS3__.vec.*;
    import avmplus.*;
    import com.garmin.fit.custom.*;
    import flash.errors.*;
    
    public class ActivityClass extends com.garmin.fit.custom.BaseType
    {
        public function ActivityClass(arg1:Object, arg2:uint)
        {
            super();
            if (arg1 != SINGLETON_ENFORCER) 
            {
                throw new flash.errors.IllegalOperationError("IllegalOperation: Manipulation of type " + avmplus.getQualifiedClassName(this));
            }
            this.value = arg2;
            return;
        }

        public function getAllValues():__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>
        {
            return VALUES;
        }

        public function getInvalid():com.garmin.fit.custom.BaseType
        {
            return INVALID;
        }

        public function getValue():uint
        {
            return value;
        }

        public static function getByValue(arg1:uint):com.garmin.fit.ActivityClass
        {
            return com.garmin.fit.custom.BaseType.getByValue(arg1) as ActivityClass;
        }

        
        {
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(4)[0] = LEVEL;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(4)[1] = LEVEL_MAX;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(4)[2] = ATHLETE;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(4)[3] = INVALID;
        }

        internal static const SINGLETON_ENFORCER:Object={};

        public static const LEVEL:com.garmin.fit.ActivityClass=new ActivityClass(SINGLETON_ENFORCER, 127);

        public static const LEVEL_MAX:com.garmin.fit.ActivityClass=new ActivityClass(SINGLETON_ENFORCER, 100);

        public static const ATHLETE:com.garmin.fit.ActivityClass=new ActivityClass(SINGLETON_ENFORCER, 128);

        public static const INVALID:com.garmin.fit.ActivityClass=new ActivityClass(SINGLETON_ENFORCER, 255);

        internal static const VALUES:__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>=new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(4);
    }
}


//    class ActivityMesg
package com.garmin.fit 
{
    public class ActivityMesg extends com.garmin.fit.Mesg implements com.garmin.fit.MesgWithEvent
    {
        public function ActivityMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(34));
            return;
        }

        public function getTimestamp():com.garmin.fit.DateTime
        {
            return timestampToDateTime(getFieldDoubleValue(253, 0, 65535));
        }

        public function setTimestamp(arg1:com.garmin.fit.DateTime):void
        {
            setFieldValue(253, 0, arg1.getTimestamp(), 65535);
            return;
        }

        public function getTotalTimerTime():Number
        {
            return getFieldDoubleValue(0, 0, 65535);
        }

        public function setTotalTimerTime(arg1:Number):void
        {
            setFieldValue(0, 0, arg1, 65535);
            return;
        }

        public function getNumSessions():int
        {
            return getFieldIntegerValue(1, 0, 65535);
        }

        public function setNumSessions(arg1:int):void
        {
            setFieldValue(1, 0, arg1, 65535);
            return;
        }

        public function getType():com.garmin.fit.Activity
        {
            var loc1:*=getFieldIntegerValue(2, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.Activity.getByValue(loc1);
        }

        public function setType(arg1:com.garmin.fit.Activity):void
        {
            setFieldValue(2, 0, arg1.getValue(), 65535);
            return;
        }

        public function getEvent():com.garmin.fit.FITEvent
        {
            var loc1:*=getFieldIntegerValue(3, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.FITEvent.getByValue(loc1);
        }

        public function setEvent(arg1:com.garmin.fit.FITEvent):void
        {
            setFieldValue(3, 0, arg1.getValue(), 65535);
            return;
        }

        public function getEventType():com.garmin.fit.EventType
        {
            var loc1:*=getFieldIntegerValue(4, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.EventType.getByValue(loc1);
        }

        public function setEventType(arg1:com.garmin.fit.EventType):void
        {
            setFieldValue(4, 0, arg1.getValue(), 65535);
            return;
        }

        public function getLocalTimestamp():Number
        {
            return getFieldDoubleValue(5, 0, 65535);
        }

        public function setLocalTimestamp(arg1:Number):void
        {
            setFieldValue(5, 0, arg1, 65535);
            return;
        }

        public function getEventGroup():int
        {
            return getFieldIntegerValue(6, 0, 65535);
        }

        public function setEventGroup(arg1:int):void
        {
            setFieldValue(6, 0, arg1, 65535);
            return;
        }

        public static function get activityMesg():com.garmin.fit.Mesg
        {
            return _activityMesg;
        }

        
        {
            _activityMesg = new com.garmin.fit.Mesg("activity", 34);
            activityMesg.addField(new com.garmin.fit.Field("timestamp", 253, 134, 1, 0, ""));
            activityMesg.addField(new com.garmin.fit.Field("total_timer_time", 0, 134, 1000, 0, "s"));
            activityMesg.addField(new com.garmin.fit.Field("num_sessions", 1, 132, 1, 0, ""));
            activityMesg.addField(new com.garmin.fit.Field("type", 2, 0, 1, 0, ""));
            activityMesg.addField(new com.garmin.fit.Field("event", 3, 0, 1, 0, ""));
            activityMesg.addField(new com.garmin.fit.Field("event_type", 4, 0, 1, 0, ""));
            activityMesg.addField(new com.garmin.fit.Field("local_timestamp", 5, 134, 1, 0, ""));
            activityMesg.addField(new com.garmin.fit.Field("event_group", 6, 2, 1, 0, ""));
        }

        internal static var _activityMesg:com.garmin.fit.Mesg;
    }
}


//    class BikeProfileMesg
package com.garmin.fit 
{
    public class BikeProfileMesg extends com.garmin.fit.Mesg
    {
        public function BikeProfileMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(6));
            return;
        }

        public function getMessageIndex():int
        {
            return getFieldIntegerValue(254, 0, 65535);
        }

        public function setMessageIndex(arg1:int):void
        {
            setFieldValue(254, 0, arg1, 65535);
            return;
        }

        public override function getName():String
        {
            return getFieldStringValue(0, 0, 65535);
        }

        public function setName(arg1:String):void
        {
            setFieldValue(0, 0, arg1, 65535);
            return;
        }

        public function getSport():com.garmin.fit.Sport
        {
            var loc1:*=getFieldIntegerValue(1, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.Sport.getByValue(loc1);
        }

        public function setSport(arg1:com.garmin.fit.Sport):void
        {
            setFieldValue(1, 0, arg1.getValue(), 65535);
            return;
        }

        public function getSubSport():com.garmin.fit.SubSport
        {
            var loc1:*=getFieldIntegerValue(2, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.SubSport.getByValue(loc1);
        }

        public function setSubSport(arg1:com.garmin.fit.SubSport):void
        {
            setFieldValue(2, 0, arg1.getValue(), 65535);
            return;
        }

        public function getOdometer():Number
        {
            return getFieldDoubleValue(3, 0, 65535);
        }

        public function setOdometer(arg1:Number):void
        {
            setFieldValue(3, 0, arg1, 65535);
            return;
        }

        public function getBikeSpdAntId():int
        {
            return getFieldIntegerValue(4, 0, 65535);
        }

        public function setBikeSpdAntId(arg1:int):void
        {
            setFieldValue(4, 0, arg1, 65535);
            return;
        }

        public function getBikeCadAntId():int
        {
            return getFieldIntegerValue(5, 0, 65535);
        }

        public function setBikeCadAntId(arg1:int):void
        {
            setFieldValue(5, 0, arg1, 65535);
            return;
        }

        public function getBikeSpdcadAntId():int
        {
            return getFieldIntegerValue(6, 0, 65535);
        }

        public function setBikeSpdcadAntId(arg1:int):void
        {
            setFieldValue(6, 0, arg1, 65535);
            return;
        }

        public function getBikePowerAntId():int
        {
            return getFieldIntegerValue(7, 0, 65535);
        }

        public function setBikePowerAntId(arg1:int):void
        {
            setFieldValue(7, 0, arg1, 65535);
            return;
        }

        public function getCustomWheelsize():Number
        {
            return getFieldDoubleValue(8, 0, 65535);
        }

        public function setCustomWheelsize(arg1:Number):void
        {
            setFieldValue(8, 0, arg1, 65535);
            return;
        }

        public function getAutoWheelsize():Number
        {
            return getFieldDoubleValue(9, 0, 65535);
        }

        public function setAutoWheelsize(arg1:Number):void
        {
            setFieldValue(9, 0, arg1, 65535);
            return;
        }

        public function getBikeWeight():Number
        {
            return getFieldDoubleValue(10, 0, 65535);
        }

        public function setBikeWeight(arg1:Number):void
        {
            setFieldValue(10, 0, arg1, 65535);
            return;
        }

        public function getPowerCalFactor():Number
        {
            return getFieldDoubleValue(11, 0, 65535);
        }

        public function setPowerCalFactor(arg1:Number):void
        {
            setFieldValue(11, 0, arg1, 65535);
            return;
        }

        public function getAutoWheelCal():com.garmin.fit.FITBool
        {
            var loc1:*=getFieldIntegerValue(12, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.FITBool.getByValue(loc1);
        }

        public function setAutoWheelCal(arg1:com.garmin.fit.FITBool):void
        {
            setFieldValue(12, 0, arg1.getValue(), 65535);
            return;
        }

        public function getAutoPowerZero():com.garmin.fit.FITBool
        {
            var loc1:*=getFieldIntegerValue(13, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.FITBool.getByValue(loc1);
        }

        public function setAutoPowerZero(arg1:com.garmin.fit.FITBool):void
        {
            setFieldValue(13, 0, arg1.getValue(), 65535);
            return;
        }

        public function getId():int
        {
            return getFieldIntegerValue(14, 0, 65535);
        }

        public function setId(arg1:int):void
        {
            setFieldValue(14, 0, arg1, 65535);
            return;
        }

        public function getSpdEnabled():com.garmin.fit.FITBool
        {
            var loc1:*=getFieldIntegerValue(15, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.FITBool.getByValue(loc1);
        }

        public function setSpdEnabled(arg1:com.garmin.fit.FITBool):void
        {
            setFieldValue(15, 0, arg1, 65535);
            return;
        }

        public function getCadEnabled():com.garmin.fit.FITBool
        {
            var loc1:*=getFieldIntegerValue(16, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.FITBool.getByValue(loc1);
        }

        public function setCadEnabled(arg1:com.garmin.fit.FITBool):void
        {
            setFieldValue(16, 0, arg1, 65535);
            return;
        }

        public function getSpdcadEnabled():com.garmin.fit.FITBool
        {
            var loc1:*=getFieldIntegerValue(17, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.FITBool.getByValue(loc1);
        }

        public function setSpdcadEnabled(arg1:com.garmin.fit.FITBool):void
        {
            setFieldValue(17, 0, arg1, 65535);
            return;
        }

        public function getPowerEnabled():com.garmin.fit.FITBool
        {
            var loc1:*=getFieldIntegerValue(18, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.FITBool.getByValue(loc1);
        }

        public function setPowerEnabled(arg1:com.garmin.fit.FITBool):void
        {
            setFieldValue(18, 0, arg1.getValue(), 65535);
            return;
        }

        public function getCrankLength():Number
        {
            return getFieldDoubleValue(19, 0, 65535);
        }

        public function setCrankLength(arg1:Number):void
        {
            setFieldValue(19, 0, arg1, 65535);
            return;
        }

        public function getEnabled():com.garmin.fit.FITBool
        {
            var loc1:*=getFieldIntegerValue(20, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.FITBool.getByValue(loc1);
        }

        public function setEnabled(arg1:com.garmin.fit.FITBool):void
        {
            setFieldValue(20, 0, arg1, 65535);
            return;
        }

        public function getBikeSpdAntIdTransType():int
        {
            return getFieldIntegerValue(21, 0, 65535);
        }

        public function setBikeSpdAntIdTransType(arg1:int):void
        {
            setFieldValue(21, 0, arg1, 65535);
            return;
        }

        public function getBikeCadAntIdTransType():int
        {
            return getFieldIntegerValue(22, 0, 65535);
        }

        public function setBikeCadAntIdTransType(arg1:int):void
        {
            setFieldValue(22, 0, arg1, 65535);
            return;
        }

        public function getBikeSpdcadAntIdTransType():int
        {
            return getFieldIntegerValue(23, 0, 65535);
        }

        public function setBikeSpdcadAntIdTransType(arg1:int):void
        {
            setFieldValue(23, 0, arg1, 65535);
            return;
        }

        public function getBikePowerAntIdTransType():int
        {
            return getFieldIntegerValue(24, 0, 65535);
        }

        public function setBikePowerAntIdTransType(arg1:int):void
        {
            setFieldValue(24, 0, arg1, 65535);
            return;
        }

        public static function get bikeProfileMesg():com.garmin.fit.Mesg
        {
            return _bikeProfileMesg;
        }

        
        {
            _bikeProfileMesg = new com.garmin.fit.Mesg("bike_profile", 6);
            bikeProfileMesg.addField(new com.garmin.fit.Field("message_index", 254, 132, 1, 0, ""));
            bikeProfileMesg.addField(new com.garmin.fit.Field("name", 0, 7, 1, 0, ""));
            bikeProfileMesg.addField(new com.garmin.fit.Field("sport", 1, 0, 1, 0, ""));
            bikeProfileMesg.addField(new com.garmin.fit.Field("sub_sport", 2, 0, 1, 0, ""));
            bikeProfileMesg.addField(new com.garmin.fit.Field("odometer", 3, 134, 100, 0, "m"));
            bikeProfileMesg.addField(new com.garmin.fit.Field("bike_spd_ant_id", 4, 139, 1, 0, ""));
            bikeProfileMesg.addField(new com.garmin.fit.Field("bike_cad_ant_id", 5, 139, 1, 0, ""));
            bikeProfileMesg.addField(new com.garmin.fit.Field("bike_spdcad_ant_id", 6, 139, 1, 0, ""));
            bikeProfileMesg.addField(new com.garmin.fit.Field("bike_power_ant_id", 7, 139, 1, 0, ""));
            bikeProfileMesg.addField(new com.garmin.fit.Field("custom_wheelsize", 8, 132, 1000, 0, "m"));
            bikeProfileMesg.addField(new com.garmin.fit.Field("auto_wheelsize", 9, 132, 1000, 0, "m"));
            bikeProfileMesg.addField(new com.garmin.fit.Field("bike_weight", 10, 132, 10, 0, "kg"));
            bikeProfileMesg.addField(new com.garmin.fit.Field("power_cal_factor", 11, 132, 10, 0, "%"));
            bikeProfileMesg.addField(new com.garmin.fit.Field("auto_wheel_cal", 12, 0, 1, 0, ""));
            bikeProfileMesg.addField(new com.garmin.fit.Field("auto_power_zero", 13, 0, 1, 0, ""));
            bikeProfileMesg.addField(new com.garmin.fit.Field("id", 14, 2, 1, 0, ""));
            bikeProfileMesg.addField(new com.garmin.fit.Field("spd_enabled", 15, 0, 1, 0, ""));
            bikeProfileMesg.addField(new com.garmin.fit.Field("cad_enabled", 16, 0, 1, 0, ""));
            bikeProfileMesg.addField(new com.garmin.fit.Field("spdcad_enabled", 17, 0, 1, 0, ""));
            bikeProfileMesg.addField(new com.garmin.fit.Field("power_enabled", 18, 0, 1, 0, ""));
            bikeProfileMesg.addField(new com.garmin.fit.Field("crank_length", 19, 2, 2, -110, "mm"));
            bikeProfileMesg.addField(new com.garmin.fit.Field("enabled", 20, 0, 1, 0, ""));
            bikeProfileMesg.addField(new com.garmin.fit.Field("bike_spd_ant_id_trans_type", 21, 10, 1, 0, ""));
            bikeProfileMesg.addField(new com.garmin.fit.Field("bike_cad_ant_id_trans_type", 22, 10, 1, 0, ""));
            bikeProfileMesg.addField(new com.garmin.fit.Field("bike_spdcad_ant_id_trans_type", 23, 10, 1, 0, ""));
            bikeProfileMesg.addField(new com.garmin.fit.Field("bike_power_ant_id_trans_type", 24, 10, 1, 0, ""));
        }

        internal static var _bikeProfileMesg:com.garmin.fit.Mesg;
    }
}


//    class BloodPressureMesg
package com.garmin.fit 
{
    public class BloodPressureMesg extends com.garmin.fit.Mesg
    {
        public function BloodPressureMesg(arg1:com.garmin.fit.Mesg)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(51));
            return;
        }

        public function getTimestamp():com.garmin.fit.DateTime
        {
            return timestampToDateTime(getFieldDoubleValue(253, 0, 65535));
        }

        public function setTimestamp(arg1:com.garmin.fit.DateTime):void
        {
            setFieldValue(253, 0, arg1.getTimestamp(), 65535);
            return;
        }

        public function getSystolicPressure():int
        {
            return getFieldIntegerValue(0, 0, 65535);
        }

        public function setSystolicPressure(arg1:int):void
        {
            setFieldValue(0, 0, arg1, 65535);
            return;
        }

        public function getDiastolicPressure():int
        {
            return getFieldIntegerValue(1, 0, 65535);
        }

        public function setDiastolicPressure(arg1:int):void
        {
            setFieldValue(1, 0, arg1, 65535);
            return;
        }

        public function getMeanArterialPressure():int
        {
            return getFieldIntegerValue(2, 0, 65535);
        }

        public function setMeanArterialPressure(arg1:int):void
        {
            setFieldValue(2, 0, arg1, 65535);
            return;
        }

        public function getMap3SampleMean():int
        {
            return getFieldIntegerValue(3, 0, 65535);
        }

        public function setMap3SampleMean(arg1:int):void
        {
            setFieldValue(3, 0, arg1, 65535);
            return;
        }

        public function getMapMorningValues():int
        {
            return getFieldIntegerValue(4, 0, 65535);
        }

        public function setMapMorningValues(arg1:int):void
        {
            setFieldValue(4, 0, arg1, 65535);
            return;
        }

        public function getMapEveningValues():int
        {
            return getFieldIntegerValue(5, 0, 65535);
        }

        public function setMapEveningValues(arg1:int):void
        {
            setFieldValue(5, 0, arg1, 65535);
            return;
        }

        public function getHeartRate():int
        {
            return getFieldIntegerValue(6, 0, 65535);
        }

        public function setHeartRate(arg1:int):void
        {
            setFieldValue(6, 0, arg1, 65535);
            return;
        }

        public function getHeartRateType():com.garmin.fit.HrType
        {
            var loc1:*=getFieldIntegerValue(7, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.HrType.getByValue(loc1);
        }

        public function setHeartRateType(arg1:com.garmin.fit.HrType):void
        {
            setFieldValue(7, 0, arg1.getValue(), 65535);
            return;
        }

        public function getStatus():com.garmin.fit.BpStatus
        {
            var loc1:*=getFieldIntegerValue(8, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.BpStatus.getByValue(loc1);
        }

        public function setStatus(arg1:com.garmin.fit.BpStatus):void
        {
            setFieldValue(8, 0, arg1.getValue(), 65535);
            return;
        }

        public function getUserProfileIndex():int
        {
            return getFieldIntegerValue(9, 0, 65535);
        }

        public function setUserProfileIndex(arg1:int):void
        {
            setFieldValue(9, 0, arg1, 65535);
            return;
        }

        public static function get bloodPressureMesg():com.garmin.fit.Mesg
        {
            return _bloodPressureMesg;
        }

        
        {
            _bloodPressureMesg = new com.garmin.fit.Mesg("blood_pressure", 51);
            bloodPressureMesg.addField(new com.garmin.fit.Field("timestamp", 253, 134, 1, 0, "s"));
            bloodPressureMesg.addField(new com.garmin.fit.Field("systolic_pressure", 0, 132, 1, 0, "mmHg"));
            bloodPressureMesg.addField(new com.garmin.fit.Field("diastolic_pressure", 1, 132, 1, 0, "mmHg"));
            bloodPressureMesg.addField(new com.garmin.fit.Field("mean_arterial_pressure", 2, 132, 1, 0, "mmHg"));
            bloodPressureMesg.addField(new com.garmin.fit.Field("map_3_sample_mean", 3, 132, 1, 0, "mmHg"));
            bloodPressureMesg.addField(new com.garmin.fit.Field("map_morning_values", 4, 132, 1, 0, "mmHg"));
            bloodPressureMesg.addField(new com.garmin.fit.Field("map_evening_values", 5, 132, 1, 0, "mmHg"));
            bloodPressureMesg.addField(new com.garmin.fit.Field("heart_rate", 6, 2, 1, 0, "bpm"));
            bloodPressureMesg.addField(new com.garmin.fit.Field("heart_rate_type", 7, 0, 1, 0, ""));
            bloodPressureMesg.addField(new com.garmin.fit.Field("status", 8, 0, 1, 0, ""));
            bloodPressureMesg.addField(new com.garmin.fit.Field("user_profile_index", 9, 132, 1, 0, ""));
        }

        internal static var _bloodPressureMesg:com.garmin.fit.Mesg;
    }
}


//    class BpStatus
package com.garmin.fit 
{
    import __AS3__.vec.*;
    import avmplus.*;
    import com.garmin.fit.custom.*;
    import flash.errors.*;
    
    public class BpStatus extends com.garmin.fit.custom.BaseType
    {
        public function BpStatus(arg1:Object, arg2:uint)
        {
            super();
            if (arg1 != SINGLETON_ENFORCER) 
            {
                throw new flash.errors.IllegalOperationError("IllegalOperation: Manipulation of type " + avmplus.getQualifiedClassName(this));
            }
            this.value = arg2;
            return;
        }

        public function getAllValues():__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>
        {
            return VALUES;
        }

        public function getInvalid():com.garmin.fit.custom.BaseType
        {
            return INVALID;
        }

        public function getValue():uint
        {
            return value;
        }

        public static function getByValue(arg1:uint):com.garmin.fit.BpStatus
        {
            return com.garmin.fit.custom.BaseType.getByValue(arg1) as BpStatus;
        }

        
        {
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(6)[0] = NO_ERROR;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(6)[1] = ERROR_INCOMPLETE_DATA;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(6)[2] = ERROR_NO_MEASUREMENT;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(6)[3] = ERROR_DATA_OUT_OF_RANGE;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(6)[4] = ERROR_IRREGULAR_HEART_RATE;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(6)[5] = INVALID;
        }

        internal static const SINGLETON_ENFORCER:Object={};

        public static const NO_ERROR:com.garmin.fit.BpStatus=new BpStatus(SINGLETON_ENFORCER, 0);

        public static const ERROR_INCOMPLETE_DATA:com.garmin.fit.BpStatus=new BpStatus(SINGLETON_ENFORCER, 1);

        public static const ERROR_NO_MEASUREMENT:com.garmin.fit.BpStatus=new BpStatus(SINGLETON_ENFORCER, 2);

        public static const ERROR_DATA_OUT_OF_RANGE:com.garmin.fit.BpStatus=new BpStatus(SINGLETON_ENFORCER, 3);

        public static const ERROR_IRREGULAR_HEART_RATE:com.garmin.fit.BpStatus=new BpStatus(SINGLETON_ENFORCER, 4);

        public static const INVALID:com.garmin.fit.BpStatus=new BpStatus(SINGLETON_ENFORCER, 255);

        internal static const VALUES:__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>=new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(6);
    }
}


//    class CRC
package com.garmin.fit 
{
    import __AS3__.vec.*;
    
    public class CRC extends Object
    {
        public function CRC()
        {
            super();
            return;
        }

        public static function get16(arg1:int, arg2:uint):int
        {
            var loc1:*=0;
            4294967295;
            loc1 = crc16_table[arg1 & 15];
            arg1 = arg1 >> 4 & 4095;
            arg1 = arg1 ^ loc1 ^ crc16_table[arg2 & 15];
            loc1 = crc16_table[arg1 & 15];
            arg1 = arg1 >> 4 & 4095;
            arg1 = arg1 ^ loc1 ^ crc16_table[arg2 >> 4 & 15];
            return arg1;
        }

        
        {
            new __AS3__.vec.Vector.<uint>(16)[0] = 0;
            new __AS3__.vec.Vector.<uint>(16)[1] = 52225;
            new __AS3__.vec.Vector.<uint>(16)[2] = 55297;
            new __AS3__.vec.Vector.<uint>(16)[3] = 5120;
            new __AS3__.vec.Vector.<uint>(16)[4] = 61441;
            new __AS3__.vec.Vector.<uint>(16)[5] = 15360;
            new __AS3__.vec.Vector.<uint>(16)[6] = 10240;
            new __AS3__.vec.Vector.<uint>(16)[7] = 58369;
            new __AS3__.vec.Vector.<uint>(16)[8] = 40961;
            new __AS3__.vec.Vector.<uint>(16)[9] = 27648;
            new __AS3__.vec.Vector.<uint>(16)[10] = 30720;
            new __AS3__.vec.Vector.<uint>(16)[11] = 46081;
            new __AS3__.vec.Vector.<uint>(16)[12] = 20480;
            new __AS3__.vec.Vector.<uint>(16)[13] = 39937;
            new __AS3__.vec.Vector.<uint>(16)[14] = 34817;
            new __AS3__.vec.Vector.<uint>(16)[15] = 17408;
            crc16_table = new __AS3__.vec.Vector.<uint>(16);
        }

        internal static var crc16_table:__AS3__.vec.Vector.<uint>;
    }
}


//    class CadenceZoneMesg
package com.garmin.fit 
{
    public class CadenceZoneMesg extends com.garmin.fit.Mesg
    {
        public function CadenceZoneMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(131));
            return;
        }

        public function getMessageIndex():int
        {
            return getFieldIntegerValue(254, 0, 65535);
        }

        public function setMessageIndex(arg1:int):void
        {
            setFieldValue(254, 0, arg1, 65535);
            return;
        }

        public function getHighValue():int
        {
            return getFieldIntegerValue(0, 0, 65535);
        }

        public function setHighValue(arg1:int):void
        {
            setFieldValue(0, 0, arg1, 65535);
            return;
        }

        public override function getName():String
        {
            return getFieldStringValue(1, 0, 65535);
        }

        public function setName(arg1:String):void
        {
            setFieldValue(1, 0, arg1, 65535);
            return;
        }

        public static function get cadenceZoneMesg():com.garmin.fit.Mesg
        {
            return _cadenceZoneMesg;
        }

        
        {
            _cadenceZoneMesg = new com.garmin.fit.Mesg("cadence_zone", 131);
            cadenceZoneMesg.addField(new com.garmin.fit.Field("message_index", 254, 132, 1, 0, ""));
            cadenceZoneMesg.addField(new com.garmin.fit.Field("high_value", 0, 2, 1, 0, "rpm"));
            cadenceZoneMesg.addField(new com.garmin.fit.Field("name", 1, 7, 1, 0, ""));
        }

        internal static var _cadenceZoneMesg:com.garmin.fit.Mesg;
    }
}


//    class CapabilitiesMesg
package com.garmin.fit 
{
    public class CapabilitiesMesg extends com.garmin.fit.Mesg
    {
        public function CapabilitiesMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(1));
            return;
        }

        public function getNumLanguages():int
        {
            return getNumFieldValues(0, 65535);
        }

        public function getLanguages(arg1:int):int
        {
            return getFieldIntegerValue(0, arg1, 65535);
        }

        public function setLanguages(arg1:int, arg2:int):void
        {
            setFieldValue(0, arg1, arg2, 65535);
            return;
        }

        public function getNumSports():int
        {
            return getNumFieldValues(1, 65535);
        }

        public function getSports(arg1:int):int
        {
            return getFieldIntegerValue(1, arg1, 65535);
        }

        public function setSports(arg1:int, arg2:int):void
        {
            setFieldValue(1, arg1, arg2, 65535);
            return;
        }

        public function getWorkoutsSupported():Number
        {
            return getFieldDoubleValue(21, 0, 65535);
        }

        public function setWorkoutsSupported(arg1:Number):void
        {
            setFieldValue(21, 0, arg1, 65535);
            return;
        }

        public static function get capabilitiesMesg():com.garmin.fit.Mesg
        {
            return _capabilitiesMesg;
        }

        
        {
            _capabilitiesMesg = new com.garmin.fit.Mesg("capabilities", 1);
            capabilitiesMesg.addField(new com.garmin.fit.Field("languages", 0, 10, 1, 0, ""));
            capabilitiesMesg.addField(new com.garmin.fit.Field("sports", 1, 10, 1, 0, ""));
            capabilitiesMesg.addField(new com.garmin.fit.Field("workouts_supported", 21, 140, 1, 0, ""));
        }

        protected static var _capabilitiesMesg:com.garmin.fit.Mesg;
    }
}


//    class CourseMesg
package com.garmin.fit 
{
    public class CourseMesg extends com.garmin.fit.Mesg
    {
        public function CourseMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(31));
            return;
        }

        public function getSport():com.garmin.fit.Sport
        {
            var loc1:*=getFieldIntegerValue(4, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.Sport.getByValue(loc1);
        }

        public function setSport(arg1:com.garmin.fit.Sport):void
        {
            setFieldValue(4, 0, arg1.getValue(), 65535);
            return;
        }

        public override function getName():String
        {
            return getFieldStringValue(5, 0, 65535);
        }

        public function setName(arg1:String):void
        {
            setFieldValue(5, 0, arg1, 65535);
            return;
        }

        public function getCapabilities():Number
        {
            return getFieldDoubleValue(6, 0, 65535);
        }

        public function setCapabilities(arg1:Number):void
        {
            setFieldValue(6, 0, arg1, 65535);
            return;
        }

        public static function get courseMesg():com.garmin.fit.Mesg
        {
            return _courseMesg;
        }

        
        {
            _courseMesg = new com.garmin.fit.Mesg("course", 31);
            courseMesg.addField(new com.garmin.fit.Field("sport", 4, 0, 1, 0, ""));
            courseMesg.addField(new com.garmin.fit.Field("name", 5, 7, 1, 0, ""));
            courseMesg.addField(new com.garmin.fit.Field("capabilities", 6, 140, 1, 0, ""));
        }

        internal static var _courseMesg:com.garmin.fit.Mesg;
    }
}


//    class CoursePoint
package com.garmin.fit 
{
    import __AS3__.vec.*;
    import avmplus.*;
    import com.garmin.fit.custom.*;
    import flash.errors.*;
    
    public class CoursePoint extends com.garmin.fit.custom.BaseType
    {
        public function CoursePoint(arg1:Object, arg2:uint)
        {
            super();
            if (arg1 != SINGLETON_ENFORCER) 
            {
                throw new flash.errors.IllegalOperationError("IllegalOperation: Manipulation of type " + avmplus.getQualifiedClassName(this));
            }
            this.value = arg2;
            return;
        }

        public function getAllValues():__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>
        {
            return VALUES;
        }

        public function getInvalid():com.garmin.fit.custom.BaseType
        {
            return INVALID;
        }

        public function getValue():uint
        {
            return value;
        }

        public static function getByValue(arg1:uint):com.garmin.fit.CoursePoint
        {
            return com.garmin.fit.custom.BaseType.getByValue(arg1) as CoursePoint;
        }

        
        {
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(20)[0] = GENERIC;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(20)[1] = SUMMIT;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(20)[2] = VALLEY;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(20)[3] = WATER;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(20)[4] = FOOD;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(20)[5] = DANGER;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(20)[6] = LEFT;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(20)[7] = RIGHT;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(20)[8] = STRAIGHT;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(20)[9] = FIRST_AID;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(20)[10] = FOURTH_CATEGORY;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(20)[11] = THIRD_CATEGORY;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(20)[12] = SECOND_CATEGORY;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(20)[13] = FIRST_CATEGORY;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(20)[14] = HORS_CATEGORY;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(20)[15] = SPRINT;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(20)[16] = LEFT_FORK;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(20)[17] = RIGHT_FORK;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(20)[18] = MIDDLE_FORK;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(20)[19] = INVALID;
        }

        internal static const SINGLETON_ENFORCER:Object={};

        public static const GENERIC:com.garmin.fit.CoursePoint=new CoursePoint(SINGLETON_ENFORCER, 0);

        public static const SUMMIT:com.garmin.fit.CoursePoint=new CoursePoint(SINGLETON_ENFORCER, 1);

        public static const VALLEY:com.garmin.fit.CoursePoint=new CoursePoint(SINGLETON_ENFORCER, 2);

        public static const WATER:com.garmin.fit.CoursePoint=new CoursePoint(SINGLETON_ENFORCER, 3);

        public static const FOOD:com.garmin.fit.CoursePoint=new CoursePoint(SINGLETON_ENFORCER, 4);

        public static const DANGER:com.garmin.fit.CoursePoint=new CoursePoint(SINGLETON_ENFORCER, 5);

        public static const LEFT:com.garmin.fit.CoursePoint=new CoursePoint(SINGLETON_ENFORCER, 6);

        public static const RIGHT:com.garmin.fit.CoursePoint=new CoursePoint(SINGLETON_ENFORCER, 7);

        public static const STRAIGHT:com.garmin.fit.CoursePoint=new CoursePoint(SINGLETON_ENFORCER, 8);

        public static const FIRST_AID:com.garmin.fit.CoursePoint=new CoursePoint(SINGLETON_ENFORCER, 9);

        public static const FOURTH_CATEGORY:com.garmin.fit.CoursePoint=new CoursePoint(SINGLETON_ENFORCER, 10);

        public static const THIRD_CATEGORY:com.garmin.fit.CoursePoint=new CoursePoint(SINGLETON_ENFORCER, 11);

        public static const SECOND_CATEGORY:com.garmin.fit.CoursePoint=new CoursePoint(SINGLETON_ENFORCER, 12);

        public static const FIRST_CATEGORY:com.garmin.fit.CoursePoint=new CoursePoint(SINGLETON_ENFORCER, 13);

        public static const HORS_CATEGORY:com.garmin.fit.CoursePoint=new CoursePoint(SINGLETON_ENFORCER, 14);

        public static const SPRINT:com.garmin.fit.CoursePoint=new CoursePoint(SINGLETON_ENFORCER, 15);

        public static const LEFT_FORK:com.garmin.fit.CoursePoint=new CoursePoint(SINGLETON_ENFORCER, 16);

        public static const RIGHT_FORK:com.garmin.fit.CoursePoint=new CoursePoint(SINGLETON_ENFORCER, 17);

        public static const MIDDLE_FORK:com.garmin.fit.CoursePoint=new CoursePoint(SINGLETON_ENFORCER, 18);

        public static const INVALID:com.garmin.fit.CoursePoint=new CoursePoint(SINGLETON_ENFORCER, 255);

        internal static const VALUES:__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>=new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(20);
    }
}


//    class CoursePointMesg
package com.garmin.fit 
{
    public class CoursePointMesg extends com.garmin.fit.Mesg
    {
        public function CoursePointMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(32));
            return;
        }

        public function getMessageIndex():int
        {
            return getFieldIntegerValue(254, 0, 65535);
        }

        public function setMessageIndex(arg1:int):void
        {
            setFieldValue(254, 0, arg1, 65535);
            return;
        }

        public function getTimestamp():com.garmin.fit.DateTime
        {
            return timestampToDateTime(getFieldDoubleValue(1, 0, 65535));
        }

        public function setTimestamp(arg1:com.garmin.fit.DateTime):void
        {
            setFieldValue(1, 0, arg1.getTimestamp(), 65535);
            return;
        }

        public function getPositionLat():int
        {
            return getFieldIntegerValue(2, 0, 65535);
        }

        public function setPositionLat(arg1:int):void
        {
            setFieldValue(2, 0, arg1, 65535);
            return;
        }

        public function getPositionLong():int
        {
            return getFieldIntegerValue(3, 0, 65535);
        }

        public function setPositionLong(arg1:int):void
        {
            setFieldValue(3, 0, arg1, 65535);
            return;
        }

        public function getDistance():Number
        {
            return getFieldDoubleValue(4, 0, 65535);
        }

        public function setDistance(arg1:Number):void
        {
            setFieldValue(4, 0, arg1, 65535);
            return;
        }

        public function getType():com.garmin.fit.CoursePoint
        {
            var loc1:*=getFieldIntegerValue(5, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.CoursePoint.getByValue(loc1);
        }

        public function setType(arg1:com.garmin.fit.CoursePoint):void
        {
            setFieldValue(5, 0, arg1.getValue(), 65535);
            return;
        }

        public override function getName():String
        {
            return getFieldStringValue(6, 0, 65535);
        }

        public function setName(arg1:String):void
        {
            setFieldValue(6, 0, arg1, 65535);
            return;
        }

        public static function get coursePointMesg():com.garmin.fit.Mesg
        {
            return _coursePointMesg;
        }

        
        {
            _coursePointMesg = new com.garmin.fit.Mesg("course_point", 32);
            coursePointMesg.addField(new com.garmin.fit.Field("message_index", 254, 132, 1, 0, ""));
            coursePointMesg.addField(new com.garmin.fit.Field("timestamp", 1, 134, 1, 0, ""));
            coursePointMesg.addField(new com.garmin.fit.Field("position_lat", 2, 133, 1, 0, "semicircles"));
            coursePointMesg.addField(new com.garmin.fit.Field("position_long", 3, 133, 1, 0, "semicircles"));
            coursePointMesg.addField(new com.garmin.fit.Field("distance", 4, 134, 100, 0, "m"));
            coursePointMesg.addField(new com.garmin.fit.Field("type", 5, 0, 1, 0, ""));
            coursePointMesg.addField(new com.garmin.fit.Field("name", 6, 7, 1, 0, ""));
        }

        internal static var _coursePointMesg:com.garmin.fit.Mesg;
    }
}


//    class DateTime
package com.garmin.fit 
{
    public class DateTime extends Object
    {
        public function DateTime(arg1:*)
        {
            super();
            if (arg1 is Date) 
            {
                this.timestamp = ((arg1 as Date).getTime() - 631065600000) / 1000;
            }
            else if (arg1 is Number) 
            {
                this.timestamp = ((arg1 as Number) - 631065600000) / 1000;
            }
            return;
        }

        public function equals(arg1:com.garmin.fit.DateTime):Boolean
        {
            return this.getTimestamp() == arg1.timestamp;
        }

        public function convertSystemTimeToUTC(arg1:Number):void
        {
            if (timestamp < 268435456) 
            {
                timestamp = timestamp + arg1;
            }
            return;
        }

        public function getTimestamp():Number
        {
            return timestamp;
        }

        public function setTimeStamp(arg1:Number):void
        {
            this.timestamp = arg1;
            return;
        }

        public function getDate():Date
        {
            return new Date(timestamp * 1000 + 631065600000);
        }

        public function toString():String
        {
            return getDate().toString();
        }

        public static const MIN:Number=268435456;

        public static const INVALID:Number=4294967295;

        public static const OFFSET:Number=631065600000;

        internal var timestamp:Number;
    }
}


//    class DeviceInfoMesg
package com.garmin.fit 
{
    public class DeviceInfoMesg extends com.garmin.fit.Mesg
    {
        public function DeviceInfoMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(23));
            return;
        }

        public function getTimestamp():com.garmin.fit.DateTime
        {
            return timestampToDateTime(getFieldDoubleValue(253, 0, 65535));
        }

        public function setTimestamp(arg1:com.garmin.fit.DateTime):void
        {
            setFieldValue(253, 0, arg1.getTimestamp(), 65535);
            return;
        }

        public function getDeviceIndex():int
        {
            return getFieldIntegerValue(0, 0, 65535);
        }

        public function setDeviceIndex(arg1:int):void
        {
            setFieldValue(0, 0, arg1, 65535);
            return;
        }

        public function getDeviceType():int
        {
            return getFieldIntegerValue(1, 0, 65535);
        }

        public function setDeviceType(arg1:int):void
        {
            setFieldValue(1, 0, arg1, 65535);
            return;
        }

        public function getManufacturer():int
        {
            return getFieldIntegerValue(2, 0, 65535);
        }

        public function setManufacturer(arg1:int):void
        {
            setFieldValue(2, 0, arg1, 65535);
            return;
        }

        public function getSerialNumber():Number
        {
            return getFieldDoubleValue(3, 0, 65535);
        }

        public function setSerialNumber(arg1:Number):void
        {
            setFieldValue(3, 0, arg1, 65535);
            return;
        }

        public function getProduct():int
        {
            return getFieldIntegerValue(4, 0, 65535);
        }

        public function setProduct(arg1:int):void
        {
            setFieldValue(4, 0, arg1, 65535);
            return;
        }

        public function getSoftwareVersion():Number
        {
            return getFieldDoubleValue(5, 0, 65535);
        }

        public function setSoftwareVersion(arg1:Number):void
        {
            setFieldValue(5, 0, arg1, 65535);
            return;
        }

        public function getHardwareVersion():int
        {
            return getFieldIntegerValue(6, 0, 65535);
        }

        public function setHardwareVersion(arg1:int):void
        {
            setFieldValue(6, 0, arg1, 65535);
            return;
        }

        public function getCumOperatingTime():Number
        {
            return getFieldDoubleValue(7, 0, 65535);
        }

        public function setCumOperatingTime(arg1:Number):void
        {
            setFieldValue(7, 0, arg1, 65535);
            return;
        }

        public function getBatteryVoltage():Number
        {
            return getFieldDoubleValue(10, 0, 65535);
        }

        public function setBatteryVoltage(arg1:Number):void
        {
            setFieldValue(10, 0, arg1, 65535);
            return;
        }

        public function getBatteryStatus():int
        {
            return getFieldIntegerValue(11, 0, 65535);
        }

        public function setBatteryStatus(arg1:int):void
        {
            setFieldValue(11, 0, arg1, 65535);
            return;
        }

        public static function get deviceInfoMesg():com.garmin.fit.Mesg
        {
            return _deviceInfoMesg;
        }

        
        {
            _deviceInfoMesg = new com.garmin.fit.Mesg("device_info", 23);
            deviceInfoMesg.addField(new com.garmin.fit.Field("timestamp", 253, 134, 1, 0, "s"));
            deviceInfoMesg.addField(new com.garmin.fit.Field("device_index", 0, 2, 1, 0, ""));
            deviceInfoMesg.addField(new com.garmin.fit.Field("device_type", 1, 2, 1, 0, ""));
            deviceInfoMesg.addField(new com.garmin.fit.Field("manufacturer", 2, 132, 1, 0, ""));
            deviceInfoMesg.addField(new com.garmin.fit.Field("serial_number", 3, 140, 1, 0, ""));
            deviceInfoMesg.addField(new com.garmin.fit.Field("product", 4, 132, 1, 0, ""));
            deviceInfoMesg.addField(new com.garmin.fit.Field("software_version", 5, 132, 100, 0, ""));
            deviceInfoMesg.addField(new com.garmin.fit.Field("hardware_version", 6, 2, 1, 0, ""));
            deviceInfoMesg.addField(new com.garmin.fit.Field("cum_operating_time", 7, 134, 1, 0, "s"));
            deviceInfoMesg.addField(new com.garmin.fit.Field("battery_voltage", 10, 132, 256, 0, "V"));
            deviceInfoMesg.addField(new com.garmin.fit.Field("battery_status", 11, 2, 1, 0, ""));
        }

        internal static var _deviceInfoMesg:com.garmin.fit.Mesg;
    }
}


//    class DeviceSettingsMesg
package com.garmin.fit 
{
    public class DeviceSettingsMesg extends com.garmin.fit.Mesg
    {
        public function DeviceSettingsMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(2));
            return;
        }

        public function getUtcOffset():Number
        {
            return getFieldDoubleValue(1, 0, 65535);
        }

        public function setUtcOffset(arg1:Number):void
        {
            setFieldValue(1, 0, arg1, 65535);
            return;
        }

        public static function get deviceSettingsMesg():com.garmin.fit.Mesg
        {
            return _deviceSettingsMesg;
        }

        
        {
            _deviceSettingsMesg = new com.garmin.fit.Mesg("device_settings", 2);
            deviceSettingsMesg.addField(new com.garmin.fit.Field("utc_offset", 1, 134, 1, 0, ""));
        }

        internal static var _deviceSettingsMesg:com.garmin.fit.Mesg;
    }
}


//    class DisplayHeart
package com.garmin.fit 
{
    import __AS3__.vec.*;
    import avmplus.*;
    import com.garmin.fit.custom.*;
    import flash.errors.*;
    
    public class DisplayHeart extends com.garmin.fit.custom.BaseType
    {
        public function DisplayHeart(arg1:Object, arg2:uint)
        {
            super();
            if (arg1 != SINGLETON_ENFORCER) 
            {
                throw new flash.errors.IllegalOperationError("IllegalOperation: Manipulation of type " + avmplus.getQualifiedClassName(this));
            }
            this.value = arg2;
            return;
        }

        public function getAllValues():__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>
        {
            return VALUES;
        }

        public function getInvalid():com.garmin.fit.custom.BaseType
        {
            return INVALID;
        }

        public function getValue():uint
        {
            return value;
        }

        public static function getByValue(arg1:uint):com.garmin.fit.DisplayHeart
        {
            return com.garmin.fit.custom.BaseType.getByValue(arg1) as DisplayHeart;
        }

        
        {
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(4)[0] = BPM;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(4)[1] = MAX;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(4)[2] = RESERVE;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(4)[3] = INVALID;
        }

        internal static const SINGLETON_ENFORCER:Object={};

        public static const BPM:com.garmin.fit.DisplayHeart=new DisplayHeart(SINGLETON_ENFORCER, 0);

        public static const MAX:com.garmin.fit.DisplayHeart=new DisplayHeart(SINGLETON_ENFORCER, 1);

        public static const RESERVE:com.garmin.fit.DisplayHeart=new DisplayHeart(SINGLETON_ENFORCER, 2);

        public static const INVALID:com.garmin.fit.DisplayHeart=new DisplayHeart(SINGLETON_ENFORCER, 255);

        internal static const VALUES:__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>=new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(4);
    }
}


//    class DisplayMeasure
package com.garmin.fit 
{
    import __AS3__.vec.*;
    import avmplus.*;
    import com.garmin.fit.custom.*;
    import flash.errors.*;
    
    public class DisplayMeasure extends com.garmin.fit.custom.BaseType
    {
        public function DisplayMeasure(arg1:Object, arg2:uint)
        {
            super();
            if (arg1 != SINGLETON_ENFORCER) 
            {
                throw new flash.errors.IllegalOperationError("IllegalOperation: Manipulation of type " + avmplus.getQualifiedClassName(this));
            }
            this.value = arg2;
            return;
        }

        public function getAllValues():__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>
        {
            return VALUES;
        }

        public function getInvalid():com.garmin.fit.custom.BaseType
        {
            return INVALID;
        }

        public function getValue():uint
        {
            return value;
        }

        public static function getByValue(arg1:uint):com.garmin.fit.DisplayMeasure
        {
            return com.garmin.fit.custom.BaseType.getByValue(arg1) as DisplayMeasure;
        }

        
        {
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(3)[0] = METRIC;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(3)[1] = STATUTE;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(3)[2] = INVALID;
        }

        internal static const SINGLETON_ENFORCER:Object={};

        public static const METRIC:com.garmin.fit.DisplayMeasure=new DisplayMeasure(SINGLETON_ENFORCER, 0);

        public static const STATUTE:com.garmin.fit.DisplayMeasure=new DisplayMeasure(SINGLETON_ENFORCER, 1);

        public static const INVALID:com.garmin.fit.DisplayMeasure=new DisplayMeasure(SINGLETON_ENFORCER, 255);

        internal static const VALUES:__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>=new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(3);
    }
}


//    class DisplayPosition
package com.garmin.fit 
{
    import __AS3__.vec.*;
    import avmplus.*;
    import com.garmin.fit.custom.*;
    import flash.errors.*;
    
    public class DisplayPosition extends com.garmin.fit.custom.BaseType
    {
        public function DisplayPosition(arg1:Object, arg2:uint)
        {
            super();
            if (arg1 != SINGLETON_ENFORCER) 
            {
                throw new flash.errors.IllegalOperationError("IllegalOperation: Manipulation of type " + avmplus.getQualifiedClassName(this));
            }
            this.value = arg2;
            return;
        }

        public function getAllValues():__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>
        {
            return VALUES;
        }

        public function getInvalid():com.garmin.fit.custom.BaseType
        {
            return INVALID;
        }

        public function getValue():uint
        {
            return value;
        }

        
        {
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[0] = DEGREE;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[1] = DEGREE_MINUTE;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[2] = DEGREE_MINUTE_SECOND;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[3] = AUSTRIAN_GRID;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[4] = BRITISH_GRID;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[5] = DUTCH_GRID;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[6] = HUNGARIAN_GRID;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[7] = FINNISH_GRID;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[8] = GERMAN_GRID;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[9] = ICELANDIC_GRID;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[10] = INDONESIAN_EQUATORIAL;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[11] = INDONESIAN_IRIAN;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[12] = INDONESIAN_SOUTHERN;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[13] = INDIA_ZONE_0;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[14] = INDIA_ZONE_IA;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[15] = INDIA_ZONE_IB;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[16] = INDIA_ZONE_IIA;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[17] = INDIA_ZONE_IIB;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[18] = INDIA_ZONE_IIIA;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[19] = INDIA_ZONE_IIIB;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[20] = INDIA_ZONE_IVA;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[21] = INDIA_ZONE_IVB;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[22] = IRISH_TRANSVERSE;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[23] = IRISH_GRID;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[24] = LORAN;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[25] = MAIDENHEAD_GRID;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[26] = MGRS_GRID;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[27] = NEW_ZEALAND_GRID;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[28] = NEW_ZEALAND_TRANSVERSE;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[29] = QATAR_GRID;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[30] = MODIFIED_SWEDISH_GRID;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[31] = SWEDISH_GRID;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[32] = SOUTH_AFRICAN_GRID;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[33] = SWISS_GRID;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[34] = TAIWAN_GRID;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[35] = UNITED_STATES_GRID;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[36] = UTM_UPS_GRID;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[37] = WEST_MALAYAN;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[38] = BORNEO_RSO;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[39] = ESTONIAN_GRID;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[40] = LATVIAN_GRID;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[41] = SWEDISH_REF_99_GRID;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[42] = INVALID;
        }

        public static function getByValue(arg1:uint):com.garmin.fit.DisplayPosition
        {
            return com.garmin.fit.custom.BaseType.getByValue(arg1) as DisplayPosition;
        }

        public static const DEGREE_MINUTE:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 1);

        public static const DEGREE_MINUTE_SECOND:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 2);

        public static const AUSTRIAN_GRID:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 3);

        public static const BRITISH_GRID:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 4);

        public static const DUTCH_GRID:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 5);

        public static const HUNGARIAN_GRID:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 6);

        public static const FINNISH_GRID:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 7);

        public static const GERMAN_GRID:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 8);

        public static const ICELANDIC_GRID:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 9);

        public static const INDONESIAN_EQUATORIAL:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 10);

        public static const INDONESIAN_IRIAN:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 11);

        public static const INDONESIAN_SOUTHERN:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 12);

        public static const INDIA_ZONE_0:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 13);

        public static const INDIA_ZONE_IA:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 14);

        public static const INDIA_ZONE_IB:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 15);

        public static const INDIA_ZONE_IIA:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 16);

        public static const INDIA_ZONE_IIB:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 17);

        public static const INDIA_ZONE_IIIA:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 18);

        public static const INDIA_ZONE_IIIB:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 19);

        public static const INDIA_ZONE_IVA:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 20);

        public static const INDIA_ZONE_IVB:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 21);

        public static const IRISH_TRANSVERSE:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 22);

        public static const IRISH_GRID:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 23);

        public static const LORAN:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 24);

        public static const MAIDENHEAD_GRID:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 25);

        public static const MGRS_GRID:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 26);

        public static const NEW_ZEALAND_GRID:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 27);

        public static const NEW_ZEALAND_TRANSVERSE:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 28);

        public static const QATAR_GRID:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 29);

        public static const MODIFIED_SWEDISH_GRID:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 30);

        public static const SWEDISH_GRID:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 31);

        public static const SOUTH_AFRICAN_GRID:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 32);

        internal static const SINGLETON_ENFORCER:Object={};

        public static const TAIWAN_GRID:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 34);

        public static const UNITED_STATES_GRID:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 35);

        public static const UTM_UPS_GRID:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 36);

        public static const WEST_MALAYAN:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 37);

        public static const BORNEO_RSO:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 38);

        public static const SWISS_GRID:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 33);

        public static const LATVIAN_GRID:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 40);

        public static const SWEDISH_REF_99_GRID:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 41);

        public static const INVALID:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 255);

        internal static const VALUES:__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>=new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43);

        public static const DEGREE:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 0);

        public static const ESTONIAN_GRID:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 39);
    }
}


//    class DisplayPower
package com.garmin.fit 
{
    import __AS3__.vec.*;
    import avmplus.*;
    import com.garmin.fit.custom.*;
    import flash.errors.*;
    
    public class DisplayPower extends com.garmin.fit.custom.BaseType
    {
        public function DisplayPower(arg1:Object, arg2:uint)
        {
            super();
            if (arg1 != SINGLETON_ENFORCER) 
            {
                throw new flash.errors.IllegalOperationError("IllegalOperation: Manipulation of type " + avmplus.getQualifiedClassName(this));
            }
            this.value = arg2;
            return;
        }

        public function getAllValues():__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>
        {
            return VALUES;
        }

        public function getInvalid():com.garmin.fit.custom.BaseType
        {
            return INVALID;
        }

        public function getValue():uint
        {
            return value;
        }

        public static function getByValue(arg1:uint):com.garmin.fit.DisplayPower
        {
            return com.garmin.fit.custom.BaseType.getByValue(arg1) as DisplayPower;
        }

        
        {
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(3)[0] = WATTS;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(3)[1] = PERCENT_FTP;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(3)[2] = INVALID;
        }

        internal static const SINGLETON_ENFORCER:Object={};

        public static const WATTS:com.garmin.fit.DisplayPower=new DisplayPower(SINGLETON_ENFORCER, 0);

        public static const PERCENT_FTP:com.garmin.fit.DisplayPower=new DisplayPower(SINGLETON_ENFORCER, 1);

        public static const INVALID:com.garmin.fit.DisplayPower=new DisplayPower(SINGLETON_ENFORCER, 255);

        internal static const VALUES:__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>=new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(3);
    }
}


//    class EventMesg
package com.garmin.fit 
{
    public class EventMesg extends com.garmin.fit.Mesg implements com.garmin.fit.MesgWithEvent
    {
        public function EventMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(21));
            return;
        }

        public function getTimestamp():com.garmin.fit.DateTime
        {
            return timestampToDateTime(getFieldDoubleValue(253, 0, 65535));
        }

        public function setTimestamp(arg1:com.garmin.fit.DateTime):void
        {
            setFieldValue(253, 0, arg1.getTimestamp(), 65535);
            return;
        }

        public function getEvent():com.garmin.fit.FITEvent
        {
            var loc1:*=getFieldIntegerValue(0, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.FITEvent.getByValue(loc1);
        }

        public function setEvent(arg1:com.garmin.fit.FITEvent):void
        {
            setFieldValue(0, 0, arg1.getValue(), 65535);
            return;
        }

        public function getEventType():com.garmin.fit.EventType
        {
            var loc1:*=getFieldIntegerValue(1, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.EventType.getByValue(loc1);
        }

        public function setEventType(arg1:com.garmin.fit.EventType):void
        {
            setFieldValue(1, 0, arg1.getValue(), 65535);
            return;
        }

        public function getData16():int
        {
            return getFieldIntegerValue(2, 0, 65535);
        }

        public function setData16(arg1:int):void
        {
            setFieldValue(2, 0, arg1, 65535);
            return;
        }

        public function getData():Number
        {
            return getFieldDoubleValue(3, 0, 65535);
        }

        public function setData(arg1:Number):void
        {
            setFieldValue(3, 0, arg1, 65535);
            return;
        }

        public function getTimerTrigger():com.garmin.fit.TimerTrigger
        {
            var loc1:*=getFieldIntegerValue(3, 0, 0);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.TimerTrigger.getByValue(loc1);
        }

        public function setTimerTrigger(arg1:com.garmin.fit.TimerTrigger):void
        {
            setFieldValue(3, 0, arg1.getValue(), 0);
            return;
        }

        public function getCoursePointIndex():int
        {
            return getFieldIntegerValue(3, 0, 1);
        }

        public function setCoursePointIndex(arg1:int):void
        {
            setFieldValue(3, 0, arg1, 1);
            return;
        }

        public function getBatteryLevel():Number
        {
            return getFieldDoubleValue(3, 0, 2);
        }

        public function setBatteryLevel(arg1:Number):void
        {
            setFieldValue(3, 0, arg1, 2);
            return;
        }

        public function getVirtualPartnerSpeed():Number
        {
            return getFieldDoubleValue(3, 0, 3);
        }

        public function setVirtualPartnerSpeed(arg1:Number):void
        {
            setFieldValue(3, 0, arg1, 3);
            return;
        }

        public function getHrHighAlert():int
        {
            return getFieldIntegerValue(3, 0, 4);
        }

        public function setHrHighAlert(arg1:int):void
        {
            setFieldValue(3, 0, arg1, 4);
            return;
        }

        public function getHrLowAlert():int
        {
            return getFieldIntegerValue(3, 0, 5);
        }

        public function setHrLowAlert(arg1:int):void
        {
            setFieldValue(3, 0, arg1, 5);
            return;
        }

        public function getSpeedHighAlert():Number
        {
            return getFieldDoubleValue(3, 0, 6);
        }

        public function setSpeedHighAlert(arg1:Number):void
        {
            setFieldValue(3, 0, arg1, 6);
            return;
        }

        public function getSpeedLowAlert():Number
        {
            return getFieldDoubleValue(3, 0, 7);
        }

        public function setSpeedLowAlert(arg1:Number):void
        {
            setFieldValue(3, 0, arg1, 7);
            return;
        }

        public function getCadHighAlert():int
        {
            return getFieldIntegerValue(3, 0, 8);
        }

        public function setCadHighAlert(arg1:int):void
        {
            setFieldValue(3, 0, arg1, 8);
            return;
        }

        public function getCadLowAlert():int
        {
            return getFieldIntegerValue(3, 0, 9);
        }

        public function setCadLowAlert(arg1:int):void
        {
            setFieldValue(3, 0, arg1, 9);
            return;
        }

        public function getPowerHighAlert():int
        {
            return getFieldIntegerValue(3, 0, 10);
        }

        public function setPowerHighAlert(arg1:int):void
        {
            setFieldValue(3, 0, arg1, 10);
            return;
        }

        public function getPowerLowAlert():int
        {
            return getFieldIntegerValue(3, 0, 11);
        }

        public function setPowerLowAlert(arg1:int):void
        {
            setFieldValue(3, 0, arg1, 11);
            return;
        }

        public function getTimeDurationAlert():Number
        {
            return getFieldDoubleValue(3, 0, 12);
        }

        public function setTimeDurationAlert(arg1:Number):void
        {
            setFieldValue(3, 0, arg1, 12);
            return;
        }

        public function getDistanceDurationAlert():Number
        {
            return getFieldDoubleValue(3, 0, 13);
        }

        public function setDistanceDurationAlert(arg1:Number):void
        {
            setFieldValue(3, 0, arg1, 13);
            return;
        }

        public function getCalorieDurationAlert():Number
        {
            return getFieldDoubleValue(3, 0, 14);
        }

        public function setCalorieDurationAlert(arg1:Number):void
        {
            setFieldValue(3, 0, arg1, 14);
            return;
        }

        public function getFitnessEquipmentState():com.garmin.fit.FitnessEquipmentState
        {
            var loc1:*=getFieldIntegerValue(3, 0, 15);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.FitnessEquipmentState.getByValue(loc1);
        }

        public function setFitnessEquipmentState(arg1:com.garmin.fit.FitnessEquipmentState):void
        {
            setFieldValue(3, 0, arg1.getValue(), 15);
            return;
        }

        public function getEventGroup():int
        {
            return getFieldIntegerValue(4, 0, 65535);
        }

        public function setEventGroup(arg1:int):void
        {
            setFieldValue(4, 0, arg1, 65535);
            return;
        }

        public static function get eventMesg():com.garmin.fit.Mesg
        {
            return _eventMesg;
        }

        
        {
            _eventMesg = new com.garmin.fit.Mesg("event", 21);
            eventMesg.addField(new com.garmin.fit.Field("timestamp", 253, 134, 1, 0, "s"));
            ++field_index;
            eventMesg.addField(new com.garmin.fit.Field("event", 0, 0, 1, 0, ""));
            ++field_index;
            eventMesg.addField(new com.garmin.fit.Field("event_type", 1, 0, 1, 0, ""));
            ++field_index;
            eventMesg.addField(new com.garmin.fit.Field("data16", 2, 132, 1, 0, ""));
            eventMesg.fields[field_index].components.push(new com.garmin.fit.FieldComponent(3, false, 16, 1, 0));
            ++field_index;
            eventMesg.addField(new com.garmin.fit.Field("data", 3, 134, 1, 0, ""));
            subfield_index = 0;
            eventMesg.fields[field_index].subFields.push(new com.garmin.fit.SubField("timer_trigger", 0, 1, 0, ""));
            eventMesg.fields[field_index].subFields[subfield_index].addMap(0, 0);
            ++subfield_index;
            eventMesg.fields[field_index].subFields.push(new com.garmin.fit.SubField("course_point_index", 132, 1, 0, ""));
            eventMesg.fields[field_index].subFields[subfield_index].addMap(0, 10);
            ++subfield_index;
            eventMesg.fields[field_index].subFields.push(new com.garmin.fit.SubField("battery_level", 132, 1000, 0, "V"));
            eventMesg.fields[field_index].subFields[subfield_index].addMap(0, 11);
            ++subfield_index;
            eventMesg.fields[field_index].subFields.push(new com.garmin.fit.SubField("virtual_partner_speed", 132, 1000, 0, "m/s"));
            eventMesg.fields[field_index].subFields[subfield_index].addMap(0, 12);
            ++subfield_index;
            eventMesg.fields[field_index].subFields.push(new com.garmin.fit.SubField("hr_high_alert", 2, 1, 0, "bpm"));
            eventMesg.fields[field_index].subFields[subfield_index].addMap(0, 13);
            ++subfield_index;
            eventMesg.fields[field_index].subFields.push(new com.garmin.fit.SubField("hr_low_alert", 2, 1, 0, "bpm"));
            eventMesg.fields[field_index].subFields[subfield_index].addMap(0, 14);
            ++subfield_index;
            eventMesg.fields[field_index].subFields.push(new com.garmin.fit.SubField("speed_high_alert", 132, 1000, 0, "m/s"));
            eventMesg.fields[field_index].subFields[subfield_index].addMap(0, 15);
            ++subfield_index;
            eventMesg.fields[field_index].subFields.push(new com.garmin.fit.SubField("speed_low_alert", 132, 1000, 0, "m/s"));
            eventMesg.fields[field_index].subFields[subfield_index].addMap(0, 16);
            ++subfield_index;
            eventMesg.fields[field_index].subFields.push(new com.garmin.fit.SubField("cad_high_alert", 132, 1, 0, "rpm"));
            eventMesg.fields[field_index].subFields[subfield_index].addMap(0, 17);
            ++subfield_index;
            eventMesg.fields[field_index].subFields.push(new com.garmin.fit.SubField("cad_low_alert", 132, 1, 0, "rpm"));
            eventMesg.fields[field_index].subFields[subfield_index].addMap(0, 18);
            ++subfield_index;
            eventMesg.fields[field_index].subFields.push(new com.garmin.fit.SubField("power_high_alert", 132, 1, 0, "watts"));
            eventMesg.fields[field_index].subFields[subfield_index].addMap(0, 19);
            ++subfield_index;
            eventMesg.fields[field_index].subFields.push(new com.garmin.fit.SubField("power_low_alert", 132, 1, 0, "watts"));
            eventMesg.fields[field_index].subFields[subfield_index].addMap(0, 20);
            ++subfield_index;
            eventMesg.fields[field_index].subFields.push(new com.garmin.fit.SubField("time_duration_alert", 134, 1000, 0, "s"));
            eventMesg.fields[field_index].subFields[subfield_index].addMap(0, 23);
            ++subfield_index;
            eventMesg.fields[field_index].subFields.push(new com.garmin.fit.SubField("distance_duration_alert", 134, 100, 0, "m"));
            eventMesg.fields[field_index].subFields[subfield_index].addMap(0, 24);
            ++subfield_index;
            eventMesg.fields[field_index].subFields.push(new com.garmin.fit.SubField("calorie_duration_alert", 134, 1, 0, "calories"));
            eventMesg.fields[field_index].subFields[subfield_index].addMap(0, 25);
            ++subfield_index;
            eventMesg.fields[field_index].subFields.push(new com.garmin.fit.SubField("fitness_equipment_state", 0, 1, 0, ""));
            eventMesg.fields[field_index].subFields[subfield_index].addMap(0, 27);
            ++subfield_index;
            ++field_index;
            eventMesg.addField(new com.garmin.fit.Field("event_group", 4, 2, 1, 0, ""));
            ++field_index;
        }

        internal static var field_index:int=0;

        internal static var subfield_index:int=0;

        internal static var _eventMesg:com.garmin.fit.Mesg;
    }
}


//    class EventType
package com.garmin.fit 
{
    import __AS3__.vec.*;
    import avmplus.*;
    import flash.errors.*;
    
    public class EventType extends Object
    {
        public function EventType(arg1:Object, arg2:uint)
        {
            super();
            if (arg1 != SINGLETON_ENFORCER) 
            {
                throw new flash.errors.IllegalOperationError("IllegalOperation: Manipulation of type " + avmplus.getQualifiedClassName(this));
            }
            this.value = arg2;
            return;
        }

        public function getValue():uint
        {
            return value;
        }

        public static function getByValue(arg1:uint):com.garmin.fit.EventType
        {
            var loc3:*=0;
            var loc2:*=EventType.VALUES;
            for each (var loc1:* in loc2) 
            {
                if (!(arg1 == loc1.value)) 
                {
                    continue;
                }
                return loc1;
            }
            return EventType.INVALID;
        }

        
        {
            new __AS3__.vec.Vector.<>(11)[0] = START;
            new __AS3__.vec.Vector.<>(11)[1] = STOP;
            new __AS3__.vec.Vector.<>(11)[2] = CONSECUTIVE_DEPRECIATED;
            new __AS3__.vec.Vector.<>(11)[3] = MARKER;
            new __AS3__.vec.Vector.<>(11)[4] = STOP_ALL;
            new __AS3__.vec.Vector.<>(11)[5] = BEGIN_DEPRECIATED;
            new __AS3__.vec.Vector.<>(11)[6] = END_DEPRECIATED;
            new __AS3__.vec.Vector.<>(11)[7] = END_ALL_DEPRECIATED;
            new __AS3__.vec.Vector.<>(11)[8] = STOP_DISABLE;
            new __AS3__.vec.Vector.<>(11)[9] = STOP_DISABLE_ALL;
            new __AS3__.vec.Vector.<>(11)[10] = INVALID;
        }

        internal static const SINGLETON_ENFORCER:Object={};

        public static const START:com.garmin.fit.EventType=new EventType(SINGLETON_ENFORCER, 0);

        public static const STOP:com.garmin.fit.EventType=new EventType(SINGLETON_ENFORCER, 1);

        public static const CONSECUTIVE_DEPRECIATED:com.garmin.fit.EventType=new EventType(SINGLETON_ENFORCER, 2);

        public static const MARKER:com.garmin.fit.EventType=new EventType(SINGLETON_ENFORCER, 3);

        public static const STOP_ALL:com.garmin.fit.EventType=new EventType(SINGLETON_ENFORCER, 4);

        public static const BEGIN_DEPRECIATED:com.garmin.fit.EventType=new EventType(SINGLETON_ENFORCER, 5);

        public static const END_DEPRECIATED:com.garmin.fit.EventType=new EventType(SINGLETON_ENFORCER, 6);

        public static const END_ALL_DEPRECIATED:com.garmin.fit.EventType=new EventType(SINGLETON_ENFORCER, 7);

        public static const STOP_DISABLE:com.garmin.fit.EventType=new EventType(SINGLETON_ENFORCER, 8);

        public static const STOP_DISABLE_ALL:com.garmin.fit.EventType=new EventType(SINGLETON_ENFORCER, 9);

        public static const INVALID:com.garmin.fit.EventType=new EventType(SINGLETON_ENFORCER, 255);

        internal static const VALUES:__AS3__.vec.Vector.<com.garmin.fit.EventType>=new __AS3__.vec.Vector.<>(11);

        internal var value:uint;
    }
}


//    class FITBool
package com.garmin.fit 
{
    import __AS3__.vec.*;
    import avmplus.*;
    import com.garmin.fit.custom.*;
    import flash.errors.*;
    
    public class FITBool extends com.garmin.fit.custom.BaseType
    {
        public function FITBool(arg1:Object, arg2:uint)
        {
            super();
            if (arg1 != SINGLETON_ENFORCER) 
            {
                throw new flash.errors.IllegalOperationError("IllegalOperation: Manipulation of type " + avmplus.getQualifiedClassName(this));
            }
            this.value = arg2;
            return;
        }

        public function getAllValues():__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>
        {
            return VALUES;
        }

        public function getInvalid():com.garmin.fit.custom.BaseType
        {
            return INVALID;
        }

        public function getValue():uint
        {
            return value;
        }

        public static function getByValue(arg1:uint):com.garmin.fit.FITBool
        {
            return com.garmin.fit.custom.BaseType.getByValue(arg1) as FITBool;
        }

        
        {
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(3)[0] = FALSE;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(3)[1] = TRUE;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(3)[2] = INVALID;
        }

        internal static const SINGLETON_ENFORCER:Object={};

        public static const FALSE:com.garmin.fit.FITBool=new FITBool(SINGLETON_ENFORCER, 0);

        public static const TRUE:com.garmin.fit.FITBool=new FITBool(SINGLETON_ENFORCER, 1);

        public static const INVALID:com.garmin.fit.FITBool=new FITBool(SINGLETON_ENFORCER, 255);

        internal static const VALUES:__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>=new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(3);
    }
}


//    class FITEvent
package com.garmin.fit 
{
    import __AS3__.vec.*;
    import avmplus.*;
    import flash.errors.*;
    
    public class FITEvent extends Object
    {
        public function FITEvent(arg1:Object, arg2:uint)
        {
            super();
            if (arg1 != SINGLETON_ENFORCER) 
            {
                throw new flash.errors.IllegalOperationError("IllegalOperation: Manipulation of type " + avmplus.getQualifiedClassName(this));
            }
            this.value = arg2;
            return;
        }

        public static function getByValue(arg1:uint):com.garmin.fit.FITEvent
        {
            var loc3:*=0;
            var loc2:*=FITEvent.VALUES;
            for each (var loc1:* in loc2) 
            {
                if (!(arg1 == loc1.value)) 
                {
                    continue;
                }
                return loc1;
            }
            return FITEvent.INVALID;
        }

        public function getValue():uint
        {
            return value;
        }

        
        {
            new __AS3__.vec.Vector.<>(28)[0] = TIMER;
            new __AS3__.vec.Vector.<>(28)[1] = WORKOUT;
            new __AS3__.vec.Vector.<>(28)[2] = WORKOUT_STEP;
            new __AS3__.vec.Vector.<>(28)[3] = POWER_DOWN;
            new __AS3__.vec.Vector.<>(28)[4] = POWER_UP;
            new __AS3__.vec.Vector.<>(28)[5] = OFF_COURSE;
            new __AS3__.vec.Vector.<>(28)[6] = SESSION;
            new __AS3__.vec.Vector.<>(28)[7] = LAP;
            new __AS3__.vec.Vector.<>(28)[8] = COURSE_POINT;
            new __AS3__.vec.Vector.<>(28)[9] = BATTERY;
            new __AS3__.vec.Vector.<>(28)[10] = VIRTUAL_PARTNER_PACE;
            new __AS3__.vec.Vector.<>(28)[11] = HR_HIGH_ALERT;
            new __AS3__.vec.Vector.<>(28)[12] = HR_LOW_ALERT;
            new __AS3__.vec.Vector.<>(28)[13] = SPEED_HIGH_ALERT;
            new __AS3__.vec.Vector.<>(28)[14] = SPEED_LOW_ALERT;
            new __AS3__.vec.Vector.<>(28)[15] = CAD_HIGH_ALERT;
            new __AS3__.vec.Vector.<>(28)[16] = CAD_LOW_ALERT;
            new __AS3__.vec.Vector.<>(28)[17] = POWER_HIGH_ALERT;
            new __AS3__.vec.Vector.<>(28)[18] = POWER_LOW_ALERT;
            new __AS3__.vec.Vector.<>(28)[19] = RECOVERY_HR;
            new __AS3__.vec.Vector.<>(28)[20] = BATTERY_LOW;
            new __AS3__.vec.Vector.<>(28)[21] = TIME_DURATION_ALERT;
            new __AS3__.vec.Vector.<>(28)[22] = DISTANCE_DURATION_ALERT;
            new __AS3__.vec.Vector.<>(28)[23] = CALORIE_DURATION_ALERT;
            new __AS3__.vec.Vector.<>(28)[24] = ACTIVITY;
            new __AS3__.vec.Vector.<>(28)[25] = FITNESS_EQUIPMENT;
            new __AS3__.vec.Vector.<>(28)[26] = LENGTH;
            new __AS3__.vec.Vector.<>(28)[27] = INVALID;
        }

        internal static const SINGLETON_ENFORCER:Object={};

        public static const TIMER:com.garmin.fit.FITEvent=new FITEvent(SINGLETON_ENFORCER, 0);

        public static const WORKOUT:com.garmin.fit.FITEvent=new FITEvent(SINGLETON_ENFORCER, 3);

        public static const WORKOUT_STEP:com.garmin.fit.FITEvent=new FITEvent(SINGLETON_ENFORCER, 4);

        public static const POWER_DOWN:com.garmin.fit.FITEvent=new FITEvent(SINGLETON_ENFORCER, 5);

        public static const POWER_UP:com.garmin.fit.FITEvent=new FITEvent(SINGLETON_ENFORCER, 6);

        public static const OFF_COURSE:com.garmin.fit.FITEvent=new FITEvent(SINGLETON_ENFORCER, 7);

        public static const SESSION:com.garmin.fit.FITEvent=new FITEvent(SINGLETON_ENFORCER, 8);

        public static const LAP:com.garmin.fit.FITEvent=new FITEvent(SINGLETON_ENFORCER, 9);

        public static const COURSE_POINT:com.garmin.fit.FITEvent=new FITEvent(SINGLETON_ENFORCER, 10);

        public static const BATTERY:com.garmin.fit.FITEvent=new FITEvent(SINGLETON_ENFORCER, 11);

        public static const VIRTUAL_PARTNER_PACE:com.garmin.fit.FITEvent=new FITEvent(SINGLETON_ENFORCER, 12);

        public static const HR_HIGH_ALERT:com.garmin.fit.FITEvent=new FITEvent(SINGLETON_ENFORCER, 13);

        public static const HR_LOW_ALERT:com.garmin.fit.FITEvent=new FITEvent(SINGLETON_ENFORCER, 14);

        public static const CAD_HIGH_ALERT:com.garmin.fit.FITEvent=new FITEvent(SINGLETON_ENFORCER, 17);

        public static const CAD_LOW_ALERT:com.garmin.fit.FITEvent=new FITEvent(SINGLETON_ENFORCER, 18);

        public static const POWER_HIGH_ALERT:com.garmin.fit.FITEvent=new FITEvent(SINGLETON_ENFORCER, 19);

        public static const POWER_LOW_ALERT:com.garmin.fit.FITEvent=new FITEvent(SINGLETON_ENFORCER, 20);

        public static const RECOVERY_HR:com.garmin.fit.FITEvent=new FITEvent(SINGLETON_ENFORCER, 21);

        public static const BATTERY_LOW:com.garmin.fit.FITEvent=new FITEvent(SINGLETON_ENFORCER, 22);

        public static const TIME_DURATION_ALERT:com.garmin.fit.FITEvent=new FITEvent(SINGLETON_ENFORCER, 23);

        public static const DISTANCE_DURATION_ALERT:com.garmin.fit.FITEvent=new FITEvent(SINGLETON_ENFORCER, 24);

        public static const CALORIE_DURATION_ALERT:com.garmin.fit.FITEvent=new FITEvent(SINGLETON_ENFORCER, 25);

        public static const ACTIVITY:com.garmin.fit.FITEvent=new FITEvent(SINGLETON_ENFORCER, 26);

        public static const FITNESS_EQUIPMENT:com.garmin.fit.FITEvent=new FITEvent(SINGLETON_ENFORCER, 27);

        public static const LENGTH:com.garmin.fit.FITEvent=new FITEvent(SINGLETON_ENFORCER, 28);

        public static const INVALID:com.garmin.fit.FITEvent=new FITEvent(SINGLETON_ENFORCER, 255);

        public static const VALUES:__AS3__.vec.Vector.<com.garmin.fit.FITEvent>=new __AS3__.vec.Vector.<>(28);

        public static const SPEED_LOW_ALERT:com.garmin.fit.FITEvent=new FITEvent(SINGLETON_ENFORCER, 16);

        public static const SPEED_HIGH_ALERT:com.garmin.fit.FITEvent=new FITEvent(SINGLETON_ENFORCER, 15);

        internal var value:uint;
    }
}


//    class FITFile
package com.garmin.fit 
{
    import __AS3__.vec.*;
    import avmplus.*;
    import flash.errors.*;
    
    public class FITFile extends Object
    {
        public function FITFile(arg1:Object, arg2:uint)
        {
            super();
            if (arg1 != SINGLETON_ENFORCER) 
            {
                throw new flash.errors.IllegalOperationError("IllegalOperation: Manipulation of type " + avmplus.getQualifiedClassName(this));
            }
            this.value = arg2;
            return;
        }

        public function getValue():Number
        {
            return value;
        }

        public static function getByValue(arg1:uint):com.garmin.fit.FITFile
        {
            var loc3:*=0;
            var loc2:*=FITFile.VALUES;
            for each (var loc1:* in loc2) 
            {
                if (!(arg1 == loc1.value)) 
                {
                    continue;
                }
                return loc1;
            }
            return FITFile.INVALID;
        }

        
        {
            new __AS3__.vec.Vector.<>(15)[0] = DEVICE;
            new __AS3__.vec.Vector.<>(15)[1] = SETTINGS;
            new __AS3__.vec.Vector.<>(15)[2] = SPORT;
            new __AS3__.vec.Vector.<>(15)[3] = ACTIVITY;
            new __AS3__.vec.Vector.<>(15)[4] = WORKOUT;
            new __AS3__.vec.Vector.<>(15)[5] = COURSE;
            new __AS3__.vec.Vector.<>(15)[6] = SCHEDULES;
            new __AS3__.vec.Vector.<>(15)[7] = WEIGHT;
            new __AS3__.vec.Vector.<>(15)[8] = TOTALS;
            new __AS3__.vec.Vector.<>(15)[9] = GOALS;
            new __AS3__.vec.Vector.<>(15)[10] = BLOOD_PRESSURE;
            new __AS3__.vec.Vector.<>(15)[11] = MONITORING;
            new __AS3__.vec.Vector.<>(15)[12] = ACTIVITY_SUMMARY;
            new __AS3__.vec.Vector.<>(15)[13] = MONITORING_DAILY;
            new __AS3__.vec.Vector.<>(15)[14] = INVALID;
        }

        internal static const SINGLETON_ENFORCER:Object={};

        public static const DEVICE:com.garmin.fit.FITFile=new FITFile(SINGLETON_ENFORCER, 1);

        public static const SETTINGS:com.garmin.fit.FITFile=new FITFile(SINGLETON_ENFORCER, 2);

        public static const SPORT:com.garmin.fit.FITFile=new FITFile(SINGLETON_ENFORCER, 3);

        public static const ACTIVITY:com.garmin.fit.FITFile=new FITFile(SINGLETON_ENFORCER, 4);

        public static const WORKOUT:com.garmin.fit.FITFile=new FITFile(SINGLETON_ENFORCER, 5);

        public static const COURSE:com.garmin.fit.FITFile=new FITFile(SINGLETON_ENFORCER, 6);

        public static const SCHEDULES:com.garmin.fit.FITFile=new FITFile(SINGLETON_ENFORCER, 7);

        public static const WEIGHT:com.garmin.fit.FITFile=new FITFile(SINGLETON_ENFORCER, 9);

        public static const TOTALS:com.garmin.fit.FITFile=new FITFile(SINGLETON_ENFORCER, 10);

        public static const GOALS:com.garmin.fit.FITFile=new FITFile(SINGLETON_ENFORCER, 11);

        public static const BLOOD_PRESSURE:com.garmin.fit.FITFile=new FITFile(SINGLETON_ENFORCER, 14);

        public static const MONITORING:com.garmin.fit.FITFile=new FITFile(SINGLETON_ENFORCER, 15);

        public static const ACTIVITY_SUMMARY:com.garmin.fit.FITFile=new FITFile(SINGLETON_ENFORCER, 20);

        public static const MONITORING_DAILY:com.garmin.fit.FITFile=new FITFile(SINGLETON_ENFORCER, 28);

        public static const INVALID:com.garmin.fit.FITFile=new FITFile(SINGLETON_ENFORCER, 255);

        public static const VALUES:__AS3__.vec.Vector.<com.garmin.fit.FITFile>=new __AS3__.vec.Vector.<>(15);

        internal var value:uint;
    }
}


//    class FITFileEncoder
package com.garmin.fit 
{
    import __AS3__.vec.*;
    import com.logging.*;
    import flash.errors.*;
    import flash.events.*;
    import flash.filesystem.*;
    
    public class FITFileEncoder extends flash.events.EventDispatcher implements com.garmin.fit.MesgListener, com.garmin.fit.MesgDefinitionListener
    {
        public function FITFileEncoder(arg1:flash.filesystem.File=null)
        {
            lastMesgDefinition = new __AS3__.vec.Vector.<com.garmin.fit.MesgDefinition>(16, false);
            super(null);
            com.logging.ErrorLogging.getInstance().addTarget(this);
            if (arg1 != null) 
            {
                open(arg1);
            }
            return;
        }

        public function open(arg1:flash.filesystem.File):void
        {
            var loc1:*=null;
            var loc2:*=null;
            try 
            {
                if (arg1.exists) 
                {
                    arg1.deleteFile();
                }
                this.file = arg1;
                writeFileHeader();
            }
            catch (e:flash.errors.IOError)
            {
                loc1 = "IOError - The directory does not exist, or the directory could not be deleted. On Windows, you cannot delete a directory that contains a file that is open.";
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 1800000, "FitEncoding: " + e.message));
            }
            catch (e:SecurityError)
            {
                loc2 = "SecurityError - The application does not have the necessary permissions to delete the directory.";
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 1800000, "FitEncoding: " + e.message));
            }
            return;
        }

        internal function writeFileHeader():void
        {
            var loc4:*=0;
            if (file == null) 
            {
                throw new com.garmin.fit.FitRuntimeException("File not open.");
            }
            stream = new flash.filesystem.FileStream();
            stream.open(file, "update");
            var loc3:*=file.size - 14;
            var loc1:*=0;
            var loc2:*=0;
            if (loc3 < 0) 
            {
                loc3 = 0;
            }
            loc4 = 0;
            while (loc4 < 14 - 2) 
            {
            };
            stream.writeByte(loc2 & 255);
            stream.writeByte(loc2 >> 8 & 255);
            return;
        }

        public function onMesg(arg1:*):void
        {
            write(arg1 as com.garmin.fit.Mesg);
            return;
        }

        public function onMesgDefinition(arg1:*):void
        {
            write(arg1 as com.garmin.fit.MesgDefinition);
            return;
        }

        public function write(arg1:*):void
        {
            var loc1:*=null;
            var loc3:*=null;
            var loc2:*=undefined;
            if (arg1 is com.garmin.fit.MesgDefinition) 
            {
                loc1 = arg1 as com.garmin.fit.MesgDefinition;
                if (file == null) 
                {
                    throw new com.garmin.fit.FitRuntimeException("File not open.");
                }
                loc1.write(stream);
                lastMesgDefinition[loc1.localNum] = loc1;
            }
            else if (arg1 is com.garmin.fit.Mesg) 
            {
                loc3 = arg1 as com.garmin.fit.Mesg;
                if (file == null) 
                {
                    throw new com.garmin.fit.FitRuntimeException("File not open.");
                }
                if (lastMesgDefinition[loc3.localNum] == null || !lastMesgDefinition[loc3.localNum].supports(loc3)) 
                {
                    write(new com.garmin.fit.MesgDefinition(loc3));
                }
                loc3.write(stream, lastMesgDefinition[loc3.localNum]);
            }
            else if (arg1 is __AS3__.vec.Vector.<com.garmin.fit.Mesg>) 
            {
                loc2 = arg1 as __AS3__.vec.Vector.<com.garmin.fit.Mesg>;
                var loc6:*=0;
                var loc5:*=loc2;
                for each (var loc4:* in loc5) 
                {
                    write(loc4);
                }
            }
            else 
            {
                throw new com.garmin.fit.FitRuntimeException("Portierungsfehler");
            }
            return;
        }

        public function close():void
        {
            if (file == null) 
            {
                throw new com.garmin.fit.FitRuntimeException("File not open.");
            }
            stream.close();
            writeFileHeader();
            stream.close();
            var loc1:*=0;
            stream = new flash.filesystem.FileStream();
            stream.open(file, "update");
            while (stream.bytesAvailable > 0) 
            {
                loc1 = com.garmin.fit.CRC.get16(loc1, stream.readByte());
            }
            stream.writeByte(loc1 & 255);
            stream.writeByte(loc1 >> 8 & 255);
            this.stream.close();
            this.file = null;
            return;
        }

        internal var lastMesgDefinition:__AS3__.vec.Vector.<com.garmin.fit.MesgDefinition>;

        internal var file:flash.filesystem.File;

        internal var stream:flash.filesystem.FileStream;
    }
}


//    class Factory
package com.garmin.fit 
{
    import __AS3__.vec.*;
    import com.garmin.fit.custom.rox100.*;
    
    public class Factory extends Object
    {
        public function Factory()
        {
            super();
            return;
        }

        public static function createMesg(arg1:Object):com.garmin.fit.Mesg
        {
            var loc2:*=0;
            var loc1:*=null;
            var loc3:*=0;
            var loc4:*=null;
            if (arg1 is String) 
            {
                loc1 = arg1 as String;
                loc2 = 0;
                while (loc2 < mesgs.length) 
                {
                    if (mesgs[loc2].name == loc1) 
                    {
                        return new com.garmin.fit.Mesg(mesgs[loc2]);
                    }
                    ++loc2;
                }
                return new com.garmin.fit.Mesg(loc1, 65535);
            }
            if (arg1 is int) 
            {
                loc3 = arg1 as int;
                loc2 = 0;
                while (loc2 < mesgs.length) 
                {
                    if (mesgs[loc2].num == loc3) 
                    {
                        return new com.garmin.fit.Mesg(mesgs[loc2]);
                    }
                    ++loc2;
                }
                return new com.garmin.fit.Mesg("unknown", loc3);
            }
        }

        public static function createField(arg1:*, arg2:*=null, arg3:Array=null):com.garmin.fit.Field
        {
            var loc2:*=null;
            var loc6:*=0;
            var loc5:*=0;
            var loc1:*=null;
            var loc4:*=0;
            var loc3:*=null;
            if (arg1 is String && arg2 is String && arg3 == null) 
            {
                loc2 = arg1 as String;
                loc1 = arg2 as String;
                loc4 = 0;
                while (loc4 < mesgs.length) 
                {
                    if (mesgs[loc4].name == loc2) 
                    {
                        return new com.garmin.fit.Field(mesgs[loc4].getField(loc1, false));
                    }
                    ++loc4;
                }
                return new com.garmin.fit.Field(loc1, 255, 0, 1, 0, "");
            }
            if (arg1 is String && arg2 is int && arg3 == null) 
            {
                loc2 = arg1 as String;
                loc5 = arg2 as int;
                loc4 = 0;
                while (loc4 < mesgs.length) 
                {
                    if (mesgs[loc4].name == loc2) 
                    {
                        return new com.garmin.fit.Field(mesgs[loc4].getField(loc5));
                    }
                    ++loc4;
                }
                return new com.garmin.fit.Field("unknown", loc5, 0, 1, 0, "");
            }
            if (arg1 is int && arg2 is int && arg3 == null) 
            {
                if ((loc6 = arg1 as int) != 1980) 
                {
                    if (loc6 != 1982) 
                    {
                        if (loc6 != 1981) 
                        {
                            if (loc6 == 1983) 
                            {
                                loc6 = 65280;
                            }
                        }
                        else 
                        {
                            loc6 = 65283;
                        }
                    }
                    else 
                    {
                        loc6 = 65282;
                    }
                }
                else 
                {
                    loc6 = 65281;
                }
                loc5 = arg2 as int;
                loc4 = 0;
                while (loc4 < mesgs.length) 
                {
                    if (mesgs[loc4].num == loc6) 
                    {
                        return new com.garmin.fit.Field(mesgs[loc4].getField(loc5));
                    }
                    ++loc4;
                }
                return new com.garmin.fit.Field("unknown", loc5, 0, 1, 0, "");
            }
            if (arg1 is int && arg2 is String && arg3 == null) 
            {
                if ((loc6 = arg1 as int) != 1980) 
                {
                    if (loc6 != 1982) 
                    {
                        if (loc6 != 1981) 
                        {
                            if (loc6 == 1983) 
                            {
                                loc6 = 65280;
                            }
                        }
                        else 
                        {
                            loc6 = 65283;
                        }
                    }
                    else 
                    {
                        loc6 = 65282;
                    }
                }
                else 
                {
                    loc6 = 65281;
                }
                loc1 = loc1 as String;
                loc4 = 0;
                while (loc4 < mesgs.length) 
                {
                    if (mesgs[loc4].num == loc6) 
                    {
                        return new com.garmin.fit.Field(mesgs[loc4].getField(loc1, false));
                    }
                    ++loc4;
                }
                return new com.garmin.fit.Field(loc1, 255, 0, 1, 0, "");
            }
            if (arg1 is String && arg2 is String && !(arg3 == null)) 
            {
                loc2 = arg1 as String;
                loc1 = arg2 as String;
                (loc3 = createField(loc2, loc1)).values.push(arg3);
                return loc3;
            }
            throw new com.garmin.fit.FitRuntimeException("loggingErrorEvent", 1800001, "FITEncoding > Logical Error: Factory.createField");
            return null;
        }

        
        {
            mesgs = new __AS3__.vec.Vector.<com.garmin.fit.Mesg>(false);
            mesgs.push(com.garmin.fit.FileIdMesg.fileIdMesg);
            mesgs.push(com.garmin.fit.FileCreatorMesg.fileCreatorMesg);
            mesgs.push(com.garmin.fit.SoftwareMesg.softwareMesg);
            mesgs.push(com.garmin.fit.SlaveDeviceMesg.slaveDeviceMesg);
            mesgs.push(com.garmin.fit.CapabilitiesMesg.capabilitiesMesg);
            mesgs.push(com.garmin.fit.FileCapabilitiesMesg.fileCapabilitiesMesg);
            mesgs.push(com.garmin.fit.MesgCapabilitiesMesg.mesgCapabilitiesMesg);
            mesgs.push(com.garmin.fit.FieldCapabilitiesMesg.fieldCapabilitiesMesg);
            mesgs.push(com.garmin.fit.DeviceSettingsMesg.deviceSettingsMesg);
            mesgs.push(com.garmin.fit.UserProfileMesg.userProfileMesg);
            mesgs.push(com.garmin.fit.HrmProfileMesg.hrmProfileMesg);
            mesgs.push(com.garmin.fit.SdmProfileMesg.sdmProfileMesg);
            mesgs.push(com.garmin.fit.BikeProfileMesg.bikeProfileMesg);
            mesgs.push(com.garmin.fit.ZonesTargetMesg.zonesTargetMesg);
            mesgs.push(com.garmin.fit.SportMesg.sportMesg);
            mesgs.push(com.garmin.fit.HrZoneMesg.hrZoneMesg);
            mesgs.push(com.garmin.fit.SpeedZoneMesg.speedZoneMesg);
            mesgs.push(com.garmin.fit.CadenceZoneMesg.cadenceZoneMesg);
            mesgs.push(com.garmin.fit.PowerZoneMesg.powerZoneMesg);
            mesgs.push(com.garmin.fit.MetZoneMesg.metZoneMesg);
            mesgs.push(com.garmin.fit.GoalMesg.goalMesg);
            mesgs.push(com.garmin.fit.ActivityMesg.activityMesg);
            mesgs.push(com.garmin.fit.SessionMesg.sessionMesg);
            mesgs.push(com.garmin.fit.LapMesg.lapMesg);
            mesgs.push(com.garmin.fit.LengthMesg.lengthMesg);
            mesgs.push(com.garmin.fit.RecordMesg.recordMesg);
            mesgs.push(com.garmin.fit.EventMesg.eventMesg);
            mesgs.push(com.garmin.fit.DeviceInfoMesg.deviceInfoMesg);
            mesgs.push(com.garmin.fit.HrvMesg.hrvMesg);
            mesgs.push(com.garmin.fit.CourseMesg.courseMesg);
            mesgs.push(com.garmin.fit.CoursePointMesg.coursePointMesg);
            mesgs.push(com.garmin.fit.WorkoutMesg.workoutMesg);
            mesgs.push(com.garmin.fit.WorkoutStepMesg.workoutStepMesg);
            mesgs.push(com.garmin.fit.ScheduleMesg.scheduleMesg);
            mesgs.push(com.garmin.fit.TotalsMesg.totalsMesg);
            mesgs.push(com.garmin.fit.WeightScaleMesg.weightScaleMesg);
            mesgs.push(com.garmin.fit.BloodPressureMesg.bloodPressureMesg);
            mesgs.push(com.garmin.fit.MonitoringInfoMesg.monitoringInfoMesg);
            mesgs.push(com.garmin.fit.MonitoringMesg.monitoringMesg);
            mesgs.push(com.garmin.fit.PadMesg.padMesg);
            mesgs.push(com.garmin.fit.custom.rox100.SigmaLogMesg.logMesg);
            mesgs.push(com.garmin.fit.custom.rox100.SigmaLapMesg.markerROX100LapMesg);
            mesgs.push(com.garmin.fit.custom.rox100.SigmaBreakMesg.markerROX100MBreakMesg);
            mesgs.push(com.garmin.fit.custom.rox100.SigmaRecordMesg.logEntryMesg);
            mesgs.fixed = true;
        }

        internal static var mesgs:__AS3__.vec.Vector.<com.garmin.fit.Mesg>;
    }
}


//    class Field
package com.garmin.fit 
{
    import __AS3__.vec.*;
    import flash.events.*;
    import flash.filesystem.*;
    import flash.utils.*;
    
    public class Field extends flash.events.EventDispatcher
    {
        public function Field(arg1:*=null, arg2:int=0, arg3:int=0, arg4:Number=NaN, arg5:Number=NaN, arg6:String=null)
        {
            var loc4:*=0;
            var loc2:*=null;
            super();
            if (arg1 == null) 
            {
                this.name = "unknown";
                this.num = 255;
                this.type = 0;
                this.scale = 1;
                this.offset = 0;
                this.units = "";
                this.values = new __AS3__.vec.Vector.<Object>(0);
                this.components = new __AS3__.vec.Vector.<com.garmin.fit.FieldComponent>(0);
                this.subFields = new __AS3__.vec.Vector.<com.garmin.fit.SubField>(0);
                return;
            }
            if (arg1 is com.garmin.fit.Field) 
            {
                loc2 = arg1 as com.garmin.fit.Field;
                var loc3:*;
                var loc1:*=(loc3 = (arg1 as com.garmin.fit.Field).values).length;
                this.name = new String(loc2.name);
                this.num = loc2.num;
                this.type = loc2.type;
                this.scale = loc2.scale;
                this.offset = loc2.offset;
                this.units = new String(loc2.units);
                this.values = new __AS3__.vec.Vector.<Object>(0);
                loc4 = 0;
                while (loc4 < loc1) 
                {
                    this.values.push(loc3[loc4]);
                    ++loc4;
                }
                this.components = loc2.components;
                this.subFields = loc2.subFields;
            }
            else if (arg1 is String) 
            {
                this.name = arg1 as String;
                this.num = arg2;
                this.type = arg3;
                this.scale = arg4;
                this.offset = arg5;
                this.units = arg6;
                this.values = new __AS3__.vec.Vector.<Object>(0);
                this.components = new __AS3__.vec.Vector.<com.garmin.fit.FieldComponent>(0);
                this.subFields = new __AS3__.vec.Vector.<com.garmin.fit.SubField>(0);
            }
            return;
        }

        public function getFloatValue(arg1:int, arg2:*):Number
        {
            var loc2:*=null;
            var loc1:*=0;
            if (arg2 is String) 
            {
                loc2 = arg2 as String;
                return getFloatValueInternal(arg1, getSubField(loc2));
            }
            if (arg2 is int) 
            {
                loc1 = arg2 as int;
                return getFloatValueInternal(arg1, getSubField(loc1));
            }
            throw new com.garmin.fit.FitRuntimeException("loggingErrorEvent", 1800001, "FITEncoding > Logical Error: Field.getFloatValue: " + name);
        }

        internal function getFloatValueInternal(arg1:int, arg2:com.garmin.fit.SubField):Number
        {
            var loc1:*=getValueInternal(arg1, arg2);
            if (loc1 == null) 
            {
                return NaN;
            }
            return loc1 as Number;
        }

        public function getDoubleValue(arg1:*=null, arg2:*=null):Number
        {
            var loc3:*=null;
            var loc2:*=0;
            if (arg2 == null) 
            {
                return getDoubleValueInternal(0, null);
            }
            var loc1:*=arg1 as int;
            if (arg2 is String) 
            {
                loc3 = arg2 as String;
                return getDoubleValueInternal(loc1, getSubField(loc3));
            }
            if (arg2 is int) 
            {
                loc2 = arg2 as int;
                return getDoubleValueInternal(loc1, getSubField(loc2));
            }
            throw new com.garmin.fit.FitRuntimeException("loggingErrorEvent", 1800001, "FITEncoding > Logical Error: Field.getDoubleValue: " + name);
        }

        internal function getDoubleValueInternal(arg1:int, arg2:com.garmin.fit.SubField):Number
        {
            var loc1:*=getValueInternal(arg1, arg2);
            if (!loc1) 
            {
                return NaN;
            }
            return loc1;
        }

        public function getStringValue(arg1:int, arg2:*):String
        {
            var loc2:*=null;
            var loc1:*=0;
            if (arg2 is String) 
            {
                loc2 = arg2 as String;
                return getStringValueInternal(arg1, getSubField(loc2));
            }
            if (arg2 is int) 
            {
                loc1 = arg2 as int;
                return getStringValueInternal(arg1, getSubField(loc1));
            }
            throw new com.garmin.fit.FitRuntimeException("loggingErrorEvent", 1800001, "FITEncoding > Logical Error: Field.getStringValue " + name);
        }

        public function getNum():int
        {
            return num;
        }

        internal function getStringValueInternal(arg1:int, arg2:com.garmin.fit.SubField):String
        {
            var loc1:*=getValueInternal(arg1, arg2);
            if (loc1 == null) 
            {
                return null;
            }
            var loc2:*=type;
            while (0 === loc2) 
            {
                if (loc1 == 255) 
                {
                    return null;
                }
            }
        }

        public function read(arg1:__AS3__.vec.Vector.<int>, arg2:int):Boolean
        {
            var loc2:*=null;
            var loc11:*=null;
            var loc3:*=0;
            var loc7:*=0;
            var loc8:*=false;
            var loc4:*=0;
            var loc10:*=0;
            var loc6:*=NaN;
            var loc5:*=null;
            var loc9:*=null;
            var loc1:*=NaN;
            arg1.fixed = false;
        }

        public function write(arg1:flash.filesystem.FileStream, arg2:com.garmin.fit.FieldDefinition=null):void
        {
            var loc3:*=0;
            var loc2:*=0;
            if (arg2 != null) 
            {
                loc2 = arg2.size - getSize();
                write(arg1);
                while (loc2 > 0) 
                {
                    writeValue(arg1, null);
                    loc2 = loc2 - com.garmin.fit.Fit.baseTypeSizes[type & 31];
                }
            }
            else 
            {
                var loc1:*=values.length;
                loc3 = 0;
                while (loc3 < loc1) 
                {
                    writeValue(arg1, values[loc3]);
                    ++loc3;
                }
            }
            return;
        }

        public function getName(arg1:*=null):String
        {
            var loc2:*=null;
            var loc1:*=0;
            if (arg1 == null) 
            {
                return getNameInternal(null);
            }
            if (arg1 is String) 
            {
                loc2 = arg1 as String;
                return getNameInternal(getSubField(loc2));
            }
            if (arg1 is int) 
            {
                loc1 = arg1 as int;
                return getNameInternal(getSubField(loc1));
            }
            throw new com.garmin.fit.FitRuntimeException("loggingErrorEvent", 1800001, "FITEncoding > Logical Error: Field.getName: " + name);
            return null;
        }

        internal function getNameInternal(arg1:com.garmin.fit.SubField):String
        {
            if (arg1 == null) 
            {
                return name;
            }
            return arg1.name;
        }

        internal function writeValue(arg1:flash.filesystem.FileStream, arg2:Object):void
        {
        }

        public function getType():int
        {
            return getTypeInternal(null);
        }

        public function getTypeBySubFieldIndex(arg1:int):int
        {
            return getTypeInternal(getSubField(arg1));
        }

        public function getTypeBySubFieldName(arg1:String):int
        {
            return getTypeInternal(getSubField(arg1));
        }

        internal function getTypeInternal(arg1:com.garmin.fit.SubField):int
        {
            if (arg1 == null) 
            {
                return type;
            }
            return arg1.type;
        }

        public function getUnits(arg1:*=null):String
        {
            if (arg1 == null) 
            {
                return getUnitsInternal(null);
            }
            if (arg1 is int) 
            {
                return getUnitsInternal(getSubField(arg1));
            }
            if (arg1 is String) 
            {
                return getUnitsInternal(getSubField(arg1));
            }
            throw new com.garmin.fit.FitRuntimeException("loggingErrorEvent", 1800001, "FITEncoding > Logical Error: Field.getUnits: " + name);
            return "";
        }

        internal function getUnitsInternal(arg1:com.garmin.fit.SubField):String
        {
            if (arg1 == null) 
            {
                return units;
            }
            return arg1.units;
        }

        public function getSize():int
        {
            var loc4:*=0;
            var loc2:*=0;
            var loc3:*=null;
            var loc1:*=0;
            var loc7:*=type;
            while (0 === loc7) 
            {
                loc1 = getNumValues() * com.garmin.fit.Fit.baseTypeSizes[type & 31];
            }
        }

        public function getSubField(arg1:*):com.garmin.fit.SubField
        {
            var loc3:*=null;
            var loc1:*=0;
            var loc2:*=0;
            if (arg1 is String) 
            {
                loc3 = arg1 as String;
                loc1 = 0;
                while (loc1 < subFields.length) 
                {
                    if (subFields[loc1].name == loc3) 
                    {
                        return subFields[loc1];
                    }
                    ++loc1;
                }
            }
            else if (arg1 is int) 
            {
                loc2 = arg1 as int;
                if (loc2 >= 0 && loc2 < subFields.length) 
                {
                    return subFields[loc2];
                }
            }
            return null;
        }

        public function isSignedInteger():Boolean
        {
            return isSignedIntegerInternal(null);
        }

        internal function isSignedIntegerInternal(arg1:com.garmin.fit.SubField):Boolean
        {
            var loc1:*=getTypeInternal(arg1);
            while (1 === loc1) 
            {
                return true;
            }
        }

        public function addValue(arg1:*):void
        {
            var loc2:*=null;
            var loc1:*=NaN;
            if (arg1 is Number && type == 7) 
            {
                loc2 = getStringValueInternal(0, null);
                loc1 = arg1;
                if (loc2 == null) 
                {
                    loc2 = "";
                }
                loc2 = loc2 + ("" + (loc1 as int));
                setValueInternal(0, loc2, null);
                return;
            }
            values.push(arg1);
            return;
        }

        public function getNumValues():int
        {
            return values.length;
        }

        public function getValue(arg1:*=null, arg2:*=null):*
        {
            if (arg1 == null && arg2 == null) 
            {
                return getValueInternal(0, null);
            }
            if (arg1 == undefined && arg2 is int) 
            {
                return getValueInternal(arg1, getSubField(arg2 as int));
            }
            if (arg1 == undefined && arg2 is String) 
            {
                return getValueInternal(arg1, getSubField(arg2 as String));
            }
            throw new com.garmin.fit.FitRuntimeException("loggingErrorEvent", 1800001, "FITEncoding > Logical Error: Field.getValue: " + name);
            return null;
        }

        internal function getValueInternal(arg1:int, arg2:com.garmin.fit.SubField):*
        {
            var loc3:*=undefined;
            var loc2:*=NaN;
            var loc1:*=NaN;
            if (arg1 >= values.length) 
            {
                return null;
            }
            if (arg2 != null) 
            {
                loc2 = arg2.scale;
                loc1 = arg2.offset;
            }
            else 
            {
                loc2 = this.scale;
                loc1 = this.offset;
            }
        }

        public function setValue(arg1:*, arg2:Object=null, arg3:*=null):void
        {
            var loc1:*=0;
            var loc2:*=null;
            if (arg2 == null && arg3 == null) 
            {
                setValueInternal(0, arg2, null);
            }
            else if (arg3 is int) 
            {
                loc1 = arg3 as int;
                setValueInternal(arg1, arg2, getSubField(loc1));
            }
            else if (arg3 is String) 
            {
                loc2 = arg3 as String;
                setValueInternal(arg1, arg2, getSubField(loc2));
            }
            else 
            {
                throw new com.garmin.fit.FitRuntimeException("loggingErrorEvent", 1800001, "FITEncoding > Logical Error: Field.setValue: " + name);
            }
            return;
        }

        internal function setValueInternal(arg1:int, arg2:*, arg3:com.garmin.fit.SubField):void
        {
            var loc3:*=NaN;
            var loc1:*=NaN;
            var loc2:*=NaN;
            while (arg1 >= getNumValues()) 
            {
                addValue({});
            }
            if (arg3 != null) 
            {
                loc3 = arg3.scale;
                loc1 = arg3.offset;
            }
            else 
            {
                loc3 = this.scale;
                loc1 = this.offset;
            }
        }

        public function getBitsValue(arg1:int, arg2:int, arg3:Boolean):Number
        {
            var loc1:*=0;
            var loc2:*=NaN;
            var loc7:*=NaN;
            var loc3:*=NaN;
            var loc6:*=0;
            var loc5:*=0;
            var loc4:*=0;
            while (loc5 < arg2) 
            {
                ++loc4;
                loc2 = getLongValueInternal(loc4, null);
                if (isNaN(loc2)) 
                {
                    return NaN;
                }
                loc2 = loc2 >> arg1;
                loc1 = com.garmin.fit.Fit.baseTypeSizes[type & 31] * 8 - arg1;
                arg1 = arg1 - com.garmin.fit.Fit.baseTypeSizes[type & 31] * 8;
                if (!(loc1 > 0)) 
                {
                    continue;
                }
                arg1 = 0;
                if (loc1 > arg2 - loc5) 
                {
                    loc1 = arg2 - loc5;
                }
                loc7 = ((1 as Number) << loc1 - 1);
                loc6 = loc6 | (loc2 & loc7) << loc5;
                loc5 = loc5 + loc1;
            }
            if (arg3) 
            {
                loc3 = (1 as Number) << (arg2 - 1);
                if ((loc6 & loc3) != 0) 
                {
                    loc6 = -loc3 + (loc6 & (loc3 - 1));
                }
            }
            return loc6;
        }

        public function getByteValue():int
        {
            return getByteValueInternal(0, null);
        }

        public function getByteValueByFieldArrayIndex(arg1:int):int
        {
            return getByteValueInternal(arg1, null);
        }

        public function getByteValueByFieldArrayIndexAndSubFieldIndex(arg1:int, arg2:int):int
        {
            return getByteValueInternal(arg1, getSubField(arg2));
        }

        public function getByteValueByFieldArrayIndexAndSubFieldName(arg1:int, arg2:String):int
        {
            return getByteValueInternal(arg1, getSubField(arg2));
        }

        internal function getByteValueInternal(arg1:int, arg2:com.garmin.fit.SubField):int
        {
            var loc1:*=getValueInternal(arg1, arg2);
            if (loc1 == null) 
            {
                return 0;
            }
            return loc1 as int;
        }

        public function getShortValue(arg1:int=0, arg2:*=null):int
        {
            return getShortValueInternal(arg1, getSubField(arg2));
        }

        internal function getShortValueInternal(arg1:int, arg2:com.garmin.fit.SubField):int
        {
            var loc1:*=getValueInternal(arg1, arg2);
            if (loc1 == null) 
            {
                return 0;
            }
            return loc1 as int;
        }

        public function getIntegerValue(arg1:int, arg2:*):int
        {
            var loc2:*=null;
            var loc1:*=0;
            if (arg2 is String) 
            {
                loc2 = arg2 as String;
                return getIntegerValueInternal(arg1, getSubField(loc2));
            }
            if (arg2 is int) 
            {
                loc1 = arg2 as int;
                return getIntegerValueInternal(arg1, getSubField(loc1));
            }
            throw new com.garmin.fit.FitRuntimeException("loggingErrorEvent", 1800001, "FITEncoding > Logical Error: Field.getIntegerValue: " + name);
        }

        internal function getIntegerValueInternal(arg1:int, arg2:com.garmin.fit.SubField):int
        {
            var loc1:*=getValueInternal(arg1, arg2);
            if (loc1 == null) 
            {
                return 0;
            }
            return loc1 as int;
        }

        public function getLongValue(arg1:int, arg2:int):Number
        {
            return getLongValueInternal(arg1, getSubField(arg2));
        }

        internal function getLongValueInternal(arg1:int, arg2:com.garmin.fit.SubField):Number
        {
            var loc1:*=getValueInternal(arg1, arg2);
            if (loc1 == null) 
            {
                return NaN;
            }
            return loc1 as Number;
        }

        public var name:String;

        public var num:int;

        public var type:int;

        public var scale:Number;

        public var offset:Number;

        public var values:__AS3__.vec.Vector.<Object>;

        public var components:__AS3__.vec.Vector.<com.garmin.fit.FieldComponent>;

        public var subFields:__AS3__.vec.Vector.<com.garmin.fit.SubField>;

        protected var units:String;
    }
}


//    class FieldCapabilitiesMesg
package com.garmin.fit 
{
    public class FieldCapabilitiesMesg extends com.garmin.fit.Mesg
    {
        public function FieldCapabilitiesMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(39));
            return;
        }

        public function getMessageIndex():int
        {
            return getFieldIntegerValue(254, 0, 65535);
        }

        public function setMessageIndex(arg1:int):void
        {
            setFieldValue(254, 0, arg1, 65535);
            return;
        }

        public function getFile():com.garmin.fit.FITFile
        {
            var loc1:*=getFieldIntegerValue(0, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.FITFile.getByValue(loc1);
        }

        public function setFile(arg1:com.garmin.fit.FITFile):void
        {
            setFieldValue(0, 0, arg1.getValue(), 65535);
            return;
        }

        public function getMesgNum():int
        {
            return getFieldIntegerValue(1, 0, 65535);
        }

        public function setMesgNum(arg1:int):void
        {
            setFieldValue(1, 0, arg1, 65535);
            return;
        }

        public function getFieldNum():int
        {
            return getFieldIntegerValue(2, 0, 65535);
        }

        public function setFieldNum(arg1:int):void
        {
            setFieldValue(2, 0, arg1, 65535);
            return;
        }

        public function getCount():int
        {
            return getFieldIntegerValue(3, 0, 65535);
        }

        public function setCount(arg1:int):void
        {
            setFieldValue(3, 0, arg1, 65535);
            return;
        }

        public static function get fieldCapabilitiesMesg():com.garmin.fit.Mesg
        {
            return _fieldCapabilitiesMesg;
        }

        
        {
            _fieldCapabilitiesMesg = new com.garmin.fit.Mesg("field_capabilities", 39);
            fieldCapabilitiesMesg.addField(new com.garmin.fit.Field("message_index", 254, 132, 1, 0, ""));
            fieldCapabilitiesMesg.addField(new com.garmin.fit.Field("file", 0, 0, 1, 0, ""));
            fieldCapabilitiesMesg.addField(new com.garmin.fit.Field("mesg_num", 1, 132, 1, 0, ""));
            fieldCapabilitiesMesg.addField(new com.garmin.fit.Field("field_num", 2, 2, 1, 0, ""));
            fieldCapabilitiesMesg.addField(new com.garmin.fit.Field("count", 3, 132, 1, 0, ""));
        }

        internal static var _fieldCapabilitiesMesg:com.garmin.fit.Mesg;
    }
}


//    class FieldComponent
package com.garmin.fit 
{
    public class FieldComponent extends Object
    {
        public function FieldComponent(arg1:int, arg2:Boolean, arg3:int, arg4:Number, arg5:Number)
        {
            super();
            this.fieldNum = arg1;
            this.accumulate = arg2;
            this.bits = arg3;
            this.scale = arg4;
            this.offset = arg5;
            return;
        }

        public var fieldNum:int;

        public var accumulate:Boolean;

        public var bits:int;

        public var scale:Number;

        public var offset:Number;
    }
}


//    class FieldDefinition
package com.garmin.fit 
{
    import flash.filesystem.*;
    
    public class FieldDefinition extends Object
    {
        public function FieldDefinition(arg1:com.garmin.fit.Field=null, arg2:int=255)
        {
            super();
            if (arg1 == null) 
            {
                _num = arg2;
                _size = 0;
            }
            else 
            {
                _num = arg1.num;
                _size = arg1.getSize();
                _type = arg1.type;
            }
            return;
        }

        public function set num(arg1:int):void
        {
            _num = arg1;
            return;
        }

        public function get num():int
        {
            return _num;
        }

        public function set size(arg1:int):void
        {
            _size = arg1;
            return;
        }

        public function get size():int
        {
            return _size;
        }

        public function set type(arg1:int):void
        {
            _type = arg1;
            return;
        }

        public function get type():int
        {
            return _type;
        }

        public function write(arg1:flash.filesystem.FileStream):void
        {
            arg1.writeByte(num);
            arg1.writeByte(size);
            arg1.writeByte(type);
            return;
        }

        public function getNum():int
        {
            return num;
        }

        public function setSize(arg1:int):void
        {
            _size = arg1;
            return;
        }

        public function getSize():int
        {
            return size;
        }

        public function getType():int
        {
            return type;
        }

        public function equals(arg1:*):Boolean
        {
            if (this == arg1) 
            {
                return true;
            }
            if (!(arg1 is com.garmin.fit.FieldDefinition)) 
            {
                return false;
            }
            var loc1:*=com.garmin.fit.FieldDefinition(arg1);
            if (num != loc1.num) 
            {
                return false;
            }
            if (size != loc1.size) 
            {
                return false;
            }
            if (type != loc1.type) 
            {
                return false;
            }
            return true;
        }

        public function hashCode():int
        {
            var loc1:*=1;
            loc1 = loc1 * 47 + this.num;
            loc1 = loc1 * 31 + this.size;
            loc1 = loc1 * 19 + this.type;
            return loc1;
        }

        internal var _num:int;

        internal var _size:int;

        internal var _type:int;
    }
}


//    class FileCapabilitiesMesg
package com.garmin.fit 
{
    public class FileCapabilitiesMesg extends com.garmin.fit.Mesg
    {
        public function FileCapabilitiesMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(37));
            return;
        }

        public function getMessageIndex():int
        {
            return getFieldIntegerValue(254, 0, 65535);
        }

        public function setMessageIndex(arg1:int):void
        {
            setFieldValue(254, 0, arg1, 65535);
            return;
        }

        public function getType():com.garmin.fit.FITFile
        {
            var loc1:*=getFieldIntegerValue(0, 0, 65535);
            if (!loc1) 
            {
                return null;
            }
            return com.garmin.fit.FITFile.getByValue(loc1);
        }

        public function setType(arg1:com.garmin.fit.FITFile):void
        {
            setFieldValue(0, 0, arg1.getValue(), 65535);
            return;
        }

        public function getFlags():int
        {
            return getFieldIntegerValue(1, 0, 65535);
        }

        public function setFlags(arg1:int):void
        {
            setFieldValue(1, 0, arg1, 65535);
            return;
        }

        public function getDirectory():String
        {
            return getFieldStringValue(2, 0, 65535);
        }

        public function setDirectory(arg1:String):void
        {
            setFieldValue(2, 0, arg1, 65535);
            return;
        }

        public function getMaxCount():int
        {
            return getFieldIntegerValue(3, 0, 65535);
        }

        public function setMaxCount(arg1:int):void
        {
            setFieldValue(3, 0, arg1, 65535);
            return;
        }

        public function getMaxSize():Number
        {
            return getFieldDoubleValue(4, 0, 65535);
        }

        public function setMaxSize(arg1:Number):void
        {
            setFieldValue(4, 0, arg1, 65535);
            return;
        }

        public static function get fileCapabilitiesMesg():com.garmin.fit.Mesg
        {
            return _fileCapabilitiesMesg;
        }

        
        {
            _fileCapabilitiesMesg = new com.garmin.fit.Mesg("file_capabilities", 37);
            fileCapabilitiesMesg.addField(new com.garmin.fit.Field("message_index", 254, 132, 1, 0, ""));
            fileCapabilitiesMesg.addField(new com.garmin.fit.Field("type", 0, 0, 1, 0, ""));
            fileCapabilitiesMesg.addField(new com.garmin.fit.Field("flags", 1, 10, 1, 0, ""));
            fileCapabilitiesMesg.addField(new com.garmin.fit.Field("directory", 2, 7, 1, 0, ""));
            fileCapabilitiesMesg.addField(new com.garmin.fit.Field("max_count", 3, 132, 1, 0, ""));
            fileCapabilitiesMesg.addField(new com.garmin.fit.Field("max_size", 4, 134, 1, 0, "bytes"));
        }

        internal static var _fileCapabilitiesMesg:com.garmin.fit.Mesg;
    }
}


//    class FileCreatorMesg
package com.garmin.fit 
{
    public class FileCreatorMesg extends com.garmin.fit.Mesg
    {
        public function FileCreatorMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(49));
            return;
        }

        public function getSoftwareVersion():int
        {
            return getFieldIntegerValue(0, 0, 65535);
        }

        public function setSoftwareVersion(arg1:int):void
        {
            setFieldValue(0, 0, arg1, 65535);
            return;
        }

        public function getHardwareVersion():int
        {
            return getFieldIntegerValue(1, 0, 65535);
        }

        public function setHardwareVersion(arg1:int):void
        {
            setFieldValue(1, 0, arg1, 65535);
            return;
        }

        public static function get fileCreatorMesg():com.garmin.fit.Mesg
        {
            return _fileCreatorMesg;
        }

        
        {
            _fileCreatorMesg = new com.garmin.fit.Mesg("file_creator", 49);
            fileCreatorMesg.addField(new com.garmin.fit.Field("software_version", 0, 132, 1, 0, ""));
            fileCreatorMesg.addField(new com.garmin.fit.Field("hardware_version", 1, 2, 1, 0, ""));
        }

        internal static var _fileCreatorMesg:com.garmin.fit.Mesg;
    }
}


//    class FileIdMesg
package com.garmin.fit 
{
    public class FileIdMesg extends com.garmin.fit.Mesg
    {
        public function FileIdMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(0));
            return;
        }

        public function getType():com.garmin.fit.FITFile
        {
            var loc1:*=getFieldIntegerValue(0, 0, 65535);
            if (!loc1) 
            {
                return null;
            }
            return com.garmin.fit.FITFile.getByValue(loc1);
        }

        public function setType(arg1:com.garmin.fit.FITFile):void
        {
            setFieldValue(0, 0, arg1.getValue(), 65535);
            return;
        }

        public function getManufacturer():int
        {
            return getFieldIntegerValue(1, 0, 65535);
        }

        public function setManufacturer(arg1:int):void
        {
            setFieldValue(1, 0, arg1, 65535);
            return;
        }

        public function getProduct():int
        {
            return getFieldIntegerValue(2, 0, 65535);
        }

        public function setProduct(arg1:int):void
        {
            setFieldValue(2, 0, arg1, 65535);
            return;
        }

        public function getGarminProduct():int
        {
            return getFieldIntegerValue(2, 0, 0);
        }

        public function setGarminProduct(arg1:int):void
        {
            setFieldValue(2, 0, arg1, 0);
            return;
        }

        public function getSerialNumber():Number
        {
            return getFieldDoubleValue(3, 0, 65535);
        }

        public function setSerialNumber(arg1:Number):void
        {
            setFieldValue(3, 0, arg1, 65535);
            return;
        }

        public function getTimeCreated():com.garmin.fit.DateTime
        {
            return timestampToDateTime(getFieldDoubleValue(4, 0, 65535));
        }

        public function setTimeCreated(arg1:com.garmin.fit.DateTime):void
        {
            setFieldValue(4, 0, arg1.getTimestamp(), 65535);
            return;
        }

        public function getNumber():int
        {
            return getFieldIntegerValue(5, 0, 65535);
        }

        public function setNumber(arg1:int):void
        {
            setFieldValue(5, 0, arg1, 65535);
            return;
        }

        public function getProductName():String
        {
            return getFieldStringValue(8, 0, 65535);
        }

        public function setProductName(arg1:String):void
        {
            setFieldValue(8, 0, arg1, 65535);
            return;
        }

        public static function get fileIdMesg():com.garmin.fit.Mesg
        {
            return _fileIdMesg;
        }

        
        {
            _fileIdMesg = new com.garmin.fit.Mesg("file_id", 0);
            fileIdMesg.addField(new com.garmin.fit.Field("type", 0, 0, 1, 0, ""));
            ++field_index;
            fileIdMesg.addField(new com.garmin.fit.Field("manufacturer", 1, 132, 1, 0, ""));
            ++field_index;
            fileIdMesg.addField(new com.garmin.fit.Field("product", 2, 132, 1, 0, ""));
            subfield_index = 0;
            fileIdMesg.fields[field_index].subFields.push(new com.garmin.fit.SubField("garmin_product", 132, 1, 0, ""));
            fileIdMesg.fields[field_index].subFields[subfield_index].addMap(1, 1);
            fileIdMesg.fields[field_index].subFields[subfield_index].addMap(1, 15);
            fileIdMesg.fields[field_index].subFields[subfield_index].addMap(1, 13);
            ++subfield_index;
            ++field_index;
            fileIdMesg.addField(new com.garmin.fit.Field("serial_number", 3, 140, 1, 0, ""));
            ++field_index;
            fileIdMesg.addField(new com.garmin.fit.Field("time_created", 4, 134, 1, 0, ""));
            ++field_index;
            fileIdMesg.addField(new com.garmin.fit.Field("number", 5, 132, 1, 0, ""));
            ++field_index;
            fileIdMesg.addField(new com.garmin.fit.Field("product_name", 8, 7, 1, 0, ""));
            ++field_index;
        }

        internal static var _fileIdMesg:com.garmin.fit.Mesg;

        internal static var field_index:int=0;

        internal static var subfield_index:int=0;
    }
}


//    class Fit
package com.garmin.fit 
{
    import __AS3__.vec.*;
    
    public class Fit extends Object
    {
        public function Fit()
        {
            super();
            return;
        }

        
        {
            new __AS3__.vec.Vector.<uint>(14)[0] = 1;
            new __AS3__.vec.Vector.<uint>(14)[1] = 1;
            new __AS3__.vec.Vector.<uint>(14)[2] = 1;
            new __AS3__.vec.Vector.<uint>(14)[3] = 2;
            new __AS3__.vec.Vector.<uint>(14)[4] = 2;
            new __AS3__.vec.Vector.<uint>(14)[5] = 4;
            new __AS3__.vec.Vector.<uint>(14)[6] = 4;
            new __AS3__.vec.Vector.<uint>(14)[7] = 1;
            new __AS3__.vec.Vector.<uint>(14)[8] = 2;
            new __AS3__.vec.Vector.<uint>(14)[9] = 4;
            new __AS3__.vec.Vector.<uint>(14)[10] = 1;
            new __AS3__.vec.Vector.<uint>(14)[11] = 2;
            new __AS3__.vec.Vector.<uint>(14)[12] = 4;
            new __AS3__.vec.Vector.<uint>(14)[13] = 1;
        }

        public static const PROTOCOL_VERSION_MAJOR:int=1;

        public static const PROTOCOL_VERSION_MINOR:int=0;

        public static const PROTOCOL_VERSION_MAJOR_SHIFT:int=4;

        public static const PROTOCOL_VERSION_MAJOR_MASK:int=240;

        public static const PROTOCOL_VERSION_MINOR_MASK:int=15;

        public static const PROTOCOL_VERSION:int=16;

        public static const PROFILE_VERSION_MAJOR:int=6;

        public static const PROFILE_VERSION_MINOR:int=10;

        public static const PROFILE_VERSION_SCALE:int=100;

        public static const PROFILE_VERSION:int=610;

        public static const ANTFS_FILE_DATA_TYPE:int=128;

        public static const FILE_HDR_SIZE:int=14;

        public static const HDR_SIZE:int=1;

        public static const HDR_TIME_REC_BIT:int=128;

        public static const HDR_TIME_TYPE_MASK:int=96;

        public static const HDR_TIME_TYPE_SHIFT:int=5;

        public static const HDR_TIME_OFFSET_MASK:int=31;

        public static const HDR_TYPE_DEF_BIT:int=64;

        public static const HDR_TYPE_MASK:int=15;

        public static const MAX_LOCAL_MESGS:int=16;

        public static const MAX_MESG_SIZE:int=255;

        public static const ARCH_ENDIAN_MASK:int=1;

        public static const ARCH_ENDIAN_LITTLE:int=0;

        public static const ARCH_ENDIAN_BIG:int=1;

        public static const MAX_FIELD_SIZE:int=255;

        public static const FIELD_NUM_INVALID:int=255;

        public static const FIELD_NUM_MESSAGE_INDEX:int=254;

        public static const FIELD_NUM_TIMESTAMP:int=253;

        public static const SUBFIELD_INDEX_ACTIVE_SUBFIELD:int=65534;

        public static const SUBFIELD_INDEX_MAIN_FIELD:int=65535;

        public static const SUBFIELD_NAME_MAIN_FIELD:String=new String();

        public static const BASE_TYPE_ENDIAN_FLAG:int=128;

        public static const BASE_TYPE_RESERVED:int=96;

        public static const BASE_TYPE_NUM_MASK:int=31;

        public static const ENUM_INVALID:int=255;

        public static const BASE_TYPE_ENUM:int=0;

        public static const SINT8_INVALID:int=127;

        public static const BASE_TYPE_SINT8:int=1;

        public static const UINT8_INVALID:int=255;

        public static const BASE_TYPE_UINT8:int=2;

        public static const SINT16_INVALID:int=32767;

        public static const BASE_TYPE_SINT16:int=131;

        public static const UINT16_INVALID:int=65535;

        public static const BASE_TYPE_UINT16:int=132;

        public static const SINT32_INVALID:int=2147483647;

        public static const BASE_TYPE_SINT32:int=133;

        public static const UINT32_INVALID:Number=4294967295;

        public static const BASE_TYPE_UINT32:int=134;

        public static const BASE_TYPE_STRING:int=7;

        public static const FLOAT32_INVALID:Number=4294967295;

        public static const BASE_TYPE_FLOAT32:int=136;

        public static const FLOAT64_INVALID:Number=1.84467440737e+019;

        public static const BASE_TYPE_FLOAT64:int=137;

        public static const UINT8Z_INVALID:int=0;

        public static const BASE_TYPE_UINT8Z:int=10;

        public static const STRING_INVALID:String=new String();

        public static const BASE_TYPE_UINT16Z:int=139;

        public static const UINT32Z_INVALID:Number=0;

        public static const BASE_TYPE_UINT32Z:int=140;

        public static const BYTE_INVALID:int=255;

        public static const BASE_TYPE_BYTE:int=13;

        public static const BASE_TYPES:int=14;

        public static const baseTypeSizes:__AS3__.vec.Vector.<uint>=new __AS3__.vec.Vector.<uint>(14);

        public static const UINT16Z_INVALID:int=0;

        public static var debug:Boolean=false;
    }
}


//    class FitRuntimeException
package com.garmin.fit 
{
    public class FitRuntimeException extends Object
    {
        public function FitRuntimeException(arg1:String="", arg2:*=null, arg3:String="", arg4:Object=null, arg5:Boolean=false, arg6:Boolean=false)
        {
            var loc2:*=null;
            var loc1:*=null;
            super();
            if (arg2 is Error) 
            {
                loc2 = arg1 != "" ? arg1 + "\t" : "";
                loc1 = arg2 != null ? arg2.message : "";
                _event = "loggingErrorEvent";
                _code = 1800001;
                _description = "FITEncoding > Logical Error:  " + loc2 + " " + loc1;
            }
            else if (arg2 is int) 
            {
                _event = arg1;
                _code = arg2;
                _description = arg3;
            }
            else if (arg2 == null && !(arg1 == "")) 
            {
                _event = "loggingErrorEvent";
                _code = 1800000;
                _description = "FitEncoding:  " + arg1;
            }
            return;
        }

        public function get code():int
        {
            return _code;
        }

        public function get event():String
        {
            return _event;
        }

        public function get message():String
        {
            return _description;
        }

        internal static const serialVersionUID:Number=9.70213851172e+017;

        internal var _event:String;

        internal var _code:int;

        internal var _description:String;
    }
}


//    class FitnessEquipmentState
package com.garmin.fit 
{
    import __AS3__.vec.*;
    import avmplus.*;
    import com.garmin.fit.custom.*;
    import flash.errors.*;
    
    public class FitnessEquipmentState extends com.garmin.fit.custom.BaseType
    {
        public function FitnessEquipmentState(arg1:Object, arg2:uint)
        {
            super();
            if (arg1 != SINGLETON_ENFORCER) 
            {
                throw new flash.errors.IllegalOperationError("IllegalOperation: Manipulation of type " + avmplus.getQualifiedClassName(this));
            }
            this.value = arg2;
            return;
        }

        public function getAllValues():__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>
        {
            return VALUES;
        }

        public function getInvalid():com.garmin.fit.custom.BaseType
        {
            return INVALID;
        }

        public function getValue():uint
        {
            return value;
        }

        public static function getByValue(arg1:uint):com.garmin.fit.FitnessEquipmentState
        {
            return com.garmin.fit.custom.BaseType.getByValue(arg1) as FitnessEquipmentState;
        }

        
        {
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(5)[0] = READY;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(5)[1] = IN_USE;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(5)[2] = PAUSED;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(5)[3] = UNKNOWN;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(5)[4] = INVALID;
        }

        internal static const SINGLETON_ENFORCER:Object={};

        public static const READY:com.garmin.fit.FitnessEquipmentState=new FitnessEquipmentState(SINGLETON_ENFORCER, 0);

        public static const IN_USE:com.garmin.fit.FitnessEquipmentState=new FitnessEquipmentState(SINGLETON_ENFORCER, 1);

        public static const PAUSED:com.garmin.fit.FitnessEquipmentState=new FitnessEquipmentState(SINGLETON_ENFORCER, 2);

        public static const UNKNOWN:com.garmin.fit.FitnessEquipmentState=new FitnessEquipmentState(SINGLETON_ENFORCER, 3);

        public static const INVALID:com.garmin.fit.FitnessEquipmentState=new FitnessEquipmentState(SINGLETON_ENFORCER, 255);

        internal static const VALUES:__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>=new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(5);
    }
}


//    class Gender
package com.garmin.fit 
{
    import __AS3__.vec.*;
    import avmplus.*;
    import flash.errors.*;
    
    public class Gender extends Object
    {
        public function Gender(arg1:Object, arg2:uint)
        {
            super();
            if (arg1 != SINGLETON_ENFORCER) 
            {
                throw new flash.errors.IllegalOperationError("IllegalOperation: Manipulation of type " + avmplus.getQualifiedClassName(this));
            }
            this.value = arg2;
            return;
        }

        public function getValue():uint
        {
            return value;
        }

        public static function getByValue(arg1:uint):com.garmin.fit.Gender
        {
            var loc3:*=0;
            var loc2:*=Gender.VALUES;
            for each (var loc1:* in loc2) 
            {
                if (!(arg1 == loc1.value)) 
                {
                    continue;
                }
                return loc1;
            }
            return Gender.INVALID;
        }

        
        {
            new __AS3__.vec.Vector.<>(3)[0] = FEMALE;
            new __AS3__.vec.Vector.<>(3)[1] = MALE;
            new __AS3__.vec.Vector.<>(3)[2] = INVALID;
        }

        internal static const SINGLETON_ENFORCER:Object={};

        public static const FEMALE:com.garmin.fit.Gender=new Gender(SINGLETON_ENFORCER, 0);

        public static const MALE:com.garmin.fit.Gender=new Gender(SINGLETON_ENFORCER, 1);

        public static const INVALID:com.garmin.fit.Gender=new Gender(SINGLETON_ENFORCER, 255);

        public static const VALUES:__AS3__.vec.Vector.<com.garmin.fit.Gender>=new __AS3__.vec.Vector.<>(3);

        internal var value:uint;
    }
}


//    class Goal
package com.garmin.fit 
{
    import __AS3__.vec.*;
    import avmplus.*;
    import com.garmin.fit.custom.*;
    import flash.errors.*;
    
    public class Goal extends com.garmin.fit.custom.BaseType
    {
        public function Goal(arg1:Object, arg2:uint)
        {
            super();
            if (arg1 != SINGLETON_ENFORCER) 
            {
                throw new flash.errors.IllegalOperationError("IllegalOperation: Manipulation of type " + avmplus.getQualifiedClassName(this));
            }
            this.value = arg2;
            return;
        }

        public function getAllValues():__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>
        {
            return VALUES;
        }

        public function getInvalid():com.garmin.fit.custom.BaseType
        {
            return INVALID;
        }

        public function getValue():uint
        {
            return value;
        }

        public static function getByValue(arg1:uint):com.garmin.fit.Goal
        {
            return com.garmin.fit.custom.BaseType.getByValue(arg1) as Goal;
        }

        
        {
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(6)[0] = TIME;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(6)[1] = DISTANCE;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(6)[2] = CALORIES;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(6)[3] = FREQUENCY;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(6)[4] = STEPS;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(6)[5] = INVALID;
        }

        internal static const SINGLETON_ENFORCER:Object={};

        public static const TIME:com.garmin.fit.Goal=new Goal(SINGLETON_ENFORCER, 0);

        public static const DISTANCE:com.garmin.fit.Goal=new Goal(SINGLETON_ENFORCER, 1);

        public static const CALORIES:com.garmin.fit.Goal=new Goal(SINGLETON_ENFORCER, 2);

        public static const FREQUENCY:com.garmin.fit.Goal=new Goal(SINGLETON_ENFORCER, 3);

        public static const STEPS:com.garmin.fit.Goal=new Goal(SINGLETON_ENFORCER, 4);

        public static const INVALID:com.garmin.fit.Goal=new Goal(SINGLETON_ENFORCER, 255);

        public static const VALUES:__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>=new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(6);
    }
}


//    class GoalMesg
package com.garmin.fit 
{
    public class GoalMesg extends com.garmin.fit.Mesg
    {
        public function GoalMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(15));
            return;
        }

        public function getMessageIndex():int
        {
            return getFieldIntegerValue(254, 0, 65535);
        }

        public function setMessageIndex(arg1:int):void
        {
            setFieldValue(254, 0, arg1, 65535);
            return;
        }

        public function getSport():com.garmin.fit.Sport
        {
            var loc1:*=getFieldIntegerValue(0, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.Sport.getByValue(loc1);
        }

        public function setSport(arg1:com.garmin.fit.Sport):void
        {
            setFieldValue(0, 0, arg1.getValue(), 65535);
            return;
        }

        public function getSubSport():com.garmin.fit.SubSport
        {
            var loc1:*=getFieldIntegerValue(1, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.SubSport.getByValue(loc1);
        }

        public function setSubSport(arg1:com.garmin.fit.SubSport):void
        {
            setFieldValue(1, 0, arg1.getValue(), 65535);
            return;
        }

        public function getStartDate():com.garmin.fit.DateTime
        {
            return timestampToDateTime(getFieldDoubleValue(2, 0, 65535));
        }

        public function setStartDate(arg1:com.garmin.fit.DateTime):void
        {
            setFieldValue(2, 0, arg1.getTimestamp(), 65535);
            return;
        }

        public function getEndDate():com.garmin.fit.DateTime
        {
            return timestampToDateTime(getFieldDoubleValue(3, 0, 65535));
        }

        public function setEndDate(arg1:com.garmin.fit.DateTime):void
        {
            setFieldValue(3, 0, arg1.getTimestamp(), 65535);
            return;
        }

        public function getType():com.garmin.fit.Goal
        {
            var loc1:*=getFieldIntegerValue(4, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.Goal.getByValue(loc1);
        }

        public function setType(arg1:com.garmin.fit.Goal):void
        {
            setFieldValue(4, 0, arg1.getValue(), 65535);
            return;
        }

        public function getValue():Number
        {
            return getFieldDoubleValue(5, 0, 65535);
        }

        public function setValue(arg1:Number):void
        {
            setFieldValue(5, 0, arg1, 65535);
            return;
        }

        public function getRepeat():com.garmin.fit.FITBool
        {
            var loc1:*=getFieldIntegerValue(6, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.FITBool.getByValue(loc1);
        }

        public function setRepeat(arg1:com.garmin.fit.FITBool):void
        {
            setFieldValue(6, 0, arg1.getValue(), 65535);
            return;
        }

        public function getTargetValue():Number
        {
            return getFieldDoubleValue(7, 0, 65535);
        }

        public function setTargetValue(arg1:Number):void
        {
            setFieldValue(7, 0, arg1, 65535);
            return;
        }

        public function getRecurrence():com.garmin.fit.GoalRecurrence
        {
            var loc1:*=getFieldIntegerValue(8, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.GoalRecurrence.getByValue(loc1);
        }

        public function setRecurrence(arg1:com.garmin.fit.GoalRecurrence):void
        {
            setFieldValue(8, 0, arg1.getValue(), 65535);
            return;
        }

        public function getRecurrenceValue():int
        {
            return getFieldIntegerValue(9, 0, 65535);
        }

        public function setRecurrenceValue(arg1:int):void
        {
            setFieldValue(9, 0, arg1, 65535);
            return;
        }

        public function getEnabled():com.garmin.fit.FITBool
        {
            var loc1:*=getFieldIntegerValue(10, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.FITBool.getByValue(loc1);
        }

        public function setEnabled(arg1:com.garmin.fit.FITBool):void
        {
            setFieldValue(10, 0, arg1.getValue(), 65535);
            return;
        }

        public static function get goalMesg():com.garmin.fit.Mesg
        {
            return _goalMesg;
        }

        
        {
            _goalMesg = new com.garmin.fit.Mesg("goal", 15);
            goalMesg.addField(new com.garmin.fit.Field("message_index", 254, 132, 1, 0, ""));
            goalMesg.addField(new com.garmin.fit.Field("sport", 0, 0, 1, 0, ""));
            goalMesg.addField(new com.garmin.fit.Field("sub_sport", 1, 0, 1, 0, ""));
            goalMesg.addField(new com.garmin.fit.Field("start_date", 2, 134, 1, 0, ""));
            goalMesg.addField(new com.garmin.fit.Field("end_date", 3, 134, 1, 0, ""));
            goalMesg.addField(new com.garmin.fit.Field("type", 4, 0, 1, 0, ""));
            goalMesg.addField(new com.garmin.fit.Field("value", 5, 134, 1, 0, ""));
            goalMesg.addField(new com.garmin.fit.Field("repeat", 6, 0, 1, 0, ""));
            goalMesg.addField(new com.garmin.fit.Field("target_value", 7, 134, 1, 0, ""));
            goalMesg.addField(new com.garmin.fit.Field("recurrence", 8, 0, 1, 0, ""));
            goalMesg.addField(new com.garmin.fit.Field("recurrence_value", 9, 132, 1, 0, ""));
            goalMesg.addField(new com.garmin.fit.Field("enabled", 10, 0, 1, 0, ""));
        }

        internal static var _goalMesg:com.garmin.fit.Mesg;
    }
}


//    class GoalRecurrence
package com.garmin.fit 
{
    import __AS3__.vec.*;
    import avmplus.*;
    import com.garmin.fit.custom.*;
    import flash.errors.*;
    
    public class GoalRecurrence extends com.garmin.fit.custom.BaseType
    {
        public function GoalRecurrence(arg1:Object, arg2:uint)
        {
            super();
            if (arg1 != SINGLETON_ENFORCER) 
            {
                throw new flash.errors.IllegalOperationError("IllegalOperation: Manipulation of type " + avmplus.getQualifiedClassName(this));
            }
            this.value = arg2;
            return;
        }

        public function getAllValues():__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>
        {
            return VALUES;
        }

        public function getInvalid():com.garmin.fit.custom.BaseType
        {
            return INVALID;
        }

        public function getValue():uint
        {
            return value;
        }

        public static function getByValue(arg1:uint):com.garmin.fit.GoalRecurrence
        {
            return com.garmin.fit.custom.BaseType.getByValue(arg1) as GoalRecurrence;
        }

        
        {
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(7)[0] = OFF;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(7)[1] = DAILY;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(7)[2] = WEEKLY;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(7)[3] = MONTHLY;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(7)[4] = YEARLY;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(7)[5] = CUSTOM;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(7)[6] = INVALID;
        }

        internal static const SINGLETON_ENFORCER:Object={};

        public static const OFF:com.garmin.fit.GoalRecurrence=new GoalRecurrence(SINGLETON_ENFORCER, 0);

        public static const DAILY:com.garmin.fit.GoalRecurrence=new GoalRecurrence(SINGLETON_ENFORCER, 1);

        public static const WEEKLY:com.garmin.fit.GoalRecurrence=new GoalRecurrence(SINGLETON_ENFORCER, 2);

        public static const MONTHLY:com.garmin.fit.GoalRecurrence=new GoalRecurrence(SINGLETON_ENFORCER, 3);

        public static const YEARLY:com.garmin.fit.GoalRecurrence=new GoalRecurrence(SINGLETON_ENFORCER, 4);

        public static const CUSTOM:com.garmin.fit.GoalRecurrence=new GoalRecurrence(SINGLETON_ENFORCER, 5);

        public static const INVALID:com.garmin.fit.GoalRecurrence=new GoalRecurrence(SINGLETON_ENFORCER, 255);

        public static const VALUES:__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>=new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(7);
    }
}


//    class HrType
package com.garmin.fit 
{
    import __AS3__.vec.*;
    import avmplus.*;
    import com.garmin.fit.custom.*;
    import flash.errors.*;
    
    public class HrType extends com.garmin.fit.custom.BaseType
    {
        public function HrType(arg1:Object, arg2:uint)
        {
            super();
            if (arg1 != SINGLETON_ENFORCER) 
            {
                throw new flash.errors.IllegalOperationError("IllegalOperation: Manipulation of type " + avmplus.getQualifiedClassName(this));
            }
            this.value = arg2;
            return;
        }

        public function getAllValues():__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>
        {
            return VALUES;
        }

        public function getInvalid():com.garmin.fit.custom.BaseType
        {
            return INVALID;
        }

        public function getValue():uint
        {
            return value;
        }

        public static function getByValue(arg1:uint):com.garmin.fit.HrType
        {
            return com.garmin.fit.custom.BaseType.getByValue(arg1) as HrType;
        }

        
        {
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(3)[0] = NORMAL;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(3)[1] = IRREGULAR;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(3)[2] = INVALID;
        }

        internal static const SINGLETON_ENFORCER:Object={};

        public static const NORMAL:com.garmin.fit.HrType=new HrType(SINGLETON_ENFORCER, 0);

        public static const IRREGULAR:com.garmin.fit.HrType=new HrType(SINGLETON_ENFORCER, 1);

        public static const INVALID:com.garmin.fit.HrType=new HrType(SINGLETON_ENFORCER, 255);

        public static const VALUES:__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>=new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(3);
    }
}


//    class HrZoneCalc
package com.garmin.fit 
{
    import __AS3__.vec.*;
    import avmplus.*;
    import com.garmin.fit.custom.*;
    import flash.errors.*;
    
    public class HrZoneCalc extends com.garmin.fit.custom.BaseType
    {
        public function HrZoneCalc(arg1:Object, arg2:uint)
        {
            super();
            if (arg1 != SINGLETON_ENFORCER) 
            {
                throw new flash.errors.IllegalOperationError("IllegalOperation: Manipulation of type " + avmplus.getQualifiedClassName(this));
            }
            this.value = arg2;
            return;
        }

        public function getAllValues():__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>
        {
            return VALUES;
        }

        public function getInvalid():com.garmin.fit.custom.BaseType
        {
            return INVALID;
        }

        public function getValue():uint
        {
            return value;
        }

        public static function getByValue(arg1:uint):com.garmin.fit.HrZoneCalc
        {
            return com.garmin.fit.custom.BaseType.getByValue(arg1) as HrZoneCalc;
        }

        
        {
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(4)[0] = CUSTOM;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(4)[1] = PERCENT_MAX_HR;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(4)[2] = PERCENT_HRR;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(4)[3] = INVALID;
        }

        internal static const SINGLETON_ENFORCER:Object={};

        public static const CUSTOM:com.garmin.fit.HrZoneCalc=new HrZoneCalc(SINGLETON_ENFORCER, 0);

        public static const PERCENT_MAX_HR:com.garmin.fit.HrZoneCalc=new HrZoneCalc(SINGLETON_ENFORCER, 1);

        public static const PERCENT_HRR:com.garmin.fit.HrZoneCalc=new HrZoneCalc(SINGLETON_ENFORCER, 2);

        public static const INVALID:com.garmin.fit.HrZoneCalc=new HrZoneCalc(SINGLETON_ENFORCER, 255);

        public static const VALUES:__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>=new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(4);
    }
}


//    class HrZoneMesg
package com.garmin.fit 
{
    public class HrZoneMesg extends com.garmin.fit.Mesg
    {
        public function HrZoneMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(8));
            return;
        }

        public function getMessageIndex():int
        {
            return getFieldIntegerValue(254, 0, 65535);
        }

        public function setMessageIndex(arg1:int):void
        {
            setFieldValue(254, 0, arg1, 65535);
            return;
        }

        public function getHighBpm():int
        {
            return getFieldIntegerValue(1, 0, 65535);
        }

        public function setHighBpm(arg1:int):void
        {
            setFieldValue(1, 0, arg1, 65535);
            return;
        }

        public override function getName():String
        {
            return getFieldStringValue(2, 0, 65535);
        }

        public function setName(arg1:String):void
        {
            setFieldValue(2, 0, arg1, 65535);
            return;
        }

        public static function get hrZoneMesg():com.garmin.fit.Mesg
        {
            return _hrZoneMesg;
        }

        
        {
            _hrZoneMesg = new com.garmin.fit.Mesg("hr_zone", 8);
            hrZoneMesg.addField(new com.garmin.fit.Field("message_index", 254, 132, 1, 0, ""));
            hrZoneMesg.addField(new com.garmin.fit.Field("high_bpm", 1, 2, 1, 0, "bpm"));
            hrZoneMesg.addField(new com.garmin.fit.Field("name", 2, 7, 1, 0, ""));
        }

        internal static var _hrZoneMesg:com.garmin.fit.Mesg;
    }
}


//    class HrmProfileMesg
package com.garmin.fit 
{
    public class HrmProfileMesg extends com.garmin.fit.Mesg
    {
        public function HrmProfileMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(4));
            return;
        }

        public function getMessageIndex():int
        {
            return getFieldIntegerValue(254, 0, 65535);
        }

        public function setMessageIndex(arg1:int):void
        {
            setFieldValue(254, 0, arg1, 65535);
            return;
        }

        public function getEnabled():com.garmin.fit.FITBool
        {
            var loc1:*=getFieldIntegerValue(0, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.FITBool.getByValue(loc1);
        }

        public function setEnabled(arg1:com.garmin.fit.FITBool):void
        {
            setFieldValue(0, 0, arg1.getValue(), 65535);
            return;
        }

        public function getHrmAntId():int
        {
            return getFieldIntegerValue(1, 0, 65535);
        }

        public function setHrmAntId(arg1:int):void
        {
            setFieldValue(1, 0, arg1, 65535);
            return;
        }

        public function getLogHrv():com.garmin.fit.FITBool
        {
            var loc1:*=getFieldIntegerValue(2, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.FITBool.getByValue(loc1);
        }

        public function setLogHrv(arg1:com.garmin.fit.FITBool):void
        {
            setFieldValue(2, 0, arg1.getValue(), 65535);
            return;
        }

        public function getHrmAntIdTransType():int
        {
            return getFieldIntegerValue(3, 0, 65535);
        }

        public function setHrmAntIdTransType(arg1:int):void
        {
            setFieldValue(3, 0, arg1, 65535);
            return;
        }

        public static function get hrmProfileMesg():com.garmin.fit.Mesg
        {
            return _hrmProfileMesg;
        }

        
        {
            _hrmProfileMesg = new com.garmin.fit.Mesg("hrm_profile", 4);
            hrmProfileMesg.addField(new com.garmin.fit.Field("message_index", 254, 132, 1, 0, ""));
            hrmProfileMesg.addField(new com.garmin.fit.Field("enabled", 0, 0, 1, 0, ""));
            hrmProfileMesg.addField(new com.garmin.fit.Field("hrm_ant_id", 1, 139, 1, 0, ""));
            hrmProfileMesg.addField(new com.garmin.fit.Field("log_hrv", 2, 0, 1, 0, ""));
            hrmProfileMesg.addField(new com.garmin.fit.Field("hrm_ant_id_trans_type", 3, 10, 1, 0, ""));
        }

        internal static var _hrmProfileMesg:com.garmin.fit.Mesg;
    }
}


//    class HrvMesg
package com.garmin.fit 
{
    public class HrvMesg extends com.garmin.fit.Mesg
    {
        public function HrvMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(78));
            return;
        }

        public function getNumTime():int
        {
            return getNumFieldValues(0, 65535);
        }

        public function getTime(arg1:int):Number
        {
            return getFieldDoubleValue(0, arg1, 65535);
        }

        public function setTime(arg1:int, arg2:Number):void
        {
            setFieldValue(0, arg1, arg2, 65535);
            return;
        }

        public static function get hrvMesg():com.garmin.fit.Mesg
        {
            return _hrvMesg;
        }

        
        {
            _hrvMesg = new com.garmin.fit.Mesg("hrv", 78);
            hrvMesg.addField(new com.garmin.fit.Field("time", 0, 132, 1000, 0, "s"));
        }

        internal static var _hrvMesg:com.garmin.fit.Mesg;
    }
}


//    class Intensity
package com.garmin.fit 
{
    import __AS3__.vec.*;
    import avmplus.*;
    import com.garmin.fit.custom.*;
    import flash.errors.*;
    
    public class Intensity extends com.garmin.fit.custom.BaseType
    {
        public function Intensity(arg1:Object, arg2:uint)
        {
            super();
            if (arg1 != SINGLETON_ENFORCER) 
            {
                throw new flash.errors.IllegalOperationError("IllegalOperation: Manipulation of type " + avmplus.getQualifiedClassName(this));
            }
            this.value = arg2;
            return;
        }

        public function getAllValues():__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>
        {
            return VALUES;
        }

        public function getInvalid():com.garmin.fit.custom.BaseType
        {
            return INVALID;
        }

        public function getValue():uint
        {
            return value;
        }

        public static function getByValue(arg1:uint):com.garmin.fit.Intensity
        {
            return com.garmin.fit.custom.BaseType.getByValue(arg1) as Intensity;
        }

        
        {
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(5)[0] = ACTIVE;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(5)[1] = REST;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(5)[2] = WARMUP;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(5)[3] = COOLDOWN;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(5)[4] = INVALID;
        }

        internal static const SINGLETON_ENFORCER:Object={};

        public static const ACTIVE:com.garmin.fit.Intensity=new Intensity(SINGLETON_ENFORCER, 0);

        public static const REST:com.garmin.fit.Intensity=new Intensity(SINGLETON_ENFORCER, 1);

        public static const WARMUP:com.garmin.fit.Intensity=new Intensity(SINGLETON_ENFORCER, 2);

        public static const COOLDOWN:com.garmin.fit.Intensity=new Intensity(SINGLETON_ENFORCER, 3);

        public static const INVALID:com.garmin.fit.Intensity=new Intensity(SINGLETON_ENFORCER, 255);

        public static const VALUES:__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>=new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(5);
    }
}


//    class Language
package com.garmin.fit 
{
    import __AS3__.vec.*;
    import avmplus.*;
    import com.garmin.fit.custom.*;
    import flash.errors.*;
    
    public class Language extends com.garmin.fit.custom.BaseType
    {
        public function Language(arg1:Object, arg2:uint)
        {
            super();
            if (arg1 != SINGLETON_ENFORCER) 
            {
                throw new flash.errors.IllegalOperationError("IllegalOperation: Manipulation of type " + avmplus.getQualifiedClassName(this));
            }
            this.value = arg2;
            return;
        }

        public function getAllValues():__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>
        {
            return VALUES;
        }

        public function getInvalid():com.garmin.fit.custom.BaseType
        {
            return INVALID;
        }

        public function getValue():uint
        {
            return value;
        }

        
        {
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(28)[0] = ENGLISH;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(28)[1] = FRENCH;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(28)[2] = ITALIAN;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(28)[3] = GERMAN;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(28)[4] = SPANISH;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(28)[5] = CROATIAN;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(28)[6] = CZECH;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(28)[7] = DANISH;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(28)[8] = DUTCH;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(28)[9] = FINNISH;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(28)[10] = GREEK;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(28)[11] = HUNGARIAN;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(28)[12] = NORWEGIAN;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(28)[13] = POLISH;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(28)[14] = PORTUGUESE;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(28)[15] = SLOVAKIAN;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(28)[16] = SLOVENIAN;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(28)[17] = SWEDISH;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(28)[18] = RUSSIAN;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(28)[19] = TURKISH;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(28)[20] = LATVIAN;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(28)[21] = UKRAINIAN;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(28)[22] = ARABIC;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(28)[23] = FARSI;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(28)[24] = BULGARIAN;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(28)[25] = ROMANIAN;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(28)[26] = CUSTOM;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(28)[27] = INVALID;
        }

        public static function getByValue(arg1:uint):com.garmin.fit.Language
        {
            return com.garmin.fit.custom.BaseType.getByValue(arg1) as Language;
        }

        internal static const SINGLETON_ENFORCER:Object={};

        public static const ENGLISH:com.garmin.fit.Language=new Language(SINGLETON_ENFORCER, 0);

        public static const FRENCH:com.garmin.fit.Language=new Language(SINGLETON_ENFORCER, 1);

        public static const ITALIAN:com.garmin.fit.Language=new Language(SINGLETON_ENFORCER, 2);

        public static const GERMAN:com.garmin.fit.Language=new Language(SINGLETON_ENFORCER, 3);

        public static const SPANISH:com.garmin.fit.Language=new Language(SINGLETON_ENFORCER, 4);

        public static const CROATIAN:com.garmin.fit.Language=new Language(SINGLETON_ENFORCER, 5);

        public static const CZECH:com.garmin.fit.Language=new Language(SINGLETON_ENFORCER, 6);

        public static const DANISH:com.garmin.fit.Language=new Language(SINGLETON_ENFORCER, 7);

        public static const DUTCH:com.garmin.fit.Language=new Language(SINGLETON_ENFORCER, 8);

        public static const FINNISH:com.garmin.fit.Language=new Language(SINGLETON_ENFORCER, 9);

        public static const GREEK:com.garmin.fit.Language=new Language(SINGLETON_ENFORCER, 10);

        public static const HUNGARIAN:com.garmin.fit.Language=new Language(SINGLETON_ENFORCER, 11);

        public static const NORWEGIAN:com.garmin.fit.Language=new Language(SINGLETON_ENFORCER, 12);

        public static const SLOVAKIAN:com.garmin.fit.Language=new Language(SINGLETON_ENFORCER, 15);

        public static const SLOVENIAN:com.garmin.fit.Language=new Language(SINGLETON_ENFORCER, 16);

        public static const SWEDISH:com.garmin.fit.Language=new Language(SINGLETON_ENFORCER, 17);

        public static const RUSSIAN:com.garmin.fit.Language=new Language(SINGLETON_ENFORCER, 18);

        public static const TURKISH:com.garmin.fit.Language=new Language(SINGLETON_ENFORCER, 19);

        public static const LATVIAN:com.garmin.fit.Language=new Language(SINGLETON_ENFORCER, 20);

        public static const UKRAINIAN:com.garmin.fit.Language=new Language(SINGLETON_ENFORCER, 21);

        public static const ARABIC:com.garmin.fit.Language=new Language(SINGLETON_ENFORCER, 22);

        public static const FARSI:com.garmin.fit.Language=new Language(SINGLETON_ENFORCER, 23);

        public static const BULGARIAN:com.garmin.fit.Language=new Language(SINGLETON_ENFORCER, 24);

        public static const ROMANIAN:com.garmin.fit.Language=new Language(SINGLETON_ENFORCER, 25);

        public static const CUSTOM:com.garmin.fit.Language=new Language(SINGLETON_ENFORCER, 254);

        public static const INVALID:com.garmin.fit.Language=new Language(SINGLETON_ENFORCER, 255);

        internal static const VALUES:__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>=new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(28);

        public static const PORTUGUESE:com.garmin.fit.Language=new Language(SINGLETON_ENFORCER, 14);

        public static const POLISH:com.garmin.fit.Language=new Language(SINGLETON_ENFORCER, 13);
    }
}


//    class LapMesg
package com.garmin.fit 
{
    public class LapMesg extends com.garmin.fit.Mesg implements com.garmin.fit.MesgWithEvent
    {
        public function LapMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(19));
            return;
        }

        public function getMessageIndex():int
        {
            return getFieldIntegerValue(254, 0, 65535);
        }

        public function setMessageIndex(arg1:int):void
        {
            setFieldValue(254, 0, arg1, 65535);
            return;
        }

        public function getTimestamp():com.garmin.fit.DateTime
        {
            return timestampToDateTime(getFieldDoubleValue(253, 0, 65535));
        }

        public function setTimestamp(arg1:com.garmin.fit.DateTime):void
        {
            setFieldValue(253, 0, arg1.getTimestamp(), 65535);
            return;
        }

        public function getEvent():com.garmin.fit.FITEvent
        {
            var loc1:*=getFieldIntegerValue(0, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.FITEvent.getByValue(loc1);
        }

        public function setEvent(arg1:com.garmin.fit.FITEvent):void
        {
            setFieldValue(0, 0, arg1.getValue(), 65535);
            return;
        }

        public function getEventType():com.garmin.fit.EventType
        {
            var loc1:*=getFieldIntegerValue(1, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.EventType.getByValue(loc1);
        }

        public function setEventType(arg1:com.garmin.fit.EventType):void
        {
            setFieldValue(1, 0, arg1.getValue(), 65535);
            return;
        }

        public function getStartTime():com.garmin.fit.DateTime
        {
            return timestampToDateTime(getFieldDoubleValue(2, 0, 65535));
        }

        public function setStartTime(arg1:com.garmin.fit.DateTime):void
        {
            setFieldValue(2, 0, arg1.getTimestamp(), 65535);
            return;
        }

        public function getStartPositionLat():int
        {
            return getFieldIntegerValue(3, 0, 65535);
        }

        public function setStartPositionLat(arg1:int):void
        {
            setFieldValue(3, 0, arg1, 65535);
            return;
        }

        public function getStartPositionLong():int
        {
            return getFieldIntegerValue(4, 0, 65535);
        }

        public function setStartPositionLong(arg1:int):void
        {
            setFieldValue(4, 0, arg1, 65535);
            return;
        }

        public function getEndPositionLat():int
        {
            return getFieldIntegerValue(5, 0, 65535);
        }

        public function setEndPositionLat(arg1:int):void
        {
            setFieldValue(5, 0, arg1, 65535);
            return;
        }

        public function getEndPositionLong():int
        {
            return getFieldIntegerValue(6, 0, 65535);
        }

        public function setEndPositionLong(arg1:int):void
        {
            setFieldValue(6, 0, arg1, 65535);
            return;
        }

        public function getTotalElapsedTime():Number
        {
            return getFieldDoubleValue(7, 0, 65535);
        }

        public function setTotalElapsedTime(arg1:Number):void
        {
            setFieldValue(7, 0, arg1, 65535);
            return;
        }

        public function getTotalTimerTime():Number
        {
            return getFieldDoubleValue(8, 0, 65535);
        }

        public function setTotalTimerTime(arg1:Number):void
        {
            setFieldValue(8, 0, arg1, 65535);
            return;
        }

        public function getTotalDistance():Number
        {
            return getFieldDoubleValue(9, 0, 65535);
        }

        public function setTotalDistance(arg1:Number):void
        {
            setFieldValue(9, 0, arg1, 65535);
            return;
        }

        public function getTotalCycles():Number
        {
            return getFieldDoubleValue(10, 0, 65535);
        }

        public function setTotalCycles(arg1:Number):void
        {
            setFieldValue(10, 0, arg1, 65535);
            return;
        }

        public function getTotalStrides():Number
        {
            return getFieldDoubleValue(10, 0, 0);
        }

        public function setTotalStrides(arg1:Number):void
        {
            setFieldValue(10, 0, arg1, 0);
            return;
        }

        public function getTotalCalories():int
        {
            return getFieldIntegerValue(11, 0, 65535);
        }

        public function setTotalCalories(arg1:int):void
        {
            setFieldValue(11, 0, arg1, 65535);
            return;
        }

        public function getTotalFatCalories():int
        {
            return getFieldIntegerValue(12, 0, 65535);
        }

        public function setTotalFatCalories(arg1:int):void
        {
            setFieldValue(12, 0, arg1, 65535);
            return;
        }

        public function getAvgSpeed():Number
        {
            return getFieldDoubleValue(13, 0, 65535);
        }

        public function setAvgSpeed(arg1:Number):void
        {
            setFieldValue(13, 0, arg1, 65535);
            return;
        }

        public function getMaxSpeed():Number
        {
            return getFieldDoubleValue(14, 0, 65535);
        }

        public function setMaxSpeed(arg1:Number):void
        {
            setFieldValue(14, 0, arg1, 65535);
            return;
        }

        public function getAvgHeartRate():int
        {
            return getFieldIntegerValue(15, 0, 65535);
        }

        public function setAvgHeartRate(arg1:int):void
        {
            setFieldValue(15, 0, arg1, 65535);
            return;
        }

        public function getMaxHeartRate():int
        {
            return getFieldIntegerValue(16, 0, 65535);
        }

        public function setMaxHeartRate(arg1:int):void
        {
            setFieldValue(16, 0, arg1, 65535);
            return;
        }

        public function getAvgCadence():int
        {
            return getFieldIntegerValue(17, 0, 65535);
        }

        public function setAvgCadence(arg1:int):void
        {
            setFieldValue(17, 0, arg1, 65535);
            return;
        }

        public function getAvgRunningCadence():int
        {
            return getFieldIntegerValue(17, 0, 0);
        }

        public function setAvgRunningCadence(arg1:int):void
        {
            setFieldValue(17, 0, arg1, 0);
            return;
        }

        public function getMaxCadence():int
        {
            return getFieldIntegerValue(18, 0, 65535);
        }

        public function setMaxCadence(arg1:int):void
        {
            setFieldValue(18, 0, arg1, 65535);
            return;
        }

        public function getMaxRunningCadence():int
        {
            return getFieldIntegerValue(18, 0, 0);
        }

        public function setMaxRunningCadence(arg1:int):void
        {
            setFieldValue(18, 0, arg1, 0);
            return;
        }

        public function getAvgPower():int
        {
            return getFieldIntegerValue(19, 0, 65535);
        }

        public function setAvgPower(arg1:int):void
        {
            setFieldValue(19, 0, arg1, 65535);
            return;
        }

        public function getMaxPower():int
        {
            return getFieldIntegerValue(20, 0, 65535);
        }

        public function setMaxPower(arg1:int):void
        {
            setFieldValue(20, 0, arg1, 65535);
            return;
        }

        public function getTotalAscent():int
        {
            return getFieldIntegerValue(21, 0, 65535);
        }

        public function setTotalAscent(arg1:int):void
        {
            setFieldValue(21, 0, arg1, 65535);
            return;
        }

        public function getTotalDescent():int
        {
            return getFieldIntegerValue(22, 0, 65535);
        }

        public function setTotalDescent(arg1:int):void
        {
            setFieldValue(22, 0, arg1, 65535);
            return;
        }

        public function getIntensity():com.garmin.fit.Intensity
        {
            var loc1:*=getFieldIntegerValue(23, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.Intensity.getByValue(loc1);
        }

        public function setIntensity(arg1:com.garmin.fit.Intensity):void
        {
            setFieldValue(23, 0, arg1.getValue(), 65535);
            return;
        }

        public function getLapTrigger():com.garmin.fit.LapTrigger
        {
            var loc1:*=getFieldIntegerValue(24, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.LapTrigger.getByValue(loc1);
        }

        public function setLapTrigger(arg1:com.garmin.fit.LapTrigger):void
        {
            setFieldValue(24, 0, arg1.getValue(), 65535);
            return;
        }

        public function getSport():com.garmin.fit.Sport
        {
            var loc1:*=getFieldIntegerValue(25, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.Sport.getByValue(loc1);
        }

        public function setSport(arg1:com.garmin.fit.Sport):void
        {
            setFieldValue(25, 0, arg1.getValue(), 65535);
            return;
        }

        public function getEventGroup():int
        {
            return getFieldIntegerValue(26, 0, 65535);
        }

        public function setEventGroup(arg1:int):void
        {
            setFieldValue(26, 0, arg1, 65535);
            return;
        }

        public function getNumLengths():int
        {
            return getFieldIntegerValue(32, 0, 65535);
        }

        public function setNumLengths(arg1:int):void
        {
            setFieldValue(32, 0, arg1, 65535);
            return;
        }

        public function getNormalizedPower():int
        {
            return getFieldIntegerValue(33, 0, 65535);
        }

        public function setNormalizedPower(arg1:int):void
        {
            setFieldValue(33, 0, arg1, 65535);
            return;
        }

        public function getLeftRightBalance():int
        {
            return getFieldIntegerValue(34, 0, 65535);
        }

        public function setLeftRightBalance(arg1:int):void
        {
            setFieldValue(34, 0, arg1, 65535);
            return;
        }

        public function getFirstLengthIndex():int
        {
            return getFieldIntegerValue(35, 0, 65535);
        }

        public function setFirstLengthIndex(arg1:int):void
        {
            setFieldValue(35, 0, arg1, 65535);
            return;
        }

        public function getAvgStrokeDistance():Number
        {
            return getFieldDoubleValue(37, 0, 65535);
        }

        public function setAvgStrokeDistance(arg1:Number):void
        {
            setFieldValue(37, 0, arg1, 65535);
            return;
        }

        public function getSwimStroke():com.garmin.fit.SwimStroke
        {
            var loc1:*=getFieldIntegerValue(38, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.SwimStroke.getByValue(loc1);
        }

        public function setSwimStroke(arg1:com.garmin.fit.SwimStroke):void
        {
            setFieldValue(38, 0, arg1.getValue(), 65535);
            return;
        }

        public function getSubSport():com.garmin.fit.SubSport
        {
            var loc1:*=getFieldIntegerValue(39, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.SubSport.getByValue(loc1);
        }

        public function setSubSport(arg1:com.garmin.fit.SubSport):void
        {
            setFieldValue(39, 0, arg1.getValue(), 65535);
            return;
        }

        public function getNumActiveLengths():int
        {
            return getFieldIntegerValue(40, 0, 65535);
        }

        public function setNumActiveLengths(arg1:int):void
        {
            setFieldValue(40, 0, arg1, 65535);
            return;
        }

        public function getTotalWork():Number
        {
            return getFieldDoubleValue(41, 0, 65535);
        }

        public function setTotalWork(arg1:Number):void
        {
            setFieldValue(41, 0, arg1, 65535);
            return;
        }

        public function getAvgAltitude():Number
        {
            return getFieldDoubleValue(42, 0, 65535);
        }

        public function setAvgAltitude(arg1:Number):void
        {
            setFieldValue(42, 0, arg1, 65535);
            return;
        }

        public function getMaxAltitude():Number
        {
            return getFieldDoubleValue(43, 0, 65535);
        }

        public function setMaxAltitude(arg1:Number):void
        {
            setFieldValue(43, 0, arg1, 65535);
            return;
        }

        public function getGpsAccuracy():int
        {
            return getFieldIntegerValue(44, 0, 65535);
        }

        public function setGpsAccuracy(arg1:int):void
        {
            setFieldValue(44, 0, arg1, 65535);
            return;
        }

        public function getAvgGrade():Number
        {
            return getFieldDoubleValue(45, 0, 65535);
        }

        public function setAvgGrade(arg1:Number):void
        {
            setFieldValue(45, 0, arg1, 65535);
            return;
        }

        public function getAvgPosGrade():Number
        {
            return getFieldDoubleValue(46, 0, 65535);
        }

        public function setAvgPosGrade(arg1:Number):void
        {
            setFieldValue(46, 0, arg1, 65535);
            return;
        }

        public function getAvgNegGrade():Number
        {
            return getFieldDoubleValue(47, 0, 65535);
        }

        public function setAvgNegGrade(arg1:Number):void
        {
            setFieldValue(47, 0, arg1, 65535);
            return;
        }

        public function getMaxPosGrade():Number
        {
            return getFieldDoubleValue(48, 0, 65535);
        }

        public function setMaxPosGrade(arg1:Number):void
        {
            setFieldValue(48, 0, arg1, 65535);
            return;
        }

        public function getMaxNegGrade():Number
        {
            return getFieldDoubleValue(49, 0, 65535);
        }

        public function setMaxNegGrade(arg1:Number):void
        {
            setFieldValue(49, 0, arg1, 65535);
            return;
        }

        public function getAvgTemperature():int
        {
            return getFieldIntegerValue(50, 0, 65535);
        }

        public function setAvgTemperature(arg1:int):void
        {
            setFieldValue(50, 0, arg1, 65535);
            return;
        }

        public function getMaxTemperature():int
        {
            return getFieldIntegerValue(51, 0, 65535);
        }

        public function setMaxTemperature(arg1:int):void
        {
            setFieldValue(51, 0, arg1, 65535);
            return;
        }

        public function getTotalMovingTime():Number
        {
            return getFieldDoubleValue(52, 0, 65535);
        }

        public function setTotalMovingTime(arg1:Number):void
        {
            setFieldValue(52, 0, arg1, 65535);
            return;
        }

        public function getAvgPosVerticalSpeed():Number
        {
            return getFieldDoubleValue(53, 0, 65535);
        }

        public function setAvgPosVerticalSpeed(arg1:Number):void
        {
            setFieldValue(53, 0, arg1, 65535);
            return;
        }

        public function getAvgNegVerticalSpeed():Number
        {
            return getFieldDoubleValue(54, 0, 65535);
        }

        public function setAvgNegVerticalSpeed(arg1:Number):void
        {
            setFieldValue(54, 0, arg1, 65535);
            return;
        }

        public function getMaxPosVerticalSpeed():Number
        {
            return getFieldDoubleValue(55, 0, 65535);
        }

        public function setMaxPosVerticalSpeed(arg1:Number):void
        {
            setFieldValue(55, 0, arg1, 65535);
            return;
        }

        public function getMaxNegVerticalSpeed():Number
        {
            return getFieldDoubleValue(56, 0, 65535);
        }

        public function setMaxNegVerticalSpeed(arg1:Number):void
        {
            setFieldValue(56, 0, arg1, 65535);
            return;
        }

        public function getNumTimeInHrZone():int
        {
            return getNumFieldValues(57, 65535);
        }

        public function getTimeInHrZone(arg1:int):Number
        {
            return getFieldDoubleValue(57, arg1, 65535);
        }

        public function setTimeInHrZone(arg1:int, arg2:Number):void
        {
            setFieldValue(57, arg1, arg2, 65535);
            return;
        }

        public function getNumTimeInSpeedZone():int
        {
            return getNumFieldValues(58, 65535);
        }

        public function getTimeInSpeedZone(arg1:int):Number
        {
            return getFieldDoubleValue(58, arg1, 65535);
        }

        public function setTimeInSpeedZone(arg1:int, arg2:Number):void
        {
            setFieldValue(58, arg1, arg2, 65535);
            return;
        }

        public function getNumTimeInCadenceZone():int
        {
            return getNumFieldValues(59, 65535);
        }

        public function getTimeInCadenceZone(arg1:int):Number
        {
            return getFieldDoubleValue(59, arg1, 65535);
        }

        public function setTimeInCadenceZone(arg1:int, arg2:Number):void
        {
            setFieldValue(59, arg1, arg2, 65535);
            return;
        }

        public function getNumTimeInPowerZone():int
        {
            return getNumFieldValues(60, 65535);
        }

        public function getTimeInPowerZone(arg1:int):Number
        {
            return getFieldDoubleValue(60, arg1, 65535);
        }

        public function setTimeInPowerZone(arg1:int, arg2:Number):void
        {
            setFieldValue(60, arg1, arg2, 65535);
            return;
        }

        public function getRepetitionNum():int
        {
            return getFieldIntegerValue(61, 0, 65535);
        }

        public function setRepetitionNum(arg1:int):void
        {
            setFieldValue(61, 0, arg1, 65535);
            return;
        }

        public function getMinAltitude():Number
        {
            return getFieldDoubleValue(62, 0, 65535);
        }

        public function setMinAltitude(arg1:Number):void
        {
            setFieldValue(62, 0, arg1, 65535);
            return;
        }

        public function getMinHeartRate():int
        {
            return getFieldIntegerValue(63, 0, 65535);
        }

        public function setMinHeartRate(arg1:int):void
        {
            setFieldValue(63, 0, arg1, 65535);
            return;
        }

        public function getWktStepIndex():int
        {
            return getFieldIntegerValue(71, 0, 65535);
        }

        public function setWktStepIndex(arg1:int):void
        {
            setFieldValue(71, 0, arg1, 65535);
            return;
        }

        public static function get lapMesg():com.garmin.fit.Mesg
        {
            return _lapMesg;
        }

        
        {
            _lapMesg = new com.garmin.fit.Mesg("lap", 19);
            lapMesg.addField(new com.garmin.fit.Field("message_index", 254, 132, 1, 0, ""));
            ++field_index;
            lapMesg.addField(new com.garmin.fit.Field("timestamp", 253, 134, 1, 0, "s"));
            ++field_index;
            lapMesg.addField(new com.garmin.fit.Field("event", 0, 0, 1, 0, ""));
            ++field_index;
            lapMesg.addField(new com.garmin.fit.Field("event_type", 1, 0, 1, 0, ""));
            ++field_index;
            lapMesg.addField(new com.garmin.fit.Field("start_time", 2, 134, 1, 0, ""));
            ++field_index;
            lapMesg.addField(new com.garmin.fit.Field("start_position_lat", 3, 133, 1, 0, "semicircles"));
            ++field_index;
            lapMesg.addField(new com.garmin.fit.Field("start_position_long", 4, 133, 1, 0, "semicircles"));
            ++field_index;
            lapMesg.addField(new com.garmin.fit.Field("end_position_lat", 5, 133, 1, 0, "semicircles"));
            ++field_index;
            lapMesg.addField(new com.garmin.fit.Field("end_position_long", 6, 133, 1, 0, "semicircles"));
            ++field_index;
            lapMesg.addField(new com.garmin.fit.Field("total_elapsed_time", 7, 134, 1000, 0, "s"));
            ++field_index;
            lapMesg.addField(new com.garmin.fit.Field("total_timer_time", 8, 134, 1000, 0, "s"));
            ++field_index;
            lapMesg.addField(new com.garmin.fit.Field("total_distance", 9, 134, 100, 0, "m"));
            ++field_index;
            lapMesg.addField(new com.garmin.fit.Field("total_cycles", 10, 134, 1, 0, "cycles"));
            subfield_index = 0;
            lapMesg.fields[field_index].subFields.push(new com.garmin.fit.SubField("total_strides", 134, 1, 0, "strides"));
            lapMesg.fields[field_index].subFields[subfield_index].addMap(25, 1);
            ++subfield_index;
            ++field_index;
            lapMesg.addField(new com.garmin.fit.Field("total_calories", 11, 132, 1, 0, "kcal"));
            ++field_index;
            lapMesg.addField(new com.garmin.fit.Field("total_fat_calories", 12, 132, 1, 0, "kcal"));
            ++field_index;
            lapMesg.addField(new com.garmin.fit.Field("avg_speed", 13, 132, 1000, 0, "m/s"));
            ++field_index;
            lapMesg.addField(new com.garmin.fit.Field("max_speed", 14, 132, 1000, 0, "m/s"));
            ++field_index;
            lapMesg.addField(new com.garmin.fit.Field("avg_heart_rate", 15, 2, 1, 0, "bpm"));
            ++field_index;
            lapMesg.addField(new com.garmin.fit.Field("max_heart_rate", 16, 2, 1, 0, "bpm"));
            ++field_index;
            lapMesg.addField(new com.garmin.fit.Field("avg_cadence", 17, 2, 1, 0, "rpm"));
            subfield_index = 0;
            lapMesg.fields[field_index].subFields.push(new com.garmin.fit.SubField("avg_running_cadence", 2, 1, 0, "strides/min"));
            lapMesg.fields[field_index].subFields[subfield_index].addMap(25, 1);
            ++subfield_index;
            ++field_index;
            lapMesg.addField(new com.garmin.fit.Field("max_cadence", 18, 2, 1, 0, "rpm"));
            subfield_index = 0;
            lapMesg.fields[field_index].subFields.push(new com.garmin.fit.SubField("max_running_cadence", 2, 1, 0, "strides/min"));
            lapMesg.fields[field_index].subFields[subfield_index].addMap(25, 1);
            ++subfield_index;
            ++field_index;
            lapMesg.addField(new com.garmin.fit.Field("avg_power", 19, 132, 1, 0, "watts"));
            ++field_index;
            lapMesg.addField(new com.garmin.fit.Field("max_power", 20, 132, 1, 0, "watts"));
            ++field_index;
            lapMesg.addField(new com.garmin.fit.Field("total_ascent", 21, 132, 1, 0, "m"));
            ++field_index;
            lapMesg.addField(new com.garmin.fit.Field("total_descent", 22, 132, 1, 0, "m"));
            ++field_index;
            lapMesg.addField(new com.garmin.fit.Field("intensity", 23, 0, 1, 0, ""));
            ++field_index;
            lapMesg.addField(new com.garmin.fit.Field("lap_trigger", 24, 0, 1, 0, ""));
            ++field_index;
            lapMesg.addField(new com.garmin.fit.Field("sport", 25, 0, 1, 0, ""));
            ++field_index;
            lapMesg.addField(new com.garmin.fit.Field("event_group", 26, 2, 1, 0, ""));
            ++field_index;
            lapMesg.addField(new com.garmin.fit.Field("num_lengths", 32, 132, 1, 0, "lengths"));
            ++field_index;
            lapMesg.addField(new com.garmin.fit.Field("normalized_power", 33, 132, 1, 0, "watts"));
            ++field_index;
            lapMesg.addField(new com.garmin.fit.Field("left_right_balance", 34, 132, 1, 0, ""));
            ++field_index;
            lapMesg.addField(new com.garmin.fit.Field("first_length_index", 35, 132, 1, 0, ""));
            ++field_index;
            lapMesg.addField(new com.garmin.fit.Field("avg_stroke_distance", 37, 132, 100, 0, "m"));
            ++field_index;
            lapMesg.addField(new com.garmin.fit.Field("swim_stroke", 38, 0, 1, 0, ""));
            ++field_index;
            lapMesg.addField(new com.garmin.fit.Field("sub_sport", 39, 0, 1, 0, ""));
            ++field_index;
            lapMesg.addField(new com.garmin.fit.Field("num_active_lengths", 40, 132, 1, 0, "lengths"));
            ++field_index;
            lapMesg.addField(new com.garmin.fit.Field("total_work", 41, 134, 1, 0, "J"));
            ++field_index;
            lapMesg.addField(new com.garmin.fit.Field("avg_altitude", 42, 132, 5, 500, "m"));
            ++field_index;
            lapMesg.addField(new com.garmin.fit.Field("max_altitude", 43, 132, 5, 500, "m"));
            ++field_index;
            lapMesg.addField(new com.garmin.fit.Field("gps_accuracy", 44, 2, 1, 0, "m"));
            ++field_index;
            lapMesg.addField(new com.garmin.fit.Field("avg_grade", 45, 131, 100, 0, "%"));
            ++field_index;
            lapMesg.addField(new com.garmin.fit.Field("avg_pos_grade", 46, 131, 100, 0, "%"));
            ++field_index;
            lapMesg.addField(new com.garmin.fit.Field("avg_neg_grade", 47, 131, 100, 0, "%"));
            ++field_index;
            lapMesg.addField(new com.garmin.fit.Field("max_pos_grade", 48, 131, 100, 0, "%"));
            ++field_index;
            lapMesg.addField(new com.garmin.fit.Field("max_neg_grade", 49, 131, 100, 0, "%"));
            ++field_index;
            lapMesg.addField(new com.garmin.fit.Field("avg_temperature", 50, 1, 1, 0, "C"));
            ++field_index;
            lapMesg.addField(new com.garmin.fit.Field("max_temperature", 51, 1, 1, 0, "C"));
            ++field_index;
            lapMesg.addField(new com.garmin.fit.Field("total_moving_time", 52, 134, 1000, 0, "s"));
            ++field_index;
            lapMesg.addField(new com.garmin.fit.Field("avg_pos_vertical_speed", 53, 131, 1000, 0, "m/s"));
            ++field_index;
            lapMesg.addField(new com.garmin.fit.Field("avg_neg_vertical_speed", 54, 131, 1000, 0, "m/s"));
            ++field_index;
            lapMesg.addField(new com.garmin.fit.Field("max_pos_vertical_speed", 55, 131, 1000, 0, "m/s"));
            ++field_index;
            lapMesg.addField(new com.garmin.fit.Field("max_neg_vertical_speed", 56, 131, 1000, 0, "m/s"));
            ++field_index;
            lapMesg.addField(new com.garmin.fit.Field("time_in_hr_zone", 57, 134, 1000, 0, "s"));
            ++field_index;
            lapMesg.addField(new com.garmin.fit.Field("time_in_speed_zone", 58, 134, 1000, 0, "s"));
            ++field_index;
            lapMesg.addField(new com.garmin.fit.Field("time_in_cadence_zone", 59, 134, 1000, 0, "s"));
            ++field_index;
            lapMesg.addField(new com.garmin.fit.Field("time_in_power_zone", 60, 134, 1000, 0, "s"));
            ++field_index;
            lapMesg.addField(new com.garmin.fit.Field("repetition_num", 61, 132, 1, 0, ""));
            ++field_index;
            lapMesg.addField(new com.garmin.fit.Field("min_altitude", 62, 132, 5, 500, "m"));
            ++field_index;
            lapMesg.addField(new com.garmin.fit.Field("min_heart_rate", 63, 2, 1, 0, "bpm"));
            ++field_index;
            lapMesg.addField(new com.garmin.fit.Field("wkt_step_index", 71, 132, 1, 0, ""));
            ++field_index;
        }

        internal static var field_index:int=0;

        internal static var subfield_index:int=0;

        internal static var _lapMesg:com.garmin.fit.Mesg;
    }
}


//    class LapTrigger
package com.garmin.fit 
{
    import __AS3__.vec.*;
    import avmplus.*;
    import com.garmin.fit.custom.*;
    import flash.errors.*;
    
    public class LapTrigger extends com.garmin.fit.custom.BaseType
    {
        public function LapTrigger(arg1:Object, arg2:uint)
        {
            super();
            if (arg1 != SINGLETON_ENFORCER) 
            {
                throw new flash.errors.IllegalOperationError("IllegalOperation: Manipulation of type " + avmplus.getQualifiedClassName(this));
            }
            this.value = arg2;
            return;
        }

        public function getAllValues():__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>
        {
            return VALUES;
        }

        public function getInvalid():com.garmin.fit.custom.BaseType
        {
            return INVALID;
        }

        public function getValue():uint
        {
            return value;
        }

        public static function getByValue(arg1:uint):com.garmin.fit.LapTrigger
        {
            return com.garmin.fit.custom.BaseType.getByValue(arg1) as LapTrigger;
        }

        
        {
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(10)[0] = MANUAL;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(10)[1] = TIME;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(10)[2] = DISTANCE;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(10)[3] = POSITION_START;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(10)[4] = POSITION_LAP;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(10)[5] = POSITION_WAYPOINT;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(10)[6] = POSITION_MARKED;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(10)[7] = SESSION_END;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(10)[8] = FITNESS_EQUIPMENT;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(10)[9] = INVALID;
        }

        internal static const SINGLETON_ENFORCER:Object={};

        public static const MANUAL:com.garmin.fit.LapTrigger=new LapTrigger(SINGLETON_ENFORCER, 0);

        public static const TIME:com.garmin.fit.LapTrigger=new LapTrigger(SINGLETON_ENFORCER, 1);

        public static const DISTANCE:com.garmin.fit.LapTrigger=new LapTrigger(SINGLETON_ENFORCER, 2);

        public static const POSITION_START:com.garmin.fit.LapTrigger=new LapTrigger(SINGLETON_ENFORCER, 3);

        public static const POSITION_LAP:com.garmin.fit.LapTrigger=new LapTrigger(SINGLETON_ENFORCER, 4);

        public static const POSITION_WAYPOINT:com.garmin.fit.LapTrigger=new LapTrigger(SINGLETON_ENFORCER, 5);

        public static const POSITION_MARKED:com.garmin.fit.LapTrigger=new LapTrigger(SINGLETON_ENFORCER, 6);

        public static const SESSION_END:com.garmin.fit.LapTrigger=new LapTrigger(SINGLETON_ENFORCER, 7);

        public static const FITNESS_EQUIPMENT:com.garmin.fit.LapTrigger=new LapTrigger(SINGLETON_ENFORCER, 8);

        public static const INVALID:com.garmin.fit.LapTrigger=new LapTrigger(SINGLETON_ENFORCER, 255);

        public static const VALUES:__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>=new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(10);
    }
}


//    class LengthMesg
package com.garmin.fit 
{
    public class LengthMesg extends com.garmin.fit.Mesg implements com.garmin.fit.MesgWithEvent
    {
        public function LengthMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(101));
            return;
        }

        public function getMessageIndex():int
        {
            return getFieldIntegerValue(254, 0, 65535);
        }

        public function setMessageIndex(arg1:int):void
        {
            setFieldValue(254, 0, arg1, 65535);
            return;
        }

        public function getTimestamp():com.garmin.fit.DateTime
        {
            return timestampToDateTime(getFieldDoubleValue(253, 0, 65535));
        }

        public function setTimestamp(arg1:com.garmin.fit.DateTime):void
        {
            setFieldValue(253, 0, arg1.getTimestamp(), 65535);
            return;
        }

        public function getEvent():com.garmin.fit.FITEvent
        {
            var loc1:*=getFieldIntegerValue(0, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.FITEvent.getByValue(loc1);
        }

        public function setEvent(arg1:com.garmin.fit.FITEvent):void
        {
            setFieldValue(0, 0, arg1.getValue(), 65535);
            return;
        }

        public function getEventType():com.garmin.fit.EventType
        {
            var loc1:*=getFieldIntegerValue(1, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.EventType.getByValue(loc1);
        }

        public function setEventType(arg1:com.garmin.fit.EventType):void
        {
            setFieldValue(1, 0, arg1.getValue(), 65535);
            return;
        }

        public function getStartTime():com.garmin.fit.DateTime
        {
            return timestampToDateTime(getFieldDoubleValue(2, 0, 65535));
        }

        public function setStartTime(arg1:com.garmin.fit.DateTime):void
        {
            setFieldValue(2, 0, arg1.getTimestamp(), 65535);
            return;
        }

        public function getTotalElapsedTime():Number
        {
            return getFieldDoubleValue(3, 0, 65535);
        }

        public function setTotalElapsedTime(arg1:Number):void
        {
            setFieldValue(3, 0, arg1, 65535);
            return;
        }

        public function getTotalTimerTime():Number
        {
            return getFieldDoubleValue(4, 0, 65535);
        }

        public function setTotalTimerTime(arg1:Number):void
        {
            setFieldValue(4, 0, arg1, 65535);
            return;
        }

        public function getTotalStrokes():int
        {
            return getFieldIntegerValue(5, 0, 65535);
        }

        public function setTotalStrokes(arg1:int):void
        {
            setFieldValue(5, 0, arg1, 65535);
            return;
        }

        public function getAvgSpeed():Number
        {
            return getFieldDoubleValue(6, 0, 65535);
        }

        public function setAvgSpeed(arg1:Number):void
        {
            setFieldValue(6, 0, arg1, 65535);
            return;
        }

        public function getSwimStroke():com.garmin.fit.SwimStroke
        {
            var loc1:*=getFieldIntegerValue(7, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.SwimStroke.getByValue(loc1);
        }

        public function setSwimStroke(arg1:com.garmin.fit.SwimStroke):void
        {
            setFieldValue(7, 0, arg1.getValue(), 65535);
            return;
        }

        public function getAvgSwimmingCadence():int
        {
            return getFieldIntegerValue(9, 0, 65535);
        }

        public function setAvgSwimmingCadence(arg1:int):void
        {
            setFieldValue(9, 0, arg1, 65535);
            return;
        }

        public function getEventGroup():int
        {
            return getFieldIntegerValue(10, 0, 65535);
        }

        public function setEventGroup(arg1:int):void
        {
            setFieldValue(10, 0, arg1, 65535);
            return;
        }

        public function getTotalCalories():int
        {
            return getFieldIntegerValue(11, 0, 65535);
        }

        public function setTotalCalories(arg1:int):void
        {
            setFieldValue(11, 0, arg1, 65535);
            return;
        }

        public function getLengthType():com.garmin.fit.LengthType
        {
            var loc1:*=getFieldIntegerValue(12, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.LengthType.getByValue(loc1);
        }

        public function setLengthType(arg1:com.garmin.fit.LengthType):void
        {
            setFieldValue(12, 0, arg1.getValue(), 65535);
            return;
        }

        public static function get lengthMesg():com.garmin.fit.Mesg
        {
            return _lengthMesg;
        }

        
        {
            _lengthMesg = new com.garmin.fit.Mesg("length", 101);
            lengthMesg.addField(new com.garmin.fit.Field("message_index", 254, 132, 1, 0, ""));
            lengthMesg.addField(new com.garmin.fit.Field("timestamp", 253, 134, 1, 0, ""));
            lengthMesg.addField(new com.garmin.fit.Field("event", 0, 0, 1, 0, ""));
            lengthMesg.addField(new com.garmin.fit.Field("event_type", 1, 0, 1, 0, ""));
            lengthMesg.addField(new com.garmin.fit.Field("start_time", 2, 134, 1, 0, ""));
            lengthMesg.addField(new com.garmin.fit.Field("total_elapsed_time", 3, 134, 1000, 0, "s"));
            lengthMesg.addField(new com.garmin.fit.Field("total_timer_time", 4, 134, 1000, 0, "s"));
            lengthMesg.addField(new com.garmin.fit.Field("total_strokes", 5, 132, 1, 0, "strokes"));
            lengthMesg.addField(new com.garmin.fit.Field("avg_speed", 6, 132, 1000, 0, "m/s"));
            lengthMesg.addField(new com.garmin.fit.Field("swim_stroke", 7, 0, 1, 0, "swim_stroke"));
            lengthMesg.addField(new com.garmin.fit.Field("avg_swimming_cadence", 9, 2, 1, 0, "strokes/min"));
            lengthMesg.addField(new com.garmin.fit.Field("event_group", 10, 2, 1, 0, ""));
            lengthMesg.addField(new com.garmin.fit.Field("total_calories", 11, 132, 1, 0, "kcal"));
            lengthMesg.addField(new com.garmin.fit.Field("length_type", 12, 0, 1, 0, ""));
        }

        internal static var _lengthMesg:com.garmin.fit.Mesg;
    }
}


//    class LengthType
package com.garmin.fit 
{
    import __AS3__.vec.*;
    import avmplus.*;
    import com.garmin.fit.custom.*;
    import flash.errors.*;
    
    public class LengthType extends com.garmin.fit.custom.BaseType
    {
        public function LengthType(arg1:Object, arg2:uint)
        {
            super();
            if (arg1 != SINGLETON_ENFORCER) 
            {
                throw new flash.errors.IllegalOperationError("IllegalOperation: Manipulation of type " + avmplus.getQualifiedClassName(this));
            }
            this.value = arg2;
            return;
        }

        public function getAllValues():__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>
        {
            return VALUES;
        }

        public function getInvalid():com.garmin.fit.custom.BaseType
        {
            return INVALID;
        }

        public function getValue():uint
        {
            return value;
        }

        public static function getByValue(arg1:uint):com.garmin.fit.LengthType
        {
            return com.garmin.fit.custom.BaseType.getByValue(arg1) as LengthType;
        }

        
        {
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(3)[0] = IDLE;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(3)[1] = ACTIVE;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(3)[2] = INVALID;
        }

        internal static const SINGLETON_ENFORCER:Object={};

        public static const IDLE:com.garmin.fit.LengthType=new LengthType(SINGLETON_ENFORCER, 0);

        public static const ACTIVE:com.garmin.fit.LengthType=new LengthType(SINGLETON_ENFORCER, 1);

        public static const INVALID:com.garmin.fit.LengthType=new LengthType(SINGLETON_ENFORCER, 255);

        public static const VALUES:__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>=new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(3);
    }
}


//    class Manufacturer
package com.garmin.fit 
{
    public class Manufacturer extends Object
    {
        public function Manufacturer()
        {
            super();
            return;
        }

        public static const GARMIN:int=1;

        public static const GARMIN_FR405_ANTFS:int=2;

        public static const ZEPHYR:int=3;

        public static const DAYTON:int=4;

        public static const IDT:int=5;

        public static const SRM:int=6;

        public static const QUARQ:int=7;

        public static const IBIKE:int=8;

        public static const SARIS:int=9;

        public static const SPARK_HK:int=10;

        public static const TANITA:int=11;

        public static const ECHOWELL:int=12;

        public static const DYNASTREAM_OEM:int=13;

        public static const NAUTILUS:int=14;

        public static const DYNASTREAM:int=15;

        public static const TIMEX:int=16;

        public static const METRIGEAR:int=17;

        public static const XELIC:int=18;

        public static const BEURER:int=19;

        public static const CARDIOSPORT:int=20;

        public static const A_AND_D:int=21;

        public static const HMM:int=22;

        public static const SUUNTO:int=23;

        public static const THITA_ELEKTRONIK:int=24;

        public static const GPULSE:int=25;

        public static const CLEAN_MOBILE:int=26;

        public static const PEDAL_BRAIN:int=27;

        public static const PEAKSWARE:int=28;

        public static const SAXONAR:int=29;

        public static const LEMOND_FITNESS:int=30;

        public static const DEXCOM:int=31;

        public static const WAHOO_FITNESS:int=32;

        public static const OCTANE_FITNESS:int=33;

        public static const ARCHINOETICS:int=34;

        public static const THE_HURT_BOX:int=35;

        public static const CITIZEN_SYSTEMS:int=36;

        public static const MAGELLAN:int=37;

        public static const OSYNCE:int=38;

        public static const HOLUX:int=39;

        public static const CONCEPT2:int=40;

        public static const ONE_GIANT_LEAP:int=42;

        public static const ACE_SENSOR:int=43;

        public static const BRIM_BROTHERS:int=44;

        public static const XPLOVA:int=45;

        public static const PERCEPTION_DIGITAL:int=46;

        public static const BF1SYSTEMS:int=47;

        public static const PIONEER:int=48;

        public static const SPANTEC:int=49;

        public static const METALOGICS:int=50;

        public static const _4IIIIS:int=51;

        public static const SEIKO_EPSON:int=52;

        public static const SEIKO_EPSON_OEM:int=53;

        public static const IFOR_POWELL:int=54;

        public static const MAXWELL_GUIDER:int=55;

        public static const STAR_TRAC:int=56;

        public static const BREAKAWAY:int=57;

        public static const ALATECH_TECHNOLOGY_LTD:int=58;

        public static const MIO_TECHNOLOGY_EUROPE:int=59;

        public static const ROTOR:int=60;

        public static const GEONAUTE:int=61;

        public static const ID_BIKE:int=62;

        public static const SPECIALIZED:int=63;

        public static const WTEK:int=64;

        public static const PHYSICAL_ENTERPRISES:int=65;

        public static const NORTH_POLE_ENGINEERING:int=66;

        public static const BKOOL:int=67;

        public static const STAGES_CYCLING:int=69;

        public static const SIGMASPORT:int=70;

        public static const DEVELOPMENT:int=255;

        public static const ACTIGRAPHCORP:int=5759;

        public static const INVALID:int=65535;
    }
}


//    class Mesg
package com.garmin.fit 
{
    import __AS3__.vec.*;
    import flash.filesystem.*;
    import flash.utils.*;
    
    public class Mesg extends flash.utils.Dictionary
    {
        public function Mesg(arg1:*=null, arg2:int=0)
        {
            var loc3:*=null;
            var loc2:*=undefined;
            super();
            this.fields = new __AS3__.vec.Vector.<com.garmin.fit.Field>(0);
            if (arg1 == null) 
            {
                this.name = "unknown";
                this.num = 65535;
                this.systemTimeOffset = 0;
                return;
            }
            if (arg1 is com.garmin.fit.Mesg) 
            {
                loc3 = arg1;
                this.name = loc3.name;
                this.num = loc3.num;
                this.localNum = loc3.localNum;
                this.systemTimeOffset = loc3.systemTimeOffset;
                loc2 = loc3.fields;
                var loc1:*=loc3.fields.length;
                z = 0;
                while (z < loc1) 
                {
                    if (loc2[z].getNumValues() > 0) 
                    {
                        this.fields.push(new com.garmin.fit.Field(loc2[z]));
                    }
                    ++z;
                }
            }
            else if (arg1 is String) 
            {
                this.name = arg1 as String;
                this.num = arg2;
                this.localNum = 0;
                this.fields = new __AS3__.vec.Vector.<com.garmin.fit.Field>(0);
                this.systemTimeOffset = 0;
            }
            return;
        }

        public function write(arg1:flash.filesystem.FileStream, arg2:com.garmin.fit.MesgDefinition):void
        {
            var loc2:*=null;
            var loc1:*=null;
            arg1.writeByte(localNum & 15);
            if (arg2 == null) 
            {
                arg2 = new com.garmin.fit.MesgDefinition(this);
            }
            var loc5:*=0;
            var loc4:*=arg2.fieldsDic;
            for (var loc3:* in loc4) 
            {
                loc2 = arg2.fieldsDic[loc3];
                loc1 = this.getField(loc2.num);
                if (loc1 == null) 
                {
                    loc1 = com.garmin.fit.Factory.createField(num, loc2.num);
                }
                loc1.write(arg1, loc2);
            }
            return;
        }

        public function getName():String
        {
            return name;
        }

        public function getNum():int
        {
            return num;
        }

        public function hasField(arg1:int):Boolean
        {
            var loc1:*=0;
            loc1 = 0;
            while (loc1 < fields.length) 
            {
                if (fields[loc1].num == arg1) 
                {
                    return true;
                }
                ++loc1;
            }
            return false;
        }

        public function addField(arg1:com.garmin.fit.Field):void
        {
            fields.push(arg1);
            return;
        }

        public function setField(arg1:com.garmin.fit.Field):void
        {
            var loc1:*=0;
            loc1 = 0;
            while (loc1 < fields.length) 
            {
                if (fields[loc1].num == arg1.num) 
                {
                    fields[loc1] = arg1;
                    return;
                }
                ++loc1;
            }
            fields.push(arg1);
            return;
        }

        public function setFields(arg1:com.garmin.fit.Mesg):void
        {
            if (arg1.num != num) 
            {
                return;
            }
            var loc3:*=0;
            var loc2:*=arg1.fields;
            for each (var loc1:* in loc2) 
            {
                setField(loc1);
            }
            return;
        }

        public function getNumFields():int
        {
            return fields.length;
        }

        public function getField(arg1:*, arg2:Boolean=true):com.garmin.fit.Field
        {
            var loc1:*=0;
            var loc2:*=null;
            var loc4:*=0;
            var loc3:*=0;
            if (arg1 is int) 
            {
                loc1 = arg1 as int;
                loc3 = 0;
                while (loc3 < fields.length) 
                {
                    if (fields[loc3].num == loc1) 
                    {
                        return fields[loc3];
                    }
                    ++loc3;
                }
            }
            else if (arg1 is String) 
            {
                loc2 = arg1 as String;
                loc3 = 0;
                while (loc3 < fields.length) 
                {
                    if (fields[loc3].name == loc2) 
                    {
                        return fields[loc3];
                    }
                    loc4 = 0;
                    while (loc4 < fields[loc3].subFields.length) 
                    {
                        if (fields[loc3].subFields[loc4].name == loc2 && (!arg2 || fields[loc3].subFields[loc4].canMesgSupport(this))) 
                        {
                            return fields[loc3];
                        }
                        ++loc4;
                    }
                    ++loc3;
                }
            }
            return null;
        }

        public function GetActiveSubFieldIndex(arg1:int):int
        {
            var loc1:*=0;
            var loc2:*=com.garmin.fit.Factory.createField(this.num, arg1);
            if (loc2 == null) 
            {
                return 65535;
            }
            loc1 = 0;
            while (loc1 < loc2.subFields.length) 
            {
                if (loc2.subFields[loc1].canMesgSupport(this)) 
                {
                    return loc1;
                }
                ++loc1;
            }
            return 65535;
        }

        public function GetActiveSubFieldName(arg1:int):String
        {
            var loc1:*=0;
            var loc2:*=com.garmin.fit.Factory.createField(this.num, arg1);
            if (loc2 == null) 
            {
                return com.garmin.fit.Fit.SUBFIELD_NAME_MAIN_FIELD;
            }
            loc1 = 0;
            while (loc1 < loc2.subFields.length) 
            {
                if (loc2.subFields[loc1].canMesgSupport(this)) 
                {
                    return loc2.subFields[loc1].name;
                }
                ++loc1;
            }
            return com.garmin.fit.Fit.SUBFIELD_NAME_MAIN_FIELD;
        }

        public function getNumFieldValues(arg1:*, arg2:*):int
        {
            var loc1:*=null;
            var loc3:*=null;
            var loc2:*=0;
            var loc4:*=null;
            if (arg1) 
            {
                loc1 = getField(arg1);
            }
            else 
            {
                loc1 = getField(name, false);
            }
            if (loc1 == null) 
            {
                return 0;
            }
            if (arg2 is int) 
            {
                if ((loc2 = arg2 as int) == 65534) 
                {
                    return loc1.getNumValues();
                }
                loc3 = loc1.getSubField(loc2);
            }
            else if (arg2 is String) 
            {
                loc4 = arg2 as String;
                loc3 = loc1.getSubField(loc4);
            }
            if (loc3 == null || loc3.canMesgSupport(this)) 
            {
                return loc1.getNumValues();
            }
            return 0;
        }

        public function getFieldValue(arg1:*, arg2:int=-2147483648, arg3:*=null):*
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc6:*=null;
            var loc5:*=null;
            var loc3:*=null;
            var loc4:*=0;
            if (arg1 is int && !(arg2 == -2147483648) && arg3 is String) 
            {
                loc2 = arg1 as int;
                loc6 = arg3 as String;
                if ((loc1 = getField(loc2)) == null) 
                {
                    return null;
                }
                if ((loc5 = loc1.getSubField(loc6)) == null || loc5.canMesgSupport(this)) 
                {
                    return loc1.getValue(arg2, loc6);
                }
                return null;
            }
            if (arg1 is String && arg2 == -2147483648 && arg3 == null) 
            {
                return getFieldValue(loc3, 0);
            }
            if (arg1 is String && !(arg2 == -2147483648) && arg3 == null) 
            {
                loc3 = arg1 as String;
                if ((loc1 = getField(loc3, false)) == null) 
                {
                    return null;
                }
                if ((loc5 = loc1.getSubField(loc3)) == null || loc5.canMesgSupport(this)) 
                {
                    return loc1.getValue(arg2, loc3);
                }
                return null;
            }
            loc2 = arg1 as int;
            if (arg1 is int && arg2 == -2147483648 && arg3 == null) 
            {
                arg2 = 0;
                loc4 = 65534;
            }
            else if (arg1 is int && !(arg2 == -2147483648) && arg3 == null) 
            {
                loc4 = 65534;
            }
            else if (!(arg1 is int && !(arg2 == -2147483648) && !(arg3 == null))) 
            {
                throw new com.garmin.fit.FitRuntimeException("loggingErrorEvent", 1800001, "FITEncoding > Logical Error: Mesg.getFieldValue " + loc3);
            }
            if ((loc1 = getField(loc2)) == null) 
            {
                return null;
            }
            if (loc4 == 65534) 
            {
                return loc1.getValue(arg2, GetActiveSubFieldIndex(loc2));
            }
            if ((loc5 = loc1.getSubField(loc4)) == null || loc5.canMesgSupport(this)) 
            {
                return loc1.getValue(arg2, loc4);
            }
            return null;
        }

        public function setFieldValue(arg1:int, arg2:int, arg3:Object, arg4:int):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=0;
            var loc7:*=null;
            var loc5:*=null;
            var loc6:*=null;
            if (arg3 is String && !(arg3 == null)) 
            {
                loc2 = arg3 as String;
                if ((arg3 as String).length > 63) 
                {
                    (loc3 = new flash.utils.ByteArray()).writeMultiByte(loc2, "utf-8");
                    if (loc3.length > 254) 
                    {
                        loc3.clear();
                        loc4 = 0;
                        while (loc3.position < 252) 
                        {
                            loc3.writeMultiByte(loc2.charAt(loc4++), "utf-8");
                        }
                        loc7 = loc2.slice(0, loc4 - 2) + "...";
                        loc3.clear();
                        loc3.position = 0;
                        loc3.writeMultiByte(loc7, "utf-8");
                        arg3 = loc7;
                    }
                }
            }
            if (arg4 != 65534) 
            {
                if (!((loc6 = (loc5 = com.garmin.fit.Factory.createField(this.num, arg1)).getSubField(arg4)) == null) && !loc6.canMesgSupport(this)) 
                {
                    return;
                }
            }
            else 
            {
                arg4 = GetActiveSubFieldIndex(arg1);
            }
            var loc1:*;
            if ((loc1 = getField(arg1)) == null) 
            {
                loc1 = com.garmin.fit.Factory.createField(this.num, arg1);
                addField(loc1);
            }
            loc1.setValue(arg2, arg3, arg4);
            return;
        }

        public function getFieldIntegerValue(arg1:int, arg2:int, arg3:int):int
        {
            var loc2:*=null;
            var loc1:*;
            if ((loc1 = getField(arg1)) == null) 
            {
                return -2147483648;
            }
            if (arg3 == 65534) 
            {
                return loc1.getIntegerValue(arg2, GetActiveSubFieldIndex(arg1));
            }
            if ((loc2 = loc1.getSubField(arg3)) == null || loc2.canMesgSupport(this)) 
            {
                return loc1.getIntegerValue(arg2, arg3);
            }
            return -2147483648;
        }

        public function getFieldDoubleValue(arg1:int, arg2:int=0, arg3:int=65534):Number
        {
            var loc2:*=null;
            var loc1:*;
            if ((loc1 = getField(arg1)) == null) 
            {
                return NaN;
            }
            if (arg3 == 65534) 
            {
                return loc1.getFloatValue(arg2, GetActiveSubFieldIndex(arg1));
            }
            if ((loc2 = loc1.getSubField(arg3)) == null || loc2.canMesgSupport(this)) 
            {
                return loc1.getFloatValue(arg2, arg3);
            }
            return NaN;
        }

        public function getFieldStringValue(arg1:int, arg2:int, arg3:int):String
        {
            var loc2:*=null;
            var loc1:*;
            if ((loc1 = getField(arg1)) == null) 
            {
                return null;
            }
            if (arg3 == 65534) 
            {
                return loc1.getStringValue(arg2, GetActiveSubFieldIndex(arg1));
            }
            if ((loc2 = loc1.getSubField(arg3)) == null || loc2.canMesgSupport(this)) 
            {
                return loc1.getStringValue(arg2, arg3);
            }
            return null;
        }

        public function getFields():__AS3__.vec.Vector.<com.garmin.fit.Field>
        {
            return fields;
        }

        public function timestampToDateTime(arg1:Number):com.garmin.fit.DateTime
        {
            var loc1:*=null;
            if (!arg1) 
            {
                return null;
            }
            loc1 = new com.garmin.fit.DateTime(null);
            loc1.setTimeStamp(arg1);
            loc1.convertSystemTimeToUTC(systemTimeOffset);
            return loc1;
        }

        public function setLocalNum(arg1:int):void
        {
            if (arg1 >= 16) 
            {
                throw new com.garmin.fit.FitRuntimeException("Invalid local message number " + arg1 + ".  Local message number must be < " + 16 + ".");
            }
            this.localNum = arg1;
            return;
        }

        public function getLocalNum():int
        {
            return localNum;
        }

        public var name:String;

        public var num:int;

        public var localNum:int;

        public var fields:__AS3__.vec.Vector.<com.garmin.fit.Field>;

        public var systemTimeOffset:Number;

        internal var z:uint;
    }
}


//    class MesgCapabilitiesMesg
package com.garmin.fit 
{
    public class MesgCapabilitiesMesg extends com.garmin.fit.Mesg
    {
        public function MesgCapabilitiesMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(38));
            return;
        }

        public function getMessageIndex():int
        {
            return getFieldIntegerValue(254, 0, 65535);
        }

        public function setMessageIndex(arg1:int):void
        {
            setFieldValue(254, 0, arg1, 65535);
            return;
        }

        public function getFile():com.garmin.fit.FITFile
        {
            var loc1:*=getFieldIntegerValue(0, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.FITFile.getByValue(loc1);
        }

        public function setFile(arg1:com.garmin.fit.FITFile):void
        {
            setFieldValue(0, 0, arg1.getValue(), 65535);
            return;
        }

        public function getMesgNum():int
        {
            return getFieldIntegerValue(1, 0, 65535);
        }

        public function setMesgNum(arg1:int):void
        {
            setFieldValue(1, 0, arg1, 65535);
            return;
        }

        public function getCountType():com.garmin.fit.MesgCount
        {
            var loc1:*=getFieldIntegerValue(2, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.MesgCount.getByValue(loc1);
        }

        public function setCountType(arg1:com.garmin.fit.MesgCount):void
        {
            setFieldValue(2, 0, arg1.getValue(), 65535);
            return;
        }

        public function getCount():int
        {
            return getFieldIntegerValue(3, 0, 65535);
        }

        public function setCount(arg1:int):void
        {
            setFieldValue(3, 0, arg1, 65535);
            return;
        }

        public function getNumPerFile():int
        {
            return getFieldIntegerValue(3, 0, 0);
        }

        public function setNumPerFile(arg1:int):void
        {
            setFieldValue(3, 0, arg1, 0);
            return;
        }

        public function getMaxPerFile():int
        {
            return getFieldIntegerValue(3, 0, 1);
        }

        public function setMaxPerFile(arg1:int):void
        {
            setFieldValue(3, 0, arg1, 1);
            return;
        }

        public function getMaxPerFileType():int
        {
            return getFieldIntegerValue(3, 0, 2);
        }

        public function setMaxPerFileType(arg1:int):void
        {
            setFieldValue(3, 0, arg1, 2);
            return;
        }

        public static function get mesgCapabilitiesMesg():com.garmin.fit.Mesg
        {
            return _mesgCapabilitiesMesg;
        }

        
        {
            _mesgCapabilitiesMesg = new com.garmin.fit.Mesg("mesg_capabilities", 38);
            mesgCapabilitiesMesg.addField(new com.garmin.fit.Field("message_index", 254, 132, 1, 0, ""));
            ++field_index;
            mesgCapabilitiesMesg.addField(new com.garmin.fit.Field("file", 0, 0, 1, 0, ""));
            ++field_index;
            mesgCapabilitiesMesg.addField(new com.garmin.fit.Field("mesg_num", 1, 132, 1, 0, ""));
            ++field_index;
            mesgCapabilitiesMesg.addField(new com.garmin.fit.Field("count_type", 2, 0, 1, 0, ""));
            ++field_index;
            mesgCapabilitiesMesg.addField(new com.garmin.fit.Field("count", 3, 132, 1, 0, ""));
            subfield_index = 0;
            mesgCapabilitiesMesg.fields[field_index].subFields.push(new com.garmin.fit.SubField("num_per_file", 132, 1, 0, ""));
            mesgCapabilitiesMesg.fields[field_index].subFields[subfield_index].addMap(2, 0);
            ++subfield_index;
            mesgCapabilitiesMesg.fields[field_index].subFields.push(new com.garmin.fit.SubField("max_per_file", 132, 1, 0, ""));
            mesgCapabilitiesMesg.fields[field_index].subFields[subfield_index].addMap(2, 1);
            ++subfield_index;
            mesgCapabilitiesMesg.fields[field_index].subFields.push(new com.garmin.fit.SubField("max_per_file_type", 132, 1, 0, ""));
            mesgCapabilitiesMesg.fields[field_index].subFields[subfield_index].addMap(2, 2);
            ++subfield_index;
            ++field_index;
        }

        internal static var _mesgCapabilitiesMesg:com.garmin.fit.Mesg;

        internal static var field_index:int=0;

        internal static var subfield_index:int=0;
    }
}


//    class MesgCount
package com.garmin.fit 
{
    import __AS3__.vec.*;
    import avmplus.*;
    import com.garmin.fit.custom.*;
    import flash.errors.*;
    
    public class MesgCount extends com.garmin.fit.custom.BaseType
    {
        public function MesgCount(arg1:Object, arg2:uint)
        {
            super();
            if (arg1 != SINGLETON_ENFORCER) 
            {
                throw new flash.errors.IllegalOperationError("IllegalOperation: Manipulation of type " + avmplus.getQualifiedClassName(this));
            }
            this.value = arg2;
            return;
        }

        public function getAllValues():__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>
        {
            return VALUES;
        }

        public function getInvalid():com.garmin.fit.custom.BaseType
        {
            return INVALID;
        }

        public function getValue():uint
        {
            return value;
        }

        public static function getByValue(arg1:uint):com.garmin.fit.MesgCount
        {
            return com.garmin.fit.custom.BaseType.getByValue(arg1) as MesgCount;
        }

        
        {
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(4)[0] = NUM_PER_FILE;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(4)[1] = MAX_PER_FILE;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(4)[2] = MAX_PER_FILE_TYPE;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(4)[3] = INVALID;
        }

        internal static const SINGLETON_ENFORCER:Object={};

        public static const NUM_PER_FILE:com.garmin.fit.MesgCount=new MesgCount(SINGLETON_ENFORCER, 0);

        public static const MAX_PER_FILE:com.garmin.fit.MesgCount=new MesgCount(SINGLETON_ENFORCER, 1);

        public static const MAX_PER_FILE_TYPE:com.garmin.fit.MesgCount=new MesgCount(SINGLETON_ENFORCER, 2);

        public static const INVALID:com.garmin.fit.MesgCount=new MesgCount(SINGLETON_ENFORCER, 255);

        internal static const VALUES:__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>=new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(4);
    }
}


//    class MesgDefinition
package com.garmin.fit 
{
    import __AS3__.vec.*;
    import flash.filesystem.*;
    import flash.utils.*;
    
    public class MesgDefinition extends Object
    {
        public function MesgDefinition(arg1:com.garmin.fit.Mesg=null)
        {
            var loc1:*=null;
            var loc2:*=undefined;
            super();
            if (arg1 != null) 
            {
                num = arg1.num;
                localNum = arg1.localNum;
            }
            else 
            {
                num = 65535;
                localNum = 0;
            }
            arch = 1;
            if (localNum >= 16) 
            {
                throw new com.garmin.fit.FitRuntimeException("Invalid local message number " + localNum + ".  Local message number must be < " + 16 + ".");
            }
            fieldsDic = new flash.utils.Dictionary();
            if (arg1 != null) 
            {
                loc2 = arg1.fields;
                fieldsLength = loc2.length;
                z = 0;
                while (z < fieldsLength) 
                {
                    loc1 = loc2[z];
                    fieldsDic[loc1.num] = new com.garmin.fit.FieldDefinition(loc1);
                    ++z;
                }
            }
            return;
        }

        public function getNum():int
        {
            return num;
        }

        public function getLocalNum():int
        {
            return localNum;
        }

        public function getArch():int
        {
            return arch;
        }

        public function getField(arg1:int):com.garmin.fit.FieldDefinition
        {
            return fieldsDic[arg1];
        }

        public function addField(arg1:com.garmin.fit.FieldDefinition):void
        {
            fieldsDic[fieldsLength] = arg1;
            ++fieldsLength;
            return;
        }

        public function write(arg1:flash.filesystem.FileStream):void
        {
            arg1.writeByte(64 | localNum & 15);
            arg1.writeByte(0);
            arg1.writeByte(1);
            arg1.writeByte(num >> 8);
            arg1.writeByte(num);
            arg1.writeByte(fieldsLength);
            var loc3:*=0;
            var loc2:*=fieldsDic;
            for each (var loc1:* in loc2) 
            {
                loc1.write(arg1);
            }
            return;
        }

        public function supports(arg1:com.garmin.fit.Mesg):Boolean
        {
            var loc1:*=null;
            var loc3:*=null;
            var loc2:*=null;
            var loc4:*;
            if ((loc4 = new com.garmin.fit.MesgDefinition(arg1)) == null) 
            {
                return false;
            }
            if (num != loc4.num) 
            {
                return false;
            }
            if (localNum != loc4.localNum) 
            {
                return false;
            }
            var loc7:*=0;
            var loc6:*=loc1;
            for (var loc5:* in loc6) 
            {
                loc3 = loc1[loc5];
                loc2 = getField(loc3.num);
                if (loc2 == null) 
                {
                    return false;
                }
                if (!(loc3.size > loc2.size)) 
                {
                    continue;
                }
                return false;
            }
            return true;
        }

        public function equals(arg1:*):Boolean
        {
            if (this == arg1) 
            {
                return true;
            }
            if (!(arg1 is com.garmin.fit.MesgDefinition)) 
            {
                return false;
            }
            var loc1:*=com.garmin.fit.MesgDefinition(arg1);
            if (num != loc1.num) 
            {
                return false;
            }
            if (localNum != loc1.localNum) 
            {
                return false;
            }
            if (fieldsLength != loc1.fieldsLength) 
            {
                return false;
            }
            var loc2:*=loc1.fieldsDic;
            var loc5:*=0;
            var loc4:*=fieldsDic;
            for (var loc3:* in loc4) 
            {
                if (!(fieldsDic[loc3] == loc2[loc3])) 
                {
                    continue;
                }
                return false;
            }
            return true;
        }

        public function get fieldsDic():flash.utils.Dictionary
        {
            return _fieldsDic;
        }

        public function set fieldsDic(arg1:flash.utils.Dictionary):void
        {
            _fieldsDic = arg1;
            return;
        }

        internal static const FIELD_DEFINITION_NUM:String="FIELD_NUM";

        public var num:int;

        public var localNum:int;

        public var arch:int;

        internal var _fieldsDic:flash.utils.Dictionary;

        public var fieldsLength:uint;

        internal var z:uint;
    }
}


//    class MesgDefinitionListener
package com.garmin.fit 
{
    public dynamic interface MesgDefinitionListener
    {
        function onMesgDefinition(arg1:*):void;
    }
}


//    class MesgListener
package com.garmin.fit 
{
    public dynamic interface MesgListener
    {
        function onMesg(arg1:*):void;
    }
}


//    class MesgNum
package com.garmin.fit 
{
    public class MesgNum extends Object
    {
        public function MesgNum()
        {
            super();
            return;
        }

        public static const FILE_ID:int=0;

        public static const CAPABILITIES:int=1;

        public static const DEVICE_SETTINGS:int=2;

        public static const USER_PROFILE:int=3;

        public static const HRM_PROFILE:int=4;

        public static const SDM_PROFILE:int=5;

        public static const BIKE_PROFILE:int=6;

        public static const ZONES_TARGET:int=7;

        public static const HR_ZONE:int=8;

        public static const POWER_ZONE:int=9;

        public static const MET_ZONE:int=10;

        public static const SPORT:int=12;

        public static const GOAL:int=15;

        public static const SESSION:int=18;

        public static const LAP:int=19;

        public static const RECORD:int=20;

        public static const EVENT:int=21;

        public static const DEVICE_INFO:int=23;

        public static const WORKOUT:int=26;

        public static const WORKOUT_STEP:int=27;

        public static const SCHEDULE:int=28;

        public static const WEIGHT_SCALE:int=30;

        public static const COURSE:int=31;

        public static const COURSE_POINT:int=32;

        public static const TOTALS:int=33;

        public static const ACTIVITY:int=34;

        public static const SOFTWARE:int=35;

        public static const FILE_CAPABILITIES:int=37;

        public static const MESG_CAPABILITIES:int=38;

        public static const FIELD_CAPABILITIES:int=39;

        public static const FILE_CREATOR:int=49;

        public static const BLOOD_PRESSURE:int=51;

        public static const SPEED_ZONE:int=53;

        public static const MONITORING:int=55;

        public static const HRV:int=78;

        public static const LENGTH:int=101;

        public static const MONITORING_INFO:int=103;

        public static const PAD:int=105;

        public static const SLAVE_DEVICE:int=106;

        public static const CADENCE_ZONE:int=131;

        public static const SIGMARECORD:int=65280;

        public static const SIGMALOG:int=65281;

        public static const SIGMALAP:int=65282;

        public static const SIGMABREAK:int=65283;

        public static const MFG_RANGE_MAX:int=65534;

        public static const INVALID:int=65535;
    }
}


//    class MesgWithEvent
package com.garmin.fit 
{
    public dynamic interface MesgWithEvent
    {
        function getTimestamp():com.garmin.fit.DateTime;

        function setTimestamp(arg1:com.garmin.fit.DateTime):void;

        function getEvent():com.garmin.fit.FITEvent;

        function setEvent(arg1:com.garmin.fit.FITEvent):void;

        function getEventType():com.garmin.fit.EventType;

        function setEventType(arg1:com.garmin.fit.EventType):void;

        function getEventGroup():int;

        function setEventGroup(arg1:int):void;
    }
}


//    class MetZoneMesg
package com.garmin.fit 
{
    public class MetZoneMesg extends com.garmin.fit.Mesg
    {
        public function MetZoneMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(10));
            return;
        }

        public function getMessageIndex():int
        {
            return getFieldIntegerValue(254, 0, 65535);
        }

        public function setMessageIndex(arg1:int):void
        {
            setFieldValue(254, 0, arg1, 65535);
            return;
        }

        public function getHighBpm():int
        {
            return getFieldIntegerValue(1, 0, 65535);
        }

        public function setHighBpm(arg1:int):void
        {
            setFieldValue(1, 0, arg1, 65535);
            return;
        }

        public function getCalories():Number
        {
            return getFieldDoubleValue(2, 0, 65535);
        }

        public function setCalories(arg1:Number):void
        {
            setFieldValue(2, 0, arg1, 65535);
            return;
        }

        public function getFatCalories():Number
        {
            return getFieldDoubleValue(3, 0, 65535);
        }

        public function setFatCalories(arg1:Number):void
        {
            setFieldValue(3, 0, arg1, 65535);
            return;
        }

        public static function get metZoneMesg():com.garmin.fit.Mesg
        {
            return _metZoneMesg;
        }

        
        {
            _metZoneMesg = new com.garmin.fit.Mesg("met_zone", 10);
            metZoneMesg.addField(new com.garmin.fit.Field("message_index", 254, 132, 1, 0, ""));
            metZoneMesg.addField(new com.garmin.fit.Field("high_bpm", 1, 2, 1, 0, ""));
            metZoneMesg.addField(new com.garmin.fit.Field("calories", 2, 132, 10, 0, "kcal / min"));
            metZoneMesg.addField(new com.garmin.fit.Field("fat_calories", 3, 2, 10, 0, "kcal / min"));
        }

        internal static var _metZoneMesg:com.garmin.fit.Mesg;
    }
}


//    class MonitoringInfoMesg
package com.garmin.fit 
{
    public class MonitoringInfoMesg extends com.garmin.fit.Mesg
    {
        public function MonitoringInfoMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(103));
            return;
        }

        public function getTimestamp():com.garmin.fit.DateTime
        {
            return timestampToDateTime(getFieldDoubleValue(253, 0, 65535));
        }

        public function setTimestamp(arg1:com.garmin.fit.DateTime):void
        {
            setFieldValue(253, 0, arg1.getTimestamp(), 65535);
            return;
        }

        public function getLocalTimestamp():Number
        {
            return getFieldDoubleValue(0, 0, 65535);
        }

        public function setLocalTimestamp(arg1:Number):void
        {
            setFieldValue(0, 0, arg1, 65535);
            return;
        }

        public static function get monitoringInfoMesg():com.garmin.fit.Mesg
        {
            return _monitoringInfoMesg;
        }

        
        {
            _monitoringInfoMesg = new com.garmin.fit.Mesg("monitoring_info", 103);
            monitoringInfoMesg.addField(new com.garmin.fit.Field("timestamp", 253, 134, 1, 0, ""));
            monitoringInfoMesg.addField(new com.garmin.fit.Field("local_timestamp", 0, 134, 1, 0, ""));
        }

        internal static var _monitoringInfoMesg:com.garmin.fit.Mesg;
    }
}


//    class MonitoringMesg
package com.garmin.fit 
{
    public class MonitoringMesg extends com.garmin.fit.Mesg
    {
        public function MonitoringMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(55));
            return;
        }

        public function getTimestamp():com.garmin.fit.DateTime
        {
            return timestampToDateTime(getFieldDoubleValue(253, 0, 65535));
        }

        public function setTimestamp(arg1:com.garmin.fit.DateTime):void
        {
            setFieldValue(253, 0, arg1.getTimestamp(), 65535);
            return;
        }

        public function getDeviceIndex():int
        {
            return getFieldIntegerValue(0, 0, 65535);
        }

        public function setDeviceIndex(arg1:int):void
        {
            setFieldValue(0, 0, arg1, 65535);
            return;
        }

        public function getCalories():int
        {
            return getFieldIntegerValue(1, 0, 65535);
        }

        public function setCalories(arg1:int):void
        {
            setFieldValue(1, 0, arg1, 65535);
            return;
        }

        public function getDistance():Number
        {
            return getFieldDoubleValue(2, 0, 65535);
        }

        public function setDistance(arg1:Number):void
        {
            setFieldValue(2, 0, arg1, 65535);
            return;
        }

        public function getCycles():Number
        {
            return getFieldDoubleValue(3, 0, 65535);
        }

        public function setCycles(arg1:Number):void
        {
            setFieldValue(3, 0, arg1, 65535);
            return;
        }

        public function getActiveTime():Number
        {
            return getFieldDoubleValue(4, 0, 65535);
        }

        public function setActiveTime(arg1:Number):void
        {
            setFieldValue(4, 0, arg1, 65535);
            return;
        }

        public function getCompressedDistance():int
        {
            return getFieldIntegerValue(8, 0, 65535);
        }

        public function setCompressedDistance(arg1:int):void
        {
            setFieldValue(8, 0, arg1, 65535);
            return;
        }

        public function getCompressedCycles():int
        {
            return getFieldIntegerValue(9, 0, 65535);
        }

        public function setCompressedCycles(arg1:int):void
        {
            setFieldValue(9, 0, arg1, 65535);
            return;
        }

        public function getCompressedActiveTime():int
        {
            return getFieldIntegerValue(10, 0, 65535);
        }

        public function setCompressedActiveTime(arg1:int):void
        {
            setFieldValue(10, 0, arg1, 65535);
            return;
        }

        public function getLocalTimestamp():Number
        {
            return getFieldDoubleValue(11, 0, 65535);
        }

        public function setLocalTimestamp(arg1:Number):void
        {
            setFieldValue(11, 0, arg1, 65535);
            return;
        }

        public static function get monitoringMesg():com.garmin.fit.Mesg
        {
            return _monitoringMesg;
        }

        
        {
            _monitoringMesg = new com.garmin.fit.Mesg("monitoring", 55);
            monitoringMesg.addField(new com.garmin.fit.Field("timestamp", 253, 134, 1, 0, "s"));
            ++field_index;
            monitoringMesg.addField(new com.garmin.fit.Field("device_index", 0, 2, 1, 0, ""));
            ++field_index;
            monitoringMesg.addField(new com.garmin.fit.Field("calories", 1, 132, 1, 0, "kcal"));
            ++field_index;
            monitoringMesg.addField(new com.garmin.fit.Field("distance", 2, 134, 100, 0, "m"));
            ++field_index;
            monitoringMesg.addField(new com.garmin.fit.Field("cycles", 3, 134, 1, 0, "cycles"));
            ++field_index;
            monitoringMesg.addField(new com.garmin.fit.Field("active_time", 4, 134, 1000, 0, "s"));
            ++field_index;
            monitoringMesg.addField(new com.garmin.fit.Field("activity_type", 5, 0, 1, 0, ""));
            ++field_index;
            monitoringMesg.addField(new com.garmin.fit.Field("activity_subtype", 6, 0, 1, 0, ""));
            ++field_index;
            monitoringMesg.addField(new com.garmin.fit.Field("compressed_distance", 8, 132, 1, 0, ""));
            monitoringMesg.fields[field_index].components.push(new com.garmin.fit.FieldComponent(2, true, 16, 100, 0));
            ++field_index;
            monitoringMesg.addField(new com.garmin.fit.Field("compressed_cycles", 9, 132, 1, 0, ""));
            monitoringMesg.fields[field_index].components.push(new com.garmin.fit.FieldComponent(3, true, 16, 1, 0));
            ++field_index;
            monitoringMesg.addField(new com.garmin.fit.Field("compressed_active_time", 10, 132, 1, 0, ""));
            monitoringMesg.fields[field_index].components.push(new com.garmin.fit.FieldComponent(4, true, 16, 1, 0));
            ++field_index;
            monitoringMesg.addField(new com.garmin.fit.Field("local_timestamp", 11, 134, 1, 0, ""));
            ++field_index;
        }

        internal static var _monitoringMesg:com.garmin.fit.Mesg;

        internal static var field_index:int=0;
    }
}


//    class PadMesg
package com.garmin.fit 
{
    public class PadMesg extends com.garmin.fit.Mesg
    {
        public function PadMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(105));
            return;
        }

        public static function get padMesg():com.garmin.fit.Mesg
        {
            return _padMesg;
        }

        
        {
            _padMesg = new com.garmin.fit.Mesg("pad", 105);
        }

        internal static var _padMesg:com.garmin.fit.Mesg;
    }
}


//    class PowerZoneMesg
package com.garmin.fit 
{
    public class PowerZoneMesg extends com.garmin.fit.Mesg
    {
        public function PowerZoneMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(9));
            return;
        }

        public function getMessageIndex():int
        {
            return getFieldIntegerValue(254, 0, 65535);
        }

        public function setMessageIndex(arg1:int):void
        {
            setFieldValue(254, 0, arg1, 65535);
            return;
        }

        public function getHighValue():int
        {
            return getFieldIntegerValue(1, 0, 65535);
        }

        public function setHighValue(arg1:int):void
        {
            setFieldValue(1, 0, arg1, 65535);
            return;
        }

        public override function getName():String
        {
            return getFieldStringValue(2, 0, 65535);
        }

        public function setName(arg1:String):void
        {
            setFieldValue(2, 0, arg1, 65535);
            return;
        }

        public static function get powerZoneMesg():com.garmin.fit.Mesg
        {
            return _powerZoneMesg;
        }

        
        {
            _powerZoneMesg = new com.garmin.fit.Mesg("power_zone", 9);
            powerZoneMesg.addField(new com.garmin.fit.Field("message_index", 254, 132, 1, 0, ""));
            powerZoneMesg.addField(new com.garmin.fit.Field("high_value", 1, 132, 1, 0, "watts"));
            powerZoneMesg.addField(new com.garmin.fit.Field("name", 2, 7, 1, 0, ""));
        }

        internal static var _powerZoneMesg:com.garmin.fit.Mesg;
    }
}


//    class Profile
package com.garmin.fit 
{
    public class Profile extends Object
    {
        public function Profile()
        {
            super();
            return;
        }

        public static const FILE_ID_MESG_PRODUCT_FIELD_GARMIN_PRODUCT:int=0;

        public static const FILE_ID_MESG_PRODUCT_FIELD_SUBFIELDS:int=1;

        public static const FILE_ID_MESG_PRODUCT_FIELD_ACTIVE_SUBFIELD:int=65534;

        public static const FILE_ID_MESG_PRODUCT_FIELD_MAIN_FIELD:int=65535;

        public static const SLAVE_DEVICE_MESG_PRODUCT_FIELD_GARMIN_PRODUCT:int=0;

        public static const SLAVE_DEVICE_MESG_PRODUCT_FIELD_SUBFIELDS:int=1;

        public static const SLAVE_DEVICE_MESG_PRODUCT_FIELD_ACTIVE_SUBFIELD:int=65534;

        public static const SLAVE_DEVICE_MESG_PRODUCT_FIELD_MAIN_FIELD:int=65535;

        public static const MESG_CAPABILITIES_MESG_COUNT_FIELD_NUM_PER_FILE:int=0;

        public static const MESG_CAPABILITIES_MESG_COUNT_FIELD_MAX_PER_FILE:int=1;

        public static const MESG_CAPABILITIES_MESG_COUNT_FIELD_MAX_PER_FILE_TYPE:int=2;

        public static const MESG_CAPABILITIES_MESG_COUNT_FIELD_SUBFIELDS:int=3;

        public static const MESG_CAPABILITIES_MESG_COUNT_FIELD_ACTIVE_SUBFIELD:int=65534;

        public static const MESG_CAPABILITIES_MESG_COUNT_FIELD_MAIN_FIELD:int=65535;

        public static const SESSION_MESG_TOTAL_CYCLES_FIELD_TOTAL_STRIDES:int=0;

        public static const SESSION_MESG_TOTAL_CYCLES_FIELD_SUBFIELDS:int=1;

        public static const SESSION_MESG_TOTAL_CYCLES_FIELD_ACTIVE_SUBFIELD:int=65534;

        public static const SESSION_MESG_TOTAL_CYCLES_FIELD_MAIN_FIELD:int=65535;

        public static const SESSION_MESG_AVG_CADENCE_FIELD_AVG_RUNNING_CADENCE:int=0;

        public static const SESSION_MESG_AVG_CADENCE_FIELD_SUBFIELDS:int=1;

        public static const SESSION_MESG_AVG_CADENCE_FIELD_ACTIVE_SUBFIELD:int=65534;

        public static const SESSION_MESG_AVG_CADENCE_FIELD_MAIN_FIELD:int=65535;

        public static const SESSION_MESG_MAX_CADENCE_FIELD_MAX_RUNNING_CADENCE:int=0;

        public static const SESSION_MESG_MAX_CADENCE_FIELD_SUBFIELDS:int=1;

        public static const SESSION_MESG_MAX_CADENCE_FIELD_ACTIVE_SUBFIELD:int=65534;

        public static const SESSION_MESG_MAX_CADENCE_FIELD_MAIN_FIELD:int=65535;

        public static const LAP_MESG_TOTAL_CYCLES_FIELD_TOTAL_STRIDES:int=0;

        public static const LAP_MESG_TOTAL_CYCLES_FIELD_SUBFIELDS:int=1;

        public static const LAP_MESG_TOTAL_CYCLES_FIELD_ACTIVE_SUBFIELD:int=65534;

        public static const LAP_MESG_TOTAL_CYCLES_FIELD_MAIN_FIELD:int=65535;

        public static const LAP_MESG_AVG_CADENCE_FIELD_AVG_RUNNING_CADENCE:int=0;

        public static const LAP_MESG_AVG_CADENCE_FIELD_SUBFIELDS:int=1;

        public static const LAP_MESG_AVG_CADENCE_FIELD_ACTIVE_SUBFIELD:int=65534;

        public static const LAP_MESG_AVG_CADENCE_FIELD_MAIN_FIELD:int=65535;

        public static const LAP_MESG_MAX_CADENCE_FIELD_MAX_RUNNING_CADENCE:int=0;

        public static const LAP_MESG_MAX_CADENCE_FIELD_SUBFIELDS:int=1;

        public static const LAP_MESG_MAX_CADENCE_FIELD_ACTIVE_SUBFIELD:int=65534;

        public static const LAP_MESG_MAX_CADENCE_FIELD_MAIN_FIELD:int=65535;

        public static const EVENT_MESG_DATA_FIELD_TIMER_TRIGGER:int=0;

        public static const EVENT_MESG_DATA_FIELD_COURSE_POINT_INDEX:int=1;

        public static const EVENT_MESG_DATA_FIELD_BATTERY_LEVEL:int=2;

        public static const EVENT_MESG_DATA_FIELD_VIRTUAL_PARTNER_SPEED:int=3;

        public static const EVENT_MESG_DATA_FIELD_HR_HIGH_ALERT:int=4;

        public static const EVENT_MESG_DATA_FIELD_HR_LOW_ALERT:int=5;

        public static const EVENT_MESG_DATA_FIELD_SPEED_HIGH_ALERT:int=6;

        public static const EVENT_MESG_DATA_FIELD_SPEED_LOW_ALERT:int=7;

        public static const EVENT_MESG_DATA_FIELD_CAD_HIGH_ALERT:int=8;

        public static const EVENT_MESG_DATA_FIELD_CAD_LOW_ALERT:int=9;

        public static const EVENT_MESG_DATA_FIELD_POWER_HIGH_ALERT:int=10;

        public static const EVENT_MESG_DATA_FIELD_POWER_LOW_ALERT:int=11;

        public static const EVENT_MESG_DATA_FIELD_TIME_DURATION_ALERT:int=12;

        public static const EVENT_MESG_DATA_FIELD_DISTANCE_DURATION_ALERT:int=13;

        public static const EVENT_MESG_DATA_FIELD_CALORIE_DURATION_ALERT:int=14;

        public static const EVENT_MESG_DATA_FIELD_FITNESS_EQUIPMENT_STATE:int=15;

        public static const EVENT_MESG_DATA_FIELD_SUBFIELDS:int=16;

        public static const EVENT_MESG_DATA_FIELD_ACTIVE_SUBFIELD:int=65534;

        public static const EVENT_MESG_DATA_FIELD_MAIN_FIELD:int=65535;

        public static const WORKOUT_STEP_MESG_DURATION_VALUE_FIELD_DURATION_TIME:int=0;

        public static const WORKOUT_STEP_MESG_DURATION_VALUE_FIELD_DURATION_DISTANCE:int=1;

        public static const WORKOUT_STEP_MESG_DURATION_VALUE_FIELD_DURATION_HR:int=2;

        public static const WORKOUT_STEP_MESG_DURATION_VALUE_FIELD_DURATION_CALORIES:int=3;

        public static const WORKOUT_STEP_MESG_DURATION_VALUE_FIELD_DURATION_STEP:int=4;

        public static const WORKOUT_STEP_MESG_DURATION_VALUE_FIELD_DURATION_POWER:int=5;

        public static const WORKOUT_STEP_MESG_DURATION_VALUE_FIELD_SUBFIELDS:int=6;

        public static const WORKOUT_STEP_MESG_DURATION_VALUE_FIELD_ACTIVE_SUBFIELD:int=65534;

        public static const WORKOUT_STEP_MESG_DURATION_VALUE_FIELD_MAIN_FIELD:int=65535;

        public static const WORKOUT_STEP_MESG_TARGET_VALUE_FIELD_TARGET_HR_ZONE:int=0;

        public static const WORKOUT_STEP_MESG_TARGET_VALUE_FIELD_TARGET_POWER_ZONE:int=1;

        public static const WORKOUT_STEP_MESG_TARGET_VALUE_FIELD_REPEAT_STEPS:int=2;

        public static const WORKOUT_STEP_MESG_TARGET_VALUE_FIELD_REPEAT_TIME:int=3;

        public static const WORKOUT_STEP_MESG_TARGET_VALUE_FIELD_REPEAT_DISTANCE:int=4;

        public static const WORKOUT_STEP_MESG_TARGET_VALUE_FIELD_REPEAT_CALORIES:int=5;

        public static const WORKOUT_STEP_MESG_TARGET_VALUE_FIELD_REPEAT_HR:int=6;

        public static const WORKOUT_STEP_MESG_TARGET_VALUE_FIELD_REPEAT_POWER:int=7;

        public static const WORKOUT_STEP_MESG_TARGET_VALUE_FIELD_SUBFIELDS:int=8;

        public static const WORKOUT_STEP_MESG_TARGET_VALUE_FIELD_ACTIVE_SUBFIELD:int=65534;

        public static const WORKOUT_STEP_MESG_TARGET_VALUE_FIELD_MAIN_FIELD:int=65535;

        public static const WORKOUT_STEP_MESG_CUSTOM_TARGET_VALUE_LOW_FIELD_CUSTOM_TARGET_SPEED_LOW:int=0;

        public static const WORKOUT_STEP_MESG_CUSTOM_TARGET_VALUE_LOW_FIELD_CUSTOM_TARGET_HEART_RATE_LOW:int=1;

        public static const WORKOUT_STEP_MESG_CUSTOM_TARGET_VALUE_LOW_FIELD_CUSTOM_TARGET_CADENCE_LOW:int=2;

        public static const WORKOUT_STEP_MESG_CUSTOM_TARGET_VALUE_LOW_FIELD_CUSTOM_TARGET_POWER_LOW:int=3;

        public static const WORKOUT_STEP_MESG_CUSTOM_TARGET_VALUE_LOW_FIELD_SUBFIELDS:int=4;

        public static const WORKOUT_STEP_MESG_CUSTOM_TARGET_VALUE_LOW_FIELD_ACTIVE_SUBFIELD:int=65534;

        public static const WORKOUT_STEP_MESG_CUSTOM_TARGET_VALUE_LOW_FIELD_MAIN_FIELD:int=65535;

        public static const WORKOUT_STEP_MESG_CUSTOM_TARGET_VALUE_HIGH_FIELD_CUSTOM_TARGET_SPEED_HIGH:int=0;

        public static const WORKOUT_STEP_MESG_CUSTOM_TARGET_VALUE_HIGH_FIELD_CUSTOM_TARGET_HEART_RATE_HIGH:int=1;

        public static const WORKOUT_STEP_MESG_CUSTOM_TARGET_VALUE_HIGH_FIELD_CUSTOM_TARGET_CADENCE_HIGH:int=2;

        public static const WORKOUT_STEP_MESG_CUSTOM_TARGET_VALUE_HIGH_FIELD_CUSTOM_TARGET_POWER_HIGH:int=3;

        public static const WORKOUT_STEP_MESG_CUSTOM_TARGET_VALUE_HIGH_FIELD_SUBFIELDS:int=4;

        public static const WORKOUT_STEP_MESG_CUSTOM_TARGET_VALUE_HIGH_FIELD_ACTIVE_SUBFIELD:int=65534;

        public static const WORKOUT_STEP_MESG_CUSTOM_TARGET_VALUE_HIGH_FIELD_MAIN_FIELD:int=65535;

        public static const SCHEDULE_MESG_PRODUCT_FIELD_GARMIN_PRODUCT:int=0;

        public static const SCHEDULE_MESG_PRODUCT_FIELD_SUBFIELDS:int=1;

        public static const SCHEDULE_MESG_PRODUCT_FIELD_ACTIVE_SUBFIELD:int=65534;

        public static const SCHEDULE_MESG_PRODUCT_FIELD_MAIN_FIELD:int=65535;
    }
}


//    class PwrZoneCalc
package com.garmin.fit 
{
    import __AS3__.vec.*;
    import avmplus.*;
    import com.garmin.fit.custom.*;
    import flash.errors.*;
    
    public class PwrZoneCalc extends com.garmin.fit.custom.BaseType
    {
        public function PwrZoneCalc(arg1:Object, arg2:uint)
        {
            super();
            if (arg1 != SINGLETON_ENFORCER) 
            {
                throw new flash.errors.IllegalOperationError("IllegalOperation: Manipulation of type " + avmplus.getQualifiedClassName(this));
            }
            this.value = arg2;
            return;
        }

        public function getAllValues():__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>
        {
            return VALUES;
        }

        public function getInvalid():com.garmin.fit.custom.BaseType
        {
            return INVALID;
        }

        public function getValue():uint
        {
            return value;
        }

        public static function getByValue(arg1:uint):com.garmin.fit.PwrZoneCalc
        {
            return com.garmin.fit.custom.BaseType.getByValue(arg1) as PwrZoneCalc;
        }

        
        {
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(3)[0] = CUSTOM;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(3)[1] = PERCENT_FTP;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(3)[2] = INVALID;
        }

        internal static const SINGLETON_ENFORCER:Object={};

        public static const CUSTOM:com.garmin.fit.PwrZoneCalc=new PwrZoneCalc(SINGLETON_ENFORCER, 0);

        public static const PERCENT_FTP:com.garmin.fit.PwrZoneCalc=new PwrZoneCalc(SINGLETON_ENFORCER, 1);

        public static const INVALID:com.garmin.fit.PwrZoneCalc=new PwrZoneCalc(SINGLETON_ENFORCER, 255);

        public static const VALUES:__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>=new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(3);
    }
}


//    class RecordMesg
package com.garmin.fit 
{
    public class RecordMesg extends com.garmin.fit.Mesg
    {
        public function RecordMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(20));
            return;
        }

        public function getTimestamp():com.garmin.fit.DateTime
        {
            return timestampToDateTime(getFieldDoubleValue(253, 0, 65535));
        }

        public function setTimestamp(arg1:com.garmin.fit.DateTime):void
        {
            setFieldValue(253, 0, arg1.getTimestamp(), 65535);
            return;
        }

        public function getPositionLat():int
        {
            return getFieldIntegerValue(0, 0, 65535);
        }

        public function setPositionLat(arg1:int):void
        {
            setFieldValue(0, 0, arg1, 65535);
            return;
        }

        public function getPositionLong():int
        {
            return getFieldDoubleValue(1, 0, 65535);
        }

        public function setPositionLong(arg1:int):void
        {
            setFieldValue(1, 0, arg1, 65535);
            return;
        }

        public function getAltitude():Number
        {
            return getFieldDoubleValue(2, 0, 65535);
        }

        public function setAltitude(arg1:Number):void
        {
            setFieldValue(2, 0, arg1, 65535);
            return;
        }

        public function getHeartRate():int
        {
            return getFieldIntegerValue(3, 0, 65535);
        }

        public function setHeartRate(arg1:int):void
        {
            setFieldValue(3, 0, arg1, 65535);
            return;
        }

        public function getCadence():int
        {
            return getFieldIntegerValue(4, 0, 65535);
        }

        public function setCadence(arg1:int):void
        {
            setFieldValue(4, 0, arg1, 65535);
            return;
        }

        public function getDistance():Number
        {
            return getFieldDoubleValue(5, 0, 65535);
        }

        public function setDistance(arg1:Number):void
        {
            setFieldValue(5, 0, arg1, 65535);
            return;
        }

        public function getSpeed():Number
        {
            return getFieldDoubleValue(6, 0, 65535);
        }

        public function setSpeed(arg1:Number):void
        {
            setFieldValue(6, 0, arg1, 65535);
            return;
        }

        public function getPower():int
        {
            return getFieldIntegerValue(7, 0, 65535);
        }

        public function setPower(arg1:int):void
        {
            setFieldValue(7, 0, arg1, 65535);
            return;
        }

        public function getNumCompressedSpeedDistance():int
        {
            return getNumFieldValues(8, 65535);
        }

        public function getCompressedSpeedDistance(arg1:int):int
        {
            return getFieldIntegerValue(8, arg1, 65535);
        }

        public function setCompressedSpeedDistance(arg1:int, arg2:int):void
        {
            setFieldValue(8, arg1, arg2, 65535);
            return;
        }

        public function getGrade():Number
        {
            return getFieldDoubleValue(9, 0, 65535);
        }

        public function setGrade(arg1:Number):void
        {
            setFieldValue(9, 0, arg1, 65535);
            return;
        }

        public function getResistance():int
        {
            return getFieldIntegerValue(10, 0, 65535);
        }

        public function setResistance(arg1:int):void
        {
            setFieldValue(10, 0, arg1, 65535);
            return;
        }

        public function getTimeFromCourse():Number
        {
            return getFieldDoubleValue(11, 0, 65535);
        }

        public function setTimeFromCourse(arg1:Number):void
        {
            setFieldValue(11, 0, arg1, 65535);
            return;
        }

        public function getCycleLength():Number
        {
            return getFieldDoubleValue(12, 0, 65535);
        }

        public function setCycleLength(arg1:Number):void
        {
            setFieldValue(12, 0, arg1, 65535);
            return;
        }

        public function getTemperature():int
        {
            return getFieldIntegerValue(13, 0, 65535);
        }

        public function setTemperature(arg1:int):void
        {
            setFieldValue(13, 0, arg1, 65535);
            return;
        }

        public function getNumSpeed1s():int
        {
            return getNumFieldValues(17, 65535);
        }

        public function getSpeed1s(arg1:int):Number
        {
            return getFieldDoubleValue(17, arg1, 65535);
        }

        public function setSpeed1s(arg1:int, arg2:Number):void
        {
            setFieldValue(17, arg1, arg2, 65535);
            return;
        }

        public function getCycles():int
        {
            return getFieldIntegerValue(18, 0, 65535);
        }

        public function setCycles(arg1:int):void
        {
            setFieldValue(18, 0, arg1, 65535);
            return;
        }

        public function getTotalCycles():Number
        {
            return getFieldDoubleValue(19, 0, 65535);
        }

        public function setTotalCycles(arg1:Number):void
        {
            setFieldValue(19, 0, arg1, 65535);
            return;
        }

        public function getCompressedAccumulatedPower():int
        {
            return getFieldIntegerValue(28, 0, 65535);
        }

        public function setCompressedAccumulatedPower(arg1:int):void
        {
            setFieldValue(28, 0, arg1, 65535);
            return;
        }

        public function getAccumulatedPower():Number
        {
            return getFieldDoubleValue(29, 0, 65535);
        }

        public function setAccumulatedPower(arg1:Number):void
        {
            setFieldValue(29, 0, arg1, 65535);
            return;
        }

        public function getLeftRightBalance():int
        {
            return getFieldIntegerValue(30, 0, 65535);
        }

        public function setLeftRightBalance(arg1:int):void
        {
            setFieldValue(30, 0, arg1, 65535);
            return;
        }

        public function getGpsAccuracy():int
        {
            return getFieldIntegerValue(31, 0, 65535);
        }

        public function setGpsAccuracy(arg1:int):void
        {
            setFieldValue(31, 0, arg1, 65535);
            return;
        }

        public function getVerticalSpeed():Number
        {
            return getFieldDoubleValue(32, 0, 65535);
        }

        public function setVerticalSpeed(arg1:Number):void
        {
            setFieldValue(32, 0, arg1, 65535);
            return;
        }

        public function getCalories():int
        {
            return getFieldIntegerValue(33, 0, 65535);
        }

        public function setCalories(arg1:int):void
        {
            setFieldValue(33, 0, arg1, 65535);
            return;
        }

        public function getLeftTorqueEffectiveness():Number
        {
            return getFieldDoubleValue(43, 0, 65535);
        }

        public function setLeftTorqueEffectiveness(arg1:Number):void
        {
            setFieldValue(43, 0, arg1, 65535);
            return;
        }

        public function getRightTorqueEffectiveness():Number
        {
            return getFieldDoubleValue(44, 0, 65535);
        }

        public function setRightTorqueEffectiveness(arg1:Number):void
        {
            setFieldValue(44, 0, arg1, 65535);
            return;
        }

        public function getLeftPedalSmoothness():Number
        {
            return getFieldDoubleValue(45, 0, 65535);
        }

        public function setLeftPedalSmoothness(arg1:Number):void
        {
            setFieldValue(45, 0, arg1, 65535);
            return;
        }

        public function getRightPedalSmoothness():Number
        {
            return getFieldDoubleValue(46, 0, 65535);
        }

        public function setRightPedalSmoothness(arg1:Number):void
        {
            setFieldValue(46, 0, arg1, 65535);
            return;
        }

        public function getCombinedPedalSmoothness():Number
        {
            return getFieldDoubleValue(47, 0, 65535);
        }

        public function setCombinedPedalSmoothness(arg1:Number):void
        {
            setFieldValue(47, 0, arg1, 65535);
            return;
        }

        public static function get recordMesg():com.garmin.fit.Mesg
        {
            return _recordMesg;
        }

        
        {
            _recordMesg = new com.garmin.fit.Mesg("record", 20);
            recordMesg.addField(new com.garmin.fit.Field("timestamp", 253, 134, 1, 0, "s"));
            ++field_index;
            recordMesg.addField(new com.garmin.fit.Field("position_lat", 0, 133, 1, 0, "semicircles"));
            ++field_index;
            recordMesg.addField(new com.garmin.fit.Field("position_long", 1, 133, 1, 0, "semicircles"));
            ++field_index;
            recordMesg.addField(new com.garmin.fit.Field("altitude", 2, 132, 5, 500, "m"));
            ++field_index;
            recordMesg.addField(new com.garmin.fit.Field("heart_rate", 3, 2, 1, 0, "bpm"));
            ++field_index;
            recordMesg.addField(new com.garmin.fit.Field("cadence", 4, 2, 1, 0, "rpm"));
            ++field_index;
            recordMesg.addField(new com.garmin.fit.Field("distance", 5, 134, 100, 0, "m"));
            ++field_index;
            recordMesg.addField(new com.garmin.fit.Field("speed", 6, 132, 1000, 0, "m/s"));
            ++field_index;
            recordMesg.addField(new com.garmin.fit.Field("power", 7, 132, 1, 0, "watts"));
            ++field_index;
            recordMesg.addField(new com.garmin.fit.Field("compressed_speed_distance", 8, 13, 1, 0, ""));
            recordMesg.fields[field_index].components.push(new com.garmin.fit.FieldComponent(6, false, 12, 100, 0));
            recordMesg.fields[field_index].components.push(new com.garmin.fit.FieldComponent(5, true, 12, 16, 0));
            ++field_index;
            recordMesg.addField(new com.garmin.fit.Field("grade", 9, 131, 100, 0, "%"));
            ++field_index;
            recordMesg.addField(new com.garmin.fit.Field("resistance", 10, 2, 1, 0, ""));
            ++field_index;
            recordMesg.addField(new com.garmin.fit.Field("time_from_course", 11, 133, 1000, 0, "s"));
            ++field_index;
            recordMesg.addField(new com.garmin.fit.Field("cycle_length", 12, 2, 100, 0, "m"));
            ++field_index;
            recordMesg.addField(new com.garmin.fit.Field("temperature", 13, 1, 1, 0, "C"));
            ++field_index;
            recordMesg.addField(new com.garmin.fit.Field("speed_1s", 17, 2, 16, 0, "m/s"));
            ++field_index;
            recordMesg.addField(new com.garmin.fit.Field("cycles", 18, 2, 1, 0, ""));
            recordMesg.fields[field_index].components.push(new com.garmin.fit.FieldComponent(19, true, 8, 1, 0));
            ++field_index;
            recordMesg.addField(new com.garmin.fit.Field("total_cycles", 19, 134, 1, 0, "cycles"));
            ++field_index;
            recordMesg.addField(new com.garmin.fit.Field("compressed_accumulated_power", 28, 132, 1, 0, ""));
            recordMesg.fields[field_index].components.push(new com.garmin.fit.FieldComponent(29, true, 16, 1, 0));
            ++field_index;
            recordMesg.addField(new com.garmin.fit.Field("accumulated_power", 29, 134, 1, 0, "watts"));
            ++field_index;
            recordMesg.addField(new com.garmin.fit.Field("left_right_balance", 30, 2, 1, 0, ""));
            ++field_index;
            recordMesg.addField(new com.garmin.fit.Field("gps_accuracy", 31, 2, 1, 0, "m"));
            ++field_index;
            recordMesg.addField(new com.garmin.fit.Field("vertical_speed", 32, 131, 1000, 0, "m/s"));
            ++field_index;
            recordMesg.addField(new com.garmin.fit.Field("calories", 33, 132, 1, 0, "kcal"));
            ++field_index;
            recordMesg.addField(new com.garmin.fit.Field("left_torque_effectiveness", 43, 2, 2, 0, "percent"));
            ++field_index;
            recordMesg.addField(new com.garmin.fit.Field("right_torque_effectiveness", 44, 2, 2, 0, "percent"));
            ++field_index;
            recordMesg.addField(new com.garmin.fit.Field("left_pedal_smoothness", 45, 2, 2, 0, "percent"));
            ++field_index;
            recordMesg.addField(new com.garmin.fit.Field("right_pedal_smoothness", 46, 2, 2, 0, "percent"));
            ++field_index;
            recordMesg.addField(new com.garmin.fit.Field("combined_pedal_smoothness", 47, 2, 2, 0, "percent"));
            ++field_index;
        }

        internal static var field_index:int=0;

        internal static var _recordMesg:com.garmin.fit.Mesg;
    }
}


//    class Schedule
package com.garmin.fit 
{
    import __AS3__.vec.*;
    import avmplus.*;
    import com.garmin.fit.custom.*;
    import flash.errors.*;
    
    public class Schedule extends com.garmin.fit.custom.BaseType
    {
        public function Schedule(arg1:Object, arg2:uint)
        {
            super();
            if (arg1 != SINGLETON_ENFORCER) 
            {
                throw new flash.errors.IllegalOperationError("IllegalOperation: Manipulation of type " + avmplus.getQualifiedClassName(this));
            }
            this.value = arg2;
            return;
        }

        public function getAllValues():__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>
        {
            return VALUES;
        }

        public function getInvalid():com.garmin.fit.custom.BaseType
        {
            return INVALID;
        }

        public function getValue():uint
        {
            return value;
        }

        public static function getByValue(arg1:uint):com.garmin.fit.Schedule
        {
            return com.garmin.fit.custom.BaseType.getByValue(arg1) as Schedule;
        }

        
        {
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(3)[0] = WORKOUT;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(3)[1] = COURSE;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(3)[2] = INVALID;
        }

        internal static const SINGLETON_ENFORCER:Object={};

        public static const WORKOUT:com.garmin.fit.Schedule=new Schedule(SINGLETON_ENFORCER, 0);

        public static const COURSE:com.garmin.fit.Schedule=new Schedule(SINGLETON_ENFORCER, 1);

        public static const INVALID:com.garmin.fit.Schedule=new Schedule(SINGLETON_ENFORCER, 255);

        internal static const VALUES:__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>=new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(3);
    }
}


//    class ScheduleMesg
package com.garmin.fit 
{
    public class ScheduleMesg extends com.garmin.fit.Mesg
    {
        public function ScheduleMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(28));
            return;
        }

        public function getManufacturer():int
        {
            return getFieldIntegerValue(0, 0, 65535);
        }

        public function setManufacturer(arg1:int):void
        {
            setFieldValue(0, 0, arg1, 65535);
            return;
        }

        public function getProduct():int
        {
            return getFieldIntegerValue(1, 0, 65535);
        }

        public function setProduct(arg1:int):void
        {
            setFieldValue(1, 0, arg1, 65535);
            return;
        }

        public function getGarminProduct():int
        {
            return getFieldIntegerValue(1, 0, 0);
        }

        public function setGarminProduct(arg1:int):void
        {
            setFieldValue(1, 0, arg1, 0);
            return;
        }

        public function getSerialNumber():Number
        {
            return getFieldDoubleValue(2, 0, 65535);
        }

        public function setSerialNumber(arg1:Number):void
        {
            setFieldValue(2, 0, arg1, 65535);
            return;
        }

        public function getTimeCreated():com.garmin.fit.DateTime
        {
            return timestampToDateTime(getFieldDoubleValue(3, 0, 65535));
        }

        public function setTimeCreated(arg1:com.garmin.fit.DateTime):void
        {
            setFieldValue(3, 0, arg1.getTimestamp(), 65535);
            return;
        }

        public function getCompleted():com.garmin.fit.FITBool
        {
            var loc1:*=getFieldIntegerValue(4, 0, 65535);
            if (!loc1) 
            {
                return null;
            }
            return com.garmin.fit.FITBool.getByValue(loc1);
        }

        public function setCompleted(arg1:Boolean):void
        {
            setFieldValue(4, 0, arg1, 65535);
            return;
        }

        public function getType():com.garmin.fit.Schedule
        {
            var loc1:*=getFieldIntegerValue(5, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.Schedule.getByValue(loc1);
        }

        public function setType(arg1:com.garmin.fit.Schedule):void
        {
            setFieldValue(5, 0, arg1.getValue(), 65535);
            return;
        }

        public function getScheduledTime():Number
        {
            return getFieldDoubleValue(6, 0, 65535);
        }

        public function setScheduledTime(arg1:Number):void
        {
            setFieldValue(6, 0, arg1, 65535);
            return;
        }

        public static function get scheduleMesg():com.garmin.fit.Mesg
        {
            return _scheduleMesg;
        }

        
        {
            _scheduleMesg = new com.garmin.fit.Mesg("schedule", 28);
            scheduleMesg.addField(new com.garmin.fit.Field("manufacturer", 0, 132, 1, 0, ""));
            ++field_index;
            scheduleMesg.addField(new com.garmin.fit.Field("product", 1, 132, 1, 0, ""));
            subfield_index = 0;
            scheduleMesg.fields[field_index].subFields.push(new com.garmin.fit.SubField("garmin_product", 132, 1, 0, ""));
            scheduleMesg.fields[field_index].subFields[subfield_index].addMap(0, 1);
            scheduleMesg.fields[field_index].subFields[subfield_index].addMap(0, 15);
            scheduleMesg.fields[field_index].subFields[subfield_index].addMap(0, 13);
            ++subfield_index;
            ++field_index;
            scheduleMesg.addField(new com.garmin.fit.Field("serial_number", 2, 140, 1, 0, ""));
            ++field_index;
            scheduleMesg.addField(new com.garmin.fit.Field("time_created", 3, 134, 1, 0, ""));
            ++field_index;
            scheduleMesg.addField(new com.garmin.fit.Field("completed", 4, 0, 1, 0, ""));
            ++field_index;
            scheduleMesg.addField(new com.garmin.fit.Field("type", 5, 0, 1, 0, ""));
            ++field_index;
            scheduleMesg.addField(new com.garmin.fit.Field("scheduled_time", 6, 134, 1, 0, ""));
            ++field_index;
        }

        internal static var _scheduleMesg:com.garmin.fit.Mesg;

        internal static var field_index:int=0;

        internal static var subfield_index:int=0;
    }
}


//    class SdmProfileMesg
package com.garmin.fit 
{
    public class SdmProfileMesg extends com.garmin.fit.Mesg
    {
        public function SdmProfileMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(5));
            return;
        }

        public function getMessageIndex():int
        {
            return getFieldIntegerValue(254, 0, 65535);
        }

        public function setMessageIndex(arg1:int):void
        {
            setFieldValue(254, 0, arg1, 65535);
            return;
        }

        public function getEnabled():com.garmin.fit.FITBool
        {
            var loc1:*=getFieldIntegerValue(0, 0, 65535);
            if (!loc1) 
            {
                return null;
            }
            return com.garmin.fit.FITBool.getByValue(loc1);
        }

        public function setEnabled(arg1:Boolean):void
        {
            setFieldValue(0, 0, arg1, 65535);
            return;
        }

        public function getSdmAntId():int
        {
            return getFieldIntegerValue(1, 0, 65535);
        }

        public function setSdmAntId(arg1:int):void
        {
            setFieldValue(1, 0, arg1, 65535);
            return;
        }

        public function getSdmCalFactor():Number
        {
            return getFieldDoubleValue(2, 0, 65535);
        }

        public function setSdmCalFactor(arg1:Number):void
        {
            setFieldValue(2, 0, arg1, 65535);
            return;
        }

        public function getOdometer():Number
        {
            return getFieldDoubleValue(3, 0, 65535);
        }

        public function setOdometer(arg1:Number):void
        {
            setFieldValue(3, 0, arg1, 65535);
            return;
        }

        public function getSpeedSource():com.garmin.fit.FITBool
        {
            var loc1:*=getFieldIntegerValue(4, 0, 65535);
            if (!loc1) 
            {
                return null;
            }
            return com.garmin.fit.FITBool.getByValue(loc1);
        }

        public function setSpeedSource(arg1:Boolean):void
        {
            setFieldValue(4, 0, arg1, 65535);
            return;
        }

        public function getSdmAntIdTransType():int
        {
            return getFieldIntegerValue(5, 0, 65535);
        }

        public function setSdmAntIdTransType(arg1:int):void
        {
            setFieldValue(5, 0, arg1, 65535);
            return;
        }

        public static function get sdmProfileMesg():com.garmin.fit.Mesg
        {
            return _sdmProfileMesg;
        }

        
        {
            _sdmProfileMesg = new com.garmin.fit.Mesg("sdm_profile", 5);
            sdmProfileMesg.addField(new com.garmin.fit.Field("message_index", 254, 132, 1, 0, ""));
            sdmProfileMesg.addField(new com.garmin.fit.Field("enabled", 0, 0, 1, 0, ""));
            sdmProfileMesg.addField(new com.garmin.fit.Field("sdm_ant_id", 1, 139, 1, 0, ""));
            sdmProfileMesg.addField(new com.garmin.fit.Field("sdm_cal_factor", 2, 132, 10, 0, "%"));
            sdmProfileMesg.addField(new com.garmin.fit.Field("odometer", 3, 134, 100, 0, "m"));
            sdmProfileMesg.addField(new com.garmin.fit.Field("speed_source", 4, 0, 1, 0, ""));
            sdmProfileMesg.addField(new com.garmin.fit.Field("sdm_ant_id_trans_type", 5, 10, 1, 0, ""));
        }

        internal static var _sdmProfileMesg:com.garmin.fit.Mesg;
    }
}


//    class SessionMesg
package com.garmin.fit 
{
    public class SessionMesg extends com.garmin.fit.Mesg implements com.garmin.fit.MesgWithEvent
    {
        public function SessionMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(18));
            return;
        }

        public function getMessageIndex():int
        {
            return getFieldIntegerValue(254, 0, 65535);
        }

        public function setMessageIndex(arg1:int):void
        {
            setFieldValue(254, 0, arg1, 65535);
            return;
        }

        public function getTimestamp():com.garmin.fit.DateTime
        {
            return timestampToDateTime(getFieldDoubleValue(253, 0, 65535));
        }

        public function setTimestamp(arg1:com.garmin.fit.DateTime):void
        {
            setFieldValue(253, 0, arg1.getTimestamp(), 65535);
            return;
        }

        public function getEvent():com.garmin.fit.FITEvent
        {
            var loc1:*=getFieldIntegerValue(0, 0, 65535);
            if (!loc1) 
            {
                return null;
            }
            return com.garmin.fit.FITEvent.getByValue(loc1);
        }

        public function setEvent(arg1:com.garmin.fit.FITEvent):void
        {
            setFieldValue(0, 0, arg1.getValue(), 65535);
            return;
        }

        public function getEventType():com.garmin.fit.EventType
        {
            var loc1:*=getFieldIntegerValue(1, 0, 65535);
            if (!loc1) 
            {
                return null;
            }
            return com.garmin.fit.EventType.getByValue(loc1);
        }

        public function setEventType(arg1:com.garmin.fit.EventType):void
        {
            setFieldValue(1, 0, arg1.getValue(), 65535);
            return;
        }

        public function getStartTime():com.garmin.fit.DateTime
        {
            return timestampToDateTime(getFieldDoubleValue(2, 0, 65535));
        }

        public function setStartTime(arg1:com.garmin.fit.DateTime):void
        {
            setFieldValue(2, 0, arg1.getTimestamp(), 65535);
            return;
        }

        public function getStartPositionLat():int
        {
            return getFieldIntegerValue(3, 0, 65535);
        }

        public function setStartPositionLat(arg1:int):void
        {
            setFieldValue(3, 0, arg1, 65535);
            return;
        }

        public function getStartPositionLong():int
        {
            return getFieldIntegerValue(4, 0, 65535);
        }

        public function setStartPositionLong(arg1:int):void
        {
            setFieldValue(4, 0, arg1, 65535);
            return;
        }

        public function getSport():com.garmin.fit.Sport
        {
            var loc1:*=getFieldIntegerValue(5, 0, 65535);
            if (-2147483648 == loc1) 
            {
                return null;
            }
            return com.garmin.fit.Sport.getByValue(loc1);
        }

        public function setSport(arg1:com.garmin.fit.Sport):void
        {
            setFieldValue(5, 0, arg1.getValue(), 65535);
            return;
        }

        public function getSubSport():com.garmin.fit.SubSport
        {
            var loc1:*=getFieldIntegerValue(6, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.SubSport.getByValue(loc1);
        }

        public function setSubSport(arg1:com.garmin.fit.SubSport):void
        {
            setFieldValue(6, 0, arg1.getValue(), 65535);
            return;
        }

        public function getTotalElapsedTime():Number
        {
            return getFieldDoubleValue(7, 0, 65535);
        }

        public function setTotalElapsedTime(arg1:Number):void
        {
            setFieldValue(7, 0, arg1, 65535);
            return;
        }

        public function getTotalTimerTime():Number
        {
            return getFieldDoubleValue(8, 0, 65535);
        }

        public function setTotalTimerTime(arg1:Number):void
        {
            setFieldValue(8, 0, arg1, 65535);
            return;
        }

        public function getTotalDistance():Number
        {
            return getFieldDoubleValue(9, 0, 65535);
        }

        public function setTotalDistance(arg1:Number):void
        {
            setFieldValue(9, 0, arg1, 65535);
            return;
        }

        public function getTotalCycles():Number
        {
            return getFieldDoubleValue(10, 0, 65535);
        }

        public function setTotalCycles(arg1:Number):void
        {
            setFieldValue(10, 0, arg1, 65535);
            return;
        }

        public function getTotalStrides():Number
        {
            return getFieldDoubleValue(10, 0, 0);
        }

        public function setTotalStrides(arg1:Number):void
        {
            setFieldValue(10, 0, arg1, 0);
            return;
        }

        public function getTotalCalories():int
        {
            return getFieldIntegerValue(11, 0, 65535);
        }

        public function setTotalCalories(arg1:int):void
        {
            setFieldValue(11, 0, arg1, 65535);
            return;
        }

        public function getTotalFatCalories():int
        {
            return getFieldIntegerValue(13, 0, 65535);
        }

        public function setTotalFatCalories(arg1:int):void
        {
            setFieldValue(13, 0, arg1, 65535);
            return;
        }

        public function getAvgSpeed():Number
        {
            return getFieldDoubleValue(14, 0, 65535);
        }

        public function setAvgSpeed(arg1:Number):void
        {
            setFieldValue(14, 0, arg1, 65535);
            return;
        }

        public function getMaxSpeed():Number
        {
            return getFieldDoubleValue(15, 0, 65535);
        }

        public function setMaxSpeed(arg1:Number):void
        {
            setFieldValue(15, 0, arg1, 65535);
            return;
        }

        public function getAvgHeartRate():int
        {
            return getFieldIntegerValue(16, 0, 65535);
        }

        public function setAvgHeartRate(arg1:int):void
        {
            setFieldValue(16, 0, arg1, 65535);
            return;
        }

        public function getMaxHeartRate():int
        {
            return getFieldIntegerValue(17, 0, 65535);
        }

        public function setMaxHeartRate(arg1:int):void
        {
            setFieldValue(17, 0, arg1, 65535);
            return;
        }

        public function getAvgCadence():int
        {
            return getFieldIntegerValue(18, 0, 65535);
        }

        public function setAvgCadence(arg1:int):void
        {
            setFieldValue(18, 0, arg1, 65535);
            return;
        }

        public function getAvgRunningCadence():int
        {
            return getFieldIntegerValue(18, 0, 0);
        }

        public function setAvgRunningCadence(arg1:int):void
        {
            setFieldValue(18, 0, arg1, 0);
            return;
        }

        public function getMaxCadence():int
        {
            return getFieldIntegerValue(19, 0, 65535);
        }

        public function setMaxCadence(arg1:int):void
        {
            setFieldValue(19, 0, arg1, 65535);
            return;
        }

        public function getMaxRunningCadence():int
        {
            return getFieldIntegerValue(19, 0, 0);
        }

        public function setMaxRunningCadence(arg1:int):void
        {
            setFieldValue(19, 0, arg1, 0);
            return;
        }

        public function getAvgPower():int
        {
            return getFieldIntegerValue(20, 0, 65535);
        }

        public function setAvgPower(arg1:int):void
        {
            setFieldValue(20, 0, arg1, 65535);
            return;
        }

        public function getMaxPower():int
        {
            return getFieldIntegerValue(21, 0, 65535);
        }

        public function setMaxPower(arg1:int):void
        {
            setFieldValue(21, 0, arg1, 65535);
            return;
        }

        public function getTotalAscent():int
        {
            return getFieldIntegerValue(22, 0, 65535);
        }

        public function setTotalAscent(arg1:int):void
        {
            setFieldValue(22, 0, arg1, 65535);
            return;
        }

        public function getTotalDescent():int
        {
            return getFieldIntegerValue(23, 0, 65535);
        }

        public function setTotalDescent(arg1:int):void
        {
            setFieldValue(23, 0, arg1, 65535);
            return;
        }

        public function getTotalTrainingEffect():Number
        {
            return getFieldDoubleValue(24, 0, 65535);
        }

        public function setTotalTrainingEffect(arg1:Number):void
        {
            setFieldValue(24, 0, arg1, 65535);
            return;
        }

        public function getFirstLapIndex():int
        {
            return getFieldIntegerValue(25, 0, 65535);
        }

        public function setFirstLapIndex(arg1:int):void
        {
            setFieldValue(25, 0, arg1, 65535);
            return;
        }

        public function getNumLaps():int
        {
            return getFieldIntegerValue(26, 0, 65535);
        }

        public function setNumLaps(arg1:int):void
        {
            setFieldValue(26, 0, arg1, 65535);
            return;
        }

        public function getEventGroup():int
        {
            return getFieldIntegerValue(27, 0, 65535);
        }

        public function setEventGroup(arg1:int):void
        {
            setFieldValue(27, 0, arg1, 65535);
            return;
        }

        public function getTrigger():com.garmin.fit.SessionTrigger
        {
            var loc1:*=getFieldIntegerValue(28, 0, 65535);
            if (!loc1) 
            {
                return null;
            }
            return com.garmin.fit.SessionTrigger.getByValue(loc1);
        }

        public function setTrigger(arg1:com.garmin.fit.SessionTrigger):void
        {
            setFieldValue(28, 0, arg1.getValue(), 65535);
            return;
        }

        public function getNecLat():int
        {
            return getFieldIntegerValue(29, 0, 65535);
        }

        public function setNecLat(arg1:int):void
        {
            setFieldValue(29, 0, arg1, 65535);
            return;
        }

        public function getNecLong():int
        {
            return getFieldIntegerValue(30, 0, 65535);
        }

        public function setNecLong(arg1:int):void
        {
            setFieldValue(30, 0, arg1, 65535);
            return;
        }

        public function getSwcLat():int
        {
            return getFieldIntegerValue(31, 0, 65535);
        }

        public function setSwcLat(arg1:int):void
        {
            setFieldValue(31, 0, arg1, 65535);
            return;
        }

        public function getSwcLong():int
        {
            return getFieldIntegerValue(32, 0, 65535);
        }

        public function setSwcLong(arg1:int):void
        {
            setFieldValue(32, 0, arg1, 65535);
            return;
        }

        public function getNormalizedPower():int
        {
            return getFieldIntegerValue(34, 0, 65535);
        }

        public function setNormalizedPower(arg1:int):void
        {
            setFieldValue(34, 0, arg1, 65535);
            return;
        }

        public function getTrainingStressScore():Number
        {
            return getFieldDoubleValue(35, 0, 65535);
        }

        public function setTrainingStressScore(arg1:Number):void
        {
            setFieldValue(35, 0, arg1, 65535);
            return;
        }

        public function getIntensityFactor():Number
        {
            return getFieldDoubleValue(36, 0, 65535);
        }

        public function setIntensityFactor(arg1:Number):void
        {
            setFieldValue(36, 0, arg1, 65535);
            return;
        }

        public function getLeftRightBalance():int
        {
            return getFieldIntegerValue(37, 0, 65535);
        }

        public function setLeftRightBalance(arg1:int):void
        {
            setFieldValue(37, 0, arg1, 65535);
            return;
        }

        public function getAvgStrokeCount():Number
        {
            return getFieldDoubleValue(41, 0, 65535);
        }

        public function setAvgStrokeCount(arg1:Number):void
        {
            setFieldValue(41, 0, arg1, 65535);
            return;
        }

        public function getAvgStrokeDistance():Number
        {
            return getFieldDoubleValue(42, 0, 65535);
        }

        public function setAvgStrokeDistance(arg1:Number):void
        {
            setFieldValue(42, 0, arg1, 65535);
            return;
        }

        public function getSwimStroke():com.garmin.fit.SwimStroke
        {
            var loc1:*=getFieldIntegerValue(43, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.SwimStroke.getByValue(loc1);
        }

        public function setSwimStroke(arg1:com.garmin.fit.SwimStroke):void
        {
            setFieldValue(43, 0, arg1.getValue(), 65535);
            return;
        }

        public function getPoolLength():Number
        {
            return getFieldDoubleValue(44, 0, 65535);
        }

        public function setPoolLength(arg1:Number):void
        {
            setFieldValue(44, 0, arg1, 65535);
            return;
        }

        public function getPoolLengthUnit():com.garmin.fit.DisplayMeasure
        {
            var loc1:*=getFieldIntegerValue(46, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.DisplayMeasure.getByValue(loc1);
        }

        public function setPoolLengthUnit(arg1:com.garmin.fit.DisplayMeasure):void
        {
            setFieldValue(46, 0, arg1.getValue(), 65535);
            return;
        }

        public function getNumActiveLengths():int
        {
            return getFieldIntegerValue(47, 0, 65535);
        }

        public function setNumActiveLengths(arg1:int):void
        {
            setFieldValue(47, 0, arg1, 65535);
            return;
        }

        public function getTotalWork():Number
        {
            return getFieldDoubleValue(48, 0, 65535);
        }

        public function setTotalWork(arg1:Number):void
        {
            setFieldValue(48, 0, arg1, 65535);
            return;
        }

        public function getAvgAltitude():Number
        {
            return getFieldDoubleValue(49, 0, 65535);
        }

        public function setAvgAltitude(arg1:Number):void
        {
            setFieldValue(49, 0, arg1, 65535);
            return;
        }

        public function getMaxAltitude():Number
        {
            return getFieldDoubleValue(50, 0, 65535);
        }

        public function setMaxAltitude(arg1:Number):void
        {
            setFieldValue(50, 0, arg1, 65535);
            return;
        }

        public function getGpsAccuracy():int
        {
            return getFieldIntegerValue(51, 0, 65535);
        }

        public function setGpsAccuracy(arg1:int):void
        {
            setFieldValue(51, 0, arg1, 65535);
            return;
        }

        public function getAvgGrade():Number
        {
            return getFieldDoubleValue(52, 0, 65535);
        }

        public function setAvgGrade(arg1:Number):void
        {
            setFieldValue(52, 0, arg1, 65535);
            return;
        }

        public function getAvgPosGrade():Number
        {
            return getFieldDoubleValue(53, 0, 65535);
        }

        public function setAvgPosGrade(arg1:Number):void
        {
            setFieldValue(53, 0, arg1, 65535);
            return;
        }

        public function getAvgNegGrade():Number
        {
            return getFieldDoubleValue(54, 0, 65535);
        }

        public function setAvgNegGrade(arg1:Number):void
        {
            setFieldValue(54, 0, arg1, 65535);
            return;
        }

        public function getMaxPosGrade():Number
        {
            return getFieldDoubleValue(55, 0, 65535);
        }

        public function setMaxPosGrade(arg1:Number):void
        {
            setFieldValue(55, 0, arg1, 65535);
            return;
        }

        public function getMaxNegGrade():Number
        {
            return getFieldDoubleValue(56, 0, 65535);
        }

        public function setMaxNegGrade(arg1:Number):void
        {
            setFieldValue(56, 0, arg1, 65535);
            return;
        }

        public function getAvgTemperature():int
        {
            return getFieldIntegerValue(57, 0, 65535);
        }

        public function setAvgTemperature(arg1:int):void
        {
            setFieldValue(57, 0, arg1, 65535);
            return;
        }

        public function getMaxTemperature():int
        {
            return getFieldIntegerValue(58, 0, 65535);
        }

        public function setMaxTemperature(arg1:int):void
        {
            setFieldValue(58, 0, arg1, 65535);
            return;
        }

        public function getTotalMovingTime():Number
        {
            return getFieldDoubleValue(59, 0, 65535);
        }

        public function setTotalMovingTime(arg1:Number):void
        {
            setFieldValue(59, 0, arg1, 65535);
            return;
        }

        public function getAvgPosVerticalSpeed():Number
        {
            return getFieldDoubleValue(60, 0, 65535);
        }

        public function setAvgPosVerticalSpeed(arg1:Number):void
        {
            setFieldValue(60, 0, arg1, 65535);
            return;
        }

        public function getAvgNegVerticalSpeed():Number
        {
            return getFieldDoubleValue(61, 0, 65535);
        }

        public function setAvgNegVerticalSpeed(arg1:Number):void
        {
            setFieldValue(61, 0, arg1, 65535);
            return;
        }

        public function getMaxPosVerticalSpeed():Number
        {
            return getFieldDoubleValue(62, 0, 65535);
        }

        public function setMaxPosVerticalSpeed(arg1:Number):void
        {
            setFieldValue(62, 0, arg1, 65535);
            return;
        }

        public function getMaxNegVerticalSpeed():Number
        {
            return getFieldDoubleValue(63, 0, 65535);
        }

        public function setMaxNegVerticalSpeed(arg1:Number):void
        {
            setFieldValue(63, 0, arg1, 65535);
            return;
        }

        public function getMinHeartRate():int
        {
            return getFieldIntegerValue(64, 0, 65535);
        }

        public function setMinHeartRate(arg1:int):void
        {
            setFieldValue(64, 0, arg1, 65535);
            return;
        }

        public function getNumTimeInHrZone():int
        {
            return getNumFieldValues(65, 65535);
        }

        public function getTimeInHrZone(arg1:int):Number
        {
            return getFieldDoubleValue(65, arg1, 65535);
        }

        public function setTimeInHrZone(arg1:int, arg2:Number):void
        {
            setFieldValue(65, arg1, arg2, 65535);
            return;
        }

        public function getNumTimeInSpeedZone():int
        {
            return getNumFieldValues(66, 65535);
        }

        public function getTimeInSpeedZone(arg1:int):Number
        {
            return getFieldDoubleValue(66, arg1, 65535);
        }

        public function setTimeInSpeedZone(arg1:int, arg2:Number):void
        {
            setFieldValue(66, arg1, arg2, 65535);
            return;
        }

        public function getNumTimeInCadenceZone():int
        {
            return getNumFieldValues(67, 65535);
        }

        public function getTimeInCadenceZone(arg1:int):Number
        {
            return getFieldDoubleValue(67, arg1, 65535);
        }

        public function setTimeInCadenceZone(arg1:int, arg2:Number):void
        {
            setFieldValue(67, arg1, arg2, 65535);
            return;
        }

        public function getNumTimeInPowerZone():int
        {
            return getNumFieldValues(68, 65535);
        }

        public function getTimeInPowerZone(arg1:int):Number
        {
            return getFieldDoubleValue(68, arg1, 65535);
        }

        public function setTimeInPowerZone(arg1:int, arg2:Number):void
        {
            setFieldValue(68, arg1, arg2, 65535);
            return;
        }

        public function getAvgLapTime():Number
        {
            return getFieldDoubleValue(69, 0, 65535);
        }

        public function setAvgLapTime(arg1:Number):void
        {
            setFieldValue(69, 0, arg1, 65535);
            return;
        }

        public function getBestLapIndex():int
        {
            return getFieldIntegerValue(70, 0, 65535);
        }

        public function setBestLapIndex(arg1:int):void
        {
            setFieldValue(70, 0, arg1, 65535);
            return;
        }

        public function getMinAltitude():Number
        {
            return getFieldDoubleValue(71, 0, 65535);
        }

        public function setMinAltitude(arg1:Number):void
        {
            setFieldValue(71, 0, arg1, 65535);
            return;
        }

        public static function get sessionMesg():com.garmin.fit.Mesg
        {
            return _sessionMesg;
        }

        
        {
            _sessionMesg = new com.garmin.fit.Mesg("session", 18);
            sessionMesg.addField(new com.garmin.fit.Field("message_index", 254, 132, 1, 0, ""));
            ++field_index;
            sessionMesg.addField(new com.garmin.fit.Field("timestamp", 253, 134, 1, 0, "s"));
            ++field_index;
            sessionMesg.addField(new com.garmin.fit.Field("event", 0, 0, 1, 0, ""));
            ++field_index;
            sessionMesg.addField(new com.garmin.fit.Field("event_type", 1, 0, 1, 0, ""));
            ++field_index;
            sessionMesg.addField(new com.garmin.fit.Field("start_time", 2, 134, 1, 0, ""));
            ++field_index;
            sessionMesg.addField(new com.garmin.fit.Field("start_position_lat", 3, 133, 1, 0, "semicircles"));
            ++field_index;
            sessionMesg.addField(new com.garmin.fit.Field("start_position_long", 4, 133, 1, 0, "semicircles"));
            ++field_index;
            sessionMesg.addField(new com.garmin.fit.Field("sport", 5, 0, 1, 0, ""));
            ++field_index;
            sessionMesg.addField(new com.garmin.fit.Field("sub_sport", 6, 0, 1, 0, ""));
            ++field_index;
            sessionMesg.addField(new com.garmin.fit.Field("total_elapsed_time", 7, 134, 1000, 0, "s"));
            ++field_index;
            sessionMesg.addField(new com.garmin.fit.Field("total_timer_time", 8, 134, 1000, 0, "s"));
            ++field_index;
            sessionMesg.addField(new com.garmin.fit.Field("total_distance", 9, 134, 100, 0, "m"));
            ++field_index;
            sessionMesg.addField(new com.garmin.fit.Field("total_cycles", 10, 134, 1, 0, "cycles"));
            subfield_index = 0;
            sessionMesg.fields[field_index].subFields.push(new com.garmin.fit.SubField("total_strides", 134, 1, 0, "strides"));
            sessionMesg.fields[field_index].subFields[subfield_index].addMap(5, 1);
            ++subfield_index;
            ++field_index;
            sessionMesg.addField(new com.garmin.fit.Field("total_calories", 11, 132, 1, 0, "kcal"));
            ++field_index;
            sessionMesg.addField(new com.garmin.fit.Field("total_fat_calories", 13, 132, 1, 0, "kcal"));
            ++field_index;
            sessionMesg.addField(new com.garmin.fit.Field("avg_speed", 14, 132, 1000, 0, "m/s"));
            ++field_index;
            sessionMesg.addField(new com.garmin.fit.Field("max_speed", 15, 132, 1000, 0, "m/s"));
            ++field_index;
            sessionMesg.addField(new com.garmin.fit.Field("avg_heart_rate", 16, 2, 1, 0, "bpm"));
            ++field_index;
            sessionMesg.addField(new com.garmin.fit.Field("max_heart_rate", 17, 2, 1, 0, "bpm"));
            ++field_index;
            sessionMesg.addField(new com.garmin.fit.Field("avg_cadence", 18, 2, 1, 0, "rpm"));
            subfield_index = 0;
            sessionMesg.fields[field_index].subFields.push(new com.garmin.fit.SubField("avg_running_cadence", 2, 1, 0, "strides/min"));
            sessionMesg.fields[field_index].subFields[subfield_index].addMap(5, 1);
            ++subfield_index;
            ++field_index;
            sessionMesg.addField(new com.garmin.fit.Field("max_cadence", 19, 2, 1, 0, "rpm"));
            subfield_index = 0;
            sessionMesg.fields[field_index].subFields.push(new com.garmin.fit.SubField("max_running_cadence", 2, 1, 0, "strides/min"));
            sessionMesg.fields[field_index].subFields[subfield_index].addMap(5, 1);
            ++subfield_index;
            ++field_index;
            sessionMesg.addField(new com.garmin.fit.Field("avg_power", 20, 132, 1, 0, "watts"));
            ++field_index;
            sessionMesg.addField(new com.garmin.fit.Field("max_power", 21, 132, 1, 0, "watts"));
            ++field_index;
            sessionMesg.addField(new com.garmin.fit.Field("total_ascent", 22, 132, 1, 0, "m"));
            ++field_index;
            sessionMesg.addField(new com.garmin.fit.Field("total_descent", 23, 132, 1, 0, "m"));
            ++field_index;
            sessionMesg.addField(new com.garmin.fit.Field("total_training_effect", 24, 2, 10, 0, ""));
            ++field_index;
            sessionMesg.addField(new com.garmin.fit.Field("first_lap_index", 25, 132, 1, 0, ""));
            ++field_index;
            sessionMesg.addField(new com.garmin.fit.Field("num_laps", 26, 132, 1, 0, ""));
            ++field_index;
            sessionMesg.addField(new com.garmin.fit.Field("event_group", 27, 2, 1, 0, ""));
            ++field_index;
            sessionMesg.addField(new com.garmin.fit.Field("trigger", 28, 0, 1, 0, ""));
            ++field_index;
            sessionMesg.addField(new com.garmin.fit.Field("nec_lat", 29, 133, 1, 0, "semicircles"));
            ++field_index;
            sessionMesg.addField(new com.garmin.fit.Field("nec_long", 30, 133, 1, 0, "semicircles"));
            ++field_index;
            sessionMesg.addField(new com.garmin.fit.Field("swc_lat", 31, 133, 1, 0, "semicircles"));
            ++field_index;
            sessionMesg.addField(new com.garmin.fit.Field("swc_long", 32, 133, 1, 0, "semicircles"));
            ++field_index;
            sessionMesg.addField(new com.garmin.fit.Field("normalized_power", 34, 132, 1, 0, "watts"));
            ++field_index;
            sessionMesg.addField(new com.garmin.fit.Field("training_stress_score", 35, 132, 10, 0, "tss"));
            ++field_index;
            sessionMesg.addField(new com.garmin.fit.Field("intensity_factor", 36, 132, 1000, 0, "if"));
            ++field_index;
            sessionMesg.addField(new com.garmin.fit.Field("left_right_balance", 37, 132, 1, 0, ""));
            ++field_index;
            sessionMesg.addField(new com.garmin.fit.Field("avg_stroke_count", 41, 134, 10, 0, "strokes/lap"));
            ++field_index;
            sessionMesg.addField(new com.garmin.fit.Field("avg_stroke_distance", 42, 132, 100, 0, "m"));
            ++field_index;
            sessionMesg.addField(new com.garmin.fit.Field("swim_stroke", 43, 0, 1, 0, "swim_stroke"));
            ++field_index;
            sessionMesg.addField(new com.garmin.fit.Field("pool_length", 44, 132, 100, 0, "m"));
            ++field_index;
            sessionMesg.addField(new com.garmin.fit.Field("pool_length_unit", 46, 0, 1, 0, ""));
            ++field_index;
            sessionMesg.addField(new com.garmin.fit.Field("num_active_lengths", 47, 132, 1, 0, "lengths"));
            ++field_index;
            sessionMesg.addField(new com.garmin.fit.Field("total_work", 48, 134, 1, 0, "J"));
            ++field_index;
            sessionMesg.addField(new com.garmin.fit.Field("avg_altitude", 49, 132, 5, 500, "m"));
            ++field_index;
            sessionMesg.addField(new com.garmin.fit.Field("max_altitude", 50, 132, 5, 500, "m"));
            ++field_index;
            sessionMesg.addField(new com.garmin.fit.Field("gps_accuracy", 51, 2, 1, 0, "m"));
            ++field_index;
            sessionMesg.addField(new com.garmin.fit.Field("avg_grade", 52, 131, 100, 0, "%"));
            ++field_index;
            sessionMesg.addField(new com.garmin.fit.Field("avg_pos_grade", 53, 131, 100, 0, "%"));
            ++field_index;
            sessionMesg.addField(new com.garmin.fit.Field("avg_neg_grade", 54, 131, 100, 0, "%"));
            ++field_index;
            sessionMesg.addField(new com.garmin.fit.Field("max_pos_grade", 55, 131, 100, 0, "%"));
            ++field_index;
            sessionMesg.addField(new com.garmin.fit.Field("max_neg_grade", 56, 131, 100, 0, "%"));
            ++field_index;
            sessionMesg.addField(new com.garmin.fit.Field("avg_temperature", 57, 1, 1, 0, "C"));
            ++field_index;
            sessionMesg.addField(new com.garmin.fit.Field("max_temperature", 58, 1, 1, 0, "C"));
            ++field_index;
            sessionMesg.addField(new com.garmin.fit.Field("total_moving_time", 59, 134, 1000, 0, "s"));
            ++field_index;
            sessionMesg.addField(new com.garmin.fit.Field("avg_pos_vertical_speed", 60, 131, 1000, 0, "m/s"));
            ++field_index;
            sessionMesg.addField(new com.garmin.fit.Field("avg_neg_vertical_speed", 61, 131, 1000, 0, "m/s"));
            ++field_index;
            sessionMesg.addField(new com.garmin.fit.Field("max_pos_vertical_speed", 62, 131, 1000, 0, "m/s"));
            ++field_index;
            sessionMesg.addField(new com.garmin.fit.Field("max_neg_vertical_speed", 63, 131, 1000, 0, "m/s"));
            ++field_index;
            sessionMesg.addField(new com.garmin.fit.Field("min_heart_rate", 64, 2, 1, 0, "bpm"));
            ++field_index;
            sessionMesg.addField(new com.garmin.fit.Field("time_in_hr_zone", 65, 134, 1000, 0, "s"));
            ++field_index;
            sessionMesg.addField(new com.garmin.fit.Field("time_in_speed_zone", 66, 134, 1000, 0, "s"));
            ++field_index;
            sessionMesg.addField(new com.garmin.fit.Field("time_in_cadence_zone", 67, 134, 1000, 0, "s"));
            ++field_index;
            sessionMesg.addField(new com.garmin.fit.Field("time_in_power_zone", 68, 134, 1000, 0, "s"));
            ++field_index;
            sessionMesg.addField(new com.garmin.fit.Field("avg_lap_time", 69, 134, 1000, 0, "s"));
            ++field_index;
            sessionMesg.addField(new com.garmin.fit.Field("best_lap_index", 70, 132, 1, 0, ""));
            ++field_index;
            sessionMesg.addField(new com.garmin.fit.Field("min_altitude", 71, 132, 5, 500, "m"));
            ++field_index;
        }

        internal static var field_index:int=0;

        internal static var subfield_index:int=0;

        internal static var _sessionMesg:com.garmin.fit.Mesg;
    }
}


//    class SessionTrigger
package com.garmin.fit 
{
    import __AS3__.vec.*;
    import avmplus.*;
    import flash.errors.*;
    
    public class SessionTrigger extends Object
    {
        public function SessionTrigger(arg1:Object, arg2:uint)
        {
            super();
            if (arg1 != SINGLETON_ENFORCER) 
            {
                throw new flash.errors.IllegalOperationError("IllegalOperation: Manipulation of type " + avmplus.getQualifiedClassName(this));
            }
            this.value = arg2;
            return;
        }

        public function getValue():uint
        {
            return value;
        }

        public static function getByValue(arg1:uint):com.garmin.fit.SessionTrigger
        {
            var loc3:*=0;
            var loc2:*=SessionTrigger.VALUES;
            for each (var loc1:* in loc2) 
            {
                if (!(arg1 == loc1.value)) 
                {
                    continue;
                }
                return loc1;
            }
            return SessionTrigger.INVALID;
        }

        
        {
            new __AS3__.vec.Vector.<>(5)[0] = ACTIVITY_END;
            new __AS3__.vec.Vector.<>(5)[1] = MANUAL;
            new __AS3__.vec.Vector.<>(5)[2] = AUTO_MULTI_SPORT;
            new __AS3__.vec.Vector.<>(5)[3] = FITNESS_EQUIPMENT;
            new __AS3__.vec.Vector.<>(5)[4] = INVALID;
        }

        internal static const SINGLETON_ENFORCER:Object={};

        public static const ACTIVITY_END:com.garmin.fit.SessionTrigger=new SessionTrigger(SINGLETON_ENFORCER, 0);

        public static const MANUAL:com.garmin.fit.SessionTrigger=new SessionTrigger(SINGLETON_ENFORCER, 1);

        public static const AUTO_MULTI_SPORT:com.garmin.fit.SessionTrigger=new SessionTrigger(SINGLETON_ENFORCER, 2);

        public static const FITNESS_EQUIPMENT:com.garmin.fit.SessionTrigger=new SessionTrigger(SINGLETON_ENFORCER, 3);

        public static const INVALID:com.garmin.fit.SessionTrigger=new SessionTrigger(SINGLETON_ENFORCER, 255);

        public static const VALUES:__AS3__.vec.Vector.<com.garmin.fit.SessionTrigger>=new __AS3__.vec.Vector.<>(5);

        internal var value:uint;
    }
}


//    class SlaveDeviceMesg
package com.garmin.fit 
{
    public class SlaveDeviceMesg extends com.garmin.fit.Mesg
    {
        public function SlaveDeviceMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(106));
            return;
        }

        public function getManufacturer():int
        {
            return getFieldIntegerValue(0, 0, 65535);
        }

        public function setManufacturer(arg1:int):void
        {
            setFieldValue(0, 0, arg1, 65535);
            return;
        }

        public function getProduct():int
        {
            return getFieldIntegerValue(1, 0, 65535);
        }

        public function setProduct(arg1:int):void
        {
            setFieldValue(1, 0, arg1, 65535);
            return;
        }

        public function getGarminProduct():int
        {
            return getFieldIntegerValue(1, 0, 0);
        }

        public function setGarminProduct(arg1:int):void
        {
            setFieldValue(1, 0, arg1, 0);
            return;
        }

        public static function get slaveDeviceMesg():com.garmin.fit.Mesg
        {
            return _slaveDeviceMesg;
        }

        
        {
            _slaveDeviceMesg = new com.garmin.fit.Mesg("slave_device", 106);
            slaveDeviceMesg.addField(new com.garmin.fit.Field("manufacturer", 0, 132, 1, 0, ""));
            ++field_index;
            slaveDeviceMesg.addField(new com.garmin.fit.Field("product", 1, 132, 1, 0, ""));
            subfield_index = 0;
            _slaveDeviceMesg.fields[field_index].subFields.push(new com.garmin.fit.SubField("garmin_product", 132, 1, 0, ""));
            _slaveDeviceMesg.fields[field_index].subFields[subfield_index].addMap(0, 1);
            _slaveDeviceMesg.fields[field_index].subFields[subfield_index].addMap(0, 15);
            _slaveDeviceMesg.fields[field_index].subFields[subfield_index].addMap(0, 13);
            ++subfield_index;
            ++field_index;
        }

        internal static var _slaveDeviceMesg:com.garmin.fit.Mesg;

        internal static var field_index:int=0;

        internal static var subfield_index:int=0;
    }
}


//    class SoftwareMesg
package com.garmin.fit 
{
    public class SoftwareMesg extends com.garmin.fit.Mesg
    {
        public function SoftwareMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(35));
            return;
        }

        public function getMessageIndex():int
        {
            return getFieldIntegerValue(254, 0, 65535);
        }

        public function setMessageIndex(arg1:int):void
        {
            setFieldValue(254, 0, arg1, 65535);
            return;
        }

        public function getVersion():Number
        {
            return getFieldDoubleValue(3, 0, 65535);
        }

        public function setVersion(arg1:Number):void
        {
            setFieldValue(3, 0, arg1, 65535);
            return;
        }

        public function getPartNumber():String
        {
            return getFieldStringValue(5, 0, 65535);
        }

        public function setPartNumber(arg1:String):void
        {
            setFieldValue(5, 0, arg1, 65535);
            return;
        }

        public static function get softwareMesg():com.garmin.fit.Mesg
        {
            return _softwareMesg;
        }

        
        {
            _softwareMesg = new com.garmin.fit.Mesg("software", 35);
            softwareMesg.addField(new com.garmin.fit.Field("message_index", 254, 132, 1, 0, ""));
            softwareMesg.addField(new com.garmin.fit.Field("version", 3, 132, 100, 0, ""));
            softwareMesg.addField(new com.garmin.fit.Field("part_number", 5, 7, 1, 0, ""));
        }

        internal static var _softwareMesg:com.garmin.fit.Mesg;
    }
}


//    class SpeedZoneMesg
package com.garmin.fit 
{
    public class SpeedZoneMesg extends com.garmin.fit.Mesg
    {
        public function SpeedZoneMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(53));
            return;
        }

        public function getMessageIndex():int
        {
            return getFieldIntegerValue(254, 0, 65535);
        }

        public function setMessageIndex(arg1:int):void
        {
            setFieldValue(254, 0, arg1, 65535);
            return;
        }

        public function getHighValue():Number
        {
            return getFieldDoubleValue(0, 0, 65535);
        }

        public function setHighValue(arg1:Number):void
        {
            setFieldValue(0, 0, arg1, 65535);
            return;
        }

        public override function getName():String
        {
            return getFieldStringValue(1, 0, 65535);
        }

        public function setName(arg1:String):void
        {
            setFieldValue(1, 0, arg1, 65535);
            return;
        }

        public static function get speedZoneMesg():com.garmin.fit.Mesg
        {
            return _speedZoneMesg;
        }

        
        {
            _speedZoneMesg = new com.garmin.fit.Mesg("speed_zone", 53);
            speedZoneMesg.addField(new com.garmin.fit.Field("message_index", 254, 132, 1, 0, ""));
            speedZoneMesg.addField(new com.garmin.fit.Field("high_value", 0, 132, 1000, 0, "m/s"));
            speedZoneMesg.addField(new com.garmin.fit.Field("name", 1, 7, 1, 0, ""));
        }

        internal static var _speedZoneMesg:com.garmin.fit.Mesg;
    }
}


//    class Sport
package com.garmin.fit 
{
    import __AS3__.vec.*;
    import avmplus.*;
    import com.garmin.fit.custom.*;
    import flash.errors.*;
    
    public class Sport extends com.garmin.fit.custom.BaseType
    {
        public function Sport(arg1:Object, arg2:uint)
        {
            super();
            if (arg1 != SINGLETON_ENFORCER) 
            {
                throw new flash.errors.IllegalOperationError("IllegalOperation: Manipulation of type " + avmplus.getQualifiedClassName(this));
            }
            this.value = arg2;
            return;
        }

        public function getAllValues():__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>
        {
            return VALUES;
        }

        public function getInvalid():com.garmin.fit.custom.BaseType
        {
            return INVALID;
        }

        public function getValue():uint
        {
            return value;
        }

        public static function getByValue(arg1:uint):com.garmin.fit.Sport
        {
            return com.garmin.fit.custom.BaseType.getByValue(arg1) as Sport;
        }

        
        {
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(13)[0] = GENERIC;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(13)[1] = RUNNING;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(13)[2] = CYCLING;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(13)[3] = TRANSITION;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(13)[4] = FITNESS_EQUIPMENT;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(13)[5] = SWIMMING;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(13)[6] = BASKETBALL;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(13)[7] = SOCCER;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(13)[8] = TENNIS;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(13)[9] = AMERICAN_FOOTBALL;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(13)[10] = TRAINING;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(13)[11] = ALL;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(13)[12] = INVALID;
        }

        internal static const SINGLETON_ENFORCER:Object={};

        public static const GENERIC:com.garmin.fit.Sport=new Sport(SINGLETON_ENFORCER, 0);

        public static const RUNNING:com.garmin.fit.Sport=new Sport(SINGLETON_ENFORCER, 1);

        public static const CYCLING:com.garmin.fit.Sport=new Sport(SINGLETON_ENFORCER, 2);

        public static const TRANSITION:com.garmin.fit.Sport=new Sport(SINGLETON_ENFORCER, 3);

        public static const FITNESS_EQUIPMENT:com.garmin.fit.Sport=new Sport(SINGLETON_ENFORCER, 4);

        public static const SWIMMING:com.garmin.fit.Sport=new Sport(SINGLETON_ENFORCER, 5);

        public static const BASKETBALL:com.garmin.fit.Sport=new Sport(SINGLETON_ENFORCER, 6);

        public static const SOCCER:com.garmin.fit.Sport=new Sport(SINGLETON_ENFORCER, 7);

        public static const TENNIS:com.garmin.fit.Sport=new Sport(SINGLETON_ENFORCER, 8);

        public static const AMERICAN_FOOTBALL:com.garmin.fit.Sport=new Sport(SINGLETON_ENFORCER, 9);

        public static const TRAINING:com.garmin.fit.Sport=new Sport(SINGLETON_ENFORCER, 10);

        public static const ALL:com.garmin.fit.Sport=new Sport(SINGLETON_ENFORCER, 254);

        public static const INVALID:com.garmin.fit.Sport=new Sport(SINGLETON_ENFORCER, 255);

        public static const VALUES:__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>=new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(13);
    }
}


//    class SportMesg
package com.garmin.fit 
{
    public class SportMesg extends com.garmin.fit.Mesg
    {
        public function SportMesg(arg1:com.garmin.fit.Mesg=null)
        {
            if (arg1 == null) 
            {
                arg1 = com.garmin.fit.Factory.createMesg(12);
            }
            super(arg1);
            return;
        }

        public function getSport():com.garmin.fit.Sport
        {
            var loc1:*=getFieldIntegerValue(0, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.Sport.getByValue(loc1);
        }

        public function setSport(arg1:com.garmin.fit.Sport):void
        {
            setFieldValue(0, 0, arg1.getValue(), 65535);
            return;
        }

        public function getSubSport():com.garmin.fit.SubSport
        {
            var loc1:*=getFieldIntegerValue(1, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.SubSport.getByValue(loc1);
        }

        public function setSubSport(arg1:com.garmin.fit.SubSport):void
        {
            setFieldValue(1, 0, arg1.getValue(), 65535);
            return;
        }

        public override function getName():String
        {
            return getFieldStringValue(3, 0, 65535);
        }

        public function setName(arg1:String):void
        {
            setFieldValue(3, 0, arg1, 65535);
            return;
        }

        public static function get sportMesg():com.garmin.fit.Mesg
        {
            return _sportMesg;
        }

        
        {
            _sportMesg = new com.garmin.fit.Mesg("sport", 12);
            sportMesg.addField(new com.garmin.fit.Field("sport", 0, 0, 1, 0, ""));
            sportMesg.addField(new com.garmin.fit.Field("sub_sport", 1, 0, 1, 0, ""));
            sportMesg.addField(new com.garmin.fit.Field("name", 3, 7, 1, 0, ""));
        }

        internal static var _sportMesg:com.garmin.fit.Mesg;
    }
}


//    class SubField
package com.garmin.fit 
{
    import __AS3__.vec.*;
    
    public class SubField extends Object
    {
        public function SubField(arg1:String, arg2:int, arg3:Number, arg4:Number, arg5:String)
        {
            super();
            this._name = new String(arg1);
            this._type = arg2;
            this._scale = arg3;
            this._offset = arg4;
            this._units = new String(arg5);
            this.maps = new __AS3__.vec.Vector.<SubFieldMap>(0);
            return;
        }

        public function get name():String
        {
            return _name;
        }

        public function get type():int
        {
            return _type;
        }

        public function get scale():Number
        {
            return _scale;
        }

        public function get offset():Number
        {
            return _offset;
        }

        public function get units():String
        {
            return _units;
        }

        protected function getName():String
        {
            return name;
        }

        protected function getType():int
        {
            return type;
        }

        protected function getUnits():String
        {
            return units;
        }

        public function addMap(arg1:int, arg2:Number):void
        {
            maps.push(new SubFieldMap(arg1, arg2));
            return;
        }

        public function canMesgSupport(arg1:com.garmin.fit.Mesg):Boolean
        {
            var loc3:*=0;
            var loc2:*=maps;
            for each (var loc1:* in loc2) 
            {
                if (!loc1.canMesgSupport(arg1)) 
                {
                    continue;
                }
                return true;
            }
            return false;
        }

        internal var _name:String;

        internal var _type:int;

        internal var _scale:Number;

        internal var _offset:Number;

        internal var _units:String;

        internal var maps:__AS3__.vec.Vector.<SubFieldMap>;
    }
}


class SubFieldMap extends Object
{
    public function SubFieldMap(arg1:int, arg2:Number)
    {
        super();
        this.refFieldNum = arg1;
        this.refFieldValue = arg2;
        return;
    }

    public function canMesgSupport(arg1:com.garmin.fit.Mesg):Boolean
    {
        var loc2:*=NaN;
        var loc1:*=arg1.getField(refFieldNum);
        if (loc1 != null) 
        {
            loc2 = loc1.getLongValue(0, 65535);
            if (!isNaN(loc2)) 
            {
                if (loc2 == refFieldValue) 
                {
                    return true;
                }
            }
        }
        return false;
    }

    internal var refFieldNum:int;

    internal var refFieldValue:Number;
}

//    class SubSport
package com.garmin.fit 
{
    import __AS3__.vec.*;
    import avmplus.*;
    import com.garmin.fit.custom.*;
    import flash.errors.*;
    
    public class SubSport extends com.garmin.fit.custom.BaseType
    {
        public function SubSport(arg1:Object, arg2:uint)
        {
            super();
            if (arg1 != SINGLETON_ENFORCER) 
            {
                throw new flash.errors.IllegalOperationError("IllegalOperation: Manipulation of type " + avmplus.getQualifiedClassName(this));
            }
            this.value = arg2;
            return;
        }

        public function getAllValues():__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>
        {
            return VALUES;
        }

        public function getInvalid():com.garmin.fit.custom.BaseType
        {
            return INVALID;
        }

        public function getValue():uint
        {
            return value;
        }

        public static function getByValue(arg1:uint):com.garmin.fit.SubSport
        {
            return com.garmin.fit.custom.BaseType.getByValue(arg1) as SubSport;
        }

        
        {
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(23)[0] = GENERIC;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(23)[1] = TREADMILL;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(23)[2] = STREET;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(23)[3] = TRAIL;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(23)[4] = TRACK;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(23)[5] = SPIN;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(23)[6] = INDOOR_CYCLING;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(23)[7] = ROAD;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(23)[8] = MOUNTAIN;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(23)[9] = DOWNHILL;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(23)[10] = RECUMBENT;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(23)[11] = CYCLOCROSS;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(23)[12] = HAND_CYCLING;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(23)[13] = TRACK_CYCLING;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(23)[14] = INDOOR_ROWING;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(23)[15] = ELLIPTICAL;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(23)[16] = STAIR_CLIMBING;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(23)[17] = LAP_SWIMMING;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(23)[18] = OPEN_WATER;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(23)[19] = FLEXIBILITY_TRAINING;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(23)[20] = STRENGTH_TRAINING;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(23)[21] = ALL;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(23)[22] = INVALID;
        }

        internal static const SINGLETON_ENFORCER:Object={};

        public static const GENERIC:com.garmin.fit.SubSport=new SubSport(SINGLETON_ENFORCER, 0);

        public static const TREADMILL:com.garmin.fit.SubSport=new SubSport(SINGLETON_ENFORCER, 1);

        public static const STREET:com.garmin.fit.SubSport=new SubSport(SINGLETON_ENFORCER, 2);

        public static const TRAIL:com.garmin.fit.SubSport=new SubSport(SINGLETON_ENFORCER, 3);

        public static const TRACK:com.garmin.fit.SubSport=new SubSport(SINGLETON_ENFORCER, 4);

        public static const SPIN:com.garmin.fit.SubSport=new SubSport(SINGLETON_ENFORCER, 5);

        public static const INDOOR_CYCLING:com.garmin.fit.SubSport=new SubSport(SINGLETON_ENFORCER, 6);

        public static const ROAD:com.garmin.fit.SubSport=new SubSport(SINGLETON_ENFORCER, 7);

        public static const MOUNTAIN:com.garmin.fit.SubSport=new SubSport(SINGLETON_ENFORCER, 8);

        public static const DOWNHILL:com.garmin.fit.SubSport=new SubSport(SINGLETON_ENFORCER, 9);

        public static const RECUMBENT:com.garmin.fit.SubSport=new SubSport(SINGLETON_ENFORCER, 10);

        public static const CYCLOCROSS:com.garmin.fit.SubSport=new SubSport(SINGLETON_ENFORCER, 11);

        public static const HAND_CYCLING:com.garmin.fit.SubSport=new SubSport(SINGLETON_ENFORCER, 12);

        public static const TRACK_CYCLING:com.garmin.fit.SubSport=new SubSport(SINGLETON_ENFORCER, 13);

        public static const INDOOR_ROWING:com.garmin.fit.SubSport=new SubSport(SINGLETON_ENFORCER, 14);

        public static const ELLIPTICAL:com.garmin.fit.SubSport=new SubSport(SINGLETON_ENFORCER, 15);

        public static const STAIR_CLIMBING:com.garmin.fit.SubSport=new SubSport(SINGLETON_ENFORCER, 16);

        public static const LAP_SWIMMING:com.garmin.fit.SubSport=new SubSport(SINGLETON_ENFORCER, 17);

        public static const OPEN_WATER:com.garmin.fit.SubSport=new SubSport(SINGLETON_ENFORCER, 18);

        public static const FLEXIBILITY_TRAINING:com.garmin.fit.SubSport=new SubSport(SINGLETON_ENFORCER, 19);

        public static const STRENGTH_TRAINING:com.garmin.fit.SubSport=new SubSport(SINGLETON_ENFORCER, 20);

        public static const ALL:com.garmin.fit.SubSport=new SubSport(SINGLETON_ENFORCER, 254);

        public static const INVALID:com.garmin.fit.SubSport=new SubSport(SINGLETON_ENFORCER, 255);

        internal static const VALUES:__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>=new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(23);
    }
}


//    class SwimStroke
package com.garmin.fit 
{
    import __AS3__.vec.*;
    import avmplus.*;
    import com.garmin.fit.custom.*;
    import flash.errors.*;
    
    public class SwimStroke extends com.garmin.fit.custom.BaseType
    {
        public function SwimStroke(arg1:Object, arg2:uint)
        {
            super();
            if (arg1 != SINGLETON_ENFORCER) 
            {
                throw new flash.errors.IllegalOperationError("IllegalOperation: Manipulation of type " + avmplus.getQualifiedClassName(this));
            }
            this.value = arg2;
            return;
        }

        public function getAllValues():__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>
        {
            return VALUES;
        }

        public function getInvalid():com.garmin.fit.custom.BaseType
        {
            return INVALID;
        }

        public function getValue():uint
        {
            return value;
        }

        public static function getByValue(arg1:uint):com.garmin.fit.SwimStroke
        {
            return com.garmin.fit.custom.BaseType.getByValue(arg1) as SwimStroke;
        }

        
        {
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(8)[0] = FREESTYLE;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(8)[1] = BACKSTROKE;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(8)[2] = BREASTSTROKE;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(8)[3] = BUTTERFLY;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(8)[4] = DRILL;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(8)[5] = MIXED;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(8)[6] = IM;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(8)[7] = INVALID;
        }

        internal static const SINGLETON_ENFORCER:Object={};

        public static const FREESTYLE:com.garmin.fit.SwimStroke=new SwimStroke(SINGLETON_ENFORCER, 0);

        public static const BACKSTROKE:com.garmin.fit.SwimStroke=new SwimStroke(SINGLETON_ENFORCER, 1);

        public static const BREASTSTROKE:com.garmin.fit.SwimStroke=new SwimStroke(SINGLETON_ENFORCER, 2);

        public static const BUTTERFLY:com.garmin.fit.SwimStroke=new SwimStroke(SINGLETON_ENFORCER, 3);

        public static const DRILL:com.garmin.fit.SwimStroke=new SwimStroke(SINGLETON_ENFORCER, 4);

        public static const MIXED:com.garmin.fit.SwimStroke=new SwimStroke(SINGLETON_ENFORCER, 5);

        public static const IM:com.garmin.fit.SwimStroke=new SwimStroke(SINGLETON_ENFORCER, 6);

        public static const INVALID:com.garmin.fit.SwimStroke=new SwimStroke(SINGLETON_ENFORCER, 255);

        internal static const VALUES:__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>=new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(8);
    }
}


//    class TimerTrigger
package com.garmin.fit 
{
    import __AS3__.vec.*;
    import avmplus.*;
    import com.garmin.fit.custom.*;
    import flash.errors.*;
    
    public class TimerTrigger extends com.garmin.fit.custom.BaseType
    {
        public function TimerTrigger(arg1:Object, arg2:uint)
        {
            super();
            if (arg1 != SINGLETON_ENFORCER) 
            {
                throw new flash.errors.IllegalOperationError("IllegalOperation: Manipulation of type " + avmplus.getQualifiedClassName(this));
            }
            this.value = arg2;
            return;
        }

        public function getAllValues():__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>
        {
            return VALUES;
        }

        public function getInvalid():com.garmin.fit.custom.BaseType
        {
            return INVALID;
        }

        public function getValue():uint
        {
            return value;
        }

        public static function getByValue(arg1:uint):com.garmin.fit.TimerTrigger
        {
            return com.garmin.fit.custom.BaseType.getByValue(arg1) as TimerTrigger;
        }

        
        {
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(4)[0] = MANUAL;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(4)[1] = AUTO;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(4)[2] = FITNESS_EQUIPMENT;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(4)[3] = INVALID;
        }

        internal static const SINGLETON_ENFORCER:Object={};

        public static const MANUAL:com.garmin.fit.TimerTrigger=new TimerTrigger(SINGLETON_ENFORCER, 0);

        public static const AUTO:com.garmin.fit.TimerTrigger=new TimerTrigger(SINGLETON_ENFORCER, 1);

        public static const FITNESS_EQUIPMENT:com.garmin.fit.TimerTrigger=new TimerTrigger(SINGLETON_ENFORCER, 2);

        public static const INVALID:com.garmin.fit.TimerTrigger=new TimerTrigger(SINGLETON_ENFORCER, 255);

        internal static const VALUES:__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>=new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(4);
    }
}


//    class TotalsMesg
package com.garmin.fit 
{
    public class TotalsMesg extends com.garmin.fit.Mesg
    {
        public function TotalsMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(33));
            return;
        }

        public function getMessageIndex():int
        {
            return getFieldIntegerValue(254, 0, 65535);
        }

        public function setMessageIndex(arg1:int):void
        {
            setFieldValue(254, 0, arg1, 65535);
            return;
        }

        public function getTimestamp():com.garmin.fit.DateTime
        {
            return timestampToDateTime(getFieldDoubleValue(253, 0, 65535));
        }

        public function setTimestamp(arg1:com.garmin.fit.DateTime):void
        {
            setFieldValue(253, 0, arg1.getTimestamp(), 65535);
            return;
        }

        public function getTimerTime():Number
        {
            return getFieldDoubleValue(0, 0, 65535);
        }

        public function setTimerTime(arg1:Number):void
        {
            setFieldValue(0, 0, arg1, 65535);
            return;
        }

        public function getDistance():Number
        {
            return getFieldDoubleValue(1, 0, 65535);
        }

        public function setDistance(arg1:Number):void
        {
            setFieldValue(1, 0, arg1, 65535);
            return;
        }

        public function getCalories():Number
        {
            return getFieldDoubleValue(2, 0, 65535);
        }

        public function setCalories(arg1:Number):void
        {
            setFieldValue(2, 0, arg1, 65535);
            return;
        }

        public function getSport():com.garmin.fit.Sport
        {
            var loc1:*=getFieldIntegerValue(3, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.Sport.getByValue(loc1);
        }

        public function setSport(arg1:com.garmin.fit.Sport):void
        {
            setFieldValue(3, 0, arg1.getValue(), 65535);
            return;
        }

        public function getElapsedTime():Number
        {
            return getFieldDoubleValue(4, 0, 65535);
        }

        public function setElapsedTime(arg1:Number):void
        {
            setFieldValue(4, 0, arg1, 65535);
            return;
        }

        public function getSessions():int
        {
            return getFieldIntegerValue(5, 0, 65535);
        }

        public function setSessions(arg1:int):void
        {
            setFieldValue(5, 0, arg1, 65535);
            return;
        }

        public function getActiveTime():Number
        {
            return getFieldDoubleValue(6, 0, 65535);
        }

        public function setActiveTime(arg1:Number):void
        {
            setFieldValue(6, 0, arg1, 65535);
            return;
        }

        public static function get totalsMesg():com.garmin.fit.Mesg
        {
            return _totalsMesg;
        }

        
        {
            _totalsMesg = new com.garmin.fit.Mesg("totals", 33);
            totalsMesg.addField(new com.garmin.fit.Field("message_index", 254, 132, 1, 0, ""));
            totalsMesg.addField(new com.garmin.fit.Field("timestamp", 253, 134, 1, 0, "s"));
            totalsMesg.addField(new com.garmin.fit.Field("timer_time", 0, 134, 1, 0, "s"));
            totalsMesg.addField(new com.garmin.fit.Field("distance", 1, 134, 1, 0, "m"));
            totalsMesg.addField(new com.garmin.fit.Field("calories", 2, 134, 1, 0, "kcal"));
            totalsMesg.addField(new com.garmin.fit.Field("sport", 3, 0, 1, 0, ""));
            totalsMesg.addField(new com.garmin.fit.Field("elapsed_time", 4, 134, 1, 0, "s"));
            totalsMesg.addField(new com.garmin.fit.Field("sessions", 5, 132, 1, 0, ""));
            totalsMesg.addField(new com.garmin.fit.Field("active_time", 6, 134, 1, 0, "s"));
        }

        internal static var _totalsMesg:com.garmin.fit.Mesg;
    }
}


//    class UserProfileMesg
package com.garmin.fit 
{
    public class UserProfileMesg extends com.garmin.fit.Mesg
    {
        public function UserProfileMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(3));
            return;
        }

        public function getMessageIndex():int
        {
            return getFieldIntegerValue(254, 0, 65535);
        }

        public function setMessageIndex(arg1:int):void
        {
            setFieldValue(254, 0, arg1, 65535);
            return;
        }

        public function getFriendlyName():String
        {
            return getFieldStringValue(0, 0, 65535);
        }

        public function setFriendlyName(arg1:String):void
        {
            setFieldValue(0, 0, arg1, 65535);
            return;
        }

        public function getGender():com.garmin.fit.Gender
        {
            var loc1:*=getFieldIntegerValue(1, 0, 65535);
            if (!loc1) 
            {
                return null;
            }
            return com.garmin.fit.Gender.getByValue(loc1);
        }

        public function setGender(arg1:com.garmin.fit.Gender):void
        {
            setFieldValue(1, 0, arg1.getValue(), 65535);
            return;
        }

        public function getAge():int
        {
            return getFieldIntegerValue(2, 0, 65535);
        }

        public function setAge(arg1:int):void
        {
            setFieldValue(2, 0, arg1, 65535);
            return;
        }

        public function getHeight():Number
        {
            return getFieldDoubleValue(3, 0, 65535);
        }

        public function setHeight(arg1:Number):void
        {
            setFieldValue(3, 0, arg1, 65535);
            return;
        }

        public function getWeight():Number
        {
            return getFieldDoubleValue(4, 0, 65535);
        }

        public function setWeight(arg1:Number):void
        {
            setFieldValue(4, 0, arg1, 65535);
            return;
        }

        public function getLanguage():com.garmin.fit.Language
        {
            var loc1:*=getFieldIntegerValue(5, 0, 65535);
            if (!loc1) 
            {
                return null;
            }
            return com.garmin.fit.Language.getByValue(loc1);
        }

        public function setLanguage(arg1:com.garmin.fit.Language):void
        {
            setFieldValue(5, 0, arg1.getValue(), 65535);
            return;
        }

        public function getElevSetting():com.garmin.fit.DisplayMeasure
        {
            var loc1:*=getFieldIntegerValue(6, 0, 65535);
            if (!loc1) 
            {
                return null;
            }
            return com.garmin.fit.DisplayMeasure.getByValue(loc1);
        }

        public function setElevSetting(arg1:com.garmin.fit.DisplayMeasure):void
        {
            setFieldValue(6, 0, arg1.getValue(), 65535);
            return;
        }

        public function getWeightSetting():com.garmin.fit.DisplayMeasure
        {
            var loc1:*=getFieldIntegerValue(7, 0, 65535);
            if (!loc1) 
            {
                return null;
            }
            return com.garmin.fit.DisplayMeasure.getByValue(loc1);
        }

        public function setWeightSetting(arg1:com.garmin.fit.DisplayMeasure):void
        {
            setFieldValue(7, 0, arg1.getValue(), 65535);
            return;
        }

        public function getRestingHeartRate():int
        {
            return getFieldIntegerValue(8, 0, 65535);
        }

        public function setRestingHeartRate(arg1:int):void
        {
            setFieldValue(8, 0, arg1, 65535);
            return;
        }

        public function getDefaultMaxRunningHeartRate():int
        {
            return getFieldIntegerValue(9, 0, 65535);
        }

        public function setDefaultMaxRunningHeartRate(arg1:int):void
        {
            setFieldValue(9, 0, arg1, 65535);
            return;
        }

        public function getDefaultMaxBikingHeartRate():int
        {
            return getFieldIntegerValue(10, 0, 65535);
        }

        public function setDefaultMaxBikingHeartRate(arg1:int):void
        {
            setFieldValue(10, 0, arg1, 65535);
            return;
        }

        public function getDefaultMaxHeartRate():int
        {
            return getFieldIntegerValue(11, 0, 65535);
        }

        public function setDefaultMaxHeartRate(arg1:int):void
        {
            setFieldValue(11, 0, arg1, 65535);
            return;
        }

        public function getHrSetting():com.garmin.fit.DisplayHeart
        {
            var loc1:*=getFieldIntegerValue(12, 0, 65535);
            if (!loc1) 
            {
                return null;
            }
            return com.garmin.fit.DisplayHeart.getByValue(loc1);
        }

        public function setHrSetting(arg1:com.garmin.fit.DisplayHeart):void
        {
            setFieldValue(12, 0, arg1.getValue(), 65535);
            return;
        }

        public function getSpeedSetting():com.garmin.fit.DisplayMeasure
        {
            var loc1:*=getFieldIntegerValue(13, 0, 65535);
            if (!loc1) 
            {
                return null;
            }
            return com.garmin.fit.DisplayMeasure.getByValue(loc1);
        }

        public function setSpeedSetting(arg1:com.garmin.fit.DisplayMeasure):void
        {
            setFieldValue(13, 0, arg1.getValue(), 65535);
            return;
        }

        public function getDistSetting():com.garmin.fit.DisplayMeasure
        {
            var loc1:*=getFieldIntegerValue(14, 0, 65535);
            if (!loc1) 
            {
                return null;
            }
            return com.garmin.fit.DisplayMeasure.getByValue(loc1);
        }

        public function setDistSetting(arg1:com.garmin.fit.DisplayMeasure):void
        {
            setFieldValue(14, 0, arg1.getValue(), 65535);
            return;
        }

        public function getPowerSetting():com.garmin.fit.DisplayPower
        {
            var loc1:*=getFieldIntegerValue(16, 0, 65535);
            if (!loc1) 
            {
                return null;
            }
            return com.garmin.fit.DisplayPower.getByValue(loc1);
        }

        public function setPowerSetting(arg1:com.garmin.fit.DisplayPower):void
        {
            setFieldValue(16, 0, arg1.getValue(), 65535);
            return;
        }

        public function getActivityClass():com.garmin.fit.ActivityClass
        {
            var loc1:*=getFieldIntegerValue(17, 0, 65535);
            if (!loc1) 
            {
                return null;
            }
            return com.garmin.fit.ActivityClass.getByValue(loc1);
        }

        public function setActivityClass(arg1:com.garmin.fit.ActivityClass):void
        {
            setFieldValue(17, 0, arg1.getValue(), 65535);
            return;
        }

        public function getPositionSetting():com.garmin.fit.DisplayPosition
        {
            var loc1:*=getFieldIntegerValue(18, 0, 65535);
            if (!loc1) 
            {
                return null;
            }
            return com.garmin.fit.DisplayPosition.getByValue(loc1);
        }

        public function setPositionSetting(arg1:com.garmin.fit.DisplayPosition):void
        {
            setFieldValue(18, 0, arg1.getValue(), 65535);
            return;
        }

        public function getTemperatureSetting():com.garmin.fit.DisplayMeasure
        {
            var loc1:*=getFieldIntegerValue(21, 0, 65535);
            if (!loc1) 
            {
                return null;
            }
            return com.garmin.fit.DisplayMeasure.getByValue(loc1);
        }

        public function setTemperatureSetting(arg1:com.garmin.fit.DisplayMeasure):void
        {
            setFieldValue(21, 0, arg1.getValue(), 65535);
            return;
        }

        public function getLocalId():int
        {
            return getFieldIntegerValue(22, 0, 65535);
        }

        public function setLocalId(arg1:int):void
        {
            setFieldValue(22, 0, arg1, 65535);
            return;
        }

        public function getNumGlobalId():int
        {
            return getNumFieldValues(23, 65535);
        }

        public function getGlobalId(arg1:int):int
        {
            return getFieldIntegerValue(23, arg1, 65535);
        }

        public function setGlobalId(arg1:int, arg2:int):void
        {
            setFieldValue(23, arg1, arg2, 65535);
            return;
        }

        public static function get userProfileMesg():com.garmin.fit.Mesg
        {
            return _userProfileMesg;
        }

        
        {
            _userProfileMesg = new com.garmin.fit.Mesg("user_profile", 3);
            userProfileMesg.addField(new com.garmin.fit.Field("message_index", 254, 132, 1, 0, ""));
            userProfileMesg.addField(new com.garmin.fit.Field("friendly_name", 0, 7, 1, 0, ""));
            userProfileMesg.addField(new com.garmin.fit.Field("gender", 1, 0, 1, 0, ""));
            userProfileMesg.addField(new com.garmin.fit.Field("age", 2, 2, 1, 0, "years"));
            userProfileMesg.addField(new com.garmin.fit.Field("height", 3, 2, 100, 0, "m"));
            userProfileMesg.addField(new com.garmin.fit.Field("weight", 4, 132, 10, 0, "kg"));
            userProfileMesg.addField(new com.garmin.fit.Field("language", 5, 0, 1, 0, ""));
            userProfileMesg.addField(new com.garmin.fit.Field("elev_setting", 6, 0, 1, 0, ""));
            userProfileMesg.addField(new com.garmin.fit.Field("weight_setting", 7, 0, 1, 0, ""));
            userProfileMesg.addField(new com.garmin.fit.Field("resting_heart_rate", 8, 2, 1, 0, "bpm"));
            userProfileMesg.addField(new com.garmin.fit.Field("default_max_running_heart_rate", 9, 2, 1, 0, "bpm"));
            userProfileMesg.addField(new com.garmin.fit.Field("default_max_biking_heart_rate", 10, 2, 1, 0, "bpm"));
            userProfileMesg.addField(new com.garmin.fit.Field("default_max_heart_rate", 11, 2, 1, 0, "bpm"));
            userProfileMesg.addField(new com.garmin.fit.Field("hr_setting", 12, 0, 1, 0, ""));
            userProfileMesg.addField(new com.garmin.fit.Field("speed_setting", 13, 0, 1, 0, ""));
            userProfileMesg.addField(new com.garmin.fit.Field("dist_setting", 14, 0, 1, 0, ""));
            userProfileMesg.addField(new com.garmin.fit.Field("power_setting", 16, 0, 1, 0, ""));
            userProfileMesg.addField(new com.garmin.fit.Field("activity_class", 17, 0, 1, 0, ""));
            userProfileMesg.addField(new com.garmin.fit.Field("position_setting", 18, 0, 1, 0, ""));
            userProfileMesg.addField(new com.garmin.fit.Field("temperature_setting", 21, 0, 1, 0, ""));
            userProfileMesg.addField(new com.garmin.fit.Field("local_id", 22, 132, 1, 0, ""));
            userProfileMesg.addField(new com.garmin.fit.Field("global_id", 23, 13, 1, 0, ""));
        }

        internal static var _userProfileMesg:com.garmin.fit.Mesg;
    }
}


//    class WeightScaleMesg
package com.garmin.fit 
{
    public class WeightScaleMesg extends com.garmin.fit.Mesg
    {
        public function WeightScaleMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(30));
            return;
        }

        public function getTimestamp():com.garmin.fit.DateTime
        {
            return timestampToDateTime(getFieldDoubleValue(253, 0, 65535));
        }

        public function setTimestamp(arg1:com.garmin.fit.DateTime):void
        {
            setFieldValue(253, 0, arg1.getTimestamp(), 65535);
            return;
        }

        public function getWeight():Number
        {
            return getFieldDoubleValue(0, 0, 65535);
        }

        public function setWeight(arg1:Number):void
        {
            setFieldValue(0, 0, arg1, 65535);
            return;
        }

        public function getPercentFat():Number
        {
            return getFieldDoubleValue(1, 0, 65535);
        }

        public function setPercentFat(arg1:Number):void
        {
            setFieldValue(1, 0, arg1, 65535);
            return;
        }

        public function getPercentHydration():Number
        {
            return getFieldDoubleValue(2, 0, 65535);
        }

        public function setPercentHydration(arg1:Number):void
        {
            setFieldValue(2, 0, arg1, 65535);
            return;
        }

        public function getVisceralFatMass():Number
        {
            return getFieldDoubleValue(3, 0, 65535);
        }

        public function setVisceralFatMass(arg1:Number):void
        {
            setFieldValue(3, 0, arg1, 65535);
            return;
        }

        public function getBoneMass():Number
        {
            return getFieldDoubleValue(4, 0, 65535);
        }

        public function setBoneMass(arg1:Number):void
        {
            setFieldValue(4, 0, arg1, 65535);
            return;
        }

        public function getMuscleMass():Number
        {
            return getFieldDoubleValue(5, 0, 65535);
        }

        public function setMuscleMass(arg1:Number):void
        {
            setFieldValue(5, 0, arg1, 65535);
            return;
        }

        public function getBasalMet():Number
        {
            return getFieldDoubleValue(7, 0, 65535);
        }

        public function setBasalMet(arg1:Number):void
        {
            setFieldValue(7, 0, arg1, 65535);
            return;
        }

        public function getPhysiqueRating():int
        {
            return getFieldIntegerValue(8, 0, 65535);
        }

        public function setPhysiqueRating(arg1:int):void
        {
            setFieldValue(8, 0, arg1, 65535);
            return;
        }

        public function getActiveMet():Number
        {
            return getFieldDoubleValue(9, 0, 65535);
        }

        public function setActiveMet(arg1:Number):void
        {
            setFieldValue(9, 0, arg1, 65535);
            return;
        }

        public function getMetabolicAge():int
        {
            return getFieldIntegerValue(10, 0, 65535);
        }

        public function setMetabolicAge(arg1:int):void
        {
            setFieldValue(10, 0, arg1, 65535);
            return;
        }

        public function getVisceralFatRating():int
        {
            return getFieldIntegerValue(11, 0, 65535);
        }

        public function setVisceralFatRating(arg1:int):void
        {
            setFieldValue(11, 0, arg1, 65535);
            return;
        }

        public function getUserProfileIndex():int
        {
            return getFieldIntegerValue(12, 0, 65535);
        }

        public function setUserProfileIndex(arg1:int):void
        {
            setFieldValue(12, 0, arg1, 65535);
            return;
        }

        public static function get weightScaleMesg():com.garmin.fit.Mesg
        {
            return _weightScaleMesg;
        }

        
        {
            _weightScaleMesg = new com.garmin.fit.Mesg("weight_scale", 30);
            weightScaleMesg.addField(new com.garmin.fit.Field("timestamp", 253, 134, 1, 0, "s"));
            weightScaleMesg.addField(new com.garmin.fit.Field("weight", 0, 132, 100, 0, "kg"));
            weightScaleMesg.addField(new com.garmin.fit.Field("percent_fat", 1, 132, 100, 0, "%"));
            weightScaleMesg.addField(new com.garmin.fit.Field("percent_hydration", 2, 132, 100, 0, "%"));
            weightScaleMesg.addField(new com.garmin.fit.Field("visceral_fat_mass", 3, 132, 100, 0, "kg"));
            weightScaleMesg.addField(new com.garmin.fit.Field("bone_mass", 4, 132, 100, 0, "kg"));
            weightScaleMesg.addField(new com.garmin.fit.Field("muscle_mass", 5, 132, 100, 0, "kg"));
            weightScaleMesg.addField(new com.garmin.fit.Field("basal_met", 7, 132, 4, 0, "kcal/day"));
            weightScaleMesg.addField(new com.garmin.fit.Field("physique_rating", 8, 2, 1, 0, ""));
            weightScaleMesg.addField(new com.garmin.fit.Field("active_met", 9, 132, 4, 0, "kcal/day"));
            weightScaleMesg.addField(new com.garmin.fit.Field("metabolic_age", 10, 2, 1, 0, "years"));
            weightScaleMesg.addField(new com.garmin.fit.Field("visceral_fat_rating", 11, 2, 1, 0, ""));
            weightScaleMesg.addField(new com.garmin.fit.Field("user_profile_index", 12, 132, 1, 0, ""));
        }

        internal static var _weightScaleMesg:com.garmin.fit.Mesg;
    }
}


//    class WktStepDuration
package com.garmin.fit 
{
    import __AS3__.vec.*;
    import avmplus.*;
    import com.garmin.fit.custom.*;
    import flash.errors.*;
    
    public class WktStepDuration extends com.garmin.fit.custom.BaseType
    {
        public function WktStepDuration(arg1:Object, arg2:uint)
        {
            super();
            if (arg1 != SINGLETON_ENFORCER) 
            {
                throw new flash.errors.IllegalOperationError("IllegalOperation: Manipulation of type " + avmplus.getQualifiedClassName(this));
            }
            this.value = arg2;
            return;
        }

        public function getAllValues():__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>
        {
            return VALUES;
        }

        public function getInvalid():com.garmin.fit.custom.BaseType
        {
            return INVALID;
        }

        public function getValue():uint
        {
            return value;
        }

        public static function getByValue(arg1:uint):com.garmin.fit.WktStepDuration
        {
            return com.garmin.fit.custom.BaseType.getByValue(arg1) as WktStepDuration;
        }

        
        {
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(17)[0] = TIME;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(17)[1] = DISTANCE;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(17)[2] = HR_LESS_THAN;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(17)[3] = HR_GREATER_THAN;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(17)[4] = CALORIES;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(17)[5] = OPEN;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(17)[6] = REPEAT_UNTIL_STEPS_CMPLT;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(17)[7] = REPEAT_UNTIL_TIME;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(17)[8] = REPEAT_UNTIL_DISTANCE;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(17)[9] = REPEAT_UNTIL_CALORIES;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(17)[10] = REPEAT_UNTIL_HR_LESS_THAN;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(17)[11] = REPEAT_UNTIL_HR_GREATER_THAN;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(17)[12] = REPEAT_UNTIL_POWER_LESS_THAN;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(17)[13] = REPEAT_UNTIL_POWER_GREATER_THAN;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(17)[14] = POWER_LESS_THAN;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(17)[15] = POWER_GREATER_THAN;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(17)[16] = INVALID;
        }

        internal static const SINGLETON_ENFORCER:Object={};

        public static const TIME:com.garmin.fit.WktStepDuration=new WktStepDuration(SINGLETON_ENFORCER, 0);

        public static const DISTANCE:com.garmin.fit.WktStepDuration=new WktStepDuration(SINGLETON_ENFORCER, 1);

        public static const HR_LESS_THAN:com.garmin.fit.WktStepDuration=new WktStepDuration(SINGLETON_ENFORCER, 2);

        public static const HR_GREATER_THAN:com.garmin.fit.WktStepDuration=new WktStepDuration(SINGLETON_ENFORCER, 3);

        public static const CALORIES:com.garmin.fit.WktStepDuration=new WktStepDuration(SINGLETON_ENFORCER, 4);

        public static const OPEN:com.garmin.fit.WktStepDuration=new WktStepDuration(SINGLETON_ENFORCER, 5);

        public static const REPEAT_UNTIL_STEPS_CMPLT:com.garmin.fit.WktStepDuration=new WktStepDuration(SINGLETON_ENFORCER, 6);

        public static const REPEAT_UNTIL_TIME:com.garmin.fit.WktStepDuration=new WktStepDuration(SINGLETON_ENFORCER, 7);

        public static const REPEAT_UNTIL_DISTANCE:com.garmin.fit.WktStepDuration=new WktStepDuration(SINGLETON_ENFORCER, 8);

        public static const REPEAT_UNTIL_CALORIES:com.garmin.fit.WktStepDuration=new WktStepDuration(SINGLETON_ENFORCER, 9);

        public static const REPEAT_UNTIL_HR_LESS_THAN:com.garmin.fit.WktStepDuration=new WktStepDuration(SINGLETON_ENFORCER, 10);

        public static const REPEAT_UNTIL_HR_GREATER_THAN:com.garmin.fit.WktStepDuration=new WktStepDuration(SINGLETON_ENFORCER, 11);

        public static const REPEAT_UNTIL_POWER_LESS_THAN:com.garmin.fit.WktStepDuration=new WktStepDuration(SINGLETON_ENFORCER, 12);

        public static const REPEAT_UNTIL_POWER_GREATER_THAN:com.garmin.fit.WktStepDuration=new WktStepDuration(SINGLETON_ENFORCER, 13);

        public static const POWER_LESS_THAN:com.garmin.fit.WktStepDuration=new WktStepDuration(SINGLETON_ENFORCER, 14);

        public static const POWER_GREATER_THAN:com.garmin.fit.WktStepDuration=new WktStepDuration(SINGLETON_ENFORCER, 15);

        public static const INVALID:com.garmin.fit.WktStepDuration=new WktStepDuration(SINGLETON_ENFORCER, 255);

        internal static const VALUES:__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>=new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(17);
    }
}


//    class WktStepTarget
package com.garmin.fit 
{
    import __AS3__.vec.*;
    import avmplus.*;
    import com.garmin.fit.custom.*;
    import flash.errors.*;
    
    public class WktStepTarget extends com.garmin.fit.custom.BaseType
    {
        public function WktStepTarget(arg1:Object, arg2:uint)
        {
            super();
            if (arg1 != SINGLETON_ENFORCER) 
            {
                throw new flash.errors.IllegalOperationError("IllegalOperation: Manipulation of type " + avmplus.getQualifiedClassName(this));
            }
            this.value = arg2;
            return;
        }

        public function getAllValues():__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>
        {
            return VALUES;
        }

        public function getInvalid():com.garmin.fit.custom.BaseType
        {
            return INVALID;
        }

        public function getValue():uint
        {
            return value;
        }

        public static function getByValue(arg1:uint):com.garmin.fit.WktStepTarget
        {
            return com.garmin.fit.custom.BaseType.getByValue(arg1) as WktStepTarget;
        }

        
        {
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(8)[0] = SPEED;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(8)[1] = HEART_RATE;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(8)[2] = OPEN;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(8)[3] = CADENCE;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(8)[4] = POWER;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(8)[5] = GRADE;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(8)[6] = RESISTANCE;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(8)[7] = INVALID;
        }

        internal static const SINGLETON_ENFORCER:Object={};

        public static const SPEED:com.garmin.fit.WktStepTarget=new WktStepTarget(SINGLETON_ENFORCER, 0);

        public static const HEART_RATE:com.garmin.fit.WktStepTarget=new WktStepTarget(SINGLETON_ENFORCER, 1);

        public static const OPEN:com.garmin.fit.WktStepTarget=new WktStepTarget(SINGLETON_ENFORCER, 2);

        public static const CADENCE:com.garmin.fit.WktStepTarget=new WktStepTarget(SINGLETON_ENFORCER, 3);

        public static const POWER:com.garmin.fit.WktStepTarget=new WktStepTarget(SINGLETON_ENFORCER, 4);

        public static const GRADE:com.garmin.fit.WktStepTarget=new WktStepTarget(SINGLETON_ENFORCER, 5);

        public static const RESISTANCE:com.garmin.fit.WktStepTarget=new WktStepTarget(SINGLETON_ENFORCER, 6);

        public static const INVALID:com.garmin.fit.WktStepTarget=new WktStepTarget(SINGLETON_ENFORCER, 255);

        internal static const VALUES:__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>=new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(8);
    }
}


//    class WorkoutMesg
package com.garmin.fit 
{
    public class WorkoutMesg extends com.garmin.fit.Mesg
    {
        public function WorkoutMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(26));
            return;
        }

        public function getSport():com.garmin.fit.Sport
        {
            var loc1:*=getFieldIntegerValue(4, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.Sport.getByValue(loc1);
        }

        public function setSport(arg1:com.garmin.fit.Sport):void
        {
            setFieldValue(4, 0, arg1.getValue(), 65535);
            return;
        }

        public function getCapabilities():Number
        {
            return getFieldDoubleValue(5, 0, 65535);
        }

        public function setCapabilities(arg1:Number):void
        {
            setFieldValue(5, 0, arg1, 65535);
            return;
        }

        public function getNumValidSteps():int
        {
            return getFieldIntegerValue(6, 0, 65535);
        }

        public function setNumValidSteps(arg1:int):void
        {
            setFieldValue(6, 0, arg1, 65535);
            return;
        }

        public function getWktName():String
        {
            return getFieldStringValue(8, 0, 65535);
        }

        public function setWktName(arg1:String):void
        {
            setFieldValue(8, 0, arg1, 65535);
            return;
        }

        public static function get workoutMesg():com.garmin.fit.Mesg
        {
            return _workoutMesg;
        }

        
        {
            _workoutMesg = new com.garmin.fit.Mesg("workout", 26);
            workoutMesg.addField(new com.garmin.fit.Field("sport", 4, 0, 1, 0, ""));
            workoutMesg.addField(new com.garmin.fit.Field("capabilities", 5, 140, 1, 0, ""));
            workoutMesg.addField(new com.garmin.fit.Field("num_valid_steps", 6, 132, 1, 0, ""));
            workoutMesg.addField(new com.garmin.fit.Field("wkt_name", 8, 7, 1, 0, ""));
        }

        internal static var _workoutMesg:com.garmin.fit.Mesg;
    }
}


//    class WorkoutStepMesg
package com.garmin.fit 
{
    public class WorkoutStepMesg extends com.garmin.fit.Mesg
    {
        public function WorkoutStepMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(27));
            return;
        }

        public function getMessageIndex():int
        {
            return getFieldIntegerValue(254, 0, 65535);
        }

        public function setMessageIndex(arg1:int):void
        {
            setFieldValue(254, 0, arg1, 65535);
            return;
        }

        public function getWktStepName():String
        {
            return getFieldStringValue(0, 0, 65535);
        }

        public function setWktStepName(arg1:String):void
        {
            setFieldValue(0, 0, arg1, 65535);
            return;
        }

        public function getDurationType():com.garmin.fit.WktStepDuration
        {
            var loc1:*=getFieldIntegerValue(1, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.WktStepDuration.getByValue(loc1);
        }

        public function setDurationType(arg1:com.garmin.fit.WktStepDuration):void
        {
            setFieldValue(1, 0, arg1.getValue(), 65535);
            return;
        }

        public function getDurationValue():Number
        {
            return getFieldDoubleValue(2, 0, 65535);
        }

        public function setDurationValue(arg1:Number):void
        {
            setFieldValue(2, 0, arg1, 65535);
            return;
        }

        public function getDurationTime():Number
        {
            return getFieldDoubleValue(2, 0, 0);
        }

        public function setDurationTime(arg1:Number):void
        {
            setFieldValue(2, 0, arg1, 0);
            return;
        }

        public function getDurationDistance():Number
        {
            return getFieldDoubleValue(2, 0, 1);
        }

        public function setDurationDistance(arg1:Number):void
        {
            setFieldValue(2, 0, arg1, 1);
            return;
        }

        public function getDurationHr():Number
        {
            return getFieldDoubleValue(2, 0, 2);
        }

        public function setDurationHr(arg1:Number):void
        {
            setFieldValue(2, 0, arg1, 2);
            return;
        }

        public function getDurationCalories():Number
        {
            return getFieldDoubleValue(2, 0, 3);
        }

        public function setDurationCalories(arg1:Number):void
        {
            setFieldValue(2, 0, arg1, 3);
            return;
        }

        public function getDurationStep():Number
        {
            return getFieldDoubleValue(2, 0, 4);
        }

        public function setDurationStep(arg1:Number):void
        {
            setFieldValue(2, 0, arg1, 4);
            return;
        }

        public function getDurationPower():Number
        {
            return getFieldDoubleValue(2, 0, 5);
        }

        public function setDurationPower(arg1:Number):void
        {
            setFieldValue(2, 0, arg1, 5);
            return;
        }

        public function getTargetType():com.garmin.fit.WktStepTarget
        {
            var loc1:*=getFieldIntegerValue(3, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.WktStepTarget.getByValue(loc1);
        }

        public function setTargetType(arg1:com.garmin.fit.WktStepTarget):void
        {
            setFieldValue(3, 0, arg1.getValue(), 65535);
            return;
        }

        public function getTargetValue():Number
        {
            return getFieldDoubleValue(4, 0, 65535);
        }

        public function setTargetValue(arg1:Number):void
        {
            setFieldValue(4, 0, arg1, 65535);
            return;
        }

        public function getTargetHrZone():Number
        {
            return getFieldDoubleValue(4, 0, 0);
        }

        public function setTargetHrZone(arg1:Number):void
        {
            setFieldValue(4, 0, arg1, 0);
            return;
        }

        public function getTargetPowerZone():Number
        {
            return getFieldDoubleValue(4, 0, 1);
        }

        public function setTargetPowerZone(arg1:Number):void
        {
            setFieldValue(4, 0, arg1, 1);
            return;
        }

        public function getRepeatSteps():Number
        {
            return getFieldDoubleValue(4, 0, 2);
        }

        public function setRepeatSteps(arg1:Number):void
        {
            setFieldValue(4, 0, arg1, 2);
            return;
        }

        public function getRepeatTime():Number
        {
            return getFieldDoubleValue(4, 0, 3);
        }

        public function setRepeatTime(arg1:Number):void
        {
            setFieldValue(4, 0, arg1, 3);
            return;
        }

        public function getRepeatDistance():Number
        {
            return getFieldDoubleValue(4, 0, 4);
        }

        public function setRepeatDistance(arg1:Number):void
        {
            setFieldValue(4, 0, arg1, 4);
            return;
        }

        public function getRepeatCalories():Number
        {
            return getFieldDoubleValue(4, 0, 5);
        }

        public function setRepeatCalories(arg1:Number):void
        {
            setFieldValue(4, 0, arg1, 5);
            return;
        }

        public function getRepeatHr():Number
        {
            return getFieldDoubleValue(4, 0, 6);
        }

        public function setRepeatHr(arg1:Number):void
        {
            setFieldValue(4, 0, arg1, 6);
            return;
        }

        public function getRepeatPower():Number
        {
            return getFieldDoubleValue(4, 0, 7);
        }

        public function setRepeatPower(arg1:Number):void
        {
            setFieldValue(4, 0, arg1, 7);
            return;
        }

        public function getCustomTargetValueLow():Number
        {
            return getFieldDoubleValue(5, 0, 65535);
        }

        public function setCustomTargetValueLow(arg1:Number):void
        {
            setFieldValue(5, 0, arg1, 65535);
            return;
        }

        public function getCustomTargetSpeedLow():Number
        {
            return getFieldDoubleValue(5, 0, 0);
        }

        public function setCustomTargetSpeedLow(arg1:Number):void
        {
            setFieldValue(5, 0, arg1, 0);
            return;
        }

        public function getCustomTargetHeartRateLow():Number
        {
            return getFieldDoubleValue(5, 0, 1);
        }

        public function setCustomTargetHeartRateLow(arg1:Number):void
        {
            setFieldValue(5, 0, arg1, 1);
            return;
        }

        public function getCustomTargetCadenceLow():Number
        {
            return getFieldDoubleValue(5, 0, 2);
        }

        public function setCustomTargetCadenceLow(arg1:Number):void
        {
            setFieldValue(5, 0, arg1, 2);
            return;
        }

        public function getCustomTargetPowerLow():Number
        {
            return getFieldDoubleValue(5, 0, 3);
        }

        public function setCustomTargetPowerLow(arg1:Number):void
        {
            setFieldValue(5, 0, arg1, 3);
            return;
        }

        public function getCustomTargetValueHigh():Number
        {
            return getFieldDoubleValue(6, 0, 65535);
        }

        public function setCustomTargetValueHigh(arg1:Number):void
        {
            setFieldValue(6, 0, arg1, 65535);
            return;
        }

        public function getCustomTargetSpeedHigh():Number
        {
            return getFieldDoubleValue(6, 0, 0);
        }

        public function setCustomTargetSpeedHigh(arg1:Number):void
        {
            setFieldValue(6, 0, arg1, 0);
            return;
        }

        public function getCustomTargetHeartRateHigh():Number
        {
            return getFieldDoubleValue(6, 0, 1);
        }

        public function setCustomTargetHeartRateHigh(arg1:Number):void
        {
            setFieldValue(6, 0, arg1, 1);
            return;
        }

        public function getCustomTargetCadenceHigh():Number
        {
            return getFieldDoubleValue(6, 0, 2);
        }

        public function setCustomTargetCadenceHigh(arg1:Number):void
        {
            setFieldValue(6, 0, arg1, 2);
            return;
        }

        public function getCustomTargetPowerHigh():Number
        {
            return getFieldDoubleValue(6, 0, 3);
        }

        public function setCustomTargetPowerHigh(arg1:Number):void
        {
            setFieldValue(6, 0, arg1, 3);
            return;
        }

        public function getIntensity():com.garmin.fit.Intensity
        {
            var loc1:*=getFieldIntegerValue(7, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.Intensity.getByValue(loc1);
        }

        public function setIntensity(arg1:com.garmin.fit.Intensity):void
        {
            setFieldValue(7, 0, arg1.getValue(), 65535);
            return;
        }

        public static function get workoutStepMesg():com.garmin.fit.Mesg
        {
            return _workoutStepMesg;
        }

        
        {
            _workoutStepMesg = new com.garmin.fit.Mesg("workout_step", 27);
            workoutStepMesg.addField(new com.garmin.fit.Field("message_index", 254, 132, 1, 0, ""));
            ++field_index;
            workoutStepMesg.addField(new com.garmin.fit.Field("wkt_step_name", 0, 7, 1, 0, ""));
            ++field_index;
            workoutStepMesg.addField(new com.garmin.fit.Field("duration_type", 1, 0, 1, 0, ""));
            ++field_index;
            workoutStepMesg.addField(new com.garmin.fit.Field("duration_value", 2, 134, 1, 0, ""));
            subfield_index = 0;
            workoutStepMesg.fields[field_index].subFields.push(new com.garmin.fit.SubField("duration_time", 134, 1000, 0, "s"));
            workoutStepMesg.fields[field_index].subFields[subfield_index].addMap(1, 0);
            ++subfield_index;
            workoutStepMesg.fields[field_index].subFields.push(new com.garmin.fit.SubField("duration_distance", 134, 100, 0, "m"));
            workoutStepMesg.fields[field_index].subFields[subfield_index].addMap(1, 1);
            ++subfield_index;
            workoutStepMesg.fields[field_index].subFields.push(new com.garmin.fit.SubField("duration_hr", 134, 1, 0, "% or bpm"));
            workoutStepMesg.fields[field_index].subFields[subfield_index].addMap(1, 2);
            workoutStepMesg.fields[field_index].subFields[subfield_index].addMap(1, 3);
            ++subfield_index;
            workoutStepMesg.fields[field_index].subFields.push(new com.garmin.fit.SubField("duration_calories", 134, 1, 0, "calories"));
            workoutStepMesg.fields[field_index].subFields[subfield_index].addMap(1, 4);
            ++subfield_index;
            workoutStepMesg.fields[field_index].subFields.push(new com.garmin.fit.SubField("duration_step", 134, 1, 0, ""));
            workoutStepMesg.fields[field_index].subFields[subfield_index].addMap(1, 6);
            workoutStepMesg.fields[field_index].subFields[subfield_index].addMap(1, 7);
            workoutStepMesg.fields[field_index].subFields[subfield_index].addMap(1, 8);
            workoutStepMesg.fields[field_index].subFields[subfield_index].addMap(1, 9);
            workoutStepMesg.fields[field_index].subFields[subfield_index].addMap(1, 10);
            workoutStepMesg.fields[field_index].subFields[subfield_index].addMap(1, 11);
            workoutStepMesg.fields[field_index].subFields[subfield_index].addMap(1, 12);
            workoutStepMesg.fields[field_index].subFields[subfield_index].addMap(1, 13);
            ++subfield_index;
            workoutStepMesg.fields[field_index].subFields.push(new com.garmin.fit.SubField("duration_power", 134, 1, 0, "% or watts"));
            workoutStepMesg.fields[field_index].subFields[subfield_index].addMap(1, 14);
            workoutStepMesg.fields[field_index].subFields[subfield_index].addMap(1, 15);
            ++subfield_index;
            ++field_index;
            workoutStepMesg.addField(new com.garmin.fit.Field("target_type", 3, 0, 1, 0, ""));
            ++field_index;
            workoutStepMesg.addField(new com.garmin.fit.Field("target_value", 4, 134, 1, 0, ""));
            subfield_index = 0;
            workoutStepMesg.fields[field_index].subFields.push(new com.garmin.fit.SubField("target_hr_zone", 134, 1, 0, ""));
            workoutStepMesg.fields[field_index].subFields[subfield_index].addMap(3, 1);
            ++subfield_index;
            workoutStepMesg.fields[field_index].subFields.push(new com.garmin.fit.SubField("target_power_zone", 134, 1, 0, ""));
            workoutStepMesg.fields[field_index].subFields[subfield_index].addMap(3, 4);
            ++subfield_index;
            workoutStepMesg.fields[field_index].subFields.push(new com.garmin.fit.SubField("repeat_steps", 134, 1, 0, ""));
            workoutStepMesg.fields[field_index].subFields[subfield_index].addMap(1, 6);
            ++subfield_index;
            workoutStepMesg.fields[field_index].subFields.push(new com.garmin.fit.SubField("repeat_time", 134, 1000, 0, "s"));
            workoutStepMesg.fields[field_index].subFields[subfield_index].addMap(1, 7);
            ++subfield_index;
            workoutStepMesg.fields[field_index].subFields.push(new com.garmin.fit.SubField("repeat_distance", 134, 100, 0, "m"));
            workoutStepMesg.fields[field_index].subFields[subfield_index].addMap(1, 8);
            ++subfield_index;
            workoutStepMesg.fields[field_index].subFields.push(new com.garmin.fit.SubField("repeat_calories", 134, 1, 0, "calories"));
            workoutStepMesg.fields[field_index].subFields[subfield_index].addMap(1, 9);
            ++subfield_index;
            workoutStepMesg.fields[field_index].subFields.push(new com.garmin.fit.SubField("repeat_hr", 134, 1, 0, "% or bpm"));
            workoutStepMesg.fields[field_index].subFields[subfield_index].addMap(1, 10);
            workoutStepMesg.fields[field_index].subFields[subfield_index].addMap(1, 11);
            ++subfield_index;
            workoutStepMesg.fields[field_index].subFields.push(new com.garmin.fit.SubField("repeat_power", 134, 1, 0, "% or watts"));
            workoutStepMesg.fields[field_index].subFields[subfield_index].addMap(1, 12);
            workoutStepMesg.fields[field_index].subFields[subfield_index].addMap(1, 13);
            ++subfield_index;
            ++field_index;
            workoutStepMesg.addField(new com.garmin.fit.Field("custom_target_value_low", 5, 134, 1, 0, ""));
            subfield_index = 0;
            workoutStepMesg.fields[field_index].subFields.push(new com.garmin.fit.SubField("custom_target_speed_low", 134, 1000, 0, "m/s"));
            workoutStepMesg.fields[field_index].subFields[subfield_index].addMap(3, 0);
            ++subfield_index;
            workoutStepMesg.fields[field_index].subFields.push(new com.garmin.fit.SubField("custom_target_heart_rate_low", 134, 1, 0, "% or bpm"));
            workoutStepMesg.fields[field_index].subFields[subfield_index].addMap(3, 1);
            ++subfield_index;
            workoutStepMesg.fields[field_index].subFields.push(new com.garmin.fit.SubField("custom_target_cadence_low", 134, 1, 0, "rpm"));
            workoutStepMesg.fields[field_index].subFields[subfield_index].addMap(3, 3);
            ++subfield_index;
            workoutStepMesg.fields[field_index].subFields.push(new com.garmin.fit.SubField("custom_target_power_low", 134, 1, 0, "% or watts"));
            workoutStepMesg.fields[field_index].subFields[subfield_index].addMap(3, 4);
            ++subfield_index;
            ++field_index;
            workoutStepMesg.addField(new com.garmin.fit.Field("custom_target_value_high", 6, 134, 1, 0, ""));
            subfield_index = 0;
            workoutStepMesg.fields[field_index].subFields.push(new com.garmin.fit.SubField("custom_target_speed_high", 134, 1000, 0, "m/s"));
            workoutStepMesg.fields[field_index].subFields[subfield_index].addMap(3, 0);
            ++subfield_index;
            workoutStepMesg.fields[field_index].subFields.push(new com.garmin.fit.SubField("custom_target_heart_rate_high", 134, 1, 0, "% or bpm"));
            workoutStepMesg.fields[field_index].subFields[subfield_index].addMap(3, 1);
            ++subfield_index;
            workoutStepMesg.fields[field_index].subFields.push(new com.garmin.fit.SubField("custom_target_cadence_high", 134, 1, 0, "rpm"));
            workoutStepMesg.fields[field_index].subFields[subfield_index].addMap(3, 3);
            ++subfield_index;
            workoutStepMesg.fields[field_index].subFields.push(new com.garmin.fit.SubField("custom_target_power_high", 134, 1, 0, "% or watts"));
            workoutStepMesg.fields[field_index].subFields[subfield_index].addMap(3, 4);
            ++subfield_index;
            ++field_index;
            workoutStepMesg.addField(new com.garmin.fit.Field("intensity", 7, 0, 1, 0, ""));
            ++field_index;
        }

        internal static var field_index:int=0;

        internal static var subfield_index:int=0;

        internal static var _workoutStepMesg:com.garmin.fit.Mesg;
    }
}


//    class ZonesTargetMesg
package com.garmin.fit 
{
    public class ZonesTargetMesg extends com.garmin.fit.Mesg
    {
        public function ZonesTargetMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(7));
            return;
        }

        public function getMaxHeartRate():int
        {
            return getFieldIntegerValue(1, 0, 65535);
        }

        public function setMaxHeartRate(arg1:int):void
        {
            setFieldValue(1, 0, arg1, 65535);
            return;
        }

        public function getThresholdHeartRate():int
        {
            return getFieldIntegerValue(2, 0, 65535);
        }

        public function setThresholdHeartRate(arg1:int):void
        {
            setFieldValue(2, 0, arg1, 65535);
            return;
        }

        public function getFunctionalThresholdPower():int
        {
            return getFieldIntegerValue(3, 0, 65535);
        }

        public function setFunctionalThresholdPower(arg1:int):void
        {
            setFieldValue(3, 0, arg1, 65535);
            return;
        }

        public function getHrCalcType():com.garmin.fit.HrZoneCalc
        {
            var loc1:*=getFieldIntegerValue(5, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.HrZoneCalc.getByValue(loc1);
        }

        public function setHrCalcType(arg1:com.garmin.fit.HrZoneCalc):void
        {
            setFieldValue(5, 0, arg1.getValue(), 65535);
            return;
        }

        public function getPwrCalcType():com.garmin.fit.PwrZoneCalc
        {
            var loc1:*=getFieldIntegerValue(7, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.PwrZoneCalc.getByValue(loc1);
        }

        public function setPwrCalcType(arg1:com.garmin.fit.PwrZoneCalc):void
        {
            setFieldValue(7, 0, arg1.getValue(), 65535);
            return;
        }

        public static function get zonesTargetMesg():com.garmin.fit.Mesg
        {
            return _zonesTargetMesg;
        }

        
        {
            _zonesTargetMesg = new com.garmin.fit.Mesg("zones_target", 7);
            zonesTargetMesg.addField(new com.garmin.fit.Field("max_heart_rate", 1, 2, 1, 0, ""));
            zonesTargetMesg.addField(new com.garmin.fit.Field("threshold_heart_rate", 2, 2, 1, 0, ""));
            zonesTargetMesg.addField(new com.garmin.fit.Field("functional_threshold_power", 3, 132, 1, 0, ""));
            zonesTargetMesg.addField(new com.garmin.fit.Field("hr_calc_type", 5, 0, 1, 0, ""));
            zonesTargetMesg.addField(new com.garmin.fit.Field("pwr_calc_type", 7, 0, 1, 0, ""));
        }

        internal static var _zonesTargetMesg:com.garmin.fit.Mesg;
    }
}


