//package file
//  class CRC32Generator
package utils.file 
{
    import flash.utils.*;
    
    public class CRC32Generator extends Object
    {
        public function CRC32Generator()
        {
            super();
            return;
        }

        public function generateCRC32(arg1:flash.utils.ByteArray):int
        {
            var loc3:*=0;
            if (!_tableComputed) 
            {
                makeCRCTable();
            }
            var loc1:*=-1;
            var loc2:*=arg1.length;
            loc3 = 0;
            while (loc3 < loc2) 
            {
                loc1 = _crcTable[(loc1 ^ arg1[loc3]) & 255] ^ loc1 >>> 8;
                ++loc3;
            }
            loc1 = ~loc1;
            return loc1 & 4294967295;
        }

        internal static function makeCRCTable():void
        {
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=0;
            _crcTable = new Array(256);
            loc2 = 0;
            while (loc2 < 256) 
            {
                loc1 = loc2;
                loc3 = 0;
                while (loc3 < 8) 
                {
                    if ((loc1 & 1) == 0) 
                    {
                        loc1 = loc1 >>> 1;
                    }
                    else 
                    {
                        loc1 = 3988292384 ^ loc1 >>> 1;
                    }
                    ++loc3;
                }
                _crcTable[loc2] = loc1;
                ++loc2;
            }
            _tableComputed = true;
            return;
        }

        internal static var _crcTable:Array;

        internal static var _tableComputed:Boolean=false;
    }
}


//  class FileExtension
package utils.file 
{
    public class FileExtension extends Object
    {
        public function FileExtension()
        {
            super();
            return;
        }

        public static function createFileName(arg1:String):String
        {
            var loc1:*=createRandomNumber(1, 100);
            var loc3:*;
            var loc2:*=(loc3 = new Date()).date.toString() + loc3.month.toString() + loc3.fullYear.toString() + loc3.hours.toString() + loc3.minutes.toString() + loc3.seconds.toString() + loc3.milliseconds.toString() + loc1;
            return loc2 + "." + arg1;
        }

        public static function createRandomNumber(arg1:Number, arg2:Number):Number
        {
            var loc1:*=Math.floor(Math.random() * (arg2 - arg1 + 1)) + arg1;
            return loc1;
        }

        public static const CSV_FILE:String="csv";

        public static const FILTER_FILE:String="sff";

        public static const FIT_FILE:String="fit";

        public static const GPX_FILE:String="gpx";

        public static const KML_FILE:String="kml";

        public static const KMZ_FILE:String="kmz";

        public static const LOG_FILE:String="slf";

        public static const MEMORY_FILE:String="smf";

        public static const POINT_NAVIGATION:String="spn";

        public static const SETTING_FILE:String="ssf";

        public static const SPORTPROFILE:String="ssp";

        public static const TCX_FILE:String="tcx";

        public static const TRACK_FILE:String="stf";

        public static const TRAININGPROGRAM_FILE:String="spf";

        public static const XLSX_FILE:String="xlsx";
    }
}


