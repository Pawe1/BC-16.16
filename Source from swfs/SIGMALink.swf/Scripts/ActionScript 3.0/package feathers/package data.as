//package data
//  class ArrayChildrenHierarchicalCollectionDataDescriptor
package feathers.data 
{
    import __AS3__.vec.*;
    
    public class ArrayChildrenHierarchicalCollectionDataDescriptor extends Object implements feathers.data.IHierarchicalCollectionDataDescriptor
    {
        public function ArrayChildrenHierarchicalCollectionDataDescriptor()
        {
            super();
            return;
        }

        public function getLength(arg1:Object, ... rest):int
        {
            var loc4:*=0;
            var loc1:*=arg1 as Array;
            var loc2:*=rest.length;
            var loc3:*=0;
            while (loc3 < loc2) 
            {
                loc4 = rest[loc3] as int;
                loc1 = loc1[loc4][this.childrenField] as Array;
                ++loc3;
            }
            return loc1.length;
        }

        public function getItemAt(arg1:Object, arg2:int, ... rest):Object
        {
            rest.insertAt(0, arg2);
            var loc1:*=arg1 as Array;
            var loc2:*=(rest.length - 1);
            var loc3:*=0;
            while (loc3 < loc2) 
            {
                arg2 = rest[loc3] as int;
                loc1 = loc1[arg2][this.childrenField] as Array;
                ++loc3;
            }
            var loc4:*=rest[loc2] as int;
            return loc1[loc4];
        }

        public function setItemAt(arg1:Object, arg2:Object, arg3:int, ... rest):void
        {
            rest.insertAt(0, arg3);
            var loc1:*=arg1 as Array;
            var loc2:*=(rest.length - 1);
            var loc3:*=0;
            while (loc3 < loc2) 
            {
                arg3 = rest[loc3] as int;
                loc1 = loc1[arg3][this.childrenField] as Array;
                ++loc3;
            }
            var loc4:*=rest[loc2];
            loc1[loc4] = arg2;
            return;
        }

        public function addItemAt(arg1:Object, arg2:Object, arg3:int, ... rest):void
        {
            rest.insertAt(0, arg3);
            var loc1:*=arg1 as Array;
            var loc2:*=(rest.length - 1);
            var loc3:*=0;
            while (loc3 < loc2) 
            {
                arg3 = rest[loc3] as int;
                loc1 = loc1[arg3][this.childrenField] as Array;
                ++loc3;
            }
            var loc4:*=rest[loc2];
            loc1.insertAt(loc4, arg2);
            return;
        }

        public function removeItemAt(arg1:Object, arg2:int, ... rest):Object
        {
            rest.insertAt(0, arg2);
            var loc1:*=arg1 as Array;
            var loc2:*=(rest.length - 1);
            var loc3:*=0;
            while (loc3 < loc2) 
            {
                arg2 = rest[loc3] as int;
                loc1 = loc1[arg2][this.childrenField] as Array;
                ++loc3;
            }
            var loc4:*=rest[loc2];
            return loc1.removeAt(loc4);
        }

        public function removeAll(arg1:Object):void
        {
            var loc1:*=arg1 as Array;
            loc1.length = 0;
            return;
        }

        public function getItemLocation(arg1:Object, arg2:Object, arg3:__AS3__.vec.Vector.<int>=null, ... rest):__AS3__.vec.Vector.<int>
        {
            var loc5:*=0;
            if (arg3) 
            {
                arg3.length = 0;
            }
            else 
            {
                arg3 = new Vector.<int>(0);
            }
            var loc1:*=arg1 as Array;
            var loc2:*=rest.length;
            var loc3:*=0;
            while (loc3 < loc2) 
            {
                loc5 = rest[loc3] as int;
                arg3[loc3] = loc5;
                loc1 = loc1[loc5][this.childrenField] as Array;
                ++loc3;
            }
            var loc4:*=this.findItemInBranch(loc1, arg2, arg3);
            if (!loc4) 
            {
                arg3.length = 0;
            }
            return arg3;
        }

        public function isBranch(arg1:Object):Boolean
        {
            return arg1.hasOwnProperty(this.childrenField) && arg1[this.childrenField] is Array;
        }

        protected function findItemInBranch(arg1:Array, arg2:Object, arg3:__AS3__.vec.Vector.<int>):Boolean
        {
            var loc4:*=null;
            var loc5:*=false;
            var loc1:*=arg1.indexOf(arg2);
            if (loc1 >= 0) 
            {
                arg3.push(loc1);
                return true;
            }
            var loc2:*=arg1.length;
            var loc3:*=0;
            while (loc3 < loc2) 
            {
                loc4 = arg1[loc3];
                if (this.isBranch(loc4)) 
                {
                    arg3.push(loc3);
                    loc5 = this.findItemInBranch(loc4[this.childrenField] as Array, arg2, arg3);
                    if (loc5) 
                    {
                        return true;
                    }
                    arg3.pop();
                }
                ++loc3;
            }
            return false;
        }

        public var childrenField:String="children";
    }
}


