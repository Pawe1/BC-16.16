//class USBSendTimer
package service.usb 
{
    import flash.utils.*;
    
    public class USBSendTimer extends flash.utils.Timer
    {
        public function USBSendTimer(arg1:Number, arg2:uint=0, arg3:String="", arg4:int=0, arg5:Array=null, arg6:int=0, arg7:int=0)
        {
            super(arg1, arg7);
            usbPort = arg2;
            command = arg3;
            bytesToReceive = arg4;
            packageSize = arg6;
            data = arg5;
            return;
        }

        public var bytesToReceive:int;

        public var command:String;

        public var data:Array;

        public var packageSize:int;

        public var sentBytes:int=0;

        public var usbPort:uint;
    }
}


