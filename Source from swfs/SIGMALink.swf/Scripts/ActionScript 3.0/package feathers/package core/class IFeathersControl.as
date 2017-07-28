//class IFeathersControl
package feathers.core 
{
    import feathers.skins.*;
    
    public interface IFeathersControl extends feathers.core.IValidating, feathers.core.IMeasureDisplayObject
    {
        function get isEnabled():Boolean;

        function set isEnabled(arg1:Boolean):void;

        function get isInitialized():Boolean;

        function get isCreated():Boolean;

        function get styleNameList():feathers.core.TokenList;

        function get styleName():String;

        function set styleName(arg1:String):void;

        function get styleProvider():feathers.skins.IStyleProvider;

        function set styleProvider(arg1:feathers.skins.IStyleProvider):void;

        function get toolTip():String;

        function set toolTip(arg1:String):void;

        function setSize(arg1:Number, arg2:Number):void;

        function move(arg1:Number, arg2:Number):void;

        function resetStyleProvider():void;

        function initializeNow():void;
    }
}


