//class FITEvent
package com.garmin.fit 
{
    import __AS3__.vec.*;
    import avmplus.*;
    import flash.errors.*;
    
    public class FITEvent extends Object
    {
        public function FITEvent(arg1:Object, arg2:uint)
        {
            super();
            if (arg1 != SINGLETON_ENFORCER) 
            {
                throw new flash.errors.IllegalOperationError("IllegalOperation: Manipulation of type " + avmplus.getQualifiedClassName(this));
            }
            this.value = arg2;
            return;
        }

        public static function getByValue(arg1:uint):com.garmin.fit.FITEvent
        {
            var loc3:*=0;
            var loc2:*=FITEvent.VALUES;
            for each (var loc1:* in loc2) 
            {
                if (!(arg1 == loc1.value)) 
                {
                    continue;
                }
                return loc1;
            }
            return FITEvent.INVALID;
        }

        public function getValue():uint
        {
            return value;
        }

        
        {
            new __AS3__.vec.Vector.<>(28)[0] = TIMER;
            new __AS3__.vec.Vector.<>(28)[1] = WORKOUT;
            new __AS3__.vec.Vector.<>(28)[2] = WORKOUT_STEP;
            new __AS3__.vec.Vector.<>(28)[3] = POWER_DOWN;
            new __AS3__.vec.Vector.<>(28)[4] = POWER_UP;
            new __AS3__.vec.Vector.<>(28)[5] = OFF_COURSE;
            new __AS3__.vec.Vector.<>(28)[6] = SESSION;
            new __AS3__.vec.Vector.<>(28)[7] = LAP;
            new __AS3__.vec.Vector.<>(28)[8] = COURSE_POINT;
            new __AS3__.vec.Vector.<>(28)[9] = BATTERY;
            new __AS3__.vec.Vector.<>(28)[10] = VIRTUAL_PARTNER_PACE;
            new __AS3__.vec.Vector.<>(28)[11] = HR_HIGH_ALERT;
            new __AS3__.vec.Vector.<>(28)[12] = HR_LOW_ALERT;
            new __AS3__.vec.Vector.<>(28)[13] = SPEED_HIGH_ALERT;
            new __AS3__.vec.Vector.<>(28)[14] = SPEED_LOW_ALERT;
            new __AS3__.vec.Vector.<>(28)[15] = CAD_HIGH_ALERT;
            new __AS3__.vec.Vector.<>(28)[16] = CAD_LOW_ALERT;
            new __AS3__.vec.Vector.<>(28)[17] = POWER_HIGH_ALERT;
            new __AS3__.vec.Vector.<>(28)[18] = POWER_LOW_ALERT;
            new __AS3__.vec.Vector.<>(28)[19] = RECOVERY_HR;
            new __AS3__.vec.Vector.<>(28)[20] = BATTERY_LOW;
            new __AS3__.vec.Vector.<>(28)[21] = TIME_DURATION_ALERT;
            new __AS3__.vec.Vector.<>(28)[22] = DISTANCE_DURATION_ALERT;
            new __AS3__.vec.Vector.<>(28)[23] = CALORIE_DURATION_ALERT;
            new __AS3__.vec.Vector.<>(28)[24] = ACTIVITY;
            new __AS3__.vec.Vector.<>(28)[25] = FITNESS_EQUIPMENT;
            new __AS3__.vec.Vector.<>(28)[26] = LENGTH;
            new __AS3__.vec.Vector.<>(28)[27] = INVALID;
        }

        internal static const SINGLETON_ENFORCER:Object={};

        public static const TIMER:com.garmin.fit.FITEvent=new FITEvent(SINGLETON_ENFORCER, 0);

        public static const WORKOUT:com.garmin.fit.FITEvent=new FITEvent(SINGLETON_ENFORCER, 3);

        public static const WORKOUT_STEP:com.garmin.fit.FITEvent=new FITEvent(SINGLETON_ENFORCER, 4);

        public static const POWER_DOWN:com.garmin.fit.FITEvent=new FITEvent(SINGLETON_ENFORCER, 5);

        public static const POWER_UP:com.garmin.fit.FITEvent=new FITEvent(SINGLETON_ENFORCER, 6);

        public static const OFF_COURSE:com.garmin.fit.FITEvent=new FITEvent(SINGLETON_ENFORCER, 7);

        public static const SESSION:com.garmin.fit.FITEvent=new FITEvent(SINGLETON_ENFORCER, 8);

        public static const LAP:com.garmin.fit.FITEvent=new FITEvent(SINGLETON_ENFORCER, 9);

        public static const COURSE_POINT:com.garmin.fit.FITEvent=new FITEvent(SINGLETON_ENFORCER, 10);

        public static const BATTERY:com.garmin.fit.FITEvent=new FITEvent(SINGLETON_ENFORCER, 11);

        public static const VIRTUAL_PARTNER_PACE:com.garmin.fit.FITEvent=new FITEvent(SINGLETON_ENFORCER, 12);

        public static const HR_HIGH_ALERT:com.garmin.fit.FITEvent=new FITEvent(SINGLETON_ENFORCER, 13);

        public static const HR_LOW_ALERT:com.garmin.fit.FITEvent=new FITEvent(SINGLETON_ENFORCER, 14);

        public static const CAD_HIGH_ALERT:com.garmin.fit.FITEvent=new FITEvent(SINGLETON_ENFORCER, 17);

        public static const CAD_LOW_ALERT:com.garmin.fit.FITEvent=new FITEvent(SINGLETON_ENFORCER, 18);

        public static const POWER_HIGH_ALERT:com.garmin.fit.FITEvent=new FITEvent(SINGLETON_ENFORCER, 19);

        public static const POWER_LOW_ALERT:com.garmin.fit.FITEvent=new FITEvent(SINGLETON_ENFORCER, 20);

        public static const RECOVERY_HR:com.garmin.fit.FITEvent=new FITEvent(SINGLETON_ENFORCER, 21);

        public static const BATTERY_LOW:com.garmin.fit.FITEvent=new FITEvent(SINGLETON_ENFORCER, 22);

        public static const TIME_DURATION_ALERT:com.garmin.fit.FITEvent=new FITEvent(SINGLETON_ENFORCER, 23);

        public static const DISTANCE_DURATION_ALERT:com.garmin.fit.FITEvent=new FITEvent(SINGLETON_ENFORCER, 24);

        public static const CALORIE_DURATION_ALERT:com.garmin.fit.FITEvent=new FITEvent(SINGLETON_ENFORCER, 25);

        public static const ACTIVITY:com.garmin.fit.FITEvent=new FITEvent(SINGLETON_ENFORCER, 26);

        public static const FITNESS_EQUIPMENT:com.garmin.fit.FITEvent=new FITEvent(SINGLETON_ENFORCER, 27);

        public static const LENGTH:com.garmin.fit.FITEvent=new FITEvent(SINGLETON_ENFORCER, 28);

        public static const INVALID:com.garmin.fit.FITEvent=new FITEvent(SINGLETON_ENFORCER, 255);

        public static const VALUES:__AS3__.vec.Vector.<com.garmin.fit.FITEvent>=new __AS3__.vec.Vector.<>(28);

        public static const SPEED_LOW_ALERT:com.garmin.fit.FITEvent=new FITEvent(SINGLETON_ENFORCER, 16);

        public static const SPEED_HIGH_ALERT:com.garmin.fit.FITEvent=new FITEvent(SINGLETON_ENFORCER, 15);

        internal var value:uint;
    }
}


