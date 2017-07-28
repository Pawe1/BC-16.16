//class DatabaseDefinition
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


