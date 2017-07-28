//class BasicButton
package feathers.controls 
{
    import feathers.core.*;
    import feathers.events.*;
    import feathers.skins.*;
    import feathers.utils.skins.*;
    import feathers.utils.touch.*;
    import flash.geom.*;
    import starling.display.*;
    import starling.events.*;
    
    public class BasicButton extends feathers.core.FeathersControl implements feathers.core.IStateContext
    {
        public function BasicButton()
        {
            this._stateToSkin = {};
            super();
            this.isQuickHitAreaEnabled = true;
            this.addEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.basicButton_removedFromStageHandler);
            this.addEventListener(starling.events.TouchEvent.TOUCH, this.basicButton_touchHandler);
            return;
        }

        protected override function get defaultStyleProvider():feathers.skins.IStyleProvider
        {
            return feathers.controls.BasicButton.globalStyleProvider;
        }

        protected function getCurrentSkin():starling.display.DisplayObject
        {
            var loc1:*=this._stateToSkin[this._currentState] as starling.display.DisplayObject;
            if (loc1 !== null) 
            {
                return loc1;
            }
            return this._defaultSkin;
        }

        protected function scaleSkin():void
        {
            if (!this.currentSkin) 
            {
                return;
            }
            this.currentSkin.x = 0;
            this.currentSkin.y = 0;
            if (this.currentSkin.width !== this.actualWidth) 
            {
                this.currentSkin.width = this.actualWidth;
            }
            if (this.currentSkin.height !== this.actualHeight) 
            {
                this.currentSkin.height = this.actualHeight;
            }
            if (this.currentSkin is feathers.core.IValidating) 
            {
                feathers.core.IValidating(this.currentSkin).validate();
            }
            return;
        }

        protected function removeCurrentSkin(arg1:starling.display.DisplayObject):void
        {
            if (arg1 === null) 
            {
                return;
            }
            if (arg1 is feathers.core.IStateObserver) 
            {
                feathers.core.IStateObserver(arg1).stateContext = null;
            }
            if (arg1.parent === this) 
            {
                this.removeChild(arg1, false);
            }
            return;
        }

        public function get currentState():String
        {
            return this._currentState;
        }

        protected function refreshTriggeredEvents():void
        {
            this.tapToTrigger.isEnabled = this._isEnabled;
            return;
        }

        public override function set isEnabled(arg1:Boolean):void
        {
            if (this._isEnabled === arg1) 
            {
                return;
            }
            super.isEnabled = arg1;
            if (this._isEnabled) 
            {
                if (this._currentState === feathers.controls.ButtonState.DISABLED) 
                {
                    this.changeState(feathers.controls.ButtonState.UP);
                }
            }
            else 
            {
                this.resetTouchState();
            }
            return;
        }

        protected function resetTouchState(arg1:starling.events.Touch=null):void
        {
            this.touchPointID = -1;
            if (this._isEnabled) 
            {
                this.changeState(feathers.controls.ButtonState.UP);
            }
            else 
            {
                this.changeState(feathers.controls.ButtonState.DISABLED);
            }
            return;
        }

        public function get keepDownStateOnRollOut():Boolean
        {
            return this._keepDownStateOnRollOut;
        }

        public function set keepDownStateOnRollOut(arg1:Boolean):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            this._keepDownStateOnRollOut = arg1;
            return;
        }

        protected function basicButton_removedFromStageHandler(arg1:starling.events.Event):void
        {
            this.resetTouchState();
            return;
        }

        public function get defaultSkin():starling.display.DisplayObject
        {
            return this._defaultSkin;
        }

        public function set defaultSkin(arg1:starling.display.DisplayObject):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                if (arg1 !== null) 
                {
                    arg1.dispose();
                }
                return;
            }
            if (this._defaultSkin === arg1) 
            {
                return;
            }
            if (!(this._defaultSkin === null) && this.currentSkin === this._defaultSkin) 
            {
                this.removeCurrentSkin(this._defaultSkin);
                this.currentSkin = null;
            }
            this._defaultSkin = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get upSkin():starling.display.DisplayObject
        {
            return this.getSkinForState(feathers.controls.ButtonState.UP);
        }

        public function set upSkin(arg1:starling.display.DisplayObject):void
        {
            this.setSkinForState(feathers.controls.ButtonState.UP, arg1);
            return;
        }

        public function get downSkin():starling.display.DisplayObject
        {
            return this.getSkinForState(feathers.controls.ButtonState.DOWN);
        }

        public function set downSkin(arg1:starling.display.DisplayObject):void
        {
            this.setSkinForState(feathers.controls.ButtonState.DOWN, arg1);
            return;
        }

        public function get hoverSkin():starling.display.DisplayObject
        {
            return this.getSkinForState(feathers.controls.ButtonState.HOVER);
        }

        public function set hoverSkin(arg1:starling.display.DisplayObject):void
        {
            this.setSkinForState(feathers.controls.ButtonState.HOVER, arg1);
            return;
        }

        public function get disabledSkin():starling.display.DisplayObject
        {
            return this.getSkinForState(feathers.controls.ButtonState.DISABLED);
        }

        public function set disabledSkin(arg1:starling.display.DisplayObject):void
        {
            this.setSkinForState(feathers.controls.ButtonState.DISABLED, arg1);
            return;
        }

        protected function basicButton_touchHandler(arg1:starling.events.TouchEvent):void
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
                loc1.getLocation(this.stage, HELPER_POINT);
                loc2 = this.contains(this.stage.hitTest(HELPER_POINT));
                if (loc1.phase !== starling.events.TouchPhase.MOVED) 
                {
                    if (loc1.phase === starling.events.TouchPhase.ENDED) 
                    {
                        this.resetTouchState(loc1);
                    }
                }
                else if (loc2 || this._keepDownStateOnRollOut) 
                {
                    this.changeState(feathers.controls.ButtonState.DOWN);
                }
                else 
                {
                    this.changeState(feathers.controls.ButtonState.UP);
                }
                return;
            }
            loc1 = arg1.getTouch(this, starling.events.TouchPhase.BEGAN);
            if (loc1) 
            {
                this.changeState(feathers.controls.ButtonState.DOWN);
                this.touchPointID = loc1.id;
                return;
            }
            loc1 = arg1.getTouch(this, starling.events.TouchPhase.HOVER);
            if (loc1) 
            {
                this.changeState(feathers.controls.ButtonState.HOVER);
                return;
            }
            this.changeState(feathers.controls.ButtonState.UP);
            return;
        }

        protected function changeState(arg1:String):void
        {
            if (this._currentState === arg1) 
            {
                return;
            }
            this._currentState = arg1;
            this.invalidate(INVALIDATION_FLAG_STATE);
            this.dispatchEventWith(feathers.events.FeathersEventType.STATE_CHANGE);
            return;
        }

        public function getSkinForState(arg1:String):starling.display.DisplayObject
        {
            return this._stateToSkin[arg1] as starling.display.DisplayObject;
        }

        public function setSkinForState(arg1:String, arg2:starling.display.DisplayObject):void
        {
            var loc1:*="setSkinForState--" + arg1;
            if (this.processStyleRestriction(loc1)) 
            {
                if (arg2 !== null) 
                {
                    arg2.dispose();
                }
                return;
            }
            var loc2:*=this._stateToSkin[arg1] as starling.display.DisplayObject;
            if (!(loc2 === null) && this.currentSkin === loc2) 
            {
                this.removeCurrentSkin(loc2);
                this.currentSkin = null;
            }
            if (arg2 === null) 
            {
                delete this._stateToSkin[arg1];
            }
            else 
            {
                this._stateToSkin[arg1] = arg2;
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public override function dispose():void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (!(this._defaultSkin === null) && !(this._defaultSkin.parent === this)) 
            {
                this._defaultSkin.dispose();
            }
            var loc3:*=0;
            var loc4:*=this._stateToSkin;
            for (loc1 in loc4) 
            {
                loc2 = this._stateToSkin[loc1] as starling.display.DisplayObject;
                if (!(!(loc2 === null) && !(loc2.parent === this))) 
                {
                    continue;
                }
                loc2.dispose();
            }
            super.dispose();
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            if (!this.tapToTrigger) 
            {
                this.tapToTrigger = new feathers.utils.touch.TapToTrigger(this);
            }
            return;
        }

        protected override function draw():void
        {
            var loc1:*=this.isInvalid(INVALIDATION_FLAG_STYLES);
            var loc2:*=this.isInvalid(INVALIDATION_FLAG_STATE);
            var loc3:*=this.isInvalid(INVALIDATION_FLAG_SIZE);
            if (loc1 || loc2) 
            {
                this.refreshTriggeredEvents();
                this.refreshSkin();
            }
            this.autoSizeIfNeeded();
            this.scaleSkin();
            return;
        }

        protected function autoSizeIfNeeded():Boolean
        {
            var loc1:*=!(this._explicitWidth === this._explicitWidth);
            var loc2:*=!(this._explicitHeight === this._explicitHeight);
            var loc3:*=!(this._explicitMinWidth === this._explicitMinWidth);
            var loc4:*=!(this._explicitMinHeight === this._explicitMinHeight);
            if (!loc1 && !loc2 && !loc3 && !loc4) 
            {
                return false;
            }
            feathers.utils.skins.resetFluidChildDimensionsForMeasurement(this.currentSkin, this._explicitWidth, this._explicitHeight, this._explicitMinWidth, this._explicitMinHeight, this._explicitMaxWidth, this._explicitMaxHeight, this._explicitSkinWidth, this._explicitSkinHeight, this._explicitSkinMinWidth, this._explicitSkinMinHeight, this._explicitSkinMaxWidth, this._explicitSkinMaxHeight);
            var loc5:*=this.currentSkin as feathers.core.IMeasureDisplayObject;
            if (this.currentSkin is feathers.core.IValidating) 
            {
                feathers.core.IValidating(this.currentSkin).validate();
            }
            var loc6:*=this._explicitMinWidth;
            if (loc3) 
            {
                if (loc5 === null) 
                {
                    if (this.currentSkin === null) 
                    {
                        loc6 = 0;
                    }
                    else 
                    {
                        loc6 = this._explicitSkinMinWidth;
                    }
                }
                else 
                {
                    loc6 = loc5.minWidth;
                }
            }
            var loc7:*=this._explicitMinHeight;
            if (loc4) 
            {
                if (loc5 === null) 
                {
                    if (this.currentSkin === null) 
                    {
                        loc7 = 0;
                    }
                    else 
                    {
                        loc7 = this._explicitSkinMinHeight;
                    }
                }
                else 
                {
                    loc7 = loc5.minHeight;
                }
            }
            var loc8:*=this._explicitWidth;
            if (loc1) 
            {
                if (this.currentSkin === null) 
                {
                    loc8 = 0;
                }
                else 
                {
                    loc8 = this.currentSkin.width;
                }
            }
            var loc9:*=this._explicitHeight;
            if (loc2) 
            {
                if (this.currentSkin === null) 
                {
                    loc9 = 0;
                }
                else 
                {
                    loc9 = this.currentSkin.height;
                }
            }
            return this.saveMeasurements(loc8, loc9, loc6, loc7);
        }

        protected function refreshSkin():void
        {
            var loc2:*=null;
            var loc1:*=this.currentSkin;
            this.currentSkin = this.getCurrentSkin();
            if (this.currentSkin !== loc1) 
            {
                this.removeCurrentSkin(loc1);
                if (this.currentSkin !== null) 
                {
                    if (this.currentSkin is feathers.core.IFeathersControl) 
                    {
                        feathers.core.IFeathersControl(this.currentSkin).initializeNow();
                    }
                    if (this.currentSkin is feathers.core.IMeasureDisplayObject) 
                    {
                        loc2 = feathers.core.IMeasureDisplayObject(this.currentSkin);
                        this._explicitSkinWidth = loc2.explicitWidth;
                        this._explicitSkinHeight = loc2.explicitHeight;
                        this._explicitSkinMinWidth = loc2.explicitMinWidth;
                        this._explicitSkinMinHeight = loc2.explicitMinHeight;
                        this._explicitSkinMaxWidth = loc2.explicitMaxWidth;
                        this._explicitSkinMaxHeight = loc2.explicitMaxHeight;
                    }
                    else 
                    {
                        this._explicitSkinWidth = this.currentSkin.width;
                        this._explicitSkinHeight = this.currentSkin.height;
                        this._explicitSkinMinWidth = this._explicitSkinWidth;
                        this._explicitSkinMinHeight = this._explicitSkinHeight;
                        this._explicitSkinMaxWidth = this._explicitSkinWidth;
                        this._explicitSkinMaxHeight = this._explicitSkinHeight;
                    }
                    if (this.currentSkin is feathers.core.IStateObserver) 
                    {
                        feathers.core.IStateObserver(this.currentSkin).stateContext = this;
                    }
                    this.addChildAt(this.currentSkin, 0);
                }
            }
            return;
        }

        internal static const HELPER_POINT:flash.geom.Point=new flash.geom.Point();

        protected var tapToTrigger:feathers.utils.touch.TapToTrigger;

        protected var touchPointID:int=-1;

        protected var _currentState:String="up";

        protected var currentSkin:starling.display.DisplayObject;

        protected var _keepDownStateOnRollOut:Boolean=false;

        protected var _defaultSkin:starling.display.DisplayObject;

        protected var _stateToSkin:Object;

        protected var _explicitSkinMaxHeight:Number;

        protected var _explicitSkinHeight:Number;

        protected var _explicitSkinWidth:Number;

        protected var _explicitSkinMinWidth:Number;

        protected var _explicitSkinMinHeight:Number;

        protected var _explicitSkinMaxWidth:Number;

        public static var globalStyleProvider:feathers.skins.IStyleProvider;
    }
}


