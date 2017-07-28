//class Deflater
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


