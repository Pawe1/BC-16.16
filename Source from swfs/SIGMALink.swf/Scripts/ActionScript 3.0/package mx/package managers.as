//package managers
//  class ISystemManager
package mx.managers 
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import mx.core.*;
    
    public interface ISystemManager extends flash.events.IEventDispatcher, mx.core.IChildList, mx.core.IFlexModuleFactory
    {
        function get cursorChildren():mx.core.IChildList;

        function get document():Object;

        function set document(arg1:Object):void;

        function get embeddedFontList():Object;

        function get focusPane():flash.display.Sprite;

        function set focusPane(arg1:flash.display.Sprite):void;

        function get isProxy():Boolean;

        function get loaderInfo():flash.display.LoaderInfo;

        function get numModalWindows():int;

        function set numModalWindows(arg1:int):void;

        function get popUpChildren():mx.core.IChildList;

        function get rawChildren():mx.core.IChildList;

        function get screen():flash.geom.Rectangle;

        function get stage():flash.display.Stage;

        function get toolTipChildren():mx.core.IChildList;

        function get topLevelSystemManager():mx.managers.ISystemManager;

        function getDefinitionByName(arg1:String):Object;

        function isTopLevel():Boolean;

        function isFontFaceEmbedded(arg1:flash.text.TextFormat):Boolean;

        function isTopLevelRoot():Boolean;

        function getTopLevelRoot():flash.display.DisplayObject;

        function getSandboxRoot():flash.display.DisplayObject;

        function getVisibleApplicationRect(arg1:flash.geom.Rectangle=null, arg2:Boolean=false):flash.geom.Rectangle;

        function deployMouseShields(arg1:Boolean):void;

        function invalidateParentSizeAndDisplayList():void;
    }
}


