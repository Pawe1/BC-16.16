//class FitnessEquipmentState
package com.garmin.fit 
{
    import __AS3__.vec.*;
    import avmplus.*;
    import com.garmin.fit.custom.*;
    import flash.errors.*;
    
    public class FitnessEquipmentState extends com.garmin.fit.custom.BaseType
    {
        public function FitnessEquipmentState(arg1:Object, arg2:uint)
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

        public static function getByValue(arg1:uint):com.garmin.fit.FitnessEquipmentState
        {
            return com.garmin.fit.custom.BaseType.getByValue(arg1) as FitnessEquipmentState;
        }

        
        {
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(5)[0] = READY;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(5)[1] = IN_USE;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(5)[2] = PAUSED;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(5)[3] = UNKNOWN;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(5)[4] = INVALID;
        }

        internal static const SINGLETON_ENFORCER:Object={};

        public static const READY:com.garmin.fit.FitnessEquipmentState=new FitnessEquipmentState(SINGLETON_ENFORCER, 0);

        public static const IN_USE:com.garmin.fit.FitnessEquipmentState=new FitnessEquipmentState(SINGLETON_ENFORCER, 1);

        public static const PAUSED:com.garmin.fit.FitnessEquipmentState=new FitnessEquipmentState(SINGLETON_ENFORCER, 2);

        public static const UNKNOWN:com.garmin.fit.FitnessEquipmentState=new FitnessEquipmentState(SINGLETON_ENFORCER, 3);

        public static const INVALID:com.garmin.fit.FitnessEquipmentState=new FitnessEquipmentState(SINGLETON_ENFORCER, 255);

        internal static const VALUES:__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>=new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(5);
    }
}


