//package dashboard
//  class ActivitiesListShortcutElement
package frontend.screen.dashboard 
{
    import backend.utils.dbUtils.*;
    import core.activities.*;
    import debug.*;
    import feathers.controls.*;
    import feathers.layout.*;
    import flash.data.*;
    import frontend.components.*;
    
    public class ActivitiesListShortcutElement extends frontend.screen.dashboard.ShortcutElement
    {
        public function ActivitiesListShortcutElement()
        {
            super();
            var loc1:*=new feathers.layout.HorizontalLayout();
            loc1.gap = elementGap;
            loc1.verticalAlign = feathers.layout.VerticalAlign.MIDDLE;
            loc1.horizontalAlign = feathers.layout.HorizontalAlign.CENTER;
            this._hGroup = new feathers.controls.LayoutGroup();
            this._hGroup.layout = loc1;
            this._counterLabel = new feathers.controls.Label();
            this._counterLabel.styleName = "DASHBOARD_SHORTCUT_VALUE";
            this._counterLabel.touchable = false;
            addChild(this._hGroup);
            return;
        }

        public function updateNumberOfActivities():void
        {
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, core.activities.ActivityMapper.countActivitiesStatement(" and sportId != 16"), this.numberOfActivitiesComplete, this.numberOfActivitiesError);
            return;
        }

        protected override function addIcon():void
        {
            var loc1:*=null;
            if (iconName != "") 
            {
                loc1 = new frontend.components.TextureImage();
                loc1.textureName = iconName;
                loc1.touchable = false;
                this._hGroup.addChild(loc1);
            }
            return;
        }

        protected override function addLabel():void
        {
            label = new feathers.controls.Label();
            label.text = labelText;
            label.styleName = "DASHBOARD_SHORTCUT_LABEL";
            label.touchable = false;
            var loc1:*=new feathers.layout.VerticalLayout();
            loc1.gap = elementGap;
            loc1.horizontalAlign = feathers.layout.HorizontalAlign.CENTER;
            loc1.verticalAlign = feathers.layout.VerticalAlign.MIDDLE;
            loc1.paddingBottom = 18.5 * SIGMALink.scaleFactor;
            var loc2:*=new feathers.controls.LayoutGroup();
            loc2.layout = loc1;
            loc2.layoutData = new feathers.layout.VerticalLayoutData(100, 100);
            loc2.addChild(this._counterLabel);
            loc2.addChild(label);
            this._hGroup.addChild(loc2);
            return;
        }

        internal function numberOfActivitiesComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            var loc1:*=arg1.getResult();
            if (loc1.length == 1) 
            {
                this._counterLabel.text = loc1[0].activities;
            }
            debug.Debug.debug("numberOfActivitiesComplete");
            return;
        }

        internal function numberOfActivitiesError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.debug("numberOfActivitiesComplete");
            return;
        }

        internal var _counterLabel:feathers.controls.Label;

        internal var _hGroup:feathers.controls.LayoutGroup;
    }
}


