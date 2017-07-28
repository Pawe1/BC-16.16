//package units
//  package interfaces
//    class IAgpsSupported
package core.units.interfaces 
{
    public dynamic interface IAgpsSupported
    {
    }
}


//    class IBLEDeviceInfo
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


//    class IBLESimplePairing
package core.units.interfaces 
{
    public dynamic interface IBLESimplePairing
    {
    }
}


//    class ICadenceTXBatteryStatus
package core.units.interfaces 
{
    public dynamic interface ICadenceTXBatteryStatus
    {
        function get cadenceTXBatteryStatus():Boolean;

        function set cadenceTXBatteryStatus(arg1:Boolean):void;
    }
}


//    class ICodingSettings
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


//    class ICodingTotals
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


//    class ICodingUnitInformation
package core.units.interfaces 
{
    import core.units.*;
    
    public dynamic interface ICodingUnitInformation
    {
        function decodeUnitInformation(arg1:Object):core.units.Unit;
    }
}


//    class IDSFirmwareUpdateSupported
package core.units.interfaces 
{
    public dynamic interface IDSFirmwareUpdateSupported
    {
        function dockingStationType():String;
    }
}


//    class IDSTDeviceInfo
package core.units.interfaces 
{
    public dynamic interface IDSTDeviceInfo
    {
    }
}


//    class IDataToDecode
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


//    class IDateCode
package core.units.interfaces 
{
    public dynamic interface IDateCode
    {
        function get dateCode():Date;

        function set dateCode(arg1:Date):void;
    }
}


//    class IFirmwareUpdateSupported
package core.units.interfaces 
{
    public dynamic interface IFirmwareUpdateSupported
    {
        function bleFirmwareUpdateSupported():Boolean;

        function firmwareUpdateSupported():Boolean;
    }
}


//    class IGhostRaceSupported
package core.units.interfaces 
{
    public dynamic interface IGhostRaceSupported
    {
        function get ghostRaceSupported():Boolean;

        function get ghostRaceGPSDataRequired():Boolean;
    }
}


//    class IHeartrateTXBatteryStatus
package core.units.interfaces 
{
    public dynamic interface IHeartrateTXBatteryStatus
    {
        function get heartrateTXBatteryStatus():Boolean;

        function set heartrateTXBatteryStatus(arg1:Boolean):void;
    }
}


//    class IIntensityZonesPercentage
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


//    class ILogList
package core.units.interfaces 
{
    import __AS3__.vec.*;
    
    public dynamic interface ILogList
    {
        function get loadedLogs():__AS3__.vec.Vector.<core.activities.Activity>;

        function set loadedLogs(arg1:__AS3__.vec.Vector.<core.activities.Activity>):void;
    }
}


//    class ILogStatus
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


//    class ILogTime10Sec
package core.units.interfaces 
{
    public dynamic interface ILogTime10Sec
    {
        function get logTime10Sec():int;

        function set logTime10Sec(arg1:int):void;
    }
}


//    class ILogTime1Sec
package core.units.interfaces 
{
    public dynamic interface ILogTime1Sec
    {
        function get logTime1Sec():int;

        function set logTime1Sec(arg1:int):void;
    }
}


//    class ILogTime20Sec
package core.units.interfaces 
{
    public dynamic interface ILogTime20Sec
    {
        function get logTime20Sec():int;

        function set logTime20Sec(arg1:int):void;
    }
}


//    class ILogTime2Sec
package core.units.interfaces 
{
    public dynamic interface ILogTime2Sec
    {
        function get logTime2Sec():int;

        function set logTime2Sec(arg1:int):void;
    }
}


//    class ILogTime30Sec
package core.units.interfaces 
{
    public dynamic interface ILogTime30Sec
    {
        function get logTime30Sec():int;

        function set logTime30Sec(arg1:int):void;
    }
}


//    class ILogTime5Sec
package core.units.interfaces 
{
    public dynamic interface ILogTime5Sec
    {
        function get logTime5Sec():int;

        function set logTime5Sec(arg1:int):void;
    }
}


//    class IMemoryMapVersion
package core.units.interfaces 
{
    public dynamic interface IMemoryMapVersion
    {
        function get memoryMapVersion():String;

        function set memoryMapVersion(arg1:String):void;
    }
}


//    class INFCDeviceInfo
package core.units.interfaces 
{
    public dynamic interface INFCDeviceInfo
    {
        function get fifoBit():uint;

        function get readBlockDelay():uint;

        function get readDelay():uint;
    }
}


//    class INotificationEvent
package core.units.interfaces 
{
    import core.notification.*;
    
    public dynamic interface INotificationEvent
    {
        function get notificationEvent():core.notification.NotificationEvent;

        function set notificationEvent(arg1:core.notification.NotificationEvent):void;
    }
}


//    class IOnlyFinishedActivitiesLoadable
package core.units.interfaces 
{
    public dynamic interface IOnlyFinishedActivitiesLoadable
    {
    }
}


//    class IPointNavigationsList
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


//    class IPowerZones7
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


//    class IR3TXBatteryStatus
package core.units.interfaces 
{
    public dynamic interface IR3TXBatteryStatus
    {
        function get r3txBatteryStatus():Boolean;

        function set r3txBatteryStatus(arg1:Boolean):void;
    }
}


//    class ISettingsList
package core.units.interfaces 
{
    import __AS3__.vec.*;
    
    public dynamic interface ISettingsList
    {
        function get settingsList():__AS3__.vec.Vector.<core.settings.Settings>;

        function set settingsList(arg1:__AS3__.vec.Vector.<core.settings.Settings>):void;
    }
}


//    class ISleepScreen
package core.units.interfaces 
{
    import core.sleepScreen.*;
    
    public dynamic interface ISleepScreen
    {
        function set sleepScreen(arg1:core.sleepScreen.SleepScreen):void;

        function get sleepScreen():core.sleepScreen.SleepScreen;
    }
}


//    class ISpeedTXBatteryStatus
package core.units.interfaces 
{
    public dynamic interface ISpeedTXBatteryStatus
    {
        function get speedTXBatteryStatus():Boolean;

        function set speedTXBatteryStatus(arg1:Boolean):void;
    }
}


//    class ISportProfiles
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


//    class IStravaSegmentsSupported
package core.units.interfaces 
{
    import core.strava.*;
    
    public dynamic interface IStravaSegmentsSupported
    {
        function get currentStravaSegment():core.strava.StravaSegment;

        function set currentStravaSegment(arg1:core.strava.StravaSegment):void;
    }
}


//    class ITotalsList
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


//    class ITrackList
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


//    class ITrainingsList
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


//    class IUSBDeviceInfo
package core.units.interfaces 
{
    public dynamic interface IUSBDeviceInfo
    {
    }
}


//    class IUnitBatteryStatus
package core.units.interfaces 
{
    public dynamic interface IUnitBatteryStatus
    {
        function get unitBatteryStatus():Boolean;

        function set unitBatteryStatus(arg1:Boolean):void;
    }
}


//    class IUnitSamplingRate
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


//  class Unit
package core.units 
{
    import __AS3__.vec.*;
    import com.logging.*;
    import core.activities.*;
    import core.general.*;
    import core.general.interfaces.*;
    import core.settings.*;
    import core.training.*;
    import core.units.interfaces.*;
    import database.*;
    import flash.events.*;
    import init.*;
    import init.interfaces.*;
    import mx.events.*;
    
    public class Unit extends flash.events.EventDispatcher implements core.units.interfaces.ISettingsList, core.general.interfaces.IDatabase, core.general.interfaces.ISynchronisable
    {
        public function Unit(arg1:flash.events.IEventDispatcher=null)
        {
            _loadedMemories = new __AS3__.vec.Vector.<core.activities.Activity>();
            pointNavigationsVectorList = init.BackendInitializer.getInstance().createVectorList();
            _settingsList = new __AS3__.vec.Vector.<core.settings.Settings>();
            settingsVectorlist = init.BackendInitializer.getInstance().createVectorList();
            totalsVectorList = init.BackendInitializer.getInstance().createVectorList();
            super(arg1);
            com.logging.ErrorLogging.getInstance().addTarget(this);
            addEventListener("settingsChanged", onSettingsChanged, false, 0, true);
            return;
        }

        public function generateDBInsert():Array
        {
            var loc3:*=null;
            var loc1:*=null;
            var loc2:*=null;
            if (unitId > 0) 
            {
                return getUpdateStatement();
            }
            loc3 = "unitId, GUID, modificationDate, isDeleted, type, serialNumber, softwareRevision, memoryMapVersion, externalName, defaultContrast, bleDeviceId, bleLocalName, bleServiceUUID, bleFirmwareVersion";
            loc1 = this.unitId > 0 ? "\"" + this.unitId + "\"," : "NULL,";
            loc1 = loc1 + ("\"" + GUID + "\"," + "\"" + modificationDate + "\"," + (isDeleted ? 1 : 0) + ", " + "\"" + type + "\"," + " \"" + serialNumber + "\"," + " \"" + softwareRevision + "\"," + " \"" + (this is core.units.interfaces.IMemoryMapVersion ? (this as core.units.interfaces.IMemoryMapVersion).memoryMapVersion : 0) + "\"," + " \"" + externalName + "\"," + " \"" + defaultContrast + "\"," + " \"" + _bleDeviceId + "\"," + " \"" + _bleLocalName + "\"," + " \"" + _bleServiceUUID + "\"," + " \"" + _bleFirmwareVersion + "\"");
            loc2 = new database.DCSQLStatement();
            loc2.text = "insert or replace into Unit (" + loc3 + ") values (" + loc1 + ")";
            return [loc2];
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

        public function get bikeCount():int
        {
            return 0;
        }

        internal function getUpdateStatement():Array
        {
            var loc2:*=[];
            loc2.push("GUID = \"" + GUID + "\"");
            loc2.push("modificationDate = \"" + modificationDate + "\"");
            loc2.push("isDeleted = " + (isDeleted ? 1 : 0));
            loc2.push("type = \"" + type.toString() + "\"");
            loc2.push("serialNumber = \"" + serialNumber + "\"");
            loc2.push("softwareRevision = \"" + softwareRevision + "\"");
            loc2.push("memoryMapVersion = \"" + (this is core.units.interfaces.IMemoryMapVersion ? (this as core.units.interfaces.IMemoryMapVersion).memoryMapVersion : 0) + "\"");
            loc2.push("externalName = \"" + externalName + "\"");
            loc2.push("defaultContrast = \"" + defaultContrast + "\"");
            if (!ignoreBLEDeviceIdOnInsert) 
            {
                loc2.push("bleDeviceId = \"" + _bleDeviceId + "\"");
            }
            loc2.push("bleLocalName = \"" + _bleLocalName + "\"");
            loc2.push("bleServiceUUID = \"" + _bleServiceUUID + "\"");
            loc2.push("bleFirmwareVersion = \"" + _bleFirmwareVersion + "\"");
            var loc1:*=new database.DCSQLStatement();
            loc1.text = "UPDATE Unit SET " + loc2.join(", ") + " WHERE unitId = " + unitId;
            return [loc1];
        }

        public function get bleFirmwareVersion():String
        {
            return _bleFirmwareVersion;
        }

        public function set bleFirmwareVersion(arg1:String):void
        {
            _bleFirmwareVersion = arg1;
            return;
        }

        public function getInsertStatement():String
        {
            var loc1:*=generateDBInsert();
            var loc2:*=loc1[0] as database.DCSQLStatement;
            return loc2.text;
        }

        public function get currentSettings():core.settings.Settings
        {
            return _currentSettings;
        }

        public function set currentSettings(arg1:core.settings.Settings):void
        {
            if (arg1 != _currentSettings) 
            {
                _currentSettings = arg1;
                dispatchEvent(new flash.events.Event("currentSettingsChange"));
            }
            return;
        }

        public function selectPrimaryKeyFromGUID():String
        {
            return "SELECT unitId FROM Unit where GUID = \'" + GUID + "\'";
        }

        public function get currentTrainingProgram():core.training.Training
        {
            return _currentTrainingProgram;
        }

        public function set currentTrainingProgram(arg1:core.training.Training):void
        {
            _currentTrainingProgram = arg1;
            return;
        }

        public function generateDBSelect():Array
        {
            return null;
        }

        public function get defaultContrast():int
        {
            return _defaultContrast;
        }

        public function set defaultContrast(arg1:int):void
        {
            if (arg1 != _defaultContrast) 
            {
                _defaultContrast = arg1;
                dispatchEvent(new flash.events.Event("defaultContrastChange"));
            }
            return;
        }

        public function get deviceGUID():Boolean
        {
            return true;
        }

        public function getLoggingInfo():String
        {
            return "\t-unitId " + unitId.toString() + "\t-type " + type + "\t-serialNumber " + serialNumber + "\t-externalName " + externalName;
        }

        public function get externalName():String
        {
            if (_externalName == null || _externalName == "" || _externalName == "null") 
            {
                _externalName = core.general.UnitType.formatUnit(type);
            }
            return _externalName;
        }

        public function set externalName(arg1:String):void
        {
            if (arg1 != _externalName) 
            {
                _externalName = arg1;
                dispatchEvent(new flash.events.Event("externalNameChange"));
            }
            return;
        }

        public override function toString():String
        {
            return "[Unit implements ISettingsList, IGenerateSUF, IDatabase, ISportProfiles]";
        }

        internal function onSettingsChanged(arg1:flash.events.Event):void
        {
            settingsVectorlist = init.BackendInitializer.getInstance().createVectorList(_settingsList);
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

        public static function getUnitsByType(arg1:Array):String
        {
            return "SELECT distinct * FROM Unit WHERE type in (\'" + arg1.join("\',\'") + "\')";
        }

        public function get isOnline():Boolean
        {
            return _isOnline;
        }

        public function set isOnline(arg1:Boolean):void
        {
            if (arg1 != _isOnline) 
            {
                _isOnline = arg1;
                dispatchEvent(new flash.events.Event("isOnlineChange"));
            }
            return;
        }

        public static function generateDBCreateTable(arg1:uint):database.DatabaseTable
        {
            var loc1:*=null;
            var loc2:*=arg1;
            while (400 === loc2) 
            {
                DB_TABLE_400 = new database.DatabaseTable("Unit");
                DB_TABLE_400.addColumns([["unitId", "INTEGER", false, true, true], ["GUID", "VARCHAR UNIQUE", false], ["modificationDate", "NUMERIC", true], ["isDeleted", "BOOL", true], ["type", "VARCHAR", false], ["serialNumber", "VARCHAR", false], ["softwareRevision", "VARCHAR", true], ["memoryMapVersion", "VARCHAR", true], ["externalName", "VARCHAR", false], ["defaultContrast", "VARCHAR", true], ["bleDeviceId", "VARCHAR", true], ["bleLocalName", "VARCHAR", true], ["bleServiceUUID", "VARCHAR", true], ["emptyField1", "VARCHAR", true], ["emptyField2", "VARCHAR", true]]);
                loc1 = DB_TABLE_400;
            }
        }

        public function get loadedMemories():__AS3__.vec.Vector.<core.activities.Activity>
        {
            return _loadedMemories;
        }

        public function set loadedMemories(arg1:__AS3__.vec.Vector.<core.activities.Activity>):void
        {
            if (arg1 != _loadedMemories) 
            {
                _loadedMemories = arg1;
                dispatchEvent(new flash.events.Event("loadedMemoriesChange"));
            }
            return;
        }

        public static function generateDBCreateTrigger(arg1:uint):String
        {
            var loc1:*=null;
            var loc2:*=arg1;
            while (400 === loc2) 
            {
                loc1 = "CREATE TRIGGER IF NOT EXISTS UnitTrigger AFTER DELETE ON Unit FOR EACH ROW BEGIN DELETE FROM Settings WHERE Settings.unitGUID = OLD.GUID; DELETE FROM Totals WHERE Totals.unitGUID = OLD.GUID; DELETE FROM Training WHERE Training.unitGUID = OLD.GUID;END";
            }
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

        public static function prepareDelete(arg1:String):String
        {
            var loc1:*=new Date().time;
            var loc2:*="UPDATE Unit SET isDeleted = true, modificationDate = \'" + loc1 + "\' WHERE GUID = \'" + arg1 + "\'";
            return loc2;
        }

        public function get pointNavigationsVectorList():init.interfaces.IVectorList
        {
            return this.pointNavigationsVectorList;
        }

        public function set pointNavigationsVectorList(arg1:init.interfaces.IVectorList):void
        {
            var loc1:*=this.pointNavigationsVectorList;
            if (loc1 !== arg1) 
            {
                this.pointNavigationsVectorList = arg1;
                if (this.hasEventListener("propertyChange")) 
                {
                    this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "pointNavigationsVectorList", loc1, arg1));
                }
            }
            return;
        }

        public static function generatePrepareDeleteUnitTrigger():String
        {
            var loc1:*=new Date().time;
            var loc2:*="CREATE TRIGGER IF NOT EXISTS UnitDeleted AFTER UPDATE OF isDeleted ON Unit BEGIN UPDATE Settings SET isDeleted = true, modificationDate = \'" + loc1 + "\' WHERE Settings.unitGUID = OLD.GUID and NEW.isDeleted = true; " + "UPDATE Totals SET isDeleted = true, modificationDate = \'" + loc1 + "\' WHERE Totals.unitGUID = OLD.GUID and NEW.isDeleted = true; " + "UPDATE Training SET isDeleted = true, modificationDate = \'" + loc1 + "\' WHERE Training.unitGUID = OLD.GUID and NEW.isDeleted = true; " + "END;";
            return loc2;
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
                dispatchEvent(new flash.events.Event("serialNumberChange"));
            }
            return;
        }

        public static function generateXML(arg1:core.units.Unit):XML
        {
            var loc1:*=new XML("<Device/>");
            loc1.GUID = arg1.GUID;
            loc1.modificationDate = arg1.modificationDate;
            loc1.type = arg1.type.toString();
            loc1.serialNumber = arg1.serialNumber;
            loc1.softwareRevision = arg1.softwareRevision;
            loc1.externalName = arg1.externalName;
            loc1.defaultContrast = arg1.defaultContrast;
            if (arg1 is core.units.interfaces.IMemoryMapVersion) 
            {
                loc1.memoryMapVersion = (arg1 as core.units.interfaces.IMemoryMapVersion).memoryMapVersion;
            }
            if (arg1 is core.units.interfaces.IFirmwareUpdateSupported && (arg1 as core.units.interfaces.IFirmwareUpdateSupported).bleFirmwareUpdateSupported()) 
            {
                loc1.bleFirmwareVersion = arg1.bleFirmwareVersion;
            }
            return loc1;
        }

        public function get settingsList():__AS3__.vec.Vector.<core.settings.Settings>
        {
            return _settingsList;
        }

        public function set settingsList(arg1:__AS3__.vec.Vector.<core.settings.Settings>):void
        {
            if (arg1 != _settingsList) 
            {
                _settingsList = arg1;
                dispatchEvent(new flash.events.Event("settingsListChange"));
            }
            return;
        }

        public static function fromXML(arg1:XML):core.units.Unit
        {
            var loc1:*=core.units.UnitFactory.createUnitFromType(core.general.UnitType.fromString(arg1.type.text()));
            loc1.GUID = arg1.GUID;
            loc1.modificationDate = arg1.modificationDate;
            loc1.serialNumber = arg1.serialNumber;
            loc1.softwareRevision = arg1.softwareRevision;
            loc1.externalName = arg1.externalName;
            loc1.defaultContrast = arg1.defaultContrast;
            if (loc1 is core.units.interfaces.IMemoryMapVersion) 
            {
                (loc1 as core.units.interfaces.IMemoryMapVersion).memoryMapVersion = arg1.memoryMapVersion;
            }
            if (loc1 is core.units.interfaces.IFirmwareUpdateSupported && (loc1 as core.units.interfaces.IFirmwareUpdateSupported).bleFirmwareUpdateSupported()) 
            {
                loc1.bleFirmwareVersion = arg1.bleFirmwareVersion;
            }
            return loc1;
        }

        public function get settingsVectorlist():init.interfaces.IVectorList
        {
            return this.settingsVectorlist;
        }

        public function set settingsVectorlist(arg1:init.interfaces.IVectorList):void
        {
            var loc1:*=this.settingsVectorlist;
            if (loc1 !== arg1) 
            {
                this.settingsVectorlist = arg1;
                if (this.hasEventListener("propertyChange")) 
                {
                    this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "settingsVectorlist", loc1, arg1));
                }
            }
            return;
        }

        public static function deleteUnitByGUID(arg1:String):String
        {
            return "DELETE FROM Unit WHERE GUID = \'" + arg1 + "\'";
        }

        public function get softwareRevision():String
        {
            return _softwareRevision;
        }

        public function set softwareRevision(arg1:String):void
        {
            if (arg1 != _softwareRevision) 
            {
                _softwareRevision = arg1;
                dispatchEvent(new flash.events.Event("softwareRevisionChange"));
            }
            return;
        }

        public static function selectAll():String
        {
            return "SELECT * FROM Unit where isDeleted = false ORDER BY externalName COLLATE NOCASE";
        }

        public function get totalsVectorList():init.interfaces.IVectorList
        {
            return this.totalsVectorList;
        }

        public function set totalsVectorList(arg1:init.interfaces.IVectorList):void
        {
            var loc1:*=this.totalsVectorList;
            if (loc1 !== arg1) 
            {
                this.totalsVectorList = arg1;
                if (this.hasEventListener("propertyChange")) 
                {
                    this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "totalsVectorList", loc1, arg1));
                }
            }
            return;
        }

        public static function getUnitCount():String
        {
            return "SELECT count(unitId) as numDevices FROM Unit WHERE isDeleted = false";
        }

        public function get type():core.general.UnitType
        {
            return _type;
        }

        public function set type(arg1:core.general.UnitType):void
        {
            if (arg1 != _type) 
            {
                _type = arg1;
            }
            return;
        }

        public function get unitId():int
        {
            return _unitId;
        }

        public function set unitId(arg1:int):void
        {
            if (arg1 != _unitId) 
            {
                _unitId = arg1;
                dispatchEvent(new flash.events.Event("currentIdChange"));
            }
            return;
        }

        public function fromDB(arg1:Object):void
        {
            GUID = arg1.GUID;
            modificationDate = arg1.modificationDate;
            unitId = arg1.unitId;
            serialNumber = arg1.serialNumber;
            softwareRevision = arg1.softwareRevision;
            isDeleted = arg1.isDeleted;
            type = core.general.UnitType.fromString(arg1.type);
            if (this is core.units.interfaces.IBLEDeviceInfo) 
            {
                (this as core.units.interfaces.IBLEDeviceInfo).deviceID = arg1["bleDeviceId"];
                (this as core.units.interfaces.IBLEDeviceInfo).localName = arg1["bleLocalName"];
            }
            if (this is core.units.interfaces.IMemoryMapVersion) 
            {
                (this as core.units.interfaces.IMemoryMapVersion).memoryMapVersion = arg1.memoryMapVersion;
            }
            externalName = arg1.externalName;
            defaultContrast = parseInt(arg1.defaultContrast);
            if (this is core.units.interfaces.IFirmwareUpdateSupported && (this as core.units.interfaces.IFirmwareUpdateSupported).bleFirmwareUpdateSupported) 
            {
                bleFirmwareVersion = arg1["bleFirmwareVersion"];
            }
            return;
        }

        public function fromSUF(arg1:XML):void
        {
            dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 10060, "Unit > fromSUF: Abstract function, please override!"));
            return;
        }

        public function generateDBDelete():Array
        {
            var loc2:*=[];
            var loc1:*=new database.DCSQLStatement();
            loc1.text = "delete from Unit where Unit.unitId = " + this.unitId;
            loc2.push(loc1);
            return loc2;
        }

        public static const TOTAL_REMOVED:String="totalRemoved";

        public static const col_GUID:String="GUID";

        public static const CURRENT_SETTINGS_CHANGE:String="currentSettingsChange";

        public static const col_bleFirmwareVersion:String="bleFirmwareVersion";

        public static const col_bleLocalName:String="bleLocalName";

        public static const col_bleServiceUUID:String="bleServiceUUID";

        public static const col_bleDeviceId:String="bleDeviceId";

        public static const col_defaultContrast:String="defaultContrast";

        public static const col_externalName:String="externalName";

        public static const col_isDeleted:String="isDeleted";

        public static const col_memoryMapVersion:String="memoryMapVersion";

        public static const col_modificationDate:String="modificationDate";

        public static const col_serialNumber:String="serialNumber";

        public static const TOTAL_ADDED:String="totalAdded";

        public static const col_type:String="type";

        public static const col_unitId:String="unitId";

        public static const table_name:String="Unit";

        public static const POINT_NAVIGATIONS_CHANGED:String="pointNavigationsChanged";

        public static const SETTINGS_CHANGED:String="settingsChanged";

        public static const SPORTPROFILES_CHANGED:String="sportprofilesChanged";

        public static const TOTALS_CHANGED:String="totalsChanged";

        public static const col_softwareRevision:String="softwareRevision";

        internal var _GUID:String="";

        internal var _bleFirmwareVersion:String="";

        internal var _currentSettings:core.settings.Settings;

        internal var _currentTrainingProgram:core.training.Training;

        internal var _defaultContrast:int;

        internal var _externalName:String;

        internal var _isDeleted:Boolean=false;

        internal var _isOnline:Boolean;

        internal var _loadedMemories:__AS3__.vec.Vector.<core.activities.Activity>;

        internal var _modificationDate:Number=0;

        internal var pointNavigationsVectorList:init.interfaces.IVectorList;

        internal var _serialNumber:String="";

        internal var _settingsList:__AS3__.vec.Vector.<core.settings.Settings>;

        internal var settingsVectorlist:init.interfaces.IVectorList;

        internal var _softwareRevision:String="";

        internal var totalsVectorList:init.interfaces.IVectorList;

        protected var _type:core.general.UnitType;

        protected var _bleServiceUUID:String="";

        protected var _bleLocalName:String="";

        public var ignoreBLEDeviceIdOnInsert:Boolean=false;

        public static var DB_TABLE_400:database.DatabaseTable;

        public static var DB_TABLE_500:database.DatabaseTable;

        public static var DB_TABLE_510:database.DatabaseTable;

        public static var DB_TABLE_520:database.DatabaseTable;

        internal var _unitId:int;

        protected var _bleDeviceId:String="";
    }
}


