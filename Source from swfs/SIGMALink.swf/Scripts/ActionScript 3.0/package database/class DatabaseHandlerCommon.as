//class DatabaseHandlerCommon
package database 
{
    import flash.data.*;
    import flash.events.*;
    import flash.filesystem.*;
    
    public class DatabaseHandlerCommon extends flash.events.EventDispatcher
    {
        public function DatabaseHandlerCommon(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            return;
        }

        public function get connection():flash.data.SQLConnection
        {
            return _connection;
        }

        public function set connection(arg1:flash.data.SQLConnection):void
        {
            _connection = arg1;
            return;
        }

        public function get dataBase():flash.filesystem.File
        {
            return _dataBase;
        }

        public function set dataBase(arg1:flash.filesystem.File):void
        {
            _dataBase = arg1;
            return;
        }

        public function open(arg1:String, arg2:Boolean=false):void
        {
            return;
        }

        public function commit(arg1:Boolean=false, arg2:Boolean=false):void
        {
            return;
        }

        public function close():void
        {
            return;
        }

        public static function setInstance(arg1:database.DatabaseHandlerCommon):void
        {
            _instance = arg1;
            return;
        }

        public static function getInstance():database.DatabaseHandlerCommon
        {
            if (!_instance) 
            {
                _instance = new DatabaseHandlerCommon();
            }
            return _instance;
        }

        public static const DATABASE_DISCONNECTED:String="databaseDisconnected";

        public static const DATABASE_FOR_CREATE_CONNECTED:String="databaseForCreateConnected";

        public static const DATABASE_FOR_READ_CONNECTED:String="databaseForReadConnected";

        public static const DATABASE_FOR_UPDATE_CONNECTED:String="databaseForUpdateConnected";

        internal var _connection:flash.data.SQLConnection;

        internal var _dataBase:flash.filesystem.File;

        protected static var _instance:database.DatabaseHandlerCommon;
    }
}


