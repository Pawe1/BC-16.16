//class TotalsEntity
package core.totals 
{
    import core.general.interfaces.*;
    import core.totals.interfaces.*;
    import database.*;
    import flash.events.*;
    import utils.*;
    
    public class TotalsEntity extends flash.events.EventDispatcher implements core.general.interfaces.IDatabase
    {
        public function TotalsEntity(arg1:core.totals.Totals, arg2:flash.events.IEventDispatcher)
        {
            super(arg2);
            this.totals = arg1;
            return;
        }

        public static function selectPrimaryKeyFromGUID(arg1:core.totals.Totals):String
        {
            return "SELECT totalsId FROM Totals WHERE GUID = \'" + arg1.GUID + "\'";
        }

        public function fromDB(arg1:core.totals.Totals, arg2:Object):void
        {
            arg1.totalsId = arg2["totalsId"];
            arg1.unitGUID = arg2["unitGUID"];
            arg1.date = new Date(arg2["date"]);
            arg1.GUID = arg2.GUID;
            arg1.modificationDate = arg2.modificationDate;
            arg1.isDeleted = arg2.isDeleted;
            if (arg1 is core.totals.interfaces.ITotalCal1) 
            {
                (arg1 as core.totals.interfaces.ITotalCal1).totalCal1 = arg2["totalCal1"];
            }
            if (arg1 is core.totals.interfaces.ITotalCal2) 
            {
                (arg1 as core.totals.interfaces.ITotalCal2).totalCal2 = arg2["totalCal2"];
            }
            if (arg1 is core.totals.interfaces.ITotalCal3) 
            {
                (arg1 as core.totals.interfaces.ITotalCal3).totalCal3 = arg2["totalCal3"];
            }
            if (arg1 is core.totals.interfaces.ITotalClimbMeter1) 
            {
                (arg1 as core.totals.interfaces.ITotalClimbMeter1).totalClimbMeter1 = arg2["totalClimbMeter1"];
            }
            if (arg1 is core.totals.interfaces.ITotalClimbMeter2) 
            {
                (arg1 as core.totals.interfaces.ITotalClimbMeter2).totalClimbMeter2 = arg2["totalClimbMeter2"];
            }
            if (arg1 is core.totals.interfaces.ITotalClimbMeter3) 
            {
                (arg1 as core.totals.interfaces.ITotalClimbMeter3).totalClimbMeter3 = arg2["totalClimbMeter3"];
            }
            if (arg1 is core.totals.interfaces.ITotalDescent1) 
            {
                (arg1 as core.totals.interfaces.ITotalDescent1).totalDescent1 = arg2["totalDescent1"];
            }
            if (arg1 is core.totals.interfaces.ITotalDescent2) 
            {
                (arg1 as core.totals.interfaces.ITotalDescent2).totalDescent2 = arg2["totalDescent2"];
            }
            if (arg1 is core.totals.interfaces.ITotalDescent3) 
            {
                (arg1 as core.totals.interfaces.ITotalDescent3).totalDescent3 = arg2["totalDescent3"];
            }
            if (arg1 is core.totals.interfaces.ITotalDistance1) 
            {
                (arg1 as core.totals.interfaces.ITotalDistance1).totalDistance1 = arg2["totalDistance1"];
            }
            if (arg1 is core.totals.interfaces.ITotalDistance2) 
            {
                (arg1 as core.totals.interfaces.ITotalDistance2).totalDistance2 = arg2["totalDistance2"];
            }
            if (arg1 is core.totals.interfaces.ITotalDistance3) 
            {
                (arg1 as core.totals.interfaces.ITotalDistance3).totalDistance3 = arg2["totalDistance3"];
            }
            if (arg1 is core.totals.interfaces.ITotalFuelConsumption1) 
            {
                (arg1 as core.totals.interfaces.ITotalFuelConsumption1).totalFuelConsumption1 = arg2["totalFuelConsumption1"];
            }
            if (arg1 is core.totals.interfaces.ITotalHikingAltitude) 
            {
                (arg1 as core.totals.interfaces.ITotalHikingAltitude).totalHikingAltitude = arg2["totalHikingAltitude"];
            }
            if (arg1 is core.totals.interfaces.ITotalHikingCalories) 
            {
                (arg1 as core.totals.interfaces.ITotalHikingCalories).totalHikingCalories = arg2["totalHikingCalories"];
            }
            if (arg1 is core.totals.interfaces.ITotalHikingTime) 
            {
                (arg1 as core.totals.interfaces.ITotalHikingTime).totalHikingTime = arg2["totalHikingTime"];
            }
            if (arg1 is core.totals.interfaces.IMaxAltitude1) 
            {
                (arg1 as core.totals.interfaces.IMaxAltitude1).maxAltitude1 = arg2["maxAltitude1"];
            }
            if (arg1 is core.totals.interfaces.IMaxAltitude2) 
            {
                (arg1 as core.totals.interfaces.IMaxAltitude2).maxAltitude2 = arg2["maxAltitude2"];
            }
            if (arg1 is core.totals.interfaces.IMaxAltitude3) 
            {
                (arg1 as core.totals.interfaces.IMaxAltitude3).maxAltitude3 = arg2["maxAltitude3"];
            }
            if (arg1 is core.totals.interfaces.IResetDate) 
            {
                (arg1 as core.totals.interfaces.IResetDate).resetDate = new Date(arg2["resetDate"]);
            }
            if (arg1 is core.totals.interfaces.ITotalTimeDown1) 
            {
                (arg1 as core.totals.interfaces.ITotalTimeDown1).totalTimeDown1 = arg2["totalTimeDown1"];
            }
            if (arg1 is core.totals.interfaces.ITotalTimeDown2) 
            {
                (arg1 as core.totals.interfaces.ITotalTimeDown2).totalTimeDown2 = arg2["totalTimeDown2"];
            }
            if (arg1 is core.totals.interfaces.ITotalTimeDown3) 
            {
                (arg1 as core.totals.interfaces.ITotalTimeDown3).totalTimeDown3 = arg2["totalTimeDown3"];
            }
            if (arg1 is core.totals.interfaces.ITotalTimeUp1) 
            {
                (arg1 as core.totals.interfaces.ITotalTimeUp1).totalTimeUp1 = arg2["totalTimeUp1"];
            }
            if (arg1 is core.totals.interfaces.ITotalTimeUp2) 
            {
                (arg1 as core.totals.interfaces.ITotalTimeUp2).totalTimeUp2 = arg2["totalTimeUp2"];
            }
            if (arg1 is core.totals.interfaces.ITotalTimeUp3) 
            {
                (arg1 as core.totals.interfaces.ITotalTimeUp3).totalTimeUp3 = arg2["totalTimeUp3"];
            }
            if (arg1 is core.totals.interfaces.ITotalTrainings) 
            {
                (arg1 as core.totals.interfaces.ITotalTrainings).totalTrainings = arg2["trainings"];
            }
            if (arg1 is core.totals.interfaces.ITotalTrainingTime1) 
            {
                (arg1 as core.totals.interfaces.ITotalTrainingTime1).totalTrainingTime1 = arg2["totalTrainingTime1"];
            }
            if (arg1 is core.totals.interfaces.ITotalTrainingTime2) 
            {
                (arg1 as core.totals.interfaces.ITotalTrainingTime2).totalTrainingTime2 = arg2["totalTrainingTime2"];
            }
            if (arg1 is core.totals.interfaces.ITotalTrainingTime3) 
            {
                (arg1 as core.totals.interfaces.ITotalTrainingTime3).totalTrainingTime3 = arg2["totalTrainingTime3"];
            }
            if (arg1 is core.totals.interfaces.ITotalTripDistDown1) 
            {
                (arg1 as core.totals.interfaces.ITotalTripDistDown1).totalTripDistDown1 = arg2["totalTripDistDown1"];
            }
            if (arg1 is core.totals.interfaces.ITotalTripDistDown2) 
            {
                (arg1 as core.totals.interfaces.ITotalTripDistDown2).totalTripDistDown2 = arg2["totalTripDistDown2"];
            }
            if (arg1 is core.totals.interfaces.ITotalTripDistDown3) 
            {
                (arg1 as core.totals.interfaces.ITotalTripDistDown3).totalTripDistDown3 = arg2["totalTripDistDown3"];
            }
            if (arg1 is core.totals.interfaces.ITotalTripDistUp1) 
            {
                (arg1 as core.totals.interfaces.ITotalTripDistUp1).totalTripDistUp1 = arg2["totalTripDistUp1"];
            }
            if (arg1 is core.totals.interfaces.ITotalTripDistUp2) 
            {
                (arg1 as core.totals.interfaces.ITotalTripDistUp2).totalTripDistUp2 = arg2["totalTripDistUp2"];
            }
            if (arg1 is core.totals.interfaces.ITotalTripDistUp3) 
            {
                (arg1 as core.totals.interfaces.ITotalTripDistUp3).totalTripDistUp3 = arg2["totalTripDistUp3"];
            }
            if (arg1 is core.totals.interfaces.ITotalActivityCount1) 
            {
                (arg1 as core.totals.interfaces.ITotalActivityCount1).totalActivityCount1 = arg2["totalActivityCount1"];
            }
            return;
        }

        public function generateDBDelete():Array
        {
            var loc1:*=new database.DCSQLStatement();
            loc1.text = "DELETE FROM Totals WHERE Totals.totalsId = @fk";
            return [loc1];
        }

        public function generateDBInsert():Array
        {
            var loc1:*=new database.DCSQLStatement();
            var loc2:*=[];
            core.totals.TotalsEntity.generateParamsAndColums(totals, loc2, loc1.parameters);
            loc1.text = utils.BackendUtil.generateStatementText("insert or replace into Totals", loc2.toString().split(","));
            return [loc1];
        }

        public function generateDBSelect():Array
        {
            var loc1:*=new database.DCSQLStatement();
            loc1.text = "SELECT totalsId as pk, * FROM Totals WHERE Totals.unitGUID = @fk ORDER BY totalsId DESC";
            loc1.parameters["@fk"] = totals.unitGUID;
            return [loc1];
        }

        public static function generateParamsAndColums(arg1:core.totals.Totals, arg2:Array, arg3:Object):void
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
            arg2.push("totalsId");
            ++loc1;
            arg3[loc1] = arg1.totalsId > 0 ? arg1.totalsId : null;
            arg2.push("date");
            ++loc1;
            arg3[loc1] = arg1.date.toString();
            arg2.push("GUID");
            ++loc1;
            arg3[loc1] = arg1.GUID;
            arg2.push("modificationDate");
            ++loc1;
            arg3[loc1] = arg1.modificationDate;
            arg2.push("isDeleted");
            ++loc1;
            arg3[loc1] = arg1.isDeleted;
            arg2.push("unitGUID");
            ++loc1;
            arg3[loc1] = arg1.unitGUID;
            if (arg1 is core.totals.interfaces.ITotalCal1) 
            {
                arg2.push("totalCal1");
                ++loc1;
                arg3[loc1] = (arg1 as core.totals.interfaces.ITotalCal1).totalCal1;
            }
            if (arg1 is core.totals.interfaces.ITotalCal2) 
            {
                arg2.push("totalCal2");
                ++loc1;
                arg3[loc1] = (arg1 as core.totals.interfaces.ITotalCal2).totalCal2;
            }
            if (arg1 is core.totals.interfaces.ITotalCal3) 
            {
                arg2.push("totalCal3");
                ++loc1;
                arg3[loc1] = (arg1 as core.totals.interfaces.ITotalCal3).totalCal3;
            }
            if (arg1 is core.totals.interfaces.ITotalClimbMeter1) 
            {
                arg2.push("totalClimbMeter1");
                ++loc1;
                arg3[loc1] = (arg1 as core.totals.interfaces.ITotalClimbMeter1).totalClimbMeter1;
            }
            if (arg1 is core.totals.interfaces.ITotalClimbMeter2) 
            {
                arg2.push("totalClimbMeter2");
                ++loc1;
                arg3[loc1] = (arg1 as core.totals.interfaces.ITotalClimbMeter2).totalClimbMeter2;
            }
            if (arg1 is core.totals.interfaces.ITotalClimbMeter3) 
            {
                arg2.push("totalClimbMeter3");
                ++loc1;
                arg3[loc1] = (arg1 as core.totals.interfaces.ITotalClimbMeter3).totalClimbMeter3;
            }
            if (arg1 is core.totals.interfaces.ITotalDescent1) 
            {
                arg2.push("totalDescent1");
                ++loc1;
                arg3[loc1] = (arg1 as core.totals.interfaces.ITotalDescent1).totalDescent1;
            }
            if (arg1 is core.totals.interfaces.ITotalDescent2) 
            {
                arg2.push("totalDescent2");
                ++loc1;
                arg3[loc1] = (arg1 as core.totals.interfaces.ITotalDescent2).totalDescent2;
            }
            if (arg1 is core.totals.interfaces.ITotalDescent3) 
            {
                arg2.push("totalDescent3");
                ++loc1;
                arg3[loc1] = (arg1 as core.totals.interfaces.ITotalDescent3).totalDescent3;
            }
            if (arg1 is core.totals.interfaces.ITotalDistance1) 
            {
                arg2.push("totalDistance1");
                ++loc1;
                arg3[loc1] = (arg1 as core.totals.interfaces.ITotalDistance1).totalDistance1;
            }
            if (arg1 is core.totals.interfaces.ITotalDistance2) 
            {
                arg2.push("totalDistance2");
                ++loc1;
                arg3[loc1] = (arg1 as core.totals.interfaces.ITotalDistance2).totalDistance2;
            }
            if (arg1 is core.totals.interfaces.ITotalDistance3) 
            {
                arg2.push("totalDistance3");
                ++loc1;
                arg3[loc1] = (arg1 as core.totals.interfaces.ITotalDistance3).totalDistance3;
            }
            if (arg1 is core.totals.interfaces.ITotalFuelConsumption1) 
            {
                arg2.push("totalFuelConsumption1");
                ++loc1;
                arg3[loc1] = (arg1 as core.totals.interfaces.ITotalFuelConsumption1).totalFuelConsumption1;
            }
            if (arg1 is core.totals.interfaces.ITotalHikingAltitude) 
            {
                arg2.push("totalHikingAltitude");
                ++loc1;
                arg3[loc1] = (arg1 as core.totals.interfaces.ITotalHikingAltitude).totalHikingAltitude;
            }
            if (arg1 is core.totals.interfaces.ITotalHikingCalories) 
            {
                arg2.push("totalHikingCalories");
                ++loc1;
                arg3[loc1] = (arg1 as core.totals.interfaces.ITotalHikingCalories).totalHikingCalories;
            }
            if (arg1 is core.totals.interfaces.ITotalHikingTime) 
            {
                arg2.push("totalHikingTime");
                ++loc1;
                arg3[loc1] = (arg1 as core.totals.interfaces.ITotalHikingTime).totalHikingTime;
            }
            if (arg1 is core.totals.interfaces.IMaxAltitude1) 
            {
                arg2.push("maxAltitude1");
                ++loc1;
                arg3[loc1] = (arg1 as core.totals.interfaces.IMaxAltitude1).maxAltitude1;
            }
            if (arg1 is core.totals.interfaces.IMaxAltitude2) 
            {
                arg2.push("maxAltitude2");
                ++loc1;
                arg3[loc1] = (arg1 as core.totals.interfaces.IMaxAltitude2).maxAltitude2;
            }
            if (arg1 is core.totals.interfaces.IMaxAltitude3) 
            {
                arg2.push("maxAltitude3");
                ++loc1;
                arg3[loc1] = (arg1 as core.totals.interfaces.IMaxAltitude3).maxAltitude3;
            }
            if (arg1 is core.totals.interfaces.IResetDate) 
            {
                arg2.push("resetDate");
                ++loc1;
                arg3[loc1] = (arg1 as core.totals.interfaces.IResetDate).resetDate;
            }
            if (arg1 is core.totals.interfaces.ITotalTimeDown1) 
            {
                arg2.push("totalTimeDown1");
                ++loc1;
                arg3[loc1] = (arg1 as core.totals.interfaces.ITotalTimeDown1).totalTimeDown1;
            }
            if (arg1 is core.totals.interfaces.ITotalTimeDown2) 
            {
                arg2.push("totalTimeDown2");
                ++loc1;
                arg3[loc1] = (arg1 as core.totals.interfaces.ITotalTimeDown2).totalTimeDown2;
            }
            if (arg1 is core.totals.interfaces.ITotalTimeDown3) 
            {
                arg2.push("totalTimeDown3");
                ++loc1;
                arg3[loc1] = (arg1 as core.totals.interfaces.ITotalTimeDown3).totalTimeDown3;
            }
            if (arg1 is core.totals.interfaces.ITotalTimeUp1) 
            {
                arg2.push("totalTimeUp1");
                ++loc1;
                arg3[loc1] = (arg1 as core.totals.interfaces.ITotalTimeUp1).totalTimeUp1;
            }
            if (arg1 is core.totals.interfaces.ITotalTimeUp2) 
            {
                arg2.push("totalTimeUp2");
                ++loc1;
                arg3[loc1] = (arg1 as core.totals.interfaces.ITotalTimeUp2).totalTimeUp2;
            }
            if (arg1 is core.totals.interfaces.ITotalTimeUp3) 
            {
                arg2.push("totalTimeUp3");
                ++loc1;
                arg3[loc1] = (arg1 as core.totals.interfaces.ITotalTimeUp3).totalTimeUp3;
            }
            if (arg1 is core.totals.interfaces.ITotalTrainings) 
            {
                arg2.push("trainings");
                ++loc1;
                arg3[loc1] = (arg1 as core.totals.interfaces.ITotalTrainings).totalTrainings;
            }
            if (arg1 is core.totals.interfaces.ITotalTrainingTime1) 
            {
                arg2.push("totalTrainingTime1");
                ++loc1;
                arg3[loc1] = (arg1 as core.totals.interfaces.ITotalTrainingTime1).totalTrainingTime1;
            }
            if (arg1 is core.totals.interfaces.ITotalTrainingTime2) 
            {
                arg2.push("totalTrainingTime2");
                ++loc1;
                arg3[loc1] = (arg1 as core.totals.interfaces.ITotalTrainingTime2).totalTrainingTime2;
            }
            if (arg1 is core.totals.interfaces.ITotalTrainingTime3) 
            {
                arg2.push("totalTrainingTime3");
                ++loc1;
                arg3[loc1] = (arg1 as core.totals.interfaces.ITotalTrainingTime3).totalTrainingTime3;
            }
            if (arg1 is core.totals.interfaces.ITotalTripDistDown1) 
            {
                arg2.push("totalTripDistDown1");
                ++loc1;
                arg3[loc1] = (arg1 as core.totals.interfaces.ITotalTripDistDown1).totalTripDistDown1;
            }
            if (arg1 is core.totals.interfaces.ITotalTripDistDown2) 
            {
                arg2.push("totalTripDistDown2");
                ++loc1;
                arg3[loc1] = (arg1 as core.totals.interfaces.ITotalTripDistDown2).totalTripDistDown2;
            }
            if (arg1 is core.totals.interfaces.ITotalTripDistDown3) 
            {
                arg2.push("totalTripDistDown3");
                ++loc1;
                arg3[loc1] = (arg1 as core.totals.interfaces.ITotalTripDistDown3).totalTripDistDown3;
            }
            if (arg1 is core.totals.interfaces.ITotalTripDistUp1) 
            {
                arg2.push("totalTripDistUp1");
                ++loc1;
                arg3[loc1] = (arg1 as core.totals.interfaces.ITotalTripDistUp1).totalTripDistUp1;
            }
            if (arg1 is core.totals.interfaces.ITotalTripDistUp2) 
            {
                arg2.push("totalTripDistUp2");
                ++loc1;
                arg3[loc1] = (arg1 as core.totals.interfaces.ITotalTripDistUp2).totalTripDistUp2;
            }
            if (arg1 is core.totals.interfaces.ITotalTripDistUp3) 
            {
                arg2.push("totalTripDistUp3");
                ++loc1;
                arg3[loc1] = (arg1 as core.totals.interfaces.ITotalTripDistUp3).totalTripDistUp3;
            }
            if (arg1 is core.totals.interfaces.ITotalActivityCount1) 
            {
                arg2.push("totalActivityCount1");
                ++loc1;
                arg3[loc1] = (arg1 as core.totals.interfaces.ITotalActivityCount1).totalActivityCount1;
            }
            return;
        }

        public static function getInsertStatement(arg1:Array):String
        {
            return "INSERT or REPLACE INTO Totals (" + arg1.toString() + ") VALUES (:" + arg1.join(", :") + ");";
        }

        public static function generateDBCreateIndex():String
        {
            var loc1:*="CREATE INDEX IF NOT EXISTS UnitGUIDOnTotals ON Totals (unitGUID)";
            return loc1;
        }

        public static function generateDBCreateTable(arg1:uint):database.DatabaseTable
        {
            var loc1:*=null;
            var loc2:*=arg1;
            while (400 === loc2) 
            {
                DB_TABLE_400 = new database.DatabaseTable("Totals");
                DB_TABLE_400.addColumns([["totalsId", "INTEGER", false, true, true], ["date", "VARCHAR", true], ["GUID", "VARCHAR UNIQUE", false], ["modificationDate", "NUMERIC", true], ["isDeleted", "BOOL", true], ["unitGUID", "VARCHAR", false], ["calories1", "INTEGER", true], ["calories2", "INTEGER", true], ["calories3", "INTEGER", true], ["climbMeter1", "INTEGER", true], ["climbMeter2", "INTEGER", true], ["climbMeter3", "INTEGER", true], ["descent1", "INTEGER", true], ["descent2", "INTEGER", true], ["descent3", "INTEGER", true], ["distance1", "NUMERIC", true], ["distance2", "NUMERIC", true], ["distance3", "NUMERIC", true], ["fuelConsumption", "NUMERIC", true], ["hikingAltitude", "INTEGER", true], ["hikingCalories", "INTEGER", true], ["hikingTime", "INTEGER", true], ["maxAltitude1", "INTEGER", true], ["maxAltitude2", "INTEGER", true], ["maxAltitude3", "INTEGER", true], ["resetDate", "VARCHAR", true], ["timeDown1", "INTEGER", true], ["timeDown2", "INTEGER", true], ["timeDown3", "INTEGER", true], ["timeUp1", "INTEGER", true], ["timeUp2", "INTEGER", true], ["timeUp3", "INTEGER", true], ["trainings", "INTEGER", true], ["trainingTime1", "INTEGER", true], ["trainingTime2", "INTEGER", true], ["trainingTime3", "INTEGER", true], ["tripDistDown1", "NUMERIC", true], ["tripDistDown2", "NUMERIC", true], ["tripDistDown3", "NUMERIC", true], ["tripDistUp1", "NUMERIC", true], ["tripDistUp2", "NUMERIC", true], ["tripDistUp3", "NUMERIC", true], ["emptyField1", "NUMERIC", true], ["emptyField2", "NUMERIC", true], ["emptyField3", "NUMERIC", true], ["emptyField4", "NUMERIC", true], ["emptyField5", "NUMERIC", true], ["emptyField6", "NUMERIC", true]]);
                loc1 = DB_TABLE_400;
            }
        }

        public static const col_calories3:String="totalCal3";

        public static const col_GUID:String="GUID";

        public static const col_activityCount1:String="totalActivityCount1";

        public static const col_calories1:String="totalCal1";

        public static const col_calories2:String="totalCal2";

        public static const col_climbMeter1:String="totalClimbMeter1";

        public static const col_climbMeter2:String="totalClimbMeter2";

        public static const col_climbMeter3:String="totalClimbMeter3";

        public static const col_date:String="date";

        public static const col_descent1:String="totalDescent1";

        public static const col_descent2:String="totalDescent2";

        public static const col_descent3:String="totalDescent3";

        public static const col_distance1:String="totalDistance1";

        public static const col_distance2:String="totalDistance2";

        public static const col_distance3:String="totalDistance3";

        public static const col_fuelConsumption1:String="totalFuelConsumption1";

        public static const col_fuelConsumption2:String="totalFuelConsumption2";

        public static const col_hikingAltitude:String="totalHikingAltitude";

        public static const col_hikingCalories:String="totalHikingCalories";

        public static const col_hikingTime:String="totalHikingTime";

        public static const col_isDeleted:String="isDeleted";

        public static const col_maxAltitude1:String="maxAltitude1";

        public static const col_maxAltitude2:String="maxAltitude2";

        public static const col_maxAltitude3:String="maxAltitude3";

        public static const col_modificationDate:String="modificationDate";

        public static const col_resetDate:String="resetDate";

        public static const col_timeDown1:String="totalTimeDown1";

        public static const col_timeDown2:String="totalTimeDown2";

        public static const col_timeDown3:String="totalTimeDown3";

        public static const col_timeUp1:String="totalTimeUp1";

        public static const col_timeUp2:String="totalTimeUp2";

        public static const col_timeUp3:String="totalTimeUp3";

        public static const col_totalsId:String="totalsId";

        public static const col_trainingTime1:String="totalTrainingTime1";

        public static const col_trainingTime2:String="totalTrainingTime2";

        public static const col_trainings:String="trainings";

        public static const col_tripDistDown1:String="totalTripDistDown1";

        public static const col_tripDistDown2:String="totalTripDistDown2";

        public static const col_tripDistDown3:String="totalTripDistDown3";

        public static const col_tripDistUp1:String="totalTripDistUp1";

        public static const col_tripDistUp2:String="totalTripDistUp2";

        public static const col_trainingTime3:String="totalTrainingTime3";

        public static const col_unitGUID:String="unitGUID";

        public static const table_name:String="Totals";

        public static const col_tripDistUp3:String="totalTripDistUp3";

        public static var DB_TABLE_520:database.DatabaseTable;

        public static var DB_TABLE_510:database.DatabaseTable;

        public static var DB_TABLE_400:database.DatabaseTable;

        internal var totals:core.totals.Totals;

        public static var DB_TABLE_500:database.DatabaseTable;
    }
}


