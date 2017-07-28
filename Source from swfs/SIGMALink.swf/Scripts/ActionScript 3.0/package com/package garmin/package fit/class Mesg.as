//class Mesg
package com.garmin.fit 
{
    import __AS3__.vec.*;
    import flash.filesystem.*;
    import flash.utils.*;
    
    public class Mesg extends flash.utils.Dictionary
    {
        public function Mesg(arg1:*=null, arg2:int=0)
        {
            var loc3:*=null;
            var loc2:*=undefined;
            super();
            this.fields = new __AS3__.vec.Vector.<com.garmin.fit.Field>(0);
            if (arg1 == null) 
            {
                this.name = "unknown";
                this.num = 65535;
                this.systemTimeOffset = 0;
                return;
            }
            if (arg1 is com.garmin.fit.Mesg) 
            {
                loc3 = arg1;
                this.name = loc3.name;
                this.num = loc3.num;
                this.localNum = loc3.localNum;
                this.systemTimeOffset = loc3.systemTimeOffset;
                loc2 = loc3.fields;
                var loc1:*=loc3.fields.length;
                z = 0;
                while (z < loc1) 
                {
                    if (loc2[z].getNumValues() > 0) 
                    {
                        this.fields.push(new com.garmin.fit.Field(loc2[z]));
                    }
                    ++z;
                }
            }
            else if (arg1 is String) 
            {
                this.name = arg1 as String;
                this.num = arg2;
                this.localNum = 0;
                this.fields = new __AS3__.vec.Vector.<com.garmin.fit.Field>(0);
                this.systemTimeOffset = 0;
            }
            return;
        }

        public function write(arg1:flash.filesystem.FileStream, arg2:com.garmin.fit.MesgDefinition):void
        {
            var loc2:*=null;
            var loc1:*=null;
            arg1.writeByte(localNum & 15);
            if (arg2 == null) 
            {
                arg2 = new com.garmin.fit.MesgDefinition(this);
            }
            var loc5:*=0;
            var loc4:*=arg2.fieldsDic;
            for (var loc3:* in loc4) 
            {
                loc2 = arg2.fieldsDic[loc3];
                loc1 = this.getField(loc2.num);
                if (loc1 == null) 
                {
                    loc1 = com.garmin.fit.Factory.createField(num, loc2.num);
                }
                loc1.write(arg1, loc2);
            }
            return;
        }

        public function getName():String
        {
            return name;
        }

        public function getNum():int
        {
            return num;
        }

        public function hasField(arg1:int):Boolean
        {
            var loc1:*=0;
            loc1 = 0;
            while (loc1 < fields.length) 
            {
                if (fields[loc1].num == arg1) 
                {
                    return true;
                }
                ++loc1;
            }
            return false;
        }

        public function addField(arg1:com.garmin.fit.Field):void
        {
            fields.push(arg1);
            return;
        }

        public function setField(arg1:com.garmin.fit.Field):void
        {
            var loc1:*=0;
            loc1 = 0;
            while (loc1 < fields.length) 
            {
                if (fields[loc1].num == arg1.num) 
                {
                    fields[loc1] = arg1;
                    return;
                }
                ++loc1;
            }
            fields.push(arg1);
            return;
        }

        public function setFields(arg1:com.garmin.fit.Mesg):void
        {
            if (arg1.num != num) 
            {
                return;
            }
            var loc3:*=0;
            var loc2:*=arg1.fields;
            for each (var loc1:* in loc2) 
            {
                setField(loc1);
            }
            return;
        }

        public function getNumFields():int
        {
            return fields.length;
        }

        public function getField(arg1:*, arg2:Boolean=true):com.garmin.fit.Field
        {
            var loc1:*=0;
            var loc2:*=null;
            var loc4:*=0;
            var loc3:*=0;
            if (arg1 is int) 
            {
                loc1 = arg1 as int;
                loc3 = 0;
                while (loc3 < fields.length) 
                {
                    if (fields[loc3].num == loc1) 
                    {
                        return fields[loc3];
                    }
                    ++loc3;
                }
            }
            else if (arg1 is String) 
            {
                loc2 = arg1 as String;
                loc3 = 0;
                while (loc3 < fields.length) 
                {
                    if (fields[loc3].name == loc2) 
                    {
                        return fields[loc3];
                    }
                    loc4 = 0;
                    while (loc4 < fields[loc3].subFields.length) 
                    {
                        if (fields[loc3].subFields[loc4].name == loc2 && (!arg2 || fields[loc3].subFields[loc4].canMesgSupport(this))) 
                        {
                            return fields[loc3];
                        }
                        ++loc4;
                    }
                    ++loc3;
                }
            }
            return null;
        }

        public function GetActiveSubFieldIndex(arg1:int):int
        {
            var loc1:*=0;
            var loc2:*=com.garmin.fit.Factory.createField(this.num, arg1);
            if (loc2 == null) 
            {
                return 65535;
            }
            loc1 = 0;
            while (loc1 < loc2.subFields.length) 
            {
                if (loc2.subFields[loc1].canMesgSupport(this)) 
                {
                    return loc1;
                }
                ++loc1;
            }
            return 65535;
        }

        public function GetActiveSubFieldName(arg1:int):String
        {
            var loc1:*=0;
            var loc2:*=com.garmin.fit.Factory.createField(this.num, arg1);
            if (loc2 == null) 
            {
                return com.garmin.fit.Fit.SUBFIELD_NAME_MAIN_FIELD;
            }
            loc1 = 0;
            while (loc1 < loc2.subFields.length) 
            {
                if (loc2.subFields[loc1].canMesgSupport(this)) 
                {
                    return loc2.subFields[loc1].name;
                }
                ++loc1;
            }
            return com.garmin.fit.Fit.SUBFIELD_NAME_MAIN_FIELD;
        }

        public function getNumFieldValues(arg1:*, arg2:*):int
        {
            var loc1:*=null;
            var loc3:*=null;
            var loc2:*=0;
            var loc4:*=null;
            if (arg1) 
            {
                loc1 = getField(arg1);
            }
            else 
            {
                loc1 = getField(name, false);
            }
            if (loc1 == null) 
            {
                return 0;
            }
            if (arg2 is int) 
            {
                if ((loc2 = arg2 as int) == 65534) 
                {
                    return loc1.getNumValues();
                }
                loc3 = loc1.getSubField(loc2);
            }
            else if (arg2 is String) 
            {
                loc4 = arg2 as String;
                loc3 = loc1.getSubField(loc4);
            }
            if (loc3 == null || loc3.canMesgSupport(this)) 
            {
                return loc1.getNumValues();
            }
            return 0;
        }

        public function getFieldValue(arg1:*, arg2:int=-2147483648, arg3:*=null):*
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc6:*=null;
            var loc5:*=null;
            var loc3:*=null;
            var loc4:*=0;
            if (arg1 is int && !(arg2 == -2147483648) && arg3 is String) 
            {
                loc2 = arg1 as int;
                loc6 = arg3 as String;
                if ((loc1 = getField(loc2)) == null) 
                {
                    return null;
                }
                if ((loc5 = loc1.getSubField(loc6)) == null || loc5.canMesgSupport(this)) 
                {
                    return loc1.getValue(arg2, loc6);
                }
                return null;
            }
            if (arg1 is String && arg2 == -2147483648 && arg3 == null) 
            {
                return getFieldValue(loc3, 0);
            }
            if (arg1 is String && !(arg2 == -2147483648) && arg3 == null) 
            {
                loc3 = arg1 as String;
                if ((loc1 = getField(loc3, false)) == null) 
                {
                    return null;
                }
                if ((loc5 = loc1.getSubField(loc3)) == null || loc5.canMesgSupport(this)) 
                {
                    return loc1.getValue(arg2, loc3);
                }
                return null;
            }
            loc2 = arg1 as int;
            if (arg1 is int && arg2 == -2147483648 && arg3 == null) 
            {
                arg2 = 0;
                loc4 = 65534;
            }
            else if (arg1 is int && !(arg2 == -2147483648) && arg3 == null) 
            {
                loc4 = 65534;
            }
            else if (!(arg1 is int && !(arg2 == -2147483648) && !(arg3 == null))) 
            {
                throw new com.garmin.fit.FitRuntimeException("loggingErrorEvent", 1800001, "FITEncoding > Logical Error: Mesg.getFieldValue " + loc3);
            }
            if ((loc1 = getField(loc2)) == null) 
            {
                return null;
            }
            if (loc4 == 65534) 
            {
                return loc1.getValue(arg2, GetActiveSubFieldIndex(loc2));
            }
            if ((loc5 = loc1.getSubField(loc4)) == null || loc5.canMesgSupport(this)) 
            {
                return loc1.getValue(arg2, loc4);
            }
            return null;
        }

        public function setFieldValue(arg1:int, arg2:int, arg3:Object, arg4:int):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=0;
            var loc7:*=null;
            var loc5:*=null;
            var loc6:*=null;
            if (arg3 is String && !(arg3 == null)) 
            {
                loc2 = arg3 as String;
                if ((arg3 as String).length > 63) 
                {
                    (loc3 = new flash.utils.ByteArray()).writeMultiByte(loc2, "utf-8");
                    if (loc3.length > 254) 
                    {
                        loc3.clear();
                        loc4 = 0;
                        while (loc3.position < 252) 
                        {
                            loc3.writeMultiByte(loc2.charAt(loc4++), "utf-8");
                        }
                        loc7 = loc2.slice(0, loc4 - 2) + "...";
                        loc3.clear();
                        loc3.position = 0;
                        loc3.writeMultiByte(loc7, "utf-8");
                        arg3 = loc7;
                    }
                }
            }
            if (arg4 != 65534) 
            {
                if (!((loc6 = (loc5 = com.garmin.fit.Factory.createField(this.num, arg1)).getSubField(arg4)) == null) && !loc6.canMesgSupport(this)) 
                {
                    return;
                }
            }
            else 
            {
                arg4 = GetActiveSubFieldIndex(arg1);
            }
            var loc1:*;
            if ((loc1 = getField(arg1)) == null) 
            {
                loc1 = com.garmin.fit.Factory.createField(this.num, arg1);
                addField(loc1);
            }
            loc1.setValue(arg2, arg3, arg4);
            return;
        }

        public function getFieldIntegerValue(arg1:int, arg2:int, arg3:int):int
        {
            var loc2:*=null;
            var loc1:*;
            if ((loc1 = getField(arg1)) == null) 
            {
                return -2147483648;
            }
            if (arg3 == 65534) 
            {
                return loc1.getIntegerValue(arg2, GetActiveSubFieldIndex(arg1));
            }
            if ((loc2 = loc1.getSubField(arg3)) == null || loc2.canMesgSupport(this)) 
            {
                return loc1.getIntegerValue(arg2, arg3);
            }
            return -2147483648;
        }

        public function getFieldDoubleValue(arg1:int, arg2:int=0, arg3:int=65534):Number
        {
            var loc2:*=null;
            var loc1:*;
            if ((loc1 = getField(arg1)) == null) 
            {
                return NaN;
            }
            if (arg3 == 65534) 
            {
                return loc1.getFloatValue(arg2, GetActiveSubFieldIndex(arg1));
            }
            if ((loc2 = loc1.getSubField(arg3)) == null || loc2.canMesgSupport(this)) 
            {
                return loc1.getFloatValue(arg2, arg3);
            }
            return NaN;
        }

        public function getFieldStringValue(arg1:int, arg2:int, arg3:int):String
        {
            var loc2:*=null;
            var loc1:*;
            if ((loc1 = getField(arg1)) == null) 
            {
                return null;
            }
            if (arg3 == 65534) 
            {
                return loc1.getStringValue(arg2, GetActiveSubFieldIndex(arg1));
            }
            if ((loc2 = loc1.getSubField(arg3)) == null || loc2.canMesgSupport(this)) 
            {
                return loc1.getStringValue(arg2, arg3);
            }
            return null;
        }

        public function getFields():__AS3__.vec.Vector.<com.garmin.fit.Field>
        {
            return fields;
        }

        public function timestampToDateTime(arg1:Number):com.garmin.fit.DateTime
        {
            var loc1:*=null;
            if (!arg1) 
            {
                return null;
            }
            loc1 = new com.garmin.fit.DateTime(null);
            loc1.setTimeStamp(arg1);
            loc1.convertSystemTimeToUTC(systemTimeOffset);
            return loc1;
        }

        public function setLocalNum(arg1:int):void
        {
            if (arg1 >= 16) 
            {
                throw new com.garmin.fit.FitRuntimeException("Invalid local message number " + arg1 + ".  Local message number must be < " + 16 + ".");
            }
            this.localNum = arg1;
            return;
        }

        public function getLocalNum():int
        {
            return localNum;
        }

        public var name:String;

        public var num:int;

        public var localNum:int;

        public var fields:__AS3__.vec.Vector.<com.garmin.fit.Field>;

        public var systemTimeOffset:Number;

        internal var z:uint;
    }
}


