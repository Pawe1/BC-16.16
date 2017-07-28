//class TotalsMesg
package com.garmin.fit 
{
    public class TotalsMesg extends com.garmin.fit.Mesg
    {
        public function TotalsMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(33));
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

        public function getTimerTime():Number
        {
            return getFieldDoubleValue(0, 0, 65535);
        }

        public function setTimerTime(arg1:Number):void
        {
            setFieldValue(0, 0, arg1, 65535);
            return;
        }

        public function getDistance():Number
        {
            return getFieldDoubleValue(1, 0, 65535);
        }

        public function setDistance(arg1:Number):void
        {
            setFieldValue(1, 0, arg1, 65535);
            return;
        }

        public function getCalories():Number
        {
            return getFieldDoubleValue(2, 0, 65535);
        }

        public function setCalories(arg1:Number):void
        {
            setFieldValue(2, 0, arg1, 65535);
            return;
        }

        public function getSport():com.garmin.fit.Sport
        {
            var loc1:*=getFieldIntegerValue(3, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.Sport.getByValue(loc1);
        }

        public function setSport(arg1:com.garmin.fit.Sport):void
        {
            setFieldValue(3, 0, arg1.getValue(), 65535);
            return;
        }

        public function getElapsedTime():Number
        {
            return getFieldDoubleValue(4, 0, 65535);
        }

        public function setElapsedTime(arg1:Number):void
        {
            setFieldValue(4, 0, arg1, 65535);
            return;
        }

        public function getSessions():int
        {
            return getFieldIntegerValue(5, 0, 65535);
        }

        public function setSessions(arg1:int):void
        {
            setFieldValue(5, 0, arg1, 65535);
            return;
        }

        public function getActiveTime():Number
        {
            return getFieldDoubleValue(6, 0, 65535);
        }

        public function setActiveTime(arg1:Number):void
        {
            setFieldValue(6, 0, arg1, 65535);
            return;
        }

        public static function get totalsMesg():com.garmin.fit.Mesg
        {
            return _totalsMesg;
        }

        
        {
            _totalsMesg = new com.garmin.fit.Mesg("totals", 33);
            totalsMesg.addField(new com.garmin.fit.Field("message_index", 254, 132, 1, 0, ""));
            totalsMesg.addField(new com.garmin.fit.Field("timestamp", 253, 134, 1, 0, "s"));
            totalsMesg.addField(new com.garmin.fit.Field("timer_time", 0, 134, 1, 0, "s"));
            totalsMesg.addField(new com.garmin.fit.Field("distance", 1, 134, 1, 0, "m"));
            totalsMesg.addField(new com.garmin.fit.Field("calories", 2, 134, 1, 0, "kcal"));
            totalsMesg.addField(new com.garmin.fit.Field("sport", 3, 0, 1, 0, ""));
            totalsMesg.addField(new com.garmin.fit.Field("elapsed_time", 4, 134, 1, 0, "s"));
            totalsMesg.addField(new com.garmin.fit.Field("sessions", 5, 132, 1, 0, ""));
            totalsMesg.addField(new com.garmin.fit.Field("active_time", 6, 134, 1, 0, "s"));
        }

        internal static var _totalsMesg:com.garmin.fit.Mesg;
    }
}


