//class XMLListListCollectionDataDescriptor
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


