//class LapTrigger
package com.garmin.fit 
{
    import __AS3__.vec.*;
    import avmplus.*;
    import com.garmin.fit.custom.*;
    import flash.errors.*;
    
    public class LapTrigger extends com.garmin.fit.custom.BaseType
    {
        public function LapTrigger(arg1:Object, arg2:uint)
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

        public static function getByValue(arg1:uint):com.garmin.fit.LapTrigger
        {
            return com.garmin.fit.custom.BaseType.getByValue(arg1) as LapTrigger;
        }

        
        {
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(10)[0] = MANUAL;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(10)[1] = TIME;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(10)[2] = DISTANCE;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(10)[3] = POSITION_START;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(10)[4] = POSITION_LAP;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(10)[5] = POSITION_WAYPOINT;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(10)[6] = POSITION_MARKED;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(10)[7] = SESSION_END;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(10)[8] = FITNESS_EQUIPMENT;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(10)[9] = INVALID;
        }

        internal static const SINGLETON_ENFORCER:Object={};

        public static const MANUAL:com.garmin.fit.LapTrigger=new LapTrigger(SINGLETON_ENFORCER, 0);

        public static const TIME:com.garmin.fit.LapTrigger=new LapTrigger(SINGLETON_ENFORCER, 1);

        public static const DISTANCE:com.garmin.fit.LapTrigger=new LapTrigger(SINGLETON_ENFORCER, 2);

        public static const POSITION_START:com.garmin.fit.LapTrigger=new LapTrigger(SINGLETON_ENFORCER, 3);

        public static const POSITION_LAP:com.garmin.fit.LapTrigger=new LapTrigger(SINGLETON_ENFORCER, 4);

        public static const POSITION_WAYPOINT:com.garmin.fit.LapTrigger=new LapTrigger(SINGLETON_ENFORCER, 5);

        public static const POSITION_MARKED:com.garmin.fit.LapTrigger=new LapTrigger(SINGLETON_ENFORCER, 6);

        public static const SESSION_END:com.garmin.fit.LapTrigger=new LapTrigger(SINGLETON_ENFORCER, 7);

        public static const FITNESS_EQUIPMENT:com.garmin.fit.LapTrigger=new LapTrigger(SINGLETON_ENFORCER, 8);

        public static const INVALID:com.garmin.fit.LapTrigger=new LapTrigger(SINGLETON_ENFORCER, 255);

        public static const VALUES:__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>=new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(10);
    }
}


