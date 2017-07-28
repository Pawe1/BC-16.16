//package interfaces
//  class IActualAltitude
package core.settings.interfaces 
{
    public dynamic interface IActualAltitude
    {
        function get actualAltitude():int;

        function set actualAltitude(arg1:int):void;

        function get actualAltitudeMax():int;

        function get actualAltitudeMin():int;
    }
}


//  class IAge
package core.settings.interfaces 
{
    public dynamic interface IAge
    {
        function get age():int;

        function set age(arg1:int):void;

        function get ageMax():int;

        function get ageMin():int;
    }
}


//  class IAlarm
package core.settings.interfaces 
{
    public dynamic interface IAlarm
    {
        function get alarm():Date;

        function set alarm(arg1:Date):void;
    }
}


//  class IAlarmCalories
package core.settings.interfaces 
{
    public dynamic interface IAlarmCalories
    {
        function get alarmCalories():Boolean;

        function set alarmCalories(arg1:Boolean):void;

        function get alarmCaloriesBase():Number;

        function set alarmCaloriesBase(arg1:Number):void;
    }
}


//  class IAlarmDistance
package core.settings.interfaces 
{
    public dynamic interface IAlarmDistance
    {
        function get alarmDistance():Boolean;

        function set alarmDistance(arg1:Boolean):void;

        function get alarmDistanceBase():Number;

        function set alarmDistanceBase(arg1:Number):void;
    }
}


//  class IAlarmMode
package core.settings.interfaces 
{
    public dynamic interface IAlarmMode
    {
        function get alarmMode():String;

        function set alarmMode(arg1:String):void;
    }
}


//  class IAlarmTime
package core.settings.interfaces 
{
    public dynamic interface IAlarmTime
    {
        function get alarmTime():Boolean;

        function set alarmTime(arg1:Boolean):void;

        function get alarmTimeBase():Number;

        function set alarmTimeBase(arg1:Number):void;
    }
}


//  class IAltitudeReference
package core.settings.interfaces 
{
    public dynamic interface IAltitudeReference
    {
        function get altitudeReference():String;

        function set altitudeReference(arg1:String):void;
    }
}


//  class IAltitudeUnit
package core.settings.interfaces 
{
    public dynamic interface IAltitudeUnit
    {
        function get altitudeUnit():String;

        function set altitudeUnit(arg1:String):void;
    }
}


//  class IAutoLap
package core.settings.interfaces 
{
    public dynamic interface IAutoLap
    {
        function get autoLap():uint;

        function set autoLap(arg1:uint):void;

        function get autoLapBasedOn():uint;

        function set autoLapBasedOn(arg1:uint):void;
    }
}


//  class IAutoLapBasedOnCalories
package core.settings.interfaces 
{
    public dynamic interface IAutoLapBasedOnCalories
    {
        function get autoLapCalories():uint;

        function set autoLapCalories(arg1:uint):void;

        function get autoLapCaloriesMax():uint;

        function get autoLapCaloriesMin():uint;
    }
}


//  class IAutoLapBasedOnDistance
package core.settings.interfaces 
{
    public dynamic interface IAutoLapBasedOnDistance
    {
        function get autoLapDistance():uint;

        function set autoLapDistance(arg1:uint):void;

        function get autoLapDistanceMax():uint;

        function get autoLapDistanceMin():uint;
    }
}


//  class IAutoLapBasedOnTime
package core.settings.interfaces 
{
    public dynamic interface IAutoLapBasedOnTime
    {
        function get autoLapTime():uint;

        function set autoLapTime(arg1:uint):void;

        function get autoLapTimeMax():uint;

        function get autoLapTimeMin():uint;
    }
}


//  class IAutoLapFavSets
package core.settings.interfaces 
{
    import core.sportprofiles.*;
    
    public dynamic interface IAutoLapFavSets
    {
        function get auto_lap_fav_set_1():String;

        function set auto_lap_fav_set_1(arg1:String):void;

        function changeAutoLapFavSet(arg1:uint, arg2:String):void;

        function getAutoLapFavSetObject(arg1:uint):core.sportprofiles.FavFunctionList;
    }
}


//  class IAutoOffTime
package core.settings.interfaces 
{
    import core.general.*;
    
    public dynamic interface IAutoOffTime
    {
        function get autoOffTime():core.general.AutoOffTimeUnit;

        function set autoOffTime(arg1:core.general.AutoOffTimeUnit):void;
    }
}


