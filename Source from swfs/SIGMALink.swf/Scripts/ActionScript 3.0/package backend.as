//package backend
//  package database
//    class DatabaseDefinition
package backend.database 
{
    import com.logging.*;
    import core.*;
    import core.activities.*;
    import core.general.*;
    import core.gps.*;
    import core.marker.*;
    import core.participant.*;
    import core.route.*;
    import core.settings.*;
    import core.sportprofiles.*;
    import core.totals.*;
    import core.training.*;
    import core.units.*;
    import core.user.*;
    import database.*;
    import database.columnMapper.*;
    import database.update.*;
    import debug.*;
    import flash.events.*;
    import flash.filesystem.*;
    import flash.utils.*;
    import handler.*;
    import utils.*;
    
    public class DatabaseDefinition extends database.CommonDatabaseDefinition
    {
        public function DatabaseDefinition()
        {
            super();
            return;
        }

        protected override function init():void
        {
            var loc1:*=new database.Database("SigmaLink.db", "1.0", database.CommonDatabaseDefinition.DB_510, database.CommonDatabaseDefinition.DB_520, ".", false, null, false);
            oldDatabaseFiles.push(loc1);
            var loc2:*=new database.Database("SigmaLink.db", "1.2", database.CommonDatabaseDefinition.DB_520, database.CommonDatabaseDefinition.DB_520, ".", false, null, false);
            currentDatabase = loc2;
            return;
        }

        public override function getCreateTableFunction(arg1:uint):Array
        {
            var loc1:*=new Array();
            if (arg1 >= database.CommonDatabaseDefinition.DB_510) 
            {
                loc1.push(core.Status.generateDBCreateTable(arg1));
                loc1.push(core.units.Unit.generateDBCreateTable(arg1));
                loc1.push(core.activities.ActivityMapper.generateDBCreateTable(arg1));
                loc1.push(core.activities.ActivityEntryMapper.generateDBCreateTable(arg1));
                loc1.push(core.training.TrainingMapper.generateDBCreateTable(arg1));
                loc1.push(core.training.TrainingPhaseMapper.generateDBCreateTable(arg1));
                loc1.push(core.marker.MarkerMapper.generateDBCreateTable(arg1));
                loc1.push(core.user.User.generateDBCreateTable(arg1));
                loc1.push(core.participant.Person.generateDBCreateTable(arg1));
                loc1.push(core.participant.Person.generateDBCreateTableActivityPerson(arg1));
                loc1.push(core.route.Route.generateDBCreateTable(arg1));
                loc1.push(core.route.RouteOptions.generateDBCreateTable(arg1));
                loc1.push(core.route.RoutePoint.generateDBCreateTable(arg1));
                loc1.push(core.route.RoutePointInstruction.generateDBCreateTable());
                loc1.push(core.route.RoutePoi.generateDBCreateTable(arg1));
                loc1.push(core.settings.SettingsMapper.generateDBCreateTable(arg1));
                loc1.push(core.totals.TotalsEntity.generateDBCreateTable(arg1));
                loc1.push(core.sportprofiles.SportprofileMapper.generateDBCreateTable(arg1));
                loc1.push(core.route.Route.generateDBCreateTrigger(arg1));
                loc1.push(core.activities.ActivityMapper.generateDBCreateTrigger(arg1));
                loc1.push(core.units.Unit.generateDBCreateTrigger(arg1));
                loc1.push(core.training.TrainingMapper.generateDBCreateTrigger(arg1));
            }
            if (arg1 >= database.CommonDatabaseDefinition.DB_520) 
            {
                loc1.push(core.gps.PointNavigationMapper.generateDBCreateTable(arg1));
            }
            loc1.push(core.Status.generateDefaultStatement(arg1));
            this.addIndizesStatements(arg1, loc1);
            return loc1;
        }

        internal function addIndizesStatements(arg1:uint, arg2:Array=null):Array
        {
            if (!arg2) 
            {
                arg2 = [];
            }
            if (arg1 >= database.CommonDatabaseDefinition.DB_510) 
            {
                arg2.push(core.activities.ActivityEntryMapper.generateDBCreateIndex());
                arg2.push(core.training.TrainingMapper.generateDBCreateIndex());
                arg2.push(core.training.TrainingPhaseMapper.generateDBCreateIndex());
                arg2.push(core.marker.MarkerMapper.generateDBCreateIndex());
                arg2.push(core.route.RoutePoint.generateDBCreateIndex());
                arg2.push(core.route.RoutePointInstruction.generateDBCreateIndex());
                arg2.push(core.route.RoutePoi.generateDBCreateIndex());
                arg2.push(core.settings.SettingsMapper.generateDBCreateIndex());
                arg2.push(core.totals.TotalsEntity.generateDBCreateIndex());
                arg2.push(core.sportprofiles.SportprofileMapper.generateDBCreateIndex());
            }
            if (arg1 >= database.CommonDatabaseDefinition.DB_520) 
            {
                arg2.push(core.gps.PointNavigationMapper.generateDBCreateIndex());
            }
            return arg2;
        }

        public override function checkDatabaseStructure():void
        {
            var loc1:*=new utils.Base64Decoder();
            loc1.decode(database.Database.myDecoderPwd);
            this.sqlValidator = new database.update.SQLUpdateHelper(database.DatabaseHandlerCommon.getInstance().dataBase, loc1.toByteArray());
            this.checkStructure();
            return;
        }

        internal function checkStructure():void
        {
            var loc1:*=this.getCreateTableFunction(database.CommonDatabaseDefinition.CURRENT_DB_VERSION);
            this.sqlValidator.addEventListener(database.update.SQLUpdateEvent.EXECUTED, this.checkStructureComplete);
            this.sqlValidator.addEventListener(database.update.SQLUpdateErrorEvent.EVENT_ERROR, this.checkStructureError);
            this.sqlValidator.checkStructure(loc1);
            return;
        }

        internal function checkStructureError(arg1:database.update.SQLUpdateErrorEvent):void
        {
            this.sqlValidator.removeEventListener(database.update.SQLUpdateEvent.EXECUTED, this.checkStructureComplete);
            this.sqlValidator.removeEventListener(database.update.SQLUpdateErrorEvent.EVENT_ERROR, this.checkStructureError);
            this.sqlValidator.dispose();
            database.DatabaseHandlerCommon.getInstance().dispatchEvent(new com.logging.ErrorLoggingEvent(com.logging.ErrorLoggingEvent.ERROR, core.general.ErrorLoggingTyp.ERROR_INVALID_DATABASE, arg1.message));
            dispatchEvent(new flash.events.Event(DATABASE_STRUCTURE_INVALID));
            return;
        }

        internal function checkStructureComplete(arg1:flash.events.Event):void
        {
            this.sqlValidator.removeEventListener(database.update.SQLUpdateEvent.EXECUTED, this.checkStructureComplete);
            this.sqlValidator.removeEventListener(database.update.SQLUpdateErrorEvent.EVENT_ERROR, this.checkStructureError);
            this.sqlValidator.dispose();
            dispatchEvent(new flash.events.Event(DATABASE_STRUCTURE_VALID));
            return;
        }

        public function stopUpdate():void
        {
            debug.Debug.database("undoDatabaseUpdate");
            if (this.sqlUpdate) 
            {
                this.sqlUpdate.dispose();
                this.sqlUpdate.removeEventListener(database.update.SQLUpdateErrorEvent.EVENT_ERROR, this.onUpdateError);
                this.sqlUpdate.removeEventListener(database.update.SQLUpdateEvent.EXECUTED, this.executeFunctions);
            }
            return;
        }

        public override function createDatabaseUpdate(arg1:flash.filesystem.File, arg2:database.Database, arg3:database.Database):void
        {
            var loc1:*=new utils.Base64Decoder();
            loc1.decode(database.Database.myDecoderPwd);
            this.targetDB = arg3;
            this.sqlUpdate = new database.update.SQLUpdateHelper(arg1, loc1.toByteArray());
            this.sqlUpdate.addEventListener(database.update.SQLUpdateErrorEvent.EVENT_ERROR, this.onUpdateError);
            this.sqlUpdate.addEventListener(database.update.SQLUpdateEvent.EXECUTED, this.executeFunctions);
            this.functions = [];
            var loc2:*=arg2.versionNumber;
            switch (loc2) 
            {
                case database.CommonDatabaseDefinition.DB_510:
                {
                    this.functions.push(this.updateActivity_510_to_520);
                    this.functions.push(this.updateActivityAdd_510_to_520);
                    this.functions.push(this.updatePointNaviation_510_to_520);
                    this.functions.push(this.updateTrainingPhaseRemove_510_to_520);
                    this.functions.push(this.updateRouteTrigger_510_to_520);
                    this.functions.push(this.updateActivityTrigger_510_to_520);
                    this.functions.push(this.updateUnitTrigger_510_to_520);
                    this.functions.push(this.updateTrainingTrigger_510_to_520);
                    this.functions.push(this.updateIndizes_510_to_520);
                    break;
                }
            }
            this.functionsLength = this.functions.length + 2;
            this.index = this.functionsLength != 2 ? 0 : 1;
            this.executeFunctions();
            return;
        }

        internal function executeFunctions(arg1:flash.events.Event=null):void
        {
            var loc2:*=null;
            if (this.index == this.functionsLength - 2) 
            {
                debug.Debug.database("step " + (this.functionsLength - 1) + "/" + this.functionsLength + ": statements executed, now: compact");
                this.dispatchProgressEvent(this.functionsLength, this.index);
                var loc3:*;
                var loc4:*=((loc3 = this).index + 1);
                loc3.index = loc4;
                this.sqlUpdate.compact();
                return;
            }
            if (this.index == (this.functionsLength - 1)) 
            {
                debug.Debug.database("step " + this.functionsLength + "/" + this.functionsLength + ": compact complete, update status and start DC");
                this.targetDB.initDatabaseFile();
                loc2 = new core.Status();
                loc2.databaseVersion = this.targetDB.version;
                loc2.dbUpdateNumber = this.targetDB.versionNumber;
                loc2.trialCounter = 0;
                loc2.databaseUpdateStatus = core.Status.UPDATE_COMPLETE;
                core.Status.setNewStatus(loc2);
                handler.AppDBHandler.getInstance().status = loc2;
                this.dispatchProgressEvent(this.functionsLength, this.functionsLength);
                this.stopUpdate();
                flash.utils.setTimeout(dispatchEvent, this.executeDelay, new flash.events.Event(database.update.CommonDatabaseUpdate.DATABASE_OKAY));
                return;
            }
            debug.Debug.info("step " + this.index + "/" + this.functionsLength + ": execute next function");
            this.dispatchProgressEvent(this.functionsLength, this.index);
            var loc1:*=this.functions[this.index] as Function;
            loc4 = ((loc3 = this).index + 1);
            loc3.index = loc4;
            loc1.apply();
            return;
        }

        internal function dispatchProgressEvent(arg1:Number, arg2:Number):void
        {
            var loc1:*=new database.update.SQLUpdateEvent(database.update.CommonDatabaseUpdate.PROGRESS);
            loc1.maximum = arg1;
            loc1.value = arg2;
            dispatchEvent(loc1);
            return;
        }

        internal function onUpdateError(arg1:database.update.SQLUpdateErrorEvent):void
        {
            debug.Debug.error("update error: " + arg1.message);
            var loc1:*=arg1.currentTarget as database.update.SQLUpdateHelper;
            loc1.dispose();
            dispatchEvent(new flash.events.Event(database.update.CommonDatabaseUpdate.DATABASE_ERROR));
            return;
        }

        internal function updateIndizes_510_to_520():void
        {
            var loc1:*=[];
            this.addIndizesStatements(database.CommonDatabaseDefinition.DB_520, loc1);
            this.sqlUpdate.updateIndizes(loc1);
            return;
        }

        internal function updateUnitTrigger_510_to_520():void
        {
            debug.Debug.database("updateUnitTrigger_510_to_520");
            this.sqlUpdate.updateTrigger("UnitTrigger", core.units.Unit.generateDBCreateTrigger(database.CommonDatabaseDefinition.DB_520));
            return;
        }

        internal function updateRouteTrigger_510_to_520():void
        {
            debug.Debug.database("updateRouteTrigger_510_to_520");
            this.sqlUpdate.updateTrigger("RouteTrigger", core.route.Route.generateDBCreateTrigger(database.CommonDatabaseDefinition.DB_520));
            return;
        }

        internal function updateActivityTrigger_510_to_520():void
        {
            debug.Debug.database("updateActivityTrigger_510_to_520");
            this.sqlUpdate.updateTrigger("ActivityTrigger", core.activities.ActivityMapper.generateDBCreateTrigger(database.CommonDatabaseDefinition.DB_520));
            return;
        }

        internal function updateTrainingTrigger_510_to_520():void
        {
            debug.Debug.database("updateTrainingTrigger_510_to_520");
            this.sqlUpdate.updateTrigger("TrainingTrigger", core.training.TrainingMapper.generateDBCreateTrigger(database.CommonDatabaseDefinition.DB_520));
            return;
        }

        internal function updateActivity_510_to_520():void
        {
            debug.Debug.database("updateActivity_510_to_520");
            var loc1:*=[[database.columnMapper.DB_510_Activity.col_averagePowerWatt, ""]];
            this.sqlUpdate.renameOrRemoveColumns(database.columnMapper.DB_510_Activity.table_name, loc1);
            return;
        }

        internal function updateActivityAdd_510_to_520():void
        {
            debug.Debug.database("updateActivityAdd_510_to_520");
            var loc1:*=[];
            loc1.push([core.activities.ActivityMapper.col_best20minPowerEntry, "INTEGER", true, false, ""]);
            this.sqlUpdate.addColumns(core.activities.ActivityMapper.table_name, loc1);
            return;
        }

        internal function updateTrainingPhaseRemove_510_to_520():void
        {
            debug.Debug.database("updateTrainingPhaseRemove_510_to_520");
            var loc1:*=[[database.columnMapper.DB_510_TrainingPhase.col_loadZoneType, ""], [database.columnMapper.DB_510_TrainingPhase.col_recoveryZoneType, ""]];
            this.sqlUpdate.renameOrRemoveColumns(core.training.TrainingPhaseMapper.table_name, loc1);
            return;
        }

        internal function updatePointNaviation_510_to_520():void
        {
            debug.Debug.database("updatePointNaviation_510_to_520");
            this.sqlUpdate.createTable(core.gps.PointNavigationMapper.generateDBCreateTable(database.CommonDatabaseDefinition.DB_520));
            return;
        }

        public static function getInstance():backend.database.DatabaseDefinition
        {
            if (!_instance) 
            {
                _instance = new DatabaseDefinition();
                database.CommonDatabaseDefinition.setInstance(_instance);
            }
            return _instance;
        }

        internal var executeDelay:Number=500;

        internal var functions:Array;

        internal var functionsLength:int=0;

        internal var index:int;

        internal var sqlUpdate:database.update.SQLUpdateHelper;

        internal var sqlValidator:database.update.SQLUpdateHelper;

        internal var targetDB:database.Database;

        internal static var _instance:backend.database.DatabaseDefinition;
    }
}


//    class DatabaseUpdate
package backend.database 
{
    import database.update.*;
    import debug.*;
    import flash.events.*;
    import handler.*;
    
    public class DatabaseUpdate extends database.update.CommonDatabaseUpdate
    {
        public function DatabaseUpdate()
        {
            super();
            return;
        }

        protected override function startUpdate():void
        {
            backend.database.DatabaseDefinition.getInstance().addEventListener(database.update.CommonDatabaseUpdate.DATABASE_OKAY, this.onUpdateOkay);
            backend.database.DatabaseDefinition.getInstance().addEventListener(database.update.CommonDatabaseUpdate.DATABASE_ERROR, this.onUpdateError);
            backend.database.DatabaseDefinition.getInstance().addEventListener(database.update.CommonDatabaseUpdate.PROGRESS, onUpdateProgress);
            backend.database.DatabaseDefinition.getInstance().createDatabaseUpdate(newDatabase.file, oldDatabase, newDatabase);
            return;
        }

        internal function onUpdateOkay(arg1:flash.events.Event):void
        {
            backend.database.DatabaseDefinition.getInstance().removeEventListener(database.update.CommonDatabaseUpdate.DATABASE_OKAY, this.onUpdateOkay);
            backend.database.DatabaseDefinition.getInstance().removeEventListener(database.update.CommonDatabaseUpdate.DATABASE_ERROR, this.onUpdateError);
            backend.database.DatabaseDefinition.getInstance().removeEventListener(database.update.CommonDatabaseUpdate.PROGRESS, onUpdateProgress);
            dispatchEvent(new flash.events.Event(database.update.CommonDatabaseUpdate.DATABASE_OKAY));
            return;
        }

        internal function onUpdateError(arg1:flash.events.Event):void
        {
            debug.Debug.error("DatabaseUpdate > onUpdateError............");
            backend.database.DatabaseDefinition.getInstance().removeEventListener(database.update.CommonDatabaseUpdate.DATABASE_OKAY, this.onUpdateOkay);
            backend.database.DatabaseDefinition.getInstance().removeEventListener(database.update.CommonDatabaseUpdate.DATABASE_ERROR, this.onUpdateError);
            backend.database.DatabaseDefinition.getInstance().removeEventListener(database.update.CommonDatabaseUpdate.PROGRESS, onUpdateProgress);
            backend.database.DatabaseDefinition.getInstance().stopUpdate();
            backend.database.DatabaseDefinition.getInstance().currentDatabase.deleteDatabase();
            handler.AppDBHandler.getInstance().validateDatabase();
            dispatchEvent(new flash.events.Event(database.update.CommonDatabaseUpdate.DATABASE_ERROR));
            return;
        }

        public static function getInstance():backend.database.DatabaseUpdate
        {
            if (!_instance) 
            {
                _instance = new DatabaseUpdate();
                database.update.CommonDatabaseUpdate.setInstance(_instance);
            }
            return _instance;
        }

        internal static var _instance:backend.database.DatabaseUpdate;
    }
}


//  package events
//    class UnitDataEvent
package backend.events 
{
    import flash.events.*;
    
    public class UnitDataEvent extends flash.events.Event
    {
        public function UnitDataEvent(arg1:String, arg2:Object, arg3:Boolean=false, arg4:Boolean=false)
        {
            super(arg1, arg3, arg4);
            this.data = arg2;
            return;
        }

        public function get data():Object
        {
            return this._data;
        }

        public function set data(arg1:Object):void
        {
            this._data = arg1;
            return;
        }

        public static const DATA_ADDED:String="dataAddedEvent";

        public static const DATA_CHANGED:String="dataChangeEvent";

        public static const DATA_REMOVED:String="dataRemovedEvent";

        public static const SHARING_DATA_ADDED:String="sharingDataAddedEvent";

        internal var _data:Object;
    }
}


