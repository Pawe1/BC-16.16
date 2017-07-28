//class DBUtil
package backend.utils.dbUtils 
{
    import backend.database.*;
    import com.logging.*;
    import database.*;
    import debug.*;
    import flash.data.*;
    import flash.errors.*;
    import flash.events.*;
    import flash.system.*;
    import flash.utils.*;
    import handler.*;
    import utils.*;
    import worker.*;
    
    public class DBUtil extends flash.events.EventDispatcher
    {
        public function DBUtil(arg1:flash.events.IEventDispatcher=null)
        {
            this._calls = new flash.utils.Dictionary();
            this._multiCalls = new flash.utils.Dictionary();
            super(arg1);
            return;
        }

        internal function get _ignoreWorkerTarget():Boolean
        {
            return !flash.system.Worker.current.isPrimordial;
        }

        public function call(arg1:String, arg2:String, arg3:Function, arg4:Function=null, arg5:flash.utils.ByteArray=null, arg6:Object=null, arg7:Object=null):void
        {
            this._workerTarget = this._ignoreWorkerTarget ? null : arg5;
            var loc1:*=new backend.utils.dbUtils.DBUtilObject();
            loc1.sqlMode = arg1;
            loc1.stmt = arg2;
            loc1.guid = utils.GUID.create();
            loc1.completeCallback = arg3;
            loc1.errorCallback = arg4;
            loc1.data = arg6;
            loc1.parameters = arg7;
            this._calls[loc1.guid] = loc1;
            if (this._workerTarget) 
            {
                this.sendToWorker([worker.DatabaseWorker.EXECUTE_LOAD_STMT, loc1]);
            }
            else 
            {
                new database.DatabaseTransaction(this.executeStatement, [loc1], arg1).commit();
            }
            return;
        }

        public function callMultiple(arg1:String, arg2:Array, arg3:Function, arg4:Function=null, arg5:flash.utils.ByteArray=null, arg6:Object=null):void
        {
            this._workerTarget = this._ignoreWorkerTarget ? null : arg5;
            var loc1:*=new backend.utils.dbUtils.DBUtilObject();
            loc1.sqlMode = arg1;
            loc1.stmts = arg2;
            loc1.guid = utils.GUID.create();
            loc1.completeCallback = arg3;
            loc1.errorCallback = arg4;
            loc1.data = arg6;
            this._calls[loc1.guid] = loc1;
            if (this._workerTarget) 
            {
                this.sendToWorker([worker.DatabaseWorker.EXECUTE_MULTIPLE_STMTS, loc1]);
            }
            else 
            {
                new database.DatabaseTransaction(this.executeMultipleStmts, [loc1], loc1.sqlMode).commit();
            }
            return;
        }

        public function startWorker(arg1:flash.utils.ByteArray):void
        {
            this._workerTarget = arg1;
            this.initWorker();
            return;
        }

        internal function initWorker():void
        {
            var loc1:*;
            if (workerInstance) 
            {
                return;
            }
            workerInstance = flash.system.WorkerDomain.current.createWorker(this._workerTarget, true);
            this._toBGChannel = flash.system.Worker.current.createMessageChannel(workerInstance);
            this._toMainChannel = workerInstance.createMessageChannel(flash.system.Worker.current);
            workerInstance.setSharedProperty(worker.DatabaseWorker.TO_BG_CHANNEL, this._toBGChannel);
            workerInstance.setSharedProperty(worker.DatabaseWorker.TO_MAIN_CHANNEL, this._toMainChannel);
            workerInstance.addEventListener(flash.events.Event.WORKER_STATE, this.onWorkerStateChanged);
            try 
            {
                workerInstance.start();
            }
            catch (error:Error)
            {
                debug.Debug.error("initWorker error: " + error.message);
                return;
            }
            this._toMainChannel.addEventListener(flash.events.Event.CHANNEL_MESSAGE, this.onWorkerChannelMessage);
            return;
        }

        internal function sendToWorker(arg1:Array):void
        {
            var p_array:Array;

            var loc1:*;
            p_array = arg1;
            if (!workerInstance) 
            {
                this.initWorker();
            }
            if (!this._workerInitComplete) 
            {
                flash.utils.setTimeout(this.sendToWorker, 100, p_array);
                return;
            }
            if (workerInstance.state != flash.system.WorkerState.RUNNING) 
            {
                flash.utils.setTimeout(this.sendToWorker, 100, p_array);
                return;
            }
            var loc2:*;
            var loc3:*=((loc2 = this)._currentWorkerRequests + 1);
            loc2._currentWorkerRequests = loc3;
            if (this._currentWorkerRequests > this._maxWorkerRequests) 
            {
                debug.Debug.debug("################# DESTROY WORKER ###############");
                this.destroyWorker();
                flash.utils.setTimeout(this.sendToWorker, 200, p_array);
                return;
            }
            try 
            {
                this._toBGChannel.send(p_array);
            }
            catch (error:Error)
            {
                debug.Debug.error("sendToWorker error: " + error.message);
            }
            return;
        }

        public function destroyWorker():void
        {
            this._currentWorkerRequests = 0;
            if (workerInstance) 
            {
                workerInstance.removeEventListener(flash.events.Event.WORKER_STATE, this.onWorkerStateChanged);
                workerInstance.terminate();
                workerInstance = null;
                this._workerInitComplete = false;
                this._toBGChannel.close();
                this._toMainChannel.close();
            }
            return;
        }

        internal function onWorkerStateChanged(arg1:flash.events.Event):void
        {
            if (arg1.target.state == flash.system.WorkerState.RUNNING) 
            {
                this._toBGChannel.send([worker.DatabaseWorker.INIT_DATABASE, backend.database.DatabaseDefinition.getInstance().currentDatabase.file.nativePath]);
                this._toBGChannel.send([worker.DatabaseWorker.INIT_ERROR_LOGGING, backend.database.DatabaseDefinition.getInstance().currentDatabase.workDirectory.nativePath]);
            }
            return;
        }

        internal function onWorkerChannelMessage(arg1:flash.events.Event):void
        {
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=null;
            var loc1:*=this._toMainChannel.receive();
            var loc2:*=loc1[0];
            var loc6:*=loc2;
            switch (loc6) 
            {
                case worker.DatabaseWorker.INIT_DATABASE:
                {
                    this._workerInitComplete = true;
                    break;
                }
                case worker.DatabaseWorker.EXECUTE_LOAD_STMT:
                case worker.DatabaseWorker.EXECUTE_MULTIPLE_STMTS:
                {
                    loc3 = backend.utils.dbUtils.DBUtilObject.fromObject(loc1[2]);
                    loc5 = this._calls[loc3.guid];
                    loc5.result = loc3.result;
                    delete this._calls[loc5.guid];
                    loc4 = new backend.utils.dbUtils.DBUtilEvent(backend.utils.dbUtils.DBUtilEvent.COMPLETE, loc5);
                    loc5.completeCallback(loc4);
                    break;
                }
                default:
                {
                    debug.Debug.warning("TODO: no handling for mode: " + loc2);
                }
            }
            return;
        }

        internal function executeStatement(arg1:backend.utils.dbUtils.DBUtilObject):void
        {
            var p_definitionObj:backend.utils.dbUtils.DBUtilObject;
            var stmt:database.DCSQLStatement;
            var prop:*;

            var loc1:*;
            stmt = null;
            prop = undefined;
            p_definitionObj = arg1;
            stmt = new database.DCSQLStatement();
            stmt.addEventListener(flash.events.SQLEvent.RESULT, this.onExecuteStatementComplete);
            stmt.addEventListener(flash.events.SQLErrorEvent.ERROR, this.onExecuteStatementError);
            stmt.data = p_definitionObj;
            stmt.text = p_definitionObj.stmt;
            if (p_definitionObj.parameters) 
            {
                var loc2:*=0;
                var loc3:*=p_definitionObj.parameters;
                for (prop in loc3) 
                {
                    stmt.parameters[prop] = p_definitionObj.parameters[prop];
                }
            }
            try 
            {
                stmt.execute();
            }
            catch (error:Error)
            {
                stmt.dispatchEvent(new flash.events.SQLErrorEvent(flash.events.SQLErrorEvent.ERROR, false, false, new flash.errors.SQLError("", stmt.text, error.message, error.errorID)));
            }
            return;
        }

        internal function onExecuteStatementComplete(arg1:flash.events.SQLEvent):void
        {
            var loc1:*=arg1.target as database.DCSQLStatement;
            loc1.removeEventListener(flash.events.SQLEvent.RESULT, this.onExecuteStatementComplete);
            loc1.removeEventListener(flash.events.SQLErrorEvent.ERROR, this.onExecuteStatementError);
            var loc2:*=loc1.data as backend.utils.dbUtils.DBUtilObject;
            var loc3:*=loc1.getResult();
            if (loc3) 
            {
                loc2.result = loc3.data;
            }
            loc1.dbHandler.commit();
            var loc4:*=this._calls[loc2.guid];
            loc4.result = loc2.result;
            if (loc3) 
            {
                loc4.lastInsertRowId = loc3.lastInsertRowID;
            }
            delete this._calls[loc4.guid];
            var loc5:*=new backend.utils.dbUtils.DBUtilEvent(backend.utils.dbUtils.DBUtilEvent.COMPLETE, loc4);
            loc4.completeCallback(loc5);
            com.logging.ErrorLogging.getInstance().removeTarget(loc1);
            return;
        }

        internal function onExecuteStatementError(arg1:flash.events.SQLErrorEvent):void
        {
            var loc1:*=arg1.target as database.DCSQLStatement;
            loc1.removeEventListener(flash.events.SQLEvent.RESULT, this.onExecuteStatementComplete);
            loc1.removeEventListener(flash.events.SQLErrorEvent.ERROR, this.onExecuteStatementError);
            var loc2:*=loc1.data as backend.utils.dbUtils.DBUtilObject;
            loc1.dbHandler.close();
            var loc3:*=this._calls[loc2.guid];
            loc3.result = loc2.result;
            delete this._calls[loc3.guid];
            var loc4:*=new backend.utils.dbUtils.DBUtilEvent(backend.utils.dbUtils.DBUtilEvent.ERROR, loc3);
            loc4.message = arg1.error.message;
            loc3.errorCallback(loc4);
            com.logging.ErrorLogging.getInstance().removeTarget(loc1);
            return;
        }

        internal function executeMultipleStmts(arg1:backend.utils.dbUtils.DBUtilObject):void
        {
            var p_definitionObj:backend.utils.dbUtils.DBUtilObject;
            var i:int;
            var len:int;
            var prop:*;
            var nextObj:backend.utils.dbUtils.DBUtilObject;
            var result:Array;
            var definition:backend.utils.dbUtils.DBUtilObject;
            var completeEvent:backend.utils.dbUtils.DBUtilEvent;
            var sqlResult:flash.data.SQLResult;
            var j:int;
            var jLen:int;
            var errorEvent:backend.utils.dbUtils.DBUtilEvent;

            var loc1:*;
            i = 0;
            prop = undefined;
            nextObj = null;
            sqlResult = null;
            j = 0;
            jLen = 0;
            errorEvent = null;
            p_definitionObj = arg1;
            len = p_definitionObj.stmts.length;
            result = new Array();
            i = 0;
            while (i < len) 
            {
                nextObj = p_definitionObj.stmts[i];
                if (p_definitionObj.preparedStmt == null) 
                {
                    p_definitionObj.preparedStmt = new database.DCSQLStatement();
                    p_definitionObj.preparedStmt.data = p_definitionObj;
                }
                p_definitionObj.preparedStmt.text = nextObj.stmt;
                p_definitionObj.preparedStmt.clearParameters();
                if (nextObj.parameters) 
                {
                    var loc2:*=0;
                    var loc3:*=nextObj.parameters;
                    for (prop in loc3) 
                    {
                        p_definitionObj.preparedStmt.parameters[prop] = nextObj.parameters[prop];
                    }
                }
                try 
                {
                    p_definitionObj.preparedStmt.execute();
                    sqlResult = p_definitionObj.preparedStmt.getResult();
                    if (sqlResult && sqlResult.data) 
                    {
                        jLen = sqlResult.data.length;
                        j = 0;
                        while (j < jLen) 
                        {
                            result.push(sqlResult.data[j]);
                            ++j;
                        }
                    }
                }
                catch (error:Error)
                {
                    p_definitionObj.preparedStmt.dispatchEvent(new flash.events.SQLErrorEvent(flash.events.SQLErrorEvent.ERROR, false, false, new flash.errors.SQLError("", p_definitionObj.preparedStmt.text, error.message, error.errorID)));
                    handler.AppDBHandler.getInstance().close();
                    errorEvent = new backend.utils.dbUtils.DBUtilEvent(backend.utils.dbUtils.DBUtilEvent.ERROR, p_definitionObj);
                    errorEvent.message = error.errorID + ": " + error.message;
                    p_definitionObj.errorCallback(errorEvent);
                    delete _calls[p_definitionObj.guid];
                    com.logging.ErrorLogging.getInstance().removeTarget(p_definitionObj.preparedStmt);
                    p_definitionObj = null;
                    return;
                }
                ++i;
            }
            p_definitionObj.result = result;
            handler.AppDBHandler.getInstance().commit();
            com.logging.ErrorLogging.getInstance().removeTarget(p_definitionObj.preparedStmt);
            definition = this._calls[p_definitionObj.guid];
            try 
            {
                if (definition) 
                {
                    definition.result = p_definitionObj.result;
                }
                delete this._calls[p_definitionObj.guid];
            }
            catch (e:Error)
            {
                debug.Debug.error("DBUtilObject existiert nicht mehr");
            }
            completeEvent = new backend.utils.dbUtils.DBUtilEvent(backend.utils.dbUtils.DBUtilEvent.COMPLETE, p_definitionObj);
            p_definitionObj.completeCallback(completeEvent);
            p_definitionObj = null;
            return;
        }

        public static function getInstance():backend.utils.dbUtils.DBUtil
        {
            if (!_instance) 
            {
                _instance = new DBUtil();
            }
            return _instance;
        }

        internal var _calls:flash.utils.Dictionary;

        internal var _currentWorkerRequests:int=0;

        internal var _maxWorkerRequests:int=100;

        internal var _multiCalls:flash.utils.Dictionary;

        internal var _toBGChannel:flash.system.MessageChannel;

        internal var _toMainChannel:flash.system.MessageChannel;

        internal var _workerInitComplete:Boolean=false;

        internal var _workerTarget:flash.utils.ByteArray;

        internal static var _instance:backend.utils.dbUtils.DBUtil;

        internal static var workerInstance:flash.system.Worker;
    }
}


