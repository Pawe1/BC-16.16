//class Status
package core 
{
    import database.*;
    import database.columnMapper.*;
    import flash.errors.*;
    import flash.events.*;
    import utils.*;
    
    public class Status extends Object
    {
        public function Status()
        {
            super();
            return;
        }

        public static function updateStatusTable(arg1:String, arg2:Object):void
        {
            new database.DatabaseTransaction(executeUpdateStatusStatement, [arg1, arg2], "update").commit();
            return;
        }

        internal static function executeUpdateStatusStatement(arg1:String, arg2:Object):void
        {
            var loc1:*=new database.DCSQLStatement();
            loc1.addEventListener("result", updateStatusComplete);
            loc1.addEventListener("error", updateStatusError);
            loc1.text = "UPDATE Status SET " + arg1 + " = @p1 WHERE id = 1";
            loc1.parameters["@p1"] = arg2;
            try 
            {
                loc1.execute();
            }
            catch (error:flash.errors.SQLError)
            {
            };
            return;
        }

        internal static function updateStatusComplete(arg1:flash.events.SQLEvent):void
        {
            var loc1:*=arg1.target as database.DCSQLStatement;
            loc1.removeEventListener("result", updateStatusComplete);
            loc1.removeEventListener("error", updateStatusError);
            database.DatabaseHandlerCommon.getInstance().commit();
            return;
        }

        internal static function updateStatusError(arg1:flash.events.SQLErrorEvent):void
        {
            var loc1:*=arg1.target as database.DCSQLStatement;
            loc1.removeEventListener("result", updateStatusComplete);
            loc1.removeEventListener("error", updateStatusError);
            database.DatabaseHandlerCommon.getInstance().close();
            return;
        }

        
        {
            softwareGUID = utils.GUID.create();
        }

        public function fromDB(arg1:Object):void
        {
            softwareGUID = arg1["softwareGUID"];
            databaseUpdateStatus = arg1["databaseUpdateStatus"];
            licenceNumberAccepted = arg1["licenseNumberAccepted"];
            databaseVersion = arg1["databaseVersion"];
            trialCounter = arg1["trialCounter"];
            dbUpdateNumber = arg1["dbUpdateNumber"];
            return;
        }

        public static function generateDBCreateTable(arg1:uint):database.DatabaseTable
        {
            var loc1:*=null;
            var loc2:*=arg1;
            while (400 === loc2) 
            {
                DB_TABLE_400 = new database.DatabaseTable(database.columnMapper.DB_400_Status.table_name);
                DB_TABLE_400.addColumns([["id", "INTEGER", false, true, true], ["softwareGUID", "VARCHAR", false], ["databaseUpdateStatus", "VARCHAR", false], ["licenseNumberAccepted", "VARCHAR", false], ["databaseVersion", "VARCHAR", false], ["trialCounter", "INTEGER", false]]);
                loc1 = DB_TABLE_400;
            }
        }

        public static function generateInsertStatement(arg1:core.Status):String
        {
            var loc2:*=["id", "softwareGUID", "databaseUpdateStatus", "licenseNumberAccepted", "databaseVersion", "trialCounter", "dbUpdateNumber"];
            var loc1:*=[1, "\"" + softwareGUID + "\"", "\"" + arg1.databaseUpdateStatus + "\"", "\"" + arg1.licenceNumberAccepted + "\"", "\"" + arg1.databaseVersion + "\"", arg1.trialCounter, arg1.dbUpdateNumber];
            return "insert or replace into " + table_name + " (" + loc2.join(", ") + ") values (" + loc1.join(",") + ")";
        }

        public static function generateDefaultStatement(arg1:int):String
        {
            var loc1:*=new Status();
            loc1.databaseUpdateStatus = "updateStatusCompleteTo_5_0";
            loc1.licenceNumberAccepted = "0";
            loc1.databaseVersion = arg1.toString().split("").join(".");
            loc1.trialCounter = 0;
            loc1.dbUpdateNumber = arg1;
            return generateInsertStatement(loc1);
        }

        public static function setNewStatus(arg1:core.Status):void
        {
            new database.DatabaseTransaction(setNewStatusStatement, [arg1], "update").commit();
            return;
        }

        internal static function setNewStatusStatement(arg1:core.Status):void
        {
            var loc1:*=new database.DCSQLStatement();
            loc1.addEventListener("result", updateStatusComplete);
            loc1.addEventListener("error", updateStatusError);
            loc1.text = generateInsertStatement(arg1);
            try 
            {
                loc1.execute();
            }
            catch (error:flash.errors.SQLError)
            {
            };
            return;
        }

        public static function increaseTrialCounter():void
        {
            new database.DatabaseTransaction(executeIncreaseTrialCounterStatement, [], "update").commit();
            return;
        }

        internal static function executeIncreaseTrialCounterStatement():void
        {
            var loc1:*=new database.DCSQLStatement();
            loc1.addEventListener("result", updateStatusComplete);
            loc1.addEventListener("error", updateStatusError);
            loc1.text = "UPDATE Status SET trialCounter = trialCounter + 1 WHERE id = 1";
            try 
            {
                loc1.execute();
            }
            catch (error:flash.errors.SQLError)
            {
            };
            return;
        }

        public static const UPDATE_COMPLETE:String="updateStatusCompleteTo_5_0";

        public static const UPDATE_FROM_SELECTED_DATABASE_UNCOMPLETE:String="updateFromSelectedDatabaseUncomplete";

        public static const UPDATE_NONE:String="updateStatusNone";

        public static const UPDATE_STARTED:String="updateStatusStartedTo_5_0";

        public static const col_databaseUpdateStatus:String="databaseUpdateStatus";

        public static const col_databaseVersion:String="databaseVersion";

        public static const col_dbUpdateNumber:String="dbUpdateNumber";

        public static const col_softwareGUID:String="softwareGUID";

        public static const col_trialCounter:String="trialCounter";

        public static const col_licenceNumberAccepted:String="licenseNumberAccepted";

        public static const col_id:String="id";

        public var databaseUpdateStatus:String="updateStatusNone";

        public var databaseVersion:String="";

        public var dbUpdateNumber:uint=0;

        public var licenceNumberAccepted:String="0.0";

        public var trialCounter:int=0;

        public static var DB_TABLE_400:database.DatabaseTable;

        public static var DB_TABLE_500:database.DatabaseTable;

        public static var DB_TABLE_510:database.DatabaseTable;

        public static var DB_TABLE_520:database.DatabaseTable;

        public static var softwareGUID:String;

        public static var table_name:String="Status";
    }
}