//  package oauth
//    class FacebookGoViralHandler
package backend.oauth 
{
    import com.milkmangames.nativeextensions.*;
    import com.milkmangames.nativeextensions.events.*;
    import debug.*;
    import flash.display.*;
    import flash.events.*;
    import flash.media.*;
    import frontend.components.popup.oauth.*;
    
    public class FacebookGoViralHandler extends frontend.components.popup.oauth.CustomOAuth
    {
        public function FacebookGoViralHandler()
        {
            this.facebookObject = new Object();
            this.postObject = new Object();
            super();
            className = "FacebookGoViralHandler";
            CLIENT_ID = APP_ID;
            CLIENT_SECRET = "288c9b39d76fa7724360329c4eddf2ce";
            UPLOAD_URL = "https://graph.facebook.com/v2.8/";
            if (!com.milkmangames.nativeextensions.GoViral.isSupported()) 
            {
                return;
            }
            com.milkmangames.nativeextensions.GoViral.create();
            if (!com.milkmangames.nativeextensions.GoViral.goViral.isFacebookSupported()) 
            {
                return;
            }
            debug.Debug.debug("Facebook supported... initializing Facebook!");
            com.milkmangames.nativeextensions.GoViral.goViral.initFacebook(APP_ID, "");
            com.milkmangames.nativeextensions.GoViral.goViral.addEventListener(com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_LOGGED_IN, this.onFacebookEvent);
            com.milkmangames.nativeextensions.GoViral.goViral.addEventListener(com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_LOGGED_OUT, this.onFacebookEvent);
            com.milkmangames.nativeextensions.GoViral.goViral.addEventListener(com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_LOGIN_CANCELED, this.onFacebookEvent);
            com.milkmangames.nativeextensions.GoViral.goViral.addEventListener(com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_LOGIN_FAILED, this.onFacebookEvent);
            debug.Debug.debug("Facebook initialized...");
            return;
        }

        public override function get accessToken():String
        {
            var loc1:*=com.milkmangames.nativeextensions.GoViral.goViral.getFbAccessToken();
            return loc1;
        }

        public function postData(arg1:String, arg2:Object=null):void
        {
            com.milkmangames.nativeextensions.GoViral.goViral.facebookGraphRequest(arg1, com.milkmangames.nativeextensions.GVHttpMethod.POST, arg2, APP_PERMISSIONS_PUBLISH).addRequestListener(this.onPostDataResponse);
            return;
        }

        internal function onPostDataResponse(arg1:com.milkmangames.nativeextensions.events.GVFacebookEvent):void
        {
            if (arg1.type != com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_REQUEST_RESPONSE) 
            {
                debug.Debug.debug("Failed:" + arg1.errorMessage);
                dispatchEvent(new flash.events.Event(FBH_POST_DATA_ERROR));
            }
            else 
            {
                debug.Debug.debug("Posted:" + arg1.jsonData);
                dispatchEvent(new flash.events.Event(FBH_POST_DATA_SUCCESS));
            }
            return;
        }

        public static function getInstance():backend.oauth.FacebookGoViralHandler
        {
            if (!_instance) 
            {
                _instance = new FacebookGoViralHandler();
            }
            return _instance;
        }

        protected override function initWebView():void
        {
            debug.Debug.debug("not implemented - initWebView");
            return;
        }

        public override function destructor():void
        {
            debug.Debug.debug("not implemented - destructor");
            return;
        }

        public override function showWebViewer(arg1:Boolean):void
        {
            debug.Debug.debug("not implemented - showWebViewer");
            return;
        }

        protected override function doOAuthCall(arg1:flash.media.StageWebView):void
        {
            debug.Debug.debug("not implemented - doOAuthCall");
            return;
        }

        protected override function getStageWebView():flash.media.StageWebView
        {
            debug.Debug.debug("not implemented - getStageWebView");
            return null;
        }

        public static function trackAction(arg1:String):void
        {
            return;
        }

        public function getLoginStatus():Boolean
        {
            return com.milkmangames.nativeextensions.GoViral.goViral.isFacebookAuthenticated();
        }

        public function isNativeFacebookAvailable():Boolean
        {
            return com.milkmangames.nativeextensions.GoViral.goViral.isFacebookSupported() && com.milkmangames.nativeextensions.GoViral.goViral.isFacebookMessageDialogAvailable();
        }

        public override function checkLogin(arg1:flash.display.Stage, arg2:Boolean):void
        {
            var p_stage:flash.display.Stage;
            var p_showPopupIfRequired:Boolean;

            var loc1:*;
            p_stage = arg1;
            p_showPopupIfRequired = arg2;
            if (com.milkmangames.nativeextensions.GoViral.isSupported()) 
            {
                if (this.getLoginStatus() != false) 
                {
                    com.milkmangames.nativeextensions.GoViral.goViral.requestNewFacebookReadPermissions(APP_PERMISSIONS_READ);
                    com.milkmangames.nativeextensions.GoViral.goViral.requestNewFacebookPublishPermissions(APP_PERMISSIONS_PUBLISH);
                }
                else if (p_showPopupIfRequired) 
                {
                    try 
                    {
                        com.milkmangames.nativeextensions.GoViral.goViral.authenticateWithFacebook(APP_BASE_PERMISSIONS);
                    }
                    catch (e:Error)
                    {
                        debug.Debug.error("Error: " + e.message);
                    }
                }
            }
            return;
        }

        public override function logout():void
        {
            com.milkmangames.nativeextensions.GoViral.goViral.logoutFacebook();
            return;
        }

        public function onFacebookEvent(arg1:com.milkmangames.nativeextensions.events.GVFacebookEvent):void
        {
            var loc1:*=arg1.type;
            switch (loc1) 
            {
                case com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_LOGGED_IN:
                {
                    loggedOut = false;
                    com.milkmangames.nativeextensions.GoViral.goViral.requestNewFacebookReadPermissions(APP_PERMISSIONS_READ);
                    com.milkmangames.nativeextensions.GoViral.goViral.requestNewFacebookPublishPermissions(APP_PERMISSIONS_PUBLISH);
                    debug.Debug.debug("Logged in to facebook:" + com.milkmangames.nativeextensions.GoViral.VERSION);
                    debug.Debug.debug("DeclinedFacebookPermissions:" + com.milkmangames.nativeextensions.GoViral.goViral.getDeclinedFacebookPermissions().toString());
                    debug.Debug.debug("isFacebookPermissionGranted - " + APP_PERMISSIONS_READ + ":" + com.milkmangames.nativeextensions.GoViral.goViral.isFacebookPermissionGranted(APP_PERMISSIONS_READ));
                    debug.Debug.debug("isFacebookPermissionGranted - " + APP_PERMISSIONS_PUBLISH + ":" + com.milkmangames.nativeextensions.GoViral.goViral.isFacebookPermissionGranted(APP_PERMISSIONS_PUBLISH));
                    break;
                }
                case com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_LOGGED_OUT:
                {
                    loggedOut = true;
                    debug.Debug.debug("Logged out of facebook.");
                    break;
                }
                case com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_LOGIN_CANCELED:
                {
                    debug.Debug.debug("Canceled facebook login.");
                    break;
                }
                case com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_LOGIN_FAILED:
                {
                    debug.Debug.debug("Login failed:" + arg1.errorMessage + ",sn?" + arg1.shouldNotifyFacebookUser + ",cat?" + arg1.facebookUserErrorMessage);
                    break;
                }
                case com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_PUBLISH_PERMISSIONS_FAILED:
                case com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_READ_PERMISSIONS_FAILED:
                {
                    debug.Debug.debug("perms failed:" + arg1.errorMessage + ",sn?" + arg1.shouldNotifyFacebookUser + ",cat?" + arg1.facebookUserErrorMessage + "," + arg1.permissions + ", uf=" + com.milkmangames.nativeextensions.GoViral.goViral.isFacebookPermissionGranted("user_friends"));
                    break;
                }
                case com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_READ_PERMISSIONS_UPDATED:
                case com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_PUBLISH_PERMISSIONS_UPDATED:
                {
                    debug.Debug.debug("Perms updated:" + arg1.permissions + ", uf=" + com.milkmangames.nativeextensions.GoViral.goViral.isFacebookPermissionGranted("user_friends"));
                    break;
                }
                case com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_PERMISSIONS_REFRESHED:
                {
                    debug.Debug.debug("Perms refreshed, now:" + arg1.permissions + ",uf=" + com.milkmangames.nativeextensions.GoViral.goViral.isFacebookPermissionGranted("user_friends"));
                    break;
                }
                case com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_PERMISSIONS_REFRESH_FAILED:
                {
                    debug.Debug.debug("Refresh permission failed:" + arg1.errorMessage + ",sn?" + arg1.shouldNotifyFacebookUser + ",cat?" + arg1.facebookUserErrorMessage + "," + arg1.permissions + ", uf=" + com.milkmangames.nativeextensions.GoViral.goViral.isFacebookPermissionGranted("user_friends"));
                    break;
                }
            }
            return;
        }

        public function postWalk(arg1:Object, arg2:String):void
        {
            this.postId = "";
            this.postObject = arg1;
            this.postType = arg2;
            debug.Debug.debug("postWalk: " + arg1.toString());
            com.milkmangames.nativeextensions.GoViral.goViral.facebookGraphRequest("/me/objects/fitness.course", com.milkmangames.nativeextensions.GVHttpMethod.POST, arg1, APP_PERMISSIONS_PUBLISH).addRequestListener(this.onPostWalkResponse);
            return;
        }

        public function postVideo(arg1:Object):void
        {
            var p_postObject:Object;

            var loc1:*;
            p_postObject = arg1;
            this.postObject = p_postObject;
            debug.Debug.debug("postVideo: " + p_postObject.toString());
            if (!com.milkmangames.nativeextensions.GoViral.goViral.isFacebookMessageDialogAvailable()) 
            {
                return;
            }
            com.milkmangames.nativeextensions.GoViral.goViral.displaySocialComposerView(com.milkmangames.nativeextensions.GVSocialServiceType.FACEBOOK, this.postObject.title, null, p_postObject.videoUrl).addDialogListener(function (arg1:com.milkmangames.nativeextensions.events.GVShareEvent):void
            {
                var loc1:*=arg1.type;
                switch (loc1) 
                {
                    case com.milkmangames.nativeextensions.events.GVShareEvent.SOCIAL_COMPOSER_FINISHED:
                    {
                        dispatchEvent(new flash.events.Event(FBH_POST_DATA_SUCCESS));
                        break;
                    }
                    case com.milkmangames.nativeextensions.events.GVShareEvent.SOCIAL_COMPOSER_CANCELED:
                    {
                        dispatchEvent(new flash.events.Event(FBH_POST_DATA_ERROR));
                        break;
                    }
                }
                return;
            })
            return;
        }

        internal function onPostWalkResponse(arg1:com.milkmangames.nativeextensions.events.GVFacebookEvent):void
        {
            if (arg1.type != com.milkmangames.nativeextensions.events.GVFacebookEvent.FB_REQUEST_RESPONSE) 
            {
                debug.Debug.debug("Failed:" + arg1.errorMessage);
                dispatchEvent(new flash.events.Event(FBH_POST_DATA_ERROR));
            }
            else 
            {
                debug.Debug.debug("Posted:" + arg1.jsonData);
                if (arg1.data.hasOwnProperty("id")) 
                {
                    if (arg1.data.id > 0) 
                    {
                        this.postId = arg1.data.id;
                        debug.Debug.debug("id: " + arg1.data.id);
                        this.PostCourseExplicitlyShared(arg1.data.id);
                    }
                }
            }
            return;
        }

        protected function PostCourseExplicitlyShared(arg1:String):void
        {
            var loc1:*=new Object();
            loc1["course"] = arg1;
            this.postData(this.postType, loc1);
            return;
        }

        public static const FBTE_VIEWACTION_PREFIX:String="OPEN_VIEW_";

        public static const FBTE_MENU_TOPVALUES:String="MENU_TOPVALUES";

        public static const APP_BASE_PERMISSIONS:String="user_actions.fitness, public_profile";

        public static const APP_ID:String="1614345838874691";

        public static const APP_PERMISSIONS_READ:String="user_actions.fitness";

        public static const APP_PERMISSIONS_PUBLISH:String="publish_actions";

        public static const FBH_POST_DATA:String="FBH_POST_DATA";

        public static const FBH_POST_DATA_ERROR:String="FBH_POST_DATA_ERROR";

        public static const FBH_POST_DATA_SUCCESS:String="FBH_POST_DATA_SUCCESS";

        public static const FBTE_MENU_ABOUT:String="MENU_ABOUT";

        public static const FBTE_MENU_ACTIVITIES:String="MENU_ACTIVITIES";

        public static const FBTE_MENU_SETTINGS:String="MENU_SETTINGS";

        public static const FBTE_MENU_SETTINGS_ACTIVO:String="MENU_SETTINGS_ACTIVO";

        public static const FBTE_MENU_SETTINGS_PAIRING:String="MENU_SETTINGS_PAIRING";

        public static const FBTE_MENU_SETTINGS_PROFILE:String="MENU_SETTINGS_PROFILE";

        public static const FBTE_MENU_SETTINGS_TIMER:String="MENU_SETTINGS_TIMER";

        public static const FBTE_MENU_SIGMACLOUD:String="MENU_SIGMACLOUD";

        public static const FBTE_MENU_SETTINGS_GENERAL:String="MENU_SETTINGS_GENERAL";

        public static const FBTE_MENU_VIDEOS:String="MENU_VIDEOS";

        public var postId:String="";

        internal var facebookObject:Object;

        internal static var _instance:backend.oauth.FacebookGoViralHandler;

        internal var postObject:Object;

        internal var postType:String;
    }
}


