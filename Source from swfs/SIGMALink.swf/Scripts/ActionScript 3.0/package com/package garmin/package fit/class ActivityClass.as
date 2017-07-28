//class ActivityClass
package com.garmin.fit 
{
    import __AS3__.vec.*;
    import avmplus.*;
    import com.garmin.fit.custom.*;
    import flash.errors.*;
    
    public class ActivityClass extends com.garmin.fit.custom.BaseType
    {
        public function ActivityClass(arg1:Object, arg2:uint)
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

        public static function getByValue(arg1:uint):com.garmin.fit.ActivityClass
        {
            return com.garmin.fit.custom.BaseType.getByValue(arg1) as ActivityClass;
        }

        
        {
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(4)[0] = LEVEL;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(4)[1] = LEVEL_MAX;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(4)[2] = ATHLETE;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(4)[3] = INVALID;
        }

        internal static const SINGLETON_ENFORCER:Object={};

        public static const LEVEL:com.garmin.fit.ActivityClass=new ActivityClass(SINGLETON_ENFORCER, 127);

        public static const LEVEL_MAX:com.garmin.fit.ActivityClass=new ActivityClass(SINGLETON_ENFORCER, 100);

        public static const ATHLETE:com.garmin.fit.ActivityClass=new ActivityClass(SINGLETON_ENFORCER, 128);

        public static const INVALID:com.garmin.fit.ActivityClass=new ActivityClass(SINGLETON_ENFORCER, 255);

        internal static const VALUES:__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>=new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(4);
    }
}


