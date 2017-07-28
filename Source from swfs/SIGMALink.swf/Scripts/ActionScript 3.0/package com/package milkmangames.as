//package milkmangames
//  package nativeextensions
//    package events
//      class GVFacebookEvent
package com.milkmangames.nativeextensions.events 
{
    import __AS3__.vec.*;
    import com.milkmangames.nativeextensions.*;
    import flash.events.*;
    import flash.utils.*;
    
    public class GVFacebookEvent extends flash.events.Event
    {
        public function GVFacebookEvent(arg1:String, arg2:String=null, arg3:Boolean=false, arg4:Boolean=false)
        {
            this.jsonData = arg2;
            super(arg1, arg3, arg4);
            return;
        }

        public function get data():Object
        {
            var toUpper:String;
            var jsonClass:Class;

            var loc1:*;
            jsonClass = null;
            if (this._data != null) 
            {
                return this._data;
            }
            if (this.jsonData == null) 
            {
                return {};
            }
            toUpper = this.jsonData.toUpperCase();
            if (toUpper == "TRUE" || toUpper == "FALSE") 
            {
                var loc2:*=toUpper;
                switch (loc2) 
                {
                    case "TRUE":
                    {
                        this._data = true;
                        break;
                    }
                    case "FALSE":
                    {
                        this._data = false;
                        break;
                    }
                }
                return this._data;
            }
            try 
            {
                jsonClass = flash.utils.getDefinitionByName("JSON") as Class;
                if (jsonClass != null) 
                {
                    this._data = (loc2 = jsonClass)["parse"](this.jsonData);
                }
            }
            catch (e:Error)
            {
                this._data = {};
            }
            if (this._data["FACEBOOK_NON_JSON_RESULT"] != null) 
            {
                this._data = this._data["FACEBOOK_NON_JSON_RESULT"];
            }
            return this._data;
        }

        public function get friends():__AS3__.vec.Vector.<com.milkmangames.nativeextensions.GVFacebookFriend>
        {
            var list:__AS3__.vec.Vector.<com.milkmangames.nativeextensions.GVFacebookFriend>;
            var isForMe:Boolean;
            var isForFriends:Boolean;
            var friendData:Object;
            var inMe:Object;
            var me:com.milkmangames.nativeextensions.GVFacebookFriend;
            var friendArray:Array;
            var inFriend:Object;
            var nextFriend:com.milkmangames.nativeextensions.GVFacebookFriend;

            var loc1:*;
            list = null;
            inMe = null;
            me = null;
            friendArray = null;
            inFriend = null;
            nextFriend = null;
            list = new Vector.<com.milkmangames.nativeextensions.GVFacebookFriend>();
            if (this.data == null) 
            {
                return list;
            }
            trace("get friends my gp is \'" + this.graphPath + "\'");
            trace("mydata:" + this.jsonData);
            isForMe = false;
            if (this.graphPath != "me") 
            {
                if (this.graphPath.substring(this.graphPath.length - 3) == "/me") 
                {
                    isForMe = true;
                }
            }
            else 
            {
                isForMe = true;
            }
            if (isForMe) 
            {
                inMe = this.data;
                if (!inMe["id"]) 
                {
                    return list;
                }
                if (!inMe["name"]) 
                {
                    return list;
                }
                me = new com.milkmangames.nativeextensions.GVFacebookFriend(inMe["name"], inMe["id"], inMe);
                list.push(me);
                return list;
            }
            isForFriends = false;
            if (this.graphPath != "me/friends") 
            {
                if (this.graphPath.substr(this.graphPath.length - 11) == "/me/friends") 
                {
                    isForFriends = true;
                }
            }
            else 
            {
                isForFriends = true;
            }
            if (!isForFriends) 
            {
                return list;
            }
            friendData = this.data["data"];
            if (friendData == null) 
            {
                return list;
            }
            try 
            {
                friendArray = friendData as Array;
                loc2 = 0;
                var loc3:*=friendArray;
                for each (inFriend in loc3) 
                {
                    if (!inFriend["id"]) 
                    {
                        continue;
                    }
                    if (!inFriend["name"]) 
                    {
                        continue;
                    }
                    nextFriend = new com.milkmangames.nativeextensions.GVFacebookFriend(inFriend["name"], inFriend["id"], inFriend);
                    list.push(nextFriend);
                }
            }
            catch (e:Error)
            {
                return list;
            }
            return list;
        }

        public override function clone():flash.events.Event
        {
            var loc1:*=new com.milkmangames.nativeextensions.events.GVFacebookEvent(type, this.jsonData, bubbles, cancelable);
            loc1.graphPath = this.graphPath;
            loc1.dialogType = this.dialogType;
            loc1.errorCode = this.errorCode;
            loc1.permissions = this.permissions;
            loc1.errorMessage = this.errorMessage;
            loc1.graphPathQuery = this.graphPathQuery;
            loc1.jsonData = this.jsonData;
            loc1.shouldNotifyFacebookUser = this.shouldNotifyFacebookUser;
            loc1.appInviteURL = this.appInviteURL;
            return loc1;
        }

        public override function toString():String
        {
            return formatToString("GVFacebookEvent", "type", "graphPath", "dialogType", "bubbles", "cancelable", "eventPhase");
        }

        public static const FB_PUBLISH_PERMISSIONS_UPDATED:String="gvPublishPermUpdated";

        public static const FB_PUBLISH_PERMISSIONS_FAILED:String="gvPublishPermFailed";

        public static const FB_PERMISSIONS_REFRESHED:String="gvSessionPermRefreshed";

        public static const FB_PERMISSIONS_REFRESH_FAILED:String="gvSessionPermFailed";

        public static const FACEBOOK_REQUEST_DIALOG:String="apprequests";

        public static const FACEBOOK_FEED_DIALOG:String="feed";

        public static const FACEBOOK_SHARE_DIALOG:String="share";

        public static const FACEBOOK_MESSAGE_DIALOG:String="message";

        public static const FACEBOOK_GRAPH_DIALOG:String="graph";

        public static const FACEBOOK_APP_INVITE_DIALOG:String="appinvite";

        public static const FB_AD_ID_RESPONSE:String="gvFbAdIdResponse";

        public static const FB_APP_INVITE_OPENED:String="gvAppInviteOpened";

        public static const FB_LOGGED_IN:String="gvFacebookLoggedin";

        public static const FB_LOGGED_OUT:String="gvFacebookLoggedout";

        public static const FB_LOGIN_CANCELED:String="gvFacebookLoginCancelled";

        public static const FB_LOGIN_FAILED:String="gvFacebookLoginFailed";

        public static const FB_SESSION_INVALIDATED:String="gvFacebookSessionInvalidated";

        public static const FB_DIALOG_FINISHED:String="gvFbDialogFinished";

        public static const FB_DIALOG_CANCELED:String="gvFbDialogCancelled";

        public static const FB_DIALOG_FAILED:String="gvFbDialogFailed";

        public static const FB_REQUEST_RESPONSE:String="gvFbRawResponse";

        public static const FB_REQUEST_FAILED:String="gvFbRequestFailed";

        public static const FB_READ_PERMISSIONS_UPDATED:String="gvReadPermUpdated";

        public static const FB_READ_PERMISSIONS_FAILED:String="gvReadPermFailed";

        internal var _data:Object;

        public var jsonData:String;

        public var dialogType:String;

        public var graphPath:String;

        public var graphPathQuery:String;

        public var errorCode:int;

        public var errorMessage:String;

        public var shouldNotifyFacebookUser:Boolean;

        public var facebookUserErrorMessage:String;

        public var permissions:String;

        public var facebookMobileAdId:String;

        public var appInviteURL:String;
    }
}


//      class GVMailEvent
package com.milkmangames.nativeextensions.events 
{
    import flash.events.*;
    
    public class GVMailEvent extends flash.events.Event
    {
        public function GVMailEvent(arg1:String, arg2:Boolean=false, arg3:Boolean=false)
        {
            super(arg1, arg2, arg3);
            return;
        }

        public override function clone():flash.events.Event
        {
            return new com.milkmangames.nativeextensions.events.GVMailEvent(type, bubbles, cancelable);
        }

        public override function toString():String
        {
            return formatToString("GVMailEvent", "type", "bubbles", "cancelable", "eventPhase");
        }

        public static const MAIL_CANCELED:String="gvMailCancelled";

        public static const MAIL_SAVED:String="gvMailSaved";

        public static const MAIL_SENT:String="gvMailSent";

        public static const MAIL_FAILED:String="gvMailFailed";

        public var errorCode:int;

        public var errorMessage:String;
    }
}


//      class GVShareEvent
package com.milkmangames.nativeextensions.events 
{
    import flash.events.*;
    
    public class GVShareEvent extends flash.events.Event
    {
        public function GVShareEvent(arg1:String, arg2:Boolean=false, arg3:Boolean=false)
        {
            super(arg1, arg2, arg3);
            return;
        }

        public override function clone():flash.events.Event
        {
            return new com.milkmangames.nativeextensions.events.GVShareEvent(type, bubbles, cancelable);
        }

        public override function toString():String
        {
            return formatToString("GVShareEvent", "type", "bubbles", "cancelable", "eventPhase");
        }

        public static const GENERIC_MESSAGE_SHARED:String="gvGenericShared";

        public static const SOCIAL_COMPOSER_FINISHED:String="gvSocialFinished";

        public static const SOCIAL_COMPOSER_CANCELED:String="gvSocialCanceled";

        public var socialServiceType:String;
    }
}


//      class GVTwitterEvent
package com.milkmangames.nativeextensions.events 
{
    import flash.events.*;
    
    public class GVTwitterEvent extends flash.events.Event
    {
        public function GVTwitterEvent(arg1:String, arg2:Boolean=false, arg3:Boolean=false)
        {
            super(arg1, arg2, arg3);
            return;
        }

        public override function clone():flash.events.Event
        {
            return new com.milkmangames.nativeextensions.events.GVTwitterEvent(type, bubbles, cancelable);
        }

        public override function toString():String
        {
            return formatToString("GVTwitterEvent", "type", "bubbles", "cancelable", "eventPhase");
        }

        public static const TW_DIALOG_FINISHED:String="gvTwDialogFinished";

        public static const TW_DIALOG_CANCELED:String="gvTwDialogCancelled";

        public static const TW_DIALOG_FAILED:String="gvTwDialogFailed";

        public var errorCode:int;

        public var errorMessage:String;
    }
}


//    class GVDispatcher
package com.milkmangames.nativeextensions 
{
    import __AS3__.vec.*;
    import flash.events.*;
    
    public class GVDispatcher extends flash.events.EventDispatcher
    {
        public function GVDispatcher()
        {
            super();
            if (!_isCreating) 
            {
                throw new Error("Use an async method of GoViral.goViral to create a GVDispatcher..");
            }
            this.eventIDs = new Vector.<String>();
            return;
        }

        protected function addListener(arg1:String, arg2:Function):void
        {
            this.addEventListener(arg1, arg2, false, 0, false);
            this.eventIDs.push(arg1);
            return;
        }

        public override function dispatchEvent(arg1:flash.events.Event):Boolean
        {
            return super.dispatchEvent(arg1);
        }

        function removeListeners():void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=this.eventIDs;
            for each (loc1 in loc3) 
            {
                if (!this.hasEventListener(loc1)) 
                {
                    continue;
                }
                this.removeEventListener(loc1, this.listener);
            }
            this.listener = null;
            this.eventIDs.length = 0;
            return;
        }

        
        {
            _isCreating = false;
        }

        var requestID:String;

        protected var listener:Function;

        protected var eventIDs:__AS3__.vec.Vector.<String>;

        static var _isCreating:Boolean=false;
    }
}


