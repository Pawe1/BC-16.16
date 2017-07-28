//class CommonDatabaseDefinition
package database 
{
    import flash.events.*;
    import flash.filesystem.*;
    
    public class CommonDatabaseDefinition extends flash.events.EventDispatcher
    {
        public function CommonDatabaseDefinition()
        {
            oldDatabaseFiles = [];
            super();
            init();
            return;
        }

        public function get currentDatabase():database.Database
        {
            return _currentDatabase;
        }

        public function set currentDatabase(arg1:database.Database):void
        {
            _currentDatabase = arg1;
            return;
        }

        protected function init():void
        {
            return;
        }

        public function getCreateTableFunction(arg1:uint):Array
        {
            return null;
        }

        public function createDatabaseUpdate(arg1:flash.filesystem.File, arg2:database.Database, arg3:database.Database):void
        {
            return;
        }

        public function hasOldDatabase():Boolean
        {
            var loc1:*=getHighestOldDatabase();
            return !(loc1 == null);
        }

        public function getHighestOldDatabase():database.Database
        {
            var loc1:*=null;
            var loc4:*=null;
            var loc3:*=0;
            var loc2:*=oldDatabaseFiles.length;
            loc3 = 0;
            while (loc3 < loc2) 
            {
                if (loc4 = oldDatabaseFiles[loc3] as database.Database) 
                {
                    loc4.searchFile();
                    if (loc4.exists()) 
                    {
                        loc1 = loc4;
                    }
                }
                ++loc3;
            }
            return loc1;
        }

        public function getUpdateTargetDatabase(arg1:uint):database.Database
        {
            var loc3:*=null;
            var loc2:*=0;
            var loc4:*=currentDatabase;
            var loc1:*=oldDatabaseFiles.length;
            loc2 = 0;
            while (loc2 < loc1) 
            {
                if ((loc3 = oldDatabaseFiles[loc2] as database.Database) && loc3.versionNumber == arg1) 
                {
                    loc4 = loc3;
                    break;
                }
                ++loc2;
            }
            return loc4;
        }

        public function checkDatabaseStructure():void
        {
            return;
        }

        public function getCurrentStructure(arg1:uint):Array
        {
            return null;
        }

        public static function getRequiredUpdates(arg1:uint):Array
        {
            var loc3:*=0;
            var loc2:*=[];
            var loc1:*=UPDATE_STEPS.length;
            loc3 = 0;
            while (loc3 < loc1) 
            {
                if (UPDATE_STEPS[loc3] >= arg1) 
                {
                    loc2.push(UPDATE_STEPS[loc3]);
                }
                ++loc3;
            }
            if (arg1 < 400) 
            {
                loc2.unshift(arg1);
            }
            return loc2;
        }

        public static function getInstance():database.CommonDatabaseDefinition
        {
            if (!_instance) 
            {
                _instance = new CommonDatabaseDefinition();
            }
            return _instance;
        }

        public static function setInstance(arg1:database.CommonDatabaseDefinition):void
        {
            _instance = arg1;
            return;
        }

        public static const CURRENT_DB_VERSION:uint=520;

        public static const DATABASE_STRUCTURE_INVALID:String="databaseStructureInvalid";

        public static const DATABASE_STRUCTURE_VALID:String="databaseStructureValid";

        public static const DB_200:uint=200;

        public static const DB_210:uint=210;

        public static const DB_300:uint=300;

        public static const DB_313:uint=313;

        public static const DB_320:uint=320;

        public static const DB_330:uint=330;

        public static const DB_400:uint=400;

        public static const DB_500:uint=500;

        public static const DB_510:uint=510;

        public static const DB_520:uint=520;

        public static const UPDATE_STEPS:Array=[400, 500, 510, 520];

        internal var _currentDatabase:database.Database;

        public var oldDatabaseFiles:Array;

        internal static var _instance:database.CommonDatabaseDefinition;
    }
}


