//class HrmProfileMesg
package com.garmin.fit 
{
    public class HrmProfileMesg extends com.garmin.fit.Mesg
    {
        public function HrmProfileMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(4));
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
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.FITBool.getByValue(loc1);
        }

        public function setEnabled(arg1:com.garmin.fit.FITBool):void
        {
            setFieldValue(0, 0, arg1.getValue(), 65535);
            return;
        }

        public function getHrmAntId():int
        {
            return getFieldIntegerValue(1, 0, 65535);
        }

        public function setHrmAntId(arg1:int):void
        {
            setFieldValue(1, 0, arg1, 65535);
            return;
        }

        public function getLogHrv():com.garmin.fit.FITBool
        {
            var loc1:*=getFieldIntegerValue(2, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.FITBool.getByValue(loc1);
        }

        public function setLogHrv(arg1:com.garmin.fit.FITBool):void
        {
            setFieldValue(2, 0, arg1.getValue(), 65535);
            return;
        }

        public function getHrmAntIdTransType():int
        {
            return getFieldIntegerValue(3, 0, 65535);
        }

        public function setHrmAntIdTransType(arg1:int):void
        {
            setFieldValue(3, 0, arg1, 65535);
            return;
        }

        public static function get hrmProfileMesg():com.garmin.fit.Mesg
        {
            return _hrmProfileMesg;
        }

        
        {
            _hrmProfileMesg = new com.garmin.fit.Mesg("hrm_profile", 4);
            hrmProfileMesg.addField(new com.garmin.fit.Field("message_index", 254, 132, 1, 0, ""));
            hrmProfileMesg.addField(new com.garmin.fit.Field("enabled", 0, 0, 1, 0, ""));
            hrmProfileMesg.addField(new com.garmin.fit.Field("hrm_ant_id", 1, 139, 1, 0, ""));
            hrmProfileMesg.addField(new com.garmin.fit.Field("log_hrv", 2, 0, 1, 0, ""));
            hrmProfileMesg.addField(new com.garmin.fit.Field("hrm_ant_id_trans_type", 3, 10, 1, 0, ""));
        }

        internal static var _hrmProfileMesg:com.garmin.fit.Mesg;
    }
}