//    class GVFacebookAppEvent
package com.milkmangames.nativeextensions 
{
    public class GVFacebookAppEvent extends Object
    {
        public function GVFacebookAppEvent(arg1:String)
        {
            super();
            this.eventName = arg1;
            this.valueToSum = NaN;
            this.params = null;
            return;
        }

        public function setValueToSum(arg1:Number):void
        {
            this.valueToSum = arg1;
            return;
        }

        public function setParameter(arg1:String, arg2:String):void
        {
            this.applyParam(arg1, arg2);
            return;
        }

        internal function applyParam(arg1:String, arg2:String):void
        {
            if (!this.params) 
            {
                this.params = {};
            }
            this.params[arg1] = arg2;
            return;
        }

        public static const EVENT_PARAM_DESCRIPTION:String="fb_description";

        public static const EVENT_PARAM_VALUE_YES:String="1";

        public static const EVENT_PARAM_VALUE_NO:String="0";

        public static const EVENT_NAME_ACTIVATED_APP:String="fb_mobile_activate_app";

        public static const EVENT_NAME_COMPLETED_REGISTRATION:String="fb_mobile_complete_registration";

        public static const EVENT_NAME_VIEWED_CONTENT:String="fb_mobile_content_view";

        public static const EVENT_NAME_SEARCHED:String="fb_mobile_search";

        public static const EVENT_NAME_RATED:String="fb_mobile_rate";

        public static const EVENT_NAME_COMPLETED_TUTORIAL:String="fb_mobile_tutorial_completion";

        public static const EVENT_NAME_ADDED_TO_CART:String="fb_mobile_add_to_cart";

        public static const EVENT_NAME_ADDED_TO_WISHLIST:String="fb_mobile_add_to_wishlist";

        public static const EVENT_NAME_INITIATED_CHECKOUT:String="fb_mobile_initiated_checkout";

        public static const EVENT_NAME_ADDED_PAYMENT_INFO:String="fb_mobile_add_payment_info";

        public static const EVENT_NAME_PURCHASED:String="fb_mobile_purchase";

        public static const EVENT_NAME_ACHIEVED_LEVEL:String="fb_mobile_level_achieved";

        public static const EVENT_NAME_UNLOCKED_ACHIEVEMENT:String="fb_mobile_achievement_unlocked";

        public static const EVENT_NAME_SPENT_CREDITS:String="fb_mobile_spent_credits";

        public static const EVENT_PARAM_CURRENCY:String="fb_currency";

        public static const EVENT_PARAM_REGISTRATION_METHOD:String="fb_registration_method";

        public static const EVENT_PARAM_CONTENT_TYPE:String="fb_content_type";

        public static const EVENT_PARAM_CONTENT_ID:String="fb_content_id";

        public static const EVENT_PARAM_SEARCH_STRING:String="fb_search_string";

        public static const EVENT_PARAM_SUCCESS:String="fb_success";

        public static const EVENT_PARAM_MAX_RATING_VALUE:String="fb_max_rating_value";

        public static const EVENT_PARAM_PAYMENT_INFO_AVAILABLE:String="fb_payment_info_available";

        public static const EVENT_PARAM_NUM_ITEMS:String="fb_num_items";

        public static const EVENT_PARAM_LEVEL:String="fb_level";

        var params:Object;

        var valueToSum:Number;

        var eventName:String;
    }
}


//    class GVFacebookDialogMode
package com.milkmangames.nativeextensions 
{
    public class GVFacebookDialogMode extends Object
    {
        public function GVFacebookDialogMode()
        {
            super();
            return;
        }

        static function enumerate(arg1:String):int
        {
            if (arg1 == AUTOMATIC) 
            {
                return 0;
            }
            if (arg1 == WEB) 
            {
                return 2;
            }
            if (arg1 == FEED) 
            {
                return 3;
            }
            if (arg1 == IOS_NATIVE) 
            {
                return 4;
            }
            return 0;
        }

        public static const AUTOMATIC:String="AUTOMATIC";

        public static const WEB:String="WEB";

        public static const FEED:String="FEED";

        public static const IOS_NATIVE:String="IOS_NATIVE";
    }
}


//    class GVFacebookDispatcher
package com.milkmangames.nativeextensions 
{
    import com.milkmangames.nativeextensions.events.*;
    
    public class GVFacebookDispatcher extends com.milkmangames.nativeextensions.GVDispatcher
    {
        public function GVFacebookDispatcher()
        {
            super();
            return;
        }

        public function addRequestListener(arg1:Function):com.milkmangames.nativeextensions.GVFacebookDispatcher
        {
            this.addListener(com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_REQUEST_RESPONSE, arg1);
            this.addListener(com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_REQUEST_FAILED, arg1);
            return this;
        }

        public function addDialogListener(arg1:Function):com.milkmangames.nativeextensions.GVFacebookDispatcher
        {
            this.addListener(com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_DIALOG_CANCELED, arg1);
            this.addListener(com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_DIALOG_FAILED, arg1);
            this.addListener(com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_DIALOG_FINISHED, arg1);
            return this;
        }

        public function addAdIdListener(arg1:Function):com.milkmangames.nativeextensions.GVFacebookDispatcher
        {
            this.addListener(com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_AD_ID_RESPONSE, arg1);
            return this;
        }
    }
}


//    class GVFacebookFriend
package com.milkmangames.nativeextensions 
{
    public class GVFacebookFriend extends Object
    {
        public function GVFacebookFriend(arg1:String, arg2:String, arg3:Object)
        {
            super();
            this.name = arg1;
            this.id = arg2;
            this.properties = arg3;
            return;
        }

        public function toString():String
        {
            return "GVFacebookFriend(name=\'" + this.name + "\',id=\'" + this.id + "\')";
        }

        public function getPropertyString(arg1:String):String
        {
            if (this.properties == null) 
            {
                return null;
            }
            if (this.properties[arg1] != null) 
            {
                if (this.properties[arg1] is String) 
                {
                    return this.properties[arg1];
                }
            }
            return null;
        }

        public function get gender():String
        {
            return this.getPropertyString("gender");
        }

        public function get link():String
        {
            return this.getPropertyString("link");
        }

        public function get installed():Boolean
        {
            if (this.properties == null) 
            {
                return false;
            }
            if (this.properties["installed"]) 
            {
                return true;
            }
            return false;
        }

        public function get locationName():String
        {
            var loc1:*=null;
            if (this.properties == null) 
            {
                return null;
            }
            if (this.properties["location"]) 
            {
                loc1 = this.properties["location"];
                return loc1["name"];
            }
            return null;
        }

        public function get bio():String
        {
            return this.getPropertyString("bio");
        }

        public function get about():String
        {
            return this.getPropertyString("about");
        }

        public function get email():String
        {
            return this.getPropertyString("email");
        }

        public var name:String;

        public var id:String;

        public var properties:Object;
    }
}


//    class GVFacebookRequestActionType
package com.milkmangames.nativeextensions 
{
    public class GVFacebookRequestActionType extends Object
    {
        public function GVFacebookRequestActionType()
        {
            super();
            return;
        }

        public static const SEND:String="send";

        public static const ASK_FOR:String="askfor";

        public static const TURN:String="turn";
    }
}


//    class GVFacebookRequestFilter
package com.milkmangames.nativeextensions 
{
    public class GVFacebookRequestFilter extends Object
    {
        public function GVFacebookRequestFilter()
        {
            super();
            return;
        }

        public static const APP_USERS:String="app_users";

        public static const APP_NON_USERS:String="app_non_users";
    }
}


//    class GVHttpMethod
package com.milkmangames.nativeextensions 
{
    public class GVHttpMethod extends Object
    {
        public function GVHttpMethod()
        {
            super();
            return;
        }

        public static const GET:String="GET";

        public static const POST:String="POST";

        public static const DELETE:String="DELETE";
    }
}


//    class GVMailDispatcher
package com.milkmangames.nativeextensions 
{
    import com.milkmangames.nativeextensions.events.*;
    
    public class GVMailDispatcher extends com.milkmangames.nativeextensions.GVDispatcher
    {
        public function GVMailDispatcher()
        {
            super();
            return;
        }

        public function addDialogListener(arg1:Function):com.milkmangames.nativeextensions.GVMailDispatcher
        {
            this.addListener(com.milkmangames.nativeextensions.events.GVMailEvent.MAIL_CANCELED, arg1);
            this.addListener(com.milkmangames.nativeextensions.events.GVMailEvent.MAIL_FAILED, arg1);
            this.addListener(com.milkmangames.nativeextensions.events.GVMailEvent.MAIL_SAVED, arg1);
            this.addListener(com.milkmangames.nativeextensions.events.GVMailEvent.MAIL_SENT, arg1);
            return this;
        }
    }
}


//    class GVShareDispatcher
package com.milkmangames.nativeextensions 
{
    import com.milkmangames.nativeextensions.events.*;
    
    public class GVShareDispatcher extends com.milkmangames.nativeextensions.GVDispatcher
    {
        public function GVShareDispatcher()
        {
            super();
            return;
        }

        public function addDialogListener(arg1:Function):com.milkmangames.nativeextensions.GVShareDispatcher
        {
            this.addListener(com.milkmangames.nativeextensions.events.GVShareEvent.GENERIC_MESSAGE_SHARED, arg1);
            this.addListener(com.milkmangames.nativeextensions.events.GVShareEvent.SOCIAL_COMPOSER_CANCELED, arg1);
            this.addListener(com.milkmangames.nativeextensions.events.GVShareEvent.SOCIAL_COMPOSER_FINISHED, arg1);
            return this;
        }
    }
}


//    class GVSocialServiceType
package com.milkmangames.nativeextensions 
{
    public class GVSocialServiceType extends Object
    {
        public function GVSocialServiceType()
        {
            super();
            return;
        }

        public static function decode(arg1:String):String
        {
            var loc1:*=arg1.toUpperCase();
            if (loc1.indexOf("FACEB") > -1) 
            {
                return FACEBOOK;
            }
            if (loc1.indexOf("TWITT") > -1) 
            {
                return TWITTER;
            }
            if (loc1.indexOf("SINA") > -1) 
            {
                return SINAWEIBO;
            }
            return arg1;
        }

        public static const TWITTER:String="TWITTER";

        public static const FACEBOOK:String="FACEBOOK";

        public static const SINAWEIBO:String="SINAWEIBO";

        public static const SMS:String="SMS";
    }
}


