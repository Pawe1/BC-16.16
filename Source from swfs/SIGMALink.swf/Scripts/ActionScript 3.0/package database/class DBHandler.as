//class DBHandler
package database 
{
    import avmplus.*;
    import com.logging.*;
    import debug.*;
    import flash.data.*;
    import flash.errors.*;
    import flash.events.*;
    import flash.filesystem.*;
    import flash.utils.*;
    import mx.events.*;
    import utils.*;
    
    public class DBHandler extends database.DatabaseHandlerCommon
    {
        public function DBHandler()
        {
            super();
            com.logging.ErrorLogging.getInstance().addTarget(this);
            connection = new flash.data.SQLConnection();
            connection.addEventListener("commit", commitStatementsComplete);
            connection.addEventListener("close", closeConnectionComplete);
            connection.addEventListener("open", openConnectionComplete);
            connection.addEventListener("begin", onSQLTransactionBegin);
            connection.addEventListener("compact", onCompact);
            connection.addEventListener("error", onSQLError);
            return;
        }

        public function get openCreateTransactions():uint
        {
            return _openCreatTransactions;
        }

        public function set openCreateTransactions(arg1:uint):void
        {
            _openCreatTransactions = arg1;
            return;
        }

        protected function tablesToCreateInNewDatabase():Array
        {
            return null;
        }

        public function get openReadTransactions():uint
        {
            return _openReadTransactions;
        }

        public function set openReadTransactions(arg1:uint):void
        {
            _openReadTransactions = arg1;
            return;
        }

        internal function onSQLTransactionBegin(arg1:flash.events.Event=null):void
        {
            addLogText("on transaction begin - inTransaction:" + connection.inTransaction);
            if (arg1) 
            {
                addLogText(arg1.toString());
            }
            if (_currentMode != "read") 
            {
                if (_currentMode != "update") 
                {
                    if (_currentMode == "create") 
                    {
                        dispatchEvent(new flash.events.Event("databaseForCreateConnected"));
                    }
                }
                else 
                {
                    dispatchEvent(new flash.events.Event("databaseForUpdateConnected"));
                }
            }
            else 
            {
                dispatchEvent(new flash.events.Event("databaseForReadConnected"));
            }
            return;
        }

        internal function onCompact(arg1:flash.events.SQLEvent):void
        {
            addLogText("connection compacted");
            connection.close();
            return;
        }

        public function get openUpdateTransactions():uint
        {
            return _openUpdateTransactions;
        }

        public function set openUpdateTransactions(arg1:uint):void
        {
            _openUpdateTransactions = arg1;
            return;
        }

        internal function onConnectedCreateTable(arg1:flash.events.Event):void
        {
            var loc3:*=null;
            removeEventListener("databaseForCreateConnected", onConnectedCreateTable);
            var loc2:*=tablesToCreateInNewDatabase();
            tablesToCreate = loc2.length;
            var loc7:*=0;
            var loc6:*=loc2;
            for each (var loc1:* in loc6) 
            {
                (loc3 = new flash.data.SQLStatement()).sqlConnection = connection;
                loc3.text = loc1;
                loc3.addEventListener("result", createNewDatabaseComplete);
                loc3.addEventListener("error", createNewDatabaseError);
            }
            return;
        }

        internal function createNewDatabaseComplete(arg1:flash.events.SQLEvent):void
        {
            (arg1.target as flash.data.SQLStatement).removeEventListener("result", createNewDatabaseComplete);
            --tablesToCreate;
            if (tablesToCreate == 0) 
            {
                addEventListener("databaseDisconnected", createNewDatabaseCommit);
                commit();
            }
            return;
        }

        public function set toCompact(arg1:Boolean):void
        {
            _toCompact = arg1;
            return;
        }

        internal function createNewDatabaseCommit(arg1:flash.events.Event):void
        {
            removeEventListener("databaseDisconnected", createNewDatabaseCommit);
            dispatchEvent(new com.logging.ErrorLoggingEvent("loggingInfoEvent", 1, "database created: " + dataBase.nativePath));
            dispatchEvent(new flash.events.Event("databaseExist"));
            return;
        }

        internal function createNewDatabaseError(arg1:flash.events.SQLErrorEvent):void
        {
            (arg1.target as flash.data.SQLStatement).removeEventListener("error", createNewDatabaseError);
            return;
        }

        internal function loadSchema():void
        {
            var loc4:*=null;
            var loc2:*=new flash.data.SQLStatement();
            loc2.sqlConnection = database.DBHandler.getInstance().connection;
            try 
            {
                loc2.sqlConnection.loadSchema();
            }
            catch (error:Error)
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 1000035, "DatabaseBackup > : " + error.toString()));
                database.DBHandler.getInstance().close();
                dispatchEvent(new flash.events.Event("databaseCorrupt"));
                return;
            }
            var loc1:*=loc2.sqlConnection.getSchemaResult();
            var loc10:*=0;
            var loc9:*=loc1.tables;
            for each (var loc3:* in loc9) 
            {
                (loc4 = new database.DCSQLStatement()).sqlConnection = database.DBHandler.getInstance().connection;
                loc4.data = loc3.name;
                loc4.text = "select count(*) as rowCounter from " + loc3.name;
            }
            database.DBHandler.getInstance().close();
            dispatchEvent(new flash.events.Event("databaseOk"));
            return;
        }

        
        {
            trialCounterFromStatusTable = 0;
            DBHandler._bindingEventDispatcher = new flash.events.EventDispatcher();
        }

        public static function get trialCounterFromStatusTable():int
        {
            return DBHandler.trialCounterFromStatusTable;
        }

        public static function set trialCounterFromStatusTable(arg1:int):void
        {
            var loc1:*=DBHandler.trialCounterFromStatusTable;
            if (loc1 !== arg1) 
            {
                DBHandler.trialCounterFromStatusTable = arg1;
                if (DBHandler._bindingEventDispatcher.hasEventListener("propertyChange")) 
                {
                    DBHandler._bindingEventDispatcher.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(DBHandler, "trialCounterFromStatusTable", loc1, arg1));
                }
            }
            return;
        }

        public static function getInstance():database.DBHandler
        {
            if (!_instance) 
            {
                _instance = new DBHandler();
                database.DatabaseHandlerCommon.setInstance(_instance);
            }
            return _instance;
        }

        public static function setInstance(arg1:database.DBHandler):void
        {
            _instance = arg1;
            database.DatabaseHandlerCommon.setInstance(_instance);
            return;
        }

        public static function get staticEventDispatcher():flash.events.IEventDispatcher
        {
            return DBHandler._bindingEventDispatcher;
        }

        public function checkDataCurrentDatabaseFile(arg1:flash.filesystem.File):Boolean
        {
            if (!(arg1 == null) && arg1.exists) 
            {
                return true;
            }
            return false;
        }

        public function validateDatabase():void
        {
            return;
        }

        public function isDemo():Boolean
        {
            return false;
        }

        public override function open(arg1:String, arg2:Boolean=false):void
        {
            var loc1:*=null;
            var loc2:*=arg1;
            while ("read" === loc2) 
            {
                if (_openReadTimeoutCounter > 0 && _currentMode == "") 
                {
                    openReadTransactions = _openReadTimeoutCounter;
                    _openReadTimeoutCounter = 0;
                }
                else if (!arg2) 
                {
                    ++openReadTransactions;
                }
            }
        }

        public override function close():void
        {
            addLogText("close()");
            if (connection.connected) 
            {
                try 
                {
                    if (connection.inTransaction) 
                    {
                        connection.rollback();
                    }
                    openCreateTransactions = openReadTransactions = openUpdateTransactions = 0;
                }
                catch (error:Error)
                {
                    addLogText("close error: " + error.message);
                }
            }
            connection.close();
            return;
        }

        public function openConnectionComplete(arg1:flash.events.SQLEvent=null):void
        {
            addLogText("connection opened");
            try 
            {
                addLogText("try begin transaction - inTransaction:" + connection.inTransaction);
                if (connection.inTransaction) 
                {
                    onSQLTransactionBegin();
                }
                else 
                {
                    connection.begin("deferred");
                }
            }
            catch (error:Error)
            {
                addLogText("begin transaction error (errorID: " + error.errorID + ", message: " + error.message + ")");
                if (error.errorID != 3115) 
                {
                    if (_currentMode != "read") 
                    {
                        if (_currentMode != "update") 
                        {
                            if (_currentMode == "create") 
                            {
                                --openCreateTransactions;
                            }
                        }
                        else 
                        {
                            --openUpdateTransactions;
                        }
                    }
                    else 
                    {
                        --openReadTransactions;
                    }
                    addLogText("open later (500 ms)");
                    flash.utils.setTimeout(open, 500, _currentMode);
                }
                else 
                {
                    addLogText("dispatch connection ready");
                    onSQLTransactionBegin();
                }
            }
            return;
        }

        public function onSQLError(arg1:flash.events.SQLErrorEvent):void
        {
            addLogText("onSQLError: errorID = " + arg1.error.errorID + ", operation = " + arg1.error.operation + ", message = " + arg1.error.message);
            if (arg1.error.operation == "open" && arg1.error.errorID == 3119) 
            {
                if (_currentMode != "read") 
                {
                    if (_currentMode != "update") 
                    {
                        if (_currentMode == "create") 
                        {
                            --openCreateTransactions;
                        }
                    }
                    else 
                    {
                        --openUpdateTransactions;
                    }
                }
                else 
                {
                    --openReadTransactions;
                }
                addLogText("try to open later (1000 ms)");
                flash.utils.setTimeout(open, 1000, _currentMode);
            }
            else if (arg1.error.operation == "commit" && arg1.error.errorID == 3119) 
            {
                if (_currentMode != "read") 
                {
                    if (_currentMode != "update") 
                    {
                        if (_currentMode == "create") 
                        {
                            ++openCreateTransactions;
                        }
                    }
                    else 
                    {
                        ++openUpdateTransactions;
                    }
                }
                else 
                {
                    ++openReadTransactions;
                }
                addLogText("try to commit later (1000 ms)");
                flash.utils.setTimeout(commit, 1000);
            }
            else 
            {
                if (connection.connected) 
                {
                    try 
                    {
                        addLogText("rollback");
                        connection.rollback();
                    }
                    catch (error:Error)
                    {
                        addLogText("rollback error: " + error.errorID + ", msg: " + error.message);
                    }
                    addLogText("close connection");
                    connection.close();
                }
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 1000000, "DatabaseHandler > openConnectionError: database not connected" + arg1.text + ", details: " + arg1.error.details));
            }
            return;
        }

        public override function commit(arg1:Boolean=false, arg2:Boolean=false):void
        {
            if (_currentMode != "read") 
            {
                if (_currentMode != "update") 
                {
                    if (_currentMode == "create") 
                    {
                        --openCreateTransactions;
                    }
                }
                else 
                {
                    --openUpdateTransactions;
                }
            }
            else 
            {
                --openReadTransactions;
            }
            addLogText("connection commit - fromTimer: " + arg2);
            if (_currentMode == "read" && openReadTransactions == 0 || _currentMode == "update" && openUpdateTransactions == 0 || _currentMode == "create" && openCreateTransactions == 0) 
            {
                try 
                {
                    if (connection.inTransaction) 
                    {
                        connection.commit();
                    }
                    else 
                    {
                        connection.close();
                    }
                }
                catch (error:Error)
                {
                    addLogText("connection commit error: " + error.message);
                    if (error.errorID != 3119) 
                    {
                        if (error is flash.errors.SQLError) 
                        {
                            connection.dispatchEvent(new flash.events.SQLErrorEvent("error", false, false, error as flash.errors.SQLError));
                        }
                    }
                    else 
                    {
                        if (_currentMode != "read") 
                        {
                            if (_currentMode != "update") 
                            {
                                if (_currentMode == "create") 
                                {
                                    ++openCreateTransactions;
                                }
                            }
                            else 
                            {
                                ++openUpdateTransactions;
                            }
                        }
                        else 
                        {
                            ++openReadTransactions;
                        }
                        addLogText("try to commit later (250 ms)");
                        flash.utils.setTimeout(commit, 250, arg1, true);
                    }
                }
            }
            else 
            {
                addLogText("open transactions after commit");
            }
            return;
        }

        public function commitStatementsComplete(arg1:flash.events.SQLEvent):void
        {
            addLogText("transaction commited");
            _currentMode == "";
            dispatchEvent(new flash.events.Event("databaseCommited"));
            try 
            {
                if (_toCompact) 
                {
                    connection.compact();
                }
                else 
                {
                    connection.close();
                }
            }
            catch (error:Error)
            {
                addLogText("close or compact after commit error: " + error.message);
                if (error is flash.errors.SQLError) 
                {
                    connection.dispatchEvent(new flash.events.SQLErrorEvent("error", false, false, error as flash.errors.SQLError));
                }
            }
            return;
        }

        public function closeConnectionComplete(arg1:flash.events.SQLEvent):void
        {
            var loc1:*=null;
            addLogText("connection closed");
            try 
            {
                if (openReadTransactions > 0) 
                {
                    loc1 = new utils.Base64Decoder();
                    loc1.decode(myDecoderPwd);
                    connection.open(dataBase, "read", false, 1024, loc1.toByteArray());
                    _currentMode = "read";
                    addLogText("closeConnectionComplete > open for read ???? ####################");
                }
                else if (openUpdateTransactions > 0) 
                {
                    loc1 = new utils.Base64Decoder();
                    loc1.decode(myDecoderPwd);
                    connection.open(dataBase, "update", false, 1024, loc1.toByteArray());
                    _currentMode = "update";
                    addLogText("closeConnectionComplete > open for update ???? ####################");
                }
                else if (openCreateTransactions > 0) 
                {
                    loc1 = new utils.Base64Decoder();
                    loc1.decode(myDecoderPwd);
                    connection.open(dataBase, "create", false, 1024, loc1.toByteArray());
                    _currentMode = "create";
                    addLogText("closeConnectionComplete > open for create ???? ####################");
                }
                else 
                {
                    _currentMode = "";
                }
            }
            catch (error:flash.errors.SQLError)
            {
                connection.dispatchEvent(new flash.events.SQLErrorEvent("error", false, false, error));
            }
            dispatchEvent(new flash.events.Event("databaseDisconnected"));
            return;
        }

        public function checkDatabaseSchema():void
        {
            new database.DatabaseTransaction(loadSchema, [], "read").commit();
            return;
        }

        protected function addLogText(arg1:String):void
        {
            debug.Debug.database("class: " + avmplus.getQualifiedClassName(this) + "\topen transactions: READ: " + openReadTransactions + "\tUPDATE: " + openUpdateTransactions + "\tCREATE: " + openCreateTransactions + "\tcurrentMode: " + (_currentMode != "" ? _currentMode : "\t") + "\tmsg: " + arg1);
            return;
        }

        protected final function databaseIOError(arg1:flash.events.IOErrorEvent):void
        {
            dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 1000030, "DatabaseHandler:" + arg1.text + " - Error Type:" + arg1.type + " - Error ID:" + arg1.errorID));
            return;
        }

        protected final function databaseSecurityError(arg1:flash.events.SecurityErrorEvent):void
        {
            dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 1000031, "DatabaseHandler:" + arg1.text + " - Error Type:" + arg1.type + " - Error ID:" + arg1.errorID));
            return;
        }

        protected function createNewDatabase(arg1:flash.filesystem.File):void
        {
            addEventListener("databaseForCreateConnected", onConnectedCreateTable);
            try 
            {
                open("create");
                addLogText("database created: " + _currentMode);
            }
            catch (error:flash.errors.SQLError)
            {
                addLogText("database create error: " + error.message);
                connection.dispatchEvent(new flash.events.SQLErrorEvent("error", false, false, error));
            }
            return;
        }

        public static const DATABASE_FOR_UPDATE_CONNECTED:String="databaseForUpdateConnected";

        public static const DATABASE_NOT_EXIST:String="databaseNotExist";

        public static const DATABASE_FOR_CREATE_CONNECTED:String="databaseForCreateConnected";

        public static const DATABASE_FOR_READ_CONNECTED:String="databaseForReadConnected";

        public static const DATABASE_VALIDATED:String="databaseValidatedEvent";

        public static const DATABASE_OK:String="databaseOk";

        public static const DATABASE_COMMITED:String="databaseCommited";

        public static const DATABASE_CONNECTED:String="databaseConnected";

        public static const DATABASE_CORRUPT:String="databaseCorrupt";

        public static const DATABASE_DISCONNECTED:String="databaseDisconnected";

        public static const DATABASE_EXIST:String="databaseExist";

        internal var _currentMode:String="";

        internal var _openCreatTransactions:uint;

        internal var _openCreateTimeoutCounter:int=0;

        internal var _openReadTimeoutCounter:int=0;

        internal var _openTimeout:uint=0;

        internal var _openUpdateTimeoutCounter:int=0;

        internal var _tempMode:String;

        public static var CONFIG_PATH:String="config/dcConfig";

        internal var _openReadTransactions:uint;

        public static var licenceNumberAccepted:String="0.0";

        public static var myDecoderPwd:String="J6voPJaQjsq3srBZw7pBQA==";

        public static var showActivateView:Boolean=false;

        public static var showLicenceTextView:Boolean=false;

        public static var showUpdateView:Boolean=false;

        public static var skipActivationCheck:Boolean=false;

        public static var skipDatabaseUpdate:Boolean=false;

        public var openTransactions:uint=0;

        internal static var trialCounterFromStatusTable:int;

        internal var _openUpdateTransactions:uint;

        public var tablesToCreate:uint=0;

        internal static var _instance:database.DBHandler;

        internal var _toCompact:Boolean=false;

        protected var dbName:String="";

        internal static var _bindingEventDispatcher:flash.events.EventDispatcher;

        internal var _connection:flash.data.SQLConnection;

        public static var skipLicenceCheck:Boolean=false;
    }
}


