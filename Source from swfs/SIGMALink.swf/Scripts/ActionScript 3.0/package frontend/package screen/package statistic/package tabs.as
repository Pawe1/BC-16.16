//package tabs
//  class CustomShape
package frontend.screen.statistic.tabs 
{
    import frontend.components.charts.*;
    
    public class CustomShape extends Object
    {
        public function CustomShape()
        {
            super();
            return;
        }

        public var chartItem:frontend.components.charts.ColumnChartItem;

        public var color:uint;

        public var heightFrom:Number;

        public var heightTo:Number;

        public var id:String;

        public var label:String="";

        public var showLabel:Boolean=true;

        public var widthFrom:Number;

        public var widthTo:Number;

        public var xFrom:Number;

        public var xTo:Number;

        public var yFrom:Number;

        public var yTo:Number;
    }
}


//  class StatisticChart
package frontend.screen.statistic.tabs 
{
    import debug.*;
    import feathers.controls.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import flash.events.*;
    import flash.utils.*;
    import frontend.components.charts.*;
    
    public class StatisticChart extends feathers.controls.LayoutGroup
    {
        public function StatisticChart(arg1:Boolean=false)
        {
            super();
            this._showLoadingLabel = arg1;
            this._layoutGroup = new feathers.controls.LayoutGroup();
            this._layoutGroup.width = SIGMALink.appWidth;
            this._layoutGroup.height = height;
            this._layoutGroup.layout = new feathers.layout.AnchorLayout();
            addChild(this._layoutGroup);
            this._headerTitle = new feathers.controls.Label();
            this._headerTitle.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_DARKLABEL;
            this._headerTitle.text = " ";
            this._headerTitle.layoutData = new feathers.layout.AnchorLayoutData(HEADER_PADDING, NaN, NaN, HEADER_PADDING);
            this._layoutGroup.addChild(this._headerTitle);
            this._headerTitle.validate();
            var loc1:*;
            this._headerHeight = loc1 = this._headerTitle.height + 2 * HEADER_PADDING;
            frontend.components.charts.ColumnChartList.HEADER_HEIGHT = loc1;
            this._headerMaxYValueLabel = new feathers.controls.Label();
            this._headerMaxYValueLabel.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_SMALLLISTLABEL;
            this._headerMaxYValueLabel.layoutData = new feathers.layout.AnchorLayoutData(HEADER_PADDING, HEADER_PADDING, NaN, NaN);
            this._layoutGroup.addChild(this._headerMaxYValueLabel);
            this._chartIndex = this._layoutGroup.numChildren;
            this._scaleTimer = new flash.utils.Timer(100, 1);
            return;
        }

        public function drawChart():void
        {
            if (!this.item) 
            {
                return;
            }
            debug.Debug.debug("drawChart - " + this.item.title + ", " + this.item.type);
            if (this._chart) 
            {
                this._chart.item = this.item;
            }
            else 
            {
                this._chart = new frontend.components.charts.ColumnChartList();
                this._chart.alpha = 1;
                this._chart.dropLabels = this.dropLabels;
                this._chart.parentHeight = height;
                this._chart.item = this.item;
                this._layoutGroup.addChildAt(this._chart, this._chartIndex);
            }
            this.updateHiddenFlag();
            return;
        }

        internal function updateHiddenFlag():void
        {
            debug.Debug.debug("updateHiddenFlag => item.dataChanged: " + this.item.dataChanged.toString());
            if (this._scaleTimer) 
            {
                this._scaleTimer.removeEventListener(flash.events.TimerEvent.TIMER, this._chart.scaleIn);
                this._scaleTimer.reset();
            }
            if (this.item.dataChanged) 
            {
                this._chart.validateItem();
                this.item.dataChanged = false;
            }
            if (this.item.hidden) 
            {
                this._chart.scaleOut();
            }
            else 
            {
                this._scaleTimer.addEventListener(flash.events.TimerEvent.TIMER, this._chart.scaleIn);
                this._scaleTimer.start();
            }
            this.updateHeader();
            return;
        }

        internal function updateHeader():void
        {
            var loc1:*=this.item.converter ? this.item.converter.convert(this.item.yMax) : this.item.yMax;
            this._headerTitle.text = this.item.title;
            this._headerMaxYValueLabel.text = this.item.formatter ? this.item.formatter.format(loc1) : loc1.toString();
            return;
        }

        public static const HEADER_PADDING:Number=12 * SIGMALink.scaleFactor;

        public var dropLabels:Boolean=true;

        public var item:frontend.screen.statistic.tabs.StatisticTabItem;

        internal var _chart:frontend.components.charts.ColumnChartList;

        internal var _chartIndex:int=0;

        internal var _headerHeight:Number;

        internal var _headerMaxYValueLabel:feathers.controls.Label;

        internal var _headerTitle:feathers.controls.Label;

        internal var _layoutGroup:feathers.controls.LayoutGroup;

        internal var _scaleTimer:flash.utils.Timer;

        internal var _showLoadingLabel:Boolean=false;
    }
}


