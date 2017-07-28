//class DeviceHandler
package handler 
{
    import com.logging.*;
    import debug.*;
    import flash.events.*;
    import flash.utils.*;
    
    public class DeviceHandler extends flash.events.EventDispatcher
    {
        public function DeviceHandler(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            com.logging.ErrorLogging.getInstance().addTarget(this);
            return;
        }

        public function get port():String
        {
            return _port;
        }

        public function set port(arg1:String):void
        {
            _port = arg1;
            return;
        }

        public function destructor():void
        {
            com.logging.ErrorLogging.getInstance().removeTarget(this);
            return;
        }

        public function loadFromDC(arg1:String):void
        {
            debug.Debug.error("please override this method!");
            return;
        }

        public function sendToDC(arg1:String):void
        {
            debug.Debug.error("please override this method!");
            return;
        }

        public function resetCheckConnectionTimeOut():void
        {
            return;
        }

        protected function removeEvents():void
        {
            return;
        }

        public var connectionTimeoutInterval:uint=20000;

        public var currentBytesToReceive:int=0;

        public var currentCommand:*=0;

        public var currentLogHeaderIndex:int=0;

        public var currentReceiveChecksumLength:int=0;

        public var currentStartAdrr:String="";

        internal var _port:String;

        protected var _checkConnectionTimeOutId:uint=0;

        protected var currentType:String;
    }
}


