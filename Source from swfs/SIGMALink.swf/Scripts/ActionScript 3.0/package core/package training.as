//package training
//  package type
//    class PhaseCategory
package core.training.type 
{
    import core.general.*;
    import debug.*;
    
    public class PhaseCategory extends core.general.BaseType
    {
        public function PhaseCategory(arg1:String=null)
        {
            super(arg1);
            return;
        }

        public static function fromString(arg1:String):core.training.type.PhaseCategory
        {
            var loc1:*=0;
            loc1 = 0;
            while (loc1 < TYPES.length) 
            {
                if (TYPES[loc1].toString() == arg1) 
                {
                    return TYPES[loc1];
                }
                ++loc1;
            }
            debug.Debug.warning("Warning: Unknown TrainingPhaseType: \'" + arg1 + "\' !");
            return null;
        }

        public static const INTERVAL:core.training.type.PhaseCategory=new PhaseCategory("interval");

        public static const SIMPLE:core.training.type.PhaseCategory=new PhaseCategory("simple");

        public static const TYPES:Array=[SIMPLE, INTERVAL];
    }
}


//    class PhaseChangeMode
package core.training.type 
{
    import core.general.*;
    
    public class PhaseChangeMode extends core.general.BaseType
    {
        public function PhaseChangeMode(arg1:String=null)
        {
            super(arg1);
            return;
        }

        public static function fromString(arg1:String):core.training.type.PhaseChangeMode
        {
            var loc1:*=0;
            loc1 = 0;
            while (loc1 < TYPES.length) 
            {
                if (TYPES[loc1].toString() == arg1) 
                {
                    return TYPES[loc1];
                }
                ++loc1;
            }
            return null;
        }

        public static const AUTOMATIC:core.training.type.PhaseChangeMode=new PhaseChangeMode("automatic");

        public static const MANUAL:core.training.type.PhaseChangeMode=new PhaseChangeMode("manual");

        public static const TYPES:Array=[AUTOMATIC, MANUAL];
    }
}


//    class PhaseControl
package core.training.type 
{
    import core.general.*;
    
    public class PhaseControl extends core.general.BaseType
    {
        public function PhaseControl(arg1:String=null)
        {
            super(arg1);
            return;
        }

        public static function fromString(arg1:String):core.training.type.PhaseControl
        {
            var loc1:*=0;
            loc1 = 0;
            while (loc1 < TYPES.length) 
            {
                if (TYPES[loc1].toString() == arg1) 
                {
                    return TYPES[loc1];
                }
                ++loc1;
            }
            return null;
        }

        public static const DISTANCE:core.training.type.PhaseControl=new PhaseControl("distance");

        public static const NO:core.training.type.PhaseControl=new PhaseControl("no");

        public static const PULSE:core.training.type.PhaseControl=new PhaseControl("pulse");

        public static const TIME:core.training.type.PhaseControl=new PhaseControl("time");

        public static const TYPES:Array=[NO, TIME, PULSE, DISTANCE];
    }
}


//    class PhaseLoadRecovery
package core.training.type 
{
    import core.general.*;
    
    public class PhaseLoadRecovery extends core.general.BaseType
    {
        public function PhaseLoadRecovery(arg1:String=null)
        {
            super(arg1);
            return;
        }

        public static function fromString(arg1:String):core.training.type.PhaseLoadRecovery
        {
            var loc1:*=0;
            loc1 = 0;
            while (loc1 < TYPES.length) 
            {
                if (TYPES[loc1].toString() == arg1) 
                {
                    return TYPES[loc1];
                }
                ++loc1;
            }
            return null;
        }

        public static const LOAD:core.training.type.PhaseLoadRecovery=new PhaseLoadRecovery("load");

        public static const RECOVERY:core.training.type.PhaseLoadRecovery=new PhaseLoadRecovery("recovery");

        public static const TYPES:Array=[LOAD, RECOVERY];
    }
}


//    class PhaseTarget
package core.training.type 
{
    import core.general.*;
    
    public class PhaseTarget extends core.general.BaseType
    {
        public function PhaseTarget(arg1:String=null)
        {
            super(arg1);
            return;
        }

        public static function fromString(arg1:String):core.training.type.PhaseTarget
        {
            var loc1:*=0;
            loc1 = 0;
            while (loc1 < TYPES.length) 
            {
                if (TYPES[loc1].toString() == arg1) 
                {
                    return TYPES[loc1];
                }
                ++loc1;
            }
            return null;
        }

        public static const CADENCE:core.training.type.PhaseTarget=new PhaseTarget("cadence");

        public static const HEARTFREQUENCY:core.training.type.PhaseTarget=new PhaseTarget("heartfrequency");

        public static const OFF:core.training.type.PhaseTarget=new PhaseTarget("off");

        public static const PERCENT_MAX_HEARTFREQUENCY:core.training.type.PhaseTarget=new PhaseTarget("percent_of_max_heartfrequency");

        public static const POWER:core.training.type.PhaseTarget=new PhaseTarget("power");

        public static const TYPES:Array=[OFF, PERCENT_MAX_HEARTFREQUENCY, HEARTFREQUENCY, CADENCE, POWER];
    }
}