//  class IAutoPause
package core.settings.interfaces 
{
    public dynamic interface IAutoPause
    {
        function get autoPause():Boolean;

        function set autoPause(arg1:Boolean):void;
    }
}


//  class IAutoScan
package core.settings.interfaces 
{
    public dynamic interface IAutoScan
    {
        function get scanFlagOn():Boolean;

        function set scanFlagOn(arg1:Boolean):void;
    }
}


//  class IAutoWheelsize
package core.settings.interfaces 
{
    public dynamic interface IAutoWheelsize
    {
        function get autoWheelsize():Boolean;

        function set autoWheelsize(arg1:Boolean):void;
    }
}


//  class IAutoZoomTrack
package core.settings.interfaces 
{
    public dynamic interface IAutoZoomTrack
    {
        function get autoZoomTrack():Boolean;

        function set autoZoomTrack(arg1:Boolean):void;
    }
}


//  class IAvgCadInclZero
package core.settings.interfaces 
{
    public dynamic interface IAvgCadInclZero
    {
        function get avgCadInclZero():Boolean;

        function set avgCadInclZero(arg1:Boolean):void;
    }
}


//  class IAvgPowerInclZero
package core.settings.interfaces 
{
    public dynamic interface IAvgPowerInclZero
    {
        function get avgPowerInclZero():Boolean;

        function set avgPowerInclZero(arg1:Boolean):void;
    }
}


//  class IBacklight
package core.settings.interfaces 
{
    public dynamic interface IBacklight
    {
        function get backlightActive():Boolean;

        function set backlightActive(arg1:Boolean):void;
    }
}


//  class IBacklightLevel
package core.settings.interfaces 
{
    public dynamic interface IBacklightLevel
    {
        function get backlightLevel():uint;

        function set backlightLevel(arg1:uint):void;

        function get backlightLevelMax():int;

        function get backlightLevelMin():int;
    }
}


//  class IBacklightTime
package core.settings.interfaces 
{
    public dynamic interface IBacklightTime
    {
        function get backlightTime():Number;

        function set backlightTime(arg1:Number):void;
    }
}


//  class IBacklightTimeOff
package core.settings.interfaces 
{
    public dynamic interface IBacklightTimeOff
    {
        function get backlightTimeOff():Date;

        function set backlightTimeOff(arg1:Date):void;
    }
}


//  class IBacklightTimeOn
package core.settings.interfaces 
{
    public dynamic interface IBacklightTimeOn
    {
        function get backlightTimeOn():Date;

        function set backlightTimeOn(arg1:Date):void;
    }
}


//  class IBikeType1
package core.settings.interfaces 
{
    public dynamic interface IBikeType1
    {
        function get bikeType1():String;

        function set bikeType1(arg1:String):void;
    }
}


//  class IBikeType2
package core.settings.interfaces 
{
    public dynamic interface IBikeType2
    {
        function get bikeType2():String;

        function set bikeType2(arg1:String):void;
    }
}


//  class IBikeType3
package core.settings.interfaces 
{
    public dynamic interface IBikeType3
    {
        function get bikeType3():String;

        function set bikeType3(arg1:String):void;
    }
}


//  class IBikeWeight1
package core.settings.interfaces 
{
    public dynamic interface IBikeWeight1
    {
        function get bikeWeight1():int;

        function set bikeWeight1(arg1:int):void;

        function get bikeWeight1Max():int;

        function get bikeWeight1Min():int;
    }
}


//  class IBikeWeight1Unit
package core.settings.interfaces 
{
    public dynamic interface IBikeWeight1Unit
    {
        function get bikeWeight1Unit():String;

        function set bikeWeight1Unit(arg1:String):void;
    }
}


//  class IBikeWeight2
package core.settings.interfaces 
{
    public dynamic interface IBikeWeight2
    {
        function get bikeWeight2():int;

        function set bikeWeight2(arg1:int):void;

        function get bikeWeight2Max():int;

        function get bikeWeight2Min():int;
    }
}


//  class IBikeWeight2Unit
package core.settings.interfaces 
{
    public dynamic interface IBikeWeight2Unit
    {
        function get bikeWeight2Unit():String;

        function set bikeWeight2Unit(arg1:String):void;
    }
}


