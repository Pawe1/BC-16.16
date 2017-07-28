//package events
//  class EnterFrameEvent
package starling.events 
{
    public class EnterFrameEvent extends starling.events.Event
    {
        public function EnterFrameEvent(arg1:String, arg2:Number, arg3:Boolean=false)
        {
            super(arg1, arg3, arg2);
            return;
        }

        public function get passedTime():Number
        {
            return data as Number;
        }

        public static const ENTER_FRAME:String="enterFrame";
    }
}


//  class Event
package starling.events 
{
    import __AS3__.vec.*;
    import flash.utils.*;
    import starling.core.*;
    import starling.utils.*;
    
    use namespace starling_internal;
    
    public class Event extends Object
    {
        public function Event(arg1:String, arg2:Boolean=false, arg3:Object=null)
        {
            super();
            this._type = arg1;
            this._bubbles = arg2;
            this._data = arg3;
            return;
        }

        function setData(arg1:Object):void
        {
            this._data = arg1;
            return;
        }

        function get stopsPropagation():Boolean
        {
            return this._stopsPropagation;
        }

        function get stopsImmediatePropagation():Boolean
        {
            return this._stopsImmediatePropagation;
        }

        starling_internal function reset(arg1:String, arg2:Boolean=false, arg3:Object=null):starling.events.Event
        {
            this._type = arg1;
            this._bubbles = arg2;
            this._data = arg3;
            var loc1:*;
            this._currentTarget = loc1 = null;
            this._target = loc1;
            this._stopsImmediatePropagation = loc1 = false;
            this._stopsPropagation = loc1;
            return this;
        }

        starling_internal static function toPool(arg1:starling.events.Event):void
        {
            var loc1:*;
            arg1._currentTarget = loc1 = null;
            arg1._target = loc1 = loc1;
            arg1._data = loc1;
            sEventPool[sEventPool.length] = arg1;
            return;
        }

        public function get target():starling.events.EventDispatcher
        {
            return this._target;
        }

        starling_internal static function fromPool(arg1:String, arg2:Boolean=false, arg3:Object=null):starling.events.Event
        {
            if (sEventPool.length) 
            {
                return sEventPool.pop().reset(arg1, arg2, arg3);
            }
            return new Event(arg1, arg2, arg3);
        }

        public function stopPropagation():void
        {
            this._stopsPropagation = true;
            return;
        }

        public function stopImmediatePropagation():void
        {
            var loc1:*;
            this._stopsImmediatePropagation = loc1 = true;
            this._stopsPropagation = loc1;
            return;
        }

        public function toString():String
        {
            return starling.utils.StringUtil.format("[{0} type=\"{1}\" bubbles={2}]", flash.utils.getQualifiedClassName(this).split("::").pop(), this._type, this._bubbles);
        }

        public function get bubbles():Boolean
        {
            return this._bubbles;
        }

        
        {
            sEventPool = new Vector.<>(0);
        }

        public function get currentTarget():starling.events.EventDispatcher
        {
            return this._currentTarget;
        }

        public function get type():String
        {
            return this._type;
        }

        public function get data():Object
        {
            return this._data;
        }

        function setTarget(arg1:starling.events.EventDispatcher):void
        {
            this._target = arg1;
            return;
        }

        function setCurrentTarget(arg1:starling.events.EventDispatcher):void
        {
            this._currentTarget = arg1;
            return;
        }

        public static const FATAL_ERROR:String="fatalError";

        public static const READY:String="ready";

        public static const UPDATE:String="update";

        public static const SELECT:String="select";

        public static const ADDED:String="added";

        public static const ADDED_TO_STAGE:String="addedToStage";

        public static const ENTER_FRAME:String="enterFrame";

        public static const REMOVED:String="removed";

        public static const REMOVED_FROM_STAGE:String="removedFromStage";

        public static const TRIGGERED:String="triggered";

        public static const RESIZE:String="resize";

        public static const COMPLETE:String="complete";

        public static const CONTEXT3D_CREATE:String="context3DCreate";

        public static const RENDER:String="render";

        public static const ROOT_CREATED:String="rootCreated";

        public static const REMOVE_FROM_JUGGLER:String="removeFromJuggler";

        public static const TEXTURES_RESTORED:String="texturesRestored";

        public static const IO_ERROR:String="ioError";

        public static const SECURITY_ERROR:String="securityError";

        public static const PARSE_ERROR:String="parseError";

        public static const CHANGE:String="change";

        public static const CANCEL:String="cancel";

        public static const SCROLL:String="scroll";

        public static const OPEN:String="open";

        public static const CLOSE:String="close";

        internal var _target:starling.events.EventDispatcher;

        internal var _currentTarget:starling.events.EventDispatcher;

        internal var _type:String;

        internal var _bubbles:Boolean;

        internal static var sEventPool:__AS3__.vec.Vector.<starling.events.Event>;

        internal var _data:Object;

        internal var _stopsPropagation:Boolean;

        internal var _stopsImmediatePropagation:Boolean;
    }
}


