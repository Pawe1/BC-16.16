//class AddNewDeviceComponent
package frontend.screen.mydevices.components 
{
    import backend.utils.dbUtils.*;
    import core.units.*;
    import debug.*;
    import feathers.binding.*;
    import feathers.controls.*;
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
    import frontend.components.popup.*;
    import frontend.screen.component.devices.*;
    import handler.*;
    import handler.dockingstation.*;
    import handler.event.*;
    import mx.core.*;
    import service.*;
    import service.cloud.*;
    import starling.animation.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    import utils.*;
    
    use namespace mx_internal;
    
    public class AddNewDeviceComponent extends feathers.controls.LayoutGroup implements feathers.binding.IBindingClient
    {
        public function AddNewDeviceComponent()
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
            bindings = this._AddNewDeviceComponent_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_mydevices_components_AddNewDeviceComponentWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return AddNewDeviceComponent[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.mxmlContent = [this._AddNewDeviceComponent_CommunicationState1_i()];
            this.addEventListener("addedToStage", this.___AddNewDeviceComponent_LayoutGroup1_addedToStage);
            this.addEventListener("removedFromStage", this.___AddNewDeviceComponent_LayoutGroup1_removedFromStage);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        internal function onInsertUnitError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("onInsertUnitError: " + arg1.toString());
            return;
        }

        internal function _AddNewDeviceComponent_CommunicationState1_i():frontend.screen.component.devices.CommunicationState
        {
            var loc1:*=new frontend.screen.component.devices.CommunicationState();
            loc1.id = "comState";
            this.comState = loc1;
            feathers.binding.BindingManager.executeBindings(this, "comState", this.comState);
            return loc1;
        }

        public function ___AddNewDeviceComponent_LayoutGroup1_addedToStage(arg1:starling.events.Event):void
        {
            this.onAddedToStage(arg1);
            return;
        }

        public override function set height(arg1:Number):void
        {
            super.height = arg1;
            this.comState.height = height;
            return;
        }

        public function ___AddNewDeviceComponent_LayoutGroup1_removedFromStage(arg1:starling.events.Event):void
        {
            this.onRemovedFromStage(arg1);
            return;
        }

        protected function onTimeoutOk(arg1:frontend.components.popup.InfoPopUp):void
        {
            frontend.components.popup.PopUpBase.removePopUps(this._errorTimeoutPopUp);
            this._errorTimeoutPopUp = null;
            this._errorTimeoutTimeout = flash.utils.setTimeout(this.backButtonFunction, 300);
            this.comState.onProgressPopUpClosed = this.backButtonFunction;
            this.comState.onCommunicationTimeoutCallback();
            return;
        }

        public function set useSmallLayout(arg1:Boolean):void
        {
            this.comState.height = height;
            this.comState.useSmallLayout = arg1;
            return;
        }

        internal function _AddNewDeviceComponent_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight;
            }, null, "this.height")
            result[1] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "this.width")
            result[2] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight;
            }, null, "comState.height")
            return result;
        }

        public function get comState():frontend.screen.component.devices.CommunicationState
        {
            return this._625992816comState;
        }

        public function get unit():core.units.Unit
        {
            return this._3594628unit;
        }

        public function set unit(arg1:core.units.Unit):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._3594628unit;
            if (loc1 !== arg1) 
            {
                this._3594628unit = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "unit", loc1, arg1, this);
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
            AddNewDeviceComponent._watcherSetupUtil = arg1;
            return;
        }

        
        {
            deviceAdded = false;
        }

        protected function onAddedToStage(arg1:starling.events.Event):void
        {
            if (this.deviceAddetCallback == null) 
            {
                return;
            }
            handler.ViewHandler.getInstance().addBackFunction(this.backButtonFunction);
            handler.CommunicationHandling.getInstance().addEventListener(handler.CommunicationHandling.CURRENT_DEVICE_NOT_MATCH, this.onDeviceNotMatch);
            handler.CommunicationHandling.getInstance().addEventListener(handler.CommunicationHandling.CURRENT_DEVICE_CHANGED, this.onDeviceChanged);
            handler.CommunicationHandling.getInstance().communicationFunction = this.loadUnitInformation;
            this.comState.loading = false;
            this.comState.unitChangeable = false;
            if (this.unit) 
            {
                handler.CommunicationHandling.getInstance().currentDevice = this.unit;
            }
            return;
        }

        protected function onDeviceChanged(arg1:starling.events.Event=null):void
        {
            this.comState.loading = true;
            handler.CommunicationHandling.getInstance().addEventListener(handler.CommunicationHandling.COMMUNICATION_ERROR, this.onCommunicationError);
            handler.CommunicationHandling.getInstance().addEventListener(handler.CommunicationHandling.COMMUNICATION_TIMEOUT, this.onCommunicationTimeout);
            handler.CommunicationHandling.getInstance().stopCommunication();
            handler.CommunicationHandling.getInstance().initCurrentDeviceCommunication(true);
            this.comState.showUnitState(handler.CommunicationHandling.getInstance().currentDevice);
            return;
        }

        protected function onRemovedFromStage(arg1:starling.events.Event):void
        {
            this.destroy();
            handler.ViewHandler.getInstance().removeBackFunction(this.backButtonFunction);
            return;
        }

        internal function destroy():void
        {
            this.deviceExistsCallback = null;
            this.deviceAddetCallback = null;
            flash.utils.clearTimeout(this._deviceNotMatchTimeout);
            flash.utils.clearTimeout(this._errorTimeout);
            flash.utils.clearTimeout(this._errorTimeoutTimeout);
            handler.CommunicationHandling.getInstance().removeEventListener(handler.CommunicationHandling.COMMUNICATION_ERROR, this.onCommunicationError);
            handler.CommunicationHandling.getInstance().removeEventListener(handler.CommunicationHandling.COMMUNICATION_TIMEOUT, this.onCommunicationTimeout);
            handler.CommunicationHandling.getInstance().removeEventListener(handler.CommunicationHandling.CURRENT_DEVICE_NOT_MATCH, this.onDeviceNotMatch);
            handler.CommunicationHandling.getInstance().removeEventListener(handler.CommunicationHandling.CURRENT_DEVICE_CHANGED, this.onDeviceChanged);
            handler.CommunicationHandling.getInstance().communicationFunction = null;
            return;
        }

        internal function backButtonFunction():void
        {
            handler.CommunicationHandling.getInstance().stopCommunication();
            handler.ViewHandler.getInstance().goBack();
            return;
        }

        protected function onDeviceNotMatch(arg1:starling.events.Event):void
        {
            this._deviceNotMatchPopUp = new frontend.components.popup.InfoPopUp(true, false, this.onDeviceNotMatchOk);
            this._deviceNotMatchPopUp.headline = utils.LanguageManager.getString("INFO_POPUP.DEVICE_DO_NOT_MATCH_TITLE");
            this._deviceNotMatchPopUp.text = utils.LanguageManager.getString("INFO_POPUP.DEVICE_DO_NOT_MATCH_TEXT");
            frontend.components.popup.PopUpBase.showModalPopUp(this._deviceNotMatchPopUp);
            return;
        }

        internal function onDeviceNotMatchOk(arg1:frontend.components.popup.InfoPopUp):void
        {
            handler.CommunicationHandling.getInstance().stopCommunication();
            this.comState.onProgressPopUpClosed = null;
            frontend.components.popup.PopUpBase.removePopUps(this._deviceNotMatchPopUp);
            this._deviceNotMatchPopUp = null;
            return;
        }

        protected function onCommunicationError(arg1:starling.events.Event):void
        {
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
            this._errorTimeout = flash.utils.setTimeout(this.backButtonFunction, 300);
            this.comState.onProgressPopUpClosed = this.backButtonFunction;
            this.comState.onCommunicationErrorCallback();
            return;
        }

        protected function onCommunicationTimeout(arg1:starling.events.Event):void
        {
            this._errorTimeoutPopUp = new frontend.components.popup.InfoPopUp(true, false, this.onTimeoutOk);
            this._errorTimeoutPopUp.headline = utils.LanguageManager.getString("INFO_POPUP.DEVICE_TRANSFER_TIMEOUT_TITLE");
            this._errorTimeoutPopUp.text = utils.LanguageManager.getString("INFO_POPUP.DEVICE_TRANSFER_TIMEOUT_TEXT");
            frontend.components.popup.PopUpBase.showModalPopUp(this._errorTimeoutPopUp);
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

        internal function loadUnitInformation():void
        {
            if (handler.DeviceCommunicationHandlerLink.getInstance().connectionMode == service.DeviceCommunicationHandler.CONNECTION_MODE_USB) 
            {
                if (handler.CommunicationHandling.getInstance().currentUSBEvent) 
                {
                    this.comState.openProgressPopUp(utils.LanguageManager.getString("PROGRESS_POPUP.LOAD_UNIT_INFORMATION_TITLE"), utils.LanguageManager.getString("PROGRESS_POPUP.LOAD_UNIT_INFORMATION_TEXT"));
                    flash.utils.setTimeout(this.onInfoLoadedComplete, 500, handler.CommunicationHandling.getInstance().currentUSBEvent);
                }
                return;
            }
            this.comState.openProgressPopUp(utils.LanguageManager.getString("PROGRESS_POPUP.LOAD_UNIT_INFORMATION_TITLE"), utils.LanguageManager.getString("PROGRESS_POPUP.LOAD_UNIT_INFORMATION_TEXT"));
            if (handler.DeviceCommunicationHandlerLink.getInstance().connectionMode != service.DeviceCommunicationHandler.CONNECTION_MODE_NFC) 
            {
                if (handler.DeviceCommunicationHandlerLink.getInstance().connectionMode == service.DeviceCommunicationHandler.CONNECTION_MODE_BLE) 
                {
                    handler.DeviceCommunicationHandlerLink.getInstance().currentDSHandler.addEventListener(handler.dockingstation.DockingStationHandler.UNIT_INITIALISED_EVENT, this.onInfoLoadedComplete);
                    handler.DeviceCommunicationHandlerLink.getInstance().currentDSHandler.loadFromDC(handler.dockingstation.DockingStationHandler.LOAD_UNIT_INFORMATION);
                }
            }
            else 
            {
                handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler = handler.HandlerFactory.getImplementation(handler.CommunicationHandling.getInstance().currentDevice) as handler.UnitHandler;
                handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.addEventListener(handler.dockingstation.DockingStationHandler.UNIT_INITIALISED_EVENT, this.onInfoLoadedComplete);
                handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.loadFromDC(handler.dockingstation.DockingStationHandler.LOAD_UNIT_INFORMATION);
            }
            return;
        }

        internal function onInfoLoadedComplete(arg1:handler.event.UnitEvent):void
        {
            this.comState.closeProgressPopUp();
            if (handler.DeviceCommunicationHandlerLink.getInstance().connectionMode != service.DeviceCommunicationHandler.CONNECTION_MODE_NFC) 
            {
                if (handler.DeviceCommunicationHandlerLink.getInstance().connectionMode == service.DeviceCommunicationHandler.CONNECTION_MODE_BLE) 
                {
                    handler.DeviceCommunicationHandlerLink.getInstance().currentDSHandler.removeEventListener(handler.dockingstation.DockingStationHandler.UNIT_INITIALISED_EVENT, this.onInfoLoadedComplete);
                }
            }
            else 
            {
                handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.removeEventListener(handler.dockingstation.DockingStationHandler.UNIT_INITIALISED_EVENT, this.onInfoLoadedComplete);
            }
            handler.DeviceCommunicationHandlerLink.getInstance().getUnitBySerialNumberAndType(arg1.unit.serialNumber, arg1.unit.type, this.unitChecked, arg1.unit);
            return;
        }

        internal function unitChecked(arg1:core.units.Unit, arg2:Object):void
        {
            if (this.repairUnit) 
            {
                if (arg1 == null || arg1 && arg1.serialNumber == (arg2 as core.units.Unit).serialNumber) 
                {
                    this.unit.serialNumber = (arg2 as core.units.Unit).serialNumber;
                    this.unit.softwareRevision = (arg2 as core.units.Unit).softwareRevision;
                    handler.CommunicationHandling.getInstance().currentDevice.GUID = this.unit.GUID;
                    handler.CommunicationHandling.getInstance().currentDevice.serialNumber = this.unit.serialNumber;
                    handler.CommunicationHandling.getInstance().currentDevice.softwareRevision = this.unit.softwareRevision;
                    handler.CommunicationHandling.getInstance().currentDevice.modificationDate = new Date().time;
                    handler.CommunicationHandling.getInstance().reloadSavedDevicesFlag = true;
                    handler.AppDeviceHandler.getInstance().saveUnit(new backend.utils.dbUtils.DBUtilObject(this.unit, this.onInsertUnitComplete, this.onInsertUnitError, null));
                }
                else 
                {
                    this.showDeviceExistsPopUp();
                }
            }
            else if (arg1 != null) 
            {
                this.showDeviceExistsPopUp();
            }
            else 
            {
                this.unit = arg2 as core.units.Unit;
                if (this.unit.GUID == "" || this.unit.GUID == null) 
                {
                    this.unit.GUID = utils.GUID.create();
                }
                if (this.unit.modificationDate == 0) 
                {
                    this.unit.modificationDate = new Date().time;
                }
                handler.CommunicationHandling.getInstance().currentDevice.GUID = this.unit.GUID;
                handler.CommunicationHandling.getInstance().currentDevice.serialNumber = this.unit.serialNumber;
                handler.CommunicationHandling.getInstance().currentDevice.modificationDate = new Date().time;
                handler.CommunicationHandling.getInstance().reloadSavedDevicesFlag = true;
                handler.AppDeviceHandler.getInstance().saveUnit(new backend.utils.dbUtils.DBUtilObject(this.unit, this.onInsertUnitComplete, this.onInsertUnitError, null));
            }
            return;
        }

        internal function showDeviceExistsPopUp():void
        {
            var loc1:*=new frontend.components.popup.InfoPopUp(true, false, this.onDeviceExistsInfoClosed, this.onDeviceExistsInfoClosed);
            loc1.headline = utils.LanguageManager.getString("INFO_POPUP.DEVICE_EXISTS_TITLE");
            loc1.text = utils.LanguageManager.getString("INFO_POPUP.DEVICE_EXISTS_TEXT");
            frontend.components.popup.PopUpBase.showModalPopUp(loc1);
            return;
        }

        internal function onDeviceExistsInfoClosed(arg1:frontend.components.popup.InfoPopUp):void
        {
            frontend.components.popup.PopUpBase.removePopUps(arg1);
            handler.CommunicationHandling.getInstance().stopCommunication();
            if (this.deviceExistsCallback != null) 
            {
                this.deviceExistsCallback();
            }
            return;
        }

        internal function onInsertUnitComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            handler.AppDeviceHandler.getInstance().dispatchEvent(new frontend.screen.component.devices.DeviceListEvent(frontend.screen.component.devices.DeviceListEvent.RELOAD));
            handler.AppDeviceHandler.getInstance().dispatchEvent(new service.cloud.CloudEvent(service.cloud.CloudEvent.DATA_CHANGED));
            this.comState.onProgressPopUpClosed = null;
            this.comState.closeProgressPopUp();
            this.deviceAddetCallback();
            this.destroy();
            return;
        }

        internal var _625992816comState:frontend.screen.component.devices.CommunicationState;

        public var deviceAddetCallback:Function;

        public var deviceExistsCallback:Function;

        public var repairUnit:Boolean=false;

        internal var _deviceNotMatchPopUp:frontend.components.popup.InfoPopUp;

        internal var _deviceNotMatchTimeout:uint=0;

        internal var _errorPopUp:frontend.components.popup.InfoPopUp;

        internal var _errorTimeout:uint=0;

        internal var _errorTimeoutPopUp:frontend.components.popup.InfoPopUp;

        internal var _errorTimeoutTimeout:uint=0;

        internal var _3594628unit:core.units.Unit;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        internal static var deviceAdded:Boolean=false;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;

        mx_internal var _bindings:Array;
    }
}


