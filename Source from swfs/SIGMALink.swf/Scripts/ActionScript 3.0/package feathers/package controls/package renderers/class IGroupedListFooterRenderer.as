//class IGroupedListFooterRenderer
package feathers.controls.renderers 
{
    import feathers.controls.*;
    import feathers.core.*;
    
    public interface IGroupedListFooterRenderer extends feathers.core.IFeathersControl
    {
        function get data():Object;

        function set data(arg1:Object):void;

        function get groupIndex():int;

        function set groupIndex(arg1:int):void;

        function get layoutIndex():int;

        function set layoutIndex(arg1:int):void;

        function get owner():feathers.controls.GroupedList;

        function set owner(arg1:feathers.controls.GroupedList):void;

        function get factoryID():String;

        function set factoryID(arg1:String):void;
    }
}


