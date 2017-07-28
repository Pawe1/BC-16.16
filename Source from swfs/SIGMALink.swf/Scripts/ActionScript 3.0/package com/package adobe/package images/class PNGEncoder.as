//class PNGEncoder
package com.adobe.images 
{
    import flash.display.*;
    import flash.geom.*;
    import flash.utils.*;
    
    public class PNGEncoder extends Object
    {
        public function PNGEncoder()
        {
            super();
            return;
        }

        public static function encode(arg1:flash.display.BitmapData):flash.utils.ByteArray
        {
            var loc3:*=0;
            var loc1:*=0;
            var loc4:*=0;
            var loc2:*=new flash.utils.ByteArray();
            loc2.writeUnsignedInt(2303741511);
            loc2.writeUnsignedInt(218765834);
            var loc6:*;
            (loc6 = new flash.utils.ByteArray()).writeInt(arg1.width);
            loc6.writeInt(arg1.height);
            loc6.writeUnsignedInt(134610944);
            loc6.writeByte(0);
            writeChunk(loc2, 1229472850, loc6);
            var loc5:*=new flash.utils.ByteArray();
            loc3 = 0;
            while (loc3 < arg1.height) 
            {
                loc5.writeByte(0);
                if (arg1.transparent) 
                {
                    loc4 = 0;
                    while (loc4 < arg1.width) 
                    {
                        loc1 = arg1.getPixel32(loc4, loc3);
                        loc5.writeUnsignedInt((loc1 & 16777215) << 8 | loc1 >>> 24);
                        ++loc4;
                    }
                }
                else 
                {
                    loc4 = 0;
                    while (loc4 < arg1.width) 
                    {
                        loc1 = arg1.getPixel(loc4, loc3);
                        loc5.writeUnsignedInt((loc1 & 16777215) << 8 | 255);
                        ++loc4;
                    }
                }
                ++loc3;
            }
            loc5.compress();
            writeChunk(loc2, 1229209940, loc5);
            writeChunk(loc2, 1229278788, null);
            return loc2;
        }

        internal static function writeChunk(arg1:flash.utils.ByteArray, arg2:uint, arg3:flash.utils.ByteArray):void
        {
            var loc2:*=0;
            var loc7:*=0;
            var loc6:*=0;
            var loc5:*=0;
            if (!crcTableComputed) 
            {
                crcTableComputed = true;
                crcTable = [];
                loc7 = 0;
                while (loc7 < 256) 
                {
                    loc2 = loc7;
                    loc6 = 0;
                    while (loc6 < 8) 
                    {
                        if (loc2 & 1) 
                        {
                            loc2 = 3988292384 ^ loc2 >>> 1;
                        }
                        else 
                        {
                            loc2 = loc2 >>> 1;
                        }
                        ++loc6;
                    }
                    crcTable[loc7] = loc2;
                    ++loc7;
                }
            }
            var loc3:*=0;
            if (arg3 != null) 
            {
                loc3 = arg3.length;
            }
            arg1.writeUnsignedInt(loc3);
            var loc1:*=arg1.position;
            arg1.writeUnsignedInt(arg2);
            if (arg3 != null) 
            {
                arg1.writeBytes(arg3);
            }
            var loc4:*=arg1.position;
            arg1.position = loc1;
            loc2 = 4294967295;
            loc5 = 0;
            while (loc5 < loc4 - loc1) 
            {
                loc2 = crcTable[(loc2 ^ arg1.readUnsignedByte()) & 255] ^ loc2 >>> 8;
                ++loc5;
            }
            loc2 = loc2 ^ 4294967295;
            arg1.position = loc4;
            arg1.writeUnsignedInt(loc2);
            return;
        }

        internal static var crcTable:Array;

        internal static var crcTableComputed:Boolean=false;
    }
}


