//class MesgCount
package com.garmin.fit 
{
    import __AS3__.vec.*;
    import avmplus.*;
    import com.garmin.fit.custom.*;
    import flash.errors.*;
    
    public class MesgCount extends com.garmin.fit.custom.BaseType
    {
        public function MesgCount(arg1:Object, arg2:uint)
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

        public static function getByValue(arg1:uint):com.garmin.fit.MesgCount
        {
            return com.garmin.fit.custom.BaseType.getByValue(arg1) as MesgCount;
        }

        
        {
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(4)[0] = NUM_PER_FILE;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(4)[1] = MAX_PER_FILE;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(4)[2] = MAX_PER_FILE_TYPE;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(4)[3] = INVALID;
        }

        internal static const SINGLETON_ENFORCER:Object={};

        public static const NUM_PER_FILE:com.garmin.fit.MesgCount=new MesgCount(SINGLETON_ENFORCER, 0);

        public static const MAX_PER_FILE:com.garmin.fit.MesgCount=new MesgCount(SINGLETON_ENFORCER, 1);

        public static const MAX_PER_FILE_TYPE:com.garmin.fit.MesgCount=new MesgCount(SINGLETON_ENFORCER, 2);

        public static const INVALID:com.garmin.fit.MesgCount=new MesgCount(SINGLETON_ENFORCER, 255);

        internal static const VALUES:__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>=new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(4);
    }
}


