//package events
//  class ApplicationStateChangedEvent
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


//  class NotificationServiceControllerEvent
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


//  class NotificationStatusChangedEvent
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


