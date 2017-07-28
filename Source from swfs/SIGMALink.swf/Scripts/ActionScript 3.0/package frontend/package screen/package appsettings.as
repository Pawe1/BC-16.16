//package appsettings
//  package allgemein
//    class ASAllgemein
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


//    class GeneralAppSettings
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


//  package benutzer
//    class ASBenutzer
package frontend.screen.appsettings.benutzer 
{
    import __AS3__.vec.*;
    import backend.utils.dbUtils.*;
    import core.general.*;
    import core.user.*;
    import database.*;
    import debug.*;
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
    import frontend.*;
    import frontend.components.button.*;
    import frontend.components.menuList.*;
    import frontend.components.popup.*;
    import frontend.components.scrollContainer.*;
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
    
    public class ASBenutzer extends frontend.screen.component.CustomScreen implements feathers.binding.IBindingClient
    {
        public function ASBenutzer()
        {
            var bindings:Array;
            var watchers:Array;
            var target:Object;
            var i:uint;
            var watcherSetupUtilClass:Object;

            var loc1:*;
            target = null;
            watcherSetupUtilClass = null;
            this._buttonAdd = new frontend.components.button.IconButton();
            this._buttonCancel = new frontend.components.button.IconButton();
            this._buttonDelete = new frontend.components.button.IconButton();
            this._buttonEdit = new frontend.components.button.IconButton();
            this.mx_internal::_bindings = [];
            this.mx_internal::_watchers = [];
            this.mx_internal::_bindingsByDestination = {};
            this.mx_internal::_bindingsBeginWithWord = {};
            super();
            bindings = this._ASBenutzer_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_appsettings_benutzer_ASBenutzerWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return ASBenutzer[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.allowCaching = true;
            this.hasBackwardNavigation = true;
            this.mxmlContent = [this._ASBenutzer_CustomVScrollContainer1_i(), this._ASBenutzer_Footer1_i()];
            this.addEventListener("initialize", this.___ASBenutzer_CustomScreen1_initialize);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        internal function _ASBenutzer_CustomVScrollContainer1_i():frontend.components.scrollContainer.CustomVScrollContainer
        {
            var loc1:*=new frontend.components.scrollContainer.CustomVScrollContainer();
            loc1.mxmlContent = [this._ASBenutzer_MenuList1_i()];
            loc1.id = "scroller";
            this.scroller = loc1;
            feathers.binding.BindingManager.executeBindings(this, "scroller", this.scroller);
            return loc1;
        }

        internal function _ASBenutzer_MenuList1_i():frontend.components.menuList.MenuList
        {
            var loc1:*=new frontend.components.menuList.MenuList();
            loc1.id = "userList";
            this.userList = loc1;
            feathers.binding.BindingManager.executeBindings(this, "userList", this.userList);
            return loc1;
        }

        internal function _ASBenutzer_Footer1_i():frontend.screen.component.Footer
        {
            var loc1:*=new frontend.screen.component.Footer();
            loc1.id = "footer";
            this.footer = loc1;
            feathers.binding.BindingManager.executeBindings(this, "footer", this.footer);
            return loc1;
        }

        public function ___ASBenutzer_CustomScreen1_initialize(arg1:starling.events.Event):void
        {
            this.initializeHandler(arg1);
            return;
        }

        internal function _ASBenutzer_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("APPSETTINGS.BENUTZER.TITLE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.title")
            result[1] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight;
            }, null, "scroller.height")
            result[2] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "scroller.width")
            result[3] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "userList.width")
            return result;
        }

        protected function cancelEditHandler(arg1:starling.events.TouchEvent):void
        {
            this.userList.selectMode = false;
            this.setFooterButtons();
            return;
        }

        public function get footer():frontend.screen.component.Footer
        {
            return this._1268861541footer;
        }

        public function get scroller():frontend.components.scrollContainer.CustomVScrollContainer
        {
            return this._402164678scroller;
        }

        public function set scroller(arg1:frontend.components.scrollContainer.CustomVScrollContainer):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._402164678scroller;
            if (loc1 !== arg1) 
            {
                this._402164678scroller = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "scroller", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get userList():frontend.components.menuList.MenuList
        {
            return this._266718455userList;
        }

        public function set userList(arg1:frontend.components.menuList.MenuList):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._266718455userList;
            if (loc1 !== arg1) 
            {
                this._266718455userList = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "userList", loc1, arg1, this);
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
            ASBenutzer._watcherSetupUtil = arg1;
            return;
        }

        protected function initializeHandler(arg1:starling.events.Event):void
        {
            this._buttonEdit = new frontend.components.button.IconButton();
            this._buttonEdit.image = frontend.Textures.editbutton;
            this._buttonEdit.touchHandler = this.editUserHandler;
            this._buttonDelete = new frontend.components.button.IconButton();
            this._buttonDelete.image = frontend.Textures.trashicon;
            this._buttonDelete.touchHandler = this.deleteUserHandler;
            this._buttonCancel = new frontend.components.button.IconButton();
            this._buttonCancel.image = frontend.Textures.closeicon;
            this._buttonCancel.touchHandler = this.cancelEditHandler;
            this._buttonAdd = new frontend.components.button.IconButton();
            this._buttonAdd.image = frontend.Textures.addiconwhite;
            this._buttonAdd.touchHandler = this.addUserHandler;
            this.setFooterButtons();
            return;
        }

        internal function setFooterButtons():void
        {
            this._buttonGroup = new Vector.<frontend.components.button.IconButton>();
            this._buttonEdit.isEnabled = this._userCount > 1;
            this._buttonDelete.isEnabled = this._userCount > 1;
            if (this.userList.selectMode) 
            {
                this._buttonGroup.push(this._buttonDelete);
                this._buttonGroup.push(this._buttonCancel);
            }
            else 
            {
                this._buttonGroup.push(this._buttonAdd);
                this._buttonGroup.push(this._buttonEdit);
            }
            this.footer.showBackButton = !this.userList.selectMode;
            this.footer.setButtonGroup(this._buttonGroup);
            return;
        }

        protected override function addContent():void
        {
            this.userList.removeChildren();
            var loc1:*=core.user.User.statementGetUsers();
            loc1 = loc1 + " ORDER BY name COLLATE NOCASE ASC";
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, loc1, this.loadUsersComplete, this.loadUsersError, Workers.worker_DatabaseWorker);
            return;
        }

        internal function loadUsersComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            var loc2:*=0;
            var loc4:*=null;
            var loc1:*=arg1.getResult();
            var loc3:*=loc1.length;
            this._userCount = 0;
            this._buttonEdit.isEnabled = false;
            this._buttonDelete.isEnabled = false;
            loc2 = 0;
            while (loc2 < loc3) 
            {
                loc4 = new core.user.User();
                loc4.fromDB(loc1[loc2]);
                this.addUser(loc4);
                ++loc2;
            }
            this._buttonEdit.isEnabled = this._userCount > 1;
            return;
        }

        internal function addUser(arg1:core.user.User):frontend.components.menuList.MenuListItem
        {
            var loc1:*=this.createItem(arg1);
            loc1.saveToDbUseUpdate = true;
            loc1.saveToDbUseUpdateObject = this.createSQLUpdateObject(arg1);
            this.userList.addChild(loc1);
            var loc2:*;
            var loc3:*=((loc2 = this)._userCount + 1);
            loc2._userCount = loc3;
            return loc1;
        }

        internal function createItem(arg1:core.user.User=null):frontend.components.menuList.MenuListItem
        {
            var loc1:*=new frontend.components.menuList.MenuListItem();
            loc1.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TEXTFIELD;
            loc1.minItemHeight = frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
            loc1.editable = true;
            loc1.displayText = false;
            loc1.defaultValue = arg1 ? arg1.name : "";
            loc1.useLocalesForText = false;
            loc1.title = "ASBENUTZER.LINETITLENAME";
            loc1.destinationObject = arg1;
            loc1.useLocalesForTitle = true;
            return loc1;
        }

        internal function createSQLUpdateObject(arg1:core.user.User):frontend.components.menuList.MenuListDbObject
        {
            var loc1:*=new frontend.components.menuList.MenuListDbObject();
            loc1.keyField = core.user.User.COL_USER_ID;
            loc1.keyValue = arg1.userId.toString();
            loc1.updateField = core.user.User.COL_NAME;
            loc1.table = core.user.User.TABLE_NAME;
            loc1.updateModificationDate = false;
            return loc1;
        }

        internal function loadUsersError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.debug("loadUsersError");
            return;
        }

        protected function addUserHandler(arg1:starling.events.TouchEvent):void
        {
            debug.Debug.debug("addUserButtonClicked");
            var loc1:*=this.createItem();
            loc1.addEventListener("completeEvent", this.onAddUserComplete);
            loc1.onInit();
            loc1.showEditor();
            return;
        }

        internal function onAddUserComplete(arg1:starling.events.Event):void
        {
            var loc1:*=arg1.currentTarget as frontend.components.menuList.MenuListItem;
            var loc2:*="INSERT OR REPLACE INTO User (name, gender, color) VALUES (:name, :gender, :color)";
            var loc3:*=new Object();
            loc3[":name"] = loc1.value as String;
            loc3[":gender"] = core.general.Gender.MALE;
            loc3[":color"] = core.general.Colors.RED;
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.UPDATE, loc2, this.insertUsersComplete, this.insertUsersError, null, null, loc3);
            return;
        }

        internal function insertUsersComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            this.addContent();
            return;
        }

        internal function insertUsersError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.debug("ASBenutzer > insertUsersError");
            return;
        }

        protected function editUserHandler(arg1:starling.events.TouchEvent):void
        {
            this.userList.selectMode = true;
            this.setFooterButtons();
            return;
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

        protected function deleteUserHandler(arg1:starling.events.TouchEvent):void
        {
            var loc1:*=0;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=null;
            this._deleteUserList = new Vector.<core.user.User>();
            this._restUserList = new Vector.<core.user.User>();
            var loc2:*=this.userList.numChildren;
            loc1 = 0;
            while (loc1 < loc2) 
            {
                loc3 = this.userList.getChildAt(loc1) as frontend.components.menuList.MenuListItem;
                loc4 = loc3.destinationObject as core.user.User;
                if (loc3 && loc3.isSelected) 
                {
                    this._deleteUserList.push(loc4);
                }
                else 
                {
                    this._restUserList.push(loc4);
                }
                ++loc1;
            }
            if (this._restUserList.length == 0) 
            {
                loc6 = new frontend.components.popup.InfoPopUp(false, true, null, this.onErrorPopUpClose);
                loc6.headline = utils.LanguageManager.getString("DELETE_POPUP.DELETE_USERS_TITLE");
                loc6.text = utils.LanguageManager.getString("DELETE_POPUP.DELETE_USERS_ERROR_MINIMUM_ONE_USER");
                frontend.components.popup.PopUpBase.showModalPopUp(loc6);
                return;
            }
            if (this._deleteUserList.length > 0) 
            {
                this._deletePopUp = new frontend.screen.appsettings.benutzer.DeleteUserPopUp();
                this._deletePopUp.users = this._restUserList;
                this._deletePopUp.numToDelete = this._deleteUserList.length;
                this._deletePopUp.cancelCallback = this.onPopUpClose;
                this._deletePopUp.deleteCallback = this.onPopUpDelete;
                frontend.components.popup.PopUpBase.showModalPopUp(this._deletePopUp);
            }
            return;
        }

        internal function onErrorPopUpClose(arg1:frontend.components.popup.InfoPopUp):void
        {
            frontend.components.popup.PopUpBase.removePopUps(arg1, true);
            return;
        }

        internal function onPopUpClose():void
        {
            frontend.components.popup.PopUpBase.removePopUps(this._deletePopUp, true);
            return;
        }

        internal function onPopUpDelete():void
        {
            var loc1:*=0;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=null;
            var loc2:*=this._deleteUserList.length;
            if (this._deleteUserList.length > 0) 
            {
                loc4 = this._deleteUserList.shift();
                loc5 = "UPDATE Activity set userId = \'" + this._deletePopUp.selectedUserId + "\' WHERE userId = \'" + loc4.userId + "\'";
                backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.UPDATE, loc5, this.onUpdateActivityComplete, this.onUpdateActivityError, Workers.worker_DatabaseWorker, loc4);
            }
            else 
            {
                this.userList.selectMode = false;
                this.setFooterButtons();
                frontend.components.popup.PopUpBase.removePopUps(this._deletePopUp, true);
                this.addContent();
            }
            return;
        }

        internal function onUpdateActivityComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            var loc1:*=arg1.data.data as core.user.User;
            var loc2:*=(loc1.generateDBDelete()[0] as database.DCSQLStatement).text;
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.UPDATE, loc2, this.onDeleteUserComplete, this.onDeleteUserError);
            return;
        }

        internal function onUpdateActivityError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.debug("onUpdateActivityError");
            return;
        }

        internal function onDeleteUserComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            this.onPopUpDelete();
            return;
        }

        internal function onDeleteUserError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.debug("onDeleteActivityError");
            return;
        }

        internal var _1268861541footer:frontend.screen.component.Footer;

        internal var _402164678scroller:frontend.components.scrollContainer.CustomVScrollContainer;

        internal var _266718455userList:frontend.components.menuList.MenuList;

        internal var _buttonAdd:frontend.components.button.IconButton;

        internal var _buttonCancel:frontend.components.button.IconButton;

        internal var _buttonEdit:frontend.components.button.IconButton;

        internal var _buttonGroup:__AS3__.vec.Vector.<frontend.components.button.IconButton>;

        internal var _deletePopUp:frontend.screen.appsettings.benutzer.DeleteUserPopUp;

        internal var _deleteUserList:__AS3__.vec.Vector.<core.user.User>;

        internal var _restUserList:__AS3__.vec.Vector.<core.user.User>;

        internal var _userCount:uint=0;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        mx_internal var _bindings:Array;

        internal var _buttonDelete:frontend.components.button.IconButton;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//    class DeleteUserPopUp
