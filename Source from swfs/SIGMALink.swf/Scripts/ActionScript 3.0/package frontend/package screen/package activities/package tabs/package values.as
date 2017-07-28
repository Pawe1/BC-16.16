//package values
//  package list
//    class ActivityValueDataProviderObject
package frontend.screen.activities.tabs.values.list 
{
    import utils.converter.*;
    import utils.interfaces.*;
    
    public class ActivityValueDataProviderObject extends Object
    {
        public function ActivityValueDataProviderObject()
        {
            this.footer = {"label":"test"};
            super();
            return;
        }

        public function setValue(arg1:Object, arg2:utils.converter.IConverter=null, arg3:utils.interfaces.ICustomFormatterBase=null):void
        {
            if (arg2) 
            {
                if (arg3) 
                {
                    this.value = arg3.format(arg2.convert(arg1));
                }
                else 
                {
                    this.value = arg2.convert(arg1).toString();
                }
            }
            else if (arg3) 
            {
                this.value = arg3.format(arg1);
            }
            else 
            {
                this.value = arg1 + "";
            }
            return;
        }

        public var clickCallback:Function;

        public var footer:Object;

        public var header:Object;

        public var iconSource:String;

        public var iconText:String;

        public var isHline:Boolean=false;

        public var isSeperator:Boolean=false;

        public var key:String;

        public var speedBasedValue:Number;

        public var unit:String;

        public var value:String;

        public var valueIconSource:String;
    }
}


//    class ActivityValueListFooterItemRenderer
package frontend.screen.activities.tabs.values.list 
{
    import core.general.*;
    import feathers.controls.renderers.*;
    import starling.display.*;
    
    public class ActivityValueListFooterItemRenderer extends feathers.controls.renderers.DefaultGroupedListHeaderOrFooterRenderer implements feathers.controls.renderers.IGroupedListHeaderOrFooterRenderer
    {
        public function ActivityValueListFooterItemRenderer()
        {
            super();
            height = ROW_HEIGHT;
            styleProvider = null;
            backgroundSkin = new starling.display.Quad(SIGMALink.appWidth, ROW_HEIGHT, core.general.Colors.LIGHTGREY);
            contentLabelFunction = this.noLabelFunction;
            return;
        }

        internal function noLabelFunction(arg1:Object):String
        {
            return "";
        }

        internal static const ROW_HEIGHT:Number=29 * SIGMALink.scaleFactor;
    }
}


//    class ActivityValueListHeaderItemRenderer
package frontend.screen.activities.tabs.values.list 
{
    import core.general.*;
    import feathers.controls.*;
    import feathers.controls.renderers.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import frontend.components.*;
    import handler.*;
    import starling.display.*;
    import starling.events.*;
    
    public class ActivityValueListHeaderItemRenderer extends feathers.controls.renderers.DefaultGroupedListHeaderOrFooterRenderer implements feathers.controls.renderers.IGroupedListHeaderOrFooterRenderer
    {
        public function ActivityValueListHeaderItemRenderer()
        {
            super();
            backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            height = ROW_HEIGHT;
            padding = 0;
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            this.holderGroup = new feathers.controls.LayoutGroup();
            this.holderGroup.layout = new feathers.layout.AnchorLayout();
            this.holderGroup.height = ROW_HEIGHT;
            this.holderGroup.width = SIGMALink.appWidth;
            this.holderGroup.backgroundSkin = new starling.display.Quad(1, 1, 16777215);
            this.icon = new frontend.components.TextureImage();
            this.icon.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, ipadding, NaN, 0);
            this.holderGroup.addChild(this.icon);
            this.text = new feathers.controls.Label();
            this.text.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_BIGLISTLABEL;
            this.text.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, ipadding + COL_ICON_WIDTH, NaN, 0);
            this.holderGroup.addChild(this.text);
            this.value = new feathers.controls.Label();
            this.value.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            this.value.layoutData = new feathers.layout.AnchorLayoutData(NaN, ipadding + COL_ICON_WIDTH, NaN, NaN, NaN, 0);
            this.holderGroup.addChild(this.value);
            this.unit = new feathers.controls.Label();
            this.unit.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_SMALLLISTLABEL;
            this.unit.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, SIGMALink.appWidth - COL_ICON_WIDTH, NaN, 0);
            this.unit.addEventListener(starling.events.TouchEvent.TOUCH, this.onTouch);
            this.holderGroup.addChild(this.unit);
            addChild(this.holderGroup);
            return;
        }

        internal function onTouch(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            var loc1:*=data as frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject;
            if (loc1.clickCallback != null) 
            {
                loc1.clickCallback();
            }
            return;
        }

        protected override function commitData():void
        {
            if (!data) 
            {
                return;
            }
            var loc1:*=data as frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject;
            this.icon.textureName = loc1.iconSource;
            this.text.text = loc1.iconText;
            this.value.text = loc1.value;
            this.unit.text = loc1.unit;
            this.value.validate();
            this.text.maxWidth = width - 2 * ipadding - 2 * COL_ICON_WIDTH - this.value.width;
            return;
        }

        
        {
            COL_ICON_WIDTH = 80 * SIGMALink.scaleFactor;
            ROW_HEIGHT = 85 * SIGMALink.scaleFactor;
            ipadding = 17 * SIGMALink.scaleFactor;
        }

        internal var holderGroup:feathers.controls.LayoutGroup;

        internal var icon:frontend.components.TextureImage;

        internal var text:feathers.controls.Label;

        internal var unit:feathers.controls.Label;

        internal var value:feathers.controls.Label;

        internal static var COL_ICON_WIDTH:uint;

        internal static var ROW_HEIGHT:Number;

        internal static var ipadding:Number;
    }
}


