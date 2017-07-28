//class StravaSegmentsTransfer
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


