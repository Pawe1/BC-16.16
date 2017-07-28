//class ActivitiesTransfer
package frontend.screen.mydevices.transfer 
{
    import __AS3__.vec.*;
    import backend.events.*;
    import backend.utils.dbUtils.*;
    import core.activities.*;
    import core.units.interfaces.*;
    import debug.*;
    import feathers.binding.*;
    import feathers.data.*;
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
    import frontend.components.popup.*;
    import frontend.screen.activities.list.*;
    import frontend.screen.component.*;
    import frontend.screen.component.devices.*;
    import handler.*;
    import mx.core.*;
    import service.cloud.*;
    import starling.animation.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    import utils.*;
    
    use namespace mx_internal;
    
    public class ActivitiesTransfer extends frontend.screen.mydevices.transfer.TransferScreen implements feathers.binding.IBindingClient
    {
        public function ActivitiesTransfer()
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
            bindings = this._ActivitiesTransfer_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_mydevices_transfer_ActivitiesTransferWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return ActivitiesTransfer[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.allowCaching = false;
            this.hasBackwardNavigation = true;
            this.saveAsOldScreen = false;
            this.mxmlContent = [this._ActivitiesTransfer_CommunicationState1_i(), this._ActivitiesTransfer_Footer1_i()];
            this.addEventListener("addedToStage", this.___ActivitiesTransfer_TransferScreen1_addedToStage);
            this.addEventListener("removedFromStage", this.___ActivitiesTransfer_TransferScreen1_removedFromStage);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        protected override function onDeviceChanged(arg1:starling.events.Event=null):void
        {
            super.onDeviceChanged(arg1);
            this.comState.showUnitState(handler.CommunicationHandling.getInstance().currentDevice);
            return;
        }

        protected override function transferFunction():void
        {
            var loc1:*=0;
            var loc2:*=null;
            var loc3:*=0;
            super.transferFunction();
            this.comState.openProgressPopUp(utils.LanguageManager.getString("PROGRESS_POPUP.LOAD_ACTIVITIES_TITLE"), utils.LanguageManager.getString("PROGRESS_POPUP.LOAD_ACTIVITIES_TEXT"));
            if (this.loadHeader) 
            {
                this.loadedData = null;
                if (handler.CommunicationHandling.getInstance().currentDevice is core.units.interfaces.ILogList) 
                {
                    this.comState.closeProgressOn100Percent = false;
                    handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.addEventListener(handler.UnitHandler.PAGE_HEADER_CHANGE, this.onPageHeaderLoadedComplete);
                    handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.loadFromDC(handler.UnitHandler.LOAD_UNIT_LOG_DATA_HEADER_FROM_DEVICE);
                }
                else 
                {
                    handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.addEventListener(handler.UnitHandler.MEMORIES_LOADED_FROM_UNIT_COMPLETE, this.onPageHeaderLoadedComplete);
                    handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.loadFromDC(handler.UnitHandler.LOAD_UNIT_TRIP_DATA_FROM_DEVICE);
                }
            }
            else 
            {
                this._activitiesSelected = new flash.utils.Dictionary();
                this.comState.closeProgressOn100Percent = false;
                if (unit is core.units.interfaces.IDataToDecode) 
                {
                    loc2 = (unit as core.units.interfaces.IDataToDecode).activitiesToDecode;
                    handler.CommunicationHandling.getInstance().currentDevice;
                }
                else if (unit is core.units.interfaces.ILogList) 
                {
                    loc2 = (unit as core.units.interfaces.ILogList).loadedLogs;
                }
                loc3 = loc2.length;
                loc1 = 0;
                while (loc1 < loc3) 
                {
                    this._activitiesSelected[loc2[loc1].GUID] = true;
                    ++loc1;
                }
                handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler = handler.HandlerFactory.getImplementation(handler.CommunicationHandling.getInstance().currentDevice) as handler.UnitHandler;
                if (handler.DeviceCommunicationHandlerLink.getInstance().currentDSHandler) 
                {
                    handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.port = handler.DeviceCommunicationHandlerLink.getInstance().currentDSHandler.port;
                }
                handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.addEventListener(handler.UnitHandler.LOGS_LOADED_FROM_UNIT_COMPLETE, this.onActivitiesLoadedComplete);
                handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.loadFromDC(handler.UnitHandler.LOAD_UNIT_LOG_DATA_FROM_DEVICE);
            }
            return;
        }

        internal function onPageHeaderLoadedComplete(arg1:flash.events.Event):void
        {
            this.comState.closeProgressPopUp();
            var loc1:*=0;
            if (handler.CommunicationHandling.getInstance().currentDevice is core.units.interfaces.ILogList) 
            {
                this.loadedData = (handler.CommunicationHandling.getInstance().currentDevice as core.units.interfaces.ILogList).loadedLogs;
                loc1 = this.loadedData.length;
                (arg1.currentTarget as handler.UnitHandler).removeEventListener(handler.UnitHandler.PAGE_HEADER_CHANGE, this.onPageHeaderLoadedComplete);
            }
            else 
            {
                this.loadedData = handler.CommunicationHandling.getInstance().currentDevice.loadedMemories;
                loc1 = this.loadedData.length;
                (arg1.currentTarget as handler.UnitHandler).removeEventListener(handler.UnitHandler.MEMORIES_LOADED_FROM_UNIT_COMPLETE, this.onPageHeaderLoadedComplete);
            }
            handler.CommunicationHandling.getInstance().stopCommunication();
            if (loc1 != 0) 
            {
                handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_ACTIVITIES_SELECTOR, {"backScreenName":backScreenName, "loadedData":this.loadedData, "unit":unit}, handler.ViewHandler.slideToLeftTransition());
            }
            else 
            {
                noDataOnDeviceInfo();
            }
            return;
        }

        internal function onActivitiesLoadedComplete(arg1:flash.events.Event):void
        {
            handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.removeEventListener(handler.UnitHandler.LOGS_LOADED_FROM_UNIT_COMPLETE, this.onActivitiesLoadedComplete);
            this.loadedData = null;
            this.comState.updateProgressPopUp(0, utils.LanguageManager.getString("PROGRESS_POPUP.SAVE_ACTIVITIES_TITLE"), utils.LanguageManager.getString("PROGRESS_POPUP.SAVE_ACTIVITIES_TEXT"));
            this.comState.onProgressPopUpClosed = this.onProgressComplete;
            flash.utils.setTimeout(this.saveNow, 500);
            return;
        }

        internal function saveNow():void
        {
            var loc1:*=0;
            debug.Debug.debug("onDataDecoded");
            var loc2:*=(handler.CommunicationHandling.getInstance().currentDevice as core.units.interfaces.ILogList).loadedLogs;
            var loc3:*=loc2.length;
            this._activitiesToSave = new Vector.<backend.utils.dbUtils.DBUtilObject>();
            loc1 = 0;
            while (loc1 < loc3) 
            {
                if (this._activitiesSelected[loc2[loc1].GUID]) 
                {
                    loc2[loc1].isDeleted = false;
                    loc2[loc1].modificationDate = new Date().time;
                    this._activitiesToSave.push(new backend.utils.dbUtils.DBUtilObject(loc2[loc1], this.onSaveActivityComplete, this.onSaveActivityError, null, true));
                }
                ++loc1;
            }
            this._activitiesToSaveCount = this._activitiesToSave.length;
            handler.CommunicationHandling.getInstance().stopCommunication();
            this.saveNextActivity();
            return;
        }

        protected function onAddedToStage(arg1:starling.events.Event):void
        {
            this.comState.loading = true;
            this.comState.unitChangeable = false;
            setCallbacks(this.comState);
            if (unit) 
            {
                init();
            }
            else 
            {
                handler.CommunicationHandling.getInstance().loadSavedDevices(this.onDevicesLoaded);
            }
            return;
        }

        protected function onRemovedFromStage(arg1:starling.events.Event):void
        {
            destroy();
            if (!this.loadHeader || !(handler.CommunicationHandling.getInstance().currentDevice is core.units.interfaces.ILogList)) 
            {
                handler.CommunicationHandling.getInstance().stopCommunication();
            }
            return;
        }

        protected override function validateProperties():void
        {
            title = utils.LanguageManager.getString("ACTIVITIES.IMPORT_TITLE");
            this.comState.headline = title;
            return;
        }

        internal function onDevicesLoaded():void
        {
            var loc1:*=handler.CommunicationHandling.getInstance().currentDevices.length;
            if (loc1 != 0) 
            {
                if (handler.CommunicationHandling.getInstance().currentDevice) 
                {
                    unit = handler.CommunicationHandling.getInstance().currentDevice;
                }
                else 
                {
                    unit = handler.CommunicationHandling.getInstance().getSelectedDeviceFromCache();
                }
                init();
            }
            else if (!handler.AppDBHandler.getInstance().initialAppStart) 
            {
                this._addDeviceTimeoutId = flash.utils.setTimeout(handler.ViewHandler.getInstance().showScreen, 1000, handler.ViewHandler.VIEW_ADD_DEVICE_POSSIBLE_DEVICES, null, handler.ViewHandler.slideToLeftTransition());
            }
            this.comState.unitChangeable = loc1 > 1;
            if (this.comState.unitChangeable) 
            {
                addUnitChangeEventListener();
            }
            return;
        }

        internal function onProgressComplete():void
        {
            var loc1:*=new frontend.screen.activities.list.ActivityListEvent(frontend.screen.activities.list.ActivityListEvent.RELOAD);
            loc1.resetLastScrollPosition = true;
            handler.ActivityHandler.getInstance().dispatchEvent(loc1);
            handler.ActivityHandler.getInstance().dispatchEvent(new service.cloud.CloudEvent(service.cloud.CloudEvent.DATA_CHANGED));
            if (this._activitiesToSaveCount == 1 && !(this._actualActivity == null)) 
            {
                handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_ACTIVITY, {"activity":this._actualActivity}, handler.ViewHandler.slideToLeftTransition());
            }
            else 
            {
                handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_ACTIVITIES_LIST, null, handler.ViewHandler.slideToLeftTransition());
            }
            return;
        }

        internal function saveNextActivity():void
        {
            if (this._activitiesToSave.length == 0) 
            {
                this.comState.closeProgressPopUp();
                return;
            }
            this._actualActivity = null;
            var loc1:*=this._activitiesToSave.shift();
            if (loc1.data is core.activities.Activity) 
            {
                this._actualActivity = loc1.data as core.activities.Activity;
            }
            handler.ActivityHandler.getInstance().saveActivity(loc1);
            return;
        }

        internal function onSaveActivityComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            var loc1:*=100 / this._activitiesToSaveCount * (this._activitiesToSaveCount - this._activitiesToSave.length);
            this.comState.updateProgressPopUp(loc1);
            var loc2:*=new backend.events.UnitDataEvent(backend.events.UnitDataEvent.SHARING_DATA_ADDED, arg1.data.data);
            handler.ActivityHandler.getInstance().dispatchEvent(loc2);
            flash.utils.setTimeout(this.saveNextActivity, 100);
            return;
        }

        internal function onSaveActivityError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("onSaveActivityError");
            return;
        }

        protected override function goBackSwitch():void
        {
            handler.CommunicationHandling.getInstance().stopCommunication();
            if (this.loadedData && this.loadedData.length > 0) 
            {
                handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_ACTIVITIES_SELECTOR, {"backScreenName":backScreenName, "loadedData":this.loadedData, "unit":unit}, handler.ViewHandler.slideToLeftTransition());
                return;
            }
            if (backScreenName == "") 
            {
                handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_ACTIVITIES_LIST, null, handler.ViewHandler.slideToRightTransition());
            }
            else 
            {
                handler.ViewHandler.getInstance().showScreen(backScreenName, null, handler.ViewHandler.slideToRightTransition());
            }
            return;
        }

        internal function _ActivitiesTransfer_CommunicationState1_i():frontend.screen.component.devices.CommunicationState
        {
            var loc1:*=new frontend.screen.component.devices.CommunicationState();
            loc1.id = "comState";
            this.comState = loc1;
            feathers.binding.BindingManager.executeBindings(this, "comState", this.comState);
            return loc1;
        }

        internal function _ActivitiesTransfer_Footer1_i():frontend.screen.component.Footer
        {
            var loc1:*=new frontend.screen.component.Footer();
            loc1.id = "footer";
            this.footer = loc1;
            feathers.binding.BindingManager.executeBindings(this, "footer", this.footer);
            return loc1;
        }

        public function ___ActivitiesTransfer_TransferScreen1_addedToStage(arg1:starling.events.Event):void
        {
            this.onAddedToStage(arg1);
            return;
        }

        public function ___ActivitiesTransfer_TransferScreen1_removedFromStage(arg1:starling.events.Event):void
        {
            this.onRemovedFromStage(arg1);
            return;
        }

        internal function _ActivitiesTransfer_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight;
            }, null, "comState.height")
            return result;
        }

        public function get footer():frontend.screen.component.Footer
        {
            return this._1268861541footer;
        }

        public function get comState():frontend.screen.component.devices.CommunicationState
        {
            return this._625992816comState;
        }

        public function set comState(arg1:frontend.screen.component.devices.CommunicationState):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._625992816comState;
            if (loc1 !== arg1) 
            {
                this._625992816comState = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "comState", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
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

        internal function get _dataProvider():feathers.data.ListCollection
        {
            return this._1763739238_dataProvider;
        }

        internal function set _dataProvider(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1763739238_dataProvider;
            if (loc1 !== arg1) 
            {
                this._1763739238_dataProvider = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_dataProvider", loc1, arg1, this);
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
            ActivitiesTransfer._watcherSetupUtil = arg1;
            return;
        }

        internal var _activitiesToSave:__AS3__.vec.Vector.<backend.utils.dbUtils.DBUtilObject>;

        internal var _activitiesToSaveCount:uint;

        internal var _actualActivity:core.activities.Activity;

        internal var _addDeviceTimeoutId:uint=0;

        internal var _currentDevices:Array;

        internal var _1763739238_dataProvider:feathers.data.ListCollection;

        mx_internal var _bindings:Array;

        internal var _noDataPopUp:frontend.components.popup.InfoPopUp;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal var _noDataTimeout:uint=0;

        internal var _activitiesSelected:flash.utils.Dictionary;

        mx_internal var _watchers:Array;

        internal var _625992816comState:frontend.screen.component.devices.CommunicationState;

        internal var _1268861541footer:frontend.screen.component.Footer;

        public var loadHeader:Boolean=true;

        public var loadedData:__AS3__.vec.Vector.<core.activities.Activity>;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


