//package interfaces
//  class IGhostRaceLog
package handler.interfaces 
{
    import core.activities.*;
    
    public dynamic interface IGhostRaceLog
    {
        function get ghostRaceLog():core.activities.Activity;

        function set ghostRaceLog(arg1:core.activities.Activity):void;
    }
}


//  class IHandlerDispose
package handler.interfaces 
{
    public dynamic interface IHandlerDispose
    {
        function disposeHandler():void;
    }
}


//  class IHandlerDockingStation
package handler.interfaces 
{
    public dynamic interface IHandlerDockingStation
    {
        function sendToDCDS(arg1:String):void;

        function loadFromDCDS(arg1:String):void;

        function disposeDs():void;
    }
}


//  class IHandlerNfc
package handler.interfaces 
{
    public dynamic interface IHandlerNfc
    {
        function sendToDCNFC(arg1:String):void;

        function loadFromDCNFC(arg1:String):void;
    }
}


