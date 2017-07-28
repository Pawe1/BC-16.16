//class DeviceSettingsMesg
package com.garmin.fit 
{
    public class DeviceSettingsMesg extends com.garmin.fit.Mesg
    {
        public function DeviceSettingsMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(2));
            return;
        }

        public function getUtcOffset():Number
        {
            return getFieldDoubleValue(1, 0, 65535);
        }

        public function setUtcOffset(arg1:Number):void
        {
            setFieldValue(1, 0, arg1, 65535);
            return;
        }

        public static function get deviceSettingsMesg():com.garmin.fit.Mesg
        {
            return _deviceSettingsMesg;
        }

        
        {
            _deviceSettingsMesg = new com.garmin.fit.Mesg("device_settings", 2);
            deviceSettingsMesg.addField(new com.garmin.fit.Field("utc_offset", 1, 134, 1, 0, ""));
        }

        internal static var _deviceSettingsMesg:com.garmin.fit.Mesg;
    }
}


