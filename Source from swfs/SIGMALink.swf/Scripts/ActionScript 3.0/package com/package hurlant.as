//package hurlant
//  package crypto
//    package hash
//      class HMAC
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


//      class IHash
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


//      class MD2
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


//      class MD5
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


//      class SHA1
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


//      class SHA224
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


//      class SHA256
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


//      class SHABase
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


//    package prng
//      class ARC4
package com.hurlant.crypto.prng 
{
    import com.hurlant.crypto.symmetric.*;
    import com.hurlant.util.*;
    import flash.utils.*;
    
    public class ARC4 extends Object implements com.hurlant.crypto.prng.IPRNG, com.hurlant.crypto.symmetric.IStreamCipher
    {
        public function ARC4(arg1:flash.utils.ByteArray=null)
        {
            super();
            S = new flash.utils.ByteArray();
            if (arg1) 
            {
                init(arg1);
            }
            return;
        }

        public function decrypt(arg1:flash.utils.ByteArray):void
        {
            encrypt(arg1);
            return;
        }

        public function init(arg1:flash.utils.ByteArray):void
        {
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=0;
            loc1 = 0;
            while (loc1 < 256) 
            {
                S[loc1] = loc1;
                ++loc1;
            }
            loc2 = 0;
            loc1 = 0;
            while (loc1 < 256) 
            {
                loc2 = loc2 + S[loc1] + arg1[loc1 % arg1.length] & 255;
                loc3 = S[loc1];
                S[loc1] = S[loc2];
                S[loc2] = loc3;
                ++loc1;
            }
            this.i = 0;
            this.j = 0;
            return;
        }

        public function next():uint
        {
            var loc1:*=0;
            i = i + 1 & 255;
            j = j + S[i] & 255;
            loc1 = S[i];
            S[i] = S[j];
            S[j] = loc1;
            return S[loc1 + S[i] & 255];
        }

        public function encrypt(arg1:flash.utils.ByteArray):void
        {
            var loc1:*=0;
            while (loc1 < arg1.length) 
            {
                var loc2:*=loc1++;
                arg1[loc2] = arg1[loc2] ^ next();
            }
            return;
        }

        public function dispose():void
        {
            var loc1:*=0;
            if (S != null) 
            {
                loc1 = 0;
                while (loc1 < S.length) 
                {
                    S[loc1] = Math.random() * 256;
                    ++loc1;
                }
                S.length = 0;
                S = null;
            }
            this.i = 0;
            this.j = 0;
            com.hurlant.util.Memory.gc();
            return;
        }

        public function getBlockSize():uint
        {
            return 1;
        }

        public function getPoolSize():uint
        {
            return psize;
        }

        public function toString():String
        {
            return "rc4";
        }

        internal const psize:uint=256;

        internal var S:flash.utils.ByteArray;

        internal var i:int=0;

        internal var j:int=0;
    }
}


//      class IPRNG
package com.hurlant.crypto.prng 
{
    import flash.utils.*;
    
    public interface IPRNG
    {
        function init(arg1:flash.utils.ByteArray):void;

        function next():uint;

        function getPoolSize():uint;

        function toString():String;

        function dispose():void;
    }
}


//      class Random
package com.hurlant.crypto.prng 
{
    import com.hurlant.util.*;
    import flash.system.*;
    import flash.text.*;
    import flash.utils.*;
    
    public class Random extends Object
    {
        public function Random(arg1:Class=null)
        {
            var loc1:*=0;
            super();
            if (arg1 == null) 
            {
                arg1 = com.hurlant.crypto.prng.ARC4;
            }
            state = new arg1() as com.hurlant.crypto.prng.IPRNG;
            psize = state.getPoolSize();
            pool = new flash.utils.ByteArray();
            pptr = 0;
            while (pptr < psize) 
            {
                loc1 = 65536 * Math.random();
                var loc3:*;
                var loc2:*=pptr++;
                pool[loc2] = loc1 >>> 8;
                pool[loc3 = pptr++] = loc1 & 255;
            }
            pptr = 0;
            seed();
            return;
        }

        public function autoSeed():void
        {
            var loc3:*=null;
            var loc1:*=new flash.utils.ByteArray();
            loc1.writeUnsignedInt(flash.system.System.totalMemory);
            loc1.writeUTF(flash.system.Capabilities.serverString);
            loc1.writeUnsignedInt(flash.utils.getTimer());
            loc1.writeUnsignedInt(new Date().getTime());
            var loc2:*=flash.text.Font.enumerateFonts(true);
            var loc4:*=0;
            var loc5:*=loc2;
            for each (loc3 in loc5) 
            {
                loc1.writeUTF(loc3.fontName);
                loc1.writeUTF(loc3.fontStyle);
                loc1.writeUTF(loc3.fontType);
            }
            loc1.position = 0;
            while (loc1.bytesAvailable >= 4) 
            {
                seed(loc1.readUnsignedInt());
            }
            return;
        }

        public function seed(arg1:int=0):void
        {
            if (arg1 == 0) 
            {
                arg1 = new Date().getTime();
            }
            var loc2:*;
            var loc1:*=pptr++;
            pool[loc1] = pool[loc1] ^ arg1 & 255;
            loc2 = pptr++;
            pool[loc2] = pool[loc2] ^ arg1 >> 8 & 255;
            pool[loc3 = pptr++] = pool[loc3] ^ arg1 >> 16 & 255;
            pool[loc4 = pptr++] = pool[loc4] ^ arg1 >> 24 & 255;
            pptr = pptr % psize;
            seeded = true;
            return;
        }

        public function toString():String
        {
            return "random-" + state.toString();
        }

        public function dispose():void
        {
            var loc1:*=0;
            while (loc1 < pool.length) 
            {
                pool[loc1] = Math.random() * 256;
                ++loc1;
            }
            pool.length = 0;
            pool = null;
            state.dispose();
            state = null;
            psize = 0;
            pptr = 0;
            com.hurlant.util.Memory.gc();
            return;
        }

        public function nextBytes(arg1:flash.utils.ByteArray, arg2:int):void
        {
            while (arg2--) 
            {
                arg1.writeByte(nextByte());
            }
            return;
        }

        public function nextByte():int
        {
            if (!ready) 
            {
                if (!seeded) 
                {
                    autoSeed();
                }
                state.init(pool);
                pool.length = 0;
                pptr = 0;
                ready = true;
            }
            return state.next();
        }

        internal var ready:Boolean=false;

        internal var pool:flash.utils.ByteArray;

        internal var seeded:Boolean=false;

        internal var psize:int;

        internal var state:com.hurlant.crypto.prng.IPRNG;

        internal var pptr:int;
    }
}


//    package rsa
//      class RSAKey
package com.hurlant.crypto.rsa 
{
    import com.hurlant.crypto.prng.*;
    import com.hurlant.math.*;
    import com.hurlant.util.*;
    import flash.utils.*;
    
    public class RSAKey extends Object
    {
        public function RSAKey(arg1:com.hurlant.math.BigInteger, arg2:int, arg3:com.hurlant.math.BigInteger=null, arg4:com.hurlant.math.BigInteger=null, arg5:com.hurlant.math.BigInteger=null, arg6:com.hurlant.math.BigInteger=null, arg7:com.hurlant.math.BigInteger=null, arg8:com.hurlant.math.BigInteger=null)
        {
            super();
            this.n = arg1;
            this.e = arg2;
            this.d = arg3;
            this.p = arg4;
            this.q = arg5;
            this.dmp1 = arg6;
            this.dmq1 = arg7;
            this.coeff = arg8;
            canEncrypt = !(n == null) && !(e == 0);
            canDecrypt = canEncrypt && !(d == null);
            return;
        }

        public function verify(arg1:flash.utils.ByteArray, arg2:flash.utils.ByteArray, arg3:uint, arg4:Function=null):void
        {
            _decrypt(doPublic, arg1, arg2, arg3, arg4, 1);
            return;
        }

        protected function doPrivate2(arg1:com.hurlant.math.BigInteger):com.hurlant.math.BigInteger
        {
            if (p == null && q == null) 
            {
                return arg1.modPow(d, n);
            }
            var loc1:*=arg1.mod(p).modPow(dmp1, p);
            var loc2:*=arg1.mod(q).modPow(dmq1, q);
            while (loc1.compareTo(loc2) < 0) 
            {
                loc1 = loc1.add(p);
            }
            var loc3:*=loc1.subtract(loc2).multiply(coeff).mod(p).multiply(q).add(loc2);
            return loc3;
        }

        public function dump():String
        {
            var loc1:*="N=" + n.toString(16) + "\n" + "E=" + e.toString(16) + "\n";
            if (canDecrypt) 
            {
                loc1 = loc1 + ("D=" + d.toString(16) + "\n");
                if (!(p == null) && !(q == null)) 
                {
                    loc1 = loc1 + ("P=" + p.toString(16) + "\n");
                    loc1 = loc1 + ("Q=" + q.toString(16) + "\n");
                    loc1 = loc1 + ("DMP1=" + dmp1.toString(16) + "\n");
                    loc1 = loc1 + ("DMQ1=" + dmq1.toString(16) + "\n");
                    loc1 = loc1 + ("IQMP=" + coeff.toString(16) + "\n");
                }
            }
            return loc1;
        }

        public function decrypt(arg1:flash.utils.ByteArray, arg2:flash.utils.ByteArray, arg3:uint, arg4:Function=null):void
        {
            _decrypt(doPrivate2, arg1, arg2, arg3, arg4, 2);
            return;
        }

        internal function _decrypt(arg1:Function, arg2:flash.utils.ByteArray, arg3:flash.utils.ByteArray, arg4:uint, arg5:Function, arg6:int):void
        {
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=null;
            if (arg5 == null) 
            {
                arg5 = pkcs1unpad;
            }
            if (arg2.position >= arg2.length) 
            {
                arg2.position = 0;
            }
            var loc1:*=getBlockSize();
            var loc2:*=arg2.position + arg4;
            while (arg2.position < loc2) 
            {
                loc3 = new com.hurlant.math.BigInteger(arg2, arg4);
                loc4 = arg1(loc3);
                loc5 = arg5(loc4, loc1);
                arg3.writeBytes(loc5);
            }
            return;
        }

        protected function doPublic(arg1:com.hurlant.math.BigInteger):com.hurlant.math.BigInteger
        {
            return arg1.modPowInt(e, n);
        }

        public function dispose():void
        {
            e = 0;
            n.dispose();
            n = null;
            com.hurlant.util.Memory.gc();
            return;
        }

        internal function _encrypt(arg1:Function, arg2:flash.utils.ByteArray, arg3:flash.utils.ByteArray, arg4:uint, arg5:Function, arg6:int):void
        {
            var loc3:*=null;
            var loc4:*=null;
            if (arg5 == null) 
            {
                arg5 = pkcs1pad;
            }
            if (arg2.position >= arg2.length) 
            {
                arg2.position = 0;
            }
            var loc1:*=getBlockSize();
            var loc2:*=arg2.position + arg4;
            while (arg2.position < loc2) 
            {
                loc3 = new com.hurlant.math.BigInteger(arg5(arg2, loc2, loc1, arg6), loc1);
                loc4 = arg1(loc3);
                loc4.toArray(arg3);
            }
            return;
        }

        internal function rawpad(arg1:flash.utils.ByteArray, arg2:int, arg3:uint):flash.utils.ByteArray
        {
            return arg1;
        }

        public function encrypt(arg1:flash.utils.ByteArray, arg2:flash.utils.ByteArray, arg3:uint, arg4:Function=null):void
        {
            _encrypt(doPublic, arg1, arg2, arg3, arg4, 2);
            return;
        }

        internal function pkcs1pad(arg1:flash.utils.ByteArray, arg2:int, arg3:uint, arg4:uint=2):flash.utils.ByteArray
        {
            var loc5:*=0;
            var loc1:*=new flash.utils.ByteArray();
            var loc2:*=arg1.position;
            arg2 = Math.min(arg2, arg1.length, loc2 + arg3 - 11);
            arg1.position = arg2;
            var loc3:*;
            --loc3;
            while (loc3 >= loc2 && arg3 > 11) 
            {
                var loc6:*;
                loc1[loc6 = --arg3] = arg1[loc3--];
            }
            loc1[loc6 = --arg3] = 0;
            var loc4:*=new com.hurlant.crypto.prng.Random();
            while (arg3 > 2) 
            {
                loc5 = 0;
                while (loc5 == 0) 
                {
                    loc5 = arg4 != 2 ? 255 : loc4.nextByte();
                }
                var loc7:*;
                loc1[loc7 = --arg3] = loc5;
            }
            loc1[loc7 = --arg3] = arg4;
            var loc8:*;
            loc1[loc8 = --arg3] = 0;
            return loc1;
        }

        internal function pkcs1unpad(arg1:com.hurlant.math.BigInteger, arg2:uint, arg3:uint=2):flash.utils.ByteArray
        {
            var loc1:*=arg1.toByteArray();
            var loc2:*=new flash.utils.ByteArray();
            var loc3:*=0;
            while (loc3 < loc1.length && loc1[loc3] == 0) 
            {
                ++loc3;
            }
            if (!(loc1.length - loc3 == (arg2 - 1)) || loc1[loc3] > 2) 
            {
                trace("PKCS#1 unpad: i=" + loc3 + ", expected b[i]==[0,1,2], got b[i]=" + loc1[loc3].toString(16));
                return null;
            }
            ++loc3;
            while (loc1[loc3] != 0) 
            {
                if (!(++loc3 >= loc1.length)) 
                {
                    continue;
                }
                trace("PKCS#1 unpad: i=" + loc3 + ", b[i-1]!=0 (=" + loc1[(loc3 - 1)].toString(16) + ")");
                return null;
            }
            while (++loc3 < loc1.length) 
            {
                loc2.writeByte(loc1[loc3]);
            }
            loc2.position = 0;
            return loc2;
        }

        public function getBlockSize():uint
        {
            return (n.bitLength() + 7) / 8;
        }

        public function toString():String
        {
            return "rsa";
        }

        public function sign(arg1:flash.utils.ByteArray, arg2:flash.utils.ByteArray, arg3:uint, arg4:Function=null):void
        {
            _encrypt(doPrivate2, arg1, arg2, arg3, arg4, 1);
            return;
        }

        protected function doPrivate(arg1:com.hurlant.math.BigInteger):com.hurlant.math.BigInteger
        {
            if (p == null || q == null) 
            {
                return arg1.modPow(d, n);
            }
            var loc1:*=arg1.mod(p).modPow(dmp1, p);
            var loc2:*=arg1.mod(q).modPow(dmq1, q);
            while (loc1.compareTo(loc2) < 0) 
            {
                loc1 = loc1.add(p);
            }
            return loc1.subtract(loc2).multiply(coeff).mod(p).multiply(q).add(loc2);
        }

        protected static function bigRandom(arg1:int, arg2:com.hurlant.crypto.prng.Random):com.hurlant.math.BigInteger
        {
            if (arg1 < 2) 
            {
                return com.hurlant.math.BigInteger.nbv(1);
            }
            var loc1:*=new flash.utils.ByteArray();
            arg2.nextBytes(loc1, arg1 >> 3);
            loc1.position = 0;
            var loc2:*=new com.hurlant.math.BigInteger(loc1);
            loc2.primify(arg1, 1);
            return loc2;
        }

        public static function parsePublicKey(arg1:String, arg2:String):com.hurlant.crypto.rsa.RSAKey
        {
            return new RSAKey(new com.hurlant.math.BigInteger(arg1, 16), parseInt(arg2, 16));
        }

        public static function generate(arg1:uint, arg2:String):com.hurlant.crypto.rsa.RSAKey
        {
            var loc5:*=null;
            var loc6:*=null;
            var loc7:*=null;
            var loc8:*=null;
            var loc1:*=new com.hurlant.crypto.prng.Random();
            var loc2:*=arg1 >> 1;
            var loc3:*=new RSAKey(null, 0, null);
            loc3.e = parseInt(arg2, 16);
            var loc4:*=new com.hurlant.math.BigInteger(arg2, 16);
            for (;;) 
            {
                for (;;) 
                {
                    loc3.p = bigRandom(arg1 - loc2, loc1);
                    if (loc3.p.subtract(com.hurlant.math.BigInteger.ONE).gcd(loc4).compareTo(com.hurlant.math.BigInteger.ONE) == 0 && loc3.p.isProbablePrime(10)) 
                    {
                        break;
                    }
                }
                for (;;) 
                {
                    loc3.q = bigRandom(loc2, loc1);
                    if (loc3.q.subtract(com.hurlant.math.BigInteger.ONE).gcd(loc4).compareTo(com.hurlant.math.BigInteger.ONE) == 0 && loc3.q.isProbablePrime(10)) 
                    {
                        break;
                    }
                }
                if (loc3.p.compareTo(loc3.q) <= 0) 
                {
                    loc8 = loc3.p;
                    loc3.p = loc3.q;
                    loc3.q = loc8;
                }
                loc5 = loc3.p.subtract(com.hurlant.math.BigInteger.ONE);
                loc6 = loc3.q.subtract(com.hurlant.math.BigInteger.ONE);
                loc7 = loc5.multiply(loc6);
                if (loc7.gcd(loc4).compareTo(com.hurlant.math.BigInteger.ONE) != 0) 
                {
                    continue;
                }
                loc3.n = loc3.p.multiply(loc3.q);
                loc3.d = loc4.modInverse(loc7);
                loc3.dmp1 = loc3.d.mod(loc5);
                loc3.dmq1 = loc3.d.mod(loc6);
                loc3.coeff = loc3.q.modInverse(loc3.p);
                break;
            }
            return loc3;
        }

        public static function parsePrivateKey(arg1:String, arg2:String, arg3:String, arg4:String=null, arg5:String=null, arg6:String=null, arg7:String=null, arg8:String=null):com.hurlant.crypto.rsa.RSAKey
        {
            if (arg4 == null) 
            {
                return new RSAKey(new com.hurlant.math.BigInteger(arg1, 16), parseInt(arg2, 16), new com.hurlant.math.BigInteger(arg3, 16));
            }
            return new RSAKey(new com.hurlant.math.BigInteger(arg1, 16), parseInt(arg2, 16), new com.hurlant.math.BigInteger(arg3, 16), new com.hurlant.math.BigInteger(arg4, 16), new com.hurlant.math.BigInteger(arg5, 16), new com.hurlant.math.BigInteger(arg6, 16), new com.hurlant.math.BigInteger(arg7), new com.hurlant.math.BigInteger(arg8));
        }

        public var dmp1:com.hurlant.math.BigInteger;

        protected var canDecrypt:Boolean;

        public var d:com.hurlant.math.BigInteger;

        public var e:int;

        public var dmq1:com.hurlant.math.BigInteger;

        public var n:com.hurlant.math.BigInteger;

        public var p:com.hurlant.math.BigInteger;

        public var q:com.hurlant.math.BigInteger;

        protected var canEncrypt:Boolean;

        public var coeff:com.hurlant.math.BigInteger;
    }
}


