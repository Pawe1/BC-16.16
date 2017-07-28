//class FieldCapabilitiesMesg
package com.garmin.fit 
{
    public class FieldCapabilitiesMesg extends com.garmin.fit.Mesg
    {
        public function FieldCapabilitiesMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(39));
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

        public function getFile():com.garmin.fit.FITFile
        {
            var loc1:*=getFieldIntegerValue(0, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.FITFile.getByValue(loc1);
        }

        public function setFile(arg1:com.garmin.fit.FITFile):void
        {
            setFieldValue(0, 0, arg1.getValue(), 65535);
            return;
        }

        public function getMesgNum():int
        {
            return getFieldIntegerValue(1, 0, 65535);
        }

        public function setMesgNum(arg1:int):void
        {
            setFieldValue(1, 0, arg1, 65535);
            return;
        }

        public function getFieldNum():int
        {
            return getFieldIntegerValue(2, 0, 65535);
        }

        public function setFieldNum(arg1:int):void
        {
            setFieldValue(2, 0, arg1, 65535);
            return;
        }

        public function getCount():int
        {
            return getFieldIntegerValue(3, 0, 65535);
        }

        public function setCount(arg1:int):void
        {
            setFieldValue(3, 0, arg1, 65535);
            return;
        }

        public static function get fieldCapabilitiesMesg():com.garmin.fit.Mesg
        {
            return _fieldCapabilitiesMesg;
        }

        
        {
            _fieldCapabilitiesMesg = new com.garmin.fit.Mesg("field_capabilities", 39);
            fieldCapabilitiesMesg.addField(new com.garmin.fit.Field("message_index", 254, 132, 1, 0, ""));
            fieldCapabilitiesMesg.addField(new com.garmin.fit.Field("file", 0, 0, 1, 0, ""));
            fieldCapabilitiesMesg.addField(new com.garmin.fit.Field("mesg_num", 1, 132, 1, 0, ""));
            fieldCapabilitiesMesg.addField(new com.garmin.fit.Field("field_num", 2, 2, 1, 0, ""));
            fieldCapabilitiesMesg.addField(new com.garmin.fit.Field("count", 3, 132, 1, 0, ""));
        }

        internal static var _fieldCapabilitiesMesg:com.garmin.fit.Mesg;
    }
}


