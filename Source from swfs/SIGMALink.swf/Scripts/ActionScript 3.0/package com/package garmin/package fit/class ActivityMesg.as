//class ActivityMesg
package com.garmin.fit 
{
    public class ActivityMesg extends com.garmin.fit.Mesg implements com.garmin.fit.MesgWithEvent
    {
        public function ActivityMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(34));
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

        public function getTotalTimerTime():Number
        {
            return getFieldDoubleValue(0, 0, 65535);
        }

        public function setTotalTimerTime(arg1:Number):void
        {
            setFieldValue(0, 0, arg1, 65535);
            return;
        }

        public function getNumSessions():int
        {
            return getFieldIntegerValue(1, 0, 65535);
        }

        public function setNumSessions(arg1:int):void
        {
            setFieldValue(1, 0, arg1, 65535);
            return;
        }

        public function getType():com.garmin.fit.Activity
        {
            var loc1:*=getFieldIntegerValue(2, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.Activity.getByValue(loc1);
        }

        public function setType(arg1:com.garmin.fit.Activity):void
        {
            setFieldValue(2, 0, arg1.getValue(), 65535);
            return;
        }

        public function getEvent():com.garmin.fit.FITEvent
        {
            var loc1:*=getFieldIntegerValue(3, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.FITEvent.getByValue(loc1);
        }

        public function setEvent(arg1:com.garmin.fit.FITEvent):void
        {
            setFieldValue(3, 0, arg1.getValue(), 65535);
            return;
        }

        public function getEventType():com.garmin.fit.EventType
        {
            var loc1:*=getFieldIntegerValue(4, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.EventType.getByValue(loc1);
        }

        public function setEventType(arg1:com.garmin.fit.EventType):void
        {
            setFieldValue(4, 0, arg1.getValue(), 65535);
            return;
        }

        public function getLocalTimestamp():Number
        {
            return getFieldDoubleValue(5, 0, 65535);
        }

        public function setLocalTimestamp(arg1:Number):void
        {
            setFieldValue(5, 0, arg1, 65535);
            return;
        }

        public function getEventGroup():int
        {
            return getFieldIntegerValue(6, 0, 65535);
        }

        public function setEventGroup(arg1:int):void
        {
            setFieldValue(6, 0, arg1, 65535);
            return;
        }

        public static function get activityMesg():com.garmin.fit.Mesg
        {
            return _activityMesg;
        }

        
        {
            _activityMesg = new com.garmin.fit.Mesg("activity", 34);
            activityMesg.addField(new com.garmin.fit.Field("timestamp", 253, 134, 1, 0, ""));
            activityMesg.addField(new com.garmin.fit.Field("total_timer_time", 0, 134, 1000, 0, "s"));
            activityMesg.addField(new com.garmin.fit.Field("num_sessions", 1, 132, 1, 0, ""));
            activityMesg.addField(new com.garmin.fit.Field("type", 2, 0, 1, 0, ""));
            activityMesg.addField(new com.garmin.fit.Field("event", 3, 0, 1, 0, ""));
            activityMesg.addField(new com.garmin.fit.Field("event_type", 4, 0, 1, 0, ""));
            activityMesg.addField(new com.garmin.fit.Field("local_timestamp", 5, 134, 1, 0, ""));
            activityMesg.addField(new com.garmin.fit.Field("event_group", 6, 2, 1, 0, ""));
        }

        internal static var _activityMesg:com.garmin.fit.Mesg;
    }
}


