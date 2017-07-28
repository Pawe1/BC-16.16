//class SubSport
package com.garmin.fit 
{
    import __AS3__.vec.*;
    import avmplus.*;
    import com.garmin.fit.custom.*;
    import flash.errors.*;
    
    public class SubSport extends com.garmin.fit.custom.BaseType
    {
        public function SubSport(arg1:Object, arg2:uint)
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

        public static function getByValue(arg1:uint):com.garmin.fit.SubSport
        {
            return com.garmin.fit.custom.BaseType.getByValue(arg1) as SubSport;
        }

        
        {
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(23)[0] = GENERIC;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(23)[1] = TREADMILL;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(23)[2] = STREET;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(23)[3] = TRAIL;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(23)[4] = TRACK;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(23)[5] = SPIN;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(23)[6] = INDOOR_CYCLING;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(23)[7] = ROAD;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(23)[8] = MOUNTAIN;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(23)[9] = DOWNHILL;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(23)[10] = RECUMBENT;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(23)[11] = CYCLOCROSS;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(23)[12] = HAND_CYCLING;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(23)[13] = TRACK_CYCLING;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(23)[14] = INDOOR_ROWING;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(23)[15] = ELLIPTICAL;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(23)[16] = STAIR_CLIMBING;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(23)[17] = LAP_SWIMMING;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(23)[18] = OPEN_WATER;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(23)[19] = FLEXIBILITY_TRAINING;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(23)[20] = STRENGTH_TRAINING;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(23)[21] = ALL;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(23)[22] = INVALID;
        }

        internal static const SINGLETON_ENFORCER:Object={};

        public static const GENERIC:com.garmin.fit.SubSport=new SubSport(SINGLETON_ENFORCER, 0);

        public static const TREADMILL:com.garmin.fit.SubSport=new SubSport(SINGLETON_ENFORCER, 1);

        public static const STREET:com.garmin.fit.SubSport=new SubSport(SINGLETON_ENFORCER, 2);

        public static const TRAIL:com.garmin.fit.SubSport=new SubSport(SINGLETON_ENFORCER, 3);

        public static const TRACK:com.garmin.fit.SubSport=new SubSport(SINGLETON_ENFORCER, 4);

        public static const SPIN:com.garmin.fit.SubSport=new SubSport(SINGLETON_ENFORCER, 5);

        public static const INDOOR_CYCLING:com.garmin.fit.SubSport=new SubSport(SINGLETON_ENFORCER, 6);

        public static const ROAD:com.garmin.fit.SubSport=new SubSport(SINGLETON_ENFORCER, 7);

        public static const MOUNTAIN:com.garmin.fit.SubSport=new SubSport(SINGLETON_ENFORCER, 8);

        public static const DOWNHILL:com.garmin.fit.SubSport=new SubSport(SINGLETON_ENFORCER, 9);

        public static const RECUMBENT:com.garmin.fit.SubSport=new SubSport(SINGLETON_ENFORCER, 10);

        public static const CYCLOCROSS:com.garmin.fit.SubSport=new SubSport(SINGLETON_ENFORCER, 11);

        public static const HAND_CYCLING:com.garmin.fit.SubSport=new SubSport(SINGLETON_ENFORCER, 12);

        public static const TRACK_CYCLING:com.garmin.fit.SubSport=new SubSport(SINGLETON_ENFORCER, 13);

        public static const INDOOR_ROWING:com.garmin.fit.SubSport=new SubSport(SINGLETON_ENFORCER, 14);

        public static const ELLIPTICAL:com.garmin.fit.SubSport=new SubSport(SINGLETON_ENFORCER, 15);

        public static const STAIR_CLIMBING:com.garmin.fit.SubSport=new SubSport(SINGLETON_ENFORCER, 16);

        public static const LAP_SWIMMING:com.garmin.fit.SubSport=new SubSport(SINGLETON_ENFORCER, 17);

        public static const OPEN_WATER:com.garmin.fit.SubSport=new SubSport(SINGLETON_ENFORCER, 18);

        public static const FLEXIBILITY_TRAINING:com.garmin.fit.SubSport=new SubSport(SINGLETON_ENFORCER, 19);

        public static const STRENGTH_TRAINING:com.garmin.fit.SubSport=new SubSport(SINGLETON_ENFORCER, 20);

        public static const ALL:com.garmin.fit.SubSport=new SubSport(SINGLETON_ENFORCER, 254);

        public static const INVALID:com.garmin.fit.SubSport=new SubSport(SINGLETON_ENFORCER, 255);

        internal static const VALUES:__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>=new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(23);
    }
}


