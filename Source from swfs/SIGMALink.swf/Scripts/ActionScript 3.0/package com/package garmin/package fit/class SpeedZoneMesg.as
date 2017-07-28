//class SpeedZoneMesg
package com.garmin.fit 
{
    public class SpeedZoneMesg extends com.garmin.fit.Mesg
    {
        public function SpeedZoneMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(53));
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

        public function getHighValue():Number
        {
            return getFieldDoubleValue(0, 0, 65535);
        }

        public function setHighValue(arg1:Number):void
        {
            setFieldValue(0, 0, arg1, 65535);
            return;
        }

        public override function getName():String
        {
            return getFieldStringValue(1, 0, 65535);
        }

        public function setName(arg1:String):void
        {
            setFieldValue(1, 0, arg1, 65535);
            return;
        }

        public static function get speedZoneMesg():com.garmin.fit.Mesg
        {
            return _speedZoneMesg;
        }

        
        {
            _speedZoneMesg = new com.garmin.fit.Mesg("speed_zone", 53);
            speedZoneMesg.addField(new com.garmin.fit.Field("message_index", 254, 132, 1, 0, ""));
            speedZoneMesg.addField(new com.garmin.fit.Field("high_value", 0, 132, 1000, 0, "m/s"));
            speedZoneMesg.addField(new com.garmin.fit.Field("name", 1, 7, 1, 0, ""));
        }

        internal static var _speedZoneMesg:com.garmin.fit.Mesg;
    }
}


