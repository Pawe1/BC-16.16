//class Database
package database 
{
    import com.logging.*;
    import flash.data.*;
    import flash.errors.*;
    import flash.events.*;
    import flash.filesystem.*;
    import flash.utils.*;
    import helper.*;
    
    public class Database extends flash.events.EventDispatcher
    {
        public function Database(arg1:String, arg2:String, arg3:uint, arg4:uint, arg5:String, arg6:Boolean=false, arg7:String=null, arg8:Boolean=false)
        {
            super();
            name = arg1;
            version = arg2;
            versionNumber = arg3;
            updateToVersion = arg4;
            directory = arg5;
            searchForConfig = arg6;
            tilesDirectory = arg7;
            createBackupBeforeUpdate = arg8;
            return;
        }

        internal function databaseIOError(arg1:flash.events.IOErrorEvent):void
        {
            return;
        }

        internal function databaseSecurityError(arg1:flash.events.SecurityErrorEvent):void
        {
            return;
        }

        internal function createNewDatabase(arg1:flash.filesystem.File):void
        {
            database.DatabaseHandlerCommon.getInstance().addEventListener("databaseForCreateConnected", onConnectedCreateTable);
            try 
            {
                database.DatabaseHandlerCommon.getInstance().dataBase = arg1;
                database.DatabaseHandlerCommon.getInstance().open("create");
            }
            catch (error:flash.errors.SQLError)
            {
                database.DatabaseHandlerCommon.getInstance().connection.dispatchEvent(new flash.events.SQLErrorEvent("error", false, false, error));
            }
            return;
        }

        internal function onConnectedCreateTable(arg1:flash.events.Event):void
        {
            var loc3:*=null;
            database.DatabaseHandlerCommon.getInstance().removeEventListener("databaseForCreateConnected", onConnectedCreateTable);
            var loc2:*=database.CommonDatabaseDefinition.getInstance().getCreateTableFunction(versionNumber);
            tablesToCreate = loc2.length;
            var loc7:*=0;
            var loc6:*=loc2;
            for each (var loc1:* in loc6) 
            {
                (loc3 = new flash.data.SQLStatement()).sqlConnection = database.DatabaseHandlerCommon.getInstance().connection;
                loc3.addEventListener("result", createNewDatabaseComplete);
                loc3.addEventListener("error", createNewDatabaseError);
                if (loc1 is String) 
                {
                    loc3.text = loc1 as String;
                }
                else if (loc1 is database.DatabaseTable) 
                {
                    loc3.text = (loc1 as database.DatabaseTable).createTableStatement();
                }
                else 
                {
                    continue;
                }
            }
            return;
        }

        internal function createNewDatabaseComplete(arg1:flash.events.SQLEvent):void
        {
            (arg1.target as flash.data.SQLStatement).removeEventListener("result", createNewDatabaseComplete);
            --tablesToCreate;
            if (tablesToCreate == 0) 
            {
                database.DatabaseHandlerCommon.getInstance().addEventListener("databaseDisconnected", createNewDatabaseCommit);
                database.DatabaseHandlerCommon.getInstance().commit();
            }
            return;
        }

        internal function createNewDatabaseCommit(arg1:flash.events.Event):void
        {
            removeEventListener("databaseDisconnected", createNewDatabaseCommit);
            dispatchEvent(new flash.events.Event("databaseExist"));
            return;
        }

        internal function createNewDatabaseError(arg1:flash.events.SQLErrorEvent):void
        {
            (arg1.target as flash.data.SQLStatement).removeEventListener("error", createNewDatabaseError);
            return;
        }

        public function checkDatabaseSchema():void
        {
            database.DatabaseHandlerCommon.getInstance().dataBase = file;
            new database.DatabaseTransaction(loadSchema, [], "read").commit();
            return;
        }

        internal function loadSchema():void
        {
            var loc4:*=null;
            var loc2:*=new flash.data.SQLStatement();
            loc2.sqlConnection = database.DatabaseHandlerCommon.getInstance().connection;
            try 
            {
                loc2.sqlConnection.loadSchema();
            }
            catch (error:flash.errors.SQLError)
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 1000035, "DatabaseBackup > : " + error.toString()));
                database.DatabaseHandlerCommon.getInstance().close();
                dispatchEvent(new flash.events.Event("databaseCorrupt"));
                return;
            }
            var loc1:*=loc2.sqlConnection.getSchemaResult();
            var loc10:*=0;
            var loc9:*=loc1.tables;
            for each (var loc3:* in loc9) 
            {
                (loc4 = new database.DCSQLStatement()).sqlConnection = database.DatabaseHandlerCommon.getInstance().connection;
                loc4.data = loc3.name;
                loc4.text = "select count(*) as rowCounter from " + loc3.name;
            }
            database.DatabaseHandlerCommon.getInstance().close();
            dispatchEvent(new flash.events.Event("databaseOk"));
            return;
        }

        public function deleteDatabase():void
        {
            if (exists()) 
            {
                try 
                {
                    file.deleteFile();
                    file = null;
                }
                catch (e:Error)
                {
                    if (e.errorID == 3013) 
                    {
                        flash.utils.setTimeout(deleteDatabase, 1000);
                    }
                }
            }
            return;
        }

        public function restoreFromBackup():void
        {
            var loc1:*=null;
            if (backupFile && backupFile.exists) 
            {
                deleteDatabase();
                loc1 = new flash.filesystem.File(backupFile.parent.nativePath + "/" + name);
                backupFile.moveTo(loc1);
            }
            return;
        }

        public static function createBackupFileName(arg1:String, arg2:Number=NaN):String
        {
            var loc1:*="AUTOBACKUP_" + arg1;
            if (!isNaN(arg2)) 
            {
                loc1 = loc1.replace(".db", "_" + arg2.toString() + ".db");
            }
            return loc1;
        }

        public static function backupDirectory():flash.filesystem.File
        {
            var loc3:*=null;
            var loc2:*=null;
            var loc1:*=null;
            if (helper.Capabilities_helper.isDesktop()) 
            {
                loc3 = new flash.filesystem.File(flash.filesystem.File.applicationStorageDirectory.nativePath).parent;
                loc2 = new flash.filesystem.File(loc3.nativePath).parent;
                return new flash.filesystem.File(loc2.nativePath + "/" + "DataCenter.Desktop/Local Store");
            }
            loc1 = new flash.filesystem.File(flash.filesystem.File.documentsDirectory.nativePath + "/SigmaDataCenter");
            return loc1;
        }

        public function get workDirectory():flash.filesystem.File
        {
            if (helper.Capabilities_helper.DEVICE == "IOS") 
            {
                return flash.filesystem.File.documentsDirectory.resolvePath(".");
            }
            return flash.filesystem.File.applicationStorageDirectory;
        }

        public function exists():Boolean
        {
            return !(file == null) && file.exists;
        }

        public function searchFile():void
        {
            var loc3:*=null;
            var loc2:*=null;
            var loc4:*=null;
            var loc1:*=null;
            var loc6:*=null;
            var loc7:*=null;
            var loc5:*=null;
            if (helper.Capabilities_helper.isMobile()) 
            {
                loc3 = workDirectory.resolvePath(name);
                if (loc3 && loc3.exists) 
                {
                    file = loc3;
                }
                return;
            }
            if (searchForConfig) 
            {
                loc2 = workDirectory.resolvePath(CONFIG_PATH);
                if (loc2.exists) 
                {
                    loc4 = new flash.filesystem.FileStream();
                    try 
                    {
                        loc4.open(loc2, "read");
                        if (loc4.bytesAvailable > 0) 
                        {
                            loc1 = loc4.readUTFBytes(loc4.bytesAvailable);
                            loc3 = new flash.filesystem.File(loc1);
                            if (loc3.exists) 
                            {
                                file = loc3;
                            }
                        }
                    }
                    catch (e:*)
                    {
                    };
                    loc4.close();
                }
            }
            else 
            {
                loc6 = directory + "/" + name;
                loc3 = flash.filesystem.File.documentsDirectory.resolvePath(loc6);
                if (loc3 && loc3.exists) 
                {
                    file = loc3;
                }
                else 
                {
                    try 
                    {
                        loc7 = new flash.filesystem.File(flash.filesystem.File.applicationStorageDirectory.nativePath).parent;
                        loc5 = new flash.filesystem.File(loc7.nativePath).parent;
                        loc3 = new flash.filesystem.File(loc5.nativePath + "/" + loc6);
                        if (loc3 && loc3.exists) 
                        {
                            file = loc3;
                        }
                    }
                    catch (e:Error)
                    {
                    };
                }
            }
            return;
        }

        public function initDatabaseFile(arg1:String=""):void
        {
            if (arg1 == "") 
            {
                arg1 = workDirectory.nativePath;
            }
            var loc1:*=new flash.filesystem.File(arg1);
            loc1.addEventListener("ioError", databaseIOError);
            loc1.addEventListener("securityError", databaseSecurityError);
            if (!loc1.exists) 
            {
                loc1.createDirectory();
            }
            file = new flash.filesystem.File(arg1 + "/" + name);
            if (!(file == null) && file.exists) 
            {
                database.DatabaseHandlerCommon.getInstance().dataBase = file;
                dispatchEvent(new flash.events.Event("databaseExist"));
            }
            else 
            {
                createNewDatabase(file);
            }
            return;
        }

        public static const DATABASE_EXIST:String="databaseExist";

        public static const DATABASE_NOT_EXIST:String="databaseNotExist";

        public static const DATABASE_OK:String="databaseOk";

        public static const DATABASE_CORRUPT:String="databaseCorrupt";

        public var backupFile:flash.filesystem.File;

        public var checkStatusFlag:Boolean=true;

        public var createBackupBeforeUpdate:Boolean=false;

        public var directory:String;

        public var file:flash.filesystem.File;

        public var name:String;

        public var searchForConfig:Boolean;

        public var tablesToCreate:uint=0;

        public var tilesDirectory:String;

        public var updateComplete:Boolean=false;

        public var updateToVersion:uint;

        public var version:String;

        public var versionNumber:uint;

        public static var myDecoderPwd:String="J6voPJaQjsq3srBZw7pBQA==";

        public static var CONFIG_PATH:String="config/dcConfig";
    }
}