//    class GVTwitterDispatcher
package com.milkmangames.nativeextensions 
{
    import com.milkmangames.nativeextensions.events.*;
    
    public class GVTwitterDispatcher extends com.milkmangames.nativeextensions.GVDispatcher
    {
        public function GVTwitterDispatcher()
        {
            super();
            return;
        }

        public function addDialogListener(arg1:Function):com.milkmangames.nativeextensions.GVTwitterDispatcher
        {
            this.addListener(com.milkmangames.nativeextensions.events.GVTwitterEvent.TW_DIALOG_CANCELED, arg1);
            this.addListener(com.milkmangames.nativeextensions.events.GVTwitterEvent.TW_DIALOG_FAILED, arg1);
            this.addListener(com.milkmangames.nativeextensions.events.GVTwitterEvent.TW_DIALOG_FINISHED, arg1);
            return this;
        }
    }
}


//    class GoViral
package com.milkmangames.nativeextensions 
{
    import __AS3__.vec.*;
    import com.milkmangames.nativeextensions.events.*;
    import flash.desktop.*;
    import flash.display.*;
    import flash.events.*;
    import flash.external.*;
    import flash.utils.*;
    
    public class GoViral extends flash.events.EventDispatcher
    {
        public function GoViral(arg1:Function=null)
        {
            var logCallback:Function=null;

            var loc1:*;
            logCallback = arg1;
            super();
            if (!_isCreating) 
            {
                throw new Error("Use GoViral.create() instead of \'new GoViral()\'.");
            }
            this.logCallback = logCallback;
            this.initContext();
            this.dispatchers = new Vector.<com.milkmangames.nativeextensions.GVDispatcher>();
            try 
            {
                this.extContext.call("ffiInitGoViral");
            }
            catch (e:Error)
            {
                throw new Error("Error initializing GoViral protocol.");
                return;
            }
            this.isFacebookInitialized = false;
            return;
        }

        internal static function oneOfInt(arg1:int, arg2:Array):Boolean
        {
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=arg2;
            for each (loc1 in loc3) 
            {
                if (arg1 != loc1) 
                {
                    continue;
                }
                return true;
            }
            return false;
        }

        internal static function oneOf(arg1:String, arg2:Array):Boolean
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=arg2;
            for each (loc1 in loc3) 
            {
                if (arg1 != loc1) 
                {
                    continue;
                }
                return true;
            }
            return false;
        }

        internal static function inRange(arg1:Number, arg2:Number, arg3:Number):Boolean
        {
            if (arg1 < arg3 || arg1 > arg2) 
            {
                return false;
            }
            return true;
        }

        internal static function addToHash(arg1:Object, arg2:String, arg3:String):void
        {
            if (arg3 == null) 
            {
                return;
            }
            arg1[arg2] = arg3;
            return;
        }

        internal static function truncate(arg1:String, arg2:int):String
        {
            if (arg1 == null) 
            {
                return null;
            }
            var loc1:*=arg1.substr(0, arg2);
            trace("truncation result:" + loc1 + "=" + loc1.length);
            return loc1;
        }

        internal static function jsonEncodeObject(arg1:Object):String
        {
            var inObject:Object;
            var jsonOut:String;
            var jsonClass:Class;

            var loc1:*;
            jsonClass = null;
            inObject = arg1;
            if (inObject is String) 
            {
                return inObject as String;
            }
            if (inObject is Boolean) 
            {
                return inObject != true ? "0" : "1";
            }
            jsonOut = inObject + "";
            try 
            {
                jsonClass = flash.utils.getDefinitionByName("JSON") as Class;
                if (jsonClass != null) 
                {
                    jsonOut = (loc2 = jsonClass)["stringify"](inObject, null, "");
                }
            }
            catch (e:Error)
            {
                trace("parse error.");
            }
            return jsonOut;
        }

        
        {
            _isCreating = false;
        }

        public function dispose():void
        {
            _instance = null;
            this.extContext = null;
            return;
        }

        public function isEmailAvailable():Boolean
        {
            var loc1:*=this.extContext.call("ffiCanSendEmail") as Boolean;
            return loc1;
        }

        public function showEmailComposer(arg1:String, arg2:String, arg3:String, arg4:Boolean):com.milkmangames.nativeextensions.GVMailDispatcher
        {
            var loc1:*=this.getNextDispatcherRequestID();
            this.extContext.call("ffiShowEmailComposer", arg1, arg2, arg3, arg4, "", "", loc1);
            var loc2:*=this.queueDispatcherWithID(com.milkmangames.nativeextensions.GVMailDispatcher, loc1) as com.milkmangames.nativeextensions.GVMailDispatcher;
            return loc2;
        }

        public function showEmailComposerWithBitmap(arg1:String, arg2:String, arg3:String, arg4:Boolean, arg5:flash.display.BitmapData, arg6:String=null):com.milkmangames.nativeextensions.GVMailDispatcher
        {
            arg6 = arg6 || "picture";
            var loc1:*=this.getNextDispatcherRequestID();
            flash.utils.setTimeout(this.extContext.call, 50, "ffiShowEmailComposerWithBitmap", arg1, arg2, arg3, arg4, "", "", arg5, "image/jpeg", arg6, loc1);
            var loc2:*=this.queueDispatcherWithID(com.milkmangames.nativeextensions.GVMailDispatcher, loc1) as com.milkmangames.nativeextensions.GVMailDispatcher;
            return loc2;
        }

        public function showEmailComposerWithByteArray(arg1:String, arg2:String, arg3:String, arg4:Boolean, arg5:flash.utils.ByteArray, arg6:String, arg7:String):com.milkmangames.nativeextensions.GVMailDispatcher
        {
            var loc1:*=this.getNextDispatcherRequestID();
            flash.utils.setTimeout(this.extContext.call, 50, "ffiShowEmailComposerWithByteArray", arg1, arg2, arg3, arg4, "", "", arg5, arg6, arg7, loc1);
            var loc2:*=this.queueDispatcherWithID(com.milkmangames.nativeextensions.GVMailDispatcher, loc1) as com.milkmangames.nativeextensions.GVMailDispatcher;
            return loc2;
        }

        public function initFacebook(arg1:String, arg2:String=""):void
        {
            if (this.isFacebookInitialized) 
            {
                return;
            }
            this.extContext.call("ffiInitFacebook", arg1, arg2, false);
            this.facebookAppId = arg1;
            this.isFacebookInitialized = true;
            return;
        }

        public function isFacebookSupported():Boolean
        {
            var isSupported:Boolean;

            var loc1:*;
            isSupported = false;
            try 
            {
                isSupported = this.extContext.call("ffiIsFacebookSupported") as Boolean;
            }
            catch (e:Error)
            {
                isSupported = true;
            }
            return isSupported;
        }

        public function authenticateWithFacebook(arg1:String="public_profile"):void
        {
            arg1 = arg1.replace(" ", "");
            this.extContext.call("ffiAuthenticateWithFacebook", arg1, 0);
            return;
        }

        public function _authenticateWithFacebookForcingAlternateLoginBehavior(arg1:String="public_profile", arg2:int=0):void
        {
            arg1 = arg1.replace(" ", "");
            assertAsArgumentError(arg2 > -1 && arg2 < 5, "Value of loginBehavior must be one of GVFacebookLoginBehavior.NATIVE, GVFacebookLoginBehavior.WEB, GVFacebookLoginBehavior.SYSTEM_ACCOUNT,  or GVFacebookLoginBehavior.BROWSER.");
            this.extContext.call("ffiAuthenticateWithFacebook", arg1, arg2);
            return;
        }

        public function refreshFacebookSessionPermissions():void
        {
            var loc2:*=null;
            if (!this.isFacebookAuthenticated()) 
            {
                loc2 = new com.milkmangames.nativeextensions.events.GVFacebookEvent(com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_PERMISSIONS_REFRESH_FAILED);
                loc2.errorCode = -1;
                loc2.errorMessage = "You must authenticate before refreshing permissions.";
                dispatchEvent(loc2);
                return;
            }
            var loc1:*=this.extContext.call("ffiRefreshSessionPermissions", "0") as Boolean;
            return;
        }

        public function requestNewFacebookReadPermissions(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            if (!this.isFacebookAuthenticated()) 
            {
                loc2 = new com.milkmangames.nativeextensions.events.GVFacebookEvent(com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_READ_PERMISSIONS_FAILED);
                loc2.errorCode = -1;
                loc2.errorMessage = "You must authenticate before requesting new permissions.";
                dispatchEvent(loc2);
                return;
            }
            assert(!(arg1 == null), "Invalid permissions requested.");
            arg1 = arg1.replace(" ", "");
            assert(!(arg1 == ""), "Invalid permissions requested.");
            var loc1:*=this.extContext.call("ffiRequestNewReadPermissions", arg1) as Boolean;
            if (!loc1) 
            {
                loc3 = new com.milkmangames.nativeextensions.events.GVFacebookEvent(com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_READ_PERMISSIONS_UPDATED);
                loc3.permissions = arg1;
                flash.utils.setTimeout(this.dispatchEvent, 100, loc3);
            }
            return;
        }

        public function requestNewFacebookPublishPermissions(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            if (!this.isFacebookAuthenticated()) 
            {
                loc2 = new com.milkmangames.nativeextensions.events.GVFacebookEvent(com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_READ_PERMISSIONS_FAILED);
                loc2.errorCode = -1;
                loc2.errorMessage = "You must authenticate before requesting new permissions.";
                dispatchEvent(loc2);
                return;
            }
            assert(!(arg1 == null), "Invalid permissions requested.");
            arg1 = arg1.replace(" ", "");
            assert(!(arg1 == ""), "Invalid permissions requested.");
            var loc1:*=this.extContext.call("ffiRequestNewPublishPermissions", arg1) as Boolean;
            if (!loc1) 
            {
                loc3 = new com.milkmangames.nativeextensions.events.GVFacebookEvent(com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_PUBLISH_PERMISSIONS_UPDATED);
                loc3.permissions = arg1;
                flash.utils.setTimeout(this.dispatchEvent, 100, loc3);
            }
            return;
        }

        public function isFacebookAuthenticated():Boolean
        {
            return this.extContext.call("ffiIsFacebookAuthenticated") as Boolean;
        }

        public function getDeclinedFacebookPermissions():__AS3__.vec.Vector.<String>
        {
            var loc1:*=this.extContext.call("ffiGetDeclinedPermissions") as String;
            var loc2:*=Vector.<String>(loc1.split(","));
            return loc2;
        }

        public function isFacebookPermissionGranted(arg1:String):Boolean
        {
            trace("check granted " + arg1);
            var loc1:*=this.extContext.call("ffiIsPermissionGranted", arg1) as Boolean;
            trace("res " + loc1);
            return loc1;
        }

        public function logoutFacebook():void
        {
            this.extContext.call("ffiLogoutFacebook");
            return;
        }

        public function isFacebookMessageDialogAvailable():Boolean
        {
            var loc1:*=this.extContext.call("ffiIsFacebookMessageDialogAvailable", false) as Boolean;
            return loc1;
        }

        public function isFacebookAppInviteDialogAvailable():Boolean
        {
            var result:Boolean;

            var loc1:*;
            result = false;
            try 
            {
                result = this.extContext.call("ffiIsAppInviteDialogAvailable", false) as Boolean;
            }
            catch (e:Error)
            {
                return true;
            }
            return result;
        }

        public function showFacebookGraphDialog(arg1:String, arg2:String, arg3:String, arg4:String, arg5:String=null, arg6:flash.display.BitmapData=null, arg7:Object=null, arg8:Object=null):com.milkmangames.nativeextensions.GVFacebookDispatcher
        {
            var loc9:*=null;
            var loc10:*=null;
            var loc11:*=null;
            var loc12:*=null;
            var loc13:*=null;
            var loc14:*=null;
            var loc1:*=this.getNextDispatcherRequestID();
            var loc2:*=this.queueDispatcherWithID(com.milkmangames.nativeextensions.GVFacebookDispatcher, loc1) as com.milkmangames.nativeextensions.GVFacebookDispatcher;
            var loc3:*=arg7 == null ? {} : arg7;
            loc3["og:title"] = arg3;
            loc3["og:description"] = arg4;
            var loc4:*=arg8 == null ? {} : arg8;
            var loc5:*=flash.desktop.NativeApplication.nativeApplication.applicationDescriptor;
            var loc6:*=loc5.namespace();
            if (arg5 != null) 
            {
                loc3["og:url"] = arg5;
            }
            loc3 = loc3 != null ? loc3 : {};
            var loc7:*=[];
            var loc8:*=[];
            var loc15:*=0;
            var loc16:*=loc3;
            for (loc9 in loc16) 
            {
                loc7.push(loc9);
                loc13 = loc3[loc9];
                loc8.push(jsonEncodeObject(loc13));
            }
            loc10 = [];
            loc11 = [];
            loc15 = 0;
            loc16 = loc4;
            for (loc12 in loc16) 
            {
                loc10.push(loc12);
                loc14 = loc4[loc12];
                loc11.push(jsonEncodeObject(loc14));
            }
            this.extContext.call("ffiShowFacebookGraphDialog", loc7, loc8, loc10, loc11, arg1, arg2, arg6, loc1);
            return loc2;
        }

        public function showFacebookMessageDialog(arg1:String, arg2:String, arg3:String, arg4:String=null, arg5:String=null, arg6:Object=null):com.milkmangames.nativeextensions.GVFacebookDispatcher
        {
            var loc6:*=null;
            var loc7:*=null;
            var loc8:*=null;
            var loc9:*=null;
            var loc1:*=arg6 == null ? {} : arg6;
            loc1["name"] = arg1;
            loc1["caption"] = arg2;
            loc1["description"] = arg3;
            var loc2:*=flash.desktop.NativeApplication.nativeApplication.applicationDescriptor;
            var loc3:*=loc2.namespace();
            if (arg5 != null) 
            {
                loc1["picture"] = arg5;
            }
            if (arg4 != null) 
            {
                loc1["link"] = arg4;
            }
            loc1 = loc1 != null ? loc1 : {};
            var loc4:*=[];
            var loc5:*=[];
            var loc10:*=0;
            var loc11:*=loc1;
            for (loc6 in loc11) 
            {
                loc4.push(loc6);
                loc9 = loc1[loc6];
                loc5.push(jsonEncodeObject(loc9));
            }
            loc7 = this.getNextDispatcherRequestID();
            this.extContext.call("ffiShowFacebookMessageDialog", loc4, loc5, loc7);
            loc8 = this.queueDispatcherWithID(com.milkmangames.nativeextensions.GVFacebookDispatcher, loc7) as com.milkmangames.nativeextensions.GVFacebookDispatcher;
            return loc8;
        }

        public function showFacebookShareDialog(arg1:String, arg2:String, arg3:String=null, arg4:String=null, arg5:Object=null, arg6:String="AUTOMATIC"):com.milkmangames.nativeextensions.GVFacebookDispatcher
        {
            var loc6:*=null;
            var loc7:*=null;
            var loc8:*=null;
            var loc9:*=null;
            if (arg6 != com.milkmangames.nativeextensions.GVFacebookDialogMode.AUTOMATIC) 
            {
                assertArgs(arg6, [com.milkmangames.nativeextensions.GVFacebookDialogMode.AUTOMATIC, com.milkmangames.nativeextensions.GVFacebookDialogMode.FEED, com.milkmangames.nativeextensions.GVFacebookDialogMode.IOS_NATIVE, com.milkmangames.nativeextensions.GVFacebookDialogMode.WEB], "modeOverride parameter must be a valid member of GVFacebookDialogMode.");
            }
            if (arg5 is String) 
            {
                throw new Error("Params Object invalid- (should be Object not string.)");
            }
            var loc1:*=arg5 == null ? {} : arg5;
            loc1["title"] = arg1;
            loc1["description"] = arg2;
            var loc2:*=flash.desktop.NativeApplication.nativeApplication.applicationDescriptor;
            var loc3:*=loc2.namespace();
            if (arg4 != null) 
            {
                loc1["image"] = arg4;
            }
            if (arg3 != null) 
            {
                loc1["link"] = arg3;
            }
            loc1 = loc1 != null ? loc1 : {};
            var loc4:*=[];
            var loc5:*=[];
            var loc10:*=0;
            var loc11:*=loc1;
            for (loc6 in loc11) 
            {
                loc4.push(loc6);
                loc9 = loc1[loc6];
                loc5.push(jsonEncodeObject(loc9));
            }
            loc7 = this.getNextDispatcherRequestID();
            this.extContext.call("ffiShowFacebookShareDialog", loc4, loc5, loc7, com.milkmangames.nativeextensions.GVFacebookDialogMode.enumerate(arg6));
            loc8 = this.queueDispatcherWithID(com.milkmangames.nativeextensions.GVFacebookDispatcher, loc7) as com.milkmangames.nativeextensions.GVFacebookDispatcher;
            return loc8;
        }

        public function showFacebookGameRequestDialog(arg1:String, arg2:String=null, arg3:String=null, arg4:String=null, arg5:String=null, arg6:String=null, arg7:String=null, arg8:String=null, arg9:Boolean=false):com.milkmangames.nativeextensions.GVFacebookDispatcher
        {
            var loc6:*=null;
            var loc7:*=null;
            var loc8:*=null;
            var loc9:*=null;
            var loc10:*=0;
            var loc11:*=null;
            var loc12:*=null;
            if (arg4 != null) 
            {
                assertArgs(arg4, [com.milkmangames.nativeextensions.GVFacebookRequestFilter.APP_NON_USERS, com.milkmangames.nativeextensions.GVFacebookRequestFilter.APP_USERS], "Value of filters must be one of GVFacebookRequestFilter.APP_USERS, or GVFacebookRequestFilter.APP_NON_USERS.");
            }
            var loc1:*=this.getNextDispatcherRequestID();
            var loc2:*=this.queueDispatcherWithID(com.milkmangames.nativeextensions.GVFacebookDispatcher, loc1) as com.milkmangames.nativeextensions.GVFacebookDispatcher;
            if (!this.isFacebookAuthenticated()) 
            {
                loc7 = new com.milkmangames.nativeextensions.events.GVFacebookEvent(com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_DIALOG_FAILED);
                loc7.errorCode = -1;
                loc7.dialogType = com.milkmangames.nativeextensions.events.GVFacebookEvent.FACEBOOK_REQUEST_DIALOG;
                loc7.errorMessage = "You must authenticate before inviting friends.";
                this.delayedErrorDispatch(loc1, loc7);
                return loc2;
            }
            var loc3:*={};
            addToHash(loc3, "message", truncate(arg1, 255));
            addToHash(loc3, "title", truncate(arg2, 50));
            if (arg5 != null) 
            {
                addToHash(loc3, "to", arg5);
            }
            addToHash(loc3, "data", truncate(arg3, 255));
            if (arg7) 
            {
                assert(!(arg6 == null), "If objectID is set, actionType must also be set.");
            }
            if (arg6 == com.milkmangames.nativeextensions.GVFacebookRequestActionType.TURN) 
            {
                assert(!(arg5 == null), "If using TURN actionType, must set value of TO.");
                assert(arg7 == null, "ObjectID should not be set for the TURN actionType.");
            }
            if (arg6 == com.milkmangames.nativeextensions.GVFacebookRequestActionType.SEND || arg6 == com.milkmangames.nativeextensions.GVFacebookRequestActionType.ASK_FOR) 
            {
                assert(!(arg7 == null), "ObjectID must be set when using SEND or ASK_FOR actionType.");
            }
            if (arg6 != null) 
            {
                assertArgs(arg6, [com.milkmangames.nativeextensions.GVFacebookRequestActionType.ASK_FOR, com.milkmangames.nativeextensions.GVFacebookRequestActionType.SEND, com.milkmangames.nativeextensions.GVFacebookRequestActionType.TURN], "actionType must be one of GVFacebookRequestActionType.ASK_FOR, GVFacebookRequestActionType.SEND, or GVFacebookRequestActionType.TURN.");
                addToHash(loc3, "action_type", arg6);
                addToHash(loc3, "object_id", arg7);
            }
            if (arg4 != null) 
            {
                addToHash(loc3, "filters", arg4);
            }
            if (arg8) 
            {
                arg8 = arg8.split(" ").join("");
                loc8 = arg8.split(",");
                loc9 = [];
                loc10 = 0;
                while (loc10 < loc8.length) 
                {
                    loc12 = loc8[loc10];
                    loc12 = "\'" + loc12 + "\'";
                    loc9.push(loc12);
                    ++loc10;
                }
                loc11 = "[" + loc9.join(",") + "]";
                addToHash(loc3, "suggestions", loc11);
            }
            if (arg9) 
            {
                addToHash(loc3, "frictionless", "1");
            }
            loc3 = loc3 != null ? loc3 : {};
            var loc4:*=[];
            var loc5:*=[];
            var loc13:*=0;
            var loc14:*=loc3;
            for (loc6 in loc14) 
            {
                loc4.push(loc6);
                loc5.push(loc3[loc6]);
            }
            this.extContext.call("ffiShowFacebookRequestDialog", loc4, loc5, loc1);
            return loc2;
        }

        public function showFacebookAppInviteDialog(arg1:String, arg2:String=null):com.milkmangames.nativeextensions.GVFacebookDispatcher
        {
            var loc6:*=null;
            var loc1:*=this.getNextDispatcherRequestID();
            var loc2:*=this.queueDispatcherWithID(com.milkmangames.nativeextensions.GVFacebookDispatcher, loc1) as com.milkmangames.nativeextensions.GVFacebookDispatcher;
            var loc3:*={"appLinkURL":arg1};
            if (arg2 != null) 
            {
                loc3["previewImageURL"] = arg2;
            }
            var loc4:*=[];
            var loc5:*=[];
            var loc7:*=0;
            var loc8:*=loc3;
            for (loc6 in loc8) 
            {
                loc4.push(loc6);
                loc5.push(loc3[loc6]);
            }
            this.extContext.call("ffiShowFacebookAppInviteDialog", loc4, loc5, loc1);
            return loc2;
        }

        public function facebookGraphRequest(arg1:String, arg2:String="GET", arg3:Object=null, arg4:String=null):com.milkmangames.nativeextensions.GVFacebookDispatcher
        {
            var loc5:*=null;
            var loc6:*=null;
            var loc7:*=null;
            var loc1:*=this.getNextDispatcherRequestID();
            var loc2:*=this.queueDispatcherWithID(com.milkmangames.nativeextensions.GVFacebookDispatcher, loc1) as com.milkmangames.nativeextensions.GVFacebookDispatcher;
            assertArgs(arg2, [com.milkmangames.nativeextensions.GVHttpMethod.GET, com.milkmangames.nativeextensions.GVHttpMethod.POST, com.milkmangames.nativeextensions.GVHttpMethod.DELETE], "Argument \'httpMethod\' must be one of GVHttpMethod.GET, GVHttpMethod.POST, or GVHttpMethod.DELETE.");
            if (!this.isFacebookAuthenticated()) 
            {
                loc6 = new com.milkmangames.nativeextensions.events.GVFacebookEvent(com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_REQUEST_FAILED);
                loc6.errorCode = -1;
                loc6.errorMessage = "You must authenticate before calling the graph API.";
                loc6.graphPath = arg1;
                this.delayedErrorDispatch(loc1, loc6);
                return loc2;
            }
            arg4 = arg4 || "";
            arg3 = arg3 != null ? arg3 : {};
            var loc3:*=[];
            var loc4:*=[];
            var loc8:*=0;
            var loc9:*=arg3;
            for (loc5 in loc9) 
            {
                loc3.push(loc5);
                loc7 = arg3[loc5];
                loc4.push(jsonEncodeObject(loc7));
            }
            this.extContext.call("ffiFacebookGraphRequest", arg1, arg2, loc3, loc4, arg4, loc1, false);
            return loc2;
        }

        public function postFacebookHighScore(arg1:Number):com.milkmangames.nativeextensions.GVFacebookDispatcher
        {
            return this.facebookGraphRequest("me/scores", com.milkmangames.nativeextensions.GVHttpMethod.POST, {"score":arg1}, "publish_actions");
        }

        public function postFacebookAchievement(arg1:String):com.milkmangames.nativeextensions.GVFacebookDispatcher
        {
            return this.facebookGraphRequest("me/achievements", com.milkmangames.nativeextensions.GVHttpMethod.POST, {"achievement":arg1}, "publish_actions");
        }

        public function presentTwitterProfile(arg1:String):void
        {
            if (!arg1) 
            {
                return;
            }
            if (arg1 == "") 
            {
                return;
            }
            this.extContext.call("ffiPresentTwitterProfile", arg1);
            return;
        }

        public function presentFacebookPageOrProfile(arg1:String):void
        {
            if (!arg1) 
            {
                return;
            }
            if (arg1 == "") 
            {
                return;
            }
            this.extContext.call("ffiPresentFacebookProfileOrPage", arg1);
            return;
        }

        public function logFacebookAppEvent(arg1:com.milkmangames.nativeextensions.GVFacebookAppEvent):void
        {
            var loc7:*=null;
            var loc8:*=null;
            if (arg1 == null) 
            {
                return;
            }
            var loc1:*=arg1.params;
            var loc2:*=!(loc1 == null);
            var loc3:*=[];
            var loc4:*=[];
            if (loc2) 
            {
                var loc9:*=0;
                var loc10:*=loc1;
                for (loc7 in loc10) 
                {
                    loc3.push(loc7);
                    loc8 = loc1[loc7];
                    loc4.push(jsonEncodeObject(loc8));
                }
            }
            var loc5:*=false;
            var loc6:*=arg1.valueToSum;
            if (isNaN(loc6)) 
            {
                loc5 = false;
                loc6 = 0;
            }
            else 
            {
                loc5 = true;
            }
            this.extContext.call("ffiFacebookLogAppEvent", arg1.eventName, loc2, loc5, loc3, loc4, loc6);
            return;
        }

        public function requestFacebookMobileAdID():com.milkmangames.nativeextensions.GVFacebookDispatcher
        {
            var loc1:*=this.getNextDispatcherRequestID();
            this.extContext.call("ffiFacebookRequestAppUserID", loc1);
            var loc2:*=this.queueDispatcherWithID(com.milkmangames.nativeextensions.GVFacebookDispatcher, loc1) as com.milkmangames.nativeextensions.GVFacebookDispatcher;
            return loc2;
        }

        public function requestFacebookFriends(arg1:Object=null):com.milkmangames.nativeextensions.GVFacebookDispatcher
        {
            var loc1:*=null;
            if (arg1) 
            {
                if (arg1["fields"] != null) 
                {
                    loc1 = arg1["fields"];
                    arg1["fields"] = loc1 + ",name";
                }
                return this.facebookGraphRequest("me/friends", "GET", arg1);
            }
            return this.facebookGraphRequest("me/friends", "GET");
        }

        public function requestMyFacebookProfile(arg1:Array=null):com.milkmangames.nativeextensions.GVFacebookDispatcher
        {
            var loc1:*=null;
            var loc2:*=null;
            if (arg1 != null) 
            {
                loc1 = [];
                var loc3:*=0;
                var loc4:*=arg1;
                for each (loc2 in loc4) 
                {
                    if (!(loc2 is String)) 
                    {
                        continue;
                    }
                    loc1.push(loc2);
                }
                if (loc1.length > 0) 
                {
                    if (loc1.indexOf("name") == -1) 
                    {
                        loc1.push("name");
                    }
                    if (loc1.indexOf("gender") == -1) 
                    {
                        loc1.push("gender");
                    }
                    return this.facebookGraphRequest("me", "GET", {"fields":loc1.join(",")});
                }
            }
            return this.facebookGraphRequest("me", "GET", {"fields":"gender,name"});
        }

        public function facebookPostPhoto(arg1:String, arg2:flash.display.BitmapData, arg3:String="me/photos"):com.milkmangames.nativeextensions.GVFacebookDispatcher
        {
            var loc3:*=null;
            var loc1:*=this.getNextDispatcherRequestID();
            var loc2:*=this.queueDispatcherWithID(com.milkmangames.nativeextensions.GVFacebookDispatcher, loc1) as com.milkmangames.nativeextensions.GVFacebookDispatcher;
            if (!this.isFacebookAuthenticated()) 
            {
                loc3 = new com.milkmangames.nativeextensions.events.GVFacebookEvent(com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_REQUEST_FAILED);
                loc3.errorCode = -1;
                loc3.errorMessage = "You must authenticate before calling the graph API.";
                loc3.graphPath = arg3;
                this.delayedErrorDispatch(loc1, loc3);
                return loc2;
            }
            flash.utils.setTimeout(this.extContext.call, 100, "ffiFacebookPostPhoto", arg1, arg2, arg3, loc1, false);
            return loc2;
        }

        public function getFbAccessToken():String
        {
            var loc1:*=this.extContext.call("ffiGetAccessToken") as String;
            return loc1;
        }

        public function getFbAccessExpiry():Number
        {
            var loc1:*=this.extContext.call("ffiGetFbAccessExpiry") as Number;
            trace("exnum:" + loc1);
            var loc2:*=Math.floor(loc1 * 1000);
            trace("ms:" + loc2);
            return loc2;
        }

        public function isGenericShareAvailable():Boolean
        {
            return this.extContext.call("ffiIsGenericShareAvailable") as Boolean;
        }

        public function shareGenericMessage(arg1:String, arg2:String, arg3:Boolean, arg4:Number=380, arg5:Number=512):com.milkmangames.nativeextensions.GVShareDispatcher
        {
            var loc1:*=this.getNextDispatcherRequestID();
            var loc2:*=this.queueDispatcherWithID(com.milkmangames.nativeextensions.GVShareDispatcher, loc1) as com.milkmangames.nativeextensions.GVShareDispatcher;
            if (!this.isGenericShareAvailable()) 
            {
                return loc2;
            }
            this.extContext.call("ffiShareGeneric", arg1, arg2, arg3, arg4, arg5, loc1);
            return loc2;
        }

        public function shareGenericMessageWithImage(arg1:String, arg2:String, arg3:Boolean, arg4:flash.display.BitmapData, arg5:Number=380, arg6:Number=512, arg7:String=null):com.milkmangames.nativeextensions.GVShareDispatcher
        {
            var loc3:*=null;
            var loc4:*=0;
            var loc5:*=null;
            var loc1:*=this.getNextDispatcherRequestID();
            var loc2:*=this.queueDispatcherWithID(com.milkmangames.nativeextensions.GVShareDispatcher, loc1) as com.milkmangames.nativeextensions.GVShareDispatcher;
            if (!this.isGenericShareAvailable()) 
            {
                return loc2;
            }
            if (arg7 == null) 
            {
                arg7 = "";
            }
            else if (arg7.indexOf(".") != -1) 
            {
                loc3 = arg7.split(".");
                loc4 = loc3.length;
                loc5 = loc3[(loc4 - 1)];
                if (!(loc5.toLowerCase() == "jpg") && !(loc5.toLowerCase() == "jpeg")) 
                {
                    loc3.push("jpg");
                    arg7 = loc3.join(".");
                }
            }
            else 
            {
                arg7 = arg7 + ".jpg";
            }
            flash.utils.setTimeout(this.extContext.call, 50, "ffiShareGenericWithImage", arg1, arg2, arg3, arg4, arg5, arg6, loc1, arg7);
            return loc2;
        }

        public function showTweetSheet(arg1:String):com.milkmangames.nativeextensions.GVTwitterDispatcher
        {
            var loc1:*=this.getNextDispatcherRequestID();
            this.extContext.call("ffiShowTweetSheet", arg1, loc1);
            var loc2:*=this.queueDispatcherWithID(com.milkmangames.nativeextensions.GVTwitterDispatcher, loc1) as com.milkmangames.nativeextensions.GVTwitterDispatcher;
            return loc2;
        }

        public function showTweetSheetWithImage(arg1:String, arg2:flash.display.BitmapData):com.milkmangames.nativeextensions.GVTwitterDispatcher
        {
            var loc1:*=this.getNextDispatcherRequestID();
            flash.utils.setTimeout(this.extContext.call, 50, "ffiShowTweetSheetWithImage", arg1, arg2, loc1);
            var loc2:*=this.queueDispatcherWithID(com.milkmangames.nativeextensions.GVTwitterDispatcher, loc1) as com.milkmangames.nativeextensions.GVTwitterDispatcher;
            return loc2;
        }

        public function isTweetSheetAvailable():Boolean
        {
            return this.extContext.call("ffiIsTweetSheetAvailable");
        }

        public function displaySocialComposerView(arg1:String, arg2:String, arg3:flash.display.BitmapData=null, arg4:String=null, arg5:__AS3__.vec.Vector.<String>=null):com.milkmangames.nativeextensions.GVShareDispatcher
        {
            arg4 = arg4 || "";
            this.lastServiceType = arg1;
            var loc1:*="";
            if (!(arg5 == null) && arg1 == com.milkmangames.nativeextensions.GVSocialServiceType.SMS) 
            {
                loc1 = arg5.join(",");
            }
            var loc2:*=this.getNextDispatcherRequestID();
            flash.utils.setTimeout(this.extContext.call, 50, "ffiDisplaySocialView", arg1, arg2, arg3 != null ? true : false, arg3, arg4, loc2, loc1);
            var loc3:*=this.queueDispatcherWithID(com.milkmangames.nativeextensions.GVShareDispatcher, loc2) as com.milkmangames.nativeextensions.GVShareDispatcher;
            return loc3;
        }

        public function isSocialServiceAvailable(arg1:String):Boolean
        {
            var serviceType:String;

            var loc1:*;
            serviceType = arg1;
            try 
            {
                return this.extContext.call("ffiIsServiceAvailable", serviceType) as Boolean;
            }
            catch (e:Error)
            {
                return false;
            }
            return false;
        }

        internal function onExtStatus(arg1:flash.events.StatusEvent):void
        {
            var loc2:*=null;
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=null;
            this.log("SE:" + arg1.code + "/" + arg1.level);
            trace("make status");
            var loc1:*=arg1.code;
            if (loc1.indexOf("[[[GVRiD]]]") != -1) 
            {
                loc4 = loc1.split("[[[GVRiD]]]");
                loc5 = loc4[0];
                loc6 = loc4[1];
                arg1.code = loc6;
                trace("code is now:" + arg1.code);
                loc2 = this.dequeueDispatcherByRequestID(loc5);
            }
            var loc3:*=Status.eventFromStatusEvent(arg1);
            if (this.lastServiceType != null) 
            {
                if (loc3 is com.milkmangames.nativeextensions.events.GVShareEvent) 
                {
                    (loc3 as com.milkmangames.nativeextensions.events.GVShareEvent).socialServiceType = this.lastServiceType;
                    this.lastServiceType = null;
                }
            }
            trace("PRE/" + loc3 + "," + loc2);
            if (loc3 != null) 
            {
                if (loc2 != null) 
                {
                    loc2.dispatchEvent(loc3);
                }
            }
            if (loc3 != null) 
            {
                trace("do dispatch:" + loc3);
                dispatchEvent(loc3);
            }
            return;
        }

        internal function getNextDispatcherRequestID():String
        {
            var loc1:*;
            var loc2:*=((loc1 = this).dispatcherRequestIdIndex + 1);
            loc1.dispatcherRequestIdIndex = loc2;
            return this.dispatcherRequestIdIndex + "";
        }

        internal function dequeueDispatcherByRequestID(arg1:String):com.milkmangames.nativeextensions.GVDispatcher
        {
            var loc6:*=null;
            var loc1:*=-1;
            var loc2:*=this.dispatchers.length;
            var loc3:*=null;
            var loc4:*=-1;
            var loc5:*=0;
            while (loc5 < loc2) 
            {
                loc6 = this.dispatchers[loc5];
                if (loc6.requestID + "" == arg1) 
                {
                    loc3 = loc6;
                    loc1 = loc5;
                    break;
                }
                ++loc5;
            }
            if (loc1 != -1) 
            {
                trace("dQ ix=" + loc1 + ", DiD=" + loc3.requestID + " for " + arg1);
                this.dispatchers.splice(loc1, 1);
            }
            return loc3;
        }

        internal function queueDispatcherWithID(arg1:Class, arg2:String):com.milkmangames.nativeextensions.GVDispatcher
        {
            com.milkmangames.nativeextensions.GVDispatcher._isCreating = true;
            var loc1:*=null;
            var loc2:*=arg1;
            switch (loc2) 
            {
                case com.milkmangames.nativeextensions.GVFacebookDispatcher:
                {
                    loc1 = new com.milkmangames.nativeextensions.GVFacebookDispatcher();
                    break;
                }
                case com.milkmangames.nativeextensions.GVShareDispatcher:
                {
                    loc1 = new com.milkmangames.nativeextensions.GVShareDispatcher();
                    break;
                }
                case com.milkmangames.nativeextensions.GVMailDispatcher:
                {
                    loc1 = new com.milkmangames.nativeextensions.GVMailDispatcher();
                    break;
                }
                case com.milkmangames.nativeextensions.GVTwitterDispatcher:
                {
                    loc1 = new com.milkmangames.nativeextensions.GVTwitterDispatcher();
                    break;
                }
                default:
                {
                    loc1 = null;
                    break;
                }
            }
            com.milkmangames.nativeextensions.GVDispatcher._isCreating = false;
            loc1.requestID = arg2;
            trace("Q DiD=" + arg2);
            this.dispatchers.push(loc1);
            return loc1;
        }

        internal function delayedErrorDispatch(arg1:String, arg2:flash.events.Event):void
        {
            flash.utils.setTimeout(this.delayedErrorDispatchInternal, 100, arg1, arg2);
            return;
        }

        internal function delayedErrorDispatchInternal(arg1:String, arg2:flash.events.Event):void
        {
            var loc1:*=this.dequeueDispatcherByRequestID(arg1);
            loc1.dispatchEvent(arg2);
            dispatchEvent(arg2);
            return;
        }

        internal function log(arg1:String):void
        {
            if (this.logCallback != null) 
            {
                this.logCallback(arg1);
            }
            return;
        }

        internal function initContext():void
        {
            var loc1:*;
            if (!this.extContext) 
            {
                try 
                {
                    this.extContext = flash.external.ExtensionContext.createExtensionContext("com.milkmangames.extensions.GoViral", "");
                }
                catch (e:Error)
                {
                    throw new Error("Could not create ExtensionContext");
                }
                if (this.extContext == null) 
                {
                    throw new Error("Failed creating GoViral Extension Context.");
                }
                else 
                {
                    this.extContext.addEventListener(flash.events.StatusEvent.STATUS, this.onExtStatus);
                }
            }
            return;
        }

        public static function isSupported():Boolean
        {
            return true;
        }

        public static function create():com.milkmangames.nativeextensions.GoViral
        {
            if (_instance != null) 
            {
                throw new Error("GoViral already initiated; use GoViral.goViral to get instance.");
            }
            _isCreating = true;
            _instance = new GoViral();
            _isCreating = false;
            return _instance;
        }

        public static function get goViral():com.milkmangames.nativeextensions.GoViral
        {
            if (_instance != null) 
            {
                return _instance;
            }
            throw new Error("GoViral not initialized; call GoViral.create() first.");
        }

        internal static function assert(arg1:Boolean, arg2:String):Boolean
        {
            if (arg1) 
            {
                return true;
            }
            throw new Error(arg2);
        }

        internal static function assertAsArgumentError(arg1:Boolean, arg2:String):Boolean
        {
            if (arg1) 
            {
                return true;
            }
            throw new ArgumentError(arg2);
        }

        internal static function assertArgs(arg1:String, arg2:Array, arg3:String):Boolean
        {
            if (oneOf(arg1, arg2)) 
            {
                return true;
            }
            throw new ArgumentError(arg3);
        }

        internal static function assertArgsInt(arg1:int, arg2:Array, arg3:String):Boolean
        {
            if (oneOfInt(arg1, arg2)) 
            {
                return true;
            }
            throw new ArgumentError(arg3);
        }

        public static const VERSION:String="5.5.1";

        internal var extContext:flash.external.ExtensionContext=null;

        internal var isFacebookInitialized:Boolean;

        public var logCallback:Function;

        internal var facebookAppId:String;

        internal var lastServiceType:String;

        internal var dispatchers:__AS3__.vec.Vector.<com.milkmangames.nativeextensions.GVDispatcher>;

        internal var dispatcherRequestIdIndex:int=0;

        internal static var _isCreating:Boolean=false;

        internal static var _instance:com.milkmangames.nativeextensions.GoViral;
    }
}

