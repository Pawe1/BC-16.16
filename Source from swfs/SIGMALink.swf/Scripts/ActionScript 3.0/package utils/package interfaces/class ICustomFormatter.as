//class ICustomFormatter
package utils.interfaces 
{
    public dynamic interface ICustomFormatter extends utils.interfaces.ICustomFormatterBase
    {
        function get formatString():String;

        function set formatString(arg1:String):void;
    }
}


