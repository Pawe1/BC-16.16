//class NfcQuePackage
package service.nfc 
{
    import de.pagecon.ane.nfc.events.*;
    
    public class NfcQuePackage extends Object
    {
        public function NfcQuePackage(arg1:de.pagecon.ane.nfc.events.NfcEvent=null)
        {
            super();
            if (arg1 != null) 
            {
                byteString = arg1.byteString;
                endAddr = arg1.endAddr;
                errorCode = arg1.errorCode;
                errorMessage = arg1.errorMessage;
                rArray = arg1.rArray;
                startAddr = arg1.startAddr;
            }
            return;
        }

        public var byteString:String;

        public var endAddr:uint;

        public var errorCode:uint;

        public var errorMessage:String;

        public var rArray:Array;

        public var startAddr:uint;
    }
}


