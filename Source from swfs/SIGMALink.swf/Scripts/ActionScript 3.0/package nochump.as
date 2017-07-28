//package nochump
//  package util
//    package zip
//      class CRC32
package nochump.util.zip 
{
    import flash.utils.*;
    
    public class CRC32 extends Object
    {
        public function CRC32()
        {
            super();
            return;
        }

        public function getValue():uint
        {
            return crc & 4294967295;
        }

        public function reset():void
        {
            crc = 0;
            return;
        }

        public function update(arg1:flash.utils.ByteArray):void
        {
            var loc3:*=0;
            var loc2:*=arg1.length;
            var loc1:*=~crc;
            while (--loc2 >= 0) 
            {
                loc1 = crcTable[(loc1 ^ arg1[loc3++]) & 255] ^ loc1 >>> 8;
            }
            crc = ~loc1;
            return;
        }

        internal static function makeCrcTable():Array
        {
            var loc4:*=0;
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=new Array(256);
            loc4 = 0;
            while (loc4 < 256) 
            {
                loc1 = loc4;
                loc2 = 8;
                for (;;) 
                {
                    --loc2;
                    if (!(loc2 >= 0)) 
                    {
                        break;
                    }
                    if ((loc1 & 1) != 0) 
                    {
                        loc1 = 3988292384 ^ loc1 >>> 1;
                        continue;
                    }
                    loc1 = loc1 >>> 1;
                }
                loc3[loc4] = loc1;
                ++loc4;
            }
            return loc3;
        }

        
        {
            crcTable = makeCrcTable();
        }

        internal var crc:uint;

        internal static var crcTable:Array;
    }
}


//      class Deflater
package nochump.util.zip 
{
    import flash.utils.*;
    
    public class Deflater extends Object
    {
        public function Deflater()
        {
            super();
            reset();
            return;
        }

        public function reset():void
        {
            buf = new flash.utils.ByteArray();
            compressed = false;
            totalOut = totalIn = 0;
            return;
        }

        public function setInput(arg1:flash.utils.ByteArray):void
        {
            buf.writeBytes(arg1);
            totalIn = buf.length;
            return;
        }

        public function deflate(arg1:flash.utils.ByteArray):uint
        {
            if (!compressed) 
            {
                buf.compress();
                compressed = true;
            }
            arg1.writeBytes(buf, 2, buf.length - 6);
            totalOut = arg1.length;
            return 0;
        }

        public function getBytesRead():uint
        {
            return totalIn;
        }

        public function getBytesWritten():uint
        {
            return totalOut;
        }

        internal var buf:flash.utils.ByteArray;

        internal var compressed:Boolean;

        internal var totalIn:uint;

        internal var totalOut:uint;
    }
}


