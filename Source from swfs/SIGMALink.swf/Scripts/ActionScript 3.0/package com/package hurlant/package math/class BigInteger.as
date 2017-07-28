//class BigInteger
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


