//class ITrainingInterval
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


