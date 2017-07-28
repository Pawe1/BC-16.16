//class CRC32
package nochump.util.zip 
{
    import flash.utils.*;
    
    public class CRC32 extends Object
    {
        public function CRC32()
        {
            super();
            return;
        }

        public function getValue():uint
        {
            return crc & 4294967295;
        }

        public function reset():void
        {
            crc = 0;
            return;
        }

        public function update(arg1:flash.utils.ByteArray):void
        {
            var loc3:*=0;
            var loc2:*=arg1.length;
            var loc1:*=~crc;
            while (--loc2 >= 0) 
            {
                loc1 = crcTable[(loc1 ^ arg1[loc3++]) & 255] ^ loc1 >>> 8;
            }
            crc = ~loc1;
            return;
        }

        internal static function makeCrcTable():Array
        {
            var loc4:*=0;
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=new Array(256);
            loc4 = 0;
            while (loc4 < 256) 
            {
                loc1 = loc4;
                loc2 = 8;
                for (;;) 
                {
                    --loc2;
                    if (!(loc2 >= 0)) 
                    {
                        break;
                    }
                    if ((loc1 & 1) != 0) 
                    {
                        loc1 = 3988292384 ^ loc1 >>> 1;
                        continue;
                    }
                    loc1 = loc1 >>> 1;
                }
                loc3[loc4] = loc1;
                ++loc4;
            }
            return loc3;
        }

        
        {
            crcTable = makeCrcTable();
        }

        internal var crc:uint;

        internal static var crcTable:Array;
    }
}