//    class ActivityValueListItemRenderer
package frontend.screen.activities.tabs.values.list 
{
    import core.general.*;
    import feathers.controls.*;
    import feathers.controls.renderers.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import frontend.components.*;
    import handler.*;
    import starling.display.*;
    import starling.events.*;
    
    public class ActivityValueListItemRenderer extends feathers.controls.renderers.DefaultGroupedListItemRenderer
    {
        public function ActivityValueListItemRenderer()
        {
            super();
            height = ROW_HEIGHT;
            horizontalAlign = feathers.controls.renderers.DefaultListItemRenderer.HORIZONTAL_ALIGN_LEFT;
            verticalAlign = feathers.controls.renderers.DefaultListItemRenderer.VERTICAL_ALIGN_MIDDLE;
            styleProvider = null;
            defaultSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            defaultSelectedSkin = new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            this.holderGroup = new feathers.controls.LayoutGroup();
            this.holderGroup.layout = new feathers.layout.AnchorLayout();
            this.holderGroup.height = ROW_HEIGHT;
            this.holderGroup.width = SIGMALink.appWidth;
            this.holderGroup.backgroundSkin = new starling.display.Quad(1, 1, 16777215);
            this.icon = new frontend.components.TextureImage();
            this.icon.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, ipadding, NaN, 0);
            this.holderGroup.addChild(this.icon);
            this.text = new feathers.controls.Label();
            this.text.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_BIGLISTLABEL;
            this.text.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, ipadding, NaN, 0);
            this.holderGroup.addChild(this.text);
            this.value = new feathers.controls.Label();
            this.value.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            this.value.layoutData = new feathers.layout.AnchorLayoutData(NaN, ipadding + COL_ICON_WIDTH, NaN, NaN, NaN, 0);
            this.holderGroup.addChild(this.value);
            this.unit = new feathers.controls.Label();
            this.unit.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_SMALLLISTLABEL;
            this.unit.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, SIGMALink.appWidth - COL_ICON_WIDTH, NaN, 0);
            this.unit.addEventListener(starling.events.TouchEvent.TOUCH, this.onTouch);
            this.holderGroup.addChild(this.unit);
            addChild(this.holderGroup);
            var loc1:*=new starling.display.Quad(SIGMALink.appWidth, 1, core.general.Colors.LIGHTGREY);
            addChild(loc1);
            return;
        }

        internal function onTouch(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            var loc1:*=data as frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject;
            if (loc1.clickCallback != null) 
            {
                loc1.clickCallback();
            }
            return;
        }

        protected override function commitData():void
        {
            if (!data) 
            {
                return;
            }
            var loc1:*=data as frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject;
            this.icon.textureName = loc1.iconSource;
            this.text.text = loc1.iconText;
            this.value.text = loc1.value;
            this.unit.text = loc1.unit;
            return;
        }

        
        {
            COL_ICON_WIDTH = 80 * SIGMALink.scaleFactor;
            COL_UNIT_WIDTH = 50 * SIGMALink.scaleFactor;
            ROW_HEIGHT = 51 * SIGMALink.scaleFactor;
            ipadding = 17 * SIGMALink.scaleFactor;
        }

        internal var holderGroup:feathers.controls.LayoutGroup;

        internal var icon:frontend.components.TextureImage;

        internal var text:feathers.controls.Label;

        internal var unit:feathers.controls.Label;

        internal var value:feathers.controls.Label;

        internal static var COL_ICON_WIDTH:uint;

        internal static var COL_UNIT_WIDTH:uint;

        internal static var ROW_HEIGHT:uint;

        internal static var ipadding:Number;
    }
}


//    class ActivityValuesGroup
package frontend.screen.activities.tabs.values.list 
{
    public class ActivityValuesGroup extends Object
    {
        public function ActivityValuesGroup()
        {
            this.children = [];
            this.footer = {"text":""};
            super();
            return;
        }

        public function addChild(arg1:frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject):void
        {
            if (arg1 is frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject) 
            {
                this.children.push(arg1);
            }
            return;
        }

        public var children:Array;

        public var footer:Object;

        public var header:Object;
    }
}


