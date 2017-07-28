//class Intensity
package com.garmin.fit 
{
    import __AS3__.vec.*;
    import avmplus.*;
    import com.garmin.fit.custom.*;
    import flash.errors.*;
    
    public class Intensity extends com.garmin.fit.custom.BaseType
    {
        public function Intensity(arg1:Object, arg2:uint)
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

        public static function getByValue(arg1:uint):com.garmin.fit.Intensity
        {
            return com.garmin.fit.custom.BaseType.getByValue(arg1) as Intensity;
        }

        
        {
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(5)[0] = ACTIVE;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(5)[1] = REST;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(5)[2] = WARMUP;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(5)[3] = COOLDOWN;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(5)[4] = INVALID;
        }

        internal static const SINGLETON_ENFORCER:Object={};

        public static const ACTIVE:com.garmin.fit.Intensity=new Intensity(SINGLETON_ENFORCER, 0);

        public static const REST:com.garmin.fit.Intensity=new Intensity(SINGLETON_ENFORCER, 1);

        public static const WARMUP:com.garmin.fit.Intensity=new Intensity(SINGLETON_ENFORCER, 2);

        public static const COOLDOWN:com.garmin.fit.Intensity=new Intensity(SINGLETON_ENFORCER, 3);

        public static const INVALID:com.garmin.fit.Intensity=new Intensity(SINGLETON_ENFORCER, 255);

        public static const VALUES:__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>=new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(5);
    }
}


