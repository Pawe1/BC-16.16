//package charts
//  class ColumnChartItem
package frontend.components.charts 
{
    public class ColumnChartItem extends Object
    {
        public function ColumnChartItem()
        {
            this.activityGUIDs = [];
            this.yValues = [];
            this.yValuesFormat = [];
            super();
            return;
        }

        public var activityGUIDs:Array;

        public var color:uint=13046322;

        public var date:Date;

        public var label:String="";

        public var sortField:String="";

        public var xValue:String="";

        public var ySum:Number=0;

        public var yValues:Array;

        public var yValuesFormat:Array;
    }
}


//  class ColumnChartItemProps
package frontend.components.charts 
{
    public class ColumnChartItemProps extends Object
    {
        public function ColumnChartItemProps()
        {
            super();
            return;
        }

        public static const SORT_FIELD_PROPERTY:String="sportsIndex";

        public var color:uint;

        public var sportId:int;

        public var sportsIndex:int;

        public var value:Number;
    }
}


//  class ColumnChartList
package frontend.components.charts 
{
    import __AS3__.vec.*;
    import core.general.*;
    import debug.*;
    import feathers.controls.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import flash.events.*;
    import flash.utils.*;
    import frontend.screen.statistic.tabs.*;
    import handler.*;
    import starling.animation.*;
    import starling.core.*;
    import starling.display.*;
    import starling.events.*;
    import utils.sort.*;
    
    public class ColumnChartList extends feathers.controls.LayoutGroup
    {
        public function ColumnChartList()
        {
            this.bgGroup = new feathers.controls.LayoutGroup();
            this.labelGroup = new feathers.controls.LayoutGroup();
            this.shapesGroup = new feathers.controls.LayoutGroup();
            super();
            layoutData = new feathers.layout.AnchorLayoutData(HEADER_HEIGHT);
            addEventListener(starling.events.Event.ADDED_TO_STAGE, this.onAddedToStage);
            addEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
            return;
        }

        internal function drawBackground():void
        {
            var loc1:*=0;
            var loc2:*=null;
            debug.Debug.debug("drawBackground - " + this.item.title + ", " + this.item.type);
            if (this.rtBg) 
            {
                this.rtBg.clear();
            }
            else 
            {
                this.rtBg = new frontend.components.charts.CustomRenderTexture(width, height);
            }
            loc2 = new starling.display.Quad(width, FOOTER_LINES_HEIGHT, core.general.Colors.DARKGREY);
            loc2.x = 0;
            loc2.y = int(this._columnMaxHeight);
            this.rtBg.draw(loc2, null, 1, 3);
            loc1 = 1;
            while (loc1 <= this._gridLines) 
            {
                loc2 = new starling.display.Quad(width, COLUMN_BOTTOM_LINE_HEIGHT, core.general.Colors.LIGHTGREY);
                loc2.x = 0;
                loc2.y = int(this._columnMaxHeight - loc1 * this._gridGap);
                this.rtBg.draw(loc2, null, 1, 3);
                loc2.dispose();
                ++loc1;
            }
            this.disposeChildren(this.bgGroup);
            this.bgGroup.addChild(new starling.display.Image(this.rtBg));
            return;
        }

        internal function validateShapes():void
        {
            var loc1:*=0;
            var loc3:*=null;
            var loc4:*=null;
            var loc6:*=0;
            var loc7:*=0;
            var loc8:*=null;
            var loc9:*=NaN;
            var loc10:*=NaN;
            var loc11:*=null;
            var loc12:*=NaN;
            var loc13:*=NaN;
            var loc14:*=null;
            var loc16:*=false;
            var loc18:*=false;
            var loc19:*=null;
            debug.Debug.debug("validateShapes - " + this.item.title + ", " + this.item.type);
            var loc2:*=this.item.dataProvider.length;
            var loc5:*=0;
            var loc15:*=TWEEN_DURATION > 0;
            var loc17:*=0;
            this.shapes = new Vector.<Array>();
            if (this.rtLabels) 
            {
                this.rtLabels.clear();
            }
            else 
            {
                this.rtLabels = new frontend.components.charts.CustomRenderTexture(width, height);
            }
            loc1 = 0;
            while (loc1 < loc2) 
            {
                loc5 = loc1 * (this._columnWidth + COLUMN_H_GAP);
                loc3 = this.item.dataProvider.getItemAt(loc1) as frontend.components.charts.ColumnChartItem;
                loc7 = loc3.yValues.length;
                loc9 = this._columnMaxHeight;
                loc10 = this._columnPaddingSide;
                loc3.yValues.sort(sortOnSortField);
                loc16 = this.dropLabels ? (loc1 + 1) % (DROP_LABELS_MINIMUM + 1) == 0 : true;
                if (loc7 == 0 || this.item.hidden) 
                {
                    loc4 = new frontend.screen.statistic.tabs.CustomShape();
                    loc4.showLabel = loc16;
                    loc4.color = 16777215;
                    loc4.xFrom = loc10;
                    loc4.yFrom = this._columnMaxHeight;
                    loc4.widthFrom = this._columnQuadWidth;
                    loc4.heightFrom = 0.1;
                    loc4.label = loc3.label;
                    loc4.heightTo = 0.1;
                    loc4.yTo = this._columnMaxHeight;
                    this.shapes.push([loc4]);
                }
                else 
                {
                    loc19 = [];
                    loc6 = 0;
                    while (loc6 < loc7) 
                    {
                        loc14 = loc3.yValues[loc6] as frontend.components.charts.ColumnChartItemProps;
                        if (loc14.value != 0) 
                        {
                            loc12 = loc14.value * this._columnQuadHeightFactor;
                            loc13 = loc9 - loc12;
                            loc4 = new frontend.screen.statistic.tabs.CustomShape();
                            loc4.chartItem = loc3;
                            loc4.showLabel = loc16;
                            loc4.color = loc14.color;
                            loc4.xFrom = loc10;
                            loc4.yFrom = this._columnMaxHeight;
                            loc4.widthFrom = this._columnQuadWidth;
                            loc4.heightFrom = 0.1;
                            loc4.label = loc3.label;
                            loc4.heightTo = loc12;
                            loc4.yTo = loc13;
                            loc19.push(loc4);
                            loc9 = loc13;
                        }
                        ++loc6;
                    }
                    this.shapes.push(loc19);
                }
                loc18 = true;
                if (this.dropLabels) 
                {
                    loc18 = (loc1 + 1) % (DROP_LABELS_MINIMUM + 1) == 0;
                }
                if (loc18) 
                {
                    loc11 = new feathers.controls.Label();
                    loc11.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_SMALLLISTLABEL;
                    loc11.text = loc3.label;
                    loc11.wordWrap = false;
                    loc11.validate();
                    loc11.x = loc5 + (this._columnWidth - loc11.width >> 1);
                    loc11.y = this._columnMaxHeight + COLUMN_BOTTOM_LINE_HEIGHT + (FOOTER_HEIGHT - loc11.height >> 1);
                    if (loc11.x < 0 && this.dropLabels) 
                    {
                        loc11.x = 0;
                    }
                    if (loc1 == (loc2 - 1) && this.dropLabels) 
                    {
                        loc11.x = loc5 + this._columnWidth - loc11.width;
                    }
                    if (loc11.x > loc17) 
                    {
                        this.rtLabels.draw(loc11, null, 1, 2);
                        loc17 = loc11.x + loc11.width;
                        loc11.dispose();
                    }
                }
                ++loc1;
            }
            this.disposeChildren(this.labelGroup);
            this.labelGroup.addChild(new starling.display.Image(this.rtLabels));
            return;
        }

        public function validateItem():void
        {
            this._columnWidth = width / this.item.dataProvider.length - COLUMN_H_GAP;
            this._columnMaxHeight = this.parentHeight - HEADER_HEIGHT - FOOTER_HEIGHT;
            this._columnPaddingSide = COLUMN_PADDING >> 1;
            this._columnQuadWidth = this._columnWidth - COLUMN_PADDING;
            this._columnQuadHeightFactor = this._columnMaxHeight / this.item.yMax;
            this._gridLines = Math.floor(this.item.yMax / this.item.yInterval);
            this._gridGap = this._columnMaxHeight / this._gridLines;
            this.drawBackground();
            this.validateShapes();
            this.drawWithQuads();
            return;
        }

        internal function onRemovedFromStage(arg1:starling.events.Event):void
        {
            if (this.item) 
            {
                this.item.dataChanged = true;
            }
            if (this.shapesGroup) 
            {
                this.shapesGroup.removeEventListener(starling.events.TouchEvent.TOUCH, this.onShapesGroupTouch);
            }
            return;
        }

        internal function disposeChildren(arg1:feathers.controls.LayoutGroup):void
        {
            var loc1:*=0;
            var loc3:*=null;
            debug.Debug.debug("disposeChilden");
            var loc2:*=arg1.numChildren;
            loc1 = 0;
            while (loc1 < loc2) 
            {
                loc3 = arg1.getChildAt(loc1);
                loc3.dispose();
                ++loc1;
            }
            arg1.removeChildren();
            return;
        }

        internal function onShapesGroupTouch(arg1:starling.events.TouchEvent):void
        {
            var loc2:*=null;
            var loc3:*=NaN;
            var loc4:*=NaN;
            var loc5:*=null;
            var loc6:*=null;
            var loc7:*=null;
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            var loc1:*=arg1.target as starling.display.Image;
            if (loc1) 
            {
                loc2 = arg1.getTouch(loc1);
                loc3 = loc2.globalX;
                loc4 = loc2.globalY;
                var loc8:*=0;
                var loc9:*=this.calloutInfo;
                for (loc5 in loc9) 
                {
                    loc6 = this.calloutInfo[loc5];
                    if (!(loc3 >= int(loc5) && loc3 <= int(loc5) + this._columnWidth)) 
                    {
                        continue;
                    }
                    debug.Debug.debug("treffer");
                    this._calloutAnchor.x = int(loc5) + this._columnWidth / 2;
                    this._calloutAnchor.y = this._columnMaxHeight - this.calloutInfoY[loc5];
                    loc7 = new frontend.components.charts.StatisticColumnChartCallout();
                    loc7.applyitem(loc6);
                    feathers.controls.Callout.show(loc7, this._calloutAnchor, null, false, this.calloutFactory);
                    return;
                }
            }
            return;
        }

        internal function calloutFactory():feathers.controls.Callout
        {
            var loc1:*=new feathers.controls.Callout();
            loc1.closeOnTouchBeganOutside = true;
            return loc1;
        }

        internal function onAddedToStage(arg1:starling.events.Event):void
        {
            height = this.parentHeight;
            width = SIGMALink.appWidth;
            COLUMN_H_GAP = 0.5 * SIGMALink.scaleFactor;
            this.bgGroup.width = width;
            this.bgGroup.height = height;
            addChild(this.bgGroup);
            this.labelGroup.width = width;
            this.labelGroup.height = height;
            addChild(this.labelGroup);
            this.shapesGroup.width = width;
            this.shapesGroup.height = height;
            this.shapesGroup.addEventListener(starling.events.TouchEvent.TOUCH, this.onShapesGroupTouch);
            addChild(this.shapesGroup);
            this._calloutAnchor = new feathers.controls.LayoutGroup();
            this._calloutAnchor.width = 1;
            this._calloutAnchor.height = 1;
            addChild(this._calloutAnchor);
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            removeEventListener(starling.events.Event.ADDED_TO_STAGE, this.onAddedToStage);
            removeEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
            if (this.labelGroup) 
            {
                this.disposeChildren(this.labelGroup);
            }
            if (this.bgGroup) 
            {
                this.disposeChildren(this.bgGroup);
            }
            if (this.shapesGroup) 
            {
                this.shapesGroup.removeEventListener(starling.events.TouchEvent.TOUCH, this.onShapesGroupTouch);
                this.disposeChildren(this.shapesGroup);
            }
            if (this.rtBg) 
            {
                this.rtBg.dispose();
                this.rtBg = null;
            }
            if (this.rtLabels) 
            {
                this.rtLabels.dispose();
                this.rtLabels = null;
            }
            if (this.rtShapes) 
            {
                this.rtShapes.dispose();
                this.rtShapes = null;
            }
            if (this._calloutAnchor) 
            {
                this.disposeChildren(this._calloutAnchor);
            }
            removeChildren();
            return;
        }

        internal static function sortOnSortField(arg1:frontend.components.charts.ColumnChartItemProps, arg2:frontend.components.charts.ColumnChartItemProps):Number
        {
            return utils.sort.SortUtil.sortOnString(arg1, arg2, frontend.components.charts.ColumnChartItemProps.SORT_FIELD_PROPERTY, true);
        }

        
        {
            HEADER_HEIGHT = 62 * SIGMALink.scaleFactor;
            COLUMN_H_GAP = 1 * SIGMALink.scaleFactor;
            COLUMN_PADDING = 6 * SIGMALink.scaleFactor;
        }

        public function scaleOut(arg1:flash.events.TimerEvent=null):void
        {
            debug.Debug.debug("remove - " + this.item.title + ", " + this.item.type);
            this.disposeChildren(this.shapesGroup);
            return;
        }

        public function scaleIn(arg1:flash.events.TimerEvent=null):void
        {
            var p_event:flash.events.TimerEvent=null;
            var targetHeight:Number;
            var ctween:starling.animation.Tween;

            var loc1:*;
            ctween = null;
            p_event = arg1;
            if (this._img) 
            {
                this.disposeChildren(this.shapesGroup);
                this.drawWithQuads();
            }
            if (!this._img) 
            {
                this.disposeChildren(this.shapesGroup);
                return;
            }
            debug.Debug.debug("scaleIn - " + this.item.title + ", " + this.item.type);
            this.disposeChildren(this.shapesGroup);
            this.shapesGroup.addChild(this._img);
            targetHeight = this._img.height;
            this._img.height = 0;
            this._img.y = this._columnMaxHeight;
            ctween = new starling.animation.Tween(this._img, 0.8, starling.animation.Transitions.EASE_IN_OUT);
            ctween.animate("height", targetHeight);
            ctween.animate("y", 0);
            ctween.onComplete = function ():void
            {
                starling.core.Starling.juggler.remove(ctween);
                return;
            }
            starling.core.Starling.juggler.add(ctween);
            return;
        }

        internal function drawWithQuads():void
        {
            var loc1:*=null;
            var loc3:*=null;
            var loc6:*=NaN;
            var loc7:*=NaN;
            var loc8:*=NaN;
            var loc9:*=NaN;
            var loc10:*=null;
            debug.Debug.debug("drawWithQuads - " + this.item.title + ", " + this.item.type);
            var loc2:*=this.shapes.length;
            var loc4:*=0;
            var loc5:*=0;
            var loc11:*=0;
            if (this.rtShapes) 
            {
                this.rtShapes.clear();
            }
            else 
            {
                this.rtShapes = new frontend.components.charts.CustomRenderTexture(width, height);
            }
            this.calloutInfo = new flash.utils.Dictionary();
            this.calloutInfoY = new flash.utils.Dictionary();
            loc4 = 0;
            while (loc4 < loc2) 
            {
                loc3 = this.shapes[loc4];
                loc5 = 0;
                while (loc5 < loc3.length) 
                {
                    loc1 = loc3[loc5] as frontend.screen.statistic.tabs.CustomShape;
                    if (loc1.heightTo > 0.1) 
                    {
                        loc6 = loc4 * this._columnWidth + loc1.xFrom;
                        loc7 = loc1.yTo;
                        loc8 = loc1.widthFrom;
                        loc9 = loc1.heightTo;
                        this.calloutInfo[loc6] = loc1.chartItem;
                        if (!this.calloutInfoY[loc6]) 
                        {
                            this.calloutInfoY[loc6] = 0;
                        }
                        this.calloutInfoY[loc6] = Math.max(loc1.yFrom - loc1.yTo, this.calloutInfoY[loc6]);
                        loc10 = new starling.display.Quad(loc8, loc9, loc1.color);
                        loc10.x = loc6;
                        loc10.y = loc7;
                        this.rtShapes.draw(loc10, null, 1, 3);
                        loc10.dispose();
                        ++loc11;
                    }
                    ++loc5;
                }
                ++loc4;
            }
            this._img = loc11 > 0 ? new starling.display.Image(this.rtShapes) : null;
            return;
        }

        internal static const FOOTER_LINES_HEIGHT:Number=3 * SIGMALink.scaleFactor;

        internal static const COLUMN_BOTTOM_LINE_HEIGHT:Number=2 * SIGMALink.scaleFactor;

        internal static const DP_CHANGED:String="dpChangedEvent";

        internal static const DROP_LABELS_MINIMUM:int=3;

        internal static const FOOTER_HEIGHT:Number=48 * SIGMALink.scaleFactor;

        internal static const FOOTER_LINES_LABEL_PADDING:Number=6 * SIGMALink.scaleFactor;

        internal static const LANDSCAPE_COLUMN_COUNT:int=16;

        internal static const TWEEN_DURATION:Number=0.75;

        public var bgGroup:feathers.controls.LayoutGroup;

        public var dropLabels:Boolean=false;

        public var item:frontend.screen.statistic.tabs.StatisticTabItem;

        public var labelGroup:feathers.controls.LayoutGroup;

        public var shapes:__AS3__.vec.Vector.<Array>;

        public var shapesGroup:feathers.controls.LayoutGroup;

        internal var _calloutAnchor:feathers.controls.LayoutGroup;

        internal var _columnMaxHeight:Number;

        internal var _gridGap:Number;

        internal var _columnWidth:Number;

        internal var _columnQuadWidth:Number;

        public static var HEADER_HEIGHT:Number;

        internal var rtShapes:frontend.components.charts.CustomRenderTexture;

        internal var _columnQuadHeightFactor:Number;

        internal static var COLUMN_PADDING:Number;

        internal var rtLabels:frontend.components.charts.CustomRenderTexture;

        internal var rtBg:frontend.components.charts.CustomRenderTexture;

        internal var calloutInfo:flash.utils.Dictionary;

        public var parentHeight:Number=0;

        internal var calloutInfoY:flash.utils.Dictionary;

        internal var _img:starling.display.Image;

        internal var _gridLines:int;

        internal var _columnPaddingSide:Number;

        internal static var COLUMN_H_GAP:Number;
    }
}


