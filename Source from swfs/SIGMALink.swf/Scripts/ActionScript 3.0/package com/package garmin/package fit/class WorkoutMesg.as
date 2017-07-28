//class WorkoutMesg
package com.garmin.fit 
{
    public class WorkoutMesg extends com.garmin.fit.Mesg
    {
        public function WorkoutMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(26));
            return;
        }

        public function getSport():com.garmin.fit.Sport
        {
            var loc1:*=getFieldIntegerValue(4, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.Sport.getByValue(loc1);
        }

        public function setSport(arg1:com.garmin.fit.Sport):void
        {
            setFieldValue(4, 0, arg1.getValue(), 65535);
            return;
        }

        public function getCapabilities():Number
        {
            return getFieldDoubleValue(5, 0, 65535);
        }

        public function setCapabilities(arg1:Number):void
        {
            setFieldValue(5, 0, arg1, 65535);
            return;
        }

        public function getNumValidSteps():int
        {
            return getFieldIntegerValue(6, 0, 65535);
        }

        public function setNumValidSteps(arg1:int):void
        {
            setFieldValue(6, 0, arg1, 65535);
            return;
        }

        public function getWktName():String
        {
            return getFieldStringValue(8, 0, 65535);
        }

        public function setWktName(arg1:String):void
        {
            setFieldValue(8, 0, arg1, 65535);
            return;
        }

        public static function get workoutMesg():com.garmin.fit.Mesg
        {
            return _workoutMesg;
        }

        
        {
            _workoutMesg = new com.garmin.fit.Mesg("workout", 26);
            workoutMesg.addField(new com.garmin.fit.Field("sport", 4, 0, 1, 0, ""));
            workoutMesg.addField(new com.garmin.fit.Field("capabilities", 5, 140, 1, 0, ""));
            workoutMesg.addField(new com.garmin.fit.Field("num_valid_steps", 6, 132, 1, 0, ""));
            workoutMesg.addField(new com.garmin.fit.Field("wkt_name", 8, 7, 1, 0, ""));
        }

        internal static var _workoutMesg:com.garmin.fit.Mesg;
    }
}


