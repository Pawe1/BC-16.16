//class IUIComponent
package mx.core 
{
    import flash.display.*;
    import mx.managers.*;
    
    public interface IUIComponent extends mx.core.IFlexDisplayObject
    {
        function get baselinePosition():Number;

        function get document():Object;

        function set document(arg1:Object):void;

        function get enabled():Boolean;

        function set enabled(arg1:Boolean):void;

        function get explicitHeight():Number;

        function set explicitHeight(arg1:Number):void;

        function get explicitMaxHeight():Number;

        function get explicitMaxWidth():Number;

        function get explicitMinHeight():Number;

        function get explicitMinWidth():Number;

        function get explicitWidth():Number;

        function set explicitWidth(arg1:Number):void;

        function get focusPane():flash.display.Sprite;

        function set focusPane(arg1:flash.display.Sprite):void;

        function get includeInLayout():Boolean;

        function set includeInLayout(arg1:Boolean):void;

        function get isPopUp():Boolean;

        function set isPopUp(arg1:Boolean):void;

        function get maxHeight():Number;

        function get maxWidth():Number;

        function get measuredMinHeight():Number;

        function set measuredMinHeight(arg1:Number):void;

        function get measuredMinWidth():Number;

        function set measuredMinWidth(arg1:Number):void;

        function get minHeight():Number;

        function get minWidth():Number;

        function get owner():flash.display.DisplayObjectContainer;

        function set owner(arg1:flash.display.DisplayObjectContainer):void;

        function get percentHeight():Number;

        function set percentHeight(arg1:Number):void;

        function get percentWidth():Number;

        function set percentWidth(arg1:Number):void;

        function get systemManager():mx.managers.ISystemManager;

        function set systemManager(arg1:mx.managers.ISystemManager):void;

        function get tweeningProperties():Array;

        function set tweeningProperties(arg1:Array):void;

        function initialize():void;

        function parentChanged(arg1:flash.display.DisplayObjectContainer):void;

        function getExplicitOrMeasuredWidth():Number;

        function getExplicitOrMeasuredHeight():Number;

        function setVisible(arg1:Boolean, arg2:Boolean=false):void;

        function owns(arg1:flash.display.DisplayObject):Boolean;
    }
}


