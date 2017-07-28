//class OFBMode
package com.hurlant.crypto.symmetric 
{
    import flash.utils.*;
    
    public class OFBMode extends com.hurlant.crypto.symmetric.IVMode implements com.hurlant.crypto.symmetric.IMode
    {
        public function OFBMode(arg1:com.hurlant.crypto.symmetric.ISymmetricKey, arg2:com.hurlant.crypto.symmetric.IPad=null)
        {
            super(arg1, null);
            return;
        }

        internal function core(arg1:flash.utils.ByteArray, arg2:flash.utils.ByteArray):void
        {
            var loc4:*=0;
            var loc5:*=0;
            var loc1:*=arg1.length;
            var loc2:*=new flash.utils.ByteArray();
            var loc3:*=0;
            while (loc3 < arg1.length) 
            {
                key.encrypt(arg2);
                loc2.position = 0;
                loc2.writeBytes(arg2);
                loc4 = loc3 + blockSize < loc1 ? blockSize : loc1 - loc3;
                loc5 = 0;
                while (loc5 < loc4) 
                {
                    arg1[loc3 + loc5] = arg1[loc3 + loc5] ^ arg2[loc5];
                    ++loc5;
                }
                arg2.position = 0;
                arg2.writeBytes(loc2);
                loc3 = loc3 + blockSize;
            }
            return;
        }

        public function toString():String
        {
            return key.toString() + "-ofb";
        }

        public function encrypt(arg1:flash.utils.ByteArray):void
        {
            var loc1:*=getIV4e();
            core(arg1, loc1);
            return;
        }

        public function decrypt(arg1:flash.utils.ByteArray):void
        {
            var loc1:*=getIV4d();
            core(arg1, loc1);
            return;
        }
    }
}