//  class EventDispatcher
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


//  class KeyboardEvent
package starling.events 
{
    public class KeyboardEvent extends starling.events.Event
    {
        public function KeyboardEvent(arg1:String, arg2:uint=0, arg3:uint=0, arg4:uint=0, arg5:Boolean=false, arg6:Boolean=false, arg7:Boolean=false)
        {
            super(arg1, false, arg3);
            this._charCode = arg2;
            this._keyCode = arg3;
            this._keyLocation = arg4;
            this._ctrlKey = arg5;
            this._altKey = arg6;
            this._shiftKey = arg7;
            return;
        }

        public function preventDefault():void
        {
            this._isDefaultPrevented = true;
            return;
        }

        public function isDefaultPrevented():Boolean
        {
            return this._isDefaultPrevented;
        }

        public function get charCode():uint
        {
            return this._charCode;
        }

        public function get keyCode():uint
        {
            return this._keyCode;
        }

        public function get keyLocation():uint
        {
            return this._keyLocation;
        }

        public function get altKey():Boolean
        {
            return this._altKey;
        }

        public function get ctrlKey():Boolean
        {
            return this._ctrlKey;
        }

        public function get shiftKey():Boolean
        {
            return this._shiftKey;
        }

        public static const KEY_UP:String="keyUp";

        public static const KEY_DOWN:String="keyDown";

        internal var _charCode:uint;

        internal var _keyCode:uint;

        internal var _keyLocation:uint;

        internal var _altKey:Boolean;

        internal var _ctrlKey:Boolean;

        internal var _shiftKey:Boolean;

        internal var _isDefaultPrevented:Boolean;
    }
}


//  class ResizeEvent
package starling.events 
{
    import flash.geom.*;
    
    public class ResizeEvent extends starling.events.Event
    {
        public function ResizeEvent(arg1:String, arg2:int, arg3:int, arg4:Boolean=false)
        {
            super(arg1, arg4, new flash.geom.Point(arg2, arg3));
            return;
        }

        public function get width():int
        {
            return (data as flash.geom.Point).x;
        }

        public function get height():int
        {
            return (data as flash.geom.Point).y;
        }

        public static const RESIZE:String="resize";
    }
}


