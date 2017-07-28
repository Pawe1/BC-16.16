//class CourseMesg
package com.garmin.fit 
{
    public class CourseMesg extends com.garmin.fit.Mesg
    {
        public function CourseMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(31));
            return;
        }

        public function getSport():com.garmin.fit.Sport
        {
            var loc1:*=getFieldIntegerValue(4, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.Sport.getByValue(loc1);
        }

        public function setSport(arg1:com.garmin.fit.Sport):void
        {
            setFieldValue(4, 0, arg1.getValue(), 65535);
            return;
        }

        public override function getName():String
        {
            return getFieldStringValue(5, 0, 65535);
        }

        public function setName(arg1:String):void
        {
            setFieldValue(5, 0, arg1, 65535);
            return;
        }

        public function getCapabilities():Number
        {
            return getFieldDoubleValue(6, 0, 65535);
        }

        public function setCapabilities(arg1:Number):void
        {
            setFieldValue(6, 0, arg1, 65535);
            return;
        }

        public static function get courseMesg():com.garmin.fit.Mesg
        {
            return _courseMesg;
        }

        
        {
            _courseMesg = new com.garmin.fit.Mesg("course", 31);
            courseMesg.addField(new com.garmin.fit.Field("sport", 4, 0, 1, 0, ""));
            courseMesg.addField(new com.garmin.fit.Field("name", 5, 7, 1, 0, ""));
            courseMesg.addField(new com.garmin.fit.Field("capabilities", 6, 140, 1, 0, ""));
        }

        internal static var _courseMesg:com.garmin.fit.Mesg;
    }
}


