//class StatisticTab2
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


