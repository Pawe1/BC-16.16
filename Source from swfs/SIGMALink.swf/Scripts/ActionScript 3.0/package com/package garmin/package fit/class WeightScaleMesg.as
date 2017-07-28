//class WeightScaleMesg
package com.garmin.fit 
{
    public class WeightScaleMesg extends com.garmin.fit.Mesg
    {
        public function WeightScaleMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(30));
            return;
        }

        public function getTimestamp():com.garmin.fit.DateTime
        {
            return timestampToDateTime(getFieldDoubleValue(253, 0, 65535));
        }

        public function setTimestamp(arg1:com.garmin.fit.DateTime):void
        {
            setFieldValue(253, 0, arg1.getTimestamp(), 65535);
            return;
        }

        public function getWeight():Number
        {
            return getFieldDoubleValue(0, 0, 65535);
        }

        public function setWeight(arg1:Number):void
        {
            setFieldValue(0, 0, arg1, 65535);
            return;
        }

        public function getPercentFat():Number
        {
            return getFieldDoubleValue(1, 0, 65535);
        }

        public function setPercentFat(arg1:Number):void
        {
            setFieldValue(1, 0, arg1, 65535);
            return;
        }

        public function getPercentHydration():Number
        {
            return getFieldDoubleValue(2, 0, 65535);
        }

        public function setPercentHydration(arg1:Number):void
        {
            setFieldValue(2, 0, arg1, 65535);
            return;
        }

        public function getVisceralFatMass():Number
        {
            return getFieldDoubleValue(3, 0, 65535);
        }

        public function setVisceralFatMass(arg1:Number):void
        {
            setFieldValue(3, 0, arg1, 65535);
            return;
        }

        public function getBoneMass():Number
        {
            return getFieldDoubleValue(4, 0, 65535);
        }

        public function setBoneMass(arg1:Number):void
        {
            setFieldValue(4, 0, arg1, 65535);
            return;
        }

        public function getMuscleMass():Number
        {
            return getFieldDoubleValue(5, 0, 65535);
        }

        public function setMuscleMass(arg1:Number):void
        {
            setFieldValue(5, 0, arg1, 65535);
            return;
        }

        public function getBasalMet():Number
        {
            return getFieldDoubleValue(7, 0, 65535);
        }

        public function setBasalMet(arg1:Number):void
        {
            setFieldValue(7, 0, arg1, 65535);
            return;
        }

        public function getPhysiqueRating():int
        {
            return getFieldIntegerValue(8, 0, 65535);
        }

        public function setPhysiqueRating(arg1:int):void
        {
            setFieldValue(8, 0, arg1, 65535);
            return;
        }

        public function getActiveMet():Number
        {
            return getFieldDoubleValue(9, 0, 65535);
        }

        public function setActiveMet(arg1:Number):void
        {
            setFieldValue(9, 0, arg1, 65535);
            return;
        }

        public function getMetabolicAge():int
        {
            return getFieldIntegerValue(10, 0, 65535);
        }

        public function setMetabolicAge(arg1:int):void
        {
            setFieldValue(10, 0, arg1, 65535);
            return;
        }

        public function getVisceralFatRating():int
        {
            return getFieldIntegerValue(11, 0, 65535);
        }

        public function setVisceralFatRating(arg1:int):void
        {
            setFieldValue(11, 0, arg1, 65535);
            return;
        }

        public function getUserProfileIndex():int
        {
            return getFieldIntegerValue(12, 0, 65535);
        }

        public function setUserProfileIndex(arg1:int):void
        {
            setFieldValue(12, 0, arg1, 65535);
            return;
        }

        public static function get weightScaleMesg():com.garmin.fit.Mesg
        {
            return _weightScaleMesg;
        }

        
        {
            _weightScaleMesg = new com.garmin.fit.Mesg("weight_scale", 30);
            weightScaleMesg.addField(new com.garmin.fit.Field("timestamp", 253, 134, 1, 0, "s"));
            weightScaleMesg.addField(new com.garmin.fit.Field("weight", 0, 132, 100, 0, "kg"));
            weightScaleMesg.addField(new com.garmin.fit.Field("percent_fat", 1, 132, 100, 0, "%"));
            weightScaleMesg.addField(new com.garmin.fit.Field("percent_hydration", 2, 132, 100, 0, "%"));
            weightScaleMesg.addField(new com.garmin.fit.Field("visceral_fat_mass", 3, 132, 100, 0, "kg"));
            weightScaleMesg.addField(new com.garmin.fit.Field("bone_mass", 4, 132, 100, 0, "kg"));
            weightScaleMesg.addField(new com.garmin.fit.Field("muscle_mass", 5, 132, 100, 0, "kg"));
            weightScaleMesg.addField(new com.garmin.fit.Field("basal_met", 7, 132, 4, 0, "kcal/day"));
            weightScaleMesg.addField(new com.garmin.fit.Field("physique_rating", 8, 2, 1, 0, ""));
            weightScaleMesg.addField(new com.garmin.fit.Field("active_met", 9, 132, 4, 0, "kcal/day"));
            weightScaleMesg.addField(new com.garmin.fit.Field("metabolic_age", 10, 2, 1, 0, "years"));
            weightScaleMesg.addField(new com.garmin.fit.Field("visceral_fat_rating", 11, 2, 1, 0, ""));
            weightScaleMesg.addField(new com.garmin.fit.Field("user_profile_index", 12, 132, 1, 0, ""));
        }

        internal static var _weightScaleMesg:com.garmin.fit.Mesg;
    }
}


