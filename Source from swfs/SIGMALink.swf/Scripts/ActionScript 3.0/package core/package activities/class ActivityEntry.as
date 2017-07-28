//class ActivityEntry
package core.activities 
{
    import flash.errors.*;
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;
    import mx.events.*;
    import utils.*;
    
    public class ActivityEntry extends flash.events.EventDispatcher
    {
        public function ActivityEntry(arg1:Object=null, arg2:flash.events.IEventDispatcher=null)
        {
            altitudeDefined = false;
            cadenceDefined = false;
            heartrateDefined = false;
            inclineDefined = false;
            intensityZoneDefined = false;
            pedalingTimeDefined = false;
            powerDefined = false;
            powerZoneDefined = false;
            riseRateDefined = false;
            speedDefined = false;
            targetZoneDefined = false;
            temperatureDefined = false;
            super(arg2);
            if (!allowActivityEntryCopy && !core.activities.ActivityFactory.isCreatedByFactory(arg1)) 
            {
                throw new flash.errors.IllegalOperationError("Use the factory to instantiate an activity.");
            }
            return;
        }

        public final function set powerPerKG(arg1:Number):void
        {
            _powerPerKG = arg1;
            return;
        }

        public function get activeHour():int
        {
            return _activeHour;
        }

        public function set activeHour(arg1:int):void
        {
            _activeHour = arg1;
            return;
        }

        public function equalsRoutePoint(arg1:core.activities.ActivityEntry):Boolean
        {
            if (arg1 == null) 
            {
                return false;
            }
            return this.latitude == arg1.latitude && this.longitude == arg1.longitude;
        }

        public function get speedDefined():Boolean
        {
            return this.speedDefined;
        }

        public final function get activityEntryId():int
        {
            return _activityEntryId;
        }

        public final function set activityEntryId(arg1:int):void
        {
            _activityEntryId = arg1;
            return;
        }

        public function get powerZone():int
        {
            return _powerZone;
        }

        public final function get activityId():int
        {
            return _activityId;
        }

        public final function set activityId(arg1:int):void
        {
            _activityId = arg1;
            return;
        }

        public function set powerZone(arg1:int):void
        {
            _powerZone = arg1;
            return;
        }

        public final function get altitude():Number
        {
            return _altitude;
        }

        public final function set altitude(arg1:Number):void
        {
            _altitude = arg1;
            return;
        }

        public function get powerZoneDefined():Boolean
        {
            return this.powerZoneDefined;
        }

        public function get altitudeDefined():Boolean
        {
            return this.altitudeDefined;
        }

        public function set altitudeDefined(arg1:Boolean):void
        {
            var loc1:*=this.altitudeDefined;
            if (loc1 !== arg1) 
            {
                this.altitudeDefined = arg1;
                if (this.hasEventListener("propertyChange")) 
                {
                    this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "altitudeDefined", loc1, arg1));
                }
            }
            return;
        }

        public function set powerZoneDefined(arg1:Boolean):void
        {
            var loc1:*=this.powerZoneDefined;
            if (loc1 !== arg1) 
            {
                this.powerZoneDefined = arg1;
                if (this.hasEventListener("propertyChange")) 
                {
                    this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "powerZoneDefined", loc1, arg1));
                }
            }
            return;
        }

        public final function get altitudeDifferencesDownhill():Number
        {
            return _altitudeDifferencesDownhill;
        }

        public final function set altitudeDifferencesDownhill(arg1:Number):void
        {
            _altitudeDifferencesDownhill = arg1;
            return;
        }

        public final function get relativeRotations():int
        {
            return _relativeRotations;
        }

        public final function set relativeRotations(arg1:int):void
        {
            _relativeRotations = arg1;
            return;
        }

        public final function get altitudeDifferencesUphill():Number
        {
            return _altitudeDifferencesUphill;
        }

        public final function set altitudeDifferencesUphill(arg1:Number):void
        {
            _altitudeDifferencesUphill = arg1;
            return;
        }

        public final function get riseRate():Number
        {
            return _riseRate;
        }

        public final function set riseRate(arg1:Number):void
        {
            _riseRate = arg1;
            return;
        }

        public final function get cadence():Number
        {
            return _cadence;
        }

        public final function set cadence(arg1:Number):void
        {
            _cadence = arg1;
            return;
        }

        public function get riseRateDefined():Boolean
        {
            return this.riseRateDefined;
        }

        public function get cadenceDefined():Boolean
        {
            return this.cadenceDefined;
        }

        public function set cadenceDefined(arg1:Boolean):void
        {
            var loc1:*=this.cadenceDefined;
            if (loc1 !== arg1) 
            {
                this.cadenceDefined = arg1;
                if (this.hasEventListener("propertyChange")) 
                {
                    this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "cadenceDefined", loc1, arg1));
                }
            }
            return;
        }

        public function set riseRateDefined(arg1:Boolean):void
        {
            var loc1:*=this.riseRateDefined;
            if (loc1 !== arg1) 
            {
                this.riseRateDefined = arg1;
                if (this.hasEventListener("propertyChange")) 
                {
                    this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "riseRateDefined", loc1, arg1));
                }
            }
            return;
        }

        public final function get calories():Number
        {
            return _calories;
        }

        public final function set calories(arg1:Number):void
        {
            _calories = arg1;
            return;
        }

        public final function get rotations():int
        {
            return _rotations;
        }

        public final function set rotations(arg1:int):void
        {
            _rotations = arg1;
            return;
        }

        public final function get distance():Number
        {
            return _distance;
        }

        public final function set distance(arg1:Number):void
        {
            _distance = arg1;
            return;
        }

        public function get sleepPhase():Number
        {
            return _sleepPhase;
        }

        public final function get distanceAbsolute():Number
        {
            return _distanceAbsolute;
        }

        public final function set distanceAbsolute(arg1:Number):void
        {
            _distanceAbsolute = arg1;
            return;
        }

        public function set sleepPhase(arg1:Number):void
        {
            _sleepPhase = arg1;
            return;
        }

        public final function get speed():Number
        {
            return _speed;
        }

        public final function set speed(arg1:Number):void
        {
            _speed = arg1;
            return;
        }

        public final function get distanceDownhill():Number
        {
            return _distanceDownhill;
        }

        public final function set distanceDownhill(arg1:Number):void
        {
            _distanceDownhill = arg1;
            return;
        }

        public function set speedDefined(arg1:Boolean):void
        {
            var loc1:*=this.speedDefined;
            if (loc1 !== arg1) 
            {
                this.speedDefined = arg1;
                if (this.hasEventListener("propertyChange")) 
                {
                    this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "speedDefined", loc1, arg1));
                }
            }
            return;
        }

        public final function get speedReference():String
        {
            return _speedReference;
        }

        public final function get distanceUphill():Number
        {
            return _distanceUphill;
        }

        public final function set distanceUphill(arg1:Number):void
        {
            _distanceUphill = arg1;
            return;
        }

        public final function set speedReference(arg1:String):void
        {
            _speedReference = arg1;
            return;
        }

        public final function get speedTime():Number
        {
            return _speedTime;
        }

        public final function get heartrate():Number
        {
            return _heartrate;
        }

        public final function set heartrate(arg1:Number):void
        {
            _heartrate = arg1;
            return;
        }

        public final function set speedTime(arg1:Number):void
        {
            _speedTime = arg1;
            return;
        }

        public function get heartrateDefined():Boolean
        {
            return this.heartrateDefined;
        }

        public function set heartrateDefined(arg1:Boolean):void
        {
            var loc1:*=this.heartrateDefined;
            if (loc1 !== arg1) 
            {
                this.heartrateDefined = arg1;
                if (this.hasEventListener("propertyChange")) 
                {
                    this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "heartrateDefined", loc1, arg1));
                }
            }
            return;
        }

        public function get stepType():Number
        {
            return _stepType;
        }

        public final function get incline():Number
        {
            return _incline;
        }

        public final function set incline(arg1:Number):void
        {
            _incline = arg1;
            return;
        }

        public function set stepType(arg1:Number):void
        {
            _stepType = arg1;
            return;
        }

        public function get inclineDefined():Boolean
        {
            return this.inclineDefined;
        }

        public function set inclineDefined(arg1:Boolean):void
        {
            var loc1:*=this.inclineDefined;
            if (loc1 !== arg1) 
            {
                this.inclineDefined = arg1;
                if (this.hasEventListener("propertyChange")) 
                {
                    this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "inclineDefined", loc1, arg1));
                }
            }
            return;
        }

        public function get steps():Number
        {
            return _steps;
        }

        public final function get intensityZone():Number
        {
            return _intensityZone;
        }

        public final function set intensityZone(arg1:Number):void
        {
            _intensityZone = arg1;
            return;
        }

        public function set steps(arg1:Number):void
        {
            _steps = arg1;
            return;
        }

        public function get intensityZoneDefined():Boolean
        {
            return this.intensityZoneDefined;
        }

        public function set intensityZoneDefined(arg1:Boolean):void
        {
            var loc1:*=this.intensityZoneDefined;
            if (loc1 !== arg1) 
            {
                this.intensityZoneDefined = arg1;
                if (this.hasEventListener("propertyChange")) 
                {
                    this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "intensityZoneDefined", loc1, arg1));
                }
            }
            return;
        }

        public final function get targetZone():Number
        {
            return _targetZone;
        }

        public function get isActive():Boolean
        {
            return _isActive;
        }

        public function set isActive(arg1:Boolean):void
        {
            _isActive = arg1;
            return;
        }

        public final function set targetZone(arg1:Number):void
        {
            _targetZone = arg1;
            return;
        }

        public function get targetZoneDefined():Boolean
        {
            return this.targetZoneDefined;
        }

        public function get isPause():Boolean
        {
            return _isPause;
        }

        public function set isPause(arg1:Boolean):void
        {
            _isPause = arg1;
            return;
        }

        public function set targetZoneDefined(arg1:Boolean):void
        {
            var loc1:*=this.targetZoneDefined;
            if (loc1 !== arg1) 
            {
                this.targetZoneDefined = arg1;
                if (this.hasEventListener("propertyChange")) 
                {
                    this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "targetZoneDefined", loc1, arg1));
                }
            }
            return;
        }

        public function get isWaypoint():Boolean
        {
            return _isWaypoint;
        }

        public function set isWaypoint(arg1:Boolean):void
        {
            _isWaypoint = arg1;
            return;
        }

        public final function get temperature():Number
        {
            return _temperature;
        }

        public final function get latitude():Number
        {
            return _latitude;
        }

        public final function set latitude(arg1:Number):void
        {
            _latitude = arg1;
            return;
        }

        public final function set temperature(arg1:Number):void
        {
            _temperature = arg1;
            return;
        }

        public function get temperatureDefined():Boolean
        {
            return this.temperatureDefined;
        }

        public function set temperatureDefined(arg1:Boolean):void
        {
            var loc1:*=this.temperatureDefined;
            if (loc1 !== arg1) 
            {
                this.temperatureDefined = arg1;
                if (this.hasEventListener("propertyChange")) 
                {
                    this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "temperatureDefined", loc1, arg1));
                }
            }
            return;
        }

        public static function copy(arg1:core.activities.ActivityEntry, arg2:core.activities.Activity=null):core.activities.ActivityEntry
        {
            var loc1:*=arg2 ? arg2 : arg1.logReference;
            arg1.logReference = null;
            allowActivityEntryCopy = true;
            var loc3:*=flash.utils.getQualifiedClassName(arg1);
            flash.net.registerClassAlias(loc3, flash.utils.getDefinitionByName(loc3) as Class);
            var loc2:*=utils.BackendUtil.copy(arg1) as ActivityEntry;
            allowActivityEntryCopy = false;
            loc2.activityEntryId = 0;
            loc2.logReference = loc1;
            return loc2;
        }

        public function get timeStart():Date
        {
            return _timeStart;
        }

        public final function get longitude():Number
        {
            return _longitude;
        }

        public final function set longitude(arg1:Number):void
        {
            _longitude = arg1;
            return;
        }

        public function set timeStart(arg1:Date):void
        {
            _timeStart = arg1;
            return;
        }

        public final function get trainingTime():Number
        {
            return _trainingTime;
        }

        public final function set trainingTime(arg1:Number):void
        {
            _trainingTime = arg1;
            return;
        }

        public final function get trainingTimeAbsolute():Number
        {
            return _trainingTimeAbsolute;
        }

        public function get number():int
        {
            return _number;
        }

        public function set number(arg1:int):void
        {
            if (arg1 != _number) 
            {
                _number = arg1;
                dispatchEvent(new flash.events.Event("numberChange"));
            }
            return;
        }

        public final function set trainingTimeAbsolute(arg1:Number):void
        {
            _trainingTimeAbsolute = arg1;
            return;
        }

        public final function get trainingTimeDownhill():Number
        {
            return _trainingTimeDownhill;
        }

        public function get pauseTime():Number
        {
            return _pauseTime;
        }

        public function set pauseTime(arg1:Number):void
        {
            _pauseTime = arg1;
            return;
        }

        public final function set trainingTimeDownhill(arg1:Number):void
        {
            _trainingTimeDownhill = arg1;
            return;
        }

        public function get pedalingTime():Number
        {
            return _pedalingTime;
        }

        public function set pedalingTime(arg1:Number):void
        {
            _pedalingTime = arg1;
            return;
        }

        public final function get trainingTimeUphill():Number
        {
            return _trainingTimeUphill;
        }

        public function get pedalingTimeDefined():Boolean
        {
            return this.pedalingTimeDefined;
        }

        public function set pedalingTimeDefined(arg1:Boolean):void
        {
            var loc1:*=this.pedalingTimeDefined;
            if (loc1 !== arg1) 
            {
                this.pedalingTimeDefined = arg1;
                if (this.hasEventListener("propertyChange")) 
                {
                    this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "pedalingTimeDefined", loc1, arg1));
                }
            }
            return;
        }

        public final function set trainingTimeUphill(arg1:Number):void
        {
            _trainingTimeUphill = arg1;
            return;
        }

        public final function get percentHRMax():Number
        {
            return _percentHRMax;
        }

        public final function set percentHRMax(arg1:Number):void
        {
            _percentHRMax = arg1;
            return;
        }

        public final function get workInKJ():Number
        {
            return _workInKJ;
        }

        public final function set workInKJ(arg1:Number):void
        {
            _workInKJ = arg1;
            return;
        }

        public function get phaseNumber():Number
        {
            return _phaseNumber;
        }

        public function set phaseNumber(arg1:Number):void
        {
            _phaseNumber = arg1;
            return;
        }

        public final function get zone():int
        {
            return _zone;
        }

        public final function set zone(arg1:int):void
        {
            _zone = arg1;
            return;
        }

        public final function get power():Number
        {
            return _power;
        }

        public final function set power(arg1:Number):void
        {
            _power = arg1;
            return;
        }

        public function setPrimaryKey(arg1:int):void
        {
            _activityEntryId = arg1;
            return;
        }

        public function get powerDefined():Boolean
        {
            return this.powerDefined;
        }

        public function set powerDefined(arg1:Boolean):void
        {
            var loc1:*=this.powerDefined;
            if (loc1 !== arg1) 
            {
                this.powerDefined = arg1;
                if (this.hasEventListener("propertyChange")) 
                {
                    this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "powerDefined", loc1, arg1));
                }
            }
            return;
        }

        public override function toString():String
        {
            return flash.utils.getQualifiedClassName(this);
        }

        public final function get powerPerKG():Number
        {
            return _powerPerKG;
        }

        internal var _activeHour:int=0;

        public var activeHourDefined:Boolean=false;

        internal var _activityEntryId:int;

        internal var _activityId:int;

        internal var _altitude:Number=0;

        internal var altitudeDefined:Boolean;

        internal var _altitudeDifferencesDownhill:Number=0;

        public var altitudeDifferencesDownhillDefined:Boolean=false;

        internal var _altitudeDifferencesUphill:Number=0;

        public var altitudeDifferencesUphillDefined:Boolean=false;

        internal var _cadence:Number=0;

        internal var cadenceDefined:Boolean;

        internal var _calories:Number=0;

        public var caloriesDefined:Boolean=false;

        internal var _distance:Number=0;

        internal var _distanceAbsolute:Number=0;

        public var distanceAbsoluteDefined:Boolean=false;

        public var distanceDefined:Boolean=false;

        internal var _distanceDownhill:Number=0;

        public var distanceDownhillDefined:Boolean=false;

        internal var _distanceUphill:Number=0;

        public var distanceUphillDefined:Boolean=false;

        internal var _heartrate:Number=0;

        internal var heartrateDefined:Boolean;

        internal var _incline:Number=0;

        internal var inclineDefined:Boolean;

        internal var _intensityZone:Number=0;

        internal var intensityZoneDefined:Boolean;

        internal var _isActive:Boolean=true;

        public var isActiveDefined:Boolean=false;

        internal var _isPause:Boolean=false;

        internal var _isWaypoint:Boolean=false;

        internal var _latitude:Number=0;

        public var latitudeDefined:Boolean=false;

        public var leftBalance:Number=0;

        public var leftBalanceDefined:Boolean=false;

        public var logReference:core.activities.Activity;

        internal var _longitude:Number=0;

        public var longitudeDefined:Boolean=false;

        public var normalizedPower:Number=0;

        public var normalizedPowerDefined:Boolean=false;

        protected var _number:int=0;

        public var pauseIndex:int;

        internal var _pauseTime:Number=0;

        internal var _pedalingTime:Number=0;

        internal var pedalingTimeDefined:Boolean;

        internal var _percentHRMax:Number=0;

        public var percentHRMaxDefined:Boolean=false;

        internal var _phaseNumber:Number;

        public var phaseNumberDefined:Boolean=false;

        internal var _power:Number=0;

        internal var powerDefined:Boolean;

        internal var _powerPerKG:Number=0;

        public var powerPerKGDefined:Boolean=false;

        public var relativeRotationsDefined:Boolean=false;

        internal var speedDefined:Boolean;

        public var tempUncorrectedDistance:Number=0;

        internal var _temperature:Number=0;

        internal var _powerZone:int=0;

        public var rightBalance:Number=0;

        internal var temperatureDefined:Boolean;

        internal var _speedReference:String="";

        internal var _rotations:int=0;

        public var timeAboveIntensityZones:Number=0;

        public var timeAboveIntensityZonesDefined:Boolean=false;

        public var rightBalanceDefined:Boolean=false;

        public var timeAboveTargetZoneDefined:Boolean=false;

        public var timeBelowIntensityZones:Number=0;

        public var timeBelowIntensityZonesDefined:Boolean=false;

        public var timeBelowTargetZone:Number=0;

        public var timeBelowTargetZoneDefined:Boolean=false;

        public var timeInIntensityZone1:Number=0;

        public var timeInIntensityZone1Defined:Boolean=false;

        public var timeInIntensityZone2:Number=0;

        public var timeInIntensityZone2Defined:Boolean=false;

        public var timeInIntensityZone3:Number=0;

        public var timeInIntensityZone3Defined:Boolean=false;

        public var timeInIntensityZone4:Number=0;

        public var timeInIntensityZone4Defined:Boolean=false;

        public var timeInPowerZone1:Number=0;

        public var timeInPowerZone1Defined:Boolean=false;

        public var timeInPowerZone2:Number=0;

        public var timeInPowerZone2Defined:Boolean=false;

        public var timeInPowerZone3:Number=0;

        public var timeInPowerZone3Defined:Boolean=false;

        public var timeInPowerZone4:Number=0;

        public var timeInPowerZone4Defined:Boolean=false;

        public var timeInPowerZone5:Number=0;

        public var timeInPowerZone5Defined:Boolean=false;

        public var timeInPowerZone6:Number=0;

        public var timeInPowerZone6Defined:Boolean=false;

        public var timeInPowerZone7:Number=0;

        public var timeInPowerZone7Defined:Boolean=false;

        public var timeInTargetZone:Number=0;

        public var timeInTargetZoneDefined:Boolean=false;

        public var timeAboveTargetZone:Number=0;

        public var speedReferenceDefined:Boolean=false;

        internal var _speedTime:Number=0;

        public var timeStartDefined:Boolean=false;

        internal var _trainingTime:Number=0;

        internal var _riseRate:Number=0;

        public var rotationsDefined:Boolean=false;

        internal var _trainingTimeAbsolute:Number=0;

        public var speedTimeDefined:Boolean=false;

        internal var _stepType:Number=0;

        internal var _trainingTimeDownhill:Number=0;

        internal var _sleepPhase:Number=0;

        internal var powerZoneDefined:Boolean;

        public var trainingTimeDownhillDefined:Boolean=false;

        internal var _trainingTimeUphill:Number=0;

        public var stepTypeDefined:Boolean=false;

        internal var _steps:Number=0;

        public var trainingTimeUphillDefined:Boolean=false;

        internal var _workInKJ:Number=0;

        internal var _relativeRotations:int=0;

        public var sleepPhaseDefined:Boolean=false;

        public var workInKJDefined:Boolean=false;

        internal var _zone:int=0;

        public var stepsDefined:Boolean=false;

        internal var _targetZone:Number=0;

        public var zoneDefined:Boolean=false;

        internal var _speed:Number=0;

        internal var riseRateDefined:Boolean;

        internal var targetZoneDefined:Boolean;

        internal static var allowActivityEntryCopy:Boolean=false;

        internal var _timeStart:Date;
    }
}