//  class ArrayListCollectionDataDescriptor
package feathers.data 
{
    import flash.errors.*;
    
    public class ArrayListCollectionDataDescriptor extends Object implements feathers.data.IListCollectionDataDescriptor
    {
        public function ArrayListCollectionDataDescriptor()
        {
            super();
            return;
        }

        public function getLength(arg1:Object):int
        {
            this.checkForCorrectDataType(arg1);
            return (arg1 as Array).length;
        }

        public function getItemAt(arg1:Object, arg2:int):Object
        {
            this.checkForCorrectDataType(arg1);
            return (arg1 as Array)[arg2];
        }

        public function setItemAt(arg1:Object, arg2:Object, arg3:int):void
        {
            this.checkForCorrectDataType(arg1);
            (arg1 as Array)[arg3] = arg2;
            return;
        }

        public function addItemAt(arg1:Object, arg2:Object, arg3:int):void
        {
            this.checkForCorrectDataType(arg1);
            (arg1 as Array).insertAt(arg3, arg2);
            return;
        }

        public function removeItemAt(arg1:Object, arg2:int):Object
        {
            this.checkForCorrectDataType(arg1);
            return (arg1 as Array).removeAt(arg2);
        }

        public function removeAll(arg1:Object):void
        {
            this.checkForCorrectDataType(arg1);
            (arg1 as Array).length = 0;
            return;
        }

        public function getItemIndex(arg1:Object, arg2:Object):int
        {
            this.checkForCorrectDataType(arg1);
            return (arg1 as Array).indexOf(arg2);
        }

        protected function checkForCorrectDataType(arg1:Object):void
        {
            if (!(arg1 is Array)) 
            {
                throw new flash.errors.IllegalOperationError("Expected Array. Received " + Object(arg1).constructor + " instead.");
            }
            return;
        }
    }
}


//  class HierarchicalCollection
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


//  class IHierarchicalCollectionDataDescriptor
package feathers.data 
{
    import __AS3__.vec.*;
    
    public interface IHierarchicalCollectionDataDescriptor
    {
        function isBranch(arg1:Object):Boolean;

        function getLength(arg1:Object, ... rest):int;

        function getItemAt(arg1:Object, arg2:int, ... rest):Object;

        function setItemAt(arg1:Object, arg2:Object, arg3:int, ... rest):void;

        function addItemAt(arg1:Object, arg2:Object, arg3:int, ... rest):void;

        function removeItemAt(arg1:Object, arg2:int, ... rest):Object;

        function removeAll(arg1:Object):void;

        function getItemLocation(arg1:Object, arg2:Object, arg3:__AS3__.vec.Vector.<int>=null, ... rest):__AS3__.vec.Vector.<int>;
    }
}


//  class IListCollectionDataDescriptor
package feathers.data 
{
    public interface IListCollectionDataDescriptor
    {
        function getLength(arg1:Object):int;

        function getItemAt(arg1:Object, arg2:int):Object;

        function setItemAt(arg1:Object, arg2:Object, arg3:int):void;

        function addItemAt(arg1:Object, arg2:Object, arg3:int):void;

        function removeItemAt(arg1:Object, arg2:int):Object;

        function getItemIndex(arg1:Object, arg2:Object):int;

        function removeAll(arg1:Object):void;
    }
}


//  class ListCollection
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


//  class VectorIntListCollectionDataDescriptor
package feathers.data 
{
    import __AS3__.vec.*;
    import flash.errors.*;
    
    public class VectorIntListCollectionDataDescriptor extends Object implements feathers.data.IListCollectionDataDescriptor
    {
        public function VectorIntListCollectionDataDescriptor()
        {
            super();
            return;
        }

        public function getLength(arg1:Object):int
        {
            this.checkForCorrectDataType(arg1);
            return (arg1 as Vector.<int>).length;
        }

        public function getItemAt(arg1:Object, arg2:int):Object
        {
            this.checkForCorrectDataType(arg1);
            return (arg1 as Vector.<int>)[arg2];
        }

        public function setItemAt(arg1:Object, arg2:Object, arg3:int):void
        {
            this.checkForCorrectDataType(arg1);
            (arg1 as Vector.<int>)[arg3] = arg2 as int;
            return;
        }

        public function addItemAt(arg1:Object, arg2:Object, arg3:int):void
        {
            this.checkForCorrectDataType(arg1);
            (arg1 as Vector.<int>).insertAt(arg3, arg2 as int);
            return;
        }

        public function removeItemAt(arg1:Object, arg2:int):Object
        {
            this.checkForCorrectDataType(arg1);
            return (arg1 as Vector.<int>).removeAt(arg2);
        }

        public function removeAll(arg1:Object):void
        {
            this.checkForCorrectDataType(arg1);
            (arg1 as Vector.<int>).length = 0;
            return;
        }

        public function getItemIndex(arg1:Object, arg2:Object):int
        {
            this.checkForCorrectDataType(arg1);
            return (arg1 as Vector.<int>).indexOf(arg2 as int);
        }

        protected function checkForCorrectDataType(arg1:Object):void
        {
            if (!(arg1 is Vector.<int>)) 
            {
                throw new flash.errors.IllegalOperationError("Expected Vector.<int>. Received " + Object(arg1).constructor + " instead.");
            }
            return;
        }
    }
}


