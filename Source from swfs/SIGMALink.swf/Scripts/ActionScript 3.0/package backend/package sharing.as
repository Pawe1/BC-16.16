//package sharing
//  class ActivitySharing
package backend.sharing 
{
    import backend.oauth.*;
    import backend.utils.*;
    import com.garmin.fit.*;
    import com.hurlant.util.*;
    import core.activities.*;
    import core.fit.*;
    import core.general.*;
    import core.sport.*;
    import core.tcx.*;
    import debug.*;
    import feathers.events.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filesystem.*;
    import flash.geom.*;
    import flash.net.*;
    import flash.utils.*;
    import frontend.components.popup.oauth.*;
    import handler.*;
    import helper.*;
    import org.iotashan.oauth.*;
    import org.iotashan.utils.*;
    import service.oauth.*;
    import starling.events.*;
    import utils.*;
    import utils.converter.*;
    import utils.file.*;
    import utils.format.*;
    
    public class ActivitySharing extends flash.events.EventDispatcher
    {
        public function ActivitySharing(arg1:core.activities.Activity, arg2:String, arg3:frontend.components.popup.oauth.CustomOAuth)
        {
            super();
            this.sharingGUID = utils.GUID.create();
            this.activity = arg1;
            this.fileExtension = arg2;
            this.oauthInstance = arg3;
            var loc1:*=this.oauthInstance;
            switch (loc1) 
            {
                case backend.oauth.StravaOAuth.getInstance():
                {
                    this.createURLRequestFunc = this.createStravaUploadRequest;
                    break;
                }
                case backend.oauth.TwoPeakOAuth.getInstance():
                {
                    this.createURLRequestFunc = this.create2PeakUploadRequest;
                    break;
                }
                case backend.oauth.TrainingPeaksOAuth.getInstance():
                {
                    this.createURLRequestFunc = this.createTrainingPeaksUploadRequest;
                    break;
                }
                case backend.oauth.FacebookGoViralHandler.getInstance():
                {
                    this.createURLRequestFunc = this.createFacebookObject;
                    break;
                }
                case backend.oauth.TwitterOAuth.getInstance():
                {
                    this.createURLRequestFunc = this.createTwitterRequest;
                    break;
                }
                default:
                {
                    throw new Error("ActivitySharing > please define a createURLRequestFunc");
                }
            }
            return;
        }

        internal function fileError(arg1:flash.events.IOErrorEvent):void
        {
            debug.Debug.error("fileError: " + arg1.errorID + ", " + arg1.text);
            if (arg1 && arg1.target.hasOwnProperty("data") && arg1.target.data) 
            {
                debug.Debug.error("+++ fileError message: " + arg1.target.data);
            }
            dispatchEvent(new backend.sharing.SharingEvent(backend.sharing.SharingEvent.SHARING_ERROR, this.activity, arg1));
            return;
        }

        internal function onFileUploadComplete(arg1:flash.events.DataEvent):void
        {
            debug.Debug.debug("onFileUploadComplete: " + arg1.text);
            dispatchEvent(new backend.sharing.SharingEvent(backend.sharing.SharingEvent.SHARING_COMPLETE, this.activity, arg1));
            return;
        }

        internal function onFBUploadComplete(arg1:flash.events.Event):void
        {
            debug.Debug.debug("onFBUploadComplete");
            backend.oauth.FacebookGoViralHandler.getInstance().removeEventListener(backend.oauth.FacebookGoViralHandler.FBH_POST_DATA_SUCCESS, this.onFBUploadComplete);
            backend.oauth.FacebookGoViralHandler.getInstance().removeEventListener(backend.oauth.FacebookGoViralHandler.FBH_POST_DATA_ERROR, this.onFBUploadError);
            dispatchEvent(new backend.sharing.SharingEvent(backend.sharing.SharingEvent.SHARING_COMPLETE, this.activity, arg1));
            return;
        }

        internal function onFBUploadError(arg1:flash.events.Event):void
        {
            debug.Debug.debug("onFBUploadError");
            backend.oauth.FacebookGoViralHandler.getInstance().removeEventListener(backend.oauth.FacebookGoViralHandler.FBH_POST_DATA_SUCCESS, this.onFBUploadComplete);
            backend.oauth.FacebookGoViralHandler.getInstance().removeEventListener(backend.oauth.FacebookGoViralHandler.FBH_POST_DATA_ERROR, this.onFBUploadError);
            dispatchEvent(new backend.sharing.SharingEvent(backend.sharing.SharingEvent.SHARING_ERROR, this.activity, arg1));
            return;
        }

        internal function generateSharingImageFromDisplayObject(arg1:backend.sharing.ShareableDocument):void
        {
            arg1.addEventListener(feathers.events.FeathersEventType.CREATION_COMPLETE, this.sharingImageCompleteDelay);
            handler.SharingHandler.getInstance().shareHolder.addChild(arg1);
            return;
        }

        internal function onURLLoaderComplete(arg1:flash.events.Event):void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=null;
            (arg1.currentTarget as flash.net.URLLoader).removeEventListener(flash.events.HTTPStatusEvent.HTTP_RESPONSE_STATUS, this.onHTTPResponseStatus);
            (arg1.currentTarget as flash.net.URLLoader).removeEventListener(flash.events.Event.COMPLETE, this.onURLLoaderComplete);
            (arg1.currentTarget as flash.net.URLLoader).removeEventListener(flash.events.ProgressEvent.PROGRESS, this.updateProgress);
            (arg1.currentTarget as flash.net.URLLoader).removeEventListener(flash.events.IOErrorEvent.IO_ERROR, this.fileError);
            debug.Debug.debug("onURLLoaderComplete" + arg1.toString());
            var loc7:*=this.oauthInstance;
            switch (loc7) 
            {
                case backend.oauth.FacebookGoViralHandler.getInstance():
                {
                    if (this.activity.sport.keyName == core.sport.Sport.ACTIVITY_TRACKER) 
                    {
                        dispatchEvent(new backend.sharing.SharingEvent(backend.sharing.SharingEvent.SHARING_COMPLETE, this.activity, arg1));
                        return;
                    }
                    loc1 = new flash.net.URLLoader();
                    loc2 = new flash.net.URLRequest(backend.oauth.FacebookGoViralHandler.getInstance().UPLOAD_URL + mapSportToFacebook(this.activity.sport));
                    loc3 = JSON.parse(arg1.target.data);
                    loc4 = new Object();
                    loc5 = new Object();
                    loc4["course"] = loc3.id;
                    loc4["fb:explicitly_shared"] = true;
                    loc4["start_time"] = this.activity.startDate.time / 1000;
                    loc6 = JSON.stringify(loc4);
                    loc5 = {"object":loc6, "course":loc3.id, "fb:explicitly_shared":true, "start_time":this.activity.startDate.time / 1000, "access_token":backend.oauth.FacebookGoViralHandler.getInstance().accessToken, "message":this.generatePostMessage()};
                    loc2.method = flash.net.URLRequestMethod.POST;
                    loc2.data = this.objectToURLVariables(loc5);
                    loc1.addEventListener(flash.events.Event.COMPLETE, this.onFBURLLoaderComplete, false, 0, false);
                    loc1.addEventListener(flash.events.ProgressEvent.PROGRESS, this.updateProgress);
                    loc1.addEventListener(flash.events.IOErrorEvent.IO_ERROR, this.fileError, false, 0, true);
                    loc1.load(loc2);
                    break;
                }
                default:
                {
                    dispatchEvent(new backend.sharing.SharingEvent(backend.sharing.SharingEvent.SHARING_COMPLETE, this.activity, arg1));
                    break;
                }
            }
            return;
        }

        internal function onFBURLLoaderComplete(arg1:flash.events.Event):void
        {
            (arg1.currentTarget as flash.net.URLLoader).removeEventListener(flash.events.Event.COMPLETE, this.onFBURLLoaderComplete);
            (arg1.currentTarget as flash.net.URLLoader).removeEventListener(flash.events.ProgressEvent.PROGRESS, this.updateProgress);
            (arg1.currentTarget as flash.net.URLLoader).removeEventListener(flash.events.IOErrorEvent.IO_ERROR, this.fileError);
            debug.Debug.debug("onFBURLLoaderComplete: " + arg1.toString());
            dispatchEvent(new backend.sharing.SharingEvent(backend.sharing.SharingEvent.SHARING_COMPLETE, this.activity, arg1));
            return;
        }

        internal function doUploadObject(arg1:backend.sharing.SharingEvent=null):void
        {
            var loc1:*=null;
            var loc2:*=null;
            removeEventListener(backend.sharing.SharingEvent.SCREENSHOT_READY, this.doUploadObject);
            if (this.oauthInstance != backend.oauth.FacebookGoViralHandler.getInstance()) 
            {
                if (arg1) 
                {
                    loc1 = this.createURLRequestFunc(arg1.screenshot) as flash.net.URLRequest;
                }
                else 
                {
                    loc1 = this.createURLRequestFunc() as flash.net.URLRequest;
                }
                if (this.oauthInstance == backend.oauth.TwitterOAuth.getInstance()) 
                {
                    return;
                }
                loc2 = new flash.net.URLLoader();
                loc2.addEventListener(flash.events.Event.COMPLETE, this.onURLLoaderComplete, false, 0, false);
                loc2.addEventListener(flash.events.ProgressEvent.PROGRESS, this.updateProgress);
                loc2.addEventListener(flash.events.IOErrorEvent.IO_ERROR, this.fileError, false, 0, true);
                loc2.load(loc1);
            }
            else 
            {
                backend.oauth.FacebookGoViralHandler.getInstance().addEventListener(backend.oauth.FacebookGoViralHandler.FBH_POST_DATA_SUCCESS, this.onFBUploadComplete);
                backend.oauth.FacebookGoViralHandler.getInstance().addEventListener(backend.oauth.FacebookGoViralHandler.FBH_POST_DATA_ERROR, this.onFBUploadError);
                backend.oauth.FacebookGoViralHandler.getInstance().postWalk(this.createURLRequestFunc() as Object, mapSportToFacebook(this.activity.sport));
            }
            return;
        }

        internal static function mapSportToStrava(arg1:core.sport.Sport):String
        {
            var loc1:*="";
            var loc2:*=arg1.keyName;
            switch (loc2) 
            {
                case core.sport.Sport.CYCLING:
                case core.sport.Sport.INDOOR_CYCLING:
                case core.sport.Sport.MOUNTAINBIKE:
                case core.sport.Sport.RACING_BYCICLE:
                {
                    loc1 = "ride";
                    break;
                }
                case core.sport.Sport.RUNNING:
                {
                    return "run";
                }
                case core.sport.Sport.SWIMMING:
                {
                    return "swim";
                }
                case core.sport.Sport.HIKING:
                {
                    loc1 = "hike";
                    break;
                }
                case core.sport.Sport.WALKING:
                {
                    loc1 = "walk";
                    break;
                }
                case core.sport.Sport.INLINE_SKATES:
                {
                    loc1 = "inlineskate";
                    break;
                }
                case core.sport.Sport.SNOWBOARDING:
                {
                    loc1 = "snowboard";
                    break;
                }
                case core.sport.Sport.FITNESS:
                case core.sport.Sport.TREADMILL:
                {
                    loc1 = "workout";
                    break;
                }
            }
            return loc1;
        }

        internal static function mapSportTo2Peak(arg1:core.sport.Sport):String
        {
            var loc1:*=arg1.keyName;
            switch (loc1) 
            {
                case core.sport.Sport.CYCLING:
                case core.sport.Sport.INDOOR_CYCLING:
                case core.sport.Sport.MOUNTAINBIKE:
                case core.sport.Sport.RACING_BYCICLE:
                {
                    return "Cycling";
                }
                case core.sport.Sport.ACTIVITY_TRACKER:
                case core.sport.Sport.HIKING:
                case core.sport.Sport.RUNNING:
                case core.sport.Sport.TREADMILL:
                case core.sport.Sport.WALKING:
                {
                    return "Running";
                }
                default:
                {
                    return "Other";
                }
            }
        }

        public static function mapSportToFacebook(arg1:core.sport.Sport):String
        {
            var loc1:*=arg1.keyName;
            switch (loc1) 
            {
                case core.sport.Sport.CYCLING:
                case core.sport.Sport.INDOOR_CYCLING:
                case core.sport.Sport.MOUNTAINBIKE:
                case core.sport.Sport.RACING_BYCICLE:
                {
                    return "/me/fitness.bikes";
                }
                case core.sport.Sport.HIKING:
                case core.sport.Sport.RUNNING:
                case core.sport.Sport.TREADMILL:
                {
                    return "/me/fitness.runs";
                }
                case core.sport.Sport.WALKING:
                case core.sport.Sport.ACTIVITY_TRACKER:
                {
                    return "/me/fitness.walks";
                }
                default:
                {
                    return "/me/fitness.walks";
                }
            }
        }

        public static function getJSONString(arg1:Object):String
        {
            return JSON.stringify(arg1);
        }

        public function upload():void
        {
            if (this.fileExtension) 
            {
                var loc1:*=this.fileExtension;
                switch (loc1) 
                {
                    case utils.file.FileExtension.FIT_FILE:
                    {
                        this.file = this.generateFITUploadFile(this.activity);
                        break;
                    }
                    case utils.file.FileExtension.TCX_FILE:
                    {
                        this.file = this.generateTXCUploadFile(this.activity);
                        break;
                    }
                }
                if (this.file) 
                {
                    this.uploadFile();
                }
                else 
                {
                    dispatchEvent(new backend.sharing.SharingEvent(backend.sharing.SharingEvent.SHARING_ERROR, this.activity));
                }
            }
            else 
            {
                this.initUploadObject();
            }
            return;
        }

        public function createStravaUploadRequest(arg1:flash.filesystem.File):flash.net.URLRequest
        {
            var loc1:*=new flash.net.URLRequest(backend.oauth.StravaOAuth.getInstance().UPLOAD_URL);
            loc1.method = flash.net.URLRequestMethod.POST;
            loc1.contentType = "multipart/form-data";
            var loc2:*=new flash.net.URLVariables();
            loc2.access_token = backend.oauth.StravaOAuth.getInstance().accessToken;
            var loc3:*=mapSportToStrava(this.activity.sport);
            if (loc3 != "") 
            {
                loc2.activity_type = loc3;
            }
            loc2.name = this.activity.name;
            loc2.data_type = this.fileExtension;
            loc2.file = arg1;
            this._uploadDataFieldName = "file";
            loc1.data = loc2;
            this._useURLLoader = false;
            return loc1;
        }

        public function create2PeakUploadRequest(arg1:flash.filesystem.File):flash.net.URLRequest
        {
            var loc1:*=new flash.net.URLRequest(backend.oauth.TwoPeakOAuth.getInstance().UPLOAD_URL);
            loc1.method = flash.net.URLRequestMethod.POST;
            var loc2:*=new flash.net.URLVariables();
            loc2.access_token = backend.oauth.TwoPeakOAuth.getInstance().accessToken;
            loc2.file = arg1;
            loc2.type = mapSportTo2Peak(this.activity.sport);
            loc2.startdate = core.tcx.ActivityTCXMapper.formatDate(this.activity.startDate);
            loc1.data = loc2;
            loc1.useCache = true;
            this._uploadDataFieldName = "file";
            this._useURLLoader = false;
            return loc1;
        }

        public function createTrainingPeaksUploadRequest(arg1:flash.filesystem.File):flash.net.URLRequest
        {
            var p_file:flash.filesystem.File;
            var fs:flash.filesystem.FileStream;
            var fileContentBytes:flash.utils.ByteArray;
            var urlRequest:flash.net.URLRequest;
            var urlObj:Object;
            var target:flash.filesystem.File;
            var enc:utils.file.GZIPEncoder;
            var base64Data:String;

            var loc1:*;
            fs = null;
            fileContentBytes = null;
            urlRequest = null;
            urlObj = null;
            target = null;
            enc = null;
            base64Data = null;
            p_file = arg1;
            try 
            {
                fs = new flash.filesystem.FileStream();
                fileContentBytes = new flash.utils.ByteArray();
                target = new flash.filesystem.File(p_file.nativePath + ".gz");
                enc = new utils.file.GZIPEncoder();
                enc.compressToFile(p_file, target);
                fs.open(target, flash.filesystem.FileMode.READ);
                fs.readBytes(fileContentBytes, 0, fs.bytesAvailable);
                fs.close();
                base64Data = com.hurlant.util.Base64.encodeByteArray(fileContentBytes);
                urlObj = {"UploadClient":"sigmasport", "Filename":target.name, "Data":base64Data};
                urlRequest = new flash.net.URLRequest(backend.oauth.TrainingPeaksOAuth.getInstance().UPLOAD_URL);
                urlRequest.method = flash.net.URLRequestMethod.POST;
                urlRequest.contentType = "application/json";
                urlRequest.requestHeaders.push(new flash.net.URLRequestHeader("Authorization", "Bearer " + backend.oauth.TrainingPeaksOAuth.getInstance().accessToken));
                urlRequest.data = getJSONString(urlObj);
                this._useURLLoader = true;
            }
            catch (e:Error)
            {
                debug.Debug.error("error: " + e.message);
            }
            return urlRequest;
        }

        public function createFacebookObject(arg1:flash.utils.ByteArray=null):Object
        {
            var loc4:*=null;
            var loc5:*=null;
            var loc7:*=0;
            var loc8:*=null;
            var loc9:*=0;
            var loc10:*=null;
            var loc11:*=0;
            var loc1:*=new Object();
            var loc2:*=new Object();
            var loc3:*=new Array();
            var loc6:*=new utils.converter.SpeedConverter(backend.utils.DataUtils.speedConverter.inputFormat, backend.utils.DataUtils.speedConverter.inputFormat != utils.format.SpeedFormat.KILOMETER_PER_HOUR ? "fps" : "ms");
            if (this.activity.sport.keyName == core.sport.Sport.ACTIVITY_TRACKER) 
            {
                loc1 = {"message":this.generatePostMessage(), "access_token":backend.oauth.FacebookGoViralHandler.getInstance().accessToken};
                if (arg1) 
                {
                    loc1["fileName"] = "shareimage.png";
                    loc10 = new flash.net.URLRequest(backend.oauth.FacebookGoViralHandler.getInstance().UPLOAD_URL + "me/photos");
                }
                else 
                {
                    loc10 = new flash.net.URLRequest(backend.oauth.FacebookGoViralHandler.getInstance().UPLOAD_URL + "me/feed");
                }
                this.createUploadFileRequest(arg1, loc10, loc1);
                loc10.method = flash.net.URLRequestMethod.POST;
            }
            else 
            {
                loc7 = 0;
                loc9 = 0;
                loc11 = this.activity.trainingTime / 245;
                loc7 = 0;
                while (loc7 < this.activity.entries.length) 
                {
                    loc8 = this.activity.entries[loc7];
                    loc9 = loc9 + this.activity.entries[loc7].trainingTime;
                    loc4 = new Object();
                    if (loc8.caloriesDefined) 
                    {
                        loc4["calories"] = Math.floor(loc8.calories) as int;
                    }
                    if (loc8.distanceDefined) 
                    {
                        loc4["distance:value"] = backend.utils.DataUtils.distanceConverter.convert(loc8.distance);
                        loc4["distance:units"] = backend.utils.DataUtils.unitStringDistance;
                    }
                    if (loc8.latitudeDefined && loc8.longitudeDefined && loc8.latitude > 0 && loc8.longitude > 0) 
                    {
                        loc4["location:latitude"] = loc8.latitude;
                        loc4["location:longitude"] = loc8.longitude;
                        if (loc8.altitudeDefined) 
                        {
                            loc4["location:altitude"] = loc8.altitude;
                        }
                    }
                    if (loc8.stepsDefined) 
                    {
                        loc4["steps"] = loc8.steps;
                    }
                    if (loc8.speedDefined) 
                    {
                        loc4["speed:value"] = loc6.convert(loc8.speed);
                        loc4["speed:units"] = backend.utils.DataUtils.speedConverter.inputFormat != utils.format.SpeedFormat.KILOMETER_PER_HOUR ? "ft/s" : "m/s";
                    }
                    if (loc8.trainingTimeAbsolute) 
                    {
                        loc4["timestamp"] = loc8.trainingTimeAbsolute;
                    }
                    if (loc9 >= loc11) 
                    {
                        loc3.push(loc4);
                        loc9 = 0;
                    }
                    ++loc7;
                }
                if (loc4 != null) 
                {
                    loc3.push(loc4);
                }
                loc2 = {"fb:app_id":backend.oauth.FacebookGoViralHandler.APP_ID, "og:type":"fitness.course", "og:title":"Course", "og:url":"http://www.sigmasport.com/de/produkte/software/software/apps/data-center", "og:title":"SIGMA LINK"};
                if (this.activity.distanceDefined) 
                {
                    loc2["fitness:distance:value"] = backend.utils.DataUtils.distanceConverter.convert(this.activity.distance);
                    loc2["fitness:distance:units"] = backend.utils.DataUtils.unitStringDistance;
                }
                if (this.activity.trainingTimeDefined) 
                {
                    loc2["fitness:duration:value"] = this.activity.trainingTime / 100;
                    loc2["fitness:duration:units"] = "s";
                }
                if (this.activity.distanceDefined && this.activity.trainingTimeDefined) 
                {
                    loc2["fitness:pace:value"] = this.activity.trainingTime / 100 / this.activity.distance;
                    loc2["fitness:pace:units"] = "s/m";
                    loc2["fitness:speed:value"] = this.activity.distance / (this.activity.trainingTime / 100);
                    loc2["fitness:speed:units"] = "m/s";
                }
                if (this.activity.caloriesDefined) 
                {
                    loc2["fitness:calories"] = Math.floor(this.activity.calories) as int;
                }
                if (loc3.length > 0) 
                {
                    loc2["fitness:metrics"] = loc3;
                }
                loc5 = JSON.stringify(loc2);
                loc1 = {"object":loc5, "access_token":backend.oauth.FacebookGoViralHandler.getInstance().accessToken};
            }
            return loc1;
        }

        public function createTwitterRequest(arg1:flash.utils.ByteArray=null):flash.net.URLRequest
        {
            var p_postImageByteArray:flash.utils.ByteArray=null;
            var message:String;
            var tmp:flash.filesystem.File;
            var file:flash.filesystem.File;
            var stream:flash.filesystem.FileStream;
            var twitterData:Object;
            var consumer:org.iotashan.oauth.OAuthConsumer;
            var token:org.iotashan.oauth.OAuthToken;
            var uploadRequest:org.iotashan.oauth.OAuthRequest;
            var urlRequest:flash.net.URLRequest;
            var tw_onHTTPResponseStatus:Function;
            var tw_updateProgress:Function;
            var tw_fileError:Function;
            var tw_onFileUploadComplete:Function;

            var loc1:*;
            message = null;
            tmp = null;
            file = null;
            stream = null;
            twitterData = null;
            consumer = null;
            token = null;
            uploadRequest = null;
            urlRequest = null;
            p_postImageByteArray = arg1;
            message = this.generatePostMessage();
            if (p_postImageByteArray) 
            {
                tw_onHTTPResponseStatus = function (arg1:flash.events.HTTPStatusEvent):void
                {
                    debug.Debug.debug("onHTTPResponseStatus: " + arg1.status);
                    dispatchEvent(new backend.sharing.SharingEvent(backend.sharing.SharingEvent.SHARING_HTTP_RESPONSE_STATUS, activity, arg1));
                    return;
                }
                tw_updateProgress = function (arg1:flash.events.ProgressEvent):void
                {
                    debug.Debug.debug("updateProgress: loaded = " + arg1.bytesLoaded + ", total = " + arg1.bytesTotal);
                    dispatchEvent(new backend.sharing.SharingEvent(backend.sharing.SharingEvent.SHARING_PROGRESS, activity, arg1));
                    return;
                }
                tw_fileError = function (arg1:flash.events.IOErrorEvent):void
                {
                    debug.Debug.error("fileError: " + arg1.errorID + ", " + arg1.text);
                    if (arg1 && arg1.target.hasOwnProperty("data") && arg1.target.data) 
                    {
                        debug.Debug.error("+++ fileError message: " + arg1.target.data);
                    }
                    dispatchEvent(new backend.sharing.SharingEvent(backend.sharing.SharingEvent.SHARING_ERROR, activity, arg1));
                    return;
                }
                tw_onFileUploadComplete = function (arg1:flash.events.DataEvent):void
                {
                    var loc1:*=JSON.parse(arg1.text);
                    postTwitter(message, loc1.media_id_string);
                    return;
                }
                tmp = flash.filesystem.File.documentsDirectory.resolvePath("tmp_sharingFiles");
                if (!tmp.exists) 
                {
                    tmp.createDirectory();
                }
                file = tmp.resolvePath("twitterUploadFile" + this.sharingGUID + ".png");
                stream = new flash.filesystem.FileStream();
                stream.open(file, flash.filesystem.FileMode.WRITE);
                stream.writeBytes(p_postImageByteArray);
                stream.close();
                twitterData = new Object();
                consumer = new org.iotashan.oauth.OAuthConsumer(backend.oauth.TwitterOAuth.getInstance().CLIENT_ID, backend.oauth.TwitterOAuth.getInstance().CLIENT_SECRET);
                token = new org.iotashan.oauth.OAuthToken(backend.oauth.TwitterOAuth.getInstance().accessKey, backend.oauth.TwitterOAuth.getInstance().accessSecret);
                uploadRequest = new org.iotashan.oauth.OAuthRequest(org.iotashan.oauth.OAuthRequest.HTTP_MEHTOD_POST, backend.oauth.TwitterOAuth.TWITTER_UPLOAD_URL, twitterData, consumer, token);
                urlRequest = new flash.net.URLRequest(uploadRequest.buildRequest(new org.iotashan.oauth.OAuthSignatureMethod_HMAC_SHA1()));
                urlRequest.method = flash.net.URLRequestMethod.POST;
                urlRequest.contentType = "multipart/form-data";
                twitterData["media"] = file;
                urlRequest.data = this.objectToURLVariables(twitterData);
                file.addEventListener(flash.events.HTTPStatusEvent.HTTP_RESPONSE_STATUS, tw_onHTTPResponseStatus);
                file.addEventListener(flash.events.ProgressEvent.PROGRESS, tw_updateProgress);
                file.addEventListener(flash.events.DataEvent.UPLOAD_COMPLETE_DATA, tw_onFileUploadComplete);
                file.addEventListener(flash.events.IOErrorEvent.IO_ERROR, tw_fileError);
                file.upload(urlRequest, "media", false);
            }
            else 
            {
                this.postTwitter(message);
            }
            return null;
        }

        internal function postTwitter(arg1:String, arg2:String=null):void
        {
            var loc7:*=null;
            var loc1:*=new org.iotashan.oauth.OAuthConsumer(backend.oauth.TwitterOAuth.getInstance().CLIENT_ID, backend.oauth.TwitterOAuth.getInstance().CLIENT_SECRET);
            var loc2:*=new org.iotashan.oauth.OAuthToken(backend.oauth.TwitterOAuth.getInstance().accessKey, backend.oauth.TwitterOAuth.getInstance().accessSecret);
            var loc3:*=arg2 == null ? {"status":arg1} : {"status":arg1, "media_ids":arg2};
            var loc4:*=new org.iotashan.oauth.OAuthRequest(org.iotashan.oauth.OAuthRequest.HTTP_MEHTOD_POST, backend.oauth.TwitterOAuth.TWITTER_POST_URL, loc3, loc1, loc2);
            var loc5:*=new flash.net.URLRequest(loc4.buildRequest(new org.iotashan.oauth.OAuthSignatureMethod_HMAC_SHA1()));
            loc5.method = flash.net.URLRequestMethod.POST;
            if (arg2 == null) 
            {
                loc5.url = loc5.url.replace("&status=" + org.iotashan.utils.URLEncoding.encode(arg1), "");
                loc5.data = new flash.net.URLVariables("status=" + arg1);
            }
            else 
            {
                loc5.url = loc5.url.replace("&status=" + org.iotashan.utils.URLEncoding.encode(arg1), "");
                loc5.url = loc5.url.replace("media_ids=" + arg2 + "&", "");
                loc7 = new flash.net.URLVariables();
                loc7.status = arg1;
                loc7.media_ids = arg2;
                loc5.data = loc7;
            }
            var loc6:*=new flash.net.URLLoader();
            loc6.addEventListener(flash.events.Event.COMPLETE, this.onURLLoaderComplete, false, 0, false);
            loc6.addEventListener(flash.events.ProgressEvent.PROGRESS, this.updateProgress);
            loc6.addEventListener(flash.events.IOErrorEvent.IO_ERROR, this.fileError, false, 0, true);
            loc6.load(loc5);
            return;
        }

        public function generatePostMessage():String
        {
            var loc1:*=null;
            var loc4:*=false;
            if (this.customShareMessage) 
            {
                return this.customShareMessage;
            }
            var loc2:*=this.activity.distanceDefined ? backend.utils.DataUtils.distanceFormatter.format(backend.utils.DataUtils.distanceConverter.convert(this.activity.distance)) : "";
            var loc3:*=this.activity.trainingTimeDefined ? backend.utils.DataUtils.timeFormatterHHMM.format(this.activity.trainingTime) : "";
            if (this.activity.sport.keyName != core.sport.Sport.ACTIVITY_TRACKER) 
            {
                if (this.activity.unitType) 
                {
                    loc1 = this.activity.distanceDefined ? utils.LanguageManager.getString("DEVICE_POST_MESSAGE") : utils.LanguageManager.getString("DEVICE_POST_MESSAGE_TIME_ONLY");
                    loc1 = loc1.replace("##device", core.general.UnitType.hashtag(this.activity.unitType));
                }
                else 
                {
                    loc1 = this.activity.distanceDefined ? utils.LanguageManager.getString("GENERAL_POST_MESSAGE") : utils.LanguageManager.getString("GENERAL_POST_MESSAGE_TIME_ONLY");
                }
                loc1 = loc1.replace("##sport", this.activity.sport.noun);
                loc1 = loc1.replace("##date", this.activity.dateOutputString);
                if (this.activity.distanceDefined) 
                {
                    loc1 = loc1.replace("##distance", loc2 + " " + backend.utils.DataUtils.unitStringDistance);
                }
                loc1 = loc1.replace("##time", loc3 + " " + backend.utils.DataUtils.unitStringTimeHours);
            }
            else 
            {
                loc4 = backend.utils.DataUtils.dateTimeFormatter.format(this.activity.startDate) == backend.utils.DataUtils.dateTimeFormatter.format(new Date());
                loc1 = utils.LanguageManager.getString(loc4 ? "SOCIAL_SHARE_STANDARD_TEXT_THIS_DAY" : "SOCIAL_SHARE_STANDARD_TEXT_DATE_DAY");
                loc1 = loc1 + " " + utils.LanguageManager.getString("SOCIAL_SHARE_STANDARD_TEXT_PART2");
                loc1 = loc1.replace("##0", this.activity.steps);
                loc1 = loc1.replace("##1", loc2);
                loc1 = loc1.replace("##2", backend.utils.DataUtils.unitStringDistance);
                loc1 = loc1.replace("##3", backend.utils.DataUtils.dateTimeFormatter.format(this.activity.startDate));
                loc1 = loc1 + (" " + core.general.UnitType.hashtag(this.activity.unitType));
            }
            loc1 = loc1 + " #SIGMASPORT #SIGMALink";
            return loc1;
        }

        internal function objectToURLVariables(arg1:Object):flash.net.URLVariables
        {
            var loc2:*=null;
            var loc1:*=new flash.net.URLVariables();
            if (arg1 == null) 
            {
                return loc1;
            }
            var loc3:*=0;
            var loc4:*=arg1;
            for (loc2 in loc4) 
            {
                loc1[loc2] = arg1[loc2];
            }
            return loc1;
        }

        internal function initUploadObject():void
        {
            var loc1:*=this.oauthInstance;
            switch (loc1) 
            {
                case backend.oauth.FacebookGoViralHandler.getInstance():
                case backend.oauth.TwitterOAuth.getInstance():
                {
                    if (this.activity.sport.keyName == core.sport.Sport.ACTIVITY_TRACKER) 
                    {
                        throw new Error("Activity Tracker wird noch nicht unterstützt");
                    }
                    this.doUploadObject();
                    break;
                }
                default:
                {
                    this.doUploadObject();
                    break;
                }
            }
            return;
        }

        internal function sharingImageCompleteDelay(arg1:starling.events.Event):void
        {
            var loc1:*=arg1.currentTarget as backend.sharing.ShareableDocument;
            loc1.removeEventListener(feathers.events.FeathersEventType.CREATION_COMPLETE, this.sharingImageComplete);
            if (!loc1.completeCreated) 
            {
                flash.utils.setTimeout(this.sharingImageCompleteDelay, 100, arg1);
                return;
            }
            flash.utils.setTimeout(this.sharingImageComplete, 800, loc1);
            return;
        }

        internal function sharingImageComplete(arg1:backend.sharing.ShareableDocument):void
        {
            var loc1:*=new flash.display.BitmapData(arg1.width, arg1.height, false, 16777215);
            loc1.fillRect(new flash.geom.Rectangle(0, 0, arg1.width, arg1.height), 16777215);
            loc1.draw(arg1, new flash.geom.Matrix());
            var loc2:*=new backend.sharing.SharingEvent(backend.sharing.SharingEvent.SCREENSHOT_READY, null);
            loc2.screenshot = helper.Image_helper.png(loc1);
            dispatchEvent(loc2);
            handler.SharingHandler.getInstance().shareHolder.removeChildren();
            return;
        }

        internal function createUploadFileRequest(arg1:Object, arg2:flash.net.URLRequest, arg3:Object=null):void
        {
            var loc2:*=null;
            var loc1:*=new service.oauth.PostRequest();
            if (arg3) 
            {
                var loc3:*=0;
                var loc4:*=arg3;
                for (loc2 in loc4) 
                {
                    loc1.writePostData(loc2, arg3[loc2]);
                }
            }
            if (arg1 is flash.utils.ByteArray && arg3.fileName) 
            {
                loc1.writeFileData(arg3.fileName, arg1 as flash.utils.ByteArray, "image/png");
            }
            loc1.close();
            arg2.contentType = "multipart/form-data; boundary=" + loc1.boundary;
            arg2.data = loc1.getPostData();
            return;
        }

        internal function generateFITUploadFile(arg1:core.activities.Activity):flash.filesystem.File
        {
            var loc1:*=this.createFile(utils.file.FileExtension.FIT_FILE);
            var loc2:*=new com.garmin.fit.FITFileEncoder(loc1);
            core.fit.ActivityFITMapper.getInstance(arg1).generateFIT(loc2);
            return loc1;
        }

        internal function generateTXCUploadFile(arg1:core.activities.Activity):flash.filesystem.File
        {
            var loc1:*=this.createFile(utils.file.FileExtension.TCX_FILE);
            var loc2:*=new flash.filesystem.FileStream();
            loc2.open(loc1, flash.filesystem.FileMode.WRITE);
            loc2.writeUTFBytes("<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?>" + core.tcx.ActivityTCXMapper.generateXML(arg1).toXMLString());
            loc2.close();
            return loc1;
        }

        internal function createFile(arg1:String):flash.filesystem.File
        {
            var loc1:*=flash.filesystem.File.documentsDirectory.resolvePath("tmp_sharingFiles");
            if (!loc1.exists) 
            {
                loc1.createDirectory();
            }
            var loc2:*=loc1.resolvePath(this.fileExtension + "uploadFile" + this.sharingGUID + "." + arg1);
            return loc2;
        }

        internal function uploadFile():void
        {
            var request:flash.net.URLRequest;
            var urlLoader:flash.net.URLLoader;

            var loc1:*;
            request = null;
            urlLoader = null;
            try 
            {
                request = this.createURLRequestFunc(this.file) as flash.net.URLRequest;
                if (this._useURLLoader) 
                {
                    urlLoader = new flash.net.URLLoader();
                    urlLoader.addEventListener(flash.events.HTTPStatusEvent.HTTP_RESPONSE_STATUS, this.onHTTPResponseStatus);
                    urlLoader.addEventListener(flash.events.ProgressEvent.PROGRESS, this.updateProgress);
                    urlLoader.addEventListener(flash.events.Event.COMPLETE, this.onURLLoaderComplete);
                    urlLoader.addEventListener(flash.events.IOErrorEvent.IO_ERROR, this.fileError);
                    urlLoader.load(request);
                }
                else 
                {
                    this.file.addEventListener(flash.events.HTTPStatusEvent.HTTP_RESPONSE_STATUS, this.onHTTPResponseStatus);
                    this.file.addEventListener(flash.events.ProgressEvent.PROGRESS, this.updateProgress);
                    this.file.addEventListener(flash.events.DataEvent.UPLOAD_COMPLETE_DATA, this.onFileUploadComplete);
                    this.file.addEventListener(flash.events.IOErrorEvent.IO_ERROR, this.fileError);
                    this.file.upload(request, this._uploadDataFieldName, false);
                }
            }
            catch (e:*)
            {
                dispatchEvent(new backend.sharing.SharingEvent(backend.sharing.SharingEvent.SHARING_ERROR, activity));
            }
            return;
        }

        internal function onHTTPResponseStatus(arg1:flash.events.HTTPStatusEvent):void
        {
            debug.Debug.debug("onHTTPResponseStatus: " + arg1.status);
            dispatchEvent(new backend.sharing.SharingEvent(backend.sharing.SharingEvent.SHARING_HTTP_RESPONSE_STATUS, this.activity, arg1));
            return;
        }

        internal function updateProgress(arg1:flash.events.ProgressEvent):void
        {
            debug.Debug.debug("updateProgress: loaded = " + arg1.bytesLoaded + ", total = " + arg1.bytesTotal);
            dispatchEvent(new backend.sharing.SharingEvent(backend.sharing.SharingEvent.SHARING_PROGRESS, this.activity, arg1, this.oauthInstance));
            return;
        }

        public var activity:core.activities.Activity;

        public var createURLRequestFunc:Function;

        public var customShareMessage:String;

        public var errorStatus:int=0;

        public var fileExtension:String;

        public var oauthInstance:frontend.components.popup.oauth.CustomOAuth;

        public var sharingGUID:String;

        public var uploadComplete:Boolean=false;

        public var uploadProgress:int=0;

        internal var _uploadDataFieldName:String="file";

        internal var _useURLLoader:Boolean=false;

        public var file:flash.filesystem.File;
    }
}


