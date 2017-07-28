//class DateFormatDataProvider
package backend.utils.dataprovider 
{
    import feathers.data.*;
    import feathers.events.*;
    import starling.events.*;
    import utils.dataprovider.*;
    
    public class DateFormatDataProvider extends starling.events.EventDispatcher
    {
        public function DateFormatDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonDateFormatDataProvider.init();
            DATA_PROVIDER = new feathers.data.ListCollection(utils.dataprovider.CommonDateFormatDataProvider.V_DATA_PROVIDER);
            return;
        }

        public static function get DATA_PROVIDER():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.DateFormatDataProvider._700989158DATA_PROVIDER;
        }

        public static function set DATA_PROVIDER(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.DateFormatDataProvider._700989158DATA_PROVIDER;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.DateFormatDataProvider._700989158DATA_PROVIDER = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER", loc1, arg1, backend.utils.dataprovider.DateFormatDataProvider);
                loc3 = backend.utils.dataprovider.DateFormatDataProvider.staticEventDispatcher;
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

        internal static var _700989158DATA_PROVIDER:feathers.data.ListCollection;

        internal static var _staticBindingEventDispatcher:starling.events.EventDispatcher;
    }
}