//    package symmetric
//      class AESKey
package com.hurlant.crypto.symmetric 
{
    import com.hurlant.crypto.prng.*;
    import com.hurlant.util.*;
    import flash.utils.*;
    
    public class AESKey extends Object implements com.hurlant.crypto.symmetric.ISymmetricKey
    {
        public function AESKey(arg1:flash.utils.ByteArray)
        {
            super();
            tmp = new flash.utils.ByteArray();
            state = new flash.utils.ByteArray();
            keyLength = arg1.length;
            this.key = new flash.utils.ByteArray();
            this.key.writeBytes(arg1);
            expandKey();
            return;
        }

        public function toString():String
        {
            return "aes" + 8 * keyLength;
        }

        public function decrypt(arg1:flash.utils.ByteArray, arg2:uint=0):void
        {
            var loc1:*=0;
            state.position = 0;
            state.writeBytes(arg1, arg2, Nb * 4);
            addRoundKey(key, Nr * Nb * 4);
            invShiftRows();
            loc1 = Nr;
            while (loc1--) 
            {
                addRoundKey(key, loc1 * Nb * 4);
                if (!loc1) 
                {
                    continue;
                }
                invMixSubColumns();
            }
            arg1.position = arg2;
            arg1.writeBytes(state);
            return;
        }

        protected function invMixSubColumns():void
        {
            var loc1:*=0;
            tmp.length = 0;
            tmp[0] = XtimeE[state[0]] ^ XtimeB[state[1]] ^ XtimeD[state[2]] ^ Xtime9[state[3]];
            tmp[5] = Xtime9[state[0]] ^ XtimeE[state[1]] ^ XtimeB[state[2]] ^ XtimeD[state[3]];
            tmp[10] = XtimeD[state[0]] ^ Xtime9[state[1]] ^ XtimeE[state[2]] ^ XtimeB[state[3]];
            tmp[15] = XtimeB[state[0]] ^ XtimeD[state[1]] ^ Xtime9[state[2]] ^ XtimeE[state[3]];
            tmp[4] = XtimeE[state[4]] ^ XtimeB[state[5]] ^ XtimeD[state[6]] ^ Xtime9[state[7]];
            tmp[9] = Xtime9[state[4]] ^ XtimeE[state[5]] ^ XtimeB[state[6]] ^ XtimeD[state[7]];
            tmp[14] = XtimeD[state[4]] ^ Xtime9[state[5]] ^ XtimeE[state[6]] ^ XtimeB[state[7]];
            tmp[3] = XtimeB[state[4]] ^ XtimeD[state[5]] ^ Xtime9[state[6]] ^ XtimeE[state[7]];
            tmp[8] = XtimeE[state[8]] ^ XtimeB[state[9]] ^ XtimeD[state[10]] ^ Xtime9[state[11]];
            tmp[13] = Xtime9[state[8]] ^ XtimeE[state[9]] ^ XtimeB[state[10]] ^ XtimeD[state[11]];
            tmp[2] = XtimeD[state[8]] ^ Xtime9[state[9]] ^ XtimeE[state[10]] ^ XtimeB[state[11]];
            tmp[7] = XtimeB[state[8]] ^ XtimeD[state[9]] ^ Xtime9[state[10]] ^ XtimeE[state[11]];
            tmp[12] = XtimeE[state[12]] ^ XtimeB[state[13]] ^ XtimeD[state[14]] ^ Xtime9[state[15]];
            tmp[1] = Xtime9[state[12]] ^ XtimeE[state[13]] ^ XtimeB[state[14]] ^ XtimeD[state[15]];
            tmp[6] = XtimeD[state[12]] ^ Xtime9[state[13]] ^ XtimeE[state[14]] ^ XtimeB[state[15]];
            tmp[11] = XtimeB[state[12]] ^ XtimeD[state[13]] ^ Xtime9[state[14]] ^ XtimeE[state[15]];
            loc1 = 0;
            while (loc1 < 4 * Nb) 
            {
                state[loc1] = InvSbox[tmp[loc1]];
                ++loc1;
            }
            return;
        }

        
        {
            _Rcon = [0, 1, 2, 4, 8, 16, 32, 64, 128, 27, 54];
            Sbox = new flash.utils.ByteArray();
            InvSbox = new flash.utils.ByteArray();
            Xtime2Sbox = new flash.utils.ByteArray();
            Xtime3Sbox = new flash.utils.ByteArray();
            Xtime2 = new flash.utils.ByteArray();
            Xtime9 = new flash.utils.ByteArray();
            XtimeB = new flash.utils.ByteArray();
            XtimeD = new flash.utils.ByteArray();
            XtimeE = new flash.utils.ByteArray();
            i = 0;
            while (i < 256) 
            {
                Sbox[i] = _Sbox[i];
                InvSbox[i] = _InvSbox[i];
                Xtime2Sbox[i] = _Xtime2Sbox[i];
                Xtime3Sbox[i] = _Xtime3Sbox[i];
                Xtime2[i] = _Xtime2[i];
                Xtime9[i] = _Xtime9[i];
                XtimeB[i] = _XtimeB[i];
                XtimeD[i] = _XtimeD[i];
                XtimeE[i] = _XtimeE[i];
                var loc1:*;
                i++;
            }
            Rcon = new flash.utils.ByteArray();
            i = 0;
            while (i < _Rcon.length) 
            {
                Rcon[i] = _Rcon[i];
                i++;
            }
        }

        protected function mixSubColumns():void
        {
            tmp.length = 0;
            tmp[0] = Xtime2Sbox[state[0]] ^ Xtime3Sbox[state[5]] ^ Sbox[state[10]] ^ Sbox[state[15]];
            tmp[1] = Sbox[state[0]] ^ Xtime2Sbox[state[5]] ^ Xtime3Sbox[state[10]] ^ Sbox[state[15]];
            tmp[2] = Sbox[state[0]] ^ Sbox[state[5]] ^ Xtime2Sbox[state[10]] ^ Xtime3Sbox[state[15]];
            tmp[3] = Xtime3Sbox[state[0]] ^ Sbox[state[5]] ^ Sbox[state[10]] ^ Xtime2Sbox[state[15]];
            tmp[4] = Xtime2Sbox[state[4]] ^ Xtime3Sbox[state[9]] ^ Sbox[state[14]] ^ Sbox[state[3]];
            tmp[5] = Sbox[state[4]] ^ Xtime2Sbox[state[9]] ^ Xtime3Sbox[state[14]] ^ Sbox[state[3]];
            tmp[6] = Sbox[state[4]] ^ Sbox[state[9]] ^ Xtime2Sbox[state[14]] ^ Xtime3Sbox[state[3]];
            tmp[7] = Xtime3Sbox[state[4]] ^ Sbox[state[9]] ^ Sbox[state[14]] ^ Xtime2Sbox[state[3]];
            tmp[8] = Xtime2Sbox[state[8]] ^ Xtime3Sbox[state[13]] ^ Sbox[state[2]] ^ Sbox[state[7]];
            tmp[9] = Sbox[state[8]] ^ Xtime2Sbox[state[13]] ^ Xtime3Sbox[state[2]] ^ Sbox[state[7]];
            tmp[10] = Sbox[state[8]] ^ Sbox[state[13]] ^ Xtime2Sbox[state[2]] ^ Xtime3Sbox[state[7]];
            tmp[11] = Xtime3Sbox[state[8]] ^ Sbox[state[13]] ^ Sbox[state[2]] ^ Xtime2Sbox[state[7]];
            tmp[12] = Xtime2Sbox[state[12]] ^ Xtime3Sbox[state[1]] ^ Sbox[state[6]] ^ Sbox[state[11]];
            tmp[13] = Sbox[state[12]] ^ Xtime2Sbox[state[1]] ^ Xtime3Sbox[state[6]] ^ Sbox[state[11]];
            tmp[14] = Sbox[state[12]] ^ Sbox[state[1]] ^ Xtime2Sbox[state[6]] ^ Xtime3Sbox[state[11]];
            tmp[15] = Xtime3Sbox[state[12]] ^ Sbox[state[1]] ^ Sbox[state[6]] ^ Xtime2Sbox[state[11]];
            state.position = 0;
            state.writeBytes(tmp, 0, Nb * 4);
            return;
        }

        protected function invShiftRows():void
        {
            var loc1:*=0;
            state[0] = InvSbox[state[0]];
            state[4] = InvSbox[state[4]];
            state[8] = InvSbox[state[8]];
            state[12] = InvSbox[state[12]];
            loc1 = InvSbox[state[13]];
            state[13] = InvSbox[state[9]];
            state[9] = InvSbox[state[5]];
            state[5] = InvSbox[state[1]];
            state[1] = loc1;
            loc1 = InvSbox[state[2]];
            state[2] = InvSbox[state[10]];
            state[10] = loc1;
            loc1 = InvSbox[state[6]];
            state[6] = InvSbox[state[14]];
            state[14] = loc1;
            loc1 = InvSbox[state[3]];
            state[3] = InvSbox[state[7]];
            state[7] = InvSbox[state[11]];
            state[11] = InvSbox[state[15]];
            state[15] = loc1;
            return;
        }

        protected function shiftRows():void
        {
            var loc1:*=0;
            state[0] = Sbox[state[0]];
            state[4] = Sbox[state[4]];
            state[8] = Sbox[state[8]];
            state[12] = Sbox[state[12]];
            loc1 = Sbox[state[1]];
            state[1] = Sbox[state[5]];
            state[5] = Sbox[state[9]];
            state[9] = Sbox[state[13]];
            state[13] = loc1;
            loc1 = Sbox[state[2]];
            state[2] = Sbox[state[10]];
            state[10] = loc1;
            loc1 = Sbox[state[6]];
            state[6] = Sbox[state[14]];
            state[14] = loc1;
            loc1 = Sbox[state[15]];
            state[15] = Sbox[state[11]];
            state[11] = Sbox[state[7]];
            state[7] = Sbox[state[3]];
            state[3] = loc1;
            return;
        }

        public function getBlockSize():uint
        {
            return 16;
        }

        public function dispose():void
        {
            var loc1:*=0;
            var loc2:*=new com.hurlant.crypto.prng.Random();
            loc1 = 0;
            while (loc1 < key.length) 
            {
                key[loc1] = loc2.nextByte();
                ++loc1;
            }
            Nr = loc2.nextByte();
            loc1 = 0;
            while (loc1 < state.length) 
            {
                state[loc1] = loc2.nextByte();
                ++loc1;
            }
            loc1 = 0;
            while (loc1 < tmp.length) 
            {
                tmp[loc1] = loc2.nextByte();
                ++loc1;
            }
            key.length = 0;
            keyLength = 0;
            state.length = 0;
            tmp.length = 0;
            key = null;
            state = null;
            tmp = null;
            Nr = 0;
            com.hurlant.util.Memory.gc();
            return;
        }

        internal function expandKey():void
        {
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=0;
            var loc5:*=0;
            var loc6:*=0;
            var loc7:*=key.length / 4;
            Nr = loc7 + 6;
            loc6 = loc7;
            while (loc6 < Nb * (Nr + 1)) 
            {
                loc1 = key[4 * loc6 - 4];
                loc2 = key[4 * loc6 - 3];
                loc3 = key[4 * loc6 - 2];
                loc4 = key[(4 * loc6 - 1)];
                if (loc6 % loc7) 
                {
                    if (loc7 > 6 && loc6 % loc7 == 4) 
                    {
                        loc1 = Sbox[loc1];
                        loc2 = Sbox[loc2];
                        loc3 = Sbox[loc3];
                        loc4 = Sbox[loc4];
                    }
                }
                else 
                {
                    loc5 = loc4;
                    loc4 = Sbox[loc1];
                    loc1 = Sbox[loc2] ^ Rcon[loc6 / loc7];
                    loc2 = Sbox[loc3];
                    loc3 = Sbox[loc5];
                }
                key[4 * loc6 + 0] = key[4 * loc6 - 4 * loc7 + 0] ^ loc1;
                key[4 * loc6 + 1] = key[4 * loc6 - 4 * loc7 + 1] ^ loc2;
                key[4 * loc6 + 2] = key[4 * loc6 - 4 * loc7 + 2] ^ loc3;
                key[4 * loc6 + 3] = key[4 * loc6 - 4 * loc7 + 3] ^ loc4;
                ++loc6;
            }
            return;
        }

        protected function addRoundKey(arg1:flash.utils.ByteArray, arg2:uint):void
        {
            var loc1:*=0;
            loc1 = 0;
            while (loc1 < 16) 
            {
                state[loc1] = state[loc1] ^ arg1[loc1 + arg2];
                ++loc1;
            }
            return;
        }

        public function encrypt(arg1:flash.utils.ByteArray, arg2:uint=0):void
        {
            var loc1:*=0;
            state.position = 0;
            state.writeBytes(arg1, arg2, Nb * 4);
            addRoundKey(key, 0);
            loc1 = 1;
            while (loc1 < Nr + 1) 
            {
                if (loc1 < Nr) 
                {
                    mixSubColumns();
                }
                else 
                {
                    shiftRows();
                }
                addRoundKey(key, loc1 * Nb * 4);
                ++loc1;
            }
            arg1.position = arg2;
            arg1.writeBytes(state);
            return;
        }

        internal static const _Xtime2:Array=[0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 52, 54, 56, 58, 60, 62, 64, 66, 68, 70, 72, 74, 76, 78, 80, 82, 84, 86, 88, 90, 92, 94, 96, 98, 100, 102, 104, 106, 108, 110, 112, 114, 116, 118, 120, 122, 124, 126, 128, 130, 132, 134, 136, 138, 140, 142, 144, 146, 148, 150, 152, 154, 156, 158, 160, 162, 164, 166, 168, 170, 172, 174, 176, 178, 180, 182, 184, 186, 188, 190, 192, 194, 196, 198, 200, 202, 204, 206, 208, 210, 212, 214, 216, 218, 220, 222, 224, 226, 228, 230, 232, 234, 236, 238, 240, 242, 244, 246, 248, 250, 252, 254, 27, 25, 31, 29, 19, 17, 23, 21, 11, 9, 15, 13, 3, 1, 7, 5, 59, 57, 63, 61, 51, 49, 55, 53, 43, 41, 47, 45, 35, 33, 39, 37, 91, 89, 95, 93, 83, 81, 87, 85, 75, 73, 79, 77, 67, 65, 71, 69, 123, 121, 127, 125, 115, 113, 119, 117, 107, 105, 111, 109, 99, 97, 103, 101, 155, 153, 159, 157, 147, 145, 151, 149, 139, 137, 143, 141, 131, 129, 135, 133, 187, 185, 191, 189, 179, 177, 183, 181, 171, 169, 175, 173, 163, 161, 167, 165, 219, 217, 223, 221, 211, 209, 215, 213, 203, 201, 207, 205, 195, 193, 199, 197, 251, 249, 255, 253, 243, 241, 247, 245, 235, 233, 239, 237, 227, 225, 231, 229];

        internal static const _Xtime9:Array=[0, 9, 18, 27, 36, 45, 54, 63, 72, 65, 90, 83, 108, 101, 126, 119, 144, 153, 130, 139, 180, 189, 166, 175, 216, 209, 202, 195, 252, 245, 238, 231, 59, 50, 41, 32, 31, 22, 13, 4, 115, 122, 97, 104, 87, 94, 69, 76, 171, 162, 185, 176, 143, 134, 157, 148, 227, 234, 241, 248, 199, 206, 213, 220, 118, 127, 100, 109, 82, 91, 64, 73, 62, 55, 44, 37, 26, 19, 8, 1, 230, 239, 244, 253, 194, 203, 208, 217, 174, 167, 188, 181, 138, 131, 152, 145, 77, 68, 95, 86, 105, 96, 123, 114, 5, 12, 23, 30, 33, 40, 51, 58, 221, 212, 207, 198, 249, 240, 235, 226, 149, 156, 135, 142, 177, 184, 163, 170, 236, 229, 254, 247, 200, 193, 218, 211, 164, 173, 182, 191, 128, 137, 146, 155, 124, 117, 110, 103, 88, 81, 74, 67, 52, 61, 38, 47, 16, 25, 2, 11, 215, 222, 197, 204, 243, 250, 225, 232, 159, 150, 141, 132, 187, 178, 169, 160, 71, 78, 85, 92, 99, 106, 113, 120, 15, 6, 29, 20, 43, 34, 57, 48, 154, 147, 136, 129, 190, 183, 172, 165, 210, 219, 192, 201, 246, 255, 228, 237, 10, 3, 24, 17, 46, 39, 60, 53, 66, 75, 80, 89, 102, 111, 116, 125, 161, 168, 179, 186, 133, 140, 151, 158, 233, 224, 251, 242, 205, 196, 223, 214, 49, 56, 35, 42, 21, 28, 7, 14, 121, 112, 107, 98, 93, 84, 79, 70];

        internal static const Nb:uint=4;

        internal static const _XtimeB:Array=[0, 11, 22, 29, 44, 39, 58, 49, 88, 83, 78, 69, 116, 127, 98, 105, 176, 187, 166, 173, 156, 151, 138, 129, 232, 227, 254, 245, 196, 207, 210, 217, 123, 112, 109, 102, 87, 92, 65, 74, 35, 40, 53, 62, 15, 4, 25, 18, 203, 192, 221, 214, 231, 236, 241, 250, 147, 152, 133, 142, 191, 180, 169, 162, 246, 253, 224, 235, 218, 209, 204, 199, 174, 165, 184, 179, 130, 137, 148, 159, 70, 77, 80, 91, 106, 97, 124, 119, 30, 21, 8, 3, 50, 57, 36, 47, 141, 134, 155, 144, 161, 170, 183, 188, 213, 222, 195, 200, 249, 242, 239, 228, 61, 54, 43, 32, 17, 26, 7, 12, 101, 110, 115, 120, 73, 66, 95, 84, 247, 252, 225, 234, 219, 208, 205, 198, 175, 164, 185, 178, 131, 136, 149, 158, 71, 76, 81, 90, 107, 96, 125, 118, 31, 20, 9, 2, 51, 56, 37, 46, 140, 135, 154, 145, 160, 171, 182, 189, 212, 223, 194, 201, 248, 243, 238, 229, 60, 55, 42, 33, 16, 27, 6, 13, 100, 111, 114, 121, 72, 67, 94, 85, 1, 10, 23, 28, 45, 38, 59, 48, 89, 82, 79, 68, 117, 126, 99, 104, 177, 186, 167, 172, 157, 150, 139, 128, 233, 226, 255, 244, 197, 206, 211, 216, 122, 113, 108, 103, 86, 93, 64, 75, 34, 41, 52, 63, 14, 5, 24, 19, 202, 193, 220, 215, 230, 237, 240, 251, 146, 153, 132, 143, 190, 181, 168, 163];

        internal static const _XtimeE:Array=[0, 14, 28, 18, 56, 54, 36, 42, 112, 126, 108, 98, 72, 70, 84, 90, 224, 238, 252, 242, 216, 214, 196, 202, 144, 158, 140, 130, 168, 166, 180, 186, 219, 213, 199, 201, 227, 237, 255, 241, 171, 165, 183, 185, 147, 157, 143, 129, 59, 53, 39, 41, 3, 13, 31, 17, 75, 69, 87, 89, 115, 125, 111, 97, 173, 163, 177, 191, 149, 155, 137, 135, 221, 211, 193, 207, 229, 235, 249, 247, 77, 67, 81, 95, 117, 123, 105, 103, 61, 51, 33, 47, 5, 11, 25, 23, 118, 120, 106, 100, 78, 64, 82, 92, 6, 8, 26, 20, 62, 48, 34, 44, 150, 152, 138, 132, 174, 160, 178, 188, 230, 232, 250, 244, 222, 208, 194, 204, 65, 79, 93, 83, 121, 119, 101, 107, 49, 63, 45, 35, 9, 7, 21, 27, 161, 175, 189, 179, 153, 151, 133, 139, 209, 223, 205, 195, 233, 231, 245, 251, 154, 148, 134, 136, 162, 172, 190, 176, 234, 228, 246, 248, 210, 220, 206, 192, 122, 116, 102, 104, 66, 76, 94, 80, 10, 4, 22, 24, 50, 60, 46, 32, 236, 226, 240, 254, 212, 218, 200, 198, 156, 146, 128, 142, 164, 170, 184, 182, 12, 2, 16, 30, 52, 58, 40, 38, 124, 114, 96, 110, 68, 74, 88, 86, 55, 57, 43, 37, 15, 1, 19, 29, 71, 73, 91, 85, 127, 113, 99, 109, 215, 217, 203, 197, 239, 225, 243, 253, 167, 169, 187, 181, 159, 145, 131, 141];

        internal static const _Xtime2Sbox:Array=[198, 248, 238, 246, 255, 214, 222, 145, 96, 2, 206, 86, 231, 181, 77, 236, 143, 31, 137, 250, 239, 178, 142, 251, 65, 179, 95, 69, 35, 83, 228, 155, 117, 225, 61, 76, 108, 126, 245, 131, 104, 81, 209, 249, 226, 171, 98, 42, 8, 149, 70, 157, 48, 55, 10, 47, 14, 36, 27, 223, 205, 78, 127, 234, 18, 29, 88, 52, 54, 220, 180, 91, 164, 118, 183, 125, 82, 221, 94, 19, 166, 185, 0, 193, 64, 227, 121, 182, 212, 141, 103, 114, 148, 152, 176, 133, 187, 197, 79, 237, 134, 154, 102, 17, 138, 233, 4, 254, 160, 120, 37, 75, 162, 93, 128, 5, 63, 33, 112, 241, 99, 119, 175, 66, 32, 229, 253, 191, 129, 24, 38, 195, 190, 53, 136, 46, 147, 85, 252, 122, 200, 186, 50, 230, 192, 25, 158, 163, 68, 84, 59, 11, 140, 199, 107, 40, 167, 188, 22, 173, 219, 100, 116, 20, 146, 12, 72, 184, 159, 189, 67, 196, 57, 49, 211, 242, 213, 139, 110, 218, 1, 177, 156, 73, 216, 172, 243, 207, 202, 244, 71, 16, 111, 240, 74, 92, 56, 87, 115, 151, 203, 161, 232, 62, 150, 97, 13, 15, 224, 124, 113, 204, 144, 6, 247, 28, 194, 106, 174, 105, 23, 153, 58, 39, 217, 235, 43, 34, 210, 169, 7, 51, 45, 60, 21, 201, 135, 170, 80, 165, 3, 89, 9, 26, 101, 215, 132, 208, 130, 41, 90, 30, 123, 168, 109, 44];

        internal static const _Xtime3Sbox:Array=[165, 132, 153, 141, 13, 189, 177, 84, 80, 3, 169, 125, 25, 98, 230, 154, 69, 157, 64, 135, 21, 235, 201, 11, 236, 103, 253, 234, 191, 247, 150, 91, 194, 28, 174, 106, 90, 65, 2, 79, 92, 244, 52, 8, 147, 115, 83, 63, 12, 82, 101, 94, 40, 161, 15, 181, 9, 54, 155, 61, 38, 105, 205, 159, 27, 158, 116, 46, 45, 178, 238, 251, 246, 77, 97, 206, 123, 62, 113, 151, 245, 104, 0, 44, 96, 31, 200, 237, 190, 70, 217, 75, 222, 212, 232, 74, 107, 42, 229, 22, 197, 215, 85, 148, 207, 16, 6, 129, 240, 68, 186, 227, 243, 254, 192, 138, 173, 188, 72, 4, 223, 193, 117, 99, 48, 26, 14, 109, 76, 20, 53, 47, 225, 162, 204, 57, 87, 242, 130, 71, 172, 231, 43, 149, 160, 152, 209, 127, 102, 126, 171, 131, 202, 41, 211, 60, 121, 226, 29, 118, 59, 86, 78, 30, 219, 10, 108, 228, 93, 110, 239, 166, 168, 164, 55, 139, 50, 67, 89, 183, 140, 100, 210, 224, 180, 250, 7, 37, 175, 142, 233, 24, 213, 136, 111, 114, 36, 241, 199, 81, 35, 124, 156, 33, 221, 220, 134, 133, 144, 66, 196, 170, 216, 5, 1, 18, 163, 95, 249, 208, 145, 88, 39, 185, 56, 19, 179, 51, 187, 112, 137, 167, 182, 34, 146, 32, 73, 255, 120, 122, 143, 248, 128, 23, 218, 49, 198, 184, 195, 176, 119, 17, 203, 252, 214, 58];

        internal static const _InvSbox:Array=[82, 9, 106, 213, 48, 54, 165, 56, 191, 64, 163, 158, 129, 243, 215, 251, 124, 227, 57, 130, 155, 47, 255, 135, 52, 142, 67, 68, 196, 222, 233, 203, 84, 123, 148, 50, 166, 194, 35, 61, 238, 76, 149, 11, 66, 250, 195, 78, 8, 46, 161, 102, 40, 217, 36, 178, 118, 91, 162, 73, 109, 139, 209, 37, 114, 248, 246, 100, 134, 104, 152, 22, 212, 164, 92, 204, 93, 101, 182, 146, 108, 112, 72, 80, 253, 237, 185, 218, 94, 21, 70, 87, 167, 141, 157, 132, 144, 216, 171, 0, 140, 188, 211, 10, 247, 228, 88, 5, 184, 179, 69, 6, 208, 44, 30, 143, 202, 63, 15, 2, 193, 175, 189, 3, 1, 19, 138, 107, 58, 145, 17, 65, 79, 103, 220, 234, 151, 242, 207, 206, 240, 180, 230, 115, 150, 172, 116, 34, 231, 173, 53, 133, 226, 249, 55, 232, 28, 117, 223, 110, 71, 241, 26, 113, 29, 41, 197, 137, 111, 183, 98, 14, 170, 24, 190, 27, 252, 86, 62, 75, 198, 210, 121, 32, 154, 219, 192, 254, 120, 205, 90, 244, 31, 221, 168, 51, 136, 7, 199, 49, 177, 18, 16, 89, 39, 128, 236, 95, 96, 81, 127, 169, 25, 181, 74, 13, 45, 229, 122, 159, 147, 201, 156, 239, 160, 224, 59, 77, 174, 42, 245, 176, 200, 235, 187, 60, 131, 83, 153, 97, 23, 43, 4, 126, 186, 119, 214, 38, 225, 105, 20, 99, 85, 33, 12, 125];

        internal static const _XtimeD:Array=[0, 13, 26, 23, 52, 57, 46, 35, 104, 101, 114, 127, 92, 81, 70, 75, 208, 221, 202, 199, 228, 233, 254, 243, 184, 181, 162, 175, 140, 129, 150, 155, 187, 182, 161, 172, 143, 130, 149, 152, 211, 222, 201, 196, 231, 234, 253, 240, 107, 102, 113, 124, 95, 82, 69, 72, 3, 14, 25, 20, 55, 58, 45, 32, 109, 96, 119, 122, 89, 84, 67, 78, 5, 8, 31, 18, 49, 60, 43, 38, 189, 176, 167, 170, 137, 132, 147, 158, 213, 216, 207, 194, 225, 236, 251, 246, 214, 219, 204, 193, 226, 239, 248, 245, 190, 179, 164, 169, 138, 135, 144, 157, 6, 11, 28, 17, 50, 63, 40, 37, 110, 99, 116, 121, 90, 87, 64, 77, 218, 215, 192, 205, 238, 227, 244, 249, 178, 191, 168, 165, 134, 139, 156, 145, 10, 7, 16, 29, 62, 51, 36, 41, 98, 111, 120, 117, 86, 91, 76, 65, 97, 108, 123, 118, 85, 88, 79, 66, 9, 4, 19, 30, 61, 48, 39, 42, 177, 188, 171, 166, 133, 136, 159, 146, 217, 212, 195, 206, 237, 224, 247, 250, 183, 186, 173, 160, 131, 142, 153, 148, 223, 210, 197, 200, 235, 230, 241, 252, 103, 106, 125, 112, 83, 94, 73, 68, 15, 2, 21, 24, 59, 54, 33, 44, 12, 1, 22, 27, 56, 53, 34, 47, 100, 105, 126, 115, 80, 93, 74, 71, 220, 209, 198, 203, 232, 229, 242, 255, 180, 185, 174, 163, 128, 141, 154, 151];

        internal static const _Sbox:Array=[99, 124, 119, 123, 242, 107, 111, 197, 48, 1, 103, 43, 254, 215, 171, 118, 202, 130, 201, 125, 250, 89, 71, 240, 173, 212, 162, 175, 156, 164, 114, 192, 183, 253, 147, 38, 54, 63, 247, 204, 52, 165, 229, 241, 113, 216, 49, 21, 4, 199, 35, 195, 24, 150, 5, 154, 7, 18, 128, 226, 235, 39, 178, 117, 9, 131, 44, 26, 27, 110, 90, 160, 82, 59, 214, 179, 41, 227, 47, 132, 83, 209, 0, 237, 32, 252, 177, 91, 106, 203, 190, 57, 74, 76, 88, 207, 208, 239, 170, 251, 67, 77, 51, 133, 69, 249, 2, 127, 80, 60, 159, 168, 81, 163, 64, 143, 146, 157, 56, 245, 188, 182, 218, 33, 16, 255, 243, 210, 205, 12, 19, 236, 95, 151, 68, 23, 196, 167, 126, 61, 100, 93, 25, 115, 96, 129, 79, 220, 34, 42, 144, 136, 70, 238, 184, 20, 222, 94, 11, 219, 224, 50, 58, 10, 73, 6, 36, 92, 194, 211, 172, 98, 145, 149, 228, 121, 231, 200, 55, 109, 141, 213, 78, 169, 108, 86, 244, 234, 101, 122, 174, 8, 186, 120, 37, 46, 28, 166, 180, 198, 232, 221, 116, 31, 75, 189, 139, 138, 112, 62, 181, 102, 72, 3, 246, 14, 97, 53, 87, 185, 134, 193, 29, 158, 225, 248, 152, 17, 105, 217, 142, 148, 155, 30, 135, 233, 206, 85, 40, 223, 140, 161, 137, 13, 191, 230, 66, 104, 65, 153, 45, 15, 176, 84, 187, 22];

        internal var state:flash.utils.ByteArray;

        internal var tmp:flash.utils.ByteArray;

        internal var Nr:uint;

        internal var keyLength:uint;

        internal var key:flash.utils.ByteArray;

        internal static var XtimeE:flash.utils.ByteArray;

        internal static var i:uint;

        internal static var Xtime2Sbox:flash.utils.ByteArray;

        internal static var _Rcon:Array;

        internal static var Sbox:flash.utils.ByteArray;

        internal static var Rcon:flash.utils.ByteArray;

        internal static var InvSbox:flash.utils.ByteArray;

        internal static var Xtime2:flash.utils.ByteArray;

        internal static var Xtime9:flash.utils.ByteArray;

        internal static var XtimeB:flash.utils.ByteArray;

        internal static var XtimeD:flash.utils.ByteArray;

        internal static var Xtime3Sbox:flash.utils.ByteArray;
    }
}


