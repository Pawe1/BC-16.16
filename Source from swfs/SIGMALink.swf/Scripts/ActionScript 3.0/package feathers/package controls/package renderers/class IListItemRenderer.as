//class IListItemRenderer
package feathers.controls.renderers 
{
    import feathers.controls.*;
    import feathers.core.*;
    
    public interface IListItemRenderer extends feathers.core.IToggle
    {
        function get data():Object;

        function set data(arg1:Object):void;

        function get index():int;

        function set index(arg1:int):void;

        function get owner():feathers.controls.List;

        function set owner(arg1:feathers.controls.List):void;

        function get factoryID():String;

        function set factoryID(arg1:String):void;
    }
}


