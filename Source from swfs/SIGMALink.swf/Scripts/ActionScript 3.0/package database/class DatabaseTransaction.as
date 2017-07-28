//class DatabaseTransaction
package database 
{
    import debug.*;
    import flash.events.*;
    
    public class DatabaseTransaction extends Object
    {
        public function DatabaseTransaction(arg1:Function, arg2:Array, arg3:String, arg4:Function=null, arg5:Array=null)
        {
            super();
            _generator = arg1;
            _generatorArguments = arg2;
            _sqlMode = arg3;
            _callback = arg4;
            _callbackArguments = arg5;
            return;
        }

        public function commit():void
        {
            database.DatabaseHandlerCommon.getInstance().addEventListener(resolveType(_sqlMode), database_connectedHandler);
            try 
            {
                database.DatabaseHandlerCommon.getInstance().open(_sqlMode);
            }
            catch (e:Error)
            {
                debug.Debug.error("DatabaseTransaction > commit: Database open failed: " + e.message);
            }
            return;
        }

        protected function databaseOpen():void
        {
            _generator.apply(null, _generatorArguments);
            return;
        }

        protected function databaseClose():void
        {
            if (_callback != null) 
            {
                _callback.apply(null, _callbackArguments);
            }
            return;
        }

        internal function resolveType(arg1:String):String
        {
            var loc1:*=arg1;
            while ("create" === loc1) 
            {
                return "databaseForCreateConnected";
            }
        }

        internal function database_connectedHandler(arg1:flash.events.Event):void
        {
            database.DatabaseHandlerCommon.getInstance().removeEventListener(arg1.type, database_connectedHandler);
            database.DatabaseHandlerCommon.getInstance().addEventListener("databaseDisconnected", database_disconnectedHandler);
            databaseOpen();
            return;
        }

        internal function database_disconnectedHandler(arg1:flash.events.Event):void
        {
            database.DatabaseHandlerCommon.getInstance().removeEventListener(arg1.type, database_disconnectedHandler);
            databaseClose();
            return;
        }

        internal var _callback:Function;

        internal var _callbackArguments:Array;

        internal var _generator:Function;

        internal var _generatorArguments:Array;

        internal var _sqlMode:String;
    }
}


