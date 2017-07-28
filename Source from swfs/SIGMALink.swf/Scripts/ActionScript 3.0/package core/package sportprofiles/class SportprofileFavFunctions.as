//class SportprofileFavFunctions
package core.sportprofiles 
{
    import __AS3__.vec.*;
    import utils.sort.*;
    
    public class SportprofileFavFunctions extends Object
    {
        public function SportprofileFavFunctions()
        {
            var loc1:*=0;
            _functions = new __AS3__.vec.Vector.<core.sportprofiles.SportprofileFavFunctionObject>();
            _categories = new __AS3__.vec.Vector.<core.sportprofiles.SportprofileFavFunctionsCategory>();
            super();
            var loc2:*=0;
            sportprofile = currentSportprofile;
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 1, 1, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 1, 2, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 1, 3, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 1, 4, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 2, 5, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 2, 6, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 2, 8, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 2, 9, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 4, 13, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 4, 14, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 4, 15, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 4, 16, loc2++, [10]));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 4, 17, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 4, 18, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 4, 19, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 4, 20, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 4, 21, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 4, 22, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 4, 23, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 4, 24, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 4, 25, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 4, 26, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 4, 27, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 4, 28, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 4, 29, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 4, 30, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 4, 31, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 4, 32, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 4, 33, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 6, 37, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 6, 38, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 6, 39, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 6, 40, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 6, 42, loc2++, [10]));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 14, 7, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 2], 8, 57, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 2], 8, 58, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 2], 8, 59, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 2], 8, 60, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 2], 8, 61, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 2], 8, 62, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 2], 8, 63, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 2], 8, 64, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 2], 8, 65, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 2], 8, 66, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 2], 8, 67, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 2], 8, 68, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 2], 8, 69, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 2], 8, 70, loc2++));
            if (sportprofile is core.sportprofiles.SportProfileROX110) 
            {
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 2], 8, 71, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 2], 8, 72, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 2], 8, 73, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 2], 8, 74, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 2], 8, 75, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 2], 8, 76, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 2], 8, 77, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 2], 8, 78, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 2], 8, 79, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 2], 8, 80, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 2], 8, 81, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 2], 8, 82, loc2++));
            }
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 3], 7, 43, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 3], 7, 44, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 3], 7, 45, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 3], 7, 46, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 3], 7, 47, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 3], 7, 48, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 3], 7, 49, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 3], 7, 50, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 3], 7, 51, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 3], 7, 52, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 3], 7, 53, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 3], 7, 54, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 3], 7, 55, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 3], 7, 56, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 3], 7, 83, loc2++, [10]));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 3], 7, 96, loc2++, [10]));
            if (sportprofile is core.sportprofiles.SportProfileROX110) 
            {
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 3], 7, 84, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 3], 7, 85, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 3], 7, 86, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 3], 7, 87, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 3], 7, 88, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 3], 7, 89, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 3], 7, 90, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 3], 7, 91, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 3], 7, 92, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 3], 7, 93, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 3], 7, 94, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1, 3], 7, 95, loc2++));
            }
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 5, 10, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 5, 11, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 5, 12, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 5, 34, loc2++));
            addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 5, 35, loc2++));
            if (sportprofile is core.sportprofiles.SportProfileROX110) 
            {
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 9, 105, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 9, 108, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 9, 109, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 9, 110, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 9, 107, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 9, 112, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 9, 106, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 9, 111, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 9, 114, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 9, 115, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 9, 116, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 9, 113, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 9, 117, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 9, 99, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 9, 100, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 9, 101, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 9, 102, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 9, 103, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 9, 118, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 9, 104, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 9, 119, loc2++, [10]));
            }
            if (sportprofile is core.sportprofiles.SportProfileROX110) 
            {
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 11, 120, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 11, 122, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 11, 123, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 11, 124, loc2++, [10]));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 11, 125, loc2++));
            }
            if (sportprofile is core.sportprofiles.SportProfileROX110) 
            {
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 12, 126, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 12, 127, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 12, 128, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 12, 129, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 12, 130, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 12, 131, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 12, 133, loc2++, [10]));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 12, 132, loc2++, [10]));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 12, 134, loc2++, [10]));
            }
            if (sportprofile is core.sportprofiles.SportProfileROX110) 
            {
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 13, 135, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 13, 136, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 13, 137, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 13, 121, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 13, 138, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 13, 139, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 13, 140, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 13, 97, loc2++));
                addFunction(new core.sportprofiles.SportprofileFavFunctionObject([1], 13, 98, loc2++));
            }
            _categories.sort(sortCategories);
            loc1 = 0;
            while (loc1 < _categories.length) 
            {
                (_categories[loc1] as core.sportprofiles.SportprofileFavFunctionsCategory).functions.sort(sortFunctions);
                ++loc1;
            }
            _functions.sort(sortFunctions);
            return;
        }

        internal function addFunction(arg1:core.sportprofiles.SportprofileFavFunctionObject):void
        {
            getCategory(arg1.categoryId).addFunction(arg1);
            _functions.push(arg1);
            return;
        }

        public function get functions():__AS3__.vec.Vector.<core.sportprofiles.SportprofileFavFunctionObject>
        {
            return _functions;
        }

        public function getCategoryFunctions(arg1:uint):__AS3__.vec.Vector.<core.sportprofiles.SportprofileFavFunctionObject>
        {
            var loc1:*=0;
            loc1 = 0;
            while (loc1 < _categories.length) 
            {
                if (_categories[loc1].categoryId == arg1) 
                {
                    return (_categories[loc1] as core.sportprofiles.SportprofileFavFunctionsCategory).functions;
                }
                ++loc1;
            }
            return new __AS3__.vec.Vector.<core.sportprofiles.SportprofileFavFunctionObject>();
        }

        internal function getCategory(arg1:uint):core.sportprofiles.SportprofileFavFunctionsCategory
        {
            var loc1:*=0;
            loc1 = 0;
            while (loc1 < _categories.length) 
            {
                if (_categories[loc1].categoryId == arg1) 
                {
                    return _categories[loc1] as core.sportprofiles.SportprofileFavFunctionsCategory;
                }
                ++loc1;
            }
            var loc2:*=new core.sportprofiles.SportprofileFavFunctionsCategory(arg1);
            _catSortCounter = (_catSortCounter + 1);
            loc2.sort = _catSortCounter;
            _categories.push(loc2);
            return loc2;
        }

        public static function getInstance():core.sportprofiles.SportprofileFavFunctions
        {
            if (!_instance || !(_instance.sportprofile.unit.type == currentSportprofile.unit.type)) 
            {
                _instance = new SportprofileFavFunctions();
            }
            return _instance;
        }

        internal function sortCategories(arg1:core.sportprofiles.SportprofileFavFunctionsCategory, arg2:core.sportprofiles.SportprofileFavFunctionsCategory):Number
        {
            return utils.sort.SortUtil.sortOnNumber(arg1, arg2, "sort", false);
        }

        internal function sortFunctions(arg1:core.sportprofiles.SportprofileFavFunctionObject, arg2:core.sportprofiles.SportprofileFavFunctionObject):Number
        {
            return utils.sort.SortUtil.sortOnNumber(arg1, arg2, "sort", false);
        }

        public function getCategories():__AS3__.vec.Vector.<core.sportprofiles.SportprofileFavFunctionsCategory>
        {
            return _categories;
        }

        public static const FUNC_TIME_EXCERCISE_TIME:uint=5;

        public static const FUNC_TIME_TRIP_TIME:uint=6;

        public static const FUNC_POWER_KJ:uint=113;

        public static const CATEGORY_ID_ALTITUDE:uint=4;

        public static const CATEGORY_ID_AUTOLAP:uint=7;

        public static const CATEGORY_ID_BICYCLE:uint=1;

        public static const CATEGORY_ID_CADENCE:uint=13;

        public static const CATEGORY_ID_CALORIES:uint=14;

        public static const CATEGORY_ID_CYCLINGDYNAMICS:uint=10;

        public static const CATEGORY_ID_GEARS:uint=11;

        public static const CATEGORY_ID_HEARTRATE:uint=12;

        public static const CATEGORY_ID_LAP:uint=8;

        public static const CATEGORY_ID_NAVIGATION:uint=6;

        public static const CATEGORY_ID_POWER:uint=9;

        public static const CATEGORY_ID_STATUS:uint=5;

        public static const CATEGORY_ID_TEMPERATURE:uint=3;

        public static const CATEGORY_ID_TIME:uint=2;

        public static const FUNC_ALTITUDE_ACTUAL_RISE_RATE:uint=15;

        public static const FUNC_ALTITUDE_ASCENT:uint=17;

        public static const FUNC_ALTITUDE_AVG_DECLINE_DOWNHILL:uint=32;

        public static const FUNC_ALTITUDE_AVG_INCLINE_UPHILL:uint=24;

        public static const FUNC_ALTITUDE_AVG_RISE_RATE_DOWNHILL:uint=30;

        public static const FUNC_ALTITUDE_AVG_RISE_RATE_UPHILL:uint=22;

        public static const FUNC_ALTITUDE_AVG_SPEED_DOWNHILL:uint=29;

        public static const FUNC_ALTITUDE_AVG_SPEED_UPHILL:uint=21;

        public static const FUNC_ALTITUDE_CURRENT_ALTITUDE:uint=13;

        public static const FUNC_ALTITUDE_DESCENT:uint=26;

        public static const FUNC_ALTITUDE_DISTACE_UPHILL:uint=19;

        public static const FUNC_ALTITUDE_DISTANCE_DOWNHILL:uint=27;

        public static const FUNC_ALTITUDE_INCLINE:uint=14;

        public static const FUNC_ALTITUDE_MAXIMUM_ALTITUDE:uint=18;

        public static const FUNC_ALTITUDE_MAX_DECLINE_DOWNHILL:uint=33;

        public static const FUNC_ALTITUDE_MAX_INCLINE_UPHILL:uint=25;

        public static const FUNC_ALTITUDE_MAX_RISE_RATE_DOWNHILL:uint=31;

        public static const FUNC_ALTITUDE_MAX_RISE_RATE_UPHILL:uint=23;

        public static const FUNC_ALTITUDE_PROFILE:uint=16;

        public static const FUNC_ALTITUDE_TIME_DOWNHILL:uint=28;

        public static const FUNC_ALTITUDE_TIME_UPHILL:uint=20;

        public static const FUNC_AUTOLAP_ALTITUDE_ASCENT_PER_LAP:uint=51;

        public static const FUNC_AUTOLAP_ALTITUDE_DESCENT_PER_LAP:uint=52;

        public static const FUNC_AUTOLAP_AL_PEDALING_INDEX:uint=95;

        public static const FUNC_AUTOLAP_AL_PEDALING_TIME:uint=94;

        public static const FUNC_AUTOLAP_AVG_ALTITUDE_PER_LAP:uint=49;

        public static const FUNC_AUTOLAP_AVG_BALANCE_LAP:uint=84;

        public static const FUNC_AUTOLAP_AVG_CAD:uint=90;

        public static const FUNC_AUTOLAP_AVG_HR:uint=92;

        public static const FUNC_AUTOLAP_AVG_INCLINE_PER_LAP_DOWNHILL:uint=54;

        public static const FUNC_AUTOLAP_AVG_INCLINE_PER_LAP_UPHILL:uint=53;

        public static const FUNC_AUTOLAP_AVG_SPEED_PER_LAP:uint=46;

        public static const FUNC_AUTOLAP_AVG_VAM_DOWNHILL_PER_LAP:uint=56;

        public static const FUNC_AUTOLAP_AVG_VAM_UPHILL_PER_LAP:uint=55;

        public static const FUNC_AUTOLAP_CALORIES_PER_LAP:uint=48;

        public static const FUNC_AUTOLAP_DISTANCE:uint=45;

        public static const FUNC_AUTOLAP_LAPLIST:uint=83;

        public static const FUNC_AUTOLAP_LAST_AUTOLAP_AVG_POWER:uint=86;

        public static const FUNC_AUTOLAP_LAST_AUTOLAP_NP:uint=89;

        public static const FUNC_AUTOLAP_LIST:uint=96;

        public static const FUNC_AUTOLAP_MAX_ALTITUDE_PER_LAP:uint=50;

        public static const FUNC_AUTOLAP_MAX_CAD:uint=91;

        public static const FUNC_AUTOLAP_MAX_HR:uint=93;

        public static const FUNC_AUTOLAP_MAX_POWER:uint=87;

        public static const FUNC_AUTOLAP_MAX_SPEED_PER_LAP:uint=47;

        public static const FUNC_AUTOLAP_NP:uint=88;

        public static const FUNC_AUTOLAP_NUMBER:uint=43;

        public static const FUNC_AUTOLAP_POWER_LAP:uint=85;

        public static const FUNC_AUTOLAP_TIME:uint=44;

        public static const FUNC_BICYCLE_AVERAGE_SPEED:uint=2;

        public static const FUNC_BICYCLE_CURRENT_SPEED:uint=1;

        public static const FUNC_BICYCLE_MAX_SPEED:uint=3;

        public static const FUNC_BICYCLE_TRIP_DISTANCE:uint=4;

        public static const FUNC_CADENCE_AVG_CAD:uint=136;

        public static const FUNC_CADENCE_AVG_EXPANSION:uint=138;

        public static const FUNC_CADENCE_AVG_EXPANSION_DOWNHILL:uint=140;

        public static const FUNC_CADENCE_AVG_EXPANSION_UPHILL:uint=139;

        public static const FUNC_CADENCE_CURRENT_CAD:uint=135;

        public static const FUNC_CADENCE_CURRENT_EXPANSION:uint=121;

        public static const FUNC_CADENCE_MAX_CAD:uint=137;

        public static const FUNC_CALORIES_CALORIES:uint=7;

        public static const FUNC_GEARS_DI2_BATTERY_LEVEL:uint=120;

        public static const FUNC_GEARS_DI2_FRONTGEAR:uint=122;

        public static const FUNC_GEARS_DI2_GEARS:uint=124;

        public static const FUNC_GEARS_DI2_GEAR_RATIO:uint=123;

        public static const FUNC_GEARS_DI2_GEAR_REAR:uint=125;

        public static const FUNC_HEARTRATE_AVG_HR:uint=127;

        public static const FUNC_HEARTRATE_AVG_HRMAX_PERCENT:uint=131;

        public static const FUNC_HEARTRATE_CURRENT_HR:uint=126;

        public static const FUNC_HEARTRATE_HRMAX_PERCENT:uint=130;

        public static const FUNC_HEARTRATE_HR_GRAPH:uint=134;

        public static const FUNC_HEARTRATE_INTENSITY_ZONE:uint=133;

        public static const FUNC_HEARTRATE_MAX_HR:uint=128;

        public static const FUNC_HEARTRATE_MIN_HR:uint=129;

        public static const FUNC_HEARTRATE_ZONE_BAR:uint=132;

        public static const FUNC_LAP_ALTITUDE_ASCENT_PER_LAP:uint=65;

        public static const FUNC_LAP_ALTITUDE_DESCENT_PER_LAP:uint=66;

        public static const FUNC_LAP_AVG_ALTITUDE_PER_LAP:uint=63;

        public static const FUNC_LAP_AVG_BALANCE:uint=71;

        public static const FUNC_LAP_AVG_CAD:uint=77;

        public static const FUNC_LAP_AVG_HR:uint=79;

        public static const FUNC_LAP_AVG_INCLINE_PER_LAP_DOWNHILL:uint=68;

        public static const FUNC_LAP_AVG_INCLINE_PER_LAP_UPHILL:uint=67;

        public static const FUNC_LAP_AVG_POWER:uint=72;

        public static const FUNC_LAP_AVG_SPEED_PER_LAP:uint=60;

        public static const FUNC_LAP_AVG_VAM_DOWNHILL_PER_LAP:uint=70;

        public static const FUNC_LAP_AVG_VAM_UPHILL_PER_LAP:uint=69;

        public static const FUNC_LAP_CALORIES_PER_LAP:uint=62;

        public static const FUNC_LAP_DISTANCE:uint=59;

        public static const FUNC_LAP_LAST_LAP_AVG_POWER:uint=73;

        public static const FUNC_LAP_LAST_LAP_NP:uint=76;

        public static const FUNC_LAP_MAX_ALTITUDE_PER_LAP:uint=64;

        public static const FUNC_LAP_MAX_CAD:uint=78;

        public static const FUNC_LAP_MAX_HR:uint=80;

        public static const FUNC_LAP_MAX_POWER:uint=74;

        public static const FUNC_LAP_MAX_SPEED_PER_LAP:uint=61;

        public static const FUNC_LAP_NP:uint=75;

        public static const FUNC_LAP_NUMBER:uint=57;

        public static const FUNC_LAP_PEDALING_INDEX:uint=82;

        public static const FUNC_LAP_PEDALING_TIME:uint=81;

        public static const FUNC_NAVIGATION_DIRECTION:uint=40;

        public static const FUNC_NAVIGATION_DISTANCE_TO_DESTINATION:uint=39;

        public static const FUNC_NAVIGATION_NAVIGATION:uint=41;

        public static const FUNC_NAVIGATION_TIME_OF_ARRIVAL:uint=38;

        public static const FUNC_NAVIGATION_TIME_TO_DESTINATION:uint=37;

        public static const FUNC_NAVIGATION_TRACK_VIEW:uint=42;

        public static const FUNC_PEDALING_INDEX:uint=98;

        public static const FUNC_PEDALING_TIME:uint=97;

        public static const FUNC_POWER_AVG_10_SEC:uint=109;

        public static const FUNC_POWER_AVG_30_SEC:uint=110;

        public static const FUNC_POWER_AVG_3_SEC:uint=108;

        public static const FUNC_POWER_AVG_POWER:uint=107;

        public static const FUNC_POWER_BALANCE:uint=99;

        public static const FUNC_POWER_BALANCE_10_SEC:uint=101;

        public static const FUNC_POWER_BALANCE_30_SEC:uint=102;

        public static const FUNC_POWER_BALANCE_3_SEC:uint=100;

        public static const FUNC_POWER_BALANCE_AVG:uint=103;

        public static const FUNC_POWER_CURRENT_POWER:uint=105;

        public static const FUNC_POWER_FTP_PERCENT:uint=106;

        public static const FUNC_POWER_IF:uint=111;

        public static const FUNC_LAP_TIME:uint=58;

        public static const FUNC_POWER_MAX:uint=112;

        public static const FUNC_POWER_NP:uint=114;

        public static const FUNC_POWER_PEDAL_SMOOTHNESS:uint=104;

        public static const FUNC_POWER_TARGET_ZONE:uint=119;

        public static const FUNC_POWER_TORQUE_EFFECTIVENESS:uint=118;

        public static const FUNC_POWER_TSS:uint=115;

        public static const FUNC_POWER_WATT_KG:uint=116;

        public static const FUNC_POWER_ZONES:uint=117;

        public static const FUNC_STATUS_BATTERY:uint=35;

        public static const FUNC_STATUS_CURRENT_TEMPERATURE:uint=10;

        public static const FUNC_STATUS_GPS_ACCURACY:uint=34;

        public static const FUNC_STATUS_GPS_POSITION:uint=36;

        public static const FUNC_STATUS_MAX_TEMP:uint=12;

        public static const FUNC_STATUS_MIN_TEMP:uint=11;

        public static const FUNC_TIME_CLOCK:uint=8;

        public static const FUNC_TIME_DATE:uint=9;

        internal var _functions:__AS3__.vec.Vector.<core.sportprofiles.SportprofileFavFunctionObject>;

        public var sportprofile:core.sportprofiles.Sportprofile;

        internal var _catSortCounter:uint=0;

        public static var currentSportprofile:core.sportprofiles.Sportprofile;

        internal static var _instance:core.sportprofiles.SportprofileFavFunctions;

        internal var _categories:__AS3__.vec.Vector.<core.sportprofiles.SportprofileFavFunctionsCategory>;
    }
}


