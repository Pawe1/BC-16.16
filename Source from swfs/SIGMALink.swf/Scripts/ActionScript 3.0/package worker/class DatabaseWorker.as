//class DatabaseWorker
package worker 
{
    import backend.database.*;
    import backend.utils.dataprovider.*;
    import backend.utils.dbUtils.*;
    import com.logging.*;
    import core.general.*;
    import database.*;
    import debug.*;
    import flash.data.*;
    import flash.display.*;
    import flash.errors.*;
    import flash.events.*;
    import flash.filesystem.*;
    import flash.system.*;
    import frontend.*;
    import frontend.formatter.*;
    import handler.*;
    import utils.*;
    
    public class DatabaseWorker extends flash.display.Sprite
    {
        public function DatabaseWorker()
        {
            super();
            if (!flash.system.Worker.current.isPrimordial) 
            {
                this._toBGChannel = flash.system.Worker.current.getSharedProperty(TO_BG_CHANNEL) as flash.system.MessageChannel;
                this._toMainChannel = flash.system.Worker.current.getSharedProperty(TO_MAIN_CHANNEL) as flash.system.MessageChannel;
                this._toBGChannel.addEventListener(flash.events.Event.CHANNEL_MESSAGE, this.onMainMessage);
            }
            return;
        }

        internal function onMainMessage(arg1:flash.events.Event):void
        {
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=null;
            if (!this._toBGChannel.messageAvailable) 
            {
                return;
            }
            var loc1:*=this._toBGChannel.receive();
            var loc2:*=loc1[0];
            var loc7:*=loc2;
            switch (loc7) 
            {
                case INIT_DATABASE:
                {
                    utils.LanguageManager.getStringFunction = frontend.Locales.locale().getString;
                    frontend.Locales.locale().localeChain = ["de_DE"];
                    frontend.Locales.locale().addBundle("de_DE", frontend.Locales.DEFAULT_LANGUAGE_BUNDLENAME, true, this.onLocaleInitialized);
                    loc3 = new flash.filesystem.File(loc1[1]);
                    handler.AppDBHandler.getInstance();
                    backend.database.DatabaseDefinition.getInstance().currentDatabase.initDatabaseFile(loc3.parent.nativePath);
                    break;
                }
                case INIT_ERROR_LOGGING:
                {
                    loc4 = loc1[1];
                    com.logging.ErrorLogging.getInstance().filename = "app-error";
                    com.logging.ErrorLogging.getInstance().loggingPath = loc4;
                    debug.Debug.setCustomFilePath(loc4 + "/worker1_" + debug.Debug.DEFAULT_FILENAME);
                    loaderInfo.uncaughtErrorEvents.addEventListener(flash.events.UncaughtErrorEvent.UNCAUGHT_ERROR, this.onError);
                    break;
                }
                case EXECUTE_LOAD_STMT:
                {
                    loc5 = backend.utils.dbUtils.DBUtilObject.fromObject(loc1[1]);
                    new database.DatabaseTransaction(this.executeLoadStatement, [loc5], loc5.sqlMode).commit();
                    break;
                }
                case EXECUTE_MULTIPLE_STMTS:
                {
                    loc6 = backend.utils.dbUtils.DBUtilObject.fromObject(loc1[1]);
                    new database.DatabaseTransaction(this.executeMultipleStmts, [loc6], loc6.sqlMode).commit();
                    break;
                }
            }
            return;
        }

        internal function onLocaleInitialized(arg1:Object, arg2:Object, arg3:Object):void
        {
            var o1:Object;
            var o2:Object;
            var o3:Object;

            var loc1:*;
            o1 = arg1;
            o2 = arg2;
            o3 = arg3;
            frontend.formatter.LinkBackendInitializer.getInstance();
            handler.SportHandler.init();
            backend.utils.dataprovider.DataProviderUtil.initDataProviders();
            try 
            {
                this._toMainChannel.send([INIT_DATABASE]);
            }
            catch (e:Error)
            {
                debug.Debug.error("ERROR: " + e.message);
            }
            return;
        }

        internal function onError(arg1:flash.events.UncaughtErrorEvent):void
        {
            var loc1:*=null;
            arg1.preventDefault();
            arg1.stopImmediatePropagation();
            if (arg1.error is Error) 
            {
                loc1 = (arg1.error as Error).getStackTrace();
            }
            else if (arg1.error is flash.events.ErrorEvent) 
            {
                loc1 = flash.events.ErrorEvent(arg1.error).text;
            }
            else 
            {
                loc1 = arg1.error.toString();
            }
            var loc2:*=new com.logging.ErrorLoggingEvent(com.logging.ErrorLoggingEvent.ERROR, core.general.ErrorLoggingTyp.ERROR_UNCAUGHT_EXCEPTION, loc1, "DatabaseWorker");
            com.logging.ErrorLogging.getInstance().receiveMessageFromStaticFunction(loc2, false);
            return;
        }

        internal function executeLoadStatement(arg1:backend.utils.dbUtils.DBUtilObject):void
        {
            var p_definitionObj:backend.utils.dbUtils.DBUtilObject;
            var stmt:database.DCSQLStatement;

            var loc1:*;
            stmt = null;
            p_definitionObj = arg1;
            debug.Debug.database("executeLoadStatement: " + p_definitionObj.stmt);
            stmt = new database.DCSQLStatement();
            stmt.addEventListener(flash.events.SQLEvent.RESULT, this.onLoadComplete);
            stmt.addEventListener(flash.events.SQLErrorEvent.ERROR, this.onLoadError);
            stmt.data = p_definitionObj;
            stmt.text = p_definitionObj.stmt;
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

        internal function onLoadComplete(arg1:flash.events.SQLEvent):void
        {
            var p_event:flash.events.SQLEvent;
            var currentStmt:database.DCSQLStatement;
            var returnObj:backend.utils.dbUtils.DBUtilObject;
            var sqlResult:flash.data.SQLResult;

            var loc1:*;
            p_event = arg1;
            currentStmt = p_event.target as database.DCSQLStatement;
            currentStmt.removeEventListener(flash.events.SQLEvent.RESULT, this.onLoadComplete);
            currentStmt.removeEventListener(flash.events.SQLErrorEvent.ERROR, this.onLoadError);
            returnObj = currentStmt.data as backend.utils.dbUtils.DBUtilObject;
            sqlResult = currentStmt.getResult();
            if (sqlResult) 
            {
                returnObj.result = sqlResult.data;
            }
            handler.AppDBHandler.getInstance().commit();
            try 
            {
                this._toMainChannel.send([EXECUTE_LOAD_STMT, flash.events.SQLEvent.RESULT, returnObj]);
            }
            catch (e:Error)
            {
                debug.Debug.error("ERROR: " + e.message);
            }
            return;
        }

        internal function onLoadError(arg1:flash.events.SQLErrorEvent):void
        {
            var p_event:flash.events.SQLErrorEvent;
            var currentStmt:database.DCSQLStatement;
            var returnObj:backend.utils.dbUtils.DBUtilObject;

            var loc1:*;
            p_event = arg1;
            currentStmt = p_event.target as database.DCSQLStatement;
            currentStmt.removeEventListener(flash.events.SQLEvent.RESULT, this.onLoadComplete);
            currentStmt.removeEventListener(flash.events.SQLErrorEvent.ERROR, this.onLoadError);
            returnObj = currentStmt.data as backend.utils.dbUtils.DBUtilObject;
            handler.AppDBHandler.getInstance().close();
            try 
            {
                this._toMainChannel.send([EXECUTE_LOAD_STMT, flash.events.SQLErrorEvent.ERROR, returnObj]);
            }
            catch (e:Error)
            {
                debug.Debug.error("ERROR: " + e.message);
            }
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
            var sqlResult:flash.data.SQLResult;
            var j:int;
            var jLen:int;

            var loc1:*;
            i = 0;
            prop = undefined;
            nextObj = null;
            sqlResult = null;
            j = 0;
            jLen = 0;
            p_definitionObj = arg1;
            len = p_definitionObj.stmts.length;
            result = new Array();
            i = 0;
            while (i < len) 
            {
                nextObj = backend.utils.dbUtils.DBUtilObject.fromObject(p_definitionObj.stmts[i]);
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
                    com.logging.ErrorLogging.getInstance().removeTarget(p_definitionObj.preparedStmt);
                    try 
                    {
                        _toMainChannel.send([EXECUTE_MULTIPLE_STMTS, flash.events.SQLErrorEvent.ERROR, p_definitionObj]);
                    }
                    catch (e:Error)
                    {
                        debug.Debug.error("ERROR: " + e.message);
                    }
                    return;
                }
                ++i;
            }
            p_definitionObj.result = result;
            handler.AppDBHandler.getInstance().commit();
            com.logging.ErrorLogging.getInstance().removeTarget(p_definitionObj.preparedStmt);
            try 
            {
                this._toMainChannel.send([EXECUTE_MULTIPLE_STMTS, flash.events.SQLEvent.RESULT, p_definitionObj]);
            }
            catch (e:Error)
            {
                debug.Debug.error("ERROR: " + e.message);
            }
            return;
        }

        
        {
            EXECUTE_LOAD_STMT = "execute_load_statement";
            EXECUTE_MULTIPLE_STMTS = "execute_multi_stmts";
            INIT_DATABASE = "dbWorker_initDataBase";
            INIT_ERROR_LOGGING = "dbWorker_initErrorLogging";
            TO_BG_CHANNEL = "dbWorker_toBGChannel";
            TO_MAIN_CHANNEL = "dbWorker_toMainChannel";
        }

        internal var _toBGChannel:flash.system.MessageChannel;

        internal var _toMainChannel:flash.system.MessageChannel;

        public static var EXECUTE_LOAD_STMT:String="execute_load_statement";

        public static var EXECUTE_MULTIPLE_STMTS:String="execute_multi_stmts";

        public static var INIT_DATABASE:String="dbWorker_initDataBase";

        public static var INIT_ERROR_LOGGING:String="dbWorker_initErrorLogging";

        public static var TO_BG_CHANNEL:String="dbWorker_toBGChannel";

        public static var TO_MAIN_CHANNEL:String="dbWorker_toMainChannel";
    }
}


