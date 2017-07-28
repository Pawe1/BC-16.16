//class IFeathersEventDispatcher
package feathers.core 
{
    import starling.events.*;
    
    public interface IFeathersEventDispatcher
    {
        function addEventListener(arg1:String, arg2:Function):void;

        function removeEventListener(arg1:String, arg2:Function):void;

        function removeEventListeners(arg1:String=null):void;

        function dispatchEvent(arg1:starling.events.Event):void;

        function dispatchEventWith(arg1:String, arg2:Boolean=false, arg3:Object=null):void;

        function hasEventListener(arg1:String, arg2:Function=null):Boolean;
    }
}


