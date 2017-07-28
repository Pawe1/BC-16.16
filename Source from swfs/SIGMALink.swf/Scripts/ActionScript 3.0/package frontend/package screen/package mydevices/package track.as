//package track
//  class TrackSelector
package frontend.screen.mydevices.track 
{
    import __AS3__.vec.*;
    import backend.utils.*;
    import core.general.*;
    import core.route.*;
    import core.units.*;
    import debug.*;
    import feathers.binding.*;
    import feathers.controls.*;
    import feathers.controls.renderers.*;
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
    import frontend.components.button.*;
    import frontend.components.list.*;
    import frontend.components.menuList.*;
    import frontend.screen.component.*;
    import frontend.screen.tracks.tabs.list.*;
    import handler.*;
    import init.interfaces.*;
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
    
    public class TrackSelector extends frontend.screen.component.CustomScreen implements feathers.binding.IBindingClient
    {
        public function TrackSelector()
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
            bindings = this._TrackSelector_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_mydevices_track_TrackSelectorWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return TrackSelector[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.allowCaching = false;
            this.hasBackwardNavigation = true;
            this.saveAsOldScreen = false;
            this.mxmlContent = [this._TrackSelector_LayoutGroup1_i(), this._TrackSelector_Footer1_i()];
            this.addEventListener("addedToStage", this.___TrackSelector_CustomScreen1_addedToStage);
            this.addEventListener("initialize", this.___TrackSelector_CustomScreen1_initialize);
            this.addEventListener("removedFromStage", this.___TrackSelector_CustomScreen1_removedFromStage);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        public function set row1(arg1:feathers.controls.LayoutGroup):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._3506583row1;
            if (loc1 !== arg1) 
            {
                this._3506583row1 = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "row1", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get download():Boolean
        {
            return this._1427818632download;
        }

        public function set download(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1427818632download;
            if (loc1 !== arg1) 
            {
                this._1427818632download = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "download", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        protected function get _tracksDataProvider():feathers.data.ListCollection
        {
            return this._850614018_tracksDataProvider;
        }

        protected function set _tracksDataProvider(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._850614018_tracksDataProvider;
            if (loc1 !== arg1) 
            {
                this._850614018_tracksDataProvider = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_tracksDataProvider", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _customList():frontend.components.list.CustomList
        {
            return this._493623986_customList;
        }

        internal function set _customList(arg1:frontend.components.list.CustomList):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._493623986_customList;
            if (loc1 !== arg1) 
            {
                this._493623986_customList = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_customList", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function ___TrackSelector_CustomScreen1_addedToStage(arg1:starling.events.Event):void
        {
            this.onAddedToStage(arg1);
            return;
        }

        internal function get _listTitle():String
        {
            return this._1571499739_listTitle;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            TrackSelector._watcherSetupUtil = arg1;
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

        internal static function get ROW_PADDING():Number
        {
            return TrackSelector._25669012ROW_PADDING;
        }

        internal static function set ROW_PADDING(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=TrackSelector._25669012ROW_PADDING;
            if (loc1 !== arg1) 
            {
                TrackSelector._25669012ROW_PADDING = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "ROW_PADDING", loc1, arg1, TrackSelector);
                loc3 = TrackSelector.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get staticEventDispatcher():starling.events.EventDispatcher
        {
            return _staticBindingEventDispatcher;
        }

        
        {
            _25669012ROW_PADDING = 15 * SIGMALink.scaleFactor;
            _staticBindingEventDispatcher = new starling.events.EventDispatcher();
        }

        protected function onInit(arg1:starling.events.Event):void
        {
            this._customList = new frontend.components.list.CustomList();
            this._customList.height = frontend.components.menuList.MenuList.ROW_HEIGHT * 3;
            this._customList.width = SIGMALink.appWidth;
            this._customList.allowMultipleSelection = false;
            this._customList.autoHideBackground = false;
            this._customList.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            this._listStateHandler = new frontend.components.list.ListStateHandler(this._customList);
            return;
        }

        protected function onResizeRow(arg1:starling.events.Event):void
        {
            this.listLoader.height = SIGMALink.containerHeight - this.row1.height;
            return;
        }

        internal function onRemovedFromStage():void
        {
            handler.ViewHandler.getInstance().removeBackFunction(this.backButtonFunction);
            return;
        }

        protected function backButtonFunction():void
        {
            handler.ViewHandler.getInstance().goBack();
            return;
        }

        protected function onAddedToStage(arg1:starling.events.Event):void
        {
            var loc3:*=null;
            handler.ViewHandler.getInstance().addBackFunction(this.backButtonFunction);
            var loc1:*=0;
            var loc2:*=this.loadedTracks.length;
            this._tracksDataProvider = new feathers.data.ListCollection();
            loc1 = 0;
            while (loc1 < loc2) 
            {
                loc3 = new frontend.screen.tracks.tabs.list.MyTracksListItem();
                loc3.GUID = (this.loadedTracks.getItemAt(loc1) as core.route.Route).GUID;
                loc3.track = this.loadedTracks.getItemAt(loc1) as core.route.Route;
                loc3.icon = null;
                loc3.distance = backend.utils.DataUtils.distanceFormatter.format(backend.utils.DataUtils.distanceConverter.convert((this.loadedTracks.getItemAt(loc1) as core.route.Route).distance));
                loc3.distanceUnit = backend.utils.DataUtils.unitStringDistance;
                loc3.altitude = backend.utils.DataUtils.altitudeFormatter.format(backend.utils.DataUtils.altitudeConverter.convert((this.loadedTracks.getItemAt(loc1) as core.route.Route).altitudeDifferencesUphill));
                loc3.altitudeUnit = backend.utils.DataUtils.unitStringAltitude;
                this._tracksDataProvider.push(loc3);
                ++loc1;
            }
            if (this.download) 
            {
                this._listTitle = utils.LanguageManager.getString("DEVICEVIEW.DEVICE_TRACKS_SELECT_TRACK");
                this._customList.itemRendererFactory = this.tracksMultiSelectItemRenderer;
            }
            this._customList.dataProvider = this._tracksDataProvider;
            this.listLoader.checkDataProvider();
            return;
        }

        internal function tracksMultiSelectItemRenderer():feathers.controls.renderers.IListItemRenderer
        {
            var loc1:*=new frontend.screen.tracks.tabs.list.MyTracksRenderer();
            loc1.isEditState(true);
            loc1.allowMultiSelection = true;
            return loc1;
        }

        internal function nextStepSave(arg1:starling.events.TouchEvent):void
        {
            var loc1:*=0;
            var loc2:*=this._tracksDataProvider.length;
            var loc3:*=new Vector.<core.route.Route>();
            loc1 = 0;
            while (loc1 < loc2) 
            {
                if ((this._tracksDataProvider.getItemAt(loc1) as frontend.screen.tracks.tabs.list.MyTracksListItem).isSelected()) 
                {
                    debug.Debug.debug("adding " + (this._tracksDataProvider.getItemAt(loc1) as frontend.screen.tracks.tabs.list.MyTracksListItem).track.name + " to queue");
                    loc3.push((this._tracksDataProvider.getItemAt(loc1) as frontend.screen.tracks.tabs.list.MyTracksListItem).track);
                    (this._tracksDataProvider.getItemAt(loc1) as frontend.screen.tracks.tabs.list.MyTracksListItem).removeSelection();
                }
                ++loc1;
            }
            this._listStateHandler.setNormalState();
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_TRACKS_TRANSFER, {"unit":this.unit, "transferModeDownload":true, "loadHeader":false, "tracksHeader":loc3}, handler.ViewHandler.slideToLeftTransition(), true);
            return;
        }

        internal function _TrackSelector_LayoutGroup1_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._TrackSelector_VerticalLayout1_c();
            loc1.mxmlContent = [this._TrackSelector_LayoutGroup2_i(), this._TrackSelector_ListLoader1_i()];
            loc1.id = "_TrackSelector_LayoutGroup1";
            this._TrackSelector_LayoutGroup1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_TrackSelector_LayoutGroup1", this._TrackSelector_LayoutGroup1);
            return loc1;
        }

        internal function _TrackSelector_VerticalLayout1_c():feathers.layout.VerticalLayout
        {
            var loc1:*=new feathers.layout.VerticalLayout();
            loc1.gap = 1;
            loc1.useVirtualLayout = true;
            return loc1;
        }

        internal function _TrackSelector_LayoutGroup2_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.mxmlContent = [this._TrackSelector_Label1_i()];
            loc1.addEventListener("resize", this.__row1_resize);
            loc1.id = "row1";
            this.row1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "row1", this.row1);
            return loc1;
        }

        internal function _TrackSelector_Label1_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.id = "_TrackSelector_Label1";
            this._TrackSelector_Label1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_TrackSelector_Label1", this._TrackSelector_Label1);
            return loc1;
        }

        public function __row1_resize(arg1:starling.events.Event):void
        {
            this.onResizeRow(arg1);
            return;
        }

        internal function _TrackSelector_ListLoader1_i():frontend.components.list.ListLoader
        {
            var loc1:*=new frontend.components.list.ListLoader();
            loc1.id = "listLoader";
            this.listLoader = loc1;
            feathers.binding.BindingManager.executeBindings(this, "listLoader", this.listLoader);
            return loc1;
        }

        internal function _TrackSelector_Footer1_i():frontend.screen.component.Footer
        {
            var loc1:*=new frontend.screen.component.Footer();
            loc1.forceRightButton = true;
            loc1.mxmlContent = [this._TrackSelector_IconButton1_i()];
            loc1.id = "footer";
            this.footer = loc1;
            feathers.binding.BindingManager.executeBindings(this, "footer", this.footer);
            return loc1;
        }

        internal function _TrackSelector_IconButton1_i():frontend.components.button.IconButton
        {
            var loc1:*=new frontend.components.button.IconButton();
            loc1.touchHandler = this.nextStepSave;
            loc1.id = "nextButton";
            this.nextButton = loc1;
            feathers.binding.BindingManager.executeBindings(this, "nextButton", this.nextButton);
            return loc1;
        }

        internal function set _listTitle(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1571499739_listTitle;
            if (loc1 !== arg1) 
            {
                this._1571499739_listTitle = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_listTitle", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function ___TrackSelector_CustomScreen1_initialize(arg1:starling.events.Event):void
        {
            this.onInit(arg1);
            return;
        }

        public function ___TrackSelector_CustomScreen1_removedFromStage(arg1:starling.events.Event):void
        {
            this.onRemovedFromStage();
            return;
        }

        internal function _TrackSelector_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("DEVICEVIEW.DEVICE_TRACKS_SELECT");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.title")
            result[1] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            }, null, "_TrackSelector_LayoutGroup1.backgroundSkin")
            result[2] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight;
            }, null, "_TrackSelector_LayoutGroup1.height")
            result[3] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_TrackSelector_LayoutGroup1.width")
            result[4] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            }, null, "row1.backgroundSkin")
            result[5] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.components.menuList.MenuList.ROW_HEIGHT_SMALL;
            }, null, "row1.height")
            result[6] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return new feathers.layout.AnchorLayout();
            }, null, "row1.layout")
            result[7] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "row1.width")
            result[8] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, ROW_PADDING, NaN, 0);
            }, null, "_TrackSelector_Label1.layoutData")
            result[9] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUITEM;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_TrackSelector_Label1.styleName")
            result[10] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=_listTitle;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_TrackSelector_Label1.text")
            result[11] = new feathers.binding.Binding(this, function ():feathers.controls.Scroller
            {
                return _customList;
            }, null, "listLoader.list")
            result[12] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "listLoader.width")
            result[13] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=download ? frontend.Textures.saveiconwhite : frontend.Textures.arrowRight;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "nextButton.image")
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

        public function get nextButton():frontend.components.button.IconButton
        {
            return this._1749722107nextButton;
        }

        public function set nextButton(arg1:frontend.components.button.IconButton):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1749722107nextButton;
            if (loc1 !== arg1) 
            {
                this._1749722107nextButton = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "nextButton", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get row1():feathers.controls.LayoutGroup
        {
            return this._3506583row1;
        }

        public var _TrackSelector_Label1:feathers.controls.Label;

        public var _TrackSelector_LayoutGroup1:feathers.controls.LayoutGroup;

        internal var _1268861541footer:frontend.screen.component.Footer;

        internal var _159473233listLoader:frontend.components.list.ListLoader;

        internal var _1749722107nextButton:frontend.components.button.IconButton;

        internal var _3506583row1:feathers.controls.LayoutGroup;

        internal var _1427818632download:Boolean=true;

        public var trainings:__AS3__.vec.Vector.<core.training.Training>;

        internal var _unit:core.units.Unit;

        protected var _850614018_tracksDataProvider:feathers.data.ListCollection;

        internal var _493623986_customList:frontend.components.list.CustomList;

        internal var _listStateHandler:frontend.components.list.ListStateHandler;

        internal var _1571499739_listTitle:String="";

        internal static var _25669012ROW_PADDING:Number;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        internal static var _staticBindingEventDispatcher:starling.events.EventDispatcher;

        mx_internal var _bindingsByDestination:Object;

        public var loadedTracks:init.interfaces.IVectorList;
    }
}


