//class LapMesg
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


