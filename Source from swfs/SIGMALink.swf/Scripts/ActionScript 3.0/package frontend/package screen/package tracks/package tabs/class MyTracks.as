//class MyTracks
package frontend.screen.tracks.tabs 
{
    import backend.utils.*;
    import backend.utils.dbUtils.*;
    import configCache.*;
    import core.general.*;
    import core.route.*;
    import debug.*;
    import feathers.binding.*;
    import feathers.controls.*;
    import feathers.controls.renderers.*;
    import feathers.data.*;
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
    import frontend.components.list.*;
    import frontend.components.tab.*;
    import frontend.components.tabbarbase.*;
    import frontend.screen.tracks.tabs.list.*;
    import handler.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.display.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    import utils.*;
    
    use namespace mx_internal;
    
    public class MyTracks extends frontend.components.tabbarbase.TabLayoutGroup implements feathers.binding.IBindingClient
    {
        public function MyTracks()
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
            bindings = this._MyTracks_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_tracks_tabs_MyTracksWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return MyTracks[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.mxmlContent = [this._MyTracks_ListLoader1_i()];
            this.addEventListener("addedToStage", this.___MyTracks_TabLayoutGroup1_addedToStage);
            this.addEventListener("initialize", this.___MyTracks_TabLayoutGroup1_initialize);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        public function get listLoader():frontend.components.list.ListLoader
        {
            return this._159473233listLoader;
        }

        public function set listLoader(arg1:frontend.components.list.ListLoader):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._159473233listLoader;
            if (loc1 !== arg1) 
            {
                this._159473233listLoader = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "listLoader", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _trackList():frontend.components.list.CustomList
        {
            return this._759336182_trackList;
        }

        internal function set _trackList(arg1:frontend.components.list.CustomList):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._759336182_trackList;
            if (loc1 !== arg1) 
            {
                this._759336182_trackList = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_trackList", loc1, arg1, this);
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

        public function get trackList():frontend.components.list.CustomList
        {
            return this._trackList;
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
            MyTracks._watcherSetupUtil = arg1;
            return;
        }

        internal function onInit(arg1:starling.events.Event):void
        {
            this._trackList = new frontend.components.list.CustomList();
            this._trackList.allowMultipleSelection = false;
            this._trackList.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            this._trackList.dataProvider = this._dataProvider;
            this._trackList.height = SIGMALink.containerHeight - frontend.components.tab.TabContainer.TAB_HEIGHT;
            this._trackList.itemRendererFactory = this.trackListItemRendererUpload;
            this._trackList.width = SIGMALink.appWidth;
            this._trackList.addEventListener(starling.events.Event.TRIGGERED, this.triggeredHandler);
            this.currentSortField = configCache.ConfigCache.getInstance().getValue(configCache.ConfigCacheObject.TRACKS_SORT_FIELD, core.route.Route.COL_MODIFICATION_DATE);
            this.currentAscending = configCache.ConfigCache.getInstance().getValue(configCache.ConfigCacheObject.TRACKS_SORT_FIELD + this.currentSortField + configCache.ConfigCacheObject.TRACKS_SORT_ASCENDING, false);
            handler.RouteHandler.getInstance().addEventListener(frontend.screen.tracks.tabs.list.MyTracksListEvent.UPDATE, this.updateTrack);
            handler.RouteHandler.getInstance().addEventListener(frontend.screen.tracks.tabs.list.MyTracksListEvent.RELOAD, this.loadTracks);
            handler.RouteHandler.getInstance().addEventListener(frontend.screen.tracks.tabs.list.MyTracksListEvent.DELETE, this.deleteTrack);
            this.loadTracks();
            return;
        }

        internal function trackListItemRendererUpload():feathers.controls.renderers.IListItemRenderer
        {
            var loc1:*=new frontend.screen.tracks.tabs.list.MyTracksRenderer();
            loc1.callBackFunction = this.uploadItemClickCallback;
            return loc1;
        }

        internal function uploadItemClickCallback(arg1:frontend.screen.tracks.tabs.list.MyTracksListItem):void
        {
            if (this.listLoader.listStateHandler.editState) 
            {
                return;
            }
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_TRACKS_TRANSFER, {"transferModeDownload":false, "track":arg1.track}, handler.ViewHandler.slideToLeftTransition());
            return;
        }

        internal function addedToStageHandler(arg1:starling.events.Event):void
        {
            this._trackList.selectedItem = null;
            this.listLoader.setNormalState();
            return;
        }

        internal function loadTracks(arg1:frontend.screen.tracks.tabs.list.MyTracksListEvent=null):void
        {
            this.listLoader.startLoading();
            var loc1:*=core.route.Route.statementGetRoutes(0, this.currentSortField, this.currentAscending);
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, loc1, this.loadTracksComplete, this.loadTracksError, Workers.worker_DatabaseWorker);
            return;
        }

        internal function loadTracksComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            var loc2:*=0;
            var loc4:*=null;
            var loc5:*=null;
            var loc1:*=arg1.getResult();
            var loc3:*=loc1.length;
            this._dataProvider = new feathers.data.ListCollection();
            loc2 = 0;
            while (loc2 < loc3) 
            {
                loc4 = new core.route.Route();
                loc4.fromDB(loc1[loc2]);
                loc5 = new frontend.screen.tracks.tabs.list.MyTracksListItem();
                loc5.GUID = loc4.GUID;
                loc5.track = loc4;
                loc5.icon = null;
                loc5.distance = backend.utils.DataUtils.distanceFormatter.format(backend.utils.DataUtils.distanceConverter.convert(loc4.distance));
                loc5.distanceUnit = backend.utils.DataUtils.unitStringDistance;
                loc5.altitude = backend.utils.DataUtils.altitudeFormatter.format(backend.utils.DataUtils.altitudeConverter.convert(loc4.altitudeDifferencesUphill));
                loc5.altitudeUnit = backend.utils.DataUtils.unitStringAltitude;
                this._dataProvider.push(loc5);
                ++loc2;
            }
            if (this.contentLoadedCallback != null) 
            {
                this.contentLoadedCallback();
            }
            this._trackList.dataProvider = this._dataProvider;
            this.listLoader.stopLoading();
            this.listLoader.setNormalState();
            this.listLoader.checkDataProvider();
            return;
        }

        internal function loadTracksError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("loadTracksError");
            this.listLoader.stopLoading();
            return;
        }

        public function updateTrack(arg1:frontend.screen.tracks.tabs.list.MyTracksListEvent):void
        {
            if (!arg1.route) 
            {
                return;
            }
            this._routeToFocus = arg1.route;
            this.contentLoadedCallback = this.focusListItem;
            this.loadTracks();
            return;
        }

        internal function focusListItem():void
        {
            var loc1:*=this.getRouteIndex(this._routeToFocus);
            if (loc1 != -1) 
            {
                this._trackList.scrollToDisplayIndex(loc1);
            }
            this._routeToFocus = null;
            this.contentLoadedCallback = null;
            return;
        }

        public function deleteTrack(arg1:frontend.screen.tracks.tabs.list.MyTracksListEvent):void
        {
            if (!arg1.route) 
            {
                return;
            }
            var loc1:*=this.getRouteIndex(arg1.route);
            if (loc1 != -1) 
            {
                this._dataProvider.removeItemAt(loc1);
            }
            this.listLoader.checkDataProvider();
            return;
        }

        internal function getRouteIndex(arg1:core.route.Route):int
        {
            var loc2:*=0;
            var loc1:*=-1;
            var loc3:*=this._dataProvider.length;
            loc2 = 0;
            while (loc2 < loc3) 
            {
                if (this._dataProvider.getItemAt(loc2).GUID == arg1.GUID) 
                {
                    loc1 = loc2;
                    break;
                }
                ++loc2;
            }
            return loc1;
        }

        protected function triggeredHandler(arg1:starling.events.Event):void
        {
            if (this.listLoader.listStateHandler.editState) 
            {
                return;
            }
            var loc1:*=(arg1.data as frontend.screen.tracks.tabs.list.MyTracksListItem).track as core.route.Route;
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_TRACKS_TRACKDETAIL, {"myRoute":loc1}, handler.ViewHandler.slideToLeftTransition());
            return;
        }

        public function sortList(arg1:frontend.components.list.ListSortItem):void
        {
            this.currentSortField = arg1.sortField;
            configCache.ConfigCache.getInstance().setValue(configCache.ConfigCacheObject.TRACKS_SORT_FIELD, this.currentSortField);
            this.currentAscending = arg1.ascending;
            configCache.ConfigCache.getInstance().setValue(configCache.ConfigCacheObject.TRACKS_SORT_FIELD + this.currentSortField + configCache.ConfigCacheObject.TRACKS_SORT_ASCENDING, this.currentAscending);
            this.loadTracks();
            return;
        }

        internal function _MyTracks_ListLoader1_i():frontend.components.list.ListLoader
        {
            var loc1:*=new frontend.components.list.ListLoader();
            loc1.id = "listLoader";
            this.listLoader = loc1;
            feathers.binding.BindingManager.executeBindings(this, "listLoader", this.listLoader);
            return loc1;
        }

        public function ___MyTracks_TabLayoutGroup1_addedToStage(arg1:starling.events.Event):void
        {
            this.addedToStageHandler(arg1);
            return;
        }

        public function ___MyTracks_TabLayoutGroup1_initialize(arg1:starling.events.Event):void
        {
            this.onInit(arg1);
            return;
        }

        internal function _MyTracks_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("TRACKS.MYTRACKS.TITLE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.label")
            result[1] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight - frontend.components.tab.TabContainer.TAB_HEIGHT;
            }, null, "listLoader.height")
            result[2] = new feathers.binding.Binding(this, function ():feathers.controls.Scroller
            {
                return _trackList;
            }, null, "listLoader.list")
            result[3] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "listLoader.width")
            return result;
        }

        public static const TAB_NAME:String="TAB_MYTRACKS";

        internal var _159473233listLoader:frontend.components.list.ListLoader;

        public var contentLoadedCallback:Function;

        public var currentAscending:Boolean;

        public var currentSortField:String;

        internal var _759336182_trackList:frontend.components.list.CustomList;

        internal var _1763739238_dataProvider:feathers.data.ListCollection;

        internal var _routeToFocus:core.route.Route;

        mx_internal var _bindingsBeginWithWord:Object;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


