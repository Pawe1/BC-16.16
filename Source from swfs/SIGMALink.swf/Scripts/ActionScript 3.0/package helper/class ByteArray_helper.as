//class ByteArray_helper
package helper 
{
    import flash.utils.*;
    
    public class ByteArray_helper extends Object
    {
        public function ByteArray_helper()
        {
            super();
            return;
        }

        public static function toArray(arg1:flash.utils.ByteArray):Array
        {
            var loc1:*=[];
            var loc2:*=0;
            arg1.position = 0;
            while (arg1.bytesAvailable) 
            {
                loc2 = arg1.readUnsignedByte();
                loc1.push(loc2);
            }
            return loc1;
        }

        public static function fromDelimitedString(arg1:String, arg2:String=" "):flash.utils.ByteArray
        {
            return fromArray(arg1.split(arg2));
        }

        public static function fromArray(arg1:Array):flash.utils.ByteArray
        {
            var loc3:*=new flash.utils.ByteArray();
            var loc1:*=arg1.length;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                loc3.writeByte(arg1[loc2]);
                ++loc2;
            }
            return loc3;
        }
    }
}


