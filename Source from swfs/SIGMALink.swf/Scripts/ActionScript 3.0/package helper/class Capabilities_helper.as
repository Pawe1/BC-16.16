//class Capabilities_helper
package helper 
{
    import flash.system.*;
    
    public final class Capabilities_helper extends Object
    {
        public function Capabilities_helper()
        {
            super();
            return;
        }

        public static function get APPNAME():String
        {
            if (_appname == null) 
            {
                _appname = appXml.ns::name;
            }
            return _appname;
        }

        public static function get APPVERSION():String
        {
            if (_appversion == null) 
            {
                _appversion = appXml.ns::versionNumber;
            }
            return _appversion;
        }

        public static function get DEVICE():String
        {
            if (_platform.indexOf("ios") > -1) 
            {
                return "IOS";
            }
            if (_platform.indexOf("and") > -1) 
            {
                return "ANDROID";
            }
            if (_platform.indexOf("win") > -1) 
            {
                return "WINDOWS";
            }
            if (_platform.indexOf("mac") > -1) 
            {
                return "MACOSX";
            }
            return "UNDEFINED";
        }

        public static function set appXML(arg1:XML):void
        {
            _appxml = arg1;
            return;
        }

        internal static function get appXml():XML
        {
            return _appxml;
        }

        internal static function get ns():Namespace
        {
            if (_ns == null) 
            {
                _ns = appXml.namespace();
            }
            return _ns;
        }

        public static function isAndroid():Boolean
        {
            return DEVICE == "ANDROID";
        }

        public static function isWindows():Boolean
        {
            return DEVICE == "WINDOWS";
        }

        public static function isMobile():Boolean
        {
            return DEVICE == "ANDROID" || DEVICE == "IOS";
        }

        public static function isMac():Boolean
        {
            return DEVICE == "MACOSX";
        }

        public static function isIOS():Boolean
        {
            return DEVICE == "IOS";
        }

        public static function isDesktop():Boolean
        {
            return isWindows() || isMac();
        }

        public static function isSimulator():Boolean
        {
            return isMobile() && (!(_operatingSystem.indexOf("windows") == -1) || !(_operatingSystem.indexOf("mac os") == -1));
        }

        
        {
            _operatingSystem = flash.system.Capabilities.os.toLowerCase();
            _platform = flash.system.Capabilities.version.toLowerCase();
        }

        public static const DEVICE_ANDROID:String="ANDROID";

        public static const DEVICE_IOS:String="IOS";

        public static const DEVICE_OSX:String="MACOSX";

        public static const DEVICE_UNDEFINED:String="UNDEFINED";

        public static const DEVICE_WINDOWS:String="WINDOWS";

        internal static var _appname:String;

        internal static var _appversion:String;

        internal static var _appxml:XML;

        internal static var _operatingSystem:String;

        internal static var _platform:String;

        internal static var _ns:Namespace;
    }
}


