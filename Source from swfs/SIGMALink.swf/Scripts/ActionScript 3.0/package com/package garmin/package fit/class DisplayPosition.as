//class DisplayPosition
package com.garmin.fit 
{
    import __AS3__.vec.*;
    import avmplus.*;
    import com.garmin.fit.custom.*;
    import flash.errors.*;
    
    public class DisplayPosition extends com.garmin.fit.custom.BaseType
    {
        public function DisplayPosition(arg1:Object, arg2:uint)
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

        
        {
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[0] = DEGREE;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[1] = DEGREE_MINUTE;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[2] = DEGREE_MINUTE_SECOND;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[3] = AUSTRIAN_GRID;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[4] = BRITISH_GRID;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[5] = DUTCH_GRID;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[6] = HUNGARIAN_GRID;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[7] = FINNISH_GRID;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[8] = GERMAN_GRID;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[9] = ICELANDIC_GRID;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[10] = INDONESIAN_EQUATORIAL;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[11] = INDONESIAN_IRIAN;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[12] = INDONESIAN_SOUTHERN;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[13] = INDIA_ZONE_0;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[14] = INDIA_ZONE_IA;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[15] = INDIA_ZONE_IB;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[16] = INDIA_ZONE_IIA;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[17] = INDIA_ZONE_IIB;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[18] = INDIA_ZONE_IIIA;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[19] = INDIA_ZONE_IIIB;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[20] = INDIA_ZONE_IVA;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[21] = INDIA_ZONE_IVB;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[22] = IRISH_TRANSVERSE;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[23] = IRISH_GRID;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[24] = LORAN;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[25] = MAIDENHEAD_GRID;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[26] = MGRS_GRID;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[27] = NEW_ZEALAND_GRID;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[28] = NEW_ZEALAND_TRANSVERSE;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[29] = QATAR_GRID;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[30] = MODIFIED_SWEDISH_GRID;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[31] = SWEDISH_GRID;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[32] = SOUTH_AFRICAN_GRID;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[33] = SWISS_GRID;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[34] = TAIWAN_GRID;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[35] = UNITED_STATES_GRID;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[36] = UTM_UPS_GRID;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[37] = WEST_MALAYAN;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[38] = BORNEO_RSO;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[39] = ESTONIAN_GRID;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[40] = LATVIAN_GRID;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[41] = SWEDISH_REF_99_GRID;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43)[42] = INVALID;
        }

        public static function getByValue(arg1:uint):com.garmin.fit.DisplayPosition
        {
            return com.garmin.fit.custom.BaseType.getByValue(arg1) as DisplayPosition;
        }

        public static const DEGREE_MINUTE:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 1);

        public static const DEGREE_MINUTE_SECOND:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 2);

        public static const AUSTRIAN_GRID:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 3);

        public static const BRITISH_GRID:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 4);

        public static const DUTCH_GRID:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 5);

        public static const HUNGARIAN_GRID:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 6);

        public static const FINNISH_GRID:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 7);

        public static const GERMAN_GRID:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 8);

        public static const ICELANDIC_GRID:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 9);

        public static const INDONESIAN_EQUATORIAL:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 10);

        public static const INDONESIAN_IRIAN:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 11);

        public static const INDONESIAN_SOUTHERN:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 12);

        public static const INDIA_ZONE_0:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 13);

        public static const INDIA_ZONE_IA:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 14);

        public static const INDIA_ZONE_IB:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 15);

        public static const INDIA_ZONE_IIA:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 16);

        public static const INDIA_ZONE_IIB:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 17);

        public static const INDIA_ZONE_IIIA:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 18);

        public static const INDIA_ZONE_IIIB:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 19);

        public static const INDIA_ZONE_IVA:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 20);

        public static const INDIA_ZONE_IVB:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 21);

        public static const IRISH_TRANSVERSE:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 22);

        public static const IRISH_GRID:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 23);

        public static const LORAN:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 24);

        public static const MAIDENHEAD_GRID:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 25);

        public static const MGRS_GRID:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 26);

        public static const NEW_ZEALAND_GRID:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 27);

        public static const NEW_ZEALAND_TRANSVERSE:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 28);

        public static const QATAR_GRID:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 29);

        public static const MODIFIED_SWEDISH_GRID:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 30);

        public static const SWEDISH_GRID:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 31);

        public static const SOUTH_AFRICAN_GRID:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 32);

        internal static const SINGLETON_ENFORCER:Object={};

        public static const TAIWAN_GRID:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 34);

        public static const UNITED_STATES_GRID:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 35);

        public static const UTM_UPS_GRID:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 36);

        public static const WEST_MALAYAN:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 37);

        public static const BORNEO_RSO:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 38);

        public static const SWISS_GRID:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 33);

        public static const LATVIAN_GRID:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 40);

        public static const SWEDISH_REF_99_GRID:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 41);

        public static const INVALID:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 255);

        internal static const VALUES:__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>=new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(43);

        public static const DEGREE:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 0);

        public static const ESTONIAN_GRID:com.garmin.fit.DisplayPosition=new DisplayPosition(SINGLETON_ENFORCER, 39);
    }
}


