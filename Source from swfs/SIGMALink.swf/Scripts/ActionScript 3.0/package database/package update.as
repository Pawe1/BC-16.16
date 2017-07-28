//package update
//  class CommonDatabaseUpdate
package database.update 
{
    import com.logging.*;
    import database.*;
    import flash.data.*;
    import flash.events.*;
    import flash.filesystem.*;
    import flash.utils.*;
    import utils.*;
    
    public class CommonDatabaseUpdate extends flash.events.EventDispatcher
    {
        public function CommonDatabaseUpdate(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            return;
        }

        protected function connectDatabases(arg1:database.Database, arg2:database.Database):void
        {
            if (!arg1 || !arg2) 
            {
                return;
            }
            oldDatabase = arg1;
            newDatabase = arg2;
            var loc1:*=getEncryptionKey();
            oldDatabaseConnection = new flash.data.SQLConnection();
            oldDatabaseConnection.open(arg1.file, "read", false, 1024, loc1);
            oldDatabaseConnectionUpdate = new flash.data.SQLConnection();
            oldDatabaseConnectionUpdate.open(arg1.file, "update", false, 1024, loc1);
            currentDatabaseConnection = new flash.data.SQLConnection();
            currentDatabaseConnection.open(arg2.file, "create", false, 1024, loc1);
            database.update.CommonUpdateHandler.getInstance().dbVersion = arg2.versionNumber;
            database.update.CommonUpdateHandler.getInstance().oldDatabaseConnection = oldDatabaseConnection;
            database.update.CommonUpdateHandler.getInstance().currentDatabaseConnection = currentDatabaseConnection;
            return;
        }

        protected function getEncryptionKey():flash.utils.ByteArray
        {
            var loc1:*=new utils.Base64Decoder();
            loc1.decode(database.Database.myDecoderPwd);
            var loc2:*=loc1.toByteArray();
            return loc2;
        }

        public function runUpdate(arg1:database.Database, arg2:database.Database):void
        {
            var loc2:*=null;
            var loc1:*=null;
            var loc4:*=null;
            var loc3:*=null;
            var loc5:*=0;
            oldDatabase = arg1;
            newDatabase = arg2;
            onUpdateProgress();
            if (!(oldDatabase.directory == newDatabase.directory) || !(oldDatabase.name == newDatabase.name)) 
            {
                loc2 = newDatabase.workDirectory.resolvePath(newDatabase.name);
                oldDatabase.file.addEventListener("complete", onCreateDBFileComplete);
                oldDatabase.file.addEventListener("ioError", onFileOperationError);
                oldDatabase.file.copyToAsync(loc2, true);
            }
            else if (oldDatabase.createBackupBeforeUpdate) 
            {
                loc1 = arg1.name + "_" + arg1.versionNumber;
                loc4 = database.Database.backupDirectory().resolvePath(database.Database.createBackupFileName(loc1));
                loc5 = 1;
                while (loc4.exists) 
                {
                    loc4 = database.Database.backupDirectory().resolvePath(database.Database.createBackupFileName(loc1, loc5));
                    ++loc5;
                }
                oldDatabase.backupFile = loc4;
                oldDatabase.file.addEventListener("complete", onCreateDBFileComplete);
                oldDatabase.file.addEventListener("ioError", onFileOperationError);
                oldDatabase.file.copyToAsync(loc4, true);
            }
            else 
            {
                onCreateDBFileComplete();
            }
            return;
        }

        internal function onFileOperationError(arg1:flash.events.IOErrorEvent):void
        {
            var loc1:*=arg1.currentTarget as flash.filesystem.File;
            loc1.removeEventListener("complete", onCreateDBFileComplete);
            loc1.removeEventListener("ioError", onFileOperationError);
            dispatchEvent(new flash.events.Event("databaseError"));
            return;
        }

        internal function onCreateDBFileComplete(arg1:flash.events.Event=null):void
        {
            var loc3:*=null;
            var loc1:*=null;
            var loc4:*=null;
            var loc2:*=null;
            var loc5:*=0;
            if (arg1) 
            {
                (loc3 = arg1.currentTarget as flash.filesystem.File).removeEventListener("complete", onCreateDBFileComplete);
                loc3.removeEventListener("ioError", onFileOperationError);
            }
            if (oldDatabase.createBackupBeforeUpdate && arg1 == null) 
            {
                loc1 = oldDatabase.name + "_" + oldDatabase.versionNumber;
                loc4 = database.Database.backupDirectory().resolvePath(database.Database.createBackupFileName(loc1));
                loc5 = 1;
                while (loc4.exists) 
                {
                    loc4 = database.Database.backupDirectory().resolvePath(database.Database.createBackupFileName(loc1, loc5));
                    ++loc5;
                }
                oldDatabase.backupFile = loc4;
                oldDatabase.file.addEventListener("complete", onBackupComplete);
                oldDatabase.file.addEventListener("ioError", onFileOperationError);
                oldDatabase.file.copyToAsync(loc4, true);
            }
            else 
            {
                onBackupComplete();
            }
            return;
        }

        internal function onBackupComplete(arg1:flash.events.Event=null):void
        {
            var loc1:*=null;
            if (arg1) 
            {
                loc1 = arg1.currentTarget as flash.filesystem.File;
                loc1.removeEventListener("complete", onBackupComplete);
                loc1.removeEventListener("ioError", onFileOperationError);
            }
            newDatabase.file = newDatabase.workDirectory.resolvePath(newDatabase.name);
            startUpdate();
            return;
        }

        protected function startUpdate():void
        {
            return;
        }

        protected function onUpdateProgress(arg1:database.update.SQLUpdateEvent=null):void
        {
            var loc1:*=new database.update.SQLUpdateEvent("databaseUpdateProgress");
            if (arg1) 
            {
                loc1.maximum = arg1.maximum;
                loc1.value = arg1.value;
            }
            else 
            {
                loc1.maximum = 1;
                loc1.value = 0;
            }
            dispatchEvent(loc1);
            return;
        }

        protected function disconnectDatabases():void
        {
            if (oldDatabaseConnection && oldDatabaseConnection.connected) 
            {
                try 
                {
                    oldDatabaseConnection.close();
                    oldDatabaseConnectionUpdate.close();
                    currentDatabaseConnection.close();
                }
                catch (e:Error)
                {
                };
            }
            return;
        }

        public function loadOldData(arg1:database.Database, arg2:database.Database):void
        {
            return;
        }

        public static function getInstance():database.update.CommonDatabaseUpdate
        {
            if (!_instance) 
            {
                _instance = new CommonDatabaseUpdate();
            }
            return _instance;
        }

        public static function setInstance(arg1:database.update.CommonDatabaseUpdate):void
        {
            _instance = arg1;
            return;
        }

        protected static function getSQLStatement():database.DCSQLStatement
        {
            if (!stmt) 
            {
                stmt = database.update.CommonUpdateHandler.getInstance().loadStatement();
            }
            return stmt;
        }

        public static function dispose():void
        {
            if (_instance != null) 
            {
                com.logging.ErrorLogging.getInstance().removeTarget(_instance);
                _instance = null;
                database.update.CommonUpdateHandler.dispose();
            }
            return;
        }

        public static const DATABASE_ERROR:String="databaseError";

        public static const DATABASE_OKAY:String="databaseOkay";

        public static const PROGRESS:String="databaseUpdateProgress";

        protected var currentDatabaseConnection:flash.data.SQLConnection;

        protected var newDatabase:database.Database;

        protected var oldDatabase:database.Database;

        protected var oldDatabaseConnection:flash.data.SQLConnection;

        protected var oldDatabaseConnectionUpdate:flash.data.SQLConnection;

        protected static var stmt:database.DCSQLStatement;

        internal static var _instance:database.update.CommonDatabaseUpdate;
    }
}