//  class IBikeWeight3
package core.settings.interfaces 
{
    public dynamic interface IBikeWeight3
    {
        function get bikeWeight3():Number;

        function set bikeWeight3(arg1:Number):void;

        function get bikeWeight3Max():int;

        function get bikeWeight3Min():int;
    }
}


//  class IBirthDate
package core.settings.interfaces 
{
    public dynamic interface IBirthDate
    {
        function get birthDate():Date;

        function set birthDate(arg1:Date):void;

        function get birthDateMax():Number;

        function get birthDateMin():Number;
    }
}


//  class IBodyHeight
package core.settings.interfaces 
{
    public dynamic interface IBodyHeight
    {
        function get bodyHeight():Number;

        function set bodyHeight(arg1:Number):void;

        function get bodyHeightMax():Number;

        function get bodyHeightMin():Number;
    }
}


//  class IBodyHeightUnit
package core.settings.interfaces 
{
    public dynamic interface IBodyHeightUnit
    {
        function get bodyHeightUnit():String;

        function set bodyHeightUnit(arg1:String):void;
    }
}


//  class IBodyWeight
package core.settings.interfaces 
{
    public dynamic interface IBodyWeight
    {
        function get bodyWeight():int;

        function set bodyWeight(arg1:int):void;

        function get bodyWeightMax():int;

        function get bodyWeightMin():int;
    }
}


//  class IBodyWeightUnit
package core.settings.interfaces 
{
    public dynamic interface IBodyWeightUnit
    {
        function get bodyWeightUnit():String;

        function set bodyWeightUnit(arg1:String):void;
    }
}


//  class IButtonInfo
package core.settings.interfaces 
{
    public dynamic interface IButtonInfo
    {
        function get buttonInfo():Boolean;

        function set buttonInfo(arg1:Boolean):void;
    }
}


//  class IButtonTone
package core.settings.interfaces 
{
    public dynamic interface IButtonTone
    {
        function get buttonTone():Boolean;

        function set buttonTone(arg1:Boolean):void;
    }
}


//  class ICadenceSensor
package core.settings.interfaces 
{
    public dynamic interface ICadenceSensor
    {
        function get cadenceSensorActive():Boolean;

        function set cadenceSensorActive(arg1:Boolean):void;
    }
}


//  class ICalibration
package core.settings.interfaces 
{
    public dynamic interface ICalibration
    {
        function get calibration():Boolean;

        function set calibration(arg1:Boolean):void;
    }
}


//  class IClock
package core.settings.interfaces 
{
    public dynamic interface IClock
    {
        function get clock():Date;

        function set clock(arg1:Date):void;
    }
}


//  class IClockMode
package core.settings.interfaces 
{
    public dynamic interface IClockMode
    {
        function get clockMode():String;

        function set clockMode(arg1:String):void;
    }
}


//  class IContrast
package core.settings.interfaces 
{
    public dynamic interface IContrast
    {
        function get contrast():int;

        function set contrast(arg1:int):void;

        function get contrastMax():int;

        function get contrastMin():int;
    }
}


//  class ICorrectionFactor
package core.settings.interfaces 
{
    public dynamic interface ICorrectionFactor
    {
        function get correctionFactor():int;

        function set correctionFactor(arg1:int):void;

        function get correctionFactorMax():int;

        function get correctionFactorMin():int;
    }
}


//  class ICountdown
package core.settings.interfaces 
{
    public dynamic interface ICountdown
    {
        function get countdown():Number;

        function set countdown(arg1:Number):void;

        function get countdownMax():Number;

        function get countdownMin():Number;

        function get countdownOn():Boolean;

        function set countdownOn(arg1:Boolean):void;
    }
}


//  class IDate
package core.settings.interfaces 
{
    public dynamic interface IDate
    {
        function get date():Date;

        function set date(arg1:Date):void;
    }
}


//  class IDateFormat
package core.settings.interfaces 
{
    public dynamic interface IDateFormat
    {
        function get dateFormat():String;

        function set dateFormat(arg1:String):void;
    }
}


//  class IDistanceUnit
package core.settings.interfaces 
{
    public dynamic interface IDistanceUnit
    {
        function get distanceUnit():String;

        function set distanceUnit(arg1:String):void;
    }
}


//  class IETAArivalFlag
package core.settings.interfaces 
{
    public dynamic interface IETAArivalFlag
    {
        function get etaArivalFlag():Boolean;

        function set etaArivalFlag(arg1:Boolean):void;
    }
}


