//class LengthType
package com.garmin.fit 
{
    import __AS3__.vec.*;
    import avmplus.*;
    import com.garmin.fit.custom.*;
    import flash.errors.*;
    
    public class LengthType extends com.garmin.fit.custom.BaseType
    {
        public function LengthType(arg1:Object, arg2:uint)
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

        public static function getByValue(arg1:uint):com.garmin.fit.LengthType
        {
            return com.garmin.fit.custom.BaseType.getByValue(arg1) as LengthType;
        }

        
        {
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(3)[0] = IDLE;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(3)[1] = ACTIVE;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(3)[2] = INVALID;
        }

        internal static const SINGLETON_ENFORCER:Object={};

        public static const IDLE:com.garmin.fit.LengthType=new LengthType(SINGLETON_ENFORCER, 0);

        public static const ACTIVE:com.garmin.fit.LengthType=new LengthType(SINGLETON_ENFORCER, 1);

        public static const INVALID:com.garmin.fit.LengthType=new LengthType(SINGLETON_ENFORCER, 255);

        public static const VALUES:__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>=new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(3);
    }
}


