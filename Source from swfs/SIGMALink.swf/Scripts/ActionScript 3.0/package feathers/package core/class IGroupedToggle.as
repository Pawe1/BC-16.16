//class IGroupedToggle
package feathers.core 
{
    public interface IGroupedToggle extends feathers.core.IToggle
    {
        function get toggleGroup():feathers.core.ToggleGroup;

        function set toggleGroup(arg1:feathers.core.ToggleGroup):void;
    }
}