//  class UnitBC1009
package core.units 
{
    import core.general.*;
    
    public class UnitBC1009 extends core.units.UnitTopline2009
    {
        public function UnitBC1009()
        {
            super();
            type = core.general.UnitType.BC1009;
            return;
        }

        public override function get bikeCount():int
        {
            return 1;
        }

        public override function get deviceGUID():Boolean
        {
            return false;
        }

        public override function toString():String
        {
            return "[UnitBC1009 extends UnitTopline2009]";
        }
    }
}


//  class UnitBC1009STS
package core.units 
{
    import core.general.*;
    
    public class UnitBC1009STS extends core.units.UnitTopline2009
    {
        public function UnitBC1009STS()
        {
            super();
            type = core.general.UnitType.BC1009STS;
            return;
        }

        public override function get bikeCount():int
        {
            return 1;
        }

        public override function get deviceGUID():Boolean
        {
            return false;
        }

        public override function toString():String
        {
            return "[UnitBC1009STS extends UnitTopline2009 implements ISpeedTXBatteryStatus]";
        }
    }
}


//  class UnitBC1212
package core.units 
{
    import core.general.*;
    
    public class UnitBC1212 extends core.units.UnitTopline2012
    {
        public function UnitBC1212()
        {
            super();
            type = core.general.UnitType.BC1212;
            return;
        }

        public override function get bikeCount():int
        {
            return 1;
        }

        public override function get deviceGUID():Boolean
        {
            return false;
        }

        public override function toString():String
        {
            return "[UnitBC1212 extends UnitTopline2012]";
        }
    }
}


//  class UnitBC1212STS
package core.units 
{
    import core.general.*;
    
    public class UnitBC1212STS extends core.units.UnitTopline2012
    {
        public function UnitBC1212STS()
        {
            super();
            type = core.general.UnitType.BC1212STS;
            return;
        }

        public override function get bikeCount():int
        {
            return 1;
        }

        public override function get deviceGUID():Boolean
        {
            return false;
        }

        public override function toString():String
        {
            return "[UnitBC1212STS extends UnitTopline2012]";
        }
    }
}


//  class UnitBC1412
package core.units 
{
    import core.general.*;
    
    public class UnitBC1412 extends core.units.UnitTopline2012
    {
        public function UnitBC1412()
        {
            super();
            type = core.general.UnitType.BC1412;
            return;
        }

        public override function get bikeCount():int
        {
            return 1;
        }

        public override function get deviceGUID():Boolean
        {
            return false;
        }

        public override function toString():String
        {
            return "[UnitBC1412 extends UnitTopline2012]";
        }
    }
}


//  class UnitBC1416
package core.units 
{
    import core.general.*;
    import core.sleepScreen.*;
    import core.units.interfaces.*;
    
    public class UnitBC1416 extends core.units.UnitTopline2016 implements core.units.interfaces.INFCDeviceInfo, core.units.interfaces.ISleepScreen
    {
        public function UnitBC1416()
        {
            super();
            type = core.general.UnitType.BC1416;
            return;
        }

        public override function get bikeCount():int
        {
            return 1;
        }

        public function get fifoBit():uint
        {
            return 16;
        }

        public function get readBlockDelay():uint
        {
            return 18;
        }

        public function get readDelay():uint
        {
            return 6;
        }

        public function get sleepScreen():core.sleepScreen.SleepScreen
        {
            return _sleepScreen;
        }

        public function set sleepScreen(arg1:core.sleepScreen.SleepScreen):void
        {
            _sleepScreen = arg1;
            return;
        }

        public static const FIFO_BIT:uint=16;

        public static const READ_BLOCK_DELAY:uint=18;

        public static const READ_DELAY:uint=6;

        internal var _sleepScreen:core.sleepScreen.SleepScreen;
    }
}


//  class UnitBC1416STS
package core.units 
{
    import core.general.*;
    import core.sleepScreen.*;
    import core.units.interfaces.*;
    
    public class UnitBC1416STS extends core.units.UnitTopline2016 implements core.units.interfaces.INFCDeviceInfo, core.units.interfaces.ISleepScreen
    {
        public function UnitBC1416STS()
        {
            super();
            type = core.general.UnitType.BC1416STS;
            return;
        }

        public override function get bikeCount():int
        {
            return 1;
        }

        public function get fifoBit():uint
        {
            return 16;
        }

        public function get readBlockDelay():uint
        {
            return 18;
        }

        public function get readDelay():uint
        {
            return 6;
        }

        public function get sleepScreen():core.sleepScreen.SleepScreen
        {
            return _sleepScreen;
        }

        public function set sleepScreen(arg1:core.sleepScreen.SleepScreen):void
        {
            _sleepScreen = arg1;
            return;
        }

        public static const FIFO_BIT:uint=16;

        public static const READ_BLOCK_DELAY:uint=18;

        public static const READ_DELAY:uint=6;

        internal var _sleepScreen:core.sleepScreen.SleepScreen;
    }
}


//  class UnitBC1609
package core.units 
{
    import core.general.*;
    
    public class UnitBC1609 extends core.units.UnitTopline2009
    {
        public function UnitBC1609()
        {
            super();
            type = core.general.UnitType.BC1609;
            return;
        }

        public override function get bikeCount():int
        {
            return 2;
        }

        public override function get deviceGUID():Boolean
        {
            return false;
        }

        public override function toString():String
        {
            return "[UnitBC1609 extends UnitTopline2009]";
        }
    }
}


//  class UnitBC1609STS
package core.units 
{
    import core.general.*;
    
    public class UnitBC1609STS extends core.units.UnitTopline2009
    {
        public function UnitBC1609STS()
        {
            super();
            type = core.general.UnitType.BC1609STS;
            return;
        }

        public override function get bikeCount():int
        {
            return 2;
        }

        public override function get deviceGUID():Boolean
        {
            return false;
        }

        public override function toString():String
        {
            return "[UnitBC1609STS extends UnitTopline2009]";
        }
    }
}


//  class UnitBC1612
package core.units 
{
    import core.general.*;
    
    public class UnitBC1612 extends core.units.UnitTopline2012
    {
        public function UnitBC1612()
        {
            super();
            type = core.general.UnitType.BC1612;
            return;
        }

        public override function get bikeCount():int
        {
            return 2;
        }

        public override function toString():String
        {
            return "[UnitBC1612 extends UnitTopline2012]";
        }
    }
}


//  class UnitBC1612STS
package core.units 
{
    import core.general.*;
    
    public class UnitBC1612STS extends core.units.UnitTopline2012
    {
        public function UnitBC1612STS()
        {
            super();
            type = core.general.UnitType.BC1612STS;
            return;
        }

        public override function get bikeCount():int
        {
            return 2;
        }

        public override function get deviceGUID():Boolean
        {
            return false;
        }

        public override function toString():String
        {
            return "[UnitBC1612STS extends UnitTopline2012]";
        }
    }
}


//  class UnitBC1616
package core.units 
{
    import core.general.*;
    import core.sleepScreen.*;
    import core.units.interfaces.*;
    
    public class UnitBC1616 extends core.units.UnitTopline2016 implements core.units.interfaces.INFCDeviceInfo, core.units.interfaces.ISleepScreen
    {
        public function UnitBC1616()
        {
            super();
            type = core.general.UnitType.BC1616;
            return;
        }

        public override function get bikeCount():int
        {
            return 1;
        }

        public function get fifoBit():uint
        {
            return 16;
        }

        public function get readBlockDelay():uint
        {
            return 18;
        }

        public function get readDelay():uint
        {
            return 6;
        }

        public function get sleepScreen():core.sleepScreen.SleepScreen
        {
            return _sleepScreen;
        }

        public function set sleepScreen(arg1:core.sleepScreen.SleepScreen):void
        {
            _sleepScreen = arg1;
            return;
        }

        public static const FIFO_BIT:uint=16;

        public static const READ_BLOCK_DELAY:uint=18;

        public static const READ_DELAY:uint=6;

        internal var _sleepScreen:core.sleepScreen.SleepScreen;
    }
}


//  class UnitBC1616STS
package core.units 
{
    import core.general.*;
    import core.sleepScreen.*;
    import core.units.interfaces.*;
    
    public class UnitBC1616STS extends core.units.UnitTopline2016 implements core.units.interfaces.INFCDeviceInfo, core.units.interfaces.ISleepScreen
    {
        public function UnitBC1616STS()
        {
            super();
            type = core.general.UnitType.BC1616STS;
            return;
        }

        public override function get bikeCount():int
        {
            return 1;
        }

        public function get fifoBit():uint
        {
            return 16;
        }

        public function get readBlockDelay():uint
        {
            return 18;
        }

        public function get readDelay():uint
        {
            return 6;
        }

        public function get sleepScreen():core.sleepScreen.SleepScreen
        {
            return _sleepScreen;
        }

        public function set sleepScreen(arg1:core.sleepScreen.SleepScreen):void
        {
            _sleepScreen = arg1;
            return;
        }

        public static const FIFO_BIT:uint=16;

        public static const READ_BLOCK_DELAY:uint=18;

        public static const READ_DELAY:uint=6;

        internal var _sleepScreen:core.sleepScreen.SleepScreen;
    }
}


//  class UnitBC1909HR
package core.units 
{
    import core.general.*;
    
    public class UnitBC1909HR extends core.units.UnitTopline2009
    {
        public function UnitBC1909HR()
        {
            super();
            type = core.general.UnitType.BC1909HR;
            return;
        }

        public override function get bikeCount():int
        {
            return 2;
        }

        public override function get deviceGUID():Boolean
        {
            return false;
        }

        public override function toString():String
        {
            return "[UnitBC1909HR extends UnitTopline2009]";
        }
    }
}


//  class UnitBC2209MHR
package core.units 
{
    import core.general.*;
    
    public class UnitBC2209MHR extends core.units.UnitTopline2009
    {
        public function UnitBC2209MHR()
        {
            super();
            type = core.general.UnitType.BC2209MHR;
            return;
        }

        public override function get bikeCount():int
        {
            return 2;
        }

        public override function get deviceGUID():Boolean
        {
            return false;
        }

        public override function toString():String
        {
            return "[UnitBC2209MHR extends UnitTopline2009 implements ISpeedTXBatteryStatus, ICadenceTXBatteryStatus, IHeartrateTXBatteryStatus, ITotalDistance1, ITotalDistance2, ITotalTime1, ITotalTime2, ITotalAltitude1, ITotalAltitude2]";
        }
    }
}


//  class UnitBC2316STS
package core.units 
{
    import __AS3__.vec.*;
    import core.activities.*;
    import core.general.*;
    import core.sleepScreen.*;
    import core.units.interfaces.*;
    import flash.events.*;
    
    public class UnitBC2316STS extends core.units.UnitTopline2016 implements core.units.interfaces.INFCDeviceInfo, core.units.interfaces.ISleepScreen, core.units.interfaces.ILogList, core.units.interfaces.IDataToDecode, core.units.interfaces.IUnitSamplingRate, core.units.interfaces.IGhostRaceSupported
    {
        public function UnitBC2316STS()
        {
            _activitiesToDecode = new __AS3__.vec.Vector.<core.activities.Activity>();
            super();
            type = core.general.UnitType.BC2316STS;
            return;
        }

        public function get activitiesToDecode():__AS3__.vec.Vector.<core.activities.Activity>
        {
            return _activitiesToDecode;
        }

        public function set activitiesToDecode(arg1:__AS3__.vec.Vector.<core.activities.Activity>):void
        {
            if (_activitiesToDecode !== arg1) 
            {
                _activitiesToDecode = arg1;
                dispatchEvent(new flash.events.Event("activitiesToDecodeChange"));
            }
            return;
        }

        public override function get bikeCount():int
        {
            return 2;
        }

        public function get fifoBit():uint
        {
            return 16;
        }

        public function get ghostRaceGPSDataRequired():Boolean
        {
            return false;
        }

        public function get ghostRaceSupported():Boolean
        {
            return true;
        }

        public function get loadedLogs():__AS3__.vec.Vector.<core.activities.Activity>
        {
            return _loadedLogs;
        }

        public function set loadedLogs(arg1:__AS3__.vec.Vector.<core.activities.Activity>):void
        {
            _loadedLogs = arg1;
            return;
        }

        public function get readBlockDelay():uint
        {
            return 18;
        }

        public function get readDelay():uint
        {
            return 6;
        }

        public function get sleepScreen():core.sleepScreen.SleepScreen
        {
            return _sleepScreen;
        }

        public function set sleepScreen(arg1:core.sleepScreen.SleepScreen):void
        {
            _sleepScreen = arg1;
            return;
        }

        public function get tracksToDecode():__AS3__.vec.Vector.<core.route.Route>
        {
            return null;
        }

        public function set tracksToDecode(arg1:__AS3__.vec.Vector.<core.route.Route>):void
        {
            return;
        }

        public function getSamplingRates():Array
        {
            return [_sr5, _sr10, _sr20];
        }

        public function getSamplingRateIds():Array
        {
            return [5, 10, 20];
        }

        public function getSamplingRate(arg1:Number):Number
        {
            var loc1:*=NaN;
            var loc2:*=arg1;
            while (5 === loc2) 
            {
                loc1 = _sr5;
            }
        }

        public function getSamplingRateId(arg1:Number):Number
        {
            var loc1:*=NaN;
            var loc2:*=arg1;
            while (_sr5 === loc2) 
            {
                loc1 = 5;
            }
        }

        public static const FIFO_BIT:uint=16;

        public static const READ_BLOCK_DELAY:uint=18;

        public static const READ_DELAY:uint=6;

        internal var _activitiesToDecode:__AS3__.vec.Vector.<core.activities.Activity>;

        internal var _loadedLogs:__AS3__.vec.Vector.<core.activities.Activity>;

        internal var _sleepScreen:core.sleepScreen.SleepScreen;

        internal var _sr10:Number=10;

        internal var _sr20:Number=20;

        internal var _sr5:Number=5;
    }
}