import com.milkmangames.nativeextensions.events.*;
import flash.display.*;
import flash.events.*;
import flash.external.*;
import flash.utils.*;


class AttachmentRequest extends Object
{
    public function AttachmentRequest(arg1:flash.external.ExtensionContext, arg2:String)
    {
        super();
        this.context = arg1;
        this.requestID = arg2;
        return;
    }

    public function execute():void
    {
        return;
    }

    protected var context:flash.external.ExtensionContext;

    protected var requestID:String;
}

class SocialComposerRequest extends AttachmentRequest
{
    public function SocialComposerRequest(arg1:flash.external.ExtensionContext, arg2:String, arg3:String, arg4:String, arg5:flash.display.BitmapData=null, arg6:String=null, arg7:String=null)
    {
        super(arg1, arg2);
        this.serviceType = arg3;
        this.message = arg4;
        this.image = arg5;
        this.url = arg6;
        this.recipientString = arg7;
        return;
    }

    public override function execute():void
    {
        super.execute();
        context.call("ffiDisplaySocialView", this.serviceType, this.message, this.image != null ? true : false, this.image, this.url, requestID, this.recipientString);
        this.context = null;
        this.serviceType = null;
        this.message = null;
        this.image = null;
        this.url = null;
        this.recipientString = null;
        return;
    }

