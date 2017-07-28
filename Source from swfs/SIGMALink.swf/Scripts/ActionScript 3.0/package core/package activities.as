//package activities
//  package interfaces
//    class ICodingLog
package core.activities.interfaces 
{
    import core.activities.*;
    import core.units.*;
    
    public dynamic interface ICodingLog
    {
        function decodeLog(arg1:core.activities.Activity, arg2:Array):void;

        function decodePageHeaderInformation(arg1:Array, arg2:core.units.Unit):core.activities.Activity;

        function decodeAddressOfPageHeaders(arg1:Array):void;
    }
}


//  class Activity
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


//  class ActivityEntry
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


//  class ActivityEntryMapper
package core.activities 
{
    import __AS3__.vec.*;
    import database.*;
    import utils.*;
    import utils.date.*;
    
    public class ActivityEntryMapper extends Object
    {
        public function ActivityEntryMapper()
        {
            super();
            return;
        }

        public static function generateCSVHeader(arg1:core.activities.ActivityEntry):__AS3__.vec.Vector.<String>
        {
            var loc1:*=new __AS3__.vec.Vector.<String>();
            loc1.push("Number");
            if (arg1.altitudeDefined) 
            {
                loc1.push("Altitude [m]");
            }
            if (arg1.altitudeDifferencesDownhillDefined) 
            {
                loc1.push("AltitudeDifferencesDownhill [m]");
            }
            if (arg1.altitudeDifferencesUphillDefined) 
            {
                loc1.push("AltitudeDifferencesUphill [m]");
            }
            if (arg1.cadenceDefined) 
            {
                loc1.push("Cadence [rpm]");
            }
            if (arg1.caloriesDefined) 
            {
                loc1.push("Calories [kcal]");
            }
            if (arg1.distanceAbsoluteDefined) 
            {
                loc1.push("DistanceAbsolute [m]");
            }
            if (arg1.distanceDefined) 
            {
                loc1.push("Distance [m]");
            }
            if (arg1.distanceDownhillDefined) 
            {
                loc1.push("DistanceDownhill [m]");
            }
            if (arg1.distanceUphillDefined) 
            {
                loc1.push("DistanceUphill [m]");
            }
            if (arg1.heartrateDefined) 
            {
                loc1.push("Heartrate [bpm]");
            }
            if (arg1.inclineDefined) 
            {
                loc1.push("Incline [%]");
            }
            if (arg1.intensityZoneDefined) 
            {
                loc1.push("IntensityZone");
            }
            if (arg1.latitudeDefined) 
            {
                loc1.push("Latitude");
            }
            if (arg1.longitudeDefined) 
            {
                loc1.push("Longitude");
            }
            if (arg1.percentHRMaxDefined) 
            {
                loc1.push(" % of  HRMax");
            }
            if (arg1.powerDefined) 
            {
                loc1.push("Power [Watt]");
            }
            if (arg1.powerPerKGDefined) 
            {
                loc1.push("Power to Weight Ratio [Watt/kg]");
            }
            if (arg1.relativeRotationsDefined) 
            {
                loc1.push("RelativeRotations");
            }
            if (arg1.riseRateDefined) 
            {
                loc1.push("RiseRate [m/min]");
            }
            if (arg1.rotationsDefined) 
            {
                loc1.push("Rotations");
            }
            if (arg1.speedDefined) 
            {
                loc1.push("Speed [m/s]");
            }
            if (arg1.speedReferenceDefined) 
            {
                loc1.push("SpeedReference");
            }
            if (arg1.speedTimeDefined) 
            {
                loc1.push("SpeedTime");
            }
            if (arg1.targetZoneDefined) 
            {
                loc1.push("TargetZone");
            }
            if (arg1.temperatureDefined) 
            {
                loc1.push("Temperature [°C]");
            }
            loc1.push("TrainingTime [s]");
            loc1.push("TrainingTimeAbsolute [s]");
            if (arg1.trainingTimeDownhillDefined) 
            {
                loc1.push("TrainingTimeDownhill [s]");
            }
            if (arg1.trainingTimeUphillDefined) 
            {
                loc1.push("TrainingTimeUphill [s]");
            }
            if (arg1.workInKJDefined) 
            {
                loc1.push("Work [kJ]");
            }
            if (arg1.zoneDefined) 
            {
                loc1.push("Zone");
            }
            if (arg1.powerZoneDefined) 
            {
                loc1.push("Power zone");
            }
            if (arg1.timeBelowIntensityZonesDefined) 
            {
                loc1.push("Time below intensity zones");
            }
            if (arg1.timeInIntensityZone1Defined) 
            {
                loc1.push("Time in intensity zone 1");
            }
            if (arg1.timeInIntensityZone2Defined) 
            {
                loc1.push("Time in intensity zone 2");
            }
            if (arg1.timeInIntensityZone3Defined) 
            {
                loc1.push("Time in intensity zone 3");
            }
            if (arg1.timeInIntensityZone4Defined) 
            {
                loc1.push("Time in intensity zone 4");
            }
            if (arg1.timeAboveIntensityZonesDefined) 
            {
                loc1.push("Time above intensity zones");
            }
            if (arg1.timeInPowerZone1Defined) 
            {
                loc1.push("Time in Power zone 1");
            }
            if (arg1.timeInPowerZone2Defined) 
            {
                loc1.push("Time in Power zone 2");
            }
            if (arg1.timeInPowerZone3Defined) 
            {
                loc1.push("Time in Power zone 3");
            }
            if (arg1.timeInPowerZone4Defined) 
            {
                loc1.push("Time in Power zone 4");
            }
            if (arg1.timeInPowerZone5Defined) 
            {
                loc1.push("Time in Power zone 5");
            }
            if (arg1.timeInPowerZone6Defined) 
            {
                loc1.push("Time in Power zone 6");
            }
            if (arg1.timeInPowerZone7Defined) 
            {
                loc1.push("Time in Power zone 7");
            }
            if (arg1.timeBelowTargetZoneDefined) 
            {
                loc1.push("Time beow target zone");
            }
            if (arg1.timeInTargetZoneDefined) 
            {
                loc1.push("Time in target zone");
            }
            if (arg1.timeAboveTargetZoneDefined) 
            {
                loc1.push("Time above target zone");
            }
            if (arg1.pedalingTimeDefined) 
            {
                loc1.push("Pedaling time");
            }
            return loc1;
        }

        public static function fromXML(arg1:XML, arg2:core.activities.ActivityEntry, arg3:int, arg4:core.activities.ActivityEntry):void
        {
            var loc1:*=arg3;
            while (100 === loc1) 
            {
            };
        }

        public static function fromDB(arg1:Object, arg2:core.activities.ActivityEntry):void
        {
            arg2.activityEntryId = arg1["activityEntryId"];
            arg2.activityId = arg1["activityId"];
            var loc1:*;
            arg2.altitudeDefined = loc1 = !(arg1["altitude"] == null);
            if (loc1 == true) 
            {
                arg2.altitude = arg1["altitude"];
            }
            arg2.altitudeDifferencesDownhillDefined = loc1 = !(arg1["altitudeDifferencesDownhill"] == null);
            if (loc1 == true) 
            {
                arg2.altitudeDifferencesDownhill = arg1["altitudeDifferencesDownhill"];
            }
            arg2.altitudeDifferencesUphillDefined = loc1 = !(arg1["altitudeDifferencesUphill"] == null);
            if (loc1 == true) 
            {
                arg2.altitudeDifferencesUphill = arg1["altitudeDifferencesUphill"];
            }
            arg2.cadenceDefined = loc1 = !(arg1["cadence"] == null);
            if (loc1 == true) 
            {
                arg2.cadence = arg1["cadence"];
            }
            arg2.caloriesDefined = loc1 = !(arg1["calories"] == null);
            if (loc1 == true) 
            {
                arg2.calories = arg1["calories"];
            }
            arg2.distanceDefined = loc1 = !(arg1["distance"] == null);
            if (loc1 == true) 
            {
                arg2.distance = arg1["distance"];
            }
            arg2.distanceAbsoluteDefined = loc1 = !(arg1["distanceAbsolute"] == null);
            if (loc1 == true) 
            {
                arg2.distanceAbsolute = arg1["distanceAbsolute"];
            }
            arg2.distanceDownhillDefined = loc1 = !(arg1["distanceDownhill"] == null);
            if (loc1 == true) 
            {
                arg2.distanceDownhill = arg1["distanceDownhill"];
            }
            arg2.distanceUphillDefined = loc1 = !(arg1["distanceUphill"] == null);
            if (loc1 == true) 
            {
                arg2.distanceUphill = arg1["distanceUphill"];
            }
            arg2.heartrateDefined = loc1 = !(arg1["heartrate"] == null);
            if (loc1 == true) 
            {
                arg2.heartrate = arg1["heartrate"];
            }
            arg2.inclineDefined = loc1 = !(arg1["incline"] == null);
            if (loc1 == true) 
            {
                arg2.incline = arg1["incline"];
            }
            arg2.intensityZoneDefined = loc1 = !(arg1["intensityZone"] == null);
            if (loc1 == true) 
            {
                arg2.intensityZone = arg1["intensityZone"];
            }
            arg2.latitudeDefined = loc1 = !(arg1["latitude"] == null);
            if (loc1 == true) 
            {
                arg2.latitude = arg1["latitude"];
            }
            arg2.longitudeDefined = loc1 = !(arg1["longitude"] == null);
            if (loc1 == true) 
            {
                arg2.longitude = arg1["longitude"];
            }
            arg2.percentHRMaxDefined = loc1 = !(arg1["percentHRMax"] == null);
            if (loc1 == true) 
            {
                arg2.percentHRMax = arg1["percentHRMax"];
            }
            arg2.powerDefined = loc1 = !(arg1["power"] == null);
            if (loc1 == true) 
            {
                arg2.power = arg1["power"];
            }
            arg2.powerPerKGDefined = loc1 = !(arg1["powerPerKG"] == null);
            if (loc1 == true) 
            {
                arg2.powerPerKG = arg1["powerPerKG"];
            }
            arg2.relativeRotationsDefined = loc1 = !(arg1["relativeRotations"] == null);
            if (loc1 == true) 
            {
                arg2.relativeRotations = arg1["relativeRotations"];
            }
            arg2.riseRateDefined = loc1 = !(arg1["riseRate"] == null);
            if (loc1 == true) 
            {
                arg2.riseRate = arg1["riseRate"];
            }
            arg2.rotationsDefined = loc1 = !(arg1["rotations"] == null);
            if (loc1 == true) 
            {
                arg2.rotations = arg1["rotations"];
            }
            arg2.speedDefined = loc1 = !(arg1["speed"] == null);
            if (loc1 == true) 
            {
                arg2.speed = arg1["speed"];
                arg2.speedTimeDefined = true;
                arg2.speedTime = utils.Calculations.calculateSpeedTime(arg2.speed);
            }
            arg2.speedReferenceDefined = loc1 = !(arg1["speedReference"] == null);
            if (loc1 == true) 
            {
                arg2.speedReference = arg1["speedReference"];
            }
            arg2.targetZoneDefined = loc1 = !(arg1["targetZone"] == null);
            if (loc1 == true) 
            {
                arg2.targetZone = arg1["targetZone"];
            }
            arg2.temperatureDefined = loc1 = !(arg1["temperature"] == null);
            if (loc1 == true) 
            {
                arg2.temperature = arg1["temperature"];
            }
            arg2.trainingTime = arg1["trainingTime"];
            arg2.trainingTimeAbsolute = arg1["trainingTimeAbsolute"];
            arg2.trainingTimeDownhillDefined = loc1 = !(arg1["trainingTimeDownhill"] == null);
            if (loc1 == true) 
            {
                arg2.trainingTimeDownhill = arg1["trainingTimeDownhill"];
            }
            arg2.trainingTimeUphillDefined = loc1 = !(arg1["trainingTimeUphill"] == null);
            if (loc1 == true) 
            {
                arg2.trainingTimeUphill = arg1["trainingTimeUphill"];
            }
            arg2.workInKJDefined = loc1 = !(arg1["workInKJ"] == null);
            if (loc1 == true) 
            {
                arg2.workInKJ = arg1["workInKJ"];
            }
            arg2.zoneDefined = loc1 = !(arg1["zone"] == null);
            if (loc1 == true) 
            {
                arg2.zone = arg1["zone"];
            }
            arg2.normalizedPowerDefined = loc1 = !(arg1["normalizedPower"] == null);
            if (loc1 == true) 
            {
                arg2.normalizedPower = arg1["normalizedPower"];
            }
            arg2.rightBalanceDefined = loc1 = !(arg1["rightBalance"] == null);
            if (loc1 == true) 
            {
                arg2.rightBalance = arg1["rightBalance"];
            }
            arg2.leftBalanceDefined = loc1 = !(arg1["leftBalance"] == null);
            if (loc1 == true) 
            {
                arg2.leftBalance = arg1["leftBalance"];
            }
            arg2.powerZoneDefined = loc1 = !(arg1["powerZone"] == null);
            if (loc1 == true) 
            {
                arg2.powerZone = arg1["powerZone"];
            }
            arg2.isActiveDefined = loc1 = !(arg1["motionPoints"] == null);
            if (loc1 == true) 
            {
                arg2.isActive = arg1["motionPoints"] != 1 ? false : true;
            }
            arg2.stepsDefined = loc1 = !(arg1["stepsLow"] == null);
            if (loc1 == true) 
            {
                arg2.steps = arg1["stepsLow"];
            }
            arg2.stepTypeDefined = loc1 = !(arg1["stepsMedium"] == null);
            if (loc1 == true) 
            {
                arg2.stepType = arg1["stepsMedium"];
            }
            arg2.sleepPhaseDefined = loc1 = !(arg1["stepsHigh"] == null);
            if (loc1 == true) 
            {
                arg2.sleepPhase = arg1["stepsHigh"];
            }
            arg2.activeHourDefined = loc1 = !(arg1["activTimeLow"] == null);
            if (loc1 == true) 
            {
                arg2.activeHour = arg1["activTimeLow"];
            }
            arg2.timeStartDefined = loc1 = !(arg1["timeStart"] == null);
            if (loc1 == true) 
            {
                arg2.timeStart = utils.date.DateUtilCommon.dateFromMySqlFormat(arg1["timeStart"]);
            }
            arg2.phaseNumberDefined = loc1 = !(arg1["phaseNumber"] == null);
            if (loc1 == true) 
            {
                arg2.phaseNumber = arg1["phaseNumber"];
            }
            arg2.timeBelowIntensityZonesDefined = loc1 = !(arg1["timeBelowIntensityZones"] == null);
            if (loc1 == true) 
            {
                arg2.timeBelowIntensityZones = arg1["timeBelowIntensityZones"];
            }
            arg2.timeInIntensityZone1Defined = loc1 = !(arg1["timeInIntensityZone1"] == null);
            if (loc1 == true) 
            {
                arg2.timeInIntensityZone1 = arg1["timeInIntensityZone1"];
            }
            arg2.timeInIntensityZone2Defined = loc1 = !(arg1["timeInIntensityZone2"] == null);
            if (loc1 == true) 
            {
                arg2.timeInIntensityZone2 = arg1["timeInIntensityZone2"];
            }
            arg2.timeInIntensityZone3Defined = loc1 = !(arg1["timeInIntensityZone3"] == null);
            if (loc1 == true) 
            {
                arg2.timeInIntensityZone3 = arg1["timeInIntensityZone3"];
            }
            arg2.timeInIntensityZone4Defined = loc1 = !(arg1["timeInIntensityZone4"] == null);
            if (loc1 == true) 
            {
                arg2.timeInIntensityZone4 = arg1["timeInIntensityZone4"];
            }
            arg2.timeAboveIntensityZonesDefined = loc1 = !(arg1["timeAboveIntensityZones"] == null);
            if (loc1 == true) 
            {
                arg2.timeAboveIntensityZones = arg1["timeAboveIntensityZones"];
            }
            arg2.timeBelowTargetZoneDefined = loc1 = !(arg1["timeBelowTargetZone"] == null);
            if (loc1 == true) 
            {
                arg2.timeBelowTargetZone = arg1["timeBelowTargetZone"];
            }
            arg2.timeInPowerZone1Defined = loc1 = !(arg1["timeInPowerZone1"] == null);
            if (loc1 == true) 
            {
                arg2.timeInPowerZone1 = arg1["timeInPowerZone1"];
            }
            arg2.timeInPowerZone2Defined = loc1 = !(arg1["timeInPowerZone2"] == null);
            if (loc1 == true) 
            {
                arg2.timeInPowerZone2 = arg1["timeInPowerZone2"];
            }
            arg2.timeInPowerZone3Defined = loc1 = !(arg1["timeInPowerZone3"] == null);
            if (loc1 == true) 
            {
                arg2.timeInPowerZone3 = arg1["timeInPowerZone3"];
            }
            arg2.timeInPowerZone4Defined = loc1 = !(arg1["timeInPowerZone4"] == null);
            if (loc1 == true) 
            {
                arg2.timeInPowerZone4 = arg1["timeInPowerZone4"];
            }
            arg2.timeInPowerZone5Defined = loc1 = !(arg1["timeInPowerZone5"] == null);
            if (loc1 == true) 
            {
                arg2.timeInPowerZone5 = arg1["timeInPowerZone5"];
            }
            arg2.timeInPowerZone6Defined = loc1 = !(arg1["timeInPowerZone6"] == null);
            if (loc1 == true) 
            {
                arg2.timeInPowerZone6 = arg1["timeInPowerZone6"];
            }
            arg2.timeInPowerZone7Defined = loc1 = !(arg1["timeInPowerZone7"] == null);
            if (loc1 == true) 
            {
                arg2.timeInPowerZone7 = arg1["timeInPowerZone7"];
            }
            arg2.timeInTargetZoneDefined = loc1 = !(arg1["timeInTargetZone"] == null);
            if (loc1 == true) 
            {
                arg2.timeInTargetZone = arg1["timeInTargetZone"];
            }
            arg2.timeAboveTargetZoneDefined = loc1 = !(arg1["timeAboveTargetZone"] == null);
            if (loc1 == true) 
            {
                arg2.timeAboveTargetZone = arg1["timeAboveTargetZone"];
            }
            arg2.pedalingTimeDefined = loc1 = !(arg1["pedalingTime"] == null);
            if (loc1 == true) 
            {
                arg2.pedalingTime = arg1["pedalingTime"];
            }
            return;
        }

        public static function generateCSV(arg1:core.activities.ActivityEntry, arg2:int):__AS3__.vec.Vector.<String>
        {
            var loc1:*=new __AS3__.vec.Vector.<String>();
            loc1.push(arg2);
            if (arg1.altitudeDefined) 
            {
                loc1.push(arg1.altitude);
            }
            if (arg1.altitudeDifferencesDownhillDefined) 
            {
                loc1.push(arg1.altitudeDifferencesDownhill);
            }
            if (arg1.altitudeDifferencesUphillDefined) 
            {
                loc1.push(arg1.altitudeDifferencesUphill);
            }
            if (arg1.cadenceDefined) 
            {
                loc1.push(arg1.cadence);
            }
            if (arg1.caloriesDefined) 
            {
                loc1.push(arg1.calories);
            }
            if (arg1.distanceAbsoluteDefined) 
            {
                loc1.push(arg1.distanceAbsolute);
            }
            if (arg1.distanceDefined) 
            {
                loc1.push(arg1.distance);
            }
            if (arg1.distanceDownhillDefined) 
            {
                loc1.push(arg1.distanceDownhill);
            }
            if (arg1.distanceUphillDefined) 
            {
                loc1.push(arg1.distanceUphill);
            }
            if (arg1.heartrateDefined) 
            {
                loc1.push(arg1.heartrate);
            }
            if (arg1.inclineDefined) 
            {
                loc1.push(arg1.incline);
            }
            if (arg1.intensityZoneDefined) 
            {
                loc1.push(arg1.intensityZone);
            }
            if (arg1.latitudeDefined) 
            {
                loc1.push(arg1.latitude);
            }
            if (arg1.longitudeDefined) 
            {
                loc1.push(arg1.longitude);
            }
            if (arg1.percentHRMaxDefined) 
            {
                loc1.push(arg1.percentHRMax);
            }
            if (arg1.powerDefined) 
            {
                loc1.push(arg1.power);
            }
            if (arg1.powerPerKGDefined) 
            {
                loc1.push(arg1.powerPerKG);
            }
            if (arg1.relativeRotationsDefined) 
            {
                loc1.push(arg1.relativeRotations);
            }
            if (arg1.riseRateDefined) 
            {
                loc1.push(arg1.riseRate);
            }
            if (arg1.rotationsDefined) 
            {
                loc1.push(arg1.rotations);
            }
            if (arg1.speedDefined) 
            {
                loc1.push(arg1.speed);
            }
            if (arg1.speedReferenceDefined) 
            {
                loc1.push(arg1.speedReference);
            }
            if (arg1.speedTimeDefined) 
            {
                loc1.push(arg1.speedTime);
            }
            if (arg1.targetZoneDefined) 
            {
                loc1.push(arg1.targetZone);
            }
            if (arg1.temperatureDefined) 
            {
                loc1.push(arg1.temperature);
            }
            loc1.push(arg1.trainingTime);
            loc1.push(arg1.trainingTimeAbsolute);
            if (arg1.trainingTimeDownhillDefined) 
            {
                loc1.push(arg1.trainingTimeDownhill);
            }
            if (arg1.trainingTimeUphillDefined) 
            {
                loc1.push(arg1.trainingTimeUphill);
            }
            if (arg1.workInKJDefined) 
            {
                loc1.push(arg1.workInKJ);
            }
            if (arg1.zoneDefined) 
            {
                loc1.push(arg1.zone);
            }
            if (arg1.powerZoneDefined) 
            {
                loc1.push(arg1.powerZone);
            }
            if (arg1.timeBelowIntensityZonesDefined) 
            {
                loc1.push(arg1.timeBelowIntensityZones);
            }
            if (arg1.timeInIntensityZone1Defined) 
            {
                loc1.push(arg1.timeInIntensityZone1);
            }
            if (arg1.timeInIntensityZone2Defined) 
            {
                loc1.push(arg1.timeInIntensityZone2);
            }
            if (arg1.timeInIntensityZone3Defined) 
            {
                loc1.push(arg1.timeInIntensityZone3);
            }
            if (arg1.timeInIntensityZone4Defined) 
            {
                loc1.push(arg1.timeInIntensityZone4);
            }
            if (arg1.timeAboveIntensityZonesDefined) 
            {
                loc1.push(arg1.timeAboveIntensityZones);
            }
            if (arg1.timeInPowerZone1Defined) 
            {
                loc1.push(arg1.timeInPowerZone1);
            }
            if (arg1.timeInPowerZone2Defined) 
            {
                loc1.push(arg1.timeInPowerZone2);
            }
            if (arg1.timeInPowerZone3Defined) 
            {
                loc1.push(arg1.timeInPowerZone3);
            }
            if (arg1.timeInPowerZone4Defined) 
            {
                loc1.push(arg1.timeInPowerZone4);
            }
            if (arg1.timeInPowerZone5Defined) 
            {
                loc1.push(arg1.timeInPowerZone5);
            }
            if (arg1.timeInPowerZone6Defined) 
            {
                loc1.push(arg1.timeInPowerZone6);
            }
            if (arg1.timeInPowerZone7Defined) 
            {
                loc1.push(arg1.timeInPowerZone7);
            }
            if (arg1.timeBelowTargetZoneDefined) 
            {
                loc1.push(arg1.timeBelowTargetZone);
            }
            if (arg1.timeInTargetZoneDefined) 
            {
                loc1.push(arg1.timeInTargetZone);
            }
            if (arg1.timeAboveTargetZoneDefined) 
            {
                loc1.push(arg1.timeAboveTargetZone);
            }
            if (arg1.pedalingTimeDefined) 
            {
                loc1.push(arg1.pedalingTime);
            }
            return loc1;
        }

        internal static function fromXML400(arg1:XML, arg2:core.activities.ActivityEntry, arg3:core.activities.ActivityEntry):core.activities.ActivityEntry
        {
            var loc1:*=undefined;
            if (arg2 != null) 
            {
                arg3.number = arg2.number + 1;
            }
            else 
            {
                arg3.number = 0;
            }
            loc1 = arg1.@altitude;
            var loc2:*;
            arg3.altitudeDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.altitude = loc1;
            }
            loc1 = arg1.@altitudeDifferencesDownhill;
            arg3.altitudeDifferencesDownhillDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.altitudeDifferencesDownhill = loc1;
            }
            loc1 = arg1.@altitudeDifferencesUphill;
            arg3.altitudeDifferencesUphillDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.altitudeDifferencesUphill = loc1;
            }
            loc1 = arg1.@cadence;
            arg3.cadenceDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.cadence = loc1;
            }
            loc1 = arg1.@calories;
            arg3.caloriesDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.calories = loc1;
            }
            loc1 = arg1.@distance;
            arg3.distanceDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.distance = loc1;
            }
            loc1 = arg1.@distanceAbsolute;
            arg3.distanceAbsoluteDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.distanceAbsolute = loc1;
            }
            loc1 = arg1.@distanceDownhill;
            arg3.distanceDownhillDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.distanceDownhill = loc1;
            }
            loc1 = arg1.@distanceUphill;
            arg3.distanceUphillDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.distanceUphill = loc1;
            }
            loc1 = arg1.@heartrate;
            arg3.heartrateDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.heartrate = loc1;
            }
            loc1 = arg1.@incline;
            arg3.inclineDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.incline = loc1;
            }
            loc1 = arg1.@intensityZone;
            arg3.intensityZoneDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.intensityZone = loc1;
            }
            loc1 = arg1.@latitude;
            arg3.latitudeDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.latitude = loc1;
            }
            loc1 = arg1.@longitude;
            arg3.longitudeDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.longitude = loc1;
            }
            loc1 = arg1.@percentHRMax;
            arg3.percentHRMaxDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.percentHRMax = loc1;
            }
            loc1 = arg1.@power;
            arg3.powerDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.power = loc1;
            }
            loc1 = arg1.@powerPerKG;
            arg3.powerPerKGDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.powerPerKG = loc1;
            }
            loc1 = arg1.@relativeRotations;
            arg3.relativeRotationsDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.relativeRotations = loc1;
            }
            loc1 = arg1.@riseRate;
            arg3.riseRateDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.riseRate = loc1;
            }
            loc1 = arg1.@rotations;
            arg3.rotationsDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.rotations = loc1;
            }
            loc1 = arg1.@speed;
            arg3.speedDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.speed = loc1;
            }
            loc1 = arg1.@speedReference;
            arg3.speedReferenceDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.speedReference = loc1;
            }
            loc1 = arg1.@speedTime;
            arg3.speedTimeDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.speedTime = loc1;
            }
            loc1 = arg1.@targetZone;
            arg3.targetZoneDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.targetZone = loc1;
            }
            loc1 = arg1.@zone;
            arg3.zoneDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.zone = loc1;
            }
            loc1 = arg1.@normalizedPower;
            arg3.normalizedPowerDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.normalizedPower = loc1;
            }
            loc1 = arg1.@balance;
            arg3.rightBalanceDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.rightBalance = loc1;
            }
            arg3.leftBalanceDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.leftBalance = loc1;
            }
            loc1 = arg1.@temperature;
            arg3.temperatureDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.temperature = loc1;
            }
            arg3.trainingTime = arg1.@trainingTime;
            arg3.trainingTimeAbsolute = arg1.@trainingTimeAbsolute;
            loc1 = arg1.@trainingTimeDownhill;
            arg3.trainingTimeDownhillDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.trainingTimeDownhill = loc1;
            }
            loc1 = arg1.@trainingTimeUphill;
            arg3.trainingTimeUphillDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.trainingTimeUphill = loc1;
            }
            loc1 = arg1.@workInKJ;
            arg3.workInKJDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.workInKJ = loc1;
            }
            loc1 = arg1.@powerZone;
            arg3.powerZoneDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.powerZone = loc1;
            }
            loc1 = arg1.@isActive;
            arg3.isActiveDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.isActive = loc1 != 1 ? false : true;
            }
            loc1 = arg1.@steps;
            arg3.stepsDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.steps = loc1;
            }
            loc1 = arg1.@stepType;
            arg3.stepTypeDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.stepType = loc1;
            }
            loc1 = arg1.@sleepPhase;
            arg3.sleepPhaseDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.sleepPhase = loc1;
            }
            loc1 = arg1.@activeHour;
            arg3.activeHourDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.activeHour = loc1;
            }
            loc1 = arg1.@timeStart;
            arg3.timeStartDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.timeStart = utils.date.DateUtilCommon.dateFromMySqlFormat(loc1);
            }
            loc1 = arg1.@phaseNumber;
            arg3.phaseNumberDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.phaseNumber = loc1;
            }
            loc1 = arg1.@timeBelowIntensityZones;
            arg3.timeBelowIntensityZonesDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.timeBelowIntensityZones = loc1;
            }
            loc1 = arg1.@timeInIntensityZone1;
            arg3.timeInIntensityZone1Defined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.timeInIntensityZone1 = loc1;
            }
            loc1 = arg1.@timeInIntensityZone2;
            arg3.timeInIntensityZone2Defined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.timeInIntensityZone2 = loc1;
            }
            loc1 = arg1.@timeInIntensityZone3;
            arg3.timeInIntensityZone3Defined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.timeInIntensityZone3 = loc1;
            }
            loc1 = arg1.@timeInIntensityZone4;
            arg3.timeInIntensityZone4Defined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.timeInIntensityZone4 = loc1;
            }
            loc1 = arg1.@timeAboveIntensityZones;
            arg3.timeAboveIntensityZonesDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.timeAboveIntensityZones = loc1;
            }
            loc1 = arg1.@timeInPowerZone1;
            arg3.timeInPowerZone1Defined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.timeInPowerZone1 = loc1;
            }
            loc1 = arg1.@timeInPowerZone2;
            arg3.timeInPowerZone2Defined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.timeInPowerZone2 = loc1;
            }
            loc1 = arg1.@timeInPowerZone3;
            arg3.timeInPowerZone3Defined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.timeInPowerZone3 = loc1;
            }
            loc1 = arg1.@timeInPowerZone4;
            arg3.timeInPowerZone4Defined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.timeInPowerZone4 = loc1;
            }
            loc1 = arg1.@timeInPowerZone5;
            arg3.timeInPowerZone5Defined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.timeInPowerZone5 = loc1;
            }
            loc1 = arg1.@timeInPowerZone6;
            arg3.timeInPowerZone6Defined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.timeInPowerZone6 = loc1;
            }
            loc1 = arg1.@timeInPowerZone7;
            arg3.timeInPowerZone7Defined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.timeInPowerZone7 = loc1;
            }
            loc1 = arg1.@timeBelowTargetZone;
            arg3.timeBelowTargetZoneDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.timeBelowTargetZone = loc1;
            }
            loc1 = arg1.@timeInTargetZone;
            arg3.timeInTargetZoneDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.timeInTargetZone = loc1;
            }
            loc1 = arg1.@timeAboveTargetZone;
            arg3.timeAboveTargetZoneDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.timeAboveTargetZone = loc1;
            }
            loc1 = arg1.@pedalingTime;
            arg3.pedalingTimeDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.pedalingTime = loc1;
            }
            return arg3;
        }

        public static function generateDBCreateTable(arg1:uint):database.DatabaseTable
        {
            var loc1:*=null;
            var loc2:*=arg1;
            while (400 === loc2) 
            {
                DB_TABLE_400 = new database.DatabaseTable("ActivityEntry");
                DB_TABLE_400.addColumns([["activityEntryId", "INTEGER", false, true, true], ["activityId", "INTEGER", false], ["altitude", "NUMERIC", true], ["altitudeDifferencesDownhill", "INTEGER", true], ["altitudeDifferencesUphill", "INTEGER", true], ["cadence", "INTEGER", true], ["calories", "NUMERIC", true], ["distance", "NUMERIC", true], ["distanceAbsolute", "NUMERIC", true], ["distanceDownhill", "NUMERIC", true], ["distanceUphill", "NUMERIC", true], ["heartrate", "NUMERIC", true], ["incline", "NUMERIC", true], ["intensityZone", "INTEGER", true], ["latitude", "NUMERIC", true], ["longitude", "NUMERIC", true], ["percentHRMax", "NUMERIC", true], ["power", "INTEGER", true], ["powerPerKG", "NUMERIC", true], ["relativeRotations", "INTEGER", true], ["riseRate", "NUMERIC", true], ["rotations", "INTEGER", true], ["speed", "NUMERIC", true], ["speedReference", "VARCHAR", true], ["targetZone", "INTEGER", true], ["temperature", "NUMERIC", true], ["trainingTime", "NUMERIC", true], ["trainingTimeAbsolute", "NUMERIC", true], ["trainingTimeDownhill", "NUMERIC", true], ["trainingTimeUphill", "NUMERIC", true], ["workInKJ", "NUMERIC", true], ["zone", "INTEGER", true], ["powerZone", "INTEGER", true], ["motionPoints", "NUMERIC", true], ["stepsLow", "NUMERIC", true], ["stepsMedium", "NUMERIC", true], ["stepsHigh", "NUMERIC", true], ["activTimeLow", "NUMERIC", true], ["activTimeMedium", "NUMERIC", true], ["activTimeHigh", "NUMERIC", true], ["emptyField1", "NUMERIC", true], ["emptyField2", "NUMERIC", true], ["emptyField3", "VARCHAR", true], ["emptyField4", "VARCHAR", true]]);
                loc1 = DB_TABLE_400;
            }
        }

        public static function generateDBCreateIndex():String
        {
            var loc1:*="CREATE INDEX IF NOT EXISTS ActivityIdOnActivityEntry ON ActivityEntry (activityId)";
            return loc1;
        }

        public static function generateDBColumns(arg1:core.activities.ActivityEntry):Array
        {
            var loc1:*=[];
            loc1.push("activityEntryId");
            loc1.push("activityId");
            if (arg1.altitudeDefined) 
            {
                loc1.push("altitude");
            }
            if (arg1.altitudeDifferencesDownhillDefined) 
            {
                loc1.push("altitudeDifferencesDownhill");
            }
            if (arg1.altitudeDifferencesUphillDefined) 
            {
                loc1.push("altitudeDifferencesUphill");
            }
            if (arg1.cadenceDefined) 
            {
                loc1.push("cadence");
            }
            if (arg1.caloriesDefined) 
            {
                loc1.push("calories");
            }
            if (arg1.distanceDefined) 
            {
                loc1.push("distance");
            }
            if (arg1.distanceAbsoluteDefined) 
            {
                loc1.push("distanceAbsolute");
            }
            if (arg1.distanceDownhillDefined) 
            {
                loc1.push("distanceDownhill");
            }
            if (arg1.distanceUphillDefined) 
            {
                loc1.push("distanceUphill");
            }
            if (arg1.heartrateDefined) 
            {
                loc1.push("heartrate");
            }
            if (arg1.inclineDefined) 
            {
                loc1.push("incline");
            }
            if (arg1.intensityZoneDefined) 
            {
                loc1.push("intensityZone");
            }
            if (arg1.latitudeDefined) 
            {
                loc1.push("latitude");
            }
            if (arg1.longitudeDefined) 
            {
                loc1.push("longitude");
            }
            if (arg1.percentHRMaxDefined) 
            {
                loc1.push("percentHRMax");
            }
            if (arg1.powerDefined) 
            {
                loc1.push("power");
            }
            if (arg1.powerPerKGDefined) 
            {
                loc1.push("powerPerKG");
            }
            if (arg1.relativeRotationsDefined) 
            {
                loc1.push("relativeRotations");
            }
            if (arg1.riseRateDefined) 
            {
                loc1.push("riseRate");
            }
            if (arg1.rotationsDefined) 
            {
                loc1.push("rotations");
            }
            if (arg1.speedDefined) 
            {
                loc1.push("speed");
            }
            if (arg1.speedReferenceDefined) 
            {
                loc1.push("speedReference");
            }
            if (arg1.targetZoneDefined) 
            {
                loc1.push("targetZone");
            }
            if (arg1.temperatureDefined) 
            {
                loc1.push("temperature");
            }
            loc1.push("trainingTime");
            loc1.push("trainingTimeAbsolute");
            if (arg1.trainingTimeDownhillDefined) 
            {
                loc1.push("trainingTimeDownhill");
            }
            if (arg1.trainingTimeUphillDefined) 
            {
                loc1.push("trainingTimeUphill");
            }
            if (arg1.workInKJDefined) 
            {
                loc1.push("workInKJ");
            }
            if (arg1.zoneDefined) 
            {
                loc1.push("zone");
            }
            if (arg1.normalizedPowerDefined) 
            {
                loc1.push("normalizedPower");
            }
            if (arg1.rightBalanceDefined) 
            {
                loc1.push("rightBalance");
            }
            if (arg1.leftBalanceDefined) 
            {
                loc1.push("leftBalance");
            }
            if (arg1.powerZoneDefined) 
            {
                loc1.push("powerZone");
            }
            if (arg1.isActiveDefined) 
            {
                loc1.push("motionPoints");
            }
            if (arg1.stepsDefined) 
            {
                loc1.push("stepsLow");
            }
            if (arg1.stepTypeDefined) 
            {
                loc1.push("stepsMedium");
            }
            if (arg1.sleepPhaseDefined) 
            {
                loc1.push("stepsHigh");
            }
            if (arg1.activeHourDefined) 
            {
                loc1.push("activTimeLow");
            }
            if (arg1.timeStartDefined) 
            {
                loc1.push("timeStart");
            }
            if (arg1.phaseNumberDefined) 
            {
                loc1.push("phaseNumber");
            }
            if (arg1.timeBelowIntensityZonesDefined) 
            {
                loc1.push("timeBelowIntensityZones");
            }
            if (arg1.timeInIntensityZone1Defined) 
            {
                loc1.push("timeInIntensityZone1");
            }
            if (arg1.timeInIntensityZone2Defined) 
            {
                loc1.push("timeInIntensityZone2");
            }
            if (arg1.timeInIntensityZone3Defined) 
            {
                loc1.push("timeInIntensityZone3");
            }
            if (arg1.timeInIntensityZone4Defined) 
            {
                loc1.push("timeInIntensityZone4");
            }
            if (arg1.timeAboveIntensityZonesDefined) 
            {
                loc1.push("timeAboveIntensityZones");
            }
            if (arg1.timeInPowerZone1Defined) 
            {
                loc1.push("timeInPowerZone1");
            }
            if (arg1.timeInPowerZone2Defined) 
            {
                loc1.push("timeInPowerZone2");
            }
            if (arg1.timeInPowerZone3Defined) 
            {
                loc1.push("timeInPowerZone3");
            }
            if (arg1.timeInPowerZone4Defined) 
            {
                loc1.push("timeInPowerZone4");
            }
            if (arg1.timeInPowerZone5Defined) 
            {
                loc1.push("timeInPowerZone5");
            }
            if (arg1.timeInPowerZone6Defined) 
            {
                loc1.push("timeInPowerZone6");
            }
            if (arg1.timeInPowerZone7Defined) 
            {
                loc1.push("timeInPowerZone7");
            }
            if (arg1.timeBelowTargetZoneDefined) 
            {
                loc1.push("timeBelowTargetZone");
            }
            if (arg1.timeInTargetZoneDefined) 
            {
                loc1.push("timeInTargetZone");
            }
            if (arg1.timeAboveTargetZoneDefined) 
            {
                loc1.push("timeAboveTargetZone");
            }
            if (arg1.pedalingTimeDefined) 
            {
                loc1.push("pedalingTime");
            }
            return loc1;
        }

        public static function generateDBInsertStmtParameter(arg1:core.activities.ActivityEntry, arg2:Object):void
        {
            if (arg1.activityEntryId > 0) 
            {
                arg2[":activityEntryId"] = arg1.activityEntryId;
            }
            else 
            {
                arg2[":activityEntryId"] = null;
            }
            arg2[":activityId"] = arg1.activityId;
            if (arg1.altitudeDefined) 
            {
                arg2[":altitude"] = arg1.altitude;
            }
            if (arg1.altitudeDifferencesDownhillDefined) 
            {
                arg2[":altitudeDifferencesDownhill"] = arg1.altitudeDifferencesDownhill;
            }
            if (arg1.altitudeDifferencesUphillDefined) 
            {
                arg2[":altitudeDifferencesUphill"] = arg1.altitudeDifferencesUphill;
            }
            if (arg1.cadenceDefined) 
            {
                arg2[":cadence"] = arg1.cadence;
            }
            if (arg1.caloriesDefined) 
            {
                arg2[":calories"] = arg1.calories;
            }
            if (arg1.distanceDefined) 
            {
                arg2[":distance"] = arg1.distance;
            }
            if (arg1.distanceAbsoluteDefined) 
            {
                arg2[":distanceAbsolute"] = arg1.distanceAbsolute;
            }
            if (arg1.distanceDownhillDefined) 
            {
                arg2[":distanceDownhill"] = arg1.distanceDownhill;
            }
            if (arg1.distanceUphillDefined) 
            {
                arg2[":distanceUphill"] = arg1.distanceUphill;
            }
            if (arg1.heartrateDefined) 
            {
                arg2[":heartrate"] = arg1.heartrate;
            }
            if (arg1.inclineDefined) 
            {
                arg2[":incline"] = arg1.incline;
            }
            if (arg1.intensityZoneDefined) 
            {
                arg2[":intensityZone"] = arg1.intensityZone;
            }
            if (arg1.latitudeDefined) 
            {
                arg2[":latitude"] = arg1.latitude;
            }
            if (arg1.longitudeDefined) 
            {
                arg2[":longitude"] = arg1.longitude;
            }
            if (arg1.percentHRMaxDefined) 
            {
                arg2[":percentHRMax"] = arg1.percentHRMax;
            }
            if (arg1.powerDefined) 
            {
                arg2[":power"] = arg1.power;
            }
            if (arg1.powerPerKGDefined) 
            {
                arg2[":powerPerKG"] = arg1.powerPerKG;
            }
            if (arg1.relativeRotationsDefined) 
            {
                arg2[":relativeRotations"] = arg1.relativeRotations;
            }
            if (arg1.riseRateDefined) 
            {
                arg2[":riseRate"] = arg1.riseRate;
            }
            if (arg1.rotationsDefined) 
            {
                arg2[":rotations"] = arg1.rotations;
            }
            if (arg1.speedDefined) 
            {
                arg2[":speed"] = arg1.speed;
            }
            if (arg1.speedReferenceDefined) 
            {
                arg2[":speedReference"] = arg1.speedReference;
            }
            if (arg1.targetZoneDefined) 
            {
                arg2[":targetZone"] = arg1.targetZone;
            }
            if (arg1.zoneDefined) 
            {
                arg2[":zone"] = arg1.zone;
            }
            if (arg1.normalizedPowerDefined) 
            {
                arg2[":normalizedPower"] = arg1.normalizedPower;
            }
            if (arg1.rightBalanceDefined) 
            {
                arg2[":rightBalance"] = arg1.rightBalance;
            }
            if (arg1.leftBalanceDefined) 
            {
                arg2[":leftBalance"] = arg1.leftBalance;
            }
            if (arg1.temperatureDefined) 
            {
                arg2[":temperature"] = arg1.temperature;
            }
            arg2[":trainingTime"] = arg1.trainingTime;
            arg2[":trainingTimeAbsolute"] = arg1.trainingTimeAbsolute;
            if (arg1.trainingTimeDownhillDefined) 
            {
                arg2[":trainingTimeDownhill"] = arg1.trainingTimeDownhill;
            }
            if (arg1.trainingTimeUphillDefined) 
            {
                arg2[":trainingTimeUphill"] = arg1.trainingTimeUphill;
            }
            if (arg1.workInKJDefined) 
            {
                arg2[":workInKJ"] = arg1.workInKJ;
            }
            if (arg1.powerZoneDefined) 
            {
                arg2[":powerZone"] = arg1.powerZone;
            }
            if (arg1.isActiveDefined) 
            {
                arg2[":motionPoints"] = arg1.isActive ? 1 : 0;
            }
            if (arg1.stepsDefined) 
            {
                arg2[":stepsLow"] = arg1.steps;
            }
            if (arg1.stepTypeDefined) 
            {
                arg2[":stepsMedium"] = arg1.stepType;
            }
            if (arg1.sleepPhaseDefined) 
            {
                arg2[":stepsHigh"] = arg1.sleepPhase;
            }
            if (arg1.activeHourDefined) 
            {
                arg2[":activTimeLow"] = arg1.activeHour;
            }
            if (arg1.timeStartDefined) 
            {
                arg2[":timeStart"] = utils.date.DateUtilCommon.dateToMySqlFormat(arg1.timeStart);
            }
            if (arg1.phaseNumberDefined) 
            {
                arg2[":phaseNumber"] = arg1.phaseNumber;
            }
            if (arg1.timeBelowIntensityZonesDefined) 
            {
                arg2[":timeBelowIntensityZones"] = arg1.timeBelowIntensityZones;
            }
            if (arg1.timeInIntensityZone1Defined) 
            {
                arg2[":timeInIntensityZone1"] = arg1.timeInIntensityZone1;
            }
            if (arg1.timeInIntensityZone2Defined) 
            {
                arg2[":timeInIntensityZone2"] = arg1.timeInIntensityZone2;
            }
            if (arg1.timeInIntensityZone3Defined) 
            {
                arg2[":timeInIntensityZone3"] = arg1.timeInIntensityZone3;
            }
            if (arg1.timeInIntensityZone4Defined) 
            {
                arg2[":timeInIntensityZone4"] = arg1.timeInIntensityZone4;
            }
            if (arg1.timeAboveIntensityZonesDefined) 
            {
                arg2[":timeAboveIntensityZones"] = arg1.timeAboveIntensityZones;
            }
            if (arg1.timeInPowerZone1Defined) 
            {
                arg2[":timeInPowerZone1"] = arg1.timeInPowerZone1;
            }
            if (arg1.timeInPowerZone2Defined) 
            {
                arg2[":timeInPowerZone2"] = arg1.timeInPowerZone2;
            }
            if (arg1.timeInPowerZone3Defined) 
            {
                arg2[":timeInPowerZone3"] = arg1.timeInPowerZone3;
            }
            if (arg1.timeInPowerZone4Defined) 
            {
                arg2[":timeInPowerZone4"] = arg1.timeInPowerZone4;
            }
            if (arg1.timeInPowerZone5Defined) 
            {
                arg2[":timeInPowerZone5"] = arg1.timeInPowerZone5;
            }
            if (arg1.timeInPowerZone6Defined) 
            {
                arg2[":timeInPowerZone6"] = arg1.timeInPowerZone6;
            }
            if (arg1.timeInPowerZone7Defined) 
            {
                arg2[":timeInPowerZone7"] = arg1.timeInPowerZone7;
            }
            if (arg1.timeBelowTargetZoneDefined) 
            {
                arg2[":timeBelowTargetZone"] = arg1.timeBelowTargetZone;
            }
            if (arg1.timeInTargetZoneDefined) 
            {
                arg2[":timeInTargetZone"] = arg1.timeInTargetZone;
            }
            if (arg1.timeAboveTargetZoneDefined) 
            {
                arg2[":timeAboveTargetZone"] = arg1.timeAboveTargetZone;
            }
            if (arg1.pedalingTimeDefined) 
            {
                arg2[":pedalingTime"] = arg1.pedalingTime;
            }
            return;
        }

        public static function getInsertStatement(arg1:Array):String
        {
            return "INSERT OR REPLACE INTO ActivityEntry (" + arg1.toString() + ") VALUES (:" + arg1.join(", :") + ");";
        }

        public static function generateXML(arg1:core.activities.ActivityEntry):XML
        {
            var loc1:*=new XML("<Entry/>");
            if (arg1.altitudeDefined) 
            {
                var loc2:*;
                loc1.@altitude = loc2 = arg1.altitude;
            }
            undefined;
            if (arg1.altitudeDifferencesDownhillDefined) 
            {
                loc1.@altitudeDifferencesDownhill = loc2 = arg1.altitudeDifferencesDownhill;
            }
            undefined;
            if (arg1.altitudeDifferencesUphillDefined) 
            {
                loc1.@altitudeDifferencesUphill = loc2 = arg1.altitudeDifferencesUphill;
            }
            undefined;
            if (arg1.cadenceDefined) 
            {
                loc1.@cadence = loc2 = arg1.cadence;
            }
            undefined;
            if (arg1.caloriesDefined) 
            {
                loc1.@calories = loc2 = arg1.calories;
            }
            undefined;
            if (arg1.distanceAbsoluteDefined) 
            {
                loc1.@distanceAbsolute = loc2 = arg1.distanceAbsolute;
            }
            undefined;
            if (arg1.distanceDefined) 
            {
                loc1.@distance = loc2 = arg1.distance;
            }
            undefined;
            if (arg1.distanceDownhillDefined) 
            {
                loc1.@distanceDownhill = loc2 = arg1.distanceDownhill;
            }
            undefined;
            if (arg1.distanceUphillDefined) 
            {
                loc1.@distanceUphill = loc2 = arg1.distanceUphill;
            }
            undefined;
            if (arg1.heartrateDefined) 
            {
                loc1.@heartrate = loc2 = arg1.heartrate;
            }
            undefined;
            if (arg1.inclineDefined) 
            {
                loc1.@incline = loc2 = arg1.incline;
            }
            undefined;
            if (arg1.intensityZoneDefined) 
            {
                loc1.@intensityZone = loc2 = arg1.intensityZone;
            }
            undefined;
            if (arg1.latitudeDefined) 
            {
                loc1.@latitude = loc2 = arg1.latitude;
            }
            undefined;
            if (arg1.longitudeDefined) 
            {
                loc1.@longitude = loc2 = arg1.longitude;
            }
            undefined;
            if (arg1.percentHRMaxDefined) 
            {
                loc1.@percentHRMax = loc2 = arg1.percentHRMax;
            }
            undefined;
            if (arg1.powerDefined) 
            {
                loc1.@power = loc2 = arg1.power;
            }
            undefined;
            if (arg1.powerPerKGDefined) 
            {
                loc1.@powerPerKG = loc2 = arg1.powerPerKG;
            }
            undefined;
            if (arg1.relativeRotationsDefined) 
            {
                loc1.@relativeRotations = loc2 = arg1.relativeRotations;
            }
            undefined;
            if (arg1.riseRateDefined) 
            {
                loc1.@riseRate = loc2 = arg1.riseRate;
            }
            undefined;
            if (arg1.rotationsDefined) 
            {
                loc1.@rotations = loc2 = arg1.rotations;
            }
            undefined;
            if (arg1.speedDefined) 
            {
                loc1.@speed = loc2 = arg1.speed;
            }
            undefined;
            if (arg1.speedReferenceDefined) 
            {
                loc1.@speedReference = loc2 = arg1.speedReference;
            }
            undefined;
            if (arg1.speedTimeDefined) 
            {
                loc1.@speedTime = loc2 = arg1.speedTime;
            }
            undefined;
            if (arg1.targetZoneDefined) 
            {
                loc1.@targetZone = loc2 = arg1.targetZone;
            }
            undefined;
            if (arg1.temperatureDefined) 
            {
                loc1.@temperature = loc2 = arg1.temperature;
            }
            undefined;
            loc1.@trainingTime = arg1.trainingTime;
            loc1.@trainingTimeAbsolute = arg1.trainingTimeAbsolute;
            if (arg1.trainingTimeDownhillDefined) 
            {
                loc1.@trainingTimeDownhill = loc2 = arg1.trainingTimeDownhill;
            }
            undefined;
            if (arg1.trainingTimeUphillDefined) 
            {
                loc1.@trainingTimeUphill = loc2 = arg1.trainingTimeUphill;
            }
            undefined;
            if (arg1.workInKJDefined) 
            {
                loc1.@workInKJ = loc2 = arg1.workInKJ;
            }
            undefined;
            if (arg1.zoneDefined) 
            {
                loc1.@zone = loc2 = arg1.zone;
            }
            undefined;
            if (arg1.powerZoneDefined) 
            {
                loc1.@powerZone = loc2 = arg1.powerZone;
            }
            undefined;
            if (arg1.stepsDefined) 
            {
                loc1.@steps = loc2 = arg1.steps;
            }
            undefined;
            if (arg1.stepTypeDefined) 
            {
                loc1.@stepType = loc2 = arg1.stepType;
            }
            undefined;
            if (arg1.sleepPhaseDefined) 
            {
                loc1.@sleepPhase = loc2 = arg1.sleepPhase;
            }
            undefined;
            if (arg1.activeHourDefined) 
            {
                loc1.@activeHour = loc2 = arg1.activeHour;
            }
            undefined;
            if (arg1.timeStartDefined) 
            {
                loc1.@timeStart = loc2 = utils.date.DateUtilCommon.dateToMySqlFormat(arg1.timeStart);
            }
            undefined;
            if (arg1.isActiveDefined) 
            {
                loc1.@isActive = loc2 = arg1.isActive ? 1 : 0;
            }
            undefined;
            if (arg1.phaseNumberDefined) 
            {
                loc1.@phaseNumber = loc2 = arg1.phaseNumber;
            }
            undefined;
            if (arg1.normalizedPowerDefined) 
            {
                loc1.@normalizedPower = loc2 = arg1.normalizedPower;
            }
            undefined;
            if (arg1.rightBalanceDefined) 
            {
                loc1.@rightBalance = loc2 = arg1.rightBalance;
            }
            undefined;
            if (arg1.leftBalanceDefined) 
            {
                loc1.@leftBalance = loc2 = arg1.leftBalance;
            }
            undefined;
            if (arg1.timeBelowIntensityZonesDefined) 
            {
                loc1.@timeBelowIntensityZones = loc2 = arg1.timeBelowIntensityZones;
            }
            undefined;
            if (arg1.timeInIntensityZone1Defined) 
            {
                loc1.@timeInIntensityZone1 = loc2 = arg1.timeInIntensityZone1;
            }
            undefined;
            if (arg1.timeInIntensityZone2Defined) 
            {
                loc1.@timeInIntensityZone2 = loc2 = arg1.timeInIntensityZone2;
            }
            undefined;
            if (arg1.timeInIntensityZone3Defined) 
            {
                loc1.@timeInIntensityZone3 = loc2 = arg1.timeInIntensityZone3;
            }
            undefined;
            if (arg1.timeInIntensityZone4Defined) 
            {
                loc1.@timeInIntensityZone4 = loc2 = arg1.timeInIntensityZone4;
            }
            undefined;
            if (arg1.timeAboveIntensityZonesDefined) 
            {
                loc1.@timeAboveIntensityZones = loc2 = arg1.timeAboveIntensityZones;
            }
            undefined;
            if (arg1.timeInPowerZone1Defined) 
            {
                loc1.@timeInPowerZone1 = loc2 = arg1.timeInPowerZone1;
            }
            undefined;
            if (arg1.timeInPowerZone2Defined) 
            {
                loc1.@timeInPowerZone2 = loc2 = arg1.timeInPowerZone2;
            }
            undefined;
            if (arg1.timeInPowerZone3Defined) 
            {
                loc1.@timeInPowerZone3 = loc2 = arg1.timeInPowerZone3;
            }
            undefined;
            if (arg1.timeInPowerZone4Defined) 
            {
                loc1.@timeInPowerZone4 = loc2 = arg1.timeInPowerZone4;
            }
            undefined;
            if (arg1.timeInPowerZone5Defined) 
            {
                loc1.@timeInPowerZone5 = loc2 = arg1.timeInPowerZone5;
            }
            undefined;
            if (arg1.timeInPowerZone6Defined) 
            {
                loc1.@timeInPowerZone6 = loc2 = arg1.timeInPowerZone6;
            }
            undefined;
            if (arg1.timeInPowerZone7Defined) 
            {
                loc1.@timeInPowerZone7 = loc2 = arg1.timeInPowerZone7;
            }
            undefined;
            if (arg1.timeBelowTargetZoneDefined) 
            {
                loc1.@timeBelowTargetZone = loc2 = arg1.timeBelowTargetZone;
            }
            undefined;
            if (arg1.timeInTargetZoneDefined) 
            {
                loc1.@timeInTargetZone = loc2 = arg1.timeInTargetZone;
            }
            undefined;
            if (arg1.timeAboveTargetZoneDefined) 
            {
                loc1.@timeAboveTargetZone = loc2 = arg1.timeAboveTargetZone;
            }
            undefined;
            if (arg1.pedalingTimeDefined) 
            {
                loc1.@pedalingTime = loc2 = arg1.pedalingTime;
            }
            undefined;
            return loc1;
        }

        internal static function fromXML200To210(arg1:XML, arg2:core.activities.ActivityEntry, arg3:core.activities.ActivityEntry):core.activities.ActivityEntry
        {
            var loc1:*;
            if ((loc1 = arg1.Altitude).length() == 1) 
            {
                arg1.Altitude = loc1[0] * 1000;
            }
            if ((loc1 = arg1.RiseRate).length() == 1) 
            {
                arg1.RiseRate = loc1[0] * 1000;
            }
            if ((loc1 = arg1.AltitudeDifferenceDownhill).length() == 1) 
            {
                arg1.AltitudeDifferenceDownhill = loc1[0] * 1000;
            }
            if ((loc1 = arg1.AltitudeDifferenceUphill).length() == 1) 
            {
                arg1.AltitudeDifferenceUphill = loc1[0] * 1000;
            }
            return fromXML300To330(arg1, arg2, arg3);
        }

        internal static function fromXML300To330(arg1:XML, arg2:core.activities.ActivityEntry, arg3:core.activities.ActivityEntry):core.activities.ActivityEntry
        {
            var loc1:*=undefined;
            if (arg2 != null) 
            {
                arg3.number = arg2.number + 1;
            }
            else 
            {
                arg3.number = 0;
            }
            loc1 = arg1.Altitude;
            var loc2:*;
            arg3.altitudeDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.altitude = loc1;
            }
            loc1 = arg1.AltitudeDifferenceDownhill;
            arg3.altitudeDifferencesDownhillDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.altitudeDifferencesDownhill = loc1;
            }
            loc1 = arg1.AltitudeDifferenceUphill;
            arg3.altitudeDifferencesUphillDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.altitudeDifferencesUphill = loc1;
            }
            loc1 = arg1.Cadence;
            arg3.cadenceDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.cadence = loc1;
            }
            loc1 = arg1.Calories;
            arg3.caloriesDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.calories = loc1;
            }
            loc1 = arg1.Distance;
            arg3.distanceDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.distance = loc1;
            }
            loc1 = arg1.DistanceAbsolute;
            arg3.distanceAbsoluteDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                if (!(arg2 == null) && arg3.distanceDefined) 
                {
                    arg3.distanceAbsolute = arg3.distance + arg2.distanceAbsolute;
                }
                else if (arg3.distanceDefined) 
                {
                    arg3.distanceAbsolute = arg3.distance;
                }
                else 
                {
                    arg3.distanceAbsolute = loc1;
                }
            }
            if (!(arg1.RideTime == undefined) != true) 
            {
                if (arg1.Time != undefined) 
                {
                    arg3.trainingTime = arg1.Time;
                }
            }
            else 
            {
                arg3.trainingTime = arg1.RideTime;
            }
            if (arg2 == null) 
            {
                arg3.trainingTimeAbsolute = arg3.trainingTime;
            }
            else 
            {
                arg3.trainingTimeAbsolute = arg3.trainingTime + arg2.trainingTimeAbsolute;
            }
            arg3.trainingTime = arg3.trainingTime * 100;
            arg3.trainingTimeAbsolute = arg3.trainingTimeAbsolute * 100;
            loc1 = arg1.DistanceDownhill;
            arg3.distanceDownhillDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.distanceDownhill = loc1;
            }
            loc1 = arg1.DistanceUphill;
            arg3.distanceUphillDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.distanceUphill = loc1;
            }
            loc1 = arg1.Heartrate;
            arg3.heartrateDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.heartrate = loc1;
            }
            loc1 = arg1.Incline;
            arg3.inclineDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.incline = loc1;
            }
            loc1 = arg1.IntensityZone;
            arg3.intensityZoneDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.intensityZone = loc1;
            }
            loc1 = arg1.Latitude;
            arg3.latitudeDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.latitude = loc1;
            }
            loc1 = arg1.Longitude;
            arg3.longitudeDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.longitude = loc1;
            }
            if (arg1.IsPause == "true") 
            {
                arg3.isPause = true;
            }
            loc1 = arg1.PercentHRMax;
            arg3.percentHRMaxDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.percentHRMax = loc1;
            }
            loc1 = arg1.Power;
            arg3.powerDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.power = loc1;
            }
            loc1 = arg1.PowerPerKG;
            arg3.powerPerKGDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.powerPerKG = loc1;
            }
            loc1 = arg1.RelativeRotations;
            arg3.relativeRotationsDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.relativeRotations = loc1;
            }
            loc1 = arg1.RideTimeDownhill;
            arg3.trainingTimeDownhillDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.trainingTimeDownhill = loc1;
                arg3.trainingTimeDownhill = arg3.trainingTimeDownhill * 100;
            }
            loc1 = arg1.RideTimeUphill;
            arg3.trainingTimeUphillDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.trainingTimeUphill = loc1;
                arg3.trainingTimeUphill = arg3.trainingTimeUphill * 100;
            }
            loc1 = arg1.RiseRate;
            arg3.riseRateDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.riseRate = loc1;
            }
            loc1 = arg1.Rotations;
            arg3.rotationsDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.rotations = loc1;
            }
            loc1 = arg1.Speed;
            arg3.speedDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.speed = loc1;
            }
            loc1 = arg1.SpeedReference;
            arg3.speedReferenceDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.speedReference = loc1;
            }
            loc1 = arg1.SpeedTime;
            arg3.speedTimeDefined = loc2 = !(loc1 == undefined);
            if (loc2 != true) 
            {
                if (arg3.speedDefined) 
                {
                    arg3.speedTime = utils.Calculations.calculateSpeedTime(arg3.speed);
                    arg3.speedTimeDefined = true;
                }
            }
            else 
            {
                arg3.speedTime = loc1;
            }
            loc1 = arg1.TargetZone;
            arg3.targetZoneDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.targetZone = loc1;
            }
            loc1 = arg1.Temperature;
            arg3.temperatureDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.temperature = loc1;
            }
            if (arg1.IsWaypoint == "true") 
            {
                arg3.isWaypoint = true;
            }
            loc1 = arg1.WorkInKJ;
            arg3.workInKJDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.workInKJ = loc1;
            }
            loc1 = arg1.Zone;
            arg3.zoneDefined = loc2 = !(loc1 == undefined);
            if (loc2 == true) 
            {
                arg3.zone = loc1;
            }
            return arg3;
        }

        public static const col_calories:String="calories";

        public static const col_distance:String="distance";

        public static const col_distanceAbsolute:String="distanceAbsolute";

        public static const col_distanceDownhill:String="distanceDownhill";

        public static const col_distanceUphill:String="distanceUphill";

        public static const col_heartrate:String="heartrate";

        public static const col_incline:String="incline";

        public static const col_intensityZone:String="intensityZone";

        public static const col_isActive:String="motionPoints";

        public static const col_latitude:String="latitude";

        public static const col_leftBalance:String="leftBalance";

        public static const col_longitude:String="longitude";

        public static const col_normalizedPower:String="normalizedPower";

        public static const col_pedalingTime:String="pedalingTime";

        public static const col_percentHRMax:String="percentHRMax";

        public static const col_phaseNumber:String="phaseNumber";

        public static const col_power:String="power";

        public static const col_powerPerKG:String="powerPerKG";

        public static const col_powerZone:String="powerZone";

        public static const col_relativeRotations:String="relativeRotations";

        public static const col_rightBalance:String="rightBalance";

        public static const col_riseRate:String="riseRate";

        public static const col_rotations:String="rotations";

        public static const col_sleepPhase:String="stepsHigh";

        public static const col_speed:String="speed";

        public static const col_speedReference:String="speedReference";

        public static const col_stepType:String="stepsMedium";

        public static const col_altitude:String="altitude";

        public static const col_targetZone:String="targetZone";

        public static const col_temperature:String="temperature";

        public static const col_timeAboveIntensityZones:String="timeAboveIntensityZones";

        public static const col_timeAboveTargetZone:String="timeAboveTargetZone";

        public static const col_timeBelowIntensityZones:String="timeBelowIntensityZones";

        public static const col_timeBelowTargetZone:String="timeBelowTargetZone";

        public static const col_timeInIntensityZone1:String="timeInIntensityZone1";

        public static const col_timeInIntensityZone2:String="timeInIntensityZone2";

        public static const col_timeInIntensityZone3:String="timeInIntensityZone3";

        public static const col_timeInIntensityZone4:String="timeInIntensityZone4";

        public static const col_timeInPowerZone1:String="timeInPowerZone1";

        public static const col_timeInPowerZone2:String="timeInPowerZone2";

        public static const col_timeInPowerZone3:String="timeInPowerZone3";

        public static const col_timeInPowerZone4:String="timeInPowerZone4";

        public static const col_timeInPowerZone5:String="timeInPowerZone5";

        public static const col_timeInPowerZone6:String="timeInPowerZone6";

        public static const col_timeInPowerZone7:String="timeInPowerZone7";

        public static const col_timeInTargetZone:String="timeInTargetZone";

        public static const col_timeStart:String="timeStart";

        public static const col_trainingTimeAbsolute:String="trainingTimeAbsolute";

        public static const col_trainingTimeDownhill:String="trainingTimeDownhill";

        public static const col_trainingTimeUphill:String="trainingTimeUphill";

        public static const col_workInKJ:String="workInKJ";

        public static const col_zone:String="zone";

        public static const field_phaseNumber:String="phaseNumber";

        public static const table_name:String="ActivityEntry";

        public static const col_steps:String="stepsLow";

        public static const col_activTimeHeigh:String="activTimeHigh";

        public static const col_activTimeMedium:String="activTimeMedium";

        public static const col_activeHour:String="activTimeLow";

        public static const col_activityEntryId:String="activityEntryId";

        public static const col_activityId:String="activityId";

        public static const col_altitudeDifferencesDownhill:String="altitudeDifferencesDownhill";

        public static const col_altitudeDifferencesUphill:String="altitudeDifferencesUphill";

        public static const col_cadence:String="cadence";

        public static const col_trainingTime:String="trainingTime";

        public static var DB_TABLE_500:database.DatabaseTable;

        public static var DB_TABLE_520:database.DatabaseTable;

        public static var DB_TABLE_400:database.DatabaseTable;

        public static var DB_TABLE_510:database.DatabaseTable;
    }
}


//  class ActivityFactory
package core.activities 
{
    import __AS3__.vec.*;
    import configCache.*;
    import core.general.*;
    import core.tcx.*;
    import init.*;
    
    public class ActivityFactory extends Object
    {
        public function ActivityFactory()
        {
            super();
            return;
        }

        public static function createLogEntryFromLog(arg1:core.activities.Activity):core.activities.ActivityEntry
        {
            var loc1:*=new core.activities.ActivityEntry(INSTANCE_CHECK_OBJECT);
            if (arg1.unitType) 
            {
                configEntryDefinitions(loc1, arg1.unitType, arg1.logType);
            }
            loc1.logReference = arg1;
            return loc1;
        }

        public static function createLogFromDB(arg1:Object, arg2:Boolean=false):core.activities.Activity
        {
            return core.activities.ActivityMapper.fromDB(new core.activities.Activity(INSTANCE_CHECK_OBJECT), arg1, arg2);
        }

        public static function createLogFromFIT(arg1:__AS3__.vec.Vector.<Object>):core.activities.Activity
        {
            var loc1:*=new core.activities.Activity(INSTANCE_CHECK_OBJECT);
            loc1.sport = init.BackendInitializer.getInstance().getSportHandler().resolveSportByType(null);
            return loc1;
        }

        public static function createLogFromTcx(arg1:XML, arg2:Boolean=true):core.activities.Activity
        {
            var loc1:*=new core.activities.Activity(INSTANCE_CHECK_OBJECT);
            return core.tcx.ActivityTCXMapper.fromTCX(arg1, loc1, INSTANCE_CHECK_OBJECT);
        }

        public static function createLogFromSLF(arg1:XML, arg2:Boolean=false):core.activities.Activity
        {
            var loc2:*=null;
            var loc1:*=core.general.UnitType.fromString(arg1.Computer.@unit);
            var loc4:*=arg1.@revision;
            var loc3:*=new core.activities.Activity(INSTANCE_CHECK_OBJECT);
            if (!(loc4 == 0) && loc4 < 400) 
            {
                loc2 = null;
                if (core.general.UnitType.ROX50 == loc1 || core.general.UnitType.ROX60 == loc1) 
                {
                    loc2 = core.general.LogType.fromString(arg1.GeneralInformation.@logType);
                }
                if (loc1) 
                {
                    configActivityDefinitions(loc3, loc1, loc2);
                }
            }
            loc3.sport = init.BackendInitializer.getInstance().getSportHandler().resolveSportByKeyName(arg1.GeneralInformation.sport);
            return core.activities.ActivityMapper.fromXML(arg1, loc3, arg2);
        }

        public static function createActivityFromUnitType(arg1:core.general.UnitType, arg2:String, arg3:core.general.LogType=null):core.activities.Activity
        {
            var loc1:*;
            (loc1 = new core.activities.Activity(INSTANCE_CHECK_OBJECT)).unitType = arg1;
            loc1.dataType = arg2;
            loc1.logType = arg3;
            configActivityDefinitions(loc1, arg1, arg3);
            loc1.sport = init.BackendInitializer.getInstance().getSportHandler().resolveSportByType(arg1);
            return loc1;
        }

        public static function isCreatedByFactory(arg1:Object):Boolean
        {
            return INSTANCE_CHECK_OBJECT == arg1;
        }

        public static function applyZoneValues(arg1:core.activities.Activity, arg2:Boolean, arg3:Boolean):void
        {
            var loc2:*=null;
            var loc1:*=null;
            if (arg1 == null) 
            {
                return;
            }
            if (arg2 && arg1.hrMaxDefined) 
            {
                loc2 = configCache.ConfigCache.getInstance().getIntensityZoneValue(arg1.sport);
                arg1.intensityZone1Start = arg1.hrMax * loc2.intensityZone1Start / 100;
                arg1.intensityZone1StartDefined = true;
                arg1.intensityZone2Start = arg1.hrMax * loc2.intensityZone2Start / 100;
                arg1.intensityZone2StartDefined = true;
                arg1.intensityZone3Start = arg1.hrMax * loc2.intensityZone3Start / 100;
                arg1.intensityZone3StartDefined = true;
                arg1.intensityZone4Start = arg1.hrMax * loc2.intensityZone4Start / 100;
                arg1.intensityZone4StartDefined = true;
                arg1.intensityZone4End = arg1.hrMax * loc2.intensityZone4End / 100;
                arg1.intensityZone4EndDefined = true;
            }
            if (arg3) 
            {
                loc1 = configCache.ConfigCache.getInstance().getPowerZoneValue(arg1.sport);
                arg1.powerZone1Start = loc1.pZone1Start;
                arg1.powerZone1StartDefined = true;
                arg1.powerZone2Start = loc1.pZone2Start;
                arg1.powerZone2StartDefined = true;
                arg1.powerZone3Start = loc1.pZone3Start;
                arg1.powerZone3StartDefined = true;
                arg1.powerZone4Start = loc1.pZone4Start;
                arg1.powerZone4StartDefined = true;
                arg1.powerZone5Start = loc1.pZone5Start;
                arg1.powerZone5StartDefined = true;
                arg1.powerZone6Start = loc1.pZone6Start;
                arg1.powerZone6StartDefined = true;
                arg1.powerZone7Start = loc1.pZone7Start;
                arg1.powerZone7StartDefined = true;
                arg1.powerZone7End = loc1.pZone7End;
                arg1.powerZone7EndDefined = true;
            }
            return;
        }

        internal static function configActivityDefinitions(arg1:core.activities.Activity, arg2:core.general.UnitType, arg3:core.general.LogType=null):void
        {
            var loc1:*=false;
            var loc2:*=arg2;
            while (core.general.UnitType.ROX8.toString() === loc2) 
            {
                if (arg1.dataType != "memory") 
                {
                    arg1.logType = core.general.LogType.CYCLING;
                    arg1.altitudeDifferencesDownhillDefined = true;
                    arg1.altitudeDifferencesUphillDefined = true;
                    arg1.averageAltitudeDefined = true;
                    arg1.averageHeartrateDefined = true;
                    arg1.averageInclineUphillDefined = true;
                    arg1.averageInclineDownhillDefined = true;
                    arg1.averageRiseRateDefined = true;
                    arg1.averageRiseRateUphillDefined = true;
                    arg1.averageRiseRateDownhillDefined = true;
                    arg1.averageTemperatureDefined = true;
                    arg1.caloriesDefined = true;
                    arg1.caloriesDifferenceFactorDefined = true;
                    arg1.distanceDownhillDefined = true;
                    arg1.distanceUphillDefined = true;
                    arg1.hrMaxDefined = true;
                    arg1.intensityZone1StartDefined = true;
                    arg1.intensityZone2StartDefined = true;
                    arg1.intensityZone3StartDefined = true;
                    arg1.intensityZone4EndDefined = true;
                    arg1.intensityZone4StartDefined = true;
                    arg1.maximumAltitudeDefined = true;
                    arg1.maximumHeartrateDefined = true;
                    arg1.maximumInclineDefined = true;
                    arg1.maximumRiseRateDefined = true;
                    arg1.maximumTemperatureDefined = true;
                    arg1.minimumAltitudeDefined = true;
                    arg1.minimumHeartrateDefined = true;
                    arg1.minimumInclineDefined = true;
                    arg1.minimumRiseRateDefined = true;
                    arg1.minimumTemperatureDefined = true;
                    arg1.timeInIntensityZone1Defined = true;
                    arg1.timeInIntensityZone2Defined = true;
                    arg1.timeInIntensityZone3Defined = true;
                    arg1.timeInIntensityZone4Defined = true;
                    arg1.timeInZone1Defined = true;
                    arg1.timeInZone2Defined = true;
                    arg1.timeInZone3Defined = true;
                    arg1.timeInZoneDefined = true;
                    arg1.timeOverIntensityZoneDefined = true;
                    arg1.timeOverZoneDefined = true;
                    arg1.timeUnderIntensityZoneDefined = true;
                    arg1.timeUnderZoneDefined = true;
                    arg1.trainingTimeDownhillDefined = true;
                    arg1.trainingTimeUphillDefined = true;
                    arg1.zone1StartDefined = true;
                    arg1.zone2StartDefined = true;
                    arg1.zone3EndDefined = true;
                    arg1.zone3StartDefined = true;
                    arg1.distanceDefined = true;
                    arg1.minimumSpeedDefined = true;
                    arg1.maximumSpeedDefined = true;
                    arg1.averageSpeedDefined = true;
                    arg1.averageSpeedDownhillDefined = true;
                    arg1.averageSpeedUphillDefined = true;
                    arg1.wheelSizeDefined = true;
                    arg1.speedUnitDefined = true;
                }
                else 
                {
                    arg1.logType = core.general.LogType.CYCLING;
                    arg1.averageCadenceDefined = true;
                    arg1.maximumCadenceDefined = true;
                    arg1.altitudeDifferencesDownhillDefined = true;
                    arg1.altitudeDifferencesUphillDefined = true;
                    arg1.averageHeartrateDefined = true;
                    arg1.averageInclineUphillDefined = true;
                    arg1.averageInclineDownhillDefined = true;
                    arg1.averageRiseRateUphillDefined = true;
                    arg1.averageRiseRateDownhillDefined = true;
                    arg1.caloriesDefined = true;
                    arg1.distanceDownhillDefined = true;
                    arg1.distanceUphillDefined = true;
                    arg1.hrMaxDefined = true;
                    arg1.maximumAltitudeDefined = true;
                    arg1.maximumHeartrateDefined = true;
                    arg1.maximumInclineDownhillDefined = true;
                    arg1.maximumRiseRateDefined = true;
                    arg1.maximumTemperatureDefined = true;
                    arg1.maximumInclineUphillDefined = true;
                    arg1.minimumRiseRateDefined = true;
                    arg1.minimumTemperatureDefined = true;
                    arg1.timeInZone1Defined = true;
                    arg1.timeInZone2Defined = true;
                    arg1.timeInZone3Defined = true;
                    arg1.timeOverZoneDefined = true;
                    arg1.timeUnderZoneDefined = true;
                    arg1.trainingTimeDownhillDefined = true;
                    arg1.trainingTimeUphillDefined = true;
                    arg1.zone1StartDefined = true;
                    arg1.zone2StartDefined = true;
                    arg1.zone3EndDefined = true;
                    arg1.zone3StartDefined = true;
                    arg1.timeInZoneDefined = true;
                    arg1.distanceDefined = true;
                    arg1.maximumSpeedDefined = true;
                    arg1.averageSpeedDefined = true;
                    arg1.averageSpeedDownhillDefined = true;
                    arg1.averageSpeedUphillDefined = true;
                    arg1.wheelSizeDefined = true;
                    arg1.speedUnitDefined = true;
                }
            }
        }

        internal static function configEntryDefinitions(arg1:core.activities.ActivityEntry, arg2:core.general.UnitType, arg3:core.general.LogType=null):void
        {
            var loc1:*=arg2;
            while (core.general.UnitType.ROX100.toString() === loc1) 
            {
                arg1.distanceDefined = true;
                arg1.distanceAbsoluteDefined = true;
                arg1.distanceUphillDefined = true;
                arg1.distanceDownhillDefined = true;
                arg1.trainingTimeUphillDefined = true;
                arg1.trainingTimeDownhillDefined = true;
                arg1.heartrateDefined = true;
                arg1.speedDefined = true;
                arg1.speedTimeDefined = true;
                arg1.speedReferenceDefined = true;
                arg1.inclineDefined = true;
                arg1.riseRateDefined = true;
                arg1.altitudeDefined = true;
                arg1.altitudeDifferencesUphillDefined = true;
                arg1.altitudeDifferencesDownhillDefined = true;
                arg1.temperatureDefined = true;
                arg1.cadenceDefined = true;
                arg1.powerDefined = true;
                arg1.powerPerKGDefined = true;
                arg1.intensityZoneDefined = true;
                arg1.targetZoneDefined = true;
                arg1.latitudeDefined = true;
                arg1.longitudeDefined = true;
                arg1.caloriesDefined = true;
                arg1.percentHRMaxDefined = true;
                arg1.workInKJDefined = true;
            }
        }

        internal static const INSTANCE_CHECK_OBJECT:Object={};
    }
}


//  class ActivityMapper
package core.activities 
{
    import __AS3__.vec.*;
    import core.general.*;
    import core.marker.*;
    import core.participant.*;
    import core.user.*;
    import database.*;
    import handler.*;
    import init.*;
    import utils.*;
    import utils.date.*;
    import utils.format.*;
    
    public class ActivityMapper extends Object
    {
        public function ActivityMapper()
        {
            super();
            return;
        }

        public static function getInsertStatement(arg1:Array):String
        {
            return "INSERT OR REPLACE INTO Activity (" + arg1.toString() + ") VALUES (:" + arg1.join(", :") + ");";
        }

        public static function selectPrimaryKeyFromGUID(arg1:core.activities.Activity):String
        {
            return "SELECT activityId FROM Activity WHERE GUID = \'" + arg1.GUID + "\'";
        }

        public static function getTable(arg1:uint):database.DatabaseTable
        {
            var loc1:*=null;
            var loc2:*=arg1;
            while (400 === loc2) 
            {
                loc1 = DB_TABLE_400;
            }
        }

        internal static function loadMarkers(arg1:XML, arg2:core.activities.Activity, arg3:int):void
        {
            var loc4:*=null;
            var loc3:*=0;
            arg2.markerList.splice(0, arg2.markerList.length);
            if (arg3 != 210) 
            {
                if (arg3 >= 300) 
                {
                    loc4 = arg1.Markers.Marker;
                }
                else 
                {
                    return;
                }
            }
            else 
            {
                loc4 = arg1.Laps.Lap;
            }
            var loc1:*=loc4.length();
            var loc2:*=null;
            loc3 = 0;
            while (loc3 < loc1) 
            {
                loc2 = core.marker.MarkerMapper.fromXML(loc4[loc3], loc2, arg3, arg2);
                arg2.markerList.push(loc2);
                ++loc3;
            }
            return;
        }

        public static function countActivitiesStatement(arg1:String=""):String
        {
            return "SELECT COUNT(*) AS activities FROM Activity WHERE isDeleted = false" + arg1;
        }

        public static function fromDB(arg1:core.activities.Activity, arg2:Object, arg3:Boolean=false):core.activities.Activity
        {
            arg1.activityId = arg2["activityId"];
            if (arg2["simpleHeaderValuesCalculation"]) 
            {
                arg1.simpleHeaderValuesCalculation = arg2["simpleHeaderValuesCalculation"];
            }
            var loc1:*;
            arg1.ageDefined = loc1 = !(arg2["age"] == null);
            if (loc1 == true) 
            {
                arg1.age = arg2["age"];
            }
            if (arg2["GUID"] != null) 
            {
                arg1.GUID = arg2["GUID"];
            }
            if (arg2["modificationDate"] != null) 
            {
                arg1.modificationDate = arg2["modificationDate"];
            }
            if (arg2["activityStatus"] != null) 
            {
                arg1.activityStatus = arg2["activityStatus"];
            }
            arg1.altitudeDifferencesDownhillDefined = loc1 = !(arg2["altitudeDifferencesDownhill"] == null);
            if (loc1 == true) 
            {
                arg1.altitudeDifferencesDownhill = arg2["altitudeDifferencesDownhill"];
            }
            arg1.altitudeDifferencesUphillDefined = loc1 = !(arg2["altitudeDifferencesUphill"] == null);
            if (loc1 == true) 
            {
                arg1.altitudeDifferencesUphill = arg2["altitudeDifferencesUphill"];
            }
            arg1.averageAltitudeDefined = loc1 = !(arg2["averageAltitude"] == null);
            if (loc1 == true) 
            {
                arg1.averageAltitude = arg2["averageAltitude"];
            }
            arg1.averageCadenceDefined = loc1 = !(arg2["averageCadence"] == null);
            if (loc1 == true) 
            {
                arg1.averageCadence = arg2["averageCadence"];
            }
            arg1.averageExpansionDefined = loc1 = !(arg2["averageExpansion"] == null);
            if (loc1 == true) 
            {
                arg1.averageExpansion = arg2["averageExpansion"];
            }
            arg1.averageExpansionDownhillDefined = loc1 = !(arg2["averageExpansionDownhill"] == null);
            if (loc1 == true) 
            {
                arg1.averageExpansionDownhill = arg2["averageExpansionDownhill"];
            }
            arg1.averageExpansionUphillDefined = loc1 = !(arg2["averageExpansionUphill"] == null);
            if (loc1 == true) 
            {
                arg1.averageExpansionUphill = arg2["averageExpansionUphill"];
            }
            arg1.averageHeartrateDefined = loc1 = !(arg2["averageHeartrate"] == null);
            if (loc1 == true) 
            {
                arg1.averageHeartrate = arg2["averageHeartrate"];
            }
            arg1.averageInclineDownhillDefined = loc1 = !(arg2["averageInclineDownhill"] == null);
            if (loc1 == true) 
            {
                arg1.averageInclineDownhill = arg2["averageInclineDownhill"];
            }
            arg1.averageInclineUphillDefined = loc1 = !(arg2["averageInclineUphill"] == null);
            if (loc1 == true) 
            {
                arg1.averageInclineUphill = arg2["averageInclineUphill"];
            }
            arg1.averagePercentHRMaxDefined = loc1 = !(arg2["averagePercentHRMax"] == null);
            if (loc1 == true) 
            {
                arg1.averagePercentHRMax = arg2["averagePercentHRMax"];
            }
            arg1.averagePowerDefined = loc1 = !(arg2["averagePower"] == null);
            if (loc1 == true) 
            {
                arg1.averagePower = arg2["averagePower"];
            }
            arg1.averagePowerKJDefined = loc1 = !(arg2["averagePowerKJ"] == null);
            if (loc1 == true) 
            {
                arg1.averagePowerKJ = arg2["averagePowerKJ"];
            }
            arg1.averagePowerWattPerKGDefined = loc1 = !(arg2["averagePowerWattPerKG"] == null);
            if (loc1 == true) 
            {
                arg1.averagePowerWattPerKG = arg2["averagePowerWattPerKG"];
            }
            arg1.averageRiseRateDefined = loc1 = !(arg2["averageRiseRate"] == null);
            if (loc1 == true) 
            {
                arg1.averageRiseRate = arg2["averageRiseRate"];
            }
            arg1.averageRiseRateUphillDefined = loc1 = !(arg2["averageRiseRateUphill"] == null);
            if (loc1 == true) 
            {
                arg1.averageRiseRateUphill = arg2["averageRiseRateUphill"];
            }
            arg1.averageRiseRateDownhillDefined = loc1 = !(arg2["averageRiseRateDownhill"] == null);
            if (loc1 == true) 
            {
                arg1.averageRiseRateDownhill = arg2["averageRiseRateDownhill"];
            }
            arg1.averageSpeedDefined = loc1 = !(arg2["averageSpeed"] == null);
            if (loc1 == true) 
            {
                arg1.averageSpeed = arg2["averageSpeed"];
            }
            arg1.averageSpeedDownhillDefined = loc1 = !(arg2["averageSpeedDownhill"] == null);
            if (loc1 == true) 
            {
                arg1.averageSpeedDownhill = arg2["averageSpeedDownhill"];
            }
            arg1.averageSpeedUphillDefined = loc1 = !(arg2["averageSpeedUphill"] == null);
            if (loc1 == true) 
            {
                arg1.averageSpeedUphill = arg2["averageSpeedUphill"];
            }
            arg1.averageTemperatureDefined = loc1 = !(arg2["averageTemperature"] == null);
            if (loc1 == true) 
            {
                arg1.averageTemperature = arg2["averageTemperature"];
            }
            arg1.bike = arg2["bike"] == null ? "noBike" : arg2["bike"];
            arg1.bikeTypeDefined = loc1 = !(arg2["bikeType"] == null);
            if (loc1 == true) 
            {
                arg1.bikeType = arg2["bikeType"];
            }
            arg1.bikeWeightDefined = loc1 = !(arg2["bikeWeight"] == null);
            if (loc1 == true) 
            {
                arg1.bikeWeight = arg2["bikeWeight"];
            }
            arg1.bikeWeightUnitDefined = loc1 = !(arg2["bikeWeightUnit"] == null);
            if (loc1 == true) 
            {
                arg1.bikeWeightUnit = arg2["bikeWeightUnit"];
            }
            arg1.bodyHeightDefined = loc1 = !(arg2["bodyHeight"] == null);
            if (loc1 == true) 
            {
                arg1.bodyHeight = arg2["bodyHeight"];
            }
            arg1.bodyHeightUnitDefined = loc1 = !(arg2["bodyHeightUnit"] == null);
            if (loc1 == true) 
            {
                arg1.bodyHeightUnit = arg2["bodyHeightUnit"];
            }
            arg1.bodyWeightDefined = loc1 = !(arg2["bodyWeight"] == null);
            if (loc1 == true) 
            {
                arg1.bodyWeight = arg2["bodyWeight"];
            }
            arg1.bodyWeightUnitDefined = loc1 = !(arg2["bodyWeightUnit"] == null);
            if (loc1 == true) 
            {
                arg1.bodyWeightUnit = arg2["bodyWeightUnit"];
            }
            arg1.calibrationDefined = loc1 = !(arg2["calibration"] == null);
            if (loc1 == true) 
            {
                arg1.calibration = arg2["calibration"];
            }
            arg1.caloriesDefined = loc1 = !(arg2["calories"] == null);
            if (loc1 == true) 
            {
                arg1.calories = arg2["calories"];
            }
            arg1.caloriesDifferenceFactorDefined = loc1 = !(arg2["caloriesDifferenceFactor"] == null);
            if (loc1 == true) 
            {
                arg1.caloriesDifferenceFactor = arg2["caloriesDifferenceFactor"];
            }
            arg1.correctionChestRunDefined = loc1 = !(arg2["correctionChestRun"] == null);
            if (loc1 == true) 
            {
                arg1.correctionChestRun = arg2["correctionChestRun"];
            }
            arg1.correctionChestWalkDefined = loc1 = !(arg2["correctionChestWalk"] == null);
            if (loc1 == true) 
            {
                arg1.correctionChestWalk = arg2["correctionChestWalk"];
            }
            arg1.correctionFactorDefined = loc1 = !(arg2["correctionFactor"] == null);
            if (loc1 == true) 
            {
                arg1.correctionFactor = arg2["correctionFactor"];
            }
            arg1.correctionHipRunDefined = loc1 = !(arg2["correctionHipRun"] == null);
            if (loc1 == true) 
            {
                arg1.correctionHipRun = arg2["correctionHipRun"];
            }
            arg1.correctionHipWalkDefined = loc1 = !(arg2["correctionHipWalk"] == null);
            if (loc1 == true) 
            {
                arg1.correctionHipWalk = arg2["correctionHipWalk"];
            }
            arg1.dataType = arg2["dataType"];
            arg1.dateCodeDefined = loc1 = !(arg2["dateCode"] == null);
            if (loc1 == true) 
            {
                arg1.dateCode = arg2["dateCode"];
            }
            arg1.descriptionDefined = loc1 = !(arg2["description"] == null);
            if (loc1 == true) 
            {
                arg1.description = arg2["description"];
            }
            arg1.distanceDefined = loc1 = !(arg2["distance"] == null);
            if (loc1 == true) 
            {
                arg1.distance = arg2["distance"];
            }
            arg1.distanceDownhillDefined = loc1 = !(arg2["distanceDownhill"] == null);
            if (loc1 == true) 
            {
                arg1.distanceDownhill = arg2["distanceDownhill"];
            }
            arg1.distanceMinusDefined = loc1 = !(arg2["distanceMinus"] == null);
            if (loc1 == true) 
            {
                arg1.distanceMinus = arg2["distanceMinus"];
            }
            arg1.distancePlusDefined = loc1 = !(arg2["distancePlus"] == null);
            if (loc1 == true) 
            {
                arg1.distancePlus = arg2["distancePlus"];
            }
            arg1.distancePlusMinusStatusDefined = loc1 = !(arg2["distancePlusMinusStatus"] == null);
            if (loc1 == true) 
            {
                arg1.distancePlusMinusStatus = arg2["distancePlusMinusStatus"];
            }
            arg1.distanceUphillDefined = loc1 = !(arg2["distanceUphill"] == null);
            if (loc1 == true) 
            {
                arg1.distanceUphill = arg2["distanceUphill"];
            }
            arg1.exerciseTimeDefined = loc1 = !(arg2["exerciseTime"] == null);
            if (loc1 == true) 
            {
                arg1.exerciseTime = arg2["exerciseTime"];
            }
            arg1.externalLinkDefined = loc1 = !(arg2["externalLink"] == null);
            if (loc1 == true) 
            {
                arg1.externalLink = arg2["externalLink"];
            }
            arg1.fuelEconomyDefined = loc1 = !(arg2["fuelEconomy"] == null);
            if (loc1 == true) 
            {
                arg1.fuelEconomy = arg2["fuelEconomy"];
            }
            arg1.genderDefined = loc1 = !(arg2["gender"] == null);
            if (loc1 == true) 
            {
                arg1.gender = arg2["gender"];
            }
            arg1.hrMaxDefined = loc1 = !(arg2["hrMax"] == null);
            if (loc1 == true) 
            {
                arg1.hrMax = arg2["hrMax"];
            }
            arg1.intensityZone1StartDefined = loc1 = !(arg2["intensityZone1Start"] == null);
            if (loc1 == true) 
            {
                arg1.intensityZone1Start = arg2["intensityZone1Start"];
            }
            arg1.intensityZone2StartDefined = loc1 = !(arg2["intensityZone2Start"] == null);
            if (loc1 == true) 
            {
                arg1.intensityZone2Start = arg2["intensityZone2Start"];
            }
            arg1.intensityZone3StartDefined = loc1 = !(arg2["intensityZone3Start"] == null);
            if (loc1 == true) 
            {
                arg1.intensityZone3Start = arg2["intensityZone3Start"];
            }
            arg1.intensityZone4StartDefined = loc1 = !(arg2["intensityZone4Start"] == null);
            if (loc1 == true) 
            {
                arg1.intensityZone4Start = arg2["intensityZone4Start"];
            }
            arg1.intensityZone4EndDefined = loc1 = !(arg2["intensityZone4End"] == null);
            if (loc1 == true) 
            {
                arg1.intensityZone4End = arg2["intensityZone4End"];
            }
            arg1.isDeleted = arg2["isDeleted"];
            arg1.latitudeEndDefined = loc1 = !(arg2["latitudeEnd"] == null);
            if (loc1 == true) 
            {
                arg1.latitudeEnd = arg2["latitudeEnd"];
            }
            arg1.latitudeStartDefined = loc1 = !(arg2["latitudeStart"] == null);
            if (loc1 == true) 
            {
                arg1.latitudeStart = arg2["latitudeStart"];
            }
            arg1.linkedRouteIdDefined = loc1 = !(arg2["linkedRouteId"] == null);
            if (loc1 == true) 
            {
                arg1.linkedRouteId = arg2["linkedRouteId"];
            }
            arg1.linkedTrackGUIDDefined = loc1 = !(arg2["linkedTrackGUID"] == null);
            if (loc1 == true) 
            {
                arg1.linkedTrackGUID = arg2["linkedTrackGUID"];
            }
            arg1.logTypeDefined = loc1 = !(arg2["logType"] == null);
            if (loc1 == true) 
            {
                arg1.logType = core.general.LogType.fromString(arg2["logType"]);
            }
            arg1.logVersionDefined = loc1 = !(arg2["logVersion"] == null);
            if (loc1 == true) 
            {
                arg1.logVersion = arg2["logVersion"];
            }
            arg1.longitudeEndDefined = loc1 = !(arg2["longitudeEnd"] == null);
            if (loc1 == true) 
            {
                arg1.longitudeEnd = arg2["longitudeEnd"];
            }
            arg1.longitudeStartDefined = loc1 = !(arg2["longitudeStart"] == null);
            if (loc1 == true) 
            {
                arg1.longitudeStart = arg2["longitudeStart"];
            }
            arg1.lowerLimitDefined = loc1 = !(arg2["lowerLimit"] == null);
            if (loc1 == true) 
            {
                arg1.lowerLimit = arg2["lowerLimit"];
            }
            arg1.manualTemperatureDefined = loc1 = !(arg2["manualTemperature"] == null);
            if (loc1 == true) 
            {
                arg1.manualTemperature = arg2["manualTemperature"];
            }
            arg1.maximumAltitudeDefined = loc1 = !(arg2["maximumAltitude"] == null);
            if (loc1 == true) 
            {
                arg1.maximumAltitude = arg2["maximumAltitude"];
            }
            arg1.maximumCadenceDefined = loc1 = !(arg2["maximumCadence"] == null);
            if (loc1 == true) 
            {
                arg1.maximumCadence = arg2["maximumCadence"];
            }
            arg1.maximumHeartrateDefined = loc1 = !(arg2["maximumHeartrate"] == null);
            if (loc1 == true) 
            {
                arg1.maximumHeartrate = arg2["maximumHeartrate"];
            }
            arg1.maximumInclineDefined = loc1 = !(arg2["maximumIncline"] == null);
            if (loc1 == true) 
            {
                arg1.maximumIncline = arg2["maximumIncline"];
            }
            arg1.maximumInclineDownhillDefined = loc1 = !(arg2["maximumInclineDownhill"] == null);
            if (loc1 == true) 
            {
                arg1.maximumInclineDownhill = arg2["maximumInclineDownhill"];
            }
            arg1.maximumInclineUphillDefined = loc1 = !(arg2["maximumInclineUphill"] == null);
            if (loc1 == true) 
            {
                arg1.maximumInclineUphill = arg2["maximumInclineUphill"];
            }
            arg1.maximumPercentHRMaxDefined = loc1 = !(arg2["maximumPercentHRMax"] == null);
            if (loc1 == true) 
            {
                arg1.maximumPercentHRMax = arg2["maximumPercentHRMax"];
            }
            arg1.maximumPowerDefined = loc1 = !(arg2["maximumPower"] == null);
            if (loc1 == true) 
            {
                arg1.maximumPower = arg2["maximumPower"];
            }
            arg1.maximumRiseRateDefined = loc1 = !(arg2["maximumRiseRate"] == null);
            if (loc1 == true) 
            {
                arg1.maximumRiseRate = arg2["maximumRiseRate"];
            }
            arg1.maximumRiseRateDownhillDefined = loc1 = !(arg2["maximumRiseRateDownhill"] == null);
            if (loc1 == true) 
            {
                arg1.maximumRiseRateDownhill = arg2["maximumRiseRateDownhill"];
            }
            arg1.maximumRiseRateUphillDefined = loc1 = !(arg2["maximumRiseRateUphill"] == null);
            if (loc1 == true) 
            {
                arg1.maximumRiseRateUphill = arg2["maximumRiseRateUphill"];
            }
            arg1.maximumSpeedDefined = loc1 = !(arg2["maximumSpeed"] == null);
            if (loc1 == true) 
            {
                arg1.maximumSpeed = arg2["maximumSpeed"];
            }
            arg1.maximumTemperatureDefined = loc1 = !(arg2["maximumTemperature"] == null);
            if (loc1 == true) 
            {
                arg1.maximumTemperature = arg2["maximumTemperature"];
            }
            arg1.minimumAltitudeDefined = loc1 = !(arg2["minimumAltitude"] == null);
            if (loc1 == true) 
            {
                arg1.minimumAltitude = arg2["minimumAltitude"];
            }
            arg1.minimumCadenceDefined = loc1 = !(arg2["minimumCadence"] == null);
            if (loc1 == true) 
            {
                arg1.minimumCadence = arg2["minimumCadence"];
            }
            arg1.minimumHeartrateDefined = loc1 = !(arg2["minimumHeartrate"] == null);
            if (loc1 == true) 
            {
                arg1.minimumHeartrate = arg2["minimumHeartrate"];
            }
            arg1.minimumInclineDefined = loc1 = !(arg2["minimumIncline"] == null);
            if (loc1 == true) 
            {
                arg1.minimumIncline = arg2["minimumIncline"];
            }
            arg1.minimumInclineUphillDefined = loc1 = !(arg2["minimumInclineUphill"] == null);
            if (loc1 == true) 
            {
                arg1.minimumInclineUphill = arg2["minimumInclineUphill"];
            }
            arg1.minimumInclineDownhillDefined = loc1 = !(arg2["minimumInclineDownhill"] == null);
            if (loc1 == true) 
            {
                arg1.minimumInclineDownhill = arg2["minimumInclineDownhill"];
            }
            arg1.minimumPercentHRMaxDefined = loc1 = !(arg2["minimumPercentHRMax"] == null);
            if (loc1 == true) 
            {
                arg1.minimumPercentHRMax = arg2["minimumPercentHRMax"];
            }
            arg1.minimumPowerDefined = loc1 = !(arg2["minimumPower"] == null);
            if (loc1 == true) 
            {
                arg1.minimumPower = arg2["minimumPower"];
            }
            arg1.minimumRiseRateDefined = loc1 = !(arg2["minimumRiseRate"] == null);
            if (loc1 == true) 
            {
                arg1.minimumRiseRate = arg2["minimumRiseRate"];
            }
            arg1.minimumRiseRateUphillDefined = loc1 = !(arg2["minimumRiseRateUphill"] == null);
            if (loc1 == true) 
            {
                arg1.minimumRiseRateUphill = arg2["minimumRiseRateUphill"];
            }
            arg1.minimumRiseRateDownhillDefined = loc1 = !(arg2["minimumRiseRateDownhill"] == null);
            if (loc1 == true) 
            {
                arg1.minimumRiseRateDownhill = arg2["minimumRiseRateDownhill"];
            }
            arg1.minimumSpeedDefined = loc1 = !(arg2["minimumSpeed"] == null);
            if (loc1 == true) 
            {
                arg1.minimumSpeed = arg2["minimumSpeed"];
            }
            arg1.minimumTemperatureDefined = loc1 = !(arg2["minimumTemperature"] == null);
            if (loc1 == true) 
            {
                arg1.minimumTemperature = arg2["minimumTemperature"];
            }
            arg1.name = arg2["name"];
            arg1.pauseTimeDefined = loc1 = !(arg2["pauseTime"] == null);
            if (loc1 == true) 
            {
                arg1.pauseTime = arg2["pauseTime"];
            }
            arg1.percentTimeInIntensityZone1Defined = loc1 = !(arg2["percentTimeInIntensityZone1"] == null);
            if (loc1 == true) 
            {
                arg1.percentTimeInIntensityZone1 = arg2["percentTimeInIntensityZone1"];
            }
            arg1.percentTimeInIntensityZone2Defined = loc1 = !(arg2["percentTimeInIntensityZone2"] == null);
            if (loc1 == true) 
            {
                arg1.percentTimeInIntensityZone2 = arg2["percentTimeInIntensityZone2"];
            }
            arg1.percentTimeInIntensityZone3Defined = loc1 = !(arg2["percentTimeInIntensityZone3"] == null);
            if (loc1 == true) 
            {
                arg1.percentTimeInIntensityZone3 = arg2["percentTimeInIntensityZone3"];
            }
            arg1.percentTimeInIntensityZone4Defined = loc1 = !(arg2["percentTimeInIntensityZone4"] == null);
            if (loc1 == true) 
            {
                arg1.percentTimeInIntensityZone4 = arg2["percentTimeInIntensityZone4"];
            }
            arg1.powerZone1StartDefined = loc1 = !(arg2["powerZone1Start"] == null);
            if (loc1 == true) 
            {
                arg1.powerZone1Start = arg2["powerZone1Start"];
            }
            arg1.powerZone2StartDefined = loc1 = !(arg2["powerZone2Start"] == null);
            if (loc1 == true) 
            {
                arg1.powerZone2Start = arg2["powerZone2Start"];
            }
            arg1.powerZone3StartDefined = loc1 = !(arg2["powerZone3Start"] == null);
            if (loc1 == true) 
            {
                arg1.powerZone3Start = arg2["powerZone3Start"];
            }
            arg1.powerZone4StartDefined = loc1 = !(arg2["powerZone4Start"] == null);
            if (loc1 == true) 
            {
                arg1.powerZone4Start = arg2["powerZone4Start"];
            }
            arg1.powerZone5StartDefined = loc1 = !(arg2["powerZone5Start"] == null);
            if (loc1 == true) 
            {
                arg1.powerZone5Start = arg2["powerZone5Start"];
            }
            arg1.powerZone6StartDefined = loc1 = !(arg2["powerZone6Start"] == null);
            if (loc1 == true) 
            {
                arg1.powerZone6Start = arg2["powerZone6Start"];
            }
            arg1.powerZone7EndDefined = loc1 = !(arg2["powerZone7End"] == null);
            if (loc1 == true) 
            {
                arg1.powerZone7End = arg2["powerZone7End"];
            }
            arg1.powerZone7StartDefined = loc1 = !(arg2["powerZone7Start"] == null);
            if (loc1 == true) 
            {
                arg1.powerZone7Start = arg2["powerZone7Start"];
            }
            arg1.ratingDefined = loc1 = !(arg2["rating"] == null);
            if (loc1 == true) 
            {
                arg1.rating = arg2["rating"];
            }
            arg1.feelingDefined = loc1 = !(arg2["feeling"] == null);
            if (loc1 == true) 
            {
                arg1.feeling = arg2["feeling"];
            }
            arg1.trainingTimeDownhillDefined = loc1 = !(arg2["trainingTimeDownhill"] == null);
            if (loc1 == true) 
            {
                arg1.trainingTimeDownhill = arg2["trainingTimeDownhill"];
            }
            arg1.trainingTimeUphillDefined = loc1 = !(arg2["trainingTimeUphill"] == null);
            if (loc1 == true) 
            {
                arg1.trainingTimeUphill = arg2["trainingTimeUphill"];
            }
            arg1.rxBatteryStatusDefined = loc1 = !(arg2["rxBatteryStatus"] == null);
            if (loc1 == true) 
            {
                arg1.rxBatteryStatus = arg2["rxBatteryStatus"];
            }
            arg1.samplingRateDefined = loc1 = !(arg2["samplingRate"] == null);
            if (loc1 == true) 
            {
                arg1.samplingRate = arg2["samplingRate"];
            }
            arg1.shoulderWidthDefined = loc1 = !(arg2["shoulderWidth"] == null);
            if (loc1 == true) 
            {
                arg1.shoulderWidth = arg2["shoulderWidth"];
            }
            arg1.shoulderWidthUnitDefined = loc1 = !(arg2["shoulderWidthUnit"] == null);
            if (loc1 == true) 
            {
                arg1.shoulderWidthUnit = arg2["shoulderWidthUnit"];
            }
            arg1.speedUnitDefined = loc1 = !(arg2["measurement"] == null);
            if (loc1 == true) 
            {
                arg1.speedUnit = arg2["measurement"];
            }
            arg1.startDateDefined = loc1 = !(arg2["startDate"] == null);
            if (loc1 == true) 
            {
                arg1.startDate = utils.date.DateUtilCommon.dateFromMySqlFormat(arg2["startDate"]);
            }
            arg1.statisticDefined = loc1 = !(arg2["statistic"] == null);
            if (loc1 == true) 
            {
                arg1.statistic = arg2["statistic"];
            }
            arg1.serialNumberDefined = loc1 = !(arg2["serialNumber"] == null);
            if (loc1 == true) 
            {
                arg1.serialNumber = arg2["serialNumber"];
            }
            arg1.thresholdPowerDefined = loc1 = !(arg2["thresholdPower"] == null);
            if (loc1 == true) 
            {
                arg1.thresholdPower = arg2["thresholdPower"];
            }
            arg1.timeInIntensityZone1Defined = loc1 = !(arg2["timeInIntensityZone1"] == null);
            if (loc1 == true) 
            {
                arg1.timeInIntensityZone1 = arg2["timeInIntensityZone1"];
            }
            arg1.timeInIntensityZone2Defined = loc1 = !(arg2["timeInIntensityZone2"] == null);
            if (loc1 == true) 
            {
                arg1.timeInIntensityZone2 = arg2["timeInIntensityZone2"];
            }
            arg1.timeInIntensityZone3Defined = loc1 = !(arg2["timeInIntensityZone3"] == null);
            if (loc1 == true) 
            {
                arg1.timeInIntensityZone3 = arg2["timeInIntensityZone3"];
            }
            arg1.timeInIntensityZone4Defined = loc1 = !(arg2["timeInIntensityZone4"] == null);
            if (loc1 == true) 
            {
                arg1.timeInIntensityZone4 = arg2["timeInIntensityZone4"];
            }
            arg1.timeInPowerZone1Defined = loc1 = !(arg2["timeInPowerZone1"] == null);
            if (loc1 == true) 
            {
                arg1.timeInPowerZone1 = arg2["timeInPowerZone1"];
            }
            arg1.timeInPowerZone2Defined = loc1 = !(arg2["timeInPowerZone2"] == null);
            if (loc1 == true) 
            {
                arg1.timeInPowerZone2 = arg2["timeInPowerZone2"];
            }
            arg1.timeInPowerZone3Defined = loc1 = !(arg2["timeInPowerZone3"] == null);
            if (loc1 == true) 
            {
                arg1.timeInPowerZone3 = arg2["timeInPowerZone3"];
            }
            arg1.timeInPowerZone4Defined = loc1 = !(arg2["timeInPowerZone4"] == null);
            if (loc1 == true) 
            {
                arg1.timeInPowerZone4 = arg2["timeInPowerZone4"];
            }
            arg1.timeInPowerZone5Defined = loc1 = !(arg2["timeInPowerZone5"] == null);
            if (loc1 == true) 
            {
                arg1.timeInPowerZone5 = arg2["timeInPowerZone5"];
            }
            arg1.timeInPowerZone6Defined = loc1 = !(arg2["timeInPowerZone6"] == null);
            if (loc1 == true) 
            {
                arg1.timeInPowerZone6 = arg2["timeInPowerZone6"];
            }
            arg1.timeInPowerZone7Defined = loc1 = !(arg2["timeInPowerZone7"] == null);
            if (loc1 == true) 
            {
                arg1.timeInPowerZone7 = arg2["timeInPowerZone7"];
            }
            arg1.timeInZoneDefined = loc1 = !(arg2["timeInZone"] == null);
            if (loc1 == true) 
            {
                arg1.timeInZone = arg2["timeInZone"];
            }
            arg1.timeInZone1Defined = loc1 = !(arg2["timeInZone1"] == null);
            if (loc1 == true) 
            {
                arg1.timeInZone1 = arg2["timeInZone1"];
            }
            arg1.timeInZone2Defined = loc1 = !(arg2["timeInZone2"] == null);
            if (loc1 == true) 
            {
                arg1.timeInZone2 = arg2["timeInZone2"];
            }
            arg1.timeInZone3Defined = loc1 = !(arg2["timeInZone3"] == null);
            if (loc1 == true) 
            {
                arg1.timeInZone3 = arg2["timeInZone3"];
            }
            arg1.timeOverIntensityZoneDefined = loc1 = !(arg2["timeOverIntensityZone"] == null);
            if (loc1 == true) 
            {
                arg1.timeOverIntensityZone = arg2["timeOverIntensityZone"];
            }
            arg1.timeOverZoneDefined = loc1 = !(arg2["timeOverZone"] == null);
            if (loc1 == true) 
            {
                arg1.timeOverZone = arg2["timeOverZone"];
            }
            arg1.timeUnderIntensityZoneDefined = loc1 = !(arg2["timeUnderIntensityZone"] == null);
            if (loc1 == true) 
            {
                arg1.timeUnderIntensityZone = arg2["timeUnderIntensityZone"];
            }
            arg1.timeUnderZoneDefined = loc1 = !(arg2["timeUnderZone"] == null);
            if (loc1 == true) 
            {
                arg1.timeUnderZone = arg2["timeUnderZone"];
            }
            arg1.trackProfileDefined = loc1 = !(arg2["trackProfile"] == null);
            if (loc1 == true) 
            {
                arg1.trackProfile = arg2["trackProfile"];
            }
            arg1.trainingTimeDefined = loc1 = !(arg2["trainingTime"] == null);
            if (loc1 == true) 
            {
                arg1.trainingTime = arg2["trainingTime"];
            }
            arg1.trainingTypeDefined = loc1 = !(arg2["trainingType"] == null);
            if (loc1 == true) 
            {
                arg1.trainingType = arg2["trainingType"];
            }
            arg1.trainingZoneDefined = loc1 = !(arg2["trainingZone"] == null);
            if (loc1 == true) 
            {
                arg1.trainingZone = arg2["trainingZone"];
            }
            arg1.tripSectionDistanceDefined = loc1 = !(arg2["tripSectionDistance"] == null);
            if (loc1 == true) 
            {
                arg1.tripSectionDistance = arg2["tripSectionDistance"];
            }
            arg1.tripSectionTimeDefined = loc1 = !(arg2["tripSectionTime"] == null);
            if (loc1 == true) 
            {
                arg1.tripSectionTime = arg2["tripSectionTime"];
            }
            arg1.txBatteryStatusDefined = loc1 = !(arg2["txBatteryStatus"] == null);
            if (loc1 == true) 
            {
                arg1.txBatteryStatus = arg2["txBatteryStatus"];
            }
            arg1.unitDefined = loc1 = !(arg2["unitId"] == null);
            if (loc1 == true) 
            {
                arg1.unitId = arg2["unitId"];
            }
            if (arg2["unitType"] != null) 
            {
                arg1.unitType = core.general.UnitType.fromString(arg2["unitType"]);
            }
            arg1.sportId = arg2["sportId"];
            arg1.sport = init.BackendInitializer.getInstance().getSportHandler().resolveSportById(arg1.sportId);
            init.BackendInitializer.getInstance().getSportHandler().sportsInUseDic[arg1.sportId] = arg1.sport;
            arg1.userId = arg2["userId"];
            arg1.upperLimitDefined = loc1 = !(arg2["upperLimit"] == null);
            if (loc1 == true) 
            {
                arg1.upperLimit = arg2["upperLimit"];
            }
            arg1.weatherDefined = loc1 = !(arg2["weather"] == null);
            if (loc1 == true) 
            {
                arg1.weather = arg2["weather"];
            }
            arg1.wheelSizeDefined = loc1 = !(arg2["wheelSize"] == null);
            if (loc1 == true) 
            {
                arg1.wheelSize = arg2["wheelSize"];
            }
            arg1.windDefined = loc1 = !(arg2["wind"] == null);
            if (loc1 == true) 
            {
                arg1.wind = arg2["wind"];
            }
            arg1.workInKJDefined = loc1 = !(arg2["workInKJ"] == null);
            if (loc1 == true) 
            {
                arg1.workInKJ = arg2["workInKJ"];
            }
            arg1.zone1StartDefined = loc1 = !(arg2["zone1Start"] == null);
            if (loc1 == true) 
            {
                arg1.zone1Start = arg2["zone1Start"];
            }
            arg1.zone2StartDefined = loc1 = !(arg2["zone2Start"] == null);
            if (loc1 == true) 
            {
                arg1.zone2Start = arg2["zone2Start"];
            }
            arg1.zone3EndDefined = loc1 = !(arg2["zone3End"] == null);
            if (loc1 == true) 
            {
                arg1.zone3End = arg2["zone3End"];
            }
            arg1.zone3StartDefined = loc1 = !(arg2["zone3Start"] == null);
            if (loc1 == true) 
            {
                arg1.zone3Start = arg2["zone3Start"];
            }
            arg1.chestbeltManufacturerDefined = loc1 = !(arg2["chestbeltManufacturer"] == null);
            if (loc1 == true) 
            {
                arg1.chestbeltManufacturer = arg2["chestbeltManufacturer"];
            }
            arg1.withDeviceDefined = loc1 = !(arg2["withDevice"] == null);
            if (loc1 == true) 
            {
                arg1.withDevice = arg2["withDevice"];
            }
            arg1.stepsDefined = loc1 = !(arg2["steps"] == null);
            if (loc1 == true) 
            {
                arg1.steps = arg2["steps"];
            }
            arg1.targetDayDefined = loc1 = !(arg2["targetDay"] == null);
            if (loc1 == true) 
            {
                arg1.targetDay = arg2["targetDay"];
            }
            arg1.activeTimeLowDefined = loc1 = !(arg2["activTimeLow"] == null);
            if (loc1 == true) 
            {
                arg1.activeTimeLow = arg2["activTimeLow"];
            }
            arg1.activeTimeMiddleDefined = loc1 = !(arg2["activTimeMedium"] == null);
            if (loc1 == true) 
            {
                arg1.activeTimeMiddle = arg2["activTimeMedium"];
            }
            arg1.activeTimeHighDefined = loc1 = !(arg2["activTimeHigh"] == null);
            if (loc1 == true) 
            {
                arg1.activeTimeHigh = arg2["activTimeHigh"];
            }
            arg1.timeWakeUpDefined = loc1 = !(arg2["stepsLow"] == null);
            if (loc1 == true) 
            {
                arg1.timeWakeUp = arg2["stepsLow"];
            }
            arg1.timeLightSleepDefined = loc1 = !(arg2["stepsMedium"] == null);
            if (loc1 == true) 
            {
                arg1.timeLightSleep = arg2["stepsMedium"];
            }
            arg1.timeDeepSleepDefined = loc1 = !(arg2["stepsHigh"] == null);
            if (loc1 == true) 
            {
                arg1.timeDeepSleep = arg2["stepsHigh"];
            }
            arg1.timeSleepDefined = loc1 = !(arg2["timeSleep"] == null);
            if (loc1 == true) 
            {
                arg1.timeSleep = arg2["timeSleep"];
            }
            arg1.best5KTimeDefined = loc1 = !(arg2["best5KTime"] == null);
            if (loc1 == true) 
            {
                arg1.best5KTime = arg2["best5KTime"];
            }
            arg1.best5KEntryDefined = loc1 = !(arg2["best5KEntry"] == null);
            if (loc1 == true) 
            {
                arg1.best5KEntry = arg2["best5KEntry"];
            }
            decodeSharingInformations(arg2["sharingInformations"], arg1);
            arg1.best20minPowerDefined = loc1 = !(arg2["best20minPower"] == null);
            if (loc1 == true) 
            {
                arg1.best20minPower = arg2["best20minPower"];
            }
            arg1.best20minPowerEntryDefined = loc1 = !(arg2["best20minPowerEntry"] == null);
            if (loc1 == true) 
            {
                arg1.best20minPowerEntry = arg2["best20minPowerEntry"];
            }
            arg1.powerNPDefined = loc1 = !(arg2["powerNP"] == null);
            if (loc1 == true) 
            {
                arg1.powerNP = arg2["powerNP"];
            }
            arg1.powerTSSDefined = loc1 = !(arg2["powerTSS"] == null);
            if (loc1 == true) 
            {
                arg1.powerTSS = arg2["powerTSS"];
            }
            arg1.powerFTPDefined = loc1 = !(arg2["powerFTP"] == null);
            if (loc1 == true) 
            {
                arg1.powerFTP = arg2["powerFTP"];
            }
            arg1.pedalingTimeDefined = loc1 = !(arg2["pedalingTime"] == null);
            if (loc1 == true) 
            {
                arg1.pedalingTime = arg2["pedalingTime"];
            }
            arg1.pedalingIndexDefined = loc1 = !(arg2["pedalingIndex"] == null);
            if (loc1 == true) 
            {
                arg1.pedalingIndex = arg2["pedalingIndex"];
            }
            arg1.maximumExpansionDefined = loc1 = !(arg2["maximumExpansion"] == null);
            if (loc1 == true) 
            {
                arg1.maximumExpansion = arg2["maximumExpansion"];
            }
            arg1.maximumExpansionUphillDefined = loc1 = !(arg2["maximumExpansionUphill"] == null);
            if (loc1 == true) 
            {
                arg1.maximumExpansionUphill = arg2["maximumExpansionUphill"];
            }
            arg1.maximumExpansionDownhillDefined = loc1 = !(arg2["maximumExpansionDownhill"] == null);
            if (loc1 == true) 
            {
                arg1.maximumExpansionDownhill = arg2["maximumExpansionDownhill"];
            }
            arg1.averageBalanceRightDefined = loc1 = !(arg2["averageBalanceRight"] == null);
            if (loc1 == true) 
            {
                arg1.averageBalanceRight = arg2["averageBalanceRight"];
            }
            arg1.averageBalanceLeftDefined = loc1 = !(arg2["averageBalanceLeft"] == null);
            if (loc1 == true) 
            {
                arg1.averageBalanceLeft = arg2["averageBalanceLeft"];
            }
            arg1.powerIFDefined = loc1 = !(arg2["powerIF"] == null);
            if (loc1 == true) 
            {
                arg1.powerIF = arg2["powerIF"];
            }
            arg1.torqueEffectLeftDefined = loc1 = !(arg2["torqueEffectLeft"] == null);
            if (loc1 == true) 
            {
                arg1.torqueEffectLeft = arg2["torqueEffectLeft"];
            }
            arg1.torqueEffectRightDefined = loc1 = !(arg2["torqueEffectRight"] == null);
            if (loc1 == true) 
            {
                arg1.torqueEffectRight = arg2["torqueEffectRight"];
            }
            arg1.pedalSmoothLeftDefined = loc1 = !(arg2["pedalSmoothLeft"] == null);
            if (loc1 == true) 
            {
                arg1.pedalSmoothLeft = arg2["pedalSmoothLeft"];
            }
            arg1.pedalSmoothRightDefined = loc1 = !(arg2["pedalSmoothRight"] == null);
            if (loc1 == true) 
            {
                arg1.pedalSmoothRight = arg2["pedalSmoothRight"];
            }
            arg1.averageCadenceCalcDefined = loc1 = !(arg2["averageCadenceCalc"] == null);
            if (loc1 == true) 
            {
                arg1.averageCadenceCalc = arg2["averageCadenceCalc"];
            }
            arg1.averagePowerCalcDefined = loc1 = !(arg2["averagePowerCalc"] == null);
            if (loc1 == true) 
            {
                arg1.averagePowerCalc = arg2["averagePowerCalc"];
            }
            return arg1;
        }

        public static function fromRecalculationValues(arg1:core.activities.Activity, arg2:core.activities.ActivityRecalculationValues):core.activities.Activity
        {
            if (arg1.altitudeDifferencesDownhillDefined) 
            {
                arg1.altitudeDifferencesDownhill = arg2.altitudeDifferencesDownhill;
            }
            if (arg1.altitudeDifferencesUphillDefined) 
            {
                arg1.altitudeDifferencesUphill = arg2.altitudeDifferencesUphill;
            }
            if (arg1.averageAltitudeDefined) 
            {
                arg1.averageAltitude = arg2.averageAltitude;
            }
            if (arg1.averageCadenceDefined) 
            {
                arg1.averageCadence = arg2.averageCadence;
            }
            if (arg1.averageExpansionDefined) 
            {
                arg1.averageExpansion = arg2.averageExpansion;
            }
            if (arg1.averageExpansionUphillDefined) 
            {
                arg1.averageExpansionUphill = arg2.averageExpansionUphill;
            }
            if (arg1.averageHeartrateDefined) 
            {
                arg1.averageHeartrate = arg2.averageHeartrate;
            }
            if (arg1.averageInclineDownhillDefined) 
            {
                arg1.averageInclineDownhill = arg2.averageInclineDownhill;
            }
            if (arg1.averageInclineUphillDefined) 
            {
                arg1.averageInclineUphill = arg2.averageInclineUphill;
            }
            if (arg1.averagePercentHRMaxDefined) 
            {
                arg1.averagePercentHRMax = arg2.averagePercentHRMax;
            }
            if (arg1.averagePowerDefined) 
            {
                arg1.averagePower = arg2.averagePower;
            }
            if (arg1.averagePowerWattPerKGDefined) 
            {
                arg1.averagePowerWattPerKG = arg2.averagePowerWattPerKG;
            }
            if (arg1.averageRiseRateDefined) 
            {
                arg1.averageRiseRate = arg2.averageRiseRate;
            }
            if (arg1.averageRiseRateUphillDefined) 
            {
                arg1.averageRiseRateUphill = arg2.averageRiseRateUphill;
            }
            if (arg1.averageRiseRateDownhillDefined) 
            {
                arg1.averageRiseRateDownhill = arg2.averageRiseRateDownhill;
            }
            if (arg1.averageSpeedDefined) 
            {
                arg1.averageSpeed = arg2.averageSpeed;
            }
            if (arg1.averageSpeedDownhillDefined) 
            {
                arg1.averageSpeedDownhill = arg2.averageSpeedDownhill;
            }
            if (arg1.averageSpeedUphillDefined) 
            {
                arg1.averageSpeedUphill = arg2.averageSpeedUphill;
            }
            if (arg1.averageTemperatureDefined) 
            {
                arg1.averageTemperature = arg2.averageTemperature;
            }
            if (arg1.caloriesDefined) 
            {
                arg1.calories = arg2.calories;
            }
            if (arg1.distanceDefined) 
            {
                arg1.distance = arg2.distance;
            }
            if (arg1.distanceDownhillDefined) 
            {
                arg1.distanceDownhill = arg2.distanceDownhill;
            }
            if (arg1.distanceUphillDefined) 
            {
                arg1.distanceUphill = arg2.distanceUphill;
            }
            if (arg1.exerciseTimeDefined) 
            {
                arg1.exerciseTime = arg2.exerciseTime;
            }
            if (arg1.maximumAltitudeDefined) 
            {
                arg1.maximumAltitude = arg2.maximumAltitude;
            }
            if (arg1.maximumCadenceDefined) 
            {
                arg1.maximumCadence = arg2.maximumCadence;
            }
            if (arg1.maximumHeartrateDefined) 
            {
                arg1.maximumHeartrate = arg2.maximumHeartrate;
            }
            if (arg1.maximumInclineDefined) 
            {
                arg1.maximumIncline = arg2.maximumIncline;
            }
            if (arg1.maximumInclineDownhillDefined) 
            {
                arg1.maximumInclineDownhill = arg2.maximumInclineDownhill;
            }
            if (arg1.maximumInclineUphillDefined) 
            {
                arg1.maximumInclineUphill = arg2.maximumInclineUphill;
            }
            if (arg1.maximumPercentHRMaxDefined) 
            {
                arg1.maximumPercentHRMax = arg2.maximumPercentHRMax;
            }
            if (arg1.maximumPowerDefined) 
            {
                arg1.maximumPower = arg2.maximumPower;
            }
            if (arg1.maximumRiseRateDefined) 
            {
                arg1.maximumRiseRate = arg2.maximumRiseRate;
            }
            if (arg1.maximumRiseRateDownhillDefined) 
            {
                arg1.maximumRiseRateDownhill = arg2.maximumRiseRateDownhill;
            }
            if (arg1.maximumRiseRateUphillDefined) 
            {
                arg1.maximumRiseRateUphill = arg2.maximumRiseRateUphill;
            }
            if (arg1.maximumSpeedDefined) 
            {
                arg1.maximumSpeed = arg2.maximumSpeed;
            }
            if (arg1.maximumTemperatureDefined) 
            {
                arg1.maximumTemperature = arg2.maximumTemperature;
            }
            if (arg1.minimumAltitudeDefined) 
            {
                arg1.minimumAltitude = arg2.minimumAltitude;
            }
            if (arg1.minimumCadenceDefined) 
            {
                arg1.minimumCadence = arg2.minimumCadence;
            }
            if (arg1.minimumHeartrateDefined) 
            {
                arg1.minimumHeartrate = arg2.minimumHeartrate;
            }
            if (arg1.minimumInclineDefined) 
            {
                arg1.minimumIncline = arg2.minimumIncline;
            }
            if (arg1.minimumInclineUphillDefined) 
            {
                arg1.minimumInclineUphill = arg2.minimumInclineUphill;
            }
            if (arg1.minimumInclineDownhillDefined) 
            {
                arg1.minimumInclineDownhill = arg2.minimumInclineDownhill;
            }
            if (arg1.minimumPercentHRMaxDefined) 
            {
                arg1.minimumPercentHRMax = arg2.minimumPercentHRMax;
            }
            if (arg1.minimumPowerDefined) 
            {
                arg1.minimumPower = arg2.minimumPower;
            }
            if (arg1.minimumRiseRateDefined) 
            {
                arg1.minimumRiseRate = arg2.minimumRiseRate;
            }
            if (arg1.minimumRiseRateUphillDefined) 
            {
                arg1.minimumRiseRateUphill = arg2.minimumRiseRateUphill;
            }
            if (arg1.minimumRiseRateDownhillDefined) 
            {
                arg1.minimumRiseRateDownhill = arg2.minimumRiseRateDownhill;
            }
            if (arg1.minimumSpeedDefined) 
            {
                arg1.minimumSpeed = arg2.minimumSpeed;
            }
            if (arg1.minimumTemperatureDefined) 
            {
                arg1.minimumTemperature = arg2.minimumTemperature;
            }
            if (arg1.pauseTimeDefined) 
            {
                arg1.pauseTime = arg2.pauseTime;
            }
            if (arg1.trainingTimeDownhillDefined) 
            {
                arg1.trainingTimeDownhill = arg2.trainingTimeDownhill;
            }
            if (arg1.trainingTimeUphillDefined) 
            {
                arg1.trainingTimeUphill = arg2.trainingTimeUphill;
            }
            if (arg1.timeInIntensityZone1Defined) 
            {
                arg1.timeInIntensityZone1 = arg2.timeInIntensityZone1;
            }
            if (arg1.timeInIntensityZone2Defined) 
            {
                arg1.timeInIntensityZone2 = arg2.timeInIntensityZone2;
            }
            if (arg1.timeInIntensityZone3Defined) 
            {
                arg1.timeInIntensityZone3 = arg2.timeInIntensityZone3;
            }
            if (arg1.timeInIntensityZone4Defined) 
            {
                arg1.timeInIntensityZone4 = arg2.timeInIntensityZone4;
            }
            if (arg1.timeInPowerZone1Defined) 
            {
                arg1.timeInPowerZone1 = arg2.timeInPowerZone1;
            }
            if (arg1.timeInPowerZone2Defined) 
            {
                arg1.timeInPowerZone2 = arg2.timeInPowerZone2;
            }
            if (arg1.timeInPowerZone3Defined) 
            {
                arg1.timeInPowerZone3 = arg2.timeInPowerZone3;
            }
            if (arg1.timeInPowerZone4Defined) 
            {
                arg1.timeInPowerZone4 = arg2.timeInPowerZone4;
            }
            if (arg1.timeInPowerZone5Defined) 
            {
                arg1.timeInPowerZone5 = arg2.timeInPowerZone5;
            }
            if (arg1.timeInPowerZone6Defined) 
            {
                arg1.timeInPowerZone6 = arg2.timeInPowerZone6;
            }
            if (arg1.timeInPowerZone7Defined) 
            {
                arg1.timeInPowerZone7 = arg2.timeInPowerZone7;
            }
            if (arg1.timeInZoneDefined) 
            {
                arg1.timeInZone = arg2.timeInZone;
            }
            if (arg1.timeInZone1Defined) 
            {
                arg1.timeInZone1 = arg2.timeInZone1;
            }
            if (arg1.timeInZone2Defined) 
            {
                arg1.timeInZone2 = arg2.timeInZone2;
            }
            if (arg1.timeInZone3Defined) 
            {
                arg1.timeInZone3 = arg2.timeInZone3;
            }
            if (arg1.timeOverIntensityZoneDefined) 
            {
                arg1.timeOverIntensityZone = arg2.timeOverIntensityZone;
            }
            if (arg1.timeOverZoneDefined) 
            {
                arg1.timeOverZone = arg2.timeOverZone;
            }
            if (arg1.timeUnderIntensityZoneDefined) 
            {
                arg1.timeUnderIntensityZone = arg2.timeUnderIntensityZone;
            }
            if (arg1.timeUnderZoneDefined) 
            {
                arg1.timeUnderZone = arg2.timeUnderZone;
            }
            if (arg1.trainingTimeDefined) 
            {
                arg1.trainingTime = arg2.trainingTime;
            }
            if (arg1.workInKJDefined) 
            {
                arg1.workInKJ = arg2.workInKJ;
            }
            if (arg1.best5KTimeDefined) 
            {
                arg1.best5KTime = arg2.best5KTime;
            }
            if (arg1.best20minPowerDefined) 
            {
                arg1.best20minPower = arg2.best20minPower;
            }
            if (arg1.powerNPDefined) 
            {
                arg1.powerNP = arg2.powerNP;
            }
            if (arg1.powerTSSDefined) 
            {
                arg1.powerTSS = arg2.powerTSS;
            }
            if (arg1.pedalingTimeDefined) 
            {
                arg1.pedalingTime = arg2.pedalingTime;
            }
            if (arg1.pedalingIndexDefined) 
            {
                arg1.pedalingIndex = arg2.pedalingIndex;
            }
            if (arg1.averageBalanceRightDefined) 
            {
                arg1.averageBalanceRight = arg2.averageBalanceRight;
            }
            if (arg1.averageBalanceLeftDefined) 
            {
                arg1.averageBalanceLeft = arg2.averageBalanceLeft;
            }
            if (arg1.powerIFDefined) 
            {
                arg1.powerIF = arg2.powerIF;
            }
            if (arg1.torqueEffectLeftDefined) 
            {
                arg1.torqueEffectLeft = arg2.torqueEffectLeft;
            }
            if (arg1.torqueEffectRightDefined) 
            {
                arg1.torqueEffectRight = arg2.torqueEffectRight;
            }
            if (arg1.pedalSmoothLeftDefined) 
            {
                arg1.pedalSmoothLeft = arg2.pedalSmoothLeft;
            }
            if (arg1.pedalSmoothRightDefined) 
            {
                arg1.pedalSmoothRight = arg2.pedalSmoothRight;
            }
            return arg1;
        }

        public static function retrieveUnitTypeFromXML(arg1:XML):core.general.UnitType
        {
            var loc1:*=2147483647;
            if (arg1.GeneralInformation.@unit != undefined) 
            {
                return core.general.UnitType.fromString(arg1.GeneralInformation.@unit);
            }
            if (arg1.Computer.@unit != undefined) 
            {
                return core.general.UnitType.fromString(arg1.Computer.@unit);
            }
            if (arg1.Log.Information == undefined) 
            {
                return core.general.UnitType.ROX80;
            }
            return null;
        }

        public static function fromXML(arg1:XML, arg2:core.activities.Activity, arg3:Boolean):core.activities.Activity
        {
            var loc1:*=null;
            var loc3:*=undefined;
            arg1.normalize();
            arg2.modificationDate = new Date().time;
            var loc4:*=2147483647;
            if (arg1.@revision == undefined) 
            {
                if (arg1.name().toString() == "Trip") 
                {
                    arg2.logVersionDefined = true;
                    arg2.logVersion = "100";
                    return arg2;
                }
            }
            else 
            {
                loc4 = parseInt(arg1.@revision);
                arg2.logVersionDefined = true;
            }
            if (arg1.LogEintraege != undefined) 
            {
                arg2.logVersionDefined = true;
                arg2.logVersion = "100";
                return arg2;
            }
            if (loc4 < 400) 
            {
                arg2.serialNumber = arg1.GeneralInformation.@serialNumber;
                arg2.serialNumberDefined = true;
                arg2.unitType = core.general.UnitType.fromString(arg1.GeneralInformation.@unit);
                arg2.unitDefined = true;
                arg2.startDate = new Date(arg1.GeneralInformation.StartDate.text().toString());
                arg2.startDateDefined = true;
                arg2.name = arg1.GeneralInformation.Name;
                arg2.dateCode = arg1.GeneralInformation.DateCode;
                arg2.dateCodeDefined = true;
                arg2.samplingRate = arg1.GeneralInformation.SamplingRate;
                arg2.samplingRateDefined = true;
                arg2.description = arg1.MetaInformation.Notes;
                arg2.descriptionDefined = true;
                arg2.rating = arg1.MetaInformation.Rating;
                arg2.ratingDefined = true;
                arg2.feelingDefined = true;
                arg2.weather = arg1.MetaInformation.Weather;
                arg2.weatherDefined = true;
                arg2.wind = arg1.MetaInformation.Wind;
                arg2.windDefined = true;
                arg2.trainingType = arg1.MetaInformation.TrainingType;
                arg2.trainingTypeDefined = true;
                arg2.trackProfile = arg1.MetaInformation.Profile;
                arg2.trackProfileDefined = true;
                arg2.dataType = retrieveDataTypeFromXMLRootNode(arg1);
                loc1 = arg1.LogValues;
                if (arg2.dataType != "memory") 
                {
                    if (arg2.dataType == "log") 
                    {
                        arg2.logTypeDefined = true;
                        arg2.pauseTimeDefined = true;
                        arg2.pauseTime = loc1.PauseTime;
                        arg2.pauseTime = arg2.pauseTime * 100;
                    }
                }
                else 
                {
                    loc1 = arg1.MemoryValues;
                    arg2.logTypeDefined = false;
                }
                if (200 == loc4 || 210 == loc4) 
                {
                    if (loc1.Time == undefined) 
                    {
                        arg2.trainingTime = loc1.TrainingTime;
                    }
                    else 
                    {
                        arg2.trainingTime = loc1.Time;
                    }
                }
                else if (300 != loc4) 
                {
                    if (310 <= loc4 && loc4 < 400) 
                    {
                        if (arg2.dataType == "log") 
                        {
                            arg2.logType = core.general.LogType.fromString(arg1.GeneralInformation.@logType);
                            arg2.logTypeDefined = !(arg2.logType == null);
                        }
                        arg2.trainingTime = loc1.TrainingTime;
                    }
                }
                else 
                {
                    arg2.trainingTime = loc1.TrainingTime;
                }
                arg2.trainingTimeDefined = true;
                arg2.trainingTime = arg2.trainingTime * 100;
                if (loc4 < 210) 
                {
                    arg2.manualTemperature = arg1.GeneralInformation.Temperature;
                    arg2.manualTemperatureDefined = true;
                }
                else if (loc4 >= 210) 
                {
                    arg2.manualTemperature = arg1.MetaInformation.Temperature;
                    arg2.manualTemperatureDefined = true;
                    arg2.externalLink = arg1.MetaInformation.ExternalLink;
                    arg2.externalLinkDefined = true;
                }
                arg2.statisticDefined = !(arg1.MetaInformation.Statistic == undefined);
                if (arg2.statisticDefined) 
                {
                    if (arg1.MetaInformation.Statistic != "true") 
                    {
                        arg2.statistic = false;
                    }
                    else 
                    {
                        arg2.statistic = true;
                    }
                }
                loc3 = loc1.TripSectionDistance;
                var loc5:*;
                arg2.tripSectionDistanceDefined = loc5 = !(loc3 == undefined);
                if (loc5 == true) 
                {
                    arg2.tripSectionDistance = loc3;
                }
                loc3 = loc1.TripSectionTime;
                arg2.tripSectionTimeDefined = loc5 = !(loc3 == undefined);
                if (loc5 == true) 
                {
                    arg2.tripSectionTime = loc3 * 100;
                }
                loc3 = loc1.FuelEconomy;
                arg2.fuelEconomyDefined = loc5 = !(loc3 == undefined);
                if (loc5 == true) 
                {
                    arg2.fuelEconomy = loc3;
                }
                var loc7:*=0;
                var loc6:*=arg1.MetaInformation.Participant.Person;
                for each (var loc2:* in loc6) 
                {
                    arg2.participant.push(core.participant.Person.createFromXML(loc2));
                }
                if (undefined == arg1.GeneralInformation.Age) 
                {
                    if (loc1.Age != undefined) 
                    {
                        arg2.ageDefined = true;
                        arg2.age = loc1.Age;
                    }
                }
                else 
                {
                    arg2.ageDefined = true;
                    arg2.age = arg1.GeneralInformation.Age;
                }
                loc3 = loc1.AverageCadence;
                arg2.averageCadenceDefined = loc5 = !(loc3 == undefined);
                if (loc5 == true) 
                {
                    arg2.averageCadence = loc3;
                }
                loc3 = loc1.AverageExpansion;
                arg2.averageExpansionDefined = loc7 = !(loc3 == undefined);
                if (loc7 == true) 
                {
                    arg2.averageExpansion = loc3;
                }
                loc3 = loc1.AverageExpansionDownhill;
                arg2.averageExpansionDownhillDefined = loc6 = !(loc3 == undefined);
                if (loc6 == true) 
                {
                    arg2.averageExpansionDownhill = loc3;
                }
                loc3 = loc1.AverageExpansionUphill;
                arg2.averageExpansionUphillDefined = loc5 = !(loc3 == undefined);
                if (loc5 == true) 
                {
                    arg2.averageExpansionUphill = loc3;
                }
                loc3 = loc1.AverageHeartrate;
                arg2.averageHeartrateDefined = loc7 = !(loc3 == undefined);
                if (loc7 == true) 
                {
                    arg2.averageHeartrate = loc3;
                }
                loc3 = loc1.AverageInclineDownhill;
                arg2.averageInclineDownhillDefined = loc6 = !(loc3 == undefined);
                if (loc6 == true) 
                {
                    arg2.averageInclineDownhill = loc3;
                }
                loc3 = loc1.AverageInclineUphill;
                arg2.averageInclineUphillDefined = loc5 = !(loc3 == undefined);
                if (loc5 == true) 
                {
                    arg2.averageInclineUphill = loc3;
                }
                loc3 = loc1.AveragePercentHRMax;
                arg2.averagePercentHRMaxDefined = loc7 = !(loc3 == undefined);
                if (loc7 == true) 
                {
                    arg2.averagePercentHRMax = loc3;
                }
                loc3 = loc1.AveragePower;
                arg2.averagePowerDefined = loc6 = !(loc3 == undefined);
                if (loc6 == true) 
                {
                    arg2.averagePower = loc3;
                }
                loc3 = loc1.AvgPowerWattPerKG;
                arg2.averagePowerWattPerKGDefined = loc5 = !(loc3 == undefined);
                if (loc5 == true) 
                {
                    arg2.averagePowerWattPerKG = loc3;
                }
                loc3 = loc1.AverageSpeed;
                arg2.averageSpeedDefined = loc7 = !(loc3 == undefined);
                if (loc7 == true) 
                {
                    arg2.averageSpeed = loc3;
                }
                loc3 = loc1.AverageSpeedUphill;
                arg2.averageSpeedUphillDefined = loc6 = !(loc3 == undefined);
                if (loc6 == true) 
                {
                    arg2.averageSpeedUphill = loc3;
                }
                loc3 = loc1.AverageSpeedDownhill;
                arg2.averageSpeedDownhillDefined = loc5 = !(loc3 == undefined);
                if (loc5 == true) 
                {
                    arg2.averageSpeedDownhill = loc3;
                }
                loc3 = loc1.AverageTemperature;
                arg2.averageTemperatureDefined = loc7 = !(loc3 == undefined);
                if (loc7 == true) 
                {
                    arg2.averageTemperature = loc3;
                }
                loc3 = arg1.GeneralInformation.Bike;
                arg2.bike = loc3 == undefined ? "noBike" : loc3;
                loc3 = loc1.BikeType1;
                arg2.bikeTypeDefined = loc6 = !(loc3 == undefined);
                if (loc6 == true) 
                {
                    arg2.bikeType = loc3;
                }
                if (undefined == arg1.GeneralInformation.BodyWeight) 
                {
                    if (loc1.Weight == undefined) 
                    {
                        arg2.bodyWeightDefined = false;
                    }
                    else 
                    {
                        arg2.bodyWeightDefined = true;
                        arg2.bodyWeight = loc1.Weight;
                    }
                }
                else 
                {
                    arg2.bodyWeightDefined = true;
                    arg2.bodyWeight = arg1.GeneralInformation.BodyWeight;
                }
                if (undefined == arg1.GeneralInformation.BodyWeightUnit) 
                {
                    if (loc1.BodyWeightUnit == undefined) 
                    {
                        arg2.bodyWeightUnitDefined = false;
                    }
                    else 
                    {
                        arg2.bodyWeightUnitDefined = true;
                        arg2.bodyWeightUnit = loc1.BodyWeightUnit;
                    }
                }
                else 
                {
                    arg2.bodyWeightUnitDefined = true;
                    arg2.bodyWeightUnit = arg1.GeneralInformation.BodyWeightUnit;
                }
                arg2.calibrationDefined = !(loc1.Calibration == undefined);
                arg2.calibration = loc1.Calibration != "true" ? false : true;
                loc3 = loc1.Calories;
                arg2.caloriesDefined = loc5 = !(loc3 == undefined);
                if (loc5 == true) 
                {
                    arg2.calories = loc3;
                }
                loc3 = loc1.CaloriesDifferenceFactor;
                arg2.caloriesDifferenceFactorDefined = loc7 = !(loc3 == undefined);
                if (loc7 == true) 
                {
                    arg2.caloriesDifferenceFactor = loc3;
                }
                loc3 = loc1.CorrectionChestRun;
                arg2.correctionChestRunDefined = loc6 = !(loc3 == undefined);
                if (loc6 == true) 
                {
                    arg2.correctionChestRun = loc3;
                    arg2.correctionChestWalk = loc1.CorrectionChestWalk;
                    arg2.correctionHipRun = loc1.CorrectionHipRun;
                    arg2.correctionHipWalk = loc1.CorrectionHipWalk;
                }
                arg2.correctionChestWalkDefined = arg2.correctionChestRunDefined;
                arg2.correctionHipRunDefined = arg2.correctionChestRunDefined;
                arg2.correctionHipWalkDefined = arg2.correctionChestRunDefined;
                loc3 = loc1.CorrectionFactor;
                arg2.correctionFactorDefined = loc5 = !(loc3 == undefined);
                if (loc5 == true) 
                {
                    arg2.correctionFactor = loc3;
                }
                loc3 = loc1.Distance;
                arg2.distanceDefined = loc7 = !(loc3 == undefined);
                if (loc7 == true) 
                {
                    arg2.distance = loc3;
                }
                loc3 = loc1.DistancePlus;
                arg2.distancePlusDefined = loc6 = !(loc3 == undefined);
                if (loc6 == true) 
                {
                    arg2.distancePlus = loc3;
                }
                loc3 = loc1.DistanceMinus;
                arg2.distanceMinusDefined = loc5 = !(loc3 == undefined);
                if (loc5 == true) 
                {
                    arg2.distanceMinus = loc3;
                }
                loc3 = loc1.DistanceDownhill;
                arg2.distanceDownhillDefined = loc7 = !(loc3 == undefined);
                if (loc7 == true) 
                {
                    arg2.distanceDownhill = loc3;
                }
                loc3 = loc1.DistanceUphill;
                arg2.distanceUphillDefined = loc6 = !(loc3 == undefined);
                if (loc6 == true) 
                {
                    arg2.distanceUphill = loc3;
                }
                loc3 = arg1.GeneralInformation.ExerciseTime;
                arg2.exerciseTimeDefined = loc5 = !(loc3 == undefined);
                if (loc5 == true) 
                {
                    arg2.exerciseTime = loc3;
                    arg2.exerciseTime = arg2.exerciseTime * 100;
                }
                if (undefined == arg1.GeneralInformation.Gender) 
                {
                    if (loc1.Gender == undefined) 
                    {
                        arg2.genderDefined = false;
                    }
                    else 
                    {
                        arg2.genderDefined = true;
                        arg2.gender = loc1.Gender;
                    }
                }
                else 
                {
                    arg2.genderDefined = true;
                    arg2.gender = arg1.GeneralInformation.Gender;
                }
                loc3 = loc1.HrMax;
                arg2.hrMaxDefined = loc7 = !(loc3 == undefined);
                if (loc7 != true) 
                {
                    loc3 = arg1.GeneralInformation.HRMax;
                    arg2.hrMaxDefined = loc6 = !(loc3 == undefined);
                    if (loc6 == true) 
                    {
                        arg2.hrMax = loc3;
                    }
                }
                else 
                {
                    arg2.hrMax = loc3;
                }
                loc3 = loc1.IntensityZone1Start;
                arg2.intensityZone1StartDefined = loc5 = !(loc3 == undefined);
                if (loc5 != true) 
                {
                    if (arg2.hrMaxDefined) 
                    {
                        arg2.intensityZone1Start = Math.round(arg2.hrMax * 0.6);
                        arg2.intensityZone2Start = Math.round(arg2.hrMax * 0.7);
                        arg2.intensityZone3Start = Math.round(arg2.hrMax * 0.8);
                        arg2.intensityZone4Start = Math.round(arg2.hrMax * 0.9);
                    }
                }
                else 
                {
                    arg2.intensityZone1Start = loc3;
                    arg2.intensityZone2Start = loc1.IntensityZone2Start;
                    arg2.intensityZone3Start = loc1.IntensityZone3Start;
                    arg2.intensityZone4Start = loc1.IntensityZone4Start;
                }
                if ((loc3 = loc1.IntensityZone4End) == undefined) 
                {
                    if (arg2.hrMaxDefined) 
                    {
                        arg2.intensityZone4End = arg2.hrMax;
                        arg2.intensityZone4EndDefined = true;
                    }
                }
                else 
                {
                    arg2.intensityZone4End = loc3;
                    arg2.intensityZone4EndDefined = true;
                }
                arg2.intensityZone4StartDefined = loc7 = arg2.intensityZone1StartDefined;
                arg2.intensityZone3StartDefined = loc6 = loc7;
                arg2.intensityZone2StartDefined = loc6;
                loc3 = loc1.LatitudeEnd;
                arg2.latitudeEndDefined = loc5 = !(loc3 == undefined);
                if (loc5 == true) 
                {
                    arg2.latitudeEnd = loc3;
                    arg2.latitudeStart = loc1.LatitudeStart;
                    arg2.longitudeEnd = loc1.LongitudeEnd;
                    arg2.longitudeStart = loc1.LongitudeStart;
                }
                arg2.longitudeStartDefined = loc7 = arg2.latitudeEndDefined;
                arg2.longitudeEndDefined = loc6 = loc7;
                arg2.latitudeStartDefined = loc6;
                loc3 = loc1.LowerLimit;
                arg2.lowerLimitDefined = loc5 = !(loc3 == undefined);
                if (loc5 == true) 
                {
                    arg2.lowerLimit = loc3;
                }
                if (parseInt(arg1.@revision) <= 210) 
                {
                    loc3 = loc1.MinimumAltitude;
                    arg2.minimumAltitudeDefined = loc7 = !(loc3 == undefined);
                    if (loc7 == true) 
                    {
                        arg2.minimumAltitude = loc1.MinimumAltitude * 1000;
                        arg2.maximumAltitude = loc1.MaximumAltitude * 1000;
                        arg2.averageAltitude = loc1.AverageAltitude * 1000;
                    }
                    arg2.averageAltitudeDefined = loc6 = arg2.minimumAltitudeDefined;
                    arg2.maximumAltitudeDefined = loc6;
                    loc3 = loc1.MinimumRiseRate;
                    arg2.minimumRiseRateDefined = loc5 = !(loc3 == undefined);
                    if (loc5 == true) 
                    {
                        arg2.minimumRiseRate = loc1.MinimumRiseRate * 1000;
                        arg2.maximumRiseRate = loc1.MaximumRiseRate * 1000;
                        arg2.averageRiseRate = loc1.AverageRiseRate * 1000;
                    }
                    arg2.averageRiseRateDefined = loc7 = arg2.minimumRiseRateDefined;
                    arg2.maximumRiseRateDefined = loc7;
                    loc3 = loc1.AltitudeDifferencesUphill;
                    arg2.altitudeDifferencesUphillDefined = loc6 = !(loc3 == undefined);
                    if (loc6 == true) 
                    {
                        arg2.altitudeDifferencesUphill = loc1.AltitudeDifferencesUphill * 1000;
                        arg2.altitudeDifferencesDownhill = loc1.AltitudeDifferencesDownhill * 1000;
                    }
                    arg2.altitudeDifferencesDownhillDefined = arg2.altitudeDifferencesUphillDefined;
                }
                else 
                {
                    loc3 = loc1.MinimumAltitude;
                    arg2.minimumAltitudeDefined = loc5 = !(loc3 == undefined);
                    if (loc5 == true) 
                    {
                        arg2.minimumAltitude = loc3;
                    }
                    loc3 = loc1.MaximumAltitude;
                    arg2.maximumAltitudeDefined = loc7 = !(loc3 == undefined);
                    if (loc7 == true) 
                    {
                        arg2.maximumAltitude = loc3;
                    }
                    loc3 = loc1.AverageAltitude;
                    arg2.averageAltitudeDefined = loc6 = !(loc3 == undefined);
                    if (loc6 == true) 
                    {
                        arg2.averageAltitude = loc3;
                    }
                    loc3 = loc1.MinimumRiseRate;
                    arg2.minimumRiseRateDefined = loc5 = !(loc3 == undefined);
                    if (loc5 == true) 
                    {
                        arg2.minimumRiseRate = loc1.MinimumRiseRate;
                        arg2.maximumRiseRate = loc1.MaximumRiseRate;
                        arg2.averageRiseRate = loc1.AverageRiseRate;
                    }
                    arg2.averageRiseRateDefined = loc7 = arg2.minimumRiseRateDefined;
                    arg2.maximumRiseRateDefined = loc7;
                    loc3 = loc1.AltitudeDifferencesUphill;
                    arg2.altitudeDifferencesUphillDefined = loc6 = !(loc3 == undefined);
                    if (loc6 == true) 
                    {
                        arg2.altitudeDifferencesUphill = loc3;
                    }
                    loc3 = loc1.AltitudeDifferencesDownhill;
                    arg2.altitudeDifferencesDownhillDefined = loc5 = !(loc3 == undefined);
                    if (loc5 == true) 
                    {
                        arg2.altitudeDifferencesDownhill = loc3;
                    }
                }
                loc3 = loc1.MaximumCadence;
                arg2.maximumCadenceDefined = loc7 = !(loc3 == undefined);
                if (loc7 == true) 
                {
                    arg2.maximumCadence = loc3;
                }
                loc3 = loc1.MaximumHeartrate;
                arg2.maximumHeartrateDefined = loc6 = !(loc3 == undefined);
                if (loc6 == true) 
                {
                    arg2.maximumHeartrate = loc3;
                }
                loc3 = loc1.MaximumIncline;
                arg2.maximumInclineDefined = loc5 = !(loc3 == undefined);
                if (loc5 == true) 
                {
                    arg2.maximumIncline = loc3;
                }
                loc3 = loc1.MaximumInclineDownhill;
                arg2.maximumInclineDownhillDefined = loc7 = !(loc3 == undefined);
                if (loc7 == true) 
                {
                    arg2.maximumInclineDownhill = loc3;
                }
                loc3 = loc1.MaximumInclineUphill;
                arg2.maximumInclineUphillDefined = loc6 = !(loc3 == undefined);
                if (loc6 == true) 
                {
                    arg2.maximumInclineUphill = loc3;
                }
                loc3 = loc1.MaximumPercentHRMax;
                arg2.maximumPercentHRMaxDefined = loc5 = !(loc3 == undefined);
                if (loc5 == true) 
                {
                    arg2.maximumPercentHRMax = loc3;
                }
                loc3 = loc1.MaximumPower;
                arg2.maximumPowerDefined = loc7 = !(loc3 == undefined);
                if (loc7 == true) 
                {
                    arg2.maximumPower = loc3;
                }
                loc3 = loc1.MaximumSpeed;
                arg2.maximumSpeedDefined = loc6 = !(loc3 == undefined);
                if (loc6 == true) 
                {
                    arg2.maximumSpeed = loc3;
                }
                loc3 = loc1.MaximumTemperature;
                arg2.maximumTemperatureDefined = loc5 = !(loc3 == undefined);
                if (loc5 != true) 
                {
                    loc3 = loc1.MaximalTemperature;
                    arg2.maximumTemperatureDefined = loc7 = !(loc3 == undefined);
                    if (loc7 == true) 
                    {
                        arg2.maximumTemperature = loc3;
                    }
                }
                else 
                {
                    arg2.maximumTemperature = loc3;
                }
                loc3 = loc1.MinimumCadence;
                arg2.minimumCadenceDefined = loc6 = !(loc3 == undefined);
                if (loc6 == true) 
                {
                    arg2.minimumCadence = loc3;
                }
                loc3 = loc1.MinimumHeartrate;
                arg2.minimumHeartrateDefined = loc5 = !(loc3 == undefined);
                if (loc5 == true) 
                {
                    arg2.minimumHeartrate = loc3;
                }
                loc3 = loc1.MinimumIncline;
                arg2.minimumInclineDefined = loc7 = !(loc3 == undefined);
                if (loc7 == true) 
                {
                    arg2.minimumIncline = loc3;
                }
                loc3 = loc1.MinimumPercentHRMax;
                arg2.minimumPercentHRMaxDefined = loc6 = !(loc3 == undefined);
                if (loc6 == true) 
                {
                    arg2.minimumPercentHRMax = loc3;
                }
                loc3 = loc1.MinimumPower;
                arg2.minimumPowerDefined = loc5 = !(loc3 == undefined);
                if (loc5 == true) 
                {
                    arg2.minimumPower = loc3;
                }
                loc3 = loc1.MinimumSpeed;
                arg2.minimumSpeedDefined = loc7 = !(loc3 == undefined);
                if (loc7 == true) 
                {
                    arg2.minimumSpeed = loc3;
                }
                loc3 = loc1.MinimumTemperature;
                arg2.minimumTemperatureDefined = loc6 = !(loc3 == undefined);
                if (loc6 != true) 
                {
                    loc3 = loc1.MinimalTemperature;
                    arg2.minimumTemperatureDefined = loc5 = !(loc3 == undefined);
                    if (loc5 == true) 
                    {
                        arg2.minimumTemperature = loc3;
                    }
                }
                else 
                {
                    arg2.minimumTemperature = loc3;
                }
                loc3 = loc1.PowerZone1Start;
                arg2.powerZone1StartDefined = loc7 = !(loc3 == undefined);
                if (loc7 == true) 
                {
                    arg2.powerZone1Start = loc3;
                    arg2.powerZone2Start = loc1.PowerZone2Start;
                    arg2.powerZone3Start = loc1.PowerZone3Start;
                    arg2.powerZone4Start = loc1.PowerZone4Start;
                    arg2.powerZone5Start = loc1.PowerZone5Start;
                    arg2.powerZone6Start = loc1.PowerZone6Start;
                    arg2.powerZone7End = loc1.PowerZone7End;
                    arg2.powerZone7Start = loc1.PowerZone7Start;
                }
                arg2.powerZone7StartDefined = loc6 = arg2.powerZone1StartDefined;
                arg2.powerZone7EndDefined = loc5 = loc6;
                arg2.powerZone6StartDefined = loc7 = loc5;
                arg2.powerZone5StartDefined = loc6 = loc7;
                arg2.powerZone4StartDefined = loc5 = loc6;
                arg2.powerZone3StartDefined = loc7 = loc5;
                arg2.powerZone2StartDefined = loc7;
                loc3 = loc1.RideTimeDownhill;
                arg2.trainingTimeDownhillDefined = loc6 = !(loc3 == undefined);
                if (loc6 != true) 
                {
                    loc3 = loc1.TimeDownhill;
                    arg2.trainingTimeDownhillDefined = loc5 = !(loc3 == undefined);
                    if (loc5 == true) 
                    {
                        arg2.trainingTimeDownhill = loc3;
                        arg2.trainingTimeDownhill = arg2.trainingTimeDownhill * 100;
                    }
                }
                else 
                {
                    arg2.trainingTimeDownhill = loc3;
                    arg2.trainingTimeDownhill = arg2.trainingTimeDownhill * 100;
                }
                loc3 = loc1.RideTimeUphill;
                arg2.trainingTimeUphillDefined = loc7 = !(loc3 == undefined);
                if (loc7 != true) 
                {
                    loc3 = loc1.TimeUphill;
                    arg2.trainingTimeUphillDefined = loc6 = !(loc3 == undefined);
                    if (loc6 == true) 
                    {
                        arg2.trainingTimeUphill = loc3;
                        arg2.trainingTimeUphill = arg2.trainingTimeUphill * 100;
                    }
                }
                else 
                {
                    arg2.trainingTimeUphill = loc3;
                    arg2.trainingTimeUphill = arg2.trainingTimeUphill * 100;
                }
                loc3 = loc1.RXBatteryStatus;
                arg2.rxBatteryStatusDefined = loc5 = !(loc3 == undefined);
                if (loc5 == true) 
                {
                    arg2.rxBatteryStatus = loc3;
                }
                loc3 = loc1.ShoulderWidth;
                arg2.shoulderWidthDefined = loc7 = !(loc3 == undefined);
                if (loc7 == true) 
                {
                    arg2.shoulderWidth = loc3;
                }
                loc3 = loc1.ShoulderWidthUnit;
                arg2.shoulderWidthUnitDefined = loc6 = !(loc3 == undefined);
                if (loc6 == true) 
                {
                    arg2.shoulderWidthUnit = loc3;
                }
                loc3 = loc1.ThresholdPower;
                arg2.thresholdPowerDefined = loc5 = !(loc3 == undefined);
                if (loc5 == true) 
                {
                    arg2.thresholdPower = loc3;
                }
                loc3 = loc1.TimeInIntensityZone1;
                arg2.timeInIntensityZone1Defined = loc7 = !(loc3 == undefined);
                if (loc7 == true) 
                {
                    arg2.timeInIntensityZone1 = loc3;
                    arg2.timeInIntensityZone1 = arg2.timeInIntensityZone1 * 100;
                    arg2.timeInIntensityZone2 = loc1.TimeInIntensityZone2;
                    arg2.timeInIntensityZone2 = arg2.timeInIntensityZone2 * 100;
                    arg2.timeInIntensityZone3 = loc1.TimeInIntensityZone3;
                    arg2.timeInIntensityZone3 = arg2.timeInIntensityZone3 * 100;
                    arg2.timeInIntensityZone4 = loc1.TimeInIntensityZone4;
                    arg2.timeInIntensityZone4 = arg2.timeInIntensityZone4 * 100;
                    arg2.timeOverIntensityZone = loc1.TimeOverIntensityZone;
                    arg2.timeOverIntensityZone = arg2.timeOverIntensityZone * 100;
                    arg2.timeUnderIntensityZone = loc1.TimeUnderIntensityZone;
                    arg2.timeUnderIntensityZone = arg2.timeUnderIntensityZone * 100;
                }
                arg2.timeUnderIntensityZoneDefined = loc6 = arg2.timeInIntensityZone1Defined;
                arg2.timeOverIntensityZoneDefined = loc5 = loc6;
                arg2.timeInIntensityZone4Defined = loc7 = loc5;
                arg2.timeInIntensityZone3Defined = loc6 = loc7;
                arg2.timeInIntensityZone2Defined = loc6;
                if (undefined == loc1.TimeInZone) 
                {
                    if (undefined == loc1.TimeInTargetZone) 
                    {
                        arg2.timeInZoneDefined = false;
                    }
                    else 
                    {
                        arg2.timeInZoneDefined = true;
                        arg2.timeInZone = loc1.TimeInTargetZone;
                        arg2.timeInZone = arg2.timeInZone * 100;
                    }
                }
                else 
                {
                    arg2.timeInZoneDefined = true;
                    arg2.timeInZone = loc1.TimeInZone;
                    arg2.timeInZone = arg2.timeInZone * 100;
                }
                if (undefined == loc1.TimeOverZone) 
                {
                    if (undefined == loc1.TimeOverTargetZone) 
                    {
                        arg2.timeOverZoneDefined = false;
                    }
                    else 
                    {
                        arg2.timeOverZoneDefined = true;
                        arg2.timeOverZone = loc1.TimeOverTargetZone;
                        arg2.timeOverZone = arg2.timeOverZone * 100;
                    }
                }
                else 
                {
                    arg2.timeOverZoneDefined = true;
                    arg2.timeOverZone = loc1.TimeOverZone;
                    arg2.timeOverZone = arg2.timeOverZone * 100;
                }
                if (undefined == loc1.TimeUnderZone) 
                {
                    if (undefined == loc1.TimeUnderTargetZone) 
                    {
                        arg2.timeUnderZoneDefined = false;
                    }
                    else 
                    {
                        arg2.timeUnderZoneDefined = true;
                        arg2.timeUnderZone = loc1.TimeUnderTargetZone;
                        arg2.timeUnderZone = arg2.timeUnderZone * 100;
                    }
                }
                else 
                {
                    arg2.timeUnderZoneDefined = true;
                    arg2.timeUnderZone = loc1.TimeUnderZone;
                    arg2.timeUnderZone = arg2.timeUnderZone * 100;
                }
                loc3 = loc1.TimeInZone1;
                arg2.timeInZone1Defined = loc5 = !(loc3 == undefined);
                if (loc5 == true) 
                {
                    arg2.timeInZone1 = loc1.TimeInZone1;
                    arg2.timeInZone1 = arg2.timeInZone1 * 100;
                    arg2.timeInZone2 = loc1.TimeInZone2;
                    arg2.timeInZone2 = arg2.timeInZone2 * 100;
                    arg2.timeInZone3 = loc1.TimeInZone3;
                    arg2.timeInZone3 = arg2.timeInZone3 * 100;
                }
                arg2.timeInZone3Defined = loc7 = arg2.timeInZone1Defined;
                arg2.timeInZone2Defined = loc7;
                if (undefined == loc1.TargetZone) 
                {
                    if (undefined == loc1.TrainingZone) 
                    {
                        arg2.trainingZoneDefined = false;
                    }
                    else 
                    {
                        arg2.trainingZoneDefined = true;
                        arg2.trainingZone = loc1.TrainingZone;
                    }
                }
                else 
                {
                    arg2.trainingZoneDefined = true;
                    arg2.trainingZone = loc1.TargetZone;
                }
                loc3 = loc1.TXBatteryStatus;
                arg2.txBatteryStatusDefined = loc6 = !(loc3 == undefined);
                if (loc6 == true) 
                {
                    arg2.txBatteryStatus = loc3;
                }
                loc3 = loc1.UpperLimit;
                arg2.upperLimitDefined = loc5 = !(loc3 == undefined);
                if (loc5 == true) 
                {
                    arg2.upperLimit = loc3;
                }
                loc3 = loc1.WorkInKJ;
                arg2.workInKJDefined = loc7 = !(loc3 == undefined);
                if (loc7 == true) 
                {
                    arg2.workInKJ = loc3;
                }
                loc3 = loc1.Zone1Start;
                arg2.zone1StartDefined = loc6 = !(loc3 == undefined);
                if (loc6 != true) 
                {
                    loc3 = arg1.GeneralInformation.StartZone1;
                    arg2.zone1StartDefined = loc5 = !(loc3 == undefined);
                    if (loc5 == true) 
                    {
                        arg2.zone1Start = loc3;
                        arg2.zone2Start = arg1.GeneralInformation.StartZone2;
                        arg2.zone3Start = arg1.GeneralInformation.StartZone3;
                        arg2.zone3End = arg1.GeneralInformation.EndZone3;
                    }
                }
                else 
                {
                    arg2.zone1Start = loc3;
                    arg2.zone2Start = loc1.Zone2Start;
                    arg2.zone3End = loc1.Zone3End;
                    arg2.zone3Start = loc1.Zone3Start;
                }
                arg2.zone3StartDefined = loc7 = arg2.zone1StartDefined;
                arg2.zone3EndDefined = loc6 = loc7;
                arg2.zone2StartDefined = loc6;
            }
            else 
            {
                fromSLF400(arg1, arg2);
            }
            if (arg3) 
            {
                loadEntries(arg1, arg2, loc4);
                loadMarkers(arg1, arg2, loc4);
                if (arg2.entries.length > 0 || arg2.markerList.length > 0) 
                {
                    arg2.dataType = "log";
                }
            }
            if (loc4 < 400 && arg2.dataType == "log") 
            {
                handler.ActivityCalculator.calculateMinMaxAvgValues(arg2);
            }
            if (arg2.userId == 0) 
            {
                arg2.userId = 1;
            }
            return arg2;
        }

        public static function generateCSV(arg1:core.activities.Activity):__AS3__.vec.Vector.<String>
        {
            var loc1:*=(arg1.ageDefined ? arg1.age + "," : "") + (arg1.GUID == "" ? "" : arg1.GUID + ",") + (arg1.modificationDate == 0 ? "" : arg1.modificationDate + ",") + (arg1.altitudeDifferencesDownhillDefined ? arg1.altitudeDifferencesDownhill + "," : "") + (arg1.altitudeDifferencesUphillDefined ? arg1.altitudeDifferencesUphill + "," : "") + (arg1.averageCadenceDefined ? arg1.averageCadence + "," : "") + (arg1.averageExpansionDefined ? arg1.averageExpansion + "," : "") + (arg1.averageExpansionDownhillDefined ? arg1.averageExpansionDownhill + "," : "") + (arg1.averageExpansionUphillDefined ? arg1.averageExpansionUphill + "," : "") + (arg1.averageHeartrateDefined ? arg1.averageHeartrate + "," : "") + (arg1.averageInclineDownhillDefined ? arg1.averageInclineDownhill + "," : "") + (arg1.averageInclineUphillDefined ? arg1.averageInclineUphill + "," : "") + (arg1.averagePercentHRMaxDefined ? arg1.averagePercentHRMax + "," : "") + (arg1.averagePowerKJDefined ? arg1.averagePowerKJ + "," : "") + (arg1.averagePowerWattPerKGDefined ? arg1.averagePowerWattPerKG + "," : "") + (arg1.averageSpeedDefined ? arg1.averageSpeed + "," : "") + (arg1.averageSpeedDownhillDefined ? arg1.averageSpeedDownhill + "," : "") + (arg1.averageSpeedUphillDefined ? arg1.averageSpeedUphill + "," : "") + arg1.bike + "," + (arg1.caloriesDefined ? arg1.calories + "," : "") + (arg1.unitDefined ? arg1.unitType.toString() + "," : "") + (arg1.descriptionDefined ? arg1.description + "," : "") + (arg1.distanceDefined ? arg1.distance + "," : "") + (arg1.distanceDownhillDefined ? arg1.distanceDownhill + "," : "") + (arg1.distanceMinusDefined ? arg1.distanceMinus + "," : "") + (arg1.distancePlusDefined ? arg1.distancePlus + "," : "") + (arg1.distancePlusMinusStatusDefined ? arg1.distancePlusMinusStatus + "," : "") + (arg1.distanceUphillDefined ? arg1.distanceUphill + "," : "") + (arg1.zone1StartDefined ? arg1.zone1Start + "," : "") + (arg1.zone2StartDefined ? arg1.zone2Start + "," : "") + (arg1.zone3StartDefined ? arg1.zone3Start + "," : "") + (arg1.zone3EndDefined ? arg1.zone3End + "," : "") + (arg1.exerciseTimeDefined ? arg1.exerciseTime + "," : "") + (arg1.fuelEconomyDefined ? arg1.fuelEconomy + "," : "") + (arg1.hrMaxDefined ? arg1.hrMax + "," : "") + (arg1.percentTimeInIntensityZone1Defined ? arg1.percentTimeInIntensityZone1Defined + "," : "") + (arg1.percentTimeInIntensityZone2Defined ? arg1.percentTimeInIntensityZone2Defined + "," : "") + (arg1.percentTimeInIntensityZone3Defined ? arg1.percentTimeInIntensityZone3Defined + "," : "") + (arg1.percentTimeInIntensityZone4Defined ? arg1.percentTimeInIntensityZone4Defined + "," : "") + (arg1.maximumAltitudeDefined ? arg1.maximumAltitude + "," : "") + (arg1.maximumCadenceDefined ? arg1.maximumCadence + "," : "") + (arg1.maximumHeartrateDefined ? arg1.maximumHeartrate + "," : "") + (arg1.maximumInclineDownhillDefined ? arg1.maximumInclineDownhill + "," : "") + (arg1.maximumInclineUphillDefined ? arg1.maximumInclineUphill + "," : "") + (arg1.maximumPowerDefined ? arg1.maximumPower + "," : "") + (arg1.maximumRiseRateDownhillDefined ? arg1.maximumRiseRateDownhill + "," : "") + (arg1.maximumRiseRateUphillDefined ? arg1.maximumRiseRateUphill + "," : "") + (arg1.maximumSpeedDefined ? arg1.maximumSpeed + "," : "") + (arg1.maximumTemperatureDefined ? arg1.maximumTemperature + "," : "") + (arg1.minimumTemperatureDefined ? arg1.minimumTemperature + "," : "") + arg1.name + "," + (arg1.participant ? arg1.participant.toLocaleString() + "," : "") + (arg1.trackProfileDefined ? arg1.trackProfileDefined + "," : "") + (arg1.ratingDefined ? arg1.rating + "," : "") + (arg1.feelingDefined ? arg1.feeling + "," : "") + (arg1.trainingTimeDownhillDefined ? arg1.trainingTimeDownhill + "," : "") + (arg1.trainingTimeUphillDefined ? arg1.trainingTimeUphill + "," : "") + (arg1.serialNumberDefined ? arg1.serialNumber + "," : "") + (arg1.startDateDefined ? arg1.startDate + "," : "") + (arg1.manualTemperatureDefined ? arg1.manualTemperature + "," : "") + (arg1.timeInIntensityZone1Defined ? arg1.timeInIntensityZone1 + "," : "") + (arg1.timeInIntensityZone2Defined ? arg1.timeInIntensityZone2 + "," : "") + (arg1.timeInIntensityZone3Defined ? arg1.timeInIntensityZone3 + "," : "") + (arg1.timeInIntensityZone4Defined ? arg1.timeInIntensityZone4 + "," : "") + (arg1.timeInPowerZone1Defined ? arg1.timeInPowerZone1 + "," : "") + (arg1.timeInPowerZone2Defined ? arg1.timeInPowerZone2 + "," : "") + (arg1.timeInPowerZone3Defined ? arg1.timeInPowerZone3 + "," : "") + (arg1.timeInPowerZone4Defined ? arg1.timeInPowerZone4 + "," : "") + (arg1.timeInPowerZone5Defined ? arg1.timeInPowerZone5 + "," : "") + (arg1.timeInPowerZone6Defined ? arg1.timeInPowerZone6 + "," : "") + (arg1.timeInPowerZone7Defined ? arg1.timeInPowerZone7 + "," : "") + (arg1.timeInZone1Defined ? arg1.timeInZone1 + "," : "") + (arg1.timeInZone2Defined ? arg1.timeInZone2 + "," : "") + (arg1.timeInZone3Defined ? arg1.timeInZone3 + "," : "") + (arg1.trainingTypeDefined ? arg1.trainingType.toString() + "," : "") + (arg1.trainingTimeDefined ? arg1.trainingTime + "," : "") + (arg1.tripSectionDistanceDefined ? arg1.tripSectionDistance + "," : "") + (arg1.tripSectionTimeDefined ? arg1.tripSectionTime + "," : "") + (arg1.weatherDefined ? arg1.weather + "," : "") + (arg1.wheelSizeDefined ? arg1.wheelSize + "," : "") + (arg1.windDefined ? arg1.wind + "" : "");
            return __AS3__.vec.Vector.<String>(loc1.split(","));
        }

        public static function generateDBInsert(arg1:core.activities.Activity, arg2:Array, arg3:Object):void
        {
            if (arg1 == null) 
            {
                return;
            }
            if (arg1.GUID == "" || arg1.GUID == "0") 
            {
                arg1.GUID = utils.GUID.create();
            }
            if (arg1.modificationDate == 0) 
            {
                arg1.modificationDate = new Date().time;
            }
            arg2.push("activityStatus");
            arg3[":activityStatus"] = arg1.activityStatus;
            if (arg1.activityId > 0) 
            {
                arg2.push("activityId");
                arg3[":activityId"] = arg1.activityId;
            }
            if (arg1.GUID != "") 
            {
                arg2.push("GUID");
                arg3[":GUID"] = arg1.GUID;
            }
            if (arg1.modificationDate != 0) 
            {
                arg2.push("modificationDate");
                arg3[":modificationDate"] = arg1.modificationDate;
            }
            if (arg1.ageDefined) 
            {
                arg2.push("age");
                arg3[":age"] = arg1.age;
            }
            if (arg1.altitudeDifferencesDownhillDefined) 
            {
                arg2.push("altitudeDifferencesDownhill");
                arg3[":altitudeDifferencesDownhill"] = arg1.altitudeDifferencesDownhill;
            }
            if (arg1.altitudeDifferencesUphillDefined) 
            {
                arg2.push("altitudeDifferencesUphill");
                arg3[":altitudeDifferencesUphill"] = arg1.altitudeDifferencesUphill;
            }
            if (arg1.averageAltitudeDefined) 
            {
                arg2.push("averageAltitude");
                arg3[":averageAltitude"] = arg1.averageAltitude;
            }
            if (arg1.averageCadenceDefined) 
            {
                arg2.push("averageCadence");
                arg3[":averageCadence"] = arg1.averageCadence;
            }
            if (arg1.averageExpansionDefined) 
            {
                arg2.push("averageExpansion");
                arg3[":averageExpansion"] = arg1.averageExpansion;
            }
            if (arg1.averageExpansionDownhillDefined) 
            {
                arg2.push("averageExpansionDownhill");
                arg3[":averageExpansionDownhill"] = arg1.averageExpansionDownhill;
            }
            if (arg1.averageExpansionUphillDefined) 
            {
                arg2.push("averageExpansionUphill");
                arg3[":averageExpansionUphill"] = arg1.averageExpansionUphill;
            }
            if (arg1.averageHeartrateDefined) 
            {
                arg2.push("averageHeartrate");
                arg3[":averageHeartrate"] = arg1.averageHeartrate;
            }
            if (arg1.averageInclineDownhill) 
            {
                arg2.push("averageInclineDownhill");
                arg3[":averageInclineDownhill"] = arg1.averageInclineDownhill;
            }
            if (arg1.averageInclineUphillDefined) 
            {
                arg2.push("averageInclineUphill");
                arg3[":averageInclineUphill"] = arg1.averageInclineUphill;
            }
            if (arg1.averagePercentHRMaxDefined) 
            {
                arg2.push("averagePercentHRMax");
                arg3[":averagePercentHRMax"] = arg1.averagePercentHRMax;
            }
            if (arg1.averagePowerDefined) 
            {
                arg2.push("averagePower");
                arg3[":averagePower"] = arg1.averagePower;
            }
            if (arg1.averagePowerKJDefined) 
            {
                arg2.push("averagePowerKJ");
                arg3[":averagePowerKJ"] = arg1.averagePowerKJ;
            }
            if (arg1.averagePowerWattPerKGDefined) 
            {
                arg2.push("averagePowerWattPerKG");
                arg3[":averagePowerWattPerKG"] = arg1.averagePowerWattPerKG;
            }
            if (arg1.averageRiseRateDefined) 
            {
                arg2.push("averageRiseRate");
                arg3[":averageRiseRate"] = arg1.averageRiseRate;
            }
            if (arg1.averageRiseRateUphillDefined) 
            {
                arg2.push("averageRiseRateUphill");
                arg3[":averageRiseRateUphill"] = arg1.averageRiseRateUphill;
            }
            if (arg1.averageRiseRateDownhillDefined) 
            {
                arg2.push("averageRiseRateDownhill");
                arg3[":averageRiseRateDownhill"] = arg1.averageRiseRateDownhill;
            }
            if (arg1.averageSpeedDefined) 
            {
                arg2.push("averageSpeed");
                arg3[":averageSpeed"] = arg1.averageSpeed;
            }
            if (arg1.averageSpeedDownhillDefined) 
            {
                arg2.push("averageSpeedDownhill");
                arg3[":averageSpeedDownhill"] = arg1.averageSpeedDownhill;
            }
            if (arg1.averageSpeedUphillDefined) 
            {
                arg2.push("averageSpeedUphill");
                arg3[":averageSpeedUphill"] = arg1.averageSpeedUphill;
            }
            if (arg1.averageTemperatureDefined) 
            {
                arg2.push("averageTemperature");
                arg3[":averageTemperature"] = arg1.averageTemperature;
            }
            arg2.push("bike");
            arg3[":bike"] = arg1.bike;
            if (arg1.bikeTypeDefined) 
            {
                arg2.push("bikeType");
                arg3[":bikeType"] = arg1.bikeType;
            }
            if (arg1.bikeWeightDefined) 
            {
                arg2.push("bikeWeight");
                arg3[":bikeWeight"] = arg1.bikeWeight;
            }
            if (arg1.bikeWeightUnitDefined) 
            {
                arg2.push("bikeWeightUnit");
                arg3[":bikeWeightUnit"] = arg1.bikeWeightUnit;
            }
            if (arg1.bodyHeightDefined) 
            {
                arg2.push("bodyHeight");
                arg3[":bodyHeight"] = arg1.bodyHeight;
            }
            if (arg1.bodyHeightUnitDefined) 
            {
                arg2.push("bodyHeightUnit");
                arg3[":bodyHeightUnit"] = arg1.bodyHeightUnit;
            }
            if (arg1.bodyWeightDefined) 
            {
                arg2.push("bodyWeight");
                arg3[":bodyWeight"] = arg1.bodyWeight;
            }
            if (arg1.bodyWeightUnitDefined) 
            {
                arg2.push("bodyWeightUnit");
                arg3[":bodyWeightUnit"] = arg1.bodyWeightUnit;
            }
            if (arg1.calibrationDefined) 
            {
                arg2.push("calibration");
                arg3[":calibration"] = arg1.calibration;
            }
            if (arg1.caloriesDefined) 
            {
                arg2.push("calories");
                arg3[":calories"] = arg1.calories;
            }
            if (arg1.caloriesDifferenceFactorDefined) 
            {
                arg2.push("caloriesDifferenceFactor");
                arg3[":caloriesDifferenceFactor"] = arg1.caloriesDifferenceFactor;
            }
            if (arg1.correctionChestRunDefined) 
            {
                arg2.push("correctionChestRun");
                arg3[":correctionChestRun"] = arg1.correctionChestRun;
            }
            if (arg1.correctionChestWalkDefined) 
            {
                arg2.push("correctionChestWalk");
                arg3[":correctionChestWalk"] = arg1.correctionChestWalk;
            }
            if (arg1.correctionFactorDefined) 
            {
                arg2.push("correctionFactor");
                arg3[":correctionFactor"] = arg1.correctionFactor;
            }
            if (arg1.correctionHipRunDefined) 
            {
                arg2.push("correctionHipRun");
                arg3[":correctionHipRun"] = arg1.correctionHipRun;
            }
            if (arg1.correctionHipWalkDefined) 
            {
                arg2.push("correctionHipWalk");
                arg3[":correctionHipWalk"] = arg1.correctionHipWalk;
            }
            arg2.push("dataType");
            arg3[":dataType"] = arg1.dataType;
            if (arg1.dateCodeDefined) 
            {
                arg2.push("dateCode");
                arg3[":dateCode"] = arg1.dateCode;
            }
            if (arg1.descriptionDefined) 
            {
                arg2.push("description");
                arg3[":description"] = arg1.description;
            }
            if (arg1.distanceDefined) 
            {
                arg2.push("distance");
                arg3[":distance"] = arg1.distance;
            }
            if (arg1.distanceDownhillDefined) 
            {
                arg2.push("distanceDownhill");
                arg3[":distanceDownhill"] = arg1.distanceDownhill;
            }
            if (arg1.distanceMinusDefined) 
            {
                arg2.push("distanceMinus");
                arg3[":distanceMinus"] = arg1.distanceMinus;
            }
            if (arg1.distancePlusDefined) 
            {
                arg2.push("distancePlus");
                arg3[":distancePlus"] = arg1.distancePlus;
            }
            if (arg1.distancePlusMinusStatusDefined) 
            {
                arg2.push("distancePlusMinusStatus");
                arg3[":distancePlusMinusStatus"] = arg1.distancePlusMinusStatus;
            }
            if (arg1.distanceUphillDefined) 
            {
                arg2.push("distanceUphill");
                arg3[":distanceUphill"] = arg1.distanceUphill;
            }
            if (arg1.exerciseTimeDefined) 
            {
                arg2.push("exerciseTime");
                arg3[":exerciseTime"] = arg1.exerciseTime;
            }
            if (arg1.externalLinkDefined) 
            {
                arg2.push("externalLink");
                arg3[":externalLink"] = arg1.externalLink;
            }
            if (arg1.fuelEconomyDefined) 
            {
                arg2.push("fuelEconomy");
                arg3[":fuelEconomy"] = arg1.fuelEconomy;
            }
            if (arg1.genderDefined) 
            {
                arg2.push("gender");
                arg3[":gender"] = arg1.gender;
            }
            if (arg1.hrMaxDefined) 
            {
                arg2.push("hrMax");
                arg3[":hrMax"] = arg1.hrMax;
            }
            if (arg1.intensityZone1StartDefined) 
            {
                arg2.push("intensityZone1Start");
                arg3[":intensityZone1Start"] = arg1.intensityZone1Start;
            }
            if (arg1.intensityZone2StartDefined) 
            {
                arg2.push("intensityZone2Start");
                arg3[":intensityZone2Start"] = arg1.intensityZone2Start;
            }
            if (arg1.intensityZone3StartDefined) 
            {
                arg2.push("intensityZone3Start");
                arg3[":intensityZone3Start"] = arg1.intensityZone3Start;
            }
            if (arg1.intensityZone4StartDefined) 
            {
                arg2.push("intensityZone4Start");
                arg3[":intensityZone4Start"] = arg1.intensityZone4Start;
            }
            if (arg1.intensityZone4EndDefined) 
            {
                arg2.push("intensityZone4End");
                arg3[":intensityZone4End"] = arg1.intensityZone4End;
            }
            arg2.push("isDeleted");
            arg3[":isDeleted"] = arg1.isDeleted;
            if (arg1.latitudeEndDefined) 
            {
                arg2.push("latitudeEnd");
                arg3[":latitudeEnd"] = arg1.latitudeEnd;
            }
            if (arg1.latitudeStartDefined) 
            {
                arg2.push("latitudeStart");
                arg3[":latitudeStart"] = arg1.latitudeStart;
            }
            if (arg1.linkedRouteIdDefined) 
            {
                arg2.push("linkedRouteId");
                arg3[":linkedRouteId"] = arg1.linkedRouteId;
            }
            arg2.push("linkedTrackGUID");
            arg3[":linkedTrackGUID"] = arg1.linkedTrackGUID;
            if (arg1.logTypeDefined && arg1.logType) 
            {
                arg2.push("logType");
                arg3[":logType"] = arg1.logType.toString();
            }
            if (arg1.logVersionDefined) 
            {
                arg2.push("logVersion");
                arg3[":logVersion"] = arg1.logVersion;
            }
            if (arg1.longitudeEndDefined) 
            {
                arg2.push("longitudeEnd");
                arg3[":longitudeEnd"] = arg1.longitudeEnd;
            }
            if (arg1.longitudeStartDefined) 
            {
                arg2.push("longitudeStart");
                arg3[":longitudeStart"] = arg1.longitudeStart;
            }
            if (arg1.lowerLimitDefined) 
            {
                arg2.push("lowerLimit");
                arg3[":lowerLimit"] = arg1.lowerLimit;
            }
            if (arg1.manualTemperatureDefined) 
            {
                arg2.push("manualTemperature");
                arg3[":manualTemperature"] = arg1.manualTemperature;
            }
            if (arg1.maximumAltitudeDefined) 
            {
                arg2.push("maximumAltitude");
                arg3[":maximumAltitude"] = arg1.maximumAltitude;
            }
            if (arg1.maximumCadenceDefined) 
            {
                arg2.push("maximumCadence");
                arg3[":maximumCadence"] = arg1.maximumCadence;
            }
            if (arg1.maximumHeartrateDefined) 
            {
                arg2.push("maximumHeartrate");
                arg3[":maximumHeartrate"] = arg1.maximumHeartrate;
            }
            if (arg1.maximumInclineDefined) 
            {
                arg2.push("maximumIncline");
                arg3[":maximumIncline"] = arg1.maximumIncline;
            }
            if (arg1.maximumInclineDownhillDefined) 
            {
                arg2.push("maximumInclineDownhill");
                arg3[":maximumInclineDownhill"] = arg1.maximumInclineDownhill;
            }
            if (arg1.maximumInclineUphillDefined) 
            {
                arg2.push("maximumInclineUphill");
                arg3[":maximumInclineUphill"] = arg1.maximumInclineUphill;
            }
            if (arg1.maximumPercentHRMaxDefined) 
            {
                arg2.push("maximumPercentHRMax");
                arg3[":maximumPercentHRMax"] = arg1.maximumPercentHRMax;
            }
            if (arg1.maximumPowerDefined) 
            {
                arg2.push("maximumPower");
                arg3[":maximumPower"] = arg1.maximumPower;
            }
            if (arg1.maximumRiseRateDefined) 
            {
                arg2.push("maximumRiseRate");
                arg3[":maximumRiseRate"] = arg1.maximumRiseRate;
            }
            if (arg1.maximumRiseRateDownhillDefined) 
            {
                arg2.push("maximumRiseRateDownhill");
                arg3[":maximumRiseRateDownhill"] = arg1.maximumRiseRateDownhill;
            }
            if (arg1.maximumRiseRateUphillDefined) 
            {
                arg2.push("maximumRiseRateUphill");
                arg3[":maximumRiseRateUphill"] = arg1.maximumRiseRateUphill;
            }
            if (arg1.maximumSpeedDefined) 
            {
                arg2.push("maximumSpeed");
                arg3[":maximumSpeed"] = arg1.maximumSpeed;
            }
            if (arg1.maximumTemperatureDefined) 
            {
                arg2.push("maximumTemperature");
                arg3[":maximumTemperature"] = arg1.maximumTemperature;
            }
            if (arg1.speedUnitDefined) 
            {
                arg2.push("measurement");
                arg3[":measurement"] = arg1.speedUnit;
            }
            if (arg1.minimumAltitudeDefined) 
            {
                arg2.push("minimumAltitude");
                arg3[":minimumAltitude"] = arg1.minimumAltitude;
            }
            if (arg1.minimumCadenceDefined) 
            {
                arg2.push("minimumCadence");
                arg3[":minimumCadence"] = arg1.minimumCadence;
            }
            if (arg1.minimumHeartrateDefined) 
            {
                arg2.push("minimumHeartrate");
                arg3[":minimumHeartrate"] = arg1.minimumHeartrate;
            }
            if (arg1.minimumInclineDefined) 
            {
                arg2.push("minimumIncline");
                arg3[":minimumIncline"] = arg1.minimumIncline;
            }
            if (arg1.minimumInclineUphillDefined) 
            {
                arg2.push("minimumInclineUphill");
                arg3[":minimumInclineUphill"] = arg1.minimumInclineUphill;
            }
            if (arg1.minimumInclineDownhillDefined) 
            {
                arg2.push("minimumInclineDownhill");
                arg3[":minimumInclineDownhill"] = arg1.minimumInclineDownhill;
            }
            if (arg1.minimumPercentHRMaxDefined) 
            {
                arg2.push("minimumPercentHRMax");
                arg3[":minimumPercentHRMax"] = arg1.minimumPercentHRMax;
            }
            if (arg1.minimumPowerDefined) 
            {
                arg2.push("minimumPower");
                arg3[":minimumPower"] = arg1.minimumPower;
            }
            if (arg1.minimumRiseRateDefined) 
            {
                arg2.push("minimumRiseRate");
                arg3[":minimumRiseRate"] = arg1.minimumRiseRate;
            }
            if (arg1.minimumRiseRateUphillDefined) 
            {
                arg2.push("minimumRiseRateUphill");
                arg3[":minimumRiseRateUphill"] = arg1.minimumRiseRateUphill;
            }
            if (arg1.minimumRiseRateDownhillDefined) 
            {
                arg2.push("minimumRiseRateDownhill");
                arg3[":minimumRiseRateDownhill"] = arg1.minimumRiseRateDownhill;
            }
            if (arg1.minimumSpeedDefined) 
            {
                arg2.push("minimumSpeed");
                arg3[":minimumSpeed"] = arg1.minimumSpeed;
            }
            if (arg1.minimumTemperatureDefined) 
            {
                arg2.push("minimumTemperature");
                arg3[":minimumTemperature"] = arg1.minimumTemperature;
            }
            arg2.push("name");
            arg3[":name"] = arg1.name;
            if (arg1.pauseTimeDefined) 
            {
                arg2.push("pauseTime");
                arg3[":pauseTime"] = arg1.pauseTime;
            }
            if (arg1.percentTimeInIntensityZone1Defined) 
            {
                arg2.push("percentTimeInIntensityZone1");
                arg3[":percentTimeInIntensityZone1"] = arg1.percentTimeInIntensityZone1;
            }
            if (arg1.percentTimeInIntensityZone2Defined) 
            {
                arg2.push("percentTimeInIntensityZone2");
                arg3[":percentTimeInIntensityZone2"] = arg1.percentTimeInIntensityZone2;
            }
            if (arg1.percentTimeInIntensityZone3Defined) 
            {
                arg2.push("percentTimeInIntensityZone3");
                arg3[":percentTimeInIntensityZone3"] = arg1.percentTimeInIntensityZone3;
            }
            if (arg1.percentTimeInIntensityZone4Defined) 
            {
                arg2.push("percentTimeInIntensityZone4");
                arg3[":percentTimeInIntensityZone4"] = arg1.percentTimeInIntensityZone4;
            }
            if (arg1.powerZone1StartDefined) 
            {
                arg2.push("powerZone1Start");
                arg3[":powerZone1Start"] = arg1.powerZone1Start;
            }
            if (arg1.powerZone2StartDefined) 
            {
                arg2.push("powerZone2Start");
                arg3[":powerZone2Start"] = arg1.powerZone2Start;
            }
            if (arg1.powerZone3StartDefined) 
            {
                arg2.push("powerZone3Start");
                arg3[":powerZone3Start"] = arg1.powerZone3Start;
            }
            if (arg1.powerZone4StartDefined) 
            {
                arg2.push("powerZone4Start");
                arg3[":powerZone4Start"] = arg1.powerZone4Start;
            }
            if (arg1.powerZone5StartDefined) 
            {
                arg2.push("powerZone5Start");
                arg3[":powerZone5Start"] = arg1.powerZone5Start;
            }
            if (arg1.powerZone6StartDefined) 
            {
                arg2.push("powerZone6Start");
                arg3[":powerZone6Start"] = arg1.powerZone6Start;
            }
            if (arg1.powerZone7StartDefined) 
            {
                arg2.push("powerZone7Start");
                arg3[":powerZone7Start"] = arg1.powerZone7Start;
            }
            if (arg1.powerZone7EndDefined) 
            {
                arg2.push("powerZone7End");
                arg3[":powerZone7End"] = arg1.powerZone7End;
            }
            if (arg1.ratingDefined) 
            {
                arg2.push("rating");
                arg3[":rating"] = arg1.rating;
            }
            if (arg1.feelingDefined) 
            {
                arg2.push("feeling");
                arg3[":feeling"] = arg1.feeling;
            }
            if (arg1.trainingTimeDownhillDefined) 
            {
                arg2.push("trainingTimeDownhill");
                arg3[":trainingTimeDownhill"] = arg1.trainingTimeDownhill;
            }
            if (arg1.trainingTimeUphillDefined) 
            {
                arg2.push("trainingTimeUphill");
                arg3[":trainingTimeUphill"] = arg1.trainingTimeUphill;
            }
            if (arg1.rxBatteryStatusDefined) 
            {
                arg2.push("rxBatteryStatus");
                arg3[":rxBatteryStatus"] = arg1.rxBatteryStatus;
            }
            if (arg1.samplingRateDefined) 
            {
                arg2.push("samplingRate");
                arg3[":samplingRate"] = arg1.samplingRate;
            }
            if (arg1.shoulderWidthDefined) 
            {
                arg2.push("shoulderWidth");
                arg3[":shoulderWidth"] = arg1.shoulderWidth;
            }
            if (arg1.shoulderWidthUnitDefined) 
            {
                arg2.push("shoulderWidthUnit");
                arg3[":shoulderWidthUnit"] = arg1.shoulderWidthUnit;
            }
            if (arg1.startDateDefined) 
            {
                arg2.push("startDate");
                arg3[":startDate"] = utils.date.DateUtilCommon.dateToMySqlFormat(arg1.startDate);
            }
            if (arg1.statisticDefined) 
            {
                arg2.push("statistic");
                arg3[":statistic"] = arg1.statistic ? 1 : 0;
            }
            if (arg1.serialNumberDefined) 
            {
                arg2.push("serialNumber");
                arg3[":serialNumber"] = arg1.serialNumber;
            }
            if (arg1.thresholdPowerDefined) 
            {
                arg2.push("thresholdPower");
                arg3[":thresholdPower"] = arg1.thresholdPower;
            }
            if (arg1.timeInIntensityZone1Defined) 
            {
                arg2.push("timeInIntensityZone1");
                arg3[":timeInIntensityZone1"] = arg1.timeInIntensityZone1;
            }
            if (arg1.timeInIntensityZone2Defined) 
            {
                arg2.push("timeInIntensityZone2");
                arg3[":timeInIntensityZone2"] = arg1.timeInIntensityZone2;
            }
            if (arg1.timeInIntensityZone3Defined) 
            {
                arg2.push("timeInIntensityZone3");
                arg3[":timeInIntensityZone3"] = arg1.timeInIntensityZone3;
            }
            if (arg1.timeInIntensityZone4Defined) 
            {
                arg2.push("timeInIntensityZone4");
                arg3[":timeInIntensityZone4"] = arg1.timeInIntensityZone4;
            }
            if (arg1.timeInPowerZone1Defined) 
            {
                arg2.push("timeInPowerZone1");
                arg3[":timeInPowerZone1"] = arg1.timeInPowerZone1;
            }
            if (arg1.timeInPowerZone2Defined) 
            {
                arg2.push("timeInPowerZone2");
                arg3[":timeInPowerZone2"] = arg1.timeInPowerZone2;
            }
            if (arg1.timeInPowerZone3Defined) 
            {
                arg2.push("timeInPowerZone3");
                arg3[":timeInPowerZone3"] = arg1.timeInPowerZone3;
            }
            if (arg1.timeInPowerZone4Defined) 
            {
                arg2.push("timeInPowerZone4");
                arg3[":timeInPowerZone4"] = arg1.timeInPowerZone4;
            }
            if (arg1.timeInPowerZone5Defined) 
            {
                arg2.push("timeInPowerZone5");
                arg3[":timeInPowerZone5"] = arg1.timeInPowerZone5;
            }
            if (arg1.timeInPowerZone6Defined) 
            {
                arg2.push("timeInPowerZone6");
                arg3[":timeInPowerZone6"] = arg1.timeInPowerZone6;
            }
            if (arg1.timeInPowerZone7Defined) 
            {
                arg2.push("timeInPowerZone7");
                arg3[":timeInPowerZone7"] = arg1.timeInPowerZone7;
            }
            if (arg1.timeInZoneDefined) 
            {
                arg2.push("timeInZone");
                arg3[":timeInZone"] = arg1.timeInZone;
            }
            if (arg1.timeInZone1Defined) 
            {
                arg2.push("timeInZone1");
                arg3[":timeInZone1"] = arg1.timeInZone1;
            }
            if (arg1.timeInZone2Defined) 
            {
                arg2.push("timeInZone2");
                arg3[":timeInZone2"] = arg1.timeInZone2;
            }
            if (arg1.timeInZone3Defined) 
            {
                arg2.push("timeInZone3");
                arg3[":timeInZone3"] = arg1.timeInZone3;
            }
            if (arg1.timeOverIntensityZoneDefined) 
            {
                arg2.push("timeOverIntensityZone");
                arg3[":timeOverIntensityZone"] = arg1.timeOverIntensityZone;
            }
            if (arg1.timeOverZoneDefined) 
            {
                arg2.push("timeOverZone");
                arg3[":timeOverZone"] = arg1.timeOverZone;
            }
            if (arg1.timeUnderIntensityZoneDefined) 
            {
                arg2.push("timeUnderIntensityZone");
                arg3[":timeUnderIntensityZone"] = arg1.timeUnderIntensityZone;
            }
            if (arg1.timeUnderZoneDefined) 
            {
                arg2.push("timeUnderZone");
                arg3[":timeUnderZone"] = arg1.timeUnderZone;
            }
            if (arg1.trackProfileDefined) 
            {
                arg2.push("trackProfile");
                arg3[":trackProfile"] = arg1.trackProfile;
            }
            if (arg1.trainingTimeDefined) 
            {
                arg2.push("trainingTime");
                arg3[":trainingTime"] = arg1.trainingTime;
            }
            if (arg1.trainingTypeDefined) 
            {
                arg2.push("trainingType");
                arg3[":trainingType"] = arg1.trainingType.toString();
            }
            if (arg1.trainingZoneDefined) 
            {
                arg2.push("trainingZone");
                arg3[":trainingZone"] = arg1.trainingZone;
            }
            if (arg1.tripSectionDistanceDefined) 
            {
                arg2.push("tripSectionDistance");
                arg3[":tripSectionDistance"] = arg1.tripSectionDistance;
            }
            if (arg1.tripSectionTimeDefined) 
            {
                arg2.push("tripSectionTime");
                arg3[":tripSectionTime"] = arg1.tripSectionTime;
            }
            if (arg1.txBatteryStatusDefined) 
            {
                arg2.push("txBatteryStatus");
                arg3[":txBatteryStatus"] = arg1.txBatteryStatus;
            }
            if (arg1.unitDefined) 
            {
                arg2.push("unitId");
                if (arg1.unit == null) 
                {
                    arg3[":unitId"] = arg1.unitId;
                }
                else 
                {
                    arg3[":unitId"] = arg1.unit.unitId;
                }
            }
            if (arg1.unitType != null) 
            {
                arg2.push("unitType");
                arg3[":unitType"] = arg1.unitType.toString();
            }
            arg2.push("sportId");
            arg3[":sportId"] = arg1.sportId;
            if (arg1.upperLimitDefined) 
            {
                arg2.push("upperLimit");
                arg3[":upperLimit"] = arg1.upperLimit;
            }
            arg2.push("userId");
            arg3[":userId"] = arg1.userId;
            if (arg1.weatherDefined) 
            {
                arg2.push("weather");
                arg3[":weather"] = arg1.weather;
            }
            if (arg1.wheelSizeDefined) 
            {
                arg2.push("wheelSize");
                arg3[":wheelSize"] = arg1.wheelSize;
            }
            if (arg1.windDefined) 
            {
                arg2.push("wind");
                arg3[":wind"] = arg1.wind;
            }
            if (arg1.workInKJDefined) 
            {
                arg2.push("workInKJ");
                arg3[":workInKJ"] = arg1.workInKJ;
            }
            if (arg1.zone1StartDefined) 
            {
                arg2.push("zone1Start");
                arg3[":zone1Start"] = arg1.zone1Start;
            }
            if (arg1.zone2StartDefined) 
            {
                arg2.push("zone2Start");
                arg3[":zone2Start"] = arg1.zone2Start;
            }
            if (arg1.zone3StartDefined) 
            {
                arg2.push("zone3Start");
                arg3[":zone3Start"] = arg1.zone3Start;
            }
            if (arg1.zone3EndDefined) 
            {
                arg2.push("zone3End");
                arg3[":zone3End"] = arg1.zone3End;
            }
            if (arg1.chestbeltManufacturerDefined) 
            {
                arg2.push("chestbeltManufacturer");
                arg3[":chestbeltManufacturer"] = arg1.chestbeltManufacturer;
            }
            if (arg1.withDeviceDefined) 
            {
                arg2.push("withDevice");
                arg3[":withDevice"] = arg1.chestbeltManufacturer;
            }
            if (arg1.stepsDefined) 
            {
                arg2.push("steps");
                arg3[":steps"] = arg1.steps;
            }
            if (arg1.targetDayDefined) 
            {
                arg2.push("targetDay");
                arg3[":targetDay"] = arg1.targetDay;
            }
            if (arg1.activeTimeLowDefined) 
            {
                arg2.push("activTimeLow");
                arg3[":activTimeLow"] = arg1.activeTimeLow;
            }
            if (arg1.activeTimeMiddleDefined) 
            {
                arg2.push("activTimeMedium");
                arg3[":activTimeMedium"] = arg1.activeTimeMiddle;
            }
            if (arg1.activeTimeHighDefined) 
            {
                arg2.push("activTimeHigh");
                arg3[":activTimeHigh"] = arg1.activeTimeHigh;
            }
            if (arg1.timeWakeUpDefined) 
            {
                arg2.push("stepsLow");
                arg3[":stepsLow"] = arg1.timeWakeUp;
            }
            if (arg1.timeLightSleepDefined) 
            {
                arg2.push("stepsMedium");
                arg3[":stepsMedium"] = arg1.timeLightSleep;
            }
            if (arg1.timeDeepSleepDefined) 
            {
                arg2.push("stepsHigh");
                arg3[":stepsHigh"] = arg1.timeDeepSleep;
            }
            if (arg1.timeSleepDefined) 
            {
                arg2.push("timeSleep");
                arg3[":timeSleep"] = arg1.timeSleep;
            }
            if (arg1.best5KTimeDefined) 
            {
                arg2.push("best5KTime");
                arg3[":best5KTime"] = arg1.best5KTime;
            }
            if (arg1.best5KEntryDefined) 
            {
                arg2.push("best5KEntry");
                arg3[":best5KEntry"] = arg1.best5KEntry;
            }
            arg2.push("sharingInformations");
            arg3[":sharingInformations"] = encodeSharingInformations(arg1);
            if (arg1.best20minPowerDefined) 
            {
                arg2.push("best20minPower");
                arg3[":best20minPower"] = arg1.best20minPower;
            }
            if (arg1.best20minPowerEntryDefined) 
            {
                arg2.push("best20minPowerEntry");
                arg3[":best20minPowerEntry"] = arg1.best20minPowerEntry;
            }
            if (arg1.powerNPDefined) 
            {
                arg2.push("powerNP");
                arg3[":powerNP"] = arg1.powerNP;
            }
            if (arg1.powerTSSDefined) 
            {
                arg2.push("powerTSS");
                arg3[":powerTSS"] = arg1.powerTSS;
            }
            if (arg1.powerFTPDefined) 
            {
                arg2.push("powerFTP");
                arg3[":powerFTP"] = arg1.powerFTP;
            }
            if (arg1.pedalingTimeDefined) 
            {
                arg2.push("pedalingTime");
                arg3[":pedalingTime"] = arg1.pedalingTime;
            }
            if (arg1.pedalingIndexDefined) 
            {
                arg2.push("pedalingIndex");
                arg3[":pedalingIndex"] = arg1.pedalingIndex;
            }
            if (arg1.maximumExpansionDefined) 
            {
                arg2.push("maximumExpansion");
                arg3[":maximumExpansion"] = arg1.maximumExpansion;
            }
            if (arg1.maximumExpansionUphillDefined) 
            {
                arg2.push("maximumExpansionUphill");
                arg3[":maximumExpansionUphill"] = arg1.maximumExpansionUphill;
            }
            if (arg1.maximumExpansionDownhillDefined) 
            {
                arg2.push("maximumExpansionDownhill");
                arg3[":maximumExpansionDownhill"] = arg1.maximumExpansionDownhill;
            }
            if (arg1.averageBalanceRightDefined) 
            {
                arg2.push("averageBalanceRight");
                arg3[":averageBalanceRight"] = arg1.averageBalanceRight;
            }
            if (arg1.averageBalanceLeftDefined) 
            {
                arg2.push("averageBalanceLeft");
                arg3[":averageBalanceLeft"] = arg1.averageBalanceLeft;
            }
            if (arg1.powerIFDefined) 
            {
                arg2.push("powerIF");
                arg3[":powerIF"] = arg1.powerIF;
            }
            if (arg1.torqueEffectLeftDefined) 
            {
                arg2.push("torqueEffectLeft");
                arg3[":torqueEffectLeft"] = arg1.torqueEffectLeft;
            }
            if (arg1.torqueEffectRightDefined) 
            {
                arg2.push("torqueEffectRight");
                arg3[":torqueEffectRight"] = arg1.torqueEffectRight;
            }
            if (arg1.pedalSmoothLeftDefined) 
            {
                arg2.push("pedalSmoothLeft");
                arg3[":pedalSmoothLeft"] = arg1.pedalSmoothLeft;
            }
            if (arg1.pedalSmoothRightDefined) 
            {
                arg2.push("pedalSmoothRight");
                arg3[":pedalSmoothRight"] = arg1.pedalSmoothRight;
            }
            if (arg1.averageCadenceCalcDefined) 
            {
                arg2.push("averageCadenceCalc");
                arg3[":averageCadenceCalc"] = arg1.averageCadenceCalc;
            }
            if (arg1.averagePowerCalcDefined) 
            {
                arg2.push("averagePowerCalc");
                arg3[":averagePowerCalc"] = arg1.averagePowerCalc;
            }
            arg2.push("simpleHeaderValuesCalculation");
            arg3[":simpleHeaderValuesCalculation"] = arg1.simpleHeaderValuesCalculation;
            return;
        }

        public static function generateCSVHeader(arg1:core.activities.Activity):__AS3__.vec.Vector.<String>
        {
            var loc1:*=(arg1.ageDefined ? "Age," : "") + (arg1.GUID ? "GUID," : "") + (arg1.modificationDate ? "Modification Date," : "") + (arg1.altitudeDifferencesDownhillDefined ? "AltitudeDifferencesDownhill [m]," : "") + (arg1.altitudeDifferencesUphillDefined ? "AltitudeDifferencesUphill [m]," : "") + (arg1.averageCadenceDefined ? "AverageCadence [U/min]," : "") + (arg1.averageExpansionDefined ? "AverageExpansion [m/r]," : "") + (arg1.averageExpansionDownhillDefined ? "AverageExpansionDownhill [m]," : "") + (arg1.averageExpansionUphillDefined ? "AverageExpansionUphill [m/r]," : "") + (arg1.averageHeartrateDefined ? "AverageHeartrate [bpm]," : "") + (arg1.averageInclineDownhillDefined ? "AverageInclineDownhill [%]," : "") + (arg1.averageInclineUphillDefined ? "AverageInclineUphill [%]," : "") + (arg1.averagePercentHRMaxDefined ? "AveragePercentHRMax [%]," : "") + (arg1.averagePowerKJDefined ? "AveragePower [KJ]," : "") + (arg1.averagePowerWattPerKGDefined ? "AveragePower [W/KG]," : "") + (arg1.averageSpeedDefined ? "AverageSpeed [m/s]," : "") + (arg1.averageSpeedDownhillDefined ? "AverageSpeedDownhill [m/s]," : "") + (arg1.averageSpeedUphillDefined ? "AverageSpeedUphill [m/s]," : "") + "Bike," + (arg1.caloriesDefined ? "Calories [kcal]," : "") + (arg1.unitDefined ? "Computer," : "") + (arg1.descriptionDefined ? "Description," : "") + (arg1.distanceDefined ? "Distance [m]," : "") + (arg1.distanceDownhillDefined ? "DistanceDownhill [m]," : "") + (arg1.distanceMinusDefined ? "DistanceMinus [m]," : "") + (arg1.distancePlusDefined ? "DistancePlus [m]," : "") + (arg1.distancePlusMinusStatusDefined ? "DistancePlusMinusStatus," : "") + (arg1.distanceUphillDefined ? "DistanceUphill [m]," : "") + (arg1.zone1StartDefined ? "StartZone1 [bpm]," : "") + (arg1.zone2StartDefined ? "StartZone2 [bpm]," : "") + (arg1.zone3StartDefined ? "StartZone3 [bpm]," : "") + (arg1.zone3EndDefined ? "EndZone3 [bpm]," : "") + (arg1.exerciseTimeDefined ? "ExerciseTime [s]," : "") + (arg1.fuelEconomyDefined ? "FuelEconomy [ml]," : "") + (arg1.hrMaxDefined ? "HRMax [bpm]," : "") + (arg1.percentTimeInIntensityZone1Defined ? "InIntensityZone1 [%]," : "") + (arg1.percentTimeInIntensityZone2Defined ? "InIntensityZone2 [%]," : "") + (arg1.percentTimeInIntensityZone3Defined ? "InIntensityZone3 [%]," : "") + (arg1.percentTimeInIntensityZone4Defined ? "InIntensityZone4 [%]," : "") + (arg1.maximumAltitudeDefined ? "MaximumAltitude [m]," : "") + (arg1.maximumCadenceDefined ? "MaximumCadence [U/min]," : "") + (arg1.maximumHeartrateDefined ? "MaximumHeartrate [bpm]," : "") + (arg1.maximumInclineDownhillDefined ? "MaximumInclineDownhill [%]," : "") + (arg1.maximumInclineUphillDefined ? "MaximumInclineUphill [%]," : "") + (arg1.maximumPowerDefined ? "MaximumPower [W]," : "") + (arg1.maximumRiseRateDownhillDefined ? "MaximumRiseRateDownhill [m/min]," : "") + (arg1.maximumRiseRateUphillDefined ? "MaximumRiseRateUphill [m/min]," : "") + (arg1.maximumSpeedDefined ? "MaximumSpeed [m/s]," : "") + (arg1.maximumTemperatureDefined ? "MaximumTemperature [°C]," : "") + (arg1.minimumTemperatureDefined ? "MinimumTemperature [°C]," : "") + "Name," + (arg1.participant ? "Participant," : "") + (arg1.trackProfileDefined ? "Profile," : "") + (arg1.ratingDefined ? "Rating," : "") + (arg1.feelingDefined ? "Feeling," : "") + (arg1.trainingTimeDownhillDefined ? "RideTimeDownhill [s]," : "") + (arg1.trainingTimeUphillDefined ? "RideTimeUphill [s]," : "") + (arg1.serialNumberDefined ? "SerialNumber," : "") + (arg1.startDateDefined ? "StartDate," : "") + (arg1.manualTemperatureDefined ? "Temperature [°C]," : "") + (arg1.timeInIntensityZone1Defined ? "TimeInIntensityZone1 [s]," : "") + (arg1.timeInIntensityZone2Defined ? "TimeInIntensityZone2 [s]," : "") + (arg1.timeInIntensityZone3Defined ? "TimeInIntensityZone3 [s]," : "") + (arg1.timeInIntensityZone4Defined ? "TimeInIntensityZone4 [s]," : "") + (arg1.timeInPowerZone1Defined ? "TimeInPowerZone1 [s]," : "") + (arg1.timeInPowerZone2Defined ? "TimeInPowerZone2 [s]," : "") + (arg1.timeInPowerZone3Defined ? "TimeInPowerZone3 [s]," : "") + (arg1.timeInPowerZone4Defined ? "TimeInPowerZone4 [s]," : "") + (arg1.timeInPowerZone5Defined ? "TimeInPowerZone5 [s]," : "") + (arg1.timeInPowerZone6Defined ? "TimeInPowerZone6 [s]," : "") + (arg1.timeInPowerZone7Defined ? "TimeInPowerZone7 [s]," : "") + (arg1.timeInZone1Defined ? "TimeInZone1 [s]," : "") + (arg1.timeInZone2Defined ? "TimeInZone2 [s]," : "") + (arg1.timeInZone3Defined ? "TimeInZone3 [s]," : "") + (arg1.trainingTypeDefined ? "Training type," : "") + (arg1.trainingTimeDefined ? "TrainingTime [s]," : "") + (arg1.tripSectionDistanceDefined ? "TripSectionDistance [m]," : "") + (arg1.tripSectionTimeDefined ? "TripSectionTime [s]," : "") + (arg1.weatherDefined ? "Weather," : "") + (arg1.wheelSizeDefined ? "WheelSize [mm]," : "") + (arg1.windDefined ? "Wind" : "");
            return __AS3__.vec.Vector.<String>(loc1.split(","));
        }

        public static function generateDBCreateTable(arg1:uint):database.DatabaseTable
        {
            var loc1:*=null;
            var loc2:*=arg1;
            while (400 === loc2) 
            {
                DB_TABLE_400 = new database.DatabaseTable("Activity");
                DB_TABLE_400.addColumns([["activityId", "INTEGER", false, true, true], ["GUID", "VARCHAR UNIQUE", false], ["modificationDate", "NUMERIC", true], ["age", "INTEGER", true], ["altitudeDifferencesDownhill", "INTEGER", true], ["altitudeDifferencesUphill", "INTEGER", true], ["averageAltitude", "NUMERIC", true], ["averageCadence", "NUMERIC", true], ["averageExpansion", "NUMERIC", true], ["averageExpansionDownhill", "NUMERIC", true], ["averageExpansionUphill", "NUMERIC", true], ["averageHeartrate", "INTEGER", true], ["averageInclineDownhill", "NUMERIC", true], ["averageInclineUphill", "NUMERIC", true], ["averagePercentHRMax", "NUMERIC", true], ["averagePower", "NUMERIC", true], ["averagePowerKJ", "NUMERIC", true], ["averagePowerWatt", "NUMERIC", true], ["averagePowerWattPerKG", "NUMERIC", true], ["averageRiseRate", "NUMERIC", true], ["averageRiseRateUphill", "NUMERIC", true], ["averageRiseRateDownhill", "NUMERIC", true], ["averageSpeed", "NUMERIC", true], ["averageSpeedDownhill", "NUMERIC", true], ["averageSpeedUphill", "NUMERIC", true], ["averageTemperature", "NUMERIC", true], ["bike", "VARCHAR", true], ["bikeType", "VARCHAR", true], ["bikeWeight", "INTEGER", true], ["bikeWeightUnit", "VARCHAR", true], ["bodyHeight", "NUMERIC", true], ["bodyHeightUnit", "VARCHAR", true], ["bodyWeight", "INTEGER", true], ["bodyWeightUnit", "VARCHAR", true], ["calibration", "BOOL", true], ["calories", "NUMERIC", true], ["caloriesDifferenceFactor", "NUMERIC", true], ["correctionChestRun", "NUMERIC", true], ["correctionChestWalk", "NUMERIC", true], ["correctionFactor", "NUMERIC", true], ["correctionHipRun", "NUMERIC", true], ["correctionHipWalk", "NUMERIC", true], ["dataType", "VARCHAR", true], ["dateCode", "VARCHAR", true], ["description", "TEXT", true], ["distance", "NUMERIC", true], ["distanceDownhill", "NUMERIC", true], ["distanceMinus", "NUMERIC", true], ["distancePlus", "NUMERIC", true], ["distancePlusMinusStatus", "VARCHAR", true], ["distanceUphill", "NUMERIC", true], ["exerciseTime", "NUMERIC", true], ["externalLink", "VARCHAR", true], ["fuelEconomy", "NUMERIC", true], ["gender", "VARCHAR", true], ["hrMax", "INTEGER", true], ["intensityZone1Start", "NUMERIC", true], ["intensityZone2Start", "NUMERIC", true], ["intensityZone3Start", "NUMERIC", true], ["intensityZone4Start", "NUMERIC", true], ["intensityZone4End", "NUMERIC", true], ["isDeleted", "BOOL", true], ["latitudeEnd", "NUMERIC", true], ["latitudeStart", "NUMERIC", true], ["linkedRouteId", "INTEGER", true], ["logType", "VARCHAR", true], ["logVersion", "VARCHAR", true], ["longitudeEnd", "NUMERIC", true], ["longitudeStart", "NUMERIC", true], ["lowerLimit", "INTEGER", true], ["manualTemperature", "NUMERIC", true], ["maximumAltitude", "NUMERIC", true], ["maximumCadence", "INTEGER", true], ["maximumHeartrate", "INTEGER", true], ["maximumIncline", "NUMERIC", true], ["maximumInclineDownhill", "NUMERIC", true], ["maximumInclineUphill", "NUMERIC", true], ["maximumPercentHRMax", "NUMERIC", true], ["maximumPower", "INTEGER", true], ["maximumRiseRate", "NUMERIC", true], ["maximumRiseRateDownhill", "NUMERIC", true], ["maximumRiseRateUphill", "NUMERIC", true], ["maximumSpeed", "NUMERIC", true], ["maximumTemperature", "NUMERIC", true], ["measurement", "VARCHAR", true], ["minimumAltitude", "NUMERIC", true], ["minimumCadence", "INTEGER", true], ["minimumHeartrate", "NUMERIC", true], ["minimumIncline", "NUMERIC", true], ["minimumInclineUphill", "NUMERIC", true], ["minimumInclineDownhill", "NUMERIC", true], ["minimumPercentHRMax", "NUMERIC", true], ["minimumPower", "INTEGER", true], ["minimumRiseRate", "NUMERIC", true], ["minimumRiseRateUphill", "NUMERIC", true], ["minimumRiseRateDownhill", "NUMERIC", true], ["minimumSpeed", "NUMERIC", true], ["minimumTemperature", "NUMERIC", true], ["name", "VARCHAR", true], ["pageHeaderData", "BLOB", true], ["pauseTime", "NUMERIC", true], ["percentTimeInIntensityZone1", "NUMERIC", true], ["percentTimeInIntensityZone2", "NUMERIC", true], ["percentTimeInIntensityZone3", "NUMERIC", true], ["percentTimeInIntensityZone4", "NUMERIC", true], ["powerZone1Start", "INTEGER", true], ["powerZone2Start", "INTEGER", true], ["powerZone3Start", "INTEGER", true], ["powerZone4Start", "INTEGER", true], ["powerZone5Start", "INTEGER", true], ["powerZone6Start", "INTEGER", true], ["powerZone7End", "INTEGER", true], ["powerZone7Start", "INTEGER", true], ["rating", "INTEGER", true], ["feeling", "INTEGER", true], ["trainingTimeDownhill", "NUMERIC", true], ["trainingTimeUphill", "NUMERIC", true], ["rxBatteryStatus", "VARCHAR", true], ["samplingRate", "NUMERIC", true], ["shoulderWidth", "NUMERIC", true], ["shoulderWidthUnit", "VARCHAR", true], ["startDate", "Date", true], ["statistic", "BOOL", true], ["serialNumber", "VARCHAR", true], ["thresholdPower", "NUMERIC", true], ["timeInIntensityZone1", "NUMERIC", true], ["timeInIntensityZone2", "NUMERIC", true], ["timeInIntensityZone3", "NUMERIC", true], ["timeInIntensityZone4", "NUMERIC", true], ["timeInPowerZone1", "NUMERIC", true], ["timeInPowerZone2", "NUMERIC", true], ["timeInPowerZone3", "NUMERIC", true], ["timeInPowerZone4", "NUMERIC", true], ["timeInPowerZone5", "NUMERIC", true], ["timeInPowerZone6", "NUMERIC", true], ["timeInPowerZone7", "NUMERIC", true], ["timeInZone", "NUMERIC", true], ["timeInZone1", "NUMERIC", true], ["timeInZone2", "NUMERIC", true], ["timeInZone3", "NUMERIC", true], ["timeOverIntensityZone", "NUMERIC", true], ["timeOverZone", "NUMERIC", true], ["timeUnderIntensityZone", "NUMERIC", true], ["timeUnderZone", "NUMERIC", true], ["trackProfile", "INTEGER", true], ["trackReferenceId", "INTEGER", true], ["trainingTime", "NUMERIC", true], ["trainingType", "VARCHAR", true], ["trainingZone", "VARCHAR", true], ["tripSectionDistance", "NUMERIC", true], ["tripSectionTime", "NUMERIC", true], ["txBatteryStatus", "VARCHAR", true], ["unitId", "INTEGER", true], ["unitType", "VARCHAR", true], ["sportId", "INTEGER", true], ["userId", "INTEGER", true], ["upperLimit", "INTEGER", true], ["weather", "INTEGER", true], ["wheelSize", "INTEGER", true], ["wind", "INTEGER", true], ["workInKJ", "NUMERIC", true], ["zone1Start", "INTEGER", true], ["zone2Start", "INTEGER", true], ["zone3End", "INTEGER", true], ["zone3Start", "INTEGER", true], ["chestbeltManufacturer", "VARCHAR", true], ["withDevice", "VARCHAR", true], ["stepsLow", "NUMERIC", true], ["stepsMedium", "NUMERIC", true], ["stepsHigh", "NUMERIC", true], ["activTimeLow", "NUMERIC", true], ["activTimeMedium", "NUMERIC", true], ["activTimeHigh", "NUMERIC", true], ["dayActivity", "BOOL", true], ["emptyField1", "NUMERIC", true], ["emptyField2", "NUMERIC", true], ["emptyField3", "NUMERIC", true], ["emptyField4", "NUMERIC", true], ["emptyField5", "VARCHAR", true], ["emptyField6", "VARCHAR", true], ["emptyField7", "VARCHAR", true], ["emptyField8", "VARCHAR", true]]);
                loc1 = DB_TABLE_400;
            }
        }

        public static function generateDBCreateIndex():String
        {
            var loc1:*="CREATE INDEX UnitIdOnActivity ON Activity (unitId)";
            return loc1;
        }

        public static function generateDBCreateTrigger(arg1:uint):String
        {
            var loc1:*=null;
            var loc2:*=arg1;
            while (400 === loc2) 
            {
                loc1 = "CREATE TRIGGER IF NOT EXISTS ActivityTrigger AFTER DELETE ON Activity FOR EACH ROW BEGIN DELETE FROM ActivityEntry WHERE ActivityEntry.activityId = OLD.activityId;DELETE FROM Marker WHERE Marker.activityId = OLD.activityId;DELETE FROM ActivityPerson WHERE ActivityPerson.activityId = OLD.activityId;END";
            }
        }

        public static function generateDBDelete(arg1:core.activities.Activity):String
        {
            return "DELETE FROM Activity WHERE GUID = \'" + arg1.GUID + "\'";
        }

        public static function generateLoadActivitiesStatement(arg1:int, arg2:int, arg3:Array=null):String
        {
            var loc1:*=["GUID", "activityId", "startDate", "isDeleted", "name", "distance", "sportId", "trainingTime", "sharingInformations"];
            var loc2:*="SELECT " + loc1.join(", ") + " FROM Activity WHERE isDeleted = false";
            if (arg3 && arg3.length > 0) 
            {
                loc2 = loc2 + (" AND " + arg3.join(" AND "));
            }
            return loc2 = loc2 + " ORDER BY startDate DESC ";
        }

        public static function generateXML(arg1:core.activities.Activity, arg2:core.user.User, arg3:Boolean=true):XML
        {
            var loc3:*;
            (loc3 = new XML("<Activity/>")).@fileDate = new Date();
            loc3.@revision = 400;
            if (arg1.unitType == null) 
            {
                loc3.Computer.@unit = "user defined";
            }
            else 
            {
                loc3.Computer.@unit = arg1.unitType.toString();
            }
            if (arg1.serialNumberDefined) 
            {
                var loc4:*;
                loc3.Computer.@serial = loc4 = arg1.serialNumber;
            }
            undefined;
            if (arg1.logType != null) 
            {
                loc3.Computer.@activityType = loc4 = arg1.logType.toString();
            }
            undefined;
            if (arg1.dateCodeDefined) 
            {
                loc3.Computer.@dateCode = loc4 = arg1.dateCode;
            }
            undefined;
            var loc2:*;
            (loc2 = new XML("<GeneralInformation/>")).user = utils.format.CDATAFormat.getCDataAsXMLNode("user", arg2.name);
            loc2.user.@color = arg2.color;
            loc2.user.@gender = arg2.gender;
            loc2.sport = utils.format.CDATAFormat.getCDataAsXMLNode("sport", arg1.sport.keyName);
            if (arg1.ageDefined) 
            {
                loc2.age = loc4 = arg1.age;
            }
            undefined;
            if (arg1.GUID != "") 
            {
                loc2.GUID = loc4 = arg1.GUID;
            }
            undefined;
            loc2.activityStatus = arg1.activityStatus;
            if (arg1.altitudeDifferencesDownhillDefined) 
            {
                loc2.altitudeDifferencesDownhill = loc4 = arg1.altitudeDifferencesDownhill;
            }
            undefined;
            if (arg1.altitudeDifferencesUphillDefined) 
            {
                loc2.altitudeDifferencesUphill = loc4 = arg1.altitudeDifferencesUphill;
            }
            undefined;
            if (arg1.averageAltitudeDefined) 
            {
                loc2.averageAltitude = loc4 = arg1.averageAltitude;
            }
            undefined;
            if (arg1.averageCadenceDefined) 
            {
                loc2.averageCadence = loc4 = arg1.averageCadence;
            }
            undefined;
            if (arg1.averageExpansionDefined) 
            {
                loc2.averageExpansion = loc4 = arg1.averageExpansion;
            }
            undefined;
            if (arg1.averageExpansionDownhillDefined) 
            {
                loc2.averageExpansionDownhill = loc4 = arg1.averageExpansionDownhill;
            }
            undefined;
            if (arg1.averageExpansionUphillDefined) 
            {
                loc2.averageExpansionUphill = loc4 = arg1.averageExpansionUphill;
            }
            undefined;
            if (arg1.averageHeartrateDefined) 
            {
                loc2.averageHeartrate = loc4 = arg1.averageHeartrate;
            }
            undefined;
            if (arg1.averageInclineDownhillDefined) 
            {
                loc2.averageInclineDownhill = loc4 = arg1.averageInclineDownhill;
            }
            undefined;
            if (arg1.averageInclineUphillDefined) 
            {
                loc2.averageInclineUphill = loc4 = arg1.averageInclineUphill;
            }
            undefined;
            if (arg1.averagePercentHRMaxDefined) 
            {
                loc2.averagePercentHRMax = loc4 = arg1.averagePercentHRMax;
            }
            undefined;
            if (arg1.averagePowerDefined) 
            {
                loc2.averagePower = loc4 = arg1.averagePower;
            }
            undefined;
            if (arg1.averagePowerKJDefined) 
            {
                loc2.averagePowerKJ = loc4 = arg1.averagePowerKJ;
            }
            undefined;
            if (arg1.averagePowerWattPerKGDefined) 
            {
                loc2.averagePowerWattPerKG = loc4 = arg1.averagePowerWattPerKG;
            }
            undefined;
            if (arg1.averageRiseRateDefined) 
            {
                loc2.averageRiseRate = loc4 = arg1.averageRiseRate;
            }
            undefined;
            if (arg1.averageRiseRateUphillDefined) 
            {
                loc2.averageRiseRateUphill = loc4 = arg1.averageRiseRateUphill;
            }
            undefined;
            if (arg1.averageRiseRateDownhillDefined) 
            {
                loc2.averageRiseRateDownhill = loc4 = arg1.averageRiseRateDownhill;
            }
            undefined;
            if (arg1.averageSpeedDefined) 
            {
                loc2.averageSpeed = loc4 = arg1.averageSpeed;
            }
            undefined;
            if (arg1.averageSpeedDownhillDefined) 
            {
                loc2.averageSpeedDownhill = loc4 = arg1.averageSpeedDownhill;
            }
            undefined;
            if (arg1.averageSpeedUphillDefined) 
            {
                loc2.averageSpeedUphill = loc4 = arg1.averageSpeedUphill;
            }
            undefined;
            if (arg1.averageTemperatureDefined) 
            {
                loc2.averageTemperature = loc4 = arg1.averageTemperature;
            }
            undefined;
            loc2.bike = arg1.bike;
            if (arg1.bikeTypeDefined) 
            {
                loc2.bikeType = loc4 = arg1.bikeType;
            }
            undefined;
            if (arg1.bikeWeightDefined) 
            {
                loc2.bikeWeight = loc4 = arg1.bikeWeight;
            }
            undefined;
            if (arg1.bikeWeightUnitDefined) 
            {
                loc2.bikeWeightUnit = loc4 = arg1.bikeWeightUnit;
            }
            undefined;
            if (arg1.bodyHeightDefined) 
            {
                loc2.bodyHeight = loc4 = arg1.bodyHeight;
            }
            undefined;
            if (arg1.bodyHeightUnitDefined) 
            {
                loc2.bodyHeightUnit = loc4 = arg1.bodyHeightUnit;
            }
            undefined;
            if (arg1.bodyWeightDefined) 
            {
                loc2.bodyWeight = loc4 = arg1.bodyWeight;
            }
            undefined;
            if (arg1.bodyWeightUnitDefined) 
            {
                loc2.bodyWeightUnit = loc4 = arg1.bodyWeightUnit;
            }
            undefined;
            if (arg1.calibrationDefined) 
            {
                loc2.calibration = loc4 = arg1.calibration;
            }
            undefined;
            if (arg1.caloriesDefined) 
            {
                loc2.calories = loc4 = arg1.calories;
            }
            undefined;
            if (arg1.caloriesDifferenceFactorDefined) 
            {
                loc2.caloriesDifferenceFactor = loc4 = arg1.caloriesDifferenceFactor;
            }
            undefined;
            if (arg1.correctionChestRunDefined) 
            {
                loc2.correctionChestRun = loc4 = arg1.correctionChestRun;
            }
            undefined;
            if (arg1.correctionChestWalkDefined) 
            {
                loc2.correctionChestWalk = loc4 = arg1.correctionChestWalk;
            }
            undefined;
            if (arg1.correctionFactorDefined) 
            {
                loc2.correctionFactor = loc4 = arg1.correctionFactor;
            }
            undefined;
            if (arg1.correctionHipRunDefined) 
            {
                loc2.correctionHipRun = loc4 = arg1.correctionHipRun;
            }
            undefined;
            if (arg1.correctionHipWalkDefined) 
            {
                loc2.correctionHipWalk = loc4 = arg1.correctionHipWalk;
            }
            undefined;
            if (arg1.descriptionDefined) 
            {
                loc2.description = loc4 = utils.format.CDATAFormat.getCDataAsXMLNode("description", arg1.description);
            }
            undefined;
            if (arg1.distanceDefined) 
            {
                loc2.distance = loc4 = arg1.distance;
            }
            undefined;
            if (arg1.distanceDownhillDefined) 
            {
                loc2.distanceDownhill = loc4 = arg1.distanceDownhill;
            }
            undefined;
            if (arg1.distanceMinusDefined) 
            {
                loc2.distanceMinus = loc4 = arg1.distanceMinus;
            }
            undefined;
            if (arg1.distancePlusDefined) 
            {
                loc2.distancePlus = loc4 = arg1.distancePlus;
            }
            undefined;
            if (arg1.distancePlusMinusStatusDefined) 
            {
                loc2.distancePlusMinusStatus = loc4 = arg1.distancePlusMinusStatus;
            }
            undefined;
            if (arg1.distanceUphillDefined) 
            {
                loc2.distanceUphill = loc4 = arg1.distanceUphill;
            }
            undefined;
            if (arg1.exerciseTimeDefined) 
            {
                loc2.exerciseTime = loc4 = arg1.exerciseTime;
            }
            undefined;
            if (arg1.externalLinkDefined) 
            {
                loc2.externalLink = loc4 = utils.format.CDATAFormat.getCDataAsXMLNode("externalLink", arg1.externalLink);
            }
            undefined;
            if (arg1.fuelEconomyDefined) 
            {
                loc2.fuelEconomy = loc4 = arg1.fuelEconomy;
            }
            undefined;
            if (arg1.genderDefined) 
            {
                loc2.gender = loc4 = arg1.gender;
            }
            undefined;
            if (arg1.hrMaxDefined) 
            {
                loc2.hrMax = loc4 = arg1.hrMax;
            }
            undefined;
            if (arg1.intensityZone1StartDefined) 
            {
                loc2.intensityZone1Start = loc4 = arg1.intensityZone1Start;
            }
            undefined;
            if (arg1.intensityZone2StartDefined) 
            {
                loc2.intensityZone2Start = loc4 = arg1.intensityZone2Start;
            }
            undefined;
            if (arg1.intensityZone3StartDefined) 
            {
                loc2.intensityZone3Start = loc4 = arg1.intensityZone3Start;
            }
            undefined;
            if (arg1.intensityZone4StartDefined) 
            {
                loc2.intensityZone4Start = loc4 = arg1.intensityZone4Start;
            }
            undefined;
            if (arg1.intensityZone4EndDefined) 
            {
                loc2.intensityZone4End = loc4 = arg1.intensityZone4End;
            }
            undefined;
            if (arg1.latitudeEndDefined) 
            {
                loc2.latitudeEnd = loc4 = arg1.latitudeEnd;
            }
            undefined;
            if (arg1.latitudeStartDefined) 
            {
                loc2.latitudeStart = loc4 = arg1.latitudeStart;
            }
            undefined;
            if (arg1.linkedTrackGUIDDefined) 
            {
                loc2.linkedTrackGUID = loc4 = arg1.linkedTrackGUID;
            }
            undefined;
            if (arg1.longitudeEndDefined) 
            {
                loc2.longitudeEnd = loc4 = arg1.longitudeEnd;
            }
            undefined;
            if (arg1.longitudeStartDefined) 
            {
                loc2.longitudeStart = loc4 = arg1.longitudeStart;
            }
            undefined;
            if (arg1.lowerLimitDefined) 
            {
                loc2.lowerLimit = loc4 = arg1.lowerLimit;
            }
            undefined;
            if (arg1.manualTemperatureDefined) 
            {
                loc2.manualTemperature = loc4 = arg1.manualTemperature;
            }
            undefined;
            if (arg1.maximumAltitudeDefined) 
            {
                loc2.maximumAltitude = loc4 = arg1.maximumAltitude;
            }
            undefined;
            if (arg1.maximumCadenceDefined) 
            {
                loc2.maximumCadence = loc4 = arg1.maximumCadence;
            }
            undefined;
            if (arg1.maximumHeartrateDefined) 
            {
                loc2.maximumHeartrate = loc4 = arg1.maximumHeartrate;
            }
            undefined;
            if (arg1.maximumInclineDefined) 
            {
                loc2.maximumIncline = loc4 = arg1.maximumIncline;
            }
            undefined;
            if (arg1.maximumInclineDownhillDefined) 
            {
                loc2.maximumInclineDownhill = loc4 = arg1.maximumInclineDownhill;
            }
            undefined;
            if (arg1.maximumInclineUphillDefined) 
            {
                loc2.maximumInclineUphill = loc4 = arg1.maximumInclineUphill;
            }
            undefined;
            if (arg1.maximumPercentHRMaxDefined) 
            {
                loc2.maximumPercentHRMax = loc4 = arg1.maximumPercentHRMax;
            }
            undefined;
            if (arg1.maximumPowerDefined) 
            {
                loc2.maximumPower = loc4 = arg1.maximumPower;
            }
            undefined;
            if (arg1.maximumRiseRateDefined) 
            {
                loc2.maximumRiseRate = loc4 = arg1.maximumRiseRate;
            }
            undefined;
            if (arg1.maximumRiseRateDownhillDefined) 
            {
                loc2.maximumRiseRateDownhill = loc4 = arg1.maximumRiseRateDownhill;
            }
            undefined;
            if (arg1.maximumRiseRateUphillDefined) 
            {
                loc2.maximumRiseRateUphill = loc4 = arg1.maximumRiseRateUphill;
            }
            undefined;
            if (arg1.maximumSpeedDefined) 
            {
                loc2.maximumSpeed = loc4 = arg1.maximumSpeed;
            }
            undefined;
            if (arg1.maximumTemperatureDefined) 
            {
                loc2.maximumTemperature = loc4 = arg1.maximumTemperature;
            }
            undefined;
            if (arg1.speedUnitDefined) 
            {
                loc2.measurement = loc4 = arg1.speedUnit;
            }
            undefined;
            if (arg1.minimumAltitudeDefined) 
            {
                loc2.minimumAltitude = loc4 = arg1.minimumAltitude;
            }
            undefined;
            if (arg1.minimumCadenceDefined) 
            {
                loc2.minimumCadence = loc4 = arg1.minimumCadence;
            }
            undefined;
            if (arg1.minimumHeartrateDefined) 
            {
                loc2.minimumHeartrate = loc4 = arg1.minimumHeartrate;
            }
            undefined;
            if (arg1.minimumInclineDefined) 
            {
                loc2.minimumIncline = loc4 = arg1.minimumIncline;
            }
            undefined;
            if (arg1.minimumInclineUphillDefined) 
            {
                loc2.minimumInclineUphill = loc4 = arg1.minimumInclineUphill;
            }
            undefined;
            if (arg1.minimumInclineDownhillDefined) 
            {
                loc2.minimumInclineDownhill = loc4 = arg1.minimumInclineDownhill;
            }
            undefined;
            if (arg1.minimumPercentHRMaxDefined) 
            {
                loc2.minimumPercentHRMax = loc4 = arg1.minimumPercentHRMax;
            }
            undefined;
            if (arg1.minimumPowerDefined) 
            {
                loc2.minimumPower = loc4 = arg1.minimumPower;
            }
            undefined;
            if (arg1.minimumRiseRateDefined) 
            {
                loc2.minimumRiseRate = loc4 = arg1.minimumRiseRate;
            }
            undefined;
            if (arg1.minimumRiseRateUphillDefined) 
            {
                loc2.minimumRiseRateUphill = loc4 = arg1.minimumRiseRateUphill;
            }
            undefined;
            if (arg1.minimumRiseRateDownhillDefined) 
            {
                loc2.minimumRiseRateDownhill = loc4 = arg1.minimumRiseRateDownhill;
            }
            undefined;
            if (arg1.minimumSpeedDefined) 
            {
                loc2.minimumSpeed = loc4 = arg1.minimumSpeed;
            }
            undefined;
            if (arg1.minimumTemperatureDefined) 
            {
                loc2.minimumTemperature = loc4 = arg1.minimumTemperature;
            }
            undefined;
            loc2.name = utils.format.CDATAFormat.getCDataAsXMLNode("name", arg1.name);
            if (arg1.pageHeaderDataDefined) 
            {
                loc2.pageHeaderData = loc4 = arg1.pageHeaderData;
            }
            undefined;
            if (arg1.pauseTimeDefined) 
            {
                loc2.pauseTime = loc4 = arg1.pauseTime;
            }
            undefined;
            if (arg1.percentTimeInIntensityZone1Defined) 
            {
                loc2.percentTimeInIntensityZone1 = loc4 = arg1.percentTimeInIntensityZone1;
            }
            undefined;
            if (arg1.percentTimeInIntensityZone2Defined) 
            {
                loc2.percentTimeInIntensityZone2 = loc4 = arg1.percentTimeInIntensityZone2;
            }
            undefined;
            if (arg1.percentTimeInIntensityZone3Defined) 
            {
                loc2.percentTimeInIntensityZone3 = loc4 = arg1.percentTimeInIntensityZone3;
            }
            undefined;
            if (arg1.percentTimeInIntensityZone4Defined) 
            {
                loc2.percentTimeInIntensityZone4 = loc4 = arg1.percentTimeInIntensityZone4;
            }
            undefined;
            if (arg1.powerZone1StartDefined) 
            {
                loc2.powerZone1Start = loc4 = arg1.powerZone1Start;
            }
            undefined;
            if (arg1.powerZone2StartDefined) 
            {
                loc2.powerZone2Start = loc4 = arg1.powerZone2Start;
            }
            undefined;
            if (arg1.powerZone3StartDefined) 
            {
                loc2.powerZone3Start = loc4 = arg1.powerZone3Start;
            }
            undefined;
            if (arg1.powerZone4StartDefined) 
            {
                loc2.powerZone4Start = loc4 = arg1.powerZone4Start;
            }
            undefined;
            if (arg1.powerZone5StartDefined) 
            {
                loc2.powerZone5Start = loc4 = arg1.powerZone5Start;
            }
            undefined;
            if (arg1.powerZone6StartDefined) 
            {
                loc2.powerZone6Start = loc4 = arg1.powerZone6Start;
            }
            undefined;
            if (arg1.powerZone7EndDefined) 
            {
                loc2.powerZone7End = loc4 = arg1.powerZone7End;
            }
            undefined;
            if (arg1.powerZone7StartDefined) 
            {
                loc2.powerZone7Start = loc4 = arg1.powerZone7Start;
            }
            undefined;
            if (arg1.ratingDefined) 
            {
                loc2.rating = loc4 = arg1.rating;
            }
            undefined;
            if (arg1.feelingDefined) 
            {
                loc2.feeling = loc4 = arg1.feeling;
            }
            undefined;
            if (arg1.trainingTimeDownhillDefined) 
            {
                loc2.trainingTimeDownhill = loc4 = arg1.trainingTimeDownhill;
            }
            undefined;
            if (arg1.trainingTimeUphillDefined) 
            {
                loc2.trainingTimeUphill = loc4 = arg1.trainingTimeUphill;
            }
            undefined;
            if (arg1.rxBatteryStatusDefined) 
            {
                loc2.rxBatteryStatus = loc4 = arg1.rxBatteryStatus;
            }
            undefined;
            if (arg1.samplingRateDefined) 
            {
                loc2.samplingRate = loc4 = arg1.samplingRate;
            }
            undefined;
            if (arg1.shoulderWidthDefined) 
            {
                loc2.shoulderWidth = loc4 = arg1.shoulderWidth;
            }
            undefined;
            if (arg1.shoulderWidthUnitDefined) 
            {
                loc2.shoulderWidthUnit = loc4 = arg1.shoulderWidthUnit;
            }
            undefined;
            if (arg1.startDateDefined) 
            {
                loc2.startDate = loc4 = arg1.startDate;
            }
            undefined;
            loc2.statistic = arg1.statistic ? "true" : "false";
            if (arg1.thresholdPowerDefined) 
            {
                loc2.thresholdPower = loc4 = arg1.thresholdPower;
            }
            undefined;
            if (arg1.timeInIntensityZone1Defined) 
            {
                loc2.timeInIntensityZone1 = loc4 = arg1.timeInIntensityZone1;
            }
            undefined;
            if (arg1.timeInIntensityZone2Defined) 
            {
                loc2.timeInIntensityZone2 = loc4 = arg1.timeInIntensityZone2;
            }
            undefined;
            if (arg1.timeInIntensityZone3Defined) 
            {
                loc2.timeInIntensityZone3 = loc4 = arg1.timeInIntensityZone3;
            }
            undefined;
            if (arg1.timeInIntensityZone4Defined) 
            {
                loc2.timeInIntensityZone4 = loc4 = arg1.timeInIntensityZone4;
            }
            undefined;
            if (arg1.timeInZoneDefined) 
            {
                loc2.timeInTargetZone = loc4 = arg1.timeInZone;
            }
            undefined;
            if (arg1.timeInZone1Defined) 
            {
                loc2.timeInZone1 = loc4 = arg1.timeInZone1;
            }
            undefined;
            if (arg1.timeInZone2Defined) 
            {
                loc2.timeInZone2 = loc4 = arg1.timeInZone2;
            }
            undefined;
            if (arg1.timeInZone3Defined) 
            {
                loc2.timeInZone3 = loc4 = arg1.timeInZone3;
            }
            undefined;
            if (arg1.timeOverIntensityZoneDefined) 
            {
                loc2.timeOverIntensityZone = loc4 = arg1.timeOverIntensityZone;
            }
            undefined;
            if (arg1.timeOverZoneDefined) 
            {
                loc2.timeOverTargetZone = loc4 = arg1.timeOverZone;
            }
            undefined;
            if (arg1.timeUnderIntensityZoneDefined) 
            {
                loc2.timeUnderIntensityZone = loc4 = arg1.timeUnderIntensityZone;
            }
            undefined;
            if (arg1.timeUnderZoneDefined) 
            {
                loc2.timeUnderTargetZone = loc4 = arg1.timeUnderZone;
            }
            undefined;
            if (arg1.trackProfileDefined) 
            {
                loc2.trackProfile = loc4 = arg1.trackProfile;
            }
            undefined;
            if (arg1.trainingTimeDefined) 
            {
                loc2.trainingTime = loc4 = arg1.trainingTime;
            }
            undefined;
            if (arg1.trainingTypeDefined) 
            {
                loc2.trainingType = loc4 = arg1.trainingType.toString();
            }
            undefined;
            if (arg1.trainingZoneDefined) 
            {
                loc2.trainingZone = loc4 = arg1.trainingZone;
            }
            undefined;
            if (arg1.tripSectionDistanceDefined) 
            {
                loc2.tripSectionDistance = loc4 = arg1.tripSectionDistance;
            }
            undefined;
            if (arg1.tripSectionTimeDefined) 
            {
                loc2.tripSectionTime = loc4 = arg1.tripSectionTime;
            }
            undefined;
            if (arg1.txBatteryStatusDefined) 
            {
                loc2.txBatteryStatus = loc4 = arg1.txBatteryStatus;
            }
            undefined;
            if (arg1.upperLimitDefined) 
            {
                loc2.upperLimit = loc4 = arg1.upperLimit;
            }
            undefined;
            if (arg1.weatherDefined) 
            {
                loc2.weather = loc4 = arg1.weather;
            }
            undefined;
            if (arg1.wheelSizeDefined) 
            {
                loc2.wheelSize = loc4 = arg1.wheelSize;
            }
            undefined;
            if (arg1.windDefined) 
            {
                loc2.wind = loc4 = arg1.wind;
            }
            undefined;
            if (arg1.workInKJDefined) 
            {
                loc2.workInKJ = loc4 = arg1.workInKJ;
            }
            undefined;
            if (arg1.zone1StartDefined) 
            {
                loc2.zone1Start = loc4 = arg1.zone1Start;
            }
            undefined;
            if (arg1.zone2StartDefined) 
            {
                loc2.zone2Start = loc4 = arg1.zone2Start;
            }
            undefined;
            if (arg1.zone3EndDefined) 
            {
                loc2.zone3End = loc4 = arg1.zone3End;
            }
            undefined;
            if (arg1.zone3StartDefined) 
            {
                loc2.zone3Start = loc4 = arg1.zone3Start;
            }
            undefined;
            if (arg1.chestbeltManufacturerDefined) 
            {
                loc2.chestbeltManufacturer = loc4 = arg1.chestbeltManufacturer;
            }
            undefined;
            if (arg1.withDeviceDefined) 
            {
                loc2.withDevice = loc4 = arg1.withDevice;
            }
            undefined;
            if (arg1.motionPointsDefined) 
            {
                loc2.motionPoints = loc4 = arg1.motionPoints;
            }
            undefined;
            if (arg1.stepsDefined) 
            {
                loc2.steps = loc4 = arg1.steps;
            }
            undefined;
            if (arg1.activeTimeLowDefined) 
            {
                loc2.timeActiveLow = loc4 = arg1.activeTimeLow;
            }
            undefined;
            if (arg1.activeTimeMiddleDefined) 
            {
                loc2.timeActiveMiddle = loc4 = arg1.activeTimeMiddle;
            }
            undefined;
            if (arg1.activeTimeHighDefined) 
            {
                loc2.timeActiveHigh = loc4 = arg1.activeTimeHigh;
            }
            undefined;
            if (arg1.timeDeepSleepDefined) 
            {
                loc2.timeDeepSleep = loc4 = arg1.timeDeepSleep;
            }
            undefined;
            if (arg1.timeLightSleepDefined) 
            {
                loc2.timeLightSleep = loc4 = arg1.timeLightSleep;
            }
            undefined;
            if (arg1.timeWakeUpDefined) 
            {
                loc2.timeWakeUp = loc4 = arg1.timeWakeUp;
            }
            undefined;
            if (arg1.timeSleepDefined) 
            {
                loc2.timeSleep = loc4 = arg1.timeSleep;
            }
            undefined;
            if (arg1.targetDayDefined) 
            {
                loc2.targetDay = loc4 = arg1.targetDay;
            }
            undefined;
            if (arg1.best5KTimeDefined) 
            {
                loc2.best5KTime = loc4 = arg1.best5KTime;
            }
            undefined;
            if (arg1.best5KEntryDefined) 
            {
                loc2.best5KEntry = loc4 = arg1.best5KEntry;
            }
            undefined;
            if (arg1.best20minPowerDefined) 
            {
                loc2.best20minPower = loc4 = arg1.best20minPower;
            }
            undefined;
            if (arg1.best20minPowerEntryDefined) 
            {
                loc2.best20minPowerEntry = loc4 = arg1.best20minPowerEntry;
            }
            undefined;
            if (arg1.powerNPDefined) 
            {
                loc2.powerNP = loc4 = arg1.powerNP;
            }
            undefined;
            if (arg1.powerTSSDefined) 
            {
                loc2.powerTSS = loc4 = arg1.powerTSS;
            }
            undefined;
            if (arg1.powerFTPDefined) 
            {
                loc2.powerFTP = loc4 = arg1.powerFTP;
            }
            undefined;
            if (arg1.pedalingTimeDefined) 
            {
                loc2.pedalingTime = loc4 = arg1.pedalingTime;
            }
            undefined;
            if (arg1.pedalingIndexDefined) 
            {
                loc2.pedalingIndex = loc4 = arg1.pedalingIndex;
            }
            undefined;
            if (arg1.maximumExpansionDefined) 
            {
                loc2.maximumExpansion = loc4 = arg1.maximumExpansion;
            }
            undefined;
            if (arg1.maximumExpansionUphillDefined) 
            {
                loc2.maximumExpansionUphill = loc4 = arg1.maximumExpansionUphill;
            }
            undefined;
            if (arg1.maximumExpansionDownhillDefined) 
            {
                loc2.maximumExpansionDownhill = loc4 = arg1.maximumExpansionDownhill;
            }
            undefined;
            if (arg1.averageBalanceRightDefined) 
            {
                loc2.averageBalanceRight = loc4 = arg1.averageBalanceRight;
            }
            undefined;
            if (arg1.averageBalanceLeftDefined) 
            {
                loc2.averageBalanceLeft = loc4 = arg1.averageBalanceLeft;
            }
            undefined;
            if (arg1.powerFTPDefined) 
            {
                loc2.powerIF = loc4 = arg1.powerIF;
            }
            undefined;
            if (arg1.torqueEffectLeftDefined) 
            {
                loc2.torqueEffectLeft = loc4 = arg1.torqueEffectLeft;
            }
            undefined;
            if (arg1.torqueEffectRightDefined) 
            {
                loc2.torqueEffectRight = loc4 = arg1.torqueEffectRight;
            }
            undefined;
            if (arg1.pedalSmoothLeftDefined) 
            {
                loc2.pedalSmoothLeft = loc4 = arg1.pedalSmoothLeft;
            }
            undefined;
            if (arg1.pedalSmoothRightDefined) 
            {
                loc2.pedalSmoothRight = loc4 = arg1.pedalSmoothRight;
            }
            undefined;
            if (arg1.averageCadenceCalcDefined) 
            {
                loc2.averageCadenceCalc = loc4 = arg1.averageCadenceCalc;
            }
            undefined;
            if (arg1.averagePowerCalcDefined) 
            {
                loc2.averagePowerCalc = loc4 = arg1.averagePowerCalc;
            }
            undefined;
            loc2.simpleHeaderValuesCalculation = arg1.simpleHeaderValuesCalculation ? "true" : "false";
            loc2.sharingInfo = encodeSharingInformations(arg1);
            loc3.appendChild(loc2);
            loc3.GeneralInformation.Participant = new XML("<Participant/>");
            var loc6:*=0;
            var loc5:*=arg1.participant;
            for each (var loc1:* in loc5) 
            {
                loc3.GeneralInformation.Participant.appendChild(loc1.toXML());
            }
            if (!arg3) 
            {
                return loc3;
            }
            loc3.appendChild(generateEntries(arg1));
            loc3.appendChild(generateMarkers(arg1));
            return loc3;
        }

        public static function encodeSharingInformations(arg1:core.activities.Activity):String
        {
            var loc1:*=new core.activities.ActivityShareObject(arg1);
            return loc1.toJson();
        }

        public static function decodeSharingInformations(arg1:String, arg2:core.activities.Activity):void
        {
            if (!arg1) 
            {
                return;
            }
            var loc1:*=new core.activities.ActivityShareObject();
            loc1.fromJson(arg1);
            loc1.saveToActivity(arg2);
            return;
        }

        public static function isShared(arg1:String):Boolean
        {
            if (!arg1) 
            {
                return false;
            }
            var loc1:*=new core.activities.ActivityShareObject();
            loc1.fromJson(arg1);
            return loc1.isAnyShared();
        }

        public static function resetSharingInformation(arg1:core.activities.Activity):void
        {
            var loc1:*=new core.activities.ActivityShareObject();
            loc1.reset();
            loc1.saveToActivity(arg1);
            return;
        }

        internal static function fromSLF400(arg1:XML, arg2:core.activities.Activity):void
        {
            var loc3:*=undefined;
            arg2.unitType = core.general.UnitType.fromString(arg1.Computer.@unit);
            if (arg2.unitType == null) 
            {
                arg2.serialNumberDefined = false;
                arg2.dateCodeDefined = false;
                arg2.logTypeDefined = false;
                arg2.logVersionDefined = false;
            }
            else 
            {
                arg2.serialNumberDefined = true;
                arg2.serialNumber = arg1.Computer.@serial;
                arg2.dateCodeDefined = true;
                arg2.dateCode = arg1.Computer.@dateCode;
                arg2.logType = core.general.LogType.fromString(arg1.Computer.@activityType);
                arg2.logTypeDefined = !(arg2.logType == null);
            }
            var loc1:*=arg1.GeneralInformation;
            loc3 = loc1.age;
            var loc5:*;
            arg2.ageDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.age = loc3;
            }
            if ((loc3 = loc1.activityStatus) != undefined) 
            {
                arg2.activityStatus = loc3;
            }
            loc3 = loc1.altitudeDifferencesDownhill;
            arg2.altitudeDifferencesDownhillDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.altitudeDifferencesDownhill = loc3;
            }
            loc3 = loc1.altitudeDifferencesUphill;
            arg2.altitudeDifferencesUphillDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.altitudeDifferencesUphill = loc3;
            }
            loc3 = loc1.averageAltitude;
            arg2.averageAltitudeDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.averageAltitude = loc3;
            }
            loc3 = loc1.averageCadence;
            arg2.averageCadenceDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.averageCadence = loc3;
            }
            loc3 = loc1.averageExpansion;
            arg2.averageExpansionDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.averageExpansion = loc3;
            }
            loc3 = loc1.averageExpansionDownhill;
            arg2.averageExpansionDownhillDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.averageExpansionDownhill = loc3;
            }
            loc3 = loc1.averageExpansionUphill;
            arg2.averageExpansionUphillDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.averageExpansionUphill = loc3;
            }
            loc3 = loc1.averageHeartrate;
            arg2.averageHeartrateDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.averageHeartrate = loc3;
            }
            loc3 = loc1.averageInclineDownhill;
            arg2.averageInclineDownhillDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.averageInclineDownhill = loc3;
            }
            loc3 = loc1.averageInclineUphill;
            arg2.averageInclineUphillDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.averageInclineUphill = loc3;
            }
            loc3 = loc1.averagePercentHRMax;
            arg2.averagePercentHRMaxDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.averagePercentHRMax = loc3;
            }
            loc3 = loc1.averagePower;
            arg2.averagePowerDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.averagePower = loc3;
            }
            loc3 = loc1.averagePowerKJ;
            arg2.averagePowerKJDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.averagePowerKJ = loc3;
            }
            loc3 = loc1.averagePowerWattPerKG;
            arg2.averagePowerWattPerKGDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.averagePowerWattPerKG = loc3;
            }
            loc3 = loc1.averageRiseRate;
            arg2.averageRiseRateDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.averageRiseRate = loc3;
            }
            loc3 = loc1.averageRiseRateUphill;
            arg2.averageRiseRateUphillDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.averageRiseRateUphill = loc3;
            }
            loc3 = loc1.averageRiseRateDownhill;
            arg2.averageRiseRateDownhillDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.averageRiseRateDownhill = loc3;
            }
            loc3 = loc1.averageSpeed;
            arg2.averageSpeedDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.averageSpeed = loc3;
            }
            loc3 = loc1.averageSpeedDownhill;
            arg2.averageSpeedDownhillDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.averageSpeedDownhill = loc3;
            }
            loc3 = loc1.averageSpeedUphill;
            arg2.averageSpeedUphillDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.averageSpeedUphill = loc3;
            }
            loc3 = loc1.averageTemperature;
            arg2.averageTemperatureDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.averageTemperature = loc3;
            }
            loc3 = loc1.bike;
            arg2.bike = loc3 == undefined ? "noBike" : loc3;
            loc3 = loc1.bikeType;
            arg2.bikeTypeDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.bikeType = loc3;
            }
            loc3 = loc1.bikeWeight;
            arg2.bikeWeightDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.bikeWeight = loc3;
            }
            loc3 = loc1.bikeWeightUnit;
            arg2.bikeWeightUnitDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.bikeWeightUnit = loc3;
            }
            loc3 = loc1.bodyHeight;
            arg2.bodyHeightDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.bodyHeight = loc3;
            }
            loc3 = loc1.bodyHeightUnit;
            arg2.bodyHeightUnitDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.bodyHeightUnit = loc3;
            }
            loc3 = loc1.bodyWeight;
            arg2.bodyWeightDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.bodyWeight = loc3;
            }
            loc3 = loc1.bodyWeightUnit;
            arg2.bodyWeightUnitDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.bodyWeightUnit = loc3;
            }
            loc3 = loc1.calibration;
            arg2.calibrationDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.calibration = loc3;
            }
            loc3 = loc1.calories;
            arg2.caloriesDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.calories = loc3;
            }
            loc3 = loc1.caloriesDifferenceFactor;
            arg2.caloriesDifferenceFactorDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.caloriesDifferenceFactor = loc3;
            }
            loc3 = loc1.correctionChestRun;
            arg2.correctionChestRunDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.correctionChestRun = loc3;
            }
            loc3 = loc1.correctionChestWalk;
            arg2.correctionChestWalkDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.correctionChestWalk = loc3;
            }
            loc3 = loc1.correctionFactor;
            arg2.correctionFactorDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.correctionFactor = loc3;
            }
            loc3 = loc1.correctionHipRun;
            arg2.correctionHipRunDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.correctionHipRun = loc3;
            }
            loc3 = loc1.correctionHipWalk;
            arg2.correctionHipWalkDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.correctionHipWalk = loc3;
            }
            loc3 = loc1.description;
            arg2.descriptionDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.description = loc3;
            }
            loc3 = loc1.distance;
            arg2.distanceDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.distance = loc3;
            }
            loc3 = loc1.distanceDownhill;
            arg2.distanceDownhillDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.distanceDownhill = loc3;
            }
            loc3 = loc1.distanceMinus;
            arg2.distanceMinusDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.distanceMinus = loc3;
            }
            loc3 = loc1.distancePlus;
            arg2.distancePlusDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.distancePlus = loc3;
            }
            loc3 = loc1.distancePlusMinusStatus;
            arg2.distancePlusMinusStatusDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.distancePlusMinusStatus = loc3;
            }
            loc3 = loc1.distanceUphill;
            arg2.distanceUphillDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.distanceUphill = loc3;
            }
            loc3 = loc1.exerciseTime;
            arg2.exerciseTimeDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.exerciseTime = loc3;
            }
            loc3 = loc1.externalLink;
            arg2.externalLinkDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.externalLink = loc3;
            }
            loc3 = loc1.fuelEconomy;
            arg2.fuelEconomyDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.fuelEconomy = loc3;
            }
            loc3 = loc1.tripSectionDistance;
            arg2.tripSectionDistanceDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.tripSectionDistance = loc3;
            }
            loc3 = loc1.tripSectionTime;
            arg2.tripSectionTimeDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.tripSectionTime = loc3;
            }
            loc3 = loc1.gender;
            arg2.genderDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.gender = loc3;
            }
            loc3 = loc1.hrMax;
            arg2.hrMaxDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.hrMax = loc3;
            }
            loc3 = loc1.intensityZone1Start;
            arg2.intensityZone1StartDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.intensityZone1Start = loc3;
            }
            loc3 = loc1.intensityZone2Start;
            arg2.intensityZone2StartDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.intensityZone2Start = loc3;
            }
            loc3 = loc1.intensityZone3Start;
            arg2.intensityZone3StartDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.intensityZone3Start = loc3;
            }
            loc3 = loc1.intensityZone4Start;
            arg2.intensityZone4StartDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.intensityZone4Start = loc3;
            }
            loc3 = loc1.intensityZone4End;
            arg2.intensityZone4EndDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.intensityZone4End = loc3;
            }
            loc3 = loc1.latitudeEnd;
            arg2.latitudeEndDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.latitudeEnd = loc3;
            }
            loc3 = loc1.latitudeStart;
            arg2.latitudeStartDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.latitudeStart = loc3;
            }
            loc3 = loc1.linkedRouteId;
            arg2.linkedRouteIdDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.linkedRouteId = loc3;
            }
            loc3 = loc1.linkedTrackGUID;
            arg2.linkedTrackGUIDDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.linkedTrackGUID = loc3;
            }
            loc3 = loc1.longitudeEnd;
            arg2.longitudeEndDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.longitudeEnd = loc3;
            }
            loc3 = loc1.longitudeStart;
            arg2.longitudeStartDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.longitudeStart = loc3;
            }
            loc3 = loc1.lowerLimit;
            arg2.lowerLimitDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.lowerLimit = loc3;
            }
            loc3 = loc1.manualTemperature;
            arg2.manualTemperatureDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.manualTemperature = loc3;
            }
            loc3 = loc1.maximumAltitude;
            arg2.maximumAltitudeDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.maximumAltitude = loc3;
            }
            loc3 = loc1.maximumCadence;
            arg2.maximumCadenceDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.maximumCadence = loc3;
            }
            loc3 = loc1.maximumHeartrate;
            arg2.maximumHeartrateDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.maximumHeartrate = loc3;
            }
            loc3 = loc1.maximumIncline;
            arg2.maximumInclineDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.maximumIncline = loc3;
            }
            loc3 = loc1.maximumInclineDownhill;
            arg2.maximumInclineDownhillDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.maximumInclineDownhill = loc3;
            }
            loc3 = loc1.maximumInclineUphill;
            arg2.maximumInclineUphillDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.maximumInclineUphill = loc3;
            }
            loc3 = loc1.maximumPercentHRMax;
            arg2.maximumPercentHRMaxDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.maximumPercentHRMax = loc3;
            }
            loc3 = loc1.maximumPower;
            arg2.maximumPowerDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.maximumPower = loc3;
            }
            loc3 = loc1.maximumRiseRate;
            arg2.maximumRiseRateDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.maximumRiseRate = loc3;
            }
            loc3 = loc1.maximumRiseRateDownhill;
            arg2.maximumRiseRateDownhillDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.maximumRiseRateDownhill = loc3;
            }
            loc3 = loc1.maximumRiseRateUphill;
            arg2.maximumRiseRateUphillDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.maximumRiseRateUphill = loc3;
            }
            loc3 = loc1.maximumSpeed;
            arg2.maximumSpeedDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.maximumSpeed = loc3;
            }
            loc3 = loc1.maximumTemperature;
            arg2.maximumTemperatureDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.maximumTemperature = loc3;
            }
            loc3 = loc1.measurement;
            arg2.speedUnitDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.speedUnit = loc3;
            }
            loc3 = loc1.minimumAltitude;
            arg2.minimumAltitudeDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.minimumAltitude = loc3;
            }
            loc3 = loc1.minimumCadence;
            arg2.minimumCadenceDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.minimumCadence = loc3;
            }
            loc3 = loc1.minimumHeartrate;
            arg2.minimumHeartrateDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.minimumHeartrate = loc3;
            }
            loc3 = loc1.minimumIncline;
            arg2.minimumInclineDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.minimumIncline = loc3;
            }
            loc3 = loc1.minimumInclineUphill;
            arg2.minimumInclineUphillDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.minimumInclineUphill = loc3;
            }
            loc3 = loc1.minimumInclineDownhill;
            arg2.minimumInclineDownhillDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.minimumInclineDownhill = loc3;
            }
            loc3 = loc1.minimumPercentHRMax;
            arg2.minimumPercentHRMaxDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.minimumPercentHRMax = loc3;
            }
            loc3 = loc1.minimumPower;
            arg2.minimumPowerDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.minimumPower = loc3;
            }
            loc3 = loc1.minimumRiseRate;
            arg2.minimumRiseRateDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.minimumRiseRate = loc3;
            }
            loc3 = loc1.minimumRiseRateUphill;
            arg2.minimumRiseRateUphillDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.minimumRiseRateUphill = loc3;
            }
            loc3 = loc1.minimumRiseRateDownhill;
            arg2.minimumRiseRateDownhillDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.minimumRiseRateDownhill = loc3;
            }
            loc3 = loc1.minimumSpeed;
            arg2.minimumSpeedDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.minimumSpeed = loc3;
            }
            loc3 = loc1.minimumTemperature;
            arg2.minimumTemperatureDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.minimumTemperature = loc3;
            }
            loc3 = utils.format.CDATAFormat.getCDataAsXMLNode("name", loc1.name);
            arg2.name = loc3;
            loc3 = loc1.pageHeaderData;
            arg2.pageHeaderDataDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.pageHeaderData = (loc3 as XMLList).toString().split(",");
            }
            loc3 = loc1.pauseTime;
            arg2.pauseTimeDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.pauseTime = loc3;
            }
            loc3 = loc1.percentTimeInIntensityZone1;
            arg2.percentTimeInIntensityZone1Defined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.percentTimeInIntensityZone1 = loc3;
            }
            loc3 = loc1.percentTimeInIntensityZone2;
            arg2.percentTimeInIntensityZone2Defined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.percentTimeInIntensityZone2 = loc3;
            }
            loc3 = loc1.percentTimeInIntensityZone3;
            arg2.percentTimeInIntensityZone3Defined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.percentTimeInIntensityZone3 = loc3;
            }
            loc3 = loc1.percentTimeInIntensityZone4;
            arg2.percentTimeInIntensityZone4Defined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.percentTimeInIntensityZone4 = loc3;
            }
            loc3 = loc1.powerZone1Start;
            arg2.powerZone1StartDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.powerZone1Start = loc3;
            }
            loc3 = loc1.powerZone2Start;
            arg2.powerZone2StartDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.powerZone2Start = loc3;
            }
            loc3 = loc1.powerZone3Start;
            arg2.powerZone3StartDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.powerZone3Start = loc3;
            }
            loc3 = loc1.powerZone4Start;
            arg2.powerZone4StartDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.powerZone4Start = loc3;
            }
            loc3 = loc1.powerZone5Start;
            arg2.powerZone5StartDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.powerZone5Start = loc3;
            }
            loc3 = loc1.powerZone6Start;
            arg2.powerZone6StartDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.powerZone6Start = loc3;
            }
            loc3 = loc1.powerZone7End;
            arg2.powerZone7EndDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.powerZone7End = loc3;
            }
            loc3 = loc1.powerZone7Start;
            arg2.powerZone7StartDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.powerZone7Start = loc3;
            }
            loc3 = loc1.rating;
            arg2.ratingDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.rating = loc3;
            }
            loc3 = loc1.feeling;
            arg2.feelingDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.feeling = loc3;
            }
            loc3 = loc1.trainingTimeDownhill;
            arg2.trainingTimeDownhillDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.trainingTimeDownhill = loc3;
            }
            loc3 = loc1.trainingTimeUphill;
            arg2.trainingTimeUphillDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.trainingTimeUphill = loc3;
            }
            loc3 = loc1.rxBatteryStatus;
            arg2.rxBatteryStatusDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.rxBatteryStatus = loc3;
            }
            loc3 = loc1.samplingRate;
            arg2.samplingRateDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.samplingRate = loc3;
            }
            loc3 = loc1.shoulderWidth;
            arg2.shoulderWidthDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.shoulderWidth = loc3;
            }
            loc3 = loc1.shoulderWidthUnit;
            arg2.shoulderWidthUnitDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.shoulderWidthUnit = loc3;
            }
            loc3 = loc1.startDate;
            arg2.startDateDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.startDate = new Date(arg1.GeneralInformation.startDate.text().toString());
            }
            arg2.statistic = loc1.statistic.text().toString() != "true" ? false : true;
            loc3 = loc1.thresholdPower;
            arg2.thresholdPowerDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.thresholdPower = loc3;
            }
            loc3 = loc1.timeInIntensityZone1;
            arg2.timeInIntensityZone1Defined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.timeInIntensityZone1 = loc3;
            }
            loc3 = loc1.timeInIntensityZone2;
            arg2.timeInIntensityZone2Defined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.timeInIntensityZone2 = loc3;
            }
            loc3 = loc1.timeInIntensityZone3;
            arg2.timeInIntensityZone3Defined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.timeInIntensityZone3 = loc3;
            }
            loc3 = loc1.timeInIntensityZone4;
            arg2.timeInIntensityZone4Defined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.timeInIntensityZone4 = loc3;
            }
            loc3 = loc1.timeInPowerZone1;
            arg2.timeInPowerZone1Defined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.timeInPowerZone1 = loc3;
            }
            loc3 = loc1.timeInPowerZone2;
            arg2.timeInPowerZone2Defined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.timeInPowerZone2 = loc3;
            }
            loc3 = loc1.timeInPowerZone3;
            arg2.timeInPowerZone3Defined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.timeInPowerZone3 = loc3;
            }
            loc3 = loc1.timeInPowerZone4;
            arg2.timeInPowerZone4Defined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.timeInPowerZone4 = loc3;
            }
            loc3 = loc1.timeInPowerZone5;
            arg2.timeInPowerZone5Defined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.timeInPowerZone5 = loc3;
            }
            loc3 = loc1.timeInPowerZone6;
            arg2.timeInPowerZone6Defined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.timeInPowerZone6 = loc3;
            }
            loc3 = loc1.timeInPowerZone7;
            arg2.timeInPowerZone7Defined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.timeInPowerZone7 = loc3;
            }
            loc3 = loc1.timeInTargetZone;
            arg2.timeInZoneDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.timeInZone = loc3;
            }
            loc3 = loc1.timeInZone1;
            arg2.timeInZone1Defined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.timeInZone1 = loc3;
            }
            loc3 = loc1.timeInZone2;
            arg2.timeInZone2Defined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.timeInZone2 = loc3;
            }
            loc3 = loc1.timeInZone3;
            arg2.timeInZone3Defined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.timeInZone3 = loc3;
            }
            loc3 = loc1.timeOverIntensityZone;
            arg2.timeOverIntensityZoneDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.timeOverIntensityZone = loc3;
            }
            loc3 = loc1.timeOverTargetZone;
            arg2.timeOverZoneDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.timeOverZone = loc3;
            }
            loc3 = loc1.timeUnderIntensityZone;
            arg2.timeUnderIntensityZoneDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.timeUnderIntensityZone = loc3;
            }
            loc3 = loc1.timeUnderTargetZone;
            arg2.timeUnderZoneDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.timeUnderZone = loc3;
            }
            loc3 = loc1.trackProfile;
            arg2.trackProfileDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.trackProfile = loc3;
            }
            loc3 = loc1.trainingTime;
            arg2.trainingTimeDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.trainingTime = loc3;
            }
            loc3 = loc1.trainingType;
            arg2.trainingTypeDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.trainingType = loc3;
            }
            loc3 = loc1.trainingZone;
            arg2.trainingZoneDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.trainingZone = loc3;
            }
            loc3 = loc1.tripSectionDistance;
            arg2.tripSectionDistanceDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.tripSectionDistance = loc3;
            }
            loc3 = loc1.tripSectionTime;
            arg2.tripSectionTimeDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.tripSectionTime = loc3;
            }
            loc3 = loc1.txBatteryStatus;
            arg2.txBatteryStatusDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.txBatteryStatus = loc3;
            }
            loc3 = loc1.upperLimit;
            arg2.upperLimitDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.upperLimit = loc3;
            }
            loc3 = loc1.weather;
            arg2.weatherDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.weather = loc3;
            }
            loc3 = loc1.wheelSize;
            arg2.wheelSizeDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.wheelSize = loc3;
            }
            loc3 = loc1.wind;
            arg2.windDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.wind = loc3;
            }
            loc3 = loc1.workInKJ;
            arg2.workInKJDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.workInKJ = loc3;
            }
            loc3 = loc1.zone1Start;
            arg2.zone1StartDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.zone1Start = loc3;
            }
            loc3 = loc1.zone2Start;
            arg2.zone2StartDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.zone2Start = loc3;
            }
            loc3 = loc1.zone3End;
            arg2.zone3EndDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.zone3End = loc3;
            }
            loc3 = loc1.zone3Start;
            arg2.zone3StartDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.zone3Start = loc3;
            }
            loc3 = loc1.chestbeltManufacturer;
            arg2.chestbeltManufacturerDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.chestbeltManufacturer = loc3;
            }
            loc3 = loc1.withDevice;
            arg2.withDeviceDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.withDevice = loc3;
            }
            loc3 = loc1.motionPoints;
            arg2.motionPointsDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.motionPoints = loc3;
            }
            loc3 = loc1.steps;
            arg2.stepsDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.steps = loc3;
            }
            loc3 = loc1.timeActiveLow;
            arg2.activeTimeLowDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.activeTimeLow = loc3;
            }
            loc3 = loc1.timeActiveMiddle;
            arg2.activeTimeMiddleDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.activeTimeMiddle = loc3;
            }
            loc3 = loc1.timeActiveHigh;
            arg2.activeTimeHighDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.activeTimeHigh = loc3;
            }
            loc3 = loc1.timeDeepSleep;
            arg2.timeDeepSleepDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.timeDeepSleep = loc3;
            }
            loc3 = loc1.timeLightSleep;
            arg2.timeLightSleepDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.timeLightSleep = loc3;
            }
            loc3 = loc1.timeWakeUp;
            arg2.timeWakeUpDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.timeWakeUp = loc3;
            }
            loc3 = loc1.timeSleep;
            arg2.timeSleepDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.timeSleep = loc3;
            }
            loc3 = loc1.percentDeepSleep;
            arg2.percentDeepSleepDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.percentDeepSleep = loc3;
            }
            loc3 = loc1.percentLightSleep;
            arg2.percentLightSleepDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.percentLightSleep = loc3;
            }
            loc3 = loc1.percentWakeUp;
            arg2.percentWakeUpDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.percentWakeUp = loc3;
            }
            loc3 = loc1.targetDay;
            arg2.targetDayDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.targetDay = loc3;
            }
            loc3 = loc1.best5KTime;
            arg2.best5KTimeDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.best5KTime = loc3;
            }
            loc3 = loc1.best5KEntry;
            arg2.best5KEntryDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.best5KEntry = loc3;
            }
            loc3 = loc1.best20minPower;
            arg2.best20minPowerDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.best20minPower = loc3;
            }
            loc3 = loc1.best20minPowerEntry;
            arg2.best20minPowerEntryDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.best20minPowerEntry = loc3;
            }
            loc3 = loc1.powerNP;
            arg2.powerNPDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.powerNP = loc3;
            }
            loc3 = loc1.powerTSS;
            arg2.powerTSSDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.powerTSS = loc3;
            }
            loc3 = loc1.powerFTP;
            arg2.powerFTPDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.powerFTP = loc3;
            }
            loc3 = loc1.pedalingTime;
            arg2.pedalingTimeDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.pedalingTime = loc3;
            }
            loc3 = loc1.pedalingIndex;
            arg2.pedalingIndexDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.pedalingIndex = loc3;
            }
            loc3 = loc1.maximumExpansion;
            arg2.maximumExpansionDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.maximumExpansion = loc3;
            }
            loc3 = loc1.maximumExpansionUphill;
            arg2.maximumExpansionUphillDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.maximumExpansionUphill = loc3;
            }
            loc3 = loc1.maximumExpansionDownhill;
            arg2.maximumExpansionDownhillDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.maximumExpansionDownhill = loc3;
            }
            loc3 = loc1.averageBalanceRight;
            arg2.averageBalanceRightDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.averageBalanceRight = loc3;
            }
            loc3 = loc1.averageBalanceLeft;
            arg2.averageBalanceLeftDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.averageBalanceLeft = loc3;
            }
            loc3 = loc1.powerIF;
            arg2.powerIFDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.powerIF = loc3;
            }
            loc3 = loc1.torqueEffectLeft;
            arg2.torqueEffectLeftDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.torqueEffectLeft = loc3;
            }
            loc3 = loc1.torqueEffectRight;
            arg2.torqueEffectRightDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.torqueEffectRight = loc3;
            }
            loc3 = loc1.pedalSmoothLeft;
            arg2.pedalSmoothLeftDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.pedalSmoothLeft = loc3;
            }
            loc3 = loc1.pedalSmoothRight;
            arg2.pedalSmoothRightDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.pedalSmoothRight = loc3;
            }
            loc3 = loc1.averageCadenceCalc;
            arg2.averageCadenceCalcDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.averageCadenceCalc = loc3;
            }
            loc3 = loc1.averagePowerCalc;
            arg2.averagePowerCalcDefined = loc5 = !(loc3 == undefined);
            if (loc5 == true) 
            {
                arg2.averagePowerCalc = loc3;
            }
            var loc7:*=0;
            var loc6:*=arg1.GeneralInformation.Participant.Person;
            for each (var loc2:* in loc6) 
            {
                arg2.participant.push(core.participant.Person.createFromXML(loc2));
            }
            if ((loc3 = loc1.simpleHeaderValuesCalculation) != undefined) 
            {
                arg2.simpleHeaderValuesCalculation = loc1.simpleHeaderValuesCalculation.text().toString() != "true" ? false : true;
            }
            decodeSharingInformations(loc1.sharingInfo, arg2);
            var loc4:*;
            if (loc4 = core.activities.TrainingPartnerHandlerCommon.getInstance()) 
            {
                loc4.validatePersons(arg2.participant);
            }
            return;
        }

        internal static function retrieveDataTypeFromXMLRootNode(arg1:XML):String
        {
            var loc1:*=null;
            if (!(arg1.LogEntries == undefined) || !(arg1.Entries == undefined)) 
            {
                return "log";
            }
            return "memory";
        }

        internal static function generateEntries(arg1:core.activities.Activity):XML
        {
            var loc4:*=0;
            var loc2:*=null;
            var loc1:*=new XML("<Entries/>");
            var loc3:*=arg1.entries.length;
            loc4 = 0;
            while (loc4 < loc3) 
            {
                loc1.appendChild(core.activities.ActivityEntryMapper.generateXML(arg1.entries[loc4]));
                ++loc4;
            }
            return loc1;
        }

        internal static function generateMarkers(arg1:core.activities.Activity):XML
        {
            var loc4:*=0;
            var loc2:*=null;
            var loc3:*=new XML("<Markers/>");
            var loc1:*=arg1.markerList.length;
            loc4 = 0;
            while (loc4 < loc1) 
            {
                loc3.appendChild(core.marker.MarkerMapper.generateXML(arg1.markerList[loc4]));
                ++loc4;
            }
            return loc3;
        }

        internal static function getSecondsOf(arg1:String):Number
        {
            var loc1:*=0;
            var loc2:*=arg1.split(":");
            if (loc2.length == 3) 
            {
                loc1 = parseInt(loc2[0]) * 3600;
                loc1 = loc1 + parseInt(loc2[1]) * 60;
                loc1 = loc1 + parseInt(loc2[2]);
            }
            return loc1;
        }

        internal static function loadEntries(arg1:XML, arg2:core.activities.Activity, arg3:int):void
        {
            var loc3:*=0;
            var loc7:*=0;
            var loc1:*=null;
            arg2.entries.splice(0, arg2.entries.length);
            var loc4:*=false;
            var loc5:*=0;
            var loc8:*=0;
            if (arg3 < 400) 
            {
                loc1 = arg1.LogEntries.LogEntry;
            }
            else 
            {
                loc1 = arg1.Entries.Entry;
            }
            loc3 = loc1.length();
            if (arg2.calories > 0 && loc3 > 0 && (core.general.UnitType.ROX91.equals(arg2.unitType) || core.general.UnitType.RC1411.equals(arg2.unitType)) && 210 <= arg3 && arg3 <= 300) 
            {
                loc4 = true;
            }
            var loc6:*=null;
            var loc2:*=null;
            loc7 = 0;
            while (loc7 < loc3) 
            {
                loc6 = core.activities.ActivityFactory.createLogEntryFromLog(arg2);
                core.activities.ActivityEntryMapper.fromXML(loc1[loc7], loc2, arg3, loc6);
                if (loc4) 
                {
                    loc6.calories = utils.Calculations.calculateCalories(arg2, loc6, arg2.bikeWeightUnit);
                    loc6.caloriesDefined = true;
                    loc8 = loc8 + loc6.calories;
                }
                arg2.entries.push(loc6);
                loc2 = loc6;
                ++loc7;
            }
            if (loc4) 
            {
                arg2.caloriesDifferenceFactorDefined = true;
                utils.Calculations.calculateCaloriesDifferenceFactor(arg2, arg2.calories, loc8);
                arg2.calories = loc8;
                loc7 = 0;
                while (loc7 < loc3) 
                {
                    arg2.entries[loc7].calories = arg2.entries[loc7].calories - arg2.entries[loc7].calories * arg2.caloriesDifferenceFactor;
                    ++loc7;
                }
            }
            return;
        }

        public static const col_averagePowerWattPerKG:String="averagePowerWattPerKG";

        public static const col_averageRiseRate:String="averageRiseRate";

        public static const col_averageRiseRateDownhill:String="averageRiseRateDownhill";

        public static const col_averageRiseRateUphill:String="averageRiseRateUphill";

        public static const col_averageSpeed:String="averageSpeed";

        public static const col_averageSpeedDownhill:String="averageSpeedDownhill";

        public static const col_averageSpeedUphill:String="averageSpeedUphill";

        public static const col_averageTemperature:String="averageTemperature";

        public static const col_best20minPower:String="best20minPower";

        public static const col_best20minPowerEntry:String="best20minPowerEntry";

        public static const col_best5KEntry:String="best5KEntry";

        public static const col_best5KTime:String="best5KTime";

        public static const col_bike:String="bike";

        public static const col_bikeType:String="bikeType";

        public static const col_bikeWeight:String="bikeWeight";

        public static const col_bikeWeightUnit:String="bikeWeightUnit";

        public static const col_bodyHeight:String="bodyHeight";

        public static const col_bodyHeightUnit:String="bodyHeightUnit";

        public static const col_bodyWeight:String="bodyWeight";

        public static const col_bodyWeightUnit:String="bodyWeightUnit";

        public static const col_calibration:String="calibration";

        public static const col_calories:String="calories";

        public static const col_caloriesDifferenceFactor:String="caloriesDifferenceFactor";

        public static const col_chestbeltManufacturer:String="chestbeltManufacturer";

        public static const col_correctionChestRun:String="correctionChestRun";

        public static const col_correctionChestWalk:String="correctionChestWalk";

        public static const col_correctionFactor:String="correctionFactor";

        public static const col_correctionHipRun:String="correctionHipRun";

        public static const col_correctionHipWalk:String="correctionHipWalk";

        public static const col_dataType:String="dataType";

        public static const col_dateCode:String="dateCode";

        public static const col_dayActivity:String="dayActivity";

        public static const col_description:String="description";

        public static const col_distance:String="distance";

        public static const col_distanceDownhill:String="distanceDownhill";

        public static const col_distanceMinus:String="distanceMinus";

        public static const col_distancePlus:String="distancePlus";

        public static const col_distancePlusMinusStatus:String="distancePlusMinusStatus";

        public static const col_distanceUphill:String="distanceUphill";

        public static const col_exerciseTime:String="exerciseTime";

        public static const col_externalLink:String="externalLink";

        public static const col_feeling:String="feeling";

        public static const col_fuelEconomy:String="fuelEconomy";

        public static const col_gender:String="gender";

        public static const col_hrMax:String="hrMax";

        public static const col_intensityZone1Start:String="intensityZone1Start";

        public static const col_intensityZone2Start:String="intensityZone2Start";

        public static const col_intensityZone3Start:String="intensityZone3Start";

        public static const col_intensityZone4End:String="intensityZone4End";

        public static const col_intensityZone4Start:String="intensityZone4Start";

        public static const col_isDeleted:String="isDeleted";

        public static const col_latitudeEnd:String="latitudeEnd";

        public static const col_latitudeStart:String="latitudeStart";

        public static const col_linkedRouteId:String="linkedRouteId";

        public static const col_linkedTrackGUID:String="linkedTrackGUID";

        public static const col_logType:String="logType";

        public static const col_logVersion:String="logVersion";

        public static const col_longitudeEnd:String="longitudeEnd";

        public static const col_longitudeStart:String="longitudeStart";

        public static const col_lowerLimit:String="lowerLimit";

        public static const col_manualTemperature:String="manualTemperature";

        public static const col_maximumAltitude:String="maximumAltitude";

        public static const col_maximumCadence:String="maximumCadence";

        public static const col_maximumExpansion:String="maximumExpansion";

        public static const col_maximumExpansionDownhill:String="maximumExpansionDownhill";

        public static const col_maximumExpansionUphill:String="maximumExpansionUphill";

        public static const col_maximumHeartrate:String="maximumHeartrate";

        public static const col_maximumIncline:String="maximumIncline";

        public static const col_maximumInclineDownhill:String="maximumInclineDownhill";

        public static const col_maximumInclineUphill:String="maximumInclineUphill";

        public static const col_maximumPercentHRMax:String="maximumPercentHRMax";

        public static const col_maximumPower:String="maximumPower";

        public static const col_maximumRiseRate:String="maximumRiseRate";

        public static const col_maximumRiseRateDownhill:String="maximumRiseRateDownhill";

        public static const col_maximumRiseRateUphill:String="maximumRiseRateUphill";

        public static const col_maximumSpeed:String="maximumSpeed";

        public static const col_maximumTemperature:String="maximumTemperature";

        public static const col_measurement:String="measurement";

        public static const col_minimumAltitude:String="minimumAltitude";

        public static const col_minimumCadence:String="minimumCadence";

        public static const col_minimumHeartrate:String="minimumHeartrate";

        public static const col_minimumIncline:String="minimumIncline";

        public static const col_minimumInclineDownhill:String="minimumInclineDownhill";

        public static const col_minimumInclineUphill:String="minimumInclineUphill";

        public static const col_minimumPercentHRMax:String="minimumPercentHRMax";

        public static const col_minimumPower:String="minimumPower";

        public static const col_minimumRiseRate:String="minimumRiseRate";

        public static const col_minimumRiseRateDownhill:String="minimumRiseRateDownhill";

        public static const col_minimumRiseRateUphill:String="minimumRiseRateUphill";

        public static const col_minimumSpeed:String="minimumSpeed";

        public static const col_minimumTemperature:String="minimumTemperature";

        public static const col_modificationDate:String="modificationDate";

        public static const col_name:String="name";

        public static const col_pauseTime:String="pauseTime";

        public static const col_pedalSmoothLeft:String="pedalSmoothLeft";

        public static const col_pedalSmoothRight:String="pedalSmoothRight";

        public static const col_pedalingIndex:String="pedalingIndex";

        public static const col_pedalingTime:String="pedalingTime";

        public static const col_percentTimeInIntensityZone1:String="percentTimeInIntensityZone1";

        public static const col_percentTimeInIntensityZone2:String="percentTimeInIntensityZone2";

        public static const col_percentTimeInIntensityZone3:String="percentTimeInIntensityZone3";

        public static const col_percentTimeInIntensityZone4:String="percentTimeInIntensityZone4";

        public static const col_powerFTP:String="powerFTP";

        public static const col_powerIF:String="powerIF";

        public static const col_powerNP:String="powerNP";

        public static const col_powerTSS:String="powerTSS";

        public static const col_powerZone1Start:String="powerZone1Start";

        public static const col_powerZone2Start:String="powerZone2Start";

        public static const col_powerZone3Start:String="powerZone3Start";

        public static const col_powerZone4Start:String="powerZone4Start";

        public static const col_powerZone5Start:String="powerZone5Start";

        public static const col_powerZone6Start:String="powerZone6Start";

        public static const col_powerZone7End:String="powerZone7End";

        public static const col_powerZone7Start:String="powerZone7Start";

        public static const col_rating:String="rating";

        public static const col_rxBatteryStatus:String="rxBatteryStatus";

        public static const col_samplingRate:String="samplingRate";

        public static const col_serialNumber:String="serialNumber";

        public static const col_sharingInformations:String="sharingInformations";

        public static const col_shoulderWidth:String="shoulderWidth";

        public static const col_shoulderWidthUnit:String="shoulderWidthUnit";

        public static const col_simpleHeaderValuesCalculation:String="simpleHeaderValuesCalculation";

        public static const col_sportId:String="sportId";

        public static const col_startDate:String="startDate";

        public static const col_statistic:String="statistic";

        public static const col_steps:String="steps";

        public static const col_targetDay:String="targetDay";

        public static const col_thresholdPower:String="thresholdPower";

        public static const col_timeDeepSleep:String="stepsHigh";

        public static const col_timeInIntensityZone1:String="timeInIntensityZone1";

        public static const col_timeInIntensityZone2:String="timeInIntensityZone2";

        public static const col_timeInIntensityZone3:String="timeInIntensityZone3";

        public static const col_timeInIntensityZone4:String="timeInIntensityZone4";

        public static const col_timeInPowerZone1:String="timeInPowerZone1";

        public static const col_timeInPowerZone2:String="timeInPowerZone2";

        public static const col_timeInPowerZone3:String="timeInPowerZone3";

        public static const col_timeInPowerZone4:String="timeInPowerZone4";

        public static const col_timeInPowerZone5:String="timeInPowerZone5";

        public static const col_timeInPowerZone6:String="timeInPowerZone6";

        public static const col_timeInPowerZone7:String="timeInPowerZone7";

        public static const col_timeInZone:String="timeInZone";

        public static const col_timeInZone1:String="timeInZone1";

        public static const col_timeInZone2:String="timeInZone2";

        public static const col_timeInZone3:String="timeInZone3";

        public static const col_timeLightSleep:String="stepsMedium";

        public static const col_timeOverIntensityZone:String="timeOverIntensityZone";

        public static const col_timeOverZone:String="timeOverZone";

        public static const col_timeSleep:String="timeSleep";

        public static const col_timeUnderIntensityZone:String="timeUnderIntensityZone";

        public static const col_timeUnderZone:String="timeUnderZone";

        public static const col_timeWakeUp:String="stepsLow";

        public static const col_torqueEffectLeft:String="torqueEffectLeft";

        public static const col_torqueEffectRight:String="torqueEffectRight";

        public static const col_trackReferenceId:String="trackReferenceId";

        public static const col_trainingTime:String="trainingTime";

        public static const col_trainingTimeDownhill:String="trainingTimeDownhill";

        public static const col_trainingTimeUphill:String="trainingTimeUphill";

        public static const col_trainingType:String="trainingType";

        public static const col_trainingZone:String="trainingZone";

        public static const col_tripSectionDistance:String="tripSectionDistance";

        public static const col_tripSectionTime:String="tripSectionTime";

        public static const col_txBatteryStatus:String="txBatteryStatus";

        public static const col_unitId:String="unitId";

        public static const col_unitType:String="unitType";

        public static const col_upperLimit:String="upperLimit";

        public static const col_userId:String="userId";

        public static const col_weather:String="weather";

        public static const col_wheelSize:String="wheelSize";

        public static const col_wind:String="wind";

        public static const col_withDevice:String="withDevice";

        public static const col_workInKJ:String="workInKJ";

        public static const col_zone1Start:String="zone1Start";

        public static const col_zone2Start:String="zone2Start";

        public static const col_zone3End:String="zone3End";

        public static const col_zone3Start:String="zone3Start";

        public static const field_activeTimeHigh:String="activeTimeHigh";

        public static const field_activeTimeLow:String="activeTimeLow";

        public static const field_activeTimeMiddle:String="activeTimeMiddle";

        public static const field_steps:String="steps";

        public static const field_targetDay:String="targetDay";

        public static const field_timeDeepSleep:String="timeDeepSleep";

        public static const field_timeLightSleep:String="timeLightSleep";

        public static const col_trackProfile:String="trackProfile";

        public static const field_timeWakeUp:String="timeWakeUp";

        public static const table_name:String="Activity";

        public static const col_GUID:String="GUID";

        public static const col_activeTimeHigh:String="activTimeHigh";

        public static const col_activeTimeLow:String="activTimeLow";

        public static const col_activeTimeMiddle:String="activTimeMedium";

        public static const col_activityId:String="activityId";

        public static const col_activityStatus:String="activityStatus";

        public static const col_age:String="age";

        public static const col_altitudeDifferencesDownhill:String="altitudeDifferencesDownhill";

        public static const col_altitudeDifferencesUphill:String="altitudeDifferencesUphill";

        public static const col_averageAltitude:String="averageAltitude";

        public static const col_averageBalanceLeft:String="averageBalanceLeft";

        public static const col_averageBalanceRight:String="averageBalanceRight";

        public static const col_averageCadence:String="averageCadence";

        public static const col_averageCadenceCalc:String="averageCadenceCalc";

        public static const col_averageExpansion:String="averageExpansion";

        public static const col_averageExpansionDownhill:String="averageExpansionDownhill";

        public static const col_averageExpansionUphill:String="averageExpansionUphill";

        public static const col_averageHeartrate:String="averageHeartrate";

        public static const col_averageInclineDownhill:String="averageInclineDownhill";

        public static const col_averageInclineUphill:String="averageInclineUphill";

        public static const col_averagePercentHRMax:String="averagePercentHRMax";

        public static const col_averagePower:String="averagePower";

        public static const col_averagePowerCalc:String="averagePowerCalc";

        public static const col_averagePowerKJ:String="averagePowerKJ";

        public static const field_timeSleep:String="timeSleep";

        public static var DB_TABLE_510:database.DatabaseTable;

        public static var DB_TABLE_500:database.DatabaseTable;

        public static var DB_TABLE_400:database.DatabaseTable;

        public static var DB_TABLE_520:database.DatabaseTable;
    }
}


//  class ActivityRecalculationValues
package core.activities 
{
    import core.general.*;
    import flash.data.*;
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;
    
    public class ActivityRecalculationValues extends flash.events.EventDispatcher
    {
        public function ActivityRecalculationValues(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            var loc1:*=flash.utils.getQualifiedClassName(this);
            return;
        }

        public static function generateSelectStatement(arg1:Object):String
        {
            var loc1:*=null;
            var loc8:*=null;
            var loc2:*=null;
            var loc3:*="SELECT ";
            var loc4:*;
            (loc4 = []).push("ActivityEntry.activityId as id");
            if (arg1.unitType == core.general.UnitType.ROX100.toString() || arg1.unitType == core.general.UnitType.ROX70.toString() || arg1.unitType == core.general.UnitType.ROX110.toString()) 
            {
                loc1 = "heartrate > 0";
                loc8 = "heartrate >= 0";
            }
            else 
            {
                loc1 = loc8 = "heartrate > 0 AND heartrate != 20";
            }
            loc4.push("MIN(CASE WHEN " + loc8 + " THEN heartrate END) as minimumHeartrate");
            loc4.push("MAX(CASE WHEN " + loc8 + " THEN heartrate END) as maximumHeartrate");
            loc4.push("ROUND(AVG(CASE WHEN " + loc1 + " THEN heartrate END)) as averageHeartrate");
            loc4.push("MIN(CASE WHEN " + loc8 + " THEN percentHRMax END) as minimumPercentHRMax");
            loc4.push("MAX(CASE WHEN " + loc8 + " THEN percentHRMax END) as maximumPercentHRMax");
            loc4.push("ROUND(AVG(CASE WHEN " + loc1 + " THEN percentHRMax END)) as averagePercentHRMax");
            if (arg1.unitType != core.general.UnitType.RC1411.toString()) 
            {
                loc2 = "speed >= 0";
            }
            else 
            {
                loc2 = "speed > 0";
            }
            loc4.push("MIN(CASE WHEN " + loc2 + " THEN speed END) as minimumSpeed");
            loc4.push("MIN(CASE WHEN distanceUphill > 0 AND " + loc2 + " THEN speed ELSE 0 END) as minimumSpeedUphill");
            loc4.push("MIN(CASE WHEN distanceDownhill > 0 AND " + loc2 + " THEN speed ELSE 0 END) as minimumSpeedDownhill");
            loc4.push("MAX(CASE WHEN " + loc2 + " THEN speed END) as maximumSpeed");
            loc4.push("MAX(CASE WHEN distanceUphill > 0 AND " + loc2 + " THEN speed ELSE 0 END) as maximumSpeedUphill");
            loc4.push("MAX(CASE WHEN distanceDownhill > 0 AND " + loc2 + " THEN speed ELSE 0 END) as maximumSpeedDownhill");
            loc4.push("MIN(altitude) as minimumAltitude");
            loc4.push("MAX(altitude) as maximumAltitude");
            loc4.push("AVG(altitude) as averageAltitude");
            loc4.push("MIN(incline) as minimumIncline");
            loc4.push("MIN(CASE WHEN incline > 0 THEN incline ELSE 0 END) as minimumInclineUphill");
            loc4.push("MIN(CASE WHEN incline < 0 THEN incline ELSE 0 END) as minimumInclineDownhill");
            loc4.push("MAX(incline) as maximumIncline");
            loc4.push("MAX(CASE WHEN incline > 0 THEN incline ELSE 0 END) as maximumInclineUphill");
            loc4.push("MAX(CASE WHEN incline < 0 THEN incline ELSE 0 END) as maximumInclineDownhill");
            loc4.push("AVG(incline) as averageIncline");
            loc4.push("(TOTAL(CASE WHEN incline > 0 THEN incline END)/COUNT(CASE WHEN incline > 0 THEN 1 END)) as averageInclineUphill");
            loc4.push("(TOTAL(CASE WHEN incline < 0 THEN incline END)/COUNT(CASE WHEN incline < 0 THEN 1 END)) as averageInclineDownhill");
            loc4.push("MIN(riseRate) as minimumRiseRate");
            loc4.push("MIN(CASE WHEN riseRate > 0 THEN riseRate ELSE 0 END) as minimumRiseRateUphill");
            loc4.push("MIN(CASE WHEN riseRate < 0 THEN riseRate ELSE 0 END) as minimumRiseRateDownhill");
            loc4.push("MAX(riseRate) as maximumRiseRate");
            loc4.push("MAX(CASE WHEN riseRate > 0 THEN riseRate ELSE 0 END) as maximumRiseRateUphill");
            loc4.push("MAX(CASE WHEN riseRate < 0 THEN riseRate ELSE 0 END) as maximumRiseRateDownhill");
            loc4.push("AVG(riseRate) as averageRiseRate");
            loc4.push("AVG(CASE WHEN riseRate > 0 THEN riseRate END) as averageRiseRateUphill");
            loc4.push("AVG(CASE WHEN riseRate < 0 THEN riseRate END) as averageRiseRateDownhill");
            var loc6:*=">= 0";
            var loc7:*=arg1.avgCadInclZero ? ">= 0" : "> 0";
            loc4.push("MIN(CASE WHEN cadence " + loc6 + " THEN cadence END) as minimumCadence");
            loc4.push("MAX(CASE WHEN cadence " + loc6 + " THEN cadence END) as maximumCadence");
            loc4.push("ROUND(AVG(CASE WHEN cadence " + loc7 + " THEN cadence END)) as averageCadence");
            var loc5:*=">= 0";
            var loc10:*=arg1.avgPowerInclZero ? ">= 0" : "> 0";
            loc4.push("MIN(CASE WHEN power " + loc5 + " THEN " + "power" + " END) as minimumPower");
            loc4.push("MAX(CASE WHEN power " + loc5 + " THEN " + "power" + " END) as maximumPower");
            loc4.push("ROUND(AVG(CASE WHEN power " + loc10 + " THEN " + "power" + " END)) as " + "averagePower");
            loc4.push("AVG(CASE WHEN normalizedPower " + loc10 + " THEN " + "normalizedPower" + " END) as " + "powerNP");
            loc4.push("AVG(CASE WHEN powerPerKG " + loc10 + " THEN powerPerKG END) as averagePowerWattPerKG");
            loc4.push("MIN(temperature) as minimumTemperature");
            loc4.push("MAX(temperature) as maximumTemperature");
            loc4.push("AVG(temperature) as averageTemperature");
            loc4.push("ROUND(TOTAL(calories)) as calories");
            loc4.push("ROUND(TOTAL(workInKJ)) as workInKJ");
            loc4.push("TOTAL(distance) as distance");
            var loc9:*="";
            if (arg1.unitType == core.general.UnitType.ROX70.toString() || arg1.unitType == core.general.UnitType.ROX110.toString()) 
            {
                loc4.push("(TOTAL(trainingTime) + (SELECT TOTAL(duration) FROM Marker WHERE Marker.activityId = " + arg1.activityId + " AND " + "Marker.timeAbsolute >= " + arg1.startTimeAbsolute + " AND " + "Marker.timeAbsolute <= " + arg1.endTimeAbsolute + ")) as exerciseTime");
                loc9 = "TOTAL(trainingTime) as trainingTime";
                loc4.push(loc9);
            }
            else if (arg1.exerciseTimeDefined) 
            {
                loc4.push("TOTAL(trainingTime) as exerciseTime");
                loc9 = "TOTAL(CASE WHEN speed > 0 THEN trainingTime ELSE 0 END) as trainingTime";
                loc4.push(loc9);
            }
            else 
            {
                loc9 = "TOTAL(trainingTime) as trainingTime";
                loc4.push(loc9);
            }
            loc4.push("TOTAL(pedalingTime) as pedalingTime");
            loc4.push("ROUND(TOTAL(pedalingTime)*100 / TOTAL(trainingTime)) as pedalingIndex");
            if (arg1.unitType == core.general.UnitType.BC2316STS.toString() || arg1.unitType == core.general.UnitType.ROX110.toString()) 
            {
                loc4.push("TOTAL(distanceUphill) as distanceUphill");
                loc4.push("TOTAL(distanceDownhill) as distanceDownhill");
            }
            else 
            {
                loc4.push("TOTAL(CASE WHEN distanceUphill > 0 THEN distance ELSE 0 END) as distanceUphill");
                loc4.push("TOTAL(CASE WHEN distanceDownhill > 0 THEN distance ELSE 0 END) as distanceDownhill");
            }
            loc4.push("TOTAL(CASE WHEN trainingTimeUphill > 0 THEN trainingTime ELSE 0 END) as trainingTimeUphill");
            loc4.push("TOTAL(CASE WHEN trainingTimeDownhill > 0 THEN trainingTime ELSE 0 END) as trainingTimeDownhill");
            loc4.push("TOTAL(altitudeDifferencesUphill) as altitudeDifferencesUphill");
            loc4.push("TOTAL(altitudeDifferencesDownhill) as altitudeDifferencesDownhill");
            if (arg1.targetZoneDefined) 
            {
                if (arg1.unitType != core.general.UnitType.BC2316STS.toString()) 
                {
                    loc4.push("TOTAL(CASE WHEN targetZone = 0 THEN trainingTime ELSE 0 END) as timeUnderZone");
                    loc4.push("TOTAL(CASE WHEN targetZone = 1 THEN trainingTime ELSE 0 END) as timeInZone");
                    loc4.push("TOTAL(CASE WHEN targetZone = 2 THEN trainingTime ELSE 0 END) as timeOverZone");
                }
                else 
                {
                    loc4.push("TOTAL(timeBelowTargetZone) as timeUnderZone");
                    loc4.push("TOTAL(timeInTargetZone) as timeInZone");
                    loc4.push("TOTAL(timeAboveTargetZone) as timeOverZone");
                }
            }
            else 
            {
                loc4.push("TOTAL(CASE WHEN zone = 0 THEN trainingTime ELSE 0 END) as timeUnderZone");
                loc4.push("TOTAL(CASE WHEN zone = 1 THEN trainingTime ELSE 0 END) as timeInZone1");
                loc4.push("TOTAL(CASE WHEN zone = 2 THEN trainingTime ELSE 0 END) as timeInZone2");
                loc4.push("TOTAL(CASE WHEN zone = 3 THEN trainingTime ELSE 0 END) as timeInZone3");
                loc4.push("TOTAL(CASE WHEN zone = 4 THEN trainingTime ELSE 0 END) as timeOverZone");
            }
            if (arg1.intensityZoneStartsDefined && !(arg1.unitType == core.general.UnitType.BC2316STS.toString()) && !(arg1.unitType == core.general.UnitType.ROX110.toString())) 
            {
                loc4.push("TOTAL(CASE WHEN heartrate <= " + arg1["intensityZone1Start"] + " THEN trainingTime ELSE 0 END) as timeUnderIntensityZone");
                loc4.push("TOTAL(CASE WHEN heartrate > " + arg1["intensityZone1Start"] + " AND heartrate <= " + arg1["intensityZone2Start"] + " THEN trainingTime ELSE 0 END) as timeInIntensityZone1");
                loc4.push("TOTAL(CASE WHEN heartrate > " + arg1["intensityZone2Start"] + " AND heartrate <= " + arg1["intensityZone3Start"] + " THEN trainingTime ELSE 0 END) as timeInIntensityZone2");
                loc4.push("TOTAL(CASE WHEN heartrate > " + arg1["intensityZone3Start"] + " AND heartrate <= " + arg1["intensityZone4Start"] + " THEN trainingTime ELSE 0 END) as timeInIntensityZone3");
                loc4.push("TOTAL(CASE WHEN heartrate > " + arg1["intensityZone4Start"] + " AND heartrate <= " + arg1["intensityZone4End"] + " THEN trainingTime ELSE 0 END) as timeInIntensityZone4");
                loc4.push("TOTAL(CASE WHEN heartrate > " + arg1["intensityZone4End"] + " THEN trainingTime ELSE 0 END) as timeOverIntensityZone");
            }
            else if (arg1.unitType == core.general.UnitType.BC2316STS.toString() || arg1.unitType == core.general.UnitType.ROX110.toString()) 
            {
                loc4.push("TOTAL(timeBelowIntensityZones) as timeUnderIntensityZone");
                loc4.push("TOTAL(timeInIntensityZone1) as timeInIntensityZone1");
                loc4.push("TOTAL(timeInIntensityZone2) as timeInIntensityZone2");
                loc4.push("TOTAL(timeInIntensityZone3) as timeInIntensityZone3");
                loc4.push("TOTAL(timeInIntensityZone4) as timeInIntensityZone4");
                loc4.push("TOTAL(timeAboveIntensityZones) as timeOverIntensityZone");
            }
            else 
            {
                loc4.push("TOTAL(CASE WHEN intensityZone = 0 THEN trainingTime ELSE 0 END) as timeUnderIntensityZone");
                loc4.push("TOTAL(CASE WHEN intensityZone = 1 THEN trainingTime ELSE 0 END) as timeInIntensityZone1");
                loc4.push("TOTAL(CASE WHEN intensityZone = 2 THEN trainingTime ELSE 0 END) as timeInIntensityZone2");
                loc4.push("TOTAL(CASE WHEN intensityZone = 3 THEN trainingTime ELSE 0 END) as timeInIntensityZone3");
                loc4.push("TOTAL(CASE WHEN intensityZone = 4 THEN trainingTime ELSE 0 END) as timeInIntensityZone4");
                loc4.push("TOTAL(CASE WHEN intensityZone = 5 THEN trainingTime ELSE 0 END) as timeOverIntensityZone");
            }
            if (arg1.unitType != core.general.UnitType.ROX110.toString()) 
            {
                loc4.push("TOTAL(CASE WHEN powerZone = 1 THEN trainingTime ELSE 0 END) as timeInPowerZone1");
                loc4.push("TOTAL(CASE WHEN powerZone = 2 THEN trainingTime ELSE 0 END) as timeInPowerZone2");
                loc4.push("TOTAL(CASE WHEN powerZone = 3 THEN trainingTime ELSE 0 END) as timeInPowerZone3");
                loc4.push("TOTAL(CASE WHEN powerZone = 4 THEN trainingTime ELSE 0 END) as timeInPowerZone4");
                loc4.push("TOTAL(CASE WHEN powerZone = 5 THEN trainingTime ELSE 0 END) as timeInPowerZone5");
                loc4.push("TOTAL(CASE WHEN powerZone = 6 THEN trainingTime ELSE 0 END) as timeInPowerZone6");
                loc4.push("TOTAL(CASE WHEN powerZone = 7 THEN trainingTime ELSE 0 END) as timeInPowerZone7");
            }
            else 
            {
                loc4.push("TOTAL(timeInPowerZone1) as timeInPowerZone1");
                loc4.push("TOTAL(timeInPowerZone2) as timeInPowerZone2");
                loc4.push("TOTAL(timeInPowerZone3) as timeInPowerZone3");
                loc4.push("TOTAL(timeInPowerZone4) as timeInPowerZone4");
                loc4.push("TOTAL(timeInPowerZone5) as timeInPowerZone5");
                loc4.push("TOTAL(timeInPowerZone6) as timeInPowerZone6");
                loc4.push("TOTAL(timeInPowerZone7) as timeInPowerZone7");
            }
            loc4.push("AVG(leftBalance) as averageBalanceLeft");
            loc4.push("AVG(rightBalance) as averageBalanceRight");
            return loc3 = (loc3 = (loc3 = (loc3 = (loc3 = loc3 + loc4.join(", ")) + " FROM ActivityEntry ") + (" WHERE ActivityEntry.activityId = " + arg1.activityId)) + (" AND ActivityEntry.activityEntryId >= " + arg1.selectedStartEntry)) + (" AND ActivityEntry.activityEntryId <= " + arg1.selectedEndEntry);
        }

        public function initialize(arg1:Number):void
        {
            minimumHeartrate = arg1;
            minimumSpeed = arg1;
            minimumSpeedUphill = arg1;
            minimumSpeedDownhill = arg1;
            minimumTemperature = arg1;
            minimumIncline = arg1;
            minimumInclineUphill = arg1;
            minimumInclineDownhill = arg1;
            minimumAltitude = arg1;
            minimumRiseRate = arg1;
            minimumRiseRateUphill = arg1;
            minimumRiseRateDownhill = arg1;
            minimumCadence = arg1;
            minimumPower = arg1;
            minimumPercentHRMax = arg1;
            maximumHeartrate = arg1;
            maximumSpeed = arg1;
            maximumSpeedUphill = arg1;
            maximumSpeedDownhill = arg1;
            maximumTemperature = arg1;
            maximumIncline = arg1;
            maximumInclineUphill = arg1;
            maximumInclineDownhill = arg1;
            maximumAltitude = arg1;
            maximumRiseRate = arg1;
            maximumRiseRateUphill = arg1;
            maximumRiseRateDownhill = arg1;
            maximumCadence = arg1;
            maximumPower = arg1;
            maximumPercentHRMax = arg1;
            averageHeartrate = arg1;
            averageSpeed = arg1;
            averageSpeedUphill = arg1;
            averageSpeedDownhill = arg1;
            averageTemperature = arg1;
            averageInclineUphill = arg1;
            averageInclineDownhill = arg1;
            averageAltitude = arg1;
            averageRiseRate = arg1;
            averageRiseRateUphill = arg1;
            averageRiseRateDownhill = arg1;
            averageCadence = arg1;
            averagePower = arg1;
            averagePercentHRMax = arg1;
            averagePowerWattPerKG = arg1;
            averageExpansion = arg1;
            averageExpansionUphill = arg1;
            calories = arg1;
            workInKJ = arg1;
            distance = arg1;
            pauseTime = arg1;
            trainingTime = arg1;
            exerciseTime = arg1;
            distanceUphill = arg1;
            distanceDownhill = arg1;
            trainingTimeUphill = arg1;
            trainingTimeDownhill = arg1;
            altitudeDifferencesUphill = arg1;
            altitudeDifferencesDownhill = arg1;
            timeUnderZone = arg1;
            timeInZone = arg1;
            timeOverZone = arg1;
            timeInZone1 = arg1;
            timeInZone2 = arg1;
            timeInZone3 = arg1;
            timeUnderIntensityZone = arg1;
            timeInIntensityZone1 = arg1;
            timeInIntensityZone2 = arg1;
            timeInIntensityZone3 = arg1;
            timeInIntensityZone4 = arg1;
            timeOverIntensityZone = arg1;
            timeInPowerZone1 = arg1;
            timeInPowerZone2 = arg1;
            timeInPowerZone3 = arg1;
            timeInPowerZone4 = arg1;
            timeInPowerZone5 = arg1;
            timeInPowerZone6 = arg1;
            timeInPowerZone7 = arg1;
            powerNP = arg1;
            pedalingTime = arg1;
            pedalingIndex = arg1;
            averageBalanceLeft = arg1;
            averageBalanceRight = arg1;
            return;
        }

        public function fromSQLResult(arg1:flash.data.SQLResult):void
        {
            var loc1:*=null;
            var loc2:*=arg1.data;
            if (loc2.length == 1) 
            {
                loc1 = loc2[0] as Object;
                activityId = loc1.id;
                minimumHeartrate = loc1.minimumHeartrate;
                minimumSpeed = loc1.minimumSpeed;
                minimumSpeedUphill = loc1.minimumSpeedUphill;
                minimumSpeedDownhill = loc1.minimumSpeedDownhill;
                minimumTemperature = loc1.minimumTemperature;
                minimumIncline = loc1.minimumIncline;
                minimumInclineUphill = loc1.minimumInclineUphill;
                minimumInclineDownhill = loc1.minimumInclineDownhill;
                minimumAltitude = loc1.minimumAltitude;
                minimumRiseRate = loc1.minimumRiseRate;
                minimumRiseRateUphill = loc1.minimumRiseRateUphill;
                minimumRiseRateDownhill = loc1.minimumRiseRateDownhill;
                minimumCadence = loc1.minimumCadence;
                minimumPower = loc1.minimumPower;
                minimumPercentHRMax = loc1.minimumPercentHRMax;
                maximumHeartrate = loc1.maximumHeartrate;
                maximumSpeed = loc1.maximumSpeed;
                maximumSpeedUphill = loc1.maximumSpeedUphill;
                maximumSpeedDownhill = loc1.maximumSpeedDownhill;
                maximumTemperature = loc1.maximumTemperature;
                maximumIncline = loc1.maximumIncline;
                maximumInclineUphill = loc1.maximumInclineUphill;
                maximumInclineDownhill = loc1.maximumInclineDownhill;
                maximumAltitude = loc1.maximumAltitude;
                maximumRiseRate = loc1.maximumRiseRate;
                maximumRiseRateUphill = loc1.maximumRiseRateUphill;
                maximumRiseRateDownhill = loc1.maximumRiseRateDownhill;
                maximumCadence = loc1.maximumCadence;
                maximumPower = loc1.maximumPower;
                maximumPercentHRMax = loc1.maximumPercentHRMax;
                averageHeartrate = loc1.averageHeartrate;
                averageSpeed = loc1.averageSpeed;
                averageSpeedUphill = loc1.averageSpeedUphill;
                averageSpeedDownhill = loc1.averageSpeedDownhill;
                averageTemperature = loc1.averageTemperature;
                averageInclineUphill = loc1.averageInclineUphill;
                averageInclineDownhill = loc1.averageInclineDownhill;
                averageAltitude = loc1.averageAltitude;
                averageRiseRate = loc1.averageRiseRate;
                averageRiseRateUphill = loc1.averageRiseRateUphill;
                averageRiseRateDownhill = loc1.averageRiseRateDownhill;
                averageCadence = loc1.averageCadence;
                averagePower = loc1.averagePower;
                averagePercentHRMax = loc1.averagePercentHRMax;
                averagePowerWattPerKG = loc1.averagePowerWattPerKG;
                averageExpansion = loc1.averageExpansion;
                averageExpansionUphill = loc1.averageExpansionUphill;
                calories = loc1.calories;
                workInKJ = loc1.workInKJ;
                distance = loc1.distance;
                pauseTime = loc1.pauseTime;
                trainingTime = loc1.trainingTime;
                exerciseTime = loc1.exerciseTime;
                distanceUphill = loc1.distanceUphill;
                distanceDownhill = loc1.distanceDownhill;
                trainingTimeUphill = loc1.trainingTimeUphill;
                trainingTimeDownhill = loc1.trainingTimeDownhill;
                altitudeDifferencesUphill = loc1.altitudeDifferencesUphill;
                altitudeDifferencesDownhill = loc1.altitudeDifferencesDownhill;
                timeUnderZone = loc1.timeUnderZone;
                timeInZone = loc1.timeInZone;
                timeInZone1 = loc1.timeInZone1;
                timeInZone2 = loc1.timeInZone2;
                timeInZone3 = loc1.timeInZone3;
                timeOverZone = loc1.timeOverZone;
                timeUnderIntensityZone = loc1.timeUnderIntensityZone;
                timeInIntensityZone1 = loc1.timeInIntensityZone1;
                timeInIntensityZone2 = loc1.timeInIntensityZone2;
                timeInIntensityZone3 = loc1.timeInIntensityZone3;
                timeInIntensityZone4 = loc1.timeInIntensityZone4;
                timeOverIntensityZone = loc1.timeOverIntensityZone;
                timeInPowerZone1 = loc1.timeInPowerZone1;
                timeInPowerZone2 = loc1.timeInPowerZone2;
                timeInPowerZone3 = loc1.timeInPowerZone3;
                timeInPowerZone4 = loc1.timeInPowerZone4;
                timeInPowerZone5 = loc1.timeInPowerZone5;
                timeInPowerZone6 = loc1.timeInPowerZone6;
                timeInPowerZone7 = loc1.timeInPowerZone7;
                powerNP = loc1["powerNP"];
                averageBalanceLeft = loc1["averageBalanceLeft"];
                averageBalanceRight = loc1["averageBalanceRight"];
                pedalingTime = loc1["pedalingTime"];
                pedalingIndex = loc1["pedalingIndex"];
            }
            return;
        }

        public static const VALUES_CHANGED:String="valuesChangedEvent";

        public var averageBalanceLeft:Number;

        public var averageBalanceRight:Number;

        public var averageCadence:Number;

        public var averageExpansion:Number;

        public var averageExpansionUphill:Number;

        public var averageHeartrate:Number;

        public var averageInclineDownhill:Number;

        public var averageInclineUphill:Number;

        public var averagePercentHRMax:Number;

        public var averagePower:Number;

        public var averagePowerWattPerKG:Number;

        public var averageRiseRate:Number;

        public var averageRiseRateDownhill:Number;

        public var averageRiseRateUphill:Number;

        public var averageSpeed:Number;

        public var averageSpeedDownhill:Number;

        public var averageSpeedUphill:Number;

        public var averageTemperature:Number;

        public var best20minPower:Number=0;

        public var best5KTime:Number=0;

        public var calories:Number;

        public var distance:Number;

        public var distanceDownhill:Number;

        public var distanceUphill:Number;

        public var exerciseTime:Number;

        public var maximumAltitude:Number;

        public var maximumCadence:Number;

        public var maximumHeartrate:Number;

        public var maximumIncline:Number;

        public var maximumInclineDownhill:Number;

        public var maximumInclineUphill:Number;

        public var maximumPercentHRMax:Number;

        public var maximumPower:Number;

        public var maximumRiseRate:Number;

        public var maximumRiseRateDownhill:Number;

        public var maximumRiseRateUphill:Number;

        public var maximumSpeed:Number;

        public var maximumSpeedDownhill:Number;

        public var maximumSpeedUphill:Number;

        public var maximumTemperature:Number;

        public var minimumAltitude:Number;

        public var minimumCadence:Number;

        public var minimumHeartrate:Number;

        public var minimumIncline:Number;

        public var minimumInclineDownhill:Number;

        public var minimumInclineUphill:Number;

        public var minimumPercentHRMax:Number;

        public var minimumPower:Number;

        public var minimumRiseRate:Number;

        public var minimumRiseRateDownhill:Number;

        public var minimumRiseRateUphill:Number;

        public var minimumSpeed:Number;

        public var minimumSpeedDownhill:Number;

        public var minimumSpeedUphill:Number;

        public var minimumTemperature:Number;

        public var pauseTime:Number;

        public var pedalSmoothLeft:Number=0;

        public var pedalSmoothRight:Number=0;

        public var pedalingIndex:Number=0;

        public var pedalingTime:Number=0;

        public var powerIF:Number=0;

        public var powerNP:Number;

        public var powerTSS:Number=0;

        public var timeInIntensityZone1:Number;

        public var timeInIntensityZone2:Number;

        public var timeInIntensityZone3:Number;

        public var timeInIntensityZone4:Number;

        public var activityId:int=0;

        public var timeInPowerZone2:Number;

        public var timeInPowerZone3:Number;

        public var timeInPowerZone4:Number;

        public var timeInPowerZone5:Number;

        public var timeInPowerZone6:Number;

        public var timeInPowerZone7:Number;

        public var timeInZone:Number;

        public var timeInZone1:Number;

        public var timeInZone2:Number;

        public var timeInZone3:Number;

        public var timeOverIntensityZone:Number;

        public var timeInPowerZone1:Number;

        public var timeUnderIntensityZone:Number;

        public var timeUnderZone:Number;

        public var torqueEffectLeft:Number=0;

        public var torqueEffectRight:Number=0;

        public var trainingTime:Number;

        public var trainingTimeDownhill:Number;

        public var trainingTimeUphill:Number;

        public var workInKJ:Number;

        public var altitudeDifferencesDownhill:Number;

        public var altitudeDifferencesUphill:Number;

        public var averageAltitude:Number;

        public var timeOverZone:Number;
    }
}


//  class ActivityShareObject
package core.activities 
{
    public class ActivityShareObject extends Object
    {
        public function ActivityShareObject(arg1:core.activities.Activity=null)
        {
            super();
            if (arg1 != null) 
            {
                fromActivity(arg1);
            }
            return;
        }

        public function fromJson(arg1:String):void
        {
            var loc1:*=JSON.parse(arg1);
            if (loc1) 
            {
                var loc4:*=0;
                var loc3:*=loc1;
                for (var loc2:* in loc3) 
                {
                    if (!(serviceAllowed(loc2) && this.hasOwnProperty(loc2))) 
                    {
                        continue;
                    }
                    this[loc2] = loc1[loc2];
                }
            }
            return;
        }

        public function toJson():String
        {
            return JSON.stringify(this);
        }

        public function isShared(arg1:String):Boolean
        {
            if (!serviceAllowed(arg1)) 
            {
                return false;
            }
            return !(this[arg1] == "0");
        }

        internal function serviceAllowed(arg1:String):Boolean
        {
            return ALLOWED_SHARING_SERVICES.indexOf(arg1) >= 0;
        }

        public function isAnyShared():Boolean
        {
            var loc1:*=0;
            while (loc1 < ALLOWED_SHARING_SERVICES.length) 
            {
                if (isShared(ALLOWED_SHARING_SERVICES[loc1])) 
                {
                    return true;
                }
                ++loc1;
            }
            return false;
        }

        public function saveToActivity(arg1:core.activities.Activity):void
        {
            arg1.sharedToFacebookId = facebookId;
            arg1.sharedToFacebook = !(facebookId == "0");
            arg1.sharedToStravaId = stravaId;
            arg1.sharedToStrava = !(stravaId == "0");
            arg1.sharedToTrainingPeaksId = trainingPeaksId;
            arg1.sharedToTrainingPeaks = !(trainingPeaksId == "0");
            arg1.sharedToTwitterId = twitterId;
            arg1.sharedToTwitter = !(twitterId == "0");
            arg1.sharedTo2PeakId = twoPeaksId;
            arg1.sharedTo2Peak = !(twoPeaksId == "0");
            arg1.shared = arg1.sharedToStrava || arg1.sharedToTrainingPeaks || arg1.sharedTo2Peak || arg1.sharedToFacebook || arg1.sharedToTwitter;
            return;
        }

        public function reset():void
        {
            facebookId = "0";
            stravaId = "0";
            trainingPeaksId = "0";
            twitterId = "0";
            twoPeaksId = "0";
            return;
        }

        public function fromActivity(arg1:core.activities.Activity):void
        {
            if (arg1 != null) 
            {
                facebookId = arg1.sharedToFacebookId;
                stravaId = arg1.sharedToStravaId;
                trainingPeaksId = arg1.sharedToTrainingPeaksId;
                twitterId = arg1.sharedToTwitterId;
                twoPeaksId = arg1.sharedTo2PeakId;
            }
            return;
        }

        public static const DEFAULT_SHARING_ID:String="0";

        public static const SERVICE_FACEBOOK:String="facebookId";

        public static const SERVICE_STRAVA:String="stravaId";

        public static const SERVICE_TRAININGPEAKS:String="trainingPeaksId";

        public static const SERVICE_TWITTER:String="twitterId";

        public static const SERVICE_TWOPEAKS:String="twoPeaksId";

        internal static const ALLOWED_SHARING_SERVICES:Array=["facebookId", "stravaId", "trainingPeaksId", "twitterId", "twoPeaksId"];

        public var facebookId:String="0";

        public var stravaId:String="0";

        public var trainingPeaksId:String="0";

        public var twitterId:String="0";

        public var twoPeaksId:String="0";
    }
}


//  class ActivityStatus
package core.activities 
{
    public class ActivityStatus extends Object
    {
        public function ActivityStatus()
        {
            super();
            return;
        }

        public static function hasStatus(arg1:core.activities.Activity, arg2:String):Boolean
        {
            return !(arg1.activityStatus.indexOf(arg2) == -1);
        }

        public static function addStatus(arg1:core.activities.Activity, arg2:String):void
        {
            var loc1:*=null;
            if (arg1.activityStatus != "none") 
            {
                loc1 = arg1.activityStatus.split(",");
                loc1.push(arg2);
                arg1.activityStatus = loc1.join(",");
            }
            else 
            {
                arg1.activityStatus = arg2;
            }
            return;
        }

        public static function removeStatus(arg1:core.activities.Activity, arg2:String):void
        {
            var loc4:*=0;
            var loc2:*=null;
            loc2 = arg1.activityStatus.split(",");
            var loc1:*=[];
            var loc3:*=loc2.length;
            loc4 = 0;
            while (loc4 < loc3) 
            {
                if (loc2[loc4] != arg2) 
                {
                    loc1.push(arg2);
                }
                ++loc4;
            }
            arg1.activityStatus = loc1.join(",");
            return;
        }

        public static const HEADER_DATA_VALID:String="headerDataValid";

        public static const NONE:String="none";

        internal static const STATUS_DELIMITER:String=",";
    }
}


//  class TrainingPartnerHandlerCommon
package core.activities 
{
    import __AS3__.vec.*;
    import flash.events.*;
    
    public class TrainingPartnerHandlerCommon extends flash.events.EventDispatcher
    {
        public function TrainingPartnerHandlerCommon(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            return;
        }

        public function validatePersons(arg1:__AS3__.vec.Vector.<core.participant.Person>):void
        {
            return;
        }

        public static function getInstance():core.activities.TrainingPartnerHandlerCommon
        {
            return _instance;
        }

        public static function setInstance(arg1:core.activities.TrainingPartnerHandlerCommon):void
        {
            _instance = arg1;
            return;
        }

        internal static var _instance:core.activities.TrainingPartnerHandlerCommon;
    }
}


