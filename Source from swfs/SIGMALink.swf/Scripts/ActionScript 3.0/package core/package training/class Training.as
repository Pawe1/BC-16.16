//class Training
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