//      class BlowFishKey
package com.hurlant.crypto.symmetric 
{
    import com.hurlant.util.*;
    import flash.utils.*;
    
    public class BlowFishKey extends Object implements com.hurlant.crypto.symmetric.ISymmetricKey
    {
        public function BlowFishKey(arg1:flash.utils.ByteArray)
        {
            super();
            this.key = arg1;
            setKey(arg1);
            return;
        }

        internal function F(arg1:uint):uint
        {
            return (S0[arg1 >>> 24] + S1[arg1 >>> 16 & 255] ^ S2[arg1 >>> 8 & 255]) + S3[arg1 & 255];
        }

        internal function BytesTo32bits(arg1:flash.utils.ByteArray, arg2:uint):uint
        {
            return (arg1[arg2] & 255) << 24 | (arg1[arg2 + 1] & 255) << 16 | (arg1[arg2 + 2] & 255) << 8 | arg1[arg2 + 3] & 255;
        }

        internal function decryptBlock(arg1:flash.utils.ByteArray, arg2:uint, arg3:flash.utils.ByteArray, arg4:uint):void
        {
            var loc1:*=BytesTo32bits(arg1, arg2);
            var loc2:*=BytesTo32bits(arg1, arg2 + 4);
            loc1 = loc1 ^ P[ROUNDS + 1];
            var loc3:*=ROUNDS;
            while (loc3 > 0) 
            {
                loc2 = loc2 ^ F(loc1) ^ P[loc3];
                loc1 = loc1 ^ F(loc2) ^ P[(loc3 - 1)];
                loc3 = loc3 - 2;
            }
            loc2 = loc2 ^ P[0];
            Bits32ToBytes(loc2, arg3, arg4);
            Bits32ToBytes(loc1, arg3, arg4 + 4);
            return;
        }

        public function decrypt(arg1:flash.utils.ByteArray, arg2:uint=0):void
        {
            decryptBlock(arg1, arg2, arg1, arg2);
            return;
        }

        public function getBlockSize():uint
        {
            return BLOCK_SIZE;
        }

        internal function setKey(arg1:flash.utils.ByteArray):void
        {
            var loc4:*=0;
            var loc5:*=0;
            S0 = KS0.concat();
            S1 = KS1.concat();
            S2 = KS2.concat();
            S3 = KS3.concat();
            P = KP.concat();
            var loc1:*=arg1.length;
            var loc2:*=0;
            var loc3:*=0;
            while (loc3 < P_SZ) 
            {
                loc4 = 0;
                loc5 = 0;
                while (loc5 < 4) 
                {
                    loc4 = loc4 << 8 | arg1[loc2++] & 255;
                    if (loc2 >= loc1) 
                    {
                        loc2 = 0;
                    }
                    ++loc5;
                }
                P[loc3] = P[loc3] ^ loc4;
                ++loc3;
            }
            processTable(0, 0, P);
            processTable(P[P_SZ - 2], P[(P_SZ - 1)], S0);
            processTable(S0[SBOX_SK - 2], S0[(SBOX_SK - 1)], S1);
            processTable(S1[SBOX_SK - 2], S1[(SBOX_SK - 1)], S2);
            processTable(S2[SBOX_SK - 2], S2[(SBOX_SK - 1)], S3);
            return;
        }

        internal function processTable(arg1:uint, arg2:uint, arg3:Array):void
        {
            var loc3:*=0;
            var loc1:*=arg3.length;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                arg1 = arg1 ^ P[0];
                loc3 = 1;
                while (loc3 < ROUNDS) 
                {
                    arg2 = arg2 ^ F(arg1) ^ P[loc3];
                    arg1 = arg1 ^ F(arg2) ^ P[loc3 + 1];
                    loc3 = loc3 + 2;
                }
                arg2 = arg2 ^ P[ROUNDS + 1];
                arg3[loc2] = arg2;
                arg3[loc2 + 1] = arg1;
                arg2 = arg1;
                arg1 = arg3[loc2];
                loc2 = loc2 + 2;
            }
            return;
        }

        public function encrypt(arg1:flash.utils.ByteArray, arg2:uint=0):void
        {
            encryptBlock(arg1, arg2, arg1, arg2);
            return;
        }

        public function dispose():void
        {
            var loc1:*=0;
            loc1 = 0;
            while (loc1 < S0.length) 
            {
                S0[loc1] = 0;
                ++loc1;
            }
            loc1 = 0;
            while (loc1 < S1.length) 
            {
                S1[loc1] = 0;
                ++loc1;
            }
            loc1 = 0;
            while (loc1 < S2.length) 
            {
                S2[loc1] = 0;
                ++loc1;
            }
            loc1 = 0;
            while (loc1 < S3.length) 
            {
                S3[loc1] = 0;
                ++loc1;
            }
            loc1 = 0;
            while (loc1 < P.length) 
            {
                P[loc1] = 0;
                ++loc1;
            }
            S0 = null;
            S1 = null;
            S2 = null;
            S3 = null;
            P = null;
            loc1 = 0;
            while (loc1 < key.length) 
            {
                key[loc1] = 0;
                ++loc1;
            }
            key.length = 0;
            key = null;
            com.hurlant.util.Memory.gc();
            return;
        }

        internal function encryptBlock(arg1:flash.utils.ByteArray, arg2:uint, arg3:flash.utils.ByteArray, arg4:uint):void
        {
            var loc1:*=BytesTo32bits(arg1, arg2);
            var loc2:*=BytesTo32bits(arg1, arg2 + 4);
            loc1 = loc1 ^ P[0];
            var loc3:*=1;
            while (loc3 < ROUNDS) 
            {
                loc2 = loc2 ^ F(loc1) ^ P[loc3];
                loc1 = loc1 ^ F(loc2) ^ P[loc3 + 1];
                loc3 = loc3 + 2;
            }
            loc2 = loc2 ^ P[ROUNDS + 1];
            Bits32ToBytes(loc2, arg3, arg4);
            Bits32ToBytes(loc1, arg3, arg4 + 4);
            return;
        }

        internal function Bits32ToBytes(arg1:uint, arg2:flash.utils.ByteArray, arg3:uint):void
        {
            arg2[arg3 + 3] = arg1;
            arg2[arg3 + 2] = arg1 >> 8;
            arg2[arg3 + 1] = arg1 >> 16;
            arg2[arg3] = arg1 >> 24;
            return;
        }

        public function toString():String
        {
            return "blowfish";
        }

        internal static const KP:Array=[608135816, 2242054355, 320440878, 57701188, 2752067618, 698298832, 137296536, 3964562569, 1160258022, 953160567, 3193202383, 887688300, 3232508343, 3380367581, 1065670069, 3041331479, 2450970073, 2306472731];

        internal static const KS0:Array=[3509652390, 2564797868, 805139163, 3491422135, 3101798381, 1780907670, 3128725573, 4046225305, 614570311, 3012652279, 134345442, 2240740374, 1667834072, 1901547113, 2757295779, 4103290238, 227898511, 1921955416, 1904987480, 2182433518, 2069144605, 3260701109, 2620446009, 720527379, 3318853667, 677414384, 3393288472, 3101374703, 2390351024, 1614419982, 1822297739, 2954791486, 3608508353, 3174124327, 2024746970, 1432378464, 3864339955, 2857741204, 1464375394, 1676153920, 1439316330, 715854006, 3033291828, 289532110, 2706671279, 2087905683, 3018724369, 1668267050, 732546397, 1947742710, 3462151702, 2609353502, 2950085171, 1814351708, 2050118529, 680887927, 999245976, 1800124847, 3300911131, 1713906067, 1641548236, 4213287313, 1216130144, 1575780402, 4018429277, 3917837745, 3693486850, 3949271944, 596196993, 3549867205, 258830323, 2213823033, 772490370, 2760122372, 1774776394, 2652871518, 566650946, 4142492826, 1728879713, 2882767088, 1783734482, 3629395816, 2517608232, 2874225571, 1861159788, 326777828, 3124490320, 2130389656, 2716951837, 967770486, 1724537150, 2185432712, 2364442137, 1164943284, 2105845187, 998989502, 3765401048, 2244026483, 1075463327, 1455516326, 1322494562, 910128902, 469688178, 1117454909, 936433444, 3490320968, 3675253459, 1240580251, 122909385, 2157517691, 634681816, 4142456567, 3825094682, 3061402683, 2540495037, 79693498, 3249098678, 1084186820, 1583128258, 426386531, 1761308591, 1047286709, 322548459, 995290223, 1845252383, 2603652396, 3431023940, 2942221577, 3202600964, 3727903485, 1712269319, 422464435, 3234572375, 1170764815, 3523960633, 3117677531, 1434042557, 442511882, 3600875718, 1076654713, 1738483198, 4213154764, 2393238008, 3677496056, 1014306527, 4251020053, 793779912, 2902807211, 842905082, 4246964064, 1395751752, 1040244610, 2656851899, 3396308128, 445077038, 3742853595, 3577915638, 679411651, 2892444358, 2354009459, 1767581616, 3150600392, 3791627101, 3102740896, 284835224, 4246832056, 1258075500, 768725851, 2589189241, 3069724005, 3532540348, 1274779536, 3789419226, 2764799539, 1660621633, 3471099624, 4011903706, 913787905, 3497959166, 737222580, 2514213453, 2928710040, 3937242737, 1804850592, 3499020752, 2949064160, 2386320175, 2390070455, 2415321851, 4061277028, 2290661394, 2416832540, 1336762016, 1754252060, 3520065937, 3014181293, 791618072, 3188594551, 3933548030, 2332172193, 3852520463, 3043980520, 413987798, 3465142937, 3030929376, 4245938359, 2093235073, 3534596313, 375366246, 2157278981, 2479649556, 555357303, 3870105701, 2008414854, 3344188149, 4221384143, 3956125452, 2067696032, 3594591187, 2921233993, 2428461, 544322398, 577241275, 1471733935, 610547355, 4027169054, 1432588573, 1507829418, 2025931657, 3646575487, 545086370, 48609733, 2200306550, 1653985193, 298326376, 1316178497, 3007786442, 2064951626, 458293330, 2589141269, 3591329599, 3164325604, 727753846, 2179363840, 146436021, 1461446943, 4069977195, 705550613, 3059967265, 3887724982, 4281599278, 3313849956, 1404054877, 2845806497, 146425753, 1854211946];

        internal static const KS1:Array=[1266315497, 3048417604, 3681880366, 3289982499, 2909710000, 1235738493, 2632868024, 2414719590, 3970600049, 1771706367, 1449415276, 3266420449, 422970021, 1963543593, 2690192192, 3826793022, 1062508698, 1531092325, 1804592342, 2583117782, 2714934279, 4024971509, 1294809318, 4028980673, 1289560198, 2221992742, 1669523910, 35572830, 157838143, 1052438473, 1016535060, 1802137761, 1753167236, 1386275462, 3080475397, 2857371447, 1040679964, 2145300060, 2390574316, 1461121720, 2956646967, 4031777805, 4028374788, 33600511, 2920084762, 1018524850, 629373528, 3691585981, 3515945977, 2091462646, 2486323059, 586499841, 988145025, 935516892, 3367335476, 2599673255, 2839830854, 265290510, 3972581182, 2759138881, 3795373465, 1005194799, 847297441, 406762289, 1314163512, 1332590856, 1866599683, 4127851711, 750260880, 613907577, 1450815602, 3165620655, 3734664991, 3650291728, 3012275730, 3704569646, 1427272223, 778793252, 1343938022, 2676280711, 2052605720, 1946737175, 3164576444, 3914038668, 3967478842, 3682934266, 1661551462, 3294938066, 4011595847, 840292616, 3712170807, 616741398, 312560963, 711312465, 1351876610, 322626781, 1910503582, 271666773, 2175563734, 1594956187, 70604529, 3617834859, 1007753275, 1495573769, 4069517037, 2549218298, 2663038764, 504708206, 2263041392, 3941167025, 2249088522, 1514023603, 1998579484, 1312622330, 694541497, 2582060303, 2151582166, 1382467621, 776784248, 2618340202, 3323268794, 2497899128, 2784771155, 503983604, 4076293799, 907881277, 423175695, 432175456, 1378068232, 4145222326, 3954048622, 3938656102, 3820766613, 2793130115, 2977904593, 26017576, 3274890735, 3194772133, 1700274565, 1756076034, 4006520079, 3677328699, 720338349, 1533947780, 354530856, 688349552, 3973924725, 1637815568, 332179504, 3949051286, 53804574, 2852348879, 3044236432, 1282449977, 3583942155, 3416972820, 4006381244, 1617046695, 2628476075, 3002303598, 1686838959, 431878346, 2686675385, 1700445008, 1080580658, 1009431731, 832498133, 3223435511, 2605976345, 2271191193, 2516031870, 1648197032, 4164389018, 2548247927, 300782431, 375919233, 238389289, 3353747414, 2531188641, 2019080857, 1475708069, 455242339, 2609103871, 448939670, 3451063019, 1395535956, 2413381860, 1841049896, 1491858159, 885456874, 4264095073, 4001119347, 1565136089, 3898914787, 1108368660, 540939232, 1173283510, 2745871338, 3681308437, 4207628240, 3343053890, 4016749493, 1699691293, 1103962373, 3625875870, 2256883143, 3830138730, 1031889488, 3479347698, 1535977030, 4236805024, 3251091107, 2132092099, 1774941330, 1199868427, 1452454533, 157007616, 2904115357, 342012276, 595725824, 1480756522, 206960106, 497939518, 591360097, 863170706, 2375253569, 3596610801, 1814182875, 2094937945, 3421402208, 1082520231, 3463918190, 2785509508, 435703966, 3908032597, 1641649973, 2842273706, 3305899714, 1510255612, 2148256476, 2655287854, 3276092548, 4258621189, 236887753, 3681803219, 274041037, 1734335097, 3815195456, 3317970021, 1899903192, 1026095262, 4050517792, 356393447, 2410691914, 3873677099, 3682840055];

        internal static const KS3:Array=[976866871, 3556439503, 2881648439, 1522871579, 1555064734, 1336096578, 3548522304, 2579274686, 3574697629, 3205460757, 3593280638, 3338716283, 3079412587, 564236357, 2993598910, 1781952180, 1464380207, 3163844217, 3332601554, 1699332808, 1393555694, 1183702653, 3581086237, 1288719814, 691649499, 2847557200, 2895455976, 3193889540, 2717570544, 1781354906, 1676643554, 2592534050, 3230253752, 1126444790, 2770207658, 2633158820, 2210423226, 2615765581, 2414155088, 3127139286, 673620729, 2805611233, 1269405062, 4015350505, 3341807571, 4149409754, 1057255273, 2012875353, 2162469141, 2276492801, 2601117357, 993977747, 3918593370, 2654263191, 753973209, 36408145, 2530585658, 25011837, 3520020182, 2088578344, 530523599, 2918365339, 1524020338, 1518925132, 3760827505, 3759777254, 1202760957, 3985898139, 3906192525, 674977740, 4174734889, 2031300136, 2019492241, 3983892565, 4153806404, 3822280332, 352677332, 2297720250, 60907813, 90501309, 3286998549, 1016092578, 2535922412, 2839152426, 457141659, 509813237, 4120667899, 652014361, 1966332200, 2975202805, 55981186, 2327461051, 676427537, 3255491064, 2882294119, 3433927263, 1307055953, 942726286, 933058658, 2468411793, 3933900994, 4215176142, 1361170020, 2001714738, 2830558078, 3274259782, 1222529897, 1679025792, 2729314320, 3714953764, 1770335741, 151462246, 3013232138, 1682292957, 1483529935, 471910574, 1539241949, 458788160, 3436315007, 1807016891, 3718408830, 978976581, 1043663428, 3165965781, 1927990952, 4200891579, 2372276910, 3208408903, 3533431907, 1412390302, 2931980059, 4132332400, 1947078029, 3881505623, 4168226417, 2941484381, 1077988104, 1320477388, 886195818, 18198404, 3786409000, 2509781533, 112762804, 3463356488, 1866414978, 891333506, 18488651, 661792760, 1628790961, 3885187036, 3141171499, 876946877, 2693282273, 1372485963, 791857591, 2686433993, 3759982718, 3167212022, 3472953795, 2716379847, 445679433, 3561995674, 3504004811, 3574258232, 54117162, 3331405415, 2381918588, 3769707343, 4154350007, 1140177722, 4074052095, 668550556, 3214352940, 367459370, 261225585, 2610173221, 4209349473, 3468074219, 3265815641, 314222801, 3066103646, 3808782860, 282218597, 3406013506, 3773591054, 379116347, 1285071038, 846784868, 2669647154, 3771962079, 3550491691, 2305946142, 453669953, 1268987020, 3317592352, 3279303384, 3744833421, 2610507566, 3859509063, 266596637, 3847019092, 517658769, 3462560207, 3443424879, 370717030, 4247526661, 2224018117, 4143653529, 4112773975, 2788324899, 2477274417, 1456262402, 2901442914, 1517677493, 1846949527, 2295493580, 3734397586, 2176403920, 1280348187, 1908823572, 3871786941, 846861322, 1172426758, 3287448474, 3383383037, 1655181056, 3139813346, 901632758, 1897031941, 2986607138, 3066810236, 3447102507, 1393639104, 373351379, 950779232, 625454576, 3124240540, 4148612726, 2007998917, 544563296, 2244738638, 2330496472, 2058025392, 1291430526, 424198748, 50039436, 29584100, 3605783033, 2429876329, 2791104160, 1057563949, 3255363231, 3075367218, 3463963227, 1469046755, 985887462];

        internal static const ROUNDS:uint=16;

        internal static const KS2:Array=[3913112168, 2491498743, 4132185628, 2489919796, 1091903735, 1979897079, 3170134830, 3567386728, 3557303409, 857797738, 1136121015, 1342202287, 507115054, 2535736646, 337727348, 3213592640, 1301675037, 2528481711, 1895095763, 1721773893, 3216771564, 62756741, 2142006736, 835421444, 2531993523, 1442658625, 3659876326, 2882144922, 676362277, 1392781812, 170690266, 3921047035, 1759253602, 3611846912, 1745797284, 664899054, 1329594018, 3901205900, 3045908486, 2062866102, 2865634940, 3543621612, 3464012697, 1080764994, 553557557, 3656615353, 3996768171, 991055499, 499776247, 1265440854, 648242737, 3940784050, 980351604, 3713745714, 1749149687, 3396870395, 4211799374, 3640570775, 1161844396, 3125318951, 1431517754, 545492359, 4268468663, 3499529547, 1437099964, 2702547544, 3433638243, 2581715763, 2787789398, 1060185593, 1593081372, 2418618748, 4260947970, 69676912, 2159744348, 86519011, 2512459080, 3838209314, 1220612927, 3339683548, 133810670, 1090789135, 1078426020, 1569222167, 845107691, 3583754449, 4072456591, 1091646820, 628848692, 1613405280, 3757631651, 526609435, 236106946, 48312990, 2942717905, 3402727701, 1797494240, 859738849, 992217954, 4005476642, 2243076622, 3870952857, 3732016268, 765654824, 3490871365, 2511836413, 1685915746, 3888969200, 1414112111, 2273134842, 3281911079, 4080962846, 172450625, 2569994100, 980381355, 4109958455, 2819808352, 2716589560, 2568741196, 3681446669, 3329971472, 1835478071, 660984891, 3704678404, 4045999559, 3422617507, 3040415634, 1762651403, 1719377915, 3470491036, 2693910283, 3642056355, 3138596744, 1364962596, 2073328063, 1983633131, 926494387, 3423689081, 2150032023, 4096667949, 1749200295, 3328846651, 309677260, 2016342300, 1779581495, 3079819751, 111262694, 1274766160, 443224088, 298511866, 1025883608, 3806446537, 1145181785, 168956806, 3641502830, 3584813610, 1689216846, 3666258015, 3200248200, 1692713982, 2646376535, 4042768518, 1618508792, 1610833997, 3523052358, 4130873264, 2001055236, 3610705100, 2202168115, 4028541809, 2961195399, 1006657119, 2006996926, 3186142756, 1430667929, 3210227297, 1314452623, 4074634658, 4101304120, 2273951170, 1399257539, 3367210612, 3027628629, 1190975929, 2062231137, 2333990788, 2221543033, 2438960610, 1181637006, 548689776, 2362791313, 3372408396, 3104550113, 3145860560, 296247880, 1970579870, 3078560182, 3769228297, 1714227617, 3291629107, 3898220290, 166772364, 1251581989, 493813264, 448347421, 195405023, 2709975567, 677966185, 3703036547, 1463355134, 2715995803, 1338867538, 1343315457, 2802222074, 2684532164, 233230375, 2599980071, 2000651841, 3277868038, 1638401717, 4028070440, 3237316320, 6314154, 819756386, 300326615, 590932579, 1405279636, 3267499572, 3150704214, 2428286686, 3959192993, 3461946742, 1862657033, 1266418056, 963775037, 2089974820, 2263052895, 1917689273, 448879540, 3550394620, 3981727096, 150775221, 3627908307, 1303187396, 508620638, 2975983352, 2726630617, 1817252668, 1876281319, 1457606340, 908771278, 3720792119, 3617206836, 2455994898, 1729034894, 1080033504];

        internal static const BLOCK_SIZE:uint=8;

        internal static const P_SZ:uint=ROUNDS + 2;

        internal static const SBOX_SK:uint=256;

        internal var S3:Array;

        internal var P:Array;

        internal var S1:Array;

        internal var key:flash.utils.ByteArray=null;

        internal var S0:Array;

        internal var S2:Array;
    }
}


