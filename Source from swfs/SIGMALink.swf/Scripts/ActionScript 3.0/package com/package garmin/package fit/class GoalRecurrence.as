//class GoalRecurrence
package com.garmin.fit 
{
    import __AS3__.vec.*;
    import avmplus.*;
    import com.garmin.fit.custom.*;
    import flash.errors.*;
    
    public class GoalRecurrence extends com.garmin.fit.custom.BaseType
    {
        public function GoalRecurrence(arg1:Object, arg2:uint)
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

        public static function getByValue(arg1:uint):com.garmin.fit.GoalRecurrence
        {
            return com.garmin.fit.custom.BaseType.getByValue(arg1) as GoalRecurrence;
        }

        
        {
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(7)[0] = OFF;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(7)[1] = DAILY;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(7)[2] = WEEKLY;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(7)[3] = MONTHLY;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(7)[4] = YEARLY;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(7)[5] = CUSTOM;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(7)[6] = INVALID;
        }

        internal static const SINGLETON_ENFORCER:Object={};

        public static const OFF:com.garmin.fit.GoalRecurrence=new GoalRecurrence(SINGLETON_ENFORCER, 0);

        public static const DAILY:com.garmin.fit.GoalRecurrence=new GoalRecurrence(SINGLETON_ENFORCER, 1);

        public static const WEEKLY:com.garmin.fit.GoalRecurrence=new GoalRecurrence(SINGLETON_ENFORCER, 2);

        public static const MONTHLY:com.garmin.fit.GoalRecurrence=new GoalRecurrence(SINGLETON_ENFORCER, 3);

        public static const YEARLY:com.garmin.fit.GoalRecurrence=new GoalRecurrence(SINGLETON_ENFORCER, 4);

        public static const CUSTOM:com.garmin.fit.GoalRecurrence=new GoalRecurrence(SINGLETON_ENFORCER, 5);

        public static const INVALID:com.garmin.fit.GoalRecurrence=new GoalRecurrence(SINGLETON_ENFORCER, 255);

        public static const VALUES:__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>=new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(7);
    }
}


