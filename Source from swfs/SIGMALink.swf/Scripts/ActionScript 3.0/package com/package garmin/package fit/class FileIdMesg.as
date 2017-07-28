//class FileIdMesg
package com.garmin.fit 
{
    public class FileIdMesg extends com.garmin.fit.Mesg
    {
        public function FileIdMesg(arg1:com.garmin.fit.Mesg=null)
        {
            super(arg1 != null ? arg1 : com.garmin.fit.Factory.createMesg(0));
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

        public function getManufacturer():int
        {
            return getFieldIntegerValue(1, 0, 65535);
        }

        public function setManufacturer(arg1:int):void
        {
            setFieldValue(1, 0, arg1, 65535);
            return;
        }

        public function getProduct():int
        {
            return getFieldIntegerValue(2, 0, 65535);
        }

        public function setProduct(arg1:int):void
        {
            setFieldValue(2, 0, arg1, 65535);
            return;
        }

        public function getGarminProduct():int
        {
            return getFieldIntegerValue(2, 0, 0);
        }

        public function setGarminProduct(arg1:int):void
        {
            setFieldValue(2, 0, arg1, 0);
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

        public function getTimeCreated():com.garmin.fit.DateTime
        {
            return timestampToDateTime(getFieldDoubleValue(4, 0, 65535));
        }

        public function setTimeCreated(arg1:com.garmin.fit.DateTime):void
        {
            setFieldValue(4, 0, arg1.getTimestamp(), 65535);
            return;
        }

        public function getNumber():int
        {
            return getFieldIntegerValue(5, 0, 65535);
        }

        public function setNumber(arg1:int):void
        {
            setFieldValue(5, 0, arg1, 65535);
            return;
        }

        public function getProductName():String
        {
            return getFieldStringValue(8, 0, 65535);
        }

        public function setProductName(arg1:String):void
        {
            setFieldValue(8, 0, arg1, 65535);
            return;
        }

        public static function get fileIdMesg():com.garmin.fit.Mesg
        {
            return _fileIdMesg;
        }

        
        {
            _fileIdMesg = new com.garmin.fit.Mesg("file_id", 0);
            fileIdMesg.addField(new com.garmin.fit.Field("type", 0, 0, 1, 0, ""));
            ++field_index;
            fileIdMesg.addField(new com.garmin.fit.Field("manufacturer", 1, 132, 1, 0, ""));
            ++field_index;
            fileIdMesg.addField(new com.garmin.fit.Field("product", 2, 132, 1, 0, ""));
            subfield_index = 0;
            fileIdMesg.fields[field_index].subFields.push(new com.garmin.fit.SubField("garmin_product", 132, 1, 0, ""));
            fileIdMesg.fields[field_index].subFields[subfield_index].addMap(1, 1);
            fileIdMesg.fields[field_index].subFields[subfield_index].addMap(1, 15);
            fileIdMesg.fields[field_index].subFields[subfield_index].addMap(1, 13);
            ++subfield_index;
            ++field_index;
            fileIdMesg.addField(new com.garmin.fit.Field("serial_number", 3, 140, 1, 0, ""));
            ++field_index;
            fileIdMesg.addField(new com.garmin.fit.Field("time_created", 4, 134, 1, 0, ""));
            ++field_index;
            fileIdMesg.addField(new com.garmin.fit.Field("number", 5, 132, 1, 0, ""));
            ++field_index;
            fileIdMesg.addField(new com.garmin.fit.Field("product_name", 8, 7, 1, 0, ""));
            ++field_index;
        }

        internal static var _fileIdMesg:com.garmin.fit.Mesg;

        internal static var field_index:int=0;

        internal static var subfield_index:int=0;
    }
}


