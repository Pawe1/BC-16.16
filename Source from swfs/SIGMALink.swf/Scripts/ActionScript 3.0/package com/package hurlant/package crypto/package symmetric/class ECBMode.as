//class ECBMode
package com.hurlant.crypto.symmetric 
{
    import com.hurlant.util.*;
    import flash.utils.*;
    
    public class ECBMode extends Object implements com.hurlant.crypto.symmetric.IMode, com.hurlant.crypto.symmetric.ICipher
    {
        public function ECBMode(arg1:com.hurlant.crypto.symmetric.ISymmetricKey, arg2:com.hurlant.crypto.symmetric.IPad=null)
        {
            super();
            this.key = arg1;
            if (arg2 != null) 
            {
                arg2.setBlockSize(arg1.getBlockSize());
            }
            else 
            {
                arg2 = new com.hurlant.crypto.symmetric.PKCS5(arg1.getBlockSize());
            }
            this.padding = arg2;
            return;
        }

        public function encrypt(arg1:flash.utils.ByteArray):void
        {
            padding.pad(arg1);
            arg1.position = 0;
            var loc1:*=key.getBlockSize();
            var loc2:*=new flash.utils.ByteArray();
            var loc3:*=new flash.utils.ByteArray();
            var loc4:*=0;
            while (loc4 < arg1.length) 
            {
                loc2.length = 0;
                arg1.readBytes(loc2, 0, loc1);
                key.encrypt(loc2);
                loc3.writeBytes(loc2);
                loc4 = loc4 + loc1;
            }
            arg1.length = 0;
            arg1.writeBytes(loc3);
            return;
        }

        public function getBlockSize():uint
        {
            return key.getBlockSize();
        }

        public function decrypt(arg1:flash.utils.ByteArray):void
        {
            arg1.position = 0;
            var loc1:*=key.getBlockSize();
            if (arg1.length % loc1 != 0) 
            {
                throw new Error("ECB mode cipher length must be a multiple of blocksize " + loc1);
            }
            var loc2:*=new flash.utils.ByteArray();
            var loc3:*=new flash.utils.ByteArray();
            var loc4:*=0;
            while (loc4 < arg1.length) 
            {
                loc2.length = 0;
                arg1.readBytes(loc2, 0, loc1);
                key.decrypt(loc2);
                loc3.writeBytes(loc2);
                loc4 = loc4 + loc1;
            }
            padding.unpad(loc3);
            arg1.length = 0;
            arg1.writeBytes(loc3);
            return;
        }

        public function toString():String
        {
            return key.toString() + "-ecb";
        }

        public function dispose():void
        {
            key.dispose();
            key = null;
            padding = null;
            com.hurlant.util.Memory.gc();
            return;
        }

        internal var key:com.hurlant.crypto.symmetric.ISymmetricKey;

        internal var padding:com.hurlant.crypto.symmetric.IPad;
    }
}