package frontend.screen.appsettings.benutzer 
{
    import __AS3__.vec.*;
    import core.general.*;
    import feathers.controls.*;
    import feathers.data.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import frontend.components.core.*;
    import frontend.components.menuList.*;
    import frontend.components.popup.*;
    import starling.display.*;
    import starling.events.*;
    import utils.*;
    
    public class DeleteUserPopUp extends frontend.components.popup.DeletePopUp
    {
        public function DeleteUserPopUp()
        {
            super();
            title = utils.LanguageManager.getString("DELETE_POPUP.DELETE_USERS_TITLE");
            deleteBtnLabel = utils.LanguageManager.getString("DELETE_POPUP.DELETE_USERS_CONFIRM");
            return;
        }

        public function get users():__AS3__.vec.Vector.<core.user.User>
        {
            return this._users;
        }

        public function set users(arg1:__AS3__.vec.Vector.<core.user.User>):void
        {
            this._users = arg1;
            return;
        }

        internal function onUserSelected(arg1:starling.events.Event):void
        {
            this.selectedUserId = (arg1.currentTarget as frontend.components.menuList.MenuListItem).value as int;
            return;
        }

        protected override function validatePopUpSize():void
        {
            FOOTER_HEIGHT = 90 * SIGMALink.scaleFactor;
            HEADER_HEIGHT = 90 * SIGMALink.scaleFactor;
            height = SIGMALink.appHeight * 0.7;
            return;
        }

        protected override function addContent():void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc5:*=null;
            var loc6:*=null;
            contentHolder = new feathers.controls.LayoutGroup();
            contentHolder.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            contentHolder.layout = new feathers.layout.AnchorLayout();
            contentHolder.layoutData = contentLayoutData;
            contentHolder.width = SIGMALink.appWidth;
            contentHolder.height = height - HEADER_HEIGHT - FOOTER_HEIGHT;
            addChild(contentHolder);
            loc1 = new feathers.data.ListCollection();
            var loc3:*=this.users.length;
            loc2 = 0;
            while (loc2 < loc3) 
            {
                loc1.push({"label":this.users[loc2].name, "data":this.users[loc2].userId});
                ++loc2;
            }
            var loc4:*=new feathers.layout.VerticalLayout();
            loc4.padding = 0;
            loc4.gap = 0;
            loc5 = new feathers.controls.LayoutGroup();
            loc5.layout = loc4;
            loc5.width = SIGMALink.appWidth;
            loc6 = new feathers.controls.Label();
            loc6.text = this.numToDelete != 1 ? utils.LanguageManager.getString("DELETE_POPUP.DELETE_USERS_WARNING_MULTI") : utils.LanguageManager.getString("DELETE_POPUP.DELETE_USERS_WARNING_SINGLE");
            loc6.wordWrap = true;
            loc6.width = SIGMALink.appWidth - 2 * _layoutGap;
            loc6.padding = _layoutGap;
            loc6.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUITEM;
            loc5.addChild(loc6);
            var loc7:*=new frontend.components.core.Spacer();
            loc7.height = _layoutGap;
            loc5.addChild(loc7);
            var loc8:*=new feathers.controls.Label();
            loc8.text = utils.LanguageManager.getString("DELETE_POPUP.DELETE_USERS_TEXT");
            loc8.wordWrap = true;
            loc8.width = SIGMALink.appWidth - 2 * _layoutGap;
            loc8.padding = _layoutGap;
            loc8.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUITEM;
            loc5.addChild(loc8);
            var loc9:*=new starling.display.Quad(SIGMALink.appWidth, 1, core.general.Colors.LIGHTGREY);
            loc5.addChild(loc9);
            this.selectedUserId = this.users[0].userId;
            var loc10:*=new frontend.components.menuList.MenuListItem();
            loc10.dataProvider = loc1;
            loc10.defaultValue = this.users[0].userId;
            loc10.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SPINNER;
            loc10.editable = true;
            loc10.minItemHeight = frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
            loc10.text = "APPSETTINGS.BENUTZER";
            loc10.title = "APPSETTINGS.BENUTZER";
            loc10.addEventListener("completeEvent", this.onUserSelected);
            loc5.addChild(loc10);
            var loc11:*=new starling.display.Quad(SIGMALink.appWidth, 1, core.general.Colors.LIGHTGREY);
            loc5.addChild(loc11);
            contentHolder.addChild(loc5);
            return;
        }

        protected override function validatePopUpContent():void
        {
            return;
        }

        public var numToDelete:int;

        public var selectedUserId:int;

        internal var _users:__AS3__.vec.Vector.<core.user.User>;
    }
}


//  package cloud
//    class ASCloud
package frontend.screen.appsettings.cloud 
{
    import frontend.screen.cloud.*;
    
    public class ASCloud extends frontend.screen.cloud.CloudView
    {
        public function ASCloud()
        {
            super();
            return;
        }
    }
}


