//package prng
//  class ARC4
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


//  class IPRNG
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


//  class Random
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