    protected var serviceType:String;

    protected var message:String;

    protected var image:flash.display.BitmapData=null;

    protected var url:String=null;

    protected var recipientString:String;
}

class TweetImageRequest extends AttachmentRequest
{
    public function TweetImageRequest(arg1:flash.external.ExtensionContext, arg2:String, arg3:String, arg4:flash.display.BitmapData)
    {
        super(arg1, arg2);
        this.message = arg3;
        this.image = arg4;
        return;
    }

    public override function execute():void
    {
        super.execute();
        context.call("ffiShowTweetSheetWithImage", this.message, this.image, requestID);
        this.context = null;
        this.message = null;
        this.image = null;
        return;
    }

    public var message:String;

    public var image:flash.display.BitmapData;
}

class EmailByteArrayRequest extends AttachmentRequest
{
    public function EmailByteArrayRequest(arg1:flash.external.ExtensionContext, arg2:String, arg3:String, arg4:String, arg5:String, arg6:Boolean, arg7:flash.utils.ByteArray, arg8:String, arg9:String)
    {
        super(arg1, arg2);
        this.subject = arg3;
        this.toWhom = arg4;
        this.body = arg5;
        this.isBodyHtml = arg6;
        this.byteArray = arg7;
        this.mimeType = arg8;
        this.fileName = arg9;
        return;
    }

