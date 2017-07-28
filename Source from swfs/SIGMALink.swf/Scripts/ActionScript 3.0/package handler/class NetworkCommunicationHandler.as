//class NetworkCommunicationHandler
package handler 
{
    import configCache.*;
    import de.pagecon.ane.networkInfo.*;
    import flash.desktop.*;
    import flash.events.*;
    
    public class NetworkCommunicationHandler extends flash.events.EventDispatcher
    {
        public function NetworkCommunicationHandler()
        {
            super();
            de.pagecon.ane.networkInfo.AirNetworkInfo.networkInfo.addEventListener(NETWORK_CHANGE, this.onNetworkChange, false, 10);
            flash.desktop.NativeApplication.nativeApplication.addEventListener(flash.events.Event.DEACTIVATE, this.onApplicationDeactivate);
            flash.desktop.NativeApplication.nativeApplication.addEventListener(flash.events.Event.ACTIVATE, this.onActivationActivate);
            this.onNetworkChange();
            return;
        }

        internal function onApplicationDeactivate(arg1:flash.events.Event):void
        {
            this._deactivateFlag = true;
            return;
        }

        internal function onActivationActivate(arg1:flash.events.Event):void
        {
            this._deactivateFlag = false;
            this.onNetworkChange();
            return;
        }

        internal function onNetworkChange(arg1:flash.events.Event=null):void
        {
            if (this._deactivateFlag) 
            {
                return;
            }
            var loc1:*=isOnline(false) || handler.ApplicationHandler.isSimulator;
            if (online != loc1) 
            {
                online = loc1;
                dispatchEvent(new flash.events.Event(NETWORK_CHANGE));
            }
            return;
        }

        public static function getInstance():handler.NetworkCommunicationHandler
        {
            if (!_instance) 
            {
                _instance = new NetworkCommunicationHandler();
            }
            return _instance;
        }

        public static function isOnline(arg1:Boolean):Boolean
        {
            var loc1:*=false;
            if (arg1) 
            {
                return isConnected() || isConnectedWithWIFI();
            }
            loc1 = configCache.ConfigCache.getInstance().getValue(configCache.ConfigCacheObject.CLOUD_SYNC_WIFI_ONLY, true);
            return loc1 && isConnectedWithWIFI() || !loc1 && (isConnected() || isConnectedWithWIFI());
        }

        internal static function isConnected():Boolean
        {
            return de.pagecon.ane.networkInfo.AirNetworkInfo.networkInfo.isConnected();
        }

        internal static function isConnectedWithWIFI():Boolean
        {
            return de.pagecon.ane.networkInfo.AirNetworkInfo.networkInfo.isConnectedWithWIFI();
        }

        
        {
            online = false;
        }

        public static const NETWORK_CHANGE:String="networkChange";

        internal var _deactivateFlag:Boolean=false;

        internal var _validateNetworkStatusFlag:Boolean=false;

        public static var online:Boolean=false;

        internal static var _instance:handler.NetworkCommunicationHandler;
    }
}


