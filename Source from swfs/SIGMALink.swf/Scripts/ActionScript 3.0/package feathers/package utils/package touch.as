//package touch
//  class LongPress
package feathers.utils.touch 
{
    import feathers.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import starling.display.*;
    import starling.events.*;
    import starling.utils.*;
    
    public class LongPress extends Object
    {
        public function LongPress(arg1:starling.display.DisplayObject=null)
        {
            this._touchLastGlobalPosition = new flash.geom.Point();
            super();
            this.target = arg1;
            return;
        }

        public function get target():starling.display.DisplayObject
        {
            return this._target;
        }

        public function set target(arg1:starling.display.DisplayObject):void
        {
            if (this._target == arg1) 
            {
                return;
            }
            if (this._target) 
            {
                this._target.removeEventListener(starling.events.TouchEvent.TOUCH, this.target_touchHandler);
            }
            this._target = arg1;
            if (this._target) 
            {
                this._touchPointID = -1;
                this._target.addEventListener(starling.events.TouchEvent.TOUCH, this.target_touchHandler);
            }
            return;
        }

        public function get longPressDuration():Number
        {
            return this._longPressDuration;
        }

        public function set longPressDuration(arg1:Number):void
        {
            this._longPressDuration = arg1;
            return;
        }

        public function get isEnabled():Boolean
        {
            return this._isEnabled;
        }

        public function set isEnabled(arg1:Boolean):void
        {
            if (this._isEnabled === arg1) 
            {
                return;
            }
            this._isEnabled = arg1;
            if (!arg1) 
            {
                this._touchPointID = -1;
            }
            return;
        }

        public function get tapToTrigger():feathers.utils.touch.TapToTrigger
        {
            return this._tapToTrigger;
        }

        public function set tapToTrigger(arg1:feathers.utils.touch.TapToTrigger):void
        {
            this._tapToTrigger = arg1;
            return;
        }

        public function get tapToSelect():feathers.utils.touch.TapToSelect
        {
            return this._tapToSelect;
        }

        public function set tapToSelect(arg1:feathers.utils.touch.TapToSelect):void
        {
            this._tapToSelect = arg1;
            return;
        }

        public function get customHitTest():Function
        {
            return this._customHitTest;
        }

        public function set customHitTest(arg1:Function):void
        {
            this._customHitTest = arg1;
            return;
        }

        protected function target_touchHandler(arg1:starling.events.TouchEvent):void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=false;
            if (!this._isEnabled) 
            {
                this._touchPointID = -1;
                return;
            }
            if (this._touchPointID >= 0) 
            {
                loc1 = arg1.getTouch(this._target, null, this._touchPointID);
                if (!loc1) 
                {
                    return;
                }
                if (loc1.phase != starling.events.TouchPhase.MOVED) 
                {
                    if (loc1.phase == starling.events.TouchPhase.ENDED) 
                    {
                        this._target.removeEventListener(starling.events.Event.ENTER_FRAME, this.target_enterFrameHandler);
                        if (this._tapToTrigger) 
                        {
                            this._tapToTrigger.isEnabled = true;
                        }
                        if (this._tapToSelect) 
                        {
                            this._tapToSelect.isEnabled = true;
                        }
                        this._touchPointID = -1;
                    }
                }
                else 
                {
                    this._touchLastGlobalPosition.x = loc1.globalX;
                    this._touchLastGlobalPosition.y = loc1.globalY;
                }
                return;
            }
            loc1 = arg1.getTouch(starling.display.DisplayObject(this._target), starling.events.TouchPhase.BEGAN);
            if (!loc1) 
            {
                return;
            }
            if (this._customHitTest !== null) 
            {
                loc2 = starling.utils.Pool.getPoint();
                loc1.getLocation(starling.display.DisplayObject(this._target), loc2);
                loc3 = this._customHitTest(loc2);
                starling.utils.Pool.putPoint(loc2);
                if (!loc3) 
                {
                    return;
                }
            }
            this._touchPointID = loc1.id;
            this._touchLastGlobalPosition.x = loc1.globalX;
            this._touchLastGlobalPosition.y = loc1.globalY;
            this._touchBeginTime = flash.utils.getTimer();
            this._target.addEventListener(starling.events.Event.ENTER_FRAME, this.target_enterFrameHandler);
            return;
        }

        protected function target_enterFrameHandler(arg1:starling.events.Event):void
        {
            var loc2:*=null;
            var loc3:*=false;
            var loc1:*=(flash.utils.getTimer() - this._touchBeginTime) / 1000;
            if (loc1 >= this._longPressDuration) 
            {
                this._target.removeEventListener(starling.events.Event.ENTER_FRAME, this.target_enterFrameHandler);
                loc2 = this._target.stage;
                if (this._target is starling.display.DisplayObjectContainer) 
                {
                    loc3 = starling.display.DisplayObjectContainer(this._target).contains(loc2.hitTest(this._touchLastGlobalPosition));
                }
                else 
                {
                    loc3 = this._target === loc2.hitTest(this._touchLastGlobalPosition);
                }
                if (loc3) 
                {
                    if (this._tapToTrigger) 
                    {
                        this._tapToTrigger.isEnabled = false;
                    }
                    if (this._tapToSelect) 
                    {
                        this._tapToSelect.isEnabled = false;
                    }
                    this._target.dispatchEventWith(feathers.events.FeathersEventType.LONG_PRESS);
                }
            }
            return;
        }

        protected var _target:starling.display.DisplayObject;

        protected var _longPressDuration:Number=0.5;

        protected var _touchPointID:int=-1;

        protected var _touchLastGlobalPosition:flash.geom.Point;

        protected var _touchBeginTime:int;

        protected var _isEnabled:Boolean=true;

        protected var _tapToTrigger:feathers.utils.touch.TapToTrigger;

        protected var _tapToSelect:feathers.utils.touch.TapToSelect;

        protected var _customHitTest:Function;
    }
}


