//package transfer
//  class AGPSTransfer
package frontend.screen.mydevices.transfer 
{
    import configCache.*;
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
    import frontend.screen.component.*;
    import frontend.screen.component.devices.*;
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
    
    public class AGPSTransfer extends frontend.screen.mydevices.transfer.TransferScreen implements feathers.binding.IBindingClient
    {
        public function AGPSTransfer()
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
            bindings = this._AGPSTransfer_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_mydevices_transfer_AGPSTransferWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return AGPSTransfer[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.allowCaching = false;
            this.hasBackwardNavigation = true;
            this.saveAsOldScreen = false;
            this.mxmlContent = [this._AGPSTransfer_CommunicationState1_i(), this._AGPSTransfer_Footer1_i()];
            this.addEventListener("addedToStage", this.___AGPSTransfer_TransferScreen1_addedToStage);
            this.addEventListener("removedFromStage", this.___AGPSTransfer_TransferScreen1_removedFromStage);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        protected function onAddedToStage(arg1:starling.events.Event):void
        {
            this.comState.loading = true;
            this.comState.unitChangeable = false;
            setCallbacks(this.comState);
            init();
            return;
        }

        protected function onRemovedFromStage(arg1:starling.events.Event):void
        {
            destroy();
            handler.CommunicationHandling.getInstance().stopCommunication();
            return;
        }

        protected override function validateProperties():void
        {
            title = utils.LanguageManager.getString("DEVICEVIEW.DEVICE_AGPS");
            this.comState.headline = utils.LanguageManager.getString("DEVICEVIEW.DEVICE_AGPS");
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
            super.transferFunction();
            this.comState.openProgressPopUp(utils.LanguageManager.getString("PROGRESS_POPUP.LOAD_AGPS_TITLE"), utils.LanguageManager.getString("PROGRESS_POPUP.LOAD_AGPS_TEXT"));
            handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.addEventListener(handler.UnitHandler.WRITE_UNIT_AGPS_DATA_COMPLETE, this.onAgpsDataTransfered);
            handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.addEventListener(handler.UnitHandler.EVENT_DOWNLOAD_ERROR, this.onDownloadError);
            handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.addEventListener(handler.UnitHandler.EVENT_AGPS_FILE_LOADED, this.onAgpsFileLoaded);
            handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.sendToDC(handler.UnitHandler.WRITE_UNIT_AGPS_DATA);
            return;
        }

        protected override function goBackSwitch():void
        {
            handler.CommunicationHandling.getInstance().stopCommunication();
            handler.ViewHandler.getInstance().goBack();
            return;
        }

        internal function onAgpsDataTransfered(arg1:flash.events.Event):void
        {
            configCache.ConfigCache.getInstance().setValue(configCache.ConfigCacheObject.AGPS_LAST_SYNC_DATE, new Date());
            this.comState.closeProgressPopUp();
            if (handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler) 
            {
                handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.removeEventListener(handler.UnitHandler.WRITE_UNIT_AGPS_DATA_COMPLETE, this.onAgpsDataTransfered);
                handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.removeEventListener(handler.UnitHandler.EVENT_DOWNLOAD_ERROR, this.onDownloadError);
            }
            flash.utils.setTimeout(this.goBackSwitch, 500);
            return;
        }

        internal function onDownloadError(arg1:flash.events.Event):void
        {
            return;
        }

        internal function onAgpsFileLoaded(arg1:flash.events.Event):void
        {
            handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.removeEventListener(handler.UnitHandler.EVENT_AGPS_FILE_LOADED, this.onAgpsFileLoaded);
            return;
        }

        internal function _AGPSTransfer_CommunicationState1_i():frontend.screen.component.devices.CommunicationState
        {
            var loc1:*=new frontend.screen.component.devices.CommunicationState();
            loc1.id = "comState";
            this.comState = loc1;
            feathers.binding.BindingManager.executeBindings(this, "comState", this.comState);
            return loc1;
        }

        internal function _AGPSTransfer_Footer1_i():frontend.screen.component.Footer
        {
            var loc1:*=new frontend.screen.component.Footer();
            loc1.id = "footer";
            this.footer = loc1;
            feathers.binding.BindingManager.executeBindings(this, "footer", this.footer);
            return loc1;
        }

        public function ___AGPSTransfer_TransferScreen1_addedToStage(arg1:starling.events.Event):void
        {
            this.onAddedToStage(arg1);
            return;
        }

        public function ___AGPSTransfer_TransferScreen1_removedFromStage(arg1:starling.events.Event):void
        {
            this.onRemovedFromStage(arg1);
            return;
        }

        internal function _AGPSTransfer_bindingsSetup():Array
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
            AGPSTransfer._watcherSetupUtil = arg1;
            return;
        }

        internal var _625992816comState:frontend.screen.component.devices.CommunicationState;

        internal var _1268861541footer:frontend.screen.component.Footer;

        public var sportprofilesPreloadedFromDevice:Boolean=true;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//  class ActivitiesTransfer
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


//  class GhostRaceTransfer
package frontend.screen.mydevices.transfer 
{
    import __AS3__.vec.*;
    import core.units.*;
    import core.units.interfaces.*;
    import debug.*;
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
    import frontend.screen.component.*;
    import frontend.screen.component.devices.*;
    import handler.*;
    import handler.interfaces.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    import utils.*;
    
    use namespace mx_internal;
    
    public class GhostRaceTransfer extends frontend.screen.mydevices.transfer.TransferScreen implements feathers.binding.IBindingClient
    {
        public function GhostRaceTransfer()
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
            bindings = this._GhostRaceTransfer_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_mydevices_transfer_GhostRaceTransferWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return GhostRaceTransfer[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.allowCaching = false;
            this.hasBackwardNavigation = true;
            this.saveAsOldScreen = false;
            this.mxmlContent = [this._GhostRaceTransfer_CommunicationState1_i(), this._GhostRaceTransfer_Footer1_i()];
            this.addEventListener("addedToStage", this.___GhostRaceTransfer_TransferScreen1_addedToStage);
            this.addEventListener("removedFromStage", this.___GhostRaceTransfer_TransferScreen1_removedFromStage);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        internal function dsDataProviderFilterFunction(arg1:core.units.Unit, arg2:int, arg3:__AS3__.vec.Vector.<core.units.Unit>):Boolean
        {
            return arg1 is core.units.interfaces.IGhostRaceSupported;
        }

        protected function onAddedToStage(arg1:starling.events.Event):void
        {
            this.comState.loading = true;
            this.comState.unitChangeable = true;
            setCallbacks(this.comState);
            handler.CommunicationHandling.getInstance().loadSavedDevices(this.onDevicesLoaded);
            return;
        }

        internal function onDevicesLoaded():void
        {
            handler.CommunicationHandling.getInstance().currentDevices = handler.CommunicationHandling.getInstance().currentDevices.filter(this.dsDataProviderFilterFunction);
            var loc1:*=handler.CommunicationHandling.getInstance().currentDevices.length;
            if (loc1 != 0) 
            {
                if (handler.CommunicationHandling.getInstance().currentDevice is core.units.interfaces.IGhostRaceSupported) 
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

        protected function onRemovedFromStage(arg1:starling.events.Event):void
        {
            destroy();
            return;
        }

        protected override function validateProperties():void
        {
            title = utils.LanguageManager.getString("DEVICEVIEW.DEVICE_GHOSTRACE");
            this.comState.headline = utils.LanguageManager.getString("DEVICEVIEW.DEVICE_GHOSTRACE");
            return;
        }

        internal function ghostRaceSupported():Boolean
        {
            return unit is core.units.interfaces.IGhostRaceSupported && handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler is handler.interfaces.IGhostRaceLog && !transferModeDownload;
        }

        protected override function onDeviceChanged(arg1:starling.events.Event=null):void
        {
            super.onDeviceChanged(arg1);
            this.comState.showUnitState(handler.CommunicationHandling.getInstance().currentDevice);
            if (!(unit is core.units.interfaces.IGhostRaceSupported)) 
            {
                noGhostRaceSuppoertedInfo();
            }
            return;
        }

        protected override function transferFunction():void
        {
            super.transferFunction();
            if (this.ghostRaceSupported()) 
            {
                this.comState.openProgressPopUp(utils.LanguageManager.getString("PROGRESS_POPUP.SAVE_GHOSTRACE_TITLE"), utils.LanguageManager.getString("PROGRESS_POPUP.SAVE_GHOSTRACE_TEXT"));
                (handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler as handler.interfaces.IGhostRaceLog).ghostRaceLog = activity;
                handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.addEventListener(handler.UnitHandler.WRITE_GHOST_RACE_COMPLETE, this.onGhostRaceSendComplete);
                handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.sendToDC(handler.UnitHandler.WRITE_GHOST_RACE_TO_DEVICE);
            }
            return;
        }

        internal function onGhostRaceSendComplete(arg1:flash.events.Event):void
        {
            this.comState.closeProgressPopUp();
            flash.utils.setTimeout(this.goBackSwitch, 500);
            return;
        }

        protected override function goBackSwitch():void
        {
            debug.Debug.debug("[goBackSwitch]");
            if (handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler) 
            {
                handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.removeEventListener(handler.UnitHandler.WRITE_GHOST_RACE_COMPLETE, this.onGhostRaceSendComplete);
            }
            handler.CommunicationHandling.getInstance().stopCommunication();
            handler.ViewHandler.getInstance().goBack();
            return;
        }

        internal function _GhostRaceTransfer_CommunicationState1_i():frontend.screen.component.devices.CommunicationState
        {
            var loc1:*=new frontend.screen.component.devices.CommunicationState();
            loc1.id = "comState";
            this.comState = loc1;
            feathers.binding.BindingManager.executeBindings(this, "comState", this.comState);
            return loc1;
        }

        internal function _GhostRaceTransfer_Footer1_i():frontend.screen.component.Footer
        {
            var loc1:*=new frontend.screen.component.Footer();
            loc1.id = "footer";
            this.footer = loc1;
            feathers.binding.BindingManager.executeBindings(this, "footer", this.footer);
            return loc1;
        }

        public function ___GhostRaceTransfer_TransferScreen1_addedToStage(arg1:starling.events.Event):void
        {
            this.onAddedToStage(arg1);
            return;
        }

        public function ___GhostRaceTransfer_TransferScreen1_removedFromStage(arg1:starling.events.Event):void
        {
            this.onRemovedFromStage(arg1);
            return;
        }

        internal function _GhostRaceTransfer_bindingsSetup():Array
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
            GhostRaceTransfer._watcherSetupUtil = arg1;
            return;
        }

        internal var _625992816comState:frontend.screen.component.devices.CommunicationState;

        internal var _1268861541footer:frontend.screen.component.Footer;

        internal var _addDeviceTimeoutId:uint=0;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//  class PointNavigationTransfer
package frontend.screen.mydevices.transfer 
{
    import core.units.interfaces.*;
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
    import frontend.screen.component.*;
    import frontend.screen.component.devices.*;
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
    
    public class PointNavigationTransfer extends frontend.screen.mydevices.transfer.TransferScreen implements feathers.binding.IBindingClient
    {
        public function PointNavigationTransfer()
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
            bindings = this._PointNavigationTransfer_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_mydevices_transfer_PointNavigationTransferWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return PointNavigationTransfer[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.allowCaching = false;
            this.hasBackwardNavigation = true;
            this.saveAsOldScreen = false;
            this.mxmlContent = [this._PointNavigationTransfer_CommunicationState1_i(), this._PointNavigationTransfer_Footer1_i()];
            this.addEventListener("addedToStage", this.___PointNavigationTransfer_TransferScreen1_addedToStage);
            this.addEventListener("removedFromStage", this.___PointNavigationTransfer_TransferScreen1_removedFromStage);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        protected function onAddedToStage(arg1:starling.events.Event):void
        {
            this.comState.loading = true;
            this.comState.unitChangeable = false;
            setCallbacks(this.comState);
            init();
            return;
        }

        protected function onRemovedFromStage(arg1:starling.events.Event):void
        {
            destroy();
            handler.CommunicationHandling.getInstance().stopCommunication();
            return;
        }

        protected override function validateProperties():void
        {
            title = utils.LanguageManager.getString("DEVICEVIEW.DEVICE_POINT_NAVIGATION");
            this.comState.headline = utils.LanguageManager.getString("DEVICEVIEW.DEVICE_POINT_NAVIGATION");
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
            super.transferFunction();
            if (!(handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.unit is core.units.interfaces.IPointNavigationsList)) 
            {
                this.goBackSwitch();
                return;
            }
            if (!transferModeDownload) 
            {
                this.comState.openProgressPopUp(utils.LanguageManager.getString("PROGRESS_POPUP.SAVE_POINT_NAVIGATION_TITLE"), utils.LanguageManager.getString("PROGRESS_POPUP.SAVE_POINT_NAVIGATION_TEXT"));
                (handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.unit as core.units.interfaces.IPointNavigationsList).currentPointNavigation = pointNavigation;
                handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.addEventListener(handler.UnitHandler.POINT_NAVIGATION_SEND_TO_DEVICE_COMPLETE, this.onUploadComplete);
                handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.sendToDC(handler.UnitHandler.WRITE_POINT_NAVIGATION_TO_DEVICE);
            }
            return;
        }

        internal function onUploadComplete(arg1:flash.events.Event):void
        {
            this.comState.closeProgressPopUp();
            handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.removeEventListener(handler.UnitHandler.POINT_NAVIGATION_SEND_TO_DEVICE_COMPLETE, this.onUploadComplete);
            flash.utils.setTimeout(this.goBackSwitch, 500);
            return;
        }

        protected override function goBackSwitch():void
        {
            var loc1:*=backScreenName;
            switch (loc1) 
            {
                case "":
                {
                    hasBackwardNavigation = true;
                    handler.ViewHandler.getInstance().goBack();
                    break;
                }
                default:
                {
                    if (pointNavigation && transferModeDownload) 
                    {
                        handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_DEVICE_POINT_NAVIGATION, {"unit":unit, "pointNavigation":pointNavigation}, handler.ViewHandler.slideToLeftTransition());
                    }
                    else 
                    {
                        handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_DEVICE_POINT_NAVIGATIONS, {"unit":unit}, handler.ViewHandler.slideToRightTransition());
                    }
                    break;
                }
            }
            return;
        }

        internal function _PointNavigationTransfer_CommunicationState1_i():frontend.screen.component.devices.CommunicationState
        {
            var loc1:*=new frontend.screen.component.devices.CommunicationState();
            loc1.id = "comState";
            this.comState = loc1;
            feathers.binding.BindingManager.executeBindings(this, "comState", this.comState);
            return loc1;
        }

        internal function _PointNavigationTransfer_Footer1_i():frontend.screen.component.Footer
        {
            var loc1:*=new frontend.screen.component.Footer();
            loc1.id = "footer";
            this.footer = loc1;
            feathers.binding.BindingManager.executeBindings(this, "footer", this.footer);
            return loc1;
        }

        public function ___PointNavigationTransfer_TransferScreen1_addedToStage(arg1:starling.events.Event):void
        {
            this.onAddedToStage(arg1);
            return;
        }

        public function ___PointNavigationTransfer_TransferScreen1_removedFromStage(arg1:starling.events.Event):void
        {
            this.onRemovedFromStage(arg1);
            return;
        }

        internal function _PointNavigationTransfer_bindingsSetup():Array
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
            PointNavigationTransfer._watcherSetupUtil = arg1;
            return;
        }

        internal var _625992816comState:frontend.screen.component.devices.CommunicationState;

        internal var _1268861541footer:frontend.screen.component.Footer;

        public var sportprofilesPreloadedFromDevice:Boolean=true;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//  class SettingsTransfer
package frontend.screen.mydevices.transfer 
{
    import backend.utils.dbUtils.*;
    import core.settings.interfaces.*;
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
    import frontend.screen.component.*;
    import frontend.screen.component.devices.*;
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
    
    public class SettingsTransfer extends frontend.screen.mydevices.transfer.TransferScreen implements feathers.binding.IBindingClient
    {
        public function SettingsTransfer()
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
            bindings = this._SettingsTransfer_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_mydevices_transfer_SettingsTransferWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return SettingsTransfer[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.allowCaching = false;
            this.hasBackwardNavigation = true;
            this.saveAsOldScreen = false;
            this.mxmlContent = [this._SettingsTransfer_CommunicationState1_i(), this._SettingsTransfer_Footer1_i()];
            this.addEventListener("addedToStage", this.___SettingsTransfer_TransferScreen1_addedToStage);
            this.addEventListener("removedFromStage", this.___SettingsTransfer_TransferScreen1_removedFromStage);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        protected function onAddedToStage(arg1:starling.events.Event):void
        {
            this.comState.loading = true;
            this.comState.unitChangeable = false;
            setCallbacks(this.comState);
            init();
            return;
        }

        protected function onRemovedFromStage(arg1:starling.events.Event):void
        {
            destroy();
            handler.CommunicationHandling.getInstance().stopCommunication();
            return;
        }

        protected override function validateProperties():void
        {
            if (transferModeDownload) 
            {
                title = utils.LanguageManager.getString("DEVICEVIEW.DEVICE_SETTINGS_DOWNLOAD");
            }
            else 
            {
                title = utils.LanguageManager.getString("DEVICEVIEW.DEVICE_SETTINGS_SAVE");
            }
            this.comState.headline = title;
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
            super.transferFunction();
            if (transferModeDownload) 
            {
                this.comState.openProgressPopUp(utils.LanguageManager.getString("PROGRESS_POPUP.LOAD_SETTINGS_TITLE"), utils.LanguageManager.getString("PROGRESS_POPUP.LOAD_SETTINGS_TEXT"));
                handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.addEventListener(handler.UnitHandler.SETTINGS_LOADED_FROM_UNIT_COMPLETE, this.onSettingsDownloadComplete);
                handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.loadFromDC(handler.UnitHandler.LOAD_UNIT_SETTINGS_FROM_DEVICE);
            }
            else 
            {
                this.comState.openProgressPopUp(utils.LanguageManager.getString("PROGRESS_POPUP.SAVE_SETTINGS_TITLE"), utils.LanguageManager.getString("PROGRESS_POPUP.SAVE_SETTINGS_TEXT"));
                if (unit.currentSettings == null && !(settings == null)) 
                {
                    unit.currentSettings = settings;
                }
                if (settings == null && !(unit.currentSettings == null)) 
                {
                    settings = unit.currentSettings;
                }
                if (settings is core.settings.interfaces.INfc) 
                {
                    (settings as core.settings.interfaces.INfc).nfcActive = true;
                }
                handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.unit.currentSettings = settings;
                handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.addEventListener(handler.UnitHandler.SETTINGS_SEND_TO_DEVICE_COMPLETE, this.onSettingsUploadComplete);
                handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.sendToDC(handler.UnitHandler.WRITE_UNIT_SETTINGS_TO_DEVICE);
            }
            return;
        }

        internal function onSettingsDownloadComplete(arg1:flash.events.Event):void
        {
            this.comState.closeProgressPopUp();
            handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.removeEventListener(handler.UnitHandler.SETTINGS_LOADED_FROM_UNIT_COMPLETE, this.onSettingsDownloadComplete);
            flash.utils.setTimeout(this.saveNow, 500);
            return;
        }

        internal function saveNow():void
        {
            settings = handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.unit.currentSettings;
            settings.unit = handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.unit;
            settings.isDeleted = false;
            settings.modificationDate = new Date().time;
            handler.AppDeviceHandler.getInstance().saveSettings(new backend.utils.dbUtils.DBUtilObject(settings, this.onInsertDataComplete, onInsertDataError, null));
            return;
        }

        protected override function onInsertDataComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            super.onInsertDataComplete(arg1);
            return;
        }

        internal function onSettingsUploadComplete(arg1:flash.events.Event):void
        {
            this.comState.closeProgressPopUp();
            handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.removeEventListener(handler.UnitHandler.SETTINGS_SEND_TO_DEVICE_COMPLETE, this.onSettingsUploadComplete);
            flash.utils.setTimeout(this.goBackSwitch, 500);
            return;
        }

        protected override function goBackSwitch():void
        {
            var loc1:*=backScreenName;
            switch (loc1) 
            {
                case "":
                {
                    hasBackwardNavigation = true;
                    handler.ViewHandler.getInstance().goBack();
                    break;
                }
                default:
                {
                    if (settings && transferModeDownload) 
                    {
                        handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_DEVICE_SETTING, {"unit":unit, "settings":settings}, handler.ViewHandler.slideToLeftTransition());
                    }
                    else 
                    {
                        handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_DEVICE_SETTINGS, {"unit":unit}, handler.ViewHandler.slideToRightTransition());
                    }
                    break;
                }
            }
            return;
        }

        internal function _SettingsTransfer_CommunicationState1_i():frontend.screen.component.devices.CommunicationState
        {
            var loc1:*=new frontend.screen.component.devices.CommunicationState();
            loc1.id = "comState";
            this.comState = loc1;
            feathers.binding.BindingManager.executeBindings(this, "comState", this.comState);
            return loc1;
        }

        internal function _SettingsTransfer_Footer1_i():frontend.screen.component.Footer
        {
            var loc1:*=new frontend.screen.component.Footer();
            loc1.id = "footer";
            this.footer = loc1;
            feathers.binding.BindingManager.executeBindings(this, "footer", this.footer);
            return loc1;
        }

        public function ___SettingsTransfer_TransferScreen1_addedToStage(arg1:starling.events.Event):void
        {
            this.onAddedToStage(arg1);
            return;
        }

        public function ___SettingsTransfer_TransferScreen1_removedFromStage(arg1:starling.events.Event):void
        {
            this.onRemovedFromStage(arg1);
            return;
        }

        internal function _SettingsTransfer_bindingsSetup():Array
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
            SettingsTransfer._watcherSetupUtil = arg1;
            return;
        }

        internal var _625992816comState:frontend.screen.component.devices.CommunicationState;

        internal var _1268861541footer:frontend.screen.component.Footer;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//  class SleepScreenTransfer
package frontend.screen.mydevices.transfer 
{
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
    import frontend.screen.component.*;
    import frontend.screen.component.devices.*;
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
    
    public class SleepScreenTransfer extends frontend.screen.mydevices.transfer.TransferScreen implements feathers.binding.IBindingClient
    {
        public function SleepScreenTransfer()
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
            bindings = this._SleepScreenTransfer_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_mydevices_transfer_SleepScreenTransferWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return SleepScreenTransfer[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.allowCaching = false;
            this.hasBackwardNavigation = true;
            this.saveAsOldScreen = false;
            this.mxmlContent = [this._SleepScreenTransfer_CommunicationState1_i(), this._SleepScreenTransfer_Footer1_i()];
            this.addEventListener("addedToStage", this.___SleepScreenTransfer_TransferScreen1_addedToStage);
            this.addEventListener("removedFromStage", this.___SleepScreenTransfer_TransferScreen1_removedFromStage);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        protected function onAddedToStage(arg1:starling.events.Event):void
        {
            this.comState.loading = true;
            this.comState.unitChangeable = false;
            handler.CommunicationHandling.getInstance().ignoreUSB = true;
            setCallbacks(this.comState);
            init();
            return;
        }

        protected function onRemovedFromStage(arg1:starling.events.Event):void
        {
            destroy();
            handler.CommunicationHandling.getInstance().ignoreUSB = false;
            handler.CommunicationHandling.getInstance().stopCommunication();
            return;
        }

        protected override function validateProperties():void
        {
            title = utils.LanguageManager.getString("PROGRESS_POPUP.SAVE_SLEEP_SCREEN_TITLE");
            this.comState.headline = title;
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
            super.transferFunction();
            this.comState.openProgressPopUp(utils.LanguageManager.getString("PROGRESS_POPUP.SAVE_SLEEP_SCREEN_TITLE"), utils.LanguageManager.getString("PROGRESS_POPUP.SAVE_SLEEP_SCREEN_TEXT"));
            handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.addEventListener(handler.UnitHandler.SLEEP_SCREEN_SEND_TO_DEVICE_COMPLETE, this.onSleepScreenSendComplete);
            handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.sendToDC(handler.UnitHandler.WRITE_UNIT_SLEEP_SCREEN_TO_DEVICE);
            return;
        }

        internal function onSleepScreenSendComplete(arg1:flash.events.Event):void
        {
            this.comState.closeProgressPopUp();
            handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.removeEventListener(handler.UnitHandler.SETTINGS_LOADED_FROM_UNIT_COMPLETE, this.onSleepScreenSendComplete);
            flash.utils.setTimeout(this.goBackSwitch, 500);
            return;
        }

        protected override function goBackSwitch():void
        {
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_DEVICE_SLEEP_SCREEN, {"unit":unit}, handler.ViewHandler.slideToRightTransition());
            return;
        }

        internal function _SleepScreenTransfer_CommunicationState1_i():frontend.screen.component.devices.CommunicationState
        {
            var loc1:*=new frontend.screen.component.devices.CommunicationState();
            loc1.id = "comState";
            this.comState = loc1;
            feathers.binding.BindingManager.executeBindings(this, "comState", this.comState);
            return loc1;
        }

        internal function _SleepScreenTransfer_Footer1_i():frontend.screen.component.Footer
        {
            var loc1:*=new frontend.screen.component.Footer();
            loc1.id = "footer";
            this.footer = loc1;
            feathers.binding.BindingManager.executeBindings(this, "footer", this.footer);
            return loc1;
        }

        public function ___SleepScreenTransfer_TransferScreen1_addedToStage(arg1:starling.events.Event):void
        {
            this.onAddedToStage(arg1);
            return;
        }

        public function ___SleepScreenTransfer_TransferScreen1_removedFromStage(arg1:starling.events.Event):void
        {
            this.onRemovedFromStage(arg1);
            return;
        }

        internal function _SleepScreenTransfer_bindingsSetup():Array
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
            SleepScreenTransfer._watcherSetupUtil = arg1;
            return;
        }

        internal var _625992816comState:frontend.screen.component.devices.CommunicationState;

        internal var _1268861541footer:frontend.screen.component.Footer;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//  class SportprofilesTransfer
package frontend.screen.mydevices.transfer 
{
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
    import frontend.screen.component.*;
    import frontend.screen.component.devices.*;
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
    
    public class SportprofilesTransfer extends frontend.screen.mydevices.transfer.TransferScreen implements feathers.binding.IBindingClient
    {
        public function SportprofilesTransfer()
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
            bindings = this._SportprofilesTransfer_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_mydevices_transfer_SportprofilesTransferWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return SportprofilesTransfer[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.allowCaching = false;
            this.hasBackwardNavigation = true;
            this.saveAsOldScreen = false;
            this.mxmlContent = [this._SportprofilesTransfer_CommunicationState1_i(), this._SportprofilesTransfer_Footer1_i()];
            this.addEventListener("addedToStage", this.___SportprofilesTransfer_TransferScreen1_addedToStage);
            this.addEventListener("removedFromStage", this.___SportprofilesTransfer_TransferScreen1_removedFromStage);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        protected function onAddedToStage(arg1:starling.events.Event):void
        {
            this.comState.loading = true;
            this.comState.unitChangeable = false;
            setCallbacks(this.comState);
            init();
            return;
        }

        protected function onRemovedFromStage(arg1:starling.events.Event):void
        {
            destroy();
            handler.CommunicationHandling.getInstance().stopCommunication();
            return;
        }

        protected override function validateProperties():void
        {
            title = utils.LanguageManager.getString("DEVICEVIEW.DEVICE_SPORT_PROFILES");
            this.comState.headline = utils.LanguageManager.getString("DEVICEVIEW.DEVICE_SPORT_PROFILES");
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
            super.transferFunction();
            if (transferModeDownload) 
            {
                this.comState.openProgressPopUp(utils.LanguageManager.getString("PROGRESS_POPUP.LOAD_SPORTPROFILES_TITLE"), utils.LanguageManager.getString("PROGRESS_POPUP.LOAD_SPORTPROFILES_TEXT"));
                handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.addEventListener(handler.UnitHandler.SPORT_PROFILES_LOADED_FROM_UNIT_COMPLETE, this.onSportprofilesDownloadComplete);
                handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.loadFromDC(handler.UnitHandler.LOAD_SPORT_PROFILES_FROM_DEVICE);
            }
            else 
            {
                this.comState.openProgressPopUp(utils.LanguageManager.getString("PROGRESS_POPUP.SAVE_SPORTPROFILES_TITLE"), utils.LanguageManager.getString("PROGRESS_POPUP.SAVE_SPORTPROFILES_TEXT"));
                if (this.sportprofilesPreloadedFromDevice) 
                {
                    handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.addEventListener(handler.UnitHandler.SPORT_PROFILES_LOADED_FROM_UNIT_COMPLETE, this.onSportprofilesDownloadForUploadComplete);
                    handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.loadFromDC(handler.UnitHandler.LOAD_SPORT_PROFILES_FROM_DEVICE);
                }
                else 
                {
                    handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.addEventListener(handler.UnitHandler.SPORT_PROFILE_SEND_TO_DEVICE_COMPLETE, this.onSportprofileUploadComplete);
                    handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.sendToDC(handler.UnitHandler.WRITE_SPORT_PROFILES_TO_DEVICE);
                }
            }
            return;
        }

        internal function onSportprofilesDownloadComplete(arg1:flash.events.Event):void
        {
            this.comState.closeProgressPopUp();
            handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.removeEventListener(handler.UnitHandler.SPORT_PROFILES_LOADED_FROM_UNIT_COMPLETE, this.onSportprofilesDownloadComplete);
            flash.utils.setTimeout(this.onDownload, 500);
            return;
        }

        internal function onDownload():void
        {
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_DEVICE_SPORTPROFILES_SELECTOR, {"unit":unit, "download":true}, handler.ViewHandler.slideToLeftTransition());
            return;
        }

        internal function onSportprofilesDownloadForUploadComplete(arg1:flash.events.Event):void
        {
            this.comState.closeProgressPopUp();
            handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.removeEventListener(handler.UnitHandler.SPORT_PROFILES_LOADED_FROM_UNIT_COMPLETE, this.onSportprofilesDownloadForUploadComplete);
            flash.utils.setTimeout(this.onDownloadForUpload, 500);
            return;
        }

        internal function onDownloadForUpload():void
        {
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_DEVICE_SPORTPROFILES_SELECTOR, {"unit":unit, "download":false, "sportprofileToUpload":sportprofile}, handler.ViewHandler.slideToLeftTransition());
            return;
        }

        internal function onSportprofileUploadComplete(arg1:flash.events.Event):void
        {
            this.comState.closeProgressPopUp();
            handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.removeEventListener(handler.UnitHandler.SPORT_PROFILE_SEND_TO_DEVICE_COMPLETE, this.onSportprofileUploadComplete);
            flash.utils.setTimeout(this.goBackSwitch, 500);
            return;
        }

        protected override function goBackSwitch():void
        {
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_DEVICE_SPORT_PROFILES, {"unit":unit}, handler.ViewHandler.slideToRightTransition());
            return;
        }

        internal function _SportprofilesTransfer_CommunicationState1_i():frontend.screen.component.devices.CommunicationState
        {
            var loc1:*=new frontend.screen.component.devices.CommunicationState();
            loc1.id = "comState";
            this.comState = loc1;
            feathers.binding.BindingManager.executeBindings(this, "comState", this.comState);
            return loc1;
        }

        internal function _SportprofilesTransfer_Footer1_i():frontend.screen.component.Footer
        {
            var loc1:*=new frontend.screen.component.Footer();
            loc1.id = "footer";
            this.footer = loc1;
            feathers.binding.BindingManager.executeBindings(this, "footer", this.footer);
            return loc1;
        }

        public function ___SportprofilesTransfer_TransferScreen1_addedToStage(arg1:starling.events.Event):void
        {
            this.onAddedToStage(arg1);
            return;
        }

        public function ___SportprofilesTransfer_TransferScreen1_removedFromStage(arg1:starling.events.Event):void
        {
            this.onRemovedFromStage(arg1);
            return;
        }

        internal function _SportprofilesTransfer_bindingsSetup():Array
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
            SportprofilesTransfer._watcherSetupUtil = arg1;
            return;
        }

        internal var _625992816comState:frontend.screen.component.devices.CommunicationState;

        internal var _1268861541footer:frontend.screen.component.Footer;

        public var sportprofilesPreloadedFromDevice:Boolean=true;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//  class StravaSegmentsTransfer
package frontend.screen.mydevices.transfer 
{
    import __AS3__.vec.*;
    import backend.oauth.*;
    import configCache.*;
    import core.strava.*;
    import core.units.interfaces.*;
    import debug.*;
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
    import frontend.components.popup.*;
    import frontend.screen.component.*;
    import frontend.screen.component.devices.*;
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
    
    public class StravaSegmentsTransfer extends frontend.screen.mydevices.transfer.TransferScreen implements feathers.binding.IBindingClient
    {
        public function StravaSegmentsTransfer()
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
            bindings = this._StravaSegmentsTransfer_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_mydevices_transfer_StravaSegmentsTransferWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return StravaSegmentsTransfer[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.allowCaching = false;
            this.hasBackwardNavigation = true;
            this.saveAsOldScreen = false;
            this.mxmlContent = [this._StravaSegmentsTransfer_CommunicationState1_i(), this._StravaSegmentsTransfer_Footer1_i()];
            this.addEventListener("addedToStage", this.___StravaSegmentsTransfer_TransferScreen1_addedToStage);
            this.addEventListener("removedFromStage", this.___StravaSegmentsTransfer_TransferScreen1_removedFromStage);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        internal function onStravaSegmentsDeleted(arg1:flash.events.Event):void
        {
            handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.removeEventListener(handler.UnitHandler.DELETE_STRAVA_SEGMENTS_ON_UNIT_COMPLETE, this.onStravaSegmentsDeleted);
            this._segmentsDeleted = true;
            this.transferFunction();
            return;
        }

        internal function sendNextSegment():void
        {
            var loc1:*=null;
            var loc2:*=NaN;
            if (this._segmenstToCommit && this._segmenstToCommit.length > 0) 
            {
                var loc3:*;
                var loc4:*=((loc3 = this).numSegmentsCommited + 1);
                loc3.numSegmentsCommited = loc4;
                debug.Debug.debug("Commit Segment: " + this.numSegmentsCommited);
                loc1 = this._segmenstToCommit.shift();
                loc2 = this.PROGRESS_FOR_UPLOAD * this.numSegmentsCommited / this.numSegmentsToCommit;
                this._progress = this.PROGRESS_FOR_DOWNLOAD_HEADER + this.PROGRESS_FOR_DOWNLOAD_DETAILS + loc2;
                this._progressPopUpText = utils.LanguageManager.getString("UNIT_STRAVA_SEGMENTS_PRE_SEND") + " " + loc1.name;
                this.comState.updateProgressPopUp(this._progress, null, this._progressPopUpText);
                (handler.CommunicationHandling.getInstance().currentDevice as core.units.interfaces.IStravaSegmentsSupported).currentStravaSegment = loc1;
                handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.addEventListener(handler.UnitHandler.SEND_STRAVA_SEGMENT_TO_UNIT_COMPLETE, this.onSegmentsSendComplete);
                handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.sendToDC(handler.UnitHandler.SEND_STRAVA_SEGMENT_TO_UNIT);
            }
            else 
            {
                this.comState.closeProgressPopUp();
                flash.utils.setTimeout(this.goBackSwitch, 300);
            }
            return;
        }

        internal function onSegmentsSendComplete(arg1:flash.events.Event):void
        {
            handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.removeEventListener(handler.UnitHandler.SEND_STRAVA_SEGMENT_TO_UNIT_COMPLETE, this.onSegmentsSendComplete);
            flash.utils.setTimeout(this.sendNextSegment, 500);
            return;
        }

        protected override function goBackSwitch():void
        {
            handler.CommunicationHandling.getInstance().stopCommunication();
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_DEVICE_VIEW, {"unit":unit}, handler.ViewHandler.slideToRightTransition());
            return;
        }

        internal function _StravaSegmentsTransfer_CommunicationState1_i():frontend.screen.component.devices.CommunicationState
        {
            var loc1:*=new frontend.screen.component.devices.CommunicationState();
            loc1.id = "comState";
            this.comState = loc1;
            feathers.binding.BindingManager.executeBindings(this, "comState", this.comState);
            return loc1;
        }

        internal function _StravaSegmentsTransfer_Footer1_i():frontend.screen.component.Footer
        {
            var loc1:*=new frontend.screen.component.Footer();
            loc1.id = "footer";
            this.footer = loc1;
            feathers.binding.BindingManager.executeBindings(this, "footer", this.footer);
            return loc1;
        }

        internal function stravaSegmentsInfoPopUpCancel(arg1:frontend.components.popup.InfoPopUp):void
        {
            frontend.components.popup.PopUpBase.removePopUps(this._infoPopUp);
            this.goBackSwitch();
            return;
        }

        public function ___StravaSegmentsTransfer_TransferScreen1_addedToStage(arg1:starling.events.Event):void
        {
            this.onAddedToStage(arg1);
            return;
        }

        public function ___StravaSegmentsTransfer_TransferScreen1_removedFromStage(arg1:starling.events.Event):void
        {
            this.onRemovedFromStage(arg1);
            return;
        }

        internal function _StravaSegmentsTransfer_bindingsSetup():Array
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

        public function get comState():frontend.screen.component.devices.CommunicationState
        {
            return this._625992816comState;
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
            StravaSegmentsTransfer._watcherSetupUtil = arg1;
            return;
        }

        internal function get numSegmentsCommited():uint
        {
            return this._numSegmentsCommited;
        }

        internal function set numSegmentsCommited(arg1:uint):void
        {
            this._numSegmentsCommited = arg1;
            return;
        }

        
        {
            WAIT_FOR_STRAVA_DOWNLOAD_DELAY = 300;
        }

        internal function get numSegmentsToCommit():uint
        {
            return this._numSegmentsToCommit;
        }

        internal function set numSegmentsToCommit(arg1:uint):void
        {
            this._numSegmentsToCommit = arg1;
            return;
        }

        protected function onAddedToStage(arg1:starling.events.Event):void
        {
            this.comState.loading = true;
            this.comState.unitChangeable = false;
            setCallbacks(this.comState);
            this._segmenstToCommit = new Vector.<core.strava.StravaSegment>();
            this._numSegmentsLoaded = 0;
            this.numSegmentsToCommit = 0;
            this._progress = 0;
            init();
            return;
        }

        protected function onRemovedFromStage(arg1:starling.events.Event):void
        {
            destroy();
            return;
        }

        protected override function validateProperties():void
        {
            title = utils.LanguageManager.getString("UNIT_STRAVA_SEGMENTS_DOWNLOADING");
            this.comState.headline = title;
            if (backend.oauth.StravaOAuth.getInstance().loggedOut) 
            {
                handler.CommunicationHandling.getInstance().stopCommunication();
                this._infoPopUp = new frontend.components.popup.InfoPopUp(true, true, this.stravaNotLoggedInOk, this.stravaSegmentsInfoPopUpCancel);
                this._infoPopUp.headline = utils.LanguageManager.getString("UNIT_STRAVA_SEGMENTS");
                this._infoPopUp.text = utils.LanguageManager.getString("UNIT_STRAVA_SEGMENTS_INFOTEXT_OFFLINE");
                frontend.components.popup.PopUpBase.showModalPopUp(this._infoPopUp);
            }
            else if (configCache.ConfigCache.getInstance().getValue(backend.oauth.StravaOAuth.CONFIG_CACHE_IS_PREMIUM, false) == false) 
            {
                handler.CommunicationHandling.getInstance().stopCommunication();
                this._infoPopUp = new frontend.components.popup.InfoPopUp(true, true, this.stravaGetPremium, this.stravaSegmentsInfoPopUpCancel);
                this._infoPopUp.headline = utils.LanguageManager.getString("UNIT_STRAVA_SEGMENTS");
                this._infoPopUp.text = utils.LanguageManager.getString("UNIT_STRAVA_SEGMENTS_INFOTEXT_PREMIUM");
                this._infoPopUp.setOkButtonLabel("UNIT_STRAVA_PREMIUM_LINK_BUTTON");
                frontend.components.popup.PopUpBase.showModalPopUp(this._infoPopUp);
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
            if (this._downloadSegements) 
            {
                this.comState.openProgressPopUp(utils.LanguageManager.getString("UNIT_STRAVA_SEGMENTS_HEADLINE"), utils.LanguageManager.getString("UNIT_STRAVA_SEGMENTS_DOWNLOADING"));
                flash.utils.setTimeout(this.startDownloadSegments, 500);
            }
            else 
            {
                super.transferFunction();
                if (this._segmentsDeleted) 
                {
                    flash.utils.setTimeout(this.sendNextSegment, 1000);
                }
                else 
                {
                    this._progressPopUpText = utils.LanguageManager.getString("UNIT_STRAVA_SEGMENTS_COMMITING");
                    this.comState.updateProgressPopUp(this._progress, null, this._progressPopUpText);
                    handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.addEventListener(handler.UnitHandler.DELETE_STRAVA_SEGMENTS_ON_UNIT_COMPLETE, this.onStravaSegmentsDeleted);
                    handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.sendToDC(handler.UnitHandler.DELETE_STRAVA_SEGMENTS_ON_UNIT);
                }
            }
            return;
        }

        internal function startDownloadSegments():void
        {
            backend.oauth.StravaOAuth.getInstance().addEventListener(core.strava.StravaEvent.EVENT_LOAD_SEGMENTS_HEADER_DOWNLOADED, this.onStravaSegmentsHeaderLoaded);
            backend.oauth.StravaOAuth.getInstance().addEventListener(core.strava.StravaEvent.EVENT_LOAD_SINGLE_SEGMENT_DETAIL_COMPLETE, this.onStravaSingleSegmentLoaded);
            backend.oauth.StravaOAuth.getInstance().addEventListener(core.strava.StravaEvent.EVENT_LOAD_SEGMENTS_COMPLETE, this.onStravaAllSegmentsComplete);
            backend.oauth.StravaOAuth.getInstance().addEventListener(core.strava.StravaEvent.EVENT_LOAD_SEGMENTS_TIMEOUT, this.onStravaSegmentsTimeout);
            backend.oauth.StravaOAuth.getInstance().loadSegments(true);
            return;
        }

        internal function stravaNotLoggedInOk(arg1:frontend.components.popup.InfoPopUp):void
        {
            frontend.components.popup.PopUpBase.removePopUps(this._infoPopUp);
            handler.CommunicationHandling.getInstance().stopCommunication();
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_APPSETTINGS_KONTEN, null, handler.ViewHandler.slideToLeftTransition());
            return;
        }

        internal function stravaGetPremium(arg1:frontend.components.popup.InfoPopUp):void
        {
            frontend.components.popup.PopUpBase.removePopUps(this._infoPopUp);
            handler.CommunicationHandling.getInstance().stopCommunication();
            this.goBackSwitch();
            flash.net.navigateToURL(new flash.net.URLRequest(backend.oauth.StravaOAuth.URL_STRAVA_PREMIUM_INFO), "_blank");
            return;
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

        internal function onStravaSegmentsHeaderLoaded(arg1:core.strava.StravaEvent):void
        {
            backend.oauth.StravaOAuth.getInstance().removeEventListener(core.strava.StravaEvent.EVENT_LOAD_SEGMENTS_HEADER_DOWNLOADED, this.onStravaSegmentsHeaderLoaded);
            this.numSegmentsToCommit = arg1.extendedData as uint;
            this.numSegmentsCommited = 0;
            if (this.numSegmentsToCommit == 0) 
            {
                this.comState.closeProgressPopUp();
                return;
            }
            this._progress = this.PROGRESS_FOR_DOWNLOAD_HEADER;
            this._progressPopUpText = this.numSegmentsToCommit + " " + utils.LanguageManager.getString("UNIT_STRAVA_SEGMENTS_LOADED");
            this.comState.closeProgressOn100Percent = false;
            this.comState.updateProgressPopUp(this._progress, null, this._progressPopUpText);
            return;
        }

        internal function onStravaSingleSegmentLoaded(arg1:core.strava.StravaEvent):void
        {
            var loc1:*=arg1.stravaSegment;
            if (this._segmenstToCommit == null) 
            {
                this._segmenstToCommit = new Vector.<core.strava.StravaSegment>();
            }
            loc1.decodeMap();
            this._segmenstToCommit.push(loc1);
            var loc2:*;
            var loc3:*=((loc2 = this)._numSegmentsLoaded + 1);
            loc2._numSegmentsLoaded = loc3;
            this._progress = this.PROGRESS_FOR_DOWNLOAD_HEADER + this.PROGRESS_FOR_DOWNLOAD_DETAILS / this.numSegmentsToCommit;
            this._progressPopUpText = utils.LanguageManager.getString("UNIT_STRAVA_SEGMENTS_PRE_LOAD") + " " + loc1.name;
            this.comState.updateProgressPopUp(this._progress, null, this._progressPopUpText);
            return;
        }

        internal function onStravaAllSegmentsComplete(arg1:core.strava.StravaEvent):void
        {
            backend.oauth.StravaOAuth.getInstance().removeEventListener(core.strava.StravaEvent.EVENT_LOAD_SINGLE_SEGMENT_DETAIL_COMPLETE, this.onStravaSingleSegmentLoaded);
            backend.oauth.StravaOAuth.getInstance().removeEventListener(core.strava.StravaEvent.EVENT_LOAD_SEGMENTS_COMPLETE, this.onStravaAllSegmentsComplete);
            this._downloadSegements = false;
            this.transferFunction();
            return;
        }

        internal function onStravaSegmentsTimeout(arg1:core.strava.StravaEvent=null):void
        {
            backend.oauth.StravaOAuth.getInstance().removeEventListener(core.strava.StravaEvent.EVENT_LOAD_SEGMENTS_HEADER_DOWNLOADED, this.onStravaSegmentsHeaderLoaded);
            backend.oauth.StravaOAuth.getInstance().removeEventListener(core.strava.StravaEvent.EVENT_LOAD_SINGLE_SEGMENT_DETAIL_COMPLETE, this.onStravaSingleSegmentLoaded);
            backend.oauth.StravaOAuth.getInstance().removeEventListener(core.strava.StravaEvent.EVENT_LOAD_SEGMENTS_COMPLETE, this.onStravaAllSegmentsComplete);
            backend.oauth.StravaOAuth.getInstance().removeEventListener(core.strava.StravaEvent.EVENT_LOAD_SEGMENTS_TIMEOUT, this.onStravaSegmentsTimeout);
            this.comState.closeProgressPopUp();
            this.goBackSwitch();
            return;
        }

        internal function showNoSegmentsPopUp():void
        {
            this.comState.closeProgressPopUp();
            this._infoPopUp = new frontend.components.popup.InfoPopUp(true, false, this.stravaSegmentsInfoPopUpCancel);
            this._infoPopUp.headline = utils.LanguageManager.getString("UNIT_STRAVA_SEGEMENTS_POPUP_NOSEGMENTS_HEADLINE");
            this._infoPopUp.text = utils.LanguageManager.getString("UNIT_STRAVA_SEGEMENTS_POPUP_NOSEGMENTS_TEXT");
            frontend.components.popup.PopUpBase.showModalPopUp(this._infoPopUp);
            return;
        }

        internal const PROGRESS_FOR_DOWNLOAD_DETAILS:Number=20;

        internal const PROGRESS_FOR_DOWNLOAD_HEADER:Number=10;

        internal const PROGRESS_FOR_UPLOAD:Number=70;

        internal static const MAXIMUM_STRAVA_DOWNLOAD_RETRIES:uint=10;

        internal var _625992816comState:frontend.screen.component.devices.CommunicationState;

        internal var _1268861541footer:frontend.screen.component.Footer;

        internal var _downloadSegements:Boolean=true;

        internal var _numSegmentsLoaded:uint=0;

        internal var _progress:Number=0;

        internal var _progressPopUpText:String="";

        internal var _segmenstToCommit:__AS3__.vec.Vector.<core.strava.StravaSegment>;

        internal var _segmentsDeleted:Boolean=false;

        internal var _stravaDownloadRetries:uint=0;

        internal var _numSegmentsCommited:uint=0;

        internal var _numSegmentsToCommit:uint=0;

        internal var _infoPopUp:frontend.components.popup.InfoPopUp;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        internal static var WAIT_FOR_STRAVA_DOWNLOAD_DELAY:uint=300;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;

        mx_internal var _bindings:Array;
    }
}


//  class TracksTransfer
package frontend.screen.mydevices.transfer 
{
    import __AS3__.vec.*;
    import backend.utils.dbUtils.*;
    import core.route.*;
    import core.units.*;
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
    import frontend.components.list.*;
    import frontend.screen.component.*;
    import frontend.screen.component.devices.*;
    import frontend.screen.tracks.tabs.list.*;
    import handler.*;
    import init.interfaces.*;
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
    
    public class TracksTransfer extends frontend.screen.mydevices.transfer.TransferScreen implements feathers.binding.IBindingClient
    {
        public function TracksTransfer()
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
            bindings = this._TracksTransfer_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_mydevices_transfer_TracksTransferWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return TracksTransfer[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.allowCaching = false;
            this.hasBackwardNavigation = true;
            this.saveAsOldScreen = false;
            this.mxmlContent = [this._TracksTransfer_CommunicationState1_i(), this._TracksTransfer_Footer1_i()];
            this.addEventListener("addedToStage", this.___TracksTransfer_TransferScreen1_addedToStage);
            this.addEventListener("removedFromStage", this.___TracksTransfer_TransferScreen1_removedFromStage);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        internal function dsDataProviderFilterFunction(arg1:core.units.Unit, arg2:int, arg3:__AS3__.vec.Vector.<core.units.Unit>):Boolean
        {
            return arg1 is core.units.interfaces.ITrackList;
        }

        protected function onAddedToStage(arg1:starling.events.Event):void
        {
            this.comState.loading = true;
            this.comState.unitChangeable = false;
            this.comState.closeProgressOn100Percent = false;
            setCallbacks(this.comState);
            if (unit && !(unit is core.units.interfaces.ITrackList)) 
            {
                unit = null;
            }
            if (unit) 
            {
                init();
            }
            else 
            {
                handler.CommunicationHandling.getInstance().loadSavedDevices(this.onDevicesLoaded);
            }
            if (track) 
            {
                handler.RouteHandler.getInstance().loadRoutePoints(new backend.utils.dbUtils.DBUtilObject(null, this.loadRoutePointsComplete, this.loadRoutePointsError, null), track.routeId);
            }
            return;
        }

        internal function loadRoutePointsComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            handler.RouteHandler.getInstance().loadRoutePointsComplete(arg1.getResult(), track);
            return;
        }

        internal function loadRoutePointsError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("loadRoutePointsError");
            return;
        }

        internal function onDevicesLoaded():void
        {
            handler.CommunicationHandling.getInstance().currentDevices = handler.CommunicationHandling.getInstance().currentDevices.filter(this.dsDataProviderFilterFunction);
            var loc1:*=handler.CommunicationHandling.getInstance().currentDevices.length;
            if (loc1 != 0) 
            {
                if (handler.CommunicationHandling.getInstance().currentDevice is core.units.interfaces.ITrackList) 
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

        internal function onTracksDataDownloadComplete(arg1:flash.events.Event):void
        {
            handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.removeEventListener(handler.UnitHandler.PLANED_TRACKS_LOADED_COMPLETE, this.onTracksDataDownloadComplete);
            this.loadHeader = true;
            this.tracks = (handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.unit as core.units.interfaces.IDataToDecode).tracksToDecode;
            this._tracksToSave = this.tracks.length;
            if (this._tracksToSave > 0) 
            {
                this.comState.updateProgressPopUp(0, utils.LanguageManager.getString("PROGRESS_POPUP.SAVE_TRACKS_TITLE"), utils.LanguageManager.getString("PROGRESS_POPUP.SAVE_TRACKS_TEXT"));
            }
            this.saveNextTrack();
            return;
        }

        protected function onRemovedFromStage(arg1:starling.events.Event):void
        {
            destroy();
            return;
        }

        protected override function validateProperties():void
        {
            if (transferModeDownload) 
            {
                title = utils.LanguageManager.getString("DEVICEVIEW.DEVICE_TRACKS_DOWNLOAD");
            }
            else 
            {
                title = utils.LanguageManager.getString("DEVICEVIEW.DEVICE_TRACKS_SAVE");
            }
            this.comState.headline = title;
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
            super.transferFunction();
            if (transferModeDownload) 
            {
                this.comState.openProgressPopUp(utils.LanguageManager.getString("PROGRESS_POPUP.LOAD_TRACKS_TITLE"), utils.LanguageManager.getString("PROGRESS_POPUP.LOAD_TRACKS_TEXT"));
                if (this.loadHeader) 
                {
                    handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.addEventListener(handler.UnitHandler.PLANED_TRACK_FILE_HEADER_COMPLETE, this.onTracksHeaderDownloadComplete);
                    handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.loadFromDC(handler.UnitHandler.LOAD_UNIT_PLANED_TRACK_FILE_HEADER);
                }
                else 
                {
                    (handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.unit as core.units.interfaces.IDataToDecode).tracksToDecode = this.tracksHeader;
                    handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.addEventListener(handler.UnitHandler.PLANED_TRACKS_LOADED_COMPLETE, this.onTracksDataDownloadComplete);
                    handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.loadFromDC(handler.UnitHandler.LOAD_UNIT_PLANED_TRACK_FILE);
                }
            }
            else if (this.loadHeader) 
            {
                this.comState.openProgressPopUp(utils.LanguageManager.getString("PROGRESS_POPUP.SAVE_TRACKS_TITLE"), utils.LanguageManager.getString("PROGRESS_POPUP.SAVE_TRACKS_TEXT"));
                this.comState.progressStatusStart = 0;
                this.comState.progressStatusBase = SEND_LOAD_HEADER_PERCENT;
                handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.addEventListener(handler.UnitHandler.PLANED_TRACK_FILE_HEADER_COMPLETE, this.onTracksHeaderDownloadForUploadComplete);
                handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.loadFromDC(handler.UnitHandler.LOAD_UNIT_PLANED_TRACK_FILE_HEADER);
            }
            else if (this.deleteOnDevice) 
            {
                this.comState.progressStatusStart = SEND_LOAD_HEADER_PERCENT;
                this.comState.progressStatusBase = SEND_DELETE_ON_DEVICE_PERCENT;
                handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.addEventListener(handler.UnitHandler.DELETE_TRACKS_ON_UNIT_COMPLETE, this.onDeleteTracksComplete);
                handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.sendToDC(handler.UnitHandler.DELETE_TRACKS_ON_UNIT);
            }
            else 
            {
                this.comState.progressStatusStart = SEND_LOAD_HEADER_PERCENT + SEND_DELETE_ON_DEVICE_PERCENT;
                this.comState.progressStatusBase = SEND_UPLOAD_PERCENT;
                (handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.unit as core.units.interfaces.IDataToDecode).tracksToDecode = new Vector.<core.route.Route>();
                (handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.unit as core.units.interfaces.IDataToDecode).tracksToDecode.push(track);
                handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.addEventListener(handler.UnitHandler.SEND_TRACKS_TO_UNIT_COMPLETE, this.onTracksUploadComplete);
                handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.sendToDC(handler.UnitHandler.SEND_TRACKS_TO_UNIT);
            }
            return;
        }

        internal function onTracksHeaderDownloadComplete(arg1:flash.events.Event):void
        {
            this.comState.closeProgressPopUp();
            handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.removeEventListener(handler.UnitHandler.PLANED_TRACK_FILE_HEADER_COMPLETE, this.onTracksHeaderDownloadComplete);
            flash.utils.setTimeout(this.onDownloadHeader, 500);
            return;
        }

        internal function onDownloadHeader():void
        {
            var loc1:*=(handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.unit as core.units.interfaces.ITrackList).loadedTracks;
            handler.CommunicationHandling.getInstance().stopCommunication();
            if (loc1.length != 0) 
            {
                handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_DEVICE_TRACKS_SELECTOR, {"unit":unit, "download":true, "loadedTracks":loc1}, handler.ViewHandler.slideToLeftTransition());
            }
            else 
            {
                noDataOnDeviceInfo();
            }
            return;
        }

        internal function saveNextTrack():void
        {
            var loc1:*=100 * (this._tracksToSave - this.tracks.length) / this._tracksToSave;
            this.comState.updateProgressPopUp(loc1);
            if (this.tracks.length > 0) 
            {
                track = this.tracks.shift();
                track.isDeleted = false;
                track.modificationDate = new Date().time;
                handler.RouteHandler.getInstance().saveRoute(new backend.utils.dbUtils.DBUtilObject(track, this.onInsertDataComplete, onInsertDataError, null, true));
            }
            else 
            {
                handler.RouteHandler.getInstance().dispatchEvent(new frontend.screen.tracks.tabs.list.MyTracksListEvent(frontend.screen.tracks.tabs.list.MyTracksListEvent.RELOAD));
                handler.AppDeviceHandler.getInstance().dispatchEvent(new service.cloud.CloudEvent(service.cloud.CloudEvent.DATA_CHANGED));
                this.comState.closeProgressPopUp();
                this.goBackSwitch();
            }
            return;
        }

        protected override function onInsertDataComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            flash.utils.setTimeout(this.saveNextTrack, 500);
            return;
        }

        internal function onTracksHeaderDownloadForUploadComplete(arg1:flash.events.Event):void
        {
            var loc3:*=null;
            handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.removeEventListener(handler.UnitHandler.PLANED_TRACK_FILE_HEADER_COMPLETE, this.onTracksHeaderDownloadForUploadComplete);
            var loc1:*=0;
            var loc2:*=(handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.unit as core.units.interfaces.ITrackList).loadedTracks.length;
            this.loadHeader = false;
            (handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.unit as core.units.interfaces.IDataToDecode).tracksToDecode = new Vector.<core.route.Route>();
            loc1 = 0;
            while (loc1 < loc2) 
            {
                loc3 = (handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.unit as core.units.interfaces.ITrackList).loadedTracks.getItemAt(loc1) as core.route.Route;
                if (track.GUID == loc3.GUID) 
                {
                    track.downloadId = loc3.downloadId;
                    (handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.unit as core.units.interfaces.IDataToDecode).tracksToDecode.push(track);
                    break;
                }
                ++loc1;
            }
            this.deleteOnDevice = !(track.downloadId == "0");
            flash.utils.setTimeout(this.transferFunction, 500);
            return;
        }

        internal function onDeleteTracksComplete(arg1:flash.events.Event=null):void
        {
            handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.removeEventListener(handler.UnitHandler.DELETE_TRACKS_ON_UNIT_COMPLETE, this.onDeleteTracksComplete);
            this.comState.updateProgressPopUp(SEND_LOAD_HEADER_PERCENT + SEND_DELETE_ON_DEVICE_PERCENT);
            this.loadHeader = false;
            this.deleteOnDevice = false;
            flash.utils.setTimeout(this.transferFunction, 500);
            return;
        }

        internal function onTracksUploadComplete(arg1:flash.events.Event):void
        {
            this.comState.closeProgressPopUp();
            handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.removeEventListener(handler.UnitHandler.SEND_TRACKS_TO_UNIT_COMPLETE, this.onTracksUploadComplete);
            flash.utils.setTimeout(this.goBackSwitch, 500);
            return;
        }

        protected override function goBackSwitch():void
        {
            handler.CommunicationHandling.getInstance().stopCommunication();
            if (this._listStateHandler != null) 
            {
                this._listStateHandler.swapState();
            }
            if (transferModeDownload) 
            {
                if (this._numberOfDownloadedTracks != 1) 
                {
                    if (backScreenName == "") 
                    {
                        handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_TRACKS, {}, handler.ViewHandler.slideToRightTransition());
                    }
                    else 
                    {
                        handler.ViewHandler.getInstance().showScreen(backScreenName, {}, handler.ViewHandler.slideToRightTransition());
                    }
                }
                else 
                {
                    handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_TRACKS_TRACKDETAIL, {"myRoute":track}, handler.ViewHandler.slideToRightTransition());
                }
            }
            else 
            {
                handler.ViewHandler.getInstance().goBack();
            }
            return;
        }

        internal function _TracksTransfer_CommunicationState1_i():frontend.screen.component.devices.CommunicationState
        {
            var loc1:*=new frontend.screen.component.devices.CommunicationState();
            loc1.id = "comState";
            this.comState = loc1;
            feathers.binding.BindingManager.executeBindings(this, "comState", this.comState);
            return loc1;
        }

        internal function _TracksTransfer_Footer1_i():frontend.screen.component.Footer
        {
            var loc1:*=new frontend.screen.component.Footer();
            loc1.id = "footer";
            this.footer = loc1;
            feathers.binding.BindingManager.executeBindings(this, "footer", this.footer);
            return loc1;
        }

        public function ___TracksTransfer_TransferScreen1_addedToStage(arg1:starling.events.Event):void
        {
            this.onAddedToStage(arg1);
            return;
        }

        public function ___TracksTransfer_TransferScreen1_removedFromStage(arg1:starling.events.Event):void
        {
            this.onRemovedFromStage(arg1);
            return;
        }

        internal function _TracksTransfer_bindingsSetup():Array
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

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            TracksTransfer._watcherSetupUtil = arg1;
            return;
        }

        internal static const SEND_DELETE_ON_DEVICE_PERCENT:int=10;

        internal static const SEND_LOAD_HEADER_PERCENT:int=10;

        internal static const SEND_UPLOAD_PERCENT:int=80;

        internal var _trackList:frontend.components.list.CustomList;

        internal var _tracksDataProvider:feathers.data.ListCollection;

        internal var _tracksToSave:uint=0;

        internal var deleteOnDevice:Boolean=true;

        internal var _addDeviceTimeoutId:uint=0;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal var _625992816comState:frontend.screen.component.devices.CommunicationState;

        internal var _1268861541footer:frontend.screen.component.Footer;

        mx_internal var _bindings:Array;

        public var loadHeader:Boolean=true;

        public var tracks:__AS3__.vec.Vector.<core.route.Route>;

        public var tracksHeader:__AS3__.vec.Vector.<core.route.Route>;

        internal var _listStateHandler:frontend.components.list.ListStateHandler;

        internal var _numberOfDownloadedTracks:uint=0;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//  class TrainingsTransfer
package frontend.screen.mydevices.transfer 
{
    import __AS3__.vec.*;
    import core.units.interfaces.*;
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
    import frontend.screen.component.*;
    import frontend.screen.component.devices.*;
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
    
    public class TrainingsTransfer extends frontend.screen.mydevices.transfer.TransferScreen implements feathers.binding.IBindingClient
    {
        public function TrainingsTransfer()
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
            bindings = this._TrainingsTransfer_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_mydevices_transfer_TrainingsTransferWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return TrainingsTransfer[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.allowCaching = false;
            this.hasBackwardNavigation = true;
            this.saveAsOldScreen = false;
            this.mxmlContent = [this._TrainingsTransfer_CommunicationState1_i(), this._TrainingsTransfer_Footer1_i()];
            this.addEventListener("addedToStage", this.___TrainingsTransfer_TransferScreen1_addedToStage);
            this.addEventListener("removedFromStage", this.___TrainingsTransfer_TransferScreen1_removedFromStage);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        protected function onAddedToStage(arg1:starling.events.Event):void
        {
            this.comState.loading = true;
            this.comState.unitChangeable = false;
            setCallbacks(this.comState);
            init();
            return;
        }

        protected function onRemovedFromStage(arg1:starling.events.Event):void
        {
            destroy();
            return;
        }

        protected override function validateProperties():void
        {
            if (transferModeDownload) 
            {
                title = utils.LanguageManager.getString("DEVICEVIEW.DEVICE_TRAININGS_DOWNLOAD");
            }
            else 
            {
                title = utils.LanguageManager.getString("DEVICEVIEW.DEVICE_TRAININGS_SAVE");
            }
            this.comState.headline = title;
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
            super.transferFunction();
            if (transferModeDownload) 
            {
                this.comState.openProgressPopUp(utils.LanguageManager.getString("PROGRESS_POPUP.LOAD_TRAININGS_TITLE"), utils.LanguageManager.getString("PROGRESS_POPUP.LOAD_TRAININGS_TEXT"));
                handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.addEventListener(handler.UnitHandler.PROGRAM_LOADED_FROM_UNIT_COMPLETE, this.onTrainingsDownloadComplete);
                handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.loadFromDC(handler.UnitHandler.LOAD_PROGRAMS);
            }
            else 
            {
                if (!(handler.CommunicationHandling.getInstance().currentDevice as core.units.interfaces.ITrainingsList).supportMultipleTrainings) 
                {
                    this._loadForUpload = false;
                    this._deleteOnDevice = false;
                    this.comState.openProgressPopUp(utils.LanguageManager.getString("PROGRESS_POPUP.SAVE_TRAININGS_TITLE"), utils.LanguageManager.getString("PROGRESS_POPUP.SAVE_TRAININGS_TEXT"));
                }
                if (this._loadForUpload) 
                {
                    this.comState.openProgressPopUp(utils.LanguageManager.getString("PROGRESS_POPUP.SAVE_TRAININGS_TITLE"), utils.LanguageManager.getString("PROGRESS_POPUP.SAVE_TRAININGS_TEXT"));
                    handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.addEventListener(handler.UnitHandler.PROGRAM_LOADED_FROM_UNIT_COMPLETE, this.onTrainingsForUploadDownloadComplete);
                    handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.loadFromDC(handler.UnitHandler.LOAD_PROGRAMS);
                }
                else if (this._deleteOnDevice) 
                {
                    handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.addEventListener(handler.UnitHandler.DELETE_WORKOUTS_ON_UNIT_COMPLETE, this.onTrainingsDeleteComplete);
                    handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.sendToDC(handler.UnitHandler.DELETE_WORKOUTS_ON_UNIT);
                }
                else 
                {
                    handler.CommunicationHandling.getInstance().currentDevice.currentTrainingProgram = training;
                    handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.addEventListener(handler.UnitHandler.PROGRAM_SEND_TO_DEVICE_COMPLETE, this.onTrainingsUploadComplete);
                    handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.sendToDC(handler.UnitHandler.WRITE_PROGRAM_DATA_TO_DEVICE);
                }
            }
            return;
        }

        internal function onTrainingsDownloadComplete(arg1:flash.events.Event):void
        {
            this.comState.closeProgressPopUp();
            handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.removeEventListener(handler.UnitHandler.PROGRAM_LOADED_FROM_UNIT_COMPLETE, this.onTrainingsDownloadComplete);
            flash.utils.setTimeout(this.onDownload, 500);
            return;
        }

        internal function onDownload():void
        {
            var loc1:*=(handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.unit as core.units.interfaces.ITrainingsList).trainingsOnDeviceList;
            if (loc1.length != 0) 
            {
                handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_DEVICE_TRAININGS_SELECTOR, {"unit":unit, "download":true}, handler.ViewHandler.slideToLeftTransition());
            }
            else 
            {
                noDataOnDeviceInfo();
            }
            return;
        }

        internal function onTrainingsForUploadDownloadComplete(arg1:flash.events.Event):void
        {
            var loc1:*=0;
            handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.removeEventListener(handler.UnitHandler.PROGRAM_LOADED_FROM_UNIT_COMPLETE, this.onTrainingsForUploadDownloadComplete);
            this.trainings = (handler.CommunicationHandling.getInstance().currentDevice as core.units.interfaces.ITrainingsList).trainingsOnDeviceList;
            var loc2:*=this.trainings.length;
            if (this.trainings.length != 0) 
            {
                transferModeDownload = false;
                this._loadForUpload = false;
                this._deleteOnDevice = true;
                loc1 = 0;
                while (loc1 < this.trainings.length) 
                {
                    if (training.GUID == this.trainings[loc1].GUID) 
                    {
                        (handler.CommunicationHandling.getInstance().currentDevice as core.units.interfaces.ITrainingsList).trainingsToDelete.push(this.trainings[loc1]);
                    }
                    ++loc1;
                }
                this.transferFunction();
            }
            else 
            {
                this.onTrainingsDeleteComplete();
            }
            return;
        }

        internal function onTrainingsDeleteComplete(arg1:flash.events.Event=null):void
        {
            var loc1:*=0;
            handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.removeEventListener(handler.UnitHandler.PROGRAM_LOADED_FROM_UNIT_COMPLETE, this.onTrainingsForUploadDownloadComplete);
            this.trainings = (handler.CommunicationHandling.getInstance().currentDevice as core.units.interfaces.ITrainingsList).trainingsOnDeviceList;
            var loc2:*=this.trainings.length;
            transferModeDownload = false;
            this._loadForUpload = false;
            this._deleteOnDevice = false;
            if (training && training.unit == null && !(unit == null)) 
            {
                training.unit = unit;
            }
            if (unit && training) 
            {
                unit.currentTrainingProgram = training;
            }
            if (training == null && !(unit.currentTrainingProgram == null)) 
            {
                training = unit.currentTrainingProgram;
            }
            this.transferFunction();
            return;
        }

        internal function onTrainingsUploadComplete(arg1:flash.events.Event):void
        {
            this.comState.closeProgressPopUp();
            handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.removeEventListener(handler.UnitHandler.PROGRAM_SEND_TO_DEVICE_COMPLETE, this.onTrainingsUploadComplete);
            flash.utils.setTimeout(this.goBackSwitch, 500);
            return;
        }

        protected override function goBackSwitch():void
        {
            handler.CommunicationHandling.getInstance().stopCommunication();
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_DEVICE_TRAINING_PROGRAM, {"unit":unit}, handler.ViewHandler.slideToRightTransition());
            return;
        }

        internal function _TrainingsTransfer_CommunicationState1_i():frontend.screen.component.devices.CommunicationState
        {
            var loc1:*=new frontend.screen.component.devices.CommunicationState();
            loc1.id = "comState";
            this.comState = loc1;
            feathers.binding.BindingManager.executeBindings(this, "comState", this.comState);
            return loc1;
        }

        internal function _TrainingsTransfer_Footer1_i():frontend.screen.component.Footer
        {
            var loc1:*=new frontend.screen.component.Footer();
            loc1.id = "footer";
            this.footer = loc1;
            feathers.binding.BindingManager.executeBindings(this, "footer", this.footer);
            return loc1;
        }

        public function ___TrainingsTransfer_TransferScreen1_addedToStage(arg1:starling.events.Event):void
        {
            this.onAddedToStage(arg1);
            return;
        }

        public function ___TrainingsTransfer_TransferScreen1_removedFromStage(arg1:starling.events.Event):void
        {
            this.onRemovedFromStage(arg1);
            return;
        }

        internal function _TrainingsTransfer_bindingsSetup():Array
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
            TrainingsTransfer._watcherSetupUtil = arg1;
            return;
        }

        internal var _625992816comState:frontend.screen.component.devices.CommunicationState;

        internal var _1268861541footer:frontend.screen.component.Footer;

        public var trainings:__AS3__.vec.Vector.<core.training.Training>;

        internal var _deleteOnDevice:Boolean=true;

        internal var _loadForUpload:Boolean=true;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//  class TransferScreen
package frontend.screen.mydevices.transfer 
{
    import backend.utils.dbUtils.*;
    import core.activities.*;
    import core.gps.*;
    import core.route.*;
    import core.settings.*;
    import core.sportprofiles.*;
    import core.training.*;
    import core.units.*;
    import debug.*;
    import flash.utils.*;
    import frontend.components.popup.*;
    import frontend.screen.component.*;
    import frontend.screen.component.devices.*;
    import handler.*;
    import service.cloud.*;
    import starling.events.*;
    import utils.*;
    
    public class TransferScreen extends frontend.screen.component.CustomScreen
    {
        public function TransferScreen()
        {
            super();
            return;
        }

        protected function init(arg1:Boolean=true):void
        {
            handler.ViewHandler.getInstance().addBackFunction(this.backButtonFunction);
            handler.CommunicationHandling.getInstance().addEventListener(handler.CommunicationHandling.COMMUNICATION_ERROR, this.onCommunicationError);
            handler.CommunicationHandling.getInstance().addEventListener(handler.CommunicationHandling.COMMUNICATION_TIMEOUT, this.onCommunicationTimeout);
            handler.CommunicationHandling.getInstance().addEventListener(handler.CommunicationHandling.CURRENT_DEVICE_NOT_MATCH, this.onDeviceNotMatch);
            handler.CommunicationHandling.getInstance().communicationFunction = this.transferFunction;
            handler.CommunicationHandling.getInstance().currentDevice = this.unit;
            this.onDeviceChanged();
            return;
        }

        protected function addUnitChangeEventListener():void
        {
            handler.CommunicationHandling.getInstance().addEventListener(handler.CommunicationHandling.CURRENT_DEVICE_CHANGED, this.onDeviceChanged);
            return;
        }

        protected function setCallbacks(arg1:frontend.screen.component.devices.CommunicationState):void
        {
            this.errorCallback = arg1.onCommunicationErrorCallback;
            this.deviceNotMatchCallback = arg1.onDeviceNotMatchErrorCallback;
            this.timeoutCallback = arg1.onCommunicationTimeoutCallback;
            return;
        }

        protected function destroy():void
        {
            flash.utils.clearTimeout(this._noDataTimeout);
            flash.utils.clearTimeout(this._deviceNotMatchTimeout);
            flash.utils.clearTimeout(this._errorTimeout);
            flash.utils.clearTimeout(this._errorTimeoutTimeout);
            if (this._noDataPopUp) 
            {
                frontend.components.popup.PopUpBase.removePopUps(this._noDataPopUp);
                this._noDataPopUp = null;
            }
            if (this._deviceNotMatchPopUp) 
            {
                frontend.components.popup.PopUpBase.removePopUps(this._deviceNotMatchPopUp);
                this._deviceNotMatchPopUp = null;
            }
            if (this._errorPopUp) 
            {
                frontend.components.popup.PopUpBase.removePopUps(this._errorPopUp);
                this._errorPopUp = null;
            }
            if (this._errorTimeoutPopUp) 
            {
                frontend.components.popup.PopUpBase.removePopUps(this._errorTimeoutPopUp);
                this._errorTimeoutPopUp = null;
            }
            handler.ViewHandler.getInstance().removeBackFunction(this.backButtonFunction);
            handler.CommunicationHandling.getInstance().communicationFunction = null;
            handler.CommunicationHandling.getInstance().removeEventListener(handler.CommunicationHandling.COMMUNICATION_ERROR, this.onCommunicationError);
            handler.CommunicationHandling.getInstance().removeEventListener(handler.CommunicationHandling.COMMUNICATION_TIMEOUT, this.onCommunicationTimeout);
            handler.CommunicationHandling.getInstance().removeEventListener(handler.CommunicationHandling.CURRENT_DEVICE_CHANGED, this.onDeviceChanged);
            handler.CommunicationHandling.getInstance().removeEventListener(handler.CommunicationHandling.CURRENT_DEVICE_NOT_MATCH, this.onDeviceNotMatch);
            return;
        }

        protected function backButtonFunction():void
        {
            handler.CommunicationHandling.getInstance().stopCommunication();
            this.goBackSwitch();
            return;
        }

        protected function onDeviceChanged(arg1:starling.events.Event=null):void
        {
            this.unit = handler.CommunicationHandling.getInstance().currentDevice;
            handler.CommunicationHandling.getInstance().stopCommunication();
            handler.CommunicationHandling.getInstance().initCurrentDeviceCommunication();
            return;
        }

        protected function transferFunction():void
        {
            handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler = handler.HandlerFactory.getImplementation(handler.CommunicationHandling.getInstance().currentDevice) as handler.UnitHandler;
            if (handler.DeviceCommunicationHandlerLink.getInstance().currentDSHandler) 
            {
                handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.port = handler.DeviceCommunicationHandlerLink.getInstance().currentDSHandler.port;
            }
            return;
        }

        protected function onInsertDataError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("onInsertDataError: " + arg1.toString());
            return;
        }

        protected function onInsertDataComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            handler.AppDeviceHandler.getInstance().dispatchEvent(new service.cloud.CloudEvent(service.cloud.CloudEvent.DATA_CHANGED));
            this.goBackSwitch();
            return;
        }

        protected function goBackSwitch():void
        {
            return;
        }

        protected function noDataOnDeviceInfo():void
        {
            handler.CommunicationHandling.getInstance().stopCommunication();
            this._noDataPopUp = new frontend.components.popup.InfoPopUp(false, false);
            this._noDataPopUp.headline = title;
            this._noDataPopUp.text = utils.LanguageManager.getString("DEVICE_NORESULT_TEXT");
            frontend.components.popup.PopUpBase.showModalPopUp(this._noDataPopUp);
            this._noDataTimeout = flash.utils.setTimeout(this.goBackSwitch, 1500);
            return;
        }

        protected function noGhostRaceSuppoertedInfo():void
        {
            handler.CommunicationHandling.getInstance().stopCommunication();
            this._noDataPopUp = new frontend.components.popup.InfoPopUp(false, false);
            this._noDataPopUp.headline = title;
            this._noDataPopUp.text = utils.LanguageManager.getString("DEVICE_NO_GHOSTRACE_SUPPORTED");
            frontend.components.popup.PopUpBase.showModalPopUp(this._noDataPopUp);
            this._noDataTimeout = flash.utils.setTimeout(this.goBackSwitch, 1500);
            return;
        }

        public function get unit():core.units.Unit
        {
            return this._unit;
        }

        public function set unit(arg1:core.units.Unit):void
        {
            this._unit = arg1;
            return;
        }

        protected function onDeviceNotMatch(arg1:starling.events.Event):void
        {
            if (this._deviceNotMatchPopUp) 
            {
                return;
            }
            this._deviceNotMatchPopUp = new frontend.components.popup.InfoPopUp(true, false, this.onDeviceNotMatchOk);
            this._deviceNotMatchPopUp.headline = utils.LanguageManager.getString("INFO_POPUP.DEVICE_DO_NOT_MATCH_TITLE");
            this._deviceNotMatchPopUp.text = utils.LanguageManager.getString("INFO_POPUP.DEVICE_DO_NOT_MATCH_TEXT");
            frontend.components.popup.PopUpBase.showModalPopUp(this._deviceNotMatchPopUp);
            return;
        }

        internal function onDeviceNotMatchOk(arg1:frontend.components.popup.InfoPopUp):void
        {
            frontend.components.popup.PopUpBase.removePopUps(this._deviceNotMatchPopUp);
            this._deviceNotMatchPopUp = null;
            this._deviceNotMatchTimeout = flash.utils.setTimeout(this.goBackSwitch, 300);
            if (this.deviceNotMatchCallback != null) 
            {
                this.deviceNotMatchCallback();
            }
            return;
        }

        protected function onCommunicationError(arg1:starling.events.Event):void
        {
            if (this._errorPopUp) 
            {
                return;
            }
            handler.CommunicationHandling.getInstance().stopCommunication();
            this._errorPopUp = new frontend.components.popup.InfoPopUp(true, false, this.onErrorOk);
            this._errorPopUp.headline = utils.LanguageManager.getString("INFO_POPUP.DEVICE_TRANSFER_ERROR_TITLE");
            this._errorPopUp.text = utils.LanguageManager.getString("INFO_POPUP.DEVICE_TRANSFER_ERROR_TEXT");
            frontend.components.popup.PopUpBase.showModalPopUp(this._errorPopUp);
            return;
        }

        protected function onErrorOk(arg1:frontend.components.popup.InfoPopUp):void
        {
            frontend.components.popup.PopUpBase.removePopUps(this._errorPopUp);
            this._errorPopUp = null;
            this._errorTimeout = flash.utils.setTimeout(this.goBackSwitch, 300);
            if (this.errorCallback != null) 
            {
                this.errorCallback();
            }
            return;
        }

        protected function onCommunicationTimeout(arg1:starling.events.Event):void
        {
            if (this._errorTimeoutPopUp) 
            {
                return;
            }
            handler.CommunicationHandling.getInstance().stopCommunication();
            this._errorTimeoutPopUp = new frontend.components.popup.InfoPopUp(true, false, this.onTimeoutOk);
            this._errorTimeoutPopUp.headline = utils.LanguageManager.getString("INFO_POPUP.DEVICE_TRANSFER_TIMEOUT_TITLE");
            this._errorTimeoutPopUp.text = utils.LanguageManager.getString("INFO_POPUP.DEVICE_TRANSFER_TIMEOUT_TEXT");
            frontend.components.popup.PopUpBase.showModalPopUp(this._errorTimeoutPopUp);
            return;
        }

        protected function onTimeoutOk(arg1:frontend.components.popup.InfoPopUp):void
        {
            frontend.components.popup.PopUpBase.removePopUps(this._errorTimeoutPopUp);
            this._errorTimeoutPopUp = null;
            this._errorTimeoutTimeout = flash.utils.setTimeout(this.goBackSwitch, 300);
            if (this.timeoutCallback != null) 
            {
                this.timeoutCallback();
            }
            return;
        }

        public var activity:core.activities.Activity;

        public var backScreenName:String="";

        public var deviceNotMatchCallback:Function;

        public var errorCallback:Function;

        public var pointNavigation:core.gps.PointNavigation;

        public var settings:core.settings.Settings;

        public var sportprofile:core.sportprofiles.Sportprofile;

        public var timeoutCallback:Function;

        public var track:core.route.Route;

        public var training:core.training.Training;

        public var transferModeDownload:Boolean=true;

        internal var _unit:core.units.Unit;

        internal var _deviceNotMatchPopUp:frontend.components.popup.InfoPopUp;

        internal var _deviceNotMatchTimeout:uint=0;

        internal var _errorPopUp:frontend.components.popup.InfoPopUp;

        internal var _errorTimeout:uint=0;

        internal var _errorTimeoutPopUp:frontend.components.popup.InfoPopUp;

        internal var _noDataTimeout:uint=0;

        internal var _noDataPopUp:frontend.components.popup.InfoPopUp;

        internal var _errorTimeoutTimeout:uint=0;
    }
}


