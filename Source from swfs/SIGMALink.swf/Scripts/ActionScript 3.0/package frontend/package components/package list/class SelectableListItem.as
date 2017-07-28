//class SelectableListItem
package frontend.components.list 
{
    import flash.utils.*;
    import starling.events.*;
    
    public class SelectableListItem extends starling.events.EventDispatcher
    {
        public function SelectableListItem()
        {
            super();
            return;
        }

        public function isSelected():Boolean
        {
            return !(selectedItems[this.GUID] == null);
        }

        public function addSelection():void
        {
            selectedItems[this.GUID] = this;
            return;
        }

        public function removeSelection():void
        {
            if (selectedItems[this.GUID] != null) 
            {
                delete selectedItems[this.GUID];
            }
            return;
        }

        public function currentSelected():void
        {
            reset();
            selectedItems[this.GUID] = this;
            return;
        }

        public static function reset():void
        {
            selectedItems = new flash.utils.Dictionary();
            return;
        }

        public static function isGUIDSelected(arg1:String):Boolean
        {
            return !(selectedItems[arg1] == null);
        }

        
        {
            selectedItems = new flash.utils.Dictionary();
        }

        public var GUID:String;

        public static var selectedItems:flash.utils.Dictionary;
    }
}


