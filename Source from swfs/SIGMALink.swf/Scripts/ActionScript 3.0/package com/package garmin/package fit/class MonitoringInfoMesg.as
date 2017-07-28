//class MonitoringInfoMesg
package com.garmin.fit 
{
    public class MonitoringInfoMesg extends com.garmin.fit.Mesg
    {
        public function MonitoringInfoMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(103));
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

        public function getLocalTimestamp():Number
        {
            return getFieldDoubleValue(0, 0, 65535);
        }

        public function setLocalTimestamp(arg1:Number):void
        {
            setFieldValue(0, 0, arg1, 65535);
            return;
        }

        public static function get monitoringInfoMesg():com.garmin.fit.Mesg
        {
            return _monitoringInfoMesg;
        }

        
        {
            _monitoringInfoMesg = new com.garmin.fit.Mesg("monitoring_info", 103);
            monitoringInfoMesg.addField(new com.garmin.fit.Field("timestamp", 253, 134, 1, 0, ""));
            monitoringInfoMesg.addField(new com.garmin.fit.Field("local_timestamp", 0, 134, 1, 0, ""));
        }

        internal static var _monitoringInfoMesg:com.garmin.fit.Mesg;
    }
}


