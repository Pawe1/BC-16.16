//class IPowerTargetZone
package core.settings.interfaces 
{
    public dynamic interface IPowerTargetZone
    {
        function get powerTargetZoneEnabled():Boolean;

        function set powerTargetZoneEnabled(arg1:Boolean):void;

        function get powerTargetZoneLowerLimit():int;

        function set powerTargetZoneLowerLimit(arg1:int):void;

        function get powerTargetZoneLowerLimitMax():int;

        function get powerTargetZoneLowerLimitMin():int;

        function get powerTargetZoneUpperLimit():int;

        function set powerTargetZoneUpperLimit(arg1:int):void;

        function get powerTargetZoneUpperLimitMax():int;

        function get powerTargetZoneUpperLimitMin():int;
    }
}


