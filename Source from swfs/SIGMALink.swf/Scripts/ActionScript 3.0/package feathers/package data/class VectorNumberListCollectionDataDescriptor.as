//class VectorNumberListCollectionDataDescriptor
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