//  class CommonUpdateHandler
package database.update 
{
    import com.logging.*;
    import database.*;
    import flash.data.*;
    import flash.errors.*;
    import flash.events.*;
    
    public class CommonUpdateHandler extends flash.events.EventDispatcher
    {
        public function CommonUpdateHandler(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            com.logging.ErrorLogging.getInstance().addTarget(this);
            return;
        }

        public function executeLoadStatement(arg1:database.DCSQLStatement):flash.data.SQLResult
        {
            oldDatabaseConnection.begin("deferred");
            var loc1:*=new flash.data.SQLResult();
            try 
            {
                arg1.execute();
                loc1 = arg1.getResult();
                oldDatabaseConnection.commit();
            }
            catch (error:flash.errors.SQLError)
            {
                dispatchExecuteError(arg1, error);
            }
            return loc1;
        }

        public function loadStatement(arg1:Boolean=false):database.DCSQLStatement
        {
            var loc1:*=new database.DCSQLStatement();
            if (arg1) 
            {
                loc1.sqlConnection = currentDatabaseConnection;
            }
            else 
            {
                loc1.sqlConnection = oldDatabaseConnection;
            }
            loc1.addEventListener("error", updateErrorHandling);
            loc1.addEventListener("result", onSQLResultEvent);
            return loc1;
        }

        public function updateErrorHandling(arg1:flash.events.SQLErrorEvent):void
        {
            (arg1.target as flash.data.SQLStatement).removeEventListener("error", updateErrorHandling);
            (arg1.target as flash.data.SQLStatement).removeEventListener("result", onSQLResultEvent);
            if ((arg1.target as flash.data.SQLStatement).sqlConnection.inTransaction) 
            {
                (arg1.target as flash.data.SQLStatement).sqlConnection.rollback();
            }
            return;
        }

        public function onSQLResultEvent(arg1:flash.events.SQLEvent):void
        {
            (arg1.target as flash.data.SQLStatement).removeEventListener("error", updateErrorHandling);
            (arg1.target as flash.data.SQLStatement).removeEventListener("result", onSQLResultEvent);
            return;
        }

        public function dispatchExecuteError(arg1:database.DCSQLStatement, arg2:flash.errors.SQLError):void
        {
            arg1.dispatchEvent(new flash.events.SQLErrorEvent("error", false, false, new flash.errors.SQLError(arg2.operation, arg2.details + " in " + arg1.text, arg2.message, arg2.errorID, arg2.detailID, arg2.detailArguments)));
            return;
        }

        public static function getInstance():database.update.CommonUpdateHandler
        {
            if (!_instance) 
            {
                _instance = new CommonUpdateHandler();
            }
            return _instance;
        }

        public static function setInstance(arg1:database.update.CommonUpdateHandler):void
        {
            _instance = arg1;
            return;
        }

        public static function dispose():void
        {
            if (_instance != null) 
            {
                com.logging.ErrorLogging.getInstance().removeTarget(_instance);
                _instance = null;
            }
            return;
        }

        public var currentDatabaseConnection:flash.data.SQLConnection;

        public var dbVersion:uint=0;

        public var oldDatabaseConnection:flash.data.SQLConnection;

        internal static var _instance:database.update.CommonUpdateHandler;
    }
}


