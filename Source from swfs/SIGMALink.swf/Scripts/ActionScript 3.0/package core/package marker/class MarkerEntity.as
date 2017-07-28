//class MarkerEntity
package core.marker 
{
    import core.*;
    import core.training.type.*;
    import flash.events.*;
    import flash.globalization.*;
    import flash.system.*;
    import init.*;
    import utils.*;
    import utils.converter.*;
    import utils.interfaces.*;
    
    public class MarkerEntity extends flash.events.EventDispatcher
    {
        public function MarkerEntity(arg1:flash.events.IEventDispatcher=null)
        {
            _plannedAutoChange = core.training.type.PhaseChangeMode.AUTOMATIC;
            _plannedLoadRecovery = core.training.type.PhaseLoadRecovery.LOAD;
            _plannedPhaseControl = core.training.type.PhaseControl.TIME;
            _plannedRecoveryPhaseControl = core.training.type.PhaseControl.TIME;
            super(arg1);
            if (initFormatter && flash.system.Worker.current.isPrimordial) 
            {
                timeFormatter = init.BackendInitializer.getInstance().createTimeFormatter();
                timeFormatter.inputType = "hundredthsSecond";
                timeFormatter.formatString = "H:MM:SS.t";
                paceFormatter = init.BackendInitializer.getInstance().createTimeFormatter();
                paceFormatter.inputType = "seconds";
                paceFormatter.formatString = "MM:SS";
                altitudeConverter = new utils.converter.AltitudeConverter("millimeter", core.MeasurementConfig.altitudeFormat);
                altitudeFormatter = init.BackendInitializer.getInstance().createAltitudeFormatter();
                caloriesFormatter = init.BackendInitializer.getInstance().createCaloriesFormatter();
                dateFormatter = init.BackendInitializer.getInstance().createDateTimeFormatter();
                dateFormatter.dateStyle = "short";
                dateFormatter.timeStyle = "none";
                dateFormatter.setStyle("locale", core.MeasurementConfig.dateFormat != "eu" ? "en_US" : "de_DE");
                distanceConverter = new utils.converter.DistanceConverter("meter", core.MeasurementConfig.distanceFormat);
                distanceFormatter = init.BackendInitializer.getInstance().createDistanceFormatter();
                distanceFormatter.formatString = core.MeasurementConfig.distanceFormat != "kilometer" ? "K.MM" : "K,MM";
                heartrateFormatter = init.BackendInitializer.getInstance().createHeartrateFormatter();
                powerFormatter = init.BackendInitializer.getInstance().createPowerFormatter();
                speedConverter = new utils.converter.SpeedConverter("ms", core.MeasurementConfig.speedFormat);
                speedFormatter = init.BackendInitializer.getInstance().createSpeedFormatter();
                speedFormatter.formatString = distanceFormatter.formatString;
                cadenceFormatter = init.BackendInitializer.getInstance().createCadenceFormatter();
                inclineFormatter = init.BackendInitializer.getInstance().createInclineFormatter();
                initFormatter = false;
            }
            return;
        }

        public final function set latitude(arg1:Number):void
        {
            _latitude = arg1;
            return;
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

        public final function get calories():Number
        {
            return _calories;
        }

        public final function get altitudeDownhill():int
        {
            return _altitudeDownhill;
        }

        public final function set altitudeDownhill(arg1:int):void
        {
            _altitudeDownhill = arg1;
            if (altitudeFormatter) 
            {
                altitudeDownhillOutputString = altitudeFormatter.format(altitudeConverter.convert(arg1));
            }
            return;
        }

        public final function set calories(arg1:Number):void
        {
            _calories = arg1;
            if (caloriesFormatter) 
            {
                caloriesOutputString = caloriesFormatter.format(arg1);
            }
            return;
        }

        public final function set maximumAltitude(arg1:int):void
        {
            _maximumAltitude = arg1;
            if (altitudeFormatter) 
            {
                maximumAltitudeOutputString = altitudeFormatter.format(altitudeConverter.convert(arg1));
            }
            return;
        }

        public final function set maximumPower(arg1:Number):void
        {
            _maximumPower = arg1;
            if (powerFormatter) 
            {
                maximumPowerOutputString = powerFormatter.format(arg1);
            }
            return;
        }

        public final function get altitudeUphill():int
        {
            return _altitudeUphill;
        }

        public final function set altitudeUphill(arg1:int):void
        {
            _altitudeUphill = arg1;
            if (altitudeFormatter) 
            {
                altitudeUphillOutputString = altitudeFormatter.format(altitudeConverter.convert(arg1));
            }
            return;
        }

        public function get leftPedalingSmoothness():Number
        {
            return _leftPedalingSmoothness;
        }

        public final function get description():String
        {
            return _description;
        }

        public final function set description(arg1:String):void
        {
            _description = arg1;
            return;
        }

        public final function get averageAltitude():int
        {
            return _averageAltitude;
        }

        public final function set averageAltitude(arg1:int):void
        {
            _averageAltitude = arg1;
            if (altitudeFormatter) 
            {
                averageAltitudeOutputString = altitudeFormatter.format(altitudeConverter.convert(arg1));
            }
            return;
        }

        public function set leftPedalingSmoothness(arg1:Number):void
        {
            _leftPedalingSmoothness = arg1;
            leftPedalingSmoothnessOutputString = Math.round(_leftPedalingSmoothness).toString();
            return;
        }

        public final function get distance():Number
        {
            return _distance;
        }

        public final function set distance(arg1:Number):void
        {
            _distance = arg1;
            if (distanceFormatter) 
            {
                distanceOutputString = distanceFormatter.format(distanceConverter.convert(arg1));
            }
            return;
        }

        public function get averageBalance():Number
        {
            return _averageBalance;
        }

        public function set averageBalance(arg1:Number):void
        {
            _averageBalance = arg1;
            averageBalanceLeftOutputString = _averageBalance.toString();
            averageBalanceRightOutputString = (100 - _averageBalance).toString();
            return;
        }

        public final function get maximumPower():Number
        {
            return _maximumPower;
        }

        public final function get distanceAbsolute():Number
        {
            return _distanceAbsolute;
        }

        public final function set distanceAbsolute(arg1:Number):void
        {
            _distanceAbsolute = arg1;
            if (distanceFormatter) 
            {
                distanceAbsoluteOutputString = distanceFormatter.format(distanceConverter.convert(_distanceAbsolute));
            }
            return;
        }

        public final function get maximumInclineUphill():Number
        {
            return _maximumInclineUphill;
        }

        public final function get averageCadence():Number
        {
            return _averageCadence;
        }

        public final function set averageCadence(arg1:Number):void
        {
            _averageCadence = arg1;
            if (cadenceFormatter) 
            {
                averageCadenceOutputString = cadenceFormatter.format(arg1);
            }
            return;
        }

        public final function get maximumCadence():Number
        {
            return _maximumCadence;
        }

        public function get leftTorqueEffectivity():Number
        {
            return _leftTorqueEffectivity;
        }

        public function set leftTorqueEffectivity(arg1:Number):void
        {
            _leftTorqueEffectivity = arg1;
            leftTorqueEffectivityOutputString = Math.round(_leftTorqueEffectivity).toString();
            return;
        }

        public final function get averageHeartrate():int
        {
            return _averageHeartrate;
        }

        public final function set averageHeartrate(arg1:int):void
        {
            _averageHeartrate = arg1;
            if (heartrateFormatter) 
            {
                averageHeartrateOutputString = heartrateFormatter.format(arg1);
            }
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

        public final function set maximumCadence(arg1:Number):void
        {
            _maximumCadence = arg1;
            if (cadenceFormatter) 
            {
                maximumCadenceOutputString = cadenceFormatter.format(arg1);
            }
            return;
        }

        public final function get averageInclineDownhill():Number
        {
            return _averageInclineDownhill;
        }

        public final function set averageInclineDownhill(arg1:Number):void
        {
            _averageInclineDownhill = arg1;
            if (inclineFormatter) 
            {
                averageInclineDownhillOutputString = inclineFormatter.format(arg1);
            }
            return;
        }

        public final function get maximumInclineDownhill():Number
        {
            return _maximumInclineDownhill;
        }

        public function get pedalingTime():Number
        {
            return _pedalingTime;
        }

        public final function set maximumInclineDownhill(arg1:Number):void
        {
            _maximumInclineDownhill = arg1;
            if (inclineFormatter) 
            {
                maximumInclineDownhillOutputString = inclineFormatter.format(arg1);
            }
            return;
        }

        public final function get averageInclineUphill():Number
        {
            return _averageInclineUphill;
        }

        public final function set averageInclineUphill(arg1:Number):void
        {
            _averageInclineUphill = arg1;
            if (inclineFormatter) 
            {
                averageInclineUphillOutputString = inclineFormatter.format(arg1);
            }
            return;
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

        public final function get longitude():Number
        {
            return _longitude;
        }

        public final function get averagePower():Number
        {
            return _averagePower;
        }

        public final function set averagePower(arg1:Number):void
        {
            _averagePower = arg1;
            if (powerFormatter) 
            {
                averagePowerOutputString = powerFormatter.format(arg1);
            }
            return;
        }

        public final function set longitude(arg1:Number):void
        {
            _longitude = arg1;
            return;
        }

        public final function get duration():Number
        {
            return _duration;
        }

        public final function set duration(arg1:Number):void
        {
            _duration = arg1;
            if (timeFormatter) 
            {
                durationOutputString = timeFormatter.format(arg1);
            }
            return;
        }

        public final function get averageRiseRateDownhill():Number
        {
            return _averageRiseRateDownhill;
        }

        public final function set averageRiseRateDownhill(arg1:Number):void
        {
            _averageRiseRateDownhill = arg1;
            return;
        }

        public final function set maximumInclineUphill(arg1:Number):void
        {
            _maximumInclineUphill = arg1;
            if (inclineFormatter) 
            {
                maximumInclineUphillOutputString = inclineFormatter.format(arg1);
            }
            return;
        }

        public final function get maximumHeartrate():int
        {
            return _maximumHeartrate;
        }

        public final function get averageRiseRateUphill():Number
        {
            return _averageRiseRateUphill;
        }

        public final function set averageRiseRateUphill(arg1:Number):void
        {
            _averageRiseRateUphill = arg1;
            return;
        }

        public final function get fastLap():Boolean
        {
            return _fastLap;
        }

        public final function set fastLap(arg1:Boolean):void
        {
            _fastLap = arg1;
            return;
        }

        public final function get averageSpeed():Number
        {
            return _averageSpeed;
        }

        public final function set averageSpeed(arg1:Number):void
        {
            _averageSpeed = arg1;
            if (speedFormatter) 
            {
                _averageSpeedOutputString = speedFormatter.format(speedConverter.convert(arg1));
            }
            if (paceFormatter) 
            {
                _averageSpeedTimeOutputString = paceFormatter.format(utils.Calculations.calculateSpeedTime(arg1));
            }
            return;
        }

        public final function get markerId():int
        {
            return _markerId;
        }

        public final function set markerId(arg1:int):void
        {
            _markerId = arg1;
            return;
        }

        public final function get averageSpeedOutputString():String
        {
            return _averageSpeedOutputString;
        }

        public function get intervalCount():int
        {
            return _intervalCount;
        }

        public final function get averageSpeedTimeOutputString():String
        {
            return _averageSpeedTimeOutputString;
        }

        public function set intervalCount(arg1:int):void
        {
            _intervalCount = arg1;
            return;
        }

        public final function set maximumHeartrate(arg1:int):void
        {
            _maximumHeartrate = arg1;
            if (heartrateFormatter) 
            {
                maximumHeartrateOutputString = heartrateFormatter.format(arg1);
            }
            return;
        }

        public final function get maximumAltitude():int
        {
            return _maximumAltitude;
        }

        public final function get latitude():Number
        {
            return _latitude;
        }

        public final function get maximumRiseRateDownhill():Number
        {
            return _maximumRiseRateDownhill;
        }

        public final function set maximumRiseRateDownhill(arg1:Number):void
        {
            _maximumRiseRateDownhill = arg1;
            return;
        }

        public final function get maximumRiseRateUphill():Number
        {
            return _maximumRiseRateUphill;
        }

        public final function set maximumRiseRateUphill(arg1:Number):void
        {
            _maximumRiseRateUphill = arg1;
            return;
        }

        public final function get maximumSpeed():Number
        {
            return _maximumSpeed;
        }

        public final function set maximumSpeed(arg1:Number):void
        {
            _maximumSpeed = arg1;
            if (speedFormatter) 
            {
                _maximumSpeedOutputString = speedFormatter.format(speedConverter.convert(arg1));
            }
            if (paceFormatter) 
            {
                _maximumSpeedTimeOutputString = paceFormatter.format(utils.Calculations.calculateSpeedTime(arg1));
            }
            return;
        }

        public final function get maximumSpeedOutputString():String
        {
            return _maximumSpeedOutputString;
        }

        public final function get maximumSpeedTimeOutputString():String
        {
            return _maximumSpeedTimeOutputString;
        }

        public final function get minimumHeartrate():int
        {
            return _minimumHeartrate;
        }

        public final function set minimumHeartrate(arg1:int):void
        {
            _minimumHeartrate = arg1;
            if (heartrateFormatter) 
            {
                minimumHeartrateOutputString = heartrateFormatter.format(arg1);
            }
            return;
        }

        public final function get minimumSpeed():Number
        {
            return _minimumSpeed;
        }

        public final function set minimumSpeed(arg1:Number):void
        {
            _minimumSpeed = arg1;
            if (speedFormatter) 
            {
                _minimumSpeedOutputString = speedFormatter.format(speedConverter.convert(arg1));
            }
            if (paceFormatter) 
            {
                _minimumSpeedTimeOutputString = paceFormatter.format(utils.Calculations.calculateSpeedTime(arg1));
            }
            return;
        }

        public final function get minimumSpeedOutputString():String
        {
            return _minimumSpeedOutputString;
        }

        public final function get minimumSpeedTimeOutputString():String
        {
            return _minimumSpeedTimeOutputString;
        }

        public function get normalizedPower():Number
        {
            return _normalizedPower;
        }

        public function set normalizedPower(arg1:Number):void
        {
            _normalizedPower = arg1;
            if (powerFormatter) 
            {
                normalizedPowerOutputString = powerFormatter.format(_normalizedPower);
            }
            return;
        }

        public final function get number():int
        {
            return _number;
        }

        public final function set number(arg1:int):void
        {
            _number = arg1;
            return;
        }

        public function set pedalingTime(arg1:Number):void
        {
            _pedalingTime = arg1;
            if (timeFormatter) 
            {
                pedalingTimeOutputString = timeFormatter.format(_pedalingTime);
            }
            return;
        }

        public function get plannedAutoChange():core.training.type.PhaseChangeMode
        {
            return _plannedAutoChange;
        }

        public function set plannedAutoChange(arg1:core.training.type.PhaseChangeMode):void
        {
            _plannedAutoChange = arg1;
            return;
        }

        public function get plannedDistance():Number
        {
            return _plannedDistance;
        }

        public function set plannedDistance(arg1:Number):void
        {
            _plannedDistance = arg1;
            return;
        }

        public function get plannedLoadRecovery():core.training.type.PhaseLoadRecovery
        {
            return _plannedLoadRecovery;
        }

        public function set plannedLoadRecovery(arg1:core.training.type.PhaseLoadRecovery):void
        {
            _plannedLoadRecovery = arg1;
            return;
        }

        public function get plannedLowerLimit():int
        {
            return _plannedLowerLimit;
        }

        public function set plannedLowerLimit(arg1:int):void
        {
            _plannedLowerLimit = arg1;
            return;
        }

        public function get plannedPhaseControl():core.training.type.PhaseControl
        {
            return _plannedPhaseControl;
        }

        public function set plannedPhaseControl(arg1:core.training.type.PhaseControl):void
        {
            _plannedPhaseControl = arg1;
            return;
        }

        public function get plannedRecoveryDistance():Number
        {
            return _plannedRecoveryDistance;
        }

        public function set plannedRecoveryDistance(arg1:Number):void
        {
            _plannedRecoveryDistance = arg1;
            return;
        }

        public function get plannedRecoveryLowerLimit():int
        {
            return _plannedRecoveryLowerLimit;
        }

        public function set plannedRecoveryLowerLimit(arg1:int):void
        {
            _plannedRecoveryLowerLimit = arg1;
            return;
        }

        public function get plannedRecoveryPhaseControl():core.training.type.PhaseControl
        {
            return _plannedRecoveryPhaseControl;
        }

        public function set plannedRecoveryPhaseControl(arg1:core.training.type.PhaseControl):void
        {
            _plannedRecoveryPhaseControl = arg1;
            return;
        }

        public function get plannedRecoveryTime():Number
        {
            return _plannedRecoveryTime;
        }

        public function set plannedRecoveryTime(arg1:Number):void
        {
            _plannedRecoveryTime = arg1;
            return;
        }

        public function get plannedRecoveryUpperLimit():int
        {
            return _plannedRecoveryUpperLimit;
        }

        public function set plannedRecoveryUpperLimit(arg1:int):void
        {
            _plannedRecoveryUpperLimit = arg1;
            return;
        }

        public function get plannedTime():Number
        {
            return _plannedTime;
        }

        public function set plannedTime(arg1:Number):void
        {
            _plannedTime = arg1;
            return;
        }

        public function get plannedUpperLimit():int
        {
            return _plannedUpperLimit;
        }

        public function set plannedUpperLimit(arg1:int):void
        {
            _plannedUpperLimit = arg1;
            return;
        }

        public function get rightPedalingSmoothness():Number
        {
            return _rightPedalingSmoothness;
        }

        public function set rightPedalingSmoothness(arg1:Number):void
        {
            _rightPedalingSmoothness = arg1;
            rightPedalingSmoothnessOutputString = Math.round(_rightPedalingSmoothness).toString();
            return;
        }

        public function get rightTorqueEffectivity():Number
        {
            return _rightTorqueEffectivity;
        }

        public function set rightTorqueEffectivity(arg1:Number):void
        {
            _rightTorqueEffectivity = arg1;
            rightTorqueEffectivityOutputString = Math.round(_rightTorqueEffectivity).toString();
            return;
        }

        public final function get tXSensorPosition():String
        {
            return _tXSensorPosition;
        }

        public final function set tXSensorPosition(arg1:String):void
        {
            _tXSensorPosition = arg1;
            return;
        }

        public final function get time():Number
        {
            return _time;
        }

        public final function set time(arg1:Number):void
        {
            _time = arg1;
            if (timeFormatter) 
            {
                timeOutputString = timeFormatter.format(_time);
            }
            return;
        }

        public final function get timeAbsolute():Number
        {
            return _timeAbsolute;
        }

        public final function set timeAbsolute(arg1:Number):void
        {
            _timeAbsolute = arg1;
            if (timeFormatter) 
            {
                timeAbsoluteOutputString = timeFormatter.format(_timeAbsolute);
            }
            return;
        }

        public final function get timeDownhill():Number
        {
            return _timeDownhill;
        }

        public final function set timeDownhill(arg1:Number):void
        {
            _timeDownhill = arg1;
            return;
        }

        public function get timeInTargetZone():Number
        {
            return _timeInTargetZone;
        }

        public function set timeInTargetZone(arg1:Number):void
        {
            _timeInTargetZone = arg1;
            if (timeFormatter) 
            {
                timeInTargetZoneOutputString = timeFormatter.format(arg1);
            }
            return;
        }

        public function get timeOverTargetZone():Number
        {
            return _timeOverTargetZone;
        }

        public function set timeOverTargetZone(arg1:Number):void
        {
            _timeOverTargetZone = arg1;
            if (timeFormatter) 
            {
                timeOverTargetZoneOutputString = timeFormatter.format(arg1);
            }
            return;
        }

        public function get timeUnderTargetZone():Number
        {
            return _timeUnderTargetZone;
        }

        public function set timeUnderTargetZone(arg1:Number):void
        {
            _timeUnderTargetZone = arg1;
            if (timeFormatter) 
            {
                timeUnderTargetZoneOutputString = timeFormatter.format(arg1);
            }
            return;
        }

        public final function get timeUphill():Number
        {
            return _timeUphill;
        }

        public final function set timeUphill(arg1:Number):void
        {
            _timeUphill = arg1;
            return;
        }

        public final function get title():String
        {
            return _title;
        }

        public final function set title(arg1:String):void
        {
            _title = arg1;
            return;
        }

        public final function get type():String
        {
            return _type;
        }

        public final function set type(arg1:String):void
        {
            _type = arg1;
            return;
        }

        internal static const DEFAULT_OUTPUT_STRING:String="0";

        internal var _longitude:Number=0;

        public var longitudeDefined:Boolean=false;

        internal var _markerId:Number=0;

        internal var _maximumAltitude:int;

        public var maximumAltitudeDefined:Boolean=false;

        public var maximumAltitudeOutputString:String="0";

        internal var _maximumCadence:Number=0;

        public var maximumCadenceDefined:Boolean=false;

        public var maximumCadenceOutputString:String="0";

        internal var _maximumHeartrate:int;

        public var maximumHeartrateDefined:Boolean=false;

        public var maximumHeartrateOutputString:String="0";

        internal var _maximumInclineDownhill:Number=0;

        public var maximumInclineDownhillDefined:Boolean=false;

        public var maximumInclineDownhillOutputString:String="0";

        internal var _maximumInclineUphill:Number=0;

        public var maximumInclineUphillDefined:Boolean=false;

        public var maximumInclineUphillOutputString:String="0";

        internal var _maximumPower:Number=0;

        public var maximumPowerDefined:Boolean=false;

        public var averageInclineDownhillOutputString:String="0";

        internal var _maximumRiseRateDownhill:Number=0;

        internal var _activityId:int;

        internal var _altitudeDownhill:int;

        public var maximumRiseRateDownhillDefined:Boolean=false;

        internal var _maximumRiseRateUphill:Number=0;

        public var altitudeDownhillDefined:Boolean=false;

        public var altitudeDownhillOutputString:String="0";

        public var maximumRiseRateUphillDefined:Boolean=false;

        internal var _maximumSpeed:Number=0;

        internal var _altitudeUphill:int;

        public var altitudeUphillDefined:Boolean=false;

        public var maximumSpeedDefined:Boolean=false;

        internal var _maximumSpeedOutputString:String="0";

        public var altitudeUphillOutputString:String="0";

        internal var _maximumSpeedTimeOutputString:String="0";

        internal var _averageAltitude:int;

        internal var _minimumHeartrate:int;

        public var averageAltitudeDefined:Boolean=false;

        public var averageAltitudeOutputString:String="0";

        public var minimumHeartrateDefined:Boolean=false;

        public var minimumHeartrateOutputString:String="0";

        internal var _minimumSpeed:Number=0;

        internal var _averageBalance:Number=0;

        public var averageBalanceDefined:Boolean=false;

        public var minimumSpeedDefined:Boolean=false;

        internal var _minimumSpeedOutputString:String="0";

        public var averageBalanceLeftOutputString:String;

        internal var _minimumSpeedTimeOutputString:String="0";

        public var averageBalanceRightOutputString:String;

        internal var _normalizedPower:Number=0;

        internal var _averageCadence:Number=0;

        public var averageCadenceDefined:Boolean=false;

        public var normalizedPowerDefined:Boolean=false;

        public var normalizedPowerOutputString:String="0";

        internal var _number:int;

        public var averageCadenceOutputString:String="0";

        internal var _averageHeartrate:int;

        internal var _pedalingTime:Number=0;

        public var maximumPowerOutputString:String="0";

        public var averageHeartrateDefined:Boolean=false;

        public var pedalingTimeDefined:Boolean=false;

        public var pedalingTimeOutputString:String="0";

        internal var _plannedAutoChange:core.training.type.PhaseChangeMode;

        public var averageHeartrateOutputString:String="0";

        internal var _averageInclineDownhill:Number=0;

        public var plannedAutoChangeDefined:Boolean=false;

        internal var _plannedDistance:Number=0;

        public var averageInclineDownhillDefined:Boolean=false;

        internal var _averageInclineUphill:Number=0;

        public var plannedDistanceDefined:Boolean=false;

        internal var _plannedLoadRecovery:core.training.type.PhaseLoadRecovery;

        public var averageInclineUphillDefined:Boolean=false;

        public var averageInclineUphillOutputString:String="0";

        public var plannedLoadRecoveryDefined:Boolean=false;

        internal var _plannedLowerLimit:int=0;

        internal var _averagePower:Number=0;

        public var averagePowerDefined:Boolean=false;

        public var plannedLowerLimitDefined:Boolean=false;

        internal var _plannedPhaseControl:core.training.type.PhaseControl;

        public var averagePowerOutputString:String="0";

        internal var _averageRiseRateDownhill:Number=0;

        public var plannedPhaseControlDefined:Boolean=false;

        internal var _plannedRecoveryDistance:Number=0;

        public var averageRiseRateDownhillDefined:Boolean=false;

        internal var _averageRiseRateUphill:Number=0;

        public var plannedRecoveryDistanceDefined:Boolean=false;

        internal var _plannedRecoveryLowerLimit:int=0;

        public var averageRiseRateUphillDefined:Boolean=false;

        internal var _averageSpeed:Number=0;

        public var plannedRecoveryLowerLimitDefined:Boolean=false;

        internal var _plannedRecoveryPhaseControl:core.training.type.PhaseControl;

        public var averageSpeedDefined:Boolean=false;

        internal var _averageSpeedOutputString:String="0";

        public var plannedRecoveryPhaseControlDefined:Boolean=false;

        internal var _plannedRecoveryTime:Number=0;

        internal var _averageSpeedTimeOutputString:String="0";

        public var avgCadenceCount:int=0;

        public var plannedRecoveryTimeDefined:Boolean=false;

        internal var _plannedRecoveryUpperLimit:int=0;

        public var avgHRCount:int=0;

        public var avgPowerCount:int=0;

        public var plannedRecoveryUpperLimitDefined:Boolean=false;

        internal var _plannedTime:Number=0;

        public var avgSpeedCount:int=0;

        internal var _calories:Number=0;

        public var plannedTimeDefined:Boolean=false;

        internal var _plannedUpperLimit:int=0;

        public var caloriesDefined:Boolean=false;

        public var caloriesOutputString:String="0";

        public var plannedUpperLimitDefined:Boolean=false;

        internal var _rightPedalingSmoothness:Number=0;

        internal var _description:String="";

        internal var _distance:Number=0;

        public var rightPedalingSmoothnessDefined:Boolean=false;

        public var rightPedalingSmoothnessOutputString:String="0";

        internal var _rightTorqueEffectivity:Number=0;

        internal var _distanceAbsolute:Number=0;

        public var distanceAbsoluteDefined:Boolean=false;

        public var rightTorqueEffectivityDefined:Boolean=false;

        public var rightTorqueEffectivityOutputString:String="0";

        internal var _tXSensorPosition:String="";

        public var distanceAbsoluteOutputString:String="0";

        public var distanceDefined:Boolean=false;

        public var tXSensorPositionDefined:Boolean=false;

        internal var _time:Number=0;

        internal var _distanceDownhill:Number=0;

        public var distanceDownhillDefined:Boolean=false;

        internal var _timeAbsolute:Number=0;

        public var distanceOutputString:String="0";

        internal var _distanceUphill:Number=0;

        public var timeAbsoluteOutputString:String="0";

        internal var _timeDownhill:Number=0;

        public var distanceUphillDefined:Boolean=false;

        internal var _duration:Number=0;

        public var timeDownhillDefined:Boolean=false;

        internal var _timeInTargetZone:Number=0;

        public var durationOutputString:String="0";

        internal var _fastLap:Boolean;

        public var timeInTargetZoneDefined:Boolean=false;

        public var timeInTargetZoneOutputString:String="0";

        public var timeOutputString:String="";

        internal var _timeOverTargetZone:Number=0;

        public var fastLapDefined:Boolean=false;

        internal var _intervalCount:int=0;

        public var timeOverTargetZoneDefined:Boolean=false;

        public var timeOverTargetZoneOutputString:String="0";

        internal var _timeUnderTargetZone:Number=0;

        public var intervalCountDefined:Boolean=false;

        internal var _latitude:Number=0;

        public var timeUnderTargetZoneDefined:Boolean=false;

        public var timeUnderTargetZoneOutputString:String="0";

        internal var _timeUphill:Number=0;

        public var latitudeDefined:Boolean=false;

        internal var _leftPedalingSmoothness:Number=0;

        public var timeUphillDefined:Boolean=false;

        internal var _title:String="";

        public var leftPedalingSmoothnessDefined:Boolean=false;

        public var leftPedalingSmoothnessOutputString:String="0";

        internal var _type:String="";

        internal var _leftTorqueEffectivity:Number=0;

        public var leftTorqueEffectivityDefined:Boolean=false;

        public static var initFormatter:Boolean=true;

        public var leftTorqueEffectivityOutputString:String="0";

        internal static var altitudeConverter:utils.converter.AltitudeConverter;

        internal static var altitudeFormatter:utils.interfaces.ICustomFormatter;

        internal static var cadenceFormatter:utils.interfaces.ICustomFormatterBase;

        internal static var caloriesFormatter:utils.interfaces.ICustomFormatterBase;

        internal static var dateFormatter:utils.interfaces.ICustomDateTimeFormatter;

        internal static var distanceConverter:utils.converter.DistanceConverter;

        internal static var distanceFormatter:utils.interfaces.ICustomFormatter;

        internal static var heartrateFormatter:utils.interfaces.ICustomFormatterBase;

        internal static var inclineFormatter:utils.interfaces.ICustomFormatterBase;

        internal static var paceFormatter:utils.interfaces.ICustomTimeFormatter;

        internal static var powerFormatter:utils.interfaces.ICustomFormatterBase;

        internal static var speedConverter:utils.converter.SpeedConverter;

        internal static var speedFormatter:utils.interfaces.ICustomFormatter;

        internal static var speedTimeFormatter:flash.globalization.DateTimeFormatter;

        internal static var timeFormatter:utils.interfaces.ICustomTimeFormatter;
    }
}


