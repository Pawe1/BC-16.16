//class GUID
package utils 
{
    import flash.system.*;
    
    public class GUID extends Object
    {
        public function GUID()
        {
            super();
            return;
        }

        public static function create():String
        {
            var loc1:*=new Date();
            var loc4:*=loc1.getTime();
            var loc3:*=Math.random() * 1.79769313486e+308;
            var loc6:*=flash.system.Capabilities.serverString;
            counter = (counter + 1);
            var loc5:*;
            var loc2:*=(loc5 = calculate(loc4 + loc6 + loc3 + counter).toUpperCase()).substring(0, 8) + "-" + loc5.substring(8, 12) + "-" + loc5.substring(12, 16) + "-" + loc5.substring(16, 20) + "-" + loc5.substring(20, 32);
            return loc2;
        }

        internal static function calculate(arg1:String):String
        {
            return hex_sha1(arg1);
        }

        internal static function hex_sha1(arg1:String):String
        {
            return binb2hex(core_sha1(str2binb(arg1), arg1.length * 8));
        }

        internal static function core_sha1(arg1:Array, arg2:Number):Array
        {
            var loc7:*=NaN;
            var loc11:*=NaN;
            var loc6:*=NaN;
            var loc10:*=NaN;
            var loc13:*=NaN;
            var loc15:*=arg2 >> 5;
            var loc16:*=arg1[loc15] | 128 << 24 - arg2 % 32;
            arg1[loc15] = loc16;
            arg1[(arg2 + 64 >> 9 << 4) + 15] = arg2;
            var loc14:*=new Array(80);
            var loc1:*=1732584193;
            var loc2:*=-271733879;
            var loc3:*=-1732584194;
            var loc4:*=271733878;
            var loc5:*=-1009589776;
            loc7 = 0;
            while (loc7 < arg1.length) 
            {
                loc11 = loc1;
                var loc12:*=loc2;
                loc6 = loc3;
                var loc8:*=loc4;
                var loc9:*=loc5;
                loc10 = 0;
                while (loc10 < 80) 
                {
                    if (loc10 < 16) 
                    {
                        loc14[loc10] = arg1[loc7 + loc10];
                    }
                    else 
                    {
                        loc14[loc10] = rol(loc14[loc10 - 3] ^ loc14[loc10 - 8] ^ loc14[loc10 - 14] ^ loc14[loc10 - 16], 1);
                    }
                    loc13 = safe_add(safe_add(rol(loc1, 5), sha1_ft(loc10, loc2, loc3, loc4)), safe_add(safe_add(loc5, loc14[loc10]), sha1_kt(loc10)));
                    loc5 = loc4;
                    loc4 = loc3;
                    loc3 = rol(loc2, 30);
                    loc2 = loc1;
                    loc1 = loc13;
                    ++loc10;
                }
                loc1 = safe_add(loc1, loc11);
                loc2 = safe_add(loc2, loc12);
                loc3 = safe_add(loc3, loc6);
                loc4 = safe_add(loc4, loc8);
                loc5 = safe_add(loc5, loc9);
                loc7 = loc7 + 16;
            }
            return new Array(loc1, loc2, loc3, loc4, loc5);
        }

        internal static function sha1_ft(arg1:Number, arg2:Number, arg3:Number, arg4:Number):Number
        {
            if (arg1 < 20) 
            {
                return arg2 & arg3 | ~arg2 & arg4;
            }
            if (arg1 < 40) 
            {
                return arg2 ^ arg3 ^ arg4;
            }
            if (arg1 < 60) 
            {
                return arg2 & arg3 | arg2 & arg4 | arg3 & arg4;
            }
            return arg2 ^ arg3 ^ arg4;
        }

        internal static function sha1_kt(arg1:Number):Number
        {
            return arg1 < 20 ? 1518500249 : arg1 < 40 ? 1859775393 : arg1 < 60 ? -1894007588 : -899497514;
        }

        internal static function safe_add(arg1:Number, arg2:Number):Number
        {
            var loc2:*=(arg1 & 65535) + (arg2 & 65535);
            var loc1:*=(arg1 >> 16) + (arg2 >> 16) + (loc2 >> 16);
            return loc1 << 16 | loc2 & 65535;
        }

        internal static function rol(arg1:Number, arg2:Number):Number
        {
            return arg1 << arg2 | arg1 >>> 32 - arg2;
        }

        internal static function str2binb(arg1:String):Array
        {
            var loc2:*=NaN;
            var loc1:*=[];
            var loc3:*=255;
            loc2 = 0;
            while (loc2 < arg1.length * 8) 
            {
                var loc4:*=loc2 >> 5;
                var loc5:*=loc1[loc4] | (arg1.charCodeAt(loc2 / 8) & loc3) << 24 - loc2 % 32;
                loc1[loc4] = loc5;
                loc2 = loc2 + 8;
            }
            return loc1;
        }

        internal static function binb2hex(arg1:Array):String
        {
            var loc3:*=NaN;
            var loc1:*=new String("");
            var loc2:*=new String("0123456789abcdef");
            loc3 = 0;
            while (loc3 < arg1.length * 4) 
            {
                loc1 = loc1 + (loc2.charAt(arg1[loc3 >> 2] >> (3 - loc3 % 4) * 8 + 4 & 15) + loc2.charAt(arg1[loc3 >> 2] >> (3 - loc3 % 4) * 8 & 15));
                ++loc3;
            }
            return loc1;
        }

        internal static var counter:Number=0;
    }
}


