//class ICustomDateTimeFormatter
package utils.interfaces 
{
    public dynamic interface ICustomDateTimeFormatter extends utils.interfaces.ICustomFormatterBase
    {
        function get dateStyle():String;

        function set dateStyle(arg1:String):void;

        function get timeStyle():String;

        function set timeStyle(arg1:String):void;

        function setStyle(arg1:String, arg2:*):void;
    }
}


