//class FeathersControl
package feathers.core 
{
    import feathers.controls.text.*;
    import feathers.events.*;
    import feathers.layout.*;
    import feathers.skins.*;
    import feathers.utils.display.*;
    import flash.errors.*;
    import flash.geom.*;
    import flash.utils.*;
    import starling.core.*;
    import starling.display.*;
    import starling.events.*;
    import starling.utils.*;
    
    public class FeathersControl extends starling.display.Sprite implements feathers.core.IFeathersControl, feathers.layout.ILayoutDisplayObject
    {
        public function FeathersControl()
        {
            this._styleNameList = new feathers.core.TokenList();
            this._hitArea = new flash.geom.Rectangle();
            this._invalidationFlags = {};
            this._delayedInvalidationFlags = {};
            super();
            if (Object(this).constructor == feathers.core.FeathersControl) 
            {
                throw new Error(ABSTRACT_CLASS_ERROR);
            }
            this._styleProvider = this.defaultStyleProvider;
            this.addEventListener(starling.events.Event.ADDED_TO_STAGE, this.feathersControl_addedToStageHandler);
            this.addEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.feathersControl_removedFromStageHandler);
            if (this is feathers.core.IFocusDisplayObject) 
            {
                this.addEventListener(feathers.events.FeathersEventType.FOCUS_IN, this.focusInHandler);
                this.addEventListener(feathers.events.FeathersEventType.FOCUS_OUT, this.focusOutHandler);
            }
            return;
        }

        public function set focusPaddingBottom(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._focusPaddingBottom === arg1) 
            {
                return;
            }
            this._focusPaddingBottom = arg1;
            this.invalidate(INVALIDATION_FLAG_FOCUS);
            return;
        }

        public function get focusPaddingLeft():Number
        {
            return this._focusPaddingLeft;
        }

        public function get id():String
        {
            return this._id;
        }

        public function set id(arg1:String):void
        {
            this._id = arg1;
            return;
        }

        public function get styleName():String
        {
            return this._styleNameList.value;
        }

        public function set styleName(arg1:String):void
        {
            this._styleNameList.value = arg1;
            return;
        }

        public function set focusPaddingLeft(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._focusPaddingLeft === arg1) 
            {
                return;
            }
            this._focusPaddingLeft = arg1;
            this.invalidate(INVALIDATION_FLAG_FOCUS);
            return;
        }

        public function get styleNameList():feathers.core.TokenList
        {
            return this._styleNameList;
        }

        public function get isCreated():Boolean
        {
            return this._hasValidated;
        }

        public function get styleProvider():feathers.skins.IStyleProvider
        {
            return this._styleProvider;
        }

        public function set styleProvider(arg1:feathers.skins.IStyleProvider):void
        {
            if (this._styleProvider === arg1) 
            {
                return;
            }
            if (this._applyingStyles) 
            {
                throw new flash.errors.IllegalOperationError("Cannot change styleProvider while the current style provider is applying styles.");
            }
            this._styleProvider = arg1;
            if (!(this._styleProvider === null) && this.isInitialized) 
            {
                this._applyingStyles = true;
                this._styleProvider.applyStyles(this);
                this._applyingStyles = false;
            }
            return;
        }

        protected function get defaultStyleProvider():feathers.skins.IStyleProvider
        {
            return null;
        }

        public function get depth():int
        {
            return this._depth;
        }

        public function get isQuickHitAreaEnabled():Boolean
        {
            return this._isQuickHitAreaEnabled;
        }

        public function set isQuickHitAreaEnabled(arg1:Boolean):void
        {
            this._isQuickHitAreaEnabled = arg1;
            return;
        }

        public override function getBounds(arg1:starling.display.DisplayObject, arg2:flash.geom.Rectangle=null):flash.geom.Rectangle
        {
            var loc5:*=null;
            if (!arg2) 
            {
                arg2 = new flash.geom.Rectangle();
            }
            var loc1:*=Number.MAX_VALUE;
            var loc2:*=-Number.MAX_VALUE;
            var loc3:*=Number.MAX_VALUE;
            var loc4:*=-Number.MAX_VALUE;
            if (arg1 != this) 
            {
                loc5 = starling.utils.Pool.getMatrix();
                this.getTransformationMatrix(arg1, loc5);
                starling.utils.MatrixUtil.transformCoords(loc5, 0, 0, HELPER_POINT);
                loc1 = loc1 < HELPER_POINT.x ? loc1 : HELPER_POINT.x;
                loc2 = loc2 > HELPER_POINT.x ? loc2 : HELPER_POINT.x;
                loc3 = loc3 < HELPER_POINT.y ? loc3 : HELPER_POINT.y;
                loc4 = loc4 > HELPER_POINT.y ? loc4 : HELPER_POINT.y;
                starling.utils.MatrixUtil.transformCoords(loc5, 0, this.actualHeight, HELPER_POINT);
                loc1 = loc1 < HELPER_POINT.x ? loc1 : HELPER_POINT.x;
                loc2 = loc2 > HELPER_POINT.x ? loc2 : HELPER_POINT.x;
                loc3 = loc3 < HELPER_POINT.y ? loc3 : HELPER_POINT.y;
                loc4 = loc4 > HELPER_POINT.y ? loc4 : HELPER_POINT.y;
                starling.utils.MatrixUtil.transformCoords(loc5, this.actualWidth, 0, HELPER_POINT);
                loc1 = loc1 < HELPER_POINT.x ? loc1 : HELPER_POINT.x;
                loc2 = loc2 > HELPER_POINT.x ? loc2 : HELPER_POINT.x;
                loc3 = loc3 < HELPER_POINT.y ? loc3 : HELPER_POINT.y;
                loc4 = loc4 > HELPER_POINT.y ? loc4 : HELPER_POINT.y;
                starling.utils.MatrixUtil.transformCoords(loc5, this.actualWidth, this.actualHeight, HELPER_POINT);
                loc1 = loc1 < HELPER_POINT.x ? loc1 : HELPER_POINT.x;
                loc2 = loc2 > HELPER_POINT.x ? loc2 : HELPER_POINT.x;
                loc3 = loc3 < HELPER_POINT.y ? loc3 : HELPER_POINT.y;
                loc4 = loc4 > HELPER_POINT.y ? loc4 : HELPER_POINT.y;
                starling.utils.Pool.putMatrix(loc5);
            }
            else 
            {
                loc1 = 0;
                loc3 = 0;
                loc2 = this.actualWidth;
                loc4 = this.actualHeight;
            }
            arg2.x = loc1;
            arg2.y = loc3;
            arg2.width = loc2 - loc1;
            arg2.height = loc4 - loc3;
            return arg2;
        }

        public override function hitTest(arg1:flash.geom.Point):starling.display.DisplayObject
        {
            if (this._isQuickHitAreaEnabled) 
            {
                if (!this.visible || !this.touchable) 
                {
                    return null;
                }
                if (this.mask && !this.hitTestMask(arg1)) 
                {
                    return null;
                }
                return this._hitArea.containsPoint(arg1) ? this : null;
            }
            return super.hitTest(arg1);
        }

        public override function dispose():void
        {
            this._isDisposed = true;
            this._validationQueue = null;
            super.dispose();
            return;
        }

        public function get isInitialized():Boolean
        {
            return this._isInitialized;
        }

        public function set focusPaddingRight(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._focusPaddingRight === arg1) 
            {
                return;
            }
            this._focusPaddingRight = arg1;
            this.invalidate(INVALIDATION_FLAG_FOCUS);
            return;
        }

        public function invalidate(arg1:String="all"):void
        {
            var loc3:*=null;
            var loc1:*=this.isInvalid();
            var loc2:*=false;
            if (this._isValidating) 
            {
                var loc4:*=0;
                var loc5:*=this._delayedInvalidationFlags;
                for (loc3 in loc5) 
                {
                    loc2 = true;
                    break;
                }
            }
            if (!arg1 || arg1 == INVALIDATION_FLAG_ALL) 
            {
                if (this._isValidating) 
                {
                    this._delayedInvalidationFlags[INVALIDATION_FLAG_ALL] = true;
                }
                else 
                {
                    this._isAllInvalid = true;
                }
            }
            else if (this._isValidating) 
            {
                this._delayedInvalidationFlags[arg1] = true;
            }
            else if (!(arg1 == INVALIDATION_FLAG_ALL) && !this._invalidationFlags.hasOwnProperty(arg1)) 
            {
                this._invalidationFlags[arg1] = true;
            }
            if (this._validationQueue === null || !this._isInitialized) 
            {
                return;
            }
            if (this._isValidating) 
            {
                if (loc2) 
                {
                    return;
                }
                loc5 = ((loc4 = this)._invalidateCount + 1);
                loc4._invalidateCount = loc5;
                if (this._invalidateCount >= 10) 
                {
                    throw new Error(flash.utils.getQualifiedClassName(this) + " returned to validation queue too many times during validation. This may be an infinite loop. Try to avoid doing anything that calls invalidate() during validation.");
                }
                this._validationQueue.addControl(this);
                return;
            }
            if (loc1) 
            {
                return;
            }
            this._invalidateCount = 0;
            this._validationQueue.addControl(this);
            return;
        }

        public function validate():void
        {
            var loc1:*=null;
            if (this._isDisposed) 
            {
                return;
            }
            if (!this._isInitialized) 
            {
                if (this._isInitializing) 
                {
                    return;
                }
                this.initializeNow();
            }
            if (!this.isInvalid()) 
            {
                return;
            }
            if (this._isValidating) 
            {
                return;
            }
            this._isValidating = true;
            this.draw();
            var loc2:*=0;
            var loc3:*=this._invalidationFlags;
            for (loc1 in loc3) 
            {
                delete this._invalidationFlags[loc1];
            }
            this._isAllInvalid = false;
            loc2 = 0;
            loc3 = this._delayedInvalidationFlags;
            for (loc1 in loc3) 
            {
                if (loc1 != INVALIDATION_FLAG_ALL) 
                {
                    this._invalidationFlags[loc1] = true;
                }
                else 
                {
                    this._isAllInvalid = true;
                }
                delete this._delayedInvalidationFlags[loc1];
            }
            this._isValidating = false;
            if (!this._hasValidated) 
            {
                this._hasValidated = true;
                this.dispatchEventWith(feathers.events.FeathersEventType.CREATION_COMPLETE);
            }
            return;
        }

        public function isInvalid(arg1:String=null):Boolean
        {
            if (this._isAllInvalid) 
            {
                return true;
            }
            if (!arg1) 
            {
                var loc1:*=0;
                var loc2:*=this._invalidationFlags;
                for (arg1 in loc2) 
                {
                    return true;
                }
                return false;
            }
            return this._invalidationFlags[arg1];
        }

        public function setSize(arg1:Number, arg2:Number):void
        {
            var loc3:*=false;
            this._explicitWidth = arg1;
            var loc1:*=!(arg1 === arg1);
            if (loc1) 
            {
                var loc4:*;
                this.scaledActualWidth = loc4 = 0;
                this.actualWidth = loc4;
            }
            this._explicitHeight = arg2;
            var loc2:*=!(arg2 === arg2);
            if (loc2) 
            {
                this.scaledActualHeight = loc4 = 0;
                this.actualHeight = loc4;
            }
            if (loc1 || loc2) 
            {
                this.invalidate(INVALIDATION_FLAG_SIZE);
            }
            else 
            {
                loc3 = this.saveMeasurements(arg1, arg2, this.actualMinWidth, this.actualMinHeight);
                if (loc3) 
                {
                    this.invalidate(INVALIDATION_FLAG_SIZE);
                }
            }
            return;
        }

        public function move(arg1:Number, arg2:Number):void
        {
            this.x = arg1;
            this.y = arg2;
            return;
        }

        public function get isEnabled():Boolean
        {
            return this._isEnabled;
        }

        public function set isEnabled(arg1:Boolean):void
        {
            if (this._isEnabled == arg1) 
            {
                return;
            }
            this._isEnabled = arg1;
            this.invalidate(INVALIDATION_FLAG_STATE);
            return;
        }

        public function resetStyleProvider():void
        {
            this.styleProvider = this.defaultStyleProvider;
            return;
        }

        public function get explicitWidth():Number
        {
            return this._explicitWidth;
        }

        public function showFocus():void
        {
            if (!this._hasFocus || !this._focusIndicatorSkin) 
            {
                return;
            }
            this._showFocus = true;
            this.invalidate(INVALIDATION_FLAG_FOCUS);
            return;
        }

        public function hideFocus():void
        {
            if (!this._hasFocus || !this._focusIndicatorSkin) 
            {
                return;
            }
            this._showFocus = false;
            this.invalidate(INVALIDATION_FLAG_FOCUS);
            return;
        }

        public override function get width():Number
        {
            return this.scaledActualWidth;
        }

        public override function set width(arg1:Number):void
        {
            var loc2:*=false;
            var loc1:*=!(arg1 === arg1);
            if (loc1 && !(this._explicitWidth === this._explicitWidth)) 
            {
                return;
            }
            if (this.scaleX !== 1) 
            {
                arg1 = arg1 / this.scaleX;
            }
            if (this._explicitWidth == arg1) 
            {
                return;
            }
            this._explicitWidth = arg1;
            if (loc1) 
            {
                var loc3:*;
                this.scaledActualWidth = loc3 = 0;
                this.actualWidth = loc3;
                this.invalidate(INVALIDATION_FLAG_SIZE);
            }
            else 
            {
                loc2 = this.saveMeasurements(arg1, this.actualHeight, this.actualMinWidth, this.actualMinHeight);
                if (loc2) 
                {
                    this.invalidate(INVALIDATION_FLAG_SIZE);
                }
            }
            return;
        }

        public function initializeNow():void
        {
            if (this._isInitialized || this._isInitializing) 
            {
                return;
            }
            this._isInitializing = true;
            this.initialize();
            this.invalidate();
            this._isInitializing = false;
            this._isInitialized = true;
            this.dispatchEventWith(feathers.events.FeathersEventType.INITIALIZE);
            if (this._styleProvider !== null) 
            {
                this._applyingStyles = true;
                this._styleProvider.applyStyles(this);
                this._applyingStyles = false;
            }
            this._styleNameList.addEventListener(starling.events.Event.CHANGE, this.styleNameList_changeHandler);
            return;
        }

        public function get explicitHeight():Number
        {
            return this._explicitHeight;
        }

        protected function setSizeInternal(arg1:Number, arg2:Number, arg3:Boolean):Boolean
        {
            var loc1:*=this.saveMeasurements(arg1, arg2, this.actualMinWidth, this.actualMinHeight);
            if (arg3 && loc1) 
            {
                this.invalidate(INVALIDATION_FLAG_SIZE);
            }
            return loc1;
        }

        protected function saveMeasurements(arg1:Number, arg2:Number, arg3:Number=0, arg4:Number=0):Boolean
        {
            if (this._explicitMinWidth === this._explicitMinWidth) 
            {
                arg3 = this._explicitMinWidth;
            }
            if (this._explicitMinHeight === this._explicitMinHeight) 
            {
                arg4 = this._explicitMinHeight;
            }
            if (this._explicitWidth !== this._explicitWidth) 
            {
                if (arg1 < arg3) 
                {
                    arg1 = arg3;
                }
                else if (arg1 > this._explicitMaxWidth) 
                {
                    arg1 = this._explicitMaxWidth;
                }
            }
            else 
            {
                arg1 = this._explicitWidth;
            }
            if (this._explicitHeight !== this._explicitHeight) 
            {
                if (arg2 < arg4) 
                {
                    arg2 = arg4;
                }
                else if (arg2 > this._explicitMaxHeight) 
                {
                    arg2 = this._explicitMaxHeight;
                }
            }
            else 
            {
                arg2 = this._explicitHeight;
            }
            if (arg1 !== arg1) 
            {
                throw new ArgumentError(ILLEGAL_WIDTH_ERROR);
            }
            if (arg2 !== arg2) 
            {
                throw new ArgumentError(ILLEGAL_HEIGHT_ERROR);
            }
            var loc1:*=this.scaleX;
            if (loc1 < 0) 
            {
                loc1 = -loc1;
            }
            var loc2:*=this.scaleY;
            if (loc2 < 0) 
            {
                loc2 = -loc2;
            }
            var loc3:*=false;
            if (this.actualWidth !== arg1) 
            {
                this.actualWidth = arg1;
                this.refreshHitAreaX();
                loc3 = true;
            }
            if (this.actualHeight !== arg2) 
            {
                this.actualHeight = arg2;
                this.refreshHitAreaY();
                loc3 = true;
            }
            if (this.actualMinWidth !== arg3) 
            {
                this.actualMinWidth = arg3;
                loc3 = true;
            }
            if (this.actualMinHeight !== arg4) 
            {
                this.actualMinHeight = arg4;
                loc3 = true;
            }
            arg1 = this.scaledActualWidth;
            arg2 = this.scaledActualHeight;
            this.scaledActualWidth = this.actualWidth * loc1;
            this.scaledActualHeight = this.actualHeight * loc2;
            this.scaledActualMinWidth = this.actualMinWidth * loc1;
            this.scaledActualMinHeight = this.actualMinHeight * loc2;
            if (!(arg1 === this.scaledActualWidth) || !(arg2 === this.scaledActualHeight)) 
            {
                loc3 = true;
                this.dispatchEventWith(starling.events.Event.RESIZE);
            }
            return loc3;
        }

        public override function get height():Number
        {
            return this.scaledActualHeight;
        }

        public override function set height(arg1:Number):void
        {
            var loc2:*=false;
            var loc1:*=!(arg1 === arg1);
            if (loc1 && !(this._explicitHeight === this._explicitHeight)) 
            {
                return;
            }
            if (this.scaleY !== 1) 
            {
                arg1 = arg1 / this.scaleY;
            }
            if (this._explicitHeight == arg1) 
            {
                return;
            }
            this._explicitHeight = arg1;
            if (loc1) 
            {
                var loc3:*;
                this.scaledActualHeight = loc3 = 0;
                this.actualHeight = loc3;
                this.invalidate(INVALIDATION_FLAG_SIZE);
            }
            else 
            {
                loc2 = this.saveMeasurements(this.actualWidth, arg1, this.actualMinWidth, this.actualMinHeight);
                if (loc2) 
                {
                    this.invalidate(INVALIDATION_FLAG_SIZE);
                }
            }
            return;
        }

        protected function initialize():void
        {
            return;
        }

        public function get minTouchWidth():Number
        {
            return this._minTouchWidth;
        }

        public function set minTouchWidth(arg1:Number):void
        {
            if (this._minTouchWidth == arg1) 
            {
                return;
            }
            this._minTouchWidth = arg1;
            this.refreshHitAreaX();
            return;
        }

        protected function draw():void
        {
            return;
        }

        public function get minTouchHeight():Number
        {
            return this._minTouchHeight;
        }

        public function set minTouchHeight(arg1:Number):void
        {
            if (this._minTouchHeight == arg1) 
            {
                return;
            }
            this._minTouchHeight = arg1;
            this.refreshHitAreaY();
            return;
        }

        protected function setInvalidationFlag(arg1:String):void
        {
            if (this._invalidationFlags.hasOwnProperty(arg1)) 
            {
                return;
            }
            this._invalidationFlags[arg1] = true;
            return;
        }

        public function get explicitMinWidth():Number
        {
            return this._explicitMinWidth;
        }

        protected function clearInvalidationFlag(arg1:String):void
        {
            delete this._invalidationFlags[arg1];
            return;
        }

        protected function processStyleRestriction(arg1:Object):Boolean
        {
            if (this._applyingStyles) 
            {
                return !(this._restrictedStyles === null) && arg1 in this._restrictedStyles;
            }
            if (this._restrictedStyles === null) 
            {
                this._restrictedStyles = new flash.utils.Dictionary();
            }
            this._restrictedStyles[arg1] = true;
            return false;
        }

        public function get minWidth():Number
        {
            return this.scaledActualMinWidth;
        }

        public function set minWidth(arg1:Number):void
        {
            var loc1:*=!(arg1 === arg1);
            if (loc1 && !(this._explicitMinWidth === this._explicitMinWidth)) 
            {
                return;
            }
            if (this.scaleX !== 1) 
            {
                arg1 = arg1 / this.scaleX;
            }
            if (this._explicitMinWidth == arg1) 
            {
                return;
            }
            var loc2:*=this._explicitMinWidth;
            this._explicitMinWidth = arg1;
            if (loc1) 
            {
                var loc3:*;
                this.scaledActualMinWidth = loc3 = 0;
                this.actualMinWidth = loc3;
                this.invalidate(INVALIDATION_FLAG_SIZE);
            }
            else 
            {
                this.saveMeasurements(this.actualWidth, this.actualHeight, arg1, this.actualMinHeight);
                if (!(this._explicitWidth === this._explicitWidth) && (this.actualWidth < arg1 || this.actualWidth === loc2)) 
                {
                    this.invalidate(INVALIDATION_FLAG_SIZE);
                }
            }
            return;
        }

        protected function refreshFocusIndicator():void
        {
            if (this._focusIndicatorSkin) 
            {
                if (this._hasFocus && this._showFocus) 
                {
                    if (this._focusIndicatorSkin.parent == this) 
                    {
                        this.setChildIndex(this._focusIndicatorSkin, (this.numChildren - 1));
                    }
                    else 
                    {
                        this.addChild(this._focusIndicatorSkin);
                    }
                }
                else if (this._focusIndicatorSkin.parent) 
                {
                    this._focusIndicatorSkin.removeFromParent(false);
                }
                this._focusIndicatorSkin.x = this._focusPaddingLeft;
                this._focusIndicatorSkin.y = this._focusPaddingTop;
                this._focusIndicatorSkin.width = this.actualWidth - this._focusPaddingLeft - this._focusPaddingRight;
                this._focusIndicatorSkin.height = this.actualHeight - this._focusPaddingTop - this._focusPaddingBottom;
            }
            return;
        }

        public function get explicitMinHeight():Number
        {
            return this._explicitMinHeight;
        }

        protected function refreshHitAreaX():void
        {
            if (this.actualWidth < this._minTouchWidth) 
            {
                this._hitArea.width = this._minTouchWidth;
            }
            else 
            {
                this._hitArea.width = this.actualWidth;
            }
            var loc1:*=(this.actualWidth - this._hitArea.width) / 2;
            if (loc1 === loc1) 
            {
                this._hitArea.x = loc1;
            }
            else 
            {
                this._hitArea.x = 0;
            }
            return;
        }

        protected function refreshHitAreaY():void
        {
            if (this.actualHeight < this._minTouchHeight) 
            {
                this._hitArea.height = this._minTouchHeight;
            }
            else 
            {
                this._hitArea.height = this.actualHeight;
            }
            var loc1:*=(this.actualHeight - this._hitArea.height) / 2;
            if (loc1 === loc1) 
            {
                this._hitArea.y = loc1;
            }
            else 
            {
                this._hitArea.y = 0;
            }
            return;
        }

        public function get minHeight():Number
        {
            return this.scaledActualMinHeight;
        }

        public function set minHeight(arg1:Number):void
        {
            var loc1:*=!(arg1 === arg1);
            if (loc1 && !(this._explicitMinHeight === this._explicitMinHeight)) 
            {
                return;
            }
            if (this.scaleY !== 1) 
            {
                arg1 = arg1 / this.scaleY;
            }
            if (this._explicitMinHeight == arg1) 
            {
                return;
            }
            var loc2:*=this._explicitMinHeight;
            this._explicitMinHeight = arg1;
            if (loc1) 
            {
                var loc3:*;
                this.scaledActualMinHeight = loc3 = 0;
                this.actualMinHeight = loc3;
                this.invalidate(INVALIDATION_FLAG_SIZE);
            }
            else 
            {
                this.saveMeasurements(this.actualWidth, this.actualHeight, this.actualMinWidth, arg1);
                if (!(this._explicitHeight === this._explicitHeight) && (this.actualHeight < arg1 || this.actualHeight === loc2)) 
                {
                    this.invalidate(INVALIDATION_FLAG_SIZE);
                }
            }
            return;
        }

        protected function focusInHandler(arg1:starling.events.Event):void
        {
            this._hasFocus = true;
            this.invalidate(INVALIDATION_FLAG_FOCUS);
            return;
        }

        public function get explicitMaxWidth():Number
        {
            return this._explicitMaxWidth;
        }

        public function get maxWidth():Number
        {
            return this._explicitMaxWidth;
        }

        public function set maxWidth(arg1:Number):void
        {
            if (arg1 < 0) 
            {
                arg1 = 0;
            }
            if (this._explicitMaxWidth == arg1) 
            {
                return;
            }
            if (arg1 !== arg1) 
            {
                throw new ArgumentError("maxWidth cannot be NaN");
            }
            var loc1:*=this._explicitMaxWidth;
            this._explicitMaxWidth = arg1;
            if (!(this._explicitWidth === this._explicitWidth) && (this.actualWidth > arg1 || this.actualWidth === loc1)) 
            {
                this.invalidate(INVALIDATION_FLAG_SIZE);
            }
            return;
        }

        public function set focusOwner(arg1:feathers.core.IFocusDisplayObject):void
        {
            this._focusOwner = arg1;
            return;
        }

        public function get explicitMaxHeight():Number
        {
            return this._explicitMaxHeight;
        }

        public function get maxHeight():Number
        {
            return this._explicitMaxHeight;
        }

        public function set maxHeight(arg1:Number):void
        {
            if (arg1 < 0) 
            {
                arg1 = 0;
            }
            if (this._explicitMaxHeight == arg1) 
            {
                return;
            }
            if (arg1 !== arg1) 
            {
                throw new ArgumentError("maxHeight cannot be NaN");
            }
            var loc1:*=this._explicitMaxHeight;
            this._explicitMaxHeight = arg1;
            if (!(this._explicitHeight === this._explicitHeight) && (this.actualHeight > arg1 || this.actualHeight === loc1)) 
            {
                this.invalidate(INVALIDATION_FLAG_SIZE);
            }
            return;
        }

        public override function set scaleX(arg1:Number):void
        {
            super.scaleX = arg1;
            this.saveMeasurements(this.actualWidth, this.actualHeight, this.actualMinWidth, this.actualMinHeight);
            return;
        }

        public override function set scaleY(arg1:Number):void
        {
            super.scaleY = arg1;
            this.saveMeasurements(this.actualWidth, this.actualHeight, this.actualMinWidth, this.actualMinHeight);
            return;
        }

        protected function focusOutHandler(arg1:starling.events.Event):void
        {
            this._hasFocus = false;
            this._showFocus = false;
            this.invalidate(INVALIDATION_FLAG_FOCUS);
            return;
        }

        public function get includeInLayout():Boolean
        {
            return this._includeInLayout;
        }

        public function set includeInLayout(arg1:Boolean):void
        {
            if (this._includeInLayout == arg1) 
            {
                return;
            }
            this._includeInLayout = arg1;
            this.dispatchEventWith(feathers.events.FeathersEventType.LAYOUT_DATA_CHANGE);
            return;
        }

        protected function feathersControl_addedToStageHandler(arg1:starling.events.Event):void
        {
            this._depth = feathers.utils.display.getDisplayObjectDepthFromStage(this);
            var loc1:*=feathers.utils.display.stageToStarling(this.stage);
            this._validationQueue = feathers.core.ValidationQueue.forStarling(loc1);
            if (!this._isInitialized) 
            {
                this.initializeNow();
            }
            if (this.isInvalid()) 
            {
                this._invalidateCount = 0;
                this._validationQueue.addControl(this);
            }
            return;
        }

        public function get layoutData():feathers.layout.ILayoutData
        {
            return this._layoutData;
        }

        public function set layoutData(arg1:feathers.layout.ILayoutData):void
        {
            if (this._layoutData == arg1) 
            {
                return;
            }
            if (this._layoutData) 
            {
                this._layoutData.removeEventListener(starling.events.Event.CHANGE, this.layoutData_changeHandler);
            }
            this._layoutData = arg1;
            if (this._layoutData) 
            {
                this._layoutData.addEventListener(starling.events.Event.CHANGE, this.layoutData_changeHandler);
            }
            this.dispatchEventWith(feathers.events.FeathersEventType.LAYOUT_DATA_CHANGE);
            return;
        }

        protected function feathersControl_removedFromStageHandler(arg1:starling.events.Event):void
        {
            this._depth = -1;
            this._validationQueue = null;
            return;
        }

        public function get toolTip():String
        {
            return this._toolTip;
        }

        public function set toolTip(arg1:String):void
        {
            this._toolTip = arg1;
            return;
        }

        protected function styleNameList_changeHandler(arg1:starling.events.Event):void
        {
            if (this._styleProvider === null) 
            {
                return;
            }
            if (this._applyingStyles) 
            {
                throw new flash.errors.IllegalOperationError("Cannot change styleNameList while the style provider is applying styles.");
            }
            this._applyingStyles = true;
            this._styleProvider.applyStyles(this);
            this._applyingStyles = false;
            return;
        }

        public function get focusManager():feathers.core.IFocusManager
        {
            return this._focusManager;
        }

        public function set focusManager(arg1:feathers.core.IFocusManager):void
        {
            if (!(this is feathers.core.IFocusDisplayObject)) 
            {
                throw new flash.errors.IllegalOperationError("Cannot pass a focus manager to a component that does not implement feathers.core.IFocusDisplayObject");
            }
            if (this._focusManager == arg1) 
            {
                return;
            }
            this._focusManager = arg1;
            return;
        }

        
        {
            defaultTextRendererFactory = function ():feathers.core.ITextRenderer
            {
                return new feathers.controls.text.BitmapFontTextRenderer();
            }
            defaultTextEditorFactory = function ():feathers.core.ITextEditor
            {
                return new feathers.controls.text.StageTextTextEditor();
            }
        }

        public function get focusOwner():feathers.core.IFocusDisplayObject
        {
            return this._focusOwner;
        }

        protected function layoutData_changeHandler(arg1:starling.events.Event):void
        {
            this.dispatchEventWith(feathers.events.FeathersEventType.LAYOUT_DATA_CHANGE);
            return;
        }

        public function get isFocusEnabled():Boolean
        {
            return this._isEnabled && this._isFocusEnabled;
        }

        public function set isFocusEnabled(arg1:Boolean):void
        {
            if (!(this is feathers.core.IFocusDisplayObject)) 
            {
                throw new flash.errors.IllegalOperationError("Cannot enable focus on a component that does not implement feathers.core.IFocusDisplayObject");
            }
            if (this._isFocusEnabled == arg1) 
            {
                return;
            }
            this._isFocusEnabled = arg1;
            return;
        }

        public function get nextTabFocus():feathers.core.IFocusDisplayObject
        {
            return this._nextTabFocus;
        }

        public function set nextTabFocus(arg1:feathers.core.IFocusDisplayObject):void
        {
            if (!(this is feathers.core.IFocusDisplayObject)) 
            {
                throw new flash.errors.IllegalOperationError("Cannot set next tab focus on a component that does not implement feathers.core.IFocusDisplayObject");
            }
            this._nextTabFocus = arg1;
            return;
        }

        public function get previousTabFocus():feathers.core.IFocusDisplayObject
        {
            return this._previousTabFocus;
        }

        public function set previousTabFocus(arg1:feathers.core.IFocusDisplayObject):void
        {
            if (!(this is feathers.core.IFocusDisplayObject)) 
            {
                throw new flash.errors.IllegalOperationError("Cannot set previous tab focus on a component that does not implement feathers.core.IFocusDisplayObject");
            }
            this._previousTabFocus = arg1;
            return;
        }

        public function get focusIndicatorSkin():starling.display.DisplayObject
        {
            return this._focusIndicatorSkin;
        }

        public function set focusIndicatorSkin(arg1:starling.display.DisplayObject):void
        {
            if (!(this is feathers.core.IFocusDisplayObject)) 
            {
                throw new flash.errors.IllegalOperationError("Cannot set focus indicator skin on a component that does not implement feathers.core.IFocusDisplayObject");
            }
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._focusIndicatorSkin === arg1) 
            {
                return;
            }
            if (this._focusIndicatorSkin) 
            {
                if (this._focusIndicatorSkin.parent == this) 
                {
                    this._focusIndicatorSkin.removeFromParent(false);
                }
                if (this._focusIndicatorSkin is feathers.core.IStateObserver && this is feathers.core.IStateContext) 
                {
                    feathers.core.IStateObserver(this._focusIndicatorSkin).stateContext = null;
                }
            }
            this._focusIndicatorSkin = arg1;
            if (this._focusIndicatorSkin) 
            {
                this._focusIndicatorSkin.touchable = false;
            }
            if (this._focusIndicatorSkin is feathers.core.IStateObserver && this is feathers.core.IStateContext) 
            {
                feathers.core.IStateObserver(this._focusIndicatorSkin).stateContext = feathers.core.IStateContext(this);
            }
            if (this._focusManager && this._focusManager.focus == this) 
            {
                this.invalidate(INVALIDATION_FLAG_STYLES);
            }
            return;
        }

        public function get focusPadding():Number
        {
            return this._focusPaddingTop;
        }

        public function set focusPadding(arg1:Number):void
        {
            this.focusPaddingTop = arg1;
            this.focusPaddingRight = arg1;
            this.focusPaddingBottom = arg1;
            this.focusPaddingLeft = arg1;
            return;
        }

        public function get focusPaddingTop():Number
        {
            return this._focusPaddingTop;
        }

        public function set focusPaddingTop(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._focusPaddingTop === arg1) 
            {
                return;
            }
            this._focusPaddingTop = arg1;
            this.invalidate(INVALIDATION_FLAG_FOCUS);
            return;
        }

        public function get focusPaddingRight():Number
        {
            return this._focusPaddingRight;
        }

        public function get focusPaddingBottom():Number
        {
            return this._focusPaddingBottom;
        }

        public static const INVALIDATION_FLAG_FOCUS:String="focus";

        internal static const HELPER_POINT:flash.geom.Point=new flash.geom.Point();

        public static const INVALIDATION_FLAG_ALL:String="all";

        public static const INVALIDATION_FLAG_STATE:String="state";

        public static const INVALIDATION_FLAG_SIZE:String="size";

        public static const INVALIDATION_FLAG_STYLES:String="styles";

        public static const INVALIDATION_FLAG_SKIN:String="skin";

        public static const INVALIDATION_FLAG_LAYOUT:String="layout";

        public static const INVALIDATION_FLAG_DATA:String="data";

        public static const INVALIDATION_FLAG_SCROLL:String="scroll";

        public static const INVALIDATION_FLAG_SELECTED:String="selected";

        protected static const INVALIDATION_FLAG_TEXT_RENDERER:String="textRenderer";

        protected static const INVALIDATION_FLAG_TEXT_EDITOR:String="textEditor";

        protected static const ILLEGAL_WIDTH_ERROR:String="A component\'s width cannot be NaN.";

        protected static const ILLEGAL_HEIGHT_ERROR:String="A component\'s height cannot be NaN.";

        protected static const ABSTRACT_CLASS_ERROR:String="FeathersControl is an abstract class. For a lightweight Feathers wrapper, use feathers.controls.LayoutGroup.";

        protected var _explicitHeight:Number=NaN;

        protected var actualHeight:Number=0;

        protected var scaledActualHeight:Number=0;

        protected var _minTouchWidth:Number=0;

        protected var _minTouchHeight:Number=0;

        protected var _explicitMinWidth:Number=NaN;

        protected var actualMinWidth:Number=0;

        protected var scaledActualMinWidth:Number=0;

        protected var _explicitMinHeight:Number=NaN;

        protected var actualMinHeight:Number=0;

        protected var scaledActualMinHeight:Number=0;

        protected var _explicitMaxWidth:Number=Infinity;

        protected var _includeInLayout:Boolean=true;

        protected var _layoutData:feathers.layout.ILayoutData;

        protected var _toolTip:String;

        protected var _focusManager:feathers.core.IFocusManager;

        protected var _focusOwner:feathers.core.IFocusDisplayObject;

        protected var _depth:int=-1;

        protected var _restrictedStyles:flash.utils.Dictionary;

        protected var _invalidateCount:int=0;

        protected var _explicitMaxHeight:Number=Infinity;

        protected var _focusPaddingBottom:Number=0;

        protected var _isDisposed:Boolean=false;

        protected var _focusIndicatorSkin:starling.display.DisplayObject;

        protected var _focusPaddingTop:Number=0;

        protected var _focusPaddingLeft:Number=0;

        protected var _previousTabFocus:feathers.core.IFocusDisplayObject;

        protected var _isFocusEnabled:Boolean=true;

        protected var _hasFocus:Boolean=false;

        protected var _showFocus:Boolean=false;

        protected var _isValidating:Boolean=false;

        protected var _applyingStyles:Boolean=false;

        protected var _hasValidated:Boolean=false;

        protected var _validationQueue:feathers.core.ValidationQueue;

        protected var _id:String;

        protected var _styleNameList:feathers.core.TokenList;

        protected var _styleProvider:feathers.skins.IStyleProvider;

        protected var _isQuickHitAreaEnabled:Boolean=false;

        protected var _hitArea:flash.geom.Rectangle;

        protected var _isInitializing:Boolean=false;

        protected var _isInitialized:Boolean=false;

        protected var _isAllInvalid:Boolean=false;

        protected var _invalidationFlags:Object;

        protected var _nextTabFocus:feathers.core.IFocusDisplayObject;

        protected var _delayedInvalidationFlags:Object;

        protected var _isEnabled:Boolean=true;

        protected var _explicitWidth:Number=NaN;

        protected var actualWidth:Number=0;

        protected var scaledActualWidth:Number=0;

        public static var defaultTextRendererFactory:Function;

        public static var defaultTextEditorFactory:Function;

        protected var _focusPaddingRight:Number=0;
    }
}


