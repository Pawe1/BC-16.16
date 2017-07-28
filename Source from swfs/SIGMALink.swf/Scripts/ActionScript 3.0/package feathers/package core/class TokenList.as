//class TokenList
package feathers.core 
{
    import __AS3__.vec.*;
    import starling.events.*;
    
    public class TokenList extends starling.events.EventDispatcher
    {
        public function TokenList()
        {
            this.names = new Vector.<String>(0);
            super();
            return;
        }

        public function get value():String
        {
            if (this._joinedNames === null) 
            {
                this._joinedNames = this.names.join(" ");
            }
            return this._joinedNames;
        }

        public function set value(arg1:String):void
        {
            if (this.value == arg1) 
            {
                return;
            }
            this._joinedNames = arg1;
            this.names.length = 0;
            this.names = Vector.<String>(arg1.split(" "));
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function get length():int
        {
            return this.names.length;
        }

        public function item(arg1:int):String
        {
            if (arg1 < 0 || arg1 >= this.names.length) 
            {
                return null;
            }
            return this.names[arg1];
        }

        public function add(arg1:String):void
        {
            var loc1:*=this.names.indexOf(arg1);
            if (loc1 >= 0) 
            {
                return;
            }
            if (this._joinedNames !== null) 
            {
                this._joinedNames = this._joinedNames + (" " + arg1);
            }
            this.names[this.names.length] = arg1;
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function remove(arg1:String):void
        {
            var loc1:*=this.names.indexOf(arg1);
            this.removeAt(loc1);
            return;
        }

        public function toggle(arg1:String):void
        {
            var loc1:*=this.names.indexOf(arg1);
            if (loc1 < 0) 
            {
                if (this._joinedNames !== null) 
                {
                    this._joinedNames = this._joinedNames + (" " + arg1);
                }
                this.names[this.names.length] = arg1;
                this.dispatchEventWith(starling.events.Event.CHANGE);
            }
            else 
            {
                this.removeAt(loc1);
            }
            return;
        }

        public function contains(arg1:String):Boolean
        {
            return this.names.indexOf(arg1) >= 0;
        }

        protected function removeAt(arg1:int):void
        {
            if (arg1 < 0) 
            {
                return;
            }
            this._joinedNames = null;
            this.names.removeAt(arg1);
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        protected var _joinedNames:String=null;

        protected var names:__AS3__.vec.Vector.<String>;
    }
}


