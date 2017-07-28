//package hash
//  class HMAC
package com.hurlant.crypto.hash 
{
    import flash.utils.*;
    
    public class HMAC extends Object
    {
        public function HMAC(arg1:com.hurlant.crypto.hash.IHash, arg2:uint=0)
        {
            super();
            this.hash = arg1;
            this.bits = arg2;
            return;
        }

        public function toString():String
        {
            return "hmac-" + (bits > 0 ? bits + "-" : "") + hash.toString();
        }

        public function getHashSize():uint
        {
            if (bits != 0) 
            {
                return bits / 8;
            }
            return hash.getHashSize();
        }

        public function compute(arg1:flash.utils.ByteArray, arg2:flash.utils.ByteArray):flash.utils.ByteArray
        {
            var loc1:*=null;
            if (arg1.length > hash.getInputSize()) 
            {
                loc1 = hash.hash(arg1);
            }
            else 
            {
                loc1 = new flash.utils.ByteArray();
                loc1.writeBytes(arg1);
            }
            while (loc1.length < hash.getInputSize()) 
            {
                loc1[loc1.length] = 0;
            }
            var loc2:*=new flash.utils.ByteArray();
            var loc3:*=new flash.utils.ByteArray();
            var loc4:*=0;
            while (loc4 < loc1.length) 
            {
                loc2[loc4] = loc1[loc4] ^ 54;
                loc3[loc4] = loc1[loc4] ^ 92;
                ++loc4;
            }
            loc2.position = loc1.length;
            loc2.writeBytes(arg2);
            var loc5:*=hash.hash(loc2);
            loc3.position = loc1.length;
            loc3.writeBytes(loc5);
            var loc6:*=hash.hash(loc3);
            if (bits > 0 && bits < 8 * loc6.length) 
            {
                loc6.length = bits / 8;
            }
            return loc6;
        }

        public function dispose():void
        {
            hash = null;
            bits = 0;
            return;
        }

        internal var bits:uint;

        internal var hash:com.hurlant.crypto.hash.IHash;
    }
}


//  class IHash
package com.hurlant.crypto.hash 
{
    import flash.utils.*;
    
    public interface IHash
    {
        function toString():String;

        function getHashSize():uint;

        function getInputSize():uint;

        function hash(arg1:flash.utils.ByteArray):flash.utils.ByteArray;
    }
}


