//class FilterHandler
package handler 
{
    import __AS3__.vec.*;
    import configCache.*;
    import core.activities.*;
    import core.filter.*;
    import core.participant.*;
    import core.route.*;
    import flash.events.*;
    import mx.events.*;
    import mx.utils.*;
    import utils.*;
    import utils.date.*;
    
    public class FilterHandler extends flash.events.EventDispatcher
    {
        public function FilterHandler(arg1:flash.events.IEventDispatcher=null)
        {
            filterMode = "filterActivities";
            filterResult = "";
            _filterVector = new __AS3__.vec.Vector.<core.filter.Filter>();
            listItems = new __AS3__.vec.Vector.<Object>();
            super(arg1);
            readCache();
            validateFilterList();
            return;
        }

        internal function filterTrackType(arg1:Object):Boolean
        {
            if (_currentFilter.trackType == "alltrips" || !(arg1 is core.route.Route)) 
            {
                return true;
            }
            if (arg1 is core.route.Route) 
            {
                if (_currentFilter.trackType == "roundtrip") 
                {
                    return (arg1 as core.route.Route).isCircuit;
                }
                return !(arg1 as core.route.Route).isCircuit;
            }
            return true;
        }

        public function get defaultFilter():core.filter.Filter
        {
            return new core.filter.Filter();
        }

        public function set defaultFilter(arg1:core.filter.Filter):void
        {
            _defaultFilter = arg1;
            return;
        }

        internal function filterWeather(arg1:Object):Boolean
        {
            if (arg1 is core.activities.Activity && (arg1 as core.activities.Activity).weatherDefined) 
            {
                return _currentFilter.weather == arg1.weather;
            }
            return true;
        }

        public function get filterMode():String
        {
            return this.filterMode;
        }

        public function set filterMode(arg1:String):void
        {
            var loc1:*=this.filterMode;
            if (loc1 !== arg1) 
            {
                this.filterMode = arg1;
                if (this.hasEventListener("propertyChange")) 
                {
                    this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "filterMode", loc1, arg1));
                }
            }
            return;
        }

        public function get isFilterActive():Boolean
        {
            return !(_selectedFilterGUID == "0");
        }

        public function get filterResult():String
        {
            return this.filterResult;
        }

        public function set filterResult(arg1:String):void
        {
            var loc1:*=this.filterResult;
            if (loc1 !== arg1) 
            {
                this.filterResult = arg1;
                if (this.hasEventListener("propertyChange")) 
                {
                    this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "filterResult", loc1, arg1));
                }
            }
            return;
        }

        internal function filterWind(arg1:Object):Boolean
        {
            if (arg1 is core.activities.Activity && (arg1 as core.activities.Activity).windDefined) 
            {
                return _currentFilter.wind == arg1.wind;
            }
            return true;
        }

        public function get filterVector():__AS3__.vec.Vector.<core.filter.Filter>
        {
            return _filterVector;
        }

        public function set filterVector(arg1:__AS3__.vec.Vector.<core.filter.Filter>):void
        {
            _filterVector = arg1;
            return;
        }

        internal function filterTrainingType(arg1:Object):Boolean
        {
            if (arg1.hasOwnProperty("trainingType")) 
            {
                return !(arg1.trainingType.toLowerCase().search(_currentFilter.trainingType.toLowerCase()) == -1);
            }
            return true;
        }

        internal function filterParticipant(arg1:Object):Boolean
        {
            var loc2:*=null;
            var loc3:*=0;
            if (arg1 is core.activities.Activity) 
            {
                loc2 = mx.utils.StringUtil.trimArrayElements(_currentFilter.participant, ",").split(",");
                loc3 = 0;
                var loc8:*=0;
                var loc7:*=loc2;
                for each (var loc1:* in loc7) 
                {
                    var loc6:*=0;
                    var loc5:*=(arg1 as core.activities.Activity).participant;
                    for each (var loc4:* in loc5) 
                    {
                        if (loc4.name.toLowerCase().search(loc1.toLowerCase()) == -1) 
                        {
                            continue;
                        }
                        if (loc2.length == 1) 
                        {
                            return true;
                            continue;
                        }
                        ++loc3;
                    }
                }
                return loc3 == loc2.length;
            }
            return true;
        }

        public function set isFilterActive(arg1:Boolean):void
        {
            _isFilterActive = arg1;
            return;
        }

        internal function filterRating(arg1:Object):Boolean
        {
            if (arg1.hasOwnProperty("rating")) 
            {
                return arg1.rating == _currentFilter.rating;
            }
            return true;
        }

        public function get listItems():__AS3__.vec.Vector.<Object>
        {
            return this.listItems;
        }

        public function set listItems(arg1:__AS3__.vec.Vector.<Object>):void
        {
            var loc1:*=this.listItems;
            if (loc1 !== arg1) 
            {
                this.listItems = arg1;
                if (this.hasEventListener("propertyChange")) 
                {
                    this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "listItems", loc1, arg1));
                }
            }
            return;
        }

        internal function filterTrackActivities(arg1:Object):Boolean
        {
            var loc2:*=0;
            var loc3:*=0;
            if (_currentFilter.trackActivities == "" || !(arg1 is core.route.Route)) 
            {
                return true;
            }
            var loc4:*=_currentFilter.trackActivities.split(",");
            var loc1:*=arg1 as core.route.Route;
            if (loc1) 
            {
                if (loc1.routeOptions.length > 0 && loc4.length > 0) 
                {
                    loc2 = 0;
                    while (loc2 < loc1.routeOptions.length) 
                    {
                        loc3 = 0;
                        while (loc3 < loc4.length) 
                        {
                            if (loc1.routeOptions[loc2].param == loc4[loc3]) 
                            {
                                return true;
                            }
                            ++loc3;
                        }
                        ++loc2;
                    }
                    return false;
                }
            }
            return true;
        }

        public function get selectedFilterGUID():String
        {
            return _selectedFilterGUID;
        }

        public function set selectedFilterGUID(arg1:String):void
        {
            if (arg1 != _selectedFilterGUID) 
            {
                _selectedFilterGUID = arg1;
            }
            return;
        }

        public static function getInstance():handler.FilterHandler
        {
            if (_instance == null) 
            {
                _instance = new FilterHandler();
            }
            return _instance as FilterHandler;
        }

        public function readCache():void
        {
            var loc4:*=0;
            var loc3:*=null;
            var loc2:*=null;
            var loc1:*=configCache.ConfigCache.getInstance().configCacheObject.filters().length;
            loc4 = 0;
            while (loc4 < loc1) 
            {
                loc3 = configCache.ConfigCache.getInstance().configCacheObject.filters()[loc4];
                loc2 = core.filter.Filter.fromSharedObject(loc3);
                filterVector.push(loc2);
                ++loc4;
            }
            return;
        }

        public function validateFilterList():void
        {
            var loc5:*=null;
            var loc3:*=0;
            var loc2:*=null;
            listItems = new __AS3__.vec.Vector.<Object>();
            var loc4:*;
            (loc4 = {}).name = utils.LanguageManager.getString("DATA_LIST_FILTER_PLEASE_SELECT");
            loc4.GUID = 0;
            loc4.filter = defaultFilter;
            listItems.push(loc4);
            var loc1:*=filterVector.length;
            loc3 = 0;
            while (loc3 < loc1) 
            {
                if (!(loc5 = filterVector[loc3]).mode) 
                {
                    if (hasFilterTrackContent(loc5)) 
                    {
                        if (hasFilterActivityContent(loc5)) 
                        {
                            loc5.mode = "filterActivities";
                        }
                        else 
                        {
                            loc5.mode = "filterTracks";
                        }
                    }
                    else if (hasFilterActivityContent(loc5)) 
                    {
                        loc5.mode = "filterActivities";
                    }
                    else 
                    {
                        loc5.mode = "filterActivities";
                    }
                }
                if (!loc5.mode || filterMode == "filterTracks" && loc5.mode == "filterTracks" || !(filterMode == "filterTracks") && !(loc5.mode == "filterTracks")) 
                {
                    loc2 = {};
                    loc2.name = loc5.filterName;
                    loc2.GUID = loc5.GUID;
                    loc2.filter = loc5;
                    listItems.push(loc2);
                }
                ++loc3;
            }
            return;
        }

        public function getFilter(arg1:String):core.filter.Filter
        {
            var loc2:*=0;
            var loc1:*=filterVector.length;
            loc2 = 0;
            while (loc2 < loc1) 
            {
                if (filterVector[loc2].GUID == arg1) 
                {
                    return filterVector[loc2];
                }
                ++loc2;
            }
            if (arg1 == "1" || arg1 == "2") 
            {
                return null;
            }
            return defaultFilter;
        }

        public function updateFilter(arg1:core.filter.Filter):void
        {
            var loc2:*=0;
            var loc1:*=filterVector.length;
            loc2 = 0;
            while (loc2 < loc1) 
            {
                if (filterVector[loc2].GUID == arg1.GUID) 
                {
                    filterVector[loc2] = arg1;
                }
                ++loc2;
            }
            return;
        }

        public function addFilter(arg1:core.filter.Filter):void
        {
            var loc1:*=null;
            if (arg1.GUID != "1") 
            {
                if (arg1.GUID == "2") 
                {
                    loc1 = getFilter("2");
                    if (loc1 != null) 
                    {
                        return;
                    }
                }
            }
            else 
            {
                loc1 = getFilter("1");
                if (loc1 != null) 
                {
                    return;
                }
            }
            filterVector.push(arg1);
            return;
        }

        public function removeFilter(arg1:core.filter.Filter):void
        {
            var loc1:*=filterVector.indexOf(arg1);
            if (loc1 != -1) 
            {
                filterVector.splice(loc1, 1);
            }
            return;
        }

        public function executeFilter(arg1:*):*
        {
            _currentFilter = getFilter(selectedFilterGUID);
            if (_currentFilter) 
            {
                if (arg1 is __AS3__.vec.Vector.<core.activities.Activity>) 
                {
                    return (arg1 as __AS3__.vec.Vector.<core.activities.Activity>).filter(filter);
                }
                if (arg1 is __AS3__.vec.Vector.<core.route.Route>) 
                {
                    return (arg1 as __AS3__.vec.Vector.<core.route.Route>).filter(filter);
                }
            }
            return arg1;
        }

        public function filter(arg1:Object, arg2:int=0, arg3:*=null):Boolean
        {
            var loc1:*=true;
            if (_currentFilter.filterDate) 
            {
                if (loc1) 
                {
                    loc1 = filterDate(arg1);
                }
            }
            if (_currentFilter.filterClock) 
            {
                if (loc1) 
                {
                    loc1 = filterClock(arg1);
                }
            }
            if (_currentFilter.filterTourName) 
            {
                if (loc1) 
                {
                    loc1 = filterTourName(arg1);
                }
            }
            if (_currentFilter.filterType) 
            {
                if (loc1) 
                {
                    loc1 = filterType(arg1);
                }
            }
            if (_currentFilter.filterBike) 
            {
                if (loc1) 
                {
                    loc1 = filterBike(arg1);
                }
            }
            if (_currentFilter.filterTrainingTime) 
            {
                if (loc1) 
                {
                    loc1 = filterTrainingTime(arg1);
                }
            }
            if (_currentFilter.filterDistance) 
            {
                if (loc1) 
                {
                    loc1 = filterDistance(arg1);
                }
            }
            if (_currentFilter.filterAltitudeDifferencesUphill) 
            {
                if (loc1) 
                {
                    loc1 = filterAltitudeDifferencesUphill(arg1);
                }
            }
            if (_currentFilter.filterCalories) 
            {
                if (loc1) 
                {
                    loc1 = filterCalories(arg1);
                }
            }
            if (_currentFilter.filterTrackProfile) 
            {
                if (loc1) 
                {
                    loc1 = filterTrackProfile(arg1);
                }
            }
            if (_currentFilter.filterTrackType) 
            {
                if (loc1) 
                {
                    loc1 = filterTrackType(arg1);
                }
            }
            if (_currentFilter.filterWeather) 
            {
                if (loc1) 
                {
                    loc1 = filterWeather(arg1);
                }
            }
            if (_currentFilter.filterWind) 
            {
                if (loc1) 
                {
                    loc1 = filterWind(arg1);
                }
            }
            if (_currentFilter.filterTrainingType) 
            {
                if (loc1) 
                {
                    loc1 = filterTrainingType(arg1);
                }
            }
            if (_currentFilter.filterParticipant) 
            {
                if (loc1) 
                {
                    loc1 = filterParticipant(arg1);
                }
            }
            if (_currentFilter.filterRaiting) 
            {
                if (loc1) 
                {
                    loc1 = filterRating(arg1);
                }
            }
            if (_currentFilter.filterTrackActivities) 
            {
                if (loc1) 
                {
                    loc1 = filterTrackActivities(arg1);
                }
            }
            return loc1;
        }

        public function getfilterSQL(arg1:Date, arg2:Date):String
        {
            var loc7:*=null;
            var loc4:*=null;
            var loc5:*=0;
            if (useTmpFilter) 
            {
                tmpOldFilter = _currentFilter;
                _currentFilter = tmpFilter;
            }
            var loc1:*="";
            var loc6:*=utils.date.DateUtilCommon.dateToMySqlFormat(arg1);
            var loc8:*=utils.date.DateUtilCommon.dateToMySqlFormat(arg2);
            if (!_currentFilter || !isFilterActive) 
            {
                loc1 = "where strftime(\'%Y-%m-%d\', startDate) >= strftime(\'%Y-%m-%d\', \'" + loc6 + "\') " + "and strftime(\'%Y-%m-%d\', startDate) <=  strftime(\'%Y-%m-%d\', \'" + loc8 + "\') ";
                return loc1;
            }
            if (_currentFilter.filterDate) 
            {
                if (arg1 < _currentFilter.dateFrom) 
                {
                    arg1 = _currentFilter.dateFrom;
                }
                if (arg2 > _currentFilter.dateTo) 
                {
                    arg2 = _currentFilter.dateTo;
                }
                loc6 = utils.date.DateUtilCommon.dateToMySqlFormat(arg1);
                loc8 = utils.date.DateUtilCommon.dateToMySqlFormat(arg2);
                loc1 = "where strftime(\'%Y-%m-%d\', startDate) >= strftime(\'%Y-%m-%d\', \'" + loc6 + "\') " + "and strftime(\'%Y-%m-%d\', startDate) <=  strftime(\'%Y-%m-%d\', \'" + loc8 + "\') ";
            }
            else 
            {
                loc1 = "where strftime(\'%Y-%m-%d\', startDate) >= strftime(\'%Y-%m-%d\', \'" + loc6 + "\') " + "and strftime(\'%Y-%m-%d\', startDate) <=  strftime(\'%Y-%m-%d\', \'" + loc8 + "\') ";
            }
            if (_currentFilter.filterClock) 
            {
                loc7 = utils.date.DateUtilCommon.dateToMySqlFormat(_currentFilter.clockFrom);
                loc4 = utils.date.DateUtilCommon.dateToMySqlFormat(_currentFilter.clockTo);
                loc1 = loc1 + ("and strftime(\'%H-%M\', startDate) >=  strftime(\'%H-%M\', \'" + loc7 + "\') " + "and strftime(\'%H-%M\', startDate) <=  strftime(\'%H-%M\', \'" + loc4 + "\') ");
            }
            if (_currentFilter.filterTourName) 
            {
                loc1 = loc1 + ("and lower(name) like lower(\'%" + _currentFilter.tourName + "%\') ");
            }
            if (_currentFilter.filterType) 
            {
                loc1 = loc1 + ("and dataType == \'" + _currentFilter.type + "\' ");
            }
            if (_currentFilter.filterBike) 
            {
                loc1 = loc1 + ("and bike == \'" + _currentFilter.bike + "\' ");
            }
            if (_currentFilter.filterTrainingTime) 
            {
                loc1 = loc1 + ("and trainingTime >= " + _currentFilter.trainingTimeFrom + " and trainingTime <= " + _currentFilter.trainingTimeTo + " ");
            }
            if (_currentFilter.filterDistance) 
            {
                loc1 = loc1 + ("and distance >= " + _currentFilter.distanceFrom + " and distance <= " + _currentFilter.distanceTo + " ");
            }
            if (_currentFilter.filterAltitudeDifferencesUphill) 
            {
                loc1 = loc1 + ("and altitudeDifferencesUphill >= " + _currentFilter.altitudeDifferencesUphillFrom + " and altitudeDifferencesUphill <= " + _currentFilter.altitudeDifferencesUphillTo + " ");
            }
            if (_currentFilter.filterCalories) 
            {
                loc1 = loc1 + ("and calories >= " + _currentFilter.caloriesFrom + " and calories <= " + _currentFilter.caloriesTo + " ");
            }
            if (_currentFilter.filterTrackProfile) 
            {
                loc1 = loc1 + ("and trackProfile == " + _currentFilter.trackProfile + " ");
            }
            if (_currentFilter.filterWeather) 
            {
                loc1 = loc1 + ("and weather == " + _currentFilter.weather + " ");
            }
            if (_currentFilter.filterWind) 
            {
                loc1 = loc1 + ("and wind == " + _currentFilter.wind + " ");
            }
            if (_currentFilter.filterTrainingType) 
            {
                loc1 = loc1 + ("and trainingType == \'" + _currentFilter.trainingType + "\' ");
            }
            if (_currentFilter.filterParticipant) 
            {
                if (_currentFilter.participant.length > 0) 
                {
                    var loc2:*;
                    var loc3:*=(loc2 = mx.utils.StringUtil.trimArrayElements(_currentFilter.participant, ",").split(",")).length;
                    loc5 = 0;
                    while (loc5 < loc3) 
                    {
                        loc2[loc5] = "GROUP_CONCAT(personName) like \'%" + loc2[loc5] + "%\'";
                        ++loc5;
                    }
                    loc1 = loc1 + ("and Activity.activityId in (select ActivityPerson.activityId from ActivityPerson left join Person on ActivityPerson.personId = Person.personId group by ActivityPerson.activityId having " + loc2.join(" and ") + ") ");
                }
            }
            if (_currentFilter.filterRaiting) 
            {
                loc1 = loc1 + ("and rating == \'" + _currentFilter.rating + "\' ");
            }
            if (useTmpFilter) 
            {
                useTmpFilter = false;
                _currentFilter = tmpOldFilter;
                tmpFilter = null;
            }
            return loc1;
        }

        internal function hasFilterActivityContent(arg1:core.filter.Filter):Boolean
        {
            return arg1.filterClock || arg1.filterType || arg1.filterBike || arg1.filterTrainingTime || arg1.filterCalories || arg1.filterWeather || arg1.filterWind || arg1.filterTrainingType || arg1.filterParticipant;
        }

        internal function hasFilterTrackContent(arg1:core.filter.Filter):Boolean
        {
            return arg1.filterTrackActivities || arg1.filterTrackType || arg1.filterTrackProfile;
        }

        internal function filterDate(arg1:Object):Boolean
        {
            var loc3:*=null;
            if (arg1 is core.activities.Activity && (arg1 as core.activities.Activity).startDateDefined) 
            {
                loc3 = (arg1 as core.activities.Activity).startDate;
            }
            else if (arg1 is core.route.Route && (arg1 as core.route.Route).creationTimestamp) 
            {
                loc3 = (arg1 as core.route.Route).creationTimestamp;
            }
            else 
            {
                return true;
            }
            var loc1:*=new Date(loc3.getFullYear(), loc3.getMonth(), loc3.getDate());
            var loc4:*=_currentFilter.dateFrom;
            var loc2:*=_currentFilter.dateTo;
            if (loc4 == null) 
            {
                if (loc2 == null) 
                {
                    return true;
                }
                return loc1 <= loc2;
            }
            if (loc2 == null) 
            {
                return loc1 >= loc4;
            }
            return loc1 >= loc4 && loc1 <= loc2;
        }

        internal function filterClock(arg1:Object):Boolean
        {
            var loc3:*=null;
            if (arg1 is core.activities.Activity && (arg1 as core.activities.Activity).startDateDefined) 
            {
                loc3 = (arg1 as core.activities.Activity).startDate;
            }
            else if (arg1 is core.route.Route && (arg1 as core.route.Route).creationTimestamp) 
            {
                loc3 = (arg1 as core.route.Route).creationTimestamp;
            }
            else 
            {
                return true;
            }
            var loc1:*=new Date(loc3.getFullYear(), loc3.getMonth(), loc3.getDate(), loc3.hours, loc3.minutes);
            var loc4:*=new Date(loc3.getFullYear(), loc3.getMonth(), loc3.getDate(), _currentFilter.clockFrom.hours, _currentFilter.clockFrom.minutes);
            var loc2:*=new Date(loc3.getFullYear(), loc3.getMonth(), loc3.getDate(), _currentFilter.clockTo.hours, _currentFilter.clockTo.minutes);
            if (loc4 == null) 
            {
                if (loc2 == null) 
                {
                    return true;
                }
                return loc1 <= loc2;
            }
            if (loc2 == null) 
            {
                return loc1 >= loc4;
            }
            return loc1 >= loc4 && loc1 <= loc2;
        }

        internal function filterTourName(arg1:Object):Boolean
        {
            var loc1:*=_currentFilter.tourName.toLowerCase();
            if (arg1.hasOwnProperty("name")) 
            {
                return !(arg1.name.toLowerCase().search(loc1) == -1);
            }
            return true;
        }

        internal function filterType(arg1:Object):Boolean
        {
            if (arg1 is core.activities.Activity) 
            {
                return (arg1 as core.activities.Activity).dataType == _currentFilter.type;
            }
            return true;
        }

        internal function filterBike(arg1:Object):Boolean
        {
            if (arg1 is core.activities.Activity) 
            {
                return _currentFilter.bike == arg1.bike;
            }
            return true;
        }

        internal function filterTrainingTime(arg1:Object):Boolean
        {
            if (arg1.hasOwnProperty("trainingTime")) 
            {
                if (_currentFilter.trainingTimeTo > 0) 
                {
                    return _currentFilter.trainingTimeFrom <= arg1.trainingTime && _currentFilter.trainingTimeTo >= arg1.trainingTime;
                }
                return _currentFilter.trainingTimeFrom <= arg1.trainingTime;
            }
            return true;
        }

        internal function filterDistance(arg1:Object):Boolean
        {
            if (arg1.hasOwnProperty("distance")) 
            {
                if (_currentFilter.distanceTo > 0) 
                {
                    return _currentFilter.distanceFrom <= arg1.distance && _currentFilter.distanceTo >= arg1.distance;
                }
                return _currentFilter.distanceFrom <= arg1.distance;
            }
            return true;
        }

        internal function filterAltitudeDifferencesUphill(arg1:Object):Boolean
        {
            if (arg1.hasOwnProperty("altitudeDifferencesUphill")) 
            {
                if (_currentFilter.altitudeDifferencesUphillTo > 0) 
                {
                    return _currentFilter.altitudeDifferencesUphillFrom <= arg1.altitudeDifferencesUphill && _currentFilter.altitudeDifferencesUphillTo >= arg1.altitudeDifferencesUphill;
                }
                return _currentFilter.altitudeDifferencesUphillFrom <= arg1.altitudeDifferencesUphill;
            }
            return true;
        }

        internal function filterCalories(arg1:Object):Boolean
        {
            if (arg1.hasOwnProperty("calories")) 
            {
                if (_currentFilter.caloriesTo > 0) 
                {
                    return _currentFilter.caloriesFrom <= arg1.calories && _currentFilter.caloriesTo >= arg1.calories;
                }
                return _currentFilter.caloriesFrom <= arg1.calories;
            }
            return true;
        }

        internal function filterTrackProfile(arg1:Object):Boolean
        {
            var loc1:*=false;
            var loc3:*=0;
            var loc2:*=0;
            var loc4:*=null;
            if (arg1 is core.activities.Activity && (arg1 as core.activities.Activity).trackProfileDefined) 
            {
                return _currentFilter.trackProfile == arg1.trackProfile;
            }
        }

        internal var _defaultFilter:core.filter.Filter;

        internal var filterMode:String;

        internal var _filterVector:__AS3__.vec.Vector.<core.filter.Filter>;

        internal var _isFilterActive:Boolean=false;

        internal var filterResult:String;

        internal var listItems:__AS3__.vec.Vector.<Object>;

        internal var _selectedFilterGUID:String="0";

        internal var _currentFilter:core.filter.Filter;

        public static var useTmpFilter:Boolean=true;

        internal static var _instance:handler.FilterHandler;

        internal static var tmpOldFilter:core.filter.Filter;

        public static var tmpFilter:core.filter.Filter;
    }
}


