//class PowerZoneMesg
package com.garmin.fit 
{
    public class PowerZoneMesg extends com.garmin.fit.Mesg
    {
        public function PowerZoneMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(9));
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

        public function getHighValue():int
        {
            return getFieldIntegerValue(1, 0, 65535);
        }

        public function setHighValue(arg1:int):void
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

        public static function get powerZoneMesg():com.garmin.fit.Mesg
        {
            return _powerZoneMesg;
        }

        
        {
            _powerZoneMesg = new com.garmin.fit.Mesg("power_zone", 9);
            powerZoneMesg.addField(new com.garmin.fit.Field("message_index", 254, 132, 1, 0, ""));
            powerZoneMesg.addField(new com.garmin.fit.Field("high_value", 1, 132, 1, 0, "watts"));
            powerZoneMesg.addField(new com.garmin.fit.Field("name", 2, 7, 1, 0, ""));
        }

        internal static var _powerZoneMesg:com.garmin.fit.Mesg;
    }
}


