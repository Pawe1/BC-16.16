//class IPowerZones7
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