//  class UnitBC416
package core.units 
{
    import core.general.*;
    
    public class UnitBC416 extends core.units.UnitTopline2016
    {
        public function UnitBC416()
        {
            super();
            type = core.general.UnitType.BC416;
            return;
        }

        public override function get bikeCount():int
        {
            return 1;
        }
    }
}


//  class UnitBC416ATS
package core.units 
{
    import core.general.*;
    
    public class UnitBC416ATS extends core.units.UnitTopline2016
    {
        public function UnitBC416ATS()
        {
            super();
            type = core.general.UnitType.BC416ATS;
            return;
        }

        public override function get bikeCount():int
        {
            return 1;
        }
    }
}


//  class UnitBC509
package core.units 
{
    import core.general.*;
    
    public class UnitBC509 extends core.units.UnitTopline2009
    {
        public function UnitBC509()
        {
            super();
            type = core.general.UnitType.BC509;
            return;
        }

        public override function get bikeCount():int
        {
            return 1;
        }

        public override function get deviceGUID():Boolean
        {
            return false;
        }

        public override function toString():String
        {
            return "[UnitBC509 extends UnitTopline2009]";
        }
    }
}


//  class UnitBC512
package core.units 
{
    import core.general.*;
    
    public class UnitBC512 extends core.units.UnitTopline2012
    {
        public function UnitBC512()
        {
            super();
            type = core.general.UnitType.BC512;
            return;
        }

        public override function get bikeCount():int
        {
            return 1;
        }

        public override function get deviceGUID():Boolean
        {
            return false;
        }

        public override function toString():String
        {
            return "[UnitBC512 extends UnitTopline2012]";
        }
    }
}


//  class UnitBC516
package core.units 
{
    import core.general.*;
    
    public class UnitBC516 extends core.units.UnitTopline2016
    {
        public function UnitBC516()
        {
            super();
            type = core.general.UnitType.BC516;
            return;
        }

        public override function get bikeCount():int
        {
            return 1;
        }
    }
}


//  class UnitBC716
package core.units 
{
    import core.general.*;
    
    public class UnitBC716 extends core.units.UnitTopline2016
    {
        public function UnitBC716()
        {
            super();
            type = core.general.UnitType.BC716;
            return;
        }

        public override function get bikeCount():int
        {
            return 1;
        }
    }
}


//  class UnitBC716ATS
package core.units 
{
    import core.general.*;
    
    public class UnitBC716ATS extends core.units.UnitTopline2016
    {
        public function UnitBC716ATS()
        {
            super();
            type = core.general.UnitType.BC716ATS;
            return;
        }

        public override function get bikeCount():int
        {
            return 1;
        }
    }
}


//  class UnitBC812
package core.units 
{
    import core.general.*;
    
    public class UnitBC812 extends core.units.UnitTopline2012
    {
        public function UnitBC812()
        {
            super();
            type = core.general.UnitType.BC812;
            return;
        }

        public override function get bikeCount():int
        {
            return 1;
        }

        public override function get deviceGUID():Boolean
        {
            return false;
        }

        public override function toString():String
        {
            return "[UnitBC812 extends UnitTopline2012]";
        }
    }
}


//  class UnitBC812W
package core.units 
{
    import core.general.*;
    
    public class UnitBC812W extends core.units.UnitTopline2012
    {
        public function UnitBC812W()
        {
            super();
            type = core.general.UnitType.BC812W;
            return;
        }

        public override function get bikeCount():int
        {
            return 1;
        }

        public override function get deviceGUID():Boolean
        {
            return false;
        }

        public override function toString():String
        {
            return "[UnitBC812W extends UnitTopline2012]";
        }
    }
}


//  class UnitBC916
package core.units 
{
    import core.general.*;
    
    public class UnitBC916 extends core.units.UnitTopline2016
    {
        public function UnitBC916()
        {
            super();
            type = core.general.UnitType.BC916;
            return;
        }

        public override function get bikeCount():int
        {
            return 1;
        }
    }
}


//  class UnitBC916ATS
package core.units 
{
    import core.general.*;
    
    public class UnitBC916ATS extends core.units.UnitTopline2016
    {
        public function UnitBC916ATS()
        {
            super();
            type = core.general.UnitType.BC916ATS;
            return;
        }

        public override function get bikeCount():int
        {
            return 1;
        }
    }
}


//  class UnitBikeComputer
package core.units 
{
    import flash.events.*;
    
    public class UnitBikeComputer extends core.units.Unit
    {
        public function UnitBikeComputer(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            return;
        }
    }
}


//  class UnitFactory
package core.units 
{
    import core.general.*;
    
    public final class UnitFactory extends Object
    {
        public function UnitFactory()
        {
            super();
            return;
        }

        public static function createUnitFromSUF(arg1:XML):core.units.Unit
        {
            var loc1:*=core.general.UnitType.fromString(arg1.GeneralInformation.@unit);
            var loc2:*=unitSwitch(loc1);
            loc2.fromSUF(arg1);
            return loc2;
        }

        public static function createUnitFromDB(arg1:Object):core.units.Unit
        {
            var loc2:*=null;
            var loc1:*=core.general.UnitType.fromString(arg1.type);
            if (loc1 != null) 
            {
                loc2 = unitSwitch(loc1);
                loc2.fromDB(arg1);
            }
            return loc2;
        }

        public static function createUnitFromType(arg1:core.general.UnitType):core.units.Unit
        {
            return unitSwitch(arg1);
        }

        public static function calculateFitWithBreaks(arg1:core.general.UnitType):Boolean
        {
            return arg1.equals(core.general.UnitType.ROX100) || arg1.equals(core.general.UnitType.ROX110) || arg1.equals(core.general.UnitType.ROX70);
        }

        public static function notificationsSupported():Array
        {
            if (!_notificationTypes) 
            {
                _notificationTypes = [core.general.UnitType.ROX110];
            }
            return _notificationTypes;
        }

        public static function ghostRaceSupported():Array
        {
            if (!_ghostRaceTypes) 
            {
                _ghostRaceTypes = [core.general.UnitType.BC2316STS];
            }
            return _ghostRaceTypes;
        }

        public static function nfcSupported():Array
        {
            if (!_nfcTypes) 
            {
                _nfcTypes = [core.general.UnitType.BC1416, core.general.UnitType.BC1416STS, core.general.UnitType.BC1616, core.general.UnitType.BC1616STS, core.general.UnitType.BC2316STS, core.general.UnitType.GPS10];
            }
            return _nfcTypes;
        }

        public static function bleSupported():Array
        {
            if (!_bleTypes) 
            {
                _bleTypes = [core.general.UnitType.ROX110, core.general.UnitType.PC2814];
            }
            return _bleTypes;
        }

        public static function usbSupported():Array
        {
            var loc3:*=0;
            var loc1:*=null;
            if (!_usbTypes) 
            {
                _usbTypes = core.general.UnitType.TYPES.concat();
                loc1 = [core.general.UnitType.RC1209, core.general.UnitType.PC2814, core.general.UnitType.SigmaMove, core.general.UnitType.Activo];
                var loc2:*=loc1.length;
                loc3 = 0;
                while (loc3 < loc2) 
                {
                    _usbTypes.removeAt(_usbTypes.indexOf(loc1[loc3]));
                    ++loc3;
                }
            }
            return _usbTypes;
        }

        internal static function unitSwitch(arg1:core.general.UnitType):core.units.Unit
        {
            var loc2:*=null;
            var loc1:*=core.general.UnitType.ROX60;
            var loc3:*=arg1.toString();
            while (core.general.UnitType.BC509.toString() === loc3) 
            {
                loc2 = new core.units.UnitBC509();
            }
        }

        public static function getFITProductId(arg1:core.general.UnitType):int
        {
            var loc1:*=0;
            var loc2:*=arg1.toString();
            while (core.general.UnitType.BC509.toString() === loc2) 
            {
                loc1 = 1;
            }
        }

        internal static var _bleTypes:Array;

        internal static var _ghostRaceTypes:Array;

        internal static var _nfcTypes:Array;

        internal static var _notificationTypes:Array;

        internal static var _usbTypes:Array;
    }
}


//  class UnitGps10
package core.units 
{
    import __AS3__.vec.*;
    import core.activities.*;
    import core.general.*;
    import core.gps.*;
    import core.sleepScreen.*;
    import core.totals.*;
    import core.units.interfaces.*;
    import flash.events.*;
    import init.*;
    
    public class UnitGps10 extends core.units.UnitBikeComputer implements core.units.interfaces.INFCDeviceInfo, core.units.interfaces.IUSBDeviceInfo, core.units.interfaces.ISleepScreen, core.units.interfaces.ILogList, core.units.interfaces.IDataToDecode, core.units.interfaces.ITotalsList, core.units.interfaces.IAgpsSupported, core.units.interfaces.IFirmwareUpdateSupported, core.units.interfaces.IPointNavigationsList, core.units.interfaces.IOnlyFinishedActivitiesLoadable
    {
        public function UnitGps10(arg1:flash.events.IEventDispatcher=null)
        {
            _activitiesToDecode = new __AS3__.vec.Vector.<core.activities.Activity>();
            _pointNavigationsVector = new __AS3__.vec.Vector.<core.gps.PointNavigation>();
            _totalsVector = new __AS3__.vec.Vector.<core.totals.Totals>();
            super(arg1);
            type = core.general.UnitType.GPS10;
            addEventListener("totalsChanged", onTotalsChanged, false, 0, true);
            addEventListener("totalRemoved", onTotalsChanged, false, 0, true);
            addEventListener("pointNavigationsChanged", onPointNavigationsChanged, false, 0, true);
            return;
        }

        public function set tracksToDecode(arg1:__AS3__.vec.Vector.<core.route.Route>):void
        {
            _tracksToDecode = arg1;
            return;
        }

        public function get activitiesToDecode():__AS3__.vec.Vector.<core.activities.Activity>
        {
            return _activitiesToDecode;
        }

        public function set activitiesToDecode(arg1:__AS3__.vec.Vector.<core.activities.Activity>):void
        {
            if (_activitiesToDecode !== arg1) 
            {
                _activitiesToDecode = arg1;
                dispatchEvent(new flash.events.Event("activitiesToDecodeChange"));
            }
            return;
        }

        public function firmwareUpdateSupported():Boolean
        {
            return true;
        }

        public function get currentPointNavigation():core.gps.PointNavigation
        {
            return _currentPointNavigation;
        }

        public function set currentPointNavigation(arg1:core.gps.PointNavigation):void
        {
            _currentPointNavigation = arg1;
            return;
        }

        public function bleFirmwareUpdateSupported():Boolean
        {
            return false;
        }

        public function get currentTotals():core.totals.Totals
        {
            return _currentTotals;
        }

        public function set currentTotals(arg1:core.totals.Totals):void
        {
            if (arg1 != _currentTotals) 
            {
                _currentTotals = arg1;
                dispatchEvent(new flash.events.Event("currentTotalsChange"));
            }
            return;
        }

        public function get fifoBit():uint
        {
            return 1;
        }

        internal function onTotalsChanged(arg1:flash.events.Event):void
        {
            totalsVectorList = init.BackendInitializer.getInstance().createVectorList(_totalsVector);
            return;
        }

        public function get loadedLogs():__AS3__.vec.Vector.<core.activities.Activity>
        {
            return _loadedLogs;
        }

        public function set loadedLogs(arg1:__AS3__.vec.Vector.<core.activities.Activity>):void
        {
            _loadedLogs = arg1;
            return;
        }

        internal function onPointNavigationsChanged(arg1:flash.events.Event):void
        {
            pointNavigationsVectorList = init.BackendInitializer.getInstance().createVectorList(_pointNavigationsVector);
            return;
        }

        public function get pointNavigationsVector():__AS3__.vec.Vector.<core.gps.PointNavigation>
        {
            return _pointNavigationsVector;
        }

        public function set pointNavigationsVector(arg1:__AS3__.vec.Vector.<core.gps.PointNavigation>):void
        {
            _pointNavigationsVector = arg1;
            return;
        }

        public function get readBlockDelay():uint
        {
            return 18;
        }

        public function get readDelay():uint
        {
            return 18;
        }

        public function get sleepScreen():core.sleepScreen.SleepScreen
        {
            return _sleepScreen;
        }

        public function set sleepScreen(arg1:core.sleepScreen.SleepScreen):void
        {
            _sleepScreen = arg1;
            return;
        }

        public function get totalsVector():__AS3__.vec.Vector.<core.totals.Totals>
        {
            return _totalsVector;
        }

        public function set totalsVector(arg1:__AS3__.vec.Vector.<core.totals.Totals>):void
        {
            if (_totalsVector !== arg1) 
            {
                _totalsVector = arg1;
                dispatchEvent(new flash.events.Event("totalsVectorChange"));
            }
            return;
        }

        public function get tracksToDecode():__AS3__.vec.Vector.<core.route.Route>
        {
            return _tracksToDecode;
        }

        public static const FIFO_BIT:uint=1;

        public static const READ_BLOCK_DELAY:uint=18;

        public static const READ_DELAY:uint=18;

        public static const SAMPLING_RATE:uint=5;

        internal var _activitiesToDecode:__AS3__.vec.Vector.<core.activities.Activity>;

        internal var _currentPointNavigation:core.gps.PointNavigation;

        internal var _currentTotals:core.totals.Totals;

        internal var _loadedLogs:__AS3__.vec.Vector.<core.activities.Activity>;

        internal var _pointNavigationsVector:__AS3__.vec.Vector.<core.gps.PointNavigation>;

        internal var _sleepScreen:core.sleepScreen.SleepScreen;

        internal var _totalsVector:__AS3__.vec.Vector.<core.totals.Totals>;

        internal var _tracksToDecode:__AS3__.vec.Vector.<core.route.Route>;
    }
}


