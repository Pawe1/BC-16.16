//class ActivityFITMapper
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


