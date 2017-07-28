//package notificationlistenerservice
//  package debug
//    class Debug
package de.pagecon.ane.notificationlistenerservice.debug 
{
    import flash.globalization.*;
    
    public class Debug extends Object
    {
        public function Debug()
        {
            super();
            return;
        }

        public static function addlog(... rest):void
        {
            var loc8:*=0;
            if (!DEBUG_MODE) 
            {
                return;
            }
            var loc2:*="";
            var loc3:*="";
            var loc5:*="";
            var loc1:*="";
            var loc7:*="";
            var loc4:*="";
            var loc11:*;
            var loc12:*;
            var loc6:*;
            if ((loc6 = (loc12 = (loc11 = new Error()).getStackTrace()).split("\n")).hasOwnProperty(2)) 
            {
                loc1 = (loc3 = loc6[2].slice(4, loc6[2].length)).split("/")[0] + " ::: ";
                loc4 = loc3.split("()")[0] + "() -> ";
                if (loc6.hasOwnProperty(3)) 
                {
                    loc2 = loc6[3].slice(4, loc6[3].length);
                    loc5 = loc2.split("/")[0] + " ::: ";
                    loc7 = loc2.split("()")[0] + "() -> ";
                }
            }
            var loc9:*=new flash.globalization.DateTimeFormatter("i-default", "short", "none");
            var loc10:*="HH:mm:ss";
            loc9.setDateTimePattern(loc10);
            loc8 = 0;
            while (loc8 < rest.length) 
            {
                trace("[" + loc9.format(new Date()) + "] [NOTIFICATION LISTENER SERVICE ANE] ::: " + loc7 + loc4 + rest[loc8].toString());
                ++loc8;
            }
            return;
        }

        public static var DEBUG_MODE:Boolean=true;
    }
}


//  package events
//    class ApplicationStateChangedEvent
package de.pagecon.ane.notificationlistenerservice.events 
{
    import flash.events.*;
    
    public class ApplicationStateChangedEvent extends flash.events.Event
    {
        public function ApplicationStateChangedEvent(arg1:String, arg2:String, arg3:String)
        {
            super(arg1, bubbles, cancelable);
            this.activityName = arg3;
            var loc1:*=arg2;
            while ("create" === loc1) 
            {
                this.state = arg2;
            }
        }

        public override function clone():flash.events.Event
        {
            return new de.pagecon.ane.notificationlistenerservice.events.ApplicationStateChangedEvent(type, state, activityName);
        }

        public override function toString():String
        {
            return "[ApplicationStateChangedEvent] " + type + "\t\t" + JSON.stringify(this);
        }

        public static const APPLICATION_STATE_CREATE:String="create";

        public static const APPLICATION_STATE_DESTROY:String="destroy";

        public static const APPLICATION_STATE_PAUSE:String="pause";

        public static const APPLICATION_STATE_RESUME:String="resume";

        public static const APPLICATION_STATE_SAVEINSTANCE:String="saveinstance";

        public static const APPLICATION_STATE_START:String="start";

        public static const APPLICATION_STATE_STOP:String="stop";

        public static const APPLICATION_STATE_UNKNOWN:String="unknown";

        public var activityName:String;

        public var state:String;
    }
}


