//class Watcher
package feathers.binding 
{
    public class Watcher extends Object
    {
        public function Watcher(arg1:Array=null)
        {
            super();
            this.listeners = arg1;
            return;
        }

        public function updateParent(arg1:Object):void
        {
            return;
        }

        public function addChild(arg1:feathers.binding.Watcher):void
        {
            if (this.children) 
            {
                this.children.push(arg1);
            }
            else 
            {
                this.children = [arg1];
            }
            arg1.updateParent(this);
            return;
        }

        public function removeChildren(arg1:int):void
        {
            this.children.splice(arg1);
            return;
        }

        public function updateChildren():void
        {
            var loc1:*=0;
            var loc2:*=0;
            if (this.children) 
            {
                loc1 = this.children.length;
                loc2 = 0;
                while (loc2 < loc1) 
                {
                    this.children[loc2].updateParent(this);
                    ++loc2;
                }
            }
            return;
        }

        internal function valueChanged(arg1:Object):Boolean
        {
            if (arg1 == null && this.value == null) 
            {
                return false;
            }
            var loc1:*=typeof this.value;
            if (loc1 == "string") 
            {
                if (arg1 == null && this.value == "") 
                {
                    return false;
                }
                return !(arg1 == this.value);
            }
            if (loc1 == "number") 
            {
                if (arg1 == null && this.value == 0) 
                {
                    return false;
                }
                return !(arg1 == this.value);
            }
            if (loc1 == "boolean") 
            {
                if (arg1 == null && this.value == false) 
                {
                    return false;
                }
                return !(arg1 == this.value);
            }
            return true;
        }

        protected function wrapUpdate(arg1:Function):void
        {
            var wrappedFunction:Function;

            var loc1:*;
            wrappedFunction = arg1;
            try 
            {
                wrappedFunction.apply(this);
            }
            catch (error:Error)
            {
                if (error is RangeError) 
                {
                    value = null;
                }
                else if (!(error.errorID == 1006) && !(error.errorID == 1009) && !(error.errorID == 1010) && !(error.errorID == 1055) && !(error.errorID == 1069) && !(error.errorID == 1507)) 
                {
                    throw error;
                }
            }
            return;
        }

        protected function deepClone(arg1:int):feathers.binding.Watcher
        {
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=null;
            var loc1:*=this.shallowClone();
            loc1.cloneIndex = arg1;
            if (this.listeners) 
            {
                loc1.listeners = this.listeners.concat();
            }
            if (this.children) 
            {
                loc2 = this.children.length;
                loc3 = 0;
                while (loc3 < loc2) 
                {
                    loc4 = this.children[loc3].deepClone(arg1);
                    loc1.addChild(loc4);
                    ++loc3;
                }
            }
            return loc1;
        }

        protected function shallowClone():feathers.binding.Watcher
        {
            return new feathers.binding.Watcher();
        }

        public function notifyListeners(arg1:Boolean):void
        {
            var loc1:*=0;
            var loc2:*=0;
            if (this.listeners) 
            {
                loc1 = this.listeners.length;
                loc2 = 0;
                while (loc2 < loc1) 
                {
                    this.listeners[loc2].watcherFired(arg1, this.cloneIndex);
                    ++loc2;
                }
            }
            return;
        }

        protected var listeners:Array;

        protected var children:Array;

        public var value:Object;

        protected var cloneIndex:int;
    }
}


