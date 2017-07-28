//class StravaOAuth
package backend.oauth 
{
    import __AS3__.vec.*;
    import com.adobe.serialization.json.*;
    import com.adobe.utils.*;
    import configCache.*;
    import core.strava.*;
    import debug.*;
    import extensions.*;
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;
    import frontend.components.popup.*;
    import frontend.components.popup.oauth.*;
    import service.oauth.*;
    import starling.events.*;
    import utils.*;
    
    public class StravaOAuth extends frontend.components.popup.oauth.CustomOAuth
    {
        public function StravaOAuth(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            className = "StravaOAuth";
            CLIENT_ID = "137";
            CLIENT_SECRET = "d08449db7b3e37ffda59344c44c7d674746514fd";
            REDIRECT_URI = "https://www.sigma-dc-control.com";
            SCOPE = "write";
            STATE = "mystate";
            LOGIN_URL = "https://www.strava.com/login";
            LOGOUT_URL = "https://www.strava.com/logout";
            LOGOUT_COMPLETE_URL = "https://www.strava.com/";
            AUTHORIZE_URL = "https://www.strava.com/oauth/authorize";
            TOKEN_URL = "https://www.strava.com/oauth/token";
            DEAUTHORIZE_URL = "https://www.strava.com/oauth/deauthorize";
            UPLOAD_URL = "https://www.strava.com/api/v3/uploads";
            REGISTER_URL = "https://www.strava.com/register";
            HOME_URL = "https://www.strava.com/";
            ACCOUNT_RECOVER = "https://www.strava.com/account/recover";
            DASHBOARD_URL = "https://www.strava.com/dashboard";
            addEventListener(service.oauth.CommonOAuth.LOGGED_IN, this.onStravaLoggedInStatusChanged);
            addEventListener(service.oauth.CommonOAuth.LOGGED_OUT, this.onStravaLoggedInStatusChanged);
            return;
        }

        internal function onLogoutComplete(arg1:flash.events.Event):void
        {
            removeEventListener(LOGGED_OUT_COMPLETE, this.onLogoutComplete);
            checkUserLogin();
            return;
        }

        public override function getCompleteHTTPStatus():int
        {
            return 201;
        }

        public override function getErrorMessage(arg1:int):String
        {
            var loc1:*=null;
            var loc2:*=arg1;
            switch (loc2) 
            {
                case 400:
                {
                    loc1 = utils.LanguageManager.getString("SHARING_STATUS_DUPLICATE_ERROR");
                    break;
                }
                default:
                {
                    loc1 = utils.LanguageManager.getString("SHARING_STATUS_GENERAL_ERROR");
                }
            }
            return loc1;
        }

        public static function getInstance():backend.oauth.StravaOAuth
        {
            if (_instance == null) 
            {
                _instance = new StravaOAuth();
            }
            _instance.popupTitle = utils.LanguageManager.getString("CLOUDVIEW.OAUTH_TITLE");
            _instance.label = utils.LanguageManager.getString("APPSETTINGS.KONTEN.STRAVA.TITLE");
            return _instance;
        }

        internal function onStravaLoggedInStatusChanged(arg1:flash.events.Event):void
        {
            var loc1:*=arg1.type;
            switch (loc1) 
            {
                case service.oauth.CommonOAuth.LOGGED_IN:
                {
                    this.loadAthlete();
                    break;
                }
                case service.oauth.CommonOAuth.LOGGED_OUT:
                {
                    configCache.ConfigCache.getInstance().setValue(backend.oauth.StravaOAuth.CONFIG_CACHE_IS_PREMIUM, false);
                    configCache.ConfigCache.getInstance().saveCache();
                    break;
                }
            }
            return;
        }

        protected override function checkAccessToken():Boolean
        {
            return false;
        }

        protected override function onWebViewLocationChange(arg1:starling.events.Event):void
        {
            super.onWebViewLocationChange(arg1);
            if (lastLocation.indexOf(REGISTER_URL) == -1) 
            {
                if (lastLocation != HOME_URL) 
                {
                    if (lastLocation != ACCOUNT_RECOVER) 
                    {
                        if (lastLocation == DASHBOARD_URL) 
                        {
                            checkUserLogin();
                            hideWebViewer();
                        }
                    }
                    else 
                    {
                        hideWebViewer();
                        flash.net.navigateToURL(new flash.net.URLRequest(ACCOUNT_RECOVER), "_blank");
                        if (loggedOut) 
                        {
                            dispatchEvent(new flash.events.Event(LOGGED_OUT));
                        }
                        else 
                        {
                            loggedOut = true;
                        }
                    }
                }
                else 
                {
                    hideWebViewer();
                    flash.net.navigateToURL(new flash.net.URLRequest(HOME_URL), "_blank");
                    if (loggedOut) 
                    {
                        dispatchEvent(new flash.events.Event(LOGGED_OUT));
                    }
                    else 
                    {
                        loggedOut = true;
                    }
                }
            }
            else 
            {
                hideWebViewer();
                flash.net.navigateToURL(new flash.net.URLRequest(REGISTER_URL), "_blank");
                if (loggedOut) 
                {
                    dispatchEvent(new flash.events.Event(LOGGED_OUT));
                }
                else 
                {
                    loggedOut = true;
                }
            }
            return;
        }

        public function loadSegments(arg1:Boolean=true):void
        {
            this._timeOutTimer = flash.utils.setTimeout(this.onTimeout, TIMEOUT);
            this.segmentsList = new Vector.<core.strava.StravaSegment>();
            this.segmentsLoaded = 0;
            var loc1:*=new flash.net.URLRequest(URL_RETREIVE_STARRED_SEGMENTS);
            loc1.method = flash.net.URLRequestMethod.GET;
            var loc2:*=new flash.net.URLVariables();
            loc2.access_token = backend.oauth.StravaOAuth.getInstance().accessToken;
            loc2.latlng = "[0,0]";
            loc2.activity_type = "1";
            loc2.limit = MAX_STRAVA_SEGMENTS + 1;
            loc1.data = loc2;
            var loc3:*=new extensions.ExtendedUrlLoader();
            loc3.extendedData = arg1;
            loc3.addEventListener(flash.events.Event.COMPLETE, this.onLoadStravaStarredComplete);
            loc3.addEventListener(flash.events.IOErrorEvent.IO_ERROR, this.onError);
            loc3.load(loc1);
            return;
        }

        internal function onLoadStravaStarredComplete(arg1:flash.events.Event):void
        {
            var loc3:*=0;
            var loc5:*=null;
            var loc6:*=null;
            var loc1:*=com.adobe.serialization.json.JSON.decode(arg1.target.data);
            var loc2:*=loc1.targets;
            var loc4:*=loc2.length;
            flash.utils.clearTimeout(this._timeOutTimer);
            if (loc4 > MAX_STRAVA_SEGMENTS) 
            {
                this._loadDetais = (arg1.currentTarget as extensions.ExtendedUrlLoader).extendedData as Boolean;
                loc4 = MAX_STRAVA_SEGMENTS;
            }
            loc3 = 0;
            while (loc3 < loc4) 
            {
                this._loadDetais = (arg1.currentTarget as extensions.ExtendedUrlLoader).extendedData as Boolean;
                loc5 = new core.strava.StravaSegment();
                loc5.fromObject(loc2[loc3].segment);
                loc5.compareTo = configCache.ConfigCache.getInstance().getValue(core.strava.StravaDataProvider.COMPARE_CONFIG_CACHE_OBJECT, core.strava.StravaDataProvider.COMPARE_TO_KOM);
                this.segmentsList.push(loc5);
                ++loc3;
            }
            if (loc6 == null) 
            {
                this.triggerStravaSegementsHeaderLoaded();
            }
            return;
        }

        internal function triggerStravaSegementsHeaderLoaded(arg1:flash.events.Event=null):void
        {
            dispatchEvent(new core.strava.StravaEvent(core.strava.StravaEvent.EVENT_LOAD_SEGMENTS_HEADER_DOWNLOADED, null, this.segmentsList.length));
            if (this._loadDetais == true) 
            {
                this.loadStravaSegmentDetails();
            }
            return;
        }

        internal function loadStravaSegmentDetails():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=0;
            var loc6:*=this.segmentsList.length;
            this.segmentsLoaded = 0;
            flash.utils.clearTimeout(this._timeOutTimer);
            this._timeOutTimer = flash.utils.setTimeout(this.onTimeout, TIMEOUT);
            while (loc5 < loc6) 
            {
                loc1 = this.segmentsList[loc5] as core.strava.StravaSegment;
                loc3 = new flash.net.URLVariables();
                loc3.access_token = backend.oauth.StravaOAuth.getInstance().accessToken;
                loc2 = new flash.net.URLRequest(URL_RETREIVE_SEGMENT + com.adobe.utils.StringUtil.trim(loc1.id.toString()));
                loc2.method = flash.net.URLRequestMethod.GET;
                loc2.data = loc3;
                loc3 = new flash.net.URLVariables();
                loc3.access_token = backend.oauth.StravaOAuth.getInstance().accessToken;
                loc3.per_page = 1;
                loc3.following = true;
                loc2 = new flash.net.URLRequest(URL_RETREIVE_SEGMENT_LEADERBORD.replace("{:id}", com.adobe.utils.StringUtil.trim(loc1.id.toString())));
                loc2.method = flash.net.URLRequestMethod.GET;
                loc2.data = loc3;
                loc4 = new extensions.ExtendedUrlLoader();
                loc4.extendedData = [loc1, core.strava.StravaSegment.FIELD_RIVAL_TIME];
                loc4.addEventListener(flash.events.Event.COMPLETE, this.onLoadStravaSegmentDetailLoaderComplete);
                loc4.addEventListener(flash.events.IOErrorEvent.IO_ERROR, this.onError);
                loc4.load(loc2);
                ++loc5;
            }
            return;
        }

        internal function onError(arg1:flash.events.ErrorEvent):void
        {
            debug.Debug.error("onError: " + (arg1 as flash.events.ErrorEvent).text);
            return;
        }

        internal function onLoadStravaSegmentComplete(arg1:core.strava.StravaSegment):void
        {
            flash.utils.clearTimeout(this._timeOutTimer);
            this._timeOutTimer = flash.utils.setTimeout(this.onTimeout, TIMEOUT);
            var loc1:*;
            var loc2:*=((loc1 = this).segmentsLoaded + 1);
            loc1.segmentsLoaded = loc2;
            dispatchEvent(new core.strava.StravaEvent(core.strava.StravaEvent.EVENT_LOAD_SINGLE_SEGMENT_DETAIL_COMPLETE, arg1));
            if (this.segmentsLoaded >= this.segmentsList.length) 
            {
                dispatchEvent(new core.strava.StravaEvent(core.strava.StravaEvent.EVENT_LOAD_SEGMENTS_COMPLETE));
                flash.utils.clearTimeout(this._timeOutTimer);
            }
            return;
        }

        internal function onLoadStravaSegmentDetailLoaderComplete(arg1:flash.events.Event):void
        {
            flash.utils.clearTimeout(this._timeOutTimer);
            this._timeOutTimer = flash.utils.setTimeout(this.onTimeout, TIMEOUT);
            var loc1:*=arg1.currentTarget as extensions.ExtendedUrlLoader;
            loc1.removeEventListener(flash.events.Event.COMPLETE, this.onLoadStravaSegmentDetailLoaderComplete);
            loc1.removeEventListener(flash.events.IOErrorEvent.IO_ERROR, this.onError);
            var loc2:*=com.adobe.serialization.json.JSON.decode(loc1.data) as Object;
            var loc3:*=(loc1.extendedData as Array)[0] as core.strava.StravaSegment;
            var loc4:*=(loc1.extendedData as Array)[1] as String;
            var loc5:*=(loc1.extendedData as Array)[2] as Array;
            var loc6:*=loc4;
            switch (loc6) 
            {
                case core.strava.StravaSegment.FIELD_RIVAL_TIME:
                {
                    loc3.rival_time = loc2.entries && loc2.entries.length > 0 && loc2.entries[0].elapsed_time ? loc2.entries[0].elapsed_time : 0;
                    break;
                }
            }
            if (loc3.rival_initialized) 
            {
                this.onLoadStravaSegmentComplete(loc3);
            }
            return;
        }

        public function onTimeout(arg1:flash.events.Event=null):void
        {
            return;
        }

        public function loadAthlete():void
        {
            this._timeOutTimer = flash.utils.setTimeout(this.onTimeout, TIMEOUT);
            var loc1:*=new flash.net.URLRequest(URL_RETREIVE_ATHLETE);
            loc1.method = flash.net.URLRequestMethod.GET;
            var loc2:*=new flash.net.URLVariables();
            loc2.access_token = backend.oauth.StravaOAuth.getInstance().accessToken;
            loc1.data = loc2;
            var loc3:*=new extensions.ExtendedUrlLoader();
            loc3.addEventListener(flash.events.Event.COMPLETE, this.onLoadAthleteComplete);
            loc3.addEventListener(flash.events.IOErrorEvent.IO_ERROR, this.onError);
            loc3.load(loc1);
            return;
        }

        internal function onLoadAthleteComplete(arg1:flash.events.Event):void
        {
            flash.utils.clearTimeout(this._timeOutTimer);
            var loc1:*=com.adobe.serialization.json.JSON.decode(arg1.target.data);
            var loc2:*=new core.strava.StravaAthlete();
            loc2.fromObject(loc1);
            configCache.ConfigCache.getInstance().setValue(backend.oauth.StravaOAuth.CONFIG_CACHE_IS_PREMIUM, loc2.isPremium());
            configCache.ConfigCache.getInstance().saveCache();
            dispatchEvent(new flash.events.Event(EVENT_IS_PREMIUM_ATHLETE_STATUS_CHANGED));
            return;
        }

        protected override function onWebViewComplete(arg1:starling.events.Event):void
        {
            if (!(lastLocation.indexOf("access_denied") == -1) && lastLocation.indexOf("facebook") == -1 && lastLocation.indexOf("google") == -1) 
            {
                debug("autorisierung abgelehnt...");
                hideWebViewer();
                addEventListener(LOGGED_OUT_COMPLETE, this.onLogoutComplete);
                logout();
            }
            else if (loggedOut) 
            {
                if (showWebViewOnCheckLogin) 
                {
                    showWebViewer(true);
                }
                else 
                {
                    hideWebViewer();
                }
            }
            else 
            {
                hideWebViewer();
            }
            return;
        }

        public static const EVENT_IS_PREMIUM_ATHLETE_STATUS_CHANGED:String="stravaPremiumAthleteStatusChanged";

        public static const SEGMENT_ALLEFORTS:String="https://www.strava.com/api/v3/segments/";

        public static const SEGMENT_STARRED:String="https://www.strava.com/api/v3/segments/starred";

        public static const TIMEOUT:uint=30000;

        public static const URL_RETREIVE_ATHLETE:String="https://www.strava.com/api/v3/athlete";

        public static const URL_RETREIVE_SEGMENT:String="https://www.strava.com/api/v3/segments/";

        public static const URL_RETREIVE_SEGMENT_LEADERBORD:String="https://www.strava.com/api/v3/segments/{:id}/leaderboard/";

        public static const URL_RETREIVE_STARRED_SEGMENTS:String="https://www.strava.com/api/v3/segment_targets";

        public static const URL_STRAVA_PREMIUM_INFO:String="http://promo.strava.com/sigma-sport/";

        internal static const MAX_STRAVA_SEGMENTS:uint=100;

        public static const CONFIG_CACHE_IS_PREMIUM:String="stravaIsPremium";

        public var segmentsList:__AS3__.vec.Vector.<core.strava.StravaSegment>;

        internal var _loadDetais:Boolean=false;

        internal var _timeOutTimer:uint;

        internal var segmentsLoaded:uint=0;

        internal static var _instance:backend.oauth.StravaOAuth;
    }
}


