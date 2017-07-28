//class MarkerFITMapper
package core.fit 
{
    import __AS3__.vec.*;
    import com.garmin.fit.*;
    import com.garmin.fit.custom.*;
    import com.garmin.fit.custom.rox100.*;
    import core.activities.*;
    import core.marker.*;
    import utils.converter.*;
    
    public class MarkerFITMapper extends Object
    {
        public function MarkerFITMapper(arg1:core.activities.Activity)
        {
            super();
            sourceActivity = arg1;
            activityStartTime = arg1.startDate.time;
            commonMarker = core.marker.MarkerFactory.createMarkerFromLog(sourceActivity);
            return;
        }

        public function createBreakMarkerFromFit(arg1:com.garmin.fit.custom.rox100.SigmaBreakMesg, arg2:uint):core.marker.Marker
        {
            var loc1:*=core.marker.MarkerFactory.createMarkerFromLog(sourceActivity);
            loc1.number = arg2;
            loc1.type = "p";
            loc1.logReference = sourceActivity;
            loc1.altitudeDownhill = arg1.getMarkerAltitudeDownhill();
            loc1.altitudeUphill = arg1.getMarkerAltitudeUphill();
            loc1.averageAltitude = arg1.getMarkerAverageAltitude();
            loc1.averageCadence = arg1.getMarkerAverageCadence();
            loc1.averageHeartrate = arg1.getMarkerAverageHeartrate();
            loc1.averageInclineDownhill = arg1.getMarkerAverageInclineDownhill();
            loc1.averageInclineUphill = arg1.getMarkerAverageInclineUphill();
            loc1.averagePower = arg1.getMarkerAveragePower();
            loc1.averageSpeed = arg1.getMarkerAverageSpeed();
            loc1.calories = arg1.getMarkerCalories();
            loc1.distance = arg1.getMarkerDistance();
            loc1.duration = arg1.getMarkerDuration();
            loc1.latitude = com.garmin.fit.custom.FitConverter.convertSemicirclesToDegree(arg1.getMarkerLatitude());
            loc1.longitude = com.garmin.fit.custom.FitConverter.convertSemicirclesToDegree(arg1.getMarkerLongitude());
            loc1.maximumAltitude = arg1.getMarkerMaximumAltitude();
            loc1.maximumCadence = arg1.getMarkerMaximumCadence();
            loc1.maximumHeartrate = arg1.getMarkerMaximumHeartrate();
            loc1.maximumInclineDownhill = arg1.getMarkerMaximumInclineDownhill();
            loc1.maximumInclineUphill = arg1.getMarkerMaximumInclineUphill();
            loc1.maximumPower = arg1.getMarkerMaximumPower();
            loc1.maximumSpeed = arg1.getMarkerMaximumSpeed();
            createMarkerFromFit(loc1, arg1);
            return loc1;
        }

        public function createBreakMesgFromMarker(arg1:core.marker.Marker, arg2:core.marker.Marker, arg3:com.garmin.fit.FITFileEncoder):void
        {
            var loc1:*;
            (loc1 = new com.garmin.fit.custom.rox100.SigmaBreakMesg()).setLocalNum(12);
            loc1.setMarkerAltitudeDownhill(arg1.altitudeDownhill);
            loc1.setMarkerAltitudeUphill(arg1.altitudeUphill);
            loc1.setMarkerAverageAltitude(arg1.averageAltitude);
            loc1.setMarkerAverageCadence(arg1.averageCadence);
            loc1.setMarkerAverageHeartrate(arg1.averageHeartrate);
            loc1.setMarkerAverageInclineDownhill(arg1.averageInclineDownhill);
            loc1.setMarkerAverageInclineUphill(arg1.averageInclineUphill);
            loc1.setMarkerAveragePower(arg1.averagePower);
            loc1.setMarkerAverageSpeed(arg1.averageSpeed);
            loc1.setMarkerCalories(arg1.calories);
            loc1.setMarkerDistance(arg1.distance);
            loc1.setMarkerDuration(arg1.duration);
            loc1.setMarkerLatitude(com.garmin.fit.custom.FitConverter.convertDegreeToSemicircles(arg1.latitude));
            loc1.setMarkerLongitude(com.garmin.fit.custom.FitConverter.convertDegreeToSemicircles(arg1.longitude));
            loc1.setMarkerMaximumAltitude(arg1.maximumAltitude);
            loc1.setMarkerMaximumCadence(arg1.maximumCadence);
            loc1.setMarkerMaximumHeartrate(arg1.maximumHeartrate);
            loc1.setMarkerMaximumInclineDownhill(arg1.maximumInclineDownhill);
            loc1.setMarkerMaximumInclineUphill(arg1.maximumInclineUphill);
            loc1.setMarkerMaximumPower(arg1.maximumPower);
            loc1.setMarkerMaximumSpeed(arg1.maximumSpeed);
            createSigmaMarkerMesgFromMarker(arg1, loc1, arg3);
            return;
        }

        public function createLapMarkerFromFit(arg1:com.garmin.fit.LapMesg, arg2:Object, arg3:uint, arg4:uint):core.marker.Marker
        {
            var loc1:*=null;
            var loc2:*;
            (loc2 = core.marker.MarkerFactory.createMarkerFromLog(sourceActivity)).number = arg3;
            loc2.type = "l";
            loc2.duration = 0;
            loc2.logReference = sourceActivity;
            tmpNumber = arg1.getAvgAltitude();
            if (!isNaN(tmpNumber)) 
            {
                loc2.averageAltitude = meterToMillimeter.convert(tmpNumber);
                commonMarker.averageAltitudeDefined = true;
            }
            tmpInt = arg1.getAvgCadence();
            if (-2147483648 != tmpInt) 
            {
                loc2.averageCadence = tmpInt;
                commonMarker.averageCadenceDefined = true;
            }
            tmpInt = arg1.getAvgHeartRate();
            if (-2147483648 != tmpInt) 
            {
                loc2.averageHeartrate = tmpInt;
                commonMarker.averageHeartrateDefined = true;
            }
            tmpNumber = arg1.getAvgNegGrade();
            if (!isNaN(tmpNumber)) 
            {
                loc2.averageInclineDownhill = tmpNumber;
                commonMarker.averageInclineDownhillDefined = true;
            }
            tmpNumber = arg1.getAvgPosGrade();
            if (!isNaN(tmpNumber)) 
            {
                loc2.averageInclineUphill = tmpNumber;
                commonMarker.averageInclineUphillDefined = true;
            }
            tmpNumber = arg1.getAvgPower();
            if (!isNaN(tmpNumber)) 
            {
                loc2.averagePower = tmpNumber;
                commonMarker.averagePowerDefined = true;
            }
            tmpNumber = arg1.getAvgSpeed();
            if (!isNaN(tmpNumber)) 
            {
                loc2.averageSpeed = tmpNumber;
                commonMarker.averageSpeedDefined = true;
            }
            tmpInt = arg1.getEndPositionLat();
            if (-2147483648 != tmpInt) 
            {
                loc2.latitude = com.garmin.fit.custom.FitConverter.convertSemicirclesToDegree(tmpInt);
                commonMarker.latitudeDefined = true;
            }
            tmpInt = arg1.getEndPositionLong();
            if (-2147483648 != tmpInt) 
            {
                loc2.longitude = com.garmin.fit.custom.FitConverter.convertSemicirclesToDegree(tmpInt);
                commonMarker.longitudeDefined = true;
            }
            tmpNumber = arg1.getMaxAltitude();
            if (!isNaN(tmpNumber)) 
            {
                loc2.maximumAltitude = meterToMillimeter.convert(tmpNumber);
                commonMarker.maximumAltitudeDefined = true;
            }
            tmpInt = arg1.getMaxCadence();
            if (-2147483648 != tmpInt) 
            {
                loc2.maximumCadence = tmpInt;
                commonMarker.maximumCadenceDefined = true;
            }
            tmpInt = arg1.getMaxHeartRate();
            if (-2147483648 != tmpInt) 
            {
                loc2.maximumHeartrate = tmpInt;
                commonMarker.maximumHeartrateDefined = true;
            }
            tmpNumber = arg1.getMaxNegGrade();
            if (!isNaN(tmpNumber)) 
            {
                loc2.maximumInclineDownhill = tmpNumber;
                commonMarker.maximumInclineDownhillDefined = true;
            }
            tmpNumber = arg1.getMaxPosGrade();
            if (!isNaN(tmpNumber)) 
            {
                loc2.maximumInclineUphill = tmpNumber;
                commonMarker.maximumInclineUphillDefined = true;
            }
            tmpInt = arg1.getMaxPower();
            if (-2147483648 != tmpInt) 
            {
                loc2.maximumPower = tmpInt;
                commonMarker.maximumPowerDefined = true;
            }
            tmpNumber = arg1.getMaxSpeed();
            if (!isNaN(tmpNumber)) 
            {
                loc2.maximumSpeed = tmpNumber;
                commonMarker.maximumSpeedDefined = true;
            }
            tmpInt = arg1.getMinHeartRate();
            if (-2147483648 != tmpInt) 
            {
                loc2.minimumHeartrate = tmpInt;
                commonMarker.minimumHeartrateDefined = true;
            }
            tmpInt = arg1.getTotalAscent();
            if (-2147483648 != tmpInt) 
            {
                loc2.altitudeUphill = meterToMillimeter.convert(tmpInt);
                commonMarker.altitudeUphillDefined = true;
            }
            tmpInt = arg1.getTotalCalories();
            if (-2147483648 != tmpInt) 
            {
                loc2.calories = tmpInt;
                commonMarker.caloriesDefined = true;
            }
            tmpInt = arg1.getTotalDescent();
            if (-2147483648 != tmpInt) 
            {
                loc2.altitudeDownhill = meterToMillimeter.convert(tmpInt);
                commonMarker.altitudeDownhillDefined = true;
            }
            loc2.time = arg1.getTotalElapsedTime() * 100;
            if (arg2 is com.garmin.fit.custom.rox100.SigmaLapMesg) 
            {
                createMarkerFromFit(loc2, arg2 as com.garmin.fit.custom.rox100.SigmaLapMesg);
            }
            else 
            {
                if (loc1 = sourceActivity.markerList.length > 0 ? sourceActivity.markerList[(sourceActivity.markerList.length - 1)] : null) 
                {
                    loc2.distance = arg1.getTotalDistance();
                    loc2.distanceAbsolute = loc2.distance + loc1.distanceAbsolute;
                    loc2.timeAbsolute = loc2.time + loc1.timeAbsolute;
                }
                else 
                {
                    loc2.distance = arg1.getTotalDistance();
                    loc2.distanceAbsolute = arg1.getTotalDistance();
                    loc2.timeAbsolute = loc2.time;
                }
                loc2.duration = loc2.timeAbsolute - loc2.time;
                commonMarker.distanceDefined = true;
                commonMarker.distanceAbsoluteDefined = true;
                commonMarker.timeDownhillDefined = true;
            }
            return loc2;
        }

        public function calcCommonMarkerDefinitions():void
        {
            var loc2:*=null;
            var loc6:*=0;
            var loc4:*=0;
            var loc7:*=null;
            var loc5:*;
            var loc1:*=(loc5 = sourceActivity.markerList).length;
            var loc3:*=0;
            loc6 = 0;
            while (loc6 < loc1) 
            {
                loc2 = loc5[loc6];
                loc2.averageAltitudeDefined = commonMarker.averageAltitudeDefined;
                loc2.averageCadenceDefined = commonMarker.averageCadenceDefined;
                loc2.averageHeartrateDefined = commonMarker.averageHeartrateDefined;
                loc2.averageInclineDownhillDefined = commonMarker.averageInclineDownhillDefined;
                loc2.averageInclineUphillDefined = commonMarker.averageInclineUphillDefined;
                loc2.averagePowerDefined = commonMarker.averagePowerDefined;
                loc2.averageSpeedDefined = commonMarker.averageSpeedDefined;
                if (loc2.latitudeDefined && commonMarker.latitudeDefined) 
                {
                    loc3 = loc6;
                }
                else if (!loc2.latitudeDefined && commonMarker.latitudeDefined) 
                {
                    loc4 = loc3;
                    while (loc4 <= loc6) 
                    {
                        (loc7 = loc5[loc4]).latitude = loc2.latitude;
                        loc7.longitude = loc2.longitude;
                        ++loc4;
                    }
                    ++loc3;
                }
                loc2.latitudeDefined = commonMarker.latitudeDefined;
                loc2.longitudeDefined = commonMarker.longitudeDefined;
                loc2.maximumAltitudeDefined = commonMarker.maximumAltitudeDefined;
                loc2.maximumCadenceDefined = commonMarker.maximumCadenceDefined;
                loc2.maximumHeartrateDefined = commonMarker.maximumHeartrateDefined;
                loc2.maximumInclineDownhillDefined = commonMarker.maximumInclineDownhillDefined;
                loc2.maximumInclineUphillDefined = commonMarker.maximumInclineUphillDefined;
                loc2.maximumPowerDefined = commonMarker.maximumPowerDefined;
                loc2.maximumSpeedDefined = commonMarker.maximumSpeedDefined;
                loc2.minimumHeartrateDefined = commonMarker.minimumHeartrateDefined;
                loc2.altitudeUphillDefined = commonMarker.altitudeUphillDefined;
                loc2.caloriesDefined = commonMarker.caloriesDefined;
                loc2.distanceDefined = commonMarker.distanceDefined;
                loc2.distanceAbsoluteDefined = commonMarker.distanceAbsoluteDefined;
                loc2.timeDownhillDefined = commonMarker.timeDownhillDefined;
                ++loc6;
            }
            commonMarker = core.marker.MarkerFactory.createMarkerFromLog(sourceActivity);
            return;
        }

        public function createLapMesgFromMarker(arg1:core.marker.Marker, arg2:core.marker.Marker, arg3:Number, arg4:Number, arg5:com.garmin.fit.FITFileEncoder):void
        {
            var loc3:*=NaN;
            var loc6:*=NaN;
            var loc7:*=NaN;
            var loc4:*=NaN;
            var loc2:*=new com.garmin.fit.LapMesg();
            var loc1:*=false;
            var loc5:*=false;
            loc2.setAvgAltitude(millimeterToMeter.convert(arg1.averageAltitude));
            loc2.setAvgCadence(arg1.averageCadence);
            loc2.setAvgHeartRate(arg1.averageHeartrate);
            loc2.setAvgNegGrade(arg1.averageInclineDownhill);
            loc2.setAvgPosGrade(arg1.averageInclineUphill);
            loc2.setAvgPower(arg1.averagePower);
            loc2.setAvgSpeed(arg1.averageSpeed);
            if (!(arg1.latitude == 0) && !(arg1.longitude == 0)) 
            {
                loc2.setEndPositionLat(com.garmin.fit.custom.FitConverter.convertDegreeToSemicircles(arg1.latitude));
                loc2.setEndPositionLong(com.garmin.fit.custom.FitConverter.convertDegreeToSemicircles(arg1.longitude));
                loc5 = true;
            }
            loc2.setEvent(com.garmin.fit.FITEvent.LAP);
            loc2.setEventType(com.garmin.fit.EventType.STOP);
            loc2.setIntensity(com.garmin.fit.Intensity.ACTIVE);
            loc2.setLapTrigger(com.garmin.fit.LapTrigger.DISTANCE);
            loc2.setMaxAltitude(millimeterToMeter.convert(arg1.maximumAltitude));
            loc2.setMaxCadence(arg1.maximumCadence);
            loc2.setMaxHeartRate(arg1.maximumHeartrate);
            loc2.setMaxNegGrade(arg1.maximumInclineDownhill);
            loc2.setMaxPosGrade(arg1.maximumInclineUphill);
            loc2.setMaxPower(arg1.maximumPower);
            loc2.setMaxRunningCadence(0);
            loc2.setMaxSpeed(arg1.maximumSpeed);
            loc2.setMessageIndex(arg1.number);
            loc2.setMinHeartRate(arg1.minimumHeartrate);
            if (arg2) 
            {
                if (!(arg2.latitude == 0) && !(arg2.longitude == 0)) 
                {
                    loc2.setStartPositionLat(com.garmin.fit.custom.FitConverter.convertDegreeToSemicircles(arg2.latitude));
                    loc2.setStartPositionLong(com.garmin.fit.custom.FitConverter.convertDegreeToSemicircles(arg2.longitude));
                    loc1 = true;
                }
                loc7 = arg1.timeAbsolute - arg2.timeAbsolute;
                loc4 = arg1.distanceAbsolute - arg2.distanceAbsolute;
                loc6 = (loc3 = arg2.timeAbsolute + arg4) + loc7;
                loc2.setStartTime(new com.garmin.fit.DateTime(activityStartTime + 10 * loc3));
                loc2.setTimestamp(new com.garmin.fit.DateTime(activityStartTime + 10 * loc6));
            }
            else 
            {
                if (!(arg1.longitude == 0) && !(arg1.latitude == 0)) 
                {
                    loc2.setStartPositionLat(com.garmin.fit.custom.FitConverter.convertDegreeToSemicircles(arg1.latitude));
                    loc2.setStartPositionLong(com.garmin.fit.custom.FitConverter.convertDegreeToSemicircles(arg1.longitude));
                    loc1 = true;
                }
                loc7 = arg1.timeAbsolute;
                loc4 = arg1.distanceAbsolute;
                loc6 = (loc3 = 0) + loc7 + arg4;
                loc2.setStartTime(new com.garmin.fit.DateTime(activityStartTime + 10 * loc3));
                loc2.setTimestamp(new com.garmin.fit.DateTime(activityStartTime + 10 * loc6));
            }
            loc2.setTotalElapsedTime(0.01 * loc7);
            loc2.setTotalTimerTime(0.01 * loc7);
            loc2.setTotalMovingTime(0.01 * loc7);
            loc2.setTotalAscent(millimeterToMeter.convert(arg1.altitudeUphill));
            loc2.setTotalCalories(arg1.calories);
            loc2.setTotalDescent(millimeterToMeter.convert(arg1.altitudeDownhill));
            loc2.setTotalDistance(loc4);
            if (loc5 && loc1) 
            {
                loc2.setLocalNum(2);
            }
            else if (loc1) 
            {
                loc2.setLocalNum(3);
            }
            else if (loc5) 
            {
                loc2.setLocalNum(4);
            }
            else 
            {
                loc2.setLocalNum(1);
            }
            arg5.write(loc2);
            return;
        }

        public function createMarkerFromFit(arg1:core.marker.Marker, arg2:com.garmin.fit.custom.rox100.SigmaMarkerROX100Mesg):void
        {
            arg1.description = arg2.getDescription();
            arg1.distanceAbsolute = arg2.getMarkerDistanceAbsolute();
            arg1.minimumSpeed = arg2.getMarkerMinimumSpeed();
            arg1.time = arg2.getMarkerTime();
            arg1.timeAbsolute = arg2.getMarkerTimeAbsolute();
            arg1.timeDownhill = arg2.getMarkerTimeDownhill();
            arg1.timeUphill = arg2.getMarkerTimeUphill();
            arg1.title = arg2.getTitle();
            return;
        }

        public function createSigmaMarkerMesgFromMarker(arg1:core.marker.Marker, arg2:com.garmin.fit.custom.rox100.SigmaMarkerROX100Mesg, arg3:com.garmin.fit.FITFileEncoder):void
        {
            arg2.setDescription(arg1.description);
            arg2.setMarkerDistanceAbsolute(arg1.distanceAbsolute);
            arg2.setMarkerMinimumSpeed(arg1.minimumSpeed);
            arg2.setMarkerTime(arg1.time);
            arg2.setMarkerTimeAbsolute(arg1.timeAbsolute);
            arg2.setMarkerTimeDownhill(arg1.timeDownhill);
            arg2.setMarkerTimeUphill(arg1.timeUphill);
            arg2.setTitle(arg1.title);
            arg3.write(arg2);
            return;
        }

        internal const meterToMillimeter:utils.converter.AltitudeConverter=new utils.converter.AltitudeConverter("meter", "millimeter");

        internal const millimeterToMeter:utils.converter.AltitudeConverter=new utils.converter.AltitudeConverter("millimeter", "meter");

        internal static const MESG_LAP_WITHOUT_GPS:int=1;

        internal static const MESG_LAP_WITH_GPS:int=2;

        internal static const MESG_LAP_WITH_GPS_AT_END:int=4;

        internal static const MESG_LAP_WITH_GPS_AT_START:int=3;

        internal var activityStartTime:Number;

        internal var commonMarker:core.marker.Marker;

        internal var sourceActivity:core.activities.Activity=null;

        internal var tmpInt:int;

        internal var tmpNumber:Number;
    }
}


