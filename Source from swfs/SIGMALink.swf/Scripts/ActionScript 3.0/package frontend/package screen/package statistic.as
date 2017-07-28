//package statistic
//  package tabs
//    class CustomShape
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


//    class StatisticChart
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


//    class StatisticTab2
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


//    class StatisticTabItem
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


//  package util
//    class StatisticUtil
package frontend.screen.statistic.util 
{
    import __AS3__.vec.*;
    import backend.utils.*;
    import core.*;
    import core.sport.*;
    import flash.utils.*;
    import frontend.components.charts.*;
    import handler.*;
    import statistic.*;
    import utils.converter.*;
    import utils.date.*;
    import utils.format.*;
    import utils.interfaces.*;
    import utils.sort.*;
    
    public class StatisticUtil extends Object
    {
        public function StatisticUtil()
        {
            super();
            return;
        }

        public static function generateDataProvider(arg1:Array, arg2:Date, arg3:String, arg4:String, arg5:String, arg6:String):__AS3__.vec.Vector.<frontend.components.charts.ColumnChartItem>
        {
            var loc1:*=null;
            var loc4:*=0;
            var loc5:*=0;
            var loc6:*=null;
            var loc7:*=null;
            var loc8:*=0;
            var loc9:*=null;
            var loc10:*=0;
            var loc11:*=0;
            var loc12:*=0;
            var loc13:*=null;
            var loc14:*=NaN;
            var loc16:*=null;
            var loc17:*=null;
            var loc18:*=null;
            loc1 = new flash.utils.Dictionary();
            var loc2:*=new Date(arg2.fullYear, 0, 1);
            var loc3:*=utils.date.CalendarUtil.calculateCalendarWeek(loc2);
            var loc19:*=arg3;
            switch (loc19) 
            {
                case statistic.Statistic.X_WEEK:
                {
                    loc5 = utils.date.CalendarUtil.calculateMaxCalendarWeek(loc2);
                    loc3 = utils.date.CalendarUtil.calculateCalendarWeek(loc2);
                    if (loc3 != 1) 
                    {
                        ++loc5;
                        loc2 = utils.date.CalendarUtil.calculateCalendarWeekMondayDate(loc3, (loc2.fullYear - 1));
                    }
                    break;
                }
                case statistic.Statistic.X_MONTH:
                {
                    loc5 = 12;
                    break;
                }
                case statistic.Statistic.X_YEAR:
                {
                    if (arg1.length != 0) 
                    {
                        loc4 = handler.ApplicationHandler.getInstance().yearsWithData[(handler.ApplicationHandler.getInstance().yearsWithData.length - 1)].data;
                    }
                    else 
                    {
                        loc4 = arg2.fullYear;
                    }
                    loc5 = arg2.fullYear - loc4 + 1;
                    loc2 = new Date(loc4, 0, 1);
                    break;
                }
            }
            loc8 = 0;
            while (loc8 < loc5) 
            {
                loc6 = new frontend.components.charts.ColumnChartItem();
                loc6.date = new Date(loc2.fullYear, loc2.month, loc2.date);
                loc12 = utils.date.CalendarUtil.calculateCalendarWeek(loc2);
                if (loc12 == 1 && loc6.date.month == 11) 
                {
                    loc10 = loc6.date.fullYear + 1;
                }
                else 
                {
                    loc10 = loc6.date.fullYear;
                }
                loc11 = loc6.date.month + 1;
                loc19 = arg3;
                switch (loc19) 
                {
                    case statistic.Statistic.X_WEEK:
                    {
                        loc6.label = loc12.toString();
                        loc6.sortField = validateSortKey([loc10, loc12], arg5);
                        loc6.xValue = loc10 + "_KW_" + (loc12 < 10 ? "0" + loc12 : loc12.toString());
                        loc2.setDate(loc2.getDate() + 7);
                        break;
                    }
                    case statistic.Statistic.X_MONTH:
                    {
                        loc6.label = backend.utils.DataUtils.monthLabelsShort[(loc11 - 1)];
                        loc6.sortField = validateSortKey([loc10, loc11], arg5);
                        loc6.xValue = loc10.toString() + "_" + (loc11 < 10 ? "0" + loc11 : loc11.toString());
                        loc2.setMonth(loc2.getMonth() + 1);
                        break;
                    }
                    case statistic.Statistic.X_YEAR:
                    {
                        loc6.label = loc10.toString();
                        loc6.sortField = validateSortKey([loc10], arg5);
                        loc6.xValue = loc10.toString();
                        loc2.setFullYear(loc2.getFullYear() + 1);
                        break;
                    }
                }
                loc6.xValue = loc6.xValue + ("_" + arg4);
                loc1[loc6.sortField] = loc6;
                ++loc8;
            }
            loc5 = arg1.length;
            loc8 = 0;
            while (loc8 < loc5) 
            {
                loc7 = arg1[loc8] as Object;
                loc14 = Number(loc7[statistic.Statistic.SUM_FIELD + arg4]);
                loc9 = utils.date.DateUtilCommon.dateFromMySqlFormat(loc7.startDate);
                loc10 = loc9.fullYear;
                loc11 = loc9.month + 1;
                loc12 = parseInt(loc7.week) + 1;
                if (arg3 != statistic.Statistic.X_WEEK) 
                {
                    if (arg3 != statistic.Statistic.X_MONTH) 
                    {
                        if (arg3 == statistic.Statistic.X_YEAR) 
                        {
                            loc4 = Math.min(loc4, loc10);
                            loc13 = validateSortKey([loc10], arg5);
                        }
                    }
                    else 
                    {
                        loc13 = validateSortKey([loc10, loc11], arg5);
                    }
                }
                else 
                {
                    loc13 = validateSortKey([parseInt(loc7.weekYear), loc12], arg5);
                }
                if (loc1[loc13]) 
                {
                    loc17 = handler.SportHandler.getInstance().resolveSportById(loc7.sportId);
                    loc18 = new frontend.components.charts.ColumnChartItemProps();
                    loc18.value = loc14;
                    loc18.sportsIndex = handler.SportHandler.getInstance().sports.indexOf(loc17);
                    loc18.sportId = loc17.sportId;
                    loc18.color = loc17.color;
                    loc6 = loc1[loc13] as frontend.components.charts.ColumnChartItem;
                    loc6.activityGUIDs = loc6.activityGUIDs.concat(String(loc7.GUIDs).split(","));
                    loc6.yValues.push(loc18);
                    loc6.ySum = loc6.ySum + loc14;
                    loc1[loc13] = loc6;
                }
                ++loc8;
            }
            var loc15:*=new Vector.<frontend.components.charts.ColumnChartItem>();
            loc19 = 0;
            var loc20:*=loc1;
            for (loc16 in loc20) 
            {
                loc6 = loc1[loc16] as frontend.components.charts.ColumnChartItem;
                if (arg6 == statistic.Statistic.DISPLAY_ONLY_DATA && loc6.yValues.length == 0) 
                {
                    continue;
                }
                if (arg3 == statistic.Statistic.X_YEAR && loc6.date.fullYear < loc4) 
                {
                    continue;
                }
                if (arg6 == statistic.Statistic.DISPLAY_UNTIL_TODAY && loc6.date.time > arg2.time) 
                {
                    continue;
                }
                loc15.push(loc6);
            }
            loc15.sort(sortOnSortField);
            return loc15;
        }

        internal static function sortOnSortField(arg1:frontend.components.charts.ColumnChartItem, arg2:frontend.components.charts.ColumnChartItem):Number
        {
            return utils.sort.SortUtil.sortOnString(arg1, arg2, "sortField", false);
        }

        public static function validateSortKey(arg1:Array, arg2:String):String
        {
            var loc2:*=0;
            var loc1:*=[];
            var loc3:*=arg1.length;
            var loc4:*=NaN;
            loc2 = 0;
            while (loc2 < loc3) 
            {
                loc4 = arg1[loc2];
                if (!isNaN(loc4)) 
                {
                    if (loc4 < 10) 
                    {
                        loc1.push("00" + loc4);
                    }
                    else if (loc4 < 100) 
                    {
                        loc1.push("0" + loc4);
                    }
                    else 
                    {
                        loc1.push(loc4.toString());
                    }
                }
                ++loc2;
            }
            return loc1.join("_") + (arg2 != statistic.Statistic.SEPARATION_SPORT ? "" : "_sport");
        }

        public static function calculateVerticalAxisProperties(arg1:__AS3__.vec.Vector.<frontend.components.charts.ColumnChartItem>, arg2:String, arg3:String):Array
        {
            var loc2:*=0;
            var loc4:*=null;
            var loc9:*=NaN;
            var loc10:*=NaN;
            var loc1:*=0;
            var loc3:*=arg1.length;
            loc2 = 0;
            while (loc2 < loc3) 
            {
                loc4 = arg1[loc2];
                if (loc4.yValues.length > 0) 
                {
                    loc1 = Math.max(loc1, loc4.ySum);
                }
                ++loc2;
            }
            var loc5:*=0;
            var loc6:*=0;
            var loc11:*=arg2;
            switch (loc11) 
            {
                case statistic.Statistic.TRAININGS:
                {
                    loc5 = 1;
                    loc6 = 1;
                    break;
                }
                case statistic.Statistic.TRAINING_TIME:
                {
                    loc5 = 180000;
                    loc6 = 180;
                    break;
                }
                case statistic.Statistic.DISTANCE:
                {
                    if (core.MeasurementConfig.distanceFormat != utils.format.DistanceFormat.KILOMETER) 
                    {
                        loc5 = 1000 * 1.609344;
                    }
                    else 
                    {
                        loc5 = 1000;
                    }
                    loc6 = 5;
                    break;
                }
                case statistic.Statistic.ALTITUDE_DOWNHILL:
                case statistic.Statistic.ALTITUDE_UPHILL:
                {
                    loc5 = 100000;
                    loc6 = 5;
                    break;
                }
                case statistic.Statistic.CALORIES:
                {
                    loc5 = 300;
                    loc6 = 5;
                    break;
                }
                case statistic.Statistic.STEPS:
                {
                    loc5 = 2000;
                    loc6 = 2;
                    break;
                }
            }
            if (loc1 == 0) 
            {
                loc1 = loc5;
            }
            var loc7:*=Math.ceil(loc1);
            var loc8:*=false;
            do 
            {
                loc9 = loc1 % loc6;
                loc10 = loc1 - loc9 + loc6;
                if (loc10 / loc6 >= 10) 
                {
                    loc6 = loc6 * 10;
                    loc8 = true;
                }
                else 
                {
                    loc7 = loc10;
                    loc8 = false;
                }
            }
            while (loc8);
            return [loc7, loc6];
        }

        public static function getUnitString(arg1:String):String
        {
            var loc1:*=arg1;
            switch (loc1) 
            {
                case statistic.Statistic.TRAININGS:
                case statistic.Statistic.STEPS:
                {
                    return "";
                }
                case statistic.Statistic.TRAINING_TIME:
                {
                    return backend.utils.DataUtils.unitStringTimeHours;
                }
                case statistic.Statistic.CALORIES:
                {
                    return backend.utils.DataUtils.unitStringCalories;
                }
                case statistic.Statistic.DISTANCE:
                {
                    return backend.utils.DataUtils.unitStringDistance;
                }
                case statistic.Statistic.ALTITUDE_DOWNHILL:
                case statistic.Statistic.ALTITUDE_UPHILL:
                {
                    return backend.utils.DataUtils.unitStringAltitude;
                }
            }
            return "";
        }

        public static function getConverter(arg1:String):utils.converter.IConverter
        {
            var loc1:*=arg1;
            switch (loc1) 
            {
                case statistic.Statistic.TRAININGS:
                case statistic.Statistic.TRAINING_TIME:
                case statistic.Statistic.STEPS:
                case statistic.Statistic.CALORIES:
                {
                    return null;
                }
                case statistic.Statistic.DISTANCE:
                {
                    return backend.utils.DataUtils.distanceConverter;
                }
                case statistic.Statistic.ALTITUDE_DOWNHILL:
                case statistic.Statistic.ALTITUDE_UPHILL:
                {
                    return backend.utils.DataUtils.altitudeConverter;
                }
            }
            return null;
        }

        public static function getFormatter(arg1:String):utils.interfaces.ICustomFormatterBase
        {
            var loc1:*=arg1;
            switch (loc1) 
            {
                case statistic.Statistic.TRAININGS:
                case statistic.Statistic.STEPS:
                {
                    return null;
                }
                case statistic.Statistic.TRAINING_TIME:
                {
                    return backend.utils.DataUtils.timeFormatter;
                }
                case statistic.Statistic.CALORIES:
                {
                    return backend.utils.DataUtils.caloriesFormatter;
                }
                case statistic.Statistic.DISTANCE:
                {
                    return backend.utils.DataUtils.distanceFormatter;
                }
                case statistic.Statistic.ALTITUDE_DOWNHILL:
                case statistic.Statistic.ALTITUDE_UPHILL:
                {
                    return backend.utils.DataUtils.altitudeFormatter;
                }
            }
            return null;
        }
    }
}


//  class Statistics
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


