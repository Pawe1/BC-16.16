//class CRC
package com.garmin.fit 
{
    import __AS3__.vec.*;
    
    public class CRC extends Object
    {
        public function CRC()
        {
            super();
            return;
        }

        public static function get16(arg1:int, arg2:uint):int
        {
            var loc1:*=0;
            4294967295;
            loc1 = crc16_table[arg1 & 15];
            arg1 = arg1 >> 4 & 4095;
            arg1 = arg1 ^ loc1 ^ crc16_table[arg2 & 15];
            loc1 = crc16_table[arg1 & 15];
            arg1 = arg1 >> 4 & 4095;
            arg1 = arg1 ^ loc1 ^ crc16_table[arg2 >> 4 & 15];
            return arg1;
        }

        
        {
            new __AS3__.vec.Vector.<uint>(16)[0] = 0;
            new __AS3__.vec.Vector.<uint>(16)[1] = 52225;
            new __AS3__.vec.Vector.<uint>(16)[2] = 55297;
            new __AS3__.vec.Vector.<uint>(16)[3] = 5120;
            new __AS3__.vec.Vector.<uint>(16)[4] = 61441;
            new __AS3__.vec.Vector.<uint>(16)[5] = 15360;
            new __AS3__.vec.Vector.<uint>(16)[6] = 10240;
            new __AS3__.vec.Vector.<uint>(16)[7] = 58369;
            new __AS3__.vec.Vector.<uint>(16)[8] = 40961;
            new __AS3__.vec.Vector.<uint>(16)[9] = 27648;
            new __AS3__.vec.Vector.<uint>(16)[10] = 30720;
            new __AS3__.vec.Vector.<uint>(16)[11] = 46081;
            new __AS3__.vec.Vector.<uint>(16)[12] = 20480;
            new __AS3__.vec.Vector.<uint>(16)[13] = 39937;
            new __AS3__.vec.Vector.<uint>(16)[14] = 34817;
            new __AS3__.vec.Vector.<uint>(16)[15] = 17408;
            crc16_table = new __AS3__.vec.Vector.<uint>(16);
        }

        internal static var crc16_table:__AS3__.vec.Vector.<uint>;
    }
}


