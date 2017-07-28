//package interfaces
//  class IAgpsSupported
package core.units.interfaces 
{
    public dynamic interface IAgpsSupported
    {
    }
}


//  class IBLEDeviceInfo
package core.units.interfaces 
{
    public dynamic interface IBLEDeviceInfo
    {
        function get deviceID():String;

        function set deviceID(arg1:String):void;

        function get dsHandler():String;

        function set dsHandler(arg1:String):void;

        function get localName():String;

        function set localName(arg1:String):void;

        function get primaryServiceUUID():String;

        function set primaryServiceUUID(arg1:String):void;
    }
}


//  class IBLESimplePairing
package core.units.interfaces 
{
    public dynamic interface IBLESimplePairing
    {
    }
}


//  class ICadenceTXBatteryStatus
package core.units.interfaces 
{
    public dynamic interface ICadenceTXBatteryStatus
    {
        function get cadenceTXBatteryStatus():Boolean;

        function set cadenceTXBatteryStatus(arg1:Boolean):void;
    }
}


//  class ICodingSettings
package core.units.interfaces 
{
    import core.settings.*;
    import core.units.*;
    
    public dynamic interface ICodingSettings
    {
        function decodeSettings(arg1:Object, arg2:core.units.Unit=null):core.settings.Settings;

        function encodeSettings(arg1:core.units.Unit):Array;
    }
}


//  class ICodingTotals
package core.units.interfaces 
{
    import core.totals.*;
    import core.units.*;
    
    public dynamic interface ICodingTotals
    {
        function decodeTotals(arg1:Array, arg2:core.units.Unit):core.totals.Totals;

        function encodeTotals(arg1:core.totals.Totals):Array;
    }
}


//  class ICodingUnitInformation
package core.units.interfaces 
{
    import core.units.*;
    
    public dynamic interface ICodingUnitInformation
    {
        function decodeUnitInformation(arg1:Object):core.units.Unit;
    }
}


//  class IDSFirmwareUpdateSupported
package core.units.interfaces 
{
    public dynamic interface IDSFirmwareUpdateSupported
    {
        function dockingStationType():String;
    }
}


//  class IDSTDeviceInfo
package core.units.interfaces 
{
    public dynamic interface IDSTDeviceInfo
    {
    }
}


//  class IDataToDecode
package core.units.interfaces 
{
    import __AS3__.vec.*;
    
    public dynamic interface IDataToDecode
    {
        function get activitiesToDecode():__AS3__.vec.Vector.<core.activities.Activity>;

        function set activitiesToDecode(arg1:__AS3__.vec.Vector.<core.activities.Activity>):void;

        function get tracksToDecode():__AS3__.vec.Vector.<core.route.Route>;

        function set tracksToDecode(arg1:__AS3__.vec.Vector.<core.route.Route>):void;
    }
}


//  class IDateCode
package core.units.interfaces 
{
    public dynamic interface IDateCode
    {
        function get dateCode():Date;

        function set dateCode(arg1:Date):void;
    }
}


//  class IFirmwareUpdateSupported
package core.units.interfaces 
{
    public dynamic interface IFirmwareUpdateSupported
    {
        function bleFirmwareUpdateSupported():Boolean;

        function firmwareUpdateSupported():Boolean;
    }
}


//  class IGhostRaceSupported
package core.units.interfaces 
{
    public dynamic interface IGhostRaceSupported
    {
        function get ghostRaceSupported():Boolean;

        function get ghostRaceGPSDataRequired():Boolean;
    }
}


//  class IHeartrateTXBatteryStatus
package core.units.interfaces 
{
    public dynamic interface IHeartrateTXBatteryStatus
    {
        function get heartrateTXBatteryStatus():Boolean;

        function set heartrateTXBatteryStatus(arg1:Boolean):void;
    }
}


//  class IIntensityZonesPercentage
package core.units.interfaces 
{
    public dynamic interface IIntensityZonesPercentage
    {
        function get intensityZone1PercentageStart():Number;

        function set intensityZone1PercentageStart(arg1:Number):void;

        function get intensityZone2PercentageStart():Number;

        function set intensityZone2PercentageStart(arg1:Number):void;

        function get intensityZone3PercentageStart():Number;

        function set intensityZone3PercentageStart(arg1:Number):void;

        function get intensityZone4PercentageEnd():Number;

        function set intensityZone4PercentageEnd(arg1:Number):void;

        function get intensityZone4PercentageStart():Number;

        function set intensityZone4PercentageStart(arg1:Number):void;

        function get intensityZonePercentageMin():Number;
    }
}


