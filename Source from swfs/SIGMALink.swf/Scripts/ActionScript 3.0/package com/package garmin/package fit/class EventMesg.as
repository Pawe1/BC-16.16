//class EventMesg
package com.garmin.fit 
{
    public class EventMesg extends com.garmin.fit.Mesg implements com.garmin.fit.MesgWithEvent
    {
        public function EventMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(21));
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

        public function getEvent():com.garmin.fit.FITEvent
        {
            var loc1:*=getFieldIntegerValue(0, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.FITEvent.getByValue(loc1);
        }

        public function setEvent(arg1:com.garmin.fit.FITEvent):void
        {
            setFieldValue(0, 0, arg1.getValue(), 65535);
            return;
        }

        public function getEventType():com.garmin.fit.EventType
        {
            var loc1:*=getFieldIntegerValue(1, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.EventType.getByValue(loc1);
        }

        public function setEventType(arg1:com.garmin.fit.EventType):void
        {
            setFieldValue(1, 0, arg1.getValue(), 65535);
            return;
        }

        public function getData16():int
        {
            return getFieldIntegerValue(2, 0, 65535);
        }

        public function setData16(arg1:int):void
        {
            setFieldValue(2, 0, arg1, 65535);
            return;
        }

        public function getData():Number
        {
            return getFieldDoubleValue(3, 0, 65535);
        }

        public function setData(arg1:Number):void
        {
            setFieldValue(3, 0, arg1, 65535);
            return;
        }

        public function getTimerTrigger():com.garmin.fit.TimerTrigger
        {
            var loc1:*=getFieldIntegerValue(3, 0, 0);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.TimerTrigger.getByValue(loc1);
        }

        public function setTimerTrigger(arg1:com.garmin.fit.TimerTrigger):void
        {
            setFieldValue(3, 0, arg1.getValue(), 0);
            return;
        }

        public function getCoursePointIndex():int
        {
            return getFieldIntegerValue(3, 0, 1);
        }

        public function setCoursePointIndex(arg1:int):void
        {
            setFieldValue(3, 0, arg1, 1);
            return;
        }

        public function getBatteryLevel():Number
        {
            return getFieldDoubleValue(3, 0, 2);
        }

        public function setBatteryLevel(arg1:Number):void
        {
            setFieldValue(3, 0, arg1, 2);
            return;
        }

        public function getVirtualPartnerSpeed():Number
        {
            return getFieldDoubleValue(3, 0, 3);
        }

        public function setVirtualPartnerSpeed(arg1:Number):void
        {
            setFieldValue(3, 0, arg1, 3);
            return;
        }

        public function getHrHighAlert():int
        {
            return getFieldIntegerValue(3, 0, 4);
        }

        public function setHrHighAlert(arg1:int):void
        {
            setFieldValue(3, 0, arg1, 4);
            return;
        }

        public function getHrLowAlert():int
        {
            return getFieldIntegerValue(3, 0, 5);
        }

        public function setHrLowAlert(arg1:int):void
        {
            setFieldValue(3, 0, arg1, 5);
            return;
        }

        public function getSpeedHighAlert():Number
        {
            return getFieldDoubleValue(3, 0, 6);
        }

        public function setSpeedHighAlert(arg1:Number):void
        {
            setFieldValue(3, 0, arg1, 6);
            return;
        }

        public function getSpeedLowAlert():Number
        {
            return getFieldDoubleValue(3, 0, 7);
        }

        public function setSpeedLowAlert(arg1:Number):void
        {
            setFieldValue(3, 0, arg1, 7);
            return;
        }

        public function getCadHighAlert():int
        {
            return getFieldIntegerValue(3, 0, 8);
        }

        public function setCadHighAlert(arg1:int):void
        {
            setFieldValue(3, 0, arg1, 8);
            return;
        }

        public function getCadLowAlert():int
        {
            return getFieldIntegerValue(3, 0, 9);
        }

        public function setCadLowAlert(arg1:int):void
        {
            setFieldValue(3, 0, arg1, 9);
            return;
        }

        public function getPowerHighAlert():int
        {
            return getFieldIntegerValue(3, 0, 10);
        }

        public function setPowerHighAlert(arg1:int):void
        {
            setFieldValue(3, 0, arg1, 10);
            return;
        }

        public function getPowerLowAlert():int
        {
            return getFieldIntegerValue(3, 0, 11);
        }

        public function setPowerLowAlert(arg1:int):void
        {
            setFieldValue(3, 0, arg1, 11);
            return;
        }

        public function getTimeDurationAlert():Number
        {
            return getFieldDoubleValue(3, 0, 12);
        }

        public function setTimeDurationAlert(arg1:Number):void
        {
            setFieldValue(3, 0, arg1, 12);
            return;
        }

        public function getDistanceDurationAlert():Number
        {
            return getFieldDoubleValue(3, 0, 13);
        }

        public function setDistanceDurationAlert(arg1:Number):void
        {
            setFieldValue(3, 0, arg1, 13);
            return;
        }

        public function getCalorieDurationAlert():Number
        {
            return getFieldDoubleValue(3, 0, 14);
        }

        public function setCalorieDurationAlert(arg1:Number):void
        {
            setFieldValue(3, 0, arg1, 14);
            return;
        }

        public function getFitnessEquipmentState():com.garmin.fit.FitnessEquipmentState
        {
            var loc1:*=getFieldIntegerValue(3, 0, 15);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.FitnessEquipmentState.getByValue(loc1);
        }

        public function setFitnessEquipmentState(arg1:com.garmin.fit.FitnessEquipmentState):void
        {
            setFieldValue(3, 0, arg1.getValue(), 15);
            return;
        }

        public function getEventGroup():int
        {
            return getFieldIntegerValue(4, 0, 65535);
        }

        public function setEventGroup(arg1:int):void
        {
            setFieldValue(4, 0, arg1, 65535);
            return;
        }

        public static function get eventMesg():com.garmin.fit.Mesg
        {
            return _eventMesg;
        }

        
        {
            _eventMesg = new com.garmin.fit.Mesg("event", 21);
            eventMesg.addField(new com.garmin.fit.Field("timestamp", 253, 134, 1, 0, "s"));
            ++field_index;
            eventMesg.addField(new com.garmin.fit.Field("event", 0, 0, 1, 0, ""));
            ++field_index;
            eventMesg.addField(new com.garmin.fit.Field("event_type", 1, 0, 1, 0, ""));
            ++field_index;
            eventMesg.addField(new com.garmin.fit.Field("data16", 2, 132, 1, 0, ""));
            eventMesg.fields[field_index].components.push(new com.garmin.fit.FieldComponent(3, false, 16, 1, 0));
            ++field_index;
            eventMesg.addField(new com.garmin.fit.Field("data", 3, 134, 1, 0, ""));
            subfield_index = 0;
            eventMesg.fields[field_index].subFields.push(new com.garmin.fit.SubField("timer_trigger", 0, 1, 0, ""));
            eventMesg.fields[field_index].subFields[subfield_index].addMap(0, 0);
            ++subfield_index;
            eventMesg.fields[field_index].subFields.push(new com.garmin.fit.SubField("course_point_index", 132, 1, 0, ""));
            eventMesg.fields[field_index].subFields[subfield_index].addMap(0, 10);
            ++subfield_index;
            eventMesg.fields[field_index].subFields.push(new com.garmin.fit.SubField("battery_level", 132, 1000, 0, "V"));
            eventMesg.fields[field_index].subFields[subfield_index].addMap(0, 11);
            ++subfield_index;
            eventMesg.fields[field_index].subFields.push(new com.garmin.fit.SubField("virtual_partner_speed", 132, 1000, 0, "m/s"));
            eventMesg.fields[field_index].subFields[subfield_index].addMap(0, 12);
            ++subfield_index;
            eventMesg.fields[field_index].subFields.push(new com.garmin.fit.SubField("hr_high_alert", 2, 1, 0, "bpm"));
            eventMesg.fields[field_index].subFields[subfield_index].addMap(0, 13);
            ++subfield_index;
            eventMesg.fields[field_index].subFields.push(new com.garmin.fit.SubField("hr_low_alert", 2, 1, 0, "bpm"));
            eventMesg.fields[field_index].subFields[subfield_index].addMap(0, 14);
            ++subfield_index;
            eventMesg.fields[field_index].subFields.push(new com.garmin.fit.SubField("speed_high_alert", 132, 1000, 0, "m/s"));
            eventMesg.fields[field_index].subFields[subfield_index].addMap(0, 15);
            ++subfield_index;
            eventMesg.fields[field_index].subFields.push(new com.garmin.fit.SubField("speed_low_alert", 132, 1000, 0, "m/s"));
            eventMesg.fields[field_index].subFields[subfield_index].addMap(0, 16);
            ++subfield_index;
            eventMesg.fields[field_index].subFields.push(new com.garmin.fit.SubField("cad_high_alert", 132, 1, 0, "rpm"));
            eventMesg.fields[field_index].subFields[subfield_index].addMap(0, 17);
            ++subfield_index;
            eventMesg.fields[field_index].subFields.push(new com.garmin.fit.SubField("cad_low_alert", 132, 1, 0, "rpm"));
            eventMesg.fields[field_index].subFields[subfield_index].addMap(0, 18);
            ++subfield_index;
            eventMesg.fields[field_index].subFields.push(new com.garmin.fit.SubField("power_high_alert", 132, 1, 0, "watts"));
            eventMesg.fields[field_index].subFields[subfield_index].addMap(0, 19);
            ++subfield_index;
            eventMesg.fields[field_index].subFields.push(new com.garmin.fit.SubField("power_low_alert", 132, 1, 0, "watts"));
            eventMesg.fields[field_index].subFields[subfield_index].addMap(0, 20);
            ++subfield_index;
            eventMesg.fields[field_index].subFields.push(new com.garmin.fit.SubField("time_duration_alert", 134, 1000, 0, "s"));
            eventMesg.fields[field_index].subFields[subfield_index].addMap(0, 23);
            ++subfield_index;
            eventMesg.fields[field_index].subFields.push(new com.garmin.fit.SubField("distance_duration_alert", 134, 100, 0, "m"));
            eventMesg.fields[field_index].subFields[subfield_index].addMap(0, 24);
            ++subfield_index;
            eventMesg.fields[field_index].subFields.push(new com.garmin.fit.SubField("calorie_duration_alert", 134, 1, 0, "calories"));
            eventMesg.fields[field_index].subFields[subfield_index].addMap(0, 25);
            ++subfield_index;
            eventMesg.fields[field_index].subFields.push(new com.garmin.fit.SubField("fitness_equipment_state", 0, 1, 0, ""));
            eventMesg.fields[field_index].subFields[subfield_index].addMap(0, 27);
            ++subfield_index;
            ++field_index;
            eventMesg.addField(new com.garmin.fit.Field("event_group", 4, 2, 1, 0, ""));
            ++field_index;
        }

        internal static var field_index:int=0;

        internal static var subfield_index:int=0;

        internal static var _eventMesg:com.garmin.fit.Mesg;
    }
}


