//class UsbListener
package de.pagecon.usb 
{
    public dynamic interface UsbListener
    {
        function dataReceived(arg1:int, arg2:Array):void;

        function connectionEvent(arg1:int, arg2:de.pagecon.usb.SigmaDevice):void;

        function debugInfo(arg1:String):void;
    }
}


