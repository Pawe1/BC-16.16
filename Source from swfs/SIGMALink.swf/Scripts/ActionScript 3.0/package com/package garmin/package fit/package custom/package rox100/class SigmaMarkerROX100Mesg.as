//class SigmaMarkerROX100Mesg
package com.garmin.fit.custom.rox100 
{
    import com.garmin.fit.*;
    
    public class SigmaMarkerROX100Mesg extends com.garmin.fit.Mesg
    {
        public function SigmaMarkerROX100Mesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1);
            return;
        }

        public function getMarkerTimeAbsolute():Number
        {
            return getFieldDoubleValue(20, 0, 65535);
        }

        public function setMarkerTimeAbsolute(arg1:Number):void
        {
            setFieldValue(20, 0, arg1, 65535);
            return;
        }

        public function getMarkerMinimumSpeed():Number
        {
            return getFieldDoubleValue(23, 0, 65535);
        }

        public function setMarkerMinimumSpeed(arg1:Number):void
        {
            setFieldValue(23, 0, arg1, 65535);
            return;
        }

        public function getMarkerTimeDownhill():Number
        {
            return getFieldDoubleValue(24, 0, 65535);
        }

        public function setMarkerTimeDownhill(arg1:Number):void
        {
            setFieldValue(24, 0, arg1, 65535);
            return;
        }

        public function getMarkerTimeUphill():int
        {
            return getFieldDoubleValue(25, 0, 65535);
        }

        public function setMarkerTimeUphill(arg1:int):void
        {
            setFieldValue(25, 0, arg1, 65535);
            return;
        }

        public function getMarkerDistanceAbsolute():Number
        {
            return getFieldDoubleValue(10, 0, 65535);
        }

        public function setMarkerDistanceAbsolute(arg1:Number):void
        {
            setFieldValue(10, 0, arg1, 65535);
            return;
        }

        public function getMarkerDistanceDownhill():Number
        {
            return getFieldDoubleValue(11, 0, 65535);
        }

        public function setMarkerDistanceDownhill(arg1:Number):void
        {
            setFieldValue(11, 0, arg1, 65535);
            return;
        }

        public function getMarkerDistanceUphill():Number
        {
            return getFieldDoubleValue(12, 0, 65535);
        }

        public function setMarkerDistanceUphill(arg1:Number):void
        {
            setFieldValue(12, 0, arg1, 65535);
            return;
        }

        public function getDescription():String
        {
            return getFieldStringValue(0, 0, 65535);
        }

        public function setDescription(arg1:String):void
        {
            setFieldValue(0, 0, arg1, 65535);
            return;
        }

        public function getMarkerTime():int
        {
            return getFieldDoubleValue(2, 0, 65535);
        }

        public function setMarkerTime(arg1:int):void
        {
            setFieldValue(2, 0, arg1, 65535);
            return;
        }

        public function getTitle():String
        {
            return getFieldStringValue(3, 0, 65535);
        }

        public function setTitle(arg1:String):void
        {
            setFieldValue(3, 0, arg1, 65535);
            return;
        }

        protected static function createDescription():com.garmin.fit.Field
        {
            return new com.garmin.fit.Field("description", 0, 7, 1, 0, "");
        }

        protected static function createMarkerTime():com.garmin.fit.Field
        {
            return new com.garmin.fit.Field("markerTime", 2, 134, 100, 0, "s");
        }

        protected static function createTitle():com.garmin.fit.Field
        {
            return new com.garmin.fit.Field("title", 3, 7, 1, 0, "");
        }

        protected static function createMarkerDistanceAbsolute():com.garmin.fit.Field
        {
            return new com.garmin.fit.Field("distanceAbsolute", 10, 134, 100, 0, "m");
        }

        protected static function createMarkerDistanceDownhill():com.garmin.fit.Field
        {
            return new com.garmin.fit.Field("distanceDownhill", 11, 7, 1, 0, "");
        }

        protected static function createMarkerDistanceUphill():com.garmin.fit.Field
        {
            return new com.garmin.fit.Field("distanceUphill", 12, 7, 1, 0, "");
        }

        protected static function createMarkerTimeAbsolute():com.garmin.fit.Field
        {
            return new com.garmin.fit.Field("timeAbsolute", 20, 134, 100, 0, "s");
        }

        protected static function createMarkerMinimumSpeed():com.garmin.fit.Field
        {
            return new com.garmin.fit.Field("minimumSpeed", 23, 131, 1000, 0, "m/s");
        }

        protected static function createMarkerTimeDownhill():com.garmin.fit.Field
        {
            return new com.garmin.fit.Field("timeDownhill", 24, 134, 1, 0, "s");
        }

        protected static function createMarkerTimeUphill():com.garmin.fit.Field
        {
            return new com.garmin.fit.Field("timeUphill", 25, 134, 1, 0, "s");
        }
    }
}


