//class FITFile
package com.garmin.fit 
{
    import __AS3__.vec.*;
    import avmplus.*;
    import flash.errors.*;
    
    public class FITFile extends Object
    {
        public function FITFile(arg1:Object, arg2:uint)
        {
            super();
            if (arg1 != SINGLETON_ENFORCER) 
            {
                throw new flash.errors.IllegalOperationError("IllegalOperation: Manipulation of type " + avmplus.getQualifiedClassName(this));
            }
            this.value = arg2;
            return;
        }

        public function getValue():Number
        {
            return value;
        }

        public static function getByValue(arg1:uint):com.garmin.fit.FITFile
        {
            var loc3:*=0;
            var loc2:*=FITFile.VALUES;
            for each (var loc1:* in loc2) 
            {
                if (!(arg1 == loc1.value)) 
                {
                    continue;
                }
                return loc1;
            }
            return FITFile.INVALID;
        }

        
        {
            new __AS3__.vec.Vector.<>(15)[0] = DEVICE;
            new __AS3__.vec.Vector.<>(15)[1] = SETTINGS;
            new __AS3__.vec.Vector.<>(15)[2] = SPORT;
            new __AS3__.vec.Vector.<>(15)[3] = ACTIVITY;
            new __AS3__.vec.Vector.<>(15)[4] = WORKOUT;
            new __AS3__.vec.Vector.<>(15)[5] = COURSE;
            new __AS3__.vec.Vector.<>(15)[6] = SCHEDULES;
            new __AS3__.vec.Vector.<>(15)[7] = WEIGHT;
            new __AS3__.vec.Vector.<>(15)[8] = TOTALS;
            new __AS3__.vec.Vector.<>(15)[9] = GOALS;
            new __AS3__.vec.Vector.<>(15)[10] = BLOOD_PRESSURE;
            new __AS3__.vec.Vector.<>(15)[11] = MONITORING;
            new __AS3__.vec.Vector.<>(15)[12] = ACTIVITY_SUMMARY;
            new __AS3__.vec.Vector.<>(15)[13] = MONITORING_DAILY;
            new __AS3__.vec.Vector.<>(15)[14] = INVALID;
        }

        internal static const SINGLETON_ENFORCER:Object={};

        public static const DEVICE:com.garmin.fit.FITFile=new FITFile(SINGLETON_ENFORCER, 1);

        public static const SETTINGS:com.garmin.fit.FITFile=new FITFile(SINGLETON_ENFORCER, 2);

        public static const SPORT:com.garmin.fit.FITFile=new FITFile(SINGLETON_ENFORCER, 3);

        public static const ACTIVITY:com.garmin.fit.FITFile=new FITFile(SINGLETON_ENFORCER, 4);

        public static const WORKOUT:com.garmin.fit.FITFile=new FITFile(SINGLETON_ENFORCER, 5);

        public static const COURSE:com.garmin.fit.FITFile=new FITFile(SINGLETON_ENFORCER, 6);

        public static const SCHEDULES:com.garmin.fit.FITFile=new FITFile(SINGLETON_ENFORCER, 7);

        public static const WEIGHT:com.garmin.fit.FITFile=new FITFile(SINGLETON_ENFORCER, 9);

        public static const TOTALS:com.garmin.fit.FITFile=new FITFile(SINGLETON_ENFORCER, 10);

        public static const GOALS:com.garmin.fit.FITFile=new FITFile(SINGLETON_ENFORCER, 11);

        public static const BLOOD_PRESSURE:com.garmin.fit.FITFile=new FITFile(SINGLETON_ENFORCER, 14);

        public static const MONITORING:com.garmin.fit.FITFile=new FITFile(SINGLETON_ENFORCER, 15);

        public static const ACTIVITY_SUMMARY:com.garmin.fit.FITFile=new FITFile(SINGLETON_ENFORCER, 20);

        public static const MONITORING_DAILY:com.garmin.fit.FITFile=new FITFile(SINGLETON_ENFORCER, 28);

        public static const INVALID:com.garmin.fit.FITFile=new FITFile(SINGLETON_ENFORCER, 255);

        public static const VALUES:__AS3__.vec.Vector.<com.garmin.fit.FITFile>=new __AS3__.vec.Vector.<>(15);

        internal var value:uint;
    }
}


