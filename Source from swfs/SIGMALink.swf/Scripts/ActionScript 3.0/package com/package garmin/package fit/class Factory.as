//class Factory
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


