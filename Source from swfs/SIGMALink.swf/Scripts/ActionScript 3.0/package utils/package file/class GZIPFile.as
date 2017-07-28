//class GZIPFile
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