//  class GZIPBytesEncoder
package utils.file 
{
    import flash.errors.*;
    import flash.system.*;
    import flash.utils.*;
    
    public class GZIPBytesEncoder extends Object
    {
        public function GZIPBytesEncoder()
        {
            super();
            return;
        }

        public function compressToByteArray(arg1:flash.utils.ByteArray, arg2:Date=null):flash.utils.ByteArray
        {
            var loc1:*=0;
            if (arg1 == null) 
            {
                throw new ArgumentError("src can\'t be null.");
            }
            var loc10:*=arg1.position;
            var loc12:*;
            (loc12 = new flash.utils.ByteArray()).writeBytes(arg1);
            var loc4:*;
            (loc4 = new flash.utils.ByteArray()).endian = "littleEndian";
            var loc8:*=31;
            loc4.writeByte(loc8);
            var loc7:*=139;
            loc4.writeByte(loc7);
            var loc3:*=8;
            loc4.writeByte(loc3);
            var loc2:*=parseInt("00000000", 2);
            loc4.writeByte(loc2);
            var loc5:*=arg2 != null ? arg2.time : 0;
            loc4.writeUnsignedInt(loc5);
            var loc13:*=parseInt("00000100", 2);
            loc4.writeByte(loc13);
            if (flash.system.Capabilities.os.indexOf("Windows") >= 0) 
            {
                loc1 = 11;
            }
            else if (flash.system.Capabilities.os.indexOf("Mac OS") >= 0) 
            {
                loc1 = 7;
            }
            else 
            {
                loc1 = 3;
            }
            loc4.writeByte(loc1);
            var loc6:*;
            var loc11:*=(loc6 = new utils.file.CRC32Generator()).generateCRC32(loc12);
            var loc9:*=loc12.length % Math.pow(2, 32);
            loc12.deflate();
            loc4.writeBytes(loc12, 0, loc12.length);
            loc4.writeUnsignedInt(loc11);
            loc4.writeUnsignedInt(loc9);
            return loc4;
        }

        public function uncompressToByteArray(arg1:flash.utils.ByteArray):flash.utils.ByteArray
        {
            var loc2:*=null;
            loc2 = parseGZIPData(arg1);
            var loc1:*=loc2.getCompressedData();
            try 
            {
                loc1.inflate();
            }
            catch (error:Error)
            {
                throw new flash.errors.IllegalOperationError("The specified source is not a GZIP file format file or data.");
            }
            return loc1;
        }

        public function parseGZIPData(arg1:flash.utils.ByteArray, arg2:String=""):utils.file.GZIPFile
        {
            var loc7:*=null;
            var loc2:*=null;
            var loc15:*=null;
            var loc22:*=null;
            var loc10:*=0;
            if (arg1 == null) 
            {
                throw new ArgumentError("The srcBytes ByteArray can\'t be null.");
            }
            arg1.endian = "littleEndian";
            var loc21:*;
            if ((loc21 = arg1.readUnsignedByte()) != 31) 
            {
                throw new flash.errors.IllegalOperationError("The specified data is not in GZIP file format structure.");
            }
            var loc19:*;
            if ((loc19 = arg1.readUnsignedByte()) != 139) 
            {
                throw new flash.errors.IllegalOperationError("The specified data is not in GZIP file format structure.");
            }
            var loc18:*;
            if ((loc18 = arg1.readUnsignedByte()) != 8) 
            {
                throw new flash.errors.IllegalOperationError("The specified data is not in GZIP file format structure.");
            }
            var loc4:*;
            var loc11:*=((loc4 = arg1.readByte()) >> 7 & 1) == 1;
            var loc16:*=(loc4 >> 6 & 1) == 1;
            var loc13:*=(loc4 >> 5 & 1) == 1;
            var loc20:*=(loc4 >> 4 & 1) == 1;
            var loc1:*=(loc4 >> 3 & 1) == 1;
            var loc6:*=false;
            loc6 = (loc4 >> 2 & 1) != 1 ? loc6 : true;
            loc6 = (loc4 >> 1 & 1) != 1 ? loc6 : true;
            if (loc6 = (loc4 & 1) != 1 ? loc6 : true) 
            {
                throw new flash.errors.IllegalOperationError("The specified data is not in GZIP file format structure.");
            }
            var loc5:*=arg1.readUnsignedInt();
            var loc23:*=arg1.readUnsignedByte();
            var loc14:*=arg1.readUnsignedByte();
            if (loc13) 
            {
                loc7 = arg1.readUTF();
            }
            var loc12:*=null;
            if (loc20) 
            {
                loc2 = new flash.utils.ByteArray();
                while (arg1.readUnsignedByte() != 0) 
                {
                    --arg1.position;
                    loc2.writeByte(arg1.readByte());
                }
                loc2.position = 0;
                loc12 = loc2.readUTFBytes(loc2.length);
            }
            if (loc1) 
            {
                loc22 = new flash.utils.ByteArray();
                while (arg1.readUnsignedByte() != 0) 
                {
                    --arg1.position;
                    loc22.writeByte(arg1.readByte());
                }
                loc22.position = 0;
                loc15 = loc22.readUTFBytes(loc22.length);
            }
            if (loc16) 
            {
                loc10 = arg1.readUnsignedShort();
            }
            var loc17:*=arg1.length - arg1.position - 8;
            var loc3:*=new flash.utils.ByteArray();
            arg1.readBytes(loc3, 0, loc17);
            var loc9:*=arg1.readUnsignedInt();
            var loc8:*=arg1.readUnsignedInt();
            return new utils.file.GZIPFile(loc3, loc8, new Date(loc5), arg2, loc12, loc15);
        }
    }
}


