//class SharingHandler
package handler 
{
    import __AS3__.vec.*;
    import backend.events.*;
    import backend.oauth.*;
    import backend.sharing.*;
    import backend.utils.dbUtils.*;
    import com.adobe.serialization.json.*;
    import configCache.*;
    import core.activities.*;
    import core.general.*;
    import core.sport.*;
    import debug.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filesystem.*;
    import flash.net.*;
    import flash.utils.*;
    import frontend.components.button.*;
    import frontend.components.popup.oauth.*;
    import frontend.screen.activities.list.*;
    import mx.events.*;
    import utils.file.*;
    
    public class SharingHandler extends flash.events.EventDispatcher
    {
        public function SharingHandler(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            handler.ActivityHandler.getInstance().addEventListener(backend.events.UnitDataEvent.SHARING_DATA_ADDED, this.onSharingDataAdded);
            return;
        }

        internal function onActivitySharingProgress(arg1:backend.sharing.SharingEvent):void
        {
            debug.Debug.debug("activity sharing progress...");
            debug.Debug.debug("todo: SharingHandler > onActivitySharingProgress");
            return;
        }

        internal function onHTTPResponseStatusEvent(arg1:backend.sharing.SharingEvent):void
        {
            var loc1:*=arg1.currentTarget as backend.sharing.ActivitySharing;
            if ((arg1.eventTarget as flash.events.HTTPStatusEvent).status != loc1.oauthInstance.getCompleteHTTPStatus()) 
            {
                loc1.errorStatus = (arg1.eventTarget as flash.events.HTTPStatusEvent).status;
                this._uploadErrors.push(loc1);
            }
            return;
        }

        public function get shareHolder():flash.display.Sprite
        {
            return this._shareHolder;
        }

        public function set shareHolder(arg1:flash.display.Sprite):void
        {
            this._shareHolder = arg1;
            return;
        }

        internal function onActivitySharingComplete(arg1:backend.sharing.SharingEvent):void
        {
            var p_event:backend.sharing.SharingEvent;
            var activitySharing:backend.sharing.ActivitySharing;
            var dataEvent:flash.events.DataEvent;
            var xmlResponse:XML;
            var response:Object;
            var updateSharingInfoInActivity:Boolean;
            var onSaveActivityHeaderComplete:Function;
            var onSaveActivityHeaderError:Function;
            var stravaErrorMessage:String;
            var dbUtil:backend.utils.dbUtils.DBUtilObject;

            var loc1:*;
            dataEvent = null;
            xmlResponse = null;
            response = null;
            onSaveActivityHeaderComplete = null;
            onSaveActivityHeaderError = null;
            stravaErrorMessage = null;
            dbUtil = null;
            p_event = arg1;
            onSaveActivityHeaderComplete = function (arg1:backend.utils.dbUtils.DBUtilEvent):void
            {
                handler.ActivityHandler.getInstance().dispatchEvent(new frontend.screen.activities.list.ActivityListEvent(frontend.screen.activities.list.ActivityListEvent.UPDATE, p_event.activity));
                return;
            }
            onSaveActivityHeaderError = function (arg1:backend.utils.dbUtils.DBUtilEvent):void
            {
                return;
            }
            debug.Debug.debug("activity sharing complete...");
            activitySharing = p_event.currentTarget as backend.sharing.ActivitySharing;
            activitySharing.removeEventListener(backend.sharing.SharingEvent.SHARING_COMPLETE, this.onActivitySharingComplete);
            activitySharing.removeEventListener(backend.sharing.SharingEvent.SHARING_PROGRESS, this.onActivitySharingProgress);
            activitySharing.removeEventListener(backend.sharing.SharingEvent.SHARING_ERROR, this.onActivitySharingError);
            dataEvent = p_event.eventTarget as flash.events.DataEvent;
            updateSharingInfoInActivity = false;
            var loc2:*=activitySharing.oauthInstance;
            switch (loc2) 
            {
                case backend.oauth.FacebookGoViralHandler.getInstance():
                {
                    if (backend.oauth.FacebookGoViralHandler.getInstance().postId != "") 
                    {
                        p_event.activity.sharedToFacebookId = backend.oauth.FacebookGoViralHandler.getInstance().postId;
                        p_event.activity.sharedToFacebook = loc2 = true;
                        p_event.activity.shared = loc2;
                        p_event.activity.modificationDate = new Date().time;
                        updateSharingInfoInActivity = true;
                    }
                    break;
                }
                case backend.oauth.TwitterOAuth.getInstance():
                {
                    response = com.adobe.serialization.json.JSON.decode(p_event.eventTarget.target.data);
                    if (response["id"]) 
                    {
                        p_event.activity.sharedToTwitterId = response["id"];
                        p_event.activity.sharedToTwitter = loc2 = true;
                        p_event.activity.shared = loc2;
                        p_event.activity.modificationDate = new Date().time;
                        updateSharingInfoInActivity = true;
                    }
                    break;
                }
                case backend.oauth.StravaOAuth.getInstance():
                {
                    response = com.adobe.serialization.json.JSON.decode(dataEvent.data);
                    if (response["id"]) 
                    {
                        p_event.activity.sharedToStravaId = response["id"];
                        p_event.activity.sharedToStrava = loc2 = true;
                        p_event.activity.shared = loc2;
                        p_event.activity.modificationDate = new Date().time;
                        if (response["error"] == null) 
                        {
                            updateSharingInfoInActivity = true;
                        }
                        else 
                        {
                            stravaErrorMessage = response["error"] as String;
                            if (stravaErrorMessage && !(stravaErrorMessage.indexOf("duplicate") == -1)) 
                            {
                                activitySharing.errorStatus = 400;
                            }
                            else 
                            {
                                activitySharing.errorStatus = 0;
                            }
                            dispatchEvent(new backend.sharing.SharingEvent(backend.sharing.SharingEvent.SHARING_ERROR, p_event.activity, p_event));
                        }
                    }
                    else 
                    {
                        activitySharing.errorStatus = 0;
                        dispatchEvent(new backend.sharing.SharingEvent(backend.sharing.SharingEvent.SHARING_ERROR, p_event.activity, p_event));
                    }
                    break;
                }
                case backend.oauth.TwoPeakOAuth.getInstance():
                {
                    try 
                    {
                        response = com.adobe.serialization.json.JSON.decode(dataEvent.data);
                    }
                    catch (e:com.adobe.serialization.json.JSONParseError)
                    {
                        debug.Debug.error(e.errorID + " " + e.message);
                        xmlResponse = XML(dataEvent.data);
                        xmlResponse.normalize();
                        response = xmlResponse;
                    }
                    finally
                    {
                        if (response.status == "CREATED") 
                        {
                            p_event.activity.sharedTo2PeakId = response.id;
                            var loc4:*;
                            p_event.activity.sharedTo2Peak = loc4 = true;
                            p_event.activity.shared = loc4;
                            p_event.activity.modificationDate = new Date().time;
                            updateSharingInfoInActivity = true;
                        }
                    }
                    break;
                }
                case backend.oauth.TrainingPeaksOAuth.getInstance():
                {
                    xmlResponse = XML(((p_event.eventTarget as flash.events.Event).target as flash.net.URLLoader).data);
                    if (xmlResponse) 
                    {
                        xmlResponse.normalize();
                        p_event.activity.sharedToTrainingPeaksId = xmlResponse.Workout.Id;
                        p_event.activity.sharedToTrainingPeaks = loc2 = true;
                        p_event.activity.shared = loc2;
                        p_event.activity.modificationDate = new Date().time;
                        updateSharingInfoInActivity = true;
                    }
                    break;
                }
            }
            if (updateSharingInfoInActivity) 
            {
                dbUtil = new backend.utils.dbUtils.DBUtilObject(p_event.activity, onSaveActivityHeaderComplete, onSaveActivityHeaderError, null, null);
                handler.ActivityHandler.getInstance().saveActivity(dbUtil);
            }
            dispatchEvent(new backend.sharing.SharingEvent(backend.sharing.SharingEvent.SHARING_COMPLETE, p_event.activity));
            flash.utils.setTimeout(this.doSharing, 500);
            return;
        }

        internal function onActivitySharingError(arg1:backend.sharing.SharingEvent):void
        {
            var p_event:backend.sharing.SharingEvent;
            var activitySharing:backend.sharing.ActivitySharing;
            var error:Object;

            var loc1:*;
            error = null;
            p_event = arg1;
            debug.Debug.debug("activity sharing error...");
            activitySharing = p_event.currentTarget as backend.sharing.ActivitySharing;
            activitySharing.removeEventListener(backend.sharing.SharingEvent.SHARING_COMPLETE, this.onActivitySharingComplete);
            activitySharing.removeEventListener(backend.sharing.SharingEvent.SHARING_PROGRESS, this.onActivitySharingProgress);
            activitySharing.removeEventListener(backend.sharing.SharingEvent.SHARING_ERROR, this.onActivitySharingError);
            var loc2:*=activitySharing.oauthInstance;
            switch (loc2) 
            {
                case backend.oauth.TwitterOAuth.getInstance():
                {
                    try 
                    {
                        error = com.adobe.serialization.json.JSON.decode(((p_event.eventTarget as flash.events.IOErrorEvent).target as flash.net.URLLoader).data);
                        if (error.errors is Array) 
                        {
                            activitySharing.errorStatus = (error.errors as Array)[0].code;
                            if (activitySharing.errorStatus == 187) 
                            {
                                p_event.activity.sharedToTwitterId = "unknown";
                                p_event.activity.sharedToTwitter = true;
                                p_event.activity.modificationDate = new Date().time;
                            }
                        }
                    }
                    catch (e:Error)
                    {
                        debug.Debug.error("parse error");
                    }
                    break;
                }
            }
            this._uploadErrors.push(activitySharing);
            dispatchEvent(new backend.sharing.SharingEvent(backend.sharing.SharingEvent.SHARING_ERROR, p_event.activity, p_event));
            this.doSharing();
            return;
        }

        public function get uploadErrors():__AS3__.vec.Vector.<backend.sharing.ActivitySharing>
        {
            return this._uploadErrors;
        }

        public function get currentActivitySharing():backend.sharing.ActivitySharing
        {
            return this._1317998612currentActivitySharing;
        }

        public function set currentActivitySharing(arg1:backend.sharing.ActivitySharing):void
        {
            var loc1:*=this._1317998612currentActivitySharing;
            if (loc1 !== arg1) 
            {
                this._1317998612currentActivitySharing = arg1;
                if (this.hasEventListener("propertyChange")) 
                {
                    this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "currentActivitySharing", loc1, arg1));
                }
            }
            return;
        }

        public static function getInstance():handler.SharingHandler
        {
            if (!_instance) 
            {
                _instance = new SharingHandler();
            }
            return _instance;
        }

        public static function isValidStravaActivity(arg1:core.activities.Activity):Boolean
        {
            return arg1.latitudeStartDefined;
        }

        public static function validateButtonState(arg1:frontend.components.button.SharingAccountButton, arg2:Boolean, arg3:Boolean=true, arg4:Boolean=false):void
        {
            debug.Debug.debug("todo: SharingHandler > validateButtonState");
            return;
        }

        internal function onSharingDataAdded(arg1:backend.events.UnitDataEvent):void
        {
            if (this._startAutoSharingTimeout != 0) 
            {
                flash.utils.clearTimeout(this._startAutoSharingTimeout);
                this._startAutoSharingTimeout = 0;
            }
            if (this.isAutoSharingApplicable(backend.oauth.TrainingPeaksOAuth.getInstance(), arg1.data as core.activities.Activity)) 
            {
                this.addTrainingPeaksActivity(arg1.data as core.activities.Activity);
            }
            if (this.isAutoSharingApplicable(backend.oauth.TwoPeakOAuth.getInstance(), arg1.data as core.activities.Activity)) 
            {
                this.addTwoPeakActivity(arg1.data as core.activities.Activity);
            }
            if (this.isAutoSharingApplicable(backend.oauth.StravaOAuth.getInstance(), arg1.data as core.activities.Activity)) 
            {
                this.addStravaActivity(arg1.data as core.activities.Activity);
            }
            if (!this._uploadQueue) 
            {
                return;
            }
            this._startAutoSharingTimeout = flash.utils.setTimeout(handler.SharingHandler.getInstance().doSharing, this._startAutoSharingDelay);
            return;
        }

        internal function allowFIT(arg1:core.activities.Activity):Boolean
        {
            return arg1.dataType == core.general.DataType.LOG;
        }

        internal function allowTCX(arg1:core.activities.Activity):Boolean
        {
            return arg1.dataType == core.general.DataType.LOG;
        }

        public function addStravaActivity(arg1:core.activities.Activity):void
        {
            this.addActivitySharing(arg1, utils.file.FileExtension.FIT_FILE, backend.oauth.StravaOAuth.getInstance());
            return;
        }

        public function addTrainingPeaksActivity(arg1:core.activities.Activity):void
        {
            this.addActivitySharing(arg1, utils.file.FileExtension.TCX_FILE, backend.oauth.TrainingPeaksOAuth.getInstance());
            return;
        }

        public function addTwoPeakActivity(arg1:core.activities.Activity):void
        {
            this.addActivitySharing(arg1, utils.file.FileExtension.TCX_FILE, backend.oauth.TwoPeakOAuth.getInstance());
            return;
        }

        public function addFacebookActivity(arg1:core.activities.Activity):void
        {
            this.addActivitySharing(arg1, null, backend.oauth.FacebookGoViralHandler.getInstance());
            return;
        }

        public function addTwitterActivity(arg1:core.activities.Activity):void
        {
            this.addActivitySharing(arg1, null, backend.oauth.TwitterOAuth.getInstance());
            return;
        }

        public function addActivitySharing(arg1:core.activities.Activity, arg2:String, arg3:frontend.components.popup.oauth.CustomOAuth):void
        {
            if (arg2 == utils.file.FileExtension.FIT_FILE && !this.allowFIT(arg1)) 
            {
                return;
            }
            if (arg2 == utils.file.FileExtension.TCX_FILE && !this.allowTCX(arg1)) 
            {
                return;
            }
            if (!this._uploadQueue) 
            {
                this.prepareUpload();
            }
            var loc1:*=new backend.sharing.ActivitySharing(arg1, arg2, arg3);
            if (arg3 == backend.oauth.FacebookGoViralHandler.getInstance()) 
            {
                loc1.customShareMessage = "";
            }
            this._uploadQueue.push(loc1);
            debug.Debug.debug("activities to share: " + this._uploadQueue.length);
            return;
        }

        internal function isAutoSharingApplicable(arg1:frontend.components.popup.oauth.CustomOAuth, arg2:core.activities.Activity):Boolean
        {
            if (arg1.loggedOut) 
            {
                return false;
            }
            if (configCache.ConfigCache.getInstance().getValue(arg1.className + AUTO_SHARE_KEY + ENABLED_KEY, false)) 
            {
                if (configCache.ConfigCache.getInstance().getValue(arg1.className + AUTO_SHARE_KEY + arg2.sport.keyName, true) && configCache.ConfigCache.getInstance().getValue(arg1.className + AUTO_SHARE_KEY + "user" + arg2.userId, true)) 
                {
                    return true;
                }
            }
            return false;
        }

        public function prepareUpload():void
        {
            this._uploadQueue = new Vector.<backend.sharing.ActivitySharing>();
            this._uploadErrors = new Vector.<backend.sharing.ActivitySharing>();
            return;
        }

        public function doSharing(arg1:String=null):void
        {
            var loc1:*=null;
            if (this._uploadQueue.length > 0) 
            {
                if (!this.sharingStarted) 
                {
                    this.sharingStarted = true;
                }
                this.currentActivitySharing = this._uploadQueue.shift();
                if (arg1) 
                {
                    this.currentActivitySharing.customShareMessage = arg1;
                }
                this.currentActivitySharing.addEventListener(backend.sharing.SharingEvent.SHARING_COMPLETE, this.onActivitySharingComplete);
                this.currentActivitySharing.addEventListener(backend.sharing.SharingEvent.SHARING_PROGRESS, this.onActivitySharingProgress);
                this.currentActivitySharing.addEventListener(backend.sharing.SharingEvent.SHARING_ERROR, this.onActivitySharingError);
                this.currentActivitySharing.addEventListener(backend.sharing.SharingEvent.SHARING_HTTP_RESPONSE_STATUS, this.onHTTPResponseStatusEvent);
                this.currentActivitySharing.upload();
            }
            else 
            {
                this.sharingStarted = false;
                loc1 = flash.filesystem.File.documentsDirectory.resolvePath("tmp_sharingFiles");
                if (loc1.exists) 
                {
                    try 
                    {
                        loc1.deleteDirectoryAsync(true);
                    }
                    catch (e:Error)
                    {
                    };
                }
                dispatchEvent(new backend.sharing.SharingEvent(backend.sharing.SharingEvent.MULTI_SHARING_FINISHED, null));
            }
            return;
        }

        public function getSharingStandardText():String
        {
            var loc1:*=null;
            var loc2:*="";
            if (this._uploadQueue.length > 0) 
            {
                loc1 = this._uploadQueue[0];
                loc2 = loc1.generatePostMessage();
            }
            return loc2;
        }

        public function validateActivityEntries(arg1:core.activities.Activity):void
        {
            if (arg1.entries.length == 0 && !(arg1.sport.keyName == core.sport.Sport.ACTIVITY_TRACKER)) 
            {
                debug.Debug.debug("todo: SharingHandler > validateActivityEntries");
            }
            return;
        }

        public function tryAgain():void
        {
            var loc1:*=null;
            this._uploadQueue = new Vector.<backend.sharing.ActivitySharing>();
            var loc2:*=0;
            var loc3:*=this._uploadErrors;
            for each (loc1 in loc3) 
            {
                this.validateActivityEntries(loc1.activity);
                this._uploadQueue.push(loc1);
            }
            this._uploadErrors = new Vector.<backend.sharing.ActivitySharing>();
            this.doSharing();
            return;
        }

        public function activitiesToShare():int
        {
            return this._uploadQueue.length;
        }

        public static const AUTO_SHARE_KEY:String="AutoShare";

        public static const ENABLED_KEY:String="Enabled";

        internal var _1317998612currentActivitySharing:backend.sharing.ActivitySharing;

        internal var _shareHolder:flash.display.Sprite;

        public var sharingStarted:Boolean=false;

        internal var _uploadErrors:__AS3__.vec.Vector.<backend.sharing.ActivitySharing>;

        internal var _hasConnection:Boolean=false;

        internal var _stage:flash.display.Stage;

        internal var _startAutoSharingDelay:uint=3000;

        internal var _startAutoSharingTimeout:uint=0;

        internal var _uploadQueue:__AS3__.vec.Vector.<backend.sharing.ActivitySharing>;

        internal static var _instance:handler.SharingHandler;
    }
}


