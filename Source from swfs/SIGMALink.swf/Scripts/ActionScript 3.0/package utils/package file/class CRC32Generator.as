//class CRC32Generator
package utils.file 
{
    import flash.utils.*;
    
    public class CRC32Generator extends Object
    {
        public function CRC32Generator()
        {
            super();
            return;
        }

        public function generateCRC32(arg1:flash.utils.ByteArray):int
        {
            var loc3:*=0;
            if (!_tableComputed) 
            {
                makeCRCTable();
            }
            var loc1:*=-1;
            var loc2:*=arg1.length;
            loc3 = 0;
            while (loc3 < loc2) 
            {
                loc1 = _crcTable[(loc1 ^ arg1[loc3]) & 255] ^ loc1 >>> 8;
                ++loc3;
            }
            loc1 = ~loc1;
            return loc1 & 4294967295;
        }

        internal static function makeCRCTable():void
        {
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=0;
            _crcTable = new Array(256);
            loc2 = 0;
            while (loc2 < 256) 
            {
                loc1 = loc2;
                loc3 = 0;
                while (loc3 < 8) 
                {
                    if ((loc1 & 1) == 0) 
                    {
                        loc1 = loc1 >>> 1;
                    }
                    else 
                    {
                        loc1 = 3988292384 ^ loc1 >>> 1;
                    }
                    ++loc3;
                }
                _crcTable[loc2] = loc1;
                ++loc2;
            }
            _tableComputed = true;
            return;
        }

        internal static var _crcTable:Array;

        internal static var _tableComputed:Boolean=false;
    }
}


