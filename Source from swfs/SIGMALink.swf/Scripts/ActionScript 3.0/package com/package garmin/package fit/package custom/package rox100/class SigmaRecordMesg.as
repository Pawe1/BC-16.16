//class SigmaRecordMesg
package com.garmin.fit.custom.rox100 
{
    import com.garmin.fit.*;
    
    public class SigmaRecordMesg extends com.garmin.fit.Mesg
    {
        public function SigmaRecordMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(65280));
            return;
        }

        public function getTrainigTimeAbsolute():Number
        {
            return getFieldDoubleValue(0, 0, 65535);
        }

        public function setTrainigTimeAbsolute(arg1:Number):void
        {
            setFieldValue(0, 0, arg1, 65535);
            return;
        }

        public function getAltitudeDifferencesDownhill():int
        {
            return getFieldDoubleValue(1, 0, 65535);
        }

        public function setAltitudeDifferencesDownhill(arg1:int):void
        {
            setFieldValue(1, 0, arg1, 65535);
            return;
        }

        public function getAltitudeDifferencesUphill():int
        {
            return getFieldDoubleValue(2, 0, 65535);
        }

        public function setAltitudeDifferencesUphill(arg1:int):void
        {
            setFieldValue(2, 0, arg1, 65535);
            return;
        }

        public function getDistance():Number
        {
            return getFieldDoubleValue(3, 0, 65535);
        }

        public function setDistance(arg1:Number):void
        {
            setFieldValue(3, 0, arg1, 65535);
            return;
        }

        public function getDistanceDownhill():Number
        {
            return getFieldDoubleValue(4, 0, 65535);
        }

        public function setDistanceDownhill(arg1:Number):void
        {
            setFieldValue(4, 0, arg1, 65535);
            return;
        }

        public function getDistanceUphill():Number
        {
            return getFieldDoubleValue(5, 0, 65535);
        }

        public function setDistanceUphill(arg1:Number):void
        {
            setFieldValue(5, 0, arg1, 65535);
            return;
        }

        public function getPercentHRMax():Number
        {
            return getFieldDoubleValue(6, 0, 65535);
        }

        public function setPercentHRMax(arg1:Number):void
        {
            setFieldValue(6, 0, arg1, 65535);
            return;
        }

        public function getAvgPowerPerKG():int
        {
            return getFieldDoubleValue(7, 0, 65535);
        }

        public function setAvgPowerPerKG(arg1:int):void
        {
            setFieldValue(7, 0, arg1, 65535);
            return;
        }

        public function getRideTimeDownhill():Number
        {
            return getFieldDoubleValue(8, 0, 65535);
        }

        public function setRideTimeDownhill(arg1:Number):void
        {
            setFieldValue(8, 0, arg1, 65535);
            return;
        }

        public function getRideTimeUphill():Number
        {
            return getFieldDoubleValue(9, 0, 65535);
        }

        public function setRideTimeUphill(arg1:Number):void
        {
            setFieldValue(9, 0, arg1, 65535);
            return;
        }

        public function getRiseRate():Number
        {
            return getFieldDoubleValue(10, 0, 65535);
        }

        public function setRiseRate(arg1:Number):void
        {
            setFieldValue(10, 0, arg1, 65535);
            return;
        }

        public function getSpeedReference():String
        {
            return getFieldStringValue(11, 0, 65535);
        }

        public function setSpeedReference(arg1:String):void
        {
            setFieldValue(11, 0, arg1, 65535);
            return;
        }

        public function getTargetZone():int
        {
            return getFieldDoubleValue(12, 0, 65535);
        }

        public function setTargetZone(arg1:int):void
        {
            setFieldValue(12, 0, arg1, 65535);
            return;
        }

        public function getTrainigTime():Number
        {
            return getFieldDoubleValue(13, 0, 65535);
        }

        public function setTrainigTime(arg1:Number):void
        {
            setFieldValue(13, 0, arg1, 65535);
            return;
        }

        public function getWork():Number
        {
            return getFieldDoubleValue(14, 0, 65535);
        }

        public function setWork(arg1:Number):void
        {
            setFieldValue(14, 0, arg1, 65535);
            return;
        }

        public function getIntensityZone():int
        {
            return getFieldDoubleValue(15, 0, 65535);
        }

        public function setIntensityZone(arg1:int):void
        {
            setFieldValue(15, 0, arg1, 65535);
            return;
        }

        public static function get logEntryMesg():com.garmin.fit.Mesg
        {
            return _logEntryMesg;
        }

        
        {
            _logEntryMesg = new com.garmin.fit.Mesg("sigmaRecord", 65280);
            _logEntryMesg.addField(new com.garmin.fit.Field("trainigTimeAbsolute", 0, 134, 100, 0, "s"));
            _logEntryMesg.addField(new com.garmin.fit.Field("altitudeDifferencesDownhill", 1, 2, 1, 0, "m"));
            _logEntryMesg.addField(new com.garmin.fit.Field("altitudeDifferencesUphill", 2, 2, 1, 0, "m"));
            _logEntryMesg.addField(new com.garmin.fit.Field("distance", 3, 134, 100, 1, "m"));
            _logEntryMesg.addField(new com.garmin.fit.Field("distanceDownhill", 4, 134, 100, 0, "m"));
            _logEntryMesg.addField(new com.garmin.fit.Field("distanceUphill", 5, 134, 100, 0, "m"));
            _logEntryMesg.addField(new com.garmin.fit.Field("percentHRMax", 6, 131, 100, 0, "%"));
            _logEntryMesg.addField(new com.garmin.fit.Field("avgPowerPerKG", 7, 132, 1, 0, "W/kg"));
            _logEntryMesg.addField(new com.garmin.fit.Field("rideTimeDownhill", 8, 132, 100, 0, "s"));
            _logEntryMesg.addField(new com.garmin.fit.Field("rideTimeUphill", 9, 132, 100, 0, "s"));
            _logEntryMesg.addField(new com.garmin.fit.Field("riseRate", 10, 133, 1, 0, "mm/min"));
            _logEntryMesg.addField(new com.garmin.fit.Field("speedReference", 11, 7, 1, 0, "device"));
            _logEntryMesg.addField(new com.garmin.fit.Field("targetZone", 12, 2, 1, 0, ""));
            _logEntryMesg.addField(new com.garmin.fit.Field("trainigTime", 13, 132, 100, 0, "s"));
            _logEntryMesg.addField(new com.garmin.fit.Field("work", 14, 134, 10000, 0, "kJ"));
            _logEntryMesg.addField(new com.garmin.fit.Field("intensityZone", 15, 2, 1, 0, ""));
        }

        internal static var _logEntryMesg:com.garmin.fit.Mesg;
    }
}


