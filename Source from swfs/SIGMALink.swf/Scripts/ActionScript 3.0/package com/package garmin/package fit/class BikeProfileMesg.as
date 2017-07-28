//class BikeProfileMesg
package com.garmin.fit 
{
    public class BikeProfileMesg extends com.garmin.fit.Mesg
    {
        public function BikeProfileMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(6));
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

        public override function getName():String
        {
            return getFieldStringValue(0, 0, 65535);
        }

        public function setName(arg1:String):void
        {
            setFieldValue(0, 0, arg1, 65535);
            return;
        }

        public function getSport():com.garmin.fit.Sport
        {
            var loc1:*=getFieldIntegerValue(1, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.Sport.getByValue(loc1);
        }

        public function setSport(arg1:com.garmin.fit.Sport):void
        {
            setFieldValue(1, 0, arg1.getValue(), 65535);
            return;
        }

        public function getSubSport():com.garmin.fit.SubSport
        {
            var loc1:*=getFieldIntegerValue(2, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.SubSport.getByValue(loc1);
        }

        public function setSubSport(arg1:com.garmin.fit.SubSport):void
        {
            setFieldValue(2, 0, arg1.getValue(), 65535);
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

        public function getBikeSpdAntId():int
        {
            return getFieldIntegerValue(4, 0, 65535);
        }

        public function setBikeSpdAntId(arg1:int):void
        {
            setFieldValue(4, 0, arg1, 65535);
            return;
        }

        public function getBikeCadAntId():int
        {
            return getFieldIntegerValue(5, 0, 65535);
        }

        public function setBikeCadAntId(arg1:int):void
        {
            setFieldValue(5, 0, arg1, 65535);
            return;
        }

        public function getBikeSpdcadAntId():int
        {
            return getFieldIntegerValue(6, 0, 65535);
        }

        public function setBikeSpdcadAntId(arg1:int):void
        {
            setFieldValue(6, 0, arg1, 65535);
            return;
        }

        public function getBikePowerAntId():int
        {
            return getFieldIntegerValue(7, 0, 65535);
        }

        public function setBikePowerAntId(arg1:int):void
        {
            setFieldValue(7, 0, arg1, 65535);
            return;
        }

        public function getCustomWheelsize():Number
        {
            return getFieldDoubleValue(8, 0, 65535);
        }

        public function setCustomWheelsize(arg1:Number):void
        {
            setFieldValue(8, 0, arg1, 65535);
            return;
        }

        public function getAutoWheelsize():Number
        {
            return getFieldDoubleValue(9, 0, 65535);
        }

        public function setAutoWheelsize(arg1:Number):void
        {
            setFieldValue(9, 0, arg1, 65535);
            return;
        }

        public function getBikeWeight():Number
        {
            return getFieldDoubleValue(10, 0, 65535);
        }

        public function setBikeWeight(arg1:Number):void
        {
            setFieldValue(10, 0, arg1, 65535);
            return;
        }

        public function getPowerCalFactor():Number
        {
            return getFieldDoubleValue(11, 0, 65535);
        }

        public function setPowerCalFactor(arg1:Number):void
        {
            setFieldValue(11, 0, arg1, 65535);
            return;
        }

        public function getAutoWheelCal():com.garmin.fit.FITBool
        {
            var loc1:*=getFieldIntegerValue(12, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.FITBool.getByValue(loc1);
        }

        public function setAutoWheelCal(arg1:com.garmin.fit.FITBool):void
        {
            setFieldValue(12, 0, arg1.getValue(), 65535);
            return;
        }

        public function getAutoPowerZero():com.garmin.fit.FITBool
        {
            var loc1:*=getFieldIntegerValue(13, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.FITBool.getByValue(loc1);
        }

        public function setAutoPowerZero(arg1:com.garmin.fit.FITBool):void
        {
            setFieldValue(13, 0, arg1.getValue(), 65535);
            return;
        }

        public function getId():int
        {
            return getFieldIntegerValue(14, 0, 65535);
        }

        public function setId(arg1:int):void
        {
            setFieldValue(14, 0, arg1, 65535);
            return;
        }

        public function getSpdEnabled():com.garmin.fit.FITBool
        {
            var loc1:*=getFieldIntegerValue(15, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.FITBool.getByValue(loc1);
        }

        public function setSpdEnabled(arg1:com.garmin.fit.FITBool):void
        {
            setFieldValue(15, 0, arg1, 65535);
            return;
        }

        public function getCadEnabled():com.garmin.fit.FITBool
        {
            var loc1:*=getFieldIntegerValue(16, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.FITBool.getByValue(loc1);
        }

        public function setCadEnabled(arg1:com.garmin.fit.FITBool):void
        {
            setFieldValue(16, 0, arg1, 65535);
            return;
        }

        public function getSpdcadEnabled():com.garmin.fit.FITBool
        {
            var loc1:*=getFieldIntegerValue(17, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.FITBool.getByValue(loc1);
        }

        public function setSpdcadEnabled(arg1:com.garmin.fit.FITBool):void
        {
            setFieldValue(17, 0, arg1, 65535);
            return;
        }

        public function getPowerEnabled():com.garmin.fit.FITBool
        {
            var loc1:*=getFieldIntegerValue(18, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.FITBool.getByValue(loc1);
        }

        public function setPowerEnabled(arg1:com.garmin.fit.FITBool):void
        {
            setFieldValue(18, 0, arg1.getValue(), 65535);
            return;
        }

        public function getCrankLength():Number
        {
            return getFieldDoubleValue(19, 0, 65535);
        }

        public function setCrankLength(arg1:Number):void
        {
            setFieldValue(19, 0, arg1, 65535);
            return;
        }

        public function getEnabled():com.garmin.fit.FITBool
        {
            var loc1:*=getFieldIntegerValue(20, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.FITBool.getByValue(loc1);
        }

        public function setEnabled(arg1:com.garmin.fit.FITBool):void
        {
            setFieldValue(20, 0, arg1, 65535);
            return;
        }

        public function getBikeSpdAntIdTransType():int
        {
            return getFieldIntegerValue(21, 0, 65535);
        }

        public function setBikeSpdAntIdTransType(arg1:int):void
        {
            setFieldValue(21, 0, arg1, 65535);
            return;
        }

        public function getBikeCadAntIdTransType():int
        {
            return getFieldIntegerValue(22, 0, 65535);
        }

        public function setBikeCadAntIdTransType(arg1:int):void
        {
            setFieldValue(22, 0, arg1, 65535);
            return;
        }

        public function getBikeSpdcadAntIdTransType():int
        {
            return getFieldIntegerValue(23, 0, 65535);
        }

        public function setBikeSpdcadAntIdTransType(arg1:int):void
        {
            setFieldValue(23, 0, arg1, 65535);
            return;
        }

        public function getBikePowerAntIdTransType():int
        {
            return getFieldIntegerValue(24, 0, 65535);
        }

        public function setBikePowerAntIdTransType(arg1:int):void
        {
            setFieldValue(24, 0, arg1, 65535);
            return;
        }

        public static function get bikeProfileMesg():com.garmin.fit.Mesg
        {
            return _bikeProfileMesg;
        }

        
        {
            _bikeProfileMesg = new com.garmin.fit.Mesg("bike_profile", 6);
            bikeProfileMesg.addField(new com.garmin.fit.Field("message_index", 254, 132, 1, 0, ""));
            bikeProfileMesg.addField(new com.garmin.fit.Field("name", 0, 7, 1, 0, ""));
            bikeProfileMesg.addField(new com.garmin.fit.Field("sport", 1, 0, 1, 0, ""));
            bikeProfileMesg.addField(new com.garmin.fit.Field("sub_sport", 2, 0, 1, 0, ""));
            bikeProfileMesg.addField(new com.garmin.fit.Field("odometer", 3, 134, 100, 0, "m"));
            bikeProfileMesg.addField(new com.garmin.fit.Field("bike_spd_ant_id", 4, 139, 1, 0, ""));
            bikeProfileMesg.addField(new com.garmin.fit.Field("bike_cad_ant_id", 5, 139, 1, 0, ""));
            bikeProfileMesg.addField(new com.garmin.fit.Field("bike_spdcad_ant_id", 6, 139, 1, 0, ""));
            bikeProfileMesg.addField(new com.garmin.fit.Field("bike_power_ant_id", 7, 139, 1, 0, ""));
            bikeProfileMesg.addField(new com.garmin.fit.Field("custom_wheelsize", 8, 132, 1000, 0, "m"));
            bikeProfileMesg.addField(new com.garmin.fit.Field("auto_wheelsize", 9, 132, 1000, 0, "m"));
            bikeProfileMesg.addField(new com.garmin.fit.Field("bike_weight", 10, 132, 10, 0, "kg"));
            bikeProfileMesg.addField(new com.garmin.fit.Field("power_cal_factor", 11, 132, 10, 0, "%"));
            bikeProfileMesg.addField(new com.garmin.fit.Field("auto_wheel_cal", 12, 0, 1, 0, ""));
            bikeProfileMesg.addField(new com.garmin.fit.Field("auto_power_zero", 13, 0, 1, 0, ""));
            bikeProfileMesg.addField(new com.garmin.fit.Field("id", 14, 2, 1, 0, ""));
            bikeProfileMesg.addField(new com.garmin.fit.Field("spd_enabled", 15, 0, 1, 0, ""));
            bikeProfileMesg.addField(new com.garmin.fit.Field("cad_enabled", 16, 0, 1, 0, ""));
            bikeProfileMesg.addField(new com.garmin.fit.Field("spdcad_enabled", 17, 0, 1, 0, ""));
            bikeProfileMesg.addField(new com.garmin.fit.Field("power_enabled", 18, 0, 1, 0, ""));
            bikeProfileMesg.addField(new com.garmin.fit.Field("crank_length", 19, 2, 2, -110, "mm"));
            bikeProfileMesg.addField(new com.garmin.fit.Field("enabled", 20, 0, 1, 0, ""));
            bikeProfileMesg.addField(new com.garmin.fit.Field("bike_spd_ant_id_trans_type", 21, 10, 1, 0, ""));
            bikeProfileMesg.addField(new com.garmin.fit.Field("bike_cad_ant_id_trans_type", 22, 10, 1, 0, ""));
            bikeProfileMesg.addField(new com.garmin.fit.Field("bike_spdcad_ant_id_trans_type", 23, 10, 1, 0, ""));
            bikeProfileMesg.addField(new com.garmin.fit.Field("bike_power_ant_id_trans_type", 24, 10, 1, 0, ""));
        }

        internal static var _bikeProfileMesg:com.garmin.fit.Mesg;
    }
}


