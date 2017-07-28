//class SHABase
package com.hurlant.crypto.hash 
{
    import flash.utils.*;
    
    public class SHABase extends Object implements com.hurlant.crypto.hash.IHash
    {
        public function SHABase()
        {
            super();
            return;
        }

        public function toString():String
        {
            return "sha";
        }

        public function getInputSize():uint
        {
            return 64;
        }

        public function getHashSize():uint
        {
            return 0;
        }

        public function hash(arg1:flash.utils.ByteArray):flash.utils.ByteArray
        {
            var loc1:*=arg1.length;
            var loc2:*=arg1.endian;
            arg1.endian = flash.utils.Endian.BIG_ENDIAN;
            var loc3:*=loc1 * 8;
            while (arg1.length % 4 != 0) 
            {
                arg1[arg1.length] = 0;
            }
            arg1.position = 0;
            var loc4:*=[];
            var loc5:*=0;
            while (loc5 < arg1.length) 
            {
                loc4.push(arg1.readUnsignedInt());
                loc5 = loc5 + 4;
            }
            var loc6:*=core(loc4, loc3);
            var loc7:*=new flash.utils.ByteArray();
            var loc8:*=getHashSize() / 4;
            loc5 = 0;
            while (loc5 < loc8) 
            {
                loc7.writeUnsignedInt(loc6[loc5]);
                ++loc5;
            }
            arg1.length = loc1;
            arg1.endian = loc2;
            return loc7;
        }

        protected function core(arg1:Array, arg2:uint):Array
        {
            return null;
        }
    }
}