//  class StatisticTab2
package frontend.screen.statistic.tabs 
{
    import __AS3__.vec.*;
    import backend.utils.dbUtils.*;
    import configCache.*;
    import debug.*;
    import flash.data.*;
    import flash.utils.*;
    import frontend.components.tabbarbase.*;
    import frontend.screen.statistic.util.*;
    import handler.*;
    import starling.events.*;
    import statistic.*;
    import utils.date.*;
    
    public class StatisticTab2 extends frontend.components.tabbarbase.TabLayoutScroller
    {
        public function StatisticTab2(arg1:String, arg2:String, arg3:Function, arg4:Function)
        {
            this._itemsDic = new flash.utils.Dictionary();
            super();
            label = arg1;
            this.type = arg2;
            this._startLoadingCallback = arg3;
            this._stopLoadingCallback = arg4;
            return;
        }

        public function loadStatistic():void
        {
            if (this.type != statistic.Statistic.X_YEAR) 
            {
                _selectedYear = configCache.ConfigCache.getInstance().getValue(configCache.ConfigCacheObject.STATISTIC_SELECTED_YEAR, new Date().fullYear);
            }
            else 
            {
                _selectedYear = new Date().fullYear;
            }
            if (this._startLoadingCallback != null) 
            {
                this._startLoadingCallback();
            }
            debug.Debug.debug("load statistic, " + _selectedYear + ", type: " + this.type);
            statistic.Statistic.useTmpUserAndSport = true;
            statistic.Statistic.tmpSports = handler.SportHandler.getInstance().getSportIds([16]);
            statistic.Statistic.tmpUsers = null;
            this.today = new Date(_selectedYear, 0, 1);
            this.today.setHours(23, 59, 59);
            var loc1:*=statistic.Statistic.getGraphStatisticStatement(this.today.fullYear, this.today.month, utils.date.CalendarUtil.calculateCalendarWeek(this.today), this.type, statistic.Statistic.TRAININGS, this._currentSeparation, this._currentDisplayMode, 2000, _selectedYear).text;
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, loc1, this.onStatisticComplte, this.onStatisticError, Workers.worker_DatabaseWorker, statistic.Statistic.TRAININGS);
            return;
        }

        internal function onStatisticError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("onStatisticError");
            return;
        }

        internal function onStatisticComplte(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            this._currentYField = arg1.data.data as String;
            this.loadedYear = _selectedYear;
            this.showCharts(arg1.getResult());
            dispatchEvent(new starling.events.Event(COMPLETE));
            return;
        }

        internal function showCharts(arg1:Array):void
        {
            var loc1:*=0;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=null;
            var loc7:*=null;
            var loc8:*=null;
            var loc9:*=null;
            var loc2:*=statistic.Statistic.VALUES.length;
            this.today = new Date(_selectedYear, 0, 1);
            this.today.setHours(23, 59, 59);
            loc1 = 0;
            while (loc1 < loc2) 
            {
                if (statistic.Statistic.VALUES[loc1].value != statistic.Statistic.STEPS) 
                {
                    this._currentYField = statistic.Statistic.VALUES[loc1].value;
                    loc3 = frontend.screen.statistic.util.StatisticUtil.generateDataProvider(arg1, this.today, this.type, this._currentYField, this._currentSeparation, this._currentDisplayMode);
                    loc4 = frontend.screen.statistic.util.StatisticUtil.calculateVerticalAxisProperties(loc3, this._currentYField, this._currentSeparation);
                    loc5 = statistic.Statistic.getLabel(this._currentYField);
                    loc6 = frontend.screen.statistic.util.StatisticUtil.getUnitString(this._currentYField);
                    if (loc6 != "") 
                    {
                        loc5 = loc5 + (" [" + loc6 + "]");
                    }
                    loc9 = this._currentYField + this.type;
                    if (this._itemsDic[loc9]) 
                    {
                        loc8 = this._itemsDic[loc9] as frontend.screen.statistic.tabs.StatisticChart;
                        loc7 = loc8.item;
                    }
                    else 
                    {
                        loc7 = new frontend.screen.statistic.tabs.StatisticTabItem();
                        loc7.type = this.type;
                        loc7.title = loc5;
                        loc7.converter = frontend.screen.statistic.util.StatisticUtil.getConverter(this._currentYField);
                        loc7.formatter = frontend.screen.statistic.util.StatisticUtil.getFormatter(this._currentYField);
                    }
                    loc7.updateDataProvider(loc3);
                    loc7.maxVisibleColumns = Math.min(12, loc3.length);
                    loc7.yMax = loc4[0];
                    loc7.yInterval = loc4[1];
                    if (!this._itemsDic[loc9]) 
                    {
                        loc8 = new frontend.screen.statistic.tabs.StatisticChart(loc1 == 0);
                        loc8.dropLabels = this.type == statistic.Statistic.X_WEEK;
                        loc8.height = height / 3;
                        addChild(loc8);
                    }
                    loc8.drawChart();
                    loc8.item = loc7;
                    this._itemsDic[loc9] = loc8;
                }
                ++loc1;
            }
            if (this._stopLoadingCallback != null) 
            {
                this._stopLoadingCallback();
            }
            return;
        }

        public static function resetAllFlags(arg1:flash.utils.Dictionary):void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=arg1;
            for each (loc1 in loc3) 
            {
                setHiddenFlag(loc1, true);
            }
            return;
        }

        public static function setHiddenFlag(arg1:frontend.screen.statistic.tabs.StatisticTab2, arg2:Boolean):void
        {
            var loc1:*=0;
            var loc3:*=null;
            debug.Debug.debug("setHiddenFlag: " + arg1.label + ", " + arg2);
            var loc2:*=arg1.numChildren;
            loc1 = 0;
            while (loc1 < loc2) 
            {
                loc3 = arg1.getChildAt(loc1) as frontend.screen.statistic.tabs.StatisticChart;
                if (loc3 && !(loc3.item.hidden == arg2)) 
                {
                    loc3.item.hidden = arg2;
                    loc3.drawChart();
                }
                ++loc1;
            }
            return;
        }

        
        {
            COMPLETE = "statisticTabComplete";
            _currentPageIndex = 0;
            _currentVScrollPosition = 0;
            _lists = new Array();
            _selectedYear = 0;
            loadTimeout = 0;
        }

        public var loadedYear:int=0;

        public var type:String="week";

        internal var _currentDisplayMode:String="all";

        internal var _currentSeparation:String="sport";

        internal var _currentYField:String="statistic";

        internal var _itemsDic:flash.utils.Dictionary;

        internal var _startLoadingCallback:Function;

        internal var _stopLoadingCallback:Function;

        internal var today:Date;

        public static var COMPLETE:String="statisticTabComplete";

        internal static var _currentPageIndex:int=0;

        internal static var _currentVScrollPosition:Number=0;

        internal static var _lists:Array;

        internal static var _selectedYear:int=0;

        internal static var loadTimeout:uint=0;
    }
}


