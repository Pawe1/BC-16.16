//package fit
//  class ActivityFITMapper
package core.fit 
{
    import com.garmin.fit.*;
    import com.garmin.fit.custom.*;
    import com.logging.*;
    import core.activities.*;
    import core.general.*;
    import core.marker.*;
    import core.units.*;
    import flash.errors.*;
    import flash.events.*;
    import flash.utils.*;
    import handler.*;
    import utils.*;
    import utils.converter.*;
    
    public class ActivityFITMapper extends flash.events.EventDispatcher
    {
        public function ActivityFITMapper(arg1:Object)
        {
            super();
            if (arg1 != SINGLETON_ENFORCER) 
            {
                throw new flash.errors.IllegalOperationError("IllegalOperation: Manipulation of type " + flash.utils.getQualifiedClassName(this));
            }
            com.logging.ErrorLogging.getInstance().addTarget(this);
            return;
        }

        public function generateFIT(arg1:com.garmin.fit.FITFileEncoder):void
        {
            recordCreationTimeAll = 0;
            recordCounter = 0;
            lapCreationTime = 0;
            lapCounter = 0;
            var loc1:*=0;
            try 
            {
                generateActivity(arg1);
            }
            catch (fre:com.garmin.fit.FitRuntimeException)
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent(fre.event, fre.code, fre.message));
                loc1 = 0;
            }
            catch (e:Error)
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 1800001, "FITEncoding > Logical Error: "));
                loc1 = 0;
            }
            finally
            {
                try 
                {
                    arg1.close();
                }
                catch (e:com.garmin.fit.FitRuntimeException)
                {
                    dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 1800002, "FitEncoding > generateFitFile: Unable to close the File after Writing"));
                    return;
                }
            }
            throw loc4;
            return;
        }

        internal function generateActivity(arg1:com.garmin.fit.FITFileEncoder):void
        {
            var loc11:*=null;
            var loc8:*=null;
            var loc2:*=null;
            var loc13:*=0;
            var loc4:*=new Date().time;
            var loc6:*;
            (loc6 = utils.Util.toArray(sourceActivity.markerList)).sortOn("timeAbsolute", 16);
            fileIdMesgActivity.setLocalNum(0);
            var loc10:*=12345;
            if (sourceActivity.unit && sourceActivity.unit.serialNumber) 
            {
                loc10 = sourceActivity.unit.serialNumber;
            }
            fileIdMesgActivity.setSerialNumber(loc10);
            fileIdMesgActivity.setTimeCreated(new com.garmin.fit.DateTime(startTime));
            fileIdMesgActivity.setManufacturer(70);
            fileIdMesgActivity.setProduct(core.units.UnitFactory.getFITProductId(sourceActivity.unitType));
            fileIdMesgActivity.setType(com.garmin.fit.FITFile.ACTIVITY);
            fileIdMesgActivity.setProductName(core.general.UnitType.formatUnit(sourceActivity.unitType));
            arg1.write(fileIdMesgActivity);
            eventTimerMesgStart.setLocalNum(1);
            eventTimerMesgStart.setTimestamp(new com.garmin.fit.DateTime(startTime));
            eventTimerMesgStart.setTimerTrigger(com.garmin.fit.TimerTrigger.MANUAL);
            eventTimerMesgStart.setEvent(com.garmin.fit.FITEvent.TIMER);
            eventTimerMesgStart.setEventType(com.garmin.fit.EventType.START);
            arg1.write(eventTimerMesgStart);
            var loc5:*=-1;
            var loc12:*=null;
            var loc1:*=0;
            var loc15:*=0;
            var loc7:*=core.units.UnitFactory.calculateFitWithBreaks(sourceActivity.unitType);
            var loc14:*=0;
            var loc9:*=loc6.length;
            var loc3:*=handler.ActivityCalculator.getLastMarker(sourceActivity, "p");
            loc14 = 0;
            while (loc14 < loc9) 
            {
                loc11 = loc6[loc14];
                while (loc5 + 1 < sourceActivity.entries.length) 
                {
                    ++loc5;
                    loc8 = sourceActivity.entries[loc5];
                    entryMappper.createRecordMesgFromEntry(loc8, arg1, loc1);
                    if (loc8.trainingTimeAbsolute < loc11.timeAbsolute) 
                    {
                        continue;
                    }
                    if (!(loc8.trainingTimeAbsolute >= loc11.timeAbsolute)) 
                    {
                        continue;
                    }
                    if (loc11.type != "p") 
                    {
                        if (loc11.type == "l" || loc11.type == "al") 
                        {
                            markerMappper.createLapMesgFromMarker(loc11, loc12, loc15, loc1, arg1);
                            loc15 = 0;
                            loc12 = loc11;
                        }
                    }
                    else 
                    {
                        loc2 = core.activities.ActivityEntry.copy(loc8, sourceActivity);
                        if (loc7) 
                        {
                            loc1 = loc1 + loc11.duration;
                            loc15 = loc15 + loc11.duration;
                            loc2.distanceAbsolute = loc11.distanceAbsolute;
                            entryMappper.createRecordMesgFromEntry(loc2, arg1, loc1);
                        }
                    }
                    break;
                }
                if (!(loc8.trainingTimeAbsolute >= loc11.timeAbsolute)) 
                {
                    if (loc5 >= (sourceActivity.entries.length - 1)) 
                    {
                        if (loc11.type == "l" || loc11.type == "al") 
                        {
                            markerMappper.createLapMesgFromMarker(loc11, loc12, loc15, loc1, arg1);
                            loc15 = 0;
                            loc12 = loc11;
                        }
                        else if (loc11.type == "p") 
                        {
                            if (loc7) 
                            {
                                loc15 = loc15 + loc11.duration;
                                loc1 = loc1 + loc11.duration;
                            }
                        }
                    }
                }
                ++loc14;
            }
            if (loc5 < (sourceActivity.entries.length - 1)) 
            {
                loc13 = loc5;
                while (loc13 < sourceActivity.entries.length) 
                {
                    loc8 = sourceActivity.entries[loc13];
                    entryMappper.createRecordMesgFromEntry(loc8, arg1, loc1);
                    ++loc13;
                }
            }
            eventMesgStopAll.setLocalNum(2);
            eventMesgStopAll.setTimestamp(new com.garmin.fit.DateTime(startTime + 10 * sourceActivity.trainingTime));
            eventMesgStopAll.setTimerTrigger(com.garmin.fit.TimerTrigger.AUTO);
            eventMesgStopAll.setEvent(com.garmin.fit.FITEvent.TIMER);
            eventMesgStopAll.setEventType(com.garmin.fit.EventType.STOP_ALL);
            eventMesgStopAll.setEventGroup(0);
            arg1.write(eventMesgStopAll);
            sessionMesg.setLocalNum(8);
            sessionMesg.setAvgAltitude(millimeterToMeter.convert(sourceActivity.averageAltitude));
            sessionMesg.setAvgCadence(sourceActivity.averageCadence);
            sessionMesg.setAvgHeartRate(sourceActivity.averageHeartrate);
            sessionMesg.setAvgPower(sourceActivity.averagePower);
            sessionMesg.setAvgSpeed(sourceActivity.averageSpeed);
            sessionMesg.setAvgTemperature(sourceActivity.averageTemperature);
            sessionMesg.setEvent(com.garmin.fit.FITEvent.SESSION);
            sessionMesg.setEventType(com.garmin.fit.EventType.STOP);
            sessionMesg.setMaxAltitude(millimeterToMeter.convert(sourceActivity.maximumAltitude));
            sessionMesg.setMaxCadence(sourceActivity.maximumCadence);
            sessionMesg.setMaxHeartRate(sourceActivity.maximumHeartrate);
            sessionMesg.setMaxNegGrade(sourceActivity.maximumInclineDownhill);
            sessionMesg.setMaxPosGrade(sourceActivity.maximumInclineUphill);
            sessionMesg.setMaxPower(sourceActivity.maximumPower);
            sessionMesg.setMaxSpeed(sourceActivity.maximumSpeed);
            sessionMesg.setMaxTemperature(sourceActivity.maximumTemperature);
            sessionMesg.setMessageIndex(0);
            sessionMesg.setMinAltitude(sourceActivity.minimumAltitude * 0.001);
            sessionMesg.setMinHeartRate(sourceActivity.minimumHeartrate);
            if (core.general.UnitType.SigmaMove.equals(sourceActivity.unitType) || core.general.UnitType.PC2814.equals(sourceActivity.unitType) || core.general.UnitType.Activo.equals(sourceActivity.unitType)) 
            {
                sessionMesg.setSport(com.garmin.fit.Sport.RUNNING);
                sessionMesg.setSubSport(com.garmin.fit.SubSport.STREET);
            }
            else if ("bmx" != sourceActivity.sport.keyName) 
            {
                if ("cyclecross" != sourceActivity.sport.keyName) 
                {
                    if ("cycling" != sourceActivity.sport.keyName) 
                    {
                        if ("ebike" != sourceActivity.sport.keyName) 
                        {
                            if ("enduro" != sourceActivity.sport.keyName) 
                            {
                                if ("fitness" != sourceActivity.sport.keyName) 
                                {
                                    if ("golf" != sourceActivity.sport.keyName) 
                                    {
                                        if ("hiking" != sourceActivity.sport.keyName) 
                                        {
                                            if ("indoor_cycling" != sourceActivity.sport.keyName) 
                                            {
                                                if ("inline_skates" != sourceActivity.sport.keyName) 
                                                {
                                                    if ("mountainbike" != sourceActivity.sport.keyName) 
                                                    {
                                                        if ("other" != sourceActivity.sport.keyName) 
                                                        {
                                                            if ("racing_bycicle" != sourceActivity.sport.keyName) 
                                                            {
                                                                if ("running" != sourceActivity.sport.keyName) 
                                                                {
                                                                    if ("ski" != sourceActivity.sport.keyName) 
                                                                    {
                                                                        if ("snowboarding" != sourceActivity.sport.keyName) 
                                                                        {
                                                                            if ("swimming" != sourceActivity.sport.keyName) 
                                                                            {
                                                                                if ("treadmill" != sourceActivity.sport.keyName) 
                                                                                {
                                                                                    if ("triathlon" != sourceActivity.sport.keyName) 
                                                                                    {
                                                                                        if ("walking" == sourceActivity.sport.keyName) 
                                                                                        {
                                                                                            sessionMesg.setSport(com.garmin.fit.Sport.RUNNING);
                                                                                            sessionMesg.setSubSport(com.garmin.fit.SubSport.STREET);
                                                                                        }
                                                                                    }
                                                                                    else 
                                                                                    {
                                                                                        sessionMesg.setSport(com.garmin.fit.Sport.GENERIC);
                                                                                        sessionMesg.setSubSport(com.garmin.fit.SubSport.FLEXIBILITY_TRAINING);
                                                                                    }
                                                                                }
                                                                                else 
                                                                                {
                                                                                    sessionMesg.setSport(com.garmin.fit.Sport.FITNESS_EQUIPMENT);
                                                                                    sessionMesg.setSubSport(com.garmin.fit.SubSport.SPIN);
                                                                                }
                                                                            }
                                                                            else 
                                                                            {
                                                                                sessionMesg.setSport(com.garmin.fit.Sport.SWIMMING);
                                                                                sessionMesg.setSubSport(com.garmin.fit.SubSport.OPEN_WATER);
                                                                            }
                                                                        }
                                                                        else 
                                                                        {
                                                                            sessionMesg.setSport(com.garmin.fit.Sport.GENERIC);
                                                                            sessionMesg.setSubSport(com.garmin.fit.SubSport.GENERIC);
                                                                        }
                                                                    }
                                                                    else 
                                                                    {
                                                                        sessionMesg.setSport(com.garmin.fit.Sport.GENERIC);
                                                                        sessionMesg.setSubSport(com.garmin.fit.SubSport.GENERIC);
                                                                    }
                                                                }
                                                                else 
                                                                {
                                                                    sessionMesg.setSport(com.garmin.fit.Sport.RUNNING);
                                                                    sessionMesg.setSubSport(com.garmin.fit.SubSport.STREET);
                                                                }
                                                            }
                                                            else 
                                                            {
                                                                sessionMesg.setSport(com.garmin.fit.Sport.CYCLING);
                                                                sessionMesg.setSubSport(com.garmin.fit.SubSport.STREET);
                                                            }
                                                        }
                                                        else 
                                                        {
                                                            sessionMesg.setSport(com.garmin.fit.Sport.GENERIC);
                                                            sessionMesg.setSubSport(com.garmin.fit.SubSport.GENERIC);
                                                        }
                                                    }
                                                    else 
                                                    {
                                                        sessionMesg.setSport(com.garmin.fit.Sport.CYCLING);
                                                        sessionMesg.setSubSport(com.garmin.fit.SubSport.MOUNTAIN);
                                                    }
                                                }
                                                else 
                                                {
                                                    sessionMesg.setSport(com.garmin.fit.Sport.TRANSITION);
                                                    sessionMesg.setSubSport(com.garmin.fit.SubSport.GENERIC);
                                                }
                                            }
                                            else 
                                            {
                                                sessionMesg.setSport(com.garmin.fit.Sport.CYCLING);
                                                sessionMesg.setSubSport(com.garmin.fit.SubSport.INDOOR_CYCLING);
                                            }
                                        }
                                        else 
                                        {
                                            sessionMesg.setSport(com.garmin.fit.Sport.RUNNING);
                                            sessionMesg.setSubSport(com.garmin.fit.SubSport.STREET);
                                        }
                                    }
                                    else 
                                    {
                                        sessionMesg.setSport(com.garmin.fit.Sport.GENERIC);
                                        sessionMesg.setSubSport(com.garmin.fit.SubSport.GENERIC);
                                    }
                                }
                                else 
                                {
                                    sessionMesg.setSport(com.garmin.fit.Sport.TRAINING);
                                    sessionMesg.setSubSport(com.garmin.fit.SubSport.STRENGTH_TRAINING);
                                }
                            }
                            else 
                            {
                                sessionMesg.setSport(com.garmin.fit.Sport.CYCLING);
                                sessionMesg.setSubSport(com.garmin.fit.SubSport.TRACK);
                            }
                        }
                        else 
                        {
                            sessionMesg.setSport(com.garmin.fit.Sport.CYCLING);
                            sessionMesg.setSubSport(com.garmin.fit.SubSport.ROAD);
                        }
                    }
                    else 
                    {
                        sessionMesg.setSport(com.garmin.fit.Sport.CYCLING);
                        sessionMesg.setSubSport(com.garmin.fit.SubSport.GENERIC);
                    }
                }
                else 
                {
                    sessionMesg.setSport(com.garmin.fit.Sport.CYCLING);
                    sessionMesg.setSubSport(com.garmin.fit.SubSport.CYCLOCROSS);
                }
            }
            else 
            {
                sessionMesg.setSport(com.garmin.fit.Sport.CYCLING);
                sessionMesg.setSubSport(com.garmin.fit.SubSport.TRACK_CYCLING);
            }
            if (sourceActivity.entries.length > 0) 
            {
                sessionMesg.setStartPositionLat(com.garmin.fit.custom.FitConverter.convertDegreeToSemicircles(sourceActivity.entries[0].latitude));
                sessionMesg.setStartPositionLong(com.garmin.fit.custom.FitConverter.convertDegreeToSemicircles(sourceActivity.entries[0].longitude));
            }
            sessionMesg.setStartTime(new com.garmin.fit.DateTime(startTime));
            sessionMesg.setTimestamp(new com.garmin.fit.DateTime(startTime + 10 * sourceActivity.trainingTime));
            sessionMesg.setTotalAscent(millimeterToMeter.convert(sourceActivity.altitudeDifferencesUphill));
            sessionMesg.setTotalCalories(sourceActivity.calories);
            sessionMesg.setTotalDescent(millimeterToMeter.convert(sourceActivity.altitudeDifferencesDownhill));
            sessionMesg.setTotalDistance(sourceActivity.distance);
            sessionMesg.setTotalTimerTime(sourceActivity.trainingTime / 100);
            sessionMesg.setTotalElapsedTime((sourceActivity.trainingTime + loc1) / 100);
            sessionMesg.setTotalMovingTime(sourceActivity.trainingTime / 100);
            sessionMesg.setTrigger(com.garmin.fit.SessionTrigger.ACTIVITY_END);
            arg1.write(sessionMesg);
            activityMesg.setEvent(com.garmin.fit.FITEvent.ACTIVITY);
            activityMesg.setEventType(com.garmin.fit.EventType.STOP);
            activityMesg.setLocalNum(9);
            activityMesg.setNumSessions(1);
            activityMesg.setTimestamp(sessionMesg.getTimestamp());
            activityMesg.setType(com.garmin.fit.Activity.MANUAL);
            arg1.write(activityMesg);
            return;
        }

        public static function getInstance(arg1:core.activities.Activity):core.fit.ActivityFITMapper
        {
            mapper.sourceActivity = arg1;
            mapper.startTime = arg1.startDate.time;
            mapper.entryMappper = new core.fit.EntryFITMapper(arg1);
            mapper.markerMappper = new core.fit.MarkerFITMapper(arg1);
            return mapper;
        }

        
        {
            activityMesg = new com.garmin.fit.ActivityMesg();
            eventMesgStopAll = new com.garmin.fit.EventMesg();
            eventTimerMesgStart = new com.garmin.fit.EventMesg();
            fileIdMesgActivity = new com.garmin.fit.FileIdMesg();
            sessionMesg = new com.garmin.fit.SessionMesg();
        }

        internal const meterToMillimeter:utils.converter.AltitudeConverter=new utils.converter.AltitudeConverter("meter", "millimeter");

        internal const millimeterToMeter:utils.converter.AltitudeConverter=new utils.converter.AltitudeConverter("millimeter", "meter");

        internal static const SINGLETON_ENFORCER:Object={};

        internal static const mapper:core.fit.ActivityFITMapper=new ActivityFITMapper(SINGLETON_ENFORCER);

        internal var entryMappper:core.fit.EntryFITMapper;

        internal var lapCounter:uint=0;

        internal var lapCreationTime:Number=0;

        internal var markerMappper:core.fit.MarkerFITMapper;

        internal var recordCounter:uint=0;

        internal var recordCreationTimeAll:Number=0;

        internal var recordCreationTimeCurrent:uint=0;

        internal var sigmaSpecificMessagesEnabled:Boolean=false;

        internal var sourceActivity:core.activities.Activity=null;

        internal var startTime:Number;

        internal static var activityMesg:com.garmin.fit.ActivityMesg;

        internal static var eventMesgStopAll:com.garmin.fit.EventMesg;

        internal static var eventTimerMesgStart:com.garmin.fit.EventMesg;

        internal static var fileIdMesgActivity:com.garmin.fit.FileIdMesg;

        internal static var sessionMesg:com.garmin.fit.SessionMesg;
    }
}


//  class EntryFITMapper
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


//  class MarkerFITMapper
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