//  class GZIPEncoder
package utils.file 
{
    import flash.errors.*;
    import flash.filesystem.*;
    import flash.utils.*;
    
    public class GZIPEncoder extends Object
    {
        public function GZIPEncoder()
        {
            super();
            return;
        }

        public function compressToFile(arg1:Object, arg2:flash.filesystem.File):void
        {
            var loc7:*=null;
            var loc1:*=null;
            var loc3:*=null;
            var loc2:*=null;
            if (arg1 == null || arg2 == null) 
            {
                throw new ArgumentError("src and output can\'t be null.");
            }
            var loc8:*=new flash.filesystem.File(arg2.nativePath);
            if (arg1 is flash.filesystem.File) 
            {
                if (!(loc3 = arg1 as flash.filesystem.File).exists || loc3.isDirectory) 
                {
                    throw new ArgumentError("If src is a File instance, it must specify the location of an existing file (not a directory).");
                }
                (loc2 = new flash.filesystem.FileStream()).open(loc3, "read");
                loc7 = new flash.utils.ByteArray();
                loc2.readBytes(loc7, 0, loc2.bytesAvailable);
                loc2.close();
                if (loc8.isDirectory) 
                {
                    loc8 = loc8.resolvePath(loc3.name + ".gz");
                }
                loc1 = loc3.modificationDate;
            }
            else if (arg1 is flash.utils.ByteArray) 
            {
                loc7 = arg1 as flash.utils.ByteArray;
                if (loc8.isDirectory) 
                {
                    loc8 = loc8.resolvePath("output.gz");
                }
                loc1 = new Date();
            }
            else 
            {
                throw new ArgumentError("src must be a File instance or a ByteArray instance");
            }
            var loc5:*;
            var loc6:*=(loc5 = new utils.file.GZIPBytesEncoder()).compressToByteArray(loc7, loc1);
            var loc4:*;
            (loc4 = new flash.filesystem.FileStream()).open(loc8, "write");
            loc4.writeBytes(loc6, 0, loc6.length);
            loc4.close();
            return;
        }

        public function uncompressToFile(arg1:flash.filesystem.File, arg2:flash.filesystem.File):void
        {
            var loc1:*=null;
            if (arg2 == null) 
            {
                throw new ArgumentError("output cannot be null");
            }
            var loc4:*=parseGZIPFile(arg1);
            var loc2:*;
            if ((loc2 = new flash.filesystem.File(arg2.nativePath)).isDirectory) 
            {
                if (loc4.headerFileName == null) 
                {
                    if (loc4.gzipFileName.lastIndexOf(".gz") != loc4.gzipFileName.length - 3) 
                    {
                        if (loc4.gzipFileName.lastIndexOf(".gzip") != loc4.gzipFileName.length - 5) 
                        {
                            loc1 = loc4.gzipFileName;
                        }
                        else 
                        {
                            loc1 = loc4.gzipFileName.substr(0, loc4.gzipFileName.length - 5);
                        }
                    }
                    else 
                    {
                        loc1 = loc4.gzipFileName.substr(0, loc4.gzipFileName.length - 3);
                    }
                }
                else 
                {
                    loc1 = loc4.headerFileName;
                }
                loc2 = loc2.resolvePath(loc1);
            }
            var loc3:*=loc4.getCompressedData();
            try 
            {
                loc3.uncompress("deflate");
            }
            catch (error:Error)
            {
                throw new flash.errors.IllegalOperationError("The specified file is not a GZIP file format file.");
            }
            var loc5:*;
            (loc5 = new flash.filesystem.FileStream()).open(loc2, "write");
            loc5.writeBytes(loc3, 0, loc3.length);
            loc5.close();
            return;
        }

        public function uncompressToByteArray(arg1:Object):flash.utils.ByteArray
        {
            var loc3:*=null;
            var loc2:*=null;
            if (arg1 is flash.filesystem.File) 
            {
                loc2 = arg1 as flash.filesystem.File;
                loc3 = parseGZIPFile(loc2);
            }
            else if (arg1 is flash.utils.ByteArray) 
            {
                loc3 = parseGZIPData(arg1 as flash.utils.ByteArray);
            }
            else 
            {
                throw new ArgumentError("The src argument must be a File or ByteArray instance");
            }
            var loc1:*=loc3.getCompressedData();
            try 
            {
                loc1.uncompress("deflate");
            }
            catch (error:Error)
            {
                throw new flash.errors.IllegalOperationError("The specified source is not a GZIP file format file or data.");
            }
            return loc1;
        }

        public function parseGZIPFile(arg1:flash.filesystem.File):utils.file.GZIPFile
        {
            checkSrcFile(arg1);
            var loc2:*=new flash.filesystem.File(arg1.nativePath);
            var loc1:*=new flash.filesystem.FileStream();
            loc1.open(loc2, "read");
            var loc3:*=new flash.utils.ByteArray();
            loc1.readBytes(loc3, 0, loc1.bytesAvailable);
            loc1.close();
            return parseGZIPData(loc3, loc2.name);
        }

        public function parseGZIPData(arg1:flash.utils.ByteArray, arg2:String=""):utils.file.GZIPFile
        {
            var loc1:*=new utils.file.GZIPBytesEncoder();
            return loc1.parseGZIPData(arg1, arg2);
        }

        internal function checkSrcFile(arg1:flash.filesystem.File):void
        {
            if (arg1 == null) 
            {
                throw new ArgumentError("src can\'t be null");
            }
            if (arg1.isDirectory) 
            {
                throw new ArgumentError("src must refer to the location of a file, not a directory");
            }
            if (!arg1.exists) 
            {
                throw new ArgumentError("src refers to a file that doesn\'t exist");
            }
            return;
        }
    }
}


