//class IHeartrateLimits
package core.settings.interfaces 
{
    public dynamic interface IHeartrateLimits
    {
        function get lowerLimit():int;

        function set lowerLimit(arg1:int):void;

        function get lowerLimitMax():int;

        function get lowerLimitMin():int;

        function get upperLimit():int;

        function set upperLimit(arg1:int):void;

        function get upperLimitMax():int;

        function get upperLimitMin():int;
    }
}


