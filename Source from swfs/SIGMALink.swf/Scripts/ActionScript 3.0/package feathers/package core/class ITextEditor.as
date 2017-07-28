//class ITextEditor
package feathers.core 
{
    import feathers.text.*;
    import flash.geom.*;
    
    public interface ITextEditor extends feathers.core.IFeathersControl, feathers.core.ITextBaselineControl
    {
        function get text():String;

        function set text(arg1:String):void;

        function get displayAsPassword():Boolean;

        function set displayAsPassword(arg1:Boolean):void;

        function get maxChars():int;

        function set maxChars(arg1:int):void;

        function get restrict():String;

        function set restrict(arg1:String):void;

        function get isEditable():Boolean;

        function set isEditable(arg1:Boolean):void;

        function get isSelectable():Boolean;

        function set isSelectable(arg1:Boolean):void;

        function get setTouchFocusOnEndedPhase():Boolean;

        function get selectionBeginIndex():int;

        function get selectionEndIndex():int;

        function get fontStyles():feathers.text.FontStylesSet;

        function set fontStyles(arg1:feathers.text.FontStylesSet):void;

        function setFocus(arg1:flash.geom.Point=null):void;

        function clearFocus():void;

        function selectRange(arg1:int, arg2:int):void;

        function measureText(arg1:flash.geom.Point=null):flash.geom.Point;
    }
}


