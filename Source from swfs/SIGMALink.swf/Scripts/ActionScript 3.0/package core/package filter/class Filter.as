//class Filter
package core.filter 
{
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;
    import utils.*;
    
    public class Filter extends flash.events.EventDispatcher
    {
        public function Filter(arg1:flash.events.IEventDispatcher=null)
        {
            _clockFrom = new Date();
            _clockTo = new Date();
            _dateFrom = new Date();
            _dateTo = new Date();
            super(arg1);
            var loc1:*=new Date();
            dateFrom = new Date(loc1.fullYear, 0, 1, 0, 0);
            clockFrom = dateFrom;
            dateTo = new Date(loc1.fullYear, 11, 31, 23, 59);
            clockTo = dateTo;
            return;
        }

        public function get trackActivities():String
        {
            return _trackActivities;
        }

        public function get GUID():String
        {
            return _GUID;
        }

        public function set GUID(arg1:String):void
        {
            _GUID = arg1;
            return;
        }

        public function set trackActivities(arg1:String):void
        {
            if (_trackActivities !== arg1) 
            {
                _trackActivities = arg1;
                dispatchEvent(new flash.events.Event("trackActivitiesChange"));
                dispatchEvent(new flash.events.Event("filterValueChanged"));
            }
            return;
        }

        public function get altitudeDifferencesUphillFrom():int
        {
            return _altitudeDifferencesUphillFrom;
        }

        public function set altitudeDifferencesUphillFrom(arg1:int):void
        {
            if (arg1 != _altitudeDifferencesUphillFrom) 
            {
                _altitudeDifferencesUphillFrom = arg1;
                dispatchEvent(new flash.events.Event("altitudeDifferencesUphillFromChange"));
                dispatchEvent(new flash.events.Event("filterValueChanged"));
            }
            return;
        }

        public function get trackProfile():int
        {
            return _trackProfile;
        }

        public function get altitudeDifferencesUphillTo():int
        {
            return _altitudeDifferencesUphillTo;
        }

        public function set altitudeDifferencesUphillTo(arg1:int):void
        {
            if (arg1 != _altitudeDifferencesUphillTo) 
            {
                _altitudeDifferencesUphillTo = arg1;
                dispatchEvent(new flash.events.Event("altitudeDifferencesUphillToChange"));
                dispatchEvent(new flash.events.Event("filterValueChanged"));
            }
            return;
        }

        public function set trackProfile(arg1:int):void
        {
            if (arg1 != _trackProfile) 
            {
                _trackProfile = arg1;
                dispatchEvent(new flash.events.Event("trackProfileChange"));
                dispatchEvent(new flash.events.Event("filterValueChanged"));
            }
            return;
        }

        public function get bike():String
        {
            return _bike;
        }

        public function set bike(arg1:String):void
        {
            if (arg1 != _bike) 
            {
                _bike = arg1;
                dispatchEvent(new flash.events.Event("bikeChange"));
                dispatchEvent(new flash.events.Event("filterValueChanged"));
            }
            return;
        }

        public function get trackType():String
        {
            return _trackType;
        }

        public function get caloriesFrom():int
        {
            return _caloriesFrom;
        }

        public function set caloriesFrom(arg1:int):void
        {
            if (arg1 != _caloriesFrom) 
            {
                _caloriesFrom = arg1;
                dispatchEvent(new flash.events.Event("caloriesFromChange"));
                dispatchEvent(new flash.events.Event("filterValueChanged"));
            }
            return;
        }

        public function set trackType(arg1:String):void
        {
            if (_trackType !== arg1) 
            {
                _trackType = arg1;
                dispatchEvent(new flash.events.Event("trackTypeChange"));
                dispatchEvent(new flash.events.Event("filterValueChanged"));
            }
            return;
        }

        public function get caloriesTo():int
        {
            return _caloriesTo;
        }

        public function set caloriesTo(arg1:int):void
        {
            if (arg1 != _caloriesTo) 
            {
                _caloriesTo = arg1;
                dispatchEvent(new flash.events.Event("caloriesToChange"));
                dispatchEvent(new flash.events.Event("filterValueChanged"));
            }
            return;
        }

        public function get trainingTimeFrom():int
        {
            return _trainingTimeFrom;
        }

        public function get clockFrom():Date
        {
            return _clockFrom;
        }

        public function set clockFrom(arg1:Date):void
        {
            if (arg1 != _clockFrom) 
            {
                _clockFrom = arg1;
                dispatchEvent(new flash.events.Event("clockFromChange"));
                dispatchEvent(new flash.events.Event("filterValueChanged"));
            }
            return;
        }

        public function set trainingTimeFrom(arg1:int):void
        {
            if (arg1 != _trainingTimeFrom) 
            {
                _trainingTimeFrom = arg1;
                dispatchEvent(new flash.events.Event("trainingTimeFromChange"));
                dispatchEvent(new flash.events.Event("filterValueChanged"));
            }
            return;
        }

        public function get clockTo():Date
        {
            return _clockTo;
        }

        public function set clockTo(arg1:Date):void
        {
            if (arg1 != _clockTo) 
            {
                _clockTo = arg1;
                dispatchEvent(new flash.events.Event("clockToChange"));
                dispatchEvent(new flash.events.Event("filterValueChanged"));
            }
            return;
        }

        public function get trainingTimeTo():int
        {
            return _trainingTimeTo;
        }

        public function get dateFrom():Date
        {
            return _dateFrom;
        }

        public function set dateFrom(arg1:Date):void
        {
            if (arg1 != _dateFrom) 
            {
                _dateFrom = arg1;
                dispatchEvent(new flash.events.Event("dateFromChange"));
                dispatchEvent(new flash.events.Event("filterValueChanged"));
            }
            return;
        }

        public function set trainingTimeTo(arg1:int):void
        {
            if (arg1 != _trainingTimeTo) 
            {
                _trainingTimeTo = arg1;
                dispatchEvent(new flash.events.Event("trainingTimeToChange"));
                dispatchEvent(new flash.events.Event("filterValueChanged"));
            }
            return;
        }

        public function get dateTo():Date
        {
            return _dateTo;
        }

        public function set dateTo(arg1:Date):void
        {
            if (arg1 != _dateTo) 
            {
                _dateTo = arg1;
                dispatchEvent(new flash.events.Event("dateToChange"));
                dispatchEvent(new flash.events.Event("filterValueChanged"));
            }
            return;
        }

        public static function fromSharedObject(arg1:Object):core.filter.Filter
        {
            var loc1:*=new Filter();
            loc1.GUID = arg1.GUID;
            loc1.filterName = arg1.filterName;
            loc1.filterDate = arg1.filterDate;
            loc1.dateFrom = new Date(arg1.dateFrom);
            loc1.dateTo = new Date(arg1.dateTo);
            loc1.filterClock = arg1.filterClock;
            loc1.clockFrom = new Date(arg1.clockFrom);
            loc1.clockTo = new Date(arg1.clockTo);
            loc1.filterTourName = arg1.filterTourName;
            loc1.tourName = arg1.tourName;
            loc1.filterType = arg1.filterType;
            loc1.type = arg1.type;
            loc1.filterBike = arg1.filterBike;
            loc1.bike = arg1.bike;
            loc1.filterTrainingTime = arg1.filterTrainingTime;
            loc1.trainingTimeFrom = arg1.trainingTimeFrom;
            loc1.trainingTimeTo = arg1.trainingTimeTo;
            loc1.filterDistance = arg1.filterDistance;
            loc1.distanceFrom = arg1.distanceFrom;
            loc1.distanceTo = arg1.distanceTo;
            loc1.filterAltitudeDifferencesUphill = arg1.filterAltitudeDifferencesUphill;
            loc1.altitudeDifferencesUphillFrom = arg1.altitudeDifferencesUphillFrom;
            loc1.altitudeDifferencesUphillTo = arg1.altitudeDifferencesUphillTo;
            loc1.filterCalories = arg1.filterCalories;
            loc1.caloriesFrom = arg1.caloriesFrom;
            loc1.caloriesTo = arg1.caloriesTo;
            loc1.filterTrackProfile = arg1.filterTrackProfile;
            loc1.trackProfile = arg1.trackProfile;
            loc1.filterTrackType = arg1.filterTrackType;
            loc1.trackType = arg1.trackType;
            loc1.filterWeather = arg1.filterWeather;
            loc1.weather = arg1.weather;
            loc1.filterWind = arg1.filterWind;
            loc1.wind = arg1.wind;
            loc1.filterTrainingType = arg1.filterTrainingType;
            loc1.trainingType = arg1.trainingType;
            loc1.filterParticipant = arg1.filterParticipant;
            loc1.participant = arg1.participant;
            loc1.filterRaiting = arg1.filterRating;
            loc1.rating = arg1.rating;
            loc1.filterTrackActivities = arg1.filterTrackActivities;
            loc1.trackActivities = arg1.trackActivities;
            loc1.mode = arg1.mode;
            return loc1;
        }

        public function get distanceFrom():Number
        {
            return _distanceFrom;
        }

        public function set distanceFrom(arg1:Number):void
        {
            if (arg1 != _distanceFrom) 
            {
                _distanceFrom = arg1;
                dispatchEvent(new flash.events.Event("distanceFromChange"));
                dispatchEvent(new flash.events.Event("filterValueChanged"));
            }
            return;
        }

        public function get trainingType():String
        {
            return _trainingType;
        }

        public function get distanceTo():Number
        {
            return _distanceTo;
        }

        public function set distanceTo(arg1:Number):void
        {
            if (arg1 != _distanceTo) 
            {
                _distanceTo = arg1;
                dispatchEvent(new flash.events.Event("distanceToChange"));
                dispatchEvent(new flash.events.Event("filterValueChanged"));
            }
            return;
        }

        public function set trainingType(arg1:String):void
        {
            if (arg1 != _trainingType) 
            {
                _trainingType = arg1;
                dispatchEvent(new flash.events.Event("trainingTypeChange"));
                dispatchEvent(new flash.events.Event("filterValueChanged"));
            }
            return;
        }

        public function get filterAltitudeDifferencesUphill():Boolean
        {
            return _filterAltitudeDifferencesUphill;
        }

        public function set filterAltitudeDifferencesUphill(arg1:Boolean):void
        {
            if (_filterAltitudeDifferencesUphill !== arg1) 
            {
                _filterAltitudeDifferencesUphill = arg1;
                dispatchEvent(new flash.events.Event("filterAltitudeDifferencesUphillChange"));
                dispatchEvent(new flash.events.Event("filterValueChanged"));
            }
            return;
        }

        public function get type():String
        {
            return _type;
        }

        public function get filterBike():Boolean
        {
            return _filterBike;
        }

        public function set filterBike(arg1:Boolean):void
        {
            if (_filterBike !== arg1) 
            {
                _filterBike = arg1;
                dispatchEvent(new flash.events.Event("filterBikeChange"));
                dispatchEvent(new flash.events.Event("filterValueChanged"));
            }
            return;
        }

        public function set type(arg1:String):void
        {
            if (arg1 != _type) 
            {
                _type = arg1;
                dispatchEvent(new flash.events.Event("typeChange"));
                dispatchEvent(new flash.events.Event("filterValueChanged"));
            }
            return;
        }

        public function get filterCalories():Boolean
        {
            return _filterCalories;
        }

        public function set filterCalories(arg1:Boolean):void
        {
            if (_filterCalories !== arg1) 
            {
                _filterCalories = arg1;
                dispatchEvent(new flash.events.Event("filterCaloriesChange"));
                dispatchEvent(new flash.events.Event("filterValueChanged"));
            }
            return;
        }

        public function get weather():int
        {
            return _weather;
        }

        public function get filterClock():Boolean
        {
            return _filterClock;
        }

        public function set filterClock(arg1:Boolean):void
        {
            if (_filterClock !== arg1) 
            {
                _filterClock = arg1;
                dispatchEvent(new flash.events.Event("filterClockChange"));
                dispatchEvent(new flash.events.Event("filterValueChanged"));
            }
            return;
        }

        public function set weather(arg1:int):void
        {
            if (arg1 != _weather) 
            {
                _weather = arg1;
                dispatchEvent(new flash.events.Event("weatherChange"));
                dispatchEvent(new flash.events.Event("filterValueChanged"));
            }
            return;
        }

        public function get filterDate():Boolean
        {
            return _filterDate;
        }

        public function set filterDate(arg1:Boolean):void
        {
            if (_filterDate !== arg1) 
            {
                _filterDate = arg1;
                dispatchEvent(new flash.events.Event("filterDateChange"));
                dispatchEvent(new flash.events.Event("filterValueChanged"));
            }
            return;
        }

        public function get wind():int
        {
            return _wind;
        }

        public function get filterDistance():Boolean
        {
            return _filterDistance;
        }

        public function set filterDistance(arg1:Boolean):void
        {
            if (_filterDistance !== arg1) 
            {
                _filterDistance = arg1;
                dispatchEvent(new flash.events.Event("filterDistanceChange"));
                dispatchEvent(new flash.events.Event("filterValueChanged"));
            }
            return;
        }

        public function set wind(arg1:int):void
        {
            if (arg1 != _wind) 
            {
                _wind = arg1;
                dispatchEvent(new flash.events.Event("windChange"));
                dispatchEvent(new flash.events.Event("filterValueChanged"));
            }
            return;
        }

        public function get filterName():String
        {
            return _filterName;
        }

        public function set filterName(arg1:String):void
        {
            if (arg1 != _filterName) 
            {
                _filterName = arg1;
                dispatchEvent(new flash.events.Event("filterNameChange"));
            }
            return;
        }

        public function getLoggingInfo():String
        {
            return "\t-GUID " + GUID + "\t-filterDate " + filterDate + "\t-filterClock " + filterClock + "\t-filterName " + filterName + "\t-filterRaiting " + filterRaiting;
        }

        public function get filterParticipant():Boolean
        {
            return _filterParticipant;
        }

        public function set filterParticipant(arg1:Boolean):void
        {
            if (_filterParticipant !== arg1) 
            {
                _filterParticipant = arg1;
                dispatchEvent(new flash.events.Event("filterParticipantChange"));
                dispatchEvent(new flash.events.Event("filterValueChanged"));
            }
            return;
        }

        public override function toString():String
        {
            return "[Filter extends EventDispatcher]";
        }

        public function get filterRaiting():Boolean
        {
            return _filterRaiting;
        }

        public function set filterRaiting(arg1:Boolean):void
        {
            if (_filterRaiting !== arg1) 
            {
                _filterRaiting = arg1;
                dispatchEvent(new flash.events.Event("filterRaitingChange"));
                dispatchEvent(new flash.events.Event("filterValueChanged"));
            }
            return;
        }

        public static function copy(arg1:core.filter.Filter):core.filter.Filter
        {
            var loc1:*=flash.utils.getQualifiedClassName(arg1);
            flash.net.registerClassAlias(loc1, flash.utils.getDefinitionByName(loc1) as Class);
            var loc2:*=utils.BackendUtil.copy(arg1) as Filter;
            return loc2;
        }

        public function get filterTourName():Boolean
        {
            return _filterTourName;
        }

        public function set filterTourName(arg1:Boolean):void
        {
            if (_filterTourName !== arg1) 
            {
                _filterTourName = arg1;
                dispatchEvent(new flash.events.Event("filterTourNameChange"));
                dispatchEvent(new flash.events.Event("filterValueChanged"));
            }
            return;
        }

        public static function toSharedObject(arg1:core.filter.Filter):Object
        {
            var loc1:*={};
            loc1.GUID = arg1.GUID;
            loc1.filterName = arg1.filterName;
            loc1.filterDate = arg1.filterDate;
            loc1.dateFrom = arg1.dateFrom.toString();
            loc1.dateTo = arg1.dateTo.toString();
            loc1.filterClock = arg1.filterClock;
            loc1.clockFrom = arg1.clockFrom.toString();
            loc1.clockTo = arg1.clockTo.toString();
            loc1.filterTourName = arg1.filterTourName;
            loc1.tourName = arg1.tourName;
            loc1.filterType = arg1.filterType;
            loc1.type = arg1.type;
            loc1.filterBike = arg1.filterBike;
            loc1.bike = arg1.bike;
            loc1.filterTrainingTime = arg1.filterTrainingTime;
            loc1.trainingTimeFrom = arg1.trainingTimeFrom;
            loc1.trainingTimeTo = arg1.trainingTimeTo;
            loc1.filterDistance = arg1.filterDistance;
            loc1.distanceFrom = arg1.distanceFrom;
            loc1.distanceTo = arg1.distanceTo;
            loc1.filterAltitudeDifferencesUphill = arg1.filterAltitudeDifferencesUphill;
            loc1.altitudeDifferencesUphillFrom = arg1.altitudeDifferencesUphillFrom;
            loc1.altitudeDifferencesUphillTo = arg1.altitudeDifferencesUphillTo;
            loc1.filterCalories = arg1.filterCalories;
            loc1.caloriesFrom = arg1.caloriesFrom;
            loc1.caloriesTo = arg1.caloriesTo;
            loc1.filterTrackProfile = arg1.filterTrackProfile;
            loc1.trackProfile = arg1.trackProfile;
            loc1.filterTrackType = arg1.filterTrackType;
            loc1.trackType = arg1.trackType;
            loc1.filterWeather = arg1.filterWeather;
            loc1.weather = arg1.weather;
            loc1.filterWind = arg1.filterWind;
            loc1.wind = arg1.wind;
            loc1.filterTrainingType = arg1.filterTrainingType;
            loc1.trainingType = arg1.trainingType;
            loc1.filterParticipant = arg1.filterParticipant;
            loc1.participant = arg1.participant;
            loc1.filterRating = arg1.filterRaiting;
            loc1.rating = arg1.rating;
            loc1.filterTrackActivities = arg1.filterTrackActivities;
            loc1.trackActivities = arg1.trackActivities;
            loc1.mode = arg1.mode;
            return loc1;
        }

        public function get filterTrackActivities():Boolean
        {
            return _filterTrackActivities;
        }

        public function set filterTrackActivities(arg1:Boolean):void
        {
            if (_filterTrackActivities !== arg1) 
            {
                _filterTrackActivities = arg1;
                dispatchEvent(new flash.events.Event("filterTrackActivitiesChange"));
                dispatchEvent(new flash.events.Event("filterValueChanged"));
            }
            return;
        }

        public function get filterTrackProfile():Boolean
        {
            return _filterTrackProfile;
        }

        public function set filterTrackProfile(arg1:Boolean):void
        {
            if (_filterTrackProfile !== arg1) 
            {
                _filterTrackProfile = arg1;
                dispatchEvent(new flash.events.Event("filterTrackProfileChange"));
                dispatchEvent(new flash.events.Event("filterValueChanged"));
            }
            return;
        }

        public function get filterTrackType():Boolean
        {
            return _filterTrackType;
        }

        public function set filterTrackType(arg1:Boolean):void
        {
            if (_filterTrackType !== arg1) 
            {
                _filterTrackType = arg1;
                dispatchEvent(new flash.events.Event("filterTrackTypeChange"));
                dispatchEvent(new flash.events.Event("filterValueChanged"));
            }
            return;
        }

        public function get filterTrainingTime():Boolean
        {
            return _filterTrainingTime;
        }

        public function set filterTrainingTime(arg1:Boolean):void
        {
            if (_filterTrainingTime !== arg1) 
            {
                _filterTrainingTime = arg1;
                dispatchEvent(new flash.events.Event("filterTrainingTimeChange"));
                dispatchEvent(new flash.events.Event("filterValueChanged"));
            }
            return;
        }

        public function get filterTrainingType():Boolean
        {
            return _filterTrainingType;
        }

        public function set filterTrainingType(arg1:Boolean):void
        {
            if (_filterTrainingType !== arg1) 
            {
                _filterTrainingType = arg1;
                dispatchEvent(new flash.events.Event("filterTrainingTypeChange"));
                dispatchEvent(new flash.events.Event("filterValueChanged"));
            }
            return;
        }

        public function get filterType():Boolean
        {
            return _filterType;
        }

        public function set filterType(arg1:Boolean):void
        {
            if (_filterType !== arg1) 
            {
                _filterType = arg1;
                dispatchEvent(new flash.events.Event("filterTypeChange"));
                dispatchEvent(new flash.events.Event("filterValueChanged"));
            }
            return;
        }

        public function get filterWeather():Boolean
        {
            return _filterWeather;
        }

        public function set filterWeather(arg1:Boolean):void
        {
            if (_filterWeather !== arg1) 
            {
                _filterWeather = arg1;
                dispatchEvent(new flash.events.Event("filterWeatherChange"));
                dispatchEvent(new flash.events.Event("filterValueChanged"));
            }
            return;
        }

        public function get filterWind():Boolean
        {
            return _filterWind;
        }

        public function set filterWind(arg1:Boolean):void
        {
            if (_filterWind !== arg1) 
            {
                _filterWind = arg1;
                dispatchEvent(new flash.events.Event("filterWindChange"));
                dispatchEvent(new flash.events.Event("filterValueChanged"));
            }
            return;
        }

        public function get mode():String
        {
            return _mode;
        }

        public function set mode(arg1:String):void
        {
            if (_filterTrackActivities !== arg1) 
            {
                dispatchEvent(new flash.events.Event("modeChange"));
                _mode = arg1;
            }
            return;
        }

        public function get participant():String
        {
            return _participant;
        }

        public function set participant(arg1:String):void
        {
            if (arg1 != _participant) 
            {
                _participant = arg1;
                dispatchEvent(new flash.events.Event("participantChange"));
                dispatchEvent(new flash.events.Event("filterValueChanged"));
            }
            return;
        }

        public function get rating():int
        {
            return _rating;
        }

        public function set rating(arg1:int):void
        {
            if (arg1 != _rating) 
            {
                _rating = arg1;
                dispatchEvent(new flash.events.Event("ratingChange"));
                dispatchEvent(new flash.events.Event("filterValueChanged"));
            }
            return;
        }

        public function get tourName():String
        {
            return _tourName;
        }

        public function set tourName(arg1:String):void
        {
            if (arg1 != _tourName) 
            {
                _tourName = arg1;
                dispatchEvent(new flash.events.Event("tourNameChange"));
                dispatchEvent(new flash.events.Event("filterValueChanged"));
            }
            return;
        }

        public static const FILTER_VALUE_CHANGED:String="filterValueChanged";

        protected var _altitudeDifferencesUphillFrom:int=0;

        protected var _altitudeDifferencesUphillTo:int=0;

        protected var _bike:String="bike1";

        protected var _caloriesFrom:int=0;

        protected var _caloriesTo:int=0;

        protected var _clockFrom:Date;

        protected var _clockTo:Date;

        protected var _dateFrom:Date;

        protected var _dateTo:Date;

        protected var _distanceFrom:Number=0;

        protected var _distanceTo:Number=0;

        internal var _filterAltitudeDifferencesUphill:Boolean=false;

        internal var _filterBike:Boolean=false;

        internal var _filterCalories:Boolean=false;

        internal var _filterClock:Boolean=false;

        internal var _filterDate:Boolean=false;

        internal var _filterDistance:Boolean=false;

        protected var _filterName:String;

        internal var _filterParticipant:Boolean=false;

        internal var _filterRaiting:Boolean=false;

        internal var _filterTourName:Boolean=false;

        protected var _filterTrackActivities:Boolean=false;

        protected var _trainingTimeTo:int=0;

        protected var _tourName:String="";

        protected var _filterTrackType:Boolean=false;

        internal var _mode:String="";

        protected var _trackActivities:String="";

        internal var _filterTrainingType:Boolean=false;

        protected var _type:String="memory";

        internal var _filterWeather:Boolean=false;

        protected var _trackProfile:int=0;

        protected var _weather:int=0;

        protected var _participant:String="";

        internal var _filterTrainingTime:Boolean=false;

        protected var _wind:int=0;

        protected var _trackType:String="alltrips";

        internal var _filterTrackProfile:Boolean=false;

        protected var _rating:int=1;

        protected var _trainingTimeFrom:int=0;

        protected var _GUID:String="0";

        internal var _filterWind:Boolean=false;

        internal var _filterType:Boolean=false;

        protected var _trainingType:String="";
    }
}