//  class VectorListCollectionDataDescriptor
package feathers.data 
{
    import __AS3__.vec.*;
    import flash.errors.*;
    
    public class VectorListCollectionDataDescriptor extends Object implements feathers.data.IListCollectionDataDescriptor
    {
        public function VectorListCollectionDataDescriptor()
        {
            super();
            return;
        }

        public function getLength(arg1:Object):int
        {
            this.checkForCorrectDataType(arg1);
            return (arg1 as Vector.<>).length;
        }

        public function getItemAt(arg1:Object, arg2:int):Object
        {
            this.checkForCorrectDataType(arg1);
            return (arg1 as Vector.<>)[arg2];
        }

        public function setItemAt(arg1:Object, arg2:Object, arg3:int):void
        {
            this.checkForCorrectDataType(arg1);
            (arg1 as Vector.<>)[arg3] = arg2;
            return;
        }

        public function addItemAt(arg1:Object, arg2:Object, arg3:int):void
        {
            this.checkForCorrectDataType(arg1);
            (arg1 as Vector.<>).insertAt(arg3, arg2);
            return;
        }

        public function removeItemAt(arg1:Object, arg2:int):Object
        {
            this.checkForCorrectDataType(arg1);
            return (arg1 as Vector.<>).removeAt(arg2);
        }

        public function removeAll(arg1:Object):void
        {
            this.checkForCorrectDataType(arg1);
            (arg1 as Vector.<>).length = 0;
            return;
        }

        public function getItemIndex(arg1:Object, arg2:Object):int
        {
            this.checkForCorrectDataType(arg1);
            return (arg1 as Vector.<>).indexOf(arg2);
        }

        protected function checkForCorrectDataType(arg1:Object):void
        {
            if (!(arg1 is Vector.<>)) 
            {
                throw new flash.errors.IllegalOperationError("Expected Vector. Received " + Object(arg1).constructor + " instead.");
            }
            return;
        }
    }
}


//  class VectorNumberListCollectionDataDescriptor
package feathers.data 
{
    import __AS3__.vec.*;
    import flash.errors.*;
    
    public class VectorNumberListCollectionDataDescriptor extends Object implements feathers.data.IListCollectionDataDescriptor
    {
        public function VectorNumberListCollectionDataDescriptor()
        {
            super();
            return;
        }

        public function getLength(arg1:Object):int
        {
            this.checkForCorrectDataType(arg1);
            return (arg1 as Vector.<Number>).length;
        }

        public function getItemAt(arg1:Object, arg2:int):Object
        {
            this.checkForCorrectDataType(arg1);
            return (arg1 as Vector.<Number>)[arg2];
        }

        public function setItemAt(arg1:Object, arg2:Object, arg3:int):void
        {
            this.checkForCorrectDataType(arg1);
            (arg1 as Vector.<Number>)[arg3] = arg2 as Number;
            return;
        }

        public function addItemAt(arg1:Object, arg2:Object, arg3:int):void
        {
            this.checkForCorrectDataType(arg1);
            (arg1 as Vector.<Number>).insertAt(arg3, arg2 as Number);
            return;
        }

        public function removeItemAt(arg1:Object, arg2:int):Object
        {
            this.checkForCorrectDataType(arg1);
            return (arg1 as Vector.<Number>).removeAt(arg2);
        }

        public function removeAll(arg1:Object):void
        {
            this.checkForCorrectDataType(arg1);
            (arg1 as Vector.<Number>).length = 0;
            return;
        }

        public function getItemIndex(arg1:Object, arg2:Object):int
        {
            this.checkForCorrectDataType(arg1);
            return (arg1 as Vector.<Number>).indexOf(arg2 as Number);
        }

        protected function checkForCorrectDataType(arg1:Object):void
        {
            if (!(arg1 is Vector.<Number>)) 
            {
                throw new flash.errors.IllegalOperationError("Expected Vector.<Number>. Received " + Object(arg1).constructor + " instead.");
            }
            return;
        }
    }
}