    public override function execute():void
    {
        super.execute();
        context.call("ffiShowEmailComposerWithByteArray", this.subject, this.toWhom, this.body, this.isBodyHtml, "", "", this.byteArray, this.mimeType, this.fileName, requestID);
        this.context = null;
        this.subject = null;
        this.toWhom = null;
        this.body = null;
        this.byteArray = null;
        this.mimeType = null;
        this.fileName = null;
        return;
    }

    public var subject:String;

    public var toWhom:String;

    public var body:String;

    public var isBodyHtml:Boolean;

    public var byteArray:flash.utils.ByteArray;

    public var mimeType:String;

    public var fileName:String;
}

class GenericImageRequest extends AttachmentRequest
{
    public function GenericImageRequest(arg1:flash.external.ExtensionContext, arg2:String, arg3:String, arg4:String, arg5:Boolean, arg6:flash.display.BitmapData, arg7:Number=380, arg8:Number=512, arg9:String=null)
    {
        super(arg1, arg2);
        this.subject = arg3;
        this.message = arg4;
        this.isHtml = arg5;
        this.image = arg6;
        this.popOverX = arg7;
        this.popoverY = arg8;
        this.filename = arg9;
        return;
    }

    public override function execute():void
    {
        super.execute();
        context.call("ffiShareGenericWithImage", this.subject, this.message, this.isHtml, this.image, this.popOverX, this.popoverY, requestID, this.filename);
        this.context = null;
        this.subject = null;
        this.message = null;
        this.image = null;
        this.filename = null;
        return;
    }

