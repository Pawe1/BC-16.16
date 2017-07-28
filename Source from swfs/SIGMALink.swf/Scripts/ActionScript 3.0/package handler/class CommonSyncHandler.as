//class CommonSyncHandler
package handler 
{
    import __AS3__.vec.*;
    import backend.utils.dbUtils.*;
    import com.adobe.serialization.json.*;
    import core.activities.*;
    import core.general.*;
    import core.general.interfaces.*;
    import core.gps.*;
    import core.marker.*;
    import core.route.*;
    import core.settings.*;
    import core.sportprofiles.*;
    import core.totals.*;
    import core.training.*;
    import core.units.*;
    import core.user.*;
    import database.*;
    import debug.*;
    import flash.data.*;
    import flash.events.*;
    import flash.filesystem.*;
    import flash.net.*;
    import flash.utils.*;
    import nochump.util.zip.*;
    import service.cloud.*;
    import service.oauth.*;
    
    public class CommonSyncHandler extends flash.events.EventDispatcher
    {
        public function CommonSyncHandler(arg1:flash.events.IEventDispatcher=null)
        {
            this._deleteActivitiesAction = new service.cloud.CloudAction(handler.ActivityHandler.getInstance().deleteActivities, service.cloud.CloudAction.ACTION_DELETE);
            this._deleteDeviceDataAction = new service.cloud.CloudAction(handler.AppDeviceHandler.getInstance().deleteDeviceData, service.cloud.CloudAction.ACTION_DELETE);
            this._deletePointNavigationAction = new service.cloud.CloudAction(handler.AppDeviceHandler.getInstance().deletePointNavigations, service.cloud.CloudAction.ACTION_DELETE);
            this._deleteSettingsAction = new service.cloud.CloudAction(handler.AppDeviceHandler.getInstance().deleteSettings, service.cloud.CloudAction.ACTION_DELETE);
            this._deleteSportprofileAction = new service.cloud.CloudAction(handler.AppDeviceHandler.getInstance().deleteSportprofiles, service.cloud.CloudAction.ACTION_DELETE);
            this._deleteTotalsAction = new service.cloud.CloudAction(handler.AppDeviceHandler.getInstance().deleteTotals, service.cloud.CloudAction.ACTION_DELETE);
            this._deleteTracksAction = new service.cloud.CloudAction(handler.RouteHandler.getInstance().deleteRoutes, service.cloud.CloudAction.ACTION_DELETE);
            this._deleteTrainingProgramsAction = new service.cloud.CloudAction(handler.AppDeviceHandler.getInstance().deleteTrainings, service.cloud.CloudAction.ACTION_DELETE);
            this._deleteUnitsAction = new service.cloud.CloudAction(handler.AppDeviceHandler.getInstance().deleteUnits, service.cloud.CloudAction.ACTION_DELETE);
            this._tempDirs = new flash.utils.Dictionary();
            super(arg1);
            return;
        }

        
        {
            _access_token = "";
            _actionQueue = [];
            _currentSyncType = "";
            _isWorker = false;
            _requiredWorkerDataLoaded = false;
            _syncStatus = [];
        }

        internal function onDownloadComplete(arg1:flash.events.Event):void
        {
            var p_event:flash.events.Event;
            var urlStream:service.cloud.CloudURLStream;
            var zipFile:nochump.util.zip.ZipFile;
            var byteArray:flash.utils.ByteArray;
            var xmlString:String;
            var xml:XML;
            var setting:core.settings.Settings;
            var sportProfile:core.sportprofiles.Sportprofile;
            var pointNavigation:core.gps.PointNavigation;

            var loc1:*;
            urlStream = null;
            zipFile = null;
            byteArray = null;
            xmlString = null;
            xml = null;
            setting = null;
            sportProfile = null;
            pointNavigation = null;
            p_event = arg1;
            this.logSyncStatus("on download complete");
            urlStream = p_event.target as service.cloud.CloudURLStream;
            urlStream.removeEventListener(flash.events.Event.COMPLETE, this.onDownloadComplete);
            urlStream.removeEventListener(flash.events.IOErrorEvent.IO_ERROR, this.onDownloadError);
            urlStream.removeEventListener(flash.events.SecurityErrorEvent.SECURITY_ERROR, this.onSecurityError);
            if (this.syncStopped) 
            {
                this.onDownloadFromCloudComplete(urlStream.type);
                return;
            }
            try 
            {
                zipFile = new nochump.util.zip.ZipFile(urlStream);
                byteArray = zipFile.getInput(zipFile.entries[0]);
                xmlString = byteArray.readUTFBytes(byteArray.length);
                xml = new XML(xmlString.slice(xmlString.indexOf("<"), xmlString.length));
                byteArray.clear();
                loc2 = urlStream.type;
                switch (loc2) 
                {
                    case service.cloud.CloudConfig.TYPE_ACTIVITY:
                    {
                        handler.ActivityHandler.getInstance().downloadActivity(xml, urlStream);
                        break;
                    }
                    case service.cloud.CloudConfig.TYPE_TRACK:
                    {
                        handler.RouteHandler.getInstance().downloadRoute(xml, urlStream);
                        break;
                    }
                    case service.cloud.CloudConfig.TYPE_DEVICE:
                    {
                        handler.AppDeviceHandler.getInstance().downloadUnit(xml, urlStream);
                        break;
                    }
                    case service.cloud.CloudConfig.TYPE_TRAINING_PROGRAM:
                    {
                        handler.AppDeviceHandler.getInstance().downloadTrainingProgram(xml, urlStream);
                        break;
                    }
                    case service.cloud.CloudConfig.TYPE_DEVICE_TOTALS:
                    {
                        handler.AppDeviceHandler.getInstance().downloadTotals(xml, urlStream);
                        break;
                    }
                    case service.cloud.CloudConfig.TYPE_DEVICE_SETTING:
                    {
                        setting = core.settings.SettingsFactory.createSettingsFromSSF(xml);
                        sportProfile = core.sportprofiles.SportprofileMapper.fromXML(xml);
                        pointNavigation = core.gps.PointNavigationMapper.fromXML(xml);
                        if (setting) 
                        {
                            setting.GUID = urlStream.data.GUID;
                            setting.modificationDate = urlStream.data.modificationDate;
                            handler.AppDeviceHandler.getInstance().downloadSettings(setting);
                        }
                        else if (sportProfile) 
                        {
                            sportProfile.GUID = urlStream.data.GUID;
                            sportProfile.modificationDate = urlStream.data.modificationDate;
                            handler.AppDeviceHandler.getInstance().downloadSportprofile(sportProfile);
                        }
                        else if (pointNavigation) 
                        {
                            pointNavigation.GUID = urlStream.data.GUID;
                            pointNavigation.modificationDate = urlStream.data.modificationDate;
                            handler.AppDeviceHandler.getInstance().downloadPointNavigation(pointNavigation);
                        }
                        break;
                    }
                }
            }
            catch (e:Error)
            {
                logSyncStatus("------ XML ERROR (" + urlStream.type + "):\t" + e.message + "\n\nXMLString:\n" + xmlString);
                onDownloadFromCloudComplete(urlStream.type);
            }
            return;
        }

        internal function onSecurityError(arg1:flash.events.SecurityErrorEvent):void
        {
            this.logSyncStatus("on security Error");
            var loc1:*=arg1.target as service.cloud.CloudURLStream;
            loc1.removeEventListener(flash.events.Event.COMPLETE, this.onDownloadComplete);
            loc1.removeEventListener(flash.events.IOErrorEvent.IO_ERROR, this.onDownloadError);
            loc1.removeEventListener(flash.events.SecurityErrorEvent.SECURITY_ERROR, this.onSecurityError);
            var loc2:*;
            var loc3:*;
            var loc4:*=((loc2 = _syncStatus)[loc3 = DOWNLOADED_STATUS_INDEX] + 1);
            loc2[loc3] = loc4;
            this.logSyncStatus("download SecurityError: " + arg1.text);
            this.doNextAction();
            return;
        }

        internal function onDownloadError(arg1:flash.events.IOErrorEvent):void
        {
            this.logSyncStatus("on download Error");
            var loc1:*=arg1.target as service.cloud.CloudURLStream;
            loc1.removeEventListener(flash.events.Event.COMPLETE, this.onDownloadComplete);
            loc1.removeEventListener(flash.events.IOErrorEvent.IO_ERROR, this.onDownloadError);
            loc1.removeEventListener(flash.events.SecurityErrorEvent.SECURITY_ERROR, this.onSecurityError);
            var loc2:*;
            var loc3:*;
            var loc4:*=((loc2 = _syncStatus)[loc3 = DOWNLOADED_STATUS_INDEX] + 1);
            loc2[loc3] = loc4;
            this.logSyncStatus("download IOError: " + arg1.text);
            this.doNextAction();
            return;
        }

        internal function prepareDownload(arg1:String, arg2:Object):void
        {
            this.logSyncStatus("prepareDownload: " + arg1);
            var loc4:*;
            var loc5:*;
            var loc6:*=((loc4 = _syncStatus)[loc5 = TO_DOWNLOAD_STATUS_INDEX] + 1);
            loc4[loc5] = loc6;
            var loc1:*=new flash.net.URLRequest(arg2.url);
            var loc2:*=new service.cloud.CloudURLStream();
            loc2.data = arg2;
            loc2.type = arg1;
            loc2.addEventListener(flash.events.Event.COMPLETE, this.onDownloadComplete);
            loc2.addEventListener(flash.events.IOErrorEvent.IO_ERROR, this.onDownloadError);
            loc2.addEventListener(flash.events.SecurityErrorEvent.SECURITY_ERROR, this.onSecurityError);
            var loc3:*=new service.cloud.CloudAction(null, service.cloud.CloudAction.ACTION_DOWNLOAD, arg1);
            loc3.urlRequest = loc1;
            loc3.urlStream = loc2;
            _actionQueue.push(loc3);
            return;
        }

        public function onDeleteFromCloudComplete(arg1:String, arg2:Array):void
        {
            this.logSyncStatus("onDeleteFromCloudComplete: " + arg1);
            _syncStatus[DELETED_STATUS_INDEX] = _syncStatus[DELETED_STATUS_INDEX] + arg2.length;
            this.logSyncStatus("complete status (" + arg1 + "): " + _syncStatus[DELETED_STATUS_INDEX] + "/" + _syncStatus[TO_DELETE_STATUS_INDEX]);
            var loc1:*=new service.cloud.CloudEvent(service.cloud.CloudEvent.PROGRESS);
            loc1.syncStatus = _syncStatus;
            loc1.syncStatusType = STATUS_DELETE;
            loc1.dataType = arg1;
            dispatchEvent(loc1);
            this.doNextAction();
            return;
        }

        internal function prepareDelete(arg1:String, arg2:Object):void
        {
            var loc1:*=null;
            this.logSyncStatus("prepareDelete: " + arg1);
            var loc2:*=arg1;
            switch (loc2) 
            {
                case service.cloud.CloudConfig.TYPE_ACTIVITY:
                {
                    loc1 = this._deleteActivitiesAction;
                    break;
                }
                case service.cloud.CloudConfig.TYPE_TRACK:
                {
                    loc1 = this._deleteTracksAction;
                    break;
                }
                case service.cloud.CloudConfig.TYPE_DEVICE:
                {
                    loc1 = this._deleteUnitsAction;
                    break;
                }
                case service.cloud.CloudConfig.TYPE_TRAINING_PROGRAM:
                {
                    loc1 = this._deleteTrainingProgramsAction;
                    break;
                }
                case service.cloud.CloudConfig.TYPE_DEVICE_TOTALS:
                {
                    loc1 = this._deleteTotalsAction;
                    break;
                }
                case service.cloud.CloudConfig.TYPE_DEVICE_SETTING:
                {
                    loc1 = this._deleteDeviceDataAction;
                    break;
                }
            }
            if (_actionQueue.indexOf(loc1) == -1) 
            {
                _actionQueue.push(loc1);
                loc1.deleteList = [];
            }
            var loc3:*;
            var loc4:*=((loc2 = _syncStatus)[loc3 = TO_DELETE_STATUS_INDEX] + 1);
            loc2[loc3] = loc4;
            loc1.deleteList.push("\'" + arg2.GUID + "\'");
            return;
        }

        internal function onURLLoaderComplete(arg1:flash.events.Event):void
        {
            var p_event:flash.events.Event;
            var urlLoader:flash.net.URLLoader;
            var eventInfo:Object;

            var loc1:*;
            eventInfo = null;
            p_event = arg1;
            this.logSyncStatus("onURLLoaderComplete message: " + p_event.target.data);
            this.logSyncStatus("onURLLoaderComplete: " + p_event.toString());
            if (p_event.target.data.indexOf("message") != -1) 
            {
                try 
                {
                    eventInfo = com.adobe.serialization.json.JSON.decode(p_event.target.data);
                    if (eventInfo.hasOwnProperty("messages")) 
                    {
                        this.logSyncStatus("upload message: " + eventInfo.messages.messages[0]);
                    }
                }
                catch (e:Error)
                {
                    logSyncStatus("onURLLoaderComplete: invalid data, JSON decode failed..." + p_event.target.data);
                }
            }
            urlLoader = p_event.currentTarget as flash.net.URLLoader;
            urlLoader.removeEventListener(flash.events.Event.COMPLETE, this.onURLLoaderComplete);
            urlLoader.removeEventListener(flash.events.ProgressEvent.PROGRESS, this.updateProgress);
            urlLoader.removeEventListener(flash.events.IOErrorEvent.IO_ERROR, this.fileError);
            urlLoader.removeEventListener(flash.events.HTTPStatusEvent.HTTP_RESPONSE_STATUS, this.onHTTPResponseStatus);
            this.startNextUpload();
            return;
        }

        internal function onUpdateModificationDateError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            this.logSyncStatus("update modificationDate error...");
            return;
        }

        internal function onUpdateModificationDateComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            this.logSyncStatus("update modificationDate complete...");
            return;
        }

        internal function generateUploadData(arg1:*):flash.net.URLVariables
        {
            this.logSyncStatus("generateUploadData");
            var loc1:*=arg1 as core.general.interfaces.ISynchronisable;
            var loc2:*=new flash.net.URLVariables();
            loc2.GUID = loc1.GUID;
            loc2.modificationDate = new Date().time;
            loc2.access_token = _access_token;
            if (arg1 is core.activities.Activity) 
            {
                this.logSyncStatus("generateUploadData ::: Activity");
                loc2.distance = (arg1 as core.activities.Activity).distance;
                loc2.trainingTime = (arg1 as core.activities.Activity).trainingTime;
            }
            else if (arg1 is core.route.Route) 
            {
                this.logSyncStatus("generateUploadData ::: Route");
                loc2.name = "-";
                loc2.latitude = (arg1 as core.route.Route).latitudeStart;
                loc2.longitude = (arg1 as core.route.Route).longitudeStart;
                loc2.distance = (arg1 as core.route.Route).distance;
                loc2.altitudeUp = (arg1 as core.route.Route).altitudeDifferencesUphill;
                loc2.altitudeDown = (arg1 as core.route.Route).altitudeDifferencesDownhill;
            }
            else if (arg1 is core.units.Unit) 
            {
                this.logSyncStatus("generateUploadData ::: Unit");
                loc2.type = (arg1 as core.units.Unit).type.toString();
                loc2.serialnumber = (arg1 as core.units.Unit).serialNumber;
                loc2.softwareRevision = (arg1 as core.units.Unit).softwareRevision;
            }
            else if (arg1 is core.totals.Totals) 
            {
                this.logSyncStatus("generateUploadData ::: Totals");
            }
            else if (arg1 is core.settings.Settings) 
            {
                this.logSyncStatus("generateUploadData ::: Settings");
            }
            else if (arg1 is core.training.Training) 
            {
                this.logSyncStatus("generateUploadData ::: Training");
            }
            loc1.modificationDate = loc2.modificationDate;
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.UPDATE, handler.AppDeviceHandler.getInstance().getUpdateModificationDateSQLStatementString(loc1), this.onUpdateModificationDateComplete, this.onUpdateModificationDateError);
            return loc2;
        }

        internal function generateURLRequest(arg1:*, arg2:String):flash.net.URLRequest
        {
            var loc1:*=null;
            this.logSyncStatus("generateURLRequest");
            if (arg1 != null) 
            {
                loc1 = new flash.net.URLRequest(arg2);
                loc1.method = flash.net.URLRequestMethod.POST;
                loc1.contentType = "multipart/form-data";
                loc1.data = this.generateUploadData(arg1);
                return loc1;
            }
            return null;
        }

        internal function prepareUpload(arg1:String, arg2:Object, arg3:Boolean=false, arg4:String=""):void
        {
            var p_type:String;
            var p_data:Object;
            var p_createFile:Boolean=false;
            var p_mapperTableName:String="";
            var stmt:String;
            var xmlToUpload:XML;
            var urlRequest:flash.net.URLRequest;
            var cloudAction:service.cloud.CloudAction;
            var activity:core.activities.Activity;
            var user:core.user.User;
            var onLoadActivityComplete:Function;
            var clearActivity:Function;
            var onLoadAcitvityDataError:Function;
            var routeObj:core.route.Route;
            var onLoadRouteComplete:Function;
            var clearRoute:Function;
            var onLoadRouteError:Function;
            var unit:core.units.Unit;
            var onLoadUnitComplete:Function;
            var onLoadUnitError:Function;
            var trainingProgram:core.training.Training;
            var onLoadTrainingComplete:Function;
            var clearTraining:Function;
            var onLoadTrainingError:Function;
            var totals:core.totals.Totals;
            var onLoadTotalsComplete:Function;
            var clearTotals:Function;
            var onLoadTotalsError:Function;
            var isSetting:Boolean;
            var isSportprofile:Boolean;
            var isPointNavigation:Boolean;
            var settings:core.settings.Settings;
            var onLoadSettingsComplete:Function;
            var clearSetting:Function;
            var onLoadSettingsError:Function;
            var sportprofile:core.sportprofiles.Sportprofile;
            var onLoadSportprofileComplete:Function;
            var clearSport:Function;
            var onLoadSportprofileError:Function;
            var point:core.gps.PointNavigation;
            var onLoadPointNavigationsComplete:Function;
            var clearPointNavigation:Function;
            var onLoadPointNavigationsError:Function;

            var loc1:*;
            stmt = null;
            xmlToUpload = null;
            urlRequest = null;
            cloudAction = null;
            activity = null;
            user = null;
            onLoadAcitvityDataError = null;
            routeObj = null;
            onLoadRouteError = null;
            unit = null;
            trainingProgram = null;
            onLoadTrainingError = null;
            totals = null;
            isSetting = false;
            isSportprofile = false;
            isPointNavigation = false;
            settings = null;
            onLoadSettingsError = null;
            sportprofile = null;
            onLoadSportprofileError = null;
            point = null;
            onLoadPointNavigationsError = null;
            p_type = arg1;
            p_data = arg2;
            p_createFile = arg3;
            p_mapperTableName = arg4;
            if (!p_createFile) 
            {
                var loc2:*;
                var loc3:*;
                var loc4:*=((loc2 = _syncStatus)[loc3 = TO_UPLOAD_STATUS_INDEX] + 1);
                loc2[loc3] = loc4;
                cloudAction = new service.cloud.CloudAction(this.uploadFile, service.cloud.CloudAction.ACTION_UPLOAD, p_type, p_data, null);
                _actionQueue.push(cloudAction);
                return;
            }
            loc2 = p_type;
            switch (loc2) 
            {
                case service.cloud.CloudConfig.TYPE_ACTIVITY:
                {
                    onLoadActivityComplete = function (arg1:backend.utils.dbUtils.DBUtilEvent):void
                    {
                        var p_event:backend.utils.dbUtils.DBUtilEvent;
                        var result:Array;
                        var onLoadActivityEntriesComplete:Function;

                        var loc1:*;
                        result = null;
                        p_event = arg1;
                        result = p_event.getResult();
                        if (result.length != 1) 
                        {
                            startNextUpload();
                        }
                        else 
                        {
                            onLoadActivityEntriesComplete = function (arg1:backend.utils.dbUtils.DBUtilEvent):void
                            {
                                var p_event:backend.utils.dbUtils.DBUtilEvent;
                                var onLoadMarkerComplete:Function;

                                var loc1:*;
                                onLoadMarkerComplete = null;
                                p_event = arg1;
                                onLoadMarkerComplete = function (arg1:backend.utils.dbUtils.DBUtilEvent):void
                                {
                                    var p_event:backend.utils.dbUtils.DBUtilEvent;
                                    var onLoadUserComplete:Function;

                                    var loc1:*;
                                    onLoadUserComplete = null;
                                    p_event = arg1;
                                    onLoadUserComplete = function (arg1:backend.utils.dbUtils.DBUtilEvent):void
                                    {
                                        result = arg1.getResult();
                                        if (result.length != 1) 
                                        {
                                            user.name = core.user.User.DEFAULT_NAME;
                                        }
                                        else 
                                        {
                                            user.fromDB(result[0]);
                                        }
                                        if (p_data.modificationDate != activity.modificationDate) 
                                        {
                                            xmlToUpload = core.activities.ActivityMapper.generateXML(activity, user, true);
                                            fileToUpload = generateFile(service.cloud.CloudConfig.TYPE_ACTIVITY, generateZipOutput(xmlToUpload, service.cloud.CloudConfig.TYPE_ACTIVITY + "_" + activity.GUID).byteArray, activity.GUID);
                                            if (fileToUpload) 
                                            {
                                                urlRequest = generateURLRequest(activity, service.cloud.CloudConfig.UPLOAD_ACTIVITY_URL);
                                                uploadFile(fileToUpload, urlRequest);
                                                clearActivity();
                                                return;
                                            }
                                        }
                                        clearActivity();
                                        startNextUpload();
                                        return;
                                    }
                                    handler.ActivityHandler.getInstance().loadActivityMarkerComplete(p_event.getResult(), activity);
                                    stmt = handler.UserHandler.getInstance().loadUserStatement(activity.userId);
                                    backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, stmt, onLoadUserComplete, onLoadAcitvityDataError);
                                    return;
                                }
                                handler.ActivityHandler.getInstance().loadActivityEntriesComplete(p_event.getResult(), activity);
                                stmt = handler.ActivityHandler.getInstance().generateLoadActivityMarker(activity.activityId);
                                backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, stmt, onLoadMarkerComplete, onLoadAcitvityDataError);
                                return;
                            }
                            activity = core.activities.ActivityFactory.createLogFromDB(result[0], false);
                            stmt = handler.ActivityHandler.getInstance().generateLoadActivityEntries(activity.activityId);
                            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, stmt, onLoadActivityEntriesComplete, onLoadAcitvityDataError);
                        }
                        return;
                    }
                    clearActivity = function ():void
                    {
                        activity.entries = new Vector.<core.activities.ActivityEntry>();
                        activity.markerList = new Vector.<core.marker.Marker>();
                        fileToUpload = null;
                        return;
                    }
                    onLoadAcitvityDataError = function (arg1:backend.utils.dbUtils.DBUtilEvent):void
                    {
                        logSyncStatus("onLoadAcitvityDataError");
                        doNextAction();
                        return;
                    }
                    user = new core.user.User();
                    stmt = handler.ActivityHandler.getInstance().generateLoadActivityByGUIDStatement(p_data.GUID);
                    backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, stmt, onLoadActivityComplete, onLoadAcitvityDataError);
                    break;
                }
                case service.cloud.CloudConfig.TYPE_TRACK:
                {
                    onLoadRouteComplete = function (arg1:backend.utils.dbUtils.DBUtilEvent):void
                    {
                        var p_event:backend.utils.dbUtils.DBUtilEvent;
                        var result:Array;
                        var onLoadRoutePointsComplete:Function;

                        var loc1:*;
                        p_event = arg1;
                        result = p_event.getResult();
                        if (result.length != 1) 
                        {
                            startNextUpload();
                        }
                        else 
                        {
                            onLoadRoutePointsComplete = function (arg1:backend.utils.dbUtils.DBUtilEvent):void
                            {
                                var p_event:backend.utils.dbUtils.DBUtilEvent;
                                var onLoadOptionsComplete:Function;

                                var loc1:*;
                                onLoadOptionsComplete = null;
                                p_event = arg1;
                                onLoadOptionsComplete = function (arg1:backend.utils.dbUtils.DBUtilEvent):void
                                {
                                    var p_event:backend.utils.dbUtils.DBUtilEvent;
                                    var onLoadPOIsComplete:Function;

                                    var loc1:*;
                                    onLoadPOIsComplete = null;
                                    p_event = arg1;
                                    onLoadPOIsComplete = function (arg1:backend.utils.dbUtils.DBUtilEvent):void
                                    {
                                        handler.RouteHandler.getInstance().loadRoutePOIsComplete(arg1.getResult(), routeObj);
                                        if (p_data.modificationDate != routeObj.modificationDate) 
                                        {
                                            xmlToUpload = routeObj.generateXML();
                                            fileToUpload = generateFile(service.cloud.CloudConfig.TYPE_TRACK, generateZipOutput(xmlToUpload, service.cloud.CloudConfig.TYPE_TRACK + "_" + routeObj.GUID).byteArray, routeObj.GUID);
                                            if (fileToUpload) 
                                            {
                                                urlRequest = generateURLRequest(routeObj, service.cloud.CloudConfig.UPLOAD_TRACK_URL);
                                                uploadFile(fileToUpload, urlRequest);
                                                clearRoute();
                                                return;
                                            }
                                        }
                                        clearRoute();
                                        startNextUpload();
                                        return;
                                    }
                                    handler.RouteHandler.getInstance().loadRouteOptionsComplete(p_event.getResult(), routeObj);
                                    stmt = handler.RouteHandler.getInstance().generateLoadPOIs(routeObj.routeId);
                                    backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, stmt, onLoadPOIsComplete, onLoadRouteError);
                                    return;
                                }
                                handler.RouteHandler.getInstance().loadRoutePointsComplete(p_event.getResult(), routeObj);
                                stmt = handler.RouteHandler.getInstance().generateLoadOptions(routeObj.routeId);
                                backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, stmt, onLoadOptionsComplete, onLoadRouteError);
                                return;
                            }
                            routeObj.fromDB(result[0]);
                            stmt = handler.RouteHandler.getInstance().generateLoadRoutePoints(routeObj.routeId);
                            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, stmt, onLoadRoutePointsComplete, onLoadRouteError);
                        }
                        return;
                    }
                    clearRoute = function ():void
                    {
                        routeObj.routePoints = new Vector.<core.route.RoutePoint>();
                        routeObj.routeOptions = new Vector.<core.route.RouteOptions>();
                        routeObj.pois = new Vector.<core.route.RoutePoi>();
                        fileToUpload = null;
                        return;
                    }
                    onLoadRouteError = function (arg1:backend.utils.dbUtils.DBUtilEvent):void
                    {
                        logSyncStatus("onLoadRouteError");
                        doNextAction();
                        return;
                    }
                    routeObj = new core.route.Route();
                    stmt = handler.RouteHandler.getInstance().generateLoadRouteByGUIDStatement(p_data.GUID);
                    backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, stmt, onLoadRouteComplete, onLoadRouteError);
                    break;
                }
                case service.cloud.CloudConfig.TYPE_DEVICE:
                {
                    onLoadUnitComplete = function (arg1:backend.utils.dbUtils.DBUtilEvent):void
                    {
                        var loc1:*=arg1.getResult();
                        if (loc1.length == 1) 
                        {
                            unit = core.units.UnitFactory.createUnitFromType(new core.general.UnitType(loc1[0].type));
                            unit.fromDB(loc1[0]);
                            if (p_data.modificationDate != unit.modificationDate) 
                            {
                                xmlToUpload = core.units.Unit.generateXML(unit);
                                fileToUpload = generateFile(service.cloud.CloudConfig.TYPE_DEVICE, generateZipOutput(xmlToUpload, service.cloud.CloudConfig.TYPE_DEVICE + "_" + unit.GUID).byteArray, unit.GUID);
                                if (fileToUpload) 
                                {
                                    urlRequest = generateURLRequest(unit, service.cloud.CloudConfig.UPLOAD_DEVICE_URL);
                                    uploadFile(fileToUpload, urlRequest);
                                    fileToUpload = null;
                                    return;
                                }
                            }
                        }
                        fileToUpload = null;
                        startNextUpload();
                        return;
                    }
                    onLoadUnitError = function (arg1:backend.utils.dbUtils.DBUtilEvent):void
                    {
                        logSyncStatus("onLoadUnitError");
                        return;
                    }
                    stmt = handler.AppDeviceHandler.getInstance().generateLoadUnitByGUIDStatement(p_data.GUID);
                    backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, stmt, onLoadUnitComplete, onLoadUnitError);
                    break;
                }
                case service.cloud.CloudConfig.TYPE_TRAINING_PROGRAM:
                {
                    onLoadTrainingComplete = function (arg1:backend.utils.dbUtils.DBUtilEvent):void
                    {
                        var p_event:backend.utils.dbUtils.DBUtilEvent;
                        var result:Array;
                        var onLoadTrainingPhaseComplete:Function;

                        var loc1:*;
                        p_event = arg1;
                        result = p_event.getResult();
                        if (result.length != 1) 
                        {
                            startNextUpload();
                        }
                        else 
                        {
                            onLoadTrainingPhaseComplete = function (arg1:backend.utils.dbUtils.DBUtilEvent):void
                            {
                                handler.AppDeviceHandler.getInstance().loadTrainingPhaseComplete(arg1.getResult(), trainingProgram);
                                if (p_data.modificationDate != trainingProgram.modificationDate) 
                                {
                                    xmlToUpload = core.training.TrainingMapper.generateXML(trainingProgram);
                                    fileToUpload = generateFile(service.cloud.CloudConfig.TYPE_TRAINING_PROGRAM, generateZipOutput(xmlToUpload, service.cloud.CloudConfig.TYPE_TRAINING_PROGRAM + "_" + trainingProgram.GUID).byteArray, trainingProgram.GUID);
                                    if (fileToUpload) 
                                    {
                                        urlRequest = generateURLRequest(trainingProgram, service.cloud.CloudConfig.UPLOAD_TRAINING_PROGRAM_URL);
                                        uploadFile(fileToUpload, urlRequest);
                                        clearTraining();
                                        return;
                                    }
                                }
                                clearTraining();
                                startNextUpload();
                                return;
                            }
                            trainingProgram = new core.training.Training();
                            core.training.TrainingMapper.fromDB(trainingProgram, result[0]);
                            stmt = handler.AppDeviceHandler.getInstance().generateLoadTrainingPhase(trainingProgram.trainingId);
                            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, stmt, onLoadTrainingPhaseComplete, onLoadTrainingError);
                        }
                        return;
                    }
                    clearTraining = function ():void
                    {
                        trainingProgram.phasesList = new Vector.<core.training.TrainingPhase>();
                        fileToUpload = null;
                        return;
                    }
                    onLoadTrainingError = function (arg1:backend.utils.dbUtils.DBUtilEvent):void
                    {
                        logSyncStatus("onLoadTrainingError");
                        return;
                    }
                    stmt = handler.AppDeviceHandler.getInstance().generateLoadTrainingByGUIDStatement(p_data.GUID);
                    backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, stmt, onLoadTrainingComplete, onLoadTrainingError);
                    break;
                }
                case service.cloud.CloudConfig.TYPE_DEVICE_TOTALS:
                {
                    onLoadTotalsComplete = function (arg1:backend.utils.dbUtils.DBUtilEvent):void
                    {
                        var loc1:*=arg1.getResult();
                        if (loc1.length == 1) 
                        {
                            totals = new core.totals.Totals();
                            totals.fromDB(loc1[0]);
                            if (p_data.modificationDate != totals.modificationDate) 
                            {
                                xmlToUpload = core.totals.Totals.generateXML(totals);
                                fileToUpload = generateFile(service.cloud.CloudConfig.TYPE_DEVICE_TOTALS, generateZipOutput(xmlToUpload, service.cloud.CloudConfig.TYPE_DEVICE_TOTALS + "_" + totals.GUID).byteArray, totals.GUID);
                                if (fileToUpload) 
                                {
                                    urlRequest = generateURLRequest(totals, service.cloud.CloudConfig.UPLOAD_DEVICE_TOTALS_URL);
                                    uploadFile(fileToUpload, urlRequest);
                                    clearTotals();
                                    return;
                                }
                            }
                            clearTotals();
                        }
                        startNextUpload();
                        return;
                    }
                    clearTotals = function ():void
                    {
                        fileToUpload = null;
                        return;
                    }
                    onLoadTotalsError = function (arg1:backend.utils.dbUtils.DBUtilEvent):void
                    {
                        logSyncStatus("onLoadTotalsError");
                        return;
                    }
                    stmt = handler.AppDeviceHandler.getInstance().generateLoadTrainingByGUIDStatement(p_data.GUID);
                    backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, stmt, onLoadTotalsComplete, onLoadTotalsError);
                    break;
                }
                case service.cloud.CloudConfig.TYPE_DEVICE_SETTING:
                {
                    isSetting = p_mapperTableName == core.settings.SettingsMapper.table_name;
                    isSportprofile = p_mapperTableName == core.sportprofiles.SportprofileMapper.TABLE_NAME;
                    isPointNavigation = p_mapperTableName == core.gps.PointNavigationMapper.table_name;
                    if (isSetting) 
                    {
                        onLoadSettingsComplete = function (arg1:backend.utils.dbUtils.DBUtilEvent):void
                        {
                            var p_event:backend.utils.dbUtils.DBUtilEvent;
                            var settingResult:Array;
                            var unit:core.units.Unit;
                            var onLoadUnitForSettingComplete:Function;

                            var loc1:*;
                            settingResult = null;
                            unit = null;
                            p_event = arg1;
                            settingResult = p_event.getResult();
                            if (settingResult.length != 1) 
                            {
                                startNextUpload();
                            }
                            else 
                            {
                                onLoadUnitForSettingComplete = function (arg1:backend.utils.dbUtils.DBUtilEvent):void
                                {
                                    var loc1:*=arg1.getResult();
                                    if (loc1.length == 1) 
                                    {
                                        unit = core.units.UnitFactory.createUnitFromType(new core.general.UnitType(loc1[0].type));
                                        unit.fromDB(loc1[0]);
                                        settings = core.settings.SettingsFactory.createSettingsFromUnitType(unit.type);
                                        core.settings.SettingsMapper.fromDB(settings, settingResult[0]);
                                        settings.unit = unit;
                                        settings.unitType = unit.type;
                                        if (p_data.modificationDate != settings.modificationDate) 
                                        {
                                            xmlToUpload = settings.generateSSF();
                                            fileToUpload = generateFile(service.cloud.CloudConfig.TYPE_DEVICE_SETTING, generateZipOutput(xmlToUpload, service.cloud.CloudConfig.TYPE_DEVICE_SETTING + "_" + settings.GUID).byteArray, settings.GUID);
                                            if (fileToUpload) 
                                            {
                                                urlRequest = generateURLRequest(settings, service.cloud.CloudConfig.UPLOAD_DEVICE_SETTINGS_URL);
                                                uploadFile(fileToUpload, urlRequest);
                                                clearSetting();
                                                return;
                                            }
                                        }
                                    }
                                    clearSetting();
                                    startNextUpload();
                                    return;
                                }
                                stmt = handler.AppDeviceHandler.getInstance().generateLoadUnitByGUIDStatement(settingResult[0].unitGUID);
                                backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, stmt, onLoadUnitForSettingComplete, onLoadSettingsError);
                            }
                            return;
                        }
                        clearSetting = function ():void
                        {
                            fileToUpload = null;
                            return;
                        }
                        onLoadSettingsError = function (arg1:backend.utils.dbUtils.DBUtilEvent):void
                        {
                            logSyncStatus("onLoadSettingsError");
                            return;
                        }
                        stmt = handler.AppDeviceHandler.getInstance().generateLoadSettingsByGUIDStatement(p_data.GUID);
                        backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, stmt, onLoadSettingsComplete, onLoadSettingsError);
                    }
                    else if (isSportprofile) 
                    {
                        onLoadSportprofileComplete = function (arg1:backend.utils.dbUtils.DBUtilEvent):void
                        {
                            var p_event:backend.utils.dbUtils.DBUtilEvent;
                            var sportprofileResult:Array;
                            var unit:core.units.Unit;
                            var onLoadUnitForSportprofileComplete:Function;

                            var loc1:*;
                            sportprofileResult = null;
                            unit = null;
                            p_event = arg1;
                            sportprofileResult = p_event.getResult();
                            if (sportprofileResult.length != 1) 
                            {
                                startNextUpload();
                            }
                            else 
                            {
                                onLoadUnitForSportprofileComplete = function (arg1:backend.utils.dbUtils.DBUtilEvent):void
                                {
                                    var loc1:*=arg1.getResult();
                                    if (loc1.length == 1) 
                                    {
                                        unit = core.units.UnitFactory.createUnitFromType(new core.general.UnitType(loc1[0].type));
                                        unit.fromDB(loc1[0]);
                                        sportprofile = core.sportprofiles.SportprofileMapper.fromDB(sportprofileResult[0], sportprofile, unit);
                                        if (p_data.modificationDate != sportprofile.modificationDate) 
                                        {
                                            xmlToUpload = core.sportprofiles.SportprofileMapper.generateXML(sportprofile);
                                            fileToUpload = generateFile(service.cloud.CloudConfig.TYPE_DEVICE_SETTING, generateZipOutput(xmlToUpload, service.cloud.CloudConfig.TYPE_DEVICE_SETTING + "_" + sportprofile.GUID).byteArray, sportprofile.GUID);
                                            if (fileToUpload) 
                                            {
                                                urlRequest = generateURLRequest(sportprofile, service.cloud.CloudConfig.UPLOAD_DEVICE_SETTINGS_URL);
                                                uploadFile(fileToUpload, urlRequest);
                                                clearSport();
                                                return;
                                            }
                                        }
                                    }
                                    clearSport();
                                    startNextUpload();
                                    return;
                                }
                                stmt = handler.AppDeviceHandler.getInstance().generateLoadUnitByGUIDStatement(sportprofileResult[0].unitGUID);
                                backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, stmt, onLoadUnitForSportprofileComplete, onLoadSportprofileError);
                            }
                            return;
                        }
                        clearSport = function ():void
                        {
                            fileToUpload = null;
                            return;
                        }
                        onLoadSportprofileError = function (arg1:backend.utils.dbUtils.DBUtilEvent):void
                        {
                            logSyncStatus("onLoadSportprofileError");
                            return;
                        }
                        stmt = handler.AppDeviceHandler.getInstance().generateLoadSportprofileByGUIDStatement(p_data.GUID);
                        backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, stmt, onLoadSportprofileComplete, onLoadSportprofileError);
                    }
                    else if (isPointNavigation) 
                    {
                        onLoadPointNavigationsComplete = function (arg1:backend.utils.dbUtils.DBUtilEvent):void
                        {
                            var p_event:backend.utils.dbUtils.DBUtilEvent;
                            var pointsResult:Array;
                            var unit:core.units.Unit;
                            var onLoadUnitForPointNavigationComplete:Function;

                            var loc1:*;
                            pointsResult = null;
                            unit = null;
                            p_event = arg1;
                            pointsResult = p_event.getResult();
                            if (pointsResult.length != 1) 
                            {
                                startNextUpload();
                            }
                            else 
                            {
                                onLoadUnitForPointNavigationComplete = function (arg1:backend.utils.dbUtils.DBUtilEvent):void
                                {
                                    var loc1:*=arg1.getResult();
                                    if (loc1.length == 1) 
                                    {
                                        unit = core.units.UnitFactory.createUnitFromType(new core.general.UnitType(loc1[0].type));
                                        unit.fromDB(loc1[0]);
                                        point = core.gps.PointNavigationMapper.fromDB(pointsResult[0]);
                                        if (p_data.modificationDate != point.modificationDate) 
                                        {
                                            xmlToUpload = core.gps.PointNavigationMapper.generateXML(point);
                                            fileToUpload = generateFile(service.cloud.CloudConfig.TYPE_DEVICE_SETTING, generateZipOutput(xmlToUpload, service.cloud.CloudConfig.TYPE_DEVICE_SETTING + "_" + point.GUID).byteArray, point.GUID);
                                            if (fileToUpload) 
                                            {
                                                urlRequest = generateURLRequest(point, service.cloud.CloudConfig.UPLOAD_DEVICE_SETTINGS_URL);
                                                uploadFile(fileToUpload, urlRequest);
                                                clearPointNavigation();
                                                return;
                                            }
                                        }
                                    }
                                    clearPointNavigation();
                                    startNextUpload();
                                    return;
                                }
                                stmt = handler.AppDeviceHandler.getInstance().generateLoadUnitByGUIDStatement(pointsResult[0].unitGUID);
                                backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, stmt, onLoadUnitForPointNavigationComplete, onLoadPointNavigationsError);
                            }
                            return;
                        }
                        clearPointNavigation = function ():void
                        {
                            fileToUpload = null;
                            return;
                        }
                        onLoadPointNavigationsError = function (arg1:backend.utils.dbUtils.DBUtilEvent):void
                        {
                            logSyncStatus("onLoadPointNavigationsError");
                            return;
                        }
                        stmt = handler.AppDeviceHandler.getInstance().generateLoadPointNavigationsByGUIDStatement(p_data.GUID);
                        backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, stmt, onLoadPointNavigationsComplete, onLoadPointNavigationsError);
                    }
                    break;
                }
            }
            return;
        }

        internal function onHTTPResponseStatus(arg1:flash.events.HTTPStatusEvent):void
        {
            this.logSyncStatus("onHTTPResponseStatus: " + arg1.toString());
            return;
        }

        internal function startNextUpload():void
        {
            var loc2:*;
            var loc3:*;
            var loc4:*=((loc2 = _syncStatus)[loc3 = UPLOADED_STATUS_INDEX] + 1);
            loc2[loc3] = loc4;
            var loc1:*=new service.cloud.CloudEvent(service.cloud.CloudEvent.PROGRESS);
            loc1.syncStatus = _syncStatus;
            loc1.syncStatusType = STATUS_UPLOAD;
            loc1.dataType = _currentSyncType;
            dispatchEvent(loc1);
            this.doNextAction();
            return;
        }

        internal function fileError(arg1:flash.events.IOErrorEvent):void
        {
            this.logSyncStatus("fileError: " + arg1.toString());
            this.logSyncStatus("onUploadToCloudError: " + arg1.toString());
            var loc1:*=arg1.text;
            this.logSyncStatus("Error: " + loc1);
            this.startNextUpload();
            return;
        }

        internal function updateProgress(arg1:flash.events.ProgressEvent):void
        {
            this.logSyncStatus("updateProgress: " + arg1.toString());
            return;
        }

        public function logSyncStatus(arg1:String):void
        {
            debug.Debug.cloud("[CommonSyncHandler] " + arg1 + " - sync stopped: " + this.syncStopped);
            return;
        }

        public function stopSync():void
        {
            this.syncStopped = true;
            return;
        }

        public function readAnswer(arg1:String, arg2:Boolean, arg3:String):void
        {
            var p_answer:String;
            var p_isWorker:Boolean;
            var p_access_token:String;
            var answerObject:Object;

            var loc1:*;
            answerObject = null;
            p_answer = arg1;
            p_isWorker = arg2;
            p_access_token = arg3;
            this.syncStopped = false;
            this.logSyncStatus("readAnswer: " + p_answer);
            _syncStatus = [0, 0, 0, 0, 0, 0];
            _isWorker = p_isWorker;
            _access_token = p_access_token;
            this.dataList = [];
            _actionQueue = [];
            try 
            {
                answerObject = com.adobe.serialization.json.JSON.decode(p_answer);
                _currentSyncType = answerObject.dataLists[0].type;
                this.dataList = answerObject.dataLists[0].dataList;
                this.doPrepareAction();
            }
            catch (e:Error)
            {
                if (p_answer.indexOf("invalid_token") != -1) 
                {
                    logSyncStatus("syn answer > invalid token");
                }
                if (errorCallback != null) 
                {
                    errorCallback(e.message);
                }
            }
            return;
        }

        public function onDownloadFromCloudComplete(arg1:String):void
        {
            var loc2:*;
            var loc3:*;
            var loc4:*=((loc2 = _syncStatus)[loc3 = DOWNLOADED_STATUS_INDEX] + 1);
            loc2[loc3] = loc4;
            this.logSyncStatus("complete status (" + arg1 + "): " + _syncStatus[DOWNLOADED_STATUS_INDEX] + "/" + _syncStatus[TO_DOWNLOAD_STATUS_INDEX]);
            var loc1:*=new service.cloud.CloudEvent(service.cloud.CloudEvent.PROGRESS);
            loc1.syncStatus = _syncStatus;
            loc1.syncStatusType = STATUS_DOWNLOAD;
            loc1.dataType = arg1;
            dispatchEvent(loc1);
            if (this.progressCallback != null) 
            {
                this.progressCallback(loc1);
            }
            this.doNextAction();
            return;
        }

        internal function doPrepareAction():void
        {
            var loc1:*=null;
            var loc2:*=null;
            this.logSyncStatus("doPrepareAction");
            this.logSyncStatus("_actionQueue.length: " + _actionQueue.length);
            if (_actionQueue.length > 0) 
            {
                loc1 = _actionQueue.shift() as service.cloud.CloudAction;
                if (loc1.action != service.cloud.CloudAction.LOAD_DATA) 
                {
                    this.logSyncStatus("keine PrepareAction!?!?");
                    this.doPrepareAction();
                }
                else 
                {
                    loc1.loadData(this.doPrepareAction);
                }
            }
            else 
            {
                this.dataList.sortOn("status");
                _actionQueue = [];
                var loc3:*=0;
                var loc4:*=this.dataList;
                label298: for each (loc2 in loc4) 
                {
                    var loc5:*=loc2.status;
                    switch (loc5) 
                    {
                        case STATUS_DELETE:
                        {
                            this.prepareDelete(_currentSyncType, loc2);
                            continue label298;
                        }
                        case STATUS_UPLOAD:
                        {
                            this.prepareUpload(_currentSyncType, loc2, false);
                            continue label298;
                        }
                        case STATUS_DOWNLOAD:
                        {
                            this.prepareDownload(_currentSyncType, loc2);
                            continue label298;
                        }
                    }
                }
                this.dataList = [];
                this.doNextAction();
            }
            return;
        }

        internal function doNextAction():void
        {
            var cloudAction:service.cloud.CloudAction;
            var guid:String;
            var stmt:String;
            var res:Array;
            var checkSettings:Function;
            var onCheckSettingsComplete:Function;
            var checkSportprofile:Function;
            var onCheckSportprofileComplete:Function;
            var checkPointNavigation:Function;
            var onCheckPointNavigationComplete:Function;
            var onCheckClassError:Function;

            var loc1:*;
            cloudAction = null;
            guid = null;
            stmt = null;
            res = null;
            onCheckSettingsComplete = null;
            onCheckSportprofileComplete = null;
            onCheckPointNavigationComplete = null;
            onCheckClassError = null;
            this.logSyncStatus("doNextAction");
            this.logSyncStatus("_actionQueue.length: " + _actionQueue.length + ", type: " + _currentSyncType);
            if (this.syncStopped) 
            {
                _actionQueue = [];
            }
            this.checkSyncComplete();
            if (_actionQueue.length) 
            {
                cloudAction = _actionQueue.shift() as service.cloud.CloudAction;
                var loc2:*=cloudAction.action;
                switch (loc2) 
                {
                    case service.cloud.CloudAction.ACTION_UPLOAD:
                    {
                        this.logSyncStatus("do next action: " + cloudAction.type + " - upload");
                        if (cloudAction.file == null) 
                        {
                            if (cloudAction.type != service.cloud.CloudConfig.TYPE_DEVICE_SETTING) 
                            {
                                this.prepareUpload(cloudAction.type, cloudAction.data, true);
                            }
                            else 
                            {
                                checkSettings = function ():void
                                {
                                    stmt = "SELECT * FROM " + core.settings.SettingsMapper.table_name + " WHERE " + core.settings.SettingsMapper.col_GUID + " = \'" + guid + "\'";
                                    backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, stmt, onCheckSettingsComplete, onCheckClassError);
                                    return;
                                }
                                onCheckSettingsComplete = function (arg1:backend.utils.dbUtils.DBUtilEvent):void
                                {
                                    res = arg1.getResult();
                                    if (res.length != 1) 
                                    {
                                        checkSportprofile();
                                    }
                                    else 
                                    {
                                        prepareUpload(cloudAction.type, cloudAction.data, true, core.settings.SettingsMapper.table_name);
                                    }
                                    return;
                                }
                                checkSportprofile = function ():void
                                {
                                    stmt = "SELECT * FROM " + core.sportprofiles.SportprofileMapper.TABLE_NAME + " WHERE " + core.sportprofiles.SportprofileMapper.col_GUID + " = \'" + guid + "\'";
                                    backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, stmt, onCheckSportprofileComplete, onCheckClassError);
                                    return;
                                }
                                onCheckSportprofileComplete = function (arg1:backend.utils.dbUtils.DBUtilEvent):void
                                {
                                    res = arg1.getResult();
                                    if (res.length != 1) 
                                    {
                                        checkPointNavigation();
                                    }
                                    else 
                                    {
                                        prepareUpload(cloudAction.type, cloudAction.data, true, core.sportprofiles.SportprofileMapper.TABLE_NAME);
                                    }
                                    return;
                                }
                                checkPointNavigation = function ():void
                                {
                                    stmt = "SELECT * FROM " + core.gps.PointNavigationMapper.table_name + " WHERE " + core.gps.PointNavigationMapper.col_GUID + " = \'" + guid + "\'";
                                    backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, stmt, onCheckPointNavigationComplete, onCheckClassError);
                                    return;
                                }
                                onCheckPointNavigationComplete = function (arg1:backend.utils.dbUtils.DBUtilEvent):void
                                {
                                    res = arg1.getResult();
                                    if (res.length != 1) 
                                    {
                                        logSyncStatus("unknown data - sync type DEVICE_SETTINGS - GUID: " + guid);
                                        prepareUpload(cloudAction.type, cloudAction.data, true);
                                    }
                                    else 
                                    {
                                        prepareUpload(cloudAction.type, cloudAction.data, true, core.gps.PointNavigationMapper.table_name);
                                    }
                                    return;
                                }
                                onCheckClassError = function (arg1:backend.utils.dbUtils.DBUtilEvent):void
                                {
                                    logSyncStatus("onCheckClassError");
                                    prepareUpload(cloudAction.type, cloudAction.data, true);
                                    return;
                                }
                                guid = cloudAction.data.GUID;
                                checkSettings();
                            }
                        }
                        else 
                        {
                            this.uploadFile(cloudAction.file, cloudAction.urlRequest);
                        }
                        break;
                    }
                    case service.cloud.CloudAction.ACTION_DOWNLOAD:
                    {
                        this.logSyncStatus("do next action: " + cloudAction.type + " - download");
                        cloudAction.urlStream.load(cloudAction.urlRequest);
                        break;
                    }
                    case service.cloud.CloudAction.ACTION_DELETE:
                    {
                        this.logSyncStatus("do next action: delete");
                        cloudAction.func(cloudAction.deleteList);
                        break;
                    }
                    default:
                    {
                        this.logSyncStatus("keine Action!?!?");
                        this.doNextAction();
                    }
                }
            }
            return;
        }

        internal function checkSyncComplete():void
        {
            this.logSyncStatus("checkSyncComplete");
            var loc1:*=_syncStatus[TO_DELETE_STATUS_INDEX] == _syncStatus[DELETED_STATUS_INDEX];
            var loc2:*=_syncStatus[TO_UPLOAD_STATUS_INDEX] == _syncStatus[UPLOADED_STATUS_INDEX];
            var loc3:*=_syncStatus[TO_DOWNLOAD_STATUS_INDEX] == _syncStatus[DOWNLOADED_STATUS_INDEX];
            if (loc1 && loc2 && loc3 || this.syncStopped) 
            {
                this.clearTempDirs(_currentSyncType);
                if (_currentSyncType == service.cloud.CloudConfig.TYPE_DEVICE_TOTALS || this.syncStopped) 
                {
                    new database.DatabaseTransaction(this.compactDB, [], flash.data.SQLMode.UPDATE).commit();
                }
                else 
                {
                    this.dispatchCompleteEvents();
                }
            }
            return;
        }

        internal function compactDB():void
        {
            this.logSyncStatus("compactDB - syncStopped: " + this.syncStopped);
            handler.AppDBHandler.getInstance().commit();
            this.dispatchCompleteEvents();
            return;
        }

        internal function dispatchCompleteEvents():void
        {
            this.logSyncStatus("dispatchCompleteEvents");
            var loc1:*=new service.cloud.CloudEvent(service.cloud.CloudEvent.PROGRESS);
            loc1.syncStatus = _syncStatus;
            loc1.dataType = _currentSyncType;
            if (this.completeCallback != null) 
            {
                this.completeCallback(loc1);
            }
            return;
        }

        internal function dispatchProgressEvent():void
        {
            this.logSyncStatus("dispatchProgressEvent");
            var loc1:*=new service.cloud.CloudEvent(service.cloud.CloudEvent.PROGRESS);
            loc1.syncStatus = _syncStatus;
            loc1.dataType = _currentSyncType;
            if (this.progressCallback != null) 
            {
                this.progressCallback(loc1);
            }
            return;
        }

        internal function clearTempDirs(arg1:String):void
        {
            var p_type:String;
            var tmpDir:flash.filesystem.File;

            var loc1:*;
            p_type = arg1;
            this.logSyncStatus("clearTempDirs: " + p_type);
            tmpDir = this._tempDirs[p_type];
            if (tmpDir) 
            {
                try 
                {
                    tmpDir.deleteDirectoryAsync(true);
                    delete this._tempDirs[p_type];
                    this.logSyncStatus("------------- ## TEMP-DIR deleted: " + tmpDir.nativePath);
                }
                catch (e:Error)
                {
                    logSyncStatus("cannot delete directory: " + e.message);
                }
            }
            return;
        }

        internal function resolveTempDir(arg1:String):flash.filesystem.File
        {
            var p_type:String;
            var tmpDir:flash.filesystem.File;

            var loc1:*;
            p_type = arg1;
            this.logSyncStatus("resolveTempDir: " + p_type);
            tmpDir = this._tempDirs[p_type];
            if (!tmpDir) 
            {
                try 
                {
                    tmpDir = flash.filesystem.File.documentsDirectory.resolvePath("tmp");
                    this._tempDirs[p_type] = tmpDir;
                    this.logSyncStatus("------------- ## TEMP-DIR created: " + tmpDir.nativePath);
                }
                catch (e:Error)
                {
                    logSyncStatus("cannot create directory: " + e.message);
                }
            }
            return tmpDir;
        }

        internal function generateZipOutput(arg1:XML, arg2:String):nochump.util.zip.ZipOutput
        {
            this.logSyncStatus("generateZipOutput: " + arg2);
            var loc1:*=arg2 + ".bin";
            var loc2:*=new flash.utils.ByteArray();
            var loc3:*=arg1.toString();
            loc2.writeUTFBytes(arg1);
            var loc4:*=new nochump.util.zip.ZipOutput();
            var loc5:*=new nochump.util.zip.ZipEntry(loc1);
            loc4.putNextEntry(loc5);
            loc4.write(loc2);
            loc4.closeEntry();
            loc4.finish();
            loc2.clear();
            return loc4;
        }

        internal function generateFile(arg1:String, arg2:*, arg3:String):flash.filesystem.File
        {
            this.logSyncStatus("generateFile: " + arg1);
            var loc1:*=this.resolveTempDir(arg1).resolvePath(arg3);
            var loc2:*=new flash.filesystem.FileStream();
            loc2.open(loc1, flash.filesystem.FileMode.WRITE);
            if (arg2 is XML) 
            {
                loc2.writeUTFBytes((arg2 as XML).toString());
            }
            else if (arg2 is flash.utils.ByteArray) 
            {
                loc2.writeBytes(arg2);
            }
            loc2.close();
            return loc1;
        }

        internal function uploadFile(arg1:flash.filesystem.File, arg2:flash.net.URLRequest):void
        {
            var p_file:flash.filesystem.File;
            var p_request:flash.net.URLRequest;
            var fs:flash.filesystem.FileStream;
            var ba:flash.utils.ByteArray;
            var urlLoader:flash.net.URLLoader;

            var loc1:*;
            fs = null;
            ba = null;
            urlLoader = null;
            p_file = arg1;
            p_request = arg2;
            this.logSyncStatus("uploadFile path: " + p_file.nativePath);
            this.logSyncStatus("uploadFile url: " + p_request.url);
            try 
            {
                fs = new flash.filesystem.FileStream();
                ba = new flash.utils.ByteArray();
                fs.open(p_file, flash.filesystem.FileMode.READ);
                fs.readBytes(ba);
                fs.close();
                p_request.contentType = "multipart/form-data; boundary=" + service.oauth.UploadPostHelper.getBoundary();
                p_request.method = flash.net.URLRequestMethod.POST;
                p_request.data = service.oauth.UploadPostHelper.getPostData("ACTIVITY_" + p_file.name, ba, p_request.data);
                p_request.requestHeaders.push(new flash.net.URLRequestHeader("Cache-Control", "no-cache"));
                urlLoader = new flash.net.URLLoader();
                urlLoader.addEventListener(flash.events.Event.COMPLETE, this.onURLLoaderComplete);
                urlLoader.addEventListener(flash.events.ProgressEvent.PROGRESS, this.updateProgress);
                urlLoader.addEventListener(flash.events.IOErrorEvent.IO_ERROR, this.fileError);
                urlLoader.addEventListener(flash.events.HTTPStatusEvent.HTTP_RESPONSE_STATUS, this.onHTTPResponseStatus);
                urlLoader.load(p_request);
                ba.clear();
            }
            catch (e:Error)
            {
                logSyncStatus("++++++++++++++ uploadFile error: ..." + p_file.nativePath);
            }
            this.logSyncStatus("++++++ ============================ uploadFile fertig warte auf events ==================================");
            return;
        }

        public static function getInstance():handler.CommonSyncHandler
        {
            if (!_instance) 
            {
                _instance = new CommonSyncHandler();
            }
            return _instance;
        }

        public static const DELETED_STATUS_INDEX:uint=5;

        public static const TO_DELETE_STATUS_INDEX:uint=4;

        public static const TO_DOWNLOAD_STATUS_INDEX:uint=0;

        public static const TO_UPLOAD_STATUS_INDEX:uint=2;

        public static const UPLOADED_STATUS_INDEX:uint=3;

        internal static const STATUS_DELETE:String="DELETE";

        internal static const STATUS_DOWNLOAD:String="DOWNLOAD";

        internal static const STATUS_UPLOAD:String="UPLOAD";

        public static const DOWNLOADED_STATUS_INDEX:uint=1;

        internal var _deletePointNavigationAction:service.cloud.CloudAction;

        internal var _deleteDeviceDataAction:service.cloud.CloudAction;

        internal var _deleteActivitiesAction:service.cloud.CloudAction;

        public var updateCacheCallback:Function;

        public var progressCallback:Function;

        public var errorCallback:Function;

        internal var syncStopped:Boolean=false;

        public var completeCallback:Function;

        internal var fileToUpload:flash.filesystem.File;

        internal var dataList:Array;

        internal var _tempDirs:flash.utils.Dictionary;

        internal var _deleteUnitsAction:service.cloud.CloudAction;

        internal var _deleteTrainingProgramsAction:service.cloud.CloudAction;

        internal var _deleteTracksAction:service.cloud.CloudAction;

        internal var _deleteTotalsAction:service.cloud.CloudAction;

        internal var _deleteSettingsAction:service.cloud.CloudAction;

        internal static var _actionQueue:Array;

        internal static var _currentSyncType:String="";

        internal static var _instance:handler.CommonSyncHandler;

        internal static var _isWorker:Boolean=false;

        internal static var _requiredWorkerDataLoaded:Boolean=false;

        internal static var _syncStatus:Array;

        internal var _deleteSportprofileAction:service.cloud.CloudAction;

        internal static var _access_token:String="";
    }
}


