//package debug
//  class Debug
package debug 
{
    import flash.filesystem.*;
    import flash.globalization.*;
    import flash.system.*;
    
    public class Debug extends Object
    {
        public function Debug()
        {
            var loc1:*=null;
            super();
            if (!false) 
            {
                return;
            }
            if (useCustomPath) 
            {
                loc1 = new flash.filesystem.File(CUSTOM_FILE_PATH);
            }
            else if (flash.system.Capabilities.version.toLowerCase().indexOf("ios") > -1) 
            {
                loc1 = flash.filesystem.File.documentsDirectory.resolvePath("app-debug.log");
            }
            else 
            {
                loc1 = flash.filesystem.File.applicationStorageDirectory.resolvePath("app-debug.log");
            }
            log = new flash.filesystem.File(loc1.nativePath);
            return;
        }

        public function get logURI():String
        {
            return log.url;
        }

        public static function setCustomFilePath(arg1:String):void
        {
            CUSTOM_FILE_PATH = arg1;
            useCustomPath = true;
            _instance = null;
            return;
        }

        public function clear():void
        {
            var loc1:*=new flash.filesystem.FileStream();
            loc1.open(log, "write");
            loc1.writeUTFBytes("");
            loc1.close();
            return;
        }

        internal function write(arg1:String):void
        {
            if (!false) 
            {
                return;
            }
            var loc1:*=new flash.filesystem.FileStream();
            loc1.open(log, "append");
            loc1.writeUTFBytes(arg1 + flash.filesystem.File.lineEnding);
            loc1.close();
            return;
        }

        public static function getInstance():debug.Debug
        {
            if (!_instance) 
            {
                _instance = new Debug();
            }
            return _instance;
        }

        public static function error(arg1:String):void
        {
            logline("ERROR", arg1);
            return;
        }

        public static function addlog(arg1:String):void
        {
            logline("DEBUG", arg1);
            return;
        }

        public static function debug(arg1:String):void
        {
            logline("DEBUG", arg1);
            return;
        }

        public static function database(arg1:String):void
        {
            logline("DATABASE", arg1);
            return;
        }

        public static function usb(arg1:String):void
        {
            logline("USB", arg1);
            return;
        }

        public static function ble(arg1:String):void
        {
            logline("BLE", arg1);
            return;
        }

        public static function nfc(arg1:String):void
        {
            logline("NFC", arg1);
            return;
        }

        public static function info(arg1:String):void
        {
            logline("INFO", arg1);
            return;
        }

        public static function warning(arg1:String):void
        {
            logline("WARNING", arg1);
            return;
        }

        public static function cloud(arg1:String):void
        {
            logline("CLOUD", arg1);
            return;
        }

        internal static function logline(arg1:String, arg2:String):void
        {
            var loc2:*=null;
            var loc4:*=null;
            var loc6:*=null;
            var loc9:*=null;
            var loc3:*=null;
            var loc1:*=null;
            var loc8:*=null;
            var loc5:*=null;
            if (!DEBUG) 
            {
                return;
            }
            if (!_instance) 
            {
                _instance = new Debug();
            }
            var loc7:*=flash.system.Worker.current.isPrimordial ? "MainThread" : "Worker";
            if (verifyThread(loc7) && verifyType(arg1)) 
            {
                loc2 = "";
                loc9 = (loc6 = (loc4 = new Error()).getStackTrace()).split("\n");
                loc3 = [];
                if (loc9.hasOwnProperty(3)) 
                {
                    loc3.insertAt(0, (loc9[3].slice(4, loc9[3].length).split("()")[0] as String).split("::")[1] + "()");
                    if (DEBUG_DEEP && loc9.hasOwnProperty(4)) 
                    {
                        loc3.insertAt(0, (loc9[4].slice(4, loc9[4].length).split("()")[0] as String).split("::")[1] + "()");
                    }
                    if ((loc3[0] as String).indexOf("LanguageManager") >= 0 && loc9.hasOwnProperty(5)) 
                    {
                        loc3.insertAt(0, (loc9[5].slice(4, loc9[5].length).split("()")[0] as String).split("::")[1] + "()");
                    }
                }
                loc1 = new flash.globalization.DateTimeFormatter("i-default", "short", "none");
                loc8 = "dd.MM.yyyy HH:mm:ss";
                loc5 = "";
                loc1.setDateTimePattern(loc8);
                loc5 = "[" + loc1.format(new Date()) + "] " + sizeString(arg1, 8) + " ::: " + sizeString(loc7) + " ::: " + loc3.join(" -> ") + " -> " + arg2;
                trace(loc5);
                _instance.write(loc5);
            }
            return;
        }

        internal static function sizeString(arg1:String, arg2:uint=10):String
        {
            var loc1:*=arg1.length;
            while (loc1 < arg2) 
            {
                arg1 = arg1 + " ";
                ++loc1;
            }
            return arg1;
        }

        internal static function verifyThread(arg1:String):Boolean
        {
            return arg1 == "MainThread" && true || arg1 == "Worker" && false;
        }

        internal static function verifyType(arg1:String):Boolean
        {
            return arg1 == "DEBUG" && true || arg1 == "ERROR" && true || arg1 == "INFO" && true || arg1 == "WARNING" && true || arg1 == "CLOUD" && false || arg1 == "USB" && true || arg1 == "BLE" && true || arg1 == "NFC" && true || arg1 == "DATABASE" && false;
        }

        internal static const THREAD_MAINTHREAD:String="MainThread";

        internal static const THREAD_WORKER:String="Worker";

        internal static const TYPE_BLE:String="BLE";

        internal static const TYPE_CLOUD:String="CLOUD";

        internal static const TYPE_DATABASE:String="DATABASE";

        internal static const SHOW_DEBUG:Boolean=true;

        internal static const TYPE_ERROR:String="ERROR";

        internal static const TYPE_INFO:String="INFO";

        internal static const TYPE_NFC:String="NFC";

        internal static const TYPE_USB:String="USB";

        internal static const TYPE_WARNING:String="WARNING";

        internal static const WRITE_LOG_FILE:Boolean=false;

        public static const DEFAULT_FILENAME:String="app-debug.log";

        internal static const DEBUG:Boolean=flash.system.Capabilities.isDebugger;

        internal static const DEBUG_DEEP:Boolean=flash.system.Capabilities.isDebugger;

        internal static const SHOW_BLE:Boolean=true;

        internal static const SHOW_CLOUD:Boolean=false;

        internal static const SHOW_DATABASE:Boolean=false;

        internal static const SHOW_ERROR:Boolean=true;

        internal static const TYPE_DEBUG:String="DEBUG";

        internal static const SHOW_INFO:Boolean=true;

        internal static const SHOW_MAINTHREAD:Boolean=true;

        internal static const SHOW_NFC:Boolean=true;

        internal static const SHOW_USB:Boolean=true;

        internal static const SHOW_WARNING:Boolean=true;

        internal static const SHOW_WORKER:Boolean=false;

        internal static var CUSTOM_FILE_PATH:String="";

        internal var log:flash.filesystem.File;

        internal static var _instance:debug.Debug;

        internal static var useCustomPath:Boolean=false;
    }
}