//  class UnitPC2814
package core.units 
{
    import __AS3__.vec.*;
    import core.activities.*;
    import core.general.*;
    import core.training.*;
    import core.units.interfaces.*;
    import flash.events.*;
    import init.*;
    import init.interfaces.*;
    
    public class UnitPC2814 extends core.units.UnitPulseComputer implements core.units.interfaces.IBLEDeviceInfo, core.units.interfaces.IBLESimplePairing, core.units.interfaces.ILogList, core.units.interfaces.IUnitSamplingRate, core.units.interfaces.ILogTime5Sec, core.units.interfaces.ILogTime10Sec, core.units.interfaces.ILogTime20Sec, core.units.interfaces.ILogTime30Sec, core.units.interfaces.ILogStatus, core.units.interfaces.IIntensityZonesPercentage, core.units.interfaces.IDataToDecode, core.units.interfaces.ITrainingsList
    {
        public function UnitPC2814(arg1:flash.events.IEventDispatcher=null)
        {
            _activities = new __AS3__.vec.Vector.<core.activities.Activity>();
            _activitiesToDecode = new __AS3__.vec.Vector.<core.activities.Activity>();
            _loadedLogs = new __AS3__.vec.Vector.<core.activities.Activity>();
            _trainingsOnDeviceList = new __AS3__.vec.Vector.<core.training.Training>();
            _trainingsVectorList = init.BackendInitializer.getInstance().createVectorList();
            _trainings = new __AS3__.vec.Vector.<core.training.Training>();
            super(arg1);
            type = core.general.UnitType.PC2814;
            primaryServiceUUID = "cc141a56-0b20-41f8-9b2b-f92ccc9b555f";
            addEventListener("trainingsChanged", onTrainingListChanged, false, 0, true);
            return;
        }

        public function set trainingsToDelete(arg1:__AS3__.vec.Vector.<core.training.Training>):void
        {
            _trainingsToDelete = arg1;
            return;
        }

        public function get activities():__AS3__.vec.Vector.<core.activities.Activity>
        {
            return _activities;
        }

        public function set activities(arg1:__AS3__.vec.Vector.<core.activities.Activity>):void
        {
            if (_activities !== arg1) 
            {
                _activities = arg1;
                dispatchEvent(new flash.events.Event("activitiesChange"));
            }
            return;
        }

        public function get trainingsVectorList():init.interfaces.IVectorList
        {
            return _trainingsVectorList;
        }

        public function get activitiesToDecode():__AS3__.vec.Vector.<core.activities.Activity>
        {
            return _activitiesToDecode;
        }

        public function set activitiesToDecode(arg1:__AS3__.vec.Vector.<core.activities.Activity>):void
        {
            if (_activitiesToDecode !== arg1) 
            {
                _activitiesToDecode = arg1;
            }
            return;
        }

        public override function get bikeCount():int
        {
            return 0;
        }

        public override function get deviceGUID():Boolean
        {
            return false;
        }

        public function get deviceID():String
        {
            return _bleDeviceId;
        }

        public function set deviceID(arg1:String):void
        {
            _bleDeviceId = arg1;
            return;
        }

        public function set trainingsVectorList(arg1:init.interfaces.IVectorList):void
        {
            _trainingsVectorList = arg1;
            return;
        }

        public function get dsHandler():String
        {
            return _dsHandler;
        }

        public function set dsHandler(arg1:String):void
        {
            _dsHandler = arg1;
            return;
        }

        public function get unitLogStatus():Boolean
        {
            return _unitLogStatus;
        }

        public function get freePackages():int
        {
            return _freePackages;
        }

        public function set freePackages(arg1:int):void
        {
            _freePackages = arg1;
            return;
        }

        public function set unitLogStatus(arg1:Boolean):void
        {
            _unitLogStatus = arg1;
            return;
        }

        public function get intensityZone1PercentageStart():Number
        {
            return _intensityZone1PercentageStart;
        }

        public function set intensityZone1PercentageStart(arg1:Number):void
        {
            _intensityZone1PercentageStart = arg1;
            return;
        }

        public function onTrainingListChanged(arg1:flash.events.Event):void
        {
            trainingsVectorList = init.BackendInitializer.getInstance().createVectorList(_trainings);
            return;
        }

        public function get intensityZone2PercentageStart():Number
        {
            return _intensityZone2PercentageStart;
        }

        public function set intensityZone2PercentageStart(arg1:Number):void
        {
            _intensityZone2PercentageStart = arg1;
            return;
        }

        public function getSamplingRates():Array
        {
            return [_sr5, _sr10, _sr20, _sr30];
        }

        public function get intensityZone3PercentageStart():Number
        {
            return _intensityZone3PercentageStart;
        }

        public function set intensityZone3PercentageStart(arg1:Number):void
        {
            _intensityZone3PercentageStart = arg1;
            return;
        }

        public function getSamplingRateIds():Array
        {
            return [5, 10, 20, 30];
        }

        public function get intensityZone4PercentageEnd():Number
        {
            return _intensityZone4PercentageEnd;
        }

        public function set intensityZone4PercentageEnd(arg1:Number):void
        {
            _intensityZone4PercentageEnd = arg1;
            return;
        }

        public function getSamplingRate(arg1:Number):Number
        {
            var loc1:*=NaN;
            var loc2:*=arg1;
            while (5 === loc2) 
            {
                loc1 = _sr5;
            }
        }

        public function get intensityZone4PercentageStart():Number
        {
            return _intensityZone4PercentageStart;
        }

        public function set intensityZone4PercentageStart(arg1:Number):void
        {
            _intensityZone4PercentageStart = arg1;
            return;
        }

        public function get intensityZonePercentageMin():Number
        {
            return 30;
        }

        public function set logTime20Sec(arg1:int):void
        {
            _logTime20Sec = arg1;
            return;
        }

        public function get loadedLogs():__AS3__.vec.Vector.<core.activities.Activity>
        {
            return _loadedLogs;
        }

        public function set loadedLogs(arg1:__AS3__.vec.Vector.<core.activities.Activity>):void
        {
            if (arg1 != _loadedLogs) 
            {
                _loadedLogs = arg1;
                dispatchEvent(new flash.events.Event("loadedLogsChange"));
            }
            return;
        }

        public function get localName():String
        {
            return _bleLocalName;
        }

        public function set localName(arg1:String):void
        {
            _bleLocalName = arg1;
            return;
        }

        public function getSamplingRateId(arg1:Number):Number
        {
            var loc1:*=NaN;
            var loc2:*=arg1;
            while (_sr5 === loc2) 
            {
                loc1 = 5;
            }
        }

        public function get logTime10Sec():int
        {
            return _logTime10Sec;
        }

        public function set logTime10Sec(arg1:int):void
        {
            _logTime10Sec = arg1;
            return;
        }

        public override function toString():String
        {
            return "[UnitRC1411 extends UnitRC2011 implements ILogList, IUnitBatteryStatus]";
        }

        public function get logTime20Sec():int
        {
            return _logTime20Sec;
        }

        public function get primaryServiceUUID():String
        {
            return _bleServiceUUID;
        }

        public function get logTime30Sec():int
        {
            return _logTime30Sec;
        }

        public function set logTime30Sec(arg1:int):void
        {
            _logTime30Sec = arg1;
            return;
        }

        public function get logTime5Sec():int
        {
            return _logTime5Sec;
        }

        public function set logTime5Sec(arg1:int):void
        {
            _logTime5Sec = arg1;
            return;
        }

        public function get maxPackages():int
        {
            return _maxPackages;
        }

        public function set maxPackages(arg1:int):void
        {
            _maxPackages = arg1;
            return;
        }

        public function set primaryServiceUUID(arg1:String):void
        {
            _bleServiceUUID = arg1;
            return;
        }

        public function get supportMultipleTrainings():Boolean
        {
            return false;
        }

        public function get tracksToDecode():__AS3__.vec.Vector.<core.route.Route>
        {
            return null;
        }

        public function set tracksToDecode(arg1:__AS3__.vec.Vector.<core.route.Route>):void
        {
            return;
        }

        public function get trainingsList():__AS3__.vec.Vector.<core.training.Training>
        {
            return _trainings;
        }

        public function set trainingsList(arg1:__AS3__.vec.Vector.<core.training.Training>):void
        {
            if (arg1 != _trainings) 
            {
                _trainings = arg1;
                dispatchEvent(new flash.events.Event("trainingsChanged"));
            }
            return;
        }

        public function get trainingsOnDeviceList():__AS3__.vec.Vector.<core.training.Training>
        {
            return _trainingsOnDeviceList;
        }

        public function set trainingsOnDeviceList(arg1:__AS3__.vec.Vector.<core.training.Training>):void
        {
            _trainingsOnDeviceList = arg1;
            return;
        }

        public function get trainingsToDelete():__AS3__.vec.Vector.<core.training.Training>
        {
            return _trainingsToDelete;
        }

        public static const SEND_CHARACTERISTIC_UUID:String="b789edf9-12d0-412a-b34e-fe0f2998a0ad";

        public static const PRIMARY_SERVICE_UUID:String="cc141a56-0b20-41f8-9b2b-f92ccc9b555f";

        public static const RECEIVE_CHARACTERISTIC_UUID:String="bbeaf5d9-6f57-4dd0-a153-e9f333b1b514";

        internal var _activities:__AS3__.vec.Vector.<core.activities.Activity>;

        internal var _activitiesToDecode:__AS3__.vec.Vector.<core.activities.Activity>;

        internal var _dsHandler:String;

        internal var _freePackages:int=0;

        internal var _intensityZone1PercentageStart:Number=40;

        internal var _intensityZone2PercentageStart:Number=55;

        internal var _intensityZone3PercentageStart:Number=70;

        internal var _intensityZone4PercentageEnd:Number=100;

        internal var _intensityZone4PercentageStart:Number=85;

        internal var _logTime10Sec:int=0;

        internal var _logTime20Sec:int=0;

        internal var _loadedLogs:__AS3__.vec.Vector.<core.activities.Activity>;

        internal var _trainingsToDelete:__AS3__.vec.Vector.<core.training.Training>;

        internal var _sr10:Number=10;

        internal var _sr20:Number=20;

        internal var _sr30:Number=30;

        internal var _trainings:__AS3__.vec.Vector.<core.training.Training>;

        internal var _maxPackages:int=0;

        internal var _logTime30Sec:int=0;

        internal var _trainingsVectorList:init.interfaces.IVectorList;

        internal var _trainingsOnDeviceList:__AS3__.vec.Vector.<core.training.Training>;

        internal var _logTime5Sec:int=0;

        internal var _unitLogStatus:Boolean=true;

        internal var _sr5:Number=5;
    }
}


//  class UnitPulseComputer
package core.units 
{
    import flash.events.*;
    
    public class UnitPulseComputer extends core.units.Unit
    {
        public function UnitPulseComputer(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            return;
        }
    }
}


//  class UnitRC1209
package core.units 
{
    import core.general.*;
    import flash.events.*;
    
    public class UnitRC1209 extends core.units.UnitRC2011
    {
        public function UnitRC1209(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            type = core.general.UnitType.RC1209;
            return;
        }

        public override function get bikeCount():int
        {
            return 0;
        }

        public override function get deviceGUID():Boolean
        {
            return false;
        }

        public override function toString():String
        {
            return "[UnitRC1209 extends UnitRC2011]";
        }
    }
}


//  class UnitRC1411
package core.units 
{
    import __AS3__.vec.*;
    import core.activities.*;
    import core.general.*;
    import core.units.interfaces.*;
    import flash.events.*;
    
    public class UnitRC1411 extends core.units.UnitRC2011 implements core.units.interfaces.IDSTDeviceInfo, core.units.interfaces.ILogList, core.units.interfaces.IUnitBatteryStatus, core.units.interfaces.IR3TXBatteryStatus, core.units.interfaces.IUnitSamplingRate, core.units.interfaces.ILogTime5Sec, core.units.interfaces.ILogTime10Sec, core.units.interfaces.ILogTime20Sec, core.units.interfaces.ILogTime30Sec, core.units.interfaces.ILogStatus, core.units.interfaces.IIntensityZonesPercentage
    {
        public function UnitRC1411(arg1:flash.events.IEventDispatcher=null)
        {
            _activities = new __AS3__.vec.Vector.<core.activities.Activity>();
            _loadedLogs = new __AS3__.vec.Vector.<core.activities.Activity>();
            super(arg1);
            type = core.general.UnitType.RC1411;
            return;
        }

        public override function toString():String
        {
            return "[UnitRC1411 extends UnitRC2011 implements ILogList, IUnitBatteryStatus]";
        }

        public function get activities():__AS3__.vec.Vector.<core.activities.Activity>
        {
            return _activities;
        }

        public function set activities(arg1:__AS3__.vec.Vector.<core.activities.Activity>):void
        {
            if (_activities !== arg1) 
            {
                _activities = arg1;
                dispatchEvent(new flash.events.Event("activitiesChange"));
            }
            return;
        }

        public override function get bikeCount():int
        {
            return 0;
        }

        public override function get deviceGUID():Boolean
        {
            return false;
        }

        public function get unitBatteryStatus():Boolean
        {
            return _unitBatteryStatus;
        }

        public function get freePackages():int
        {
            return _freePackages;
        }

        public function set freePackages(arg1:int):void
        {
            _freePackages = arg1;
            return;
        }

        public function set unitBatteryStatus(arg1:Boolean):void
        {
            if (arg1 != _unitBatteryStatus) 
            {
                _unitBatteryStatus = arg1;
                dispatchEvent(new flash.events.Event("unitBatteryStatusChange"));
            }
            return;
        }

        public function get intensityZone1PercentageStart():Number
        {
            return _intensityZone1PercentageStart;
        }

        public function set intensityZone1PercentageStart(arg1:Number):void
        {
            _intensityZone1PercentageStart = arg1;
            return;
        }

        public function get unitLogStatus():Boolean
        {
            return _unitLogStatus;
        }

        public function get intensityZone2PercentageStart():Number
        {
            return _intensityZone2PercentageStart;
        }

        public function set intensityZone2PercentageStart(arg1:Number):void
        {
            _intensityZone2PercentageStart = arg1;
            return;
        }

        public function set unitLogStatus(arg1:Boolean):void
        {
            _unitLogStatus = arg1;
            return;
        }

        public function get intensityZone3PercentageStart():Number
        {
            return _intensityZone3PercentageStart;
        }

        public function set intensityZone3PercentageStart(arg1:Number):void
        {
            _intensityZone3PercentageStart = arg1;
            return;
        }

        public function getSamplingRates():Array
        {
            return [_sr5, _sr10, _sr20, _sr30];
        }

        public function get intensityZone4PercentageEnd():Number
        {
            return _intensityZone4PercentageEnd;
        }

        public function set intensityZone4PercentageEnd(arg1:Number):void
        {
            _intensityZone4PercentageEnd = arg1;
            return;
        }

        public function getSamplingRateIds():Array
        {
            return [5, 10, 20, 30];
        }

        public function get intensityZone4PercentageStart():Number
        {
            return _intensityZone4PercentageStart;
        }

        public function set intensityZone4PercentageStart(arg1:Number):void
        {
            _intensityZone4PercentageStart = arg1;
            return;
        }

        public function get intensityZonePercentageMin():Number
        {
            return 30;
        }

        public function getSamplingRate(arg1:Number):Number
        {
            var loc1:*=NaN;
            var loc2:*=arg1;
            while (5 === loc2) 
            {
                loc1 = _sr5;
            }
        }

        public function get loadedLogs():__AS3__.vec.Vector.<core.activities.Activity>
        {
            return _loadedLogs;
        }

        public function set loadedLogs(arg1:__AS3__.vec.Vector.<core.activities.Activity>):void
        {
            if (arg1 != _loadedLogs) 
            {
                _loadedLogs = arg1;
                dispatchEvent(new flash.events.Event("loadedLogsChange"));
            }
            return;
        }

        public function getSamplingRateId(arg1:Number):Number
        {
            var loc1:*=NaN;
            var loc2:*=arg1;
            while (_sr5 === loc2) 
            {
                loc1 = 5;
            }
        }

        public function get logTime10Sec():int
        {
            return _logTime10Sec;
        }

        public function set logTime10Sec(arg1:int):void
        {
            _logTime10Sec = arg1;
            return;
        }

        public function get logTime20Sec():int
        {
            return _logTime20Sec;
        }

        public function set logTime20Sec(arg1:int):void
        {
            _logTime20Sec = arg1;
            return;
        }

        public function get logTime30Sec():int
        {
            return _logTime30Sec;
        }

        public function set logTime30Sec(arg1:int):void
        {
            _logTime30Sec = arg1;
            return;
        }

        public function get logTime5Sec():int
        {
            return _logTime5Sec;
        }

        public function set logTime5Sec(arg1:int):void
        {
            _logTime5Sec = arg1;
            return;
        }

        public function get maxPackages():int
        {
            return _maxPackages;
        }

        public function set maxPackages(arg1:int):void
        {
            _maxPackages = arg1;
            return;
        }

        public function get r3txBatteryStatus():Boolean
        {
            return _r3txBatteryStatus;
        }

        public function set r3txBatteryStatus(arg1:Boolean):void
        {
            if (arg1 != _r3txBatteryStatus) 
            {
                _r3txBatteryStatus = arg1;
                dispatchEvent(new flash.events.Event("r3txBatteryStatusChange"));
            }
            return;
        }

        internal var _activities:__AS3__.vec.Vector.<core.activities.Activity>;

        internal var _freePackages:int=0;

        internal var _intensityZone1PercentageStart:Number=40;

        internal var _intensityZone2PercentageStart:Number=55;

        internal var _intensityZone3PercentageStart:Number=70;

        internal var _intensityZone4PercentageEnd:Number=100;

        internal var _intensityZone4PercentageStart:Number=85;

        internal var _loadedLogs:__AS3__.vec.Vector.<core.activities.Activity>;

        internal var _logTime10Sec:int=0;

        internal var _logTime30Sec:int=0;

        internal var _maxPackages:int=0;

        internal var _sr10:Number=10;

        protected var _unitBatteryStatus:Boolean;

        internal var _sr30:Number=30;

        internal var _sr5:Number=5;

        internal var _logTime5Sec:int=0;

        internal var _logTime20Sec:int=0;

        protected var _r3txBatteryStatus:Boolean;

        internal var _unitLogStatus:Boolean=true;

        internal var _sr20:Number=20;
    }
}


//  class UnitRC2011
package core.units 
{
    import flash.events.*;
    
    public class UnitRC2011 extends core.units.UnitRunningComputer
    {
        public function UnitRC2011(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            return;
        }

        public function get dateCode():Date
        {
            return _dateCode;
        }

        public function set dateCode(arg1:Date):void
        {
            _dateCode = arg1;
            return;
        }

        public override function toString():String
        {
            return "[UnitRC2011 extends UnitRunningComputer implements IMemoryList]";
        }

        internal var _dateCode:Date;
    }
}


//  class UnitROX
package core.units 
{
    import __AS3__.vec.*;
    import core.totals.*;
    import core.units.interfaces.*;
    import flash.events.*;
    import init.*;
    
    public class UnitROX extends core.units.UnitBikeComputer implements core.units.interfaces.IDSTDeviceInfo, core.units.interfaces.IUnitBatteryStatus, core.units.interfaces.ISpeedTXBatteryStatus, core.units.interfaces.ICadenceTXBatteryStatus, core.units.interfaces.IHeartrateTXBatteryStatus, core.units.interfaces.IDateCode, core.units.interfaces.IUnitSamplingRate, core.units.interfaces.ITotalsList
    {
        public function UnitROX()
        {
            _totalsVector = new __AS3__.vec.Vector.<core.totals.Totals>();
            super();
            addEventListener("totalsChanged", onTotalsChanged, false, 0, true);
            addEventListener("totalRemoved", onTotalsChanged, false, 0, true);
            return;
        }

        public override function get bikeCount():int
        {
            return 2;
        }

        public function set unitBatteryStatus(arg1:Boolean):void
        {
            if (arg1 != _unitBatteryStatus) 
            {
                _unitBatteryStatus = arg1;
                dispatchEvent(new flash.events.Event("unitBatteryStatusChange"));
            }
            return;
        }

        public function get cadenceTXBatteryStatus():Boolean
        {
            return _cadenceTXBatteryStatus;
        }

        public function set cadenceTXBatteryStatus(arg1:Boolean):void
        {
            if (arg1 != _cadenceTXBatteryStatus) 
            {
                _cadenceTXBatteryStatus = arg1;
                dispatchEvent(new flash.events.Event("cadenceTXBatteryStatusChange"));
            }
            return;
        }

        public function getSamplingRates():Array
        {
            return [_sr5, _sr10, _sr20, _sr30];
        }

        public function get currentTotals():core.totals.Totals
        {
            return _currentTotals;
        }

        public function set currentTotals(arg1:core.totals.Totals):void
        {
            if (arg1 != _currentTotals) 
            {
                _currentTotals = arg1;
                dispatchEvent(new flash.events.Event("currentTotalsChange"));
            }
            return;
        }

        public function getSamplingRateIds():Array
        {
            return [5, 10, 20, 30];
        }

        public function get dateCode():Date
        {
            return _dateCode;
        }

        public function set dateCode(arg1:Date):void
        {
            _dateCode = arg1;
            return;
        }

        public function getSamplingRate(arg1:Number):Number
        {
            var loc1:*=NaN;
            var loc2:*=arg1;
            while (5 === loc2) 
            {
                loc1 = _sr5;
            }
        }

        public function get heartrateTXBatteryStatus():Boolean
        {
            return _heartrateTXBatteryStatus;
        }

        public function set heartrateTXBatteryStatus(arg1:Boolean):void
        {
            if (arg1 != _heartrateTXBatteryStatus) 
            {
                _heartrateTXBatteryStatus = arg1;
                dispatchEvent(new flash.events.Event("heartrateTXBatteryStatusChange"));
            }
            return;
        }

        public function getSamplingRateId(arg1:Number):Number
        {
            var loc1:*=NaN;
            var loc2:*=arg1;
            while (_sr5 === loc2) 
            {
                loc1 = 5;
            }
        }

        public function get initialWakeUpInfo():String
        {
            return _initialWakeUpInfo;
        }

        public function set initialWakeUpInfo(arg1:String):void
        {
            _initialWakeUpInfo = arg1;
            return;
        }

        internal function onTotalsChanged(arg1:flash.events.Event):void
        {
            totalsVectorList = init.BackendInitializer.getInstance().createVectorList(_totalsVector);
            return;
        }

        public override function toString():String
        {
            return "[UnitROX extends Unit implements IMemoryList, IUnitBatteryStatus, ISpeedTXBatteryStatus, ICadenceTXBatteryStatus, IHeartrateTXBatteryStatus, IDateCode]";
        }

        public function get maskingCode():String
        {
            return _maskingCode;
        }

        public function set maskingCode(arg1:String):void
        {
            _maskingCode = arg1;
            return;
        }

        public function get speedTXBatteryStatus():Boolean
        {
            return _speedTXBatteryStatus;
        }

        public function set speedTXBatteryStatus(arg1:Boolean):void
        {
            if (arg1 != _speedTXBatteryStatus) 
            {
                _speedTXBatteryStatus = arg1;
                dispatchEvent(new flash.events.Event("speedTXBatteryStatusChange"));
            }
            return;
        }

        public function get totalsVector():__AS3__.vec.Vector.<core.totals.Totals>
        {
            return _totalsVector;
        }

        public function set totalsVector(arg1:__AS3__.vec.Vector.<core.totals.Totals>):void
        {
            if (_totalsVector !== arg1) 
            {
                _totalsVector = arg1;
                dispatchEvent(new flash.events.Event("totalsVectorChange"));
            }
            return;
        }

        public function get unitBatteryStatus():Boolean
        {
            return _unitBatteryStatus;
        }

        public const length:Number=128;

        protected var _cadenceTXBatteryStatus:Boolean;

        internal var _currentTotals:core.totals.Totals;

        internal var _dateCode:Date;

        protected var _heartrateTXBatteryStatus:Boolean;

        internal var _initialWakeUpInfo:String;

        internal var _maskingCode:String;

        internal var _sr5:Number=4.5;

        protected var _unitBatteryStatus:Boolean;

        protected var _speedTXBatteryStatus:Boolean;

        internal var _totalsVector:__AS3__.vec.Vector.<core.totals.Totals>;

        internal var _sr10:Number=10.125;

        internal var _sr20:Number=20.25;

        internal var _sr30:Number=30.375;
    }
}