//  class TapToSelect
package feathers.utils.touch 
{
    import feathers.core.*;
    import flash.geom.*;
    import starling.display.*;
    import starling.events.*;
    import starling.utils.*;
    
    public class TapToSelect extends Object
    {
        public function TapToSelect(arg1:feathers.core.IToggle=null)
        {
            super();
            this.target = arg1;
            return;
        }

        public function get target():feathers.core.IToggle
        {
            return this._target;
        }

        public function set target(arg1:feathers.core.IToggle):void
        {
            if (this._target == arg1) 
            {
                return;
            }
            if (this._target) 
            {
                this._target.removeEventListener(starling.events.TouchEvent.TOUCH, this.target_touchHandler);
            }
            this._target = arg1;
            if (this._target) 
            {
                this._touchPointID = -1;
                this._target.addEventListener(starling.events.TouchEvent.TOUCH, this.target_touchHandler);
            }
            return;
        }

        public function get isEnabled():Boolean
        {
            return this._isEnabled;
        }

        public function set isEnabled(arg1:Boolean):void
        {
            if (this._isEnabled === arg1) 
            {
                return;
            }
            this._isEnabled = arg1;
            if (!arg1) 
            {
                this._touchPointID = -1;
            }
            return;
        }

        public function get tapToDeselect():Boolean
        {
            return this._tapToDeselect;
        }

        public function set tapToDeselect(arg1:Boolean):void
        {
            this._tapToDeselect = arg1;
            return;
        }

        public function get customHitTest():Function
        {
            return this._customHitTest;
        }

        public function set customHitTest(arg1:Function):void
        {
            this._customHitTest = arg1;
            return;
        }

        protected function target_touchHandler(arg1:starling.events.TouchEvent):void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=false;
            if (!this._isEnabled) 
            {
                this._touchPointID = -1;
                return;
            }
            if (this._touchPointID >= 0) 
            {
                loc1 = arg1.getTouch(starling.display.DisplayObject(this._target), null, this._touchPointID);
                if (!loc1) 
                {
                    return;
                }
                if (loc1.phase == starling.events.TouchPhase.ENDED) 
                {
                    loc2 = this._target.stage;
                    if (loc2 !== null) 
                    {
                        loc3 = starling.utils.Pool.getPoint();
                        loc1.getLocation(loc2, loc3);
                        if (this._target is starling.display.DisplayObjectContainer) 
                        {
                            loc4 = starling.display.DisplayObjectContainer(this._target).contains(loc2.hitTest(loc3));
                        }
                        else 
                        {
                            loc4 = this._target === loc2.hitTest(loc3);
                        }
                        starling.utils.Pool.putPoint(loc3);
                        if (loc4) 
                        {
                            if (this._tapToDeselect) 
                            {
                                this._target.isSelected = !this._target.isSelected;
                            }
                            else 
                            {
                                this._target.isSelected = true;
                            }
                        }
                    }
                    this._touchPointID = -1;
                }
                return;
            }
            loc1 = arg1.getTouch(starling.display.DisplayObject(this._target), starling.events.TouchPhase.BEGAN);
            if (!loc1) 
            {
                return;
            }
            if (this._customHitTest !== null) 
            {
                loc3 = starling.utils.Pool.getPoint();
                loc1.getLocation(starling.display.DisplayObject(this._target), loc3);
                loc4 = this._customHitTest(loc3);
                starling.utils.Pool.putPoint(loc3);
                if (!loc4) 
                {
                    return;
                }
            }
            this._touchPointID = loc1.id;
            return;
        }

        protected var _target:feathers.core.IToggle;

        protected var _touchPointID:int=-1;

        protected var _isEnabled:Boolean=true;

        protected var _tapToDeselect:Boolean=false;

        protected var _customHitTest:Function;
    }
}


