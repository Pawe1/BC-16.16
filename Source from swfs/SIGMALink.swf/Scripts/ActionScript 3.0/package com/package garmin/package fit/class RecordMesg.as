//class RecordMesg
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