//  class UnitROX100
package core.units 
{
    import __AS3__.vec.*;
    import core.activities.*;
    import core.general.*;
    import core.route.*;
    import core.totals.*;
    import core.units.interfaces.*;
    import flash.events.*;
    import init.*;
    import init.interfaces.*;
    
    public class UnitROX100 extends core.units.UnitBikeComputer implements core.units.interfaces.IUSBDeviceInfo, core.units.interfaces.ILogList, core.units.interfaces.ILogTime1Sec, core.units.interfaces.ILogTime2Sec, core.units.interfaces.ILogTime5Sec, core.units.interfaces.ILogTime10Sec, core.units.interfaces.ILogTime20Sec, core.units.interfaces.ILogTime30Sec, core.units.interfaces.ILogStatus, core.units.interfaces.IUnitSamplingRate, core.units.interfaces.IDataToDecode, core.units.interfaces.ITrackList, core.units.interfaces.IMemoryMapVersion, core.units.interfaces.IFirmwareUpdateSupported, core.units.interfaces.IPowerZones7, core.units.interfaces.ITotalsList
    {
        public function UnitROX100()
        {
            _activities = new __AS3__.vec.Vector.<core.activities.Activity>();
            _activitiesToDecode = new __AS3__.vec.Vector.<core.activities.Activity>();
            _loadedLogs = new __AS3__.vec.Vector.<core.activities.Activity>();
            _loadedTracks = init.BackendInitializer.getInstance().createVectorList();
            _totalsVector = new __AS3__.vec.Vector.<core.totals.Totals>();
            _trackList = init.BackendInitializer.getInstance().createVectorList();
            _tracksToDecode = new __AS3__.vec.Vector.<core.route.Route>();
            super();
            type = core.general.UnitType.ROX100;
            addEventListener("totalsChanged", onTotalsChanged, false, 0, true);
            addEventListener("totalRemoved", onTotalsChanged, false, 0, true);
            return;
        }

        public function set logTime30Sec(arg1:int):void
        {
            _logTime30Sec = arg1;
            return;
        }

        public function get activities():__AS3__.vec.Vector.<core.activities.Activity>
        {
            return _activities;
        }

        public function set activities(arg1:__AS3__.vec.Vector.<core.activities.Activity>):void
        {
            if (_activities !== arg1) 
            {
                _activities = arg1;
                dispatchEvent(new flash.events.Event("activitiesChange"));
            }
            return;
        }

        public function get powerZone2Start():int
        {
            return _powerZone2Start;
        }

        public function get activitiesToDecode():__AS3__.vec.Vector.<core.activities.Activity>
        {
            return _activitiesToDecode;
        }

        public function set activitiesToDecode(arg1:__AS3__.vec.Vector.<core.activities.Activity>):void
        {
            if (_activitiesToDecode !== arg1) 
            {
                _activitiesToDecode = arg1;
                dispatchEvent(new flash.events.Event("activitiesToDecodeChange"));
            }
            return;
        }

        public override function get bikeCount():int
        {
            return 3;
        }

        public function get logTime5Sec():int
        {
            return _logTime5Sec;
        }

        public function get currentTotals():core.totals.Totals
        {
            return _currentTotals;
        }

        public function set currentTotals(arg1:core.totals.Totals):void
        {
            if (arg1 != _currentTotals) 
            {
                _currentTotals = arg1;
                dispatchEvent(new flash.events.Event("currentTotalsChange"));
            }
            return;
        }

        public override function get deviceGUID():Boolean
        {
            return false;
        }

        public function set powerZone2Start(arg1:int):void
        {
            if (_powerZone2Start !== arg1) 
            {
                _powerZone2Start = arg1;
                dispatchEvent(new flash.events.Event("powerZone2StartChange"));
            }
            return;
        }

        public function get freePackages():int
        {
            return _freePackages;
        }

        public function set freePackages(arg1:int):void
        {
            _freePackages = arg1;
            return;
        }

        public function set logTime5Sec(arg1:int):void
        {
            _logTime5Sec = arg1;
            return;
        }

        public function get loadedLogs():__AS3__.vec.Vector.<core.activities.Activity>
        {
            return _loadedLogs;
        }

        public function set loadedLogs(arg1:__AS3__.vec.Vector.<core.activities.Activity>):void
        {
            if (arg1 != _loadedLogs) 
            {
                _loadedLogs = arg1;
                dispatchEvent(new flash.events.Event("loadedLogsChange"));
            }
            return;
        }

        public function get powerZone1Start():int
        {
            return _powerZone1Start;
        }

        public function get loadedTracks():init.interfaces.IVectorList
        {
            return _loadedTracks;
        }

        public function set loadedTracks(arg1:init.interfaces.IVectorList):void
        {
            if (_loadedTracks !== arg1) 
            {
                _loadedTracks = arg1;
                dispatchEvent(new flash.events.Event("loadedTracksChange"));
            }
            return;
        }

        public function get maxPackages():int
        {
            return _maxPackages;
        }

        public function get logTime10Sec():int
        {
            return _logTime10Sec;
        }

        public function set logTime10Sec(arg1:int):void
        {
            _logTime10Sec = arg1;
            return;
        }

        public function set maxPackages(arg1:int):void
        {
            _maxPackages = arg1;
            return;
        }

        public function get logTime1Sec():int
        {
            return _logTime1Sec;
        }

        public function set logTime1Sec(arg1:int):void
        {
            _logTime1Sec = arg1;
            return;
        }

        public function set powerZone1Start(arg1:int):void
        {
            if (_powerZone1Start !== arg1) 
            {
                _powerZone1Start = arg1;
                dispatchEvent(new flash.events.Event("powerZone1StartChange"));
            }
            return;
        }

        public function get logTime20Sec():int
        {
            return _logTime20Sec;
        }

        public function set logTime20Sec(arg1:int):void
        {
            _logTime20Sec = arg1;
            return;
        }

        public function get memoryMapVersion():String
        {
            return _memoryMapVersion;
        }

        public function get logTime2Sec():int
        {
            return _logTime2Sec;
        }

        public function set logTime2Sec(arg1:int):void
        {
            _logTime2Sec = arg1;
            return;
        }

        public function set memoryMapVersion(arg1:String):void
        {
            if (_memoryMapVersion !== arg1) 
            {
                _memoryMapVersion = arg1;
                dispatchEvent(new flash.events.Event("memoryMapVersionChange"));
            }
            return;
        }

        public function get logTime30Sec():int
        {
            return _logTime30Sec;
        }

        public function get powerZone3Start():int
        {
            return _powerZone3Start;
        }

        public function set powerZone3Start(arg1:int):void
        {
            if (_powerZone3Start !== arg1) 
            {
                _powerZone3Start = arg1;
                dispatchEvent(new flash.events.Event("powerZone3StartChange"));
            }
            return;
        }

        public function get powerZone4Start():int
        {
            return _powerZone4Start;
        }

        public function set powerZone4Start(arg1:int):void
        {
            if (_powerZone4Start !== arg1) 
            {
                _powerZone4Start = arg1;
                dispatchEvent(new flash.events.Event("powerZone4StartChange"));
            }
            return;
        }

        public function get powerZone5Start():int
        {
            return _powerZone5Start;
        }

        public function set powerZone5Start(arg1:int):void
        {
            if (_powerZone5Start !== arg1) 
            {
                _powerZone5Start = arg1;
                dispatchEvent(new flash.events.Event("powerZone5StartChange"));
            }
            return;
        }

        public function get powerZone6Start():int
        {
            return _powerZone6Start;
        }

        public function set powerZone6Start(arg1:int):void
        {
            if (_powerZone6Start !== arg1) 
            {
                _powerZone6Start = arg1;
                dispatchEvent(new flash.events.Event("powerZone6StartChange"));
            }
            return;
        }

        public function get powerZone7End():int
        {
            return _powerZone7End;
        }

        public function set powerZone7End(arg1:int):void
        {
            if (_powerZone7End !== arg1) 
            {
                _powerZone7End = arg1;
                dispatchEvent(new flash.events.Event("powerZone7EndChange"));
            }
            return;
        }

        public function get powerZone7Start():int
        {
            return _powerZone7Start;
        }

        public function set powerZone7Start(arg1:int):void
        {
            if (_powerZone7Start !== arg1) 
            {
                _powerZone7Start = arg1;
                dispatchEvent(new flash.events.Event("powerZone7StartChange"));
            }
            return;
        }

        public function get thresholdPower():int
        {
            return _thresholdPower;
        }

        public function set thresholdPower(arg1:int):void
        {
            if (_thresholdPower !== arg1) 
            {
                _thresholdPower = arg1;
                dispatchEvent(new flash.events.Event("thresholdPowerChange"));
            }
            return;
        }

        public function get totalsVector():__AS3__.vec.Vector.<core.totals.Totals>
        {
            return _totalsVector;
        }

        public function set totalsVector(arg1:__AS3__.vec.Vector.<core.totals.Totals>):void
        {
            if (_totalsVector !== arg1) 
            {
                _totalsVector = arg1;
                dispatchEvent(new flash.events.Event("totalsVectorChange"));
            }
            return;
        }

        public static function getSoftwareRevisionNumber(arg1:String):Number
        {
            var loc1:*=arg1.split("-");
            var loc2:*=loc1[3];
            return loc2;
        }

        public function get trackList():init.interfaces.IVectorList
        {
            return _trackList;
        }

        public function set trackList(arg1:init.interfaces.IVectorList):void
        {
            if (_trackList !== arg1) 
            {
                _trackList = arg1;
                dispatchEvent(new flash.events.Event("trackListChange"));
            }
            return;
        }

        public function get tracksToDecode():__AS3__.vec.Vector.<core.route.Route>
        {
            return _tracksToDecode;
        }

        public function set tracksToDecode(arg1:__AS3__.vec.Vector.<core.route.Route>):void
        {
            if (_tracksToDecode !== arg1) 
            {
                _tracksToDecode = arg1;
                dispatchEvent(new flash.events.Event("tracksToDecodeChange"));
            }
            return;
        }

        public function get unitLogStatus():Boolean
        {
            return _unitLogStatus;
        }

        public function set unitLogStatus(arg1:Boolean):void
        {
            _unitLogStatus = arg1;
            return;
        }

        public function firmwareUpdateSupported():Boolean
        {
            return true;
        }

        public function bleFirmwareUpdateSupported():Boolean
        {
            return false;
        }

        public function getSamplingRates():Array
        {
            return [_sr1, _sr2, _sr5, _sr10, _sr20, _sr30];
        }

        public function getSamplingRateIds():Array
        {
            return [1, 2, 5, 10, 20, 30];
        }

        public function getSamplingRate(arg1:Number):Number
        {
            var loc1:*=NaN;
            var loc2:*=arg1;
            while (1 === loc2) 
            {
                loc1 = _sr1;
            }
        }

        public function getSamplingRateId(arg1:Number):Number
        {
            var loc1:*=NaN;
            var loc2:*=arg1;
            while (_sr1 === loc2) 
            {
                loc1 = 1;
            }
        }

        public override function toString():String
        {
            return "[ROX100 extends UnitROX]";
        }

        public function calculatePowerZonesByThreshold():void
        {
            powerZone1Start = 0;
            powerZone2Start = thresholdPower / 100 * 56;
            powerZone3Start = thresholdPower / 100 * 76;
            powerZone4Start = thresholdPower / 100 * 91;
            powerZone5Start = thresholdPower / 100 * 106;
            powerZone6Start = thresholdPower / 100 * 121;
            powerZone7Start = thresholdPower / 100 * 151;
            powerZone7End = 2000;
            return;
        }

        internal function onTotalsChanged(arg1:flash.events.Event):void
        {
            totalsVectorList = init.BackendInitializer.getInstance().createVectorList(_totalsVector);
            return;
        }

        internal var _logTime5Sec:int=0;

        internal var _maxPackages:int=0;

        internal var _thresholdPower:int=253;

        protected var _memoryMapVersion:String="";

        internal var _powerZone1Start:Number=0;

        internal var _totalsVector:__AS3__.vec.Vector.<core.totals.Totals>;

        internal var _powerZone2Start:int=141;

        internal var _freePackages:int=0;

        internal var _powerZone3Start:int=191;

        internal var _activities:__AS3__.vec.Vector.<core.activities.Activity>;

        internal var _activitiesToDecode:__AS3__.vec.Vector.<core.activities.Activity>;

        internal var _tracksToDecode:__AS3__.vec.Vector.<core.route.Route>;

        internal var _powerZone4Start:int=231;

        internal var _currentTotals:core.totals.Totals;

        internal var _unitLogStatus:Boolean=true;

        internal var _loadedLogs:__AS3__.vec.Vector.<core.activities.Activity>;

        internal var _powerZone5Start:int=261;

        internal var _sr1:Number=1;

        internal var _sr10:Number=10;

        internal var _sr2:Number=2;

        internal var _trackList:init.interfaces.IVectorList;

        internal var _sr30:Number=30;

        internal var _sr5:Number=5;

        internal var _loadedTracks:init.interfaces.IVectorList;

        internal var _logTime10Sec:int=0;

        internal var _powerZone6Start:int=301;

        internal var _logTime1Sec:int=0;

        internal var _logTime20Sec:int=0;

        internal var _powerZone7End:int=2000;

        internal var _logTime2Sec:int=0;

        internal var _logTime30Sec:int=0;

        internal var _powerZone7Start:int=367;

        internal var _sr20:Number=20;
    }
}


