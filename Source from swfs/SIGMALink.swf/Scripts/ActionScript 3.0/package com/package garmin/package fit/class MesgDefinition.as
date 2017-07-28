//class MesgDefinition
package com.garmin.fit 
{
    import __AS3__.vec.*;
    import flash.filesystem.*;
    import flash.utils.*;
    
    public class MesgDefinition extends Object
    {
        public function MesgDefinition(arg1:com.garmin.fit.Mesg=null)
        {
            var loc1:*=null;
            var loc2:*=undefined;
            super();
            if (arg1 != null) 
            {
                num = arg1.num;
                localNum = arg1.localNum;
            }
            else 
            {
                num = 65535;
                localNum = 0;
            }
            arch = 1;
            if (localNum >= 16) 
            {
                throw new com.garmin.fit.FitRuntimeException("Invalid local message number " + localNum + ".  Local message number must be < " + 16 + ".");
            }
            fieldsDic = new flash.utils.Dictionary();
            if (arg1 != null) 
            {
                loc2 = arg1.fields;
                fieldsLength = loc2.length;
                z = 0;
                while (z < fieldsLength) 
                {
                    loc1 = loc2[z];
                    fieldsDic[loc1.num] = new com.garmin.fit.FieldDefinition(loc1);
                    ++z;
                }
            }
            return;
        }

        public function getNum():int
        {
            return num;
        }

        public function getLocalNum():int
        {
            return localNum;
        }

        public function getArch():int
        {
            return arch;
        }

        public function getField(arg1:int):com.garmin.fit.FieldDefinition
        {
            return fieldsDic[arg1];
        }

        public function addField(arg1:com.garmin.fit.FieldDefinition):void
        {
            fieldsDic[fieldsLength] = arg1;
            ++fieldsLength;
            return;
        }

        public function write(arg1:flash.filesystem.FileStream):void
        {
            arg1.writeByte(64 | localNum & 15);
            arg1.writeByte(0);
            arg1.writeByte(1);
            arg1.writeByte(num >> 8);
            arg1.writeByte(num);
            arg1.writeByte(fieldsLength);
            var loc3:*=0;
            var loc2:*=fieldsDic;
            for each (var loc1:* in loc2) 
            {
                loc1.write(arg1);
            }
            return;
        }

        public function supports(arg1:com.garmin.fit.Mesg):Boolean
        {
            var loc1:*=null;
            var loc3:*=null;
            var loc2:*=null;
            var loc4:*;
            if ((loc4 = new com.garmin.fit.MesgDefinition(arg1)) == null) 
            {
                return false;
            }
            if (num != loc4.num) 
            {
                return false;
            }
            if (localNum != loc4.localNum) 
            {
                return false;
            }
            var loc7:*=0;
            var loc6:*=loc1;
            for (var loc5:* in loc6) 
            {
                loc3 = loc1[loc5];
                loc2 = getField(loc3.num);
                if (loc2 == null) 
                {
                    return false;
                }
                if (!(loc3.size > loc2.size)) 
                {
                    continue;
                }
                return false;
            }
            return true;
        }

        public function equals(arg1:*):Boolean
        {
            if (this == arg1) 
            {
                return true;
            }
            if (!(arg1 is com.garmin.fit.MesgDefinition)) 
            {
                return false;
            }
            var loc1:*=com.garmin.fit.MesgDefinition(arg1);
            if (num != loc1.num) 
            {
                return false;
            }
            if (localNum != loc1.localNum) 
            {
                return false;
            }
            if (fieldsLength != loc1.fieldsLength) 
            {
                return false;
            }
            var loc2:*=loc1.fieldsDic;
            var loc5:*=0;
            var loc4:*=fieldsDic;
            for (var loc3:* in loc4) 
            {
                if (!(fieldsDic[loc3] == loc2[loc3])) 
                {
                    continue;
                }
                return false;
            }
            return true;
        }

        public function get fieldsDic():flash.utils.Dictionary
        {
            return _fieldsDic;
        }

        public function set fieldsDic(arg1:flash.utils.Dictionary):void
        {
            _fieldsDic = arg1;
            return;
        }

        internal static const FIELD_DEFINITION_NUM:String="FIELD_NUM";

        public var num:int;

        public var localNum:int;

        public var arch:int;

        internal var _fieldsDic:flash.utils.Dictionary;

        public var fieldsLength:uint;

        internal var z:uint;
    }
}


