//package events
//  class GVFacebookEvent
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


//  class GVMailEvent
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


//  class GVShareEvent
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


//  class GVTwitterEvent
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


