//class MD5
package com.hurlant.crypto.hash 
{
    import flash.utils.*;
    
    public class MD5 extends Object implements com.hurlant.crypto.hash.IHash
    {
        public function MD5()
        {
            super();
            return;
        }

        internal function ff(arg1:uint, arg2:uint, arg3:uint, arg4:uint, arg5:uint, arg6:uint, arg7:uint):uint
        {
            return cmn(arg2 & arg3 | ~arg2 & arg4, arg1, arg2, arg5, arg6, arg7);
        }

        internal function cmn(arg1:uint, arg2:uint, arg3:uint, arg4:uint, arg5:uint, arg6:uint):uint
        {
            return rol(arg2 + arg1 + arg4 + arg6, arg5) + arg3;
        }

        internal function hh(arg1:uint, arg2:uint, arg3:uint, arg4:uint, arg5:uint, arg6:uint, arg7:uint):uint
        {
            return cmn(arg2 ^ arg3 ^ arg4, arg1, arg2, arg5, arg6, arg7);
        }

        public function getHashSize():uint
        {
            return HASH_SIZE;
        }

        public function hash(arg1:flash.utils.ByteArray):flash.utils.ByteArray
        {
            var loc1:*=arg1.length * 8;
            var loc2:*=arg1.endian;
            while (arg1.length % 4 != 0) 
            {
                arg1[arg1.length] = 0;
            }
            arg1.position = 0;
            var loc3:*=[];
            arg1.endian = flash.utils.Endian.LITTLE_ENDIAN;
            var loc4:*=0;
            while (loc4 < arg1.length) 
            {
                loc3.push(arg1.readUnsignedInt());
                loc4 = loc4 + 4;
            }
            var loc5:*=core_md5(loc3, loc1);
            var loc6:*=new flash.utils.ByteArray();
            loc6.endian = flash.utils.Endian.LITTLE_ENDIAN;
            loc4 = 0;
            while (loc4 < 4) 
            {
                loc6.writeUnsignedInt(loc5[loc4]);
                ++loc4;
            }
            arg1.length = loc1 / 8;
            arg1.endian = loc2;
            return loc6;
        }

        internal function gg(arg1:uint, arg2:uint, arg3:uint, arg4:uint, arg5:uint, arg6:uint, arg7:uint):uint
        {
            return cmn(arg2 & arg4 | arg3 & ~arg4, arg1, arg2, arg5, arg6, arg7);
        }

        public function toString():String
        {
            return "md5";
        }

        public function getInputSize():uint
        {
            return 64;
        }

        internal function rol(arg1:uint, arg2:uint):uint
        {
            return arg1 << arg2 | arg1 >>> 32 - arg2;
        }

        internal function ii(arg1:uint, arg2:uint, arg3:uint, arg4:uint, arg5:uint, arg6:uint, arg7:uint):uint
        {
            return cmn(arg3 ^ (arg2 | ~arg4), arg1, arg2, arg5, arg6, arg7);
        }

        internal function core_md5(arg1:Array, arg2:uint):Array
        {
            var loc6:*=0;
            var loc7:*=0;
            var loc8:*=0;
            var loc9:*=0;
            arg1[arg2 >> 5] = arg1[arg2 >> 5] | 128 << arg2 % 32;
            arg1[(arg2 + 64 >>> 9 << 4) + 14] = arg2;
            var loc1:*=1732584193;
            var loc2:*=4023233417;
            var loc3:*=2562383102;
            var loc4:*=271733878;
            var loc5:*=0;
            while (loc5 < arg1.length) 
            {
                arg1[loc5] = arg1[loc5] || 0;
                arg1[loc5 + 1] = arg1[loc5 + 1] || 0;
                arg1[loc5 + 2] = arg1[loc5 + 2] || 0;
                arg1[loc5 + 3] = arg1[loc5 + 3] || 0;
                arg1[loc5 + 4] = arg1[loc5 + 4] || 0;
                arg1[loc5 + 5] = arg1[loc5 + 5] || 0;
                arg1[loc5 + 6] = arg1[loc5 + 6] || 0;
                arg1[loc5 + 7] = arg1[loc5 + 7] || 0;
                arg1[loc5 + 8] = arg1[loc5 + 8] || 0;
                arg1[loc5 + 9] = arg1[loc5 + 9] || 0;
                arg1[loc5 + 10] = arg1[loc5 + 10] || 0;
                arg1[loc5 + 11] = arg1[loc5 + 11] || 0;
                arg1[loc5 + 12] = arg1[loc5 + 12] || 0;
                arg1[loc5 + 13] = arg1[loc5 + 13] || 0;
                arg1[loc5 + 14] = arg1[loc5 + 14] || 0;
                arg1[loc5 + 15] = arg1[loc5 + 15] || 0;
                loc6 = loc1;
                loc7 = loc2;
                loc8 = loc3;
                loc9 = loc4;
                loc1 = ff(loc1, loc2, loc3, loc4, arg1[loc5 + 0], 7, 3614090360);
                loc4 = ff(loc4, loc1, loc2, loc3, arg1[loc5 + 1], 12, 3905402710);
                loc3 = ff(loc3, loc4, loc1, loc2, arg1[loc5 + 2], 17, 606105819);
                loc2 = ff(loc2, loc3, loc4, loc1, arg1[loc5 + 3], 22, 3250441966);
                loc1 = ff(loc1, loc2, loc3, loc4, arg1[loc5 + 4], 7, 4118548399);
                loc4 = ff(loc4, loc1, loc2, loc3, arg1[loc5 + 5], 12, 1200080426);
                loc3 = ff(loc3, loc4, loc1, loc2, arg1[loc5 + 6], 17, 2821735955);
                loc2 = ff(loc2, loc3, loc4, loc1, arg1[loc5 + 7], 22, 4249261313);
                loc1 = ff(loc1, loc2, loc3, loc4, arg1[loc5 + 8], 7, 1770035416);
                loc4 = ff(loc4, loc1, loc2, loc3, arg1[loc5 + 9], 12, 2336552879);
                loc3 = ff(loc3, loc4, loc1, loc2, arg1[loc5 + 10], 17, 4294925233);
                loc2 = ff(loc2, loc3, loc4, loc1, arg1[loc5 + 11], 22, 2304563134);
                loc1 = ff(loc1, loc2, loc3, loc4, arg1[loc5 + 12], 7, 1804603682);
                loc4 = ff(loc4, loc1, loc2, loc3, arg1[loc5 + 13], 12, 4254626195);
                loc3 = ff(loc3, loc4, loc1, loc2, arg1[loc5 + 14], 17, 2792965006);
                loc2 = ff(loc2, loc3, loc4, loc1, arg1[loc5 + 15], 22, 1236535329);
                loc1 = gg(loc1, loc2, loc3, loc4, arg1[loc5 + 1], 5, 4129170786);
                loc4 = gg(loc4, loc1, loc2, loc3, arg1[loc5 + 6], 9, 3225465664);
                loc3 = gg(loc3, loc4, loc1, loc2, arg1[loc5 + 11], 14, 643717713);
                loc2 = gg(loc2, loc3, loc4, loc1, arg1[loc5 + 0], 20, 3921069994);
                loc1 = gg(loc1, loc2, loc3, loc4, arg1[loc5 + 5], 5, 3593408605);
                loc4 = gg(loc4, loc1, loc2, loc3, arg1[loc5 + 10], 9, 38016083);
                loc3 = gg(loc3, loc4, loc1, loc2, arg1[loc5 + 15], 14, 3634488961);
                loc2 = gg(loc2, loc3, loc4, loc1, arg1[loc5 + 4], 20, 3889429448);
                loc1 = gg(loc1, loc2, loc3, loc4, arg1[loc5 + 9], 5, 568446438);
                loc4 = gg(loc4, loc1, loc2, loc3, arg1[loc5 + 14], 9, 3275163606);
                loc3 = gg(loc3, loc4, loc1, loc2, arg1[loc5 + 3], 14, 4107603335);
                loc2 = gg(loc2, loc3, loc4, loc1, arg1[loc5 + 8], 20, 1163531501);
                loc1 = gg(loc1, loc2, loc3, loc4, arg1[loc5 + 13], 5, 2850285829);
                loc4 = gg(loc4, loc1, loc2, loc3, arg1[loc5 + 2], 9, 4243563512);
                loc3 = gg(loc3, loc4, loc1, loc2, arg1[loc5 + 7], 14, 1735328473);
                loc2 = gg(loc2, loc3, loc4, loc1, arg1[loc5 + 12], 20, 2368359562);
                loc1 = hh(loc1, loc2, loc3, loc4, arg1[loc5 + 5], 4, 4294588738);
                loc4 = hh(loc4, loc1, loc2, loc3, arg1[loc5 + 8], 11, 2272392833);
                loc3 = hh(loc3, loc4, loc1, loc2, arg1[loc5 + 11], 16, 1839030562);
                loc2 = hh(loc2, loc3, loc4, loc1, arg1[loc5 + 14], 23, 4259657740);
                loc1 = hh(loc1, loc2, loc3, loc4, arg1[loc5 + 1], 4, 2763975236);
                loc4 = hh(loc4, loc1, loc2, loc3, arg1[loc5 + 4], 11, 1272893353);
                loc3 = hh(loc3, loc4, loc1, loc2, arg1[loc5 + 7], 16, 4139469664);
                loc2 = hh(loc2, loc3, loc4, loc1, arg1[loc5 + 10], 23, 3200236656);
                loc1 = hh(loc1, loc2, loc3, loc4, arg1[loc5 + 13], 4, 681279174);
                loc4 = hh(loc4, loc1, loc2, loc3, arg1[loc5 + 0], 11, 3936430074);
                loc3 = hh(loc3, loc4, loc1, loc2, arg1[loc5 + 3], 16, 3572445317);
                loc2 = hh(loc2, loc3, loc4, loc1, arg1[loc5 + 6], 23, 76029189);
                loc1 = hh(loc1, loc2, loc3, loc4, arg1[loc5 + 9], 4, 3654602809);
                loc4 = hh(loc4, loc1, loc2, loc3, arg1[loc5 + 12], 11, 3873151461);
                loc3 = hh(loc3, loc4, loc1, loc2, arg1[loc5 + 15], 16, 530742520);
                loc2 = hh(loc2, loc3, loc4, loc1, arg1[loc5 + 2], 23, 3299628645);
                loc1 = ii(loc1, loc2, loc3, loc4, arg1[loc5 + 0], 6, 4096336452);
                loc4 = ii(loc4, loc1, loc2, loc3, arg1[loc5 + 7], 10, 1126891415);
                loc3 = ii(loc3, loc4, loc1, loc2, arg1[loc5 + 14], 15, 2878612391);
                loc2 = ii(loc2, loc3, loc4, loc1, arg1[loc5 + 5], 21, 4237533241);
                loc1 = ii(loc1, loc2, loc3, loc4, arg1[loc5 + 12], 6, 1700485571);
                loc4 = ii(loc4, loc1, loc2, loc3, arg1[loc5 + 3], 10, 2399980690);
                loc3 = ii(loc3, loc4, loc1, loc2, arg1[loc5 + 10], 15, 4293915773);
                loc2 = ii(loc2, loc3, loc4, loc1, arg1[loc5 + 1], 21, 2240044497);
                loc1 = ii(loc1, loc2, loc3, loc4, arg1[loc5 + 8], 6, 1873313359);
                loc4 = ii(loc4, loc1, loc2, loc3, arg1[loc5 + 15], 10, 4264355552);
                loc3 = ii(loc3, loc4, loc1, loc2, arg1[loc5 + 6], 15, 2734768916);
                loc2 = ii(loc2, loc3, loc4, loc1, arg1[loc5 + 13], 21, 1309151649);
                loc1 = ii(loc1, loc2, loc3, loc4, arg1[loc5 + 4], 6, 4149444226);
                loc4 = ii(loc4, loc1, loc2, loc3, arg1[loc5 + 11], 10, 3174756917);
                loc3 = ii(loc3, loc4, loc1, loc2, arg1[loc5 + 2], 15, 718787259);
                loc2 = ii(loc2, loc3, loc4, loc1, arg1[loc5 + 9], 21, 3951481745);
                loc1 = loc1 + loc6;
                loc2 = loc2 + loc7;
                loc3 = loc3 + loc8;
                loc4 = loc4 + loc9;
                loc5 = loc5 + 16;
            }
            return [loc1, loc2, loc3, loc4];
        }

        public static const HASH_SIZE:int=16;
    }
}


