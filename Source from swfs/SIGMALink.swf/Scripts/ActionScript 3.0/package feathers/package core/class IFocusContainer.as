//class IFocusContainer
package feathers.core 
{
    public interface IFocusContainer extends feathers.core.IFocusDisplayObject
    {
        function get isChildFocusEnabled():Boolean;

        function set isChildFocusEnabled(arg1:Boolean):void;
    }
}


