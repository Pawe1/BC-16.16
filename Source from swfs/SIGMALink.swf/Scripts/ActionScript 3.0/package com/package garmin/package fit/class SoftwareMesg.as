//class SoftwareMesg
package com.garmin.fit 
{
    public class SoftwareMesg extends com.garmin.fit.Mesg
    {
        public function SoftwareMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(35));
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

        public function getVersion():Number
        {
            return getFieldDoubleValue(3, 0, 65535);
        }

        public function setVersion(arg1:Number):void
        {
            setFieldValue(3, 0, arg1, 65535);
            return;
        }

        public function getPartNumber():String
        {
            return getFieldStringValue(5, 0, 65535);
        }

        public function setPartNumber(arg1:String):void
        {
            setFieldValue(5, 0, arg1, 65535);
            return;
        }

        public static function get softwareMesg():com.garmin.fit.Mesg
        {
            return _softwareMesg;
        }

        
        {
            _softwareMesg = new com.garmin.fit.Mesg("software", 35);
            softwareMesg.addField(new com.garmin.fit.Field("message_index", 254, 132, 1, 0, ""));
            softwareMesg.addField(new com.garmin.fit.Field("version", 3, 132, 100, 0, ""));
            softwareMesg.addField(new com.garmin.fit.Field("part_number", 5, 7, 1, 0, ""));
        }

        internal static var _softwareMesg:com.garmin.fit.Mesg;
    }
}


