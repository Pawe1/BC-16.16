//class MD2
package com.hurlant.crypto.hash 
{
    import flash.utils.*;
    
    public class MD2 extends Object implements com.hurlant.crypto.hash.IHash
    {
        public function MD2()
        {
            super();
            return;
        }

        public function toString():String
        {
            return "md2";
        }

        public function getInputSize():uint
        {
            return 16;
        }

        public function getHashSize():uint
        {
            return HASH_SIZE;
        }

        public function hash(arg1:flash.utils.ByteArray):flash.utils.ByteArray
        {
            var loc7:*=0;
            var loc8:*=0;
            var loc9:*=0;
            var loc1:*=arg1.length;
            var loc2:*=16 - arg1.length % 16 || 16;
            do 
            {
                arg1[arg1.length] = loc2;
            }
            while (arg1.length % 16 != 0);
            var loc3:*=arg1.length;
            var loc4:*=new flash.utils.ByteArray();
            var loc5:*=0;
            loc2 = 0;
            while (loc2 < loc3) 
            {
                loc7 = 0;
                while (loc7 < 16) 
                {
                    var loc10:*;
                    loc4[loc7] = loc10 = loc4[loc7] ^ S[arg1[loc2 + loc7] ^ loc5];
                    loc5 = loc10;
                    ++loc7;
                }
                loc2 = loc2 + 16;
            }
            arg1.position = arg1.length;
            arg1.writeBytes(loc4);
            loc3 = loc3 + 16;
            var loc6:*=new flash.utils.ByteArray();
            loc2 = 0;
            while (loc2 < loc3) 
            {
                loc7 = 0;
                while (loc7 < 16) 
                {
                    loc6[16 + loc7] = loc10 = arg1[loc2 + loc7];
                    loc6[32 + loc7] = loc10 ^ loc6[loc7];
                    ++loc7;
                }
                loc8 = 0;
                loc7 = 0;
                while (loc7 < 18) 
                {
                    loc9 = 0;
                    while (loc9 < 48) 
                    {
                        loc8 = loc10 = loc6[loc9] ^ S[loc8];
                        loc6[loc9] = loc10;
                        ++loc9;
                    }
                    loc8 = loc8 + loc7 & 255;
                    ++loc7;
                }
                loc2 = loc2 + 16;
            }
            loc6.length = 16;
            arg1.length = loc1;
            return loc6;
        }

        public static const HASH_SIZE:int=16;

        internal static const S:Array=[41, 46, 67, 201, 162, 216, 124, 1, 61, 54, 84, 161, 236, 240, 6, 19, 98, 167, 5, 243, 192, 199, 115, 140, 152, 147, 43, 217, 188, 76, 130, 202, 30, 155, 87, 60, 253, 212, 224, 22, 103, 66, 111, 24, 138, 23, 229, 18, 190, 78, 196, 214, 218, 158, 222, 73, 160, 251, 245, 142, 187, 47, 238, 122, 169, 104, 121, 145, 21, 178, 7, 63, 148, 194, 16, 137, 11, 34, 95, 33, 128, 127, 93, 154, 90, 144, 50, 39, 53, 62, 204, 231, 191, 247, 151, 3, 255, 25, 48, 179, 72, 165, 181, 209, 215, 94, 146, 42, 172, 86, 170, 198, 79, 184, 56, 210, 150, 164, 125, 182, 118, 252, 107, 226, 156, 116, 4, 241, 69, 157, 112, 89, 100, 113, 135, 32, 134, 91, 207, 101, 230, 45, 168, 2, 27, 96, 37, 173, 174, 176, 185, 246, 28, 70, 97, 105, 52, 64, 126, 15, 85, 71, 163, 35, 221, 81, 175, 58, 195, 92, 249, 206, 186, 197, 234, 38, 44, 83, 13, 110, 133, 40, 132, 9, 211, 223, 205, 244, 65, 129, 77, 82, 106, 220, 55, 200, 108, 193, 171, 250, 36, 225, 123, 8, 12, 189, 177, 74, 120, 136, 149, 139, 227, 99, 232, 109, 233, 203, 213, 254, 59, 0, 29, 57, 242, 239, 183, 14, 102, 88, 208, 228, 166, 119, 114, 248, 235, 117, 75, 10, 49, 68, 80, 180, 143, 237, 31, 26, 219, 153, 141, 51, 159, 17, 131, 20];
    }
}


