//class HMAC
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


