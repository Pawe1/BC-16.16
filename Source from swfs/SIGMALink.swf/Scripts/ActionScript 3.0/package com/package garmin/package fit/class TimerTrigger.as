//class TimerTrigger
package com.garmin.fit 
{
    import __AS3__.vec.*;
    import avmplus.*;
    import com.garmin.fit.custom.*;
    import flash.errors.*;
    
    public class TimerTrigger extends com.garmin.fit.custom.BaseType
    {
        public function TimerTrigger(arg1:Object, arg2:uint)
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

        public static function getByValue(arg1:uint):com.garmin.fit.TimerTrigger
        {
            return com.garmin.fit.custom.BaseType.getByValue(arg1) as TimerTrigger;
        }

        
        {
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(4)[0] = MANUAL;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(4)[1] = AUTO;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(4)[2] = FITNESS_EQUIPMENT;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(4)[3] = INVALID;
        }

        internal static const SINGLETON_ENFORCER:Object={};

        public static const MANUAL:com.garmin.fit.TimerTrigger=new TimerTrigger(SINGLETON_ENFORCER, 0);

        public static const AUTO:com.garmin.fit.TimerTrigger=new TimerTrigger(SINGLETON_ENFORCER, 1);

        public static const FITNESS_EQUIPMENT:com.garmin.fit.TimerTrigger=new TimerTrigger(SINGLETON_ENFORCER, 2);

        public static const INVALID:com.garmin.fit.TimerTrigger=new TimerTrigger(SINGLETON_ENFORCER, 255);

        internal static const VALUES:__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>=new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(4);
    }
}


