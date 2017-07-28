//class IMeasureDisplayObject
package feathers.core 
{
    public interface IMeasureDisplayObject extends feathers.core.IFeathersDisplayObject
    {
        function get explicitWidth():Number;

        function get explicitMinWidth():Number;

        function get minWidth():Number;

        function set minWidth(arg1:Number):void;

        function get explicitMaxWidth():Number;

        function get maxWidth():Number;

        function set maxWidth(arg1:Number):void;

        function get explicitHeight():Number;

        function get explicitMinHeight():Number;

        function get minHeight():Number;

        function set minHeight(arg1:Number):void;

        function get explicitMaxHeight():Number;

        function get maxHeight():Number;

        function set maxHeight(arg1:Number):void;
    }
}


