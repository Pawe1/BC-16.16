//class IGroupedLayout
package feathers.layout 
{
    import __AS3__.vec.*;
    
    public interface IGroupedLayout extends feathers.layout.ILayout
    {
        function get headerIndices():__AS3__.vec.Vector.<int>;

        function set headerIndices(arg1:__AS3__.vec.Vector.<int>):void;
    }
}


