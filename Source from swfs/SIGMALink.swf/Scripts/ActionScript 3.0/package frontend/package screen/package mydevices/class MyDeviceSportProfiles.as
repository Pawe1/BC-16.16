//class MyDeviceSportProfiles
package frontend.screen.mydevices 
{
    import __AS3__.vec.*;
    import backend.utils.dbUtils.*;
    import configCache.*;
    import core.sportprofiles.*;
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
    
    public class MyDeviceSportProfiles extends frontend.screen.mydevices.CustomEditListScreen implements feathers.binding.IBindingClient
    {
        public function MyDeviceSportProfiles()
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
            bindings = this._MyDeviceSportProfiles_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_mydevices_MyDeviceSportProfilesWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return MyDeviceSportProfiles[arg1];
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

        protected override function addedToStageHandler(arg1:starling.events.Event):void
        {
            super.addedToStageHandler(arg1);
            return;
        }

        protected override function prepareCompletedData():void
        {
            var loc1:*=0;
            var loc3:*=null;
            var loc2:*=_currentData.length;
            loc1 = 0;
            while (loc1 < loc2) 
            {
                loc3 = new frontend.screen.mydevices.list.MyDeviceSportprofilesListItem();
                loc3.sportprofile = core.sportprofiles.SportprofileMapper.fromDB(_currentData[loc1], null, unit);
                _dataProvider.push(loc3);
                ++loc1;
            }
            return;
        }

        protected override function itemRenderer():feathers.controls.renderers.IListItemRenderer
        {
            var loc1:*=new frontend.screen.mydevices.list.MyDeviceSportprofilesRenderer();
            loc1.callBackFunction = this.uploadItemClickCallback;
            return loc1;
        }

        protected override function backButtonFunction():void
        {
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_DEVICE_VIEW, {"unit":unit}, handler.ViewHandler.slideToRightTransition());
            return;
        }

        internal function uploadItemClickCallback(arg1:frontend.screen.mydevices.list.MyDeviceSportprofilesListItem):void
        {
            if (listLoader.listStateHandler.editState) 
            {
                return;
            }
            arg1.sportprofile.unit = unit;
            handler.ViewHandler.getInstance().showScreen(transferScreen, {"unit":unit, "sportprofile":arg1.sportprofile, "transferModeDownload":false, "backScreenName":handler.ViewHandler.VIEW_DEVICE_SPORT_PROFILES}, handler.ViewHandler.slideToLeftTransition());
            return;
        }

        protected override function loadData():void
        {
            handler.AppDeviceHandler.getInstance().loadSportprofiles(new backend.utils.dbUtils.DBUtilObject(unit, loadDataComplete, loadDataError, Workers.worker_DatabaseWorker), _currentSortField, _currentAscending);
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
                loc3 = _dataProvider.data[loc1] as frontend.screen.mydevices.list.MyDeviceSportprofilesListItem;
                if (loc3 && loc3.isSelected()) 
                {
                    backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.UPDATE, core.sportprofiles.SportprofileMapper.prepareDelete(loc3.sportprofile.GUID), this.onDeleteComplete, onDeleteError, Workers.worker_DatabaseWorker, loc3);
                }
                ++loc1;
            }
            super.onPopUpDelete();
            return;
        }

        protected override function onDeleteComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            ((arg1.data as backend.utils.dbUtils.DBUtilObject).data as frontend.screen.mydevices.list.MyDeviceSportprofilesListItem).removeSelection();
            super.onDeleteComplete(arg1);
            return;
        }

        protected override function triggeredHandler(arg1:starling.events.Event):void
        {
            if (listLoader.listStateHandler.editState) 
            {
                return;
            }
            if (arg1.data is frontend.screen.mydevices.list.MyDeviceSportprofilesListItem) 
            {
                handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_DEVICE_SPORT_PROFILE, {"sportprofile":(arg1.data as frontend.screen.mydevices.list.MyDeviceSportprofilesListItem).sportprofile}, handler.ViewHandler.slideToLeftTransition());
            }
            return;
        }

        protected override function initializeSortfields():void
        {
            _sortFields = new Vector.<frontend.components.list.ListSortItem>();
            _sortFields.push(new frontend.components.list.ListSortItem(utils.LanguageManager.getString("DEVICE_SPORTPROFILES_SORT_NAME"), core.sportprofiles.SportprofileMapper.col_profileName, true));
            _sortFields.push(new frontend.components.list.ListSortItem(utils.LanguageManager.getString("DEVICE_SPORTPROFILES_SORT_MODIFICATION_DATE"), core.sportprofiles.SportprofileMapper.col_modificationDate, true));
            return;
        }

        internal function _MyDeviceSportProfiles_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=configCache.ConfigCacheObject.DEVICE_SPORTPROFILES_SORT_ASCENDING;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.configCacheSortAscending")
            result[1] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=configCache.ConfigCacheObject.DEVICE_SPORTPROFILES_SORT_FIELD;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.configCacheSortField")
            result[2] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("DELETE_POPUP.DELETE_SPORTPROFILE_TEXT");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.deletePopUpText")
            result[3] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("DELETE_POPUP.DELETE_SPORTPROFILE_TITLE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.deletePopUpTitle")
            result[4] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("NO_DATA_SPORTPROFILES");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.noDataText")
            result[5] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("DEVICEVIEW.DEVICE_SPORT_PROFILES");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.title")
            result[6] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=handler.ViewHandler.VIEW_DEVICE_SPORT_PROFILES_TRANSFER;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.transferScreen")
            return result;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            MyDeviceSportProfiles._watcherSetupUtil = arg1;
            return;
        }

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


