//class DB_500_Status
package database.columnMapper 
{
    import utils.*;
    
    public class DB_500_Status extends Object
    {
        public function DB_500_Status()
        {
            super();
            return;
        }

        
        {
            softwareGUID = utils.GUID.create();
        }

        public static const col_databaseUpdateStatus:String="databaseUpdateStatus";

        public static const col_databaseVersion:String="databaseVersion";

        public static const col_dbUpdateNumber:String="dbUpdateNumber";

        public static const col_id:String="id";

        public static const col_licenceNumberAccepted:String="licenseNumberAccepted";

        public static const col_softwareGUID:String="softwareGUID";

        public static const col_trialCounter:String="trialCounter";

        public static var softwareGUID:String;

        public static var table_name:String="Status";
    }
}


