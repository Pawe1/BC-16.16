//class NfcQueObj
package service.nfc 
{
    import __AS3__.vec.*;
    import core.activities.*;
    import flash.utils.*;
    import helper.*;
    
    public class NfcQueObj extends Object
    {
        public function NfcQueObj(arg1:flash.utils.ByteArray, arg2:uint=0, arg3:Boolean=true, arg4:uint=0, arg5:Boolean=false)
        {
            packages = new __AS3__.vec.Vector.<service.nfc.NfcQuePackage>();
            resultBytes = [];
            super();
            sendCommand = arg1;
            queSize = arg2;
            waitForAllCommands = arg3;
            delay = arg4;
            keepTagOpen = arg5;
            return;
        }

        public function get length():Number
        {
            return _length;
        }

        public function set length(arg1:Number):void
        {
            _length = arg1;
            return;
        }

        public function get queSize():uint
        {
            return _queSize;
        }

        public function set queSize(arg1:uint):void
        {
            _queSize = arg1 < 1 ? 1 : arg1;
            return;
        }

        public function getProgress():uint
        {
            if (length == 0) 
            {
                return 0;
            }
            var loc1:*=length / 64;
            return 100 / loc1 * packages.length;
        }

        public function toString():String
        {
            var loc1:*="[NfcQueObj] ";
            loc1 = loc1 + ("\n\t ::: queSize: " + queSize);
            loc1 = loc1 + ("\n\t ::: sendCommand: " + helper.ByteArray_helper.toArray(sendCommand).join(" "));
            loc1 = loc1 + ("\n\t ::: waitForAllCommands: " + waitForAllCommands.toString());
            loc1 = loc1 + ("\n\t ::: readDelay: " + readDelay.toString());
            loc1 = loc1 + ("\n\t ::: readBlockDelayay: " + readBlockDelay.toString());
            loc1 = loc1 + ("\n\t ::: fifoBit: " + fifoBit.toString());
            if (buffer != null) 
            {
                loc1 = loc1 + ("\n\t ::: buffer size: " + buffer.bytesAvailable);
                loc1 = loc1 + ("\n\t ::: buffer length: " + buffer.length);
            }
            if (startBlock > 0) 
            {
                loc1 = loc1 + ("\n\t ::: startBlock: " + startBlock);
            }
            if (endBlock > 0) 
            {
                loc1 = loc1 + ("\n\t ::: endBlock: " + endBlock);
            }
            if (length > 0) 
            {
                loc1 = loc1 + ("\n\t ::: length: " + length);
            }
            if (dataByteString.length > 0) 
            {
                loc1 = loc1 + ("\n\t ::: dataByteString: " + dataByteString);
            }
            if (guid != "") 
            {
                loc1 = loc1 + ("\n\t ::: guid: " + guid);
            }
            return loc1;
        }

        public var activity:core.activities.Activity;

        public var buffer:flash.utils.ByteArray;

        public var command:uint=0;

        public var corruptedStartBlock:uint=0;

        public var currentEndBlock:uint=0;

        public var dataByteString:String="";

        public var delay:uint=0;

        public var endBlock:uint=0;

        public var errorOnBlock:uint=0;

        public var fifoBit:uint=1;

        public var guid:String="";

        public var keepTagOpen:Boolean=false;

        internal var _length:Number=0;

        public var packages:__AS3__.vec.Vector.<service.nfc.NfcQuePackage>;

        internal var _queSize:uint;

        public var readBlockDelay:uint=4;

        public var readDelay:uint=6;

        public var result:String="";

        public var resultBytes:Array;

        public var sendCommand:flash.utils.ByteArray;

        public var startBlock:uint=0;

        public var waitForAllCommands:Boolean=true;
    }
}


