//class ITrainingIntervalWarmUp
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


