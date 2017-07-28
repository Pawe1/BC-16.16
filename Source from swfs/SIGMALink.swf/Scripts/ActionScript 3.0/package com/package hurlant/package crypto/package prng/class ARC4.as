//class ARC4
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


