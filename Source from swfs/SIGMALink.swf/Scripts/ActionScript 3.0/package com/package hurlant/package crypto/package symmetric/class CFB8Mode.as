//class CFB8Mode
package com.hurlant.crypto.symmetric 
{
    import flash.utils.*;
    
    public class CFB8Mode extends com.hurlant.crypto.symmetric.IVMode implements com.hurlant.crypto.symmetric.IMode
    {
        public function CFB8Mode(arg1:com.hurlant.crypto.symmetric.ISymmetricKey, arg2:com.hurlant.crypto.symmetric.IPad=null)
        {
            super(arg1, null);
            return;
        }

        public function toString():String
        {
            return key.toString() + "-cfb8";
        }

        public function encrypt(arg1:flash.utils.ByteArray):void
        {
            var loc4:*=0;
            var loc1:*=getIV4e();
            var loc2:*=new flash.utils.ByteArray();
            var loc3:*=0;
            while (loc3 < arg1.length) 
            {
                loc2.position = 0;
                loc2.writeBytes(loc1);
                key.encrypt(loc1);
                arg1[loc3] = arg1[loc3] ^ loc1[0];
                loc4 = 0;
                while (loc4 < (blockSize - 1)) 
                {
                    loc1[loc4] = loc2[loc4 + 1];
                    ++loc4;
                }
                loc1[(blockSize - 1)] = arg1[loc3];
                ++loc3;
            }
            return;
        }

        public function decrypt(arg1:flash.utils.ByteArray):void
        {
            var loc4:*=0;
            var loc5:*=0;
            var loc1:*=getIV4d();
            var loc2:*=new flash.utils.ByteArray();
            var loc3:*=0;
            while (loc3 < arg1.length) 
            {
                loc4 = arg1[loc3];
                loc2.position = 0;
                loc2.writeBytes(loc1);
                key.encrypt(loc1);
                arg1[loc3] = arg1[loc3] ^ loc1[0];
                loc5 = 0;
                while (loc5 < (blockSize - 1)) 
                {
                    loc1[loc5] = loc2[loc5 + 1];
                    ++loc5;
                }
                loc1[(blockSize - 1)] = loc4;
                ++loc3;
            }
            return;
        }
    }
}