//  class IETADistance
package core.settings.interfaces 
{
    public dynamic interface IETADistance
    {
        function get etaDistance():Number;

        function set etaDistance(arg1:Number):void;

        function get etaDistanceMax():Number;

        function get etaDistanceMin():Number;
    }
}


//  class IFavSets
package core.settings.interfaces 
{
    import core.sportprofiles.*;
    
    public dynamic interface IFavSets
    {
        function get favSetMaxCount():uint;

        function set favSetMaxCount(arg1:uint):void;

        function get fav_set_1():String;

        function set fav_set_1(arg1:String):void;

        function get fav_set_10():String;

        function set fav_set_10(arg1:String):void;

        function get fav_set_2():String;

        function set fav_set_2(arg1:String):void;

        function get fav_set_3():String;

        function set fav_set_3(arg1:String):void;

        function get fav_set_4():String;

        function set fav_set_4(arg1:String):void;

        function get fav_set_5():String;

        function set fav_set_5(arg1:String):void;

        function get fav_set_6():String;

        function set fav_set_6(arg1:String):void;

        function get fav_set_7():String;

        function set fav_set_7(arg1:String):void;

        function get fav_set_8():String;

        function set fav_set_8(arg1:String):void;

        function get fav_set_9():String;

        function set fav_set_9(arg1:String):void;

        function changeFavFunctionList(arg1:uint, arg2:core.sportprofiles.FavFunctionList):void;

        function getFavSetObject(arg1:uint):core.sportprofiles.FavFunctionList;
    }
}


//  class IFavoriteTrip1
package core.settings.interfaces 
{
    import __AS3__.vec.*;
    
    public dynamic interface IFavoriteTrip1
    {
        function get favoritesTrip1():__AS3__.vec.Vector.<String>;

        function set favoritesTrip1(arg1:__AS3__.vec.Vector.<String>):void;

        function get favoritesTrip1Size():int;
    }
}


//  class IFavoriteTrip2
package core.settings.interfaces 
{
    import __AS3__.vec.*;
    
    public dynamic interface IFavoriteTrip2
    {
        function get favoritesTrip2():__AS3__.vec.Vector.<String>;

        function set favoritesTrip2(arg1:__AS3__.vec.Vector.<String>):void;

        function get favoritesTrip2Size():int;
    }
}


//  class IFavoritesAltitude
package core.settings.interfaces 
{
    import __AS3__.vec.*;
    
    public dynamic interface IFavoritesAltitude
    {
        function get favoritesAltitude():__AS3__.vec.Vector.<__AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>>;

        function set favoritesAltitude(arg1:__AS3__.vec.Vector.<__AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>>):void;
    }
}


//  class IFavoritesCustom
package core.settings.interfaces 
{
    import __AS3__.vec.*;
    
    public dynamic interface IFavoritesCustom
    {
        function get favoritesCustom():__AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>;

        function set favoritesCustom(arg1:__AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>):void;

        function get favoritesCustomPageCount():__AS3__.vec.Vector.<int>;

        function set favoritesCustomPageCount(arg1:__AS3__.vec.Vector.<int>):void;
    }
}


//  class IFavoritesLap
package core.settings.interfaces 
{
    import __AS3__.vec.*;
    
    public dynamic interface IFavoritesLap
    {
        function get favoritesLap():__AS3__.vec.Vector.<__AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>>;

        function set favoritesLap(arg1:__AS3__.vec.Vector.<__AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>>):void;
    }
}


//  class IFavoritesTrack
package core.settings.interfaces 
{
    import __AS3__.vec.*;
    
    public dynamic interface IFavoritesTrack
    {
        function get favoritesTrack():__AS3__.vec.Vector.<__AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>>;

        function set favoritesTrack(arg1:__AS3__.vec.Vector.<__AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>>):void;
    }
}


//  class IFuelConsumption
package core.settings.interfaces 
{
    public dynamic interface IFuelConsumption
    {
        function get fuelConsumption():Number;

        function set fuelConsumption(arg1:Number):void;

        function get fuelConsumptionMax():Number;

        function get fuelConsumptionMin():Number;
    }
}


//  class IFuelConsumptionUnit
package core.settings.interfaces 
{
    public dynamic interface IFuelConsumptionUnit
    {
        function get fuelConsumptionUnit():String;

        function set fuelConsumptionUnit(arg1:String):void;
    }
}


