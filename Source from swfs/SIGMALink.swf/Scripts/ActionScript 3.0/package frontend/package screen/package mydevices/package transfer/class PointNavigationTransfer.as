//class PointNavigationTransfer
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


