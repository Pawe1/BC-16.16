//class SwimStroke
package com.garmin.fit 
{
    import __AS3__.vec.*;
    import avmplus.*;
    import com.garmin.fit.custom.*;
    import flash.errors.*;
    
    public class SwimStroke extends com.garmin.fit.custom.BaseType
    {
        public function SwimStroke(arg1:Object, arg2:uint)
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

        public static function getByValue(arg1:uint):com.garmin.fit.SwimStroke
        {
            return com.garmin.fit.custom.BaseType.getByValue(arg1) as SwimStroke;
        }

        
        {
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(8)[0] = FREESTYLE;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(8)[1] = BACKSTROKE;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(8)[2] = BREASTSTROKE;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(8)[3] = BUTTERFLY;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(8)[4] = DRILL;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(8)[5] = MIXED;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(8)[6] = IM;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(8)[7] = INVALID;
        }

        internal static const SINGLETON_ENFORCER:Object={};

        public static const FREESTYLE:com.garmin.fit.SwimStroke=new SwimStroke(SINGLETON_ENFORCER, 0);

        public static const BACKSTROKE:com.garmin.fit.SwimStroke=new SwimStroke(SINGLETON_ENFORCER, 1);

        public static const BREASTSTROKE:com.garmin.fit.SwimStroke=new SwimStroke(SINGLETON_ENFORCER, 2);

        public static const BUTTERFLY:com.garmin.fit.SwimStroke=new SwimStroke(SINGLETON_ENFORCER, 3);

        public static const DRILL:com.garmin.fit.SwimStroke=new SwimStroke(SINGLETON_ENFORCER, 4);

        public static const MIXED:com.garmin.fit.SwimStroke=new SwimStroke(SINGLETON_ENFORCER, 5);

        public static const IM:com.garmin.fit.SwimStroke=new SwimStroke(SINGLETON_ENFORCER, 6);

        public static const INVALID:com.garmin.fit.SwimStroke=new SwimStroke(SINGLETON_ENFORCER, 255);

        internal static const VALUES:__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>=new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(8);
    }
}


