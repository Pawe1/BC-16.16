//class Transitions
package starling.animation 
{
    import flash.utils.*;
    import starling.errors.*;
    
    public class Transitions extends Object
    {
        public function Transitions()
        {
            super();
            throw new starling.errors.AbstractClassError();
        }

        protected static function linear(arg1:Number):Number
        {
            return arg1;
        }

        protected static function easeIn(arg1:Number):Number
        {
            return arg1 * arg1 * arg1;
        }

        protected static function easeOut(arg1:Number):Number
        {
            var loc1:*;
            --loc1;
            return loc1 * loc1 * loc1 + 1;
        }

        protected static function easeInOut(arg1:Number):Number
        {
            return easeCombined(easeIn, easeOut, arg1);
        }

        protected static function easeOutIn(arg1:Number):Number
        {
            return easeCombined(easeOut, easeIn, arg1);
        }

        protected static function easeInBack(arg1:Number):Number
        {
            var loc1:*=1.70158;
            return Math.pow(arg1, 2) * ((loc1 + 1) * arg1 - loc1);
        }

        protected static function easeOutBack(arg1:Number):Number
        {
            var loc1:*;
            --loc1;
            var loc2:*=1.70158;
            return Math.pow(loc1, 2) * ((loc2 + 1) * loc1 + loc2) + 1;
        }

        protected static function easeInOutBack(arg1:Number):Number
        {
            return easeCombined(easeInBack, easeOutBack, arg1);
        }

        protected static function easeOutInBack(arg1:Number):Number
        {
            return easeCombined(easeOutBack, easeInBack, arg1);
        }

        protected static function easeInElastic(arg1:Number):Number
        {
            var loc1:*=NaN;
            var loc2:*=NaN;
            var loc3:*=NaN;
            if (arg1 == 0 || arg1 == 1) 
            {
                return arg1;
            }
            loc1 = 0.3;
            loc2 = loc1 / 4;
            --loc3;
            return -1 * Math.pow(2, 10 * loc3) * Math.sin((loc3 - loc2) * 2 * Math.PI / loc1);
        }

        protected static function easeOutElastic(arg1:Number):Number
        {
            var loc1:*=NaN;
            var loc2:*=NaN;
            if (arg1 == 0 || arg1 == 1) 
            {
                return arg1;
            }
            loc1 = 0.3;
            loc2 = loc1 / 4;
            return Math.pow(2, -10 * arg1) * Math.sin((arg1 - loc2) * 2 * Math.PI / loc1) + 1;
        }

        protected static function easeInOutElastic(arg1:Number):Number
        {
            return easeCombined(easeInElastic, easeOutElastic, arg1);
        }

        protected static function easeOutInElastic(arg1:Number):Number
        {
            return easeCombined(easeOutElastic, easeInElastic, arg1);
        }

        protected static function easeInBounce(arg1:Number):Number
        {
            return 1 - easeOutBounce(1 - arg1);
        }

        protected static function easeOutBounce(arg1:Number):Number
        {
            var loc3:*=NaN;
            var loc1:*=7.5625;
            var loc2:*=2.75;
            if (arg1 < 1 / loc2) 
            {
                loc3 = loc1 * Math.pow(arg1, 2);
            }
            else if (arg1 < 2 / loc2) 
            {
                arg1 = arg1 - 1.5 / loc2;
                loc3 = loc1 * Math.pow(arg1, 2) + 0.75;
            }
            else if (arg1 < 2.5 / loc2) 
            {
                arg1 = arg1 - 2.25 / loc2;
                loc3 = loc1 * Math.pow(arg1, 2) + 0.9375;
            }
            else 
            {
                arg1 = arg1 - 2.625 / loc2;
                loc3 = loc1 * Math.pow(arg1, 2) + 0.984375;
            }
            return loc3;
        }

        protected static function easeInOutBounce(arg1:Number):Number
        {
            return easeCombined(easeInBounce, easeOutBounce, arg1);
        }

        protected static function easeOutInBounce(arg1:Number):Number
        {
            return easeCombined(easeOutBounce, easeInBounce, arg1);
        }

        protected static function easeCombined(arg1:Function, arg2:Function, arg3:Number):Number
        {
            if (arg3 < 0.5) 
            {
                return 0.5 * arg1(arg3 * 2);
            }
            return 0.5 * arg2((arg3 - 0.5) * 2) + 0.5;
        }

        public static function getTransition(arg1:String):Function
        {
            if (sTransitions == null) 
            {
                registerDefaults();
            }
            return sTransitions[arg1];
        }

        public static function register(arg1:String, arg2:Function):void
        {
            if (sTransitions == null) 
            {
                registerDefaults();
            }
            sTransitions[arg1] = arg2;
            return;
        }

        internal static function registerDefaults():void
        {
            sTransitions = new flash.utils.Dictionary();
            register(LINEAR, linear);
            register(EASE_IN, easeIn);
            register(EASE_OUT, easeOut);
            register(EASE_IN_OUT, easeInOut);
            register(EASE_OUT_IN, easeOutIn);
            register(EASE_IN_BACK, easeInBack);
            register(EASE_OUT_BACK, easeOutBack);
            register(EASE_IN_OUT_BACK, easeInOutBack);
            register(EASE_OUT_IN_BACK, easeOutInBack);
            register(EASE_IN_ELASTIC, easeInElastic);
            register(EASE_OUT_ELASTIC, easeOutElastic);
            register(EASE_IN_OUT_ELASTIC, easeInOutElastic);
            register(EASE_OUT_IN_ELASTIC, easeOutInElastic);
            register(EASE_IN_BOUNCE, easeInBounce);
            register(EASE_OUT_BOUNCE, easeOutBounce);
            register(EASE_IN_OUT_BOUNCE, easeInOutBounce);
            register(EASE_OUT_IN_BOUNCE, easeOutInBounce);
            return;
        }

        public static const LINEAR:String="linear";

        public static const EASE_IN:String="easeIn";

        public static const EASE_OUT:String="easeOut";

        public static const EASE_IN_OUT:String="easeInOut";

        public static const EASE_OUT_IN:String="easeOutIn";

        public static const EASE_IN_BACK:String="easeInBack";

        public static const EASE_OUT_BACK:String="easeOutBack";

        public static const EASE_IN_OUT_BACK:String="easeInOutBack";

        public static const EASE_OUT_IN_BACK:String="easeOutInBack";

        public static const EASE_IN_ELASTIC:String="easeInElastic";

        public static const EASE_OUT_ELASTIC:String="easeOutElastic";

        public static const EASE_IN_OUT_ELASTIC:String="easeInOutElastic";

        public static const EASE_OUT_IN_ELASTIC:String="easeOutInElastic";

        public static const EASE_IN_BOUNCE:String="easeInBounce";

        public static const EASE_OUT_BOUNCE:String="easeOutBounce";

        public static const EASE_IN_OUT_BOUNCE:String="easeInOutBounce";

        public static const EASE_OUT_IN_BOUNCE:String="easeOutInBounce";

        internal static var sTransitions:flash.utils.Dictionary;
    }
}


