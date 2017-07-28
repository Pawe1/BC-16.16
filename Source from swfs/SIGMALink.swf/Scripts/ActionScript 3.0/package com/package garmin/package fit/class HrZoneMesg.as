//class HrZoneMesg
package com.garmin.fit 
{
    public class HrZoneMesg extends com.garmin.fit.Mesg
    {
        public function HrZoneMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(8));
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

        public override function getName():String
        {
            return getFieldStringValue(2, 0, 65535);
        }

        public function setName(arg1:String):void
        {
            setFieldValue(2, 0, arg1, 65535);
            return;
        }

        public static function get hrZoneMesg():com.garmin.fit.Mesg
        {
            return _hrZoneMesg;
        }

        
        {
            _hrZoneMesg = new com.garmin.fit.Mesg("hr_zone", 8);
            hrZoneMesg.addField(new com.garmin.fit.Field("message_index", 254, 132, 1, 0, ""));
            hrZoneMesg.addField(new com.garmin.fit.Field("high_bpm", 1, 2, 1, 0, "bpm"));
            hrZoneMesg.addField(new com.garmin.fit.Field("name", 2, 7, 1, 0, ""));
        }

        internal static var _hrZoneMesg:com.garmin.fit.Mesg;
    }
}


