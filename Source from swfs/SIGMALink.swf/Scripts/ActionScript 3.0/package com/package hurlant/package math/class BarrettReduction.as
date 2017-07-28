//class BarrettReduction
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


