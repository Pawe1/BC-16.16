//class VectorIntListCollectionDataDescriptor
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


