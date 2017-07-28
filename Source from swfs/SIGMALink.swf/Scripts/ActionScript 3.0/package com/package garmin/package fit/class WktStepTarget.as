//class WktStepTarget
package com.garmin.fit 
{
    import __AS3__.vec.*;
    import avmplus.*;
    import com.garmin.fit.custom.*;
    import flash.errors.*;
    
    public class WktStepTarget extends com.garmin.fit.custom.BaseType
    {
        public function WktStepTarget(arg1:Object, arg2:uint)
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

        public static function getByValue(arg1:uint):com.garmin.fit.WktStepTarget
        {
            return com.garmin.fit.custom.BaseType.getByValue(arg1) as WktStepTarget;
        }

        
        {
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(8)[0] = SPEED;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(8)[1] = HEART_RATE;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(8)[2] = OPEN;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(8)[3] = CADENCE;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(8)[4] = POWER;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(8)[5] = GRADE;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(8)[6] = RESISTANCE;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(8)[7] = INVALID;
        }

        internal static const SINGLETON_ENFORCER:Object={};

        public static const SPEED:com.garmin.fit.WktStepTarget=new WktStepTarget(SINGLETON_ENFORCER, 0);

        public static const HEART_RATE:com.garmin.fit.WktStepTarget=new WktStepTarget(SINGLETON_ENFORCER, 1);

        public static const OPEN:com.garmin.fit.WktStepTarget=new WktStepTarget(SINGLETON_ENFORCER, 2);

        public static const CADENCE:com.garmin.fit.WktStepTarget=new WktStepTarget(SINGLETON_ENFORCER, 3);

        public static const POWER:com.garmin.fit.WktStepTarget=new WktStepTarget(SINGLETON_ENFORCER, 4);

        public static const GRADE:com.garmin.fit.WktStepTarget=new WktStepTarget(SINGLETON_ENFORCER, 5);

        public static const RESISTANCE:com.garmin.fit.WktStepTarget=new WktStepTarget(SINGLETON_ENFORCER, 6);

        public static const INVALID:com.garmin.fit.WktStepTarget=new WktStepTarget(SINGLETON_ENFORCER, 255);

        internal static const VALUES:__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>=new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(8);
    }
}


