//class AppDeviceHandler
package handler 
{
    import __AS3__.vec.*;
    import backend.utils.dbUtils.*;
    import com.logging.*;
    import core.activities.*;
    import core.general.*;
    import core.general.interfaces.*;
    import core.gps.*;
    import core.route.*;
    import core.settings.*;
    import core.sportprofiles.*;
    import core.totals.*;
    import core.training.*;
    import core.units.*;
    import debug.*;
    import flash.data.*;
    import flash.events.*;
    import service.cloud.*;
    
    public class AppDeviceHandler extends flash.events.EventDispatcher
    {
        public function AppDeviceHandler(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            com.logging.ErrorLogging.getInstance().addTarget(this);
            return;
        }

        public function getUpdateModificationDateSQLStatementString(arg1:core.general.interfaces.ISynchronisable):String
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            if (arg1 is core.activities.Activity) 
            {
                loc1 = core.activities.ActivityMapper.table_name;
                loc2 = core.activities.ActivityMapper.col_modificationDate;
                loc3 = core.activities.ActivityMapper.col_activityId;
            }
            else if (arg1 is core.route.Route) 
            {
                loc1 = core.route.Route.TABLE_NAME;
                loc2 = core.route.Route.COL_MODIFICATION_DATE;
                loc3 = core.route.Route.COL_ROUTE_ID;
            }
            else if (arg1 is core.units.Unit) 
            {
                loc1 = core.units.Unit.table_name;
                loc2 = core.units.Unit.col_modificationDate;
                loc3 = core.units.Unit.col_unitId;
            }
            else if (arg1 is core.totals.Totals) 
            {
                loc1 = core.totals.TotalsEntity.table_name;
                loc2 = core.totals.TotalsEntity.col_modificationDate;
                loc3 = core.totals.TotalsEntity.col_totalsId;
            }
            else if (arg1 is core.settings.Settings) 
            {
                loc1 = core.settings.SettingsMapper.table_name;
                loc2 = core.settings.SettingsMapper.col_modificationDate;
                loc3 = core.settings.SettingsMapper.col_settingsId;
            }
            else if (arg1 is core.training.Training) 
            {
                loc1 = core.training.TrainingMapper.table_name;
                loc2 = core.training.TrainingMapper.col_modificationDate;
                loc3 = core.training.TrainingMapper.col_trainingId;
            }
            else if (arg1 is core.sportprofiles.Sportprofile) 
            {
                loc1 = core.sportprofiles.SportprofileMapper.TABLE_NAME;
                loc2 = core.sportprofiles.SportprofileMapper.col_modificationDate;
                loc3 = core.sportprofiles.SportprofileMapper.col_sportprofileId;
            }
            else if (arg1 is core.gps.PointNavigation) 
            {
                loc1 = core.gps.PointNavigationMapper.table_name;
                loc2 = core.gps.PointNavigationMapper.col_modificationDate;
                loc3 = core.gps.PointNavigationMapper.col_pointNavigationId;
            }
            return "UPDATE " + loc1 + " SET " + loc2 + " = " + arg1[loc2] + " WHERE " + loc3 + " = " + arg1[loc3];
        }

        public function generateLoadUnitByGUIDStatement(arg1:String):String
        {
            return "SELECT * FROM Unit WHERE GUID = \'" + arg1 + "\'";
        }

        public function generateLoadUnitBySerialNumberAndType(arg1:String, arg2:String, arg3:Boolean=true):String
        {
            var loc1:*=arg3 ? " AND " + core.units.Unit.col_isDeleted + " = false" : "";
            return "SELECT * FROM Unit WHERE " + core.units.Unit.col_serialNumber + " = \'" + arg1 + "\' AND " + core.units.Unit.col_type + " = \'" + arg2 + "\'" + loc1;
        }

        public function generateLoadTrainingByGUIDStatement(arg1:String):String
        {
            return "SELECT * FROM Training WHERE GUID = \'" + arg1 + "\'";
        }

        public function generateLoadTrainingPhase(arg1:int):String
        {
            return "SELECT * FROM TrainingPhase WHERE trainingId = " + arg1;
        }

        public function generateLoadSettingsByGUIDStatement(arg1:String):String
        {
            return "SELECT * FROM Settings WHERE GUID = \'" + arg1 + "\'";
        }

        public function generateLoadSportprofileByGUIDStatement(arg1:String):String
        {
            return "SELECT * FROM Sportprofiles WHERE GUID = \'" + arg1 + "\'";
        }

        public function generateLoadPointNavigationsByGUIDStatement(arg1:String):String
        {
            return "SELECT * FROM " + core.gps.PointNavigationMapper.table_name + " WHERE GUID = \'" + arg1 + "\'";
        }

        public function loadTrainingPhaseComplete(arg1:Array, arg2:core.training.Training):void
        {
            var loc2:*=null;
            var loc4:*=0;
            if (!arg1) 
            {
                return;
            }
            var loc1:*=new Vector.<core.training.TrainingPhase>();
            var loc3:*=arg1.length;
            loc4 = 0;
            while (loc4 < loc3) 
            {
                loc2 = new core.training.TrainingPhase();
                core.training.TrainingPhaseMapper.fromDB(loc2, arg1[loc4]);
                loc1.push(loc2);
                ++loc4;
            }
            arg2.phasesList = loc1;
            return;
        }

        public function downloadUnit(arg1:XML, arg2:service.cloud.CloudURLStream):void
        {
            var loc1:*=core.units.Unit.fromXML(arg1);
            loc1.GUID = arg2.data.GUID;
            loc1.modificationDate = arg2.data.modificationDate;
            loc1.ignoreBLEDeviceIdOnInsert = true;
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, loc1.selectPrimaryKeyFromGUID(), this.onGetUnitIdComplete, this.onGetUnitIdError, null, loc1);
            return;
        }

        internal function onGetUnitIdComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            var loc1:*=arg1.data.data as core.units.Unit;
            var loc2:*=arg1.getResult();
            if (loc2.length == 1) 
            {
                loc1.unitId = loc2[0].unitId;
            }
            var loc3:*=new backend.utils.dbUtils.DBUtilObject(loc1, this.saveDownloadedUnitComplete, this.saveDownloadedUnitError, null, loc1);
            this.saveUnit(loc3);
            return;
        }

        public function insertNewUnit(arg1:core.units.Unit, arg2:Function=null, arg3:Function=null):void
        {
            debug.Debug.debug("insertNewUnit: " + arg1.toString());
            if (arg2 == null) 
            {
                arg2 = this.saveNewUnitComplete;
            }
            if (arg3 == null) 
            {
                arg3 = this.saveNewUnitError;
            }
            var loc1:*=new backend.utils.dbUtils.DBUtilObject(arg1, arg2, arg3, null, arg1);
            this.saveUnit(loc1);
            return;
        }

        internal function saveNewUnitComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.debug("saveNewUnitComplete: " + arg1.toString());
            return;
        }

        internal function saveNewUnitError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("saveNewUnitError: " + arg1.toString());
            return;
        }

        internal function onGetUnitIdError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("onGetUnitIdError");
            handler.CommonSyncHandler.getInstance().onDownloadFromCloudComplete(service.cloud.CloudConfig.TYPE_DEVICE);
            return;
        }

        internal function saveDownloadedUnitComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.debug("onInsertUnitComplete");
            handler.CommonSyncHandler.getInstance().onDownloadFromCloudComplete(service.cloud.CloudConfig.TYPE_DEVICE);
            return;
        }

        internal function saveDownloadedUnitError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("onInsertUnitError");
            handler.CommonSyncHandler.getInstance().onDownloadFromCloudComplete(service.cloud.CloudConfig.TYPE_DEVICE);
            return;
        }

        public function saveUnit(arg1:backend.utils.dbUtils.DBUtilObject):void
        {
            debug.Debug.debug("saveUnit");
            var loc1:*=arg1.data as core.units.Unit;
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.UPDATE, loc1.getInsertStatement(), this.onInsertUnitComplete, this.onInsertUnitError, arg1.workerTarget, arg1);
            return;
        }

        internal function onInsertUnitComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.debug("onInsertUnitComplete");
            var loc1:*=arg1.data.data as backend.utils.dbUtils.DBUtilObject;
            var loc2:*=loc1.data as core.units.Unit;
            loc2.ignoreBLEDeviceIdOnInsert = false;
            loc2.unitId = arg1.data.lastInsertRowId;
            loc1.completeCallback(new backend.utils.dbUtils.DBUtilEvent(backend.utils.dbUtils.DBUtilEvent.COMPLETE, loc1));
            return;
        }

        internal function onInsertUnitError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("onInsertUnitError");
            var loc1:*=arg1.data.data as backend.utils.dbUtils.DBUtilObject;
            loc1.errorCallback(new backend.utils.dbUtils.DBUtilEvent(backend.utils.dbUtils.DBUtilEvent.ERROR, loc1));
            return;
        }

        public function loadUnits(arg1:backend.utils.dbUtils.DBUtilObject):void
        {
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, core.units.Unit.selectAll(), arg1.completeCallback, arg1.errorCallback, arg1.workerTarget);
            return;
        }

        public function deleteUnits(arg1:Array):void
        {
            var loc1:*="DELETE FROM Unit WHERE GUID in (" + arg1.join(", ") + ") OR isDeleted = true";
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.UPDATE, loc1, this.onUnitsDeleteComplete, this.onUnitsDeleteError, null, arg1);
            return;
        }

        internal function onUnitsDeleteComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.debug("onUnitsDeleteComplete");
            handler.CommonSyncHandler.getInstance().onDeleteFromCloudComplete(service.cloud.CloudConfig.TYPE_DEVICE, arg1.data.data as Array);
            return;
        }

        internal function onUnitsDeleteError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("onUnitsDeleteError");
            handler.CommonSyncHandler.getInstance().onDeleteFromCloudComplete(service.cloud.CloudConfig.TYPE_DEVICE, arg1.data.data as Array);
            return;
        }

        public function downloadTotals(arg1:XML, arg2:service.cloud.CloudURLStream):void
        {
            var loc1:*=core.totals.Totals.fromXML(arg1);
            loc1.GUID = arg2.data.GUID;
            loc1.modificationDate = arg2.data.modificationDate;
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, core.totals.TotalsEntity.selectPrimaryKeyFromGUID(loc1), this.onGetTotalsIdComplete, this.onGetTotalsIdError, null, loc1);
            return;
        }

        internal function onGetTotalsIdComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            var loc1:*=arg1.data.data as core.totals.Totals;
            var loc2:*=arg1.getResult();
            if (loc2.length == 1) 
            {
                loc1.totalsId = loc2[0][core.totals.TotalsEntity.col_totalsId];
            }
            var loc3:*=new backend.utils.dbUtils.DBUtilObject(loc1, this.saveDownloadedTotalsComplete, this.saveDownloadedTotalsError, null, loc1);
            this.saveTotals(loc3);
            return;
        }

        internal function onGetTotalsIdError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("onGetTotalsIdError");
            handler.CommonSyncHandler.getInstance().onDownloadFromCloudComplete(service.cloud.CloudConfig.TYPE_DEVICE_TOTALS);
            return;
        }

        internal function saveDownloadedTotalsComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.debug("saveDownloadedTotalsComplete");
            handler.CommonSyncHandler.getInstance().onDownloadFromCloudComplete(service.cloud.CloudConfig.TYPE_DEVICE_TOTALS);
            return;
        }

        internal function saveDownloadedTotalsError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("saveDownloadedTotalsComplete");
            handler.CommonSyncHandler.getInstance().onDownloadFromCloudComplete(service.cloud.CloudConfig.TYPE_DEVICE_TOTALS);
            return;
        }

        public function saveTotals(arg1:backend.utils.dbUtils.DBUtilObject):void
        {
            var loc1:*=arg1.data as core.totals.Totals;
            var loc2:*=[];
            var loc3:*=[];
            core.totals.TotalsEntity.generateParamsAndColums(loc1, loc2, loc3);
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.UPDATE, core.totals.TotalsEntity.getInsertStatement(loc2), this.onInsertTotalsComplete, this.onInsertTotalsError, arg1.workerTarget, arg1, loc3);
            return;
        }

        internal function onInsertTotalsComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.debug("onInsertTotalsComplete");
            var loc1:*=arg1.data.data as backend.utils.dbUtils.DBUtilObject;
            var loc2:*=loc1.data as core.totals.Totals;
            loc2.totalsId = arg1.data.lastInsertRowId;
            loc1.completeCallback(new backend.utils.dbUtils.DBUtilEvent(backend.utils.dbUtils.DBUtilEvent.COMPLETE, loc1));
            return;
        }

        internal function onInsertTotalsError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("onInsertTotalsError");
            var loc1:*=arg1.data.data as backend.utils.dbUtils.DBUtilObject;
            loc1.errorCallback(new backend.utils.dbUtils.DBUtilEvent(backend.utils.dbUtils.DBUtilEvent.ERROR, loc1));
            return;
        }

        public function deleteTotals(arg1:Array):void
        {
            var loc1:*="DELETE FROM Totals WHERE GUID in (" + arg1.join(", ") + ") OR isDeleted = true";
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.UPDATE, loc1, this.onTotalsDeleteComplete, this.onTotalsDeleteError, null, arg1);
            return;
        }

        internal function onTotalsDeleteComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.debug("onTotalsDeleteComplete");
            handler.CommonSyncHandler.getInstance().onDeleteFromCloudComplete(service.cloud.CloudConfig.TYPE_DEVICE_TOTALS, arg1.data.data as Array);
            return;
        }

        internal function onTotalsDeleteError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("onTotalsDeleteError");
            handler.CommonSyncHandler.getInstance().onDeleteFromCloudComplete(service.cloud.CloudConfig.TYPE_DEVICE_TOTALS, arg1.data.data as Array);
            return;
        }

        public function downloadSettings(arg1:core.settings.Settings):void
        {
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, core.settings.SettingsMapper.selectPrimaryKeyFromGUID(arg1), this.onGetSettingsIdComplete, this.onGetSettingsIdError, null, arg1);
            return;
        }

        internal function onGetSettingsIdComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            var loc1:*=arg1.data.data as core.settings.Settings;
            var loc2:*=arg1.getResult();
            if (loc2.length == 1) 
            {
                loc1.settingsId = loc2[0][core.settings.SettingsMapper.col_settingsId];
            }
            var loc3:*=new backend.utils.dbUtils.DBUtilObject(loc1, this.saveDownloadedSettingsComplete, this.saveDownloadedSettingsError, null, loc1);
            this.saveSettings(loc3);
            return;
        }

        internal function onGetSettingsIdError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("onGetSettingsIdError");
            handler.CommonSyncHandler.getInstance().onDownloadFromCloudComplete(service.cloud.CloudConfig.TYPE_DEVICE_SETTING);
            return;
        }

        internal function saveDownloadedSettingsComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.debug("saveDownloadedSettingsComplete");
            handler.CommonSyncHandler.getInstance().onDownloadFromCloudComplete(service.cloud.CloudConfig.TYPE_DEVICE_SETTING);
            return;
        }

        internal function saveDownloadedSettingsError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("saveDownloadedSettingsError");
            handler.CommonSyncHandler.getInstance().onDownloadFromCloudComplete(service.cloud.CloudConfig.TYPE_DEVICE_SETTING);
            return;
        }

        public function downloadSportprofile(arg1:core.sportprofiles.Sportprofile):void
        {
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, core.sportprofiles.SportprofileMapper.selectPrimaryKeyFromGUID(arg1), this.onGetSportprofileIdComplete, this.onGetSportprofileIdError, null, arg1);
            return;
        }

        internal function onGetSportprofileIdComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            var loc1:*=arg1.data.data as core.sportprofiles.Sportprofile;
            var loc2:*=arg1.getResult();
            if (loc2.length == 1) 
            {
                loc1.sportprofileId = loc2[0][core.sportprofiles.SportprofileMapper.col_sportprofileId];
            }
            var loc3:*=new backend.utils.dbUtils.DBUtilObject(loc1, this.saveDownloadedSportprofileComplete, this.saveDownloadedSportprofileError, null, loc1);
            this.saveSportprofile(loc3);
            return;
        }

        internal function onGetSportprofileIdError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("onGetSportprofileIdError");
            handler.CommonSyncHandler.getInstance().onDownloadFromCloudComplete(service.cloud.CloudConfig.TYPE_DEVICE_SETTING);
            return;
        }

        internal function saveDownloadedSportprofileComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.debug("saveDownloadedSportprofileComplete");
            handler.CommonSyncHandler.getInstance().onDownloadFromCloudComplete(service.cloud.CloudConfig.TYPE_DEVICE_SETTING);
            return;
        }

        internal function saveDownloadedSportprofileError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("saveDownloadedSportprofileError");
            handler.CommonSyncHandler.getInstance().onDownloadFromCloudComplete(service.cloud.CloudConfig.TYPE_DEVICE_SETTING);
            return;
        }

        public function downloadPointNavigation(arg1:core.gps.PointNavigation):void
        {
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, core.gps.PointNavigationMapper.selectPrimaryKeyFromGUID(arg1), this.onGetPointNavigationIdComplete, this.onGetPointNavigationIdError, null, arg1);
            return;
        }

        internal function onGetPointNavigationIdComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            var loc1:*=arg1.data.data as core.gps.PointNavigation;
            var loc2:*=arg1.getResult();
            if (loc2.length == 1) 
            {
                loc1.pointNavigationId = loc2[0][core.gps.PointNavigationMapper.col_pointNavigationId];
            }
            var loc3:*=new backend.utils.dbUtils.DBUtilObject(loc1, this.saveDownloadedPointNavigationComplete, this.saveDownloadedPointNavigationError, null, loc1);
            this.savePointNavigation(loc3);
            return;
        }

        internal function onGetPointNavigationIdError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("onGetPointNavigationIdError");
            handler.CommonSyncHandler.getInstance().onDownloadFromCloudComplete(service.cloud.CloudConfig.TYPE_DEVICE_SETTING);
            return;
        }

        internal function saveDownloadedPointNavigationComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.debug("saveDownloadedPointNavigationComplete");
            handler.CommonSyncHandler.getInstance().onDownloadFromCloudComplete(service.cloud.CloudConfig.TYPE_DEVICE_SETTING);
            return;
        }

        internal function saveDownloadedPointNavigationError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("saveDownloadedPointNavigationError");
            handler.CommonSyncHandler.getInstance().onDownloadFromCloudComplete(service.cloud.CloudConfig.TYPE_DEVICE_SETTING);
            return;
        }

        public function saveSettings(arg1:backend.utils.dbUtils.DBUtilObject):void
        {
            var loc1:*=arg1.data as core.settings.Settings;
            if (loc1.unit && loc1.unit.GUID) 
            {
                loc1.unitGUID = loc1.unit.GUID;
            }
            var loc2:*=[];
            var loc3:*=[];
            core.settings.SettingsMapper.generateDBInsert(loc1, loc2, loc3);
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.UPDATE, core.settings.SettingsMapper.getInsertStatement(loc2), this.onInsertSettingsComplete, this.onInsertSettingsError, arg1.workerTarget, arg1, loc3);
            return;
        }

        internal function onInsertSettingsComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            var loc1:*=arg1.data.data as backend.utils.dbUtils.DBUtilObject;
            var loc2:*=loc1.data as core.settings.Settings;
            loc2.settingsId = arg1.data.lastInsertRowId;
            debug.Debug.debug("onInsertSettingsComplete");
            loc1.completeCallback(new backend.utils.dbUtils.DBUtilEvent(backend.utils.dbUtils.DBUtilEvent.COMPLETE, loc1));
            return;
        }

        internal function onInsertSettingsError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("onInsertSettingsError");
            var loc1:*=arg1.data.data as backend.utils.dbUtils.DBUtilObject;
            loc1.errorCallback(new backend.utils.dbUtils.DBUtilEvent(backend.utils.dbUtils.DBUtilEvent.ERROR, loc1));
            return;
        }

        public function loadSettings(arg1:backend.utils.dbUtils.DBUtilObject, arg2:String="modificationDate", arg3:Boolean=true):void
        {
            var loc1:*=arg1.data.GUID;
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, core.settings.SettingsMapper.selectSettings(loc1, arg2, arg3), arg1.completeCallback, arg1.errorCallback, arg1.workerTarget);
            return;
        }

        public function loadPointNavigations(arg1:backend.utils.dbUtils.DBUtilObject, arg2:String="modificationDate", arg3:Boolean=true):void
        {
            var loc1:*=arg1.data.GUID;
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, core.gps.PointNavigationMapper.selectPointNavigation(loc1, arg2, arg3), arg1.completeCallback, arg1.errorCallback, arg1.workerTarget);
            return;
        }

        public function savePointNavigation(arg1:backend.utils.dbUtils.DBUtilObject):void
        {
            var loc1:*=arg1.data as core.gps.PointNavigation;
            var loc2:*=[];
            var loc3:*=[];
            core.gps.PointNavigationMapper.generateDBInsert(loc1, loc2, loc3);
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.UPDATE, core.gps.PointNavigationMapper.getInsertStatement(loc2), this.onInsertPointNavigationComplete, this.onInsertPointNavigationError, arg1.workerTarget, arg1, loc3);
            return;
        }

        internal function onInsertPointNavigationComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.debug("onInsertPointNavigationComplete");
            var loc1:*=arg1.data.data as backend.utils.dbUtils.DBUtilObject;
            var loc2:*=loc1.data as core.gps.PointNavigation;
            loc2.pointNavigationId = arg1.data.lastInsertRowId;
            loc1.completeCallback(new backend.utils.dbUtils.DBUtilEvent(backend.utils.dbUtils.DBUtilEvent.COMPLETE, loc1));
            return;
        }

        internal function onInsertPointNavigationError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("onInsertPointNavigationError");
            var loc1:*=arg1.data.data as backend.utils.dbUtils.DBUtilObject;
            loc1.errorCallback(new backend.utils.dbUtils.DBUtilEvent(backend.utils.dbUtils.DBUtilEvent.ERROR, loc1));
            return;
        }

        public function deleteSettings(arg1:Array):void
        {
            var loc1:*="DELETE FROM Settings WHERE GUID in (" + arg1.join(", ") + ") OR isDeleted = true";
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.UPDATE, loc1, this.onSettingsDeleteComplete, this.onSettingsDeleteError, null, arg1);
            return;
        }

        internal function onSettingsDeleteComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.debug("onSettingsDeleteComplete");
            handler.CommonSyncHandler.getInstance().onDeleteFromCloudComplete(service.cloud.CloudConfig.TYPE_DEVICE_SETTING, arg1.data.data as Array);
            return;
        }

        internal function onSettingsDeleteError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("onSettingsDeleteError");
            handler.CommonSyncHandler.getInstance().onDeleteFromCloudComplete(service.cloud.CloudConfig.TYPE_DEVICE_SETTING, arg1.data.data as Array);
            return;
        }

        public function loadSportprofiles(arg1:backend.utils.dbUtils.DBUtilObject, arg2:String="profileName", arg3:Boolean=true):void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (arg1.data is core.units.Unit) 
            {
                loc1 = arg1.data as core.units.Unit;
                loc2 = loc1.GUID;
                backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, core.sportprofiles.SportprofileMapper.selectSportprofiles(loc2, arg2, arg3), arg1.completeCallback, arg1.errorCallback, arg1.workerTarget);
            }
            return;
        }

        public function saveSportprofile(arg1:backend.utils.dbUtils.DBUtilObject):void
        {
            var loc1:*=arg1.data as core.sportprofiles.Sportprofile;
            var loc2:*=[];
            var loc3:*=[];
            core.sportprofiles.SportprofileMapper.generateDBInsert(loc1, loc2, loc3);
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.UPDATE, core.sportprofiles.SportprofileMapper.getInsertStatement(loc2), this.onInsertSportprofileComplete, this.onInsertSportprofileError, arg1.workerTarget, arg1, loc3);
            return;
        }

        internal function onInsertSportprofileComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            var loc1:*=arg1.data.data as backend.utils.dbUtils.DBUtilObject;
            var loc2:*=loc1.data as core.sportprofiles.Sportprofile;
            loc2.sportprofileId = arg1.data.lastInsertRowId;
            debug.Debug.debug("onInsertSportprofileComplete");
            loc1.completeCallback(new backend.utils.dbUtils.DBUtilEvent(backend.utils.dbUtils.DBUtilEvent.COMPLETE, loc1));
            return;
        }

        internal function onInsertSportprofileError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("onInsertSportprofileError");
            dispatchEvent(new com.logging.ErrorLoggingEvent(com.logging.ErrorLoggingEvent.ERROR, core.general.ErrorLoggingTyp.ERROR_SAVE_SPORTPROFILES_DATA, core.general.ErrorLoggingTyp.DESC_SPORTPROFILE_NOT_SAVED));
            var loc1:*=arg1.data.data as backend.utils.dbUtils.DBUtilObject;
            loc1.errorCallback(new backend.utils.dbUtils.DBUtilEvent(backend.utils.dbUtils.DBUtilEvent.ERROR, loc1));
            return;
        }

        public function deleteSportprofiles(arg1:Array):void
        {
            var loc1:*="DELETE FROM Sportprofiles WHERE GUID in (" + arg1.join(", ") + ") OR isDeleted = true";
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.UPDATE, loc1, this.onSportprofilesDeleteComplete, this.onSportprofilesDeleteError, null, arg1);
            return;
        }

        internal function onSportprofilesDeleteComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.debug("onSportprofilesDeleteComplete");
            handler.CommonSyncHandler.getInstance().onDeleteFromCloudComplete(service.cloud.CloudConfig.TYPE_DEVICE_SETTING, arg1.data.data as Array);
            return;
        }

        internal function onSportprofilesDeleteError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("onSportprofilesDeleteError");
            handler.CommonSyncHandler.getInstance().onDeleteFromCloudComplete(service.cloud.CloudConfig.TYPE_DEVICE_SETTING, arg1.data.data as Array);
            return;
        }

        public function deleteDeviceData(arg1:Array):void
        {
            var loc1:*="DELETE FROM " + core.settings.SettingsMapper.table_name + " WHERE GUID in (" + arg1.join(", ") + ") OR isDeleted = true";
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.UPDATE, loc1, this.onDeleteDeviceDataSettingsComplete, this.onDeleteDeviceDataError, null, arg1);
            return;
        }

        internal function onDeleteDeviceDataError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("deleteDeviceDataError");
            handler.CommonSyncHandler.getInstance().onDeleteFromCloudComplete(service.cloud.CloudConfig.TYPE_DEVICE_SETTING, arg1.data.data as Array);
            return;
        }

        internal function onDeleteDeviceDataSettingsComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            var loc1:*=arg1.data.data as Array;
            var loc2:*="DELETE FROM " + core.sportprofiles.SportprofileMapper.TABLE_NAME + " WHERE GUID in (" + loc1.join(", ") + ") OR isDeleted = true";
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.UPDATE, loc2, this.onDeleteDeviceDataSportprofilesComplete, this.onDeleteDeviceDataError, null, loc1);
            return;
        }

        internal function onDeleteDeviceDataSportprofilesComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            var loc1:*=arg1.data.data as Array;
            var loc2:*="DELETE FROM " + core.gps.PointNavigationMapper.table_name + " WHERE GUID in (" + loc1.join(", ") + ") OR isDeleted = true";
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.UPDATE, loc2, this.onDeleteDeviceDataPointnavigationsComplete, this.onDeleteDeviceDataError, null, loc1);
            return;
        }

        internal function onDeleteDeviceDataPointnavigationsComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            var loc1:*=arg1.data.data as Array;
            handler.CommonSyncHandler.getInstance().onDeleteFromCloudComplete(service.cloud.CloudConfig.TYPE_DEVICE_SETTING, loc1);
            return;
        }

        public function deletePointNavigations(arg1:Array):void
        {
            var loc1:*="DELETE FROM " + core.gps.PointNavigationMapper.table_name + " WHERE GUID in (" + arg1.join(", ") + ") OR isDeleted = true";
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.UPDATE, loc1, this.onPointNavigationsDeleteComplete, this.onPointNavigationsDeleteError, null, arg1);
            return;
        }

        internal function onPointNavigationsDeleteComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.debug("onPointNavigationsDeleteComplete");
            handler.CommonSyncHandler.getInstance().onDeleteFromCloudComplete(service.cloud.CloudConfig.TYPE_DEVICE_SETTING, arg1.data.data as Array);
            return;
        }

        internal function onPointNavigationsDeleteError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("onPointNavigationsDeleteError");
            handler.CommonSyncHandler.getInstance().onDeleteFromCloudComplete(service.cloud.CloudConfig.TYPE_DEVICE_SETTING, arg1.data.data as Array);
            return;
        }

        public function downloadTrainingProgram(arg1:XML, arg2:service.cloud.CloudURLStream):void
        {
            var loc1:*=core.training.TrainingMapper.fromXML(arg1);
            loc1.GUID = arg2.data.GUID;
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, core.training.TrainingMapper.selectPrimaryKeyFromGUID(loc1), this.onGetTrainingIdComplete, this.onGetTrainingIdError, null, [loc1, arg2]);
            return;
        }

        internal function onGetTrainingIdComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            var loc1:*=arg1.data.data[0] as core.training.Training;
            var loc2:*=arg1.data.data[1] as service.cloud.CloudURLStream;
            var loc3:*=arg1.getResult();
            if (loc3.length != 1) 
            {
                this.saveDownloadedTraining(loc1, loc2);
            }
            else 
            {
                backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.UPDATE, core.training.TrainingMapper.generateDBDelete(loc1), this.onDeleteTrainingComplete, this.onDeleteTrainingError, null, [loc1, loc2]);
            }
            return;
        }

        internal function onGetTrainingIdError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("onGetTrainingIdError");
            handler.CommonSyncHandler.getInstance().onDownloadFromCloudComplete(service.cloud.CloudConfig.TYPE_TRAINING_PROGRAM);
            return;
        }

        internal function onDeleteTrainingComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.debug("onDeleteTrainingComplete");
            var loc1:*=arg1.data.data[0] as core.training.Training;
            var loc2:*=arg1.data.data[1] as service.cloud.CloudURLStream;
            this.saveDownloadedTraining(loc1, loc2);
            return;
        }

        internal function onDeleteTrainingError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("onDeleteTrainingError");
            handler.CommonSyncHandler.getInstance().onDownloadFromCloudComplete(service.cloud.CloudConfig.TYPE_TRAINING_PROGRAM);
            return;
        }

        internal function saveDownloadedTraining(arg1:core.training.Training, arg2:service.cloud.CloudURLStream):void
        {
            debug.Debug.debug("saveDownloadedTraining");
            arg1.modificationDate = arg2.data.modificationDate;
            var loc1:*=new backend.utils.dbUtils.DBUtilObject(arg1, this.saveDownloadedTrainingComplete, this.saveDownloadedTrainingError, null, true);
            this.saveTraining(loc1);
            return;
        }

        internal function saveDownloadedTrainingComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.debug("saveDownloadedTrainingComplete");
            handler.CommonSyncHandler.getInstance().onDownloadFromCloudComplete(service.cloud.CloudConfig.TYPE_TRAINING_PROGRAM);
            return;
        }

        internal function saveDownloadedTrainingError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("saveDownloadedTrainingError");
            handler.CommonSyncHandler.getInstance().onDownloadFromCloudComplete(service.cloud.CloudConfig.TYPE_TRAINING_PROGRAM);
            return;
        }

        public function saveTraining(arg1:backend.utils.dbUtils.DBUtilObject):void
        {
            var loc1:*=[];
            var loc2:*=[];
            core.training.TrainingMapper.generateDBInsert(arg1.data as core.training.Training, loc1, loc2);
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.UPDATE, core.training.TrainingMapper.getInsertStatement(loc1), this.onInsertTrainingComplete, this.onInsertTrainingError, arg1.workerTarget, arg1, loc2);
            return;
        }

        internal function onInsertTrainingComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.debug("Training/Workout saved...");
            var loc1:*=arg1.data.data as backend.utils.dbUtils.DBUtilObject;
            if (arg1.data.lastInsertRowId != 0) 
            {
                (loc1.data as core.training.Training).trainingId = arg1.data.lastInsertRowId;
            }
            if (loc1.parameters) 
            {
                this.saveTrainingPhases(loc1);
            }
            else 
            {
                loc1.completeCallback(new backend.utils.dbUtils.DBUtilEvent(backend.utils.dbUtils.DBUtilEvent.COMPLETE));
            }
            return;
        }

        internal function onInsertTrainingError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            var loc1:*=arg1.data.data as backend.utils.dbUtils.DBUtilObject;
            loc1.errorCallback(new backend.utils.dbUtils.DBUtilEvent(backend.utils.dbUtils.DBUtilEvent.ERROR));
            return;
        }

        public function saveTrainingPhases(arg1:backend.utils.dbUtils.DBUtilObject):void
        {
            var loc2:*=0;
            var loc5:*=null;
            var loc6:*=null;
            var loc7:*=null;
            var loc8:*=null;
            var loc1:*=arg1.data as core.training.Training;
            var loc3:*=loc1.phasesList.length;
            var loc4:*=new Array();
            if (loc3 != 0) 
            {
                loc2 = 0;
                while (loc2 < loc3) 
                {
                    loc5 = loc1.phasesList[loc2];
                    loc6 = [];
                    loc7 = [];
                    loc5.trainingId = loc1.trainingId;
                    core.training.TrainingPhaseMapper.generateDBInsert(loc5, loc6, loc7);
                    loc8 = new backend.utils.dbUtils.DBUtilObject();
                    loc8.stmt = core.training.TrainingPhaseMapper.getInsertStatement(loc6);
                    loc8.parameters = loc7;
                    loc4.push(loc8);
                    ++loc2;
                }
                backend.utils.dbUtils.DBUtil.getInstance().callMultiple(flash.data.SQLMode.UPDATE, loc4, this.onInsertTrainingPhasesComplete, this.onInsertTrainingPhasesError, arg1.workerTarget, arg1);
            }
            else 
            {
                arg1.completeCallback(new backend.utils.dbUtils.DBUtilEvent(backend.utils.dbUtils.DBUtilEvent.COMPLETE));
            }
            return;
        }

        internal function onInsertTrainingPhasesComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.debug("Training phases saved...");
            var loc1:*=arg1.data.data as backend.utils.dbUtils.DBUtilObject;
            loc1.completeCallback(new backend.utils.dbUtils.DBUtilEvent(backend.utils.dbUtils.DBUtilEvent.COMPLETE));
            return;
        }

        internal function onInsertTrainingPhasesError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("Training phases inser error...");
            var loc1:*=arg1.data.data as backend.utils.dbUtils.DBUtilObject;
            loc1.errorCallback(new backend.utils.dbUtils.DBUtilEvent(backend.utils.dbUtils.DBUtilEvent.ERROR));
            return;
        }

        public function loadTrainings(arg1:backend.utils.dbUtils.DBUtilObject, arg2:String="modificationDate", arg3:Boolean=true):void
        {
            var loc1:*=arg1.data.GUID;
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, core.training.TrainingMapper.selectTrainings(loc1, arg2, arg3), arg1.completeCallback, arg1.errorCallback, arg1.workerTarget);
            return;
        }

        public function deleteTrainings(arg1:Array):void
        {
            var loc1:*="DELETE FROM Training WHERE GUID in (" + arg1.join(", ") + ") OR isDeleted = true";
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.UPDATE, loc1, this.onTrainingsDeleteComplete, this.onTrainingsDeleteError, null, arg1);
            return;
        }

        internal function onTrainingsDeleteComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.debug("onTrainingsDeleteComplete");
            handler.CommonSyncHandler.getInstance().onDeleteFromCloudComplete(service.cloud.CloudConfig.TYPE_TRAINING_PROGRAM, arg1.data.data as Array);
            return;
        }

        internal function onTrainingsDeleteError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("onTrainingsDeleteError");
            handler.CommonSyncHandler.getInstance().onDeleteFromCloudComplete(service.cloud.CloudConfig.TYPE_TRAINING_PROGRAM, arg1.data.data as Array);
            return;
        }

        public static function getInstance():handler.AppDeviceHandler
        {
            if (_instance == null) 
            {
                _instance = new AppDeviceHandler();
            }
            return _instance;
        }

        internal static var _instance:handler.AppDeviceHandler;
    }
}


