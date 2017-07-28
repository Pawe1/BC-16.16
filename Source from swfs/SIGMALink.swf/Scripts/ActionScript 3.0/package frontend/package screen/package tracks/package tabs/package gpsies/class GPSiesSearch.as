//class GPSiesSearch
package frontend.screen.tracks.tabs.gpsies 
{
    import backend.utils.*;
    import backend.utils.dataprovider.*;
    import backend.utils.gps.*;
    import configCache.*;
    import core.sport.*;
    import debug.*;
    import feathers.binding.*;
    import feathers.controls.*;
    import feathers.data.*;
    import feathers.events.*;
    import feathers.layout.*;
    import feathers.themes.*;
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
    import frontend.components.*;
    import frontend.components.menuList.*;
    import frontend.components.menuList.editors.base.*;
    import frontend.components.scrollContainer.*;
    import frontend.screen.component.*;
    import handler.*;
    import helper.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.core.*;
    import starling.display.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    import utils.*;
    
    use namespace mx_internal;
    
    public class GPSiesSearch extends frontend.screen.component.CustomScreen implements feathers.binding.IBindingClient
    {
        public function GPSiesSearch()
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
            bindings = this._GPSiesSearch_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_tracks_tabs_gpsies_GPSiesSearchWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return GPSiesSearch[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.allowCaching = true;
            this.hasBackwardNavigation = true;
            this.mxmlContent = [this._GPSiesSearch_CustomVScrollContainer1_i(), this._GPSiesSearch_Footer1_i()];
            this.addEventListener("addedToStage", this.___GPSiesSearch_CustomScreen1_addedToStage);
            this.addEventListener("initialize", this.___GPSiesSearch_CustomScreen1_initialize);
            this.addEventListener("removedFromStage", this.___GPSiesSearch_CustomScreen1_removedFromStage);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        public function set list(arg1:frontend.components.menuList.MenuList):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._3322014list;
            if (loc1 !== arg1) 
            {
                this._3322014list = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "list", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get movie():feathers.controls.LayoutGroup
        {
            return this._104087344movie;
        }

        public function set movie(arg1:feathers.controls.LayoutGroup):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._104087344movie;
            if (loc1 !== arg1) 
            {
                this._104087344movie = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "movie", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get scroller():frontend.components.scrollContainer.CustomVScrollContainer
        {
            return this._402164678scroller;
        }

        public function set scroller(arg1:frontend.components.scrollContainer.CustomVScrollContainer):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._402164678scroller;
            if (loc1 !== arg1) 
            {
                this._402164678scroller = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "scroller", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get searchButton():feathers.controls.Button
        {
            return this._365389062searchButton;
        }

        protected function addedToStageHandler(arg1:starling.events.Event):void
        {
            backend.utils.gps.GeoLocationHelper.getInstance().addEventListener(backend.utils.gps.GeoLocationHelper.GPS_DISABLED, this.onGPSDisabled);
            backend.utils.gps.GeoLocationHelper.getInstance().addEventListener(backend.utils.gps.GeoLocationHelper.GPS_ENABLED, this.onGPSEnabled);
            backend.utils.gps.GeoLocationHelper.getInstance().addEventListener(backend.utils.gps.GeoLocationHelper.LOCATION_CHANGED, this.onGPSLocationChanged);
            backend.utils.gps.GeoLocationHelper.getInstance().updateGPSPosition();
            return;
        }

        public function set searchButton(arg1:feathers.controls.Button):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._365389062searchButton;
            if (loc1 !== arg1) 
            {
                this._365389062searchButton = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "searchButton", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get loading():Boolean
        {
            return this._336650556loading;
        }

        public function set loading(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._336650556loading;
            if (loc1 !== arg1) 
            {
                this._336650556loading = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "loading", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _gpsiesInfo():String
        {
            return this._2009185754_gpsiesInfo;
        }

        internal function set _gpsiesInfo(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._2009185754_gpsiesInfo;
            if (loc1 !== arg1) 
            {
                this._2009185754_gpsiesInfo = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_gpsiesInfo", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        protected function onInit(arg1:starling.events.Event):void
        {
            (this.scroller.layout as feathers.layout.VerticalLayout).gap = 20 * SIGMALink.scaleFactor;
            (this.scroller.layout as feathers.layout.VerticalLayout).horizontalAlign = feathers.layout.HorizontalAlign.CENTER;
            frontend.screen.tracks.tabs.gpsies.GPSiesHandler.getInstance().infoCallback = this.gpsiesInfoCallback;
            return;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            GPSiesSearch._watcherSetupUtil = arg1;
            return;
        }

        internal function removedFromStageHandler(arg1:starling.events.Event):void
        {
            backend.utils.gps.GeoLocationHelper.getInstance().removeEventListener(backend.utils.gps.GeoLocationHelper.GPS_DISABLED, this.onGPSDisabled);
            backend.utils.gps.GeoLocationHelper.getInstance().removeEventListener(backend.utils.gps.GeoLocationHelper.GPS_ENABLED, this.onGPSEnabled);
            backend.utils.gps.GeoLocationHelper.getInstance().removeEventListener(backend.utils.gps.GeoLocationHelper.LOCATION_CHANGED, this.onGPSLocationChanged);
            return;
        }

        internal function onGPSDisabled(arg1:starling.events.Event):void
        {
            this.searchButton.visible = helper.Capabilities_helper.isSimulator() ? true : false;
            return;
        }

        internal function onGPSEnabled(arg1:starling.events.Event):void
        {
            this.searchButton.visible = true;
            return;
        }

        internal function onGPSLocationChanged(arg1:starling.events.Event):void
        {
            this.searchButton.isEnabled = true;
            return;
        }

        protected override function validateProperties():void
        {
            var loc6:*=0;
            var loc9:*=null;
            this.list.removeChildren();
            var loc1:*=new frontend.components.menuList.MenuListItem();
            var loc10:*;
            loc1.text = loc10 = "GPSIES_SEARCH_RADIUS";
            loc1.title = loc10;
            loc1.editable = true;
            loc1.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_NUMBER;
            loc1.minItemHeight = frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
            loc1.useConfigCache = true;
            loc1.unitString = backend.utils.DataUtils.unitStringDistance;
            loc1.configCacheAttribute = frontend.screen.tracks.tabs.gpsies.GPSiesHandler.RADIUS;
            loc1.defaultValue = configCache.ConfigCache.getInstance().getValue(frontend.screen.tracks.tabs.gpsies.GPSiesHandler.RADIUS, frontend.screen.tracks.tabs.gpsies.GPSiesHandler.getInstance().defaultRadius);
            loc1.formatter = backend.utils.DataUtils.distanceFormatter;
            loc1.converter = backend.utils.DataUtils.distanceConverter;
            loc1.minimum = 0;
            loc1.maximum = this._maximumRadius;
            this.list.addChild(loc1);
            var loc2:*=new frontend.components.menuList.MenuListItem();
            loc2.text = loc10 = "GPSIES_SEARCH_TYPE";
            loc2.title = loc10;
            loc2.editable = true;
            loc2.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SPINNER;
            loc2.dataProvider = backend.utils.dataprovider.RouteOptionsDataProvider.getTypeDataProvider();
            loc2.defaultValue = configCache.ConfigCache.getInstance().getValue(frontend.screen.tracks.tabs.gpsies.GPSiesHandler.TYPE, frontend.screen.tracks.tabs.gpsies.GPSiesHandler.getInstance().defaultType);
            loc2.configCacheAttribute = frontend.screen.tracks.tabs.gpsies.GPSiesHandler.TYPE;
            loc2.minItemHeight = frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
            loc2.useConfigCache = true;
            this.list.addChild(loc2);
            var loc3:*=new frontend.components.menuList.MenuListItem();
            loc3.text = loc10 = "GPSIES_SEARCH_MAX_DISTANZ";
            loc3.title = loc10;
            loc3.editable = true;
            loc3.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_NUMBER;
            loc3.minItemHeight = frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
            loc3.useConfigCache = true;
            loc3.unitString = backend.utils.DataUtils.unitStringDistance;
            loc3.defaultValue = configCache.ConfigCache.getInstance().getValue(frontend.screen.tracks.tabs.gpsies.GPSiesHandler.MAX_DISTANCE, frontend.screen.tracks.tabs.gpsies.GPSiesHandler.getInstance().defaultMaxDistance);
            loc3.configCacheAttribute = frontend.screen.tracks.tabs.gpsies.GPSiesHandler.MAX_DISTANCE;
            loc3.formatter = backend.utils.DataUtils.distanceFormatter;
            loc3.converter = backend.utils.DataUtils.distanceConverter;
            loc3.minimum = 0;
            loc3.maximum = this._maximumMaxDistance;
            this.list.addChild(loc3);
            var loc4:*=backend.utils.dataprovider.RouteOptionsDataProvider.getSuitableDataProvider();
            var loc5:*=configCache.ConfigCache.getInstance().getValue(frontend.screen.tracks.tabs.gpsies.GPSiesHandler.SPORT, frontend.screen.tracks.tabs.gpsies.GPSiesHandler.getInstance().defaultSport);
            var loc7:*=loc4.length;
            var loc8:*=new feathers.data.ListCollection();
            loc6 = 0;
            while (loc6 < loc7) 
            {
                if (loc4.getItemAt(loc6).selectable) 
                {
                    loc9 = handler.SportHandler.getInstance().resolveSportById(loc4.getItemAt(loc6).sportId);
                    loc8.push({"label":loc9.name, "data":loc9.sportId, "param":loc4.getItemAt(loc6).param, "selected":loc4.getItemAt(loc6).sportId == loc5});
                }
                ++loc6;
            }
            this.sportsItem = new frontend.components.menuList.MenuListItem();
            this.sportsItem.text = loc10 = "GPSIES_SEARCH_SUITABLE";
            this.sportsItem.title = loc10;
            this.sportsItem.editable = true;
            this.sportsItem.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SINGLE_SELECT_SPORT;
            this.sportsItem.dataProvider = loc8;
            this.sportsItem.defaultValue = loc5;
            this.sportsItem.configCacheAttribute = frontend.screen.tracks.tabs.gpsies.GPSiesHandler.SPORT;
            this.sportsItem.minItemHeight = frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
            this.sportsItem.saveCompleteCallback = this.onSuitableItemChanged;
            this.sportsItem.useConfigCache = true;
            this.list.addChild(this.sportsItem);
            this.validateSportsItem();
            return;
        }

        internal function gpsiesInfoCallback(arg1:String):void
        {
            this._gpsiesInfo = arg1;
            return;
        }

        internal function onSuitableItemChanged(arg1:frontend.components.menuList.MenuListItem, arg2:frontend.components.menuList.editors.base.EditorReturnObject):void
        {
            this.validateSportsItem();
            return;
        }

        internal function validateSportsItem():void
        {
            this.sportsItem.customLayoutContent.removeChildren();
            this.sportsItem.customLayoutContent.visible = true;
            this.sportsItem.customLayoutContent.includeInLayout = true;
            this.sportsItem.customLayoutContent.layoutData = new feathers.layout.AnchorLayoutData(0, 0);
            var loc1:*=new feathers.layout.TiledRowsLayout();
            loc1.requestedColumnCount = 1;
            loc1.useSquareTiles = false;
            loc1.horizontalGap = this.sportsItem.padding;
            loc1.verticalGap = this.sportsItem.padding;
            loc1.verticalAlign = feathers.layout.VerticalAlign.MIDDLE;
            loc1.horizontalAlign = feathers.layout.HorizontalAlign.RIGHT;
            loc1.paddingRight = this.sportsItem.padding;
            var loc2:*=new frontend.components.SportIcon();
            loc2.sportId = 1;
            loc2.validate();
            loc1.typicalItem = loc2;
            loc1.typicalItemHeight = loc2.height;
            loc1.typicalItemWidth = loc2.width;
            this.sportsItem.customLayoutContent.width = loc1.requestedColumnCount * loc1.typicalItemWidth + (loc1.requestedColumnCount + 1) * this.sportsItem.padding;
            var loc3:*=new frontend.components.SportIcon();
            loc3.sportId = configCache.ConfigCache.getInstance().getValue(frontend.screen.tracks.tabs.gpsies.GPSiesHandler.SPORT, frontend.screen.tracks.tabs.gpsies.GPSiesHandler.getInstance().defaultSport);
            this.sportsItem.customLayoutContent.addChild(loc3);
            loc1.requestedRowCount = Math.max(1, Math.ceil(this.sportsItem.customLayoutContent.numChildren / loc1.requestedColumnCount));
            this.sportsItem.customLayoutContent.layout = loc1;
            this.sportsItem.height = loc1.requestedRowCount * this.sportsItem.minItemHeight;
            this.sportsItem.customLayoutContent.height = this.sportsItem.height;
            return;
        }

        internal function touchHandler(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            this.startLoading();
            frontend.screen.tracks.tabs.gpsies.GPSiesHandler.getInstance().addEventListener(frontend.screen.tracks.tabs.gpsies.GPSiesHandler.TRACKS_LOAD_ERROR, this.onTracksLoadError);
            frontend.screen.tracks.tabs.gpsies.GPSiesHandler.getInstance().addEventListener(frontend.screen.tracks.tabs.gpsies.GPSiesHandler.TRACKS_LOADED_COMPLETE, this.onTracksLoadedComplete);
            frontend.screen.tracks.tabs.gpsies.GPSiesHandler.getInstance().searchTracks();
            return;
        }

        internal function onTracksLoadedComplete(arg1:starling.events.Event):void
        {
            frontend.screen.tracks.tabs.gpsies.GPSiesHandler.getInstance().removeEventListener(frontend.screen.tracks.tabs.gpsies.GPSiesHandler.TRACKS_LOAD_ERROR, this.onTracksLoadError);
            frontend.screen.tracks.tabs.gpsies.GPSiesHandler.getInstance().removeEventListener(frontend.screen.tracks.tabs.gpsies.GPSiesHandler.TRACKS_LOADED_COMPLETE, this.onTracksLoadedComplete);
            this._gpsiesInfo = frontend.screen.tracks.tabs.gpsies.GPSiesHandler.getInstance().validateInfoText();
            this.stopLoading();
            if (frontend.screen.tracks.tabs.gpsies.GPSiesHandler.getInstance().tracks.length > 0) 
            {
                handler.ViewHandler.getInstance().goBack();
            }
            return;
        }

        internal function onTracksLoadError(arg1:starling.events.Event):void
        {
            this.stopLoading();
            this._gpsiesInfo = utils.LanguageManager.getString("GPSIES_SEARCH_ERROR");
            frontend.screen.tracks.tabs.gpsies.GPSiesHandler.getInstance().removeEventListener(frontend.screen.tracks.tabs.gpsies.GPSiesHandler.TRACKS_LOAD_ERROR, this.onTracksLoadError);
            frontend.screen.tracks.tabs.gpsies.GPSiesHandler.getInstance().removeEventListener(frontend.screen.tracks.tabs.gpsies.GPSiesHandler.TRACKS_LOADED_COMPLETE, this.onTracksLoadedComplete);
            debug.Debug.error("GPSiesSearch > onTracksLoadError");
            return;
        }

        public function startLoading():void
        {
            this.searchButton.isEnabled = false;
            var loc1:*=frontend.AssetsManagerCustom.getInstance().getTextureAtlas("loaderAnimation");
            if (loc1) 
            {
                this.movieClip = new starling.display.MovieClip(loc1.getTextures("frame_"), 30);
                this.movie.addChild(this.movieClip);
                this.movieClip.play();
                if (!starling.core.Starling.juggler.contains(this.movieClip)) 
                {
                    starling.core.Starling.juggler.add(this.movieClip);
                }
                this.movie.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, NaN, 0);
                this.loading = true;
            }
            return;
        }

        public function stopLoading():void
        {
            this.loading = false;
            this.searchButton.isEnabled = true;
            if (this.movieClip) 
            {
                this.movieClip.stop();
                if (starling.core.Starling.juggler.contains(this.movieClip)) 
                {
                    starling.core.Starling.juggler.remove(this.movieClip);
                }
            }
            this.movie.removeChildren();
            return;
        }

        internal function _GPSiesSearch_CustomVScrollContainer1_i():frontend.components.scrollContainer.CustomVScrollContainer
        {
            var loc1:*=new frontend.components.scrollContainer.CustomVScrollContainer();
            loc1.mxmlContent = [this._GPSiesSearch_MenuList1_i(), this._GPSiesSearch_Button1_i(), this._GPSiesSearch_Label1_i(), this._GPSiesSearch_LayoutGroup1_i()];
            loc1.id = "scroller";
            this.scroller = loc1;
            feathers.binding.BindingManager.executeBindings(this, "scroller", this.scroller);
            return loc1;
        }

        internal function _GPSiesSearch_MenuList1_i():frontend.components.menuList.MenuList
        {
            var loc1:*=new frontend.components.menuList.MenuList();
            loc1.id = "list";
            this.list = loc1;
            feathers.binding.BindingManager.executeBindings(this, "list", this.list);
            return loc1;
        }

        internal function _GPSiesSearch_Button1_i():feathers.controls.Button
        {
            var loc1:*=new feathers.controls.Button();
            loc1.styleName = "WHITEBUTTON";
            loc1.visible = false;
            loc1.addEventListener("touch", this.__searchButton_touch);
            loc1.id = "searchButton";
            this.searchButton = loc1;
            feathers.binding.BindingManager.executeBindings(this, "searchButton", this.searchButton);
            return loc1;
        }

        public function __searchButton_touch(arg1:starling.events.TouchEvent):void
        {
            this.touchHandler(arg1);
            return;
        }

        internal function _GPSiesSearch_Label1_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.wordWrap = true;
            loc1.id = "_GPSiesSearch_Label1";
            this._GPSiesSearch_Label1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_GPSiesSearch_Label1", this._GPSiesSearch_Label1);
            return loc1;
        }

        internal function _GPSiesSearch_LayoutGroup1_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.id = "movie";
            this.movie = loc1;
            feathers.binding.BindingManager.executeBindings(this, "movie", this.movie);
            return loc1;
        }

        internal function _GPSiesSearch_Footer1_i():frontend.screen.component.Footer
        {
            var loc1:*=new frontend.screen.component.Footer();
            loc1.id = "footer";
            this.footer = loc1;
            feathers.binding.BindingManager.executeBindings(this, "footer", this.footer);
            return loc1;
        }

        public function ___GPSiesSearch_CustomScreen1_addedToStage(arg1:starling.events.Event):void
        {
            this.addedToStageHandler(arg1);
            return;
        }

        public function ___GPSiesSearch_CustomScreen1_initialize(arg1:starling.events.Event):void
        {
            this.onInit(arg1);
            return;
        }

        public function ___GPSiesSearch_CustomScreen1_removedFromStage(arg1:starling.events.Event):void
        {
            this.removedFromStageHandler(arg1);
            return;
        }

        internal function _GPSiesSearch_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("GPSIES_SEARCH_TITLE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.title")
            result[1] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight;
            }, null, "scroller.height")
            result[2] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "scroller.width")
            result[3] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "list.width")
            result[4] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("GPSIES_SEARCH_BUTTON");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "searchButton.label")
            result[5] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "searchButton.width")
            result[6] = new feathers.binding.Binding(this, function ():Boolean
            {
                return !loading;
            }, null, "_GPSiesSearch_Label1.includeInLayout")
            result[7] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_GPSiesSearch_Label1.maxWidth")
            result[8] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUSUBITEM;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_GPSiesSearch_Label1.styleName")
            result[9] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=_gpsiesInfo;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_GPSiesSearch_Label1.text")
            result[10] = new feathers.binding.Binding(this, function ():Boolean
            {
                return !loading;
            }, null, "_GPSiesSearch_Label1.visible")
            result[11] = new feathers.binding.Binding(this, null, null, "movie.includeInLayout", "loading");
            result[12] = new feathers.binding.Binding(this, null, null, "movie.visible", "loading");
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

        public function get list():frontend.components.menuList.MenuList
        {
            return this._3322014list;
        }

        public var _GPSiesSearch_Label1:feathers.controls.Label;

        internal var _1268861541footer:frontend.screen.component.Footer;

        internal var _3322014list:frontend.components.menuList.MenuList;

        internal var _104087344movie:feathers.controls.LayoutGroup;

        internal var _402164678scroller:frontend.components.scrollContainer.CustomVScrollContainer;

        internal var _365389062searchButton:feathers.controls.Button;

        internal var _2009185754_gpsiesInfo:String="";

        internal var _maximumMaxDistance:Number=500000;

        internal var _maximumRadius:Number=100000;

        internal var movieClip:starling.display.MovieClip;

        internal var sportsItem:frontend.components.menuList.MenuListItem;

        internal var _336650556loading:Boolean=false;

        mx_internal var _bindingsBeginWithWord:Object;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


