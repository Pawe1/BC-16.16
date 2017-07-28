//class SHA1
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