//  class CustomRenderTexture
package frontend.components.charts 
{
    import starling.textures.*;
    
    public class CustomRenderTexture extends starling.textures.RenderTexture
    {
        public function CustomRenderTexture(arg1:int, arg2:int, arg3:Boolean=true, arg4:Number=-1, arg5:String="bgra")
        {
            super(arg1, arg2, arg3, arg4, arg5);
            return;
        }
    }
}


//  class StatisticColumnChartCallout
package frontend.components.charts 
{
    import backend.utils.*;
    import configCache.*;
    import core.general.*;
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
    import frontend.components.*;
    import frontend.formatter.*;
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
    import utils.converter.*;
    import utils.interfaces.*;
    
    use namespace mx_internal;
    
    public class StatisticColumnChartCallout extends feathers.controls.LayoutGroup implements feathers.binding.IBindingClient
    {
        public function StatisticColumnChartCallout()
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
            bindings = this._StatisticColumnChartCallout_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_components_charts_StatisticColumnChartCalloutWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return StatisticColumnChartCallout[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.layout = this._StatisticColumnChartCallout_VerticalLayout1_c();
            this.mxmlContent = [this._StatisticColumnChartCallout_LayoutGroup2_i(), this._StatisticColumnChartCallout_LayoutGroup3_i(), this._StatisticColumnChartCallout_LayoutGroup4_i(), this._StatisticColumnChartCallout_LayoutGroup5_i()];
            this.addEventListener("initialize", this.___StatisticColumnChartCallout_LayoutGroup1_initialize);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        public function get titleLabel():feathers.controls.Label
        {
            return this._1791483012titleLabel;
        }

        public function set titleLabel(arg1:feathers.controls.Label):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1791483012titleLabel;
            if (loc1 !== arg1) 
            {
                this._1791483012titleLabel = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "titleLabel", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get calloutTitel():String
        {
            return this._47456054calloutTitel;
        }

        public function set calloutTitel(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._47456054calloutTitel;
            if (loc1 !== arg1) 
            {
                this._47456054calloutTitel = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "calloutTitel", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _calloutWidth():Number
        {
            return this._2053270187_calloutWidth;
        }

        internal function set _calloutWidth(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._2053270187_calloutWidth;
            if (loc1 !== arg1) 
            {
                this._2053270187_calloutWidth = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_calloutWidth", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function getDataTipLabel(arg1:frontend.components.charts.ColumnChartItem, arg2:String):String
        {
            var loc1:*="";
            if (arg1) 
            {
                var loc2:*=arg2;
                switch (loc2) 
                {
                    case statistic.Statistic.X_YEAR:
                    {
                        loc1 = arg1.date.fullYear.toString();
                        break;
                    }
                    case statistic.Statistic.X_MONTH:
                    {
                        loc1 = backend.utils.DataUtils.monthLabelsLong[arg1.date.month];
                        break;
                    }
                    case statistic.Statistic.X_WEEK:
                    {
                        loc1 = utils.LanguageManager.getString("WEEKS_SHORT") + " " + arg1.label;
                        break;
                    }
                }
            }
            return loc1;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            StatisticColumnChartCallout._watcherSetupUtil = arg1;
            return;
        }

        public function applyitem(arg1:frontend.components.charts.ColumnChartItem):void
        {
            var loc1:*=0;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=NaN;
            var loc7:*=null;
            var loc11:*=null;
            var loc12:*=0;
            var loc13:*=0;
            var loc14:*=null;
            var loc15:*=null;
            var loc16:*=null;
            var loc17:*=null;
            var loc18:*=null;
            var loc19:*=null;
            var loc20:*=NaN;
            var loc21:*=null;
            var loc22:*=null;
            this.calloutTitel = getDataTipLabel(arg1, configCache.ConfigCache.getInstance().getValue(configCache.ConfigCacheObject.STATISTIC_SELECTED_TAB, statistic.Statistic.X_WEEK));
            var loc2:*=statistic.Statistic.VALUES.length;
            var loc8:*=new feathers.layout.HorizontalLayout();
            loc8.verticalAlign = feathers.layout.VerticalAlign.MIDDLE;
            loc8.horizontalAlign = feathers.layout.HorizontalAlign.RIGHT;
            loc8.paddingLeft = 4 * SIGMALink.scaleFactor;
            loc8.paddingRight = 8 * SIGMALink.scaleFactor;
            loc8.gap = 4 * SIGMALink.scaleFactor;
            var loc9:*=0;
            var loc10:*=0;
            loc1 = 0;
            while (loc1 < loc2) 
            {
                loc11 = statistic.Statistic.VALUES[loc1];
                if (arg1.xValue.indexOf(loc11.value) != -1) 
                {
                    var loc23:*=loc11.value;
                    switch (loc23) 
                    {
                        case statistic.Statistic.TRAINING_TIME:
                        {
                            loc3 = " " + backend.utils.DataUtils.unitStringTimeHours;
                            loc4 = backend.utils.DataUtils.timeFormatterHHMM;
                            loc5 = null;
                            break;
                        }
                        case statistic.Statistic.DISTANCE:
                        {
                            loc3 = " " + backend.utils.DataUtils.unitStringDistance;
                            loc4 = backend.utils.DataUtils.distanceFormatter;
                            loc5 = backend.utils.DataUtils.distanceConverter;
                            break;
                        }
                        case statistic.Statistic.ALTITUDE_UPHILL:
                        case statistic.Statistic.ALTITUDE_DOWNHILL:
                        {
                            loc3 = " " + backend.utils.DataUtils.unitStringAltitude;
                            loc4 = backend.utils.DataUtils.altitudeFormatter;
                            loc5 = backend.utils.DataUtils.altitudeConverter;
                            break;
                        }
                        case statistic.Statistic.CALORIES:
                        {
                            loc3 = " " + backend.utils.DataUtils.unitStringCalories;
                            loc4 = backend.utils.DataUtils.caloriesFormatter;
                            loc5 = null;
                            break;
                        }
                        case statistic.Statistic.TRAININGS:
                        case statistic.Statistic.STEPS:
                        {
                            loc3 = "";
                            loc4 = null;
                            loc5 = null;
                            break;
                        }
                    }
                    loc13 = arg1.yValues.length;
                    loc14 = [];
                    loc12 = 0;
                    while (loc12 < loc13) 
                    {
                        loc15 = new feathers.controls.LayoutGroup();
                        loc15.layout = loc8;
                        this.list.addChild(loc15);
                        loc16 = new frontend.components.SportIcon();
                        loc16.sportId = (arg1.yValues[loc12] as frontend.components.charts.ColumnChartItemProps).sportId;
                        loc15.addChild(loc16);
                        loc16.validate();
                        loc17 = new feathers.controls.Label();
                        loc17.paddingLeft = 20 * SIGMALink.scaleFactor;
                        loc17.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
                        if (loc5) 
                        {
                            loc6 = loc5.convert((arg1.yValues[loc12] as frontend.components.charts.ColumnChartItemProps).value);
                        }
                        else 
                        {
                            loc6 = (arg1.yValues[loc12] as frontend.components.charts.ColumnChartItemProps).value;
                        }
                        if (loc4 is utils.interfaces.ICustomFormatter) 
                        {
                            loc7 = (loc4 as utils.interfaces.ICustomFormatter).format(loc6);
                        }
                        else if (loc4 is frontend.formatter.NumberFormatter) 
                        {
                            loc7 = (loc4 as frontend.formatter.NumberFormatter).format(loc6);
                        }
                        else 
                        {
                            loc7 = loc6.toString();
                        }
                        loc17.text = loc7;
                        loc15.addChild(loc17);
                        loc17.validate();
                        loc18 = new feathers.controls.Label();
                        loc18.text = loc3;
                        loc15.addChild(loc18);
                        loc18.validate();
                        loc10 = Math.max(loc17.width, loc10);
                        loc14.push(loc17);
                        loc9 = loc16.width + loc18.width;
                        ++loc12;
                    }
                    loc12 = 0;
                    while (loc12 < loc13) 
                    {
                        (loc14[loc12] as feathers.controls.Label).width = loc10;
                        ++loc12;
                    }
                    if (loc13 > 1) 
                    {
                        loc19 = new feathers.controls.Label();
                        loc19.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
                        loc20 = 0;
                        loc21 = "";
                        if (loc5) 
                        {
                            loc20 = loc5.convert(arg1.ySum);
                        }
                        else 
                        {
                            loc20 = arg1.ySum;
                        }
                        if (loc4 is utils.interfaces.ICustomFormatter) 
                        {
                            loc21 = (loc4 as utils.interfaces.ICustomFormatter).format(loc20);
                        }
                        else if (loc4 is frontend.formatter.NumberFormatter) 
                        {
                            loc21 = (loc4 as frontend.formatter.NumberFormatter).format(loc20);
                        }
                        else 
                        {
                            loc21 = loc20.toString();
                        }
                        loc19.text = loc21;
                        this.sum.layout = loc8;
                        this.sum.addChild(loc19);
                        loc22 = new feathers.controls.Label();
                        loc22.text = loc3;
                        this.sum.addChild(loc22);
                    }
                }
                ++loc1;
            }
            this.titleLabel.validate();
            this._calloutWidth = Math.max(this.titleLabel.width, loc10 + loc9 + 3 * loc8.gap + loc8.paddingLeft + loc8.paddingRight);
            return;
        }

        protected function onInit(arg1:starling.events.Event):void
        {
            width = this._calloutWidth;
            return;
        }

        internal function _StatisticColumnChartCallout_VerticalLayout1_c():feathers.layout.VerticalLayout
        {
            var loc1:*=new feathers.layout.VerticalLayout();
            return loc1;
        }

        internal function _StatisticColumnChartCallout_LayoutGroup2_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.mxmlContent = [this._StatisticColumnChartCallout_Label1_i()];
            loc1.id = "header";
            this.header = loc1;
            feathers.binding.BindingManager.executeBindings(this, "header", this.header);
            return loc1;
        }

        internal function _StatisticColumnChartCallout_Label1_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.id = "titleLabel";
            this.titleLabel = loc1;
            feathers.binding.BindingManager.executeBindings(this, "titleLabel", this.titleLabel);
            return loc1;
        }

        internal function _StatisticColumnChartCallout_LayoutGroup3_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._StatisticColumnChartCallout_VerticalLayout2_i();
            loc1.id = "list";
            this.list = loc1;
            feathers.binding.BindingManager.executeBindings(this, "list", this.list);
            return loc1;
        }

        internal function _StatisticColumnChartCallout_VerticalLayout2_i():feathers.layout.VerticalLayout
        {
            var loc1:*=new feathers.layout.VerticalLayout();
            this._StatisticColumnChartCallout_VerticalLayout2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_StatisticColumnChartCallout_VerticalLayout2", this._StatisticColumnChartCallout_VerticalLayout2);
            return loc1;
        }

        internal function _StatisticColumnChartCallout_LayoutGroup4_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.id = "_StatisticColumnChartCallout_LayoutGroup4";
            this._StatisticColumnChartCallout_LayoutGroup4 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_StatisticColumnChartCallout_LayoutGroup4", this._StatisticColumnChartCallout_LayoutGroup4);
            return loc1;
        }

        internal function _StatisticColumnChartCallout_LayoutGroup5_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.id = "sum";
            this.sum = loc1;
            feathers.binding.BindingManager.executeBindings(this, "sum", this.sum);
            return loc1;
        }

        public function ___StatisticColumnChartCallout_LayoutGroup1_initialize(arg1:starling.events.Event):void
        {
            this.onInit(arg1);
            return;
        }

        internal function _StatisticColumnChartCallout_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.RED);
            }, null, "header.backgroundSkin")
            result[1] = new feathers.binding.Binding(this, function ():Number
            {
                return _calloutWidth;
            }, null, "header.width")
            result[2] = new feathers.binding.Binding(this, function ():Number
            {
                return 8 * SIGMALink.scaleFactor;
            }, null, "titleLabel.padding")
            result[3] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_BIGLISTLABEL_WHITE;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "titleLabel.styleName")
            result[4] = new feathers.binding.Binding(this, null, null, "titleLabel.text", "calloutTitel");
            result[5] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            }, null, "list.backgroundSkin")
            result[6] = new feathers.binding.Binding(this, function ():Number
            {
                return _calloutWidth;
            }, null, "list.width")
            result[7] = new feathers.binding.Binding(this, function ():Number
            {
                return 4 * SIGMALink.scaleFactor;
            }, null, "_StatisticColumnChartCallout_VerticalLayout2.gap")
            result[8] = new feathers.binding.Binding(this, function ():Number
            {
                return 4 * SIGMALink.scaleFactor;
            }, null, "_StatisticColumnChartCallout_VerticalLayout2.padding")
            result[9] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            }, null, "_StatisticColumnChartCallout_LayoutGroup4.backgroundSkin")
            result[10] = new feathers.binding.Binding(this, function ():Number
            {
                return 1 * SIGMALink.scaleFactor;
            }, null, "_StatisticColumnChartCallout_LayoutGroup4.height")
            result[11] = new feathers.binding.Binding(this, function ():Number
            {
                return _calloutWidth;
            }, null, "_StatisticColumnChartCallout_LayoutGroup4.width")
            result[12] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            }, null, "sum.backgroundSkin")
            result[13] = new feathers.binding.Binding(this, function ():Number
            {
                return _calloutWidth;
            }, null, "sum.width")
            return result;
        }

        public function get header():feathers.controls.LayoutGroup
        {
            return this._1221270899header;
        }

        public function set header(arg1:feathers.controls.LayoutGroup):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1221270899header;
            if (loc1 !== arg1) 
            {
                this._1221270899header = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "header", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get list():feathers.controls.LayoutGroup
        {
            return this._3322014list;
        }

        public function set list(arg1:feathers.controls.LayoutGroup):void
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

        public function get sum():feathers.controls.LayoutGroup
        {
            return this._114251sum;
        }

        public function set sum(arg1:feathers.controls.LayoutGroup):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._114251sum;
            if (loc1 !== arg1) 
            {
                this._114251sum = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "sum", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public var _StatisticColumnChartCallout_LayoutGroup4:feathers.controls.LayoutGroup;

        public var _StatisticColumnChartCallout_VerticalLayout2:feathers.layout.VerticalLayout;

        internal var _1221270899header:feathers.controls.LayoutGroup;

        internal var _3322014list:feathers.controls.LayoutGroup;

        internal var _114251sum:feathers.controls.LayoutGroup;

        internal var _1791483012titleLabel:feathers.controls.Label;

        internal var _47456054calloutTitel:String;

        internal var _2053270187_calloutWidth:Number;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


