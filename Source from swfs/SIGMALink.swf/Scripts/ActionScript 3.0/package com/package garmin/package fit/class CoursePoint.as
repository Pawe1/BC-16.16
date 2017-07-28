//class CoursePoint
package com.garmin.fit 
{
    import __AS3__.vec.*;
    import avmplus.*;
    import com.garmin.fit.custom.*;
    import flash.errors.*;
    
    public class CoursePoint extends com.garmin.fit.custom.BaseType
    {
        public function CoursePoint(arg1:Object, arg2:uint)
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

        public static function getByValue(arg1:uint):com.garmin.fit.CoursePoint
        {
            return com.garmin.fit.custom.BaseType.getByValue(arg1) as CoursePoint;
        }

        
        {
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(20)[0] = GENERIC;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(20)[1] = SUMMIT;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(20)[2] = VALLEY;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(20)[3] = WATER;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(20)[4] = FOOD;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(20)[5] = DANGER;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(20)[6] = LEFT;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(20)[7] = RIGHT;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(20)[8] = STRAIGHT;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(20)[9] = FIRST_AID;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(20)[10] = FOURTH_CATEGORY;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(20)[11] = THIRD_CATEGORY;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(20)[12] = SECOND_CATEGORY;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(20)[13] = FIRST_CATEGORY;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(20)[14] = HORS_CATEGORY;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(20)[15] = SPRINT;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(20)[16] = LEFT_FORK;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(20)[17] = RIGHT_FORK;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(20)[18] = MIDDLE_FORK;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(20)[19] = INVALID;
        }

        internal static const SINGLETON_ENFORCER:Object={};

        public static const GENERIC:com.garmin.fit.CoursePoint=new CoursePoint(SINGLETON_ENFORCER, 0);

        public static const SUMMIT:com.garmin.fit.CoursePoint=new CoursePoint(SINGLETON_ENFORCER, 1);

        public static const VALLEY:com.garmin.fit.CoursePoint=new CoursePoint(SINGLETON_ENFORCER, 2);

        public static const WATER:com.garmin.fit.CoursePoint=new CoursePoint(SINGLETON_ENFORCER, 3);

        public static const FOOD:com.garmin.fit.CoursePoint=new CoursePoint(SINGLETON_ENFORCER, 4);

        public static const DANGER:com.garmin.fit.CoursePoint=new CoursePoint(SINGLETON_ENFORCER, 5);

        public static const LEFT:com.garmin.fit.CoursePoint=new CoursePoint(SINGLETON_ENFORCER, 6);

        public static const RIGHT:com.garmin.fit.CoursePoint=new CoursePoint(SINGLETON_ENFORCER, 7);

        public static const STRAIGHT:com.garmin.fit.CoursePoint=new CoursePoint(SINGLETON_ENFORCER, 8);

        public static const FIRST_AID:com.garmin.fit.CoursePoint=new CoursePoint(SINGLETON_ENFORCER, 9);

        public static const FOURTH_CATEGORY:com.garmin.fit.CoursePoint=new CoursePoint(SINGLETON_ENFORCER, 10);

        public static const THIRD_CATEGORY:com.garmin.fit.CoursePoint=new CoursePoint(SINGLETON_ENFORCER, 11);

        public static const SECOND_CATEGORY:com.garmin.fit.CoursePoint=new CoursePoint(SINGLETON_ENFORCER, 12);

        public static const FIRST_CATEGORY:com.garmin.fit.CoursePoint=new CoursePoint(SINGLETON_ENFORCER, 13);

        public static const HORS_CATEGORY:com.garmin.fit.CoursePoint=new CoursePoint(SINGLETON_ENFORCER, 14);

        public static const SPRINT:com.garmin.fit.CoursePoint=new CoursePoint(SINGLETON_ENFORCER, 15);

        public static const LEFT_FORK:com.garmin.fit.CoursePoint=new CoursePoint(SINGLETON_ENFORCER, 16);

        public static const RIGHT_FORK:com.garmin.fit.CoursePoint=new CoursePoint(SINGLETON_ENFORCER, 17);

        public static const MIDDLE_FORK:com.garmin.fit.CoursePoint=new CoursePoint(SINGLETON_ENFORCER, 18);

        public static const INVALID:com.garmin.fit.CoursePoint=new CoursePoint(SINGLETON_ENFORCER, 255);

        internal static const VALUES:__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>=new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(20);
    }
}


