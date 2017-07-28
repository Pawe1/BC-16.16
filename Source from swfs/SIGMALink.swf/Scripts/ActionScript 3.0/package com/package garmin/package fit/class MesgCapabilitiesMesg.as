//class MesgCapabilitiesMesg
package com.garmin.fit 
{
    public class MesgCapabilitiesMesg extends com.garmin.fit.Mesg
    {
        public function MesgCapabilitiesMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(38));
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

        public function getCountType():com.garmin.fit.MesgCount
        {
            var loc1:*=getFieldIntegerValue(2, 0, 65535);
            if (isNaN(loc1)) 
            {
                return null;
            }
            return com.garmin.fit.MesgCount.getByValue(loc1);
        }

        public function setCountType(arg1:com.garmin.fit.MesgCount):void
        {
            setFieldValue(2, 0, arg1.getValue(), 65535);
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

        public function getNumPerFile():int
        {
            return getFieldIntegerValue(3, 0, 0);
        }

        public function setNumPerFile(arg1:int):void
        {
            setFieldValue(3, 0, arg1, 0);
            return;
        }

        public function getMaxPerFile():int
        {
            return getFieldIntegerValue(3, 0, 1);
        }

        public function setMaxPerFile(arg1:int):void
        {
            setFieldValue(3, 0, arg1, 1);
            return;
        }

        public function getMaxPerFileType():int
        {
            return getFieldIntegerValue(3, 0, 2);
        }

        public function setMaxPerFileType(arg1:int):void
        {
            setFieldValue(3, 0, arg1, 2);
            return;
        }

        public static function get mesgCapabilitiesMesg():com.garmin.fit.Mesg
        {
            return _mesgCapabilitiesMesg;
        }

        
        {
            _mesgCapabilitiesMesg = new com.garmin.fit.Mesg("mesg_capabilities", 38);
            mesgCapabilitiesMesg.addField(new com.garmin.fit.Field("message_index", 254, 132, 1, 0, ""));
            ++field_index;
            mesgCapabilitiesMesg.addField(new com.garmin.fit.Field("file", 0, 0, 1, 0, ""));
            ++field_index;
            mesgCapabilitiesMesg.addField(new com.garmin.fit.Field("mesg_num", 1, 132, 1, 0, ""));
            ++field_index;
            mesgCapabilitiesMesg.addField(new com.garmin.fit.Field("count_type", 2, 0, 1, 0, ""));
            ++field_index;
            mesgCapabilitiesMesg.addField(new com.garmin.fit.Field("count", 3, 132, 1, 0, ""));
            subfield_index = 0;
            mesgCapabilitiesMesg.fields[field_index].subFields.push(new com.garmin.fit.SubField("num_per_file", 132, 1, 0, ""));
            mesgCapabilitiesMesg.fields[field_index].subFields[subfield_index].addMap(2, 0);
            ++subfield_index;
            mesgCapabilitiesMesg.fields[field_index].subFields.push(new com.garmin.fit.SubField("max_per_file", 132, 1, 0, ""));
            mesgCapabilitiesMesg.fields[field_index].subFields[subfield_index].addMap(2, 1);
            ++subfield_index;
            mesgCapabilitiesMesg.fields[field_index].subFields.push(new com.garmin.fit.SubField("max_per_file_type", 132, 1, 0, ""));
            mesgCapabilitiesMesg.fields[field_index].subFields[subfield_index].addMap(2, 2);
            ++subfield_index;
            ++field_index;
        }

        internal static var _mesgCapabilitiesMesg:com.garmin.fit.Mesg;

        internal static var field_index:int=0;

        internal static var subfield_index:int=0;
    }
}


