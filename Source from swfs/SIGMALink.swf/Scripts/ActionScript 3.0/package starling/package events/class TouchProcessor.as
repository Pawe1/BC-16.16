//class TouchProcessor
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