//  class IGPSFormat
package core.settings.interfaces 
{
    public dynamic interface IGPSFormat
    {
        function get gpsFormat():String;

        function set gpsFormat(arg1:String):void;
    }
}


//  class IGPSStatus
package core.settings.interfaces 
{
    public dynamic interface IGPSStatus
    {
        function get gpsStatus():Boolean;

        function set gpsStatus(arg1:Boolean):void;
    }
}


//  class IGender
package core.settings.interfaces 
{
    public dynamic interface IGender
    {
        function get gender():String;

        function set gender(arg1:String):void;
    }
}


//  class IGhostFunction
package core.settings.interfaces 
{
    public dynamic interface IGhostFunction
    {
        function get ghostFunctionEnabled():Boolean;

        function set ghostFunctionEnabled(arg1:Boolean):void;
    }
}


//  class IHRMaxOption
package core.settings.interfaces 
{
    public dynamic interface IHRMaxOption
    {
        function get hrMaxOption():String;

        function set hrMaxOption(arg1:String):void;
    }
}


//  class IHRmax
package core.settings.interfaces 
{
    public dynamic interface IHRmax
    {
        function get hrMax():int;

        function set hrMax(arg1:int):void;

        function get hrMaxMax():int;

        function get hrMaxMin():int;
    }
}


//  class IHeartrateLimits
package core.settings.interfaces 
{
    public dynamic interface IHeartrateLimits
    {
        function get lowerLimit():int;

        function set lowerLimit(arg1:int):void;

        function get lowerLimitMax():int;

        function get lowerLimitMin():int;

        function get upperLimit():int;

        function set upperLimit(arg1:int):void;

        function get upperLimitMax():int;

        function get upperLimitMin():int;
    }
}


//  class IHeartrateSensor
package core.settings.interfaces 
{
    public dynamic interface IHeartrateSensor
    {
        function get heartrateSensorActive():Boolean;

        function set heartrateSensorActive(arg1:Boolean):void;
    }
}


//  class IHomeAltitude1
package core.settings.interfaces 
{
    public dynamic interface IHomeAltitude1
    {
        function get homeAltitude1():int;

        function set homeAltitude1(arg1:int):void;

        function get homeAltitude1Max():int;

        function get homeAltitude1Min():int;
    }
}


//  class IHomeAltitude2
package core.settings.interfaces 
{
    public dynamic interface IHomeAltitude2
    {
        function get homeAltitude2():int;

        function set homeAltitude2(arg1:int):void;

        function get homeAltitude2Max():int;

        function get homeAltitude2Min():int;
    }
}


//  class IHomeAltitude3
package core.settings.interfaces 
{
    public dynamic interface IHomeAltitude3
    {
        function get homeAltitude3():int;

        function set homeAltitude3(arg1:int):void;

        function get homeAltitude3Max():int;

        function get homeAltitude3Min():int;
    }
}


//  class IKeyLock
package core.settings.interfaces 
{
    public dynamic interface IKeyLock
    {
        function get keyLock():Boolean;

        function set keyLock(arg1:Boolean):void;
    }
}


//  class ILanguage
package core.settings.interfaces 
{
    public dynamic interface ILanguage
    {
        function get language():String;

        function set language(arg1:String):void;
    }
}


//  class ILapFavSets
package core.settings.interfaces 
{
    import core.sportprofiles.*;
    
    public dynamic interface ILapFavSets
    {
        function get lap_fav_set_1():String;

        function set lap_fav_set_1(arg1:String):void;

        function changeLapFavSet(arg1:uint, arg2:String):void;

        function getLapFavSetObject(arg1:uint):core.sportprofiles.FavFunctionList;
    }
}


//  class ILowBatDetectLevel
package core.settings.interfaces 
{
    public dynamic interface ILowBatDetectLevel
    {
        function get lowBatDetectLevel():String;

        function set lowBatDetectLevel(arg1:String):void;
    }
}


//  class IMyName
package core.settings.interfaces 
{
    public dynamic interface IMyName
    {
        function get myName():String;

        function set myName(arg1:String):void;

        function get myNameMaxLength():uint;
    }
}


//  class INfc
package core.settings.interfaces 
{
    public dynamic interface INfc
    {
        function get nfcActive():Boolean;

        function set nfcActive(arg1:Boolean):void;
    }
}


//  class IOffTrackAlarm
package core.settings.interfaces 
{
    public dynamic interface IOffTrackAlarm
    {
        function get offTrackAlarm():Number;

        function set offTrackAlarm(arg1:Number):void;
    }
}


