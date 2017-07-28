//class HrType
package com.garmin.fit 
{
    import __AS3__.vec.*;
    import avmplus.*;
    import com.garmin.fit.custom.*;
    import flash.errors.*;
    
    public class HrType extends com.garmin.fit.custom.BaseType
    {
        public function HrType(arg1:Object, arg2:uint)
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

        public static function getByValue(arg1:uint):com.garmin.fit.HrType
        {
            return com.garmin.fit.custom.BaseType.getByValue(arg1) as HrType;
        }

        
        {
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(3)[0] = NORMAL;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(3)[1] = IRREGULAR;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(3)[2] = INVALID;
        }

        internal static const SINGLETON_ENFORCER:Object={};

        public static const NORMAL:com.garmin.fit.HrType=new HrType(SINGLETON_ENFORCER, 0);

        public static const IRREGULAR:com.garmin.fit.HrType=new HrType(SINGLETON_ENFORCER, 1);

        public static const INVALID:com.garmin.fit.HrType=new HrType(SINGLETON_ENFORCER, 255);

        public static const VALUES:__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>=new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(3);
    }
}


