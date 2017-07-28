//class PropertyWatcher
package feathers.binding 
{
    import feathers.binding.utils.*;
    import feathers.events.*;
    import flash.events.*;
    import flash.utils.*;
    import mx.events.*;
    import starling.events.*;
    
    public class PropertyWatcher extends feathers.binding.Watcher
    {
        public function PropertyWatcher(arg1:String, arg2:Object, arg3:Array, arg4:Function=null)
        {
            super(arg3);
            this._propertyName = arg1;
            this.events = arg2;
            this.propertyGetter = arg4;
            this.useRTTI = !arg2;
            return;
        }

        public function get propertyName():String
        {
            return this._propertyName;
        }

        public override function updateParent(arg1:Object):void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            if (this.parentObj) 
            {
                if (this.parentObj is starling.events.EventDispatcher) 
                {
                    loc1 = starling.events.EventDispatcher(this.parentObj);
                    var loc5:*=0;
                    var loc6:*=this.events;
                    for (loc2 in loc6) 
                    {
                        loc1.removeEventListener(loc2, this.eventHandler);
                    }
                }
                else if (this.parentObj is flash.events.IEventDispatcher) 
                {
                    loc3 = flash.events.IEventDispatcher(this.parentObj);
                    loc5 = 0;
                    loc6 = this.events;
                    for (loc2 in loc6) 
                    {
                        loc3.removeEventListener(loc2, this.eventHandler);
                    }
                }
            }
            if (arg1 is feathers.binding.Watcher) 
            {
                this.parentObj = arg1.value;
            }
            else 
            {
                this.parentObj = arg1;
            }
            if (this.parentObj) 
            {
                if (this.useRTTI) 
                {
                    this.events = {};
                    if (this.parentObj is starling.events.EventDispatcher || this.parentObj is flash.events.IEventDispatcher) 
                    {
                        loc4 = feathers.binding.utils.DescribeTypeCache.describeType(this.parentObj).bindabilityInfo;
                        this.events = loc4.getChangeEvents(this._propertyName);
                        if (this.objectIsEmpty(this.events)) 
                        {
                            trace("warning: unable to bind to property \'" + this._propertyName + "\' on class \'" + flash.utils.getQualifiedClassName(this.parentObj) + "\'");
                        }
                        else if (this.parentObj is starling.events.EventDispatcher) 
                        {
                            this.addParentStarlingEventListeners();
                        }
                        else if (this.parentObj is flash.events.IEventDispatcher) 
                        {
                            this.addParentNativeEventListeners();
                        }
                    }
                    else 
                    {
                        trace("warning: unable to bind to property \'" + this._propertyName + "\' on class \'" + flash.utils.getQualifiedClassName(this.parentObj) + "\' (class is not an IEventDispatcher)");
                    }
                }
                else if (this.parentObj is starling.events.EventDispatcher) 
                {
                    this.addParentStarlingEventListeners();
                }
                else if (this.parentObj is flash.events.IEventDispatcher) 
                {
                    this.addParentNativeEventListeners();
                }
            }
            wrapUpdate(this.updateProperty);
            return;
        }

        protected override function shallowClone():feathers.binding.Watcher
        {
            var loc1:*=new feathers.binding.PropertyWatcher(this._propertyName, this.events, listeners, this.propertyGetter);
            return loc1;
        }

        internal function addParentStarlingEventListeners():void
        {
            var loc2:*=null;
            var loc1:*=starling.events.EventDispatcher(this.parentObj);
            var loc3:*=0;
            var loc4:*=this.events;
            for (loc2 in loc4) 
            {
                if (loc2 == "__NoChangeEvent__") 
                {
                    continue;
                }
                loc1.addEventListener(loc2, this.eventHandler);
            }
            return;
        }

        internal function addParentNativeEventListeners():void
        {
            var loc2:*=null;
            var loc1:*=flash.events.IEventDispatcher(this.parentObj);
            var loc3:*=0;
            var loc4:*=this.events;
            for (loc2 in loc4) 
            {
                if (loc2 == "__NoChangeEvent__") 
                {
                    continue;
                }
                loc1.addEventListener(loc2, this.eventHandler, false, feathers.binding.utils.BINDING_EVENT_PRIORITY, true);
            }
            return;
        }

        internal function traceInfo():String
        {
            return "Watcher(" + flash.utils.getQualifiedClassName(this.parentObj) + "." + this._propertyName + "): events = [" + this.eventNamesToString() + (this.useRTTI ? "] (RTTI)" : "]");
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

        internal function objectIsEmpty(arg1:Object):Boolean
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=arg1;
            for (loc1 in loc3) 
            {
                return false;
            }
            return true;
        }

        internal function updateProperty():void
        {
            if (this.parentObj) 
            {
                if (this._propertyName != "this") 
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
                    value = this.parentObj;
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

        internal var parentObj:Object;

        protected var events:Object;

        protected var propertyGetter:Function;

        internal var _propertyName:String;

        internal var useRTTI:Boolean;
    }
}


