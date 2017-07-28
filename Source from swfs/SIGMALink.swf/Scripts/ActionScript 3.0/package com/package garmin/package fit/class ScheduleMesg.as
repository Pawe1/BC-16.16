//class ScheduleMesg
package com.garmin.fit 
{
    public class ScheduleMesg extends com.garmin.fit.Mesg
    {
        public function ScheduleMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(28));
            return;
        }

        public function getManufacturer():int
        {
            return getFieldIntegerValue(0, 0, 65535);
        }

        public function setManufacturer(arg1:int):void
        {
            setFieldValue(0, 0, arg1, 65535);
            return;
        }

        public function getProduct():int
        {
            return getFieldIntegerValue(1, 0, 65535);
        }

        public function setProduct(arg1:int):void
        {
            setFieldValue(1, 0, arg1, 65535);
            return;
        }

        public function getGarminProduct():int
        {
            return getFieldIntegerValue(1, 0, 0);
        }

        public function setGarminProduct(arg1:int):void
        {
            setFieldValue(1, 0, arg1, 0);
            return;
        }

        public function getSerialNumber():Number
        {
            return getFieldDoubleValue(2, 0, 65535);
        }

        public function setSerialNumber(arg1:Number):void
        {
            setFieldValue(2, 0, arg1, 65535);
            return;
        }

        public function getTimeCreated():com.garmin.fit.DateTime
        {
            return timestampToDateTime(getFieldDoubleValue(3, 0, 65535));
        }

        public function setTimeCreated(arg1:com.garmin.fit.DateTime):void
        {
            setFieldValue(3, 0, arg1.getTimestamp(), 65535);
            return;
        }

        public function getCompleted():com.garmin.fit.FITBool
        {
            var loc1:*=getFieldIntegerValue(4, 0, 65535);
            if (!loc1) 
            {
                return null;
            }
            return com.garmin.fit.FITBool.getByValue(loc1);
        }

        public function setCompleted(arg1:Boolean):void
        {
            setFieldValue(4, 0, arg1, 65535);
            return;
        }

        public function getType():com.garmin.fit.Schedule
        {
            var loc1:*=getFieldIntegerValue(5, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.Schedule.getByValue(loc1);
        }

        public function setType(arg1:com.garmin.fit.Schedule):void
        {
            setFieldValue(5, 0, arg1.getValue(), 65535);
            return;
        }

        public function getScheduledTime():Number
        {
            return getFieldDoubleValue(6, 0, 65535);
        }

        public function setScheduledTime(arg1:Number):void
        {
            setFieldValue(6, 0, arg1, 65535);
            return;
        }

        public static function get scheduleMesg():com.garmin.fit.Mesg
        {
            return _scheduleMesg;
        }

        
        {
            _scheduleMesg = new com.garmin.fit.Mesg("schedule", 28);
            scheduleMesg.addField(new com.garmin.fit.Field("manufacturer", 0, 132, 1, 0, ""));
            ++field_index;
            scheduleMesg.addField(new com.garmin.fit.Field("product", 1, 132, 1, 0, ""));
            subfield_index = 0;
            scheduleMesg.fields[field_index].subFields.push(new com.garmin.fit.SubField("garmin_product", 132, 1, 0, ""));
            scheduleMesg.fields[field_index].subFields[subfield_index].addMap(0, 1);
            scheduleMesg.fields[field_index].subFields[subfield_index].addMap(0, 15);
            scheduleMesg.fields[field_index].subFields[subfield_index].addMap(0, 13);
            ++subfield_index;
            ++field_index;
            scheduleMesg.addField(new com.garmin.fit.Field("serial_number", 2, 140, 1, 0, ""));
            ++field_index;
            scheduleMesg.addField(new com.garmin.fit.Field("time_created", 3, 134, 1, 0, ""));
            ++field_index;
            scheduleMesg.addField(new com.garmin.fit.Field("completed", 4, 0, 1, 0, ""));
            ++field_index;
            scheduleMesg.addField(new com.garmin.fit.Field("type", 5, 0, 1, 0, ""));
            ++field_index;
            scheduleMesg.addField(new com.garmin.fit.Field("scheduled_time", 6, 134, 1, 0, ""));
            ++field_index;
        }

        internal static var _scheduleMesg:com.garmin.fit.Mesg;

        internal static var field_index:int=0;

        internal static var subfield_index:int=0;
    }
}


