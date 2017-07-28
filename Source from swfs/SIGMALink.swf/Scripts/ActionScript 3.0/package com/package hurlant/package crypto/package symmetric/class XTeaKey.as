//class XTeaKey
package com.hurlant.crypto.symmetric 
{
    import com.hurlant.crypto.prng.*;
    import com.hurlant.util.*;
    import flash.utils.*;
    
    public class XTeaKey extends Object implements com.hurlant.crypto.symmetric.ISymmetricKey
    {
        public function XTeaKey(arg1:flash.utils.ByteArray)
        {
            super();
            arg1.position = 0;
            k = [arg1.readUnsignedInt(), arg1.readUnsignedInt(), arg1.readUnsignedInt(), arg1.readUnsignedInt()];
            return;
        }

        public function encrypt(arg1:flash.utils.ByteArray, arg2:uint=0):void
        {
            var loc3:*=0;
            arg1.position = arg2;
            var loc1:*=arg1.readUnsignedInt();
            var loc2:*=arg1.readUnsignedInt();
            var loc4:*=0;
            var loc5:*=2654435769;
            loc3 = 0;
            while (loc3 < NUM_ROUNDS) 
            {
                loc1 = loc1 + ((loc2 << 4 ^ loc2 >> 5) + loc2 ^ loc4 + k[loc4 & 3]);
                loc4 = loc4 + loc5;
                loc2 = loc2 + ((loc1 << 4 ^ loc1 >> 5) + loc1 ^ loc4 + k[loc4 >> 11 & 3]);
                ++loc3;
            }
            arg1.position = arg1.position - 8;
            arg1.writeUnsignedInt(loc1);
            arg1.writeUnsignedInt(loc2);
            return;
        }

        public function decrypt(arg1:flash.utils.ByteArray, arg2:uint=0):void
        {
            var loc3:*=0;
            arg1.position = arg2;
            var loc1:*=arg1.readUnsignedInt();
            var loc2:*=arg1.readUnsignedInt();
            var loc4:*=2654435769;
            var loc5:*=loc4 * NUM_ROUNDS;
            loc3 = 0;
            while (loc3 < NUM_ROUNDS) 
            {
                loc2 = loc2 - ((loc1 << 4 ^ loc1 >> 5) + loc1 ^ loc5 + k[loc5 >> 11 & 3]);
                loc5 = loc5 - loc4;
                loc1 = loc1 - ((loc2 << 4 ^ loc2 >> 5) + loc2 ^ loc5 + k[loc5 & 3]);
                ++loc3;
            }
            arg1.position = arg1.position - 8;
            arg1.writeUnsignedInt(loc1);
            arg1.writeUnsignedInt(loc2);
            return;
        }

        public function getBlockSize():uint
        {
            return 8;
        }

        public function toString():String
        {
            return "xtea";
        }

        public function dispose():void
        {
            var loc1:*=new com.hurlant.crypto.prng.Random();
            var loc2:*=0;
            while (loc2 < k.length) 
            {
                k[loc2] = loc1.nextByte();
                delete k[loc2];
                ++loc2;
            }
            k = null;
            com.hurlant.util.Memory.gc();
            return;
        }

        public static function parseKey(arg1:String):com.hurlant.crypto.symmetric.XTeaKey
        {
            var loc1:*=new flash.utils.ByteArray();
            loc1.writeUnsignedInt(parseInt(arg1.substr(0, 8), 16));
            loc1.writeUnsignedInt(parseInt(arg1.substr(8, 8), 16));
            loc1.writeUnsignedInt(parseInt(arg1.substr(16, 8), 16));
            loc1.writeUnsignedInt(parseInt(arg1.substr(24, 8), 16));
            loc1.position = 0;
            return new XTeaKey(loc1);
        }

        public const NUM_ROUNDS:uint=64;

        internal var k:Array;
    }
}