//  class ILogList
package core.units.interfaces 
{
    import __AS3__.vec.*;
    
    public dynamic interface ILogList
    {
        function get loadedLogs():__AS3__.vec.Vector.<core.activities.Activity>;

        function set loadedLogs(arg1:__AS3__.vec.Vector.<core.activities.Activity>):void;
    }
}


//  class ILogStatus
package core.units.interfaces 
{
    public dynamic interface ILogStatus
    {
        function get freePackages():int;

        function set freePackages(arg1:int):void;

        function get maxPackages():int;

        function set maxPackages(arg1:int):void;

        function get unitLogStatus():Boolean;

        function set unitLogStatus(arg1:Boolean):void;
    }
}


//  class ILogTime10Sec
package core.units.interfaces 
{
    public dynamic interface ILogTime10Sec
    {
        function get logTime10Sec():int;

        function set logTime10Sec(arg1:int):void;
    }
}


//  class ILogTime1Sec
package core.units.interfaces 
{
    public dynamic interface ILogTime1Sec
    {
        function get logTime1Sec():int;

        function set logTime1Sec(arg1:int):void;
    }
}


//  class ILogTime20Sec
package core.units.interfaces 
{
    public dynamic interface ILogTime20Sec
    {
        function get logTime20Sec():int;

        function set logTime20Sec(arg1:int):void;
    }
}


//  class ILogTime2Sec
package core.units.interfaces 
{
    public dynamic interface ILogTime2Sec
    {
        function get logTime2Sec():int;

        function set logTime2Sec(arg1:int):void;
    }
}


//  class ILogTime30Sec
package core.units.interfaces 
{
    public dynamic interface ILogTime30Sec
    {
        function get logTime30Sec():int;

        function set logTime30Sec(arg1:int):void;
    }
}


//  class ILogTime5Sec
package core.units.interfaces 
{
    public dynamic interface ILogTime5Sec
    {
        function get logTime5Sec():int;

        function set logTime5Sec(arg1:int):void;
    }
}


//  class IMemoryMapVersion
package core.units.interfaces 
{
    public dynamic interface IMemoryMapVersion
    {
        function get memoryMapVersion():String;

        function set memoryMapVersion(arg1:String):void;
    }
}


//  class INFCDeviceInfo
package core.units.interfaces 
{
    public dynamic interface INFCDeviceInfo
    {
        function get fifoBit():uint;

        function get readBlockDelay():uint;

        function get readDelay():uint;
    }
}


//  class INotificationEvent
package core.units.interfaces 
{
    import core.notification.*;
    
    public dynamic interface INotificationEvent
    {
        function get notificationEvent():core.notification.NotificationEvent;

        function set notificationEvent(arg1:core.notification.NotificationEvent):void;
    }
}


//  class IOnlyFinishedActivitiesLoadable
package core.units.interfaces 
{
    public dynamic interface IOnlyFinishedActivitiesLoadable
    {
    }
}


//  class IPointNavigationsList
package core.units.interfaces 
{
    import __AS3__.vec.*;
    import core.gps.*;
    
    public dynamic interface IPointNavigationsList
    {
        function get currentPointNavigation():core.gps.PointNavigation;

        function set currentPointNavigation(arg1:core.gps.PointNavigation):void;

        function get pointNavigationsVector():__AS3__.vec.Vector.<core.gps.PointNavigation>;

        function set pointNavigationsVector(arg1:__AS3__.vec.Vector.<core.gps.PointNavigation>):void;
    }
}


//  class IPowerZones7
package core.units.interfaces 
{
    public dynamic interface IPowerZones7
    {
        function get powerZone1Start():int;

        function set powerZone1Start(arg1:int):void;

        function get powerZone2Start():int;

        function set powerZone2Start(arg1:int):void;

        function get powerZone3Start():int;

        function set powerZone3Start(arg1:int):void;

        function get powerZone4Start():int;

        function set powerZone4Start(arg1:int):void;

        function get powerZone5Start():int;

        function set powerZone5Start(arg1:int):void;

        function get powerZone6Start():int;

        function set powerZone6Start(arg1:int):void;

        function get powerZone7End():int;

        function set powerZone7End(arg1:int):void;

        function get powerZone7Start():int;

        function set powerZone7Start(arg1:int):void;

        function get thresholdPower():int;

        function set thresholdPower(arg1:int):void;

        function calculatePowerZonesByThreshold():void;
    }
}


//  class IR3TXBatteryStatus
package core.units.interfaces 
{
    public dynamic interface IR3TXBatteryStatus
    {
        function get r3txBatteryStatus():Boolean;

        function set r3txBatteryStatus(arg1:Boolean):void;
    }
}