//      class CBCMode
package com.hurlant.crypto.symmetric 
{
    import flash.utils.*;
    
    public class CBCMode extends com.hurlant.crypto.symmetric.IVMode implements com.hurlant.crypto.symmetric.IMode
    {
        public function CBCMode(arg1:com.hurlant.crypto.symmetric.ISymmetricKey, arg2:com.hurlant.crypto.symmetric.IPad=null)
        {
            super(arg1, arg2);
            return;
        }

        public function toString():String
        {
            return key.toString() + "-cbc";
        }

        public function encrypt(arg1:flash.utils.ByteArray):void
        {
            var loc3:*=0;
            padding.pad(arg1);
            var loc1:*=getIV4e();
            var loc2:*=0;
            while (loc2 < arg1.length) 
            {
                loc3 = 0;
                while (loc3 < blockSize) 
                {
                    arg1[loc2 + loc3] = arg1[loc2 + loc3] ^ loc1[loc3];
                    ++loc3;
                }
                key.encrypt(arg1, loc2);
                loc1.position = 0;
                loc1.writeBytes(arg1, loc2, blockSize);
                loc2 = loc2 + blockSize;
            }
            return;
        }

        public function decrypt(arg1:flash.utils.ByteArray):void
        {
            var loc4:*=0;
            var loc1:*=getIV4d();
            var loc2:*=new flash.utils.ByteArray();
            var loc3:*=0;
            while (loc3 < arg1.length) 
            {
                loc2.position = 0;
                loc2.writeBytes(arg1, loc3, blockSize);
                key.decrypt(arg1, loc3);
                loc4 = 0;
                while (loc4 < blockSize) 
                {
                    arg1[loc3 + loc4] = arg1[loc3 + loc4] ^ loc1[loc4];
                    ++loc4;
                }
                loc1.position = 0;
                loc1.writeBytes(loc2, 0, blockSize);
                loc3 = loc3 + blockSize;
            }
            padding.unpad(arg1);
            return;
        }
    }
}


//      class CFB8Mode
package com.hurlant.crypto.symmetric 
{
    import flash.utils.*;
    
    public class CFB8Mode extends com.hurlant.crypto.symmetric.IVMode implements com.hurlant.crypto.symmetric.IMode
    {
        public function CFB8Mode(arg1:com.hurlant.crypto.symmetric.ISymmetricKey, arg2:com.hurlant.crypto.symmetric.IPad=null)
        {
            super(arg1, null);
            return;
        }

        public function toString():String
        {
            return key.toString() + "-cfb8";
        }

        public function encrypt(arg1:flash.utils.ByteArray):void
        {
            var loc4:*=0;
            var loc1:*=getIV4e();
            var loc2:*=new flash.utils.ByteArray();
            var loc3:*=0;
            while (loc3 < arg1.length) 
            {
                loc2.position = 0;
                loc2.writeBytes(loc1);
                key.encrypt(loc1);
                arg1[loc3] = arg1[loc3] ^ loc1[0];
                loc4 = 0;
                while (loc4 < (blockSize - 1)) 
                {
                    loc1[loc4] = loc2[loc4 + 1];
                    ++loc4;
                }
                loc1[(blockSize - 1)] = arg1[loc3];
                ++loc3;
            }
            return;
        }

        public function decrypt(arg1:flash.utils.ByteArray):void
        {
            var loc4:*=0;
            var loc5:*=0;
            var loc1:*=getIV4d();
            var loc2:*=new flash.utils.ByteArray();
            var loc3:*=0;
            while (loc3 < arg1.length) 
            {
                loc4 = arg1[loc3];
                loc2.position = 0;
                loc2.writeBytes(loc1);
                key.encrypt(loc1);
                arg1[loc3] = arg1[loc3] ^ loc1[0];
                loc5 = 0;
                while (loc5 < (blockSize - 1)) 
                {
                    loc1[loc5] = loc2[loc5 + 1];
                    ++loc5;
                }
                loc1[(blockSize - 1)] = loc4;
                ++loc3;
            }
            return;
        }
    }
}


//      class CFBMode
package com.hurlant.crypto.symmetric 
{
    import flash.utils.*;
    
    public class CFBMode extends com.hurlant.crypto.symmetric.IVMode implements com.hurlant.crypto.symmetric.IMode
    {
        public function CFBMode(arg1:com.hurlant.crypto.symmetric.ISymmetricKey, arg2:com.hurlant.crypto.symmetric.IPad=null)
        {
            super(arg1, null);
            return;
        }

        public function toString():String
        {
            return key.toString() + "-cfb";
        }

        public function encrypt(arg1:flash.utils.ByteArray):void
        {
            var loc4:*=0;
            var loc5:*=0;
            var loc1:*=arg1.length;
            var loc2:*=getIV4e();
            var loc3:*=0;
            while (loc3 < arg1.length) 
            {
                key.encrypt(loc2);
                loc4 = loc3 + blockSize < loc1 ? blockSize : loc1 - loc3;
                loc5 = 0;
                while (loc5 < loc4) 
                {
                    arg1[loc3 + loc5] = arg1[loc3 + loc5] ^ loc2[loc5];
                    ++loc5;
                }
                loc2.position = 0;
                loc2.writeBytes(arg1, loc3, loc4);
                loc3 = loc3 + blockSize;
            }
            return;
        }

        public function decrypt(arg1:flash.utils.ByteArray):void
        {
            var loc5:*=0;
            var loc6:*=0;
            var loc1:*=arg1.length;
            var loc2:*=getIV4d();
            var loc3:*=new flash.utils.ByteArray();
            var loc4:*=0;
            while (loc4 < arg1.length) 
            {
                key.encrypt(loc2);
                loc5 = loc4 + blockSize < loc1 ? blockSize : loc1 - loc4;
                loc3.position = 0;
                loc3.writeBytes(arg1, loc4, loc5);
                loc6 = 0;
                while (loc6 < loc5) 
                {
                    arg1[loc4 + loc6] = arg1[loc4 + loc6] ^ loc2[loc6];
                    ++loc6;
                }
                loc2.position = 0;
                loc2.writeBytes(loc3);
                loc4 = loc4 + blockSize;
            }
            return;
        }
    }
}


//      class CTRMode
package com.hurlant.crypto.symmetric 
{
    import flash.utils.*;
    
    public class CTRMode extends com.hurlant.crypto.symmetric.IVMode implements com.hurlant.crypto.symmetric.IMode
    {
        public function CTRMode(arg1:com.hurlant.crypto.symmetric.ISymmetricKey, arg2:com.hurlant.crypto.symmetric.IPad=null)
        {
            super(arg1, arg2);
            return;
        }

        internal function core(arg1:flash.utils.ByteArray, arg2:flash.utils.ByteArray):void
        {
            var loc4:*=0;
            var loc1:*=new flash.utils.ByteArray();
            var loc2:*=new flash.utils.ByteArray();
            loc1.writeBytes(arg2);
            var loc3:*=0;
            while (loc3 < arg1.length) 
            {
                loc2.position = 0;
                loc2.writeBytes(loc1);
                key.encrypt(loc2);
                loc4 = 0;
                while (loc4 < blockSize) 
                {
                    arg1[loc3 + loc4] = arg1[loc3 + loc4] ^ loc2[loc4];
                    ++loc4;
                }
                loc4 = (blockSize - 1);
                while (loc4 >= 0) 
                {
                    var loc5:*;
                    var loc6:*;
                    var loc7:*=((loc5 = loc1)[loc6 = loc4] + 1);
                    loc5[loc6] = loc7;
                    if (loc1[loc4] != 0) 
                    {
                        break;
                    }
                    --loc4;
                }
                loc3 = loc3 + blockSize;
            }
            return;
        }

        public function toString():String
        {
            return key.toString() + "-ctr";
        }

        public function encrypt(arg1:flash.utils.ByteArray):void
        {
            padding.pad(arg1);
            var loc1:*=getIV4e();
            core(arg1, loc1);
            return;
        }

        public function decrypt(arg1:flash.utils.ByteArray):void
        {
            var loc1:*=getIV4d();
            core(arg1, loc1);
            padding.unpad(arg1);
            return;
        }
    }
}


//      class DESKey
package com.hurlant.crypto.symmetric 
{
    import com.hurlant.util.*;
    import flash.utils.*;
    
    public class DESKey extends Object implements com.hurlant.crypto.symmetric.ISymmetricKey
    {
        public function DESKey(arg1:flash.utils.ByteArray)
        {
            super();
            this.key = arg1;
            this.encKey = generateWorkingKey(true, arg1, 0);
            this.decKey = generateWorkingKey(false, arg1, 0);
            return;
        }

        protected function generateWorkingKey(arg1:Boolean, arg2:flash.utils.ByteArray, arg3:uint):Array
        {
            var loc4:*=0;
            var loc7:*=0;
            var loc8:*=0;
            var loc9:*=0;
            var loc10:*=0;
            var loc1:*=[];
            var loc2:*=new flash.utils.ByteArray();
            var loc3:*=new flash.utils.ByteArray();
            var loc5:*=0;
            while (loc5 < 56) 
            {
                loc4 = pc1[loc5];
                loc2[loc5] = !((arg2[arg3 + (loc4 >>> 3)] & bytebit[loc4 & 7]) == 0);
                ++loc5;
            }
            var loc6:*=0;
            while (loc6 < 16) 
            {
                if (arg1) 
                {
                    loc7 = loc6 << 1;
                }
                else 
                {
                    loc7 = 15 - loc6 << 1;
                }
                loc8 = loc7 + 1;
                var loc11:*;
                loc1[loc8] = loc11 = 0;
                loc1[loc7] = loc11;
                loc5 = 0;
                while (loc5 < 28) 
                {
                    loc4 = loc5 + totrot[loc6];
                    if (loc4 < 28) 
                    {
                        loc3[loc5] = loc2[loc4];
                    }
                    else 
                    {
                        loc3[loc5] = loc2[loc4 - 28];
                    }
                    ++loc5;
                }
                loc5 = 28;
                while (loc5 < 56) 
                {
                    loc4 = loc5 + totrot[loc6];
                    if (loc4 < 56) 
                    {
                        loc3[loc5] = loc2[loc4];
                    }
                    else 
                    {
                        loc3[loc5] = loc2[loc4 - 28];
                    }
                    ++loc5;
                }
                loc5 = 0;
                while (loc5 < 24) 
                {
                    if (loc3[pc2[loc5]]) 
                    {
                        loc1[loc7] = loc1[loc7] | bigbyte[loc5];
                    }
                    if (loc3[pc2[loc5 + 24]]) 
                    {
                        loc1[loc8] = loc1[loc8] | bigbyte[loc5];
                    }
                    ++loc5;
                }
                ++loc6;
            }
            loc6 = 0;
            while (loc6 != 32) 
            {
                loc9 = loc1[loc6];
                loc10 = loc1[loc6 + 1];
                loc1[loc6] = (loc9 & 16515072) << 6 | (loc9 & 4032) << 10 | (loc10 & 16515072) >>> 10 | (loc10 & 4032) >>> 6;
                loc1[loc6 + 1] = (loc9 & 258048) << 12 | (loc9 & 63) << 16 | (loc10 & 258048) >>> 4 | loc10 & 63;
                loc6 = loc6 + 2;
            }
            return loc1;
        }

        public function getBlockSize():uint
        {
            return 8;
        }

        public function encrypt(arg1:flash.utils.ByteArray, arg2:uint=0):void
        {
            desFunc(encKey, arg1, arg2, arg1, arg2);
            return;
        }

        public function decrypt(arg1:flash.utils.ByteArray, arg2:uint=0):void
        {
            desFunc(decKey, arg1, arg2, arg1, arg2);
            return;
        }

        protected function desFunc(arg1:Array, arg2:flash.utils.ByteArray, arg3:uint, arg4:flash.utils.ByteArray, arg5:uint):void
        {
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=0;
            var loc5:*=0;
            loc3 = (arg2[arg3 + 0] & 255) << 24;
            loc3 = loc3 | (arg2[arg3 + 1] & 255) << 16;
            loc3 = loc3 | (arg2[arg3 + 2] & 255) << 8;
            loc3 = loc3 | arg2[arg3 + 3] & 255;
            loc2 = (arg2[arg3 + 4] & 255) << 24;
            loc2 = loc2 | (arg2[arg3 + 5] & 255) << 16;
            loc2 = loc2 | (arg2[arg3 + 6] & 255) << 8;
            loc2 = loc2 | arg2[arg3 + 7] & 255;
            loc1 = (loc3 >>> 4 ^ loc2) & 252645135;
            loc2 = loc2 ^ loc1;
            loc3 = loc3 ^ loc1 << 4;
            loc1 = (loc3 >>> 16 ^ loc2) & 65535;
            loc2 = loc2 ^ loc1;
            loc3 = loc3 ^ loc1 << 16;
            loc1 = (loc2 >>> 2 ^ loc3) & 858993459;
            loc3 = loc3 ^ loc1;
            loc2 = loc2 ^ loc1 << 2;
            loc1 = (loc2 >>> 8 ^ loc3) & 16711935;
            loc3 = loc3 ^ loc1;
            loc2 = loc2 ^ loc1 << 8;
            loc2 = (loc2 << 1 | loc2 >>> 31 & 1) & 4294967295;
            loc1 = (loc3 ^ loc2) & 2863311530;
            loc3 = loc3 ^ loc1;
            loc2 = loc2 ^ loc1;
            loc3 = (loc3 << 1 | loc3 >>> 31 & 1) & 4294967295;
            var loc4:*=0;
            while (loc4 < 8) 
            {
                loc1 = loc2 << 28 | loc2 >>> 4;
                loc1 = loc1 ^ arg1[loc4 * 4 + 0];
                loc5 = SP7[loc1 & 63];
                loc5 = loc5 | SP5[loc1 >>> 8 & 63];
                loc5 = loc5 | SP3[loc1 >>> 16 & 63];
                loc5 = loc5 | SP1[loc1 >>> 24 & 63];
                loc1 = loc2 ^ arg1[loc4 * 4 + 1];
                loc5 = loc5 | SP8[loc1 & 63];
                loc5 = loc5 | SP6[loc1 >>> 8 & 63];
                loc5 = loc5 | SP4[loc1 >>> 16 & 63];
                loc5 = loc5 | SP2[loc1 >>> 24 & 63];
                loc3 = loc3 ^ loc5;
                loc1 = loc3 << 28 | loc3 >>> 4;
                loc1 = loc1 ^ arg1[loc4 * 4 + 2];
                loc5 = SP7[loc1 & 63];
                loc5 = loc5 | SP5[loc1 >>> 8 & 63];
                loc5 = loc5 | SP3[loc1 >>> 16 & 63];
                loc5 = loc5 | SP1[loc1 >>> 24 & 63];
                loc1 = loc3 ^ arg1[loc4 * 4 + 3];
                loc5 = loc5 | SP8[loc1 & 63];
                loc5 = loc5 | SP6[loc1 >>> 8 & 63];
                loc5 = loc5 | SP4[loc1 >>> 16 & 63];
                loc5 = loc5 | SP2[loc1 >>> 24 & 63];
                loc2 = loc2 ^ loc5;
                ++loc4;
            }
            loc2 = loc2 << 31 | loc2 >>> 1;
            loc1 = (loc3 ^ loc2) & 2863311530;
            loc3 = loc3 ^ loc1;
            loc2 = loc2 ^ loc1;
            loc3 = loc3 << 31 | loc3 >>> 1;
            loc1 = (loc3 >>> 8 ^ loc2) & 16711935;
            loc2 = loc2 ^ loc1;
            loc3 = loc3 ^ loc1 << 8;
            loc1 = (loc3 >>> 2 ^ loc2) & 858993459;
            loc2 = loc2 ^ loc1;
            loc3 = loc3 ^ loc1 << 2;
            loc1 = (loc2 >>> 16 ^ loc3) & 65535;
            loc3 = loc3 ^ loc1;
            loc2 = loc2 ^ loc1 << 16;
            loc1 = (loc2 >>> 4 ^ loc3) & 252645135;
            loc3 = loc3 ^ loc1;
            loc2 = loc2 ^ loc1 << 4;
            arg4[arg5 + 0] = loc2 >>> 24 & 255;
            arg4[arg5 + 1] = loc2 >>> 16 & 255;
            arg4[arg5 + 2] = loc2 >>> 8 & 255;
            arg4[arg5 + 3] = loc2 & 255;
            arg4[arg5 + 4] = loc3 >>> 24 & 255;
            arg4[arg5 + 5] = loc3 >>> 16 & 255;
            arg4[arg5 + 6] = loc3 >>> 8 & 255;
            arg4[arg5 + 7] = loc3 & 255;
            return;
        }

        public function toString():String
        {
            return "des";
        }

        public function dispose():void
        {
            var loc1:*=0;
            loc1 = 0;
            while (loc1 < encKey.length) 
            {
                encKey[loc1] = 0;
                ++loc1;
            }
            loc1 = 0;
            while (loc1 < decKey.length) 
            {
                decKey[loc1] = 0;
                ++loc1;
            }
            encKey = null;
            decKey = null;
            loc1 = 0;
            while (loc1 < key.length) 
            {
                key[loc1] = 0;
                ++loc1;
            }
            key.length = 0;
            key = null;
            com.hurlant.util.Memory.gc();
            return;
        }

        internal static const SP8:Array=[268439616, 4096, 262144, 268701760, 268435456, 268439616, 64, 268435456, 262208, 268697600, 268701760, 266240, 268701696, 266304, 4096, 64, 268697600, 268435520, 268439552, 4160, 266240, 262208, 268697664, 268701696, 4160, 0, 0, 268697664, 268435520, 268439552, 266304, 262144, 266304, 262144, 268701696, 4096, 64, 268697664, 4096, 266304, 268439552, 64, 268435520, 268697600, 268697664, 268435456, 262144, 268439616, 0, 268701760, 262208, 268435520, 268697600, 268439552, 268439616, 0, 268701760, 266240, 266240, 4160, 4160, 262208, 268435456, 268701696];

        internal static const bytebit:Array=[128, 64, 32, 16, 8, 4, 2, 1];

        internal static const bigbyte:Array=[8388608, 4194304, 2097152, 1048576, 524288, 262144, 131072, 65536, 32768, 16384, 8192, 4096, 2048, 1024, 512, 256, 128, 64, 32, 16, 8, 4, 2, 1];

        internal static const pc1:Array=[56, 48, 40, 32, 24, 16, 8, 0, 57, 49, 41, 33, 25, 17, 9, 1, 58, 50, 42, 34, 26, 18, 10, 2, 59, 51, 43, 35, 62, 54, 46, 38, 30, 22, 14, 6, 61, 53, 45, 37, 29, 21, 13, 5, 60, 52, 44, 36, 28, 20, 12, 4, 27, 19, 11, 3];

        internal static const pc2:Array=[13, 16, 10, 23, 0, 4, 2, 27, 14, 5, 20, 9, 22, 18, 11, 3, 25, 7, 15, 6, 26, 19, 12, 1, 40, 51, 30, 36, 46, 54, 29, 39, 50, 44, 32, 47, 43, 48, 38, 55, 33, 52, 45, 41, 49, 35, 28, 31];

        internal static const Df_Key:Array=[1, 35, 69, 103, 137, 171, 205, 239, 254, 220, 186, 152, 118, 84, 50, 16, 137, 171, 205, 239, 1, 35, 69, 103];

        internal static const totrot:Array=[1, 2, 4, 6, 8, 10, 12, 14, 15, 17, 19, 21, 23, 25, 27, 28];

        internal static const SP1:Array=[16843776, 0, 65536, 16843780, 16842756, 66564, 4, 65536, 1024, 16843776, 16843780, 1024, 16778244, 16842756, 16777216, 4, 1028, 16778240, 16778240, 66560, 66560, 16842752, 16842752, 16778244, 65540, 16777220, 16777220, 65540, 0, 1028, 66564, 16777216, 65536, 16843780, 4, 16842752, 16843776, 16777216, 16777216, 1024, 16842756, 65536, 66560, 16777220, 1024, 4, 16778244, 66564, 16843780, 65540, 16842752, 16778244, 16777220, 1028, 66564, 16843776, 1028, 16778240, 16778240, 0, 65540, 66560, 0, 16842756];

        internal static const SP2:Array=[2148565024, 2147516416, 32768, 1081376, 1048576, 32, 2148532256, 2147516448, 2147483680, 2148565024, 2148564992, 2147483648, 2147516416, 1048576, 32, 2148532256, 1081344, 1048608, 2147516448, 0, 2147483648, 32768, 1081376, 2148532224, 1048608, 2147483680, 0, 1081344, 32800, 2148564992, 2148532224, 32800, 0, 1081376, 2148532256, 1048576, 2147516448, 2148532224, 2148564992, 32768, 2148532224, 2147516416, 32, 2148565024, 1081376, 32, 32768, 2147483648, 32800, 2148564992, 1048576, 2147483680, 1048608, 2147516448, 2147483680, 1048608, 1081344, 0, 2147516416, 32800, 2147483648, 2148532256, 2148565024, 1081344];

        internal static const SP3:Array=[520, 134349312, 0, 134348808, 134218240, 0, 131592, 134218240, 131080, 134217736, 134217736, 131072, 134349320, 131080, 134348800, 520, 134217728, 8, 134349312, 512, 131584, 134348800, 134348808, 131592, 134218248, 131584, 131072, 134218248, 8, 134349320, 512, 134217728, 134349312, 134217728, 131080, 520, 131072, 134349312, 134218240, 0, 512, 131080, 134349320, 134218240, 134217736, 512, 0, 134348808, 134218248, 131072, 134217728, 134349320, 8, 131592, 131584, 134217736, 134348800, 134218248, 520, 134348800, 131592, 8, 134348808, 131584];

        internal static const SP4:Array=[8396801, 8321, 8321, 128, 8396928, 8388737, 8388609, 8193, 0, 8396800, 8396800, 8396929, 129, 0, 8388736, 8388609, 1, 8192, 8388608, 8396801, 128, 8388608, 8193, 8320, 8388737, 1, 8320, 8388736, 8192, 8396928, 8396929, 129, 8388736, 8388609, 8396800, 8396929, 129, 0, 0, 8396800, 8320, 8388736, 8388737, 1, 8396801, 8321, 8321, 128, 8396929, 129, 1, 8192, 8388609, 8193, 8396928, 8388737, 8193, 8320, 8388608, 8396801, 128, 8388608, 8192, 8396928];

        internal static const SP5:Array=[256, 34078976, 34078720, 1107296512, 524288, 256, 1073741824, 34078720, 1074266368, 524288, 33554688, 1074266368, 1107296512, 1107820544, 524544, 1073741824, 33554432, 1074266112, 1074266112, 0, 1073742080, 1107820800, 1107820800, 33554688, 1107820544, 1073742080, 0, 1107296256, 34078976, 33554432, 1107296256, 524544, 524288, 1107296512, 256, 33554432, 1073741824, 34078720, 1107296512, 1074266368, 33554688, 1073741824, 1107820544, 34078976, 1074266368, 256, 33554432, 1107820544, 1107820800, 524544, 1107296256, 1107820800, 34078720, 0, 1074266112, 1107296256, 524544, 33554688, 1073742080, 524288, 0, 1074266112, 34078976, 1073742080];

        internal static const SP6:Array=[536870928, 541065216, 16384, 541081616, 541065216, 16, 541081616, 4194304, 536887296, 4210704, 4194304, 536870928, 4194320, 536887296, 536870912, 16400, 0, 4194320, 536887312, 16384, 4210688, 536887312, 16, 541065232, 541065232, 0, 4210704, 541081600, 16400, 4210688, 541081600, 536870912, 536887296, 16, 541065232, 4210688, 541081616, 4194304, 16400, 536870928, 4194304, 536887296, 536870912, 16400, 536870928, 541081616, 4210688, 541065216, 4210704, 541081600, 0, 541065232, 16, 16384, 541065216, 4210704, 16384, 4194320, 536887312, 0, 541081600, 536870912, 4194320, 536887312];

        internal static const SP7:Array=[2097152, 69206018, 67110914, 0, 2048, 67110914, 2099202, 69208064, 69208066, 2097152, 0, 67108866, 2, 67108864, 69206018, 2050, 67110912, 2099202, 2097154, 67110912, 67108866, 69206016, 69208064, 2097154, 69206016, 2048, 2050, 69208066, 2099200, 2, 67108864, 2099200, 67108864, 2099200, 2097152, 67110914, 67110914, 69206018, 69206018, 2, 2097154, 67108864, 67110912, 2097152, 69208064, 2050, 2099202, 69208064, 2050, 67108866, 69208066, 69206016, 2099200, 0, 2, 69208066, 0, 2099202, 69206016, 2048, 67108866, 67110912, 2048, 2097154];

        protected var encKey:Array;

        protected var key:flash.utils.ByteArray;

        protected var decKey:Array;
    }
}


