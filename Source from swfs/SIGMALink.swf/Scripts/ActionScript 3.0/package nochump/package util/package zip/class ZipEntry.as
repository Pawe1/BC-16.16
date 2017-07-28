//class ZipEntry
package nochump.util.zip 
{
    import flash.utils.*;
    
    public class ZipEntry extends Object
    {
        public function ZipEntry(arg1:String)
        {
            super();
            _name = arg1;
            return;
        }

        public function get name():String
        {
            return _name;
        }

        public function get time():Number
        {
            var loc1:*=new Date((dostime >> 25 & 127) + 1980, (dostime >> 21 & 15 - 1), dostime >> 16 & 31, dostime >> 11 & 31, dostime >> 5 & 63, (dostime & 31) << 1);
            return loc1.time;
        }

        public function set time(arg1:Number):void
        {
            var loc1:*=new Date(arg1);
            dostime = (loc1.fullYear - 1980 & 127) << 25 | loc1.month + 1 << 21 | loc1.day << 16 | loc1.hours << 11 | loc1.minutes << 5 | loc1.seconds >> 1;
            return;
        }

        public function get size():int
        {
            return _size;
        }

        public function set size(arg1:int):void
        {
            _size = arg1;
            return;
        }

        public function get compressedSize():int
        {
            return _compressedSize;
        }

        public function set compressedSize(arg1:int):void
        {
            _compressedSize = arg1;
            return;
        }

        public function get crc():uint
        {
            return _crc;
        }

        public function set crc(arg1:uint):void
        {
            _crc = arg1;
            return;
        }

        public function get method():int
        {
            return _method;
        }

        public function set method(arg1:int):void
        {
            _method = arg1;
            return;
        }

        public function get extra():flash.utils.ByteArray
        {
            return _extra;
        }

        public function set extra(arg1:flash.utils.ByteArray):void
        {
            _extra = arg1;
            return;
        }

        public function get comment():String
        {
            return _comment;
        }

        public function set comment(arg1:String):void
        {
            _comment = arg1;
            return;
        }

        public function isDirectory():Boolean
        {
            return _name.charAt((_name.length - 1)) == "/";
        }

        public function toString():String
        {
            return _name;
        }

        internal var _name:String;

        internal var _size:int=-1;

        internal var _compressedSize:int=-1;

        internal var _crc:uint;

        var dostime:uint;

        internal var _method:int=-1;

        internal var _extra:flash.utils.ByteArray;

        internal var _comment:String;

        var flag:int;

        var version:int;

        var offset:int;
    }
}


