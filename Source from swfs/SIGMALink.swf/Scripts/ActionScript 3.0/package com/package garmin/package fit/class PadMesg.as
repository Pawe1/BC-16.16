//class PadMesg
package com.garmin.fit 
{
    public class PadMesg extends com.garmin.fit.Mesg
    {
        public function PadMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(105));
            return;
        }

        public static function get padMesg():com.garmin.fit.Mesg
        {
            return _padMesg;
        }

        
        {
            _padMesg = new com.garmin.fit.Mesg("pad", 105);
        }

        internal static var _padMesg:com.garmin.fit.Mesg;
    }
}