//      class ECBMode
package com.hurlant.crypto.symmetric 
{
    import com.hurlant.util.*;
    import flash.utils.*;
    
    public class ECBMode extends Object implements com.hurlant.crypto.symmetric.IMode, com.hurlant.crypto.symmetric.ICipher
    {
        public function ECBMode(arg1:com.hurlant.crypto.symmetric.ISymmetricKey, arg2:com.hurlant.crypto.symmetric.IPad=null)
        {
            super();
            this.key = arg1;
            if (arg2 != null) 
            {
                arg2.setBlockSize(arg1.getBlockSize());
            }
            else 
            {
                arg2 = new com.hurlant.crypto.symmetric.PKCS5(arg1.getBlockSize());
            }
            this.padding = arg2;
            return;
        }

        public function encrypt(arg1:flash.utils.ByteArray):void
        {
            padding.pad(arg1);
            arg1.position = 0;
            var loc1:*=key.getBlockSize();
            var loc2:*=new flash.utils.ByteArray();
            var loc3:*=new flash.utils.ByteArray();
            var loc4:*=0;
            while (loc4 < arg1.length) 
            {
                loc2.length = 0;
                arg1.readBytes(loc2, 0, loc1);
                key.encrypt(loc2);
                loc3.writeBytes(loc2);
                loc4 = loc4 + loc1;
            }
            arg1.length = 0;
            arg1.writeBytes(loc3);
            return;
        }

        public function getBlockSize():uint
        {
            return key.getBlockSize();
        }

        public function decrypt(arg1:flash.utils.ByteArray):void
        {
            arg1.position = 0;
            var loc1:*=key.getBlockSize();
            if (arg1.length % loc1 != 0) 
            {
                throw new Error("ECB mode cipher length must be a multiple of blocksize " + loc1);
            }
            var loc2:*=new flash.utils.ByteArray();
            var loc3:*=new flash.utils.ByteArray();
            var loc4:*=0;
            while (loc4 < arg1.length) 
            {
                loc2.length = 0;
                arg1.readBytes(loc2, 0, loc1);
                key.decrypt(loc2);
                loc3.writeBytes(loc2);
                loc4 = loc4 + loc1;
            }
            padding.unpad(loc3);
            arg1.length = 0;
            arg1.writeBytes(loc3);
            return;
        }

        public function toString():String
        {
            return key.toString() + "-ecb";
        }

        public function dispose():void
        {
            key.dispose();
            key = null;
            padding = null;
            com.hurlant.util.Memory.gc();
            return;
        }

        internal var key:com.hurlant.crypto.symmetric.ISymmetricKey;

        internal var padding:com.hurlant.crypto.symmetric.IPad;
    }
}


//      class ICipher
package com.hurlant.crypto.symmetric 
{
    import flash.utils.*;
    
    public interface ICipher
    {
        function encrypt(arg1:flash.utils.ByteArray):void;

        function getBlockSize():uint;

        function toString():String;

        function decrypt(arg1:flash.utils.ByteArray):void;

        function dispose():void;
    }
}


//      class IMode
package com.hurlant.crypto.symmetric 
{
    public interface IMode extends com.hurlant.crypto.symmetric.ICipher
    {
    }
}


//      class IPad
package com.hurlant.crypto.symmetric 
{
    import flash.utils.*;
    
    public interface IPad
    {
        function unpad(arg1:flash.utils.ByteArray):void;

        function pad(arg1:flash.utils.ByteArray):void;

        function setBlockSize(arg1:uint):void;
    }
}


//      class IStreamCipher
package com.hurlant.crypto.symmetric 
{
    public interface IStreamCipher extends com.hurlant.crypto.symmetric.ICipher
    {
    }
}


//      class ISymmetricKey
package com.hurlant.crypto.symmetric 
{
    import flash.utils.*;
    
    public interface ISymmetricKey
    {
        function encrypt(arg1:flash.utils.ByteArray, arg2:uint=0):void;

        function getBlockSize():uint;

        function toString():String;

        function decrypt(arg1:flash.utils.ByteArray, arg2:uint=0):void;

        function dispose():void;
    }
}


//      class IVMode
package com.hurlant.crypto.symmetric 
{
    import com.hurlant.crypto.prng.*;
    import com.hurlant.util.*;
    import flash.utils.*;
    
    public class IVMode extends Object
    {
        public function IVMode(arg1:com.hurlant.crypto.symmetric.ISymmetricKey, arg2:com.hurlant.crypto.symmetric.IPad=null)
        {
            super();
            this.key = arg1;
            blockSize = arg1.getBlockSize();
            if (arg2 != null) 
            {
                arg2.setBlockSize(blockSize);
            }
            else 
            {
                arg2 = new com.hurlant.crypto.symmetric.PKCS5(blockSize);
            }
            this.padding = arg2;
            prng = new com.hurlant.crypto.prng.Random();
            iv = null;
            lastIV = new flash.utils.ByteArray();
            return;
        }

        public function set IV(arg1:flash.utils.ByteArray):void
        {
            iv = arg1;
            lastIV.length = 0;
            lastIV.writeBytes(iv);
            return;
        }

        protected function getIV4d():flash.utils.ByteArray
        {
            var loc1:*=new flash.utils.ByteArray();
            if (iv) 
            {
                loc1.writeBytes(iv);
            }
            else 
            {
                throw new Error("an IV must be set before calling decrypt()");
            }
            return loc1;
        }

        protected function getIV4e():flash.utils.ByteArray
        {
            var loc1:*=new flash.utils.ByteArray();
            if (iv) 
            {
                loc1.writeBytes(iv);
            }
            else 
            {
                prng.nextBytes(loc1, blockSize);
            }
            lastIV.length = 0;
            lastIV.writeBytes(loc1);
            return loc1;
        }

        public function get IV():flash.utils.ByteArray
        {
            return lastIV;
        }

        public function dispose():void
        {
            var loc1:*=0;
            if (iv != null) 
            {
                loc1 = 0;
                while (loc1 < iv.length) 
                {
                    iv[loc1] = prng.nextByte();
                    ++loc1;
                }
                iv.length = 0;
                iv = null;
            }
            if (lastIV != null) 
            {
                loc1 = 0;
                while (loc1 < iv.length) 
                {
                    lastIV[loc1] = prng.nextByte();
                    ++loc1;
                }
                lastIV.length = 0;
                lastIV = null;
            }
            key.dispose();
            key = null;
            padding = null;
            prng.dispose();
            prng = null;
            com.hurlant.util.Memory.gc();
            return;
        }

        public function getBlockSize():uint
        {
            return key.getBlockSize();
        }

        protected var lastIV:flash.utils.ByteArray;

        protected var iv:flash.utils.ByteArray;

        protected var blockSize:uint;

        protected var padding:com.hurlant.crypto.symmetric.IPad;

        protected var prng:com.hurlant.crypto.prng.Random;

        protected var key:com.hurlant.crypto.symmetric.ISymmetricKey;
    }
}


//      class NullPad
package com.hurlant.crypto.symmetric 
{
    import flash.utils.*;
    
    public class NullPad extends Object implements com.hurlant.crypto.symmetric.IPad
    {
        public function NullPad()
        {
            super();
            return;
        }

        public function unpad(arg1:flash.utils.ByteArray):void
        {
            return;
        }

        public function pad(arg1:flash.utils.ByteArray):void
        {
            return;
        }

        public function setBlockSize(arg1:uint):void
        {
            return;
        }
    }
}


//      class OFBMode
package com.hurlant.crypto.symmetric 
{
    import flash.utils.*;
    
    public class OFBMode extends com.hurlant.crypto.symmetric.IVMode implements com.hurlant.crypto.symmetric.IMode
    {
        public function OFBMode(arg1:com.hurlant.crypto.symmetric.ISymmetricKey, arg2:com.hurlant.crypto.symmetric.IPad=null)
        {
            super(arg1, null);
            return;
        }

        internal function core(arg1:flash.utils.ByteArray, arg2:flash.utils.ByteArray):void
        {
            var loc4:*=0;
            var loc5:*=0;
            var loc1:*=arg1.length;
            var loc2:*=new flash.utils.ByteArray();
            var loc3:*=0;
            while (loc3 < arg1.length) 
            {
                key.encrypt(arg2);
                loc2.position = 0;
                loc2.writeBytes(arg2);
                loc4 = loc3 + blockSize < loc1 ? blockSize : loc1 - loc3;
                loc5 = 0;
                while (loc5 < loc4) 
                {
                    arg1[loc3 + loc5] = arg1[loc3 + loc5] ^ arg2[loc5];
                    ++loc5;
                }
                arg2.position = 0;
                arg2.writeBytes(loc2);
                loc3 = loc3 + blockSize;
            }
            return;
        }

        public function toString():String
        {
            return key.toString() + "-ofb";
        }

        public function encrypt(arg1:flash.utils.ByteArray):void
        {
            var loc1:*=getIV4e();
            core(arg1, loc1);
            return;
        }

        public function decrypt(arg1:flash.utils.ByteArray):void
        {
            var loc1:*=getIV4d();
            core(arg1, loc1);
            return;
        }
    }
}


//      class PKCS5
package com.hurlant.crypto.symmetric 
{
    import flash.utils.*;
    
    public class PKCS5 extends Object implements com.hurlant.crypto.symmetric.IPad
    {
        public function PKCS5(arg1:uint=0)
        {
            super();
            this.blockSize = arg1;
            return;
        }

        public function pad(arg1:flash.utils.ByteArray):void
        {
            var loc1:*=blockSize - arg1.length % blockSize;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                arg1[arg1.length] = loc1;
                ++loc2;
            }
            return;
        }

        public function setBlockSize(arg1:uint):void
        {
            blockSize = arg1;
            return;
        }

        public function unpad(arg1:flash.utils.ByteArray):void
        {
            var loc3:*=0;
            var loc1:*=arg1.length % blockSize;
            if (loc1 != 0) 
            {
                throw new Error("PKCS#5::unpad: ByteArray.length isn\'t a multiple of the blockSize");
            }
            loc1 = arg1[(arg1.length - 1)];
            var loc2:*=loc1;
            while (loc2 > 0) 
            {
                loc3 = arg1[(arg1.length - 1)];
                var loc4:*;
                var loc5:*=((loc4 = arg1).length - 1);
                loc4.length = loc5;
                if (loc1 != loc3) 
                {
                    throw new Error("PKCS#5:unpad: Invalid padding value. expected [" + loc1 + "], found [" + loc3 + "]");
                }
                --loc2;
            }
            return;
        }

        internal var blockSize:uint;
    }
}


//      class SimpleIVMode
package com.hurlant.crypto.symmetric 
{
    import com.hurlant.util.*;
    import flash.utils.*;
    
    public class SimpleIVMode extends Object implements com.hurlant.crypto.symmetric.IMode, com.hurlant.crypto.symmetric.ICipher
    {
        public function SimpleIVMode(arg1:com.hurlant.crypto.symmetric.IVMode)
        {
            super();
            this.mode = arg1;
            cipher = arg1 as com.hurlant.crypto.symmetric.ICipher;
            return;
        }

        public function encrypt(arg1:flash.utils.ByteArray):void
        {
            cipher.encrypt(arg1);
            var loc1:*=new flash.utils.ByteArray();
            loc1.writeBytes(mode.IV);
            loc1.writeBytes(arg1);
            arg1.position = 0;
            arg1.writeBytes(loc1);
            return;
        }

        public function decrypt(arg1:flash.utils.ByteArray):void
        {
            var loc1:*=new flash.utils.ByteArray();
            loc1.writeBytes(arg1, 0, getBlockSize());
            mode.IV = loc1;
            loc1 = new flash.utils.ByteArray();
            loc1.writeBytes(arg1, getBlockSize());
            cipher.decrypt(loc1);
            arg1.length = 0;
            arg1.writeBytes(loc1);
            return;
        }

        public function dispose():void
        {
            mode.dispose();
            mode = null;
            cipher = null;
            com.hurlant.util.Memory.gc();
            return;
        }

        public function getBlockSize():uint
        {
            return mode.getBlockSize();
        }

        public function toString():String
        {
            return "simple-" + cipher.toString();
        }

        protected var mode:com.hurlant.crypto.symmetric.IVMode;

        protected var cipher:com.hurlant.crypto.symmetric.ICipher;
    }
}


//      class TripleDESKey
package com.hurlant.crypto.symmetric 
{
    import com.hurlant.util.*;
    import flash.utils.*;
    
    public class TripleDESKey extends com.hurlant.crypto.symmetric.DESKey
    {
        public function TripleDESKey(arg1:flash.utils.ByteArray)
        {
            super(arg1);
            encKey2 = generateWorkingKey(false, arg1, 8);
            decKey2 = generateWorkingKey(true, arg1, 8);
            if (arg1.length > 16) 
            {
                encKey3 = generateWorkingKey(true, arg1, 16);
                decKey3 = generateWorkingKey(false, arg1, 16);
            }
            else 
            {
                encKey3 = encKey;
                decKey3 = decKey;
            }
            return;
        }

        public override function encrypt(arg1:flash.utils.ByteArray, arg2:uint=0):void
        {
            desFunc(encKey, arg1, arg2, arg1, arg2);
            desFunc(encKey2, arg1, arg2, arg1, arg2);
            desFunc(encKey3, arg1, arg2, arg1, arg2);
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            var loc1:*=0;
            if (encKey2 != null) 
            {
                loc1 = 0;
                while (loc1 < encKey2.length) 
                {
                    encKey2[loc1] = 0;
                    ++loc1;
                }
                encKey2 = null;
            }
            if (encKey3 != null) 
            {
                loc1 = 0;
                while (loc1 < encKey3.length) 
                {
                    encKey3[loc1] = 0;
                    ++loc1;
                }
                encKey3 = null;
            }
            if (decKey2 != null) 
            {
                loc1 = 0;
                while (loc1 < decKey2.length) 
                {
                    decKey2[loc1] = 0;
                    ++loc1;
                }
                decKey2 = null;
            }
            if (decKey3 != null) 
            {
                loc1 = 0;
                while (loc1 < decKey3.length) 
                {
                    decKey3[loc1] = 0;
                    ++loc1;
                }
                decKey3 = null;
            }
            com.hurlant.util.Memory.gc();
            return;
        }

        public override function decrypt(arg1:flash.utils.ByteArray, arg2:uint=0):void
        {
            desFunc(decKey3, arg1, arg2, arg1, arg2);
            desFunc(decKey2, arg1, arg2, arg1, arg2);
            desFunc(decKey, arg1, arg2, arg1, arg2);
            return;
        }

        public override function toString():String
        {
            return "3des";
        }

        protected var encKey2:Array;

        protected var encKey3:Array;

        protected var decKey2:Array;

        protected var decKey3:Array;
    }
}


//      class XTeaKey
package com.hurlant.crypto.symmetric 
{
    import com.hurlant.crypto.prng.*;
    import com.hurlant.util.*;
    import flash.utils.*;
    
    public class XTeaKey extends Object implements com.hurlant.crypto.symmetric.ISymmetricKey
    {
        public function XTeaKey(arg1:flash.utils.ByteArray)
        {
            super();
            arg1.position = 0;
            k = [arg1.readUnsignedInt(), arg1.readUnsignedInt(), arg1.readUnsignedInt(), arg1.readUnsignedInt()];
            return;
        }

        public function encrypt(arg1:flash.utils.ByteArray, arg2:uint=0):void
        {
            var loc3:*=0;
            arg1.position = arg2;
            var loc1:*=arg1.readUnsignedInt();
            var loc2:*=arg1.readUnsignedInt();
            var loc4:*=0;
            var loc5:*=2654435769;
            loc3 = 0;
            while (loc3 < NUM_ROUNDS) 
            {
                loc1 = loc1 + ((loc2 << 4 ^ loc2 >> 5) + loc2 ^ loc4 + k[loc4 & 3]);
                loc4 = loc4 + loc5;
                loc2 = loc2 + ((loc1 << 4 ^ loc1 >> 5) + loc1 ^ loc4 + k[loc4 >> 11 & 3]);
                ++loc3;
            }
            arg1.position = arg1.position - 8;
            arg1.writeUnsignedInt(loc1);
            arg1.writeUnsignedInt(loc2);
            return;
        }

        public function decrypt(arg1:flash.utils.ByteArray, arg2:uint=0):void
        {
            var loc3:*=0;
            arg1.position = arg2;
            var loc1:*=arg1.readUnsignedInt();
            var loc2:*=arg1.readUnsignedInt();
            var loc4:*=2654435769;
            var loc5:*=loc4 * NUM_ROUNDS;
            loc3 = 0;
            while (loc3 < NUM_ROUNDS) 
            {
                loc2 = loc2 - ((loc1 << 4 ^ loc1 >> 5) + loc1 ^ loc5 + k[loc5 >> 11 & 3]);
                loc5 = loc5 - loc4;
                loc1 = loc1 - ((loc2 << 4 ^ loc2 >> 5) + loc2 ^ loc5 + k[loc5 & 3]);
                ++loc3;
            }
            arg1.position = arg1.position - 8;
            arg1.writeUnsignedInt(loc1);
            arg1.writeUnsignedInt(loc2);
            return;
        }

        public function getBlockSize():uint
        {
            return 8;
        }

        public function toString():String
        {
            return "xtea";
        }

        public function dispose():void
        {
            var loc1:*=new com.hurlant.crypto.prng.Random();
            var loc2:*=0;
            while (loc2 < k.length) 
            {
                k[loc2] = loc1.nextByte();
                delete k[loc2];
                ++loc2;
            }
            k = null;
            com.hurlant.util.Memory.gc();
            return;
        }

        public static function parseKey(arg1:String):com.hurlant.crypto.symmetric.XTeaKey
        {
            var loc1:*=new flash.utils.ByteArray();
            loc1.writeUnsignedInt(parseInt(arg1.substr(0, 8), 16));
            loc1.writeUnsignedInt(parseInt(arg1.substr(8, 8), 16));
            loc1.writeUnsignedInt(parseInt(arg1.substr(16, 8), 16));
            loc1.writeUnsignedInt(parseInt(arg1.substr(24, 8), 16));
            loc1.position = 0;
            return new XTeaKey(loc1);
        }

        public const NUM_ROUNDS:uint=64;

        internal var k:Array;
    }
}


//    class Crypto
package com.hurlant.crypto 
{
    import com.hurlant.crypto.hash.*;
    import com.hurlant.crypto.prng.*;
    import com.hurlant.crypto.rsa.*;
    import com.hurlant.crypto.symmetric.*;
    import com.hurlant.util.*;
    import flash.utils.*;
    
    public class Crypto extends Object
    {
        public function Crypto()
        {
            super();
            return;
        }

        public static function getCipher(arg1:String, arg2:flash.utils.ByteArray, arg3:com.hurlant.crypto.symmetric.IPad=null):com.hurlant.crypto.symmetric.ICipher
        {
            var loc2:*=null;
            var loc1:*=arg1.split("-");
            var loc3:*=loc1[0];
            switch (loc3) 
            {
                case "simple":
                {
                    loc1.shift();
                    arg1 = loc1.join("-");
                    loc2 = getCipher(arg1, arg2, arg3);
                    if (loc2 is com.hurlant.crypto.symmetric.IVMode) 
                    {
                        return new com.hurlant.crypto.symmetric.SimpleIVMode(loc2 as com.hurlant.crypto.symmetric.IVMode);
                    }
                    return loc2;
                }
                case "aes":
                case "aes128":
                case "aes192":
                case "aes256":
                {
                    loc1.shift();
                    if (arg2.length * 8 == loc1[0]) 
                    {
                        loc1.shift();
                    }
                    return getMode(loc1[0], new com.hurlant.crypto.symmetric.AESKey(arg2), arg3);
                }
                case "bf":
                case "blowfish":
                {
                    loc1.shift();
                    return getMode(loc1[0], new com.hurlant.crypto.symmetric.BlowFishKey(arg2), arg3);
                }
                case "des":
                {
                    loc1.shift();
                    if (!(loc1[0] == "ede") && !(loc1[0] == "ede3")) 
                    {
                        return getMode(loc1[0], new com.hurlant.crypto.symmetric.DESKey(arg2), arg3);
                    }
                    if (loc1.length == 1) 
                    {
                        loc1.push("ecb");
                    }
                }
                case "3des":
                case "des3":
                {
                    loc1.shift();
                    return getMode(loc1[0], new com.hurlant.crypto.symmetric.TripleDESKey(arg2), arg3);
                }
                case "xtea":
                {
                    loc1.shift();
                    return getMode(loc1[0], new com.hurlant.crypto.symmetric.XTeaKey(arg2), arg3);
                }
                case "rc4":
                {
                    loc1.shift();
                    return new com.hurlant.crypto.prng.ARC4(arg2);
                }
            }
            return null;
        }

        public static function getHash(arg1:String):com.hurlant.crypto.hash.IHash
        {
            var loc1:*=arg1;
            switch (loc1) 
            {
                case "md2":
                {
                    return new com.hurlant.crypto.hash.MD2();
                }
                case "md5":
                {
                    return new com.hurlant.crypto.hash.MD5();
                }
                case "sha":
                case "sha1":
                {
                    return new com.hurlant.crypto.hash.SHA1();
                }
                case "sha224":
                {
                    return new com.hurlant.crypto.hash.SHA224();
                }
                case "sha256":
                {
                    return new com.hurlant.crypto.hash.SHA256();
                }
            }
            return null;
        }

        public static function getRSA(arg1:String, arg2:String):com.hurlant.crypto.rsa.RSAKey
        {
            return com.hurlant.crypto.rsa.RSAKey.parsePublicKey(arg2, arg1);
        }

        internal static function getMode(arg1:String, arg2:com.hurlant.crypto.symmetric.ISymmetricKey, arg3:com.hurlant.crypto.symmetric.IPad=null):com.hurlant.crypto.symmetric.IMode
        {
            var loc1:*=arg1;
            switch (loc1) 
            {
                case "ecb":
                {
                    return new com.hurlant.crypto.symmetric.ECBMode(arg2, arg3);
                }
                case "cfb":
                {
                    return new com.hurlant.crypto.symmetric.CFBMode(arg2, arg3);
                }
                case "cfb8":
                {
                    return new com.hurlant.crypto.symmetric.CFB8Mode(arg2, arg3);
                }
                case "ofb":
                {
                    return new com.hurlant.crypto.symmetric.OFBMode(arg2, arg3);
                }
                case "ctr":
                {
                    return new com.hurlant.crypto.symmetric.CTRMode(arg2, arg3);
                }
                case "cbc":
                default:
                {
                    return new com.hurlant.crypto.symmetric.CBCMode(arg2, arg3);
                }
            }
        }

        public static function getKeySize(arg1:String):uint
        {
            var loc1:*=arg1.split("-");
            var loc2:*=loc1[0];
            switch (loc2) 
            {
                case "simple":
                {
                    loc1.shift();
                    return getKeySize(loc1.join("-"));
                }
                case "aes128":
                {
                    return 16;
                }
                case "aes192":
                {
                    return 24;
                }
                case "aes256":
                {
                    return 32;
                }
                case "aes":
                {
                    loc1.shift();
                    return parseInt(loc1[0]) / 8;
                }
                case "bf":
                case "blowfish":
                {
                    return 16;
                }
                case "des":
                {
                    loc1.shift();
                    loc2 = loc1[0];
                    switch (loc2) 
                    {
                        case "ede":
                        {
                            return 16;
                        }
                        case "ede3":
                        {
                            return 24;
                        }
                        default:
                        {
                            return 8;
                        }
                    }
                }
                case "3des":
                case "des3":
                {
                    return 24;
                }
                case "xtea":
                {
                    return 8;
                }
                case "rc4":
                {
                    if (parseInt(loc1[1]) > 0) 
                    {
                        return parseInt(loc1[1]) / 8;
                    }
                    return 16;
                }
            }
            return 0;
        }

        public static function getPad(arg1:String):com.hurlant.crypto.symmetric.IPad
        {
            var loc1:*=arg1;
            switch (loc1) 
            {
                case "null":
                {
                    return new com.hurlant.crypto.symmetric.NullPad();
                }
                case "pkcs5":
                default:
                {
                    return new com.hurlant.crypto.symmetric.PKCS5();
                }
            }
        }

        public static function getHMAC(arg1:String):com.hurlant.crypto.hash.HMAC
        {
            var loc1:*=arg1.split("-");
            if (loc1[0] == "hmac") 
            {
                loc1.shift();
            }
            var loc2:*=0;
            if (loc1.length > 1) 
            {
                loc2 = parseInt(loc1[1]);
            }
            return new com.hurlant.crypto.hash.HMAC(getHash(loc1[0]), loc2);
        }

        internal var b64:com.hurlant.util.Base64;
    }
}


