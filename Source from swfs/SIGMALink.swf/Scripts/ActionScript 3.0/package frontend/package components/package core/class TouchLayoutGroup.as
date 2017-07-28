//class TouchLayoutGroup
package frontend.components.core 
{
    import __AS3__.vec.*;
    import feathers.controls.*;
    import feathers.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import starling.events.*;
    
    public class TouchLayoutGroup extends feathers.controls.LayoutGroup
    {
        public function TouchLayoutGroup()
        {
            new Vector.<String>(4)[0] = STATE_UP;
            new Vector.<String>(4)[1] = STATE_DOWN;
            new Vector.<String>(4)[2] = STATE_HOVER;
            new Vector.<String>(4)[3] = STATE_DISABLED;
            this._stateNames = new Vector.<String>(4);
            super();
            addEventListener(starling.events.TouchEvent.TOUCH, this.touchHandler);
            return;
        }

        public function get currentState():String
        {
            return this._currentState;
        }

        public override function set isEnabled(arg1:Boolean):void
        {
            if (this._isEnabled == arg1) 
            {
                return;
            }
            super.isEnabled = arg1;
            if (this._isEnabled) 
            {
                if (this._currentState == STATE_DISABLED) 
                {
                    this.changeState(STATE_UP);
                }
                this.touchable = true;
            }
            else 
            {
                this.touchable = false;
                this.changeState(STATE_DISABLED);
                this.touchPointID = -1;
            }
            return;
        }

        public function get isLongPressEnabled():Boolean
        {
            return this._isLongPressEnabled;
        }

        public function set isLongPressEnabled(arg1:Boolean):void
        {
            this._isLongPressEnabled = arg1;
            if (!arg1) 
            {
                this.removeEventListener(starling.events.Event.ENTER_FRAME, this.longPress_enterFrameHandler);
            }
            return;
        }

        protected function get stateNames():__AS3__.vec.Vector.<String>
        {
            return this._stateNames;
        }

        protected function touchHandler(arg1:starling.events.TouchEvent):void
        {
            var loc1:*=null;
            var loc2:*=false;
            if (!this._isEnabled) 
            {
                this.touchPointID = -1;
                return;
            }
            if (this.touchPointID >= 0) 
            {
                loc1 = arg1.getTouch(this, null, this.touchPointID);
                if (!loc1) 
                {
                    return;
                }
                if (!this.stage) 
                {
                    return;
                }
                loc1.getLocation(this.stage, HELPER_POINT);
                loc2 = this.contains(this.stage.hitTest(HELPER_POINT));
                if (loc1.phase != starling.events.TouchPhase.MOVED) 
                {
                    if (loc1.phase == starling.events.TouchPhase.ENDED) 
                    {
                        this.resetTouchState(loc1);
                        if (!this._hasLongPressed && loc2) 
                        {
                            arg1.stopPropagation();
                            this.trigger();
                        }
                    }
                }
                else 
                {
                    if (this._isLongPressEnabled) 
                    {
                        this._longPressGlobalPosition.x = loc1.globalX;
                        this._longPressGlobalPosition.y = loc1.globalY;
                    }
                    if (loc2 || this.keepDownStateOnRollOut) 
                    {
                        this.changeState(STATE_DOWN);
                    }
                    else 
                    {
                        this.changeState(STATE_UP);
                    }
                }
                return;
            }
            loc1 = arg1.getTouch(this, starling.events.TouchPhase.BEGAN);
            if (loc1) 
            {
                this.changeState(STATE_DOWN);
                this.touchPointID = loc1.id;
                if (this._isLongPressEnabled) 
                {
                    this._touchBeginTime = flash.utils.getTimer();
                    if (this._longPressGlobalPosition) 
                    {
                        this._longPressGlobalPosition.x = loc1.globalX;
                        this._longPressGlobalPosition.y = loc1.globalY;
                    }
                    else 
                    {
                        this._longPressGlobalPosition = new flash.geom.Point(loc1.globalX, loc1.globalY);
                    }
                    this._hasLongPressed = false;
                    this.addEventListener(starling.events.Event.ENTER_FRAME, this.longPress_enterFrameHandler);
                }
                return;
            }
            loc1 = arg1.getTouch(this, starling.events.TouchPhase.HOVER);
            if (loc1) 
            {
                this.changeState(STATE_HOVER);
                return;
            }
            this.changeState(STATE_UP);
            return;
        }

        protected function longPress_enterFrameHandler(arg1:starling.events.Event):void
        {
            var loc2:*=false;
            var loc1:*=(flash.utils.getTimer() - this._touchBeginTime) / 1000;
            if (loc1 >= this._longPressDuration) 
            {
                this.removeEventListener(starling.events.Event.ENTER_FRAME, this.longPress_enterFrameHandler);
                loc2 = this.contains(this.stage.hitTest(this._longPressGlobalPosition));
                if (loc2) 
                {
                    this._hasLongPressed = true;
                    this.dispatchEventWith(feathers.events.FeathersEventType.LONG_PRESS);
                }
            }
            return;
        }

        protected function changeState(arg1:String):void
        {
            if (this._currentState == arg1) 
            {
                return;
            }
            if (this.stateNames.indexOf(arg1) < 0) 
            {
                throw new ArgumentError("Invalid state: " + arg1 + ".");
            }
            this._currentState = arg1;
            this.invalidate(INVALIDATION_FLAG_STATE);
            this.dispatchEventWith(feathers.events.FeathersEventType.STATE_CHANGE);
            return;
        }

        protected function resetTouchState(arg1:starling.events.Touch=null):void
        {
            this.touchPointID = -1;
            this.removeEventListener(starling.events.Event.ENTER_FRAME, this.longPress_enterFrameHandler);
            if (this._isEnabled) 
            {
                this.changeState(STATE_UP);
            }
            else 
            {
                this.changeState(STATE_DISABLED);
            }
            return;
        }

        protected function trigger():void
        {
            this.dispatchEventWith(starling.events.Event.TRIGGERED);
            return;
        }

        public static const STATE_DISABLED:String="disabled";

        public static const STATE_DOWN:String="down";

        public static const STATE_HOVER:String="hover";

        public static const STATE_UP:String="up";

        internal static const HELPER_POINT:flash.geom.Point=new flash.geom.Point();

        protected var _currentState:String="up";

        protected var _isLongPressEnabled:Boolean=false;

        public var keepDownStateOnRollOut:Boolean=false;

        protected var _hasLongPressed:Boolean=false;

        protected var _longPressDuration:Number=0.5;

        protected var _longPressGlobalPosition:flash.geom.Point;

        protected var _touchBeginTime:int;

        protected var _stateNames:__AS3__.vec.Vector.<String>;

        protected var touchPointID:int=-1;
    }
}