//    class SigmaOAuth
package backend.oauth 
{
    import configCache.*;
    import core.*;
    import flash.events.*;
    import flash.net.*;
    import frontend.components.popup.oauth.*;
    import handler.*;
    import helper.*;
    import service.cloud.*;
    import starling.events.*;
    import utils.*;
    
    public class SigmaOAuth extends frontend.components.popup.oauth.CustomOAuth
    {
        public function SigmaOAuth(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            className = "SigmaOAuth";
            CLIENT_ID = service.cloud.CloudConfig.CLIENT_ID_ANDROID;
            CLIENT_SECRET = service.cloud.CloudConfig.CLIENT_SECRET_ANDROID;
            if (helper.Capabilities_helper.DEVICE == helper.Capabilities_helper.DEVICE_IOS) 
            {
                CLIENT_ID = service.cloud.CloudConfig.CLIENT_ID_IOS;
                CLIENT_SECRET = service.cloud.CloudConfig.CLIENT_SECRET_IOS;
            }
            REDIRECT_URI = "https://www.sigma-dc-control.com";
            SCOPE = null;
            STATE = null;
            LOGIN_URL = service.cloud.CloudConfig.BASE_URL + "/login";
            LOGOUT_URL = service.cloud.CloudConfig.BASE_URL + "/logout.do";
            LOGOUT_COMPLETE_URL = service.cloud.CloudConfig.BASE_URL + "/login?logout";
            AUTHORIZE_URL = service.cloud.CloudConfig.BASE_URL + "/oauth/authorize";
            TOKEN_URL = service.cloud.CloudConfig.BASE_URL + "/oauth/token";
            DEAUTHORIZE_URL = service.cloud.CloudConfig.BASE_URL + "/oauth/deauthorize";
            addEventListener(LOGGED_IN, handler.CloudHandler.getInstance().onLoggedIn);
            addEventListener(LOGGED_OUT, handler.CloudHandler.getInstance().onLoggedOut);
            return;
        }

        public override function get accessToken():String
        {
            return configCache.ConfigCache.getInstance().configCacheObject.accessToken();
        }

        public override function set accessToken(arg1:String):void
        {
            configCache.ConfigCache.getInstance().configCacheObject.setProperty(configCache.ConfigCacheObject.CLOUD_ACCESS_TOKEN, arg1);
            configCache.ConfigCache.getInstance().saveCache();
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

        protected override function checkAccessToken():Boolean
        {
            return false;
        }

        protected override function onWebViewLocationChange(arg1:starling.events.Event):void
        {
            super.onWebViewLocationChange(arg1);
            if (lastLocation != REGISTER_URL) 
            {
                if (lastLocation != HOME_URL) 
                {
                    if (lastLocation == ACCOUNT_RECOVER) 
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

        protected override function onWebViewComplete(arg1:starling.events.Event):void
        {
            if (lastLocation.indexOf("access_denied") == -1) 
            {
                if (loggedOut) 
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
            }
            else 
            {
                debug("autorisierung abgelehnt...");
                hideWebViewer();
                addEventListener(LOGGED_OUT_COMPLETE, this.onLogoutComplete);
                logout();
            }
            return;
        }

        internal function onLogoutComplete(arg1:flash.events.Event):void
        {
            removeEventListener(LOGGED_OUT_COMPLETE, this.onLogoutComplete);
            checkUserLogin();
            return;
        }

        public static function getInstance():backend.oauth.SigmaOAuth
        {
            if (_instance == null) 
            {
                _instance = new SigmaOAuth();
            }
            _instance.REGISTER_URL = service.cloud.CloudConfig.BASE_URL + "/portal/#/login?register&lang=" + core.MeasurementConfig.language;
            _instance.ACCOUNT_RECOVER = service.cloud.CloudConfig.BASE_URL + "/portal/#/login?forgot&lang=" + core.MeasurementConfig.language;
            _instance.HOME_URL = service.cloud.CloudConfig.BASE_URL + "/portal/";
            _instance.popupTitle = utils.LanguageManager.getString("CLOUDVIEW.OAUTH_TITLE");
            _instance.PARAMS = new Object();
            _instance.PARAMS.language = core.MeasurementConfig.language;
            return _instance;
        }

        internal static var _instance:backend.oauth.SigmaOAuth;
    }
}


//    class StravaOAuth
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


//    class TrainingPeaksOAuth
package backend.oauth 
{
    import flash.events.*;
    import flash.net.*;
    import frontend.components.popup.oauth.*;
    import helper.*;
    import starling.events.*;
    import utils.*;
    
    public class TrainingPeaksOAuth extends frontend.components.popup.oauth.CustomOAuth
    {
        public function TrainingPeaksOAuth(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            className = "TrainingPeaksOAuth";
            if (helper.Capabilities_helper.isAndroid()) 
            {
                CLIENT_ID = "sigmalinkandroid";
                CLIENT_SECRET = "ZpHCO28de7YLWUGxx3frVrr6MExdjnZb6Fs4EJuU8";
            }
            else 
            {
                CLIENT_ID = "sigmalinkios";
                CLIENT_SECRET = "Mc5dKk7MIfSPuKl9X8fDceorCYtPAaWCEpYzigfMSQ";
            }
            REDIRECT_URI = "https://www.sigma-dc-control.com";
            SCOPE = "file:write";
            STATE = null;
            LOGIN_URL = OAUTH_URL + "Account/LogOn";
            LOGOUT_URL = OAUTH_URL + "Account/LogOff";
            LOGOUT_COMPLETE_URL = OAUTH_URL;
            AUTHORIZE_URL = OAUTH_URL + "OAuth/Authorize";
            TOKEN_URL = OAUTH_URL + "oauth/token";
            UPLOAD_URL = API_URL + "v1/file";
            REGISTER_URL = _REGISTER_URL;
            ACCOUNT_RECOVER = _ACCOUNT_RECOVER;
            implicitGrant = false;
            useURLDecode = true;
            return;
        }

        public override function get requestHeader():flash.net.URLRequestHeader
        {
            return new flash.net.URLRequestHeader("Authorization", "Bearer " + accessToken);
        }

        protected override function onWebViewLocationChange(arg1:starling.events.Event):void
        {
            super.onWebViewLocationChange(arg1);
            if (lastLocation != REGISTER_URL) 
            {
                if (lastLocation == ACCOUNT_RECOVER) 
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

        protected override function onWebViewComplete(arg1:starling.events.Event):void
        {
            if (lastLocation.indexOf("access_denied") == -1) 
            {
                if (loggedOut) 
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
            }
            else 
            {
                debug("autorisierung abgelehnt...");
                hideWebViewer();
                addEventListener(LOGGED_OUT_COMPLETE, this.onLogoutComplete);
                logout();
            }
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
            return 200;
        }

        public override function getErrorMessage(arg1:int):String
        {
            return utils.LanguageManager.getString("SHARING_STATUS_GENERAL_ERROR");
        }

        public static function getInstance():backend.oauth.TrainingPeaksOAuth
        {
            if (_instance == null) 
            {
                _instance = new TrainingPeaksOAuth();
            }
            _instance.popupTitle = utils.LanguageManager.getString("CLOUDVIEW.OAUTH_TITLE");
            _instance.label = utils.LanguageManager.getString("APPSETTINGS.KONTEN.TRAININGPEAKS.TITLE");
            return _instance;
        }

        public static const API_URL:String="https://api.trainingpeaks.com/";

        public static const OAUTH_URL:String="https://oauth.trainingpeaks.com/";

        public static const UPLOAD_APPLICATION_NAME:String="SIGMA LINK";

        public static const _ACCOUNT_RECOVER:String="https://home.trainingpeaks.com/forgotpassword";

        public static const _REGISTER_URL:String="https://home.trainingpeaks.com/signup";

        public var setWorkoutPublic:Boolean=false;

        internal static var _instance:backend.oauth.TrainingPeaksOAuth;
    }
}


//    class TwitterOAuth
package backend.oauth 
{
    import configCache.*;
    import debug.*;
    import feathers.events.*;
    import flash.display.*;
    import flash.events.*;
    import flash.media.*;
    import flash.net.*;
    import flash.utils.*;
    import frontend.components.popup.oauth.*;
    import org.iotashan.oauth.*;
    import org.iotashan.utils.*;
    import starling.events.*;
    import utils.*;
    
    public class TwitterOAuth extends frontend.components.popup.oauth.CustomOAuth
    {
        public function TwitterOAuth(arg1:flash.events.IEventDispatcher=null)
        {
            this.signature = new org.iotashan.oauth.OAuthSignatureMethod_HMAC_SHA1();
            this.thisProfile = {};
            super(arg1);
            className = "TwitterOAuth";
            CLIENT_ID = "76YeNCeZj8FzPXinjYjliJX1V";
            CLIENT_SECRET = "eBClnBnYABEPSn6COKSbxSf3nj0fY37jQE6YaIQqBuCBqmaH5H";
            REDIRECT_URI = "http://www.sigma-dc-control.com";
            HOME_URL = "https://mobile.twitter.com/home";
            REGISTER_URL = "https://mobile.twitter.com/signup";
            return;
        }

        internal function onInitComplete(arg1:flash.events.Event):void
        {
            (arg1.currentTarget as flash.net.URLLoader).removeEventListener(flash.events.Event.COMPLETE, this.onInitComplete);
            this.requestToken = org.iotashan.utils.OAuthUtil.getTokenFromResponse(arg1.currentTarget.data);
            var loc1:*=!this.accessKey;
            var loc2:*=new flash.net.URLRequest(twitterAutTokenURL + this.requestToken.key + "&force_login=" + loc1);
            webView = new frontend.components.popup.oauth.CustomWebView();
            webView.addEventListener(starling.events.Event.COMPLETE, this.onWebViewComplete);
            webView.addEventListener(feathers.events.FeathersEventType.LOCATION_CHANGE, this.onWebViewLocationChange);
            webView.loadURL(loc2.url);
            if (pleaseWaitAdded) 
            {
                oauthPopUP.setWebView(webView);
            }
            return;
        }

        public function get accessKey():String
        {
            this._accessKey = configCache.ConfigCache.getInstance().getValue(className + "Key", null);
            return this._accessKey;
        }

        public function set accessKey(arg1:String):void
        {
            this._accessKey = arg1;
            configCache.ConfigCache.getInstance().setValue(className + "Key", arg1);
            return;
        }

        protected override function onWebViewLocationChange(arg1:starling.events.Event):void
        {
            super.onWebViewLocationChange(arg1);
            if (lastLocation != HOME_URL) 
            {
                if (lastLocation.indexOf(REGISTER_URL) == -1) 
                {
                    if (lastLocation.indexOf("denied") != -1) 
                    {
                        hideWebViewer();
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
            return;
        }

        public function get accessSecret():String
        {
            this._accessSecret = configCache.ConfigCache.getInstance().getValue(className + "Secret", null);
            return this._accessSecret;
        }

        public function set accessSecret(arg1:String):void
        {
            this._accessSecret = arg1;
            configCache.ConfigCache.getInstance().setValue(className + "Secret", arg1);
            return;
        }

        protected override function onWebViewComplete(arg1:starling.events.Event):void
        {
            var loc1:*=null;
            if (lastLocation.search(REDIRECT_URI) == -1) 
            {
                if (loggedOut) 
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
            }
            else if (lastLocation.search("oauth_verifier") >= 0) 
            {
                loc1 = lastLocation.substr(lastLocation.search("oauth_verifier") + 15);
                this.onPin(loc1);
            }
            else 
            {
                this.logout();
            }
            return;
        }

        public override function logout():void
        {
            this.accessKey = null;
            this.accessSecret = null;
            loggedOut = true;
            hideWebViewer();
            return;
        }

        internal function onPin(arg1:String):void
        {
            var loc1:*=new Object();
            loc1.oauth_verifier = arg1;
            this.accessRequest = new org.iotashan.oauth.OAuthRequest(org.iotashan.oauth.OAuthRequest.HTTP_MEHTOD_GET, twitterTokenURL, loc1, this.oAuthConsumer, this.requestToken);
            var loc2:*=new flash.net.URLRequest(this.accessRequest.buildRequest(new org.iotashan.oauth.OAuthSignatureMethod_HMAC_SHA1()));
            var loc3:*=new flash.net.URLLoader();
            loc3.addEventListener(flash.events.Event.COMPLETE, this.onAccessRequestComplete);
            loc3.load(loc2);
            return;
        }

        internal function onAccessRequestComplete(arg1:flash.events.Event):void
        {
            var loc1:*=org.iotashan.utils.OAuthUtil.getTokenFromResponse(arg1.currentTarget.data);
            this.accessKey = loc1.key;
            this.accessSecret = loc1.secret;
            loggedOut = false;
            hideWebViewer();
            return;
        }

        internal function verifyAccessToken():void
        {
            debug.Debug.debug("verify access token");
            var loc1:*=new org.iotashan.oauth.OAuthConsumer(CLIENT_ID, CLIENT_SECRET);
            var loc2:*=new org.iotashan.oauth.OAuthToken(this.accessKey, this.accessSecret);
            var loc3:*=new org.iotashan.oauth.OAuthRequest(flash.net.URLRequestMethod.GET, VERIFY_CREDENTIALS, null, loc1, loc2);
            var loc4:*=new flash.net.URLRequest(loc3.buildRequest(this.signature, org.iotashan.oauth.OAuthRequest.RESULT_TYPE_URL_STRING));
            loc4.method = flash.net.URLRequestMethod.GET;
            var loc5:*=new flash.net.URLLoader();
            loc5.addEventListener(flash.events.Event.COMPLETE, this.verifyAccessTokenHandler);
            loc5.addEventListener(flash.events.IOErrorEvent.IO_ERROR, this.onTwitterIOError);
            loc5.addEventListener(flash.events.HTTPStatusEvent.HTTP_STATUS, this.onTwitterHttpStatus);
            loc5.load(loc4);
            return;
        }

        protected function verifyAccessTokenHandler(arg1:flash.events.Event):void
        {
            debug.Debug.debug("Valid Access Data Exists");
            loggedOut = false;
            return;
        }

        internal function onTwitterIOError(arg1:flash.events.IOErrorEvent):void
        {
            debug.Debug.error("Tweet IOError!");
            return;
        }

        internal function onTwitterHttpStatus(arg1:flash.events.HTTPStatusEvent):void
        {
            debug.Debug.debug("Tweet HttpStatus!");
            return;
        }

        public override function getErrorMessage(arg1:int):String
        {
            var loc1:*=null;
            var loc2:*=arg1;
            switch (loc2) 
            {
                case 130:
                {
                    loc1 = utils.LanguageManager.getString("SHARING_STATUS_OVER_CAPACITY");
                    break;
                }
                case 187:
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

        public static function getInstance():backend.oauth.TwitterOAuth
        {
            if (_instance == null) 
            {
                _instance = new TwitterOAuth();
            }
            _instance.popupTitle = utils.LanguageManager.getString("CLOUDVIEW.OAUTH_TITLE");
            _instance.label = utils.LanguageManager.getString("APPSETTINGS.KONTEN.TWITTER.TITLE");
            return _instance;
        }

        protected override function debug(arg1:String=""):void
        {
            debug.Debug.debug("CLASS: " + className + "\t message: " + arg1 + "\n\t\tSTATUS - accessKey: " + this.accessKey + "\taccessSecret: " + this.accessSecret + "\tloggedOut: " + loggedOut + "\tlastLocation: " + lastLocation);
            return;
        }

        protected override function checkUserLogin():void
        {
            if (this.accessKey && this.accessSecret) 
            {
                this.verifyAccessToken();
            }
            else 
            {
                loggedOut = true;
                initWebView();
                showWebViewer(false);
                this.doOAuthCall(getStageWebView());
            }
            return;
        }

        protected override function doOAuthCall(arg1:flash.media.StageWebView):void
        {
            if (waitForCall) 
            {
                oauthPopUP.addPleaseWait();
                waitForCall = false;
                pleaseWaitAdded = true;
                reloadTimeout = flash.utils.setTimeout(this.doOAuthCall, 500, arg1);
                return;
            }
            this.oAuthConsumer = new org.iotashan.oauth.OAuthConsumer(CLIENT_ID, CLIENT_SECRET);
            var loc1:*=new org.iotashan.oauth.OAuthRequest(org.iotashan.oauth.OAuthRequest.HTTP_MEHTOD_GET, twitterRequestURL, null, this.oAuthConsumer);
            var loc2:*=new flash.net.URLRequest(loc1.buildRequest(new org.iotashan.oauth.OAuthSignatureMethod_HMAC_SHA1()));
            var loc3:*=new flash.net.URLLoader();
            loc3.addEventListener(flash.events.Event.COMPLETE, this.onInitComplete);
            loc3.load(loc2);
            return;
        }

        public static const TWITTER_POST_URL:String=TWITTER_API_BASE_URL + "/1.1/statuses/update.json";

        public static const TWITTER_UPLOAD_URL:String="https://upload.twitter.com/1.1/media/upload.json";

        public static const VERIFY_CREDENTIALS:String=TWITTER_API_BASE_URL + "/1.1/account/verify_credentials.json";

        public static const twitterAutTokenURL:String=TWITTER_API_BASE_URL + "/oauth/authorize?oauth_token=";

        public static const twitterAuthURL:String=TWITTER_API_BASE_URL + "/oauth/authorize";

        public static const twitterRequestURL:String=TWITTER_API_BASE_URL + "/oauth/request_token";

        public static const twitterTokenURL:String=TWITTER_API_BASE_URL + "/oauth/access_token";

        public static const TWITTER_API_BASE_URL:String="https://api.twitter.com";

        protected var _accessKey:String;

        protected var _accessSecret:String;

        protected var signature:org.iotashan.oauth.OAuthSignatureMethod_HMAC_SHA1;

        internal var accessRequest:org.iotashan.oauth.OAuthRequest;

        internal var cameraRoll:flash.media.CameraRoll;

        internal var dataSource:flash.utils.IDataInput;

        internal var imageLoader:flash.display.Loader;

        internal var mpLoaderInfo:flash.display.LoaderInfo;

        internal var oAuthConsumer:org.iotashan.oauth.OAuthConsumer;

        internal var requestToken:org.iotashan.oauth.OAuthToken;

        internal var thisProfile:Object;

        internal var webViewStartLocation:int;

        internal static var _instance:backend.oauth.TwitterOAuth;
    }
}


//    class TwoPeakOAuth
package backend.oauth 
{
    import com.adobe.protocols.oauth2.*;
    import com.adobe.protocols.oauth2.event.*;
    import debug.*;
    import flash.events.*;
    import flash.net.*;
    import frontend.components.popup.oauth.*;
    import helper.*;
    import org.as3commons.logging.setup.*;
    import starling.events.*;
    import utils.*;
    
    public class TwoPeakOAuth extends frontend.components.popup.oauth.CustomOAuth
    {
        public function TwoPeakOAuth(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            className = "TwoPeakOAuth";
            if (helper.Capabilities_helper.isAndroid()) 
            {
                CLIENT_ID = "sigma_link_android";
                CLIENT_SECRET = "3PyB3xnaxa9PJFoCbzF3UcdKQgeYyl";
            }
            else 
            {
                CLIENT_ID = "sigma_link_ios";
                CLIENT_SECRET = "AjZ7KkYOAtDpVRIQS2K9sTZYp9PF7P";
            }
            REDIRECT_URI = "https://www.sigma-dc-control.com";
            SCOPE = null;
            STATE = "mystate";
            LOGIN_URL = TWO_PEAK_URL + "person/login.php";
            LOGOUT_URL = TWO_PEAK_URL + "person/logout.php";
            LOGOUT_COMPLETE_URL = TWO_PEAK_URL;
            AUTHORIZE_URL = HTTPS_TWO_PEAK_URL + "oauth/authorize.php";
            TOKEN_URL = HTTPS_TWO_PEAK_URL + "oauth/token.php";
            DEAUTHORIZE_URL = TWO_PEAK_URL + "oauth/deauthorize";
            UPLOAD_URL = TWO_PEAK_URL + "api/v2/uploads";
            REGISTER_URL = TWO_PEAK_URL + "user/register.php";
            ACCOUNT_RECOVER = TWO_PEAK_URL + "person/password.php";
            SUPPORT_URL = "https://www.2peak.com/support/";
            return;
        }

        public override function get requestHeader():flash.net.URLRequestHeader
        {
            return new flash.net.URLRequestHeader("Authorization", "Bearer " + accessToken);
        }

        protected override function refresh_token():void
        {
            var loc1:*=new com.adobe.protocols.oauth2.OAuth2(AUTHORIZE_URL, TOKEN_URL, org.as3commons.logging.setup.LogSetupLevel.NONE);
            loc1.addEventListener(com.adobe.protocols.oauth2.event.RefreshAccessTokenEvent.TYPE, this.onRefreshAccessToken);
            loc1.refreshAccessToken(refreshToken, CLIENT_ID, CLIENT_SECRET);
            return;
        }

        protected override function onRefreshAccessToken(arg1:com.adobe.protocols.oauth2.event.RefreshAccessTokenEvent):void
        {
            var loc1:*=null;
            (arg1.currentTarget as com.adobe.protocols.oauth2.OAuth2).removeEventListener(com.adobe.protocols.oauth2.event.RefreshAccessTokenEvent.TYPE, this.onRefreshAccessToken);
            if (arg1.errorCode == null && arg1.errorMessage == null) 
            {
                if (arg1.accessToken) 
                {
                    accessToken = arg1.accessToken;
                    debug.Debug.debug("----------------------- " + className + ": ACCESS TOKEN REFRESHED !!!! ---------------------------");
                    loggedOut = false;
                    loc1 = new Date();
                    loc1.setSeconds(loc1.seconds + arg1.expiresIn);
                    setAccessTokenExpiresIn_timestamp(loc1.time);
                    return;
                }
            }
            else 
            {
                debug.Debug.error("----------------------- " + className + ": REFRESH ACCESS TOKEN ERROR !!!! ---------------------------");
                loggedOut = true;
                accessToken = null;
                checkUserLogin();
            }
            return;
        }

        protected override function onWebViewLocationChange(arg1:starling.events.Event):void
        {
            super.onWebViewLocationChange(arg1);
            if (lastLocation != REGISTER_URL) 
            {
                if (lastLocation != ACCOUNT_RECOVER) 
                {
                    if (lastLocation == SUPPORT_URL) 
                    {
                        hideWebViewer();
                        flash.net.navigateToURL(new flash.net.URLRequest(SUPPORT_URL), "_blank");
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

        protected override function onWebViewComplete(arg1:starling.events.Event):void
        {
            if (lastLocation.indexOf("access_denied") == -1) 
            {
                if (loggedOut) 
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
            }
            else 
            {
                debug("autorisierung abgelehnt...");
                hideWebViewer();
                addEventListener(LOGGED_OUT_COMPLETE, this.onLogoutComplete);
                logout();
            }
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
            return 200;
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

        public static function getInstance():backend.oauth.TwoPeakOAuth
        {
            if (_instance == null) 
            {
                _instance = new TwoPeakOAuth();
            }
            _instance.popupTitle = utils.LanguageManager.getString("CLOUDVIEW.OAUTH_TITLE");
            _instance.label = utils.LanguageManager.getString("APPSETTINGS.KONTEN.TWOPEAK.TITLE");
            return _instance;
        }

        public static const HTTPS_TWO_PEAK_URL:String="https://2peak.com/";

        public static const TWO_PEAK_URL:String="http://2peak.com/";

        internal static var SUPPORT_URL:String;

        internal static var _instance:backend.oauth.TwoPeakOAuth;
    }
}


//  package sharing
//    class ActivitySharing
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


//    class ShareableDocument
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


//    class SharingEvent
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


//  package utils
//    package container
//      class CustomListCollection
package backend.utils.container 
{
    import __AS3__.vec.*;
    import debug.*;
    import flash.events.*;
    import helper.*;
    import init.interfaces.*;
    
    public class CustomListCollection extends flash.events.EventDispatcher implements init.interfaces.IVectorList
    {
        public function CustomListCollection(arg1:*=null)
        {
            super();
            this.source = arg1;
            return;
        }

        public function get length():int
        {
            return this._source.length;
        }

        public function get source():*
        {
            return this._source;
        }

        public function set source(arg1:*):void
        {
            if (arg1 && !helper.Vector_helper.isVector(arg1)) 
            {
                throw new TypeError("The source of a VectorList must be a Vector");
            }
            this._source = arg1 ? arg1 : new Vector.<>();
            return;
        }

        public function addItem(arg1:Object):void
        {
            this._source.push(arg1);
            return;
        }

        public function contains(arg1:Object):Boolean
        {
            return this._source.indexOf(arg1) >= 0;
        }

        public function createVectorList(arg1:*=null):init.interfaces.IVectorList
        {
            this.source = arg1;
            return this;
        }

        public function getItemAt(arg1:int, arg2:int=0):Object
        {
            if (arg2 > 0) 
            {
                debug.Debug.warning("ACHTUNG! Parameter prefetch wird nicht berücksichtigt.");
            }
            return this._source[arg1];
        }

        public function toArray():Array
        {
            return helper.Array_helper.toArray(this._source);
        }

        internal var _source:*;
    }
}


//    package dataprovider
//      class AlarmModeDataProvider
package backend.utils.dataprovider 
{
    import feathers.data.*;
    import starling.events.*;
    import utils.dataprovider.*;
    
    public class AlarmModeDataProvider extends starling.events.EventDispatcher
    {
        public function AlarmModeDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonAlarmModeDataProvider.init();
            DATA_PROVIDER = new feathers.data.ListCollection(utils.dataprovider.CommonAlarmModeDataProvider.DATA_PROVIDER);
            return;
        }

        public static var DATA_PROVIDER:feathers.data.ListCollection;
    }
}


//      class AltitudeReferenceMarkDataProvider
package backend.utils.dataprovider 
{
    import feathers.data.*;
    import utils.dataprovider.*;
    
    public class AltitudeReferenceMarkDataProvider extends Object
    {
        public function AltitudeReferenceMarkDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonAltitudeReferenceDataProvider.init();
            DATA_PROVIDER = new feathers.data.ListCollection(utils.dataprovider.CommonAltitudeReferenceDataProvider.V_DATA_PROVIDER);
            return;
        }

        public static var DATA_PROVIDER:feathers.data.ListCollection;
    }
}


//      class AltitudeUnitDataProvider
package backend.utils.dataprovider 
{
    import feathers.data.*;
    import feathers.events.*;
    import starling.events.*;
    import utils.dataprovider.*;
    
    public class AltitudeUnitDataProvider extends starling.events.EventDispatcher
    {
        public function AltitudeUnitDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonAltitudeUnitDataProvider.init();
            DATA_PROVIDER_BC = new feathers.data.ListCollection(utils.dataprovider.CommonAltitudeUnitDataProvider.V_DATA_PROVIDER_BC);
            DATA_PROVIDER_SOFTWARE_SETTINGS = new feathers.data.ListCollection(utils.dataprovider.CommonAltitudeUnitDataProvider.V_DATA_PROVIDER_SOFTWARE_SETTINGS);
            return;
        }

        public static function get DATA_PROVIDER_SOFTWARE_SETTINGS():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.AltitudeUnitDataProvider._876350814DATA_PROVIDER_SOFTWARE_SETTINGS;
        }

        public static function set DATA_PROVIDER_SOFTWARE_SETTINGS(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.AltitudeUnitDataProvider._876350814DATA_PROVIDER_SOFTWARE_SETTINGS;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.AltitudeUnitDataProvider._876350814DATA_PROVIDER_SOFTWARE_SETTINGS = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER_SOFTWARE_SETTINGS", loc1, arg1, backend.utils.dataprovider.AltitudeUnitDataProvider);
                loc3 = backend.utils.dataprovider.AltitudeUnitDataProvider.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get staticEventDispatcher():starling.events.EventDispatcher
        {
            return _staticBindingEventDispatcher;
        }

        
        {
            _staticBindingEventDispatcher = new starling.events.EventDispatcher();
        }

        public static var DATA_PROVIDER_BC:feathers.data.ListCollection;

        internal static var _876350814DATA_PROVIDER_SOFTWARE_SETTINGS:feathers.data.ListCollection;

        internal static var _staticBindingEventDispatcher:starling.events.EventDispatcher;
    }
}


//      class AutoLapDataProvider
package backend.utils.dataprovider 
{
    import feathers.data.*;
    import starling.events.*;
    import utils.dataprovider.*;
    
    public class AutoLapDataProvider extends starling.events.EventDispatcher
    {
        public function AutoLapDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonAutoLapDataProvider.init();
            DATA_PROVIDER = new feathers.data.ListCollection(utils.dataprovider.CommonAutoLapDataProvider.V_DATA_PROVIDER);
            return;
        }

        public static function filter(arg1:Array):feathers.data.ListCollection
        {
            var loc6:*=null;
            var loc1:*=new feathers.data.ListCollection();
            var loc2:*=DATA_PROVIDER.length;
            var loc3:*=arg1.length;
            var loc4:*=0;
            var loc5:*=0;
            while (loc4 < loc2) 
            {
                loc6 = DATA_PROVIDER.getItemAt(loc4);
                if (loc6.hasOwnProperty("data")) 
                {
                    loc5 = 0;
                    while (loc5 < loc3) 
                    {
                        if (loc6.data == arg1[loc5]) 
                        {
                            loc1.push(loc6);
                        }
                        ++loc5;
                    }
                }
                ++loc4;
            }
            return loc1;
        }

        public static var DATA_PROVIDER:feathers.data.ListCollection;
    }
}


//      class AutoOffTimeDataProvider
package backend.utils.dataprovider 
{
    import feathers.data.*;
    import utils.dataprovider.*;
    
    public class AutoOffTimeDataProvider extends Object
    {
        public function AutoOffTimeDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonAutoOffTimeDataProvider.init();
            DATA_PROVIDER = new feathers.data.ListCollection(utils.dataprovider.CommonAutoOffTimeDataProvider.V_DATA_PROVIDER);
            return;
        }

        public static var DATA_PROVIDER:feathers.data.ListCollection;
    }
}


//      class BacklightLevelDataProvider
package backend.utils.dataprovider 
{
    import core.settings.interfaces.*;
    import feathers.data.*;
    
    public class BacklightLevelDataProvider extends Object
    {
        public function BacklightLevelDataProvider()
        {
            super();
            return;
        }

        public static function generateDataProvider(arg1:core.settings.interfaces.IBacklightLevel):feathers.data.ListCollection
        {
            var loc1:*=arg1.backlightLevelMin;
            var loc2:*=arg1.backlightLevelMax;
            var loc3:*=0;
            var loc4:*=new feathers.data.ListCollection();
            loc3 = loc1;
            while (loc3 <= loc2) 
            {
                loc4.addItem({"label":loc3 + "", "data":loc3});
                ++loc3;
            }
            return loc4;
        }
    }
}


//      class BacklightTimeDataProvider
package backend.utils.dataprovider 
{
    import core.general.*;
    import core.units.*;
    import feathers.data.*;
    import utils.dataprovider.*;
    
    public class BacklightTimeDataProvider extends Object
    {
        public function BacklightTimeDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonBacklightTimeDataProvider.init();
            DATA_PROVIDER_ROX100 = new feathers.data.ListCollection(utils.dataprovider.CommonBacklightTimeDataProvider.DATA_PROVIDER_ROX100);
            DATA_PROVIDER_ROX70_ROX110 = new feathers.data.ListCollection(utils.dataprovider.CommonBacklightTimeDataProvider.DATA_PROVIDER_ROX70_ROX110);
            return;
        }

        public static function getDataProviderByUnit(arg1:core.general.UnitType):feathers.data.ListCollection
        {
            var loc2:*=null;
            var loc1:*=core.units.UnitFactory.createUnitFromType(arg1);
            if (loc1 is core.units.UnitROX100) 
            {
                loc2 = DATA_PROVIDER_ROX100;
            }
            else if (loc1 is core.units.UnitROX70 || loc1 is core.units.UnitROX110) 
            {
                loc2 = DATA_PROVIDER_ROX70_ROX110;
            }
            return loc2;
        }

        public static var DATA_PROVIDER_ROX100:feathers.data.ListCollection;

        public static var DATA_PROVIDER_ROX70_ROX110:feathers.data.ListCollection;
    }
}


//      class BikeTypeDataProvider
package backend.utils.dataprovider 
{
    import feathers.data.*;
    import utils.dataprovider.*;
    
    public class BikeTypeDataProvider extends Object
    {
        public function BikeTypeDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonBikeTypeDataProvider.init();
            DATA_PROVIDER = new feathers.data.ListCollection(utils.dataprovider.CommonBikeTypeDataProvider.V_DATA_PROVIDER);
            return;
        }

        public static var DATA_PROVIDER:feathers.data.ListCollection;
    }
}


//      class ClockFormatDataProvider
package backend.utils.dataprovider 
{
    import feathers.data.*;
    import feathers.events.*;
    import starling.events.*;
    import utils.dataprovider.*;
    
    public class ClockFormatDataProvider extends starling.events.EventDispatcher
    {
        public function ClockFormatDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonClockFormatDataProvider.init();
            DATA_PROVIDER = new feathers.data.ListCollection(utils.dataprovider.CommonClockFormatDataProvider.V_DATA_PROVIDER);
            AM_PM_PROVIDER = new feathers.data.ListCollection(utils.dataprovider.CommonClockFormatDataProvider.V_AM_PM_PROVIDER);
            return;
        }

        public static function get AM_PM_PROVIDER():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.ClockFormatDataProvider._329019808AM_PM_PROVIDER;
        }

        public static function set AM_PM_PROVIDER(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.ClockFormatDataProvider._329019808AM_PM_PROVIDER;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.ClockFormatDataProvider._329019808AM_PM_PROVIDER = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "AM_PM_PROVIDER", loc1, arg1, backend.utils.dataprovider.ClockFormatDataProvider);
                loc3 = backend.utils.dataprovider.ClockFormatDataProvider.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get DATA_PROVIDER():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.ClockFormatDataProvider._700989158DATA_PROVIDER;
        }

        public static function set DATA_PROVIDER(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.ClockFormatDataProvider._700989158DATA_PROVIDER;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.ClockFormatDataProvider._700989158DATA_PROVIDER = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER", loc1, arg1, backend.utils.dataprovider.ClockFormatDataProvider);
                loc3 = backend.utils.dataprovider.ClockFormatDataProvider.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get staticEventDispatcher():starling.events.EventDispatcher
        {
            return _staticBindingEventDispatcher;
        }

        
        {
            _staticBindingEventDispatcher = new starling.events.EventDispatcher();
        }

        internal static var _329019808AM_PM_PROVIDER:feathers.data.ListCollection;

        internal static var _700989158DATA_PROVIDER:feathers.data.ListCollection;

        internal static var _staticBindingEventDispatcher:starling.events.EventDispatcher;
    }
}


//      class ContrastDataProvider
package backend.utils.dataprovider 
{
    import core.settings.interfaces.*;
    import feathers.data.*;
    
    public class ContrastDataProvider extends Object
    {
        public function ContrastDataProvider()
        {
            super();
            return;
        }

        public static function generateDataProvider(arg1:core.settings.interfaces.IContrast):feathers.data.ListCollection
        {
            var loc1:*=arg1.contrastMin;
            var loc2:*=arg1.contrastMax;
            var loc3:*=0;
            var loc4:*=new feathers.data.ListCollection();
            loc3 = loc1;
            while (loc3 <= loc2) 
            {
                loc4.addItem({"label":loc3 + "", "data":loc3});
                ++loc3;
            }
            return loc4;
        }
    }
}


//      class DataProviderUtil
package backend.utils.dataprovider 
{
    public class DataProviderUtil extends Object
    {
        public function DataProviderUtil()
        {
            super();
            return;
        }

        public static function initDataProviders():void
        {
            backend.utils.dataprovider.AltitudeReferenceMarkDataProvider.init();
            backend.utils.dataprovider.AltitudeUnitDataProvider.init();
            backend.utils.dataprovider.AlarmModeDataProvider.init();
            backend.utils.dataprovider.AutoLapDataProvider.init();
            backend.utils.dataprovider.AutoOffTimeDataProvider.init();
            backend.utils.dataprovider.BacklightTimeDataProvider.init();
            backend.utils.dataprovider.BikeTypeDataProvider.init();
            backend.utils.dataprovider.ClockFormatDataProvider.init();
            backend.utils.dataprovider.DateFormatDataProvider.init();
            backend.utils.dataprovider.DistanceUnitDataProvider.init();
            backend.utils.dataprovider.FavoritesPC2812DataProvider.init();
            backend.utils.dataprovider.FavoritesRoxDataProvider.init();
            backend.utils.dataprovider.FavoritesRox100DataProvider.init();
            backend.utils.dataprovider.FavoritesRox2010DataProvider.init();
            backend.utils.dataprovider.GenderDataProvider.init();
            backend.utils.dataprovider.GPSFormatDataProvider.init();
            backend.utils.dataprovider.HeightUnitDataProvider.init();
            backend.utils.dataprovider.LanguageDataProvider.init();
            backend.utils.dataprovider.MeasurementDataProvider.init();
            backend.utils.dataprovider.SamplingRateDataProvider.init();
            backend.utils.dataprovider.TemperatureUnitDataProvider.init();
            backend.utils.dataprovider.TimeZoneDataProvider.init();
            backend.utils.dataprovider.TireModeDataProvider.init();
            backend.utils.dataprovider.TrainingZoneDataProvider.init();
            backend.utils.dataprovider.WeightUnitDataProvider.init();
            backend.utils.dataprovider.WheelSizeSelectionModeDataProvider.init();
            backend.utils.dataprovider.RouteOptionsDataProvider.init();
            backend.utils.dataprovider.FuelConsumptionDataProvider.init();
            backend.utils.dataprovider.ETAModeDataProvider.init();
            backend.utils.dataprovider.TrackDirectionDataProvider.init();
            backend.utils.dataprovider.TrackDistanceDataProvider.init();
            return;
        }
    }
}


//      class DateFormatDataProvider
package backend.utils.dataprovider 
{
    import feathers.data.*;
    import feathers.events.*;
    import starling.events.*;
    import utils.dataprovider.*;
    
    public class DateFormatDataProvider extends starling.events.EventDispatcher
    {
        public function DateFormatDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonDateFormatDataProvider.init();
            DATA_PROVIDER = new feathers.data.ListCollection(utils.dataprovider.CommonDateFormatDataProvider.V_DATA_PROVIDER);
            return;
        }

        public static function get DATA_PROVIDER():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.DateFormatDataProvider._700989158DATA_PROVIDER;
        }

        public static function set DATA_PROVIDER(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.DateFormatDataProvider._700989158DATA_PROVIDER;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.DateFormatDataProvider._700989158DATA_PROVIDER = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER", loc1, arg1, backend.utils.dataprovider.DateFormatDataProvider);
                loc3 = backend.utils.dataprovider.DateFormatDataProvider.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get staticEventDispatcher():starling.events.EventDispatcher
        {
            return _staticBindingEventDispatcher;
        }

        
        {
            _staticBindingEventDispatcher = new starling.events.EventDispatcher();
        }

        internal static var _700989158DATA_PROVIDER:feathers.data.ListCollection;

        internal static var _staticBindingEventDispatcher:starling.events.EventDispatcher;
    }
}


//      class DistanceUnitDataProvider
package backend.utils.dataprovider 
{
    import feathers.data.*;
    import feathers.events.*;
    import starling.events.*;
    import utils.dataprovider.*;
    
    public class DistanceUnitDataProvider extends starling.events.EventDispatcher
    {
        public function DistanceUnitDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonDistanceUnitDataProvider.init();
            DATA_PROVIDER_BC = new feathers.data.ListCollection(utils.dataprovider.CommonDistanceUnitDataProvider.V_DATA_PROVIDER_BC);
            DATA_PROVIDER_SOFTWARE_SETTINGS = new feathers.data.ListCollection(utils.dataprovider.CommonDistanceUnitDataProvider.V_DATA_PROVIDER_SOFTWARE_SETTINGS);
            return;
        }

        public static function get DATA_PROVIDER_SOFTWARE_SETTINGS():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.DistanceUnitDataProvider._876350814DATA_PROVIDER_SOFTWARE_SETTINGS;
        }

        public static function set DATA_PROVIDER_SOFTWARE_SETTINGS(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.DistanceUnitDataProvider._876350814DATA_PROVIDER_SOFTWARE_SETTINGS;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.DistanceUnitDataProvider._876350814DATA_PROVIDER_SOFTWARE_SETTINGS = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER_SOFTWARE_SETTINGS", loc1, arg1, backend.utils.dataprovider.DistanceUnitDataProvider);
                loc3 = backend.utils.dataprovider.DistanceUnitDataProvider.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get staticEventDispatcher():starling.events.EventDispatcher
        {
            return _staticBindingEventDispatcher;
        }

        
        {
            _staticBindingEventDispatcher = new starling.events.EventDispatcher();
        }

        public static var DATA_PROVIDER_BC:feathers.data.ListCollection;

        internal static var _876350814DATA_PROVIDER_SOFTWARE_SETTINGS:feathers.data.ListCollection;

        internal static var _staticBindingEventDispatcher:starling.events.EventDispatcher;
    }
}


//      class ETAModeDataProvider
package backend.utils.dataprovider 
{
    import feathers.data.*;
    import utils.dataprovider.*;
    
    public class ETAModeDataProvider extends Object
    {
        public function ETAModeDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonETAModeDataProvider.init();
            DATA_PROVIDER = new feathers.data.ListCollection(utils.dataprovider.CommonETAModeDataProvider.DATA_PROVIDER);
            return;
        }

        public static var DATA_PROVIDER:feathers.data.ListCollection;
    }
}


//      class FavoritesPC2812DataProvider
package backend.utils.dataprovider 
{
    import feathers.data.*;
    import utils.dataprovider.*;
    
    public class FavoritesPC2812DataProvider extends utils.dataprovider.GraphicsnameConstants
    {
        public function FavoritesPC2812DataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonFavoritesPC2812DataProvider.init();
            DATA_PROVIDER_TRIP = new feathers.data.ListCollection(utils.dataprovider.CommonFavoritesPC2812DataProvider.V_DATA_PROVIDER_TRIP);
            return;
        }

        public static var DATA_PROVIDER_TRIP:feathers.data.ListCollection;
    }
}


//      class FavoritesRox100DataProvider
package backend.utils.dataprovider 
{
    import feathers.data.*;
    import utils.dataprovider.*;
    
    public class FavoritesRox100DataProvider extends Object
    {
        public function FavoritesRox100DataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonFavoritesRox100DataProvider.init();
            DATA_PROVIDER_TRIP = new feathers.data.ListCollection(utils.dataprovider.CommonFavoritesRox100DataProvider.V_DATA_PROVIDER_TRIP);
            DATA_PROVIDER_TRACK_ALTI = new feathers.data.ListCollection(utils.dataprovider.CommonFavoritesRox100DataProvider.V_DATA_PROVIDER_TRACK_ALTI);
            DATA_PROVIDER_LAP = new feathers.data.ListCollection(utils.dataprovider.CommonFavoritesRox100DataProvider.V_DATA_PROVIDER_LAP);
            DATA_PROVIDER_PAGE_COUNT = new feathers.data.ListCollection(utils.dataprovider.CommonFavoritesRox100DataProvider.V_DATA_PROVIDER_PAGE_COUNT);
            DATA_PROVIDER_CUSTOM = new feathers.data.ListCollection(utils.dataprovider.CommonFavoritesRox100DataProvider.V_DATA_PROVIDER_CUSTOM);
            return;
        }

        public static var DATA_PROVIDER_CUSTOM:feathers.data.ListCollection;

        public static var DATA_PROVIDER_LAP:feathers.data.ListCollection;

        public static var DATA_PROVIDER_PAGE_COUNT:feathers.data.ListCollection;

        public static var DATA_PROVIDER_TRACK_ALTI:feathers.data.ListCollection;

        public static var DATA_PROVIDER_TRIP:feathers.data.ListCollection;
    }
}


//      class FavoritesRox2010DataProvider
package backend.utils.dataprovider 
{
    import feathers.data.*;
    import utils.dataprovider.*;
    
    public class FavoritesRox2010DataProvider extends Object
    {
        public function FavoritesRox2010DataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonFavoritesRox2010DataProvider.init();
            DATA_PROVIDER = new feathers.data.ListCollection(utils.dataprovider.CommonFavoritesRox2010DataProvider.V_DATA_PROVIDER);
            DATA_PROVIDER_ROX8_1 = new feathers.data.ListCollection(utils.dataprovider.CommonFavoritesRox2010DataProvider.V_DATA_PROVIDER_ROX8_1);
            return;
        }

        public static var DATA_PROVIDER:feathers.data.ListCollection;

        public static var DATA_PROVIDER_ROX8_1:feathers.data.ListCollection;
    }
}


//      class FavoritesRoxDataProvider
package backend.utils.dataprovider 
{
    import feathers.data.*;
    import utils.dataprovider.*;
    
    public class FavoritesRoxDataProvider extends Object
    {
        public function FavoritesRoxDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonFavoritesRoxDataProvider.init();
            DATA_PROVIDER = new feathers.data.ListCollection(utils.dataprovider.CommonFavoritesRoxDataProvider.V_DATA_PROVIDER);
            return;
        }

        public static var DATA_PROVIDER:feathers.data.ListCollection;
    }
}


