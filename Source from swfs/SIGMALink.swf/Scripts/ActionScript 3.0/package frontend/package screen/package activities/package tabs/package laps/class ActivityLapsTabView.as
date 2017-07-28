//class ActivityLapsTabView
package frontend.screen.activities.tabs.laps 
{
    import backend.utils.*;
    import configCache.*;
    import core.activities.*;
    import core.general.*;
    import core.marker.*;
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
    import frontend.components.scrollContainer.*;
    import frontend.components.tab.*;
    import frontend.components.tabbar.*;
    import frontend.components.tabbarbase.*;
    import frontend.screen.activities.*;
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
    import utils.format.*;
    
    use namespace mx_internal;
    
    public class ActivityLapsTabView extends frontend.components.tabbarbase.TabLayoutScroller implements feathers.binding.IBindingClient
    {
        public function ActivityLapsTabView()
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
            bindings = this._ActivityLapsTabView_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_activities_tabs_laps_ActivityLapsTabViewWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return frontend.screen.activities.tabs.laps.ActivityLapsTabView[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.ignoreVScrollPolicySetting = true;
            this.verticalScrollPolicy = "off";
            this.layout = this._ActivityLapsTabView_AnchorLayout1_c();
            this.mxmlContent = [this._ActivityLapsTabView_TextTabBar1_i(), this._ActivityLapsTabView_LayoutGroup1_i()];
            this.addEventListener("initialize", this.___ActivityLapsTabView_TabLayoutScroller1_initialize);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        public function get tabbar():frontend.components.tabbar.TextTabBar
        {
            return this._881387426tabbar;
        }

        public function set tabbar(arg1:frontend.components.tabbar.TextTabBar):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._881387426tabbar;
            if (loc1 !== arg1) 
            {
                this._881387426tabbar = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "tabbar", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get tableHeader():feathers.controls.LayoutGroup
        {
            return this._65701893tableHeader;
        }

        public function set tableHeader(arg1:feathers.controls.LayoutGroup):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._65701893tableHeader;
            if (loc1 !== arg1) 
            {
                this._65701893tableHeader = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "tableHeader", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function set data(arg1:Object):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.data;
            if (loc1 !== arg1) 
            {
                this._3076010data = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "data", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get autolLapsMarkerList():feathers.data.ListCollection
        {
            return this._1866457677autolLapsMarkerList;
        }

        public function get data():Object
        {
            return this._data;
        }

        internal function set _3076010data(arg1:Object):void
        {
            this._data = arg1 as core.activities.Activity;
            return;
        }

        internal function set autolLapsMarkerList(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1866457677autolLapsMarkerList;
            if (loc1 !== arg1) 
            {
                this._1866457677autolLapsMarkerList = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "autolLapsMarkerList", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get manualLapsMarkerList():feathers.data.ListCollection
        {
            return this._1445284426manualLapsMarkerList;
        }

        internal function set manualLapsMarkerList(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1445284426manualLapsMarkerList;
            if (loc1 !== arg1) 
            {
                this._1445284426manualLapsMarkerList = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "manualLapsMarkerList", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get tabBarDataProvider():feathers.data.ListCollection
        {
            return this._273520409tabBarDataProvider;
        }

        internal function set tabBarDataProvider(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._273520409tabBarDataProvider;
            if (loc1 !== arg1) 
            {
                this._273520409tabBarDataProvider = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "tabBarDataProvider", loc1, arg1, this);
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
            frontend.screen.activities.tabs.laps.ActivityLapsTabView._watcherSetupUtil = arg1;
            return;
        }

        protected function init(arg1:starling.events.Event):void
        {
            this._currentSelectedTab = configCache.ConfigCache.getInstance().getValue(SELECTED_MARKER_TAB, AUTO_LAPS);
            var loc1:*=frontend.screen.activities.tabs.laps.ActivityLapItemListRenderer.COL_WIDTH;
            var loc2:*=frontend.screen.activities.tabs.laps.ActivityLapItemListRenderer.COL_PADDING;
            var loc3:*=new feathers.controls.Label();
            loc3.text = utils.LanguageManager.getString("ACTIVIY_TAB_LAPS_DISTANCE") + " [" + backend.utils.DataUtils.unitStringDistance + "]";
            loc3.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_WHITELABEL;
            loc3.wordWrap = false;
            this.tableHeader.addChild(loc3);
            loc3.validate();
            loc3.width = loc1;
            loc3.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, loc2, NaN, 0);
            var loc4:*=new feathers.controls.Label();
            loc4.text = utils.LanguageManager.getString("ACTIVIY_TAB_LAPS_TIME") + " [" + backend.utils.DataUtils.unitStringTimeHours + "]";
            loc4.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_WHITELABEL;
            loc4.wordWrap = false;
            this.tableHeader.addChild(loc4);
            loc4.validate();
            loc4.width = loc1;
            loc4.layoutData = new feathers.layout.AnchorLayoutData(NaN, loc2 + loc1 + loc2, NaN, NaN, NaN, 0);
            this.speedLabel = new feathers.controls.Label();
            this.speedLabel.text = utils.LanguageManager.getString("ACTIVIY_TAB_LAPS_SPEED");
            this.speedLabel.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_WHITELABEL;
            this.speedLabel.wordWrap = false;
            this.tableHeader.addChild(this.speedLabel);
            this.speedLabel.width = loc1;
            this.speedLabel.layoutData = new feathers.layout.AnchorLayoutData(NaN, loc2, NaN, NaN, NaN, 0);
            handler.ViewHandler.getInstance().addEventListener(handler.ViewHandler.EVENT_SPEED_FORMAT_CHANGED, this.onSpeedFormatChanged);
            return;
        }

        internal function onSpeedFormatChanged(arg1:starling.events.Event):void
        {
            this.showContent();
            return;
        }

        public override function showContent():void
        {
            var loc1:*=0;
            var loc2:*=null;
            this.manualLapsMarkerList = new feathers.data.ListCollection();
            this.autolLapsMarkerList = new feathers.data.ListCollection();
            if (configCache.ConfigCache.getInstance().getSportSpeedFormatValue(this._data.sport) != utils.format.SpeedFormat.DISTANCE_PER_TIME) 
            {
                this.speedLabel.text = utils.LanguageManager.getString("ACTIVIY_TAB_LAPS_SPEED") + " [" + backend.utils.DataUtils.unitStringSpeedTime + "]";
            }
            else 
            {
                this.speedLabel.text = utils.LanguageManager.getString("ACTIVIY_TAB_LAPS_SPEED") + " [" + backend.utils.DataUtils.unitStringSpeed + "]";
            }
            this.speedLabel.validate();
            var loc3:*=this._data.markerList.length;
            loc1 = 0;
            while (loc1 < loc3) 
            {
                loc2 = this._data.markerList[loc1];
                if (core.general.MarkerType.LAP != loc2.type) 
                {
                    if (core.general.MarkerType.AUTO_LAP == loc2.type) 
                    {
                        this.autolLapsMarkerList.addItem(loc2);
                    }
                }
                else 
                {
                    this.manualLapsMarkerList.addItem(loc2);
                }
                ++loc1;
            }
            var loc4:*=new feathers.data.ListCollection();
            if (this.autolLapsMarkerList.length > 0) 
            {
                loc4.push({"data":AUTO_LAPS, "label":utils.LanguageManager.getString("ACTIVIY_TAB_LAPS_AUTO")});
            }
            else 
            {
                this._currentSelectedTab = MANUAL_LAPS;
                configCache.ConfigCache.getInstance().setValue(SELECTED_MARKER_TAB, MANUAL_LAPS);
            }
            loc4.push({"data":MANUAL_LAPS, "label":utils.LanguageManager.getString("ACTIVIY_TAB_LAPS_MANUAL")});
            this.tabbar.dataProvider = loc4;
            this.tabbar.addEventListener(starling.events.Event.CHANGE, this.onTabeSelectionChange);
            this.validateDataProvider();
            return;
        }

        public override function hideContent():void
        {
            this.laplist.dataProvider = new feathers.data.ListCollection();
            return;
        }

        internal function onTabeSelectionChange(arg1:starling.events.Event):void
        {
            this._currentSelectedTab = (arg1.currentTarget as feathers.controls.TabBar).selectedItem.data;
            configCache.ConfigCache.getInstance().setValue(SELECTED_MARKER_TAB, this._currentSelectedTab);
            this.validateDataProvider();
            return;
        }

        internal function validateDataProvider():void
        {
            if (!this.autolLapsMarkerList || !this.manualLapsMarkerList) 
            {
                flash.utils.setTimeout(this.validateDataProvider, 100);
                return;
            }
            var loc1:*=this._currentSelectedTab;
            switch (loc1) 
            {
                case AUTO_LAPS:
                {
                    this.laplist.dataProvider = this.autolLapsMarkerList;
                    this.tabbar.selectedIndex = 0;
                    break;
                }
                case MANUAL_LAPS:
                {
                    this.laplist.dataProvider = this.manualLapsMarkerList;
                    this.tabbar.selectedIndex = (this.tabbar.dataProvider.length - 1);
                    break;
                }
            }
            return;
        }

        internal function onListTouch(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            if (this.laplist.dataProvider.getItemAt(0) is core.marker.Marker && this.laplist.selectedIndex > -1) 
            {
                this.lapDetailsGroup = new frontend.screen.activities.tabs.laps.ActivityLapDetailsView();
                this.lapDetailsGroup.layoutData = new feathers.layout.AnchorLayoutData();
                this.lapDetailsGroup.lapCurrent = this.laplist.selectedIndex + 1;
                this.lapDetailsGroup.markerList = this.laplist.dataProvider;
                addChild(this.lapDetailsGroup);
                this.laplist.selectedItem = null;
                handler.ViewHandler.getInstance().addBackFunction(this.closeLapDetails);
            }
            return;
        }

        public function closeLapDetails():void
        {
            removeChild(this.lapDetailsGroup);
            this.lapDetailsGroup = null;
            return;
        }

        internal function _ActivityLapsTabView_AnchorLayout1_c():feathers.layout.AnchorLayout
        {
            var loc1:*=new feathers.layout.AnchorLayout();
            return loc1;
        }

        internal function _ActivityLapsTabView_TextTabBar1_i():frontend.components.tabbar.TextTabBar
        {
            var loc1:*=new frontend.components.tabbar.TextTabBar();
            loc1.id = "tabbar";
            this.tabbar = loc1;
            feathers.binding.BindingManager.executeBindings(this, "tabbar", this.tabbar);
            return loc1;
        }

        internal function _ActivityLapsTabView_LayoutGroup1_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._ActivityLapsTabView_VerticalLayout1_c();
            loc1.mxmlContent = [this._ActivityLapsTabView_LayoutGroup2_i(), this._ActivityLapsTabView_CustomVScrollContainer1_i()];
            loc1.id = "tabVGroup";
            this.tabVGroup = loc1;
            feathers.binding.BindingManager.executeBindings(this, "tabVGroup", this.tabVGroup);
            return loc1;
        }

        internal function _ActivityLapsTabView_VerticalLayout1_c():feathers.layout.VerticalLayout
        {
            var loc1:*=new feathers.layout.VerticalLayout();
            return loc1;
        }

        internal function _ActivityLapsTabView_LayoutGroup2_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._ActivityLapsTabView_AnchorLayout2_c();
            loc1.id = "tableHeader";
            this.tableHeader = loc1;
            feathers.binding.BindingManager.executeBindings(this, "tableHeader", this.tableHeader);
            return loc1;
        }

        internal function _ActivityLapsTabView_AnchorLayout2_c():feathers.layout.AnchorLayout
        {
            var loc1:*=new feathers.layout.AnchorLayout();
            return loc1;
        }

        internal function _ActivityLapsTabView_CustomVScrollContainer1_i():frontend.components.scrollContainer.CustomVScrollContainer
        {
            var loc1:*=new frontend.components.scrollContainer.CustomVScrollContainer();
            loc1.clipContent = true;
            loc1.mxmlContent = [this._ActivityLapsTabView_List1_i()];
            loc1.id = "scrollContainer";
            this.scrollContainer = loc1;
            feathers.binding.BindingManager.executeBindings(this, "scrollContainer", this.scrollContainer);
            return loc1;
        }

        internal function _ActivityLapsTabView_List1_i():feathers.controls.List
        {
            var loc1:*=new feathers.controls.List();
            loc1.addEventListener("touch", this.__laplist_touch);
            loc1.id = "laplist";
            this.laplist = loc1;
            feathers.binding.BindingManager.executeBindings(this, "laplist", this.laplist);
            return loc1;
        }

        public function __laplist_touch(arg1:starling.events.TouchEvent):void
        {
            this.onListTouch(arg1);
            return;
        }

        public function ___ActivityLapsTabView_TabLayoutScroller1_initialize(arg1:starling.events.Event):void
        {
            this.init(arg1);
            return;
        }

        internal function _ActivityLapsTabView_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.uhr;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.icon")
            result[1] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ACTIVITIES.TABS.LAPS.TITLE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.label")
            result[2] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.components.tabbar.TextTabBar.SELECTED_HEIGHT;
            }, null, "tabbar.height")
            result[3] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(PADDING_TOP);
            }, null, "tabbar.layoutData")
            result[4] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "tabbar.width")
            result[5] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight - frontend.components.tab.TabContainer.TAB_HEIGHT - frontend.screen.activities.ActivityView.SPORT_ROW_HEIGHT - frontend.components.tabbar.TextTabBar.SELECTED_HEIGHT;
            }, null, "tabVGroup.height")
            result[6] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(PADDING_TOP + frontend.components.tabbar.TextTabBar.SELECTED_HEIGHT);
            }, null, "tabVGroup.layoutData")
            result[7] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "tabVGroup.width")
            result[8] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.DARKFONT);
            }, null, "tableHeader.backgroundSkin")
            result[9] = new feathers.binding.Binding(this, function ():Number
            {
                return LIST_HEADER_HEIGHT;
            }, null, "tableHeader.height")
            result[10] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "tableHeader.width")
            result[11] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight - frontend.components.tab.TabContainer.TAB_HEIGHT - frontend.screen.activities.ActivityView.SPORT_ROW_HEIGHT - LIST_HEADER_HEIGHT;
            }, null, "scrollContainer.height")
            result[12] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "scrollContainer.width")
            result[13] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight - frontend.components.tab.TabContainer.TAB_HEIGHT - frontend.screen.activities.ActivityView.SPORT_ROW_HEIGHT - LIST_HEADER_HEIGHT - frontend.components.tabbar.TextTabBar.SELECTED_HEIGHT;
            }, null, "laplist.height")
            result[14] = new feathers.binding.Binding(this, function ():Class
            {
                return frontend.screen.activities.tabs.laps.ActivityLapItemListRenderer;
            }, null, "laplist.itemRendererType")
            result[15] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "laplist.width")
            return result;
        }

        public function get laplist():feathers.controls.List
        {
            return this._50066247laplist;
        }

        public function set laplist(arg1:feathers.controls.List):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._50066247laplist;
            if (loc1 !== arg1) 
            {
                this._50066247laplist = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "laplist", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get scrollContainer():frontend.components.scrollContainer.CustomVScrollContainer
        {
            return this._2128618444scrollContainer;
        }

        public function set scrollContainer(arg1:frontend.components.scrollContainer.CustomVScrollContainer):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._2128618444scrollContainer;
            if (loc1 !== arg1) 
            {
                this._2128618444scrollContainer = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "scrollContainer", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get tabVGroup():feathers.controls.LayoutGroup
        {
            return this._1649788830tabVGroup;
        }

        public function set tabVGroup(arg1:feathers.controls.LayoutGroup):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1649788830tabVGroup;
            if (loc1 !== arg1) 
            {
                this._1649788830tabVGroup = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "tabVGroup", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal static const AUTO_LAPS:String="autoLaps";

        internal static const LIST_HEADER_HEIGHT:Number=53 * SIGMALink.scaleFactor;

        internal static const MANUAL_LAPS:String="manualLaps";

        internal static const PADDING_TOP:Number=0;

        internal static const SELECTED_MARKER_TAB:String="selectedMarkerTab";

        internal static const UNIT_WIDTH:Number=50 * SIGMALink.scaleFactor;

        internal var _50066247laplist:feathers.controls.List;

        internal var _2128618444scrollContainer:frontend.components.scrollContainer.CustomVScrollContainer;

        internal var _1649788830tabVGroup:feathers.controls.LayoutGroup;

        internal var _881387426tabbar:frontend.components.tabbar.TextTabBar;

        internal var _65701893tableHeader:feathers.controls.LayoutGroup;

        internal var _data:core.activities.Activity;

        internal var _currentSelectedTab:String="autoLaps";

        internal var _1866457677autolLapsMarkerList:feathers.data.ListCollection;

        internal var lapDetailsGroup:frontend.screen.activities.tabs.laps.ActivityLapDetailsView;

        internal var _1445284426manualLapsMarkerList:feathers.data.ListCollection;

        internal var speedLabel:feathers.controls.Label;

        internal var _273520409tabBarDataProvider:feathers.data.ListCollection;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


