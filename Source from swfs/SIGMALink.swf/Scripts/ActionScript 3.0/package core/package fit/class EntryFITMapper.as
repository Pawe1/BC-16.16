//class EntryFITMapper
package core.fit 
{
    import __AS3__.vec.*;
    import com.garmin.fit.*;
    import com.garmin.fit.custom.*;
    import com.garmin.fit.custom.rox100.*;
    import core.activities.*;
    import core.marker.*;
    import utils.converter.*;
    
    public class EntryFITMapper extends Object
    {
        public function EntryFITMapper(arg1:core.activities.Activity)
        {
            super();
            sourceActivity = arg1;
            activityStartTime = arg1.startDate.time;
            recordMesgWidthGPS.setLocalNum(2);
            recordMesgNoGPS.setLocalNum(1);
            commonEntry = core.activities.ActivityFactory.createLogEntryFromLog(sourceActivity);
            return;
        }

        public function createLogEntryFromFit(arg1:com.garmin.fit.RecordMesg, arg2:com.garmin.fit.custom.rox100.SigmaRecordMesg=null):core.activities.ActivityEntry
        {
            var loc1:*=core.activities.ActivityFactory.createLogEntryFromLog(sourceActivity);
            loc1.number = sourceActivity.entries.length + 1;
            tmpNumber = arg1.getAltitude();
            if (!isNaN(tmpNumber)) 
            {
                loc1.altitude = meterToMillimeter.convert(tmpNumber);
                commonEntry.altitudeDefined = true;
            }
            tmpInt = arg1.getCadence();
            if (-2147483648 != tmpInt) 
            {
                loc1.cadence = tmpInt;
                commonEntry.cadenceDefined = true;
            }
            tmpInt = arg1.getCalories();
            if (-2147483648 != tmpInt) 
            {
                loc1.calories = tmpInt;
                commonEntry.caloriesDefined = true;
            }
            tmpNumber = arg1.getDistance();
            if (!isNaN(tmpNumber)) 
            {
                loc1.distanceAbsolute = tmpNumber;
                commonEntry.distanceAbsoluteDefined = true;
                if (lastEntry) 
                {
                    loc1.distance = tmpNumber - lastEntry.distanceAbsolute;
                    commonEntry.distanceDefined = true;
                }
            }
            tmpNumber = arg1.getGrade();
            if (!isNaN(tmpNumber)) 
            {
                loc1.incline = tmpNumber;
                commonEntry.inclineDefined = true;
            }
            tmpInt = arg1.getHeartRate();
            if (-2147483648 != tmpInt) 
            {
                loc1.heartrate = tmpInt;
                commonEntry.heartrateDefined = true;
            }
            tmpInt = arg1.getPositionLat();
            if (-2147483648 != tmpInt) 
            {
                loc1.latitude = com.garmin.fit.custom.FitConverter.convertSemicirclesToDegree(arg1.getPositionLat());
                commonEntry.latitudeDefined = true;
            }
            tmpInt = arg1.getPositionLong();
            if (-2147483648 != tmpInt) 
            {
                loc1.longitude = com.garmin.fit.custom.FitConverter.convertSemicirclesToDegree(tmpInt);
                commonEntry.longitudeDefined = true;
            }
            tmpInt = arg1.getPower();
            if (-2147483648 != tmpInt) 
            {
                loc1.power = tmpInt;
                commonEntry.powerDefined = true;
            }
            tmpNumber = arg1.getSpeed();
            if (!isNaN(tmpNumber)) 
            {
                loc1.speed = tmpNumber;
                commonEntry.speedDefined = true;
            }
            tmpInt = arg1.getTemperature();
            if (-2147483648 != tmpInt) 
            {
                loc1.temperature = tmpInt;
                commonEntry.temperatureDefined = true;
            }
            if (loc1.number > 1) 
            {
                loc1.trainingTimeAbsolute = (arg1.getTimestamp().getDate().time - timeAtFirstEntry) * 0.1;
                loc1.trainingTime = loc1.trainingTimeAbsolute - lastEntry.trainingTimeAbsolute;
            }
            else 
            {
                timeAtFirstEntry = arg1.getTimestamp().getDate().time;
                loc1.trainingTimeAbsolute = 0;
                loc1.trainingTime = 0;
            }
            lastEntry = loc1;
            return loc1;
        }

        public function calcCommonEntryDefinitions():void
        {
            var loc1:*=null;
            var loc7:*=0;
            var loc4:*=0;
            var loc5:*=null;
            var loc6:*;
            var loc2:*=(loc6 = sourceActivity.entries).length;
            var loc3:*=0;
            var loc8:*=0;
            loc7 = 0;
            while (loc7 < loc2) 
            {
                loc1 = loc6[loc7];
                loc1.altitudeDefined = commonEntry.altitudeDefined;
                loc1.cadenceDefined = commonEntry.cadenceDefined;
                loc1.caloriesDefined = commonEntry.caloriesDefined;
                loc1.distanceDefined = commonEntry.distanceDefined;
                loc1.distanceAbsoluteDefined = commonEntry.distanceAbsoluteDefined;
                loc1.inclineDefined = commonEntry.inclineDefined;
                loc1.heartrateDefined = commonEntry.heartrateDefined;
                if (loc1.latitudeDefined && commonEntry.latitudeDefined) 
                {
                    loc3 = loc7;
                }
                else if (!loc1.latitudeDefined && commonEntry.latitudeDefined) 
                {
                    loc4 = loc3;
                    while (loc4 <= loc7) 
                    {
                        (loc5 = loc6[loc4]).latitude = loc1.latitude;
                        loc5.longitude = loc1.longitude;
                        ++loc4;
                    }
                    ++loc3;
                }
                loc1.latitudeDefined = commonEntry.latitudeDefined;
                loc1.longitudeDefined = commonEntry.longitudeDefined;
                loc1.powerDefined = commonEntry.powerDefined;
                loc1.speedDefined = commonEntry.speedDefined;
                loc1.temperatureDefined = commonEntry.temperatureDefined;
                ++loc7;
            }
            commonEntry = core.activities.ActivityFactory.createLogEntryFromLog(sourceActivity);
            return;
        }

        public function createRecordMesgFromEntry(arg1:core.activities.ActivityEntry, arg2:com.garmin.fit.FITFileEncoder, arg3:Number):void
        {
            if (!(arg1.latitude == 0) && !(arg1.longitude == 0)) 
            {
                mapEntryToRecordMesg(recordMesgWidthGPS, arg1, arg2, arg3);
            }
            else 
            {
                mapEntryToRecordMesg(recordMesgNoGPS, arg1, arg2, arg3);
            }
            return;
        }

        public function createRecordMesgFromMarker(arg1:core.marker.Marker, arg2:com.garmin.fit.FITFileEncoder, arg3:Number):void
        {
            var loc1:*;
            (loc1 = new com.garmin.fit.RecordMesg()).setLocalNum(6);
            loc1.setTimestamp(new com.garmin.fit.DateTime(activityStartTime + 10 * (arg1.timeAbsolute + arg3)));
            if (arg1.latitudeDefined) 
            {
                loc1.setPositionLat(com.garmin.fit.custom.FitConverter.convertDegreeToSemicircles(arg1.latitude));
                loc1.setPositionLong(com.garmin.fit.custom.FitConverter.convertDegreeToSemicircles(arg1.longitude));
            }
            loc1.setDistance(arg1.distanceAbsolute);
            arg2.write(loc1);
            return;
        }

        internal function mapEntryToRecordMesg(arg1:com.garmin.fit.RecordMesg, arg2:core.activities.ActivityEntry, arg3:com.garmin.fit.FITFileEncoder, arg4:Number):void
        {
            arg1.setAccumulatedPower(arg2.power);
            arg1.setAltitude(millimeterToMeter.convert(arg2.altitude));
            arg1.setCadence(arg2.cadence);
            arg1.setCalories(arg2.calories);
            arg1.setDistance(arg2.distanceAbsolute);
            arg1.setGrade(arg2.incline);
            arg1.setHeartRate(arg2.heartrate);
            if (arg1.getLocalNum() == 2) 
            {
                arg1.setPositionLat(com.garmin.fit.custom.FitConverter.convertDegreeToSemicircles(arg2.latitude));
                arg1.setPositionLong(com.garmin.fit.custom.FitConverter.convertDegreeToSemicircles(arg2.longitude));
            }
            arg1.setPower(arg2.power);
            arg1.setSpeed(arg2.speed);
            arg1.setTemperature(arg2.temperature);
            arg1.setTimestamp(new com.garmin.fit.DateTime(activityStartTime + 10 * (arg2.trainingTimeAbsolute + arg4)));
            arg3.write(arg1);
            return;
        }

        
        {
            recordMesgNoGPS = new com.garmin.fit.RecordMesg();
            recordMesgWidthGPS = new com.garmin.fit.RecordMesg();
        }

        internal const meterToMillimeter:utils.converter.AltitudeConverter=new utils.converter.AltitudeConverter("meter", "millimeter");

        internal const millimeterToMeter:utils.converter.AltitudeConverter=new utils.converter.AltitudeConverter("millimeter", "meter");

        internal static const MESG_RECORD_WITHOUT_GPS:int=1;

        internal static const MESG_RECORD_WITH_GPS:int=2;

        internal var activityStartTime:Number;

        internal var commonEntry:core.activities.ActivityEntry;

        internal var lastEntry:core.activities.ActivityEntry;

        internal var sourceActivity:core.activities.Activity=null;

        internal var timeAtFirstEntry:Number;

        internal var tmpInt:int;

        internal var tmpNumber:Number;

        internal static var recordMesgNoGPS:com.garmin.fit.RecordMesg;

        internal static var recordMesgWidthGPS:com.garmin.fit.RecordMesg;
    }
}