//  class VectorUintListCollectionDataDescriptor
package feathers.data 
{
    import __AS3__.vec.*;
    import flash.errors.*;
    
    public class VectorUintListCollectionDataDescriptor extends Object implements feathers.data.IListCollectionDataDescriptor
    {
        public function VectorUintListCollectionDataDescriptor()
        {
            super();
            return;
        }

        public function getLength(arg1:Object):int
        {
            this.checkForCorrectDataType(arg1);
            return (arg1 as Vector.<uint>).length;
        }

        public function getItemAt(arg1:Object, arg2:int):Object
        {
            this.checkForCorrectDataType(arg1);
            return (arg1 as Vector.<uint>)[arg2];
        }

        public function setItemAt(arg1:Object, arg2:Object, arg3:int):void
        {
            this.checkForCorrectDataType(arg1);
            (arg1 as Vector.<uint>)[arg3] = arg2 as uint;
            return;
        }

        public function addItemAt(arg1:Object, arg2:Object, arg3:int):void
        {
            this.checkForCorrectDataType(arg1);
            (arg1 as Vector.<uint>).insertAt(arg3, arg2 as uint);
            return;
        }

        public function removeItemAt(arg1:Object, arg2:int):Object
        {
            this.checkForCorrectDataType(arg1);
            return (arg1 as Vector.<uint>).removeAt(arg2);
        }

        public function removeAll(arg1:Object):void
        {
            this.checkForCorrectDataType(arg1);
            (arg1 as Vector.<uint>).length = 0;
            return;
        }

        public function getItemIndex(arg1:Object, arg2:Object):int
        {
            this.checkForCorrectDataType(arg1);
            return (arg1 as Vector.<uint>).indexOf(arg2 as uint);
        }

        protected function checkForCorrectDataType(arg1:Object):void
        {
            if (!(arg1 is Vector.<uint>)) 
            {
                throw new flash.errors.IllegalOperationError("Expected Vector.<uint>. Received " + Object(arg1).constructor + " instead.");
            }
            return;
        }
    }
}


//  class XMLListListCollectionDataDescriptor
package feathers.data 
{
    import flash.errors.*;
    
    public class XMLListListCollectionDataDescriptor extends Object implements feathers.data.IListCollectionDataDescriptor
    {
        public function XMLListListCollectionDataDescriptor()
        {
            super();
            return;
        }

        public function getLength(arg1:Object):int
        {
            this.checkForCorrectDataType(arg1);
            return (arg1 as XMLList).length();
        }

        public function getItemAt(arg1:Object, arg2:int):Object
        {
            this.checkForCorrectDataType(arg1);
            return arg1[arg2];
        }

        public function setItemAt(arg1:Object, arg2:Object, arg3:int):void
        {
            this.checkForCorrectDataType(arg1);
            arg1[arg3] = XML(arg2);
            return;
        }

        public function addItemAt(arg1:Object, arg2:Object, arg3:int):void
        {
            this.checkForCorrectDataType(arg1);
            var loc1:*=(arg1 as XMLList).copy();
            arg1[arg3] = arg2;
            var loc2:*=loc1.length();
            var loc3:*=arg3;
            while (loc3 < loc2) 
            {
                arg1[loc3 + 1] = loc1[loc3];
                ++loc3;
            }
            return;
        }

        public function removeItemAt(arg1:Object, arg2:int):Object
        {
            this.checkForCorrectDataType(arg1);
            var loc1:*=arg1[arg2];
            delete arg1[arg2];
            return loc1;
        }

        public function removeAll(arg1:Object):void
        {
            this.checkForCorrectDataType(arg1);
            var loc1:*=arg1 as XMLList;
            var loc2:*=loc1.length();
            var loc3:*=0;
            while (loc3 < loc2) 
            {
                delete arg1[0];
                ++loc3;
            }
            return;
        }

        public function getItemIndex(arg1:Object, arg2:Object):int
        {
            var loc4:*=null;
            this.checkForCorrectDataType(arg1);
            var loc1:*=arg1 as XMLList;
            var loc2:*=loc1.length();
            var loc3:*=0;
            while (loc3 < loc2) 
            {
                loc4 = loc1[loc3];
                if (loc4 == arg2) 
                {
                    return loc3;
                }
                ++loc3;
            }
            return -1;
        }

        protected function checkForCorrectDataType(arg1:Object):void
        {
            if (!(arg1 is XMLList)) 
            {
                throw new flash.errors.IllegalOperationError("Expected XMLList. Received " + Object(arg1).constructor + " instead.");
            }
            return;
        }
    }
}


