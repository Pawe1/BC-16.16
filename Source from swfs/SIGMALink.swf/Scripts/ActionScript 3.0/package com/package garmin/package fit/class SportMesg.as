//class SportMesg
package com.garmin.fit 
{
    public class SportMesg extends com.garmin.fit.Mesg
    {
        public function SportMesg(arg1:com.garmin.fit.Mesg=null)
        {
            if (arg1 == null) 
            {
                arg1 = com.garmin.fit.Factory.createMesg(12);
            }
            super(arg1);
            return;
        }

        public function getSport():com.garmin.fit.Sport
        {
            var loc1:*=getFieldIntegerValue(0, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.Sport.getByValue(loc1);
        }

        public function setSport(arg1:com.garmin.fit.Sport):void
        {
            setFieldValue(0, 0, arg1.getValue(), 65535);
            return;
        }

        public function getSubSport():com.garmin.fit.SubSport
        {
            var loc1:*=getFieldIntegerValue(1, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.SubSport.getByValue(loc1);
        }

        public function setSubSport(arg1:com.garmin.fit.SubSport):void
        {
            setFieldValue(1, 0, arg1.getValue(), 65535);
            return;
        }

        public override function getName():String
        {
            return getFieldStringValue(3, 0, 65535);
        }

        public function setName(arg1:String):void
        {
            setFieldValue(3, 0, arg1, 65535);
            return;
        }

        public static function get sportMesg():com.garmin.fit.Mesg
        {
            return _sportMesg;
        }

        
        {
            _sportMesg = new com.garmin.fit.Mesg("sport", 12);
            sportMesg.addField(new com.garmin.fit.Field("sport", 0, 0, 1, 0, ""));
            sportMesg.addField(new com.garmin.fit.Field("sub_sport", 1, 0, 1, 0, ""));
            sportMesg.addField(new com.garmin.fit.Field("name", 3, 7, 1, 0, ""));
        }

        internal static var _sportMesg:com.garmin.fit.Mesg;
    }
}


