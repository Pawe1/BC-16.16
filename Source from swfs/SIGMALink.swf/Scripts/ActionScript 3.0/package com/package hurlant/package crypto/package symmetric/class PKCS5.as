//class PKCS5
package com.hurlant.crypto.symmetric 
{
    import flash.utils.*;
    
    public class PKCS5 extends Object implements com.hurlant.crypto.symmetric.IPad
    {
        public function PKCS5(arg1:uint=0)
        {
            super();
            this.blockSize = arg1;
            return;
        }

        public function pad(arg1:flash.utils.ByteArray):void
        {
            var loc1:*=blockSize - arg1.length % blockSize;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                arg1[arg1.length] = loc1;
                ++loc2;
            }
            return;
        }

        public function setBlockSize(arg1:uint):void
        {
            blockSize = arg1;
            return;
        }

        public function unpad(arg1:flash.utils.ByteArray):void
        {
            var loc3:*=0;
            var loc1:*=arg1.length % blockSize;
            if (loc1 != 0) 
            {
                throw new Error("PKCS#5::unpad: ByteArray.length isn\'t a multiple of the blockSize");
            }
            loc1 = arg1[(arg1.length - 1)];
            var loc2:*=loc1;
            while (loc2 > 0) 
            {
                loc3 = arg1[(arg1.length - 1)];
                var loc4:*;
                var loc5:*=((loc4 = arg1).length - 1);
                loc4.length = loc5;
                if (loc1 != loc3) 
                {
                    throw new Error("PKCS#5:unpad: Invalid padding value. expected [" + loc1 + "], found [" + loc3 + "]");
                }
                --loc2;
            }
            return;
        }

        internal var blockSize:uint;
    }
}


