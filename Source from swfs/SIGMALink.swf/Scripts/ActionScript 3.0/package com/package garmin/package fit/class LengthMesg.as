//class LengthMesg
package com.garmin.fit 
{
    public class LengthMesg extends com.garmin.fit.Mesg implements com.garmin.fit.MesgWithEvent
    {
        public function LengthMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(101));
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

        public function getTotalElapsedTime():Number
        {
            return getFieldDoubleValue(3, 0, 65535);
        }

        public function setTotalElapsedTime(arg1:Number):void
        {
            setFieldValue(3, 0, arg1, 65535);
            return;
        }

        public function getTotalTimerTime():Number
        {
            return getFieldDoubleValue(4, 0, 65535);
        }

        public function setTotalTimerTime(arg1:Number):void
        {
            setFieldValue(4, 0, arg1, 65535);
            return;
        }

        public function getTotalStrokes():int
        {
            return getFieldIntegerValue(5, 0, 65535);
        }

        public function setTotalStrokes(arg1:int):void
        {
            setFieldValue(5, 0, arg1, 65535);
            return;
        }

        public function getAvgSpeed():Number
        {
            return getFieldDoubleValue(6, 0, 65535);
        }

        public function setAvgSpeed(arg1:Number):void
        {
            setFieldValue(6, 0, arg1, 65535);
            return;
        }

        public function getSwimStroke():com.garmin.fit.SwimStroke
        {
            var loc1:*=getFieldIntegerValue(7, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.SwimStroke.getByValue(loc1);
        }

        public function setSwimStroke(arg1:com.garmin.fit.SwimStroke):void
        {
            setFieldValue(7, 0, arg1.getValue(), 65535);
            return;
        }

        public function getAvgSwimmingCadence():int
        {
            return getFieldIntegerValue(9, 0, 65535);
        }

        public function setAvgSwimmingCadence(arg1:int):void
        {
            setFieldValue(9, 0, arg1, 65535);
            return;
        }

        public function getEventGroup():int
        {
            return getFieldIntegerValue(10, 0, 65535);
        }

        public function setEventGroup(arg1:int):void
        {
            setFieldValue(10, 0, arg1, 65535);
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

        public function getLengthType():com.garmin.fit.LengthType
        {
            var loc1:*=getFieldIntegerValue(12, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.LengthType.getByValue(loc1);
        }

        public function setLengthType(arg1:com.garmin.fit.LengthType):void
        {
            setFieldValue(12, 0, arg1.getValue(), 65535);
            return;
        }

        public static function get lengthMesg():com.garmin.fit.Mesg
        {
            return _lengthMesg;
        }

        
        {
            _lengthMesg = new com.garmin.fit.Mesg("length", 101);
            lengthMesg.addField(new com.garmin.fit.Field("message_index", 254, 132, 1, 0, ""));
            lengthMesg.addField(new com.garmin.fit.Field("timestamp", 253, 134, 1, 0, ""));
            lengthMesg.addField(new com.garmin.fit.Field("event", 0, 0, 1, 0, ""));
            lengthMesg.addField(new com.garmin.fit.Field("event_type", 1, 0, 1, 0, ""));
            lengthMesg.addField(new com.garmin.fit.Field("start_time", 2, 134, 1, 0, ""));
            lengthMesg.addField(new com.garmin.fit.Field("total_elapsed_time", 3, 134, 1000, 0, "s"));
            lengthMesg.addField(new com.garmin.fit.Field("total_timer_time", 4, 134, 1000, 0, "s"));
            lengthMesg.addField(new com.garmin.fit.Field("total_strokes", 5, 132, 1, 0, "strokes"));
            lengthMesg.addField(new com.garmin.fit.Field("avg_speed", 6, 132, 1000, 0, "m/s"));
            lengthMesg.addField(new com.garmin.fit.Field("swim_stroke", 7, 0, 1, 0, "swim_stroke"));
            lengthMesg.addField(new com.garmin.fit.Field("avg_swimming_cadence", 9, 2, 1, 0, "strokes/min"));
            lengthMesg.addField(new com.garmin.fit.Field("event_group", 10, 2, 1, 0, ""));
            lengthMesg.addField(new com.garmin.fit.Field("total_calories", 11, 132, 1, 0, "kcal"));
            lengthMesg.addField(new com.garmin.fit.Field("length_type", 12, 0, 1, 0, ""));
        }

        internal static var _lengthMesg:com.garmin.fit.Mesg;
    }
}


