//package rsa
//  class RSAKey
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


