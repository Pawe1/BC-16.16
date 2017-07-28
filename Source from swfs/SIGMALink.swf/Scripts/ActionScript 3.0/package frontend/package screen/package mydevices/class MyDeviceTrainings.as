//class MyDeviceTrainings
package frontend.screen.mydevices 
{
    import __AS3__.vec.*;
    import backend.utils.dbUtils.*;
    import configCache.*;
    import core.training.*;
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
    
    public class MyDeviceTrainings extends frontend.screen.mydevices.CustomEditListScreen implements feathers.binding.IBindingClient
    {
        public function MyDeviceTrainings()
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
            bindings = this._MyDeviceTrainings_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_mydevices_MyDeviceTrainingsWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return MyDeviceTrainings[arg1];
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

        protected override function loadData():void
        {
            handler.AppDeviceHandler.getInstance().loadTrainings(new backend.utils.dbUtils.DBUtilObject(unit, loadDataComplete, loadDataError, Workers.worker_DatabaseWorker), _currentSortField, _currentAscending);
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
                loc3 = _dataProvider.data[loc1] as frontend.screen.mydevices.list.MyDeviceTrainingsListItem;
                if (loc3 && loc3.isSelected()) 
                {
                    backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.UPDATE, core.training.TrainingMapper.prepareDelete(loc3.training.GUID), this.onDeleteComplete, onDeleteError, Workers.worker_DatabaseWorker, loc3);
                }
                ++loc1;
            }
            super.onPopUpDelete();
            return;
        }

        protected override function onDeleteComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            ((arg1.data as backend.utils.dbUtils.DBUtilObject).data as frontend.screen.mydevices.list.MyDeviceTrainingsListItem).removeSelection();
            super.onDeleteComplete(arg1);
            return;
        }

        protected override function prepareCompletedData():void
        {
            this.handleNextTraining();
            return;
        }

        protected override function backButtonFunction():void
        {
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_DEVICE_VIEW, {"unit":unit}, handler.ViewHandler.slideToRightTransition());
            return;
        }

        internal function handleNextTraining():void
        {
            var item:frontend.screen.mydevices.list.MyDeviceTrainingsListItem;
            var stmt:String;
            var onLoadTrainingError:Function;
            var onLoadTrainingPhaseComplete:Function;

            var loc1:*;
            item = null;
            stmt = null;
            if (_currentData.length > 0) 
            {
                onLoadTrainingError = function (arg1:backend.utils.dbUtils.DBUtilEvent):void
                {
                    handleNextTraining();
                    return;
                }
                onLoadTrainingPhaseComplete = function (arg1:backend.utils.dbUtils.DBUtilEvent):void
                {
                    handler.AppDeviceHandler.getInstance().loadTrainingPhaseComplete(arg1.getResult(), item.training);
                    item.training.estimatedDuration = 0;
                    item.training.recalcEstimatedValue();
                    _dataProvider.push(item);
                    handleNextTraining();
                    return;
                }
                item = new frontend.screen.mydevices.list.MyDeviceTrainingsListItem();
                core.training.TrainingMapper.fromDB(item.training, _currentData.shift());
                stmt = handler.AppDeviceHandler.getInstance().generateLoadTrainingPhase(item.training.trainingId);
                backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, stmt, onLoadTrainingPhaseComplete, onLoadTrainingError);
            }
            return;
        }

        protected override function itemRenderer():feathers.controls.renderers.IListItemRenderer
        {
            var loc1:*=new frontend.screen.mydevices.list.MyDeviceTrainingsRenderer();
            loc1.callBackFunction = this.uploadItemClickCallback;
            return loc1;
        }

        internal function uploadItemClickCallback(arg1:frontend.screen.mydevices.list.MyDeviceTrainingsListItem):void
        {
            arg1.training.unit = unit;
            handler.ViewHandler.getInstance().showScreen(transferScreen, {"unit":unit, "training":arg1.training, "transferModeDownload":false, "backScreenName":handler.ViewHandler.VIEW_DEVICE_SETTINGS}, handler.ViewHandler.slideToLeftTransition());
            return;
        }

        protected override function triggeredHandler(arg1:starling.events.Event):void
        {
            if (listLoader.listStateHandler.editState) 
            {
                return;
            }
            if (!(arg1.data is frontend.screen.mydevices.list.MyDeviceTrainingsListItem)) 
            {
                debug.Debug.error("p_event.data is not a MyDeviceSettingsListItem");
                return;
            }
            (arg1.data as frontend.screen.mydevices.list.MyDeviceTrainingsListItem).training.unit = unit;
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_DEVICE_TRAINING_PROGRAM_DETAIL, {"training":(arg1.data as frontend.screen.mydevices.list.MyDeviceTrainingsListItem).training}, handler.ViewHandler.slideToLeftTransition());
            return;
        }

        protected override function initializeSortfields():void
        {
            _sortFields = new Vector.<frontend.components.list.ListSortItem>();
            _sortFields.push(new frontend.components.list.ListSortItem(utils.LanguageManager.getString("SORT_POPUP.NAME"), "name", true));
            _sortFields.push(new frontend.components.list.ListSortItem(utils.LanguageManager.getString("SORT_POPUP.MODIFICATION_DATE"), "modificationDate", true));
            return;
        }

        internal function _MyDeviceTrainings_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=configCache.ConfigCacheObject.DEVICE_TRAININGS_SORT_ASCENDING;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.configCacheSortAscending")
            result[1] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=configCache.ConfigCacheObject.DEVICE_TRAININGS_SORT_FIELD;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.configCacheSortField")
            result[2] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("DELETE_POPUP.DELETE_TRAINING_TEXT");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.deletePopUpText")
            result[3] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("DELETE_POPUP.DELETE_TRAINING_TITLE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.deletePopUpTitle")
            result[4] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("NO_DATA_TRAININGS");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.noDataText")
            result[5] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("DEVICEVIEW.TRAINING_PROGRAM");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.title")
            result[6] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=handler.ViewHandler.VIEW_DEVICE_TRAININGS_TRANSFER;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.transferScreen")
            return result;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            MyDeviceTrainings._watcherSetupUtil = arg1;
            return;
        }

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


