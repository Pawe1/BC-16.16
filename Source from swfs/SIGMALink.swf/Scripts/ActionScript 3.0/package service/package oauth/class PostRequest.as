//class PostRequest
package service.oauth 
{
    import flash.utils.*;
    
    public class PostRequest extends Object
    {
        public function PostRequest()
        {
            super();
            createPostData();
            return;
        }

        public function createPostData():void
        {
            postData = new flash.utils.ByteArray();
            postData.endian = "bigEndian";
            return;
        }

        public function writePostData(arg1:String, arg2:String):void
        {
            var loc1:*=null;
            var loc2:*=NaN;
            writeBoundary();
            writeLineBreak();
            loc1 = "Content-Disposition: form-data; name=\"" + arg1 + "\"";
            var loc3:*=loc1.length;
            loc2 = 0;
            while (loc2 < loc3) 
            {
                postData.writeByte(loc1.charCodeAt(loc2));
                ++loc2;
            }
            writeLineBreak();
            writeLineBreak();
            postData.writeUTFBytes(arg2);
            writeLineBreak();
            return;
        }

        public function writeFileData(arg1:String, arg2:flash.utils.ByteArray, arg3:String):void
        {
            var loc1:*=null;
            var loc3:*=0;
            var loc2:*=0;
            writeBoundary();
            writeLineBreak();
            loc3 = (loc1 = "Content-Disposition: form-data; name=\"" + arg1 + "\"; filename=\"" + arg1 + "\";").length;
            loc2 = 0;
            while (loc2 < loc3) 
            {
                postData.writeByte(loc1.charCodeAt(loc2));
                ++loc2;
            }
            postData.writeUTFBytes(arg1);
            writeQuotationMark();
            writeLineBreak();
            loc3 = (loc1 = arg3 || "application/octet-stream").length;
            loc2 = 0;
            while (loc2 < loc3) 
            {
                postData.writeByte(loc1.charCodeAt(loc2));
                ++loc2;
            }
            writeLineBreak();
            writeLineBreak();
            arg2.position = 0;
            postData.writeBytes(arg2, 0, arg2.length);
            writeLineBreak();
            return;
        }

        public function getPostData():flash.utils.ByteArray
        {
            postData.position = 0;
            return postData;
        }

        public function close():void
        {
            writeBoundary();
            writeDoubleDash();
            return;
        }

        protected function writeLineBreak():void
        {
            postData.writeShort(3338);
            return;
        }

        protected function writeQuotationMark():void
        {
            postData.writeByte(34);
            return;
        }

        protected function writeDoubleDash():void
        {
            postData.writeShort(11565);
            return;
        }

        protected function writeBoundary():void
        {
            var loc1:*=0;
            writeDoubleDash();
            var loc2:*=boundary.length;
            loc1 = 0;
            while (loc1 < loc2) 
            {
                postData.writeByte(boundary.charCodeAt(loc1));
                ++loc1;
            }
            return;
        }

        public var boundary:String="-----";

        protected var postData:flash.utils.ByteArray;
    }
}


