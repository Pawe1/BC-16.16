//class Settings
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


