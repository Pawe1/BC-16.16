//class IViewPort
package feathers.controls.supportClasses 
{
    import feathers.core.*;
    
    public interface IViewPort extends feathers.core.IFeathersControl
    {
        function get visibleWidth():Number;

        function set visibleWidth(arg1:Number):void;

        function get minVisibleWidth():Number;

        function set minVisibleWidth(arg1:Number):void;

        function get maxVisibleWidth():Number;

        function set maxVisibleWidth(arg1:Number):void;

        function get visibleHeight():Number;

        function set visibleHeight(arg1:Number):void;

        function get minVisibleHeight():Number;

        function set minVisibleHeight(arg1:Number):void;

        function get maxVisibleHeight():Number;

        function set maxVisibleHeight(arg1:Number):void;

        function get contentX():Number;

        function get contentY():Number;

        function get horizontalScrollPosition():Number;

        function set horizontalScrollPosition(arg1:Number):void;

        function get verticalScrollPosition():Number;

        function set verticalScrollPosition(arg1:Number):void;

        function get horizontalScrollStep():Number;

        function get verticalScrollStep():Number;

        function get requiresMeasurementOnScroll():Boolean;
    }
}


