//class Queueitem
package service 
{
    import handler.*;
    
    public class Queueitem extends Object
    {
        public function Queueitem(arg1:String, arg2:String, arg3:handler.DeviceHandler)
        {
            super();
            type = arg1;
            commandMode = arg2;
            deviceHandler = arg3;
            return;
        }

        public var commandMode:String;

        public var deviceHandler:handler.DeviceHandler;

        public var type:String;
    }
}


