//class Base64Decoder
package utils 
{
    import flash.utils.*;
    
    public class Base64Decoder extends Object
    {
        public function Base64Decoder()
        {
            work = [0, 0, 0, 0];
            super();
            data = new flash.utils.ByteArray();
            return;
        }

        public function decode(arg1:String):void
        {
            var loc2:*=0;
            var loc1:*=NaN;
            loc2 = 0;
            while (loc2 < arg1.length) 
            {
                loc1 = arg1.charCodeAt(loc2);
                if (loc1 != 61) 
                {
                    if (inverse[loc1] != 64) 
                    {
                        count = (count + 1);
                        work[count] = inverse[loc1];
                        if (count == 4) 
                        {
                            count = 0;
                            data.writeByte(work[0] << 2 | (work[1] & 255) >> 4);
                            ++filled;
                            if (work[2] == -1) 
                            {
                                break;
                            }
                            data.writeByte(work[1] << 4 | (work[2] & 255) >> 2);
                            ++filled;
                            if (work[3] == -1) 
                            {
                                break;
                            }
                            data.writeByte(work[2] << 6 | work[3]);
                            ++filled;
                        }
                    }
                }
                else 
                {
                    count = (count + 1);
                    work[count] = -1;
                    if (count == 4) 
                    {
                        count = 0;
                        data.writeByte(work[0] << 2 | (work[1] & 255) >> 4);
                        ++filled;
                        if (work[2] == -1) 
                        {
                            break;
                        }
                        data.writeByte(work[1] << 4 | (work[2] & 255) >> 2);
                        ++filled;
                        if (work[3] == -1) 
                        {
                            break;
                        }
                        data.writeByte(work[2] << 6 | work[3]);
                        ++filled;
                    }
                }
                ++loc2;
            }
            return;
        }

        public function drain():flash.utils.ByteArray
        {
            var loc1:*=new flash.utils.ByteArray();
            var loc2:*=data.position;
            data.position = 0;
            loc1.writeBytes(data, 0, data.length);
            data.position = loc2;
            loc1.position = 0;
            filled = 0;
            return loc1;
        }

        public function flush():flash.utils.ByteArray
        {
            if (!(count > 0)) 
            {
            };
            return drain();
        }

        public function reset():void
        {
            data = new flash.utils.ByteArray();
            count = 0;
            filled = 0;
            return;
        }

        public function toByteArray():flash.utils.ByteArray
        {
            var loc1:*=flush();
            reset();
            return loc1;
        }

        internal static const ESCAPE_CHAR_CODE:Number=61;

        internal static const inverse:Array=[64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 62, 64, 64, 64, 63, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 64, 64, 64, 64, 64, 64, 64, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 64, 64, 64, 64, 64, 64, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64];

        internal var count:int=0;

        internal var data:flash.utils.ByteArray;

        internal var filled:int=0;

        internal var work:Array;
    }
}


