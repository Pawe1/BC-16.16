//class DisplayHeart
package com.garmin.fit 
{
    import __AS3__.vec.*;
    import avmplus.*;
    import com.garmin.fit.custom.*;
    import flash.errors.*;
    
    public class DisplayHeart extends com.garmin.fit.custom.BaseType
    {
        public function DisplayHeart(arg1:Object, arg2:uint)
        {
            super();
            if (arg1 != SINGLETON_ENFORCER) 
            {
                throw new flash.errors.IllegalOperationError("IllegalOperation: Manipulation of type " + avmplus.getQualifiedClassName(this));
            }
            this.value = arg2;
            return;
        }

        public function getAllValues():__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>
        {
            return VALUES;
        }

        public function getInvalid():com.garmin.fit.custom.BaseType
        {
            return INVALID;
        }

        public function getValue():uint
        {
            return value;
        }

        public static function getByValue(arg1:uint):com.garmin.fit.DisplayHeart
        {
            return com.garmin.fit.custom.BaseType.getByValue(arg1) as DisplayHeart;
        }

        
        {
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(4)[0] = BPM;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(4)[1] = MAX;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(4)[2] = RESERVE;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(4)[3] = INVALID;
        }

        internal static const SINGLETON_ENFORCER:Object={};

        public static const BPM:com.garmin.fit.DisplayHeart=new DisplayHeart(SINGLETON_ENFORCER, 0);

        public static const MAX:com.garmin.fit.DisplayHeart=new DisplayHeart(SINGLETON_ENFORCER, 1);

        public static const RESERVE:com.garmin.fit.DisplayHeart=new DisplayHeart(SINGLETON_ENFORCER, 2);

        public static const INVALID:com.garmin.fit.DisplayHeart=new DisplayHeart(SINGLETON_ENFORCER, 255);

        internal static const VALUES:__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>=new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(4);
    }
}


