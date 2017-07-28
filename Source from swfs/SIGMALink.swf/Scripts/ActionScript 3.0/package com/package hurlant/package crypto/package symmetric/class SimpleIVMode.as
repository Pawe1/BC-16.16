//class SimpleIVMode
package com.hurlant.crypto.symmetric 
{
    import com.hurlant.util.*;
    import flash.utils.*;
    
    public class SimpleIVMode extends Object implements com.hurlant.crypto.symmetric.IMode, com.hurlant.crypto.symmetric.ICipher
    {
        public function SimpleIVMode(arg1:com.hurlant.crypto.symmetric.IVMode)
        {
            super();
            this.mode = arg1;
            cipher = arg1 as com.hurlant.crypto.symmetric.ICipher;
            return;
        }

        public function encrypt(arg1:flash.utils.ByteArray):void
        {
            cipher.encrypt(arg1);
            var loc1:*=new flash.utils.ByteArray();
            loc1.writeBytes(mode.IV);
            loc1.writeBytes(arg1);
            arg1.position = 0;
            arg1.writeBytes(loc1);
            return;
        }

        public function decrypt(arg1:flash.utils.ByteArray):void
        {
            var loc1:*=new flash.utils.ByteArray();
            loc1.writeBytes(arg1, 0, getBlockSize());
            mode.IV = loc1;
            loc1 = new flash.utils.ByteArray();
            loc1.writeBytes(arg1, getBlockSize());
            cipher.decrypt(loc1);
            arg1.length = 0;
            arg1.writeBytes(loc1);
            return;
        }

        public function dispose():void
        {
            mode.dispose();
            mode = null;
            cipher = null;
            com.hurlant.util.Memory.gc();
            return;
        }

        public function getBlockSize():uint
        {
            return mode.getBlockSize();
        }

        public function toString():String
        {
            return "simple-" + cipher.toString();
        }

        protected var mode:com.hurlant.crypto.symmetric.IVMode;

        protected var cipher:com.hurlant.crypto.symmetric.ICipher;
    }
}


