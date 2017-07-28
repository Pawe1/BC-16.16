//class AppDBHandler
package handler 
{
    import backend.database.*;
    import com.logging.*;
    import configCache.*;
    import core.*;
    import core.general.*;
    import database.*;
    import debug.*;
    import flash.data.*;
    import flash.errors.*;
    import flash.events.*;
    import flash.utils.*;
    import utils.*;
    
    public class AppDBHandler extends database.DBHandler
    {
        public function AppDBHandler()
        {
            super();
            skipLicenceCheck = true;
            skipActivationCheck = true;
            return;
        }

        public function get initialAppStart():Boolean
        {
            this._initialAppStart = configCache.ConfigCache.getInstance().getValue(configCache.ConfigCacheObject.INITIAL_APP_START, this._initialAppStart);
            return this._initialAppStart;
        }

        public override function validateDatabase():void
        {
            var loc2:*=null;
            var loc1:*=backend.database.DatabaseDefinition.getInstance().hasOldDatabase();
            backend.database.DatabaseDefinition.getInstance().currentDatabase.searchFile();
            if (backend.database.DatabaseDefinition.getInstance().currentDatabase.file == null) 
            {
                if (loc1 && !skipDatabaseUpdate) 
                {
                    loc2 = backend.database.DatabaseDefinition.getInstance().getHighestOldDatabase();
                    if (loc2.versionNumber >= database.CommonDatabaseDefinition.DB_400) 
                    {
                        dataBase = loc2.file;
                        this.checkDatabaseUpdateStatus(true);
                    }
                    else 
                    {
                        this.checkOldDatabase();
                    }
                }
                else 
                {
                    backend.database.DatabaseDefinition.getInstance().currentDatabase.initDatabaseFile();
                    core.Status.updateStatusTable(core.Status.col_databaseUpdateStatus, core.Status.UPDATE_COMPLETE);
                    this.onCurrentDatabaseComplete();
                }
            }
            else 
            {
                dataBase = backend.database.DatabaseDefinition.getInstance().currentDatabase.file;
                this.checkDatabaseUpdateStatus();
            }
            return;
        }

        internal function checkDatabaseStructure():void
        {
            debug.Debug.debug("checkDatabaseStructure");
            backend.database.DatabaseDefinition.getInstance().addEventListener(database.CommonDatabaseDefinition.DATABASE_STRUCTURE_VALID, this.onDatabaseStructureValid);
            backend.database.DatabaseDefinition.getInstance().addEventListener(database.CommonDatabaseDefinition.DATABASE_STRUCTURE_INVALID, this.onDatabaseStructureInvalid);
            backend.database.DatabaseDefinition.getInstance().checkDatabaseStructure();
            return;
        }

        internal function onDatabaseStructureValid(arg1:flash.events.Event):void
        {
            debug.Debug.debug("onDatabaseStructureValid");
            backend.database.DatabaseDefinition.getInstance().removeEventListener(database.CommonDatabaseDefinition.DATABASE_STRUCTURE_VALID, this.onDatabaseStructureValid);
            backend.database.DatabaseDefinition.getInstance().removeEventListener(database.CommonDatabaseDefinition.DATABASE_STRUCTURE_INVALID, this.onDatabaseStructureInvalid);
            dispatchEvent(new flash.events.Event(DATABASE_VALIDATED));
            return;
        }

        internal function onDatabaseStructureInvalid(arg1:flash.events.Event):void
        {
            debug.Debug.debug("onDatabaseStructureInvalid");
            backend.database.DatabaseDefinition.getInstance().removeEventListener(database.CommonDatabaseDefinition.DATABASE_STRUCTURE_VALID, this.onDatabaseStructureValid);
            backend.database.DatabaseDefinition.getInstance().removeEventListener(database.CommonDatabaseDefinition.DATABASE_STRUCTURE_INVALID, this.onDatabaseStructureInvalid);
            dispatchEvent(new flash.events.Event(DATABASE_VALIDATED));
            return;
        }

        internal function onCurrentDatabaseCorrupt(arg1:flash.events.Event):void
        {
            var loc1:*=database.DatabaseBackup.getInstance();
            loc1.removeEventListener(database.DatabaseBackup.BACKUP_COMPLETE, this.onCurrentDatabaseComplete);
            loc1.removeEventListener(database.DatabaseBackup.DATABASE_CORRUPT, this.onCurrentDatabaseCorrupt);
            dispatchEvent(new com.logging.ErrorLoggingEvent(com.logging.ErrorLoggingEvent.ERROR, core.general.ErrorLoggingTyp.ERROR_CURRENT_DATABASE_CORRUPT, core.general.ErrorLoggingTyp.DESC_ERROR_CURRENT_DATABASE_CORRUPT));
            return;
        }

        internal function onCurrentDatabaseComplete(arg1:flash.events.Event=null):void
        {
            var loc1:*=database.DatabaseBackup.getInstance();
            loc1.removeEventListener(database.DatabaseBackup.BACKUP_COMPLETE, this.onCurrentDatabaseComplete);
            loc1.removeEventListener(database.DatabaseBackup.DATABASE_CORRUPT, this.onCurrentDatabaseCorrupt);
            showLicenceTextView = skipLicenceCheck ? false : true;
            showActivateView = skipActivationCheck ? false : true;
            dispatchEvent(new flash.events.Event(DATABASE_VALIDATED));
            return;
        }

        internal function checkOldDatabase():void
        {
            var loc1:*=database.DatabaseBackup.getInstance();
            loc1.addEventListener(database.DatabaseBackup.DATABASE_OKAY, this.onOldDatabaseOkay);
            loc1.addEventListener(database.DatabaseBackup.DATABASE_CORRUPT, this.onOldDatabaseCorrupt);
            loc1.checkDatabase(backend.database.DatabaseDefinition.getInstance().getHighestOldDatabase(), false);
            return;
        }

        internal function onOldDatabaseCorrupt(arg1:flash.events.Event):void
        {
            var loc1:*=database.DatabaseBackup.getInstance();
            loc1.removeEventListener(database.DatabaseBackup.DATABASE_OKAY, this.onOldDatabaseOkay);
            loc1.removeEventListener(database.DatabaseBackup.DATABASE_CORRUPT, this.onOldDatabaseCorrupt);
            dispatchEvent(new com.logging.ErrorLoggingEvent(com.logging.ErrorLoggingEvent.ERROR, core.general.ErrorLoggingTyp.ERROR_OLD_DATABASE_CORRUPT, core.general.ErrorLoggingTyp.DESC_ERROR_OLD_DATABASE_CORRUPT));
            return;
        }

        internal function onOldDatabaseOkay(arg1:flash.events.Event):void
        {
            var loc1:*=database.DatabaseBackup.getInstance();
            loc1.removeEventListener(database.DatabaseBackup.DATABASE_OKAY, this.onOldDatabaseOkay);
            loc1.removeEventListener(database.DatabaseBackup.DATABASE_CORRUPT, this.onOldDatabaseCorrupt);
            showUpdateView = true;
            showLicenceTextView = skipLicenceCheck ? false : true;
            dispatchEvent(new flash.events.Event(DATABASE_VALIDATED));
            return;
        }

        internal function checkDatabaseUpdateStatus(arg1:Boolean=false):void
        {
            new database.DatabaseTransaction(this.executeStatusSelectStatement, [arg1], flash.data.SQLMode.READ).commit();
            return;
        }

        public function executeStatusSelectStatement(arg1:Boolean=false):void
        {
            var p_oldDatabase:Boolean=false;
            var stmt:database.DCSQLStatement;

            var loc1:*;
            stmt = null;
            p_oldDatabase = arg1;
            stmt = new database.DCSQLStatement();
            stmt.addEventListener(flash.events.SQLEvent.RESULT, this.selectStatusComplete);
            stmt.addEventListener(flash.events.SQLErrorEvent.ERROR, this.selectStatusError);
            stmt.text = "select * from Status";
            stmt.data = p_oldDatabase;
            try 
            {
                stmt.execute();
            }
            catch (error:flash.errors.SQLError)
            {
                stmt.dispatchEvent(new flash.events.SQLErrorEvent(flash.events.SQLErrorEvent.ERROR, false, false, new flash.errors.SQLError(error.operation, error.details + " in " + stmt.text, error.message, error.errorID, error.detailID, error.detailArguments)));
            }
            return;
        }

        internal function selectStatusComplete(arg1:flash.events.SQLEvent):void
        {
            var loc5:*=null;
            var loc6:*=null;
            var loc7:*=null;
            var loc8:*=0;
            var loc1:*=arg1.target as database.DCSQLStatement;
            loc1.removeEventListener(flash.events.SQLEvent.RESULT, this.selectStatusComplete);
            loc1.removeEventListener(flash.events.SQLErrorEvent.ERROR, this.selectStatusError);
            var loc2:*=loc1.data as Boolean;
            var loc3:*=database.CommonDatabaseDefinition.getInstance().getHighestOldDatabase();
            var loc4:*=loc1.getResult();
            database.DatabaseHandlerCommon.getInstance().commit();
            if (loc2) 
            {
                if (!(loc4.data == null) && loc4.data.length > 0) 
                {
                    loc6 = loc4.data[(loc4.data.length - 1)];
                    loc5 = new core.Status();
                    loc5.fromDB(loc6);
                }
                if (!loc5 || loc5.databaseUpdateStatus == core.Status.UPDATE_NONE || loc5.databaseUpdateStatus == core.Status.UPDATE_STARTED) 
                {
                    loc3.deleteDatabase();
                    this.validateDatabase();
                }
                else 
                {
                    this.checkOldDatabase();
                }
            }
            else if (!(loc4.data == null) && loc4.data.length > 0) 
            {
                loc7 = loc4.data[(loc4.data.length - 1)];
                this.status = new core.Status();
                this.status.fromDB(loc7);
                if (this.status.dbUpdateNumber > database.CommonDatabaseDefinition.CURRENT_DB_VERSION) 
                {
                    dispatchEvent(new com.logging.ErrorLoggingEvent(com.logging.ErrorLoggingEvent.ERROR, core.general.ErrorLoggingTyp.ERROR_OLD_DC_VERSION, utils.LanguageManager.getString("MIN_REQUIRED_DC_VERSION").replace("##target", this.status.databaseVersion), this));
                    return;
                }
                if (this.status.databaseUpdateStatus == core.Status.UPDATE_NONE || this.status.databaseUpdateStatus == core.Status.UPDATE_STARTED) 
                {
                    if (loc3) 
                    {
                        showUpdateView = skipDatabaseUpdate ? false : true;
                    }
                    else 
                    {
                        showUpdateView = false;
                    }
                    this.deleteDatabase();
                }
                else if (this.status.databaseUpdateStatus != core.Status.UPDATE_COMPLETE) 
                {
                    if (this.status.databaseUpdateStatus != core.Status.UPDATE_FROM_SELECTED_DATABASE_UNCOMPLETE) 
                    {
                        this.deleteDatabase();
                        flash.utils.setTimeout(this.validateDatabase, 2000);
                        return;
                    }
                }
                else 
                {
                    loc8 = database.CommonDatabaseDefinition.getInstance().currentDatabase.versionNumber;
                    if (this.status.dbUpdateNumber < database.CommonDatabaseDefinition.getInstance().currentDatabase.versionNumber) 
                    {
                        if (loc3) 
                        {
                            showUpdateView = skipDatabaseUpdate ? false : true;
                        }
                        else 
                        {
                            showUpdateView = false;
                        }
                    }
                    else 
                    {
                        this.checkDatabaseStructure();
                        return;
                    }
                }
                if (skipLicenceCheck) 
                {
                    showLicenceTextView = false;
                }
                else 
                {
                    showLicenceTextView = skipLicenceCheck ? false : true;
                }
                dispatchEvent(new flash.events.Event(DATABASE_VALIDATED));
            }
            else 
            {
                this.deleteDatabase();
            }
            return;
        }

        internal function deleteDatabase():void
        {
            try 
            {
                backend.database.DatabaseDefinition.getInstance().currentDatabase.deleteDatabase();
                this.validateDatabase();
            }
            catch (e:Error)
            {
            };
            return;
        }

        internal function selectStatusError(arg1:flash.events.SQLErrorEvent):void
        {
            var loc1:*=arg1.target as database.DCSQLStatement;
            loc1.removeEventListener(flash.events.SQLEvent.RESULT, this.selectStatusComplete);
            loc1.removeEventListener(flash.events.SQLErrorEvent.ERROR, this.selectStatusError);
            database.DatabaseHandlerCommon.getInstance().close();
            return;
        }

        public static function getInstance():handler.AppDBHandler
        {
            if (!_instance) 
            {
                _instance = new AppDBHandler();
                database.DBHandler.setInstance(_instance);
            }
            return _instance;
        }

        public static const INITIAL_APP_START_FLAG_CHANGED:String="initialAppStartFlagChanged";

        internal var _initialAppStart:Boolean=true;

        public var newDatabaseCreated:Boolean=false;

        public var status:core.Status;

        internal static var _instance:handler.AppDBHandler;
    }
}


