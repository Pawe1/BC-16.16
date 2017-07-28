//class SigmaLogMesg
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