//      class FuelConsumptionDataProvider
package backend.utils.dataprovider 
{
    import feathers.data.*;
    import feathers.events.*;
    import starling.events.*;
    import utils.dataprovider.*;
    
    public class FuelConsumptionDataProvider extends starling.events.EventDispatcher
    {
        public function FuelConsumptionDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonFuelConsumptionDataProvider.init();
            DATA_PROVIDER = new feathers.data.ListCollection(utils.dataprovider.CommonFuelConsumptionDataProvider.V_DATA_PROVIDER);
            return;
        }

        public static function get DATA_PROVIDER():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.FuelConsumptionDataProvider._700989158DATA_PROVIDER;
        }

        public static function set DATA_PROVIDER(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.FuelConsumptionDataProvider._700989158DATA_PROVIDER;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.FuelConsumptionDataProvider._700989158DATA_PROVIDER = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER", loc1, arg1, backend.utils.dataprovider.FuelConsumptionDataProvider);
                loc3 = backend.utils.dataprovider.FuelConsumptionDataProvider.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get staticEventDispatcher():starling.events.EventDispatcher
        {
            return _staticBindingEventDispatcher;
        }

        
        {
            _staticBindingEventDispatcher = new starling.events.EventDispatcher();
        }

        internal static var _700989158DATA_PROVIDER:feathers.data.ListCollection;

        internal static var _staticBindingEventDispatcher:starling.events.EventDispatcher;
    }
}


//      class GPSFormatDataProvider
package backend.utils.dataprovider 
{
    import feathers.data.*;
    import feathers.events.*;
    import starling.events.*;
    import utils.dataprovider.*;
    
    public class GPSFormatDataProvider extends starling.events.EventDispatcher
    {
        public function GPSFormatDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonGPSFormatDataProvider.init();
            DATA_PROVIDER = new feathers.data.ListCollection(utils.dataprovider.CommonGPSFormatDataProvider.V_DATA_PROVIDER);
            return;
        }

        public static function get DATA_PROVIDER():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.GPSFormatDataProvider._700989158DATA_PROVIDER;
        }

        public static function set DATA_PROVIDER(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.GPSFormatDataProvider._700989158DATA_PROVIDER;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.GPSFormatDataProvider._700989158DATA_PROVIDER = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER", loc1, arg1, backend.utils.dataprovider.GPSFormatDataProvider);
                loc3 = backend.utils.dataprovider.GPSFormatDataProvider.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get staticEventDispatcher():starling.events.EventDispatcher
        {
            return _staticBindingEventDispatcher;
        }

        
        {
            _staticBindingEventDispatcher = new starling.events.EventDispatcher();
        }

        internal static var _700989158DATA_PROVIDER:feathers.data.ListCollection;

        internal static var _staticBindingEventDispatcher:starling.events.EventDispatcher;
    }
}


//      class GenderDataProvider
package backend.utils.dataprovider 
{
    import feathers.data.*;
    import utils.dataprovider.*;
    
    public class GenderDataProvider extends Object
    {
        public function GenderDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonGenderDataProvider.init();
            DATA_PROVIDER = new feathers.data.ListCollection(utils.dataprovider.CommonGenderDataProvider.V_DATA_PROVIDER);
            return;
        }

        public static var DATA_PROVIDER:feathers.data.ListCollection;
    }
}


