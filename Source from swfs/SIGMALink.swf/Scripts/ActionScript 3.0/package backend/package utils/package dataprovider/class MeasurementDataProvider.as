//class MeasurementDataProvider
package backend.utils.dataprovider 
{
    import core.general.*;
    import core.units.*;
    import feathers.data.*;
    import utils.dataprovider.*;
    
    public class MeasurementDataProvider extends Object
    {
        public function MeasurementDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonMeasurementDataProvider.init();
            DATA_PROVIDER_BC = new feathers.data.ListCollection(utils.dataprovider.CommonMeasurementDataProvider.V_DATA_PROVIDER_BC);
            DATA_PROVIDER_RC = new feathers.data.ListCollection(utils.dataprovider.CommonMeasurementDataProvider.V_DATA_PROVIDER_RC);
            return;
        }

        public static function getDataProviderByUnit(arg1:core.general.UnitType):feathers.data.ListCollection
        {
            var loc2:*=null;
            var loc1:*=core.units.UnitFactory.createUnitFromType(arg1);
            if (loc1 is core.units.UnitBikeComputer) 
            {
                loc2 = DATA_PROVIDER_BC;
            }
            else if (loc1 is core.units.UnitRunningComputer) 
            {
                loc2 = DATA_PROVIDER_RC;
            }
            return loc2;
        }

        public static var DATA_PROVIDER_BC:feathers.data.ListCollection;

        public static var DATA_PROVIDER_RC:feathers.data.ListCollection;
    }
}


