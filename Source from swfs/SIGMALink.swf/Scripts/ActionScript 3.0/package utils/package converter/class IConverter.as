//class IConverter
package utils.converter 
{
    public dynamic interface IConverter
    {
        function get inputFormat():String;

        function set inputFormat(arg1:String):void;

        function get outputFormat():String;

        function set outputFormat(arg1:String):void;

        function set toInt(arg1:Boolean):void;

        function get toInt():Boolean;

        function convert(arg1:Object):Number;
    }
}