    public var subject:String;

    public var message:String;

    public var isHtml:Boolean;

    public var image:flash.display.BitmapData;

    public var popOverX:Number=300;

    public var popoverY:Number=512;

    public var filename:String=null;
}

class EmailBitmapRequest extends AttachmentRequest
{
    public function EmailBitmapRequest(arg1:flash.external.ExtensionContext, arg2:String, arg3:String, arg4:String, arg5:String, arg6:Boolean, arg7:flash.display.BitmapData, arg8:String)
    {
        super(arg1, arg2);
        this.subject = arg3;
        this.toWhom = arg4;
        this.body = arg5;
        this.isBodyHtml = arg6;
        this.bitmapData = arg7;
        this.imageFileName = arg8;
        return;
    }

    public override function execute():void
    {
        super.execute();
        trace("[AttachRequest] execute email with bitmap: " + this.subject + "," + this.toWhom + "," + this.body + "," + this.isBodyHtml + "," + this.bitmapData + "," + this.imageFileName + "," + requestID);
        context.call("ffiShowEmailComposerWithBitmap", this.subject, this.toWhom, this.body, this.isBodyHtml, "", "", this.bitmapData, "image/jpeg", this.imageFileName, requestID);
        this.context = null;
        this.subject = null;
        this.toWhom = null;
        this.body = null;
        this.imageFileName = null;
        return;
    }

    public var subject:String;

    public var toWhom:String;

    public var body:String;

    public var isBodyHtml:Boolean;

    public var bitmapData:flash.display.BitmapData;

    public var imageFileName:String;
}

class Status extends Object
{
    public function Status()
    {
        super();
        return;
    }

    internal static function getGraphPathFromUrl(arg1:String):String
    {
        var url:String;
        var ret:String;
        var bits:Array;
        var slice:String;

        var loc1:*;
        bits = null;
        slice = null;
        url = arg1;
        ret = "";
        if (url == null) 
        {
            trace("gp: no url");
            return ret;
        }
        if (url == "") 
        {
            trace("gp: empty url");
            return ret;
        }
        if (url.indexOf("facebook.com") == -1) 
        {
            return url;
        }
        try 
        {
            bits = url.split("facebook.com/");
            if (url.indexOf("facebook.com/v2") != -1) 
            {
                slice = url.substr(url.indexOf("facebook.com/v2"), 18);
                bits = url.split(slice);
            }
            if (bits[1].indexOf("?") == -1) 
            {
                trace("gp: no separator");
                ret = bits[1];
            }
            else 
            {
                ret = bits[1].split("?")[0];
            }
        }
        catch (e:Error)
        {
            trace("parsed url as raw graph path.");
            ret = url;
        }
        return ret;
    }

    internal static function getDialogPathFromUrl(arg1:String):String
    {
        var url:String;
        var ret:String;
        var jsonClass:Class;
        var resultObject:Object;
        var bits:Array;

        var loc1:*;
        jsonClass = null;
        resultObject = null;
        bits = null;
        url = arg1;
        trace("fromurl:" + url);
        ret = "";
        if (url == null) 
        {
            return ret;
        }
        if (url == "") 
        {
            return ret;
        }
        if (url.indexOf("gvDialogType") != -1) 
        {
            try 
            {
                jsonClass = flash.utils.getDefinitionByName("JSON") as Class;
                resultObject = (loc2 = jsonClass)["parse"](url);
                if (resultObject != null) 
                {
                    if (resultObject["gvDialogType"]) 
                    {
                        return resultObject["gvDialogType"] as String;
                    }
                }
            }
            catch (e:Error)
            {
                trace("Parse error gvdtype:" + e.message);
            }
        }
        try 
        {
            bits = url.split("facebook.com/dialog/");
            if (bits[1].indexOf("?") == -1) 
            {
                ret = bits[1];
            }
            else 
            {
                ret = bits[1].split("?")[0];
            }
        }
        catch (e:Error)
        {
            ret = "";
        }
        return ret;
    }

    public static function eventFromStatusEvent(arg1:flash.events.StatusEvent):flash.events.Event
    {
        var e:flash.events.StatusEvent;
        var gvEvent:com.milkmangames.nativeextensions.events.GVFacebookEvent;
        var bits:Array;
        var errMsg:String;
        var errCode:int;
        var dialogType:String;
        var graphPath:String;
        var mEvent:com.milkmangames.nativeextensions.events.GVMailEvent;
        var cleanObject:Object;
        var cleanString:String;
        var strJsonResult:String;
        var checkData:Object;
        var twEvent:com.milkmangames.nativeextensions.events.GVTwitterEvent;
        var adIdEvent:com.milkmangames.nativeextensions.events.GVFacebookEvent;
        var inviteEvent:com.milkmangames.nativeextensions.events.GVFacebookEvent;
        var jsonClass:Class;
        var resultObject:Object;
        var toAssembly:Array;
        var k:String;
        var fixed:String;
        var index:int;
        var rawError:Object;

        var loc1:*;
        gvEvent = null;
        bits = null;
        errMsg = null;
        errCode = 0;
        dialogType = null;
        graphPath = null;
        mEvent = null;
        cleanObject = null;
        cleanString = null;
        strJsonResult = null;
        checkData = null;
        twEvent = null;
        adIdEvent = null;
        inviteEvent = null;
        jsonClass = null;
        resultObject = null;
        toAssembly = null;
        k = null;
        fixed = null;
        index = 0;
        rawError = null;
        e = arg1;
        trace("event from status->:" + int(e.code));
        var loc2:*=int(e.code);
        switch (loc2) 
        {
            case MAIL_CANCELLED:
            {
                return new com.milkmangames.nativeextensions.events.GVMailEvent(com.milkmangames.nativeextensions.events.GVMailEvent.MAIL_CANCELED);
            }
            case MAIL_FAILED:
            {
                mEvent = new com.milkmangames.nativeextensions.events.GVMailEvent(com.milkmangames.nativeextensions.events.GVMailEvent.MAIL_FAILED);
                bits = e.level.split("[ERR]");
                errCode = parseInt(bits[0]);
                errMsg = bits[1];
                mEvent.errorCode = errCode;
                mEvent.errorMessage = errMsg;
                return mEvent;
            }
            case MAIL_SAVED:
            {
                return new com.milkmangames.nativeextensions.events.GVMailEvent(com.milkmangames.nativeextensions.events.GVMailEvent.MAIL_SAVED);
            }
            case MAIL_SENT:
            {
                return new com.milkmangames.nativeextensions.events.GVMailEvent(com.milkmangames.nativeextensions.events.GVMailEvent.MAIL_SENT);
            }
            case FB_LOGGED_IN:
            {
                return new com.milkmangames.nativeextensions.events.GVFacebookEvent(com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_LOGGED_IN);
            }
            case FB_LOGGED_OUT:
            {
                return new com.milkmangames.nativeextensions.events.GVFacebookEvent(com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_LOGGED_OUT);
            }
            case FB_LOGIN_CANCELLED:
            {
                return new com.milkmangames.nativeextensions.events.GVFacebookEvent(com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_LOGIN_CANCELED);
            }
            case FB_LOGIN_FAILED:
            {
                gvEvent = new com.milkmangames.nativeextensions.events.GVFacebookEvent(com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_LOGIN_FAILED);
                gvEvent = parseAuthErrorData(com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_LOGIN_FAILED, e);
                return gvEvent;
            }
            case FB_READ_PERMISSIONS_UPDATED:
            {
                gvEvent = new com.milkmangames.nativeextensions.events.GVFacebookEvent(com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_READ_PERMISSIONS_UPDATED);
                gvEvent.permissions = e.level;
                return gvEvent;
            }
            case FB_PUBLISH_PERMISSIONS_UPDATED:
            {
                gvEvent = new com.milkmangames.nativeextensions.events.GVFacebookEvent(com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_PUBLISH_PERMISSIONS_UPDATED);
                gvEvent.permissions = e.level;
                return gvEvent;
            }
            case FB_PUBLISH_PERMISSIONS_FAILED:
            {
                gvEvent = parseAuthErrorData(com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_PUBLISH_PERMISSIONS_FAILED, e);
                return gvEvent;
            }
            case FB_READ_PERMISSIONS_FAILED:
            {
                gvEvent = parseAuthErrorData(com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_READ_PERMISSIONS_FAILED, e);
                return gvEvent;
            }
            case FB_PERMISSIONS_REFRESHED:
            {
                gvEvent = new com.milkmangames.nativeextensions.events.GVFacebookEvent(com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_PERMISSIONS_REFRESHED);
                gvEvent.permissions = e.level;
                return gvEvent;
            }
            case FB_PERMISSIONS_REFRESH_FAILED:
            {
                gvEvent = parseAuthErrorData(com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_PERMISSIONS_REFRESH_FAILED, e);
                return gvEvent;
            }
            case FB_SESSION_INVALIDATED:
            {
                return new com.milkmangames.nativeextensions.events.GVFacebookEvent(com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_SESSION_INVALIDATED);
            }
            case FB_DIALOG_FINISHED:
            {
                cleanObject = {};
                cleanString = null;
                strJsonResult = e.level;
                try 
                {
                    jsonClass = flash.utils.getDefinitionByName("JSON") as Class;
                    resultObject = (loc2 = jsonClass)["parse"](strJsonResult);
                    if (resultObject != null) 
                    {
                        if (resultObject["gvDialogType"]) 
                        {
                            dialogType = getDialogPathFromUrl(resultObject["gvDialogType"]);
                        }
                        toAssembly = [];
                        loc2 = 0;
                        var loc3:*=resultObject;
                        for (k in loc3) 
                        {
                            if (k == "gvDialogType") 
                            {
                                continue;
                            }
                            fixed = k.replace("%5B", "[").replace("%5D", "]");
                            trace("replace reuslt is :" + fixed);
                            if (fixed.indexOf("to[") != -1) 
                            {
                                index = parseInt(fixed.split("to[")[1].split("]")[0]);
                                toAssembly[index] = resultObject[k];
                            }
                            cleanObject[fixed] = resultObject[k];
                        }
                        if (toAssembly.length > 0 && !cleanObject["to"]) 
                        {
                            cleanObject["to"] = toAssembly;
                        }
                        cleanString = (loc2 = jsonClass)["stringify"](cleanObject);
                    }
                }
                catch (e:Error)
                {
                    trace("Parse error.");
                }
                dialogType = dialogType || getDialogPathFromUrl(e.level);
                gvEvent = new com.milkmangames.nativeextensions.events.GVFacebookEvent(com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_DIALOG_FINISHED);
                gvEvent.jsonData = cleanString;
                gvEvent.dialogType = dialogType;
                return gvEvent;
            }
            case FB_DIALOG_CANCELLED:
            {
                dialogType = getDialogPathFromUrl(e.level);
                gvEvent = new com.milkmangames.nativeextensions.events.GVFacebookEvent(com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_DIALOG_CANCELED);
                gvEvent.dialogType = dialogType;
                return gvEvent;
            }
            case FB_DIALOG_FAILED:
            {
                gvEvent = new com.milkmangames.nativeextensions.events.GVFacebookEvent(com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_DIALOG_FAILED);
                bits = e.level.split("[ERR]");
                errCode = parseInt(bits[0]);
                trace("code:" + errCode);
                bits = bits[1].split("[URL]");
                errMsg = bits[0];
                trace("msg:" + errMsg);
                dialogType = bits[1];
                gvEvent.errorCode = errCode;
                gvEvent.errorMessage = errMsg;
                gvEvent.dialogType = dialogType;
                trace("do return fb_dialog_failed");
                return gvEvent;
            }
            case FB_REQUEST_RAW_RESPONSE:
            {
                trace("parse raw response.");
                bits = e.level.split("[URL]");
                gvEvent = new com.milkmangames.nativeextensions.events.GVFacebookEvent(com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_REQUEST_RESPONSE, bits[0]);
                checkData = gvEvent.data;
                if (checkData != null) 
                {
                    if (!(checkData is Boolean)) 
                    {
                        try 
                        {
                            rawError = checkData["error"];
                            if (rawError) 
                            {
                                gvEvent = new com.milkmangames.nativeextensions.events.GVFacebookEvent(com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_REQUEST_FAILED, bits[0]);
                                gvEvent.errorCode = 5000;
                                if (rawError["code"]) 
                                {
                                    gvEvent.errorCode = parseInt(rawError["code"]);
                                }
                                if (rawError["message"]) 
                                {
                                    gvEvent.errorMessage = rawError["message"];
                                }
                            }
                        }
                        catch (e:Error)
                        {
                            trace("raw event- no error.");
                        }
                    }
                }
                trace("Raw response in URL:" + bits[1]);
                gvEvent.graphPath = getGraphPathFromUrl(bits[1]);
                gvEvent.graphPathQuery = getQueryFromUrl(bits[1]);
                return gvEvent;
            }
            case FB_REQUEST_FAILED:
            {
                if (e.level != null) 
                {
                    if (e.level.indexOf("gvShouldNotify") != -1) 
                    {
                        gvEvent = parseAuthErrorData(com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_REQUEST_FAILED, e);
                        return gvEvent;
                    }
                }
                gvEvent = new com.milkmangames.nativeextensions.events.GVFacebookEvent(com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_REQUEST_FAILED);
                bits = e.level.split("[ERR]");
                errCode = parseInt(bits[0]);
                bits = bits[1].split("[URL]");
                errMsg = bits[0];
                graphPath = getGraphPathFromUrl(bits[1]);
                gvEvent.errorCode = errCode;
                gvEvent.errorMessage = errMsg;
                gvEvent.graphPath = graphPath;
                return gvEvent;
            }
            case TW_DIALOG_CANCELLED:
            {
                return new com.milkmangames.nativeextensions.events.GVTwitterEvent(com.milkmangames.nativeextensions.events.GVTwitterEvent.TW_DIALOG_CANCELED);
            }
            case TW_DIALOG_FAILED:
            {
                twEvent = new com.milkmangames.nativeextensions.events.GVTwitterEvent(com.milkmangames.nativeextensions.events.GVTwitterEvent.TW_DIALOG_FAILED);
                bits = e.level.split("[ERR]");
                errCode = parseInt(bits[0]);
                errMsg = bits[1];
                twEvent.errorCode = errCode;
                twEvent.errorMessage = errMsg;
                return twEvent;
            }
            case TW_DIALOG_FINISHED:
            {
                return new com.milkmangames.nativeextensions.events.GVTwitterEvent(com.milkmangames.nativeextensions.events.GVTwitterEvent.TW_DIALOG_FINISHED);
            }
            case GE_MESSAGE_SHARED:
            case ACTIVITY_VIEW_CLOSED:
            {
                return new com.milkmangames.nativeextensions.events.GVShareEvent(com.milkmangames.nativeextensions.events.GVShareEvent.GENERIC_MESSAGE_SHARED);
            }
            case SOCIAL_COMPOSER_CANCELLED:
            {
                return new com.milkmangames.nativeextensions.events.GVShareEvent(com.milkmangames.nativeextensions.events.GVShareEvent.SOCIAL_COMPOSER_CANCELED);
            }
            case SOCIAL_COMPOSER_FINISHED:
            {
                return new com.milkmangames.nativeextensions.events.GVShareEvent(com.milkmangames.nativeextensions.events.GVShareEvent.SOCIAL_COMPOSER_FINISHED);
            }
            case FB_APP_USER_ID_RESPONSE:
            {
                adIdEvent = new com.milkmangames.nativeextensions.events.GVFacebookEvent(com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_AD_ID_RESPONSE);
                adIdEvent.facebookMobileAdId = e.level != "" ? e.level : null;
                return adIdEvent;
            }
            case FB_APP_INVITE_OPENED:
            {
                inviteEvent = new com.milkmangames.nativeextensions.events.GVFacebookEvent(com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_APP_INVITE_OPENED);
                inviteEvent.appInviteURL = e.level;
                return inviteEvent;
            }
            default:
            {
                return null;
            }
        }
    }

