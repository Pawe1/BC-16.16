//class IBLEDeviceInfo
package core.units.interfaces 
{
    public dynamic interface IBLEDeviceInfo
    {
        function get deviceID():String;

        function set deviceID(arg1:String):void;

        function get dsHandler():String;

        function set dsHandler(arg1:String):void;

        function get localName():String;

        function set localName(arg1:String):void;

        function get primaryServiceUUID():String;

        function set primaryServiceUUID(arg1:String):void;
    }
}


