//class DatabaseTable
package database 
{
    import __AS3__.vec.*;
    
    public class DatabaseTable extends Object
    {
        public function DatabaseTable(arg1:String, arg2:String="")
        {
            super();
            tableName = arg1;
            customCreationDefinition = arg2;
            return;
        }

        public function addColumns(arg1:Array):void
        {
            var loc2:*=0;
            var loc3:*=null;
            if (!columns) 
            {
                columns = new __AS3__.vec.Vector.<database.DatabaseColumn>();
            }
            var loc1:*=arg1.length;
            loc2 = 0;
            while (loc2 < loc1) 
            {
                (loc3 = new database.DatabaseColumn()).columnName = arg1[loc2][0] as String;
                loc3.columnType = arg1[loc2][1] as String;
                loc3.allowNull = arg1[loc2][2] as Boolean;
                loc3.primaryKey = arg1[loc2][3] as Boolean;
                loc3.autoIncrement = arg1[loc2][4] as Boolean;
                loc3.defaultValue = arg1[loc2][5];
                if ((arg1[loc2] as Array).length > 3) 
                {
                    loc3.columnNewName = arg1[loc2][3] as String;
                }
                columns.push(loc3);
                ++loc2;
            }
            return;
        }

        public function createTableStatement():String
        {
            return "CREATE TABLE IF NOT EXISTS " + tableName + " (" + columnDefinitions() + ")";
        }

        public function columnDefinitions():String
        {
            var loc3:*=null;
            var loc5:*=0;
            var loc1:*="";
            var loc2:*=columns.length;
            var loc4:*=[];
            loc5 = 0;
            while (loc5 < loc2) 
            {
                loc3 = columns[loc5];
                loc1 = loc1 + (loc3.columnName + " " + loc3.columnType);
                if (loc3.primaryKey) 
                {
                    loc4.push(loc3.columnName);
                }
                if (loc3.autoIncrement) 
                {
                    loc1 = loc1 + " AUTOINCREMENT";
                }
                if (!loc3.allowNull) 
                {
                    loc1 = loc1 + " NOT NULL";
                }
                if (loc3.defaultValue) 
                {
                    loc1 = loc1 + (" DEFAULT " + loc3.defaultValue);
                }
                if (loc5 < (loc2 - 1)) 
                {
                    loc1 = loc1 + ", ";
                }
                ++loc5;
            }
            if (customCreationDefinition.length > 0) 
            {
                loc1 = loc1 + (", " + customCreationDefinition);
            }
            if (loc4.length > 0) 
            {
                if (loc4.length != 1) 
                {
                    loc1 = loc1 + (", PRIMARY KEY (" + loc4.join(",") + ")");
                }
                else 
                {
                    loc1 = loc1.replace("AUTOINCREMENT", "PRIMARY KEY AUTOINCREMENT");
                }
            }
            return loc1;
        }

        public function columnNames():String
        {
            var loc3:*=null;
            var loc4:*=0;
            var loc1:*="";
            var loc2:*=columns.length;
            loc4 = 0;
            while (loc4 < loc2) 
            {
                loc3 = columns[loc4];
                loc1 = loc1 + loc3.columnName;
                if (loc4 < (loc2 - 1)) 
                {
                    loc1 = loc1 + ", ";
                }
                ++loc4;
            }
            return loc1;
        }

        public function createInsertStatement():String
        {
            var loc1:*=getAllColumns();
            var loc5:*="INSERT OR REPLACE INTO " + tableName + " (" + loc1.join(",") + ") VALUES (";
            var loc3:*=0;
            var loc2:*=loc1.length;
            var loc4:*=[];
            loc3 = 0;
            while (loc3 < loc2) 
            {
                loc4.push("?");
                ++loc3;
            }
            return loc5 = loc5 + (loc4.join(",") + ")");
        }

        public function createSelectStatement():String
        {
            return "SELECT * FROM " + tableName;
        }

        internal function getAllColumns():Array
        {
            var loc3:*=null;
            var loc4:*=0;
            var loc1:*=[];
            var loc2:*=columns.length;
            loc4 = 0;
            while (loc4 < loc2) 
            {
                loc3 = columns[loc4];
                loc1.push(loc3.columnName);
                ++loc4;
            }
            return loc1;
        }

        public var columns:__AS3__.vec.Vector.<database.DatabaseColumn>;

        public var customCreationDefinition:String;

        public var tableName:String;
    }
}


