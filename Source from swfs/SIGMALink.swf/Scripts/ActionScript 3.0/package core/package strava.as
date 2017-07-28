//package strava
//  class StravaApiBase
package core.strava 
{
    public class StravaApiBase extends Object
    {
        public function StravaApiBase()
        {
            super();
            return;
        }

        public function fromObject(arg1:Object, arg2:Array=null):core.strava.StravaApiBase
        {
            var loc1:*=null;
            var loc3:*=0;
            if (arg1 != null) 
            {
                if (arg2 == null) 
                {
                    var loc6:*=0;
                    var loc5:*=arg1;
                    for (var loc4:* in loc5) 
                    {
                        setVarFromObject(this, arg1, loc4);
                    }
                }
                else 
                {
                    loc3 = 0;
                    var loc2:*=arg2.length;
                    while (loc3 < loc2) 
                    {
                        loc1 = arg2[loc3] as String;
                        setVarFromObject(this, arg1, loc1);
                        ++loc3;
                    }
                }
            }
            return this;
        }

        protected function setVarFromObject(arg1:Object, arg2:Object, arg3:String):void
        {
            var loc1:*=null;
            if (arg1.hasOwnProperty(arg3) && arg2.hasOwnProperty(arg3)) 
            {
                arg1[arg3] = arg2[arg3];
            }
            return;
        }
    }
}


//  class StravaAthlete
package core.strava 
{
    public class StravaAthlete extends core.strava.StravaApiBase
    {
        public function StravaAthlete()
        {
            super();
            return;
        }

        public function isPremium():Boolean
        {
            return premium;
        }

        public static const FIELD_CITY:String="city";

        public static const FIELD_COUNTRY:String="country";

        public static const FIELD_CREATED_AT:String="created_at";

        public static const FIELD_FIRSTNAME:String="firstname";

        public static const FIELD_FOLLOWER:String="follower";

        public static const FIELD_FRIEND:String="friend";

        public static const FIELD_ID:String="id";

        public static const FIELD_LASTNAME:String="lastname";

        public static const FIELD_PREMIUM:String="premium";

        public static const FIELD_PROFILE:String="profile";

        public static const FIELD_PROFILE_MEDIUM:String="profile_medium";

        public static const FIELD_RESOURCE_STATE:String="resource_state";

        public static const FIELD_SEX:String="sex";

        public static const FIELD_STATE:String="state";

        public static const FIELD_UPDATED_AT:String="updated_at";

        public var city:String;

        public var country:String;

        public var created_at:String;

        public var firstname:String;

        public var follower:String;

        public var friend:String;

        public var id:int;

        public var lastname:String;

        public var premium:Boolean;

        public var profile:String;

        public var profile_medium:String;

        public var resource_state:int;

        public var sex:String;

        public var state:String;

        public var updated_at:String;
    }
}


//  class StravaDataProvider
package core.strava 
{
    import __AS3__.vec.*;
    import utils.*;
    
    public class StravaDataProvider extends Object
    {
        public function StravaDataProvider()
        {
            super();
            return;
        }

        public static function get compareToDataProvider():__AS3__.vec.Vector.<Object>
        {
            if (_compareToDataProvider == null) 
            {
                _compareToDataProvider = new __AS3__.vec.Vector.<Object>();
                _compareToDataProvider.push({"label":utils.LanguageManager.getString("UNIT_STRAVA_COMPARE_TO_KOM"), "compareTo":0});
                _compareToDataProvider.push({"label":utils.LanguageManager.getString("UNIT_STRAVA_COMPARE_TO_PR"), "compareTo":1});
                _compareToDataProvider.push({"label":utils.LanguageManager.getString("UNIT_STRAVA_COMPARE_TO_BESTFOLLOW"), "compareTo":2});
            }
            return _compareToDataProvider;
        }

        public static const COMPARE_CONFIG_CACHE_OBJECT:String="stravaCompareTo";

        public static const COMPARE_DP_COMPARETOFIELD:String="compareTo";

        public static const COMPARE_DP_LABELFIELD:String="label";

        public static const COMPARE_TO_BESTFOLLOW:uint=2;

        public static const COMPARE_TO_GOALTIME:uint=3;

        public static const COMPARE_TO_KOM:uint=0;

        public static const COMPARE_TO_PR:uint=1;

        internal static var _compareToDataProvider:__AS3__.vec.Vector.<Object>;
    }
}


//  class StravaEvent
package core.strava 
{
    import flash.events.*;
    
    public class StravaEvent extends flash.events.Event
    {
        public function StravaEvent(arg1:String, arg2:core.strava.StravaSegment=null, arg3:Object=null)
        {
            extendedData = arg3;
            stravaSegment = arg2;
            super(arg1, bubbles, cancelable);
            return;
        }

        public static const EVENT_LOAD_SEGMENTS_COMPLETE:String="loadSegmentsComplete";

        public static const EVENT_LOAD_SEGMENTS_HEADER_DOWNLOADED:String="loadSegmentsHeaderDownloaded";

        public static const EVENT_LOAD_SEGMENTS_PROGRESS:String="loadSegmentsProgress";

        public static const EVENT_LOAD_SEGMENTS_TIMEOUT:String="loadSegmentsTimeout";

        public static const EVENT_LOAD_SINGLE_SEGMENT_DETAIL_COMPLETE:String="loadSegmentDetailsDownloaded";

        public var extendedData:Object;

        public var stravaSegment:core.strava.StravaSegment;
    }
}


//  class StravaPrAthleteEffort
package core.strava 
{
    public class StravaPrAthleteEffort extends Object
    {
        public function StravaPrAthleteEffort()
        {
            super();
            return;
        }

        public var distance:Number;

        public var elapsed_time:int;

        public var id:uint;

        public var is_kom:Boolean;

        public var start_date:String;

        public var start_date_local:String;
    }
}


