//class PromotionHandler
package handler 
{
    import backend.utils.dbUtils.*;
    import configCache.*;
    import core.*;
    import core.general.*;
    import core.promotion.*;
    import core.units.*;
    import debug.*;
    import flash.data.*;
    import flash.events.*;
    import flash.net.*;
    import helper.*;
    
    public class PromotionHandler extends Object
    {
        public function PromotionHandler()
        {
            super();
            handler.NetworkCommunicationHandler.getInstance().addEventListener(handler.NetworkCommunicationHandler.NETWORK_CHANGE, this.onNetworkChanged);
            this.onNetworkChanged();
            return;
        }

        internal function onNetworkChanged(arg1:flash.events.Event=null):void
        {
            var loc1:*=null;
            if (handler.NetworkCommunicationHandler.online) 
            {
                handler.NetworkCommunicationHandler.getInstance().removeEventListener(handler.NetworkCommunicationHandler.NETWORK_CHANGE, this.onNetworkChanged);
                loc1 = "SELECT " + core.units.Unit.col_type + ", " + core.units.Unit.col_serialNumber + " FROM " + core.units.Unit.table_name;
                backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, loc1, this.loadDeviceListComplete, this.loadDeviceListError);
            }
            return;
        }

        internal function loadDeviceListError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.debug("loadDeviceListError");
            return;
        }

        internal function loadDeviceListComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            var p_event:backend.utils.dbUtils.DBUtilEvent;
            var result:Array;
            var i:int;
            var len:int;
            var deviceStr:String;
            var url:String;
            var loader:flash.net.URLLoader;

            var loc1:*;
            i = 0;
            len = 0;
            deviceStr = null;
            url = null;
            loader = null;
            p_event = arg1;
            result = p_event.getResult();
            if (result.length > 0) 
            {
                len = result.length;
                deviceStr = "";
                i = 0;
                while (i < len) 
                {
                    if (i != 0) 
                    {
                        deviceStr = deviceStr + ",";
                    }
                    deviceStr = deviceStr + (result[i][core.units.Unit.col_type] + "-" + result[i][core.units.Unit.col_serialNumber]);
                    ++i;
                }
                url = core.promotion.PromotionConfig.generateURL(configCache.ConfigCache.getInstance().getValue(configCache.ConfigCacheObject.SOFTWARE_LANGUAGE, core.general.LanguageSoftware.fromSystemLanguage()), core.promotion.PromotionConfig.PROMOTION_LINKC, handler.ApplicationHandler.versionNumber, core.Status.softwareGUID, deviceStr, helper.Capabilities_helper.DEVICE, handler.ApplicationHandler.isBeta);
                loader = new flash.net.URLLoader();
                loader.addEventListener(flash.events.Event.COMPLETE, this.onURLLoadComplete);
                try 
                {
                    debug.Debug.debug("promotion url: " + url);
                    loader.load(new flash.net.URLRequest(url));
                }
                catch (e:Error)
                {
                    debug.Debug.debug("loadUrl error: " + e.message);
                }
            }
            return;
        }

        internal function onURLLoadComplete(arg1:flash.events.Event):void
        {
            (arg1.currentTarget as flash.net.URLLoader).removeEventListener(flash.events.Event.COMPLETE, this.onURLLoadComplete);
            debug.Debug.debug("promotion URL loaded...");
            return;
        }

        public static function getInstance():handler.PromotionHandler
        {
            if (!_instance) 
            {
                _instance = new PromotionHandler();
            }
            return _instance;
        }

        internal static var _instance:handler.PromotionHandler;
    }
}


