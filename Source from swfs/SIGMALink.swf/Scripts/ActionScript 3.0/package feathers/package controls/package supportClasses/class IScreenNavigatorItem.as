//class IScreenNavigatorItem
package feathers.controls.supportClasses 
{
    import starling.display.*;
    
    public interface IScreenNavigatorItem
    {
        function get canDispose():Boolean;

        function getScreen():starling.display.DisplayObject;
    }
}


