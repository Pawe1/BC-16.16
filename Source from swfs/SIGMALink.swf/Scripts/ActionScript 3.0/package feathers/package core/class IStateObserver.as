//class IStateObserver
package feathers.core 
{
    public interface IStateObserver
    {
        function get stateContext():feathers.core.IStateContext;

        function set stateContext(arg1:feathers.core.IStateContext):void;
    }
}


