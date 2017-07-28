//package statistic
//  class Statistic
package statistic 
{
    import __AS3__.vec.*;
    import configCache.*;
    import core.*;
    import flash.events.*;
    import handler.*;
    import mx.events.*;
    import utils.*;
    import utils.date.*;
    import utils.formatter.*;
    
    public class Statistic extends flash.events.EventDispatcher
    {
        public function Statistic(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            init();
            return;
        }

        internal static function getYear(arg1:String, arg2:String="_total", arg3:String="key"):String
        {
            return "strftime(\'%Y_" + arg1 + arg2 + "\', startDate) as " + arg3;
        }

        internal static function getYearDay(arg1:String, arg2:String="_total", arg3:String="key"):String
        {
            return "strftime(\'%Y_%j_" + arg1 + arg2 + "\', startDate) as " + arg3;
        }

        internal static function getYearWeek(arg1:String, arg2:String="_total", arg3:String="key"):String
        {
            return "(" + getWeekYearByConfig() + " || \'_KW_\' || " + getWeekByConfig() + " || \'_" + arg1 + arg2 + "\') as " + arg3;
        }

        internal static function getYearWeekDay(arg1:String, arg2:String="_total", arg3:String="key"):String
        {
            return "(" + getWeekYearByConfig() + " || \'_KW_\' || " + getWeekByConfig() + " || \'_\' || strftime(\'%Y\',startDate) || strftime(\'%j\',startDate) || \'_" + arg1 + arg2 + "\') as " + arg3;
        }

        internal static function getYearMonth(arg1:String, arg2:String="_total", arg3:String="key"):String
        {
            return "strftime(\'%Y_%m_" + arg1 + arg2 + "\', startDate) as " + arg3;
        }

        internal static function getYearMonthDate(arg1:String, arg2:String="_total", arg3:String="key"):String
        {
            return "strftime(\'%Y_%m_%d_" + arg1 + arg2 + "\', startDate) as " + arg3;
        }

        internal static function getCommonStatisticConditions():String
        {
            var loc2:*=configCache.ConfigCache.getInstance().configCacheObject.selectedSportIds().concat();
            if (useTmpUserAndSport) 
            {
                loc2 = tmpSports;
            }
            if (loc2 && loc2.length == 0) 
            {
                loc2.push(0);
            }
            var loc3:*=configCache.ConfigCache.getInstance().configCacheObject.selectedUserIds().concat();
            if (useTmpUserAndSport) 
            {
                loc3 = tmpUsers;
            }
            useTmpUserAndSport = false;
            if (loc3 && loc3.length == 0) 
            {
                loc3.push(0);
            }
            var loc1:*="statistic = true ";
            if (loc2) 
            {
                loc1 = loc1 + ("and sportId in (" + loc2.join(",") + ") ");
            }
            if (loc3) 
            {
                loc1 = loc1 + ("and userId in (" + loc3.join(",") + ") ");
            }
            loc1 = loc1 + "and isDeleted = false";
            return loc1;
        }

        internal static function setCommonStatisticFields(arg1:Array):void
        {
            arg1.push(getWeek());
            arg1.push(getWeekYear());
            arg1.push("count(GUID) as sum_statistic");
            arg1.push("GROUP_CONCAT(GUID) as GUIDs");
            arg1.push("min(strftime(\'%Y/%m/%d\', startDate)) as startDate");
            arg1.push("sportId");
            return;
        }

        internal static function buildSelectStatement(arg1:Date, arg2:Date, arg3:Array, arg4:String="key", arg5:String="key", arg6:String=""):String
        {
            var loc1:*=handler.FilterHandler.getInstance().selectedFilterGUID;
            handler.FilterHandler.tmpFilter = handler.FilterHandler.getInstance().getFilter(loc1);
            var loc2:*="SELECT " + arg3.join(", ") + " " + "from Activity " + handler.FilterHandler.getInstance().getfilterSQL(arg1, arg2) + "and " + getCommonStatisticConditions();
            if (arg6 != "") 
            {
                loc2 = loc2 + (" and " + arg6);
            }
            if (arg4 != "") 
            {
                loc2 = loc2 + (" group by " + arg4);
            }
            if (arg5 != "") 
            {
                loc2 = loc2 + (" order by " + arg5);
            }
            return loc2;
        }

        public static function get staticEventDispatcher():flash.events.IEventDispatcher
        {
            return Statistic._bindingEventDispatcher;
        }

        public static function get DISPLAY_MODES():__AS3__.vec.Vector.<Object>
        {
            return Statistic.DISPLAY_MODES;
        }

        public static function set DISPLAY_MODES(arg1:__AS3__.vec.Vector.<Object>):void
        {
            var loc1:*=Statistic.DISPLAY_MODES;
            if (loc1 !== arg1) 
            {
                Statistic.DISPLAY_MODES = arg1;
                if (Statistic._bindingEventDispatcher.hasEventListener("propertyChange")) 
                {
                    Statistic._bindingEventDispatcher.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(Statistic, "DISPLAY_MODES", loc1, arg1));
                }
            }
            return;
        }

        
        {
            Statistic._bindingEventDispatcher = new flash.events.EventDispatcher();
        }

        internal static function getWeekYear(arg1:String="weekYear"):String
        {
            return getWeekYearByConfig() + (arg1 == " " ? "" : " as " + arg1);
        }

        public static function get VALUES_CALENDAR():__AS3__.vec.Vector.<Object>
        {
            return Statistic.VALUES_CALENDAR;
        }

        public static function set VALUES_CALENDAR(arg1:__AS3__.vec.Vector.<Object>):void
        {
            var loc1:*=Statistic.VALUES_CALENDAR;
            if (loc1 !== arg1) 
            {
                Statistic.VALUES_CALENDAR = arg1;
                if (Statistic._bindingEventDispatcher.hasEventListener("propertyChange")) 
                {
                    Statistic._bindingEventDispatcher.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(Statistic, "VALUES_CALENDAR", loc1, arg1));
                }
            }
            return;
        }

        public static function getInstance():statistic.Statistic
        {
            if (_instance == null) 
            {
                _instance = new Statistic();
            }
            return _instance;
        }

        public static function init():void
        {
            new __AS3__.vec.Vector.<Object>(7)[0] = {"label":utils.LanguageManager.getString("STATISTIC_VALUES_TRAININGS"), "value":"statistic", "valueDefined":"statisticDefined", "iconSource":"TrainingsDataIcon"};
            new __AS3__.vec.Vector.<Object>(7)[1] = {"label":utils.LanguageManager.getString("STATISTIC_VALUES_DISTANCE"), "value":"distance", "valueDefined":"distanceDefined", "iconSource":"DistanceDataIcon"};
            new __AS3__.vec.Vector.<Object>(7)[2] = {"label":utils.LanguageManager.getString("STATISTIC_VALUES_TRAINING_TIME"), "value":"trainingTime", "valueDefined":"trainingTimeDefined", "iconSource":"TrainingTimeDataIcon"};
            new __AS3__.vec.Vector.<Object>(7)[3] = {"label":utils.LanguageManager.getString("STATISTIC_VALUES_ALTI_UP"), "value":"altitudeDifferencesUphill", "valueDefined":"altitudeDifferencesUphillDefined", "iconSource":"AltitudeDataIcon"};
            new __AS3__.vec.Vector.<Object>(7)[4] = {"label":utils.LanguageManager.getString("STATISTIC_VALUES_ALTI_DOWN"), "value":"altitudeDifferencesDownhill", "valueDefined":"altitudeDifferencesDownhillDefined", "iconSource":"AltitudeDataIcon"};
            new __AS3__.vec.Vector.<Object>(7)[5] = {"label":utils.LanguageManager.getString("STATISTIC_VALUES_CALORIES"), "value":"calories", "valueDefined":"caloriesDefined", "iconSource":"CaloriesDataIcon"};
            new __AS3__.vec.Vector.<Object>(7)[6] = {"label":utils.LanguageManager.getString("STATISTIC_VALUES_STEPS"), "value":"steps", "valueDefined":"stepsDefined", "iconSource":"StepsDataIcon"};
            VALUES = new __AS3__.vec.Vector.<Object>(7);
            new __AS3__.vec.Vector.<Object>(5)[0] = {"label":utils.LanguageManager.getString("TOP_VALUES.TILE_DISTANCE"), "value":"distance"};
            new __AS3__.vec.Vector.<Object>(5)[1] = {"label":utils.LanguageManager.getString("TOP_VALUES.TILE_TRAINING_TIME"), "value":"trainingTime"};
            new __AS3__.vec.Vector.<Object>(5)[2] = {"label":utils.LanguageManager.getString("TOP_VALUES.TILE_MAX_SPEED"), "value":"maximumSpeed"};
            new __AS3__.vec.Vector.<Object>(5)[3] = {"label":utils.LanguageManager.getString("TOP_VALUES.TILE_ALTITUDE"), "value":"altitudeDifferencesUphill"};
            new __AS3__.vec.Vector.<Object>(5)[4] = {"label":utils.LanguageManager.getString("TOP_VALUES.TILE_CALORIES"), "value":"calories"};
            TOP_VALUES = new __AS3__.vec.Vector.<Object>(5);
            new __AS3__.vec.Vector.<Object>(8)[0] = {"label":utils.LanguageManager.getString("CALENDAR_STATISTIC_TREND_HEARTRATE"), "value":"averageHeartrate", "valueDefined":"averageHeartrateDefined", "color":10031655};
            new __AS3__.vec.Vector.<Object>(8)[1] = {"label":utils.LanguageManager.getString("CALENDAR_STATISTIC_TREND_SPEED"), "value":"averageSpeed", "valueDefined":"averageSpeedDefined", "color":3050304};
            new __AS3__.vec.Vector.<Object>(8)[2] = {"label":utils.LanguageManager.getString("CALENDAR_STATISTIC_TREND_ALTITUDE"), "value":"averageAltitude", "valueDefined":"averageAltitudeDefined", "color":19931};
            new __AS3__.vec.Vector.<Object>(8)[3] = {"label":utils.LanguageManager.getString("CALENDAR_STATISTIC_TREND_CADENCE"), "value":"averageCadence", "valueDefined":"averageCadenceDefined", "color":4539975};
            new __AS3__.vec.Vector.<Object>(8)[4] = {"label":utils.LanguageManager.getString("CALENDAR_STATISTIC_TREND_POWER"), "value":"averagePower", "valueDefined":"averagePowerDefined", "color":16755200};
            new __AS3__.vec.Vector.<Object>(8)[5] = {"label":utils.LanguageManager.getString("CALENDAR_STATISTIC_TREND_INTENSITY_ZONES"), "value":"intensityZone1Start", "valueDefined":"intensityZone1StartDefined", "color":0, "color1":1542837, "color2":48716, "color3":16568846, "color4":13046322, "colorUnder":10066329, "colorOver":6908265};
            new __AS3__.vec.Vector.<Object>(8)[6] = {"label":utils.LanguageManager.getString("CALENDAR_STATISTIC_TREND_POWER_ZONES"), "value":"powerZone1Start", "valueDefined":"powerZone1StartDefined", "color":0, "color1":7747541, "color2":1542837, "color3":48716, "color4":16568846, "color5":16752653, "color6":13046322, "color7":11085908};
            new __AS3__.vec.Vector.<Object>(8)[7] = {"label":utils.LanguageManager.getString("CALENDAR_STATISTIC_TREND_STEPS"), "value":"steps", "valueDefined":"stepsDefined", "color":2201544};
            VALUES_CALENDAR = new __AS3__.vec.Vector.<Object>(8);
            new __AS3__.vec.Vector.<Object>(2)[0] = {"label":utils.LanguageManager.getString("STATISTIC_SEPARATION_NONE"), "value":"total"};
            new __AS3__.vec.Vector.<Object>(2)[1] = {"label":utils.LanguageManager.getString("STATISTIC_SEPARATION_SPORT"), "value":"sport"};
            SEPARATION_MODES = new __AS3__.vec.Vector.<Object>(2);
            new __AS3__.vec.Vector.<Object>(3)[0] = {"label":utils.LanguageManager.getString("STATISTIC_DISPLAY_ALL"), "value":"all"};
            new __AS3__.vec.Vector.<Object>(3)[1] = {"label":utils.LanguageManager.getString("STATISTIC_DISPLAY_ONLY_DATA"), "value":"onlyData"};
            new __AS3__.vec.Vector.<Object>(3)[2] = {"label":utils.LanguageManager.getString("STATISTIC_DISPLAY_UNTIL_TODAY"), "value":"untilToday"};
            DISPLAY_MODES = new __AS3__.vec.Vector.<Object>(3);
            return;
        }

        public static function getLabel(arg1:String):String
        {
            var loc3:*=0;
            var loc2:*=VALUES.length;
            var loc1:*="";
            loc3 = 0;
            while (loc3 < loc2) 
            {
                if (VALUES[loc3].value == arg1) 
                {
                    loc1 = VALUES[loc3].label;
                    break;
                }
                ++loc3;
            }
            return loc1;
        }

        public static function get SEPARATION_MODES():__AS3__.vec.Vector.<Object>
        {
            return Statistic.SEPARATION_MODES;
        }

        public static function set SEPARATION_MODES(arg1:__AS3__.vec.Vector.<Object>):void
        {
            var loc1:*=Statistic.SEPARATION_MODES;
            if (loc1 !== arg1) 
            {
                Statistic.SEPARATION_MODES = arg1;
                if (Statistic._bindingEventDispatcher.hasEventListener("propertyChange")) 
                {
                    Statistic._bindingEventDispatcher.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(Statistic, "SEPARATION_MODES", loc1, arg1));
                }
            }
            return;
        }

        public static function getStatisticYearsStatement():String
        {
            var loc1:*=configCache.ConfigCache.getInstance().configCacheObject.selectedSportIds().concat();
            if (loc1.length == 0) 
            {
                loc1.push(0);
            }
            var loc2:*=configCache.ConfigCache.getInstance().configCacheObject.selectedUserIds().concat();
            if (loc2.length == 0) 
            {
                loc2.push(0);
            }
            var loc3:*="select strftime(\'%Y\', startDate) as year, count(GUID) as dataCount from Activity where statistic = true and sportId in (" + loc1.join(",") + ") " + "and userId in (" + loc2.join(",") + ") " + "and isDeleted = false " + "group by strftime(\'%Y\', startDate)";
            return loc3;
        }

        public static function getDashboardStatisticStatement(arg1:String, arg2:String):Object
        {
            var loc3:*=0;
            var loc1:*=[];
            if (arg1 != "week") 
            {
                if (arg1 == "month") 
                {
                    loc1.push(getYearMonth(arg2));
                }
            }
            else 
            {
                loc1.push(getYearWeek(arg2));
            }
            var loc2:*=VALUES.length;
            var loc5:*="";
            loc3 = 0;
            while (loc3 < loc2) 
            {
                if ((loc5 = VALUES[loc3].value) != "statistic") 
                {
                    loc1.push("sum(" + loc5 + ") as sum_" + loc5);
                }
                ++loc3;
            }
            setCommonStatisticFields(loc1);
            var loc4:*;
            (loc4 = {}).xMode = arg1;
            loc4.yMode = arg2;
            loc4.text = buildSelectStatement(getDashboardStatisticStartDate(arg1), new Date(), loc1, "sportId, key");
            return loc4;
        }

        public static function getGraphStatisticStatement(arg1:int, arg2:int, arg3:int, arg4:String, arg5:String, arg6:String, arg7:String, arg8:int=2000, arg9:int=2016):Object
        {
            var loc2:*=null;
            var loc4:*=0;
            var loc9:*=new Date(arg1, 0, 1, 0, 0, 0);
            var loc3:*=new Date(arg1, 11, 31, 23, 59, 59);
            var loc1:*=[];
            var loc6:*=arg6 != "sport" ? "_total" : "_sport";
            if (arg4 != "week") 
            {
                if (arg4 != "weekDays") 
                {
                    if (arg4 != "month") 
                    {
                        if (arg4 != "monthDays") 
                        {
                            if (arg4 != "year") 
                            {
                                if (arg4 == "yearDays") 
                                {
                                    loc9 = new Date(arg1, 0, 1, 0, 0, 0);
                                    loc3 = new Date(arg1, 11, 31, 23, 59, 59);
                                    loc1.push(getYearDay(arg5, loc6));
                                }
                            }
                            else 
                            {
                                loc9 = new Date(arg8, 0, 1, 0, 0, 0);
                                loc3 = new Date(arg9, 11, 31, 23, 59, 59);
                                loc1.push(getYear(arg5, loc6));
                            }
                        }
                        else 
                        {
                            loc9 = new Date(arg1, arg2, 1, 0, 0, 0);
                            loc3.date = ((loc3 = new Date(arg1, arg2 + 1, 1, 23, 59, 59)).date - 1);
                            loc1.push(getYearMonthDate(arg5, loc6));
                        }
                    }
                    else 
                    {
                        loc1.push(getYearMonth(arg5, loc6));
                    }
                }
                else 
                {
                    loc9 = utils.date.CalendarUtil.calculateCalendarWeekMondayDate(arg3, arg1);
                    (loc3 = new Date()).setTime(loc9.getTime());
                    loc3.date = loc3.date + 6;
                    loc3.setHours(23, 59, 59);
                    loc1.push(getYearWeekDay(arg5, loc6));
                }
            }
            else 
            {
                loc9 = utils.date.CalendarUtil.calculateCalendarWeekMondayDate(1, arg1);
                loc2.date = ((loc2 = utils.date.CalendarUtil.calculateCalendarWeekMondayDate(1, arg1 + 1)).date - 1);
                loc3 = loc2;
                loc1.push(getYearWeek(arg5, loc6));
            }
            var loc7:*=VALUES.length;
            var loc11:*="";
            loc4 = 0;
            while (loc4 < loc7) 
            {
                if ((loc11 = VALUES[loc4].value) != "statistic") 
                {
                    loc1.push("sum(" + loc11 + ") as sum_" + loc11);
                }
                ++loc4;
            }
            setCommonStatisticFields(loc1);
            var loc5:*=arg6 != "sport" ? "key" : "key, sportId";
            var loc8:*="key";
            var loc10:*;
            (loc10 = {}).xMode = arg4;
            loc10.yMode = arg5;
            loc10.text = buildSelectStatement(loc9, loc3, loc1, loc5, loc8);
            return loc10;
        }

        public static function getStatisticValueCompareStatement(arg1:int, arg2:int, arg3:int, arg4:String, arg5:String, arg6:String, arg7:String, arg8:int=2000, arg9:int=2016):Object
        {
            var loc2:*=null;
            var loc4:*=0;
            var loc11:*=new Date(arg1, 0, 1, 0, 0, 0);
            var loc3:*=new Date(arg1, 11, 31, 23, 59, 59);
            var loc9:*=new Date();
            var loc5:*="";
            if (arg7 == "untilToday") 
            {
                if (loc9.fullYear == arg1) 
                {
                    loc3 = loc9;
                }
            }
            var loc1:*=[];
            var loc7:*=arg6 != "sport" ? "total" : "sport";
            if (arg4 != "week") 
            {
                if (arg4 != "weekDays") 
                {
                    if (arg4 != "month") 
                    {
                        if (arg4 != "monthDays") 
                        {
                            if (arg4 != "year") 
                            {
                                if (arg4 == "yearDays") 
                                {
                                    loc11 = new Date(arg1, 0, 1);
                                    loc3 = new Date(arg1, 11, 31, 23, 59, 59);
                                    loc1.push(getYearDay(arg5, loc7));
                                }
                            }
                            else 
                            {
                                loc11 = new Date(arg8, 0, 1, 0, 0, 0);
                                loc3 = new Date(arg9, 11, 31, 23, 59, 59);
                                loc1.push(getYear(arg5, loc7));
                            }
                        }
                        else 
                        {
                            loc11 = new Date(arg1, arg2, 1);
                            loc3.date = ((loc3 = new Date(arg1, arg2 + 1, 1, 23, 59, 59)).date - 1);
                            loc1.push(getYearMonthDate(arg5, loc7));
                        }
                    }
                    else 
                    {
                        loc1.push(getYearMonth(arg5, loc7));
                    }
                }
                else 
                {
                    loc11 = utils.date.CalendarUtil.calculateCalendarWeekMondayDate(arg3, arg1);
                    (loc3 = new Date()).setTime(loc11.getTime());
                    loc3.date = loc3.date + 6;
                    loc1.push(getYearWeekDay(arg5, loc7));
                }
            }
            else 
            {
                loc11 = utils.date.CalendarUtil.calculateCalendarWeekMondayDate(1, arg1);
                loc2.date = ((loc2 = utils.date.CalendarUtil.calculateCalendarWeekMondayDate(1, arg1 + 1)).date - 1);
                loc3 = loc2;
                loc5 = getWeekYear(" ") + " = \'" + arg1 + "\'";
                loc1.push(getYearWeek(arg5, loc7));
            }
            var loc8:*=VALUES.length;
            var loc13:*="";
            loc4 = 0;
            while (loc4 < loc8) 
            {
                if ((loc13 = VALUES[loc4].value) != "statistic") 
                {
                    loc1.push("sum(" + loc13 + ") as sum_" + loc13);
                }
                ++loc4;
            }
            setCommonStatisticFields(loc1);
            var loc6:*=arg6 != "sport" ? "key" : "key, sportId";
            var loc10:*="key";
            var loc12:*;
            (loc12 = {}).xMode = arg4;
            loc12.yMode = arg5;
            loc12.text = buildSelectStatement(loc11, loc3, loc1, loc6, loc10, loc5);
            return loc12;
        }

        public static function getStatisticValueCompareSummaryStatement(arg1:int, arg2:int, arg3:int, arg4:String, arg5:String, arg6:String, arg7:String, arg8:int=2000, arg9:int=2016):Object
        {
            var loc2:*=null;
            var loc4:*=0;
            var loc10:*=new Date(arg1, 0, 1);
            var loc3:*=new Date(arg1, 11, 31, 23, 59, 59);
            var loc9:*=new Date();
            var loc5:*="";
            if (arg7 == "untilToday") 
            {
                if (loc9.fullYear == arg1) 
                {
                    loc3 = loc9;
                }
            }
            var loc1:*=[];
            var loc7:*=arg6 != "sport" ? "total" : "sport";
            if (arg4 != "week") 
            {
                if (arg4 != "weekDays") 
                {
                    if (arg4 != "month") 
                    {
                        if (arg4 != "monthDays") 
                        {
                            if (arg4 != "year") 
                            {
                                if (arg4 == "yearDays") 
                                {
                                    loc10 = new Date(arg1, 0, 1);
                                    loc3 = new Date(arg1, 11, 31, 23, 59, 59);
                                }
                            }
                            else 
                            {
                                loc10 = new Date(arg8, 0, 1, 0, 0, 0);
                                loc3 = new Date(arg9, 11, 31, 23, 59, 59);
                            }
                        }
                        else 
                        {
                            loc10 = new Date(arg1, arg2, 1);
                            loc3.date = ((loc3 = new Date(arg1, arg2 + 1, 1, 23, 59, 59)).date - 1);
                            loc1.push(getYearMonth(arg5, loc7));
                        }
                    }
                    else 
                    {
                        loc1.push(getYear(arg5, arg6));
                    }
                }
                else 
                {
                    loc10 = utils.date.CalendarUtil.calculateCalendarWeekMondayDate(arg3, arg1);
                    (loc3 = new Date()).setTime(loc10.getTime());
                    loc3.date = loc3.date + 6;
                    loc1.push(getWeekDay(arg5, loc7));
                }
            }
            else 
            {
                loc10 = utils.date.CalendarUtil.calculateCalendarWeekMondayDate(1, arg1);
                loc2.date = ((loc2 = utils.date.CalendarUtil.calculateCalendarWeekMondayDate(1, arg1 + 1)).date - 1);
                loc3 = loc2;
                loc5 = getWeekYear(" ") + " = \'" + arg1 + "\'";
                loc1.push(getYearWeek(arg5, loc7));
            }
            var loc8:*=VALUES.length;
            var loc12:*="";
            loc4 = 0;
            while (loc4 < loc8) 
            {
                if ((loc12 = VALUES[loc4].value) == "statistic") 
                {
                    loc1.push("(sum(CASE WHEN " + loc12 + " = true THEN 1 ELSE 0 END)/COUNT(GUID)) as " + "avgTraining_" + loc12);
                }
                else 
                {
                    loc1.push("sum(" + loc12 + ") as sum_" + loc12);
                    loc1.push("(sum(CASE WHEN " + loc12 + " > 0 THEN " + loc12 + " ELSE 0 END)/COUNT(GUID)) as " + "avgTraining_" + loc12);
                }
                ++loc4;
            }
            setCommonStatisticFields(loc1);
            var loc6:*=arg6 != "sport" ? "" : "sportId";
            var loc11:*;
            (loc11 = {}).xMode = arg4;
            loc11.yMode = arg5;
            loc11.text = buildSelectStatement(loc10, loc3, loc1, loc6, "", loc5);
            return loc11;
        }

        public static function getStatisticYearCompareStatement(arg1:int, arg2:int, arg3:int, arg4:String, arg5:String, arg6:String, arg7:String, arg8:int=2000, arg9:int=2016):Object
        {
            var loc4:*=0;
            var loc9:*=new Date(arg8, 0, 1);
            var loc3:*=new Date(arg9, 11, 31, 23, 59, 59);
            var loc5:*="";
            if (arg7 == "untilToday") 
            {
                loc3 = new Date();
            }
            var loc1:*=[];
            var loc7:*=arg6 != "sport" ? "total" : "sport";
            if (arg4 != "week") 
            {
                if (arg4 == "month") 
                {
                    loc1.push(getYearMonth(arg5, loc7));
                    if (arg7 == "untilToday") 
                    {
                        loc5 = "cast(strftime(\'%m\', startDate) as INTEGER) <= " + (loc3.month + 1);
                    }
                }
            }
            else 
            {
                loc1.push(getYearWeek(arg5, loc7));
                if (arg7 == "untilToday") 
                {
                    loc5 = getWeek(" ") + " <= " + (utils.date.CalendarUtil.calculateCalendarWeek(loc3) - 1);
                }
            }
            var loc8:*=arg9 - arg8 + 1;
            var loc2:*="";
            loc4 = 0;
            while (loc4 < loc8) 
            {
                if (arg4 != "week") 
                {
                    loc2 = "CASE WHEN strftime(\'%Y\', startDate) == \'" + (arg8 + loc4) + "\' THEN " + (arg5 != "statistic" ? arg5 : 1) + " ELSE 0 END";
                }
                else 
                {
                    loc2 = "CASE WHEN " + getWeekYear(" ") + " == \'" + (arg8 + loc4) + "\' THEN " + (arg5 != "statistic" ? arg5 : 1) + " ELSE 0 END";
                }
                loc1.push("sum(" + loc2 + ") as " + "sumYear_" + arg5 + (arg8 + loc4));
                ++loc4;
            }
            setCommonStatisticFields(loc1);
            var loc6:*=arg6 != "sport" ? "key" : "key, sportId";
            var loc10:*;
            (loc10 = {}).xMode = arg4;
            loc10.yMode = arg5;
            loc10.text = buildSelectStatement(loc9, loc3, loc1, loc6, loc6, loc5);
            return loc10;
        }

        public static function getStatisticYearCompareSummaryStatement(arg1:int, arg2:int, arg3:int, arg4:String, arg5:String, arg6:String, arg7:String, arg8:int=2000, arg9:int=2016):Object
        {
            var loc7:*=null;
            var loc4:*=0;
            var loc11:*=new Date(arg8, 0, 1);
            var loc3:*=new Date(arg9, 11, 31, 23, 59, 59);
            var loc5:*="";
            if (arg7 == "untilToday") 
            {
                loc3 = new Date();
                if (arg4 != "week") 
                {
                    if (arg4 == "month") 
                    {
                        loc5 = "cast(strftime(\'%m\', startDate) as INTEGER) <= " + (loc3.month + 1);
                    }
                }
                else 
                {
                    loc5 = getWeek(" ") + " <= " + (utils.date.CalendarUtil.calculateCalendarWeek(loc3) - 1);
                }
            }
            var loc1:*=[];
            var loc6:*="";
            var loc10:*="startDate";
            var loc8:*=arg6 != "sport" ? "total" : "sport";
            var loc9:*=arg9 - arg8 + 1;
            var loc2:*="";
            loc4 = 0;
            while (loc4 < loc9) 
            {
                if (arg4 != "week") 
                {
                    loc2 = "CASE WHEN strftime(\'%Y\', startDate) == \'" + (arg8 + loc4) + "\' THEN " + (arg5 != "statistic" ? arg5 : 1) + " ELSE 0 END";
                }
                else 
                {
                    loc2 = "CASE WHEN " + getWeekYear(" ") + " == \'" + (arg8 + loc4) + "\' THEN " + (arg5 != "statistic" ? arg5 : 1) + " ELSE 0 END";
                }
                loc1.push("sum(" + loc2 + ") as " + "sumYear_" + arg5 + (arg8 + loc4));
                ++loc4;
            }
            setCommonStatisticFields(loc1);
            loc6 = arg6 != "sport" ? loc6 : "sportId";
            var loc12:*;
            (loc12 = {}).xMode = arg4;
            loc12.yMode = arg5;
            loc12.text = buildSelectStatement(loc11, loc3, loc1, loc6, loc10, loc5);
            return loc12;
        }

        public static function get TOP_VALUES():__AS3__.vec.Vector.<Object>
        {
            return Statistic.TOP_VALUES;
        }

        public static function set TOP_VALUES(arg1:__AS3__.vec.Vector.<Object>):void
        {
            var loc1:*=Statistic.TOP_VALUES;
            if (loc1 !== arg1) 
            {
                Statistic.TOP_VALUES = arg1;
                if (Statistic._bindingEventDispatcher.hasEventListener("propertyChange")) 
                {
                    Statistic._bindingEventDispatcher.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(Statistic, "TOP_VALUES", loc1, arg1));
                }
            }
            return;
        }

        public static function getStatisticCalendarStatement(arg1:int, arg2:int, arg3:int, arg4:String, arg5:String):Object
        {
            var loc5:*=null;
            var loc3:*=null;
            var loc4:*=0;
            var loc1:*=[];
            if (arg4 != "week") 
            {
                if (arg4 != "month") 
                {
                    loc5 = new Date(arg1, 0, 1, 0, 0, 0);
                    loc3 = new Date(arg1, 11, 31, 23, 59, 59);
                    loc1.push(getYear(arg5));
                }
                else 
                {
                    loc5 = new Date(arg1, arg2, 1);
                    loc3.date = ((loc3 = new Date(arg1, arg2 + 1, 1, 23, 59, 59)).date - 1);
                    loc1.push(getYearMonth(arg5));
                }
            }
            else 
            {
                loc5 = utils.date.CalendarUtil.calculateCalendarWeekMondayDate(arg3, arg1);
                (loc3 = new Date()).setTime(loc5.getTime());
                loc3.date = loc3.date + 6;
                loc1.push(getYearWeek(arg5));
            }
            var loc2:*=VALUES.length;
            var loc7:*="";
            loc4 = 0;
            while (loc4 < loc2) 
            {
                if ((loc7 = VALUES[loc4].value) != "statistic") 
                {
                    loc1.push("sum(" + loc7 + ") as sum_" + loc7);
                }
                ++loc4;
            }
            setCommonStatisticFields(loc1);
            var loc6:*;
            (loc6 = {}).xMode = arg4;
            loc6.yMode = arg5;
            loc6.text = buildSelectStatement(loc5, loc3, loc1);
            return loc6;
        }

        public static function getDashboardStatisticStartDate(arg1:String):Date
        {
            var loc2:*=null;
            var loc3:*=0;
            var loc4:*=null;
            var loc1:*=new Date();
            if (arg1 == "month") 
            {
                loc2 = loc1;
                loc2.hours = 0;
                loc2.minutes = 0;
                loc2.seconds = 0;
                loc2.date = 1;
                loc2.month = loc2.month - 11;
                return loc2;
            }
            loc3 = utils.date.CalendarUtil.calculateCalendarWeek(loc1);
            (loc4 = utils.date.CalendarUtil.calculateCalendarWeekMondayDate(loc3, loc1.fullYear)).hours = 0;
            loc4.minutes = 0;
            loc4.seconds = 0;
            loc4.date = loc4.date - 77;
            return loc4;
        }

        public static function dateToMySqlFormat(arg1:Date=null):String
        {
            var loc1:*=new utils.formatter.DateFormatterMx();
            loc1.formatString = "YYYY-MM-DD JJ:NN:SS";
            if (arg1 == null) 
            {
                arg1 = new Date();
            }
            return loc1.format(arg1);
        }

        internal static function getWeekByConfig():String
        {
            return core.MeasurementConfig.firstDayOfWeek != 0 ? _week_ISO : _week_US;
        }

        internal static function getWeekYearByConfig():String
        {
            return core.MeasurementConfig.firstDayOfWeek != 0 ? _weekYear_ISO : _weekYear_US;
        }

        internal static function getWeek(arg1:String="week"):String
        {
            return getWeekByConfig() + (arg1 == " " ? "" : " as " + arg1);
        }

        internal static function getWeekDay(arg1:String, arg2:String="_total", arg3:String="key"):String
        {
            return "(strftime(\'%Y\',startDate) || \'_\' || strftime(\'%j\',startDate) || \'_" + arg1 + arg2 + "\') as " + arg3;
        }

        public static const ALTITUDE_DOWNHILL:String="altitudeDifferencesDownhill";

        public static const ALTITUDE_DOWNHILL_DEFINED:String="altitudeDifferencesDownhillDefined";

        public static const ALTITUDE_UPHILL:String="altitudeDifferencesUphill";

        public static const ALTITUDE_UPHILL_DEFINED:String="altitudeDifferencesUphillDefined";

        public static const AVG_TIMEMODE_FIELD:String="avgTimeMode_";

        public static const AVG_TRAINING_FIELD:String="avgTraining_";

        public static const CALORIES:String="calories";

        public static const CALORIES_DEFINED:String="caloriesDefined";

        public static const DISPLAY_ALL:String="all";

        public static const X_YEAR:String="year";

        public static const DISPLAY_ONLY_DATA:String="onlyData";

        public static const DISPLAY_UNTIL_TODAY:String="untilToday";

        public static const DISTANCE:String="distance";

        public static const DISTANCE_DEFINED:String="distanceDefined";

        public static const FORMATED_FIELD:String="_format";

        public static const MAX_SPEED:String="maximumSpeed";

        public static const X_YEAR_DAYS:String="yearDays";

        public static const SEPARATION_NONE:String="total";

        public static const SEPARATION_SPORT:String="sport";

        public static const STEPS:String="steps";

        public static const STEPS_DEFINED:String="stepsDefined";

        public static const SUM_FIELD:String="sum_";

        public static const SUM_YEAR_FIELD:String="sumYear_";

        public static const TREND_OF_CADENCE:String="averageCadence";

        public static const TRAININGS:String="statistic";

        public static const TRAININGS_DEFINED:String="statisticDefined";

        public static const TRAINING_TIME:String="trainingTime";

        public static const TRAINING_TIME_DEFINED:String="trainingTimeDefined";

        public static const TREND_OF_ALTITUDE:String="averageAltitude";

        public static const TREND_OF_ALTITUDE_DEFINED:String="averageAltitudeDefined";

        public static const TREND_OF_POWER_DEFINED:String="averagePowerDefined";

        public static const TREND_OF_CADENCE_DEFINED:String="averageCadenceDefined";

        public static const TREND_OF_HEARTRATE:String="averageHeartrate";

        public static const TREND_OF_HEARTRATE_DEFINED:String="averageHeartrateDefined";

        public static const TREND_OF_INTENSITY_ZONES:String="intensityZone1Start";

        public static const TREND_OF_INTENSITY_ZONES_DEFINED:String="intensityZone1StartDefined";

        public static const TREND_OF_POWER:String="averagePower";

        public static const TREND_OF_POWER_ZONES:String="powerZone1Start";

        public static const TREND_OF_POWER_ZONES_DEFINED:String="powerZone1StartDefined";

        public static const TREND_OF_SPEED:String="averageSpeed";

        public static const TREND_OF_SPEED_DEFINED:String="averageSpeedDefined";

        public static const X_MONTH_DAYS:String="monthDays";

        public static const TREND_OF_STEPS:String="steps";

        public static const TREND_OF_STEPS_DEFINED:String="stepsDefined";

        public static const X_MONTH:String="month";

        public static const X_WEEK:String="week";

        public static const X_WEEK_DAYS:String="weekDays";

        internal static var DISPLAY_MODES:__AS3__.vec.Vector.<Object>;

        internal static var SEPARATION_MODES:__AS3__.vec.Vector.<Object>;

        internal static var VALUES_CALENDAR:__AS3__.vec.Vector.<Object>;

        internal static var _instance:statistic.Statistic;

        public static var VALUES:__AS3__.vec.Vector.<Object>;

        internal static var _weekYear_ISO:String="strftime(\'%Y\', date(startDate, \'-3 days\', \'weekday 4\'))";

        internal static var _week_ISO:String="((strftime(\'%j\', date(startDate, \'-3 days\', \'weekday 4\')) - 1) / 7)";

        internal static var _weekYear_US:String="strftime(\'%Y\', date(startDate, \'-3 days\', \'weekday 4\'))";

        internal static var TOP_VALUES:__AS3__.vec.Vector.<Object>;

        internal static var _week_US:String="((strftime(\'%j\', date(startDate, \'-3 days\', \'weekday 4\')) - 1) / 7)";

        public static var useTmpUserAndSport:Boolean=false;

        internal static var _bindingEventDispatcher:flash.events.EventDispatcher;

        public static var tmpSports:Array;

        public static var tmpUsers:Array;
    }
}


