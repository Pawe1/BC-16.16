//package sport
//  class Sport
package core.sport 
{
    import configCache.*;
    import flash.events.*;
    import mx.events.*;
    
    public class Sport extends flash.events.EventDispatcher
    {
        public function Sport(arg1:flash.events.IEventDispatcher=null, arg2:uint=0)
        {
            pZoneThresholdInput = 250;
            super(arg1);
            if (arg2 > 0) 
            {
                sportId = arg2;
            }
            return;
        }

        internal function set pZone4Start(arg1:uint):void
        {
            var loc1:*=this.pZone4Start;
            if (loc1 !== arg1) 
            {
                this.pZone4Start = arg1;
                if (this.hasEventListener("propertyChange")) 
                {
                    this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "pZone4Start", loc1, arg1));
                }
            }
            return;
        }

        public function get color():uint
        {
            return _color;
        }

        public function set color(arg1:uint):void
        {
            _color = arg1;
            return;
        }

        internal function get pZone1Start():uint
        {
            return this.pZone1Start;
        }

        internal function set pZone1Start(arg1:uint):void
        {
            var loc1:*=this.pZone1Start;
            if (loc1 !== arg1) 
            {
                this.pZone1Start = arg1;
                if (this.hasEventListener("propertyChange")) 
                {
                    this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "pZone1Start", loc1, arg1));
                }
            }
            return;
        }

        internal function get pZone4Start():uint
        {
            return this.pZone4Start;
        }

        internal function get pZone2Start():uint
        {
            return this.pZone2Start;
        }

        internal function set pZone2Start(arg1:uint):void
        {
            var loc1:*=this.pZone2Start;
            if (loc1 !== arg1) 
            {
                this.pZone2Start = arg1;
                if (this.hasEventListener("propertyChange")) 
                {
                    this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "pZone2Start", loc1, arg1));
                }
            }
            return;
        }

        internal function set pZone3Start(arg1:uint):void
        {
            var loc1:*=this.pZone3Start;
            if (loc1 !== arg1) 
            {
                this.pZone3Start = arg1;
                if (this.hasEventListener("propertyChange")) 
                {
                    this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "pZone3Start", loc1, arg1));
                }
            }
            return;
        }

        public static function get staticEventDispatcher():flash.events.IEventDispatcher
        {
            return Sport._bindingEventDispatcher;
        }

        public static function set ICON_WIDTH(arg1:uint):void
        {
            var loc1:*=Sport.ICON_WIDTH;
            if (loc1 !== arg1) 
            {
                Sport.ICON_WIDTH = arg1;
                if (Sport._bindingEventDispatcher.hasEventListener("propertyChange")) 
                {
                    Sport._bindingEventDispatcher.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(Sport, "ICON_WIDTH", loc1, arg1));
                }
            }
            return;
        }

        public static function get ICON_WIDTH():uint
        {
            return Sport.ICON_WIDTH;
        }

        internal function set pZone7End(arg1:uint):void
        {
            var loc1:*=this.pZone7End;
            if (loc1 !== arg1) 
            {
                this.pZone7End = arg1;
                if (this.hasEventListener("propertyChange")) 
                {
                    this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "pZone7End", loc1, arg1));
                }
            }
            return;
        }

        public static function set ICON_HEIGHT(arg1:uint):void
        {
            var loc1:*=Sport.ICON_HEIGHT;
            if (loc1 !== arg1) 
            {
                Sport.ICON_HEIGHT = arg1;
                if (Sport._bindingEventDispatcher.hasEventListener("propertyChange")) 
                {
                    Sport._bindingEventDispatcher.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(Sport, "ICON_HEIGHT", loc1, arg1));
                }
            }
            return;
        }

        public static function get ICON_HEIGHT():uint
        {
            return Sport.ICON_HEIGHT;
        }

        
        {
            ICON_HEIGHT = 24;
            ICON_WIDTH = 46;
            Sport._bindingEventDispatcher = new flash.events.EventDispatcher();
        }

        public override function toString():String
        {
            return "[Sport extends EventDispatcher implements IDatabase]";
        }

        public function getLoggingInfo():String
        {
            return "\t-sportId " + sportId;
        }

        public function applyDefaultIntensityZoneRanges():Boolean
        {
            var loc1:*=null;
            var loc2:*=configCache.ConfigCache.getInstance().getIntensityZoneValue(this);
            if (loc2) 
            {
                intensityZone1Start = loc2.intensityZone1Start;
                intensityZone2Start = loc2.intensityZone2Start;
                intensityZone3Start = loc2.intensityZone3Start;
                intensityZone4Start = loc2.intensityZone4Start;
                intensityZone4End = loc2.intensityZone4End;
                return false;
            }
            intensityZone1Start = 60;
            intensityZone2Start = 70;
            intensityZone3Start = 80;
            intensityZone4Start = 90;
            intensityZone4End = 100;
            loc1 = {"intensityZone1Start":intensityZone1Start, "intensityZone2Start":intensityZone2Start, "intensityZone3Start":intensityZone3Start, "intensityZone4Start":intensityZone4Start, "intensityZone4End":intensityZone4End};
            configCache.ConfigCache.getInstance().setIntensityZoneValue(this, loc1, false);
            return true;
        }

        public function applyDefaultPowerZoneRanges():Boolean
        {
            var loc1:*=null;
            var loc2:*=configCache.ConfigCache.getInstance().getPowerZoneValue(this);
            if (loc2) 
            {
                pZone1Start = loc2.pZone1Start;
                pZone2Start = loc2.pZone2Start;
                pZone3Start = loc2.pZone3Start;
                pZone4Start = loc2.pZone4Start;
                pZone5Start = loc2.pZone5Start;
                pZone6Start = loc2.pZone6Start;
                pZone7Start = loc2.pZone7Start;
                pZone7End = loc2.pZone7End;
                pZoneThresholdInput = loc2.pZoneThresholdInput;
                return false;
            }
            pZone1Start = 0;
            pZone2Start = pZoneThresholdInput / 100 * 56;
            pZone3Start = pZoneThresholdInput / 100 * 76;
            pZone4Start = pZoneThresholdInput / 100 * 91;
            pZone5Start = pZoneThresholdInput / 100 * 106;
            pZone6Start = pZoneThresholdInput / 100 * 121;
            pZone7Start = pZoneThresholdInput / 100 * 151;
            pZone7End = 2000;
            loc1 = {"pZone1Start":pZone1Start, "pZone2Start":pZone2Start, "pZone3Start":pZone3Start, "pZone4Start":pZone4Start, "pZone5Start":pZone5Start, "pZone6Start":pZone6Start, "pZone7Start":pZone7Start, "pZone7End":pZone7End, "pZoneThresholdInput":250};
            configCache.ConfigCache.getInstance().setPowerZoneValue(this, loc1, false);
            return true;
        }

        public function setPrimaryKey(arg1:uint):void
        {
            if (sportId == 0) 
            {
                sportId = arg1;
            }
            return;
        }

        internal function set pZoneThresholdInput(arg1:uint):void
        {
            var loc1:*=this.pZoneThresholdInput;
            if (loc1 !== arg1) 
            {
                this.pZoneThresholdInput = arg1;
                if (this.hasEventListener("propertyChange")) 
                {
                    this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "pZoneThresholdInput", loc1, arg1));
                }
            }
            return;
        }

        public function get name():String
        {
            return _name;
        }

        public function set name(arg1:String):void
        {
            if (_name == arg1) 
            {
                return;
            }
            _name = arg1;
            return;
        }

        internal function get pZoneThresholdInput():uint
        {
            return this.pZoneThresholdInput;
        }

        internal function set pZone7Start(arg1:uint):void
        {
            var loc1:*=this.pZone7Start;
            if (loc1 !== arg1) 
            {
                this.pZone7Start = arg1;
                if (this.hasEventListener("propertyChange")) 
                {
                    this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "pZone7Start", loc1, arg1));
                }
            }
            return;
        }

        internal function get pZone7Start():uint
        {
            return this.pZone7Start;
        }

        public function get shortName():String
        {
            return _shortName;
        }

        public function set shortName(arg1:String):void
        {
            _shortName = arg1;
            return;
        }

        internal function get pZone7End():uint
        {
            return this.pZone7End;
        }

        public function get sportId():uint
        {
            return _sportId;
        }

        public function set sportId(arg1:uint):void
        {
            _sportId = arg1;
            return;
        }

        internal function set pZone6Start(arg1:uint):void
        {
            var loc1:*=this.pZone6Start;
            if (loc1 !== arg1) 
            {
                this.pZone6Start = arg1;
                if (this.hasEventListener("propertyChange")) 
                {
                    this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "pZone6Start", loc1, arg1));
                }
            }
            return;
        }

        internal function get intensityZone1Start():uint
        {
            return this.intensityZone1Start;
        }

        internal function set intensityZone1Start(arg1:uint):void
        {
            var loc1:*=this.intensityZone1Start;
            if (loc1 !== arg1) 
            {
                this.intensityZone1Start = arg1;
                if (this.hasEventListener("propertyChange")) 
                {
                    this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "intensityZone1Start", loc1, arg1));
                }
            }
            return;
        }

        internal function get pZone6Start():uint
        {
            return this.pZone6Start;
        }

        internal function get intensityZone2Start():uint
        {
            return this.intensityZone2Start;
        }

        internal function set intensityZone2Start(arg1:uint):void
        {
            var loc1:*=this.intensityZone2Start;
            if (loc1 !== arg1) 
            {
                this.intensityZone2Start = arg1;
                if (this.hasEventListener("propertyChange")) 
                {
                    this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "intensityZone2Start", loc1, arg1));
                }
            }
            return;
        }

        internal function set pZone5Start(arg1:uint):void
        {
            var loc1:*=this.pZone5Start;
            if (loc1 !== arg1) 
            {
                this.pZone5Start = arg1;
                if (this.hasEventListener("propertyChange")) 
                {
                    this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "pZone5Start", loc1, arg1));
                }
            }
            return;
        }

        internal function get intensityZone3Start():uint
        {
            return this.intensityZone3Start;
        }

        internal function set intensityZone3Start(arg1:uint):void
        {
            var loc1:*=this.intensityZone3Start;
            if (loc1 !== arg1) 
            {
                this.intensityZone3Start = arg1;
                if (this.hasEventListener("propertyChange")) 
                {
                    this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "intensityZone3Start", loc1, arg1));
                }
            }
            return;
        }

        internal function get pZone3Start():uint
        {
            return this.pZone3Start;
        }

        internal function get intensityZone4End():uint
        {
            return this.intensityZone4End;
        }

        internal function set intensityZone4End(arg1:uint):void
        {
            var loc1:*=this.intensityZone4End;
            if (loc1 !== arg1) 
            {
                this.intensityZone4End = arg1;
                if (this.hasEventListener("propertyChange")) 
                {
                    this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "intensityZone4End", loc1, arg1));
                }
            }
            return;
        }

        internal function get pZone5Start():uint
        {
            return this.pZone5Start;
        }

        internal function get intensityZone4Start():uint
        {
            return this.intensityZone4Start;
        }

        internal function set intensityZone4Start(arg1:uint):void
        {
            var loc1:*=this.intensityZone4Start;
            if (loc1 !== arg1) 
            {
                this.intensityZone4Start = arg1;
                if (this.hasEventListener("propertyChange")) 
                {
                    this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "intensityZone4Start", loc1, arg1));
                }
            }
            return;
        }

        public static const SKI:String="ski";

        public static const SNOWBOARDING:String="snowboarding";

        public static const SWIMMING:String="swimming";

        public static const TREADMILL:String="treadmill";

        public static const TRIATHLON:String="triathlon";

        public static const WALKING:String="walking";

        public static const INLINE_SKATES:String="inline_skates";

        public static const CYCLING:String="cycling";

        public static const ACTIVITY_TRACKER:String="activityTracker";

        public static const BMX:String="bmx";

        public static const CYCLECROSS:String="cyclecross";

        public static const EBIKE:String="ebike";

        public static const ENDURO:String="enduro";

        public static const FITNESS:String="fitness";

        public static const GOLF:String="golf";

        public static const HIKING:String="hiking";

        public static const INDOOR_CYCLING:String="indoor_cycling";

        public static const MOUNTAINBIKE:String="mountainbike";

        public static const OTHER:String="other";

        public static const RACING_BYCICLE:String="racing_bycicle";

        public static const RUNNING:String="running";

        protected var _color:uint=13046322;

        public var defaultSpeedFormat:String="distance/time";

        public var defaultXAxisUnit:String="distanceAbsolute";

        public var editable:Boolean=true;

        public var iconLeft:int=0;

        public var iconName:String="";

        public var keyName:String;

        public var logTrackBest20MinPower:Boolean=false;

        public var logMapHighlight:String="none";

        public var logHeartrateZonesDiagramStyleDefault:String="";

        public var logChartSpeed:Boolean=true;

        internal var pZone3Start:uint;

        internal var pZone4Start:uint;

        internal var pZone2Start:uint;

        public var logChartHeartrate:Boolean=true;

        internal var pZone1Start:uint;

        internal var pZone5Start:uint;

        internal var intensityZone4Start:uint;

        internal var intensityZone3Start:uint;

        internal var pZone6Start:uint;

        internal static var ICON_HEIGHT:uint;

        public var logChartCompareSliderDefault:Number=0.2;

        public var logChartBest5KTime:Boolean=true;

        internal static var ICON_WIDTH:uint;

        public var logChartAltitude:Boolean=true;

        public var leftAxisRenderer:String="renderer_speed";

        internal var intensityZone2Start:uint;

        public var logChartBest20MinPower:Boolean=true;

        internal var intensityZone1Start:uint;

        internal var pZone7End:uint;

        protected var _sportId:uint;

        internal var intensityZone4End:uint;

        internal var pZone7Start:uint;

        protected var _shortName:String="--";

        public var rightAxisRenderer:String="renderer_heartrate_right";

        internal var pZoneThresholdInput:uint;

        public var noun:String="";

        protected var _name:String="";

        internal static var _bindingEventDispatcher:flash.events.EventDispatcher;

        public var labelColor:uint=16777215;

        public var logTrackBest5KTime:Boolean=true;
    }
}