//      class Inflater
package nochump.util.zip 
{
    import flash.utils.*;
    
    public class Inflater extends Object
    {
        public function Inflater()
        {
            super();
            return;
        }

        public function setInput(arg1:flash.utils.ByteArray):void
        {
            inbuf = arg1;
            inbuf.endian = "littleEndian";
            return;
        }

        public function inflate(arg1:flash.utils.ByteArray):uint
        {
            var loc2:*=0;
            var loc3:*=0;
            incnt = bitbuf = bitcnt = 0;
            var loc1:*=0;
            loc2 = bits(1);
            if ((loc3 = bits(2)) != 0) 
            {
                if (loc3 == 3) 
                {
                    throw new Error("invalid block type (type == 3)", -1);
                }
                lencode = {"count":[], "symbol":[]};
                distcode = {"count":[], "symbol":[]};
                if (loc3 != 1) 
                {
                    if (loc3 == 2) 
                    {
                        loc1 = constructDynamicTables();
                    }
                }
                else 
                {
                    constructFixedTables();
                }
                if (loc1 != 0) 
                {
                    return loc1;
                }
                loc1 = codes(arg1);
            }
            else 
            {
                stored(arg1);
            }
        }

        internal function bits(arg1:int):int
        {
            var loc1:*=bitbuf;
            while (bitcnt < arg1) 
            {
                if (incnt == inbuf.length) 
                {
                    throw new Error("available inflate data did not terminate", 2);
                }
                incnt = (incnt + 1);
                loc1 = loc1 | inbuf[incnt] << bitcnt;
                bitcnt = bitcnt + 8;
            }
            bitbuf = loc1 >> arg1;
            bitcnt = bitcnt - arg1;
            return loc1 & (1 << arg1 - 1);
        }

        internal function construct(arg1:Object, arg2:Array, arg3:int):int
        {
            var loc3:*=0;
            var loc2:*=0;
            var loc1:*=[];
            loc3 = 0;
            while (loc3 <= 15) 
            {
                arg1.count[loc3] = 0;
                ++loc3;
            }
            loc2 = 0;
            while (loc2 < arg3) 
            {
                var loc5:*;
                var loc6:*;
                var loc7:*=((loc5 = arg1.count)[loc6 = arg2[loc2]] + 1);
                loc5[loc6] = loc7;
                ++loc2;
            }
            if (arg1.count[0] == arg3) 
            {
                return 0;
            }
            var loc4:*=1;
            loc3 = 1;
            while (loc3 <= 15) 
            {
                if ((loc4 = (loc4 = loc4 << 1) - arg1.count[loc3]) < 0) 
                {
                    return loc4;
                }
                ++loc3;
            }
            loc1[1] = 0;
            loc3 = 1;
            while (loc3 < 15) 
            {
                loc1[loc3 + 1] = loc1[loc3] + arg1.count[loc3];
                ++loc3;
            }
            loc2 = 0;
            while (loc2 < arg3) 
            {
                if (arg2[loc2] != 0) 
                {
                    loc7 = ((loc5 = loc1)[loc6 = arg2[loc2]] + 1);
                    loc5[loc6] = loc7;
                    arg1.symbol[(loc5 = loc1)[loc6 = arg2[loc2]]] = loc2;
                }
                ++loc2;
            }
            return loc4;
        }

        internal function decode(arg1:Object):int
        {
            var loc2:*=0;
            var loc3:*=0;
            var loc1:*=0;
            var loc5:*=0;
            var loc4:*=0;
            loc2 = 1;
            while (loc2 <= 15) 
            {
                loc1 = loc1 | bits(1);
                loc3 = arg1.count[loc2];
                if (loc1 < loc5 + loc3) 
                {
                    return arg1.symbol[loc4 + (loc1 - loc5)];
                }
                loc4 = loc4 + loc3;
                loc5 = (loc5 = loc5 + loc3) << 1;
                loc1 = loc1 << 1;
                ++loc2;
            }
            return -9;
        }

        internal function codes(arg1:flash.utils.ByteArray):int
        {
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=0;
            loc1 = decode(lencode);
            if (loc1 < 0) 
            {
                return loc1;
            }
            if (loc1 < 256) 
            {
                arg1[arg1.length] = loc1;
            }
            else if (loc1 > 256) 
            {
                loc1 = loc1 - 257;
                if (loc1 >= 29) 
                {
                    throw new Error("invalid literal/length or distance code in fixed or dynamic block", -9);
                }
                loc2 = LENS[loc1] + bits(LEXT[loc1]);
                loc1 = decode(distcode);
                if (loc1 < 0) 
                {
                    return loc1;
                }
                if ((loc3 = DISTS[loc1] + bits(DEXT[loc1])) > arg1.length) 
                {
                    throw new Error("distance is too far back in fixed or dynamic block", -10);
                }
                for (;;) 
                {
                    --loc2;
                    if (!loc2) 
                    {
                        break;
                    }
                    arg1[arg1.length] = arg1[arg1.length - loc3];
                }
            }
        }

        internal function stored(arg1:flash.utils.ByteArray):void
        {
            bitbuf = 0;
            bitcnt = 0;
            if (incnt + 4 > inbuf.length) 
            {
                throw new Error("available inflate data did not terminate", 2);
            }
            incnt = (incnt + 1);
            var loc1:*=inbuf[incnt];
            incnt = (incnt + 1);
            loc1 = loc1 | inbuf[incnt] << 8;
            incnt = (incnt + 1);
            if (!!(inbuf[incnt] == (~loc1 & 255))) 
            {
                !(inbuf[incnt] == (~loc1 & 255));
                incnt = (incnt + 1);
            }
            if (!(inbuf[incnt] == (~loc1 & 255))) 
            {
                throw new Error("stored block length did not match one\'s complement", -2);
            }
            if (incnt + loc1 > inbuf.length) 
            {
                throw new Error("available inflate data did not terminate", 2);
            }
            while (loc1--) 
            {
                incnt = (incnt + 1);
                arg1[arg1.length] = inbuf[incnt];
            }
            return;
        }

        internal function constructFixedTables():void
        {
            var loc1:*=0;
            var loc2:*=[];
            loc1 = 0;
            while (loc1 < 144) 
            {
                loc2[loc1] = 8;
                ++loc1;
            }
            while (loc1 < 256) 
            {
                loc2[loc1] = 9;
                ++loc1;
            }
            while (loc1 < 280) 
            {
                loc2[loc1] = 7;
                ++loc1;
            }
            while (loc1 < 288) 
            {
                loc2[loc1] = 8;
                ++loc1;
            }
            construct(lencode, loc2, 288);
            loc1 = 0;
            while (loc1 < 30) 
            {
                loc2[loc1] = 5;
                ++loc1;
            }
            construct(distcode, loc2, 30);
            return;
        }

        internal function constructDynamicTables():int
        {
            var loc8:*=0;
            var loc1:*=0;
            var loc5:*=0;
            var loc2:*=[];
            var loc9:*=[16, 17, 18, 0, 8, 7, 9, 6, 10, 5, 11, 4, 12, 3, 13, 2, 14, 1, 15];
            var loc3:*=bits(5) + 257;
            var loc7:*=bits(5) + 1;
            var loc6:*=bits(4) + 4;
            if (loc3 > 286 || loc7 > 30) 
            {
                throw new Error("dynamic block code description: too many length or distance codes", -3);
            }
            loc8 = 0;
            while (loc8 < loc6) 
            {
                loc2[loc9[loc8]] = bits(3);
                ++loc8;
            }
            while (loc8 < 19) 
            {
                loc2[loc9[loc8]] = 0;
                ++loc8;
            }
            var loc4:*;
            if ((loc4 = construct(lencode, loc2, 19)) != 0) 
            {
                throw new Error("dynamic block code description: code lengths codes incomplete", -4);
            }
            loc8 = 0;
            while (loc8 < loc3 + loc7) 
            {
                loc1 = decode(lencode);
                if (loc1 < 16) 
                {
                    ++loc8;
                    loc2[loc8] = loc1;
                    continue;
                }
                loc5 = 0;
                if (loc1 != 16) 
                {
                    if (loc1 != 17) 
                    {
                        loc1 = 11 + bits(7);
                    }
                    else 
                    {
                        loc1 = 3 + bits(3);
                    }
                }
                else 
                {
                    if (loc8 == 0) 
                    {
                        throw new Error("dynamic block code description: repeat lengths with no first length", -5);
                    }
                    loc5 = loc2[(loc8 - 1)];
                    loc1 = 3 + bits(2);
                }
                if (loc8 + loc1 > loc3 + loc7) 
                {
                    throw new Error("dynamic block code description: repeat more than specified lengths", -6);
                }
                for (;;) 
                {
                    --loc1;
                    if (!loc1) 
                    {
                        break;
                    }
                    ++loc8;
                    loc2[loc8] = loc5;
                }
            }
            if ((loc4 = construct(lencode, loc2, loc3)) < 0 || loc4 > 0 && !(loc3 - lencode.count[0] == 1)) 
            {
                throw new Error("dynamic block code description: invalid literal/length code lengths", -7);
            }
            if ((loc4 = construct(distcode, loc2.slice(loc3), loc7)) < 0 || loc4 > 0 && !(loc7 - distcode.count[0] == 1)) 
            {
                throw new Error("dynamic block code description: invalid distance code lengths", -8);
            }
            return loc4;
        }

        internal static const MAXBITS:int=15;

        internal static const MAXLCODES:int=286;

        internal static const MAXDCODES:int=30;

        internal static const MAXCODES:int=316;

        internal static const FIXLCODES:int=288;

        internal static const LENS:Array=[3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 15, 17, 19, 23, 27, 31, 35, 43, 51, 59, 67, 83, 99, 115, 131, 163, 195, 227, 258];

        internal static const LEXT:Array=[0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 0];

        internal static const DISTS:Array=[1, 2, 3, 4, 5, 7, 9, 13, 17, 25, 33, 49, 65, 97, 129, 193, 257, 385, 513, 769, 1025, 1537, 2049, 3073, 4097, 6145, 8193, 12289, 16385, 24577];

        internal static const DEXT:Array=[0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 11, 11, 12, 12, 13, 13];

        internal var inbuf:flash.utils.ByteArray;

        internal var incnt:uint;

        internal var bitbuf:int;

        internal var bitcnt:int;

        internal var lencode:Object;

        internal var distcode:Object;
    }
}


