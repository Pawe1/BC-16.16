//class SessionTrigger
package com.garmin.fit 
{
    import __AS3__.vec.*;
    import avmplus.*;
    import flash.errors.*;
    
    public class SessionTrigger extends Object
    {
        public function SessionTrigger(arg1:Object, arg2:uint)
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

        public static function getByValue(arg1:uint):com.garmin.fit.SessionTrigger
        {
            var loc3:*=0;
            var loc2:*=SessionTrigger.VALUES;
            for each (var loc1:* in loc2) 
            {
                if (!(arg1 == loc1.value)) 
                {
                    continue;
                }
                return loc1;
            }
            return SessionTrigger.INVALID;
        }

        
        {
            new __AS3__.vec.Vector.<>(5)[0] = ACTIVITY_END;
            new __AS3__.vec.Vector.<>(5)[1] = MANUAL;
            new __AS3__.vec.Vector.<>(5)[2] = AUTO_MULTI_SPORT;
            new __AS3__.vec.Vector.<>(5)[3] = FITNESS_EQUIPMENT;
            new __AS3__.vec.Vector.<>(5)[4] = INVALID;
        }

        internal static const SINGLETON_ENFORCER:Object={};

        public static const ACTIVITY_END:com.garmin.fit.SessionTrigger=new SessionTrigger(SINGLETON_ENFORCER, 0);

        public static const MANUAL:com.garmin.fit.SessionTrigger=new SessionTrigger(SINGLETON_ENFORCER, 1);

        public static const AUTO_MULTI_SPORT:com.garmin.fit.SessionTrigger=new SessionTrigger(SINGLETON_ENFORCER, 2);

        public static const FITNESS_EQUIPMENT:com.garmin.fit.SessionTrigger=new SessionTrigger(SINGLETON_ENFORCER, 3);

        public static const INVALID:com.garmin.fit.SessionTrigger=new SessionTrigger(SINGLETON_ENFORCER, 255);

        public static const VALUES:__AS3__.vec.Vector.<com.garmin.fit.SessionTrigger>=new __AS3__.vec.Vector.<>(5);

        internal var value:uint;
    }
}


