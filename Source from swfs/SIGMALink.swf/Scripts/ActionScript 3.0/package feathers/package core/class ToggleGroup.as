//class ToggleGroup
package feathers.core 
{
    import __AS3__.vec.*;
    import flash.errors.*;
    import starling.events.*;
    
    public class ToggleGroup extends starling.events.EventDispatcher
    {
        public function ToggleGroup()
        {
            this._items = new Vector.<feathers.core.IToggle>();
            super();
            return;
        }

        public function get isSelectionRequired():Boolean
        {
            return this._isSelectionRequired;
        }

        public function set isSelectionRequired(arg1:Boolean):void
        {
            if (this._isSelectionRequired == arg1) 
            {
                return;
            }
            this._isSelectionRequired = arg1;
            if (this._isSelectionRequired && this._selectedIndex < 0 && this._items.length > 0) 
            {
                this.selectedIndex = 0;
            }
            return;
        }

        public function get selectedItem():feathers.core.IToggle
        {
            if (this._selectedIndex < 0) 
            {
                return null;
            }
            return this._items[this._selectedIndex];
        }

        public function set selectedItem(arg1:feathers.core.IToggle):void
        {
            this.selectedIndex = this._items.indexOf(arg1);
            return;
        }

        public function get selectedIndex():int
        {
            return this._selectedIndex;
        }

        public function set selectedIndex(arg1:int):void
        {
            var loc4:*=null;
            var loc1:*=this._items.length;
            if (arg1 < -1 || arg1 >= loc1) 
            {
                throw new RangeError("Index " + arg1 + " is out of range " + loc1 + " for ToggleGroup.");
            }
            var loc2:*=!(this._selectedIndex == arg1);
            this._selectedIndex = arg1;
            this._ignoreChanges = true;
            var loc3:*=0;
            while (loc3 < loc1) 
            {
                loc4 = this._items[loc3];
                loc4.isSelected = loc3 == arg1;
                ++loc3;
            }
            this._ignoreChanges = false;
            if (loc2) 
            {
                this.dispatchEventWith(starling.events.Event.CHANGE);
            }
            return;
        }

        public function get numItems():int
        {
            return this._items.length;
        }

        public function addItem(arg1:feathers.core.IToggle):void
        {
            if (!arg1) 
            {
                throw new ArgumentError("IToggle passed to ToggleGroup addItem() must not be null.");
            }
            var loc1:*=this._items.indexOf(arg1);
            if (loc1 >= 0) 
            {
                throw new flash.errors.IllegalOperationError("Cannot add an item to a ToggleGroup more than once.");
            }
            this._items.push(arg1);
            if (this._selectedIndex < 0 && this._isSelectionRequired) 
            {
                this.selectedItem = arg1;
            }
            else 
            {
                arg1.isSelected = false;
            }
            arg1.addEventListener(starling.events.Event.CHANGE, this.item_changeHandler);
            if (arg1 is feathers.core.IGroupedToggle) 
            {
                feathers.core.IGroupedToggle(arg1).toggleGroup = this;
            }
            return;
        }

        public function removeItem(arg1:feathers.core.IToggle):void
        {
            var loc2:*=0;
            var loc1:*=this._items.indexOf(arg1);
            if (loc1 < 0) 
            {
                return;
            }
            this._items.removeAt(loc1);
            arg1.removeEventListener(starling.events.Event.CHANGE, this.item_changeHandler);
            if (arg1 is feathers.core.IGroupedToggle) 
            {
                feathers.core.IGroupedToggle(arg1).toggleGroup = null;
            }
            if (this._selectedIndex > loc1) 
            {
                --this.selectedIndex;
            }
            else if (this._selectedIndex == loc1) 
            {
                if (this._isSelectionRequired) 
                {
                    loc2 = (this._items.length - 1);
                    if (this._selectedIndex > loc2) 
                    {
                        this.selectedIndex = loc2;
                    }
                    else 
                    {
                        this.dispatchEventWith(starling.events.Event.CHANGE);
                    }
                }
                else 
                {
                    this.selectedIndex = -1;
                }
            }
            return;
        }

        public function removeAllItems():void
        {
            var loc3:*=null;
            var loc1:*=this._items.length;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                loc3 = this._items.shift();
                loc3.removeEventListener(starling.events.Event.CHANGE, this.item_changeHandler);
                if (loc3 is feathers.core.IGroupedToggle) 
                {
                    feathers.core.IGroupedToggle(loc3).toggleGroup = null;
                }
                ++loc2;
            }
            this.selectedIndex = -1;
            return;
        }

        public function hasItem(arg1:feathers.core.IToggle):Boolean
        {
            var loc1:*=this._items.indexOf(arg1);
            return loc1 >= 0;
        }

        public function getItemAt(arg1:int):feathers.core.IToggle
        {
            return this._items[arg1];
        }

        public function getItemIndex(arg1:feathers.core.IToggle):int
        {
            return this._items.indexOf(arg1);
        }

        public function setItemIndex(arg1:feathers.core.IToggle, arg2:int):void
        {
            var loc1:*=this._items.indexOf(arg1);
            if (loc1 < 0) 
            {
                throw new ArgumentError("Attempting to set index of an item that has not been added to this ToggleGroup.");
            }
            if (loc1 === arg2) 
            {
                return;
            }
            this._items.removeAt(loc1);
            this._items.insertAt(arg2, arg1);
            if (this._selectedIndex >= 0) 
            {
                if (this._selectedIndex != loc1) 
                {
                    if (loc1 < this._selectedIndex && arg2 > this._selectedIndex) 
                    {
                        var loc2:*;
                        var loc3:*=((loc2 = this).selectedIndex - 1);
                        loc2.selectedIndex = loc3;
                    }
                    else if (loc1 > this._selectedIndex && arg2 < this._selectedIndex) 
                    {
                        loc3 = ((loc2 = this).selectedIndex + 1);
                        loc2.selectedIndex = loc3;
                    }
                }
                else 
                {
                    this.selectedIndex = arg2;
                }
            }
            return;
        }

        protected function item_changeHandler(arg1:starling.events.Event):void
        {
            if (this._ignoreChanges) 
            {
                return;
            }
            var loc1:*=feathers.core.IToggle(arg1.currentTarget);
            var loc2:*=this._items.indexOf(loc1);
            if (loc1.isSelected || this._isSelectionRequired && this._selectedIndex == loc2) 
            {
                this.selectedIndex = loc2;
            }
            else if (!loc1.isSelected) 
            {
                this.selectedIndex = -1;
            }
            return;
        }

        protected var _items:__AS3__.vec.Vector.<feathers.core.IToggle>;

        protected var _ignoreChanges:Boolean=false;

        protected var _isSelectionRequired:Boolean=true;

        protected var _selectedIndex:int=-1;
    }
}


