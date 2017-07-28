//class ErrorLogging
package com.logging 
{
    import flash.desktop.*;
    import flash.events.*;
    import flash.filesystem.*;
    import flash.utils.*;
    
    public class ErrorLogging extends flash.events.EventDispatcher
    {
        public function ErrorLogging(arg1:flash.events.IEventDispatcher=null)
        {
            _targets = new flash.utils.Dictionary();
            super(arg1);
            threadType = flash.desktop.NativeApplication.nativeApplication.applicationDescriptor != null ? "MainThread" : "Worker    ";
            return;
        }

        public function removeTarget(arg1:Object):void
        {
            removeListener(arg1 as flash.events.IEventDispatcher);
            return;
        }

        internal function receiveMessage(arg1:com.logging.ErrorLoggingEvent):void
        {
            receiveMessageFromStaticFunction(arg1);
            return;
        }

        public function receiveMessageFromStaticFunction(arg1:com.logging.ErrorLoggingEvent, arg2:Boolean=true):void
        {
            if (arg2) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent(arg1.type, arg1.errorType, arg1.message, arg1.errorTarget));
            }
            var loc1:*=new Date();
            var loc2:*=(loc2 = (loc2 = "") + loc1.toDateString()) + (" - " + loc1.toTimeString());
            if (isFirstLogMessageAfterStart) 
            {
                loc2 = loc2 + ("\t- SoftwareRevision: " + softwareRevision);
                isFirstLogMessageAfterStart = false;
            }
            loc2 = (loc2 = (loc2 = (loc2 = loc2 + ("\t- Type: " + arg1.type)) + ("\t- ID Number:" + arg1.errorType.toString() + " \t")) + ("\t- Target (" + threadType + "): " + arg1.errorTarget)) + ("\t- Message:" + arg1.message);
            writeLogging(loc2);
            return;
        }

        internal function writeLogging(arg1:String):void
        {
            if (_loggingMode != "off") 
            {
                if (_loggingMode == "offline") 
                {
                    if (2 >= com.logging.ErrorLogging.getInstance().logLevel) 
                    {
                        trace(arg1);
                    }
                    saveOnFileSystem(arg1);
                }
            }
            else 
            {
                trace(arg1);
            }
            return;
        }

        internal function saveOnFileSystem(arg1:String):void
        {
            var loc2:*=null;
            if (errorMessage.length > 0) 
            {
                errorMessage = errorMessage + "\n";
            }
            errorMessage = errorMessage + arg1;
            if (!_loggingPath || !_filename) 
            {
                return;
            }
            var loc3:*=_loggingPath + "/" + _filename;
            var loc1:*=0;
            loc2 = new flash.filesystem.File(loc3 + loc1 + _fileExtension);
            while (loc2.exists && loc2.size >= _maxLoggingSize) 
            {
                loc2 = new flash.filesystem.File(loc3 + loc1 + _fileExtension);
                ++loc1;
            }
            var loc4:*;
            (loc4 = new flash.filesystem.FileStream()).addEventListener("ioError", saveLogIOError, false, 0, true);
            try 
            {
                loc4.open(loc2, "append");
                loc4.writeUTFBytes(errorMessage + "\r\n");
                loc4.close();
            }
            catch (e:Error)
            {
                return;
            }
            errorMessage = "";
            return;
        }

        internal function saveLogIOError(arg1:flash.events.IOErrorEvent):void
        {
            return;
        }

        public function get loggingMode():String
        {
            return _loggingMode;
        }

        public function set loggingMode(arg1:String):void
        {
            _loggingMode = arg1;
            return;
        }

        public static function getInstance():com.logging.ErrorLogging
        {
            if (_instance == null) 
            {
                _instance = new ErrorLogging();
            }
            return _instance;
        }

        public function set loggingPath(arg1:String):void
        {
            _loggingPath = arg1;
            return;
        }

        public function get loggingPath():String
        {
            return _loggingPath;
        }

        public function set filename(arg1:String):void
        {
            _filename = arg1;
            return;
        }

        public function get filename():String
        {
            return _filename;
        }

        public function set maxLoggingSize(arg1:uint):void
        {
            _maxLoggingSize = arg1;
            return;
        }

        public function get maxLoggingSize():uint
        {
            return _maxLoggingSize;
        }

        public function set logLevel(arg1:uint):void
        {
            if (arg1 != _logLevel) 
            {
                _logLevel = arg1;
                var loc3:*=0;
                var loc2:*=_targets;
                for (var loc1:* in loc2) 
                {
                    addListener(loc1 as flash.events.IEventDispatcher);
                }
            }
            return;
        }

        public function get logLevel():uint
        {
            return _logLevel;
        }

        public function set softwareRevision(arg1:String):void
        {
            _softwareRevision = arg1;
            return;
        }

        public function get softwareRevision():String
        {
            return _softwareRevision;
        }

        internal function addListener(arg1:flash.events.IEventDispatcher):void
        {
            var loc1:*=_logLevel;
            while (0 === loc1) 
            {
                arg1.addEventListener("loggingDebugEvent", receiveMessage, false, 0, true);
                arg1.addEventListener("loggingInfoEvent", receiveMessage, false, 0, true);
                arg1.addEventListener("loggingWarningEvent", receiveMessage, false, 0, true);
                arg1.addEventListener("loggingErrorEvent", receiveMessage, false, 0, true);
                arg1.addEventListener("loggingFatalEvent", receiveMessage, false, 0, true);
            }
        }

        internal function removeListener(arg1:flash.events.IEventDispatcher):void
        {
            arg1.removeEventListener("loggingDebugEvent", receiveMessage);
            arg1.removeEventListener("loggingInfoEvent", receiveMessage);
            arg1.removeEventListener("loggingWarningEvent", receiveMessage);
            arg1.removeEventListener("loggingErrorEvent", receiveMessage);
            arg1.removeEventListener("loggingFatalEvent", receiveMessage);
            return;
        }

        public function addTarget(arg1:Object):void
        {
            var loc1:*=null;
            if (arg1 is flash.events.IEventDispatcher) 
            {
                loc1 = arg1 as flash.events.IEventDispatcher;
                if (loc1 in _targets == false) 
                {
                    dicCounter = (dicCounter + 1);
                    _targets[loc1] = dicCounter;
                    addListener(loc1);
                }
            }
            else 
            {
                throw Error(arg1.toString() + " is not IEventDispatcher");
            }
            return;
        }

        public static const LOGGING_MODE_OFFLINE:String="offline";

        public static const LOGGING_MODE_ONLINE:String="online";

        public static const LOGGING_MODE_OFF:String="off";

        internal var _loggingPath:String;

        internal var _filename:String;

        internal var _fileExtension:String=".txt";

        internal var _maxLoggingSize:uint=1000000;

        internal var _logLevel:uint=0;

        internal var _targets:flash.utils.Dictionary;

        internal var _loggingMode:String="offline";

        internal var _softwareRevision:String="";

        internal var threadType:String="";

        internal var errorMessage:String="";

        internal static var _instance:com.logging.ErrorLogging;

        internal var dicCounter:uint=0;

        internal static var isFirstLogMessageAfterStart:Boolean=true;
    }
}


