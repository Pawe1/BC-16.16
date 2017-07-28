//class Unit
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