//  class SQLUpdateErrorEvent
package database.update 
{
    import flash.events.*;
    
    public class SQLUpdateErrorEvent extends flash.events.Event
    {
        public function SQLUpdateErrorEvent(arg1:String, arg2:String, arg3:Boolean=false, arg4:Boolean=false)
        {
            super(arg1, arg3, arg4);
            message = arg2;
            return;
        }

        public static const EVENT_ERROR:String="sqlUpdateEventError";

        public var message:String="";
    }
}


//  class SQLUpdateEvent
package database.update 
{
    import flash.events.*;
    
    public class SQLUpdateEvent extends flash.events.Event
    {
        public function SQLUpdateEvent(arg1:String, arg2:Boolean=false, arg3:Boolean=false)
        {
            super(arg1, arg2, arg3);
            return;
        }

        public static const EXECUTED:String="executedEvent";

        public static const STATUS:String="statusEvent";

        public var maximum:Number;

        public var status:String;

        public var value:Number;
    }
}


//  class SQLUpdateHelper
package database.update 
{
    import database.*;
    import debug.*;
    import flash.data.*;
    import flash.errors.*;
    import flash.events.*;
    import flash.filesystem.*;
    import flash.net.*;
    import flash.utils.*;
    
    public class SQLUpdateHelper extends flash.events.EventDispatcher
    {
        public function SQLUpdateHelper(arg1:flash.filesystem.File, arg2:flash.utils.ByteArray=null, arg3:flash.events.IEventDispatcher=null)
        {
            super(arg3);
            _dbFile = arg1;
            _dbKey = arg2;
            openDBFile();
            return;
        }

        public function changeTablePrimaryKey(arg1:String, arg2:Array):void
        {
            var loc6:*=0;
            var loc5:*=null;
            var loc1:*=null;
            if (!_schemas) 
            {
                debug.Debug.database("changeTablePrimaryKey - wait for schemas loaded...");
                loadSchemas(true, arg1);
                flash.utils.setTimeout(changeTablePrimaryKey, _executeDelay, arg1, arg2);
                return;
            }
            loc1 = tableToUpdate.sql;
            var loc8:*;
            var loc3:*=(loc8 = loc1.slice(loc1.indexOf("(") + 1, loc1.lastIndexOf(")"))).split(",");
            var loc4:*=tableToUpdate.columns.length;
            var loc7:*=[];
            var loc2:*=[];
            loc6 = 0;
            while (loc6 < loc4) 
            {
                loc5 = loc3[loc6];
                loc7.push(loc5);
                loc2.push(loc5.match(new RegExp("\\w+"))[0]);
                ++loc6;
            }
            var loc9:*=0;
            try 
            {
                executeStatement("DROP TABLE backup");
                executeStatement("CREATE TABLE backup (" + loc7.join(",") + ", PRIMARY KEY (" + arg2.join(", ") + "));");
                executeStatement("INSERT INTO backup SELECT " + loc2.join(",") + " FROM " + tableToUpdate.name + ";");
                executeStatement("DROP TABLE " + tableToUpdate.name + ";");
                executeStatement("ALTER TABLE backup RENAME TO " + tableToUpdate.name);
            }
            catch (e:Error)
            {
                debug.Debug.error("changeTablePrimaryKey error: " + e.message);
                loc9 = 0;
            }
            catch (se:flash.errors.SQLError)
            {
                debug.Debug.error("changeTablePrimaryKey sql error: " + se.message);
                loc9 = 0;
            }
            finally
            {
                checkCompleteExecuted();
            }
            throw loc10;
            return;
        }

        public function renameOrRemoveColumns(arg1:String, arg2:Array):void
        {
            var loc7:*=0;
            var loc10:*=null;
            var loc9:*=0;
            var loc5:*=null;
            var loc15:*=null;
            var loc14:*=null;
            var loc18:*=false;
            var loc19:*=null;
            if (!_schemas) 
            {
                debug.Debug.database("renameOrRemoveColumns - wait for schemas loaded...");
                loadSchemas(true, arg1);
                flash.utils.setTimeout(renameOrRemoveColumns, _executeDelay, arg1, arg2);
                return;
            }
            loc10 = tableToUpdate.sql;
            var loc20:*;
            var loc11:*=(loc20 = loc10.slice(loc10.indexOf("(") + 1, loc10.lastIndexOf(")"))).split(",");
            var loc13:*=tableToUpdate.columns.length;
            var loc16:*=[];
            var loc1:*=[];
            loc7 = 0;
            while (loc7 < loc13) 
            {
                var loc4:*=(loc5 = loc11[loc7]).match(new RegExp("\\w+"))[0];
                var loc17:*=arg2.length;
                var loc6:*=false;
                loc9 = 0;
                while (loc9 < loc17) 
                {
                    loc15 = arg2[loc9][0];
                    var loc12:*=arg2[loc9][1];
                    var loc8:*=arg2[loc9][2];
                    var loc2:*=arg2[loc9][3];
                    var loc3:*=arg2[loc9][4] == true;
                    if (loc4 == loc15) 
                    {
                        loc6 = true;
                        if (loc12 != "") 
                        {
                            loc14 = new RegExp(loc15, "");
                            loc18 = (loc5 = loc5.replace(loc14, loc12)).indexOf(loc2) == -1 || loc8 == "BOOLEAN";
                            if (loc8 && loc2 && (loc18 || loc3)) 
                            {
                                loc19 = new RegExp(loc8, "");
                                loc5 = loc5.replace(loc19, loc2);
                            }
                            loc16.push(loc5);
                            loc1.push(loc15 + " AS " + loc12);
                        }
                        --loc9;
                    }
                    ++loc9;
                }
                if (!loc6) 
                {
                    loc16.push(loc5);
                    loc1.push(loc4);
                }
                ++loc7;
            }
            var loc21:*=0;
            try 
            {
                executeStatement("DROP TABLE backup");
                executeStatement("CREATE TABLE backup (" + loc16.join(",") + ");");
                executeStatement("INSERT INTO backup SELECT " + loc1.join(",") + " FROM " + tableToUpdate.name + ";");
                executeStatement("DROP TABLE " + tableToUpdate.name + ";");
                executeStatement("ALTER TABLE backup RENAME TO " + tableToUpdate.name);
            }
            catch (e:Error)
            {
                debug.Debug.error("renameOrRemoveColumns error: " + e.message);
                loc21 = 0;
            }
            catch (se:flash.errors.SQLError)
            {
                debug.Debug.error("renameOrRemoveColumns sql error: " + se.message);
                loc21 = 0;
            }
            finally
            {
                checkCompleteExecuted();
            }
            throw loc22;
            return;
        }

        public function checkStructure(arg1:Array):void
        {
            var loc5:*=0;
            var loc9:*=0;
            var loc4:*=null;
            var loc10:*=null;
            var loc1:*=null;
            var loc8:*=null;
            var loc11:*=null;
            if (!_schemas) 
            {
                debug.Debug.database("checkStructure - wait for schemas loaded...");
                loadSchemas(true);
                flash.utils.setTimeout(checkStructure, _executeDelay, arg1);
                return;
            }
            var loc13:*="CREATE TABLE";
            var loc7:*="CREATE INDEX";
            var loc6:*="CREATE TRIGGER";
            var loc3:*=[];
            var loc12:*=[];
            var loc14:*=[];
            while (arg1.length > 0) 
            {
                if (arg1[0] is database.DatabaseTable) 
                {
                    loc3.push(arg1[0]);
                }
                else if ((loc8 = (arg1[0] as String).replace("IF NOT EXISTS ", "")).indexOf(loc7) == -1) 
                {
                    if (loc8.indexOf(loc6) != -1) 
                    {
                        loc14.push(loc8);
                    }
                }
                else 
                {
                    loc12.push(loc8);
                }
                arg1.shift();
            }
            loc9 = dbTables.length;
            debug.Debug.database("\n################## checkStructure results ##################");
            loc5 = 0;
            while (loc5 < loc9) 
            {
                loc4 = dbTables[loc5] as flash.data.SQLTableSchema;
                if (!isValidTable(loc4, loc3)) 
                {
                    return;
                }
                debug.Debug.database("valid table definition: " + loc4.name);
                ++loc5;
            }
            loc9 = dbIndices.length;
            loc5 = 0;
            while (loc5 < loc9) 
            {
                loc10 = dbIndices[loc5] as flash.data.SQLIndexSchema;
                if (loc12.indexOf(loc10.sql) == -1) 
                {
                    debug.Debug.database("invalid index definition: " + loc10.sql);
                    debug.Debug.database("current valid index definitions: \n- " + loc12.join("\n- "));
                    dispatchEvent(new database.update.SQLUpdateErrorEvent("sqlUpdateEventError", "invalid index: " + loc10.sql));
                    return;
                }
                debug.Debug.database("valid index definition: " + loc10.sql);
                ++loc5;
            }
            loc9 = dbTriggers.length;
            loc5 = 0;
            while (loc5 < loc9) 
            {
                loc1 = dbTriggers[loc5] as flash.data.SQLTriggerSchema;
                if (loc14.indexOf(loc1.sql) == -1) 
                {
                    debug.Debug.database("invalid trigger definition: " + loc1.sql);
                    debug.Debug.database("current valid trigger definitions: \n- " + loc14.join("\n- "));
                    dispatchEvent(new database.update.SQLUpdateErrorEvent("sqlUpdateEventError", "invalid trigger: " + loc1.sql));
                    return;
                }
                debug.Debug.database("valid trigger definition: " + loc1.sql);
                ++loc5;
            }
            var loc2:*="";
            if (loc3.length != dbTables.length) 
            {
                loc2 = loc2 + ("\ninvalid number of tables - in database: " + dbTables.length + "/ in definition: " + loc3.length);
            }
            if (loc12.length != dbIndices.length) 
            {
                loc2 = loc2 + ("\ninvalid number of indices - in database: " + dbIndices.length + "/ in definition: " + loc12.length);
            }
            if (loc14.length != dbTriggers.length) 
            {
                loc2 = loc2 + ("\ninvalid number of triggers - in database: " + dbTriggers.length + "/ in definition: " + loc14.length);
            }
            if (loc2 != "") 
            {
                debug.Debug.database(loc2);
                dispatchEvent(new database.update.SQLUpdateErrorEvent("sqlUpdateEventError", loc2));
                return;
            }
            debug.Debug.debug("check structure complete");
            dispatchEvent(new flash.events.Event("executedEvent"));
            return;
        }

        internal function isValidTable(arg1:flash.data.SQLTableSchema, arg2:Array):Boolean
        {
            var loc8:*=null;
            var loc5:*=0;
            var loc6:*=0;
            var loc7:*=null;
            var loc3:*=null;
            var loc9:*=null;
            var loc4:*=0;
            var loc10:*=null;
            var loc1:*=arg2.length;
            var loc2:*="";
            loc4 = 0;
            while (loc4 < loc1) 
            {
                if ((loc8 = arg2[loc4]).tableName == arg1.name) 
                {
                    if (loc8.columns.length != arg1.columns.length) 
                    {
                        loc2 = loc2 + ("invalid number of columns in " + loc8.tableName + "\n\n");
                    }
                    loc6 = loc8.columns.length;
                    loc10 = new flash.utils.Dictionary();
                    loc5 = 0;
                    while (loc5 < arg1.columns.length) 
                    {
                        loc10[arg1.columns[loc5].name] = arg1.columns[loc5];
                        ++loc5;
                    }
                    loc5 = 0;
                    while (loc5 < loc6) 
                    {
                        loc7 = loc8.columns[loc5];
                        if (!(arg1.columns.length <= loc5)) 
                        {
                            loc3 = loc10[loc7.columnName];
                            loc9 = "";
                            if (loc3) 
                            {
                                if (loc7.columnName == loc3.name) 
                                {
                                    if (loc7.allowNull == loc3.allowNull) 
                                    {
                                        if (loc7.autoIncrement == loc3.autoIncrement) 
                                        {
                                            if (loc7.columnType.indexOf(loc3.dataType) != -1) 
                                            {
                                                if (loc7.primaryKey != loc3.primaryKey) 
                                                {
                                                    loc9 = loc9 + "[primaryKey]";
                                                }
                                            }
                                            else 
                                            {
                                                loc9 = loc9 + ("[columnType: " + loc7.columnType + " - " + loc3.dataType + "]");
                                            }
                                        }
                                        else 
                                        {
                                            loc9 = loc9 + "[autoIncrement]";
                                        }
                                    }
                                    else 
                                    {
                                        loc9 = loc9 + "[allowNull]";
                                    }
                                }
                                else 
                                {
                                    loc9 = loc9 + ("[columnName: " + loc7.columnName + " - " + loc3.name + "]");
                                }
                            }
                            else 
                            {
                                loc9 = loc9 + ("[column: " + loc7.columnName + " - not exist]");
                            }
                            if (loc9 != "") 
                            {
                                loc9 = "invalid column \'" + loc7.columnName + "\' in table \'" + arg1.name + "\'\n" + loc9;
                                if (loc5 > 0) 
                                {
                                    loc2 = loc2 + "\n\n";
                                }
                                loc2 = loc2 + loc9;
                            }
                        }
                        ++loc5;
                    }
                    if (loc2 != "") 
                    {
                        dispatchEvent(new database.update.SQLUpdateErrorEvent("sqlUpdateEventError", loc2));
                        return false;
                    }
                    return true;
                }
                ++loc4;
            }
            return false;
        }

        public function addColumns(arg1:String, arg2:Array):void
        {
            var loc4:*=0;
            var loc2:*=null;
            var loc3:*=null;
            var loc5:*=null;
            if (!_schemas) 
            {
                debug.Debug.database("addColumns - wait for schemas loaded...");
                loadSchemas(true, arg1);
                flash.utils.setTimeout(addColumns, _executeDelay, arg1, arg2);
                return;
            }
            var loc1:*=arg2.length;
            var loc6:*=[];
            loc4 = 0;
            while (loc4 < loc1) 
            {
                loc3 = (loc2 = arg2[loc4] as Array)[0];
                loc5 = loc2[1];
                if (!loc2[2]) 
                {
                    loc5 = loc5 + " NOT NULL";
                }
                if (loc2[3]) 
                {
                    loc5 = loc5 + " UNIQUE";
                }
                if (loc2[4] != "") 
                {
                    loc5 = loc5 + (" DEFAULT " + loc2[4]);
                }
                try 
                {
                    executeStatement("ALTER TABLE " + tableToUpdate.name + " ADD " + loc3 + " " + loc5);
                }
                catch (e:Error)
                {
                    debug.Debug.error("addColumns error: " + e.message);
                }
                catch (se:flash.errors.SQLError)
                {
                    debug.Debug.error("addColumns sql error: " + se.message);
                }
                ++loc4;
            }
            checkCompleteExecuted();
            return;
        }

        public function addColumn(arg1:String, arg2:String, arg3:String, arg4:Boolean=true, arg5:Boolean=false, arg6:String=""):void
        {
            if (!_schemas) 
            {
                debug.Debug.database("addColumn - wait for schemas loaded...");
                loadSchemas(true, arg1);
                flash.utils.setTimeout(addColumn, _executeDelay, arg1, arg2, arg3, arg4, arg5, arg6);
                return;
            }
            var loc1:*=arg3;
            if (!arg4) 
            {
                loc1 = loc1 + " NOT NULL";
            }
            if (arg5) 
            {
                loc1 = loc1 + " UNIQUE";
            }
            if (arg6 != "") 
            {
                loc1 = loc1 + (" DEFAULT " + arg6);
            }
            var loc2:*=0;
            try 
            {
                executeStatement("ALTER TABLE " + tableToUpdate.name + " ADD " + arg2 + " " + loc1);
            }
            catch (e:Error)
            {
                debug.Debug.error("addColumn error: " + e.message);
                loc2 = 0;
            }
            catch (se:flash.errors.SQLError)
            {
                debug.Debug.error("addColumn sql error: " + se.message);
                loc2 = 0;
            }
            finally
            {
                checkCompleteExecuted();
            }
            throw loc3;
            return;
        }

        public function updateTrigger(arg1:String="", arg2:String=""):void
        {
            if (!_schemas) 
            {
                debug.Debug.database("updateTrigger - wait for schemas loaded...");
                loadSchemas(true, "");
                flash.utils.setTimeout(updateTrigger, _executeDelay, arg1, arg2);
                return;
            }
            var loc1:*=0;
            try 
            {
                if (arg1 != "") 
                {
                    executeStatement("DROP TRIGGER IF EXISTS " + arg1);
                }
                executeStatement(arg2);
            }
            catch (e:Error)
            {
                debug.Debug.error("updateTrigger error: " + e.message);
                loc1 = 0;
            }
            catch (se:flash.errors.SQLError)
            {
                debug.Debug.error("updateTrigger sql error: " + se.message);
                loc1 = 0;
            }
            finally
            {
                checkCompleteExecuted();
            }
            throw loc2;
            return;
        }

        public function updateIndizes(arg1:Array):void
        {
            var loc2:*=0;
            var loc3:*=0;
            try 
            {
                var loc1:*=arg1.length;
                loc2 = 0;
                while (loc2 < loc1) 
                {
                    executeStatement(arg1[loc2]);
                    ++loc2;
                }
            }
            catch (e:Error)
            {
                debug.Debug.error("updateIndizes error: " + e.message);
                loc3 = 0;
            }
            catch (se:flash.errors.SQLError)
            {
                debug.Debug.error("updateIndizes sqlerror: " + se.message);
                loc3 = 0;
            }
            finally
            {
                checkCompleteExecuted();
            }
            throw loc4;
            return;
        }

        public function updateRows(arg1:String, arg2:Array):void
        {
            var loc2:*=0;
            if (!_schemas) 
            {
                debug.Debug.database("updateRows - wait for schemas loaded...");
                loadSchemas(true, arg1);
                flash.utils.setTimeout(updateRows, _executeDelay, arg1, arg2);
                return;
            }
            var loc3:*=0;
            try 
            {
                var loc1:*=arg2.length;
                loc2 = 0;
                while (loc2 < loc1) 
                {
                    executeStatement(arg2[loc2] as String);
                    ++loc2;
                }
            }
            catch (e:Error)
            {
                debug.Debug.error("updateRows error: " + e.message);
                loc3 = 0;
            }
            catch (se:flash.errors.SQLError)
            {
                debug.Debug.error("updateRows sql error: " + se.message);
                loc3 = 0;
            }
            finally
            {
                checkCompleteExecuted();
            }
            throw loc4;
            return;
        }

        public function compact():void
        {
            if (_cnx.inTransaction) 
            {
                debug.Debug.database("cnx in transaction - compact later...");
                flash.utils.setTimeout(compact, _executeDelay);
                return;
            }
            try 
            {
                _cnx.compact(new flash.net.Responder(onCompactResult));
            }
            catch (error:Error)
            {
                debug.Debug.error("compact error: " + error.message);
                dispatchEvent(new database.update.SQLUpdateErrorEvent("sqlUpdateEventError", "compact error: " + error.message));
            }
            catch (se:flash.errors.SQLError)
            {
                debug.Debug.error("compact sql error: " + se.message);
            }
            return;
        }

        internal function onCompactResult(arg1:flash.events.SQLEvent):void
        {
            checkCompleteExecuted();
            return;
        }

        internal function checkCompleteExecuted():void
        {
            if (_cnx.inTransaction) 
            {
                debug.Debug.database("cnx in transaction...");
                flash.utils.setTimeout(checkCompleteExecuted, _executeDelay);
            }
            else 
            {
                _schemas = null;
                dispatchEvent(new flash.events.Event("executedEvent"));
            }
            return;
        }

        internal function openDBFile():void
        {
            _cnx = new flash.data.SQLConnection();
            try 
            {
                _cnx.openAsync(_dbFile, "create", new flash.net.Responder(onConnectionResult, onConnectionError), true, 1024, _dbKey);
            }
            catch (error:flash.errors.SQLError)
            {
                debug.Debug.error("openDBFile error: " + error.message);
                dispatchEvent(new database.update.SQLUpdateErrorEvent("sqlUpdateEventError", "open db error: " + error.message));
            }
            return;
        }

        internal function onConnectionResult(arg1:flash.events.SQLEvent):void
        {
            _dbOpened = true;
            return;
        }

        internal function onConnectionError(arg1:flash.events.SQLErrorEvent):void
        {
            _dbOpened = false;
            return;
        }

        internal function loadSchemas(arg1:Boolean=false, arg2:String=""):void
        {
            if (!_dbOpened) 
            {
                debug.Debug.database("cnx not connected...");
                flash.utils.setTimeout(loadSchemas, _executeDelay, arg1, arg2);
                return;
            }
            try 
            {
                _cnx.loadSchema();
            }
            catch (error:flash.errors.SQLError)
            {
                debug.Debug.error("loadSchemas error: " + error.message);
                dispatchEvent(new database.update.SQLUpdateErrorEvent("sqlUpdateEventError", "load schema error: " + error.message));
                return;
            }
            _schemas = _cnx.getSchemaResult();
            if (!_schemas) 
            {
                debug.Debug.error("ERROR: schemas is null");
                return;
            }
            dbTables = _schemas.tables;
            dbIndices = _schemas.indices;
            dbTriggers = _schemas.triggers;
            if (dbTables) 
            {
                dbTables.sortOn("name", 1);
            }
            if (dbIndices) 
            {
                dbIndices.sort(sortIndices);
            }
            if (arg2 != "") 
            {
                validateTable(arg2);
            }
            return;
        }

        public function dispose():void
        {
            if (!_cnx) 
            {
                return;
            }
            try 
            {
                _cnx.close();
                _dbOpened = false;
            }
            catch (error:flash.errors.SQLError)
            {
                debug.Debug.error("dispose error: " + error.message);
                dispatchEvent(new database.update.SQLUpdateErrorEvent("sqlUpdateEventError", "close db error: " + error.message));
            }
            return;
        }

        internal function sortIndices(arg1:flash.data.SQLIndexSchema, arg2:flash.data.SQLIndexSchema):Number
        {
            var loc4:*=arg1.table.toLowerCase();
            var loc1:*=arg2.table.toLowerCase();
            if (loc4 < loc1) 
            {
                return -1;
            }
            if (loc4 > loc1) 
            {
                return 1;
            }
            var loc3:*=arg1.name.toLowerCase();
            var loc2:*=arg2.name.toLowerCase();
            if (loc3 < loc2) 
            {
                return -1;
            }
            if (loc3 > loc2) 
            {
                return 1;
            }
            return 0;
        }

        internal function validateTable(arg1:String):Boolean
        {
            var loc2:*=0;
            var loc1:*=dbTables.length;
            loc2 = 0;
            while (loc2 < loc1) 
            {
                if ((dbTables[loc2] as flash.data.SQLTableSchema).name == arg1) 
                {
                    tableToUpdate = dbTables[loc2] as flash.data.SQLTableSchema;
                    return true;
                }
                ++loc2;
            }
            return false;
        }

        public function executeStatement(arg1:String, arg2:Object=null):flash.data.SQLResult
        {
            debug.Debug.database("executeStatement: " + arg1);
            var loc2:*=flash.utils.getTimer();
            var loc4:*;
            (loc4 = new flash.data.SQLStatement()).sqlConnection = _cnx;
            loc4.text = arg1;
            loc4.addEventListener("error", onSQLErrorEvent);
            if (arg2) 
            {
                var loc6:*=0;
                var loc5:*=arg2;
                for (var loc1:* in loc5) 
                {
                    loc4.parameters[loc1] = arg2[loc1];
                }
            }
            try 
            {
                loc4.execute();
            }
            catch (error:flash.errors.SQLError)
            {
                debug.Debug.error("executeStatement SQLError: " + error.message);
            }
            catch (error:Error)
            {
                debug.Debug.error("executeStatement Error: " + error.message);
            }
            lastExecutionTime = flash.utils.getTimer() - loc2;
            var loc3:*=loc4.getResult();
            flash.utils.setTimeout(removeSQLStmtEvents, 1000, loc4);
            return loc3;
        }

        internal function removeSQLStmtEvents(arg1:flash.data.SQLStatement):void
        {
            arg1.removeEventListener("error", onSQLErrorEvent);
            arg1.clearParameters();
            arg1 = null;
            return;
        }

        internal function onSQLErrorEvent(arg1:flash.events.SQLErrorEvent):void
        {
            debug.Debug.error("onSQLErrorEvent: " + arg1.text);
            return;
        }

        public function createTable(arg1:database.DatabaseTable):void
        {
            if (!_schemas) 
            {
                debug.Debug.database("createTable - wait for schemas loaded...");
                loadSchemas(true, arg1.tableName);
                flash.utils.setTimeout(createTable, _executeDelay, arg1);
                return;
            }
            var loc1:*=0;
            try 
            {
                executeStatement(arg1.createTableStatement());
            }
            catch (e:Error)
            {
                debug.Debug.error("createTable error: " + e.message);
                loc1 = 0;
            }
            catch (se:flash.errors.SQLError)
            {
                debug.Debug.error("createTable sql error: " + se.message);
                loc1 = 0;
            }
            finally
            {
                checkCompleteExecuted();
            }
            throw loc2;
            return;
        }

        public var columnToUpdate:flash.data.SQLColumnSchema;

        public var dbIndices:Array;

        public var dbTables:Array;

        public var dbTriggers:Array;

        public var lastExecutionTime:int=0;

        public var tableRecords:Array;

        public var tableToUpdate:flash.data.SQLTableSchema;

        internal var _cnx:flash.data.SQLConnection;

        internal var _dbFile:flash.filesystem.File;

        internal var _dbKey:flash.utils.ByteArray;

        internal var _dbOpened:Boolean=false;

        internal var _schemas:flash.data.SQLSchemaResult;

        internal static var _executeDelay:uint=500;
    }
}


