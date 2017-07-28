//class IFeathersDisplayObject
package feathers.core 
{
    import flash.geom.*;
    import starling.display.*;
    import starling.filters.*;
    import starling.rendering.*;
    
    public interface IFeathersDisplayObject extends feathers.core.IFeathersEventDispatcher
    {
        function get x():Number;

        function set x(arg1:Number):void;

        function get y():Number;

        function set y(arg1:Number):void;

        function get width():Number;

        function set width(arg1:Number):void;

        function get height():Number;

        function set height(arg1:Number):void;

        function get pivotX():Number;

        function set pivotX(arg1:Number):void;

        function get pivotY():Number;

        function set pivotY(arg1:Number):void;

        function get scaleX():Number;

        function set scaleX(arg1:Number):void;

        function get scaleY():Number;

        function set scaleY(arg1:Number):void;

        function get skewX():Number;

        function set skewX(arg1:Number):void;

        function get skewY():Number;

        function set skewY(arg1:Number):void;

        function get blendMode():String;

        function set blendMode(arg1:String):void;

        function get name():String;

        function set name(arg1:String):void;

        function get touchable():Boolean;

        function set touchable(arg1:Boolean):void;

        function get visible():Boolean;

        function set visible(arg1:Boolean):void;

        function get alpha():Number;

        function set alpha(arg1:Number):void;

        function get rotation():Number;

        function set rotation(arg1:Number):void;

        function get mask():starling.display.DisplayObject;

        function set mask(arg1:starling.display.DisplayObject):void;

        function get parent():starling.display.DisplayObjectContainer;

        function get base():starling.display.DisplayObject;

        function get root():starling.display.DisplayObject;

        function get stage():starling.display.Stage;

        function get transformationMatrix():flash.geom.Matrix;

        function get useHandCursor():Boolean;

        function set useHandCursor(arg1:Boolean):void;

        function get bounds():flash.geom.Rectangle;

        function get filter():starling.filters.FragmentFilter;

        function set filter(arg1:starling.filters.FragmentFilter):void;

        function removeFromParent(arg1:Boolean=false):void;

        function hitTest(arg1:flash.geom.Point):starling.display.DisplayObject;

        function localToGlobal(arg1:flash.geom.Point, arg2:flash.geom.Point=null):flash.geom.Point;

        function globalToLocal(arg1:flash.geom.Point, arg2:flash.geom.Point=null):flash.geom.Point;

        function getTransformationMatrix(arg1:starling.display.DisplayObject, arg2:flash.geom.Matrix=null):flash.geom.Matrix;

        function getBounds(arg1:starling.display.DisplayObject, arg2:flash.geom.Rectangle=null):flash.geom.Rectangle;

        function render(arg1:starling.rendering.Painter):void;

        function dispose():void;
    }
}


