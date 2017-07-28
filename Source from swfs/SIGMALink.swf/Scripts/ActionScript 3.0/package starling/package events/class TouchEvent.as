//class TouchEvent
package starling.events 
{
    import __AS3__.vec.*;
    import starling.core.*;
    import starling.display.*;
    
    use namespace starling_internal;
    
    public class TouchEvent extends starling.events.Event
    {
        public function TouchEvent(arg1:String, arg2:__AS3__.vec.Vector.<starling.events.Touch>=null, arg3:Boolean=false, arg4:Boolean=false, arg5:Boolean=true)
        {
            super(arg1, arg5, arg2);
            this._shiftKey = arg3;
            this._ctrlKey = arg4;
            this._visitedObjects = new Vector.<starling.events.EventDispatcher>(0);
            this.updateTimestamp(arg2);
            return;
        }

        function resetTo(arg1:String, arg2:__AS3__.vec.Vector.<starling.events.Touch>=null, arg3:Boolean=false, arg4:Boolean=false, arg5:Boolean=true):starling.events.TouchEvent
        {
            super.starling_internal::reset(arg1, arg5, arg2);
            this._shiftKey = arg3;
            this._ctrlKey = arg4;
            this._visitedObjects.length = 0;
            this.updateTimestamp(arg2);
            return this;
        }

        internal function updateTimestamp(arg1:__AS3__.vec.Vector.<starling.events.Touch>):void
        {
            this._timestamp = -1;
            var loc1:*=arg1 ? arg1.length : 0;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                if (arg1[loc2].timestamp > this._timestamp) 
                {
                    this._timestamp = arg1[loc2].timestamp;
                }
                ++loc2;
            }
            return;
        }

        public function getTouches(arg1:starling.display.DisplayObject, arg2:String=null, arg3:__AS3__.vec.Vector.<starling.events.Touch>=null):__AS3__.vec.Vector.<starling.events.Touch>
        {
            var loc4:*=null;
            var loc5:*=false;
            var loc6:*=false;
            if (arg3 == null) 
            {
                arg3 = new Vector.<starling.events.Touch>(0);
            }
            var loc1:*=data as Vector.<starling.events.Touch>;
            var loc2:*=loc1.length;
            var loc3:*=0;
            while (loc3 < loc2) 
            {
                loc4 = loc1[loc3];
                loc5 = loc4.isTouching(arg1);
                loc6 = arg2 == null || arg2 == loc4.phase;
                if (loc5 && loc6) 
                {
                    arg3[arg3.length] = loc4;
                }
                ++loc3;
            }
            return arg3;
        }

        public function getTouch(arg1:starling.display.DisplayObject, arg2:String=null, arg3:int=-1):starling.events.Touch
        {
            var loc2:*=null;
            var loc3:*=0;
            this.getTouches(arg1, arg2, sTouches);
            var loc1:*=sTouches.length;
            if (loc1 > 0) 
            {
                loc2 = null;
                if (arg3 < 0) 
                {
                    loc2 = sTouches[0];
                }
                else 
                {
                    loc3 = 0;
                    while (loc3 < loc1) 
                    {
                        if (sTouches[loc3].id == arg3) 
                        {
                            loc2 = sTouches[loc3];
                        }
                        ++loc3;
                    }
                }
                sTouches.length = 0;
                return loc2;
            }
            return null;
        }

        public function interactsWith(arg1:starling.display.DisplayObject):Boolean
        {
            var loc1:*=false;
            this.getTouches(arg1, null, sTouches);
            var loc2:*=(sTouches.length - 1);
            while (loc2 >= 0) 
            {
                if (sTouches[loc2].phase != starling.events.TouchPhase.ENDED) 
                {
                    loc1 = true;
                    break;
                }
                --loc2;
            }
            sTouches.length = 0;
            return loc1;
        }

        function dispatch(arg1:__AS3__.vec.Vector.<starling.events.EventDispatcher>):void
        {
            var loc1:*=0;
            var loc2:*=null;
            var loc3:*=0;
            var loc4:*=null;
            var loc5:*=false;
            if (arg1 && arg1.length) 
            {
                loc1 = bubbles ? arg1.length : 1;
                loc2 = target;
                setTarget(arg1[0] as starling.events.EventDispatcher);
                loc3 = 0;
                while (loc3 < loc1) 
                {
                    loc4 = arg1[loc3] as starling.events.EventDispatcher;
                    if (this._visitedObjects.indexOf(loc4) == -1) 
                    {
                        loc5 = loc4.invokeEvent(this);
                        this._visitedObjects[this._visitedObjects.length] = loc4;
                        if (loc5) 
                        {
                            break;
                        }
                    }
                    ++loc3;
                }
                setTarget(loc2);
            }
            return;
        }

        public function get timestamp():Number
        {
            return this._timestamp;
        }

        public function get touches():__AS3__.vec.Vector.<starling.events.Touch>
        {
            return (data as Vector.<starling.events.Touch>).concat();
        }

        public function get shiftKey():Boolean
        {
            return this._shiftKey;
        }

        public function get ctrlKey():Boolean
        {
            return this._ctrlKey;
        }

        
        {
            sTouches = new Vector.<starling.events.Touch>(0);
        }

        public static const TOUCH:String="touch";

        internal var _shiftKey:Boolean;

        internal var _ctrlKey:Boolean;

        internal var _timestamp:Number;

        internal var _visitedObjects:__AS3__.vec.Vector.<starling.events.EventDispatcher>;

        internal static var sTouches:__AS3__.vec.Vector.<starling.events.Touch>;
    }
}