//  class ActivityValuesTabView
package frontend.screen.activities.tabs.values 
{
    import backend.utils.*;
    import backend.utils.dbUtils.*;
    import configCache.*;
    import core.activities.*;
    import core.general.*;
    import debug.*;
    import feathers.binding.*;
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
    import frontend.*;
    import frontend.components.list.*;
    import frontend.components.tab.*;
    import frontend.components.tabbarbase.*;
    import frontend.screen.activities.*;
    import frontend.screen.activities.tabs.values.list.*;
    import handler.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    import utils.*;
    import utils.format.*;
    
    use namespace mx_internal;
    
    public class ActivityValuesTabView extends frontend.components.tabbarbase.TabLayoutGroup implements feathers.binding.IBindingClient
    {
        public function ActivityValuesTabView()
        {
            var bindings:Array;
            var watchers:Array;
            var target:Object;
            var i:uint;
            var watcherSetupUtilClass:Object;

            var loc1:*;
            target = null;
            watcherSetupUtilClass = null;
            this.dictHCObjects = [];
            this.speedBasedObjects = [];
            this.mx_internal::_bindings = [];
            this.mx_internal::_watchers = [];
            this.mx_internal::_bindingsByDestination = {};
            this.mx_internal::_bindingsBeginWithWord = {};
            super();
            bindings = this._ActivityValuesTabView_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_activities_tabs_values_ActivityValuesTabViewWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return frontend.screen.activities.tabs.values.ActivityValuesTabView[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.mxmlContent = [this._ActivityValuesTabView_CustomGroupedList1_i()];
            this.addEventListener("addedToStage", this.___ActivityValuesTabView_TabLayoutGroup1_addedToStage);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        public function get groupedList():frontend.components.list.CustomGroupedList
        {
            return this._1258726684groupedList;
        }

        public function set groupedList(arg1:frontend.components.list.CustomGroupedList):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1258726684groupedList;
            if (loc1 !== arg1) 
            {
                this._1258726684groupedList = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "groupedList", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get activity():core.activities.Activity
        {
            return this._activity;
        }

        public function set activity(arg1:core.activities.Activity):void
        {
            this._activity = arg1;
            return;
        }

        internal function get contentHeight():Number
        {
            return this._655379712contentHeight;
        }

        internal function set contentHeight(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._655379712contentHeight;
            if (loc1 !== arg1) 
            {
                this._655379712contentHeight = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "contentHeight", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get dataProvider():feathers.data.HierarchicalCollection
        {
            return this._339742651dataProvider;
        }

        internal function set dataProvider(arg1:feathers.data.HierarchicalCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._339742651dataProvider;
            if (loc1 !== arg1) 
            {
                this._339742651dataProvider = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "dataProvider", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function loadActivityMarkerComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            handler.ActivityHandler.getInstance().loadActivityMarkerComplete(arg1.getResult(), this._activity);
            this.onActivityDataLoaded();
            return;
        }

        protected function addedToStageHandler(arg1:starling.events.Event):void
        {
            this.updateSpeedBasedObjects();
            return;
        }

        internal function loadActivityData():void
        {
            if (this._activity.dataType != core.general.DataType.LOG) 
            {
                this.onActivityDataLoaded();
            }
            else if (this._activity.entries.length != 0) 
            {
                if (this._activity.markerList.length != 0) 
                {
                    this.onActivityDataLoaded();
                }
                else 
                {
                    this.loadMarkers();
                }
            }
            else 
            {
                this.loadEntries();
            }
            return;
        }

        internal function onActivityDataLoaded():void
        {
            if (this.contentLoadedCallback != null) 
            {
                this.contentLoadedCallback();
            }
            return;
        }

        internal function loadEntries():void
        {
            var loc1:*=handler.ActivityHandler.getInstance().generateLoadActivityEntries(this._activity.activityId);
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, loc1, this.loadActivityEntriesComplete, this.loadActivityEntriesError, Workers.worker_DatabaseWorker);
            return;
        }

        internal function loadActivityEntriesError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("activityEntriesError");
            return;
        }

        internal function loadActivityEntriesComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            handler.ActivityHandler.getInstance().loadActivityEntriesComplete(arg1.getResult(), this._activity);
            if (this._activity.markerList.length != 0) 
            {
                this.onActivityDataLoaded();
            }
            else 
            {
                this.loadMarkers();
            }
            return;
        }

        internal function loadMarkers():void
        {
            var loc1:*=handler.ActivityHandler.getInstance().generateLoadActivityMarker(this._activity.activityId);
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, loc1, this.loadActivityMarkerComplete, this.loadActivityMarkerError, Workers.worker_DatabaseWorker);
            return;
        }

        internal function loadActivityMarkerError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("activityMarkerError");
            return;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            frontend.screen.activities.tabs.values.ActivityValuesTabView._watcherSetupUtil = arg1;
            return;
        }

        internal function pushLine(arg1:frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject, arg2:int):void
        {
            var loc1:*=null;
            if (arg2 > (this.dictHCObjects.length - 1)) 
            {
                loc1 = new frontend.screen.activities.tabs.values.list.ActivityValuesGroup();
                loc1.header = arg1;
                this.dictHCObjects.push(loc1);
            }
            else 
            {
                loc1 = this.dictHCObjects[arg2] as frontend.screen.activities.tabs.values.list.ActivityValuesGroup;
                loc1.addChild(arg1);
            }
            return;
        }

        internal function createDataProvider():void
        {
            var loc1:*=0;
            this.dataProvider = new feathers.data.HierarchicalCollection();
            var loc2:*=this.dictHCObjects.length;
            loc1 = 0;
            while (loc1 < loc2) 
            {
                this.dataProvider.addItemAt(this.dictHCObjects[loc1], loc1);
                ++loc1;
            }
            return;
        }

        public override function showContent():void
        {
            this.dictHCObjects = [];
            this.speedBasedObjects = [];
            this.addToDataProviderTrainingTime(this.dictHCObjects.length);
            this.addToDataProviderDistance(this.dictHCObjects.length);
            this.addToDataProviderSpeed(this.dictHCObjects.length);
            this.addToDataProviderFuelEconomy(this.dictHCObjects.length);
            this.addToDataProviderTripsection(this.dictHCObjects.length);
            this.addToDataProviderAltitude(this.dictHCObjects.length);
            this.addToDataProviderHeartrate(this.dictHCObjects.length);
            this.addToDataProviderCalories(this.dictHCObjects.length);
            this.addToDataProviderIncline(this.dictHCObjects.length);
            this.addToDataProviderRiseRate(this.dictHCObjects.length);
            this.addToDataProviderCadence(this.dictHCObjects.length);
            this.addToDataProviderPower(this.dictHCObjects.length);
            this.addToDataProviderExpansion(this.dictHCObjects.length);
            this.addToDataProviderDistancePlusMinus(this.dictHCObjects.length);
            this.addToDataProviderBest5K(this.dictHCObjects.length);
            this.addToDataProviderTemperature(this.dictHCObjects.length);
            this.addToDataProviderNP(this.dictHCObjects.length);
            this.addToDataProviderBalance(this.dictHCObjects.length);
            this.addToDataProviderPedalingTime(this.dictHCObjects.length);
            this.createDataProvider();
            this.loadActivityData();
            return;
        }

        public override function hideContent():void
        {
            this.dictHCObjects = [];
            this.dataProvider = new feathers.data.HierarchicalCollection();
            return;
        }

        internal function addToDataProviderTrainingTime(arg1:int):void
        {
            var loc1:*=null;
            if (this.activity.trainingTimeDefined) 
            {
                loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                loc1.key = GROUP_TRAININGTIME;
                loc1.iconSource = frontend.Textures.laengstezeit;
                loc1.iconText = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_TRAININGTIME");
                loc1.setValue(this.activity.trainingTime, null, backend.utils.DataUtils.timeFormatter);
                loc1.unit = backend.utils.DataUtils.unitStringTimeHours;
                this.pushLine(loc1, arg1);
            }
            if (this.activity.exerciseTimeDefined) 
            {
                loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                loc1.key = GROUP_TRAININGTIME;
                loc1.iconText = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_TRAININGTIME_BRUTTO");
                loc1.setValue(this.activity.exerciseTime, null, backend.utils.DataUtils.timeFormatter);
                loc1.unit = backend.utils.DataUtils.unitStringTimeHours;
                this.pushLine(loc1, arg1);
            }
            if (this.activity.trainingTimeUphillDefined) 
            {
                loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                loc1.key = GROUP_TRAININGTIME;
                loc1.iconSource = frontend.Textures.bergauf;
                loc1.setValue(this.activity.trainingTimeUphill, null, backend.utils.DataUtils.timeFormatter);
                loc1.unit = backend.utils.DataUtils.unitStringTimeHours;
                this.pushLine(loc1, arg1);
            }
            if (this.activity.trainingTimeDownhillDefined) 
            {
                loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                loc1.key = GROUP_TRAININGTIME;
                loc1.iconSource = frontend.Textures.bergab;
                loc1.setValue(this.activity.trainingTimeDownhill, null, backend.utils.DataUtils.timeFormatter);
                loc1.unit = backend.utils.DataUtils.unitStringTimeHours;
                this.pushLine(loc1, arg1);
            }
            return;
        }

        internal function addToDataProviderDistance(arg1:int):void
        {
            var loc1:*=null;
            if (this.activity.distanceDefined) 
            {
                loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                loc1.key = GROUP_DISTANCE;
                loc1.iconSource = frontend.Textures.strecke;
                loc1.iconText = backend.utils.DataUtils.distanceLabel;
                loc1.setValue(this.activity.distance, backend.utils.DataUtils.distanceConverter, backend.utils.DataUtils.distanceFormatter);
                loc1.unit = backend.utils.DataUtils.unitStringDistance;
                this.pushLine(loc1, arg1);
                if (this.activity.distanceUphillDefined) 
                {
                    loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                    loc1.key = GROUP_DISTANCE;
                    loc1.iconSource = frontend.Textures.bergauf;
                    loc1.setValue(this.activity.distanceUphill, backend.utils.DataUtils.distanceConverter, backend.utils.DataUtils.distanceFormatter);
                    loc1.unit = backend.utils.DataUtils.unitStringDistance;
                    this.pushLine(loc1, arg1);
                }
                if (this.activity.distanceDownhillDefined) 
                {
                    loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                    loc1.key = GROUP_DISTANCE;
                    loc1.iconSource = frontend.Textures.bergab;
                    loc1.setValue(this.activity.distanceDownhill, backend.utils.DataUtils.distanceConverter, backend.utils.DataUtils.distanceFormatter);
                    loc1.unit = backend.utils.DataUtils.unitStringDistance;
                    this.pushLine(loc1, arg1);
                }
            }
            return;
        }

        internal function swapSpeedFormat():void
        {
            var loc1:*=configCache.ConfigCache.getInstance().getSportSpeedFormatValue(this.activity.sport);
            loc1 = loc1 != utils.format.SpeedFormat.DISTANCE_PER_TIME ? utils.format.SpeedFormat.DISTANCE_PER_TIME : utils.format.SpeedFormat.TIME_PER_DISTANCE;
            configCache.ConfigCache.getInstance().setSportSpeedFormatValue(this.activity.sport, loc1);
            handler.ViewHandler.getInstance().dispatchEventWith(handler.ViewHandler.EVENT_SPEED_FORMAT_CHANGED);
            this.updateSpeedBasedObjects();
            return;
        }

        internal function updateSpeedBasedObjects():void
        {
            var loc1:*=0;
            var loc3:*=null;
            var loc5:*=NaN;
            var loc2:*=this.speedBasedObjects.length;
            var loc4:*=configCache.ConfigCache.getInstance().getSportSpeedFormatValue(this.activity.sport);
            loc1 = 0;
            while (loc1 < loc2) 
            {
                loc3 = this.speedBasedObjects[loc1];
                if (loc4 != utils.format.SpeedFormat.DISTANCE_PER_TIME) 
                {
                    loc5 = utils.Calculations.calculateSpeedTime(loc3.speedBasedValue);
                    if (loc5 != utils.Calculations.speedTimeMaximum()) 
                    {
                        loc3.setValue(loc5 * 100, null, backend.utils.DataUtils.timeFormatter_MM_SS);
                    }
                    else 
                    {
                        loc3.value = "--:--";
                    }
                    loc3.unit = backend.utils.DataUtils.unitStringSpeedTime;
                }
                else 
                {
                    loc3.setValue(loc3.speedBasedValue, backend.utils.DataUtils.speedConverter, backend.utils.DataUtils.speedFormatter);
                    loc3.unit = backend.utils.DataUtils.unitStringSpeed;
                }
                ++loc1;
            }
            if (this.dataProvider) 
            {
                this.dataProvider.updateAll();
            }
            return;
        }

        internal function addToDataProviderSpeed(arg1:int):void
        {
            var loc1:*=null;
            if (this.activity.averageSpeedDefined) 
            {
                loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                loc1.key = GROUP_SPEED;
                loc1.iconSource = frontend.Textures.IconSpeed;
                loc1.iconText = backend.utils.DataUtils.speedLabel;
                loc1.speedBasedValue = this.activity.averageSpeed;
                loc1.valueIconSource = frontend.Textures.averageiconmini;
                loc1.clickCallback = this.swapSpeedFormat;
                this.pushLine(loc1, arg1);
                this.speedBasedObjects.push(loc1);
                if (this.activity.averageSpeedUphillDefined) 
                {
                    loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                    loc1.key = GROUP_SPEED;
                    loc1.iconSource = frontend.Textures.averageuphillsmall;
                    loc1.speedBasedValue = this.activity.averageSpeedUphill;
                    loc1.unit = backend.utils.DataUtils.unitStringSpeed;
                    loc1.clickCallback = this.swapSpeedFormat;
                    this.pushLine(loc1, arg1);
                    this.speedBasedObjects.push(loc1);
                }
                if (this.activity.averageSpeedDownhillDefined) 
                {
                    loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                    loc1.key = GROUP_SPEED;
                    loc1.iconSource = frontend.Textures.averagedownhillsmall;
                    loc1.speedBasedValue = this.activity.averageSpeedDownhill;
                    loc1.unit = backend.utils.DataUtils.unitStringSpeed;
                    loc1.clickCallback = this.swapSpeedFormat;
                    this.pushLine(loc1, arg1);
                    this.speedBasedObjects.push(loc1);
                }
                if (this.activity.minimumSpeedDefined) 
                {
                    loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                    loc1.key = GROUP_SPEED;
                    loc1.iconText = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_MIN");
                    loc1.speedBasedValue = this.activity.minimumSpeed;
                    loc1.speedBasedValue = backend.utils.DataUtils.speedConverter.convert(this.activity.minimumSpeed);
                    loc1.unit = backend.utils.DataUtils.unitStringSpeed;
                    loc1.clickCallback = this.swapSpeedFormat;
                    this.pushLine(loc1, arg1);
                    this.speedBasedObjects.push(loc1);
                }
                if (this.activity.maximumSpeedDefined) 
                {
                    loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                    loc1.key = GROUP_SPEED;
                    loc1.iconText = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_MAX");
                    loc1.speedBasedValue = this.activity.maximumSpeed;
                    loc1.unit = backend.utils.DataUtils.unitStringSpeed;
                    loc1.clickCallback = this.swapSpeedFormat;
                    this.pushLine(loc1, arg1);
                    this.speedBasedObjects.push(loc1);
                }
                this.updateSpeedBasedObjects();
            }
            return;
        }

        internal function addToDataProviderFuelEconomy(arg1:int):void
        {
            var loc1:*=null;
            if (this.activity.fuelEconomyDefined) 
            {
                loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                loc1.key = GROUP_FUELECONOMY;
                loc1.iconSource = frontend.Textures.fuelicon;
                loc1.iconText = backend.utils.DataUtils.fuelEconomyLabel;
                loc1.setValue(this.activity.fuelEconomy, backend.utils.DataUtils.fuelEconomyConverter, backend.utils.DataUtils.fuelEconomyFormatter);
                loc1.unit = backend.utils.DataUtils.unitStringFuelEconomy;
                this.pushLine(loc1, arg1);
            }
            return;
        }

        internal function addToDataProviderTripsection(arg1:int):void
        {
            var loc1:*=null;
            if (this.activity.tripSectionTimeDefined || this.activity.tripSectionDistanceDefined) 
            {
                if (this.activity.tripSectionTimeDefined) 
                {
                    loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                    loc1.key = GROUP_TRIPSECTION;
                    loc1.iconSource = frontend.Textures.laengstezeit;
                    loc1.iconText = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_TRIP_SECTION");
                    loc1.setValue(this.activity.tripSectionTime, null, backend.utils.DataUtils.timeFormatter);
                    loc1.unit = backend.utils.DataUtils.unitStringTimeHours;
                    this.pushLine(loc1, arg1);
                }
                if (loc1) 
                {
                    loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                    loc1.key = GROUP_TRIPSECTION;
                    loc1.iconSource = frontend.Textures.streckesmall;
                    loc1.setValue(this.activity.tripSectionDistance, backend.utils.DataUtils.distanceConverter, backend.utils.DataUtils.distanceFormatter);
                    loc1.unit = backend.utils.DataUtils.unitStringDistance;
                    this.pushLine(loc1, arg1);
                }
                else 
                {
                    loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                    loc1.key = GROUP_TRIPSECTION;
                    loc1.iconSource = frontend.Textures.strecke;
                    loc1.iconText = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_TRIP_SECTION");
                    loc1.setValue(this.activity.tripSectionDistance, backend.utils.DataUtils.distanceConverter, backend.utils.DataUtils.distanceFormatter);
                    loc1.unit = backend.utils.DataUtils.unitStringDistance;
                    this.pushLine(loc1, arg1);
                }
            }
            return;
        }

        internal function addToDataProviderAltitude(arg1:int):void
        {
            var loc1:*=null;
            if (this.activity.altitudeDifferencesUphillDefined) 
            {
                if (this.activity.averageAltitudeDefined) 
                {
                    loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                    loc1.key = GROUP_ALTITUDE;
                    loc1.iconSource = frontend.Textures.hohenmeter;
                    loc1.iconText = backend.utils.DataUtils.altitudeLabel;
                    loc1.valueIconSource = frontend.Textures.averageiconmini;
                    loc1.setValue(this.activity.averageAltitude, backend.utils.DataUtils.altitudeConverter, backend.utils.DataUtils.altitudeFormatter);
                    loc1.unit = backend.utils.DataUtils.unitStringAltitude;
                    this.pushLine(loc1, arg1);
                }
                if (!loc1) 
                {
                    loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                    loc1.key = GROUP_ALTITUDE;
                    loc1.iconSource = frontend.Textures.hohenmeter;
                    loc1.iconText = backend.utils.DataUtils.altitudeLabel;
                    this.pushLine(loc1, arg1);
                }
                loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                loc1.key = GROUP_ALTITUDE;
                loc1.iconSource = frontend.Textures.bergauf;
                loc1.setValue(this.activity.altitudeDifferencesUphill, backend.utils.DataUtils.altitudeConverter, backend.utils.DataUtils.altitudeFormatter);
                loc1.unit = backend.utils.DataUtils.unitStringAltitude;
                this.pushLine(loc1, arg1);
                if (this.activity.altitudeDifferencesDownhillDefined) 
                {
                    loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                    loc1.key = GROUP_ALTITUDE;
                    loc1.iconSource = frontend.Textures.bergab;
                    loc1.setValue(this.activity.altitudeDifferencesDownhill, backend.utils.DataUtils.altitudeConverter, backend.utils.DataUtils.altitudeFormatter);
                    loc1.unit = backend.utils.DataUtils.unitStringAltitude;
                    this.pushLine(loc1, arg1);
                }
                if (this.activity.minimumAltitudeDefined) 
                {
                    loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                    loc1.key = GROUP_ALTITUDE;
                    loc1.iconText = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_MIN");
                    loc1.setValue(this.activity.minimumAltitude, backend.utils.DataUtils.altitudeConverter, backend.utils.DataUtils.altitudeFormatter);
                    loc1.unit = backend.utils.DataUtils.unitStringAltitude;
                    this.pushLine(loc1, arg1);
                }
                if (this.activity.maximumAltitudeDefined) 
                {
                    loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                    loc1.key = GROUP_ALTITUDE;
                    loc1.iconText = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_MAX");
                    loc1.setValue(this.activity.maximumAltitude, backend.utils.DataUtils.altitudeConverter, backend.utils.DataUtils.altitudeFormatter);
                    loc1.unit = backend.utils.DataUtils.unitStringAltitude;
                    this.pushLine(loc1, arg1);
                }
            }
            return;
        }

        internal function addToDataProviderHeartrate(arg1:int):void
        {
            var loc1:*=null;
            if (this.activity.averageHeartrateDefined) 
            {
                loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                loc1.key = GROUP_HEARTRATE;
                loc1.iconSource = frontend.Textures.heartrateicon;
                loc1.iconText = backend.utils.DataUtils.heartrateLabel;
                loc1.valueIconSource = frontend.Textures.averageiconmini;
                loc1.setValue(this.activity.averageHeartrate, null, backend.utils.DataUtils.heartrateFormatter);
                loc1.unit = backend.utils.DataUtils.unitStringHeartrate;
                this.pushLine(loc1, arg1);
                if (this.activity.averagePercentHRMaxDefined) 
                {
                    loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                    loc1.key = GROUP_HEARTRATE;
                    loc1.iconText = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_PERCENT_OF_HRMAX");
                    loc1.setValue(this.activity.averagePercentHRMax, null, backend.utils.DataUtils.heartrateFormatter);
                    loc1.unit = backend.utils.DataUtils.unitStringPercent;
                    this.pushLine(loc1, arg1);
                }
                if (this.activity.minimumHeartrateDefined) 
                {
                    loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                    loc1.key = GROUP_HEARTRATE;
                    loc1.iconText = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_MIN");
                    loc1.setValue(this.activity.minimumHeartrate, null, backend.utils.DataUtils.heartrateFormatter);
                    loc1.unit = backend.utils.DataUtils.unitStringHeartrate;
                    this.pushLine(loc1, arg1);
                }
                if (this.activity.maximumHeartrateDefined) 
                {
                    loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                    loc1.key = GROUP_HEARTRATE;
                    loc1.iconText = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_MAX");
                    loc1.setValue(this.activity.maximumHeartrate, null, backend.utils.DataUtils.heartrateFormatter);
                    loc1.unit = backend.utils.DataUtils.unitStringHeartrate;
                    this.pushLine(loc1, arg1);
                }
            }
            return;
        }

        internal function addToDataProviderCalories(arg1:int):void
        {
            var loc1:*=null;
            if (this.activity.caloriesDefined) 
            {
                loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                loc1.key = GROUP_KCAL;
                loc1.iconSource = frontend.Textures.kcal;
                loc1.iconText = backend.utils.DataUtils.caloriesLabel;
                loc1.setValue(this.activity.calories, null, backend.utils.DataUtils.caloriesFormatter);
                loc1.unit = backend.utils.DataUtils.unitStringCalories;
                this.pushLine(loc1, arg1);
            }
            return;
        }

        internal function addToDataProviderIncline(arg1:int):void
        {
            var loc1:*=null;
            if (this.activity.averageInclineUphillDefined) 
            {
                loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                loc1.key = GROUP_INCLINE;
                loc1.iconSource = frontend.Textures.bergaufab;
                loc1.iconText = backend.utils.DataUtils.inclineLabel;
                this.pushLine(loc1, arg1);
                loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                loc1.key = GROUP_INCLINE;
                loc1.iconSource = frontend.Textures.averageuphillsmall;
                loc1.setValue(this.activity.averageInclineUphill, null, backend.utils.DataUtils.inclineFormatter);
                loc1.unit = backend.utils.DataUtils.unitStringIncline;
                this.pushLine(loc1, arg1);
                loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                loc1.key = GROUP_INCLINE;
                loc1.iconSource = frontend.Textures.averagedownhillsmall;
                loc1.setValue(this.activity.averageInclineDownhill, null, backend.utils.DataUtils.inclineFormatter);
                loc1.unit = backend.utils.DataUtils.unitStringIncline;
                this.pushLine(loc1, arg1);
                if (this.activity.minimumInclineDefined) 
                {
                    loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                    loc1.key = GROUP_INCLINE;
                    loc1.iconText = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_MIN");
                    loc1.setValue(this.activity.minimumIncline, null, backend.utils.DataUtils.inclineFormatter);
                    loc1.unit = backend.utils.DataUtils.unitStringIncline;
                    this.pushLine(loc1, arg1);
                }
                if (this.activity.maximumInclineDefined) 
                {
                    loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                    loc1.key = GROUP_INCLINE;
                    loc1.iconText = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_MAX");
                    loc1.setValue(this.activity.maximumIncline, null, backend.utils.DataUtils.inclineFormatter);
                    loc1.unit = backend.utils.DataUtils.unitStringIncline;
                    this.pushLine(loc1, arg1);
                }
            }
            return;
        }

        internal function addToDataProviderRiseRate(arg1:int):void
        {
            var loc1:*=null;
            if (this.activity.averageRiseRateDefined) 
            {
                loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                loc1.key = GROUP_RISERATE;
                loc1.iconSource = frontend.Textures.bergaufab;
                loc1.iconText = backend.utils.DataUtils.riseRateLabel;
                loc1.valueIconSource = frontend.Textures.averageiconmini;
                this.pushLine(loc1, arg1);
                if (this.activity.averageRiseRateUphillDefined) 
                {
                    loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                    loc1.key = GROUP_RISERATE;
                    loc1.iconSource = frontend.Textures.averageuphillsmall;
                    loc1.setValue(this.activity.averageRiseRateUphill, backend.utils.DataUtils.altitudeConverter, backend.utils.DataUtils.altitudeFormatter);
                    loc1.unit = backend.utils.DataUtils.unitStringRiseRate;
                    this.pushLine(loc1, arg1);
                }
                if (this.activity.averageRiseRateDownhillDefined) 
                {
                    loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                    loc1.key = GROUP_RISERATE;
                    loc1.iconSource = frontend.Textures.averagedownhillsmall;
                    loc1.setValue(this.activity.averageRiseRateDownhill, backend.utils.DataUtils.altitudeConverter, backend.utils.DataUtils.altitudeFormatter);
                    loc1.unit = backend.utils.DataUtils.unitStringRiseRate;
                    this.pushLine(loc1, arg1);
                }
                if (this.activity.minimumRiseRateDefined) 
                {
                    loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                    loc1.key = GROUP_RISERATE;
                    loc1.iconText = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_MIN");
                    loc1.setValue(this.activity.minimumRiseRate, backend.utils.DataUtils.altitudeConverter, backend.utils.DataUtils.altitudeFormatter);
                    loc1.unit = backend.utils.DataUtils.unitStringRiseRate;
                    this.pushLine(loc1, arg1);
                }
                if (this.activity.maximumRiseRateDefined) 
                {
                    loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                    loc1.key = GROUP_RISERATE;
                    loc1.iconText = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_MAX");
                    loc1.setValue(this.activity.maximumRiseRate, backend.utils.DataUtils.altitudeConverter, backend.utils.DataUtils.altitudeFormatter);
                    loc1.unit = backend.utils.DataUtils.unitStringRiseRate;
                    this.pushLine(loc1, arg1);
                }
            }
            return;
        }

        internal function addToDataProviderCadence(arg1:int):void
        {
            var loc1:*=null;
            if (this.activity.averageCadenceDefined) 
            {
                loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                loc1.key = GROUP_CADENCE;
                loc1.iconSource = frontend.Textures.cadenceicon;
                loc1.iconText = backend.utils.DataUtils.cadenceLabel;
                loc1.valueIconSource = frontend.Textures.averageiconmini;
                loc1.setValue(this.activity.averageCadence, null, backend.utils.DataUtils.cadenceFormatter);
                loc1.unit = backend.utils.DataUtils.unitStringCadence;
                this.pushLine(loc1, arg1);
                if (this.activity.minimumCadenceDefined) 
                {
                    loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                    loc1.key = GROUP_CADENCE;
                    loc1.iconText = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_MIN");
                    loc1.setValue(this.activity.minimumCadence, null, backend.utils.DataUtils.cadenceFormatter);
                    loc1.unit = backend.utils.DataUtils.unitStringCadence;
                    this.pushLine(loc1, arg1);
                }
                if (this.activity.maximumCadenceDefined) 
                {
                    loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                    loc1.key = GROUP_CADENCE;
                    loc1.iconText = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_MAX");
                    loc1.setValue(this.activity.maximumCadence, null, backend.utils.DataUtils.cadenceFormatter);
                    loc1.unit = backend.utils.DataUtils.unitStringCadence;
                    this.pushLine(loc1, arg1);
                }
            }
            return;
        }

        internal function addToDataProviderExpansion(arg1:int):void
        {
            var loc1:*=null;
            if (this.activity.averageExpansionDefined) 
            {
                loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                loc1.key = GROUP_EXPANSION;
                loc1.iconSource = frontend.Textures.cadenceicon;
                loc1.iconText = backend.utils.DataUtils.expansionLabel;
                loc1.valueIconSource = frontend.Textures.averageiconmini;
                loc1.setValue(this.activity.averageExpansion, null, backend.utils.DataUtils.expansionFormatter);
                loc1.unit = backend.utils.DataUtils.unitStringExpansion;
                this.pushLine(loc1, arg1);
                if (this.activity.averageExpansionUphillDefined) 
                {
                    loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                    loc1.key = GROUP_EXPANSION;
                    loc1.iconSource = frontend.Textures.averageuphillsmall;
                    loc1.setValue(this.activity.averageExpansionUphill, null, backend.utils.DataUtils.expansionFormatter);
                    loc1.unit = backend.utils.DataUtils.unitStringExpansion;
                    this.pushLine(loc1, arg1);
                }
            }
            return;
        }

        internal function addToDataProviderPower(arg1:int):void
        {
            var loc1:*=null;
            if (this.activity.averagePowerDefined || this.activity.maximumPowerDefined) 
            {
                loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                loc1.key = GROUP_POWER;
                loc1.iconSource = frontend.Textures.powericon;
                if (this.activity.averagePowerDefined) 
                {
                    loc1.iconText = backend.utils.DataUtils.powerLabel;
                    loc1.valueIconSource = frontend.Textures.averageiconmini;
                    loc1.setValue(this.activity.averagePower, null, backend.utils.DataUtils.powerFormatter);
                    loc1.unit = backend.utils.DataUtils.unitStringPower;
                }
                this.pushLine(loc1, arg1);
                if (this.activity.averagePowerWattPerKGDefined) 
                {
                    loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                    loc1.key = GROUP_POWER;
                    loc1.iconText = backend.utils.DataUtils.powerPerKGLabel;
                    loc1.valueIconSource = frontend.Textures.averageiconmini;
                    loc1.setValue(this.activity.averagePowerWattPerKG, backend.utils.DataUtils.powerPerKGConverter, backend.utils.DataUtils.powerPerKGFormatter);
                    loc1.unit = backend.utils.DataUtils.unitStringPowerPerKg;
                    this.pushLine(loc1, arg1);
                }
                if (this.activity.workInKJDefined) 
                {
                    loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                    loc1.key = GROUP_POWER;
                    loc1.iconText = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_WORK_PER_KJ");
                    loc1.setValue(this.activity.workInKJ, null, backend.utils.DataUtils.powerFormatter);
                    loc1.unit = backend.utils.DataUtils.unitStringKj;
                    this.pushLine(loc1, arg1);
                }
                if (this.activity.minimumPowerDefined) 
                {
                    loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                    loc1.key = GROUP_POWER;
                    loc1.iconText = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_MIN");
                    loc1.setValue(this.activity.minimumPower, backend.utils.DataUtils.powerPerKGConverter, backend.utils.DataUtils.powerPerKGFormatter);
                    loc1.unit = backend.utils.DataUtils.unitStringPowerPerKg;
                    this.pushLine(loc1, arg1);
                }
                if (this.activity.maximumPowerDefined) 
                {
                    loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                    loc1.key = GROUP_POWER;
                    loc1.iconText = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_MAX");
                    loc1.setValue(this.activity.maximumPower, backend.utils.DataUtils.powerPerKGConverter, backend.utils.DataUtils.powerPerKGFormatter);
                    loc1.unit = backend.utils.DataUtils.unitStringPowerPerKg;
                    this.pushLine(loc1, arg1);
                }
            }
            return;
        }

        internal function addToDataProviderDistancePlusMinus(arg1:int):void
        {
            var loc1:*=null;
            if (this.activity.distancePlusDefined || this.activity.distanceMinusDefined) 
            {
                loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                loc1.key = GROUP_DISTANCEPLUSMINUS;
                loc1.iconSource = frontend.Textures.strecke;
                loc1.iconText = backend.utils.DataUtils.distancePlusMinusLabel;
                this.pushLine(loc1, arg1);
                if (this.activity.distancePlusDefined) 
                {
                    loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                    loc1.key = GROUP_DISTANCEPLUSMINUS;
                    loc1.iconText = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_DISTANCE_UP");
                    loc1.setValue(this.activity.distancePlus, backend.utils.DataUtils.distanceConverter, backend.utils.DataUtils.distanceFormatter);
                    loc1.unit = backend.utils.DataUtils.unitStringDistance;
                    this.pushLine(loc1, arg1);
                }
                if (this.activity.distanceMinusDefined) 
                {
                    loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                    loc1.key = GROUP_DISTANCEPLUSMINUS;
                    loc1.iconText = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_DISTANCE_DOWN");
                    loc1.setValue(this.activity.distanceMinus, backend.utils.DataUtils.distanceConverter, backend.utils.DataUtils.distanceFormatter);
                    loc1.unit = backend.utils.DataUtils.unitStringDistance;
                    this.pushLine(loc1, arg1);
                }
            }
            return;
        }

        internal function addToDataProviderTemperature(arg1:int):void
        {
            var loc1:*=null;
            if (this.activity.averageTemperatureDefined || this.activity.minimumTemperatureDefined || this.activity.maximumTemperatureDefined) 
            {
                loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                loc1.key = GROUP_TEMPERATURE;
                loc1.iconSource = frontend.Textures.temperatureicon;
                loc1.iconText = backend.utils.DataUtils.temperatureLabel;
                if (this.activity.averageTemperatureDefined) 
                {
                    loc1.valueIconSource = frontend.Textures.averageiconmini;
                    loc1.setValue(this.activity.averageTemperature, backend.utils.DataUtils.temperatureConverter, backend.utils.DataUtils.temperatureFormatter);
                    loc1.unit = backend.utils.DataUtils.unitStringTemperature;
                }
                this.pushLine(loc1, arg1);
                if (this.activity.minimumTemperatureDefined) 
                {
                    loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                    loc1.key = GROUP_TEMPERATURE;
                    loc1.iconText = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_MIN");
                    loc1.setValue(this.activity.minimumTemperature, backend.utils.DataUtils.temperatureConverter, backend.utils.DataUtils.temperatureFormatter);
                    loc1.unit = backend.utils.DataUtils.unitStringTemperature;
                    this.pushLine(loc1, arg1);
                }
                if (this.activity.maximumTemperatureDefined) 
                {
                    loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                    loc1.key = GROUP_TEMPERATURE;
                    loc1.iconText = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_MAX");
                    loc1.setValue(this.activity.maximumTemperature, backend.utils.DataUtils.temperatureConverter, backend.utils.DataUtils.temperatureFormatter);
                    loc1.unit = backend.utils.DataUtils.unitStringTemperature;
                    this.pushLine(loc1, arg1);
                }
            }
            return;
        }

        internal function addToDataProviderBest5K(arg1:int):void
        {
            var loc1:*=null;
            var loc2:*=false;
            if (this.activity.best5KTimeDefined) 
            {
                loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                loc1.key = GROUP_BEST_5K;
                if (!loc2) 
                {
                    loc1.iconSource = frontend.Textures.iconstarblacksmall;
                    loc2 = true;
                }
                loc1.iconText = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_BEST_5K_TIME");
                loc1.setValue(this.activity.best5KTime, null, backend.utils.DataUtils.timeFormatter);
                loc1.unit = backend.utils.DataUtils.unitStringTimeHours;
                this.pushLine(loc1, arg1);
            }
            if (this.activity.best20minPowerDefined) 
            {
                loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                loc1.key = GROUP_BEST_5K;
                if (!loc2) 
                {
                    loc1.iconSource = frontend.Textures.iconstarblacksmall;
                    loc2 = true;
                }
                loc1.iconText = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_BEST_20MIN_POWER");
                loc1.setValue(this.activity.best20minPower, null, backend.utils.DataUtils.powerFormatter);
                loc1.unit = backend.utils.DataUtils.unitStringPower;
                this.pushLine(loc1, arg1);
            }
            return;
        }

        internal function addToDataProviderNP(arg1:int):void
        {
            var loc1:*=null;
            if (this.activity.powerNPDefined) 
            {
                loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                loc1.key = GROUP_NP;
                loc1.iconSource = frontend.Textures.powericon;
                loc1.iconText = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_NP_SHORT");
                loc1.setValue(this.activity.powerNP, null, backend.utils.DataUtils.powerFormatter);
                loc1.unit = backend.utils.DataUtils.unitStringPower;
                this.pushLine(loc1, arg1);
            }
            if (this.activity.powerIFDefined) 
            {
                loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                loc1.key = GROUP_NP;
                loc1.iconText = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_IF_SHORT");
                loc1.setValue(this.activity.powerIF, null, backend.utils.DataUtils.intensityFactorFormatter);
                loc1.unit = "";
                this.pushLine(loc1, arg1);
            }
            if (this.activity.powerTSSDefined) 
            {
                loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                loc1.key = GROUP_NP;
                loc1.iconText = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_TSS_SHORT");
                loc1.setValue(this.activity.powerTSS, null, backend.utils.DataUtils.tssFormatter);
                loc1.unit = "";
                this.pushLine(loc1, arg1);
            }
            return;
        }

        internal function addToDataProviderBalance(arg1:int):void
        {
            var loc1:*=null;
            if (this.activity.averageBalanceLeftDefined && this.activity.averageBalanceRightDefined) 
            {
                loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                loc1.key = GROUP_BALANCE;
                loc1.iconSource = frontend.Textures.cadenceicon;
                loc1.iconText = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_BALANCE");
                loc1.value = backend.utils.DataUtils.percentFormatter.format(this.activity.averageBalanceLeft) + " / " + backend.utils.DataUtils.percentFormatter.format(this.activity.averageBalanceRight);
                loc1.unit = backend.utils.DataUtils.unitStringPercent;
                this.pushLine(loc1, arg1);
            }
            if (this.activity.pedalSmoothLeftDefined && this.activity.pedalSmoothRightDefined) 
            {
                loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                loc1.key = GROUP_BALANCE;
                loc1.iconText = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_PEDAL_SMOOTHNESS");
                loc1.value = this.activity.pedalSmoothLeft + " / " + this.activity.pedalSmoothRight;
                loc1.unit = "";
                this.pushLine(loc1, arg1);
            }
            if (this.activity.torqueEffectLeftDefined && this.activity.torqueEffectRightDefined) 
            {
                loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                loc1.key = GROUP_BALANCE;
                loc1.iconText = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_TORQUE_EFFECT");
                loc1.value = this.activity.torqueEffectLeft + " / " + this.activity.torqueEffectRight;
                loc1.unit = "";
                this.pushLine(loc1, arg1);
            }
            return;
        }

        internal function addToDataProviderPedalingTime(arg1:int):void
        {
            var loc1:*=null;
            if (this.activity.pedalingTimeDefined) 
            {
                loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                loc1.key = GROUP_PEDALING_TIME;
                loc1.iconSource = frontend.Textures.cadenceicon;
                loc1.iconText = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_PEDALING_TIME");
                loc1.setValue(this.activity.pedalingTime, null, backend.utils.DataUtils.timeFormatter);
                loc1.unit = backend.utils.DataUtils.unitStringTimeHours;
                this.pushLine(loc1, arg1);
            }
            if (this.activity.pedalingIndexDefined) 
            {
                loc1 = new frontend.screen.activities.tabs.values.list.ActivityValueDataProviderObject();
                loc1.key = GROUP_PEDALING_TIME;
                loc1.iconText = utils.LanguageManager.getString("ACTIVIY_TAB_VALUES_PEDALING_INDEX");
                loc1.setValue(this.activity.pedalingIndex, null, backend.utils.DataUtils.percentFormatter);
                loc1.unit = backend.utils.DataUtils.unitStringPercent;
                this.pushLine(loc1, arg1);
            }
            return;
        }

        internal function _ActivityValuesTabView_CustomGroupedList1_i():frontend.components.list.CustomGroupedList
        {
            var loc1:*=new frontend.components.list.CustomGroupedList();
            loc1.clipContent = false;
            loc1.footerField = "footer";
            loc1.headerField = "header";
            loc1.stickyHeader = true;
            loc1.useVirtualLayout = true;
            loc1.id = "groupedList";
            this.groupedList = loc1;
            feathers.binding.BindingManager.executeBindings(this, "groupedList", this.groupedList);
            return loc1;
        }

        public function ___ActivityValuesTabView_TabLayoutGroup1_addedToStage(arg1:starling.events.Event):void
        {
            this.addedToStageHandler(arg1);
            return;
        }

        internal function _ActivityValuesTabView_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.values1icon;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.icon")
            result[1] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ACTIVITIES.TABS.VALUES.TITLE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.label")
            result[2] = new feathers.binding.Binding(this, function ():feathers.data.HierarchicalCollection
            {
                return dataProvider;
            }, null, "groupedList.dataProvider")
            result[3] = new feathers.binding.Binding(this, function ():Class
            {
                return frontend.screen.activities.tabs.values.list.ActivityValueListFooterItemRenderer;
            }, null, "groupedList.footerRendererType")
            result[4] = new feathers.binding.Binding(this, function ():Class
            {
                return frontend.screen.activities.tabs.values.list.ActivityValueListHeaderItemRenderer;
            }, null, "groupedList.headerRendererType")
            result[5] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight - frontend.components.tab.TabContainer.TAB_HEIGHT - frontend.screen.activities.ActivityView.SPORT_ROW_HEIGHT;
            }, null, "groupedList.height")
            result[6] = new feathers.binding.Binding(this, function ():Class
            {
                return frontend.screen.activities.tabs.values.list.ActivityValueListItemRenderer;
            }, null, "groupedList.itemRendererType")
            result[7] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "groupedList.width")
            return result;
        }

        internal static const GROUP_ALTITUDE:String="altitude";

        internal static const GROUP_BALANCE:String="balance";

        internal static const GROUP_BEST_5K:String="best5K";

        internal static const GROUP_CADENCE:String="cadence";

        internal static const GROUP_DISTANCE:String="distance";

        internal static const GROUP_DISTANCEPLUSMINUS:String="distanceplusminus";

        internal static const GROUP_EXPANSION:String="expansion";

        internal static const GROUP_FUELECONOMY:String="fueleconomy";

        internal static const GROUP_HEARTRATE:String="heartrate";

        internal static const GROUP_INCLINE:String="incline";

        internal static const GROUP_KCAL:String="kcal";

        internal static const GROUP_NP:String="np";

        internal static const GROUP_PEDALING_TIME:String="pedalingTime";

        internal static const GROUP_POWER:String="power";

        internal static const GROUP_RISERATE:String="riserate";

        internal static const GROUP_SPEED:String="speed";

        internal static const GROUP_TEMPERATURE:String="temperature";

        internal static const GROUP_TRAININGTIME:String="trainingtime";

        internal static const GROUP_TRIPSECTION:String="tripsection";

        internal var _1258726684groupedList:frontend.components.list.CustomGroupedList;

        internal var _activity:core.activities.Activity;

        public var contentLoadedCallback:Function;

        internal var _655379712contentHeight:Number;

        internal var _339742651dataProvider:feathers.data.HierarchicalCollection;

        internal var dictHCObjects:Array;

        internal var speedBasedObjects:Array;

        mx_internal var _bindingsBeginWithWord:Object;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


