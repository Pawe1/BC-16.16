//class IFlexDisplayObject
package mx.core 
{
    import flash.accessibility.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    
    public interface IFlexDisplayObject extends flash.display.IBitmapDrawable, flash.events.IEventDispatcher
    {
        function get root():flash.display.DisplayObject;

        function get stage():flash.display.Stage;

        function get name():String;

        function set name(arg1:String):void;

        function get parent():flash.display.DisplayObjectContainer;

        function get mask():flash.display.DisplayObject;

        function set mask(arg1:flash.display.DisplayObject):void;

        function get visible():Boolean;

        function set visible(arg1:Boolean):void;

        function get x():Number;

        function set x(arg1:Number):void;

        function get y():Number;

        function set y(arg1:Number):void;

        function get scaleX():Number;

        function set scaleX(arg1:Number):void;

        function get scaleY():Number;

        function set scaleY(arg1:Number):void;

        function get mouseX():Number;

        function get mouseY():Number;

        function get rotation():Number;

        function set rotation(arg1:Number):void;

        function get alpha():Number;

        function set alpha(arg1:Number):void;

        function get width():Number;

        function set width(arg1:Number):void;

        function get height():Number;

        function set height(arg1:Number):void;

        function get cacheAsBitmap():Boolean;

        function set cacheAsBitmap(arg1:Boolean):void;

        function get opaqueBackground():Object;

        function set opaqueBackground(arg1:Object):void;

        function get scrollRect():flash.geom.Rectangle;

        function set scrollRect(arg1:flash.geom.Rectangle):void;

        function get filters():Array;

        function set filters(arg1:Array):void;

        function get blendMode():String;

        function set blendMode(arg1:String):void;

        function get transform():flash.geom.Transform;

        function set transform(arg1:flash.geom.Transform):void;

        function get scale9Grid():flash.geom.Rectangle;

        function set scale9Grid(arg1:flash.geom.Rectangle):void;

        function globalToLocal(arg1:flash.geom.Point):flash.geom.Point;

        function localToGlobal(arg1:flash.geom.Point):flash.geom.Point;

        function getBounds(arg1:flash.display.DisplayObject):flash.geom.Rectangle;

        function getRect(arg1:flash.display.DisplayObject):flash.geom.Rectangle;

        function get loaderInfo():flash.display.LoaderInfo;

        function hitTestObject(arg1:flash.display.DisplayObject):Boolean;

        function hitTestPoint(arg1:Number, arg2:Number, arg3:Boolean=false):Boolean;

        function get accessibilityProperties():flash.accessibility.AccessibilityProperties;

        function set accessibilityProperties(arg1:flash.accessibility.AccessibilityProperties):void;

        function get measuredHeight():Number;

        function get measuredWidth():Number;

        function move(arg1:Number, arg2:Number):void;

        function setActualSize(arg1:Number, arg2:Number):void;
    }
}


