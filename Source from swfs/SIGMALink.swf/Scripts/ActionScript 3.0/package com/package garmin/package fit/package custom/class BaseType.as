//class BaseType
package com.garmin.fit.custom 
{
    import __AS3__.vec.*;
    
    public class BaseType extends Object
    {
        public function BaseType()
        {
            super();
            return;
        }

        public function getByValue():uint
        {
            return null;
        }

        public static function getByValue(arg1:uint):com.garmin.fit.custom.BaseType
        {
            var loc3:*=0;
            var loc2:*=getAllValues();
            for each (var loc1:* in loc2) 
            {
                if (!(arg1 == loc1.getByValue())) 
                {
                    continue;
                }
                return loc1;
            }
            return getInvalid();
        }

        public static function getAllValues():__AS3__.vec.Vector.<com.garmin.fit.custom.BaseType>
        {
            return null;
        }

        public static function getInvalid():com.garmin.fit.custom.BaseType
        {
            return null;
        }

        protected var value:uint;
    }
}


