//class IIMETextEditor
package feathers.core 
{
    public interface IIMETextEditor extends feathers.core.ITextEditor
    {
        function get selectionAnchorIndex():int;

        function get selectionActiveIndex():int;
    }
}


