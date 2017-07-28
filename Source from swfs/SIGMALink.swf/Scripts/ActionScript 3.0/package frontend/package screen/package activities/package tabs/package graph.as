//package graph
//  class ActivityGraphTabView
package frontend.screen.activities.tabs.graph 
{
    import __AS3__.vec.*;
    import backend.utils.*;
    import configCache.*;
    import core.activities.*;
    import core.general.*;
    import feathers.binding.*;
    import feathers.controls.*;
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
    import frontend.components.tab.*;
    import frontend.components.tabbarbase.*;
    import frontend.screen.activities.component.*;
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
    
    public class ActivityGraphTabView extends frontend.components.tabbarbase.TabLayoutScroller implements feathers.binding.IBindingClient
    {
        public function ActivityGraphTabView()
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
            bindings = this._ActivityGraphTabView_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_activities_tabs_graph_ActivityGraphTabViewWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return frontend.screen.activities.tabs.graph.ActivityGraphTabView[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.addEventListener("addedToStage", this.___ActivityGraphTabView_TabLayoutScroller1_addedToStage);
            this.addEventListener("removedFromStage", this.___ActivityGraphTabView_TabLayoutScroller1_removedFromStage);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        public function ___ActivityGraphTabView_TabLayoutScroller1_addedToStage(arg1:starling.events.Event):void
        {
            this.onAddedToStage(arg1);
            return;
        }

        public function get activity():core.activities.Activity
        {
            return this._activity;
        }

        public function set activity(arg1:core.activities.Activity):void
        {
            this._activity = arg1;
            this._redrawFlag = true;
            return;
        }

        public function ___ActivityGraphTabView_TabLayoutScroller1_removedFromStage(arg1:starling.events.Event):void
        {
            this.onRemovedFromStage(arg1);
            return;
        }

        internal function _ActivityGraphTabView_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            }, null, "this.backgroundSkin")
            result[1] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight - frontend.components.tab.TabContainer.TAB_HEIGHT;
            }, null, "this.height")
            result[2] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.graphicon;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.icon")
            result[3] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ACTIVITIES.TABS.GRAPH.TITLE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.label")
            result[4] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "this.width")
            return result;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            frontend.screen.activities.tabs.graph.ActivityGraphTabView._watcherSetupUtil = arg1;
            return;
        }

        
        {
            gapQuadHeight = 4;
        }

        internal function drawChart(arg1:frontend.screen.activities.component.ActivityGraphComp, arg2:int=-1, arg3:Function=null):void
        {
            arg1.validate();
            var loc1:*=new starling.textures.RenderTexture(SIGMALink.appWidth, frontend.screen.activities.component.ActivityGraphComp.CHART_COMP_HEIGHT);
            loc1.draw(arg1, null, 1, 3);
            var loc2:*=new starling.display.Image(loc1);
            if (arg3 != null) 
            {
                loc2.addEventListener(starling.events.TouchEvent.TOUCH, arg3);
            }
            if (arg2 != -1) 
            {
                addChildAt(loc2, arg2);
            }
            else 
            {
                addChild(loc2);
            }
            return;
        }

        public override function showContent():void
        {
            var loc2:*=null;
            if (!this._redrawFlag) 
            {
                return;
            }
            this._redrawFlag = false;
            if (this.activity.entries.length == 0) 
            {
                return;
            }
            var loc1:*=0;
            this.entries = handler.ActivityCalculator.calculateChartEntries(this.activity, 60);
            if (this.activity.entries[0].altitudeDefined) 
            {
                loc2 = new frontend.screen.activities.component.ActivityGraphComp();
                loc2.yAchseLabel = backend.utils.DataUtils.altitudeLabel + " [" + backend.utils.DataUtils.unitStringAltitude + "]";
                loc2.yLabelConverter = backend.utils.DataUtils.altitudeConverter;
                loc2.yLabelFormatter = backend.utils.DataUtils.altitudeFormatter;
                loc2.yValueName = core.activities.ActivityEntryMapper.col_altitude;
                loc2.xValueName = this.getXValueName();
                loc2.graphColor = core.general.Colors.ALTITUDE;
                loc2.entries = this.entries;
                this.drawChart(loc2, -1, this.onChartTouch);
                loc1 = loc1 + (frontend.screen.activities.component.ActivityGraphComp.CHART_COMP_HEIGHT + gapQuadHeight);
            }
            if (this.activity.entries[0].speedDefined) 
            {
                this.addGapQuad(loc1 - gapQuadHeight);
                this.speedIndex = numChildren;
                this.drawSleepChart();
                loc1 = loc1 + (frontend.screen.activities.component.ActivityGraphComp.CHART_COMP_HEIGHT + gapQuadHeight);
            }
            if (this.activity.entries[0].heartrateDefined) 
            {
                this.addGapQuad(loc1 - gapQuadHeight);
                loc2 = new frontend.screen.activities.component.ActivityGraphComp();
                loc2.yAchseLabel = backend.utils.DataUtils.heartrateLabel + " [" + backend.utils.DataUtils.unitStringHeartrate + "]";
                loc2.yLabelFormatter = backend.utils.DataUtils.heartrateFormatter;
                loc2.yValueName = core.activities.ActivityEntryMapper.col_heartrate;
                loc2.xValueName = this.getXValueName();
                loc2.yMaxFix = 240;
                loc2.yMinFix = 0;
                loc2.yIntervalFix = 60;
                loc2.graphColor = core.general.Colors.HEATRATE;
                loc2.entries = this.entries;
                this.drawChart(loc2, -1, this.onChartTouch);
                loc1 = loc1 + (frontend.screen.activities.component.ActivityGraphComp.CHART_COMP_HEIGHT + gapQuadHeight);
            }
            verticalScrollPolicy = numChildren > 3 ? feathers.controls.Scroller.SCROLL_POLICY_ON : feathers.controls.Scroller.SCROLL_POLICY_OFF;
            return;
        }

        public override function hideContent():void
        {
            this.clearCharts();
            return;
        }

        internal function addGapQuad(arg1:Number):void
        {
            var loc1:*=new starling.display.Quad(SIGMALink.appWidth, gapQuadHeight, core.general.Colors.LIGHTGREY);
            loc1.y = arg1;
            addChild(loc1);
            return;
        }

        protected function onAddedToStage(arg1:starling.events.Event):void
        {
            handler.ViewHandler.getInstance().addEventListener(handler.ViewHandler.EVENT_SPEED_FORMAT_CHANGED, this.onSpeedFormatChanged);
            return;
        }

        protected function onRemovedFromStage(arg1:starling.events.Event):void
        {
            handler.ViewHandler.getInstance().removeEventListener(handler.ViewHandler.EVENT_SPEED_FORMAT_CHANGED, this.onSpeedFormatChanged);
            return;
        }

        internal function onSpeedFormatChanged(arg1:starling.events.Event):void
        {
            if (this.speedIndex != -1) 
            {
                removeChildAt(this.speedIndex);
            }
            this.drawSleepChart();
            return;
        }

        internal function drawSleepChart():void
        {
            this.speedChart = new frontend.screen.activities.component.ActivityGraphComp();
            var loc1:*=configCache.ConfigCache.getInstance().getSportSpeedFormatValue(this.activity.sport);
            if (loc1 != utils.format.SpeedFormat.DISTANCE_PER_TIME) 
            {
                this.speedChart.speedTime = true;
                this.speedChart.yAchseLabel = backend.utils.DataUtils.speedLabel + " [" + backend.utils.DataUtils.unitStringSpeedTime + "]";
                this.speedChart.yLabelConverter = backend.utils.DataUtils.speedTimeConverter;
                this.speedChart.yLabelFormatter = backend.utils.DataUtils.timeFormatter_MM_SS;
                this.speedChart.yValueName = core.activities.ActivityEntryMapper.col_speed;
            }
            else 
            {
                this.speedChart.speedTime = false;
                this.speedChart.yAchseLabel = backend.utils.DataUtils.speedLabel + " [" + backend.utils.DataUtils.unitStringSpeed + "]";
                this.speedChart.yLabelConverter = backend.utils.DataUtils.speedConverter;
                this.speedChart.yLabelFormatter = backend.utils.DataUtils.speedFormatter;
                this.speedChart.yValueName = core.activities.ActivityEntryMapper.col_speed;
            }
            this.speedChart.xValueName = this.getXValueName();
            this.speedChart.graphColor = core.general.Colors.SPEED;
            this.speedChart.entries = this.entries;
            this.drawChart(this.speedChart, this.speedIndex, this.onSpeedChartTouch);
            return;
        }

        internal function onSpeedChartTouch(arg1:starling.events.TouchEvent):void
        {
            var loc2:*=null;
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            var loc1:*=this.getTouchPoint(arg1);
            if (loc1.y < frontend.screen.activities.component.ActivityGraphComp.GUTTER_TOP) 
            {
                loc2 = configCache.ConfigCache.getInstance().getSportSpeedFormatValue(this.activity.sport);
                loc2 = loc2 != utils.format.SpeedFormat.DISTANCE_PER_TIME ? utils.format.SpeedFormat.DISTANCE_PER_TIME : utils.format.SpeedFormat.TIME_PER_DISTANCE;
                configCache.ConfigCache.getInstance().setSportSpeedFormatValue(this.activity.sport, loc2);
                handler.ViewHandler.getInstance().dispatchEventWith(handler.ViewHandler.EVENT_SPEED_FORMAT_CHANGED);
            }
            else 
            {
                this.onChartTouch(arg1);
            }
            return;
        }

        internal function onChartTouch(arg1:starling.events.TouchEvent):void
        {
            var loc2:*=null;
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            var loc1:*=this.getTouchPoint(arg1);
            if (loc1.y > frontend.screen.activities.component.ActivityGraphComp.CHART_COMP_HEIGHT - frontend.screen.activities.component.ActivityGraphComp.GUTTER_TOP) 
            {
                loc2 = configCache.ConfigCache.getInstance().getSportBaseValue(this.activity.sport);
                loc2 = loc2 != core.general.MeasuringUnit.DISTANCE ? core.general.MeasuringUnit.DISTANCE : core.general.MeasuringUnit.TRAININGTIME;
                configCache.ConfigCache.getInstance().setSportBaseValue(this.activity.sport, loc2);
                this.clearCharts();
                this.speedIndex = -1;
                this.showContent();
            }
            return;
        }

        internal function getTouchPoint(arg1:starling.events.TouchEvent):flash.geom.Point
        {
            var loc1:*=arg1.target as starling.display.DisplayObject;
            var loc2:*=arg1.getTouch(loc1);
            var loc3:*=new flash.geom.Point(loc2.globalX, loc2.globalY);
            return loc1.globalToLocal(loc3);
        }

        internal function getXValueName():String
        {
            return configCache.ConfigCache.getInstance().getSportBaseValue(this.activity.sport);
        }

        public override function dispose():void
        {
            this.clearCharts();
            super.dispose();
            return;
        }

        public function clearCharts():void
        {
            var loc1:*=0;
            var loc3:*=null;
            var loc2:*=numChildren;
            loc1 = 0;
            while (loc1 < loc2) 
            {
                loc3 = getChildAt(loc1);
                if (loc3 is starling.display.Image) 
                {
                    (loc3 as starling.display.Image).texture.dispose();
                }
                loc3.dispose();
                ++loc1;
            }
            removeChildren();
            return;
        }

        internal var _activity:core.activities.Activity;

        internal var _redrawFlag:Boolean=true;

        internal var entries:__AS3__.vec.Vector.<Object>;

        internal var speedChart:frontend.screen.activities.component.ActivityGraphComp;

        internal var speedIndex:int=-1;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var gapQuadHeight:Number=4;

        mx_internal var _bindings:Array;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;

        mx_internal var _watchers:Array;
    }
}


