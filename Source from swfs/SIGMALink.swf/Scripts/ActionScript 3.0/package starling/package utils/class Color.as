//class Color
package starling.utils 
{
    import __AS3__.vec.*;
    import starling.errors.*;
    
    public class Color extends Object
    {
        public function Color()
        {
            super();
            throw new starling.errors.AbstractClassError();
        }

        public static function getAlpha(arg1:uint):int
        {
            return arg1 >> 24 & 255;
        }

        public static function getRed(arg1:uint):int
        {
            return arg1 >> 16 & 255;
        }

        public static function getGreen(arg1:uint):int
        {
            return arg1 >> 8 & 255;
        }

        public static function getBlue(arg1:uint):int
        {
            return arg1 & 255;
        }

        public static function rgb(arg1:int, arg2:int, arg3:int):uint
        {
            return arg1 << 16 | arg2 << 8 | arg3;
        }

        public static function argb(arg1:int, arg2:int, arg3:int, arg4:int):uint
        {
            return arg1 << 24 | arg2 << 16 | arg3 << 8 | arg4;
        }

        public static function toVector(arg1:uint, arg2:__AS3__.vec.Vector.<Number>=null):__AS3__.vec.Vector.<Number>
        {
            if (arg2 == null) 
            {
                arg2 = new Vector.<Number>(4, true);
            }
            arg2[0] = (arg1 >> 16 & 255) / 255;
            arg2[1] = (arg1 >> 8 & 255) / 255;
            arg2[2] = (arg1 & 255) / 255;
            arg2[3] = (arg1 >> 24 & 255) / 255;
            return arg2;
        }

        public static function multiply(arg1:uint, arg2:Number):uint
        {
            var loc1:*=(arg1 >> 24 & 255) * arg2;
            var loc2:*=(arg1 >> 16 & 255) * arg2;
            var loc3:*=(arg1 >> 8 & 255) * arg2;
            var loc4:*=(arg1 & 255) * arg2;
            if (loc1 > 255) 
            {
                loc1 = 255;
            }
            if (loc2 > 255) 
            {
                loc2 = 255;
            }
            if (loc3 > 255) 
            {
                loc3 = 255;
            }
            if (loc4 > 255) 
            {
                loc4 = 255;
            }
            return argb(loc1, loc2, loc3, loc4);
        }

        public static function interpolate(arg1:uint, arg2:uint, arg3:Number):uint
        {
            var loc1:*=arg1 >> 24 & 255;
            var loc2:*=arg1 >> 16 & 255;
            var loc3:*=arg1 >> 8 & 255;
            var loc4:*=arg1 & 255;
            var loc5:*=arg2 >> 24 & 255;
            var loc6:*=arg2 >> 16 & 255;
            var loc7:*=arg2 >> 8 & 255;
            var loc8:*=arg2 & 255;
            var loc9:*=loc1 + (loc5 - loc1) * arg3;
            var loc10:*=loc2 + (loc6 - loc2) * arg3;
            var loc11:*=loc3 + (loc7 - loc3) * arg3;
            var loc12:*=loc4 + (loc8 - loc4) * arg3;
            return loc9 << 24 | loc10 << 16 | loc11 << 8 | loc12;
        }

        public static const WHITE:uint=16777215;

        public static const SILVER:uint=12632256;

        public static const GRAY:uint=8421504;

        public static const BLACK:uint=0;

        public static const RED:uint=16711680;

        public static const MAROON:uint=8388608;

        public static const YELLOW:uint=16776960;

        public static const OLIVE:uint=8421376;

        public static const LIME:uint=65280;

        public static const GREEN:uint=32768;

        public static const AQUA:uint=65535;

        public static const TEAL:uint=32896;

        public static const BLUE:uint=255;

        public static const NAVY:uint=128;

        public static const FUCHSIA:uint=16711935;

        public static const PURPLE:uint=8388736;
    }
}


