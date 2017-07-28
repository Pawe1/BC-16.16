//class ILogger
package org.as3commons.logging.api 
{
    public interface ILogger
    {
        function get name():String;

        function get shortName():String;

        function get person():String;

        function debug(arg1:*, arg2:Array=null):void;

        function info(arg1:*, arg2:Array=null):void;

        function warn(arg1:*, arg2:Array=null):void;

        function error(arg1:*, arg2:Array=null):void;

        function fatal(arg1:*, arg2:Array=null):void;

        function get debugEnabled():Boolean;

        function get infoEnabled():Boolean;

        function get warnEnabled():Boolean;

        function get errorEnabled():Boolean;

        function get fatalEnabled():Boolean;
    }
}


