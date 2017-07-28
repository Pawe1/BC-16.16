//class FieldDefinition
package com.garmin.fit 
{
    import flash.filesystem.*;
    
    public class FieldDefinition extends Object
    {
        public function FieldDefinition(arg1:com.garmin.fit.Field=null, arg2:int=255)
        {
            super();
            if (arg1 == null) 
            {
                _num = arg2;
                _size = 0;
            }
            else 
            {
                _num = arg1.num;
                _size = arg1.getSize();
                _type = arg1.type;
            }
            return;
        }

        public function set num(arg1:int):void
        {
            _num = arg1;
            return;
        }

        public function get num():int
        {
            return _num;
        }

        public function set size(arg1:int):void
        {
            _size = arg1;
            return;
        }

        public function get size():int
        {
            return _size;
        }

        public function set type(arg1:int):void
        {
            _type = arg1;
            return;
        }

        public function get type():int
        {
            return _type;
        }

        public function write(arg1:flash.filesystem.FileStream):void
        {
            arg1.writeByte(num);
            arg1.writeByte(size);
            arg1.writeByte(type);
            return;
        }

        public function getNum():int
        {
            return num;
        }

        public function setSize(arg1:int):void
        {
            _size = arg1;
            return;
        }

        public function getSize():int
        {
            return size;
        }

        public function getType():int
        {
            return type;
        }

        public function equals(arg1:*):Boolean
        {
            if (this == arg1) 
            {
                return true;
            }
            if (!(arg1 is com.garmin.fit.FieldDefinition)) 
            {
                return false;
            }
            var loc1:*=com.garmin.fit.FieldDefinition(arg1);
            if (num != loc1.num) 
            {
                return false;
            }
            if (size != loc1.size) 
            {
                return false;
            }
            if (type != loc1.type) 
            {
                return false;
            }
            return true;
        }

        public function hashCode():int
        {
            var loc1:*=1;
            loc1 = loc1 * 47 + this.num;
            loc1 = loc1 * 31 + this.size;
            loc1 = loc1 * 19 + this.type;
            return loc1;
        }

        internal var _num:int;

        internal var _size:int;

        internal var _type:int;
    }
}


