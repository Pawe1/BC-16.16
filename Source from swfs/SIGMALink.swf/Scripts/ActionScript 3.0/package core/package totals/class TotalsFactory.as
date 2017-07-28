//class TotalsFactory
package core.totals 
{
    import core.general.*;
    
    public class TotalsFactory extends Object
    {
        public function TotalsFactory()
        {
            super();
            return;
        }

        public static function createTotalsFromDB(arg1:Object, arg2:core.general.UnitType):core.totals.Totals
        {
            var loc1:*=unitSwitch(arg2);
            new core.totals.TotalsEntity(loc1, null).fromDB(loc1, arg1);
            return loc1;
        }

        public static function createTotalsFromSSF(arg1:XML):core.totals.Totals
        {
            var loc1:*=core.general.UnitType.fromString(arg1.GeneralInformation.@unit);
            return unitSwitch(loc1);
        }

        public static function createTotalsFromUnitType(arg1:core.general.UnitType):core.totals.Totals
        {
            return unitSwitch(arg1);
        }

        internal static function unitSwitch(arg1:core.general.UnitType):core.totals.Totals
        {
            var loc1:*=null;
            var loc2:*=arg1.toString();
            while (core.general.UnitType.BC509.toString() === loc2) 
            {
                loc1 = new core.totals.TotalsBC509();
            }
        }
    }
}


