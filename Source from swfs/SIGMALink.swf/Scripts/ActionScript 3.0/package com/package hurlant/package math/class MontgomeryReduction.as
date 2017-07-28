//class MontgomeryReduction
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