//  package math
//    class BarrettReduction
package com.hurlant.math 
{
    use namespace bi_internal;
    
    internal class BarrettReduction extends Object implements com.hurlant.math.IReduction
    {
        public function BarrettReduction(arg1:com.hurlant.math.BigInteger)
        {
            super();
            r2 = new com.hurlant.math.BigInteger();
            q3 = new com.hurlant.math.BigInteger();
            com.hurlant.math.BigInteger.ONE.bi_internal::dlShiftTo(2 * arg1.t, r2);
            mu = r2.divide(arg1);
            this.m = arg1;
            return;
        }

        public function revert(arg1:com.hurlant.math.BigInteger):com.hurlant.math.BigInteger
        {
            return arg1;
        }

        public function sqrTo(arg1:com.hurlant.math.BigInteger, arg2:com.hurlant.math.BigInteger):void
        {
            arg1.bi_internal::squareTo(arg2);
            reduce(arg2);
            return;
        }

        public function convert(arg1:com.hurlant.math.BigInteger):com.hurlant.math.BigInteger
        {
            var loc1:*=null;
            if (arg1.bi_internal::s < 0 || arg1.t > 2 * m.t) 
            {
                return arg1.mod(m);
            }
            if (arg1.compareTo(m) < 0) 
            {
                return arg1;
            }
            loc1 = new com.hurlant.math.BigInteger();
            arg1.bi_internal::copyTo(loc1);
            reduce(loc1);
            return loc1;
        }

        public function reduce(arg1:com.hurlant.math.BigInteger):void
        {
            var loc1:*=arg1 as com.hurlant.math.BigInteger;
            loc1.bi_internal::drShiftTo((m.t - 1), r2);
            if (loc1.t > m.t + 1) 
            {
                loc1.t = m.t + 1;
                loc1.bi_internal::clamp();
            }
            mu.bi_internal::multiplyUpperTo(r2, m.t + 1, q3);
            m.bi_internal::multiplyLowerTo(q3, m.t + 1, r2);
            while (loc1.compareTo(r2) < 0) 
            {
                loc1.bi_internal::dAddOffset(1, m.t + 1);
            }
            loc1.bi_internal::subTo(r2, loc1);
            while (loc1.compareTo(m) >= 0) 
            {
                loc1.bi_internal::subTo(m, loc1);
            }
            return;
        }

        public function mulTo(arg1:com.hurlant.math.BigInteger, arg2:com.hurlant.math.BigInteger, arg3:com.hurlant.math.BigInteger):void
        {
            arg1.bi_internal::multiplyTo(arg2, arg3);
            reduce(arg3);
            return;
        }

        internal var r2:com.hurlant.math.BigInteger;

        internal var q3:com.hurlant.math.BigInteger;

        internal var mu:com.hurlant.math.BigInteger;

        internal var m:com.hurlant.math.BigInteger;
    }
}


