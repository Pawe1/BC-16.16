//class IPopUpContentManager
package feathers.controls.popups 
{
    import starling.display.*;
    
    public interface IPopUpContentManager
    {
        function get isOpen():Boolean;

        function open(arg1:starling.display.DisplayObject, arg2:starling.display.DisplayObject):void;

        function close():void;

        function dispose():void;
    }
}


