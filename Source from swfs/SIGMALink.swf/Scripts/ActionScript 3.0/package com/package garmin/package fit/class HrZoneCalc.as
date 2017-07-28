//class HrZoneCalc
package com.garmin.fit 
{
    import __AS3__.vec.*;
    import avmplus.*;
    import com.garmin.fit.custom.*;
    import flash.errors.*;
    
    public class HrZoneCalc extends com.garmin.fit.custom.BaseType
    {
        public function HrZoneCalc(arg1:Object, arg2:uint)
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

        public static function getByValue(arg1:uint):com.garmin.fit.HrZoneCalc
        {
            return com.garmin.fit.custom.BaseType.getByValue(arg1) as HrZoneCalc;
        }

        
        {
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(4)[0] = CUSTOM;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(4)[1] = PERCENT_MAX_HR;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(4)[2] = PERCENT_HRR;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(4)[3] = INVALID;
        }

        internal static const SINGLETON_ENFORCER:Object={};

        public static const CUSTOM:com.garmin.fit.HrZoneCalc=new HrZoneCalc(SINGLETON_ENFORCER, 0);

        public static const PERCENT_MAX_HR:com.garmin.fit.HrZoneCalc=new HrZoneCalc(SINGLETON_ENFORCER, 1);

        public static const PERCENT_HRR:com.garmin.fit.HrZoneCalc=new HrZoneCalc(SINGLETON_ENFORCER, 2);

        public static const INVALID:com.garmin.fit.HrZoneCalc=new HrZoneCalc(SINGLETON_ENFORCER, 255);

        public static const VALUES:__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>=new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(4);
    }
}


