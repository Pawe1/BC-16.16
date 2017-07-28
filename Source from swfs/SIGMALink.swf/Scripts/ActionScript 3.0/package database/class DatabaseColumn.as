//class DatabaseColumn
package database 
{
    public class DatabaseColumn extends Object
    {
        public function DatabaseColumn()
        {
            super();
            return;
        }

        public var allowNull:Boolean=true;

        public var autoIncrement:Boolean=false;

        public var columnName:String="";

        public var columnNewName:String="";

        public var columnType:String="";

        public var defaultValue:Object;

        public var primaryKey:Boolean=false;
    }
}


