//class ISleepScreen
package core.units.interfaces 
{
    import core.sleepScreen.*;
    
    public dynamic interface ISleepScreen
    {
        function set sleepScreen(arg1:core.sleepScreen.SleepScreen):void;

        function get sleepScreen():core.sleepScreen.SleepScreen;
    }
}


