//class Hex
package com.hurlant.util 
{
    import flash.utils.*;
    
    public class Hex extends Object
    {
        public function Hex()
        {
            super();
            return;
        }

        public static function fromString(arg1:String, arg2:Boolean=false):String
        {
            var loc1:*=new flash.utils.ByteArray();
            loc1.writeUTFBytes(arg1);
            return fromArray(loc1, arg2);
        }

        public static function toString(arg1:String):String
        {
            var loc1:*=toArray(arg1);
            return loc1.readUTFBytes(loc1.length);
        }

        public static function toArray(arg1:String):flash.utils.ByteArray
        {
            arg1 = arg1.replace(new RegExp("\\s|:", "gm"), "");
            var loc1:*=new flash.utils.ByteArray();
            if (arg1.length & 1 == 1) 
            {
                arg1 = "0" + arg1;
            }
            var loc2:*=0;
            while (loc2 < arg1.length) 
            {
                loc1[loc2 / 2] = parseInt(arg1.substr(loc2, 2), 16);
                loc2 = loc2 + 2;
            }
            return loc1;
        }

        public static function fromArray(arg1:flash.utils.ByteArray, arg2:Boolean=false):String
        {
            var loc1:*="";
            var loc2:*=0;
            while (loc2 < arg1.length) 
            {
                loc1 = loc1 + ("0" + arg1[loc2].toString(16)).substr(-2, 2);
                if (arg2) 
                {
                    if (loc2 < (arg1.length - 1)) 
                    {
                        loc1 = loc1 + ":";
                    }
                }
                ++loc2;
            }
            return loc1;
        }
    }
}


