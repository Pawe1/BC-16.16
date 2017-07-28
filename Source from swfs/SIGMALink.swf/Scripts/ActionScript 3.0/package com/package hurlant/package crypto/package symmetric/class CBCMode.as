//class CBCMode
package com.hurlant.crypto.symmetric 
{
    import flash.utils.*;
    
    public class CBCMode extends com.hurlant.crypto.symmetric.IVMode implements com.hurlant.crypto.symmetric.IMode
    {
        public function CBCMode(arg1:com.hurlant.crypto.symmetric.ISymmetricKey, arg2:com.hurlant.crypto.symmetric.IPad=null)
        {
            super(arg1, arg2);
            return;
        }

        public function toString():String
        {
            return key.toString() + "-cbc";
        }

        public function encrypt(arg1:flash.utils.ByteArray):void
        {
            var loc3:*=0;
            padding.pad(arg1);
            var loc1:*=getIV4e();
            var loc2:*=0;
            while (loc2 < arg1.length) 
            {
                loc3 = 0;
                while (loc3 < blockSize) 
                {
                    arg1[loc2 + loc3] = arg1[loc2 + loc3] ^ loc1[loc3];
                    ++loc3;
                }
                key.encrypt(arg1, loc2);
                loc1.position = 0;
                loc1.writeBytes(arg1, loc2, blockSize);
                loc2 = loc2 + blockSize;
            }
            return;
        }

        public function decrypt(arg1:flash.utils.ByteArray):void
        {
            var loc4:*=0;
            var loc1:*=getIV4d();
            var loc2:*=new flash.utils.ByteArray();
            var loc3:*=0;
            while (loc3 < arg1.length) 
            {
                loc2.position = 0;
                loc2.writeBytes(arg1, loc3, blockSize);
                key.decrypt(arg1, loc3);
                loc4 = 0;
                while (loc4 < blockSize) 
                {
                    arg1[loc3 + loc4] = arg1[loc3 + loc4] ^ loc1[loc4];
                    ++loc4;
                }
                loc1.position = 0;
                loc1.writeBytes(loc2, 0, blockSize);
                loc3 = loc3 + blockSize;
            }
            padding.unpad(arg1);
            return;
        }
    }
}


