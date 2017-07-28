//package settings
//  package interfaces
//    class IActualAltitude
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


//    class IAge
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


//    class IAlarm
package core.settings.interfaces 
{
    public dynamic interface IAlarm
    {
        function get alarm():Date;

        function set alarm(arg1:Date):void;
    }
}


//    class IAlarmCalories
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


//    class IAlarmDistance
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


//    class IAlarmMode
package core.settings.interfaces 
{
    public dynamic interface IAlarmMode
    {
        function get alarmMode():String;

        function set alarmMode(arg1:String):void;
    }
}


//    class IAlarmTime
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


//    class IAltitudeReference
package core.settings.interfaces 
{
    public dynamic interface IAltitudeReference
    {
        function get altitudeReference():String;

        function set altitudeReference(arg1:String):void;
    }
}


//    class IAltitudeUnit
package core.settings.interfaces 
{
    public dynamic interface IAltitudeUnit
    {
        function get altitudeUnit():String;

        function set altitudeUnit(arg1:String):void;
    }
}


//    class IAutoLap
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


//    class IAutoLapBasedOnCalories
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


//    class IAutoLapBasedOnDistance
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


//    class IAutoLapBasedOnTime
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


//    class IAutoLapFavSets
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


//    class IAutoOffTime
package core.settings.interfaces 
{
    import core.general.*;
    
    public dynamic interface IAutoOffTime
    {
        function get autoOffTime():core.general.AutoOffTimeUnit;

        function set autoOffTime(arg1:core.general.AutoOffTimeUnit):void;
    }
}


//    class IAutoPause
package core.settings.interfaces 
{
    public dynamic interface IAutoPause
    {
        function get autoPause():Boolean;

        function set autoPause(arg1:Boolean):void;
    }
}


//    class IAutoScan
package core.settings.interfaces 
{
    public dynamic interface IAutoScan
    {
        function get scanFlagOn():Boolean;

        function set scanFlagOn(arg1:Boolean):void;
    }
}


//    class IAutoWheelsize
package core.settings.interfaces 
{
    public dynamic interface IAutoWheelsize
    {
        function get autoWheelsize():Boolean;

        function set autoWheelsize(arg1:Boolean):void;
    }
}


//    class IAutoZoomTrack
package core.settings.interfaces 
{
    public dynamic interface IAutoZoomTrack
    {
        function get autoZoomTrack():Boolean;

        function set autoZoomTrack(arg1:Boolean):void;
    }
}


//    class IAvgCadInclZero
package core.settings.interfaces 
{
    public dynamic interface IAvgCadInclZero
    {
        function get avgCadInclZero():Boolean;

        function set avgCadInclZero(arg1:Boolean):void;
    }
}


//    class IAvgPowerInclZero
package core.settings.interfaces 
{
    public dynamic interface IAvgPowerInclZero
    {
        function get avgPowerInclZero():Boolean;

        function set avgPowerInclZero(arg1:Boolean):void;
    }
}


//    class IBacklight
package core.settings.interfaces 
{
    public dynamic interface IBacklight
    {
        function get backlightActive():Boolean;

        function set backlightActive(arg1:Boolean):void;
    }
}


//    class IBacklightLevel
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


//    class IBacklightTime
package core.settings.interfaces 
{
    public dynamic interface IBacklightTime
    {
        function get backlightTime():Number;

        function set backlightTime(arg1:Number):void;
    }
}


//    class IBacklightTimeOff
package core.settings.interfaces 
{
    public dynamic interface IBacklightTimeOff
    {
        function get backlightTimeOff():Date;

        function set backlightTimeOff(arg1:Date):void;
    }
}


//    class IBacklightTimeOn
package core.settings.interfaces 
{
    public dynamic interface IBacklightTimeOn
    {
        function get backlightTimeOn():Date;

        function set backlightTimeOn(arg1:Date):void;
    }
}


//    class IBikeType1
package core.settings.interfaces 
{
    public dynamic interface IBikeType1
    {
        function get bikeType1():String;

        function set bikeType1(arg1:String):void;
    }
}


//    class IBikeType2
package core.settings.interfaces 
{
    public dynamic interface IBikeType2
    {
        function get bikeType2():String;

        function set bikeType2(arg1:String):void;
    }
}


//    class IBikeType3
package core.settings.interfaces 
{
    public dynamic interface IBikeType3
    {
        function get bikeType3():String;

        function set bikeType3(arg1:String):void;
    }
}


//    class IBikeWeight1
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


//    class IBikeWeight1Unit
package core.settings.interfaces 
{
    public dynamic interface IBikeWeight1Unit
    {
        function get bikeWeight1Unit():String;

        function set bikeWeight1Unit(arg1:String):void;
    }
}


//    class IBikeWeight2
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


//    class IBikeWeight2Unit
package core.settings.interfaces 
{
    public dynamic interface IBikeWeight2Unit
    {
        function get bikeWeight2Unit():String;

        function set bikeWeight2Unit(arg1:String):void;
    }
}


//    class IBikeWeight3
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


//    class IBirthDate
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


//    class IBodyHeight
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


//    class IBodyHeightUnit
package core.settings.interfaces 
{
    public dynamic interface IBodyHeightUnit
    {
        function get bodyHeightUnit():String;

        function set bodyHeightUnit(arg1:String):void;
    }
}


//    class IBodyWeight
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


//    class IBodyWeightUnit
package core.settings.interfaces 
{
    public dynamic interface IBodyWeightUnit
    {
        function get bodyWeightUnit():String;

        function set bodyWeightUnit(arg1:String):void;
    }
}


//    class IButtonInfo
package core.settings.interfaces 
{
    public dynamic interface IButtonInfo
    {
        function get buttonInfo():Boolean;

        function set buttonInfo(arg1:Boolean):void;
    }
}


//    class IButtonTone
package core.settings.interfaces 
{
    public dynamic interface IButtonTone
    {
        function get buttonTone():Boolean;

        function set buttonTone(arg1:Boolean):void;
    }
}


//    class ICadenceSensor
package core.settings.interfaces 
{
    public dynamic interface ICadenceSensor
    {
        function get cadenceSensorActive():Boolean;

        function set cadenceSensorActive(arg1:Boolean):void;
    }
}


//    class ICalibration
package core.settings.interfaces 
{
    public dynamic interface ICalibration
    {
        function get calibration():Boolean;

        function set calibration(arg1:Boolean):void;
    }
}


//    class IClock
package core.settings.interfaces 
{
    public dynamic interface IClock
    {
        function get clock():Date;

        function set clock(arg1:Date):void;
    }
}


//    class IClockMode
package core.settings.interfaces 
{
    public dynamic interface IClockMode
    {
        function get clockMode():String;

        function set clockMode(arg1:String):void;
    }
}


//    class IContrast
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


//    class ICorrectionFactor
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


//    class ICountdown
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


//    class IDate
package core.settings.interfaces 
{
    public dynamic interface IDate
    {
        function get date():Date;

        function set date(arg1:Date):void;
    }
}


//    class IDateFormat
package core.settings.interfaces 
{
    public dynamic interface IDateFormat
    {
        function get dateFormat():String;

        function set dateFormat(arg1:String):void;
    }
}


//    class IDistanceUnit
package core.settings.interfaces 
{
    public dynamic interface IDistanceUnit
    {
        function get distanceUnit():String;

        function set distanceUnit(arg1:String):void;
    }
}


//    class IETAArivalFlag
package core.settings.interfaces 
{
    public dynamic interface IETAArivalFlag
    {
        function get etaArivalFlag():Boolean;

        function set etaArivalFlag(arg1:Boolean):void;
    }
}


//    class IETADistance
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


//    class IFavSets
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


//    class IFavoriteTrip1
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


//    class IFavoriteTrip2
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


//    class IFavoritesAltitude
package core.settings.interfaces 
{
    import __AS3__.vec.*;
    
    public dynamic interface IFavoritesAltitude
    {
        function get favoritesAltitude():__AS3__.vec.Vector.<__AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>>;

        function set favoritesAltitude(arg1:__AS3__.vec.Vector.<__AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>>):void;
    }
}


//    class IFavoritesCustom
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


//    class IFavoritesLap
package core.settings.interfaces 
{
    import __AS3__.vec.*;
    
    public dynamic interface IFavoritesLap
    {
        function get favoritesLap():__AS3__.vec.Vector.<__AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>>;

        function set favoritesLap(arg1:__AS3__.vec.Vector.<__AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>>):void;
    }
}


//    class IFavoritesTrack
package core.settings.interfaces 
{
    import __AS3__.vec.*;
    
    public dynamic interface IFavoritesTrack
    {
        function get favoritesTrack():__AS3__.vec.Vector.<__AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>>;

        function set favoritesTrack(arg1:__AS3__.vec.Vector.<__AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>>):void;
    }
}


//    class IFuelConsumption
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


//    class IFuelConsumptionUnit
package core.settings.interfaces 
{
    public dynamic interface IFuelConsumptionUnit
    {
        function get fuelConsumptionUnit():String;

        function set fuelConsumptionUnit(arg1:String):void;
    }
}


//    class IGPSFormat
package core.settings.interfaces 
{
    public dynamic interface IGPSFormat
    {
        function get gpsFormat():String;

        function set gpsFormat(arg1:String):void;
    }
}


//    class IGPSStatus
package core.settings.interfaces 
{
    public dynamic interface IGPSStatus
    {
        function get gpsStatus():Boolean;

        function set gpsStatus(arg1:Boolean):void;
    }
}


//    class IGender
package core.settings.interfaces 
{
    public dynamic interface IGender
    {
        function get gender():String;

        function set gender(arg1:String):void;
    }
}


//    class IGhostFunction
package core.settings.interfaces 
{
    public dynamic interface IGhostFunction
    {
        function get ghostFunctionEnabled():Boolean;

        function set ghostFunctionEnabled(arg1:Boolean):void;
    }
}


//    class IHRMaxOption
package core.settings.interfaces 
{
    public dynamic interface IHRMaxOption
    {
        function get hrMaxOption():String;

        function set hrMaxOption(arg1:String):void;
    }
}


//    class IHRmax
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


//    class IHeartrateLimits
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


//    class IHeartrateSensor
package core.settings.interfaces 
{
    public dynamic interface IHeartrateSensor
    {
        function get heartrateSensorActive():Boolean;

        function set heartrateSensorActive(arg1:Boolean):void;
    }
}


//    class IHomeAltitude1
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


//    class IHomeAltitude2
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


//    class IHomeAltitude3
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


//    class IKeyLock
package core.settings.interfaces 
{
    public dynamic interface IKeyLock
    {
        function get keyLock():Boolean;

        function set keyLock(arg1:Boolean):void;
    }
}


//    class ILanguage
package core.settings.interfaces 
{
    public dynamic interface ILanguage
    {
        function get language():String;

        function set language(arg1:String):void;
    }
}


//    class ILapFavSets
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


//    class ILowBatDetectLevel
package core.settings.interfaces 
{
    public dynamic interface ILowBatDetectLevel
    {
        function get lowBatDetectLevel():String;

        function set lowBatDetectLevel(arg1:String):void;
    }
}


//    class IMyName
package core.settings.interfaces 
{
    public dynamic interface IMyName
    {
        function get myName():String;

        function set myName(arg1:String):void;

        function get myNameMaxLength():uint;
    }
}


//    class INfc
package core.settings.interfaces 
{
    public dynamic interface INfc
    {
        function get nfcActive():Boolean;

        function set nfcActive(arg1:Boolean):void;
    }
}


//    class IOffTrackAlarm
package core.settings.interfaces 
{
    public dynamic interface IOffTrackAlarm
    {
        function get offTrackAlarm():Number;

        function set offTrackAlarm(arg1:Number):void;
    }
}


//    class IPhaseAlarm
package core.settings.interfaces 
{
    public dynamic interface IPhaseAlarm
    {
        function get phaseAlarm():Boolean;

        function set phaseAlarm(arg1:Boolean):void;
    }
}


//    class IPowerFTP
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


//    class IPowerIntensityZone
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


//    class IPowerMeterFormula
package core.settings.interfaces 
{
    public dynamic interface IPowerMeterFormula
    {
        function get powerMeterFormula():int;

        function set powerMeterFormula(arg1:int):void;
    }
}


//    class IPowerSaveMode
package core.settings.interfaces 
{
    public dynamic interface IPowerSaveMode
    {
        function get powerSaveModeActive():Boolean;

        function set powerSaveModeActive(arg1:Boolean):void;
    }
}


//    class IPowerTargetZone
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


//    class ISamplingRate
package core.settings.interfaces 
{
    public dynamic interface ISamplingRate
    {
        function get samplingRate():Number;

        function set samplingRate(arg1:Number):void;
    }
}


//    class ISeaLevel
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


//    class IService
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


//    class IShoulderWidth
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


//    class IShoulderWidthUnit
package core.settings.interfaces 
{
    public dynamic interface IShoulderWidthUnit
    {
        function get shoulderWidthUnit():String;

        function set shoulderWidthUnit(arg1:String):void;
    }
}


//    class IShowTotals
package core.settings.interfaces 
{
    public dynamic interface IShowTotals
    {
        function get showTotals():int;

        function set showTotals(arg1:int):void;
    }
}


//    class ISpeedUnit
package core.settings.interfaces 
{
    public dynamic interface ISpeedUnit
    {
        function get speedUnit():String;

        function set speedUnit(arg1:String):void;
    }
}


//    class IStravaSegmentsEnabled
package core.settings.interfaces 
{
    public dynamic interface IStravaSegmentsEnabled
    {
        function get stravaSegmentsEnabled():Boolean;

        function set stravaSegmentsEnabled(arg1:Boolean):void;
    }
}


//    class ISummerTime
package core.settings.interfaces 
{
    public dynamic interface ISummerTime
    {
        function get summerTime():Boolean;

        function set summerTime(arg1:Boolean):void;
    }
}


//    class ISystemTone
package core.settings.interfaces 
{
    public dynamic interface ISystemTone
    {
        function get systemTone():Boolean;

        function set systemTone(arg1:Boolean):void;
    }
}


//    class ITemperatureUnit
package core.settings.interfaces 
{
    public dynamic interface ITemperatureUnit
    {
        function get temperatureUnit():String;

        function set temperatureUnit(arg1:String):void;
    }
}


//    class IThreeZones
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


//    class ITimeZone
package core.settings.interfaces 
{
    public dynamic interface ITimeZone
    {
        function get timeZone():int;

        function set timeZone(arg1:int):void;
    }
}


//    class ITireSize1
package core.settings.interfaces 
{
    import core.general.*;
    
    public dynamic interface ITireSize1
    {
        function get tireSize1():core.general.TireSize;

        function set tireSize1(arg1:core.general.TireSize):void;
    }
}


//    class ITireSize2
package core.settings.interfaces 
{
    import core.general.*;
    
    public dynamic interface ITireSize2
    {
        function get tireSize2():core.general.TireSize;

        function set tireSize2(arg1:core.general.TireSize):void;
    }
}


//    class ITrackDirection
package core.settings.interfaces 
{
    public dynamic interface ITrackDirection
    {
        function get trackDirection():String;

        function set trackDirection(arg1:String):void;
    }
}


//    class ITrainingFree
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


//    class ITrainingInterval
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


//    class ITrainingIntervalCoolDown
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


//    class ITrainingIntervalWarmUp
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


//    class ITrainingZone
package core.settings.interfaces 
{
    public dynamic interface ITrainingZone
    {
        function get trainingZone():String;

        function set trainingZone(arg1:String):void;
    }
}


//    class IVolume
package core.settings.interfaces 
{
    public dynamic interface IVolume
    {
        function get volume():int;

        function set volume(arg1:int):void;
    }
}


//    class IWayPointAlarm
package core.settings.interfaces 
{
    public dynamic interface IWayPointAlarm
    {
        function get waypointAlarm():Number;

        function set waypointAlarm(arg1:Number):void;
    }
}


//    class IWeightUnit
package core.settings.interfaces 
{
    public dynamic interface IWeightUnit
    {
        function get weightUnit():String;

        function set weightUnit(arg1:String):void;
    }
}


//    class IWheelSize1
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


//    class IWheelSize1Mode
package core.settings.interfaces 
{
    import core.general.*;
    
    public dynamic interface IWheelSize1Mode
    {
        function get wheelSize1Mode():core.general.WheelSizeSelectionMode;

        function set wheelSize1Mode(arg1:core.general.WheelSizeSelectionMode):void;
    }
}


//    class IWheelSize2
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


//    class IWheelSize2Mode
package core.settings.interfaces 
{
    import core.general.*;
    
    public dynamic interface IWheelSize2Mode
    {
        function get wheelSize2Mode():core.general.WheelSizeSelectionMode;

        function set wheelSize2Mode(arg1:core.general.WheelSizeSelectionMode):void;
    }
}


//    class IWheelSize3
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


//    class IYearOfBirth
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


//    class IZoneAlarm
package core.settings.interfaces 
{
    public dynamic interface IZoneAlarm
    {
        function get zoneAlarm():Boolean;

        function set zoneAlarm(arg1:Boolean):void;
    }
}


//  class Settings
package core.settings 
{
    import core.*;
    import core.general.*;
    import core.general.interfaces.*;
    import core.units.*;
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;
    import init.*;
    import utils.*;
    import utils.interfaces.*;
    
    public class Settings extends flash.events.EventDispatcher implements core.general.interfaces.ISynchronisable
    {
        public function Settings(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            if (!dateFormatter) 
            {
                dateFormatter = initDateTimeFormatter();
            }
            totalsSeperatedOnUnit = false;
            return;
        }

        public final function generateSSF():XML
        {
            return core.settings.SettingsMapper.generateXML(this);
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

        public function getLoggingInfo():String
        {
            var loc1:*="\t-settingsId " + settingsId.toString() + "\t-name " + name;
            if (unitGUID) 
            {
                loc1 = loc1 + ("unitGUID " + unitGUID.toString());
            }
            if (unitType) 
            {
                loc1 = loc1 + ("\t-unit " + unitType.toString());
            }
            return loc1;
        }

        public function set dateOutputString(arg1:String):void
        {
            _dateOutputString = arg1;
            return;
        }

        public final function get date():Date
        {
            return _date;
        }

        public final function set date(arg1:Date):void
        {
            if (arg1 != _date) 
            {
                _date = arg1;
                if (initFormatter) 
                {
                    dateFormatter = initDateTimeFormatter();
                }
                dateOutputString = dateFormatter.format(_date);
                dispatchEvent(new flash.events.Event("dateChange"));
            }
            return;
        }

        public final function resetPrimaryKey():void
        {
            settingsId = 0;
            return;
        }

        public function get dateOutputString():String
        {
            return _dateOutputString;
        }

        public final function setCurrentPrimaryKeys(arg1:core.settings.Settings):void
        {
            settingsId = arg1.settingsId;
            return;
        }

        public final function setPrimaryKey(arg1:int):void
        {
            if (settingsId == 0) 
            {
                settingsId = arg1;
            }
            return;
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

        public override function toString():String
        {
            return "[Settings name:" + name + ", id:" + settingsId + "]";
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

        public final function get settingsId():int
        {
            return _settingsId;
        }

        public final function get name():String
        {
            return _name;
        }

        public final function set name(arg1:String):void
        {
            if (arg1 != _name) 
            {
                _name = arg1;
                dispatchEvent(new flash.events.Event("nameChange"));
            }
            return;
        }

        public static function copy(arg1:core.settings.Settings):core.settings.Settings
        {
            var loc1:*=arg1.unit;
            arg1.unit = null;
            var loc2:*=flash.utils.getQualifiedClassName(arg1);
            flash.net.registerClassAlias(loc2, flash.utils.getDefinitionByName(loc2) as Class);
            var loc3:*=utils.BackendUtil.copy(arg1) as Settings;
            arg1.unit = loc1;
            loc3.unit = loc1;
            loc3.unitType = loc1.type;
            loc3.GUID = "";
            loc3.unitGUID = loc1.GUID;
            loc3.selected = false;
            loc3.settingsId = 0;
            return loc3;
        }

        internal static function initDateTimeFormatter():utils.interfaces.ICustomDateTimeFormatter
        {
            var loc1:*=init.BackendInitializer.getInstance().createDateTimeFormatter();
            loc1.dateStyle = "short";
            loc1.timeStyle = "none";
            loc1.setStyle("locale", core.MeasurementConfig.dateFormat != "eu" ? "en_US" : "de_DE");
            initFormatter = false;
            return loc1;
        }

        public final function set unit(arg1:core.units.Unit):void
        {
            if (_unit !== arg1) 
            {
                _unit = arg1;
                dispatchEvent(new flash.events.Event("unitChange"));
            }
            return;
        }

        public final function set settingsId(arg1:int):void
        {
            _settingsId = arg1;
            return;
        }

        public final function get unit():core.units.Unit
        {
            return _unit;
        }

        public function get unitGUID():String
        {
            return _unitGUID;
        }

        public function set unitGUID(arg1:String):void
        {
            _unitGUID = arg1;
            return;
        }

        public final function get unitType():core.general.UnitType
        {
            return _unitType;
        }

        public final function set unitType(arg1:core.general.UnitType):void
        {
            if (arg1 != _unitType) 
            {
                _unitType = arg1;
                dispatchEvent(new flash.events.Event("unitChange"));
            }
            return;
        }

        public const className:String="settings";

        internal var _GUID:String="";

        internal var _dateOutputString:String="--";

        internal var _date:Date;

        internal var _isDeleted:Boolean=false;

        internal var _modificationDate:Number=0;

        public var selected:Boolean;

        internal var _settingsId:int;

        internal var _name:String="";

        internal var _unitGUID:String="";

        internal var _unit:core.units.Unit;

        public static var dateFormatter:utils.interfaces.ICustomDateTimeFormatter;

        public static var initFormatter:Boolean=true;

        public var totalsSeperatedOnUnit:Boolean=false;

        internal var _unitType:core.general.UnitType;
    }
}


//  class SettingsBC1009
package core.settings 
{
    import core.settings.interfaces.*;
    import flash.events.*;
    
    public class SettingsBC1009 extends core.settings.SettingsTopline2009 implements core.settings.interfaces.ILanguage, core.settings.interfaces.IService, core.settings.interfaces.ILowBatDetectLevel, core.settings.interfaces.IContrast
    {
        public function SettingsBC1009()
        {
            super();
            wheelSize1 = 2155;
            speedUnit = "kmh";
            return;
        }

        public function get contrast():int
        {
            return _contrast;
        }

        public function set contrast(arg1:int):void
        {
            if (arg1 != _contrast) 
            {
                _contrast = arg1;
                dispatchEvent(new flash.events.Event("contrastChange"));
            }
            return;
        }

        public function get contrastMax():int
        {
            return 3;
        }

        public function get contrastMin():int
        {
            return 1;
        }

        public function get language():String
        {
            return _language;
        }

        public function set language(arg1:String):void
        {
            if (arg1 != _language) 
            {
                _language = arg1;
                dispatchEvent(new flash.events.Event("languageChange"));
            }
            return;
        }

        public function get lowBatDetectLevel():String
        {
            return _lowBatDetectLevel;
        }

        public function set lowBatDetectLevel(arg1:String):void
        {
            if (arg1 != _lowBatDetectLevel) 
            {
                _lowBatDetectLevel = arg1;
                dispatchEvent(new flash.events.Event("lowBatDetectLevelChange"));
            }
            return;
        }

        public function get serviceInterval():int
        {
            return _serviceInterval;
        }

        public function set serviceInterval(arg1:int):void
        {
            if (arg1 != _serviceInterval) 
            {
                _serviceInterval = arg1;
                dispatchEvent(new flash.events.Event("serviceIntervalChange"));
            }
            return;
        }

        public function get serviceStatusOn():Boolean
        {
            return _serviceStatusOn;
        }

        public function set serviceStatusOn(arg1:Boolean):void
        {
            if (arg1 != _serviceStatusOn) 
            {
                _serviceStatusOn = arg1;
                dispatchEvent(new flash.events.Event("serviceStatusOnChange"));
            }
            return;
        }

        public override function toString():String
        {
            return "[SettingsBC1009 extends SettingsTopline implements ILanguage, IService, ILowBatDetectLevel, IContrast]";
        }

        internal var _contrast:int=2;

        internal var _language:String="en";

        internal var _lowBatDetectLevel:String="N/A";

        internal var _serviceInterval:int=750;

        internal var _serviceStatusOn:Boolean=false;
    }
}


//  class SettingsBC1212
package core.settings 
{
    import core.settings.interfaces.*;
    import flash.events.*;
    
    public class SettingsBC1212 extends core.settings.SettingsTopline2012 implements core.settings.interfaces.IService, core.settings.interfaces.ILanguage, core.settings.interfaces.IContrast, core.settings.interfaces.ILowBatDetectLevel, core.settings.interfaces.IFuelConsumption
    {
        public function SettingsBC1212(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            wheelSize1 = 2155;
            speedUnit = "kmh";
            return;
        }

        public function get contrast():int
        {
            return _contrast;
        }

        public function set contrast(arg1:int):void
        {
            if (arg1 != _contrast) 
            {
                _contrast = arg1;
                dispatchEvent(new flash.events.Event("contrastChange"));
            }
            return;
        }

        public function get contrastMax():int
        {
            return 3;
        }

        public function get contrastMin():int
        {
            return 1;
        }

        public function get fuelConsumption():Number
        {
            return _fuelConsumption;
        }

        public function set fuelConsumption(arg1:Number):void
        {
            if (arg1 != _fuelConsumption) 
            {
                _fuelConsumption = arg1;
                dispatchEvent(new flash.events.Event("fuelConsumptionChange"));
            }
            return;
        }

        public function get fuelConsumptionMax():Number
        {
            if (speedUnit == "kmh") 
            {
                return 30;
            }
            return 240;
        }

        public function get fuelConsumptionMin():Number
        {
            if (speedUnit == "kmh") 
            {
                return 1;
            }
            return 10;
        }

        public function get language():String
        {
            return _language;
        }

        public function set language(arg1:String):void
        {
            if (arg1 != _language) 
            {
                _language = arg1;
                dispatchEvent(new flash.events.Event("languageChange"));
            }
            return;
        }

        public function get lowBatDetectLevel():String
        {
            return _lowBatDetectLevel;
        }

        public function set lowBatDetectLevel(arg1:String):void
        {
            if (arg1 != _lowBatDetectLevel) 
            {
                _lowBatDetectLevel = arg1;
                dispatchEvent(new flash.events.Event("lowBatDetectLevelChange"));
            }
            return;
        }

        public function get serviceInterval():int
        {
            return _serviceInterval;
        }

        public function set serviceInterval(arg1:int):void
        {
            if (arg1 != _serviceInterval) 
            {
                _serviceInterval = arg1;
                dispatchEvent(new flash.events.Event("serviceIntervalChange"));
            }
            return;
        }

        public function get serviceStatusOn():Boolean
        {
            return _serviceStatusOn;
        }

        public function set serviceStatusOn(arg1:Boolean):void
        {
            if (arg1 != _serviceStatusOn) 
            {
                _serviceStatusOn = arg1;
                dispatchEvent(new flash.events.Event("serviceStatusOnChange"));
            }
            return;
        }

        public override function toString():String
        {
            return "[SettingsBC1212 extends SettingsTopline2012]";
        }

        public static const FUEL_ECONOMY_MAX:Number=9999.99;

        public static const FUEL_ECONOMY_MIN:Number=0;

        internal var _contrast:int=2;

        internal var _fuelConsumption:Number=8.5;

        internal var _language:String="en";

        internal var _lowBatDetectLevel:String="N/A";

        internal var _serviceInterval:int=750;

        internal var _serviceStatusOn:Boolean=false;
    }
}


//  class SettingsBC1412
package core.settings 
{
    import core.settings.interfaces.*;
    import flash.events.*;
    
    public class SettingsBC1412 extends core.settings.SettingsTopline2012 implements core.settings.interfaces.IService, core.settings.interfaces.ILanguage, core.settings.interfaces.IContrast, core.settings.interfaces.IActualAltitude, core.settings.interfaces.IHomeAltitude1, core.settings.interfaces.ILowBatDetectLevel
    {
        public function SettingsBC1412(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            wheelSize1 = 2155;
            speedUnit = "kmh";
            return;
        }

        public function get actualAltitude():int
        {
            return _actualAltitude;
        }

        public function set actualAltitude(arg1:int):void
        {
            if (arg1 != _actualAltitude) 
            {
                _actualAltitude = arg1;
                dispatchEvent(new flash.events.Event("actualAltitudeChange"));
            }
            return;
        }

        public function get contrast():int
        {
            return _contrast;
        }

        public function set contrast(arg1:int):void
        {
            if (arg1 != _contrast) 
            {
                _contrast = arg1;
                dispatchEvent(new flash.events.Event("contrastChange"));
            }
            return;
        }

        public function get contrastMax():int
        {
            return 3;
        }

        public function get contrastMin():int
        {
            return 1;
        }

        public function get homeAltitude1():int
        {
            return _homeAltitude1;
        }

        public function set homeAltitude1(arg1:int):void
        {
            if (arg1 != _homeAltitude1) 
            {
                _homeAltitude1 = arg1;
                dispatchEvent(new flash.events.Event("homeAltitudeChange"));
            }
            return;
        }

        public function get language():String
        {
            return _language;
        }

        public function set language(arg1:String):void
        {
            if (arg1 != _language) 
            {
                _language = arg1;
                dispatchEvent(new flash.events.Event("languageChange"));
            }
            return;
        }

        public function get lowBatDetectLevel():String
        {
            return _lowBatDetectLevel;
        }

        public function set lowBatDetectLevel(arg1:String):void
        {
            if (arg1 != _lowBatDetectLevel) 
            {
                _lowBatDetectLevel = arg1;
                dispatchEvent(new flash.events.Event("lowBatDetectLevelChange"));
            }
            return;
        }

        public function get serviceInterval():int
        {
            return _serviceInterval;
        }

        public function set serviceInterval(arg1:int):void
        {
            if (arg1 != _serviceInterval) 
            {
                _serviceInterval = arg1;
                dispatchEvent(new flash.events.Event("serviceIntervalChange"));
            }
            return;
        }

        public function get serviceStatusOn():Boolean
        {
            return _serviceStatusOn;
        }

        public function set serviceStatusOn(arg1:Boolean):void
        {
            if (arg1 != _serviceStatusOn) 
            {
                _serviceStatusOn = arg1;
                dispatchEvent(new flash.events.Event("serviceStatusOnChange"));
            }
            return;
        }

        public override function toString():String
        {
            return "[SettingsBC1412 extends SettingsTopline2012]";
        }

        internal var _actualAltitude:int=250000;

        internal var _contrast:int=2;

        internal var _homeAltitude1:int=100000;

        internal var _language:String="en";

        internal var _lowBatDetectLevel:String="N/A";

        internal var _serviceInterval:int=750;

        internal var _serviceStatusOn:Boolean=true;
    }
}


//  class SettingsBC1416
package core.settings 
{
    import core.general.*;
    import core.settings.interfaces.*;
    import flash.events.*;
    
    public class SettingsBC1416 extends core.settings.SettingsTopline2016 implements core.settings.interfaces.IDate, core.settings.interfaces.ILanguage, core.settings.interfaces.IService, core.settings.interfaces.IWheelSize2Mode, core.settings.interfaces.ITireSize2, core.settings.interfaces.IWheelSize2, core.settings.interfaces.IAltitudeReference, core.settings.interfaces.IAltitudeUnit, core.settings.interfaces.IActualAltitude, core.settings.interfaces.ISeaLevel, core.settings.interfaces.IContrast, core.settings.interfaces.IDateFormat, core.settings.interfaces.ITemperatureUnit, core.settings.interfaces.IClockMode, core.settings.interfaces.IHomeAltitude1, core.settings.interfaces.IHomeAltitude2, core.settings.interfaces.IMyName, core.settings.interfaces.IPowerSaveMode, core.settings.interfaces.INfc
    {
        public function SettingsBC1416(arg1:flash.events.IEventDispatcher=null)
        {
            _altitudeReference = core.general.AltitudeReference.ACTUAL_ALTITUDE;
            _tireSize2 = core.general.TireSize.S_16INCH;
            _wheelSize2Mode = core.general.WheelSizeSelectionMode.TIRE;
            super(arg1);
            return;
        }

        public function set temperatureUnit(arg1:String):void
        {
            if (arg1 != _temperatureUnit) 
            {
                _temperatureUnit = arg1;
                dispatchEvent(new flash.events.Event("temperatureUnitChange"));
            }
            return;
        }

        public function get actualAltitude():int
        {
            return _actualAltitude;
        }

        public function set actualAltitude(arg1:int):void
        {
            if (arg1 != _actualAltitude) 
            {
                _actualAltitude = arg1;
                dispatchEvent(new flash.events.Event("actualAltitudeChange"));
            }
            return;
        }

        public function get actualAltitudeMax():int
        {
            if (altitudeUnit == "meter") 
            {
                return 4999000;
            }
            return 5181295;
        }

        public function get actualAltitudeMin():int
        {
            if (altitudeUnit == "meter") 
            {
                return -999000;
            }
            return -304495;
        }

        public function get tireSize2():core.general.TireSize
        {
            return _tireSize2;
        }

        public function get altitudeReference():String
        {
            return _altitudeReference;
        }

        public function set altitudeReference(arg1:String):void
        {
            if (_altitudeReference !== arg1) 
            {
                _altitudeReference = arg1;
                dispatchEvent(new flash.events.Event("altitudeReferenceChange"));
            }
            return;
        }

        public function get contrastMax():int
        {
            return 3;
        }

        public function get altitudeUnit():String
        {
            return _altitudeUnit;
        }

        public function set altitudeUnit(arg1:String):void
        {
            if (arg1 != _altitudeUnit) 
            {
                _altitudeUnit = arg1;
                dispatchEvent(new flash.events.Event("altitudeUnitChange"));
            }
            return;
        }

        public function set tireSize2(arg1:core.general.TireSize):void
        {
            _tireSize2 = arg1;
            if (arg1 && core.general.WheelSizeSelectionMode.TIRE.equals(wheelSize2Mode)) 
            {
                wheelSize2 = parseInt(arg1.data);
            }
            return;
        }

        public function get clockMode():String
        {
            return _clockMode;
        }

        public function set clockMode(arg1:String):void
        {
            if (arg1 != _clockMode) 
            {
                _clockMode = arg1;
                dispatchEvent(new flash.events.Event("clockModeChange"));
            }
            return;
        }

        public function get wheelSize2():int
        {
            return _wheelSize2;
        }

        public function get contrast():int
        {
            return _contrast;
        }

        public function set contrast(arg1:int):void
        {
            if (arg1 != _contrast) 
            {
                _contrast = arg1;
                dispatchEvent(new flash.events.Event("contrastChange"));
            }
            return;
        }

        public function set wheelSize2(arg1:int):void
        {
            if (_wheelSize2 !== arg1) 
            {
                _wheelSize2 = arg1;
                dispatchEvent(new flash.events.Event("wheelSize2Change"));
            }
            return;
        }

        public function get contrastMin():int
        {
            return 1;
        }

        public function get wheelSize2Max():int
        {
            return 3999;
        }

        public function get dateFormat():String
        {
            return _dateFormat;
        }

        public function set dateFormat(arg1:String):void
        {
            if (arg1 != _dateFormat) 
            {
                _dateFormat = arg1;
                dispatchEvent(new flash.events.Event("dateFormatChange"));
            }
            return;
        }

        public function get wheelSize2Min():int
        {
            return 500;
        }

        public function get homeAltitude1():int
        {
            return _homeAltitude1;
        }

        public function set homeAltitude1(arg1:int):void
        {
            if (arg1 != _homeAltitude1) 
            {
                _homeAltitude1 = arg1;
                dispatchEvent(new flash.events.Event("homeAltitude1Change"));
            }
            return;
        }

        public function get homeAltitude1Max():int
        {
            if (altitudeUnit == "meter") 
            {
                return 4999000;
            }
            return 3962095;
        }

        public function get homeAltitude1Min():int
        {
            if (altitudeUnit == "meter") 
            {
                return -999000;
            }
            return -304495;
        }

        public function get wheelSize2Mode():core.general.WheelSizeSelectionMode
        {
            return _wheelSize2Mode;
        }

        public function get homeAltitude2():int
        {
            return _homeAltitude2;
        }

        public function set homeAltitude2(arg1:int):void
        {
            if (arg1 != _homeAltitude2) 
            {
                _homeAltitude2 = arg1;
                dispatchEvent(new flash.events.Event("homeAltitude2Change"));
            }
            return;
        }

        public function get homeAltitude2Max():int
        {
            if (altitudeUnit == "meter") 
            {
                return 4999000;
            }
            return 3962095;
        }

        public function get homeAltitude2Min():int
        {
            if (altitudeUnit == "meter") 
            {
                return -999000;
            }
            return -304495;
        }

        public function set wheelSize2Mode(arg1:core.general.WheelSizeSelectionMode):void
        {
            _wheelSize2Mode = arg1;
            return;
        }

        public function get language():String
        {
            return _language;
        }

        public function set language(arg1:String):void
        {
            if (arg1 != _language) 
            {
                _language = arg1;
                dispatchEvent(new flash.events.Event("languageChange"));
            }
            return;
        }

        public function get powerSaveModeActive():Boolean
        {
            return _powerSaveModeActive;
        }

        public function get myName():String
        {
            return _myName;
        }

        public function set myName(arg1:String):void
        {
            if (arg1 != _myName) 
            {
                _myName = arg1;
                dispatchEvent(new flash.events.Event("myNameChange"));
            }
            return;
        }

        public function get myNameMaxLength():uint
        {
            return 9;
        }

        public function get nfcActive():Boolean
        {
            return _nfcActive;
        }

        public function set nfcActive(arg1:Boolean):void
        {
            _nfcActive = arg1;
            return;
        }

        public function set powerSaveModeActive(arg1:Boolean):void
        {
            if (arg1 != _powerSaveModeActive) 
            {
                _powerSaveModeActive = arg1;
                dispatchEvent(new flash.events.Event("powerSaveModeActiveChange"));
            }
            return;
        }

        public function get seaLevel():Number
        {
            return _seaLevel;
        }

        public function set seaLevel(arg1:Number):void
        {
            if (arg1 != _seaLevel) 
            {
                _seaLevel = arg1;
                dispatchEvent(new flash.events.Event("seaLevelChange"));
            }
            return;
        }

        public function get seaLevelMax():Number
        {
            return 1050;
        }

        public function get seaLevelMin():Number
        {
            return 950;
        }

        public function get serviceInterval():int
        {
            return _serviceInterval;
        }

        public function set serviceInterval(arg1:int):void
        {
            if (arg1 != _serviceInterval) 
            {
                _serviceInterval = arg1;
                dispatchEvent(new flash.events.Event("serviceIntervalChange"));
            }
            return;
        }

        public function get serviceStatusOn():Boolean
        {
            return _serviceStatusOn;
        }

        public function set serviceStatusOn(arg1:Boolean):void
        {
            if (arg1 != _serviceStatusOn) 
            {
                _serviceStatusOn = arg1;
                dispatchEvent(new flash.events.Event("serviceStatusOnChange"));
            }
            return;
        }

        public function get temperatureUnit():String
        {
            return _temperatureUnit;
        }

        internal const _myNameMaxLength:uint=9;

        internal var _actualAltitude:int=250000;

        internal var _altitudeReference:String;

        internal var _clockMode:String="24";

        internal var _contrast:int=2;

        internal var _altitudeUnit:String="meter";

        internal var _dateFormat:String="eu";

        internal var _homeAltitude1:int=100000;

        internal var _homeAltitude2:int=100000;

        internal var _language:String="en";

        internal var _tireSize2:core.general.TireSize;

        internal var _seaLevel:Number=1009;

        internal var _nfcActive:Boolean=true;

        internal var _wheelSize2:int=1253;

        internal var _serviceStatusOn:Boolean=false;

        internal var _powerSaveModeActive:Boolean=false;

        internal var _myName:String="BC 14.16";

        internal var _temperatureUnit:String="";

        internal var _wheelSize2Mode:core.general.WheelSizeSelectionMode;

        internal var _serviceInterval:int=750;
    }
}


//  class SettingsBC1416STS
package core.settings 
{
    import core.settings.interfaces.*;
    import flash.events.*;
    
    public class SettingsBC1416STS extends core.settings.SettingsBC1416 implements core.settings.interfaces.ICadenceSensor
    {
        public function SettingsBC1416STS(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            return;
        }

        public function get cadenceSensorActive():Boolean
        {
            return _cadenceSensorActive;
        }

        public function set cadenceSensorActive(arg1:Boolean):void
        {
            if (arg1 != _cadenceSensorActive) 
            {
                _cadenceSensorActive = arg1;
                dispatchEvent(new flash.events.Event("cadenceSensorActiveChange"));
            }
            return;
        }

        internal var _cadenceSensorActive:Boolean=false;
    }
}


//  class SettingsBC1609
package core.settings 
{
    import core.settings.interfaces.*;
    import flash.events.*;
    
    public class SettingsBC1609 extends core.settings.SettingsTopline2009 implements core.settings.interfaces.ILanguage, core.settings.interfaces.IWheelSize2, core.settings.interfaces.IService, core.settings.interfaces.ILowBatDetectLevel, core.settings.interfaces.IContrast
    {
        public function SettingsBC1609()
        {
            super();
            wheelSize1 = 2155;
            speedUnit = "kmh";
            return;
        }

        public function get contrast():int
        {
            return _contrast;
        }

        public function set contrast(arg1:int):void
        {
            if (arg1 != _contrast) 
            {
                _contrast = arg1;
                dispatchEvent(new flash.events.Event("contrastChange"));
            }
            return;
        }

        public function get contrastMax():int
        {
            return 3;
        }

        public function get contrastMin():int
        {
            return 1;
        }

        public function get language():String
        {
            return _language;
        }

        public function set language(arg1:String):void
        {
            if (arg1 != _language) 
            {
                _language = arg1;
                dispatchEvent(new flash.events.Event("languageChange"));
            }
            return;
        }

        public function get lowBatDetectLevel():String
        {
            return _lowBatDetectLevel;
        }

        public function set lowBatDetectLevel(arg1:String):void
        {
            if (arg1 != _lowBatDetectLevel) 
            {
                _lowBatDetectLevel = arg1;
                dispatchEvent(new flash.events.Event("lowBatDetectLevelChange"));
            }
            return;
        }

        public function get serviceInterval():int
        {
            return _serviceInterval;
        }

        public function set serviceInterval(arg1:int):void
        {
            if (arg1 != _serviceInterval) 
            {
                _serviceInterval = arg1;
                dispatchEvent(new flash.events.Event("serviceIntervalChange"));
            }
            return;
        }

        public function get serviceStatusOn():Boolean
        {
            return _serviceStatusOn;
        }

        public function set serviceStatusOn(arg1:Boolean):void
        {
            if (arg1 != _serviceStatusOn) 
            {
                _serviceStatusOn = arg1;
                dispatchEvent(new flash.events.Event("serviceStatusOnChange"));
            }
            return;
        }

        public function get wheelSize2():int
        {
            return _wheelSize2;
        }

        public function set wheelSize2(arg1:int):void
        {
            if (arg1 != _wheelSize2) 
            {
                _wheelSize2 = arg1;
                dispatchEvent(new flash.events.Event("wheelSize2Change"));
            }
            return;
        }

        public override function toString():String
        {
            return "[SettingsBC1609 extends SettingsTopline implements ILanguage, IWheelSize2, IService, ILowBatDetectLevel, IContrast]";
        }

        internal var _contrast:int=2;

        internal var _language:String="en";

        internal var _lowBatDetectLevel:String="N/A";

        internal var _serviceInterval:int=750;

        internal var _serviceStatusOn:Boolean=false;

        internal var _wheelSize2:int=2000;
    }
}


//  class SettingsBC1612
package core.settings 
{
    import core.settings.interfaces.*;
    import flash.events.*;
    
    public class SettingsBC1612 extends core.settings.SettingsTopline2012 implements core.settings.interfaces.IService, core.settings.interfaces.ILanguage, core.settings.interfaces.IContrast, core.settings.interfaces.IWheelSize2, core.settings.interfaces.ILowBatDetectLevel
    {
        public function SettingsBC1612(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            wheelSize1 = 2155;
            speedUnit = "kmh";
            return;
        }

        public function get contrast():int
        {
            return _contrast;
        }

        public function set contrast(arg1:int):void
        {
            if (arg1 != _contrast) 
            {
                _contrast = arg1;
                dispatchEvent(new flash.events.Event("contrastChange"));
            }
            return;
        }

        public function get contrastMax():int
        {
            return 3;
        }

        public function get contrastMin():int
        {
            return 1;
        }

        public function get language():String
        {
            return _language;
        }

        public function set language(arg1:String):void
        {
            if (arg1 != _language) 
            {
                _language = arg1;
                dispatchEvent(new flash.events.Event("languageChange"));
            }
            return;
        }

        public function get lowBatDetectLevel():String
        {
            return _lowBatDetectLevel;
        }

        public function set lowBatDetectLevel(arg1:String):void
        {
            if (arg1 != _lowBatDetectLevel) 
            {
                _lowBatDetectLevel = arg1;
                dispatchEvent(new flash.events.Event("lowBatDetectLevelChange"));
            }
            return;
        }

        public function get serviceInterval():int
        {
            return _serviceInterval;
        }

        public function set serviceInterval(arg1:int):void
        {
            if (arg1 != _serviceInterval) 
            {
                _serviceInterval = arg1;
                dispatchEvent(new flash.events.Event("serviceIntervalChange"));
            }
            return;
        }

        public function get serviceStatusOn():Boolean
        {
            return _serviceStatusOn;
        }

        public function set serviceStatusOn(arg1:Boolean):void
        {
            if (arg1 != _serviceStatusOn) 
            {
                _serviceStatusOn = arg1;
                dispatchEvent(new flash.events.Event("serviceStatusOnChange"));
            }
            return;
        }

        public function get wheelSize2():int
        {
            return _wheelSize2;
        }

        public function set wheelSize2(arg1:int):void
        {
            if (arg1 != _wheelSize2) 
            {
                _wheelSize2 = arg1;
                dispatchEvent(new flash.events.Event("wheelSize2Change"));
            }
            return;
        }

        public override function toString():String
        {
            return "[SettingsBC1612 extends SettingsTopline2012]";
        }

        protected var _contrast:int=2;

        protected var _language:String="en";

        internal var _lowBatDetectLevel:String="N/A";

        internal var _serviceInterval:int=750;

        internal var _serviceStatusOn:Boolean=false;

        protected var _wheelSize2:int=2000;
    }
}


//  class SettingsBC1616
package core.settings 
{
    import core.general.*;
    import core.settings.interfaces.*;
    import flash.events.*;
    
    public class SettingsBC1616 extends core.settings.SettingsTopline2016 implements core.settings.interfaces.IDate, core.settings.interfaces.ILanguage, core.settings.interfaces.IService, core.settings.interfaces.IWheelSize2Mode, core.settings.interfaces.ITireSize2, core.settings.interfaces.IWheelSize2, core.settings.interfaces.IContrast, core.settings.interfaces.IDateFormat, core.settings.interfaces.ITemperatureUnit, core.settings.interfaces.IClockMode, core.settings.interfaces.IFuelConsumptionUnit, core.settings.interfaces.IETADistance, core.settings.interfaces.IMyName, core.settings.interfaces.IBacklight, core.settings.interfaces.IBacklightTimeOff, core.settings.interfaces.IBacklightTimeOn, core.settings.interfaces.IFuelConsumption, core.settings.interfaces.IPowerSaveMode, core.settings.interfaces.IETAArivalFlag, core.settings.interfaces.INfc
    {
        public function SettingsBC1616(arg1:flash.events.IEventDispatcher=null)
        {
            _tireSize2 = core.general.TireSize.S_16INCH;
            _wheelSize2Mode = core.general.WheelSizeSelectionMode.TIRE;
            super(arg1);
            return;
        }

        public function set serviceStatusOn(arg1:Boolean):void
        {
            if (arg1 != _serviceStatusOn) 
            {
                _serviceStatusOn = arg1;
                dispatchEvent(new flash.events.Event("serviceStatusOnChange"));
            }
            return;
        }

        public function get backlightActive():Boolean
        {
            return _backlightActive;
        }

        public function set backlightActive(arg1:Boolean):void
        {
            if (arg1 != _backlightActive) 
            {
                _backlightActive = arg1;
                dispatchEvent(new flash.events.Event("backlightActiveChange"));
            }
            return;
        }

        public function get temperatureUnit():String
        {
            return _temperatureUnit;
        }

        public function get backlightTimeOff():Date
        {
            if (!_backlightTimeOff) 
            {
                _backlightTimeOff = new Date();
                _backlightTimeOff.setSeconds(64800);
            }
            return _backlightTimeOff;
        }

        public function set backlightTimeOff(arg1:Date):void
        {
            if (arg1 != _backlightTimeOff) 
            {
                _backlightTimeOff = arg1;
                dispatchEvent(new flash.events.Event("backlightTimeOffChange"));
            }
            return;
        }

        public function set temperatureUnit(arg1:String):void
        {
            if (arg1 != _temperatureUnit) 
            {
                _temperatureUnit = arg1;
                dispatchEvent(new flash.events.Event("temperatureUnitChange"));
            }
            return;
        }

        public function get backlightTimeOn():Date
        {
            if (!_backlightTimeOn) 
            {
                _backlightTimeOn = new Date();
                _backlightTimeOn.setSeconds(64800);
            }
            return _backlightTimeOn;
        }

        public function set backlightTimeOn(arg1:Date):void
        {
            if (arg1 != _backlightTimeOn) 
            {
                _backlightTimeOn = arg1;
                dispatchEvent(new flash.events.Event("backlightTimeOnChange"));
            }
            return;
        }

        public function get tireSize2():core.general.TireSize
        {
            return _tireSize2;
        }

        public function get clockMode():String
        {
            return _clockMode;
        }

        public function set clockMode(arg1:String):void
        {
            if (arg1 != _clockMode) 
            {
                _clockMode = arg1;
                dispatchEvent(new flash.events.Event("clockModeChange"));
            }
            return;
        }

        public function set wheelSize2Mode(arg1:core.general.WheelSizeSelectionMode):void
        {
            _wheelSize2Mode = arg1;
            return;
        }

        public function get contrast():int
        {
            return _contrast;
        }

        public function set contrast(arg1:int):void
        {
            if (arg1 != _contrast) 
            {
                _contrast = arg1;
                dispatchEvent(new flash.events.Event("contrastChange"));
            }
            return;
        }

        public function get contrastMax():int
        {
            return 3;
        }

        public function get contrastMin():int
        {
            return 1;
        }

        public function get wheelSize2():int
        {
            return _wheelSize2;
        }

        public function get dateFormat():String
        {
            return _dateFormat;
        }

        public function set dateFormat(arg1:String):void
        {
            if (arg1 != _dateFormat) 
            {
                _dateFormat = arg1;
                dispatchEvent(new flash.events.Event("dateFormatChange"));
            }
            return;
        }

        public function set wheelSize2(arg1:int):void
        {
            if (_wheelSize2 !== arg1) 
            {
                _wheelSize2 = arg1;
                dispatchEvent(new flash.events.Event("wheelSize2Change"));
            }
            return;
        }

        public function get etaArivalFlag():Boolean
        {
            return _etaArivalFlag;
        }

        public function set etaArivalFlag(arg1:Boolean):void
        {
            if (arg1 != _etaArivalFlag) 
            {
                _etaArivalFlag = arg1;
                dispatchEvent(new flash.events.Event("etaArivalFlagChange"));
            }
            return;
        }

        public function get wheelSize2Max():int
        {
            return 3999;
        }

        public function get etaDistance():Number
        {
            return _etaDistance;
        }

        public function set etaDistance(arg1:Number):void
        {
            if (arg1 != _etaDistance) 
            {
                _etaDistance = arg1;
                dispatchEvent(new flash.events.Event("etaDistanceChange"));
            }
            return;
        }

        public function get etaDistanceMax():Number
        {
            return 160935121;
        }

        public function get etaDistanceMin():Number
        {
            return 0;
        }

        public function get wheelSize2Min():int
        {
            return 500;
        }

        public function get fuelConsumption():Number
        {
            return _fuelConsumption;
        }

        public function set fuelConsumption(arg1:Number):void
        {
            if (arg1 != _fuelConsumption) 
            {
                _fuelConsumption = arg1;
                dispatchEvent(new flash.events.Event("fuelConsumptionChange"));
            }
            return;
        }

        public function get fuelConsumptionMax():Number
        {
            if (fuelConsumptionUnit == "l/100km") 
            {
                return 30;
            }
            return 23.52;
        }

        public function get fuelConsumptionMin():Number
        {
            if (fuelConsumptionUnit == "l/100km") 
            {
                return 1;
            }
            return 0.98;
        }

        public function get wheelSize2Mode():core.general.WheelSizeSelectionMode
        {
            return _wheelSize2Mode;
        }

        public function get fuelConsumptionUnit():String
        {
            return _fuelConsumptionUnit;
        }

        public function set fuelConsumptionUnit(arg1:String):void
        {
            if (arg1 != _fuelConsumptionUnit) 
            {
                _fuelConsumptionUnit = arg1;
                dispatchEvent(new flash.events.Event("fuelConsumptionUnitChange"));
            }
            return;
        }

        public function get language():String
        {
            return _language;
        }

        public function set language(arg1:String):void
        {
            if (arg1 != _language) 
            {
                _language = arg1;
                dispatchEvent(new flash.events.Event("languageChange"));
            }
            return;
        }

        public function get myName():String
        {
            return _myName;
        }

        public function set myName(arg1:String):void
        {
            if (arg1 != _myName) 
            {
                _myName = arg1;
                dispatchEvent(new flash.events.Event("myNameChange"));
            }
            return;
        }

        public function get myNameMaxLength():uint
        {
            return 9;
        }

        public function get nfcActive():Boolean
        {
            return _nfcActive;
        }

        public function set nfcActive(arg1:Boolean):void
        {
            _nfcActive = arg1;
            return;
        }

        public function get powerSaveModeActive():Boolean
        {
            return _powerSaveModeActive;
        }

        public function set powerSaveModeActive(arg1:Boolean):void
        {
            if (arg1 != _powerSaveModeActive) 
            {
                _powerSaveModeActive = arg1;
                dispatchEvent(new flash.events.Event("powerSaveModeActiveChange"));
            }
            return;
        }

        public function get serviceInterval():int
        {
            return _serviceInterval;
        }

        public function set serviceInterval(arg1:int):void
        {
            if (arg1 != _serviceInterval) 
            {
                _serviceInterval = arg1;
                dispatchEvent(new flash.events.Event("serviceIntervalChange"));
            }
            return;
        }

        public function set tireSize2(arg1:core.general.TireSize):void
        {
            _tireSize2 = arg1;
            if (arg1 && core.general.WheelSizeSelectionMode.TIRE.equals(wheelSize2Mode)) 
            {
                wheelSize2 = parseInt(arg1.data);
            }
            return;
        }

        public function get serviceStatusOn():Boolean
        {
            return _serviceStatusOn;
        }

        internal const _myNameMaxLength:uint=9;

        internal var _backlightActive:Boolean=false;

        internal var _backlightTimeOff:Date;

        internal var _backlightTimeOn:Date;

        internal var _clockMode:String="24";

        internal var _contrast:int=2;

        internal var _dateFormat:String="eu";

        internal var _etaArivalFlag:Boolean=true;

        internal var _etaDistance:Number=100000;

        internal var _fuelConsumption:Number=8.5;

        internal var _fuelConsumptionUnit:String="l/100km";

        internal var _tireSize2:core.general.TireSize;

        internal var _powerSaveModeActive:Boolean=false;

        internal var _wheelSize2:int=1253;

        internal var _language:String="en";

        internal var _nfcActive:Boolean=true;

        internal var _temperatureUnit:String="";

        internal var _serviceInterval:int=750;

        internal var _wheelSize2Mode:core.general.WheelSizeSelectionMode;

        internal var _myName:String="BC 16.16";

        internal var _serviceStatusOn:Boolean=false;
    }
}


//  class SettingsBC1616STS
package core.settings 
{
    import core.settings.interfaces.*;
    import flash.events.*;
    
    public class SettingsBC1616STS extends core.settings.SettingsBC1616 implements core.settings.interfaces.ICadenceSensor
    {
        public function SettingsBC1616STS(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            return;
        }

        public function get cadenceSensorActive():Boolean
        {
            return _cadenceSensorActive;
        }

        public function set cadenceSensorActive(arg1:Boolean):void
        {
            if (arg1 != _cadenceSensorActive) 
            {
                _cadenceSensorActive = arg1;
                dispatchEvent(new flash.events.Event("cadenceSensorActiveChange"));
            }
            return;
        }

        internal var _cadenceSensorActive:Boolean=false;
    }
}


//  class SettingsBC1909HR
package core.settings 
{
    import core.settings.interfaces.*;
    import flash.events.*;
    
    public class SettingsBC1909HR extends core.settings.SettingsTopline2009 implements core.settings.interfaces.ILanguage, core.settings.interfaces.IHeartrateLimits, core.settings.interfaces.ITrainingZone, core.settings.interfaces.IHRmax, core.settings.interfaces.IWheelSize2, core.settings.interfaces.IBodyWeight, core.settings.interfaces.IAge, core.settings.interfaces.IGender, core.settings.interfaces.IService, core.settings.interfaces.ILowBatDetectLevel, core.settings.interfaces.IBodyWeightUnit, core.settings.interfaces.IContrast
    {
        public function SettingsBC1909HR()
        {
            super();
            wheelSize1 = 2155;
            speedUnit = "kmh";
            hrMax = 191;
            return;
        }

        public function set upperLimit(arg1:int):void
        {
            if (arg1 != _upperLimit) 
            {
                _upperLimit = arg1;
                dispatchEvent(new flash.events.Event("upperLimitChange"));
            }
            return;
        }

        public function get age():int
        {
            return _age;
        }

        public function set age(arg1:int):void
        {
            if (arg1 != _age) 
            {
                _age = arg1;
                dispatchEvent(new flash.events.Event("ageChange"));
            }
            return;
        }

        public function get ageMax():int
        {
            return 99;
        }

        public function get ageMin():int
        {
            return 10;
        }

        public function get bodyWeight():int
        {
            return _weight;
        }

        public function set bodyWeight(arg1:int):void
        {
            if (arg1 != _weight) 
            {
                _weight = arg1;
                dispatchEvent(new flash.events.Event("weightChange"));
            }
            return;
        }

        public function get bodyWeightUnit():String
        {
            return _weightUnit;
        }

        public function set bodyWeightUnit(arg1:String):void
        {
            if (arg1 != _weightUnit) 
            {
                _weightUnit = arg1;
                dispatchEvent(new flash.events.Event("weightUnitChange"));
            }
            return;
        }

        public function get upperLimitMax():int
        {
            return 240;
        }

        public function get contrast():int
        {
            return _contrast;
        }

        public function set contrast(arg1:int):void
        {
            if (arg1 != _contrast) 
            {
                _contrast = arg1;
                dispatchEvent(new flash.events.Event("contrastChange"));
            }
            return;
        }

        public function get contrastMax():int
        {
            return 3;
        }

        public function get contrastMin():int
        {
            return 1;
        }

        public function get upperLimitMin():int
        {
            return lowerLimit + 5;
        }

        public function get gender():String
        {
            return _gender;
        }

        public function set gender(arg1:String):void
        {
            if (arg1 != _gender) 
            {
                _gender = arg1;
                dispatchEvent(new flash.events.Event("genderChange"));
            }
            return;
        }

        public function get wheelSize2():int
        {
            return _wheelSize2;
        }

        public function get hrMax():int
        {
            return _hrMax;
        }

        public function set hrMax(arg1:int):void
        {
            if (arg1 != _hrMax) 
            {
                _hrMax = arg1;
                dispatchEvent(new flash.events.Event("hrMaxChange"));
            }
            return;
        }

        public function set wheelSize2(arg1:int):void
        {
            if (arg1 != _wheelSize2) 
            {
                _wheelSize2 = arg1;
                dispatchEvent(new flash.events.Event("wheelSize2Change"));
            }
            return;
        }

        public function get language():String
        {
            return _language;
        }

        public function set language(arg1:String):void
        {
            if (arg1 != _language) 
            {
                _language = arg1;
                dispatchEvent(new flash.events.Event("languageChange"));
            }
            return;
        }

        public override function toString():String
        {
            return "[SettingsBC1909HR extends SettingsTopline ...]";
        }

        public function get lowBatDetectLevel():String
        {
            return _lowBatDetectLevel;
        }

        public function set lowBatDetectLevel(arg1:String):void
        {
            if (arg1 != _lowBatDetectLevel) 
            {
                _lowBatDetectLevel = arg1;
                dispatchEvent(new flash.events.Event("lowBatDetectLevelChange"));
            }
            return;
        }

        public function get lowerLimit():int
        {
            return _lowerLimit;
        }

        public function set lowerLimit(arg1:int):void
        {
            if (arg1 != _lowerLimit) 
            {
                _lowerLimit = arg1;
                dispatchEvent(new flash.events.Event("lowerLimitChange"));
            }
            return;
        }

        public function get lowerLimitMax():int
        {
            return upperLimit - 5;
        }

        public function get lowerLimitMin():int
        {
            return 40;
        }

        public function get serviceInterval():int
        {
            return _serviceInterval;
        }

        public function set serviceInterval(arg1:int):void
        {
            if (arg1 != _serviceInterval) 
            {
                _serviceInterval = arg1;
                dispatchEvent(new flash.events.Event("serviceIntervalChange"));
            }
            return;
        }

        public function get serviceStatusOn():Boolean
        {
            return _serviceStatusOn;
        }

        public function set serviceStatusOn(arg1:Boolean):void
        {
            if (arg1 != _serviceStatusOn) 
            {
                _serviceStatusOn = arg1;
                dispatchEvent(new flash.events.Event("serviceStatusOnChange"));
            }
            return;
        }

        public function get trainingZone():String
        {
            return _trainingZone;
        }

        public function set trainingZone(arg1:String):void
        {
            if (arg1 != _trainingZone) 
            {
                _trainingZone = arg1;
                dispatchEvent(new flash.events.Event("trainingZoneChange"));
            }
            return;
        }

        public function get upperLimit():int
        {
            return _upperLimit;
        }

        internal var _age:int=30;

        internal var _contrast:int=2;

        internal var _gender:String="male";

        internal var _hrMax:int=40;

        internal var _language:String="en";

        internal var _lowBatDetectLevel:String;

        internal var _serviceStatusOn:Boolean=false;

        internal var _lowerLimit:int=107;

        internal var _wheelSize2:int=2000;

        internal var _upperLimit:int=136;

        internal var _serviceInterval:int=750;

        internal var _weight:int=75000;

        internal var _weightUnit:String="kg";

        internal var _trainingZone:String="N/A";
    }
}


//  class SettingsBC2209MHR
package core.settings 
{
    import core.general.*;
    import core.settings.interfaces.*;
    import flash.events.*;
    
    public class SettingsBC2209MHR extends core.settings.SettingsTopline2009 implements core.settings.interfaces.ILanguage, core.settings.interfaces.IWheelSize2, core.settings.interfaces.IAge, core.settings.interfaces.IGender, core.settings.interfaces.IActualAltitude, core.settings.interfaces.IService, core.settings.interfaces.ILowBatDetectLevel, core.settings.interfaces.IAltitudeReference, core.settings.interfaces.IHomeAltitude1, core.settings.interfaces.ISeaLevel, core.settings.interfaces.IBodyWeight, core.settings.interfaces.IBodyWeightUnit, core.settings.interfaces.IContrast
    {
        public function SettingsBC2209MHR()
        {
            _altitudeReference = core.general.AltitudeReference.ACTUAL_ALTITUDE;
            _referenceMark = core.general.AltitudeReference.SEA_LEVEL;
            super();
            wheelSize1 = 2155;
            speedUnit = "kmh";
            return;
        }

        public function set serviceInterval(arg1:int):void
        {
            if (arg1 != _serviceInterval) 
            {
                _serviceInterval = arg1;
                dispatchEvent(new flash.events.Event("serviceIntervalChange"));
            }
            return;
        }

        public function get actualAltitude():int
        {
            return _actualAltitude;
        }

        public function set actualAltitude(arg1:int):void
        {
            if (arg1 != _actualAltitude) 
            {
                _actualAltitude = arg1;
                dispatchEvent(new flash.events.Event("actualAltitudeChange"));
            }
            return;
        }

        public function get serviceStatusOn():Boolean
        {
            return _serviceStatusOn;
        }

        public function get age():int
        {
            return _age;
        }

        public function set age(arg1:int):void
        {
            if (arg1 != _age) 
            {
                _age = arg1;
                dispatchEvent(new flash.events.Event("ageChange"));
            }
            return;
        }

        public function get ageMax():int
        {
            return 99;
        }

        public function get ageMin():int
        {
            return 10;
        }

        public function set serviceStatusOn(arg1:Boolean):void
        {
            if (arg1 != _serviceStatusOn) 
            {
                _serviceStatusOn = arg1;
                dispatchEvent(new flash.events.Event("serviceStatusOnChange"));
            }
            return;
        }

        public function get altitudeReference():String
        {
            return _altitudeReference;
        }

        public function set altitudeReference(arg1:String):void
        {
            if (_altitudeReference !== arg1) 
            {
                _altitudeReference = arg1;
                dispatchEvent(new flash.events.Event("altitudeReferenceChange"));
            }
            return;
        }

        public function get bodyWeight():int
        {
            return _weight;
        }

        public function set bodyWeight(arg1:int):void
        {
            if (arg1 != _weight) 
            {
                _weight = arg1;
                dispatchEvent(new flash.events.Event("weightChange"));
            }
            return;
        }

        public function get bodyWeightUnit():String
        {
            return _weightUnit;
        }

        public function set bodyWeightUnit(arg1:String):void
        {
            if (arg1 != _weightUnit) 
            {
                _weightUnit = arg1;
                dispatchEvent(new flash.events.Event("weightUnitChange"));
            }
            return;
        }

        public function get wheelSize2():int
        {
            return _wheelSize2;
        }

        public function get contrast():int
        {
            return _contrast;
        }

        public function set contrast(arg1:int):void
        {
            if (arg1 != _contrast) 
            {
                _contrast = arg1;
                dispatchEvent(new flash.events.Event("contrastChange"));
            }
            return;
        }

        public function get contrastMax():int
        {
            return 3;
        }

        public function get contrastMin():int
        {
            return 1;
        }

        public function set wheelSize2(arg1:int):void
        {
            if (arg1 != _wheelSize2) 
            {
                _wheelSize2 = arg1;
                dispatchEvent(new flash.events.Event("wheelSize2Change"));
            }
            return;
        }

        public function get gender():String
        {
            return _gender;
        }

        public function set gender(arg1:String):void
        {
            if (arg1 != _gender) 
            {
                _gender = arg1;
                dispatchEvent(new flash.events.Event("genderChange"));
            }
            return;
        }

        public override function toString():String
        {
            return "[SettingsBC2209MHR extends SettingsBikeComputer ...]";
        }

        public function get homeAltitude1():int
        {
            return _homeAltitude1;
        }

        public function set homeAltitude1(arg1:int):void
        {
            if (arg1 != _homeAltitude1) 
            {
                _homeAltitude1 = arg1;
                dispatchEvent(new flash.events.Event("homeAltitudeChange"));
            }
            return;
        }

        public function get language():String
        {
            return _language;
        }

        public function set language(arg1:String):void
        {
            if (arg1 != _language) 
            {
                _language = arg1;
                dispatchEvent(new flash.events.Event("languageChange"));
            }
            return;
        }

        public function get lowBatDetectLevel():String
        {
            return _lowBatDetectLevel;
        }

        public function set lowBatDetectLevel(arg1:String):void
        {
            if (arg1 != _lowBatDetectLevel) 
            {
                _lowBatDetectLevel = arg1;
                dispatchEvent(new flash.events.Event("lowBatDetectLevelChange"));
            }
            return;
        }

        public function get referenceMark():String
        {
            return _referenceMark;
        }

        public function set referenceMark(arg1:String):void
        {
            if (arg1 != _referenceMark) 
            {
                _referenceMark = arg1;
                dispatchEvent(new flash.events.Event("referenceMarkChange"));
            }
            return;
        }

        public function get seaLevel():Number
        {
            return _seaLevel;
        }

        public function set seaLevel(arg1:Number):void
        {
            if (arg1 != _seaLevel) 
            {
                _seaLevel = arg1;
                dispatchEvent(new flash.events.Event("seaLevelChange"));
            }
            return;
        }

        public function get serviceInterval():int
        {
            return _serviceInterval;
        }

        internal var _actualAltitude:int=250000;

        internal var _age:int=27;

        internal var _altitudeReference:String;

        internal var _contrast:int=2;

        internal var _gender:String="male";

        internal var _homeAltitude1:int=100000;

        internal var _serviceStatusOn:Boolean=false;

        internal var _referenceMark:String;

        internal var _language:String="en";

        internal var _wheelSize2:int=2000;

        internal var _serviceInterval:int=750;

        internal var _lowBatDetectLevel:String="N/A";

        internal var _weight:int=75000;

        internal var _weightUnit:String="kg";

        internal var _seaLevel:Number=1009;
    }
}


//  class SettingsBC2316STS
package core.settings 
{
    import core.general.*;
    import core.settings.interfaces.*;
    import core.units.interfaces.*;
    import flash.events.*;
    
    public class SettingsBC2316STS extends core.settings.SettingsTopline2016 implements core.settings.interfaces.IDate, core.settings.interfaces.ILanguage, core.settings.interfaces.IService, core.settings.interfaces.IWheelSize2Mode, core.settings.interfaces.ITireSize2, core.settings.interfaces.IWheelSize2, core.settings.interfaces.IAltitudeReference, core.settings.interfaces.IAltitudeUnit, core.settings.interfaces.IActualAltitude, core.settings.interfaces.ISeaLevel, core.settings.interfaces.IContrast, core.settings.interfaces.IDateFormat, core.settings.interfaces.ITemperatureUnit, core.settings.interfaces.IClockMode, core.settings.interfaces.IHomeAltitude1, core.settings.interfaces.IHomeAltitude2, core.settings.interfaces.IMyName, core.settings.interfaces.IPowerSaveMode, core.settings.interfaces.ICadenceSensor, core.settings.interfaces.IHeartrateSensor, core.settings.interfaces.INfc, core.settings.interfaces.IWeightUnit, core.settings.interfaces.IBodyHeightUnit, core.settings.interfaces.IBikeType1, core.settings.interfaces.IBikeWeight1, core.settings.interfaces.IBikeType2, core.settings.interfaces.IBikeWeight2, core.settings.interfaces.IBirthDate, core.settings.interfaces.IBodyWeight, core.settings.interfaces.IBodyHeight, core.settings.interfaces.IShoulderWidth, core.settings.interfaces.IGender, core.settings.interfaces.IHRmax, core.settings.interfaces.IHeartrateLimits, core.units.interfaces.IIntensityZonesPercentage, core.settings.interfaces.IZoneAlarm, core.settings.interfaces.ITrainingZone, core.settings.interfaces.IHRMaxOption, core.settings.interfaces.ISamplingRate
    {
        public function SettingsBC2316STS(arg1:flash.events.IEventDispatcher=null)
        {
            _altitudeReference = core.general.AltitudeReference.ACTUAL_ALTITUDE;
            _birthDate = new Date(1983, 0, 1);
            _tireSize2 = core.general.TireSize.S_16INCH;
            _wheelSize2Mode = core.general.WheelSizeSelectionMode.TIRE;
            super(arg1);
            return;
        }

        public function get shoulderWidthMin():Number
        {
            if (bodyHeightUnit == "kilometer") 
            {
                return 40;
            }
            return 38;
        }

        public function get actualAltitude():int
        {
            return _actualAltitude;
        }

        public function set actualAltitude(arg1:int):void
        {
            if (arg1 != _actualAltitude) 
            {
                _actualAltitude = arg1;
                dispatchEvent(new flash.events.Event("actualAltitudeChange"));
            }
            return;
        }

        public function get actualAltitudeMax():int
        {
            if (altitudeUnit == "meter") 
            {
                return 4999000;
            }
            return 5181295;
        }

        public function get actualAltitudeMin():int
        {
            if (altitudeUnit == "meter") 
            {
                return -999000;
            }
            return -304495;
        }

        public function get temperatureUnit():String
        {
            return _temperatureUnit;
        }

        public function get altitudeReference():String
        {
            return _altitudeReference;
        }

        public function set altitudeReference(arg1:String):void
        {
            if (_altitudeReference !== arg1) 
            {
                _altitudeReference = arg1;
                dispatchEvent(new flash.events.Event("altitudeReferenceChange"));
            }
            return;
        }

        public function set temperatureUnit(arg1:String):void
        {
            if (arg1 != _temperatureUnit) 
            {
                _temperatureUnit = arg1;
                dispatchEvent(new flash.events.Event("temperatureUnitChange"));
            }
            return;
        }

        public function get altitudeUnit():String
        {
            return _altitudeUnit;
        }

        public function set altitudeUnit(arg1:String):void
        {
            if (arg1 != _altitudeUnit) 
            {
                _altitudeUnit = arg1;
                dispatchEvent(new flash.events.Event("altitudeUnitChange"));
            }
            return;
        }

        public function get tireSize2():core.general.TireSize
        {
            return _tireSize2;
        }

        public function get bikeType1():String
        {
            return _bikeType1;
        }

        public function set bikeType1(arg1:String):void
        {
            if (arg1 != _bikeType1) 
            {
                _bikeType1 = arg1;
                dispatchEvent(new flash.events.Event("bikeType1Change"));
            }
            return;
        }

        public function set tireSize2(arg1:core.general.TireSize):void
        {
            _tireSize2 = arg1;
            if (arg1 && core.general.WheelSizeSelectionMode.TIRE.equals(wheelSize2Mode)) 
            {
                wheelSize2 = parseInt(arg1.data);
            }
            return;
        }

        public function get bikeType2():String
        {
            return _bikeType2;
        }

        public function set bikeType2(arg1:String):void
        {
            if (arg1 != _bikeType2) 
            {
                _bikeType2 = arg1;
                dispatchEvent(new flash.events.Event("bikeType2Change"));
            }
            return;
        }

        public function set trainingZone(arg1:String):void
        {
            if (arg1 != _trainingZone) 
            {
                _trainingZone = arg1;
                dispatchEvent(new flash.events.Event("trainingZoneChange"));
            }
            return;
        }

        public function get bikeWeight1():int
        {
            return _bikeWeight1;
        }

        public function set bikeWeight1(arg1:int):void
        {
            if (arg1 != _bikeWeight1) 
            {
                _bikeWeight1 = arg1;
                dispatchEvent(new flash.events.Event("bikeWeight1Change"));
            }
            return;
        }

        public function get bikeWeight1Max():int
        {
            if (weightUnit == "kg") 
            {
                return 50000;
            }
            return 45359;
        }

        public function get bikeWeight1Min():int
        {
            if (weightUnit == "kg") 
            {
                return 1000;
            }
            return 1361;
        }

        public function get upperLimit():int
        {
            return _upperLimit;
        }

        public function get bikeWeight2():int
        {
            return _bikeWeight2;
        }

        public function set bikeWeight2(arg1:int):void
        {
            if (arg1 != _bikeWeight2) 
            {
                _bikeWeight2 = arg1;
                dispatchEvent(new flash.events.Event("bikeWeight2Change"));
            }
            return;
        }

        public function get bikeWeight2Max():int
        {
            return bikeWeight1Max;
        }

        public function get bikeWeight2Min():int
        {
            return bikeWeight1Min;
        }

        public function set upperLimit(arg1:int):void
        {
            if (arg1 != _upperLimit) 
            {
                _upperLimit = arg1;
                dispatchEvent(new flash.events.Event("upperLimitChange"));
            }
            return;
        }

        public function get birthDate():Date
        {
            return _birthDate;
        }

        public function set birthDate(arg1:Date):void
        {
            if (arg1 != _birthDate) 
            {
                _birthDate = arg1;
                dispatchEvent(new flash.events.Event("birthDateChange"));
            }
            return;
        }

        public function get birthDateMax():Number
        {
            return new Date(NOW.fullYear - 6, NOW.month, NOW.date).time;
        }

        public function get birthDateMin():Number
        {
            return new Date(1900, 0, 1).time;
        }

        public function get upperLimitMax():int
        {
            return 240;
        }

        public function get bodyHeight():Number
        {
            return _bodyHeight;
        }

        public function set bodyHeight(arg1:Number):void
        {
            if (arg1 != _bodyHeight) 
            {
                _bodyHeight = arg1;
                dispatchEvent(new flash.events.Event("bodyHeightChange"));
            }
            return;
        }

        public function get bodyHeightMax():Number
        {
            if (weightUnit == "kg") 
            {
                return 250;
            }
            return 254;
        }

        public function get bodyHeightMin():Number
        {
            if (weightUnit == "kg") 
            {
                return 100;
            }
            return 102;
        }

        public function get upperLimitMin():int
        {
            return lowerLimit + 1;
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

        public function get weightUnit():String
        {
            return _weightUnit;
        }

        public function get bodyWeight():int
        {
            return _bodyWeight;
        }

        public function set bodyWeight(arg1:int):void
        {
            if (arg1 != _bodyWeight) 
            {
                _bodyWeight = arg1;
                dispatchEvent(new flash.events.Event("weightChange"));
            }
            return;
        }

        public function get bodyWeightMax():int
        {
            if (weightUnit == "kg") 
            {
                return 200000;
            }
            return 181437;
        }

        public function get bodyWeightMin():int
        {
            if (weightUnit == "kg") 
            {
                return 20000;
            }
            return 18144;
        }

        public function set weightUnit(arg1:String):void
        {
            if (arg1 != _weightUnit) 
            {
                _weightUnit = arg1;
                dispatchEvent(new flash.events.Event("weightUnitChange"));
            }
            return;
        }

        public function get cadenceSensorActive():Boolean
        {
            return _cadenceSensorActive;
        }

        public function set cadenceSensorActive(arg1:Boolean):void
        {
            if (arg1 != _cadenceSensorActive) 
            {
                _cadenceSensorActive = arg1;
                dispatchEvent(new flash.events.Event("cadenceSensorActiveChange"));
            }
            return;
        }

        public function get wheelSize2():int
        {
            return _wheelSize2;
        }

        public function get clockMode():String
        {
            return _clockMode;
        }

        public function set clockMode(arg1:String):void
        {
            if (arg1 != _clockMode) 
            {
                _clockMode = arg1;
                dispatchEvent(new flash.events.Event("clockModeChange"));
            }
            return;
        }

        public function set wheelSize2(arg1:int):void
        {
            if (_wheelSize2 !== arg1) 
            {
                _wheelSize2 = arg1;
                dispatchEvent(new flash.events.Event("wheelSize2Change"));
            }
            return;
        }

        public function get contrast():int
        {
            return _contrast;
        }

        public function set contrast(arg1:int):void
        {
            if (arg1 != _contrast) 
            {
                _contrast = arg1;
                dispatchEvent(new flash.events.Event("contrastChange"));
            }
            return;
        }

        public function get contrastMax():int
        {
            return 3;
        }

        public function get contrastMin():int
        {
            return 1;
        }

        public function get wheelSize2Max():int
        {
            return 3999;
        }

        public function get dateFormat():String
        {
            return _dateFormat;
        }

        public function set dateFormat(arg1:String):void
        {
            if (arg1 != _dateFormat) 
            {
                _dateFormat = arg1;
                dispatchEvent(new flash.events.Event("dateFormatChange"));
            }
            return;
        }

        public function get wheelSize2Min():int
        {
            return 500;
        }

        public function get gender():String
        {
            return _gender;
        }

        public function set gender(arg1:String):void
        {
            if (arg1 != _gender) 
            {
                _gender = arg1;
                dispatchEvent(new flash.events.Event("genderChange"));
            }
            return;
        }

        public function set hrMaxOption(arg1:String):void
        {
            if (arg1 != _hrMaxOption) 
            {
                _hrMaxOption = arg1;
                dispatchEvent(new flash.events.Event("hrMaxOptionChange"));
            }
            return;
        }

        public function get heartrateSensorActive():Boolean
        {
            return _heartrateSensorActive;
        }

        public function set heartrateSensorActive(arg1:Boolean):void
        {
            if (arg1 != _heartrateSensorActive) 
            {
                _heartrateSensorActive = arg1;
                dispatchEvent(new flash.events.Event("heartrateSensorActiveChange"));
            }
            return;
        }

        public function get wheelSize2Mode():core.general.WheelSizeSelectionMode
        {
            return _wheelSize2Mode;
        }

        public function get homeAltitude1():int
        {
            return _homeAltitude1;
        }

        public function set homeAltitude1(arg1:int):void
        {
            if (arg1 != _homeAltitude1) 
            {
                _homeAltitude1 = arg1;
                dispatchEvent(new flash.events.Event("homeAltitude1Change"));
            }
            return;
        }

        public function get homeAltitude1Max():int
        {
            if (altitudeUnit == "meter") 
            {
                return 4999000;
            }
            return 3962095;
        }

        public function get homeAltitude1Min():int
        {
            if (altitudeUnit == "meter") 
            {
                return -999000;
            }
            return -304495;
        }

        public function set wheelSize2Mode(arg1:core.general.WheelSizeSelectionMode):void
        {
            _wheelSize2Mode = arg1;
            return;
        }

        public function get homeAltitude2():int
        {
            return _homeAltitude2;
        }

        public function set homeAltitude2(arg1:int):void
        {
            if (arg1 != _homeAltitude2) 
            {
                _homeAltitude2 = arg1;
                dispatchEvent(new flash.events.Event("homeAltitude2Change"));
            }
            return;
        }

        public function get homeAltitude2Max():int
        {
            if (altitudeUnit == "meter") 
            {
                return 4999000;
            }
            return 3962095;
        }

        public function get homeAltitude2Min():int
        {
            if (altitudeUnit == "meter") 
            {
                return -999000;
            }
            return -304495;
        }

        public function get zoneAlarm():Boolean
        {
            return _zoneAlarm;
        }

        public function get hrMax():int
        {
            return _hrMax;
        }

        public function set hrMax(arg1:int):void
        {
            if (arg1 != _hrMax) 
            {
                _hrMax = arg1;
                dispatchEvent(new flash.events.Event("hrMaxChange"));
            }
            return;
        }

        public function get hrMaxMax():int
        {
            return 240;
        }

        public function get hrMaxMin():int
        {
            return 40;
        }

        public function set zoneAlarm(arg1:Boolean):void
        {
            if (arg1 != _zoneAlarm) 
            {
                _zoneAlarm = arg1;
                dispatchEvent(new flash.events.Event("zoneAlarmChange"));
            }
            return;
        }

        public function get hrMaxOption():String
        {
            return _hrMaxOption;
        }

        public function get trainingZone():String
        {
            return _trainingZone;
        }

        public function get intensityZone1PercentageStart():Number
        {
            return _intensityZone1PercentageStart;
        }

        public function set intensityZone1PercentageStart(arg1:Number):void
        {
            if (arg1 != _intensityZone1PercentageStart) 
            {
                _intensityZone1PercentageStart = arg1;
                dispatchEvent(new flash.events.Event("intensityZone1PercentageStartChange"));
            }
            return;
        }

        public function get intensityZone2PercentageStart():Number
        {
            return _intensityZone2PercentageStart;
        }

        public function set intensityZone2PercentageStart(arg1:Number):void
        {
            if (arg1 != _intensityZone2PercentageStart) 
            {
                _intensityZone2PercentageStart = arg1;
                dispatchEvent(new flash.events.Event("intensityZone2PercentageStartChange"));
            }
            return;
        }

        public function get intensityZone3PercentageStart():Number
        {
            return _intensityZone3PercentageStart;
        }

        public function set intensityZone3PercentageStart(arg1:Number):void
        {
            if (arg1 != _intensityZone3PercentageStart) 
            {
                _intensityZone3PercentageStart = arg1;
                dispatchEvent(new flash.events.Event("intensityZone3PercentageStartChange"));
            }
            return;
        }

        public function get intensityZone4PercentageEnd():Number
        {
            return _intensityZone4PercentageEnd;
        }

        public function set intensityZone4PercentageEnd(arg1:Number):void
        {
            if (arg1 != _intensityZone4PercentageEnd) 
            {
                _intensityZone4PercentageEnd = arg1;
                dispatchEvent(new flash.events.Event("intensityZone4PercentageEndChange"));
            }
            return;
        }

        public function get intensityZone4PercentageStart():Number
        {
            return _intensityZone4PercentageStart;
        }

        public function set intensityZone4PercentageStart(arg1:Number):void
        {
            if (arg1 != _intensityZone4PercentageStart) 
            {
                _intensityZone4PercentageStart = arg1;
                dispatchEvent(new flash.events.Event("intensityZone4PercentageStartChange"));
            }
            return;
        }

        public function get intensityZonePercentageMin():Number
        {
            return 20;
        }

        public function get language():String
        {
            return _language;
        }

        public function set language(arg1:String):void
        {
            if (arg1 != _language) 
            {
                _language = arg1;
                dispatchEvent(new flash.events.Event("languageChange"));
            }
            return;
        }

        public function get lowerLimit():int
        {
            return _lowerLimit;
        }

        public function set lowerLimit(arg1:int):void
        {
            if (arg1 != _lowerLimit) 
            {
                _lowerLimit = arg1;
                dispatchEvent(new flash.events.Event("lowerLimitChange"));
            }
            return;
        }

        public function get lowerLimitMax():int
        {
            return (upperLimit - 1);
        }

        public function get lowerLimitMin():int
        {
            return 40;
        }

        public function get myName():String
        {
            return _myName;
        }

        public function set myName(arg1:String):void
        {
            if (arg1 != _myName) 
            {
                _myName = arg1;
                dispatchEvent(new flash.events.Event("myNameChange"));
            }
            return;
        }

        public function get myNameMaxLength():uint
        {
            return 9;
        }

        public function get nfcActive():Boolean
        {
            return _nfcActive;
        }

        public function set nfcActive(arg1:Boolean):void
        {
            _nfcActive = arg1;
            return;
        }

        public function get powerSaveModeActive():Boolean
        {
            return _powerSaveModeActive;
        }

        public function set powerSaveModeActive(arg1:Boolean):void
        {
            if (arg1 != _powerSaveModeActive) 
            {
                _powerSaveModeActive = arg1;
                dispatchEvent(new flash.events.Event("powerSaveModeActiveChange"));
            }
            return;
        }

        public function get samplingRate():Number
        {
            return _samplingRate;
        }

        public function set samplingRate(arg1:Number):void
        {
            if (arg1 != _samplingRate) 
            {
                _samplingRate = arg1;
            }
            return;
        }

        public function get seaLevel():Number
        {
            return _seaLevel;
        }

        public function set seaLevel(arg1:Number):void
        {
            if (arg1 != _seaLevel) 
            {
                _seaLevel = arg1;
                dispatchEvent(new flash.events.Event("seaLevelChange"));
            }
            return;
        }

        public function get seaLevelMax():Number
        {
            return 1050;
        }

        public function get seaLevelMin():Number
        {
            return 950;
        }

        public function get serviceInterval():int
        {
            return _serviceInterval;
        }

        public function set serviceInterval(arg1:int):void
        {
            if (arg1 != _serviceInterval) 
            {
                _serviceInterval = arg1;
                dispatchEvent(new flash.events.Event("serviceIntervalChange"));
            }
            return;
        }

        public function get serviceStatusOn():Boolean
        {
            return _serviceStatusOn;
        }

        public function set serviceStatusOn(arg1:Boolean):void
        {
            if (arg1 != _serviceStatusOn) 
            {
                _serviceStatusOn = arg1;
                dispatchEvent(new flash.events.Event("serviceStatusOnChange"));
            }
            return;
        }

        public function get shoulderWidth():Number
        {
            return _shoulderWidth;
        }

        public function set shoulderWidth(arg1:Number):void
        {
            if (arg1 != _shoulderWidth) 
            {
                _shoulderWidth = arg1;
                dispatchEvent(new flash.events.Event("shoulderWidthChange"));
            }
            return;
        }

        public function get shoulderWidthMax():Number
        {
            if (bodyHeightUnit == "kilometer") 
            {
                return 80;
            }
            return 76;
        }

        internal const _myNameMaxLength:uint=9;

        internal var _actualAltitude:int=250000;

        internal var _altitudeReference:String;

        internal var _altitudeUnit:String="meter";

        internal var _bikeType1:String="raceDrop";

        internal var _bikeType2:String="raceDrop";

        internal var _bikeWeight1:int=8000;

        internal var _bikeWeight2:int=8000;

        internal var _birthDate:Date;

        internal var _bodyHeight:Number=180;

        internal var _bodyHeightUnit:String="";

        internal var _bodyWeight:int=70000;

        internal var _cadenceSensorActive:Boolean=false;

        internal var _clockMode:String="24";

        internal var _contrast:int=2;

        internal var _dateFormat:String="eu";

        internal var _gender:String="male";

        internal var _homeAltitude1:int=100000;

        internal var _homeAltitude2:int=100000;

        internal var _hrMax:int=193;

        internal var _hrMaxOption:String="calculated";

        internal var _tireSize2:core.general.TireSize;

        internal var _lowerLimit:int=105;

        internal var _trainingZone:String="fitZone";

        internal var _heartrateSensorActive:Boolean=false;

        internal var _nfcActive:Boolean=true;

        internal var _upperLimit:int=155;

        internal var _serviceInterval:int=750;

        internal var _intensityZone2PercentageStart:Number=70;

        internal var _intensityZone4PercentageEnd:Number=100;

        internal var _serviceStatusOn:Boolean=false;

        internal var _weightUnit:String="kg";

        internal var _powerSaveModeActive:Boolean=false;

        internal var _intensityZone3PercentageStart:Number=80;

        internal var _wheelSize2:int=1253;

        internal var _shoulderWidth:Number=44;

        internal var _language:String="en";

        internal var _samplingRate:Number=5;

        internal var _myName:String="BC 23.16 STS";

        internal var _wheelSize2Mode:core.general.WheelSizeSelectionMode;

        internal var _intensityZone1PercentageStart:Number=60;

        internal var _temperatureUnit:String="";

        internal var _zoneAlarm:Boolean=false;

        internal var _seaLevel:Number=1009;

        internal var _intensityZone4PercentageStart:Number=90;
    }
}


//  class SettingsBC416
package core.settings 
{
    import core.general.*;
    import core.settings.interfaces.*;
    import flash.events.*;
    
    public class SettingsBC416 extends core.settings.Settings implements core.settings.interfaces.ISpeedUnit, core.settings.interfaces.IWheelSize1, core.settings.interfaces.IWheelSize1Mode, core.settings.interfaces.ITireSize1
    {
        public function SettingsBC416(arg1:flash.events.IEventDispatcher=null)
        {
            _tireSize = core.general.TireSize.S_16INCH;
            _selectionMode = core.general.WheelSizeSelectionMode.MANUAL;
            super(arg1);
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

        public function get tireSize1():core.general.TireSize
        {
            return _tireSize;
        }

        public function set tireSize1(arg1:core.general.TireSize):void
        {
            _tireSize = arg1;
            return;
        }

        public function get wheelSize1():int
        {
            return _wheelSize1;
        }

        public function set wheelSize1(arg1:int):void
        {
            _wheelSize1 = arg1;
            return;
        }

        public function get wheelSize1Max():int
        {
            return 3999;
        }

        public function get wheelSize1Min():int
        {
            return 500;
        }

        public function get wheelSize1Mode():core.general.WheelSizeSelectionMode
        {
            return _selectionMode;
        }

        public function set wheelSize1Mode(arg1:core.general.WheelSizeSelectionMode):void
        {
            _selectionMode = arg1;
            return;
        }

        internal var _speedUnit:String="kmh";

        internal var _tireSize:core.general.TireSize;

        internal var _wheelSize1:int=2195;

        internal var _selectionMode:core.general.WheelSizeSelectionMode;
    }
}


//  class SettingsBC416ATS
package core.settings 
{
    import flash.events.*;
    
    public class SettingsBC416ATS extends core.settings.SettingsBC416
    {
        public function SettingsBC416ATS(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            return;
        }
    }
}


//  class SettingsBC509
package core.settings 
{
    import core.settings.interfaces.*;
    import flash.events.*;
    
    public class SettingsBC509 extends core.settings.SettingsTopline2009 implements core.settings.interfaces.IAutoScan
    {
        public function SettingsBC509(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            wheelSize1 = 2155;
            speedUnit = "kmh";
            return;
        }

        public function get scanFlagOn():Boolean
        {
            return _scanFlagOn;
        }

        public function set scanFlagOn(arg1:Boolean):void
        {
            if (arg1 != _scanFlagOn) 
            {
                _scanFlagOn = arg1;
                dispatchEvent(new flash.events.Event("scanFlagOnChange"));
            }
            return;
        }

        internal var _scanFlagOn:Boolean=false;
    }
}


//  class SettingsBC512
package core.settings 
{
    import core.settings.interfaces.*;
    import flash.events.*;
    
    public class SettingsBC512 extends core.settings.SettingsTopline2012 implements core.settings.interfaces.IAutoScan, core.settings.interfaces.IService, core.settings.interfaces.ILanguage, core.settings.interfaces.ILowBatDetectLevel
    {
        public function SettingsBC512(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            wheelSize1 = 2155;
            speedUnit = "kmh";
            return;
        }

        public function get language():String
        {
            return _language;
        }

        public function set language(arg1:String):void
        {
            if (arg1 != _language) 
            {
                _language = arg1;
                dispatchEvent(new flash.events.Event("languageChange"));
            }
            return;
        }

        public function get lowBatDetectLevel():String
        {
            return _lowBatDetectLevel;
        }

        public function set lowBatDetectLevel(arg1:String):void
        {
            if (arg1 != _lowBatDetectLevel) 
            {
                _lowBatDetectLevel = arg1;
                dispatchEvent(new flash.events.Event("lowBatDetectLevelChange"));
            }
            return;
        }

        public function get scanFlagOn():Boolean
        {
            return _scanFlagOn;
        }

        public function set scanFlagOn(arg1:Boolean):void
        {
            if (arg1 != _scanFlagOn) 
            {
                _scanFlagOn = arg1;
                dispatchEvent(new flash.events.Event("scanFlagOnChange"));
            }
            return;
        }

        public function get serviceInterval():int
        {
            return _serviceInterval;
        }

        public function set serviceInterval(arg1:int):void
        {
            if (arg1 != _serviceInterval) 
            {
                _serviceInterval = arg1;
                dispatchEvent(new flash.events.Event("serviceIntervalChange"));
            }
            return;
        }

        public function get serviceStatusOn():Boolean
        {
            return _serviceStatusOn;
        }

        public function set serviceStatusOn(arg1:Boolean):void
        {
            if (arg1 != _serviceStatusOn) 
            {
                _serviceStatusOn = arg1;
                dispatchEvent(new flash.events.Event("serviceStatusOnChange"));
            }
            return;
        }

        public override function toString():String
        {
            return "[SettingsBC512 extends SettingsTopline2012]";
        }

        internal var _language:String="en";

        internal var _lowBatDetectLevel:String="N/A";

        internal var _scanFlagOn:Boolean=false;

        internal var _serviceInterval:int=750;

        internal var _serviceStatusOn:Boolean=false;
    }
}


//  class SettingsBC516
package core.settings 
{
    import core.settings.interfaces.*;
    import flash.events.*;
    
    public class SettingsBC516 extends core.settings.SettingsTopline2016 implements core.settings.interfaces.IAutoScan
    {
        public function SettingsBC516(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            return;
        }

        public function get scanFlagOn():Boolean
        {
            return _scanFlagOn;
        }

        public function set scanFlagOn(arg1:Boolean):void
        {
            _scanFlagOn = arg1;
            return;
        }

        internal var _scanFlagOn:Boolean;
    }
}


//  class SettingsBC716
package core.settings 
{
    import core.settings.interfaces.*;
    import flash.events.*;
    
    public class SettingsBC716 extends core.settings.SettingsTopline2016 implements core.settings.interfaces.IAutoScan, core.settings.interfaces.ILanguage
    {
        public function SettingsBC716(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            return;
        }

        public function get language():String
        {
            return _language;
        }

        public function set language(arg1:String):void
        {
            _language = arg1;
            return;
        }

        public function get scanFlagOn():Boolean
        {
            return _scanFlagOn;
        }

        public function set scanFlagOn(arg1:Boolean):void
        {
            _scanFlagOn = arg1;
            return;
        }

        internal var _language:String="en";

        internal var _scanFlagOn:Boolean;
    }
}


//  class SettingsBC716ATS
package core.settings 
{
    import flash.events.*;
    
    public class SettingsBC716ATS extends core.settings.SettingsBC716
    {
        public function SettingsBC716ATS(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            return;
        }
    }
}


//  class SettingsBC812
package core.settings 
{
    import core.settings.interfaces.*;
    import flash.events.*;
    
    public class SettingsBC812 extends core.settings.SettingsTopline2012 implements core.settings.interfaces.IService, core.settings.interfaces.ILanguage, core.settings.interfaces.ILowBatDetectLevel
    {
        public function SettingsBC812(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            wheelSize1 = 2155;
            speedUnit = "kmh";
            return;
        }

        public function get language():String
        {
            return _language;
        }

        public function set language(arg1:String):void
        {
            if (arg1 != _language) 
            {
                _language = arg1;
                dispatchEvent(new flash.events.Event("languageChange"));
            }
            return;
        }

        public function get lowBatDetectLevel():String
        {
            return _lowBatDetectLevel;
        }

        public function set lowBatDetectLevel(arg1:String):void
        {
            if (arg1 != _lowBatDetectLevel) 
            {
                _lowBatDetectLevel = arg1;
                dispatchEvent(new flash.events.Event("lowBatDetectLevelChange"));
            }
            return;
        }

        public function get serviceInterval():int
        {
            return _serviceInterval;
        }

        public function set serviceInterval(arg1:int):void
        {
            if (arg1 != _serviceInterval) 
            {
                _serviceInterval = arg1;
                dispatchEvent(new flash.events.Event("serviceIntervalChange"));
            }
            return;
        }

        public function get serviceStatusOn():Boolean
        {
            return _serviceStatusOn;
        }

        public function set serviceStatusOn(arg1:Boolean):void
        {
            if (arg1 != _serviceStatusOn) 
            {
                _serviceStatusOn = arg1;
                dispatchEvent(new flash.events.Event("serviceStatusOnChange"));
            }
            return;
        }

        public override function toString():String
        {
            return "[SettingsBC812 extends SettingsTopline2012]";
        }

        internal var _language:String="en";

        internal var _lowBatDetectLevel:String="N/A";

        internal var _serviceInterval:int=750;

        internal var _serviceStatusOn:Boolean=false;
    }
}


//  class SettingsBC916
package core.settings 
{
    import core.settings.interfaces.*;
    import flash.events.*;
    
    public class SettingsBC916 extends core.settings.SettingsTopline2016 implements core.settings.interfaces.ILanguage
    {
        public function SettingsBC916(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            return;
        }

        public function get language():String
        {
            return _language;
        }

        public function set language(arg1:String):void
        {
            _language = arg1;
            return;
        }

        internal var _language:String="en";
    }
}


//  class SettingsBC916ATS
package core.settings 
{
    import flash.events.*;
    
    public class SettingsBC916ATS extends core.settings.SettingsBC916
    {
        public function SettingsBC916ATS(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            return;
        }
    }
}


//  class SettingsBikeComputer
package core.settings 
{
    import core.settings.interfaces.*;
    import flash.events.*;
    
    public class SettingsBikeComputer extends core.settings.Settings implements core.settings.interfaces.ISpeedUnit, core.settings.interfaces.IClock
    {
        public function SettingsBikeComputer(arg1:flash.events.IEventDispatcher=null)
        {
            _clock = new Date(new Date().fullYear, 0, 1);
            super(arg1);
            return;
        }

        public function get clock():Date
        {
            return _clock;
        }

        public function set clock(arg1:Date):void
        {
            if (_clock !== arg1) 
            {
                _clock = arg1;
                dispatchEvent(new flash.events.Event("clockChange"));
            }
            return;
        }

        public function get speedUnit():String
        {
            return _speedUnit;
        }

        public function set speedUnit(arg1:String):void
        {
            if (_speedUnit !== arg1) 
            {
                _speedUnit = arg1;
                dispatchEvent(new flash.events.Event("speedUnitChange"));
            }
            return;
        }

        public override function toString():String
        {
            return "[SettingsBikeComputer extends Settings implements IMeasurement, IClock, IWheelSize1]";
        }

        internal var _clock:Date;

        internal var _speedUnit:String="kmh";
    }
}


//  class SettingsFactory
package core.settings 
{
    import core.general.*;
    
    public class SettingsFactory extends Object
    {
        public function SettingsFactory()
        {
            super();
            return;
        }

        public static function createSettingsFromSSF(arg1:XML):core.settings.Settings
        {
            var loc2:*=null;
            var loc1:*=core.general.UnitType.fromString(arg1.GeneralInformation.@unit);
            try 
            {
                loc2 = unitSwitch(loc1);
            }
            catch (e:Error)
            {
                var loc4:*=null;
                return loc4;
            }
            if (loc2 != null) 
            {
                core.settings.SettingsMapper.fromXML(arg1, loc2);
            }
            return loc2;
        }

        public static function createSettingsFromUnitType(arg1:core.general.UnitType):core.settings.Settings
        {
            return unitSwitch(arg1);
        }

        public static function createSettingsFromDB(arg1:Object, arg2:core.general.UnitType):core.settings.Settings
        {
            var loc1:*=unitSwitch(arg2);
            core.settings.SettingsMapper.fromDB(loc1, arg1);
            return loc1;
        }

        internal static function unitSwitch(arg1:core.general.UnitType):core.settings.Settings
        {
            var loc1:*=null;
            var loc2:*=arg1.toString();
            while (core.general.UnitType.BC509.toString() === loc2) 
            {
                loc1 = new core.settings.SettingsBC509();
            }
        }
    }
}


//  class SettingsGps10
package core.settings 
{
    import core.*;
    import core.general.*;
    import core.settings.interfaces.*;
    import flash.events.*;
    
    public class SettingsGps10 extends core.settings.SettingsBikeComputer implements core.settings.interfaces.IClockMode, core.settings.interfaces.ILanguage, core.settings.interfaces.IAutoPause, core.settings.interfaces.IAltitudeReference, core.settings.interfaces.IContrast, core.settings.interfaces.IDateFormat, core.settings.interfaces.ITemperatureUnit, core.settings.interfaces.IAltitudeUnit, core.settings.interfaces.INfc, core.settings.interfaces.ISystemTone, core.settings.interfaces.IActualAltitude, core.settings.interfaces.ISeaLevel, core.settings.interfaces.IHomeAltitude1, core.settings.interfaces.IHomeAltitude2, core.settings.interfaces.IMyName, core.settings.interfaces.IAutoLapBasedOnDistance, core.settings.interfaces.ITimeZone, core.settings.interfaces.ISummerTime
    {
        public function SettingsGps10(arg1:flash.events.IEventDispatcher=null)
        {
            _altitudeReference = core.general.AltitudeReference.ACTUAL_ALTITUDE;
            super(arg1);
            return;
        }

        public function get temperatureUnit():String
        {
            return _temperatureUnit;
        }

        public function get actualAltitude():int
        {
            return _actualAltitude;
        }

        public function set actualAltitude(arg1:int):void
        {
            if (arg1 != _actualAltitude) 
            {
                _actualAltitude = arg1;
                dispatchEvent(new flash.events.Event("actualAltitudeChange"));
            }
            return;
        }

        public function get actualAltitudeMax():int
        {
            if (altitudeUnit == "meter") 
            {
                return 4999000;
            }
            return 5181295;
        }

        public function get actualAltitudeMin():int
        {
            if (altitudeUnit == "meter") 
            {
                return -999000;
            }
            return -304495;
        }

        public function set systemTone(arg1:Boolean):void
        {
            if (arg1 != _systemTone) 
            {
                _systemTone = arg1;
                dispatchEvent(new flash.events.Event("systemToneChange"));
            }
            return;
        }

        public function get altitudeReference():String
        {
            return _altitudeReference;
        }

        public function set altitudeReference(arg1:String):void
        {
            if (_altitudeReference !== arg1) 
            {
                _altitudeReference = arg1;
                dispatchEvent(new flash.events.Event("altitudeReferenceChange"));
            }
            return;
        }

        public function get systemTone():Boolean
        {
            return _systemTone;
        }

        public function get altitudeUnit():String
        {
            return _altitudeUnit;
        }

        public function set altitudeUnit(arg1:String):void
        {
            if (arg1 != _altitudeUnit) 
            {
                _altitudeUnit = arg1;
                dispatchEvent(new flash.events.Event("altitudeUnitChange"));
            }
            return;
        }

        public function set summerTime(arg1:Boolean):void
        {
            if (arg1 != _summerTime) 
            {
                _summerTime = arg1;
                dispatchEvent(new flash.events.Event("summerTimeChange"));
            }
            return;
        }

        public function get autoLapDistance():uint
        {
            return _autoLapDistance;
        }

        public function set autoLapDistance(arg1:uint):void
        {
            if (arg1 > autoLapDistanceMax) 
            {
                arg1 = autoLapDistanceMax;
            }
            if (arg1 < autoLapDistanceMin) 
            {
                arg1 = autoLapDistanceMin;
            }
            _autoLapDistance = arg1;
            return;
        }

        public function get autoLapDistanceMax():uint
        {
            var loc1:*=core.MeasurementConfig.distanceFormat;
            while ("kilometer" === loc1) 
            {
                return 99900000;
            }
        }

        public function get autoLapDistanceMin():uint
        {
            var loc1:*=core.MeasurementConfig.distanceFormat;
            while ("kilometer" === loc1) 
            {
                return 100000;
            }
        }

        public function get seaLevelMin():Number
        {
            return 900;
        }

        public function get autoPause():Boolean
        {
            return _autoPause;
        }

        public function set autoPause(arg1:Boolean):void
        {
            if (arg1 != _autoPause) 
            {
                _autoPause = arg1;
                dispatchEvent(new flash.events.Event("autoPauseChange"));
            }
            return;
        }

        public function get seaLevelMax():Number
        {
            return 1050;
        }

        public function get clockMode():String
        {
            return _clockMode;
        }

        public function set clockMode(arg1:String):void
        {
            if (arg1 != _clockMode) 
            {
                _clockMode = arg1;
                dispatchEvent(new flash.events.Event("clockModeChange"));
            }
            return;
        }

        public function set seaLevel(arg1:Number):void
        {
            if (arg1 != _seaLevel) 
            {
                _seaLevel = arg1;
                dispatchEvent(new flash.events.Event("seaLevelChange"));
            }
            return;
        }

        public function get contrast():int
        {
            return _contrast;
        }

        public function set contrast(arg1:int):void
        {
            if (arg1 != _contrast) 
            {
                _contrast = arg1;
                dispatchEvent(new flash.events.Event("contrastChange"));
            }
            return;
        }

        public function get contrastMax():int
        {
            return 3;
        }

        public function get contrastMin():int
        {
            return 1;
        }

        public function get seaLevel():Number
        {
            return _seaLevel;
        }

        public function get dateFormat():String
        {
            return _dateFormat;
        }

        public function set dateFormat(arg1:String):void
        {
            if (arg1 != _dateFormat) 
            {
                _dateFormat = arg1;
                dispatchEvent(new flash.events.Event("dateFormatChange"));
            }
            return;
        }

        public function set nfcActive(arg1:Boolean):void
        {
            _nfcActive = arg1;
            return;
        }

        public function get homeAltitude1():int
        {
            return _homeAltitude1;
        }

        public function set homeAltitude1(arg1:int):void
        {
            if (arg1 != _homeAltitude1) 
            {
                _homeAltitude1 = arg1;
                dispatchEvent(new flash.events.Event("homeAltitude1Change"));
            }
            return;
        }

        public function get homeAltitude1Max():int
        {
            if (core.MeasurementConfig.altitudeFormat == "meter") 
            {
                return 4999000;
            }
            return 5181295;
        }

        public function get homeAltitude1Min():int
        {
            if (core.MeasurementConfig.altitudeFormat == "meter") 
            {
                return -9990000;
            }
            return -304495;
        }

        public function get summerTime():Boolean
        {
            return _summerTime;
        }

        public function get homeAltitude2():int
        {
            return _homeAltitude2;
        }

        public function set homeAltitude2(arg1:int):void
        {
            if (arg1 != _homeAltitude2) 
            {
                _homeAltitude2 = arg1;
                dispatchEvent(new flash.events.Event("homeAltitude2Change"));
            }
            return;
        }

        public function get homeAltitude2Max():int
        {
            return homeAltitude1Max;
        }

        public function get homeAltitude2Min():int
        {
            return homeAltitude1Min;
        }

        public function get nfcActive():Boolean
        {
            return _nfcActive;
        }

        public function get language():String
        {
            return _language;
        }

        public function set language(arg1:String):void
        {
            if (arg1 != _language) 
            {
                _language = arg1;
                dispatchEvent(new flash.events.Event("languageChange"));
            }
            return;
        }

        public function get myNameMaxLength():uint
        {
            return 9;
        }

        public function get myName():String
        {
            return _myName;
        }

        public function set myName(arg1:String):void
        {
            if (arg1 != _myName) 
            {
                _myName = arg1;
                dispatchEvent(new flash.events.Event("myNameChange"));
            }
            return;
        }

        public function set temperatureUnit(arg1:String):void
        {
            if (arg1 != _temperatureUnit) 
            {
                _temperatureUnit = arg1;
                dispatchEvent(new flash.events.Event("temperatureUnitChange"));
            }
            return;
        }

        public function get timeZone():int
        {
            return _timeZone;
        }

        public function set timeZone(arg1:int):void
        {
            if (arg1 != _timeZone) 
            {
                _timeZone = arg1;
                dispatchEvent(new flash.events.Event("timeZoneChange"));
            }
            return;
        }

        internal const _myNameMaxLength:uint=9;

        public static const ACT_ALTIFT_MAX:int=5181295;

        public static const ACT_ALTIFT_MIN:int=-304495;

        public static const ACT_ALTIM_MAX:int=4999000;

        public static const ACT_ALTIM_MIN:int=-999000;

        public static const CALORIES_MAX:int=99999;

        public static const CALORIES_MIN:int=0;

        public static const CONTRAST_MAX:int=3;

        public static const CONTRAST_MIN:int=1;

        public static const DISTANCE1_MAX_KM:int=99999000;

        public static const DISTANCE2_MAX_KM:int=99999000;

        public static const DISTANCE1_MAX_MI:Number=160932790.656;

        public static const DISTANCE2_MAX_MI:Number=160932790.656;

        public static const DISTANCE1_MIN:Number=0;

        public static const HOME_ALTITUDE_FT_MAX_IN_MM:int=5181295;

        public static const HOME_ALTITUDE_FT_MIN_IN_MM:int=-304495;

        public static const HOME_ALTITUDE_M_MAX_IN_MM:int=4999000;

        public static const HOME_ALTITUDE_M_MIN_IN_MM:int=-9990000;

        public static const SEA_LEVEL_MAX:int=1050;

        public static const SEA_LEVEL_MIN:int=900;

        public static const TOTALTIMEBIKE1_MAX:uint=3599999900;

        public static const TOTAL_ALTI_1_MAX_M:int=99999000;

        public static const TOTAL_ALTI_1_MIN:int=0;

        internal static const AUTOLAP_DISTANCE_MAX_KM:uint=99900000;

        internal static const AUTOLAP_DISTANCE_MAX_MILE:uint=99900000;

        internal static const AUTOLAP_DISTANCE_MIN_KM:uint=100000;

        internal static const AUTOLAP_DISTANCE_MIN_MILE:uint=100000;

        internal var _autoLapDistance:uint;

        internal var _systemTone:Boolean=false;

        internal var _altitudeUnit:String="meter";

        internal var _altitudeReference:String;

        internal var _temperatureUnit:String="";

        internal var _actualAltitude:int=250000;

        internal var _myName:String="Pure GPS";

        internal var _timeZone:int=104;

        internal var _nfcActive:Boolean=true;

        internal var _language:String="en";

        internal var _homeAltitude1:int=100;

        internal var _seaLevel:Number=1013;

        internal var _dateFormat:String="eu";

        internal var _contrast:int=2;

        internal var _clockMode:String="24";

        internal var _autoPause:Boolean=true;

        internal var _summerTime:Boolean=true;

        internal var _homeAltitude2:int=200;
    }
}


//  class SettingsMapper
package core.settings 
{
    import __AS3__.vec.*;
    import core.general.*;
    import core.settings.interfaces.*;
    import core.training.type.*;
    import core.units.*;
    import core.units.interfaces.*;
    import database.*;
    import handler.*;
    import utils.*;
    import utils.format.*;
    
    public class SettingsMapper extends Object
    {
        public function SettingsMapper()
        {
            super();
            return;
        }

        public static function getInsertStatement(arg1:Array):String
        {
            return "INSERT OR REPLACE INTO Settings (" + arg1.toString() + ") VALUES (:" + arg1.join(", :") + ");";
        }

        public static function selectPrimaryKeyFromGUID(arg1:core.settings.Settings):String
        {
            return "SELECT settingsId FROM Settings WHERE GUID = \'" + arg1.GUID + "\'";
        }

        public static function generateDBCreateTable(arg1:uint):database.DatabaseTable
        {
            var loc1:*=null;
            var loc2:*=arg1;
            while (400 === loc2) 
            {
                DB_TABLE_400 = new database.DatabaseTable("Settings");
                DB_TABLE_400.addColumns([["settingsId", "INTEGER", false, true, true], ["GUID", "VARCHAR UNIQUE", false], ["unitGUID", "VARCHAR", true], ["modificationDate", "NUMERIC", false], ["isDeleted", "BOOL", true], ["actualAltitude", "INTEGER", true], ["age", "INTEGER", true], ["alarm", "VARCHAR", true], ["alarmMode", "VARCHAR", true], ["altitudeReference", "VARCHAR", true], ["altitudeUnit", "VARCHAR", true], ["autoPause", "BOOL", true], ["autoZoomTrack", "BOOL", true], ["autoOffTime", "VARCHAR", true], ["backlightTime", "NUMERIC", true], ["bikeType1", "VARCHAR", true], ["bikeType2", "VARCHAR", true], ["bikeType3", "VARCHAR", true], ["bikeWeight1", "NUMERIC", true], ["bikeWeight1Unit", "VARCHAR", true], ["bikeWeight2", "NUMERIC", true], ["bikeWeight2Unit", "VARCHAR", true], ["bikeWeight3", "NUMERIC", true], ["birthDate", "VARCHAR", true], ["bodyHeight", "NUMERIC", true], ["bodyHeightUnit", "VARCHAR", true], ["bodyWeight", "NUMERIC", true], ["bodyWeightUnit", "VARCHAR", true], ["buttonInfo", "BOOL", true], ["buttonTone", "BOOL", true], ["calibration", "BOOL", true], ["clockMode", "VARCHAR", true], ["contrast", "INTEGER", true], ["correctionFactor", "NUMERIC", true], ["countdown", "NUMERIC", true], ["countdownOn", "BOOL", true], ["date", "VARCHAR", true], ["dateFormat", "VARCHAR", true], ["distanceUnit", "VARCHAR", true], ["endZone3", "INTEGER", true], ["favoritesAltitude1_1_A", "VARCHAR", true], ["favoritesAltitude1_1_B", "VARCHAR", true], ["favoritesAltitude1_2_A", "VARCHAR", true], ["favoritesAltitude1_2_B", "VARCHAR", true], ["favoritesAltitude1_3_A", "VARCHAR", true], ["favoritesAltitude1_3_B", "VARCHAR", true], ["favoritesAltitude2_1_A", "VARCHAR", true], ["favoritesAltitude2_1_B", "VARCHAR", true], ["favoritesAltitude2_2_A", "VARCHAR", true], ["favoritesAltitude2_2_B", "VARCHAR", true], ["favoritesAltitude2_3_A", "VARCHAR", true], ["favoritesAltitude2_3_B", "VARCHAR", true], ["favoritesLap1_1_A", "VARCHAR", true], ["favoritesLap1_1_B", "VARCHAR", true], ["favoritesLap1_2_A", "VARCHAR", true], ["favoritesLap1_2_B", "VARCHAR", true], ["favoritesLap1_3_A", "VARCHAR", true], ["favoritesLap1_3_B", "VARCHAR", true], ["favoritesLap2_1_A", "VARCHAR", true], ["favoritesLap2_1_B", "VARCHAR", true], ["favoritesLap2_2_A", "VARCHAR", true], ["favoritesLap2_2_B", "VARCHAR", true], ["favoritesLap2_3_A", "VARCHAR", true], ["favoritesLap2_3_B", "VARCHAR", true], ["favoritesSelected", "INTEGER", true], ["favoritesTrack1_1_A", "VARCHAR", true], ["favoritesTrack1_1_B", "VARCHAR", true], ["favoritesTrack1_2_A", "VARCHAR", true], ["favoritesTrack1_2_B", "VARCHAR", true], ["favoritesTrack1_3_A", "VARCHAR", true], ["favoritesTrack1_3_B", "VARCHAR", true], ["favoritesTrack2_1_A", "VARCHAR", true], ["favoritesTrack2_1_B", "VARCHAR", true], ["favoritesTrack2_2_A", "VARCHAR", true], ["favoritesTrack2_2_B", "VARCHAR", true], ["favoritesTrack2_3_A", "VARCHAR", true], ["favoritesTrack2_3_B", "VARCHAR", true], ["favoritesCustomA_PageCount", "INTEGER", true], ["favoritesCustom1_A", "VARCHAR", true], ["favoritesCustom2_A", "VARCHAR", true], ["favoritesCustom3_A", "VARCHAR", true], ["favoritesCustom4_A", "VARCHAR", true], ["favoritesCustom5_A", "VARCHAR", true], ["favoritesCustom6_A", "VARCHAR", true], ["favoritesCustomB_PageCount", "INTEGER", true], ["favoritesCustom1_B", "VARCHAR", true], ["favoritesCustom2_B", "VARCHAR", true], ["favoritesCustom3_B", "VARCHAR", true], ["favoritesCustom4_B", "VARCHAR", true], ["favoritesCustom5_B", "VARCHAR", true], ["favoritesCustom6_B", "VARCHAR", true], ["favoritesTrip1_0", "VARCHAR", true], ["favoritesTrip1_1", "VARCHAR", true], ["favoritesTrip1_2", "VARCHAR", true], ["favoritesTrip1_3", "VARCHAR", true], ["favoritesTrip1_4", "VARCHAR", true], ["favoritesTrip1_5", "VARCHAR", true], ["favoritesTrip1_6", "VARCHAR", true], ["favoritesTrip1_7", "VARCHAR", true], ["favoritesTrip1_8", "VARCHAR", true], ["favoritesTrip1_9", "VARCHAR", true], ["favoritesTrip2_0", "VARCHAR", true], ["favoritesTrip2_1", "VARCHAR", true], ["favoritesTrip2_2", "VARCHAR", true], ["favoritesTrip2_3", "VARCHAR", true], ["favoritesTrip2_4", "VARCHAR", true], ["favoritesTrip2_5", "VARCHAR", true], ["favoritesTrip2_6", "VARCHAR", true], ["favoritesTrip2_7", "VARCHAR", true], ["favoritesTrip2_8", "VARCHAR", true], ["favoritesTrip2_9", "VARCHAR", true], ["freeTrainingTargetZone", "VARCHAR", true], ["freeTrainingTargetZoneLowerLimit", "INTEGER", true], ["freeTrainingTargetZoneUpperLimit", "INTEGER", true], ["fuelConsumption", "NUMERIC", true], ["gender", "VARCHAR", true], ["gpsFormat", "VARCHAR", true], ["gpsStatus", "BOOL", true], ["homeAltitude1", "INTEGER", true], ["homeAltitude2", "INTEGER", true], ["homeAltitude3", "INTEGER", true], ["hrMax", "INTEGER", true], ["intensityZone1", "INTEGER", true], ["intensityZone2", "INTEGER", true], ["intensityZone3", "INTEGER", true], ["intensityZone4", "INTEGER", true], ["intensityZone4End", "INTEGER", true], ["intervalCoolDownTargetZoneLowerLimit", "INTEGER", true], ["intervalCoolDownTargetZoneUpperLimit", "INTEGER", true], ["intervalCoolDownTime", "INTEGER", true], ["intervalRecoveryHR", "INTEGER", true], ["intervalRecoveryMode", "VARCHAR", true], ["intervalRecoveryTime", "INTEGER", true], ["intervalTargetZoneLowerLimit", "INTEGER", true], ["intervalTargetZoneUpperLimit", "INTEGER", true], ["intervalTime", "INTEGER", true], ["intervalWarmUpTargetZoneLowerLimit", "INTEGER", true], ["intervalWarmUpTargetZoneUpperLimit", "INTEGER", true], ["intervalWarmUpTime", "INTEGER", true], ["language", "VARCHAR", true], ["lowBatDetectLevel", "VARCHAR", true], ["lowerLimit", "INTEGER", true], ["measurement", "VARCHAR", true], ["myName", "VARCHAR", true], ["name", "VARCHAR", true], ["offTrackAlarm", "NUMERIC", true], ["powerMeterFormula", "INTEGER", true], ["powerTargetZoneEnabled", "BOOL", true], ["powerTargetZoneLowerLimit", "INTEGER", true], ["powerTargetZoneUpperLimit", "INTEGER", true], ["powerIntensityZone1Start", "INTEGER", true], ["powerIntensityZone2Start", "INTEGER", true], ["powerIntensityZone3Start", "INTEGER", true], ["powerIntensityZone4Start", "INTEGER", true], ["powerIntensityZone5Start", "INTEGER", true], ["powerIntensityZone6Start", "INTEGER", true], ["powerIntensityZone7Start", "INTEGER", true], ["powerIntensityZone7End", "INTEGER", true], ["samplingRate", "NUMERIC", true], ["scanFlagOn", "BOOL", true], ["seaLevel", "NUMERIC", true], ["serviceInterval", "INTEGER", true], ["serviceStatusOn", "BOOL", true], ["shoulderWidth", "NUMERIC", true], ["shoulderWidthUnit", "VARCHAR", true], ["showTotals", "INTEGER", true], ["startZone1", "INTEGER", true], ["startZone2", "INTEGER", true], ["startZone3", "INTEGER", true], ["summerTime", "BOOL", true], ["systemTone", "BOOL", true], ["temperatureUnit", "VARCHAR", true], ["timeZone", "INTEGER", true], ["trainingZone", "VARCHAR", true], ["upperLimit", "INTEGER", true], ["volume", "INTEGER", true], ["waypointAlarm", "NUMERIC", true], ["wheelSize1", "INTEGER", true], ["wheelSize2", "INTEGER", true], ["wheelSize3", "INTEGER", true], ["yearOfBirth", "INTEGER", true], ["zoneAlarm", "BOOL", true], ["phaseAlarm", "BOOL", true], ["keyLock", "BOOL", true], ["emptyField1", "NUMERIC", true], ["emptyField2", "NUMERIC", true], ["emptyField3", "NUMERIC", true], ["emptyField4", "NUMERIC", true], ["emptyField5", "VARCHAR", true], ["emptyField6", "VARCHAR", true], ["emptyField7", "VARCHAR", true], ["emptyField8", "VARCHAR", true]]);
                loc1 = DB_TABLE_400;
            }
        }

        public static function fromDB(arg1:core.settings.Settings, arg2:Object):void
        {
            var loc6:*=0;
            var loc7:*=0;
            var loc1:*=undefined;
            var loc8:*=undefined;
            var loc2:*=undefined;
            var loc4:*=undefined;
            var loc5:*=undefined;
            arg1.settingsId = arg2["settingsId"];
            arg1.GUID = arg2["GUID"];
            arg1.unitGUID = arg2["unitGUID"];
            arg1.modificationDate = arg2.modificationDate;
            arg1.isDeleted = arg2.isDeleted;
            arg1.date = new Date(arg2["date"]);
            arg1.name = arg2["name"];
            if (arg1 is core.settings.interfaces.IActualAltitude) 
            {
                var loc9:*;
                (arg1 as core.settings.interfaces.IActualAltitude).actualAltitude = loc9 = arg2["actualAltitude"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IAge) 
            {
                (arg1 as core.settings.interfaces.IAge).age = loc9 = arg2["age"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IAlarm) 
            {
                (arg1 as core.settings.interfaces.IAlarm).alarm = loc9 = new Date(arg2["alarm"]);
            }
            undefined;
            if (arg1 is core.settings.interfaces.IAlarmMode) 
            {
                (arg1 as core.settings.interfaces.IAlarmMode).alarmMode = loc9 = arg2["alarmMode"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IAltitudeReference) 
            {
                (arg1 as core.settings.interfaces.IAltitudeReference).altitudeReference = loc9 = arg2["altitudeReference"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IAltitudeUnit) 
            {
                (arg1 as core.settings.interfaces.IAltitudeUnit).altitudeUnit = loc9 = arg2["altitudeUnit"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IAutoPause) 
            {
                (arg1 as core.settings.interfaces.IAutoPause).autoPause = loc9 = arg2["autoPause"] != 0 ? true : false;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IAutoZoomTrack) 
            {
                (arg1 as core.settings.interfaces.IAutoZoomTrack).autoZoomTrack = loc9 = arg2["autoZoomTrack"] != 0 ? true : false;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IAutoOffTime) 
            {
                (arg1 as core.settings.interfaces.IAutoOffTime).autoOffTime = loc9 = core.general.AutoOffTimeUnit.fromString(arg2["autoOffTime"]);
            }
            undefined;
            if (arg1 is core.settings.interfaces.IBacklightTime) 
            {
                (arg1 as core.settings.interfaces.IBacklightTime).backlightTime = loc9 = arg2["backlightTime"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IBacklightLevel) 
            {
                (arg1 as core.settings.interfaces.IBacklightLevel).backlightLevel = loc9 = arg2["backlightLevel"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IBikeType1) 
            {
                (arg1 as core.settings.interfaces.IBikeType1).bikeType1 = loc9 = arg2["bikeType1"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IBikeType2) 
            {
                (arg1 as core.settings.interfaces.IBikeType2).bikeType2 = loc9 = arg2["bikeType2"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IBikeType3) 
            {
                (arg1 as core.settings.interfaces.IBikeType3).bikeType3 = loc9 = arg2["bikeType3"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IBikeWeight1) 
            {
                (arg1 as core.settings.interfaces.IBikeWeight1).bikeWeight1 = loc9 = arg2["bikeWeight1"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IBikeWeight1Unit) 
            {
                (arg1 as core.settings.interfaces.IBikeWeight1Unit).bikeWeight1Unit = loc9 = arg2["bikeWeight1Unit"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IBikeWeight2) 
            {
                (arg1 as core.settings.interfaces.IBikeWeight2).bikeWeight2 = loc9 = arg2["bikeWeight2"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IBikeWeight2Unit) 
            {
                (arg1 as core.settings.interfaces.IBikeWeight2Unit).bikeWeight2Unit = loc9 = arg2["bikeWeight2Unit"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IBikeWeight3) 
            {
                (arg1 as core.settings.interfaces.IBikeWeight3).bikeWeight3 = loc9 = arg2["bikeWeight3"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IBirthDate) 
            {
                (arg1 as core.settings.interfaces.IBirthDate).birthDate = loc9 = new Date(arg2["birthDate"]);
            }
            undefined;
            if (arg1 is core.settings.interfaces.IBodyHeight) 
            {
                (arg1 as core.settings.interfaces.IBodyHeight).bodyHeight = loc9 = arg2["bodyHeight"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IBodyHeightUnit) 
            {
                (arg1 as core.settings.interfaces.IBodyHeightUnit).bodyHeightUnit = loc9 = arg2["bodyHeightUnit"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IBodyWeight) 
            {
                (arg1 as core.settings.interfaces.IBodyWeight).bodyWeight = loc9 = arg2["bodyWeight"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IBodyWeightUnit) 
            {
                (arg1 as core.settings.interfaces.IBodyWeightUnit).bodyWeightUnit = loc9 = arg2["bodyWeightUnit"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IButtonInfo) 
            {
                (arg1 as core.settings.interfaces.IButtonInfo).buttonInfo = loc9 = arg2["buttonInfo"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IButtonTone) 
            {
                (arg1 as core.settings.interfaces.IButtonTone).buttonTone = loc9 = arg2["buttonTone"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.ICalibration) 
            {
                (arg1 as core.settings.interfaces.ICalibration).calibration = loc9 = arg2["calibration"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IClockMode) 
            {
                (arg1 as core.settings.interfaces.IClockMode).clockMode = loc9 = arg2["clockMode"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IContrast) 
            {
                (arg1 as core.settings.interfaces.IContrast).contrast = loc9 = arg2["contrast"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.ICorrectionFactor) 
            {
                (arg1 as core.settings.interfaces.ICorrectionFactor).correctionFactor = loc9 = arg2["correctionFactor"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.ICountdown) 
            {
                (arg1 as core.settings.interfaces.ICountdown).countdown = loc9 = arg2["countdown"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.ICountdown) 
            {
                (arg1 as core.settings.interfaces.ICountdown).countdownOn = loc9 = arg2["countdownOn"] != 0 ? true : false;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IDateFormat) 
            {
                (arg1 as core.settings.interfaces.IDateFormat).dateFormat = loc9 = arg2["dateFormat"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IDistanceUnit) 
            {
                (arg1 as core.settings.interfaces.IDistanceUnit).distanceUnit = loc9 = arg2["distanceUnit"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IThreeZones) 
            {
                (arg1 as core.settings.interfaces.IThreeZones).endZone3 = loc9 = arg2["endZone3"];
            }
            undefined;
            if (arg1 is core.settings.SettingsROX100) 
            {
                (arg1 as core.settings.SettingsROX100).favoritesSelected = loc9 = arg2["favoritesSelected"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IFuelConsumption) 
            {
                (arg1 as core.settings.interfaces.IFuelConsumption).fuelConsumption = loc9 = arg2["fuelConsumption"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IFuelConsumptionUnit) 
            {
                (arg1 as core.settings.interfaces.IFuelConsumptionUnit).fuelConsumptionUnit = loc9 = arg2["fuelConsumptionUnit"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingFree) 
            {
                (arg1 as core.settings.interfaces.ITrainingFree).freeTrainingTargetZone = loc9 = arg2["freeTrainingTargetZone"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingFree) 
            {
                (arg1 as core.settings.interfaces.ITrainingFree).freeOwnZone1LowerLimit = loc9 = arg2["freeOwnZone1LowerLimit"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingFree) 
            {
                (arg1 as core.settings.interfaces.ITrainingFree).freeOwnZone1UpperLimit = loc9 = arg2["freeOwnZone1UpperLimit"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingFree) 
            {
                (arg1 as core.settings.interfaces.ITrainingFree).freeOwnZone2LowerLimit = loc9 = arg2["freeOwnZone2LowerLimit"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingFree) 
            {
                (arg1 as core.settings.interfaces.ITrainingFree).freeOwnZone2UpperLimit = loc9 = arg2["freeOwnZone2UpperLimit"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingFree) 
            {
                (arg1 as core.settings.interfaces.ITrainingFree).freeOwnZone3LowerLimit = loc9 = arg2["freeOwnZone3LowerLimit"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingFree) 
            {
                (arg1 as core.settings.interfaces.ITrainingFree).freeOwnZone3UpperLimit = loc9 = arg2["freeOwnZone3UpperLimit"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IGender) 
            {
                (arg1 as core.settings.interfaces.IGender).gender = loc9 = arg2["gender"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IGPSFormat) 
            {
                (arg1 as core.settings.interfaces.IGPSFormat).gpsFormat = loc9 = arg2["gpsFormat"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IGPSStatus) 
            {
                (arg1 as core.settings.interfaces.IGPSStatus).gpsStatus = loc9 = arg2["gpsStatus"] != 0 ? true : false;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IStravaSegmentsEnabled) 
            {
                (arg1 as core.settings.interfaces.IStravaSegmentsEnabled).stravaSegmentsEnabled = loc9 = arg2["stravaSegmentsEnabled"] != 0 ? true : false;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrackDirection) 
            {
                (arg1 as core.settings.interfaces.ITrackDirection).trackDirection = loc9 = arg2["trackDirection"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IHomeAltitude1) 
            {
                (arg1 as core.settings.interfaces.IHomeAltitude1).homeAltitude1 = loc9 = arg2["homeAltitude1"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IHomeAltitude2) 
            {
                (arg1 as core.settings.interfaces.IHomeAltitude2).homeAltitude2 = loc9 = arg2["homeAltitude2"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IHomeAltitude3) 
            {
                (arg1 as core.settings.interfaces.IHomeAltitude3).homeAltitude3 = loc9 = arg2["homeAltitude3"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IHRmax) 
            {
                (arg1 as core.settings.interfaces.IHRmax).hrMax = loc9 = arg2["hrMax"];
            }
            undefined;
            if (arg1 is core.units.interfaces.IIntensityZonesPercentage) 
            {
                (arg1 as core.units.interfaces.IIntensityZonesPercentage).intensityZone1PercentageStart = loc9 = arg2["intensityZone1"];
            }
            undefined;
            if (arg1 is core.units.interfaces.IIntensityZonesPercentage) 
            {
                (arg1 as core.units.interfaces.IIntensityZonesPercentage).intensityZone2PercentageStart = loc9 = arg2["intensityZone2"];
            }
            undefined;
            if (arg1 is core.units.interfaces.IIntensityZonesPercentage) 
            {
                (arg1 as core.units.interfaces.IIntensityZonesPercentage).intensityZone3PercentageStart = loc9 = arg2["intensityZone3"];
            }
            undefined;
            if (arg1 is core.units.interfaces.IIntensityZonesPercentage) 
            {
                (arg1 as core.units.interfaces.IIntensityZonesPercentage).intensityZone4PercentageEnd = loc9 = arg2["intensityZone4End"];
            }
            undefined;
            if (arg1 is core.units.interfaces.IIntensityZonesPercentage) 
            {
                (arg1 as core.units.interfaces.IIntensityZonesPercentage).intensityZone4PercentageStart = loc9 = arg2["intensityZone4"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingIntervalCoolDown) 
            {
                (arg1 as core.settings.interfaces.ITrainingIntervalCoolDown).intervalCoolDownTargetZoneLowerLimit = loc9 = arg2["intervalCoolDownTargetZoneLowerLimit"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingIntervalCoolDown) 
            {
                (arg1 as core.settings.interfaces.ITrainingIntervalCoolDown).intervalCoolDownTargetZoneUpperLimit = loc9 = arg2["intervalCoolDownTargetZoneUpperLimit"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingIntervalCoolDown) 
            {
                (arg1 as core.settings.interfaces.ITrainingIntervalCoolDown).intervalCoolDownTime = loc9 = arg2["intervalCoolDownTime"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingInterval) 
            {
                (arg1 as core.settings.interfaces.ITrainingInterval).intervalRecoveryHR = loc9 = arg2["intervalRecoveryHR"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingInterval) 
            {
                (arg1 as core.settings.interfaces.ITrainingInterval).intervalRecoveryMode = loc9 = core.training.type.PhaseControl.fromString(arg2["intervalRecoveryMode"]);
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingInterval) 
            {
                (arg1 as core.settings.interfaces.ITrainingInterval).intervalRecoveryTime = loc9 = arg2["intervalRecoveryTime"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingInterval) 
            {
                (arg1 as core.settings.interfaces.ITrainingInterval).intervalTargetZoneLowerLimit = loc9 = arg2["intervalTargetZoneLowerLimit"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingInterval) 
            {
                (arg1 as core.settings.interfaces.ITrainingInterval).intervalTargetZoneUpperLimit = loc9 = arg2["intervalTargetZoneUpperLimit"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingInterval) 
            {
                (arg1 as core.settings.interfaces.ITrainingInterval).intervalTime = loc9 = arg2["intervalTime"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingIntervalWarmUp) 
            {
                (arg1 as core.settings.interfaces.ITrainingIntervalWarmUp).intervalWarmUpTargetZoneLowerLimit = loc9 = arg2["intervalWarmUpTargetZoneLowerLimit"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingIntervalWarmUp) 
            {
                (arg1 as core.settings.interfaces.ITrainingIntervalWarmUp).intervalWarmUpTargetZoneUpperLimit = loc9 = arg2["intervalWarmUpTargetZoneUpperLimit"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingIntervalWarmUp) 
            {
                (arg1 as core.settings.interfaces.ITrainingIntervalWarmUp).intervalWarmUpTime = loc9 = arg2["intervalWarmUpTime"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.ILanguage) 
            {
                (arg1 as core.settings.interfaces.ILanguage).language = loc9 = arg2["language"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.ILowBatDetectLevel) 
            {
                (arg1 as core.settings.interfaces.ILowBatDetectLevel).lowBatDetectLevel = loc9 = arg2["lowBatDetectLevel"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IHeartrateLimits) 
            {
                (arg1 as core.settings.interfaces.IHeartrateLimits).lowerLimit = loc9 = arg2["lowerLimit"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IHeartrateSensor) 
            {
                (arg1 as core.settings.interfaces.IHeartrateSensor).heartrateSensorActive = loc9 = arg2["heartrateSensorActive"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.ICadenceSensor) 
            {
                (arg1 as core.settings.interfaces.ICadenceSensor).cadenceSensorActive = loc9 = arg2["cadenceSensorActive"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IMyName) 
            {
                (arg1 as core.settings.interfaces.IMyName).myName = loc9 = arg2["myName"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IOffTrackAlarm) 
            {
                (arg1 as core.settings.interfaces.IOffTrackAlarm).offTrackAlarm = loc9 = arg2["offTrackAlarm"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IPowerMeterFormula) 
            {
                (arg1 as core.settings.interfaces.IPowerMeterFormula).powerMeterFormula = loc9 = arg2["powerMeterFormula"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IPowerTargetZone) 
            {
                (arg1 as core.settings.interfaces.IPowerTargetZone).powerTargetZoneEnabled = loc9 = arg2["powerTargetZoneEnabled"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IPowerTargetZone) 
            {
                (arg1 as core.settings.interfaces.IPowerTargetZone).powerTargetZoneLowerLimit = loc9 = arg2["powerTargetZoneLowerLimit"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IPowerTargetZone) 
            {
                (arg1 as core.settings.interfaces.IPowerTargetZone).powerTargetZoneUpperLimit = loc9 = arg2["powerTargetZoneUpperLimit"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IPowerIntensityZone) 
            {
                (arg1 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone1Start = loc9 = arg2["powerIntensityZone1Start"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IPowerIntensityZone) 
            {
                (arg1 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone2Start = loc9 = arg2["powerIntensityZone2Start"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IPowerIntensityZone) 
            {
                (arg1 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone3Start = loc9 = arg2["powerIntensityZone3Start"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IPowerIntensityZone) 
            {
                (arg1 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone4Start = loc9 = arg2["powerIntensityZone4Start"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IPowerIntensityZone) 
            {
                (arg1 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone5Start = loc9 = arg2["powerIntensityZone5Start"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IPowerIntensityZone) 
            {
                (arg1 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone6Start = loc9 = arg2["powerIntensityZone6Start"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IPowerIntensityZone) 
            {
                (arg1 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone7Start = loc9 = arg2["powerIntensityZone7Start"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.ISamplingRate) 
            {
                (arg1 as core.settings.interfaces.ISamplingRate).samplingRate = loc9 = arg2["samplingRate"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IAutoScan) 
            {
                arg2["scanFlagOn"] = loc9 = 0;
                (arg1 as core.settings.interfaces.IAutoScan).scanFlagOn = loc9 = loc9 ? false : true;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ISeaLevel) 
            {
                (arg1 as core.settings.interfaces.ISeaLevel).seaLevel = loc9 = arg2["seaLevel"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IService) 
            {
                (arg1 as core.settings.interfaces.IService).serviceInterval = loc9 = arg2["serviceInterval"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IService) 
            {
                (arg1 as core.settings.interfaces.IService).serviceStatusOn = loc9 = arg2["serviceInterval"] != 0 ? true : false;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IShoulderWidth) 
            {
                (arg1 as core.settings.interfaces.IShoulderWidth).shoulderWidth = loc9 = arg2["shoulderWidth"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IShoulderWidthUnit) 
            {
                (arg1 as core.settings.interfaces.IShoulderWidthUnit).shoulderWidthUnit = loc9 = arg2["shoulderWidthUnit"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IShowTotals) 
            {
                (arg1 as core.settings.interfaces.IShowTotals).showTotals = loc9 = arg2["showTotals"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.ISpeedUnit) 
            {
                (arg1 as core.settings.interfaces.ISpeedUnit).speedUnit = loc9 = arg2["speedUnit"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IThreeZones) 
            {
                (arg1 as core.settings.interfaces.IThreeZones).startZone1 = loc9 = arg2["startZone1"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IThreeZones) 
            {
                (arg1 as core.settings.interfaces.IThreeZones).startZone2 = loc9 = arg2["startZone2"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IThreeZones) 
            {
                (arg1 as core.settings.interfaces.IThreeZones).startZone3 = loc9 = arg2["startZone3"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.ISummerTime) 
            {
                (arg1 as core.settings.interfaces.ISummerTime).summerTime = loc9 = arg2["summerTime"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.ISystemTone) 
            {
                (arg1 as core.settings.interfaces.ISystemTone).systemTone = loc9 = arg2["systemTone"] != 0 ? true : false;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITemperatureUnit) 
            {
                (arg1 as core.settings.interfaces.ITemperatureUnit).temperatureUnit = loc9 = arg2["temperatureUnit"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITimeZone) 
            {
                (arg1 as core.settings.interfaces.ITimeZone).timeZone = loc9 = arg2["timeZone"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITireSize1) 
            {
                (arg1 as core.settings.interfaces.ITireSize1).tireSize1 = loc9 = core.general.TireSize.fromString(arg2["tireSize1"]);
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITireSize2) 
            {
                (arg1 as core.settings.interfaces.ITireSize2).tireSize2 = loc9 = core.general.TireSize.fromString(arg2["tireSize2"]);
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingZone) 
            {
                (arg1 as core.settings.interfaces.ITrainingZone).trainingZone = loc9 = arg2["trainingZone"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IHeartrateLimits) 
            {
                (arg1 as core.settings.interfaces.IHeartrateLimits).upperLimit = loc9 = arg2["upperLimit"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IVolume) 
            {
                (arg1 as core.settings.interfaces.IVolume).volume = loc9 = arg2["volume"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IWayPointAlarm) 
            {
                (arg1 as core.settings.interfaces.IWayPointAlarm).waypointAlarm = loc9 = arg2["waypointAlarm"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IWheelSize1) 
            {
                (arg1 as core.settings.interfaces.IWheelSize1).wheelSize1 = loc9 = arg2["wheelSize1"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IWheelSize2) 
            {
                (arg1 as core.settings.interfaces.IWheelSize2).wheelSize2 = loc9 = arg2["wheelSize2"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IWheelSize3) 
            {
                (arg1 as core.settings.interfaces.IWheelSize3).wheelSize3 = loc9 = arg2["wheelSize3"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IWheelSize1Mode) 
            {
                (arg1 as core.settings.interfaces.IWheelSize1Mode).wheelSize1Mode = loc9 = core.general.WheelSizeSelectionMode.fromString(arg2["wheelSize1Mode"]);
            }
            undefined;
            if (arg1 is core.settings.interfaces.IWheelSize2Mode) 
            {
                (arg1 as core.settings.interfaces.IWheelSize2Mode).wheelSize2Mode = loc9 = core.general.WheelSizeSelectionMode.fromString(arg2["wheelSize2Mode"]);
            }
            undefined;
            if (arg1 is core.settings.interfaces.IYearOfBirth) 
            {
                (arg1 as core.settings.interfaces.IYearOfBirth).yearOfBirth = loc9 = arg2["yearOfBirth"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IZoneAlarm) 
            {
                (arg1 as core.settings.interfaces.IZoneAlarm).zoneAlarm = loc9 = arg2["zoneAlarm"] != 0 ? true : false;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IPhaseAlarm) 
            {
                (arg1 as core.settings.interfaces.IPhaseAlarm).phaseAlarm = loc9 = arg2["phaseAlarm"] != 0 ? true : false;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IKeyLock) 
            {
                (arg1 as core.settings.interfaces.IKeyLock).keyLock = loc9 = arg2["keyLock"] != 0 ? true : false;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IPowerSaveMode) 
            {
                (arg1 as core.settings.interfaces.IPowerSaveMode).powerSaveModeActive = loc9 = arg2["powerSaveModeActive"] != 0 ? true : false;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IBacklight) 
            {
                (arg1 as core.settings.interfaces.IBacklight).backlightActive = loc9 = arg2["backlightActive"] != 0 ? true : false;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IBacklightTimeOn) 
            {
                (arg1 as core.settings.interfaces.IBacklightTimeOn).backlightTimeOn = loc9 = new Date(arg2["backlightTimeOn"]);
            }
            undefined;
            if (arg1 is core.settings.interfaces.IBacklightTimeOff) 
            {
                (arg1 as core.settings.interfaces.IBacklightTimeOff).backlightTimeOff = loc9 = new Date(arg2["backlightTimeOff"]);
            }
            undefined;
            if (arg1 is core.settings.interfaces.INfc) 
            {
                (arg1 as core.settings.interfaces.INfc).nfcActive = loc9 = arg2["nfcActive"] != 0 ? true : false;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IETADistance) 
            {
                (arg1 as core.settings.interfaces.IETADistance).etaDistance = loc9 = arg2["etaDistance"];
            }
            undefined;
            if (arg1 is core.settings.interfaces.IETAArivalFlag) 
            {
                (arg1 as core.settings.interfaces.IETAArivalFlag).etaArivalFlag = loc9 = arg2["etaArivalFlag"] != 0 ? true : false;
            }
            undefined;
            var loc3:*=0;
            if (arg1 is core.settings.interfaces.IFavoriteTrip1) 
            {
                (arg1 as core.settings.interfaces.IFavoriteTrip1).favoritesTrip1 = new __AS3__.vec.Vector.<String>((arg1 as core.settings.interfaces.IFavoriteTrip1).favoritesTrip1Size, true);
                loc6 = 0;
                while (loc6 < (arg1 as core.settings.interfaces.IFavoriteTrip1).favoritesTrip1Size) 
                {
                    (arg1 as core.settings.interfaces.IFavoriteTrip1).favoritesTrip1[loc6] = arg2["favoritesTrip1_" + loc6];
                    ++loc6;
                }
            }
            if (arg1 is core.settings.interfaces.IFavoriteTrip2) 
            {
                (arg1 as core.settings.interfaces.IFavoriteTrip2).favoritesTrip2 = new __AS3__.vec.Vector.<String>((arg1 as core.settings.interfaces.IFavoriteTrip2).favoritesTrip2Size, true);
                loc7 = 0;
                while (loc7 < (arg1 as core.settings.interfaces.IFavoriteTrip2).favoritesTrip2Size) 
                {
                    (arg1 as core.settings.interfaces.IFavoriteTrip2).favoritesTrip2[loc7] = arg2["favoritesTrip2_" + loc7];
                    ++loc7;
                }
            }
            if (arg1 is core.settings.interfaces.IFavoritesTrack) 
            {
                loc1 = new __AS3__.vec.Vector.<__AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>>(2, true);
                loc1[0] = new __AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>(3, true);
                loc1[0][0] = new __AS3__.vec.Vector.<String>(2, true);
                loc1[0][0][0] = arg2["favoritesTrack1_1_A"];
                loc1[0][0][1] = arg2["favoritesTrack1_1_B"];
                loc1[0][1] = new __AS3__.vec.Vector.<String>(2, true);
                loc1[0][1][0] = arg2["favoritesTrack1_2_A"];
                loc1[0][1][1] = arg2["favoritesTrack1_2_B"];
                loc1[0][2] = new __AS3__.vec.Vector.<String>(2, true);
                loc1[0][2][0] = arg2["favoritesTrack1_3_A"];
                loc1[0][2][1] = arg2["favoritesTrack1_3_B"];
                loc1[1] = new __AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>(3, true);
                loc1[1][0] = new __AS3__.vec.Vector.<String>(2, true);
                loc1[1][0][0] = arg2["favoritesTrack2_1_A"];
                loc1[1][0][1] = arg2["favoritesTrack2_1_B"];
                loc1[1][1] = new __AS3__.vec.Vector.<String>(2, true);
                loc1[1][1][0] = arg2["favoritesTrack2_2_A"];
                loc1[1][1][1] = arg2["favoritesTrack2_2_B"];
                loc1[1][2] = new __AS3__.vec.Vector.<String>(2, true);
                loc1[1][2][0] = arg2["favoritesTrack2_3_A"];
                loc1[1][2][1] = arg2["favoritesTrack2_3_B"];
                (arg1 as core.settings.interfaces.IFavoritesTrack).favoritesTrack = loc1;
            }
            if (arg1 is core.settings.interfaces.IFavoritesCustom) 
            {
                (loc8 = new __AS3__.vec.Vector.<int>(2, true))[0] = arg2["favoritesCustomA_PageCount"];
                loc8[1] = arg2["favoritesCustomB_PageCount"];
                (arg1 as core.settings.interfaces.IFavoritesCustom).favoritesCustomPageCount = loc8;
                (loc2 = new __AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>(2, true))[0] = new __AS3__.vec.Vector.<String>(6, true);
                loc2[0][0] = arg2["favoritesCustom1_A"];
                loc2[0][1] = arg2["favoritesCustom2_A"];
                loc2[0][2] = arg2["favoritesCustom3_A"];
                loc2[0][3] = arg2["favoritesCustom4_A"];
                loc2[0][4] = arg2["favoritesCustom5_A"];
                loc2[0][5] = arg2["favoritesCustom6_A"];
                loc2[1] = new __AS3__.vec.Vector.<String>(6, true);
                loc2[1][0] = arg2["favoritesCustom1_B"];
                loc2[1][1] = arg2["favoritesCustom2_B"];
                loc2[1][2] = arg2["favoritesCustom3_B"];
                loc2[1][3] = arg2["favoritesCustom4_B"];
                loc2[1][4] = arg2["favoritesCustom5_B"];
                loc2[1][5] = arg2["favoritesCustom6_B"];
                (arg1 as core.settings.interfaces.IFavoritesCustom).favoritesCustom = loc2;
            }
            if (arg1 is core.settings.interfaces.IFavoritesAltitude) 
            {
                (loc4 = new __AS3__.vec.Vector.<__AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>>(2, true))[0] = new __AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>(3, true);
                loc4[0][0] = new __AS3__.vec.Vector.<String>(2, true);
                loc4[0][0][0] = arg2["favoritesAltitude1_1_A"];
                loc4[0][0][1] = arg2["favoritesAltitude1_1_B"];
                loc4[0][1] = new __AS3__.vec.Vector.<String>(2, true);
                loc4[0][1][0] = arg2["favoritesAltitude1_2_A"];
                loc4[0][1][1] = arg2["favoritesAltitude1_2_B"];
                loc4[0][2] = new __AS3__.vec.Vector.<String>(2, true);
                loc4[0][2][0] = arg2["favoritesAltitude1_3_A"];
                loc4[0][2][1] = arg2["favoritesAltitude1_3_B"];
                loc4[1] = new __AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>(3, true);
                loc4[1][0] = new __AS3__.vec.Vector.<String>(2, true);
                loc4[1][0][0] = arg2["favoritesAltitude2_1_A"];
                loc4[1][0][1] = arg2["favoritesAltitude2_1_B"];
                loc4[1][1] = new __AS3__.vec.Vector.<String>(2, true);
                loc4[1][1][0] = arg2["favoritesAltitude2_2_A"];
                loc4[1][1][1] = arg2["favoritesAltitude2_2_B"];
                loc4[1][2] = new __AS3__.vec.Vector.<String>(2, true);
                loc4[1][2][0] = arg2["favoritesAltitude2_3_A"];
                loc4[1][2][1] = arg2["favoritesAltitude2_3_B"];
                (arg1 as core.settings.interfaces.IFavoritesAltitude).favoritesAltitude = loc4;
            }
            if (arg1 is core.settings.interfaces.IFavoritesLap) 
            {
                (loc5 = new __AS3__.vec.Vector.<__AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>>(2, true))[0] = new __AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>(3, true);
                loc5[0][0] = new __AS3__.vec.Vector.<String>(2, true);
                loc5[0][0][0] = arg2["favoritesLap1_1_A"];
                loc5[0][0][1] = arg2["favoritesLap1_1_B"];
                loc5[0][1] = new __AS3__.vec.Vector.<String>(2, true);
                loc5[0][1][0] = arg2["favoritesLap1_2_A"];
                loc5[0][1][1] = arg2["favoritesLap1_2_B"];
                loc5[0][2] = new __AS3__.vec.Vector.<String>(2, true);
                loc5[0][2][0] = arg2["favoritesLap1_3_A"];
                loc5[0][2][1] = arg2["favoritesLap1_3_B"];
                loc5[1] = new __AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>(3, true);
                loc5[1][0] = new __AS3__.vec.Vector.<String>(2, true);
                loc5[1][0][0] = arg2["favoritesLap2_1_A"];
                loc5[1][0][1] = arg2["favoritesLap2_1_B"];
                loc5[1][1] = new __AS3__.vec.Vector.<String>(2, true);
                loc5[1][1][0] = arg2["favoritesLap2_2_A"];
                loc5[1][1][1] = arg2["favoritesLap2_2_B"];
                loc5[1][2] = new __AS3__.vec.Vector.<String>(2, true);
                loc5[1][2][0] = arg2["favoritesLap2_3_A"];
                loc5[1][2][1] = arg2["favoritesLap2_3_B"];
                (arg1 as core.settings.SettingsROX100).favoritesLap = loc5;
            }
            return;
        }

        public static function selectSettings(arg1:String, arg2:String="modificationDate", arg3:Boolean=false):String
        {
            return "SELECT * FROM Settings where unitGUID = \'" + arg1 + "\' and isDeleted = false ORDER BY " + arg2 + (arg3 ? " ASC" : " DESC");
        }

        public static function prepareDelete(arg1:String):String
        {
            var loc1:*=new Date().time;
            var loc2:*="UPDATE Settings SET isDeleted = true, modificationDate = \'" + loc1 + "\' WHERE GUID = \'" + arg1 + "\'";
            return loc2;
        }

        public static function generateDBCreateIndex():String
        {
            var loc1:*="CREATE INDEX IF NOT EXISTS UnitGUIDOnSettings ON Settings (unitGUID)";
            return loc1;
        }

        public static function fromXML(arg1:XML, arg2:core.settings.Settings):void
        {
            var loc9:*=undefined;
            var loc1:*=null;
            var loc5:*=0;
            var loc8:*=0;
            var loc2:*=undefined;
            var loc4:*=null;
            var loc3:*=undefined;
            var loc6:*=undefined;
            var loc7:*=undefined;
            var loc10:*;
            if ((loc10 = arg1.name()).localName != "SettingInformation") 
            {
                return;
            }
            if (arg1.GeneralInformation.GUID != undefined) 
            {
                arg2.GUID = arg1.GeneralInformation.GUID;
            }
            if (arg1.GeneralInformation.unitGUID != undefined) 
            {
                arg2.unitGUID = arg1.GeneralInformation.unitGUID;
                arg2.unit = handler.AppDeviceHandlerCommon.deviceDicGUID[arg2.unitGUID];
            }
            if (arg1.GeneralInformation.modificationDate != undefined) 
            {
                arg2.modificationDate = arg1.GeneralInformation.modificationDate;
            }
            if (arg2 is core.settings.interfaces.IActualAltitude) 
            {
                (arg2 as core.settings.interfaces.IActualAltitude).actualAltitude = arg1.SettingValues.ActualAltitude;
            }
            if (arg2 is core.settings.interfaces.IAge) 
            {
                (arg2 as core.settings.interfaces.IAge).age = arg1.SettingValues.Age;
            }
            if (arg2 is core.settings.interfaces.IAlarm) 
            {
                (arg2 as core.settings.interfaces.IAlarm).alarm = new Date(arg1.SettingValues.Alarm.text().toString());
            }
            if (arg2 is core.settings.interfaces.IAlarmMode) 
            {
                (arg2 as core.settings.interfaces.IAlarmMode).alarmMode = arg1.SettingValues.AlarmMode;
            }
            if (arg2 is core.settings.interfaces.IAltitudeReference) 
            {
                if ((loc9 = arg1.SettingValues.AltitudeReference) == undefined) 
                {
                    loc9 = arg1.SettingValues.ReferenceMark;
                }
                (arg2 as core.settings.interfaces.IAltitudeReference).altitudeReference = loc9;
            }
            if (arg2 is core.settings.interfaces.IAltitudeUnit) 
            {
                (arg2 as core.settings.interfaces.IAltitudeUnit).altitudeUnit = arg1.SettingValues.AltitudeUnit;
            }
            if (arg2 is core.settings.interfaces.IAutoPause) 
            {
                (arg2 as core.settings.interfaces.IAutoPause).autoPause = arg1.SettingValues.AutoPause != "true" ? false : true;
            }
            if (arg2 is core.settings.interfaces.IAutoZoomTrack) 
            {
                (arg2 as core.settings.interfaces.IAutoZoomTrack).autoZoomTrack = arg1.SettingValues.AutoZoomTrack != "true" ? false : true;
            }
            if (arg2 is core.settings.interfaces.IAutoOffTime) 
            {
                (arg2 as core.settings.interfaces.IAutoOffTime).autoOffTime = core.general.AutoOffTimeUnit.fromString(arg1.SettingValues.AutoOffTime);
            }
            if (arg2 is core.settings.interfaces.IBacklightTime) 
            {
                (arg2 as core.settings.interfaces.IBacklightTime).backlightTime = arg1.SettingValues.BacklightTime;
            }
            if (arg2 is core.settings.interfaces.IBikeType1) 
            {
                (arg2 as core.settings.interfaces.IBikeType1).bikeType1 = arg1.SettingValues.BikeType1;
            }
            if (arg2 is core.settings.interfaces.IBikeType2) 
            {
                (arg2 as core.settings.interfaces.IBikeType2).bikeType2 = arg1.SettingValues.BikeType2;
            }
            if (arg2 is core.settings.interfaces.IBikeType3) 
            {
                (arg2 as core.settings.interfaces.IBikeType3).bikeType3 = arg1.SettingValues.BikeType3;
            }
            if (arg2 is core.settings.interfaces.IBikeWeight1) 
            {
                (arg2 as core.settings.interfaces.IBikeWeight1).bikeWeight1 = arg1.SettingValues.BikeWeight1;
            }
            if (arg2 is core.settings.interfaces.IBikeWeight1Unit) 
            {
                (arg2 as core.settings.interfaces.IBikeWeight1Unit).bikeWeight1Unit = arg1.SettingValues.BikeWeight1Unit;
            }
            if (arg2 is core.settings.interfaces.IBikeWeight2) 
            {
                (arg2 as core.settings.interfaces.IBikeWeight2).bikeWeight2 = arg1.SettingValues.BikeWeight2;
            }
            if (arg2 is core.settings.interfaces.IBikeWeight2Unit) 
            {
                (arg2 as core.settings.interfaces.IBikeWeight2Unit).bikeWeight2Unit = arg1.SettingValues.BikeWeight2Unit;
            }
            if (arg2 is core.settings.interfaces.IBikeWeight3) 
            {
                (arg2 as core.settings.interfaces.IBikeWeight3).bikeWeight3 = arg1.SettingValues.BikeWeight3;
            }
            if (arg2 is core.settings.interfaces.IBirthDate) 
            {
                (arg2 as core.settings.interfaces.IBirthDate).birthDate = new Date(arg1.SettingValues.BirthDate.text().toString());
            }
            if (arg2 is core.settings.interfaces.IBodyHeight) 
            {
                (arg2 as core.settings.interfaces.IBodyHeight).bodyHeight = arg1.SettingValues.BodyHeight;
            }
            if (arg2 is core.settings.interfaces.IBodyHeightUnit) 
            {
                (arg2 as core.settings.interfaces.IBodyHeightUnit).bodyHeightUnit = arg1.SettingValues.BodyHeightUnit;
            }
            if (arg2 is core.settings.interfaces.IBodyWeight) 
            {
                if ((loc9 = arg1.SettingValues.BodyWeight) == undefined) 
                {
                    loc9 = arg1.SettingValues.Weight;
                }
                (arg2 as core.settings.interfaces.IBodyWeight).bodyWeight = loc9;
            }
            if (arg2 is core.settings.interfaces.IBodyWeightUnit) 
            {
                if ((loc9 = arg1.SettingValues.WeightUnit) == undefined) 
                {
                    loc9 = arg1.SettingValues.BodyWeightUnit;
                }
                (arg2 as core.settings.interfaces.IBodyWeightUnit).bodyWeightUnit = loc9;
            }
            if (arg2 is core.settings.interfaces.IButtonInfo) 
            {
                (arg2 as core.settings.interfaces.IButtonInfo).buttonInfo = arg1.SettingValues.ButtonInfo != "true" ? false : true;
            }
            if (arg2 is core.settings.interfaces.IButtonTone) 
            {
                (arg2 as core.settings.interfaces.IButtonTone).buttonTone = arg1.SettingValues.ButtonTone != "true" ? false : true;
            }
            if (arg2 is core.settings.interfaces.ICalibration) 
            {
                (arg2 as core.settings.interfaces.ICalibration).calibration = arg1.SettingValues.Calibration != "true" ? false : true;
            }
            if (arg2 is core.settings.interfaces.IClockMode) 
            {
                (arg2 as core.settings.interfaces.IClockMode).clockMode = arg1.SettingValues.ClockMode;
            }
            if (arg2 is core.settings.interfaces.IContrast) 
            {
                (arg2 as core.settings.interfaces.IContrast).contrast = arg1.SettingValues.Contrast;
            }
            if (arg2 is core.settings.interfaces.ICorrectionFactor) 
            {
                (arg2 as core.settings.interfaces.ICorrectionFactor).correctionFactor = arg1.SettingValues.CorrectionFactor;
            }
            if (arg2 is core.settings.interfaces.ICountdown) 
            {
                (arg2 as core.settings.interfaces.ICountdown).countdown = arg1.SettingValues.Countdown;
                (arg2 as core.settings.interfaces.ICountdown).countdownOn = arg1.SettingValues.CountdownOn != "true" ? false : true;
            }
            arg2.date = new Date(Date.parse(arg1.SettingValues.Date + ""));
            if (arg2 is core.settings.interfaces.IDateFormat) 
            {
                (arg2 as core.settings.interfaces.IDateFormat).dateFormat = arg1.SettingValues.DateFormat;
            }
            if (arg2 is core.settings.interfaces.IDistanceUnit) 
            {
                (arg2 as core.settings.interfaces.IDistanceUnit).distanceUnit = arg1.SettingValues.DistanceUnit;
            }
            if (arg2 is core.settings.interfaces.IThreeZones) 
            {
                (arg2 as core.settings.interfaces.IThreeZones).endZone3 = arg1.SettingValues.EndZone3;
            }
            if (arg2 is core.settings.SettingsROX100) 
            {
                (arg2 as core.settings.SettingsROX100).favoritesSelected = arg1.SettingValues.FavoritesSelected;
            }
            if (arg2 is core.settings.interfaces.IFuelConsumption) 
            {
                (arg2 as core.settings.interfaces.IFuelConsumption).fuelConsumption = arg1.SettingValues.FuelConsumption;
            }
            if (arg2 is core.settings.interfaces.IFuelConsumptionUnit) 
            {
                (arg2 as core.settings.interfaces.IFuelConsumptionUnit).fuelConsumptionUnit = arg1.SettingValues.FuelConsumptionUnit;
            }
            if (arg2 is core.settings.interfaces.ITrainingFree) 
            {
                (arg2 as core.settings.interfaces.ITrainingFree).freeTrainingTargetZone = arg1.SettingValues.FreeTrainingTargetZone;
                (arg2 as core.settings.interfaces.ITrainingFree).freeOwnZone1LowerLimit = arg1.SettingValues.FreeOwnZone1LowerLimit != undefined ? arg1.SettingValues.FreeOwnZone1LowerLimit : (arg2 as core.settings.interfaces.ITrainingFree).freeOwnZone1LowerLimitDefault;
                (arg2 as core.settings.interfaces.ITrainingFree).freeOwnZone1UpperLimit = arg1.SettingValues.FreeOwnZone1UpperLimit != undefined ? arg1.SettingValues.FreeOwnZone1UpperLimit : (arg2 as core.settings.interfaces.ITrainingFree).freeOwnZone1UpperLimitDefault;
                (arg2 as core.settings.interfaces.ITrainingFree).freeOwnZone2LowerLimit = arg1.SettingValues.FreeOwnZone2LowerLimit != undefined ? arg1.SettingValues.FreeOwnZone2LowerLimit : (arg2 as core.settings.interfaces.ITrainingFree).freeOwnZone2LowerLimitDefault;
                (arg2 as core.settings.interfaces.ITrainingFree).freeOwnZone2UpperLimit = arg1.SettingValues.FreeOwnZone2UpperLimit != undefined ? arg1.SettingValues.FreeOwnZone2UpperLimit : (arg2 as core.settings.interfaces.ITrainingFree).freeOwnZone2UpperLimitDefault;
                (arg2 as core.settings.interfaces.ITrainingFree).freeOwnZone3LowerLimit = arg1.SettingValues.FreeOwnZone3LowerLimit != undefined ? arg1.SettingValues.FreeOwnZone3LowerLimit : (arg2 as core.settings.interfaces.ITrainingFree).freeOwnZone3LowerLimitDefault;
                (arg2 as core.settings.interfaces.ITrainingFree).freeOwnZone3UpperLimit = arg1.SettingValues.FreeOwnZone3UpperLimit != undefined ? arg1.SettingValues.FreeOwnZone3UpperLimit : (arg2 as core.settings.interfaces.ITrainingFree).freeOwnZone3UpperLimitDefault;
            }
            loc9 = arg1.SettingValues.Gender;
            if (arg2 is core.settings.interfaces.IGender) 
            {
                (arg2 as core.settings.interfaces.IGender).gender = loc9;
            }
            if (arg2 is core.settings.interfaces.IGPSFormat) 
            {
                (arg2 as core.settings.interfaces.IGPSFormat).gpsFormat = arg1.SettingValues.GPSFormat;
            }
            if (arg2 is core.settings.interfaces.IGPSStatus) 
            {
                (arg2 as core.settings.interfaces.IGPSStatus).gpsStatus = arg1.SettingValues.GPSStatus != "true" ? false : true;
            }
            if (arg2 is core.settings.interfaces.IStravaSegmentsEnabled) 
            {
                (arg2 as core.settings.interfaces.IStravaSegmentsEnabled).stravaSegmentsEnabled = arg1.SettingValues.StravaSegmentsEnabled != "true" ? false : true;
            }
            if (arg2 is core.settings.interfaces.ITrackDirection) 
            {
                (arg2 as core.settings.interfaces.ITrackDirection).trackDirection = arg1.SettingValues.TrackDirection;
            }
            if (arg2 is core.settings.interfaces.IHomeAltitude1) 
            {
                (arg2 as core.settings.interfaces.IHomeAltitude1).homeAltitude1 = arg1.SettingValues.HomeAltitude1;
            }
            if (arg2 is core.settings.interfaces.IHomeAltitude2) 
            {
                (arg2 as core.settings.interfaces.IHomeAltitude2).homeAltitude2 = arg1.SettingValues.HomeAltitude2;
            }
            if (arg2 is core.settings.interfaces.IHomeAltitude3) 
            {
                (arg2 as core.settings.interfaces.IHomeAltitude3).homeAltitude3 = arg1.SettingValues.HomeAltitude3;
            }
            if (arg2 is core.settings.interfaces.IHRmax) 
            {
                (arg2 as core.settings.interfaces.IHRmax).hrMax = arg1.SettingValues.HrMax;
            }
            if (arg2 is core.units.interfaces.IIntensityZonesPercentage) 
            {
                (arg2 as core.units.interfaces.IIntensityZonesPercentage).intensityZone1PercentageStart = arg1.SettingValues.IntensityZone1;
                (arg2 as core.units.interfaces.IIntensityZonesPercentage).intensityZone2PercentageStart = arg1.SettingValues.IntensityZone2;
                (arg2 as core.units.interfaces.IIntensityZonesPercentage).intensityZone3PercentageStart = arg1.SettingValues.IntensityZone3;
                (arg2 as core.units.interfaces.IIntensityZonesPercentage).intensityZone4PercentageEnd = arg1.SettingValues.IntensityZone4End;
                (arg2 as core.units.interfaces.IIntensityZonesPercentage).intensityZone4PercentageStart = arg1.SettingValues.IntensityZone4;
            }
            if (arg2 is core.settings.interfaces.ITrainingIntervalCoolDown) 
            {
                (arg2 as core.settings.interfaces.ITrainingIntervalCoolDown).intervalCoolDownTargetZoneLowerLimit = arg1.SettingValues.IntervalCoolDownTargetZoneLowerLimit;
                (arg2 as core.settings.interfaces.ITrainingIntervalCoolDown).intervalCoolDownTargetZoneUpperLimit = arg1.SettingValues.IntervalCoolDownTargetZoneUpperLimit;
                (arg2 as core.settings.interfaces.ITrainingIntervalCoolDown).intervalCoolDownTime = arg1.SettingValues.IntervalCoolDownTime;
            }
            if (arg2 is core.settings.interfaces.ITrainingInterval) 
            {
                (arg2 as core.settings.interfaces.ITrainingInterval).intervalRecoveryHR = arg1.SettingValues.IntervalRecoveryHR;
                (arg2 as core.settings.interfaces.ITrainingInterval).intervalRecoveryMode = core.training.type.PhaseControl.fromString(arg1.SettingValues.IntervalRecoveryMode);
                (arg2 as core.settings.interfaces.ITrainingInterval).intervalRecoveryTime = arg1.SettingValues.IntervalRecoveryTime;
                (arg2 as core.settings.interfaces.ITrainingInterval).intervalTargetZoneLowerLimit = arg1.SettingValues.IntervalTargetZoneLowerLimit;
                (arg2 as core.settings.interfaces.ITrainingInterval).intervalTargetZoneUpperLimit = arg1.SettingValues.IntervalTargetZoneUpperLimit;
                (arg2 as core.settings.interfaces.ITrainingInterval).intervalTime = arg1.SettingValues.intervalTime;
            }
            if (arg2 is core.settings.interfaces.ITrainingIntervalWarmUp) 
            {
                (arg2 as core.settings.interfaces.ITrainingIntervalWarmUp).intervalWarmUpTargetZoneLowerLimit = arg1.SettingValues.IntervalWarmUpTargetZoneLowerLimit;
                (arg2 as core.settings.interfaces.ITrainingIntervalWarmUp).intervalWarmUpTargetZoneUpperLimit = arg1.SettingValues.IntervalWarmUpTargetZoneUpperLimit;
                (arg2 as core.settings.interfaces.ITrainingIntervalWarmUp).intervalWarmUpTime = arg1.SettingValues.IntervalWarmUpTime;
            }
            if (arg2 is core.settings.interfaces.ILanguage) 
            {
                (arg2 as core.settings.interfaces.ILanguage).language = arg1.SettingValues.Language;
            }
            if (arg2 is core.settings.interfaces.ILowBatDetectLevel) 
            {
                (arg2 as core.settings.interfaces.ILowBatDetectLevel).lowBatDetectLevel = arg1.SettingValues.LowBatteryDetectLevel;
            }
            if (arg2 is core.settings.interfaces.IHeartrateLimits) 
            {
                (arg2 as core.settings.interfaces.IHeartrateLimits).lowerLimit = arg1.SettingValues.LowerLimit;
            }
            if (arg2 is core.settings.interfaces.IHeartrateSensor) 
            {
                (arg2 as core.settings.interfaces.IHeartrateSensor).heartrateSensorActive = arg1.SettingValues.HeartrateSensorActive;
            }
            if (arg2 is core.settings.interfaces.ICadenceSensor) 
            {
                (arg2 as core.settings.interfaces.ICadenceSensor).cadenceSensorActive = arg1.SettingValues.CadenceSensorActive;
            }
            if (arg2 is core.settings.interfaces.IMyName) 
            {
                (arg2 as core.settings.interfaces.IMyName).myName = arg1.SettingValues.MyName;
            }
            arg2.name = arg1.SettingValues.Name;
            if (arg2 is core.settings.interfaces.IOffTrackAlarm) 
            {
                (arg2 as core.settings.interfaces.IOffTrackAlarm).offTrackAlarm = arg1.SettingValues.OffTrackAlarm;
            }
            if (arg2 is core.settings.interfaces.IPowerMeterFormula) 
            {
                (arg2 as core.settings.interfaces.IPowerMeterFormula).powerMeterFormula = arg1.SettingValues.PowerMeterFormula;
            }
            if (arg2 is core.settings.interfaces.IPowerTargetZone) 
            {
                (arg2 as core.settings.interfaces.IPowerTargetZone).powerTargetZoneEnabled = arg1.SettingValues.PowerTargetZoneEnabled != "true" ? false : true;
                (arg2 as core.settings.interfaces.IPowerTargetZone).powerTargetZoneLowerLimit = arg1.SettingValues.PowerTargetZoneLowerLimit;
                (arg2 as core.settings.interfaces.IPowerTargetZone).powerTargetZoneUpperLimit = arg1.SettingValues.PowerTargetZoneUpperLimit;
            }
            if (arg2 is core.settings.interfaces.IPowerIntensityZone) 
            {
                (arg2 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone1Start = arg1.SettingValues.PowerIntensityZone1Start;
                (arg2 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone2Start = arg1.SettingValues.PowerIntensityZone2Start;
                (arg2 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone3Start = arg1.SettingValues.PowerIntensityZone3Start;
                (arg2 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone4Start = arg1.SettingValues.PowerIntensityZone4Start;
                (arg2 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone5Start = arg1.SettingValues.PowerIntensityZone5Start;
                (arg2 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone6Start = arg1.SettingValues.PowerIntensityZone6Start;
                (arg2 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone7Start = arg1.SettingValues.PowerIntensityZone7Start;
                (arg2 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone7End = arg1.SettingValues.PowerIntensityZone7End;
            }
            if (arg2 is core.settings.interfaces.ISamplingRate) 
            {
                (arg2 as core.settings.interfaces.ISamplingRate).samplingRate = arg1.SettingValues.SamplingRate;
            }
            if (arg2 is core.settings.interfaces.IAutoScan) 
            {
                (arg2 as core.settings.interfaces.IAutoScan).scanFlagOn = arg1.SettingValues.AutoScan != "true" ? false : true;
            }
            if (arg2 is core.settings.interfaces.ISeaLevel) 
            {
                (arg2 as core.settings.interfaces.ISeaLevel).seaLevel = arg1.SettingValues.SeaLevel;
            }
            if (arg2 is core.settings.interfaces.IService) 
            {
                (arg2 as core.settings.interfaces.IService).serviceInterval = arg1.SettingValues.ServiceInterval;
                (arg2 as core.settings.interfaces.IService).serviceStatusOn = arg1.SettingValues.ServiceStatus != "true" ? false : true;
            }
            if (arg2 is core.settings.interfaces.IShoulderWidth) 
            {
                (arg2 as core.settings.interfaces.IShoulderWidth).shoulderWidth = arg1.SettingValues.ShoulderWidth;
            }
            if (arg2 is core.settings.interfaces.IShoulderWidthUnit) 
            {
                (arg2 as core.settings.interfaces.IShoulderWidthUnit).shoulderWidthUnit = arg1.SettingValues.ShoulderWidthUnit;
            }
            if (arg2 is core.settings.interfaces.IShowTotals) 
            {
                (arg2 as core.settings.interfaces.IShowTotals).showTotals = arg1.SettingValues.ShowTotals;
            }
            if (arg2 is core.settings.interfaces.ISpeedUnit) 
            {
                (arg2 as core.settings.interfaces.ISpeedUnit).speedUnit = arg1.SettingValues.Measurement;
            }
            if (arg2 is core.settings.interfaces.IThreeZones) 
            {
                (arg2 as core.settings.interfaces.IThreeZones).startZone1 = arg1.SettingValues.StartZone1;
                (arg2 as core.settings.interfaces.IThreeZones).startZone2 = arg1.SettingValues.StartZone2;
                (arg2 as core.settings.interfaces.IThreeZones).startZone3 = arg1.SettingValues.StartZone3;
            }
            if (arg2 is core.settings.interfaces.ISummerTime) 
            {
                (arg2 as core.settings.interfaces.ISummerTime).summerTime = arg1.SettingValues.SummerTime != "true" ? false : true;
            }
            if (arg2 is core.settings.interfaces.ISystemTone) 
            {
                (arg2 as core.settings.interfaces.ISystemTone).systemTone = arg1.SettingValues.SystemTone != "true" ? false : true;
            }
            if (arg2 is core.settings.interfaces.ITrainingZone) 
            {
                if ((loc9 = arg1.SettingValues.TrainingZone) == undefined) 
                {
                    loc9 = arg1.SettingValues.TargetZone;
                }
                (arg2 as core.settings.interfaces.ITrainingZone).trainingZone = loc9;
            }
            if (arg2 is core.settings.interfaces.ITemperatureUnit) 
            {
                (arg2 as core.settings.interfaces.ITemperatureUnit).temperatureUnit = arg1.SettingValues.TemperatureUnit;
            }
            if (arg2 is core.settings.interfaces.ITimeZone) 
            {
                (arg2 as core.settings.interfaces.ITimeZone).timeZone = arg1.SettingValues.TimeZone;
            }
            arg2.unitType = core.general.UnitType.fromString(arg1.GeneralInformation.@unit);
            if (arg2 is core.settings.interfaces.IHeartrateLimits) 
            {
                (arg2 as core.settings.interfaces.IHeartrateLimits).upperLimit = arg1.SettingValues.UpperLimit;
            }
            if (arg2 is core.settings.interfaces.IVolume) 
            {
                (arg2 as core.settings.interfaces.IVolume).volume = arg1.SettingValues.Volume;
            }
            if (arg2 is core.settings.interfaces.IWayPointAlarm) 
            {
                (arg2 as core.settings.interfaces.IWayPointAlarm).waypointAlarm = arg1.SettingValues.WaypointAlarm;
            }
            if (arg2 is core.settings.interfaces.IWheelSize1) 
            {
                (arg2 as core.settings.interfaces.IWheelSize1).wheelSize1 = arg1.SettingValues.WheelSize1;
            }
            if (arg2 is core.settings.interfaces.IWheelSize2) 
            {
                (arg2 as core.settings.interfaces.IWheelSize2).wheelSize2 = arg1.SettingValues.WheelSize2;
            }
            if (arg2 is core.settings.interfaces.IWheelSize3) 
            {
                (arg2 as core.settings.interfaces.IWheelSize3).wheelSize3 = arg1.SettingValues.WheelSize3;
            }
            if (arg2 is core.settings.interfaces.IWheelSize1Mode) 
            {
                (arg2 as core.settings.interfaces.IWheelSize1Mode).wheelSize1Mode = core.general.WheelSizeSelectionMode.fromString(arg1.SettingValues.WheelSize1Mode);
            }
            if (arg2 is core.settings.interfaces.IWheelSize2Mode) 
            {
                (arg2 as core.settings.interfaces.IWheelSize2Mode).wheelSize2Mode = core.general.WheelSizeSelectionMode.fromString(arg1.SettingValues.WheelSize2Mode);
            }
            if (arg2 is core.settings.interfaces.ITireSize1) 
            {
                (arg2 as core.settings.interfaces.ITireSize1).tireSize1 = core.general.TireSize.fromString(arg1.SettingValues.TireSize1);
            }
            if (arg2 is core.settings.interfaces.ITireSize2) 
            {
                (arg2 as core.settings.interfaces.ITireSize2).tireSize2 = core.general.TireSize.fromString(arg1.SettingValues.TireSize2);
            }
            if (arg2 is core.settings.interfaces.IYearOfBirth) 
            {
                (arg2 as core.settings.interfaces.IYearOfBirth).yearOfBirth = arg1.SettingValues.YearOfBirth;
            }
            if (arg2 is core.settings.interfaces.IZoneAlarm) 
            {
                if ((loc9 = arg1.SettingValues.Target) == undefined) 
                {
                    loc9 = arg1.SettingValues.ZoneAlarm;
                }
                (arg2 as core.settings.interfaces.IZoneAlarm).zoneAlarm = loc9 != "true" ? false : true;
            }
            if (arg2 is core.settings.interfaces.IPhaseAlarm) 
            {
                if ((loc9 = arg1.SettingValues.Target) == undefined) 
                {
                    loc9 = arg1.SettingValues.PhaseAlarm;
                }
                (arg2 as core.settings.interfaces.IPhaseAlarm).phaseAlarm = loc9 != "true" ? false : true;
            }
            if (arg2 is core.settings.interfaces.IKeyLock) 
            {
                if ((loc9 = arg1.SettingValues.Target) == undefined) 
                {
                    loc9 = arg1.SettingValues.KeyLock;
                }
                (arg2 as core.settings.interfaces.IKeyLock).keyLock = loc9 != "true" ? false : true;
            }
            if (arg2 is core.settings.interfaces.IPowerSaveMode) 
            {
                if ((loc9 = arg1.SettingValues.PowerSaveModeActive) == undefined) 
                {
                    loc9 = true;
                }
                (arg2 as core.settings.interfaces.IPowerSaveMode).powerSaveModeActive = loc9 != "true" ? false : true;
            }
            if (arg2 is core.settings.interfaces.IBacklight) 
            {
                if ((loc9 = arg1.SettingValues.BacklightActive) == undefined) 
                {
                    loc9 = false;
                }
                (arg2 as core.settings.interfaces.IBacklight).backlightActive = loc9 != "true" ? false : true;
            }
            if (arg2 is core.settings.interfaces.IBacklightTimeOn) 
            {
                (arg2 as core.settings.interfaces.IBacklightTimeOn).backlightTimeOn = new Date(arg1.SettingValues.BacklightTimeOn.text().toString());
            }
            if (arg2 is core.settings.interfaces.IBacklightTimeOff) 
            {
                (arg2 as core.settings.interfaces.IBacklightTimeOff).backlightTimeOff = new Date(arg1.SettingValues.BacklightTimeOff.text().toString());
            }
            if (arg2 is core.settings.interfaces.INfc) 
            {
                if ((loc9 = arg1.SettingValues.NFCActive) != undefined) 
                {
                    (arg2 as core.settings.interfaces.INfc).nfcActive = loc9 != "true" ? false : true;
                }
                else 
                {
                    (arg2 as core.settings.interfaces.INfc).nfcActive = true;
                }
            }
            if (arg2 is core.settings.interfaces.IETADistance) 
            {
                if ((loc9 = arg1.SettingValues.ETADistance) != undefined) 
                {
                    (arg2 as core.settings.interfaces.IETADistance).etaDistance = loc9;
                }
                else 
                {
                    (arg2 as core.settings.interfaces.IETADistance).etaDistance = 0;
                }
            }
            if (arg2 is core.settings.interfaces.IETAArivalFlag) 
            {
                if ((loc9 = arg1.SettingValues.ETAArivalFlag) != undefined) 
                {
                    (arg2 as core.settings.interfaces.IETAArivalFlag).etaArivalFlag = loc9;
                }
                else 
                {
                    (arg2 as core.settings.interfaces.IETAArivalFlag).etaArivalFlag = false;
                }
            }
            loc1 = arg1.SettingValues.Favourites1.children();
            if (loc1.length() == 0) 
            {
                loc1 = arg1.SettingValues.FavouritesTrip1.children();
            }
            if (arg2 is core.settings.interfaces.IFavoriteTrip1) 
            {
                (arg2 as core.settings.interfaces.IFavoriteTrip1).favoritesTrip1 = new __AS3__.vec.Vector.<String>((arg2 as core.settings.interfaces.IFavoriteTrip1).favoritesTrip1Size, true);
                loc8 = 0;
                while (loc8 < (arg2 as core.settings.interfaces.IFavoriteTrip1).favoritesTrip1Size) 
                {
                    (arg2 as core.settings.interfaces.IFavoriteTrip1).favoritesTrip1[loc8] = loc1[loc8];
                    ++loc8;
                }
            }
            loc1 = arg1.SettingValues.Favourites2.children();
            if (loc1.length() == 0) 
            {
                loc1 = arg1.SettingValues.FavouritesTrip2.children();
            }
            if (arg2 as core.settings.interfaces.IFavoriteTrip2) 
            {
                (arg2 as core.settings.interfaces.IFavoriteTrip2).favoritesTrip2 = new __AS3__.vec.Vector.<String>((arg2 as core.settings.interfaces.IFavoriteTrip2).favoritesTrip2Size, true);
                loc8 = 0;
                while (loc8 < (arg2 as core.settings.interfaces.IFavoriteTrip2).favoritesTrip2Size) 
                {
                    (arg2 as core.settings.interfaces.IFavoriteTrip2).favoritesTrip2[loc8] = loc1[loc8];
                    ++loc8;
                }
            }
            if (arg2 is core.settings.SettingsROX100) 
            {
                (loc2 = (arg2 as core.settings.SettingsROX100).favoritesTrack).splice(0, 2);
                loc2[0] = new __AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>(3, true);
                loc2[0][0] = new __AS3__.vec.Vector.<String>(2, true);
                loc2[0][0][0] = arg1.SettingValues.FavouritesTrack1.FavouritesTrack1_1.FavouriteTrack1A.text().toString();
                loc2[0][0][1] = arg1.SettingValues.FavouritesTrack1.FavouritesTrack1_1.FavouriteTrack1B.text().toString();
                loc2[0][1] = new __AS3__.vec.Vector.<String>(2, true);
                loc2[0][1][0] = arg1.SettingValues.FavouritesTrack1.FavouritesTrack1_2.FavouriteTrack2A.text().toString();
                loc2[0][1][1] = arg1.SettingValues.FavouritesTrack1.FavouritesTrack1_2.FavouriteTrack2B.text().toString();
                loc2[0][2] = new __AS3__.vec.Vector.<String>(2, true);
                loc2[0][2][0] = arg1.SettingValues.FavouritesTrack1.FavouritesTrack1_3.FavouriteTrack3A.text().toString();
                loc2[0][2][1] = arg1.SettingValues.FavouritesTrack1.FavouritesTrack1_3.FavouriteTrack3B.text().toString();
                loc2[1] = new __AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>(3, true);
                loc2[1][0] = new __AS3__.vec.Vector.<String>(2, true);
                loc2[1][0][0] = arg1.SettingValues.FavouritesTrack2.FavouritesTrack2_1.FavouriteTrack1A.text().toString();
                loc2[1][0][1] = arg1.SettingValues.FavouritesTrack2.FavouritesTrack2_1.FavouriteTrack1B.text().toString();
                loc2[1][1] = new __AS3__.vec.Vector.<String>(2, true);
                loc2[1][1][0] = arg1.SettingValues.FavouritesTrack2.FavouritesTrack2_2.FavouriteTrack2A.text().toString();
                loc2[1][1][1] = arg1.SettingValues.FavouritesTrack2.FavouritesTrack2_2.FavouriteTrack2B.text().toString();
                loc2[1][2] = new __AS3__.vec.Vector.<String>(2, true);
                loc2[1][2][0] = arg1.SettingValues.FavouritesTrack2.FavouritesTrack2_3.FavouriteTrack3A.text().toString();
                loc2[1][2][1] = arg1.SettingValues.FavouritesTrack2.FavouritesTrack2_3.FavouriteTrack3B.text().toString();
                (arg2 as core.settings.interfaces.IFavoritesCustom).favoritesCustomPageCount = new __AS3__.vec.Vector.<int>(2, true);
                (arg2 as core.settings.interfaces.IFavoritesCustom).favoritesCustomPageCount[0] = parseInt(arg1.SettingValues.FavouritesCustomA_PageCount.text().toString());
                (arg2 as core.settings.interfaces.IFavoritesCustom).favoritesCustomPageCount[1] = parseInt(arg1.SettingValues.FavouritesCustomB_PageCount.text().toString());
                if ((loc4 = handler.AppDeviceHandlerCommon.deviceDicGUID[(arg2 as core.settings.SettingsROX100).unitGUID]) && core.units.UnitROX100.getSoftwareRevisionNumber(loc4.softwareRevision) >= 1403271) 
                {
                    (loc3 = (arg2 as core.settings.interfaces.IFavoritesCustom).favoritesCustom).splice(0, 2);
                    loc3[0] = new __AS3__.vec.Vector.<String>(6, true);
                    loc3[0][0] = arg1.SettingValues.FavouriteCustom1A.text().toString();
                    loc3[0][1] = arg1.SettingValues.FavouriteCustom2A.text().toString();
                    loc3[0][2] = arg1.SettingValues.FavouriteCustom3A.text().toString();
                    loc3[0][3] = arg1.SettingValues.FavouriteCustom4A.text().toString();
                    loc3[0][4] = arg1.SettingValues.FavouriteCustom5A.text().toString();
                    loc3[0][5] = arg1.SettingValues.FavouriteCustom6A.text().toString();
                    loc3[1] = new __AS3__.vec.Vector.<String>(6, true);
                    loc3[1][0] = arg1.SettingValues.FavouriteCustom1B.text().toString();
                    loc3[1][1] = arg1.SettingValues.FavouriteCustom2B.text().toString();
                    loc3[1][2] = arg1.SettingValues.FavouriteCustom3B.text().toString();
                    loc3[1][3] = arg1.SettingValues.FavouriteCustom4B.text().toString();
                    loc3[1][4] = arg1.SettingValues.FavouriteCustom5B.text().toString();
                    loc3[1][5] = arg1.SettingValues.FavouriteCustom6B.text().toString();
                }
                (loc6 = (arg2 as core.settings.SettingsROX100).favoritesAltitude).splice(0, 2);
                loc6[0] = new __AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>(3, true);
                loc6[0][0] = new __AS3__.vec.Vector.<String>(2, true);
                loc6[0][0][0] = arg1.SettingValues.FavouritesAltitude1.FavouritesAltitude1_1.FavouriteAltitude1A.text().toString();
                loc6[0][0][1] = arg1.SettingValues.FavouritesAltitude1.FavouritesAltitude1_1.FavouriteAltitude1B.text().toString();
                loc6[0][1] = new __AS3__.vec.Vector.<String>(2, true);
                loc6[0][1][0] = arg1.SettingValues.FavouritesAltitude1.FavouritesAltitude1_2.FavouriteAltitude2A.text().toString();
                loc6[0][1][1] = arg1.SettingValues.FavouritesAltitude1.FavouritesAltitude1_2.FavouriteAltitude2B.text().toString();
                loc6[0][2] = new __AS3__.vec.Vector.<String>(2, true);
                loc6[0][2][0] = arg1.SettingValues.FavouritesAltitude1.FavouritesAltitude1_3.FavouriteAltitude3A.text().toString();
                loc6[0][2][1] = arg1.SettingValues.FavouritesAltitude1.FavouritesAltitude1_3.FavouriteAltitude3B.text().toString();
                loc6[1] = new __AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>(3, true);
                loc6[1][0] = new __AS3__.vec.Vector.<String>(2, true);
                loc6[1][0][0] = arg1.SettingValues.FavouritesAltitude2.FavouritesAltitude2_1.FavouriteAltitude1A.text().toString();
                loc6[1][0][1] = arg1.SettingValues.FavouritesAltitude2.FavouritesAltitude2_1.FavouriteAltitude1B.text().toString();
                loc6[1][1] = new __AS3__.vec.Vector.<String>(2, true);
                loc6[1][1][0] = arg1.SettingValues.FavouritesAltitude2.FavouritesAltitude2_2.FavouriteAltitude2A.text().toString();
                loc6[1][1][1] = arg1.SettingValues.FavouritesAltitude2.FavouritesAltitude2_2.FavouriteAltitude2B.text().toString();
                loc6[1][2] = new __AS3__.vec.Vector.<String>(2, true);
                loc6[1][2][0] = arg1.SettingValues.FavouritesAltitude2.FavouritesAltitude2_3.FavouriteAltitude3A.text().toString();
                loc6[1][2][1] = arg1.SettingValues.FavouritesAltitude2.FavouritesAltitude2_3.FavouriteAltitude3B.text().toString();
                (loc7 = (arg2 as core.settings.SettingsROX100).favoritesLap).splice(0, 2);
                loc7[0] = new __AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>(3, true);
                loc7[0][0] = new __AS3__.vec.Vector.<String>(2, true);
                loc7[0][0][0] = arg1.SettingValues.FavouritesLap1.FavouritesLap1_1.FavouriteLap1A.text().toString();
                loc7[0][0][1] = arg1.SettingValues.FavouritesLap1.FavouritesLap1_1.FavouriteLap1B.text().toString();
                loc7[0][1] = new __AS3__.vec.Vector.<String>(2, true);
                loc7[0][1][0] = arg1.SettingValues.FavouritesLap1.FavouritesLap1_2.FavouriteLap2A.text().toString();
                loc7[0][1][1] = arg1.SettingValues.FavouritesLap1.FavouritesLap1_2.FavouriteLap2B.text().toString();
                loc7[0][2] = new __AS3__.vec.Vector.<String>(2, true);
                loc7[0][2][0] = arg1.SettingValues.FavouritesLap1.FavouritesLap1_3.FavouriteLap3A.text().toString();
                loc7[0][2][1] = arg1.SettingValues.FavouritesLap1.FavouritesLap1_3.FavouriteLap3B.text().toString();
                loc7[1] = new __AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>(3, true);
                loc7[1][0] = new __AS3__.vec.Vector.<String>(2, true);
                loc7[1][0][0] = arg1.SettingValues.FavouritesLap2.FavouritesLap2_1.FavouriteLap1A.text().toString();
                loc7[1][0][1] = arg1.SettingValues.FavouritesLap2.FavouritesLap2_1.FavouriteLap1B.text().toString();
                loc7[1][1] = new __AS3__.vec.Vector.<String>(2, true);
                loc7[1][1][0] = arg1.SettingValues.FavouritesLap2.FavouritesLap2_2.FavouriteLap2A.text().toString();
                loc7[1][1][1] = arg1.SettingValues.FavouritesLap2.FavouritesLap2_2.FavouriteLap2B.text().toString();
                loc7[1][2] = new __AS3__.vec.Vector.<String>(2, true);
                loc7[1][2][0] = arg1.SettingValues.FavouritesLap2.FavouritesLap2_3.FavouriteLap3A.text().toString();
                loc7[1][2][1] = arg1.SettingValues.FavouritesLap2.FavouritesLap2_3.FavouriteLap3B.text().toString();
            }
            return;
        }

        public static function generateXML(arg1:core.settings.Settings):XML
        {
            var loc3:*=undefined;
            var loc4:*=0;
            var loc2:*=undefined;
            var loc5:*=0;
            var loc1:*=new XML("<SettingInformation/>");
            var loc6:*;
            (loc6 = new XML("<GeneralInformation/>")).@unit = arg1.unit.type.toString();
            loc6.@serialNumber = arg1.unit.serialNumber;
            loc6.GUID = arg1.GUID;
            loc6.unitGUID = arg1.unitGUID;
            loc6.modificationDate = arg1.modificationDate;
            loc6.FileDate = new Date();
            loc1.appendChild(loc6);
            var loc7:*=new XML("<SettingValues/>");
            if (arg1 is core.settings.interfaces.IActualAltitude) 
            {
                var loc8:*;
                loc7.ActualAltitude = loc8 = (arg1 as core.settings.interfaces.IActualAltitude).actualAltitude;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IAge) 
            {
                loc7.Age = loc8 = (arg1 as core.settings.interfaces.IAge).age;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IAlarm) 
            {
                loc7.Alarm = loc8 = (arg1 as core.settings.interfaces.IAlarm).alarm;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IAlarmMode) 
            {
                loc7.AlarmMode = loc8 = (arg1 as core.settings.interfaces.IAlarmMode).alarmMode;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IAltitudeReference) 
            {
                loc7.AltitudeReference = loc8 = (arg1 as core.settings.interfaces.IAltitudeReference).altitudeReference;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IAltitudeUnit) 
            {
                loc7.AltitudeUnit = loc8 = (arg1 as core.settings.interfaces.IAltitudeUnit).altitudeUnit;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IAutoPause) 
            {
                loc7.AutoPause = loc8 = (arg1 as core.settings.interfaces.IAutoPause).autoPause;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IAutoZoomTrack) 
            {
                loc7.AutoZoomTrack = loc8 = (arg1 as core.settings.interfaces.IAutoZoomTrack).autoZoomTrack;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IAutoOffTime && (arg1 as core.settings.interfaces.IAutoOffTime).autoOffTime) 
            {
                loc7.AutoOffTime = loc8 = (arg1 as core.settings.interfaces.IAutoOffTime).autoOffTime.toString();
            }
            undefined;
            if (arg1 is core.settings.interfaces.IBacklightTime) 
            {
                loc7.BacklightTime = loc8 = (arg1 as core.settings.interfaces.IBacklightTime).backlightTime;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IBacklightLevel) 
            {
                loc7.BacklightLevel = loc8 = (arg1 as core.settings.interfaces.IBacklightLevel).backlightLevel;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IBikeType1) 
            {
                loc7.BikeType1 = loc8 = (arg1 as core.settings.interfaces.IBikeType1).bikeType1;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IBikeType2) 
            {
                loc7.BikeType2 = loc8 = (arg1 as core.settings.interfaces.IBikeType2).bikeType2;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IBikeType3) 
            {
                loc7.BikeType3 = loc8 = (arg1 as core.settings.interfaces.IBikeType3).bikeType3;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IBikeWeight1) 
            {
                loc7.BikeWeight1 = loc8 = (arg1 as core.settings.interfaces.IBikeWeight1).bikeWeight1;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IBikeWeight1Unit) 
            {
                loc7.BikeWeight1Unit = loc8 = (arg1 as core.settings.interfaces.IBikeWeight1Unit).bikeWeight1Unit;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IBikeWeight2) 
            {
                loc7.BikeWeight2 = loc8 = (arg1 as core.settings.interfaces.IBikeWeight2).bikeWeight2;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IBikeWeight2Unit) 
            {
                loc7.BikeWeight2Unit = loc8 = (arg1 as core.settings.interfaces.IBikeWeight2Unit).bikeWeight2Unit;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IBikeWeight3) 
            {
                loc7.BikeWeight3 = loc8 = (arg1 as core.settings.interfaces.IBikeWeight3).bikeWeight3;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IBirthDate) 
            {
                loc7.BirthDate = loc8 = (arg1 as core.settings.interfaces.IBirthDate).birthDate;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IBodyHeight) 
            {
                loc7.BodyHeight = loc8 = (arg1 as core.settings.interfaces.IBodyHeight).bodyHeight;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IBodyHeightUnit) 
            {
                loc7.BodyHeightUnit = loc8 = (arg1 as core.settings.interfaces.IBodyHeightUnit).bodyHeightUnit;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IBodyWeight) 
            {
                loc7.BodyWeight = loc8 = (arg1 as core.settings.interfaces.IBodyWeight).bodyWeight;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IBodyWeightUnit) 
            {
                loc7.WeightUnit = loc8 = (arg1 as core.settings.interfaces.IBodyWeightUnit).bodyWeightUnit;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IButtonInfo) 
            {
                loc7.ButtonInfo = loc8 = (arg1 as core.settings.interfaces.IButtonInfo).buttonInfo;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IButtonTone) 
            {
                loc7.ButtonTone = loc8 = (arg1 as core.settings.interfaces.IButtonTone).buttonTone;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ICalibration) 
            {
                loc7.Calibration = loc8 = (arg1 as core.settings.interfaces.ICalibration).calibration;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IClockMode) 
            {
                loc7.ClockMode = loc8 = (arg1 as core.settings.interfaces.IClockMode).clockMode;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IContrast) 
            {
                loc7.Contrast = loc8 = (arg1 as core.settings.interfaces.IContrast).contrast;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ICorrectionFactor) 
            {
                loc7.CorrectionFactor = loc8 = (arg1 as core.settings.interfaces.ICorrectionFactor).correctionFactor;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ICountdown) 
            {
                loc7.Countdown = loc8 = (arg1 as core.settings.interfaces.ICountdown).countdown;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ICountdown) 
            {
                loc7.CountdownOn = loc8 = (arg1 as core.settings.interfaces.ICountdown).countdownOn;
            }
            undefined;
            loc7.Date = arg1.date;
            if (arg1 is core.settings.interfaces.IDateFormat) 
            {
                loc7.DateFormat = loc8 = (arg1 as core.settings.interfaces.IDateFormat).dateFormat;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IDistanceUnit) 
            {
                loc7.DistanceUnit = loc8 = (arg1 as core.settings.interfaces.IDistanceUnit).distanceUnit;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IThreeZones) 
            {
                loc7.EndZone3 = loc8 = (arg1 as core.settings.interfaces.IThreeZones).endZone3;
            }
            undefined;
            if (arg1 is core.settings.SettingsROX100) 
            {
                loc7.FavoritesSelected = loc8 = (arg1 as core.settings.SettingsROX100).favoritesSelected;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingFree) 
            {
                loc7.FreeTrainingTargetZone = loc8 = (arg1 as core.settings.interfaces.ITrainingFree).freeTrainingTargetZone;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingFree) 
            {
                loc7.FreeOwnZone1LowerLimit = loc8 = (arg1 as core.settings.interfaces.ITrainingFree).freeOwnZone1LowerLimit;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingFree) 
            {
                loc7.FreeOwnZone1UpperLimit = loc8 = (arg1 as core.settings.interfaces.ITrainingFree).freeOwnZone1UpperLimit;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingFree) 
            {
                loc7.FreeOwnZone2LowerLimit = loc8 = (arg1 as core.settings.interfaces.ITrainingFree).freeOwnZone2LowerLimit;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingFree) 
            {
                loc7.FreeOwnZone2UpperLimit = loc8 = (arg1 as core.settings.interfaces.ITrainingFree).freeOwnZone2UpperLimit;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingFree) 
            {
                loc7.FreeOwnZone3LowerLimit = loc8 = (arg1 as core.settings.interfaces.ITrainingFree).freeOwnZone3LowerLimit;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingFree) 
            {
                loc7.FreeOwnZone3UpperLimit = loc8 = (arg1 as core.settings.interfaces.ITrainingFree).freeOwnZone3UpperLimit;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IFuelConsumption) 
            {
                loc7.FuelConsumption = loc8 = (arg1 as core.settings.interfaces.IFuelConsumption).fuelConsumption;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IFuelConsumptionUnit) 
            {
                loc7.FuelConsumptionUnit = loc8 = (arg1 as core.settings.interfaces.IFuelConsumptionUnit).fuelConsumptionUnit;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IGender) 
            {
                loc7.Gender = loc8 = (arg1 as core.settings.interfaces.IGender).gender;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IGPSFormat) 
            {
                loc7.GPSFormat = loc8 = (arg1 as core.settings.interfaces.IGPSFormat).gpsFormat;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IGPSStatus) 
            {
                loc7.GPSStatus = loc8 = (arg1 as core.settings.interfaces.IGPSStatus).gpsStatus;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IStravaSegmentsEnabled) 
            {
                loc7.StravaSegmentsEnabled = loc8 = (arg1 as core.settings.interfaces.IStravaSegmentsEnabled).stravaSegmentsEnabled;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrackDirection) 
            {
                loc7.TrackDirection = loc8 = (arg1 as core.settings.interfaces.ITrackDirection).trackDirection;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IHomeAltitude1) 
            {
                loc7.HomeAltitude1 = loc8 = (arg1 as core.settings.interfaces.IHomeAltitude1).homeAltitude1;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IHomeAltitude2) 
            {
                loc7.HomeAltitude2 = loc8 = (arg1 as core.settings.interfaces.IHomeAltitude2).homeAltitude2;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IHomeAltitude3) 
            {
                loc7.HomeAltitude3 = loc8 = (arg1 as core.settings.interfaces.IHomeAltitude3).homeAltitude3;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IHRmax) 
            {
                loc7.HrMax = loc8 = (arg1 as core.settings.interfaces.IHRmax).hrMax;
            }
            undefined;
            if (arg1 is core.units.interfaces.IIntensityZonesPercentage) 
            {
                loc7.IntensityZone1 = loc8 = (arg1 as core.units.interfaces.IIntensityZonesPercentage).intensityZone1PercentageStart;
            }
            undefined;
            if (arg1 is core.units.interfaces.IIntensityZonesPercentage) 
            {
                loc7.IntensityZone2 = loc8 = (arg1 as core.units.interfaces.IIntensityZonesPercentage).intensityZone2PercentageStart;
            }
            undefined;
            if (arg1 is core.units.interfaces.IIntensityZonesPercentage) 
            {
                loc7.IntensityZone3 = loc8 = (arg1 as core.units.interfaces.IIntensityZonesPercentage).intensityZone3PercentageStart;
            }
            undefined;
            if (arg1 is core.units.interfaces.IIntensityZonesPercentage) 
            {
                loc7.IntensityZone4End = loc8 = (arg1 as core.units.interfaces.IIntensityZonesPercentage).intensityZone4PercentageEnd;
            }
            undefined;
            if (arg1 is core.units.interfaces.IIntensityZonesPercentage) 
            {
                loc7.IntensityZone4 = loc8 = (arg1 as core.units.interfaces.IIntensityZonesPercentage).intensityZone4PercentageStart;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingIntervalCoolDown) 
            {
                loc7.IntervalCoolDownTargetZoneLowerLimit = loc8 = (arg1 as core.settings.interfaces.ITrainingIntervalCoolDown).intervalCoolDownTargetZoneLowerLimit;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingIntervalCoolDown) 
            {
                loc7.IntervalCoolDownTargetZoneUpperLimit = loc8 = (arg1 as core.settings.interfaces.ITrainingIntervalCoolDown).intervalCoolDownTargetZoneUpperLimit;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingIntervalCoolDown) 
            {
                loc7.IntervalCoolDownTime = loc8 = (arg1 as core.settings.interfaces.ITrainingIntervalCoolDown).intervalCoolDownTime;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingInterval) 
            {
                loc7.IntervalRecoveryHR = loc8 = (arg1 as core.settings.interfaces.ITrainingInterval).intervalRecoveryHR;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingInterval && (arg1 as core.settings.interfaces.ITrainingInterval).intervalRecoveryMode) 
            {
                loc7.IntervalRecoveryMode = loc8 = (arg1 as core.settings.interfaces.ITrainingInterval).intervalRecoveryMode.toString();
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingInterval) 
            {
                loc7.IntervalRecoveryTime = loc8 = (arg1 as core.settings.interfaces.ITrainingInterval).intervalRecoveryTime;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingInterval) 
            {
                loc7.IntervalTargetZoneLowerLimit = loc8 = (arg1 as core.settings.interfaces.ITrainingInterval).intervalTargetZoneLowerLimit;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingInterval) 
            {
                loc7.IntervalTargetZoneUpperLimit = loc8 = (arg1 as core.settings.interfaces.ITrainingInterval).intervalTargetZoneUpperLimit;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingInterval) 
            {
                loc7.IntervalTime = loc8 = (arg1 as core.settings.interfaces.ITrainingInterval).intervalTime;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingIntervalWarmUp) 
            {
                loc7.IntervalWarmUpTargetZoneLowerLimit = loc8 = (arg1 as core.settings.interfaces.ITrainingIntervalWarmUp).intervalWarmUpTargetZoneLowerLimit;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingIntervalWarmUp) 
            {
                loc7.IntervalWarmUpTargetZoneUpperLimit = loc8 = (arg1 as core.settings.interfaces.ITrainingIntervalWarmUp).intervalWarmUpTargetZoneUpperLimit;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingIntervalWarmUp) 
            {
                loc7.IntervalWarmUpTime = loc8 = (arg1 as core.settings.interfaces.ITrainingIntervalWarmUp).intervalWarmUpTime;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ILanguage) 
            {
                loc7.Language = loc8 = (arg1 as core.settings.interfaces.ILanguage).language;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ILowBatDetectLevel) 
            {
                loc7.LowBatteryDetectLevel = loc8 = (arg1 as core.settings.interfaces.ILowBatDetectLevel).lowBatDetectLevel;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IHeartrateLimits) 
            {
                loc7.LowerLimit = loc8 = (arg1 as core.settings.interfaces.IHeartrateLimits).lowerLimit;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IHeartrateSensor) 
            {
                loc7.HeartrateSensorActive = loc8 = (arg1 as core.settings.interfaces.IHeartrateSensor).heartrateSensorActive;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ICadenceSensor) 
            {
                loc7.CadenceSensorActive = loc8 = (arg1 as core.settings.interfaces.ICadenceSensor).cadenceSensorActive;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IMyName) 
            {
                loc7.myName = loc8 = utils.format.CDATAFormat.getCDataAsXMLNode("MyName", (arg1 as core.settings.interfaces.IMyName).myName);
            }
            undefined;
            loc7.name = utils.format.CDATAFormat.getCDataAsXMLNode("Name", arg1.name);
            if (arg1 is core.settings.interfaces.IOffTrackAlarm) 
            {
                loc7.OffTrackAlarm = loc8 = (arg1 as core.settings.interfaces.IOffTrackAlarm).offTrackAlarm;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IPowerMeterFormula) 
            {
                loc7.PowerMeterFormula = loc8 = (arg1 as core.settings.interfaces.IPowerMeterFormula).powerMeterFormula;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IPowerTargetZone) 
            {
                loc7.PowerTargetZoneEnabled = loc8 = (arg1 as core.settings.interfaces.IPowerTargetZone).powerTargetZoneEnabled;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IPowerTargetZone) 
            {
                loc7.PowerTargetZoneLowerLimit = loc8 = (arg1 as core.settings.interfaces.IPowerTargetZone).powerTargetZoneLowerLimit;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IPowerTargetZone) 
            {
                loc7.PowerTargetZoneUpperLimit = loc8 = (arg1 as core.settings.interfaces.IPowerTargetZone).powerTargetZoneUpperLimit;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IPowerIntensityZone) 
            {
                loc7.PowerIntensityZone1Start = loc8 = (arg1 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone1Start;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IPowerIntensityZone) 
            {
                loc7.PowerIntensityZone2Start = loc8 = (arg1 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone2Start;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IPowerIntensityZone) 
            {
                loc7.PowerIntensityZone3Start = loc8 = (arg1 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone3Start;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IPowerIntensityZone) 
            {
                loc7.PowerIntensityZone4Start = loc8 = (arg1 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone4Start;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IPowerIntensityZone) 
            {
                loc7.PowerIntensityZone5Start = loc8 = (arg1 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone5Start;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IPowerIntensityZone) 
            {
                loc7.PowerIntensityZone6Start = loc8 = (arg1 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone6Start;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IPowerIntensityZone) 
            {
                loc7.PowerIntensityZone7Start = loc8 = (arg1 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone7Start;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IPowerIntensityZone) 
            {
                loc7.PowerIntensityZone7End = loc8 = (arg1 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone7End;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ISamplingRate) 
            {
                loc7.SamplingRate = loc8 = (arg1 as core.settings.interfaces.ISamplingRate).samplingRate;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IAutoScan) 
            {
                loc7.AutoScan = loc8 = (arg1 as core.settings.interfaces.IAutoScan).scanFlagOn;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ISeaLevel) 
            {
                loc7.SeaLevel = loc8 = (arg1 as core.settings.interfaces.ISeaLevel).seaLevel;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IService) 
            {
                loc7.ServiceInterval = loc8 = (arg1 as core.settings.interfaces.IService).serviceInterval;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IService) 
            {
                loc7.ServiceStatus = loc8 = (arg1 as core.settings.interfaces.IService).serviceStatusOn;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IShoulderWidth) 
            {
                loc7.ShoulderWidth = loc8 = (arg1 as core.settings.interfaces.IShoulderWidth).shoulderWidth;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IShoulderWidthUnit) 
            {
                loc7.ShoulderWidthUnit = loc8 = (arg1 as core.settings.interfaces.IShoulderWidthUnit).shoulderWidthUnit;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IShowTotals) 
            {
                loc7.ShowTotals = loc8 = (arg1 as core.settings.interfaces.IShowTotals).showTotals;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ISpeedUnit) 
            {
                loc7.Measurement = loc8 = (arg1 as core.settings.interfaces.ISpeedUnit).speedUnit;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IThreeZones) 
            {
                loc7.StartZone1 = loc8 = (arg1 as core.settings.interfaces.IThreeZones).startZone1;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IThreeZones) 
            {
                loc7.StartZone2 = loc8 = (arg1 as core.settings.interfaces.IThreeZones).startZone2;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IThreeZones) 
            {
                loc7.StartZone3 = loc8 = (arg1 as core.settings.interfaces.IThreeZones).startZone3;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ISummerTime) 
            {
                loc7.SummerTime = loc8 = (arg1 as core.settings.interfaces.ISummerTime).summerTime;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ISystemTone) 
            {
                loc7.SystemTone = loc8 = (arg1 as core.settings.interfaces.ISystemTone).systemTone;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITemperatureUnit) 
            {
                loc7.TemperatureUnit = loc8 = (arg1 as core.settings.interfaces.ITemperatureUnit).temperatureUnit;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITimeZone) 
            {
                loc7.TimeZone = loc8 = (arg1 as core.settings.interfaces.ITimeZone).timeZone;
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITrainingZone) 
            {
                loc7.TrainingZone = loc8 = (arg1 as core.settings.interfaces.ITrainingZone).trainingZone;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IHeartrateLimits) 
            {
                loc7.UpperLimit = loc8 = (arg1 as core.settings.interfaces.IHeartrateLimits).upperLimit;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IVolume) 
            {
                loc7.Volume = loc8 = (arg1 as core.settings.interfaces.IVolume).volume;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IWayPointAlarm) 
            {
                loc7.WaypointAlarm = loc8 = (arg1 as core.settings.interfaces.IWayPointAlarm).waypointAlarm;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IWheelSize1) 
            {
                loc7.WheelSize1 = loc8 = (arg1 as core.settings.interfaces.IWheelSize1).wheelSize1;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IWheelSize2) 
            {
                loc7.WheelSize2 = loc8 = (arg1 as core.settings.interfaces.IWheelSize2).wheelSize2;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IWheelSize3) 
            {
                loc7.WheelSize3 = loc8 = (arg1 as core.settings.interfaces.IWheelSize3).wheelSize3;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IWheelSize1Mode) 
            {
                loc7.WheelSize1Mode = loc8 = (arg1 as core.settings.interfaces.IWheelSize1Mode).wheelSize1Mode.toString();
            }
            undefined;
            if (arg1 is core.settings.interfaces.IWheelSize2Mode) 
            {
                loc7.WheelSize2Mode = loc8 = (arg1 as core.settings.interfaces.IWheelSize2Mode).wheelSize2Mode.toString();
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITireSize1) 
            {
                loc7.TireSize1 = loc8 = (arg1 as core.settings.interfaces.ITireSize1).tireSize1.toString();
            }
            undefined;
            if (arg1 is core.settings.interfaces.ITireSize2) 
            {
                loc7.TireSize2 = loc8 = (arg1 as core.settings.interfaces.ITireSize2).tireSize2.toString();
            }
            undefined;
            if (arg1 is core.settings.interfaces.IYearOfBirth) 
            {
                loc7.YearOfBirth = loc8 = (arg1 as core.settings.interfaces.IYearOfBirth).yearOfBirth;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IZoneAlarm) 
            {
                loc7.ZoneAlarm = loc8 = (arg1 as core.settings.interfaces.IZoneAlarm).zoneAlarm;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IPhaseAlarm) 
            {
                loc7.PhaseAlarm = loc8 = (arg1 as core.settings.interfaces.IPhaseAlarm).phaseAlarm;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IKeyLock) 
            {
                loc7.KeyLock = loc8 = (arg1 as core.settings.interfaces.IKeyLock).keyLock;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IPowerSaveMode) 
            {
                loc7.PowerSaveModeActive = loc8 = (arg1 as core.settings.interfaces.IPowerSaveMode).powerSaveModeActive;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IBacklight) 
            {
                loc7.BacklightActive = loc8 = (arg1 as core.settings.interfaces.IBacklight).backlightActive;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IBacklightTimeOn) 
            {
                loc7.BacklightTimeOn = loc8 = (arg1 as core.settings.interfaces.IBacklightTimeOn).backlightTimeOn;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IBacklightTimeOff) 
            {
                loc7.BacklightTimeOff = loc8 = (arg1 as core.settings.interfaces.IBacklightTimeOff).backlightTimeOff;
            }
            undefined;
            if (arg1 is core.settings.interfaces.INfc) 
            {
                loc7.NFCActive = loc8 = (arg1 as core.settings.interfaces.INfc).nfcActive;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IETADistance) 
            {
                loc7.ETADistance = loc8 = (arg1 as core.settings.interfaces.IETADistance).etaDistance;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IETAArivalFlag) 
            {
                loc7.ETAArivalFlag = loc8 = (arg1 as core.settings.interfaces.IETAArivalFlag).etaArivalFlag;
            }
            undefined;
            if (arg1 is core.settings.interfaces.IFavoriteTrip1) 
            {
                loc3 = (arg1 as core.settings.interfaces.IFavoriteTrip1).favoritesTrip1;
                loc4 = 0;
                while (loc4 < (arg1 as core.settings.interfaces.IFavoriteTrip1).favoritesTrip1Size) 
                {
                    loc7.FavouritesTrip1["Fav" + (loc4 + 1)] = loc3[loc4];
                    ++loc4;
                }
            }
            if (arg1 is core.settings.interfaces.IFavoriteTrip2) 
            {
                loc2 = (arg1 as core.settings.interfaces.IFavoriteTrip2).favoritesTrip2;
                loc5 = 0;
                while (loc5 < (arg1 as core.settings.interfaces.IFavoriteTrip2).favoritesTrip2Size) 
                {
                    loc7.FavouritesTrip2["Fav" + (loc5 + 1)] = loc2[loc5];
                    ++loc5;
                }
            }
            if (arg1 is core.settings.SettingsROX100) 
            {
                loc7.FavouritesTrack1.FavouritesTrack1_1.FavouriteTrack1A = (arg1 as core.settings.SettingsROX100).favoritesTrack[0][0][0];
                loc7.FavouritesTrack1.FavouritesTrack1_1.FavouriteTrack1B = (arg1 as core.settings.SettingsROX100).favoritesTrack[0][0][1];
                loc7.FavouritesTrack1.FavouritesTrack1_2.FavouriteTrack2A = (arg1 as core.settings.SettingsROX100).favoritesTrack[0][1][0];
                loc7.FavouritesTrack1.FavouritesTrack1_2.FavouriteTrack2B = (arg1 as core.settings.SettingsROX100).favoritesTrack[0][1][1];
                loc7.FavouritesTrack1.FavouritesTrack1_3.FavouriteTrack3A = (arg1 as core.settings.SettingsROX100).favoritesTrack[0][2][0];
                loc7.FavouritesTrack1.FavouritesTrack1_3.FavouriteTrack3B = (arg1 as core.settings.SettingsROX100).favoritesTrack[0][2][1];
                loc7.FavouritesTrack2.FavouritesTrack2_1.FavouriteTrack1A = (arg1 as core.settings.SettingsROX100).favoritesTrack[1][0][0];
                loc7.FavouritesTrack2.FavouritesTrack2_1.FavouriteTrack1B = (arg1 as core.settings.SettingsROX100).favoritesTrack[1][0][1];
                loc7.FavouritesTrack2.FavouritesTrack2_2.FavouriteTrack2A = (arg1 as core.settings.SettingsROX100).favoritesTrack[1][1][0];
                loc7.FavouritesTrack2.FavouritesTrack2_2.FavouriteTrack2B = (arg1 as core.settings.SettingsROX100).favoritesTrack[1][1][1];
                loc7.FavouritesTrack2.FavouritesTrack2_3.FavouriteTrack3A = (arg1 as core.settings.SettingsROX100).favoritesTrack[1][2][0];
                loc7.FavouritesTrack2.FavouritesTrack2_3.FavouriteTrack3B = (arg1 as core.settings.SettingsROX100).favoritesTrack[1][2][1];
                if (core.units.UnitROX100.getSoftwareRevisionNumber((arg1 as core.settings.SettingsROX100).unit.softwareRevision) >= 1403271) 
                {
                    loc7.FavouritesCustomA_PageCount = (arg1 as core.settings.interfaces.IFavoritesCustom).favoritesCustomPageCount[0];
                    loc7.FavouriteCustom1A = (arg1 as core.settings.interfaces.IFavoritesCustom).favoritesCustom[0][0];
                    loc7.FavouriteCustom2A = (arg1 as core.settings.interfaces.IFavoritesCustom).favoritesCustom[0][1];
                    loc7.FavouriteCustom3A = (arg1 as core.settings.interfaces.IFavoritesCustom).favoritesCustom[0][2];
                    loc7.FavouriteCustom4A = (arg1 as core.settings.interfaces.IFavoritesCustom).favoritesCustom[0][3];
                    loc7.FavouriteCustom5A = (arg1 as core.settings.interfaces.IFavoritesCustom).favoritesCustom[0][4];
                    loc7.FavouriteCustom6A = (arg1 as core.settings.interfaces.IFavoritesCustom).favoritesCustom[0][5];
                    loc7.FavouritesCustomB_PageCount = (arg1 as core.settings.interfaces.IFavoritesCustom).favoritesCustomPageCount[1];
                    loc7.FavouriteCustom1B = (arg1 as core.settings.interfaces.IFavoritesCustom).favoritesCustom[1][0];
                    loc7.FavouriteCustom2B = (arg1 as core.settings.interfaces.IFavoritesCustom).favoritesCustom[1][1];
                    loc7.FavouriteCustom3B = (arg1 as core.settings.interfaces.IFavoritesCustom).favoritesCustom[1][2];
                    loc7.FavouriteCustom4B = (arg1 as core.settings.interfaces.IFavoritesCustom).favoritesCustom[1][3];
                    loc7.FavouriteCustom5B = (arg1 as core.settings.interfaces.IFavoritesCustom).favoritesCustom[1][4];
                    loc7.FavouriteCustom6B = (arg1 as core.settings.interfaces.IFavoritesCustom).favoritesCustom[1][5];
                }
                loc7.FavouritesAltitude1.FavouritesAltitude1_1.FavouriteAltitude1A = (arg1 as core.settings.SettingsROX100).favoritesAltitude[0][0][0];
                loc7.FavouritesAltitude1.FavouritesAltitude1_1.FavouriteAltitude1B = (arg1 as core.settings.SettingsROX100).favoritesAltitude[0][0][1];
                loc7.FavouritesAltitude1.FavouritesAltitude1_2.FavouriteAltitude2A = (arg1 as core.settings.SettingsROX100).favoritesAltitude[0][1][0];
                loc7.FavouritesAltitude1.FavouritesAltitude1_2.FavouriteAltitude2B = (arg1 as core.settings.SettingsROX100).favoritesAltitude[0][1][1];
                loc7.FavouritesAltitude1.FavouritesAltitude1_3.FavouriteAltitude3A = (arg1 as core.settings.SettingsROX100).favoritesAltitude[0][2][0];
                loc7.FavouritesAltitude1.FavouritesAltitude1_3.FavouriteAltitude3B = (arg1 as core.settings.SettingsROX100).favoritesAltitude[0][2][1];
                loc7.FavouritesAltitude2.FavouritesAltitude2_1.FavouriteAltitude1A = (arg1 as core.settings.SettingsROX100).favoritesAltitude[1][0][0];
                loc7.FavouritesAltitude2.FavouritesAltitude2_1.FavouriteAltitude1B = (arg1 as core.settings.SettingsROX100).favoritesAltitude[1][0][1];
                loc7.FavouritesAltitude2.FavouritesAltitude2_2.FavouriteAltitude2A = (arg1 as core.settings.SettingsROX100).favoritesAltitude[1][1][0];
                loc7.FavouritesAltitude2.FavouritesAltitude2_2.FavouriteAltitude2B = (arg1 as core.settings.SettingsROX100).favoritesAltitude[1][1][1];
                loc7.FavouritesAltitude2.FavouritesAltitude2_3.FavouriteAltitude3A = (arg1 as core.settings.SettingsROX100).favoritesAltitude[1][2][0];
                loc7.FavouritesAltitude2.FavouritesAltitude2_3.FavouriteAltitude3B = (arg1 as core.settings.SettingsROX100).favoritesAltitude[1][2][1];
                loc7.FavouritesLap1.FavouritesLap1_1.FavouriteLap1A = (arg1 as core.settings.SettingsROX100).favoritesLap[0][0][0];
                loc7.FavouritesLap1.FavouritesLap1_1.FavouriteLap1B = (arg1 as core.settings.SettingsROX100).favoritesLap[0][0][1];
                loc7.FavouritesLap1.FavouritesLap1_2.FavouriteLap2A = (arg1 as core.settings.SettingsROX100).favoritesLap[0][1][0];
                loc7.FavouritesLap1.FavouritesLap1_2.FavouriteLap2B = (arg1 as core.settings.SettingsROX100).favoritesLap[0][1][1];
                loc7.FavouritesLap1.FavouritesLap1_3.FavouriteLap3A = (arg1 as core.settings.SettingsROX100).favoritesLap[0][2][0];
                loc7.FavouritesLap1.FavouritesLap1_3.FavouriteLap3B = (arg1 as core.settings.SettingsROX100).favoritesLap[0][2][1];
                loc7.FavouritesLap2.FavouritesLap2_1.FavouriteLap1A = (arg1 as core.settings.SettingsROX100).favoritesLap[1][0][0];
                loc7.FavouritesLap2.FavouritesLap2_1.FavouriteLap1B = (arg1 as core.settings.SettingsROX100).favoritesLap[1][0][1];
                loc7.FavouritesLap2.FavouritesLap2_2.FavouriteLap2A = (arg1 as core.settings.SettingsROX100).favoritesLap[1][1][0];
                loc7.FavouritesLap2.FavouritesLap2_2.FavouriteLap2B = (arg1 as core.settings.SettingsROX100).favoritesLap[1][1][1];
                loc7.FavouritesLap2.FavouritesLap2_3.FavouriteLap3A = (arg1 as core.settings.SettingsROX100).favoritesLap[1][2][0];
                loc7.FavouritesLap2.FavouritesLap2_3.FavouriteLap3B = (arg1 as core.settings.SettingsROX100).favoritesLap[1][2][1];
            }
            loc1.appendChild(loc7);
            return loc1;
        }

        public static function generateDBInsert(arg1:core.settings.Settings, arg2:Array, arg3:Object):void
        {
            var loc3:*=0;
            var loc4:*=0;
            var loc2:*=0;
            var loc5:*=0;
            if (arg1.GUID == "" || arg1.GUID == "0") 
            {
                arg1.GUID = utils.GUID.create();
            }
            if (arg1.modificationDate == 0) 
            {
                arg1.modificationDate = new Date().time;
            }
            var loc1:*=0;
            arg2.push("settingsId");
            ++loc1;
            arg3[loc1] = arg1.settingsId > 0 ? arg1.settingsId : null;
            arg2.push("GUID");
            ++loc1;
            arg3[loc1] = arg1.GUID;
            arg2.push("unitGUID");
            ++loc1;
            arg3[loc1] = arg1.unitGUID;
            arg2.push("modificationDate");
            ++loc1;
            arg3[loc1] = arg1.modificationDate;
            arg2.push("isDeleted");
            ++loc1;
            arg3[loc1] = arg1.isDeleted;
            arg2.push("date");
            ++loc1;
            arg3[loc1] = arg1.date.toString();
            if (arg1 is core.settings.interfaces.IActualAltitude) 
            {
                arg2.push("actualAltitude");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IActualAltitude).actualAltitude;
            }
            if (arg1 is core.settings.interfaces.IAge) 
            {
                arg2.push("age");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IAge).age;
            }
            if (arg1 is core.settings.interfaces.IAlarm && (arg1 as core.settings.interfaces.IAlarm).alarm) 
            {
                arg2.push("alarm");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IAlarm).alarm.toString();
            }
            if (arg1 is core.settings.interfaces.IAlarmMode) 
            {
                arg2.push("alarmMode");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IAlarmMode).alarmMode;
            }
            if (arg1 is core.settings.interfaces.IAltitudeReference) 
            {
                arg2.push("altitudeReference");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IAltitudeReference).altitudeReference;
            }
            if (arg1 is core.settings.interfaces.IAltitudeUnit) 
            {
                arg2.push("altitudeUnit");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IAltitudeUnit).altitudeUnit;
            }
            if (arg1 is core.settings.interfaces.IAutoPause) 
            {
                arg2.push("autoPause");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IAutoPause).autoPause;
            }
            if (arg1 is core.settings.interfaces.IAutoZoomTrack) 
            {
                arg2.push("autoZoomTrack");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IAutoZoomTrack).autoZoomTrack;
            }
            if (arg1 is core.settings.interfaces.IAutoOffTime && (arg1 as core.settings.interfaces.IAutoOffTime).autoOffTime) 
            {
                arg2.push("autoOffTime");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IAutoOffTime).autoOffTime.toString();
            }
            if (arg1 is core.settings.interfaces.IBacklightTime) 
            {
                arg2.push("backlightTime");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IBacklightTime).backlightTime;
            }
            if (arg1 is core.settings.interfaces.IBacklightLevel) 
            {
                arg2.push("backlightLevel");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IBacklightLevel).backlightLevel;
            }
            if (arg1 is core.settings.interfaces.IBikeType1) 
            {
                arg2.push("bikeType1");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IBikeType1).bikeType1;
            }
            if (arg1 is core.settings.interfaces.IBikeType2) 
            {
                arg2.push("bikeType2");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IBikeType2).bikeType2;
            }
            if (arg1 is core.settings.interfaces.IBikeType3) 
            {
                arg2.push("bikeType3");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IBikeType3).bikeType3;
            }
            if (arg1 is core.settings.interfaces.IBikeWeight1) 
            {
                arg2.push("bikeWeight1");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IBikeWeight1).bikeWeight1;
            }
            if (arg1 is core.settings.interfaces.IBikeWeight1Unit) 
            {
                arg2.push("bikeWeight1Unit");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IBikeWeight1Unit).bikeWeight1Unit;
            }
            if (arg1 is core.settings.interfaces.IBikeWeight2) 
            {
                arg2.push("bikeWeight2");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IBikeWeight2).bikeWeight2;
            }
            if (arg1 is core.settings.interfaces.IBikeWeight2Unit) 
            {
                arg2.push("bikeWeight2Unit");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IBikeWeight2Unit).bikeWeight2Unit;
            }
            if (arg1 is core.settings.interfaces.IBikeWeight3) 
            {
                arg2.push("bikeWeight3");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IBikeWeight3).bikeWeight3;
            }
            if (arg1 is core.settings.interfaces.IBirthDate && (arg1 as core.settings.interfaces.IBirthDate).birthDate) 
            {
                arg2.push("birthDate");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IBirthDate).birthDate.toString();
            }
            if (arg1 is core.settings.interfaces.IBodyHeight) 
            {
                arg2.push("bodyHeight");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IBodyHeight).bodyHeight;
            }
            if (arg1 is core.settings.interfaces.IBodyHeightUnit) 
            {
                arg2.push("bodyHeightUnit");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IBodyHeightUnit).bodyHeightUnit;
            }
            if (arg1 is core.settings.interfaces.IBodyWeight) 
            {
                arg2.push("bodyWeight");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IBodyWeight).bodyWeight;
            }
            if (arg1 is core.settings.interfaces.IBodyWeightUnit) 
            {
                arg2.push("bodyWeightUnit");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IBodyWeightUnit).bodyWeightUnit;
            }
            if (arg1 is core.settings.interfaces.IButtonInfo) 
            {
                arg2.push("buttonInfo");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IButtonInfo).buttonInfo;
            }
            if (arg1 is core.settings.interfaces.IButtonTone) 
            {
                arg2.push("buttonTone");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IButtonTone).buttonTone;
            }
            if (arg1 is core.settings.interfaces.ICalibration) 
            {
                arg2.push("calibration");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ICalibration).calibration;
            }
            if (arg1 is core.settings.interfaces.IClockMode) 
            {
                arg2.push("clockMode");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IClockMode).clockMode;
            }
            if (arg1 is core.settings.interfaces.IContrast) 
            {
                arg2.push("contrast");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IContrast).contrast;
            }
            if (arg1 is core.settings.interfaces.ICorrectionFactor) 
            {
                arg2.push("correctionFactor");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ICorrectionFactor).correctionFactor;
            }
            if (arg1 is core.settings.interfaces.ICountdown) 
            {
                arg2.push("countdown");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ICountdown).countdown;
                arg2.push("countdownOn");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ICountdown).countdownOn;
            }
            if (arg1 is core.settings.interfaces.IDateFormat) 
            {
                arg2.push("dateFormat");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IDateFormat).dateFormat;
            }
            if (arg1 is core.settings.interfaces.IDistanceUnit) 
            {
                arg2.push("distanceUnit");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IDistanceUnit).distanceUnit;
            }
            if (arg1 is core.settings.interfaces.IThreeZones) 
            {
                arg2.push("endZone3");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IThreeZones).endZone3;
            }
            if (arg1 is core.settings.interfaces.IFavoritesAltitude) 
            {
                arg2.push("favoritesAltitude1_1_A");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesAltitude).favoritesAltitude[0][0][0];
                arg2.push("favoritesAltitude1_1_B");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesAltitude).favoritesAltitude[0][0][1];
                arg2.push("favoritesAltitude1_2_A");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesAltitude).favoritesAltitude[0][1][0];
                arg2.push("favoritesAltitude1_2_B");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesAltitude).favoritesAltitude[0][1][1];
                arg2.push("favoritesAltitude1_3_A");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesAltitude).favoritesAltitude[0][2][0];
                arg2.push("favoritesAltitude1_3_B");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesAltitude).favoritesAltitude[0][2][1];
                arg2.push("favoritesAltitude2_1_A");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesAltitude).favoritesAltitude[1][0][0];
                arg2.push("favoritesAltitude2_1_B");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesAltitude).favoritesAltitude[1][0][1];
                arg2.push("favoritesAltitude2_2_A");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesAltitude).favoritesAltitude[1][1][0];
                arg2.push("favoritesAltitude2_2_B");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesAltitude).favoritesAltitude[1][1][1];
                arg2.push("favoritesAltitude2_3_A");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesAltitude).favoritesAltitude[1][2][0];
                arg2.push("favoritesAltitude2_3_B");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesAltitude).favoritesAltitude[1][2][1];
            }
            if (arg1 is core.settings.interfaces.IFavoritesLap) 
            {
                arg2.push("favoritesLap1_1_A");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesLap).favoritesLap[0][0][0];
                arg2.push("favoritesLap1_1_B");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesLap).favoritesLap[0][0][1];
                arg2.push("favoritesLap1_2_A");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesLap).favoritesLap[0][1][0];
                arg2.push("favoritesLap1_2_B");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesLap).favoritesLap[0][1][1];
                arg2.push("favoritesLap1_3_A");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesLap).favoritesLap[0][2][0];
                arg2.push("favoritesLap1_3_B");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesLap).favoritesLap[0][2][1];
                arg2.push("favoritesLap2_1_A");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesLap).favoritesLap[1][0][0];
                arg2.push("favoritesLap2_1_B");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesLap).favoritesLap[1][0][1];
                arg2.push("favoritesLap2_2_A");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesLap).favoritesLap[1][1][0];
                arg2.push("favoritesLap2_2_B");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesLap).favoritesLap[1][1][1];
                arg2.push("favoritesLap2_3_A");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesLap).favoritesLap[1][2][0];
                arg2.push("favoritesLap2_3_B");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesLap).favoritesLap[1][2][1];
            }
            if (arg1 is core.settings.SettingsROX100) 
            {
                arg2.push("favoritesSelected");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.SettingsROX100).favoritesSelected;
            }
            if (arg1 is core.settings.interfaces.IFavoritesTrack) 
            {
                arg2.push("favoritesTrack1_1_A");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesTrack).favoritesTrack[0][0][0];
                arg2.push("favoritesTrack1_1_B");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesTrack).favoritesTrack[0][0][1];
                arg2.push("favoritesTrack1_2_A");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesTrack).favoritesTrack[0][1][0];
                arg2.push("favoritesTrack1_2_B");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesTrack).favoritesTrack[0][1][1];
                arg2.push("favoritesTrack1_3_A");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesTrack).favoritesTrack[0][2][0];
                arg2.push("favoritesTrack1_3_B");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesTrack).favoritesTrack[0][2][1];
                arg2.push("favoritesTrack2_1_A");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesTrack).favoritesTrack[1][0][0];
                arg2.push("favoritesTrack2_1_B");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesTrack).favoritesTrack[1][0][1];
                arg2.push("favoritesTrack2_2_A");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesTrack).favoritesTrack[1][1][0];
                arg2.push("favoritesTrack2_2_B");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesTrack).favoritesTrack[1][1][1];
                arg2.push("favoritesTrack2_3_A");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesTrack).favoritesTrack[1][2][0];
                arg2.push("favoritesTrack2_3_B");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesTrack).favoritesTrack[1][2][1];
            }
            if (arg1 is core.settings.interfaces.IFavoritesCustom) 
            {
                arg2.push("favoritesCustomA_PageCount");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesCustom).favoritesCustomPageCount[0];
                arg2.push("favoritesCustom1_A");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesCustom).favoritesCustom[0][0];
                arg2.push("favoritesCustom2_A");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesCustom).favoritesCustom[0][1];
                arg2.push("favoritesCustom3_A");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesCustom).favoritesCustom[0][2];
                arg2.push("favoritesCustom4_A");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesCustom).favoritesCustom[0][3];
                arg2.push("favoritesCustom5_A");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesCustom).favoritesCustom[0][4];
                arg2.push("favoritesCustom6_A");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesCustom).favoritesCustom[0][5];
                arg2.push("favoritesCustomB_PageCount");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesCustom).favoritesCustomPageCount[1];
                arg2.push("favoritesCustom1_B");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesCustom).favoritesCustom[1][0];
                arg2.push("favoritesCustom2_B");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesCustom).favoritesCustom[1][1];
                arg2.push("favoritesCustom3_B");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesCustom).favoritesCustom[1][2];
                arg2.push("favoritesCustom4_B");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesCustom).favoritesCustom[1][3];
                arg2.push("favoritesCustom5_B");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesCustom).favoritesCustom[1][4];
                arg2.push("favoritesCustom6_B");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFavoritesCustom).favoritesCustom[1][5];
            }
            if (arg1 is core.settings.interfaces.IFavoriteTrip1) 
            {
                loc3 = (arg1 as core.settings.interfaces.IFavoriteTrip1).favoritesTrip1Size;
                loc4 = 0;
                while (loc4 < loc3) 
                {
                    arg2.push("favoritesTrip1_" + loc4);
                    ++loc1;
                    arg3[loc1] = (arg1 as core.settings.interfaces.IFavoriteTrip1).favoritesTrip1[loc4];
                    ++loc4;
                }
            }
            if (arg1 is core.settings.interfaces.IFavoriteTrip2) 
            {
                loc2 = (arg1 as core.settings.interfaces.IFavoriteTrip2).favoritesTrip2Size;
                loc5 = 0;
                while (loc5 < loc2) 
                {
                    arg2.push("favoritesTrip2_" + loc5);
                    ++loc1;
                    arg3[loc1] = (arg1 as core.settings.interfaces.IFavoriteTrip2).favoritesTrip2[loc5];
                    ++loc5;
                }
            }
            if (arg1 is core.settings.interfaces.ITrainingFree) 
            {
                arg2.push("freeTrainingTargetZone");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ITrainingFree).freeTrainingTargetZone;
                arg2.push("freeOwnZone1LowerLimit");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ITrainingFree).freeOwnZone1LowerLimit;
                arg2.push("freeOwnZone1UpperLimit");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ITrainingFree).freeOwnZone1UpperLimit;
                arg2.push("freeOwnZone2LowerLimit");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ITrainingFree).freeOwnZone2LowerLimit;
                arg2.push("freeOwnZone2UpperLimit");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ITrainingFree).freeOwnZone2UpperLimit;
                arg2.push("freeOwnZone3LowerLimit");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ITrainingFree).freeOwnZone3LowerLimit;
                arg2.push("freeOwnZone3UpperLimit");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ITrainingFree).freeOwnZone3UpperLimit;
            }
            if (arg1 is core.settings.interfaces.IFuelConsumption) 
            {
                arg2.push("fuelConsumption");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFuelConsumption).fuelConsumption;
            }
            if (arg1 is core.settings.interfaces.IFuelConsumptionUnit) 
            {
                arg2.push("fuelConsumptionUnit");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IFuelConsumptionUnit).fuelConsumptionUnit;
            }
            if (arg1 is core.settings.interfaces.IGender) 
            {
                arg2.push("gender");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IGender).gender;
            }
            if (arg1 is core.settings.interfaces.IGPSFormat) 
            {
                arg2.push("gpsFormat");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IGPSFormat).gpsFormat;
            }
            if (arg1 is core.settings.interfaces.IGPSStatus) 
            {
                arg2.push("gpsStatus");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IGPSStatus).gpsStatus;
            }
            if (arg1 is core.settings.interfaces.IStravaSegmentsEnabled) 
            {
                arg2.push("stravaSegmentsEnabled");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IStravaSegmentsEnabled).stravaSegmentsEnabled;
            }
            if (arg1 is core.settings.interfaces.ITrackDirection) 
            {
                arg2.push("trackDirection");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ITrackDirection).trackDirection;
            }
            if (arg1 is core.settings.interfaces.IHomeAltitude1) 
            {
                arg2.push("homeAltitude1");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IHomeAltitude1).homeAltitude1;
            }
            if (arg1 is core.settings.interfaces.IHomeAltitude2) 
            {
                arg2.push("homeAltitude2");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IHomeAltitude2).homeAltitude2;
            }
            if (arg1 is core.settings.interfaces.IHomeAltitude3) 
            {
                arg2.push("homeAltitude3");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IHomeAltitude3).homeAltitude3;
            }
            if (arg1 is core.settings.interfaces.IHRmax) 
            {
                arg2.push("hrMax");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IHRmax).hrMax;
            }
            if (arg1 is core.units.interfaces.IIntensityZonesPercentage) 
            {
                arg2.push("intensityZone1");
                ++loc1;
                arg3[loc1] = (arg1 as core.units.interfaces.IIntensityZonesPercentage).intensityZone1PercentageStart;
            }
            if (arg1 is core.units.interfaces.IIntensityZonesPercentage) 
            {
                arg2.push("intensityZone2");
                ++loc1;
                arg3[loc1] = (arg1 as core.units.interfaces.IIntensityZonesPercentage).intensityZone2PercentageStart;
            }
            if (arg1 is core.units.interfaces.IIntensityZonesPercentage) 
            {
                arg2.push("intensityZone3");
                ++loc1;
                arg3[loc1] = (arg1 as core.units.interfaces.IIntensityZonesPercentage).intensityZone3PercentageStart;
            }
            if (arg1 is core.units.interfaces.IIntensityZonesPercentage) 
            {
                arg2.push("intensityZone4");
                ++loc1;
                arg3[loc1] = (arg1 as core.units.interfaces.IIntensityZonesPercentage).intensityZone4PercentageStart;
            }
            if (arg1 is core.units.interfaces.IIntensityZonesPercentage) 
            {
                arg2.push("intensityZone4End");
                ++loc1;
                arg3[loc1] = (arg1 as core.units.interfaces.IIntensityZonesPercentage).intensityZone4PercentageEnd;
            }
            if (arg1 is core.settings.interfaces.ITrainingIntervalCoolDown) 
            {
                arg2.push("intervalCoolDownTargetZoneLowerLimit");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ITrainingIntervalCoolDown).intervalCoolDownTargetZoneLowerLimit;
            }
            if (arg1 is core.settings.interfaces.ITrainingIntervalCoolDown) 
            {
                arg2.push("intervalCoolDownTargetZoneUpperLimit");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ITrainingIntervalCoolDown).intervalCoolDownTargetZoneUpperLimit;
            }
            if (arg1 is core.settings.interfaces.ITrainingIntervalCoolDown) 
            {
                arg2.push("intervalCoolDownTime");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ITrainingIntervalCoolDown).intervalCoolDownTime;
            }
            if (arg1 is core.settings.interfaces.ITrainingInterval) 
            {
                arg2.push("intervalRecoveryHR");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ITrainingInterval).intervalRecoveryHR;
            }
            if (arg1 is core.settings.interfaces.ITrainingInterval) 
            {
                arg2.push("intervalRecoveryMode");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ITrainingInterval).intervalRecoveryMode.toString();
            }
            if (arg1 is core.settings.interfaces.ITrainingInterval) 
            {
                arg2.push("intervalRecoveryTime");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ITrainingInterval).intervalRecoveryTime;
            }
            if (arg1 is core.settings.interfaces.ITrainingInterval) 
            {
                arg2.push("intervalTargetZoneLowerLimit");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ITrainingInterval).intervalTargetZoneLowerLimit;
            }
            if (arg1 is core.settings.interfaces.ITrainingInterval) 
            {
                arg2.push("intervalTargetZoneUpperLimit");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ITrainingInterval).intervalTargetZoneUpperLimit;
            }
            if (arg1 is core.settings.interfaces.ITrainingInterval) 
            {
                arg2.push("intervalTime");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ITrainingInterval).intervalTime;
            }
            if (arg1 is core.settings.interfaces.ITrainingIntervalWarmUp) 
            {
                arg2.push("intervalWarmUpTargetZoneLowerLimit");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ITrainingIntervalWarmUp).intervalWarmUpTargetZoneLowerLimit;
            }
            if (arg1 is core.settings.interfaces.ITrainingIntervalWarmUp) 
            {
                arg2.push("intervalWarmUpTargetZoneUpperLimit");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ITrainingIntervalWarmUp).intervalWarmUpTargetZoneUpperLimit;
            }
            if (arg1 is core.settings.interfaces.ITrainingIntervalWarmUp) 
            {
                arg2.push("intervalWarmUpTime");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ITrainingIntervalWarmUp).intervalWarmUpTime;
            }
            if (arg1 is core.settings.interfaces.ILanguage) 
            {
                arg2.push("language");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ILanguage).language;
            }
            if (arg1 is core.settings.interfaces.ILowBatDetectLevel) 
            {
                arg2.push("lowBatDetectLevel");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ILowBatDetectLevel).lowBatDetectLevel;
            }
            if (arg1 is core.settings.interfaces.IHeartrateLimits) 
            {
                arg2.push("lowerLimit");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IHeartrateLimits).lowerLimit;
            }
            if (arg1 is core.settings.interfaces.IHeartrateSensor) 
            {
                arg2.push("heartrateSensorActive");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IHeartrateSensor).heartrateSensorActive;
            }
            if (arg1 is core.settings.interfaces.ICadenceSensor) 
            {
                arg2.push("cadenceSensorActive");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ICadenceSensor).cadenceSensorActive;
            }
            if (arg1 is core.settings.interfaces.IMyName) 
            {
                arg2.push("myName");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IMyName).myName;
            }
            arg2.push("name");
            ++loc1;
            arg3[loc1] = arg1.name;
            if (arg1 is core.settings.interfaces.IOffTrackAlarm) 
            {
                arg2.push("offTrackAlarm");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IOffTrackAlarm).offTrackAlarm;
            }
            if (arg1 is core.settings.interfaces.IPowerMeterFormula) 
            {
                arg2.push("powerMeterFormula");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IPowerMeterFormula).powerMeterFormula;
            }
            if (arg1 is core.settings.interfaces.IPowerTargetZone) 
            {
                arg2.push("powerTargetZoneEnabled");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IPowerTargetZone).powerTargetZoneEnabled;
                arg2.push("powerTargetZoneLowerLimit");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IPowerTargetZone).powerTargetZoneLowerLimit;
                arg2.push("powerTargetZoneUpperLimit");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IPowerTargetZone).powerTargetZoneUpperLimit;
            }
            if (arg1 is core.settings.interfaces.IPowerIntensityZone) 
            {
                arg2.push("powerIntensityZone1Start");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone1Start;
                arg2.push("powerIntensityZone2Start");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone2Start;
                arg2.push("powerIntensityZone3Start");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone3Start;
                arg2.push("powerIntensityZone4Start");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone4Start;
                arg2.push("powerIntensityZone5Start");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone5Start;
                arg2.push("powerIntensityZone6Start");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone6Start;
                arg2.push("powerIntensityZone7Start");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone7Start;
                arg2.push("powerIntensityZone7End");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IPowerIntensityZone).powerIntensityZone7End;
            }
            if (arg1 is core.settings.interfaces.ISamplingRate) 
            {
                arg2.push("samplingRate");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ISamplingRate).samplingRate;
            }
            if (arg1 is core.settings.interfaces.IAutoScan) 
            {
                arg2.push("scanFlagOn");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IAutoScan).scanFlagOn;
            }
            if (arg1 is core.settings.interfaces.ISeaLevel) 
            {
                arg2.push("seaLevel");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ISeaLevel).seaLevel;
            }
            if (arg1 is core.settings.interfaces.IService) 
            {
                arg2.push("serviceInterval");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IService).serviceInterval;
                arg2.push("serviceStatusOn");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IService).serviceStatusOn;
            }
            if (arg1 is core.settings.interfaces.IShoulderWidth) 
            {
                arg2.push("shoulderWidth");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IShoulderWidth).shoulderWidth;
            }
            if (arg1 is core.settings.interfaces.IShoulderWidthUnit) 
            {
                arg2.push("shoulderWidthUnit");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IShoulderWidthUnit).shoulderWidthUnit;
            }
            if (arg1 is core.settings.interfaces.IShowTotals) 
            {
                arg2.push("showTotals");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IShowTotals).showTotals;
            }
            if (arg1 is core.settings.interfaces.ISpeedUnit) 
            {
                arg2.push("speedUnit");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ISpeedUnit).speedUnit;
            }
            if (arg1 is core.settings.interfaces.IThreeZones) 
            {
                arg2.push("startZone1");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IThreeZones).startZone1;
            }
            if (arg1 is core.settings.interfaces.IThreeZones) 
            {
                arg2.push("startZone2");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IThreeZones).startZone2;
            }
            if (arg1 is core.settings.interfaces.IThreeZones) 
            {
                arg2.push("startZone3");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IThreeZones).startZone3;
            }
            if (arg1 is core.settings.interfaces.ISummerTime) 
            {
                arg2.push("summerTime");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ISummerTime).summerTime;
            }
            if (arg1 is core.settings.interfaces.ISystemTone) 
            {
                arg2.push("systemTone");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ISystemTone).systemTone;
            }
            if (arg1 is core.settings.interfaces.ITemperatureUnit) 
            {
                arg2.push("temperatureUnit");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ITemperatureUnit).temperatureUnit;
            }
            if (arg1 is core.settings.interfaces.ITimeZone) 
            {
                arg2.push("timeZone");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ITimeZone).timeZone;
            }
            if (arg1 is core.settings.interfaces.ITrainingZone) 
            {
                arg2.push("trainingZone");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ITrainingZone).trainingZone;
            }
            if (arg1 is core.settings.interfaces.IHeartrateLimits) 
            {
                arg2.push("upperLimit");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IHeartrateLimits).upperLimit;
            }
            if (arg1 is core.settings.interfaces.IVolume) 
            {
                arg2.push("volume");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IVolume).volume;
            }
            if (arg1 is core.settings.interfaces.IWayPointAlarm) 
            {
                arg2.push("waypointAlarm");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IWayPointAlarm).waypointAlarm;
            }
            if (arg1 is core.settings.interfaces.IWheelSize1) 
            {
                arg2.push("wheelSize1");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IWheelSize1).wheelSize1;
            }
            if (arg1 is core.settings.interfaces.IWheelSize2) 
            {
                arg2.push("wheelSize2");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IWheelSize2).wheelSize2;
            }
            if (arg1 is core.settings.interfaces.IWheelSize3) 
            {
                arg2.push("wheelSize3");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IWheelSize3).wheelSize3;
            }
            if (arg1 is core.settings.interfaces.IYearOfBirth) 
            {
                arg2.push("yearOfBirth");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IYearOfBirth).yearOfBirth;
            }
            if (arg1 is core.settings.interfaces.IZoneAlarm) 
            {
                arg2.push("zoneAlarm");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IZoneAlarm).zoneAlarm;
            }
            if (arg1 is core.settings.interfaces.IPhaseAlarm) 
            {
                arg2.push("phaseAlarm");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IPhaseAlarm).phaseAlarm;
            }
            if (arg1 is core.settings.interfaces.IKeyLock) 
            {
                arg2.push("keyLock");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IKeyLock).keyLock;
            }
            if (arg1 is core.settings.interfaces.IPowerSaveMode) 
            {
                arg2.push("powerSaveModeActive");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IPowerSaveMode).powerSaveModeActive;
            }
            if (arg1 is core.settings.interfaces.IBacklight) 
            {
                arg2.push("backlightActive");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IBacklight).backlightActive;
            }
            if (arg1 is core.settings.interfaces.IBacklightTimeOn) 
            {
                arg2.push("backlightTimeOn");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IBacklightTimeOn).backlightTimeOn.toString();
            }
            if (arg1 is core.settings.interfaces.IBacklightTimeOff) 
            {
                arg2.push("backlightTimeOff");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IBacklightTimeOff).backlightTimeOff.toString();
            }
            if (arg1 is core.settings.interfaces.INfc) 
            {
                arg2.push("nfcActive");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.INfc).nfcActive;
            }
            if (arg1 is core.settings.interfaces.ITireSize1) 
            {
                arg2.push("tireSize1");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ITireSize1).tireSize1 ? (arg1 as core.settings.interfaces.ITireSize1).tireSize1.data : "";
            }
            if (arg1 is core.settings.interfaces.ITireSize2) 
            {
                arg2.push("tireSize2");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.ITireSize2).tireSize2 ? (arg1 as core.settings.interfaces.ITireSize2).tireSize2.data : "";
            }
            if (arg1 is core.settings.interfaces.IWheelSize1Mode) 
            {
                arg2.push("wheelSize1Mode");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IWheelSize1Mode).wheelSize1Mode ? (arg1 as core.settings.interfaces.IWheelSize1Mode).wheelSize1Mode.toString() : "";
            }
            if (arg1 is core.settings.interfaces.IWheelSize2Mode) 
            {
                arg2.push("wheelSize2Mode");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IWheelSize2Mode).wheelSize2Mode ? (arg1 as core.settings.interfaces.IWheelSize2Mode).wheelSize2Mode.toString() : "";
            }
            if (arg1 is core.settings.interfaces.IETADistance) 
            {
                arg2.push("etaDistance");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IETADistance).etaDistance;
            }
            if (arg1 is core.settings.interfaces.IETAArivalFlag) 
            {
                arg2.push("etaArivalFlag");
                ++loc1;
                arg3[loc1] = (arg1 as core.settings.interfaces.IETAArivalFlag).etaArivalFlag;
            }
            return;
        }

        public static const col_altitudeUnit:String="altitudeUnit";

        public static const col_autoOffTime:String="autoOffTime";

        public static const col_autoPause:String="autoPause";

        public static const col_autoZoomTrack:String="autoZoomTrack";

        public static const col_backlightActive:String="backlightActive";

        public static const col_backlightLevel:String="backlightLevel";

        public static const col_backlightTime:String="backlightTime";

        public static const col_backlightTimeOff:String="backlightTimeOff";

        public static const col_backlightTimeOn:String="backlightTimeOn";

        public static const col_bikeType1:String="bikeType1";

        public static const col_bikeType2:String="bikeType2";

        public static const col_bikeType3:String="bikeType3";

        public static const col_bikeWeight1:String="bikeWeight1";

        public static const col_bikeWeight1Unit:String="bikeWeight1Unit";

        public static const col_bikeWeight2:String="bikeWeight2";

        public static const col_bikeWeight2Unit:String="bikeWeight2Unit";

        public static const col_bikeWeight3:String="bikeWeight3";

        public static const col_birthDate:String="birthDate";

        public static const col_bodyHeight:String="bodyHeight";

        public static const col_bodyHeightUnit:String="bodyHeightUnit";

        public static const col_bodyWeight:String="bodyWeight";

        public static const col_bodyWeightUnit:String="bodyWeightUnit";

        public static const col_buttonInfo:String="buttonInfo";

        public static const col_buttonTone:String="buttonTone";

        public static const col_cadenceSensorActive:String="cadenceSensorActive";

        public static const col_calibration:String="calibration";

        public static const col_clockMode:String="clockMode";

        public static const col_contrast:String="contrast";

        public static const col_correctionFactor:String="correctionFactor";

        public static const col_countdown:String="countdown";

        public static const col_countdownOn:String="countdownOn";

        public static const col_date:String="date";

        public static const col_dateFormat:String="dateFormat";

        public static const col_distanceUnit:String="distanceUnit";

        public static const col_endZone3:String="endZone3";

        public static const col_etaArivalFlag:String="etaArivalFlag";

        public static const col_etaDistance:String="etaDistance";

        public static const col_favoritesAltitude1_1_A:String="favoritesAltitude1_1_A";

        public static const col_favoritesAltitude1_1_B:String="favoritesAltitude1_1_B";

        public static const col_favoritesAltitude1_2_A:String="favoritesAltitude1_2_A";

        public static const col_favoritesAltitude1_2_B:String="favoritesAltitude1_2_B";

        public static const col_favoritesAltitude1_3_A:String="favoritesAltitude1_3_A";

        public static const col_favoritesAltitude1_3_B:String="favoritesAltitude1_3_B";

        public static const col_favoritesAltitude2_1_A:String="favoritesAltitude2_1_A";

        public static const col_favoritesAltitude2_1_B:String="favoritesAltitude2_1_B";

        public static const col_favoritesAltitude2_2_A:String="favoritesAltitude2_2_A";

        public static const col_favoritesAltitude2_2_B:String="favoritesAltitude2_2_B";

        public static const col_favoritesAltitude2_3_A:String="favoritesAltitude2_3_A";

        public static const col_favoritesAltitude2_3_B:String="favoritesAltitude2_3_B";

        public static const col_favoritesCustom1_A:String="favoritesCustom1_A";

        public static const col_favoritesCustom1_B:String="favoritesCustom1_B";

        public static const col_favoritesCustom2_A:String="favoritesCustom2_A";

        public static const col_favoritesCustom2_B:String="favoritesCustom2_B";

        public static const col_favoritesCustom3_A:String="favoritesCustom3_A";

        public static const col_favoritesCustom3_B:String="favoritesCustom3_B";

        public static const col_favoritesCustom4_A:String="favoritesCustom4_A";

        public static const col_favoritesCustom4_B:String="favoritesCustom4_B";

        public static const col_favoritesCustom5_A:String="favoritesCustom5_A";

        public static const col_favoritesCustom5_B:String="favoritesCustom5_B";

        public static const col_favoritesCustom6_A:String="favoritesCustom6_A";

        public static const col_favoritesCustom6_B:String="favoritesCustom6_B";

        public static const col_favoritesCustomA_PageCount:String="favoritesCustomA_PageCount";

        public static const col_favoritesCustomB_PageCount:String="favoritesCustomB_PageCount";

        public static const col_favoritesLap1_1_A:String="favoritesLap1_1_A";

        public static const col_favoritesLap1_1_B:String="favoritesLap1_1_B";

        public static const col_favoritesLap1_2_A:String="favoritesLap1_2_A";

        public static const col_favoritesLap1_2_B:String="favoritesLap1_2_B";

        public static const col_favoritesLap1_3_A:String="favoritesLap1_3_A";

        public static const col_favoritesLap1_3_B:String="favoritesLap1_3_B";

        public static const col_favoritesLap2_1_A:String="favoritesLap2_1_A";

        public static const col_favoritesLap2_1_B:String="favoritesLap2_1_B";

        public static const col_favoritesLap2_2_A:String="favoritesLap2_2_A";

        public static const col_favoritesLap2_2_B:String="favoritesLap2_2_B";

        public static const col_favoritesLap2_3_A:String="favoritesLap2_3_A";

        public static const col_favoritesLap2_3_B:String="favoritesLap2_3_B";

        public static const col_favoritesSelected:String="favoritesSelected";

        public static const col_favoritesTrack1_1_A:String="favoritesTrack1_1_A";

        public static const col_favoritesTrack1_1_B:String="favoritesTrack1_1_B";

        public static const col_favoritesTrack1_2_A:String="favoritesTrack1_2_A";

        public static const col_favoritesTrack1_2_B:String="favoritesTrack1_2_B";

        public static const col_favoritesTrack1_3_A:String="favoritesTrack1_3_A";

        public static const col_favoritesTrack1_3_B:String="favoritesTrack1_3_B";

        public static const col_favoritesTrack2_1_A:String="favoritesTrack2_1_A";

        public static const col_favoritesTrack2_1_B:String="favoritesTrack2_1_B";

        public static const col_favoritesTrack2_2_A:String="favoritesTrack2_2_A";

        public static const col_favoritesTrack2_2_B:String="favoritesTrack2_2_B";

        public static const col_favoritesTrack2_3_A:String="favoritesTrack2_3_A";

        public static const col_favoritesTrack2_3_B:String="favoritesTrack2_3_B";

        public static const col_favoritesTrip1_0:String="favoritesTrip1_0";

        public static const col_favoritesTrip1_1:String="favoritesTrip1_1";

        public static const col_favoritesTrip1_2:String="favoritesTrip1_2";

        public static const col_favoritesTrip1_3:String="favoritesTrip1_3";

        public static const col_favoritesTrip1_4:String="favoritesTrip1_4";

        public static const col_favoritesTrip1_5:String="favoritesTrip1_5";

        public static const col_favoritesTrip1_6:String="favoritesTrip1_6";

        public static const col_favoritesTrip1_7:String="favoritesTrip1_7";

        public static const col_favoritesTrip1_8:String="favoritesTrip1_8";

        public static const col_favoritesTrip1_9:String="favoritesTrip1_9";

        public static const col_favoritesTrip2_0:String="favoritesTrip2_0";

        public static const col_favoritesTrip2_1:String="favoritesTrip2_1";

        public static const col_favoritesTrip2_2:String="favoritesTrip2_2";

        public static const col_favoritesTrip2_3:String="favoritesTrip2_3";

        public static const col_favoritesTrip2_4:String="favoritesTrip2_4";

        public static const col_favoritesTrip2_5:String="favoritesTrip2_5";

        public static const col_favoritesTrip2_6:String="favoritesTrip2_6";

        public static const col_favoritesTrip2_7:String="favoritesTrip2_7";

        public static const col_favoritesTrip2_8:String="favoritesTrip2_8";

        public static const col_favoritesTrip2_9:String="favoritesTrip2_9";

        public static const col_freeOwnZone1LowerLimit:String="freeOwnZone1LowerLimit";

        public static const col_freeOwnZone1UpperLimit:String="freeOwnZone1UpperLimit";

        public static const col_freeOwnZone2LowerLimit:String="freeOwnZone2LowerLimit";

        public static const col_freeOwnZone2UpperLimit:String="freeOwnZone2UpperLimit";

        public static const col_freeOwnZone3LowerLimit:String="freeOwnZone3LowerLimit";

        public static const col_freeOwnZone3UpperLimit:String="freeOwnZone3UpperLimit";

        public static const col_freeTrainingTargetZone:String="freeTrainingTargetZone";

        public static const col_fuelConsumption:String="fuelConsumption";

        public static const col_fuelConsumptionUnit:String="fuelConsumptionUnit";

        public static const col_gender:String="gender";

        public static const col_gpsFormat:String="gpsFormat";

        public static const col_gpsStatus:String="gpsStatus";

        public static const col_heartrateSensorActive:String="heartrateSensorActive";

        public static const col_homeAltitude1:String="homeAltitude1";

        public static const col_homeAltitude2:String="homeAltitude2";

        public static const col_homeAltitude3:String="homeAltitude3";

        public static const col_hrMax:String="hrMax";

        public static const col_intensityZone1:String="intensityZone1";

        public static const col_intensityZone2:String="intensityZone2";

        public static const col_intensityZone3:String="intensityZone3";

        public static const col_intensityZone4:String="intensityZone4";

        public static const col_intensityZone4End:String="intensityZone4End";

        public static const col_intervalCoolDownTargetZoneLowerLimit:String="intervalCoolDownTargetZoneLowerLimit";

        public static const col_intervalCoolDownTargetZoneUpperLimit:String="intervalCoolDownTargetZoneUpperLimit";

        public static const col_intervalCoolDownTime:String="intervalCoolDownTime";

        public static const col_intervalRecoveryHR:String="intervalRecoveryHR";

        public static const col_intervalRecoveryMode:String="intervalRecoveryMode";

        public static const col_intervalRecoveryTime:String="intervalRecoveryTime";

        public static const col_intervalTargetZoneLowerLimit:String="intervalTargetZoneLowerLimit";

        public static const col_intervalTargetZoneUpperLimit:String="intervalTargetZoneUpperLimit";

        public static const col_intervalTime:String="intervalTime";

        public static const col_intervalWarmUpTargetZoneLowerLimit:String="intervalWarmUpTargetZoneLowerLimit";

        public static const col_intervalWarmUpTargetZoneUpperLimit:String="intervalWarmUpTargetZoneUpperLimit";

        public static const col_intervalWarmUpTime:String="intervalWarmUpTime";

        public static const col_isDeleted:String="isDeleted";

        public static const col_keyLock:String="keyLock";

        public static const col_language:String="language";

        public static const col_lowBatDetectLevel:String="lowBatDetectLevel";

        public static const col_lowerLimit:String="lowerLimit";

        public static const col_modificationDate:String="modificationDate";

        public static const col_myName:String="myName";

        public static const col_name:String="name";

        public static const col_nfcActive:String="nfcActive";

        public static const col_offTrackAlarm:String="offTrackAlarm";

        public static const col_phaseAlarm:String="phaseAlarm";

        public static const col_powerIntensityZone1Start:String="powerIntensityZone1Start";

        public static const col_powerIntensityZone2Start:String="powerIntensityZone2Start";

        public static const col_powerIntensityZone4Start:String="powerIntensityZone4Start";

        public static const col_powerIntensityZone5Start:String="powerIntensityZone5Start";

        public static const col_powerIntensityZone6Start:String="powerIntensityZone6Start";

        public static const col_powerIntensityZone7End:String="powerIntensityZone7End";

        public static const col_powerIntensityZone7Start:String="powerIntensityZone7Start";

        public static const col_powerMeterFormula:String="powerMeterFormula";

        public static const col_powerSaveModeActive:String="powerSaveModeActive";

        public static const col_powerTargetZoneEnabled:String="powerTargetZoneEnabled";

        public static const col_powerTargetZoneLowerLimit:String="powerTargetZoneLowerLimit";

        public static const col_powerTargetZoneUpperLimit:String="powerTargetZoneUpperLimit";

        public static const col_samplingRate:String="samplingRate";

        public static const col_scanFlagOn:String="scanFlagOn";

        public static const col_seaLevel:String="seaLevel";

        public static const col_serviceInterval:String="serviceInterval";

        public static const col_serviceStatusOn:String="serviceStatusOn";

        public static const col_settingsId:String="settingsId";

        public static const col_shoulderWidth:String="shoulderWidth";

        public static const col_shoulderWidthUnit:String="shoulderWidthUnit";

        public static const col_showTotals:String="showTotals";

        public static const col_speedUnit:String="speedUnit";

        public static const col_startZone1:String="startZone1";

        public static const col_startZone2:String="startZone2";

        public static const col_startZone3:String="startZone3";

        public static const col_stravaSegmentsEnabled:String="stravaSegmentsEnabled";

        public static const col_summerTime:String="summerTime";

        public static const col_systemTone:String="systemTone";

        public static const col_powerIntensityZone3Start:String="powerIntensityZone3Start";

        public static const col_timeZone:String="timeZone";

        public static const col_tireSize1:String="tireSize1";

        public static const col_tireSize2:String="tireSize2";

        public static const col_trackDirection:String="trackDirection";

        public static const col_trainingZone:String="trainingZone";

        public static const col_unitGUID:String="unitGUID";

        public static const col_upperLimit:String="upperLimit";

        public static const col_volume:String="volume";

        public static const col_waypointAlarm:String="waypointAlarm";

        public static const col_wheelSize1:String="wheelSize1";

        public static const col_wheelSize2:String="wheelSize2";

        public static const col_wheelSize3:String="wheelSize3";

        public static const col_wheelSizeMode1:String="wheelSize1Mode";

        public static const col_wheelSizeMode2:String="wheelSize2Mode";

        public static const col_yearOfBirth:String="yearOfBirth";

        public static const col_zoneAlarm:String="zoneAlarm";

        public static const table_name:String="Settings";

        public static const col_GUID:String="GUID";

        public static const col_actual_altitude:String="actualAltitude";

        public static const col_age:String="age";

        public static const col_alarm:String="alarm";

        public static const col_alarmMode:String="alarmMode";

        public static const col_altitudeReference:String="altitudeReference";

        public static const col_temperatureUnit:String="temperatureUnit";

        public static var DB_TABLE_400:database.DatabaseTable;

        public static var DB_TABLE_520:database.DatabaseTable;

        public static var DB_TABLE_510:database.DatabaseTable;

        public static var DB_TABLE_500:database.DatabaseTable;
    }
}


//  class SettingsPC2814
package core.settings 
{
    import __AS3__.vec.*;
    import core.settings.interfaces.*;
    import core.training.type.*;
    import core.units.interfaces.*;
    import flash.events.*;
    
    public class SettingsPC2814 extends core.settings.SettingsPulseComputer implements core.settings.interfaces.IDate, core.settings.interfaces.ILanguage, core.settings.interfaces.IDateFormat, core.settings.interfaces.IGender, core.settings.interfaces.IHRmax, core.settings.interfaces.ISamplingRate, core.settings.interfaces.IButtonTone, core.settings.interfaces.IZoneAlarm, core.settings.interfaces.ILowBatDetectLevel, core.units.interfaces.IIntensityZonesPercentage, core.settings.interfaces.IBirthDate, core.settings.interfaces.IAlarm, core.settings.interfaces.IAlarmMode, core.settings.interfaces.IFavoriteTrip1, core.settings.interfaces.IFavoriteTrip2, core.settings.interfaces.ITrainingFree, core.settings.interfaces.ITrainingIntervalWarmUp, core.settings.interfaces.ITrainingInterval, core.settings.interfaces.ITrainingIntervalCoolDown, core.settings.interfaces.IMyName, core.settings.interfaces.IKeyLock, core.settings.interfaces.IPhaseAlarm
    {
        public function SettingsPC2814(arg1:flash.events.IEventDispatcher=null)
        {
            _alarm = new Date(2014, 0, 1);
            _birthDate = new Date(1980, 0, 1);
            _favoritesTrip1 = new __AS3__.vec.Vector.<String>(9);
            _favoritesTrip2 = new __AS3__.vec.Vector.<String>(9);
            _intervalRecoveryMode = core.training.type.PhaseControl.TIME;
            super(arg1);
            bodyWeight = 75000;
            favoritesTrip1[0] = "2";
            favoritesTrip2[0] = "1";
            favoritesTrip1[1] = "6";
            favoritesTrip2[1] = "7";
            favoritesTrip1[2] = "8";
            favoritesTrip2[2] = "9";
            favoritesTrip1[3] = "5";
            favoritesTrip2[3] = "2";
            favoritesTrip1[4] = "3";
            favoritesTrip2[4] = "0";
            favoritesTrip1[5] = "4";
            favoritesTrip2[5] = "0";
            favoritesTrip1[6] = "0";
            favoritesTrip2[6] = "0";
            favoritesTrip1[7] = "0";
            favoritesTrip2[7] = "0";
            favoritesTrip1[8] = "0";
            favoritesTrip2[8] = "0";
            return;
        }

        public function set intervalWarmUpTime(arg1:int):void
        {
            if (arg1 != _intervalWarmUpTime) 
            {
                _intervalWarmUpTime = arg1;
                dispatchEvent(new flash.events.Event("intervalWarmUpTimeChange"));
            }
            return;
        }

        public function get alarm():Date
        {
            return _alarm;
        }

        public function set alarm(arg1:Date):void
        {
            if (arg1 != _alarm) 
            {
                _alarm = arg1;
                dispatchEvent(new flash.events.Event("alarmChange"));
            }
            return;
        }

        public function get keyLock():Boolean
        {
            return _keyLock;
        }

        public function get alarmMode():String
        {
            return _alarmMode;
        }

        public function set alarmMode(arg1:String):void
        {
            if (arg1 != _alarmMode) 
            {
                _alarmMode = arg1;
                dispatchEvent(new flash.events.Event("alarmModeChange"));
            }
            return;
        }

        public function set keyLock(arg1:Boolean):void
        {
            if (arg1 != _keyLock) 
            {
                _keyLock = arg1;
                dispatchEvent(new flash.events.Event("keyLockChange"));
            }
            return;
        }

        public function get birthDate():Date
        {
            return _birthDate;
        }

        public function set birthDate(arg1:Date):void
        {
            if (arg1 != _birthDate) 
            {
                _birthDate = arg1;
                dispatchEvent(new flash.events.Event("birthDateChange"));
            }
            return;
        }

        public function get birthDateMax():Number
        {
            return new Date(NOW.fullYear - 6, NOW.month, NOW.date).time;
        }

        public function get birthDateMin():Number
        {
            return new Date(1900, 0, 1).time;
        }

        public function get language():String
        {
            return _language;
        }

        public function get buttonTone():Boolean
        {
            return _buttonTone;
        }

        public function set buttonTone(arg1:Boolean):void
        {
            if (arg1 != _buttonTone) 
            {
                _buttonTone = arg1;
                dispatchEvent(new flash.events.Event("buttonToneChange"));
            }
            return;
        }

        public function set language(arg1:String):void
        {
            if (arg1 != _language) 
            {
                _language = arg1;
                dispatchEvent(new flash.events.Event("languageChange"));
            }
            return;
        }

        public function get dateFormat():String
        {
            return _dateFormat;
        }

        public function set dateFormat(arg1:String):void
        {
            if (arg1 != _dateFormat) 
            {
                _dateFormat = arg1;
                dispatchEvent(new flash.events.Event("dateFormatChange"));
            }
            return;
        }

        public function get lowBatDetectLevel():String
        {
            return _lowBatDetectLevel;
        }

        public final function get favoritesTrip1():__AS3__.vec.Vector.<String>
        {
            return _favoritesTrip1;
        }

        public final function set favoritesTrip1(arg1:__AS3__.vec.Vector.<String>):void
        {
            if (_favoritesTrip1 !== arg1) 
            {
                _favoritesTrip1 = arg1;
                dispatchEvent(new flash.events.Event("favoritesTrip1Change"));
            }
            return;
        }

        public function get favoritesTrip1Size():int
        {
            return 9;
        }

        public function set lowBatDetectLevel(arg1:String):void
        {
            if (arg1 != _lowBatDetectLevel) 
            {
                _lowBatDetectLevel = arg1;
                dispatchEvent(new flash.events.Event("lowBatDetectLevelChange"));
            }
            return;
        }

        public final function get favoritesTrip2():__AS3__.vec.Vector.<String>
        {
            return _favoritesTrip2;
        }

        public final function set favoritesTrip2(arg1:__AS3__.vec.Vector.<String>):void
        {
            if (_favoritesTrip2 !== arg1) 
            {
                _favoritesTrip2 = arg1;
                dispatchEvent(new flash.events.Event("favorites2Change"));
            }
            return;
        }

        public function get favoritesTrip2Size():int
        {
            return 9;
        }

        public function get myName():String
        {
            return _myName;
        }

        public function get freeOwnZone1LowerLimit():int
        {
            return _freeOwnZone1LowerLimit;
        }

        public function set freeOwnZone1LowerLimit(arg1:int):void
        {
            if (arg1 != _freeOwnZone1LowerLimit) 
            {
                _freeOwnZone1LowerLimit = arg1;
                dispatchEvent(new flash.events.Event("freeOwnZone1LowerLimitChange"));
            }
            return;
        }

        public function get freeOwnZone1LowerLimitDefault():int
        {
            return 110;
        }

        public function get freeOwnZone1LowerLimitMax():int
        {
            return (Math.min(240, freeOwnZone1UpperLimit) - 1);
        }

        public function get freeOwnZone1LowerLimitMin():int
        {
            return 30;
        }

        public function set myName(arg1:String):void
        {
            if (arg1 != _myName) 
            {
                _myName = arg1;
                dispatchEvent(new flash.events.Event("myNameChange"));
            }
            return;
        }

        public function get freeOwnZone1UpperLimit():int
        {
            return _freeOwnZone1UpperLimit;
        }

        public function set freeOwnZone1UpperLimit(arg1:int):void
        {
            if (arg1 != _freeOwnZone1UpperLimit) 
            {
                _freeOwnZone1UpperLimit = arg1;
                dispatchEvent(new flash.events.Event("freeOwnZone1UpperLimitChange"));
            }
            return;
        }

        public function get freeOwnZone1UpperLimitDefault():int
        {
            return 155;
        }

        public function get freeOwnZone1UpperLimitMax():int
        {
            return 240;
        }

        public function get freeOwnZone1UpperLimitMin():int
        {
            return Math.max(30, freeOwnZone1LowerLimit) + 1;
        }

        public function get myNameMaxLength():uint
        {
            return 10;
        }

        public function get freeOwnZone2LowerLimit():int
        {
            return _freeOwnZone2LowerLimit;
        }

        public function set freeOwnZone2LowerLimit(arg1:int):void
        {
            if (arg1 != _freeOwnZone2LowerLimit) 
            {
                _freeOwnZone2LowerLimit = arg1;
                dispatchEvent(new flash.events.Event("freeOwnZone2LowerLimitChange"));
            }
            return;
        }

        public function get freeOwnZone2LowerLimitDefault():int
        {
            return 120;
        }

        public function get freeOwnZone2LowerLimitMax():int
        {
            return (Math.min(240, freeOwnZone2UpperLimit) - 1);
        }

        public function get freeOwnZone2LowerLimitMin():int
        {
            return 30;
        }

        public function get phaseAlarm():Boolean
        {
            return _phaseAlarm;
        }

        public function get freeOwnZone2UpperLimit():int
        {
            return _freeOwnZone2UpperLimit;
        }

        public function set freeOwnZone2UpperLimit(arg1:int):void
        {
            if (arg1 != _freeOwnZone2UpperLimit) 
            {
                _freeOwnZone2UpperLimit = arg1;
                dispatchEvent(new flash.events.Event("freeOwnZone2UpperLimitChange"));
            }
            return;
        }

        public function get freeOwnZone2UpperLimitDefault():int
        {
            return 165;
        }

        public function get freeOwnZone2UpperLimitMax():int
        {
            return 240;
        }

        public function get freeOwnZone2UpperLimitMin():int
        {
            return Math.max(30, freeOwnZone2LowerLimit) + 1;
        }

        public function set phaseAlarm(arg1:Boolean):void
        {
            if (arg1 != _phaseAlarm) 
            {
                _phaseAlarm = arg1;
                dispatchEvent(new flash.events.Event("phaseAlarmChange"));
            }
            return;
        }

        public function get freeOwnZone3LowerLimit():int
        {
            return _freeOwnZone3LowerLimit;
        }

        public function set freeOwnZone3LowerLimit(arg1:int):void
        {
            if (arg1 != _freeOwnZone3LowerLimit) 
            {
                _freeOwnZone3LowerLimit = arg1;
                dispatchEvent(new flash.events.Event("freeOwnZone3LowerLimitChange"));
            }
            return;
        }

        public function get freeOwnZone3LowerLimitDefault():int
        {
            return 130;
        }

        public function get freeOwnZone3LowerLimitMax():int
        {
            return (Math.min(240, freeOwnZone3UpperLimit) - 1);
        }

        public function get freeOwnZone3LowerLimitMin():int
        {
            return 30;
        }

        public function get samplingRate():Number
        {
            return _samplingRate;
        }

        public function get freeOwnZone3UpperLimit():int
        {
            return _freeOwnZone3UpperLimit;
        }

        public function set freeOwnZone3UpperLimit(arg1:int):void
        {
            if (arg1 != _freeOwnZone3UpperLimit) 
            {
                _freeOwnZone3UpperLimit = arg1;
                dispatchEvent(new flash.events.Event("freeOwnZone3UpperLimitChange"));
            }
            return;
        }

        public function get freeOwnZone3UpperLimitDefault():int
        {
            return 175;
        }

        public function get freeOwnZone3UpperLimitMax():int
        {
            return 240;
        }

        public function get freeOwnZone3UpperLimitMin():int
        {
            return Math.max(30, freeOwnZone3LowerLimit) + 1;
        }

        public function set samplingRate(arg1:Number):void
        {
            if (arg1 != _samplingRate) 
            {
                _samplingRate = arg1;
                dispatchEvent(new flash.events.Event("samplingRateChange"));
            }
            return;
        }

        public function get freeTrainingTargetZone():String
        {
            return _freeTrainingTargetZone;
        }

        public function set freeTrainingTargetZone(arg1:String):void
        {
            if (arg1 != _freeTrainingTargetZone) 
            {
                _freeTrainingTargetZone = arg1;
                dispatchEvent(new flash.events.Event("freeTrainingTargetZone"));
            }
            return;
        }

        public function get zoneAlarm():Boolean
        {
            return _zoneAlarm;
        }

        public function get gender():String
        {
            return _gender;
        }

        public function set gender(arg1:String):void
        {
            if (arg1 != _gender) 
            {
                _gender = arg1;
                dispatchEvent(new flash.events.Event("genderChange"));
            }
            return;
        }

        public function set zoneAlarm(arg1:Boolean):void
        {
            if (arg1 != _zoneAlarm) 
            {
                _zoneAlarm = arg1;
                dispatchEvent(new flash.events.Event("zoneAlarmChange"));
            }
            return;
        }

        public function get hrMax():int
        {
            return _hrMax;
        }

        public function set hrMax(arg1:int):void
        {
            if (arg1 != _hrMax) 
            {
                _hrMax = arg1;
                dispatchEvent(new flash.events.Event("hrMaxChange"));
            }
            return;
        }

        public function get hrMaxMax():int
        {
            return 240;
        }

        public function get hrMaxMin():int
        {
            return 100;
        }

        public function get intensityZone1PercentageStart():Number
        {
            return _intensityZone1;
        }

        public function set intensityZone1PercentageStart(arg1:Number):void
        {
            if (arg1 != _intensityZone1) 
            {
                _intensityZone1 = arg1;
                dispatchEvent(new flash.events.Event("intensityZone1PercentageStartChange"));
            }
            return;
        }

        public function get intensityZone2PercentageStart():Number
        {
            return _intensityZone2;
        }

        public function set intensityZone2PercentageStart(arg1:Number):void
        {
            if (arg1 != _intensityZone2) 
            {
                _intensityZone2 = arg1;
                dispatchEvent(new flash.events.Event("intensityZone2PercentageStartChange"));
            }
            return;
        }

        public function get intensityZone3PercentageStart():Number
        {
            return _intensityZone3;
        }

        public function set intensityZone3PercentageStart(arg1:Number):void
        {
            if (arg1 != _intensityZone3) 
            {
                _intensityZone3 = arg1;
                dispatchEvent(new flash.events.Event("intensityZone3PercentageStartChange"));
            }
            return;
        }

        public function get intensityZone4PercentageEnd():Number
        {
            return _intensityZone4End;
        }

        public function set intensityZone4PercentageEnd(arg1:Number):void
        {
            if (arg1 != _intensityZone4End) 
            {
                _intensityZone4End = arg1;
                dispatchEvent(new flash.events.Event("intensityZone4PercentageEndChange"));
            }
            return;
        }

        public function get intensityZone4PercentageStart():Number
        {
            return _intensityZone4;
        }

        public function set intensityZone4PercentageStart(arg1:Number):void
        {
            if (arg1 != _intensityZone4) 
            {
                _intensityZone4 = arg1;
                dispatchEvent(new flash.events.Event("intensityZone4PercentageStartChange"));
            }
            return;
        }

        public function get intensityZonePercentageMin():Number
        {
            return 30;
        }

        public override function toString():String
        {
            return "[SettingsPC2813 extends SettingsPulseComputer]";
        }

        public function get intervalCoolDownTargetZoneLowerLimit():int
        {
            return _intervalCoolDownTargetZoneLowerLimit;
        }

        public function set intervalCoolDownTargetZoneLowerLimit(arg1:int):void
        {
            if (arg1 != _intervalCoolDownTargetZoneLowerLimit) 
            {
                _intervalCoolDownTargetZoneLowerLimit = arg1;
                dispatchEvent(new flash.events.Event("intervalCoolDownTargetZoneLowerLimitChange"));
            }
            return;
        }

        public function get intervalCoolDownTargetZoneLowerLimitMax():int
        {
            return (Math.min(240, intervalCoolDownTargetZoneUpperLimit) - 1);
        }

        public function get intervalCoolDownTargetZoneLowerLimitMin():int
        {
            return 30;
        }

        public function get intervalCoolDownTargetZoneUpperLimit():int
        {
            return _intervalCoolDownTargetZoneUpperLimit;
        }

        public function set intervalCoolDownTargetZoneUpperLimit(arg1:int):void
        {
            if (arg1 != _intervalCoolDownTargetZoneUpperLimit) 
            {
                _intervalCoolDownTargetZoneUpperLimit = arg1;
                dispatchEvent(new flash.events.Event("intervalCoolDownTargetZoneUpperLimitChange"));
            }
            return;
        }

        public function get intervalCoolDownTargetZoneUpperLimitMax():int
        {
            return 240;
        }

        public function get intervalCoolDownTargetZoneUpperLimitMin():int
        {
            return Math.max(30, intervalCoolDownTargetZoneLowerLimit) + 1;
        }

        public function get intervalCoolDownTime():int
        {
            return _intervalCoolDownTime;
        }

        public function set intervalCoolDownTime(arg1:int):void
        {
            if (arg1 != _intervalCoolDownTime) 
            {
                _intervalCoolDownTime = arg1;
                dispatchEvent(new flash.events.Event("intervalCoolDownTimeChange"));
            }
            return;
        }

        public function get intervalRecoveryHR():int
        {
            return _intervalRecoveryHR;
        }

        public function set intervalRecoveryHR(arg1:int):void
        {
            if (arg1 != _intervalRecoveryHR) 
            {
                _intervalRecoveryHR = arg1;
                dispatchEvent(new flash.events.Event("intervalRecoveryHRChange"));
            }
            return;
        }

        public function get intervalRecoveryMode():core.training.type.PhaseControl
        {
            return _intervalRecoveryMode;
        }

        public function set intervalRecoveryMode(arg1:core.training.type.PhaseControl):void
        {
            if (arg1 != _intervalRecoveryMode) 
            {
                _intervalRecoveryMode = arg1;
                dispatchEvent(new flash.events.Event("intervalRecoveryModeChange"));
            }
            return;
        }

        public function get intervalRecoveryTime():int
        {
            return _intervalRecoveryTime;
        }

        public function set intervalRecoveryTime(arg1:int):void
        {
            if (arg1 != _intervalRecoveryTime) 
            {
                _intervalRecoveryTime = arg1;
                dispatchEvent(new flash.events.Event("intervalRecoveryTimeChange"));
            }
            return;
        }

        public function get intervalTargetZoneLowerLimit():int
        {
            return _intervalTargetZoneLowerLimit;
        }

        public function set intervalTargetZoneLowerLimit(arg1:int):void
        {
            if (arg1 != _intervalTargetZoneLowerLimit) 
            {
                _intervalTargetZoneLowerLimit = arg1;
                dispatchEvent(new flash.events.Event("intervalTargetZoneLowerLimitChange"));
            }
            return;
        }

        public function get intervalTargetZoneLowerLimitMax():int
        {
            return (Math.min(240, intervalTargetZoneUpperLimit) - 1);
        }

        public function get intervalTargetZoneLowerLimitMin():int
        {
            return 30;
        }

        public function get intervalTargetZoneUpperLimit():int
        {
            return _intervalTargetZoneUpperLimit;
        }

        public function set intervalTargetZoneUpperLimit(arg1:int):void
        {
            if (arg1 != _intervalTargetZoneUpperLimit) 
            {
                _intervalTargetZoneUpperLimit = arg1;
                dispatchEvent(new flash.events.Event("intervalTargetZoneUpperLimitChange"));
            }
            return;
        }

        public function get intervalTargetZoneUpperLimitMax():int
        {
            return 240;
        }

        public function get intervalTargetZoneUpperLimitMin():int
        {
            return Math.max(30, intervalTargetZoneLowerLimit) + 1;
        }

        public function get intervalTime():int
        {
            return _intervalTime;
        }

        public function set intervalTime(arg1:int):void
        {
            if (arg1 != _intervalTime) 
            {
                _intervalTime = arg1;
                dispatchEvent(new flash.events.Event("intervalTimeChange"));
            }
            return;
        }

        public function get intervalWarmUpTargetZoneLowerLimit():int
        {
            return _intervalWarmUpTargetZoneLowerLimit;
        }

        public function set intervalWarmUpTargetZoneLowerLimit(arg1:int):void
        {
            if (arg1 != _intervalWarmUpTargetZoneLowerLimit) 
            {
                _intervalWarmUpTargetZoneLowerLimit = arg1;
                dispatchEvent(new flash.events.Event("intervalWarmUpTargetZoneLowerLimitChange"));
            }
            return;
        }

        public function get intervalWarmUpTargetZoneLowerLimitMax():int
        {
            return (Math.min(240, intervalWarmUpTargetZoneUpperLimit) - 1);
        }

        public function get intervalWarmUpTargetZoneLowerLimitMin():int
        {
            return 30;
        }

        public function get intervalWarmUpTargetZoneUpperLimit():int
        {
            return _intervalWarmUpTargetZoneUpperLimit;
        }

        public function set intervalWarmUpTargetZoneUpperLimit(arg1:int):void
        {
            if (arg1 != _intervalWarmUpTargetZoneUpperLimit) 
            {
                _intervalWarmUpTargetZoneUpperLimit = arg1;
                dispatchEvent(new flash.events.Event("intervalWarmUpTargetZoneUpperLimitChange"));
            }
            return;
        }

        public function get intervalWarmUpTargetZoneUpperLimitMax():int
        {
            return 240;
        }

        public function get intervalWarmUpTargetZoneUpperLimitMin():int
        {
            return Math.max(30, intervalWarmUpTargetZoneLowerLimit) + 1;
        }

        public function get intervalWarmUpTime():int
        {
            return _intervalWarmUpTime;
        }

        internal const _myNameMaxLength:uint=10;

        internal static const NOW:Date=new Date();

        public static const FREE_OWN_ZONE_2_UPPER_LIMIT_DEFAULT:int=165;

        public static const FREE_OWN_ZONE_1_LOWER_LIMIT_DEFAULT:int=110;

        public static const FREE_OWN_ZONE_1_UPPER_LIMIT_DEFAULT:int=155;

        public static const FREE_OWN_ZONE_2_LOWER_LIMIT_DEFAULT:int=120;

        public static const FREE_OWN_ZONE_3_LOWER_LIMIT_DEFAULT:int=130;

        public static const FREE_OWN_ZONE_3_UPPER_LIMIT_DEFAULT:int=175;

        public static const MAXHEARTRATE_MAX:int=240;

        public static const MAXHEARTRATE_MIN:int=100;

        internal static const FAVORIT_TRIP_SIZE:int=9;

        internal var _freeOwnZone2UpperLimit:int=165;

        internal var _freeOwnZone3LowerLimit:int=130;

        internal var _freeOwnZone3UpperLimit:int=175;

        internal var _freeTrainingTargetZone:String="fitZone";

        internal var _gender:String="male";

        internal var _hrMax:int=190;

        internal var _intervalCoolDownTargetZoneLowerLimit:int=90;

        internal var _intervalWarmUpTargetZoneUpperLimit:int=130;

        internal var _lowBatDetectLevel:String;

        internal var _intervalCoolDownTargetZoneUpperLimit:int=120;

        internal var _intervalTime:int=60;

        internal var _myName:String="RC MOVE";

        internal var _intervalRecoveryTime:int=60;

        internal var _intervalCoolDownTime:int=300;

        internal var _intervalWarmUpTime:int=600;

        internal var _phaseAlarm:Boolean=true;

        internal var _intervalWarmUpTargetZoneLowerLimit:int=100;

        internal var _intervalTargetZoneUpperLimit:int=150;

        internal var _alarm:Date;

        internal var _keyLock:Boolean=false;

        internal var _intervalRecoveryMode:core.training.type.PhaseControl;

        internal var _zoneAlarm:Boolean=true;

        internal var _intervalTargetZoneLowerLimit:int=130;

        internal var _language:String="en";

        internal var _intensityZone1:Number=60;

        internal var _intensityZone2:Number=70;

        internal var _intensityZone3:Number=80;

        internal var _alarmMode:String="off";

        internal var _intensityZone4End:Number=100;

        internal var _intervalRecoveryHR:int=100;

        internal var _birthDate:Date;

        internal var _buttonTone:Boolean=true;

        internal var _dateFormat:String="eu";

        internal var _intensityZone4:Number=90;

        internal var _favoritesTrip1:__AS3__.vec.Vector.<String>;

        internal var _favoritesTrip2:__AS3__.vec.Vector.<String>;

        internal var _freeOwnZone1LowerLimit:int=110;

        internal var _freeOwnZone1UpperLimit:int=155;

        internal var _freeOwnZone2LowerLimit:int=120;

        internal var _samplingRate:Number=0;
    }
}


//  class SettingsPulseComputer
package core.settings 
{
    import core.settings.interfaces.*;
    import flash.events.*;
    
    public class SettingsPulseComputer extends core.settings.Settings implements core.settings.interfaces.IClock, core.settings.interfaces.IClockMode, core.settings.interfaces.IBodyWeight, core.settings.interfaces.IBodyWeightUnit
    {
        public function SettingsPulseComputer(arg1:flash.events.IEventDispatcher=null)
        {
            _clock = new Date(new Date().fullYear, 0, 1);
            super(arg1);
            return;
        }

        public function get bodyWeight():int
        {
            return _bodyWeight;
        }

        public function set bodyWeight(arg1:int):void
        {
            if (_bodyWeight !== arg1) 
            {
                _bodyWeight = arg1;
                dispatchEvent(new flash.events.Event("bodyWeightChange"));
            }
            return;
        }

        public function get bodyWeightMax():int
        {
            return 199000;
        }

        public function get bodyWeightMin():int
        {
            return 20000;
        }

        public function get bodyWeightUnit():String
        {
            return _bodyWeightUnit;
        }

        public function set bodyWeightUnit(arg1:String):void
        {
            if (_bodyWeightUnit !== arg1) 
            {
                _bodyWeightUnit = arg1;
                dispatchEvent(new flash.events.Event("bodyWeightUnitChange"));
            }
            return;
        }

        public function get clock():Date
        {
            return _clock;
        }

        public function set clock(arg1:Date):void
        {
            if (_clock !== arg1) 
            {
                _clock = arg1;
                dispatchEvent(new flash.events.Event("clockChange"));
            }
            return;
        }

        public function get clockMode():String
        {
            return _clockMode;
        }

        public function set clockMode(arg1:String):void
        {
            if (_clockMode !== arg1) 
            {
                _clockMode = arg1;
                dispatchEvent(new flash.events.Event("clockModeChange"));
            }
            return;
        }

        public override function toString():String
        {
            return "[SettingsPulseComputer extends Settings]";
        }

        public static const WEIGHT_G_MAX:int=199000;

        public static const WEIGHT_G_MIN:int=20000;

        internal var _bodyWeight:int=75000;

        internal var _bodyWeightUnit:String="kg";

        internal var _clock:Date;

        internal var _clockMode:String="24";
    }
}


//  class SettingsRC1411
package core.settings 
{
    import core.*;
    import core.settings.interfaces.*;
    import flash.events.*;
    
    public class SettingsRC1411 extends core.settings.SettingsRunningComputer implements core.settings.interfaces.ILowBatDetectLevel, core.settings.interfaces.ICorrectionFactor, core.settings.interfaces.IYearOfBirth, core.settings.interfaces.IHRmax, core.settings.interfaces.IHeartrateLimits, core.settings.interfaces.ITrainingZone, core.settings.interfaces.IBodyWeight, core.settings.interfaces.ILanguage, core.settings.interfaces.IContrast, core.settings.interfaces.ICalibration, core.settings.interfaces.IDateFormat, core.settings.interfaces.IBodyWeightUnit, core.settings.interfaces.IGender, core.settings.interfaces.IClockMode, core.settings.interfaces.IButtonTone, core.settings.interfaces.IZoneAlarm, core.settings.interfaces.ISamplingRate, core.settings.interfaces.IDate
    {
        public function SettingsRC1411(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            totalsSeperatedOnUnit = true;
            speedUnit = "kmh";
            return;
        }

        public function get bodyWeight():int
        {
            return _weight;
        }

        public function set bodyWeight(arg1:int):void
        {
            if (arg1 != _weight) 
            {
                _weight = arg1;
                dispatchEvent(new flash.events.Event("weightChange"));
            }
            return;
        }

        public function get bodyWeightMax():int
        {
            if (core.MeasurementConfig.weightFormat == "kg") 
            {
                return 199000;
            }
            return 180983;
        }

        public function get bodyWeightMin():int
        {
            if (core.MeasurementConfig.weightFormat == "kg") 
            {
                return 20000;
            }
            return 18144;
        }

        public function get bodyWeightUnit():String
        {
            return _weightUnit;
        }

        public function set bodyWeightUnit(arg1:String):void
        {
            if (arg1 != _weightUnit) 
            {
                _weightUnit = arg1;
                dispatchEvent(new flash.events.Event("weightUnitChange"));
            }
            return;
        }

        public function set trainingZone(arg1:String):void
        {
            if (arg1 != _trainingZone) 
            {
                _trainingZone = arg1;
                dispatchEvent(new flash.events.Event("trainingZoneChange"));
            }
            return;
        }

        public function get buttonTone():Boolean
        {
            return _buttonTone;
        }

        public function set buttonTone(arg1:Boolean):void
        {
            if (arg1 != _buttonTone) 
            {
                _buttonTone = arg1;
                dispatchEvent(new flash.events.Event("buttonToneChange"));
            }
            return;
        }

        public function get upperLimit():int
        {
            return _upperLimit;
        }

        public function get calibration():Boolean
        {
            return _calibration;
        }

        public function set calibration(arg1:Boolean):void
        {
            if (arg1 != _calibration) 
            {
                _calibration = arg1;
                dispatchEvent(new flash.events.Event("calibrationChange"));
            }
            return;
        }

        public function set upperLimit(arg1:int):void
        {
            if (arg1 != _upperLimit) 
            {
                _upperLimit = arg1;
                dispatchEvent(new flash.events.Event("upperLimitChange"));
            }
            return;
        }

        public function get calibrationDone():Boolean
        {
            return _calibrationDone;
        }

        public function set calibrationDone(arg1:Boolean):void
        {
            if (arg1 != _calibrationDone) 
            {
                _calibrationDone = arg1;
                dispatchEvent(new flash.events.Event("calibrationDoneChange"));
            }
            return;
        }

        public function get upperLimitMax():int
        {
            return 240;
        }

        public function get clockMode():String
        {
            return _clockMode;
        }

        public function set clockMode(arg1:String):void
        {
            if (arg1 != _clockMode) 
            {
                _clockMode = arg1;
                dispatchEvent(new flash.events.Event("clockModeChange"));
            }
            return;
        }

        public function get upperLimitMin():int
        {
            return lowerLimit + 5;
        }

        public function get contrast():int
        {
            return _contrast;
        }

        public function set contrast(arg1:int):void
        {
            if (arg1 != _contrast) 
            {
                _contrast = arg1;
                dispatchEvent(new flash.events.Event("contrastChange"));
            }
            return;
        }

        public function get contrastMax():int
        {
            return 5;
        }

        public function get contrastMin():int
        {
            return 1;
        }

        public function get yearOfBirth():int
        {
            return _yearOfBirth;
        }

        public function get correctionFactor():int
        {
            return _correctionFactor;
        }

        public function set correctionFactor(arg1:int):void
        {
            if (arg1 != _correctionFactor) 
            {
                _correctionFactor = arg1;
                dispatchEvent(new flash.events.Event("correctionFactorChange"));
            }
            return;
        }

        public function get correctionFactorMax():int
        {
            return 1500;
        }

        public function get correctionFactorMin():int
        {
            return 500;
        }

        public function set yearOfBirth(arg1:int):void
        {
            if (arg1 != _yearOfBirth) 
            {
                _yearOfBirth = arg1;
                dispatchEvent(new flash.events.Event("yearOfBirthChange"));
            }
            return;
        }

        public function get dateFormat():String
        {
            return _dateFormat;
        }

        public function set dateFormat(arg1:String):void
        {
            if (arg1 != _dateFormat) 
            {
                _dateFormat = arg1;
                dispatchEvent(new flash.events.Event("dateFormatChange"));
            }
            return;
        }

        public function get yearOfBirthMax():int
        {
            return YEAR_OF_BIRTH_MAX;
        }

        public function get gender():String
        {
            return _gender;
        }

        public function set gender(arg1:String):void
        {
            if (arg1 != _gender) 
            {
                _gender = arg1;
                dispatchEvent(new flash.events.Event("genderChange"));
            }
            return;
        }

        public function get yearOfBirthMin():int
        {
            return 1900;
        }

        public function get hrMax():int
        {
            return _hrMax;
        }

        public function set hrMax(arg1:int):void
        {
            if (arg1 != _hrMax) 
            {
                _hrMax = arg1;
                dispatchEvent(new flash.events.Event("hrMaxChange"));
            }
            return;
        }

        public function get hrMaxMax():int
        {
            return 240;
        }

        public function get hrMaxMin():int
        {
            return 100;
        }

        public function get zoneAlarm():Boolean
        {
            return _zoneAlarm;
        }

        public function get language():String
        {
            return _language;
        }

        public function set language(arg1:String):void
        {
            if (arg1 != _language) 
            {
                _language = arg1;
                dispatchEvent(new flash.events.Event("languageChange"));
            }
            return;
        }

        public function set zoneAlarm(arg1:Boolean):void
        {
            if (arg1 != _zoneAlarm) 
            {
                _zoneAlarm = arg1;
                dispatchEvent(new flash.events.Event("zoneAlarmChange"));
            }
            return;
        }

        public function get lowBatDetectLevel():String
        {
            return _lowBatDetectLevel;
        }

        public function set lowBatDetectLevel(arg1:String):void
        {
            if (arg1 != _lowBatDetectLevel) 
            {
                _lowBatDetectLevel = arg1;
                dispatchEvent(new flash.events.Event("lowBatDetectLevelChange"));
            }
            return;
        }

        public override function toString():String
        {
            return "[SettingsRC1411...]";
        }

        public function get lowerLimit():int
        {
            return _lowerLimit;
        }

        public function set lowerLimit(arg1:int):void
        {
            if (arg1 != _lowerLimit) 
            {
                _lowerLimit = arg1;
                dispatchEvent(new flash.events.Event("lowerLimitChange"));
            }
            return;
        }

        public function get lowerLimitMax():int
        {
            return upperLimit - 5;
        }

        public function get lowerLimitMin():int
        {
            return 40;
        }

        public function get needUpdateSettingInfo():Boolean
        {
            return _needUpdateSettingInfo;
        }

        public function set needUpdateSettingInfo(arg1:Boolean):void
        {
            _needUpdateSettingInfo = arg1;
            return;
        }

        public function get samplingRate():Number
        {
            return _samplingRate;
        }

        public function set samplingRate(arg1:Number):void
        {
            if (arg1 != _samplingRate) 
            {
                _samplingRate = arg1;
                dispatchEvent(new flash.events.Event("samplingRateChange"));
            }
            return;
        }

        public function get trainingZone():String
        {
            return _trainingZone;
        }

        public static const MAXHEARTRATE_MAX:int=240;

        public static const MAXHEARTRATE_MIN:int=100;

        public static const TOTAL_CALORIES_MAX:int=99999;

        public static const TOTAL_DISTANCE_MAX_KM:int=99999000;

        public static const TOTAL_DISTANCE_MAX_MI:Number=160932790.656;

        public static const TOTAL_CALORIES_MIN:int=0;

        public static const TOTAL_DISTANCE_MIN:int=0;

        public static const TOTAL_TIME_HOURS_MAX:int=999;

        public static const TOTAL_TIME_HOURS_MIN:int=0;

        public static const TOTAL_TIME_MAX:int=359999900;

        public static const TOTAL_TIME_MINUTES_MAX:int=59;

        public static const TOTAL_TIME_MINUTES_MIN:int=0;

        public static const TOTAL_TIME_SECONDS_MAX:int=59;

        public static const TOTAL_TIME_SECONDS_MIN:int=0;

        public static const WEIGHTLB_MIN_IN_KG:int=18144;

        public static const WEIGHT_KG_MAX:int=199000;

        public static const WEIGHT_KG_MIN:int=20000;

        public static const CORRECTION_FACTOR_MAX:int=1500;

        public static const YEAR_OF_BIRTH_MAX:int=new Date().fullYear - 6;

        public static const YEAR_OF_BIRTH_MIN:int=1900;

        public static const CONTRAST_MAX:int=5;

        public static const CONTRAST_MIN:int=1;

        public static const WEIGHTLB_MAX_IN_KG:int=180983;

        public static const CORRECTION_FACTOR_MIN:int=500;

        internal var _buttonTone:Boolean=true;

        internal var _calibration:Boolean;

        internal var _calibrationDone:Boolean;

        internal var _clockMode:String="24";

        internal var _contrast:int=3;

        internal var _dateFormat:String="eu";

        internal var _gender:String="male";

        internal var _hrMax:int=191;

        internal var _language:String="en";

        internal var _lowBatDetectLevel:String;

        internal var _lowerLimit:int=105;

        internal var _samplingRate:Number=5;

        internal var _upperLimit:int=155;

        internal var _zoneAlarm:Boolean=true;

        internal var _yearOfBirth:int;

        internal var _trainingZone:String="fitZone";

        internal var _weightUnit:String="kg";

        internal var _needUpdateSettingInfo:Boolean=false;

        internal var _correctionFactor:int=1000;

        internal var _weight:int=75000;
    }
}


//  class SettingsROX
package core.settings 
{
    import __AS3__.vec.*;
    import core.general.*;
    import core.settings.interfaces.*;
    import flash.events.*;
    
    public class SettingsROX extends core.settings.SettingsBikeComputer implements core.settings.interfaces.ILanguage, core.settings.interfaces.IThreeZones, core.settings.interfaces.IWheelSize2, core.settings.interfaces.IBodyWeight, core.settings.interfaces.IGender, core.settings.interfaces.IDate, core.settings.interfaces.IFavoriteTrip1, core.settings.interfaces.IFavoriteTrip2, core.settings.interfaces.IBirthDate, core.settings.interfaces.IClockMode, core.settings.interfaces.IHomeAltitude1, core.settings.interfaces.IHomeAltitude2, core.settings.interfaces.IHomeAltitude3, core.settings.interfaces.IHRmax, core.settings.interfaces.IVolume, core.settings.interfaces.IDateFormat, core.settings.interfaces.IZoneAlarm, core.settings.interfaces.IButtonInfo, core.settings.interfaces.IBodyWeightUnit, core.settings.interfaces.IMyName, core.settings.interfaces.IShowTotals, core.settings.interfaces.ILowBatDetectLevel, core.settings.interfaces.IContrast, core.settings.interfaces.IWheelSize1
    {
        public function SettingsROX(arg1:flash.events.IEventDispatcher=null, arg2:core.general.UnitType=null)
        {
            _birthDate = new Date(1981, 0, 1);
            _favoritesTrip1 = new __AS3__.vec.Vector.<String>();
            _favoritesTrip2 = new __AS3__.vec.Vector.<String>();
            super(arg1);
            wheelSize1 = 2155;
            speedUnit = "kmh";
            _favoritesTrip1 = new __AS3__.vec.Vector.<String>(10);
            _favoritesTrip2 = new __AS3__.vec.Vector.<String>(10);
            if (core.general.UnitType.ROX90 != arg2) 
            {
                if (core.general.UnitType.ROX80 == arg2) 
                {
                    _myName = " ROX 8.0  ";
                    _favoritesTrip1[0] = core.general.FavoritesROX2010.FAVORITES_GUI[0];
                    _favoritesTrip1[1] = core.general.FavoritesROX2010.FAVORITES_GUI[1];
                    _favoritesTrip1[2] = core.general.FavoritesROX2010.FAVORITES_GUI[2];
                    _favoritesTrip1[3] = core.general.FavoritesROX2010.FAVORITES_GUI[3];
                    _favoritesTrip1[4] = core.general.FavoritesROX2010.FAVORITES_GUI[12];
                    _favoritesTrip1[5] = core.general.FavoritesROX2010.FAVORITES_GUI[16];
                    _favoritesTrip1[6] = core.general.FavoritesROX2010.FAVORITES_GUI[44];
                    _favoritesTrip1[7] = core.general.FavoritesROX2010.FAVORITES_GUI[43];
                    _favoritesTrip1[8] = core.general.FavoritesROX2010.FAVORITES_GUI[18];
                    _favoritesTrip1[9] = core.general.FavoritesROX2010.FAVORITES_GUI[41];
                    _favoritesTrip2[0] = core.general.FavoritesROX2010.FAVORITES_GUI[0];
                    _favoritesTrip2[1] = core.general.FavoritesROX2010.FAVORITES_GUI[1];
                    _favoritesTrip2[2] = core.general.FavoritesROX2010.FAVORITES_GUI[2];
                    _favoritesTrip2[3] = core.general.FavoritesROX2010.FAVORITES_GUI[12];
                    _favoritesTrip2[4] = core.general.FavoritesROX2010.FAVORITES_GUI[22];
                    _favoritesTrip2[5] = core.general.FavoritesROX2010.FAVORITES_GUI[24];
                    _favoritesTrip2[6] = core.general.FavoritesROX2010.FAVORITES_GUI[27];
                    _favoritesTrip2[7] = core.general.FavoritesROX2010.FAVORITES_GUI[29];
                    _favoritesTrip2[8] = core.general.FavoritesROX2010.FAVORITES_GUI[23];
                    _favoritesTrip2[9] = core.general.FavoritesROX2010.FAVORITES_GUI[41];
                }
            }
            else 
            {
                _myName = " ROX 9.0  ";
                _favoritesTrip1[0] = core.general.FavoritesROX2010.FAVORITES_GUI[0];
                _favoritesTrip1[1] = core.general.FavoritesROX2010.FAVORITES_GUI[1];
                _favoritesTrip1[2] = core.general.FavoritesROX2010.FAVORITES_GUI[2];
                _favoritesTrip1[3] = core.general.FavoritesROX2010.FAVORITES_GUI[3];
                _favoritesTrip1[4] = core.general.FavoritesROX2010.FAVORITES_GUI[12];
                _favoritesTrip1[5] = core.general.FavoritesROX2010.FAVORITES_GUI[16];
                _favoritesTrip1[6] = core.general.FavoritesROX2010.FAVORITES_GUI[44];
                _favoritesTrip1[7] = core.general.FavoritesROX2010.FAVORITES_GUI[43];
                _favoritesTrip1[8] = core.general.FavoritesROX2010.FAVORITES_GUI[18];
                _favoritesTrip1[9] = core.general.FavoritesROX2010.FAVORITES_GUI[41];
                _favoritesTrip2[0] = core.general.FavoritesROX2010.FAVORITES_GUI[0];
                _favoritesTrip2[1] = core.general.FavoritesROX2010.FAVORITES_GUI[1];
                _favoritesTrip2[2] = core.general.FavoritesROX2010.FAVORITES_GUI[2];
                _favoritesTrip2[3] = core.general.FavoritesROX2010.FAVORITES_GUI[12];
                _favoritesTrip2[4] = core.general.FavoritesROX2010.FAVORITES_GUI[22];
                _favoritesTrip2[5] = core.general.FavoritesROX2010.FAVORITES_GUI[24];
                _favoritesTrip2[6] = core.general.FavoritesROX2010.FAVORITES_GUI[27];
                _favoritesTrip2[7] = core.general.FavoritesROX2010.FAVORITES_GUI[29];
                _favoritesTrip2[8] = core.general.FavoritesROX2010.FAVORITES_GUI[23];
                _favoritesTrip2[9] = core.general.FavoritesROX2010.FAVORITES_GUI[41];
            }
            return;
        }

        public function get startZone1():int
        {
            return _startZone1;
        }

        public function get birthDate():Date
        {
            return _birthDate;
        }

        public function set birthDate(arg1:Date):void
        {
            if (arg1 != _birthDate) 
            {
                _birthDate = arg1;
                dispatchEvent(new flash.events.Event("birthDateChange"));
            }
            return;
        }

        public function get birthDateMax():Number
        {
            return new Date(NOW.fullYear - 6, NOW.month, NOW.date).time;
        }

        public function get birthDateMin():Number
        {
            return new Date(1900, 0, 1).time;
        }

        public function get bodyWeight():int
        {
            return _weight;
        }

        public function set bodyWeight(arg1:int):void
        {
            if (arg1 != _weight) 
            {
                _weight = arg1;
                dispatchEvent(new flash.events.Event("weightChange"));
            }
            return;
        }

        public function get bodyWeightMax():int
        {
            return 199000;
        }

        public function get bodyWeightMin():int
        {
            return 20000;
        }

        public function get bodyWeightUnit():String
        {
            return _weightUnit;
        }

        public function set bodyWeightUnit(arg1:String):void
        {
            if (arg1 != _weightUnit) 
            {
                _weightUnit = arg1;
                dispatchEvent(new flash.events.Event("weightUnitChange"));
            }
            return;
        }

        public function set startZone1(arg1:int):void
        {
            if (arg1 != _startZone1) 
            {
                _startZone1 = arg1;
                dispatchEvent(new flash.events.Event("startZone1Change"));
            }
            return;
        }

        public function get buttonInfo():Boolean
        {
            return _buttonInfo;
        }

        public function set buttonInfo(arg1:Boolean):void
        {
            if (arg1 != _buttonInfo) 
            {
                _buttonInfo = arg1;
                dispatchEvent(new flash.events.Event("buttonInfoChange"));
            }
            return;
        }

        public function get wheelSize2Max():int
        {
            return 3999;
        }

        public function get clockMode():String
        {
            return _clockMode;
        }

        public function set clockMode(arg1:String):void
        {
            if (arg1 != _clockMode) 
            {
                _clockMode = arg1;
                dispatchEvent(new flash.events.Event("clockModeChange"));
            }
            return;
        }

        public function get startZone2():int
        {
            return _startZone2;
        }

        public function get contrast():int
        {
            return _contrast;
        }

        public function set contrast(arg1:int):void
        {
            if (arg1 != _contrast) 
            {
                _contrast = arg1;
                dispatchEvent(new flash.events.Event("contrastChange"));
            }
            return;
        }

        public function get contrastMax():int
        {
            return 15;
        }

        public function get contrastMin():int
        {
            return 0;
        }

        public function set startZone2(arg1:int):void
        {
            if (arg1 != _startZone2) 
            {
                _startZone2 = arg1;
                dispatchEvent(new flash.events.Event("startZone2Change"));
            }
            return;
        }

        public function get dateFormat():String
        {
            return _dateFormat;
        }

        public function set dateFormat(arg1:String):void
        {
            if (arg1 != _dateFormat) 
            {
                _dateFormat = arg1;
                dispatchEvent(new flash.events.Event("dateFormatChange"));
            }
            return;
        }

        public function get wheelSize2Min():int
        {
            return 1000;
        }

        public function get endZone3():int
        {
            return _endZone3;
        }

        public function set endZone3(arg1:int):void
        {
            if (arg1 != _endZone3) 
            {
                _endZone3 = arg1;
                dispatchEvent(new flash.events.Event("endZone3Change"));
            }
            return;
        }

        public function get startZone3():int
        {
            return _startZone3;
        }

        public function get favoritesTrip1():__AS3__.vec.Vector.<String>
        {
            return _favoritesTrip1;
        }

        public function set favoritesTrip1(arg1:__AS3__.vec.Vector.<String>):void
        {
            if (_favoritesTrip1 !== arg1) 
            {
                _favoritesTrip1 = arg1;
                dispatchEvent(new flash.events.Event("favoritesTrip1Change"));
            }
            return;
        }

        public function get favoritesTrip1Size():int
        {
            return 10;
        }

        public function set startZone3(arg1:int):void
        {
            if (arg1 != _startZone3) 
            {
                _startZone3 = arg1;
                dispatchEvent(new flash.events.Event("startZone3Change"));
            }
            return;
        }

        public function get favoritesTrip2():__AS3__.vec.Vector.<String>
        {
            return _favoritesTrip2;
        }

        public function set favoritesTrip2(arg1:__AS3__.vec.Vector.<String>):void
        {
            if (_favoritesTrip2 !== arg1) 
            {
                _favoritesTrip2 = arg1;
                dispatchEvent(new flash.events.Event("favoritesTrip2Change"));
            }
            return;
        }

        public function get favoritesTrip2Size():int
        {
            return 10;
        }

        public override function toString():String
        {
            return "[SettingsROX extends SettingsBikeComputer implements ILanguage, IThreeZones, IWheelSize2, IWeight, IGender, IDate, IFavorite1, IFavorite2,...]";
        }

        public function get gender():String
        {
            return _gender;
        }

        public function set gender(arg1:String):void
        {
            if (arg1 != _gender) 
            {
                _gender = arg1;
                dispatchEvent(new flash.events.Event("genderChange"));
            }
            return;
        }

        public function get volume():int
        {
            return _volume;
        }

        public function get homeAltitude1():int
        {
            return _homeAltitude1;
        }

        public function set homeAltitude1(arg1:int):void
        {
            if (arg1 != _homeAltitude1) 
            {
                _homeAltitude1 = arg1;
                dispatchEvent(new flash.events.Event("homeAltitude1Change"));
            }
            return;
        }

        public function get homeAltitude1Max():int
        {
            return 4999000;
        }

        public function get homeAltitude1Min():int
        {
            return -999000;
        }

        public function set volume(arg1:int):void
        {
            if (arg1 != _volume) 
            {
                _volume = arg1;
                dispatchEvent(new flash.events.Event("volumeChange"));
            }
            return;
        }

        public function get homeAltitude2():int
        {
            return _homeAltitude2;
        }

        public function set homeAltitude2(arg1:int):void
        {
            if (arg1 != _homeAltitude2) 
            {
                _homeAltitude2 = arg1;
                dispatchEvent(new flash.events.Event("homeAltitude2Change"));
            }
            return;
        }

        public function get homeAltitude2Max():int
        {
            return homeAltitude1Max;
        }

        public function get homeAltitude2Min():int
        {
            return homeAltitude1Min;
        }

        public function get zoneAlarm():Boolean
        {
            return _zoneAlarm;
        }

        public function get homeAltitude3():int
        {
            return _homeAltitude3;
        }

        public function set homeAltitude3(arg1:int):void
        {
            if (arg1 != _homeAltitude3) 
            {
                _homeAltitude3 = arg1;
                dispatchEvent(new flash.events.Event("homeAltitude3Change"));
            }
            return;
        }

        public function get homeAltitude3Max():int
        {
            return homeAltitude1Max;
        }

        public function get homeAltitude3Min():int
        {
            return homeAltitude1Min;
        }

        public function get wheelSize1():int
        {
            return _wheelSize1;
        }

        public function get hrMax():int
        {
            return _hrMax;
        }

        public function set hrMax(arg1:int):void
        {
            if (arg1 != _hrMax) 
            {
                _hrMax = arg1;
                dispatchEvent(new flash.events.Event("hrMaxChange"));
            }
            return;
        }

        public function get hrMaxMax():int
        {
            return 240;
        }

        public function get hrMaxMin():int
        {
            return 100;
        }

        public function set wheelSize1(arg1:int):void
        {
            if (_wheelSize1 !== arg1) 
            {
                _wheelSize1 = arg1;
                dispatchEvent(new flash.events.Event("wheelSize1Change"));
            }
            return;
        }

        public function get language():String
        {
            return _language;
        }

        public function set language(arg1:String):void
        {
            if (arg1 != _language) 
            {
                _language = arg1;
                dispatchEvent(new flash.events.Event("languageChange"));
            }
            return;
        }

        public function get wheelSize1Max():int
        {
            return 3999;
        }

        public function get lowBatDetectLevel():String
        {
            return _lowBatDetectLevel;
        }

        public function set lowBatDetectLevel(arg1:String):void
        {
            if (arg1 != _lowBatDetectLevel) 
            {
                _lowBatDetectLevel = arg1;
                dispatchEvent(new flash.events.Event("lowBatDetectLevelChange"));
            }
            return;
        }

        public function get wheelSize1Min():int
        {
            return 1000;
        }

        public function get myName():String
        {
            if ("") 
            {
                if (core.general.UnitType.ROX8 == unitType || core.general.UnitType.ROX80 == unitType) 
                {
                    return " ROX 8.0  ";
                }
                if (core.general.UnitType.ROX9 == unitType || core.general.UnitType.ROX90 == unitType) 
                {
                    return " ROX 9.0  ";
                }
            }
            return _myName;
        }

        public function set myName(arg1:String):void
        {
            if (arg1 != _myName) 
            {
                _myName = arg1;
                dispatchEvent(new flash.events.Event("myNameChange"));
            }
            return;
        }

        public function set zoneAlarm(arg1:Boolean):void
        {
            if (arg1 != _zoneAlarm) 
            {
                _zoneAlarm = arg1;
                dispatchEvent(new flash.events.Event("zoneAlarmChange"));
            }
            return;
        }

        public function get myNameMaxLength():uint
        {
            return 10;
        }

        public function get wheelSize2():int
        {
            return _wheelSize2;
        }

        public function get showTotals():int
        {
            return _showTotals;
        }

        public function set showTotals(arg1:int):void
        {
            if (arg1 != _showTotals) 
            {
                _showTotals = arg1;
                dispatchEvent(new flash.events.Event("showTotalsChange"));
            }
            return;
        }

        public function set wheelSize2(arg1:int):void
        {
            if (arg1 != _wheelSize2) 
            {
                _wheelSize2 = arg1;
                dispatchEvent(new flash.events.Event("wheelSize2Change"));
            }
            return;
        }

        public static const TOTALTIMEUPBIKE2_SECONDS_MAX:int=59;

        public static const TOTALTIMEUPBIKE2_SECONDS_MIN:int=0;

        public static const TOTALTRIPDISTDOWNBIKE1_MAX_KM:Number=99999000;

        public static const TOTALTRIPDISTDOWNBIKE1_MAX_MI:Number=160932790.656;

        public static const TOTALTRIPDISTDOWNBIKE1_MIN:int=0;

        public static const TOTALTRIPDISTDOWNBIKE2_MAX_KM:Number=99999000;

        public static const TOTALTRIPDISTDOWNBIKE2_MAX_MI:Number=160932790.656;

        public static const TOTALTRIPDISTDOWNBIKE2_MIN:int=0;

        public static const TOTALTRIPDISTUPBIKE1_MAX_KM:Number=99999000;

        public static const TOTALTRIPDISTUPBIKE1_MAX_MI:Number=160932790.656;

        public static const TOTALTRIPDISTUPBIKE1_MIN:int=0;

        public static const TOTALTRIPDISTUPBIKE2_MAX_KM:Number=99999000;

        public static const TOTALTRIPDISTUPBIKE2_MAX_MI:Number=160932790.656;

        public static const TOTALTRIPDISTUPBIKE2_MIN:int=0;

        public static const VOLUME_MAX:int=5;

        public static const VOLUME_MIN:int=1;

        internal const _myNameMaxLength:uint=10;

        public static const WEIGHTLB_MAX:int=399;

        public static const WEIGHTLB_MIN:int=40;

        public static const WEIGHT_G_MAX:int=199000;

        public static const WEIGHT_G_MIN:int=20000;

        public static const WHEEL_SBIKE1_MAX:int=3999;

        public static const WHEEL_SBIKE1_MIN:int=1000;

        internal static const FAVORIT_TRIP_SIZE:int=10;

        internal static const NOW:Date=new Date();

        internal static const WHEEL_SBIKE2_MAX:int=3999;

        internal static const WHEEL_SBIKE2_MIN:int=1000;

        public static const CHECKSUM3_MAX:int=65535;

        public static const CHECKSUM3_MIN:int=0;

        public static const CLOCK_MAX:int=86399;

        public static const CLOCK_MIN:int=0;

        public static const CONTRAST_MAX:int=15;

        public static const CONTRAST_MIN:int=0;

        public static const DATE_MAX:Date=new Date(2099, 11, 31);

        public static const DATE_MIN:Date=new Date(2006, 0, 1);

        public static const ENDPOWERZONE_MAX:int=240;

        public static const ENDPOWERZONE_MIN:int=40;

        public static const HOME_ALTITUDE_FT_MAX:Number=3.0479999997e+012;

        public static const HOME_ALTITUDE_FT_MIN:int=-304496;

        public static const HOME_ALTITUDE_M_MAX:int=4999000;

        public static const HOME_ALTITUDE_M_MIN:int=-999000;

        public static const MAXALTITUEBIKE1_FT_MAX:int=3047696;

        public static const MAXALTITUEBIKE1_FT_MIN:int=-304496;

        public static const MAXALTITUEBIKE1_M_MAX:int=4999000;

        public static const MAXALTITUEBIKE1_M_MIN:int=-999000;

        public static const MAXALTITUEBIKE2_FT_MAX:int=3047696;

        public static const MAXALTITUEBIKE2_FT_MIN:int=-304496;

        public static const MAXALTITUEBIKE2_M_MAX:int=4999000;

        public static const MAXALTITUEBIKE2_M_MIN:int=-999000;

        public static const MAXHEARTRATE_MAX:int=240;

        public static const MAXHEARTRATE_MIN:int=100;

        public static const STARTFITNESSZONE_MAX:int=240;

        public static const STARTFITNESSZONE_MIN:int=40;

        public static const STARTHEALTHZONE_MAX:int=240;

        public static const STARTHEALTHZONE_MIN:int=40;

        public static const STARTPOWERZONE_MAX:int=240;

        public static const STARTPOWERZONE_MIN:int=40;

        public static const TOTALCLIMBMETERBIKE1_MAX_FT:int=304799969;

        public static const TOTALCLIMBMETERBIKE1_MAX_M:int=999999000;

        public static const TOTALCLIMBMETERBIKE1_MIN:int=0;

        public static const TOTALCLIMBMETERBIKE2_MAX_FT:int=304799969;

        public static const TOTALCLIMBMETERBIKE2_MAX_M:int=999999000;

        public static const TOTALCLIMBMETERBIKE2_MIN:int=0;

        public static const TOTALDBIKE1_MAX_KM:Number=99999000;

        public static const TOTALDBIKE1_MAX_MI:Number=160932790.656;

        public static const TOTALDBIKE1_MIN:int=0;

        public static const TOTALDBIKE2_MAX_KM:Number=99999000;

        public static const TOTALDBIKE2_MAX_MI:Number=160932790.656;

        public static const TOTALDBIKE2_MIN:int=0;

        public static const TOTALDESCENTBIKE1_MAX_FT:int=304799969;

        public static const TOTALDESCENTBIKE1_MAX_M:int=999999000;

        public static const TOTALDESCENTBIKE1_MIN:int=0;

        public static const TOTALDESCENTBIKE2_MAX_FT:int=304799969;

        public static const TOTALDESCENTBIKE2_MAX_M:int=999999000;

        public static const TOTALDESCENTBIKE2_MIN:int=0;

        public static const TOTALKCALBIKE1_MAX:int=999999;

        public static const TOTALKCALBIKE1_MIN:int=0;

        public static const TOTALKCALBIKE2_MAX:int=999999;

        public static const TOTALKCALBIKE2_MIN:int=0;

        public static const TOTALTIMEBIKE1_HOURS_MAX:int=9999;

        public static const TOTALTIMEBIKE1_HOURS_MIN:int=0;

        public static const TOTALTIMEBIKE1_MAX:uint=3599999900;

        public static const TOTALTIMEBIKE1_MINUTES_MAX:int=59;

        public static const TOTALTIMEBIKE1_MINUTES_MIN:int=0;

        public static const TOTALTIMEBIKE1_SECONDS_MAX:int=59;

        public static const TOTALTIMEBIKE1_SECONDS_MIN:int=0;

        public static const TOTALTIMEBIKE2_HOURS_MAX:int=9999;

        public static const TOTALTIMEBIKE2_HOURS_MIN:int=0;

        public static const TOTALTIMEBIKE2_MINUTES_MAX:int=59;

        public static const TOTALTIMEBIKE2_MINUTES_MIN:int=0;

        public static const TOTALTIMEBIKE2_SECONDS_MAX:int=59;

        public static const TOTALTIMEBIKE2_SECONDS_MIN:int=0;

        public static const TOTALTIMEDOWNBIKE1_HOURS_MAX:int=9999;

        public static const TOTALTIMEDOWNBIKE1_HOURS_MIN:int=0;

        public static const TOTALTIMEDOWNBIKE1_MAX:uint=3599999900;

        public static const TOTALTIMEDOWNBIKE1_MINUTES_MAX:int=59;

        public static const TOTALTIMEDOWNBIKE1_MINUTES_MIN:int=0;

        public static const TOTALTIMEDOWNBIKE1_SECONDS_MAX:int=59;

        public static const TOTALTIMEDOWNBIKE1_SECONDS_MIN:int=0;

        public static const TOTALTIMEDOWNBIKE2_HOURS_MAX:int=9999;

        public static const TOTALTIMEDOWNBIKE2_HOURS_MIN:int=0;

        public static const TOTALTIMEDOWNBIKE2_MAX:uint=3599999900;

        public static const TOTALTIMEDOWNBIKE2_MINUTES_MAX:int=59;

        public static const TOTALTIMEDOWNBIKE2_MINUTES_MIN:int=0;

        public static const TOTALTIMEDOWNBIKE2_SECONDS_MAX:int=59;

        public static const TOTALTIMEDOWNBIKE2_SECONDS_MIN:int=0;

        public static const TOTALTIMEUPBIKE1_HOURS_MAX:int=9999;

        public static const TOTALTIMEUPBIKE1_HOURS_MIN:int=0;

        public static const TOTALTIMEUPBIKE1_MAX:uint=3599999900;

        public static const TOTALTIMEUPBIKE1_MINUTES_MAX:int=59;

        public static const TOTALTIMEUPBIKE1_MINUTES_MIN:int=0;

        public static const TOTALTIMEUPBIKE1_SECONDS_MAX:int=59;

        public static const TOTALTIMEUPBIKE1_SECONDS_MIN:int=0;

        public static const TOTALTIMEUPBIKE2_HOURS_MAX:int=9999;

        public static const TOTALTIMEUPBIKE2_HOURS_MIN:int=0;

        public static const TOTALTIMEUPBIKE2_MAX:uint=3599999900;

        public static const TOTALTIMEUPBIKE2_MINUTES_MAX:int=59;

        public static const TOTALTIMEUPBIKE2_MINUTES_MIN:int=0;

        internal var _birthDate:Date;

        internal var _buttonInfo:Boolean=false;

        internal var _clockMode:String="24";

        internal var _contrast:int=10;

        internal var _dateFormat:String="eu";

        internal var _endZone3:int=194;

        internal var _favoritesTrip1:__AS3__.vec.Vector.<String>;

        internal var _favoritesTrip2:__AS3__.vec.Vector.<String>;

        internal var _gender:String="male";

        internal var _homeAltitude1:int=100000;

        internal var _homeAltitude2:int=200000;

        internal var _homeAltitude3:int=300000;

        internal var _hrMax:int=194;

        internal var _language:String="en";

        internal var _lowBatDetectLevel:String;

        internal var _myName:String="";

        internal var _showTotals:int;

        internal var _startZone1:int=107;

        internal var _startZone2:int=136;

        internal var _startZone3:int=155;

        internal var _volume:int=3;

        internal var _wheelSize1:int=2155;

        internal var _wheelSize2:int=2000;

        internal var _zoneAlarm:Boolean=true;

        internal var _weight:int=75000;

        internal var _weightUnit:String="kg";
    }
}


//  class SettingsROX100
package core.settings 
{
    import __AS3__.vec.*;
    import core.*;
    import core.general.*;
    import core.settings.interfaces.*;
    import core.units.interfaces.*;
    import flash.events.*;
    
    public class SettingsROX100 extends core.settings.SettingsBikeComputer implements core.settings.interfaces.IDate, core.settings.interfaces.IDistanceUnit, core.settings.interfaces.IAltitudeUnit, core.settings.interfaces.ITemperatureUnit, core.settings.interfaces.IWeightUnit, core.settings.interfaces.IDateFormat, core.settings.interfaces.IClockMode, core.settings.interfaces.ILanguage, core.settings.interfaces.ISamplingRate, core.settings.interfaces.ITimeZone, core.settings.interfaces.ISummerTime, core.settings.interfaces.ICountdown, core.settings.interfaces.IMyName, core.settings.interfaces.IAutoPause, core.settings.interfaces.IZoneAlarm, core.settings.interfaces.IButtonTone, core.settings.interfaces.ISystemTone, core.settings.interfaces.IContrast, core.settings.interfaces.IBacklightTime, core.settings.interfaces.IPowerMeterFormula, core.settings.interfaces.IBikeType1, core.settings.interfaces.IBikeType2, core.settings.interfaces.IBikeType3, core.settings.interfaces.IBikeWeight1, core.settings.interfaces.IBikeWeight2, core.settings.interfaces.IBikeWeight3, core.settings.interfaces.IWheelSize2, core.settings.interfaces.IWheelSize3, core.settings.interfaces.IHomeAltitude1, core.settings.interfaces.IHomeAltitude2, core.settings.interfaces.IHomeAltitude3, core.settings.interfaces.ISeaLevel, core.settings.interfaces.IGender, core.settings.interfaces.IBirthDate, core.settings.interfaces.IBodyWeight, core.settings.interfaces.IBodyWeightUnit, core.settings.interfaces.IBodyHeight, core.settings.interfaces.IBodyHeightUnit, core.settings.interfaces.IShoulderWidth, core.settings.interfaces.IShoulderWidthUnit, core.settings.interfaces.IHRmax, core.units.interfaces.IIntensityZonesPercentage, core.settings.interfaces.ITrainingZone, core.settings.interfaces.IHeartrateLimits, core.settings.interfaces.IPowerTargetZone, core.settings.interfaces.IGPSStatus, core.settings.interfaces.IGPSFormat, core.settings.interfaces.IOffTrackAlarm, core.settings.interfaces.IWayPointAlarm, core.settings.interfaces.IAutoZoomTrack, core.settings.interfaces.IFavoriteTrip1, core.settings.interfaces.IFavoriteTrip2, core.settings.interfaces.IFavoritesTrack, core.settings.interfaces.IFavoritesAltitude, core.settings.interfaces.IFavoritesLap, core.settings.interfaces.IFavoritesCustom, core.settings.interfaces.IPowerIntensityZone, core.settings.interfaces.IAutoOffTime, core.settings.interfaces.IWheelSize1
    {
        public function SettingsROX100(arg1:flash.events.IEventDispatcher=null)
        {
            _autoOffTime = core.general.AutoOffTimeUnit.FIVE_MINUTES;
            _birthDate = new Date(1983, 0, 1);
            _favoritesAltitude = new __AS3__.vec.Vector.<__AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>>();
            _favoritesLap = new __AS3__.vec.Vector.<__AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>>();
            _favoritesTrack = new __AS3__.vec.Vector.<__AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>>();
            _favoritesTrip1 = new __AS3__.vec.Vector.<String>(10);
            _favoritesTrip2 = new __AS3__.vec.Vector.<String>(10);
            super(arg1);
            favoritesTrack = new __AS3__.vec.Vector.<__AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>>();
            favoritesTrack.splice(0, 2);
            favoritesTrack[0] = new __AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>(3, true);
            favoritesTrack[0][0] = new __AS3__.vec.Vector.<String>(2, true);
            favoritesTrack[0][1] = new __AS3__.vec.Vector.<String>(2, true);
            favoritesTrack[0][2] = new __AS3__.vec.Vector.<String>(2, true);
            favoritesTrack[1] = new __AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>(3, true);
            favoritesTrack[1][0] = new __AS3__.vec.Vector.<String>(2, true);
            favoritesTrack[1][1] = new __AS3__.vec.Vector.<String>(2, true);
            favoritesTrack[1][2] = new __AS3__.vec.Vector.<String>(2, true);
            favoritesAltitude = new __AS3__.vec.Vector.<__AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>>();
            favoritesAltitude.splice(0, 2);
            favoritesAltitude[0] = new __AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>(3, true);
            favoritesAltitude[0][0] = new __AS3__.vec.Vector.<String>(2, true);
            favoritesAltitude[0][1] = new __AS3__.vec.Vector.<String>(2, true);
            favoritesAltitude[0][2] = new __AS3__.vec.Vector.<String>(2, true);
            favoritesAltitude[1] = new __AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>(3, true);
            favoritesAltitude[1][0] = new __AS3__.vec.Vector.<String>(2, true);
            favoritesAltitude[1][1] = new __AS3__.vec.Vector.<String>(2, true);
            favoritesAltitude[1][2] = new __AS3__.vec.Vector.<String>(2, true);
            favoritesLap = new __AS3__.vec.Vector.<__AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>>();
            favoritesLap.splice(0, 2);
            favoritesLap[0] = new __AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>(3, true);
            favoritesLap[0][0] = new __AS3__.vec.Vector.<String>(2, true);
            favoritesLap[0][1] = new __AS3__.vec.Vector.<String>(2, true);
            favoritesLap[0][2] = new __AS3__.vec.Vector.<String>(2, true);
            favoritesLap[1] = new __AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>(3, true);
            favoritesLap[1][0] = new __AS3__.vec.Vector.<String>(2, true);
            favoritesLap[1][1] = new __AS3__.vec.Vector.<String>(2, true);
            favoritesLap[1][2] = new __AS3__.vec.Vector.<String>(2, true);
            _favoritesTrack[0] = new __AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>(3, true);
            _favoritesTrack[0][0] = new __AS3__.vec.Vector.<String>(2, true);
            _favoritesTrack[0][0][0] = "1";
            _favoritesTrack[0][0][1] = "4";
            _favoritesTrack[0][1] = new __AS3__.vec.Vector.<String>(2, true);
            _favoritesTrack[0][1][0] = "54";
            _favoritesTrack[0][1][1] = "55";
            _favoritesTrack[0][2] = new __AS3__.vec.Vector.<String>(2, true);
            _favoritesTrack[0][2][0] = "52";
            _favoritesTrack[0][2][1] = "56";
            _favoritesTrack[1] = new __AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>(3, true);
            _favoritesTrack[1][0] = new __AS3__.vec.Vector.<String>(2, true);
            _favoritesTrack[1][0][0] = "1";
            _favoritesTrack[1][0][1] = "4";
            _favoritesTrack[1][1] = new __AS3__.vec.Vector.<String>(2, true);
            _favoritesTrack[1][1][0] = "10";
            _favoritesTrack[1][1][1] = "21";
            _favoritesTrack[1][2] = new __AS3__.vec.Vector.<String>(2, true);
            _favoritesTrack[1][2][0] = "52";
            _favoritesTrack[1][2][1] = "56";
            _favoritesAltitude[0] = new __AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>(3, true);
            _favoritesAltitude[0][0] = new __AS3__.vec.Vector.<String>(2, true);
            _favoritesAltitude[0][0][0] = "1";
            _favoritesAltitude[0][0][1] = "4";
            _favoritesAltitude[0][1] = new __AS3__.vec.Vector.<String>(2, true);
            _favoritesAltitude[0][1][0] = "32";
            _favoritesAltitude[0][1][1] = "31";
            _favoritesAltitude[0][2] = new __AS3__.vec.Vector.<String>(2, true);
            _favoritesAltitude[0][2][0] = "52";
            _favoritesAltitude[0][2][1] = "36";
            _favoritesAltitude[1] = new __AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>(3, true);
            _favoritesAltitude[1][0] = new __AS3__.vec.Vector.<String>(2, true);
            _favoritesAltitude[1][0][0] = "1";
            _favoritesAltitude[1][0][1] = "4";
            _favoritesAltitude[1][1] = new __AS3__.vec.Vector.<String>(2, true);
            _favoritesAltitude[1][1][0] = "32";
            _favoritesAltitude[1][1][1] = "33";
            _favoritesAltitude[1][2] = new __AS3__.vec.Vector.<String>(2, true);
            _favoritesAltitude[1][2][0] = "52";
            _favoritesAltitude[1][2][1] = "35";
            _favoritesLap[0] = new __AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>(3, true);
            _favoritesLap[0][0] = new __AS3__.vec.Vector.<String>(2, true);
            _favoritesLap[0][0][0] = "2";
            _favoritesLap[0][0][1] = "1";
            _favoritesLap[0][1] = new __AS3__.vec.Vector.<String>(2, true);
            _favoritesLap[0][1][0] = "8";
            _favoritesLap[0][1][1] = "0";
            _favoritesLap[0][2] = new __AS3__.vec.Vector.<String>(2, true);
            _favoritesLap[0][2][0] = "4";
            _favoritesLap[0][2][1] = "6";
            _favoritesLap[1] = new __AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>(3, true);
            _favoritesLap[1][0] = new __AS3__.vec.Vector.<String>(2, true);
            _favoritesLap[1][0][0] = "8";
            _favoritesLap[1][0][1] = "13";
            _favoritesLap[1][1] = new __AS3__.vec.Vector.<String>(2, true);
            _favoritesLap[1][1][0] = "2";
            _favoritesLap[1][1][1] = "0";
            _favoritesLap[1][2] = new __AS3__.vec.Vector.<String>(2, true);
            _favoritesLap[1][2][0] = "4";
            _favoritesLap[1][2][1] = "6";
            _favoritesTrip1[0] = "4";
            _favoritesTrip1[1] = "19";
            _favoritesTrip1[2] = "2";
            _favoritesTrip1[3] = "3";
            _favoritesTrip1[4] = "46";
            _favoritesTrip1[5] = "41";
            _favoritesTrip1[6] = "39";
            _favoritesTrip1[7] = "38";
            _favoritesTrip1[8] = "32";
            _favoritesTrip1[9] = "18";
            _favoritesTrip2[0] = "4";
            _favoritesTrip2[1] = "19";
            _favoritesTrip2[2] = "58";
            _favoritesTrip2[3] = "2";
            _favoritesTrip2[4] = "24";
            _favoritesTrip2[5] = "11";
            _favoritesTrip2[6] = "17";
            _favoritesTrip2[7] = "39";
            _favoritesTrip2[8] = "32";
            _favoritesTrip2[9] = "18";
            _favoritesCustom = new __AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>();
            _favoritesCustom[0] = new __AS3__.vec.Vector.<String>(6, true);
            _favoritesCustom[0][0] = "1";
            _favoritesCustom[0][1] = "4";
            _favoritesCustom[0][2] = "7";
            _favoritesCustom[0][3] = "24";
            _favoritesCustom[0][4] = "10";
            _favoritesCustom[0][5] = "36";
            _favoritesCustom[1] = new __AS3__.vec.Vector.<String>(6, true);
            _favoritesCustom[1][0] = "1";
            _favoritesCustom[1][1] = "4";
            _favoritesCustom[1][2] = "7";
            _favoritesCustom[1][3] = "24";
            _favoritesCustom[1][4] = "10";
            _favoritesCustom[1][5] = "36";
            _customFavoritesPageCount = new __AS3__.vec.Vector.<int>(2, true);
            _customFavoritesPageCount[0] = 6;
            _customFavoritesPageCount[1] = 6;
            return;
        }

        public function get shoulderWidthMin():Number
        {
            if (distanceUnit == "kilometer") 
            {
                return 40;
            }
            return 38;
        }

        public function get altitudeUnit():String
        {
            return _altitudeUnit;
        }

        public function set altitudeUnit(arg1:String):void
        {
            if (arg1 != _altitudeUnit) 
            {
                _altitudeUnit = arg1;
                dispatchEvent(new flash.events.Event("altitudeUnitChange"));
            }
            return;
        }

        public function get shoulderWidthUnit():String
        {
            return _shoulderWidthUnit;
        }

        public function get autoOffTime():core.general.AutoOffTimeUnit
        {
            return _autoOffTime;
        }

        public function set autoOffTime(arg1:core.general.AutoOffTimeUnit):void
        {
            _autoOffTime = arg1;
            return;
        }

        public function set shoulderWidthUnit(arg1:String):void
        {
            if (arg1 != _shoulderWidthUnit) 
            {
                if (_weightUnit) 
                {
                    _shoulderWidthUnit = convertWheightUnitToBodySizeUnit();
                }
                else 
                {
                    _shoulderWidthUnit = arg1;
                }
                dispatchEvent(new flash.events.Event("shoulderWidthUnitChange"));
            }
            return;
        }

        public function get autoPause():Boolean
        {
            return _autoPause;
        }

        public function set autoPause(arg1:Boolean):void
        {
            if (arg1 != _autoPause) 
            {
                _autoPause = arg1;
                dispatchEvent(new flash.events.Event("autoPauseChange"));
            }
            return;
        }

        public function get summerTime():Boolean
        {
            return _summerTime;
        }

        public function get autoZoomTrack():Boolean
        {
            return _autoZoomTrack;
        }

        public function set autoZoomTrack(arg1:Boolean):void
        {
            if (arg1 != _autoZoomTrack) 
            {
                _autoZoomTrack = arg1;
                dispatchEvent(new flash.events.Event("autoZoomTrackChange"));
            }
            return;
        }

        public function set summerTime(arg1:Boolean):void
        {
            if (arg1 != _summerTime) 
            {
                _summerTime = arg1;
                dispatchEvent(new flash.events.Event("summerTimeChange"));
            }
            return;
        }

        public function get backlightTime():Number
        {
            return _backlightTime;
        }

        public function set backlightTime(arg1:Number):void
        {
            if (arg1 != _backlightTime) 
            {
                _backlightTime = arg1;
                dispatchEvent(new flash.events.Event("backlightTimeChange"));
            }
            return;
        }

        public function get systemTone():Boolean
        {
            return _systemTone;
        }

        public function get bikeType1():String
        {
            return _bikeType1;
        }

        public function set bikeType1(arg1:String):void
        {
            if (arg1 != _bikeType1) 
            {
                _bikeType1 = arg1;
                dispatchEvent(new flash.events.Event("bikeType1Change"));
            }
            return;
        }

        public function set systemTone(arg1:Boolean):void
        {
            if (arg1 != _systemTone) 
            {
                _systemTone = arg1;
                dispatchEvent(new flash.events.Event("systemToneChange"));
            }
            return;
        }

        public function get bikeType2():String
        {
            return _bikeType2;
        }

        public function set bikeType2(arg1:String):void
        {
            if (arg1 != _bikeType2) 
            {
                _bikeType2 = arg1;
                dispatchEvent(new flash.events.Event("bikeType2Change"));
            }
            return;
        }

        public function get temperatureUnit():String
        {
            return _temperatureUnit;
        }

        public function get bikeType3():String
        {
            return _bikeType3;
        }

        public function set bikeType3(arg1:String):void
        {
            if (arg1 != _bikeType3) 
            {
                _bikeType3 = arg1;
                dispatchEvent(new flash.events.Event("bikeType3Change"));
            }
            return;
        }

        public function set temperatureUnit(arg1:String):void
        {
            if (arg1 != _temperatureUnit) 
            {
                _temperatureUnit = arg1;
                dispatchEvent(new flash.events.Event("temperatureUnitChange"));
            }
            return;
        }

        public function get bikeWeight1():int
        {
            return _bikeWeight1;
        }

        public function set bikeWeight1(arg1:int):void
        {
            if (arg1 != _bikeWeight1) 
            {
                _bikeWeight1 = arg1;
                dispatchEvent(new flash.events.Event("bikeWeight1Change"));
            }
            return;
        }

        public function get bikeWeight1Max():int
        {
            if (weightUnit == "kg") 
            {
                return 50000;
            }
            return 45359;
        }

        public function get bikeWeight1Min():int
        {
            if (weightUnit == "kg") 
            {
                return 1000;
            }
            return 1361;
        }

        public function get timeZone():int
        {
            return _timeZone;
        }

        public function get bikeWeight2():int
        {
            return _bikeWeight2;
        }

        public function set bikeWeight2(arg1:int):void
        {
            if (arg1 != _bikeWeight2) 
            {
                _bikeWeight2 = arg1;
                dispatchEvent(new flash.events.Event("bikeWeight2Change"));
            }
            return;
        }

        public function get bikeWeight2Max():int
        {
            return bikeWeight1Max;
        }

        public function get bikeWeight2Min():int
        {
            return bikeWeight1Min;
        }

        public function set timeZone(arg1:int):void
        {
            if (arg1 != _timeZone) 
            {
                _timeZone = arg1;
                dispatchEvent(new flash.events.Event("timeZoneChange"));
            }
            return;
        }

        public function get bikeWeight3():Number
        {
            return _bikeWeight3;
        }

        public function set bikeWeight3(arg1:Number):void
        {
            if (arg1 != _bikeWeight3) 
            {
                _bikeWeight3 = arg1;
                dispatchEvent(new flash.events.Event("bikeWeight3Change"));
            }
            return;
        }

        public function get bikeWeight3Max():int
        {
            return bikeWeight1Max;
        }

        public function get bikeWeight3Min():int
        {
            return bikeWeight1Min;
        }

        public function get trainingZone():String
        {
            return _trainingZone;
        }

        public function get birthDate():Date
        {
            return _birthDate;
        }

        public function set birthDate(arg1:Date):void
        {
            if (arg1 != _birthDate) 
            {
                _birthDate = arg1;
                dispatchEvent(new flash.events.Event("birthDateChange"));
            }
            return;
        }

        public function get birthDateMax():Number
        {
            return new Date(NOW.fullYear - 6, NOW.month, NOW.date).time;
        }

        public function get birthDateMin():Number
        {
            return new Date(1900, 0, 1).time;
        }

        public function set trainingZone(arg1:String):void
        {
            if (arg1 != _trainingZone) 
            {
                _trainingZone = arg1;
                dispatchEvent(new flash.events.Event("trainingZoneChange"));
            }
            return;
        }

        public function get bodyHeight():Number
        {
            return _bodyHeight;
        }

        public function set bodyHeight(arg1:Number):void
        {
            if (arg1 != _bodyHeight) 
            {
                _bodyHeight = arg1;
                dispatchEvent(new flash.events.Event("bodyHeightChange"));
            }
            return;
        }

        public function get bodyHeightMax():Number
        {
            if (bodyWeightUnit == "kg") 
            {
                return 250;
            }
            return 254;
        }

        public function get bodyHeightMin():Number
        {
            if (bodyWeightUnit == "kg") 
            {
                return 100;
            }
            return 102;
        }

        public function get upperLimit():int
        {
            return _upperLimit;
        }

        public function get bodyHeightUnit():String
        {
            return _bodyHeightUnit;
        }

        public function set bodyHeightUnit(arg1:String):void
        {
            if (arg1 != _bodyHeightUnit) 
            {
                if (_weightUnit) 
                {
                    _bodyHeightUnit = convertWheightUnitToBodySizeUnit();
                }
                else 
                {
                    _bodyHeightUnit = arg1;
                }
                dispatchEvent(new flash.events.Event("bodyHeightUnitChange"));
            }
            return;
        }

        public function get bodyWeight():int
        {
            return _weight;
        }

        public function set bodyWeight(arg1:int):void
        {
            if (arg1 != _weight) 
            {
                _weight = arg1;
                dispatchEvent(new flash.events.Event("weightChange"));
            }
            return;
        }

        public function get bodyWeightMax():int
        {
            if (bodyWeightUnit == "kg") 
            {
                return 200000;
            }
            return 181437;
        }

        public function get bodyWeightMin():int
        {
            if (bodyWeightUnit == "kg") 
            {
                return 20000;
            }
            return 18144;
        }

        public function get bodyWeightUnit():String
        {
            return weightUnit;
        }

        public function set bodyWeightUnit(arg1:String):void
        {
            weightUnit = arg1;
            return;
        }

        public function set upperLimit(arg1:int):void
        {
            if (arg1 != _upperLimit) 
            {
                _upperLimit = arg1;
                dispatchEvent(new flash.events.Event("upperLimitChange"));
            }
            return;
        }

        public function get buttonTone():Boolean
        {
            return _buttonTone;
        }

        public function set buttonTone(arg1:Boolean):void
        {
            if (arg1 != _buttonTone) 
            {
                _buttonTone = arg1;
                dispatchEvent(new flash.events.Event("buttonToneChange"));
            }
            return;
        }

        public function get upperLimitMax():int
        {
            return 240;
        }

        public function get clockMode():String
        {
            return _clockMode;
        }

        public function set clockMode(arg1:String):void
        {
            if (arg1 != _clockMode) 
            {
                _clockMode = arg1;
                dispatchEvent(new flash.events.Event("clockModeChange"));
            }
            return;
        }

        public function get upperLimitMin():int
        {
            return lowerLimit + 5;
        }

        public function get contrast():int
        {
            return _contrast;
        }

        public function set contrast(arg1:int):void
        {
            if (arg1 != _contrast) 
            {
                _contrast = arg1;
                dispatchEvent(new flash.events.Event("contrastChange"));
            }
            return;
        }

        public function get contrastMax():int
        {
            return 4;
        }

        public function get contrastMin():int
        {
            return 1;
        }

        public function get waypointAlarm():Number
        {
            return _waypointAlarm;
        }

        public function get countdown():Number
        {
            return _countdown;
        }

        public function set countdown(arg1:Number):void
        {
            if (arg1 != _countdown) 
            {
                _countdown = arg1;
                dispatchEvent(new flash.events.Event("countdownChange"));
            }
            return;
        }

        public function get countdownMax():Number
        {
            return 3599999;
        }

        public function get countdownMin():Number
        {
            return 0;
        }

        public function set waypointAlarm(arg1:Number):void
        {
            if (arg1 != _waypointAlarm) 
            {
                _waypointAlarm = arg1;
                dispatchEvent(new flash.events.Event("waypointAlarmChange"));
            }
            return;
        }

        public function get countdownOn():Boolean
        {
            return _countdownOn;
        }

        public function set countdownOn(arg1:Boolean):void
        {
            if (arg1 != _countdownOn) 
            {
                _countdownOn = arg1;
                dispatchEvent(new flash.events.Event("countdownOnChange"));
            }
            return;
        }

        public function get weightUnit():String
        {
            return _weightUnit;
        }

        public function get dateFormat():String
        {
            return _dateFormat;
        }

        public function set dateFormat(arg1:String):void
        {
            if (arg1 != _dateFormat) 
            {
                _dateFormat = arg1;
                dispatchEvent(new flash.events.Event("dateFormatChange"));
            }
            return;
        }

        public function set weightUnit(arg1:String):void
        {
            if (arg1 != _weightUnit) 
            {
                _weightUnit = arg1;
                shoulderWidthUnit = "..will be calced";
                bodyHeightUnit = "..will be calced, too";
                dispatchEvent(new flash.events.Event("weightUnitChange"));
            }
            return;
        }

        public function get distanceUnit():String
        {
            return _distanceUnit;
        }

        public function set distanceUnit(arg1:String):void
        {
            if (arg1 != _distanceUnit) 
            {
                _distanceUnit = arg1;
                dispatchEvent(new flash.events.Event("distanceUnitChange"));
            }
            return;
        }

        public function get wheelSize1():int
        {
            return _wheelSize1;
        }

        public final function get favoritesAltitude():__AS3__.vec.Vector.<__AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>>
        {
            return _favoritesAltitude;
        }

        public final function set favoritesAltitude(arg1:__AS3__.vec.Vector.<__AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>>):void
        {
            if (_favoritesAltitude !== arg1) 
            {
                _favoritesAltitude = arg1;
                dispatchEvent(new flash.events.Event("favoritesAltitudeChange"));
            }
            return;
        }

        public function set wheelSize1(arg1:int):void
        {
            if (_wheelSize1 !== arg1) 
            {
                _wheelSize1 = arg1;
                dispatchEvent(new flash.events.Event("wheelSize1Change"));
            }
            return;
        }

        public function get favoritesCustom():__AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>
        {
            return _favoritesCustom;
        }

        public function set favoritesCustom(arg1:__AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>):void
        {
            _favoritesCustom = arg1;
            return;
        }

        public function get favoritesCustomPageCount():__AS3__.vec.Vector.<int>
        {
            return _customFavoritesPageCount;
        }

        public function set favoritesCustomPageCount(arg1:__AS3__.vec.Vector.<int>):void
        {
            _customFavoritesPageCount = arg1;
            return;
        }

        public function get wheelSize1Max():int
        {
            return 3999;
        }

        public final function get favoritesLap():__AS3__.vec.Vector.<__AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>>
        {
            return _favoritesLap;
        }

        public final function set favoritesLap(arg1:__AS3__.vec.Vector.<__AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>>):void
        {
            if (_favoritesLap !== arg1) 
            {
                _favoritesLap = arg1;
                dispatchEvent(new flash.events.Event("favoritesLapChange"));
            }
            return;
        }

        public function get wheelSize1Min():int
        {
            return 500;
        }

        public function get wheelSize2():int
        {
            return _wheelSize2;
        }

        public final function get favoritesTrack():__AS3__.vec.Vector.<__AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>>
        {
            return _favoritesTrack;
        }

        public final function set favoritesTrack(arg1:__AS3__.vec.Vector.<__AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>>):void
        {
            if (_favoritesTrack !== arg1) 
            {
                _favoritesTrack = arg1;
                dispatchEvent(new flash.events.Event("favoritesTrackChange"));
            }
            return;
        }

        public function set wheelSize2(arg1:int):void
        {
            if (arg1 != _wheelSize2) 
            {
                _wheelSize2 = arg1;
                dispatchEvent(new flash.events.Event("wheelSize2Change"));
            }
            return;
        }

        public final function get favoritesTrip1():__AS3__.vec.Vector.<String>
        {
            return _favoritesTrip1;
        }

        public final function set favoritesTrip1(arg1:__AS3__.vec.Vector.<String>):void
        {
            if (_favoritesTrip1 !== arg1) 
            {
                _favoritesTrip1 = arg1;
                dispatchEvent(new flash.events.Event("favoritesTrip1Change"));
            }
            return;
        }

        public function get favoritesTrip1Size():int
        {
            return 10;
        }

        public function get wheelSize2Max():int
        {
            return 3999;
        }

        public final function get favoritesTrip2():__AS3__.vec.Vector.<String>
        {
            return _favoritesTrip2;
        }

        public final function set favoritesTrip2(arg1:__AS3__.vec.Vector.<String>):void
        {
            if (_favoritesTrip2 !== arg1) 
            {
                _favoritesTrip2 = arg1;
                dispatchEvent(new flash.events.Event("favorites2Change"));
            }
            return;
        }

        public function get favoritesTrip2Size():int
        {
            return 10;
        }

        public function get wheelSize2Min():int
        {
            return 500;
        }

        public function get gender():String
        {
            return _gender;
        }

        public function set gender(arg1:String):void
        {
            if (arg1 != _gender) 
            {
                _gender = arg1;
                dispatchEvent(new flash.events.Event("genderChange"));
            }
            return;
        }

        public function get wheelSize3():int
        {
            return _wheelSize3;
        }

        public function get gpsFormat():String
        {
            return _gpsFormat;
        }

        public function set gpsFormat(arg1:String):void
        {
            if (arg1 != _gpsFormat) 
            {
                _gpsFormat = arg1;
                dispatchEvent(new flash.events.Event("gpsFormatChange"));
            }
            return;
        }

        public function set wheelSize3(arg1:int):void
        {
            if (arg1 != _wheelSize3) 
            {
                _wheelSize3 = arg1;
                dispatchEvent(new flash.events.Event("wheelSize3Change"));
            }
            return;
        }

        public function get gpsStatus():Boolean
        {
            return _gpsStatus;
        }

        public function set gpsStatus(arg1:Boolean):void
        {
            if (arg1 != _gpsStatus) 
            {
                _gpsStatus = arg1;
                dispatchEvent(new flash.events.Event("gpsStatusChange"));
            }
            return;
        }

        public function get wheelSize3Max():int
        {
            return 3999;
        }

        public function get homeAltitude1():int
        {
            return _homeAltitude1;
        }

        public function set homeAltitude1(arg1:int):void
        {
            if (arg1 != _homeAltitude1) 
            {
                _homeAltitude1 = arg1;
                dispatchEvent(new flash.events.Event("homeAltitude1Change"));
            }
            return;
        }

        public function get homeAltitude1Max():int
        {
            if (core.MeasurementConfig.altitudeFormat == "meter") 
            {
                return 4999000;
            }
            return 5181295;
        }

        public function get homeAltitude1Min():int
        {
            if (core.MeasurementConfig.altitudeFormat == "meter") 
            {
                return -9990000;
            }
            return -304495;
        }

        public function get wheelSize3Min():int
        {
            return 500;
        }

        public function get homeAltitude2():int
        {
            return _homeAltitude2;
        }

        public function set homeAltitude2(arg1:int):void
        {
            if (arg1 != _homeAltitude2) 
            {
                _homeAltitude2 = arg1;
                dispatchEvent(new flash.events.Event("homeAltitude2Change"));
            }
            return;
        }

        public function get homeAltitude2Max():int
        {
            return homeAltitude1Max;
        }

        public function get homeAltitude2Min():int
        {
            return homeAltitude1Min;
        }

        public function get zoneAlarm():Boolean
        {
            return _zoneAlarm;
        }

        public function get homeAltitude3():int
        {
            return _homeAltitude3;
        }

        public function set homeAltitude3(arg1:int):void
        {
            if (arg1 != _homeAltitude3) 
            {
                _homeAltitude3 = arg1;
                dispatchEvent(new flash.events.Event("homeAltitude3Change"));
            }
            return;
        }

        public function get homeAltitude3Max():int
        {
            return homeAltitude1Max;
        }

        public function get homeAltitude3Min():int
        {
            return homeAltitude1Min;
        }

        public function set zoneAlarm(arg1:Boolean):void
        {
            if (arg1 != _zoneAlarm) 
            {
                _zoneAlarm = arg1;
                dispatchEvent(new flash.events.Event("zoneAlarmChange"));
            }
            return;
        }

        public function get hrMax():int
        {
            return _hrMax;
        }

        public function set hrMax(arg1:int):void
        {
            if (arg1 != _hrMax) 
            {
                _hrMax = arg1;
                dispatchEvent(new flash.events.Event("hrMaxChange"));
            }
            return;
        }

        public function get hrMaxMax():int
        {
            return 240;
        }

        public function get hrMaxMin():int
        {
            return 100;
        }

        public function get intensityZone1PercentageStart():Number
        {
            return _intensityZone1;
        }

        public function set intensityZone1PercentageStart(arg1:Number):void
        {
            if (arg1 != _intensityZone1) 
            {
                _intensityZone1 = arg1;
                dispatchEvent(new flash.events.Event("intensityZone1PercentageStartChange"));
            }
            return;
        }

        public function get intensityZone2PercentageStart():Number
        {
            return _intensityZone2;
        }

        public function set intensityZone2PercentageStart(arg1:Number):void
        {
            if (arg1 != _intensityZone2) 
            {
                _intensityZone2 = arg1;
                dispatchEvent(new flash.events.Event("intensityZone2PercentageStartChange"));
            }
            return;
        }

        public function get intensityZone3PercentageStart():Number
        {
            return _intensityZone3;
        }

        public function set intensityZone3PercentageStart(arg1:Number):void
        {
            if (arg1 != _intensityZone3) 
            {
                _intensityZone3 = arg1;
                dispatchEvent(new flash.events.Event("intensityZone3PercentageStartChange"));
            }
            return;
        }

        public function get intensityZone4PercentageEnd():Number
        {
            return _intensityZone4End;
        }

        public function set intensityZone4PercentageEnd(arg1:Number):void
        {
            if (arg1 != _intensityZone4End) 
            {
                _intensityZone4End = arg1;
                dispatchEvent(new flash.events.Event("intensityZone4PercentageEndChange"));
            }
            return;
        }

        public function get intensityZone4PercentageStart():Number
        {
            return _intensityZone4;
        }

        public function set intensityZone4PercentageStart(arg1:Number):void
        {
            if (arg1 != _intensityZone4) 
            {
                _intensityZone4 = arg1;
                dispatchEvent(new flash.events.Event("intensityZone4PercentageStartChange"));
            }
            return;
        }

        public function get intensityZonePercentageMin():Number
        {
            return 20;
        }

        public override function getLoggingInfo():String
        {
            return super.getLoggingInfo() + "\t-settingsROX100Id " + settingsROX100Id;
        }

        public function get language():String
        {
            return _language;
        }

        public function set language(arg1:String):void
        {
            if (arg1 != _language) 
            {
                _language = arg1;
                dispatchEvent(new flash.events.Event("languageChange"));
            }
            return;
        }

        public override function toString():String
        {
            return "[SettingsROX100 extends SettingsBikeComputer]";
        }

        public function get lowerLimit():int
        {
            return _lowerLimit;
        }

        public function set lowerLimit(arg1:int):void
        {
            if (arg1 != _lowerLimit) 
            {
                _lowerLimit = arg1;
                dispatchEvent(new flash.events.Event("lowerLimitChange"));
            }
            return;
        }

        public function get lowerLimitMax():int
        {
            return upperLimit - 5;
        }

        public function get lowerLimitMin():int
        {
            return 30;
        }

        internal function convertWheightUnitToBodySizeUnit():String
        {
            if (_weightUnit == "lb") 
            {
                return "inch";
            }
            return "centimeter";
        }

        public function get myName():String
        {
            return _myName;
        }

        public function set myName(arg1:String):void
        {
            if (arg1 != _myName) 
            {
                _myName = arg1;
                dispatchEvent(new flash.events.Event("myNameChange"));
            }
            return;
        }

        public function get myNameMaxLength():uint
        {
            return 12;
        }

        public function get offTrackAlarm():Number
        {
            return _offTrackAlarm;
        }

        public function set offTrackAlarm(arg1:Number):void
        {
            if (arg1 != _offTrackAlarm) 
            {
                _offTrackAlarm = arg1;
                dispatchEvent(new flash.events.Event("offTrackAlarmChange"));
            }
            return;
        }

        public function get powerIntensityZone1Start():int
        {
            return _powerZone1Start;
        }

        public function set powerIntensityZone1Start(arg1:int):void
        {
            _powerZone1Start = arg1;
            return;
        }

        public function get powerIntensityZone2Start():int
        {
            return _powerZone2Start;
        }

        public function set powerIntensityZone2Start(arg1:int):void
        {
            _powerZone2Start = arg1;
            return;
        }

        public function get powerIntensityZone3Start():int
        {
            return _powerZone3Start;
        }

        public function set powerIntensityZone3Start(arg1:int):void
        {
            _powerZone3Start = arg1;
            return;
        }

        public function get powerIntensityZone4Start():int
        {
            return _powerZone4Start;
        }

        public function set powerIntensityZone4Start(arg1:int):void
        {
            _powerZone4Start = arg1;
            return;
        }

        public function get powerIntensityZone5Start():int
        {
            return _powerZone5Start;
        }

        public function set powerIntensityZone5Start(arg1:int):void
        {
            _powerZone5Start = arg1;
            return;
        }

        public function get powerIntensityZone6Start():int
        {
            return _powerZone6Start;
        }

        public function set powerIntensityZone6Start(arg1:int):void
        {
            _powerZone6Start = arg1;
            return;
        }

        public function get powerIntensityZone7End():int
        {
            return _powerZone7End;
        }

        public function set powerIntensityZone7End(arg1:int):void
        {
            _powerZone7End = arg1;
            return;
        }

        public function get powerIntensityZone7Start():int
        {
            return _powerZone7Start;
        }

        public function set powerIntensityZone7Start(arg1:int):void
        {
            _powerZone7Start = arg1;
            return;
        }

        public function get powerMeterFormula():int
        {
            return _powerMeterFormula;
        }

        public function set powerMeterFormula(arg1:int):void
        {
            if (_powerMeterFormula !== arg1) 
            {
                _powerMeterFormula = arg1;
                dispatchEvent(new flash.events.Event("powerMeterFormulaChange"));
            }
            return;
        }

        public function get powerTargetZoneEnabled():Boolean
        {
            return _powerTargetZoneEnabled;
        }

        public function set powerTargetZoneEnabled(arg1:Boolean):void
        {
            if (arg1 != _powerTargetZoneEnabled) 
            {
                _powerTargetZoneEnabled = arg1;
                dispatchEvent(new flash.events.Event("powerTargetZoneEnabledChange"));
            }
            return;
        }

        public function get powerTargetZoneLowerLimit():int
        {
            return _powerTargetZoneLowerLimit;
        }

        public function set powerTargetZoneLowerLimit(arg1:int):void
        {
            if (arg1 != _powerTargetZoneLowerLimit) 
            {
                _powerTargetZoneLowerLimit = arg1;
                dispatchEvent(new flash.events.Event("powerTargetZoneLowerLimitChange"));
            }
            return;
        }

        public function get powerTargetZoneLowerLimitMax():int
        {
            return (2000 - 1);
        }

        public function get powerTargetZoneLowerLimitMin():int
        {
            return 0;
        }

        public function get powerTargetZoneUpperLimit():int
        {
            return _powerTargetZoneUpperLimit;
        }

        public function set powerTargetZoneUpperLimit(arg1:int):void
        {
            if (arg1 != _powerTargetZoneUpperLimit) 
            {
                _powerTargetZoneUpperLimit = arg1;
                dispatchEvent(new flash.events.Event("powerTargetZoneUpperLimitChange"));
            }
            return;
        }

        public function get powerTargetZoneUpperLimitMax():int
        {
            return 2000;
        }

        public function get powerTargetZoneUpperLimitMin():int
        {
            return 0 + 1;
        }

        public function get samplingRate():Number
        {
            return _samplingRate;
        }

        public function set samplingRate(arg1:Number):void
        {
            if (arg1 != _samplingRate) 
            {
                _samplingRate = arg1;
                dispatchEvent(new flash.events.Event("samplingRateChange"));
            }
            return;
        }

        public function get seaLevel():Number
        {
            return _seaLevel;
        }

        public function set seaLevel(arg1:Number):void
        {
            if (arg1 != _seaLevel) 
            {
                _seaLevel = arg1;
                dispatchEvent(new flash.events.Event("seaLevelChange"));
            }
            return;
        }

        public function get seaLevelMax():Number
        {
            return 1050;
        }

        public function get seaLevelMin():Number
        {
            return 900;
        }

        public function get settingsROX100Id():int
        {
            return _settingsROX100Id;
        }

        public function set settingsROX100Id(arg1:int):void
        {
            _settingsROX100Id = arg1;
            return;
        }

        public function get shoulderWidth():Number
        {
            return _shoulderWidth;
        }

        public function set shoulderWidth(arg1:Number):void
        {
            if (arg1 != _shoulderWidth) 
            {
                _shoulderWidth = arg1;
                dispatchEvent(new flash.events.Event("shoulderWidthChange"));
            }
            return;
        }

        public function get shoulderWidthMax():Number
        {
            if (distanceUnit == "kilometer") 
            {
                return 80;
            }
            return 76;
        }

        public static const WEIGHTBIKE_KG_MIN_IN_G:int=1000;

        internal static const WHEEL_SBIKE3_MIN:int=500;

        internal const _myNameMaxLength:uint=12;

        public static const CONTRAST_MAX:int=4;

        public static const CONTRAST_MIN:int=1;

        public static const HOME_ALTITUDE_FT_MAX_IN_MM:int=5181295;

        public static const HOME_ALTITUDE_FT_MIN_IN_MM:int=-304495;

        public static const HOME_ALTITUDE_M_MAX_IN_MM:int=4999000;

        public static const HOME_ALTITUDE_M_MIN_IN_MM:int=-9990000;

        public static const MAXHEARTRATE_MAX:int=240;

        public static const MAXHEARTRATE_MIN:int=100;

        public static const POWER_TARGET_ZONE_MAX:int=2000;

        public static const POWER_TARGET_ZONE_MIN:int=0;

        public static const SEA_LEVEL_MAX:int=1050;

        public static const SEA_LEVEL_MIN:int=900;

        public static const SHOULDERWIDTH_CM_MAX:int=80;

        public static const SHOULDERWIDTH_CM_MIN:int=40;

        public static const SHOULDERWIDTH_INCH_MAX_IN_CM:int=76;

        public static const SHOULDERWIDTH_INCH_MIN_IN_CM:int=38;

        public static const USERSIZE_CM_MAX:int=250;

        public static const USERSIZE_CM_MIN:int=100;

        public static const USERSIZE_INCH_MAX_IN_CM:int=254;

        public static const USERSIZE_INCH_MIN_IN_CM:int=102;

        public static const WEIGHTBIKE_KG_MAX_IN_G:int=50000;

        public static const WEIGHTBIKE_LB_MAX_IN_G:int=45359;

        public static const WEIGHTBIKE_LB_MIN_IN_G:int=1361;

        public static const WEIGHT_KG_MAX_IN_G:int=200000;

        public static const WEIGHT_KG_MIN_IN_G:int=20000;

        public static const WEIGHT_LB_MAX_IN_G:int=181437;

        public static const WEIGHT_LB_MIN_IN_G:int=18144;

        public static const WHEEL_SBIKE1_MAX:int=3999;

        public static const WHEEL_SBIKE1_MIN:int=500;

        internal static const FAVORIT_TRIP_SIZE:int=10;

        internal static const NOW:Date=new Date();

        internal static const WHEEL_SBIKE2_MAX:int=3999;

        internal static const WHEEL_SBIKE2_MIN:int=500;

        internal static const WHEEL_SBIKE3_MAX:int=3999;

        internal var _myName:String="ROX 10.0";

        internal var _shoulderWidth:Number=44;

        internal var _temperatureUnit:String="";

        internal var _wheelSize1:int=2155;

        internal var _powerTargetZoneUpperLimit:int=250;

        internal var _seaLevel:Number=1013;

        internal var _timeZone:int=0;

        internal var _powerTargetZoneLowerLimit:int=150;

        internal var _wheelSize2:int=2155;

        internal var _offTrackAlarm:Number=2;

        internal var _trainingZone:String="fitZone";

        internal var _shoulderWidthUnit:String="centimeter";

        internal var _powerTargetZoneEnabled:Boolean=false;

        internal var _wheelSize3:int=2155;

        internal var _upperLimit:int=152;

        internal var _powerMeterFormula:int=1;

        internal var _summerTime:Boolean=false;

        internal var _settingsROX100Id:int;

        internal var _zoneAlarm:Boolean=true;

        internal var _buttonTone:Boolean=true;

        internal var _waypointAlarm:Number=2;

        internal var _customFavoritesPageCount:__AS3__.vec.Vector.<int>;

        internal var _intensityZone1:Number=60;

        internal var _intensityZone2:Number=70;

        internal var _intensityZone3:Number=80;

        internal var _intensityZone4:Number=90;

        internal var _intensityZone4End:Number=100;

        internal var _powerZone1Start:int=0;

        internal var _powerZone2Start:int=141;

        internal var _powerZone3Start:int=191;

        internal var _powerZone4Start:int=231;

        internal var _powerZone5Start:int=261;

        internal var _powerZone6Start:int=301;

        internal var _powerZone7End:int=2000;

        internal var _powerZone7Start:int=367;

        internal var _altitudeUnit:String="meter";

        internal var _systemTone:Boolean=false;

        internal var _autoOffTime:core.general.AutoOffTimeUnit;

        internal var _weightUnit:String="kg";

        internal var _autoPause:Boolean=true;

        internal var _autoZoomTrack:Boolean=false;

        internal var _backlightTime:Number=1;

        internal var _bikeType1:String="raceDrop";

        internal var _bikeType2:String="raceDrop";

        internal var _bikeType3:String="raceDrop";

        internal var _bikeWeight1:int=8000;

        internal var _bikeWeight2:int=8000;

        internal var _bikeWeight3:Number=8000;

        internal var _birthDate:Date;

        internal var _bodyHeight:Number=180;

        internal var _bodyHeightUnit:String="centimeter";

        internal var _clockMode:String="24";

        internal var _contrast:int=2;

        internal var _countdown:Number=0;

        internal var _countdownOn:Boolean=false;

        internal var _dateFormat:String="eu";

        internal var _distanceUnit:String="kilometer";

        internal var _favoritesAltitude:__AS3__.vec.Vector.<__AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>>;

        internal var _favoritesCustom:__AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>;

        internal var _favoritesLap:__AS3__.vec.Vector.<__AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>>;

        internal var _samplingRate:Number=0;

        public var favoritesSelected:int=0;

        internal var _favoritesTrack:__AS3__.vec.Vector.<__AS3__.vec.Vector.<__AS3__.vec.Vector.<String>>>;

        internal var _favoritesTrip1:__AS3__.vec.Vector.<String>;

        internal var _favoritesTrip2:__AS3__.vec.Vector.<String>;

        internal var _gender:String="male";

        internal var _gpsFormat:String="0";

        internal var _gpsStatus:Boolean=true;

        internal var _homeAltitude1:int=100;

        internal var _homeAltitude2:int=200;

        internal var _homeAltitude3:int=300;

        internal var _hrMax:int=191;

        internal var _language:String="en";

        internal var _lowerLimit:int=133;

        internal var _weight:int=70000;
    }
}


//  class SettingsROX110
package core.settings 
{
    import core.settings.interfaces.*;
    import flash.events.*;
    
    public class SettingsROX110 extends core.settings.SettingsROX70 implements core.settings.interfaces.ISamplingRate, core.settings.interfaces.IWeightUnit, core.settings.interfaces.IYearOfBirth, core.settings.interfaces.IBodyWeight, core.settings.interfaces.IBodyHeight, core.settings.interfaces.IShoulderWidth, core.settings.interfaces.IHRmax, core.settings.interfaces.IStravaSegmentsEnabled
    {
        public function SettingsROX110(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            timeZone = 8;
            contrast = 3;
            myName = "ROX GPS 11.0";
            return;
        }

        public function set yearOfBirth(arg1:int):void
        {
            if (arg1 != _yearOfBirth) 
            {
                _yearOfBirth = arg1;
                dispatchEvent(new flash.events.Event("yearOfBirthChange"));
            }
            return;
        }

        public function get bodyHeight():Number
        {
            return _bodyHeight;
        }

        public function set bodyHeight(arg1:Number):void
        {
            if (arg1 != _bodyHeight) 
            {
                _bodyHeight = arg1;
                dispatchEvent(new flash.events.Event("bodyHeightChange"));
            }
            return;
        }

        public function get bodyHeightMax():Number
        {
            if (weightUnit == "kg") 
            {
                return 250;
            }
            return 254;
        }

        public function get bodyHeightMin():Number
        {
            if (weightUnit == "kg") 
            {
                return 100;
            }
            return 102;
        }

        public function get bodyWeight():int
        {
            return _weight;
        }

        public function set bodyWeight(arg1:int):void
        {
            if (arg1 != _weight) 
            {
                _weight = arg1;
                dispatchEvent(new flash.events.Event("weightChange"));
            }
            return;
        }

        public function get bodyWeightMax():int
        {
            if (weightUnit == "kg") 
            {
                return 200000;
            }
            return 181437;
        }

        public function get bodyWeightMin():int
        {
            if (weightUnit == "kg") 
            {
                return 20000;
            }
            return 18144;
        }

        public override function toString():String
        {
            return "[SettingsROX110 extends SettingsBikeComputer]";
        }

        public function get hrMax():int
        {
            return _hrMax;
        }

        public function set hrMax(arg1:int):void
        {
            if (arg1 != _hrMax) 
            {
                _hrMax = arg1;
                dispatchEvent(new flash.events.Event("hrMaxChange"));
            }
            return;
        }

        public function get hrMaxMax():int
        {
            return 240;
        }

        public function get hrMaxMin():int
        {
            return 100;
        }

        public override function getLoggingInfo():String
        {
            return super.getLoggingInfo() + "\t-settingsROX100Id " + settingsROX70Id;
        }

        public function get samplingRate():Number
        {
            return _samplingRate;
        }

        public function set samplingRate(arg1:Number):void
        {
            if (arg1 != _samplingRate) 
            {
                _samplingRate = arg1;
            }
            return;
        }

        public function get yearOfBirthMin():int
        {
            return 1900;
        }

        public function get shoulderWidth():Number
        {
            return _shoulderWidth;
        }

        public function set shoulderWidth(arg1:Number):void
        {
            if (arg1 != _shoulderWidth) 
            {
                _shoulderWidth = arg1;
                dispatchEvent(new flash.events.Event("shoulderWidthChange"));
            }
            return;
        }

        public function get shoulderWidthMax():Number
        {
            if (distanceUnit == "kilometer") 
            {
                return 80;
            }
            return 76;
        }

        public function get shoulderWidthMin():Number
        {
            if (distanceUnit == "kilometer") 
            {
                return 40;
            }
            return 38;
        }

        public function get yearOfBirth():int
        {
            return _yearOfBirth;
        }

        public function get stravaSegmentsEnabled():Boolean
        {
            return _stravaSegmentsEnabled;
        }

        public function set stravaSegmentsEnabled(arg1:Boolean):void
        {
            _stravaSegmentsEnabled = arg1;
            return;
        }

        public function get yearOfBirthMax():int
        {
            return YEAR_OF_BIRTH_MAX;
        }

        public function get weightUnit():String
        {
            return _weightUnit;
        }

        public function set weightUnit(arg1:String):void
        {
            if (arg1 != _weightUnit) 
            {
                _weightUnit = arg1;
                dispatchEvent(new flash.events.Event("weightUnitChange"));
            }
            return;
        }

        internal static const NOW:Date=new Date();

        public static const CONTRAST_MAX:int=10;

        public static const CONTRAST_MIN:int=1;

        public static const HOME_ALTITUDE_FT_MAX_IN_MM:int=5181295;

        public static const HOME_ALTITUDE_FT_MIN_IN_MM:int=-304495;

        public static const HOME_ALTITUDE_M_MAX_IN_MM:int=4999000;

        public static const HOME_ALTITUDE_M_MIN_IN_MM:int=-9990000;

        public static const MAXHEARTRATE_MAX:int=240;

        public static const MAXHEARTRATE_MIN:int=100;

        public static const SHOULDERWIDTH_CM_MAX:int=80;

        public static const SHOULDERWIDTH_CM_MIN:int=40;

        public static const SHOULDERWIDTH_INCH_MAX_IN_CM:int=76;

        public static const SHOULDERWIDTH_INCH_MIN_IN_CM:int=38;

        public static const USERSIZE_CM_MAX:int=250;

        public static const USERSIZE_CM_MIN:int=100;

        public static const USERSIZE_INCH_MAX_IN_CM:int=254;

        public static const USERSIZE_INCH_MIN_IN_CM:int=102;

        public static const WEIGHT_KG_MAX_IN_G:int=200000;

        public static const WEIGHT_KG_MIN_IN_G:int=20000;

        public static const WEIGHT_LB_MAX_IN_G:int=181437;

        public static const WEIGHT_LB_MIN_IN_G:int=18144;

        public static const YEAR_OF_BIRTH_MAX:int=new Date().fullYear - 6;

        public static const YEAR_OF_BIRTH_MIN:int=1900;

        internal var _bodyHeight:Number=180;

        internal var _weightUnit:String="kg";

        internal var _shoulderWidth:Number=44;

        internal var _weight:int=70000;

        internal var _samplingRate:Number=5;

        internal var _hrMax:int=191;

        internal var _stravaSegmentsEnabled:Boolean=true;

        internal var _yearOfBirth:int=1980;
    }
}


//  class SettingsROX2010
package core.settings 
{
    import __AS3__.vec.*;
    import core.*;
    import core.general.*;
    import core.settings.interfaces.*;
    import flash.events.*;
    
    public class SettingsROX2010 extends core.settings.SettingsBikeComputer implements core.settings.interfaces.ILanguage, core.settings.interfaces.IThreeZones, core.settings.interfaces.IWheelSize2, core.settings.interfaces.IBodyWeight, core.settings.interfaces.IGender, core.settings.interfaces.IDate, core.settings.interfaces.IFavoriteTrip1, core.settings.interfaces.IFavoriteTrip2, core.settings.interfaces.IBirthDate, core.settings.interfaces.IClockMode, core.settings.interfaces.IHomeAltitude1, core.settings.interfaces.IHomeAltitude2, core.settings.interfaces.IHomeAltitude3, core.settings.interfaces.IHRmax, core.settings.interfaces.IVolume, core.settings.interfaces.IDateFormat, core.settings.interfaces.IZoneAlarm, core.settings.interfaces.IButtonInfo, core.settings.interfaces.IBodyWeightUnit, core.settings.interfaces.IMyName, core.settings.interfaces.IShowTotals, core.settings.interfaces.ILowBatDetectLevel, core.settings.interfaces.IBikeType1, core.settings.interfaces.IBikeType2, core.settings.interfaces.IBikeWeight1, core.settings.interfaces.IBikeWeight2, core.settings.interfaces.IBikeWeight1Unit, core.settings.interfaces.IBikeWeight2Unit, core.settings.interfaces.IShoulderWidth, core.settings.interfaces.IShoulderWidthUnit, core.settings.interfaces.IGhostFunction, core.settings.interfaces.IBodyHeight, core.settings.interfaces.IBodyHeightUnit, core.settings.interfaces.IContrast, core.settings.interfaces.IWheelSize1
    {
        public function SettingsROX2010(arg1:flash.events.IEventDispatcher=null, arg2:core.general.UnitType=null)
        {
            _birthDate = new Date(1983, 0, 1);
            _favoritesTrip1 = new __AS3__.vec.Vector.<String>();
            _favoritesTrip2 = new __AS3__.vec.Vector.<String>();
            super(arg1);
            wheelSize1 = 2155;
            speedUnit = "kmh";
            _favoritesTrip1 = new __AS3__.vec.Vector.<String>(10);
            _favoritesTrip2 = new __AS3__.vec.Vector.<String>(10);
            if (core.general.UnitType.ROX91 != arg2) 
            {
                if (core.general.UnitType.ROX81 == arg2) 
                {
                    _myName = " ROX 8.1  ";
                    _favoritesTrip1[0] = core.general.FavoritesROX2010.FAVORITES_GUI[0];
                    _favoritesTrip1[1] = core.general.FavoritesROX2010.FAVORITES_GUI[1];
                    _favoritesTrip1[2] = core.general.FavoritesROX2010.FAVORITES_GUI[2];
                    _favoritesTrip1[3] = core.general.FavoritesROX2010.FAVORITES_GUI[3];
                    _favoritesTrip1[4] = core.general.FavoritesROX2010.FAVORITES_GUI[12];
                    _favoritesTrip1[5] = core.general.FavoritesROX2010.FAVORITES_GUI[16];
                    _favoritesTrip1[6] = core.general.FavoritesROX2010.FAVORITES_GUI[49];
                    _favoritesTrip1[7] = core.general.FavoritesROX2010.FAVORITES_GUI[43];
                    _favoritesTrip1[8] = core.general.FavoritesROX2010.FAVORITES_GUI[18];
                    _favoritesTrip1[9] = core.general.FavoritesROX2010.FAVORITES_GUI[41];
                    _favoritesTrip2[0] = core.general.FavoritesROX2010.FAVORITES_GUI[0];
                    _favoritesTrip2[1] = core.general.FavoritesROX2010.FAVORITES_GUI[1];
                    _favoritesTrip2[2] = core.general.FavoritesROX2010.FAVORITES_GUI[2];
                    _favoritesTrip2[3] = core.general.FavoritesROX2010.FAVORITES_GUI[12];
                    _favoritesTrip2[4] = core.general.FavoritesROX2010.FAVORITES_GUI[22];
                    _favoritesTrip2[5] = core.general.FavoritesROX2010.FAVORITES_GUI[24];
                    _favoritesTrip2[6] = core.general.FavoritesROX2010.FAVORITES_GUI[27];
                    _favoritesTrip2[7] = core.general.FavoritesROX2010.FAVORITES_GUI[23];
                    _favoritesTrip2[8] = core.general.FavoritesROX2010.FAVORITES_GUI[49];
                    _favoritesTrip2[9] = core.general.FavoritesROX2010.FAVORITES_GUI[41];
                }
            }
            else 
            {
                _myName = " ROX 9.1  ";
                _favoritesTrip1[0] = core.general.FavoritesROX2010.FAVORITES_GUI[0];
                _favoritesTrip1[1] = core.general.FavoritesROX2010.FAVORITES_GUI[1];
                _favoritesTrip1[2] = core.general.FavoritesROX2010.FAVORITES_GUI[2];
                _favoritesTrip1[3] = core.general.FavoritesROX2010.FAVORITES_GUI[3];
                _favoritesTrip1[4] = core.general.FavoritesROX2010.FAVORITES_GUI[8];
                _favoritesTrip1[5] = core.general.FavoritesROX2010.FAVORITES_GUI[12];
                _favoritesTrip1[6] = core.general.FavoritesROX2010.FAVORITES_GUI[49];
                _favoritesTrip1[7] = core.general.FavoritesROX2010.FAVORITES_GUI[43];
                _favoritesTrip1[8] = core.general.FavoritesROX2010.FAVORITES_GUI[18];
                _favoritesTrip1[9] = core.general.FavoritesROX2010.FAVORITES_GUI[41];
                _favoritesTrip2[0] = core.general.FavoritesROX2010.FAVORITES_GUI[0];
                _favoritesTrip2[1] = core.general.FavoritesROX2010.FAVORITES_GUI[1];
                _favoritesTrip2[2] = core.general.FavoritesROX2010.FAVORITES_GUI[2];
                _favoritesTrip2[3] = core.general.FavoritesROX2010.FAVORITES_GUI[8];
                _favoritesTrip2[4] = core.general.FavoritesROX2010.FAVORITES_GUI[22];
                _favoritesTrip2[5] = core.general.FavoritesROX2010.FAVORITES_GUI[24];
                _favoritesTrip2[6] = core.general.FavoritesROX2010.FAVORITES_GUI[27];
                _favoritesTrip2[7] = core.general.FavoritesROX2010.FAVORITES_GUI[49];
                _favoritesTrip2[8] = core.general.FavoritesROX2010.FAVORITES_GUI[12];
                _favoritesTrip2[9] = core.general.FavoritesROX2010.FAVORITES_GUI[41];
            }
            return;
        }

        public function get shoulderWidth():Number
        {
            return _shoulderWidth;
        }

        public function get bikeType1():String
        {
            return _bikeType1;
        }

        public function set bikeType1(arg1:String):void
        {
            if (arg1 != _bikeType1) 
            {
                _bikeType1 = arg1;
                dispatchEvent(new flash.events.Event("bikeType1Change"));
            }
            return;
        }

        public function set shoulderWidth(arg1:Number):void
        {
            if (arg1 != _shoulderWidth) 
            {
                _shoulderWidth = arg1;
                dispatchEvent(new flash.events.Event("shoulderWidthChange"));
            }
            return;
        }

        public function get bikeType2():String
        {
            return _bikeType2;
        }

        public function set bikeType2(arg1:String):void
        {
            if (arg1 != _bikeType2) 
            {
                _bikeType2 = arg1;
                dispatchEvent(new flash.events.Event("bikeType2Change"));
            }
            return;
        }

        public function get shoulderWidthMax():Number
        {
            return 80;
        }

        public function get bikeWeight1():int
        {
            return _bikeWeight1;
        }

        public function set bikeWeight1(arg1:int):void
        {
            if (arg1 != _bikeWeight1) 
            {
                _bikeWeight1 = arg1;
                dispatchEvent(new flash.events.Event("bikeWeight1Change"));
            }
            return;
        }

        public function get bikeWeight1Max():int
        {
            return 50000;
        }

        public function get bikeWeight1Min():int
        {
            return 5000;
        }

        public function get shoulderWidthMin():Number
        {
            return 38;
        }

        public function get bikeWeight1Unit():String
        {
            return _bikeWeight1Unit;
        }

        public function set bikeWeight1Unit(arg1:String):void
        {
            if (arg1 != _bikeWeight1Unit) 
            {
                _bikeWeight1Unit = arg1;
                dispatchEvent(new flash.events.Event("bikeWeight1UnitChange"));
            }
            return;
        }

        public function get wheelSize1Min():int
        {
            return 1000;
        }

        public function get bikeWeight2():int
        {
            return _bikeWeight2;
        }

        public function set bikeWeight2(arg1:int):void
        {
            if (arg1 != _bikeWeight2) 
            {
                _bikeWeight2 = arg1;
                dispatchEvent(new flash.events.Event("bikeWeight2Change"));
            }
            return;
        }

        public function get bikeWeight2Max():int
        {
            return bikeWeight1Max;
        }

        public function get bikeWeight2Min():int
        {
            return bikeWeight1Min;
        }

        public function get shoulderWidthUnit():String
        {
            return _shoulderWidthUnit;
        }

        public function get bikeWeight2Unit():String
        {
            return _bikeWeight2Unit;
        }

        public function set bikeWeight2Unit(arg1:String):void
        {
            if (arg1 != _bikeWeight2Unit) 
            {
                _bikeWeight2Unit = arg1;
                dispatchEvent(new flash.events.Event("bikeWeight2UnitChange"));
            }
            return;
        }

        public function set shoulderWidthUnit(arg1:String):void
        {
            if (arg1 != _shoulderWidthUnit) 
            {
                _shoulderWidthUnit = arg1;
                dispatchEvent(new flash.events.Event("shoulderWidthUnitChange"));
            }
            return;
        }

        public function get birthDate():Date
        {
            return _birthDate;
        }

        public function set birthDate(arg1:Date):void
        {
            if (arg1 != _birthDate) 
            {
                _birthDate = arg1;
                dispatchEvent(new flash.events.Event("birthDateChange"));
            }
            return;
        }

        public function get birthDateMax():Number
        {
            return new Date(NOW.fullYear - 6, NOW.month, NOW.date).time;
        }

        public function get birthDateMin():Number
        {
            return new Date(1900, 0, 1).time;
        }

        public function get zoneAlarm():Boolean
        {
            return _zoneAlarm;
        }

        public function get bodyHeight():Number
        {
            return _bodyHeight;
        }

        public function set bodyHeight(arg1:Number):void
        {
            if (arg1 != _bodyHeight) 
            {
                _bodyHeight = arg1;
                dispatchEvent(new flash.events.Event("bodyHeightChange"));
            }
            return;
        }

        public function get bodyHeightMax():Number
        {
            return 250;
        }

        public function get bodyHeightMin():Number
        {
            return 100;
        }

        public function get showTotals():int
        {
            return _showTotals;
        }

        public function get bodyHeightUnit():String
        {
            return _bodyHeightUnit;
        }

        public function set bodyHeightUnit(arg1:String):void
        {
            if (arg1 != _bodyHeightUnit) 
            {
                _bodyHeightUnit = arg1;
                dispatchEvent(new flash.events.Event("bodyHeightUnitChange"));
            }
            return;
        }

        public function get bodyWeight():int
        {
            return _weight;
        }

        public function set bodyWeight(arg1:int):void
        {
            if (arg1 != _weight) 
            {
                _weight = arg1;
                dispatchEvent(new flash.events.Event("weightChange"));
            }
            return;
        }

        public function get bodyWeightMax():int
        {
            return 199000;
        }

        public function get bodyWeightMin():int
        {
            return 20000;
        }

        public function get bodyWeightUnit():String
        {
            return _weightUnit;
        }

        public function set bodyWeightUnit(arg1:String):void
        {
            if (arg1 != _weightUnit) 
            {
                _weightUnit = arg1;
                dispatchEvent(new flash.events.Event("weightUnitChange"));
            }
            return;
        }

        public function set showTotals(arg1:int):void
        {
            if (arg1 != _showTotals) 
            {
                _showTotals = arg1;
                dispatchEvent(new flash.events.Event("showTotalsChange"));
            }
            return;
        }

        public function get buttonInfo():Boolean
        {
            return _buttonInfo;
        }

        public function set buttonInfo(arg1:Boolean):void
        {
            if (arg1 != _buttonInfo) 
            {
                _buttonInfo = arg1;
                dispatchEvent(new flash.events.Event("buttonInfoChange"));
            }
            return;
        }

        public function get wheelSize2():int
        {
            return _wheelSize2;
        }

        public function get clockMode():String
        {
            return _clockMode;
        }

        public function set clockMode(arg1:String):void
        {
            if (arg1 != _clockMode) 
            {
                _clockMode = arg1;
                dispatchEvent(new flash.events.Event("clockModeChange"));
            }
            return;
        }

        public function get startZone1():int
        {
            return _startZone1;
        }

        public function get contrast():int
        {
            return _contrast;
        }

        public function set contrast(arg1:int):void
        {
            if (arg1 != _contrast) 
            {
                _contrast = arg1;
                dispatchEvent(new flash.events.Event("contrastChange"));
            }
            return;
        }

        public function get contrastMax():int
        {
            return 15;
        }

        public function get contrastMin():int
        {
            return 5;
        }

        public function set startZone1(arg1:int):void
        {
            if (arg1 != _startZone1) 
            {
                _startZone1 = arg1;
                dispatchEvent(new flash.events.Event("startZone1Change"));
            }
            return;
        }

        public function get dateFormat():String
        {
            return _dateFormat;
        }

        public function set dateFormat(arg1:String):void
        {
            if (arg1 != _dateFormat) 
            {
                _dateFormat = arg1;
                dispatchEvent(new flash.events.Event("dateFormatChange"));
            }
            return;
        }

        public function set wheelSize2(arg1:int):void
        {
            if (arg1 != _wheelSize2) 
            {
                _wheelSize2 = arg1;
                dispatchEvent(new flash.events.Event("wheelSize2Change"));
            }
            return;
        }

        public function get endZone3():int
        {
            return _endZone3;
        }

        public function set endZone3(arg1:int):void
        {
            if (arg1 != _endZone3) 
            {
                _endZone3 = arg1;
                dispatchEvent(new flash.events.Event("endZone3Change"));
            }
            return;
        }

        public function get startZone2():int
        {
            return _startZone2;
        }

        public function get favoritesTrip1():__AS3__.vec.Vector.<String>
        {
            return _favoritesTrip1;
        }

        public function set favoritesTrip1(arg1:__AS3__.vec.Vector.<String>):void
        {
            if (_favoritesTrip1 !== arg1) 
            {
                _favoritesTrip1 = arg1;
                dispatchEvent(new flash.events.Event("favoritesTrip1Change"));
            }
            return;
        }

        public function get favoritesTrip1Size():int
        {
            return 10;
        }

        public function set startZone2(arg1:int):void
        {
            if (arg1 != _startZone2) 
            {
                _startZone2 = arg1;
                dispatchEvent(new flash.events.Event("startZone2Change"));
            }
            return;
        }

        public function get favoritesTrip2():__AS3__.vec.Vector.<String>
        {
            return _favoritesTrip2;
        }

        public function set favoritesTrip2(arg1:__AS3__.vec.Vector.<String>):void
        {
            if (_favoritesTrip2 !== arg1) 
            {
                _favoritesTrip2 = arg1;
                dispatchEvent(new flash.events.Event("favoritesTrip2Change"));
            }
            return;
        }

        public function get favoritesTrip2Size():int
        {
            return 10;
        }

        public function get wheelSize2Max():int
        {
            return 3999;
        }

        public function get gender():String
        {
            return _gender;
        }

        public function set gender(arg1:String):void
        {
            if (arg1 != _gender) 
            {
                _gender = arg1;
                dispatchEvent(new flash.events.Event("genderChange"));
            }
            return;
        }

        public function get startZone3():int
        {
            return _startZone3;
        }

        public function get ghostFunctionEnabled():Boolean
        {
            return _ghostFunctionEnabled;
        }

        public function set ghostFunctionEnabled(arg1:Boolean):void
        {
            if (arg1 != _ghostFunctionEnabled) 
            {
                _ghostFunctionEnabled = arg1;
                dispatchEvent(new flash.events.Event("ghostFunctionEnabledChange"));
            }
            return;
        }

        public function set startZone3(arg1:int):void
        {
            if (arg1 != _startZone3) 
            {
                _startZone3 = arg1;
                dispatchEvent(new flash.events.Event("startZone3Change"));
            }
            return;
        }

        public function get homeAltitude1():int
        {
            return _homeAltitude1;
        }

        public function set homeAltitude1(arg1:int):void
        {
            if (arg1 != _homeAltitude1) 
            {
                _homeAltitude1 = arg1;
                dispatchEvent(new flash.events.Event("homeAltitude1Change"));
            }
            return;
        }

        public function get homeAltitude1Max():int
        {
            if (core.MeasurementConfig.altitudeFormat == "meter") 
            {
                return 4999000;
            }
            return 4999000;
        }

        public function get homeAltitude1Min():int
        {
            if (core.MeasurementConfig.altitudeFormat == "meter") 
            {
                return -999000;
            }
            return -999000;
        }

        public override function toString():String
        {
            return "[SettingsROX2010 extends SettingsBikeComputer implements ILanguage, IThreeZones, IWheelSize2, IWeight, IGender, IDate, IFavorite1,...]";
        }

        public function get homeAltitude2():int
        {
            return _homeAltitude2;
        }

        public function set homeAltitude2(arg1:int):void
        {
            if (arg1 != _homeAltitude2) 
            {
                _homeAltitude2 = arg1;
                dispatchEvent(new flash.events.Event("homeAltitude2Change"));
            }
            return;
        }

        public function get homeAltitude2Max():int
        {
            return homeAltitude1Max;
        }

        public function get homeAltitude2Min():int
        {
            return homeAltitude1Min;
        }

        public function get volume():int
        {
            return _volume;
        }

        public function get homeAltitude3():int
        {
            return _homeAltitude3;
        }

        public function set homeAltitude3(arg1:int):void
        {
            if (arg1 != _homeAltitude3) 
            {
                _homeAltitude3 = arg1;
                dispatchEvent(new flash.events.Event("homeAltitude3Change"));
            }
            return;
        }

        public function get homeAltitude3Max():int
        {
            return homeAltitude1Max;
        }

        public function get homeAltitude3Min():int
        {
            return homeAltitude1Min;
        }

        public function set volume(arg1:int):void
        {
            if (arg1 != _volume) 
            {
                _volume = arg1;
                dispatchEvent(new flash.events.Event("volumeChange"));
            }
            return;
        }

        public function get hrMax():int
        {
            return _hrMax;
        }

        public function set hrMax(arg1:int):void
        {
            if (arg1 != _hrMax) 
            {
                _hrMax = arg1;
                dispatchEvent(new flash.events.Event("hrMaxChange"));
            }
            return;
        }

        public function get hrMaxMax():int
        {
            return 240;
        }

        public function get hrMaxMin():int
        {
            return 100;
        }

        public function set zoneAlarm(arg1:Boolean):void
        {
            if (arg1 != _zoneAlarm) 
            {
                _zoneAlarm = arg1;
                dispatchEvent(new flash.events.Event("zoneAlarmChange"));
            }
            return;
        }

        public function get language():String
        {
            return _language;
        }

        public function set language(arg1:String):void
        {
            if (arg1 != _language) 
            {
                _language = arg1;
                dispatchEvent(new flash.events.Event("languageChange"));
            }
            return;
        }

        public function get wheelSize1():int
        {
            return _wheelSize1;
        }

        public function get lowBatDetectLevel():String
        {
            return _lowBatDetectLevel;
        }

        public function set lowBatDetectLevel(arg1:String):void
        {
            if (arg1 != _lowBatDetectLevel) 
            {
                _lowBatDetectLevel = arg1;
                dispatchEvent(new flash.events.Event("lowBatDetectLevelChange"));
            }
            return;
        }

        public function set wheelSize1(arg1:int):void
        {
            if (_wheelSize1 !== arg1) 
            {
                _wheelSize1 = arg1;
                dispatchEvent(new flash.events.Event("wheelSize1Change"));
            }
            return;
        }

        public function get myName():String
        {
            return _myName;
        }

        public function set myName(arg1:String):void
        {
            if (arg1 != _myName) 
            {
                _myName = arg1;
                dispatchEvent(new flash.events.Event("myNameChange"));
            }
            return;
        }

        public function get wheelSize2Min():int
        {
            return 1000;
        }

        public function get myNameMaxLength():uint
        {
            return 10;
        }

        public function get wheelSize1Max():int
        {
            return 3999;
        }

        public static const TOTALTRIPDISTDOWNBIKE1_MAX_MI:Number=160932790.656;

        public static const TOTALTRIPDISTDOWNBIKE1_MIN:int=0;

        public static const TOTALTRIPDISTDOWNBIKE2_MAX_KM:Number=99999000;

        public static const TOTALTRIPDISTDOWNBIKE2_MAX_MI:Number=160932790.656;

        public static const TOTALTRIPDISTDOWNBIKE2_MIN:int=0;

        public static const TOTALTRIPDISTUPBIKE1_MAX_KM:Number=99999000;

        public static const TOTALTRIPDISTUPBIKE1_MAX_MI:Number=160932790.656;

        public static const TOTALTRIPDISTUPBIKE1_MIN:int=0;

        public static const TOTALTRIPDISTUPBIKE2_MAX_KM:Number=99999000;

        public static const TOTALTRIPDISTUPBIKE2_MAX_MI:Number=160932790.656;

        public static const TOTALTRIPDISTUPBIKE2_MIN:int=0;

        public static const USERSIZE_CM_MAX:int=250;

        public static const USERSIZE_CM_MIN:int=100;

        public static const USERSIZE_INCH_MAX:int=100;

        public static const USERSIZE_INCH_MIN:int=39;

        public static const VOLUME_MAX:int=5;

        public static const VOLUME_MIN:int=1;

        public static const WEIGHTBIKE_G_MAX:int=50000;

        public static const WEIGHTBIKE_G_MIN:int=5000;

        public static const WEIGHTBIKE_LB_MAX:int=100;

        public static const WEIGHTBIKE_LB_MIN:int=10;

        public static const WEIGHTLB_MAX:int=438;

        public static const WEIGHTLB_MIN:int=44;

        public static const WEIGHT_G_MAX:int=199000;

        public static const WEIGHT_G_MIN:int=20000;

        public static const WHEEL_SBIKE1_MAX:int=3999;

        public static const WHEEL_SBIKE1_MIN:int=1000;

        public static const WHEEL_SBIKE2_MAX:int=3999;

        public static const WHEEL_SBIKE2_MIN:int=1000;

        internal static const FAVORIT_TRIP_SIZE:int=10;

        internal static const NOW:Date=new Date();

        internal const _myNameMaxLength:uint=10;

        public static const CHECKSUM3_MAX:int=65535;

        public static const CHECKSUM3_MIN:int=0;

        public static const CLOCK_MAX:int=86399;

        public static const CLOCK_MIN:int=0;

        public static const CONTRAST_MAX:int=15;

        public static const CONTRAST_MIN:int=5;

        public static const DATE_MAX:Date=new Date(2099, 11, 31);

        public static const DATE_MIN:Date=new Date(2006, 0, 1);

        public static const ENDPOWERZONE_MAX:int=240;

        public static const ENDPOWERZONE_MIN:int=40;

        public static const HOME_ALTITUDE_FT_MAX:Number=3.0479999997e+012;

        public static const HOME_ALTITUDE_FT_MIN:int=-304496;

        public static const HOME_ALTITUDE_M_MAX:int=4999000;

        public static const HOME_ALTITUDE_M_MIN:int=-999000;

        public static const MAXALTITUEBIKE1_FT_MAX:int=3047696;

        public static const MAXALTITUEBIKE1_FT_MIN:int=-304496;

        public static const MAXALTITUEBIKE1_M_MAX:int=4999000;

        public static const MAXALTITUEBIKE1_M_MIN:int=-999000;

        public static const MAXALTITUEBIKE2_FT_MAX:int=3047696;

        public static const MAXALTITUEBIKE2_FT_MIN:int=-304496;

        public static const MAXALTITUEBIKE2_M_MAX:int=4999000;

        public static const MAXALTITUEBIKE2_M_MIN:int=-999000;

        public static const MAXHEARTRATE_MAX:int=240;

        public static const MAXHEARTRATE_MIN:int=100;

        public static const SHOULDERWIDTH_CM_MAX:int=80;

        public static const SHOULDERWIDTH_CM_MIN:int=38;

        public static const SHOULDERWIDTH_INCH_MAX:int=31;

        public static const SHOULDERWIDTH_INCH_MIN:int=15;

        public static const STARTFITNESSZONE_MAX:int=240;

        public static const STARTFITNESSZONE_MIN:int=40;

        public static const STARTHEALTHZONE_MAX:int=240;

        public static const STARTHEALTHZONE_MIN:int=40;

        public static const STARTPOWERZONE_MAX:int=240;

        public static const STARTPOWERZONE_MIN:int=40;

        public static const TOTALCLIMBMETERBIKE1_MAX_FT:int=304799969;

        public static const TOTALCLIMBMETERBIKE1_MAX_M:int=999999000;

        public static const TOTALCLIMBMETERBIKE1_MIN:int=0;

        public static const TOTALCLIMBMETERBIKE2_MAX_FT:int=304799969;

        public static const TOTALCLIMBMETERBIKE2_MAX_M:int=999999000;

        public static const TOTALCLIMBMETERBIKE2_MIN:int=0;

        public static const TOTALDBIKE1_MAX_KM:Number=99999000;

        public static const TOTALDBIKE1_MAX_MI:Number=160932790.656;

        public static const TOTALDBIKE1_MIN:int=0;

        public static const TOTALDBIKE2_MAX_KM:Number=99999000;

        public static const TOTALDBIKE2_MAX_MI:Number=160932790.656;

        public static const TOTALDBIKE2_MIN:int=0;

        public static const TOTALDESCENTBIKE1_MAX_FT:int=304799969;

        public static const TOTALDESCENTBIKE1_MAX_M:int=999999000;

        public static const TOTALDESCENTBIKE1_MIN:int=0;

        public static const TOTALDESCENTBIKE2_MAX_FT:int=304799969;

        public static const TOTALDESCENTBIKE2_MAX_M:int=999999000;

        public static const TOTALDESCENTBIKE2_MIN:int=0;

        public static const TOTALKCALBIKE1_MAX:int=999999;

        public static const TOTALKCALBIKE1_MIN:int=0;

        public static const TOTALKCALBIKE2_MAX:int=999999;

        public static const TOTALKCALBIKE2_MIN:int=0;

        public static const TOTALTIMEBIKE1_HOURS_MAX:int=9999;

        public static const TOTALTIMEBIKE1_HOURS_MIN:int=0;

        public static const TOTALTIMEBIKE1_MAX:uint=3599999900;

        public static const TOTALTIMEBIKE1_MINUTES_MAX:int=59;

        public static const TOTALTIMEBIKE1_MINUTES_MIN:int=0;

        public static const TOTALTIMEBIKE1_SECONDS_MAX:int=59;

        public static const TOTALTIMEBIKE1_SECONDS_MIN:int=0;

        public static const TOTALTIMEBIKE2_HOURS_MAX:int=9999;

        public static const TOTALTIMEBIKE2_HOURS_MIN:int=0;

        public static const TOTALTIMEBIKE2_MINUTES_MAX:int=59;

        public static const TOTALTIMEBIKE2_MINUTES_MIN:int=0;

        public static const TOTALTIMEBIKE2_SECONDS_MAX:int=59;

        public static const TOTALTIMEBIKE2_SECONDS_MIN:int=0;

        public static const TOTALTIMEDOWNBIKE1_HOURS_MAX:int=9999;

        public static const TOTALTIMEDOWNBIKE1_HOURS_MIN:int=0;

        public static const TOTALTIMEDOWNBIKE1_MAX:uint=3599999900;

        public static const TOTALTIMEDOWNBIKE1_MINUTES_MAX:int=59;

        public static const TOTALTIMEDOWNBIKE1_MINUTES_MIN:int=0;

        public static const TOTALTIMEDOWNBIKE1_SECONDS_MAX:int=59;

        public static const TOTALTIMEDOWNBIKE1_SECONDS_MIN:int=0;

        public static const TOTALTIMEDOWNBIKE2_HOURS_MAX:int=9999;

        public static const TOTALTIMEDOWNBIKE2_HOURS_MIN:int=0;

        public static const TOTALTIMEDOWNBIKE2_MAX:uint=3599999900;

        public static const TOTALTIMEDOWNBIKE2_MINUTES_MAX:int=59;

        public static const TOTALTIMEDOWNBIKE2_MINUTES_MIN:int=0;

        public static const TOTALTIMEDOWNBIKE2_SECONDS_MAX:int=59;

        public static const TOTALTIMEDOWNBIKE2_SECONDS_MIN:int=0;

        public static const TOTALTIMEUPBIKE1_HOURS_MAX:int=9999;

        public static const TOTALTIMEUPBIKE1_HOURS_MIN:int=0;

        public static const TOTALTIMEUPBIKE1_MAX:uint=3599999900;

        public static const TOTALTIMEUPBIKE1_MINUTES_MAX:int=59;

        public static const TOTALTIMEUPBIKE1_MINUTES_MIN:int=0;

        public static const TOTALTIMEUPBIKE1_SECONDS_MAX:int=59;

        public static const TOTALTIMEUPBIKE1_SECONDS_MIN:int=0;

        public static const TOTALTIMEUPBIKE2_HOURS_MAX:int=9999;

        public static const TOTALTIMEUPBIKE2_HOURS_MIN:int=0;

        public static const TOTALTIMEUPBIKE2_MAX:uint=3599999900;

        public static const TOTALTIMEUPBIKE2_MINUTES_MAX:int=59;

        public static const TOTALTIMEUPBIKE2_MINUTES_MIN:int=0;

        public static const TOTALTIMEUPBIKE2_SECONDS_MAX:int=59;

        public static const TOTALTIMEUPBIKE2_SECONDS_MIN:int=0;

        public static const TOTALTRIPDISTDOWNBIKE1_MAX_KM:Number=99999000;

        internal var _bikeType1:String="raceDrop";

        internal var _bikeType2:String="mountainBike";

        internal var _bikeWeight1:int=20000;

        internal var _bikeWeight1Unit:String="kg";

        internal var _bikeWeight2:int=20000;

        internal var _bikeWeight2Unit:String="kg";

        internal var _birthDate:Date;

        internal var _bodyHeight:Number=178;

        internal var _bodyHeightUnit:String="centimeter";

        internal var _buttonInfo:Boolean=false;

        internal var _clockMode:String="24";

        internal var _contrast:int=8;

        internal var _dateFormat:String="eu";

        internal var _endZone3:int=193;

        internal var _favoritesTrip1:__AS3__.vec.Vector.<String>;

        internal var _favoritesTrip2:__AS3__.vec.Vector.<String>;

        internal var _gender:String="male";

        internal var _ghostFunctionEnabled:Boolean=true;

        internal var _homeAltitude1:int=100000;

        internal var _homeAltitude2:int=200000;

        internal var _homeAltitude3:int=300000;

        internal var _hrMax:int=193;

        internal var _language:String="en";

        internal var _lowBatDetectLevel:String;

        internal var _myName:String;

        internal var _shoulderWidth:Number=48;

        internal var _shoulderWidthUnit:String="centimeter";

        internal var _showTotals:int=0;

        internal var _startZone1:int=106;

        internal var _startZone2:int=135;

        internal var _startZone3:int=154;

        internal var _favorites2:__AS3__.vec.Vector.<String>;

        internal var _weight:int=75000;

        internal var _weightUnit:String="kg";

        internal var _volume:int=3;

        internal var _zoneAlarm:Boolean=true;

        internal var _wheelSize2:int=2000;

        internal var _wheelSize1:int=2155;
    }
}


//  class SettingsROX50
package core.settings 
{
    import core.settings.interfaces.*;
    import core.units.interfaces.*;
    import flash.events.*;
    
    public class SettingsROX50 extends core.settings.SettingsTopline2012 implements core.settings.interfaces.IService, core.settings.interfaces.ILanguage, core.settings.interfaces.IContrast, core.settings.interfaces.IWheelSize2, core.settings.interfaces.ILowBatDetectLevel, core.settings.interfaces.IBodyWeight, core.settings.interfaces.IBodyWeightUnit, core.settings.interfaces.IGender, core.settings.interfaces.IHRmax, core.units.interfaces.IIntensityZonesPercentage, core.settings.interfaces.ITrainingZone, core.settings.interfaces.IHeartrateLimits, core.settings.interfaces.IZoneAlarm, core.settings.interfaces.IAge, core.settings.interfaces.IDate, core.settings.interfaces.IDateFormat
    {
        public function SettingsROX50(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            return;
        }

        public function get upperLimitMax():int
        {
            return 240;
        }

        public function get age():int
        {
            return _age;
        }

        public function set age(arg1:int):void
        {
            if (arg1 != _age) 
            {
                _age = arg1;
                dispatchEvent(new flash.events.Event("AgeChange"));
            }
            return;
        }

        public function get ageMax():int
        {
            return 99;
        }

        public function get ageMin():int
        {
            return 10;
        }

        public function get bodyWeight():int
        {
            return _weight;
        }

        public function set bodyWeight(arg1:int):void
        {
            if (arg1 != _weight) 
            {
                _weight = arg1;
                dispatchEvent(new flash.events.Event("weightChange"));
            }
            return;
        }

        public function get bodyWeightUnit():String
        {
            return _weightUnit;
        }

        public function set bodyWeightUnit(arg1:String):void
        {
            if (arg1 != _weightUnit) 
            {
                _weightUnit = arg1;
                dispatchEvent(new flash.events.Event("weightUnitChange"));
            }
            return;
        }

        public function get upperLimitMin():int
        {
            return lowerLimit + 5;
        }

        public function get contrast():int
        {
            return _contrast;
        }

        public function set contrast(arg1:int):void
        {
            if (arg1 != _contrast) 
            {
                _contrast = arg1;
                dispatchEvent(new flash.events.Event("contrastChange"));
            }
            return;
        }

        public function get contrastMax():int
        {
            return 3;
        }

        public function get contrastMin():int
        {
            return 1;
        }

        public function get wheelSize2():int
        {
            return _wheelSize2;
        }

        public function get dateFormat():String
        {
            return _dateFormat;
        }

        public function set dateFormat(arg1:String):void
        {
            if (arg1 != _dateFormat) 
            {
                _dateFormat = arg1;
                dispatchEvent(new flash.events.Event("dateFormatChange"));
            }
            return;
        }

        public function set wheelSize2(arg1:int):void
        {
            if (arg1 != _wheelSize2) 
            {
                _wheelSize2 = arg1;
                dispatchEvent(new flash.events.Event("wheelSize2Change"));
            }
            return;
        }

        public function get gender():String
        {
            return _gender;
        }

        public function set gender(arg1:String):void
        {
            if (arg1 != _gender) 
            {
                _gender = arg1;
                dispatchEvent(new flash.events.Event("genderChange"));
            }
            return;
        }

        public override function toString():String
        {
            return "[SettingsROX50 extends SettingsBikeComputer]";
        }

        public function get hrMax():int
        {
            return _hrMax;
        }

        public function set hrMax(arg1:int):void
        {
            if (arg1 != _hrMax) 
            {
                _hrMax = arg1;
                dispatchEvent(new flash.events.Event("hrMaxChange"));
            }
            return;
        }

        public function get intensityZone1PercentageStart():Number
        {
            return _intensityZone1;
        }

        public function set intensityZone1PercentageStart(arg1:Number):void
        {
            if (arg1 != _intensityZone1) 
            {
                _intensityZone1 = arg1;
                dispatchEvent(new flash.events.Event("intensityZone1PercentageStartChange"));
            }
            return;
        }

        public function get intensityZone2PercentageStart():Number
        {
            return _intensityZone2;
        }

        public function set intensityZone2PercentageStart(arg1:Number):void
        {
            if (arg1 != _intensityZone2) 
            {
                _intensityZone2 = arg1;
                dispatchEvent(new flash.events.Event("intensityZone2PercentageStartChange"));
            }
            return;
        }

        public function get intensityZone3PercentageStart():Number
        {
            return _intensityZone3;
        }

        public function set intensityZone3PercentageStart(arg1:Number):void
        {
            if (arg1 != _intensityZone3) 
            {
                _intensityZone3 = arg1;
                dispatchEvent(new flash.events.Event("intensityZone3PercentageStartChange"));
            }
            return;
        }

        public function get intensityZone4PercentageEnd():Number
        {
            return _intensityZone4End;
        }

        public function set intensityZone4PercentageEnd(arg1:Number):void
        {
            if (arg1 != _intensityZone4End) 
            {
                _intensityZone4End = arg1;
                dispatchEvent(new flash.events.Event("intensityZone4PercentageEndChange"));
            }
            return;
        }

        public function get intensityZone4PercentageStart():Number
        {
            return _intensityZone4;
        }

        public function set intensityZone4PercentageStart(arg1:Number):void
        {
            if (arg1 != _intensityZone4) 
            {
                _intensityZone4 = arg1;
                dispatchEvent(new flash.events.Event("intensityZone4PercentageStartChange"));
            }
            return;
        }

        public function get intensityZonePercentageMin():Number
        {
            return 20;
        }

        public function set zoneAlarm(arg1:Boolean):void
        {
            if (arg1 != _zoneAlarm) 
            {
                _zoneAlarm = arg1;
                dispatchEvent(new flash.events.Event("zoneAlarmChange"));
            }
            return;
        }

        public function get language():String
        {
            return _language;
        }

        public function set language(arg1:String):void
        {
            if (arg1 != _language) 
            {
                _language = arg1;
                dispatchEvent(new flash.events.Event("languageChange"));
            }
            return;
        }

        public function get lowBatDetectLevel():String
        {
            return _lowBatDetectLevel;
        }

        public function set lowBatDetectLevel(arg1:String):void
        {
            if (arg1 != _lowBatDetectLevel) 
            {
                _lowBatDetectLevel = arg1;
                dispatchEvent(new flash.events.Event("lowBatDetectLevelChange"));
            }
            return;
        }

        public function get lowerLimit():int
        {
            return _lowerLimit;
        }

        public function set lowerLimit(arg1:int):void
        {
            if (arg1 != _lowerLimit) 
            {
                _lowerLimit = arg1;
                dispatchEvent(new flash.events.Event("lowerLimitChange"));
            }
            return;
        }

        public function get lowerLimitMax():int
        {
            return upperLimit - 5;
        }

        public function get lowerLimitMin():int
        {
            return 40;
        }

        public function get serviceInterval():int
        {
            return _serviceInterval;
        }

        public function set serviceInterval(arg1:int):void
        {
            if (arg1 != _serviceInterval) 
            {
                _serviceInterval = arg1;
                dispatchEvent(new flash.events.Event("serviceIntervalChange"));
            }
            return;
        }

        public function get serviceStatusOn():Boolean
        {
            return _serviceStatusOn;
        }

        public function set serviceStatusOn(arg1:Boolean):void
        {
            if (arg1 != _serviceStatusOn) 
            {
                _serviceStatusOn = arg1;
                dispatchEvent(new flash.events.Event("serviceStatusOnChange"));
            }
            return;
        }

        public function get trainingZone():String
        {
            return _trainingZone;
        }

        public function set trainingZone(arg1:String):void
        {
            if (arg1 != _trainingZone) 
            {
                _trainingZone = arg1;
                dispatchEvent(new flash.events.Event("trainingZoneChange"));
            }
            return;
        }

        public function get zoneAlarm():Boolean
        {
            return _zoneAlarm;
        }

        public function get upperLimit():int
        {
            return _upperLimit;
        }

        public function set upperLimit(arg1:int):void
        {
            if (arg1 != _upperLimit) 
            {
                _upperLimit = arg1;
                dispatchEvent(new flash.events.Event("upperLimitChange"));
            }
            return;
        }

        internal var _age:int=25;

        internal var _contrast:int=2;

        internal var _dateFormat:String="eu";

        internal var _gender:String="male";

        internal var _hrMax:int=100;

        internal var _language:String="en";

        internal var _serviceStatusOn:Boolean=false;

        internal var _wheelSize2:int=2000;

        internal var _serviceInterval:int=750;

        internal var _lowBatDetectLevel:String="3.00V";

        internal var _zoneAlarm:Boolean=false;

        internal var _trainingZone:String="fitZone";

        internal var _lowerLimit:int=105;

        internal var _intensityZone1:Number=60;

        internal var _intensityZone2:Number=70;

        internal var _intensityZone3:Number=80;

        internal var _intensityZone4:Number=90;

        internal var _intensityZone4End:Number=100;

        internal var _weight:int=75000;

        internal var _weightUnit:String="kg";

        internal var _upperLimit:int=155;
    }
}


//  class SettingsROX60
package core.settings 
{
    import core.general.*;
    import core.settings.interfaces.*;
    import core.units.interfaces.*;
    import flash.events.*;
    
    public class SettingsROX60 extends core.settings.SettingsTopline2012 implements core.settings.interfaces.IService, core.settings.interfaces.ILanguage, core.settings.interfaces.IContrast, core.settings.interfaces.IWheelSize2, core.settings.interfaces.ILowBatDetectLevel, core.settings.interfaces.IBodyWeight, core.settings.interfaces.IBodyWeightUnit, core.settings.interfaces.IGender, core.settings.interfaces.IHRmax, core.units.interfaces.IIntensityZonesPercentage, core.settings.interfaces.ITrainingZone, core.settings.interfaces.IHeartrateLimits, core.settings.interfaces.IZoneAlarm, core.settings.interfaces.ISeaLevel, core.settings.interfaces.IAltitudeReference, core.settings.interfaces.IActualAltitude, core.settings.interfaces.IHomeAltitude1, core.settings.interfaces.IAge, core.settings.interfaces.IDate, core.settings.interfaces.IDateFormat
    {
        public function SettingsROX60(arg1:flash.events.IEventDispatcher=null)
        {
            _altitudeReference = core.general.AltitudeReference.ACTUAL_ALTITUDE;
            super(arg1);
            return;
        }

        public function get upperLimit():int
        {
            return _upperLimit;
        }

        public function get actualAltitude():int
        {
            return _actualAltitude;
        }

        public function set actualAltitude(arg1:int):void
        {
            if (arg1 != _actualAltitude) 
            {
                _actualAltitude = arg1;
                dispatchEvent(new flash.events.Event("actualAltitudeChange"));
            }
            return;
        }

        public function set upperLimit(arg1:int):void
        {
            if (arg1 != _upperLimit) 
            {
                _upperLimit = arg1;
                dispatchEvent(new flash.events.Event("upperLimitChange"));
            }
            return;
        }

        public function get age():int
        {
            return _age;
        }

        public function set age(arg1:int):void
        {
            if (arg1 != _age) 
            {
                _age = arg1;
                dispatchEvent(new flash.events.Event("AgeChange"));
            }
            return;
        }

        public function get ageMax():int
        {
            return 99;
        }

        public function get ageMin():int
        {
            return 10;
        }

        public function get upperLimitMax():int
        {
            return 240;
        }

        public function get altitudeReference():String
        {
            return _altitudeReference;
        }

        public function set altitudeReference(arg1:String):void
        {
            if (arg1 != _altitudeReference) 
            {
                _altitudeReference = arg1;
                dispatchEvent(new flash.events.Event("altitudeReferenceChange"));
            }
            return;
        }

        public function get bodyWeight():int
        {
            return _weight;
        }

        public function set bodyWeight(arg1:int):void
        {
            if (arg1 != _weight) 
            {
                _weight = arg1;
                dispatchEvent(new flash.events.Event("weightChange"));
            }
            return;
        }

        public function get bodyWeightUnit():String
        {
            return _weightUnit;
        }

        public function set bodyWeightUnit(arg1:String):void
        {
            if (arg1 != _weightUnit) 
            {
                _weightUnit = arg1;
                dispatchEvent(new flash.events.Event("weightUnitChange"));
            }
            return;
        }

        public function get upperLimitMin():int
        {
            return lowerLimit + 5;
        }

        public function get contrast():int
        {
            return _contrast;
        }

        public function set contrast(arg1:int):void
        {
            if (arg1 != _contrast) 
            {
                _contrast = arg1;
                dispatchEvent(new flash.events.Event("contrastChange"));
            }
            return;
        }

        public function get contrastMax():int
        {
            return 3;
        }

        public function get contrastMin():int
        {
            return 1;
        }

        public function get wheelSize2():int
        {
            return _wheelSize2;
        }

        public function get dateFormat():String
        {
            return _dateFormat;
        }

        public function set dateFormat(arg1:String):void
        {
            if (arg1 != _dateFormat) 
            {
                _dateFormat = arg1;
                dispatchEvent(new flash.events.Event("dateFormatChange"));
            }
            return;
        }

        public function get zoneAlarm():Boolean
        {
            return _zoneAlarm;
        }

        public function get gender():String
        {
            return _gender;
        }

        public function set gender(arg1:String):void
        {
            if (arg1 != _gender) 
            {
                _gender = arg1;
                dispatchEvent(new flash.events.Event("genderChange"));
            }
            return;
        }

        public function set zoneAlarm(arg1:Boolean):void
        {
            if (arg1 != _zoneAlarm) 
            {
                _zoneAlarm = arg1;
                dispatchEvent(new flash.events.Event("zoneAlarmChange"));
            }
            return;
        }

        public function get homeAltitude1():int
        {
            return _homeAltitude1;
        }

        public function set homeAltitude1(arg1:int):void
        {
            if (arg1 != _homeAltitude1) 
            {
                _homeAltitude1 = arg1;
                dispatchEvent(new flash.events.Event("homeAltitude1Change"));
            }
            return;
        }

        public override function toString():String
        {
            return "[SettingsROX60 extends SettingsBikeComputer]";
        }

        public function get hrMax():int
        {
            return _hrMax;
        }

        public function set hrMax(arg1:int):void
        {
            if (arg1 != _hrMax) 
            {
                _hrMax = arg1;
                dispatchEvent(new flash.events.Event("hrMaxChange"));
            }
            return;
        }

        public function get intensityZone1PercentageStart():Number
        {
            return _intensityZone1;
        }

        public function set intensityZone1PercentageStart(arg1:Number):void
        {
            if (arg1 != _intensityZone1) 
            {
                _intensityZone1 = arg1;
                dispatchEvent(new flash.events.Event("intensityZone1PercentageStartChange"));
            }
            return;
        }

        public function get intensityZone2PercentageStart():Number
        {
            return _intensityZone2;
        }

        public function set intensityZone2PercentageStart(arg1:Number):void
        {
            if (arg1 != _intensityZone2) 
            {
                _intensityZone2 = arg1;
                dispatchEvent(new flash.events.Event("intensityZone2PercentageStartChange"));
            }
            return;
        }

        public function get intensityZone3PercentageStart():Number
        {
            return _intensityZone3;
        }

        public function set intensityZone3PercentageStart(arg1:Number):void
        {
            if (arg1 != _intensityZone3) 
            {
                _intensityZone3 = arg1;
                dispatchEvent(new flash.events.Event("intensityZone3PercentageStartChange"));
            }
            return;
        }

        public function get intensityZone4PercentageEnd():Number
        {
            return _intensityZone4End;
        }

        public function set intensityZone4PercentageEnd(arg1:Number):void
        {
            if (arg1 != _intensityZone4End) 
            {
                _intensityZone4End = arg1;
                dispatchEvent(new flash.events.Event("intensityZone4PercentageEndChange"));
            }
            return;
        }

        public function get intensityZone4PercentageStart():Number
        {
            return _intensityZone4;
        }

        public function set intensityZone4PercentageStart(arg1:Number):void
        {
            if (arg1 != _intensityZone4) 
            {
                _intensityZone4 = arg1;
                dispatchEvent(new flash.events.Event("intensityZone4PercentageStartChange"));
            }
            return;
        }

        public function get intensityZonePercentageMin():Number
        {
            return 20;
        }

        public function set wheelSize2(arg1:int):void
        {
            if (arg1 != _wheelSize2) 
            {
                _wheelSize2 = arg1;
                dispatchEvent(new flash.events.Event("wheelSize2Change"));
            }
            return;
        }

        public function get language():String
        {
            return _language;
        }

        public function set language(arg1:String):void
        {
            if (arg1 != _language) 
            {
                _language = arg1;
                dispatchEvent(new flash.events.Event("languageChange"));
            }
            return;
        }

        public function get lowBatDetectLevel():String
        {
            return _lowBatDetectLevel;
        }

        public function set lowBatDetectLevel(arg1:String):void
        {
            if (arg1 != _lowBatDetectLevel) 
            {
                _lowBatDetectLevel = arg1;
                dispatchEvent(new flash.events.Event("lowBatDetectLevelChange"));
            }
            return;
        }

        public function get lowerLimit():int
        {
            return _lowerLimit;
        }

        public function set lowerLimit(arg1:int):void
        {
            if (arg1 != _lowerLimit) 
            {
                _lowerLimit = arg1;
                dispatchEvent(new flash.events.Event("lowerLimitChange"));
            }
            return;
        }

        public function get lowerLimitMax():int
        {
            return upperLimit - 5;
        }

        public function get lowerLimitMin():int
        {
            return 40;
        }

        public function get seaLevel():Number
        {
            return _seaLevel;
        }

        public function set seaLevel(arg1:Number):void
        {
            if (arg1 != _seaLevel) 
            {
                _seaLevel = arg1;
                dispatchEvent(new flash.events.Event("seaLevelChange"));
            }
            return;
        }

        public function get seaLevelMax():Number
        {
            return 1050;
        }

        public function get seaLevelMin():Number
        {
            return 900;
        }

        public function get serviceInterval():int
        {
            return _serviceInterval;
        }

        public function set serviceInterval(arg1:int):void
        {
            if (arg1 != _serviceInterval) 
            {
                _serviceInterval = arg1;
                dispatchEvent(new flash.events.Event("serviceIntervalChange"));
            }
            return;
        }

        public function get serviceStatusOn():Boolean
        {
            return _serviceStatusOn;
        }

        public function set serviceStatusOn(arg1:Boolean):void
        {
            if (arg1 != _serviceStatusOn) 
            {
                _serviceStatusOn = arg1;
                dispatchEvent(new flash.events.Event("serviceStatusOnChange"));
            }
            return;
        }

        public function get trainingZone():String
        {
            return _trainingZone;
        }

        public function set trainingZone(arg1:String):void
        {
            if (arg1 != _trainingZone) 
            {
                _trainingZone = arg1;
                dispatchEvent(new flash.events.Event("trainingZoneChange"));
            }
            return;
        }

        internal var _actualAltitude:int=257000;

        internal var _age:int=25;

        internal var _altitudeReference:String;

        internal var _contrast:int=2;

        internal var _dateFormat:String="eu";

        internal var _gender:String="male";

        internal var _homeAltitude1:int=300000;

        internal var _hrMax:int=193;

        internal var _lowBatDetectLevel:String="3.00V";

        internal var _serviceInterval:int=750;

        internal var _trainingZone:String="fitZone";

        internal var _wheelSize2:int=2000;

        internal var _lowerLimit:int=105;

        internal var _language:String="en";

        internal var _zoneAlarm:Boolean=false;

        internal var _seaLevel:Number=1013.2;

        internal var _upperLimit:int=155;

        internal var _intensityZone1:Number=60;

        internal var _intensityZone2:Number=70;

        internal var _intensityZone3:Number=80;

        internal var _intensityZone4:Number=90;

        internal var _intensityZone4End:Number=100;

        internal var _weight:int=75000;

        internal var _weightUnit:String="kg";

        internal var _serviceStatusOn:Boolean=true;
    }
}


//  class SettingsROX70
package core.settings 
{
    import core.*;
    import core.general.*;
    import core.settings.interfaces.*;
    import flash.events.*;
    
    public class SettingsROX70 extends core.settings.SettingsBikeComputer implements core.settings.interfaces.IDate, core.settings.interfaces.IDistanceUnit, core.settings.interfaces.IAltitudeUnit, core.settings.interfaces.ITemperatureUnit, core.settings.interfaces.IDateFormat, core.settings.interfaces.IClockMode, core.settings.interfaces.ILanguage, core.settings.interfaces.ITimeZone, core.settings.interfaces.ISummerTime, core.settings.interfaces.IMyName, core.settings.interfaces.IButtonTone, core.settings.interfaces.ISystemTone, core.settings.interfaces.IContrast, core.settings.interfaces.IBacklightTime, core.settings.interfaces.IHomeAltitude1, core.settings.interfaces.IHomeAltitude2, core.settings.interfaces.IHomeAltitude3, core.settings.interfaces.IGPSFormat, core.settings.interfaces.IOffTrackAlarm, core.settings.interfaces.ITrackDirection, core.settings.interfaces.IWayPointAlarm, core.settings.interfaces.IAutoOffTime, core.settings.interfaces.IBacklightLevel, core.settings.interfaces.IGender
    {
        public function SettingsROX70(arg1:flash.events.IEventDispatcher=null)
        {
            _autoOffTime = core.general.AutoOffTimeUnit.FIVE_MINUTES;
            super(arg1);
            return;
        }

        public function set summerTime(arg1:Boolean):void
        {
            if (arg1 != _summerTime) 
            {
                _summerTime = arg1;
                dispatchEvent(new flash.events.Event("summerTimeChange"));
            }
            return;
        }

        public function get altitudeUnit():String
        {
            return _altitudeUnit;
        }

        public function set altitudeUnit(arg1:String):void
        {
            if (arg1 != _altitudeUnit) 
            {
                _altitudeUnit = arg1;
                dispatchEvent(new flash.events.Event("altitudeUnitChange"));
            }
            return;
        }

        public function get systemTone():Boolean
        {
            return _systemTone;
        }

        public function get autoOffTime():core.general.AutoOffTimeUnit
        {
            return _autoOffTime;
        }

        public function set autoOffTime(arg1:core.general.AutoOffTimeUnit):void
        {
            _autoOffTime = arg1;
            return;
        }

        public function set systemTone(arg1:Boolean):void
        {
            if (arg1 != _systemTone) 
            {
                _systemTone = arg1;
                dispatchEvent(new flash.events.Event("systemToneChange"));
            }
            return;
        }

        public function get backlightLevel():uint
        {
            return _backlightLevel;
        }

        public function set backlightLevel(arg1:uint):void
        {
            _backlightLevel = arg1;
            return;
        }

        public function get backlightLevelMax():int
        {
            return 3;
        }

        public function get backlightLevelMin():int
        {
            return 1;
        }

        public function get temperatureUnit():String
        {
            return _temperatureUnit;
        }

        public function get backlightTime():Number
        {
            return _backlightTime;
        }

        public function set backlightTime(arg1:Number):void
        {
            if (arg1 != _backlightTime) 
            {
                _backlightTime = arg1;
                dispatchEvent(new flash.events.Event("backlightTimeChange"));
            }
            return;
        }

        public function set temperatureUnit(arg1:String):void
        {
            if (arg1 != _temperatureUnit) 
            {
                _temperatureUnit = arg1;
                dispatchEvent(new flash.events.Event("temperatureUnitChange"));
            }
            return;
        }

        public function get buttonTone():Boolean
        {
            return _buttonTone;
        }

        public function set buttonTone(arg1:Boolean):void
        {
            if (arg1 != _buttonTone) 
            {
                _buttonTone = arg1;
                dispatchEvent(new flash.events.Event("buttonToneChange"));
            }
            return;
        }

        public function get timeZone():int
        {
            return _timeZone;
        }

        public function get clockMode():String
        {
            return _clockMode;
        }

        public function set clockMode(arg1:String):void
        {
            if (arg1 != _clockMode) 
            {
                _clockMode = arg1;
                dispatchEvent(new flash.events.Event("clockModeChange"));
            }
            return;
        }

        public function set timeZone(arg1:int):void
        {
            if (arg1 != _timeZone) 
            {
                _timeZone = arg1;
                dispatchEvent(new flash.events.Event("timeZoneChange"));
            }
            return;
        }

        public function get contrast():int
        {
            return _contrast;
        }

        public function set contrast(arg1:int):void
        {
            if (arg1 != _contrast) 
            {
                _contrast = arg1;
                dispatchEvent(new flash.events.Event("contrastChange"));
            }
            return;
        }

        public function get contrastMax():int
        {
            return 10;
        }

        public function get contrastMin():int
        {
            return 1;
        }

        public function get trackDirection():String
        {
            return _trackDirection;
        }

        public function get dateFormat():String
        {
            return _dateFormat;
        }

        public function set dateFormat(arg1:String):void
        {
            if (arg1 != _dateFormat) 
            {
                _dateFormat = arg1;
                dispatchEvent(new flash.events.Event("dateFormatChange"));
            }
            return;
        }

        public function set trackDirection(arg1:String):void
        {
            _trackDirection = arg1;
            return;
        }

        public function get distanceUnit():String
        {
            return _distanceUnit;
        }

        public function set distanceUnit(arg1:String):void
        {
            if (arg1 != _distanceUnit) 
            {
                _distanceUnit = arg1;
                dispatchEvent(new flash.events.Event("distanceUnitChange"));
            }
            return;
        }

        public function get waypointAlarm():Number
        {
            return _waypointAlarm;
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

        public function set waypointAlarm(arg1:Number):void
        {
            if (arg1 != _waypointAlarm) 
            {
                _waypointAlarm = arg1;
                dispatchEvent(new flash.events.Event("waypointAlarmChange"));
            }
            return;
        }

        public function get gpsFormat():String
        {
            return _gpsFormat;
        }

        public function set gpsFormat(arg1:String):void
        {
            if (arg1 != _gpsFormat) 
            {
                _gpsFormat = arg1;
                dispatchEvent(new flash.events.Event("gpsFormatChange"));
            }
            return;
        }

        public override function getLoggingInfo():String
        {
            return super.getLoggingInfo() + "\t-settingsROX100Id " + settingsROX70Id;
        }

        public function get homeAltitude1():int
        {
            return _homeAltitude1;
        }

        public function set homeAltitude1(arg1:int):void
        {
            if (arg1 != _homeAltitude1) 
            {
                _homeAltitude1 = arg1;
                dispatchEvent(new flash.events.Event("homeAltitude1Change"));
            }
            return;
        }

        public function get homeAltitude1Max():int
        {
            if (core.MeasurementConfig.altitudeFormat == "meter") 
            {
                return 4999000;
            }
            return 5181295;
        }

        public function get homeAltitude1Min():int
        {
            if (core.MeasurementConfig.altitudeFormat == "meter") 
            {
                return -9990000;
            }
            return -304495;
        }

        public override function toString():String
        {
            return "[SettingsROX100 extends SettingsBikeComputer]";
        }

        public function get homeAltitude2():int
        {
            return _homeAltitude2;
        }

        public function set homeAltitude2(arg1:int):void
        {
            if (arg1 != _homeAltitude2) 
            {
                _homeAltitude2 = arg1;
                dispatchEvent(new flash.events.Event("homeAltitude2Change"));
            }
            return;
        }

        public function get homeAltitude2Max():int
        {
            return homeAltitude1Max;
        }

        public function get homeAltitude2Min():int
        {
            return homeAltitude1Min;
        }

        public function get homeAltitude3():int
        {
            return _homeAltitude3;
        }

        public function set homeAltitude3(arg1:int):void
        {
            if (arg1 != _homeAltitude3) 
            {
                _homeAltitude3 = arg1;
                dispatchEvent(new flash.events.Event("homeAltitude3Change"));
            }
            return;
        }

        public function get homeAltitude3Max():int
        {
            return homeAltitude1Max;
        }

        public function get homeAltitude3Min():int
        {
            return homeAltitude1Min;
        }

        public function get language():String
        {
            return _language;
        }

        public function set language(arg1:String):void
        {
            if (arg1 != _language) 
            {
                _language = arg1;
                dispatchEvent(new flash.events.Event("languageChange"));
            }
            return;
        }

        public function get myName():String
        {
            return _myName;
        }

        public function set myName(arg1:String):void
        {
            if (arg1 != _myName) 
            {
                _myName = arg1;
                dispatchEvent(new flash.events.Event("myNameChange"));
            }
            return;
        }

        public function get myNameMaxLength():uint
        {
            return 12;
        }

        public function get offTrackAlarm():Number
        {
            return _offTrackAlarm;
        }

        public function set offTrackAlarm(arg1:Number):void
        {
            if (arg1 != _offTrackAlarm) 
            {
                _offTrackAlarm = arg1;
                dispatchEvent(new flash.events.Event("offTrackAlarmChange"));
            }
            return;
        }

        public function get settingsROX70Id():int
        {
            return _settingsROX70Id;
        }

        public function set settingsROX70Id(arg1:int):void
        {
            _settingsROX70Id = arg1;
            return;
        }

        public function get summerTime():Boolean
        {
            return _summerTime;
        }

        internal static const NOW:Date=new Date();

        internal const _myNameMaxLength:uint=12;

        public static const CONTRAST_MAX:int=10;

        public static const CONTRAST_MIN:int=1;

        public static const HOME_ALTITUDE_FT_MAX_IN_MM:int=5181295;

        public static const HOME_ALTITUDE_FT_MIN_IN_MM:int=-304495;

        public static const HOME_ALTITUDE_M_MAX_IN_MM:int=4999000;

        public static const HOME_ALTITUDE_M_MIN_IN_MM:int=-9990000;

        internal var _altitudeUnit:String="meter";

        internal var _autoOffTime:core.general.AutoOffTimeUnit;

        internal var _backlightLevel:uint=3;

        internal var _backlightTime:Number=1;

        internal var _buttonTone:Boolean=true;

        internal var _clockMode:String="24";

        internal var _contrast:int=6;

        internal var _dateFormat:String="eu";

        internal var _distanceUnit:String="kilometer";

        internal var _gender:String="male";

        internal var _gpsFormat:String="hddd°mm,mmm";

        internal var _homeAltitude1:int=100000;

        internal var _homeAltitude2:int=200000;

        internal var _myName:String="ROX 7.0 GPS";

        internal var _timeZone:int=104;

        internal var _summerTime:Boolean=true;

        internal var _offTrackAlarm:Number=2;

        internal var _trackDirection:String="drivingDirection";

        internal var _homeAltitude3:int=300000;

        internal var _systemTone:Boolean=true;

        internal var _language:String="en";

        internal var _settingsROX70Id:int;

        internal var _temperatureUnit:String="celsius";

        internal var _waypointAlarm:Number=2;
    }
}


//  class SettingsRunningComputer
package core.settings 
{
    import core.settings.interfaces.*;
    import flash.events.*;
    
    public class SettingsRunningComputer extends core.settings.Settings implements core.settings.interfaces.ISpeedUnit, core.settings.interfaces.IClock
    {
        public function SettingsRunningComputer(arg1:flash.events.IEventDispatcher)
        {
            _clock = new Date(new Date().fullYear, 0, 1);
            super(arg1);
            return;
        }

        public function get clock():Date
        {
            return _clock;
        }

        public function set clock(arg1:Date):void
        {
            if (_clock !== arg1) 
            {
                _clock = arg1;
                dispatchEvent(new flash.events.Event("clockChange"));
            }
            return;
        }

        public function get speedUnit():String
        {
            return _speedUnit;
        }

        public function set speedUnit(arg1:String):void
        {
            if (_speedUnit !== arg1) 
            {
                _speedUnit = arg1;
                dispatchEvent(new flash.events.Event("speedUnitChange"));
            }
            return;
        }

        public override function toString():String
        {
            return "[SettingsRunningComputer extends Settings implements IMeasurement, IClock]";
        }

        internal var _clock:Date;

        internal var _speedUnit:String="kmh";
    }
}


//  class SettingsTopline2009
package core.settings 
{
    import core.*;
    import core.settings.interfaces.*;
    import flash.events.*;
    
    public class SettingsTopline2009 extends core.settings.SettingsBikeComputer implements core.settings.interfaces.IWheelSize1
    {
        public function SettingsTopline2009(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            return;
        }

        public function get actualAltitudeMax():int
        {
            if (core.MeasurementConfig.altitudeFormat == "meter") 
            {
                return 4999000;
            }
            return 3962095;
        }

        public function get actualAltitudeMin():int
        {
            if (core.MeasurementConfig.altitudeFormat == "meter") 
            {
                return -999000;
            }
            return -304495;
        }

        public function get bodyWeightMax():int
        {
            return 199000;
        }

        public function get bodyWeightMin():int
        {
            return 20000;
        }

        public function get homeAltitude1Max():int
        {
            if (core.MeasurementConfig.altitudeFormat == "meter") 
            {
                return 4999000;
            }
            return 3962095;
        }

        public function get homeAltitude1Min():int
        {
            if (core.MeasurementConfig.altitudeFormat == "meter") 
            {
                return -999000;
            }
            return -304495;
        }

        public function get hrMaxMax():int
        {
            return 240;
        }

        public function get hrMaxMin():int
        {
            return 100;
        }

        public function get seaLevelMax():Number
        {
            return 1050;
        }

        public function get seaLevelMin():Number
        {
            return 950;
        }

        public function get wheelSize2Min():int
        {
            return 1000;
        }

        public function get wheelSize1():int
        {
            return _wheelSize1;
        }

        public function set wheelSize1(arg1:int):void
        {
            if (_wheelSize1 !== arg1) 
            {
                _wheelSize1 = arg1;
                dispatchEvent(new flash.events.Event("wheelSize1Change"));
            }
            return;
        }

        public function get wheelSize1Max():int
        {
            return 3999;
        }

        public function get wheelSize1Min():int
        {
            return 1000;
        }

        public function get wheelSize2Max():int
        {
            return 3999;
        }

        public static const WHEEL_SIZE_2_MIN:int=1000;

        public static const ACT_ALTIFT_MAX:int=3962095;

        public static const ACT_ALTIFT_MIN:int=-304495;

        public static const ACT_ALTIM_MAX:int=4999000;

        public static const ACT_ALTIM_MIN:int=-999000;

        public static const AGE_MAX:int=99;

        public static const AGE_MIN:int=10;

        public static const AUTO_SCAN_MAX:int=1;

        public static const AUTO_SCAN_MIN:int=0;

        public static const CLOCK_MAX:int=89999;

        public static const CLOCK_MIN:int=0;

        public static const CONTRAST_MAX:int=3;

        public static const CONTRAST_MIN:int=1;

        public static const GENDER_MAX:int=1;

        public static const GENDER_MIN:int=0;

        public static const HIKING_ACTI_MAX_FT:Number=160932790.656;

        public static const HIKING_ACTI_MAX_M:int=99999000;

        public static const HIKING_ACTI_MIN:int=0;

        public static const HIKING_TIME_HOURS_MAX:int=9999;

        public static const HIKING_TIME_HOURS_MIN:int=0;

        public static const HIKING_TIME_MAX:uint=3599999900;

        public static const HIKING_TIME_MIN:int=0;

        public static const HIKING_TIME_MINUTES_MAX:int=59;

        public static const HIKING_TIME_MINUTES_MIN:int=0;

        public static const HIKING_TIME_SECONDS_MAX:int=59;

        public static const HIKING_TIME_SECONDS_MIN:int=0;

        public static const HOME_ALTIFT_MAX:int=3962095;

        public static const HOME_ALTIFT_MIN:int=-304495;

        public static const HOME_ALTIM_MAX:int=4999000;

        public static const HOME_ALTIM_MIN:int=-999000;

        public static const LANGUAGE_MAX:int=7;

        public static const LANGUAGE_MIN:int=1;

        public static const LBD_LEVEL_MAX:int=15;

        public static const LBD_LEVEL_MIN:int=0;

        public static const LOWER_LIMIT_MAX:int=235;

        public static const LOWER_LIMIT_MIN:int=40;

        public static const MAXHEARTRATE_MAX:int=240;

        public static const MAXHEARTRATE_MIN:int=40;

        public static const MAX_ALTI_1_MAX_FT:Number=160932790.656;

        public static const MAX_ALTI_1_MAX_M:int=99999000;

        public static const MAX_ALTI_1_MIN:int=0;

        public static const MEASUREMENT_MAX:int=1;

        public static const MEASUREMENT_MIN:int=0;

        public static const POWER_ON_MODE_MAX:int=2;

        public static const POWER_ON_MODE_MIN:int=0;

        public static const SEA_LEVEL_MAX:int=1050;

        public static const SEA_LEVEL_MIN:int=950;

        public static const SERVICE_INT_MAX:int=99999;

        public static const SERVICE_INT_MIN:int=50;

        public static const SERVICE_STATUS_MAX:int=1;

        public static const SERVICE_STATUS_MIN:int=0;

        public static const TOTALTIMEBIKE1_HOURS_MAX:int=9999;

        public static const TOTALTIMEBIKE1_HOURS_MIN:int=0;

        public static const TOTALTIMEBIKE1_MAX:uint=3599999900;

        public static const TOTALTIMEBIKE1_MINUTES_MAX:int=59;

        public static const TOTALTIMEBIKE1_MINUTES_MIN:int=0;

        public static const TOTALTIMEBIKE1_SECONDS_MAX:int=59;

        public static const TOTALTIMEBIKE1_SECONDS_MIN:int=0;

        public static const TOTALTIMEBIKE2_HOURS_MAX:int=9999;

        public static const TOTALTIMEBIKE2_HOURS_MIN:int=0;

        public static const TOTALTIMEBIKE2_MINUTES_MAX:int=59;

        public static const TOTALTIMEBIKE2_MINUTES_MIN:int=0;

        public static const TOTALTIMEBIKE2_SECONDS_MAX:int=59;

        public static const TOTALTIMEBIKE2_SECONDS_MIN:int=0;

        public static const TOTAL_ALTI_1_MAX_FT:Number=160932790.656;

        public static const TOTAL_ALTI_1_MAX_M:int=99999000;

        public static const TOTAL_ALTI_1_MIN:int=0;

        public static const TOTAL_ALTI_2_MAX_FT:Number=160932790.656;

        public static const TOTAL_ALTI_2_MAX_M:int=99999000;

        public static const TOTAL_ALTI_2_MIN:int=0;

        public static const TOTAL_ODO_1_MAX_FT:Number=160932790.656;

        public static const TOTAL_ODO_1_MAX_M:int=99999000;

        public static const TOTAL_ODO_1_MIN:int=0;

        public static const TOTAL_ODO_2_MAX_FT:Number=160932790.656;

        public static const TOTAL_ODO_2_MAX_M:int=99999000;

        public static const TOTAL_ODO_2_MIN:int=0;

        public static const TOTAL_TIME_2_MIN:int=0;

        public static const UPPER_LIMIT_MAX:int=240;

        public static const UPPER_LIMIT_MIN:int=45;

        public static const WEIGHTLB_MAX:int=399;

        public static const WEIGHTLB_MIN:int=40;

        public static const WEIGHT_G_MAX:int=199000;

        public static const WEIGHT_G_MIN:int=20000;

        public static const WHEEL_SIZE_1_MAX:int=3999;

        public static const WHEEL_SIZE_1_MIN:int=1000;

        public static const WHEEL_SIZE_2_MAX:int=3999;

        internal var _wheelSize1:int=2155;
    }
}


//  class SettingsTopline2012
package core.settings 
{
    import core.*;
    import core.settings.interfaces.*;
    import flash.events.*;
    
    public class SettingsTopline2012 extends core.settings.SettingsBikeComputer implements core.settings.interfaces.IWheelSize1, core.settings.interfaces.IDate
    {
        public function SettingsTopline2012(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            return;
        }

        public function get actualAltitudeMax():int
        {
            if (core.MeasurementConfig.altitudeFormat == "meter") 
            {
                return 4999000;
            }
            return 3962095;
        }

        public function get actualAltitudeMin():int
        {
            if (core.MeasurementConfig.altitudeFormat == "meter") 
            {
                return -999000;
            }
            return -304495;
        }

        public function get bodyWeightMax():int
        {
            return 199000;
        }

        public function get bodyWeightMin():int
        {
            return 20000;
        }

        public function get homeAltitude1Max():int
        {
            if (core.MeasurementConfig.altitudeFormat == "meter") 
            {
                return 4999000;
            }
            return 3962095;
        }

        public function get homeAltitude1Min():int
        {
            if (core.MeasurementConfig.altitudeFormat == "meter") 
            {
                return -999000;
            }
            return -304495;
        }

        public function get hrMaxMax():int
        {
            return 240;
        }

        public function get hrMaxMin():int
        {
            return 40;
        }

        public function get wheelSize2Min():int
        {
            return 500;
        }

        public function get wheelSize1():int
        {
            return _wheelSize1;
        }

        public function set wheelSize1(arg1:int):void
        {
            if (_wheelSize1 !== arg1) 
            {
                _wheelSize1 = arg1;
                dispatchEvent(new flash.events.Event("wheelSize1Change"));
            }
            return;
        }

        public function get wheelSize1Max():int
        {
            return 3999;
        }

        public function get wheelSize1Min():int
        {
            return 500;
        }

        public function get wheelSize2Max():int
        {
            return 3999;
        }

        internal static const WHEEL_SIZE_2_MAX:int=3999;

        public static const ACT_ALTIFT_MAX:int=3962095;

        public static const ACT_ALTIFT_MIN:int=-304495;

        public static const ACT_ALTIM_MAX:int=4999000;

        public static const ACT_ALTIM_MIN:int=-999000;

        public static const AGE_MAX:int=99;

        public static const AGE_MIN:int=10;

        public static const AUTO_SCAN_MAX:int=1;

        public static const AUTO_SCAN_MIN:int=0;

        public static const CLOCK_MAX:int=89999;

        public static const CLOCK_MIN:int=0;

        public static const CONTRAST_MAX:int=3;

        public static const CONTRAST_MIN:int=1;

        public static const FUEL_CONSUMPTION_LITER_MAX:Number=30;

        public static const FUEL_CONSUMPTION_LITER_MIN:Number=1;

        public static const FUEL_CONSUMPTION_MPG_MAX:Number=240;

        public static const FUEL_CONSUMPTION_MPG_MIN:Number=10;

        public static const GENDER_MAX:int=1;

        public static const GENDER_MIN:int=0;

        public static const HIKING_ACTI_MAX:int=99999000;

        public static const HIKING_ACTI_MIN:int=0;

        public static const HIKING_TIME_MAX:uint=3599999900;

        public static const HOME_ALTIFT_MAX:int=3962095;

        public static const HOME_ALTIFT_MIN:int=-304495;

        public static const HOME_ALTIM_MIN:int=-999000;

        public static const HOME_ALTI_MAX_FT:int=51812952;

        public static const HOME_ALTI_MAX_M:int=4999000;

        public static const LBD_LEVEL_MAX:int=15;

        public static const LBD_LEVEL_MIN:int=0;

        public static const LOWER_LIMIT_MAX:int=235;

        public static const LOWER_LIMIT_MIN:int=40;

        public static const MAXHEARTRATE_MAX:int=240;

        public static const MAXHEARTRATE_MIN:int=40;

        public static const MAX_ALTI_1_MAX_FT:Number=160932790.656;

        public static const MAX_ALTI_1_MAX_M:int=99999000;

        public static const MAX_ALTI_1_MIN:int=0;

        public static const POWER_ON_MODE_MAX:int=2;

        public static const POWER_ON_MODE_MIN:int=0;

        public static const SEA_LEVEL_MAX:int=1050;

        public static const SEA_LEVEL_MIN:int=900;

        public static const SERVICE_INT_MAX:int=99999;

        public static const SERVICE_INT_MIN:int=50;

        public static const SERVICE_STATUS_MAX:int=1;

        public static const SERVICE_STATUS_MIN:int=0;

        public static const TOTALTIMEBIKE1_HOURS_MAX:int=9999;

        public static const TOTALTIMEBIKE1_MAX:uint=3599999900;

        public static const TOTAL_ALTI_1_MAX_FT:Number=160932790.656;

        public static const TOTAL_ALTI_1_MAX_M:int=99999000;

        public static const TOTAL_ALTI_1_MIN:int=0;

        public static const TOTAL_ALTI_2_MAX_FT:Number=160932790.656;

        public static const TOTAL_ALTI_2_MAX_M:int=99999000;

        public static const TOTAL_ALTI_2_MIN:int=0;

        public static const TOTAL_FUEL_CONSUMPTION_MAX:Number=9999.9;

        public static const TOTAL_FUEL_CONSUMPTION_MIN:Number=0;

        public static const TOTAL_KCAL_BIKE_MAX:int=99999;

        public static const TOTAL_KCAL_BIKE_MIN:int=0;

        public static const TOTAL_KCAL_HIKING_MAX:int=99999;

        public static const TOTAL_KCAL_HIKING_MIN:int=0;

        public static const TOTAL_ODO_1_MAX_KM:int=99999000;

        public static const TOTAL_ODO_1_MAX_MI:Number=160932790.656;

        public static const TOTAL_ODO_1_MIN:int=0;

        public static const TOTAL_ODO_2_MAX_KM:int=99999000;

        public static const TOTAL_ODO_2_MAX_MI:Number=160932790.656;

        public static const TOTAL_ODO_2_MIN:int=0;

        public static const UPPER_LIMIT_MAX:int=240;

        public static const UPPER_LIMIT_MIN:int=45;

        public static const WEIGHTLB_MAX:int=399;

        public static const WEIGHTLB_MIN:int=40;

        public static const WEIGHT_G_MAX:int=199000;

        public static const WEIGHT_G_MIN:int=20000;

        public static const WHEEL_SIZE_1_MAX:int=3999;

        public static const WHEEL_SIZE_1_MIN:int=500;

        public static const WHEEL_SIZE_2_MIN:int=500;

        internal var _wheelSize1:int=2155;
    }
}


//  class SettingsTopline2016
package core.settings 
{
    import core.general.*;
    import core.settings.interfaces.*;
    import flash.events.*;
    
    public class SettingsTopline2016 extends core.settings.SettingsBikeComputer implements core.settings.interfaces.IWheelSize1Mode, core.settings.interfaces.ITireSize1, core.settings.interfaces.IWheelSize1
    {
        public function SettingsTopline2016(arg1:flash.events.IEventDispatcher=null)
        {
            _selectionMode = core.general.WheelSizeSelectionMode.TIRE;
            _tireSize = core.general.TireSize.S_16INCH;
            super(arg1);
            return;
        }

        public function get tireSize1():core.general.TireSize
        {
            return _tireSize;
        }

        public function set tireSize1(arg1:core.general.TireSize):void
        {
            _tireSize = arg1;
            if (arg1 && core.general.WheelSizeSelectionMode.TIRE.equals(wheelSize1Mode)) 
            {
                wheelSize1 = parseInt(arg1.data);
            }
            return;
        }

        public function set wheelSize1Mode(arg1:core.general.WheelSizeSelectionMode):void
        {
            _selectionMode = arg1;
            return;
        }

        public function get wheelSize1():int
        {
            return _wheelSize1;
        }

        public function set wheelSize1(arg1:int):void
        {
            if (_wheelSize1 !== arg1) 
            {
                _wheelSize1 = arg1;
                dispatchEvent(new flash.events.Event("wheelSize1Change"));
            }
            return;
        }

        public function get wheelSize1Max():int
        {
            return 3999;
        }

        public function get wheelSize1Min():int
        {
            return 500;
        }

        public function get wheelSize1Mode():core.general.WheelSizeSelectionMode
        {
            return _selectionMode;
        }

        public static const WHEEL_SIZE_1_MIN:int=500;

        public static const WHEEL_SIZE_2_MAX:int=3999;

        public static const DISTANCE2_MAX_KM:int=99999000;

        public static const WHEEL_SIZE_2_MIN:int=500;

        public static const ACT_ALTIFT_MAX:int=5181295;

        public static const ACT_ALTIFT_MIN:int=-304495;

        public static const ACT_ALTIM_MAX:int=4999000;

        public static const ACT_ALTIM_MIN:int=-999000;

        public static const CALORIES_MAX:int=99999;

        public static const CALORIES_MIN:int=0;

        public static const CONTRAST_MAX:int=3;

        public static const CONTRAST_MIN:int=1;

        public static const DISTANCE1_MAX_KM:int=99999000;

        protected static const NOW:Date=new Date();

        public static const DISTANCE1_MAX_MI:Number=160932790.656;

        public static const DISTANCE2_MAX_MI:Number=160932790.656;

        public static const ETA_DISTANCE_MAX:Number=160935121;

        public static const FUEL_CONSUMPTION_LITER_MAX:Number=30;

        public static const FUEL_CONSUMPTION_LITER_MIN:Number=1;

        public static const FUEL_CONSUMPTION_MPG_MAX:Number=23.52;

        public static const FUEL_CONSUMPTION_MPG_MIN:Number=0.98;

        public static const HOME_ALTIFT_MAX:int=3962095;

        public static const HOME_ALTIFT_MIN:int=-304495;

        public static const HOME_ALTIM_MAX:int=4999000;

        public static const HOME_ALTIM_MIN:int=-999000;

        public static const MAXHEARTRATE_MAX:int=240;

        public static const MAXHEARTRATE_MIN:int=40;

        public static const SEA_LEVEL_MAX:int=1050;

        public static const SEA_LEVEL_MIN:int=950;

        public static const SHOULDERWIDTH_CM_MAX:int=80;

        public static const SHOULDERWIDTH_CM_MIN:int=40;

        public static const SHOULDERWIDTH_INCH_MAX_IN_CM:int=76;

        public static const SHOULDERWIDTH_INCH_MIN_IN_CM:int=38;

        public static const TOTALTIMEBIKE1_HOURS_MAX:int=9999;

        public static const TOTALTIMEBIKE1_HOURS_MIN:int=0;

        public static const TOTALTIMEBIKE1_MAX:uint=3599999900;

        public static const TOTALTIMEBIKE1_MINUTES_MAX:int=59;

        public static const TOTALTIMEBIKE1_MINUTES_MIN:int=0;

        public static const TOTALTIMEBIKE1_SECONDS_MAX:int=59;

        public static const TOTALTIMEBIKE1_SECONDS_MIN:int=0;

        public static const TOTALTIMEBIKE2_HOURS_MAX:int=9999;

        public static const TOTALTIMEBIKE2_HOURS_MIN:int=0;

        public static const TOTALTIMEBIKE2_MINUTES_MAX:int=59;

        public static const TOTALTIMEBIKE2_MINUTES_MIN:int=0;

        public static const TOTALTIMEBIKE2_SECONDS_MAX:int=59;

        public static const TOTALTIMEBIKE2_SECONDS_MIN:int=0;

        public static const TOTAL_ALTI_1_MAX_FT:Number=160932790.656;

        public static const TOTAL_ALTI_1_MAX_M:int=99999000;

        public static const TOTAL_ALTI_1_MIN:int=0;

        public static const TOTAL_ALTI_2_MAX_FT:Number=160932790.656;

        public static const TOTAL_ALTI_2_MAX_M:int=99999000;

        public static const TOTAL_ALTI_2_MIN:int=0;

        public static const TOTAL_FUEL_CONSUMPTION_MAX:Number=9999.9;

        public static const TOTAL_FUEL_CONSUMPTION_MIN:Number=0;

        public static const TOTAL_ODO_1_MAX_FT:Number=160932790.656;

        public static const TOTAL_ODO_1_MAX_M:int=99999000;

        public static const TOTAL_ODO_1_MIN:int=0;

        public static const TOTAL_ODO_2_MAX_FT:Number=160932790.656;

        public static const TOTAL_ODO_2_MAX_M:int=99999000;

        public static const TOTAL_ODO_2_MIN:int=0;

        public static const TRAININGTIME_BIKE1_MAX:uint=3599999900;

        public static const TRAININGTIME_BIKE2_MAX:uint=3599999900;

        public static const USERSIZE_CM_MAX:int=250;

        public static const USERSIZE_CM_MIN:int=100;

        public static const USERSIZE_INCH_MAX_IN_CM:int=254;

        public static const USERSIZE_INCH_MIN_IN_CM:int=102;

        public static const WEIGHTBIKE_KG_MAX_IN_G:int=50000;

        public static const WEIGHTBIKE_KG_MIN_IN_G:int=1000;

        public static const WEIGHTBIKE_LB_MAX_IN_G:int=45359;

        public static const WEIGHTBIKE_LB_MIN_IN_G:int=1361;

        public static const WEIGHT_KG_MAX_IN_G:int=200000;

        public static const WEIGHT_KG_MIN_IN_G:int=20000;

        public static const WEIGHT_LB_MAX_IN_G:int=181437;

        public static const WEIGHT_LB_MIN_IN_G:int=18144;

        public static const WHEEL_SIZE_1_MAX:int=3999;

        internal var _wheelSize1:int=1253;

        internal var _selectionMode:core.general.WheelSizeSelectionMode;

        internal var _tireSize:core.general.TireSize;

        internal var _speedUnit:String="kmh";
    }
}


