//class IService
package core.settings.interfaces 
{
    public dynamic interface IService
    {
        function get serviceInterval():int;

        function set serviceInterval(arg1:int):void;

        function get serviceStatusOn():Boolean;

        function set serviceStatusOn(arg1:Boolean):void;
    }
}


