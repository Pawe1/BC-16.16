//class CTRMode
package com.hurlant.crypto.symmetric 
{
    import flash.utils.*;
    
    public class CTRMode extends com.hurlant.crypto.symmetric.IVMode implements com.hurlant.crypto.symmetric.IMode
    {
        public function CTRMode(arg1:com.hurlant.crypto.symmetric.ISymmetricKey, arg2:com.hurlant.crypto.symmetric.IPad=null)
        {
            super(arg1, arg2);
            return;
        }

        internal function core(arg1:flash.utils.ByteArray, arg2:flash.utils.ByteArray):void
        {
            var loc4:*=0;
            var loc1:*=new flash.utils.ByteArray();
            var loc2:*=new flash.utils.ByteArray();
            loc1.writeBytes(arg2);
            var loc3:*=0;
            while (loc3 < arg1.length) 
            {
                loc2.position = 0;
                loc2.writeBytes(loc1);
                key.encrypt(loc2);
                loc4 = 0;
                while (loc4 < blockSize) 
                {
                    arg1[loc3 + loc4] = arg1[loc3 + loc4] ^ loc2[loc4];
                    ++loc4;
                }
                loc4 = (blockSize - 1);
                while (loc4 >= 0) 
                {
                    var loc5:*;
                    var loc6:*;
                    var loc7:*=((loc5 = loc1)[loc6 = loc4] + 1);
                    loc5[loc6] = loc7;
                    if (loc1[loc4] != 0) 
                    {
                        break;
                    }
                    --loc4;
                }
                loc3 = loc3 + blockSize;
            }
            return;
        }

        public function toString():String
        {
            return key.toString() + "-ctr";
        }

        public function encrypt(arg1:flash.utils.ByteArray):void
        {
            padding.pad(arg1);
            var loc1:*=getIV4e();
            core(arg1, loc1);
            return;
        }

        public function decrypt(arg1:flash.utils.ByteArray):void
        {
            var loc1:*=getIV4d();
            core(arg1, loc1);
            padding.unpad(arg1);
            return;
        }
    }
}


