//package allgemein
//  class ASAllgemein
package frontend.screen.appsettings.allgemein 
{
    import feathers.binding.*;
    import feathers.events.*;
    import flash.accessibility.*;
    import flash.data.*;
    import flash.debugger.*;
    import flash.desktop.*;
    import flash.errors.*;
    import flash.external.*;
    import flash.filesystem.*;
    import flash.geom.*;
    import flash.html.*;
    import flash.html.script.*;
    import flash.media.*;
    import flash.net.*;
    import flash.printing.*;
    import flash.profiler.*;
    import flash.system.*;
    import flash.text.*;
    import flash.ui.*;
    import flash.utils.*;
    import flash.xml.*;
    import frontend.screen.component.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    import utils.*;
    
    use namespace mx_internal;
    
    public class ASAllgemein extends frontend.screen.component.CustomScreen implements feathers.binding.IBindingClient
    {
        public function ASAllgemein()
        {
            var bindings:Array;
            var watchers:Array;
            var target:Object;
            var i:uint;
            var watcherSetupUtilClass:Object;

            var loc1:*;
            target = null;
            watcherSetupUtilClass = null;
            this.mx_internal::_bindings = [];
            this.mx_internal::_watchers = [];
            this.mx_internal::_bindingsByDestination = {};
            this.mx_internal::_bindingsBeginWithWord = {};
            super();
            bindings = this._ASAllgemein_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_appsettings_allgemein_ASAllgemeinWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return ASAllgemein[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.allowCaching = true;
            this.hasBackwardNavigation = true;
            this.mxmlContent = [this._ASAllgemein_GeneralAppSettings1_i(), this._ASAllgemein_Footer1_i()];
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        internal function _ASAllgemein_GeneralAppSettings1_i():frontend.screen.appsettings.allgemein.GeneralAppSettings
        {
            var loc1:*=new frontend.screen.appsettings.allgemein.GeneralAppSettings();
            loc1.id = "_ASAllgemein_GeneralAppSettings1";
            this._ASAllgemein_GeneralAppSettings1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ASAllgemein_GeneralAppSettings1", this._ASAllgemein_GeneralAppSettings1);
            return loc1;
        }

        internal function _ASAllgemein_Footer1_i():frontend.screen.component.Footer
        {
            var loc1:*=new frontend.screen.component.Footer();
            loc1.id = "footer";
            this.footer = loc1;
            feathers.binding.BindingManager.executeBindings(this, "footer", this.footer);
            return loc1;
        }

        internal function _ASAllgemein_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("APPSETTINGS.ALLGEMEIN.TITLE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.title")
            result[1] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight;
            }, null, "_ASAllgemein_GeneralAppSettings1.height")
            result[2] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_ASAllgemein_GeneralAppSettings1.width")
            return result;
        }

        public function get footer():frontend.screen.component.Footer
        {
            return this._1268861541footer;
        }

        public function set footer(arg1:frontend.screen.component.Footer):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1268861541footer;
            if (loc1 !== arg1) 
            {
                this._1268861541footer = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "footer", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            ASAllgemein._watcherSetupUtil = arg1;
            return;
        }

        public var _ASAllgemein_GeneralAppSettings1:frontend.screen.appsettings.allgemein.GeneralAppSettings;

        internal var _1268861541footer:frontend.screen.component.Footer;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//  class GeneralAppSettings
package frontend.screen.appsettings.allgemein 
{
    import backend.utils.dataprovider.*;
    import configCache.*;
    import core.*;
    import core.general.*;
    import feathers.binding.*;
    import feathers.data.*;
    import flash.accessibility.*;
    import flash.data.*;
    import flash.debugger.*;
    import flash.desktop.*;
    import flash.errors.*;
    import flash.external.*;
    import flash.filesystem.*;
    import flash.geom.*;
    import flash.html.*;
    import flash.html.script.*;
    import flash.media.*;
    import flash.net.*;
    import flash.printing.*;
    import flash.profiler.*;
    import flash.system.*;
    import flash.text.*;
    import flash.ui.*;
    import flash.utils.*;
    import flash.xml.*;
    import frontend.*;
    import frontend.components.menuList.*;
    import frontend.components.menuList.editors.base.*;
    import frontend.components.scrollContainer.*;
    import handler.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    import utils.*;
    import utils.format.*;
    
    use namespace mx_internal;
    
    public class GeneralAppSettings extends frontend.components.scrollContainer.CustomVScrollContainer implements feathers.binding.IBindingClient
    {
        public function GeneralAppSettings()
        {
            var bindings:Array;
            var watchers:Array;
            var target:Object;
            var i:uint;
            var watcherSetupUtilClass:Object;

            var loc1:*;
            target = null;
            watcherSetupUtilClass = null;
            this.mx_internal::_bindings = [];
            this.mx_internal::_watchers = [];
            this.mx_internal::_bindingsByDestination = {};
            this.mx_internal::_bindingsBeginWithWord = {};
            super();
            bindings = this._GeneralAppSettings_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_appsettings_allgemein_GeneralAppSettingsWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return GeneralAppSettings[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.mxmlContent = [this._GeneralAppSettings_MenuList1_i()];
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        internal function onSaveComplete(arg1:frontend.components.menuList.MenuListItem, arg2:frontend.components.menuList.editors.base.EditorReturnObject):void
        {
            var loc1:*=configCache.ConfigCache.getInstance().getValue(configCache.ConfigCacheAttributeNames.LANGUAGE, core.general.LanguageSoftware.DE_DE);
            utils.LanguageManager.getStringFunction = frontend.Locales.locale().getString;
            frontend.Locales.locale().localeChain = [loc1];
            frontend.Locales.locale().addBundle(loc1, frontend.Locales.DEFAULT_LANGUAGE_BUNDLENAME, true, this.loadLabelsReady);
            return;
        }

        internal function loadLabelsReady(arg1:Object=null, arg2:Object=null, arg3:Object=null):void
        {
            handler.ViewHandler.getInstance().updateScreens();
            return;
        }

        internal function _GeneralAppSettings_MenuList1_i():frontend.components.menuList.MenuList
        {
            var loc1:*=new frontend.components.menuList.MenuList();
            loc1.mxmlContent = [this._GeneralAppSettings_MenuListItem1_i(), this._GeneralAppSettings_MenuListItem2_i(), this._GeneralAppSettings_MenuListItem3_i(), this._GeneralAppSettings_MenuListItem4_i(), this._GeneralAppSettings_MenuListItem5_i(), this._GeneralAppSettings_MenuListItem6_i(), this._GeneralAppSettings_MenuListItem7_i()];
            loc1.id = "_GeneralAppSettings_MenuList1";
            this._GeneralAppSettings_MenuList1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_GeneralAppSettings_MenuList1", this._GeneralAppSettings_MenuList1);
            return loc1;
        }

        internal function _GeneralAppSettings_MenuListItem1_i():frontend.components.menuList.MenuListItem
        {
            var loc1:*=new frontend.components.menuList.MenuListItem();
            loc1.editable = true;
            loc1.saveCompleteCallback = this.onSaveComplete;
            loc1.text = "ASALLGEMEIN.SPRACHE";
            loc1.title = "ASALLGEMEIN.SPRACHE";
            loc1.useConfigCache = true;
            loc1.useLocalesForText = true;
            loc1.useLocalesForTitle = true;
            loc1.id = "_GeneralAppSettings_MenuListItem1";
            this._GeneralAppSettings_MenuListItem1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_GeneralAppSettings_MenuListItem1", this._GeneralAppSettings_MenuListItem1);
            return loc1;
        }

        internal function _GeneralAppSettings_MenuListItem2_i():frontend.components.menuList.MenuListItem
        {
            var loc1:*=new frontend.components.menuList.MenuListItem();
            loc1.editable = true;
            loc1.saveCompleteCallback = this.onSaveComplete;
            loc1.text = "ASALLGEMEIN.DATUM";
            loc1.title = "ASALLGEMEIN.DATUM";
            loc1.useConfigCache = true;
            loc1.useLocalesForText = true;
            loc1.useLocalesForTitle = true;
            loc1.id = "_GeneralAppSettings_MenuListItem2";
            this._GeneralAppSettings_MenuListItem2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_GeneralAppSettings_MenuListItem2", this._GeneralAppSettings_MenuListItem2);
            return loc1;
        }

        internal function _GeneralAppSettings_MenuListItem3_i():frontend.components.menuList.MenuListItem
        {
            var loc1:*=new frontend.components.menuList.MenuListItem();
            loc1.editable = true;
            loc1.saveCompleteCallback = this.onSaveComplete;
            loc1.text = "ASALLGEMEIN.UHRZEIT";
            loc1.title = "ASALLGEMEIN.UHRZEIT";
            loc1.useConfigCache = true;
            loc1.useLocalesForText = true;
            loc1.useLocalesForTitle = true;
            loc1.id = "_GeneralAppSettings_MenuListItem3";
            this._GeneralAppSettings_MenuListItem3 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_GeneralAppSettings_MenuListItem3", this._GeneralAppSettings_MenuListItem3);
            return loc1;
        }

        internal function _GeneralAppSettings_MenuListItem4_i():frontend.components.menuList.MenuListItem
        {
            var loc1:*=new frontend.components.menuList.MenuListItem();
            loc1.editable = true;
            loc1.saveCompleteCallback = this.onSaveComplete;
            loc1.text = "ASALLGEMEIN.STRECKE";
            loc1.title = "ASALLGEMEIN.STRECKE";
            loc1.useConfigCache = true;
            loc1.useLocalesForText = true;
            loc1.useLocalesForTitle = true;
            loc1.id = "_GeneralAppSettings_MenuListItem4";
            this._GeneralAppSettings_MenuListItem4 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_GeneralAppSettings_MenuListItem4", this._GeneralAppSettings_MenuListItem4);
            return loc1;
        }

        internal function _GeneralAppSettings_MenuListItem5_i():frontend.components.menuList.MenuListItem
        {
            var loc1:*=new frontend.components.menuList.MenuListItem();
            loc1.editable = true;
            loc1.saveCompleteCallback = this.onSaveComplete;
            loc1.text = "ASALLGEMEIN.HOEHE";
            loc1.title = "ASALLGEMEIN.HOEHE";
            loc1.useConfigCache = true;
            loc1.useLocalesForText = true;
            loc1.useLocalesForTitle = true;
            loc1.id = "_GeneralAppSettings_MenuListItem5";
            this._GeneralAppSettings_MenuListItem5 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_GeneralAppSettings_MenuListItem5", this._GeneralAppSettings_MenuListItem5);
            return loc1;
        }

        internal function _GeneralAppSettings_MenuListItem6_i():frontend.components.menuList.MenuListItem
        {
            var loc1:*=new frontend.components.menuList.MenuListItem();
            loc1.editable = true;
            loc1.saveCompleteCallback = this.onSaveComplete;
            loc1.text = "ASALLGEMEIN.GEWICHT";
            loc1.title = "ASALLGEMEIN.GEWICHT";
            loc1.useConfigCache = true;
            loc1.useLocalesForText = true;
            loc1.useLocalesForTitle = true;
            loc1.id = "_GeneralAppSettings_MenuListItem6";
            this._GeneralAppSettings_MenuListItem6 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_GeneralAppSettings_MenuListItem6", this._GeneralAppSettings_MenuListItem6);
            return loc1;
        }

        internal function _GeneralAppSettings_MenuListItem7_i():frontend.components.menuList.MenuListItem
        {
            var loc1:*=new frontend.components.menuList.MenuListItem();
            loc1.editable = true;
            loc1.saveCompleteCallback = this.onSaveComplete;
            loc1.text = "ASALLGEMEIN.TEMPERATUR";
            loc1.title = "ASALLGEMEIN.TEMPERATUR";
            loc1.useConfigCache = true;
            loc1.useLocalesForText = true;
            loc1.useLocalesForTitle = true;
            loc1.id = "_GeneralAppSettings_MenuListItem7";
            this._GeneralAppSettings_MenuListItem7 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_GeneralAppSettings_MenuListItem7", this._GeneralAppSettings_MenuListItem7);
            return loc1;
        }

        internal function _GeneralAppSettings_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_GeneralAppSettings_MenuList1.width")
            result[1] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=configCache.ConfigCacheAttributeNames.LANGUAGE;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_GeneralAppSettings_MenuListItem1.configCacheAttribute")
            result[2] = new feathers.binding.Binding(this, function ():feathers.data.ListCollection
            {
                return generateLanguageDataProvider();
            }, null, "_GeneralAppSettings_MenuListItem1.dataProvider")
            result[3] = new feathers.binding.Binding(this, function ():Object
            {
                return configCache.ConfigCache.getInstance().getValue(configCache.ConfigCacheAttributeNames.LANGUAGE, core.general.LanguageSoftware.DE_DE);
            }, null, "_GeneralAppSettings_MenuListItem1.defaultValue")
            result[4] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
            }, null, "_GeneralAppSettings_MenuListItem1.minItemHeight")
            result[5] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SPINNER;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_GeneralAppSettings_MenuListItem1.type")
            result[6] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=configCache.ConfigCacheAttributeNames.DATE_FORMAT;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_GeneralAppSettings_MenuListItem2.configCacheAttribute")
            result[7] = new feathers.binding.Binding(this, function ():feathers.data.ListCollection
            {
                return backend.utils.dataprovider.DateFormatDataProvider.DATA_PROVIDER;
            }, null, "_GeneralAppSettings_MenuListItem2.dataProvider")
            result[8] = new feathers.binding.Binding(this, function ():Object
            {
                return configCache.ConfigCache.getInstance().getValue(configCache.ConfigCacheAttributeNames.DATE_FORMAT, utils.format.DateFormat.EUROPEAN);
            }, null, "_GeneralAppSettings_MenuListItem2.defaultValue")
            result[9] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
            }, null, "_GeneralAppSettings_MenuListItem2.minItemHeight")
            result[10] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SPINNER;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_GeneralAppSettings_MenuListItem2.type")
            result[11] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=configCache.ConfigCacheAttributeNames.CLOCK_FORMAT;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_GeneralAppSettings_MenuListItem3.configCacheAttribute")
            result[12] = new feathers.binding.Binding(this, function ():feathers.data.ListCollection
            {
                return backend.utils.dataprovider.ClockFormatDataProvider.DATA_PROVIDER;
            }, null, "_GeneralAppSettings_MenuListItem3.dataProvider")
            result[13] = new feathers.binding.Binding(this, function ():Object
            {
                return configCache.ConfigCache.getInstance().getValue(configCache.ConfigCacheAttributeNames.CLOCK_FORMAT, utils.format.ClockFormat.CLOCK_24H);
            }, null, "_GeneralAppSettings_MenuListItem3.defaultValue")
            result[14] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
            }, null, "_GeneralAppSettings_MenuListItem3.minItemHeight")
            result[15] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SPINNER;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_GeneralAppSettings_MenuListItem3.type")
            result[16] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=configCache.ConfigCacheAttributeNames.DISTANCE_FORMAT;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_GeneralAppSettings_MenuListItem4.configCacheAttribute")
            result[17] = new feathers.binding.Binding(this, function ():feathers.data.ListCollection
            {
                return backend.utils.dataprovider.DistanceUnitDataProvider.DATA_PROVIDER_SOFTWARE_SETTINGS;
            }, null, "_GeneralAppSettings_MenuListItem4.dataProvider")
            result[18] = new feathers.binding.Binding(this, function ():Object
            {
                return configCache.ConfigCache.getInstance().getValue(configCache.ConfigCacheAttributeNames.DISTANCE_FORMAT, utils.format.DistanceFormat.KILOMETER);
            }, null, "_GeneralAppSettings_MenuListItem4.defaultValue")
            result[19] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
            }, null, "_GeneralAppSettings_MenuListItem4.minItemHeight")
            result[20] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SPINNER;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_GeneralAppSettings_MenuListItem4.type")
            result[21] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=configCache.ConfigCacheAttributeNames.ALTITUDE_FORMAT;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_GeneralAppSettings_MenuListItem5.configCacheAttribute")
            result[22] = new feathers.binding.Binding(this, function ():feathers.data.ListCollection
            {
                return backend.utils.dataprovider.AltitudeUnitDataProvider.DATA_PROVIDER_SOFTWARE_SETTINGS;
            }, null, "_GeneralAppSettings_MenuListItem5.dataProvider")
            result[23] = new feathers.binding.Binding(this, function ():Object
            {
                return configCache.ConfigCache.getInstance().getValue(configCache.ConfigCacheAttributeNames.ALTITUDE_FORMAT, utils.format.AltitudeFormat.METER);
            }, null, "_GeneralAppSettings_MenuListItem5.defaultValue")
            result[24] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
            }, null, "_GeneralAppSettings_MenuListItem5.minItemHeight")
            result[25] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SPINNER;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_GeneralAppSettings_MenuListItem5.type")
            result[26] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=configCache.ConfigCacheAttributeNames.WEIGHT_FORMAT;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_GeneralAppSettings_MenuListItem6.configCacheAttribute")
            result[27] = new feathers.binding.Binding(this, function ():feathers.data.ListCollection
            {
                return backend.utils.dataprovider.WeightUnitDataProvider.DATA_PROVIDER;
            }, null, "_GeneralAppSettings_MenuListItem6.dataProvider")
            result[28] = new feathers.binding.Binding(this, function ():Object
            {
                return configCache.ConfigCache.getInstance().getValue(configCache.ConfigCacheAttributeNames.WEIGHT_FORMAT, core.general.WeightUnit.KG);
            }, null, "_GeneralAppSettings_MenuListItem6.defaultValue")
            result[29] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
            }, null, "_GeneralAppSettings_MenuListItem6.minItemHeight")
            result[30] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SPINNER;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_GeneralAppSettings_MenuListItem6.type")
            result[31] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=configCache.ConfigCacheAttributeNames.TEMPERATURE_FORMAT;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_GeneralAppSettings_MenuListItem7.configCacheAttribute")
            result[32] = new feathers.binding.Binding(this, function ():feathers.data.ListCollection
            {
                return backend.utils.dataprovider.TemperatureUnitDataProvider.DATA_PROVIDER_SOFTWARE_SETTINGS;
            }, null, "_GeneralAppSettings_MenuListItem7.dataProvider")
            result[33] = new feathers.binding.Binding(this, function ():Object
            {
                return configCache.ConfigCache.getInstance().getValue(configCache.ConfigCacheAttributeNames.TEMPERATURE_FORMAT, utils.format.TemperatureFormat.CELSIUS);
            }, null, "_GeneralAppSettings_MenuListItem7.defaultValue")
            result[34] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
            }, null, "_GeneralAppSettings_MenuListItem7.minItemHeight")
            result[35] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SPINNER;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_GeneralAppSettings_MenuListItem7.type")
            return result;
        }

        internal static function generateLanguageDataProvider():feathers.data.ListCollection
        {
            if (handler.ApplicationHandler.isBeta) 
            {
                return backend.utils.dataprovider.LanguageDataProvider.DATA_PROVIDER_BETA_TEST;
            }
            if (core.MeasurementConfig.language == core.general.LanguageSoftware.ZH_CN || core.MeasurementConfig.language == core.general.LanguageSoftware.JA_JP) 
            {
                return backend.utils.dataprovider.LanguageDataProvider.DATA_PROVIDER_SOFTWARESETTINGS_JA_CH;
            }
            return backend.utils.dataprovider.LanguageDataProvider.DATA_PROVIDER_SOFTWARESETTINGS_EN;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            GeneralAppSettings._watcherSetupUtil = arg1;
            return;
        }

        public var _GeneralAppSettings_MenuList1:frontend.components.menuList.MenuList;

        public var _GeneralAppSettings_MenuListItem1:frontend.components.menuList.MenuListItem;

        public var _GeneralAppSettings_MenuListItem2:frontend.components.menuList.MenuListItem;

        public var _GeneralAppSettings_MenuListItem3:frontend.components.menuList.MenuListItem;

        public var _GeneralAppSettings_MenuListItem4:frontend.components.menuList.MenuListItem;

        public var _GeneralAppSettings_MenuListItem5:frontend.components.menuList.MenuListItem;

        public var _GeneralAppSettings_MenuListItem6:frontend.components.menuList.MenuListItem;

        public var _GeneralAppSettings_MenuListItem7:frontend.components.menuList.MenuListItem;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


