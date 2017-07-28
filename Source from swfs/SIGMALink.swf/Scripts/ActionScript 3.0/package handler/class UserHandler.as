//class UserHandler
package handler 
{
    import backend.utils.dbUtils.*;
    import com.logging.*;
    import configCache.*;
    import core.general.*;
    import core.user.*;
    import core.user.interfaces.*;
    import database.*;
    import flash.data.*;
    import flash.errors.*;
    import flash.events.*;
    import flash.utils.*;
    
    public class UserHandler extends flash.events.EventDispatcher implements core.user.interfaces.IUserHandler
    {
        public function UserHandler(arg1:flash.events.IEventDispatcher=null)
        {
            this._usersIdDic = new flash.utils.Dictionary(true);
            super(arg1);
            return;
        }

        public function get usersIdDic():flash.utils.Dictionary
        {
            return this._usersIdDic;
        }

        public function loadUsers(arg1:backend.utils.dbUtils.DBUtilObject):void
        {
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, core.user.User.SELECT_ALL_STATEMENT_TEXT, arg1.completeCallback, arg1.errorCallback, arg1.workerTarget);
            return;
        }

        public function saveUser(arg1:core.user.User):void
        {
            new database.DatabaseTransaction(this.saveUserTransaction, [arg1], flash.data.SQLMode.UPDATE).commit();
            return;
        }

        public function loadUserStatement(arg1:int):String
        {
            return "SELECT * FROM User WHERE userId = " + arg1;
        }

        internal function saveUserTransaction(arg1:core.user.User):void
        {
            var p_user:core.user.User;
            var insertArr:Array;
            var stmt:database.DCSQLStatement;

            var loc1:*;
            stmt = null;
            p_user = arg1;
            insertArr = p_user.generateDBInsert();
            stmt = insertArr[0] as database.DCSQLStatement;
            stmt.data = p_user;
            stmt.data2 = p_user.userId == 0;
            stmt.addEventListener(flash.events.SQLErrorEvent.ERROR, this.saveUserError);
            stmt.addEventListener(flash.events.SQLEvent.RESULT, this.saveUserComplete);
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

        internal function saveUserComplete(arg1:flash.events.SQLEvent):void
        {
            var loc1:*=arg1.target as database.DCSQLStatement;
            loc1.removeEventListener(flash.events.SQLEvent.RESULT, this.saveUserComplete);
            loc1.removeEventListener(flash.events.SQLErrorEvent.ERROR, this.saveUserError);
            var loc2:*=loc1.getResult();
            var loc3:*=loc2.lastInsertRowID;
            var loc4:*=loc1.data as core.user.User;
            loc4.userId = loc3;
            if (loc1.data2 as Boolean) 
            {
                configCache.ConfigCache.getInstance().enableUser(loc4.userId);
                configCache.ConfigCache.getInstance().saveCache();
            }
            handler.AppDBHandler.getInstance().commit();
            dispatchEvent(new core.user.UserEvent(SAVE_USER_COMPLETE, loc4));
            return;
        }

        internal function saveUserError(arg1:flash.events.SQLErrorEvent):void
        {
            var loc1:*=arg1.target as database.DCSQLStatement;
            loc1.removeEventListener(flash.events.SQLEvent.RESULT, this.saveUserComplete);
            loc1.removeEventListener(flash.events.SQLErrorEvent.ERROR, this.saveUserError);
            var loc2:*=loc1.data as core.user.User;
            handler.AppDBHandler.getInstance().close();
            dispatchEvent(new com.logging.ErrorLoggingEvent(com.logging.ErrorLoggingEvent.ERROR, core.general.ErrorLoggingTyp.ERROR_INSERT_SPORT, core.general.ErrorLoggingTyp.DESC_ERROR_INSERT_SPORT + arg1.text + " " + "DetailsId: " + arg1.error.detailID + ", " + "Details: " + arg1.error.details));
            dispatchEvent(new core.user.UserEvent(SAVE_USER_ERROR, loc2));
            return;
        }

        internal function deleteUserTransaction(arg1:core.user.User):void
        {
            var p_user:core.user.User;
            var insertArr:Array;
            var stmt:database.DCSQLStatement;

            var loc1:*;
            stmt = null;
            p_user = arg1;
            insertArr = p_user.generateDBDelete();
            stmt = insertArr[0] as database.DCSQLStatement;
            stmt.data = p_user;
            stmt.addEventListener(flash.events.SQLErrorEvent.ERROR, this.deleteUserError);
            stmt.addEventListener(flash.events.SQLEvent.RESULT, this.deleteUserComplete);
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

        internal function deleteUserComplete(arg1:flash.events.SQLEvent):void
        {
            var loc1:*=arg1.target as database.DCSQLStatement;
            loc1.removeEventListener(flash.events.SQLEvent.RESULT, this.deleteUserComplete);
            loc1.removeEventListener(flash.events.SQLErrorEvent.ERROR, this.deleteUserError);
            var loc2:*=loc1.data as core.user.User;
            configCache.ConfigCache.getInstance().disableUser(loc2.userId);
            configCache.ConfigCache.getInstance().saveCache();
            handler.AppDBHandler.getInstance().commit();
            dispatchEvent(new core.user.UserEvent(DELETE_USER_COMPLETE, loc2));
            return;
        }

        internal function deleteUserError(arg1:flash.events.SQLErrorEvent):void
        {
            var loc1:*=arg1.target as database.DCSQLStatement;
            loc1.removeEventListener(flash.events.SQLEvent.RESULT, this.saveUserComplete);
            loc1.removeEventListener(flash.events.SQLErrorEvent.ERROR, this.saveUserError);
            var loc2:*=loc1.data as core.user.User;
            handler.AppDBHandler.getInstance().close();
            dispatchEvent(new com.logging.ErrorLoggingEvent(com.logging.ErrorLoggingEvent.ERROR, core.general.ErrorLoggingTyp.ERROR_INSERT_SPORT, core.general.ErrorLoggingTyp.DESC_ERROR_INSERT_SPORT + arg1.text + " " + "DetailsId: " + arg1.error.detailID + ", " + "Details: " + arg1.error.details));
            dispatchEvent(new core.user.UserEvent(DELETE_USER_ERROR, loc2));
            return;
        }

        public static function getInstance():handler.UserHandler
        {
            if (_instance == null) 
            {
                _instance = new UserHandler();
            }
            return _instance;
        }

        public static const DELETE_USER_COMPLETE:String="deleteUserCompleteEvent";

        public static const DELETE_USER_ERROR:String="deleteUserErrorEvent";

        public static const LOAD_USER_ACTIVITIES_COMPLETE:String="loadUserCompleteEvent";

        public static const LOAD_USER_ACTIVITIES_ERROR:String="loadUserErrorEvent";

        public static const LOAD_USER_COMPLETE:String="loadUserCompleteEvent";

        public static const LOAD_USER_ERROR:String="loadUserErrorEvent";

        public static const SAVE_USER_COMPLETE:String="saveUserCompleteEvent";

        public static const SAVE_USER_ERROR:String="saveUserErrorEvent";

        internal var _usersIdDic:flash.utils.Dictionary;

        internal static var _instance:handler.UserHandler;
    }
}


