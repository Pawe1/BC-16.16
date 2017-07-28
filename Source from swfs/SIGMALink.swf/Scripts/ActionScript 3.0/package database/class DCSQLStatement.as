//class DCSQLStatement
package database 
{
    import com.logging.*;
    import debug.*;
    import flash.data.*;
    import flash.errors.*;
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;
    import mx.events.*;
    
    public class DCSQLStatement extends flash.data.SQLStatement
    {
        public function DCSQLStatement()
        {
            super();
            values = {};
            dbHandler = database.DatabaseHandlerCommon.getInstance();
            sqlConnection = dbHandler.connection;
            return;
        }

        public function get data():Object
        {
            return this.data;
        }

        public function set data(arg1:Object):void
        {
            var loc1:*=this.data;
            if (loc1 !== arg1) 
            {
                this.data = arg1;
                if (this.hasEventListener("propertyChange")) 
                {
                    this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "data", loc1, arg1));
                }
            }
            return;
        }

        public override function execute(arg1:int=-1, arg2:flash.net.Responder=null):void
        {
            var loc1:*=0;
            try 
            {
                com.logging.ErrorLogging.getInstance().addTarget(this);
                super.execute(arg1, arg2);
            }
            catch (error:Error)
            {
                if (DEBUG) 
                {
                    dispatchEvent(new com.logging.ErrorLoggingEvent("loggingDebugEvent", 0, error.errorID + ": " + error.message + "(" + text + ")"));
                }
                if (error.errorID != 3119) 
                {
                    if (DEBUG) 
                    {
                        debug.Debug.error("execute error: " + error.errorID + ", msg: " + error.message);
                    }
                    dispatchEvent(new flash.events.SQLErrorEvent("error", false, false, new flash.errors.SQLError(error is flash.errors.SQLError ? (error as flash.errors.SQLError).operation : "", error is flash.errors.SQLError ? (error as flash.errors.SQLError).details + " " + text : text, error.message, error.errorID)));
                }
                else 
                {
                    ++_timeoutCounter;
                    if (DEBUG) 
                    {
                        debug.Debug.warning("Database currently locked > setTimeout-Counter: " + _timeoutCounter);
                    }
                    com.logging.ErrorLogging.getInstance().removeTarget(this);
                    flash.utils.setTimeout(execute, 200, arg1, arg2);
                }
                loc1 = 0;
            }
            finally
            {
                com.logging.ErrorLogging.getInstance().removeTarget(this);
            }
            throw loc2;
            return;
        }

        public var arr:Array;

        public var commitOnComplete:Boolean=true;

        internal var data:Object;

        public var data2:Object;

        public var dbHandler:database.DatabaseHandlerCommon;

        public var dispatchCompleteEvent:Boolean=false;

        public var dispatchUpdateEvent:Boolean=true;

        public var statementArray:Array;

        public var values:Object;

        public var workerType:String="";

        internal var _timeoutCounter:int=0;

        public static var dispatchCompleteEventProperty:String="dispatchCompleteEvent";

        internal static var DEBUG:Boolean=false;
    }
}


