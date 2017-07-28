//class UploadPostHelper
package service.oauth 
{
    import flash.utils.*;
    
    public class UploadPostHelper extends Object
    {
        public function UploadPostHelper()
        {
            super();
            return;
        }

        public static function getBoundary():String
        {
            var loc1:*=0;
            if (_boundary.length == 0) 
            {
                loc1 = 0;
                while (loc1 < 32) 
                {
                    _boundary = _boundary + String.fromCharCode(97 + Math.random() * 25);
                    ++loc1;
                }
            }
            return _boundary;
        }

        public static function getPostData(arg1:String, arg2:flash.utils.ByteArray, arg3:Object=null):flash.utils.ByteArray
        {
            var loc3:*=0;
            var loc1:*=null;
            var loc4:*;
            (loc4 = new flash.utils.ByteArray()).endian = "bigEndian";
            if (arg3 == null) 
            {
                arg3 = {};
            }
            arg3.Filename = arg1;
            var loc6:*=0;
            var loc5:*=arg3;
            for (var loc2:* in loc5) 
            {
                loc4 = BOUNDARY(loc4);
                loc4 = LINEBREAK(loc4);
                loc1 = "Content-Disposition: form-data; name=\"" + loc2 + "\"";
                loc3 = 0;
                while (loc3 < loc1.length) 
                {
                    loc4.writeByte(loc1.charCodeAt(loc3));
                    ++loc3;
                }
                loc4 = LINEBREAK(loc4);
                (loc4 = LINEBREAK(loc4)).writeUTFBytes(arg3[loc2]);
                loc4 = LINEBREAK(loc4);
            }
            loc4 = BOUNDARY(loc4);
            loc4 = LINEBREAK(loc4);
            loc1 = "Content-Disposition: form-data; name=\"file\"; filename=\"";
            loc3 = 0;
            while (loc3 < loc1.length) 
            {
                loc4.writeByte(loc1.charCodeAt(loc3));
                ++loc3;
            }
            loc4.writeUTFBytes(arg1);
            loc4 = QUOTATIONMARK(loc4);
            loc4 = LINEBREAK(loc4);
            loc1 = "Content-Type: application/octet-stream";
            loc3 = 0;
            while (loc3 < loc1.length) 
            {
                loc4.writeByte(loc1.charCodeAt(loc3));
                ++loc3;
            }
            loc4 = LINEBREAK(loc4);
            (loc4 = LINEBREAK(loc4)).writeBytes(arg2, 0, arg2.length);
            loc4 = LINEBREAK(loc4);
            loc4 = LINEBREAK(loc4);
            loc4 = BOUNDARY(loc4);
            loc4 = LINEBREAK(loc4);
            loc1 = "Content-Disposition: form-data; name=\"Upload\"";
            loc3 = 0;
            while (loc3 < loc1.length) 
            {
                loc4.writeByte(loc1.charCodeAt(loc3));
                ++loc3;
            }
            loc4 = LINEBREAK(loc4);
            loc4 = LINEBREAK(loc4);
            loc1 = "Submit Query";
            loc3 = 0;
            while (loc3 < loc1.length) 
            {
                loc4.writeByte(loc1.charCodeAt(loc3));
                ++loc3;
            }
            loc4 = LINEBREAK(loc4);
            loc4 = BOUNDARY(loc4);
            return loc4 = DOUBLEDASH(loc4);
        }

        internal static function BOUNDARY(arg1:flash.utils.ByteArray):flash.utils.ByteArray
        {
            var loc1:*=0;
            var loc2:*=UploadPostHelper.getBoundary().length;
            arg1 = DOUBLEDASH(arg1);
            loc1 = 0;
            while (loc1 < loc2) 
            {
                arg1.writeByte(_boundary.charCodeAt(loc1));
                ++loc1;
            }
            return arg1;
        }

        internal static function LINEBREAK(arg1:flash.utils.ByteArray):flash.utils.ByteArray
        {
            arg1.writeShort(3338);
            return arg1;
        }

        internal static function QUOTATIONMARK(arg1:flash.utils.ByteArray):flash.utils.ByteArray
        {
            arg1.writeByte(34);
            return arg1;
        }

        internal static function DOUBLEDASH(arg1:flash.utils.ByteArray):flash.utils.ByteArray
        {
            arg1.writeShort(11565);
            return arg1;
        }

        internal static var _boundary:String="";
    }
}


