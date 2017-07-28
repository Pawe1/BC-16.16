//class StatisticColumnChartCallout
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


