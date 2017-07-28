//class ChecksumUtil
package utils 
{
    public class ChecksumUtil extends Object
    {
        public function ChecksumUtil()
        {
            super();
            return;
        }

        public static function calculateCrcValue(arg1:Array, arg2:uint=0):uint
        {
            var loc3:*=0;
            var loc2:*=0;
            var loc1:*=arg1.length;
            while (loc3 < loc1) 
            {
                loc2 = loc2 + arg1[loc3];
                ++loc3;
            }
            return (loc2 = loc2 + arg2) & 255;
        }

        public static function addCommandChecksumm(arg1:Array, arg2:uint=0):Array
        {
            arg1.push(calculateCrcValue(arg1, arg2));
            return arg1;
        }
    }
}


