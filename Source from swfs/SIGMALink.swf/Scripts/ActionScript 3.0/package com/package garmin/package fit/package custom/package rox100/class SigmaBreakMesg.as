//class SigmaBreakMesg
package com.garmin.fit.custom.rox100 
{
    import com.garmin.fit.*;
    
    public class SigmaBreakMesg extends com.garmin.fit.custom.rox100.SigmaMarkerROX100Mesg
    {
        public function SigmaBreakMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(65283));
            return;
        }

        public function getMarkerDuration():Number
        {
            return getFieldDoubleValue(1, 0, 65535);
        }

        public function setMarkerDuration(arg1:Number):void
        {
            setFieldValue(1, 0, arg1, 65535);
            return;
        }

        public function getMarkerAltitudeDownhill():int
        {
            return getFieldDoubleValue(21, 0, 65535);
        }

        public function setMarkerAltitudeDownhill(arg1:int):void
        {
            setFieldValue(21, 0, arg1, 65535);
            return;
        }

        public function getMarkerAltitudeUphill():int
        {
            return getFieldDoubleValue(22, 0, 65535);
        }

        public function setMarkerAltitudeUphill(arg1:int):void
        {
            setFieldValue(22, 0, arg1, 65535);
            return;
        }

        public function getMarkerAverageAltitude():Number
        {
            return getFieldDoubleValue(40, 0, 65535);
        }

        public function setMarkerAverageAltitude(arg1:Number):void
        {
            setFieldValue(40, 0, arg1, 65535);
            return;
        }

        public function getMarkerMaximumAltitude():Number
        {
            return getFieldDoubleValue(41, 0, 65535);
        }

        public function setMarkerMaximumAltitude(arg1:Number):void
        {
            setFieldValue(41, 0, arg1, 65535);
            return;
        }

        public function getMarkerAverageCadence():int
        {
            return getFieldIntegerValue(50, 0, 65535);
        }

        public function setMarkerAverageCadence(arg1:int):void
        {
            setFieldValue(50, 0, arg1, 65535);
            return;
        }

        public function getMarkerMaximumCadence():int
        {
            return getFieldIntegerValue(51, 0, 65535);
        }

        public function setMarkerMaximumCadence(arg1:int):void
        {
            setFieldValue(51, 0, arg1, 65535);
            return;
        }

        public function getMarkerMinimumHeartrate():int
        {
            return getFieldIntegerValue(60, 0, 65535);
        }

        public function setMarkerMinimumHeartrate(arg1:int):void
        {
            setFieldValue(60, 0, arg1, 65535);
            return;
        }

        public function getMarkerAverageHeartrate():int
        {
            return getFieldIntegerValue(61, 0, 65535);
        }

        public function setMarkerAverageHeartrate(arg1:int):void
        {
            setFieldValue(61, 0, arg1, 65535);
            return;
        }

        public function getMarkerMaximumHeartrate():int
        {
            return getFieldIntegerValue(62, 0, 65535);
        }

        public function setMarkerMaximumHeartrate(arg1:int):void
        {
            setFieldValue(62, 0, arg1, 65535);
            return;
        }

        public function getMarkerAverageSpeed():Number
        {
            return getFieldDoubleValue(70, 0, 65535);
        }

        public function setMarkerAverageSpeed(arg1:Number):void
        {
            setFieldValue(70, 0, arg1, 65535);
            return;
        }

        public function getMarkerMaximumSpeed():Number
        {
            return getFieldDoubleValue(71, 0, 65535);
        }

        public function setMarkerMaximumSpeed(arg1:Number):void
        {
            setFieldValue(71, 0, arg1, 65535);
            return;
        }

        public function getMarkerAverageInclineUphill():Number
        {
            return getFieldDoubleValue(80, 0, 65535);
        }

        public function setMarkerAverageInclineUphill(arg1:Number):void
        {
            setFieldValue(80, 0, arg1, 65535);
            return;
        }

        public function getMarkerMaximumInclineUphill():Number
        {
            return getFieldDoubleValue(81, 0, 65535);
        }

        public function setMarkerMaximumInclineUphill(arg1:Number):void
        {
            setFieldValue(81, 0, arg1, 65535);
            return;
        }

        public function getMarkerAverageInclineDownhill():Number
        {
            return getFieldDoubleValue(82, 0, 65535);
        }

        public function setMarkerAverageInclineDownhill(arg1:Number):void
        {
            setFieldValue(82, 0, arg1, 65535);
            return;
        }

        public function getMarkerMaximumInclineDownhill():Number
        {
            return getFieldDoubleValue(83, 0, 65535);
        }

        public function setMarkerMaximumInclineDownhill(arg1:Number):void
        {
            setFieldValue(83, 0, arg1, 65535);
            return;
        }

        public function getMarkerAveragePower():int
        {
            return getFieldIntegerValue(90, 0, 65535);
        }

        public function setMarkerAveragePower(arg1:int):void
        {
            setFieldValue(90, 0, arg1, 65535);
            return;
        }

        public function getMarkerMaximumPower():int
        {
            return getFieldIntegerValue(91, 0, 65535);
        }

        public function setMarkerMaximumPower(arg1:int):void
        {
            setFieldValue(91, 0, arg1, 65535);
            return;
        }

        public function getMarkerCalories():int
        {
            return getFieldIntegerValue(100, 0, 65535);
        }

        public function setMarkerCalories(arg1:int):void
        {
            setFieldValue(100, 0, arg1, 65535);
            return;
        }

        public function getMarkerLatitude():int
        {
            return getFieldIntegerValue(110, 0, 65535);
        }

        public function setMarkerLatitude(arg1:int):void
        {
            setFieldValue(110, 0, arg1, 65535);
            return;
        }

        public function getMarkerLongitude():int
        {
            return getFieldIntegerValue(111, 0, 65535);
        }

        public function setMarkerLongitude(arg1:int):void
        {
            setFieldValue(111, 0, arg1, 65535);
            return;
        }

        public function getMarkerDistance():Number
        {
            return getFieldDoubleValue(120, 0, 65535);
        }

        public function setMarkerDistance(arg1:Number):void
        {
            setFieldValue(120, 0, arg1, 65535);
            return;
        }

        public static function get markerROX100MBreakMesg():com.garmin.fit.Mesg
        {
            return _markerROX100Mesg;
        }

        
        {
            _markerROX100Mesg = new com.garmin.fit.Mesg("sigmaBreak", 65283);
            _markerROX100Mesg.addField(createDescription());
            _markerROX100Mesg.addField(createMarkerTime());
            _markerROX100Mesg.addField(createTitle());
            _markerROX100Mesg.addField(new com.garmin.fit.Field("duration", 1, 134, 1, 0, "s"));
            _markerROX100Mesg.addField(createMarkerDistanceAbsolute());
            _markerROX100Mesg.addField(createMarkerDistanceDownhill());
            _markerROX100Mesg.addField(createMarkerDistanceUphill());
            _markerROX100Mesg.addField(createMarkerTimeAbsolute());
            _markerROX100Mesg.addField(new com.garmin.fit.Field("altitudeDownhill", 21, 134, 1, 0, "mm"));
            _markerROX100Mesg.addField(new com.garmin.fit.Field("altitudeUphill", 22, 134, 1, 0, "mm"));
            _markerROX100Mesg.addField(createMarkerMinimumSpeed());
            _markerROX100Mesg.addField(createMarkerTimeDownhill());
            _markerROX100Mesg.addField(createMarkerTimeUphill());
            _markerROX100Mesg.addField(new com.garmin.fit.Field("averageAltitude", 40, 133, 1, 0, "mm"));
            _markerROX100Mesg.addField(new com.garmin.fit.Field("maximumAltitude", 41, 133, 1, 0, "mm"));
            _markerROX100Mesg.addField(new com.garmin.fit.Field("averageCadence", 50, 132, 1000, 0, "rpm"));
            _markerROX100Mesg.addField(new com.garmin.fit.Field("maximumCadence", 51, 2, 1, 0, "rpm"));
            _markerROX100Mesg.addField(new com.garmin.fit.Field("minimumHeartrate", 60, 2, 1, 0, "bpm"));
            _markerROX100Mesg.addField(new com.garmin.fit.Field("averageHeartrate", 61, 2, 1, 0, "bpm"));
            _markerROX100Mesg.addField(new com.garmin.fit.Field("maximumHeartrate", 62, 2, 1, 0, "bpm"));
            _markerROX100Mesg.addField(new com.garmin.fit.Field("averageSpeed", 70, 132, 1000, 0, "m/s"));
            _markerROX100Mesg.addField(new com.garmin.fit.Field("maximumSpeed", 71, 132, 1000, 0, "m/s"));
            _markerROX100Mesg.addField(new com.garmin.fit.Field("averageInclineUphill", 80, 134, 10000, 1, "%"));
            _markerROX100Mesg.addField(new com.garmin.fit.Field("maximumInclineUphill", 81, 132, 100, 0, "%"));
            _markerROX100Mesg.addField(new com.garmin.fit.Field("averageInclineDownhill", 82, 134, 10000, 0, "%"));
            _markerROX100Mesg.addField(new com.garmin.fit.Field("maximumInclineDownhill", 83, 131, 100, 0, "%"));
            _markerROX100Mesg.addField(new com.garmin.fit.Field("averagePower", 90, 132, 1, 0, "watts"));
            _markerROX100Mesg.addField(new com.garmin.fit.Field("maximumPower", 91, 132, 1, 0, "watts"));
            _markerROX100Mesg.addField(new com.garmin.fit.Field("calories", 100, 132, 1, 0, "kcal"));
            _markerROX100Mesg.addField(new com.garmin.fit.Field("latitude", 110, 133, 1, 0, "semicircles"));
            _markerROX100Mesg.addField(new com.garmin.fit.Field("longitude", 111, 133, 1, 0, "semicircles"));
            _markerROX100Mesg.addField(new com.garmin.fit.Field("distance", 120, 134, 100, 1, "m"));
        }

        internal static var _markerROX100Mesg:com.garmin.fit.Mesg;
    }
}


