//class ICountdown
package core.settings.interfaces 
{
    public dynamic interface ICountdown
    {
        function get countdown():Number;

        function set countdown(arg1:Number):void;

        function get countdownMax():Number;

        function get countdownMin():Number;

        function get countdownOn():Boolean;

        function set countdownOn(arg1:Boolean):void;
    }
}


