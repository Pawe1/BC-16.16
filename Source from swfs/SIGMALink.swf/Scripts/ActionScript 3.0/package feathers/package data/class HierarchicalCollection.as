//class HierarchicalCollection
package feathers.data 
{
    import __AS3__.vec.*;
    import feathers.events.*;
    import starling.events.*;
    
    public class HierarchicalCollection extends starling.events.EventDispatcher
    {
        public function HierarchicalCollection(arg1:Object=null)
        {
            this._dataDescriptor = new feathers.data.ArrayChildrenHierarchicalCollectionDataDescriptor();
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
            this.dispatchEventWith(feathers.events.CollectionEventType.RESET);
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function get dataDescriptor():feathers.data.IHierarchicalCollectionDataDescriptor
        {
            return this._dataDescriptor;
        }

        public function set dataDescriptor(arg1:feathers.data.IHierarchicalCollectionDataDescriptor):void
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

        public function isBranch(arg1:Object):Boolean
        {
            return this._dataDescriptor.isBranch(arg1);
        }

        public function getLength(... rest):int
        {
            rest.insertAt(0, this._data);
            return this._dataDescriptor.getLength.apply(null, rest);
        }

        public function updateItemAt(arg1:int, ... rest):void
        {
            rest.insertAt(0, arg1);
            this.dispatchEventWith(feathers.events.CollectionEventType.UPDATE_ITEM, false, rest);
            return;
        }

        public function updateAll():void
        {
            this.dispatchEventWith(feathers.events.CollectionEventType.UPDATE_ALL);
            return;
        }

        public function getItemAt(arg1:int, ... rest):Object
        {
            rest.insertAt(0, arg1);
            rest.insertAt(0, this._data);
            return this._dataDescriptor.getItemAt.apply(null, rest);
        }

        public function getItemLocation(arg1:Object, arg2:__AS3__.vec.Vector.<int>=null):__AS3__.vec.Vector.<int>
        {
            return this._dataDescriptor.getItemLocation(this._data, arg1, arg2);
        }

        public function addItemAt(arg1:Object, arg2:int, ... rest):void
        {
            rest.insertAt(0, arg2);
            rest.insertAt(0, arg1);
            rest.insertAt(0, this._data);
            this._dataDescriptor.addItemAt.apply(null, rest);
            this.dispatchEventWith(starling.events.Event.CHANGE);
            rest.shift();
            rest.shift();
            this.dispatchEventWith(feathers.events.CollectionEventType.ADD_ITEM, false, rest);
            return;
        }

        public function removeItemAt(arg1:int, ... rest):Object
        {
            rest.insertAt(0, arg1);
            rest.insertAt(0, this._data);
            var loc1:*=this._dataDescriptor.removeItemAt.apply(null, rest);
            this.dispatchEventWith(starling.events.Event.CHANGE);
            rest.shift();
            this.dispatchEventWith(feathers.events.CollectionEventType.REMOVE_ITEM, false, rest);
            return loc1;
        }

        public function removeItem(arg1:Object):void
        {
            var loc2:*=null;
            var loc3:*=0;
            var loc4:*=0;
            var loc1:*=this.getItemLocation(arg1);
            if (loc1) 
            {
                loc2 = [];
                loc3 = loc1.length;
                loc4 = 0;
                while (loc4 < loc3) 
                {
                    loc2.push(loc1[loc4]);
                    ++loc4;
                }
                this.removeItemAt.apply(this, loc2);
            }
            return;
        }

        public function removeAll():void
        {
            if (this.getLength() == 0) 
            {
                return;
            }
            this._dataDescriptor.removeAll(this._data);
            this.dispatchEventWith(starling.events.Event.CHANGE);
            this.dispatchEventWith(feathers.events.CollectionEventType.RESET, false);
            return;
        }

        public function setItemAt(arg1:Object, arg2:int, ... rest):void
        {
            rest.insertAt(0, arg2);
            rest.insertAt(0, arg1);
            rest.insertAt(0, this._data);
            this._dataDescriptor.setItemAt.apply(null, rest);
            rest.shift();
            rest.shift();
            this.dispatchEventWith(feathers.events.CollectionEventType.REPLACE_ITEM, false, rest);
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function dispose(arg1:Function, arg2:Function):void
        {
            var loc4:*=null;
            var loc1:*=this.getLength();
            var loc2:*=[];
            var loc3:*=0;
            while (loc3 < loc1) 
            {
                loc4 = this.getItemAt(loc3);
                loc2[0] = loc3;
                this.disposeGroupInternal(loc4, loc2, arg1, arg2);
                loc2.length = 0;
                ++loc3;
            }
            return;
        }

        protected function disposeGroupInternal(arg1:Object, arg2:Array, arg3:Function, arg4:Function):void
        {
            var loc3:*=null;
            if (arg3 != null) 
            {
                arg3(arg1);
            }
            var loc1:*=this.getLength.apply(this, arg2);
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                arg2[arg2.length] = loc2;
                loc3 = this.getItemAt.apply(this, arg2);
                if (this.isBranch(loc3)) 
                {
                    this.disposeGroupInternal(loc3, arg2, arg3, arg4);
                }
                else if (arg4 != null) 
                {
                    arg4(loc3);
                }
                var loc4:*;
                var loc5:*=((loc4 = arg2).length - 1);
                loc4.length = loc5;
                ++loc2;
            }
            return;
        }

        protected var _data:Object;

        protected var _dataDescriptor:feathers.data.IHierarchicalCollectionDataDescriptor;
    }
}