//  class Touch
package starling.events 
{
    import __AS3__.vec.*;
    import flash.geom.*;
    import starling.display.*;
    import starling.utils.*;
    
    public class Touch extends Object
    {
        public function Touch(arg1:int)
        {
            super();
            this._id = arg1;
            this._tapCount = 0;
            this._phase = starling.events.TouchPhase.HOVER;
            var loc1:*;
            this._height = loc1 = 1;
            this._width = loc1 = loc1;
            this._pressure = loc1;
            this._bubbleChain = new Vector.<starling.events.EventDispatcher>(0);
            return;
        }

        public function set target(arg1:starling.display.DisplayObject):void
        {
            if (this._target != arg1) 
            {
                this._target = arg1;
                this.updateBubbleChain();
            }
            return;
        }

        public function get timestamp():Number
        {
            return this._timestamp;
        }

        public function set timestamp(arg1:Number):void
        {
            this._timestamp = arg1;
            return;
        }

        public function get pressure():Number
        {
            return this._pressure;
        }

        public function set pressure(arg1:Number):void
        {
            this._pressure = arg1;
            return;
        }

        public function get previousGlobalY():Number
        {
            return this._previousGlobalY;
        }

        public function get width():Number
        {
            return this._width;
        }

        public function set width(arg1:Number):void
        {
            this._width = arg1;
            return;
        }

        public function get height():Number
        {
            return this._height;
        }

        public function get cancelled():Boolean
        {
            return this._cancelled;
        }

        public function set cancelled(arg1:Boolean):void
        {
            this._cancelled = arg1;
            return;
        }

        function dispatchEvent(arg1:starling.events.TouchEvent):void
        {
            if (this._target) 
            {
                arg1.dispatch(this._bubbleChain);
            }
            return;
        }

        function get bubbleChain():__AS3__.vec.Vector.<starling.events.EventDispatcher>
        {
            return this._bubbleChain.concat();
        }

        
        {
            sHelperPoint = new flash.geom.Point();
        }

        public function getLocation(arg1:starling.display.DisplayObject, arg2:flash.geom.Point=null):flash.geom.Point
        {
            sHelperPoint.setTo(this._globalX, this._globalY);
            return arg1.globalToLocal(sHelperPoint, arg2);
        }

        public function getPreviousLocation(arg1:starling.display.DisplayObject, arg2:flash.geom.Point=null):flash.geom.Point
        {
            sHelperPoint.setTo(this._previousGlobalX, this._previousGlobalY);
            return arg1.globalToLocal(sHelperPoint, arg2);
        }

        public function getMovement(arg1:starling.display.DisplayObject, arg2:flash.geom.Point=null):flash.geom.Point
        {
            if (arg2 == null) 
            {
                arg2 = new flash.geom.Point();
            }
            this.getLocation(arg1, arg2);
            var loc1:*=arg2.x;
            var loc2:*=arg2.y;
            this.getPreviousLocation(arg1, arg2);
            arg2.setTo(loc1 - arg2.x, loc2 - arg2.y);
            return arg2;
        }

        public function isTouching(arg1:starling.display.DisplayObject):Boolean
        {
            return !(this._bubbleChain.indexOf(arg1) == -1);
        }

        public function toString():String
        {
            return starling.utils.StringUtil.format("[Touch {0}: globalX={1}, globalY={2}, phase={3}]", this._id, this._globalX, this._globalY, this._phase);
        }

        public function clone():starling.events.Touch
        {
            var loc1:*=new starling.events.Touch(this._id);
            loc1._globalX = this._globalX;
            loc1._globalY = this._globalY;
            loc1._previousGlobalX = this._previousGlobalX;
            loc1._previousGlobalY = this._previousGlobalY;
            loc1._phase = this._phase;
            loc1._tapCount = this._tapCount;
            loc1._timestamp = this._timestamp;
            loc1._pressure = this._pressure;
            loc1._width = this._width;
            loc1._height = this._height;
            loc1._cancelled = this._cancelled;
            loc1.target = this._target;
            return loc1;
        }

        internal function updateBubbleChain():void
        {
            var loc1:*=0;
            var loc2:*=null;
            if (this._target) 
            {
                loc1 = 1;
                loc2 = this._target;
                this._bubbleChain.length = 1;
                this._bubbleChain[0] = loc2;
                for (;;) 
                {
                    var loc3:*;
                    loc2 = loc3 = loc2.parent;
                    if (loc3 == null) 
                    {
                        break;
                    }
                    this._bubbleChain[int(loc1++)] = loc2;
                }
            }
            else 
            {
                this._bubbleChain.length = 0;
            }
            return;
        }

        public function get id():int
        {
            return this._id;
        }

        public function get previousGlobalX():Number
        {
            return this._previousGlobalX;
        }

        public function set height(arg1:Number):void
        {
            this._height = arg1;
            return;
        }

        public function get globalX():Number
        {
            return this._globalX;
        }

        public function set globalX(arg1:Number):void
        {
            this._previousGlobalX = this._globalX == this._globalX ? this._globalX : arg1;
            this._globalX = arg1;
            return;
        }

        public function get globalY():Number
        {
            return this._globalY;
        }

        public function set globalY(arg1:Number):void
        {
            this._previousGlobalY = this._globalY == this._globalY ? this._globalY : arg1;
            this._globalY = arg1;
            return;
        }

        public function get tapCount():int
        {
            return this._tapCount;
        }

        public function set tapCount(arg1:int):void
        {
            this._tapCount = arg1;
            return;
        }

        public function get phase():String
        {
            return this._phase;
        }

        public function set phase(arg1:String):void
        {
            this._phase = arg1;
            return;
        }

        public function get target():starling.display.DisplayObject
        {
            return this._target;
        }

        internal var _id:int;

        internal var _globalX:Number;

        internal var _globalY:Number;

        internal var _previousGlobalX:Number;

        internal var _previousGlobalY:Number;

        internal var _phase:String;

        internal var _target:starling.display.DisplayObject;

        internal var _timestamp:Number;

        internal var _pressure:Number;

        internal var _width:Number;

        internal var _height:Number;

        internal var _cancelled:Boolean;

        internal var _bubbleChain:__AS3__.vec.Vector.<starling.events.EventDispatcher>;

        internal static var sHelperPoint:flash.geom.Point;

        internal var _tapCount:int;
    }
}


