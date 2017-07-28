//class MonitoringMesg
package com.garmin.fit 
{
    public class MonitoringMesg extends com.garmin.fit.Mesg
    {
        public function MonitoringMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(55));
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

        public function getDeviceIndex():int
        {
            return getFieldIntegerValue(0, 0, 65535);
        }

        public function setDeviceIndex(arg1:int):void
        {
            setFieldValue(0, 0, arg1, 65535);
            return;
        }

        public function getCalories():int
        {
            return getFieldIntegerValue(1, 0, 65535);
        }

        public function setCalories(arg1:int):void
        {
            setFieldValue(1, 0, arg1, 65535);
            return;
        }

        public function getDistance():Number
        {
            return getFieldDoubleValue(2, 0, 65535);
        }

        public function setDistance(arg1:Number):void
        {
            setFieldValue(2, 0, arg1, 65535);
            return;
        }

        public function getCycles():Number
        {
            return getFieldDoubleValue(3, 0, 65535);
        }

        public function setCycles(arg1:Number):void
        {
            setFieldValue(3, 0, arg1, 65535);
            return;
        }

        public function getActiveTime():Number
        {
            return getFieldDoubleValue(4, 0, 65535);
        }

        public function setActiveTime(arg1:Number):void
        {
            setFieldValue(4, 0, arg1, 65535);
            return;
        }

        public function getCompressedDistance():int
        {
            return getFieldIntegerValue(8, 0, 65535);
        }

        public function setCompressedDistance(arg1:int):void
        {
            setFieldValue(8, 0, arg1, 65535);
            return;
        }

        public function getCompressedCycles():int
        {
            return getFieldIntegerValue(9, 0, 65535);
        }

        public function setCompressedCycles(arg1:int):void
        {
            setFieldValue(9, 0, arg1, 65535);
            return;
        }

        public function getCompressedActiveTime():int
        {
            return getFieldIntegerValue(10, 0, 65535);
        }

        public function setCompressedActiveTime(arg1:int):void
        {
            setFieldValue(10, 0, arg1, 65535);
            return;
        }

        public function getLocalTimestamp():Number
        {
            return getFieldDoubleValue(11, 0, 65535);
        }

        public function setLocalTimestamp(arg1:Number):void
        {
            setFieldValue(11, 0, arg1, 65535);
            return;
        }

        public static function get monitoringMesg():com.garmin.fit.Mesg
        {
            return _monitoringMesg;
        }

        
        {
            _monitoringMesg = new com.garmin.fit.Mesg("monitoring", 55);
            monitoringMesg.addField(new com.garmin.fit.Field("timestamp", 253, 134, 1, 0, "s"));
            ++field_index;
            monitoringMesg.addField(new com.garmin.fit.Field("device_index", 0, 2, 1, 0, ""));
            ++field_index;
            monitoringMesg.addField(new com.garmin.fit.Field("calories", 1, 132, 1, 0, "kcal"));
            ++field_index;
            monitoringMesg.addField(new com.garmin.fit.Field("distance", 2, 134, 100, 0, "m"));
            ++field_index;
            monitoringMesg.addField(new com.garmin.fit.Field("cycles", 3, 134, 1, 0, "cycles"));
            ++field_index;
            monitoringMesg.addField(new com.garmin.fit.Field("active_time", 4, 134, 1000, 0, "s"));
            ++field_index;
            monitoringMesg.addField(new com.garmin.fit.Field("activity_type", 5, 0, 1, 0, ""));
            ++field_index;
            monitoringMesg.addField(new com.garmin.fit.Field("activity_subtype", 6, 0, 1, 0, ""));
            ++field_index;
            monitoringMesg.addField(new com.garmin.fit.Field("compressed_distance", 8, 132, 1, 0, ""));
            monitoringMesg.fields[field_index].components.push(new com.garmin.fit.FieldComponent(2, true, 16, 100, 0));
            ++field_index;
            monitoringMesg.addField(new com.garmin.fit.Field("compressed_cycles", 9, 132, 1, 0, ""));
            monitoringMesg.fields[field_index].components.push(new com.garmin.fit.FieldComponent(3, true, 16, 1, 0));
            ++field_index;
            monitoringMesg.addField(new com.garmin.fit.Field("compressed_active_time", 10, 132, 1, 0, ""));
            monitoringMesg.fields[field_index].components.push(new com.garmin.fit.FieldComponent(4, true, 16, 1, 0));
            ++field_index;
            monitoringMesg.addField(new com.garmin.fit.Field("local_timestamp", 11, 134, 1, 0, ""));
            ++field_index;
        }

        internal static var _monitoringMesg:com.garmin.fit.Mesg;

        internal static var field_index:int=0;
    }
}