//  class IPhaseAlarm
package core.settings.interfaces 
{
    public dynamic interface IPhaseAlarm
    {
        function get phaseAlarm():Boolean;

        function set phaseAlarm(arg1:Boolean):void;
    }
}


//  class IPowerFTP
package core.settings.interfaces 
{
    public dynamic interface IPowerFTP
    {
        function get powerFTP():Number;

        function set powerFTP(arg1:Number):void;

        function get powerFTPMax():Number;

        function get powerFTPMin():Number;
    }
}


//  class IPowerIntensityZone
package core.settings.interfaces 
{
    public dynamic interface IPowerIntensityZone
    {
        function get powerIntensityZone1Start():int;

        function set powerIntensityZone1Start(arg1:int):void;

        function get powerIntensityZone2Start():int;

        function set powerIntensityZone2Start(arg1:int):void;

        function get powerIntensityZone3Start():int;

        function set powerIntensityZone3Start(arg1:int):void;

        function get powerIntensityZone4Start():int;

        function set powerIntensityZone4Start(arg1:int):void;

        function get powerIntensityZone5Start():int;

        function set powerIntensityZone5Start(arg1:int):void;

        function get powerIntensityZone6Start():int;

        function set powerIntensityZone6Start(arg1:int):void;

        function get powerIntensityZone7End():int;

        function set powerIntensityZone7End(arg1:int):void;

        function get powerIntensityZone7Start():int;

        function set powerIntensityZone7Start(arg1:int):void;
    }
}


//  class IPowerMeterFormula
package core.settings.interfaces 
{
    public dynamic interface IPowerMeterFormula
    {
        function get powerMeterFormula():int;

        function set powerMeterFormula(arg1:int):void;
    }
}


//  class IPowerSaveMode
package core.settings.interfaces 
{
    public dynamic interface IPowerSaveMode
    {
        function get powerSaveModeActive():Boolean;

        function set powerSaveModeActive(arg1:Boolean):void;
    }
}


//  class IPowerTargetZone
package core.settings.interfaces 
{
    public dynamic interface IPowerTargetZone
    {
        function get powerTargetZoneEnabled():Boolean;

        function set powerTargetZoneEnabled(arg1:Boolean):void;

        function get powerTargetZoneLowerLimit():int;

        function set powerTargetZoneLowerLimit(arg1:int):void;

        function get powerTargetZoneLowerLimitMax():int;

        function get powerTargetZoneLowerLimitMin():int;

        function get powerTargetZoneUpperLimit():int;

        function set powerTargetZoneUpperLimit(arg1:int):void;

        function get powerTargetZoneUpperLimitMax():int;

        function get powerTargetZoneUpperLimitMin():int;
    }
}


//  class ISamplingRate
package core.settings.interfaces 
{
    public dynamic interface ISamplingRate
    {
        function get samplingRate():Number;

        function set samplingRate(arg1:Number):void;
    }
}


//  class ISeaLevel
package core.settings.interfaces 
{
    public dynamic interface ISeaLevel
    {
        function get seaLevel():Number;

        function set seaLevel(arg1:Number):void;

        function get seaLevelMax():Number;

        function get seaLevelMin():Number;
    }
}


//  class IService
package core.settings.interfaces 
{
    public dynamic interface IService
    {
        function get serviceInterval():int;

        function set serviceInterval(arg1:int):void;

        function get serviceStatusOn():Boolean;

        function set serviceStatusOn(arg1:Boolean):void;
    }
}


//  class IShoulderWidth
package core.settings.interfaces 
{
    public dynamic interface IShoulderWidth
    {
        function get shoulderWidth():Number;

        function set shoulderWidth(arg1:Number):void;

        function get shoulderWidthMax():Number;

        function get shoulderWidthMin():Number;
    }
}


//  class IShoulderWidthUnit
package core.settings.interfaces 
{
    public dynamic interface IShoulderWidthUnit
    {
        function get shoulderWidthUnit():String;

        function set shoulderWidthUnit(arg1:String):void;
    }
}


//  class IShowTotals
package core.settings.interfaces 
{
    public dynamic interface IShowTotals
    {
        function get showTotals():int;

        function set showTotals(arg1:int):void;
    }
}