//  class StatisticTabItem
package frontend.screen.statistic.tabs 
{
    import __AS3__.vec.*;
    import debug.*;
    import feathers.data.*;
    import frontend.components.charts.*;
    import utils.converter.*;
    import utils.interfaces.*;
    
    public class StatisticTabItem extends Object
    {
        public function StatisticTabItem(arg1:Boolean=false)
        {
            this._dataProvider = new feathers.data.ListCollection();
            super();
            if (arg1) 
            {
                this.title = "typicalItemTitle";
                this.yMax = 10;
                this.dataProvider = new feathers.data.ListCollection();
                this.converter = null;
                this.formatter = null;
                this.yInterval = 5;
                this.maxVisibleColumns = 53;
                this.scrollHandler = null;
                this.zoomHandler = null;
            }
            return;
        }

        public function get dataProvider():feathers.data.ListCollection
        {
            return this._dataProvider;
        }

        public function set dataProvider(arg1:feathers.data.ListCollection):void
        {
            this._dataProvider = arg1;
            this.dataChanged = true;
            return;
        }

        public function get hidden():Boolean
        {
            return this._hidden;
        }

        public function set hidden(arg1:Boolean):void
        {
            this._hidden = arg1;
            this.dataChanged = true;
            return;
        }

        public function updateDataProvider(arg1:__AS3__.vec.Vector.<frontend.components.charts.ColumnChartItem>):void
        {
            if (isEqual(arg1, this.dataProvider.data as Vector.<frontend.components.charts.ColumnChartItem>)) 
            {
                debug.Debug.debug("same dp - " + this.title);
            }
            else 
            {
                debug.Debug.debug("new dp - " + this.title);
                this.dataProvider = new feathers.data.ListCollection(arg1);
            }
            return;
        }

        internal static function isEqual(arg1:__AS3__.vec.Vector.<frontend.components.charts.ColumnChartItem>, arg2:__AS3__.vec.Vector.<frontend.components.charts.ColumnChartItem>):Boolean
        {
            var loc1:*=0;
            if (!arg2) 
            {
                return false;
            }
            if (arg1.length != arg2.length) 
            {
                return false;
            }
            var loc2:*=arg1.length;
            loc1 = 0;
            while (loc1 < loc2) 
            {
                if (arg1[loc1].ySum != arg2[loc1].ySum) 
                {
                    return false;
                }
                ++loc1;
            }
            return true;
        }

        public var converter:utils.converter.IConverter;

        public var dataChanged:Boolean=true;

        internal var _dataProvider:feathers.data.ListCollection;

        public var formatter:utils.interfaces.ICustomFormatterBase;

        internal var _hidden:Boolean=true;

        public var landscapeCloseHandler:Function;

        public var maxVisibleColumns:Number;

        public var scrollHandler:Function;

        public var title:String;

        public var type:String;

        public var yInterval:Number;

        public var yMax:Number;

        public var zoomHandler:Function;
    }
}


