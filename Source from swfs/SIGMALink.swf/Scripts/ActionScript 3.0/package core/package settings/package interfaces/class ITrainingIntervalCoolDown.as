//class ITrainingIntervalCoolDown
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