//  class UnitROX110
package core.units 
{
    import __AS3__.vec.*;
    import core.activities.*;
    import core.general.*;
    import core.notification.*;
    import core.route.*;
    import core.sportprofiles.*;
    import core.strava.*;
    import core.totals.*;
    import core.training.*;
    import core.units.interfaces.*;
    import flash.events.*;
    import init.*;
    import init.interfaces.*;
    
    public class UnitROX110 extends core.units.UnitBikeComputer implements core.units.interfaces.IUSBDeviceInfo, core.units.interfaces.IBLEDeviceInfo, core.units.interfaces.INotificationEvent, core.units.interfaces.ILogList, core.units.interfaces.ILogTime1Sec, core.units.interfaces.ILogTime2Sec, core.units.interfaces.ILogTime5Sec, core.units.interfaces.ILogTime10Sec, core.units.interfaces.ILogTime20Sec, core.units.interfaces.ILogStatus, core.units.interfaces.IUnitSamplingRate, core.units.interfaces.IDataToDecode, core.units.interfaces.ITrackList, core.units.interfaces.IMemoryMapVersion, core.units.interfaces.IFirmwareUpdateSupported, core.units.interfaces.IStravaSegmentsSupported, core.units.interfaces.ISportProfiles, core.units.interfaces.ITotalsList, core.units.interfaces.ITrainingsList
    {
        public function UnitROX110()
        {
            _activities = new __AS3__.vec.Vector.<core.activities.Activity>();
            _activitiesToDecode = new __AS3__.vec.Vector.<core.activities.Activity>();
            _loadedLogs = new __AS3__.vec.Vector.<core.activities.Activity>();
            _loadedTracks = init.BackendInitializer.getInstance().createVectorList();
            _sportprofilesList = new __AS3__.vec.Vector.<core.sportprofiles.Sportprofile>();
            _sportprofilesVectorlist = init.BackendInitializer.getInstance().createVectorList();
            _totalsVector = new __AS3__.vec.Vector.<core.totals.Totals>();
            _trackList = init.BackendInitializer.getInstance().createVectorList();
            _tracksToDecode = new __AS3__.vec.Vector.<core.route.Route>();
            _trainingsOnDeviceList = new __AS3__.vec.Vector.<core.training.Training>();
            _trainingsToDelete = new __AS3__.vec.Vector.<core.training.Training>();
            _trainingsVectorList = init.BackendInitializer.getInstance().createVectorList();
            _trainings = new __AS3__.vec.Vector.<core.training.Training>();
            super();
            type = core.general.UnitType.ROX110;
            primaryServiceUUID = "5762";
            addEventListener("totalsChanged", onTotalsChanged, false, 0, true);
            addEventListener("totalRemoved", onTotalsChanged, false, 0, true);
            addEventListener("trainingsChanged", onTrainingsChanged, false, 0, true);
            addEventListener("sportprofilesChanged", onSportprofilesChanged, false, 0, true);
            return;
        }

        public function get trainingsList():__AS3__.vec.Vector.<core.training.Training>
        {
            return _trainings;
        }

        public function get activities():__AS3__.vec.Vector.<core.activities.Activity>
        {
            return _activities;
        }

        public function set activities(arg1:__AS3__.vec.Vector.<core.activities.Activity>):void
        {
            if (_activities !== arg1) 
            {
                _activities = arg1;
                dispatchEvent(new flash.events.Event("activitiesChange"));
            }
            return;
        }

        public function set trainingsList(arg1:__AS3__.vec.Vector.<core.training.Training>):void
        {
            if (arg1 != _trainings) 
            {
                _trainings = arg1;
                dispatchEvent(new flash.events.Event("trainingsChanged"));
            }
            return;
        }

        public function get activitiesToDecode():__AS3__.vec.Vector.<core.activities.Activity>
        {
            return _activitiesToDecode;
        }

        public function set activitiesToDecode(arg1:__AS3__.vec.Vector.<core.activities.Activity>):void
        {
            if (_activitiesToDecode !== arg1) 
            {
                _activitiesToDecode = arg1;
                dispatchEvent(new flash.events.Event("activitiesToDecodeChange"));
            }
            return;
        }

        public override function get bikeCount():int
        {
            return 0;
        }

        public function get trainingsOnDeviceList():__AS3__.vec.Vector.<core.training.Training>
        {
            return _trainingsOnDeviceList;
        }

        public function get currentSportProfileIndex():uint
        {
            return _currentSportProfileIndex;
        }

        public function set currentSportProfileIndex(arg1:uint):void
        {
            _currentSportProfileIndex = arg1;
            return;
        }

        public function set trainingsOnDeviceList(arg1:__AS3__.vec.Vector.<core.training.Training>):void
        {
            _trainingsOnDeviceList = arg1;
            return;
        }

        public function get currentStravaSegment():core.strava.StravaSegment
        {
            return _currentStravaSegment;
        }

        public function set currentStravaSegment(arg1:core.strava.StravaSegment):void
        {
            _currentStravaSegment = arg1;
            return;
        }

        public function get trainingsToDelete():__AS3__.vec.Vector.<core.training.Training>
        {
            return _trainingsToDelete;
        }

        public function get currentTotals():core.totals.Totals
        {
            return _currentTotals;
        }

        public function set currentTotals(arg1:core.totals.Totals):void
        {
            if (arg1 != _currentTotals) 
            {
                _currentTotals = arg1;
                dispatchEvent(new flash.events.Event("currentTotalsChange"));
            }
            return;
        }

        public function get deviceID():String
        {
            return _bleDeviceId;
        }

        public function set deviceID(arg1:String):void
        {
            _bleDeviceId = arg1;
            return;
        }

        public function set trainingsToDelete(arg1:__AS3__.vec.Vector.<core.training.Training>):void
        {
            _trainingsToDelete = arg1;
            return;
        }

        public function get dsHandler():String
        {
            return _dsHandler;
        }

        public function set dsHandler(arg1:String):void
        {
            _dsHandler = arg1;
            return;
        }

        public function get trainingsVectorList():init.interfaces.IVectorList
        {
            return _trainingsVectorList;
        }

        public function get freePackages():int
        {
            return _freePackages;
        }

        public function set freePackages(arg1:int):void
        {
            _freePackages = arg1;
            return;
        }

        public function set trainingsVectorList(arg1:init.interfaces.IVectorList):void
        {
            _trainingsVectorList = arg1;
            return;
        }

        public function get loadedLogs():__AS3__.vec.Vector.<core.activities.Activity>
        {
            return _loadedLogs;
        }

        public function set loadedLogs(arg1:__AS3__.vec.Vector.<core.activities.Activity>):void
        {
            if (arg1 != _loadedLogs) 
            {
                _loadedLogs = arg1;
                dispatchEvent(new flash.events.Event("loadedLogsChange"));
            }
            return;
        }

        public function get unitLogStatus():Boolean
        {
            return _unitLogStatus;
        }

        public function set unitLogStatus(arg1:Boolean):void
        {
            _unitLogStatus = arg1;
            return;
        }

        public function get loadedSportProfiles():__AS3__.vec.Vector.<core.sportprofiles.Sportprofile>
        {
            return _loadedSportProfiles;
        }

        public function set loadedSportProfiles(arg1:__AS3__.vec.Vector.<core.sportprofiles.Sportprofile>):void
        {
            _loadedSportProfiles = arg1;
            return;
        }

        public static function getSoftwareRevisionNumber(arg1:String):Number
        {
            var loc1:*=arg1.split("-");
            var loc2:*=loc1[3];
            return loc2;
        }

        public function get loadedTracks():init.interfaces.IVectorList
        {
            return _loadedTracks;
        }

        public function set loadedTracks(arg1:init.interfaces.IVectorList):void
        {
            if (_loadedTracks !== arg1) 
            {
                _loadedTracks = arg1;
                dispatchEvent(new flash.events.Event("loadedTracksChange"));
            }
            return;
        }

        public function get localName():String
        {
            return _bleLocalName;
        }

        public function set localName(arg1:String):void
        {
            _bleLocalName = arg1;
            return;
        }

        public function firmwareUpdateSupported():Boolean
        {
            return true;
        }

        public function get logTime10Sec():int
        {
            return _logTime10Sec;
        }

        public function set logTime10Sec(arg1:int):void
        {
            _logTime10Sec = arg1;
            return;
        }

        public function bleFirmwareUpdateSupported():Boolean
        {
            return true;
        }

        public function get logTime1Sec():int
        {
            return _logTime1Sec;
        }

        public function set logTime1Sec(arg1:int):void
        {
            _logTime1Sec = arg1;
            return;
        }

        public function getSamplingRates():Array
        {
            return [_sr1, _sr2, _sr5, _sr10, _sr20];
        }

        public function get logTime20Sec():int
        {
            return _logTime20Sec;
        }

        public function set logTime20Sec(arg1:int):void
        {
            _logTime20Sec = arg1;
            return;
        }

        public function getSamplingRateIds():Array
        {
            return [1, 2, 5, 10, 20];
        }

        public function get logTime2Sec():int
        {
            return _logTime2Sec;
        }

        public function set logTime2Sec(arg1:int):void
        {
            _logTime2Sec = arg1;
            return;
        }

        public function getSamplingRate(arg1:Number):Number
        {
            var loc1:*=NaN;
            var loc2:*=arg1;
            while (1 === loc2) 
            {
                loc1 = _sr1;
            }
        }

        public function get logTime5Sec():int
        {
            return _logTime5Sec;
        }

        public function set logTime5Sec(arg1:int):void
        {
            _logTime5Sec = arg1;
            return;
        }

        public function getSamplingRateId(arg1:Number):Number
        {
            var loc1:*=NaN;
            var loc2:*=arg1;
            while (_sr1 === loc2) 
            {
                loc1 = 1;
            }
        }

        public function get maxPackages():int
        {
            return _maxPackages;
        }

        public function set maxPackages(arg1:int):void
        {
            _maxPackages = arg1;
            return;
        }

        public function addSportProfile(arg1:core.sportprofiles.Sportprofile):void
        {
            sportprofilesList.push(arg1);
            dispatchEvent(new flash.events.Event("sportprofilesListChange"));
            return;
        }

        public function get memoryMapVersion():String
        {
            return _memoryMapVersion;
        }

        public function set memoryMapVersion(arg1:String):void
        {
            if (_memoryMapVersion !== arg1) 
            {
                _memoryMapVersion = arg1;
                dispatchEvent(new flash.events.Event("memoryMapVersionChange"));
            }
            return;
        }

        public override function toString():String
        {
            return "[ROX110 extends UnitROX]";
        }

        public function get notificationEvent():core.notification.NotificationEvent
        {
            return _notificationEvent;
        }

        public function set notificationEvent(arg1:core.notification.NotificationEvent):void
        {
            _notificationEvent = arg1;
            return;
        }

        public function calculatePowerZonesByThreshold():void
        {
            powerZone1Start = 0;
            powerZone2Start = thresholdPower / 100 * 56;
            powerZone3Start = thresholdPower / 100 * 76;
            powerZone4Start = thresholdPower / 100 * 91;
            powerZone5Start = thresholdPower / 100 * 106;
            powerZone6Start = thresholdPower / 100 * 121;
            powerZone7Start = thresholdPower / 100 * 151;
            powerZone7End = 2000;
            return;
        }

        public function get powerZone1Start():int
        {
            return _powerZone1Start;
        }

        public function set powerZone1Start(arg1:int):void
        {
            if (_powerZone1Start !== arg1) 
            {
                _powerZone1Start = arg1;
                dispatchEvent(new flash.events.Event("powerZone1StartChange"));
            }
            return;
        }

        internal function onTotalsChanged(arg1:flash.events.Event):void
        {
            totalsVectorList = init.BackendInitializer.getInstance().createVectorList(_totalsVector);
            return;
        }

        public function get powerZone2Start():int
        {
            return _powerZone2Start;
        }

        public function set powerZone2Start(arg1:int):void
        {
            if (_powerZone2Start !== arg1) 
            {
                _powerZone2Start = arg1;
                dispatchEvent(new flash.events.Event("powerZone2StartChange"));
            }
            return;
        }

        internal function onSportprofilesChanged(arg1:flash.events.Event):void
        {
            sportprofilesVectorlist = init.BackendInitializer.getInstance().createVectorList(_sportprofilesList);
            return;
        }

        public function get powerZone3Start():int
        {
            return _powerZone3Start;
        }

        public function set powerZone3Start(arg1:int):void
        {
            if (_powerZone3Start !== arg1) 
            {
                _powerZone3Start = arg1;
                dispatchEvent(new flash.events.Event("powerZone3StartChange"));
            }
            return;
        }

        internal function onTrainingsChanged(arg1:flash.events.Event):void
        {
            trainingsVectorList = init.BackendInitializer.getInstance().createVectorList(_trainings);
            return;
        }

        public function get powerZone4Start():int
        {
            return _powerZone4Start;
        }

        public function set powerZone4Start(arg1:int):void
        {
            if (_powerZone4Start !== arg1) 
            {
                _powerZone4Start = arg1;
                dispatchEvent(new flash.events.Event("powerZone4StartChange"));
            }
            return;
        }

        public function get powerZone5Start():int
        {
            return _powerZone5Start;
        }

        public function set powerZone5Start(arg1:int):void
        {
            if (_powerZone5Start !== arg1) 
            {
                _powerZone5Start = arg1;
                dispatchEvent(new flash.events.Event("powerZone5StartChange"));
            }
            return;
        }

        public function get powerZone6Start():int
        {
            return _powerZone6Start;
        }

        public function set powerZone6Start(arg1:int):void
        {
            if (_powerZone6Start !== arg1) 
            {
                _powerZone6Start = arg1;
                dispatchEvent(new flash.events.Event("powerZone6StartChange"));
            }
            return;
        }

        public function get powerZone7End():int
        {
            return _powerZone7End;
        }

        public function set powerZone7End(arg1:int):void
        {
            if (_powerZone7End !== arg1) 
            {
                _powerZone7End = arg1;
                dispatchEvent(new flash.events.Event("powerZone7EndChange"));
            }
            return;
        }

        public function get powerZone7Start():int
        {
            return _powerZone7Start;
        }

        public function set powerZone7Start(arg1:int):void
        {
            if (_powerZone7Start !== arg1) 
            {
                _powerZone7Start = arg1;
                dispatchEvent(new flash.events.Event("powerZone7StartChange"));
            }
            return;
        }

        public function get primaryServiceUUID():String
        {
            return _bleServiceUUID;
        }

        public function set primaryServiceUUID(arg1:String):void
        {
            _bleServiceUUID = arg1;
            return;
        }

        public function get sportprofilesList():__AS3__.vec.Vector.<core.sportprofiles.Sportprofile>
        {
            return _sportprofilesList;
        }

        public function set sportprofilesList(arg1:__AS3__.vec.Vector.<core.sportprofiles.Sportprofile>):void
        {
            if (arg1 != _sportprofilesList) 
            {
                _sportprofilesList = arg1;
                dispatchEvent(new flash.events.Event("sportprofilesListChange"));
            }
            return;
        }

        public function get sportprofilesVectorlist():init.interfaces.IVectorList
        {
            return _sportprofilesVectorlist;
        }

        public function set sportprofilesVectorlist(arg1:init.interfaces.IVectorList):void
        {
            _sportprofilesVectorlist = arg1;
            return;
        }

        public function get supportMultipleTrainings():Boolean
        {
            return true;
        }

        public function get thresholdPower():int
        {
            return _thresholdPower;
        }

        public function set thresholdPower(arg1:int):void
        {
            if (_thresholdPower !== arg1) 
            {
                _thresholdPower = arg1;
                dispatchEvent(new flash.events.Event("thresholdPowerChange"));
            }
            return;
        }

        public function get totalsVector():__AS3__.vec.Vector.<core.totals.Totals>
        {
            return _totalsVector;
        }

        public function set totalsVector(arg1:__AS3__.vec.Vector.<core.totals.Totals>):void
        {
            if (_totalsVector !== arg1) 
            {
                _totalsVector = arg1;
                dispatchEvent(new flash.events.Event("totalsVectorChange"));
            }
            return;
        }

        public function get trackList():init.interfaces.IVectorList
        {
            return _trackList;
        }

        public function set trackList(arg1:init.interfaces.IVectorList):void
        {
            if (_trackList !== arg1) 
            {
                _trackList = arg1;
                dispatchEvent(new flash.events.Event("trackListChange"));
            }
            return;
        }

        public function get tracksToDecode():__AS3__.vec.Vector.<core.route.Route>
        {
            return _tracksToDecode;
        }

        public function set tracksToDecode(arg1:__AS3__.vec.Vector.<core.route.Route>):void
        {
            if (_tracksToDecode !== arg1) 
            {
                _tracksToDecode = arg1;
                dispatchEvent(new flash.events.Event("tracksToDecodeChange"));
            }
            return;
        }

        public static const PRIMARY_SERVICE_UUID:String="5762";

        public static const RECEIVE_CHARACTERISTIC_UUID:String="c1b6";

        public static const SEND_CHARACTERISTIC_UUID:String="b3ba";

        internal var _currentStravaSegment:core.strava.StravaSegment;

        internal var _currentTotals:core.totals.Totals;

        internal var _dsHandler:String;

        internal var _freePackages:int=0;

        internal var _loadedLogs:__AS3__.vec.Vector.<core.activities.Activity>;

        public var loadedPrograms:init.interfaces.IVectorList;

        internal var _loadedSportProfiles:__AS3__.vec.Vector.<core.sportprofiles.Sportprofile>;

        internal var _loadedTracks:init.interfaces.IVectorList;

        internal var _logTime10Sec:int=0;

        internal var _logTime1Sec:int=0;

        internal var _logTime20Sec:int=0;

        internal var _logTime2Sec:int=0;

        internal var _logTime5Sec:int=0;

        internal var _maxPackages:int=0;

        protected var _memoryMapVersion:String="";

        internal var _notificationEvent:core.notification.NotificationEvent;

        internal var _powerZone1Start:Number=0;

        internal var _powerZone2Start:int=141;

        internal var _powerZone3Start:int=191;

        internal var _powerZone4Start:int=231;

        internal var _powerZone7End:int=2000;

        internal var _sr1:Number=1;

        internal var _sr10:Number=10;

        internal var _sr2:Number=2;

        internal var _sr20:Number=20;

        internal var _powerZone5Start:int=261;

        internal var _trainings:__AS3__.vec.Vector.<core.training.Training>;

        internal var _totalsVector:__AS3__.vec.Vector.<core.totals.Totals>;

        internal var _trainingsOnDeviceList:__AS3__.vec.Vector.<core.training.Training>;

        internal var _sportprofilesVectorlist:init.interfaces.IVectorList;

        internal var _powerZone6Start:int=301;

        internal var _trainingsToDelete:__AS3__.vec.Vector.<core.training.Training>;

        internal var _trackList:init.interfaces.IVectorList;

        internal var _powerZone7Start:int=367;

        internal var _trainingsVectorList:init.interfaces.IVectorList;

        internal var _sportprofilesList:__AS3__.vec.Vector.<core.sportprofiles.Sportprofile>;

        internal var _tracksToDecode:__AS3__.vec.Vector.<core.route.Route>;

        internal var _unitLogStatus:Boolean=true;

        internal var _thresholdPower:int=253;

        internal var _activities:__AS3__.vec.Vector.<core.activities.Activity>;

        internal var _activitiesToDecode:__AS3__.vec.Vector.<core.activities.Activity>;

        internal var _currentSportProfileIndex:uint;

        internal var _sr5:Number=5;
    }
}


//  class UnitROX2010
package core.units 
{
    import __AS3__.vec.*;
    import core.totals.*;
    import core.units.interfaces.*;
    import flash.events.*;
    import init.*;
    
    public class UnitROX2010 extends core.units.UnitBikeComputer implements core.units.interfaces.IDSTDeviceInfo, core.units.interfaces.IUnitBatteryStatus, core.units.interfaces.ISpeedTXBatteryStatus, core.units.interfaces.ICadenceTXBatteryStatus, core.units.interfaces.IHeartrateTXBatteryStatus, core.units.interfaces.IDateCode, core.units.interfaces.IUnitSamplingRate, core.units.interfaces.ITotalsList
    {
        public function UnitROX2010()
        {
            _totalsVector = new __AS3__.vec.Vector.<core.totals.Totals>();
            super();
            addEventListener("totalsChanged", onTotalsChanged, false, 0, true);
            addEventListener("totalRemoved", onTotalsChanged, false, 0, true);
            return;
        }

        public function set unitBatteryStatus(arg1:Boolean):void
        {
            if (arg1 != _unitBatteryStatus) 
            {
                _unitBatteryStatus = arg1;
                dispatchEvent(new flash.events.Event("unitBatteryStatusChange"));
            }
            return;
        }

        public function get cadenceTXBatteryStatus():Boolean
        {
            return _cadenceTXBatteryStatus;
        }

        public function set cadenceTXBatteryStatus(arg1:Boolean):void
        {
            if (arg1 != _cadenceTXBatteryStatus) 
            {
                _cadenceTXBatteryStatus = arg1;
                dispatchEvent(new flash.events.Event("cadenceTXBatteryStatusChange"));
            }
            return;
        }

        public function getSamplingRates():Array
        {
            return [_sr5, _sr10, _sr20, _sr30];
        }

        public function get currentTotals():core.totals.Totals
        {
            return _currentTotals;
        }

        public function set currentTotals(arg1:core.totals.Totals):void
        {
            if (arg1 != _currentTotals) 
            {
                _currentTotals = arg1;
                dispatchEvent(new flash.events.Event("currentTotalsChange"));
            }
            return;
        }

        public function getSamplingRateIds():Array
        {
            return [5, 10, 20, 30];
        }

        public function get dateCode():Date
        {
            return _dateCode;
        }

        public function set dateCode(arg1:Date):void
        {
            _dateCode = arg1;
            return;
        }

        public function getSamplingRate(arg1:Number):Number
        {
            var loc1:*=NaN;
            var loc2:*=arg1;
            while (5 === loc2) 
            {
                loc1 = _sr5;
            }
        }

        public function get heartrateTXBatteryStatus():Boolean
        {
            return _heartrateTXBatteryStatus;
        }

        public function set heartrateTXBatteryStatus(arg1:Boolean):void
        {
            if (arg1 != _heartrateTXBatteryStatus) 
            {
                _heartrateTXBatteryStatus = arg1;
                dispatchEvent(new flash.events.Event("heartrateTXBatteryStatusChange"));
            }
            return;
        }

        public function getSamplingRateId(arg1:Number):Number
        {
            var loc1:*=NaN;
            var loc2:*=arg1;
            while (_sr5 === loc2) 
            {
                loc1 = 5;
            }
        }

        public function get initialWakeUpInfo():String
        {
            return _initialWakeUpInfo;
        }

        public function set initialWakeUpInfo(arg1:String):void
        {
            _initialWakeUpInfo = arg1;
            return;
        }

        internal function onTotalsChanged(arg1:flash.events.Event):void
        {
            totalsVectorList = init.BackendInitializer.getInstance().createVectorList(_totalsVector);
            return;
        }

        public override function toString():String
        {
            return "[UnitROX extends Unit implements IMemoryList, IUnitBatteryStatus, ISpeedTXBatteryStatus, ICadenceTXBatteryStatus, IHeartrateTXBatteryStatus, IDateCode]";
        }

        public function get maskingCode():String
        {
            return _maskingCode;
        }

        public function set maskingCode(arg1:String):void
        {
            _maskingCode = arg1;
            return;
        }

        public function get speedTXBatteryStatus():Boolean
        {
            return _speedTXBatteryStatus;
        }

        public function set speedTXBatteryStatus(arg1:Boolean):void
        {
            if (arg1 != _speedTXBatteryStatus) 
            {
                _speedTXBatteryStatus = arg1;
                dispatchEvent(new flash.events.Event("speedTXBatteryStatusChange"));
            }
            return;
        }

        public function get totalsVector():__AS3__.vec.Vector.<core.totals.Totals>
        {
            return _totalsVector;
        }

        public function set totalsVector(arg1:__AS3__.vec.Vector.<core.totals.Totals>):void
        {
            if (_totalsVector !== arg1) 
            {
                _totalsVector = arg1;
                dispatchEvent(new flash.events.Event("totalsVectorChange"));
            }
            return;
        }

        public function get unitBatteryStatus():Boolean
        {
            return _unitBatteryStatus;
        }

        public const length:Number=128;

        protected var _cadenceTXBatteryStatus:Boolean;

        internal var _currentTotals:core.totals.Totals;

        internal var _dateCode:Date;

        protected var _heartrateTXBatteryStatus:Boolean;

        internal var _initialWakeUpInfo:String;

        internal var _maskingCode:String;

        internal var _sr5:Number=4.5;

        protected var _unitBatteryStatus:Boolean;

        protected var _speedTXBatteryStatus:Boolean;

        internal var _totalsVector:__AS3__.vec.Vector.<core.totals.Totals>;

        internal var _sr10:Number=10.125;

        internal var _sr20:Number=20.25;

        internal var _sr30:Number=30.375;
    }
}


