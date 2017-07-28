//class ScreenNavigatorItem
package feathers.controls 
{
    import feathers.controls.supportClasses.*;
    import mx.core.*;
    import starling.display.*;
    
    public class ScreenNavigatorItem extends Object implements feathers.controls.supportClasses.IScreenNavigatorItem, mx.core.IMXMLObject
    {
        public function ScreenNavigatorItem(arg1:Object=null, arg2:Object=null, arg3:Object=null)
        {
            super();
            this._screen = arg1;
            this._events = arg2 ? arg2 : {};
            this._properties = arg3 ? arg3 : {};
            return;
        }

        public function get screen():Object
        {
            return this._screen;
        }

        public function set screen(arg1:Object):void
        {
            this._screen = arg1;
            return;
        }

        public function get events():Object
        {
            return this._events;
        }

        public function set events(arg1:Object):void
        {
            if (!arg1) 
            {
                arg1 = {};
            }
            this._events = arg1;
            return;
        }

        public function get properties():Object
        {
            return this._properties;
        }

        public function set properties(arg1:Object):void
        {
            if (!arg1) 
            {
                arg1 = {};
            }
            this._properties = arg1;
            return;
        }

        public function get canDispose():Boolean
        {
            return !(this._screen is starling.display.DisplayObject);
        }

        public function get mxmlID():String
        {
            return this._mxmlID;
        }

        public function initialized(arg1:Object, arg2:String):void
        {
            if (!arg2) 
            {
                throw new Error("ScreenNavigatorItem must have an \"id\" in MXML.");
            }
            this._mxmlID = arg2;
            return;
        }

        public function setFunctionForEvent(arg1:String, arg2:Function):void
        {
            this._events[arg1] = arg2;
            return;
        }

        public function setScreenIDForEvent(arg1:String, arg2:String):void
        {
            this._events[arg1] = arg2;
            return;
        }

        public function clearEvent(arg1:String):void
        {
            delete this._events[arg1];
            return;
        }

        public function getScreen():starling.display.DisplayObject
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            if (this._screen is Class) 
            {
                loc2 = Class(this._screen);
                loc1 = new loc2();
            }
            else if (this._screen is Function) 
            {
                loc1 = starling.display.DisplayObject((this._screen as Function)());
            }
            else 
            {
                loc1 = starling.display.DisplayObject(this._screen);
            }
            if (!(loc1 is starling.display.DisplayObject)) 
            {
                throw new ArgumentError("ScreenNavigatorItem \"getScreen()\" must return a Starling display object.");
            }
            if (this._properties) 
            {
                var loc4:*=0;
                var loc5:*=this._properties;
                for (loc3 in loc5) 
                {
                    loc1[loc3] = this._properties[loc3];
                }
            }
            return loc1;
        }

        protected var _screen:Object;

        protected var _events:Object;

        protected var _properties:Object;

        internal var _mxmlID:String;
    }
}