//    class BigInteger
package com.hurlant.math 
{
    import com.hurlant.crypto.prng.*;
    import com.hurlant.util.*;
    import flash.utils.*;
    
    use namespace bi_internal;
    
    public class BigInteger extends Object
    {
        public function BigInteger(arg1:*=null, arg2:int=0)
        {
            var loc1:*=null;
            var loc2:*=0;
            super();
            bi_internal::a = new Array();
            if (arg1 is String) 
            {
                arg1 = com.hurlant.util.Hex.toArray(arg1);
                arg2 = 0;
            }
            if (arg1 is flash.utils.ByteArray) 
            {
                loc1 = arg1 as flash.utils.ByteArray;
                loc2 = arg2 || loc1.length - loc1.position;
                bi_internal::fromArray(loc1, loc2);
            }
            return;
        }

        public function clearBit(arg1:int):com.hurlant.math.BigInteger
        {
            return changeBit(arg1, op_andnot);
        }

        internal function op_or(arg1:int, arg2:int):int
        {
            return arg1 | arg2;
        }

        public function negate():com.hurlant.math.BigInteger
        {
            var loc1:*=nbi();
            ZERO.bi_internal::subTo(this, loc1);
            return loc1;
        }

        public function andNot(arg1:com.hurlant.math.BigInteger):com.hurlant.math.BigInteger
        {
            var loc1:*=new com.hurlant.math.BigInteger();
            bitwiseTo(arg1, op_andnot, loc1);
            return loc1;
        }

        public function modPow(arg1:com.hurlant.math.BigInteger, arg2:com.hurlant.math.BigInteger):com.hurlant.math.BigInteger
        {
            var loc2:*=0;
            var loc4:*=null;
            var loc10:*=0;
            var loc13:*=null;
            var loc14:*=null;
            var loc1:*=arg1.bitLength();
            var loc3:*=nbv(1);
            if (loc1 <= 0) 
            {
                return loc3;
            }
            if (loc1 < 18) 
            {
                loc2 = 1;
            }
            else if (loc1 < 48) 
            {
                loc2 = 3;
            }
            else if (loc1 < 144) 
            {
                loc2 = 4;
            }
            else if (loc1 < 768) 
            {
                loc2 = 5;
            }
            else 
            {
                loc2 = 6;
            }
            if (loc1 < 8) 
            {
                loc4 = new ClassicReduction(arg2);
            }
            else if (arg2.bi_internal::isEven()) 
            {
                loc4 = new BarrettReduction(arg2);
            }
            else 
            {
                loc4 = new MontgomeryReduction(arg2);
            }
            var loc5:*=[];
            var loc6:*=3;
            var loc7:*;
            --loc7;
            var loc8:*=(1 << loc2 - 1);
            loc5[1] = loc4.convert(this);
            if (loc2 > 1) 
            {
                loc14 = new com.hurlant.math.BigInteger();
                loc4.sqrTo(loc5[1], loc14);
                while (loc6 <= loc8) 
                {
                    loc5[loc6] = new com.hurlant.math.BigInteger();
                    loc4.mulTo(loc14, loc5[loc6 - 2], loc5[loc6]);
                    loc6 = loc6 + 2;
                }
            }
            var loc9:*=(arg1.t - 1);
            var loc11:*=true;
            var loc12:*=new com.hurlant.math.BigInteger();
            loc1 = (bi_internal::nbits(arg1.bi_internal::a[loc9]) - 1);
            while (loc9 >= 0) 
            {
                if (loc1 >= loc7) 
                {
                    loc10 = arg1.bi_internal::a[loc9] >> loc1 - loc7 & loc8;
                }
                else 
                {
                    loc10 = (arg1.bi_internal::a[loc9] & (1 << loc1 + 1 - 1)) << loc7 - loc1;
                    if (loc9 > 0) 
                    {
                        loc10 = loc10 | arg1.bi_internal::a[(loc9 - 1)] >> DB + loc1 - loc7;
                    }
                }
                loc6 = loc2;
                while ((loc10 & 1) == 0) 
                {
                    loc10 = loc10 >> 1;
                    --loc6;
                }
                var loc15:*;
                loc1 = loc15 = loc1 - loc6;
                if (loc15 < 0) 
                {
                    loc1 = loc1 + DB;
                    --loc9;
                }
                if (loc11) 
                {
                    loc5[loc10].copyTo(loc3);
                    loc11 = false;
                }
                else 
                {
                    while (loc6 > 1) 
                    {
                        loc4.sqrTo(loc3, loc12);
                        loc4.sqrTo(loc12, loc3);
                        loc6 = loc6 - 2;
                    }
                    if (loc6 > 0) 
                    {
                        loc4.sqrTo(loc3, loc12);
                    }
                    else 
                    {
                        loc13 = loc3;
                        loc3 = loc12;
                        loc12 = loc13;
                    }
                    loc4.mulTo(loc12, loc5[loc10], loc3);
                }
                while (loc9 >= 0 && (arg1.bi_internal::a[loc9] & 1 << loc1) == 0) 
                {
                    loc4.sqrTo(loc3, loc12);
                    loc13 = loc3;
                    loc3 = loc12;
                    loc12 = loc13;
                    if (!(--loc1 < 0)) 
                    {
                        continue;
                    }
                    loc1 = (DB - 1);
                    --loc9;
                }
            }
            return loc4.revert(loc3);
        }

        public function isProbablePrime(arg1:int):Boolean
        {
            var loc1:*=0;
            var loc3:*=0;
            var loc4:*=0;
            var loc2:*=abs();
            if (loc2.t == 1 && loc2.bi_internal::a[0] <= lowprimes[(lowprimes.length - 1)]) 
            {
                loc1 = 0;
                while (loc1 < lowprimes.length) 
                {
                    if (loc2[0] == lowprimes[loc1]) 
                    {
                        return true;
                    }
                    ++loc1;
                }
                return false;
            }
            if (loc2.bi_internal::isEven()) 
            {
                return false;
            }
            loc1 = 1;
            while (loc1 < lowprimes.length) 
            {
                loc3 = lowprimes[loc1];
                loc4 = loc1 + 1;
                while (loc4 < lowprimes.length && loc3 < lplim) 
                {
                    loc3 = loc3 * lowprimes[loc4++];
                }
                loc3 = loc2.modInt(loc3);
                while (loc1 < loc4) 
                {
                    if (loc3 % lowprimes[loc1++] != 0) 
                    {
                        continue;
                    }
                    return false;
                }
            }
            return loc2.millerRabin(arg1);
        }

        public function divide(arg1:com.hurlant.math.BigInteger):com.hurlant.math.BigInteger
        {
            var loc1:*=new com.hurlant.math.BigInteger();
            bi_internal::divRemTo(arg1, loc1, null);
            return loc1;
        }

        public function mod(arg1:com.hurlant.math.BigInteger):com.hurlant.math.BigInteger
        {
            var loc1:*=nbi();
            abs().bi_internal::divRemTo(arg1, null, loc1);
            if (bi_internal::s < 0 && loc1.compareTo(ZERO) > 0) 
            {
                arg1.bi_internal::subTo(loc1, loc1);
            }
            return loc1;
        }

        protected function addTo(arg1:com.hurlant.math.BigInteger, arg2:com.hurlant.math.BigInteger):void
        {
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=Math.min(arg1.t, t);
            while (loc1 < loc3) 
            {
                loc2 = loc2 + (this.bi_internal::a[loc1] + arg1.bi_internal::a[loc1]);
                var loc4:*;
                arg2.bi_internal::a[loc4 = loc1++] = loc2 & DM;
                loc2 = loc2 >> DB;
            }
            if (arg1.t < t) 
            {
                loc2 = loc2 + arg1.bi_internal::s;
                while (loc1 < t) 
                {
                    loc2 = loc2 + this.bi_internal::a[loc1];
                    arg2.bi_internal::a[loc4 = loc1++] = loc2 & DM;
                    loc2 = loc2 >> DB;
                }
                loc2 = loc2 + bi_internal::s;
            }
            else 
            {
                loc2 = loc2 + bi_internal::s;
                while (loc1 < arg1.t) 
                {
                    loc2 = loc2 + arg1.bi_internal::a[loc1];
                    arg2.bi_internal::a[loc4 = loc1++] = loc2 & DM;
                    loc2 = loc2 >> DB;
                }
                loc2 = loc2 + arg1.bi_internal::s;
            }
            arg2.bi_internal::s = loc2 < 0 ? -1 : 0;
            if (loc2 > 0) 
            {
                arg2.bi_internal::a[loc4 = loc1++] = loc2;
            }
            else if (loc2 < -1) 
            {
                arg2.bi_internal::a[loc4 = loc1++] = DV + loc2;
            }
            arg2.t = loc1;
            arg2.bi_internal::clamp();
            return;
        }

        protected function bitwiseTo(arg1:com.hurlant.math.BigInteger, arg2:Function, arg3:com.hurlant.math.BigInteger):void
        {
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=Math.min(arg1.t, t);
            loc1 = 0;
            while (loc1 < loc3) 
            {
                arg3.bi_internal::a[loc1] = arg2(this.bi_internal::a[loc1], arg1.bi_internal::a[loc1]);
                ++loc1;
            }
            if (arg1.t < t) 
            {
                loc2 = arg1.bi_internal::s & DM;
                loc1 = loc3;
                while (loc1 < t) 
                {
                    arg3.bi_internal::a[loc1] = arg2(this.bi_internal::a[loc1], loc2);
                    ++loc1;
                }
                arg3.t = t;
            }
            else 
            {
                loc2 = bi_internal::s & DM;
                loc1 = loc3;
                while (loc1 < arg1.t) 
                {
                    arg3.bi_internal::a[loc1] = arg2(loc2, arg1.bi_internal::a[loc1]);
                    ++loc1;
                }
                arg3.t = arg1.t;
            }
            arg3.bi_internal::s = arg2(bi_internal::s, arg1.bi_internal::s);
            arg3.bi_internal::clamp();
            return;
        }

        protected function modInt(arg1:int):int
        {
            var loc3:*=0;
            if (arg1 <= 0) 
            {
                return 0;
            }
            var loc1:*=DV % arg1;
            var loc2:*=bi_internal::s < 0 ? (arg1 - 1) : 0;
            if (t > 0) 
            {
                if (loc1 != 0) 
                {
                    loc3 = (t - 1);
                    while (loc3 >= 0) 
                    {
                        loc2 = (loc1 * loc2 + bi_internal::a[loc3]) % arg1;
                        --loc3;
                    }
                }
                else 
                {
                    loc2 = bi_internal::a[0] % arg1;
                }
            }
            return loc2;
        }

        protected function chunkSize(arg1:Number):int
        {
            return Math.floor(Math.LN2 * DB / Math.log(arg1));
        }

        public function gcd(arg1:com.hurlant.math.BigInteger):com.hurlant.math.BigInteger
        {
            var loc5:*=null;
            var loc1:*=bi_internal::s < 0 ? negate() : clone();
            var loc2:*=arg1.bi_internal::s < 0 ? arg1.negate() : arg1.clone();
            if (loc1.compareTo(loc2) < 0) 
            {
                loc5 = loc1;
                loc1 = loc2;
                loc2 = loc5;
            }
            var loc3:*=loc1.getLowestSetBit();
            var loc4:*=loc2.getLowestSetBit();
            if (loc4 < 0) 
            {
                return loc1;
            }
            if (loc3 < loc4) 
            {
                loc4 = loc3;
            }
            if (loc4 > 0) 
            {
                loc1.bi_internal::rShiftTo(loc4, loc1);
                loc2.bi_internal::rShiftTo(loc4, loc2);
            }
            while (loc1.sigNum() > 0) 
            {
                var loc6:*;
                loc3 = loc6 = loc1.getLowestSetBit();
                if (loc6 > 0) 
                {
                    loc1.bi_internal::rShiftTo(loc3, loc1);
                }
                loc3 = loc6 = loc2.getLowestSetBit();
                if (loc6 > 0) 
                {
                    loc2.bi_internal::rShiftTo(loc3, loc2);
                }
                if (loc1.compareTo(loc2) >= 0) 
                {
                    loc1.bi_internal::subTo(loc2, loc1);
                    loc1.bi_internal::rShiftTo(1, loc1);
                    continue;
                }
                loc2.bi_internal::subTo(loc1, loc2);
                loc2.bi_internal::rShiftTo(1, loc2);
            }
            if (loc4 > 0) 
            {
                loc2.bi_internal::lShiftTo(loc4, loc2);
            }
            return loc2;
        }

        bi_internal function dAddOffset(arg1:int, arg2:int):void
        {
            while (t <= arg2) 
            {
                var loc2:*;
                var loc1:*=t++;
                bi_internal::a[loc1] = 0;
            }
            bi_internal::a[arg2] = bi_internal::a[arg2] + arg1;
            while (bi_internal::a[arg2] >= DV) 
            {
                bi_internal::a[arg2] = bi_internal::a[arg2] - DV;
                if (++arg2 >= t) 
                {
                    loc1 = t++;
                    bi_internal::a[loc1] = 0;
                }
                loc3 = ((loc1 = bi_internal::a)[loc2 = arg2] + 1);
                loc1[loc2] = loc3;
            }
            return;
        }

        bi_internal function lShiftTo(arg1:int, arg2:com.hurlant.math.BigInteger):void
        {
            var loc6:*=0;
            var loc1:*=arg1 % DB;
            var loc2:*=DB - loc1;
            var loc3:*=(1 << loc2 - 1);
            var loc4:*=arg1 / DB;
            var loc5:*=bi_internal::s << loc1 & DM;
            loc6 = (t - 1);
            while (loc6 >= 0) 
            {
                arg2.bi_internal::a[loc6 + loc4 + 1] = bi_internal::a[loc6] >> loc2 | loc5;
                loc5 = (bi_internal::a[loc6] & loc3) << loc1;
                --loc6;
            }
            --loc6;
            while (loc6 >= 0) 
            {
                arg2.bi_internal::a[loc6] = 0;
                --loc6;
            }
            arg2.bi_internal::a[loc4] = loc5;
            arg2.t = t + loc4 + 1;
            arg2.bi_internal::s = bi_internal::s;
            arg2.bi_internal::clamp();
            return;
        }

        public function getLowestSetBit():int
        {
            var loc1:*=0;
            while (loc1 < t) 
            {
                if (bi_internal::a[loc1] != 0) 
                {
                    return loc1 * DB + lbit(bi_internal::a[loc1]);
                }
                ++loc1;
            }
            if (bi_internal::s < 0) 
            {
                return t * DB;
            }
            return -1;
        }

        public function subtract(arg1:com.hurlant.math.BigInteger):com.hurlant.math.BigInteger
        {
            var loc1:*=new com.hurlant.math.BigInteger();
            bi_internal::subTo(arg1, loc1);
            return loc1;
        }

        public function primify(arg1:int, arg2:int):void
        {
            if (!testBit((arg1 - 1))) 
            {
                bitwiseTo(com.hurlant.math.BigInteger.ONE.shiftLeft((arg1 - 1)), op_or, this);
            }
            if (bi_internal::isEven()) 
            {
                bi_internal::dAddOffset(1, 0);
            }
            while (!isProbablePrime(arg2)) 
            {
                bi_internal::dAddOffset(2, 0);
                while (bitLength() > arg1) 
                {
                    bi_internal::subTo(com.hurlant.math.BigInteger.ONE.shiftLeft((arg1 - 1)), this);
                }
            }
            return;
        }

        bi_internal function multiplyLowerTo(arg1:com.hurlant.math.BigInteger, arg2:int, arg3:com.hurlant.math.BigInteger):void
        {
            var loc2:*=0;
            var loc1:*=Math.min(t + arg1.t, arg2);
            arg3.bi_internal::s = 0;
            arg3.t = loc1;
            while (loc1 > 0) 
            {
                var loc3:*;
                arg3.bi_internal::a[loc3 = --loc1] = 0;
            }
            loc2 = arg3.t - t;
            while (loc1 < loc2) 
            {
                arg3.bi_internal::a[loc1 + t] = bi_internal::am(0, arg1.bi_internal::a[loc1], arg3, loc1, 0, t);
                ++loc1;
            }
            loc2 = Math.min(arg1.t, arg2);
            while (loc1 < loc2) 
            {
                bi_internal::am(0, arg1.bi_internal::a[loc1], arg3, loc1, 0, arg2 - loc1);
                ++loc1;
            }
            arg3.bi_internal::clamp();
            return;
        }

        public function modPowInt(arg1:int, arg2:com.hurlant.math.BigInteger):com.hurlant.math.BigInteger
        {
            var loc1:*=null;
            if (arg1 < 256 || arg2.bi_internal::isEven()) 
            {
                loc1 = new ClassicReduction(arg2);
            }
            else 
            {
                loc1 = new MontgomeryReduction(arg2);
            }
            return bi_internal::exp(arg1, loc1);
        }

        bi_internal function intAt(arg1:String, arg2:int):int
        {
            return parseInt(arg1.charAt(arg2), 36);
        }

        public function testBit(arg1:int):Boolean
        {
            var loc1:*=Math.floor(arg1 / DB);
            if (loc1 >= t) 
            {
                return !(bi_internal::s == 0);
            }
            return !((bi_internal::a[loc1] & 1 << arg1 % DB) == 0);
        }

        bi_internal function exp(arg1:int, arg2:IReduction):com.hurlant.math.BigInteger
        {
            var loc5:*=null;
            if (arg1 > 4294967295 || arg1 < 1) 
            {
                return ONE;
            }
            var loc1:*=nbi();
            var loc2:*=nbi();
            var loc3:*=arg2.convert(this);
            var loc4:*=(bi_internal::nbits(arg1) - 1);
            loc3.bi_internal::copyTo(loc1);
            while (--loc4 >= 0) 
            {
                arg2.sqrTo(loc1, loc2);
                if ((arg1 & 1 << loc4) > 0) 
                {
                    arg2.mulTo(loc2, loc3, loc1);
                    continue;
                }
                loc5 = loc1;
                loc1 = loc2;
                loc2 = loc5;
            }
            return arg2.revert(loc1);
        }

        public function toArray(arg1:flash.utils.ByteArray):uint
        {
            var loc1:*=8;
            var loc2:*=(1 << 8 - 1);
            var loc3:*=0;
            var loc4:*=t;
            var loc5:*=DB - loc4 * DB % loc1;
            var loc6:*=false;
            var loc7:*=0;
            if (loc4-- > 0) 
            {
                if (loc5 < DB) 
                {
                    loc5 < DB;
                    var loc8:*;
                    loc3 = loc8 = bi_internal::a[loc4] >> loc5;
                }
                if (loc5 < DB) 
                {
                    loc6 = true;
                    arg1.writeByte(loc3);
                    ++loc7;
                }
                while (loc4 >= 0) 
                {
                    if (loc5 < loc1) 
                    {
                        loc3 = (bi_internal::a[loc4] & (1 << loc5 - 1)) << loc1 - loc5;
                        loc5 = loc8 = loc5 + (DB - loc1);
                        loc3 = loc3 | bi_internal::a[--loc4] >> loc8;
                    }
                    else 
                    {
                        loc5 = loc8 = loc5 - loc1;
                        loc3 = bi_internal::a[loc4] >> loc8 & loc2;
                        if (loc5 <= 0) 
                        {
                            loc5 = loc5 + DB;
                            --loc4;
                        }
                    }
                    if (loc3 > 0) 
                    {
                        loc6 = true;
                    }
                    if (!loc6) 
                    {
                        continue;
                    }
                    arg1.writeByte(loc3);
                    ++loc7;
                }
            }
            return loc7;
        }

        public function dispose():void
        {
            var loc1:*=new com.hurlant.crypto.prng.Random();
            var loc2:*=0;
            while (loc2 < bi_internal::a.length) 
            {
                bi_internal::a[loc2] = loc1.nextByte();
                delete bi_internal::a[loc2];
                ++loc2;
            }
            bi_internal::a = null;
            t = 0;
            bi_internal::s = 0;
            com.hurlant.util.Memory.gc();
            return;
        }

        internal function lbit(arg1:int):int
        {
            if (arg1 == 0) 
            {
                return -1;
            }
            var loc1:*=0;
            if ((arg1 & 65535) == 0) 
            {
                arg1 = arg1 >> 16;
                loc1 = loc1 + 16;
            }
            if ((arg1 & 255) == 0) 
            {
                arg1 = arg1 >> 8;
                loc1 = loc1 + 8;
            }
            if ((arg1 & 15) == 0) 
            {
                arg1 = arg1 >> 4;
                loc1 = loc1 + 4;
            }
            if ((arg1 & 3) == 0) 
            {
                arg1 = arg1 >> 2;
                loc1 = loc1 + 2;
            }
            if ((arg1 & 1) == 0) 
            {
                ++loc1;
            }
            return loc1;
        }

        bi_internal function divRemTo(arg1:com.hurlant.math.BigInteger, arg2:com.hurlant.math.BigInteger=null, arg3:com.hurlant.math.BigInteger=null):void
        {
            var y:com.hurlant.math.BigInteger;
            var nsh:int;
            var pt:com.hurlant.math.BigInteger;
            var d1:Number;
            var d2:Number;
            var qd:int;
            var y0:int;
            var yt:Number;
            var ys:int;
            var e:Number;
            var ms:int;
            var j:int;
            var m:com.hurlant.math.BigInteger;
            var i:int;
            var q:com.hurlant.math.BigInteger=null;
            var r:com.hurlant.math.BigInteger=null;
            var t:com.hurlant.math.BigInteger;
            var pm:com.hurlant.math.BigInteger;
            var ts:int;

            var loc1:*;
            qd = 0;
            m = arg1;
            q = arg2;
            r = arg3;
            pm = m.abs();
            if (pm.t <= 0) 
            {
                return;
            }
            pt = abs();
            if (pt.t < pm.t) 
            {
                if (q != null) 
                {
                    q.bi_internal::fromInt(0);
                }
                if (r != null) 
                {
                    bi_internal::copyTo(r);
                }
                return;
            }
            if (r == null) 
            {
                r = nbi();
            }
            y = nbi();
            ts = bi_internal::s;
            ms = m.bi_internal::s;
            nsh = DB - bi_internal::nbits(pm.bi_internal::a[(pm.t - 1)]);
            if (nsh > 0) 
            {
                pm.bi_internal::lShiftTo(nsh, y);
                pt.bi_internal::lShiftTo(nsh, r);
            }
            else 
            {
                pm.bi_internal::copyTo(y);
                pt.bi_internal::copyTo(r);
            }
            ys = y.t;
            y0 = y.bi_internal::a[(ys - 1)];
            if (y0 == 0) 
            {
                return;
            }
            yt = y0 * (1 << F1) + (ys > 1 ? y.bi_internal::a[ys - 2] >> F2 : 0);
            d1 = FV / yt;
            d2 = (1 << F1) / yt;
            e = 1 << F2;
            i = r.t;
            j = i - ys;
            t = q != null ? q : nbi();
            y.bi_internal::dlShiftTo(j, t);
            if (r.compareTo(t) >= 0) 
            {
                var loc3:*;
                var loc4:*=((loc3 = r).t + 1);
                loc3.t = loc4;
                var loc2:*;
                r.bi_internal::a[loc2 = (loc3 = r).t] = 1;
                r.bi_internal::subTo(t, r);
            }
            ONE.bi_internal::dlShiftTo(ys, t);
            t.bi_internal::subTo(y, y);
            while (y.t < ys) 
            {
                loc3 = 0;
                loc4 = y;
                loc2 = new XMLList("");
                for each (var loc5:* in loc4) 
                {
                    var loc6:*;
                    with (loc6 = loc5) 
                    {
                        var loc7:*;
                        var loc8:*=((loc7 = y).t + 1);
                        loc7.t = loc8;
                        if (0) 
                        {
                            loc2[loc3] = loc5;
                        }
                    }
                }
            }
            while ((j = (j - 1)) >= 0) 
            {
                qd = r.bi_internal::a[i = (i - 1)] != y0 ? Number(r.bi_internal::a[i]) * d1 + (Number(r.bi_internal::a[(i - 1)]) + e) * d2 : DM;
                r.bi_internal::a[i] = loc2 = r.bi_internal::a[i] + y.bi_internal::am(0, qd, r, j, 0, ys);
                if (!(loc2 < qd)) 
                {
                    continue;
                }
                y.bi_internal::dlShiftTo(j, t);
                r.bi_internal::subTo(t, r);
                while (r.bi_internal::a[i] < (qd = (qd - 1))) 
                {
                    r.bi_internal::subTo(t, r);
                }
            }
            if (q != null) 
            {
                r.bi_internal::drShiftTo(ys, q);
                if (ts != ms) 
                {
                    ZERO.bi_internal::subTo(q, q);
                }
            }
            r.t = ys;
            r.bi_internal::clamp();
            if (nsh > 0) 
            {
                r.bi_internal::rShiftTo(nsh, r);
            }
            if (ts < 0) 
            {
                ZERO.bi_internal::subTo(r, r);
            }
            return;
        }

        public function remainder(arg1:com.hurlant.math.BigInteger):com.hurlant.math.BigInteger
        {
            var loc1:*=new com.hurlant.math.BigInteger();
            bi_internal::divRemTo(arg1, null, loc1);
            return loc1;
        }

        bi_internal function multiplyUpperTo(arg1:com.hurlant.math.BigInteger, arg2:int, arg3:com.hurlant.math.BigInteger):void
        {
            --arg2;
            var loc2:*;
            arg3.t = loc2 = t + arg1.t - arg2;
            var loc1:*=loc2;
            arg3.bi_internal::s = 0;
            while (--loc1 >= 0) 
            {
                arg3.bi_internal::a[loc1] = 0;
            }
            loc1 = Math.max(arg2 - t, 0);
            while (loc1 < arg1.t) 
            {
                arg3.bi_internal::a[t + loc1 - arg2] = bi_internal::am(arg2 - loc1, arg1.bi_internal::a[loc1], arg3, 0, 0, t + loc1 - arg2);
                ++loc1;
            }
            arg3.bi_internal::clamp();
            arg3.bi_internal::drShiftTo(1, arg3);
            return;
        }

        public function divideAndRemainder(arg1:com.hurlant.math.BigInteger):Array
        {
            var loc1:*=new com.hurlant.math.BigInteger();
            var loc2:*=new com.hurlant.math.BigInteger();
            bi_internal::divRemTo(arg1, loc1, loc2);
            return [loc1, loc2];
        }

        public function valueOf():Number
        {
            var loc1:*=1;
            var loc2:*=0;
            var loc3:*=0;
            while (loc3 < t) 
            {
                loc2 = loc2 + bi_internal::a[loc3] * loc1;
                loc1 = loc1 * DV;
                ++loc3;
            }
            return loc2;
        }

        public function shiftLeft(arg1:int):com.hurlant.math.BigInteger
        {
            var loc1:*=new com.hurlant.math.BigInteger();
            if (arg1 < 0) 
            {
                bi_internal::rShiftTo(-arg1, loc1);
            }
            else 
            {
                bi_internal::lShiftTo(arg1, loc1);
            }
            return loc1;
        }

        public function multiply(arg1:com.hurlant.math.BigInteger):com.hurlant.math.BigInteger
        {
            var loc1:*=new com.hurlant.math.BigInteger();
            bi_internal::multiplyTo(arg1, loc1);
            return loc1;
        }

        bi_internal function am(arg1:int, arg2:int, arg3:com.hurlant.math.BigInteger, arg4:int, arg5:int, arg6:int):int
        {
            var loc3:*=0;
            var loc4:*=0;
            var loc5:*=0;
            var loc1:*=arg2 & 32767;
            var loc2:*=arg2 >> 15;
            while (--arg6 >= 0) 
            {
                loc3 = bi_internal::a[arg1] & 32767;
                loc4 = bi_internal::a[arg1++] >> 15;
                loc5 = loc2 * loc3 + loc4 * loc1;
                loc3 = loc1 * loc3 + ((loc5 & 32767) << 15) + arg3.bi_internal::a[arg4] + (arg5 & 1073741823);
                arg5 = (loc3 >>> 30) + (loc5 >>> 15) + loc2 * loc4 + (arg5 >>> 30);
                var loc6:*;
                arg3.bi_internal::a[loc6 = arg4++] = loc3 & 1073741823;
            }
            return arg5;
        }

        bi_internal function drShiftTo(arg1:int, arg2:com.hurlant.math.BigInteger):void
        {
            var loc1:*=0;
            loc1 = arg1;
            while (loc1 < t) 
            {
                arg2.bi_internal::a[loc1 - arg1] = bi_internal::a[loc1];
                ++loc1;
            }
            arg2.t = Math.max(t - arg1, 0);
            arg2.bi_internal::s = bi_internal::s;
            return;
        }

        public function add(arg1:com.hurlant.math.BigInteger):com.hurlant.math.BigInteger
        {
            var loc1:*=new com.hurlant.math.BigInteger();
            addTo(arg1, loc1);
            return loc1;
        }

        protected function nbi():*
        {
            return new com.hurlant.math.BigInteger();
        }

        protected function millerRabin(arg1:int):Boolean
        {
            var loc6:*=null;
            var loc7:*=0;
            var loc1:*=subtract(com.hurlant.math.BigInteger.ONE);
            var loc2:*=loc1.getLowestSetBit();
            if (loc2 <= 0) 
            {
                return false;
            }
            var loc3:*=loc1.shiftRight(loc2);
            arg1 = arg1 + 1 >> 1;
            if (arg1 > lowprimes.length) 
            {
                arg1 = lowprimes.length;
            }
            var loc4:*=new com.hurlant.math.BigInteger();
            var loc5:*=0;
            while (loc5 < arg1) 
            {
                loc4.bi_internal::fromInt(lowprimes[loc5]);
                loc6 = loc4.modPow(loc3, this);
                if (!(loc6.compareTo(com.hurlant.math.BigInteger.ONE) == 0) && !(loc6.compareTo(loc1) == 0)) 
                {
                    loc7 = 1;
                    while (loc7++ < loc2 && !(loc6.compareTo(loc1) == 0)) 
                    {
                        loc6 = loc6.modPowInt(2, this);
                        if (loc6.compareTo(com.hurlant.math.BigInteger.ONE) != 0) 
                        {
                            continue;
                        }
                        return false;
                    }
                    if (loc6.compareTo(loc1) != 0) 
                    {
                        return false;
                    }
                }
                ++loc5;
            }
            return true;
        }

        bi_internal function dMultiply(arg1:int):void
        {
            bi_internal::a[t] = bi_internal::am(0, (arg1 - 1), this, 0, 0, t);
            var loc1:*;
            t++;
            bi_internal::clamp();
            return;
        }

        internal function op_andnot(arg1:int, arg2:int):int
        {
            return arg1 & ~arg2;
        }

        bi_internal function clamp():void
        {
            var loc1:*=bi_internal::s & DM;
            while (t > 0 && bi_internal::a[(t - 1)] == loc1) 
            {
                var loc2:*;
                t--;
            }
            return;
        }

        bi_internal function invDigit():int
        {
            if (t < 1) 
            {
                return 0;
            }
            var loc1:*=bi_internal::a[0];
            if ((loc1 & 1) == 0) 
            {
                return 0;
            }
            var loc2:*=loc1 & 3;
            loc2 = loc2 * (2 - (loc1 & 15) * loc2) & 15;
            loc2 = loc2 * (2 - (loc1 & 255) * loc2) & 255;
            loc2 = loc2 * (2 - ((loc1 & 65535) * loc2 & 65535)) & 65535;
            loc2 = loc2 * (2 - loc1 * loc2 % DV) % DV;
            return loc2 > 0 ? DV - loc2 : -loc2;
        }

        protected function changeBit(arg1:int, arg2:Function):com.hurlant.math.BigInteger
        {
            var loc1:*=com.hurlant.math.BigInteger.ONE.shiftLeft(arg1);
            bitwiseTo(loc1, arg2, loc1);
            return loc1;
        }

        public function equals(arg1:com.hurlant.math.BigInteger):Boolean
        {
            return compareTo(arg1) == 0;
        }

        public function compareTo(arg1:com.hurlant.math.BigInteger):int
        {
            var loc1:*=bi_internal::s - arg1.bi_internal::s;
            if (loc1 != 0) 
            {
                return loc1;
            }
            var loc2:*=t;
            loc1 = loc2 - arg1.t;
            if (loc1 != 0) 
            {
                return loc1;
            }
            while (--loc2 >= 0) 
            {
                loc1 = bi_internal::a[loc2] - arg1.bi_internal::a[loc2];
                if (loc1 == 0) 
                {
                    continue;
                }
                return loc1;
            }
            return 0;
        }

        public function shiftRight(arg1:int):com.hurlant.math.BigInteger
        {
            var loc1:*=new com.hurlant.math.BigInteger();
            if (arg1 < 0) 
            {
                bi_internal::lShiftTo(-arg1, loc1);
            }
            else 
            {
                bi_internal::rShiftTo(arg1, loc1);
            }
            return loc1;
        }

        bi_internal function multiplyTo(arg1:com.hurlant.math.BigInteger, arg2:com.hurlant.math.BigInteger):void
        {
            var loc1:*=abs();
            var loc2:*=arg1.abs();
            var loc3:*=loc1.t;
            arg2.t = loc3 + loc2.t;
            while (--loc3 >= 0) 
            {
                arg2.bi_internal::a[loc3] = 0;
            }
            loc3 = 0;
            while (loc3 < loc2.t) 
            {
                arg2.bi_internal::a[loc3 + loc1.t] = loc1.bi_internal::am(0, loc2.bi_internal::a[loc3], arg2, loc3, 0, loc1.t);
                ++loc3;
            }
            arg2.bi_internal::s = 0;
            arg2.bi_internal::clamp();
            if (bi_internal::s != arg1.bi_internal::s) 
            {
                ZERO.bi_internal::subTo(arg2, arg2);
            }
            return;
        }

        public function bitCount():int
        {
            var loc1:*=0;
            var loc2:*=bi_internal::s & DM;
            var loc3:*=0;
            while (loc3 < t) 
            {
                loc1 = loc1 + cbit(bi_internal::a[loc3] ^ loc2);
                ++loc3;
            }
            return loc1;
        }

        protected function toRadix(arg1:uint=10):String
        {
            if (sigNum() == 0 || arg1 < 2 || arg1 > 32) 
            {
                return "0";
            }
            var loc1:*=chunkSize(arg1);
            var loc2:*=Math.pow(arg1, loc1);
            var loc3:*=nbv(loc2);
            var loc4:*=nbi();
            var loc5:*=nbi();
            var loc6:*="";
            bi_internal::divRemTo(loc3, loc4, loc5);
            while (loc4.sigNum() > 0) 
            {
                loc6 = (loc2 + loc5.intValue()).toString(arg1).substr(1) + loc6;
                loc4.bi_internal::divRemTo(loc3, loc4, loc5);
            }
            return loc5.intValue().toString(arg1) + loc6;
        }

        internal function cbit(arg1:int):int
        {
            var loc1:*=0;
            while (arg1 != 0) 
            {
                arg1 = arg1 & (arg1 - 1);
                ++loc1;
            }
            return loc1;
        }

        bi_internal function rShiftTo(arg1:int, arg2:com.hurlant.math.BigInteger):void
        {
            var loc5:*=0;
            arg2.bi_internal::s = bi_internal::s;
            var loc1:*=arg1 / DB;
            if (loc1 >= t) 
            {
                arg2.t = 0;
                return;
            }
            var loc2:*=arg1 % DB;
            var loc3:*=DB - loc2;
            var loc4:*=(1 << loc2 - 1);
            arg2.bi_internal::a[0] = bi_internal::a[loc1] >> loc2;
            loc5 = loc1 + 1;
            while (loc5 < t) 
            {
                arg2.bi_internal::a[(loc5 - loc1 - 1)] = arg2.bi_internal::a[(loc5 - loc1 - 1)] | (bi_internal::a[loc5] & loc4) << loc3;
                arg2.bi_internal::a[loc5 - loc1] = bi_internal::a[loc5] >> loc2;
                ++loc5;
            }
            if (loc2 > 0) 
            {
                arg2.bi_internal::a[(t - loc1 - 1)] = arg2.bi_internal::a[(t - loc1 - 1)] | (bi_internal::s & loc4) << loc3;
            }
            arg2.t = t - loc1;
            arg2.bi_internal::clamp();
            return;
        }

        public function modInverse(arg1:com.hurlant.math.BigInteger):com.hurlant.math.BigInteger
        {
            var loc1:*=arg1.bi_internal::isEven();
            if (bi_internal::isEven() && loc1 || arg1.sigNum() == 0) 
            {
                return com.hurlant.math.BigInteger.ZERO;
            }
            var loc2:*=arg1.clone();
            var loc3:*=clone();
            var loc4:*=nbv(1);
            var loc5:*=nbv(0);
            var loc6:*=nbv(0);
            var loc7:*=nbv(1);
            while (loc2.sigNum() != 0) 
            {
                while (loc2.bi_internal::isEven()) 
                {
                    loc2.bi_internal::rShiftTo(1, loc2);
                    if (loc1) 
                    {
                        if (!loc4.bi_internal::isEven() || !loc5.bi_internal::isEven()) 
                        {
                            loc4.addTo(this, loc4);
                            loc5.bi_internal::subTo(arg1, loc5);
                        }
                        loc4.bi_internal::rShiftTo(1, loc4);
                    }
                    else if (!loc5.bi_internal::isEven()) 
                    {
                        loc5.bi_internal::subTo(arg1, loc5);
                    }
                    loc5.bi_internal::rShiftTo(1, loc5);
                }
                while (loc3.bi_internal::isEven()) 
                {
                    loc3.bi_internal::rShiftTo(1, loc3);
                    if (loc1) 
                    {
                        if (!loc6.bi_internal::isEven() || !loc7.bi_internal::isEven()) 
                        {
                            loc6.addTo(this, loc6);
                            loc7.bi_internal::subTo(arg1, loc7);
                        }
                        loc6.bi_internal::rShiftTo(1, loc6);
                    }
                    else if (!loc7.bi_internal::isEven()) 
                    {
                        loc7.bi_internal::subTo(arg1, loc7);
                    }
                    loc7.bi_internal::rShiftTo(1, loc7);
                }
                if (loc2.compareTo(loc3) >= 0) 
                {
                    loc2.bi_internal::subTo(loc3, loc2);
                    if (loc1) 
                    {
                        loc4.bi_internal::subTo(loc6, loc4);
                    }
                    loc5.bi_internal::subTo(loc7, loc5);
                    continue;
                }
                loc3.bi_internal::subTo(loc2, loc3);
                if (loc1) 
                {
                    loc6.bi_internal::subTo(loc4, loc6);
                }
                loc7.bi_internal::subTo(loc5, loc7);
            }
            if (loc3.compareTo(com.hurlant.math.BigInteger.ONE) != 0) 
            {
                return com.hurlant.math.BigInteger.ZERO;
            }
            if (loc7.compareTo(arg1) >= 0) 
            {
                return loc7.subtract(arg1);
            }
            if (loc7.sigNum() < 0) 
            {
                loc7.addTo(arg1, loc7);
            }
            else 
            {
                return loc7;
            }
            if (loc7.sigNum() < 0) 
            {
                return loc7.add(arg1);
            }
            return loc7;
        }

        bi_internal function fromArray(arg1:flash.utils.ByteArray, arg2:int):void
        {
            var loc5:*=0;
            var loc1:*=arg1.position;
            var loc2:*=loc1 + arg2;
            var loc3:*=0;
            var loc4:*=8;
            t = 0;
            bi_internal::s = 0;
            while (--loc2 >= loc1) 
            {
                loc5 = loc2 < arg1.length ? arg1[loc2] : 0;
                if (loc3 != 0) 
                {
                    if (loc3 + loc4 > DB) 
                    {
                        bi_internal::a[(t - 1)] = bi_internal::a[(t - 1)] | (loc5 & (1 << DB - loc3 - 1)) << loc3;
                        bi_internal::a[loc6 = t++] = loc5 >> DB - loc3;
                    }
                    else 
                    {
                        bi_internal::a[(t - 1)] = bi_internal::a[(t - 1)] | loc5 << loc3;
                    }
                }
                else 
                {
                    var loc7:*;
                    var loc6:*;
                    bi_internal::a[loc6 = t++] = loc5;
                }
                loc3 = loc3 + loc4;
                if (!(loc3 >= DB)) 
                {
                    continue;
                }
                loc3 = loc3 - DB;
            }
            bi_internal::clamp();
            arg1.position = Math.min(loc1 + arg2, arg1.length);
            return;
        }

        bi_internal function copyTo(arg1:com.hurlant.math.BigInteger):void
        {
            var loc1:*=(t - 1);
            while (loc1 >= 0) 
            {
                arg1.bi_internal::a[loc1] = bi_internal::a[loc1];
                --loc1;
            }
            arg1.t = t;
            arg1.bi_internal::s = bi_internal::s;
            return;
        }

        public function intValue():int
        {
            if (bi_internal::s < 0) 
            {
                if (t == 1) 
                {
                    return bi_internal::a[0] - DV;
                }
                if (t == 0) 
                {
                    return -1;
                }
            }
            else 
            {
                if (t == 1) 
                {
                    return bi_internal::a[0];
                }
                if (t == 0) 
                {
                    return 0;
                }
            }
            return (bi_internal::a[1] & (1 << 32 - DB - 1)) << DB | bi_internal::a[0];
        }

        public function min(arg1:com.hurlant.math.BigInteger):com.hurlant.math.BigInteger
        {
            return compareTo(arg1) < 0 ? this : arg1;
        }

        public function bitLength():int
        {
            if (t <= 0) 
            {
                return 0;
            }
            return DB * (t - 1) + bi_internal::nbits(bi_internal::a[(t - 1)] ^ bi_internal::s & DM);
        }

        public function shortValue():int
        {
            return t != 0 ? bi_internal::a[0] << 16 >> 16 : bi_internal::s;
        }

        public function and(arg1:com.hurlant.math.BigInteger):com.hurlant.math.BigInteger
        {
            var loc1:*=new com.hurlant.math.BigInteger();
            bitwiseTo(arg1, op_and, loc1);
            return loc1;
        }

        public function byteValue():int
        {
            return t != 0 ? bi_internal::a[0] << 24 >> 24 : bi_internal::s;
        }

        public function not():com.hurlant.math.BigInteger
        {
            var loc1:*=new com.hurlant.math.BigInteger();
            var loc2:*=0;
            while (loc2 < t) 
            {
                loc1[loc2] = DM & ~bi_internal::a[loc2];
                ++loc2;
            }
            loc1.t = t;
            loc1.bi_internal::s = ~bi_internal::s;
            return loc1;
        }

        bi_internal function subTo(arg1:com.hurlant.math.BigInteger, arg2:com.hurlant.math.BigInteger):void
        {
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=Math.min(arg1.t, t);
            while (loc1 < loc3) 
            {
                loc2 = loc2 + (bi_internal::a[loc1] - arg1.bi_internal::a[loc1]);
                var loc4:*;
                arg2.bi_internal::a[loc4 = loc1++] = loc2 & DM;
                loc2 = loc2 >> DB;
            }
            if (arg1.t < t) 
            {
                loc2 = loc2 - arg1.bi_internal::s;
                while (loc1 < t) 
                {
                    loc2 = loc2 + bi_internal::a[loc1];
                    arg2.bi_internal::a[loc4 = loc1++] = loc2 & DM;
                    loc2 = loc2 >> DB;
                }
                loc2 = loc2 + bi_internal::s;
            }
            else 
            {
                loc2 = loc2 + bi_internal::s;
                while (loc1 < arg1.t) 
                {
                    loc2 = loc2 - arg1.bi_internal::a[loc1];
                    arg2.bi_internal::a[loc4 = loc1++] = loc2 & DM;
                    loc2 = loc2 >> DB;
                }
                loc2 = loc2 - arg1.bi_internal::s;
            }
            arg2.bi_internal::s = loc2 < 0 ? -1 : 0;
            if (loc2 < -1) 
            {
                arg2.bi_internal::a[loc4 = loc1++] = DV + loc2;
            }
            else if (loc2 > 0) 
            {
                arg2.bi_internal::a[loc4 = loc1++] = loc2;
            }
            arg2.t = loc1;
            arg2.bi_internal::clamp();
            return;
        }

        public function clone():com.hurlant.math.BigInteger
        {
            var loc1:*=new com.hurlant.math.BigInteger();
            this.bi_internal::copyTo(loc1);
            return loc1;
        }

        public function pow(arg1:int):com.hurlant.math.BigInteger
        {
            return bi_internal::exp(arg1, new com.hurlant.math.NullReduction());
        }

        public function flipBit(arg1:int):com.hurlant.math.BigInteger
        {
            return changeBit(arg1, op_xor);
        }

        public function xor(arg1:com.hurlant.math.BigInteger):com.hurlant.math.BigInteger
        {
            var loc1:*=new com.hurlant.math.BigInteger();
            bitwiseTo(arg1, op_xor, loc1);
            return loc1;
        }

        public function or(arg1:com.hurlant.math.BigInteger):com.hurlant.math.BigInteger
        {
            var loc1:*=new com.hurlant.math.BigInteger();
            bitwiseTo(arg1, op_or, loc1);
            return loc1;
        }

        public function max(arg1:com.hurlant.math.BigInteger):com.hurlant.math.BigInteger
        {
            return compareTo(arg1) > 0 ? this : arg1;
        }

        bi_internal function fromInt(arg1:int):void
        {
            t = 1;
            bi_internal::s = arg1 < 0 ? -1 : 0;
            if (arg1 > 0) 
            {
                bi_internal::a[0] = arg1;
            }
            else if (arg1 < -1) 
            {
                bi_internal::a[0] = arg1 + DV;
            }
            else 
            {
                t = 0;
            }
            return;
        }

        bi_internal function isEven():Boolean
        {
            return (t > 0 ? bi_internal::a[0] & 1 : bi_internal::s) == 0;
        }

        public function toString(arg1:Number=16):String
        {
            var loc1:*=0;
            if (bi_internal::s < 0) 
            {
                return "-" + negate().toString(arg1);
            }
            var loc8:*=arg1;
            switch (loc8) 
            {
                case 2:
                {
                    loc1 = 1;
                    break;
                }
                case 4:
                {
                    loc1 = 2;
                    break;
                }
                case 8:
                {
                    loc1 = 3;
                    break;
                }
                case 16:
                {
                    loc1 = 4;
                    break;
                }
                case 32:
                {
                    loc1 = 5;
                    break;
                }
            }
            var loc2:*=(1 << loc1 - 1);
            var loc3:*=0;
            var loc4:*=false;
            var loc5:*="";
            var loc6:*=t;
            var loc7:*=DB - loc6 * DB % loc1;
            if (loc6-- > 0) 
            {
                if (loc7 < DB) 
                {
                    loc7 < DB;
                    loc3 = loc8 = bi_internal::a[loc6] >> loc7;
                }
                if (loc7 < DB) 
                {
                    loc4 = true;
                    loc5 = loc3.toString(36);
                }
                while (loc6 >= 0) 
                {
                    if (loc7 < loc1) 
                    {
                        loc3 = (bi_internal::a[loc6] & (1 << loc7 - 1)) << loc1 - loc7;
                        loc7 = loc8 = loc7 + (DB - loc1);
                        loc3 = loc3 | bi_internal::a[--loc6] >> loc8;
                    }
                    else 
                    {
                        loc7 = loc8 = loc7 - loc1;
                        loc3 = bi_internal::a[loc6] >> loc8 & loc2;
                        if (loc7 <= 0) 
                        {
                            loc7 = loc7 + DB;
                            --loc6;
                        }
                    }
                    if (loc3 > 0) 
                    {
                        loc4 = true;
                    }
                    if (!loc4) 
                    {
                        continue;
                    }
                    loc5 = loc5 + loc3.toString(36);
                }
            }
            return loc4 ? loc5 : "0";
        }

        public function setBit(arg1:int):com.hurlant.math.BigInteger
        {
            return changeBit(arg1, op_or);
        }

        public function abs():com.hurlant.math.BigInteger
        {
            return bi_internal::s < 0 ? negate() : this;
        }

        bi_internal function nbits(arg1:int):int
        {
            var loc2:*=0;
            var loc1:*=1;
            var loc3:*;
            loc2 = loc3 = arg1 >>> 16;
            if (loc3 != 0) 
            {
                arg1 = loc2;
                loc1 = loc1 + 16;
            }
            loc2 = loc3 = arg1 >> 8;
            if (loc3 != 0) 
            {
                arg1 = loc2;
                loc1 = loc1 + 8;
            }
            loc2 = loc3 = arg1 >> 4;
            if (loc3 != 0) 
            {
                arg1 = loc2;
                loc1 = loc1 + 4;
            }
            loc2 = loc3 = arg1 >> 2;
            if (loc3 != 0) 
            {
                arg1 = loc2;
                loc1 = loc1 + 2;
            }
            loc2 = loc3 = arg1 >> 1;
            if (loc3 != 0) 
            {
                arg1 = loc2;
                loc1 = loc1 + 1;
            }
            return loc1;
        }

        public function sigNum():int
        {
            if (bi_internal::s < 0) 
            {
                return -1;
            }
            if (t <= 0 || t == 1 && bi_internal::a[0] <= 0) 
            {
                return 0;
            }
            return 1;
        }

        public function toByteArray():flash.utils.ByteArray
        {
            var loc4:*=0;
            var loc1:*=t;
            var loc2:*=new flash.utils.ByteArray();
            loc2[0] = bi_internal::s;
            var loc3:*=DB - loc1 * DB % 8;
            var loc5:*=0;
            if (loc1-- > 0) 
            {
                if (loc3 < DB) 
                {
                    loc3 < DB;
                    var loc6:*;
                    loc4 = loc6 = bi_internal::a[loc1] >> loc3;
                }
                if (loc3 < DB) 
                {
                    loc2[loc6 = loc5++] = loc4 | bi_internal::s << DB - loc3;
                }
                while (loc1 >= 0) 
                {
                    if (loc3 < 8) 
                    {
                        loc4 = (bi_internal::a[loc1] & (1 << loc3 - 1)) << 8 - loc3;
                        loc3 = loc6 = loc3 + (DB - 8);
                        loc4 = loc4 | bi_internal::a[--loc1] >> loc6;
                    }
                    else 
                    {
                        loc3 = loc6 = loc3 - 8;
                        loc4 = bi_internal::a[loc1] >> loc6 & 255;
                        if (loc3 <= 0) 
                        {
                            loc3 = loc3 + DB;
                            --loc1;
                        }
                    }
                    if ((loc4 & 128) != 0) 
                    {
                        loc4 = loc4 | -256;
                    }
                    if (loc5 == 0 && !((bi_internal::s & 128) == (loc4 & 128))) 
                    {
                        ++loc5;
                    }
                    if (!(loc5 > 0 || !(loc4 == bi_internal::s))) 
                    {
                        continue;
                    }
                    loc2[loc6 = loc5++] = loc4;
                }
            }
            return loc2;
        }

        bi_internal function squareTo(arg1:com.hurlant.math.BigInteger):void
        {
            var loc3:*=0;
            var loc1:*=abs();
            var loc4:*;
            arg1.t = loc4 = 2 * loc1.t;
            var loc2:*=loc4;
            while (--loc2 >= 0) 
            {
                arg1.bi_internal::a[loc2] = 0;
            }
            loc2 = 0;
            while (loc2 < (loc1.t - 1)) 
            {
                loc3 = loc1.bi_internal::am(loc2, loc1.bi_internal::a[loc2], arg1, 2 * loc2, 0, 1);
                arg1.bi_internal::a[loc2 + loc1.t] = loc4 = arg1.bi_internal::a[loc2 + loc1.t] + loc1.bi_internal::am(loc2 + 1, 2 * loc1.bi_internal::a[loc2], arg1, 2 * loc2 + 1, loc3, (loc1.t - loc2 - 1));
                if (loc4 >= DV) 
                {
                    arg1.bi_internal::a[loc2 + loc1.t] = arg1.bi_internal::a[loc2 + loc1.t] - DV;
                    arg1.bi_internal::a[loc2 + loc1.t + 1] = 1;
                }
                ++loc2;
            }
            if (arg1.t > 0) 
            {
                arg1.bi_internal::a[(arg1.t - 1)] = arg1.bi_internal::a[(arg1.t - 1)] + loc1.bi_internal::am(loc2, loc1.bi_internal::a[loc2], arg1, 2 * loc2, 0, 1);
            }
            arg1.bi_internal::s = 0;
            arg1.bi_internal::clamp();
            return;
        }

        internal function op_and(arg1:int, arg2:int):int
        {
            return arg1 & arg2;
        }

        protected function fromRadix(arg1:String, arg2:int=10):void
        {
            var loc7:*=0;
            bi_internal::fromInt(0);
            var loc1:*=chunkSize(arg2);
            var loc2:*=Math.pow(arg2, loc1);
            var loc3:*=false;
            var loc4:*=0;
            var loc5:*=0;
            var loc6:*=0;
            while (loc6 < arg1.length) 
            {
                loc7 = bi_internal::intAt(arg1, loc6);
                if (loc7 < 0) 
                {
                    if (arg1.charAt(loc6) == "-" && sigNum() == 0) 
                    {
                        loc3 = true;
                    }
                }
                else 
                {
                    loc5 = arg2 * loc5 + loc7;
                    if (++loc4 >= loc1) 
                    {
                        bi_internal::dMultiply(loc2);
                        bi_internal::dAddOffset(loc5, 0);
                        loc4 = 0;
                        loc5 = 0;
                    }
                }
                ++loc6;
            }
            if (loc4 > 0) 
            {
                bi_internal::dMultiply(Math.pow(arg2, loc4));
                bi_internal::dAddOffset(loc5, 0);
            }
            if (loc3) 
            {
                com.hurlant.math.BigInteger.ZERO.bi_internal::subTo(this, this);
            }
            return;
        }

        bi_internal function dlShiftTo(arg1:int, arg2:com.hurlant.math.BigInteger):void
        {
            var loc1:*=0;
            loc1 = (t - 1);
            while (loc1 >= 0) 
            {
                arg2.bi_internal::a[loc1 + arg1] = bi_internal::a[loc1];
                --loc1;
            }
            --loc1;
            while (loc1 >= 0) 
            {
                arg2.bi_internal::a[loc1] = 0;
                --loc1;
            }
            arg2.t = t + arg1;
            arg2.bi_internal::s = bi_internal::s;
            return;
        }

        internal function op_xor(arg1:int, arg2:int):int
        {
            return arg1 ^ arg2;
        }

        public static function nbv(arg1:int):com.hurlant.math.BigInteger
        {
            var loc1:*=new BigInteger();
            loc1.bi_internal::fromInt(arg1);
            return loc1;
        }

        public static const ONE:com.hurlant.math.BigInteger=nbv(1);

        public static const ZERO:com.hurlant.math.BigInteger=nbv(0);

        public static const DM:int=(DV - 1);

        public static const F1:int=BI_FP - DB;

        public static const F2:int=2 * DB - BI_FP;

        public static const lplim:int=(1 << 26) / lowprimes[(lowprimes.length - 1)];

        public static const lowprimes:Array=[2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101, 103, 107, 109, 113, 127, 131, 137, 139, 149, 151, 157, 163, 167, 173, 179, 181, 191, 193, 197, 199, 211, 223, 227, 229, 233, 239, 241, 251, 257, 263, 269, 271, 277, 281, 283, 293, 307, 311, 313, 317, 331, 337, 347, 349, 353, 359, 367, 373, 379, 383, 389, 397, 401, 409, 419, 421, 431, 433, 439, 443, 449, 457, 461, 463, 467, 479, 487, 491, 499, 503, 509];

        public static const FV:Number=Math.pow(2, BI_FP);

        public static const BI_FP:int=52;

        public static const DV:int=1 << DB;

        public static const DB:int=30;

        bi_internal var a:Array;

        bi_internal var s:int;

        public var t:int;
    }
}