//  class TouchEvent
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


//  class TouchMarker
package starling.events 
{
    import flash.display.*;
    import flash.geom.*;
    import starling.core.*;
    import starling.display.*;
    import starling.textures.*;
    
    internal class TouchMarker extends starling.display.Sprite
    {
        public function TouchMarker()
        {
            var loc2:*=null;
            super();
            this._center = new flash.geom.Point();
            this._texture = this.createTexture();
            var loc1:*=0;
            while (loc1 < 2) 
            {
                loc2 = new starling.display.Image(this._texture);
                loc2.pivotX = this._texture.width / 2;
                loc2.pivotY = this._texture.height / 2;
                loc2.touchable = false;
                addChild(loc2);
                ++loc1;
            }
            return;
        }

        public override function dispose():void
        {
            this._texture.dispose();
            super.dispose();
            return;
        }

        public function moveMarker(arg1:Number, arg2:Number, arg3:Boolean=false):void
        {
            if (arg3) 
            {
                this._center.x = this._center.x + (arg1 - this.realMarker.x);
                this._center.y = this._center.y + (arg2 - this.realMarker.y);
            }
            this.realMarker.x = arg1;
            this.realMarker.y = arg2;
            this.mockMarker.x = 2 * this._center.x - arg1;
            this.mockMarker.y = 2 * this._center.y - arg2;
            return;
        }

        public function moveCenter(arg1:Number, arg2:Number):void
        {
            this._center.x = arg1;
            this._center.y = arg2;
            this.moveMarker(this.realX, this.realY);
            return;
        }

        internal function createTexture():starling.textures.Texture
        {
            var loc1:*=starling.core.Starling.contentScaleFactor;
            var loc2:*=12 * loc1;
            var loc3:*=32 * loc1;
            var loc4:*=32 * loc1;
            var loc5:*=1.5 * loc1;
            var loc6:*=new flash.display.Shape();
            loc6.graphics.lineStyle(loc5, 0, 0.3);
            loc6.graphics.drawCircle(loc3 / 2, loc4 / 2, loc2 + loc5);
            loc6.graphics.beginFill(16777215, 0.4);
            loc6.graphics.lineStyle(loc5, 16777215);
            loc6.graphics.drawCircle(loc3 / 2, loc4 / 2, loc2);
            loc6.graphics.endFill();
            var loc7:*=new flash.display.BitmapData(loc3, loc4, true, 0);
            loc7.draw(loc6);
            return starling.textures.Texture.fromBitmapData(loc7, false, false, loc1);
        }

        internal function get realMarker():starling.display.Image
        {
            return getChildAt(0) as starling.display.Image;
        }

        internal function get mockMarker():starling.display.Image
        {
            return getChildAt(1) as starling.display.Image;
        }

        public function get realX():Number
        {
            return this.realMarker.x;
        }

        public function get realY():Number
        {
            return this.realMarker.y;
        }

        public function get mockX():Number
        {
            return this.mockMarker.x;
        }

        public function get mockY():Number
        {
            return this.mockMarker.y;
        }

        internal var _center:flash.geom.Point;

        internal var _texture:starling.textures.Texture;
    }
}


