//class SessionMesg
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