//    class ClassicReduction
package com.hurlant.math 
{
    use namespace bi_internal;
    
    internal class ClassicReduction extends Object implements com.hurlant.math.IReduction
    {
        public function ClassicReduction(arg1:com.hurlant.math.BigInteger)
        {
            super();
            this.m = arg1;
            return;
        }

        public function revert(arg1:com.hurlant.math.BigInteger):com.hurlant.math.BigInteger
        {
            return arg1;
        }

        public function reduce(arg1:com.hurlant.math.BigInteger):void
        {
            arg1.bi_internal::divRemTo(m, null, arg1);
            return;
        }

        public function mulTo(arg1:com.hurlant.math.BigInteger, arg2:com.hurlant.math.BigInteger, arg3:com.hurlant.math.BigInteger):void
        {
            arg1.bi_internal::multiplyTo(arg2, arg3);
            reduce(arg3);
            return;
        }

        public function sqrTo(arg1:com.hurlant.math.BigInteger, arg2:com.hurlant.math.BigInteger):void
        {
            arg1.bi_internal::squareTo(arg2);
            reduce(arg2);
            return;
        }

        public function convert(arg1:com.hurlant.math.BigInteger):com.hurlant.math.BigInteger
        {
            if (arg1.bi_internal::s < 0 || arg1.compareTo(m) >= 0) 
            {
                return arg1.mod(m);
            }
            return arg1;
        }

        internal var m:com.hurlant.math.BigInteger;
    }
}


//    class IReduction
package com.hurlant.math 
{
    internal interface IReduction
    {
        function revert(arg1:com.hurlant.math.BigInteger):com.hurlant.math.BigInteger;

        function reduce(arg1:com.hurlant.math.BigInteger):void;

        function convert(arg1:com.hurlant.math.BigInteger):com.hurlant.math.BigInteger;

        function mulTo(arg1:com.hurlant.math.BigInteger, arg2:com.hurlant.math.BigInteger, arg3:com.hurlant.math.BigInteger):void;

        function sqrTo(arg1:com.hurlant.math.BigInteger, arg2:com.hurlant.math.BigInteger):void;
    }
}


//    class MontgomeryReduction
package com.hurlant.math 
{
    use namespace bi_internal;
    
    internal class MontgomeryReduction extends Object implements com.hurlant.math.IReduction
    {
        public function MontgomeryReduction(arg1:com.hurlant.math.BigInteger)
        {
            super();
            this.m = arg1;
            mp = arg1.bi_internal::invDigit();
            mpl = mp & 32767;
            mph = mp >> 15;
            um = (1 << com.hurlant.math.BigInteger.DB - 15 - 1);
            mt2 = 2 * arg1.t;
            return;
        }

        public function convert(arg1:com.hurlant.math.BigInteger):com.hurlant.math.BigInteger
        {
            var loc1:*=new com.hurlant.math.BigInteger();
            arg1.abs().bi_internal::dlShiftTo(m.t, loc1);
            loc1.bi_internal::divRemTo(m, null, loc1);
            if (arg1.bi_internal::s < 0 && loc1.compareTo(com.hurlant.math.BigInteger.ZERO) > 0) 
            {
                m.bi_internal::subTo(loc1, loc1);
            }
            return loc1;
        }

        public function revert(arg1:com.hurlant.math.BigInteger):com.hurlant.math.BigInteger
        {
            var loc1:*=new com.hurlant.math.BigInteger();
            arg1.bi_internal::copyTo(loc1);
            reduce(loc1);
            return loc1;
        }

        public function sqrTo(arg1:com.hurlant.math.BigInteger, arg2:com.hurlant.math.BigInteger):void
        {
            arg1.bi_internal::squareTo(arg2);
            reduce(arg2);
            return;
        }

        public function reduce(arg1:com.hurlant.math.BigInteger):void
        {
            var loc2:*=0;
            var loc3:*=0;
            while (arg1.t <= mt2) 
            {
                var loc5:*;
                var loc6:*=((loc5 = arg1).t + 1);
                loc5.t = loc6;
                var loc4:*;
                arg1.bi_internal::a[loc4 = (loc5 = arg1).t] = 0;
            }
            var loc1:*=0;
            while (loc1 < m.t) 
            {
                loc2 = arg1.bi_internal::a[loc1] & 32767;
                loc3 = loc2 * mpl + ((loc2 * mph + (arg1.bi_internal::a[loc1] >> 15) * mpl & um) << 15) & com.hurlant.math.BigInteger.DM;
                loc2 = loc1 + m.t;
                arg1.bi_internal::a[loc2] = arg1.bi_internal::a[loc2] + m.bi_internal::am(0, loc3, arg1, loc1, 0, m.t);
                while (arg1.bi_internal::a[loc2] >= com.hurlant.math.BigInteger.DV) 
                {
                    arg1.bi_internal::a[loc2] = arg1.bi_internal::a[loc2] - com.hurlant.math.BigInteger.DV;
                    loc6 = ((loc4 = arg1.bi_internal::a)[loc5 = ++loc2] + 1);
                    loc4[loc5] = loc6;
                }
                ++loc1;
            }
            arg1.bi_internal::clamp();
            arg1.bi_internal::drShiftTo(m.t, arg1);
            if (arg1.compareTo(m) >= 0) 
            {
                arg1.bi_internal::subTo(m, arg1);
            }
            return;
        }

        public function mulTo(arg1:com.hurlant.math.BigInteger, arg2:com.hurlant.math.BigInteger, arg3:com.hurlant.math.BigInteger):void
        {
            arg1.bi_internal::multiplyTo(arg2, arg3);
            reduce(arg3);
            return;
        }

        internal var mp:int;

        internal var mph:int;

        internal var mpl:int;

        internal var mt2:int;

        internal var m:com.hurlant.math.BigInteger;

        internal var um:int;
    }
}


//    class NullReduction
package com.hurlant.math 
{
    use namespace bi_internal;
    
    public class NullReduction extends Object implements com.hurlant.math.IReduction
    {
        public function NullReduction()
        {
            super();
            return;
        }

        public function convert(arg1:com.hurlant.math.BigInteger):com.hurlant.math.BigInteger
        {
            return arg1;
        }

        public function sqrTo(arg1:com.hurlant.math.BigInteger, arg2:com.hurlant.math.BigInteger):void
        {
            arg1.bi_internal::squareTo(arg2);
            return;
        }

        public function mulTo(arg1:com.hurlant.math.BigInteger, arg2:com.hurlant.math.BigInteger, arg3:com.hurlant.math.BigInteger):void
        {
            arg1.bi_internal::multiplyTo(arg2, arg3);
            return;
        }

        public function revert(arg1:com.hurlant.math.BigInteger):com.hurlant.math.BigInteger
        {
            return arg1;
        }

        public function reduce(arg1:com.hurlant.math.BigInteger):void
        {
            return;
        }
    }
}


//    namespace bi_internal
package com.hurlant.math 
{
    public namespace bi_internal="http://crypto.hurlant.com/BigInteger";
}


//  package util
//    class Base64
package com.hurlant.util 
{
    import flash.utils.*;
    
    public class Base64 extends Object
    {
        public function Base64()
        {
            super();
            throw new Error("Base64 class is static container only");
        }

        public static function encode(arg1:String):String
        {
            var loc1:*=new flash.utils.ByteArray();
            loc1.writeUTFBytes(arg1);
            return encodeByteArray(loc1);
        }

        public static function encodeByteArray(arg1:flash.utils.ByteArray):String
        {
            var loc2:*=null;
            var loc4:*=0;
            var loc5:*=0;
            var loc6:*=0;
            var loc1:*="";
            var loc3:*=new Array(4);
            arg1.position = 0;
            while (arg1.bytesAvailable > 0) 
            {
                loc2 = new Array();
                loc4 = 0;
                while (loc4 < 3 && arg1.bytesAvailable > 0) 
                {
                    loc2[loc4] = arg1.readUnsignedByte();
                    ++loc4;
                }
                loc3[0] = (loc2[0] & 252) >> 2;
                loc3[1] = (loc2[0] & 3) << 4 | loc2[1] >> 4;
                loc3[2] = (loc2[1] & 15) << 2 | loc2[2] >> 6;
                loc3[3] = loc2[2] & 63;
                loc5 = loc2.length;
                while (loc5 < 3) 
                {
                    loc3[loc5 + 1] = 64;
                    ++loc5;
                }
                loc6 = 0;
                while (loc6 < loc3.length) 
                {
                    loc1 = loc1 + BASE64_CHARS.charAt(loc3[loc6]);
                    ++loc6;
                }
            }
            return loc1;
        }

        public static function decode(arg1:String):String
        {
            var loc1:*=decodeToByteArray(arg1);
            return loc1.readUTFBytes(loc1.length);
        }

        public static function decodeToByteArray(arg1:String):flash.utils.ByteArray
        {
            var loc5:*=0;
            var loc6:*=0;
            var loc1:*=new flash.utils.ByteArray();
            var loc2:*=new Array(4);
            var loc3:*=new Array(3);
            var loc4:*=0;
            while (loc4 < arg1.length) 
            {
                loc5 = 0;
                while (loc5 < 4 && loc4 + loc5 < arg1.length) 
                {
                    loc2[loc5] = BASE64_CHARS.indexOf(arg1.charAt(loc4 + loc5));
                    ++loc5;
                }
                loc3[0] = (loc2[0] << 2) + ((loc2[1] & 48) >> 4);
                loc3[1] = ((loc2[1] & 15) << 4) + ((loc2[2] & 60) >> 2);
                loc3[2] = ((loc2[2] & 3) << 6) + loc2[3];
                loc6 = 0;
                while (loc6 < loc3.length) 
                {
                    if (loc2[loc6 + 1] == 64) 
                    {
                        break;
                    }
                    loc1.writeByte(loc3[loc6]);
                    ++loc6;
                }
                loc4 = loc4 + 4;
            }
            loc1.position = 0;
            return loc1;
        }

        public static const version:String="1.0.0";

        internal static const BASE64_CHARS:String="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    }
}


//    class Hex
package com.hurlant.util 
{
    import flash.utils.*;
    
    public class Hex extends Object
    {
        public function Hex()
        {
            super();
            return;
        }

        public static function fromString(arg1:String, arg2:Boolean=false):String
        {
            var loc1:*=new flash.utils.ByteArray();
            loc1.writeUTFBytes(arg1);
            return fromArray(loc1, arg2);
        }

        public static function toString(arg1:String):String
        {
            var loc1:*=toArray(arg1);
            return loc1.readUTFBytes(loc1.length);
        }

        public static function toArray(arg1:String):flash.utils.ByteArray
        {
            arg1 = arg1.replace(new RegExp("\\s|:", "gm"), "");
            var loc1:*=new flash.utils.ByteArray();
            if (arg1.length & 1 == 1) 
            {
                arg1 = "0" + arg1;
            }
            var loc2:*=0;
            while (loc2 < arg1.length) 
            {
                loc1[loc2 / 2] = parseInt(arg1.substr(loc2, 2), 16);
                loc2 = loc2 + 2;
            }
            return loc1;
        }

        public static function fromArray(arg1:flash.utils.ByteArray, arg2:Boolean=false):String
        {
            var loc1:*="";
            var loc2:*=0;
            while (loc2 < arg1.length) 
            {
                loc1 = loc1 + ("0" + arg1[loc2].toString(16)).substr(-2, 2);
                if (arg2) 
                {
                    if (loc2 < (arg1.length - 1)) 
                    {
                        loc1 = loc1 + ":";
                    }
                }
                ++loc2;
            }
            return loc1;
        }
    }
}


//    class Memory
package com.hurlant.util 
{
    import flash.net.*;
    import flash.system.*;
    
    public class Memory extends Object
    {
        public function Memory()
        {
            super();
            return;
        }

        public static function gc():void
        {
            var loc1:*;
            try 
            {
                new flash.net.LocalConnection().connect("foo");
                new flash.net.LocalConnection().connect("foo");
            }
            catch (e:*)
            {
            };
            return;
        }

        public static function get used():uint
        {
            return flash.system.System.totalMemory;
        }
    }
}


