//class Fit
package com.garmin.fit 
{
    import __AS3__.vec.*;
    
    public class Fit extends Object
    {
        public function Fit()
        {
            super();
            return;
        }

        
        {
            new __AS3__.vec.Vector.<uint>(14)[0] = 1;
            new __AS3__.vec.Vector.<uint>(14)[1] = 1;
            new __AS3__.vec.Vector.<uint>(14)[2] = 1;
            new __AS3__.vec.Vector.<uint>(14)[3] = 2;
            new __AS3__.vec.Vector.<uint>(14)[4] = 2;
            new __AS3__.vec.Vector.<uint>(14)[5] = 4;
            new __AS3__.vec.Vector.<uint>(14)[6] = 4;
            new __AS3__.vec.Vector.<uint>(14)[7] = 1;
            new __AS3__.vec.Vector.<uint>(14)[8] = 2;
            new __AS3__.vec.Vector.<uint>(14)[9] = 4;
            new __AS3__.vec.Vector.<uint>(14)[10] = 1;
            new __AS3__.vec.Vector.<uint>(14)[11] = 2;
            new __AS3__.vec.Vector.<uint>(14)[12] = 4;
            new __AS3__.vec.Vector.<uint>(14)[13] = 1;
        }

        public static const PROTOCOL_VERSION_MAJOR:int=1;

        public static const PROTOCOL_VERSION_MINOR:int=0;

        public static const PROTOCOL_VERSION_MAJOR_SHIFT:int=4;

        public static const PROTOCOL_VERSION_MAJOR_MASK:int=240;

        public static const PROTOCOL_VERSION_MINOR_MASK:int=15;

        public static const PROTOCOL_VERSION:int=16;

        public static const PROFILE_VERSION_MAJOR:int=6;

        public static const PROFILE_VERSION_MINOR:int=10;

        public static const PROFILE_VERSION_SCALE:int=100;

        public static const PROFILE_VERSION:int=610;

        public static const ANTFS_FILE_DATA_TYPE:int=128;

        public static const FILE_HDR_SIZE:int=14;

        public static const HDR_SIZE:int=1;

        public static const HDR_TIME_REC_BIT:int=128;

        public static const HDR_TIME_TYPE_MASK:int=96;

        public static const HDR_TIME_TYPE_SHIFT:int=5;

        public static const HDR_TIME_OFFSET_MASK:int=31;

        public static const HDR_TYPE_DEF_BIT:int=64;

        public static const HDR_TYPE_MASK:int=15;

        public static const MAX_LOCAL_MESGS:int=16;

        public static const MAX_MESG_SIZE:int=255;

        public static const ARCH_ENDIAN_MASK:int=1;

        public static const ARCH_ENDIAN_LITTLE:int=0;

        public static const ARCH_ENDIAN_BIG:int=1;

        public static const MAX_FIELD_SIZE:int=255;

        public static const FIELD_NUM_INVALID:int=255;

        public static const FIELD_NUM_MESSAGE_INDEX:int=254;

        public static const FIELD_NUM_TIMESTAMP:int=253;

        public static const SUBFIELD_INDEX_ACTIVE_SUBFIELD:int=65534;

        public static const SUBFIELD_INDEX_MAIN_FIELD:int=65535;

        public static const SUBFIELD_NAME_MAIN_FIELD:String=new String();

        public static const BASE_TYPE_ENDIAN_FLAG:int=128;

        public static const BASE_TYPE_RESERVED:int=96;

        public static const BASE_TYPE_NUM_MASK:int=31;

        public static const ENUM_INVALID:int=255;

        public static const BASE_TYPE_ENUM:int=0;

        public static const SINT8_INVALID:int=127;

        public static const BASE_TYPE_SINT8:int=1;

        public static const UINT8_INVALID:int=255;

        public static const BASE_TYPE_UINT8:int=2;

        public static const SINT16_INVALID:int=32767;

        public static const BASE_TYPE_SINT16:int=131;

        public static const UINT16_INVALID:int=65535;

        public static const BASE_TYPE_UINT16:int=132;

        public static const SINT32_INVALID:int=2147483647;

        public static const BASE_TYPE_SINT32:int=133;

        public static const UINT32_INVALID:Number=4294967295;

        public static const BASE_TYPE_UINT32:int=134;

        public static const BASE_TYPE_STRING:int=7;

        public static const FLOAT32_INVALID:Number=4294967295;

        public static const BASE_TYPE_FLOAT32:int=136;

        public static const FLOAT64_INVALID:Number=1.84467440737e+019;

        public static const BASE_TYPE_FLOAT64:int=137;

        public static const UINT8Z_INVALID:int=0;

        public static const BASE_TYPE_UINT8Z:int=10;

        public static const STRING_INVALID:String=new String();

        public static const BASE_TYPE_UINT16Z:int=139;

        public static const UINT32Z_INVALID:Number=0;

        public static const BASE_TYPE_UINT32Z:int=140;

        public static const BYTE_INVALID:int=255;

        public static const BASE_TYPE_BYTE:int=13;

        public static const BASE_TYPES:int=14;

        public static const baseTypeSizes:__AS3__.vec.Vector.<uint>=new __AS3__.vec.Vector.<uint>(14);

        public static const UINT16Z_INVALID:int=0;

        public static var debug:Boolean=false;
    }
}


