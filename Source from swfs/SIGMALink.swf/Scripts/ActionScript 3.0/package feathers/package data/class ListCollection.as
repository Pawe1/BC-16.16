//class ListCollection
package feathers.data 
{
    import __AS3__.vec.*;
    import feathers.events.*;
    import starling.events.*;
    
    public class ListCollection extends starling.events.EventDispatcher
    {
        public function ListCollection(arg1:Object=null)
        {
            super();
            if (!arg1) 
            {
                arg1 = [];
            }
            this.data = arg1;
            return;
        }

        public function get data():Object
        {
            return this._data;
        }

        public function set data(arg1:Object):void
        {
            if (this._data == arg1) 
            {
                return;
            }
            this._data = arg1;
            if (this._data is Array && !(this._dataDescriptor is feathers.data.ArrayListCollectionDataDescriptor)) 
            {
                this._dataDescriptor = new feathers.data.ArrayListCollectionDataDescriptor();
            }
            else if (this._data is Vector.<Number> && !(this._dataDescriptor is feathers.data.VectorNumberListCollectionDataDescriptor)) 
            {
                this._dataDescriptor = new feathers.data.VectorNumberListCollectionDataDescriptor();
            }
            else if (this._data is Vector.<int> && !(this._dataDescriptor is feathers.data.VectorIntListCollectionDataDescriptor)) 
            {
                this._dataDescriptor = new feathers.data.VectorIntListCollectionDataDescriptor();
            }
            else if (this._data is Vector.<uint> && !(this._dataDescriptor is feathers.data.VectorUintListCollectionDataDescriptor)) 
            {
                this._dataDescriptor = new feathers.data.VectorUintListCollectionDataDescriptor();
            }
            else if (this._data is Vector.<> && !(this._dataDescriptor is feathers.data.VectorListCollectionDataDescriptor)) 
            {
                this._dataDescriptor = new feathers.data.VectorListCollectionDataDescriptor();
            }
            else if (this._data is XMLList && !(this._dataDescriptor is feathers.data.XMLListListCollectionDataDescriptor)) 
            {
                this._dataDescriptor = new feathers.data.XMLListListCollectionDataDescriptor();
            }
            if (this._data === null) 
            {
                this._dataDescriptor = null;
            }
            this.dispatchEventWith(feathers.events.CollectionEventType.RESET);
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function get dataDescriptor():feathers.data.IListCollectionDataDescriptor
        {
            return this._dataDescriptor;
        }

        public function set dataDescriptor(arg1:feathers.data.IListCollectionDataDescriptor):void
        {
            if (this._dataDescriptor == arg1) 
            {
                return;
            }
            this._dataDescriptor = arg1;
            this.dispatchEventWith(feathers.events.CollectionEventType.RESET);
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function get length():int
        {
            if (!this._dataDescriptor) 
            {
                return 0;
            }
            return this._dataDescriptor.getLength(this._data);
        }

        public function updateItemAt(arg1:int):void
        {
            this.dispatchEventWith(feathers.events.CollectionEventType.UPDATE_ITEM, false, arg1);
            return;
        }

        public function updateAll():void
        {
            this.dispatchEventWith(feathers.events.CollectionEventType.UPDATE_ALL);
            return;
        }

        public function getItemAt(arg1:int):Object
        {
            return this._dataDescriptor.getItemAt(this._data, arg1);
        }

        public function getItemIndex(arg1:Object):int
        {
            return this._dataDescriptor.getItemIndex(this._data, arg1);
        }

        public function addItemAt(arg1:Object, arg2:int):void
        {
            this._dataDescriptor.addItemAt(this._data, arg1, arg2);
            this.dispatchEventWith(starling.events.Event.CHANGE);
            this.dispatchEventWith(feathers.events.CollectionEventType.ADD_ITEM, false, arg2);
            return;
        }

        public function removeItemAt(arg1:int):Object
        {
            var loc1:*=this._dataDescriptor.removeItemAt(this._data, arg1);
            this.dispatchEventWith(starling.events.Event.CHANGE);
            this.dispatchEventWith(feathers.events.CollectionEventType.REMOVE_ITEM, false, arg1);
            return loc1;
        }

        public function removeItem(arg1:Object):void
        {
            var loc1:*=this.getItemIndex(arg1);
            if (loc1 >= 0) 
            {
                this.removeItemAt(loc1);
            }
            return;
        }

        public function removeAll():void
        {
            if (this.length == 0) 
            {
                return;
            }
            this._dataDescriptor.removeAll(this._data);
            this.dispatchEventWith(starling.events.Event.CHANGE);
            this.dispatchEventWith(feathers.events.CollectionEventType.RESET, false);
            return;
        }

        public function setItemAt(arg1:Object, arg2:int):void
        {
            this._dataDescriptor.setItemAt(this._data, arg1, arg2);
            this.dispatchEventWith(starling.events.Event.CHANGE);
            this.dispatchEventWith(feathers.events.CollectionEventType.REPLACE_ITEM, false, arg2);
            return;
        }

        public function addItem(arg1:Object):void
        {
            this.addItemAt(arg1, this.length);
            return;
        }

        public function push(arg1:Object):void
        {
            this.addItemAt(arg1, this.length);
            return;
        }

        public function addAll(arg1:feathers.data.ListCollection):void
        {
            var loc3:*=null;
            var loc1:*=arg1.length;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                loc3 = arg1.getItemAt(loc2);
                this.addItem(loc3);
                ++loc2;
            }
            return;
        }

        public function addAllAt(arg1:feathers.data.ListCollection, arg2:int):void
        {
            var loc4:*=null;
            var loc1:*=arg1.length;
            var loc2:*=arg2;
            var loc3:*=0;
            while (loc3 < loc1) 
            {
                loc4 = arg1.getItemAt(loc3);
                this.addItemAt(loc4, loc2);
                ++loc2;
                ++loc3;
            }
            return;
        }

        public function pop():Object
        {
            return this.removeItemAt((this.length - 1));
        }

        public function unshift(arg1:Object):void
        {
            this.addItemAt(arg1, 0);
            return;
        }

        public function shift():Object
        {
            return this.removeItemAt(0);
        }

        public function contains(arg1:Object):Boolean
        {
            return this.getItemIndex(arg1) >= 0;
        }

        public function dispose(arg1:Function):void
        {
            var loc3:*=null;
            var loc1:*=this.length;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                loc3 = this.getItemAt(loc2);
                arg1(loc3);
                ++loc2;
            }
            return;
        }

        protected var _data:Object;

        protected var _dataDescriptor:feathers.data.IListCollectionDataDescriptor;
    }
}