    internal static function parseAuthErrorData(arg1:String, arg2:flash.events.StatusEvent):com.milkmangames.nativeextensions.events.GVFacebookEvent
    {
        var eventType:String;
        var e:flash.events.StatusEvent;
        var gvEvent:com.milkmangames.nativeextensions.events.GVFacebookEvent;
        var loginObject:Object;
        var shouldNotify:Boolean;
        var fbUserMsg:String;
        var errorId:int;
        var errorMsg:String;
        var url:String;
        var permissions:String;
        var pClass:Class;

        var loc1:*;
        pClass = null;
        eventType = arg1;
        e = arg2;
        gvEvent = new com.milkmangames.nativeextensions.events.GVFacebookEvent(eventType);
        loginObject = {};
        shouldNotify = false;
        fbUserMsg = null;
        errorId = -1;
        errorMsg = "";
        url = null;
        permissions = "";
        if (e.level.indexOf("gvShouldNotify") == -1) 
        {
            try 
            {
                errorId = int(e.level);
            }
            catch (e:Error)
            {
                trace("Parse error2.");
            }
        }
        else 
        {
            try 
            {
                pClass = flash.utils.getDefinitionByName("JSON") as Class;
                loginObject = (loc2 = pClass)["parse"](e.level);
                shouldNotify = loginObject["gvShouldNotify"] as Boolean;
                fbUserMsg = loginObject["gvUserMessage"] as String;
                errorId = loginObject["gvErrCode"] as int;
                errorMsg = loginObject["gvErr"] as String;
                if (loginObject["gvUrl"] != null) 
                {
                    url = loginObject["gvUrl"] as String;
                }
                if (loginObject["permissions"] != null) 
                {
                    permissions = loginObject["permissions"];
                }
            }
            catch (e:Error)
            {
                trace("Parse error.");
            }
        }
        gvEvent.errorCode = errorId;
        gvEvent.shouldNotifyFacebookUser = shouldNotify;
        gvEvent.errorMessage = errorMsg;
        gvEvent.facebookUserErrorMessage = fbUserMsg;
        gvEvent.permissions = permissions;
        if (url != null) 
        {
            try 
            {
                gvEvent.graphPath = getGraphPathFromUrl(url);
                gvEvent.graphPathQuery = getQueryFromUrl(url);
            }
            catch (e:Error)
            {
                trace("url invalid.");
            }
        }
        return gvEvent;
    }

    internal static function getQueryFromUrl(arg1:String):String
    {
        var url:String;
        var ret:String;
        var bits:Array;
        var slice:String;

        var loc1:*;
        bits = null;
        slice = null;
        url = arg1;
        ret = "";
        if (url == null) 
        {
            trace("qp: no url");
            return ret;
        }
        if (url == "") 
        {
            trace("qp: empty url");
            return ret;
        }
        if (url.indexOf("facebook.com") == -1) 
        {
            if (url.indexOf("?") != -1) 
            {
                try 
                {
                    ret = url.split("?")[1];
                }
                catch (e:Error)
                {
                    return "";
                }
            }
            return ret;
        }
        try 
        {
            bits = url.split("facebook.com/");
            if (url.indexOf("facebook.com/v2") != -1) 
            {
                slice = url.substr(url.indexOf("facebook.com/v2"), 18);
                bits = url.split(slice);
            }
            if (bits[1].indexOf("?") == -1) 
            {
                trace("qp: no separator");
                ret = "";
            }
            else 
            {
                ret = bits[1].split("?")[1];
            }
        }
        catch (e:Error)
        {
            trace("parsed url as raw graphpath");
            ret = "";
        }
        return ret;
    }

    public static const MAIL_CANCELLED:int=1;

    public static const MAIL_SAVED:int=2;

    public static const MAIL_SENT:int=3;

    public static const MAIL_FAILED:int=4;

    public static const FB_LOGGED_IN:int=5;

    public static const FB_LOGGED_OUT:int=6;

    public static const FB_LOGIN_CANCELLED:int=7;

    public static const FB_LOGIN_FAILED:int=8;

    public static const FB_DIALOG_FINISHED:int=9;

    public static const FB_DIALOG_CANCELLED:int=10;

    public static const FB_DIALOG_FAILED:int=11;

    public static const FB_REQUEST_RAW_RESPONSE:int=12;

    public static const FB_REQUEST_FAILED:int=13;

    public static const FB_SESSION_INVALIDATED:int=23;

    public static const TW_DIALOG_FINISHED:int=18;

    public static const TW_DIALOG_CANCELLED:int=19;

    public static const FB_READ_PERMISSIONS_UPDATED:int=300;

    public static const FB_READ_PERMISSIONS_FAILED:int=301;

    public static const FB_PUBLISH_PERMISSIONS_UPDATED:int=302;

    public static const FB_PUBLISH_PERMISSIONS_FAILED:int=303;

    public static const FB_PERMISSIONS_REFRESHED:int=304;

    public static const FB_PERMISSIONS_REFRESH_FAILED:int=305;

    public static const FB_APP_USER_ID_RESPONSE:int=420;

    public static const FB_APP_INVITE_OPENED:int=701;

    public static const GE_MESSAGE_SHARED:int=30;

    public static const ACTIVITY_VIEW_CLOSED:int=50;

    public static const SOCIAL_COMPOSER_FINISHED:int=51;

    public static const SOCIAL_COMPOSER_CANCELLED:int=52;

    public static const TW_DIALOG_FAILED:int=20;
}

