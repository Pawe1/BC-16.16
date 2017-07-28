//class IFocusDisplayObject
package feathers.core 
{
    public interface IFocusDisplayObject extends feathers.core.IFeathersDisplayObject
    {
        function get focusManager():feathers.core.IFocusManager;

        function set focusManager(arg1:feathers.core.IFocusManager):void;

        function get isFocusEnabled():Boolean;

        function set isFocusEnabled(arg1:Boolean):void;

        function get nextTabFocus():feathers.core.IFocusDisplayObject;

        function set nextTabFocus(arg1:feathers.core.IFocusDisplayObject):void;

        function get previousTabFocus():feathers.core.IFocusDisplayObject;

        function set previousTabFocus(arg1:feathers.core.IFocusDisplayObject):void;

        function get focusOwner():feathers.core.IFocusDisplayObject;

        function set focusOwner(arg1:feathers.core.IFocusDisplayObject):void;

        function showFocus():void;

        function hideFocus():void;
    }
}


