//class Tracks
package frontend.screen.tracks 
{
    import __AS3__.vec.*;
    import backend.utils.dbUtils.*;
    import backend.utils.gps.*;
    import core.route.*;
    import debug.*;
    import feathers.binding.*;
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
    import frontend.components.list.*;
    import frontend.components.popup.*;
    import frontend.components.tab.*;
    import frontend.components.tabbarbase.*;
    import frontend.screen.component.*;
    import frontend.screen.tracks.tabs.*;
    import frontend.screen.tracks.tabs.gpsies.*;
    import frontend.screen.tracks.tabs.list.*;
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
    
    public class Tracks extends frontend.screen.component.CustomScreen implements feathers.binding.IBindingClient
    {
        public function Tracks()
        {
            var bindings:Array;
            var watchers:Array;
            var target:Object;
            var i:uint;
            var watcherSetupUtilClass:Object;

            var loc1:*;
            target = null;
            watcherSetupUtilClass = null;
            this.buttonCancel = new frontend.components.button.IconButton();
            this.buttonDelete = new frontend.components.button.IconButton();
            this.buttonDownload = new frontend.components.button.IconButton();
            this.buttonEdit = new frontend.components.button.IconButton();
            this.buttonGroup = new Vector.<frontend.components.button.IconButton>();
            this.buttonSearch = new frontend.components.button.IconButton();
            this.buttonSort = new frontend.components.button.IconButton();
            this.mx_internal::_bindings = [];
            this.mx_internal::_watchers = [];
            this.mx_internal::_bindingsByDestination = {};
            this.mx_internal::_bindingsBeginWithWord = {};
            super();
            bindings = this._Tracks_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_tracks_TracksWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return Tracks[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.allowCaching = true;
            this.hasBackwardNavigation = true;
            this.mxmlContent = [this._Tracks_TabContainer1_i(), this._Tracks_Footer1_i()];
            this.addEventListener("addedToStage", this.___Tracks_CustomScreen1_addedToStage);
            this.addEventListener("initialize", this.___Tracks_CustomScreen1_initialize);
            this.addEventListener("removedFromStage", this.___Tracks_CustomScreen1_removedFromStage);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        internal function onGPSStatusChanged(arg1:starling.events.Event):void
        {
            this.gpsiesTracksTab.listLoader.noResultText = frontend.screen.tracks.tabs.gpsies.GPSiesHandler.getInstance().validateInfoText();
            return;
        }

        internal function validateFooter():void
        {
            var loc1:*=this.selectedTab;
            switch (loc1) 
            {
                case this.myTracksTab:
                {
                    this.setMyTrackFooterButtons();
                    if (this.myTracksTab.trackList.dataProvider) 
                    {
                        this.buttonSort.isEnabled = this.myTracksTab.trackList.dataProvider.length > 1;
                        this.buttonEdit.isEnabled = this.myTracksTab.trackList.dataProvider.length > 0;
                    }
                    else 
                    {
                        this.buttonSort.isEnabled = false;
                        this.buttonEdit.isEnabled = false;
                    }
                    break;
                }
                case this.gpsiesTracksTab:
                {
                    this.setGPSiesFooterButtons();
                    if (this.gpsiesTracksTab.trackList.dataProvider) 
                    {
                        this.buttonSort.isEnabled = this.gpsiesTracksTab.trackList.dataProvider.length > 1;
                    }
                    else 
                    {
                        this.buttonSort.isEnabled = false;
                    }
                    break;
                }
            }
            return;
        }

        internal function setMyTrackFooterButtons():void
        {
            this.buttonGroup = new Vector.<frontend.components.button.IconButton>();
            if (this.myTracksTab.listLoader.listStateHandler.editState) 
            {
                this.myTracksTab.listLoader.noDataIconButtonAnchor = null;
                this.buttonGroup.push(this.buttonDelete);
                this.buttonGroup.push(this.buttonCancel);
            }
            else 
            {
                this.myTracksTab.listLoader.noDataText = utils.LanguageManager.getString("NO_DATA_TRACKS");
                this.myTracksTab.listLoader.noDataIconButtonAnchor = this.buttonDownload;
                this.buttonGroup.push(this.buttonDownload);
                this.buttonGroup.push(this.buttonSort);
                this.buttonGroup.push(this.buttonEdit);
            }
            this.footer.showBackButton = !this.myTracksTab.listLoader.listStateHandler.editState;
            this.footer.setButtonGroup(this.buttonGroup);
            return;
        }

        internal function onInit(arg1:starling.events.Event):void
        {
            this.buttonSort = new frontend.components.button.IconButton();
            this.buttonSort.image = frontend.Textures.sortbutton;
            this.buttonSort.touchHandler = this.footerSortButtonHandler;
            this.buttonEdit = new frontend.components.button.IconButton();
            this.buttonEdit.image = frontend.Textures.editbutton;
            this.buttonEdit.touchHandler = this.footerEditButtonClicked;
            this.buttonSearch = new frontend.components.button.IconButton();
            this.buttonSearch.image = frontend.Textures.lupe_white;
            this.buttonSearch.touchHandler = this.footerSearchButtonHandler;
            this.buttonDelete = new frontend.components.button.IconButton();
            this.buttonDelete.image = frontend.Textures.trashicon;
            this.buttonDelete.touchHandler = this.footerDeleteButtonHandler;
            this.buttonCancel = new frontend.components.button.IconButton();
            this.buttonCancel.image = frontend.Textures.closeicon;
            this.buttonCancel.touchHandler = this.footerCancelButtonHandler;
            this.buttonDownload = new frontend.components.button.IconButton();
            this.buttonDownload.image = frontend.Textures.downloadbutton;
            this.buttonDownload.touchHandler = this.footerDownloadButtonHandler;
            this.validateTabs();
            return;
        }

        internal function onAddedToStage():void
        {
            backend.utils.gps.GeoLocationHelper.getInstance().addEventListener(backend.utils.gps.GeoLocationHelper.GPS_DISABLED, this.onGPSStatusChanged);
            backend.utils.gps.GeoLocationHelper.getInstance().addEventListener(backend.utils.gps.GeoLocationHelper.GPS_ENABLED, this.onGPSStatusChanged);
            frontend.screen.tracks.tabs.gpsies.GPSiesHandler.getInstance().addEventListener(frontend.screen.tracks.tabs.gpsies.GPSiesHandler.TRACKS_LOADED_COMPLETE, this.onTracksChanged);
            this.myTracksTab.listLoader.setNormalState();
            this.validateFooter();
            return;
        }

        internal function setGPSiesFooterButtons():void
        {
            this.gpsiesTracksTab.listLoader.noDataIconButtonAnchor = null;
            this.buttonGroup = new Vector.<frontend.components.button.IconButton>();
            this.buttonGroup.push(this.buttonSort);
            this.buttonGroup.push(this.buttonSearch);
            this.footer.setButtonGroup(this.buttonGroup);
            return;
        }

        internal function onRemovedFromStage():void
        {
            backend.utils.gps.GeoLocationHelper.getInstance().removeEventListener(backend.utils.gps.GeoLocationHelper.GPS_DISABLED, this.onGPSStatusChanged);
            backend.utils.gps.GeoLocationHelper.getInstance().removeEventListener(backend.utils.gps.GeoLocationHelper.GPS_ENABLED, this.onGPSStatusChanged);
            frontend.screen.tracks.tabs.gpsies.GPSiesHandler.getInstance().removeEventListener(frontend.screen.tracks.tabs.gpsies.GPSiesHandler.TRACKS_LOADED_COMPLETE, this.onTracksChanged);
            return;
        }

        internal function validateTabs():void
        {
            this.tracksTabbar.removeTabs();
            this.myTracksTab = new frontend.screen.tracks.tabs.MyTracks();
            this.tracksTabbar.addTab(this.myTracksTab, true);
            this.myTracksTab.showContent();
            this.myTracksTab.contentLoadedCallback = this.onContentLoadedCallback;
            this.gpsiesTracksTab = new frontend.screen.tracks.tabs.GPSies();
            this.gpsiesTracksTab.height = SIGMALink.containerHeight - frontend.components.tab.TabContainer.TAB_HEIGHT;
            this.tracksTabbar.addTab(this.gpsiesTracksTab);
            return;
        }

        internal function onContentLoadedCallback():void
        {
            this.myTracksTab.contentLoadedCallback = null;
            return;
        }

        internal function onTabChanged(arg1:frontend.components.tab.TabEvent):void
        {
            this.selectedTab = arg1.instance;
            if (this.selectedTab == this.gpsiesTracksTab && this._initialGPSiesSearchFlag) 
            {
                this._initialGPSiesSearchFlag = false;
                backend.utils.gps.GeoLocationHelper.getInstance().addEventListener(backend.utils.gps.GeoLocationHelper.LOCATION_CHANGED, this.onLocationChanged);
                backend.utils.gps.GeoLocationHelper.getInstance().updateGPSPosition();
            }
            this.myTracksTab.listLoader.setNormalState();
            this.validateFooter();
            return;
        }

        internal function onLocationChanged(arg1:starling.events.Event):void
        {
            backend.utils.gps.GeoLocationHelper.getInstance().removeEventListener(backend.utils.gps.GeoLocationHelper.LOCATION_CHANGED, this.onLocationChanged);
            frontend.screen.tracks.tabs.gpsies.GPSiesHandler.getInstance().searchTracks();
            return;
        }

        internal function onTracksChanged(arg1:starling.events.Event):void
        {
            this.validateFooter();
            return;
        }

        protected function footerSortButtonHandler(arg1:starling.events.TouchEvent):void
        {
            var loc2:*=null;
            var loc1:*=new Vector.<frontend.components.list.ListSortItem>();
            if (this.selectedTab != this.myTracksTab) 
            {
                if (this.gpsiesTracksTab) 
                {
                    loc1.push(new frontend.components.list.ListSortItem(utils.LanguageManager.getString("SORT_POPUP.NAME"), frontend.screen.tracks.tabs.gpsies.GPSiesSearchResult.COL_NAME, true));
                    loc1.push(new frontend.components.list.ListSortItem(utils.LanguageManager.getString("SORT_POPUP.MODIFICATION_DATE"), frontend.screen.tracks.tabs.gpsies.GPSiesSearchResult.COL_MODIFICATION_DATE, true));
                    loc1.push(new frontend.components.list.ListSortItem(utils.LanguageManager.getString("SORT_POPUP.DISTANCE"), frontend.screen.tracks.tabs.gpsies.GPSiesSearchResult.COL_DISTANCE, true));
                    loc1.push(new frontend.components.list.ListSortItem(utils.LanguageManager.getString("SORT_POPUP.LOCATION"), frontend.screen.tracks.tabs.gpsies.GPSiesSearchResult.COL_DISTANCE_TO_TRACK, true));
                    loc2 = new frontend.components.popup.SortPopUp(loc1, this.gpsiesTracksTab.currentSortField, this.gpsiesTracksTab.currentAscending);
                    loc2.sortCallback = this.gpsiesTracksTab.sortList;
                }
            }
            else 
            {
                loc1.push(new frontend.components.list.ListSortItem(utils.LanguageManager.getString("SORT_POPUP.NAME"), core.route.Route.COL_NAME, true));
                loc1.push(new frontend.components.list.ListSortItem(utils.LanguageManager.getString("SORT_POPUP.MODIFICATION_DATE"), core.route.Route.COL_MODIFICATION_DATE, true));
                loc1.push(new frontend.components.list.ListSortItem(utils.LanguageManager.getString("SORT_POPUP.DISTANCE"), core.route.Route.COL_DISTANCE, true));
                loc1.push(new frontend.components.list.ListSortItem(utils.LanguageManager.getString("SORT_POPUP.ALTI_UP"), core.route.Route.COL_ALTITUDE_DIFFERENCES_UPHILL, true));
                loc2 = new frontend.components.popup.SortPopUp(loc1, this.myTracksTab.currentSortField, this.myTracksTab.currentAscending);
                loc2.sortCallback = this.myTracksTab.sortList;
            }
            if (loc2) 
            {
                frontend.components.popup.PopUpBase.showModalPopUp(loc2, true, true, false, true);
            }
            return;
        }

        internal function footerEditButtonClicked(arg1:starling.events.TouchEvent):void
        {
            debug.Debug.debug("footerEditButtonClicked");
            if (this.selectedTab == this.myTracksTab) 
            {
                this.myTracksTab.listLoader.swapState();
                this.setMyTrackFooterButtons();
            }
            return;
        }

        internal function footerSearchButtonHandler(arg1:starling.events.TouchEvent):void
        {
            debug.Debug.debug("footerSearchButtonHandler");
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_TRACKS_GPSIES_SEARCH, null, handler.ViewHandler.slideToLeftTransition());
            return;
        }

        internal function footerDeleteButtonHandler(arg1:starling.events.TouchEvent):void
        {
            var loc1:*=0;
            var loc3:*=null;
            this._selectedTracks = new Vector.<frontend.screen.tracks.tabs.list.MyTracksListItem>();
            var loc2:*=this.myTracksTab.trackList.dataProvider.length;
            loc1 = 0;
            while (loc1 < loc2) 
            {
                loc3 = this.myTracksTab.trackList.dataProvider.data[loc1] as frontend.screen.tracks.tabs.list.MyTracksListItem;
                if (loc3 && loc3.isSelected()) 
                {
                    this._selectedTracks.push(loc3);
                }
                ++loc1;
            }
            if (this._selectedTracks.length > 0) 
            {
                if (!this.deletePopUp) 
                {
                    this.deletePopUp = new frontend.components.popup.DeletePopUp();
                    this.deletePopUp.title = utils.LanguageManager.getString("DELETE_POPUP.DELETE_TRACKS_TITLE");
                    this.deletePopUp.text = utils.LanguageManager.getString("DELETE_POPUP.DELETE_TRACKS_TEXT");
                    this.deletePopUp.cancelCallback = this.onPopUpClose;
                    this.deletePopUp.deleteCallback = this.onPopUpDelete;
                }
            }
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
            var loc1:*=0;
            var loc3:*=null;
            var loc2:*=this._selectedTracks.length;
            loc1 = 0;
            while (loc1 < loc2) 
            {
                loc3 = this._selectedTracks[loc1] as frontend.screen.tracks.tabs.list.MyTracksListItem;
                backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.UPDATE, core.route.Route.prepareDelete(loc3.track.GUID), this.onDeleteTracksComplete, this.onDeleteTracksError, Workers.worker_DatabaseWorker, loc3);
                ++loc1;
            }
            frontend.components.popup.PopUpBase.removePopUps(this.deletePopUp, true);
            this.myTracksTab.listLoader.swapState();
            this.setMyTrackFooterButtons();
            return;
        }

        internal function onDeleteTracksComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.info("Track wurde gelöscht.");
            var loc1:*=(arg1.data as backend.utils.dbUtils.DBUtilObject).data as frontend.screen.tracks.tabs.list.MyTracksListItem;
            this.myTracksTab.trackList.dataProvider.removeItem(loc1);
            var loc2:*=new frontend.screen.tracks.tabs.list.MyTracksListEvent(frontend.screen.tracks.tabs.list.MyTracksListEvent.DELETE, loc1.track);
            handler.RouteHandler.getInstance().dispatchEvent(loc2);
            loc1.removeSelection();
            handler.RouteHandler.getInstance().dispatchEvent(new service.cloud.CloudEvent(service.cloud.CloudEvent.DATA_CHANGED));
            return;
        }

        internal function onDeleteTracksError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("Track konnte nicht gelöscht werden.");
            var loc1:*=(arg1.data as backend.utils.dbUtils.DBUtilObject).data as frontend.screen.tracks.tabs.list.MyTracksListItem;
            loc1.removeSelection();
            return;
        }

        internal function footerCancelButtonHandler(arg1:starling.events.TouchEvent):void
        {
            debug.Debug.debug("footerCancelButtonHandler");
            this.myTracksTab.listLoader.swapState();
            this.setMyTrackFooterButtons();
            return;
        }

        internal function footerDownloadButtonHandler(arg1:starling.events.TouchEvent):void
        {
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_TRACKS_TRANSFER, {"transferModeDownload":true}, handler.ViewHandler.slideToLeftTransition(), true);
            return;
        }

        internal function _Tracks_TabContainer1_i():frontend.components.tab.TabContainer
        {
            var loc1:*=new frontend.components.tab.TabContainer();
            loc1.useIconTabs = false;
            loc1.addEventListener("tabChanged", this.__tracksTabbar_tabChanged);
            loc1.id = "tracksTabbar";
            this.tracksTabbar = loc1;
            feathers.binding.BindingManager.executeBindings(this, "tracksTabbar", this.tracksTabbar);
            return loc1;
        }

        public function __tracksTabbar_tabChanged(arg1:frontend.components.tab.TabEvent):void
        {
            this.onTabChanged(arg1);
            return;
        }

        internal function _Tracks_Footer1_i():frontend.screen.component.Footer
        {
            var loc1:*=new frontend.screen.component.Footer();
            loc1.id = "footer";
            this.footer = loc1;
            feathers.binding.BindingManager.executeBindings(this, "footer", this.footer);
            return loc1;
        }

        public function ___Tracks_CustomScreen1_addedToStage(arg1:starling.events.Event):void
        {
            this.onAddedToStage();
            return;
        }

        public function ___Tracks_CustomScreen1_initialize(arg1:starling.events.Event):void
        {
            this.onInit(arg1);
            return;
        }

        public function ___Tracks_CustomScreen1_removedFromStage(arg1:starling.events.Event):void
        {
            this.onRemovedFromStage();
            return;
        }

        internal function _Tracks_bindingsSetup():Array
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
            }, null, "tracksTabbar.height")
            result[2] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "tracksTabbar.width")
            return result;
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

        public function get tracksTabbar():frontend.components.tab.TabContainer
        {
            return this._1946662662tracksTabbar;
        }

        public function set tracksTabbar(arg1:frontend.components.tab.TabContainer):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1946662662tracksTabbar;
            if (loc1 !== arg1) 
            {
                this._1946662662tracksTabbar = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "tracksTabbar", loc1, arg1, this);
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
            Tracks._watcherSetupUtil = arg1;
            return;
        }

        internal var buttonGroup:__AS3__.vec.Vector.<frontend.components.button.IconButton>;

        internal var buttonSearch:frontend.components.button.IconButton;

        internal var buttonSort:frontend.components.button.IconButton;

        internal var deletePopUp:frontend.components.popup.DeletePopUp;

        internal var gpsiesTracksTab:frontend.screen.tracks.tabs.GPSies;

        internal var myTracksTab:frontend.screen.tracks.tabs.MyTracks;

        internal var selectedTab:frontend.components.tabbarbase.ITabLayoutContainer;

        internal var buttonDelete:frontend.components.button.IconButton;

        internal var _1268861541footer:frontend.screen.component.Footer;

        internal var _1946662662tracksTabbar:frontend.components.tab.TabContainer;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal var _initialGPSiesSearchFlag:Boolean=true;

        internal var _selectedTracks:__AS3__.vec.Vector.<frontend.screen.tracks.tabs.list.MyTracksListItem>;

        internal var buttonCancel:frontend.components.button.IconButton;

        internal var buttonDownload:frontend.components.button.IconButton;

        internal var buttonEdit:frontend.components.button.IconButton;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


