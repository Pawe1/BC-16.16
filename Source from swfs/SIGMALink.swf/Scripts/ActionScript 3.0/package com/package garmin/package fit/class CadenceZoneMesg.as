//class CadenceZoneMesg
package com.garmin.fit 
{
    public class CadenceZoneMesg extends com.garmin.fit.Mesg
    {
        public function CadenceZoneMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(131));
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
            return getFieldIntegerValue(0, 0, 65535);
        }

        public function setHighValue(arg1:int):void
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

        public static function get cadenceZoneMesg():com.garmin.fit.Mesg
        {
            return _cadenceZoneMesg;
        }

        
        {
            _cadenceZoneMesg = new com.garmin.fit.Mesg("cadence_zone", 131);
            cadenceZoneMesg.addField(new com.garmin.fit.Field("message_index", 254, 132, 1, 0, ""));
            cadenceZoneMesg.addField(new com.garmin.fit.Field("high_value", 0, 2, 1, 0, "rpm"));
            cadenceZoneMesg.addField(new com.garmin.fit.Field("name", 1, 7, 1, 0, ""));
        }

        internal static var _cadenceZoneMesg:com.garmin.fit.Mesg;
    }
}


