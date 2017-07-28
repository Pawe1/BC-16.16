//class BloodPressureMesg
package com.garmin.fit 
{
    public class BloodPressureMesg extends com.garmin.fit.Mesg
    {
        public function BloodPressureMesg(arg1:com.garmin.fit.Mesg)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(51));
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

        public function getSystolicPressure():int
        {
            return getFieldIntegerValue(0, 0, 65535);
        }

        public function setSystolicPressure(arg1:int):void
        {
            setFieldValue(0, 0, arg1, 65535);
            return;
        }

        public function getDiastolicPressure():int
        {
            return getFieldIntegerValue(1, 0, 65535);
        }

        public function setDiastolicPressure(arg1:int):void
        {
            setFieldValue(1, 0, arg1, 65535);
            return;
        }

        public function getMeanArterialPressure():int
        {
            return getFieldIntegerValue(2, 0, 65535);
        }

        public function setMeanArterialPressure(arg1:int):void
        {
            setFieldValue(2, 0, arg1, 65535);
            return;
        }

        public function getMap3SampleMean():int
        {
            return getFieldIntegerValue(3, 0, 65535);
        }

        public function setMap3SampleMean(arg1:int):void
        {
            setFieldValue(3, 0, arg1, 65535);
            return;
        }

        public function getMapMorningValues():int
        {
            return getFieldIntegerValue(4, 0, 65535);
        }

        public function setMapMorningValues(arg1:int):void
        {
            setFieldValue(4, 0, arg1, 65535);
            return;
        }

        public function getMapEveningValues():int
        {
            return getFieldIntegerValue(5, 0, 65535);
        }

        public function setMapEveningValues(arg1:int):void
        {
            setFieldValue(5, 0, arg1, 65535);
            return;
        }

        public function getHeartRate():int
        {
            return getFieldIntegerValue(6, 0, 65535);
        }

        public function setHeartRate(arg1:int):void
        {
            setFieldValue(6, 0, arg1, 65535);
            return;
        }

        public function getHeartRateType():com.garmin.fit.HrType
        {
            var loc1:*=getFieldIntegerValue(7, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.HrType.getByValue(loc1);
        }

        public function setHeartRateType(arg1:com.garmin.fit.HrType):void
        {
            setFieldValue(7, 0, arg1.getValue(), 65535);
            return;
        }

        public function getStatus():com.garmin.fit.BpStatus
        {
            var loc1:*=getFieldIntegerValue(8, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.BpStatus.getByValue(loc1);
        }

        public function setStatus(arg1:com.garmin.fit.BpStatus):void
        {
            setFieldValue(8, 0, arg1.getValue(), 65535);
            return;
        }

        public function getUserProfileIndex():int
        {
            return getFieldIntegerValue(9, 0, 65535);
        }

        public function setUserProfileIndex(arg1:int):void
        {
            setFieldValue(9, 0, arg1, 65535);
            return;
        }

        public static function get bloodPressureMesg():com.garmin.fit.Mesg
        {
            return _bloodPressureMesg;
        }

        
        {
            _bloodPressureMesg = new com.garmin.fit.Mesg("blood_pressure", 51);
            bloodPressureMesg.addField(new com.garmin.fit.Field("timestamp", 253, 134, 1, 0, "s"));
            bloodPressureMesg.addField(new com.garmin.fit.Field("systolic_pressure", 0, 132, 1, 0, "mmHg"));
            bloodPressureMesg.addField(new com.garmin.fit.Field("diastolic_pressure", 1, 132, 1, 0, "mmHg"));
            bloodPressureMesg.addField(new com.garmin.fit.Field("mean_arterial_pressure", 2, 132, 1, 0, "mmHg"));
            bloodPressureMesg.addField(new com.garmin.fit.Field("map_3_sample_mean", 3, 132, 1, 0, "mmHg"));
            bloodPressureMesg.addField(new com.garmin.fit.Field("map_morning_values", 4, 132, 1, 0, "mmHg"));
            bloodPressureMesg.addField(new com.garmin.fit.Field("map_evening_values", 5, 132, 1, 0, "mmHg"));
            bloodPressureMesg.addField(new com.garmin.fit.Field("heart_rate", 6, 2, 1, 0, "bpm"));
            bloodPressureMesg.addField(new com.garmin.fit.Field("heart_rate_type", 7, 0, 1, 0, ""));
            bloodPressureMesg.addField(new com.garmin.fit.Field("status", 8, 0, 1, 0, ""));
            bloodPressureMesg.addField(new com.garmin.fit.Field("user_profile_index", 9, 132, 1, 0, ""));
        }

        internal static var _bloodPressureMesg:com.garmin.fit.Mesg;
    }
}


