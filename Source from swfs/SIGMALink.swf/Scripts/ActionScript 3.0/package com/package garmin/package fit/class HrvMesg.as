//class HrvMesg
package com.garmin.fit 
{
    public class HrvMesg extends com.garmin.fit.Mesg
    {
        public function HrvMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(78));
            return;
        }

        public function getNumTime():int
        {
            return getNumFieldValues(0, 65535);
        }

        public function getTime(arg1:int):Number
        {
            return getFieldDoubleValue(0, arg1, 65535);
        }

        public function setTime(arg1:int, arg2:Number):void
        {
            setFieldValue(0, arg1, arg2, 65535);
            return;
        }

        public static function get hrvMesg():com.garmin.fit.Mesg
        {
            return _hrvMesg;
        }

        
        {
            _hrvMesg = new com.garmin.fit.Mesg("hrv", 78);
            hrvMesg.addField(new com.garmin.fit.Field("time", 0, 132, 1000, 0, "s"));
        }

        internal static var _hrvMesg:com.garmin.fit.Mesg;
    }
}


