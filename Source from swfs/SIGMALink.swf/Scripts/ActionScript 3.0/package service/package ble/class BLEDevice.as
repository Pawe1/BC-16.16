//class BLEDevice
package service.ble 
{
    import core.units.interfaces.*;
    
    public class BLEDevice extends Object implements core.units.interfaces.IBLEDeviceInfo
    {
        public function BLEDevice(arg1:String, arg2:String, arg3:String)
        {
            super();
            _deviceID = arg1;
            _primaryServiceUUID = arg2;
            _localName = arg3;
            return;
        }

        public function get deviceID():String
        {
            return _deviceID;
        }

        public function set deviceID(arg1:String):void
        {
            _deviceID = arg1;
            return;
        }

        public function get dsHandler():String
        {
            return _dsHandler;
        }

        public function set dsHandler(arg1:String):void
        {
            _dsHandler = arg1;
            return;
        }

        public function get localName():String
        {
            return _localName;
        }

        public function set localName(arg1:String):void
        {
            _localName = arg1;
            return;
        }

        public function get primaryServiceUUID():String
        {
            return _primaryServiceUUID;
        }

        public function set primaryServiceUUID(arg1:String):void
        {
            _primaryServiceUUID = arg1;
            return;
        }

        public function toString():String
        {
            return _localName + "\nDevice: " + _deviceID + "\nPrimary Service: " + _primaryServiceUUID;
        }

        internal var _deviceID:String="";

        internal var _dsHandler:String;

        internal var _localName:String="";

        internal var _primaryServiceUUID:String="";
    }
}