//      class HeightUnitDataProvider
package backend.utils.dataprovider 
{
    import feathers.data.*;
    import feathers.events.*;
    import starling.events.*;
    import utils.dataprovider.*;
    
    public class HeightUnitDataProvider extends starling.events.EventDispatcher
    {
        public function HeightUnitDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonHeightUnitDataProvider.init();
            DATA_PROVIDER = new feathers.data.ListCollection(utils.dataprovider.CommonHeightUnitDataProvider.V_DATA_PROVIDER);
            return;
        }

        public static function get DATA_PROVIDER():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.HeightUnitDataProvider._700989158DATA_PROVIDER;
        }

        public static function set DATA_PROVIDER(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.HeightUnitDataProvider._700989158DATA_PROVIDER;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.HeightUnitDataProvider._700989158DATA_PROVIDER = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER", loc1, arg1, backend.utils.dataprovider.HeightUnitDataProvider);
                loc3 = backend.utils.dataprovider.HeightUnitDataProvider.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get staticEventDispatcher():starling.events.EventDispatcher
        {
            return _staticBindingEventDispatcher;
        }

        
        {
            _staticBindingEventDispatcher = new starling.events.EventDispatcher();
        }

        internal static var _700989158DATA_PROVIDER:feathers.data.ListCollection;

        internal static var _staticBindingEventDispatcher:starling.events.EventDispatcher;
    }
}


//      class LanguageDataProvider
package backend.utils.dataprovider 
{
    import core.general.*;
    import core.units.*;
    import feathers.data.*;
    import feathers.events.*;
    import starling.events.*;
    import utils.dataprovider.*;
    
    public class LanguageDataProvider extends starling.events.EventDispatcher
    {
        public function LanguageDataProvider()
        {
            super();
            return;
        }

        public static function get DATA_PROVIDER_ROX70_ROX110():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.LanguageDataProvider._192133113DATA_PROVIDER_ROX70_ROX110;
        }

        public static function set DATA_PROVIDER_ROX70_ROX110(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.LanguageDataProvider._192133113DATA_PROVIDER_ROX70_ROX110;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.LanguageDataProvider._192133113DATA_PROVIDER_ROX70_ROX110 = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER_ROX70_ROX110", loc1, arg1, backend.utils.dataprovider.LanguageDataProvider);
                loc3 = backend.utils.dataprovider.LanguageDataProvider.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get DATA_PROVIDER_SOFTWARESETTINGS_EN():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.LanguageDataProvider._102659941DATA_PROVIDER_SOFTWARESETTINGS_EN;
        }

        public static function set DATA_PROVIDER_SOFTWARESETTINGS_EN(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.LanguageDataProvider._102659941DATA_PROVIDER_SOFTWARESETTINGS_EN;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.LanguageDataProvider._102659941DATA_PROVIDER_SOFTWARESETTINGS_EN = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER_SOFTWARESETTINGS_EN", loc1, arg1, backend.utils.dataprovider.LanguageDataProvider);
                loc3 = backend.utils.dataprovider.LanguageDataProvider.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get DATA_PROVIDER_RC2011():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.LanguageDataProvider._745976312DATA_PROVIDER_RC2011;
        }

        public static function get DATA_PROVIDER_SOFTWARESETTINGS_JA_CH():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.LanguageDataProvider._329911345DATA_PROVIDER_SOFTWARESETTINGS_JA_CH;
        }

        public static function set DATA_PROVIDER_SOFTWARESETTINGS_JA_CH(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.LanguageDataProvider._329911345DATA_PROVIDER_SOFTWARESETTINGS_JA_CH;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.LanguageDataProvider._329911345DATA_PROVIDER_SOFTWARESETTINGS_JA_CH = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER_SOFTWARESETTINGS_JA_CH", loc1, arg1, backend.utils.dataprovider.LanguageDataProvider);
                loc3 = backend.utils.dataprovider.LanguageDataProvider.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get DATA_PROVIDER_TOPLINE2009():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.LanguageDataProvider._1500203241DATA_PROVIDER_TOPLINE2009;
        }

        public static function get DATA_PROVIDER_TOPLINE2012():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.LanguageDataProvider._1500203217DATA_PROVIDER_TOPLINE2012;
        }

        public static function set DATA_PROVIDER_TOPLINE2012(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.LanguageDataProvider._1500203217DATA_PROVIDER_TOPLINE2012;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.LanguageDataProvider._1500203217DATA_PROVIDER_TOPLINE2012 = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER_TOPLINE2012", loc1, arg1, backend.utils.dataprovider.LanguageDataProvider);
                loc3 = backend.utils.dataprovider.LanguageDataProvider.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get staticEventDispatcher():starling.events.EventDispatcher
        {
            return _staticBindingEventDispatcher;
        }

        
        {
            _staticBindingEventDispatcher = new starling.events.EventDispatcher();
        }

        public static function init():void
        {
            utils.dataprovider.CommonLanguageDataProvider.init();
            DATA_PROVIDER_BETA_TEST = new feathers.data.ListCollection(utils.dataprovider.CommonLanguageDataProvider.V_DATA_PROVIDER_BETA_TEST);
            DATA_PROVIDER_GPS10 = new feathers.data.ListCollection(utils.dataprovider.CommonLanguageDataProvider.V_DATA_PROVIDER_GPS10);
            DATA_PROVIDER_PC2814 = new feathers.data.ListCollection(utils.dataprovider.CommonLanguageDataProvider.V_DATA_PROVIDER_PC2814);
            DATA_PROVIDER_RC2011 = new feathers.data.ListCollection(utils.dataprovider.CommonLanguageDataProvider.V_DATA_PROVIDER_RC2011);
            DATA_PROVIDER_ROX100 = new feathers.data.ListCollection(utils.dataprovider.CommonLanguageDataProvider.V_DATA_PROVIDER_ROX100);
            DATA_PROVIDER_ROX2008 = new feathers.data.ListCollection(utils.dataprovider.CommonLanguageDataProvider.V_DATA_PROVIDER_ROX2008);
            DATA_PROVIDER_ROX2010 = new feathers.data.ListCollection(utils.dataprovider.CommonLanguageDataProvider.V_DATA_PROVIDER_ROX2010);
            DATA_PROVIDER_ROX70_ROX110 = new feathers.data.ListCollection(utils.dataprovider.CommonLanguageDataProvider.V_DATA_PROVIDER_ROX70_ROX110);
            DATA_PROVIDER_SOFTWARESETTINGS_EN = new feathers.data.ListCollection(utils.dataprovider.CommonLanguageDataProvider.V_DATA_PROVIDER_SOFTWARESETTINGS_EN);
            DATA_PROVIDER_SOFTWARESETTINGS_JA_CH = new feathers.data.ListCollection(utils.dataprovider.CommonLanguageDataProvider.V_DATA_PROVIDER_SOFTWARESETTINGS_JA_CH);
            DATA_PROVIDER_TOPLINE2009 = new feathers.data.ListCollection(utils.dataprovider.CommonLanguageDataProvider.V_DATA_PROVIDER_TOPLINE2009);
            DATA_PROVIDER_TOPLINE2012 = new feathers.data.ListCollection(utils.dataprovider.CommonLanguageDataProvider.V_DATA_PROVIDER_TOPLINE2012);
            return;
        }

        public static function getDataProviderByUnit(arg1:core.general.UnitType):feathers.data.ListCollection
        {
            var loc2:*=null;
            var loc1:*=core.units.UnitFactory.createUnitFromType(arg1);
            if (loc1 is core.units.UnitROX) 
            {
                loc2 = DATA_PROVIDER_ROX2008;
            }
            else if (loc1 is core.units.UnitROX2010) 
            {
                loc2 = DATA_PROVIDER_ROX2010;
            }
            else if (loc1 is core.units.UnitROX2010) 
            {
                loc2 = DATA_PROVIDER_TOPLINE2009;
            }
            else if (loc1 is core.units.UnitTopline2012 || loc1 is core.units.UnitTopline2016) 
            {
                loc2 = DATA_PROVIDER_TOPLINE2012;
            }
            else if (loc1 is core.units.UnitRC1411) 
            {
                loc2 = DATA_PROVIDER_RC2011;
            }
            else if (loc1 is core.units.UnitROX2012) 
            {
                loc2 = DATA_PROVIDER_TOPLINE2012;
            }
            else if (loc1 is core.units.UnitROX100) 
            {
                loc2 = DATA_PROVIDER_ROX100;
            }
            else if (loc1 is core.units.UnitPC2814) 
            {
                loc2 = DATA_PROVIDER_PC2814;
            }
            else if (loc1 is core.units.UnitROX70 || loc1 is core.units.UnitROX110) 
            {
                loc2 = DATA_PROVIDER_ROX70_ROX110;
            }
            else if (loc1 is core.units.UnitGps10) 
            {
                loc2 = DATA_PROVIDER_GPS10;
            }
            return loc2;
        }

        public static function get DATA_PROVIDER_BETA_TEST():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.LanguageDataProvider._1761242984DATA_PROVIDER_BETA_TEST;
        }

        public static function set DATA_PROVIDER_BETA_TEST(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.LanguageDataProvider._1761242984DATA_PROVIDER_BETA_TEST;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.LanguageDataProvider._1761242984DATA_PROVIDER_BETA_TEST = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER_BETA_TEST", loc1, arg1, backend.utils.dataprovider.LanguageDataProvider);
                loc3 = backend.utils.dataprovider.LanguageDataProvider.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get DATA_PROVIDER_GPS10():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.LanguageDataProvider._1557824112DATA_PROVIDER_GPS10;
        }

        public static function set DATA_PROVIDER_GPS10(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.LanguageDataProvider._1557824112DATA_PROVIDER_GPS10;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.LanguageDataProvider._1557824112DATA_PROVIDER_GPS10 = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER_GPS10", loc1, arg1, backend.utils.dataprovider.LanguageDataProvider);
                loc3 = backend.utils.dataprovider.LanguageDataProvider.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get DATA_PROVIDER_PC2814():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.LanguageDataProvider._803226923DATA_PROVIDER_PC2814;
        }

        public static function set DATA_PROVIDER_PC2814(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.LanguageDataProvider._803226923DATA_PROVIDER_PC2814;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.LanguageDataProvider._803226923DATA_PROVIDER_PC2814 = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER_PC2814", loc1, arg1, backend.utils.dataprovider.LanguageDataProvider);
                loc3 = backend.utils.dataprovider.LanguageDataProvider.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function set DATA_PROVIDER_TOPLINE2009(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.LanguageDataProvider._1500203241DATA_PROVIDER_TOPLINE2009;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.LanguageDataProvider._1500203241DATA_PROVIDER_TOPLINE2009 = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER_TOPLINE2009", loc1, arg1, backend.utils.dataprovider.LanguageDataProvider);
                loc3 = backend.utils.dataprovider.LanguageDataProvider.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function set DATA_PROVIDER_RC2011(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.LanguageDataProvider._745976312DATA_PROVIDER_RC2011;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.LanguageDataProvider._745976312DATA_PROVIDER_RC2011 = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER_RC2011", loc1, arg1, backend.utils.dataprovider.LanguageDataProvider);
                loc3 = backend.utils.dataprovider.LanguageDataProvider.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get DATA_PROVIDER_ROX100():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.LanguageDataProvider._733761073DATA_PROVIDER_ROX100;
        }

        public static function set DATA_PROVIDER_ROX100(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.LanguageDataProvider._733761073DATA_PROVIDER_ROX100;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.LanguageDataProvider._733761073DATA_PROVIDER_ROX100 = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER_ROX100", loc1, arg1, backend.utils.dataprovider.LanguageDataProvider);
                loc3 = backend.utils.dataprovider.LanguageDataProvider.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get DATA_PROVIDER_ROX2008():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.LanguageDataProvider._1271726936DATA_PROVIDER_ROX2008;
        }

        public static function set DATA_PROVIDER_ROX2008(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.LanguageDataProvider._1271726936DATA_PROVIDER_ROX2008;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.LanguageDataProvider._1271726936DATA_PROVIDER_ROX2008 = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER_ROX2008", loc1, arg1, backend.utils.dataprovider.LanguageDataProvider);
                loc3 = backend.utils.dataprovider.LanguageDataProvider.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get DATA_PROVIDER_ROX2010():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.LanguageDataProvider._1271726913DATA_PROVIDER_ROX2010;
        }

        public static function set DATA_PROVIDER_ROX2010(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.LanguageDataProvider._1271726913DATA_PROVIDER_ROX2010;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.LanguageDataProvider._1271726913DATA_PROVIDER_ROX2010 = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER_ROX2010", loc1, arg1, backend.utils.dataprovider.LanguageDataProvider);
                loc3 = backend.utils.dataprovider.LanguageDataProvider.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal static var _1761242984DATA_PROVIDER_BETA_TEST:feathers.data.ListCollection;

        internal static var _1557824112DATA_PROVIDER_GPS10:feathers.data.ListCollection;

        internal static var _803226923DATA_PROVIDER_PC2814:feathers.data.ListCollection;

        internal static var _745976312DATA_PROVIDER_RC2011:feathers.data.ListCollection;

        internal static var _1271726936DATA_PROVIDER_ROX2008:feathers.data.ListCollection;

        internal static var _1271726913DATA_PROVIDER_ROX2010:feathers.data.ListCollection;

        internal static var _192133113DATA_PROVIDER_ROX70_ROX110:feathers.data.ListCollection;

        internal static var _102659941DATA_PROVIDER_SOFTWARESETTINGS_EN:feathers.data.ListCollection;

        internal static var _329911345DATA_PROVIDER_SOFTWARESETTINGS_JA_CH:feathers.data.ListCollection;

        internal static var _1500203241DATA_PROVIDER_TOPLINE2009:feathers.data.ListCollection;

        internal static var _1500203217DATA_PROVIDER_TOPLINE2012:feathers.data.ListCollection;

        internal static var _733761073DATA_PROVIDER_ROX100:feathers.data.ListCollection;

        internal static var _staticBindingEventDispatcher:starling.events.EventDispatcher;
    }
}


//      class MeasurementDataProvider
package backend.utils.dataprovider 
{
    import core.general.*;
    import core.units.*;
    import feathers.data.*;
    import utils.dataprovider.*;
    
    public class MeasurementDataProvider extends Object
    {
        public function MeasurementDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonMeasurementDataProvider.init();
            DATA_PROVIDER_BC = new feathers.data.ListCollection(utils.dataprovider.CommonMeasurementDataProvider.V_DATA_PROVIDER_BC);
            DATA_PROVIDER_RC = new feathers.data.ListCollection(utils.dataprovider.CommonMeasurementDataProvider.V_DATA_PROVIDER_RC);
            return;
        }

        public static function getDataProviderByUnit(arg1:core.general.UnitType):feathers.data.ListCollection
        {
            var loc2:*=null;
            var loc1:*=core.units.UnitFactory.createUnitFromType(arg1);
            if (loc1 is core.units.UnitBikeComputer) 
            {
                loc2 = DATA_PROVIDER_BC;
            }
            else if (loc1 is core.units.UnitRunningComputer) 
            {
                loc2 = DATA_PROVIDER_RC;
            }
            return loc2;
        }

        public static var DATA_PROVIDER_BC:feathers.data.ListCollection;

        public static var DATA_PROVIDER_RC:feathers.data.ListCollection;
    }
}


//      class RouteOptionsDataProvider
package backend.utils.dataprovider 
{
    import feathers.data.*;
    import utils.dataprovider.*;
    
    public class RouteOptionsDataProvider extends Object
    {
        public function RouteOptionsDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonRouteOptionsDataProvider.init();
            _suitableDataProvider = new feathers.data.ListCollection(utils.dataprovider.CommonRouteOptionsDataProvider.V_SUITABLE_DATA_PROVIDER);
            _characteristicsDataProvider = new feathers.data.ListCollection(utils.dataprovider.CommonRouteOptionsDataProvider.V_CHARACTERISTIC_DATA_PROVIDER);
            _typeDataProvider = new feathers.data.ListCollection(utils.dataprovider.CommonRouteOptionsDataProvider.V_TYPE_DATA_PROVIDER);
            return;
        }

        public static function getSuitableDataProvider():feathers.data.ListCollection
        {
            return _suitableDataProvider;
        }

        public static function getCharacteristicsDataProvider():feathers.data.ListCollection
        {
            return _characteristicsDataProvider;
        }

        public static function getTypeDataProvider():feathers.data.ListCollection
        {
            return _typeDataProvider;
        }

        internal static var _characteristicsDataProvider:feathers.data.ListCollection;

        internal static var _suitableDataProvider:feathers.data.ListCollection;

        internal static var _typeDataProvider:feathers.data.ListCollection;
    }
}


//      class SamplingRateDataProvider
package backend.utils.dataprovider 
{
    import core.general.*;
    import core.units.*;
    import feathers.data.*;
    import feathers.events.*;
    import starling.events.*;
    import utils.dataprovider.*;
    
    public class SamplingRateDataProvider extends starling.events.EventDispatcher
    {
        public function SamplingRateDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonSamplingRateDataProvider.init();
            DATA_PROVIDER_BC2316 = new feathers.data.ListCollection(utils.dataprovider.CommonSamplingRateDataProvider.V_DATA_PROVIDER_BC2316);
            DATA_PROVIDER_PC2814 = new feathers.data.ListCollection(utils.dataprovider.CommonSamplingRateDataProvider.V_DATA_PROVIDER_PC2814);
            DATA_PROVIDER_RC1411 = new feathers.data.ListCollection(utils.dataprovider.CommonSamplingRateDataProvider.V_DATA_PROVIDER_RC1411);
            DATA_PROVIDER_ROX100 = new feathers.data.ListCollection(utils.dataprovider.CommonSamplingRateDataProvider.V_DATA_PROVIDER_ROX100);
            DATA_PROVIDER_ROX110 = new feathers.data.ListCollection(utils.dataprovider.CommonSamplingRateDataProvider.V_DATA_PROVIDER_ROX110);
            return;
        }

        public static function getDataProviderByUnit(arg1:core.general.UnitType):feathers.data.ListCollection
        {
            var loc2:*=null;
            var loc1:*=core.units.UnitFactory.createUnitFromType(arg1);
            if (loc1 is core.units.UnitBC2316STS) 
            {
                loc2 = DATA_PROVIDER_BC2316;
            }
            else if (loc1 is core.units.UnitPC2814) 
            {
                loc2 = DATA_PROVIDER_PC2814;
            }
            else if (loc1 is core.units.UnitRC1411) 
            {
                loc2 = DATA_PROVIDER_RC1411;
            }
            else if (loc1 is core.units.UnitROX100) 
            {
                loc2 = DATA_PROVIDER_ROX100;
            }
            else if (loc1 is core.units.UnitROX110) 
            {
                loc2 = DATA_PROVIDER_ROX110;
            }
            return loc2;
        }

        public static function get DATA_PROVIDER_BC2316():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.SamplingRateDataProvider._1204039840DATA_PROVIDER_BC2316;
        }

        public static function set DATA_PROVIDER_BC2316(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.SamplingRateDataProvider._1204039840DATA_PROVIDER_BC2316;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.SamplingRateDataProvider._1204039840DATA_PROVIDER_BC2316 = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER_BC2316", loc1, arg1, backend.utils.dataprovider.SamplingRateDataProvider);
                loc3 = backend.utils.dataprovider.SamplingRateDataProvider.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get DATA_PROVIDER_PC2814():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.SamplingRateDataProvider._803226923DATA_PROVIDER_PC2814;
        }

        public static function set DATA_PROVIDER_PC2814(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.SamplingRateDataProvider._803226923DATA_PROVIDER_PC2814;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.SamplingRateDataProvider._803226923DATA_PROVIDER_PC2814 = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER_PC2814", loc1, arg1, backend.utils.dataprovider.SamplingRateDataProvider);
                loc3 = backend.utils.dataprovider.SamplingRateDataProvider.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get DATA_PROVIDER_RC1411():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.SamplingRateDataProvider._746002259DATA_PROVIDER_RC1411;
        }

        public static function set DATA_PROVIDER_RC1411(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.SamplingRateDataProvider._746002259DATA_PROVIDER_RC1411;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.SamplingRateDataProvider._746002259DATA_PROVIDER_RC1411 = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER_RC1411", loc1, arg1, backend.utils.dataprovider.SamplingRateDataProvider);
                loc3 = backend.utils.dataprovider.SamplingRateDataProvider.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get DATA_PROVIDER_ROX100():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.SamplingRateDataProvider._733761073DATA_PROVIDER_ROX100;
        }

        public static function set DATA_PROVIDER_ROX100(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.SamplingRateDataProvider._733761073DATA_PROVIDER_ROX100;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.SamplingRateDataProvider._733761073DATA_PROVIDER_ROX100 = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER_ROX100", loc1, arg1, backend.utils.dataprovider.SamplingRateDataProvider);
                loc3 = backend.utils.dataprovider.SamplingRateDataProvider.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get DATA_PROVIDER_ROX110():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.SamplingRateDataProvider._733761042DATA_PROVIDER_ROX110;
        }

        public static function set DATA_PROVIDER_ROX110(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.SamplingRateDataProvider._733761042DATA_PROVIDER_ROX110;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.SamplingRateDataProvider._733761042DATA_PROVIDER_ROX110 = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER_ROX110", loc1, arg1, backend.utils.dataprovider.SamplingRateDataProvider);
                loc3 = backend.utils.dataprovider.SamplingRateDataProvider.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get staticEventDispatcher():starling.events.EventDispatcher
        {
            return _staticBindingEventDispatcher;
        }

        
        {
            _staticBindingEventDispatcher = new starling.events.EventDispatcher();
        }

        internal static var _1204039840DATA_PROVIDER_BC2316:feathers.data.ListCollection;

        internal static var _803226923DATA_PROVIDER_PC2814:feathers.data.ListCollection;

        internal static var _746002259DATA_PROVIDER_RC1411:feathers.data.ListCollection;

        internal static var _733761073DATA_PROVIDER_ROX100:feathers.data.ListCollection;

        internal static var _733761042DATA_PROVIDER_ROX110:feathers.data.ListCollection;

        internal static var _staticBindingEventDispatcher:starling.events.EventDispatcher;
    }
}