//  class UnitROX2012
package core.units 
{
    import __AS3__.vec.*;
    import core.activities.*;
    import core.totals.*;
    import core.units.interfaces.*;
    import flash.events.*;
    import init.*;
    
    public class UnitROX2012 extends core.units.UnitBikeComputer implements core.units.interfaces.IDSTDeviceInfo, core.units.interfaces.ILogList, core.units.interfaces.ILogStatus, core.units.interfaces.IUnitBatteryStatus, core.units.interfaces.IUnitSamplingRate, core.units.interfaces.ITotalsList
    {
        public function UnitROX2012()
        {
            _activities = new __AS3__.vec.Vector.<core.activities.Activity>();
            _loadedLogs = new __AS3__.vec.Vector.<core.activities.Activity>();
            _totalsVector = new __AS3__.vec.Vector.<core.totals.Totals>();
            super();
            addEventListener("totalsChanged", onTotalsChanged, false, 0, true);
            addEventListener("totalRemoved", onTotalsChanged, false, 0, true);
            return;
        }

        public function get activities():__AS3__.vec.Vector.<core.activities.Activity>
        {
            return _activities;
        }

        public function set activities(arg1:__AS3__.vec.Vector.<core.activities.Activity>):void
        {
            if (_activities !== arg1) 
            {
                _activities = arg1;
                dispatchEvent(new flash.events.Event("activitiesChange"));
            }
            return;
        }

        public override function get bikeCount():int
        {
            return 2;
        }

        public function get currentTotals():core.totals.Totals
        {
            return _currentTotals;
        }

        public function set currentTotals(arg1:core.totals.Totals):void
        {
            if (arg1 != _currentTotals) 
            {
                _currentTotals = arg1;
                dispatchEvent(new flash.events.Event("currentTotalsChange"));
            }
            return;
        }

        public function get freePackages():int
        {
            return _freePackages;
        }

        public function set freePackages(arg1:int):void
        {
            _freePackages = arg1;
            return;
        }

        public function get loadedLogs():__AS3__.vec.Vector.<core.activities.Activity>
        {
            return _loadedLogs;
        }

        public function set loadedLogs(arg1:__AS3__.vec.Vector.<core.activities.Activity>):void
        {
            if (arg1 != _loadedLogs) 
            {
                _loadedLogs = arg1;
                dispatchEvent(new flash.events.Event("loadedLogsChange"));
            }
            return;
        }

        public function get maxPackages():int
        {
            return _maxPackages;
        }

        public function set maxPackages(arg1:int):void
        {
            _maxPackages = arg1;
            return;
        }

        public function get totalsVector():__AS3__.vec.Vector.<core.totals.Totals>
        {
            return _totalsVector;
        }

        public function set totalsVector(arg1:__AS3__.vec.Vector.<core.totals.Totals>):void
        {
            if (_totalsVector !== arg1) 
            {
                _totalsVector = arg1;
                dispatchEvent(new flash.events.Event("totalsVectorChange"));
            }
            return;
        }

        public function get unitBatteryStatus():Boolean
        {
            return _unitBatteryStatus;
        }

        public function set unitBatteryStatus(arg1:Boolean):void
        {
            if (arg1 != _unitBatteryStatus) 
            {
                _unitBatteryStatus = arg1;
            }
            return;
        }

        public function get unitLogStatus():Boolean
        {
            return _unitLogStatus;
        }

        public function set unitLogStatus(arg1:Boolean):void
        {
            _unitLogStatus = arg1;
            return;
        }

        public function getSamplingRates():Array
        {
            return [10];
        }

        public function getSamplingRateIds():Array
        {
            return [10];
        }

        public function getSamplingRate(arg1:Number):Number
        {
            return 10;
        }

        public function getSamplingRateId(arg1:Number):Number
        {
            return 10;
        }

        internal function onTotalsChanged(arg1:flash.events.Event):void
        {
            totalsVectorList = init.BackendInitializer.getInstance().createVectorList(_totalsVector);
            return;
        }

        public override function toString():String
        {
            return "[UnitROX extends Unit implements IMemoryList, IUnitBatteryStatus, ISpeedTXBatteryStatus, ICadenceTXBatteryStatus, IHeartrateTXBatteryStatus, IDateCode]";
        }

        internal var _activities:__AS3__.vec.Vector.<core.activities.Activity>;

        internal var _currentTotals:core.totals.Totals;

        internal var _freePackages:int=0;

        internal var _loadedLogs:__AS3__.vec.Vector.<core.activities.Activity>;

        internal var _maxPackages:int=0;

        internal var _totalsVector:__AS3__.vec.Vector.<core.totals.Totals>;

        internal var _unitBatteryStatus:Boolean=false;

        internal var _unitLogStatus:Boolean=true;
    }
}


//  class UnitROX50
package core.units 
{
    import core.general.*;
    
    public class UnitROX50 extends core.units.UnitROX2012
    {
        public function UnitROX50()
        {
            super();
            type = core.general.UnitType.ROX50;
            return;
        }

        public override function get deviceGUID():Boolean
        {
            return false;
        }

        public override function toString():String
        {
            return "[UnitROX50 extends UnitROX]";
        }
    }
}


//  class UnitROX60
package core.units 
{
    import core.general.*;
    
    public class UnitROX60 extends core.units.UnitROX2012
    {
        public function UnitROX60()
        {
            super();
            type = core.general.UnitType.ROX60;
            return;
        }

        public override function get deviceGUID():Boolean
        {
            return false;
        }

        public override function toString():String
        {
            return "[UnitROX60 extends UnitROX]";
        }
    }
}


//  class UnitROX70
package core.units 
{
    import __AS3__.vec.*;
    import core.activities.*;
    import core.general.*;
    import core.route.*;
    import core.sportprofiles.*;
    import core.strava.*;
    import core.totals.*;
    import core.units.interfaces.*;
    import flash.events.*;
    import init.*;
    import init.interfaces.*;
    
    public class UnitROX70 extends core.units.UnitBikeComputer implements core.units.interfaces.IUSBDeviceInfo, core.units.interfaces.ILogList, core.units.interfaces.ILogTime5Sec, core.units.interfaces.ILogStatus, core.units.interfaces.IDataToDecode, core.units.interfaces.ITrackList, core.units.interfaces.IMemoryMapVersion, core.units.interfaces.IFirmwareUpdateSupported, core.units.interfaces.IStravaSegmentsSupported, core.units.interfaces.ISportProfiles, core.units.interfaces.ITotalsList
    {
        public function UnitROX70()
        {
            _activities = new __AS3__.vec.Vector.<core.activities.Activity>();
            _activitiesToDecode = new __AS3__.vec.Vector.<core.activities.Activity>();
            _loadedLogs = new __AS3__.vec.Vector.<core.activities.Activity>();
            _loadedTracks = init.BackendInitializer.getInstance().createVectorList();
            _sportprofilesList = new __AS3__.vec.Vector.<core.sportprofiles.Sportprofile>();
            _sportprofilesVectorlist = init.BackendInitializer.getInstance().createVectorList();
            _totalsVector = new __AS3__.vec.Vector.<core.totals.Totals>();
            _trackList = init.BackendInitializer.getInstance().createVectorList();
            _tracksToDecode = new __AS3__.vec.Vector.<core.route.Route>();
            super();
            type = core.general.UnitType.ROX70;
            addEventListener("totalsChanged", onTotalsChanged, false, 0, true);
            addEventListener("totalRemoved", onTotalsChanged, false, 0, true);
            addEventListener("sportprofilesChanged", onSportprofilesChanged, false, 0, true);
            return;
        }

        public function get totalsVector():__AS3__.vec.Vector.<core.totals.Totals>
        {
            return _totalsVector;
        }

        public function get activities():__AS3__.vec.Vector.<core.activities.Activity>
        {
            return _activities;
        }

        public function set activities(arg1:__AS3__.vec.Vector.<core.activities.Activity>):void
        {
            if (_activities !== arg1) 
            {
                _activities = arg1;
                dispatchEvent(new flash.events.Event("activitiesChange"));
            }
            return;
        }

        public function set totalsVector(arg1:__AS3__.vec.Vector.<core.totals.Totals>):void
        {
            if (_totalsVector !== arg1) 
            {
                _totalsVector = arg1;
                dispatchEvent(new flash.events.Event("totalsVectorChange"));
            }
            return;
        }

        public function get activitiesToDecode():__AS3__.vec.Vector.<core.activities.Activity>
        {
            return _activitiesToDecode;
        }

        public function set activitiesToDecode(arg1:__AS3__.vec.Vector.<core.activities.Activity>):void
        {
            if (_activitiesToDecode !== arg1) 
            {
                _activitiesToDecode = arg1;
                dispatchEvent(new flash.events.Event("activitiesToDecodeChange"));
            }
            return;
        }

        public override function get bikeCount():int
        {
            return 0;
        }

        public function get trackList():init.interfaces.IVectorList
        {
            return _trackList;
        }

        public function get currentSportProfileIndex():uint
        {
            return _currentSportProfileIndex;
        }

        public function set currentSportProfileIndex(arg1:uint):void
        {
            _currentSportProfileIndex = arg1;
            return;
        }

        public function set loadedLogs(arg1:__AS3__.vec.Vector.<core.activities.Activity>):void
        {
            if (arg1 != _loadedLogs) 
            {
                _loadedLogs = arg1;
                dispatchEvent(new flash.events.Event("loadedLogsChange"));
            }
            return;
        }

        public function get currentStravaSegment():core.strava.StravaSegment
        {
            return _currentStravaSegment;
        }

        public function set currentStravaSegment(arg1:core.strava.StravaSegment):void
        {
            _currentStravaSegment = arg1;
            return;
        }

        public function set trackList(arg1:init.interfaces.IVectorList):void
        {
            if (_trackList !== arg1) 
            {
                _trackList = arg1;
                dispatchEvent(new flash.events.Event("trackListChange"));
            }
            return;
        }

        public function get currentTotals():core.totals.Totals
        {
            return _currentTotals;
        }

        public function set currentTotals(arg1:core.totals.Totals):void
        {
            if (arg1 != _currentTotals) 
            {
                _currentTotals = arg1;
                dispatchEvent(new flash.events.Event("currentTotalsChange"));
            }
            return;
        }

        public function get tracksToDecode():__AS3__.vec.Vector.<core.route.Route>
        {
            return _tracksToDecode;
        }

        public function get freePackages():int
        {
            return _freePackages;
        }

        public function set freePackages(arg1:int):void
        {
            _freePackages = arg1;
            return;
        }

        public static function getSoftwareRevisionNumber(arg1:String):Number
        {
            var loc1:*=arg1.split("-");
            var loc2:*=loc1[3];
            return loc2;
        }

        public function get loadedLogs():__AS3__.vec.Vector.<core.activities.Activity>
        {
            return _loadedLogs;
        }

        public function get unitLogStatus():Boolean
        {
            return _unitLogStatus;
        }

        public function set unitLogStatus(arg1:Boolean):void
        {
            _unitLogStatus = arg1;
            return;
        }

        public function get loadedSportProfiles():__AS3__.vec.Vector.<core.sportprofiles.Sportprofile>
        {
            return _loadedSportProfiles;
        }

        public function set loadedSportProfiles(arg1:__AS3__.vec.Vector.<core.sportprofiles.Sportprofile>):void
        {
            _loadedSportProfiles = arg1;
            return;
        }

        public function firmwareUpdateSupported():Boolean
        {
            return true;
        }

        public function get loadedTracks():init.interfaces.IVectorList
        {
            return _loadedTracks;
        }

        public function set loadedTracks(arg1:init.interfaces.IVectorList):void
        {
            if (_loadedTracks !== arg1) 
            {
                _loadedTracks = arg1;
                dispatchEvent(new flash.events.Event("loadedTracksChange"));
            }
            return;
        }

        public function bleFirmwareUpdateSupported():Boolean
        {
            return false;
        }

        public function get logTime5Sec():int
        {
            return _logTime5Sec;
        }

        public function set logTime5Sec(arg1:int):void
        {
            _logTime5Sec = arg1;
            return;
        }

        public function addSportProfile(arg1:core.sportprofiles.Sportprofile):void
        {
            sportprofilesList.push(arg1);
            dispatchEvent(new flash.events.Event("sportprofilesListChange"));
            return;
        }

        public function get maxPackages():int
        {
            return _maxPackages;
        }

        public function set maxPackages(arg1:int):void
        {
            _maxPackages = arg1;
            return;
        }

        public override function toString():String
        {
            return "[ROX70 extends UnitBikeComputer]";
        }

        public function get memoryMapVersion():String
        {
            return _memoryMapVersion;
        }

        public function set memoryMapVersion(arg1:String):void
        {
            if (_memoryMapVersion !== arg1) 
            {
                _memoryMapVersion = arg1;
                dispatchEvent(new flash.events.Event("memoryMapVersionChange"));
            }
            return;
        }

        public function calculatePowerZonesByThreshold():void
        {
            powerZone1Start = 0;
            powerZone2Start = thresholdPower / 100 * 56;
            powerZone3Start = thresholdPower / 100 * 76;
            powerZone4Start = thresholdPower / 100 * 91;
            powerZone5Start = thresholdPower / 100 * 106;
            powerZone6Start = thresholdPower / 100 * 121;
            powerZone7Start = thresholdPower / 100 * 151;
            powerZone7End = 2000;
            return;
        }

        public function get powerZone1Start():int
        {
            return _powerZone1Start;
        }

        public function set powerZone1Start(arg1:int):void
        {
            if (_powerZone1Start !== arg1) 
            {
                _powerZone1Start = arg1;
                dispatchEvent(new flash.events.Event("powerZone1StartChange"));
            }
            return;
        }

        internal function onTotalsChanged(arg1:flash.events.Event):void
        {
            totalsVectorList = init.BackendInitializer.getInstance().createVectorList(_totalsVector);
            return;
        }

        public function get powerZone2Start():int
        {
            return _powerZone2Start;
        }

        public function set powerZone2Start(arg1:int):void
        {
            if (_powerZone2Start !== arg1) 
            {
                _powerZone2Start = arg1;
                dispatchEvent(new flash.events.Event("powerZone2StartChange"));
            }
            return;
        }

        internal function onSportprofilesChanged(arg1:flash.events.Event):void
        {
            sportprofilesVectorlist = init.BackendInitializer.getInstance().createVectorList(_sportprofilesList);
            return;
        }

        public function get powerZone3Start():int
        {
            return _powerZone3Start;
        }

        public function set powerZone3Start(arg1:int):void
        {
            if (_powerZone3Start !== arg1) 
            {
                _powerZone3Start = arg1;
                dispatchEvent(new flash.events.Event("powerZone3StartChange"));
            }
            return;
        }

        public function get powerZone4Start():int
        {
            return _powerZone4Start;
        }

        public function set powerZone4Start(arg1:int):void
        {
            if (_powerZone4Start !== arg1) 
            {
                _powerZone4Start = arg1;
                dispatchEvent(new flash.events.Event("powerZone4StartChange"));
            }
            return;
        }

        public function get powerZone5Start():int
        {
            return _powerZone5Start;
        }

        public function set powerZone5Start(arg1:int):void
        {
            if (_powerZone5Start !== arg1) 
            {
                _powerZone5Start = arg1;
                dispatchEvent(new flash.events.Event("powerZone5StartChange"));
            }
            return;
        }

        public function get powerZone6Start():int
        {
            return _powerZone6Start;
        }

        public function set powerZone6Start(arg1:int):void
        {
            if (_powerZone6Start !== arg1) 
            {
                _powerZone6Start = arg1;
                dispatchEvent(new flash.events.Event("powerZone6StartChange"));
            }
            return;
        }

        public function get powerZone7End():int
        {
            return _powerZone7End;
        }

        public function set powerZone7End(arg1:int):void
        {
            if (_powerZone7End !== arg1) 
            {
                _powerZone7End = arg1;
                dispatchEvent(new flash.events.Event("powerZone7EndChange"));
            }
            return;
        }

        public function get powerZone7Start():int
        {
            return _powerZone7Start;
        }

        public function set powerZone7Start(arg1:int):void
        {
            if (_powerZone7Start !== arg1) 
            {
                _powerZone7Start = arg1;
                dispatchEvent(new flash.events.Event("powerZone7StartChange"));
            }
            return;
        }

        public function get sportprofilesList():__AS3__.vec.Vector.<core.sportprofiles.Sportprofile>
        {
            return _sportprofilesList;
        }

        public function set sportprofilesList(arg1:__AS3__.vec.Vector.<core.sportprofiles.Sportprofile>):void
        {
            if (arg1 != _sportprofilesList) 
            {
                _sportprofilesList = arg1;
                dispatchEvent(new flash.events.Event("sportprofilesListChange"));
            }
            return;
        }

        public function get sportprofilesVectorlist():init.interfaces.IVectorList
        {
            return _sportprofilesVectorlist;
        }

        public function set sportprofilesVectorlist(arg1:init.interfaces.IVectorList):void
        {
            _sportprofilesVectorlist = arg1;
            return;
        }

        public function set tracksToDecode(arg1:__AS3__.vec.Vector.<core.route.Route>):void
        {
            if (_tracksToDecode !== arg1) 
            {
                _tracksToDecode = arg1;
                dispatchEvent(new flash.events.Event("tracksToDecodeChange"));
            }
            return;
        }

        public function get thresholdPower():int
        {
            return _thresholdPower;
        }

        public function set thresholdPower(arg1:int):void
        {
            if (_thresholdPower !== arg1) 
            {
                _thresholdPower = arg1;
                dispatchEvent(new flash.events.Event("thresholdPowerChange"));
            }
            return;
        }

        internal var _activities:__AS3__.vec.Vector.<core.activities.Activity>;

        internal var _activitiesToDecode:__AS3__.vec.Vector.<core.activities.Activity>;

        internal var _currentSportProfileIndex:uint;

        internal var _currentTotals:core.totals.Totals;

        internal var _freePackages:int=0;

        internal var _loadedLogs:__AS3__.vec.Vector.<core.activities.Activity>;

        internal var _currentStravaSegment:core.strava.StravaSegment;

        internal var _loadedSportProfiles:__AS3__.vec.Vector.<core.sportprofiles.Sportprofile>;

        internal var _loadedTracks:init.interfaces.IVectorList;

        internal var _logTime5Sec:int=0;

        internal var _maxPackages:int=0;

        protected var _memoryMapVersion:String="";

        internal var _powerZone1Start:Number=0;

        internal var _powerZone2Start:int=141;

        internal var _powerZone3Start:int=191;

        internal var _sportprofilesList:__AS3__.vec.Vector.<core.sportprofiles.Sportprofile>;

        internal var _unitLogStatus:Boolean=true;

        internal var _powerZone6Start:int=301;

        internal var _totalsVector:__AS3__.vec.Vector.<core.totals.Totals>;

        internal var _powerZone4Start:int=231;

        internal var _sportprofilesVectorlist:init.interfaces.IVectorList;

        internal var _trackList:init.interfaces.IVectorList;

        internal var _powerZone7Start:int=367;

        internal var _powerZone5Start:int=261;

        internal var _tracksToDecode:__AS3__.vec.Vector.<core.route.Route>;

        internal var _powerZone7End:int=2000;

        internal var _thresholdPower:int=253;
    }
}


