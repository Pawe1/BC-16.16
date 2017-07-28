//class ZipOutput
package nochump.util.zip 
{
    import flash.utils.*;
    
    public class ZipOutput extends Object
    {
        public function ZipOutput()
        {
            _entries = [];
            _names = new flash.utils.Dictionary();
            _def = new nochump.util.zip.Deflater();
            _crc = new nochump.util.zip.CRC32();
            _buf = new flash.utils.ByteArray();
            super();
            _buf.endian = "littleEndian";
            return;
        }

        public function get size():uint
        {
            return _entries.length;
        }

        public function get byteArray():flash.utils.ByteArray
        {
            _buf.position = 0;
            return _buf;
        }

        public function set comment(arg1:String):void
        {
            _comment = arg1;
            return;
        }

        public function putNextEntry(arg1:nochump.util.zip.ZipEntry):void
        {
            if (_entry != null) 
            {
                closeEntry();
            }
            if (arg1.dostime == 0) 
            {
                arg1.time = new Date().time;
            }
            if (arg1.method == -1) 
            {
                arg1.method = 8;
            }
        }

        public function write(arg1:flash.utils.ByteArray):void
        {
            var loc1:*=null;
            if (_entry == null) 
            {
                throw new nochump.util.zip.ZipError("no current ZIP entry");
            }
        }

        public function closeEntry():void
        {
            var loc1:*=_entry;
            if (loc1 == null) 
            {
            };
            return;
        }

        public function finish():void
        {
            var loc1:*=0;
            if (_entry != null) 
            {
                closeEntry();
            }
            if (_entries.length < 1) 
            {
                throw new nochump.util.zip.ZipError("ZIP file must have at least one entry");
            }
            var loc2:*=_buf.position;
            loc1 = 0;
            while (loc1 < _entries.length) 
            {
                writeCEN(_entries[loc1]);
                ++loc1;
            }
            writeEND(loc2, _buf.position - loc2);
            return;
        }

        internal function writeLOC(arg1:nochump.util.zip.ZipEntry):void
        {
            _buf.writeUnsignedInt(67324752);
            _buf.writeShort(arg1.version);
            _buf.writeShort(arg1.flag);
            _buf.writeShort(arg1.method);
            _buf.writeUnsignedInt(arg1.dostime);
            if ((arg1.flag & 8) != 8) 
            {
                _buf.writeUnsignedInt(arg1.crc);
                _buf.writeUnsignedInt(arg1.compressedSize);
                _buf.writeUnsignedInt(arg1.size);
            }
            else 
            {
                _buf.writeUnsignedInt(0);
                _buf.writeUnsignedInt(0);
                _buf.writeUnsignedInt(0);
            }
            _buf.writeShort(arg1.name.length);
            _buf.writeShort(arg1.extra == null ? 0 : arg1.extra.length);
            _buf.writeUTFBytes(arg1.name);
            if (arg1.extra != null) 
            {
                _buf.writeBytes(arg1.extra);
            }
            return;
        }

        internal function writeEXT(arg1:nochump.util.zip.ZipEntry):void
        {
            _buf.writeUnsignedInt(134695760);
            _buf.writeUnsignedInt(arg1.crc);
            _buf.writeUnsignedInt(arg1.compressedSize);
            _buf.writeUnsignedInt(arg1.size);
            return;
        }

        internal function writeCEN(arg1:nochump.util.zip.ZipEntry):void
        {
            _buf.writeUnsignedInt(33639248);
            _buf.writeShort(arg1.version);
            _buf.writeShort(arg1.version);
            _buf.writeShort(arg1.flag);
            _buf.writeShort(arg1.method);
            _buf.writeUnsignedInt(arg1.dostime);
            _buf.writeUnsignedInt(arg1.crc);
            _buf.writeUnsignedInt(arg1.compressedSize);
            _buf.writeUnsignedInt(arg1.size);
            _buf.writeShort(arg1.name.length);
            _buf.writeShort(arg1.extra == null ? 0 : arg1.extra.length);
            _buf.writeShort(arg1.comment == null ? 0 : arg1.comment.length);
            _buf.writeShort(0);
            _buf.writeShort(0);
            _buf.writeUnsignedInt(0);
            _buf.writeUnsignedInt(arg1.offset);
            _buf.writeUTFBytes(arg1.name);
            if (arg1.extra != null) 
            {
                _buf.writeBytes(arg1.extra);
            }
            if (arg1.comment != null) 
            {
                _buf.writeUTFBytes(arg1.comment);
            }
            return;
        }

        internal function writeEND(arg1:uint, arg2:uint):void
        {
            _buf.writeUnsignedInt(101010256);
            _buf.writeShort(0);
            _buf.writeShort(0);
            _buf.writeShort(_entries.length);
            _buf.writeShort(_entries.length);
            _buf.writeUnsignedInt(arg2);
            _buf.writeUnsignedInt(arg1);
            _buf.writeUTF(_comment);
            return;
        }

        internal var _entry:nochump.util.zip.ZipEntry;

        internal var _entries:Array;

        internal var _names:flash.utils.Dictionary;

        internal var _def:nochump.util.zip.Deflater;

        internal var _crc:nochump.util.zip.CRC32;

        internal var _buf:flash.utils.ByteArray;

        internal var _comment:String="";
    }
}


