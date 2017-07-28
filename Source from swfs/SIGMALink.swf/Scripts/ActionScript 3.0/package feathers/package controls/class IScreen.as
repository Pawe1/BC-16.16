//class IScreen
package feathers.controls 
{
    import feathers.core.*;
    
    public interface IScreen extends feathers.core.IFeathersControl
    {
        function get screenID():String;

        function set screenID(arg1:String):void;

        function get owner():Object;

        function set owner(arg1:Object):void;
    }
}


