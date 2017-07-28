//class ActivityHandler
package handler 
{
    import __AS3__.vec.*;
    import backend.utils.dbUtils.*;
    import com.logging.*;
    import core.activities.*;
    import core.general.*;
    import core.marker.*;
    import core.participant.*;
    import core.sport.*;
    import core.user.*;
    import debug.*;
    import flash.data.*;
    import flash.events.*;
    import helper.*;
    import service.cloud.*;
    import statistic.*;
    
    public class ActivityHandler extends handler.ActivityHandlerCommon
    {
        public function ActivityHandler(arg1:flash.events.IEventDispatcher=null)
        {
            this._activitiesLight = new Array();
            super(arg1);
            com.logging.ErrorLogging.getInstance().addTarget(this);
            return;
        }

        public static function calcDiffAbs(arg1:Number, arg2:Number=0):Number
        {
            var loc1:*=NaN;
            if (arg1 >= 0 && arg2 >= 0) 
            {
                loc1 = arg1 - arg2;
            }
            else if (arg1 >= 0) 
            {
                loc1 = arg1 + arg2 * -1;
            }
            else if (arg2 >= 0) 
            {
                loc1 = arg1 * -1 + arg2;
            }
            else 
            {
                loc1 = Math.abs(arg1 - arg2);
            }
            return loc1;
        }

        public function get activitiesLight():Array
        {
            return this._activitiesLight;
        }

        public function generateLoadActivityStatement(arg1:int):String
        {
            return "SELECT * FROM Activity WHERE activityId = " + arg1;
        }

        public function generateLoadActivityByGUIDStatement(arg1:String):String
        {
            return "SELECT * FROM Activity WHERE GUID = \'" + arg1 + "\'";
        }

        public function generateLoadActivityEntries(arg1:int):String
        {
            return "SELECT * FROM ActivityEntry WHERE activityId = " + arg1;
        }

        public function generateUpdateSharingInformation(arg1:core.activities.Activity):String
        {
            var loc1:*=core.activities.ActivityMapper.encodeSharingInformations(arg1);
            var loc2:*=new Date().time;
            return "UPDATE Activity SET " + core.activities.ActivityMapper.col_sharingInformations + " = \'" + loc1 + "\', " + core.activities.ActivityMapper.col_modificationDate + " = \'" + loc2 + "\' WHERE activityId = \'" + arg1.activityId + "\'";
        }

        public function generateTopValuesStatement(arg1:int):Array
        {
            var loc1:*=0;
            var loc3:*=null;
            var loc5:*=null;
            var loc2:*=statistic.Statistic.TOP_VALUES.length;
            var loc4:*=new Array();
            loc1 = 0;
            while (loc1 < loc2) 
            {
                loc3 = statistic.Statistic.TOP_VALUES[loc1].value;
                loc5 = new backend.utils.dbUtils.DBUtilObject();
                loc5.stmt = "SELECT a." + loc3 + ", a.activityId, a.sportId, a.userId, a.startDate " + "FROM Activity a INNER JOIN " + "(SELECT sportId, MAX(" + loc3 + ") AS " + loc3 + " FROM Activity " + "WHERE " + "strftime(\'%Y\', startDate) == \'" + arg1 + "\' " + "AND statistic = true " + "AND isDeleted = false " + "GROUP BY sportId " + "ORDER BY sportId" + ") b " + "ON a." + loc3 + " = b." + loc3 + " " + "AND a.sportId = b.sportId AND strftime(\'%Y\', a.startDate) == \'" + arg1 + "\' " + "AND a.sportId != 16";
                loc4.push(loc5);
                ++loc1;
            }
            return loc4;
        }

        public function generateYearsWithDataStatement():String
        {
            return "select distinct strftime(\'%Y\', startDate) as year from Activity where isDeleted = false and statistic = true order by strftime(\'%Y\', startDate) desc";
        }

        public function loadActivityEntriesComplete(arg1:Array, arg2:core.activities.Activity):void
        {
            var loc2:*=null;
            var loc4:*=0;
            if (!arg1) 
            {
                return;
            }
            var loc1:*=new Vector.<core.activities.ActivityEntry>();
            var loc3:*=arg1.length;
            loc4 = 0;
            while (loc4 < loc3) 
            {
                loc2 = core.activities.ActivityFactory.createLogEntryFromLog(arg2);
                core.activities.ActivityEntryMapper.fromDB(arg1[loc4], loc2);
                loc1.push(loc2);
                ++loc4;
            }
            arg2.entries = loc1;
            return;
        }

        public function generateLoadActivityMarker(arg1:int):String
        {
            return "SELECT * FROM Marker WHERE activityId = " + arg1 + " ORDER BY Marker.type, Marker.timeAbsolute";
        }

        public function loadActivityMarkerComplete(arg1:Array, arg2:core.activities.Activity):void
        {
            var loc2:*=null;
            var loc4:*=0;
            var loc1:*=new Vector.<core.marker.Marker>();
            var loc3:*=arg1.length;
            loc4 = 0;
            while (loc4 < loc3) 
            {
                loc2 = core.marker.MarkerFactory.createMarkerFromDB(arg1[loc4], arg2);
                loc1.push(loc2);
                ++loc4;
            }
            arg2.markerList = loc1;
            return;
        }

        public function downloadActivity(arg1:XML, arg2:service.cloud.CloudURLStream):void
        {
            var loc2:*=null;
            var loc1:*=core.activities.ActivityFactory.createLogFromSLF(arg1, true);
            if (loc1 && !(loc1.sport == null)) 
            {
                loc1.GUID = arg2.data.GUID;
                loc2 = arg1.GeneralInformation.user.length() != 1 ? core.user.User.DEFAULT_NAME : arg1.GeneralInformation.user[0];
                backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, core.user.User.selectUserIdStatement(loc2), this.onSelectUserIdComplete, this.onSelectUserIdError, null, [loc1, arg2, loc2]);
            }
            else 
            {
                handler.CommonSyncHandler.getInstance().onDownloadFromCloudComplete(service.cloud.CloudConfig.TYPE_ACTIVITY);
            }
            return;
        }

        internal function onSelectUserIdComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            var loc5:*=null;
            var loc1:*=arg1.data.data[0] as core.activities.Activity;
            var loc2:*=arg1.data.data[1] as service.cloud.CloudURLStream;
            var loc3:*=arg1.data.data[2] as String;
            var loc4:*=arg1.getResult();
            if (loc4.length != 1) 
            {
                loc5 = new core.user.User();
                loc5.name = loc3;
                handler.UserHandler.getInstance().saveUser(loc5);
                loc1.userId = loc5.userId;
            }
            else 
            {
                loc1.userId = loc4[0].userId;
            }
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, core.activities.ActivityMapper.selectPrimaryKeyFromGUID(loc1), this.onGetActivityIdComplete, this.onGetActivityIdError, null, [loc1, loc2]);
            return;
        }

        internal function onSelectUserIdError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("onUserIdErro");
            handler.CommonSyncHandler.getInstance().onDownloadFromCloudComplete(service.cloud.CloudConfig.TYPE_ACTIVITY);
            return;
        }

        internal function onGetActivityIdComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            var loc1:*=arg1.data.data[0] as core.activities.Activity;
            var loc2:*=arg1.data.data[1] as service.cloud.CloudURLStream;
            var loc3:*=arg1.getResult();
            if (loc3.length != 1) 
            {
                this.saveDownloadedActivity(loc1, loc2);
            }
            else 
            {
                backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.UPDATE, core.activities.ActivityMapper.generateDBDelete(loc1), this.onDeleteActivityComplete, this.onDeleteActivityError, null, [loc1, loc2]);
            }
            return;
        }

        internal function onGetActivityIdError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("onGetActivityIdError");
            handler.CommonSyncHandler.getInstance().onDownloadFromCloudComplete(service.cloud.CloudConfig.TYPE_ACTIVITY);
            return;
        }

        internal function onDeleteActivityComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.debug("onDeleteActivityComplete");
            var loc1:*=arg1.data.data[0] as core.activities.Activity;
            var loc2:*=arg1.data.data[1] as service.cloud.CloudURLStream;
            this.saveDownloadedActivity(loc1, loc2);
            return;
        }

        internal function onDeleteActivityError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.debug("onDeleteActivityComplete");
            handler.CommonSyncHandler.getInstance().onDownloadFromCloudComplete(service.cloud.CloudConfig.TYPE_ACTIVITY);
            return;
        }

        internal function saveDownloadedActivity(arg1:core.activities.Activity, arg2:service.cloud.CloudURLStream):void
        {
            debug.Debug.debug("saveDownloadedActivity");
            arg1.modificationDate = arg2.data.modificationDate;
            handler.ActivityCalculator.validateActivityStatus_HeaderData(arg1);
            var loc1:*=new backend.utils.dbUtils.DBUtilObject(arg1, this.saveDownloadedActivityComplete, this.saveDownloadedActivityError, null, true);
            this.saveActivity(loc1);
            return;
        }

        internal function saveDownloadedActivityComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.debug("saveActivityComplete");
            handler.CommonSyncHandler.getInstance().onDownloadFromCloudComplete(service.cloud.CloudConfig.TYPE_ACTIVITY);
            return;
        }

        internal function saveDownloadedActivityError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("saveActivityError");
            handler.CommonSyncHandler.getInstance().onDownloadFromCloudComplete(service.cloud.CloudConfig.TYPE_ACTIVITY);
            return;
        }

        public function saveActivity(arg1:backend.utils.dbUtils.DBUtilObject):void
        {
            if (arg1.data == null || !(arg1.data is core.activities.Activity)) 
            {
                debug.Debug.error("ACHTUNG! Keine Activity übergeben!");
                return;
            }
            var loc1:*=[];
            var loc2:*=[];
            core.activities.ActivityMapper.generateDBInsert(arg1.data as core.activities.Activity, loc1, loc2);
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.UPDATE, core.activities.ActivityMapper.getInsertStatement(loc1), this.onInsertActivityComplete, this.onInsertActivityError, arg1.workerTarget, arg1, loc2);
            return;
        }

        internal function onInsertActivityComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.debug("Activity saved...");
            var loc1:*=arg1.data.data as backend.utils.dbUtils.DBUtilObject;
            if (arg1.data.lastInsertRowId != 0) 
            {
                (loc1.data as core.activities.Activity).activityId = arg1.data.lastInsertRowId;
            }
            if (loc1.parameters) 
            {
                this.saveActivityEntries(loc1);
            }
            else 
            {
                loc1.completeCallback(new backend.utils.dbUtils.DBUtilEvent(backend.utils.dbUtils.DBUtilEvent.COMPLETE, loc1));
            }
            return;
        }

        internal function onInsertActivityError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("[ERROR] Activity not saved...");
            var loc1:*=arg1.data.data as backend.utils.dbUtils.DBUtilObject;
            loc1.errorCallback(new backend.utils.dbUtils.DBUtilEvent(backend.utils.dbUtils.DBUtilEvent.ERROR));
            return;
        }

        public function saveActivityEntries(arg1:backend.utils.dbUtils.DBUtilObject):void
        {
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=null;
            var loc7:*=null;
            var loc8:*=null;
            var loc1:*=arg1.data as core.activities.Activity;
            if (loc1.dataType != core.general.DataType.LOG) 
            {
                arg1.completeCallback(new backend.utils.dbUtils.DBUtilEvent(backend.utils.dbUtils.DBUtilEvent.COMPLETE, arg1));
            }
            else 
            {
                loc3 = loc1.entries.length;
                loc4 = new Array();
                if (loc3 != 0) 
                {
                    validateStartEntry(loc1);
                    loc3 = loc1.entries.length;
                    loc2 = 0;
                    while (loc2 < loc3) 
                    {
                        loc5 = loc1.entries[loc2];
                        loc7 = [];
                        loc5.activityId = loc1.activityId;
                        loc6 = core.activities.ActivityEntryMapper.generateDBColumns(loc5);
                        core.activities.ActivityEntryMapper.generateDBInsertStmtParameter(loc5, loc7);
                        loc8 = new backend.utils.dbUtils.DBUtilObject();
                        loc8.stmt = core.activities.ActivityEntryMapper.getInsertStatement(loc6);
                        loc8.parameters = loc7;
                        loc4.push(loc8);
                        ++loc2;
                    }
                    backend.utils.dbUtils.DBUtil.getInstance().callMultiple(flash.data.SQLMode.UPDATE, loc4, this.onInsertActivityEntryComplete, this.onInsertActivityEntryError, arg1.workerTarget, arg1);
                }
                else if (arg1.parameters) 
                {
                    this.saveMarker(arg1);
                }
                else 
                {
                    arg1.completeCallback(new backend.utils.dbUtils.DBUtilEvent(backend.utils.dbUtils.DBUtilEvent.COMPLETE, arg1));
                }
            }
            return;
        }

        internal function onInsertActivityEntryComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.debug("Activity entries saved...");
            var loc1:*=arg1.data.data as backend.utils.dbUtils.DBUtilObject;
            if (loc1.parameters) 
            {
                this.saveMarker(loc1);
            }
            else 
            {
                loc1.completeCallback(new backend.utils.dbUtils.DBUtilEvent(backend.utils.dbUtils.DBUtilEvent.COMPLETE, loc1));
            }
            return;
        }

        internal function onInsertActivityEntryError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            var loc1:*=arg1.data.data as backend.utils.dbUtils.DBUtilObject;
            loc1.errorCallback(new backend.utils.dbUtils.DBUtilEvent(backend.utils.dbUtils.DBUtilEvent.ERROR));
            return;
        }

        internal function saveMarker(arg1:backend.utils.dbUtils.DBUtilObject):void
        {
            var loc2:*=0;
            var loc5:*=null;
            var loc6:*=null;
            var loc7:*=null;
            var loc8:*=null;
            var loc1:*=arg1.data as core.activities.Activity;
            var loc3:*=loc1.markerList.length;
            var loc4:*=new Array();
            if (loc3 != 0) 
            {
                loc2 = 0;
                while (loc2 < loc3) 
                {
                    loc5 = loc1.markerList[loc2];
                    loc7 = [];
                    loc5.activityId = loc1.activityId;
                    loc6 = core.marker.MarkerMapper.generateDBColumns(loc5);
                    core.marker.MarkerMapper.generateDBInsertStmtParameter(loc5, loc7);
                    loc8 = new backend.utils.dbUtils.DBUtilObject();
                    loc8.stmt = core.marker.MarkerMapper.generateDBInsertStmt(loc6);
                    loc8.parameters = loc7;
                    loc4.push(loc8);
                    ++loc2;
                }
                backend.utils.dbUtils.DBUtil.getInstance().callMultiple(flash.data.SQLMode.UPDATE, loc4, this.onInsertMarkerComplete, this.onInsertMarkerError, arg1.workerTarget, arg1);
            }
            else if (arg1.parameters) 
            {
                this.saveActivityPerson(arg1);
            }
            else 
            {
                arg1.completeCallback(new backend.utils.dbUtils.DBUtilEvent(backend.utils.dbUtils.DBUtilEvent.COMPLETE, arg1));
            }
            return;
        }

        internal function onInsertMarkerComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.debug("Activity marker saved...");
            var loc1:*=arg1.data.data as backend.utils.dbUtils.DBUtilObject;
            if (loc1.parameters) 
            {
                this.saveActivityPerson(loc1);
            }
            else 
            {
                loc1.completeCallback(new backend.utils.dbUtils.DBUtilEvent(backend.utils.dbUtils.DBUtilEvent.COMPLETE, loc1));
            }
            return;
        }

        internal function onInsertMarkerError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            var loc1:*=arg1.data.data as backend.utils.dbUtils.DBUtilObject;
            loc1.errorCallback(new backend.utils.dbUtils.DBUtilEvent(backend.utils.dbUtils.DBUtilEvent.ERROR));
            return;
        }

        public function saveActivityPerson(arg1:backend.utils.dbUtils.DBUtilObject):void
        {
            var loc2:*=0;
            var loc5:*=null;
            var loc6:*=null;
            var loc7:*=null;
            var loc1:*=arg1.data as core.activities.Activity;
            var loc3:*=loc1.participant.length;
            var loc4:*=new Vector.<backend.utils.dbUtils.DBUtilObject>();
            if (loc3 != 0) 
            {
                loc2 = 0;
                while (loc2 < loc3) 
                {
                    loc5 = loc1.participant[loc2];
                    loc7 = [];
                    arg1.parameters = [loc5, loc2 == (loc3 - 1)];
                    backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, core.participant.Person.generateLoadPersonId(loc5), this.onGetPersonIdComplete, this.onGetPersonIdError, arg1.workerTarget, arg1);
                    ++loc2;
                }
            }
            else 
            {
                arg1.completeCallback(new backend.utils.dbUtils.DBUtilEvent(backend.utils.dbUtils.DBUtilEvent.COMPLETE, arg1));
            }
            return;
        }

        internal function onGetPersonIdComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            var loc1:*=arg1.data.data as backend.utils.dbUtils.DBUtilObject;
            var loc2:*=loc1.parameters[0] as core.participant.Person;
            var loc3:*=arg1.getResult();
            if (loc3.length == 1) 
            {
                loc2.personId = loc3[0].personId;
            }
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.UPDATE, core.participant.Person.generateDBPersonInsert(loc2), this.onInsertPersonComplete, this.onInsertPersonError, loc1.workerTarget, loc1);
            return;
        }

        internal function onGetPersonIdError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            var loc1:*=arg1.data.data as backend.utils.dbUtils.DBUtilObject;
            loc1.errorCallback(new backend.utils.dbUtils.DBUtilEvent(backend.utils.dbUtils.DBUtilEvent.ERROR));
            return;
        }

        internal function onInsertPersonComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.debug("Activity Person saved...");
            var loc1:*=arg1.data.data as backend.utils.dbUtils.DBUtilObject;
            var loc2:*=loc1.parameters[0] as core.participant.Person;
            if (arg1.data.lastInsertRowId != 0) 
            {
                loc2.personId = arg1.data.lastInsertRowId;
            }
            var loc3:*=new Object();
            loc3["@fk"] = loc2.personId;
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.UPDATE, core.participant.Person.generateDBActivityPersonInsert(loc1.data as core.activities.Activity), this.onInsertActivityPersonComplete, this.onInsertActivityPersonError, loc1.workerTarget, loc1, loc3);
            return;
        }

        internal function onInsertPersonError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            var loc1:*=arg1.data.data as backend.utils.dbUtils.DBUtilObject;
            loc1.errorCallback(new backend.utils.dbUtils.DBUtilEvent(backend.utils.dbUtils.DBUtilEvent.ERROR));
            return;
        }

        internal function onInsertActivityPersonComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            var loc1:*=arg1.data.data as backend.utils.dbUtils.DBUtilObject;
            var loc2:*=loc1.parameters[1];
            debug.Debug.debug("Activity ActivityPerson saved...");
            if (loc2) 
            {
                loc1.completeCallback(new backend.utils.dbUtils.DBUtilEvent(backend.utils.dbUtils.DBUtilEvent.COMPLETE, loc1));
            }
            return;
        }

        internal function onInsertActivityPersonError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            var loc1:*=arg1.data.data as backend.utils.dbUtils.DBUtilObject;
            loc1.errorCallback(new backend.utils.dbUtils.DBUtilEvent(backend.utils.dbUtils.DBUtilEvent.ERROR));
            return;
        }

        public function deleteActivities(arg1:Array):void
        {
            var loc1:*="DELETE FROM Activity WHERE GUID in (" + arg1.join(", ") + ") OR isDeleted = true";
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.UPDATE, loc1, this.onActivitiesDeleteComplete, this.onActivitiesDeleteError, null, arg1);
            return;
        }

        internal function onActivitiesDeleteComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.debug("onActivitiesDeleteComplete");
            handler.CommonSyncHandler.getInstance().onDeleteFromCloudComplete(service.cloud.CloudConfig.TYPE_ACTIVITY, arg1.data.data as Array);
            return;
        }

        internal function onActivitiesDeleteError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("onActivitiesDeleteError");
            handler.CommonSyncHandler.getInstance().onDeleteFromCloudComplete(service.cloud.CloudConfig.TYPE_ACTIVITY, arg1.data.data as Array);
            return;
        }

        public static function getInstance():handler.ActivityHandler
        {
            if (_instance == null) 
            {
                _instance = new ActivityHandler();
                handler.ActivityHandlerCommon.setInstace(_instance);
            }
            return _instance as handler.ActivityHandler;
        }

        public static function prepareDelete(arg1:String):String
        {
            var loc1:*=new Date().time;
            var loc2:*="UPDATE Activity SET isDeleted = true, modificationDate = \'" + loc1 + "\' WHERE GUID = \'" + arg1 + "\'";
            return loc2;
        }

        public static function validateStartEntry(arg1:Object):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=null;
            var loc7:*=null;
            var loc1:*=false;
            if (arg1 is core.activities.Activity) 
            {
                if ((arg1 as core.activities.Activity).sport.keyName == core.sport.Sport.ACTIVITY_TRACKER) 
                {
                    return;
                }
                loc2 = (arg1 as core.activities.Activity).entries;
                if (loc2.length > 0) 
                {
                    loc3 = loc2[0] as core.activities.ActivityEntry;
                    if (loc3.trainingTime != 0) 
                    {
                        loc1 = true;
                    }
                    if (loc3.distanceDefined && loc3.distanceAbsoluteDefined) 
                    {
                        if (loc3.distance != 0) 
                        {
                            loc1 = true;
                        }
                    }
                    if (loc1) 
                    {
                        loc4 = core.activities.ActivityEntry.copy(loc3);
                        loc4.trainingTime = 0;
                        loc4.trainingTimeAbsolute = 0;
                        if (loc4.distanceDefined && loc4.distanceAbsoluteDefined) 
                        {
                            loc4.distance = 0;
                            loc4.distanceAbsolute = 0;
                        }
                        if (loc4.caloriesDefined) 
                        {
                            loc4.calories = 0;
                        }
                        loc2.splice(0, 0, loc4);
                        debug.Debug.debug("Start entry added in Activity \'" + arg1.name + "\'...");
                    }
                }
            }
            else if (arg1.hasOwnProperty("entries")) 
            {
                loc5 = arg1.entries;
                if (loc5.length > 0) 
                {
                    loc6 = loc5[0];
                    if (loc6.hasOwnProperty("trainingTime") && loc6.hasOwnProperty("trainingTimeAbsolute")) 
                    {
                        if (loc6.trainingTime != 0) 
                        {
                            loc1 = true;
                        }
                    }
                    if (loc6.hasOwnProperty("rideTime") && loc6.hasOwnProperty("rideTimeAbsolute")) 
                    {
                        if (loc6.rideTime != 0) 
                        {
                            loc1 = true;
                        }
                    }
                    if (loc6.hasOwnProperty("distance") && loc6.hasOwnProperty("distanceAbsolute")) 
                    {
                        if (loc6.distance != 0) 
                        {
                            loc1 = true;
                        }
                    }
                    if (loc1) 
                    {
                        loc7 = helper.Object_helper.clone(loc6);
                        if (loc7.hasOwnProperty("trainingTime") && loc7.hasOwnProperty("trainingTimeAbsolute")) 
                        {
                            loc7.trainingTime = 0;
                            loc7.trainingTimeAbsolute = 0;
                        }
                        if (loc6.hasOwnProperty("rideTime") && loc6.hasOwnProperty("rideTimeAbsolute")) 
                        {
                            loc7.rideTime = 0;
                            loc7.rideTimeAbsolute = 0;
                        }
                        if (loc7.hasOwnProperty("distance") && loc7.hasOwnProperty("distanceAbsolute")) 
                        {
                            loc7.distance = 0;
                            loc7.distanceAbsolute = 0;
                        }
                        if (loc7.hasOwnProperty("calories")) 
                        {
                            loc7.calories = 0;
                        }
                        loc5.splice(0, 0, loc7);
                        debug.Debug.debug("Start entry added in Activity \'" + arg1.name + "\'...");
                    }
                }
            }
            return;
        }

        public static function createDouglasPeuckerDP(arg1:core.activities.Activity, arg2:String):__AS3__.vec.Vector.<Object>
        {
            var loc1:*=0;
            var loc2:*=null;
            var loc5:*=null;
            var loc8:*=NaN;
            var loc3:*=arg1.entries;
            var loc4:*=new Vector.<Object>();
            var loc6:*=arg1.entries.length;
            loc1 = 0;
            while (loc1 < loc6) 
            {
                loc2 = loc3[loc1];
                loc5 = new Object();
                loc5[core.activities.ActivityEntryMapper.col_trainingTimeAbsolute] = loc2.trainingTimeAbsolute;
                loc5[arg2] = loc2[arg2];
                loc4.push(loc5);
                ++loc1;
            }
            var loc7:*=500;
            if (loc6 > loc7) 
            {
                loc8 = 1 - loc7 / loc6;
                loc4 = core.general.DouglasPeucker.simplify(loc4, core.activities.ActivityEntryMapper.col_trainingTimeAbsolute, arg2, loc8);
            }
            return loc4;
        }

        public static function calculateVerticalAxisProperties(arg1:__AS3__.vec.Vector.<Object>, arg2:String):Array
        {
            var loc3:*=NaN;
            var loc4:*=0;
            if (arg1.length == 0) 
            {
                return [0, 1, 1];
            }
            var loc1:*=arg1[0][arg2];
            var loc2:*=loc1;
            var loc5:*=arg1.length;
            loc4 = 0;
            while (loc4 < loc5) 
            {
                loc1 = Math.max(loc1, arg1[loc4][arg2]);
                loc2 = Math.min(loc2, arg1[loc4][arg2]);
                ++loc4;
            }
            if (loc1 == 0) 
            {
                loc1 = 1;
            }
            var loc6:*=1;
            var loc9:*=arg2;
            switch (loc9) 
            {
                case core.activities.ActivityEntryMapper.col_altitude:
                {
                    loc6 = 1;
                    if (loc1 == loc2 || loc1 == 1) 
                    {
                        loc1 = loc1 + 10000;
                    }
                    break;
                }
                case core.activities.ActivityEntryMapper.col_speed:
                {
                    loc6 = 1;
                    break;
                }
                case core.activities.ActivityEntryMapper.col_heartrate:
                {
                    loc6 = 1;
                    break;
                }
                case core.activities.ActivityEntryMapper.col_temperature:
                {
                    loc6 = 5;
                    break;
                }
                case core.activities.ActivityEntryMapper.col_incline:
                {
                    loc6 = 1;
                    break;
                }
                case core.activities.ActivityEntryMapper.col_riseRate:
                {
                    loc6 = 2;
                    break;
                }
                case core.activities.ActivityEntryMapper.col_cadence:
                {
                    loc6 = 2;
                    break;
                }
                case core.activities.ActivityEntryMapper.col_power:
                {
                    loc6 = 1;
                    break;
                }
                case core.activities.ActivityEntryMapper.col_steps:
                {
                    loc6 = 2;
                    break;
                }
            }
            var loc7:*=Math.ceil(calcDiffAbs(loc1, loc2));
            var loc8:*=false;
            do 
            {
                if (loc7 / loc6 >= 10) 
                {
                    loc6 = loc6 * 10;
                    loc8 = true;
                }
                else 
                {
                    loc8 = false;
                }
            }
            while (loc8);
            if (loc1 > 0) 
            {
                loc1 = loc1 - loc1 % loc6 + loc6;
            }
            else if (loc1 < 0) 
            {
                loc1 = loc1 - (-loc1) % loc6 - loc6;
            }
            if (loc2 > 0) 
            {
                loc2 = loc2 - loc2 % loc6;
            }
            else if (loc2 < 0) 
            {
                loc2 = loc2 + (-loc2) % loc6 - loc6;
            }
            return [loc2, loc1, loc6];
        }

        public static function calculateHorizontalAxisProperties(arg1:__AS3__.vec.Vector.<Object>, arg2:String):Array
        {
            if (arg1.length == 0) 
            {
                return [0, 1, 1];
            }
            var loc1:*=arg1[(arg1.length - 1)][arg2];
            var loc2:*=0;
            var loc3:*=1;
            var loc4:*=2;
            var loc5:*=7;
            var loc7:*=arg2;
            switch (loc7) 
            {
                case core.activities.ActivityEntryMapper.col_trainingTimeAbsolute:
                {
                    loc3 = 90000;
                    loc4 = 2;
                    break;
                }
                case core.activities.ActivityEntryMapper.col_distanceAbsolute:
                {
                    loc3 = 1000;
                    loc4 = 10;
                    break;
                }
                case "distance":
                {
                    loc3 = 1000;
                    loc4 = 10;
                    break;
                }
            }
            var loc6:*=false;
            do 
            {
                if (loc1 / loc3 > loc5) 
                {
                    loc3 = loc3 * loc4;
                    loc6 = true;
                }
                else 
                {
                    loc6 = false;
                }
            }
            while (loc6);
            return [loc2, loc1, loc3];
        }

        public static const ACTIVITY_SAVE_ERROR:String="activitySaveError";

        public static const AVTIVITY_SAVED_COMPLETE:String="activitySavedComplete";

        public static const ENTRIES_AND_MARKERS_LOADED_FROM_DB_COMPLETE:String="entriesAndMarkersLoadedFromDBComplete";

        public static const ACTIVITY_LOADED_FROM_DB_COMPLETE:String="activityLoadedFromDBComplete";

        public static const ACTIVITY_LIGHT_DATA_LOADED_FROM_DB_COMPLETE:String="activityLightDataLoadedFromDbComplete";

        internal var _activitiesLight:Array;

        internal static var _instance:handler.ActivityHandler;
    }
}


