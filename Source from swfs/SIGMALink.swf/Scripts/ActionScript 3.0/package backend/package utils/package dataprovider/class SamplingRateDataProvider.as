//class SamplingRateDataProvider
package backend.utils.dataprovider 
{
    import core.general.*;
    import core.units.*;
    import feathers.data.*;
    import feathers.events.*;
    import starling.events.*;
    import utils.dataprovider.*;
    
    public class SamplingRateDataProvider extends starling.events.EventDispatcher
    {
        public function SamplingRateDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            utils.dataprovider.CommonSamplingRateDataProvider.init();
            DATA_PROVIDER_BC2316 = new feathers.data.ListCollection(utils.dataprovider.CommonSamplingRateDataProvider.V_DATA_PROVIDER_BC2316);
            DATA_PROVIDER_PC2814 = new feathers.data.ListCollection(utils.dataprovider.CommonSamplingRateDataProvider.V_DATA_PROVIDER_PC2814);
            DATA_PROVIDER_RC1411 = new feathers.data.ListCollection(utils.dataprovider.CommonSamplingRateDataProvider.V_DATA_PROVIDER_RC1411);
            DATA_PROVIDER_ROX100 = new feathers.data.ListCollection(utils.dataprovider.CommonSamplingRateDataProvider.V_DATA_PROVIDER_ROX100);
            DATA_PROVIDER_ROX110 = new feathers.data.ListCollection(utils.dataprovider.CommonSamplingRateDataProvider.V_DATA_PROVIDER_ROX110);
            return;
        }

        public static function getDataProviderByUnit(arg1:core.general.UnitType):feathers.data.ListCollection
        {
            var loc2:*=null;
            var loc1:*=core.units.UnitFactory.createUnitFromType(arg1);
            if (loc1 is core.units.UnitBC2316STS) 
            {
                loc2 = DATA_PROVIDER_BC2316;
            }
            else if (loc1 is core.units.UnitPC2814) 
            {
                loc2 = DATA_PROVIDER_PC2814;
            }
            else if (loc1 is core.units.UnitRC1411) 
            {
                loc2 = DATA_PROVIDER_RC1411;
            }
            else if (loc1 is core.units.UnitROX100) 
            {
                loc2 = DATA_PROVIDER_ROX100;
            }
            else if (loc1 is core.units.UnitROX110) 
            {
                loc2 = DATA_PROVIDER_ROX110;
            }
            return loc2;
        }

        public static function get DATA_PROVIDER_BC2316():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.SamplingRateDataProvider._1204039840DATA_PROVIDER_BC2316;
        }

        public static function set DATA_PROVIDER_BC2316(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.SamplingRateDataProvider._1204039840DATA_PROVIDER_BC2316;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.SamplingRateDataProvider._1204039840DATA_PROVIDER_BC2316 = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER_BC2316", loc1, arg1, backend.utils.dataprovider.SamplingRateDataProvider);
                loc3 = backend.utils.dataprovider.SamplingRateDataProvider.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get DATA_PROVIDER_PC2814():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.SamplingRateDataProvider._803226923DATA_PROVIDER_PC2814;
        }

        public static function set DATA_PROVIDER_PC2814(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.SamplingRateDataProvider._803226923DATA_PROVIDER_PC2814;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.SamplingRateDataProvider._803226923DATA_PROVIDER_PC2814 = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER_PC2814", loc1, arg1, backend.utils.dataprovider.SamplingRateDataProvider);
                loc3 = backend.utils.dataprovider.SamplingRateDataProvider.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get DATA_PROVIDER_RC1411():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.SamplingRateDataProvider._746002259DATA_PROVIDER_RC1411;
        }

        public static function set DATA_PROVIDER_RC1411(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.SamplingRateDataProvider._746002259DATA_PROVIDER_RC1411;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.SamplingRateDataProvider._746002259DATA_PROVIDER_RC1411 = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER_RC1411", loc1, arg1, backend.utils.dataprovider.SamplingRateDataProvider);
                loc3 = backend.utils.dataprovider.SamplingRateDataProvider.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get DATA_PROVIDER_ROX100():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.SamplingRateDataProvider._733761073DATA_PROVIDER_ROX100;
        }

        public static function set DATA_PROVIDER_ROX100(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.SamplingRateDataProvider._733761073DATA_PROVIDER_ROX100;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.SamplingRateDataProvider._733761073DATA_PROVIDER_ROX100 = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER_ROX100", loc1, arg1, backend.utils.dataprovider.SamplingRateDataProvider);
                loc3 = backend.utils.dataprovider.SamplingRateDataProvider.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get DATA_PROVIDER_ROX110():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.SamplingRateDataProvider._733761042DATA_PROVIDER_ROX110;
        }

        public static function set DATA_PROVIDER_ROX110(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.SamplingRateDataProvider._733761042DATA_PROVIDER_ROX110;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.SamplingRateDataProvider._733761042DATA_PROVIDER_ROX110 = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER_ROX110", loc1, arg1, backend.utils.dataprovider.SamplingRateDataProvider);
                loc3 = backend.utils.dataprovider.SamplingRateDataProvider.staticEventDispatcher;
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

        internal static var _1204039840DATA_PROVIDER_BC2316:feathers.data.ListCollection;

        internal static var _803226923DATA_PROVIDER_PC2814:feathers.data.ListCollection;

        internal static var _746002259DATA_PROVIDER_RC1411:feathers.data.ListCollection;

        internal static var _733761073DATA_PROVIDER_ROX100:feathers.data.ListCollection;

        internal static var _733761042DATA_PROVIDER_ROX110:feathers.data.ListCollection;

        internal static var _staticBindingEventDispatcher:starling.events.EventDispatcher;
    }
}


