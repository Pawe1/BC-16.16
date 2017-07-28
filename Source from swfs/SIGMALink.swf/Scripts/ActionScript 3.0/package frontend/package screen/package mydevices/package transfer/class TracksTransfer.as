//class TracksTransfer
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


