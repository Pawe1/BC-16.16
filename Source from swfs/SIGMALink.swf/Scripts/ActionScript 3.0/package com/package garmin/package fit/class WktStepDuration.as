//class WktStepDuration
package com.garmin.fit 
{
    import __AS3__.vec.*;
    import avmplus.*;
    import com.garmin.fit.custom.*;
    import flash.errors.*;
    
    public class WktStepDuration extends com.garmin.fit.custom.BaseType
    {
        public function WktStepDuration(arg1:Object, arg2:uint)
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

        public static function getByValue(arg1:uint):com.garmin.fit.WktStepDuration
        {
            return com.garmin.fit.custom.BaseType.getByValue(arg1) as WktStepDuration;
        }

        
        {
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(17)[0] = TIME;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(17)[1] = DISTANCE;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(17)[2] = HR_LESS_THAN;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(17)[3] = HR_GREATER_THAN;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(17)[4] = CALORIES;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(17)[5] = OPEN;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(17)[6] = REPEAT_UNTIL_STEPS_CMPLT;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(17)[7] = REPEAT_UNTIL_TIME;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(17)[8] = REPEAT_UNTIL_DISTANCE;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(17)[9] = REPEAT_UNTIL_CALORIES;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(17)[10] = REPEAT_UNTIL_HR_LESS_THAN;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(17)[11] = REPEAT_UNTIL_HR_GREATER_THAN;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(17)[12] = REPEAT_UNTIL_POWER_LESS_THAN;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(17)[13] = REPEAT_UNTIL_POWER_GREATER_THAN;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(17)[14] = POWER_LESS_THAN;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(17)[15] = POWER_GREATER_THAN;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(17)[16] = INVALID;
        }

        internal static const SINGLETON_ENFORCER:Object={};

        public static const TIME:com.garmin.fit.WktStepDuration=new WktStepDuration(SINGLETON_ENFORCER, 0);

        public static const DISTANCE:com.garmin.fit.WktStepDuration=new WktStepDuration(SINGLETON_ENFORCER, 1);

        public static const HR_LESS_THAN:com.garmin.fit.WktStepDuration=new WktStepDuration(SINGLETON_ENFORCER, 2);

        public static const HR_GREATER_THAN:com.garmin.fit.WktStepDuration=new WktStepDuration(SINGLETON_ENFORCER, 3);

        public static const CALORIES:com.garmin.fit.WktStepDuration=new WktStepDuration(SINGLETON_ENFORCER, 4);

        public static const OPEN:com.garmin.fit.WktStepDuration=new WktStepDuration(SINGLETON_ENFORCER, 5);

        public static const REPEAT_UNTIL_STEPS_CMPLT:com.garmin.fit.WktStepDuration=new WktStepDuration(SINGLETON_ENFORCER, 6);

        public static const REPEAT_UNTIL_TIME:com.garmin.fit.WktStepDuration=new WktStepDuration(SINGLETON_ENFORCER, 7);

        public static const REPEAT_UNTIL_DISTANCE:com.garmin.fit.WktStepDuration=new WktStepDuration(SINGLETON_ENFORCER, 8);

        public static const REPEAT_UNTIL_CALORIES:com.garmin.fit.WktStepDuration=new WktStepDuration(SINGLETON_ENFORCER, 9);

        public static const REPEAT_UNTIL_HR_LESS_THAN:com.garmin.fit.WktStepDuration=new WktStepDuration(SINGLETON_ENFORCER, 10);

        public static const REPEAT_UNTIL_HR_GREATER_THAN:com.garmin.fit.WktStepDuration=new WktStepDuration(SINGLETON_ENFORCER, 11);

        public static const REPEAT_UNTIL_POWER_LESS_THAN:com.garmin.fit.WktStepDuration=new WktStepDuration(SINGLETON_ENFORCER, 12);

        public static const REPEAT_UNTIL_POWER_GREATER_THAN:com.garmin.fit.WktStepDuration=new WktStepDuration(SINGLETON_ENFORCER, 13);

        public static const POWER_LESS_THAN:com.garmin.fit.WktStepDuration=new WktStepDuration(SINGLETON_ENFORCER, 14);

        public static const POWER_GREATER_THAN:com.garmin.fit.WktStepDuration=new WktStepDuration(SINGLETON_ENFORCER, 15);

        public static const INVALID:com.garmin.fit.WktStepDuration=new WktStepDuration(SINGLETON_ENFORCER, 255);

        internal static const VALUES:__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>=new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(17);
    }
}


