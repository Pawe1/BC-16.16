//class FunctionReturnWatcher
package feathers.binding 
{
    import feathers.binding.utils.*;
    import flash.events.*;
    import mx.core.*;
    import starling.events.*;
    
    use namespace mx_internal;
    
    public class FunctionReturnWatcher extends feathers.binding.Watcher
    {
        public function FunctionReturnWatcher(arg1:String, arg2:Object, arg3:Function, arg4:Object, arg5:Array, arg6:Function=null)
        {
            super(arg5);
            this.functionName = arg1;
            this.document = arg2;
            this.parameterFunction = arg3;
            this.events = arg4;
            this.functionGetter = arg6;
            return;
        }

        public override function updateParent(arg1:Object):void
        {
            if (arg1 is feathers.binding.Watcher) 
            {
                if (arg1 == this.parentWatcher) 
                {
                    this.setupParentObj(this.parentWatcher.value);
                }
            }
            else 
            {
                this.setupParentObj(arg1);
            }
            this.updateFunctionReturn();
            return;
        }

        protected override function shallowClone():feathers.binding.Watcher
        {
            var loc1:*=new feathers.binding.FunctionReturnWatcher(this.functionName, this.document, this.parameterFunction, this.events, listeners, this.functionGetter);
            return loc1;
        }

        public function updateFunctionReturn():void
        {
            var loc1:*;
            wrapUpdate(function ():void
            {
                if (functionGetter == null) 
                {
                    value = parentObj[functionName].apply(parentObj, parameterFunction.apply(document));
                }
                else 
                {
                    value = functionGetter(functionName).apply(parentObj, parameterFunction.apply(document));
                }
                updateChildren();
                return;
            })
            return;
        }

        internal function setupParentObj(arg1:Object):void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            if (this.parentObj != null) 
            {
                if (this.events != null) 
                {
                    var loc4:*=0;
                    var loc5:*=this.events;
                    for (loc1 in loc5) 
                    {
                        if (loc1 == "__NoChangeEvent__") 
                        {
                            continue;
                        }
                        if (this.parentObj is starling.events.EventDispatcher) 
                        {
                            loc2 = starling.events.EventDispatcher(this.parentObj);
                            loc2.removeEventListener(loc1, this.eventHandler);
                            continue;
                        }
                        if (!(this.parentObj is flash.events.IEventDispatcher)) 
                        {
                            continue;
                        }
                        loc3 = flash.events.IEventDispatcher(this.parentObj);
                        loc3.removeEventListener(loc1, this.eventHandler);
                    }
                }
            }
            this.parentObj = arg1;
            if (this.parentObj != null) 
            {
                if (this.events != null) 
                {
                    loc4 = 0;
                    loc5 = this.events;
                    for (loc1 in loc5) 
                    {
                        if (loc1 == "__NoChangeEvent__") 
                        {
                            continue;
                        }
                        if (this.parentObj is starling.events.EventDispatcher) 
                        {
                            loc2 = starling.events.EventDispatcher(this.parentObj);
                            loc2.addEventListener(loc1, this.eventHandler);
                            continue;
                        }
                        if (!(this.parentObj is flash.events.IEventDispatcher)) 
                        {
                            continue;
                        }
                        loc3 = flash.events.IEventDispatcher(this.parentObj);
                        loc3.addEventListener(loc1, this.eventHandler, false, feathers.binding.utils.BINDING_EVENT_PRIORITY, true);
                    }
                }
            }
            return;
        }

        public function eventHandler(arg1:Object):void
        {
            var loc1:*=null;
            this.updateFunctionReturn();
            if (this.events != null) 
            {
                loc1 = arg1.type as String;
                notifyListeners(this.events[loc1]);
            }
            return;
        }

        internal var functionName:String;

        internal var document:Object;

        internal var parameterFunction:Function;

        internal var events:Object;

        internal var parentObj:Object;

        public var parentWatcher:feathers.binding.Watcher;

        internal var functionGetter:Function;
    }
}