//      class TemperatureUnitDataProvider
package backend.utils.dataprovider 
{
    import feathers.data.*;
    import feathers.events.*;
    import starling.events.*;
    import utils.dataprovider.*;
    
    public class TemperatureUnitDataProvider extends starling.events.EventDispatcher
    {
        public function TemperatureUnitDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonTemperatureUnitDataProvider.init();
            DATA_PROVIDER_BC = new feathers.data.ListCollection(utils.dataprovider.CommonTemperatureUnitDataProvider.V_DATA_PROVIDER_BC);
            DATA_PROVIDER_SOFTWARE_SETTINGS = new feathers.data.ListCollection(utils.dataprovider.CommonTemperatureUnitDataProvider.V_DATA_PROVIDER_SOFTWARE_SETTINGS);
            return;
        }

        public static function get DATA_PROVIDER_SOFTWARE_SETTINGS():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.TemperatureUnitDataProvider._876350814DATA_PROVIDER_SOFTWARE_SETTINGS;
        }

        public static function set DATA_PROVIDER_SOFTWARE_SETTINGS(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.TemperatureUnitDataProvider._876350814DATA_PROVIDER_SOFTWARE_SETTINGS;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.TemperatureUnitDataProvider._876350814DATA_PROVIDER_SOFTWARE_SETTINGS = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER_SOFTWARE_SETTINGS", loc1, arg1, backend.utils.dataprovider.TemperatureUnitDataProvider);
                loc3 = backend.utils.dataprovider.TemperatureUnitDataProvider.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get staticEventDispatcher():starling.events.EventDispatcher
        {
            return _staticBindingEventDispatcher;
        }

        
        {
            _staticBindingEventDispatcher = new starling.events.EventDispatcher();
        }

        public static var DATA_PROVIDER_BC:feathers.data.ListCollection;

        internal static var _876350814DATA_PROVIDER_SOFTWARE_SETTINGS:feathers.data.ListCollection;

        internal static var _staticBindingEventDispatcher:starling.events.EventDispatcher;
    }
}


//      class TimeZoneDataProvider
package backend.utils.dataprovider 
{
    import core.settings.*;
    import feathers.data.*;
    import utils.dataprovider.*;
    
    public class TimeZoneDataProvider extends Object
    {
        public function TimeZoneDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonTimeZoneDataProvider.init();
            DATA_PROVIDER = new feathers.data.ListCollection(utils.dataprovider.CommonTimeZoneDataProvider.DATA_PROVIDER);
            DATA_PROVIDER_GPS_10 = new feathers.data.ListCollection(utils.dataprovider.CommonTimeZoneDataProvider.DATA_PROVIDER_GPS_10);
            return;
        }

        public static function getDataProvider(arg1:core.settings.Settings):feathers.data.ListCollection
        {
            if (arg1 is core.settings.SettingsGps10) 
            {
                return DATA_PROVIDER_GPS_10;
            }
            return DATA_PROVIDER;
        }

        public static var DATA_PROVIDER:feathers.data.ListCollection;

        public static var DATA_PROVIDER_GPS_10:feathers.data.ListCollection;
    }
}


//      class TireModeDataProvider
package backend.utils.dataprovider 
{
    import feathers.data.*;
    import utils.dataprovider.*;
    
    public class TireModeDataProvider extends Object
    {
        public function TireModeDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonTireModeDataProvider.init();
            DATA_PROVIDER = new feathers.data.ListCollection(utils.dataprovider.CommonTireModeDataProvider.V_DATA_PROVIDER);
            return;
        }

        public static var DATA_PROVIDER:feathers.data.ListCollection;
    }
}


//      class TrackDirectionDataProvider
package backend.utils.dataprovider 
{
    import feathers.data.*;
    import utils.dataprovider.*;
    
    public class TrackDirectionDataProvider extends Object
    {
        public function TrackDirectionDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonTrackDirectionDataProvider.init();
            DATA_PROVIDER = new feathers.data.ListCollection(utils.dataprovider.CommonTrackDirectionDataProvider.V_DATA_PROVIDER);
            return;
        }

        public static var DATA_PROVIDER:feathers.data.ListCollection;
    }
}


//      class TrackDistanceDataProvider
package backend.utils.dataprovider 
{
    import feathers.data.*;
    import utils.dataprovider.*;
    
    public class TrackDistanceDataProvider extends Object
    {
        public function TrackDistanceDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonTrackDistanceDataProvider.init();
            DATA_PROVIDER = new feathers.data.ListCollection(utils.dataprovider.CommonTrackDistanceDataProvider.V_DATA_PROVIDER);
            return;
        }

        public static var DATA_PROVIDER:feathers.data.ListCollection;
    }
}


//      class TrainingZoneDataProvider
package backend.utils.dataprovider 
{
    import feathers.data.*;
    import utils.dataprovider.*;
    
    public class TrainingZoneDataProvider extends Object
    {
        public function TrainingZoneDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonTrainingZoneDataProvider.init();
            DATA_PROVIDER_FIT_FAT = new feathers.data.ListCollection(utils.dataprovider.CommonTrainingZoneDataProvider.V_DATA_PROVIDER_FIT_FAT);
            DATA_PROVIDER_HEARTRATE_LIMITS = new feathers.data.ListCollection(utils.dataprovider.CommonTrainingZoneDataProvider.V_DATA_PROVIDER_HEARTRATE_LIMITS);
            DATA_PROVIDER_ROX100 = new feathers.data.ListCollection(utils.dataprovider.CommonTrainingZoneDataProvider.V_DATA_PROVIDER_ROX100);
            DATA_PROVIDER_RCMOVE = new feathers.data.ListCollection(utils.dataprovider.CommonTrainingZoneDataProvider.V_DATA_PROVIDER_RCMOVE);
            return;
        }

        public static var DATA_PROVIDER_FIT_FAT:feathers.data.ListCollection;

        public static var DATA_PROVIDER_HEARTRATE_LIMITS:feathers.data.ListCollection;

        public static var DATA_PROVIDER_RCMOVE:feathers.data.ListCollection;

        public static var DATA_PROVIDER_ROX100:feathers.data.ListCollection;
    }
}


//      class UnitsDataProvider
package backend.utils.dataprovider 
{
    import __AS3__.vec.*;
    import core.general.*;
    import feathers.data.*;
    import feathers.events.*;
    import starling.events.*;
    import utils.dataprovider.*;
    
    public class UnitsDataProvider extends starling.events.EventDispatcher
    {
        public function UnitsDataProvider()
        {
            super();
            return;
        }

        public static function init(arg1:Boolean=true, arg2:Boolean=true, arg3:Boolean=true):void
        {
            var loc2:*=0;
            var loc4:*=null;
            utils.dataprovider.CommonUnitsDataProvider.init();
            var loc1:*=new Vector.<utils.dataprovider.UnitItemRendererData>();
            var loc3:*=utils.dataprovider.CommonUnitsDataProvider.V_DATA_PROVIDER_ALL_DEVICES.length;
            loc2 = 0;
            while (loc2 < loc3) 
            {
                loc4 = utils.dataprovider.CommonUnitsDataProvider.V_DATA_PROVIDER_ALL_DEVICES[loc2];
                if (loc4.usb && arg1 || loc4.ble && arg2 || loc4.nfc && arg3) 
                {
                    loc1.push(loc4);
                }
                ++loc2;
            }
            DATA_PROVIDER_ALL_DEVICES = new feathers.data.ListCollection(loc1);
            return;
        }

        public static function isCommunicationAvailable(arg1:core.general.UnitType):Boolean
        {
            var loc3:*=null;
            var loc1:*=0;
            var loc2:*=DATA_PROVIDER_ALL_DEVICES.length;
            loc1 = 0;
            while (loc1 < loc2) 
            {
                loc3 = (DATA_PROVIDER_ALL_DEVICES.getItemAt(loc1) as utils.dataprovider.UnitItemRendererData).data as core.general.UnitType;
                if (loc3.equals(arg1)) 
                {
                    return true;
                }
                ++loc1;
            }
            return false;
        }

        public static function get DATA_PROVIDER_ALL_DEVICES():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.UnitsDataProvider._176373798DATA_PROVIDER_ALL_DEVICES;
        }

        public static function set DATA_PROVIDER_ALL_DEVICES(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.UnitsDataProvider._176373798DATA_PROVIDER_ALL_DEVICES;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.UnitsDataProvider._176373798DATA_PROVIDER_ALL_DEVICES = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER_ALL_DEVICES", loc1, arg1, backend.utils.dataprovider.UnitsDataProvider);
                loc3 = backend.utils.dataprovider.UnitsDataProvider.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get staticEventDispatcher():starling.events.EventDispatcher
        {
            return _staticBindingEventDispatcher;
        }

        
        {
            _staticBindingEventDispatcher = new starling.events.EventDispatcher();
        }

        internal static var _176373798DATA_PROVIDER_ALL_DEVICES:feathers.data.ListCollection;

        internal static var _staticBindingEventDispatcher:starling.events.EventDispatcher;
    }
}


//      class VolumeDataProvider
package backend.utils.dataprovider 
{
    import __AS3__.vec.*;
    import feathers.data.*;
    import starling.events.*;
    
    public class VolumeDataProvider extends starling.events.EventDispatcher
    {
        public function VolumeDataProvider()
        {
            super();
            return;
        }

        public static const DATA_PROVIDER:feathers.data.ListCollection=new feathers.data.ListCollection(Vector.<Object>([{"label":"1", "data":1}, {"label":"2", "data":2}, {"label":"3", "data":3}, {"label":"4", "data":4}, {"label":"5", "data":5}]));
    }
}


//      class WeightUnitDataProvider
package backend.utils.dataprovider 
{
    import feathers.data.*;
    import feathers.events.*;
    import starling.events.*;
    import utils.dataprovider.*;
    
    public class WeightUnitDataProvider extends starling.events.EventDispatcher
    {
        public function WeightUnitDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonWeightUnitDataProvider.init();
            DATA_PROVIDER = new feathers.data.ListCollection(utils.dataprovider.CommonWeightUnitDataProvider.V_DATA_PROVIDER);
            return;
        }

        public static function get DATA_PROVIDER():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.WeightUnitDataProvider._700989158DATA_PROVIDER;
        }

        public static function set DATA_PROVIDER(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.WeightUnitDataProvider._700989158DATA_PROVIDER;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.WeightUnitDataProvider._700989158DATA_PROVIDER = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER", loc1, arg1, backend.utils.dataprovider.WeightUnitDataProvider);
                loc3 = backend.utils.dataprovider.WeightUnitDataProvider.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get staticEventDispatcher():starling.events.EventDispatcher
        {
            return _staticBindingEventDispatcher;
        }

        
        {
            _staticBindingEventDispatcher = new starling.events.EventDispatcher();
        }

        internal static var _700989158DATA_PROVIDER:feathers.data.ListCollection;

        internal static var _staticBindingEventDispatcher:starling.events.EventDispatcher;
    }
}


//      class WheelSizeSelectionModeDataProvider
package backend.utils.dataprovider 
{
    import feathers.data.*;
    import utils.dataprovider.*;
    
    public class WheelSizeSelectionModeDataProvider extends Object
    {
        public function WheelSizeSelectionModeDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonWheelSizeSelectionModeDataProvider.init();
            DATA_PROVIDER = new feathers.data.ListCollection(utils.dataprovider.CommonWheelSizeSelectionModeDataProvider.V_DATA_PROVIDER);
            return;
        }

        public static var DATA_PROVIDER:feathers.data.ListCollection;
    }
}