//  class ShareableDocument
package backend.sharing 
{
    import feathers.controls.*;
    import feathers.events.*;
    import flash.display.*;
    import starling.events.*;
    
    public class ShareableDocument extends flash.display.Sprite
    {
        public function ShareableDocument()
        {
            super();
            addEventListener(feathers.events.FeathersEventType.INITIALIZE, this.onInit);
            addEventListener(feathers.events.FeathersEventType.CREATION_COMPLETE, this.onCompleteCreated);
            return;
        }

        public function get shareImageWidth():int
        {
            return this._shareImageWidth;
        }

        public function set shareImageWidth(arg1:int):void
        {
            var loc1:*;
            width = loc1 = arg1;
            this._shareImageWidth = loc1;
            return;
        }

        internal function onInit(arg1:starling.events.Event):void
        {
            removeEventListener(feathers.events.FeathersEventType.INITIALIZE, this.onCompleteCreated);
            addChild(this.createHeader());
            addChild(this.createFooter());
            addChild(this.createContent());
            return;
        }

        protected function onCompleteCreated(arg1:starling.events.Event):void
        {
            removeEventListener(feathers.events.FeathersEventType.CREATION_COMPLETE, this.onCompleteCreated);
            this.completeCreated = true;
            return;
        }

        protected function createHeader():flash.display.DisplayObject
        {
            return null;
        }

        protected function createContent():flash.display.DisplayObject
        {
            return null;
        }

        protected function createFooter():flash.display.DisplayObject
        {
            return null;
        }

        public var completeCreated:Boolean=false;

        public var hGutter:Number=0;

        public var hasToCreate:Boolean=true;

        internal var _shareImageWidth:int=1500;

        public var totalPages:uint=0;

        public var vGutter:Number=0;

        protected var _header:feathers.controls.LayoutGroup;

        protected var _mxmlContentArray:Array;
    }
}