//  class TapToTrigger
package feathers.utils.touch 
{
    import flash.geom.*;
    import starling.display.*;
    import starling.events.*;
    import starling.utils.*;
    
    public class TapToTrigger extends Object
    {
        public function TapToTrigger(arg1:starling.display.DisplayObject=null)
        {
            super();
            this.target = arg1;
            return;
        }

        public function get target():starling.display.DisplayObject
        {
            return this._target;
        }

        public function set target(arg1:starling.display.DisplayObject):void
        {
            if (this._target == arg1) 
            {
                return;
            }
            if (this._target) 
            {
                this._target.removeEventListener(starling.events.TouchEvent.TOUCH, this.target_touchHandler);
            }
            this._target = arg1;
            if (this._target) 
            {
                this._touchPointID = -1;
                this._target.addEventListener(starling.events.TouchEvent.TOUCH, this.target_touchHandler);
            }
            return;
        }

        public function get isEnabled():Boolean
        {
            return this._isEnabled;
        }

        public function set isEnabled(arg1:Boolean):void
        {
            if (this._isEnabled === arg1) 
            {
                return;
            }
            this._isEnabled = arg1;
            if (!arg1) 
            {
                this._touchPointID = -1;
            }
            return;
        }

        public function get customHitTest():Function
        {
            return this._customHitTest;
        }

        public function set customHitTest(arg1:Function):void
        {
            this._customHitTest = arg1;
            return;
        }

        protected function target_touchHandler(arg1:starling.events.TouchEvent):void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=false;
            if (!this._isEnabled) 
            {
                this._touchPointID = -1;
                return;
            }
            if (this._touchPointID >= 0) 
            {
                loc1 = arg1.getTouch(this._target, null, this._touchPointID);
                if (!loc1) 
                {
                    return;
                }
                if (loc1.phase == starling.events.TouchPhase.ENDED) 
                {
                    loc2 = this._target.stage;
                    if (loc2 !== null) 
                    {
                        loc3 = starling.utils.Pool.getPoint();
                        loc1.getLocation(loc2, loc3);
                        if (this._target is starling.display.DisplayObjectContainer) 
                        {
                            loc4 = starling.display.DisplayObjectContainer(this._target).contains(loc2.hitTest(loc3));
                        }
                        else 
                        {
                            loc4 = this._target === loc2.hitTest(loc3);
                        }
                        starling.utils.Pool.putPoint(loc3);
                        if (loc4) 
                        {
                            this._target.dispatchEventWith(starling.events.Event.TRIGGERED);
                        }
                    }
                    this._touchPointID = -1;
                }
                return;
            }
            loc1 = arg1.getTouch(starling.display.DisplayObject(this._target), starling.events.TouchPhase.BEGAN);
            if (!loc1) 
            {
                return;
            }
            if (this._customHitTest !== null) 
            {
                loc3 = starling.utils.Pool.getPoint();
                loc1.getLocation(starling.display.DisplayObject(this._target), loc3);
                loc4 = this._customHitTest(loc3);
                starling.utils.Pool.putPoint(loc3);
                if (!loc4) 
                {
                    return;
                }
            }
            this._touchPointID = loc1.id;
            return;
        }

        protected var _target:starling.display.DisplayObject;

        protected var _touchPointID:int=-1;

        protected var _isEnabled:Boolean=true;

        protected var _customHitTest:Function;
    }
}