//  class TouchPhase
package starling.events 
{
    import starling.errors.*;
    
    public final class TouchPhase extends Object
    {
        public function TouchPhase()
        {
            super();
            throw new starling.errors.AbstractClassError();
        }

        public static const HOVER:String="hover";

        public static const BEGAN:String="began";

        public static const MOVED:String="moved";

        public static const STATIONARY:String="stationary";

        public static const ENDED:String="ended";
    }
}


//  class TouchProcessor
package starling.events 
{
    import __AS3__.vec.*;
    import flash.geom.*;
    import flash.utils.*;
    import starling.core.*;
    import starling.display.*;
    
    public class TouchProcessor extends Object
    {
        public function TouchProcessor(arg1:starling.display.Stage)
        {
            super();
            var loc1:*;
            this._stage = loc1 = arg1;
            this._root = loc1;
            this._elapsedTime = 0;
            this._currentTouches = new Vector.<starling.events.Touch>(0);
            this._queue = new Vector.<Array>(0);
            this._lastTaps = new Vector.<starling.events.Touch>(0);
            this._touchEvent = new starling.events.TouchEvent(starling.events.TouchEvent.TOUCH);
            this._stage.addEventListener(starling.events.KeyboardEvent.KEY_DOWN, this.onKey);
            this._stage.addEventListener(starling.events.KeyboardEvent.KEY_UP, this.onKey);
            this.monitorInterruptions(true);
            return;
        }

        public function set simulateMultitouch(arg1:Boolean):void
        {
            var value:Boolean;
            var target:starling.core.Starling;
            var createTouchMarker:Function;

            var loc1:*;
            target = null;
            createTouchMarker = null;
            value = arg1;
            createTouchMarker = function ():void
            {
                target.removeEventListener(starling.events.Event.CONTEXT3D_CREATE, createTouchMarker);
                if (_touchMarker == null) 
                {
                    _touchMarker = new TouchMarker();
                    _touchMarker.visible = false;
                    _stage.addChild(_touchMarker);
                }
                return;
            }
            if (this.simulateMultitouch == value) 
            {
                return;
            }
            this._simulateMultitouch = value;
            target = starling.core.Starling.current;
            if (value && this._touchMarker == null) 
            {
                if (starling.core.Starling.current.contextValid) 
                {
                    createTouchMarker();
                }
                else 
                {
                    target.addEventListener(starling.events.Event.CONTEXT3D_CREATE, createTouchMarker);
                }
            }
            else if (!value && this._touchMarker) 
            {
                this._touchMarker.removeFromParent(true);
                this._touchMarker = null;
            }
            return;
        }

        public function get multitapTime():Number
        {
            return this._multitapTime;
        }

        public function set multitapTime(arg1:Number):void
        {
            this._multitapTime = arg1;
            return;
        }

        public function get multitapDistance():Number
        {
            return this._multitapDistance;
        }

        internal function updateTapCount(arg1:starling.events.Touch):void
        {
            var loc3:*=null;
            var loc4:*=NaN;
            var loc1:*=null;
            var loc2:*=this._multitapDistance * this._multitapDistance;
            var loc5:*=0;
            var loc6:*=this._lastTaps;
            for each (loc3 in loc6) 
            {
                loc4 = Math.pow(loc3.globalX - arg1.globalX, 2) + Math.pow(loc3.globalY - arg1.globalY, 2);
                if (!(loc4 <= loc2)) 
                {
                    continue;
                }
                loc1 = loc3;
                break;
            }
            if (loc1) 
            {
                arg1.tapCount = loc1.tapCount + 1;
                this._lastTaps.removeAt(this._lastTaps.indexOf(loc1));
            }
            else 
            {
                arg1.tapCount = 1;
            }
            this._lastTaps[this._lastTaps.length] = arg1.clone();
            return;
        }

        public function set multitapDistance(arg1:Number):void
        {
            this._multitapDistance = arg1;
            return;
        }

        public function get root():starling.display.DisplayObject
        {
            return this._root;
        }

        public function set root(arg1:starling.display.DisplayObject):void
        {
            this._root = arg1;
            return;
        }

        public function get stage():starling.display.Stage
        {
            return this._stage;
        }

        public function get numCurrentTouches():int
        {
            return this._currentTouches.length;
        }

        internal function onKey(arg1:starling.events.KeyboardEvent):void
        {
            var loc1:*=false;
            var loc2:*=null;
            var loc3:*=null;
            if (arg1.keyCode == 17 || arg1.keyCode == 15) 
            {
                loc1 = this._ctrlDown;
                this._ctrlDown = arg1.type == starling.events.KeyboardEvent.KEY_DOWN;
                if (this._touchMarker && !(loc1 == this._ctrlDown)) 
                {
                    this._touchMarker.visible = this._ctrlDown;
                    this._touchMarker.moveCenter(this._stage.stageWidth / 2, this._stage.stageHeight / 2);
                    loc2 = this.getCurrentTouch(0);
                    loc3 = this.getCurrentTouch(1);
                    if (loc2) 
                    {
                        this._touchMarker.moveMarker(loc2.globalX, loc2.globalY);
                    }
                    if (loc1 && loc3 && !(loc3.phase == starling.events.TouchPhase.ENDED)) 
                    {
                        this._queue.unshift([1, starling.events.TouchPhase.ENDED, loc3.globalX, loc3.globalY]);
                    }
                    else if (this._ctrlDown && loc2) 
                    {
                        if (loc2.phase == starling.events.TouchPhase.HOVER || loc2.phase == starling.events.TouchPhase.ENDED) 
                        {
                            this._queue.unshift([1, starling.events.TouchPhase.HOVER, this._touchMarker.mockX, this._touchMarker.mockY]);
                        }
                        else 
                        {
                            this._queue.unshift([1, starling.events.TouchPhase.BEGAN, this._touchMarker.mockX, this._touchMarker.mockY]);
                        }
                    }
                }
            }
            else if (arg1.keyCode == 16) 
            {
                this._shiftDown = arg1.type == starling.events.KeyboardEvent.KEY_DOWN;
            }
            return;
        }

        internal function onInterruption(arg1:Object):void
        {
            this.cancelTouches();
            return;
        }

        
        {
            sUpdatedTouches = new Vector.<starling.events.Touch>(0);
            sHoveringTouchData = new Vector.<Object>(0);
            sHelperPoint = new flash.geom.Point();
        }

        public function dispose():void
        {
            this.monitorInterruptions(false);
            this._stage.removeEventListener(starling.events.KeyboardEvent.KEY_DOWN, this.onKey);
            this._stage.removeEventListener(starling.events.KeyboardEvent.KEY_UP, this.onKey);
            if (this._touchMarker) 
            {
                this._touchMarker.dispose();
            }
            return;
        }

        public function advanceTime(arg1:Number):void
        {
            var loc1:*=0;
            var loc2:*=null;
            var loc3:*=null;
            this._elapsedTime = this._elapsedTime + arg1;
            sUpdatedTouches.length = 0;
            if (this._lastTaps.length > 0) 
            {
                loc1 = (this._lastTaps.length - 1);
                while (loc1 >= 0) 
                {
                    if (this._elapsedTime - this._lastTaps[loc1].timestamp > this._multitapTime) 
                    {
                        this._lastTaps.removeAt(loc1);
                    }
                    --loc1;
                }
            }
            while (this._queue.length > 0) 
            {
                var loc4:*=0;
                var loc5:*=this._currentTouches;
                for each (loc2 in loc5) 
                {
                    if (!(loc2.phase == starling.events.TouchPhase.BEGAN || loc2.phase == starling.events.TouchPhase.MOVED)) 
                    {
                        continue;
                    }
                    loc2.phase = starling.events.TouchPhase.STATIONARY;
                }
                while (this._queue.length > 0 && !this.containsTouchWithID(sUpdatedTouches, this._queue[(this._queue.length - 1)][0])) 
                {
                    loc3 = this._queue.pop();
                    loc2 = this.createOrUpdateTouch(loc3[0], loc3[1], loc3[2], loc3[3], loc3[4], loc3[5], loc3[6]);
                    sUpdatedTouches[sUpdatedTouches.length] = loc2;
                }
                this.processTouches(sUpdatedTouches, this._shiftDown, this._ctrlDown);
                loc1 = (this._currentTouches.length - 1);
                while (loc1 >= 0) 
                {
                    if (this._currentTouches[loc1].phase == starling.events.TouchPhase.ENDED) 
                    {
                        this._currentTouches.removeAt(loc1);
                    }
                    --loc1;
                }
                sUpdatedTouches.length = 0;
            }
            return;
        }

        protected function processTouches(arg1:__AS3__.vec.Vector.<starling.events.Touch>, arg2:Boolean, arg3:Boolean):void
        {
            var loc1:*=null;
            var loc2:*=null;
            sHoveringTouchData.length = 0;
            this._touchEvent.resetTo(starling.events.TouchEvent.TOUCH, this._currentTouches, arg2, arg3);
            var loc3:*=0;
            var loc4:*=arg1;
            for each (loc1 in loc4) 
            {
                if (loc1.phase == starling.events.TouchPhase.HOVER && loc1.target) 
                {
                    sHoveringTouchData[sHoveringTouchData.length] = {"touch":loc1, "target":loc1.target, "bubbleChain":loc1.bubbleChain};
                }
                if (!(loc1.phase == starling.events.TouchPhase.HOVER || loc1.phase == starling.events.TouchPhase.BEGAN)) 
                {
                    continue;
                }
                sHelperPoint.setTo(loc1.globalX, loc1.globalY);
                loc1.target = this._root.hitTest(sHelperPoint);
            }
            loc3 = 0;
            loc4 = sHoveringTouchData;
            for each (loc2 in loc4) 
            {
                if (loc2.touch.target == loc2.target) 
                {
                    continue;
                }
                this._touchEvent.dispatch(loc2.bubbleChain);
            }
            loc3 = 0;
            loc4 = arg1;
            for each (loc1 in loc4) 
            {
                loc1.dispatchEvent(this._touchEvent);
            }
            this._touchEvent.resetTo(starling.events.TouchEvent.TOUCH);
            return;
        }

        public function enqueue(arg1:int, arg2:String, arg3:Number, arg4:Number, arg5:Number=1, arg6:Number=1, arg7:Number=1):void
        {
            this._queue.unshift(arguments);
            if (this._ctrlDown && this._touchMarker && arg1 == 0) 
            {
                this._touchMarker.moveMarker(arg3, arg4, this._shiftDown);
                this._queue.unshift([1, arg2, this._touchMarker.mockX, this._touchMarker.mockY]);
            }
            return;
        }

        public function enqueueMouseLeftStage():void
        {
            var loc1:*=this.getCurrentTouch(0);
            if (loc1 == null || !(loc1.phase == starling.events.TouchPhase.HOVER)) 
            {
                return;
            }
            var loc2:*=1;
            var loc3:*=loc1.globalX;
            var loc4:*=loc1.globalY;
            var loc5:*=loc1.globalX;
            var loc6:*=this._stage.stageWidth - loc5;
            var loc7:*=loc1.globalY;
            var loc8:*=this._stage.stageHeight - loc7;
            var loc9:*=Math.min(loc5, loc6, loc7, loc8);
            if (loc9 != loc5) 
            {
                if (loc9 != loc6) 
                {
                    if (loc9 != loc7) 
                    {
                        loc4 = this._stage.stageHeight + loc2;
                    }
                    else 
                    {
                        loc4 = -loc2;
                    }
                }
                else 
                {
                    loc3 = this._stage.stageWidth + loc2;
                }
            }
            else 
            {
                loc3 = -loc2;
            }
            this.enqueue(0, starling.events.TouchPhase.HOVER, loc3, loc4);
            return;
        }

        public function cancelTouches():void
        {
            var loc1:*=null;
            if (this._currentTouches.length > 0) 
            {
                var loc2:*=0;
                var loc3:*=this._currentTouches;
                for each (loc1 in loc3) 
                {
                    if (!(loc1.phase == starling.events.TouchPhase.BEGAN || loc1.phase == starling.events.TouchPhase.MOVED || loc1.phase == starling.events.TouchPhase.STATIONARY)) 
                    {
                        continue;
                    }
                    loc1.phase = starling.events.TouchPhase.ENDED;
                    loc1.cancelled = true;
                }
                this.processTouches(this._currentTouches, this._shiftDown, this._ctrlDown);
            }
            this._currentTouches.length = 0;
            this._queue.length = 0;
            return;
        }

        internal function createOrUpdateTouch(arg1:int, arg2:String, arg3:Number, arg4:Number, arg5:Number=1, arg6:Number=1, arg7:Number=1):starling.events.Touch
        {
            var loc1:*=this.getCurrentTouch(arg1);
            if (loc1 == null) 
            {
                loc1 = new starling.events.Touch(arg1);
                this.addCurrentTouch(loc1);
            }
            loc1.globalX = arg3;
            loc1.globalY = arg4;
            loc1.phase = arg2;
            loc1.timestamp = this._elapsedTime;
            loc1.pressure = arg5;
            loc1.width = arg6;
            loc1.height = arg7;
            if (arg2 == starling.events.TouchPhase.BEGAN) 
            {
                this.updateTapCount(loc1);
            }
            return loc1;
        }

        internal function monitorInterruptions(arg1:Boolean):void
        {
            var loc1:*=null;
            var loc2:*=null;
            try 
            {
                loc1 = flash.utils.getDefinitionByName("flash.desktop::NativeApplication");
                loc2 = loc1["nativeApplication"];
                if (arg1) 
                {
                    loc2.addEventListener("deactivate", this.onInterruption, false, 0, true);
                }
                else 
                {
                    loc2.removeEventListener("deactivate", this.onInterruption);
                }
            }
            catch (e:Error)
            {
            };
            return;
        }

        internal function addCurrentTouch(arg1:starling.events.Touch):void
        {
            var loc1:*=(this._currentTouches.length - 1);
            while (loc1 >= 0) 
            {
                if (this._currentTouches[loc1].id == arg1.id) 
                {
                    this._currentTouches.removeAt(loc1);
                }
                --loc1;
            }
            this._currentTouches[this._currentTouches.length] = arg1;
            return;
        }

        internal function getCurrentTouch(arg1:int):starling.events.Touch
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=this._currentTouches;
            for each (loc1 in loc3) 
            {
                if (loc1.id != arg1) 
                {
                    continue;
                }
                return loc1;
            }
            return null;
        }

        internal function containsTouchWithID(arg1:__AS3__.vec.Vector.<starling.events.Touch>, arg2:int):Boolean
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=arg1;
            for each (loc1 in loc3) 
            {
                if (loc1.id != arg2) 
                {
                    continue;
                }
                return true;
            }
            return false;
        }

        public function get simulateMultitouch():Boolean
        {
            return this._simulateMultitouch;
        }

        internal var _stage:starling.display.Stage;

        internal var _root:starling.display.DisplayObject;

        internal var _elapsedTime:Number;

        internal var _lastTaps:__AS3__.vec.Vector.<starling.events.Touch>;

        internal var _ctrlDown:Boolean=false;

        internal var _multitapTime:Number=0.3;

        internal var _multitapDistance:Number=25;

        internal var _touchEvent:starling.events.TouchEvent;

        internal var _touchMarker:TouchMarker;

        internal var _simulateMultitouch:Boolean;

        protected var _queue:__AS3__.vec.Vector.<Array>;

        protected var _currentTouches:__AS3__.vec.Vector.<starling.events.Touch>;

        internal static var sUpdatedTouches:__AS3__.vec.Vector.<starling.events.Touch>;

        internal static var sHoveringTouchData:__AS3__.vec.Vector.<Object>;

        internal static var sHelperPoint:flash.geom.Point;

        internal var _shiftDown:Boolean=false;
    }
}


