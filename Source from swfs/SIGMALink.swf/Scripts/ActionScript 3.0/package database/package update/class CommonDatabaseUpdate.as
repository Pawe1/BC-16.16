//class CommonDatabaseUpdate
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