//  class Training
package core.training 
{
    import __AS3__.vec.*;
    import core.*;
    import core.general.interfaces.*;
    import core.training.type.*;
    import core.units.*;
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;
    import init.*;
    import utils.*;
    import utils.interfaces.*;
    
    public class Training extends flash.events.EventDispatcher implements core.general.interfaces.ISynchronisable
    {
        public function Training(arg1:core.units.Unit=null, arg2:Boolean=true)
        {
            var loc1:*=null;
            _date = new Date();
            _phasesList = new __AS3__.vec.Vector.<core.training.TrainingPhase>();
            super();
            if (initFormatter) 
            {
                dateFormatter = init.BackendInitializer.getInstance().createDateTimeFormatter();
                dateFormatter.dateStyle = "short";
                dateFormatter.timeStyle = "none";
                dateFormatter.setStyle("locale", core.MeasurementConfig.dateFormat != "eu" ? "en_US" : "de_DE");
                timeFormatterHHMMSS = init.BackendInitializer.getInstance().createTimeFormatter();
                initFormatter = false;
            }
            unit = arg1;
            if (unit) 
            {
                unitGUID = unit.GUID;
            }
            if (arg2) 
            {
                loc1 = new core.training.TrainingPhase();
                loc1.training = this;
                phasesList.push(loc1);
            }
            if (_date) 
            {
                dateOutputString = dateFormatter.format(_date);
            }
            return;
        }

        public function set programDataLength(arg1:int):void
        {
            _programDataLength = arg1;
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

        public function get trainingId():int
        {
            return _trainingId;
        }

        public function get date():Date
        {
            return _date;
        }

        public function set date(arg1:Date):void
        {
            if (arg1 != _date) 
            {
                _date = arg1;
                dateOutputString = dateFormatter.format(arg1);
                dispatchEvent(new flash.events.Event("dateChange"));
            }
            return;
        }

        public function set trainingId(arg1:int):void
        {
            _trainingId = arg1;
            return;
        }

        public function get unit():core.units.Unit
        {
            return _unit;
        }

        public function get description():String
        {
            return _description;
        }

        public function set description(arg1:String):void
        {
            if (arg1 != _description) 
            {
                _description = arg1;
                dispatchEvent(new flash.events.Event("descriptionChange"));
            }
            return;
        }

        public function set unit(arg1:core.units.Unit):void
        {
            _unit = arg1;
            return;
        }

        public function get estimatedDistance():Number
        {
            return _estimatedDistance;
        }

        public function set estimatedDistance(arg1:Number):void
        {
            if (_estimatedDistance !== arg1) 
            {
                _estimatedDistance = arg1;
                dispatchEvent(new flash.events.Event("estimatedDistanceChange"));
            }
            return;
        }

        public function get unitGUID():String
        {
            return _unitGUID;
        }

        public function get estimatedDuration():Number
        {
            return _estimatedDuration;
        }

        public function set estimatedDuration(arg1:Number):void
        {
            if (_estimatedDuration !== arg1) 
            {
                _estimatedDuration = arg1;
                dispatchEvent(new flash.events.Event("estimatedDurationChange"));
            }
            return;
        }

        public function get estimatedDurationFormatted():String
        {
            return timeFormatterHHMMSS.format(_estimatedDuration);
        }

        public function set unitGUID(arg1:String):void
        {
            _unitGUID = arg1;
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

        public function set name(arg1:String):void
        {
            if (arg1 != _name) 
            {
                _name = arg1;
                dispatchEvent(new flash.events.Event("nameChange"));
            }
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

        public function recalcEstimatedValue():void
        {
            var loc2:*=null;
            var loc6:*=0;
            var loc5:*=0;
            var loc3:*=_phasesList.length;
            var loc1:*=0;
            var loc4:*=0;
            _estimatedDuration = 0;
            loc5 = 0;
            while (loc5 < loc3) 
            {
                loc2 = _phasesList[loc5];
                loc2.position = loc5;
                loc6 = core.training.type.PhaseCategory.SIMPLE.equals(loc2.type) ? 1 : loc2.iterations;
                if (core.training.type.PhaseControl.TIME.equals(loc2.loadPhaseControl)) 
                {
                    loc1 = loc1 + loc6 * loc2.loadDuration;
                }
                else if (core.training.type.PhaseControl.DISTANCE.equals(loc2.loadPhaseControl)) 
                {
                    loc4 = loc4 + loc6 * loc2.loadDistance;
                }
                if (core.training.type.PhaseCategory.INTERVAL.equals(loc2.type)) 
                {
                    if (core.training.type.PhaseControl.TIME.equals(loc2.recoveryPhaseControl)) 
                    {
                        loc1 = loc1 + loc6 * loc2.recoveryDuration;
                    }
                    else if (core.training.type.PhaseControl.DISTANCE.equals(loc2.recoveryPhaseControl)) 
                    {
                        loc4 = loc4 + loc6 * loc2.recoveryDistance;
                    }
                }
                ++loc5;
            }
            estimatedDuration = loc1;
            estimatedDistance = loc4 * 1000;
            return;
        }

        public static function copy(arg1:core.training.Training):core.training.Training
        {
            var loc4:*=null;
            var loc6:*=0;
            var loc7:*=null;
            var loc5:*=flash.utils.getQualifiedClassName(arg1);
            var loc1:*=arg1.unit;
            arg1.unit = null;
            flash.net.registerClassAlias(loc5, flash.utils.getDefinitionByName(loc5) as Class);
            var loc2:*=utils.BackendUtil.copy(arg1) as Training;
            loc2.unit = loc1;
            loc2.trainingId = 0;
            loc2.GUID = utils.GUID.create();
            loc2.selected = false;
            loc2.phasesList = new __AS3__.vec.Vector.<core.training.TrainingPhase>();
            var loc3:*=arg1.phasesList.length;
            loc6 = 0;
            while (loc6 < loc3) 
            {
                if (loc6 == 0) 
                {
                    loc7 = flash.utils.getQualifiedClassName(arg1.phasesList[loc6]);
                    flash.net.registerClassAlias(loc7, flash.utils.getDefinitionByName(loc7) as Class);
                }
                (loc4 = core.training.TrainingPhase.copy(arg1.phasesList[loc6])).training = loc2;
                loc4.trainingPhaseId = 0;
                loc2.phasesList.push(loc4);
                ++loc6;
            }
            arg1.unit = loc1;
            return loc2;
        }

        public function get name():String
        {
            return _name;
        }

        public function set phasesList(arg1:__AS3__.vec.Vector.<core.training.TrainingPhase>):void
        {
            if (_phasesList !== arg1) 
            {
                _phasesList = arg1;
            }
            return;
        }

        public function get phaseCount():int
        {
            return _phaseCount;
        }

        public function set phaseCount(arg1:int):void
        {
            _phaseCount = arg1;
            return;
        }

        public function get phasesList():__AS3__.vec.Vector.<core.training.TrainingPhase>
        {
            return _phasesList;
        }

        public function get programDataLength():int
        {
            return _programDataLength;
        }

        internal var _GUID:String="";

        internal var _date:Date;

        public var dateOutputString:String="--";

        internal var _description:String="";

        internal var _estimatedDistance:Number=0;

        internal var _estimatedDuration:Number=0;

        internal var _isDeleted:Boolean=false;

        public var modifiedSinceLastUpload:Boolean=false;

        internal var _name:String="";

        internal var _programDataLength:int=0;

        internal var _unit:core.units.Unit;

        internal var _phasesList:__AS3__.vec.Vector.<core.training.TrainingPhase>;

        internal var _phaseCount:int=0;

        internal var _unitGUID:String="";

        public var programIdOnDevice:uint=0;

        public var selected:Boolean;

        public var uploadedToDevice:Boolean=false;

        internal var _trainingId:int;

        public static var initFormatter:Boolean=true;

        protected static var dateFormatter:utils.interfaces.ICustomDateTimeFormatter;

        protected static var timeFormatterHHMMSS:utils.interfaces.ICustomTimeFormatter;

        internal var _modificationDate:Number=0;
    }
}


//  class TrainingEvent
package core.training 
{
    import flash.events.*;
    
    public class TrainingEvent extends flash.events.Event
    {
        public function TrainingEvent(arg1:String, arg2:core.training.Training=null, arg3:Boolean=false, arg4:Boolean=false)
        {
            super(arg1, arg3, arg4);
            training = arg2;
            return;
        }

        public static const SELECT_PHASE:String="selectPhaseEvent";

        public static const TRAININGS_CHANGED:String="trainingsChanged";

        public var phase:core.training.TrainingPhase;

        public var training:core.training.Training;
    }
}


//  class TrainingMapper
package core.training 
{
    import __AS3__.vec.*;
    import core.units.*;
    import database.*;
    import handler.*;
    import utils.*;
    import utils.format.*;
    
    public class TrainingMapper extends Object
    {
        public function TrainingMapper()
        {
            super();
            return;
        }

        public static function generateXML(arg1:core.training.Training):XML
        {
            var loc1:*=new XML("<TrainingProgram/>");
            loc1.date = arg1.date.toString();
            loc1.GUID = arg1.GUID;
            loc1.modificationDate = arg1.modificationDate;
            loc1.unitGUID = arg1.unitGUID;
            loc1.name = utils.format.CDATAFormat.getCDataAsXMLNode("name", arg1.name);
            loc1.description = utils.format.CDATAFormat.getCDataAsXMLNode("description", arg1.description);
            var loc2:*=core.training.TrainingPhaseMapper.generateXML(arg1.phasesList);
            loc1.appendChild(loc2);
            return loc1;
        }

        public static function fromXML(arg1:XML):core.training.Training
        {
            var loc2:*=null;
            var loc1:*=handler.AppDeviceHandlerCommon.deviceDicGUID[arg1.unitGUID.text().toString()];
            loc2 = new core.training.Training(loc1, false);
            loc2.date = new Date(arg1.date.text().toString());
            loc2.GUID = arg1.GUID;
            loc2.modificationDate = arg1.modificationDate;
            loc2.unitGUID = arg1.unitGUID;
            loc2.unit = loc1;
            loc2.name = arg1.name;
            loc2.description = arg1.description;
            loc2.phasesList = new __AS3__.vec.Vector.<core.training.TrainingPhase>();
            core.training.TrainingPhaseMapper.fromXML(arg1, loc2.phasesList, loc2);
            return loc2;
        }

        public static function fromDB(arg1:core.training.Training, arg2:Object):void
        {
            arg1.trainingId = arg2["trainingId"];
            arg1.date = new Date(arg2["date"]);
            arg1.GUID = arg2["GUID"];
            arg1.modificationDate = arg2["modificationDate"];
            arg1.isDeleted = arg2["isDeleted"];
            arg1.unitGUID = arg2["unitGUID"];
            arg1.name = arg2["name"];
            arg1.description = arg2["description"];
            return;
        }

        public static function generateDBCreateTable(arg1:uint):database.DatabaseTable
        {
            var loc1:*=null;
            var loc2:*=arg1;
            while (400 === loc2) 
            {
                DB_TABLE_400 = new database.DatabaseTable("Training");
                DB_TABLE_400.addColumns([["trainingId", "INTEGER", false, true, true], ["date", "VARCHAR", true], ["GUID", "VARCHAR UNIQUE", false], ["modificationDate", "NUMERIC", true], ["isDeleted", "BOOL", true], ["unitGUID", "VARCHAR", false], ["name", "VARCHAR", true], ["description", "VARCHAR", true], ["emptyField1", "VARCHAR", true]]);
                loc1 = DB_TABLE_400;
            }
        }

        public static function generateDBCreateIndex():String
        {
            var loc1:*="CREATE INDEX IF NOT EXISTS UnitGUIDOnTraining ON Training (unitGUID)";
            return loc1;
        }

        public static function generateDBCreateTrigger(arg1:uint):String
        {
            var loc1:*=null;
            var loc2:*=arg1;
            while (400 === loc2) 
            {
                loc1 = "CREATE TRIGGER IF NOT EXISTS TrainingTrigger AFTER DELETE ON Training FOR EACH ROW BEGIN DELETE FROM TrainingPhase WHERE TrainingPhase.trainingId = OLD.trainingId;END";
            }
        }

        public static function generateDBDelete(arg1:core.training.Training):String
        {
            return "DELETE FROM Training WHERE GUID = \'" + arg1.GUID + "\'";
        }

        public static function prepareDelete(arg1:String):String
        {
            var loc1:*=new Date().time;
            var loc2:*="UPDATE Training SET isDeleted = true, modificationDate = \'" + loc1 + "\' WHERE GUID = \'" + arg1 + "\'";
            return loc2;
        }

        public static function selectPrimaryKeyFromGUID(arg1:core.training.Training):String
        {
            return "SELECT trainingId FROM Training WHERE GUID = \'" + arg1.GUID + "\'";
        }

        public static function getInsertStatement(arg1:Array):String
        {
            return "INSERT OR REPLACE INTO Training (" + arg1.toString() + ") VALUES (:" + arg1.join(", :") + ");";
        }

        public static function selectTrainings(arg1:String, arg2:String="modificationDate", arg3:Boolean=false):String
        {
            var loc1:*;
            return loc1 = "SELECT * FROM Training where unitGUID = \'" + arg1 + "\' and isDeleted = false ORDER BY " + arg2 + (arg3 ? " ASC" : " DESC");
        }

        public static function generateDBInsert(arg1:core.training.Training, arg2:Array, arg3:Object):void
        {
            if (arg1.GUID == "" || arg1.GUID == "0") 
            {
                arg1.GUID = utils.GUID.create();
            }
            if (arg1.modificationDate == 0) 
            {
                arg1.modificationDate = new Date().time;
            }
            arg2.push("trainingId");
            arg3[":trainingId"] = arg1.trainingId > 0 ? arg1.trainingId : null;
            arg2.push("date");
            arg3[":date"] = arg1.date.toString();
            arg2.push("GUID");
            arg3[":GUID"] = arg1.GUID;
            arg2.push("modificationDate");
            arg3[":modificationDate"] = arg1.modificationDate;
            arg2.push("isDeleted");
            arg3[":isDeleted"] = arg1.isDeleted;
            arg2.push("unitGUID");
            arg3[":unitGUID"] = arg1.unitGUID;
            arg2.push("name");
            arg3[":name"] = arg1.name;
            arg2.push("description");
            arg3[":description"] = arg1.description;
            return;
        }

        public static const col_GUID:String="GUID";

        public static const col_date:String="date";

        public static const col_description:String="description";

        public static const col_isDeleted:String="isDeleted";

        public static const col_modificationDate:String="modificationDate";

        public static const col_name:String="name";

        public static const col_trainingId:String="trainingId";

        public static const col_unitGUID:String="unitGUID";

        public static const table_name:String="Training";

        public static var DB_TABLE_400:database.DatabaseTable;

        public static var DB_TABLE_500:database.DatabaseTable;

        public static var DB_TABLE_510:database.DatabaseTable;

        public static var DB_TABLE_520:database.DatabaseTable;
    }
}


//  class TrainingPhase
package core.training 
{
    import core.training.type.*;
    import debug.*;
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;
    import utils.*;
    
    public class TrainingPhase extends flash.events.EventDispatcher
    {
        public function TrainingPhase(arg1:flash.events.IEventDispatcher=null)
        {
            _loadPhaseControl = core.training.type.PhaseControl.TIME;
            _loadRecovery = core.training.type.PhaseLoadRecovery.LOAD;
            _loadTargetType = core.training.type.PhaseTarget.HEARTFREQUENCY;
            _phaseChangeMode = core.training.type.PhaseChangeMode.AUTOMATIC;
            _recoveryPhaseControl = core.training.type.PhaseControl.TIME;
            _recoveryTargetType = core.training.type.PhaseTarget.HEARTFREQUENCY;
            _type = core.training.type.PhaseCategory.SIMPLE;
            super(arg1);
            return;
        }

        public function get training():core.training.Training
        {
            return _training;
        }

        public function get iterations():int
        {
            return _iterations;
        }

        public function set iterations(arg1:int):void
        {
            _iterations = arg1;
            return;
        }

        public function get iterationsMax():int
        {
            return 99;
        }

        public function get iterationsMin():int
        {
            return 1;
        }

        public function set training(arg1:core.training.Training):void
        {
            _training = arg1;
            return;
        }

        public function get loadDistance():Number
        {
            return _loadDistance;
        }

        public function set loadDistance(arg1:Number):void
        {
            _loadDistance = arg1;
            return;
        }

        public function get loadDistanceDefault():Number
        {
            return resolveDefaultValue("loadDistance");
        }

        public function get loadDistanceMax():Number
        {
            return 40;
        }

        public function get loadDistanceMin():Number
        {
            return 0;
        }

        public function get trainingId():int
        {
            return _trainingId;
        }

        public function get loadDuration():int
        {
            return _loadDuration;
        }

        public function set loadDuration(arg1:int):void
        {
            if (arg1 != _loadDuration) 
            {
                _loadDuration = arg1;
            }
            return;
        }

        public function get loadDurationDefault():Number
        {
            return resolveDefaultValue("loadDuration");
        }

        public function get loadDurationMax():Number
        {
            return 3599;
        }

        public function get loadDurationMin():Number
        {
            return 0;
        }

        public function set trainingId(arg1:int):void
        {
            _trainingId = arg1;
            return;
        }

        public function get loadPhaseControl():core.training.type.PhaseControl
        {
            return _loadPhaseControl;
        }

        public function set loadPhaseControl(arg1:core.training.type.PhaseControl):void
        {
            _loadPhaseControl = arg1;
            return;
        }

        public function get trainingPhaseId():int
        {
            return _trainingPhaseId;
        }

        public function get loadRecovery():core.training.type.PhaseLoadRecovery
        {
            return _loadRecovery;
        }

        public function set loadRecovery(arg1:core.training.type.PhaseLoadRecovery):void
        {
            _loadRecovery = arg1;
            return;
        }

        public function set trainingPhaseId(arg1:int):void
        {
            _trainingPhaseId = arg1;
            return;
        }

        public function get loadTargetMax():int
        {
            if (_loadTargetMax == -1) 
            {
                _loadTargetMax = loadTargetMaxDefault;
            }
            return _loadTargetMax;
        }

        public function set loadTargetMax(arg1:int):void
        {
            _loadTargetMax = arg1;
            return;
        }

        public function get loadTargetMaxDefault():int
        {
            return resolveDefaultValue("loadTargetMax");
        }

        public function get loadTargetMaxMax():int
        {
            return resolveMaxValue("loadTargetMax");
        }

        public function get loadTargetMaxMin():int
        {
            return resolveMinValue("loadTargetMax");
        }

        public function get type():core.training.type.PhaseCategory
        {
            return _type;
        }

        public function get loadTargetMin():int
        {
            if (_loadTargetMin == -1) 
            {
                _loadTargetMin = loadTargetMinDefault;
            }
            return _loadTargetMin;
        }

        public function set loadTargetMin(arg1:int):void
        {
            _loadTargetMin = arg1;
            return;
        }

        public function get loadTargetMinDefault():int
        {
            return resolveDefaultValue("loadTargetMin");
        }

        public function get loadTargetMinMax():int
        {
            return resolveMaxValue("loadTargetMin");
        }

        public function get loadTargetMinMin():int
        {
            return resolveMinValue("loadTargetMin");
        }

        public function set type(arg1:core.training.type.PhaseCategory):void
        {
            _type = arg1;
            return;
        }

        public function get loadTargetType():core.training.type.PhaseTarget
        {
            return _loadTargetType;
        }

        public function set loadTargetType(arg1:core.training.type.PhaseTarget):void
        {
            _loadTargetType = arg1;
            return;
        }

        public function resolveMaxValue(arg1:String):Number
        {
            var loc1:*=0;
        }

        public function get loadTargetValue():Number
        {
            if (_loadTargetValue == -1) 
            {
                _loadTargetValue = loadTargetValueDefault;
            }
            return _loadTargetValue;
        }

        public function set loadTargetValue(arg1:Number):void
        {
            _loadTargetValue = arg1;
            return;
        }

        public function get loadTargetValueDefault():Number
        {
            return resolveDefaultValue("loadTargetValue");
        }

        public function get recoveryTargetMinMin():int
        {
            return resolveMinValue("recoveryTargetMin");
        }

        public function get phaseChangeMode():core.training.type.PhaseChangeMode
        {
            return _phaseChangeMode;
        }

        public function set phaseChangeMode(arg1:core.training.type.PhaseChangeMode):void
        {
            _phaseChangeMode = arg1;
            return;
        }

        public function resolveMinValue(arg1:String):Number
        {
            var loc1:*=0;
        }

        public function get position():int
        {
            return _position;
        }

        public function set position(arg1:int):void
        {
            _position = arg1;
            return;
        }

        public function resolveDefaultValue(arg1:String):Number
        {
            var loc1:*=0;
            var loc2:*=arg1;
            while ("loadTargetValue" === loc2) 
            {
                if (loadTargetType == core.training.type.PhaseTarget.HEARTFREQUENCY || recoveryTargetType == core.training.type.PhaseTarget.HEARTFREQUENCY) 
                {
                    loc1 = 100;
                }
                else 
                {
                    loc1 = 0;
                }
            }
        }

        public function get recoveryDistance():Number
        {
            if (_recoveryDistance == -1) 
            {
                _recoveryDistance = recoveryDistanceDefault;
            }
            return _recoveryDistance;
        }

        public function set recoveryDistance(arg1:Number):void
        {
            _recoveryDistance = arg1;
            return;
        }

        public function get recoveryDistanceDefault():Number
        {
            return resolveDefaultValue("recoveryDistance");
        }

        public override function toString():String
        {
            return "Position: " + position + "\tTititel: " + titel + "\tId: " + trainingId;
        }

        public function get recoveryDuration():int
        {
            if (_recoveryDuration == -1) 
            {
                _recoveryDuration = recoveryDurationDefault;
            }
            return _recoveryDuration;
        }

        public function set recoveryDuration(arg1:int):void
        {
            _recoveryDuration = arg1;
            return;
        }

        public function get recoveryDurationDefault():Number
        {
            return resolveDefaultValue("recoveryDuration");
        }

        public static function copy(arg1:core.training.TrainingPhase):core.training.TrainingPhase
        {
            var loc5:*=flash.utils.getQualifiedClassName(arg1);
            flash.net.registerClassAlias(loc5, flash.utils.getDefinitionByName(loc5) as Class);
            var loc1:*=arg1.type;
            arg1.type = null;
            loc5 = flash.utils.getQualifiedClassName(loc1);
            flash.net.registerClassAlias(loc5, flash.utils.getDefinitionByName(loc5) as Class);
            var loc4:*=arg1.phaseChangeMode;
            arg1.phaseChangeMode = null;
            loc5 = flash.utils.getQualifiedClassName(loc4);
            flash.net.registerClassAlias(loc5, flash.utils.getDefinitionByName(loc5) as Class);
            var loc2:*=arg1.loadPhaseControl;
            arg1.loadPhaseControl = null;
            loc5 = flash.utils.getQualifiedClassName(loc2);
            flash.net.registerClassAlias(loc5, flash.utils.getDefinitionByName(loc5) as Class);
            var loc6:*=arg1.recoveryPhaseControl;
            arg1.recoveryPhaseControl = null;
            var loc8:*=arg1.loadRecovery;
            arg1.loadRecovery = null;
            loc5 = flash.utils.getQualifiedClassName(core.training.type.PhaseLoadRecovery);
            flash.net.registerClassAlias(loc5, flash.utils.getDefinitionByName(loc5) as Class);
            var loc3:*=arg1.loadTargetType;
            arg1.loadTargetType = null;
            loc5 = flash.utils.getQualifiedClassName(loc3);
            flash.net.registerClassAlias(loc5, flash.utils.getDefinitionByName(loc5) as Class);
            var loc7:*=arg1.recoveryTargetType;
            arg1.recoveryTargetType = null;
            var loc9:*;
            var loc10:*;
            arg1.type = loc10 = loc1;
            (loc9 = utils.BackendUtil.copy(arg1) as TrainingPhase).type = loc10;
            arg1.phaseChangeMode = loc10 = loc4;
            loc9.phaseChangeMode = loc10;
            arg1.loadPhaseControl = loc10 = loc2;
            loc9.loadPhaseControl = loc10;
            arg1.recoveryPhaseControl = loc10 = loc6;
            loc9.recoveryPhaseControl = loc10;
            arg1.loadRecovery = loc10 = loc8;
            loc9.loadRecovery = loc10;
            arg1.loadTargetType = loc10 = loc3;
            loc9.loadTargetType = loc10;
            arg1.recoveryTargetType = loc10 = loc7;
            loc9.recoveryTargetType = loc10;
            return loc9;
        }

        public function get recoveryPhaseControl():core.training.type.PhaseControl
        {
            return _recoveryPhaseControl;
        }

        public function set recoveryPhaseControl(arg1:core.training.type.PhaseControl):void
        {
            _recoveryPhaseControl = arg1;
            return;
        }

        public function get recoveryTargetMax():int
        {
            if (_recoveryTargetMax == -1) 
            {
                _recoveryTargetMax = recoveryTargetMaxDefault;
            }
            return _recoveryTargetMax;
        }

        public function set recoveryTargetMax(arg1:int):void
        {
            _recoveryTargetMax = arg1;
            return;
        }

        public function get recoveryTargetMaxDefault():int
        {
            return resolveDefaultValue("recoveryTargetMax");
        }

        public function get recoveryTargetMaxMax():int
        {
            return resolveMaxValue("recoveryTargetMax");
        }

        public function get recoveryTargetMaxMin():int
        {
            return resolveMinValue("recoveryTargetMax");
        }

        public function get recoveryTargetMin():int
        {
            if (_recoveryTargetMin == -1) 
            {
                _recoveryTargetMin = recoveryTargetMinDefault;
            }
            return _recoveryTargetMin;
        }

        public function set recoveryTargetMin(arg1:int):void
        {
            _recoveryTargetMin = arg1;
            return;
        }

        public function get recoveryTargetMinDefault():int
        {
            return resolveDefaultValue("recoveryTargetMin");
        }

        public function get recoveryTargetMinMax():int
        {
            return resolveMaxValue("recoveryTargetMin");
        }

        public function get recoveryTargetType():core.training.type.PhaseTarget
        {
            return _recoveryTargetType;
        }

        public function set recoveryTargetType(arg1:core.training.type.PhaseTarget):void
        {
            _recoveryTargetType = arg1;
            return;
        }

        public function get recoveryTargetValue():Number
        {
            if (_recoveryTargetValue == -1) 
            {
                _recoveryTargetValue = recoveryTargetValueDefault;
            }
            return _recoveryTargetValue;
        }

        public function set recoveryTargetValue(arg1:Number):void
        {
            _recoveryTargetValue = arg1;
            return;
        }

        public function get recoveryTargetValueDefault():Number
        {
            return resolveDefaultValue("recoveryTargetValue");
        }

        public function get titel():String
        {
            return _titel;
        }

        public function set titel(arg1:String):void
        {
            _titel = arg1;
            return;
        }

        internal static const cad_max:Number=180;

        internal static const cad_min:Number=0;

        internal static const dist_max:Number=40;

        internal static const dist_min:Number=0;

        internal static const iterations_max:Number=99;

        internal static const iterations_min:Number=1;

        internal static const percentHRMax_max:Number=100;

        internal static const percentHRMax_min:Number=0;

        internal static const pow_max:Number=2000;

        internal static const pow_min:Number=0;

        internal static const puls_max:Number=240;

        internal static const puls_min:Number=0;

        internal static const time_max:Number=3599;

        internal static const time_min:Number=0;

        internal var _titel:String="";

        internal var _recoveryTargetMin:int=-1;

        internal var _type:core.training.type.PhaseCategory;

        internal var _recoveryTargetValue:Number=-1;

        internal var _training:core.training.Training;

        internal var _iterations:int=1;

        internal var _recoveryTargetType:core.training.type.PhaseTarget;

        internal var _trainingId:int;

        internal var _recoveryTargetMax:int=-1;

        internal var _phaseChangeMode:core.training.type.PhaseChangeMode;

        internal var _loadDistance:Number=0;

        internal var _loadDuration:int=0;

        internal var _loadPhaseControl:core.training.type.PhaseControl;

        internal var _loadRecovery:core.training.type.PhaseLoadRecovery;

        internal var _loadTargetMax:int=-1;

        internal var _loadTargetMin:int=-1;

        internal var _loadTargetType:core.training.type.PhaseTarget;

        internal var _loadTargetValue:Number=-1;

        internal var _position:int;

        internal var _recoveryDistance:Number=-1;

        internal var _recoveryDuration:int=-1;

        public var selected:Boolean;

        internal var _trainingPhaseId:int;

        internal var _recoveryPhaseControl:core.training.type.PhaseControl;
    }
}


//  class TrainingPhaseMapper
package core.training 
{
    import __AS3__.vec.*;
    import core.training.type.*;
    import database.*;
    
    public class TrainingPhaseMapper extends Object
    {
        public function TrainingPhaseMapper()
        {
            super();
            return;
        }

        public static function generateXML(arg1:__AS3__.vec.Vector.<core.training.TrainingPhase>):XML
        {
            var loc1:*=null;
            var loc3:*=null;
            var loc5:*=new XML("<Phases/>");
            var loc4:*=0;
            var loc2:*=arg1.length;
            loc4 = 0;
            while (loc4 < loc2) 
            {
                loc3 = new XML("<Phase/>");
                loc1 = arg1[loc4];
                loc3.@type = loc1.type.toString();
                loc3.@position = loc1.position;
                loc3.@titel = loc1.titel;
                loc3.@phaseChangeMode = loc1.phaseChangeMode.toString();
                loc3.@iterations = loc1.iterations;
                loc3.@loadDuration = loc1.loadDuration;
                loc3.@loadPhaseControl = loc1.loadPhaseControl.toString();
                loc3.@loadTargetType = loc1.loadTargetType.toString();
                loc3.@loadTargetMin = loc1.loadTargetMin;
                loc3.@loadTargetMax = loc1.loadTargetMax;
                loc3.@loadTargetValue = loc1.loadTargetValue;
                loc3.@loadRecovery = loc1.loadRecovery.toString();
                loc3.@loadDistance = loc1.loadDistance;
                loc3.@recoveryDuration = loc1.recoveryDuration;
                loc3.@recoveryPhaseControl = loc1.recoveryPhaseControl.toString();
                loc3.@recoveryTargetType = loc1.recoveryTargetType.toString();
                loc3.@recoveryTargetMin = loc1.recoveryTargetMin;
                loc3.@recoveryTargetMax = loc1.recoveryTargetMax;
                loc3.@recoveryTargetValue = loc1.recoveryTargetValue;
                loc3.@recoveryDistance = loc1.recoveryDistance;
                loc5.appendChild(loc3);
                ++loc4;
            }
            return loc5;
        }

        public static function fromXML(arg1:XML, arg2:__AS3__.vec.Vector.<core.training.TrainingPhase>, arg3:core.training.Training):void
        {
            var loc3:*=null;
            var loc1:*=null;
            var loc5:*=0;
            var loc4:*=null;
            var loc2:*=(loc4 = arg1.Phases.Phase).length();
            loc5 = 0;
            while (loc5 < loc2) 
            {
                loc3 = loc4[loc5];
                (loc1 = new core.training.TrainingPhase()).training = arg3;
                loc1.type = core.training.type.PhaseCategory.fromString(loc3.@type);
                loc1.position = loc3.@position;
                loc1.titel = loc3.@titel;
                loc1.phaseChangeMode = core.training.type.PhaseChangeMode.fromString(loc3.@phaseChangeMode);
                loc1.iterations = loc3.@iterations;
                loc1.loadDuration = loc3.@loadDuration;
                loc1.loadPhaseControl = core.training.type.PhaseControl.fromString(loc3.@loadPhaseControl);
                loc1.loadTargetType = core.training.type.PhaseTarget.fromString(loc3.@loadTargetType);
                loc1.loadTargetMin = loc3.@loadTargetMin;
                loc1.loadTargetMax = loc3.@loadTargetMax;
                loc1.loadTargetValue = loc3.@loadTargetValue;
                loc1.loadRecovery = core.training.type.PhaseLoadRecovery.fromString(loc3.@loadRecovery);
                loc1.loadDistance = loc3.@loadDistance;
                loc1.recoveryDuration = loc3.@recoveryDuration;
                loc1.recoveryPhaseControl = core.training.type.PhaseControl.fromString(loc3.@recoveryPhaseControl);
                loc1.recoveryTargetType = core.training.type.PhaseTarget.fromString(loc3.@recoveryTargetType);
                loc1.recoveryTargetMin = loc3.@recoveryTargetMin;
                loc1.recoveryTargetMax = loc3.@recoveryTargetMax;
                loc1.recoveryTargetValue = loc3.@recoveryTargetValue;
                loc1.recoveryDistance = loc3.@recoveryDistance;
                arg2.push(loc1);
                ++loc5;
            }
            return;
        }

        public static function generateDBInsert(arg1:core.training.TrainingPhase, arg2:Array, arg3:Object):void
        {
            if (arg1.trainingPhaseId > 0) 
            {
                arg2.push("trainingPhaseId");
                arg3[":trainingPhaseId"] = arg1.trainingPhaseId;
            }
            arg2.push("trainingId");
            if (arg1.training) 
            {
                arg1.trainingId = arg1.training.trainingId;
            }
            arg3[":trainingId"] = arg1.trainingId;
            arg2.push("type");
            arg3[":type"] = arg1.type ? arg1.type.toString() : null;
            arg2.push("position");
            arg3[":position"] = arg1.position;
            arg2.push("titel");
            arg3[":titel"] = arg1.titel;
            arg2.push("phaseChangeMode");
            arg3[":phaseChangeMode"] = arg1.phaseChangeMode ? arg1.phaseChangeMode.toString() : null;
            arg2.push("iterations");
            arg3[":iterations"] = arg1.iterations;
            arg2.push("loadDuration");
            arg3[":loadDuration"] = arg1.loadDuration;
            arg2.push("loadPhaseControl");
            arg3[":loadPhaseControl"] = arg1.loadPhaseControl ? arg1.loadPhaseControl.toString() : null;
            arg2.push("loadTargetType");
            arg3[":loadTargetType"] = arg1.loadTargetType ? arg1.loadTargetType.toString() : null;
            arg2.push("loadTargetMin");
            arg3[":loadTargetMin"] = arg1.loadTargetMin;
            arg2.push("loadTargetMax");
            arg3[":loadTargetMax"] = arg1.loadTargetMax;
            arg2.push("loadTargetValue");
            arg3[":loadTargetValue"] = arg1.loadTargetValue;
            arg2.push("loadDistance");
            arg3[":loadDistance"] = arg1.loadDistance;
            arg2.push("loadRecovery");
            arg3[":loadRecovery"] = arg1.loadRecovery ? arg1.loadRecovery.toString() : null;
            arg2.push("recoveryDuration");
            arg3[":recoveryDuration"] = arg1.recoveryDuration.toString();
            arg2.push("recoveryPhaseControl");
            arg3[":recoveryPhaseControl"] = arg1.recoveryPhaseControl ? arg1.recoveryPhaseControl.toString() : null;
            arg2.push("recoveryTargetType");
            arg3[":recoveryTargetType"] = arg1.recoveryTargetType ? arg1.recoveryTargetType.toString() : null;
            arg2.push("recoveryTargetMin");
            arg3[":recoveryTargetMin"] = arg1.recoveryTargetMin;
            arg2.push("recoveryTargetMax");
            arg3[":recoveryTargetMax"] = arg1.recoveryTargetMax;
            arg2.push("recoveryTargetValue");
            arg3[":recoveryTargetValue"] = arg1.recoveryTargetValue;
            arg2.push("recoveryDistance");
            arg3[":recoveryDistance"] = arg1.recoveryDistance;
            return;
        }

        public static function fromDB(arg1:core.training.TrainingPhase, arg2:Object):void
        {
            arg1.trainingPhaseId = arg2["trainingPhaseId"];
            arg1.trainingId = arg2["trainingId"];
            arg1.type = core.training.type.PhaseCategory.fromString(arg2["type"]);
            arg1.position = arg2["position"];
            arg1.titel = arg2["titel"];
            arg1.phaseChangeMode = core.training.type.PhaseChangeMode.fromString(arg2["phaseChangeMode"]);
            arg1.iterations = arg2["iterations"];
            arg1.loadDuration = arg2["loadDuration"];
            arg1.loadPhaseControl = core.training.type.PhaseControl.fromString(arg2["loadPhaseControl"]);
            arg1.loadTargetType = core.training.type.PhaseTarget.fromString(arg2["loadTargetType"]);
            arg1.loadTargetMin = arg2["loadTargetMin"];
            arg1.loadTargetMax = arg2["loadTargetMax"];
            arg1.loadTargetValue = arg2["loadTargetValue"];
            arg1.loadDistance = arg2["loadDistance"];
            arg1.loadRecovery = core.training.type.PhaseLoadRecovery.fromString(arg2["loadRecovery"]);
            arg1.recoveryDuration = arg2["recoveryDuration"];
            arg1.recoveryPhaseControl = core.training.type.PhaseControl.fromString(arg2["recoveryPhaseControl"]);
            arg1.recoveryTargetType = core.training.type.PhaseTarget.fromString(arg2["recoveryTargetType"]);
            arg1.recoveryTargetMin = arg2["recoveryTargetMin"];
            arg1.recoveryTargetMax = arg2["recoveryTargetMax"];
            arg1.recoveryTargetValue = arg2["recoveryTargetValue"];
            arg1.recoveryDistance = arg2["recoveryDistance"];
            return;
        }

        public static function generateDBCreateTable(arg1:uint):database.DatabaseTable
        {
            var loc1:*=null;
            var loc2:*=arg1;
            while (400 === loc2) 
            {
                DB_TABLE_400 = new database.DatabaseTable("TrainingPhase");
                DB_TABLE_400.addColumns([["trainingPhaseId", "INTEGER", false, true, true], ["trainingId", "INTEGER", false], ["type", "VARCHAR", true], ["position", "INTEGER", true], ["titel", "VARCHAR", true], ["phaseChangeMode", "VARCHAR", true], ["iterations", "INTEGER", true], ["loadDuration", "INTEGER", true], ["loadPhaseControl", "VARCHAR", true], ["loadTargetType", "VARCHAR", true], ["loadTargetMin", "INTEGER", true], ["loadTargetMax", "INTEGER", true], ["loadRecovery", "VARCHAR", true], ["loadDistance", "NUMERIC", true], ["recoveryDuration", "INTEGER", true], ["recoveryPhaseControl", "VARCHAR", true], ["recoveryTargetType", "VARCHAR", true], ["recoveryTargetMin", "INTEGER", true], ["recoveryTargetMax", "INTEGER", true], ["recoveryDistance", "NUMERIC", true], ["emptyField1", "VARCHAR", true], ["emptyField2", "VARCHAR", true]]);
                loc1 = DB_TABLE_400;
            }
        }

        public static function generateDBCreateIndex():String
        {
            var loc1:*="CREATE INDEX IF NOT EXISTS TrainingIdOnTrainingPhase ON TrainingPhase (trainingId)";
            return loc1;
        }

        public static function getInsertStatement(arg1:Array):String
        {
            return "INSERT OR REPLACE INTO TrainingPhase (" + arg1.toString() + ") VALUES (:" + arg1.join(", :") + ");";
        }

        public static const col_iterations:String="iterations";

        public static const col_loadDistance:String="loadDistance";

        public static const col_loadDuration:String="loadDuration";

        public static const col_loadPhaseControl:String="loadPhaseControl";

        public static const col_loadRecovery:String="loadRecovery";

        public static const col_loadTargetMax:String="loadTargetMax";

        public static const col_loadTargetMin:String="loadTargetMin";

        public static const col_loadTargetValue:String="loadTargetValue";

        public static const col_loadtargetType:String="loadTargetType";

        public static const col_phaseChangeMode:String="phaseChangeMode";

        public static const col_position:String="position";

        public static const col_recoveryDistance:String="recoveryDistance";

        public static const col_trainingId:String="trainingId";

        public static const col_trainingPhaseId:String="trainingPhaseId";

        public static const col_type:String="type";

        public static const table_name:String="TrainingPhase";

        public static const col_recoveryPhaseControl:String="recoveryPhaseControl";

        public static const col_recoveryTargetMax:String="recoveryTargetMax";

        public static const col_recoveryTargetMin:String="recoveryTargetMin";

        public static const col_recoveryTargetType:String="recoveryTargetType";

        public static const col_recoveryTargetValue:String="recoveryTargetValue";

        public static const col_titel:String="titel";

        public static const col_recoveryDuration:String="recoveryDuration";

        public static var DB_TABLE_400:database.DatabaseTable;

        public static var DB_TABLE_500:database.DatabaseTable;

        public static var DB_TABLE_510:database.DatabaseTable;

        public static var DB_TABLE_520:database.DatabaseTable;
    }
}


//  class TrainingReference
package core.training 
{
    import __AS3__.vec.*;
    import core.marker.*;
    
    public class TrainingReference extends Object
    {
        public function TrainingReference()
        {
            super();
            plannedPhases = new __AS3__.vec.Vector.<core.marker.Marker>();
            logPhases = new __AS3__.vec.Vector.<core.marker.Marker>();
            return;
        }

        public var count:int;

        public var index:int;

        public var logPhases:__AS3__.vec.Vector.<core.marker.Marker>;

        public var modificationDate:Number;

        public var name:String="";

        public var plannedPhases:__AS3__.vec.Vector.<core.marker.Marker>;

        public var programId:int=0;

        public var startPoint:uint;

        public var totalPhases:int=0;

        public var trainingGUID:String="";

        public var workoutId:int=0;
    }
}


