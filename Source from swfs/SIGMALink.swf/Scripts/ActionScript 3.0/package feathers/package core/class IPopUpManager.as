//class IPopUpManager
package feathers.core 
{
    import starling.display.*;
    
    public interface IPopUpManager
    {
        function get overlayFactory():Function;

        function set overlayFactory(arg1:Function):void;

        function get root():starling.display.DisplayObjectContainer;

        function set root(arg1:starling.display.DisplayObjectContainer):void;

        function get popUpCount():int;

        function addPopUp(arg1:starling.display.DisplayObject, arg2:Boolean=true, arg3:Boolean=true, arg4:Function=null):starling.display.DisplayObject;

        function removePopUp(arg1:starling.display.DisplayObject, arg2:Boolean=false):starling.display.DisplayObject;

        function removeAllPopUps(arg1:Boolean=false):void;

        function isPopUp(arg1:starling.display.DisplayObject):Boolean;

        function isTopLevelPopUp(arg1:starling.display.DisplayObject):Boolean;

        function centerPopUp(arg1:starling.display.DisplayObject):void;
    }
}


