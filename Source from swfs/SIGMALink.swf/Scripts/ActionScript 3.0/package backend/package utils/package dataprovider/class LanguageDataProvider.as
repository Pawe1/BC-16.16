//class LanguageDataProvider
package backend.utils.dataprovider 
{
    import core.general.*;
    import core.units.*;
    import feathers.data.*;
    import feathers.events.*;
    import starling.events.*;
    import utils.dataprovider.*;
    
    public class LanguageDataProvider extends starling.events.EventDispatcher
    {
        public function LanguageDataProvider()
        {
            super();
            return;
        }

        public static function get DATA_PROVIDER_ROX70_ROX110():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.LanguageDataProvider._192133113DATA_PROVIDER_ROX70_ROX110;
        }

        public static function set DATA_PROVIDER_ROX70_ROX110(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.LanguageDataProvider._192133113DATA_PROVIDER_ROX70_ROX110;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.LanguageDataProvider._192133113DATA_PROVIDER_ROX70_ROX110 = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER_ROX70_ROX110", loc1, arg1, backend.utils.dataprovider.LanguageDataProvider);
                loc3 = backend.utils.dataprovider.LanguageDataProvider.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get DATA_PROVIDER_SOFTWARESETTINGS_EN():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.LanguageDataProvider._102659941DATA_PROVIDER_SOFTWARESETTINGS_EN;
        }

        public static function set DATA_PROVIDER_SOFTWARESETTINGS_EN(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.LanguageDataProvider._102659941DATA_PROVIDER_SOFTWARESETTINGS_EN;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.LanguageDataProvider._102659941DATA_PROVIDER_SOFTWARESETTINGS_EN = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER_SOFTWARESETTINGS_EN", loc1, arg1, backend.utils.dataprovider.LanguageDataProvider);
                loc3 = backend.utils.dataprovider.LanguageDataProvider.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get DATA_PROVIDER_RC2011():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.LanguageDataProvider._745976312DATA_PROVIDER_RC2011;
        }

        public static function get DATA_PROVIDER_SOFTWARESETTINGS_JA_CH():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.LanguageDataProvider._329911345DATA_PROVIDER_SOFTWARESETTINGS_JA_CH;
        }

        public static function set DATA_PROVIDER_SOFTWARESETTINGS_JA_CH(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.LanguageDataProvider._329911345DATA_PROVIDER_SOFTWARESETTINGS_JA_CH;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.LanguageDataProvider._329911345DATA_PROVIDER_SOFTWARESETTINGS_JA_CH = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER_SOFTWARESETTINGS_JA_CH", loc1, arg1, backend.utils.dataprovider.LanguageDataProvider);
                loc3 = backend.utils.dataprovider.LanguageDataProvider.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get DATA_PROVIDER_TOPLINE2009():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.LanguageDataProvider._1500203241DATA_PROVIDER_TOPLINE2009;
        }

        public static function get DATA_PROVIDER_TOPLINE2012():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.LanguageDataProvider._1500203217DATA_PROVIDER_TOPLINE2012;
        }

        public static function set DATA_PROVIDER_TOPLINE2012(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.LanguageDataProvider._1500203217DATA_PROVIDER_TOPLINE2012;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.LanguageDataProvider._1500203217DATA_PROVIDER_TOPLINE2012 = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER_TOPLINE2012", loc1, arg1, backend.utils.dataprovider.LanguageDataProvider);
                loc3 = backend.utils.dataprovider.LanguageDataProvider.staticEventDispatcher;
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

        public static function init():void
        {
            utils.dataprovider.CommonLanguageDataProvider.init();
            DATA_PROVIDER_BETA_TEST = new feathers.data.ListCollection(utils.dataprovider.CommonLanguageDataProvider.V_DATA_PROVIDER_BETA_TEST);
            DATA_PROVIDER_GPS10 = new feathers.data.ListCollection(utils.dataprovider.CommonLanguageDataProvider.V_DATA_PROVIDER_GPS10);
            DATA_PROVIDER_PC2814 = new feathers.data.ListCollection(utils.dataprovider.CommonLanguageDataProvider.V_DATA_PROVIDER_PC2814);
            DATA_PROVIDER_RC2011 = new feathers.data.ListCollection(utils.dataprovider.CommonLanguageDataProvider.V_DATA_PROVIDER_RC2011);
            DATA_PROVIDER_ROX100 = new feathers.data.ListCollection(utils.dataprovider.CommonLanguageDataProvider.V_DATA_PROVIDER_ROX100);
            DATA_PROVIDER_ROX2008 = new feathers.data.ListCollection(utils.dataprovider.CommonLanguageDataProvider.V_DATA_PROVIDER_ROX2008);
            DATA_PROVIDER_ROX2010 = new feathers.data.ListCollection(utils.dataprovider.CommonLanguageDataProvider.V_DATA_PROVIDER_ROX2010);
            DATA_PROVIDER_ROX70_ROX110 = new feathers.data.ListCollection(utils.dataprovider.CommonLanguageDataProvider.V_DATA_PROVIDER_ROX70_ROX110);
            DATA_PROVIDER_SOFTWARESETTINGS_EN = new feathers.data.ListCollection(utils.dataprovider.CommonLanguageDataProvider.V_DATA_PROVIDER_SOFTWARESETTINGS_EN);
            DATA_PROVIDER_SOFTWARESETTINGS_JA_CH = new feathers.data.ListCollection(utils.dataprovider.CommonLanguageDataProvider.V_DATA_PROVIDER_SOFTWARESETTINGS_JA_CH);
            DATA_PROVIDER_TOPLINE2009 = new feathers.data.ListCollection(utils.dataprovider.CommonLanguageDataProvider.V_DATA_PROVIDER_TOPLINE2009);
            DATA_PROVIDER_TOPLINE2012 = new feathers.data.ListCollection(utils.dataprovider.CommonLanguageDataProvider.V_DATA_PROVIDER_TOPLINE2012);
            return;
        }

        public static function getDataProviderByUnit(arg1:core.general.UnitType):feathers.data.ListCollection
        {
            var loc2:*=null;
            var loc1:*=core.units.UnitFactory.createUnitFromType(arg1);
            if (loc1 is core.units.UnitROX) 
            {
                loc2 = DATA_PROVIDER_ROX2008;
            }
            else if (loc1 is core.units.UnitROX2010) 
            {
                loc2 = DATA_PROVIDER_ROX2010;
            }
            else if (loc1 is core.units.UnitROX2010) 
            {
                loc2 = DATA_PROVIDER_TOPLINE2009;
            }
            else if (loc1 is core.units.UnitTopline2012 || loc1 is core.units.UnitTopline2016) 
            {
                loc2 = DATA_PROVIDER_TOPLINE2012;
            }
            else if (loc1 is core.units.UnitRC1411) 
            {
                loc2 = DATA_PROVIDER_RC2011;
            }
            else if (loc1 is core.units.UnitROX2012) 
            {
                loc2 = DATA_PROVIDER_TOPLINE2012;
            }
            else if (loc1 is core.units.UnitROX100) 
            {
                loc2 = DATA_PROVIDER_ROX100;
            }
            else if (loc1 is core.units.UnitPC2814) 
            {
                loc2 = DATA_PROVIDER_PC2814;
            }
            else if (loc1 is core.units.UnitROX70 || loc1 is core.units.UnitROX110) 
            {
                loc2 = DATA_PROVIDER_ROX70_ROX110;
            }
            else if (loc1 is core.units.UnitGps10) 
            {
                loc2 = DATA_PROVIDER_GPS10;
            }
            return loc2;
        }

        public static function get DATA_PROVIDER_BETA_TEST():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.LanguageDataProvider._1761242984DATA_PROVIDER_BETA_TEST;
        }

        public static function set DATA_PROVIDER_BETA_TEST(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.LanguageDataProvider._1761242984DATA_PROVIDER_BETA_TEST;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.LanguageDataProvider._1761242984DATA_PROVIDER_BETA_TEST = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER_BETA_TEST", loc1, arg1, backend.utils.dataprovider.LanguageDataProvider);
                loc3 = backend.utils.dataprovider.LanguageDataProvider.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get DATA_PROVIDER_GPS10():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.LanguageDataProvider._1557824112DATA_PROVIDER_GPS10;
        }

        public static function set DATA_PROVIDER_GPS10(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.LanguageDataProvider._1557824112DATA_PROVIDER_GPS10;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.LanguageDataProvider._1557824112DATA_PROVIDER_GPS10 = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER_GPS10", loc1, arg1, backend.utils.dataprovider.LanguageDataProvider);
                loc3 = backend.utils.dataprovider.LanguageDataProvider.staticEventDispatcher;
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
            return backend.utils.dataprovider.LanguageDataProvider._803226923DATA_PROVIDER_PC2814;
        }

        public static function set DATA_PROVIDER_PC2814(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.LanguageDataProvider._803226923DATA_PROVIDER_PC2814;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.LanguageDataProvider._803226923DATA_PROVIDER_PC2814 = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER_PC2814", loc1, arg1, backend.utils.dataprovider.LanguageDataProvider);
                loc3 = backend.utils.dataprovider.LanguageDataProvider.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function set DATA_PROVIDER_TOPLINE2009(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.LanguageDataProvider._1500203241DATA_PROVIDER_TOPLINE2009;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.LanguageDataProvider._1500203241DATA_PROVIDER_TOPLINE2009 = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER_TOPLINE2009", loc1, arg1, backend.utils.dataprovider.LanguageDataProvider);
                loc3 = backend.utils.dataprovider.LanguageDataProvider.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function set DATA_PROVIDER_RC2011(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.LanguageDataProvider._745976312DATA_PROVIDER_RC2011;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.LanguageDataProvider._745976312DATA_PROVIDER_RC2011 = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER_RC2011", loc1, arg1, backend.utils.dataprovider.LanguageDataProvider);
                loc3 = backend.utils.dataprovider.LanguageDataProvider.staticEventDispatcher;
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
            return backend.utils.dataprovider.LanguageDataProvider._733761073DATA_PROVIDER_ROX100;
        }

        public static function set DATA_PROVIDER_ROX100(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.LanguageDataProvider._733761073DATA_PROVIDER_ROX100;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.LanguageDataProvider._733761073DATA_PROVIDER_ROX100 = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER_ROX100", loc1, arg1, backend.utils.dataprovider.LanguageDataProvider);
                loc3 = backend.utils.dataprovider.LanguageDataProvider.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get DATA_PROVIDER_ROX2008():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.LanguageDataProvider._1271726936DATA_PROVIDER_ROX2008;
        }

        public static function set DATA_PROVIDER_ROX2008(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.LanguageDataProvider._1271726936DATA_PROVIDER_ROX2008;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.LanguageDataProvider._1271726936DATA_PROVIDER_ROX2008 = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER_ROX2008", loc1, arg1, backend.utils.dataprovider.LanguageDataProvider);
                loc3 = backend.utils.dataprovider.LanguageDataProvider.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get DATA_PROVIDER_ROX2010():feathers.data.ListCollection
        {
            return backend.utils.dataprovider.LanguageDataProvider._1271726913DATA_PROVIDER_ROX2010;
        }

        public static function set DATA_PROVIDER_ROX2010(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=backend.utils.dataprovider.LanguageDataProvider._1271726913DATA_PROVIDER_ROX2010;
            if (loc1 !== arg1) 
            {
                backend.utils.dataprovider.LanguageDataProvider._1271726913DATA_PROVIDER_ROX2010 = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "DATA_PROVIDER_ROX2010", loc1, arg1, backend.utils.dataprovider.LanguageDataProvider);
                loc3 = backend.utils.dataprovider.LanguageDataProvider.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal static var _1761242984DATA_PROVIDER_BETA_TEST:feathers.data.ListCollection;

        internal static var _1557824112DATA_PROVIDER_GPS10:feathers.data.ListCollection;

        internal static var _803226923DATA_PROVIDER_PC2814:feathers.data.ListCollection;

        internal static var _745976312DATA_PROVIDER_RC2011:feathers.data.ListCollection;

        internal static var _1271726936DATA_PROVIDER_ROX2008:feathers.data.ListCollection;

        internal static var _1271726913DATA_PROVIDER_ROX2010:feathers.data.ListCollection;

        internal static var _192133113DATA_PROVIDER_ROX70_ROX110:feathers.data.ListCollection;

        internal static var _102659941DATA_PROVIDER_SOFTWARESETTINGS_EN:feathers.data.ListCollection;

        internal static var _329911345DATA_PROVIDER_SOFTWARESETTINGS_JA_CH:feathers.data.ListCollection;

        internal static var _1500203241DATA_PROVIDER_TOPLINE2009:feathers.data.ListCollection;

        internal static var _1500203217DATA_PROVIDER_TOPLINE2012:feathers.data.ListCollection;

        internal static var _733761073DATA_PROVIDER_ROX100:feathers.data.ListCollection;

        internal static var _staticBindingEventDispatcher:starling.events.EventDispatcher;
    }
}


