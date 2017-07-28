//class TrainingMapper
package core.training 
{
    import __AS3__.vec.*;
    import core.units.*;
    import database.*;
    import handler.*;
    import utils.*;
    import utils.format.*;
    
    public class TrainingMapper extends Object
    {
        public function TrainingMapper()
        {
            super();
            return;
        }

        public static function generateXML(arg1:core.training.Training):XML
        {
            var loc1:*=new XML("<TrainingProgram/>");
            loc1.date = arg1.date.toString();
            loc1.GUID = arg1.GUID;
            loc1.modificationDate = arg1.modificationDate;
            loc1.unitGUID = arg1.unitGUID;
            loc1.name = utils.format.CDATAFormat.getCDataAsXMLNode("name", arg1.name);
            loc1.description = utils.format.CDATAFormat.getCDataAsXMLNode("description", arg1.description);
            var loc2:*=core.training.TrainingPhaseMapper.generateXML(arg1.phasesList);
            loc1.appendChild(loc2);
            return loc1;
        }

        public static function fromXML(arg1:XML):core.training.Training
        {
            var loc2:*=null;
            var loc1:*=handler.AppDeviceHandlerCommon.deviceDicGUID[arg1.unitGUID.text().toString()];
            loc2 = new core.training.Training(loc1, false);
            loc2.date = new Date(arg1.date.text().toString());
            loc2.GUID = arg1.GUID;
            loc2.modificationDate = arg1.modificationDate;
            loc2.unitGUID = arg1.unitGUID;
            loc2.unit = loc1;
            loc2.name = arg1.name;
            loc2.description = arg1.description;
            loc2.phasesList = new __AS3__.vec.Vector.<core.training.TrainingPhase>();
            core.training.TrainingPhaseMapper.fromXML(arg1, loc2.phasesList, loc2);
            return loc2;
        }

        public static function fromDB(arg1:core.training.Training, arg2:Object):void
        {
            arg1.trainingId = arg2["trainingId"];
            arg1.date = new Date(arg2["date"]);
            arg1.GUID = arg2["GUID"];
            arg1.modificationDate = arg2["modificationDate"];
            arg1.isDeleted = arg2["isDeleted"];
            arg1.unitGUID = arg2["unitGUID"];
            arg1.name = arg2["name"];
            arg1.description = arg2["description"];
            return;
        }

        public static function generateDBCreateTable(arg1:uint):database.DatabaseTable
        {
            var loc1:*=null;
            var loc2:*=arg1;
            while (400 === loc2) 
            {
                DB_TABLE_400 = new database.DatabaseTable("Training");
                DB_TABLE_400.addColumns([["trainingId", "INTEGER", false, true, true], ["date", "VARCHAR", true], ["GUID", "VARCHAR UNIQUE", false], ["modificationDate", "NUMERIC", true], ["isDeleted", "BOOL", true], ["unitGUID", "VARCHAR", false], ["name", "VARCHAR", true], ["description", "VARCHAR", true], ["emptyField1", "VARCHAR", true]]);
                loc1 = DB_TABLE_400;
            }
        }

        public static function generateDBCreateIndex():String
        {
            var loc1:*="CREATE INDEX IF NOT EXISTS UnitGUIDOnTraining ON Training (unitGUID)";
            return loc1;
        }

        public static function generateDBCreateTrigger(arg1:uint):String
        {
            var loc1:*=null;
            var loc2:*=arg1;
            while (400 === loc2) 
            {
                loc1 = "CREATE TRIGGER IF NOT EXISTS TrainingTrigger AFTER DELETE ON Training FOR EACH ROW BEGIN DELETE FROM TrainingPhase WHERE TrainingPhase.trainingId = OLD.trainingId;END";
            }
        }

        public static function generateDBDelete(arg1:core.training.Training):String
        {
            return "DELETE FROM Training WHERE GUID = \'" + arg1.GUID + "\'";
        }

        public static function prepareDelete(arg1:String):String
        {
            var loc1:*=new Date().time;
            var loc2:*="UPDATE Training SET isDeleted = true, modificationDate = \'" + loc1 + "\' WHERE GUID = \'" + arg1 + "\'";
            return loc2;
        }

        public static function selectPrimaryKeyFromGUID(arg1:core.training.Training):String
        {
            return "SELECT trainingId FROM Training WHERE GUID = \'" + arg1.GUID + "\'";
        }

        public static function getInsertStatement(arg1:Array):String
        {
            return "INSERT OR REPLACE INTO Training (" + arg1.toString() + ") VALUES (:" + arg1.join(", :") + ");";
        }

        public static function selectTrainings(arg1:String, arg2:String="modificationDate", arg3:Boolean=false):String
        {
            var loc1:*;
            return loc1 = "SELECT * FROM Training where unitGUID = \'" + arg1 + "\' and isDeleted = false ORDER BY " + arg2 + (arg3 ? " ASC" : " DESC");
        }

        public static function generateDBInsert(arg1:core.training.Training, arg2:Array, arg3:Object):void
        {
            if (arg1.GUID == "" || arg1.GUID == "0") 
            {
                arg1.GUID = utils.GUID.create();
            }
            if (arg1.modificationDate == 0) 
            {
                arg1.modificationDate = new Date().time;
            }
            arg2.push("trainingId");
            arg3[":trainingId"] = arg1.trainingId > 0 ? arg1.trainingId : null;
            arg2.push("date");
            arg3[":date"] = arg1.date.toString();
            arg2.push("GUID");
            arg3[":GUID"] = arg1.GUID;
            arg2.push("modificationDate");
            arg3[":modificationDate"] = arg1.modificationDate;
            arg2.push("isDeleted");
            arg3[":isDeleted"] = arg1.isDeleted;
            arg2.push("unitGUID");
            arg3[":unitGUID"] = arg1.unitGUID;
            arg2.push("name");
            arg3[":name"] = arg1.name;
            arg2.push("description");
            arg3[":description"] = arg1.description;
            return;
        }

        public static const col_GUID:String="GUID";

        public static const col_date:String="date";

        public static const col_description:String="description";

        public static const col_isDeleted:String="isDeleted";

        public static const col_modificationDate:String="modificationDate";

        public static const col_name:String="name";

        public static const col_trainingId:String="trainingId";

        public static const col_unitGUID:String="unitGUID";

        public static const table_name:String="Training";

        public static var DB_TABLE_400:database.DatabaseTable;

        public static var DB_TABLE_500:database.DatabaseTable;

        public static var DB_TABLE_510:database.DatabaseTable;

        public static var DB_TABLE_520:database.DatabaseTable;
    }
}