//  class ISpeedUnit
package core.settings.interfaces 
{
    public dynamic interface ISpeedUnit
    {
        function get speedUnit():String;

        function set speedUnit(arg1:String):void;
    }
}


//  class IStravaSegmentsEnabled
package core.settings.interfaces 
{
    public dynamic interface IStravaSegmentsEnabled
    {
        function get stravaSegmentsEnabled():Boolean;

        function set stravaSegmentsEnabled(arg1:Boolean):void;
    }
}


//  class ISummerTime
package core.settings.interfaces 
{
    public dynamic interface ISummerTime
    {
        function get summerTime():Boolean;

        function set summerTime(arg1:Boolean):void;
    }
}


//  class ISystemTone
package core.settings.interfaces 
{
    public dynamic interface ISystemTone
    {
        function get systemTone():Boolean;

        function set systemTone(arg1:Boolean):void;
    }
}


//  class ITemperatureUnit
package core.settings.interfaces 
{
    public dynamic interface ITemperatureUnit
    {
        function get temperatureUnit():String;

        function set temperatureUnit(arg1:String):void;
    }
}


//  class IThreeZones
package core.settings.interfaces 
{
    public dynamic interface IThreeZones
    {
        function get endZone3():int;

        function set endZone3(arg1:int):void;

        function get startZone1():int;

        function set startZone1(arg1:int):void;

        function get startZone2():int;

        function set startZone2(arg1:int):void;

        function get startZone3():int;

        function set startZone3(arg1:int):void;
    }
}


//  class ITimeZone
package core.settings.interfaces 
{
    public dynamic interface ITimeZone
    {
        function get timeZone():int;

        function set timeZone(arg1:int):void;
    }
}


//  class ITireSize1
package core.settings.interfaces 
{
    import core.general.*;
    
    public dynamic interface ITireSize1
    {
        function get tireSize1():core.general.TireSize;

        function set tireSize1(arg1:core.general.TireSize):void;
    }
}


//  class ITireSize2
package core.settings.interfaces 
{
    import core.general.*;
    
    public dynamic interface ITireSize2
    {
        function get tireSize2():core.general.TireSize;

        function set tireSize2(arg1:core.general.TireSize):void;
    }
}


//  class ITrackDirection
package core.settings.interfaces 
{
    public dynamic interface ITrackDirection
    {
        function get trackDirection():String;

        function set trackDirection(arg1:String):void;
    }
}


//  class ITrainingFree
package core.settings.interfaces 
{
    public dynamic interface ITrainingFree
    {
        function get freeOwnZone1LowerLimit():int;

        function set freeOwnZone1LowerLimit(arg1:int):void;

        function get freeOwnZone1LowerLimitDefault():int;

        function get freeOwnZone1LowerLimitMin():int;

        function get freeOwnZone1UpperLimit():int;

        function set freeOwnZone1UpperLimit(arg1:int):void;

        function get freeOwnZone1UpperLimitDefault():int;

        function get freeOwnZone1UpperLimitMax():int;

        function get freeOwnZone2LowerLimit():int;

        function set freeOwnZone2LowerLimit(arg1:int):void;

        function get freeOwnZone2LowerLimitDefault():int;

        function get freeOwnZone2LowerLimitMin():int;

        function get freeOwnZone2UpperLimit():int;

        function set freeOwnZone2UpperLimit(arg1:int):void;

        function get freeOwnZone2UpperLimitDefault():int;

        function get freeOwnZone2UpperLimitMax():int;

        function get freeOwnZone3LowerLimit():int;

        function set freeOwnZone3LowerLimit(arg1:int):void;

        function get freeOwnZone3LowerLimitDefault():int;

        function get freeOwnZone3LowerLimitMin():int;

        function get freeOwnZone3UpperLimit():int;

        function set freeOwnZone3UpperLimit(arg1:int):void;

        function get freeOwnZone3UpperLimitDefault():int;

        function get freeOwnZone3UpperLimitMax():int;

        function get freeTrainingTargetZone():String;

        function set freeTrainingTargetZone(arg1:String):void;
    }
}


