//class Goal
package com.garmin.fit 
{
    import __AS3__.vec.*;
    import avmplus.*;
    import com.garmin.fit.custom.*;
    import flash.errors.*;
    
    public class Goal extends com.garmin.fit.custom.BaseType
    {
        public function Goal(arg1:Object, arg2:uint)
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

        public static function getByValue(arg1:uint):com.garmin.fit.Goal
        {
            return com.garmin.fit.custom.BaseType.getByValue(arg1) as Goal;
        }

        
        {
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(6)[0] = TIME;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(6)[1] = DISTANCE;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(6)[2] = CALORIES;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(6)[3] = FREQUENCY;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(6)[4] = STEPS;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(6)[5] = INVALID;
        }

        internal static const SINGLETON_ENFORCER:Object={};

        public static const TIME:com.garmin.fit.Goal=new Goal(SINGLETON_ENFORCER, 0);

        public static const DISTANCE:com.garmin.fit.Goal=new Goal(SINGLETON_ENFORCER, 1);

        public static const CALORIES:com.garmin.fit.Goal=new Goal(SINGLETON_ENFORCER, 2);

        public static const FREQUENCY:com.garmin.fit.Goal=new Goal(SINGLETON_ENFORCER, 3);

        public static const STEPS:com.garmin.fit.Goal=new Goal(SINGLETON_ENFORCER, 4);

        public static const INVALID:com.garmin.fit.Goal=new Goal(SINGLETON_ENFORCER, 255);

        public static const VALUES:__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>=new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(6);
    }
}


