//class MyDeviceSettings
package frontend.screen.mydevices 
{
    import __AS3__.vec.*;
    import backend.utils.*;
    import backend.utils.dbUtils.*;
    import configCache.*;
    import core.settings.*;
    import debug.*;
    import feathers.binding.*;
    import feathers.controls.renderers.*;
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
    import frontend.screen.mydevices.list.*;
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
    
    public class MyDeviceSettings extends frontend.screen.mydevices.CustomEditListScreen implements feathers.binding.IBindingClient
    {
        public function MyDeviceSettings()
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
            bindings = this._MyDeviceSettings_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_mydevices_MyDeviceSettingsWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return MyDeviceSettings[arg1];
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

        protected override function prepareCompletedData():void
        {
            var loc1:*=0;
            var loc3:*=null;
            var loc4:*=null;
            var loc2:*=_currentData.length;
            loc1 = 0;
            while (loc1 < loc2) 
            {
                loc3 = core.settings.SettingsFactory.createSettingsFromUnitType(unit.type);
                core.settings.SettingsMapper.fromDB(loc3, _currentData[loc1]);
                loc4 = new frontend.screen.mydevices.list.MyDeviceSettingsListItem();
                loc4.setting = loc3;
                loc4.GUID = loc3.GUID;
                loc4.name = loc3.name;
                loc4.lastChanges = backend.utils.DataUtils.dateFormatter.format(loc3.modificationDate);
                _dataProvider.push(loc4);
                ++loc1;
            }
            return;
        }

        protected override function backButtonFunction():void
        {
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_DEVICE_VIEW, {"unit":unit}, handler.ViewHandler.slideToRightTransition());
            return;
        }

        protected override function itemRenderer():feathers.controls.renderers.IListItemRenderer
        {
            var loc1:*=new frontend.screen.mydevices.list.MyDeviceSettingsRenderer();
            loc1.callBackFunction = this.uploadItemClickCallback;
            return loc1;
        }

        internal function uploadItemClickCallback(arg1:frontend.screen.mydevices.list.MyDeviceSettingsListItem):void
        {
            if (listLoader.listStateHandler.editState) 
            {
                return;
            }
            arg1.setting.unit = unit;
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_DEVICE_SETTINGS_TRANSFER, {"unit":unit, "settings":arg1.setting, "transferModeDownload":false, "backScreenName":handler.ViewHandler.VIEW_DEVICE_SETTINGS}, handler.ViewHandler.slideToLeftTransition());
            return;
        }

        protected override function triggeredHandler(arg1:starling.events.Event):void
        {
            if (listLoader.listStateHandler.editState) 
            {
                return;
            }
            if (!(arg1.data is frontend.screen.mydevices.list.MyDeviceSettingsListItem)) 
            {
                debug.Debug.error("p_event.data is not a MyDeviceSettingsListItem");
                return;
            }
            (arg1.data as frontend.screen.mydevices.list.MyDeviceSettingsListItem).setting.unit = unit;
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_DEVICE_SETTING, {"settings":(arg1.data as frontend.screen.mydevices.list.MyDeviceSettingsListItem).setting, "unit":unit}, handler.ViewHandler.slideToLeftTransition());
            return;
        }

        protected override function loadData():void
        {
            handler.AppDeviceHandler.getInstance().loadSettings(new backend.utils.dbUtils.DBUtilObject(unit, loadDataComplete, loadDataError, Workers.worker_DatabaseWorker), _currentSortField, _currentAscending);
            return;
        }

        protected override function onPopUpDelete():void
        {
            var loc1:*=0;
            var loc3:*=null;
            var loc2:*=_dataProvider.length;
            loc1 = 0;
            while (loc1 < loc2) 
            {
                loc3 = _dataProvider.data[loc1] as frontend.screen.mydevices.list.MyDeviceSettingsListItem;
                if (loc3 && loc3.isSelected()) 
                {
                    backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.UPDATE, core.settings.SettingsMapper.prepareDelete(loc3.setting.GUID), this.onDeleteComplete, onDeleteError, Workers.worker_DatabaseWorker, loc3);
                }
                ++loc1;
            }
            super.onPopUpDelete();
            return;
        }

        protected override function onDeleteComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            ((arg1.data as backend.utils.dbUtils.DBUtilObject).data as frontend.screen.mydevices.list.MyDeviceSettingsListItem).removeSelection();
            super.onDeleteComplete(arg1);
            return;
        }

        protected override function initializeSortfields():void
        {
            _sortFields = new Vector.<frontend.components.list.ListSortItem>();
            _sortFields.push(new frontend.components.list.ListSortItem(utils.LanguageManager.getString("SORT_POPUP.NAME"), "name", true));
            _sortFields.push(new frontend.components.list.ListSortItem(utils.LanguageManager.getString("SORT_POPUP.MODIFICATION_DATE"), "modificationDate", true));
            return;
        }

        internal function _MyDeviceSettings_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=configCache.ConfigCacheObject.DEVICE_SETTINGS_SORT_ASCENDING;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.configCacheSortAscending")
            result[1] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=configCache.ConfigCacheObject.DEVICE_SETTINGS_SORT_FIELD;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.configCacheSortField")
            result[2] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("DELETE_POPUP.DELETE_SETTINGS_TEXT");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.deletePopUpText")
            result[3] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("DELETE_POPUP.DELETE_SETTINGS_TITLE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.deletePopUpTitle")
            result[4] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("NO_DATA_SETTINGS");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.noDataText")
            result[5] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("DEVICEVIEW.DEVICE_SETTINGS");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.title")
            result[6] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=handler.ViewHandler.VIEW_DEVICE_SETTINGS_TRANSFER;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.transferScreen")
            return result;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            MyDeviceSettings._watcherSetupUtil = arg1;
            return;
        }

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


