//class TrainingPhase
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