//  class StravaSegment
package core.strava 
{
    import __AS3__.vec.*;
    import utils.*;
    
    public class StravaSegment extends core.strava.StravaApiBase
    {
        public function StravaSegment()
        {
            athlete_pr_effort = new core.strava.StravaPrAthleteEffort();
            super();
            return;
        }

        public function set kom(arg1:uint):void
        {
            _kom = arg1;
            kom_initialized = true;
            return;
        }

        public function get points():String
        {
            return _points;
        }

        public function set points(arg1:String):void
        {
            _points = arg1;
            map_initialized = true;
            return;
        }

        public function set qom(arg1:uint):void
        {
            _qom = arg1;
            qom_initialized = true;
            return;
        }

        public function get qom():uint
        {
            return _qom;
        }

        public function get kom():uint
        {
            return _kom;
        }

        public function get rival_time():uint
        {
            return _rival_time;
        }

        public function set rival_time(arg1:uint):void
        {
            _rival_time = arg1;
            rival_initialized = true;
            return;
        }

        public function get starred_date():String
        {
            return _starred_date;
        }

        public function set starred_date(arg1:String):void
        {
            _starred_date = arg1;
            starred_date_object = new Date();
            starred_date_object.setTime(Date.parse(arg1));
            return;
        }

        public function decodeMap():Boolean
        {
            if (_isDecoded) 
            {
                return _isDecoded;
            }
            if (points == "") 
            {
                return false;
            }
            var loc1:*=new utils.PolylineUtil();
            latlng = loc1.decodePoly(points);
            startEntryBearing = loc1.getStartEntryBearing();
            _isDecoded = latlng.length > 0;
            return _isDecoded;
        }

        public function reDecodeMap():Boolean
        {
            _isDecoded = false;
            return decodeMap();
        }

        protected override function setVarFromObject(arg1:Object, arg2:Object, arg3:String):void
        {
            var loc1:*=null;
            if (arg1.hasOwnProperty(arg3) && arg2.hasOwnProperty(arg3)) 
            {
                if (arg3 != "kom") 
                {
                    if (arg3 != "qom") 
                    {
                        if (arg3 != "athlete_segment_stats") 
                        {
                            if (arg1[arg3] is core.strava.StravaPrAthleteEffort) 
                            {
                                var loc3:*=0;
                                var loc2:*=arg2[arg3];
                                for (loc1 in loc2) 
                                {
                                    setVarFromObject(arg1[arg3], arg2[arg3], loc1);
                                }
                            }
                            else 
                            {
                                arg1[arg3] = arg2[arg3];
                            }
                        }
                        else if (arg2[arg3].pr_elapsed_time != null) 
                        {
                            arg1[arg3] = arg2[arg3].pr_elapsed_time;
                        }
                    }
                    else if (arg2[arg3].elapsed_time != null) 
                    {
                        arg1[arg3] = arg2[arg3].elapsed_time;
                    }
                }
                else if (arg2[arg3].elapsed_time != null) 
                {
                    arg1[arg3] = arg2[arg3].elapsed_time;
                }
            }
            return;
        }

        public static const FIELD_TOTAL_ELEVATION_GAIN:String="total_elevation_gain";

        public static const FIELD_ELEVATION_LOW:String="elevation_low";

        public static const ACTIVITY_TYPE_RIDE:String="Ride";

        public static const ACTIVITY_TYPE_RUN:String="Run";

        public static const FIELD_CITY:String="city";

        public static const FIELD_ELEVATION_HIGH:String="elevation_high";

        public static const FIELD_ID:String="id";

        public static const FIELD_KOM_TIME:String="kom";

        public static const FIELD_MAP:String="map";

        public static const FIELD_NAME:String="name";

        public static const FIELD_PR_TIME:String="athlete_segment_stats";

        public static const FIELD_QOM_TIME:String="qom";

        public static const FIELD_RIVAL_TIME:String="rival_time";

        public var latlng:__AS3__.vec.Vector.<core.route.RoutePoint>;

        public var latlngToSend:Array;

        public var latlng_reduced:__AS3__.vec.Vector.<core.route.RoutePoint>;

        public var map_initialized:Boolean=false;

        public var maximum_grade:int;

        public var name:String;

        internal var _points:String="";

        internal var _qom:uint;

        public var country:String;

        public var resource_state:int;

        public var rival_initialized:Boolean=false;

        internal var _rival_time:uint;

        public var activity_type:String;

        public var athlete_pr_effort:core.strava.StravaPrAthleteEffort;

        public var segmentHeader:Array;

        public var star_count:int;

        public var starred:Boolean;

        internal var _starred_date:String;

        public var athlete_segment_stats:uint;

        public var average_grade:Number;

        public var starred_date_object:Date;

        public var startEntryBearing:int;

        public var start_latitude:Number;

        public var start_latlng:Array;

        public var start_longitude:Number;

        public var state:String;

        public var total_elevation_gain:Number;

        public var city:String;

        public var climb_category:int;

        public var compareTo:uint=0;

        public var distance:Number;

        public var elevation_high:Number;

        public var elevation_low:Number;

        public var end_latitude:Number;

        public var end_latlng:Array;

        public var qom_initialized:Boolean=false;

        public var end_longitude:Number;

        public var goal_time:uint;

        public var hasDetails:Boolean=false;

        public var hazardous:Boolean;

        public var id:int;

        internal var _kom:uint;

        public var kom_initialized:Boolean=false;

        internal var _isDecoded:Boolean;
    }
}


