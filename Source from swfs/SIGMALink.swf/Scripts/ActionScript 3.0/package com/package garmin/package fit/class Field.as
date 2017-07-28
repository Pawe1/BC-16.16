//class Field
package com.garmin.fit 
{
    import __AS3__.vec.*;
    import flash.events.*;
    import flash.filesystem.*;
    import flash.utils.*;
    
    public class Field extends flash.events.EventDispatcher
    {
        public function Field(arg1:*=null, arg2:int=0, arg3:int=0, arg4:Number=NaN, arg5:Number=NaN, arg6:String=null)
        {
            var loc4:*=0;
            var loc2:*=null;
            super();
            if (arg1 == null) 
            {
                this.name = "unknown";
                this.num = 255;
                this.type = 0;
                this.scale = 1;
                this.offset = 0;
                this.units = "";
                this.values = new __AS3__.vec.Vector.<Object>(0);
                this.components = new __AS3__.vec.Vector.<com.garmin.fit.FieldComponent>(0);
                this.subFields = new __AS3__.vec.Vector.<com.garmin.fit.SubField>(0);
                return;
            }
            if (arg1 is com.garmin.fit.Field) 
            {
                loc2 = arg1 as com.garmin.fit.Field;
                var loc3:*;
                var loc1:*=(loc3 = (arg1 as com.garmin.fit.Field).values).length;
                this.name = new String(loc2.name);
                this.num = loc2.num;
                this.type = loc2.type;
                this.scale = loc2.scale;
                this.offset = loc2.offset;
                this.units = new String(loc2.units);
                this.values = new __AS3__.vec.Vector.<Object>(0);
                loc4 = 0;
                while (loc4 < loc1) 
                {
                    this.values.push(loc3[loc4]);
                    ++loc4;
                }
                this.components = loc2.components;
                this.subFields = loc2.subFields;
            }
            else if (arg1 is String) 
            {
                this.name = arg1 as String;
                this.num = arg2;
                this.type = arg3;
                this.scale = arg4;
                this.offset = arg5;
                this.units = arg6;
                this.values = new __AS3__.vec.Vector.<Object>(0);
                this.components = new __AS3__.vec.Vector.<com.garmin.fit.FieldComponent>(0);
                this.subFields = new __AS3__.vec.Vector.<com.garmin.fit.SubField>(0);
            }
            return;
        }

        public function getFloatValue(arg1:int, arg2:*):Number
        {
            var loc2:*=null;
            var loc1:*=0;
            if (arg2 is String) 
            {
                loc2 = arg2 as String;
                return getFloatValueInternal(arg1, getSubField(loc2));
            }
            if (arg2 is int) 
            {
                loc1 = arg2 as int;
                return getFloatValueInternal(arg1, getSubField(loc1));
            }
            throw new com.garmin.fit.FitRuntimeException("loggingErrorEvent", 1800001, "FITEncoding > Logical Error: Field.getFloatValue: " + name);
        }

        internal function getFloatValueInternal(arg1:int, arg2:com.garmin.fit.SubField):Number
        {
            var loc1:*=getValueInternal(arg1, arg2);
            if (loc1 == null) 
            {
                return NaN;
            }
            return loc1 as Number;
        }

        public function getDoubleValue(arg1:*=null, arg2:*=null):Number
        {
            var loc3:*=null;
            var loc2:*=0;
            if (arg2 == null) 
            {
                return getDoubleValueInternal(0, null);
            }
            var loc1:*=arg1 as int;
            if (arg2 is String) 
            {
                loc3 = arg2 as String;
                return getDoubleValueInternal(loc1, getSubField(loc3));
            }
            if (arg2 is int) 
            {
                loc2 = arg2 as int;
                return getDoubleValueInternal(loc1, getSubField(loc2));
            }
            throw new com.garmin.fit.FitRuntimeException("loggingErrorEvent", 1800001, "FITEncoding > Logical Error: Field.getDoubleValue: " + name);
        }

        internal function getDoubleValueInternal(arg1:int, arg2:com.garmin.fit.SubField):Number
        {
            var loc1:*=getValueInternal(arg1, arg2);
            if (!loc1) 
            {
                return NaN;
            }
            return loc1;
        }

        public function getStringValue(arg1:int, arg2:*):String
        {
            var loc2:*=null;
            var loc1:*=0;
            if (arg2 is String) 
            {
                loc2 = arg2 as String;
                return getStringValueInternal(arg1, getSubField(loc2));
            }
            if (arg2 is int) 
            {
                loc1 = arg2 as int;
                return getStringValueInternal(arg1, getSubField(loc1));
            }
            throw new com.garmin.fit.FitRuntimeException("loggingErrorEvent", 1800001, "FITEncoding > Logical Error: Field.getStringValue " + name);
        }

        public function getNum():int
        {
            return num;
        }

        internal function getStringValueInternal(arg1:int, arg2:com.garmin.fit.SubField):String
        {
            var loc1:*=getValueInternal(arg1, arg2);
            if (loc1 == null) 
            {
                return null;
            }
            var loc2:*=type;
            while (0 === loc2) 
            {
                if (loc1 == 255) 
                {
                    return null;
                }
            }
        }

        public function read(arg1:__AS3__.vec.Vector.<int>, arg2:int):Boolean
        {
            var loc2:*=null;
            var loc11:*=null;
            var loc3:*=0;
            var loc7:*=0;
            var loc8:*=false;
            var loc4:*=0;
            var loc10:*=0;
            var loc6:*=NaN;
            var loc5:*=null;
            var loc9:*=null;
            var loc1:*=NaN;
            arg1.fixed = false;
        }

        public function write(arg1:flash.filesystem.FileStream, arg2:com.garmin.fit.FieldDefinition=null):void
        {
            var loc3:*=0;
            var loc2:*=0;
            if (arg2 != null) 
            {
                loc2 = arg2.size - getSize();
                write(arg1);
                while (loc2 > 0) 
                {
                    writeValue(arg1, null);
                    loc2 = loc2 - com.garmin.fit.Fit.baseTypeSizes[type & 31];
                }
            }
            else 
            {
                var loc1:*=values.length;
                loc3 = 0;
                while (loc3 < loc1) 
                {
                    writeValue(arg1, values[loc3]);
                    ++loc3;
                }
            }
            return;
        }

        public function getName(arg1:*=null):String
        {
            var loc2:*=null;
            var loc1:*=0;
            if (arg1 == null) 
            {
                return getNameInternal(null);
            }
            if (arg1 is String) 
            {
                loc2 = arg1 as String;
                return getNameInternal(getSubField(loc2));
            }
            if (arg1 is int) 
            {
                loc1 = arg1 as int;
                return getNameInternal(getSubField(loc1));
            }
            throw new com.garmin.fit.FitRuntimeException("loggingErrorEvent", 1800001, "FITEncoding > Logical Error: Field.getName: " + name);
            return null;
        }

        internal function getNameInternal(arg1:com.garmin.fit.SubField):String
        {
            if (arg1 == null) 
            {
                return name;
            }
            return arg1.name;
        }

        internal function writeValue(arg1:flash.filesystem.FileStream, arg2:Object):void
        {
        }

        public function getType():int
        {
            return getTypeInternal(null);
        }

        public function getTypeBySubFieldIndex(arg1:int):int
        {
            return getTypeInternal(getSubField(arg1));
        }

        public function getTypeBySubFieldName(arg1:String):int
        {
            return getTypeInternal(getSubField(arg1));
        }

        internal function getTypeInternal(arg1:com.garmin.fit.SubField):int
        {
            if (arg1 == null) 
            {
                return type;
            }
            return arg1.type;
        }

        public function getUnits(arg1:*=null):String
        {
            if (arg1 == null) 
            {
                return getUnitsInternal(null);
            }
            if (arg1 is int) 
            {
                return getUnitsInternal(getSubField(arg1));
            }
            if (arg1 is String) 
            {
                return getUnitsInternal(getSubField(arg1));
            }
            throw new com.garmin.fit.FitRuntimeException("loggingErrorEvent", 1800001, "FITEncoding > Logical Error: Field.getUnits: " + name);
            return "";
        }

        internal function getUnitsInternal(arg1:com.garmin.fit.SubField):String
        {
            if (arg1 == null) 
            {
                return units;
            }
            return arg1.units;
        }

        public function getSize():int
        {
            var loc4:*=0;
            var loc2:*=0;
            var loc3:*=null;
            var loc1:*=0;
            var loc7:*=type;
            while (0 === loc7) 
            {
                loc1 = getNumValues() * com.garmin.fit.Fit.baseTypeSizes[type & 31];
            }
        }

        public function getSubField(arg1:*):com.garmin.fit.SubField
        {
            var loc3:*=null;
            var loc1:*=0;
            var loc2:*=0;
            if (arg1 is String) 
            {
                loc3 = arg1 as String;
                loc1 = 0;
                while (loc1 < subFields.length) 
                {
                    if (subFields[loc1].name == loc3) 
                    {
                        return subFields[loc1];
                    }
                    ++loc1;
                }
            }
            else if (arg1 is int) 
            {
                loc2 = arg1 as int;
                if (loc2 >= 0 && loc2 < subFields.length) 
                {
                    return subFields[loc2];
                }
            }
            return null;
        }

        public function isSignedInteger():Boolean
        {
            return isSignedIntegerInternal(null);
        }

        internal function isSignedIntegerInternal(arg1:com.garmin.fit.SubField):Boolean
        {
            var loc1:*=getTypeInternal(arg1);
            while (1 === loc1) 
            {
                return true;
            }
        }

        public function addValue(arg1:*):void
        {
            var loc2:*=null;
            var loc1:*=NaN;
            if (arg1 is Number && type == 7) 
            {
                loc2 = getStringValueInternal(0, null);
                loc1 = arg1;
                if (loc2 == null) 
                {
                    loc2 = "";
                }
                loc2 = loc2 + ("" + (loc1 as int));
                setValueInternal(0, loc2, null);
                return;
            }
            values.push(arg1);
            return;
        }

        public function getNumValues():int
        {
            return values.length;
        }

        public function getValue(arg1:*=null, arg2:*=null):*
        {
            if (arg1 == null && arg2 == null) 
            {
                return getValueInternal(0, null);
            }
            if (arg1 == undefined && arg2 is int) 
            {
                return getValueInternal(arg1, getSubField(arg2 as int));
            }
            if (arg1 == undefined && arg2 is String) 
            {
                return getValueInternal(arg1, getSubField(arg2 as String));
            }
            throw new com.garmin.fit.FitRuntimeException("loggingErrorEvent", 1800001, "FITEncoding > Logical Error: Field.getValue: " + name);
            return null;
        }

        internal function getValueInternal(arg1:int, arg2:com.garmin.fit.SubField):*
        {
            var loc3:*=undefined;
            var loc2:*=NaN;
            var loc1:*=NaN;
            if (arg1 >= values.length) 
            {
                return null;
            }
            if (arg2 != null) 
            {
                loc2 = arg2.scale;
                loc1 = arg2.offset;
            }
            else 
            {
                loc2 = this.scale;
                loc1 = this.offset;
            }
        }

        public function setValue(arg1:*, arg2:Object=null, arg3:*=null):void
        {
            var loc1:*=0;
            var loc2:*=null;
            if (arg2 == null && arg3 == null) 
            {
                setValueInternal(0, arg2, null);
            }
            else if (arg3 is int) 
            {
                loc1 = arg3 as int;
                setValueInternal(arg1, arg2, getSubField(loc1));
            }
            else if (arg3 is String) 
            {
                loc2 = arg3 as String;
                setValueInternal(arg1, arg2, getSubField(loc2));
            }
            else 
            {
                throw new com.garmin.fit.FitRuntimeException("loggingErrorEvent", 1800001, "FITEncoding > Logical Error: Field.setValue: " + name);
            }
            return;
        }

        internal function setValueInternal(arg1:int, arg2:*, arg3:com.garmin.fit.SubField):void
        {
            var loc3:*=NaN;
            var loc1:*=NaN;
            var loc2:*=NaN;
            while (arg1 >= getNumValues()) 
            {
                addValue({});
            }
            if (arg3 != null) 
            {
                loc3 = arg3.scale;
                loc1 = arg3.offset;
            }
            else 
            {
                loc3 = this.scale;
                loc1 = this.offset;
            }
        }

        public function getBitsValue(arg1:int, arg2:int, arg3:Boolean):Number
        {
            var loc1:*=0;
            var loc2:*=NaN;
            var loc7:*=NaN;
            var loc3:*=NaN;
            var loc6:*=0;
            var loc5:*=0;
            var loc4:*=0;
            while (loc5 < arg2) 
            {
                ++loc4;
                loc2 = getLongValueInternal(loc4, null);
                if (isNaN(loc2)) 
                {
                    return NaN;
                }
                loc2 = loc2 >> arg1;
                loc1 = com.garmin.fit.Fit.baseTypeSizes[type & 31] * 8 - arg1;
                arg1 = arg1 - com.garmin.fit.Fit.baseTypeSizes[type & 31] * 8;
                if (!(loc1 > 0)) 
                {
                    continue;
                }
                arg1 = 0;
                if (loc1 > arg2 - loc5) 
                {
                    loc1 = arg2 - loc5;
                }
                loc7 = ((1 as Number) << loc1 - 1);
                loc6 = loc6 | (loc2 & loc7) << loc5;
                loc5 = loc5 + loc1;
            }
            if (arg3) 
            {
                loc3 = (1 as Number) << (arg2 - 1);
                if ((loc6 & loc3) != 0) 
                {
                    loc6 = -loc3 + (loc6 & (loc3 - 1));
                }
            }
            return loc6;
        }

        public function getByteValue():int
        {
            return getByteValueInternal(0, null);
        }

        public function getByteValueByFieldArrayIndex(arg1:int):int
        {
            return getByteValueInternal(arg1, null);
        }

        public function getByteValueByFieldArrayIndexAndSubFieldIndex(arg1:int, arg2:int):int
        {
            return getByteValueInternal(arg1, getSubField(arg2));
        }

        public function getByteValueByFieldArrayIndexAndSubFieldName(arg1:int, arg2:String):int
        {
            return getByteValueInternal(arg1, getSubField(arg2));
        }

        internal function getByteValueInternal(arg1:int, arg2:com.garmin.fit.SubField):int
        {
            var loc1:*=getValueInternal(arg1, arg2);
            if (loc1 == null) 
            {
                return 0;
            }
            return loc1 as int;
        }

        public function getShortValue(arg1:int=0, arg2:*=null):int
        {
            return getShortValueInternal(arg1, getSubField(arg2));
        }

        internal function getShortValueInternal(arg1:int, arg2:com.garmin.fit.SubField):int
        {
            var loc1:*=getValueInternal(arg1, arg2);
            if (loc1 == null) 
            {
                return 0;
            }
            return loc1 as int;
        }

        public function getIntegerValue(arg1:int, arg2:*):int
        {
            var loc2:*=null;
            var loc1:*=0;
            if (arg2 is String) 
            {
                loc2 = arg2 as String;
                return getIntegerValueInternal(arg1, getSubField(loc2));
            }
            if (arg2 is int) 
            {
                loc1 = arg2 as int;
                return getIntegerValueInternal(arg1, getSubField(loc1));
            }
            throw new com.garmin.fit.FitRuntimeException("loggingErrorEvent", 1800001, "FITEncoding > Logical Error: Field.getIntegerValue: " + name);
        }

        internal function getIntegerValueInternal(arg1:int, arg2:com.garmin.fit.SubField):int
        {
            var loc1:*=getValueInternal(arg1, arg2);
            if (loc1 == null) 
            {
                return 0;
            }
            return loc1 as int;
        }

        public function getLongValue(arg1:int, arg2:int):Number
        {
            return getLongValueInternal(arg1, getSubField(arg2));
        }

        internal function getLongValueInternal(arg1:int, arg2:com.garmin.fit.SubField):Number
        {
            var loc1:*=getValueInternal(arg1, arg2);
            if (loc1 == null) 
            {
                return NaN;
            }
            return loc1 as Number;
        }

        public var name:String;

        public var num:int;

        public var type:int;

        public var scale:Number;

        public var offset:Number;

        public var values:__AS3__.vec.Vector.<Object>;

        public var components:__AS3__.vec.Vector.<com.garmin.fit.FieldComponent>;

        public var subFields:__AS3__.vec.Vector.<com.garmin.fit.SubField>;

        protected var units:String;
    }
}


