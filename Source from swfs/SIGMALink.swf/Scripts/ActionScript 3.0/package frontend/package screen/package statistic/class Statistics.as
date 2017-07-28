//class Statistics
package frontend.screen.statistic 
{
    import configCache.*;
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
    import frontend.*;
    import frontend.components.button.*;
    import frontend.components.menuList.*;
    import frontend.components.menuList.editors.*;
    import frontend.components.menuList.editors.base.*;
    import frontend.components.popup.*;
    import frontend.components.tab.*;
    import frontend.components.tabbarbase.*;
    import frontend.screen.activities.list.*;
    import frontend.screen.component.*;
    import frontend.screen.statistic.tabs.*;
    import handler.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.core.*;
    import starling.display.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    import statistic.*;
    import utils.*;
    
    use namespace mx_internal;
    
    public class Statistics extends frontend.screen.component.CustomScreen implements feathers.binding.IBindingClient
    {
        public function Statistics()
        {
            var bindings:Array;
            var watchers:Array;
            var target:Object;
            var i:uint;
            var watcherSetupUtilClass:Object;

            var loc1:*;
            target = null;
            watcherSetupUtilClass = null;
            this._1797417381_buttonIconOffsetX = 52 * SIGMALink.scaleFactor;
            this._1495257986_buttonLabelOffsetX = -52 * SIGMALink.scaleFactor;
            this._1495257987_buttonLabelOffsetY = 2 * SIGMALink.scaleFactor;
            this.tabContents = new flash.utils.Dictionary();
            this.mx_internal::_bindings = [];
            this.mx_internal::_watchers = [];
            this.mx_internal::_bindingsByDestination = {};
            this.mx_internal::_bindingsBeginWithWord = {};
            super();
            bindings = this._Statistics_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_statistic_StatisticsWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return Statistics[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.allowCaching = false;
            this.hasBackwardNavigation = true;
            this.mxmlContent = [this._Statistics_TabContainer1_i(), this._Statistics_LayoutGroup1_i(), this._Statistics_Footer1_i()];
            this.addEventListener("initialize", this.___Statistics_CustomScreen1_initialize);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
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

        public function get statisticTabbar():frontend.components.tab.TabContainer
        {
            return this._893534670statisticTabbar;
        }

        public function set statisticTabbar(arg1:frontend.components.tab.TabContainer):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._893534670statisticTabbar;
            if (loc1 !== arg1) 
            {
                this._893534670statisticTabbar = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "statisticTabbar", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get yearSelection():frontend.components.button.IconButton
        {
            return this._160103887yearSelection;
        }

        public function set yearSelection(arg1:frontend.components.button.IconButton):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._160103887yearSelection;
            if (loc1 !== arg1) 
            {
                this._160103887yearSelection = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "yearSelection", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get currentTab():frontend.screen.statistic.tabs.StatisticTab2
        {
            return this._currentTab;
        }

        public function set currentTab(arg1:frontend.screen.statistic.tabs.StatisticTab2):void
        {
            this._currentTab = arg1;
            if (this._currentTab) 
            {
                this.yearSelectionVisible = !(this._currentTab.type == statistic.Statistic.X_YEAR);
            }
            return;
        }

        public function startLoading():void
        {
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
                this.loading = true;
            }
            return;
        }

        internal function get _buttonIconOffsetX():Number
        {
            return this._1797417381_buttonIconOffsetX;
        }

        internal function set _buttonIconOffsetX(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1797417381_buttonIconOffsetX;
            if (loc1 !== arg1) 
            {
                this._1797417381_buttonIconOffsetX = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_buttonIconOffsetX", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _buttonLabelOffsetX():Number
        {
            return this._1495257986_buttonLabelOffsetX;
        }

        internal function get _buttonLabelOffsetY():Number
        {
            return this._1495257987_buttonLabelOffsetY;
        }

        internal function set _buttonLabelOffsetY(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1495257987_buttonLabelOffsetY;
            if (loc1 !== arg1) 
            {
                this._1495257987_buttonLabelOffsetY = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_buttonLabelOffsetY", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get loading():Boolean
        {
            return this._336650556loading;
        }

        internal function set loading(arg1:Boolean):void
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

        internal function get yearSelectionVisible():Boolean
        {
            return this._246166435yearSelectionVisible;
        }

        internal function set yearSelectionVisible(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._246166435yearSelectionVisible;
            if (loc1 !== arg1) 
            {
                this._246166435yearSelectionVisible = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "yearSelectionVisible", loc1, arg1, this);
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
            Statistics._watcherSetupUtil = arg1;
            return;
        }

        protected function onInit(arg1:starling.events.Event):void
        {
            handler.ActivityHandler.getInstance().addEventListener(frontend.screen.activities.list.ActivityListEvent.RELOAD, this.onDataChanged);
            handler.ActivityHandler.getInstance().addEventListener(frontend.screen.activities.list.ActivityListEvent.UPDATE, this.onDataChanged);
            handler.ActivityHandler.getInstance().addEventListener(frontend.screen.activities.list.ActivityListEvent.DELETE, this.onDataChanged);
            return;
        }

        internal function onDataChanged(arg1:frontend.screen.activities.list.ActivityListEvent):void
        {
            debug.Debug.debug("onDataChanged");
            this.reloadTab = true;
            this._yearsWithData = new feathers.data.ListCollection(handler.ApplicationHandler.getInstance().yearsWithData);
            if (!handler.ViewHandler.getInstance().isActive(this)) 
            {
                return;
            }
            this.updateTab(this.currentTab);
            return;
        }

        protected override function validateProperties():void
        {
            if (handler.ViewHandler.getInstance().navigator.isTransitionActive) 
            {
                flash.utils.setTimeout(this.validateProperties, 100);
                return;
            }
            if (this.tabsInitialized) 
            {
                this.updateTab(this.currentTab);
                return;
            }
            this.reloadTab = true;
            this._yearsWithData = new feathers.data.ListCollection(handler.ApplicationHandler.getInstance().yearsWithData);
            var loc1:*=configCache.ConfigCache.getInstance().getValue(configCache.ConfigCacheObject.STATISTIC_SELECTED_YEAR, new Date().fullYear);
            this.yearSelection.label = loc1.toString();
            var loc2:*=configCache.ConfigCache.getInstance().getValue(configCache.ConfigCacheObject.STATISTIC_SELECTED_TAB, statistic.Statistic.X_WEEK);
            this.addStatisticTab2(statistic.Statistic.X_WEEK, loc2 == statistic.Statistic.X_WEEK);
            this.addStatisticTab2(statistic.Statistic.X_MONTH, loc2 == statistic.Statistic.X_MONTH);
            this.addStatisticTab2(statistic.Statistic.X_YEAR, loc2 == statistic.Statistic.X_YEAR);
            return;
        }

        internal function addStatisticTab2(arg1:String, arg2:Boolean=false):void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=arg1;
            switch (loc3) 
            {
                case statistic.Statistic.X_WEEK:
                {
                    loc2 = utils.LanguageManager.getString("STATISTIC.WEEKS_TITLE");
                    break;
                }
                case statistic.Statistic.X_MONTH:
                {
                    loc2 = utils.LanguageManager.getString("STATISTIC.MONTHS_TITLE");
                    break;
                }
                case statistic.Statistic.X_YEAR:
                {
                    loc2 = utils.LanguageManager.getString("STATISTIC.YEARS_TITLE");
                    break;
                }
            }
            loc1 = new frontend.screen.statistic.tabs.StatisticTab2(loc2, arg1, this.startLoading, this.stopLoading);
            this.statisticTabbar.addTab(loc1, arg2);
            this.tabContents[arg1] = loc1;
            if (arg2) 
            {
                this.currentTab = loc1;
                this.updateTab(loc1);
            }
            return;
        }

        internal function updateTab(arg1:frontend.screen.statistic.tabs.StatisticTab2):void
        {
            arg1.addEventListener(frontend.screen.statistic.tabs.StatisticTab2.COMPLETE, this.onTabComplete);
            arg1.loadStatistic();
            return;
        }

        internal function onTabComplete(arg1:starling.events.Event):void
        {
            var loc2:*=null;
            var loc1:*=arg1.currentTarget as frontend.screen.statistic.tabs.StatisticTab2;
            loc1.removeEventListener(frontend.screen.statistic.tabs.StatisticTab2.COMPLETE, this.onTabComplete);
            if (!this.tabsInitialized && loc1 == this.currentTab) 
            {
                frontend.screen.statistic.tabs.StatisticTab2.setHiddenFlag(loc1, false);
                this.tabsInitialized = true;
                loc2 = new flash.utils.Timer(500, 1);
                loc2.addEventListener(flash.events.TimerEvent.TIMER, this.onLoadOtherTabs);
                loc2.start();
            }
            return;
        }

        internal function onLoadOtherTabs(arg1:flash.events.TimerEvent):void
        {
            this.statisticTabbar.addEventListener(frontend.components.tab.TabEvent.CHANGED, this.tabChangedHandler);
            return;
        }

        internal function onCalenderIconClick(arg1:starling.events.TouchEvent):void
        {
            var loc2:*=null;
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            var loc1:*=configCache.ConfigCache.getInstance().getValue(configCache.ConfigCacheObject.STATISTIC_SELECTED_YEAR, new Date().fullYear);
            loc2 = new frontend.components.menuList.editors.SpinnerEditor();
            loc2.title = utils.LanguageManager.getString("STATISTIC.TITLE");
            loc2.rightHeaderText = utils.LanguageManager.getString("TOP_VALUES.YEAR_SELECT_CONFIRM");
            loc2.saveCompleteCallback = this.onYearSelectComplete;
            loc2.dataProvider = this._yearsWithData;
            loc2.rawValue = loc1.toString();
            frontend.components.popup.PopUpBase.showModalPopUp(loc2, true, false);
            return;
        }

        internal function onYearSelectComplete(arg1:frontend.components.menuList.MenuListItem, arg2:frontend.components.menuList.editors.base.EditorReturnObject):void
        {
            var loc1:*=int(arg2.rawValue);
            configCache.ConfigCache.getInstance().setValue(configCache.ConfigCacheObject.STATISTIC_SELECTED_YEAR, loc1);
            flash.utils.setTimeout(this.reloadTabs, 300, loc1);
            return;
        }

        internal function reloadTabs(arg1:int):void
        {
            var loc1:*=null;
            frontend.screen.statistic.tabs.StatisticTab2.resetAllFlags(this.tabContents);
            var loc2:*=0;
            var loc3:*=this.tabContents;
            for each (loc1 in loc3) 
            {
                if (loc1 == this.currentTab) 
                {
                    continue;
                }
                loc1.loadStatistic();
            }
            this.currentTab.addEventListener(frontend.screen.statistic.tabs.StatisticTab2.COMPLETE, this.onLoadComplete);
            this.currentTab.loadStatistic();
            this.yearSelection.label = arg1.toString();
            return;
        }

        internal function onLoadComplete(arg1:starling.events.Event):void
        {
            var loc1:*=arg1.currentTarget as frontend.screen.statistic.tabs.StatisticTab2;
            loc1.removeEventListener(frontend.screen.statistic.tabs.StatisticTab2.COMPLETE, this.onLoadComplete);
            frontend.screen.statistic.tabs.StatisticTab2.setHiddenFlag(loc1, false);
            return;
        }

        protected function tabChangedHandler(arg1:frontend.components.tab.TabEvent):void
        {
            var loc2:*=null;
            if (arg1.instance == this.currentTab) 
            {
                if (this.reloadTab) 
                {
                    this.reloadTab = false;
                }
                else 
                {
                    return;
                }
            }
            var loc1:*=arg1.dpObj;
            if (!loc1) 
            {
                return;
            }
            this.currentTab = arg1.instance as frontend.screen.statistic.tabs.StatisticTab2;
            var loc3:*=0;
            var loc4:*=this.tabContents;
            for each (loc2 in loc4) 
            {
                if (loc2 == this.currentTab) 
                {
                    continue;
                }
                frontend.screen.statistic.tabs.StatisticTab2.setHiddenFlag(loc2, true);
            }
            configCache.ConfigCache.getInstance().setValue(configCache.ConfigCacheObject.STATISTIC_SELECTED_TAB, this.currentTab.type);
            (loc1.instance as frontend.screen.statistic.tabs.StatisticTab2).addEventListener(frontend.screen.statistic.tabs.StatisticTab2.COMPLETE, this.onStatisticLoadedComplete);
            (loc1.instance as frontend.screen.statistic.tabs.StatisticTab2).loadStatistic();
            return;
        }

        internal function onStatisticLoadedComplete(arg1:starling.events.Event):void
        {
            var loc1:*=arg1.currentTarget as frontend.screen.statistic.tabs.StatisticTab2;
            loc1.removeEventListener(frontend.screen.statistic.tabs.StatisticTab2.COMPLETE, this.onStatisticLoadedComplete);
            frontend.screen.statistic.tabs.StatisticTab2.setHiddenFlag(loc1, false);
            return;
        }

        internal function set _buttonLabelOffsetX(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1495257986_buttonLabelOffsetX;
            if (loc1 !== arg1) 
            {
                this._1495257986_buttonLabelOffsetX = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_buttonLabelOffsetX", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function stopLoading():void
        {
            this.loading = false;
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

        internal function _Statistics_TabContainer1_i():frontend.components.tab.TabContainer
        {
            var loc1:*=new frontend.components.tab.TabContainer();
            loc1.useIconTabs = false;
            loc1.id = "statisticTabbar";
            this.statisticTabbar = loc1;
            feathers.binding.BindingManager.executeBindings(this, "statisticTabbar", this.statisticTabbar);
            return loc1;
        }

        internal function _Statistics_LayoutGroup1_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.id = "movie";
            this.movie = loc1;
            feathers.binding.BindingManager.executeBindings(this, "movie", this.movie);
            return loc1;
        }

        internal function _Statistics_Footer1_i():frontend.screen.component.Footer
        {
            var loc1:*=new frontend.screen.component.Footer();
            loc1.forceRightButton = true;
            loc1.mxmlContent = [this._Statistics_IconButton1_i()];
            loc1.id = "footer";
            this.footer = loc1;
            feathers.binding.BindingManager.executeBindings(this, "footer", this.footer);
            return loc1;
        }

        internal function _Statistics_IconButton1_i():frontend.components.button.IconButton
        {
            var loc1:*=new frontend.components.button.IconButton();
            loc1.verticalAlign = "middle";
            loc1.id = "yearSelection";
            this.yearSelection = loc1;
            feathers.binding.BindingManager.executeBindings(this, "yearSelection", this.yearSelection);
            return loc1;
        }

        public function ___Statistics_CustomScreen1_initialize(arg1:starling.events.Event):void
        {
            this.onInit(arg1);
            return;
        }

        internal function _Statistics_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("STATISTIC.TITLE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.title")
            result[1] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight;
            }, null, "statisticTabbar.height")
            result[2] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "statisticTabbar.width")
            result[3] = new feathers.binding.Binding(this, function ():Boolean
            {
                return loading;
            }, null, "movie.includeInLayout")
            result[4] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, NaN, 0, 0);
            }, null, "movie.layoutData")
            result[5] = new feathers.binding.Binding(this, function ():Boolean
            {
                return loading;
            }, null, "movie.visible")
            result[6] = new feathers.binding.Binding(this, function ():Number
            {
                return _buttonIconOffsetX;
            }, null, "yearSelection.iconOffsetX")
            result[7] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.calendericon;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "yearSelection.image")
            result[8] = new feathers.binding.Binding(this, function ():Boolean
            {
                return yearSelectionVisible;
            }, null, "yearSelection.includeInLayout")
            result[9] = new feathers.binding.Binding(this, function ():Number
            {
                return _buttonLabelOffsetX;
            }, null, "yearSelection.labelOffsetX")
            result[10] = new feathers.binding.Binding(this, function ():Number
            {
                return _buttonLabelOffsetY;
            }, null, "yearSelection.labelOffsetY")
            result[11] = new feathers.binding.Binding(this, function ():Function
            {
                return onCalenderIconClick;
            }, null, "yearSelection.touchHandler")
            result[12] = new feathers.binding.Binding(this, function ():Boolean
            {
                return yearSelectionVisible;
            }, null, "yearSelection.visible")
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

        public function get movie():feathers.controls.LayoutGroup
        {
            return this._104087344movie;
        }

        internal var _1268861541footer:frontend.screen.component.Footer;

        internal var _104087344movie:feathers.controls.LayoutGroup;

        internal var _893534670statisticTabbar:frontend.components.tab.TabContainer;

        internal var _160103887yearSelection:frontend.components.button.IconButton;

        internal var _currentTab:frontend.screen.statistic.tabs.StatisticTab2;

        internal var _1495257986_buttonLabelOffsetX:Number;

        internal var _1495257987_buttonLabelOffsetY:Number;

        internal var _initTabs:int=0;

        internal var _yearsWithData:feathers.data.ListCollection;

        internal var _336650556loading:Boolean=false;

        internal var movieClip:starling.display.MovieClip;

        internal var reloadTab:Boolean=false;

        internal var tabContents:flash.utils.Dictionary;

        internal var tabsInitialized:Boolean=false;

        internal var _246166435yearSelectionVisible:Boolean=true;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        internal var _1797417381_buttonIconOffsetX:Number;

        mx_internal var _bindingsBeginWithWord:Object;

        mx_internal var _bindings:Array;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


