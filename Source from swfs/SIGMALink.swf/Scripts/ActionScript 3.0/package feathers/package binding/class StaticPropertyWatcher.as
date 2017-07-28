//class StaticPropertyWatcher
package feathers.binding 
{
    import feathers.binding.utils.*;
    import feathers.events.*;
    import flash.events.*;
    import mx.events.*;
    import starling.events.*;
    
    public class StaticPropertyWatcher extends feathers.binding.Watcher
    {
        public function StaticPropertyWatcher(arg1:String, arg2:Object, arg3:Array, arg4:Function=null)
        {
            super(arg3);
            this._propertyName = arg1;
            this.events = arg2;
            this.propertyGetter = arg4;
            return;
        }

        public function get propertyName():String
        {
            return this._propertyName;
        }

        public override function updateParent(arg1:Object):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            this.parentObj = Class(arg1);
            var loc1:*=this.parentObj["staticEventDispatcher"];
            if (loc1 != null) 
            {
                var loc5:*=0;
                var loc6:*=this.events;
                for (loc2 in loc6) 
                {
                    if (loc2 == "__NoChangeEvent__") 
                    {
                        continue;
                    }
                    if (loc1 is starling.events.EventDispatcher) 
                    {
                        loc3 = starling.events.EventDispatcher(this.parentObj["staticEventDispatcher"]);
                        loc3.addEventListener(loc2, this.eventHandler);
                        continue;
                    }
                    if (!(loc1 is flash.events.IEventDispatcher)) 
                    {
                        continue;
                    }
                    loc4 = flash.events.IEventDispatcher(this.parentObj["staticEventDispatcher"]);
                    loc4.addEventListener(loc2, this.eventHandler, false, feathers.binding.utils.BINDING_EVENT_PRIORITY, true);
                }
            }
            wrapUpdate(this.updateProperty);
            return;
        }

        protected override function shallowClone():feathers.binding.Watcher
        {
            var loc1:*=new feathers.binding.StaticPropertyWatcher(this._propertyName, this.events, listeners, this.propertyGetter);
            return loc1;
        }

        internal function traceInfo():String
        {
            return "StaticPropertyWatcher(" + this.parentObj + "." + this._propertyName + "): events = [" + this.eventNamesToString() + "]";
        }

        internal function eventNamesToString():String
        {
            var loc2:*=null;
            var loc1:*=" ";
            var loc3:*=0;
            var loc4:*=this.events;
            for (loc2 in loc4) 
            {
                loc1 = loc1 + (loc2 + " ");
            }
            return loc1;
        }

        internal function updateProperty():void
        {
            if (this.parentObj) 
            {
                if (this.propertyGetter == null) 
                {
                    value = this.parentObj[this._propertyName];
                }
                else 
                {
                    value = this.propertyGetter.apply(this.parentObj, [this._propertyName]);
                }
            }
            else 
            {
                value = null;
            }
            updateChildren();
            return;
        }

        public function eventHandler(arg1:Object):void
        {
            var loc2:*=null;
            var loc3:*=null;
            if (arg1 is starling.events.Event && arg1.data is feathers.events.PropertyChangeEventData) 
            {
                loc2 = starling.events.Event(arg1);
                loc3 = feathers.events.PropertyChangeEventData(loc2.data).property;
                if (loc3 != this._propertyName) 
                {
                    return;
                }
            }
            else if (arg1 is mx.events.PropertyChangeEvent) 
            {
                loc3 = mx.events.PropertyChangeEvent(arg1).property;
                if (loc3 != this._propertyName) 
                {
                    return;
                }
            }
            wrapUpdate(this.updateProperty);
            var loc1:*=arg1.type as String;
            notifyListeners(this.events[loc1]);
            return;
        }

        internal var parentObj:Class;

        protected var events:Object;

        internal var propertyGetter:Function;

        internal var _propertyName:String;
    }
}