//    package dbUtils
//      class DBUtil
package backend.utils.dbUtils 
{
    import backend.database.*;
    import com.logging.*;
    import database.*;
    import debug.*;
    import flash.data.*;
    import flash.errors.*;
    import flash.events.*;
    import flash.system.*;
    import flash.utils.*;
    import handler.*;
    import utils.*;
    import worker.*;
    
    public class DBUtil extends flash.events.EventDispatcher
    {
        public function DBUtil(arg1:flash.events.IEventDispatcher=null)
        {
            this._calls = new flash.utils.Dictionary();
            this._multiCalls = new flash.utils.Dictionary();
            super(arg1);
            return;
        }

        internal function get _ignoreWorkerTarget():Boolean
        {
            return !flash.system.Worker.current.isPrimordial;
        }

        public function call(arg1:String, arg2:String, arg3:Function, arg4:Function=null, arg5:flash.utils.ByteArray=null, arg6:Object=null, arg7:Object=null):void
        {
            this._workerTarget = this._ignoreWorkerTarget ? null : arg5;
            var loc1:*=new backend.utils.dbUtils.DBUtilObject();
            loc1.sqlMode = arg1;
            loc1.stmt = arg2;
            loc1.guid = utils.GUID.create();
            loc1.completeCallback = arg3;
            loc1.errorCallback = arg4;
            loc1.data = arg6;
            loc1.parameters = arg7;
            this._calls[loc1.guid] = loc1;
            if (this._workerTarget) 
            {
                this.sendToWorker([worker.DatabaseWorker.EXECUTE_LOAD_STMT, loc1]);
            }
            else 
            {
                new database.DatabaseTransaction(this.executeStatement, [loc1], arg1).commit();
            }
            return;
        }

        public function callMultiple(arg1:String, arg2:Array, arg3:Function, arg4:Function=null, arg5:flash.utils.ByteArray=null, arg6:Object=null):void
        {
            this._workerTarget = this._ignoreWorkerTarget ? null : arg5;
            var loc1:*=new backend.utils.dbUtils.DBUtilObject();
            loc1.sqlMode = arg1;
            loc1.stmts = arg2;
            loc1.guid = utils.GUID.create();
            loc1.completeCallback = arg3;
            loc1.errorCallback = arg4;
            loc1.data = arg6;
            this._calls[loc1.guid] = loc1;
            if (this._workerTarget) 
            {
                this.sendToWorker([worker.DatabaseWorker.EXECUTE_MULTIPLE_STMTS, loc1]);
            }
            else 
            {
                new database.DatabaseTransaction(this.executeMultipleStmts, [loc1], loc1.sqlMode).commit();
            }
            return;
        }

        public function startWorker(arg1:flash.utils.ByteArray):void
        {
            this._workerTarget = arg1;
            this.initWorker();
            return;
        }

        internal function initWorker():void
        {
            var loc1:*;
            if (workerInstance) 
            {
                return;
            }
            workerInstance = flash.system.WorkerDomain.current.createWorker(this._workerTarget, true);
            this._toBGChannel = flash.system.Worker.current.createMessageChannel(workerInstance);
            this._toMainChannel = workerInstance.createMessageChannel(flash.system.Worker.current);
            workerInstance.setSharedProperty(worker.DatabaseWorker.TO_BG_CHANNEL, this._toBGChannel);
            workerInstance.setSharedProperty(worker.DatabaseWorker.TO_MAIN_CHANNEL, this._toMainChannel);
            workerInstance.addEventListener(flash.events.Event.WORKER_STATE, this.onWorkerStateChanged);
            try 
            {
                workerInstance.start();
            }
            catch (error:Error)
            {
                debug.Debug.error("initWorker error: " + error.message);
                return;
            }
            this._toMainChannel.addEventListener(flash.events.Event.CHANNEL_MESSAGE, this.onWorkerChannelMessage);
            return;
        }

        internal function sendToWorker(arg1:Array):void
        {
            var p_array:Array;

            var loc1:*;
            p_array = arg1;
            if (!workerInstance) 
            {
                this.initWorker();
            }
            if (!this._workerInitComplete) 
            {
                flash.utils.setTimeout(this.sendToWorker, 100, p_array);
                return;
            }
            if (workerInstance.state != flash.system.WorkerState.RUNNING) 
            {
                flash.utils.setTimeout(this.sendToWorker, 100, p_array);
                return;
            }
            var loc2:*;
            var loc3:*=((loc2 = this)._currentWorkerRequests + 1);
            loc2._currentWorkerRequests = loc3;
            if (this._currentWorkerRequests > this._maxWorkerRequests) 
            {
                debug.Debug.debug("################# DESTROY WORKER ###############");
                this.destroyWorker();
                flash.utils.setTimeout(this.sendToWorker, 200, p_array);
                return;
            }
            try 
            {
                this._toBGChannel.send(p_array);
            }
            catch (error:Error)
            {
                debug.Debug.error("sendToWorker error: " + error.message);
            }
            return;
        }

        public function destroyWorker():void
        {
            this._currentWorkerRequests = 0;
            if (workerInstance) 
            {
                workerInstance.removeEventListener(flash.events.Event.WORKER_STATE, this.onWorkerStateChanged);
                workerInstance.terminate();
                workerInstance = null;
                this._workerInitComplete = false;
                this._toBGChannel.close();
                this._toMainChannel.close();
            }
            return;
        }

        internal function onWorkerStateChanged(arg1:flash.events.Event):void
        {
            if (arg1.target.state == flash.system.WorkerState.RUNNING) 
            {
                this._toBGChannel.send([worker.DatabaseWorker.INIT_DATABASE, backend.database.DatabaseDefinition.getInstance().currentDatabase.file.nativePath]);
                this._toBGChannel.send([worker.DatabaseWorker.INIT_ERROR_LOGGING, backend.database.DatabaseDefinition.getInstance().currentDatabase.workDirectory.nativePath]);
            }
            return;
        }

        internal function onWorkerChannelMessage(arg1:flash.events.Event):void
        {
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=null;
            var loc1:*=this._toMainChannel.receive();
            var loc2:*=loc1[0];
            var loc6:*=loc2;
            switch (loc6) 
            {
                case worker.DatabaseWorker.INIT_DATABASE:
                {
                    this._workerInitComplete = true;
                    break;
                }
                case worker.DatabaseWorker.EXECUTE_LOAD_STMT:
                case worker.DatabaseWorker.EXECUTE_MULTIPLE_STMTS:
                {
                    loc3 = backend.utils.dbUtils.DBUtilObject.fromObject(loc1[2]);
                    loc5 = this._calls[loc3.guid];
                    loc5.result = loc3.result;
                    delete this._calls[loc5.guid];
                    loc4 = new backend.utils.dbUtils.DBUtilEvent(backend.utils.dbUtils.DBUtilEvent.COMPLETE, loc5);
                    loc5.completeCallback(loc4);
                    break;
                }
                default:
                {
                    debug.Debug.warning("TODO: no handling for mode: " + loc2);
                }
            }
            return;
        }

        internal function executeStatement(arg1:backend.utils.dbUtils.DBUtilObject):void
        {
            var p_definitionObj:backend.utils.dbUtils.DBUtilObject;
            var stmt:database.DCSQLStatement;
            var prop:*;

            var loc1:*;
            stmt = null;
            prop = undefined;
            p_definitionObj = arg1;
            stmt = new database.DCSQLStatement();
            stmt.addEventListener(flash.events.SQLEvent.RESULT, this.onExecuteStatementComplete);
            stmt.addEventListener(flash.events.SQLErrorEvent.ERROR, this.onExecuteStatementError);
            stmt.data = p_definitionObj;
            stmt.text = p_definitionObj.stmt;
            if (p_definitionObj.parameters) 
            {
                var loc2:*=0;
                var loc3:*=p_definitionObj.parameters;
                for (prop in loc3) 
                {
                    stmt.parameters[prop] = p_definitionObj.parameters[prop];
                }
            }
            try 
            {
                stmt.execute();
            }
            catch (error:Error)
            {
                stmt.dispatchEvent(new flash.events.SQLErrorEvent(flash.events.SQLErrorEvent.ERROR, false, false, new flash.errors.SQLError("", stmt.text, error.message, error.errorID)));
            }
            return;
        }

        internal function onExecuteStatementComplete(arg1:flash.events.SQLEvent):void
        {
            var loc1:*=arg1.target as database.DCSQLStatement;
            loc1.removeEventListener(flash.events.SQLEvent.RESULT, this.onExecuteStatementComplete);
            loc1.removeEventListener(flash.events.SQLErrorEvent.ERROR, this.onExecuteStatementError);
            var loc2:*=loc1.data as backend.utils.dbUtils.DBUtilObject;
            var loc3:*=loc1.getResult();
            if (loc3) 
            {
                loc2.result = loc3.data;
            }
            loc1.dbHandler.commit();
            var loc4:*=this._calls[loc2.guid];
            loc4.result = loc2.result;
            if (loc3) 
            {
                loc4.lastInsertRowId = loc3.lastInsertRowID;
            }
            delete this._calls[loc4.guid];
            var loc5:*=new backend.utils.dbUtils.DBUtilEvent(backend.utils.dbUtils.DBUtilEvent.COMPLETE, loc4);
            loc4.completeCallback(loc5);
            com.logging.ErrorLogging.getInstance().removeTarget(loc1);
            return;
        }

        internal function onExecuteStatementError(arg1:flash.events.SQLErrorEvent):void
        {
            var loc1:*=arg1.target as database.DCSQLStatement;
            loc1.removeEventListener(flash.events.SQLEvent.RESULT, this.onExecuteStatementComplete);
            loc1.removeEventListener(flash.events.SQLErrorEvent.ERROR, this.onExecuteStatementError);
            var loc2:*=loc1.data as backend.utils.dbUtils.DBUtilObject;
            loc1.dbHandler.close();
            var loc3:*=this._calls[loc2.guid];
            loc3.result = loc2.result;
            delete this._calls[loc3.guid];
            var loc4:*=new backend.utils.dbUtils.DBUtilEvent(backend.utils.dbUtils.DBUtilEvent.ERROR, loc3);
            loc4.message = arg1.error.message;
            loc3.errorCallback(loc4);
            com.logging.ErrorLogging.getInstance().removeTarget(loc1);
            return;
        }

        internal function executeMultipleStmts(arg1:backend.utils.dbUtils.DBUtilObject):void
        {
            var p_definitionObj:backend.utils.dbUtils.DBUtilObject;
            var i:int;
            var len:int;
            var prop:*;
            var nextObj:backend.utils.dbUtils.DBUtilObject;
            var result:Array;
            var definition:backend.utils.dbUtils.DBUtilObject;
            var completeEvent:backend.utils.dbUtils.DBUtilEvent;
            var sqlResult:flash.data.SQLResult;
            var j:int;
            var jLen:int;
            var errorEvent:backend.utils.dbUtils.DBUtilEvent;

            var loc1:*;
            i = 0;
            prop = undefined;
            nextObj = null;
            sqlResult = null;
            j = 0;
            jLen = 0;
            errorEvent = null;
            p_definitionObj = arg1;
            len = p_definitionObj.stmts.length;
            result = new Array();
            i = 0;
            while (i < len) 
            {
                nextObj = p_definitionObj.stmts[i];
                if (p_definitionObj.preparedStmt == null) 
                {
                    p_definitionObj.preparedStmt = new database.DCSQLStatement();
                    p_definitionObj.preparedStmt.data = p_definitionObj;
                }
                p_definitionObj.preparedStmt.text = nextObj.stmt;
                p_definitionObj.preparedStmt.clearParameters();
                if (nextObj.parameters) 
                {
                    var loc2:*=0;
                    var loc3:*=nextObj.parameters;
                    for (prop in loc3) 
                    {
                        p_definitionObj.preparedStmt.parameters[prop] = nextObj.parameters[prop];
                    }
                }
                try 
                {
                    p_definitionObj.preparedStmt.execute();
                    sqlResult = p_definitionObj.preparedStmt.getResult();
                    if (sqlResult && sqlResult.data) 
                    {
                        jLen = sqlResult.data.length;
                        j = 0;
                        while (j < jLen) 
                        {
                            result.push(sqlResult.data[j]);
                            ++j;
                        }
                    }
                }
                catch (error:Error)
                {
                    p_definitionObj.preparedStmt.dispatchEvent(new flash.events.SQLErrorEvent(flash.events.SQLErrorEvent.ERROR, false, false, new flash.errors.SQLError("", p_definitionObj.preparedStmt.text, error.message, error.errorID)));
                    handler.AppDBHandler.getInstance().close();
                    errorEvent = new backend.utils.dbUtils.DBUtilEvent(backend.utils.dbUtils.DBUtilEvent.ERROR, p_definitionObj);
                    errorEvent.message = error.errorID + ": " + error.message;
                    p_definitionObj.errorCallback(errorEvent);
                    delete _calls[p_definitionObj.guid];
                    com.logging.ErrorLogging.getInstance().removeTarget(p_definitionObj.preparedStmt);
                    p_definitionObj = null;
                    return;
                }
                ++i;
            }
            p_definitionObj.result = result;
            handler.AppDBHandler.getInstance().commit();
            com.logging.ErrorLogging.getInstance().removeTarget(p_definitionObj.preparedStmt);
            definition = this._calls[p_definitionObj.guid];
            try 
            {
                if (definition) 
                {
                    definition.result = p_definitionObj.result;
                }
                delete this._calls[p_definitionObj.guid];
            }
            catch (e:Error)
            {
                debug.Debug.error("DBUtilObject existiert nicht mehr");
            }
            completeEvent = new backend.utils.dbUtils.DBUtilEvent(backend.utils.dbUtils.DBUtilEvent.COMPLETE, p_definitionObj);
            p_definitionObj.completeCallback(completeEvent);
            p_definitionObj = null;
            return;
        }

        public static function getInstance():backend.utils.dbUtils.DBUtil
        {
            if (!_instance) 
            {
                _instance = new DBUtil();
            }
            return _instance;
        }

        internal var _calls:flash.utils.Dictionary;

        internal var _currentWorkerRequests:int=0;

        internal var _maxWorkerRequests:int=100;

        internal var _multiCalls:flash.utils.Dictionary;

        internal var _toBGChannel:flash.system.MessageChannel;

        internal var _toMainChannel:flash.system.MessageChannel;

        internal var _workerInitComplete:Boolean=false;

        internal var _workerTarget:flash.utils.ByteArray;

        internal static var _instance:backend.utils.dbUtils.DBUtil;

        internal static var workerInstance:flash.system.Worker;
    }
}


//      class DBUtilEvent
package backend.utils.dbUtils 
{
    import flash.events.*;
    
    public class DBUtilEvent extends flash.events.Event
    {
        public function DBUtilEvent(arg1:String, arg2:backend.utils.dbUtils.DBUtilObject=null, arg3:Boolean=false, arg4:Boolean=false)
        {
            super(arg1, arg3, arg4);
            this.data = arg2;
            return;
        }

        public function getResult():Array
        {
            return this.data.result is Array ? this.data.result as Array : [];
        }

        public static const COMPLETE:String="executeCompleteEvent";

        public static const ERROR:String="executeErrorEvent";

        public var data:backend.utils.dbUtils.DBUtilObject;

        public var message:String;
    }
}


//      class DBUtilObject
package backend.utils.dbUtils 
{
    import database.*;
    import flash.utils.*;
    
    public class DBUtilObject extends Object
    {
        public function DBUtilObject(arg1:Object=null, arg2:Function=null, arg3:Function=null, arg4:flash.utils.ByteArray=null, arg5:Object=null)
        {
            super();
            this.data = arg1;
            this.completeCallback = arg2;
            this.errorCallback = arg3;
            this.workerTarget = arg4;
            this.parameters = arg5;
            return;
        }

        public static function fromObject(arg1:Object):backend.utils.dbUtils.DBUtilObject
        {
            var loc2:*=undefined;
            var loc1:*=new DBUtilObject();
            var loc3:*=0;
            var loc4:*=arg1;
            for (loc2 in loc4) 
            {
                if (loc2 == "preparedStmt") 
                {
                    loc1[loc2] = arg1[loc2] as database.DCSQLStatement;
                    continue;
                }
                loc1[loc2] = arg1[loc2];
            }
            return loc1;
        }

        public var completeCallback:Function;

        public var data:Object;

        public var errorCallback:Function;

        public var guid:String;

        public var lastInsertRowId:int;

        public var parameters:Object;

        public var preparedStmt:database.DCSQLStatement;

        public var result:Object;

        public var sqlMode:String;

        public var stmt:String;

        public var stmts:Array;

        public var workerTarget:flash.utils.ByteArray;
    }
}


//    package gps
//      class GeoLocationHelper
package backend.utils.gps 
{
    import debug.*;
    import flash.events.*;
    import flash.sensors.*;
    import flash.system.*;
    import starling.events.*;
    
    public class GeoLocationHelper extends starling.events.EventDispatcher
    {
        public function GeoLocationHelper()
        {
            super();
            return;
        }

        public function updateGPSPosition():void
        {
            if (!flash.sensors.Geolocation.isSupported && !flash.system.Capabilities.isDebugger) 
            {
                dispatchEventWith(GPS_DISABLED);
                return;
            }
            if (!this.geo) 
            {
                this.geo = new flash.sensors.Geolocation();
                this.geo.addEventListener(flash.events.StatusEvent.STATUS, this.onGeoStatusChanged);
            }
            this.validateGeoStatus();
            return;
        }

        internal function onGeoStatusChanged(arg1:flash.events.StatusEvent):void
        {
            this.validateGeoStatus();
            return;
        }

        internal function validateGeoStatus():void
        {
            debug.Debug.debug("validateGeoStatus...");
            if (this.geo.muted) 
            {
                dispatchEventWith(GPS_DISABLED);
            }
            else 
            {
                dispatchEventWith(GPS_ENABLED);
                this.geo.addEventListener(flash.events.GeolocationEvent.UPDATE, this.geoUpdateHandler);
            }
            return;
        }

        protected function geoUpdateHandler(arg1:flash.events.GeolocationEvent):void
        {
            this.currentLon = arg1.longitude;
            this.currentLat = arg1.latitude;
            this.geo.removeEventListener(flash.events.GeolocationEvent.UPDATE, this.geoUpdateHandler);
            this.geo.removeEventListener(flash.events.StatusEvent.STATUS, this.onGeoStatusChanged);
            this.geo = null;
            dispatchEventWith(LOCATION_CHANGED);
            return;
        }

        public static function getInstance():backend.utils.gps.GeoLocationHelper
        {
            if (!_instance) 
            {
                _instance = new GeoLocationHelper();
            }
            return _instance;
        }

        public static const GPS_DISABLED:String="gpsDisabledEvent";

        public static const GPS_ENABLED:String="gpsEnabledEvent";

        public static const LOCATION_CHANGED:String="locationChangedEvent";

        public var currentLat:Number=49.45981581;

        public var currentLon:Number=8.16105242;

        public var geo:flash.sensors.Geolocation;

        internal static var _instance:backend.utils.gps.GeoLocationHelper;
    }
}


