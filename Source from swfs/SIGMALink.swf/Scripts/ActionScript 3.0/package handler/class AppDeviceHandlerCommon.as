//class AppDeviceHandlerCommon
package handler 
{
    import flash.events.*;
    import flash.utils.*;
    import mx.events.*;
    
    public class AppDeviceHandlerCommon extends flash.events.EventDispatcher
    {
        public function AppDeviceHandlerCommon()
        {
            super();
            return;
        }

        public static function get deviceDicGUID():flash.utils.Dictionary
        {
            return AppDeviceHandlerCommon.deviceDicGUID;
        }

        public static function set deviceDicGUID(arg1:flash.utils.Dictionary):void
        {
            var loc1:*=AppDeviceHandlerCommon.deviceDicGUID;
            if (loc1 !== arg1) 
            {
                AppDeviceHandlerCommon.deviceDicGUID = arg1;
                if (AppDeviceHandlerCommon._bindingEventDispatcher.hasEventListener("propertyChange")) 
                {
                    AppDeviceHandlerCommon._bindingEventDispatcher.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(AppDeviceHandlerCommon, "deviceDicGUID", loc1, arg1));
                }
            }
            return;
        }

        public static function get staticEventDispatcher():flash.events.IEventDispatcher
        {
            return AppDeviceHandlerCommon._bindingEventDispatcher;
        }

        
        {
            deviceDicGUID = new flash.utils.Dictionary(true);
            AppDeviceHandlerCommon._bindingEventDispatcher = new flash.events.EventDispatcher();
        }

        internal static var deviceDicGUID:flash.utils.Dictionary;

        internal static var _bindingEventDispatcher:flash.events.EventDispatcher;
    }
}


