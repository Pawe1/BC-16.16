//class CommonUpdateHandler
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


