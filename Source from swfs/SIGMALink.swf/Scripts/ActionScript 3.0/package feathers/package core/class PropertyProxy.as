//class PropertyProxy
package feathers.core 
{
    import __AS3__.vec.*;
    import flash.utils.*;
    
    use namespace flash_proxy;
    
    public final dynamic class PropertyProxy extends flash.utils.Proxy
    {
        public function PropertyProxy(arg1:Function=null)
        {
            this._onChangeCallbacks = new Vector.<Function>(0);
            this._names = [];
            this._storage = {};
            super();
            if (arg1 != null) 
            {
                this._onChangeCallbacks[this._onChangeCallbacks.length] = arg1;
            }
            return;
        }

        flash_proxy override function hasProperty(arg1:*):Boolean
        {
            return this._storage.hasOwnProperty(arg1);
        }

        flash_proxy override function getProperty(arg1:*):*
        {
            var loc1:*=null;
            var loc2:*=null;
            if (this.flash_proxy::isAttribute(arg1)) 
            {
                loc1 = arg1 is QName ? QName(arg1).localName : arg1.toString();
                if (!this._storage.hasOwnProperty(loc1)) 
                {
                    loc2 = new feathers.core.PropertyProxy(this.subProxy_onChange);
                    loc2._subProxyName = loc1;
                    this._storage[loc1] = loc2;
                    this._names[this._names.length] = loc1;
                    this.fireOnChangeCallback(loc1);
                }
                return this._storage[loc1];
            }
            return this._storage[arg1];
        }

        flash_proxy override function setProperty(arg1:*, arg2:*):void
        {
            var loc1:*=arg1 is QName ? QName(arg1).localName : arg1.toString();
            this._storage[loc1] = arg2;
            if (this._names.indexOf(loc1) < 0) 
            {
                this._names[this._names.length] = loc1;
            }
            this.fireOnChangeCallback(loc1);
            return;
        }

        flash_proxy override function deleteProperty(arg1:*):Boolean
        {
            var loc1:*=arg1 is QName ? QName(arg1).localName : arg1.toString();
            var loc2:*=this._names.indexOf(loc1);
            if (loc2 >= 0) 
            {
                this._names.removeAt(loc2);
            }
            var loc3:*=delete this._storage[loc1];
            if (loc3) 
            {
                this.fireOnChangeCallback(loc1);
            }
            return loc3;
        }

        flash_proxy override function nextNameIndex(arg1:int):int
        {
            if (arg1 < this._names.length) 
            {
                return arg1 + 1;
            }
            return 0;
        }

        flash_proxy override function nextName(arg1:int):String
        {
            return this._names[(arg1 - 1)];
        }

        flash_proxy override function nextValue(arg1:int):*
        {
            var loc1:*=this._names[(arg1 - 1)];
            return this._storage[loc1];
        }

        public function addOnChangeCallback(arg1:Function):void
        {
            this._onChangeCallbacks[this._onChangeCallbacks.length] = arg1;
            return;
        }

        public function removeOnChangeCallback(arg1:Function):void
        {
            var loc1:*=this._onChangeCallbacks.indexOf(arg1);
            if (loc1 < 0) 
            {
                return;
            }
            if (loc1 == 0) 
            {
                this._onChangeCallbacks.shift();
                return;
            }
            var loc2:*=(this._onChangeCallbacks.length - 1);
            if (loc1 == loc2) 
            {
                this._onChangeCallbacks.pop();
                return;
            }
            this._onChangeCallbacks.removeAt(loc1);
            return;
        }

        public function toString():String
        {
            var loc2:*=null;
            var loc1:*="[object PropertyProxy";
            var loc3:*=0;
            var loc4:*=this;
            for (loc2 in loc4) 
            {
                loc1 = loc1 + (" " + loc2);
            }
            return loc1 + "]";
        }

        internal function fireOnChangeCallback(arg1:String):void
        {
            var loc3:*=null;
            var loc1:*=this._onChangeCallbacks.length;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                loc3 = this._onChangeCallbacks[loc2] as Function;
                loc3(this, arg1);
                ++loc2;
            }
            return;
        }

        internal function subProxy_onChange(arg1:feathers.core.PropertyProxy, arg2:String):void
        {
            this.fireOnChangeCallback(arg1._subProxyName);
            return;
        }

        public static function fromObject(arg1:Object, arg2:Function=null):feathers.core.PropertyProxy
        {
            var loc2:*=null;
            var loc1:*=new PropertyProxy(arg2);
            var loc3:*=0;
            var loc4:*=arg1;
            for (loc2 in loc4) 
            {
                loc1[loc2] = arg1[loc2];
            }
            return loc1;
        }

        internal var _subProxyName:String;

        internal var _onChangeCallbacks:__AS3__.vec.Vector.<Function>;

        internal var _names:Array;

        internal var _storage:Object;
    }
}


