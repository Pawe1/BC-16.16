//class IHandlerDockingStation
package handler.interfaces 
{
    public dynamic interface IHandlerDockingStation
    {
        function sendToDCDS(arg1:String):void;

        function loadFromDCDS(arg1:String):void;

        function disposeDs():void;
    }
}