//      class ZipConstants
package nochump.util.zip 
{
    internal class ZipConstants extends Object
    {
        public function ZipConstants()
        {
            super();
            return;
        }

        static const LOCSIG:uint=67324752;

        static const LOCHDR:uint=30;

        static const LOCVER:uint=4;

        static const LOCNAM:uint=26;

        static const EXTSIG:uint=134695760;

        static const EXTHDR:uint=16;

        static const CENSIG:uint=33639248;

        static const CENHDR:uint=46;

        static const CENVER:uint=6;

        static const CENNAM:uint=28;

        static const CENOFF:uint=42;

        static const ENDSIG:uint=101010256;

        static const ENDHDR:uint=22;

        static const ENDTOT:uint=10;

        static const ENDOFF:uint=16;

        static const STORED:uint=0;

        static const DEFLATED:uint=8;
    }
}


//      class ZipEntry
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


//      class ZipError
package nochump.util.zip 
{
    import flash.errors.*;
    
    public class ZipError extends flash.errors.IOError
    {
        public function ZipError(arg1:String="", arg2:int=0)
        {
            super(arg1, arg2);
            return;
        }
    }
}


//      class ZipFile
package nochump.util.zip 
{
    import flash.utils.*;
    
    public class ZipFile extends Object
    {
        public function ZipFile(arg1:flash.utils.IDataInput)
        {
            super();
            buf = new flash.utils.ByteArray();
            buf.endian = "littleEndian";
            arg1.readBytes(buf);
            readEntries();
            return;
        }

        public function get entries():Array
        {
            return entryList;
        }

        public function get size():uint
        {
            return entryList.length;
        }

        public function getEntry(arg1:String):nochump.util.zip.ZipEntry
        {
            return entryTable[arg1];
        }

        public function getInput(arg1:nochump.util.zip.ZipEntry):flash.utils.ByteArray
        {
            var loc1:*=null;
            var loc3:*=null;
            buf.position = locOffsetTable[arg1.name] + 30 - 2;
            var loc2:*=buf.readShort();
            buf.position = buf.position + (arg1.name.length + loc2);
            var loc4:*=new flash.utils.ByteArray();
            if (arg1.compressedSize > 0) 
            {
                buf.readBytes(loc4, 0, arg1.compressedSize);
            }
        }

        internal function readEntries():void
        {
            var loc3:*=0;
            var loc4:*=null;
            var loc1:*=0;
            var loc2:*=null;
            readEND();
            entryTable = new flash.utils.Dictionary();
            locOffsetTable = new flash.utils.Dictionary();
            loc3 = 0;
            while (loc3 < entryList.length) 
            {
                (loc4 = new flash.utils.ByteArray()).endian = "littleEndian";
                buf.readBytes(loc4, 0, 46);
                if (loc4.readUnsignedInt() != 33639248) 
                {
                    throw new nochump.util.zip.ZipError("invalid CEN header (bad signature)");
                }
                loc4.position = 28;
                loc1 = loc4.readUnsignedShort();
                if (loc1 == 0) 
                {
                    throw new nochump.util.zip.ZipError("missing entry name");
                }
                loc2 = new nochump.util.zip.ZipEntry(buf.readUTFBytes(loc1));
                loc1 = loc4.readUnsignedShort();
                loc2.extra = new flash.utils.ByteArray();
                if (loc1 > 0) 
                {
                    buf.readBytes(loc2.extra, 0, loc1);
                }
                buf.position = buf.position + loc4.readUnsignedShort();
                loc4.position = 6;
                loc2.version = loc4.readUnsignedShort();
                loc2.flag = loc4.readUnsignedShort();
                if ((loc2.flag & 1) == 1) 
                {
                    throw new nochump.util.zip.ZipError("encrypted ZIP entry not supported");
                }
                loc2.method = loc4.readUnsignedShort();
                loc2.dostime = loc4.readUnsignedInt();
                loc2.crc = loc4.readUnsignedInt();
                loc2.compressedSize = loc4.readUnsignedInt();
                loc2.size = loc4.readUnsignedInt();
                entryList[loc3] = loc2;
                entryTable[loc2.name] = loc2;
                loc4.position = 42;
                locOffsetTable[loc2.name] = loc4.readUnsignedInt();
                ++loc3;
            }
            return;
        }

        internal function readEND():void
        {
            var loc1:*=new flash.utils.ByteArray();
            loc1.endian = "littleEndian";
            buf.position = findEND();
            buf.readBytes(loc1, 0, 22);
            loc1.position = 10;
            entryList = new Array(loc1.readUnsignedShort());
            loc1.position = 16;
            buf.position = loc1.readUnsignedInt();
            return;
        }

        internal function findEND():uint
        {
            var loc1:*=buf.length - 22;
            var loc2:*=Math.max(0, loc1 - 65535);
            loc1;
            while (loc1 >= loc2) 
            {
                if (buf[loc1] == 80) 
                {
                    buf.position = loc1;
                    if (buf.readUnsignedInt() == 101010256) 
                    {
                        return loc1;
                    }
                }
                --loc1;
            }
            throw new nochump.util.zip.ZipError("invalid zip");
            return 0;
        }

        internal var buf:flash.utils.ByteArray;

        internal var entryList:Array;

        internal var entryTable:flash.utils.Dictionary;

        internal var locOffsetTable:flash.utils.Dictionary;
    }
}


//      class ZipOutput
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


