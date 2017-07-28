//package interfaces
//  class ICustomDateTimeFormatter
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


//  class ICustomFormatter
package utils.interfaces 
{
    public dynamic interface ICustomFormatter extends utils.interfaces.ICustomFormatterBase
    {
        function get formatString():String;

        function set formatString(arg1:String):void;
    }
}


//  class ICustomFormatterBase
package utils.interfaces 
{
    public dynamic interface ICustomFormatterBase
    {
        function format(arg1:Object):String;
    }
}


//  class ICustomTimeFormatter
package utils.interfaces 
{
    public dynamic interface ICustomTimeFormatter extends utils.interfaces.ICustomFormatter
    {
        function set inputType(arg1:String):void;
    }
}


