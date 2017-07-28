//class UserProfileMesg
package com.garmin.fit 
{
    public class UserProfileMesg extends com.garmin.fit.Mesg
    {
        public function UserProfileMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(3));
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

        public function getFriendlyName():String
        {
            return getFieldStringValue(0, 0, 65535);
        }

        public function setFriendlyName(arg1:String):void
        {
            setFieldValue(0, 0, arg1, 65535);
            return;
        }

        public function getGender():com.garmin.fit.Gender
        {
            var loc1:*=getFieldIntegerValue(1, 0, 65535);
            if (!loc1) 
            {
                return null;
            }
            return com.garmin.fit.Gender.getByValue(loc1);
        }

        public function setGender(arg1:com.garmin.fit.Gender):void
        {
            setFieldValue(1, 0, arg1.getValue(), 65535);
            return;
        }

        public function getAge():int
        {
            return getFieldIntegerValue(2, 0, 65535);
        }

        public function setAge(arg1:int):void
        {
            setFieldValue(2, 0, arg1, 65535);
            return;
        }

        public function getHeight():Number
        {
            return getFieldDoubleValue(3, 0, 65535);
        }

        public function setHeight(arg1:Number):void
        {
            setFieldValue(3, 0, arg1, 65535);
            return;
        }

        public function getWeight():Number
        {
            return getFieldDoubleValue(4, 0, 65535);
        }

        public function setWeight(arg1:Number):void
        {
            setFieldValue(4, 0, arg1, 65535);
            return;
        }

        public function getLanguage():com.garmin.fit.Language
        {
            var loc1:*=getFieldIntegerValue(5, 0, 65535);
            if (!loc1) 
            {
                return null;
            }
            return com.garmin.fit.Language.getByValue(loc1);
        }

        public function setLanguage(arg1:com.garmin.fit.Language):void
        {
            setFieldValue(5, 0, arg1.getValue(), 65535);
            return;
        }

        public function getElevSetting():com.garmin.fit.DisplayMeasure
        {
            var loc1:*=getFieldIntegerValue(6, 0, 65535);
            if (!loc1) 
            {
                return null;
            }
            return com.garmin.fit.DisplayMeasure.getByValue(loc1);
        }

        public function setElevSetting(arg1:com.garmin.fit.DisplayMeasure):void
        {
            setFieldValue(6, 0, arg1.getValue(), 65535);
            return;
        }

        public function getWeightSetting():com.garmin.fit.DisplayMeasure
        {
            var loc1:*=getFieldIntegerValue(7, 0, 65535);
            if (!loc1) 
            {
                return null;
            }
            return com.garmin.fit.DisplayMeasure.getByValue(loc1);
        }

        public function setWeightSetting(arg1:com.garmin.fit.DisplayMeasure):void
        {
            setFieldValue(7, 0, arg1.getValue(), 65535);
            return;
        }

        public function getRestingHeartRate():int
        {
            return getFieldIntegerValue(8, 0, 65535);
        }

        public function setRestingHeartRate(arg1:int):void
        {
            setFieldValue(8, 0, arg1, 65535);
            return;
        }

        public function getDefaultMaxRunningHeartRate():int
        {
            return getFieldIntegerValue(9, 0, 65535);
        }

        public function setDefaultMaxRunningHeartRate(arg1:int):void
        {
            setFieldValue(9, 0, arg1, 65535);
            return;
        }

        public function getDefaultMaxBikingHeartRate():int
        {
            return getFieldIntegerValue(10, 0, 65535);
        }

        public function setDefaultMaxBikingHeartRate(arg1:int):void
        {
            setFieldValue(10, 0, arg1, 65535);
            return;
        }

        public function getDefaultMaxHeartRate():int
        {
            return getFieldIntegerValue(11, 0, 65535);
        }

        public function setDefaultMaxHeartRate(arg1:int):void
        {
            setFieldValue(11, 0, arg1, 65535);
            return;
        }

        public function getHrSetting():com.garmin.fit.DisplayHeart
        {
            var loc1:*=getFieldIntegerValue(12, 0, 65535);
            if (!loc1) 
            {
                return null;
            }
            return com.garmin.fit.DisplayHeart.getByValue(loc1);
        }

        public function setHrSetting(arg1:com.garmin.fit.DisplayHeart):void
        {
            setFieldValue(12, 0, arg1.getValue(), 65535);
            return;
        }

        public function getSpeedSetting():com.garmin.fit.DisplayMeasure
        {
            var loc1:*=getFieldIntegerValue(13, 0, 65535);
            if (!loc1) 
            {
                return null;
            }
            return com.garmin.fit.DisplayMeasure.getByValue(loc1);
        }

        public function setSpeedSetting(arg1:com.garmin.fit.DisplayMeasure):void
        {
            setFieldValue(13, 0, arg1.getValue(), 65535);
            return;
        }

        public function getDistSetting():com.garmin.fit.DisplayMeasure
        {
            var loc1:*=getFieldIntegerValue(14, 0, 65535);
            if (!loc1) 
            {
                return null;
            }
            return com.garmin.fit.DisplayMeasure.getByValue(loc1);
        }

        public function setDistSetting(arg1:com.garmin.fit.DisplayMeasure):void
        {
            setFieldValue(14, 0, arg1.getValue(), 65535);
            return;
        }

        public function getPowerSetting():com.garmin.fit.DisplayPower
        {
            var loc1:*=getFieldIntegerValue(16, 0, 65535);
            if (!loc1) 
            {
                return null;
            }
            return com.garmin.fit.DisplayPower.getByValue(loc1);
        }

        public function setPowerSetting(arg1:com.garmin.fit.DisplayPower):void
        {
            setFieldValue(16, 0, arg1.getValue(), 65535);
            return;
        }

        public function getActivityClass():com.garmin.fit.ActivityClass
        {
            var loc1:*=getFieldIntegerValue(17, 0, 65535);
            if (!loc1) 
            {
                return null;
            }
            return com.garmin.fit.ActivityClass.getByValue(loc1);
        }

        public function setActivityClass(arg1:com.garmin.fit.ActivityClass):void
        {
            setFieldValue(17, 0, arg1.getValue(), 65535);
            return;
        }

        public function getPositionSetting():com.garmin.fit.DisplayPosition
        {
            var loc1:*=getFieldIntegerValue(18, 0, 65535);
            if (!loc1) 
            {
                return null;
            }
            return com.garmin.fit.DisplayPosition.getByValue(loc1);
        }

        public function setPositionSetting(arg1:com.garmin.fit.DisplayPosition):void
        {
            setFieldValue(18, 0, arg1.getValue(), 65535);
            return;
        }

        public function getTemperatureSetting():com.garmin.fit.DisplayMeasure
        {
            var loc1:*=getFieldIntegerValue(21, 0, 65535);
            if (!loc1) 
            {
                return null;
            }
            return com.garmin.fit.DisplayMeasure.getByValue(loc1);
        }

        public function setTemperatureSetting(arg1:com.garmin.fit.DisplayMeasure):void
        {
            setFieldValue(21, 0, arg1.getValue(), 65535);
            return;
        }

        public function getLocalId():int
        {
            return getFieldIntegerValue(22, 0, 65535);
        }

        public function setLocalId(arg1:int):void
        {
            setFieldValue(22, 0, arg1, 65535);
            return;
        }

        public function getNumGlobalId():int
        {
            return getNumFieldValues(23, 65535);
        }

        public function getGlobalId(arg1:int):int
        {
            return getFieldIntegerValue(23, arg1, 65535);
        }

        public function setGlobalId(arg1:int, arg2:int):void
        {
            setFieldValue(23, arg1, arg2, 65535);
            return;
        }

        public static function get userProfileMesg():com.garmin.fit.Mesg
        {
            return _userProfileMesg;
        }

        
        {
            _userProfileMesg = new com.garmin.fit.Mesg("user_profile", 3);
            userProfileMesg.addField(new com.garmin.fit.Field("message_index", 254, 132, 1, 0, ""));
            userProfileMesg.addField(new com.garmin.fit.Field("friendly_name", 0, 7, 1, 0, ""));
            userProfileMesg.addField(new com.garmin.fit.Field("gender", 1, 0, 1, 0, ""));
            userProfileMesg.addField(new com.garmin.fit.Field("age", 2, 2, 1, 0, "years"));
            userProfileMesg.addField(new com.garmin.fit.Field("height", 3, 2, 100, 0, "m"));
            userProfileMesg.addField(new com.garmin.fit.Field("weight", 4, 132, 10, 0, "kg"));
            userProfileMesg.addField(new com.garmin.fit.Field("language", 5, 0, 1, 0, ""));
            userProfileMesg.addField(new com.garmin.fit.Field("elev_setting", 6, 0, 1, 0, ""));
            userProfileMesg.addField(new com.garmin.fit.Field("weight_setting", 7, 0, 1, 0, ""));
            userProfileMesg.addField(new com.garmin.fit.Field("resting_heart_rate", 8, 2, 1, 0, "bpm"));
            userProfileMesg.addField(new com.garmin.fit.Field("default_max_running_heart_rate", 9, 2, 1, 0, "bpm"));
            userProfileMesg.addField(new com.garmin.fit.Field("default_max_biking_heart_rate", 10, 2, 1, 0, "bpm"));
            userProfileMesg.addField(new com.garmin.fit.Field("default_max_heart_rate", 11, 2, 1, 0, "bpm"));
            userProfileMesg.addField(new com.garmin.fit.Field("hr_setting", 12, 0, 1, 0, ""));
            userProfileMesg.addField(new com.garmin.fit.Field("speed_setting", 13, 0, 1, 0, ""));
            userProfileMesg.addField(new com.garmin.fit.Field("dist_setting", 14, 0, 1, 0, ""));
            userProfileMesg.addField(new com.garmin.fit.Field("power_setting", 16, 0, 1, 0, ""));
            userProfileMesg.addField(new com.garmin.fit.Field("activity_class", 17, 0, 1, 0, ""));
            userProfileMesg.addField(new com.garmin.fit.Field("position_setting", 18, 0, 1, 0, ""));
            userProfileMesg.addField(new com.garmin.fit.Field("temperature_setting", 21, 0, 1, 0, ""));
            userProfileMesg.addField(new com.garmin.fit.Field("local_id", 22, 132, 1, 0, ""));
            userProfileMesg.addField(new com.garmin.fit.Field("global_id", 23, 13, 1, 0, ""));
        }

        internal static var _userProfileMesg:com.garmin.fit.Mesg;
    }
}


