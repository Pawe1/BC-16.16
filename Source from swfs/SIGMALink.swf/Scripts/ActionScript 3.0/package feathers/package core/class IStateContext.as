//class IStateContext
package feathers.core 
{
    public interface IStateContext extends feathers.core.IFeathersEventDispatcher
    {
        function get currentState():String;
    }
}


