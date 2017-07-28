//class ActivityGraphComp
package frontend.screen.activities.component 
{
    import __AS3__.vec.*;
    import backend.utils.*;
    import core.activities.*;
    import core.general.*;
    import feathers.binding.*;
    import feathers.controls.*;
    import feathers.controls.text.*;
    import feathers.core.*;
    import feathers.events.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import flash.accessibility.*;
    import flash.data.*;
    import flash.debugger.*;
    import flash.desktop.*;
    import flash.display.*;
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
    import frontend.components.tab.*;
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
    import utils.converter.*;
    import utils.interfaces.*;
    
    use namespace mx_internal;
    
    public class ActivityGraphComp extends feathers.controls.LayoutGroup implements feathers.binding.IBindingClient
    {
        public function ActivityGraphComp()
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
            bindings = this._ActivityGraphComp_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_activities_component_ActivityGraphCompWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return frontend.screen.activities.component.ActivityGraphComp[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.layout = this._ActivityGraphComp_AnchorLayout1_c();
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        internal function _ActivityGraphComp_AnchorLayout1_c():feathers.layout.AnchorLayout
        {
            var loc1:*=new feathers.layout.AnchorLayout();
            return loc1;
        }

        public function get entries():__AS3__.vec.Vector.<Object>
        {
            return this._entries;
        }

        internal function set _1591573360entries(arg1:__AS3__.vec.Vector.<Object>):void
        {
            this._entries = arg1;
            if (this._entries) 
            {
                this.validateChart();
            }
            return;
        }

        internal function _ActivityGraphComp_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            }, null, "this.backgroundSkin")
            result[1] = new feathers.binding.Binding(this, function ():Number
            {
                return CHART_COMP_HEIGHT;
            }, null, "this.height")
            result[2] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "this.width")
            return result;
        }

        public function set entries(arg1:__AS3__.vec.Vector.<Object>):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.entries;
            if (loc1 !== arg1) 
            {
                this._1591573360entries = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "entries", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get yAchseLabel():String
        {
            return this._1691484629yAchseLabel;
        }

        public function set yAchseLabel(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1691484629yAchseLabel;
            if (loc1 !== arg1) 
            {
                this._1691484629yAchseLabel = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "yAchseLabel", loc1, arg1, this);
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
            frontend.screen.activities.component.ActivityGraphComp._watcherSetupUtil = arg1;
            return;
        }

        internal function validateChart():void
        {
            var loc2:*=0;
            var loc3:*=NaN;
            var loc4:*=null;
            var loc10:*=null;
            var loc14:*=null;
            var loc15:*=NaN;
            var loc23:*=NaN;
            var loc24:*=NaN;
            var loc25:*=NaN;
            var loc26:*=null;
            var loc27:*=NaN;
            var loc28:*=NaN;
            var loc29:*=NaN;
            var loc1:*=this.entries.length;
            loc4 = new feathers.controls.Label();
            loc4.text = this.yAchseLabel;
            loc4.styleProvider = null;
            loc4.textRendererFactory = this.yHeadLabelFactory;
            addChild(loc4);
            loc4.validate();
            loc4.layoutData = new feathers.layout.AnchorLayoutData((GUTTER_TOP - loc4.height) / 2, NaN, NaN, CHART_HEADLINE_PADDING_LEFT);
            var loc5:*=handler.ActivityHandler.calculateVerticalAxisProperties(this.entries, this.yValueName);
            if (isNaN(this.yMinFix)) 
            {
                this.yMin = loc5[0];
            }
            else 
            {
                this.yMin = this.yMinFix;
            }
            if (isNaN(this.yMaxFix)) 
            {
                this.yMax = this.speedTime ? utils.Calculations.speedTimeMaximum() : loc5[1];
            }
            else 
            {
                this.yMax = this.yMaxFix;
            }
            if (isNaN(this.yIntervalFix)) 
            {
                this.yInterval = this.speedTime ? utils.Calculations.speedTimeMaximum() / 2 : loc5[2];
            }
            else 
            {
                this.yInterval = this.yIntervalFix;
            }
            var loc6:*=SIGMALink.appWidth - GUTTER_LEFT - GUTTER_RIGHT;
            var loc7:*=height - GUTTER_TOP - GUTTER_BOTTOM;
            var loc8:*=this.speedTime ? handler.ActivityHandler.calcDiffAbs(utils.Calculations.speedTimeMaximum(), 0) : handler.ActivityHandler.calcDiffAbs(this.yMax, this.yMin);
            var loc9:*=loc7 / loc8;
            var loc11:*=this.yMax - this.yMin;
            var loc12:*=Math.floor(loc11 / this.yInterval);
            var loc13:*=loc7 / loc12;
            loc2 = 0;
            while (loc2 <= loc12) 
            {
                if (this.speedTime) 
                {
                    loc3 = GUTTER_TOP + loc2 * loc13;
                }
                else 
                {
                    loc3 = GUTTER_TOP + loc7 - loc2 * loc13;
                }
                loc15 = this.yMin + loc2 * this.yInterval;
                if (this.yLabelConverter) 
                {
                    loc15 = this.speedTime ? loc15 * 100 : this.yLabelConverter.convert(loc15);
                }
                loc14 = new feathers.controls.Label();
                if (this.yLabelFormatter) 
                {
                    loc14.text = this.yLabelFormatter.format(loc15);
                }
                else 
                {
                    loc14.text = loc15.toFixed(0);
                }
                loc14.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_SMALLLISTLABEL;
                addChild(loc14);
                loc14.validate();
                loc14.layoutData = new feathers.layout.AnchorLayoutData(loc3 - loc14.height / 3, NaN, NaN, GUTTER_LEFT - loc14.width - CHART_AXIS_INTERVAL_LINE_SIZE * 2);
                loc10 = new starling.display.Quad(loc6, 1 * SIGMALink.scaleFactor, core.general.Colors.LIGHTGREY);
                loc10.y = loc3;
                loc10.x = GUTTER_LEFT;
                addChild(loc10);
                loc10 = new starling.display.Quad(CHART_AXIS_INTERVAL_LINE_SIZE, CHART_AXIS_THICKNESS, CHART_AXIS_COLOR);
                loc10.y = loc3;
                loc10.x = GUTTER_LEFT - CHART_AXIS_INTERVAL_LINE_SIZE;
                addChild(loc10);
                ++loc2;
            }
            var loc16:*=new starling.display.Quad(loc6, CHART_AXIS_THICKNESS, CHART_AXIS_COLOR);
            loc16.x = GUTTER_LEFT;
            loc16.y = GUTTER_TOP + loc7;
            addChild(loc16);
            var loc17:*=new starling.display.Quad(CHART_AXIS_THICKNESS, loc7, CHART_AXIS_COLOR);
            loc17.x = GUTTER_LEFT;
            loc17.y = GUTTER_TOP;
            addChild(loc17);
            loc5 = handler.ActivityHandler.calculateHorizontalAxisProperties(this.entries, this.xValueName);
            var loc18:*=loc5[0];
            var loc19:*=loc5[1];
            var loc20:*=loc5[2];
            var loc21:*=Math.ceil(loc19 / loc20);
            var loc22:*=loc6 / loc19;
            if (loc1 > 0) 
            {
                loc23 = this.entries[0][this.xValueName] * loc22;
                loc24 = handler.ActivityHandler.calcDiffAbs(this.yMax, this.speedTime ? this.entries[0].speedTime : this.entries[0][this.yValueName]) * loc9;
                loc25 = 0;
                loc26 = new flash.display.Sprite();
                loc26.graphics.lineStyle(CHART_GRAPH_THICKNESS, this.graphColor);
                loc26.graphics.moveTo(loc23, loc24);
                loc2 = 0;
                while (loc2 < loc1) 
                {
                    loc25 = this.entries[loc2][this.xValueName] * loc22;
                    loc3 = handler.ActivityHandler.calcDiffAbs(this.yMax, this.speedTime ? this.entries[loc2].speedTime : this.entries[loc2][this.yValueName]) * loc9;
                    if (this.speedTime) 
                    {
                        loc3 = loc7 - loc3;
                    }
                    loc26.graphics.cubicCurveTo((loc25 + loc23) * 0.5, loc24, (loc25 + loc23) * 0.5, loc3, loc25, loc3);
                    loc23 = loc25;
                    loc24 = loc3;
                    ++loc2;
                }
                loc26.graphics.endFill();
                loc26.width = loc6;
                loc26.height = loc7;
                addChild(DrawerUtil.getImageFromSprite(loc26, GUTTER_LEFT, GUTTER_TOP));
                loc27 = 0;
                loc2 = 0;
                while (loc2 <= loc21) 
                {
                    loc28 = loc20 * loc2;
                    if (loc28 > loc19) 
                    {
                        loc28 = loc19;
                    }
                    loc29 = GUTTER_LEFT + loc6 * loc28 / loc19;
                    loc10 = new starling.display.Quad(CHART_AXIS_THICKNESS, CHART_AXIS_INTERVAL_LINE_SIZE, CHART_AXIS_COLOR);
                    loc10.y = loc16.y;
                    loc10.x = GUTTER_LEFT + loc6 * loc28 / loc19;
                    addChild(loc10);
                    if (!(loc29 < loc27)) 
                    {
                        loc14 = new feathers.controls.Label();
                        loc14.styleName = "SMALLLISTLABEL";
                        if (this.xValueName != core.activities.ActivityEntryMapper.col_trainingTimeAbsolute) 
                        {
                            if (this.xValueName == core.activities.ActivityEntryMapper.col_distanceAbsolute || this.xValueName == "distance") 
                            {
                                loc14.text = backend.utils.DataUtils.distanceFormatter.format(backend.utils.DataUtils.distanceConverter.convert(loc28));
                            }
                        }
                        else 
                        {
                            loc14.text = backend.utils.DataUtils.timeFormatterHHMM.format(loc28);
                        }
                        addChild(loc14);
                        loc14.validate();
                        loc14.layoutData = new feathers.layout.AnchorLayoutData(loc10.y + loc10.height * 2, NaN, NaN, loc10.x - loc14.width / 2);
                        loc27 = loc10.x + loc14.width;
                    }
                    ++loc2;
                }
            }
            return;
        }

        internal function yHeadLabelFactory():feathers.core.ITextRenderer
        {
            var loc1:*=new feathers.controls.text.TextFieldTextRenderer();
            loc1.textFormat = new flash.text.TextFormat(feathers.themes.BaseSIGMATheme.FONT_NAME, 22 * SIGMALink.scaleFactor, this.graphColor);
            return loc1;
        }

        public static const CHART_COMP_HEIGHT:Number=(SIGMALink.containerHeight - frontend.components.tab.TabContainer.TAB_HEIGHT - frontend.screen.activities.ActivityView.SPORT_ROW_HEIGHT) / 2;

        public static const GUTTER_TOP:Number=55 * SIGMALink.scaleFactor;

        internal static const CHART_AXIS_COLOR:Number=3028545;

        internal static const CHART_AXIS_INTERVAL_LINE_SIZE:Number=8 * SIGMALink.scaleFactor;

        internal static const CHART_AXIS_THICKNESS:Number=2 * SIGMALink.scaleFactor;

        internal static const CHART_GRAPH_THICKNESS:Number=4 * SIGMALink.scaleFactor;

        internal static const CHART_HEADLINE_PADDING_LEFT:Number=20 * SIGMALink.scaleFactor;

        internal static const GUTTER_BOTTOM:Number=50 * SIGMALink.scaleFactor;

        internal static const GUTTER_LEFT:Number=90 * SIGMALink.scaleFactor;

        internal static const GUTTER_RIGHT:Number=35 * SIGMALink.scaleFactor;

        internal var _entries:__AS3__.vec.Vector.<Object>;

        public var graphColor:uint;

        public var speedTime:Boolean=false;

        public var xValueName:String="trainingTimeAbsolute";

        internal var _1691484629yAchseLabel:String;

        public var yIntervalFix:Number;

        public var yLabelConverter:utils.converter.IConverter;

        public var yLabelFormatter:utils.interfaces.ICustomFormatterBase;

        public var yMaxFix:Number=NaN;

        public var yMinFix:Number=NaN;

        public var yValueName:String;

        internal var yInterval:Number;

        internal var yMax:Number;

        internal var yMin:Number;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


