//class EventDispatcher
package starling.events 
{
    import __AS3__.vec.*;
    import flash.utils.*;
    import starling.core.*;
    import starling.display.*;
    
    use namespace starling_internal;
    
    public class EventDispatcher extends Object
    {
        public function EventDispatcher()
        {
            super();
            return;
        }

        public function addEventListener(arg1:String, arg2:Function):void
        {
            if (this._eventListeners == null) 
            {
                this._eventListeners = new flash.utils.Dictionary();
            }
            var loc1:*=this._eventListeners[arg1] as Vector.<Function>;
            if (loc1 != null) 
            {
                if (loc1.indexOf(arg2) == -1) 
                {
                    loc1[loc1.length] = arg2;
                }
            }
            else 
            {
                new Vector.<Function>(1)[0] = arg2;
                this._eventListeners[arg1] = new Vector.<Function>(1);
            }
            return;
        }

        public function removeEventListener(arg1:String, arg2:Function):void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=null;
            var loc5:*=0;
            if (this._eventListeners) 
            {
                loc1 = this._eventListeners[arg1] as Vector.<Function>;
                loc2 = loc1 ? loc1.length : 0;
                if (loc2 > 0) 
                {
                    loc3 = loc1.indexOf(arg2);
                    if (loc3 != -1) 
                    {
                        loc4 = loc1.slice(0, loc3);
                        loc5 = loc3 + 1;
                        while (loc5 < loc2) 
                        {
                            loc4[(loc5 - 1)] = loc1[loc5];
                            ++loc5;
                        }
                        this._eventListeners[arg1] = loc4;
                    }
                }
            }
            return;
        }

        public function removeEventListeners(arg1:String=null):void
        {
            if (arg1 && this._eventListeners) 
            {
                delete this._eventListeners[arg1];
            }
            else 
            {
                this._eventListeners = null;
            }
            return;
        }

        public function dispatchEvent(arg1:starling.events.Event):void
        {
            var loc1:*=arg1.bubbles;
            if (!loc1 && (this._eventListeners == null || !(arg1.type in this._eventListeners))) 
            {
                return;
            }
            var loc2:*=arg1.target;
            arg1.setTarget(this);
            if (loc1 && this is starling.display.DisplayObject) 
            {
                this.bubbleEvent(arg1);
            }
            else 
            {
                this.invokeEvent(arg1);
            }
            if (loc2) 
            {
                arg1.setTarget(loc2);
            }
            return;
        }

        function invokeEvent(arg1:starling.events.Event):Boolean
        {
            var loc3:*=0;
            var loc4:*=null;
            var loc5:*=0;
            var loc1:*=this._eventListeners ? this._eventListeners[arg1.type] as Vector.<Function> : null;
            var loc2:*=loc1 != null ? loc1.length : 0;
            if (loc2) 
            {
                arg1.setCurrentTarget(this);
                loc3 = 0;
                while (loc3 < loc2) 
                {
                    loc4 = loc1[loc3] as Function;
                    loc5 = loc4.length;
                    if (loc5 != 0) 
                    {
                        if (loc5 != 1) 
                        {
                            loc4(arg1, arg1.data);
                        }
                        else 
                        {
                            loc4(arg1);
                        }
                    }
                    else 
                    {
                        loc4();
                    }
                    if (arg1.stopsImmediatePropagation) 
                    {
                        return true;
                    }
                    ++loc3;
                }
                return arg1.stopsPropagation;
            }
            return false;
        }

        function bubbleEvent(arg1:starling.events.Event):void
        {
            var loc1:*=null;
            var loc5:*=false;
            var loc2:*=this as starling.display.DisplayObject;
            var loc3:*=1;
            if (sBubbleChains.length > 0) 
            {
                loc1 = sBubbleChains.pop();
                loc1[0] = loc2;
            }
            else 
            {
                new Vector.<starling.events.EventDispatcher>(1)[0] = loc2;
                loc1 = new Vector.<starling.events.EventDispatcher>(1);
            }
            for (;;) 
            {
                var loc6:*;
                loc2 = loc6 = loc2.parent;
                if (loc6 == null) 
                {
                    break;
                }
                loc1[int(loc3++)] = loc2;
            }
            var loc4:*=0;
            while (loc4 < loc3) 
            {
                loc5 = loc1[loc4].invokeEvent(arg1);
                if (loc5) 
                {
                    break;
                }
                ++loc4;
            }
            loc1.length = 0;
            sBubbleChains[sBubbleChains.length] = loc1;
            return;
        }

        public function dispatchEventWith(arg1:String, arg2:Boolean=false, arg3:Object=null):void
        {
            var loc1:*=null;
            if (arg2 || this.hasEventListener(arg1)) 
            {
                loc1 = starling.events.Event.starling_internal::fromPool(arg1, arg2, arg3);
                this.dispatchEvent(loc1);
                starling.events.Event.starling_internal::toPool(loc1);
            }
            return;
        }

        public function hasEventListener(arg1:String, arg2:Function=null):Boolean
        {
            var loc1:*=this._eventListeners ? this._eventListeners[arg1] : null;
            if (loc1 == null) 
            {
                return false;
            }
            if (arg2 != null) 
            {
                return !(loc1.indexOf(arg2) == -1);
            }
            return !(loc1.length == 0);
        }

        
        {
            sBubbleChains = [];
        }

        internal var _eventListeners:flash.utils.Dictionary;

        internal static var sBubbleChains:Array;
    }
}


