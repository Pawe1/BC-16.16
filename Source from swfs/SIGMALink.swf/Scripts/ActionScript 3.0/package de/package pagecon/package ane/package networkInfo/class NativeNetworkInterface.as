//class NativeNetworkInterface
package de.pagecon.ane.networkInfo 
{
    public class NativeNetworkInterface extends Object
    {
        public function NativeNetworkInterface(arg1:String, arg2:String, arg3:int, arg4:Boolean, arg5:String, arg6:Array)
        {
            super();
            _name = arg1;
            _displayName = arg2;
            _mtu = arg3;
            _hardwareAddress = arg5;
            _active = arg4;
            return;
        }

        public function get active():Boolean
        {
            return _active;
        }

        public function get displayName():String
        {
            return _displayName;
        }

        public function get hardwareAddress():String
        {
            return _hardwareAddress;
        }

        public function get mtu():int
        {
            return _mtu;
        }

        public function get name():String
        {
            return _name;
        }

        public function toString():String
        {
            return "[NativeNetworkInterface] Name: " + name + " ::: displayName: " + displayName + " ::: hardwareAddress: " + hardwareAddress + " ::: mtu: " + mtu + " ::: active: " + active;
        }

        internal var _active:Boolean=false;

        internal var _displayName:String="";

        internal var _hardwareAddress:String="";

        internal var _mtu:int=-1;

        internal var _name:String="";
    }
}


