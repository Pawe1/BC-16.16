//class WorkoutStepMesg
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


