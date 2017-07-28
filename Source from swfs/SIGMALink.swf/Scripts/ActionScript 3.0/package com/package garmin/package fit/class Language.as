//class Language
package com.garmin.fit 
{
    import __AS3__.vec.*;
    import avmplus.*;
    import com.garmin.fit.custom.*;
    import flash.errors.*;
    
    public class Language extends com.garmin.fit.custom.BaseType
    {
        public function Language(arg1:Object, arg2:uint)
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
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(28)[0] = ENGLISH;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(28)[1] = FRENCH;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(28)[2] = ITALIAN;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(28)[3] = GERMAN;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(28)[4] = SPANISH;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(28)[5] = CROATIAN;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(28)[6] = CZECH;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(28)[7] = DANISH;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(28)[8] = DUTCH;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(28)[9] = FINNISH;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(28)[10] = GREEK;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(28)[11] = HUNGARIAN;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(28)[12] = NORWEGIAN;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(28)[13] = POLISH;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(28)[14] = PORTUGUESE;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(28)[15] = SLOVAKIAN;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(28)[16] = SLOVENIAN;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(28)[17] = SWEDISH;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(28)[18] = RUSSIAN;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(28)[19] = TURKISH;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(28)[20] = LATVIAN;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(28)[21] = UKRAINIAN;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(28)[22] = ARABIC;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(28)[23] = FARSI;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(28)[24] = BULGARIAN;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(28)[25] = ROMANIAN;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(28)[26] = CUSTOM;
            new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(28)[27] = INVALID;
        }

        public static function getByValue(arg1:uint):com.garmin.fit.Language
        {
            return com.garmin.fit.custom.BaseType.getByValue(arg1) as Language;
        }

        internal static const SINGLETON_ENFORCER:Object={};

        public static const ENGLISH:com.garmin.fit.Language=new Language(SINGLETON_ENFORCER, 0);

        public static const FRENCH:com.garmin.fit.Language=new Language(SINGLETON_ENFORCER, 1);

        public static const ITALIAN:com.garmin.fit.Language=new Language(SINGLETON_ENFORCER, 2);

        public static const GERMAN:com.garmin.fit.Language=new Language(SINGLETON_ENFORCER, 3);

        public static const SPANISH:com.garmin.fit.Language=new Language(SINGLETON_ENFORCER, 4);

        public static const CROATIAN:com.garmin.fit.Language=new Language(SINGLETON_ENFORCER, 5);

        public static const CZECH:com.garmin.fit.Language=new Language(SINGLETON_ENFORCER, 6);

        public static const DANISH:com.garmin.fit.Language=new Language(SINGLETON_ENFORCER, 7);

        public static const DUTCH:com.garmin.fit.Language=new Language(SINGLETON_ENFORCER, 8);

        public static const FINNISH:com.garmin.fit.Language=new Language(SINGLETON_ENFORCER, 9);

        public static const GREEK:com.garmin.fit.Language=new Language(SINGLETON_ENFORCER, 10);

        public static const HUNGARIAN:com.garmin.fit.Language=new Language(SINGLETON_ENFORCER, 11);

        public static const NORWEGIAN:com.garmin.fit.Language=new Language(SINGLETON_ENFORCER, 12);

        public static const SLOVAKIAN:com.garmin.fit.Language=new Language(SINGLETON_ENFORCER, 15);

        public static const SLOVENIAN:com.garmin.fit.Language=new Language(SINGLETON_ENFORCER, 16);

        public static const SWEDISH:com.garmin.fit.Language=new Language(SINGLETON_ENFORCER, 17);

        public static const RUSSIAN:com.garmin.fit.Language=new Language(SINGLETON_ENFORCER, 18);

        public static const TURKISH:com.garmin.fit.Language=new Language(SINGLETON_ENFORCER, 19);

        public static const LATVIAN:com.garmin.fit.Language=new Language(SINGLETON_ENFORCER, 20);

        public static const UKRAINIAN:com.garmin.fit.Language=new Language(SINGLETON_ENFORCER, 21);

        public static const ARABIC:com.garmin.fit.Language=new Language(SINGLETON_ENFORCER, 22);

        public static const FARSI:com.garmin.fit.Language=new Language(SINGLETON_ENFORCER, 23);

        public static const BULGARIAN:com.garmin.fit.Language=new Language(SINGLETON_ENFORCER, 24);

        public static const ROMANIAN:com.garmin.fit.Language=new Language(SINGLETON_ENFORCER, 25);

        public static const CUSTOM:com.garmin.fit.Language=new Language(SINGLETON_ENFORCER, 254);

        public static const INVALID:com.garmin.fit.Language=new Language(SINGLETON_ENFORCER, 255);

        internal static const VALUES:__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>=new __AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>(28);

        public static const PORTUGUESE:com.garmin.fit.Language=new Language(SINGLETON_ENFORCER, 14);

        public static const POLISH:com.garmin.fit.Language=new Language(SINGLETON_ENFORCER, 13);
    }
}