//    class DataUtils
package backend.utils 
{
    import __AS3__.vec.*;
    import backend.utils.dataprovider.*;
    import configCache.*;
    import core.*;
    import core.general.*;
    import feathers.events.*;
    import frontend.formatter.*;
    import starling.events.*;
    import utils.*;
    import utils.converter.*;
    import utils.format.*;
    import utils.formatter.*;
    import utils.interfaces.*;
    
    public class DataUtils extends starling.events.EventDispatcher
    {
        public function DataUtils()
        {
            super();
            return;
        }

        
        {
            speedTimeConverter = new utils.converter.SpeedTimeConverter();
            _staticBindingEventDispatcher = new starling.events.EventDispatcher();
        }

        public static function set unitStringFuelEconomy(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.DataUtils._277633613unitStringFuelEconomy;
            if (loc1 !== arg1) 
            {
                backend.utils.DataUtils._277633613unitStringFuelEconomy = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "unitStringFuelEconomy", loc1, arg1, backend.utils.DataUtils);
                loc3 = backend.utils.DataUtils.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function init():void
        {
            backend.utils.dataprovider.DataProviderUtil.initDataProviders();
            updateMeasurementConfig();
            unitStringPercent = utils.LanguageManager.getString("UNIT_PERCENT");
            unitStringTimeHours = utils.LanguageManager.getString("UNIT_HOUR");
            unitStringDistance = utils.LanguageManager.getString("UNIT_KM");
            unitStringSpeed = utils.LanguageManager.getString("UNIT_KMH");
            distanceFormatter = new frontend.formatter.DistanceFormatter();
            if (core.MeasurementConfig.distanceFormat != utils.format.DistanceFormat.KILOMETER) 
            {
                if (core.MeasurementConfig.distanceFormat == utils.format.DistanceFormat.MILE) 
                {
                    unitStringDistance = utils.LanguageManager.getString("UNIT_MI");
                    distanceFormatter.formatString = "K.MM";
                }
            }
            else 
            {
                unitStringDistance = utils.LanguageManager.getString("UNIT_KM");
                distanceFormatter.formatString = "K,MM";
            }
            altitudeLabel = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_ALTITUDE");
            altitudeFormatter = new frontend.formatter.AltitudeFormatter();
            if (core.MeasurementConfig.altitudeFormat != utils.format.AltitudeFormat.METER) 
            {
                if (core.MeasurementConfig.altitudeFormat == utils.format.AltitudeFormat.FEET) 
                {
                    unitStringAltitude = utils.LanguageManager.getString("UNIT_FT");
                    altitudeFormatter.formatString = "M";
                    (altitudeFormatter as frontend.formatter.AltitudeFormatter).outputFeed = true;
                    unitStringRiseRate = utils.LanguageManager.getString("UNIT_FT_MIN");
                }
            }
            else 
            {
                unitStringAltitude = utils.LanguageManager.getString("UNIT_M");
                altitudeFormatter.formatString = "M";
                (altitudeFormatter as frontend.formatter.AltitudeFormatter).outputFeed = false;
                unitStringRiseRate = utils.LanguageManager.getString("UNIT_M_MIN");
            }
            fuelEconomyFormatter = new frontend.formatter.FuelEconomyFormatter();
            fuelEconomyConverter = new utils.converter.FuelEconomyConverter();
            fuelEconomyConverter.inputFormat = utils.format.FuelEconomyFormat.LITER;
            fuelEconomyConverter.outputFormat = core.MeasurementConfig.fuelEconomyFormat;
            if (core.MeasurementConfig.fuelEconomyFormat != utils.format.FuelEconomyFormat.LITER) 
            {
                fuelEconomyFormatter.decimalSeparator = ".";
                unitStringFuelEconomy = utils.LanguageManager.getString("UNIT_GALLON");
            }
            else 
            {
                fuelEconomyFormatter.decimalSeparator = ",";
                unitStringFuelEconomy = utils.LanguageManager.getString("UNIT_LITER");
            }
            fuelEconomyLabel = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_FUEL_ECONOMY");
            altitudeConverter = new utils.converter.AltitudeConverter();
            altitudeConverter.inputFormat = utils.format.AltitudeFormat.MILLIMETER;
            altitudeConverter.outputFormat = core.MeasurementConfig.altitudeFormat;
            caloriesLabel = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_CALORIES");
            caloriesFormatter = new frontend.formatter.CaloriesFormatter();
            unitStringCalories = utils.LanguageManager.getString("UNIT_CALORIE");
            cadenceLabel = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_CADENCE");
            cadenceFormatter = new frontend.formatter.CadenceFormatter();
            unitStringCadence = utils.LanguageManager.getString("UNIT_RPM");
            distanceLabel = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_DISTANCE");
            distanceConverter = new utils.converter.DistanceConverter();
            distanceConverter.inputFormat = utils.format.DistanceFormat.METER;
            distanceConverter.outputFormat = core.MeasurementConfig.distanceFormat;
            distancePlusMinusLabel = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_DISTANCE_UP_DOWN");
            expansionLabel = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_EXPANSION");
            expansionFormatter = new frontend.formatter.ExpansionFormatter();
            if (core.MeasurementConfig.altitudeFormat != utils.format.AltitudeFormat.METER) 
            {
                unitStringExpansion = utils.LanguageManager.getString("UNIT_FTR");
                expansionFormatter.decimalSeparator = ".";
            }
            else 
            {
                unitStringExpansion = utils.LanguageManager.getString("UNIT_MR");
                expansionFormatter.decimalSeparator = ",";
            }
            heartrateLabel = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_HEARTRATE");
            heartrateFormatter = new frontend.formatter.HeartrateFormatter();
            inclineLabel = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_INCLINE");
            unitStringIncline = unitStringPercent;
            inclineFormatter = new frontend.formatter.InclineFormatter();
            powerLabel = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_POWER");
            powerFormatter = new frontend.formatter.PowerFormatter();
            unitStringPower = utils.LanguageManager.getString("UNIT_WATT");
            powerPerKGLabel = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_WATT_PER_KG");
            powerPerKGFormatter = new frontend.formatter.PowerPerKGFormatter();
            if (core.MeasurementConfig.weightFormat != core.general.WeightUnit.KG) 
            {
                unitStringPowerPerKg = utils.LanguageManager.getString("UNIT_WATT_PER_LB");
                powerPerKGFormatter.decimalSeparator = ".";
            }
            else 
            {
                unitStringPowerPerKg = utils.LanguageManager.getString("UNIT_WATT_PER_KG");
                powerPerKGFormatter.decimalSeparator = ",";
            }
            powerPerKGConverter = new utils.converter.PowerPerWeightConverter();
            powerPerKGConverter.inputFormat = core.general.WeightUnit.KG;
            powerPerKGConverter.outputFormat = core.MeasurementConfig.weightFormat;
            unitStringKj = utils.LanguageManager.getString("UNIT_KJ");
            riseRateLabel = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_RISERATE");
            speedLabel = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_SPEED");
            speedFormatter = new frontend.formatter.SpeedFormatter();
            speedConverter = new utils.converter.SpeedConverter();
            speedConverter.inputFormat = utils.format.SpeedFormat.METER_PER_SECOND;
            speedConverter.outputFormat = core.MeasurementConfig.speedFormat;
            if (core.MeasurementConfig.distanceFormat != utils.format.DistanceFormat.KILOMETER) 
            {
                if (core.MeasurementConfig.distanceFormat == utils.format.DistanceFormat.MILE) 
                {
                    unitStringSpeed = utils.LanguageManager.getString("UNIT_MPH");
                    unitStringSpeedTime = utils.LanguageManager.getString("UNIT_MIN_PER_MILE");
                    speedFormatter.decimalSeparator = ".";
                }
            }
            else 
            {
                unitStringSpeed = utils.LanguageManager.getString("UNIT_KMH");
                unitStringSpeedTime = utils.LanguageManager.getString("UNIT_MIN_PER_KM");
                speedFormatter.decimalSeparator = ",";
            }
            temperatureLabel = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_TEMPERATURE");
            temperatureFormatter = new frontend.formatter.TemperatureFormatter();
            if (core.MeasurementConfig.temperatureFormat != utils.format.TemperatureFormat.CELSIUS) 
            {
                if (core.MeasurementConfig.temperatureFormat == utils.format.TemperatureFormat.FAHRENHEIT) 
                {
                    unitStringTemperature = utils.LanguageManager.getString("UNIT_FAHRENHEIT");
                    temperatureFormatter.formatString = "B.A";
                    temperatureFormatter.fractionalDigits = 0;
                }
            }
            else 
            {
                unitStringTemperature = utils.LanguageManager.getString("UNIT_CELSIUS");
                temperatureFormatter.formatString = "B,A";
                temperatureFormatter.fractionalDigits = 1;
            }
            timeFormatter = new frontend.formatter.TimeFormatter();
            timeFormatterHHMM = new frontend.formatter.TimeFormatter();
            timeFormatterHHMM.inputType = frontend.formatter.TimeFormatter.INPUT_HUNDREDTHSSECONDS;
            timeFormatterHHMM.formatString = "HH:MM";
            timeFormatterHHMMSST = new frontend.formatter.TimeFormatter();
            timeFormatterHHMMSST.inputType = frontend.formatter.TimeFormatter.INPUT_HUNDREDTHSSECONDS;
            timeFormatterHHMMSST.formatString = "HH:MM:SS.t";
            unitStringHeartrate = utils.LanguageManager.getString("UNIT_BPM");
            dateFormatter = new utils.formatter.DateFormatterMx();
            if (core.MeasurementConfig.dateFormat != utils.format.DateFormat.EUROPEAN) 
            {
                dateFormatter.formatString = utils.formatter.DateFormatterMx.US_FORMAT;
            }
            else 
            {
                dateFormatter.formatString = utils.formatter.DateFormatterMx.EU_FORMAT;
            }
            dateTimeFormatter = new utils.formatter.DateFormatterMx();
            if (core.MeasurementConfig.clockFormat != utils.format.ClockFormat.CLOCK_12H) 
            {
                dateTimeFormatter.formatString = utils.formatter.DateFormatterMx.CLOCK_24;
                clockFormat = utils.formatter.DateFormatterMx.CLOCK_24;
            }
            else 
            {
                dateTimeFormatter.formatString = utils.formatter.DateFormatterMx.CLOCK_12;
                clockFormat = utils.formatter.DateFormatterMx.CLOCK_12;
            }
            countdownFormatter = new frontend.formatter.TimeFormatter();
            countdownFormatter.inputType = frontend.formatter.TimeFormatter.INPUT_HUNDREDTHSSECONDS;
            countdownFormatter.formatString = "H:MM:SS.t";
            autoLapTimeFormatter = new frontend.formatter.TimeFormatter();
            autoLapTimeFormatter.inputType = frontend.formatter.TimeFormatter.INPUT_HUNDREDTHSSECONDS;
            autoLapTimeFormatter.formatString = "H:MM:SS";
            timeFormatter_MM_SS = new frontend.formatter.TimeFormatter();
            timeFormatter_MM_SS.inputType = frontend.formatter.TimeFormatter.INPUT_HUNDREDTHSSECONDS;
            timeFormatter_MM_SS.formatString = "MM:SS";
            wheelSizeFormatter = new frontend.formatter.WheelSizeFormatter();
            weightConverter = new utils.converter.WeightConverter();
            weightConverter.inputFormat = core.general.WeightUnit.G;
            weightConverter.outputFormat = core.MeasurementConfig.weightFormat;
            weightFormatter = new frontend.formatter.NumberFormatter();
            weightFormatter.decimalSeparator = weightConverter.outputFormat != core.general.WeightUnit.KG ? "." : ",";
            weightFormatter.fractionalDigits = 1;
            if (weightConverter.outputFormat != core.general.WeightUnit.KG) 
            {
                weightFormatter.decimalSeparator = ".";
                unitStringWeight = utils.LanguageManager.getString("UNIT_LB");
            }
            else 
            {
                weightFormatter.decimalSeparator = ",";
                unitStringWeight = utils.LanguageManager.getString("UNIT_KG");
            }
            seaLevelFormatter = new frontend.formatter.SeaLevelFormatter();
            seaLevelFormatter.decimalSeparator = altitudeConverter.outputFormat != utils.format.AltitudeFormat.METER ? "." : ",";
            unitStringSeaLevel = utils.LanguageManager.getString("UNIT_HPA");
            bodySizeConverter = new utils.converter.SizeConverter();
            bodySizeConverter.inputFormat = utils.format.BodySizeFormat.CENTIMETER;
            if (core.MeasurementConfig.distanceFormat != utils.format.DistanceFormat.KILOMETER) 
            {
                bodySizeConverter.outputFormat = utils.format.BodySizeFormat.INCH;
                unitStringBodySize = utils.LanguageManager.getString("UNIT_INCH");
            }
            else 
            {
                bodySizeConverter.outputFormat = utils.format.BodySizeFormat.CENTIMETER;
                unitStringBodySize = utils.LanguageManager.getString("UNIT_CM");
            }
            bodySizeFormatter = new frontend.formatter.NumberFormatter();
            bodySizeFormatter.fractionalDigits = 0;
            validateMonthLabels();
            intensityZonePercentageFormatter = new frontend.formatter.NumberFormatter();
            intensityZonePercentageFormatter.fractionalDigits = 0;
            intensityFactorFormatter = new frontend.formatter.IntensityFactorFormatter();
            intensityFactorFormatter.decimalSeparator = ",";
            tssFormatter = new frontend.formatter.NumberFormatter();
            tssFormatter.decimalSeparator = ",";
            tssFormatter.fractionalDigits = 1;
            percentFormatter = new frontend.formatter.NumberFormatter();
            percentFormatter.fractionalDigits = 0;
            latLonFormatter = new frontend.formatter.NumberFormatter();
            latLonFormatter.decimalSeparator = ".";
            latLonFormatter.fractionalDigits = 6;
            latLonDegreesFormatter = new frontend.formatter.NumberFormatter();
            latLonDegreesFormatter.fractionalDigits = 0;
            latLonMinutesFormatter = new frontend.formatter.NumberFormatter();
            latLonMinutesFormatter.fractionalDigits = 0;
            latLonSecondsFormatter = new frontend.formatter.NumberFormatter();
            latLonSecondsFormatter.decimalSeparator = ".";
            latLonSecondsFormatter.fractionalDigits = 2;
            return;
        }

        internal static function updateMeasurementConfig():void
        {
            core.MeasurementConfig.language = configCache.ConfigCache.getInstance().getValue(configCache.ConfigCacheAttributeNames.LANGUAGE, core.general.LanguageSoftware.DE_DE);
            core.MeasurementConfig.dateFormat = configCache.ConfigCache.getInstance().getValue(configCache.ConfigCacheAttributeNames.DATE_FORMAT, utils.format.DateFormat.EUROPEAN);
            core.MeasurementConfig.clockFormat = configCache.ConfigCache.getInstance().getValue(configCache.ConfigCacheAttributeNames.CLOCK_FORMAT, utils.format.ClockFormat.CLOCK_24H);
            core.MeasurementConfig.distanceFormat = configCache.ConfigCache.getInstance().getValue(configCache.ConfigCacheAttributeNames.DISTANCE_FORMAT, utils.format.DistanceFormat.KILOMETER);
            configCache.ConfigCache.getInstance().setValue(configCache.ConfigCacheAttributeNames.SPEED_FORMAT, core.MeasurementConfig.distanceFormat != utils.format.DistanceFormat.KILOMETER ? utils.format.SpeedFormat.MILES_PER_HOUR : utils.format.SpeedFormat.KILOMETER_PER_HOUR);
            core.MeasurementConfig.speedFormat = configCache.ConfigCache.getInstance().getValue(configCache.ConfigCacheAttributeNames.SPEED_FORMAT, utils.format.SpeedFormat.KILOMETER_PER_HOUR);
            core.MeasurementConfig.altitudeFormat = configCache.ConfigCache.getInstance().getValue(configCache.ConfigCacheAttributeNames.ALTITUDE_FORMAT, utils.format.AltitudeFormat.METER);
            core.MeasurementConfig.weightFormat = configCache.ConfigCache.getInstance().getValue(configCache.ConfigCacheAttributeNames.WEIGHT_FORMAT, core.general.WeightUnit.KG);
            core.MeasurementConfig.temperatureFormat = configCache.ConfigCache.getInstance().getValue(configCache.ConfigCacheAttributeNames.TEMPERATURE_FORMAT, utils.format.TemperatureFormat.CELSIUS);
            return;
        }

        internal static function validateMonthLabels():void
        {
            monthLabelsLong = new Vector.<String>();
            monthLabelsLong.push(utils.LanguageManager.getString("MONTH_JANUARY_LONG"));
            monthLabelsLong.push(utils.LanguageManager.getString("MONTH_FEBRUARY_LONG"));
            monthLabelsLong.push(utils.LanguageManager.getString("MONTH_MARCH_LONG"));
            monthLabelsLong.push(utils.LanguageManager.getString("MONTH_APRIL_LONG"));
            monthLabelsLong.push(utils.LanguageManager.getString("MONTH_MAY_LONG"));
            monthLabelsLong.push(utils.LanguageManager.getString("MONTH_JUNE_LONG"));
            monthLabelsLong.push(utils.LanguageManager.getString("MONTH_JULY_LONG"));
            monthLabelsLong.push(utils.LanguageManager.getString("MONTH_AUGUST_LONG"));
            monthLabelsLong.push(utils.LanguageManager.getString("MONTH_SEPTEMBER_LONG"));
            monthLabelsLong.push(utils.LanguageManager.getString("MONTH_OCTOBER_LONG"));
            monthLabelsLong.push(utils.LanguageManager.getString("MONTH_NOVEMBER_LONG"));
            monthLabelsLong.push(utils.LanguageManager.getString("MONTH_DECEMBER_LONG"));
            monthLabelsShort = new Vector.<String>();
            monthLabelsShort.push(utils.LanguageManager.getString("MONTH_JANUARY"));
            monthLabelsShort.push(utils.LanguageManager.getString("MONTH_FEBRUARY"));
            monthLabelsShort.push(utils.LanguageManager.getString("MONTH_MARCH"));
            monthLabelsShort.push(utils.LanguageManager.getString("MONTH_APRIL"));
            monthLabelsShort.push(utils.LanguageManager.getString("MONTH_MAY"));
            monthLabelsShort.push(utils.LanguageManager.getString("MONTH_JUNE"));
            monthLabelsShort.push(utils.LanguageManager.getString("MONTH_JULY"));
            monthLabelsShort.push(utils.LanguageManager.getString("MONTH_AUGUST"));
            monthLabelsShort.push(utils.LanguageManager.getString("MONTH_SEPTEMBER"));
            monthLabelsShort.push(utils.LanguageManager.getString("MONTH_OCTOBER"));
            monthLabelsShort.push(utils.LanguageManager.getString("MONTH_NOVEMBER"));
            monthLabelsShort.push(utils.LanguageManager.getString("MONTH_DECEMBER"));
            return;
        }

        public static function get dateFormatter():utils.interfaces.ICustomFormatter
        {
            return backend.utils.DataUtils._779770692dateFormatter;
        }

        public static function set dateFormatter(arg1:utils.interfaces.ICustomFormatter):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.DataUtils._779770692dateFormatter;
            if (loc1 !== arg1) 
            {
                backend.utils.DataUtils._779770692dateFormatter = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "dateFormatter", loc1, arg1, backend.utils.DataUtils);
                loc3 = backend.utils.DataUtils.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get dateTimeFormatter():utils.interfaces.ICustomFormatter
        {
            return backend.utils.DataUtils._483524753dateTimeFormatter;
        }

        public static function set dateTimeFormatter(arg1:utils.interfaces.ICustomFormatter):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.DataUtils._483524753dateTimeFormatter;
            if (loc1 !== arg1) 
            {
                backend.utils.DataUtils._483524753dateTimeFormatter = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "dateTimeFormatter", loc1, arg1, backend.utils.DataUtils);
                loc3 = backend.utils.DataUtils.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get unitStringAltitude():String
        {
            return backend.utils.DataUtils._1519444873unitStringAltitude;
        }

        public static function set unitStringAltitude(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.DataUtils._1519444873unitStringAltitude;
            if (loc1 !== arg1) 
            {
                backend.utils.DataUtils._1519444873unitStringAltitude = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "unitStringAltitude", loc1, arg1, backend.utils.DataUtils);
                loc3 = backend.utils.DataUtils.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get unitStringDistance():String
        {
            return backend.utils.DataUtils._1027431882unitStringDistance;
        }

        public static function set unitStringDistance(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.DataUtils._1027431882unitStringDistance;
            if (loc1 !== arg1) 
            {
                backend.utils.DataUtils._1027431882unitStringDistance = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "unitStringDistance", loc1, arg1, backend.utils.DataUtils);
                loc3 = backend.utils.DataUtils.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get unitStringFuelEconomy():String
        {
            return backend.utils.DataUtils._277633613unitStringFuelEconomy;
        }

        public static function get unitStringHeartrate():String
        {
            return backend.utils.DataUtils._1634669297unitStringHeartrate;
        }

        public static function set unitStringHeartrate(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.DataUtils._1634669297unitStringHeartrate;
            if (loc1 !== arg1) 
            {
                backend.utils.DataUtils._1634669297unitStringHeartrate = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "unitStringHeartrate", loc1, arg1, backend.utils.DataUtils);
                loc3 = backend.utils.DataUtils.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get unitStringRiseRate():String
        {
            return backend.utils.DataUtils._357338850unitStringRiseRate;
        }

        public static function set unitStringRiseRate(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.DataUtils._357338850unitStringRiseRate;
            if (loc1 !== arg1) 
            {
                backend.utils.DataUtils._357338850unitStringRiseRate = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "unitStringRiseRate", loc1, arg1, backend.utils.DataUtils);
                loc3 = backend.utils.DataUtils.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get unitStringSpeed():String
        {
            return backend.utils.DataUtils._2005501586unitStringSpeed;
        }

        public static function set unitStringSpeed(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.DataUtils._2005501586unitStringSpeed;
            if (loc1 !== arg1) 
            {
                backend.utils.DataUtils._2005501586unitStringSpeed = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "unitStringSpeed", loc1, arg1, backend.utils.DataUtils);
                loc3 = backend.utils.DataUtils.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get unitStringSpeedTime():String
        {
            return backend.utils.DataUtils._209210241unitStringSpeedTime;
        }

        public static function set unitStringSpeedTime(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.DataUtils._209210241unitStringSpeedTime;
            if (loc1 !== arg1) 
            {
                backend.utils.DataUtils._209210241unitStringSpeedTime = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "unitStringSpeedTime", loc1, arg1, backend.utils.DataUtils);
                loc3 = backend.utils.DataUtils.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get unitStringTimeHours():String
        {
            return backend.utils.DataUtils._1448584461unitStringTimeHours;
        }

        public static function set unitStringTimeHours(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.DataUtils._1448584461unitStringTimeHours;
            if (loc1 !== arg1) 
            {
                backend.utils.DataUtils._1448584461unitStringTimeHours = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "unitStringTimeHours", loc1, arg1, backend.utils.DataUtils);
                loc3 = backend.utils.DataUtils.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get staticEventDispatcher():starling.events.EventDispatcher
        {
            return _staticBindingEventDispatcher;
        }

        public static var inclineFormatter:frontend.formatter.InclineFormatter;

        public static var inclineLabel:String;

        public static var intensityFactorFormatter:frontend.formatter.IntensityFactorFormatter;

        public static var intensityZonePercentageFormatter:frontend.formatter.NumberFormatter;

        public static var latLonDegreesFormatter:frontend.formatter.NumberFormatter;

        public static var latLonFormatter:frontend.formatter.NumberFormatter;

        public static var latLonMinutesFormatter:frontend.formatter.NumberFormatter;

        public static var latLonSecondsFormatter:frontend.formatter.NumberFormatter;

        public static var monthLabelsLong:__AS3__.vec.Vector.<String>;

        public static var monthLabelsShort:__AS3__.vec.Vector.<String>;

        public static var percentFormatter:frontend.formatter.NumberFormatter;

        public static var powerFormatter:frontend.formatter.PowerFormatter;

        public static var powerLabel:String;

        public static var powerPerKGConverter:utils.converter.PowerPerWeightConverter;

        public static var powerPerKGFormatter:frontend.formatter.PowerPerKGFormatter;

        public static var powerPerKGLabel:String;

        public static var riseRateLabel:String;

        public static var seaLevelFormatter:frontend.formatter.SeaLevelFormatter;

        public static var speedConverter:utils.converter.SpeedConverter;

        public static var speedFormatter:frontend.formatter.SpeedFormatter;

        public static var speedLabel:String;

        public static var speedTimeConverter:utils.converter.SpeedTimeConverter;

        public static var temperatureConverter:utils.converter.TemperatureConverter;

        public static var temperatureFormatter:frontend.formatter.TemperatureFormatter;

        public static var temperatureLabel:String;

        public static var timeFormatter:utils.interfaces.ICustomFormatter;

        internal static var _779770692dateFormatter:utils.interfaces.ICustomFormatter;

        public static var timeFormatterHHMMSST:utils.interfaces.ICustomTimeFormatter;

        public static var timeFormatter_MM_SS:frontend.formatter.TimeFormatter;

        public static var tssFormatter:frontend.formatter.NumberFormatter;

        internal static var _1519444873unitStringAltitude:String;

        public static var unitStringBodySize:String;

        public static var unitStringCadence:String;

        public static var unitStringCalories:String;

        internal static var _1027431882unitStringDistance:String;

        public static var unitStringExpansion:String;

        internal static var _277633613unitStringFuelEconomy:String;

        internal static var _1634669297unitStringHeartrate:String;

        public static var unitStringIncline:String;

        public static var unitStringKj:String;

        public static var unitStringPercent:String;

        public static var unitStringPower:String;

        public static var unitStringPowerPerKg:String;

        internal static var _357338850unitStringRiseRate:String;

        public static var unitStringSeaLevel:String;

        internal static var _2005501586unitStringSpeed:String;

        internal static var _209210241unitStringSpeedTime:String;

        public static var unitStringTemperature:String;

        internal static var _1448584461unitStringTimeHours:String;

        public static var unitStringWeight:String;

        public static var weightConverter:utils.converter.WeightConverter;

        public static var weightFormatter:frontend.formatter.NumberFormatter;

        public static var altitudeConverter:utils.converter.IConverter;

        public static var altitudeFormatter:utils.interfaces.ICustomFormatter;

        public static var altitudeLabel:String;

        public static var autoLapTimeFormatter:frontend.formatter.TimeFormatter;

        public static var bodySizeConverter:utils.converter.SizeConverter;

        public static var bodySizeFormatter:frontend.formatter.NumberFormatter;

        public static var cadenceFormatter:frontend.formatter.CadenceFormatter;

        public static var cadenceLabel:String;

        public static var caloriesFormatter:frontend.formatter.CaloriesFormatter;

        public static var caloriesLabel:String;

        public static var clockFormat:String;

        public static var countdownFormatter:frontend.formatter.TimeFormatter;

        internal static var _483524753dateTimeFormatter:utils.interfaces.ICustomFormatter;

        public static var timeFormatterHHMM:utils.interfaces.ICustomTimeFormatter;

        public static var distanceConverter:utils.converter.DistanceConverter;

        public static var distanceFormatter:utils.interfaces.ICustomFormatter;

        public static var distanceLabel:String;

        public static var distancePlusMinusLabel:String;

        public static var expansionFormatter:frontend.formatter.ExpansionFormatter;

        public static var expansionLabel:String;

        public static var fuelEconomyConverter:utils.converter.FuelEconomyConverter;

        public static var fuelEconomyFormatter:frontend.formatter.FuelEconomyFormatter;

        public static var fuelEconomyLabel:String;

        public static var heartrateFormatter:frontend.formatter.HeartrateFormatter;

        internal static var _staticBindingEventDispatcher:starling.events.EventDispatcher;

        public static var heartrateLabel:String;

        public static var wheelSizeFormatter:frontend.formatter.WheelSizeFormatter;
    }
}


