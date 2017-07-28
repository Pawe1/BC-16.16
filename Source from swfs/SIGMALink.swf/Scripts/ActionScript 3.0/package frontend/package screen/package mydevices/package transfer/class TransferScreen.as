//class TransferScreen
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


