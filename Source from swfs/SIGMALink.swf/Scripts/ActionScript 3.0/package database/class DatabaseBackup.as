//class DatabaseBackup
package database 
{
    import flash.events.*;
    import flash.filesystem.*;
    
    public class DatabaseBackup extends flash.events.EventDispatcher
    {
        public function DatabaseBackup()
        {
            super();
            return;
        }

        public function checkDatabase(arg1:database.Database, arg2:Boolean):void
        {
            if (arg1.file == null) 
            {
                return;
            }
            _createBackup = arg2;
            _backupFileName = "BACKUP_" + arg1.name;
            db = arg1;
            db.addEventListener("databaseCorrupt", onDBCorrupt);
            db.addEventListener("databaseOk", onDBOk);
            db.checkDatabaseSchema();
            return;
        }

        internal function onDBCorrupt(arg1:flash.events.Event):void
        {
            db.removeEventListener("databaseCorrupt", onDBCorrupt);
            db.removeEventListener("databaseOk", onDBOk);
            return;
        }

        internal function onDBOk(arg1:flash.events.Event):void
        {
            var loc1:*=null;
            db.removeEventListener("databaseCorrupt", onDBCorrupt);
            db.removeEventListener("databaseOk", onDBOk);
            if (_createBackup) 
            {
                loc1 = db.workDirectory.resolvePath(_backupFileName);
                db.file.copyTo(loc1, true);
                dispatchEvent(new flash.events.Event("backupComplete"));
            }
            dispatchEvent(new flash.events.Event("databaseOkay"));
            return;
        }

        public function backupFileExist():Boolean
        {
            var loc1:*=flash.filesystem.File.applicationStorageDirectory.resolvePath(_backupFileName);
            return loc1.exists;
        }

        public static function getInstance():database.DatabaseBackup
        {
            if (_instance == null) 
            {
                _instance = new DatabaseBackup();
            }
            return _instance;
        }

        public static function dispose():void
        {
            if (_instance != null) 
            {
                _instance = null;
            }
            return;
        }

        public static const BACKUP_COMPLETE:String="backupComplete";

        public static const DATABASE_CORRUPT:String="databaseCorrupt";

        public static const DATABASE_OKAY:String="databaseOkay";

        internal var _backupFileName:String;

        internal var _createBackup:Boolean=true;

        internal var db:database.Database;

        internal static var _instance:database.DatabaseBackup;
    }
}


