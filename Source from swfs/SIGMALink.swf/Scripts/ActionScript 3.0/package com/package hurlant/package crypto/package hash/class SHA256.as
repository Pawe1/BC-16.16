//class SHA256
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


