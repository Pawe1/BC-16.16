//class IBacklightLevel
package core.settings.interfaces 
{
    public dynamic interface IBacklightLevel
    {
        function get backlightLevel():uint;

        function set backlightLevel(arg1:uint):void;

        function get backlightLevelMax():int;

        function get backlightLevelMin():int;
    }
}


