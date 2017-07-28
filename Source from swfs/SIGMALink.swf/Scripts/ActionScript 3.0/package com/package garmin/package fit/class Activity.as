//class Activity
package com.garmin.fit 
{
    import __AS3__.vec.*;
    import avmplus.*;
    import com.garmin.fit.custom.*;
    import flash.errors.*;
    
    public class Activity extends com.garmin.fit.custom.BaseType
    {
        public function Activity(arg1:Object, arg2:uint)
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

        public static function getByValue(arg1:uint):com.garmin.fit.Activity
        {
            return com.garmin.fit.custom.BaseType.getByValue(arg1) as Activity;
        }

        
        {
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(3)[0] = MANUAL;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(3)[1] = AUTO_MULTI_SPORT;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(3)[2] = INVALID;
        }

        internal static const SINGLETON_ENFORCER:Object={};

        public static const MANUAL:com.garmin.fit.Activity=new Activity(SINGLETON_ENFORCER, 0);

        public static const AUTO_MULTI_SPORT:com.garmin.fit.Activity=new Activity(SINGLETON_ENFORCER, 1);

        public static const INVALID:com.garmin.fit.Activity=new Activity(SINGLETON_ENFORCER, 255);

        public static const VALUES:__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>=new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(3);
    }
}