//  class MD2
package com.hurlant.crypto.hash 
{
    import flash.utils.*;
    
    public class MD2 extends Object implements com.hurlant.crypto.hash.IHash
    {
        public function MD2()
        {
            super();
            return;
        }

        public function toString():String
        {
            return "md2";
        }

        public function getInputSize():uint
        {
            return 16;
        }

        public function getHashSize():uint
        {
            return HASH_SIZE;
        }

        public function hash(arg1:flash.utils.ByteArray):flash.utils.ByteArray
        {
            var loc7:*=0;
            var loc8:*=0;
            var loc9:*=0;
            var loc1:*=arg1.length;
            var loc2:*=16 - arg1.length % 16 || 16;
            do 
            {
                arg1[arg1.length] = loc2;
            }
            while (arg1.length % 16 != 0);
            var loc3:*=arg1.length;
            var loc4:*=new flash.utils.ByteArray();
            var loc5:*=0;
            loc2 = 0;
            while (loc2 < loc3) 
            {
                loc7 = 0;
                while (loc7 < 16) 
                {
                    var loc10:*;
                    loc4[loc7] = loc10 = loc4[loc7] ^ S[arg1[loc2 + loc7] ^ loc5];
                    loc5 = loc10;
                    ++loc7;
                }
                loc2 = loc2 + 16;
            }
            arg1.position = arg1.length;
            arg1.writeBytes(loc4);
            loc3 = loc3 + 16;
            var loc6:*=new flash.utils.ByteArray();
            loc2 = 0;
            while (loc2 < loc3) 
            {
                loc7 = 0;
                while (loc7 < 16) 
                {
                    loc6[16 + loc7] = loc10 = arg1[loc2 + loc7];
                    loc6[32 + loc7] = loc10 ^ loc6[loc7];
                    ++loc7;
                }
                loc8 = 0;
                loc7 = 0;
                while (loc7 < 18) 
                {
                    loc9 = 0;
                    while (loc9 < 48) 
                    {
                        loc8 = loc10 = loc6[loc9] ^ S[loc8];
                        loc6[loc9] = loc10;
                        ++loc9;
                    }
                    loc8 = loc8 + loc7 & 255;
                    ++loc7;
                }
                loc2 = loc2 + 16;
            }
            loc6.length = 16;
            arg1.length = loc1;
            return loc6;
        }

        public static const HASH_SIZE:int=16;

        internal static const S:Array=[41, 46, 67, 201, 162, 216, 124, 1, 61, 54, 84, 161, 236, 240, 6, 19, 98, 167, 5, 243, 192, 199, 115, 140, 152, 147, 43, 217, 188, 76, 130, 202, 30, 155, 87, 60, 253, 212, 224, 22, 103, 66, 111, 24, 138, 23, 229, 18, 190, 78, 196, 214, 218, 158, 222, 73, 160, 251, 245, 142, 187, 47, 238, 122, 169, 104, 121, 145, 21, 178, 7, 63, 148, 194, 16, 137, 11, 34, 95, 33, 128, 127, 93, 154, 90, 144, 50, 39, 53, 62, 204, 231, 191, 247, 151, 3, 255, 25, 48, 179, 72, 165, 181, 209, 215, 94, 146, 42, 172, 86, 170, 198, 79, 184, 56, 210, 150, 164, 125, 182, 118, 252, 107, 226, 156, 116, 4, 241, 69, 157, 112, 89, 100, 113, 135, 32, 134, 91, 207, 101, 230, 45, 168, 2, 27, 96, 37, 173, 174, 176, 185, 246, 28, 70, 97, 105, 52, 64, 126, 15, 85, 71, 163, 35, 221, 81, 175, 58, 195, 92, 249, 206, 186, 197, 234, 38, 44, 83, 13, 110, 133, 40, 132, 9, 211, 223, 205, 244, 65, 129, 77, 82, 106, 220, 55, 200, 108, 193, 171, 250, 36, 225, 123, 8, 12, 189, 177, 74, 120, 136, 149, 139, 227, 99, 232, 109, 233, 203, 213, 254, 59, 0, 29, 57, 242, 239, 183, 14, 102, 88, 208, 228, 166, 119, 114, 248, 235, 117, 75, 10, 49, 68, 80, 180, 143, 237, 31, 26, 219, 153, 141, 51, 159, 17, 131, 20];
    }
}


//  class MD5
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


//  class SHA1
package com.hurlant.crypto.hash 
{
    public class SHA1 extends com.hurlant.crypto.hash.SHABase implements com.hurlant.crypto.hash.IHash
    {
        public function SHA1()
        {
            super();
            return;
        }

        public override function toString():String
        {
            return "sha1";
        }

        protected override function core(arg1:Array, arg2:uint):Array
        {
            var loc8:*=0;
            var loc9:*=0;
            var loc10:*=0;
            var loc11:*=0;
            var loc12:*=0;
            var loc13:*=0;
            var loc14:*=0;
            arg1[arg2 >> 5] = arg1[arg2 >> 5] | 128 << 24 - arg2 % 32;
            arg1[(arg2 + 64 >> 9 << 4) + 15] = arg2;
            var loc1:*=[];
            var loc2:*=1732584193;
            var loc3:*=4023233417;
            var loc4:*=2562383102;
            var loc5:*=271733878;
            var loc6:*=3285377520;
            var loc7:*=0;
            while (loc7 < arg1.length) 
            {
                loc8 = loc2;
                loc9 = loc3;
                loc10 = loc4;
                loc11 = loc5;
                loc12 = loc6;
                loc13 = 0;
                while (loc13 < 80) 
                {
                    if (loc13 < 16) 
                    {
                        loc1[loc13] = arg1[loc7 + loc13] || 0;
                    }
                    else 
                    {
                        loc1[loc13] = rol(loc1[loc13 - 3] ^ loc1[loc13 - 8] ^ loc1[loc13 - 14] ^ loc1[loc13 - 16], 1);
                    }
                    loc14 = rol(loc2, 5) + ft(loc13, loc3, loc4, loc5) + loc6 + loc1[loc13] + kt(loc13);
                    loc6 = loc5;
                    loc5 = loc4;
                    loc4 = rol(loc3, 30);
                    loc3 = loc2;
                    loc2 = loc14;
                    ++loc13;
                }
                loc2 = loc2 + loc8;
                loc3 = loc3 + loc9;
                loc4 = loc4 + loc10;
                loc5 = loc5 + loc11;
                loc6 = loc6 + loc12;
                loc7 = loc7 + 16;
            }
            return [loc2, loc3, loc4, loc5, loc6];
        }

        internal function kt(arg1:uint):uint
        {
            return arg1 < 20 ? 1518500249 : arg1 < 40 ? 1859775393 : arg1 < 60 ? 2400959708 : 3395469782;
        }

        public override function getHashSize():uint
        {
            return HASH_SIZE;
        }

        internal function ft(arg1:uint, arg2:uint, arg3:uint, arg4:uint):uint
        {
            if (arg1 < 20) 
            {
                return arg2 & arg3 | ~arg2 & arg4;
            }
            if (arg1 < 40) 
            {
                return arg2 ^ arg3 ^ arg4;
            }
            if (arg1 < 60) 
            {
                return arg2 & arg3 | arg2 & arg4 | arg3 & arg4;
            }
            return arg2 ^ arg3 ^ arg4;
        }

        internal function rol(arg1:uint, arg2:uint):uint
        {
            return arg1 << arg2 | arg1 >>> 32 - arg2;
        }

        public static const HASH_SIZE:int=20;
    }
}


