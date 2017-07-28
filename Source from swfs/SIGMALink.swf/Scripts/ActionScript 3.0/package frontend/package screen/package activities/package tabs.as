//package tabs
//  package graph
//    class ActivityGraphTabView
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


//  package laps
//    class ActivityLapDetailsView
package frontend.screen.activities.tabs.laps 
{
    import backend.utils.*;
    import configCache.*;
    import core.general.*;
    import core.marker.*;
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
    import frontend.components.scrollContainer.*;
    import frontend.components.tab.*;
    import frontend.screen.activities.*;
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
    
    public class ActivityLapDetailsView extends frontend.components.scrollContainer.CustomVScrollContainer implements feathers.binding.IBindingClient
    {
        public function ActivityLapDetailsView()
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
            bindings = this._ActivityLapDetailsView_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_activities_tabs_laps_ActivityLapDetailsViewWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return frontend.screen.activities.tabs.laps.ActivityLapDetailsView[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.mxmlContent = [this._ActivityLapDetailsView_LayoutGroup1_i()];
            this.addEventListener("addedToStage", this.___ActivityLapDetailsView_CustomVScrollContainer1_addedToStage);
            this.addEventListener("removedFromStage", this.___ActivityLapDetailsView_CustomVScrollContainer1_removedFromStage);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        public function ___ActivityLapDetailsView_CustomVScrollContainer1_removedFromStage(arg1:starling.events.Event):void
        {
            this.onRemovedFromStage();
            return;
        }

        internal function _ActivityLapDetailsView_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight - frontend.screen.activities.ActivityView.SPORT_ROW_HEIGHT - frontend.components.tab.TabContainer.TAB_HEIGHT;
            }, null, "this.height")
            result[1] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "this.width")
            result[2] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            }, null, "_ActivityLapDetailsView_LayoutGroup2.backgroundSkin")
            result[3] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.scaleFactor * 100;
            }, null, "_ActivityLapDetailsView_LayoutGroup2.height")
            result[4] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_ActivityLapDetailsView_LayoutGroup2.width")
            result[5] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth * 0.5;
            }, null, "_ActivityLapDetailsView_LayoutGroup3.width")
            result[6] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.scaleFactor * 20;
            }, null, "_ActivityLapDetailsView_VerticalLayout1.paddingLeft")
            result[7] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.scaleFactor * 20;
            }, null, "_ActivityLapDetailsView_VerticalLayout1.paddingTop")
            result[8] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ACTIVIY_TAB_LAPS_DETAILS_LAP") + " " + lapCurrent + "/" + lapAmount;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ActivityLapDetailsView_Label1.text")
            result[9] = new feathers.binding.Binding(this, null, null, "_ActivityLapDetailsView_Label2.text", "lapTypeLabel");
            result[10] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth * 0.5;
            }, null, "_ActivityLapDetailsView_LayoutGroup4.width")
            result[11] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.scaleFactor * 20;
            }, null, "_ActivityLapDetailsView_HorizontalLayout2.gap")
            result[12] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.scaleFactor * 20;
            }, null, "_ActivityLapDetailsView_HorizontalLayout2.paddingRight")
            result[13] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.lefticon;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ActivityLapDetailsView_IconButton1.image")
            result[14] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.lefticonDisabled;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ActivityLapDetailsView_IconButton1.imageDisabled")
            result[15] = new feathers.binding.Binding(this, function ():Boolean
            {
                return _prevButtonEnabled;
            }, null, "_ActivityLapDetailsView_IconButton1.isEnabled")
            result[16] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.scaleFactor * 20;
            }, null, "_ActivityLapDetailsView_IconButton1.paddingLeft")
            result[17] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.scaleFactor * 20;
            }, null, "_ActivityLapDetailsView_IconButton1.paddingRight")
            result[18] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.righticon;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ActivityLapDetailsView_IconButton2.image")
            result[19] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.righticonDisabled;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ActivityLapDetailsView_IconButton2.imageDisabled")
            result[20] = new feathers.binding.Binding(this, function ():Boolean
            {
                return _nextButtonEnabled;
            }, null, "_ActivityLapDetailsView_IconButton2.isEnabled")
            result[21] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.scaleFactor * 20;
            }, null, "_ActivityLapDetailsView_IconButton2.paddingLeft")
            result[22] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.scaleFactor * 20;
            }, null, "_ActivityLapDetailsView_IconButton2.paddingRight")
            return result;
        }

        public function get vContainer():feathers.controls.LayoutGroup
        {
            return this._120745813vContainer;
        }

        public function set vContainer(arg1:feathers.controls.LayoutGroup):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._120745813vContainer;
            if (loc1 !== arg1) 
            {
                this._120745813vContainer = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "vContainer", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get lapCurrent():uint
        {
            return this._1439809374lapCurrent;
        }

        public function set lapCurrent(arg1:uint):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1439809374lapCurrent;
            if (loc1 !== arg1) 
            {
                this._1439809374lapCurrent = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "lapCurrent", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get lapTypeLabel():String
        {
            return this._520982655lapTypeLabel;
        }

        internal function _ActivityLapDetailsView_LayoutGroup3_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._ActivityLapDetailsView_VerticalLayout1_i();
            loc1.mxmlContent = [this._ActivityLapDetailsView_Label1_i(), this._ActivityLapDetailsView_Label2_i()];
            loc1.id = "_ActivityLapDetailsView_LayoutGroup3";
            this._ActivityLapDetailsView_LayoutGroup3 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ActivityLapDetailsView_LayoutGroup3", this._ActivityLapDetailsView_LayoutGroup3);
            return loc1;
        }

        public function set lapTypeLabel(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._520982655lapTypeLabel;
            if (loc1 !== arg1) 
            {
                this._520982655lapTypeLabel = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "lapTypeLabel", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function set markerList(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.markerList;
            if (loc1 !== arg1) 
            {
                this._1115163640markerList = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "markerList", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _nextButtonEnabled():Boolean
        {
            return this._731648253_nextButtonEnabled;
        }

        internal function get _prevButtonEnabled():Boolean
        {
            return this._1506460093_prevButtonEnabled;
        }

        internal function set _prevButtonEnabled(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1506460093_prevButtonEnabled;
            if (loc1 !== arg1) 
            {
                this._1506460093_prevButtonEnabled = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_prevButtonEnabled", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get markerList():feathers.data.ListCollection
        {
            return this._markerList;
        }

        internal function set _1115163640markerList(arg1:feathers.data.ListCollection):void
        {
            this._markerList = arg1;
            this.lapAmount = this._markerList.length;
            return;
        }

        internal function get lapAmount():uint
        {
            return this._2096497197lapAmount;
        }

        internal function set lapAmount(arg1:uint):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._2096497197lapAmount;
            if (loc1 !== arg1) 
            {
                this._2096497197lapAmount = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "lapAmount", loc1, arg1, this);
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
            frontend.screen.activities.tabs.laps.ActivityLapDetailsView._watcherSetupUtil = arg1;
            return;
        }

        internal function onSwitchToPreviousLapTouch():void
        {
            if (this.lapCurrent > 1) 
            {
                var loc1:*;
                var loc2:*=((loc1 = this).lapCurrent - 1);
                loc1.lapCurrent = loc2;
                this.onAddedToStage();
            }
            return;
        }

        internal function onSwitchToNextLapTouch():void
        {
            if (this.lapCurrent < this.lapAmount) 
            {
                var loc1:*;
                var loc2:*=((loc1 = this).lapCurrent + 1);
                loc1.lapCurrent = loc2;
                this.onAddedToStage();
            }
            return;
        }

        internal function checkButtonStates():void
        {
            this._prevButtonEnabled = this.lapCurrent > 1;
            this._nextButtonEnabled = this.lapCurrent < this.lapAmount;
            return;
        }

        internal function onAddedToStage():void
        {
            this.checkButtonStates();
            this.addValues();
            handler.ViewHandler.getInstance().addEventListener(handler.ViewHandler.EVENT_SPEED_FORMAT_CHANGED, this.onSpeedFormatChanged);
            return;
        }

        internal function onRemovedFromStage():void
        {
            handler.ViewHandler.getInstance().removeEventListener(handler.ViewHandler.EVENT_SPEED_FORMAT_CHANGED, this.onSpeedFormatChanged);
            return;
        }

        internal function onSpeedFormatChanged(arg1:starling.events.Event):void
        {
            this.addValues();
            return;
        }

        internal function addValues(arg1:starling.events.Event=null):void
        {
            var loc2:*=null;
            var loc1:*=this.markerList.getItemAt((this.lapCurrent - 1)) as core.marker.Marker;
            if (!loc1) 
            {
                return;
            }
            var loc4:*=loc1.type;
            switch (loc4) 
            {
                case core.general.MarkerType.LAP:
                {
                    this.lapTypeLabel = utils.LanguageManager.getString("ACTIVIY_TAB_LAPS_DETAILS_MANUAL_LAP");
                    break;
                }
                case core.general.MarkerType.AUTO_LAP:
                {
                    this.lapTypeLabel = utils.LanguageManager.getString("ACTIVIY_TAB_LAPS_DETAILS_AUTO_LAP");
                    break;
                }
                default:
                {
                    this.lapTypeLabel = "";
                }
            }
            if (this.vContainer.numChildren > 0) 
            {
                this.vContainer.removeChildren(1);
            }
            var loc3:*=100 * SIGMALink.scaleFactor;
            loc2 = new frontend.screen.activities.component.ActivityValueComp();
            loc2.layoutData = new feathers.layout.AnchorLayoutData(loc3);
            loc2.ROW_HEIGHT = ROW_HEIGHT;
            loc2.iconSource = frontend.Textures.laengstezeit;
            loc2.iconText = "ACTIVIY_TAB_LAPS_DETAILS_LAPTIME";
            loc2.setValue(loc1.time, null, backend.utils.DataUtils.timeFormatter);
            loc2.unit = backend.utils.DataUtils.unitStringTimeHours;
            this.vContainer.addChild(loc2);
            loc3 = loc3 + ROW_HEIGHT;
            loc3 = loc3 + this.addHLine(loc3);
            loc2 = new frontend.screen.activities.component.ActivityValueComp();
            loc2.layoutData = new feathers.layout.AnchorLayoutData(loc3);
            loc2.ROW_HEIGHT = SUB_ROW_HEIGHT;
            loc2.iconText = "ACTIVIY_TAB_LAPS_DETAILS_FROM_START";
            loc2.setValue(loc1.timeAbsolute, null, backend.utils.DataUtils.timeFormatter);
            loc2.unit = backend.utils.DataUtils.unitStringTimeHours;
            this.vContainer.addChild(loc2);
            loc3 = loc3 + SUB_ROW_HEIGHT;
            loc3 = loc3 + this.addHLine(loc3, true);
            if (loc1.distanceDefined) 
            {
                loc2 = new frontend.screen.activities.component.ActivityValueComp();
                loc2.layoutData = new feathers.layout.AnchorLayoutData(loc3);
                loc2.ROW_HEIGHT = ROW_HEIGHT;
                loc2.iconSource = frontend.Textures.strecke;
                loc2.iconTextTranslated = backend.utils.DataUtils.distanceLabel;
                loc2.setValue(loc1.distance, backend.utils.DataUtils.distanceConverter, backend.utils.DataUtils.distanceFormatter);
                loc2.unit = backend.utils.DataUtils.unitStringDistance;
                this.vContainer.addChild(loc2);
                loc3 = loc3 + ROW_HEIGHT;
                if (loc1.distanceAbsoluteDefined) 
                {
                    loc3 = loc3 + this.addHLine(loc3);
                    loc2 = new frontend.screen.activities.component.ActivityValueComp();
                    loc2.layoutData = new feathers.layout.AnchorLayoutData(loc3);
                    loc2.ROW_HEIGHT = SUB_ROW_HEIGHT;
                    loc2.iconText = "ACTIVIY_TAB_LAPS_DETAILS_FROM_START";
                    loc2.setValue(loc1.distanceAbsolute, backend.utils.DataUtils.distanceConverter, backend.utils.DataUtils.distanceFormatter);
                    loc2.unit = backend.utils.DataUtils.unitStringDistance;
                    this.vContainer.addChild(loc2);
                    loc3 = loc3 + SUB_ROW_HEIGHT;
                }
                loc3 = loc3 + this.addHLine(loc3, true);
            }
            if (loc1.averageSpeedDefined) 
            {
                loc2 = new frontend.screen.activities.component.ActivityValueComp();
                loc2.layoutData = new feathers.layout.AnchorLayoutData(loc3);
                loc2.ROW_HEIGHT = ROW_HEIGHT;
                loc2.speedBasedValue = loc1.averageSpeed;
                loc2.iconSource = frontend.Textures.IconSpeed;
                loc2.iconTextTranslated = backend.utils.DataUtils.speedLabel;
                loc2.valueIconSource = frontend.Textures.averageiconmini;
                loc2.clickCallback = this.swapSpeedFormat;
                this.updateSpeedBasedObjects(loc2);
                this.vContainer.addChild(loc2);
                loc3 = loc3 + ROW_HEIGHT;
                if (loc1.minimumSpeedDefined) 
                {
                    loc3 = loc3 + this.addHLine(loc3);
                    loc2 = new frontend.screen.activities.component.ActivityValueComp();
                    loc2.layoutData = new feathers.layout.AnchorLayoutData(loc3);
                    loc2.ROW_HEIGHT = SUB_ROW_HEIGHT;
                    loc2.iconText = "ACTIVIY_TAB_VALUES_MIN";
                    loc2.speedBasedValue = loc1.minimumSpeed;
                    loc2.clickCallback = this.swapSpeedFormat;
                    this.updateSpeedBasedObjects(loc2);
                    this.vContainer.addChild(loc2);
                    loc3 = loc3 + SUB_ROW_HEIGHT;
                }
                if (loc1.maximumSpeedDefined) 
                {
                    loc3 = loc3 + this.addHLine(loc3);
                    loc2 = new frontend.screen.activities.component.ActivityValueComp();
                    loc2.layoutData = new feathers.layout.AnchorLayoutData(loc3);
                    loc2.ROW_HEIGHT = SUB_ROW_HEIGHT;
                    loc2.iconText = "ACTIVIY_TAB_VALUES_MAX";
                    loc2.speedBasedValue = loc1.maximumSpeed;
                    loc2.clickCallback = this.swapSpeedFormat;
                    this.updateSpeedBasedObjects(loc2);
                    this.vContainer.addChild(loc2);
                    loc3 = loc3 + SUB_ROW_HEIGHT;
                }
                loc3 = loc3 + this.addHLine(loc3, true);
            }
            if (loc1.averageHeartrateDefined) 
            {
                loc2 = new frontend.screen.activities.component.ActivityValueComp();
                loc2.layoutData = new feathers.layout.AnchorLayoutData(loc3);
                loc2.ROW_HEIGHT = ROW_HEIGHT;
                loc2.iconSource = frontend.Textures.heartrateicon;
                loc2.iconTextTranslated = backend.utils.DataUtils.heartrateLabel;
                loc2.setValue(loc1.averageHeartrate, null, backend.utils.DataUtils.heartrateFormatter);
                loc2.unit = backend.utils.DataUtils.unitStringHeartrate;
                loc2.valueIconSource = frontend.Textures.averageiconmini;
                this.vContainer.addChild(loc2);
                loc3 = loc3 + ROW_HEIGHT;
                if (loc1.minimumHeartrateDefined) 
                {
                    loc3 = loc3 + this.addHLine(loc3);
                    loc2 = new frontend.screen.activities.component.ActivityValueComp();
                    loc2.layoutData = new feathers.layout.AnchorLayoutData(loc3);
                    loc2.ROW_HEIGHT = SUB_ROW_HEIGHT;
                    loc2.iconText = "ACTIVIY_TAB_VALUES_MIN";
                    loc2.setValue(loc1.minimumHeartrate, null, backend.utils.DataUtils.heartrateFormatter);
                    loc2.unit = backend.utils.DataUtils.unitStringHeartrate;
                    this.vContainer.addChild(loc2);
                    loc3 = loc3 + SUB_ROW_HEIGHT;
                }
                if (loc1.maximumHeartrateDefined) 
                {
                    loc3 = loc3 + this.addHLine(loc3);
                    loc2 = new frontend.screen.activities.component.ActivityValueComp();
                    loc2.layoutData = new feathers.layout.AnchorLayoutData(loc3);
                    loc2.ROW_HEIGHT = SUB_ROW_HEIGHT;
                    loc2.iconText = "ACTIVIY_TAB_VALUES_MAX";
                    loc2.setValue(loc1.maximumHeartrate, null, backend.utils.DataUtils.heartrateFormatter);
                    loc2.unit = backend.utils.DataUtils.unitStringHeartrate;
                    this.vContainer.addChild(loc2);
                    loc3 = loc3 + SUB_ROW_HEIGHT;
                }
                loc3 = loc3 + this.addHLine(loc3, true);
            }
            return;
        }

        internal function updateSpeedBasedObjects(arg1:frontend.screen.activities.component.ActivityValueComp):void
        {
            var loc3:*=NaN;
            var loc1:*=this.markerList.getItemAt((this.lapCurrent - 1)) as core.marker.Marker;
            var loc2:*=configCache.ConfigCache.getInstance().getSportSpeedFormatValue(loc1.logReference.sport);
            if (loc2 != utils.format.SpeedFormat.DISTANCE_PER_TIME) 
            {
                loc3 = utils.Calculations.calculateSpeedTime(arg1.speedBasedValue);
                if (loc3 != utils.Calculations.speedTimeMaximum()) 
                {
                    arg1.setValue(loc3 * 100, null, backend.utils.DataUtils.timeFormatter_MM_SS);
                }
                else 
                {
                    arg1.value = "--:--";
                }
                arg1.unit = backend.utils.DataUtils.unitStringSpeedTime;
            }
            else 
            {
                arg1.setValue(arg1.speedBasedValue, backend.utils.DataUtils.speedConverter, backend.utils.DataUtils.speedFormatter);
                arg1.unit = backend.utils.DataUtils.unitStringSpeed;
            }
            return;
        }

        internal function addHLine(arg1:Number, arg2:Boolean=false):Number
        {
            var loc1:*=arg2 ? 30 : 3;
            var loc2:*=new starling.display.Quad(SIGMALink.appWidth, loc1 * SIGMALink.scaleFactor, core.general.Colors.LIGHTGREY);
            loc2.y = arg1;
            this.vContainer.addChild(loc2);
            return loc1;
        }

        internal function swapSpeedFormat():void
        {
            var loc1:*=this.markerList.getItemAt((this.lapCurrent - 1)) as core.marker.Marker;
            var loc2:*=configCache.ConfigCache.getInstance().getSportSpeedFormatValue(loc1.logReference.sport);
            loc2 = loc2 != utils.format.SpeedFormat.DISTANCE_PER_TIME ? utils.format.SpeedFormat.DISTANCE_PER_TIME : utils.format.SpeedFormat.TIME_PER_DISTANCE;
            configCache.ConfigCache.getInstance().setSportSpeedFormatValue(loc1.logReference.sport, loc2);
            handler.ViewHandler.getInstance().dispatchEventWith(handler.ViewHandler.EVENT_SPEED_FORMAT_CHANGED);
            return;
        }

        internal function _ActivityLapDetailsView_LayoutGroup1_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._ActivityLapDetailsView_AnchorLayout1_c();
            loc1.mxmlContent = [this._ActivityLapDetailsView_LayoutGroup2_i()];
            loc1.id = "vContainer";
            this.vContainer = loc1;
            feathers.binding.BindingManager.executeBindings(this, "vContainer", this.vContainer);
            return loc1;
        }

        internal function _ActivityLapDetailsView_AnchorLayout1_c():feathers.layout.AnchorLayout
        {
            var loc1:*=new feathers.layout.AnchorLayout();
            return loc1;
        }

        internal function _ActivityLapDetailsView_LayoutGroup2_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._ActivityLapDetailsView_HorizontalLayout1_c();
            loc1.mxmlContent = [this._ActivityLapDetailsView_LayoutGroup3_i(), this._ActivityLapDetailsView_LayoutGroup4_i()];
            loc1.id = "_ActivityLapDetailsView_LayoutGroup2";
            this._ActivityLapDetailsView_LayoutGroup2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ActivityLapDetailsView_LayoutGroup2", this._ActivityLapDetailsView_LayoutGroup2);
            return loc1;
        }

        internal function _ActivityLapDetailsView_HorizontalLayout1_c():feathers.layout.HorizontalLayout
        {
            var loc1:*=new feathers.layout.HorizontalLayout();
            loc1.verticalAlign = "middle";
            return loc1;
        }

        internal function set _nextButtonEnabled(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._731648253_nextButtonEnabled;
            if (loc1 !== arg1) 
            {
                this._731648253_nextButtonEnabled = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_nextButtonEnabled", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function _ActivityLapDetailsView_VerticalLayout1_i():feathers.layout.VerticalLayout
        {
            var loc1:*=new feathers.layout.VerticalLayout();
            loc1.horizontalAlign = "left";
            loc1.verticalAlign = "middle";
            this._ActivityLapDetailsView_VerticalLayout1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ActivityLapDetailsView_VerticalLayout1", this._ActivityLapDetailsView_VerticalLayout1);
            return loc1;
        }

        internal function _ActivityLapDetailsView_Label1_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.styleName = "BIGLISTLABEL";
            loc1.id = "_ActivityLapDetailsView_Label1";
            this._ActivityLapDetailsView_Label1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ActivityLapDetailsView_Label1", this._ActivityLapDetailsView_Label1);
            return loc1;
        }

        internal function _ActivityLapDetailsView_Label2_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.styleName = "SMALLLISTLABEL";
            loc1.id = "_ActivityLapDetailsView_Label2";
            this._ActivityLapDetailsView_Label2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ActivityLapDetailsView_Label2", this._ActivityLapDetailsView_Label2);
            return loc1;
        }

        internal function _ActivityLapDetailsView_LayoutGroup4_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._ActivityLapDetailsView_HorizontalLayout2_i();
            loc1.mxmlContent = [this._ActivityLapDetailsView_IconButton1_i(), this._ActivityLapDetailsView_IconButton2_i()];
            loc1.id = "_ActivityLapDetailsView_LayoutGroup4";
            this._ActivityLapDetailsView_LayoutGroup4 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ActivityLapDetailsView_LayoutGroup4", this._ActivityLapDetailsView_LayoutGroup4);
            return loc1;
        }

        internal function _ActivityLapDetailsView_HorizontalLayout2_i():feathers.layout.HorizontalLayout
        {
            var loc1:*=new feathers.layout.HorizontalLayout();
            loc1.horizontalAlign = "right";
            loc1.verticalAlign = "middle";
            this._ActivityLapDetailsView_HorizontalLayout2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ActivityLapDetailsView_HorizontalLayout2", this._ActivityLapDetailsView_HorizontalLayout2);
            return loc1;
        }

        internal function _ActivityLapDetailsView_IconButton1_i():frontend.components.button.IconButton
        {
            var loc1:*=new frontend.components.button.IconButton();
            loc1.addEventListener("triggered", this.___ActivityLapDetailsView_IconButton1_triggered);
            loc1.id = "_ActivityLapDetailsView_IconButton1";
            this._ActivityLapDetailsView_IconButton1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ActivityLapDetailsView_IconButton1", this._ActivityLapDetailsView_IconButton1);
            return loc1;
        }

        public function ___ActivityLapDetailsView_IconButton1_triggered(arg1:starling.events.Event):void
        {
            this.onSwitchToPreviousLapTouch();
            return;
        }

        internal function _ActivityLapDetailsView_IconButton2_i():frontend.components.button.IconButton
        {
            var loc1:*=new frontend.components.button.IconButton();
            loc1.addEventListener("triggered", this.___ActivityLapDetailsView_IconButton2_triggered);
            loc1.id = "_ActivityLapDetailsView_IconButton2";
            this._ActivityLapDetailsView_IconButton2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ActivityLapDetailsView_IconButton2", this._ActivityLapDetailsView_IconButton2);
            return loc1;
        }

        public function ___ActivityLapDetailsView_IconButton2_triggered(arg1:starling.events.Event):void
        {
            this.onSwitchToNextLapTouch();
            return;
        }

        public function ___ActivityLapDetailsView_CustomVScrollContainer1_addedToStage(arg1:starling.events.Event):void
        {
            this.onAddedToStage();
            return;
        }

        internal static const ROW_HEIGHT:Number=80 * SIGMALink.scaleFactor;

        internal static const SUB_ROW_HEIGHT:Number=55 * SIGMALink.scaleFactor;

        public var _ActivityLapDetailsView_HorizontalLayout2:feathers.layout.HorizontalLayout;

        public var _ActivityLapDetailsView_IconButton1:frontend.components.button.IconButton;

        public var _ActivityLapDetailsView_IconButton2:frontend.components.button.IconButton;

        public var _ActivityLapDetailsView_Label1:feathers.controls.Label;

        public var _ActivityLapDetailsView_Label2:feathers.controls.Label;

        public var _ActivityLapDetailsView_LayoutGroup2:feathers.controls.LayoutGroup;

        public var _ActivityLapDetailsView_LayoutGroup3:feathers.controls.LayoutGroup;

        public var _ActivityLapDetailsView_VerticalLayout1:feathers.layout.VerticalLayout;

        internal var _120745813vContainer:feathers.controls.LayoutGroup;

        internal var _1439809374lapCurrent:uint=0;

        internal var _520982655lapTypeLabel:String="";

        internal var _markerList:feathers.data.ListCollection;

        internal var _731648253_nextButtonEnabled:Boolean=true;

        internal var _1506460093_prevButtonEnabled:Boolean=true;

        internal var _2096497197lapAmount:uint;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        public var _ActivityLapDetailsView_LayoutGroup4:feathers.controls.LayoutGroup;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//    class ActivityLapItemListRenderer
package frontend.screen.activities.tabs.laps 
{
    import configCache.*;
    import core.general.*;
    import core.marker.*;
    import feathers.controls.*;
    import feathers.controls.renderers.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import starling.display.*;
    import utils.format.*;
    
    public class ActivityLapItemListRenderer extends feathers.controls.renderers.DefaultListItemRenderer
    {
        public function ActivityLapItemListRenderer()
        {
            this._group = new feathers.controls.LayoutGroup();
            this._labelAvgSpeed = new feathers.controls.Label();
            this._labelDistance = new feathers.controls.Label();
            this._labelTime = new feathers.controls.Label();
            super();
            hasLabelTextRenderer = false;
            styleProvider = null;
            defaultSkin = new starling.display.Quad(SIGMALink.appWidth, ROW_HEIGHT, core.general.Colors.WHITE);
            defaultSelectedSkin = new starling.display.Quad(SIGMALink.appWidth, ROW_HEIGHT, core.general.Colors.LIGHTGREY);
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            this._group.width = SIGMALink.appWidth;
            this._group.height = ROW_HEIGHT;
            this._group.layout = new feathers.layout.AnchorLayout();
            this._labelDistance.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            this._labelDistance.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, COL_PADDING, NaN, 0);
            this._labelDistance.width = COL_WIDTH;
            this._group.addChild(this._labelDistance);
            this._labelTime.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            this._labelTime.layoutData = new feathers.layout.AnchorLayoutData(NaN, COL_PADDING + COL_WIDTH + COL_PADDING, NaN, NaN, NaN, 0);
            this._labelTime.width = COL_WIDTH;
            this._group.addChild(this._labelTime);
            this._labelAvgSpeed.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            this._labelAvgSpeed.layoutData = new feathers.layout.AnchorLayoutData(NaN, COL_PADDING, NaN, NaN, NaN, 0);
            this._labelAvgSpeed.width = COL_WIDTH;
            this._group.addChild(this._labelAvgSpeed);
            addChild(this._group);
            var loc1:*=new starling.display.Quad(SIGMALink.appWidth, 1, core.general.Colors.LIGHTGREY);
            addChild(loc1);
            return;
        }

        protected override function commitData():void
        {
            var loc1:*=null;
            super.commitData();
            if (!data) 
            {
                return;
            }
            if (data is core.marker.Marker) 
            {
                loc1 = data as core.marker.Marker;
                if (loc1.distanceDefined) 
                {
                    this._labelDistance.text = loc1.distanceOutputString;
                }
                this._labelTime.text = loc1.timeOutputString;
                if (loc1.averageSpeedDefined) 
                {
                    if (configCache.ConfigCache.getInstance().getSportSpeedFormatValue(loc1.logReference.sport) != utils.format.SpeedFormat.DISTANCE_PER_TIME) 
                    {
                        this._labelAvgSpeed.text = loc1.averageSpeedTimeOutputString;
                    }
                    else 
                    {
                        this._labelAvgSpeed.text = loc1.averageSpeedOutputString;
                    }
                }
            }
            else 
            {
                this._labelDistance.text = data + "";
                this._labelTime.text = "";
                this._labelAvgSpeed.text = "";
            }
            return;
        }

        public static const COL_PADDING:Number=20 * SIGMALink.scaleFactor;

        public static const COL_WIDTH:Number=(SIGMALink.appWidth - 4 * COL_PADDING) / 3;

        internal static const ROW_HEIGHT:Number=60 * SIGMALink.scaleFactor;

        internal var _group:feathers.controls.LayoutGroup;

        internal var _labelAvgSpeed:feathers.controls.Label;

        internal var _labelDistance:feathers.controls.Label;

        internal var _labelTime:feathers.controls.Label;
    }
}


//    class ActivityLapsTabView
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


//  package map
//    class ActivityMapTabView
package frontend.screen.activities.tabs.map 
{
    import __AS3__.vec.*;
    import core.activities.*;
    import core.general.*;
    import core.marker.*;
    import feathers.binding.*;
    import feathers.data.*;
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
    import frontend.components.map.*;
    import frontend.components.tab.*;
    import frontend.components.tabbarbase.*;
    import frontend.screen.activities.*;
    import frontend.screen.activities.tabs.laps.*;
    import handler.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    import utils.*;
    
    use namespace mx_internal;
    
    public class ActivityMapTabView extends frontend.components.tabbarbase.TabLayoutGroup implements feathers.binding.IBindingClient
    {
        public function ActivityMapTabView()
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
            bindings = this._ActivityMapTabView_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_activities_tabs_map_ActivityMapTabViewWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return frontend.screen.activities.tabs.map.ActivityMapTabView[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.mxmlContent = [this._ActivityMapTabView_MapView1_i()];
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
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
            this._redrawFlag = true;
            return;
        }

        public override function showContent():void
        {
            this.mapView.touchable = true;
            this.mapView.showFocus();
            if (!this._redrawFlag) 
            {
                return;
            }
            this._redrawFlag = false;
            if (this.activity.entries.length == 0) 
            {
                this.mapView.showMap(this.activity.latitudeStartDefined ? this.activity.latitudeStart : 0, this.activity.longitudeStartDefined ? this.activity.longitudeStart : 0);
                this.mapView.showControls();
                return;
            }
            this._lapList = new feathers.data.ListCollection(this._activity.markerList.filter(filterLaps));
            this._autoLapList = new feathers.data.ListCollection(this._activity.markerList.filter(filterAutoLaps));
            var loc1:*=this.activity.entries[0].latitude;
            var loc2:*=this.activity.entries[0].longitude;
            var loc3:*=this.activity.entries[(this.activity.entries.length - 1)].latitude;
            var loc4:*=this.activity.entries[(this.activity.entries.length - 1)].longitude;
            this.mapView.showMap(loc1, loc2);
            this.mapView.showActivityTrack(this.activity.entries);
            this.mapView.showStartMarker(loc1, loc2);
            this.mapView.showEndMarker(loc3, loc4);
            this.mapView.showActivityMarkers(this.activity.markerList);
            this.mapView.showControls();
            return;
        }

        public override function hideContent():void
        {
            super.hideContent();
            if (this.mapView) 
            {
                this.mapView.touchable = false;
                this.mapView.hideFocus();
            }
            return;
        }

        internal function markerCalloutTouchCallback(arg1:core.marker.Marker):void
        {
            var loc1:*=null;
            if (!arg1) 
            {
                return;
            }
            if (arg1.type != core.general.MarkerType.LAP) 
            {
                if (arg1.type != core.general.MarkerType.AUTO_LAP) 
                {
                    return;
                }
                else 
                {
                    loc1 = this._autoLapList;
                }
            }
            else 
            {
                loc1 = this._lapList;
            }
            this.lapDetailsGroup = new frontend.screen.activities.tabs.laps.ActivityLapDetailsView();
            this.lapDetailsGroup.layoutData = new feathers.layout.AnchorLayoutData();
            this.lapDetailsGroup.markerList = loc1;
            this.lapDetailsGroup.lapCurrent = loc1.getItemIndex(arg1) + 1;
            addChild(this.lapDetailsGroup);
            handler.ViewHandler.getInstance().addBackFunction(this.closeLapDetails);
            return;
        }

        public function closeLapDetails():void
        {
            removeChild(this.lapDetailsGroup);
            this.lapDetailsGroup = null;
            return;
        }

        internal function _ActivityMapTabView_MapView1_i():frontend.components.map.MapView
        {
            var loc1:*=new frontend.components.map.MapView();
            loc1.showFocusButton = true;
            loc1.showLayerButton = true;
            loc1.showLockButton = true;
            loc1.id = "mapView";
            this.mapView = loc1;
            feathers.binding.BindingManager.executeBindings(this, "mapView", this.mapView);
            return loc1;
        }

        internal function _ActivityMapTabView_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight - frontend.components.tab.TabContainer.TAB_HEIGHT - frontend.screen.activities.ActivityView.SPORT_ROW_HEIGHT;
            }, null, "this.height")
            result[1] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.mapicon;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.icon")
            result[2] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ACTIVITIES.TABS.MAP.TITLE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.label")
            result[3] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return new feathers.layout.AnchorLayout();
            }, null, "this.layout")
            result[4] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appHeight - SIGMALink.headerHeight - frontend.components.tab.TabContainer.TAB_HEIGHT - frontend.screen.activities.ActivityView.SPORT_ROW_HEIGHT - SIGMALink.footerHeight;
            }, null, "mapView.height")
            result[5] = new feathers.binding.Binding(this, function ():Function
            {
                return markerCalloutTouchCallback;
            }, null, "mapView.markerCalloutTouchCallback")
            result[6] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "mapView.width")
            result[7] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.headerHeight + frontend.components.tab.TabContainer.TAB_HEIGHT;
            }, null, "mapView.yStartCorrection")
            return result;
        }

        public function get mapView():frontend.components.map.MapView
        {
            return this._836781601mapView;
        }

        public function set mapView(arg1:frontend.components.map.MapView):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._836781601mapView;
            if (loc1 !== arg1) 
            {
                this._836781601mapView = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "mapView", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
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

        internal static function filterLaps(arg1:core.marker.Marker, arg2:int, arg3:__AS3__.vec.Vector.<core.marker.Marker>):Boolean
        {
            return arg1.type == core.general.MarkerType.LAP;
        }

        internal static function filterAutoLaps(arg1:core.marker.Marker, arg2:int, arg3:__AS3__.vec.Vector.<core.marker.Marker>):Boolean
        {
            return arg1.type == core.general.MarkerType.AUTO_LAP;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            frontend.screen.activities.tabs.map.ActivityMapTabView._watcherSetupUtil = arg1;
            return;
        }

        internal static const PADDING:Number=10 * SIGMALink.scaleFactor;

        internal var _836781601mapView:frontend.components.map.MapView;

        internal var _activity:core.activities.Activity;

        internal var _autoLapList:feathers.data.ListCollection;

        internal var _lapList:feathers.data.ListCollection;

        internal var _redrawFlag:Boolean=true;

        internal var _655379712contentHeight:Number;

        internal var lapDetailsGroup:frontend.screen.activities.tabs.laps.ActivityLapDetailsView;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//  package phases
//    class ActivityPhaseFooterRenderer
package frontend.screen.activities.tabs.phases 
{
    import core.general.*;
    import feathers.controls.*;
    import feathers.controls.renderers.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import frontend.components.*;
    import starling.display.*;
    import utils.*;
    
    public class ActivityPhaseFooterRenderer extends feathers.controls.renderers.DefaultGroupedListHeaderOrFooterRenderer implements feathers.controls.renderers.IGroupedListHeaderOrFooterRenderer
    {
        public function ActivityPhaseFooterRenderer()
        {
            super();
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
            this.holderGroup.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            this.title = new feathers.controls.Label();
            this.title.text = utils.LanguageManager.getString("ACTIVITY_PHASE_PLAN_TITLE");
            this.title.layoutData = new feathers.layout.AnchorLayoutData(NaN, COL_WIDTH * 2 + PADDING, NaN, NaN, NaN, 0);
            this.holderGroup.addChild(this.title);
            this.plan1Icon = new frontend.components.TextureImage();
            this.holderGroup.addChild(this.plan1Icon);
            this.plan1ValueLabel = new feathers.controls.Label();
            this.plan1ValueLabel.layoutData = new feathers.layout.AnchorLayoutData(NaN, COL_WIDTH + PADDING, NaN, NaN, NaN, 0);
            this.plan1ValueLabel.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            this.holderGroup.addChild(this.plan1ValueLabel);
            this.plan1Unit = new feathers.controls.Label();
            this.plan1Unit.layoutData = new feathers.layout.AnchorLayoutData(NaN, COL_WIDTH, NaN, NaN, NaN, 0);
            this.plan1Unit.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_SMALLLISTLABEL;
            this.holderGroup.addChild(this.plan1Unit);
            this.plan2Icon = new frontend.components.TextureImage();
            this.holderGroup.addChild(this.plan2Icon);
            this.plan2ValueLabel = new feathers.controls.Label();
            this.plan2ValueLabel.layoutData = new feathers.layout.AnchorLayoutData(NaN, PADDING, NaN, NaN, NaN, 0);
            this.plan2ValueLabel.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            this.holderGroup.addChild(this.plan2ValueLabel);
            this.plan2Unit = new feathers.controls.Label();
            this.plan2Unit.layoutData = new feathers.layout.AnchorLayoutData(NaN, COL_WIDTH, NaN, NaN, NaN, 0);
            this.plan2Unit.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_SMALLLISTLABEL;
            this.holderGroup.addChild(this.plan2Unit);
            addChild(this.holderGroup);
            return;
        }

        protected override function commitData():void
        {
            if (!data) 
            {
                return;
            }
            var loc1:*=data as frontend.screen.activities.tabs.phases.ActivityPhaseListGroupFooter;
            this.plan1ValueLabel.text = loc1.plan1Value;
            this.plan1Unit.text = loc1.plan1Unit;
            this.plan2ValueLabel.text = loc1.plan2Value;
            this.plan2Unit.text = loc1.plan2Unit;
            if (loc1.plan1Icon != "") 
            {
                this.plan1ValueLabel.validate();
                this.plan1Icon.textureName = loc1.plan1Icon;
                this.plan1Icon.layoutData = new feathers.layout.AnchorLayoutData(NaN, COL_WIDTH + PADDING + this.plan1ValueLabel.width + ICON_GAP, NaN, NaN, NaN, 0);
            }
            if (loc1.plan2Icon != "") 
            {
                this.plan2ValueLabel.validate();
                this.plan2Icon.textureName = loc1.plan2Icon;
                this.plan2Icon.layoutData = new feathers.layout.AnchorLayoutData(NaN, PADDING + this.plan2ValueLabel.width + ICON_GAP, NaN, NaN, NaN, 0);
            }
            return;
        }

        
        {
            ICON_GAP = 10 * SIGMALink.scaleFactor;
            ROW_HEIGHT = 75 * SIGMALink.scaleFactor;
        }

        internal static const COL_WIDTH:Number=SIGMALink.appWidth / 3;

        internal static const PADDING:Number=17 * SIGMALink.scaleFactor;

        internal var holderGroup:feathers.controls.LayoutGroup;

        internal var plan1Icon:frontend.components.TextureImage;

        internal var plan1Unit:feathers.controls.Label;

        internal var plan1ValueLabel:feathers.controls.Label;

        internal var plan2Icon:frontend.components.TextureImage;

        internal var plan2Unit:feathers.controls.Label;

        internal var plan2ValueLabel:feathers.controls.Label;

        internal var title:feathers.controls.Label;

        internal static var ICON_GAP:Number;

        internal static var ROW_HEIGHT:Number;
    }
}


//    class ActivityPhaseItemRenderer
package frontend.screen.activities.tabs.phases 
{
    import backend.utils.*;
    import core.general.*;
    import core.marker.*;
    import feathers.controls.*;
    import feathers.controls.renderers.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import starling.display.*;
    import utils.*;
    
    public class ActivityPhaseItemRenderer extends feathers.controls.renderers.DefaultGroupedListItemRenderer
    {
        public function ActivityPhaseItemRenderer()
        {
            this._group = new feathers.controls.LayoutGroup();
            super();
            hasLabelTextRenderer = false;
            styleProvider = null;
            defaultSkin = new starling.display.Quad(SIGMALink.appWidth, ROW_HEIGHT, core.general.Colors.WHITE);
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            this._group.width = SIGMALink.appWidth;
            this._group.height = ROW_HEIGHT;
            this._group.layout = new feathers.layout.AnchorLayout();
            addChild(this._group);
            this._title = new feathers.controls.Label();
            this._title.layoutData = new feathers.layout.AnchorLayoutData(COL_PADDING, NaN, NaN, COL_PADDING);
            this._group.addChild(this._title);
            this._labelDuration = new feathers.controls.Label();
            this._labelDuration.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            this._labelDuration.layoutData = new feathers.layout.AnchorLayoutData(NaN, COL_WIDTH * 2 + COL_PADDING, NaN, NaN, NaN, 0);
            this._group.addChild(this._labelDuration);
            this._inZone = new feathers.controls.Label();
            this._inZone.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            this._inZone.layoutData = new feathers.layout.AnchorLayoutData(NaN, COL_WIDTH + COL_PADDING, NaN, NaN, NaN, 0);
            this._group.addChild(this._inZone);
            var loc1:*=ROW_HEIGHT / 3;
            this._avgPrefix = utils.LanguageManager.getString("AVG");
            this._avgHRPrefix = new feathers.controls.Label();
            this._avgHRPrefix.text = this._avgPrefix;
            this._avgHRPrefix.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_SMALLLISTLABEL;
            this._group.addChild(this._avgHRPrefix);
            this._avgHRPrefix.validate();
            var loc2:*=(loc1 - this._avgHRPrefix.height) / 2;
            this._avgHRPrefix.layoutData = new feathers.layout.AnchorLayoutData(loc2, COL_HR_WIDTH);
            this._minPrefix = utils.LanguageManager.getString("MIN");
            this._minHRPrefix = new feathers.controls.Label();
            this._minHRPrefix.text = this._minPrefix;
            this._minHRPrefix.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_SMALLLISTLABEL;
            this._minHRPrefix.layoutData = new feathers.layout.AnchorLayoutData(loc1 + loc2, COL_HR_WIDTH);
            this._group.addChild(this._minHRPrefix);
            this._maxPrefix = utils.LanguageManager.getString("MAX");
            this._maxHRPrefix = new feathers.controls.Label();
            this._maxHRPrefix.text = this._maxPrefix;
            this._maxHRPrefix.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_SMALLLISTLABEL;
            this._maxHRPrefix.layoutData = new feathers.layout.AnchorLayoutData(loc1 * 2 + loc2, COL_HR_WIDTH);
            this._group.addChild(this._maxHRPrefix);
            this._avgHR = new feathers.controls.Label();
            this._avgHR.text = "0";
            this._avgHR.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            this._group.addChild(this._avgHR);
            this._avgHR.validate();
            loc2 = (loc1 - this._avgHR.height) / 2;
            this._avgHR.layoutData = new feathers.layout.AnchorLayoutData(loc2, COL_PADDING);
            this._minHR = new feathers.controls.Label();
            this._minHR.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            this._minHR.layoutData = new feathers.layout.AnchorLayoutData(loc1 + loc2, COL_PADDING);
            this._group.addChild(this._minHR);
            this._maxHR = new feathers.controls.Label();
            this._maxHR.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            this._maxHR.layoutData = new feathers.layout.AnchorLayoutData(loc1 * 2 + loc2, COL_PADDING);
            this._group.addChild(this._maxHR);
            var loc3:*=new starling.display.Quad(SIGMALink.appWidth, 1, core.general.Colors.LIGHTGREY);
            addChild(loc3);
            return;
        }

        protected override function commitData():void
        {
            var loc1:*=null;
            super.commitData();
            if (!data) 
            {
                return;
            }
            if (data is core.marker.Marker) 
            {
                loc1 = data as core.marker.Marker;
                this._group.backgroundSkin = new starling.display.Quad(1, 1, !(loc1.type == core.general.MarkerType.INTERVAL_PHASE) && !(loc1.type == core.general.MarkerType.SIMPLE_PHASE) ? core.general.Colors.WHITE : core.general.Colors.brightenColor(core.general.Colors.LIGHTGREY, 75));
                this._title.text = loc1.type == core.general.MarkerType.INTERVAL_PHASE ? utils.LanguageManager.getString("ACTIVITY_INTERVAL_PHASE_SUMMERY") : loc1.title;
                this._labelDuration.text = backend.utils.DataUtils.timeFormatterHHMMSST.format(loc1.time);
                this._inZone.text = backend.utils.DataUtils.timeFormatterHHMMSST.format(loc1.timeInTargetZone);
                if (loc1.averageHeartrateDefined) 
                {
                    this._avgHRPrefix.text = this._avgPrefix;
                    this._avgHR.text = backend.utils.DataUtils.heartrateFormatter.format(loc1.averageHeartrate);
                }
                else 
                {
                    this._avgHRPrefix.text = "";
                    this._avgHR.text = "";
                }
                if (loc1.minimumHeartrateDefined) 
                {
                    this._minHRPrefix.text = this._minPrefix;
                    this._minHR.text = backend.utils.DataUtils.heartrateFormatter.format(loc1.minimumHeartrate);
                }
                else 
                {
                    this._minHRPrefix.text = "";
                    this._minHR.text = "";
                }
                if (loc1.maximumHeartrateDefined) 
                {
                    this._maxHRPrefix.text = this._maxPrefix;
                    this._maxHR.text = backend.utils.DataUtils.heartrateFormatter.format(loc1.maximumHeartrate);
                }
                else 
                {
                    this._maxHRPrefix.text = "";
                    this._maxHR.text = "";
                }
            }
            return;
        }

        public static const COL_PADDING:Number=20 * SIGMALink.scaleFactor;

        public static const COL_WIDTH:Number=(SIGMALink.appWidth - 4 * COL_PADDING) / 3;

        internal static const COL_HR_WIDTH:Number=85 * SIGMALink.scaleFactor;

        internal static const ROW_HEIGHT:Number=150 * SIGMALink.scaleFactor;

        internal var _avgHR:feathers.controls.Label;

        internal var _avgHRPrefix:feathers.controls.Label;

        internal var _avgPrefix:String;

        internal var _group:feathers.controls.LayoutGroup;

        internal var _inZone:feathers.controls.Label;

        internal var _labelDuration:feathers.controls.Label;

        internal var _maxHR:feathers.controls.Label;

        internal var _maxHRPrefix:feathers.controls.Label;

        internal var _maxPrefix:String;

        internal var _minHR:feathers.controls.Label;

        internal var _minHRPrefix:feathers.controls.Label;

        internal var _minPrefix:String;

        internal var _title:feathers.controls.Label;
    }
}


//    class ActivityPhaseListGroup
package frontend.screen.activities.tabs.phases 
{
    import backend.utils.*;
    import core.general.*;
    import core.marker.*;
    import debug.*;
    import frontend.*;
    
    public class ActivityPhaseListGroup extends Object
    {
        public function ActivityPhaseListGroup()
        {
            this.children = new Array();
            super();
            return;
        }

        public function addItem(arg1:core.marker.Marker):void
        {
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=null;
            if (arg1) 
            {
                loc2 = this.children.length;
                loc1 = 0;
                while (loc1 < loc2) 
                {
                    if ((this.children[loc1] as core.marker.Marker).markerId == arg1.markerId) 
                    {
                        return;
                    }
                    ++loc1;
                }
                this.children.push(arg1);
                debug.Debug.debug(arg1.type);
                if (arg1.type == core.general.MarkerType.INTERVAL_PHASE) 
                {
                    return;
                }
                this.footer = new frontend.screen.activities.tabs.phases.ActivityPhaseListGroupFooter();
                if (arg1.plannedDistanceDefined) 
                {
                    this.footer.plan1Icon = frontend.Textures.phaseDistanceIcon;
                    this.footer.plan1Value = backend.utils.DataUtils.distanceFormatter.format(backend.utils.DataUtils.distanceConverter.convert(arg1.plannedDistance));
                    this.footer.plan1Unit = backend.utils.DataUtils.unitStringDistance;
                }
                else if (arg1.plannedRecoveryDistanceDefined) 
                {
                    this.footer.plan1Icon = frontend.Textures.phaseDistanceIcon;
                    this.footer.plan1Value = backend.utils.DataUtils.distanceFormatter.format(backend.utils.DataUtils.distanceConverter.convert(arg1.plannedRecoveryDistance));
                    this.footer.plan1Unit = backend.utils.DataUtils.unitStringDistance;
                }
                else if (arg1.plannedTimeDefined) 
                {
                    this.footer.plan1Icon = frontend.Textures.phaseTimeIcon;
                    this.footer.plan1Value = backend.utils.DataUtils.timeFormatterHHMMSST.format(arg1.plannedTime);
                    this.footer.plan1Unit = backend.utils.DataUtils.unitStringTimeHours;
                }
                else if (arg1.plannedRecoveryTimeDefined) 
                {
                    this.footer.plan1Icon = frontend.Textures.phaseTimeIcon;
                    this.footer.plan1Value = backend.utils.DataUtils.timeFormatterHHMMSST.format(arg1.plannedRecoveryTime);
                    this.footer.plan1Unit = backend.utils.DataUtils.unitStringTimeHours;
                }
                else 
                {
                    this.footer.plan1Icon = "";
                    this.footer.plan1Value = "--:--";
                    this.footer.plan1Unit = "";
                }
                loc3 = "";
                if (arg1.plannedLowerLimitDefined || arg1.plannedUpperLimitDefined) 
                {
                    if (arg1.plannedLowerLimitDefined) 
                    {
                        loc3 = loc3 + arg1.plannedLowerLimit.toString();
                    }
                    if (arg1.plannedUpperLimitDefined) 
                    {
                        loc3 = loc3 + (loc3.length != 0 ? "-" + arg1.plannedUpperLimit.toString() : arg1.plannedUpperLimit.toString());
                    }
                }
                else 
                {
                    if (arg1.plannedRecoveryLowerLimitDefined) 
                    {
                        loc3 = loc3 + arg1.plannedRecoveryLowerLimit.toString();
                    }
                    if (arg1.plannedRecoveryUpperLimitDefined) 
                    {
                        loc3 = loc3 + (loc3.length != 0 ? "-" + arg1.plannedRecoveryUpperLimit.toString() : arg1.plannedRecoveryUpperLimit.toString());
                    }
                }
                if (loc3.length > 0) 
                {
                    this.footer.plan2Icon = frontend.Textures.phaseHeartrateIcon;
                    this.footer.plan2Value = loc3;
                }
            }
            return;
        }

        public var children:Array;

        public var footer:frontend.screen.activities.tabs.phases.ActivityPhaseListGroupFooter;
    }
}


//    class ActivityPhaseListGroupFooter
package frontend.screen.activities.tabs.phases 
{
    public class ActivityPhaseListGroupFooter extends Object
    {
        public function ActivityPhaseListGroupFooter()
        {
            super();
            return;
        }

        public var plan1Icon:String;

        public var plan1Unit:String;

        public var plan1Value:String;

        public var plan2Icon:String;

        public var plan2Unit:String;

        public var plan2Value:String;
    }
}


//    class ActivityPhasesTabView
package frontend.screen.activities.tabs.phases 
{
    import __AS3__.vec.*;
    import backend.utils.*;
    import core.activities.*;
    import core.general.*;
    import core.marker.*;
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
    import frontend.components.list.*;
    import frontend.components.tab.*;
    import frontend.components.tabbarbase.*;
    import frontend.screen.activities.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.display.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    import utils.*;
    import utils.sort.*;
    
    use namespace mx_internal;
    
    public class ActivityPhasesTabView extends frontend.components.tabbarbase.TabLayoutGroup implements feathers.binding.IBindingClient
    {
        public function ActivityPhasesTabView()
        {
            var bindings:Array;
            var watchers:Array;
            var target:Object;
            var i:uint;
            var watcherSetupUtilClass:Object;

            var loc1:*;
            target = null;
            watcherSetupUtilClass = null;
            this._1399580807listDataProvider = new feathers.data.HierarchicalCollection();
            this.mx_internal::_bindings = [];
            this.mx_internal::_watchers = [];
            this.mx_internal::_bindingsByDestination = {};
            this.mx_internal::_bindingsBeginWithWord = {};
            super();
            bindings = this._ActivityPhasesTabView_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_activities_tabs_phases_ActivityPhasesTabViewWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return frontend.screen.activities.tabs.phases.ActivityPhasesTabView[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.layout = this._ActivityPhasesTabView_AnchorLayout1_c();
            this.mxmlContent = [this._ActivityPhasesTabView_CustomGroupedList1_i(), this._ActivityPhasesTabView_LayoutGroup1_i()];
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        public function set phaselist(arg1:frontend.components.list.CustomGroupedList):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._425294695phaselist;
            if (loc1 !== arg1) 
            {
                this._425294695phaselist = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "phaselist", loc1, arg1, this);
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

        internal function get listDataProvider():feathers.data.HierarchicalCollection
        {
            return this._1399580807listDataProvider;
        }

        internal function set listDataProvider(arg1:feathers.data.HierarchicalCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1399580807listDataProvider;
            if (loc1 !== arg1) 
            {
                this._1399580807listDataProvider = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "listDataProvider", loc1, arg1, this);
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
            this._data = arg1 as core.activities.Activity;
            return;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            frontend.screen.activities.tabs.phases.ActivityPhasesTabView._watcherSetupUtil = arg1;
            return;
        }

        internal function itemRenderer():feathers.controls.renderers.IGroupedListItemRenderer
        {
            return new frontend.screen.activities.tabs.phases.ActivityPhaseItemRenderer();
        }

        internal function footerRendererFactory():feathers.controls.renderers.IGroupedListHeaderOrFooterRenderer
        {
            return new frontend.screen.activities.tabs.phases.ActivityPhaseFooterRenderer();
        }

        public override function showContent():void
        {
            var loc2:*=0;
            var loc4:*=null;
            this.listDataProvider = new feathers.data.HierarchicalCollection();
            var loc1:*=(this.data as core.activities.Activity).markerList;
            loc1.sort(this.sortOnTimeAbsolute);
            var loc3:*=loc1.length;
            var loc5:*=new frontend.screen.activities.tabs.phases.ActivityPhaseListGroup();
            loc2 = 0;
            while (loc2 < loc3) 
            {
                loc4 = loc1[loc2];
                if (!(loc4.type == core.general.MarkerType.LAP) && !(loc4.type == core.general.MarkerType.PAUSE) && !(loc4.type == core.general.MarkerType.AUTO_LAP)) 
                {
                    loc5 = new frontend.screen.activities.tabs.phases.ActivityPhaseListGroup();
                    this.listDataProvider.addItemAt(loc5, (this.listDataProvider.data as Array).length);
                    loc5.addItem(loc4);
                }
                ++loc2;
            }
            if (this.phaselist.dataProvider == null) 
            {
                this.phaselist.dataProvider = this.listDataProvider;
            }
            return;
        }

        internal function sortOnTimeAbsolute(arg1:core.marker.Marker, arg2:core.marker.Marker):Number
        {
            return utils.sort.SortUtil.sortOnNumber(arg1, arg2, core.marker.MarkerMapper.col_timeAbsolute, false);
        }

        public override function hideContent():void
        {
            this.listDataProvider = new feathers.data.HierarchicalCollection();
            return;
        }

        internal function _ActivityPhasesTabView_AnchorLayout1_c():feathers.layout.AnchorLayout
        {
            var loc1:*=new feathers.layout.AnchorLayout();
            return loc1;
        }

        internal function _ActivityPhasesTabView_CustomGroupedList1_i():frontend.components.list.CustomGroupedList
        {
            var loc1:*=new frontend.components.list.CustomGroupedList();
            loc1.headerRendererFactory = null;
            loc1.stickyHeader = false;
            loc1.id = "phaselist";
            this.phaselist = loc1;
            feathers.binding.BindingManager.executeBindings(this, "phaselist", this.phaselist);
            return loc1;
        }

        internal function _ActivityPhasesTabView_LayoutGroup1_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._ActivityPhasesTabView_AnchorLayout2_c();
            loc1.mxmlContent = [this._ActivityPhasesTabView_Label1_i(), this._ActivityPhasesTabView_Label2_i(), this._ActivityPhasesTabView_Label3_i()];
            loc1.id = "tableHeader";
            this.tableHeader = loc1;
            feathers.binding.BindingManager.executeBindings(this, "tableHeader", this.tableHeader);
            return loc1;
        }

        internal function _ActivityPhasesTabView_AnchorLayout2_c():feathers.layout.AnchorLayout
        {
            var loc1:*=new feathers.layout.AnchorLayout();
            return loc1;
        }

        internal function _ActivityPhasesTabView_Label1_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.wordWrap = false;
            loc1.id = "_ActivityPhasesTabView_Label1";
            this._ActivityPhasesTabView_Label1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ActivityPhasesTabView_Label1", this._ActivityPhasesTabView_Label1);
            return loc1;
        }

        internal function _ActivityPhasesTabView_Label2_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.wordWrap = false;
            loc1.id = "_ActivityPhasesTabView_Label2";
            this._ActivityPhasesTabView_Label2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ActivityPhasesTabView_Label2", this._ActivityPhasesTabView_Label2);
            return loc1;
        }

        internal function _ActivityPhasesTabView_Label3_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.wordWrap = false;
            loc1.id = "_ActivityPhasesTabView_Label3";
            this._ActivityPhasesTabView_Label3 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ActivityPhasesTabView_Label3", this._ActivityPhasesTabView_Label3);
            return loc1;
        }

        internal function _ActivityPhasesTabView_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.phasenicon;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.icon")
            result[1] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ACTIVITIES.TABS.PHASES.TITLE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.label")
            result[2] = new feathers.binding.Binding(this, function ():Function
            {
                return footerRendererFactory;
            }, null, "phaselist.footerRendererFactory")
            result[3] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight - frontend.components.tab.TabContainer.TAB_HEIGHT - frontend.screen.activities.ActivityView.SPORT_ROW_HEIGHT - PADDING_TOP - LIST_HEADER_HEIGHT;
            }, null, "phaselist.height")
            result[4] = new feathers.binding.Binding(this, function ():Function
            {
                return itemRenderer;
            }, null, "phaselist.itemRendererFactory")
            result[5] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(PADDING_TOP + LIST_HEADER_HEIGHT);
            }, null, "phaselist.layoutData")
            result[6] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "phaselist.width")
            result[7] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.DARKFONT);
            }, null, "tableHeader.backgroundSkin")
            result[8] = new feathers.binding.Binding(this, function ():Number
            {
                return LIST_HEADER_HEIGHT;
            }, null, "tableHeader.height")
            result[9] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(PADDING_TOP);
            }, null, "tableHeader.layoutData")
            result[10] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "tableHeader.width")
            result[11] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, frontend.screen.activities.tabs.phases.ActivityPhaseItemRenderer.COL_PADDING, NaN, 0);
            }, null, "_ActivityPhasesTabView_Label1.layoutData")
            result[12] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_WHITELABEL;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ActivityPhasesTabView_Label1.styleName")
            result[13] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ACTIVITY_PHASE_DURATION") + " [" + backend.utils.DataUtils.unitStringTimeHours + "]";
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ActivityPhasesTabView_Label1.text")
            result[14] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.screen.activities.tabs.phases.ActivityPhaseItemRenderer.COL_WIDTH;
            }, null, "_ActivityPhasesTabView_Label1.width")
            result[15] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(NaN, frontend.screen.activities.tabs.phases.ActivityPhaseItemRenderer.COL_PADDING + frontend.screen.activities.tabs.phases.ActivityPhaseItemRenderer.COL_WIDTH + frontend.screen.activities.tabs.phases.ActivityPhaseItemRenderer.COL_PADDING, NaN, NaN, NaN, 0);
            }, null, "_ActivityPhasesTabView_Label2.layoutData")
            result[16] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_WHITELABEL;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ActivityPhasesTabView_Label2.styleName")
            result[17] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ACTIVITY_PHASE_IN_ZONE") + " [" + backend.utils.DataUtils.unitStringTimeHours + "]";
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ActivityPhasesTabView_Label2.text")
            result[18] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.screen.activities.tabs.phases.ActivityPhaseItemRenderer.COL_WIDTH;
            }, null, "_ActivityPhasesTabView_Label2.width")
            result[19] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(NaN, frontend.screen.activities.tabs.phases.ActivityPhaseItemRenderer.COL_PADDING, NaN, NaN, NaN, 0);
            }, null, "_ActivityPhasesTabView_Label3.layoutData")
            result[20] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_WHITELABEL;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ActivityPhasesTabView_Label3.styleName")
            result[21] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ACTIVITY_PHASE_HEARTRATE") + " [" + backend.utils.DataUtils.unitStringHeartrate + "]";
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ActivityPhasesTabView_Label3.text")
            result[22] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.screen.activities.tabs.phases.ActivityPhaseItemRenderer.COL_WIDTH;
            }, null, "_ActivityPhasesTabView_Label3.width")
            return result;
        }

        public function get phaselist():frontend.components.list.CustomGroupedList
        {
            return this._425294695phaselist;
        }

        internal static const LIST_HEADER_HEIGHT:Number=53 * SIGMALink.scaleFactor;

        internal static const PADDING_TOP:Number=0 * SIGMALink.scaleFactor;

        public var _ActivityPhasesTabView_Label1:feathers.controls.Label;

        public var _ActivityPhasesTabView_Label2:feathers.controls.Label;

        public var _ActivityPhasesTabView_Label3:feathers.controls.Label;

        internal var _425294695phaselist:frontend.components.list.CustomGroupedList;

        internal var _65701893tableHeader:feathers.controls.LayoutGroup;

        internal var _data:Object;

        internal var _1399580807listDataProvider:feathers.data.HierarchicalCollection;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//  package values
//    package list
//      class ActivityValueDataProviderObject
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


//      class ActivityValueListFooterItemRenderer
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


//      class ActivityValueListHeaderItemRenderer
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


//      class ActivityValueListItemRenderer
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


//      class ActivityValuesGroup
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


//    class ActivityValuesTabView
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