//    class NotificationServiceControllerEvent
package de.pagecon.ane.notificationlistenerservice.events 
{
    import flash.events.*;
    
    public class NotificationServiceControllerEvent extends flash.events.Event
    {
        public function NotificationServiceControllerEvent(arg1:String, arg2:Object=null, arg3:Boolean=false, arg4:Boolean=false)
        {
            super(arg1, arg3, arg4);
            this.optionalParameters = arg2;
            var loc2:*=0;
            var loc1:*=params.length;
            if (optionalParameters != null) 
            {
                while (loc2 < loc1) 
                {
                    if (optionalParameters.hasOwnProperty(params[loc2]) && this.hasOwnProperty(params[loc2])) 
                    {
                        this[params[loc2]] = optionalParameters[params[loc2]];
                    }
                    ++loc2;
                }
            }
            return;
        }

        public override function toString():String
        {
            return "[NotificationServiceControllerEvent] " + type + "\t\t" + JSON.stringify(this);
        }

        
        {
            params = new Array("id", "tickerText", "infoText", "subText", "extraTextLines", "summaryText", "title", "titleBig", "text", "textBig", "packageName", "postTime", "tag", "groupKey", "group", "sdk", "category", "errorCode", "errorMessage");
        }

        public override function clone():flash.events.Event
        {
            return new de.pagecon.ane.notificationlistenerservice.events.NotificationServiceControllerEvent(type, optionalParameters, bubbles, cancelable);
        }

        public static const PARAM_NAME_ERROR_MESSAGE:String="errorMessage";

        public static const PARAM_NAME_NOTIFICATION_CATEGORY:String="category";

        public static const PARAM_NAME_NOTIFICATION_EXTRA_TEXT_LINES:String="extraTextLines";

        public static const PARAM_NAME_NOTIFICATION_GROUPKEY:String="groupKey";

        public static const PARAM_NAME_NOTIFICATION_GROUP:String="group";

        public static const PARAM_NAME_NOTIFICATION_ID:String="id";

        public static const PARAM_NAME_NOTIFICATION_INFO_TEXT:String="infoText";

        public static const PARAM_NAME_NOTIFICATION_MESSAGE:String="tickerText";

        public static const PARAM_NAME_NOTIFICATION_PACKAGENAME:String="packageName";

        public static const PARAM_NAME_NOTIFICATION_SDK:String="sdk";

        public static const PARAM_NAME_NOTIFICATION_SUB_TEXT:String="subText";

        public static const PARAM_NAME_NOTIFICATION_SUMMARY_TEXT:String="summaryText";

        public static const PARAM_NAME_NOTIFICATION_TAG:String="tag";

        public static const PARAM_NAME_NOTIFICATION_TEXT_BIG:String="textBig";

        public static const PARAM_NAME_NOTIFICATION_TITLE:String="title";

        public static const PARAM_NAME_NOTIFICATION_TITLE_BIG:String="titleBig";

        public static const PARAM_NAME_NOTIFICATION_TEXT:String="text";

        public static const PARAM_NAME_NOTIFICATION_POSTTIME:String="postTime";

        public static const PARAM_NAME_ERROR_CODE:String="errorCode";

        public var category:String;

        public var errorCode:uint;

        public var errorMessage:String;

        public var extraTextLines:String;

        public var groupKey:String;

        public var id:uint;

        public var optionalParameters:Object;

        public var packageName:String;

        public var postTime:uint;

        public var sdk:uint;

        public var subText:String;

        public var summaryText:String;

        public var tag:String;

        public var text:String;

        public var tickerText:String;

        public var title:String;

        public var titleBig:String;

        public var group:String;

        public static var params:Array;

        public var textBig:String;
    }
}


//    class NotificationStatusChangedEvent
package de.pagecon.ane.notificationlistenerservice.events 
{
    import flash.events.*;
    
    public class NotificationStatusChangedEvent extends flash.events.Event
    {
        public function NotificationStatusChangedEvent(arg1:String, arg2:Boolean, arg3:Boolean=false, arg4:Boolean=false)
        {
            super(arg1, arg3, arg4);
            this.notificationsEnabled = notificationsEnabled;
            return;
        }

        public override function clone():flash.events.Event
        {
            return new de.pagecon.ane.notificationlistenerservice.events.NotificationServiceControllerEvent(type, notificationsEnabled, bubbles, cancelable);
        }

        public override function toString():String
        {
            return "[NotificationStatusChangedEvent] " + type + "\t\t" + JSON.stringify(this);
        }

        public var notificationsEnabled:Boolean;
    }
}


//  class NotificationServiceController
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


