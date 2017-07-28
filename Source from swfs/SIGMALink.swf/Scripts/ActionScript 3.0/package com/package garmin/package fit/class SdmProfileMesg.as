//class SdmProfileMesg
package com.garmin.fit 
{
    public class SdmProfileMesg extends com.garmin.fit.Mesg
    {
        public function SdmProfileMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(5));
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

        public function getEnabled():com.garmin.fit.FITBool
        {
            var loc1:*=getFieldIntegerValue(0, 0, 65535);
            if (!loc1) 
            {
                return null;
            }
            return com.garmin.fit.FITBool.getByValue(loc1);
        }

        public function setEnabled(arg1:Boolean):void
        {
            setFieldValue(0, 0, arg1, 65535);
            return;
        }

        public function getSdmAntId():int
        {
            return getFieldIntegerValue(1, 0, 65535);
        }

        public function setSdmAntId(arg1:int):void
        {
            setFieldValue(1, 0, arg1, 65535);
            return;
        }

        public function getSdmCalFactor():Number
        {
            return getFieldDoubleValue(2, 0, 65535);
        }

        public function setSdmCalFactor(arg1:Number):void
        {
            setFieldValue(2, 0, arg1, 65535);
            return;
        }

        public function getOdometer():Number
        {
            return getFieldDoubleValue(3, 0, 65535);
        }

        public function setOdometer(arg1:Number):void
        {
            setFieldValue(3, 0, arg1, 65535);
            return;
        }

        public function getSpeedSource():com.garmin.fit.FITBool
        {
            var loc1:*=getFieldIntegerValue(4, 0, 65535);
            if (!loc1) 
            {
                return null;
            }
            return com.garmin.fit.FITBool.getByValue(loc1);
        }

        public function setSpeedSource(arg1:Boolean):void
        {
            setFieldValue(4, 0, arg1, 65535);
            return;
        }

        public function getSdmAntIdTransType():int
        {
            return getFieldIntegerValue(5, 0, 65535);
        }

        public function setSdmAntIdTransType(arg1:int):void
        {
            setFieldValue(5, 0, arg1, 65535);
            return;
        }

        public static function get sdmProfileMesg():com.garmin.fit.Mesg
        {
            return _sdmProfileMesg;
        }

        
        {
            _sdmProfileMesg = new com.garmin.fit.Mesg("sdm_profile", 5);
            sdmProfileMesg.addField(new com.garmin.fit.Field("message_index", 254, 132, 1, 0, ""));
            sdmProfileMesg.addField(new com.garmin.fit.Field("enabled", 0, 0, 1, 0, ""));
            sdmProfileMesg.addField(new com.garmin.fit.Field("sdm_ant_id", 1, 139, 1, 0, ""));
            sdmProfileMesg.addField(new com.garmin.fit.Field("sdm_cal_factor", 2, 132, 10, 0, "%"));
            sdmProfileMesg.addField(new com.garmin.fit.Field("odometer", 3, 134, 100, 0, "m"));
            sdmProfileMesg.addField(new com.garmin.fit.Field("speed_source", 4, 0, 1, 0, ""));
            sdmProfileMesg.addField(new com.garmin.fit.Field("sdm_ant_id_trans_type", 5, 10, 1, 0, ""));
        }

        internal static var _sdmProfileMesg:com.garmin.fit.Mesg;
    }
}


