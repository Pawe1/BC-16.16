//class GZIPEncoder
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


