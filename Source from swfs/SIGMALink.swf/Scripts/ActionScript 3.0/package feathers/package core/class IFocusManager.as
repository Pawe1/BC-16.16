//class IFocusManager
package feathers.core 
{
    import starling.display.*;
    
    public interface IFocusManager
    {
        function get isEnabled():Boolean;

        function set isEnabled(arg1:Boolean):void;

        function get focus():feathers.core.IFocusDisplayObject;

        function set focus(arg1:feathers.core.IFocusDisplayObject):void;

        function get root():starling.display.DisplayObjectContainer;
    }
}


