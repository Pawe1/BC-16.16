//class TapToTrigger
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