//  class SHA224
package com.hurlant.crypto.hash 
{
    public class SHA224 extends com.hurlant.crypto.hash.SHA256
    {
        public function SHA224()
        {
            super();
            h = [3238371032, 914150663, 812702999, 4144912697, 4290775857, 1750603025, 1694076839, 3204075428];
            return;
        }

        public override function getHashSize():uint
        {
            return 28;
        }

        public override function toString():String
        {
            return "sha224";
        }
    }
}


//  class SHA256
package com.hurlant.crypto.hash 
{
    public class SHA256 extends com.hurlant.crypto.hash.SHABase implements com.hurlant.crypto.hash.IHash
    {
        public function SHA256()
        {
            h = [1779033703, 3144134277, 1013904242, 2773480762, 1359893119, 2600822924, 528734635, 1541459225];
            super();
            return;
        }

        public override function toString():String
        {
            return "sha256";
        }

        public override function getHashSize():uint
        {
            return 32;
        }

        protected function rrol(arg1:uint, arg2:uint):uint
        {
            return arg1 << 32 - arg2 | arg1 >>> arg2;
        }

        protected override function core(arg1:Array, arg2:uint):Array
        {
            var loc11:*=0;
            var loc12:*=0;
            var loc13:*=0;
            var loc14:*=0;
            var loc15:*=0;
            var loc16:*=0;
            var loc17:*=0;
            var loc18:*=0;
            var loc19:*=0;
            var loc20:*=0;
            var loc21:*=0;
            var loc22:*=0;
            var loc23:*=0;
            arg1[arg2 >> 5] = arg1[arg2 >> 5] | 128 << 24 - arg2 % 32;
            arg1[(arg2 + 64 >> 9 << 4) + 15] = arg2;
            var loc1:*=[];
            var loc2:*=h[0];
            var loc3:*=h[1];
            var loc4:*=h[2];
            var loc5:*=h[3];
            var loc6:*=h[4];
            var loc7:*=h[5];
            var loc8:*=h[6];
            var loc9:*=h[7];
            var loc10:*=0;
            while (loc10 < arg1.length) 
            {
                loc11 = loc2;
                loc12 = loc3;
                loc13 = loc4;
                loc14 = loc5;
                loc15 = loc6;
                loc16 = loc7;
                loc17 = loc8;
                loc18 = loc9;
                loc19 = 0;
                while (loc19 < 64) 
                {
                    if (loc19 < 16) 
                    {
                        loc1[loc19] = arg1[loc10 + loc19] || 0;
                    }
                    else 
                    {
                        loc22 = rrol(loc1[loc19 - 15], 7) ^ rrol(loc1[loc19 - 15], 18) ^ loc1[loc19 - 15] >>> 3;
                        loc23 = rrol(loc1[loc19 - 2], 17) ^ rrol(loc1[loc19 - 2], 19) ^ loc1[loc19 - 2] >>> 10;
                        loc1[loc19] = loc1[loc19 - 16] + loc22 + loc1[loc19 - 7] + loc23;
                    }
                    loc20 = (rrol(loc2, 2) ^ rrol(loc2, 13) ^ rrol(loc2, 22)) + (loc2 & loc3 ^ loc2 & loc4 ^ loc3 & loc4);
                    loc21 = loc9 + (rrol(loc6, 6) ^ rrol(loc6, 11) ^ rrol(loc6, 25)) + (loc6 & loc7 ^ loc8 & ~loc6) + k[loc19] + loc1[loc19];
                    loc9 = loc8;
                    loc8 = loc7;
                    loc7 = loc6;
                    loc6 = loc5 + loc21;
                    loc5 = loc4;
                    loc4 = loc3;
                    loc3 = loc2;
                    loc2 = loc21 + loc20;
                    ++loc19;
                }
                loc2 = loc2 + loc11;
                loc3 = loc3 + loc12;
                loc4 = loc4 + loc13;
                loc5 = loc5 + loc14;
                loc6 = loc6 + loc15;
                loc7 = loc7 + loc16;
                loc8 = loc8 + loc17;
                loc9 = loc9 + loc18;
                loc10 = loc10 + 16;
            }
            return [loc2, loc3, loc4, loc5, loc6, loc7, loc8, loc9];
        }

        protected static const k:Array=[1116352408, 1899447441, 3049323471, 3921009573, 961987163, 1508970993, 2453635748, 2870763221, 3624381080, 310598401, 607225278, 1426881987, 1925078388, 2162078206, 2614888103, 3248222580, 3835390401, 4022224774, 264347078, 604807628, 770255983, 1249150122, 1555081692, 1996064986, 2554220882, 2821834349, 2952996808, 3210313671, 3336571891, 3584528711, 113926993, 338241895, 666307205, 773529912, 1294757372, 1396182291, 1695183700, 1986661051, 2177026350, 2456956037, 2730485921, 2820302411, 3259730800, 3345764771, 3516065817, 3600352804, 4094571909, 275423344, 430227734, 506948616, 659060556, 883997877, 958139571, 1322822218, 1537002063, 1747873779, 1955562222, 2024104815, 2227730452, 2361852424, 2428436474, 2756734187, 3204031479, 3329325298];

        protected var h:Array;
    }
}


