//class Person
package core.participant 
{
    import com.logging.*;
    import core.activities.*;
    import database.*;
    import flash.events.*;
    
    public class Person extends flash.events.EventDispatcher
    {
        public function Person(arg1:flash.events.IEventDispatcher=null, arg2:int=0, arg3:String="female", arg4:String="")
        {
            super(arg1);
            color = arg2;
            gender = arg3;
            name = arg4;
            com.logging.ErrorLogging.getInstance().addTarget(this);
            return;
        }

        public static function generateDBCreateTableActivityPerson(arg1:uint):database.DatabaseTable
        {
            var loc1:*=null;
            var loc2:*=arg1;
            while (400 === loc2) 
            {
                loc1 = new database.DatabaseTable("ActivityPerson");
                loc1.addColumns([["activityId", "INTEGER", false, true], ["personId", "INTEGER", false, true]]);
            }
        }

        public function get color():int
        {
            return this._color;
        }

        public function set color(arg1:int):void
        {
            if (arg1 != this._color) 
            {
                this._color = arg1;
                dispatchEvent(new flash.events.Event("colorChange"));
            }
            return;
        }

        public static function getActivityPersonColNames():Array
        {
            return ["activityId", "personId"];
        }

        public function get foreignKey():int
        {
            return _foreignKey;
        }

        public function set foreignKey(arg1:int):void
        {
            _foreignKey = arg1;
            return;
        }

        public static function generateDBSelectAllPerson():database.DCSQLStatement
        {
            var loc1:*=new database.DCSQLStatement();
            loc1.text = statementDBSelectAllPerson();
            return loc1;
        }

        public function get gender():String
        {
            return this._gender;
        }

        public function set gender(arg1:String):void
        {
            if (arg1 == this._gender) 
            {
                return;
            }
            if (!(arg1 == null) && !(arg1 == "female") && !(arg1 == "male") && !(arg1 == "group")) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 10007, "Person > set gender: Illegal type of gender"));
            }
            this._gender = arg1;
            dispatchEvent(new flash.events.Event("genderChange"));
            return;
        }

        public static function statementDBSelectAllPerson():String
        {
            return "SELECT * FROM Person";
        }

        public function get name():String
        {
            return this._name;
        }

        public function set name(arg1:String):void
        {
            if (arg1 != this._name) 
            {
                this._name = arg1;
                dispatchEvent(new flash.events.Event("nameChange"));
            }
            return;
        }

        public static function generateDBDeletePerson(arg1:core.participant.Person):Array
        {
            var loc3:*=[];
            var loc2:*=new database.DCSQLStatement();
            loc2.text = "DELETE FROM Person where Person.personId = " + arg1.personId;
            loc3.push(loc2);
            var loc1:*=new database.DCSQLStatement();
            loc1.text = "DELETE FROM ActivityPerson where ActivityPerson.personId = " + arg1.personId;
            loc3.push(loc1);
            return loc3;
        }

        public function get personId():int
        {
            return _personId;
        }

        public function set personId(arg1:int):void
        {
            _personId = arg1;
            return;
        }

        public override function toString():String
        {
            return "[Person extends EventDispatcher]";
        }

        public function toXML():XML
        {
            return new XML("<Person color=\"" + this.color + "\" gender=\"" + this.gender + "\">" + "<PersonName><![CDATA[" + this.name + "]]></PersonName>" + "</Person>");
        }

        public static function generateLoadPersonId(arg1:core.participant.Person):String
        {
            return "SELECT personId FROM Person WHERE personName = \'" + arg1.name + "\'";
        }

        public static function generateDBPersonInsert(arg1:core.participant.Person):String
        {
            var loc2:*="personId, gender, color, personName";
            var loc1:*=arg1.personId > 0 ? "\"" + arg1.personId + "\"," : "NULL,";
            loc1 = loc1 + ("\"" + arg1.gender + "\", \"" + arg1.color + "\", \"" + arg1.name + "\"");
            return "INSERT OR REPLACE INTO Person (" + loc2 + ") VALUES (" + loc1 + ")";
        }

        public static function generateDBActivityPersonInsert(arg1:core.activities.Activity):String
        {
            var loc2:*="activityId, personId";
            var loc1:*=arg1.activityId > 0 ? "\"" + arg1.activityId + "\"," : "NULL,";
            loc1 = loc1 + "@fk";
            return "insert or replace into ActivityPerson (" + loc2 + ") values (" + loc1 + ")";
        }

        public static function createFromXML(arg1:XML):core.participant.Person
        {
            return new Person(null, arg1.@color, arg1.@gender, arg1.PersonName);
        }

        public static function createPersonFromDB(arg1:Object):core.participant.Person
        {
            var loc1:*=new Person();
            loc1.foreignKey = arg1.activityId;
            loc1.personId = arg1.personId;
            loc1.gender = arg1.gender;
            loc1.color = arg1.color;
            loc1.name = arg1.personName;
            return loc1;
        }

        public static function setForeignKey(arg1:core.participant.Person, arg2:Object):void
        {
            arg1.foreignKey = arg2.activityId;
            return;
        }

        public static function generateDBCreateTable(arg1:uint):database.DatabaseTable
        {
            var loc1:*=null;
            var loc2:*=arg1;
            while (400 === loc2) 
            {
                DB_TABLE_400 = new database.DatabaseTable("Person");
                DB_TABLE_400.addColumns([["personId", "INTEGER", false, true, true], ["gender", "VARCHAR", true], ["color", "INTEGER", true], ["personName", "VARCHAR", true]]);
                loc1 = DB_TABLE_400;
            }
        }

        public static const col_gender:String="gender";

        public static const col_personId:String="personId";

        public static const col_personName:String="personName";

        public static const table_name:String="Person";

        public static const table_name_activityPerson:String="ActivityPerson";

        public static const col_activityId:String="activityId";

        public static const col_color:String="color";

        internal var _color:int;

        internal var _foreignKey:int;

        internal var _gender:String="female";

        internal var _name:String="";

        internal var _personId:int;

        public static var DB_TABLE_400:database.DatabaseTable;

        public static var DB_TABLE_500:database.DatabaseTable;

        public static var DB_TABLE_520:database.DatabaseTable;

        public static var DB_TABLE_510:database.DatabaseTable;
    }
}


