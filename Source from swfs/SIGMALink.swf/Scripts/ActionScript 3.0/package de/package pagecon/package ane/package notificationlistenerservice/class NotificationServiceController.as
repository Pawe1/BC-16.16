//class NotificationServiceController
package de.pagecon.ane.notificationlistenerservice 
{
    import __AS3__.vec.*;
    import de.pagecon.ane.notificationlistenerservice.debug.*;
    import de.pagecon.ane.notificationlistenerservice.events.*;
    import flash.events.*;
    import flash.external.*;
    
    public class NotificationServiceController extends flash.events.EventDispatcher
    {
        public function NotificationServiceController(arg1:flash.events.IEventDispatcher=null)
        {
            _blockedListeners = [];
            _listeners = new __AS3__.vec.Vector.<Array>();
            super(arg1);
            if (_shouldCreateInstance) 
            {
                de.pagecon.ane.notificationlistenerservice.debug.Debug.addlog("Please use NotificationServiceController.instance instead!");
                throw new Error("Please use NotificationServiceController.instance instead!");
                return;
            }
            try 
            {
                _extContext = flash.external.ExtensionContext.createExtensionContext("de.pagecon.ane.notificationlistenerservice", "notificationlistenerservice");
                if (_extContext == null) 
                {
                    de.pagecon.ane.notificationlistenerservice.debug.Debug.addlog("ExtensionContext is null");
                    throw new Error("ExtensionContext is null");
                }
                _extContext.addEventListener("status", onStatus);
            }
            catch (error:Error)
            {
                de.pagecon.ane.notificationlistenerservice.debug.Debug.addlog("error: " + error);
            }
            return;
        }

        public function set debugMode(arg1:Boolean):void
        {
            de.pagecon.ane.notificationlistenerservice.debug.Debug.DEBUG_MODE = arg1;
            if (_extContext != null) 
            {
                _extContext.call("setNotificationDebugMode", arg1);
            }
            return;
        }

        public function openSecuritySettings():void
        {
            if (_extContext != null) 
            {
                _extContext.call("openSecuritySettings");
            }
            return;
        }

        public function getNotificationsEnabled():Boolean
        {
            if (_extContext != null) 
            {
                return _extContext.call("getNotificationsEnabled");
            }
            return false;
        }

        public function getNativeAneVersion():uint
        {
            if (_extContext != null) 
            {
                return _extContext.call("getNativeAneVersion") as uint;
            }
            return 0;
        }

        internal function onStatus(arg1:flash.events.StatusEvent):void
        {
            var loc3:*=arg1.code;
            var loc1:*=arg1.level;
            var loc4:*=null;
            var loc2:*=null;
            if (loc1) 
            {
                loc4 = JSON.parse(loc1) as Object;
            }
            var loc5:*=loc3;
            while ("eventNotification" === loc5) 
            {
                loc2 = new de.pagecon.ane.notificationlistenerservice.events.NotificationServiceControllerEvent(loc3, loc4);
            }
        }

        internal function initialize():void
        {
            if (_extContext != null) 
            {
                _extContext.call("initialize");
            }
            return;
        }

        public override function addEventListener(arg1:String, arg2:Function, arg3:Boolean=false, arg4:int=0, arg5:Boolean=false):void
        {
            var loc1:*=0;
            while (loc1 < _listeners.length) 
            {
                if (_listeners[loc1][0] == arg1 && _listeners[loc1][1] == arg2) 
                {
                    return;
                }
                ++loc1;
            }
            _listeners.push(new Array(arg1, arg2));
            super.addEventListener(arg1, arg2, arg3, arg4, arg5);
            return;
        }

        public override function removeEventListener(arg1:String, arg2:Function, arg3:Boolean=false):void
        {
            var loc1:*=0;
            while (loc1 < _listeners.length) 
            {
                if (_listeners[loc1][0] == arg1 && _listeners[loc1][1] == arg2) 
                {
                    _listeners.removeAt(loc1);
                    super.removeEventListener(arg1, arg2, arg3);
                    return;
                }
                ++loc1;
            }
            return;
        }

        public function removeListeners():void
        {
            var loc1:*=null;
            var loc2:*=0;
            while (loc2 < _listeners.length) 
            {
                loc1 = _listeners[loc2][0] as String;
                if (_blockedListeners.indexOf(loc1) < 0) 
                {
                    removeEventListener(loc1, _listeners[loc2][1] as Function);
                }
                ++loc2;
            }
            return;
        }

        public static function get instance():de.pagecon.ane.notificationlistenerservice.NotificationServiceController
        {
            if (!_instance) 
            {
                _shouldCreateInstance = false;
                _instance = new NotificationServiceController();
                _instance.initialize();
            }
            return _instance;
        }

        public static const COMMAND_GET_NATIVE_ANE_VERSION:String="getNativeAneVersion";

        public static const COMMAND_GET_NOTIFICATIONS_ENABLED:String="getNotificationsEnabled";

        public static const COMMAND_INIT:String="initialize";

        public static const COMMAND_OPEN_SECURITY_SETTINGS:String="openSecuritySettings";

        public static const COMMAND_SET_DEBUG_MODE:String="setNotificationDebugMode";

        public static const EVENT_APPLICATION_STATE_CHANGED:String="eventApplicationStateChanged";

        public static const EVENT_NOTIFICATION:String="eventNotification";

        public static const EVENT_STATUS_CHANGED:String="eventNotificationStatusChanged";

        public static const FIELD_STATE_CHANGED_ACTIVITYNAME:String="activityName";

        public static const FIELD_STATE_CHANGED_STATE:String="state";

        internal var _blockedListeners:Array;

        internal var _extContext:flash.external.ExtensionContext;

        internal var _listeners:__AS3__.vec.Vector.<Array>;

        internal static var _instance:de.pagecon.ane.notificationlistenerservice.NotificationServiceController;

        internal static var _shouldCreateInstance:Boolean=true;
    }
}


