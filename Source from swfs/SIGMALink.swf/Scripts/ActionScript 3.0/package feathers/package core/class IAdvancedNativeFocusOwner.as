//class IAdvancedNativeFocusOwner
package feathers.core 
{
    public interface IAdvancedNativeFocusOwner extends feathers.core.INativeFocusOwner
    {
        function get hasFocus():Boolean;

        function setFocus():void;
    }
}


