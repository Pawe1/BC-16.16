//class Random
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


