//class VectorUintListCollectionDataDescriptor
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