//  class SportLoader
package core.sport 
{
    import __AS3__.vec.*;
    import flash.utils.*;
    import utils.*;
    
    public class SportLoader extends Object
    {
        public function SportLoader()
        {
            sportsIdDic = new flash.utils.Dictionary(true);
            super();
            return;
        }

        public function getSportById(arg1:uint=0):core.sport.Sport
        {
            if (arg1 == 0) 
            {
                return sports[0] as core.sport.Sport;
            }
            return sportsIdDic[arg1] as core.sport.Sport;
        }

        public static function getInstance():core.sport.SportLoader
        {
            if (_instance == null) 
            {
                _instance = new SportLoader();
            }
            return _instance;
        }

        public static function initSports():Boolean
        {
            var loc18:*;
            (loc18 = getInstance()).sports = new __AS3__.vec.Vector.<core.sport.Sport>();
            var loc3:*=false;
            var loc20:*;
            (loc20 = new core.sport.Sport()).sportId = 1;
            loc20.color = 6007551;
            loc20.labelColor = 16777215;
            loc20.iconName = "RCB";
            loc20.name = utils.LanguageManager.getString("SPORT_RACINGBICYCLE");
            loc20.shortName = utils.LanguageManager.getString("SPORT_RACINGBICYCLE_SHORT");
            loc20.noun = utils.LanguageManager.getString("SPORT_RIDE");
            loc20.keyName = "racing_bycicle";
            loc20.defaultXAxisUnit = "distanceAbsolute";
            loc20.defaultSpeedFormat = "distance/time";
            loc20.leftAxisRenderer = "renderer_speed";
            loc20.rightAxisRenderer = "renderer_heartrate_right";
            loc3 = loc20.applyDefaultPowerZoneRanges() || loc3;
            loc3 = loc20.applyDefaultIntensityZoneRanges() || loc3;
            loc18.sportsIdDic[loc20.sportId] = loc20;
            var loc21:*;
            (loc21 = new core.sport.Sport()).sportId = 2;
            loc21.color = 16764928;
            loc21.labelColor = 0;
            loc21.iconName = "MTB";
            loc21.name = utils.LanguageManager.getString("SPORT_MOUNTAINBIKE");
            loc21.shortName = utils.LanguageManager.getString("SPORT_MOUNTAINBIKE_SHORT");
            loc21.noun = utils.LanguageManager.getString("SPORT_RIDE");
            loc21.keyName = "mountainbike";
            loc21.defaultXAxisUnit = "distanceAbsolute";
            loc21.defaultSpeedFormat = "distance/time";
            loc21.leftAxisRenderer = "renderer_speed";
            loc21.rightAxisRenderer = "renderer_heartrate_right";
            loc3 = loc21.applyDefaultPowerZoneRanges() || loc3;
            loc3 = loc21.applyDefaultIntensityZoneRanges() || loc3;
            loc18.sportsIdDic[loc21.sportId] = loc21;
            var loc7:*;
            (loc7 = new core.sport.Sport()).sportId = 3;
            loc7.color = 41728;
            loc7.labelColor = 16777215;
            loc7.iconName = "CYC";
            loc7.name = utils.LanguageManager.getString("SPORT_CYCLING");
            loc7.shortName = utils.LanguageManager.getString("SPORT_CYCLING_SHORT");
            loc7.noun = utils.LanguageManager.getString("SPORT_RIDE");
            loc7.keyName = "cycling";
            loc7.defaultXAxisUnit = "distanceAbsolute";
            loc7.defaultSpeedFormat = "distance/time";
            loc7.leftAxisRenderer = "renderer_speed";
            loc7.rightAxisRenderer = "renderer_heartrate_right";
            loc3 = loc7.applyDefaultPowerZoneRanges() || loc3;
            loc3 = loc7.applyDefaultIntensityZoneRanges() || loc3;
            loc18.sportsIdDic[loc7.sportId] = loc7;
            var loc11:*;
            (loc11 = new core.sport.Sport()).sportId = 4;
            loc11.color = 8179216;
            loc11.labelColor = 16777215;
            loc11.iconName = "RUN";
            loc11.iconLeft = 2;
            loc11.name = utils.LanguageManager.getString("SPORT_RUNNING");
            loc11.shortName = utils.LanguageManager.getString("SPORT_RUNNING_SHORT");
            loc11.noun = utils.LanguageManager.getString("SPORT_RUN");
            loc11.keyName = "running";
            loc11.defaultXAxisUnit = "trainingTimeAbsolute";
            loc11.defaultSpeedFormat = "time/distance";
            loc11.leftAxisRenderer = "renderer_heartrate";
            loc11.rightAxisRenderer = "renderer_heartrate_right";
            loc3 = loc11.applyDefaultPowerZoneRanges() || loc3;
            loc3 = loc11.applyDefaultIntensityZoneRanges() || loc3;
            loc18.sportsIdDic[loc11.sportId] = loc11;
            var loc16:*;
            (loc16 = new core.sport.Sport()).sportId = 5;
            loc16.color = 16744448;
            loc16.labelColor = 16777215;
            loc16.iconName = "WLK";
            loc16.iconLeft = 3;
            loc16.name = utils.LanguageManager.getString("SPORT_WALKING");
            loc16.shortName = utils.LanguageManager.getString("SPORT_WALKING_SHORT");
            loc16.noun = utils.LanguageManager.getString("SPORT_WALK");
            loc16.keyName = "walking";
            loc16.defaultXAxisUnit = "trainingTimeAbsolute";
            loc16.defaultSpeedFormat = "time/distance";
            loc16.leftAxisRenderer = "renderer_heartrate";
            loc16.rightAxisRenderer = "renderer_heartrate_right";
            loc3 = loc16.applyDefaultPowerZoneRanges() || loc3;
            loc3 = loc16.applyDefaultIntensityZoneRanges() || loc3;
            loc18.sportsIdDic[loc16.sportId] = loc16;
            var loc6:*;
            (loc6 = new core.sport.Sport()).sportId = 6;
            loc6.color = 8007893;
            loc6.labelColor = 16777215;
            loc6.iconName = "HIK";
            loc6.iconLeft = 4;
            loc6.name = utils.LanguageManager.getString("SPORT_HIKING");
            loc6.shortName = utils.LanguageManager.getString("SPORT_HIKING_SHORT");
            loc6.noun = utils.LanguageManager.getString("SPORT_WALK");
            loc6.keyName = "hiking";
            loc6.defaultXAxisUnit = "trainingTimeAbsolute";
            loc6.defaultSpeedFormat = "time/distance";
            loc6.leftAxisRenderer = "renderer_heartrate";
            loc6.rightAxisRenderer = "renderer_heartrate_right";
            loc3 = loc6.applyDefaultPowerZoneRanges() || loc3;
            loc3 = loc6.applyDefaultIntensityZoneRanges() || loc3;
            loc18.sportsIdDic[loc6.sportId] = loc6;
            var loc22:*;
            (loc22 = new core.sport.Sport()).sportId = 7;
            loc22.color = 43678;
            loc22.labelColor = 16777215;
            loc22.iconName = "TRM";
            loc22.name = utils.LanguageManager.getString("SPORT_TREADMILL");
            loc22.shortName = utils.LanguageManager.getString("SPORT_TREADMILL_SHORT");
            loc22.noun = utils.LanguageManager.getString("SPORT_RIDE");
            loc22.keyName = "treadmill";
            loc22.defaultXAxisUnit = "trainingTimeAbsolute";
            loc22.defaultSpeedFormat = "distance/time";
            loc22.leftAxisRenderer = "renderer_heartrate";
            loc22.rightAxisRenderer = "renderer_heartrate_right";
            loc3 = loc22.applyDefaultPowerZoneRanges() || loc3;
            loc3 = loc22.applyDefaultIntensityZoneRanges() || loc3;
            loc18.sportsIdDic[loc22.sportId] = loc22;
            var loc17:*;
            (loc17 = new core.sport.Sport()).sportId = 8;
            loc17.color = 10387573;
            loc17.labelColor = 16777215;
            loc17.iconName = "FIT";
            loc17.iconLeft = 4;
            loc17.name = utils.LanguageManager.getString("SPORT_FITNESS");
            loc17.shortName = utils.LanguageManager.getString("SPORT_FITNESS_SHORT");
            loc17.noun = utils.LanguageManager.getString("SPORT_GENERAL");
            loc17.keyName = "fitness";
            loc17.defaultXAxisUnit = "trainingTimeAbsolute";
            loc17.defaultSpeedFormat = "distance/time";
            loc17.leftAxisRenderer = "renderer_heartrate";
            loc17.rightAxisRenderer = "renderer_heartrate_right";
            loc3 = loc17.applyDefaultPowerZoneRanges() || loc3;
            loc3 = loc17.applyDefaultIntensityZoneRanges() || loc3;
            loc18.sportsIdDic[loc17.sportId] = loc17;
            var loc13:*;
            (loc13 = new core.sport.Sport()).sportId = 9;
            loc13.color = 2999259;
            loc13.labelColor = 16777215;
            loc13.iconName = "SWM";
            loc13.iconLeft = 1;
            loc13.name = utils.LanguageManager.getString("SPORT_SWIMMING");
            loc13.shortName = utils.LanguageManager.getString("SPORT_SWIMMING_SHORT");
            loc13.noun = utils.LanguageManager.getString("SPORT_GENERAL");
            loc13.keyName = "swimming";
            loc13.defaultXAxisUnit = "trainingTimeAbsolute";
            loc13.defaultSpeedFormat = "distance/time";
            loc13.leftAxisRenderer = "renderer_heartrate";
            loc13.rightAxisRenderer = "renderer_heartrate_right";
            loc3 = loc13.applyDefaultPowerZoneRanges() || loc3;
            loc3 = loc13.applyDefaultIntensityZoneRanges() || loc3;
            loc18.sportsIdDic[loc13.sportId] = loc13;
            var loc5:*;
            (loc5 = new core.sport.Sport()).sportId = 10;
            loc5.color = 8364210;
            loc5.labelColor = 16777215;
            loc5.iconName = "ICY";
            loc5.iconLeft = 2;
            loc5.name = utils.LanguageManager.getString("SPORT_INDOOR_CYCLING");
            loc5.shortName = utils.LanguageManager.getString("SPORT_INDOOR_CYCLING_SHORT");
            loc5.noun = utils.LanguageManager.getString("SPORT_RIDE");
            loc5.keyName = "indoor_cycling";
            loc5.defaultXAxisUnit = "distanceAbsolute";
            loc5.defaultSpeedFormat = "distance/time";
            loc5.leftAxisRenderer = "renderer_speed";
            loc5.rightAxisRenderer = "renderer_heartrate_right";
            loc3 = loc5.applyDefaultPowerZoneRanges() || loc3;
            loc3 = loc5.applyDefaultIntensityZoneRanges() || loc3;
            loc18.sportsIdDic[loc5.sportId] = loc5;
            var loc15:*;
            (loc15 = new core.sport.Sport()).sportId = 11;
            loc15.color = 14081352;
            loc15.labelColor = 0;
            loc15.iconName = "GLF";
            loc15.iconLeft = 4;
            loc15.name = utils.LanguageManager.getString("SPORT_GOLF");
            loc15.shortName = utils.LanguageManager.getString("SPORT_GOLF_SHORT");
            loc15.noun = utils.LanguageManager.getString("SPORT_GENERAL");
            loc15.keyName = "golf";
            loc15.defaultXAxisUnit = "trainingTimeAbsolute";
            loc15.defaultSpeedFormat = "distance/time";
            loc15.leftAxisRenderer = "renderer_heartrate";
            loc15.rightAxisRenderer = "renderer_heartrate_right";
            loc3 = loc15.applyDefaultPowerZoneRanges() || loc3;
            loc3 = loc15.applyDefaultIntensityZoneRanges() || loc3;
            loc18.sportsIdDic[loc15.sportId] = loc15;
            var loc8:*;
            (loc8 = new core.sport.Sport()).sportId = 12;
            loc8.color = 16415762;
            loc8.labelColor = 0;
            loc8.iconName = "ILS";
            loc8.iconLeft = 1;
            loc8.name = utils.LanguageManager.getString("SPORT_INLINE_SKATES");
            loc8.shortName = utils.LanguageManager.getString("SPORT_INLINE_SKATES_SHORT");
            loc8.noun = utils.LanguageManager.getString("SPORT_GENERAL");
            loc8.keyName = "inline_skates";
            loc8.defaultXAxisUnit = "trainingTimeAbsolute";
            loc8.defaultSpeedFormat = "distance/time";
            loc8.leftAxisRenderer = "renderer_heartrate";
            loc8.rightAxisRenderer = "renderer_heartrate_right";
            loc3 = loc8.applyDefaultPowerZoneRanges() || loc3;
            loc3 = loc8.applyDefaultIntensityZoneRanges() || loc3;
            loc18.sportsIdDic[loc8.sportId] = loc8;
            var loc12:*;
            (loc12 = new core.sport.Sport()).sportId = 13;
            loc12.color = 210943;
            loc12.labelColor = 16777215;
            loc12.iconName = "SKI";
            loc12.name = utils.LanguageManager.getString("SPORT_SKI");
            loc12.shortName = utils.LanguageManager.getString("SPORT_SKI_SHORT");
            loc12.noun = utils.LanguageManager.getString("SPORT_GENERAL");
            loc12.keyName = "ski";
            loc12.defaultXAxisUnit = "trainingTimeAbsolute";
            loc12.defaultSpeedFormat = "distance/time";
            loc12.leftAxisRenderer = "renderer_heartrate";
            loc12.rightAxisRenderer = "renderer_heartrate_right";
            loc3 = loc12.applyDefaultPowerZoneRanges() || loc3;
            loc3 = loc12.applyDefaultIntensityZoneRanges() || loc3;
            loc18.sportsIdDic[loc12.sportId] = loc12;
            var loc4:*;
            (loc4 = new core.sport.Sport()).sportId = 14;
            loc4.color = 15125009;
            loc4.labelColor = 0;
            loc4.iconName = "SNB";
            loc4.name = utils.LanguageManager.getString("SPORT_SNOWBOARDING");
            loc4.shortName = utils.LanguageManager.getString("SPORT_SNOWBOARDING_SHORT");
            loc4.noun = utils.LanguageManager.getString("SPORT_GENERAL");
            loc4.keyName = "snowboarding";
            loc4.defaultXAxisUnit = "trainingTimeAbsolute";
            loc4.defaultSpeedFormat = "distance/time";
            loc4.leftAxisRenderer = "renderer_heartrate";
            loc4.rightAxisRenderer = "renderer_heartrate_right";
            loc3 = loc4.applyDefaultPowerZoneRanges() || loc3;
            loc3 = loc4.applyDefaultIntensityZoneRanges() || loc3;
            loc18.sportsIdDic[loc4.sportId] = loc4;
            var loc2:*=new core.sport.Sport();
            loc2.sportId = 15;
            loc2.color = 0;
            loc2.labelColor = 16777215;
            loc2.iconName = "OTH";
            loc2.iconLeft = 3;
            loc2.name = utils.LanguageManager.getString("SPORT_OTHER");
            loc2.shortName = utils.LanguageManager.getString("SPORT_OTHER_SHORT");
            loc2.noun = utils.LanguageManager.getString("SPORT_GENERAL");
            loc2.keyName = "other";
            loc2.defaultXAxisUnit = "trainingTimeAbsolute";
            loc2.defaultSpeedFormat = "distance/time";
            loc2.leftAxisRenderer = "renderer_heartrate";
            loc2.rightAxisRenderer = "renderer_heartrate_right";
            loc3 = loc2.applyDefaultPowerZoneRanges() || loc3;
            loc3 = loc2.applyDefaultIntensityZoneRanges() || loc3;
            loc18.sportsIdDic[loc2.sportId] = loc2;
            var loc23:*;
            (loc23 = new core.sport.Sport()).editable = false;
            loc23.sportId = 16;
            loc23.color = 10027008;
            loc23.labelColor = 16777215;
            loc23.iconName = "ACT";
            loc23.iconLeft = 2;
            loc23.name = utils.LanguageManager.getString("SPORT_ACTIVITY_TRACKER");
            loc23.shortName = utils.LanguageManager.getString("SPORT_ACTIVITY_TRACKER_SHORT");
            loc23.noun = utils.LanguageManager.getString("SPORT_GENERAL");
            loc23.keyName = "activityTracker";
            loc23.defaultXAxisUnit = "trainingTimeAbsolute";
            loc23.defaultSpeedFormat = "distance/time";
            loc23.leftAxisRenderer = "renderer_heartrate";
            loc23.rightAxisRenderer = "renderer_heartrate_right";
            loc3 = loc23.applyDefaultPowerZoneRanges() || loc3;
            loc3 = loc23.applyDefaultIntensityZoneRanges() || loc3;
            loc18.sportsIdDic[loc23.sportId] = loc23;
            var loc14:*;
            (loc14 = new core.sport.Sport()).sportId = 17;
            loc14.color = 13647104;
            loc14.labelColor = 16777215;
            loc14.iconName = "TRI";
            loc14.name = utils.LanguageManager.getString("SPORT_TRIATHLON");
            loc14.shortName = utils.LanguageManager.getString("SPORT_TRIATHLON_SHORT");
            loc14.noun = utils.LanguageManager.getString("SPORT_GENERAL");
            loc14.keyName = "triathlon";
            loc14.defaultXAxisUnit = "trainingTimeAbsolute";
            loc14.defaultSpeedFormat = "distance/time";
            loc14.leftAxisRenderer = "renderer_heartrate";
            loc14.rightAxisRenderer = "renderer_heartrate_right";
            loc3 = loc14.applyDefaultPowerZoneRanges() || loc3;
            loc3 = loc14.applyDefaultIntensityZoneRanges() || loc3;
            loc18.sportsIdDic[loc14.sportId] = loc14;
            var loc19:*;
            (loc19 = new core.sport.Sport()).sportId = 18;
            loc19.color = 10827627;
            loc19.labelColor = 16777215;
            loc19.iconName = "EBI";
            loc19.name = utils.LanguageManager.getString("SPORT_EBIKE");
            loc19.shortName = utils.LanguageManager.getString("SPORT_EBIKE_SHORT");
            loc19.noun = utils.LanguageManager.getString("SPORT_GENERAL");
            loc19.keyName = "ebike";
            loc19.defaultXAxisUnit = "trainingTimeAbsolute";
            loc19.defaultSpeedFormat = "distance/time";
            loc19.leftAxisRenderer = "renderer_heartrate";
            loc19.rightAxisRenderer = "renderer_heartrate_right";
            loc3 = loc19.applyDefaultPowerZoneRanges() || loc3;
            loc3 = loc19.applyDefaultIntensityZoneRanges() || loc3;
            loc18.sportsIdDic[loc19.sportId] = loc19;
            var loc9:*;
            (loc9 = new core.sport.Sport()).sportId = 19;
            loc9.color = 4877965;
            loc9.labelColor = 16777215;
            loc9.iconName = "BMX";
            loc9.iconLeft = 2;
            loc9.name = utils.LanguageManager.getString("SPORT_BMX");
            loc9.shortName = utils.LanguageManager.getString("SPORT_BMX_SHORT");
            loc9.noun = utils.LanguageManager.getString("SPORT_GENERAL");
            loc9.keyName = "bmx";
            loc9.defaultXAxisUnit = "trainingTimeAbsolute";
            loc9.defaultSpeedFormat = "distance/time";
            loc9.leftAxisRenderer = "renderer_heartrate";
            loc9.rightAxisRenderer = "renderer_heartrate_right";
            loc3 = loc9.applyDefaultPowerZoneRanges() || loc3;
            loc3 = loc9.applyDefaultIntensityZoneRanges() || loc3;
            loc18.sportsIdDic[loc9.sportId] = loc9;
            var loc10:*;
            (loc10 = new core.sport.Sport()).sportId = 20;
            loc10.color = 11255677;
            loc10.labelColor = 16777215;
            loc10.iconName = "CYX";
            loc10.name = utils.LanguageManager.getString("SPORT_CYCLECROSS");
            loc10.shortName = utils.LanguageManager.getString("SPORT_CYCLECROSS_SHORT");
            loc10.noun = utils.LanguageManager.getString("SPORT_GENERAL");
            loc10.keyName = "cyclecross";
            loc10.defaultXAxisUnit = "trainingTimeAbsolute";
            loc10.defaultSpeedFormat = "distance/time";
            loc10.leftAxisRenderer = "renderer_heartrate";
            loc10.rightAxisRenderer = "renderer_heartrate_right";
            loc3 = loc10.applyDefaultPowerZoneRanges() || loc3;
            loc3 = loc10.applyDefaultIntensityZoneRanges() || loc3;
            loc18.sportsIdDic[loc10.sportId] = loc10;
            var loc1:*=new core.sport.Sport();
            loc1.sportId = 21;
            loc1.color = 8207616;
            loc1.labelColor = 16777215;
            loc1.iconName = "EDO";
            loc1.name = utils.LanguageManager.getString("SPORT_ENDURO");
            loc1.shortName = utils.LanguageManager.getString("SPORT_ENDURO_SHORT");
            loc1.noun = utils.LanguageManager.getString("SPORT_GENERAL");
            loc1.keyName = "enduro";
            loc1.defaultXAxisUnit = "trainingTimeAbsolute";
            loc1.defaultSpeedFormat = "distance/time";
            loc1.leftAxisRenderer = "renderer_heartrate";
            loc1.rightAxisRenderer = "renderer_heartrate_right";
            loc3 = loc1.applyDefaultPowerZoneRanges() || loc3;
            loc3 = loc1.applyDefaultIntensityZoneRanges() || loc3;
            loc18.sportsIdDic[loc1.sportId] = loc1;
            loc18.sports.push(loc20);
            loc18.sports.push(loc21);
            loc18.sports.push(loc7);
            loc18.sports.push(loc11);
            loc18.sports.push(loc14);
            loc18.sports.push(loc19);
            loc18.sports.push(loc16);
            loc18.sports.push(loc6);
            loc18.sports.push(loc22);
            loc18.sports.push(loc17);
            loc18.sports.push(loc13);
            loc18.sports.push(loc5);
            loc18.sports.push(loc9);
            loc18.sports.push(loc10);
            loc18.sports.push(loc1);
            loc18.sports.push(loc15);
            loc18.sports.push(loc8);
            loc18.sports.push(loc12);
            loc18.sports.push(loc4);
            loc18.sports.push(loc2);
            loc18.sports.push(loc23);
            return loc3;
        }

        public static function getSports():__AS3__.vec.Vector.<core.sport.Sport>
        {
            return getInstance().sports;
        }

        public static function getSportsIdDic():flash.utils.Dictionary
        {
            return getInstance().sportsIdDic;
        }

        internal var sports:__AS3__.vec.Vector.<core.sport.Sport>;

        internal var sportsIdDic:flash.utils.Dictionary;

        internal static var _instance:core.sport.SportLoader;
    }
}


