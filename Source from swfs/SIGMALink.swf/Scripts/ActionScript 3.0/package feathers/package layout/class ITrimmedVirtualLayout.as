//class ITrimmedVirtualLayout
package feathers.layout 
{
    public interface ITrimmedVirtualLayout extends feathers.layout.IVirtualLayout
    {
        function get beforeVirtualizedItemCount():int;

        function set beforeVirtualizedItemCount(arg1:int):void;

        function get afterVirtualizedItemCount():int;

        function set afterVirtualizedItemCount(arg1:int):void;
    }
}