//  class UnitROX8
package core.units 
{
    import core.general.*;
    
    public class UnitROX8 extends core.units.UnitROX
    {
        public function UnitROX8()
        {
            super();
            type = core.general.UnitType.ROX80;
            return;
        }

        public override function get deviceGUID():Boolean
        {
            return false;
        }

        public override function toString():String
        {
            return "[UnitROX8 extends UnitROX]";
        }
    }
}


//  class UnitROX81
package core.units 
{
    import core.general.*;
    
    public class UnitROX81 extends core.units.UnitROX2010
    {
        public function UnitROX81()
        {
            super();
            type = core.general.UnitType.ROX81;
            return;
        }

        public override function get bikeCount():int
        {
            return 2;
        }

        public override function get deviceGUID():Boolean
        {
            return false;
        }

        public override function toString():String
        {
            return "[UnitROX81 extends UnitROX2010]";
        }
    }
}


//  class UnitROX9
package core.units 
{
    import __AS3__.vec.*;
    import core.activities.*;
    import core.general.*;
    import core.units.interfaces.*;
    import flash.events.*;
    
    public class UnitROX9 extends core.units.UnitROX implements core.units.interfaces.ILogList, core.units.interfaces.ILogStatus, core.units.interfaces.ILogTime5Sec, core.units.interfaces.ILogTime10Sec, core.units.interfaces.ILogTime20Sec, core.units.interfaces.ILogTime30Sec, core.units.interfaces.IIntensityZonesPercentage
    {
        public function UnitROX9()
        {
            _activities = new __AS3__.vec.Vector.<core.activities.Activity>();
            _loadedLogs = new __AS3__.vec.Vector.<core.activities.Activity>();
            super();
            type = core.general.UnitType.ROX90;
            return;
        }

        public function get logTime5Sec():int
        {
            return _logTime5Sec;
        }

        public function get activities():__AS3__.vec.Vector.<core.activities.Activity>
        {
            return _activities;
        }

        public function set activities(arg1:__AS3__.vec.Vector.<core.activities.Activity>):void
        {
            if (_activities !== arg1) 
            {
                _activities = arg1;
                dispatchEvent(new flash.events.Event("activitiesChange"));
            }
            return;
        }

        public override function get deviceGUID():Boolean
        {
            return false;
        }

        public function set intensityZone1PercentageStart(arg1:Number):void
        {
            _intensityZone1PercentageStart = arg1;
            return;
        }

        public function get freePackages():int
        {
            return _freePackages;
        }

        public function set freePackages(arg1:int):void
        {
            _freePackages = arg1;
            return;
        }

        public function set logTime5Sec(arg1:int):void
        {
            _logTime5Sec = arg1;
            return;
        }

        public function get intensityZone1PercentageStart():Number
        {
            return _intensityZone1PercentageStart;
        }

        public function get maxPackages():int
        {
            return _maxPackages;
        }

        public function set maxPackages(arg1:int):void
        {
            _maxPackages = arg1;
            return;
        }

        public function get intensityZone2PercentageStart():Number
        {
            return _intensityZone2PercentageStart;
        }

        public function set intensityZone2PercentageStart(arg1:Number):void
        {
            _intensityZone2PercentageStart = arg1;
            return;
        }

        public function get unitLogStatus():Boolean
        {
            return _unitLogStatus;
        }

        public function get intensityZone3PercentageStart():Number
        {
            return _intensityZone3PercentageStart;
        }

        public function set intensityZone3PercentageStart(arg1:Number):void
        {
            _intensityZone3PercentageStart = arg1;
            return;
        }

        public function set unitLogStatus(arg1:Boolean):void
        {
            _unitLogStatus = arg1;
            return;
        }

        public function get intensityZone4PercentageEnd():Number
        {
            return _intensityZone4PercentageEnd;
        }

        public function set intensityZone4PercentageEnd(arg1:Number):void
        {
            _intensityZone4PercentageEnd = arg1;
            return;
        }

        public override function toString():String
        {
            return "[UnitROX9 extends UnitROX implements ILogList, ILogStatus]";
        }

        public function get intensityZone4PercentageStart():Number
        {
            return _intensityZone4PercentageStart;
        }

        public function set intensityZone4PercentageStart(arg1:Number):void
        {
            _intensityZone4PercentageStart = arg1;
            return;
        }

        public function get intensityZonePercentageMin():Number
        {
            return 30;
        }

        public function get loadedLogs():__AS3__.vec.Vector.<core.activities.Activity>
        {
            return _loadedLogs;
        }

        public function set loadedLogs(arg1:__AS3__.vec.Vector.<core.activities.Activity>):void
        {
            if (arg1 != _loadedLogs) 
            {
                _loadedLogs = arg1;
                dispatchEvent(new flash.events.Event("loadedLogsChange"));
            }
            return;
        }

        public function get logTime10Sec():int
        {
            return _logTime10Sec;
        }

        public function set logTime10Sec(arg1:int):void
        {
            _logTime10Sec = arg1;
            return;
        }

        public function get logTime20Sec():int
        {
            return _logTime20Sec;
        }

        public function set logTime20Sec(arg1:int):void
        {
            _logTime20Sec = arg1;
            return;
        }

        public function get logTime30Sec():int
        {
            return _logTime30Sec;
        }

        public function set logTime30Sec(arg1:int):void
        {
            _logTime30Sec = arg1;
            return;
        }

        internal var _activities:__AS3__.vec.Vector.<core.activities.Activity>;

        internal var _intensityZone1PercentageStart:Number=40;

        internal var _freePackages:int=0;

        internal var _intensityZone2PercentageStart:Number=55;

        internal var _intensityZone3PercentageStart:Number=70;

        internal var _intensityZone4PercentageEnd:Number=100;

        internal var _intensityZone4PercentageStart:Number=85;

        internal var _maxPackages:int=0;

        internal var _logTime20Sec:int=0;

        internal var _loadedLogs:__AS3__.vec.Vector.<core.activities.Activity>;

        internal var _unitLogStatus:Boolean=true;

        internal var _logTime5Sec:int=0;

        internal var _logTime10Sec:int=0;

        internal var _logTime30Sec:int=0;
    }
}


//  class UnitROX91
package core.units 
{
    import __AS3__.vec.*;
    import core.activities.*;
    import core.general.*;
    import core.units.interfaces.*;
    import flash.events.*;
    import mx.events.*;
    
    public class UnitROX91 extends core.units.UnitROX2010 implements core.units.interfaces.ILogList, core.units.interfaces.ILogStatus, core.units.interfaces.ILogTime5Sec, core.units.interfaces.ILogTime10Sec, core.units.interfaces.ILogTime20Sec, core.units.interfaces.ILogTime30Sec, core.units.interfaces.IIntensityZonesPercentage, core.units.interfaces.IGhostRaceSupported
    {
        public function UnitROX91()
        {
            _activities = new __AS3__.vec.Vector.<core.activities.Activity>();
            _loadedLogs = new __AS3__.vec.Vector.<core.activities.Activity>();
            _unitLogStatus = true;
            super();
            type = core.general.UnitType.ROX91;
            return;
        }

        public function get intensityZone4PercentageEnd():Number
        {
            return _intensityZone4PercentageEnd;
        }

        public function get activities():__AS3__.vec.Vector.<core.activities.Activity>
        {
            return _activities;
        }

        public function set activities(arg1:__AS3__.vec.Vector.<core.activities.Activity>):void
        {
            if (_activities !== arg1) 
            {
                _activities = arg1;
                dispatchEvent(new flash.events.Event("activitiesChange"));
            }
            return;
        }

        public override function get bikeCount():int
        {
            return 2;
        }

        public override function get deviceGUID():Boolean
        {
            return false;
        }

        internal function get _unitLogStatus():Boolean
        {
            return this._unitLogStatus;
        }

        public function get freePackages():int
        {
            return _freePackages;
        }

        public function set freePackages(arg1:int):void
        {
            _freePackages = arg1;
            return;
        }

        public function set intensityZone4PercentageEnd(arg1:Number):void
        {
            _intensityZone4PercentageEnd = arg1;
            return;
        }

        public function get intensityZone1PercentageStart():Number
        {
            return _intensityZone1PercentageStart;
        }

        public function set intensityZone1PercentageStart(arg1:Number):void
        {
            _intensityZone1PercentageStart = arg1;
            return;
        }

        public function get intensityZonePercentageMin():Number
        {
            return 30;
        }

        public function get intensityZone2PercentageStart():Number
        {
            return _intensityZone2PercentageStart;
        }

        public function set intensityZone2PercentageStart(arg1:Number):void
        {
            _intensityZone2PercentageStart = arg1;
            return;
        }

        public function get intensityZone4PercentageStart():Number
        {
            return _intensityZone4PercentageStart;
        }

        public function get intensityZone3PercentageStart():Number
        {
            return _intensityZone3PercentageStart;
        }

        public function set intensityZone3PercentageStart(arg1:Number):void
        {
            _intensityZone3PercentageStart = arg1;
            return;
        }

        public function set intensityZone4PercentageStart(arg1:Number):void
        {
            _intensityZone4PercentageStart = arg1;
            return;
        }

        public function get loadedLogs():__AS3__.vec.Vector.<core.activities.Activity>
        {
            return _loadedLogs;
        }

        public function set loadedLogs(arg1:__AS3__.vec.Vector.<core.activities.Activity>):void
        {
            if (arg1 != _loadedLogs) 
            {
                _loadedLogs = arg1;
                dispatchEvent(new flash.events.Event("loadedLogsChange"));
            }
            return;
        }

        public function get logTime10Sec():int
        {
            return _logTime10Sec;
        }

        public function set logTime10Sec(arg1:int):void
        {
            _logTime10Sec = arg1;
            return;
        }

        public function get logTime20Sec():int
        {
            return _logTime20Sec;
        }

        public function set logTime20Sec(arg1:int):void
        {
            _logTime20Sec = arg1;
            return;
        }

        public function get logTime30Sec():int
        {
            return _logTime30Sec;
        }

        public function set logTime30Sec(arg1:int):void
        {
            _logTime30Sec = arg1;
            return;
        }

        public function get logTime5Sec():int
        {
            return _logTime5Sec;
        }

        public function set logTime5Sec(arg1:int):void
        {
            _logTime5Sec = arg1;
            return;
        }

        public function get maxPackages():int
        {
            return _maxPackages;
        }

        public function set maxPackages(arg1:int):void
        {
            _maxPackages = arg1;
            return;
        }

        internal function set _unitLogStatus(arg1:Boolean):void
        {
            var loc1:*=this._unitLogStatus;
            if (loc1 !== arg1) 
            {
                this._unitLogStatus = arg1;
                if (this.hasEventListener("propertyChange")) 
                {
                    this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "_unitLogStatus", loc1, arg1));
                }
            }
            return;
        }

        public function get unitLogStatus():Boolean
        {
            return _unitLogStatus;
        }

        public function set unitLogStatus(arg1:Boolean):void
        {
            _unitLogStatus = arg1;
            return;
        }

        public override function toString():String
        {
            return "[UnitROX91 extends UnitROX2010 implements ILogList, ICodingLog]";
        }

        public function get ghostRaceSupported():Boolean
        {
            return true;
        }

        public function get ghostRaceGPSDataRequired():Boolean
        {
            return false;
        }

        internal var _logTime5Sec:int=0;

        internal var _intensityZone1PercentageStart:Number=40;

        internal var _logTime10Sec:int=0;

        internal var _maxPackages:int=0;

        internal var _intensityZone2PercentageStart:Number=55;

        internal var _intensityZone3PercentageStart:Number=70;

        internal var _unitLogStatus:Boolean;

        internal var _loadedLogs:__AS3__.vec.Vector.<core.activities.Activity>;

        internal var _logTime20Sec:int=0;

        internal var _intensityZone4PercentageEnd:Number=100;

        internal var _intensityZone4PercentageStart:Number=85;

        internal var _logTime30Sec:int=0;

        internal var _freePackages:int=0;

        internal var _activities:__AS3__.vec.Vector.<core.activities.Activity>;
    }
}


//  class UnitRunningComputer
package core.units 
{
    import __AS3__.vec.*;
    import core.totals.*;
    import core.units.interfaces.*;
    import flash.events.*;
    import init.*;
    
    public class UnitRunningComputer extends core.units.Unit implements core.units.interfaces.ITotalsList
    {
        public function UnitRunningComputer(arg1:flash.events.IEventDispatcher=null)
        {
            _totalsVector = new __AS3__.vec.Vector.<core.totals.Totals>();
            super(arg1);
            addEventListener("totalsChanged", onTotalsChanged, false, 0, true);
            addEventListener("totalRemoved", onTotalsChanged, false, 0, true);
            return;
        }

        public function get currentTotals():core.totals.Totals
        {
            return _currentTotals;
        }

        public function set currentTotals(arg1:core.totals.Totals):void
        {
            if (arg1 != _currentTotals) 
            {
                _currentTotals = arg1;
                dispatchEvent(new flash.events.Event("currentTotalsChange"));
            }
            return;
        }

        public function get totalsVector():__AS3__.vec.Vector.<core.totals.Totals>
        {
            return _totalsVector;
        }

        public function set totalsVector(arg1:__AS3__.vec.Vector.<core.totals.Totals>):void
        {
            if (_totalsVector !== arg1) 
            {
                _totalsVector = arg1;
                dispatchEvent(new flash.events.Event("totalsVectorChange"));
            }
            return;
        }

        internal function onTotalsChanged(arg1:flash.events.Event):void
        {
            totalsVectorList = init.BackendInitializer.getInstance().createVectorList(_totalsVector);
            return;
        }

        internal var _currentTotals:core.totals.Totals;

        internal var _totalsVector:__AS3__.vec.Vector.<core.totals.Totals>;
    }
}


//  class UnitTopline2009
package core.units 
{
    import __AS3__.vec.*;
    import core.totals.*;
    import core.units.interfaces.*;
    import flash.events.*;
    import init.*;
    
    public class UnitTopline2009 extends core.units.UnitBikeComputer implements core.units.interfaces.ITotalsList, core.units.interfaces.IDSTDeviceInfo
    {
        public function UnitTopline2009()
        {
            _totalsVector = new __AS3__.vec.Vector.<core.totals.Totals>();
            super();
            addEventListener("totalsChanged", onTotalsChanged, false, 0, true);
            addEventListener("totalRemoved", onTotalsChanged, false, 0, true);
            return;
        }

        public function get currentTotals():core.totals.Totals
        {
            return _currentTotals;
        }

        public function set currentTotals(arg1:core.totals.Totals):void
        {
            if (arg1 != _currentTotals) 
            {
                _currentTotals = arg1;
                dispatchEvent(new flash.events.Event("currentTotalsChange"));
            }
            return;
        }

        public override function get deviceGUID():Boolean
        {
            return false;
        }

        public function get totalsVector():__AS3__.vec.Vector.<core.totals.Totals>
        {
            return _totalsVector;
        }

        public function set totalsVector(arg1:__AS3__.vec.Vector.<core.totals.Totals>):void
        {
            if (_totalsVector !== arg1) 
            {
                _totalsVector = arg1;
                dispatchEvent(new flash.events.Event("totalsVectorChange"));
            }
            return;
        }

        public override function toString():String
        {
            return "[UnitTopline2009 extends Unit implements IMemoryList]";
        }

        internal function onTotalsChanged(arg1:flash.events.Event):void
        {
            totalsVectorList = init.BackendInitializer.getInstance().createVectorList(_totalsVector);
            return;
        }

        internal var _currentTotals:core.totals.Totals;

        internal var _totalsVector:__AS3__.vec.Vector.<core.totals.Totals>;
    }
}


//  class UnitTopline2012
package core.units 
{
    import __AS3__.vec.*;
    import core.totals.*;
    import core.units.interfaces.*;
    import flash.events.*;
    import init.*;
    
    public class UnitTopline2012 extends core.units.UnitBikeComputer implements core.units.interfaces.ITotalsList, core.units.interfaces.IDSTDeviceInfo
    {
        public function UnitTopline2012()
        {
            _totalsVector = new __AS3__.vec.Vector.<core.totals.Totals>();
            super();
            addEventListener("totalsChanged", onTotalsChanged, false, 0, true);
            addEventListener("totalRemoved", onTotalsChanged, false, 0, true);
            return;
        }

        public function get currentTotals():core.totals.Totals
        {
            return _currentTotals;
        }

        public function set currentTotals(arg1:core.totals.Totals):void
        {
            if (arg1 != _currentTotals) 
            {
                _currentTotals = arg1;
                dispatchEvent(new flash.events.Event("currentTotalsChange"));
            }
            return;
        }

        public override function get deviceGUID():Boolean
        {
            return false;
        }

        public function get totalsVector():__AS3__.vec.Vector.<core.totals.Totals>
        {
            return _totalsVector;
        }

        public function set totalsVector(arg1:__AS3__.vec.Vector.<core.totals.Totals>):void
        {
            if (_totalsVector !== arg1) 
            {
                _totalsVector = arg1;
                dispatchEvent(new flash.events.Event("totalsVectorChange"));
            }
            return;
        }

        internal function onTotalsChanged(arg1:flash.events.Event):void
        {
            totalsVectorList = init.BackendInitializer.getInstance().createVectorList(_totalsVector);
            return;
        }

        internal var _currentTotals:core.totals.Totals;

        internal var _totalsVector:__AS3__.vec.Vector.<core.totals.Totals>;
    }
}


//  class UnitTopline2016
package core.units 
{
    import __AS3__.vec.*;
    import core.totals.*;
    import core.units.interfaces.*;
    import flash.events.*;
    import init.*;
    
    public class UnitTopline2016 extends core.units.UnitBikeComputer implements core.units.interfaces.ITotalsList, core.units.interfaces.IDSTDeviceInfo, core.units.interfaces.IDSFirmwareUpdateSupported
    {
        public function UnitTopline2016()
        {
            _totalsVector = new __AS3__.vec.Vector.<core.totals.Totals>();
            super();
            addEventListener("totalsChanged", onTotalsChanged, false, 0, true);
            addEventListener("totalRemoved", onTotalsChanged, false, 0, true);
            return;
        }

        public function get currentTotals():core.totals.Totals
        {
            return _currentTotals;
        }

        public function set currentTotals(arg1:core.totals.Totals):void
        {
            if (arg1 != _currentTotals) 
            {
                _currentTotals = arg1;
                dispatchEvent(new flash.events.Event("currentTotalsChange"));
            }
            return;
        }

        public function get totalsVector():__AS3__.vec.Vector.<core.totals.Totals>
        {
            return _totalsVector;
        }

        public function set totalsVector(arg1:__AS3__.vec.Vector.<core.totals.Totals>):void
        {
            if (_totalsVector !== arg1) 
            {
                _totalsVector = arg1;
                dispatchEvent(new flash.events.Event("totalsVectorChange"));
            }
            return;
        }

        public override function toString():String
        {
            return "UnitTopline2016";
        }

        internal function onTotalsChanged(arg1:flash.events.Event):void
        {
            totalsVectorList = init.BackendInitializer.getInstance().createVectorList(_totalsVector);
            return;
        }

        public function dockingStationType():String
        {
            return "DS16";
        }

        internal var _currentTotals:core.totals.Totals;

        internal var _totalsVector:__AS3__.vec.Vector.<core.totals.Totals>;
    }
}


