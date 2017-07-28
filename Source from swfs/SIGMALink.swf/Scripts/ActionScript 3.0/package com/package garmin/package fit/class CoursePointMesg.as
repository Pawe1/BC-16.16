//class CoursePointMesg
package com.garmin.fit 
{
    public class CoursePointMesg extends com.garmin.fit.Mesg
    {
        public function CoursePointMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(32));
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
            return timestampToDateTime(getFieldDoubleValue(1, 0, 65535));
        }

        public function setTimestamp(arg1:com.garmin.fit.DateTime):void
        {
            setFieldValue(1, 0, arg1.getTimestamp(), 65535);
            return;
        }

        public function getPositionLat():int
        {
            return getFieldIntegerValue(2, 0, 65535);
        }

        public function setPositionLat(arg1:int):void
        {
            setFieldValue(2, 0, arg1, 65535);
            return;
        }

        public function getPositionLong():int
        {
            return getFieldIntegerValue(3, 0, 65535);
        }

        public function setPositionLong(arg1:int):void
        {
            setFieldValue(3, 0, arg1, 65535);
            return;
        }

        public function getDistance():Number
        {
            return getFieldDoubleValue(4, 0, 65535);
        }

        public function setDistance(arg1:Number):void
        {
            setFieldValue(4, 0, arg1, 65535);
            return;
        }

        public function getType():com.garmin.fit.CoursePoint
        {
            var loc1:*=getFieldIntegerValue(5, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.CoursePoint.getByValue(loc1);
        }

        public function setType(arg1:com.garmin.fit.CoursePoint):void
        {
            setFieldValue(5, 0, arg1.getValue(), 65535);
            return;
        }

        public override function getName():String
        {
            return getFieldStringValue(6, 0, 65535);
        }

        public function setName(arg1:String):void
        {
            setFieldValue(6, 0, arg1, 65535);
            return;
        }

        public static function get coursePointMesg():com.garmin.fit.Mesg
        {
            return _coursePointMesg;
        }

        
        {
            _coursePointMesg = new com.garmin.fit.Mesg("course_point", 32);
            coursePointMesg.addField(new com.garmin.fit.Field("message_index", 254, 132, 1, 0, ""));
            coursePointMesg.addField(new com.garmin.fit.Field("timestamp", 1, 134, 1, 0, ""));
            coursePointMesg.addField(new com.garmin.fit.Field("position_lat", 2, 133, 1, 0, "semicircles"));
            coursePointMesg.addField(new com.garmin.fit.Field("position_long", 3, 133, 1, 0, "semicircles"));
            coursePointMesg.addField(new com.garmin.fit.Field("distance", 4, 134, 100, 0, "m"));
            coursePointMesg.addField(new com.garmin.fit.Field("type", 5, 0, 1, 0, ""));
            coursePointMesg.addField(new com.garmin.fit.Field("name", 6, 7, 1, 0, ""));
        }

        internal static var _coursePointMesg:com.garmin.fit.Mesg;
    }
}


