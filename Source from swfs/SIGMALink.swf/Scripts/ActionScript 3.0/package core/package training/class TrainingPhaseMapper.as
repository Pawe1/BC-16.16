//class TrainingPhaseMapper
package core.training 
{
    import __AS3__.vec.*;
    import core.training.type.*;
    import database.*;
    
    public class TrainingPhaseMapper extends Object
    {
        public function TrainingPhaseMapper()
        {
            super();
            return;
        }

        public static function generateXML(arg1:__AS3__.vec.Vector.<core.training.TrainingPhase>):XML
        {
            var loc1:*=null;
            var loc3:*=null;
            var loc5:*=new XML("<Phases/>");
            var loc4:*=0;
            var loc2:*=arg1.length;
            loc4 = 0;
            while (loc4 < loc2) 
            {
                loc3 = new XML("<Phase/>");
                loc1 = arg1[loc4];
                loc3.@type = loc1.type.toString();
                loc3.@position = loc1.position;
                loc3.@titel = loc1.titel;
                loc3.@phaseChangeMode = loc1.phaseChangeMode.toString();
                loc3.@iterations = loc1.iterations;
                loc3.@loadDuration = loc1.loadDuration;
                loc3.@loadPhaseControl = loc1.loadPhaseControl.toString();
                loc3.@loadTargetType = loc1.loadTargetType.toString();
                loc3.@loadTargetMin = loc1.loadTargetMin;
                loc3.@loadTargetMax = loc1.loadTargetMax;
                loc3.@loadTargetValue = loc1.loadTargetValue;
                loc3.@loadRecovery = loc1.loadRecovery.toString();
                loc3.@loadDistance = loc1.loadDistance;
                loc3.@recoveryDuration = loc1.recoveryDuration;
                loc3.@recoveryPhaseControl = loc1.recoveryPhaseControl.toString();
                loc3.@recoveryTargetType = loc1.recoveryTargetType.toString();
                loc3.@recoveryTargetMin = loc1.recoveryTargetMin;
                loc3.@recoveryTargetMax = loc1.recoveryTargetMax;
                loc3.@recoveryTargetValue = loc1.recoveryTargetValue;
                loc3.@recoveryDistance = loc1.recoveryDistance;
                loc5.appendChild(loc3);
                ++loc4;
            }
            return loc5;
        }

        public static function fromXML(arg1:XML, arg2:__AS3__.vec.Vector.<core.training.TrainingPhase>, arg3:core.training.Training):void
        {
            var loc3:*=null;
            var loc1:*=null;
            var loc5:*=0;
            var loc4:*=null;
            var loc2:*=(loc4 = arg1.Phases.Phase).length();
            loc5 = 0;
            while (loc5 < loc2) 
            {
                loc3 = loc4[loc5];
                (loc1 = new core.training.TrainingPhase()).training = arg3;
                loc1.type = core.training.type.PhaseCategory.fromString(loc3.@type);
                loc1.position = loc3.@position;
                loc1.titel = loc3.@titel;
                loc1.phaseChangeMode = core.training.type.PhaseChangeMode.fromString(loc3.@phaseChangeMode);
                loc1.iterations = loc3.@iterations;
                loc1.loadDuration = loc3.@loadDuration;
                loc1.loadPhaseControl = core.training.type.PhaseControl.fromString(loc3.@loadPhaseControl);
                loc1.loadTargetType = core.training.type.PhaseTarget.fromString(loc3.@loadTargetType);
                loc1.loadTargetMin = loc3.@loadTargetMin;
                loc1.loadTargetMax = loc3.@loadTargetMax;
                loc1.loadTargetValue = loc3.@loadTargetValue;
                loc1.loadRecovery = core.training.type.PhaseLoadRecovery.fromString(loc3.@loadRecovery);
                loc1.loadDistance = loc3.@loadDistance;
                loc1.recoveryDuration = loc3.@recoveryDuration;
                loc1.recoveryPhaseControl = core.training.type.PhaseControl.fromString(loc3.@recoveryPhaseControl);
                loc1.recoveryTargetType = core.training.type.PhaseTarget.fromString(loc3.@recoveryTargetType);
                loc1.recoveryTargetMin = loc3.@recoveryTargetMin;
                loc1.recoveryTargetMax = loc3.@recoveryTargetMax;
                loc1.recoveryTargetValue = loc3.@recoveryTargetValue;
                loc1.recoveryDistance = loc3.@recoveryDistance;
                arg2.push(loc1);
                ++loc5;
            }
            return;
        }

        public static function generateDBInsert(arg1:core.training.TrainingPhase, arg2:Array, arg3:Object):void
        {
            if (arg1.trainingPhaseId > 0) 
            {
                arg2.push("trainingPhaseId");
                arg3[":trainingPhaseId"] = arg1.trainingPhaseId;
            }
            arg2.push("trainingId");
            if (arg1.training) 
            {
                arg1.trainingId = arg1.training.trainingId;
            }
            arg3[":trainingId"] = arg1.trainingId;
            arg2.push("type");
            arg3[":type"] = arg1.type ? arg1.type.toString() : null;
            arg2.push("position");
            arg3[":position"] = arg1.position;
            arg2.push("titel");
            arg3[":titel"] = arg1.titel;
            arg2.push("phaseChangeMode");
            arg3[":phaseChangeMode"] = arg1.phaseChangeMode ? arg1.phaseChangeMode.toString() : null;
            arg2.push("iterations");
            arg3[":iterations"] = arg1.iterations;
            arg2.push("loadDuration");
            arg3[":loadDuration"] = arg1.loadDuration;
            arg2.push("loadPhaseControl");
            arg3[":loadPhaseControl"] = arg1.loadPhaseControl ? arg1.loadPhaseControl.toString() : null;
            arg2.push("loadTargetType");
            arg3[":loadTargetType"] = arg1.loadTargetType ? arg1.loadTargetType.toString() : null;
            arg2.push("loadTargetMin");
            arg3[":loadTargetMin"] = arg1.loadTargetMin;
            arg2.push("loadTargetMax");
            arg3[":loadTargetMax"] = arg1.loadTargetMax;
            arg2.push("loadTargetValue");
            arg3[":loadTargetValue"] = arg1.loadTargetValue;
            arg2.push("loadDistance");
            arg3[":loadDistance"] = arg1.loadDistance;
            arg2.push("loadRecovery");
            arg3[":loadRecovery"] = arg1.loadRecovery ? arg1.loadRecovery.toString() : null;
            arg2.push("recoveryDuration");
            arg3[":recoveryDuration"] = arg1.recoveryDuration.toString();
            arg2.push("recoveryPhaseControl");
            arg3[":recoveryPhaseControl"] = arg1.recoveryPhaseControl ? arg1.recoveryPhaseControl.toString() : null;
            arg2.push("recoveryTargetType");
            arg3[":recoveryTargetType"] = arg1.recoveryTargetType ? arg1.recoveryTargetType.toString() : null;
            arg2.push("recoveryTargetMin");
            arg3[":recoveryTargetMin"] = arg1.recoveryTargetMin;
            arg2.push("recoveryTargetMax");
            arg3[":recoveryTargetMax"] = arg1.recoveryTargetMax;
            arg2.push("recoveryTargetValue");
            arg3[":recoveryTargetValue"] = arg1.recoveryTargetValue;
            arg2.push("recoveryDistance");
            arg3[":recoveryDistance"] = arg1.recoveryDistance;
            return;
        }

        public static function fromDB(arg1:core.training.TrainingPhase, arg2:Object):void
        {
            arg1.trainingPhaseId = arg2["trainingPhaseId"];
            arg1.trainingId = arg2["trainingId"];
            arg1.type = core.training.type.PhaseCategory.fromString(arg2["type"]);
            arg1.position = arg2["position"];
            arg1.titel = arg2["titel"];
            arg1.phaseChangeMode = core.training.type.PhaseChangeMode.fromString(arg2["phaseChangeMode"]);
            arg1.iterations = arg2["iterations"];
            arg1.loadDuration = arg2["loadDuration"];
            arg1.loadPhaseControl = core.training.type.PhaseControl.fromString(arg2["loadPhaseControl"]);
            arg1.loadTargetType = core.training.type.PhaseTarget.fromString(arg2["loadTargetType"]);
            arg1.loadTargetMin = arg2["loadTargetMin"];
            arg1.loadTargetMax = arg2["loadTargetMax"];
            arg1.loadTargetValue = arg2["loadTargetValue"];
            arg1.loadDistance = arg2["loadDistance"];
            arg1.loadRecovery = core.training.type.PhaseLoadRecovery.fromString(arg2["loadRecovery"]);
            arg1.recoveryDuration = arg2["recoveryDuration"];
            arg1.recoveryPhaseControl = core.training.type.PhaseControl.fromString(arg2["recoveryPhaseControl"]);
            arg1.recoveryTargetType = core.training.type.PhaseTarget.fromString(arg2["recoveryTargetType"]);
            arg1.recoveryTargetMin = arg2["recoveryTargetMin"];
            arg1.recoveryTargetMax = arg2["recoveryTargetMax"];
            arg1.recoveryTargetValue = arg2["recoveryTargetValue"];
            arg1.recoveryDistance = arg2["recoveryDistance"];
            return;
        }

        public static function generateDBCreateTable(arg1:uint):database.DatabaseTable
        {
            var loc1:*=null;
            var loc2:*=arg1;
            while (400 === loc2) 
            {
                DB_TABLE_400 = new database.DatabaseTable("TrainingPhase");
                DB_TABLE_400.addColumns([["trainingPhaseId", "INTEGER", false, true, true], ["trainingId", "INTEGER", false], ["type", "VARCHAR", true], ["position", "INTEGER", true], ["titel", "VARCHAR", true], ["phaseChangeMode", "VARCHAR", true], ["iterations", "INTEGER", true], ["loadDuration", "INTEGER", true], ["loadPhaseControl", "VARCHAR", true], ["loadTargetType", "VARCHAR", true], ["loadTargetMin", "INTEGER", true], ["loadTargetMax", "INTEGER", true], ["loadRecovery", "VARCHAR", true], ["loadDistance", "NUMERIC", true], ["recoveryDuration", "INTEGER", true], ["recoveryPhaseControl", "VARCHAR", true], ["recoveryTargetType", "VARCHAR", true], ["recoveryTargetMin", "INTEGER", true], ["recoveryTargetMax", "INTEGER", true], ["recoveryDistance", "NUMERIC", true], ["emptyField1", "VARCHAR", true], ["emptyField2", "VARCHAR", true]]);
                loc1 = DB_TABLE_400;
            }
        }

        public static function generateDBCreateIndex():String
        {
            var loc1:*="CREATE INDEX IF NOT EXISTS TrainingIdOnTrainingPhase ON TrainingPhase (trainingId)";
            return loc1;
        }

        public static function getInsertStatement(arg1:Array):String
        {
            return "INSERT OR REPLACE INTO TrainingPhase (" + arg1.toString() + ") VALUES (:" + arg1.join(", :") + ");";
        }

        public static const col_iterations:String="iterations";

        public static const col_loadDistance:String="loadDistance";

        public static const col_loadDuration:String="loadDuration";

        public static const col_loadPhaseControl:String="loadPhaseControl";

        public static const col_loadRecovery:String="loadRecovery";

        public static const col_loadTargetMax:String="loadTargetMax";

        public static const col_loadTargetMin:String="loadTargetMin";

        public static const col_loadTargetValue:String="loadTargetValue";

        public static const col_loadtargetType:String="loadTargetType";

        public static const col_phaseChangeMode:String="phaseChangeMode";

        public static const col_position:String="position";

        public static const col_recoveryDistance:String="recoveryDistance";

        public static const col_trainingId:String="trainingId";

        public static const col_trainingPhaseId:String="trainingPhaseId";

        public static const col_type:String="type";

        public static const table_name:String="TrainingPhase";

        public static const col_recoveryPhaseControl:String="recoveryPhaseControl";

        public static const col_recoveryTargetMax:String="recoveryTargetMax";

        public static const col_recoveryTargetMin:String="recoveryTargetMin";

        public static const col_recoveryTargetType:String="recoveryTargetType";

        public static const col_recoveryTargetValue:String="recoveryTargetValue";

        public static const col_titel:String="titel";

        public static const col_recoveryDuration:String="recoveryDuration";

        public static var DB_TABLE_400:database.DatabaseTable;

        public static var DB_TABLE_500:database.DatabaseTable;

        public static var DB_TABLE_510:database.DatabaseTable;

        public static var DB_TABLE_520:database.DatabaseTable;
    }
}