//  package karten
//    class ASKarten
package frontend.screen.appsettings.karten 
{
    import configCache.*;
    import feathers.binding.*;
    import feathers.controls.*;
    import feathers.events.*;
    import feathers.layout.*;
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
    import frontend.components.*;
    import frontend.components.map.*;
    import frontend.components.menuList.*;
    import frontend.components.scrollContainer.*;
    import frontend.screen.component.*;
    import handler.*;
    import helper.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    import utils.*;
    
    use namespace mx_internal;
    
    public class ASKarten extends frontend.screen.component.CustomScreen implements feathers.binding.IBindingClient
    {
        public function ASKarten()
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
            bindings = this._ASKarten_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_appsettings_karten_ASKartenWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return ASKarten[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.allowCaching = true;
            this.hasBackwardNavigation = true;
            this.mxmlContent = [this._ASKarten_CustomVScrollContainer1_i(), this._ASKarten_Footer1_i()];
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        internal function _ASKarten_Button1_i():feathers.controls.Button
        {
            var loc1:*=new feathers.controls.Button();
            loc1.addEventListener("touch", this.___ASKarten_Button1_touch);
            loc1.id = "_ASKarten_Button1";
            this._ASKarten_Button1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ASKarten_Button1", this._ASKarten_Button1);
            return loc1;
        }

        public function ___ASKarten_Button1_touch(arg1:starling.events.TouchEvent):void
        {
            this.saveButtonTouchHandler(arg1);
            return;
        }

        internal function _ASKarten_Footer1_i():frontend.screen.component.Footer
        {
            var loc1:*=new frontend.screen.component.Footer();
            loc1.id = "footer";
            this.footer = loc1;
            feathers.binding.BindingManager.executeBindings(this, "footer", this.footer);
            return loc1;
        }

        internal function _ASKarten_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("APPSETTINGS.KARTEN.TITLE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.title")
            result[1] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight;
            }, null, "_ASKarten_CustomVScrollContainer1.height")
            result[2] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_ASKarten_CustomVScrollContainer1.width")
            result[3] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_ASKarten_MenuList1.width")
            result[4] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=configCache.ConfigCacheAttributeNames.ENABLE_MAP_CACHING;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ASKarten_MenuListItem1.configCacheAttribute")
            result[5] = new feathers.binding.Binding(this, function ():Object
            {
                return true;
            }, null, "_ASKarten_MenuListItem1.defaultValue")
            result[6] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TOGGLE;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ASKarten_MenuListItem1.type")
            result[7] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_NUMBER;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ASKarten_MenuListItem2.type")
            result[8] = new feathers.binding.Binding(this, function ():Object
            {
                return _dirSizeLabel;
            }, null, "_ASKarten_MenuListItem2.value")
            result[9] = new feathers.binding.Binding(this, function ():Number
            {
                return GAP;
            }, null, "_ASKarten_VerticalLayout1.gap")
            result[10] = new feathers.binding.Binding(this, function ():Number
            {
                return GAP;
            }, null, "_ASKarten_VerticalLayout1.padding")
            result[11] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth - 2 * GAP;
            }, null, "_ASKarten_LangLabel1.width")
            result[12] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.layout.HorizontalAlign.CENTER;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ASKarten_Button1.horizontalAlign")
            result[13] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ASKARTEN.CLEARCHACHE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ASKarten_Button1.label")
            result[14] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.layout.VerticalAlign.MIDDLE;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ASKarten_Button1.verticalAlign")
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

        internal function get _dirSizeLabel():String
        {
            return this._226534587_dirSizeLabel;
        }

        internal function set _dirSizeLabel(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._226534587_dirSizeLabel;
            if (loc1 !== arg1) 
            {
                this._226534587_dirSizeLabel = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_dirSizeLabel", loc1, arg1, this);
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
            ASKarten._watcherSetupUtil = arg1;
            return;
        }

        protected override function validateProperties():void
        {
            var loc1:*=helper.File_helper.directorySize(frontend.components.map.MapLayerOptions.BASE_CACHE_DIRECTORY) / 1000000;
            this.updateDirSize(loc1);
            return;
        }

        internal function updateDirSize(arg1:Number):void
        {
            this._dirSizeLabel = (Math.round(arg1 * 100) / 100).toString() + " MB";
            return;
        }

        protected function saveButtonTouchHandler(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            helper.File_helper.deleteDirectory(frontend.components.map.MapLayerOptions.BASE_CACHE_DIRECTORY);
            this.updateDirSize(0);
            return;
        }

        internal function _ASKarten_CustomVScrollContainer1_i():frontend.components.scrollContainer.CustomVScrollContainer
        {
            var loc1:*=new frontend.components.scrollContainer.CustomVScrollContainer();
            loc1.mxmlContent = [this._ASKarten_MenuList1_i(), this._ASKarten_LayoutGroup1_c()];
            loc1.id = "_ASKarten_CustomVScrollContainer1";
            this._ASKarten_CustomVScrollContainer1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ASKarten_CustomVScrollContainer1", this._ASKarten_CustomVScrollContainer1);
            return loc1;
        }

        internal function _ASKarten_MenuList1_i():frontend.components.menuList.MenuList
        {
            var loc1:*=new frontend.components.menuList.MenuList();
            loc1.mxmlContent = [this._ASKarten_MenuListItem1_i(), this._ASKarten_MenuListItem2_i()];
            loc1.id = "_ASKarten_MenuList1";
            this._ASKarten_MenuList1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ASKarten_MenuList1", this._ASKarten_MenuList1);
            return loc1;
        }

        internal function _ASKarten_MenuListItem1_i():frontend.components.menuList.MenuListItem
        {
            var loc1:*=null;
            loc1 = new frontend.components.menuList.MenuListItem();
            loc1.editable = true;
            loc1.text = "ASKARTEN.ENABLECHACHING";
            loc1.useConfigCache = true;
            loc1.id = "_ASKarten_MenuListItem1";
            this._ASKarten_MenuListItem1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ASKarten_MenuListItem1", this._ASKarten_MenuListItem1);
            return loc1;
        }

        internal function _ASKarten_MenuListItem2_i():frontend.components.menuList.MenuListItem
        {
            var loc1:*=new frontend.components.menuList.MenuListItem();
            loc1.editable = false;
            loc1.text = "ASKARTEN.ACTUAL_CACHE_SIZE";
            loc1.id = "_ASKarten_MenuListItem2";
            this._ASKarten_MenuListItem2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ASKarten_MenuListItem2", this._ASKarten_MenuListItem2);
            return loc1;
        }

        internal function _ASKarten_LayoutGroup1_c():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._ASKarten_VerticalLayout1_i();
            loc1.mxmlContent = [this._ASKarten_LangLabel1_i(), this._ASKarten_Button1_i()];
            return loc1;
        }

        internal function _ASKarten_VerticalLayout1_i():feathers.layout.VerticalLayout
        {
            var loc1:*=new feathers.layout.VerticalLayout();
            loc1.horizontalAlign = "center";
            loc1.verticalAlign = "middle";
            this._ASKarten_VerticalLayout1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ASKarten_VerticalLayout1", this._ASKarten_VerticalLayout1);
            return loc1;
        }

        internal function _ASKarten_LangLabel1_i():frontend.components.LangLabel
        {
            var loc1:*=new frontend.components.LangLabel();
            loc1.height = 200;
            loc1.text = "ASKARTEN.DESCRIPTIONTEXT";
            loc1.wordWrap = true;
            loc1.id = "_ASKarten_LangLabel1";
            this._ASKarten_LangLabel1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ASKarten_LangLabel1", this._ASKarten_LangLabel1);
            return loc1;
        }

        internal static const GAP:Number=20 * SIGMALink.scaleFactor;

        public var _ASKarten_Button1:feathers.controls.Button;

        public var _ASKarten_CustomVScrollContainer1:frontend.components.scrollContainer.CustomVScrollContainer;

        public var _ASKarten_LangLabel1:frontend.components.LangLabel;

        public var _ASKarten_MenuList1:frontend.components.menuList.MenuList;

        public var _ASKarten_MenuListItem1:frontend.components.menuList.MenuListItem;

        public var _ASKarten_MenuListItem2:frontend.components.menuList.MenuListItem;

        public var _ASKarten_VerticalLayout1:feathers.layout.VerticalLayout;

        internal var _1268861541footer:frontend.screen.component.Footer;

        internal var _226534587_dirSizeLabel:String="";

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        mx_internal var _bindings:Array;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//  package konten
//    package facebook
//      class ASFacebook
package frontend.screen.appsettings.konten.facebook 
{
    import backend.oauth.*;
    import feathers.binding.*;
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
    import frontend.components.popup.oauth.*;
    import frontend.screen.appsettings.konten.*;
    import handler.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    import utils.*;
    
    use namespace mx_internal;
    
    public class ASFacebook extends frontend.screen.appsettings.konten.ASKontoSettings implements feathers.binding.IBindingClient
    {
        public function ASFacebook()
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
            bindings = this._ASFacebook_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_appsettings_konten_facebook_ASFacebookWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return ASFacebook[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        protected override function logout():void
        {
            backend.oauth.FacebookGoViralHandler.getInstance().logout();
            handler.ViewHandler.getInstance().goBack();
            return;
        }

        internal function _ASFacebook_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():frontend.components.popup.oauth.CustomOAuth
            {
                return backend.oauth.FacebookGoViralHandler.getInstance();
            }, null, "this.oauthInstance")
            result[1] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("APPSETTINGS.KONTEN.FACEBOOK.TITLE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.title")
            return result;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            ASFacebook._watcherSetupUtil = arg1;
            return;
        }

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//    package list
//      class AutoShareHeaderRenderer
package frontend.screen.appsettings.konten.list 
{
    import core.general.*;
    import feathers.controls.*;
    import feathers.controls.renderers.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import frontend.components.list.*;
    import frontend.components.menuList.*;
    import frontend.components.menuList.editors.base.*;
    import frontend.screen.appsettings.konten.*;
    import starling.display.*;
    import utils.*;
    
    public class AutoShareHeaderRenderer extends feathers.controls.renderers.DefaultGroupedListHeaderOrFooterRenderer implements feathers.controls.renderers.IGroupedListHeaderOrFooterRenderer
    {
        public function AutoShareHeaderRenderer()
        {
            super();
            height = frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
            styleProvider = null;
            padding = 0;
            backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            touchable = true;
            return;
        }

        protected override function itemToContent(arg1:Object):starling.display.DisplayObject
        {
            return null;
        }

        protected override function initialize():void
        {
            super.initialize();
            this._group = new feathers.controls.LayoutGroup();
            this._group.layout = new feathers.layout.AnchorLayout();
            this._group.width = SIGMALink.appWidth;
            this._group.height = frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
            addChild(this._group);
            this._name = new feathers.controls.Label();
            this._name.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_BIGLISTLABEL;
            this._name.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, customPadding, NaN, 0);
            this._group.addChild(this._name);
            this._check = new frontend.components.menuList.editors.base.OnOffToggleButton();
            this._check.layoutData = new feathers.layout.AnchorLayoutData(NaN, 0, NaN, NaN, NaN, 0);
            this._check.toggleChangedFunction = this.onToggleButtonChanged;
            this._group.addChild(this._check);
            this._check.validate();
            this._selectAllLabel = new feathers.controls.Label();
            this._selectAllLabel.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_BIGLISTLABEL;
            this._selectAllLabel.layoutData = new feathers.layout.AnchorLayoutData(NaN, this._check.width, NaN, NaN, NaN, 0);
            this._selectAllLabel.text = utils.LanguageManager.getString("SELECT_ALL_BUTTON_TEXT");
            this._group.addChild(this._selectAllLabel);
            return;
        }

        internal function onToggleButtonChanged(arg1:Boolean):void
        {
            var loc1:*=data as frontend.screen.appsettings.konten.list.AutoShareListGroupHeader;
            loc1.selected = arg1;
            frontend.screen.appsettings.konten.ASKontenSetting.validateChildSelection(owner as frontend.components.list.CustomGroupedList);
            return;
        }

        protected override function commitData():void
        {
            super.commitData();
            if (!data) 
            {
                return;
            }
            var loc1:*=data as frontend.screen.appsettings.konten.list.AutoShareListGroupHeader;
            if (!loc1) 
            {
                return;
            }
            this._name.text = loc1.name;
            this._check.checked = loc1.selected;
            return;
        }

        
        {
            customPadding = 20 * SIGMALink.scaleFactor;
        }

        internal var _check:frontend.components.menuList.editors.base.OnOffToggleButton;

        internal var _group:feathers.controls.LayoutGroup;

        internal var _name:feathers.controls.Label;

        internal var _selectAllLabel:feathers.controls.Label;

        internal static var customPadding:Number;
    }
}


//      class AutoShareListGroup
package frontend.screen.appsettings.konten.list 
{
    public class AutoShareListGroup extends Object
    {
        public function AutoShareListGroup()
        {
            this.children = new Array();
            super();
            return;
        }

        public function addItem(arg1:frontend.screen.appsettings.konten.list.AutoShareListItem):void
        {
            if (arg1) 
            {
                this.children.push(arg1);
            }
            return;
        }

        public var children:Array;

        public var header:frontend.screen.appsettings.konten.list.AutoShareListGroupHeader;
    }
}


//      class AutoShareListGroupHeader
package frontend.screen.appsettings.konten.list 
{
    public class AutoShareListGroupHeader extends Object
    {
        public function AutoShareListGroupHeader()
        {
            super();
            return;
        }

        public var name:String;

        public var selected:Boolean;
    }
}


//      class AutoShareListItem
package frontend.screen.appsettings.konten.list 
{
    import configCache.*;
    
    public class AutoShareListItem extends Object
    {
        public function AutoShareListItem()
        {
            super();
            return;
        }

        public function get selected():Boolean
        {
            if (this.key != "") 
            {
                return configCache.ConfigCache.getInstance().getValue(this.key, true);
            }
            return this._selected;
        }

        public function set selected(arg1:Boolean):void
        {
            if (this.key == "") 
            {
                this._selected = arg1;
            }
            else 
            {
                configCache.ConfigCache.getInstance().setValue(this.key, arg1);
            }
            return;
        }

        public var key:String="";

        public var label:String="";

        internal var _selected:Boolean=false;

        public var sportId:uint=0;

        public var userId:uint=0;
    }
}


//      class AutoShareListItemRenderer
package frontend.screen.appsettings.konten.list 
{
    import core.general.*;
    import feathers.controls.*;
    import feathers.controls.renderers.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import frontend.*;
    import frontend.components.*;
    import frontend.components.list.*;
    import frontend.components.menuList.*;
    import frontend.components.menuList.editors.base.*;
    import frontend.screen.appsettings.konten.*;
    import starling.display.*;
    
    public class AutoShareListItemRenderer extends feathers.controls.renderers.DefaultGroupedListItemRenderer
    {
        public function AutoShareListItemRenderer()
        {
            super();
            height = frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
            horizontalAlign = feathers.controls.renderers.DefaultListItemRenderer.HORIZONTAL_ALIGN_LEFT;
            verticalAlign = feathers.controls.renderers.DefaultListItemRenderer.VERTICAL_ALIGN_TOP;
            hasLabelTextRenderer = false;
            padding = 0;
            styleProvider = null;
            defaultSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            return;
        }

        protected function check_changeHandler(arg1:Boolean):void
        {
            var loc1:*=data as frontend.screen.appsettings.konten.list.AutoShareListItem;
            if (!loc1) 
            {
                return;
            }
            loc1.selected = arg1;
            frontend.screen.appsettings.konten.ASKontenSetting.validateHeaderGroupSelection(owner as frontend.components.list.CustomGroupedList);
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            this._group = new feathers.controls.LayoutGroup();
            this._group.width = SIGMALink.appWidth;
            this._group.height = frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
            this._group.layout = new feathers.layout.AnchorLayout();
            addChild(this._group);
            this._check = new frontend.components.menuList.editors.base.OnOffToggleButton();
            this._check.layoutData = new feathers.layout.AnchorLayoutData(NaN, 0, NaN, NaN, NaN, 0);
            this._check.toggleChangedFunction = this.check_changeHandler;
            this._group.addChild(this._check);
            this._sportIcon = new frontend.components.SportIcon();
            this._sportIcon.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, customPadding, NaN, 0);
            this._group.addChild(this._sportIcon);
            this._userIcon = new frontend.components.TextureImage();
            this._userIcon.textureName = frontend.Textures.profileicon;
            this._group.addChild(this._userIcon);
            this._userIcon.validate();
            this._userIcon.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, customPadding + (iconGroupWidth - this._userIcon.width) / 2, NaN, 0);
            this._labelData = new feathers.controls.Label();
            this._labelData.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUITEM;
            this._labelData.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, customPadding * 2 + iconGroupWidth, NaN, 0);
            this._group.addChild(this._labelData);
            var loc1:*=new starling.display.Quad(SIGMALink.appWidth, 1, core.general.Colors.LIGHTGREY);
            addChild(loc1);
            return;
        }

        protected override function commitData():void
        {
            super.commitData();
            if (!data) 
            {
                return;
            }
            var loc1:*=data as frontend.screen.appsettings.konten.list.AutoShareListItem;
            if (!loc1) 
            {
                return;
            }
            if (loc1.sportId == 0) 
            {
                this._userIcon.includeInLayout = loc2 = true;
                this._userIcon.visible = loc2;
                this._sportIcon.includeInLayout = loc2 = false;
                this._sportIcon.visible = loc2;
            }
            else 
            {
                var loc2:*;
                this._userIcon.includeInLayout = loc2 = false;
                this._userIcon.visible = loc2;
                this._sportIcon.includeInLayout = loc2 = true;
                this._sportIcon.visible = loc2;
                this._sportIcon.sportId = loc1.sportId;
            }
            this._labelData.text = loc1.label;
            this._check.checked = loc1.selected;
            return;
        }

        
        {
            checkBoxWidth = 50 * SIGMALink.scaleFactor;
            customPadding = 20 * SIGMALink.scaleFactor;
            iconGroupWidth = 70 * SIGMALink.scaleFactor;
            iconPaddingTop = 6 * SIGMALink.scaleFactor;
        }

        internal var _check:frontend.components.menuList.editors.base.OnOffToggleButton;

        internal var _group:feathers.controls.LayoutGroup;

        internal var _labelData:feathers.controls.Label;

        internal var _sportIcon:frontend.components.SportIcon;

        internal var _userIcon:frontend.components.TextureImage;

        internal static var checkBoxWidth:Number;

        internal static var customPadding:Number;

        internal static var iconGroupWidth:Number;

        internal static var iconPaddingTop:Number;
    }
}