//  class SHABase
package com.hurlant.crypto.hash 
{
    import flash.utils.*;
    
    public class SHABase extends Object implements com.hurlant.crypto.hash.IHash
    {
        public function SHABase()
        {
            super();
            return;
        }

        public function toString():String
        {
            return "sha";
        }

        public function getInputSize():uint
        {
            return 64;
        }

        public function getHashSize():uint
        {
            return 0;
        }

        public function hash(arg1:flash.utils.ByteArray):flash.utils.ByteArray
        {
            var loc1:*=arg1.length;
            var loc2:*=arg1.endian;
            arg1.endian = flash.utils.Endian.BIG_ENDIAN;
            var loc3:*=loc1 * 8;
            while (arg1.length % 4 != 0) 
            {
                arg1[arg1.length] = 0;
            }
            arg1.position = 0;
            var loc4:*=[];
            var loc5:*=0;
            while (loc5 < arg1.length) 
            {
                loc4.push(arg1.readUnsignedInt());
                loc5 = loc5 + 4;
            }
            var loc6:*=core(loc4, loc3);
            var loc7:*=new flash.utils.ByteArray();
            var loc8:*=getHashSize() / 4;
            loc5 = 0;
            while (loc5 < loc8) 
            {
                loc7.writeUnsignedInt(loc6[loc5]);
                ++loc5;
            }
            arg1.length = loc1;
            arg1.endian = loc2;
            return loc7;
        }

        protected function core(arg1:Array, arg2:uint):Array
        {
            return null;
        }
    }
}


