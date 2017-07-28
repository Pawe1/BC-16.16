//class KeyToTrigger
package feathers.utils.keyboard 
{
    import feathers.core.*;
    import feathers.events.*;
    import starling.display.*;
    import starling.events.*;
    
    public class KeyToTrigger extends Object
    {
        public function KeyToTrigger(arg1:feathers.core.IFocusDisplayObject=null)
        {
            super();
            this.target = arg1;
            return;
        }

        public function get target():feathers.core.IFocusDisplayObject
        {
            return this._target;
        }

        public function set target(arg1:feathers.core.IFocusDisplayObject):void
        {
            if (this._target === arg1) 
            {
                return;
            }
            if (this._target) 
            {
                this._target.removeEventListener(feathers.events.FeathersEventType.FOCUS_IN, this.target_focusInHandler);
                this._target.removeEventListener(feathers.events.FeathersEventType.FOCUS_OUT, this.target_focusOutHandler);
                this._target.removeEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.target_removedFromStageHandler);
            }
            this._target = arg1;
            if (this._target) 
            {
                this._target.addEventListener(feathers.events.FeathersEventType.FOCUS_IN, this.target_focusInHandler);
                this._target.addEventListener(feathers.events.FeathersEventType.FOCUS_OUT, this.target_focusOutHandler);
                this._target.addEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.target_removedFromStageHandler);
            }
            return;
        }

        public function get keyCode():uint
        {
            return this._keyCode;
        }

        public function set keyCode(arg1:uint):void
        {
            this._keyCode = arg1;
            return;
        }

        public function get cancelKeyCode():uint
        {
            return this._cancelKeyCode;
        }

        public function set cancelKeyCode(arg1:uint):void
        {
            this._cancelKeyCode = arg1;
            return;
        }

        public function get isEnabled():Boolean
        {
            return this._isEnabled;
        }

        public function set isEnabled(arg1:Boolean):void
        {
            this._isEnabled = arg1;
            return;
        }

        protected function target_focusInHandler(arg1:starling.events.Event):void
        {
            this._target.stage.addEventListener(starling.events.KeyboardEvent.KEY_DOWN, this.stage_keyDownHandler);
            return;
        }

        protected function target_focusOutHandler(arg1:starling.events.Event):void
        {
            this._target.stage.removeEventListener(starling.events.KeyboardEvent.KEY_DOWN, this.stage_keyDownHandler);
            this._target.stage.removeEventListener(starling.events.KeyboardEvent.KEY_UP, this.stage_keyUpHandler);
            return;
        }

        protected function target_removedFromStageHandler(arg1:starling.events.Event):void
        {
            this._target.stage.removeEventListener(starling.events.KeyboardEvent.KEY_DOWN, this.stage_keyDownHandler);
            this._target.stage.removeEventListener(starling.events.KeyboardEvent.KEY_UP, this.stage_keyUpHandler);
            return;
        }

        protected function stage_keyDownHandler(arg1:starling.events.KeyboardEvent):void
        {
            if (!this._isEnabled) 
            {
                return;
            }
            if (arg1.keyCode !== this._cancelKeyCode) 
            {
                if (arg1.keyCode === this._keyCode) 
                {
                    this._target.stage.addEventListener(starling.events.KeyboardEvent.KEY_UP, this.stage_keyUpHandler);
                }
            }
            else 
            {
                this._target.stage.removeEventListener(starling.events.KeyboardEvent.KEY_UP, this.stage_keyUpHandler);
            }
            return;
        }

        protected function stage_keyUpHandler(arg1:starling.events.KeyboardEvent):void
        {
            if (!this._isEnabled) 
            {
                return;
            }
            if (arg1.keyCode !== this._keyCode) 
            {
                return;
            }
            var loc1:*=starling.display.Stage(arg1.currentTarget);
            loc1.removeEventListener(starling.events.KeyboardEvent.KEY_UP, this.stage_keyUpHandler);
            if (this._target.stage !== loc1) 
            {
                return;
            }
            this._target.dispatchEventWith(starling.events.Event.TRIGGERED);
            return;
        }

        protected var _target:feathers.core.IFocusDisplayObject;

        protected var _keyCode:uint=32;

        protected var _cancelKeyCode:uint=27;

        protected var _isEnabled:Boolean=true;
    }
}


