//class CapabilitiesMesg
package com.garmin.fit 
{
    public class CapabilitiesMesg extends com.garmin.fit.Mesg
    {
        public function CapabilitiesMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(1));
            return;
        }

        public function getNumLanguages():int
        {
            return getNumFieldValues(0, 65535);
        }

        public function getLanguages(arg1:int):int
        {
            return getFieldIntegerValue(0, arg1, 65535);
        }

        public function setLanguages(arg1:int, arg2:int):void
        {
            setFieldValue(0, arg1, arg2, 65535);
            return;
        }

        public function getNumSports():int
        {
            return getNumFieldValues(1, 65535);
        }

        public function getSports(arg1:int):int
        {
            return getFieldIntegerValue(1, arg1, 65535);
        }

        public function setSports(arg1:int, arg2:int):void
        {
            setFieldValue(1, arg1, arg2, 65535);
            return;
        }

        public function getWorkoutsSupported():Number
        {
            return getFieldDoubleValue(21, 0, 65535);
        }

        public function setWorkoutsSupported(arg1:Number):void
        {
            setFieldValue(21, 0, arg1, 65535);
            return;
        }

        public static function get capabilitiesMesg():com.garmin.fit.Mesg
        {
            return _capabilitiesMesg;
        }

        
        {
            _capabilitiesMesg = new com.garmin.fit.Mesg("capabilities", 1);
            capabilitiesMesg.addField(new com.garmin.fit.Field("languages", 0, 10, 1, 0, ""));
            capabilitiesMesg.addField(new com.garmin.fit.Field("sports", 1, 10, 1, 0, ""));
            capabilitiesMesg.addField(new com.garmin.fit.Field("workouts_supported", 21, 140, 1, 0, ""));
        }

        protected static var _capabilitiesMesg:com.garmin.fit.Mesg;
    }
}


