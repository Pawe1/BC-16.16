//class ActivityView
package frontend.screen.activities 
{
    import backend.utils.*;
    import backend.utils.dataprovider.*;
    import backend.utils.dbUtils.*;
    import core.activities.*;
    import core.general.*;
    import core.units.*;
    import feathers.binding.*;
    import feathers.controls.*;
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
    import frontend.components.button.*;
    import frontend.components.map.*;
    import frontend.components.tab.*;
    import frontend.components.tabbarbase.*;
    import frontend.screen.activities.tabs.graph.*;
    import frontend.screen.activities.tabs.laps.*;
    import frontend.screen.activities.tabs.map.*;
    import frontend.screen.activities.tabs.phases.*;
    import frontend.screen.activities.tabs.values.*;
    import frontend.screen.component.*;
    import handler.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.display.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    
    use namespace mx_internal;
    
    public class ActivityView extends frontend.screen.component.CustomScreen implements feathers.binding.IBindingClient
    {
        public function ActivityView()
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
            bindings = this._ActivityView_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_activities_ActivityViewWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return frontend.screen.activities.ActivityView[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.allowCaching = false;
            this.hasBackwardNavigation = true;
            this.savePropertiesForBackNavigation = true;
            this.mxmlContent = [this._ActivityView_LayoutGroup1_i(), this._ActivityView_TabContainer1_i(), this._ActivityView_Footer1_i()];
            this.addEventListener("addedToStage", this.___ActivityView_CustomScreen1_addedToStage);
            this.addEventListener("removedFromStage", this.___ActivityView_CustomScreen1_removedFromStage);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        public function ___ActivityView_CustomScreen1_removedFromStage(arg1:starling.events.Event):void
        {
            this.onRemovedFromStage(arg1);
            return;
        }

        internal function _ActivityView_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():Number
            {
                return SPORT_ROW_HEIGHT;
            }, null, "sportRow.height")
            result[1] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return new feathers.layout.AnchorLayout();
            }, null, "sportRow.layout")
            result[2] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "sportRow.width")
            result[3] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, SPORT_ROW_PADDING, NaN, 0);
            }, null, "sportIcon.layoutData")
            result[4] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(NaN, SPORT_ROW_PADDING, NaN, NaN, NaN, 0);
            }, null, "activityDate.layoutData")
            result[5] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight - SPORT_ROW_HEIGHT;
            }, null, "activitiesTabbar.height")
            result[6] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(SPORT_ROW_HEIGHT);
            }, null, "activitiesTabbar.layoutData")
            result[7] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "activitiesTabbar.width")
            result[8] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.whiteshareicon;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ActivityView_IconButton1.image")
            result[9] = new feathers.binding.Binding(this, function ():Function
            {
                return shareActivity_handler;
            }, null, "_ActivityView_IconButton1.touchHandler")
            result[10] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.ghostIcon;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ActivityView_IconButton2.image")
            result[11] = new feathers.binding.Binding(this, function ():Boolean
            {
                return _ghostVisible;
            }, null, "_ActivityView_IconButton2.includeInLayout")
            result[12] = new feathers.binding.Binding(this, function ():Function
            {
                return sendGhostToDevice_handler;
            }, null, "_ActivityView_IconButton2.touchHandler")
            result[13] = new feathers.binding.Binding(this, function ():Boolean
            {
                return _ghostVisible;
            }, null, "_ActivityView_IconButton2.touchable")
            result[14] = new feathers.binding.Binding(this, function ():Boolean
            {
                return _ghostVisible;
            }, null, "_ActivityView_IconButton2.visible")
            result[15] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.infoIcon;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ActivityView_IconButton3.image")
            result[16] = new feathers.binding.Binding(this, function ():Function
            {
                return editActivity_handler;
            }, null, "_ActivityView_IconButton3.touchHandler")
            return result;
        }

        public function get activitiesTabbar():frontend.components.tab.TabContainer
        {
            return this._679224661activitiesTabbar;
        }

        public function set activitiesTabbar(arg1:frontend.components.tab.TabContainer):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._679224661activitiesTabbar;
            if (loc1 !== arg1) 
            {
                this._679224661activitiesTabbar = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "activitiesTabbar", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get activityDate():feathers.controls.Label
        {
            return this._1628321629activityDate;
        }

        public function set activityDate(arg1:feathers.controls.Label):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1628321629activityDate;
            if (loc1 !== arg1) 
            {
                this._1628321629activityDate = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "activityDate", loc1, arg1, this);
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

        internal function _ActivityView_Label1_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.id = "activityDate";
            this.activityDate = loc1;
            feathers.binding.BindingManager.executeBindings(this, "activityDate", this.activityDate);
            return loc1;
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

        public function get sportIcon():frontend.components.TextureImage
        {
            return this._970785267sportIcon;
        }

        public function set sportIcon(arg1:frontend.components.TextureImage):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._970785267sportIcon;
            if (loc1 !== arg1) 
            {
                this._970785267sportIcon = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "sportIcon", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get sportRow():feathers.controls.LayoutGroup
        {
            return this._1832421946sportRow;
        }

        internal function get _ghostVisible():Boolean
        {
            return this._799692994_ghostVisible;
        }

        internal function set _ghostVisible(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._799692994_ghostVisible;
            if (loc1 !== arg1) 
            {
                this._799692994_ghostVisible = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_ghostVisible", loc1, arg1, this);
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
            frontend.screen.activities.ActivityView._watcherSetupUtil = arg1;
            return;
        }

        
        {
            initialTabIndex = -1;
        }

        public override function dispose():void
        {
            if (this.activitiesTabbar) 
            {
                this.activitiesTabbar.removeTabs();
            }
            this.sportRow.dispose();
            this.activitiesTabbar.dispose();
            this.footer.dispose();
            super.dispose();
            return;
        }

        protected function onAddedToStage(arg1:starling.events.Event):void
        {
            handler.ViewHandler.getInstance().openMainMenuOnSwipe(false);
            return;
        }

        protected function onRemovedFromStage(arg1:starling.events.Event):void
        {
            handler.ViewHandler.getInstance().openMainMenuOnSwipe(true);
            return;
        }

        protected override function validateProperties():void
        {
            this.activitiesTabbar.removeTabs();
            title = this.activity.name;
            this.sportRow.backgroundSkin = new starling.display.Quad(1, 1, this.activity.sport.color);
            this.sportIcon.textureName = frontend.Textures.sportTextureByKeyName(this.activity.sport.keyName);
            this.activityDate.maxWidth = SIGMALink.appWidth - 3 * SPORT_ROW_PADDING - 80 * SIGMALink.scaleFactor;
            this.activityDate.styleName = this.activity.sport.labelColor != 16777215 ? feathers.themes.CustomSIGMATheme.TEXT_STYLE_BIGLISTLABEL : feathers.themes.CustomSIGMATheme.TEXT_STYLE_BIGLISTLABEL_WHITE;
            this.activityDate.text = backend.utils.DataUtils.dateFormatter.format(this.activity.startDate) + " - " + backend.utils.DataUtils.dateTimeFormatter.format(this.activity.startDate);
            this.activityValuesTab = new frontend.screen.activities.tabs.values.ActivityValuesTabView();
            this.activityValuesTab.activity = this.activity;
            this.activitiesTabbar.addTab(this.activityValuesTab, true);
            this.activityValuesTab.contentLoadedCallback = this.onContentLoadedCallback;
            if (this.activity.dataType == core.general.DataType.LOG) 
            {
                this.activityGraphTab = new frontend.screen.activities.tabs.graph.ActivityGraphTabView();
                this.activityGraphTab.activity = this.activity;
                this.activitiesTabbar.addTab(this.activityGraphTab);
                if (this.activity.latitudeStartDefined) 
                {
                    this.activityMapTab = new frontend.screen.activities.tabs.map.ActivityMapTabView();
                    this.activityMapTab.mapView.addEventListener(frontend.components.map.MapView.MAP_LOCK_CHANGED, this.onMapLockChanged);
                    this.activityMapTab.activity = this.activity;
                    this.activitiesTabbar.addTab(this.activityMapTab);
                }
                this.activityLapsTab = new frontend.screen.activities.tabs.laps.ActivityLapsTabView();
                this.activityLapsTab.data = this.activity;
                this.activitiesTabbar.addTab(this.activityLapsTab);
                if (core.general.UnitType.PC2814.equals(this.activity.unitType) || core.general.UnitType.SigmaMove.equals(this.activity.unitType)) 
                {
                    this.activityPhasesTab = new frontend.screen.activities.tabs.phases.ActivityPhasesTabView();
                    this.activityPhasesTab.data = this.activity;
                    this.activitiesTabbar.addTab(this.activityPhasesTab);
                }
            }
            this.activityValuesTab.showContent();
            if (!(initialTabIndex == -1) && this.activitiesTabbar.tabbar.dataProvider.length > initialTabIndex) 
            {
                this.activitiesTabbar.tabbar.selectedIndex = initialTabIndex;
            }
            this.checkGhostButtonVisibility();
            return;
        }

        internal function checkGhostButtonVisibility():void
        {
            if (this.activity.dataType != core.general.DataType.LOG) 
            {
                this._ghostVisible = false;
            }
            else 
            {
                backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, core.units.Unit.getUnitsByType(core.units.UnitFactory.ghostRaceSupported()), this.onGhostRaceTypesResult, this.onGhostRaceTypesError, Workers.worker_DatabaseWorker);
            }
            return;
        }

        internal function onGhostRaceTypesError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            this._ghostVisible = false;
            return;
        }

        internal function onGhostRaceTypesResult(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            var loc4:*=null;
            var loc1:*=arg1.getResult();
            var loc2:*=0;
            var loc3:*=0;
            if (loc1) 
            {
                loc3 = loc1.length;
            }
            loc2 = 0;
            while (loc2 < loc3) 
            {
                loc4 = core.units.UnitFactory.createUnitFromDB(loc1[loc2]);
                if (backend.utils.dataprovider.UnitsDataProvider.isCommunicationAvailable(loc4.type)) 
                {
                    this._ghostVisible = true;
                    return;
                }
                ++loc2;
            }
            this._ghostVisible = false;
            return;
        }

        internal function onContentLoadedCallback():void
        {
            if (this.activityGraphTab) 
            {
                this.activityGraphTab.showContent();
            }
            if (this.activityMapTab) 
            {
                this.activityMapTab.showContent();
                this.activityMapTab.hideContent();
            }
            if (this.activityLapsTab) 
            {
                this.activityLapsTab.showContent();
            }
            if (this.activityPhasesTab) 
            {
                this.activityPhasesTab.showContent();
            }
            return;
        }

        internal function onMapLockChanged(arg1:starling.events.Event):void
        {
            if (this.activityMapTab.mapView.mapLockActivated) 
            {
                this.activitiesTabbar.customScroller.horizontalScrollPolicy = feathers.controls.Scroller.SCROLL_POLICY_ON;
            }
            else 
            {
                this.activitiesTabbar.customScroller.horizontalScrollPolicy = feathers.controls.Scroller.SCROLL_POLICY_OFF;
            }
            return;
        }

        internal function onTabChanged(arg1:frontend.components.tab.TabEvent):void
        {
            this.selectedTab = arg1.instance;
            if (this.selectedTab is frontend.screen.activities.tabs.map.ActivityMapTabView) 
            {
                (this.selectedTab as frontend.screen.activities.tabs.map.ActivityMapTabView).showContent();
            }
            else if (this.activityMapTab) 
            {
                this.activityMapTab.mapView.mapLockActivated = true;
                this.activityMapTab.hideContent();
            }
            return;
        }

        internal function shareActivity_handler(arg1:starling.events.TouchEvent):void
        {
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_SHARE_ACTIVITY, {"activityId":this.activity.activityId}, handler.ViewHandler.slideToLeftTransition());
            return;
        }

        internal function editActivity_handler(arg1:starling.events.TouchEvent):void
        {
            initialTabIndex = this.activitiesTabbar.tabbar.selectedIndex;
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_ACTIVITY_EDIT, {"activity":this.activity}, handler.ViewHandler.slideToLeftTransition());
            return;
        }

        internal function sendGhostToDevice_handler(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            this.activity.ghostName = this.activity.name;
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_DEVICE_GHOSTRACE_TRANSFER, {"activity":this.activity, "transferModeDownload":false, "backScreenName":handler.ViewHandler.VIEW_ACTIVITY}, handler.ViewHandler.slideToLeftTransition());
            return;
        }

        internal function _ActivityView_LayoutGroup1_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.mxmlContent = [this._ActivityView_TextureImage1_i(), this._ActivityView_Label1_i()];
            loc1.id = "sportRow";
            this.sportRow = loc1;
            feathers.binding.BindingManager.executeBindings(this, "sportRow", this.sportRow);
            return loc1;
        }

        internal function _ActivityView_TextureImage1_i():frontend.components.TextureImage
        {
            var loc1:*=new frontend.components.TextureImage();
            loc1.id = "sportIcon";
            this.sportIcon = loc1;
            feathers.binding.BindingManager.executeBindings(this, "sportIcon", this.sportIcon);
            return loc1;
        }

        public function set sportRow(arg1:feathers.controls.LayoutGroup):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1832421946sportRow;
            if (loc1 !== arg1) 
            {
                this._1832421946sportRow = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "sportRow", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function _ActivityView_TabContainer1_i():frontend.components.tab.TabContainer
        {
            var loc1:*=new frontend.components.tab.TabContainer();
            loc1.useIconTabs = true;
            loc1.addEventListener("tabChanged", this.__activitiesTabbar_tabChanged);
            loc1.id = "activitiesTabbar";
            this.activitiesTabbar = loc1;
            feathers.binding.BindingManager.executeBindings(this, "activitiesTabbar", this.activitiesTabbar);
            return loc1;
        }

        public function __activitiesTabbar_tabChanged(arg1:frontend.components.tab.TabEvent):void
        {
            this.onTabChanged(arg1);
            return;
        }

        internal function _ActivityView_Footer1_i():frontend.screen.component.Footer
        {
            var loc1:*=new frontend.screen.component.Footer();
            loc1.mxmlContent = [this._ActivityView_IconButton1_i(), this._ActivityView_IconButton2_i(), this._ActivityView_IconButton3_i()];
            loc1.id = "footer";
            this.footer = loc1;
            feathers.binding.BindingManager.executeBindings(this, "footer", this.footer);
            return loc1;
        }

        internal function _ActivityView_IconButton1_i():frontend.components.button.IconButton
        {
            var loc1:*=new frontend.components.button.IconButton();
            loc1.id = "_ActivityView_IconButton1";
            this._ActivityView_IconButton1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ActivityView_IconButton1", this._ActivityView_IconButton1);
            return loc1;
        }

        internal function _ActivityView_IconButton2_i():frontend.components.button.IconButton
        {
            var loc1:*=new frontend.components.button.IconButton();
            loc1.id = "_ActivityView_IconButton2";
            this._ActivityView_IconButton2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ActivityView_IconButton2", this._ActivityView_IconButton2);
            return loc1;
        }

        internal function _ActivityView_IconButton3_i():frontend.components.button.IconButton
        {
            var loc1:*=new frontend.components.button.IconButton();
            loc1.id = "_ActivityView_IconButton3";
            this._ActivityView_IconButton3 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ActivityView_IconButton3", this._ActivityView_IconButton3);
            return loc1;
        }

        public function ___ActivityView_CustomScreen1_addedToStage(arg1:starling.events.Event):void
        {
            this.onAddedToStage(arg1);
            return;
        }

        public static const SPORT_ROW_HEIGHT:Number=45 * SIGMALink.scaleFactor;

        internal static const SPORT_ROW_PADDING:Number=17 * SIGMALink.scaleFactor;

        public var _ActivityView_IconButton1:frontend.components.button.IconButton;

        public var _ActivityView_IconButton2:frontend.components.button.IconButton;

        public var _ActivityView_IconButton3:frontend.components.button.IconButton;

        internal var _679224661activitiesTabbar:frontend.components.tab.TabContainer;

        internal var _1628321629activityDate:feathers.controls.Label;

        internal var _1268861541footer:frontend.screen.component.Footer;

        internal var _970785267sportIcon:frontend.components.TextureImage;

        public var activity:core.activities.Activity;

        internal var _799692994_ghostVisible:Boolean=false;

        internal var activityGraphTab:frontend.screen.activities.tabs.graph.ActivityGraphTabView;

        internal var activityLapsTab:frontend.screen.activities.tabs.laps.ActivityLapsTabView;

        internal var activityMapTab:frontend.screen.activities.tabs.map.ActivityMapTabView;

        internal var activityPhasesTab:frontend.screen.activities.tabs.phases.ActivityPhasesTabView;

        internal var activityValuesTab:frontend.screen.activities.tabs.values.ActivityValuesTabView;

        internal var selectedTab:frontend.components.tabbarbase.ITabLayoutContainer;

        internal var _1832421946sportRow:feathers.controls.LayoutGroup;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        public static var initialTabIndex:int=-1;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;

        mx_internal var _bindings:Array;
    }
}


