//class GPSies
package frontend.screen.tracks.tabs 
{
    import configCache.*;
    import core.general.*;
    import debug.*;
    import feathers.binding.*;
    import feathers.controls.*;
    import feathers.data.*;
    import feathers.events.*;
    import feathers.layout.*;
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
    import frontend.screen.tracks.tabs.gpsies.*;
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
    import utils.sort.*;
    
    use namespace mx_internal;
    
    public class GPSies extends frontend.components.tabbarbase.TabLayoutGroup implements feathers.binding.IBindingClient
    {
        public function GPSies()
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
            bindings = this._GPSies_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_tracks_tabs_GPSiesWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return GPSies[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.mxmlContent = [this._GPSies_ListLoader1_i()];
            this.addEventListener("initialize", this.___GPSies_TabLayoutGroup1_initialize);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        public function get trackList():frontend.components.list.CustomList
        {
            return this._trackList;
        }

        internal function onInit():void
        {
            this._trackList = new frontend.components.list.CustomList();
            this._trackList.allowMultipleSelection = false;
            this._trackList.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            this._trackList.dataProvider = this._dataProvider;
            this._trackList.height = SIGMALink.containerHeight - frontend.components.tab.TabContainer.TAB_HEIGHT;
            this._trackList.itemRendererType = frontend.screen.tracks.tabs.gpsies.GPSiesTrackRenderer;
            this._trackList.width = SIGMALink.appWidth;
            this._trackList.addEventListener(starling.events.Event.TRIGGERED, this.triggeredHandler);
            this.currentSortField = configCache.ConfigCache.getInstance().getValue(configCache.ConfigCacheObject.GPSIES_SORT_FIELD, frontend.screen.tracks.tabs.gpsies.GPSiesSearchResult.COL_DISTANCE_TO_TRACK);
            this.currentAscending = configCache.ConfigCache.getInstance().getValue(configCache.ConfigCacheObject.GPSIES_SORT_FIELD + this.currentSortField + configCache.ConfigCacheObject.GPSIES_SORT_ASCENDING, true);
            frontend.screen.tracks.tabs.gpsies.GPSiesHandler.getInstance().addEventListener(frontend.screen.tracks.tabs.gpsies.GPSiesHandler.TRACKS_LOAD_ERROR, this.onTracksChanged);
            frontend.screen.tracks.tabs.gpsies.GPSiesHandler.getInstance().addEventListener(frontend.screen.tracks.tabs.gpsies.GPSiesHandler.TRACKS_LOADED_COMPLETE, this.onTracksChanged);
            this.listLoader.noResultText = frontend.screen.tracks.tabs.gpsies.GPSiesHandler.getInstance().validateInfoText();
            return;
        }

        internal function onTracksChanged(arg1:starling.events.Event):void
        {
            frontend.screen.tracks.tabs.gpsies.GPSiesHandler.getInstance().tracks.sort(this.sortTracks);
            this._dataProvider = new feathers.data.ListCollection(frontend.screen.tracks.tabs.gpsies.GPSiesHandler.getInstance().tracks);
            this._trackList.dataProvider = this._dataProvider;
            this.listLoader.noResultText = frontend.screen.tracks.tabs.gpsies.GPSiesHandler.getInstance().validateInfoText();
            this.listLoader.checkDataProvider();
            return;
        }

        protected function triggeredHandler(arg1:starling.events.Event):void
        {
            var p_event:starling.events.Event;
            var track:frontend.screen.tracks.tabs.gpsies.GPSiesSearchResult;

            var loc1:*;
            track = null;
            p_event = arg1;
            if (this.listLoader.listStateHandler.editState) 
            {
                return;
            }
            this.listLoader.startLoading();
            try 
            {
                track = p_event.data as frontend.screen.tracks.tabs.gpsies.GPSiesSearchResult;
                frontend.screen.tracks.tabs.gpsies.GPSiesHandler.getInstance().addEventListener(frontend.screen.tracks.tabs.gpsies.GPSiesHandler.TRACKS_DETAILS_LOAD_ERROR, this.onTrackDetailsLoadError);
                frontend.screen.tracks.tabs.gpsies.GPSiesHandler.getInstance().addEventListener(frontend.screen.tracks.tabs.gpsies.GPSiesHandler.TRACKS_DETAILS_LOADED_COMPLETE, this.onTrackDetailsLoadedComplete);
                frontend.screen.tracks.tabs.gpsies.GPSiesHandler.getInstance().loadTrackAsKMZ(track.tmpRoute);
            }
            catch (e:Error)
            {
                debug.Debug.error(e.message);
            }
            return;
        }

        internal function onTrackDetailsLoadedComplete(arg1:starling.events.Event):void
        {
            this.listLoader.stopLoading();
            this._trackList.selectedItem = null;
            frontend.screen.tracks.tabs.gpsies.GPSiesHandler.getInstance().removeEventListener(frontend.screen.tracks.tabs.gpsies.GPSiesHandler.TRACKS_DETAILS_LOAD_ERROR, this.onTrackDetailsLoadError);
            frontend.screen.tracks.tabs.gpsies.GPSiesHandler.getInstance().removeEventListener(frontend.screen.tracks.tabs.gpsies.GPSiesHandler.TRACKS_DETAILS_LOADED_COMPLETE, this.onTrackDetailsLoadedComplete);
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_TRACKS_TRACKDETAIL, {"myRoute":frontend.screen.tracks.tabs.gpsies.GPSiesHandler.getInstance().currentRoute}, handler.ViewHandler.slideToLeftTransition());
            return;
        }

        internal function onTrackDetailsLoadError(arg1:starling.events.Event):void
        {
            this.listLoader.stopLoading();
            frontend.screen.tracks.tabs.gpsies.GPSiesHandler.getInstance().removeEventListener(frontend.screen.tracks.tabs.gpsies.GPSiesHandler.TRACKS_DETAILS_LOAD_ERROR, this.onTrackDetailsLoadError);
            frontend.screen.tracks.tabs.gpsies.GPSiesHandler.getInstance().removeEventListener(frontend.screen.tracks.tabs.gpsies.GPSiesHandler.TRACKS_DETAILS_LOADED_COMPLETE, this.onTrackDetailsLoadedComplete);
            return;
        }

        public function sortList(arg1:frontend.components.list.ListSortItem):void
        {
            this.currentSortField = arg1.sortField;
            configCache.ConfigCache.getInstance().setValue(configCache.ConfigCacheObject.GPSIES_SORT_FIELD, this.currentSortField);
            this.currentAscending = arg1.ascending;
            configCache.ConfigCache.getInstance().setValue(configCache.ConfigCacheObject.GPSIES_SORT_FIELD + this.currentSortField + configCache.ConfigCacheObject.GPSIES_SORT_ASCENDING, this.currentAscending);
            frontend.screen.tracks.tabs.gpsies.GPSiesHandler.getInstance().tracks.sort(this.sortTracks);
            this._dataProvider = new feathers.data.ListCollection(frontend.screen.tracks.tabs.gpsies.GPSiesHandler.getInstance().tracks);
            this._trackList.dataProvider = this._dataProvider;
            this.listLoader.checkDataProvider();
            return;
        }

        internal function sortTracks(arg1:frontend.screen.tracks.tabs.gpsies.GPSiesSearchResult, arg2:frontend.screen.tracks.tabs.gpsies.GPSiesSearchResult):Number
        {
            if (this.currentSortField == frontend.screen.tracks.tabs.gpsies.GPSiesSearchResult.COL_NAME) 
            {
                return utils.sort.SortUtil.sortOnString(arg1, arg2, this.currentSortField, !this.currentAscending);
            }
            return utils.sort.SortUtil.sortOnNumber(arg1, arg2, this.currentSortField, !this.currentAscending);
        }

        internal function _GPSies_ListLoader1_i():frontend.components.list.ListLoader
        {
            var loc1:*=new frontend.components.list.ListLoader();
            loc1.id = "listLoader";
            this.listLoader = loc1;
            feathers.binding.BindingManager.executeBindings(this, "listLoader", this.listLoader);
            return loc1;
        }

        public function ___GPSies_TabLayoutGroup1_initialize(arg1:starling.events.Event):void
        {
            this.onInit();
            return;
        }

        internal function _GPSies_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("TRACKS.GPSIES.TITLE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.label")
            result[1] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return new feathers.layout.AnchorLayout();
            }, null, "this.layout")
            result[2] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight;
            }, null, "listLoader.height")
            result[3] = new feathers.binding.Binding(this, function ():feathers.controls.Scroller
            {
                return _trackList;
            }, null, "listLoader.list")
            result[4] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "listLoader.width")
            return result;
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

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            GPSies._watcherSetupUtil = arg1;
            return;
        }

        public static const TAB_NAME:String="TAB_GPSIES_TRACKS";

        internal var _159473233listLoader:frontend.components.list.ListLoader;

        public var currentAscending:Boolean;

        public var currentSortField:String;

        internal var _759336182_trackList:frontend.components.list.CustomList;

        internal var _dataProvider:feathers.data.ListCollection;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


