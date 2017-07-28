//class Activity
package core.activities 
{
    import __AS3__.vec.*;
    import core.*;
    import core.general.*;
    import core.general.interfaces.*;
    import core.marker.*;
    import core.participant.*;
    import core.sport.*;
    import core.training.*;
    import core.units.*;
    import debug.*;
    import flash.errors.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.utils.*;
    import init.*;
    import mx.events.*;
    import utils.*;
    import utils.converter.*;
    import utils.interfaces.*;
    
    public class Activity extends flash.events.EventDispatcher implements core.general.interfaces.IImportFromDevice, core.general.interfaces.IGeneralDataInformation, core.general.interfaces.ISynchronisable
    {
        public function Activity(arg1:Object=null)
        {
            autoLapValuesLoaded = [];
            averagePowerDefined = false;
            _entries = new __AS3__.vec.Vector.<core.activities.ActivityEntry>();
            _reducedEntries = new __AS3__.vec.Vector.<core.activities.ActivityEntry>();
            _ghostData = [];
            lapValuesLoaded = [];
            loggingPauseValuesLoaded = [];
            _markerList = new __AS3__.vec.Vector.<core.marker.Marker>();
            _participant = new __AS3__.vec.Vector.<core.participant.Person>();
            phaseValuesLoaded = [];
            recordValuesLoaded = [];
            shared = false;
            sharedTo2Peak = false;
            sharedToFacebook = false;
            sharedToStrava = false;
            sharedToTrainingPeaks = false;
            sharedToTwitter = false;
            _startDate = new Date();
            timeInIntensityZone1Defined = false;
            timeInZone1Defined = false;
            _trainingCategory = core.general.TrainingCategory.NONE;
            trainingTypeDefined = false;
            trainingZoneDefined = false;
            super(this);
            var loc1:*=false;
            if (arg1 is core.activities.Activity) 
            {
                loc1 = core.activities.ActivityFactory.isCreatedByFactory((arg1 as core.activities.Activity).instanceObject);
            }
            else 
            {
                loc1 = core.activities.ActivityFactory.isCreatedByFactory(arg1);
            }
            if (!loc1 && !allowActivityCopy) 
            {
                throw new flash.errors.IllegalOperationError("Use the factory to instantiate an activity.");
            }
            instanceObject = arg1;
            recalculatedValues = new core.activities.ActivityRecalculationValues(this);
            if (initFormatter) 
            {
                resetFormatterAndConverter();
            }
            distance = 0;
            trainingTime = 0;
            return;
        }

        public function set maximumAltitude(arg1:int):void
        {
            _maximumAltitude = arg1;
            return;
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

        public function get dataType():String
        {
            return _dataType;
        }

        public function get activeTimeHigh():Number
        {
            return _activeTimeHigh;
        }

        public function set activeTimeHigh(arg1:Number):void
        {
            _activeTimeHigh = arg1;
            if (timeFormatterHHMM) 
            {
                activeTimeHighOutputString = timeFormatterHHMM.format(arg1);
            }
            return;
        }

        public function set dataType(arg1:String):void
        {
            _dataType = arg1;
            return;
        }

        public function get latitudeEnd():Number
        {
            return _latitudeEnd;
        }

        public function get dateCode():String
        {
            return _dateCode;
        }

        public function get activeTimeLow():Number
        {
            return _activeTimeLow;
        }

        public function set activeTimeLow(arg1:Number):void
        {
            _activeTimeLow = arg1;
            if (timeFormatterHHMM) 
            {
                activeTimeLowOutputString = timeFormatterHHMM.format(arg1);
            }
            return;
        }

        public function set dateCode(arg1:String):void
        {
            _dateCode = arg1;
            return;
        }

        public function set latitudeEnd(arg1:Number):void
        {
            _latitudeEnd = arg1;
            return;
        }

        public function set minimumInclineDownhill(arg1:Number):void
        {
            _minimumInclineDownhill = arg1;
            return;
        }

        public function get activeTimeMiddle():Number
        {
            return _activeTimeMiddle;
        }

        public function set activeTimeMiddle(arg1:Number):void
        {
            _activeTimeMiddle = arg1;
            if (timeFormatterHHMM) 
            {
                activeTimeMiddleOutputString = timeFormatterHHMM.format(arg1);
            }
            return;
        }

        public function get maximumRiseRate():Number
        {
            return _maximumRiseRate;
        }

        public function get description():String
        {
            return _description;
        }

        public function set description(arg1:String):void
        {
            _description = arg1;
            return;
        }

        public function get activityId():uint
        {
            return _activityId;
        }

        public function set activityId(arg1:uint):void
        {
            _activityId = arg1;
            return;
        }

        public function get latitudeStart():Number
        {
            return _latitudeStart;
        }

        public function set latitudeStart(arg1:Number):void
        {
            _latitudeStart = arg1;
            return;
        }

        public function get age():uint
        {
            return _age;
        }

        public function set age(arg1:uint):void
        {
            _age = arg1;
            return;
        }

        public function get distance():Number
        {
            return _distance;
        }

        public function set distance(arg1:Number):void
        {
            _distance = arg1;
            if (distanceFormatter) 
            {
                distanceOutputString = distanceFormatter.format(distanceConverter.convert(arg1));
            }
            return;
        }

        public function get alreadySaved():Boolean
        {
            return _alreadySaved;
        }

        public function set alreadySaved(arg1:Boolean):void
        {
            _alreadySaved = arg1;
            return;
        }

        public function get maximumCadence():uint
        {
            return _maximumCadence;
        }

        public function get altitudeDifferencesDownhill():uint
        {
            return _altitudeDifferencesDownhill;
        }

        public function set altitudeDifferencesDownhill(arg1:uint):void
        {
            _altitudeDifferencesDownhill = arg1;
            return;
        }

        public function set maximumCadence(arg1:uint):void
        {
            _maximumCadence = arg1;
            return;
        }

        public function get distanceDownhill():Number
        {
            return _distanceDownhill;
        }

        public function get altitudeDifferencesUphill():uint
        {
            return _altitudeDifferencesUphill;
        }

        public function set altitudeDifferencesUphill(arg1:uint):void
        {
            _altitudeDifferencesUphill = arg1;
            if (altitudeFormatter) 
            {
                altitudeDifferencesUphillOutputString = altitudeFormatter.format(altitudeConverter.convert(arg1));
            }
            return;
        }

        public function set distanceDownhill(arg1:Number):void
        {
            _distanceDownhill = arg1;
            return;
        }

        public function get linkedRouteId():uint
        {
            return _linkedRouteId;
        }

        public function set linkedRouteId(arg1:uint):void
        {
            _linkedRouteId = arg1;
            return;
        }

        public function get distanceMinus():Number
        {
            return this._distanceMinus;
        }

        public function set distanceMinus(arg1:Number):void
        {
            this._distanceMinus = arg1;
            return;
        }

        public function set maximumRiseRate(arg1:Number):void
        {
            _maximumRiseRate = arg1;
            return;
        }

        public function get minimumHeartrate():uint
        {
            return _minimumHeartrate;
        }

        public function get averageAltitude():int
        {
            return _averageAltitude;
        }

        public function set averageAltitude(arg1:int):void
        {
            _averageAltitude = arg1;
            return;
        }

        public function get linkedTrackGUID():String
        {
            return _linkedTrackGUID;
        }

        public function get distancePlus():Number
        {
            return this._distancePlus;
        }

        public function set distancePlus(arg1:Number):void
        {
            this._distancePlus = arg1;
            return;
        }

        public function set linkedTrackGUID(arg1:String):void
        {
            _linkedTrackGUID = arg1;
            return;
        }

        public function set minimumHeartrate(arg1:uint):void
        {
            _minimumHeartrate = arg1;
            return;
        }

        public function get distancePlusMinusStatus():String
        {
            return _distancePlusMinusStatus;
        }

        public function get averageCadence():Number
        {
            return _averageCadence;
        }

        public function set averageCadence(arg1:Number):void
        {
            _averageCadence = arg1;
            return;
        }

        public function set distancePlusMinusStatus(arg1:String):void
        {
            _distancePlusMinusStatus = arg1;
            return;
        }

        public function get maximumRiseRateDownhill():Number
        {
            return _maximumRiseRateDownhill;
        }

        public function get logType():core.general.LogType
        {
            return _logType;
        }

        public function get distanceUphill():Number
        {
            return this._distanceUphill;
        }

        public function get averageExpansion():Number
        {
            return _averageExpansion;
        }

        public function set averageExpansion(arg1:Number):void
        {
            _averageExpansion = arg1;
            return;
        }

        public function set distanceUphill(arg1:Number):void
        {
            this._distanceUphill = arg1;
            return;
        }

        public function set logType(arg1:core.general.LogType):void
        {
            _logType = arg1;
            return;
        }

        public function get averageExpansionDownhill():Number
        {
            return _averageExpansionDownhill;
        }

        public function set averageExpansionDownhill(arg1:Number):void
        {
            _averageExpansionDownhill = arg1;
            return;
        }

        public function set maximumRiseRateDownhill(arg1:Number):void
        {
            _maximumRiseRateDownhill = arg1;
            return;
        }

        public function get minimumInclineUphill():Number
        {
            return _minimumInclineUphill;
        }

        public function get averageExpansionUphill():Number
        {
            return _averageExpansionUphill;
        }

        public function set averageExpansionUphill(arg1:Number):void
        {
            _averageExpansionUphill = arg1;
            return;
        }

        public function get logVersion():String
        {
            return _logVersion;
        }

        public function get entries():__AS3__.vec.Vector.<core.activities.ActivityEntry>
        {
            return _entries;
        }

        public function get averageHeartrate():uint
        {
            return _averageHeartrate;
        }

        public function set averageHeartrate(arg1:uint):void
        {
            _averageHeartrate = arg1;
            if (heartrateFormatter) 
            {
                averageHeartrateOutputString = heartrateFormatter.format(arg1);
            }
            return;
        }

        public function set entries(arg1:__AS3__.vec.Vector.<core.activities.ActivityEntry>):void
        {
            if (arg1 != _entries) 
            {
                _entries = arg1;
            }
            return;
        }

        public function set logVersion(arg1:String):void
        {
            _logVersion = arg1;
            return;
        }

        public function get reducedEntries():__AS3__.vec.Vector.<core.activities.ActivityEntry>
        {
            return _reducedEntries;
        }

        public function get averageInclineDownhill():Number
        {
            return _averageInclineDownhill;
        }

        public function set averageInclineDownhill(arg1:Number):void
        {
            _averageInclineDownhill = arg1;
            return;
        }

        public function set reducedEntries(arg1:__AS3__.vec.Vector.<core.activities.ActivityEntry>):void
        {
            if (arg1 != _reducedEntries) 
            {
                _reducedEntries = arg1;
            }
            return;
        }

        public function set minimumInclineUphill(arg1:Number):void
        {
            _minimumInclineUphill = arg1;
            return;
        }

        public function get averageInclineUphill():Number
        {
            return _averageInclineUphill;
        }

        public function set averageInclineUphill(arg1:Number):void
        {
            _averageInclineUphill = arg1;
            return;
        }

        public function get minimumAltitude():int
        {
            return _minimumAltitude;
        }

        public function get exerciseTime():Number
        {
            return _exerciseTime;
        }

        public function get averagePercentHRMax():Number
        {
            return _averagePercentHRMax;
        }

        public function set averagePercentHRMax(arg1:Number):void
        {
            _averagePercentHRMax = arg1;
            return;
        }

        public function set exerciseTime(arg1:Number):void
        {
            _exerciseTime = arg1;
            return;
        }

        public function get maximumRiseRateUphill():Number
        {
            return _maximumRiseRateUphill;
        }

        public function get averagePower():Number
        {
            return _averagePower;
        }

        public function set averagePower(arg1:Number):void
        {
            _averagePower = arg1;
            if (powerFormatter) 
            {
                averagePowerOutputString = powerFormatter.format(arg1);
            }
            return;
        }

        public function get maximumHeartrate():uint
        {
            return _maximumHeartrate;
        }

        public function get externalLink():String
        {
            return _externalLink;
        }

        public function set externalLink(arg1:String):void
        {
            _externalLink = arg1;
            return;
        }

        public function get averagePowerDefined():Boolean
        {
            return this.averagePowerDefined;
        }

        public function set averagePowerDefined(arg1:Boolean):void
        {
            var loc1:*=this.averagePowerDefined;
            if (loc1 !== arg1) 
            {
                this.averagePowerDefined = arg1;
                if (this.hasEventListener("propertyChange")) 
                {
                    this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "averagePowerDefined", loc1, arg1));
                }
            }
            return;
        }

        public function get longitudeEnd():Number
        {
            return _longitudeEnd;
        }

        public function get averagePowerKJ():Number
        {
            return _averagePowerKJ;
        }

        public function set averagePowerKJ(arg1:Number):void
        {
            _averagePowerKJ = arg1;
            return;
        }

        public function set longitudeEnd(arg1:Number):void
        {
            _longitudeEnd = arg1;
            return;
        }

        public function get feeling():uint
        {
            return _feeling;
        }

        public function set feeling(arg1:uint):void
        {
            _feeling = arg1;
            return;
        }

        public function get averagePowerWattPerKG():Number
        {
            return _averagePowerWattPerKG;
        }

        public function set averagePowerWattPerKG(arg1:Number):void
        {
            _averagePowerWattPerKG = arg1;
            return;
        }

        public function set maximumHeartrate(arg1:uint):void
        {
            _maximumHeartrate = arg1;
            return;
        }

        public function set maximumRiseRateUphill(arg1:Number):void
        {
            _maximumRiseRateUphill = arg1;
            return;
        }

        public function get averageRiseRate():Number
        {
            return _averageRiseRate;
        }

        public function set averageRiseRate(arg1:Number):void
        {
            _averageRiseRate = arg1;
            return;
        }

        public function get fuelEconomy():Number
        {
            return _fuelEconomy;
        }

        public function set fuelEconomy(arg1:Number):void
        {
            _fuelEconomy = arg1;
            return;
        }

        public function get averageRiseRateDownhill():Number
        {
            return _averageRiseRateDownhill;
        }

        public function set averageRiseRateDownhill(arg1:Number):void
        {
            _averageRiseRateDownhill = arg1;
            return;
        }

        public function get longitudeStart():Number
        {
            return _longitudeStart;
        }

        public function set longitudeStart(arg1:Number):void
        {
            _longitudeStart = arg1;
            return;
        }

        public function get averageRiseRateUphill():Number
        {
            return _averageRiseRateUphill;
        }

        public function set averageRiseRateUphill(arg1:Number):void
        {
            _averageRiseRateUphill = arg1;
            return;
        }

        public function get gender():String
        {
            return _gender;
        }

        public function set gender(arg1:String):void
        {
            _gender = arg1;
            return;
        }

        public function get averageSpeed():Number
        {
            return _averageSpeed;
        }

        public function set averageSpeed(arg1:Number):void
        {
            _averageSpeed = arg1;
            if (speedFormatter) 
            {
                averageSpeedOutputString = speedFormatter.format(speedConverter.convert(arg1));
            }
            if (speedTimeFormatter) 
            {
                averageSpeedTimeOutputString = speedTimeFormatter.format(utils.Calculations.calculateSpeedTime(_averageSpeed));
            }
            return;
        }

        public function set minimumAltitude(arg1:int):void
        {
            _minimumAltitude = arg1;
            return;
        }

        
        {
            altitudeConverter = new utils.converter.AltitudeConverter("millimeter", core.MeasurementConfig.altitudeFormat);
            distanceConverter = new utils.converter.DistanceConverter("meter", core.MeasurementConfig.distanceFormat);
            speedConverter = new utils.converter.SpeedConverter("ms", core.MeasurementConfig.speedFormat);
        }

        public function get averageSpeedDownhill():Number
        {
            return _averageSpeedDownhill;
        }

        public function set averageSpeedDownhill(arg1:Number):void
        {
            _averageSpeedDownhill = arg1;
            return;
        }

        public function get maximumIncline():Number
        {
            return _maximumIncline;
        }

        public function get ghostData():Array
        {
            return _ghostData;
        }

        public function set ghostData(arg1:Array):void
        {
            if (arg1 != _ghostData) 
            {
                _ghostData = arg1;
                dispatchEvent(new flash.events.Event("ghostDataChange"));
            }
            return;
        }

        public function get lowerLimit():uint
        {
            return _lowerLimit;
        }

        public function get averageSpeedUphill():Number
        {
            return _averageSpeedUphill;
        }

        public function set averageSpeedUphill(arg1:Number):void
        {
            _averageSpeedUphill = arg1;
            return;
        }

        public function get ghostName():String
        {
            return _ghostName;
        }

        public function set ghostName(arg1:String):void
        {
            if (arg1 != _ghostName) 
            {
                _ghostName = arg1;
                dispatchEvent(new flash.events.Event("ghostNameChange"));
            }
            return;
        }

        public function get averageTemperature():Number
        {
            return _averageTemperature;
        }

        public function set averageTemperature(arg1:Number):void
        {
            _averageTemperature = arg1;
            return;
        }

        public function set lowerLimit(arg1:uint):void
        {
            _lowerLimit = arg1;
            return;
        }

        public function get hrMax():int
        {
            return _hrMax;
        }

        public function get best20minPower():Number
        {
            return _best20minPower;
        }

        public function set best20minPower(arg1:Number):void
        {
            _best20minPower = arg1;
            best20minPowerDefined = !(_best20minPower == 0);
            return;
        }

        public function set hrMax(arg1:int):void
        {
            _hrMax = arg1;
            return;
        }

        public function set maximumIncline(arg1:Number):void
        {
            _maximumIncline = arg1;
            return;
        }

        public function get best20minPowerEntry():int
        {
            return _best20minPowerEntry;
        }

        public function set best20minPowerEntry(arg1:int):void
        {
            _best20minPowerEntry = arg1;
            best20minPowerEntryDefined = !(_best20minPowerEntry == 0);
            return;
        }

        public function get minimumInclineDownhill():Number
        {
            return _minimumInclineDownhill;
        }

        public function get importFromDevice():Boolean
        {
            return _importFromDevice;
        }

        public function get best5KEntry():int
        {
            return _best5KEntry;
        }

        public function set best5KEntry(arg1:int):void
        {
            _best5KEntry = arg1;
            best5KEntryDefined = !(_best5KEntry == 0);
            return;
        }

        public function set importFromDevice(arg1:Boolean):void
        {
            _importFromDevice = arg1;
            return;
        }

        public function get manualTemperature():Number
        {
            return _manualTemperature;
        }

        public function get best5KTime():Number
        {
            return _best5KTime;
        }

        public function set best5KTime(arg1:Number):void
        {
            _best5KTime = arg1;
            best5KTimeDefined = !(_best5KTime == 0);
            return;
        }

        public function set manualTemperature(arg1:Number):void
        {
            _manualTemperature = arg1;
            return;
        }

        public function get intensityZone1Start():uint
        {
            return _intensityZone1Start;
        }

        public function get bike():String
        {
            return _bike;
        }

        public function set bike(arg1:String):void
        {
            _bike = arg1;
            return;
        }

        public function set intensityZone1Start(arg1:uint):void
        {
            _intensityZone1Start = arg1;
            return;
        }

        public function get maximumSpeed():Number
        {
            return _maximumSpeed;
        }

        public function get bikeType():String
        {
            return _bikeType;
        }

        public function set bikeType(arg1:String):void
        {
            _bikeType = arg1;
            return;
        }

        public function get maximumInclineDownhill():Number
        {
            return _maximumInclineDownhill;
        }

        public function get intensityZone2Start():uint
        {
            return _intensityZone2Start;
        }

        public function get bikeWeight():uint
        {
            return _bikeWeight;
        }

        public function set bikeWeight(arg1:uint):void
        {
            _bikeWeight = arg1;
            return;
        }

        public function set intensityZone2Start(arg1:uint):void
        {
            _intensityZone2Start = arg1;
            return;
        }

        public function get markerList():__AS3__.vec.Vector.<core.marker.Marker>
        {
            return _markerList;
        }

        public function get bikeWeightUnit():String
        {
            return _bikeWeightUnit;
        }

        public function set bikeWeightUnit(arg1:String):void
        {
            _bikeWeightUnit = arg1;
            return;
        }

        public function set markerList(arg1:__AS3__.vec.Vector.<core.marker.Marker>):void
        {
            _markerList = arg1;
            return;
        }

        public function get intensityZone3Start():uint
        {
            return _intensityZone3Start;
        }

        public function get bodyHeight():Number
        {
            return _bodyHeight;
        }

        public function set bodyHeight(arg1:Number):void
        {
            _bodyHeight = arg1;
            return;
        }

        public function set intensityZone3Start(arg1:uint):void
        {
            _intensityZone3Start = arg1;
            return;
        }

        public function set maximumInclineDownhill(arg1:Number):void
        {
            _maximumInclineDownhill = arg1;
            return;
        }

        public function get bodyHeightUnit():String
        {
            return _bodyHeightUnit;
        }

        public function set bodyHeightUnit(arg1:String):void
        {
            _bodyHeightUnit = arg1;
            return;
        }

        public function set maximumSpeed(arg1:Number):void
        {
            _maximumSpeed = arg1;
            return;
        }

        public function get intensityZone4End():uint
        {
            return _intensityZone4End;
        }

        public function get bodyWeight():uint
        {
            return _bodyWeight;
        }

        public function set bodyWeight(arg1:uint):void
        {
            _bodyWeight = arg1;
            return;
        }

        public function set intensityZone4End(arg1:uint):void
        {
            _intensityZone4End = arg1;
            return;
        }

        public function get bodyWeightUnit():String
        {
            return _weightUnit;
        }

        public function set bodyWeightUnit(arg1:String):void
        {
            _weightUnit = arg1;
            return;
        }

        public function get minimumIncline():Number
        {
            return _minimumIncline;
        }

        public function get maximumInclineUphill():Number
        {
            return _maximumInclineUphill;
        }

        public function get calibration():Boolean
        {
            return _calibration;
        }

        public function set calibration(arg1:Boolean):void
        {
            _calibration = arg1;
            return;
        }

        public function get intensityZone4Start():uint
        {
            return _intensityZone4Start;
        }

        public function set intensityZone4Start(arg1:uint):void
        {
            _intensityZone4Start = arg1;
            return;
        }

        public function get calories():Number
        {
            return _calories;
        }

        public function set calories(arg1:Number):void
        {
            _calories = arg1;
            if (caloriesFormatter) 
            {
                caloriesOutputString = caloriesFormatter.format(arg1);
            }
            return;
        }

        public function set maximumInclineUphill(arg1:Number):void
        {
            _maximumInclineUphill = arg1;
            return;
        }

        public function get minimumCadence():uint
        {
            return _minimumCadence;
        }

        public function get caloriesDifferenceFactor():Number
        {
            return _caloriesDifferenceFactor;
        }

        public function set caloriesDifferenceFactor(arg1:Number):void
        {
            _caloriesDifferenceFactor = arg1;
            return;
        }

        public function get maximumTemperature():Number
        {
            return _maximumTemperature;
        }

        public function get isDeleted():Boolean
        {
            return _isDeleted;
        }

        public function set isDeleted(arg1:Boolean):void
        {
            _isDeleted = arg1;
            return;
        }

        public function get chestbeltManufacturer():String
        {
            return _chestbeltManufacturer;
        }

        public function set chestbeltManufacturer(arg1:String):void
        {
            _chestbeltManufacturer = arg1;
            return;
        }

        public function get maximumPercentHRMax():Number
        {
            return _maximumPercentHRMax;
        }

        public function get isNew():Boolean
        {
            return _isNew;
        }

        public function set isNew(arg1:Boolean):void
        {
            _isNew = arg1;
            return;
        }

        public function get correctionChestRun():Number
        {
            return _correctionChestRun;
        }

        public function set correctionChestRun(arg1:Number):void
        {
            _correctionChestRun = arg1;
            return;
        }

        public function set maximumPercentHRMax(arg1:Number):void
        {
            _maximumPercentHRMax = arg1;
            return;
        }

        public function get isUpdate():Boolean
        {
            return _isUpdate;
        }

        public function get correctionChestWalk():Number
        {
            return _correctionChestWalk;
        }

        public function set correctionChestWalk(arg1:Number):void
        {
            _correctionChestWalk = arg1;
            return;
        }

        public function set isUpdate(arg1:Boolean):void
        {
            _isUpdate = arg1;
            return;
        }

        public function set maximumTemperature(arg1:Number):void
        {
            _maximumTemperature = arg1;
            return;
        }

        public function get correctionFactor():Number
        {
            return _correctionFactor;
        }

        public function set correctionFactor(arg1:Number):void
        {
            _correctionFactor = arg1;
            return;
        }

        public function set minimumCadence(arg1:uint):void
        {
            _minimumCadence = arg1;
            return;
        }

        public function get maximumPower():uint
        {
            return _maximumPower;
        }

        public function get correctionHipRun():Number
        {
            return _correctionHipRun;
        }

        public function set correctionHipRun(arg1:Number):void
        {
            _correctionHipRun = arg1;
            return;
        }

        public function set maximumPower(arg1:uint):void
        {
            _maximumPower = arg1;
            return;
        }

        public function set minimumIncline(arg1:Number):void
        {
            _minimumIncline = arg1;
            return;
        }

        public function get correctionHipWalk():Number
        {
            return _correctionHipWalk;
        }

        public function set correctionHipWalk(arg1:Number):void
        {
            _correctionHipWalk = arg1;
            return;
        }

        public function get maximumAltitude():int
        {
            return _maximumAltitude;
        }

        public function get minimumPercentHRMax():Number
        {
            return _minimumPercentHRMax;
        }

        public function set minimumPercentHRMax(arg1:Number):void
        {
            _minimumPercentHRMax = arg1;
            return;
        }

        public function get minimumPower():uint
        {
            return _minimumPower;
        }

        public function set minimumPower(arg1:uint):void
        {
            _minimumPower = arg1;
            return;
        }

        public function get minimumRiseRate():Number
        {
            return _minimumRiseRate;
        }

        public function set minimumRiseRate(arg1:Number):void
        {
            _minimumRiseRate = arg1;
            return;
        }

        public function get minimumRiseRateDownhill():Number
        {
            return _minimumRiseRateDownhill;
        }

        public function set minimumRiseRateDownhill(arg1:Number):void
        {
            _minimumRiseRateDownhill = arg1;
            return;
        }

        public function get minimumRiseRateUphill():Number
        {
            return _minimumRiseRateUphill;
        }

        public function set minimumRiseRateUphill(arg1:Number):void
        {
            _minimumRiseRateUphill = arg1;
            return;
        }

        public function get minimumSpeed():Number
        {
            return _minimumSpeed;
        }

        public function set minimumSpeed(arg1:Number):void
        {
            _minimumSpeed = arg1;
            return;
        }

        public function get minimumTemperature():Number
        {
            return this._minimumTemperature;
        }

        public function set minimumTemperature(arg1:Number):void
        {
            this._minimumTemperature = arg1;
            return;
        }

        public function get modificationDate():Number
        {
            return _modificationDate;
        }

        public function set modificationDate(arg1:Number):void
        {
            _modificationDate = arg1;
            return;
        }

        public function get motionPoints():Number
        {
            return _motionPoints;
        }

        public function set motionPoints(arg1:Number):void
        {
            _motionPoints = arg1;
            return;
        }

        public function get name():String
        {
            return _name;
        }

        public function set name(arg1:String):void
        {
            if (arg1 == null) 
            {
                arg1 = "";
            }
            _name = arg1;
            return;
        }

        public function get pageHeaderData():Array
        {
            return _pageHeaderData;
        }

        public function set pageHeaderData(arg1:Array):void
        {
            _pageHeaderData = arg1;
            return;
        }

        public function get participant():__AS3__.vec.Vector.<core.participant.Person>
        {
            return _participant;
        }

        public function set participant(arg1:__AS3__.vec.Vector.<core.participant.Person>):void
        {
            if (_participant != arg1) 
            {
                _participant = arg1;
                dispatchEvent(new flash.events.Event("participantChange"));
            }
            return;
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

        public function get percentTimeInIntensityZone1():Number
        {
            return _percentTimeInIntensityZone1;
        }

        public function set percentTimeInIntensityZone1(arg1:Number):void
        {
            _percentTimeInIntensityZone1 = arg1;
            return;
        }

        public function get percentTimeInIntensityZone2():Number
        {
            return _percentTimeInIntensityZone2;
        }

        public function set percentTimeInIntensityZone2(arg1:Number):void
        {
            _percentTimeInIntensityZone2 = arg1;
            return;
        }

        public function get percentTimeInIntensityZone3():Number
        {
            return _percentTimeInIntensityZone3;
        }

        public function set percentTimeInIntensityZone3(arg1:Number):void
        {
            _percentTimeInIntensityZone3 = arg1;
            return;
        }

        public function get percentTimeInIntensityZone4():Number
        {
            return _percentTimeInIntensityZone4;
        }

        public function set percentTimeInIntensityZone4(arg1:Number):void
        {
            _percentTimeInIntensityZone4 = arg1;
            return;
        }

        public function get phaseCount():uint
        {
            return _phaseCount;
        }

        public function set phaseCount(arg1:uint):void
        {
            _phaseCount = arg1;
            return;
        }

        public function get powerZone1Start():uint
        {
            return _powerZone1Start;
        }

        public function set powerZone1Start(arg1:uint):void
        {
            _powerZone1Start = arg1;
            return;
        }

        public function get powerZone2Start():uint
        {
            return _powerZone2Start;
        }

        public function set powerZone2Start(arg1:uint):void
        {
            _powerZone2Start = arg1;
            return;
        }

        public function get powerZone3Start():uint
        {
            return _powerZone3Start;
        }

        public function set powerZone3Start(arg1:uint):void
        {
            _powerZone3Start = arg1;
            return;
        }

        public function get powerZone4Start():uint
        {
            return _powerZone4Start;
        }

        public function set powerZone4Start(arg1:uint):void
        {
            _powerZone4Start = arg1;
            return;
        }

        public function get powerZone5Start():uint
        {
            return _powerZone5Start;
        }

        public function set powerZone5Start(arg1:uint):void
        {
            _powerZone5Start = arg1;
            return;
        }

        public function get powerZone6Start():uint
        {
            return _powerZone6Start;
        }

        public function set powerZone6Start(arg1:uint):void
        {
            _powerZone6Start = arg1;
            return;
        }

        public function get powerZone7End():uint
        {
            return _powerZone7End;
        }

        public function set powerZone7End(arg1:uint):void
        {
            _powerZone7End = arg1;
            return;
        }

        public function get powerZone7Start():uint
        {
            return _powerZone7Start;
        }

        public function set powerZone7Start(arg1:uint):void
        {
            _powerZone7Start = arg1;
            return;
        }

        public function get programStartAddress():uint
        {
            return _programStartAddress;
        }

        public function set programStartAddress(arg1:uint):void
        {
            _programStartAddress = arg1;
            return;
        }

        public function get programStopAddress():uint
        {
            return _programStopAddress;
        }

        public function set programStopAddress(arg1:uint):void
        {
            _programStopAddress = arg1;
            return;
        }

        public function get rating():uint
        {
            return _rating;
        }

        public function set rating(arg1:uint):void
        {
            _rating = arg1;
            return;
        }

        public function get rxBatteryStatus():String
        {
            return _rxBatteryStatus;
        }

        public function set rxBatteryStatus(arg1:String):void
        {
            _rxBatteryStatus = arg1;
            return;
        }

        public function get samplingRate():Number
        {
            return _samplingRate;
        }

        public function set samplingRate(arg1:Number):void
        {
            _samplingRate = arg1;
            return;
        }

        public function get selectedEndEntry():core.activities.ActivityEntry
        {
            return _selectedEndEntry;
        }

        public function set selectedEndEntry(arg1:core.activities.ActivityEntry):void
        {
            if (arg1 != _selectedEndEntry) 
            {
                _selectedEndEntry = arg1;
                dispatchEvent(new flash.events.Event("selectedEndEntryChange"));
            }
            return;
        }

        public function get selectedMiddleEntry():core.activities.ActivityEntry
        {
            return _selectedMiddleEntry;
        }

        public function set selectedMiddleEntry(arg1:core.activities.ActivityEntry):void
        {
            if (arg1 != _selectedMiddleEntry) 
            {
                _selectedMiddleEntry = arg1;
                dispatchEvent(new flash.events.Event("selectedMiddleEntryChange"));
            }
            return;
        }

        public function get selectedStartEntry():core.activities.ActivityEntry
        {
            return _selectedStartEntry;
        }

        public function set selectedStartEntry(arg1:core.activities.ActivityEntry):void
        {
            if (arg1 != _selectedStartEntry) 
            {
                _selectedStartEntry = arg1;
                dispatchEvent(new flash.events.Event("selectedStartEntryChange"));
            }
            return;
        }

        public function get serialNumber():String
        {
            return _serialNumber;
        }

        public function set serialNumber(arg1:String):void
        {
            if (arg1 != _serialNumber) 
            {
                _serialNumber = arg1;
                dispatchEvent(new flash.events.Event("_serialNumber"));
            }
            return;
        }

        public function get shared():Boolean
        {
            return this.shared;
        }

        public function set shared(arg1:Boolean):void
        {
            var loc1:*=this.shared;
            if (loc1 !== arg1) 
            {
                this.shared = arg1;
                if (this.hasEventListener("propertyChange")) 
                {
                    this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "shared", loc1, arg1));
                }
            }
            return;
        }

        public function get sharedTo2Peak():Boolean
        {
            return this.sharedTo2Peak;
        }

        public function set sharedTo2Peak(arg1:Boolean):void
        {
            var loc1:*=this.sharedTo2Peak;
            if (loc1 !== arg1) 
            {
                this.sharedTo2Peak = arg1;
                if (this.hasEventListener("propertyChange")) 
                {
                    this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "sharedTo2Peak", loc1, arg1));
                }
            }
            return;
        }

        public function get sharedToFacebook():Boolean
        {
            return this.sharedToFacebook;
        }

        public function set sharedToFacebook(arg1:Boolean):void
        {
            var loc1:*=this.sharedToFacebook;
            if (loc1 !== arg1) 
            {
                this.sharedToFacebook = arg1;
                if (this.hasEventListener("propertyChange")) 
                {
                    this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "sharedToFacebook", loc1, arg1));
                }
            }
            return;
        }

        public function get sharedToStrava():Boolean
        {
            return this.sharedToStrava;
        }

        public function set sharedToStrava(arg1:Boolean):void
        {
            var loc1:*=this.sharedToStrava;
            if (loc1 !== arg1) 
            {
                this.sharedToStrava = arg1;
                if (this.hasEventListener("propertyChange")) 
                {
                    this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "sharedToStrava", loc1, arg1));
                }
            }
            return;
        }

        public function get sharedToTrainingPeaks():Boolean
        {
            return this.sharedToTrainingPeaks;
        }

        public function set sharedToTrainingPeaks(arg1:Boolean):void
        {
            var loc1:*=this.sharedToTrainingPeaks;
            if (loc1 !== arg1) 
            {
                this.sharedToTrainingPeaks = arg1;
                if (this.hasEventListener("propertyChange")) 
                {
                    this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "sharedToTrainingPeaks", loc1, arg1));
                }
            }
            return;
        }

        public function get sharedToTwitter():Boolean
        {
            return this.sharedToTwitter;
        }

        public function set sharedToTwitter(arg1:Boolean):void
        {
            var loc1:*=this.sharedToTwitter;
            if (loc1 !== arg1) 
            {
                this.sharedToTwitter = arg1;
                if (this.hasEventListener("propertyChange")) 
                {
                    this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "sharedToTwitter", loc1, arg1));
                }
            }
            return;
        }

        public function get shoulderWidth():Number
        {
            return _shoulderWidth;
        }

        public function set shoulderWidth(arg1:Number):void
        {
            _shoulderWidth = arg1;
            return;
        }

        public function get shoulderWidthUnit():String
        {
            return _shoulderWidthUnit;
        }

        public function set shoulderWidthUnit(arg1:String):void
        {
            _shoulderWidthUnit = arg1;
            return;
        }

        public function get speedUnit():String
        {
            return _speedUnit;
        }

        public function set speedUnit(arg1:String):void
        {
            _speedUnit = arg1;
            return;
        }

        public function get sport():core.sport.Sport
        {
            return _sport;
        }

        public function set sport(arg1:core.sport.Sport):void
        {
            _sport = arg1;
            if (_sport) 
            {
                _sportId = _sport.sportId;
            }
            return;
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

        public function get startAdress():uint
        {
            return _startAdress;
        }

        public function set startAdress(arg1:uint):void
        {
            if (arg1 != _startAdress) 
            {
                _startAdress = arg1;
                dispatchEvent(new flash.events.Event("startAdressChange"));
            }
            return;
        }

        public function get startDate():Date
        {
            return _startDate;
        }

        public function set startDate(arg1:Date):void
        {
            _startDate = arg1;
            if (dateFormatter) 
            {
                dateOutputString = dateFormatter.format(arg1);
            }
            if (clockFormatter) 
            {
                clockOutputString = clockFormatter.format(arg1);
                if (clockOutputString.indexOf("AM") == -1) 
                {
                    if (clockOutputString.indexOf("PM") != -1) 
                    {
                        clockOutputString = clockOutputString.replace("PM", utils.LanguageManager.getString("UNIT_PM"));
                    }
                }
                else 
                {
                    clockOutputString = clockOutputString.replace("AM", utils.LanguageManager.getString("UNIT_AM"));
                }
            }
            return;
        }

        public function get statistic():Boolean
        {
            return _statistic;
        }

        public function set statistic(arg1:Boolean):void
        {
            _statistic = arg1;
            return;
        }

        public function get steps():Number
        {
            return _steps;
        }

        public function set steps(arg1:Number):void
        {
            _steps = arg1;
            return;
        }

        public function get stopAdress():uint
        {
            return _stopAdress;
        }

        public function set stopAdress(arg1:uint):void
        {
            if (arg1 != _stopAdress) 
            {
                _stopAdress = arg1;
                dispatchEvent(new flash.events.Event("stopAdressChange"));
            }
            return;
        }

        public function get targetDay():Number
        {
            return _targetDay;
        }

        public function set targetDay(arg1:Number):void
        {
            _targetDay = arg1;
            return;
        }

        public function get tempTraining():core.training.Training
        {
            return _tempTraining;
        }

        public function set tempTraining(arg1:core.training.Training):void
        {
            _tempTraining = arg1;
            return;
        }

        public function get thresholdPower():uint
        {
            return _thresholdPower;
        }

        public function set thresholdPower(arg1:uint):void
        {
            _thresholdPower = arg1;
            return;
        }

        public function get timeDeepSleep():Number
        {
            return _timeDeepSleep;
        }

        public function set timeDeepSleep(arg1:Number):void
        {
            _timeDeepSleep = arg1;
            return;
        }

        public function get timeInIntensityZone1():Number
        {
            return _timeInIntensityZone1;
        }

        public function set timeInIntensityZone1(arg1:Number):void
        {
            _timeInIntensityZone1 = arg1;
            return;
        }

        public function get timeInIntensityZone1Defined():Boolean
        {
            return this.timeInIntensityZone1Defined;
        }

        public function set timeInIntensityZone1Defined(arg1:Boolean):void
        {
            var loc1:*=this.timeInIntensityZone1Defined;
            if (loc1 !== arg1) 
            {
                this.timeInIntensityZone1Defined = arg1;
                if (this.hasEventListener("propertyChange")) 
                {
                    this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "timeInIntensityZone1Defined", loc1, arg1));
                }
            }
            return;
        }

        public function get timeInIntensityZone2():Number
        {
            return _timeInIntensityZone2;
        }

        public function set timeInIntensityZone2(arg1:Number):void
        {
            _timeInIntensityZone2 = arg1;
            return;
        }

        public function get timeInIntensityZone3():Number
        {
            return _timeInIntensityZone3;
        }

        public function set timeInIntensityZone3(arg1:Number):void
        {
            _timeInIntensityZone3 = arg1;
            return;
        }

        public function get timeInIntensityZone4():Number
        {
            return _timeInIntensityZone4;
        }

        public function set timeInIntensityZone4(arg1:Number):void
        {
            _timeInIntensityZone4 = arg1;
            return;
        }

        public function get timeInPowerZone1():Number
        {
            return _timeInPowerZone1;
        }

        public function set timeInPowerZone1(arg1:Number):void
        {
            _timeInPowerZone1 = arg1;
            return;
        }

        public function get timeInPowerZone2():Number
        {
            return _timeInPowerZone2;
        }

        public function set timeInPowerZone2(arg1:Number):void
        {
            _timeInPowerZone2 = arg1;
            return;
        }

        public function get timeInPowerZone3():Number
        {
            return _timeInPowerZone3;
        }

        public function set timeInPowerZone3(arg1:Number):void
        {
            _timeInPowerZone3 = arg1;
            return;
        }

        public function get timeInPowerZone4():Number
        {
            return _timeInPowerZone4;
        }

        public function set timeInPowerZone4(arg1:Number):void
        {
            _timeInPowerZone4 = arg1;
            return;
        }

        public function get timeInPowerZone5():Number
        {
            return _timeInPowerZone5;
        }

        public function set timeInPowerZone5(arg1:Number):void
        {
            _timeInPowerZone5 = arg1;
            return;
        }

        public function get timeInPowerZone6():Number
        {
            return _timeInPowerZone6;
        }

        public function set timeInPowerZone6(arg1:Number):void
        {
            _timeInPowerZone6 = arg1;
            return;
        }

        public function get timeInPowerZone7():Number
        {
            return _timeInPowerZone7;
        }

        public function set timeInPowerZone7(arg1:Number):void
        {
            _timeInPowerZone7 = arg1;
            return;
        }

        public function get timeInZone():Number
        {
            return _timeInZone;
        }

        public function set timeInZone(arg1:Number):void
        {
            _timeInZone = arg1;
            return;
        }

        public function get timeInZone1():Number
        {
            return _timeInZone1;
        }

        public function set timeInZone1(arg1:Number):void
        {
            _timeInZone1 = arg1;
            return;
        }

        public function get timeInZone1Defined():Boolean
        {
            return this.timeInZone1Defined;
        }

        public function set timeInZone1Defined(arg1:Boolean):void
        {
            var loc1:*=this.timeInZone1Defined;
            if (loc1 !== arg1) 
            {
                this.timeInZone1Defined = arg1;
                if (this.hasEventListener("propertyChange")) 
                {
                    this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "timeInZone1Defined", loc1, arg1));
                }
            }
            return;
        }

        public function get timeInZone2():Number
        {
            return _timeInZone2;
        }

        public function set timeInZone2(arg1:Number):void
        {
            _timeInZone2 = arg1;
            return;
        }

        public function get timeInZone3():Number
        {
            return _timeInZone3;
        }

        public function set timeInZone3(arg1:Number):void
        {
            _timeInZone3 = arg1;
            return;
        }

        public function get timeLightSleep():Number
        {
            return _timeLightSleep;
        }

        public function set timeLightSleep(arg1:Number):void
        {
            _timeLightSleep = arg1;
            return;
        }

        public function get timeOutOfZone():Number
        {
            return _timeOutOfZone;
        }

        public function set timeOutOfZone(arg1:Number):void
        {
            if (arg1 != _timeOutOfZone) 
            {
                _timeOutOfZone = arg1;
                dispatchEvent(new flash.events.Event("timeOutOfZoneChange"));
            }
            return;
        }

        public function get timeOverIntensityZone():Number
        {
            return _timeOverIntensityZone;
        }

        public function set timeOverIntensityZone(arg1:Number):void
        {
            _timeOverIntensityZone = arg1;
            return;
        }

        public function get timeOverZone():Number
        {
            return _timeOverZone;
        }

        public function set timeOverZone(arg1:Number):void
        {
            _timeOverZone = arg1;
            return;
        }

        public function get timeSleep():Number
        {
            return _timeSleep;
        }

        public function set timeSleep(arg1:Number):void
        {
            _timeSleep = arg1;
            if (timeFormatterHHMM) 
            {
                timeSleepOutputString = timeFormatterHHMM.format(_timeSleep);
            }
            return;
        }

        public function get timeUnderIntensityZone():Number
        {
            return _timeUnderIntensityZone;
        }

        public function set timeUnderIntensityZone(arg1:Number):void
        {
            _timeUnderIntensityZone = arg1;
            return;
        }

        public function get timeUnderZone():Number
        {
            return _timeUnderZone;
        }

        public function set timeUnderZone(arg1:Number):void
        {
            _timeUnderZone = arg1;
            return;
        }

        public function get timeWakeUp():Number
        {
            return _timeWakeUp;
        }

        public function set timeWakeUp(arg1:Number):void
        {
            _timeWakeUp = arg1;
            return;
        }

        public function get trackProfile():uint
        {
            return _trackProfile;
        }

        public function set trackProfile(arg1:uint):void
        {
            _trackProfile = arg1;
            return;
        }

        public function get trainingCategory():core.general.TrainingCategory
        {
            return _trainingCategory;
        }

        public function set trainingCategory(arg1:core.general.TrainingCategory):void
        {
            _trainingCategory = arg1;
            return;
        }

        public function get trainingTime():Number
        {
            return _trainingTime;
        }

        public function set trainingTime(arg1:Number):void
        {
            _trainingTime = arg1;
            if (timeFormatter) 
            {
                trainingTimeOutputString = timeFormatter.format(arg1);
            }
            return;
        }

        public function get trainingTimeDownhill():Number
        {
            return _trainingTimeDownhill;
        }

        public function set trainingTimeDownhill(arg1:Number):void
        {
            _trainingTimeDownhill = arg1;
            return;
        }

        public function get trainingTimePrecision():int
        {
            return _trainingTimePrecision;
        }

        public function set trainingTimePrecision(arg1:int):void
        {
            _trainingTimePrecision = arg1;
            return;
        }

        public function get trainingTimeUphill():Number
        {
            return _trainingTimeUphill;
        }

        public function set trainingTimeUphill(arg1:Number):void
        {
            _trainingTimeUphill = arg1;
            return;
        }

        public function get trainingType():String
        {
            return _trainingType;
        }

        public function set trainingType(arg1:String):void
        {
            _trainingType = arg1;
            return;
        }

        public function get trainingTypeDefined():Boolean
        {
            return this.trainingTypeDefined;
        }

        public function set trainingTypeDefined(arg1:Boolean):void
        {
            var loc1:*=this.trainingTypeDefined;
            if (loc1 !== arg1) 
            {
                this.trainingTypeDefined = arg1;
                if (this.hasEventListener("propertyChange")) 
                {
                    this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "trainingTypeDefined", loc1, arg1));
                }
            }
            return;
        }

        public function get trainingZone():String
        {
            return _trainingZone;
        }

        public function set trainingZone(arg1:String):void
        {
            _trainingZone = arg1;
            return;
        }

        public function get trainingZoneDefined():Boolean
        {
            return this.trainingZoneDefined;
        }

        public function set trainingZoneDefined(arg1:Boolean):void
        {
            var loc1:*=this.trainingZoneDefined;
            if (loc1 !== arg1) 
            {
                this.trainingZoneDefined = arg1;
                if (this.hasEventListener("propertyChange")) 
                {
                    this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "trainingZoneDefined", loc1, arg1));
                }
            }
            return;
        }

        public function get tripSectionDistance():Number
        {
            return _tripSectionDistance;
        }

        public function set tripSectionDistance(arg1:Number):void
        {
            _tripSectionDistance = arg1;
            return;
        }

        public function get tripSectionTime():Number
        {
            return _tripSectionTime;
        }

        public function set tripSectionTime(arg1:Number):void
        {
            _tripSectionTime = arg1;
            return;
        }

        public function get txBatteryStatus():String
        {
            return _txBatteryStatus;
        }

        public function set txBatteryStatus(arg1:String):void
        {
            _txBatteryStatus = arg1;
            return;
        }

        public function get unit():core.units.Unit
        {
            return _unit;
        }

        public function set unit(arg1:core.units.Unit):void
        {
            if (arg1 != _unit) 
            {
                _unit = arg1;
                dispatchEvent(new flash.events.Event("unitChange"));
            }
            return;
        }

        public function get unitId():uint
        {
            return _unitId;
        }

        public function set unitId(arg1:uint):void
        {
            _unitId = arg1;
            return;
        }

        public function get unitType():core.general.UnitType
        {
            return _unitType;
        }

        public function set unitType(arg1:core.general.UnitType):void
        {
            if (arg1 != _unitType) 
            {
                _unitType = arg1;
                dispatchEvent(new flash.events.Event("unitTypeChange"));
            }
            return;
        }

        public function get upperLimit():uint
        {
            return _upperLimit;
        }

        public function set upperLimit(arg1:uint):void
        {
            _upperLimit = arg1;
            return;
        }

        public function get userId():uint
        {
            return _userId;
        }

        public function set userId(arg1:uint):void
        {
            _userId = arg1;
            return;
        }

        public function get weather():uint
        {
            return _weather;
        }

        public function set weather(arg1:uint):void
        {
            _weather = arg1;
            return;
        }

        public function get weightUnit():String
        {
            return _weightUnit;
        }

        public function set weightUnit(arg1:String):void
        {
            _weightUnit = arg1;
            return;
        }

        public function get wheelSize():uint
        {
            return _wheelSize;
        }

        public function set wheelSize(arg1:uint):void
        {
            _wheelSize = arg1;
            return;
        }

        public function get wind():uint
        {
            return _wind;
        }

        public function set wind(arg1:uint):void
        {
            _wind = arg1;
            return;
        }

        public function get withDevice():String
        {
            return _withDevice;
        }

        public function set withDevice(arg1:String):void
        {
            _withDevice = arg1;
            return;
        }

        public function get workInKJ():Number
        {
            return _workInKJ;
        }

        public function set workInKJ(arg1:Number):void
        {
            _workInKJ = arg1;
            return;
        }

        public function get zone1Start():uint
        {
            return _zone1Start;
        }

        public function set zone1Start(arg1:uint):void
        {
            _zone1Start = arg1;
            return;
        }

        public function get zone2Start():uint
        {
            return _zone2Start;
        }

        public function set zone2Start(arg1:uint):void
        {
            _zone2Start = arg1;
            return;
        }

        public function get zone3End():uint
        {
            return _zone3End;
        }

        public function set zone3End(arg1:uint):void
        {
            _zone3End = arg1;
            return;
        }

        public function get zone3Start():uint
        {
            return _zone3Start;
        }

        public function set zone3Start(arg1:uint):void
        {
            _zone3Start = arg1;
            return;
        }

        public function getLoggingInfo():String
        {
            return "\t-logId " + activityId.toString() + "\t-unitId " + unitId.toString();
        }

        public function ghostRaceDefined():Boolean
        {
            return core.general.UnitType.ROX91 == unitType;
        }

        public function setPrimaryKey(arg1:uint):void
        {
            if (activityId == 0) 
            {
                _activityId = arg1;
            }
            return;
        }

        public override function toString():String
        {
            return "Activity [Name:\'" + (name ? name : "<unknown>") + "\'] [Type:\'" + (logType ? logType.toString() : "<unknown>") + "\'] [TrainingTime:\'" + trainingTime * 100 + " s\'] [Distance:\'" + distance + " m\']";
        }

        internal function onSoftwareSettingsChanged(arg1:flash.events.Event):void
        {
            if (!resetFormatterAndConverterCompleted) 
            {
                resetFormatterAndConverter();
                resetFormatterAndConverterCompleted = true;
                flash.utils.setTimeout(resetResetFlag, 1000);
            }
            if (activeTimeHighOutputString != "--") 
            {
                activeTimeHighOutputString = timeFormatterHHMM.format(_activeTimeHigh);
            }
            if (activeTimeLowOutputString != "--") 
            {
                activeTimeLowOutputString = timeFormatterHHMM.format(activeTimeLow);
            }
            if (activeTimeMiddleOutputString != "--") 
            {
                activeTimeMiddleOutputString = timeFormatterHHMM.format(activeTimeMiddle);
            }
            if (altitudeDifferencesUphillOutputString != "0") 
            {
                altitudeDifferencesUphillOutputString = altitudeFormatter.format(altitudeConverter.convert(_altitudeDifferencesUphill));
            }
            if (altitudeDifferencesUphillOutputString != "0") 
            {
                averageHeartrateOutputString = heartrateFormatter.format(_averageHeartrate);
            }
            if (averagePowerOutputString != "0") 
            {
                averagePowerOutputString = powerFormatter.format(_averagePower);
            }
            if (averageSpeedOutputString != "0") 
            {
                averageSpeedOutputString = speedFormatter.format(speedConverter.convert(_averageSpeed));
            }
            if (averageSpeedTimeOutputString != "0") 
            {
                averageSpeedTimeOutputString = speedTimeFormatter.format(utils.Calculations.calculateSpeedTime(_averageSpeed));
            }
            if (caloriesOutputString != "0") 
            {
                caloriesOutputString = caloriesFormatter.format(_calories);
            }
            if (distanceOutputString != "0") 
            {
                distanceOutputString = distanceFormatter.format(distanceConverter.convert(_distance));
            }
            if (dateOutputString != "0") 
            {
                dateOutputString = dateFormatter.format(_startDate);
                clockOutputString = clockFormatter.format(_startDate);
                if (clockOutputString.indexOf("AM") == -1) 
                {
                    if (clockOutputString.indexOf("PM") != -1) 
                    {
                        clockOutputString = clockOutputString.replace("PM", utils.LanguageManager.getString("UNIT_PM"));
                    }
                }
                else 
                {
                    clockOutputString = clockOutputString.replace("AM", utils.LanguageManager.getString("UNIT_AM"));
                }
            }
            if (trainingTimeOutputString != "--") 
            {
                trainingTimeOutputString = timeFormatter.format(_trainingTime);
            }
            if (timeSleepOutputString != "--") 
            {
                timeSleepOutputString = timeFormatterHHMM.format(_timeSleep);
            }
            return;
        }

        internal function resetFormatterAndConverter():void
        {
            if (!flash.system.Worker.current.isPrimordial) 
            {
                return;
            }
            try 
            {
                altitudeConverter = new utils.converter.AltitudeConverter("millimeter", core.MeasurementConfig.altitudeFormat);
                altitudeFormatter = init.BackendInitializer.getInstance().createAltitudeFormatter();
                caloriesFormatter = init.BackendInitializer.getInstance().createCaloriesFormatter();
                clockFormatter = init.BackendInitializer.getInstance().createDateTimeFormatter();
                clockFormatter.dateStyle = "none";
                clockFormatter.timeStyle = "short";
                clockFormatter.setStyle("locale", core.MeasurementConfig.clockFormat != "24" ? "en_US" : "de_DE");
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
                speedTimeFormatter = init.BackendInitializer.getInstance().createSpeedTimeFormatter();
                speedTimeFormatter.inputType = "seconds";
                speedTimeFormatter.formatString = "MM:SS";
                timeFormatter = init.BackendInitializer.getInstance().createTimeFormatter();
                timeFormatterHHMM = init.BackendInitializer.getInstance().createTimeFormatterHHMM();
                timeFormatterHHMM.inputType = "hundredthsSecond";
                timeFormatterHHMM.formatString = "HH:MM";
            }
            catch (e:Error)
            {
                debug.Debug.error("formatterAndConverter error: " + e.message);
            }
            initFormatter = false;
            return;
        }

        internal function resetResetFlag():void
        {
            resetFormatterAndConverterCompleted = false;
            return;
        }

        public static function copy(arg1:core.activities.Activity, arg2:Boolean=false):core.activities.Activity
        {
            var loc15:*=0;
            var loc11:*=arg1.unit;
            var loc5:*=arg1.recalculatedValues;
            var loc10:*=arg1.entries as __AS3__.vec.Vector.<core.activities.ActivityEntry>;
            var loc12:*=arg1.markerList as __AS3__.vec.Vector.<core.marker.Marker>;
            var loc3:*=arg1.sport as core.sport.Sport;
            var loc14:*=arg1.trainingCategory;
            var loc1:*=arg1.logType;
            var loc2:*=arg1.unitType;
            arg1.unit = null;
            arg1.recalculatedValues = null;
            arg1.entries = null;
            arg1.markerList = null;
            arg1.logType = null;
            allowActivityCopy = true;
            var loc9:*=flash.utils.getQualifiedClassName(arg1);
            flash.net.registerClassAlias(loc9, flash.utils.getDefinitionByName(loc9) as Class);
            var loc8:*=utils.BackendUtil.copy(arg1) as Activity;
            allowActivityCopy = false;
            var loc6:*=loc10.length;
            var loc13:*=loc12.length;
            var loc7:*=new __AS3__.vec.Vector.<core.activities.ActivityEntry>();
            var loc4:*=new __AS3__.vec.Vector.<core.marker.Marker>();
            loc15 = 0;
            while (loc15 < loc6) 
            {
                loc7.push(core.activities.ActivityEntry.copy(loc10[loc15], loc8));
                ++loc15;
            }
            loc15 = 0;
            while (loc15 < loc13) 
            {
                loc4.push(core.marker.Marker.copy(loc12[loc15], loc8));
                ++loc15;
            }
            loc8.entries = loc7 as __AS3__.vec.Vector.<core.activities.ActivityEntry>;
            loc8.markerList = loc4 as __AS3__.vec.Vector.<core.marker.Marker>;
            loc8.unit = loc11;
            loc8.sport = loc3;
            loc8.trainingCategory = loc14;
            loc8.recalculatedValues = loc5;
            loc8.logType = loc1;
            loc8.unitType = loc2;
            loc8.activityId = 0;
            loc8.selected = false;
            if (loc11 && loc11.deviceGUID) 
            {
                if (!arg2) 
                {
                    loc8.GUID = "";
                }
            }
            else 
            {
                loc8.GUID = "";
            }
            arg1.unit = loc11;
            arg1.recalculatedValues = loc5;
            arg1.entries = loc10 as __AS3__.vec.Vector.<core.activities.ActivityEntry>;
            arg1.markerList = loc12 as __AS3__.vec.Vector.<core.marker.Marker>;
            arg1.logType = loc1;
            return loc8;
        }

        protected static const DEFAULT_OUTPUT_STRING:String="0";

        protected static const DEFAULT_ACTIVITO_TIME_OUTPUT_STRING:String="--";

        public var maximumInclineDownhillDefined:Boolean=false;

        internal var _maximumInclineUphill:Number=0;

        public var maximumInclineUphillDefined:Boolean=false;

        internal var _maximumPercentHRMax:Number=0;

        public var maximumPercentHRMaxDefined:Boolean=false;

        internal var _maximumPower:uint=0;

        public var maximumPowerDefined:Boolean=false;

        internal var _maximumRiseRate:Number=0;

        public var maximumRiseRateDefined:Boolean=false;

        internal var _maximumRiseRateDownhill:Number=0;

        public var maximumRiseRateDownhillDefined:Boolean=false;

        internal var _maximumRiseRateUphill:Number=0;

        public var maximumRiseRateUphillDefined:Boolean=false;

        internal var _maximumSpeed:Number=0;

        public var maximumSpeedDefined:Boolean=false;

        internal var _maximumTemperature:Number=0;

        public var maximumTemperatureDefined:Boolean=false;

        public var minHeartrateEntry:int=-1;

        public var minRiseRateDownhillEntry:int=-1;

        public var minRiseRateEntry:int=-1;

        public var minRiseRateUphillEntry:int=-1;

        internal var _minimumAltitude:int;

        public var minimumAltitudeDefined:Boolean=false;

        internal var _minimumCadence:uint;

        public var minimumCadenceDefined:Boolean=false;

        internal var _minimumHeartrate:uint=0;

        public var minimumHeartrateDefined:Boolean=false;

        internal var _minimumIncline:Number=0;

        public var minimumInclineDefined:Boolean=false;

        internal var _minimumInclineDownhill:Number=0;

        public var minimumInclineDownhillDefined:Boolean=false;

        internal var _minimumInclineUphill:Number=0;

        internal var _averageSpeedDownhill:Number=0;

        public var minimumInclineUphillDefined:Boolean=false;

        internal var _minimumPercentHRMax:Number=0;

        internal var _GUID:String="";

        internal var _activeTimeHigh:Number=0;

        public var minimumPercentHRMaxDefined:Boolean=false;

        internal var _minimumPower:uint;

        public var activeTimeHighDefined:Boolean=false;

        public var activeTimeHighOutputString:String="--";

        public var minimumPowerDefined:Boolean=false;

        internal var _minimumRiseRate:Number=0;

        internal var _activeTimeLow:Number=0;

        public var activeTimeLowDefined:Boolean=false;

        public var minimumRiseRateDefined:Boolean=false;

        internal var _minimumRiseRateDownhill:Number=0;

        public var activeTimeLowOutputString:String="--";

        internal var _activeTimeMiddle:Number=0;

        public var minimumRiseRateDownhillDefined:Boolean=false;

        internal var _minimumRiseRateUphill:Number=0;

        public var activeTimeMiddleDefined:Boolean=false;

        public var activeTimeMiddleOutputString:String="--";

        public var minimumRiseRateUphillDefined:Boolean=false;

        internal var _minimumSpeed:Number=0;

        internal var _activityId:uint=0;

        public var activityStatus:String="none";

        public var minimumSpeedDefined:Boolean=false;

        internal var _minimumTemperature:Number=0;

        internal var _age:uint=0;

        public var ageDefined:Boolean=false;

        public var minimumTemperatureDefined:Boolean=false;

        internal var _modificationDate:Number=0;

        internal var _alreadySaved:Boolean=false;

        internal var _altitudeDifferencesDownhill:uint=0;

        internal var _motionPoints:Number=0;

        public var altitudeDifferencesDownhillDefined:Boolean=false;

        internal var _altitudeDifferencesUphill:uint=0;

        public var motionPointsDefined:Boolean=false;

        internal var _name:String="";

        public var altitudeDifferencesUphillDefined:Boolean=false;

        public var altitudeDifferencesUphillOutputString:String="0";

        internal var _pageHeaderData:Array;

        public var autoLapValuesIndex:int=0;

        public var autoLapValuesLoaded:Array;

        public var pageHeaderDataDefined:Boolean=false;

        internal var _participant:__AS3__.vec.Vector.<core.participant.Person>;

        public var autoLapValuesToLoad:int=0;

        public var autoLapsDefined:Boolean=false;

        public var pauseCount:int=0;

        internal var _pauseTime:Number=0;

        internal var _averageAltitude:int=0;

        public var averageAltitudeDefined:Boolean=false;

        public var pauseTimeDefined:Boolean=false;

        public var pedalSmoothLeft:Number=0;

        public var pedalSmoothLeftDefined:Boolean=false;

        public var pedalSmoothRight:Number=0;

        public var pedalSmoothRightDefined:Boolean=false;

        public var pedalingIndex:Number=0;

        public var pedalingIndexDefined:Boolean=false;

        public var pedalingTime:Number=0;

        public var pedalingTimeDefined:Boolean=false;

        public var percentDeepSleep:Number=0;

        public var percentDeepSleepDefined:Boolean=false;

        public var percentLightSleep:Number=0;

        public var percentLightSleepDefined:Boolean=false;

        internal var _percentTimeInIntensityZone1:Number=0;

        public var averageBalanceLeft:Number=0;

        public var averageBalanceLeftDefined:Boolean=false;

        public var percentTimeInIntensityZone1Defined:Boolean=false;

        internal var _percentTimeInIntensityZone2:Number=0;

        public var averageBalanceRight:Number=0;

        public var averageBalanceRightDefined:Boolean=false;

        public var percentTimeInIntensityZone2Defined:Boolean=false;

        internal var _percentTimeInIntensityZone3:Number=0;

        internal var _averageCadence:Number=0;

        public var averageCadenceCalc:int=0;

        public var percentTimeInIntensityZone3Defined:Boolean=false;

        internal var _percentTimeInIntensityZone4:Number=0;

        public var averageCadenceCalcDefined:Boolean=false;

        public var averageCadenceDefined:Boolean=false;

        public var percentTimeInIntensityZone4Defined:Boolean=false;

        public var percentWakeUp:Number=0;

        public var percentWakeUpDefined:Boolean=false;

        internal var _phaseCount:uint=0;

        internal var _averageExpansion:Number=0;

        public var averageExpansionDefined:Boolean=false;

        public var phaseDefined:Boolean=false;

        public var phaseValuesLoaded:Array;

        public var phaseValuesToLoad:int;

        public var powerFTP:Number=0;

        public var powerFTPDefined:Boolean=false;

        public var powerIF:Number=0;

        public var powerIFDefined:Boolean=false;

        public var powerNP:Number=0;

        public var powerNPDefined:Boolean=false;

        public var powerTSS:Number=0;

        public var powerTSSDefined:Boolean=false;

        internal var _powerZone1Start:uint=0;

        internal var _averageExpansionDownhill:Number=0;

        public var averageExpansionDownhillDefined:Boolean=false;

        public var powerZone1StartDefined:Boolean=false;

        internal var _powerZone2Start:uint=0;

        internal var _averageExpansionUphill:Number=0;

        public var averageExpansionUphillDefined:Boolean=false;

        public var powerZone2StartDefined:Boolean=false;

        internal var _powerZone3Start:uint=0;

        internal var _averageHeartrate:uint=0;

        public var averageHeartrateDefined:Boolean=false;

        public var powerZone3StartDefined:Boolean=false;

        internal var _powerZone4Start:uint=0;

        public var averageHeartrateOutputString:String="0";

        internal var _averageInclineDownhill:Number=0;

        public var powerZone4StartDefined:Boolean=false;

        internal var _powerZone5Start:uint=0;

        public var averageInclineDownhillDefined:Boolean=false;

        internal var _averageInclineUphill:Number=0;

        public var powerZone5StartDefined:Boolean=false;

        internal var _powerZone6Start:uint=0;

        public var averageInclineUphillDefined:Boolean=false;

        internal var _averagePercentHRMax:Number=0;

        public var powerZone6StartDefined:Boolean=false;

        internal var _powerZone7End:uint=0;

        public var averagePercentHRMaxDefined:Boolean=false;

        internal var _averagePower:Number=0;

        public var powerZone7EndDefined:Boolean=false;

        internal var _powerZone7Start:uint=0;

        public var averagePowerCalc:int=0;

        public var averagePowerCalcDefined:Boolean=false;

        public var powerZone7StartDefined:Boolean=false;

        internal var _programStartAddress:uint=0;

        internal var averagePowerDefined:Boolean;

        internal var _averagePowerKJ:Number=0;

        internal var _programStopAddress:uint=0;

        public var averagePowerKJDefined:Boolean=false;

        public var averagePowerOutputString:String="0";

        internal var _rating:uint=1;

        internal var _averagePowerWattPerKG:Number=0;

        public var averagePowerWattPerKGDefined:Boolean=false;

        public var ratingDefined:Boolean=false;

        public var recalculatedValues:core.activities.ActivityRecalculationValues;

        public var recordValuesLoaded:Array;

        public var recordValuesToLoad:int=0;

        internal var _rxBatteryStatus:String="";

        internal var _averageRiseRate:Number=0;

        public var averageRiseRateDefined:Boolean=false;

        public var rxBatteryStatusDefined:Boolean=false;

        internal var _samplingRate:Number=0;

        internal var _averageRiseRateDownhill:Number=0;

        public var averageRiseRateDownhillDefined:Boolean=false;

        public var samplingRateDefined:Boolean=false;

        public var selected:Boolean=false;

        protected var _selectedEndEntry:core.activities.ActivityEntry;

        internal var _averageRiseRateUphill:Number=0;

        public var averageRiseRateUphillDefined:Boolean=false;

        protected var _selectedMiddleEntry:core.activities.ActivityEntry;

        internal var _averageSpeed:Number=0;

        public var averageSpeedDefined:Boolean=false;

        internal var _selectedStartEntry:core.activities.ActivityEntry;

        public var averageSpeedDownhillDefined:Boolean=false;

        public var averageSpeedOutputString:String="0";

        internal var _serialNumber:String;

        public var averageSpeedTimeOutputString:String="0";

        internal var _averageSpeedUphill:Number=0;

        public var serialNumberDefined:Boolean=false;

        internal var shared:Boolean;

        public var averageSpeedUphillDefined:Boolean=false;

        internal var _averageTemperature:Number=0;

        internal var sharedTo2Peak:Boolean;

        public var averageTemperatureDefined:Boolean=false;

        internal var _best20minPower:Number=0;

        public var sharedTo2PeakId:String="0";

        internal var sharedToFacebook:Boolean;

        public var best20minPowerDefined:Boolean=false;

        internal var _best20minPowerEntry:int=-1;

        public var sharedToFacebookId:String="0";

        internal var sharedToStrava:Boolean;

        public var best20minPowerEntryDefined:Boolean=false;

        internal var _best5KEntry:int=0;

        public var sharedToStravaId:String="0";

        internal var sharedToTrainingPeaks:Boolean;

        public var best5KEntryDefined:Boolean=false;

        internal var _best5KTime:Number=0;

        public var sharedToTrainingPeaksId:String="0";

        internal var sharedToTwitter:Boolean;

        public var best5KTimeDefined:Boolean=false;

        internal var _bike:String="noBike";

        public var sharedToTwitterId:String="0";

        internal var _shoulderWidth:Number=-1;

        public var bikeHeightUnitDefined:Boolean=false;

        internal var _bikeType:String="";

        public var shoulderWidthDefined:Boolean=false;

        internal var _shoulderWidthUnit:String="";

        public var bikeTypeDefined:Boolean=false;

        internal var _bikeWeight:uint;

        public var shoulderWidthUnitDefined:Boolean=false;

        public var simpleHeaderValuesCalculation:Boolean=false;

        internal var _speedUnit:String="";

        public var bikeWeightDefined:Boolean=false;

        internal var _bikeWeightUnit:String="";

        public var speedUnitDefined:Boolean=false;

        internal var _sport:core.sport.Sport;

        public var bikeWeightUnitDefined:Boolean=false;

        internal var _bodyHeight:Number=-1;

        internal var _sportId:uint=0;

        public var bodyHeightDefined:Boolean=false;

        internal var _bodyHeightUnit:String="";

        internal var _startAdress:uint=0;

        public var bodyHeightUnitDefined:Boolean=false;

        internal var _bodyWeight:uint;

        internal var _startDate:Date;

        public var bodyWeightDefined:Boolean=false;

        public var bodyWeightUnitDefined:Boolean=false;

        public var startDateDefined:Boolean=false;

        public var startIndex:int=0;

        public var startPoint:int=0;

        internal var _statistic:Boolean=true;

        internal var _calibration:Boolean=false;

        public var calibrationDefined:Boolean=false;

        public var statisticDefined:Boolean=true;

        internal var _steps:Number=0;

        internal var _calories:Number=0;

        public var caloriesDefined:Boolean=false;

        public var stepsDefined:Boolean=false;

        internal var _stopAdress:uint=0;

        internal var _caloriesDifferenceFactor:Number=0;

        public var caloriesDifferenceFactorDefined:Boolean=false;

        internal var _targetDay:Number=0;

        public var caloriesOutputString:String="0";

        internal var _chestbeltManufacturer:String="";

        public var targetDayDefined:Boolean=false;

        internal var _tempTraining:core.training.Training;

        public var chestbeltManufacturerDefined:Boolean=false;

        public var clockOutputString:String="0";

        internal var _thresholdPower:uint=0;

        internal var _correctionChestRun:Number=0;

        public var correctionChestRunDefined:Boolean=false;

        public var thresholdPowerDefined:Boolean=false;

        internal var _timeDeepSleep:Number=0;

        internal var _correctionChestWalk:Number=0;

        public var correctionChestWalkDefined:Boolean=false;

        public var timeDeepSleepDefined:Boolean=false;

        internal var _timeInIntensityZone1:Number=0;

        internal var _correctionFactor:Number=0;

        public var correctionFactorDefined:Boolean=false;

        internal var timeInIntensityZone1Defined:Boolean;

        internal var _correctionHipRun:Number=0;

        public var correctionHipRunDefined:Boolean=false;

        internal var _timeInIntensityZone2:Number=0;

        internal var _correctionHipWalk:Number=0;

        public var correctionHipWalkDefined:Boolean=false;

        public var timeInIntensityZone2Defined:Boolean=false;

        internal var _timeInIntensityZone3:Number=0;

        internal var _dataType:String="memory";

        internal var _dateCode:String="";

        public var timeInIntensityZone3Defined:Boolean=false;

        internal var _timeInIntensityZone4:Number=0;

        public var dateCodeDefined:Boolean=false;

        public var dateOutputString:String="0";

        public var timeInIntensityZone4Defined:Boolean=false;

        internal var _timeInPowerZone1:Number=0;

        internal var _description:String="";

        public var descriptionDefined:Boolean=false;

        public var timeInPowerZone1Defined:Boolean=false;

        internal var _timeInPowerZone2:Number=0;

        internal var _distance:Number=0;

        public var distanceDefined:Boolean=false;

        public var timeInPowerZone2Defined:Boolean=false;

        internal var _timeInPowerZone3:Number=0;

        internal var _distanceDownhill:Number=0;

        public var distanceDownhillDefined:Boolean=false;

        public var timeInPowerZone3Defined:Boolean=false;

        internal var _timeInPowerZone4:Number=0;

        internal var _distanceMinus:Number=0;

        public var distanceMinusDefined:Boolean=false;

        public var timeInPowerZone4Defined:Boolean=false;

        internal var _timeInPowerZone5:Number=0;

        public var distanceOutputString:String="0";

        internal var _distancePlus:Number=0;

        public var timeInPowerZone5Defined:Boolean=false;

        internal var _timeInPowerZone6:Number=0;

        public var distancePlusDefined:Boolean=false;

        internal var _distancePlusMinusStatus:String="plus";

        public var timeInPowerZone6Defined:Boolean=false;

        internal var _timeInPowerZone7:Number=0;

        public var distancePlusMinusStatusDefined:Boolean=false;

        internal var _distanceUphill:Number=0;

        public var timeInPowerZone7Defined:Boolean=false;

        internal var _timeInZone:Number=0;

        public var distanceUphillDefined:Boolean=false;

        public var endIndex:int=0;

        internal var _timeInZone1:Number=0;

        public var endPoint:int=0;

        internal var _entries:__AS3__.vec.Vector.<core.activities.ActivityEntry>;

        internal var timeInZone1Defined:Boolean;

        internal var _reducedEntries:__AS3__.vec.Vector.<core.activities.ActivityEntry>;

        public var entryCount:int=0;

        internal var _timeInZone2:Number=0;

        internal var _exerciseTime:Number=0;

        public var exerciseTimeDefined:Boolean=false;

        public var timeInZone2Defined:Boolean=false;

        internal var _timeInZone3:Number=0;

        internal var _externalLink:String="";

        public var externalLinkDefined:Boolean=false;

        public var timeInZone3Defined:Boolean=false;

        public var timeInZoneDefined:Boolean=false;

        internal var _timeLightSleep:Number=0;

        internal var _feeling:uint=2;

        public var feelingDefined:Boolean=false;

        public var timeLightSleepDefined:Boolean=false;

        protected var _timeOutOfZone:Number=0;

        internal var _fuelEconomy:Number=0;

        public var fuelEconomyDefined:Boolean=false;

        internal var _timeOverIntensityZone:Number=0;

        internal var _gender:String="";

        public var genderDefined:Boolean=false;

        public var timeOverIntensityZoneDefined:Boolean=false;

        internal var _timeOverZone:Number=0;

        internal var _ghostData:Array;

        internal var _ghostName:String="";

        public var timeOverZoneDefined:Boolean=false;

        internal var _timeSleep:Number=0;

        internal var _hrMax:uint=0;

        public var hrMaxDefined:Boolean=false;

        public var timeSleepAnalysis:Number=0;

        public var timeSleepDefined:Boolean=false;

        public var timeSleepOutputString:String="--";

        internal var _timeUnderIntensityZone:Number=0;

        internal var _importFromDevice:Boolean=false;

        public var indexOfLog:int=0;

        public var timeUnderIntensityZoneDefined:Boolean=false;

        internal var _timeUnderZone:Number=0;

        internal var _intensityZone1Start:uint=0;

        public var intensityZone1StartDefined:Boolean=false;

        public var timeUnderZoneDefined:Boolean=false;

        internal var _timeWakeUp:Number=0;

        internal var _intensityZone2Start:uint=0;

        public var intensityZone2StartDefined:Boolean=false;

        public var timeWakeUpDefined:Boolean=false;

        public var torqueEffectLeft:Number=0;

        public var torqueEffectLeftDefined:Boolean=false;

        public var torqueEffectRight:Number=0;

        public var torqueEffectRightDefined:Boolean=false;

        internal var _trackProfile:uint=0;

        internal var _intensityZone3Start:uint=0;

        public var intensityZone3StartDefined:Boolean=false;

        public var trackProfileDefined:Boolean=false;

        internal var _trainingCategory:core.general.TrainingCategory;

        internal var _intensityZone4End:uint=0;

        public var intensityZone4EndDefined:Boolean=false;

        public var trainingCategoryDefined:Boolean=false;

        public var trainingReference:core.training.TrainingReference;

        internal var _trainingTime:Number=0;

        internal var _intensityZone4Start:uint=0;

        public var intensityZone4StartDefined:Boolean=false;

        public var trainingTimeDefined:Boolean=false;

        internal var _trainingTimeDownhill:Number=0;

        public var intervalDefined:Boolean=false;

        internal var _isDeleted:Boolean=false;

        public var logVersionDefined:Boolean=false;

        public var trainingTimeOutputString:String="--";

        internal var _trainingTimePrecision:int=0;

        internal var _isNew:Boolean=false;

        internal var _isUpdate:Boolean=false;

        internal var _trainingTimeUphill:Number=0;

        public var lapCount:int=0;

        public var lapValuesIndex:int=0;

        public var trainingTimeUphillDefined:Boolean=false;

        internal var _trainingType:String="";

        public var lapValuesLoaded:Array;

        public var lapValuesToLoad:int=0;

        internal var trainingTypeDefined:Boolean;

        public var lastSelectedEndEntry:core.activities.ActivityEntry;

        public var lastSelectedStartEntry:core.activities.ActivityEntry;

        internal var _trainingZone:String="";

        internal var _latitudeEnd:Number=0;

        public var latitudeEndDefined:Boolean=false;

        internal var trainingZoneDefined:Boolean;

        internal var _latitudeStart:Number=0;

        public var latitudeStartDefined:Boolean=false;

        internal var _tripSectionDistance:Number=0;

        internal var _linkedRouteId:int=0;

        public var linkedRouteIdDefined:Boolean=true;

        public var tripSectionDistanceDefined:Boolean=false;

        internal var _tripSectionTime:Number=0;

        internal var _linkedTrackGUID:String="";

        public var linkedTrackGUIDDefined:Boolean=false;

        public var tripSectionTimeDefined:Boolean=false;

        internal var _txBatteryStatus:String="";

        internal var _logType:core.general.LogType;

        public var logTypeDefined:Boolean=false;

        public var txBatteryStatusDefined:Boolean=false;

        internal var _unit:core.units.Unit;

        internal var _logVersion:String="400";

        public var loggingPauseValuesLoaded:Array;

        public var unitDefined:Boolean=false;

        internal var _unitId:uint;

        public var loggingPauseValuesToLoad:int=0;

        internal var _longitudeEnd:Number=0;

        internal var _unitType:core.general.UnitType;

        public var longitudeEndDefined:Boolean=false;

        internal var _longitudeStart:Number=0;

        internal var _upperLimit:uint=0;

        public var longitudeStartDefined:Boolean=false;

        internal var _lowerLimit:uint=0;

        public var upperLimitDefined:Boolean=false;

        internal var _userId:uint=0;

        public var lowerLimitDefined:Boolean=false;

        internal var _manualTemperature:Number=0;

        internal var _weather:uint=0;

        public var manualTemperatureDefined:Boolean=false;

        internal var _markerList:__AS3__.vec.Vector.<core.marker.Marker>;

        public var weatherDefined:Boolean=false;

        internal var _weightUnit:String="";

        public var maxAltitudeEntry:int=-1;

        public var maxCadenceEntry:int=-1;

        internal var _wheelSize:uint=0;

        public var maxExpansionDownhillEntry:int=-1;

        public var maxExpansionEntry:int=-1;

        public var wheelSizeDefined:Boolean=false;

        internal var _wind:uint=0;

        public var maxExpansionUphillEntry:int=-1;

        public var maxHeartrateEntry:int=-1;

        public var windDefined:Boolean=false;

        internal var _withDevice:String="";

        public var maxInclineDownhillEntry:int=-1;

        public var maxInclineUphillEntry:int=-1;

        public var withDeviceDefined:Boolean=false;

        internal var _workInKJ:Number=0;

        public var maxPowerEntry:int=-1;

        public var maxRiseRateDownhillEntry:int=-1;

        public var workInKJDefined:Boolean=false;

        public var workoutId:int=0;

        public var workoutIndex:int;

        internal var _zone1Start:uint=0;

        public var maxRiseRateEntry:int=-1;

        public var maxRiseRateUphillEntry:int=-1;

        public var zone1StartDefined:Boolean=false;

        internal var _zone2Start:uint=0;

        public var maxSpeedEntry:int=-1;

        internal var _maximumAltitude:int=0;

        public var zone2StartDefined:Boolean=false;

        internal var _zone3End:uint=0;

        public var maximumAltitudeDefined:Boolean=false;

        internal var _maximumCadence:uint=0;

        public var zone3EndDefined:Boolean=false;

        internal var _zone3Start:uint=0;

        public var maximumCadenceDefined:Boolean=false;

        public var maximumExpansion:Number=0;

        public var zone3StartDefined:Boolean=false;

        protected var instanceObject:Object;

        public var maximumExpansionDefined:Boolean=false;

        public var maximumExpansionDownhill:Number=0;

        public var maximumExpansionDownhillDefined:Boolean=false;

        public var maximumExpansionUphill:Number=0;

        public var maximumExpansionUphillDefined:Boolean=false;

        internal var _maximumHeartrate:uint=0;

        public var maximumHeartrateDefined:Boolean=false;

        public static var initFormatter:Boolean=true;

        public static var speedTimeFormatter:utils.interfaces.ICustomTimeFormatter;

        internal var _maximumIncline:Number=0;

        public var maximumInclineDefined:Boolean=false;

        protected static var allowActivityCopy:Boolean=false;

        protected static var altitudeConverter:utils.converter.AltitudeConverter;

        protected static var altitudeFormatter:utils.interfaces.ICustomFormatter;

        protected static var caloriesFormatter:utils.interfaces.ICustomFormatterBase;

        protected static var clockFormatter:utils.interfaces.ICustomDateTimeFormatter;

        protected static var dateFormatter:utils.interfaces.ICustomDateTimeFormatter;

        protected static var distanceConverter:utils.converter.DistanceConverter;

        protected static var distanceFormatter:utils.interfaces.ICustomFormatter;

        protected static var heartrateFormatter:utils.interfaces.ICustomFormatterBase;

        protected static var powerFormatter:utils.interfaces.ICustomFormatterBase;

        protected static var speedConverter:utils.converter.SpeedConverter;

        protected static var speedFormatter:utils.interfaces.ICustomFormatter;

        protected static var timeFormatter:utils.interfaces.ICustomFormatter;

        protected static var timeFormatterHHMM:utils.interfaces.ICustomTimeFormatter;

        internal static var resetFormatterAndConverterCompleted:Boolean=false;

        internal var _maximumInclineDownhill:Number=0;

        public var trainingTimeDownhillDefined:Boolean=false;
    }
}


