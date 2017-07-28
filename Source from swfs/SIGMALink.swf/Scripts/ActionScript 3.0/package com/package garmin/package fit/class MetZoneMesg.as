//class MetZoneMesg
package com.garmin.fit 
{
    public class MetZoneMesg extends com.garmin.fit.Mesg
    {
        public function MetZoneMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(10));
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

        public function getHighBpm():int
        {
            return getFieldIntegerValue(1, 0, 65535);
        }

        public function setHighBpm(arg1:int):void
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

        public function getFatCalories():Number
        {
            return getFieldDoubleValue(3, 0, 65535);
        }

        public function setFatCalories(arg1:Number):void
        {
            setFieldValue(3, 0, arg1, 65535);
            return;
        }

        public static function get metZoneMesg():com.garmin.fit.Mesg
        {
            return _metZoneMesg;
        }

        
        {
            _metZoneMesg = new com.garmin.fit.Mesg("met_zone", 10);
            metZoneMesg.addField(new com.garmin.fit.Field("message_index", 254, 132, 1, 0, ""));
            metZoneMesg.addField(new com.garmin.fit.Field("high_bpm", 1, 2, 1, 0, ""));
            metZoneMesg.addField(new com.garmin.fit.Field("calories", 2, 132, 10, 0, "kcal / min"));
            metZoneMesg.addField(new com.garmin.fit.Field("fat_calories", 3, 2, 10, 0, "kcal / min"));
        }

        internal static var _metZoneMesg:com.garmin.fit.Mesg;
    }
}


