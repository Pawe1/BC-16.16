//class DeviceInfoMesg
package com.garmin.fit 
{
    public class DeviceInfoMesg extends com.garmin.fit.Mesg
    {
        public function DeviceInfoMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(23));
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

        public function getDeviceIndex():int
        {
            return getFieldIntegerValue(0, 0, 65535);
        }

        public function setDeviceIndex(arg1:int):void
        {
            setFieldValue(0, 0, arg1, 65535);
            return;
        }

        public function getDeviceType():int
        {
            return getFieldIntegerValue(1, 0, 65535);
        }

        public function setDeviceType(arg1:int):void
        {
            setFieldValue(1, 0, arg1, 65535);
            return;
        }

        public function getManufacturer():int
        {
            return getFieldIntegerValue(2, 0, 65535);
        }

        public function setManufacturer(arg1:int):void
        {
            setFieldValue(2, 0, arg1, 65535);
            return;
        }

        public function getSerialNumber():Number
        {
            return getFieldDoubleValue(3, 0, 65535);
        }

        public function setSerialNumber(arg1:Number):void
        {
            setFieldValue(3, 0, arg1, 65535);
            return;
        }

        public function getProduct():int
        {
            return getFieldIntegerValue(4, 0, 65535);
        }

        public function setProduct(arg1:int):void
        {
            setFieldValue(4, 0, arg1, 65535);
            return;
        }

        public function getSoftwareVersion():Number
        {
            return getFieldDoubleValue(5, 0, 65535);
        }

        public function setSoftwareVersion(arg1:Number):void
        {
            setFieldValue(5, 0, arg1, 65535);
            return;
        }

        public function getHardwareVersion():int
        {
            return getFieldIntegerValue(6, 0, 65535);
        }

        public function setHardwareVersion(arg1:int):void
        {
            setFieldValue(6, 0, arg1, 65535);
            return;
        }

        public function getCumOperatingTime():Number
        {
            return getFieldDoubleValue(7, 0, 65535);
        }

        public function setCumOperatingTime(arg1:Number):void
        {
            setFieldValue(7, 0, arg1, 65535);
            return;
        }

        public function getBatteryVoltage():Number
        {
            return getFieldDoubleValue(10, 0, 65535);
        }

        public function setBatteryVoltage(arg1:Number):void
        {
            setFieldValue(10, 0, arg1, 65535);
            return;
        }

        public function getBatteryStatus():int
        {
            return getFieldIntegerValue(11, 0, 65535);
        }

        public function setBatteryStatus(arg1:int):void
        {
            setFieldValue(11, 0, arg1, 65535);
            return;
        }

        public static function get deviceInfoMesg():com.garmin.fit.Mesg
        {
            return _deviceInfoMesg;
        }

        
        {
            _deviceInfoMesg = new com.garmin.fit.Mesg("device_info", 23);
            deviceInfoMesg.addField(new com.garmin.fit.Field("timestamp", 253, 134, 1, 0, "s"));
            deviceInfoMesg.addField(new com.garmin.fit.Field("device_index", 0, 2, 1, 0, ""));
            deviceInfoMesg.addField(new com.garmin.fit.Field("device_type", 1, 2, 1, 0, ""));
            deviceInfoMesg.addField(new com.garmin.fit.Field("manufacturer", 2, 132, 1, 0, ""));
            deviceInfoMesg.addField(new com.garmin.fit.Field("serial_number", 3, 140, 1, 0, ""));
            deviceInfoMesg.addField(new com.garmin.fit.Field("product", 4, 132, 1, 0, ""));
            deviceInfoMesg.addField(new com.garmin.fit.Field("software_version", 5, 132, 100, 0, ""));
            deviceInfoMesg.addField(new com.garmin.fit.Field("hardware_version", 6, 2, 1, 0, ""));
            deviceInfoMesg.addField(new com.garmin.fit.Field("cum_operating_time", 7, 134, 1, 0, "s"));
            deviceInfoMesg.addField(new com.garmin.fit.Field("battery_voltage", 10, 132, 256, 0, "V"));
            deviceInfoMesg.addField(new com.garmin.fit.Field("battery_status", 11, 2, 1, 0, ""));
        }

        internal static var _deviceInfoMesg:com.garmin.fit.Mesg;
    }
}


