//class IAutoLapBasedOnTime
package core.settings.interfaces 
{
    public dynamic interface IAutoLapBasedOnTime
    {
        function get autoLapTime():uint;

        function set autoLapTime(arg1:uint):void;

        function get autoLapTimeMax():uint;

        function get autoLapTimeMin():uint;
    }
}


