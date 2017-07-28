//class BpStatus
package com.garmin.fit 
{
    import __AS3__.vec.*;
    import avmplus.*;
    import com.garmin.fit.custom.*;
    import flash.errors.*;
    
    public class BpStatus extends com.garmin.fit.custom.BaseType
    {
        public function BpStatus(arg1:Object, arg2:uint)
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

        public static function getByValue(arg1:uint):com.garmin.fit.BpStatus
        {
            return com.garmin.fit.custom.BaseType.getByValue(arg1) as BpStatus;
        }

        
        {
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(6)[0] = NO_ERROR;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(6)[1] = ERROR_INCOMPLETE_DATA;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(6)[2] = ERROR_NO_MEASUREMENT;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(6)[3] = ERROR_DATA_OUT_OF_RANGE;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(6)[4] = ERROR_IRREGULAR_HEART_RATE;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(6)[5] = INVALID;
        }

        internal static const SINGLETON_ENFORCER:Object={};

        public static const NO_ERROR:com.garmin.fit.BpStatus=new BpStatus(SINGLETON_ENFORCER, 0);

        public static const ERROR_INCOMPLETE_DATA:com.garmin.fit.BpStatus=new BpStatus(SINGLETON_ENFORCER, 1);

        public static const ERROR_NO_MEASUREMENT:com.garmin.fit.BpStatus=new BpStatus(SINGLETON_ENFORCER, 2);

        public static const ERROR_DATA_OUT_OF_RANGE:com.garmin.fit.BpStatus=new BpStatus(SINGLETON_ENFORCER, 3);

        public static const ERROR_IRREGULAR_HEART_RATE:com.garmin.fit.BpStatus=new BpStatus(SINGLETON_ENFORCER, 4);

        public static const INVALID:com.garmin.fit.BpStatus=new BpStatus(SINGLETON_ENFORCER, 255);

        internal static const VALUES:__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>=new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(6);
    }
}


