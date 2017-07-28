//class FileCreatorMesg
package com.garmin.fit 
{
    public class FileCreatorMesg extends com.garmin.fit.Mesg
    {
        public function FileCreatorMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(49));
            return;
        }

        public function getSoftwareVersion():int
        {
            return getFieldIntegerValue(0, 0, 65535);
        }

        public function setSoftwareVersion(arg1:int):void
        {
            setFieldValue(0, 0, arg1, 65535);
            return;
        }

        public function getHardwareVersion():int
        {
            return getFieldIntegerValue(1, 0, 65535);
        }

        public function setHardwareVersion(arg1:int):void
        {
            setFieldValue(1, 0, arg1, 65535);
            return;
        }

        public static function get fileCreatorMesg():com.garmin.fit.Mesg
        {
            return _fileCreatorMesg;
        }

        
        {
            _fileCreatorMesg = new com.garmin.fit.Mesg("file_creator", 49);
            fileCreatorMesg.addField(new com.garmin.fit.Field("software_version", 0, 132, 1, 0, ""));
            fileCreatorMesg.addField(new com.garmin.fit.Field("hardware_version", 1, 2, 1, 0, ""));
        }

        internal static var _fileCreatorMesg:com.garmin.fit.Mesg;
    }
}


