//class Sport
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


