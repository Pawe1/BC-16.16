//class NxpTag
package de.pagecon.ane.nxptag 
{
    import de.pagecon.ane.nfc.*;
    import flash.events.*;
    
    public class NxpTag extends flash.events.EventDispatcher
    {
        public function NxpTag()
        {
            super();
            init();
            return;
        }

        internal function init():void
        {
            return;
        }

        public function connect():void
        {
            de.pagecon.ane.nfc.NfcController.instance.handleNxpTag(10);
            return;
        }

        public function isConnected():void
        {
            de.pagecon.ane.nfc.NfcController.instance.handleNxpTag(11);
            return;
        }

        public function close():void
        {
            de.pagecon.ane.nfc.NfcController.instance.handleNxpTag(20);
            return;
        }

        public function fast_read():void
        {
            de.pagecon.ane.nfc.NfcController.instance.handleNxpTag(31);
            return;
        }

        public function write():void
        {
            de.pagecon.ane.nfc.NfcController.instance.handleNxpTag(30);
            return;
        }

        public function write_SRAM():void
        {
            de.pagecon.ane.nfc.NfcController.instance.handleNxpTag(40);
            return;
        }

        public function read_SRam():void
        {
            de.pagecon.ane.nfc.NfcController.instance.handleNxpTag(41);
            return;
        }

        public static function nxpCommandValid(arg1:uint):Boolean
        {
            var loc1:*=false;
            var loc2:*=arg1;
            while (10 === loc2) 
            {
                loc1 = true;
            }
        }

        public static const METHOD_CLOSE:uint=20;

        public static const METHOD_CONNECT:uint=10;

        public static const METHOD_FAST_READ:uint=31;

        public static const METHOD_ISCONNECTED:uint=11;

        public static const METHOD_READ_SRAM:uint=41;

        public static const METHOD_UNKNOWN:uint=0;

        public static const METHOD_WRITE:uint=30;

        public static const METHOD_WRITE_SRAM:uint=40;

        internal var _nfcController:de.pagecon.ane.nfc.NfcController;
    }
}