//  class ITrainingInterval
package core.settings.interfaces 
{
    import core.training.type.*;
    
    public dynamic interface ITrainingInterval
    {
        function get intervalRecoveryHR():int;

        function set intervalRecoveryHR(arg1:int):void;

        function get intervalRecoveryMode():core.training.type.PhaseControl;

        function set intervalRecoveryMode(arg1:core.training.type.PhaseControl):void;

        function get intervalRecoveryTime():int;

        function set intervalRecoveryTime(arg1:int):void;

        function get intervalTargetZoneLowerLimit():int;

        function set intervalTargetZoneLowerLimit(arg1:int):void;

        function get intervalTargetZoneUpperLimit():int;

        function set intervalTargetZoneUpperLimit(arg1:int):void;

        function get intervalTime():int;

        function set intervalTime(arg1:int):void;
    }
}


//  class ITrainingIntervalCoolDown
package core.settings.interfaces 
{
    public dynamic interface ITrainingIntervalCoolDown
    {
        function get intervalCoolDownTargetZoneLowerLimit():int;

        function set intervalCoolDownTargetZoneLowerLimit(arg1:int):void;

        function get intervalCoolDownTargetZoneUpperLimit():int;

        function set intervalCoolDownTargetZoneUpperLimit(arg1:int):void;

        function get intervalCoolDownTime():int;

        function set intervalCoolDownTime(arg1:int):void;
    }
}


//  class ITrainingIntervalWarmUp
package core.settings.interfaces 
{
    public dynamic interface ITrainingIntervalWarmUp
    {
        function get intervalWarmUpTargetZoneLowerLimit():int;

        function set intervalWarmUpTargetZoneLowerLimit(arg1:int):void;

        function get intervalWarmUpTargetZoneUpperLimit():int;

        function set intervalWarmUpTargetZoneUpperLimit(arg1:int):void;

        function get intervalWarmUpTime():int;

        function set intervalWarmUpTime(arg1:int):void;
    }
}


//  class ITrainingZone
package core.settings.interfaces 
{
    public dynamic interface ITrainingZone
    {
        function get trainingZone():String;

        function set trainingZone(arg1:String):void;
    }
}


//  class IVolume
package core.settings.interfaces 
{
    public dynamic interface IVolume
    {
        function get volume():int;

        function set volume(arg1:int):void;
    }
}


//  class IWayPointAlarm
package core.settings.interfaces 
{
    public dynamic interface IWayPointAlarm
    {
        function get waypointAlarm():Number;

        function set waypointAlarm(arg1:Number):void;
    }
}


//  class IWeightUnit
package core.settings.interfaces 
{
    public dynamic interface IWeightUnit
    {
        function get weightUnit():String;

        function set weightUnit(arg1:String):void;
    }
}


//  class IWheelSize1
package core.settings.interfaces 
{
    public dynamic interface IWheelSize1
    {
        function get wheelSize1():int;

        function set wheelSize1(arg1:int):void;

        function get wheelSize1Max():int;

        function get wheelSize1Min():int;
    }
}


//  class IWheelSize1Mode
package core.settings.interfaces 
{
    import core.general.*;
    
    public dynamic interface IWheelSize1Mode
    {
        function get wheelSize1Mode():core.general.WheelSizeSelectionMode;

        function set wheelSize1Mode(arg1:core.general.WheelSizeSelectionMode):void;
    }
}


//  class IWheelSize2
package core.settings.interfaces 
{
    public dynamic interface IWheelSize2
    {
        function get wheelSize2():int;

        function set wheelSize2(arg1:int):void;

        function get wheelSize2Max():int;

        function get wheelSize2Min():int;
    }
}


//  class IWheelSize2Mode
package core.settings.interfaces 
{
    import core.general.*;
    
    public dynamic interface IWheelSize2Mode
    {
        function get wheelSize2Mode():core.general.WheelSizeSelectionMode;

        function set wheelSize2Mode(arg1:core.general.WheelSizeSelectionMode):void;
    }
}


//  class IWheelSize3
package core.settings.interfaces 
{
    public dynamic interface IWheelSize3
    {
        function get wheelSize3():int;

        function set wheelSize3(arg1:int):void;

        function get wheelSize3Max():int;

        function get wheelSize3Min():int;
    }
}


//  class IYearOfBirth
package core.settings.interfaces 
{
    public dynamic interface IYearOfBirth
    {
        function get yearOfBirth():int;

        function set yearOfBirth(arg1:int):void;

        function get yearOfBirthMax():int;

        function get yearOfBirthMin():int;
    }
}


//  class IZoneAlarm
package core.settings.interfaces 
{
    public dynamic interface IZoneAlarm
    {
        function get zoneAlarm():Boolean;

        function set zoneAlarm(arg1:Boolean):void;
    }
}


