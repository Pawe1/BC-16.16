//class ICorrectionFactor
package core.settings.interfaces 
{
    public dynamic interface ICorrectionFactor
    {
        function get correctionFactor():int;

        function set correctionFactor(arg1:int):void;

        function get correctionFactorMax():int;

        function get correctionFactorMin():int;
    }
}


