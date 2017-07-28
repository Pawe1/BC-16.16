//class CFBMode
package com.hurlant.crypto.symmetric 
{
    import flash.utils.*;
    
    public class CFBMode extends com.hurlant.crypto.symmetric.IVMode implements com.hurlant.crypto.symmetric.IMode
    {
        public function CFBMode(arg1:com.hurlant.crypto.symmetric.ISymmetricKey, arg2:com.hurlant.crypto.symmetric.IPad=null)
        {
            super(arg1, null);
            return;
        }

        public function toString():String
        {
            return key.toString() + "-cfb";
        }

        public function encrypt(arg1:flash.utils.ByteArray):void
        {
            var loc4:*=0;
            var loc5:*=0;
            var loc1:*=arg1.length;
            var loc2:*=getIV4e();
            var loc3:*=0;
            while (loc3 < arg1.length) 
            {
                key.encrypt(loc2);
                loc4 = loc3 + blockSize < loc1 ? blockSize : loc1 - loc3;
                loc5 = 0;
                while (loc5 < loc4) 
                {
                    arg1[loc3 + loc5] = arg1[loc3 + loc5] ^ loc2[loc5];
                    ++loc5;
                }
                loc2.position = 0;
                loc2.writeBytes(arg1, loc3, loc4);
                loc3 = loc3 + blockSize;
            }
            return;
        }

        public function decrypt(arg1:flash.utils.ByteArray):void
        {
            var loc5:*=0;
            var loc6:*=0;
            var loc1:*=arg1.length;
            var loc2:*=getIV4d();
            var loc3:*=new flash.utils.ByteArray();
            var loc4:*=0;
            while (loc4 < arg1.length) 
            {
                key.encrypt(loc2);
                loc5 = loc4 + blockSize < loc1 ? blockSize : loc1 - loc4;
                loc3.position = 0;
                loc3.writeBytes(arg1, loc4, loc5);
                loc6 = 0;
                while (loc6 < loc5) 
                {
                    arg1[loc4 + loc6] = arg1[loc4 + loc6] ^ loc2[loc6];
                    ++loc6;
                }
                loc2.position = 0;
                loc2.writeBytes(loc3);
                loc4 = loc4 + blockSize;
            }
            return;
        }
    }
}


