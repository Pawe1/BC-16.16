//class TrackDetail
package frontend.screen.tracks.tabs.track 
{
    import __AS3__.vec.*;
    import backend.utils.dbUtils.*;
    import core.route.*;
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
    import frontend.*;
    import frontend.components.button.*;
    import frontend.components.map.*;
    import frontend.components.popup.*;
    import frontend.components.tab.*;
    import frontend.components.tabbarbase.*;
    import frontend.screen.component.*;
    import frontend.screen.tracks.tabs.list.*;
    import frontend.screen.tracks.tabs.track.tabs.*;
    import handler.*;
    import helper.*;
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
    
    public class TrackDetail extends frontend.screen.component.CustomScreen implements feathers.binding.IBindingClient
    {
        public function TrackDetail()
        {
            var bindings:Array;
            var watchers:Array;
            var target:Object;
            var i:uint;
            var watcherSetupUtilClass:Object;

            var loc1:*;
            target = null;
            watcherSetupUtilClass = null;
            this.buttonGroup = new Vector.<frontend.components.button.IconButton>();
            this.mx_internal::_bindings = [];
            this.mx_internal::_watchers = [];
            this.mx_internal::_bindingsByDestination = {};
            this.mx_internal::_bindingsBeginWithWord = {};
            super();
            bindings = this._TrackDetail_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_tracks_tabs_track_TrackDetailWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return TrackDetail[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.allowCaching = true;
            this.hasBackwardNavigation = true;
            this.mxmlContent = [this._TrackDetail_TabContainer1_i(), this._TrackDetail_Footer1_i()];
            this.addEventListener("initialize", this.___TrackDetail_CustomScreen1_initialize);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        internal function onDeleteTrackError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("Track konnte nicht gelöscht werden.");
            return;
        }

        internal function _TrackDetail_TabContainer1_i():frontend.components.tab.TabContainer
        {
            var loc1:*=new frontend.components.tab.TabContainer();
            loc1.useIconTabs = false;
            loc1.addEventListener("tabChanged", this.__detailsTabbar_tabChanged);
            loc1.id = "detailsTabbar";
            this.detailsTabbar = loc1;
            feathers.binding.BindingManager.executeBindings(this, "detailsTabbar", this.detailsTabbar);
            return loc1;
        }

        public function __detailsTabbar_tabChanged(arg1:frontend.components.tab.TabEvent):void
        {
            this.onTabChanged(arg1);
            return;
        }

        public function get myRoute():core.route.Route
        {
            return this._myRoute;
        }

        internal function set _1496932349myRoute(arg1:core.route.Route):void
        {
            this._myRoute = arg1;
            return;
        }

        internal function downloadTrackHandler(arg1:starling.events.TouchEvent):void
        {
            this.myRoute.modificationDate = new Date().time;
            this.myRoute.loadedFrom = core.route.Route.LOADED_FROM_DATABASE;
            var loc1:*=new backend.utils.dbUtils.DBUtilObject(this.myRoute, this.saveRouteComplete, this.saveRouteError, null, true);
            handler.RouteHandler.getInstance().saveRoute(loc1);
            this.validateFooter();
            return;
        }

        internal function _TrackDetail_Footer1_i():frontend.screen.component.Footer
        {
            var loc1:*=new frontend.screen.component.Footer();
            loc1.id = "footer";
            this.footer = loc1;
            feathers.binding.BindingManager.executeBindings(this, "footer", this.footer);
            return loc1;
        }

        public function ___TrackDetail_CustomScreen1_initialize(arg1:starling.events.Event):void
        {
            this.onInit(arg1);
            return;
        }

        internal function _TrackDetail_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("TRACKS.TITLE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.title")
            result[1] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight;
            }, null, "detailsTabbar.height")
            result[2] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "detailsTabbar.width")
            return result;
        }

        public function set detailsTabbar(arg1:frontend.components.tab.TabContainer):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._923974976detailsTabbar;
            if (loc1 !== arg1) 
            {
                this._923974976detailsTabbar = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "detailsTabbar", loc1, arg1, this);
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

        public function set myRoute(arg1:core.route.Route):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.myRoute;
            if (loc1 !== arg1) 
            {
                this._1496932349myRoute = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "myRoute", loc1, arg1, this);
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
            TrackDetail._watcherSetupUtil = arg1;
            return;
        }

        internal function onInit(arg1:starling.events.Event):void
        {
            this.buttonNavigateTo = new frontend.components.button.IconButton();
            this.buttonNavigateTo.image = frontend.Textures.mapsicon;
            this.buttonNavigateTo.touchHandler = this.navigateToTrack;
            this.buttonUpload = new frontend.components.button.IconButton();
            this.buttonUpload.image = frontend.Textures.uploadicon;
            this.buttonUpload.touchHandler = this.uploadTrack;
            this.buttonDelete = new frontend.components.button.IconButton();
            this.buttonDelete.image = frontend.Textures.trashicon;
            this.buttonDelete.touchHandler = this.deleteTrackHandler;
            this.buttonDownload = new frontend.components.button.IconButton();
            this.buttonDownload.image = frontend.Textures.downloadbutton;
            this.buttonDownload.touchHandler = this.downloadTrackHandler;
            return;
        }

        protected override function validateProperties():void
        {
            var loc1:*=null;
            if (this.trackMap) 
            {
                this.detailsTabbar.tabbar.selectedIndex = 0;
            }
            else 
            {
                this.validateTabs();
            }
            this.validateFooter();
            title = this.myRoute.name;
            if (handler.ViewHandler.getInstance().navigator.isTransitionActive) 
            {
                debug.Debug.debug("validateProperties later...");
                flash.utils.setTimeout(this.validateProperties, 100);
                return;
            }
            if (this.myRoute.loadedFrom != core.route.Route.LOADED_FROM_DATABASE) 
            {
                this.trackInfo.myRoute = this.myRoute;
                this.trackMap.myRoute = this.myRoute;
            }
            else 
            {
                loc1 = handler.RouteHandler.getInstance().generateLoadOptions(this.myRoute.routeId);
                backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, loc1, this.loadRouteOptionsComplete, this.onLoadRouteError, Workers.worker_DatabaseWorker);
            }
            return;
        }

        internal function loadRouteOptionsComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            handler.RouteHandler.getInstance().loadRouteOptionsComplete(arg1.getResult(), this.myRoute);
            this.trackInfo.myRoute = this.myRoute;
            this.trackMap.myRoute = this.myRoute;
            return;
        }

        internal function onLoadRouteError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("onLoadRouteError");
            return;
        }

        internal function validateTabs():void
        {
            this.trackMap = new frontend.screen.tracks.tabs.track.tabs.TracksMap();
            this.trackMap.mapView.addEventListener(frontend.components.map.MapView.MAP_LOCK_CHANGED, this.onMapLockChanged);
            this.detailsTabbar.addTab(this.trackMap, true);
            this.trackInfo = new frontend.screen.tracks.tabs.track.tabs.TracksInformation();
            this.detailsTabbar.addTab(this.trackInfo);
            return;
        }

        internal function onMapLockChanged(arg1:starling.events.Event):void
        {
            if (this.trackMap.mapView.mapLockActivated) 
            {
                this.detailsTabbar.customScroller.horizontalScrollPolicy = feathers.controls.Scroller.SCROLL_POLICY_ON;
            }
            else 
            {
                this.detailsTabbar.customScroller.horizontalScrollPolicy = feathers.controls.Scroller.SCROLL_POLICY_OFF;
            }
            return;
        }

        internal function onContentLoadedCallback():void
        {
            if (this.trackMap) 
            {
                this.trackMap.showContent();
            }
            return;
        }

        internal function onTabChanged(arg1:frontend.components.tab.TabEvent):void
        {
            this.selectedTab = arg1.instance;
            var loc1:*=this.selectedTab;
            switch (loc1) 
            {
                case this.trackInfo:
                {
                    if (this.trackMap) 
                    {
                        this.trackMap.mapView.mapLockActivated = true;
                    }
                    break;
                }
                case this.trackMap:
                {
                    break;
                }
            }
            this.validateFooter();
            return;
        }

        internal function validateFooter():void
        {
            var loc1:*=this.selectedTab;
            switch (loc1) 
            {
                case this.trackInfo:
                {
                    this.setInfoFooterButtons();
                    break;
                }
                case this.trackMap:
                {
                    this.setMapFooterButtons();
                    break;
                }
            }
            return;
        }

        internal function setInfoFooterButtons():void
        {
            this.buttonGroup = new Vector.<frontend.components.button.IconButton>();
            if (this.myRoute.loadedFrom != core.route.Route.LOADED_FROM_DATABASE) 
            {
                this.buttonGroup.push(this.buttonDownload);
            }
            else 
            {
                this.buttonGroup.push(this.buttonUpload);
                this.buttonGroup.push(this.buttonNavigateTo);
                this.buttonGroup.push(this.buttonDelete);
            }
            this.footer.setButtonGroup(this.buttonGroup);
            return;
        }

        internal function setMapFooterButtons():void
        {
            this.buttonGroup = new Vector.<frontend.components.button.IconButton>();
            if (this.myRoute.loadedFrom != core.route.Route.LOADED_FROM_DATABASE) 
            {
                this.buttonGroup.push(this.buttonDownload);
            }
            else 
            {
                this.buttonGroup.push(this.buttonUpload);
                this.buttonGroup.push(this.buttonNavigateTo);
                this.buttonGroup.push(this.buttonDelete);
            }
            this.footer.setButtonGroup(this.buttonGroup);
            return;
        }

        public function get detailsTabbar():frontend.components.tab.TabContainer
        {
            return this._923974976detailsTabbar;
        }

        internal function uploadTrack(arg1:starling.events.TouchEvent):void
        {
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_TRACKS_TRANSFER, {"transferModeDownload":false, "track":this.myRoute}, handler.ViewHandler.slideToLeftTransition());
            return;
        }

        internal function navigateToTrack(arg1:starling.events.TouchEvent):void
        {
            var loc1:*=null;
            if (helper.Capabilities_helper.isAndroid()) 
            {
                loc1 = "http://maps.google.com/maps?daddr=" + this.myRoute.latitudeStart + "," + this.myRoute.longitudeStart;
            }
            else 
            {
                loc1 = "http://maps.apple.com/maps?saddr=Current%20Location&daddr=" + this.myRoute.latitudeStart + "," + this.myRoute.longitudeStart;
            }
            flash.net.navigateToURL(new flash.net.URLRequest(loc1), "_blank");
            return;
        }

        internal function saveRouteComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.debug("route changed...");
            handler.RouteHandler.getInstance().dispatchEvent(new frontend.screen.tracks.tabs.list.MyTracksListEvent(frontend.screen.tracks.tabs.list.MyTracksListEvent.RELOAD));
            handler.RouteHandler.getInstance().dispatchEvent(new service.cloud.CloudEvent(service.cloud.CloudEvent.DATA_CHANGED));
            return;
        }

        internal function saveRouteError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("saveRouteError");
            return;
        }

        protected function deleteTrackHandler(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            this.deletePopUp = new frontend.components.popup.DeletePopUp();
            this.deletePopUp.title = utils.LanguageManager.getString("DELETE_POPUP.DELETE_TRACK_TITLE");
            this.deletePopUp.text = utils.LanguageManager.getString("DELETE_POPUP.DELETE_TRACK_TEXT");
            this.deletePopUp.cancelCallback = this.onPopUpClose;
            this.deletePopUp.deleteCallback = this.onPopUpDelete;
            frontend.components.popup.PopUpBase.showModalPopUp(this.deletePopUp, true, true);
            return;
        }

        internal function onPopUpClose():void
        {
            frontend.components.popup.PopUpBase.removePopUps(this.deletePopUp, true);
            return;
        }

        internal function onPopUpDelete():void
        {
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.UPDATE, core.route.Route.prepareDelete(this.myRoute.GUID), this.onDeleteTrackComplete, this.onDeleteTrackError, Workers.worker_DatabaseWorker);
            frontend.components.popup.PopUpBase.removePopUps(this.deletePopUp, true);
            return;
        }

        internal function onDeleteTrackComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.info("Track wurde gelöscht.");
            var loc1:*=new frontend.screen.tracks.tabs.list.MyTracksListEvent(frontend.screen.tracks.tabs.list.MyTracksListEvent.DELETE, this.myRoute);
            handler.RouteHandler.getInstance().dispatchEvent(loc1);
            handler.RouteHandler.getInstance().dispatchEvent(new service.cloud.CloudEvent(service.cloud.CloudEvent.DATA_CHANGED));
            handler.ViewHandler.getInstance().goBack();
            return;
        }

        internal var _923974976detailsTabbar:frontend.components.tab.TabContainer;

        internal var _1268861541footer:frontend.screen.component.Footer;

        internal var _myRoute:core.route.Route;

        internal var buttonDownload:frontend.components.button.IconButton;

        internal var buttonGroup:__AS3__.vec.Vector.<frontend.components.button.IconButton>;

        internal var buttonNavigateTo:frontend.components.button.IconButton;

        internal var buttonUpload:frontend.components.button.IconButton;

        internal var deletePopUp:frontend.components.popup.DeletePopUp;

        internal var selectedTab:frontend.components.tabbarbase.ITabLayoutContainer;

        internal var trackInfo:frontend.screen.tracks.tabs.track.tabs.TracksInformation;

        internal var trackMap:frontend.screen.tracks.tabs.track.tabs.TracksMap;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal var buttonDelete:frontend.components.button.IconButton;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


