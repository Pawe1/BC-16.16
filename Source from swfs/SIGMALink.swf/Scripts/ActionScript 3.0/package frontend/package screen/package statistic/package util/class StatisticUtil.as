//class StatisticUtil
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


