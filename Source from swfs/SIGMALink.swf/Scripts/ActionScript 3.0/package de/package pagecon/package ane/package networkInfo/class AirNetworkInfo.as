//class AirNetworkInfo
package de.pagecon.ane.networkInfo 
{
    import __AS3__.vec.*;
    import flash.events.*;
    import flash.external.*;
    import flash.net.*;
    import flash.system.*;
    
    public class AirNetworkInfo extends flash.events.EventDispatcher
    {
        public function AirNetworkInfo()
        {
            super();
            extContext = flash.external.ExtensionContext.createExtensionContext("de.pagecon.ane.networkInfo", "net");
            if (useNativeExtension()) 
            {
                if (extContext) 
                {
                    extContext.addEventListener("status", onStatusEvent);
                }
            }
            else 
            {
                flash.net.NetworkInfo.networkInfo.addEventListener("networkChange", onNetworkChange);
            }
            return;
        }

        internal function onStatusEvent(arg1:flash.events.StatusEvent):void
        {
            this.dispatchEvent(new flash.events.Event(arg1.code));
            return;
        }

        internal function onNetworkChange(arg1:flash.events.Event):void
        {
            this.dispatchEvent(arg1);
            return;
        }

        public function setLogging(arg1:Boolean):void
        {
            doLogging = arg1;
            if (this.useNativeExtension()) 
            {
                extContext.call("setLogging", doLogging);
            }
            return;
        }

        public function isConnected():Boolean
        {
            if (this.useNativeExtension()) 
            {
                return hasNativeActiveConnection();
            }
            return hasActiveConnection();
        }

        public function isConnectedWithWIFI():Boolean
        {
            if (this.useNativeExtension()) 
            {
                return isNativeConnectedWithWIFI();
            }
            return isNotNativeConnectedWithWIFI();
        }

        internal function isNativeConnectedWithWIFI():Boolean
        {
            var loc2:*=0;
            var loc1:*=this.findInterfaces();
            loc2 = 0;
            while (loc2 < loc1.length) 
            {
                if (doLogging) 
                {
                    trace("[Network Info][isNativeConnectedWithWIFI]", loc1[loc2].toString());
                }
                if (loc1[loc2].active && loc1[loc2].name.toLocaleLowerCase() == "en0") 
                {
                    return true;
                }
                ++loc2;
            }
            return false;
        }

        internal function isNotNativeConnectedWithWIFI():Boolean
        {
            var loc2:*=0;
            var loc1:*=flash.net.NetworkInfo.networkInfo.findInterfaces();
            loc2 = 0;
            while (loc2 < loc1.length) 
            {
                if (doLogging) 
                {
                    trace("[Network Info][isNotNativeConnectedWithWIFI]", loc1[loc2].toString());
                }
                if (loc1[loc2].active && ["en0", "wifi"].indexOf(loc1[loc2].name.toLocaleLowerCase()) > -1) 
                {
                    return true;
                }
                ++loc2;
            }
            return false;
        }

        internal function hasNativeActiveConnection():Boolean
        {
            var loc2:*=0;
            var loc1:*=this.findInterfaces();
            if (loc1.length == 0) 
            {
                return true;
            }
            loc2 = 0;
            while (loc2 < loc1.length) 
            {
                if (doLogging) 
                {
                    trace("[Network Info][hasNativeActiveConnection]", loc1[loc2].toString());
                }
                if (loc1[loc2].active) 
                {
                    return true;
                }
                ++loc2;
            }
            return false;
        }

        internal function hasActiveConnection():Boolean
        {
            var loc2:*=0;
            var loc1:*=flash.net.NetworkInfo.networkInfo.findInterfaces();
            loc2 = 0;
            while (loc2 < loc1.length) 
            {
                if (doLogging) 
                {
                    trace("[Network Info][hasActiveConnection]", loc1[loc2].toString());
                }
                if (loc1[loc2].active) 
                {
                    return true;
                }
                ++loc2;
            }
            return false;
        }

        public function findInterfaces():__AS3__.vec.Vector.<de.pagecon.ane.networkInfo.NativeNetworkInterface>
        {
            var loc2:*=undefined;
            var loc1:*=extContext.call("getInterfaces") as Array;
            var loc3:*=0;
            loc2 = __AS3__.vec.Vector.<de.pagecon.ane.networkInfo.NativeNetworkInterface>(loc1);
            return loc2;
        }

        internal function useNativeExtension():Boolean
        {
            return flash.system.Capabilities.manufacturer.indexOf("iOS") > -1;
        }

        public static function get networkInfo():de.pagecon.ane.networkInfo.AirNetworkInfo
        {
            if (_instance == null) 
            {
                _instance = new AirNetworkInfo();
            }
            return _instance;
        }

        internal static var _instance:de.pagecon.ane.networkInfo.AirNetworkInfo=null;

        internal static var doLogging:Boolean=false;

        internal static var extContext:flash.external.ExtensionContext=null;
    }
}


