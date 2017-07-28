//class ArrayChildrenHierarchicalCollectionDataDescriptor
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


