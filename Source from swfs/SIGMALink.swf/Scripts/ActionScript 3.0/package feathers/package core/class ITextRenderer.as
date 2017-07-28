//class ITextRenderer
package feathers.core 
{
    import feathers.text.*;
    import flash.geom.*;
    
    public interface ITextRenderer extends feathers.core.IStateObserver, feathers.core.IFeathersControl, feathers.core.ITextBaselineControl
    {
        function get text():String;

        function set text(arg1:String):void;

        function get wordWrap():Boolean;

        function set wordWrap(arg1:Boolean):void;

        function get numLines():int;

        function get fontStyles():feathers.text.FontStylesSet;

        function set fontStyles(arg1:feathers.text.FontStylesSet):void;

        function measureText(arg1:flash.geom.Point=null):flash.geom.Point;
    }
}


