//class ZipFile
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


