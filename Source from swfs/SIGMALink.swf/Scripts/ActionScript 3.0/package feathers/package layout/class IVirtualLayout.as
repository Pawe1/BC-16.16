//class IVirtualLayout
package feathers.layout 
{
    import __AS3__.vec.*;
    import flash.geom.*;
    import starling.display.*;
    
    public interface IVirtualLayout extends feathers.layout.ILayout
    {
        function get useVirtualLayout():Boolean;

        function set useVirtualLayout(arg1:Boolean):void;

        function get typicalItem():starling.display.DisplayObject;

        function set typicalItem(arg1:starling.display.DisplayObject):void;

        function measureViewPort(arg1:int, arg2:feathers.layout.ViewPortBounds=null, arg3:flash.geom.Point=null):flash.geom.Point;

        function getVisibleIndicesAtScrollPosition(arg1:Number, arg2:Number, arg3:Number, arg4:Number, arg5:int, arg6:__AS3__.vec.Vector.<int>=null):__AS3__.vec.Vector.<int>;
    }
}