//  class GZIPFile
package utils.file 
{
    import flash.utils.*;
    
    public class GZIPFile extends Object
    {
        public function GZIPFile(arg1:flash.utils.ByteArray, arg2:int, arg3:Date, arg4:String="", arg5:String=null, arg6:String=null)
        {
            super();
            _compressedData = arg1;
            _originalFileSize = arg2;
            _fileModificationTime = arg3;
            _gzipFileName = arg4;
            _headerFileName = arg5;
            _headerComment = arg6;
            return;
        }

        public function get fileModificationTime():Date
        {
            return _fileModificationTime;
        }

        public function get gzipFileName():String
        {
            return _gzipFileName;
        }

        public function get headerComment():String
        {
            return _headerComment;
        }

        public function get headerFileName():String
        {
            return _headerFileName;
        }

        public function get originalFileSize():int
        {
            return _originalFileSize;
        }

        public function getCompressedData():flash.utils.ByteArray
        {
            var loc1:*=new flash.utils.ByteArray();
            _compressedData.position = 0;
            _compressedData.readBytes(loc1, 0, _compressedData.length);
            return loc1;
        }

        internal var _fileModificationTime:Date;

        internal var _gzipFileName:String;

        internal var _headerComment:String;

        internal var _headerFileName:String;

        internal var _originalFileSize:int;

        internal var _compressedData:flash.utils.ByteArray;
    }
}