//  class Dashboard
package frontend.screen.dashboard 
{
    import backend.utils.*;
    import backend.utils.dbUtils.*;
    import configCache.*;
    import core.general.*;
    import core.units.*;
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
    import frontend.components.menuList.*;
    import frontend.components.tabbar.*;
    import frontend.screen.activities.list.*;
    import frontend.screen.component.*;
    import frontend.screen.component.devices.*;
    import handler.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.display.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    import statistic.*;
    import utils.*;
    import utils.date.*;
    
    use namespace mx_internal;
    
    public class Dashboard extends frontend.screen.component.CustomScreen implements feathers.binding.IBindingClient
    {
        public function Dashboard()
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
            bindings = this._Dashboard_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_dashboard_DashboardWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return frontend.screen.dashboard.Dashboard[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.allowCaching = true;
            this.hasBackwardNavigation = true;
            this.mxmlContent = [this._Dashboard_LayoutGroup1_i()];
            this.addEventListener("initialize", this.___Dashboard_CustomScreen1_initialize);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        internal function _Dashboard_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new frontend.screen.dashboard.DashboardBackgroundSkin();
            }, null, "this.backgroundSkin")
            result[1] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("DASHBOARD.TITLE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.title")
            result[2] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(0, 0, 0, 0);
            }, null, "_Dashboard_LayoutGroup1.layoutData")
            result[3] = new feathers.binding.Binding(this, function ():Number
            {
                return padding;
            }, null, "_Dashboard_VerticalLayout1.gap")
            result[4] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.VerticalLayoutData(100);
            }, null, "_Dashboard_LayoutGroup2.layoutData")
            result[5] = new feathers.binding.Binding(this, function ():Number
            {
                return padding;
            }, null, "_Dashboard_VerticalLayout2.padding")
            result[6] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.components.tabbar.TextTabBar.SELECTED_HEIGHT;
            }, null, "tabbar.height")
            result[7] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.VerticalLayoutData(100);
            }, null, "tabbar.layoutData")
            result[8] = new feathers.binding.Binding(this, function ():*
            {
                return utils.LanguageManager.getString("DASHBOARD.STATISTIC_WEEK_BUTTON");
            }, null, "_Dashboard_Object1.label")
            result[9] = new feathers.binding.Binding(this, function ():*
            {
                return utils.LanguageManager.getString("DASHBOARD.STATISTIC_MONTH_BUTTON");
            }, null, "_Dashboard_Object2.label")
            result[10] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            }, null, "_Dashboard_MenuList1.backgroundSkin")
            result[11] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.VerticalLayoutData(100);
            }, null, "_Dashboard_MenuList1.layoutData")
            result[12] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.dashboardsmallcount;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "trainings.iconName")
            result[13] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("DASHBOARD.STATISTIC_TRAININGS");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "trainings.labelText")
            result[14] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.VerticalLayoutData(100);
            }, null, "trainings.layoutData")
            result[15] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.dashboardsmalltime;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "trainingTime.iconName")
            result[16] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("DASHBOARD.STATISTIC_TRAINING_TIME");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "trainingTime.labelText")
            result[17] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.VerticalLayoutData(100);
            }, null, "trainingTime.layoutData")
            result[18] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("UNIT_HOUR");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "trainingTime.unitText")
            result[19] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.dashboardsmallkcal;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "calories.iconName")
            result[20] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("DASHBOARD.STATISTIC_CALORIES");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "calories.labelText")
            result[21] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.VerticalLayoutData(100);
            }, null, "calories.layoutData")
            result[22] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("UNIT_CALORIE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "calories.unitText")
            result[23] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.dashboardsmalldistance;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "distance.iconName")
            result[24] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("DASHBOARD.STATISTIC_DISTANCE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "distance.labelText")
            result[25] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.VerticalLayoutData(100);
            }, null, "distance.layoutData")
            result[26] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=backend.utils.DataUtils.unitStringDistance;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "distance.unitText")
            result[27] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return new feathers.layout.VerticalLayout();
            }, null, "bottomGroup.layout")
            result[28] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.VerticalLayoutData(100, 100);
            }, null, "bottomGroup.layoutData")
            result[29] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.VerticalLayoutData(100, 20);
            }, null, "spacer.layoutData")
            result[30] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            }, null, "optionalInfoBox.backgroundSkin")
            result[31] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.VerticalLayoutData(100);
            }, null, "optionalInfoBox.layoutData")
            result[32] = new feathers.binding.Binding(this, function ():Number
            {
                return _optionalShortcutsPaddingBottom;
            }, null, "_Dashboard_VerticalLayout3.paddingBottom")
            result[33] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            }, null, "_Dashboard_LayoutGroup6.backgroundSkin")
            result[34] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.VerticalLayoutData(100, 100);
            }, null, "_Dashboard_LayoutGroup6.layoutData")
            result[35] = new feathers.binding.Binding(this, function ():Number
            {
                return BUTTON_LAYOUT_GAP;
            }, null, "_Dashboard_TiledRowsLayout1.gap")
            result[36] = new feathers.binding.Binding(this, function ():int
            {
                return BUTTON_LAYOUT_COLUMNS;
            }, null, "_Dashboard_TiledRowsLayout1.requestedColumnCount")
            result[37] = new feathers.binding.Binding(this, function ():int
            {
                return BUTTON_LAYOUT_ROWS;
            }, null, "_Dashboard_TiledRowsLayout1.requestedRowCount")
            result[38] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.dashboardbigactivity;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "activitiesShortcut.iconName")
            result[39] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("DASHBOARD.SHORTCUT_ACTIVITIES");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "activitiesShortcut.labelText")
            result[40] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=handler.ViewHandler.VIEW_ACTIVITIES_LIST;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "activitiesShortcut.targetClass")
            result[41] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.dashboardbigimport;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_Dashboard_ShortcutElement1.iconName")
            result[42] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("DASHBOARD.SHORTCUT_IMPORT_ACTIVITIES");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_Dashboard_ShortcutElement1.labelText")
            result[43] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=handler.ViewHandler.VIEW_ACTIVITIES_TRANSFER;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_Dashboard_ShortcutElement1.targetClass")
            result[44] = new feathers.binding.Binding(this, function ():Object
            {
                return {"backScreenName":handler.ViewHandler.VIEW_DASHBOARD};
            }, null, "_Dashboard_ShortcutElement1.viewData")
            result[45] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.dashboardbigstatistik;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_Dashboard_ShortcutElement2.iconName")
            result[46] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("DASHBOARD.SHORTCUT_STATISTIC");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_Dashboard_ShortcutElement2.labelText")
            result[47] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=handler.ViewHandler.VIEW_STATISTIC;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_Dashboard_ShortcutElement2.targetClass")
            result[48] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.dashboardbigtopvalues;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_Dashboard_ShortcutElement3.iconName")
            result[49] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("DASHBOARD.SHORTCUT_TOP_VALUES");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_Dashboard_ShortcutElement3.labelText")
            result[50] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=handler.ViewHandler.VIEW_TOPVALUES;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_Dashboard_ShortcutElement3.targetClass")
            result[51] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.dashboardbigtracks;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_Dashboard_ShortcutElement4.iconName")
            result[52] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("DASHBOARD.SHORTCUT_TRACKS");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_Dashboard_ShortcutElement4.labelText")
            result[53] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=handler.ViewHandler.VIEW_TRACKS;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_Dashboard_ShortcutElement4.targetClass")
            result[54] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.dashboardbigdevices;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_Dashboard_ShortcutElement5.iconName")
            result[55] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("DASHBOARD.SHORTCUT_MY_DEVICES");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_Dashboard_ShortcutElement5.labelText")
            result[56] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=handler.ViewHandler.VIEW_MYDEVICES;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_Dashboard_ShortcutElement5.targetClass")
            return result;
        }

        public function get activitiesShortcut():frontend.screen.dashboard.ActivitiesListShortcutElement
        {
            return this._662388563activitiesShortcut;
        }

        public function set activitiesShortcut(arg1:frontend.screen.dashboard.ActivitiesListShortcutElement):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._662388563activitiesShortcut;
            if (loc1 !== arg1) 
            {
                this._662388563activitiesShortcut = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "activitiesShortcut", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get bottomGroup():feathers.controls.LayoutGroup
        {
            return this._631173356bottomGroup;
        }

        public function set bottomGroup(arg1:feathers.controls.LayoutGroup):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._631173356bottomGroup;
            if (loc1 !== arg1) 
            {
                this._631173356bottomGroup = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "bottomGroup", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get calories():frontend.screen.dashboard.DashboardStatisticItem
        {
            return this._168965370calories;
        }

        public function set calories(arg1:frontend.screen.dashboard.DashboardStatisticItem):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._168965370calories;
            if (loc1 !== arg1) 
            {
                this._168965370calories = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "calories", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get distance():frontend.screen.dashboard.DashboardStatisticItem
        {
            return this._288459765distance;
        }

        public function set distance(arg1:frontend.screen.dashboard.DashboardStatisticItem):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._288459765distance;
            if (loc1 !== arg1) 
            {
                this._288459765distance = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "distance", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get optionalInfoBox():feathers.controls.LayoutGroup
        {
            return this._1631124157optionalInfoBox;
        }

        public function set optionalInfoBox(arg1:feathers.controls.LayoutGroup):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1631124157optionalInfoBox;
            if (loc1 !== arg1) 
            {
                this._1631124157optionalInfoBox = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "optionalInfoBox", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get spacer():feathers.controls.LayoutGroup
        {
            return this._896192468spacer;
        }

        public function set spacer(arg1:feathers.controls.LayoutGroup):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._896192468spacer;
            if (loc1 !== arg1) 
            {
                this._896192468spacer = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "spacer", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
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

        internal function _Dashboard_MenuList1_i():frontend.components.menuList.MenuList
        {
            var loc1:*=new frontend.components.menuList.MenuList();
            loc1.mxmlContent = [this._Dashboard_DashboardStatisticItem1_i(), this._Dashboard_DashboardStatisticItem2_i(), this._Dashboard_DashboardStatisticItem3_i(), this._Dashboard_DashboardStatisticItem4_i()];
            loc1.id = "_Dashboard_MenuList1";
            this._Dashboard_MenuList1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_Dashboard_MenuList1", this._Dashboard_MenuList1);
            return loc1;
        }

        public function get trainingTime():frontend.screen.dashboard.DashboardStatisticItem
        {
            return this._1089721031trainingTime;
        }

        public function set trainingTime(arg1:frontend.screen.dashboard.DashboardStatisticItem):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1089721031trainingTime;
            if (loc1 !== arg1) 
            {
                this._1089721031trainingTime = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "trainingTime", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get trainings():frontend.screen.dashboard.DashboardStatisticItem
        {
            return this._904991449trainings;
        }

        public function set trainings(arg1:frontend.screen.dashboard.DashboardStatisticItem):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._904991449trainings;
            if (loc1 !== arg1) 
            {
                this._904991449trainings = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "trainings", loc1, arg1, this);
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

        internal function get _optionalShortcutsHeight():Number
        {
            return this._1682393525_optionalShortcutsHeight;
        }

        internal function set _optionalShortcutsHeight(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1682393525_optionalShortcutsHeight;
            if (loc1 !== arg1) 
            {
                this._1682393525_optionalShortcutsHeight = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_optionalShortcutsHeight", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _optionalShortcutsPaddingBottom():Number
        {
            return this._1435968178_optionalShortcutsPaddingBottom;
        }

        internal function set _optionalShortcutsPaddingBottom(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1435968178_optionalShortcutsPaddingBottom;
            if (loc1 !== arg1) 
            {
                this._1435968178_optionalShortcutsPaddingBottom = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_optionalShortcutsPaddingBottom", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get data():Object
        {
            return this._data;
        }

        internal function set _3076010data(arg1:Object):void
        {
            this._data = arg1;
            return;
        }

        internal function get _shortcutHeight():Number
        {
            return this._1388247852_shortcutHeight;
        }

        internal function set _shortcutHeight(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1388247852_shortcutHeight;
            if (loc1 !== arg1) 
            {
                this._1388247852_shortcutHeight = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_shortcutHeight", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function set _shortcutWidth(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1049628895_shortcutWidth;
            if (loc1 !== arg1) 
            {
                this._1049628895_shortcutWidth = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_shortcutWidth", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _statisticHeight():Number
        {
            return this._702214056_statisticHeight;
        }

        internal function set _statisticHeight(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._702214056_statisticHeight;
            if (loc1 !== arg1) 
            {
                this._702214056_statisticHeight = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_statisticHeight", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _statisticWidth():Number
        {
            return this._2086894475_statisticWidth;
        }

        internal function set _statisticWidth(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._2086894475_statisticWidth;
            if (loc1 !== arg1) 
            {
                this._2086894475_statisticWidth = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_statisticWidth", loc1, arg1, this);
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
            frontend.screen.dashboard.Dashboard._watcherSetupUtil = arg1;
            return;
        }

        public static function get padding():Number
        {
            return frontend.screen.dashboard.Dashboard._806339567padding;
        }

        public static function set padding(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=frontend.screen.dashboard.Dashboard._806339567padding;
            if (loc1 !== arg1) 
            {
                frontend.screen.dashboard.Dashboard._806339567padding = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "padding", loc1, arg1, frontend.screen.dashboard.Dashboard);
                loc3 = frontend.screen.dashboard.Dashboard.staticEventDispatcher;
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
            _806339567padding = 20 * SIGMALink.scaleFactor;
            _staticBindingEventDispatcher = new starling.events.EventDispatcher();
        }

        internal function onInit():void
        {
            this.callLater = new flash.utils.Timer(250, 1);
            this.callLater.addEventListener(flash.events.TimerEvent.TIMER, this.updateValues);
            handler.ActivityHandler.getInstance().addEventListener(frontend.screen.activities.list.ActivityListEvent.RELOAD, this.activityListEventHandler);
            handler.ActivityHandler.getInstance().addEventListener(frontend.screen.activities.list.ActivityListEvent.DELETE, this.activityListEventHandler);
            handler.ActivityHandler.getInstance().addEventListener(frontend.screen.activities.list.ActivityListEvent.UPDATE, this.activityListEventHandler);
            handler.AppDeviceHandler.getInstance().addEventListener(frontend.screen.component.devices.DeviceListEvent.RELOAD, this.onDeviceReloadTriggered);
            handler.ApplicationHandler.getInstance().checkOAuths();
            return;
        }

        protected override function validateProperties():void
        {
            this._currentXField = configCache.ConfigCache.getInstance().getValue(configCache.ConfigCacheObject.DASHBOARD_STATISTIC_SELECTED_TIME, statistic.Statistic.X_WEEK);
            this.tabbar.selectedIndex = this._currentXField != statistic.Statistic.X_WEEK ? 1 : 0;
            handler.ApplicationHandler.getInstance().startDatabaseWorker();
            this.updateValues();
            return;
        }

        internal function updateValues(arg1:flash.events.TimerEvent=null):void
        {
            if (!this._firstStatisticCall && handler.ViewHandler.getInstance().navigator.isTransitionActive) 
            {
                debug.Debug.debug("validateProperties later - transition is active ");
                this.callLater.start();
                return;
            }
            this.updateStatistic();
            this.checkDeviceExist();
            this.activitiesShortcut.updateNumberOfActivities();
            handler.ApplicationHandler.getInstance().validateYearsWithData();
            return;
        }

        internal function activityListEventHandler(arg1:frontend.screen.activities.list.ActivityListEvent):void
        {
            this.updateStatistic();
            handler.ApplicationHandler.getInstance().validateYearsWithData();
            if (this.activitiesShortcut) 
            {
                this.activitiesShortcut.updateNumberOfActivities();
            }
            return;
        }

        internal function checkDeviceExist():void
        {
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, core.units.Unit.getUnitCount(), this.onCountDeviceResult, this.onCountDeviceError, Workers.worker_DatabaseWorker);
            return;
        }

        internal function onCountDeviceError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("onCountDeviceError");
            this.displayNoDeviceBox(false);
            return;
        }

        internal function onCountDeviceResult(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            var loc1:*=arg1.getResult();
            var loc2:*=loc1.length == 1 && loc1[0].numDevices == 0;
            this.displayNoDeviceBox(loc2);
            return;
        }

        internal function onDeviceReloadTriggered(arg1:frontend.screen.component.devices.DeviceListEvent):void
        {
            this.checkDeviceExist();
            return;
        }

        internal function displayNoDeviceBox(arg1:Boolean):void
        {
            if (arg1) 
            {
                if (!this._shortcutNoDevice) 
                {
                    this._shortcutNoDevice = new frontend.screen.dashboard.ShortcutNoDevice();
                }
                this._shortcutNoDevice.addEventListener(starling.events.Event.ADDED_TO_STAGE, this.onShortcutNoDeviceAddetToStage);
                this.optionalInfoBox.addChild(this._shortcutNoDevice);
            }
            else if (this._shortcutNoDevice && this.optionalInfoBox.contains(this._shortcutNoDevice)) 
            {
                this.optionalInfoBox.removeChild(this._shortcutNoDevice);
                this.checkOptionalInfoBox();
            }
            return;
        }

        internal function onShortcutNoDeviceAddetToStage(arg1:starling.events.Event):void
        {
            this._shortcutNoDevice.removeEventListener(starling.events.Event.ADDED_TO_STAGE, this.onShortcutNoDeviceAddetToStage);
            this.checkOptionalInfoBox();
            return;
        }

        internal function checkOptionalInfoBox():void
        {
            var loc1:*=this.optionalInfoBox.numChildren > 0;
            this.spacer.visible = !loc1;
            this.spacer.includeInLayout = !loc1;
            this.optionalInfoBox.visible = loc1;
            this.optionalInfoBox.includeInLayout = loc1;
            this.optionalInfoBox.validate();
            return;
        }

        protected function tabChangeHandler(arg1:starling.events.Event):void
        {
            var loc1:*=this.tabbar.selectedIndex;
            switch (loc1) 
            {
                case 0:
                {
                    if (this._currentXField == statistic.Statistic.X_WEEK) 
                    {
                        if (this._firstStatisticCall) 
                        {
                            this.updateStatistic();
                        }
                        return;
                    }
                    this._currentXField = statistic.Statistic.X_WEEK;
                    break;
                }
                case 1:
                {
                    if (this._currentXField == statistic.Statistic.X_MONTH) 
                    {
                        if (this._firstStatisticCall) 
                        {
                            this.updateStatistic();
                        }
                        return;
                    }
                    this._currentXField = statistic.Statistic.X_MONTH;
                    break;
                }
            }
            configCache.ConfigCache.getInstance().setValue(configCache.ConfigCacheObject.DASHBOARD_STATISTIC_SELECTED_TIME, this._currentXField);
            this.updateStatistic();
            return;
        }

        internal function updateStatistic():void
        {
            var loc2:*=null;
            this._firstStatisticCall = false;
            statistic.Statistic.useTmpUserAndSport = true;
            statistic.Statistic.tmpSports = handler.SportHandler.getInstance().getSportIds([16]);
            statistic.Statistic.tmpUsers = null;
            var loc1:*=new Date();
            if (this._currentXField != statistic.Statistic.X_MONTH) 
            {
                loc2 = statistic.Statistic.X_WEEK_DAYS;
            }
            else 
            {
                loc2 = statistic.Statistic.X_MONTH_DAYS;
            }
            var loc3:*=statistic.Statistic.getStatisticValueCompareSummaryStatement(loc1.fullYear, loc1.month, utils.date.CalendarUtil.calculateCalendarWeek(loc1), loc2, statistic.Statistic.TRAININGS, statistic.Statistic.SEPARATION_NONE, statistic.Statistic.DISPLAY_ALL);
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, loc3.text, this.onStatisticResult, this.onStatisticError);
            return;
        }

        internal function onStatisticResult(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            var loc1:*=arg1.getResult();
            if (loc1.length == 0) 
            {
                return;
            }
            var loc2:*=loc1[0];
            this.trainings.valueText = this.getValue(loc2, statistic.Statistic.SUM_FIELD + statistic.Statistic.TRAININGS).toString();
            this.trainingTime.valueText = backend.utils.DataUtils.timeFormatter.format(this.getValue(loc2, statistic.Statistic.SUM_FIELD + statistic.Statistic.TRAINING_TIME).toString());
            this.calories.valueText = backend.utils.DataUtils.caloriesFormatter.format(this.getValue(loc2, statistic.Statistic.SUM_FIELD + statistic.Statistic.CALORIES));
            this.distance.valueText = backend.utils.DataUtils.distanceFormatter.format(backend.utils.DataUtils.distanceConverter.convert(this.getValue(loc2, statistic.Statistic.SUM_FIELD + statistic.Statistic.DISTANCE).toString()));
            return;
        }

        internal function getValue(arg1:Object, arg2:String):Number
        {
            return arg1[arg2] == null ? 0 : arg1[arg2];
        }

        internal function onStatisticError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("onStatisticError");
            this.trainings.valueText = "0";
            this.trainingTime.valueText = "0";
            this.calories.valueText = "0";
            this.distance.valueText = "0";
            return;
        }

        protected function onButtonsContainerResize(arg1:starling.events.Event):void
        {
            var loc1:*=arg1.currentTarget as feathers.controls.LayoutGroup;
            var loc2:*=0;
            var loc3:*=loc1.numChildren;
            var loc4:*=loc1.width / BUTTON_LAYOUT_COLUMNS - BUTTON_LAYOUT_GAP * BUTTON_LAYOUT_COLUMNS;
            var loc5:*=loc1.height / BUTTON_LAYOUT_ROWS - BUTTON_LAYOUT_GAP * BUTTON_LAYOUT_ROWS;
            if (this._buttonWidth == loc4 && this._buttonheight == loc5) 
            {
                return;
            }
            this._buttonWidth = loc4;
            this._buttonheight = loc5;
            while (loc2 < loc3) 
            {
                loc1.getChildAt(loc2).width = loc4;
                loc1.getChildAt(loc2).height = loc5;
                ++loc2;
            }
            return;
        }

        internal function _Dashboard_LayoutGroup1_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._Dashboard_VerticalLayout1_i();
            loc1.mxmlContent = [this._Dashboard_LayoutGroup2_i(), this._Dashboard_LayoutGroup3_i()];
            loc1.id = "_Dashboard_LayoutGroup1";
            this._Dashboard_LayoutGroup1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_Dashboard_LayoutGroup1", this._Dashboard_LayoutGroup1);
            return loc1;
        }

        internal function _Dashboard_VerticalLayout1_i():feathers.layout.VerticalLayout
        {
            var loc1:*=new feathers.layout.VerticalLayout();
            loc1.padding = 0;
            this._Dashboard_VerticalLayout1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_Dashboard_VerticalLayout1", this._Dashboard_VerticalLayout1);
            return loc1;
        }

        internal function _Dashboard_LayoutGroup2_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._Dashboard_VerticalLayout2_i();
            loc1.mxmlContent = [this._Dashboard_TextTabBar1_i(), this._Dashboard_MenuList1_i()];
            loc1.id = "_Dashboard_LayoutGroup2";
            this._Dashboard_LayoutGroup2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_Dashboard_LayoutGroup2", this._Dashboard_LayoutGroup2);
            return loc1;
        }

        internal function _Dashboard_VerticalLayout2_i():feathers.layout.VerticalLayout
        {
            var loc1:*=new feathers.layout.VerticalLayout();
            loc1.gap = 0;
            this._Dashboard_VerticalLayout2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_Dashboard_VerticalLayout2", this._Dashboard_VerticalLayout2);
            return loc1;
        }

        internal function _Dashboard_TextTabBar1_i():frontend.components.tabbar.TextTabBar
        {
            var loc1:*=new frontend.components.tabbar.TextTabBar();
            loc1.dataProvider = this._Dashboard_ListCollection1_c();
            loc1.addEventListener("change", this.__tabbar_change);
            loc1.id = "tabbar";
            this.tabbar = loc1;
            feathers.binding.BindingManager.executeBindings(this, "tabbar", this.tabbar);
            return loc1;
        }

        internal function _Dashboard_ListCollection1_c():feathers.data.ListCollection
        {
            var loc1:*=new feathers.data.ListCollection();
            loc1.data = [this._Dashboard_Object1_i(), this._Dashboard_Object2_i()];
            return loc1;
        }

        internal function _Dashboard_Object1_i():Object
        {
            var loc1:*={"label":null};
            this._Dashboard_Object1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_Dashboard_Object1", this._Dashboard_Object1);
            return loc1;
        }

        internal function _Dashboard_Object2_i():Object
        {
            var loc1:*={"label":null};
            this._Dashboard_Object2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_Dashboard_Object2", this._Dashboard_Object2);
            return loc1;
        }

        public function __tabbar_change(arg1:starling.events.Event):void
        {
            this.tabChangeHandler(arg1);
            return;
        }

        internal function get _shortcutWidth():Number
        {
            return this._1049628895_shortcutWidth;
        }

        internal function _Dashboard_DashboardStatisticItem1_i():frontend.screen.dashboard.DashboardStatisticItem
        {
            var loc1:*=new frontend.screen.dashboard.DashboardStatisticItem();
            loc1.id = "trainings";
            this.trainings = loc1;
            feathers.binding.BindingManager.executeBindings(this, "trainings", this.trainings);
            return loc1;
        }

        internal function _Dashboard_DashboardStatisticItem2_i():frontend.screen.dashboard.DashboardStatisticItem
        {
            var loc1:*=new frontend.screen.dashboard.DashboardStatisticItem();
            loc1.id = "trainingTime";
            this.trainingTime = loc1;
            feathers.binding.BindingManager.executeBindings(this, "trainingTime", this.trainingTime);
            return loc1;
        }

        internal function _Dashboard_DashboardStatisticItem3_i():frontend.screen.dashboard.DashboardStatisticItem
        {
            var loc1:*=new frontend.screen.dashboard.DashboardStatisticItem();
            loc1.id = "calories";
            this.calories = loc1;
            feathers.binding.BindingManager.executeBindings(this, "calories", this.calories);
            return loc1;
        }

        internal function _Dashboard_DashboardStatisticItem4_i():frontend.screen.dashboard.DashboardStatisticItem
        {
            var loc1:*=new frontend.screen.dashboard.DashboardStatisticItem();
            loc1.id = "distance";
            this.distance = loc1;
            feathers.binding.BindingManager.executeBindings(this, "distance", this.distance);
            return loc1;
        }

        internal function _Dashboard_LayoutGroup3_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.mxmlContent = [this._Dashboard_LayoutGroup4_i(), this._Dashboard_LayoutGroup5_i(), this._Dashboard_LayoutGroup6_i()];
            loc1.id = "bottomGroup";
            this.bottomGroup = loc1;
            feathers.binding.BindingManager.executeBindings(this, "bottomGroup", this.bottomGroup);
            return loc1;
        }

        internal function _Dashboard_LayoutGroup4_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.visible = false;
            loc1.id = "spacer";
            this.spacer = loc1;
            feathers.binding.BindingManager.executeBindings(this, "spacer", this.spacer);
            return loc1;
        }

        internal function _Dashboard_LayoutGroup5_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.visible = false;
            loc1.layout = this._Dashboard_VerticalLayout3_i();
            loc1.id = "optionalInfoBox";
            this.optionalInfoBox = loc1;
            feathers.binding.BindingManager.executeBindings(this, "optionalInfoBox", this.optionalInfoBox);
            return loc1;
        }

        internal function _Dashboard_VerticalLayout3_i():feathers.layout.VerticalLayout
        {
            var loc1:*=new feathers.layout.VerticalLayout();
            this._Dashboard_VerticalLayout3 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_Dashboard_VerticalLayout3", this._Dashboard_VerticalLayout3);
            return loc1;
        }

        internal function _Dashboard_LayoutGroup6_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._Dashboard_TiledRowsLayout1_i();
            loc1.mxmlContent = [this._Dashboard_ActivitiesListShortcutElement1_i(), this._Dashboard_ShortcutElement1_i(), this._Dashboard_ShortcutElement2_i(), this._Dashboard_ShortcutElement3_i(), this._Dashboard_ShortcutElement4_i(), this._Dashboard_ShortcutElement5_i()];
            loc1.addEventListener("resize", this.___Dashboard_LayoutGroup6_resize);
            loc1.id = "_Dashboard_LayoutGroup6";
            this._Dashboard_LayoutGroup6 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_Dashboard_LayoutGroup6", this._Dashboard_LayoutGroup6);
            return loc1;
        }

        internal function _Dashboard_TiledRowsLayout1_i():feathers.layout.TiledRowsLayout
        {
            var loc1:*=new feathers.layout.TiledRowsLayout();
            loc1.distributeHeights = true;
            loc1.distributeWidths = true;
            loc1.useSquareTiles = false;
            this._Dashboard_TiledRowsLayout1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_Dashboard_TiledRowsLayout1", this._Dashboard_TiledRowsLayout1);
            return loc1;
        }

        internal function _Dashboard_ActivitiesListShortcutElement1_i():frontend.screen.dashboard.ActivitiesListShortcutElement
        {
            var loc1:*=new frontend.screen.dashboard.ActivitiesListShortcutElement();
            loc1.id = "activitiesShortcut";
            this.activitiesShortcut = loc1;
            feathers.binding.BindingManager.executeBindings(this, "activitiesShortcut", this.activitiesShortcut);
            return loc1;
        }

        internal function _Dashboard_ShortcutElement1_i():frontend.screen.dashboard.ShortcutElement
        {
            var loc1:*=new frontend.screen.dashboard.ShortcutElement();
            loc1.id = "_Dashboard_ShortcutElement1";
            this._Dashboard_ShortcutElement1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_Dashboard_ShortcutElement1", this._Dashboard_ShortcutElement1);
            return loc1;
        }

        internal function _Dashboard_ShortcutElement2_i():frontend.screen.dashboard.ShortcutElement
        {
            var loc1:*=new frontend.screen.dashboard.ShortcutElement();
            loc1.id = "_Dashboard_ShortcutElement2";
            this._Dashboard_ShortcutElement2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_Dashboard_ShortcutElement2", this._Dashboard_ShortcutElement2);
            return loc1;
        }

        internal function _Dashboard_ShortcutElement3_i():frontend.screen.dashboard.ShortcutElement
        {
            var loc1:*=new frontend.screen.dashboard.ShortcutElement();
            loc1.id = "_Dashboard_ShortcutElement3";
            this._Dashboard_ShortcutElement3 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_Dashboard_ShortcutElement3", this._Dashboard_ShortcutElement3);
            return loc1;
        }

        internal function _Dashboard_ShortcutElement4_i():frontend.screen.dashboard.ShortcutElement
        {
            var loc1:*=new frontend.screen.dashboard.ShortcutElement();
            loc1.id = "_Dashboard_ShortcutElement4";
            this._Dashboard_ShortcutElement4 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_Dashboard_ShortcutElement4", this._Dashboard_ShortcutElement4);
            return loc1;
        }

        internal function _Dashboard_ShortcutElement5_i():frontend.screen.dashboard.ShortcutElement
        {
            var loc1:*=new frontend.screen.dashboard.ShortcutElement();
            loc1.id = "_Dashboard_ShortcutElement5";
            this._Dashboard_ShortcutElement5 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_Dashboard_ShortcutElement5", this._Dashboard_ShortcutElement5);
            return loc1;
        }

        public function ___Dashboard_LayoutGroup6_resize(arg1:starling.events.Event):void
        {
            this.onButtonsContainerResize(arg1);
            return;
        }

        public function ___Dashboard_CustomScreen1_initialize(arg1:starling.events.Event):void
        {
            this.onInit();
            return;
        }

        internal static const BUTTON_LAYOUT_COLUMNS:uint=2;

        internal static const BUTTON_LAYOUT_GAP:uint=1;

        internal static const BUTTON_LAYOUT_ROWS:uint=3;

        public var _Dashboard_MenuList1:frontend.components.menuList.MenuList;

        public var _Dashboard_Object1:Object;

        public var _Dashboard_Object2:Object;

        public var _Dashboard_ShortcutElement1:frontend.screen.dashboard.ShortcutElement;

        public var _Dashboard_ShortcutElement2:frontend.screen.dashboard.ShortcutElement;

        public var _Dashboard_ShortcutElement3:frontend.screen.dashboard.ShortcutElement;

        public var _Dashboard_ShortcutElement4:frontend.screen.dashboard.ShortcutElement;

        public var _Dashboard_ShortcutElement5:frontend.screen.dashboard.ShortcutElement;

        public var _Dashboard_TiledRowsLayout1:feathers.layout.TiledRowsLayout;

        public var _Dashboard_VerticalLayout1:feathers.layout.VerticalLayout;

        public var _Dashboard_VerticalLayout2:feathers.layout.VerticalLayout;

        public var _Dashboard_VerticalLayout3:feathers.layout.VerticalLayout;

        internal var _631173356bottomGroup:feathers.controls.LayoutGroup;

        internal var _168965370calories:frontend.screen.dashboard.DashboardStatisticItem;

        internal var _288459765distance:frontend.screen.dashboard.DashboardStatisticItem;

        internal var _1631124157optionalInfoBox:feathers.controls.LayoutGroup;

        internal var _896192468spacer:feathers.controls.LayoutGroup;

        internal var _881387426tabbar:frontend.components.tabbar.TextTabBar;

        internal var _1089721031trainingTime:frontend.screen.dashboard.DashboardStatisticItem;

        internal var _904991449trainings:frontend.screen.dashboard.DashboardStatisticItem;

        internal var _data:Object;

        protected var _currentXField:String="week";

        internal var _buttonWidth:Number;

        internal var _buttonheight:Number;

        internal var _firstStatisticCall:Boolean=true;

        internal var _1682393525_optionalShortcutsHeight:Number=0;

        internal var _1435968178_optionalShortcutsPaddingBottom:Number=0;

        internal var _1388247852_shortcutHeight:Number=1;

        internal var _shortcutNoDevice:frontend.screen.dashboard.ShortcutNoDevice;

        internal var _1049628895_shortcutWidth:Number=1;

        internal var _702214056_statisticHeight:Number=1;

        internal var _2086894475_statisticWidth:Number=1;

        internal var callLater:flash.utils.Timer;

        internal static var _806339567padding:Number;

        public var _Dashboard_LayoutGroup1:feathers.controls.LayoutGroup;

        public var _Dashboard_LayoutGroup2:feathers.controls.LayoutGroup;

        public var _Dashboard_LayoutGroup6:feathers.controls.LayoutGroup;

        mx_internal var _watchers:Array;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _staticBindingEventDispatcher:starling.events.EventDispatcher;

        mx_internal var _bindings:Array;

        internal var _662388563activitiesShortcut:frontend.screen.dashboard.ActivitiesListShortcutElement;
    }
}


//  class DashboardBackgroundSkin
package frontend.screen.dashboard 
{
    import frontend.*;
    import starling.display.*;
    import starling.textures.*;
    
    public class DashboardBackgroundSkin extends starling.display.Sprite
    {
        public function DashboardBackgroundSkin()
        {
            super();
            var loc1:*=frontend.AssetsManagerCustom.getInstance().getTexture(frontend.Textures.bgDashboard);
            var loc2:*=new starling.display.Image(loc1);
            addChild(loc2);
            return;
        }
    }
}


//  class DashboardStatisticItem
package frontend.screen.dashboard 
{
    import core.general.*;
    import feathers.controls.*;
    import feathers.events.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import frontend.components.*;
    import frontend.components.core.*;
    import starling.display.*;
    import starling.events.*;
    
    public class DashboardStatisticItem extends frontend.components.core.Group
    {
        public function DashboardStatisticItem()
        {
            this._1398151987iconWidth = 50 * SIGMALink.scaleFactor;
            this._1973788148minItemHeight = 45 * SIGMALink.scaleFactor;
            this._480004446unitWidth = 50 * SIGMALink.scaleFactor;
            this._575915578elementGap = 17 * SIGMALink.scaleFactor;
            super();
            percentWidth = 100;
            minHeight = this.minItemHeight;
            backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            layout = new feathers.layout.AnchorLayout();
            return;
        }

        public function set labelText(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._607740351labelText;
            if (loc1 !== arg1) 
            {
                this._607740351labelText = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "labelText", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get minItemHeight():Number
        {
            return this._1973788148minItemHeight;
        }

        public function set minItemHeight(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1973788148minItemHeight;
            if (loc1 !== arg1) 
            {
                this._1973788148minItemHeight = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "minItemHeight", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get unitText():String
        {
            return this._292671279unitText;
        }

        public function set unitText(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._292671279unitText;
            if (loc1 !== arg1) 
            {
                this._292671279unitText = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "unitText", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get unitWidth():Number
        {
            return this._480004446unitWidth;
        }

        public function set unitWidth(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._480004446unitWidth;
            if (loc1 !== arg1) 
            {
                this._480004446unitWidth = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "unitWidth", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get valueText():String
        {
            return this._valueText;
        }

        internal function set _765711810valueText(arg1:String):void
        {
            this._valueText = arg1;
            this.valueLabel.text = this._valueText;
            return;
        }

        public override function set width(arg1:Number):void
        {
            super.width = arg1;
            if (this.unitLayoutData) 
            {
                this.unitLayoutData.left = width - this.unitWidth;
            }
            if (this.label) 
            {
                this.label.maxWidth = width - 2 * this.elementGap - this.iconWidth - this.valueLabel.width - this.unitWidth;
            }
            return;
        }

        public function set valueText(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.valueText;
            if (loc1 !== arg1) 
            {
                this._765711810valueText = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "valueText", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        protected function get elementGap():Number
        {
            return this._575915578elementGap;
        }

        protected function set elementGap(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._575915578elementGap;
            if (loc1 !== arg1) 
            {
                this._575915578elementGap = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "elementGap", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get unitLayoutData():feathers.layout.AnchorLayoutData
        {
            return this._514893160unitLayoutData;
        }

        internal function set unitLayoutData(arg1:feathers.layout.AnchorLayoutData):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._514893160unitLayoutData;
            if (loc1 !== arg1) 
            {
                this._514893160unitLayoutData = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "unitLayoutData", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            var loc1:*=new frontend.components.TextureImage();
            loc1.textureName = this.iconName;
            loc1.touchable = false;
            loc1.layoutData = this.setImagePos();
            addChild(loc1);
            this.label = new feathers.controls.Label();
            this.label.text = this.labelText;
            this.label.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUITEM;
            this.label.touchable = false;
            this.label.layoutData = this.setLabelPos();
            addChild(this.label);
            this.valueLabel = new feathers.controls.Label();
            this.valueLabel.text = this.valueText;
            this.valueLabel.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            this.valueLabel.touchable = false;
            this.valueLabel.layoutData = this.setValuePos();
            addChild(this.valueLabel);
            this.unit = new feathers.controls.Label();
            this.unit.text = this.unitText;
            this.unit.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_SMALLLISTLABEL;
            this.unit.touchable = false;
            this.unit.layoutData = this.setUnitPos();
            addChild(this.unit);
            return;
        }

        internal function setImagePos():feathers.layout.AnchorLayoutData
        {
            var loc1:*=new feathers.layout.AnchorLayoutData();
            loc1.left = this.elementGap;
            loc1.verticalCenter = 0;
            return loc1;
        }

        internal function setLabelPos():feathers.layout.AnchorLayoutData
        {
            var loc1:*=new feathers.layout.AnchorLayoutData();
            loc1.left = this.elementGap + this.iconWidth;
            loc1.verticalCenter = 0;
            return loc1;
        }

        internal function setValuePos():feathers.layout.AnchorLayoutData
        {
            var loc1:*=new feathers.layout.AnchorLayoutData();
            loc1.right = this.elementGap + this.unitWidth;
            loc1.verticalCenter = 0;
            return loc1;
        }

        internal function setUnitPos():feathers.layout.AnchorLayoutData
        {
            this.unitLayoutData = new feathers.layout.AnchorLayoutData();
            this.unitLayoutData.left = 0;
            this.unitLayoutData.verticalCenter = 0;
            return this.unitLayoutData;
        }

        public function get iconName():String
        {
            return this._738113884iconName;
        }

        public function set iconName(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._738113884iconName;
            if (loc1 !== arg1) 
            {
                this._738113884iconName = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "iconName", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get iconWidth():Number
        {
            return this._1398151987iconWidth;
        }

        public function set iconWidth(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1398151987iconWidth;
            if (loc1 !== arg1) 
            {
                this._1398151987iconWidth = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "iconWidth", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get labelText():String
        {
            return this._607740351labelText;
        }

        internal var _738113884iconName:String="";

        internal var _1398151987iconWidth:Number;

        internal var _607740351labelText:String;

        internal var _1973788148minItemHeight:Number;

        internal var _292671279unitText:String;

        internal var _480004446unitWidth:Number;

        internal var _valueText:String;

        protected var _575915578elementGap:Number;

        internal var label:feathers.controls.Label;

        internal var unit:feathers.controls.Label;

        internal var _514893160unitLayoutData:feathers.layout.AnchorLayoutData;

        internal var valueLabel:feathers.controls.Label;
    }
}


//  class ShortcutElement
package frontend.screen.dashboard 
{
    import core.general.*;
    import feathers.controls.*;
    import feathers.events.*;
    import feathers.layout.*;
    import frontend.components.*;
    import handler.*;
    import starling.display.*;
    import starling.events.*;
    
    public class ShortcutElement extends feathers.controls.LayoutGroup
    {
        public function ShortcutElement()
        {
            this._575915578elementGap = 6 * SIGMALink.scaleFactor;
            super();
            backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            layout = new feathers.layout.VerticalLayout();
            (layout as feathers.layout.VerticalLayout).gap = this.elementGap;
            (layout as feathers.layout.VerticalLayout).verticalAlign = feathers.layout.VerticalAlign.MIDDLE;
            (layout as feathers.layout.VerticalLayout).horizontalAlign = feathers.layout.HorizontalAlign.CENTER;
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            addEventListener(starling.events.TouchEvent.TOUCH, this.onTouch);
            this.addIcon();
            this.addLabel();
            return;
        }

        protected function addIcon():void
        {
            var loc1:*=null;
            if (this.iconName != "") 
            {
                loc1 = new frontend.components.TextureImage();
                loc1.textureName = this.iconName;
                loc1.touchable = false;
                addChild(loc1);
            }
            return;
        }

        protected function addLabel():void
        {
            this.label = new feathers.controls.Label();
            this.label.text = this.labelText;
            this.label.styleName = "DASHBOARD_SHORTCUT_LABEL";
            this.label.touchable = false;
            addChild(this.label);
            return;
        }

        internal function onTouch(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            handler.ViewHandler.getInstance().showScreen(this.targetClass, this.viewData, handler.ViewHandler.slideToLeftTransition());
            return;
        }

        public function get iconName():String
        {
            return this._738113884iconName;
        }

        public function set iconName(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._738113884iconName;
            if (loc1 !== arg1) 
            {
                this._738113884iconName = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "iconName", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get labelText():String
        {
            return this._607740351labelText;
        }

        public function set labelText(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._607740351labelText;
            if (loc1 !== arg1) 
            {
                this._607740351labelText = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "labelText", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get targetClass():String
        {
            return this._2110678425targetClass;
        }

        public function set targetClass(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._2110678425targetClass;
            if (loc1 !== arg1) 
            {
                this._2110678425targetClass = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "targetClass", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        protected function get elementGap():Number
        {
            return this._575915578elementGap;
        }

        protected function set elementGap(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._575915578elementGap;
            if (loc1 !== arg1) 
            {
                this._575915578elementGap = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "elementGap", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal var _738113884iconName:String="";

        internal var _607740351labelText:String;

        internal var _2110678425targetClass:String;

        public var viewData:Object=null;

        protected var _575915578elementGap:Number;

        protected var label:feathers.controls.Label;
    }
}


//  class ShortcutNoDevice
package frontend.screen.dashboard 
{
    import core.general.*;
    import feathers.binding.*;
    import feathers.controls.*;
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
    import frontend.*;
    import frontend.components.*;
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
    
    public class ShortcutNoDevice extends feathers.controls.LayoutGroup implements feathers.binding.IBindingClient
    {
        public function ShortcutNoDevice()
        {
            var bindings:Array;
            var watchers:Array;
            var target:Object;
            var i:uint;
            var watcherSetupUtilClass:Object;

            var loc1:*;
            target = null;
            watcherSetupUtilClass = null;
            this._581074019_paddingBottom = 2 * SIGMALink.scaleFactor;
            this.mx_internal::_bindings = [];
            this.mx_internal::_watchers = [];
            this.mx_internal::_bindingsByDestination = {};
            this.mx_internal::_bindingsBeginWithWord = {};
            super();
            bindings = this._ShortcutNoDevice_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_dashboard_ShortcutNoDeviceWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return frontend.screen.dashboard.ShortcutNoDevice[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.mxmlContent = [this._ShortcutNoDevice_LayoutGroup2_i(), this._ShortcutNoDevice_TextureImage1_i()];
            this.addEventListener("initialize", this.___ShortcutNoDevice_LayoutGroup1_initialize);
            this.addEventListener("touch", this.___ShortcutNoDevice_LayoutGroup1_touch);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        public function get title():feathers.controls.Label
        {
            return this._110371416title;
        }

        public function set title(arg1:feathers.controls.Label):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._110371416title;
            if (loc1 !== arg1) 
            {
                this._110371416title = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "title", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _leftGroupWidth():Number
        {
            return this._115690509_leftGroupWidth;
        }

        internal function set _leftGroupWidth(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._115690509_leftGroupWidth;
            if (loc1 !== arg1) 
            {
                this._115690509_leftGroupWidth = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_leftGroupWidth", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _paddingBottom():Number
        {
            return this._581074019_paddingBottom;
        }

        internal function set _paddingBottom(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._581074019_paddingBottom;
            if (loc1 !== arg1) 
            {
                this._581074019_paddingBottom = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_paddingBottom", loc1, arg1, this);
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
            frontend.screen.dashboard.ShortcutNoDevice._watcherSetupUtil = arg1;
            return;
        }

        protected override function validateChildren():void
        {
            super.validateChildren();
            this._leftGroupWidth = this.textGroup.width;
            return;
        }

        protected function touchHandler(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_ADD_DEVICE_POSSIBLE_DEVICES, null, handler.ViewHandler.slideToLeftTransition());
            return;
        }

        protected function onInit(arg1:starling.events.Event):void
        {
            (layout as feathers.layout.HorizontalLayout).gap = frontend.screen.dashboard.Dashboard.padding / 2;
            (layout as feathers.layout.HorizontalLayout).padding = frontend.screen.dashboard.Dashboard.padding;
            (layout as feathers.layout.HorizontalLayout).verticalAlign = feathers.layout.VerticalAlign.MIDDLE;
            return;
        }

        internal function _ShortcutNoDevice_LayoutGroup2_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._ShortcutNoDevice_VerticalLayout1_i();
            loc1.mxmlContent = [this._ShortcutNoDevice_Label1_i(), this._ShortcutNoDevice_Label2_i()];
            loc1.id = "textGroup";
            this.textGroup = loc1;
            feathers.binding.BindingManager.executeBindings(this, "textGroup", this.textGroup);
            return loc1;
        }

        internal function _ShortcutNoDevice_VerticalLayout1_i():feathers.layout.VerticalLayout
        {
            var loc1:*=new feathers.layout.VerticalLayout();
            this._ShortcutNoDevice_VerticalLayout1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ShortcutNoDevice_VerticalLayout1", this._ShortcutNoDevice_VerticalLayout1);
            return loc1;
        }

        internal function _ShortcutNoDevice_Label1_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.styleName = "DASHBOARD_OPTION_TITLE";
            loc1.id = "title";
            this.title = loc1;
            feathers.binding.BindingManager.executeBindings(this, "title", this.title);
            return loc1;
        }

        internal function _ShortcutNoDevice_Label2_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.styleName = "DASHBOARD_OPTION_TEXT";
            loc1.wordWrap = true;
            loc1.id = "text";
            this.text = loc1;
            feathers.binding.BindingManager.executeBindings(this, "text", this.text);
            return loc1;
        }

        internal function _ShortcutNoDevice_TextureImage1_i():frontend.components.TextureImage
        {
            var loc1:*=new frontend.components.TextureImage();
            loc1.touchable = false;
            loc1.id = "_ShortcutNoDevice_TextureImage1";
            this._ShortcutNoDevice_TextureImage1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ShortcutNoDevice_TextureImage1", this._ShortcutNoDevice_TextureImage1);
            return loc1;
        }

        public function ___ShortcutNoDevice_LayoutGroup1_initialize(arg1:starling.events.Event):void
        {
            this.onInit(arg1);
            return;
        }

        public function ___ShortcutNoDevice_LayoutGroup1_touch(arg1:starling.events.TouchEvent):void
        {
            this.touchHandler(arg1);
            return;
        }

        internal function _ShortcutNoDevice_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            }, null, "this.backgroundSkin")
            result[1] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return new feathers.layout.HorizontalLayout();
            }, null, "this.layout")
            result[2] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.VerticalLayoutData(100);
            }, null, "this.layoutData")
            result[3] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "this.width")
            result[4] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.HorizontalLayoutData(100);
            }, null, "textGroup.layoutData")
            result[5] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.screen.dashboard.Dashboard.padding / 2;
            }, null, "_ShortcutNoDevice_VerticalLayout1.gap")
            result[6] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("DASHBOARD.NO_DEVICE_TITLE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "title.text")
            result[7] = new feathers.binding.Binding(this, function ():Number
            {
                return _leftGroupWidth;
            }, null, "title.width")
            result[8] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("DASHBOARD.NO_DEVICE_TEXT");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "text.text")
            result[9] = new feathers.binding.Binding(this, function ():Number
            {
                return _leftGroupWidth;
            }, null, "text.width")
            result[10] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.dashboardbigadddevice;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ShortcutNoDevice_TextureImage1.textureName")
            return result;
        }

        public function get text():feathers.controls.Label
        {
            return this._3556653text;
        }

        public function set text(arg1:feathers.controls.Label):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._3556653text;
            if (loc1 !== arg1) 
            {
                this._3556653text = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "text", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get textGroup():feathers.controls.LayoutGroup
        {
            return this._1059785390textGroup;
        }

        public function set textGroup(arg1:feathers.controls.LayoutGroup):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1059785390textGroup;
            if (loc1 !== arg1) 
            {
                this._1059785390textGroup = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "textGroup", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public var _ShortcutNoDevice_TextureImage1:frontend.components.TextureImage;

        public var _ShortcutNoDevice_VerticalLayout1:feathers.layout.VerticalLayout;

        internal var _3556653text:feathers.controls.Label;

        internal var _1059785390textGroup:feathers.controls.LayoutGroup;

        internal var _110371416title:feathers.controls.Label;

        internal var _115690509_leftGroupWidth:Number=1;

        internal var _581074019_paddingBottom:Number;

        mx_internal var _bindingsBeginWithWord:Object;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


