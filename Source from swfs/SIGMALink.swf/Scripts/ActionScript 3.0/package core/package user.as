//package user
//  package interfaces
//    class IUserHandler
package core.user.interfaces 
{
    import flash.utils.*;
    
    public dynamic interface IUserHandler
    {
        function get usersIdDic():flash.utils.Dictionary;
    }
}


//  class User
package core.user 
{
    import __AS3__.vec.*;
    import core.general.*;
    import core.general.interfaces.*;
    import database.*;
    import flash.events.*;
    
    public class User extends flash.events.EventDispatcher implements core.general.interfaces.IDatabase
    {
        public function User(arg1:flash.events.IEventDispatcher=null)
        {
            activityIds = new __AS3__.vec.Vector.<int>();
            _color = DEFAULT_COLOR;
            super(arg1);
            return;
        }

        public static function generateInsertUserString():String
        {
            var loc3:*=0;
            var loc2:*=[];
            var loc1:*=COLUMNS.length;
            loc3 = 0;
            while (loc3 < loc1) 
            {
                loc2.push("?");
                ++loc3;
            }
            return "INSERT OR REPLACE INTO User (" + COLUMNS.join(",") + ") VALUES (" + loc2.join(",") + ")";
        }

        public function generateDBInsert():Array
        {
            if (_insertStatement == null) 
            {
                _insertStatement = new database.DCSQLStatement();
                _insertStatement.text = generateInsertUserString();
            }
            _insertStatement.parameters[0] = userId > 0 ? userId : null;
            _insertStatement.parameters[1] = name;
            _insertStatement.parameters[2] = gender;
            _insertStatement.parameters[3] = color;
            return [_insertStatement];
        }

        public function get color():int
        {
            return _color;
        }

        public function set color(arg1:int):void
        {
            _color = arg1;
            return;
        }

        public function generateDBSelect():Array
        {
            if (_selectStatement == null) 
            {
                _selectStatement = new database.DCSQLStatement();
                _selectStatement.text = "SELECT userId AS pk, * FROM User WHERE User.userId = @fk";
            }
            return [_selectStatement];
        }

        public function get gender():String
        {
            return _gender;
        }

        public function set gender(arg1:String):void
        {
            _gender = arg1;
            return;
        }

        public function generateDBDelete():Array
        {
            if (_deleteStatement == null) 
            {
                _deleteStatement = new database.DCSQLStatement();
                _deleteStatement.text = "DELETE FROM User WHERE User.userId = " + userId;
            }
            return [_deleteStatement];
        }

        public function get name():String
        {
            return _name;
        }

        public function set name(arg1:String):void
        {
            _name = arg1;
            return;
        }

        public function fromDB(arg1:Object):void
        {
            userId = arg1["userId"];
            name = arg1["name"];
            gender = arg1["gender"];
            color = arg1["color"];
            return;
        }

        public function get userId():int
        {
            return _userId;
        }

        public function set userId(arg1:int):void
        {
            _userId = arg1;
            return;
        }

        public static function generateDBCreateTable(arg1:uint):database.DatabaseTable
        {
            var loc1:*=null;
            var loc2:*=arg1;
            while (400 === loc2) 
            {
                DB_TABLE_400 = new database.DatabaseTable("User");
                DB_TABLE_400.addColumns([["userId", "INTEGER", false, true, true], ["name", "VARCHAR", false], ["gender", "VARCHAR", false], ["color", "INTEGER", false]]);
                loc1 = DB_TABLE_400;
            }
        }

        public static function statementGetUsers(arg1:int=0):String
        {
            var loc1:*="";
            loc1 = "SELECT userId AS pk, * FROM User";
            if (arg1 > 0) 
            {
                loc1 = loc1 + (" WHERE User.userId = " + arg1);
            }
            return loc1;
        }

        public static function selectUserIdStatement(arg1:String):String
        {
            return "SELECT userId FROM User WHERE name = \'" + arg1 + "\' COLLATE NOCASE";
        }

        public static const COL_USER_ID:String="userId";

        public static const DEFAULT_COLOR:int=core.general.Colors.darkenColor(65280, 30);

        public static const DEFAULT_GENDER:String="male";

        public static const DEFAULT_NAME:String="";

        public static const SELECT_ALL_STATEMENT_TEXT:String="SELECT * FROM User";

        public static const TABLE_NAME:String="User";

        public static const COLUMNS:Array=["userId", "name", "gender", "color"];

        public static const COL_COLOR:String="color";

        public static const COL_GENDER:String="gender";

        public static const COL_NAME:String="name";

        public var activityIds:__AS3__.vec.Vector.<int>;

        protected var _color:int;

        protected var _gender:String="male";

        protected var _name:String="";

        protected var _userId:int;

        internal var _deleteStatement:database.DCSQLStatement;

        internal var _insertReferenceStatement:database.DCSQLStatement;

        internal var _insertStatement:database.DCSQLStatement;

        internal var _selectStatement:database.DCSQLStatement;

        public static var DB_TABLE_400:database.DatabaseTable;

        public static var DB_TABLE_500:database.DatabaseTable;

        public static var DB_TABLE_510:database.DatabaseTable;

        public static var DB_TABLE_520:database.DatabaseTable;
    }
}


//  class UserEvent
package core.user 
{
    import flash.events.*;
    
    public class UserEvent extends flash.events.Event
    {
        public function UserEvent(arg1:String, arg2:core.user.User=null, arg3:Boolean=false, arg4:Boolean=false)
        {
            super(arg1, arg3, arg4);
            user = arg2;
            return;
        }

        public var user:core.user.User;
    }
}


