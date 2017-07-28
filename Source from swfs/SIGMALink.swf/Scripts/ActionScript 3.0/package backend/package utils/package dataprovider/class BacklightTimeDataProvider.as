//class BacklightTimeDataProvider
package backend.utils.dataprovider 
{
    import core.general.*;
    import core.units.*;
    import feathers.data.*;
    import utils.dataprovider.*;
    
    public class BacklightTimeDataProvider extends Object
    {
        public function BacklightTimeDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonBacklightTimeDataProvider.init();
            DATA_PROVIDER_ROX100 = new feathers.data.ListCollection(utils.dataprovider.CommonBacklightTimeDataProvider.DATA_PROVIDER_ROX100);
            DATA_PROVIDER_ROX70_ROX110 = new feathers.data.ListCollection(utils.dataprovider.CommonBacklightTimeDataProvider.DATA_PROVIDER_ROX70_ROX110);
            return;
        }

        public static function getDataProviderByUnit(arg1:core.general.UnitType):feathers.data.ListCollection
        {
            var loc2:*=null;
            var loc1:*=core.units.UnitFactory.createUnitFromType(arg1);
            if (loc1 is core.units.UnitROX100) 
            {
                loc2 = DATA_PROVIDER_ROX100;
            }
            else if (loc1 is core.units.UnitROX70 || loc1 is core.units.UnitROX110) 
            {
                loc2 = DATA_PROVIDER_ROX70_ROX110;
            }
            return loc2;
        }

        public static var DATA_PROVIDER_ROX100:feathers.data.ListCollection;

        public static var DATA_PROVIDER_ROX70_ROX110:feathers.data.ListCollection;
    }
}


