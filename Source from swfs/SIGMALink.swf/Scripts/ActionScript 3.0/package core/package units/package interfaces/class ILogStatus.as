//class ILogStatus
package core.units.interfaces 
{
    public dynamic interface ILogStatus
    {
        function get freePackages():int;

        function set freePackages(arg1:int):void;

        function get maxPackages():int;

        function set maxPackages(arg1:int):void;

        function get unitLogStatus():Boolean;

        function set unitLogStatus(arg1:Boolean):void;
    }
}