//  class ISettingsList
package core.units.interfaces 
{
    import __AS3__.vec.*;
    
    public dynamic interface ISettingsList
    {
        function get settingsList():__AS3__.vec.Vector.<core.settings.Settings>;

        function set settingsList(arg1:__AS3__.vec.Vector.<core.settings.Settings>):void;
    }
}


//  class ISleepScreen
package core.units.interfaces 
{
    import core.sleepScreen.*;
    
    public dynamic interface ISleepScreen
    {
        function set sleepScreen(arg1:core.sleepScreen.SleepScreen):void;

        function get sleepScreen():core.sleepScreen.SleepScreen;
    }
}


//  class ISpeedTXBatteryStatus
package core.units.interfaces 
{
    public dynamic interface ISpeedTXBatteryStatus
    {
        function get speedTXBatteryStatus():Boolean;

        function set speedTXBatteryStatus(arg1:Boolean):void;
    }
}


//  class ISportProfiles
package core.units.interfaces 
{
    import __AS3__.vec.*;
    import core.sportprofiles.*;
    import init.interfaces.*;
    
    public dynamic interface ISportProfiles
    {
        function get currentSportProfileIndex():uint;

        function set currentSportProfileIndex(arg1:uint):void;

        function get loadedSportProfiles():__AS3__.vec.Vector.<core.sportprofiles.Sportprofile>;

        function set loadedSportProfiles(arg1:__AS3__.vec.Vector.<core.sportprofiles.Sportprofile>):void;

        function get sportprofilesList():__AS3__.vec.Vector.<core.sportprofiles.Sportprofile>;

        function set sportprofilesList(arg1:__AS3__.vec.Vector.<core.sportprofiles.Sportprofile>):void;

        function get sportprofilesVectorlist():init.interfaces.IVectorList;

        function set sportprofilesVectorlist(arg1:init.interfaces.IVectorList):void;

        function addSportProfile(arg1:core.sportprofiles.Sportprofile):void;
    }
}


//  class IStravaSegmentsSupported
package core.units.interfaces 
{
    import core.strava.*;
    
    public dynamic interface IStravaSegmentsSupported
    {
        function get currentStravaSegment():core.strava.StravaSegment;

        function set currentStravaSegment(arg1:core.strava.StravaSegment):void;
    }
}


//  class ITotalsList
package core.units.interfaces 
{
    import __AS3__.vec.*;
    import core.totals.*;
    
    public dynamic interface ITotalsList
    {
        function get currentTotals():core.totals.Totals;

        function set currentTotals(arg1:core.totals.Totals):void;

        function get totalsVector():__AS3__.vec.Vector.<core.totals.Totals>;

        function set totalsVector(arg1:__AS3__.vec.Vector.<core.totals.Totals>):void;
    }
}


//  class ITrackList
package core.units.interfaces 
{
    import init.interfaces.*;
    
    public dynamic interface ITrackList
    {
        function get loadedTracks():init.interfaces.IVectorList;

        function set loadedTracks(arg1:init.interfaces.IVectorList):void;

        function get trackList():init.interfaces.IVectorList;

        function set trackList(arg1:init.interfaces.IVectorList):void;
    }
}


//  class ITrainingsList
package core.units.interfaces 
{
    import __AS3__.vec.*;
    import init.interfaces.*;
    
    public dynamic interface ITrainingsList
    {
        function get supportMultipleTrainings():Boolean;

        function get trainingsList():__AS3__.vec.Vector.<core.training.Training>;

        function set trainingsList(arg1:__AS3__.vec.Vector.<core.training.Training>):void;

        function get trainingsOnDeviceList():__AS3__.vec.Vector.<core.training.Training>;

        function set trainingsOnDeviceList(arg1:__AS3__.vec.Vector.<core.training.Training>):void;

        function get trainingsToDelete():__AS3__.vec.Vector.<core.training.Training>;

        function set trainingsToDelete(arg1:__AS3__.vec.Vector.<core.training.Training>):void;

        function get trainingsVectorList():init.interfaces.IVectorList;
    }
}


//  class IUSBDeviceInfo
package core.units.interfaces 
{
    public dynamic interface IUSBDeviceInfo
    {
    }
}


//  class IUnitBatteryStatus
package core.units.interfaces 
{
    public dynamic interface IUnitBatteryStatus
    {
        function get unitBatteryStatus():Boolean;

        function set unitBatteryStatus(arg1:Boolean):void;
    }
}


//  class IUnitSamplingRate
package core.units.interfaces 
{
    public dynamic interface IUnitSamplingRate
    {
        function getSamplingRates():Array;

        function getSamplingRateIds():Array;

        function getSamplingRate(arg1:Number):Number;

        function getSamplingRateId(arg1:Number):Number;
    }
}


