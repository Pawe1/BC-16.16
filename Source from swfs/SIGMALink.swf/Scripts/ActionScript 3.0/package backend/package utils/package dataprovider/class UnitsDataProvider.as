//class UnitsDataProvider
package backend.utils.dataprovider 
{
    import __AS3__.vec.*;
    import core.general.*;
    import feathers.data.*;
    import feathers.events.*;
    import starling.events.*;
    import utils.dataprovider.*;
    
    public class UnitsDataProvider extends starling.events.EventDispatcher
    {
        public function UnitsDataProvider()
        {
            super();
            return;
        }

        public static function init(arg1:Boolean=true, arg2:Boolean=true, arg3:Boolean=true):void
        {
            var loc2:*=0;
            var loc4:*=null;
            utils.dataprovider.CommonUnitsDataProvider.init();
            var loc1:*=new Vector.<utils.dataprovider.UnitItemRendererData>();
            var loc3:*=utils.dataprovider.CommonUnitsDataProvider.V_DATA_PROVIDER_ALL_DEVICES.length;
            loc2 = 0;
            while (loc2 < loc3) 
            {
                loc4 = utils.dataprovider.CommonUnitsDataProvider.V_DATA_PROVIDER_ALL_DEVICES[loc2];
                if (loc4.usb && arg1 || loc4.ble && arg2 || loc4.nfc && arg3) 
                {
                    loc1.push(loc4);
                }
                ++loc2;
            }
            DATA_PROVIDER_ALL_DEVICES = new feathers.data.ListCollection(loc1);
            return;
        }

        public static function isCommunicationAvailable(arg1:core.general.UnitType):Boolean
        {
            var loc3:*=null;
            var loc1:*=0;
            var loc2:*=DATA_PROVIDER_ALL_DEVICES.length;
            loc1 = 0;
            while (loc1 < loc2) 
            {
                loc3 = (DATA_PROVIDER_ALL_DEVICES.getItemAt(loc1) as utils.dataprovider.UnitItemRendererData).data as core.general.UnitType;
                if (loc3.equals(arg1)) 
                {
                    return true;
                }
                ++loc1;
            }
            return false;
        }

        public static function get DATA_PROVIDER_ALL_DEVICES():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.UnitsDataProvider._176373798DATA_PROVIDER_ALL_DEVICES;
        }

        public static function set DATA_PROVIDER_ALL_DEVICES(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.UnitsDataProvider._176373798DATA_PROVIDER_ALL_DEVICES;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.UnitsDataProvider._176373798DATA_PROVIDER_ALL_DEVICES = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER_ALL_DEVICES", loc1, arg1, backend.utils.dataprovider.UnitsDataProvider);
                loc3 = backend.utils.dataprovider.UnitsDataProvider.staticEventDispatcher;
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

        internal static var _176373798DATA_PROVIDER_ALL_DEVICES:feathers.data.ListCollection;

        internal static var _staticBindingEventDispatcher:starling.events.EventDispatcher;
    }
}


