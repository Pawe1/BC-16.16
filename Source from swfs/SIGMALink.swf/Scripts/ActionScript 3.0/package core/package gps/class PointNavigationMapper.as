//class PointNavigationMapper
package core.gps 
{
    import core.general.*;
    import database.*;
    import utils.*;
    
    public class PointNavigationMapper extends Object
    {
        public function PointNavigationMapper()
        {
            super();
            return;
        }

        public static function generateDBCreateTable(arg1:uint):database.DatabaseTable
        {
            var loc1:*=null;
        }

        public static function generateDBCreateIndex():String
        {
            var loc1:*="CREATE INDEX IF NOT EXISTS UnitGUIDonPointNavigation ON PointNavigation (unitGUID)";
            return loc1;
        }

        public static function selectPrimaryKeyFromGUID(arg1:core.gps.PointNavigation):String
        {
            return "SELECT pointNavigationId FROM PointNavigation WHERE GUID = \'" + arg1.GUID + "\'";
        }

        public static function getInsertStatement(arg1:Array):String
        {
            return "INSERT OR REPLACE INTO PointNavigation (" + arg1.toString() + ") VALUES (:" + arg1.join(", :") + ");";
        }

        public static function selectPointNavigation(arg1:String, arg2:String="text1", arg3:Boolean=false):String
        {
            return "SELECT * FROM PointNavigation where unitGUID = \'" + arg1 + "\' and isDeleted = false ORDER BY " + arg2 + (arg3 ? " ASC" : " DESC");
        }

        public static function generateXML(arg1:core.gps.PointNavigation):XML
        {
            var loc1:*=new XML("<PointNavigation/>");
            loc1.GUID = arg1.GUID;
            loc1.unitGUID = arg1.unitGUID;
            loc1.unitType = arg1.unitType.toString();
            loc1.modificationDate = arg1.modificationDate;
            loc1.latitude = arg1.latitude;
            loc1.longitude = arg1.longitude;
            loc1.text1 = arg1.text1;
            loc1.text2 = arg1.text2;
            return loc1;
        }

        public static function fromXML(arg1:XML):core.gps.PointNavigation
        {
            arg1.normalize();
            var loc1:*=arg1.name();
            if (loc1.localName != "PointNavigation") 
            {
                return null;
            }
            var loc2:*=new core.gps.PointNavigation();
            loc2.GUID = arg1.GUID;
            loc2.unitGUID = arg1.unitGUID;
            loc2.unitType = core.general.UnitType.fromString(arg1.unitType);
            loc2.modificationDate = arg1.modificationDate;
            loc2.latitude = arg1.latitude;
            loc2.longitude = arg1.longitude;
            loc2.text1 = arg1.text1;
            loc2.text2 = arg1.text2;
            return loc2;
        }

        public static function generateDBInsert(arg1:core.gps.PointNavigation, arg2:Array, arg3:Object):void
        {
            if (arg1.GUID == "" || arg1.GUID == "0") 
            {
                arg1.GUID = utils.GUID.create();
            }
            if (arg1.modificationDate == 0) 
            {
                arg1.modificationDate = new Date().time;
            }
            var loc1:*=0;
            arg2.push("GUID");
            ++loc1;
            arg3[loc1] = arg1.GUID;
            arg2.push("unitGUID");
            ++loc1;
            arg3[loc1] = arg1.unitGUID;
            arg2.push("unitType");
            ++loc1;
            arg3[loc1] = arg1.unitType.toString();
            arg2.push("modificationDate");
            ++loc1;
            arg3[loc1] = arg1.modificationDate;
            arg2.push("isDeleted");
            ++loc1;
            arg3[loc1] = arg1.isDeleted;
            arg2.push("latitude");
            ++loc1;
            arg3[loc1] = arg1.latitude;
            arg2.push("longitude");
            ++loc1;
            arg3[loc1] = arg1.longitude;
            arg2.push("text1");
            ++loc1;
            arg3[loc1] = arg1.text1;
            arg2.push("text2");
            ++loc1;
            arg3[loc1] = arg1.text2;
            return;
        }

        public static function fromDB(arg1:Object):core.gps.PointNavigation
        {
            var loc1:*=new core.gps.PointNavigation();
            loc1.pointNavigationId = arg1["pointNavigationId"];
            loc1.GUID = arg1["GUID"];
            loc1.unitGUID = arg1["unitGUID"];
            loc1.unitType = core.general.UnitType.fromString(arg1["unitType"]);
            loc1.modificationDate = arg1["modificationDate"];
            loc1.isDeleted = arg1["isDeleted"];
            loc1.latitude = arg1["latitude"];
            loc1.longitude = arg1["longitude"];
            loc1.text1 = arg1["text1"];
            loc1.text2 = arg1["text2"];
            return loc1;
        }

        public static function generateDBDelete(arg1:core.gps.PointNavigation):String
        {
            return "delete from PointNavigation where PointNavigation.GUID = " + arg1.GUID;
        }

        public static function prepareDelete(arg1:String):String
        {
            var loc1:*=new Date().time;
            var loc2:*="UPDATE PointNavigation SET isDeleted = true, modificationDate = \'" + loc1 + "\' WHERE GUID = \'" + arg1 + "\'";
            return loc2;
        }

        public static const col_GUID:String="GUID";

        public static const col_isDeleted:String="isDeleted";

        public static const col_latitude:String="latitude";

        public static const col_longitude:String="longitude";

        public static const col_modificationDate:String="modificationDate";

        public static const col_pointNavigationId:String="pointNavigationId";

        public static const col_text1:String="text1";

        public static const col_text2:String="text2";

        public static const col_unitGUID:String="unitGUID";

        public static const col_unitType:String="unitType";

        public static const index_name:String="UnitGUIDonPointNavigation";

        public static const table_name:String="PointNavigation";

        public static var DB_TABLE_520:database.DatabaseTable;
    }
}