//  class SharingEvent
package backend.sharing 
{
    import core.activities.*;
    import flash.events.*;
    import flash.utils.*;
    import frontend.components.popup.oauth.*;
    
    public class SharingEvent extends flash.events.Event
    {
        public function SharingEvent(arg1:String, arg2:core.activities.Activity, arg3:flash.events.Event=null, arg4:frontend.components.popup.oauth.CustomOAuth=null, arg5:Boolean=false, arg6:Boolean=false)
        {
            super(arg1, arg5, arg6);
            this.activity = arg2;
            this.eventTarget = arg3;
            this.oauthInstance = arg4;
            return;
        }

        public static const MULTI_SHARING_FINISHED:String="multiSharingFinished";

        public static const SCREENSHOT_READY:String="EVENT_SCREENSHOT_READY";

        public static const SHARING_COMPLETE:String="sharingCompleteEvent";

        public static const SHARING_ERROR:String="sharingErrorEvent";

        public static const SHARING_HTTP_RESPONSE_STATUS:String="sharingHTTPResponseStatusEvent";

        public static const SHARING_PROGRESS:String="sharingProgressEvent";

        public var activity:core.activities.Activity;

        public var eventTarget:flash.events.Event;

        public var oauthInstance:frontend.components.popup.oauth.CustomOAuth;

        public var screenshot:flash.utils.ByteArray;
    }
}


