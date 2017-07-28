//class Gender
package com.garmin.fit 
{
    import __AS3__.vec.*;
    import avmplus.*;
    import flash.errors.*;
    
    public class Gender extends Object
    {
        public function Gender(arg1:Object, arg2:uint)
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

        public static function getByValue(arg1:uint):com.garmin.fit.Gender
        {
            var loc3:*=0;
            var loc2:*=Gender.VALUES;
            for each (var loc1:* in loc2) 
            {
                if (!(arg1 == loc1.value)) 
                {
                    continue;
                }
                return loc1;
            }
            return Gender.INVALID;
        }

        
        {
            new __AS3__.vec.Vector.<>(3)[0] = FEMALE;
            new __AS3__.vec.Vector.<>(3)[1] = MALE;
            new __AS3__.vec.Vector.<>(3)[2] = INVALID;
        }

        internal static const SINGLETON_ENFORCER:Object={};

        public static const FEMALE:com.garmin.fit.Gender=new Gender(SINGLETON_ENFORCER, 0);

        public static const MALE:com.garmin.fit.Gender=new Gender(SINGLETON_ENFORCER, 1);

        public static const INVALID:com.garmin.fit.Gender=new Gender(SINGLETON_ENFORCER, 255);

        public static const VALUES:__AS3__.vec.Vector.<com.garmin.fit.Gender>=new __AS3__.vec.Vector.<>(3);

        internal var value:uint;
    }
}


