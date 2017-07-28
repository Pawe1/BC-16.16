//class FileCapabilitiesMesg
package com.garmin.fit 
{
    public class FileCapabilitiesMesg extends com.garmin.fit.Mesg
    {
        public function FileCapabilitiesMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(37));
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

        public function getType():com.garmin.fit.FITFile
        {
            var loc1:*=getFieldIntegerValue(0, 0, 65535);
            if (!loc1) 
            {
                return null;
            }
            return com.garmin.fit.FITFile.getByValue(loc1);
        }

        public function setType(arg1:com.garmin.fit.FITFile):void
        {
            setFieldValue(0, 0, arg1.getValue(), 65535);
            return;
        }

        public function getFlags():int
        {
            return getFieldIntegerValue(1, 0, 65535);
        }

        public function setFlags(arg1:int):void
        {
            setFieldValue(1, 0, arg1, 65535);
            return;
        }

        public function getDirectory():String
        {
            return getFieldStringValue(2, 0, 65535);
        }

        public function setDirectory(arg1:String):void
        {
            setFieldValue(2, 0, arg1, 65535);
            return;
        }

        public function getMaxCount():int
        {
            return getFieldIntegerValue(3, 0, 65535);
        }

        public function setMaxCount(arg1:int):void
        {
            setFieldValue(3, 0, arg1, 65535);
            return;
        }

        public function getMaxSize():Number
        {
            return getFieldDoubleValue(4, 0, 65535);
        }

        public function setMaxSize(arg1:Number):void
        {
            setFieldValue(4, 0, arg1, 65535);
            return;
        }

        public static function get fileCapabilitiesMesg():com.garmin.fit.Mesg
        {
            return _fileCapabilitiesMesg;
        }

        
        {
            _fileCapabilitiesMesg = new com.garmin.fit.Mesg("file_capabilities", 37);
            fileCapabilitiesMesg.addField(new com.garmin.fit.Field("message_index", 254, 132, 1, 0, ""));
            fileCapabilitiesMesg.addField(new com.garmin.fit.Field("type", 0, 0, 1, 0, ""));
            fileCapabilitiesMesg.addField(new com.garmin.fit.Field("flags", 1, 10, 1, 0, ""));
            fileCapabilitiesMesg.addField(new com.garmin.fit.Field("directory", 2, 7, 1, 0, ""));
            fileCapabilitiesMesg.addField(new com.garmin.fit.Field("max_count", 3, 132, 1, 0, ""));
            fileCapabilitiesMesg.addField(new com.garmin.fit.Field("max_size", 4, 134, 1, 0, "bytes"));
        }

        internal static var _fileCapabilitiesMesg:com.garmin.fit.Mesg;
    }
}


