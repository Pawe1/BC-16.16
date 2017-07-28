//class AltitudeUnitDataProvider
package backend.utils.dataprovider 
{
    import feathers.data.*;
    import feathers.events.*;
    import starling.events.*;
    import utils.dataprovider.*;
    
    public class AltitudeUnitDataProvider extends starling.events.EventDispatcher
    {
        public function AltitudeUnitDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonAltitudeUnitDataProvider.init();
            DATA_PROVIDER_BC = new feathers.data.ListCollection(utils.dataprovider.CommonAltitudeUnitDataProvider.V_DATA_PROVIDER_BC);
            DATA_PROVIDER_SOFTWARE_SETTINGS = new feathers.data.ListCollection(utils.dataprovider.CommonAltitudeUnitDataProvider.V_DATA_PROVIDER_SOFTWARE_SETTINGS);
            return;
        }

        public static function get DATA_PROVIDER_SOFTWARE_SETTINGS():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.AltitudeUnitDataProvider._876350814DATA_PROVIDER_SOFTWARE_SETTINGS;
        }

        public static function set DATA_PROVIDER_SOFTWARE_SETTINGS(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.AltitudeUnitDataProvider._876350814DATA_PROVIDER_SOFTWARE_SETTINGS;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.AltitudeUnitDataProvider._876350814DATA_PROVIDER_SOFTWARE_SETTINGS = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER_SOFTWARE_SETTINGS", loc1, arg1, backend.utils.dataprovider.AltitudeUnitDataProvider);
                loc3 = backend.utils.dataprovider.AltitudeUnitDataProvider.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get staticEventDispatcher():starling.events.EventDispatcher
        {
            return _staticBindingEventDispatcher;
        }

        
        {
            _staticBindingEventDispatcher = new starling.events.EventDispatcher();
        }

        public static var DATA_PROVIDER_BC:feathers.data.ListCollection;

        internal static var _876350814DATA_PROVIDER_SOFTWARE_SETTINGS:feathers.data.ListCollection;

        internal static var _staticBindingEventDispatcher:starling.events.EventDispatcher;
    }
}


