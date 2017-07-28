//class Sport
package com.garmin.fit 
{
    import __AS3__.vec.*;
    import avmplus.*;
    import com.garmin.fit.custom.*;
    import flash.errors.*;
    
    public class Sport extends com.garmin.fit.custom.BaseType
    {
        public function Sport(arg1:Object, arg2:uint)
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

        public static function getByValue(arg1:uint):com.garmin.fit.Sport
        {
            return com.garmin.fit.custom.BaseType.getByValue(arg1) as Sport;
        }

        
        {
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(13)[0] = GENERIC;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(13)[1] = RUNNING;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(13)[2] = CYCLING;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(13)[3] = TRANSITION;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(13)[4] = FITNESS_EQUIPMENT;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(13)[5] = SWIMMING;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(13)[6] = BASKETBALL;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(13)[7] = SOCCER;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(13)[8] = TENNIS;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(13)[9] = AMERICAN_FOOTBALL;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(13)[10] = TRAINING;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(13)[11] = ALL;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(13)[12] = INVALID;
        }

        internal static const SINGLETON_ENFORCER:Object={};

        public static const GENERIC:com.garmin.fit.Sport=new Sport(SINGLETON_ENFORCER, 0);

        public static const RUNNING:com.garmin.fit.Sport=new Sport(SINGLETON_ENFORCER, 1);

        public static const CYCLING:com.garmin.fit.Sport=new Sport(SINGLETON_ENFORCER, 2);

        public static const TRANSITION:com.garmin.fit.Sport=new Sport(SINGLETON_ENFORCER, 3);

        public static const FITNESS_EQUIPMENT:com.garmin.fit.Sport=new Sport(SINGLETON_ENFORCER, 4);

        public static const SWIMMING:com.garmin.fit.Sport=new Sport(SINGLETON_ENFORCER, 5);

        public static const BASKETBALL:com.garmin.fit.Sport=new Sport(SINGLETON_ENFORCER, 6);

        public static const SOCCER:com.garmin.fit.Sport=new Sport(SINGLETON_ENFORCER, 7);

        public static const TENNIS:com.garmin.fit.Sport=new Sport(SINGLETON_ENFORCER, 8);

        public static const AMERICAN_FOOTBALL:com.garmin.fit.Sport=new Sport(SINGLETON_ENFORCER, 9);

        public static const TRAINING:com.garmin.fit.Sport=new Sport(SINGLETON_ENFORCER, 10);

        public static const ALL:com.garmin.fit.Sport=new Sport(SINGLETON_ENFORCER, 254);

        public static const INVALID:com.garmin.fit.Sport=new Sport(SINGLETON_ENFORCER, 255);

        public static const VALUES:__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>=new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(13);
    }
}