//    package strava
//      class ASStrava
package frontend.screen.appsettings.konten.strava 
{
    import backend.oauth.*;
    import feathers.binding.*;
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
    import frontend.components.popup.oauth.*;
    import frontend.screen.appsettings.konten.*;
    import handler.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    import utils.*;
    
    use namespace mx_internal;
    
    public class ASStrava extends frontend.screen.appsettings.konten.ASKontoSettings implements feathers.binding.IBindingClient
    {
        public function ASStrava()
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
            bindings = this._ASStrava_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_appsettings_konten_strava_ASStravaWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return ASStrava[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        protected override function logout():void
        {
            backend.oauth.StravaOAuth.getInstance().logout();
            handler.ViewHandler.getInstance().goBack();
            return;
        }

        internal function _ASStrava_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():frontend.components.popup.oauth.CustomOAuth
            {
                return backend.oauth.StravaOAuth.getInstance();
            }, null, "this.oauthInstance")
            result[1] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("APPSETTINGS.KONTEN.STRAVA.TITLE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.title")
            return result;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            ASStrava._watcherSetupUtil = arg1;
            return;
        }

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//    package trainingpeaks
//      class ASTrainingPeaks
package frontend.screen.appsettings.konten.trainingpeaks 
{
    import backend.oauth.*;
    import feathers.binding.*;
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
    import frontend.components.popup.oauth.*;
    import frontend.screen.appsettings.konten.*;
    import handler.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    import utils.*;
    
    use namespace mx_internal;
    
    public class ASTrainingPeaks extends frontend.screen.appsettings.konten.ASKontoSettings implements feathers.binding.IBindingClient
    {
        public function ASTrainingPeaks()
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
            bindings = this._ASTrainingPeaks_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_appsettings_konten_trainingpeaks_ASTrainingPeaksWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return ASTrainingPeaks[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        protected override function logout():void
        {
            backend.oauth.TrainingPeaksOAuth.getInstance().logout();
            handler.ViewHandler.getInstance().goBack();
            return;
        }

        internal function _ASTrainingPeaks_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():frontend.components.popup.oauth.CustomOAuth
            {
                return backend.oauth.TrainingPeaksOAuth.getInstance();
            }, null, "this.oauthInstance")
            result[1] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("APPSETTINGS.KONTEN.TRAININGPEAKS.TITLE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.title")
            return result;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            ASTrainingPeaks._watcherSetupUtil = arg1;
            return;
        }

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//    package twitter
//      class ASTwitter
package frontend.screen.appsettings.konten.twitter 
{
    import backend.oauth.*;
    import feathers.binding.*;
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
    import frontend.components.popup.oauth.*;
    import frontend.screen.appsettings.konten.*;
    import handler.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    import utils.*;
    
    use namespace mx_internal;
    
    public class ASTwitter extends frontend.screen.appsettings.konten.ASKontoSettings implements feathers.binding.IBindingClient
    {
        public function ASTwitter()
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
            bindings = this._ASTwitter_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_appsettings_konten_twitter_ASTwitterWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return ASTwitter[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        protected override function logout():void
        {
            backend.oauth.TwitterOAuth.getInstance().logout();
            handler.ViewHandler.getInstance().goBack();
            return;
        }

        internal function _ASTwitter_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():frontend.components.popup.oauth.CustomOAuth
            {
                return backend.oauth.TwitterOAuth.getInstance();
            }, null, "this.oauthInstance")
            result[1] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("APPSETTINGS.KONTEN.TWITTER.TITLE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.title")
            return result;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            ASTwitter._watcherSetupUtil = arg1;
            return;
        }

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//    package twopeak
//      class ASTwoPeak
package frontend.screen.appsettings.konten.twopeak 
{
    import backend.oauth.*;
    import feathers.binding.*;
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
    import frontend.components.popup.oauth.*;
    import frontend.screen.appsettings.konten.*;
    import handler.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    import utils.*;
    
    use namespace mx_internal;
    
    public class ASTwoPeak extends frontend.screen.appsettings.konten.ASKontoSettings implements feathers.binding.IBindingClient
    {
        public function ASTwoPeak()
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
            bindings = this._ASTwoPeak_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_appsettings_konten_twopeak_ASTwoPeakWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return ASTwoPeak[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        protected override function logout():void
        {
            backend.oauth.TwoPeakOAuth.getInstance().logout();
            handler.ViewHandler.getInstance().goBack();
            return;
        }

        internal function _ASTwoPeak_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():frontend.components.popup.oauth.CustomOAuth
            {
                return backend.oauth.TwoPeakOAuth.getInstance();
            }, null, "this.oauthInstance")
            result[1] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("APPSETTINGS.KONTEN.TWOPEAK.TITLE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.title")
            return result;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            ASTwoPeak._watcherSetupUtil = arg1;
            return;
        }

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//    class ASKonten
package frontend.screen.appsettings.konten 
{
    import backend.oauth.*;
    import feathers.binding.*;
    import feathers.events.*;
    import flash.accessibility.*;
    import flash.data.*;
    import flash.debugger.*;
    import flash.desktop.*;
    import flash.errors.*;
    import flash.events.*;
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
    import frontend.components.popup.oauth.*;
    import frontend.components.scrollContainer.*;
    import frontend.screen.component.*;
    import handler.*;
    import mx.core.*;
    import service.oauth.*;
    import starling.animation.*;
    import starling.core.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    import utils.*;
    
    use namespace mx_internal;
    
    public class ASKonten extends frontend.screen.component.CustomScreen implements feathers.binding.IBindingClient
    {
        public function ASKonten()
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
            bindings = this._ASKonten_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_appsettings_konten_ASKontenWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return frontend.screen.appsettings.konten.ASKonten[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.allowCaching = true;
            this.hasBackwardNavigation = true;
            this.mxmlContent = [this._ASKonten_CustomVScrollContainer1_i(), this._ASKonten_Footer1_i()];
            this.addEventListener("initialize", this.___ASKonten_CustomScreen1_initialize);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        public function get trainingPeaksBtn():frontend.components.menuList.MenuListItem
        {
            return this._1566496446trainingPeaksBtn;
        }

        public function set trainingPeaksBtn(arg1:frontend.components.menuList.MenuListItem):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1566496446trainingPeaksBtn;
            if (loc1 !== arg1) 
            {
                this._1566496446trainingPeaksBtn = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "trainingPeaksBtn", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get twitterBtn():frontend.components.menuList.MenuListItem
        {
            return this._59022615twitterBtn;
        }

        public function set twitterBtn(arg1:frontend.components.menuList.MenuListItem):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._59022615twitterBtn;
            if (loc1 !== arg1) 
            {
                this._59022615twitterBtn = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "twitterBtn", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get twoPeakBtn():frontend.components.menuList.MenuListItem
        {
            return this._510796527twoPeakBtn;
        }

        public function __facebookBtn_touch(arg1:starling.events.TouchEvent):void
        {
            onTouch(arg1);
            return;
        }

        internal function get _destinationObject():Object
        {
            return this._1994196370_destinationObject;
        }

        internal function set _destinationObject(arg1:Object):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1994196370_destinationObject;
            if (loc1 !== arg1) 
            {
                this._1994196370_destinationObject = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_destinationObject", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function validateTexture(arg1:frontend.components.menuList.MenuListItem):void
        {
            var loc1:*=arg1.helperObject;
            switch (loc1) 
            {
                case backend.oauth.StravaOAuth.getInstance():
                {
                    arg1.iconTexture = backend.oauth.StravaOAuth.getInstance().loggedOut ? frontend.Textures.shareStravaGrey : frontend.Textures.shareStrava;
                    break;
                }
                case backend.oauth.TrainingPeaksOAuth.getInstance():
                {
                    arg1.iconTexture = backend.oauth.TrainingPeaksOAuth.getInstance().loggedOut ? frontend.Textures.shareTrainingPeaksGrey : frontend.Textures.shareTrainingPeaks;
                    break;
                }
                case backend.oauth.TwoPeakOAuth.getInstance():
                {
                    arg1.iconTexture = backend.oauth.TwoPeakOAuth.getInstance().loggedOut ? frontend.Textures.shareTwoPeakGrey : frontend.Textures.shareTwoPeak;
                    break;
                }
                case backend.oauth.FacebookGoViralHandler.getInstance():
                {
                    arg1.iconTexture = backend.oauth.FacebookGoViralHandler.getInstance().loggedOut ? frontend.Textures.shareFacebookGrey : frontend.Textures.shareFacebook;
                    break;
                }
                case backend.oauth.TwitterOAuth.getInstance():
                {
                    arg1.iconTexture = backend.oauth.TwitterOAuth.getInstance().loggedOut ? frontend.Textures.shareTwitterGrey : frontend.Textures.shareTwitter;
                    break;
                }
            }
            return;
        }

        public function set gotoActivityId(arg1:uint):void
        {
            this._gotoActivityId = arg1;
            this._destinationObject = {"gotoActivityId":this._gotoActivityId};
            return;
        }

        public static function onTouch(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            var loc1:*=arg1.currentTarget as frontend.components.menuList.MenuListItem;
            if (loc1.hasTouchEvents) 
            {
                return;
            }
            if (!handler.ConnectionHandler.checkNoInternetPopUp()) 
            {
                return;
            }
            (loc1.helperObject as frontend.components.popup.oauth.CustomOAuth).checkLogin(starling.core.Starling.current.nativeStage, true);
            return;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            frontend.screen.appsettings.konten.ASKonten._watcherSetupUtil = arg1;
            return;
        }

        internal function addEvents(arg1:service.oauth.CommonOAuth):void
        {
            arg1.addEventListener(service.oauth.CommonOAuth.LOGGED_OUT, this.onLoggedOut);
            arg1.addEventListener(service.oauth.CommonOAuth.LOGGED_IN, this.onLoggedIn);
            return;
        }

        internal function onLoggedIn(arg1:flash.events.Event):void
        {
            var loc1:*=this.resolveBtn(arg1.currentTarget as frontend.components.popup.oauth.CustomOAuth);
            validateTexture(loc1);
            loc1.hasTouchEvents = true;
            if (handler.ViewHandler.getInstance().isActive(this)) 
            {
                handler.ViewHandler.getInstance().showScreen(loc1.destination, this._destinationObject, handler.ViewHandler.slideToLeftTransition());
            }
            return;
        }

        internal function onLoggedOut(arg1:flash.events.Event):void
        {
            var loc1:*=this.resolveBtn(arg1.currentTarget as frontend.components.popup.oauth.CustomOAuth);
            validateTexture(loc1);
            loc1.hasTouchEvents = false;
            return;
        }

        internal function resolveBtn(arg1:frontend.components.popup.oauth.CustomOAuth):frontend.components.menuList.MenuListItem
        {
            var loc1:*=null;
            var loc2:*=arg1;
            switch (loc2) 
            {
                case backend.oauth.StravaOAuth.getInstance():
                {
                    loc1 = this.stravaBtn;
                    break;
                }
                case backend.oauth.TrainingPeaksOAuth.getInstance():
                {
                    loc1 = this.trainingPeaksBtn;
                    break;
                }
                case backend.oauth.TwoPeakOAuth.getInstance():
                {
                    loc1 = this.twoPeakBtn;
                    break;
                }
                case backend.oauth.FacebookGoViralHandler.getInstance():
                {
                    loc1 = this.facebookBtn;
                    break;
                }
                case backend.oauth.TwitterOAuth.getInstance():
                {
                    loc1 = this.twitterBtn;
                    break;
                }
            }
            return loc1;
        }

        internal function onInit():void
        {
            validateTexture(this.stravaBtn);
            validateTexture(this.trainingPeaksBtn);
            validateTexture(this.twoPeakBtn);
            validateTexture(this.facebookBtn);
            validateTexture(this.twitterBtn);
            this.addEvents(backend.oauth.StravaOAuth.getInstance());
            this.addEvents(backend.oauth.TrainingPeaksOAuth.getInstance());
            this.addEvents(backend.oauth.TwoPeakOAuth.getInstance());
            this.addEvents(backend.oauth.FacebookGoViralHandler.getInstance());
            this.addEvents(backend.oauth.TwitterOAuth.getInstance());
            return;
        }

        internal function _ASKonten_CustomVScrollContainer1_i():frontend.components.scrollContainer.CustomVScrollContainer
        {
            var loc1:*=new frontend.components.scrollContainer.CustomVScrollContainer();
            loc1.mxmlContent = [this._ASKonten_MenuList1_i()];
            loc1.id = "_ASKonten_CustomVScrollContainer1";
            this._ASKonten_CustomVScrollContainer1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ASKonten_CustomVScrollContainer1", this._ASKonten_CustomVScrollContainer1);
            return loc1;
        }

        internal function _ASKonten_MenuList1_i():frontend.components.menuList.MenuList
        {
            var loc1:*=new frontend.components.menuList.MenuList();
            loc1.mxmlContent = [this._ASKonten_MenuListItem1_i(), this._ASKonten_MenuListItem2_i(), this._ASKonten_MenuListItem3_i(), this._ASKonten_MenuListItem4_i(), this._ASKonten_MenuListItem5_i()];
            loc1.id = "_ASKonten_MenuList1";
            this._ASKonten_MenuList1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ASKonten_MenuList1", this._ASKonten_MenuList1);
            return loc1;
        }

        internal function _ASKonten_MenuListItem1_i():frontend.components.menuList.MenuListItem
        {
            var loc1:*=new frontend.components.menuList.MenuListItem();
            loc1.text = "APPSETTINGS.KONTEN.STRAVA.TITLE";
            loc1.addEventListener("touch", this.__stravaBtn_touch);
            loc1.id = "stravaBtn";
            this.stravaBtn = loc1;
            feathers.binding.BindingManager.executeBindings(this, "stravaBtn", this.stravaBtn);
            return loc1;
        }

        public function __stravaBtn_touch(arg1:starling.events.TouchEvent):void
        {
            onTouch(arg1);
            return;
        }

        internal function _ASKonten_MenuListItem2_i():frontend.components.menuList.MenuListItem
        {
            var loc1:*=new frontend.components.menuList.MenuListItem();
            loc1.text = "APPSETTINGS.KONTEN.TRAININGPEAKS.TITLE";
            loc1.addEventListener("touch", this.__trainingPeaksBtn_touch);
            loc1.id = "trainingPeaksBtn";
            this.trainingPeaksBtn = loc1;
            feathers.binding.BindingManager.executeBindings(this, "trainingPeaksBtn", this.trainingPeaksBtn);
            return loc1;
        }

        public function __trainingPeaksBtn_touch(arg1:starling.events.TouchEvent):void
        {
            onTouch(arg1);
            return;
        }

        internal function _ASKonten_MenuListItem3_i():frontend.components.menuList.MenuListItem
        {
            var loc1:*=new frontend.components.menuList.MenuListItem();
            loc1.text = "APPSETTINGS.KONTEN.TWOPEAK.TITLE";
            loc1.addEventListener("touch", this.__twoPeakBtn_touch);
            loc1.id = "twoPeakBtn";
            this.twoPeakBtn = loc1;
            feathers.binding.BindingManager.executeBindings(this, "twoPeakBtn", this.twoPeakBtn);
            return loc1;
        }

        public function __twoPeakBtn_touch(arg1:starling.events.TouchEvent):void
        {
            onTouch(arg1);
            return;
        }

        internal function _ASKonten_MenuListItem4_i():frontend.components.menuList.MenuListItem
        {
            var loc1:*=new frontend.components.menuList.MenuListItem();
            loc1.text = "APPSETTINGS.KONTEN.FACEBOOK.TITLE";
            loc1.addEventListener("touch", this.__facebookBtn_touch);
            loc1.id = "facebookBtn";
            this.facebookBtn = loc1;
            feathers.binding.BindingManager.executeBindings(this, "facebookBtn", this.facebookBtn);
            return loc1;
        }

        public function set twoPeakBtn(arg1:frontend.components.menuList.MenuListItem):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._510796527twoPeakBtn;
            if (loc1 !== arg1) 
            {
                this._510796527twoPeakBtn = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "twoPeakBtn", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function _ASKonten_MenuListItem5_i():frontend.components.menuList.MenuListItem
        {
            var loc1:*=new frontend.components.menuList.MenuListItem();
            loc1.text = "APPSETTINGS.KONTEN.TWITTER.TITLE";
            loc1.addEventListener("touch", this.__twitterBtn_touch);
            loc1.id = "twitterBtn";
            this.twitterBtn = loc1;
            feathers.binding.BindingManager.executeBindings(this, "twitterBtn", this.twitterBtn);
            return loc1;
        }

        public function __twitterBtn_touch(arg1:starling.events.TouchEvent):void
        {
            onTouch(arg1);
            return;
        }

        internal function _ASKonten_Footer1_i():frontend.screen.component.Footer
        {
            var loc1:*=new frontend.screen.component.Footer();
            loc1.id = "footer";
            this.footer = loc1;
            feathers.binding.BindingManager.executeBindings(this, "footer", this.footer);
            return loc1;
        }

        public function ___ASKonten_CustomScreen1_initialize(arg1:starling.events.Event):void
        {
            this.onInit();
            return;
        }

        internal function _ASKonten_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("APPSETTINGS.KONTEN.TITLE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.title")
            result[1] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight;
            }, null, "_ASKonten_CustomVScrollContainer1.height")
            result[2] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_ASKonten_CustomVScrollContainer1.width")
            result[3] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_ASKonten_MenuList1.width")
            result[4] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=handler.ViewHandler.VIEW_APPSETTINGS_KONTENT_STRAVA;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "stravaBtn.destination")
            result[5] = new feathers.binding.Binding(this, function ():Object
            {
                return _destinationObject;
            }, null, "stravaBtn.destinationObject")
            result[6] = new feathers.binding.Binding(this, function ():Boolean
            {
                return !backend.oauth.StravaOAuth.getInstance().loggedOut;
            }, null, "stravaBtn.hasTouchEvents")
            result[7] = new feathers.binding.Binding(this, function ():Object
            {
                return backend.oauth.StravaOAuth.getInstance();
            }, null, "stravaBtn.helperObject")
            result[8] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.components.menuList.MenuList.ROW_HEIGHT;
            }, null, "stravaBtn.minItemHeight")
            result[9] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SUBMENU;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "stravaBtn.type")
            result[10] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=handler.ViewHandler.VIEW_APPSETTINGS_KONTENT_TRAININGPEAKS;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "trainingPeaksBtn.destination")
            result[11] = new feathers.binding.Binding(this, function ():Object
            {
                return _destinationObject;
            }, null, "trainingPeaksBtn.destinationObject")
            result[12] = new feathers.binding.Binding(this, function ():Boolean
            {
                return !backend.oauth.TrainingPeaksOAuth.getInstance().loggedOut;
            }, null, "trainingPeaksBtn.hasTouchEvents")
            result[13] = new feathers.binding.Binding(this, function ():Object
            {
                return backend.oauth.TrainingPeaksOAuth.getInstance();
            }, null, "trainingPeaksBtn.helperObject")
            result[14] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.components.menuList.MenuList.ROW_HEIGHT;
            }, null, "trainingPeaksBtn.minItemHeight")
            result[15] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SUBMENU;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "trainingPeaksBtn.type")
            result[16] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=handler.ViewHandler.VIEW_APPSETTINGS_KONTENT_TWOPEAK;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "twoPeakBtn.destination")
            result[17] = new feathers.binding.Binding(this, function ():Object
            {
                return _destinationObject;
            }, null, "twoPeakBtn.destinationObject")
            result[18] = new feathers.binding.Binding(this, function ():Boolean
            {
                return !backend.oauth.TwoPeakOAuth.getInstance().loggedOut;
            }, null, "twoPeakBtn.hasTouchEvents")
            result[19] = new feathers.binding.Binding(this, function ():Object
            {
                return backend.oauth.TwoPeakOAuth.getInstance();
            }, null, "twoPeakBtn.helperObject")
            result[20] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.components.menuList.MenuList.ROW_HEIGHT;
            }, null, "twoPeakBtn.minItemHeight")
            result[21] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SUBMENU;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "twoPeakBtn.type")
            result[22] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=handler.ViewHandler.VIEW_APPSETTINGS_KONTENT_FACEBOOK;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "facebookBtn.destination")
            result[23] = new feathers.binding.Binding(this, function ():Object
            {
                return _destinationObject;
            }, null, "facebookBtn.destinationObject")
            result[24] = new feathers.binding.Binding(this, function ():Boolean
            {
                return !backend.oauth.FacebookGoViralHandler.getInstance().loggedOut;
            }, null, "facebookBtn.hasTouchEvents")
            result[25] = new feathers.binding.Binding(this, function ():Object
            {
                return backend.oauth.FacebookGoViralHandler.getInstance();
            }, null, "facebookBtn.helperObject")
            result[26] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.components.menuList.MenuList.ROW_HEIGHT;
            }, null, "facebookBtn.minItemHeight")
            result[27] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SUBMENU;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "facebookBtn.type")
            result[28] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=handler.ViewHandler.VIEW_APPSETTINGS_KONTENT_TWITTER;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "twitterBtn.destination")
            result[29] = new feathers.binding.Binding(this, function ():Object
            {
                return _destinationObject;
            }, null, "twitterBtn.destinationObject")
            result[30] = new feathers.binding.Binding(this, function ():Boolean
            {
                return !backend.oauth.TwitterOAuth.getInstance().loggedOut;
            }, null, "twitterBtn.hasTouchEvents")
            result[31] = new feathers.binding.Binding(this, function ():Object
            {
                return backend.oauth.TwitterOAuth.getInstance();
            }, null, "twitterBtn.helperObject")
            result[32] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.components.menuList.MenuList.ROW_HEIGHT;
            }, null, "twitterBtn.minItemHeight")
            result[33] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SUBMENU;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "twitterBtn.type")
            return result;
        }

        public function get facebookBtn():frontend.components.menuList.MenuListItem
        {
            return this._958082486facebookBtn;
        }

        public function set facebookBtn(arg1:frontend.components.menuList.MenuListItem):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._958082486facebookBtn;
            if (loc1 !== arg1) 
            {
                this._958082486facebookBtn = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "facebookBtn", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
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

        public function get stravaBtn():frontend.components.menuList.MenuListItem
        {
            return this._411132575stravaBtn;
        }

        public function set stravaBtn(arg1:frontend.components.menuList.MenuListItem):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._411132575stravaBtn;
            if (loc1 !== arg1) 
            {
                this._411132575stravaBtn = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "stravaBtn", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public var _ASKonten_CustomVScrollContainer1:frontend.components.scrollContainer.CustomVScrollContainer;

        public var _ASKonten_MenuList1:frontend.components.menuList.MenuList;

        internal var _958082486facebookBtn:frontend.components.menuList.MenuListItem;

        internal var _1268861541footer:frontend.screen.component.Footer;

        internal var _411132575stravaBtn:frontend.components.menuList.MenuListItem;

        internal var _59022615twitterBtn:frontend.components.menuList.MenuListItem;

        internal var _510796527twoPeakBtn:frontend.components.menuList.MenuListItem;

        internal var _gotoActivityId:uint=0;

        internal var _1994196370_destinationObject:Object;

        internal var _oldScreen:String;

        mx_internal var _bindingsBeginWithWord:Object;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        internal var _1566496446trainingPeaksBtn:frontend.components.menuList.MenuListItem;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//    class ASKontenSetting
package frontend.screen.appsettings.konten 
{
    import backend.utils.dbUtils.*;
    import configCache.*;
    import core.general.*;
    import core.sport.*;
    import core.user.*;
    import debug.*;
    import feathers.binding.*;
    import feathers.controls.*;
    import feathers.data.*;
    import feathers.events.*;
    import feathers.layout.*;
    import feathers.themes.*;
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
    import frontend.components.list.*;
    import frontend.components.menuList.*;
    import frontend.components.menuList.editors.base.*;
    import frontend.components.popup.oauth.*;
    import frontend.screen.appsettings.konten.list.*;
    import handler.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.core.*;
    import starling.display.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    import utils.*;
    
    use namespace mx_internal;
    
    public class ASKontenSetting extends feathers.controls.LayoutGroup implements feathers.binding.IBindingClient
    {
        public function ASKontenSetting()
        {
            var bindings:Array;
            var watchers:Array;
            var target:Object;
            var i:uint;
            var watcherSetupUtilClass:Object;

            var loc1:*;
            target = null;
            watcherSetupUtilClass = null;
            this._313456815_listLayoutData = new feathers.layout.VerticalLayoutData(100, 100);
            this.mx_internal::_bindings = [];
            this.mx_internal::_watchers = [];
            this.mx_internal::_bindingsByDestination = {};
            this.mx_internal::_bindingsBeginWithWord = {};
            super();
            bindings = this._ASKontenSetting_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_appsettings_konten_ASKontenSettingWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return frontend.screen.appsettings.konten.ASKontenSetting[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.mxmlContent = [this._ASKontenSetting_LayoutGroup2_i(), this._ASKontenSetting_CustomGroupedList1_i()];
            this.addEventListener("addedToStage", this.___ASKontenSetting_LayoutGroup1_addedToStage);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        public function set toggleLabel(arg1:feathers.controls.Label):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._663631872toggleLabel;
            if (loc1 !== arg1) 
            {
                this._663631872toggleLabel = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "toggleLabel", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function set oauthInstance(arg1:frontend.components.popup.oauth.CustomOAuth):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.oauthInstance;
            if (loc1 !== arg1) 
            {
                this._1940553804oauthInstance = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "oauthInstance", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _autoSharingEnabledProperty():String
        {
            return this._1524315112_autoSharingEnabledProperty;
        }

        internal function set _autoSharingEnabledProperty(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1524315112_autoSharingEnabledProperty;
            if (loc1 !== arg1) 
            {
                this._1524315112_autoSharingEnabledProperty = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_autoSharingEnabledProperty", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _listLayoutData():feathers.layout.VerticalLayoutData
        {
            return this._313456815_listLayoutData;
        }

        public function get oauthInstance():frontend.components.popup.oauth.CustomOAuth
        {
            return this._oauthInstance;
        }

        internal function set _1940553804oauthInstance(arg1:frontend.components.popup.oauth.CustomOAuth):void
        {
            this._oauthInstance = arg1;
            this._autoSharingEnabledProperty = this._oauthInstance.className + handler.SharingHandler.AUTO_SHARE_KEY + handler.SharingHandler.ENABLED_KEY;
            return;
        }

        internal function set _listLayoutData(arg1:feathers.layout.VerticalLayoutData):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._313456815_listLayoutData;
            if (loc1 !== arg1) 
            {
                this._313456815_listLayoutData = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_listLayoutData", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get listDataProvider():feathers.data.HierarchicalCollection
        {
            return this._1399580807listDataProvider;
        }

        internal function set listDataProvider(arg1:feathers.data.HierarchicalCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1399580807listDataProvider;
            if (loc1 !== arg1) 
            {
                this._1399580807listDataProvider = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "listDataProvider", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function validateHeaderGroupSelection(arg1:frontend.components.list.CustomGroupedList):void
        {
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=null;
            var loc8:*=0;
            loc6 = arg1.dataProvider;
            var loc7:*=loc6.getLength();
            loc1 = 0;
            while (loc1 < loc7) 
            {
                loc4 = loc6.getItemAt(loc1) as frontend.screen.appsettings.konten.list.AutoShareListGroup;
                loc3 = loc4.children.length;
                loc8 = 0;
                loc2 = 0;
                while (loc2 < loc3) 
                {
                    loc5 = loc4.children[loc2] as frontend.screen.appsettings.konten.list.AutoShareListItem;
                    if (loc5.selected) 
                    {
                        ++loc8;
                    }
                    ++loc2;
                }
                loc4.header.selected = loc8 > loc4.children.length / 2;
                loc6.updateItemAt(loc1);
                ++loc1;
            }
            return;
        }

        public static function validateChildSelection(arg1:frontend.components.list.CustomGroupedList):void
        {
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=null;
            var loc8:*=0;
            loc6 = arg1.dataProvider;
            var loc7:*=loc6.getLength();
            loc1 = 0;
            while (loc1 < loc7) 
            {
                loc4 = loc6.getItemAt(loc1) as frontend.screen.appsettings.konten.list.AutoShareListGroup;
                loc3 = loc4.children.length;
                loc8 = 0;
                loc2 = 0;
                while (loc2 < loc3) 
                {
                    loc5 = loc4.children[loc2] as frontend.screen.appsettings.konten.list.AutoShareListItem;
                    loc5.selected = loc4.header.selected;
                    ++loc2;
                }
                loc6.updateItemAt(loc1);
                ++loc1;
            }
            return;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            frontend.screen.appsettings.konten.ASKontenSetting._watcherSetupUtil = arg1;
            return;
        }

        internal function onAddedToStage():void
        {
            var loc1:*="select distinct sportId from Activity where isDeleted = false";
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, loc1, this.onSportIdsComplete, this.onSportIdsError, Workers.worker_DatabaseWorker);
            return;
        }

        internal function onSportIdsError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.debug("onSportIdsError");
            return;
        }

        internal function onSportIdsComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            this._sportIds = arg1.getResult();
            var loc1:*="select * from User";
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, loc1, this.onUserIdsComplete, this.onUserIdsError, Workers.worker_DatabaseWorker);
            return;
        }

        internal function onUserIdsError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.debug("onUserIdsError");
            return;
        }

        internal function onUserIdsComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            this._users = arg1.getResult();
            this.updateList();
            return;
        }

        internal function updateList():void
        {
            var loc1:*=0;
            var loc7:*=null;
            var loc8:*=null;
            var loc9:*=null;
            var loc10:*=null;
            this.listDataProvider = new feathers.data.HierarchicalCollection();
            var loc2:*=this._sportIds.length;
            var loc3:*=new frontend.screen.appsettings.konten.list.AutoShareListGroup();
            var loc4:*=new frontend.screen.appsettings.konten.list.AutoShareListGroupHeader();
            loc4.name = utils.LanguageManager.getString("APPSETTINGS.KONTEN.SPORT");
            loc3.header = loc4;
            loc1 = 0;
            while (loc1 < loc2) 
            {
                loc7 = handler.SportHandler.getInstance().resolveSportById(this._sportIds[loc1].sportId);
                loc8 = new frontend.screen.appsettings.konten.list.AutoShareListItem();
                loc8.sportId = loc7.sportId;
                loc8.key = this.oauthInstance.className + handler.SharingHandler.AUTO_SHARE_KEY + loc7.keyName;
                loc8.label = loc7.name;
                loc8.selected = configCache.ConfigCache.getInstance().getValue(loc8.key, true);
                loc3.addItem(loc8);
                ++loc1;
            }
            this.listDataProvider.addItemAt(loc3, (this.listDataProvider.data as Array).length);
            var loc5:*=new frontend.screen.appsettings.konten.list.AutoShareListGroup();
            var loc6:*=new frontend.screen.appsettings.konten.list.AutoShareListGroupHeader();
            loc6.name = utils.LanguageManager.getString("APPSETTINGS.KONTEN.USER");
            loc5.header = loc6;
            loc2 = this._users.length;
            loc1 = 0;
            while (loc1 < loc2) 
            {
                loc9 = new core.user.User();
                loc9.fromDB(this._users[loc1]);
                loc10 = new frontend.screen.appsettings.konten.list.AutoShareListItem();
                loc10.userId = loc9.userId;
                loc10.key = this.oauthInstance.className + handler.SharingHandler.AUTO_SHARE_KEY + "user" + loc9.userId;
                loc10.label = loc9.name;
                loc10.selected = configCache.ConfigCache.getInstance().getValue(loc10.key, true);
                loc5.addItem(loc10);
                ++loc1;
            }
            this.listDataProvider.addItemAt(loc5, (this.listDataProvider.data as Array).length);
            this.list.dataProvider = this.listDataProvider;
            validateHeaderGroupSelection(this.list);
            return;
        }

        internal function onToggleButtonComplete():void
        {
            this.toggleLabel.width = SIGMALink.appWidth - this.autoShareOption.width - PADDING;
            this.toggleList(this.autoShareOption.checked);
            return;
        }

        internal function onAutoShareOptionChange(arg1:Boolean):void
        {
            configCache.ConfigCache.getInstance().setValue(this._autoSharingEnabledProperty, arg1);
            this.toggleList(arg1);
            return;
        }

        internal function toggleList(arg1:Boolean):void
        {
            if (this.list == null) 
            {
                return;
            }
            var loc1:*=new starling.animation.Tween(this._listLayoutData, this.ANIMATION_DURATION, starling.animation.Transitions.EASE_IN);
            loc1.animate("percentHeight", arg1 ? 100 : 0);
            var loc2:*=new starling.animation.Tween(this.list, this.ANIMATION_DURATION, starling.animation.Transitions.EASE_OUT_IN_ELASTIC);
            loc2.fadeTo(arg1 ? 1 : 0);
            starling.core.Starling.juggler.add(loc1);
            starling.core.Starling.juggler.add(loc2);
            return;
        }

        internal function _ASKontenSetting_LayoutGroup2_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._ASKontenSetting_AnchorLayout1_c();
            loc1.mxmlContent = [this._ASKontenSetting_Label1_i(), this._ASKontenSetting_OnOffToggleButton1_i()];
            loc1.id = "_ASKontenSetting_LayoutGroup2";
            this._ASKontenSetting_LayoutGroup2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ASKontenSetting_LayoutGroup2", this._ASKontenSetting_LayoutGroup2);
            return loc1;
        }

        internal function _ASKontenSetting_AnchorLayout1_c():feathers.layout.AnchorLayout
        {
            var loc1:*=new feathers.layout.AnchorLayout();
            return loc1;
        }

        internal function _ASKontenSetting_Label1_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.wordWrap = true;
            loc1.id = "toggleLabel";
            this.toggleLabel = loc1;
            feathers.binding.BindingManager.executeBindings(this, "toggleLabel", this.toggleLabel);
            return loc1;
        }

        internal function _ASKontenSetting_OnOffToggleButton1_i():frontend.components.menuList.editors.base.OnOffToggleButton
        {
            var loc1:*=new frontend.components.menuList.editors.base.OnOffToggleButton();
            loc1.addEventListener("creationComplete", this.__autoShareOption_creationComplete);
            loc1.id = "autoShareOption";
            this.autoShareOption = loc1;
            feathers.binding.BindingManager.executeBindings(this, "autoShareOption", this.autoShareOption);
            return loc1;
        }

        public function __autoShareOption_creationComplete(arg1:starling.events.Event):void
        {
            this.onToggleButtonComplete();
            return;
        }

        internal function _ASKontenSetting_CustomGroupedList1_i():frontend.components.list.CustomGroupedList
        {
            var loc1:*=new frontend.components.list.CustomGroupedList();
            loc1.clipContent = true;
            loc1.stickyHeader = true;
            loc1.id = "list";
            this.list = loc1;
            feathers.binding.BindingManager.executeBindings(this, "list", this.list);
            return loc1;
        }

        public function ___ASKontenSetting_LayoutGroup1_addedToStage(arg1:starling.events.Event):void
        {
            this.onAddedToStage();
            return;
        }

        internal function _ASKontenSetting_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return new feathers.layout.VerticalLayout();
            }, null, "this.layout")
            result[1] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.VerticalLayoutData(100, 100);
            }, null, "this.layoutData")
            result[2] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            }, null, "_ASKontenSetting_LayoutGroup2.backgroundSkin")
            result[3] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.components.menuList.MenuList.ROW_HEIGHT;
            }, null, "_ASKontenSetting_LayoutGroup2.height")
            result[4] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(0);
            }, null, "_ASKontenSetting_LayoutGroup2.layoutData")
            result[5] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_ASKontenSetting_LayoutGroup2.width")
            result[6] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, PADDING, NaN, 0);
            }, null, "toggleLabel.layoutData")
            result[7] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUITEM;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "toggleLabel.styleName")
            result[8] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("APPSETTINGS.KONTEN.AUTO_SHARE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "toggleLabel.text")
            result[9] = new feathers.binding.Binding(this, function ():Boolean
            {
                return configCache.ConfigCache.getInstance().getValue(_autoSharingEnabledProperty, false);
            }, null, "autoShareOption.checked")
            result[10] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(NaN, 0, NaN, NaN, NaN, 0);
            }, null, "autoShareOption.layoutData")
            result[11] = new feathers.binding.Binding(this, function ():Function
            {
                return onAutoShareOptionChange;
            }, null, "autoShareOption.toggleChangedFunction")
            result[12] = new feathers.binding.Binding(this, function ():Class
            {
                return frontend.screen.appsettings.konten.list.AutoShareHeaderRenderer;
            }, null, "list.headerRendererType")
            result[13] = new feathers.binding.Binding(this, function ():Boolean
            {
                return autoShareOption.checked;
            }, null, "list.isEnabled")
            result[14] = new feathers.binding.Binding(this, function ():Class
            {
                return frontend.screen.appsettings.konten.list.AutoShareListItemRenderer;
            }, null, "list.itemRendererType")
            result[15] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return _listLayoutData;
            }, null, "list.layoutData")
            result[16] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "list.width")
            return result;
        }

        public function get autoShareOption():frontend.components.menuList.editors.base.OnOffToggleButton
        {
            return this._270194693autoShareOption;
        }

        public function set autoShareOption(arg1:frontend.components.menuList.editors.base.OnOffToggleButton):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._270194693autoShareOption;
            if (loc1 !== arg1) 
            {
                this._270194693autoShareOption = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "autoShareOption", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get list():frontend.components.list.CustomGroupedList
        {
            return this._3322014list;
        }

        public function set list(arg1:frontend.components.list.CustomGroupedList):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._3322014list;
            if (loc1 !== arg1) 
            {
                this._3322014list = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "list", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get toggleLabel():feathers.controls.Label
        {
            return this._663631872toggleLabel;
        }

        internal const ANIMATION_DURATION:Number=0.3;

        internal static const PADDING:Number=20 * SIGMALink.scaleFactor;

        public var _ASKontenSetting_LayoutGroup2:feathers.controls.LayoutGroup;

        internal var _270194693autoShareOption:frontend.components.menuList.editors.base.OnOffToggleButton;

        internal var _3322014list:frontend.components.list.CustomGroupedList;

        internal var _663631872toggleLabel:feathers.controls.Label;

        internal var _oauthInstance:frontend.components.popup.oauth.CustomOAuth;

        internal var _1524315112_autoSharingEnabledProperty:String="";

        internal var _313456815_listLayoutData:feathers.layout.VerticalLayoutData;

        internal var _sportIds:Array;

        internal var _users:Array;

        internal var _1399580807listDataProvider:feathers.data.HierarchicalCollection;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//    class ASKontoSettings
package frontend.screen.appsettings.konten 
{
    import debug.*;
    import feathers.binding.*;
    import feathers.controls.*;
    import feathers.events.*;
    import feathers.layout.*;
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
    import frontend.components.button.*;
    import frontend.components.popup.oauth.*;
    import frontend.components.scrollContainer.*;
    import frontend.screen.component.*;
    import handler.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    import utils.*;
    
    use namespace mx_internal;
    
    public class ASKontoSettings extends frontend.screen.component.CustomScreen implements feathers.binding.IBindingClient
    {
        public function ASKontoSettings()
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
            bindings = this._ASKontoSettings_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_appsettings_konten_ASKontoSettingsWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return ASKontoSettings[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.allowCaching = true;
            this.hasBackwardNavigation = true;
            this.mxmlContent = [this._ASKontoSettings_CustomVScrollContainer1_i(), this._ASKontoSettings_Footer1_i()];
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        internal function _ASKontoSettings_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight;
            }, null, "_ASKontoSettings_CustomVScrollContainer1.height")
            result[1] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_ASKontoSettings_CustomVScrollContainer1.width")
            result[2] = new feathers.binding.Binding(this, null, null, "_ASKontoSettings_ASKontenSetting1.oauthInstance", "oauthInstance");
            result[3] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_ASKontoSettings_ASKontenSetting1.width")
            result[4] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_ASKontoSettings_LayoutGroup1.width")
            result[5] = new feathers.binding.Binding(this, function ():Number
            {
                return GAP;
            }, null, "_ASKontoSettings_VerticalLayout1.gap")
            result[6] = new feathers.binding.Binding(this, function ():Number
            {
                return GAP;
            }, null, "_ASKontoSettings_VerticalLayout1.padding")
            result[7] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.layout.HorizontalAlign.CENTER;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ASKontoSettings_Button1.horizontalAlign")
            result[8] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("APPSETTINGS.KONTEN.LOGOUT");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ASKontoSettings_Button1.label")
            result[9] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.layout.VerticalAlign.MIDDLE;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ASKontoSettings_Button1.verticalAlign")
            result[10] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.arrowRight;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "nextButton.image")
            result[11] = new feathers.binding.Binding(this, function ():Boolean
            {
                return _showNextButton;
            }, null, "nextButton.includeInLayout")
            result[12] = new feathers.binding.Binding(this, function ():Boolean
            {
                return _showNextButton;
            }, null, "nextButton.visible")
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

        public function get nextButton():frontend.components.button.IconButton
        {
            return this._1749722107nextButton;
        }

        public function set nextButton(arg1:frontend.components.button.IconButton):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1749722107nextButton;
            if (loc1 !== arg1) 
            {
                this._1749722107nextButton = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "nextButton", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get oauthInstance():frontend.components.popup.oauth.CustomOAuth
        {
            return this._1940553804oauthInstance;
        }

        public function set oauthInstance(arg1:frontend.components.popup.oauth.CustomOAuth):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1940553804oauthInstance;
            if (loc1 !== arg1) 
            {
                this._1940553804oauthInstance = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "oauthInstance", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _showNextButton():Boolean
        {
            return this._1327868161_showNextButton;
        }

        public function set gotoActivityId(arg1:uint):void
        {
            this._gotoActivityId = arg1;
            this._showNextButton = this._gotoActivityId > 0;
            return;
        }

        internal function set _showNextButton(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1327868161_showNextButton;
            if (loc1 !== arg1) 
            {
                this._1327868161_showNextButton = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_showNextButton", loc1, arg1, this);
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
            ASKontoSettings._watcherSetupUtil = arg1;
            return;
        }

        internal function logoutTouchHandler(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            this.logout();
            return;
        }

        protected function logout():void
        {
            debug.Debug.warning("please override");
            handler.ViewHandler.getInstance().goBack();
            return;
        }

        internal function gotoActivity(arg1:starling.events.TouchEvent):void
        {
            if (this._gotoActivityId == 0) 
            {
                return;
            }
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_SHARE_ACTIVITY, {"activityId":this._gotoActivityId, "comesFromSharingOptions":true}, handler.ViewHandler.slideToLeftTransition());
            return;
        }

        internal function _ASKontoSettings_CustomVScrollContainer1_i():frontend.components.scrollContainer.CustomVScrollContainer
        {
            var loc1:*=new frontend.components.scrollContainer.CustomVScrollContainer();
            loc1.mxmlContent = [this._ASKontoSettings_ASKontenSetting1_i(), this._ASKontoSettings_LayoutGroup1_i()];
            loc1.id = "_ASKontoSettings_CustomVScrollContainer1";
            this._ASKontoSettings_CustomVScrollContainer1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ASKontoSettings_CustomVScrollContainer1", this._ASKontoSettings_CustomVScrollContainer1);
            return loc1;
        }

        internal function _ASKontoSettings_ASKontenSetting1_i():frontend.screen.appsettings.konten.ASKontenSetting
        {
            var loc1:*=new frontend.screen.appsettings.konten.ASKontenSetting();
            loc1.id = "_ASKontoSettings_ASKontenSetting1";
            this._ASKontoSettings_ASKontenSetting1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ASKontoSettings_ASKontenSetting1", this._ASKontoSettings_ASKontenSetting1);
            return loc1;
        }

        internal function _ASKontoSettings_LayoutGroup1_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._ASKontoSettings_VerticalLayout1_i();
            loc1.mxmlContent = [this._ASKontoSettings_Button1_i()];
            loc1.id = "_ASKontoSettings_LayoutGroup1";
            this._ASKontoSettings_LayoutGroup1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ASKontoSettings_LayoutGroup1", this._ASKontoSettings_LayoutGroup1);
            return loc1;
        }

        internal function _ASKontoSettings_VerticalLayout1_i():feathers.layout.VerticalLayout
        {
            var loc1:*=new feathers.layout.VerticalLayout();
            loc1.horizontalAlign = "center";
            loc1.verticalAlign = "middle";
            this._ASKontoSettings_VerticalLayout1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ASKontoSettings_VerticalLayout1", this._ASKontoSettings_VerticalLayout1);
            return loc1;
        }

        internal function _ASKontoSettings_Button1_i():feathers.controls.Button
        {
            var loc1:*=new feathers.controls.Button();
            loc1.addEventListener("touch", this.___ASKontoSettings_Button1_touch);
            loc1.id = "_ASKontoSettings_Button1";
            this._ASKontoSettings_Button1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ASKontoSettings_Button1", this._ASKontoSettings_Button1);
            return loc1;
        }

        public function ___ASKontoSettings_Button1_touch(arg1:starling.events.TouchEvent):void
        {
            this.logoutTouchHandler(arg1);
            return;
        }

        internal function _ASKontoSettings_Footer1_i():frontend.screen.component.Footer
        {
            var loc1:*=new frontend.screen.component.Footer();
            loc1.forceRightButton = true;
            loc1.mxmlContent = [this._ASKontoSettings_IconButton1_i()];
            loc1.id = "footer";
            this.footer = loc1;
            feathers.binding.BindingManager.executeBindings(this, "footer", this.footer);
            return loc1;
        }

        internal function _ASKontoSettings_IconButton1_i():frontend.components.button.IconButton
        {
            var loc1:*=new frontend.components.button.IconButton();
            loc1.touchHandler = this.gotoActivity;
            loc1.id = "nextButton";
            this.nextButton = loc1;
            feathers.binding.BindingManager.executeBindings(this, "nextButton", this.nextButton);
            return loc1;
        }

        internal static const GAP:Number=20 * SIGMALink.scaleFactor;

        public var _ASKontoSettings_ASKontenSetting1:frontend.screen.appsettings.konten.ASKontenSetting;

        public var _ASKontoSettings_Button1:feathers.controls.Button;

        public var _ASKontoSettings_CustomVScrollContainer1:frontend.components.scrollContainer.CustomVScrollContainer;

        public var _ASKontoSettings_LayoutGroup1:feathers.controls.LayoutGroup;

        public var _ASKontoSettings_VerticalLayout1:feathers.layout.VerticalLayout;

        internal var _1268861541footer:frontend.screen.component.Footer;

        internal var _1749722107nextButton:frontend.components.button.IconButton;

        internal var _gotoActivityId:uint=0;

        internal var _1940553804oauthInstance:frontend.components.popup.oauth.CustomOAuth;

        internal var _1327868161_showNextButton:Boolean=false;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        mx_internal var _bindings:Array;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//  package mobilesnetz
//    class ASMobilesNetz
package frontend.screen.appsettings.mobilesnetz 
{
    import configCache.*;
    import feathers.binding.*;
    import feathers.controls.*;
    import feathers.events.*;
    import feathers.layout.*;
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
    import frontend.components.menuList.*;
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
    
    public class ASMobilesNetz extends frontend.screen.component.CustomScreen implements feathers.binding.IBindingClient
    {
        public function ASMobilesNetz()
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
            bindings = this._ASMobilesNetz_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_appsettings_mobilesnetz_ASMobilesNetzWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return ASMobilesNetz[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.allowCaching = true;
            this.hasBackwardNavigation = true;
            this.mxmlContent = [this._ASMobilesNetz_Footer1_i()];
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        protected override function addContent():void
        {
            var loc1:*=null;
            super.addContent();
            loc1 = new frontend.components.menuList.MenuListItem();
            loc1.configCacheAttribute = configCache.ConfigCacheAttributeNames.AUTOMATIC_DATA_TRANSMISSION;
            loc1.editable = true;
            loc1.text = "ASMOBILESNETZ.AUTODATATRANSMISSION";
            loc1.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TOGGLE;
            loc1.useConfigCache = true;
            loc1.width = SIGMALink.appWidth;
            addChild(loc1);
            loc1.validate();
            var loc2:*=new feathers.controls.Label();
            loc2.text = utils.LanguageManager.getString("ASMOBILESNETZ.DESCRIPTIONTEXT");
            loc2.width = SIGMALink.appWidth;
            loc2.wordWrap = true;
            loc2.layoutData = new feathers.layout.AnchorLayoutData(loc1.height + GAP, GAP, NaN, GAP);
            addChild(loc2);
            return;
        }

        internal function _ASMobilesNetz_Footer1_i():frontend.screen.component.Footer
        {
            var loc1:*=new frontend.screen.component.Footer();
            loc1.id = "footer";
            this.footer = loc1;
            feathers.binding.BindingManager.executeBindings(this, "footer", this.footer);
            return loc1;
        }

        internal function _ASMobilesNetz_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("APPSETTINGS.MOBILESNETZ.TITLE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.title")
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
            ASMobilesNetz._watcherSetupUtil = arg1;
            return;
        }

        internal static const GAP:Number=20 * SIGMALink.scaleFactor;

        internal var _1268861541footer:frontend.screen.component.Footer;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//  class AppSettings
package frontend.screen.appsettings 
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
    import frontend.*;
    import frontend.components.menuList.*;
    import frontend.components.scrollContainer.*;
    import frontend.screen.component.*;
    import handler.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    import utils.*;
    
    use namespace mx_internal;
    
    public class AppSettings extends frontend.screen.component.CustomScreen implements feathers.binding.IBindingClient
    {
        public function AppSettings()
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
            bindings = this._AppSettings_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_appsettings_AppSettingsWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return AppSettings[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.hasBackwardNavigation = true;
            this.mxmlContent = [this._AppSettings_CustomVScrollContainer1_i(), this._AppSettings_Footer1_i()];
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        internal function _AppSettings_CustomVScrollContainer1_i():frontend.components.scrollContainer.CustomVScrollContainer
        {
            var loc1:*=new frontend.components.scrollContainer.CustomVScrollContainer();
            loc1.mxmlContent = [this._AppSettings_MenuList1_i()];
            loc1.id = "_AppSettings_CustomVScrollContainer1";
            this._AppSettings_CustomVScrollContainer1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_AppSettings_CustomVScrollContainer1", this._AppSettings_CustomVScrollContainer1);
            return loc1;
        }

        internal function _AppSettings_MenuList1_i():frontend.components.menuList.MenuList
        {
            var loc1:*=new frontend.components.menuList.MenuList();
            loc1.mxmlContent = [this._AppSettings_MenuListItem1_i(), this._AppSettings_MenuListItem2_i(), this._AppSettings_MenuListItem3_i(), this._AppSettings_MenuListItem4_i(), this._AppSettings_MenuListItem5_i(), this._AppSettings_MenuListItem6_i()];
            loc1.id = "_AppSettings_MenuList1";
            this._AppSettings_MenuList1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_AppSettings_MenuList1", this._AppSettings_MenuList1);
            return loc1;
        }

        internal function _AppSettings_MenuListItem1_i():frontend.components.menuList.MenuListItem
        {
            var loc1:*=new frontend.components.menuList.MenuListItem();
            loc1.text = "APPSETTINGS.ALLGEMEIN";
            loc1.id = "_AppSettings_MenuListItem1";
            this._AppSettings_MenuListItem1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_AppSettings_MenuListItem1", this._AppSettings_MenuListItem1);
            return loc1;
        }

        internal function _AppSettings_MenuListItem2_i():frontend.components.menuList.MenuListItem
        {
            var loc1:*=new frontend.components.menuList.MenuListItem();
            loc1.text = "APPSETTINGS.BENUTZER";
            loc1.id = "_AppSettings_MenuListItem2";
            this._AppSettings_MenuListItem2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_AppSettings_MenuListItem2", this._AppSettings_MenuListItem2);
            return loc1;
        }

        internal function _AppSettings_MenuListItem3_i():frontend.components.menuList.MenuListItem
        {
            var loc1:*=new frontend.components.menuList.MenuListItem();
            loc1.text = "APPSETTINGS.CLOUD";
            loc1.id = "_AppSettings_MenuListItem3";
            this._AppSettings_MenuListItem3 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_AppSettings_MenuListItem3", this._AppSettings_MenuListItem3);
            return loc1;
        }

        internal function _AppSettings_MenuListItem4_i():frontend.components.menuList.MenuListItem
        {
            var loc1:*=new frontend.components.menuList.MenuListItem();
            loc1.text = "APPSETTINGS.KONTEN";
            loc1.id = "_AppSettings_MenuListItem4";
            this._AppSettings_MenuListItem4 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_AppSettings_MenuListItem4", this._AppSettings_MenuListItem4);
            return loc1;
        }

        internal function _AppSettings_MenuListItem5_i():frontend.components.menuList.MenuListItem
        {
            var loc1:*=new frontend.components.menuList.MenuListItem();
            loc1.text = "APPSETTINGS.MOBILESNETZ";
            loc1.id = "_AppSettings_MenuListItem5";
            this._AppSettings_MenuListItem5 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_AppSettings_MenuListItem5", this._AppSettings_MenuListItem5);
            return loc1;
        }

        internal function _AppSettings_MenuListItem6_i():frontend.components.menuList.MenuListItem
        {
            var loc1:*=new frontend.components.menuList.MenuListItem();
            loc1.text = "APPSETTINGS.KARTEN";
            loc1.id = "_AppSettings_MenuListItem6";
            this._AppSettings_MenuListItem6 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_AppSettings_MenuListItem6", this._AppSettings_MenuListItem6);
            return loc1;
        }

        internal function _AppSettings_Footer1_i():frontend.screen.component.Footer
        {
            var loc1:*=new frontend.screen.component.Footer();
            loc1.id = "footer";
            this.footer = loc1;
            feathers.binding.BindingManager.executeBindings(this, "footer", this.footer);
            return loc1;
        }

        internal function _AppSettings_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("APPSETTINGS.TITLE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.title")
            result[1] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight;
            }, null, "_AppSettings_CustomVScrollContainer1.height")
            result[2] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_AppSettings_CustomVScrollContainer1.width")
            result[3] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_AppSettings_MenuList1.width")
            result[4] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=handler.ViewHandler.VIEW_APPSETTINGS_ALLGEMEIN;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_AppSettings_MenuListItem1.destination")
            result[5] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.settingsiconred;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_AppSettings_MenuListItem1.iconTexture")
            result[6] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.components.menuList.MenuList.ROW_HEIGHT;
            }, null, "_AppSettings_MenuListItem1.minItemHeight")
            result[7] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SUBMENU;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_AppSettings_MenuListItem1.type")
            result[8] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=handler.ViewHandler.VIEW_APPSETTINGS_BENUTZER;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_AppSettings_MenuListItem2.destination")
            result[9] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.profileiconred;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_AppSettings_MenuListItem2.iconTexture")
            result[10] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.components.menuList.MenuList.ROW_HEIGHT;
            }, null, "_AppSettings_MenuListItem2.minItemHeight")
            result[11] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SUBMENU;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_AppSettings_MenuListItem2.type")
            result[12] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=handler.ViewHandler.VIEW_APPSETTINGS_CLOUD;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_AppSettings_MenuListItem3.destination")
            result[13] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.cloudiconred;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_AppSettings_MenuListItem3.iconTexture")
            result[14] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.components.menuList.MenuList.ROW_HEIGHT;
            }, null, "_AppSettings_MenuListItem3.minItemHeight")
            result[15] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SUBMENU;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_AppSettings_MenuListItem3.type")
            result[16] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=handler.ViewHandler.VIEW_APPSETTINGS_KONTEN;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_AppSettings_MenuListItem4.destination")
            result[17] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.shareiconred;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_AppSettings_MenuListItem4.iconTexture")
            result[18] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.components.menuList.MenuList.ROW_HEIGHT;
            }, null, "_AppSettings_MenuListItem4.minItemHeight")
            result[19] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SUBMENU;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_AppSettings_MenuListItem4.type")
            result[20] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=handler.ViewHandler.VIEW_APPSETTINGS_MOBILESNETZ;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_AppSettings_MenuListItem5.destination")
            result[21] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.networkiconred;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_AppSettings_MenuListItem5.iconTexture")
            result[22] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.components.menuList.MenuList.ROW_HEIGHT;
            }, null, "_AppSettings_MenuListItem5.minItemHeight")
            result[23] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SUBMENU;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_AppSettings_MenuListItem5.type")
            result[24] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=handler.ViewHandler.VIEW_APPSETTINGS_KARTEN;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_AppSettings_MenuListItem6.destination")
            result[25] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.mapsred;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_AppSettings_MenuListItem6.iconTexture")
            result[26] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.components.menuList.MenuList.ROW_HEIGHT;
            }, null, "_AppSettings_MenuListItem6.minItemHeight")
            result[27] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SUBMENU;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_AppSettings_MenuListItem6.type")
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
            AppSettings._watcherSetupUtil = arg1;
            return;
        }

        public var _AppSettings_CustomVScrollContainer1:frontend.components.scrollContainer.CustomVScrollContainer;

        public var _AppSettings_MenuList1:frontend.components.menuList.MenuList;

        public var _AppSettings_MenuListItem1:frontend.components.menuList.MenuListItem;

        public var _AppSettings_MenuListItem2:frontend.components.menuList.MenuListItem;

        public var _AppSettings_MenuListItem3:frontend.components.menuList.MenuListItem;

        public var _AppSettings_MenuListItem4:frontend.components.menuList.MenuListItem;

        public var _AppSettings_MenuListItem5:frontend.components.menuList.MenuListItem;

        public var _AppSettings_MenuListItem6:frontend.components.menuList.MenuListItem;

        internal var _1268861541footer:frontend.screen.component.Footer;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


