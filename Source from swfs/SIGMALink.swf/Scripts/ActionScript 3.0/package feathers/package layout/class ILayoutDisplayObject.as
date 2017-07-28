//class ILayoutDisplayObject
package feathers.layout 
{
    import feathers.core.*;
    
    public interface ILayoutDisplayObject extends feathers.core.IFeathersDisplayObject
    {
        function get layoutData():feathers.layout.ILayoutData;

        function set layoutData(arg1:feathers.layout.ILayoutData):void;

        function get includeInLayout():Boolean;

        function set includeInLayout(arg1:Boolean):void;
    }
}


