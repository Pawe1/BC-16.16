//class VectorListCollectionDataDescriptor
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


