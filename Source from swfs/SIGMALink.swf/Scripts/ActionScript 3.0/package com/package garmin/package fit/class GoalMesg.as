//class GoalMesg
package com.garmin.fit 
{
    public class GoalMesg extends com.garmin.fit.Mesg
    {
        public function GoalMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(15));
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

        public function getStartDate():com.garmin.fit.DateTime
        {
            return timestampToDateTime(getFieldDoubleValue(2, 0, 65535));
        }

        public function setStartDate(arg1:com.garmin.fit.DateTime):void
        {
            setFieldValue(2, 0, arg1.getTimestamp(), 65535);
            return;
        }

        public function getEndDate():com.garmin.fit.DateTime
        {
            return timestampToDateTime(getFieldDoubleValue(3, 0, 65535));
        }

        public function setEndDate(arg1:com.garmin.fit.DateTime):void
        {
            setFieldValue(3, 0, arg1.getTimestamp(), 65535);
            return;
        }

        public function getType():com.garmin.fit.Goal
        {
            var loc1:*=getFieldIntegerValue(4, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.Goal.getByValue(loc1);
        }

        public function setType(arg1:com.garmin.fit.Goal):void
        {
            setFieldValue(4, 0, arg1.getValue(), 65535);
            return;
        }

        public function getValue():Number
        {
            return getFieldDoubleValue(5, 0, 65535);
        }

        public function setValue(arg1:Number):void
        {
            setFieldValue(5, 0, arg1, 65535);
            return;
        }

        public function getRepeat():com.garmin.fit.FITBool
        {
            var loc1:*=getFieldIntegerValue(6, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.FITBool.getByValue(loc1);
        }

        public function setRepeat(arg1:com.garmin.fit.FITBool):void
        {
            setFieldValue(6, 0, arg1.getValue(), 65535);
            return;
        }

        public function getTargetValue():Number
        {
            return getFieldDoubleValue(7, 0, 65535);
        }

        public function setTargetValue(arg1:Number):void
        {
            setFieldValue(7, 0, arg1, 65535);
            return;
        }

        public function getRecurrence():com.garmin.fit.GoalRecurrence
        {
            var loc1:*=getFieldIntegerValue(8, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.GoalRecurrence.getByValue(loc1);
        }

        public function setRecurrence(arg1:com.garmin.fit.GoalRecurrence):void
        {
            setFieldValue(8, 0, arg1.getValue(), 65535);
            return;
        }

        public function getRecurrenceValue():int
        {
            return getFieldIntegerValue(9, 0, 65535);
        }

        public function setRecurrenceValue(arg1:int):void
        {
            setFieldValue(9, 0, arg1, 65535);
            return;
        }

        public function getEnabled():com.garmin.fit.FITBool
        {
            var loc1:*=getFieldIntegerValue(10, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.FITBool.getByValue(loc1);
        }

        public function setEnabled(arg1:com.garmin.fit.FITBool):void
        {
            setFieldValue(10, 0, arg1.getValue(), 65535);
            return;
        }

        public static function get goalMesg():com.garmin.fit.Mesg
        {
            return _goalMesg;
        }

        
        {
            _goalMesg = new com.garmin.fit.Mesg("goal", 15);
            goalMesg.addField(new com.garmin.fit.Field("message_index", 254, 132, 1, 0, ""));
            goalMesg.addField(new com.garmin.fit.Field("sport", 0, 0, 1, 0, ""));
            goalMesg.addField(new com.garmin.fit.Field("sub_sport", 1, 0, 1, 0, ""));
            goalMesg.addField(new com.garmin.fit.Field("start_date", 2, 134, 1, 0, ""));
            goalMesg.addField(new com.garmin.fit.Field("end_date", 3, 134, 1, 0, ""));
            goalMesg.addField(new com.garmin.fit.Field("type", 4, 0, 1, 0, ""));
            goalMesg.addField(new com.garmin.fit.Field("value", 5, 134, 1, 0, ""));
            goalMesg.addField(new com.garmin.fit.Field("repeat", 6, 0, 1, 0, ""));
            goalMesg.addField(new com.garmin.fit.Field("target_value", 7, 134, 1, 0, ""));
            goalMesg.addField(new com.garmin.fit.Field("recurrence", 8, 0, 1, 0, ""));
            goalMesg.addField(new com.garmin.fit.Field("recurrence_value", 9, 132, 1, 0, ""));
            goalMesg.addField(new com.garmin.fit.Field("enabled", 10, 0, 1, 0, ""));
        }

        internal static var _goalMesg:com.garmin.fit.Mesg;
    }
}


