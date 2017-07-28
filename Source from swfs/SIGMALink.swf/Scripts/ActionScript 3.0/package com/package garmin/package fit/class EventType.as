//class EventType
package com.garmin.fit 
{
    import __AS3__.vec.*;
    import avmplus.*;
    import flash.errors.*;
    
    public class EventType extends Object
    {
        public function EventType(arg1:Object, arg2:uint)
        {
            super();
            if (arg1 != SINGLETON_ENFORCER) 
            {
                throw new flash.errors.IllegalOperationError("IllegalOperation: Manipulation of type " + avmplus.getQualifiedClassName(this));
            }
            this.value = arg2;
            return;
        }

        public function getValue():uint
        {
            return value;
        }

        public static function getByValue(arg1:uint):com.garmin.fit.EventType
        {
            var loc3:*=0;
            var loc2:*=EventType.VALUES;
            for each (var loc1:* in loc2) 
            {
                if (!(arg1 == loc1.value)) 
                {
                    continue;
                }
                return loc1;
            }
            return EventType.INVALID;
        }

        
        {
            new __AS3__.vec.Vector.<>(11)[0] = START;
            new __AS3__.vec.Vector.<>(11)[1] = STOP;
            new __AS3__.vec.Vector.<>(11)[2] = CONSECUTIVE_DEPRECIATED;
            new __AS3__.vec.Vector.<>(11)[3] = MARKER;
            new __AS3__.vec.Vector.<>(11)[4] = STOP_ALL;
            new __AS3__.vec.Vector.<>(11)[5] = BEGIN_DEPRECIATED;
            new __AS3__.vec.Vector.<>(11)[6] = END_DEPRECIATED;
            new __AS3__.vec.Vector.<>(11)[7] = END_ALL_DEPRECIATED;
            new __AS3__.vec.Vector.<>(11)[8] = STOP_DISABLE;
            new __AS3__.vec.Vector.<>(11)[9] = STOP_DISABLE_ALL;
            new __AS3__.vec.Vector.<>(11)[10] = INVALID;
        }

        internal static const SINGLETON_ENFORCER:Object={};

        public static const START:com.garmin.fit.EventType=new EventType(SINGLETON_ENFORCER, 0);

        public static const STOP:com.garmin.fit.EventType=new EventType(SINGLETON_ENFORCER, 1);

        public static const CONSECUTIVE_DEPRECIATED:com.garmin.fit.EventType=new EventType(SINGLETON_ENFORCER, 2);

        public static const MARKER:com.garmin.fit.EventType=new EventType(SINGLETON_ENFORCER, 3);

        public static const STOP_ALL:com.garmin.fit.EventType=new EventType(SINGLETON_ENFORCER, 4);

        public static const BEGIN_DEPRECIATED:com.garmin.fit.EventType=new EventType(SINGLETON_ENFORCER, 5);

        public static const END_DEPRECIATED:com.garmin.fit.EventType=new EventType(SINGLETON_ENFORCER, 6);

        public static const END_ALL_DEPRECIATED:com.garmin.fit.EventType=new EventType(SINGLETON_ENFORCER, 7);

        public static const STOP_DISABLE:com.garmin.fit.EventType=new EventType(SINGLETON_ENFORCER, 8);

        public static const STOP_DISABLE_ALL:com.garmin.fit.EventType=new EventType(SINGLETON_ENFORCER, 9);

        public static const INVALID:com.garmin.fit.EventType=new EventType(SINGLETON_ENFORCER, 255);

        internal static const VALUES:__AS3__.vec.Vector.<com.garmin.fit.EventType>=new __AS3__.vec.Vector.<>(11);

        internal var value:uint;
    }
}


