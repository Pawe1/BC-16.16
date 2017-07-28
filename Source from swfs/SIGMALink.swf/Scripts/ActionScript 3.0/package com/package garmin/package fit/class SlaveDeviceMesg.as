//class SlaveDeviceMesg
package com.garmin.fit 
{
    public class SlaveDeviceMesg extends com.garmin.fit.Mesg
    {
        public function SlaveDeviceMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(106));
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

        public static function get slaveDeviceMesg():com.garmin.fit.Mesg
        {
            return _slaveDeviceMesg;
        }

        
        {
            _slaveDeviceMesg = new com.garmin.fit.Mesg("slave_device", 106);
            slaveDeviceMesg.addField(new com.garmin.fit.Field("manufacturer", 0, 132, 1, 0, ""));
            ++field_index;
            slaveDeviceMesg.addField(new com.garmin.fit.Field("product", 1, 132, 1, 0, ""));
            subfield_index = 0;
            _slaveDeviceMesg.fields[field_index].subFields.push(new com.garmin.fit.SubField("garmin_product", 132, 1, 0, ""));
            _slaveDeviceMesg.fields[field_index].subFields[subfield_index].addMap(0, 1);
            _slaveDeviceMesg.fields[field_index].subFields[subfield_index].addMap(0, 15);
            _slaveDeviceMesg.fields[field_index].subFields[subfield_index].addMap(0, 13);
            ++subfield_index;
            ++field_index;
        }

        internal static var _slaveDeviceMesg:com.garmin.fit.Mesg;

        internal static var field_index:int=0;

        internal static var subfield_index:int=0;
    }
}


