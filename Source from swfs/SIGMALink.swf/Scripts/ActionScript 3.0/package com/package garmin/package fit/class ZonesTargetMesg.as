//class ZonesTargetMesg
package com.garmin.fit 
{
    public class ZonesTargetMesg extends com.garmin.fit.Mesg
    {
        public function ZonesTargetMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(7));
            return;
        }

        public function getMaxHeartRate():int
        {
            return getFieldIntegerValue(1, 0, 65535);
        }

        public function setMaxHeartRate(arg1:int):void
        {
            setFieldValue(1, 0, arg1, 65535);
            return;
        }

        public function getThresholdHeartRate():int
        {
            return getFieldIntegerValue(2, 0, 65535);
        }

        public function setThresholdHeartRate(arg1:int):void
        {
            setFieldValue(2, 0, arg1, 65535);
            return;
        }

        public function getFunctionalThresholdPower():int
        {
            return getFieldIntegerValue(3, 0, 65535);
        }

        public function setFunctionalThresholdPower(arg1:int):void
        {
            setFieldValue(3, 0, arg1, 65535);
            return;
        }

        public function getHrCalcType():com.garmin.fit.HrZoneCalc
        {
            var loc1:*=getFieldIntegerValue(5, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.HrZoneCalc.getByValue(loc1);
        }

        public function setHrCalcType(arg1:com.garmin.fit.HrZoneCalc):void
        {
            setFieldValue(5, 0, arg1.getValue(), 65535);
            return;
        }

        public function getPwrCalcType():com.garmin.fit.PwrZoneCalc
        {
            var loc1:*=getFieldIntegerValue(7, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.PwrZoneCalc.getByValue(loc1);
        }

        public function setPwrCalcType(arg1:com.garmin.fit.PwrZoneCalc):void
        {
            setFieldValue(7, 0, arg1.getValue(), 65535);
            return;
        }

        public static function get zonesTargetMesg():com.garmin.fit.Mesg
        {
            return _zonesTargetMesg;
        }

        
        {
            _zonesTargetMesg = new com.garmin.fit.Mesg("zones_target", 7);
            zonesTargetMesg.addField(new com.garmin.fit.Field("max_heart_rate", 1, 2, 1, 0, ""));
            zonesTargetMesg.addField(new com.garmin.fit.Field("threshold_heart_rate", 2, 2, 1, 0, ""));
            zonesTargetMesg.addField(new com.garmin.fit.Field("functional_threshold_power", 3, 132, 1, 0, ""));
            zonesTargetMesg.addField(new com.garmin.fit.Field("hr_calc_type", 5, 0, 1, 0, ""));
            zonesTargetMesg.addField(new com.garmin.fit.Field("pwr_calc_type", 7, 0, 1, 0, ""));
        }

        internal static var _zonesTargetMesg:com.garmin.fit.Mesg;
    }
}


