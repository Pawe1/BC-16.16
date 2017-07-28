//class RouteOptions
package core.route 
{
    import database.*;
    import flash.events.*;
    import utils.dataprovider.*;
    
    public class RouteOptions extends flash.events.EventDispatcher
    {
        public function RouteOptions(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            return;
        }

        public function get param():String
        {
            return _param;
        }

        public function set param(arg1:String):void
        {
            _param = arg1;
            sportId = utils.dataprovider.CommonRouteOptionsDataProvider.resolveSportId(arg1);
            return;
        }

        public function get routeId():int
        {
            return _routeId;
        }

        public function set routeId(arg1:int):void
        {
            _routeId = arg1;
            return;
        }

        public function setPrimaryKey(arg1:int):void
        {
            if (routeId == 0) 
            {
                routeId = arg1;
            }
            return;
        }

        public function fromDB(arg1:Object):void
        {
            routeId = arg1.routeId;
            param = arg1.param;
            return;
        }

        public function generateDBInsert():database.DCSQLStatement
        {
            var loc3:*="routeId, param";
            var loc1:*=routeId > 0 ? "\"" + routeId + "\"," : "NULL,";
            loc1 = loc1 + ("\"" + param + "\"");
            var loc2:*=new database.DCSQLStatement();
            loc2.text = "insert or replace into RouteOptions (" + loc3 + ") values (" + loc1 + ")";
            return loc2;
        }

        public function generateDBDelete():database.DCSQLStatement
        {
            var loc1:*=new database.DCSQLStatement();
            loc1.text = "DELETE FROM RouteOptions WHERE routeId = " + this.routeId + " AND param = " + "\"" + param + "\"";
            return loc1;
        }

        public function generateDBSelectByRouteId(arg1:int):database.DCSQLStatement
        {
            var loc1:*=new database.DCSQLStatement();
            loc1.text = "select * from RouteOptions WHERE routeId = " + arg1.toString();
            return loc1;
        }

        public function getLoggingInfo():String
        {
            return "\t-routeId " + routeId.toString() + "\t-param " + param.toString();
        }

        public static function generateDBCreateTable(arg1:uint):database.DatabaseTable
        {
            var loc1:*=null;
            var loc2:*=arg1;
            while (400 === loc2) 
            {
                DB_TABLE_400 = new database.DatabaseTable("RouteOptions");
                DB_TABLE_400.addColumns([["routeId", "INTEGER", false], ["param", "VARCHAR", false]]);
                loc1 = DB_TABLE_400;
            }
        }

        public static function generateDBDeleteAllSports(arg1:int):String
        {
            return "DELETE FROM RouteOptions WHERE routeId = " + arg1 + " and " + "param" + " in (" + utils.dataprovider.CommonRouteOptionsDataProvider.resolveSportParams().join(",") + ")";
        }

        public static function generateDBDeleteAllCategories(arg1:int):String
        {
            return "DELETE FROM RouteOptions WHERE routeId = " + arg1 + " and " + "param" + " in (" + utils.dataprovider.CommonRouteOptionsDataProvider.resolveCategoryParams().join(",") + ")";
        }

        public static const FLAT:String="flat";

        public static const HILLY:String="hilly";

        public static const MOUNTAINOUS:String="mountainous";

        public static const col_param:String="param";

        public static const col_routeId:String="routeId";

        public static const table_name:String="RouteOptions";

        protected var _param:String="";

        protected var _routeId:int;

        public var sportId:int=0;

        public static var DB_TABLE_400:database.DatabaseTable;

        public static var DB_TABLE_500:database.DatabaseTable;

        public static var DB_TABLE_510:database.DatabaseTable;

        public static var DB_TABLE_520:database.DatabaseTable;
    }
}


