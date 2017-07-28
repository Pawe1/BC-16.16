//class Scroller
package feathers.controls 
{
    import __AS3__.vec.*;
    import feathers.controls.supportClasses.*;
    import feathers.core.*;
    import feathers.events.*;
    import feathers.layout.*;
    import feathers.system.*;
    import feathers.utils.math.*;
    import feathers.utils.skins.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.ui.*;
    import flash.utils.*;
    import starling.animation.*;
    import starling.core.*;
    import starling.display.*;
    import starling.events.*;
    import starling.utils.*;
    
    public class Scroller extends feathers.core.FeathersControl implements feathers.core.IFocusDisplayObject
    {
        public function Scroller()
        {
            this._previousVelocityX = new Vector.<Number>(0);
            this._previousVelocityY = new Vector.<Number>(0);
            this._horizontalScrollBarFactory = defaultScrollBarFactory;
            this._verticalScrollBarFactory = defaultScrollBarFactory;
            this._throwEase = defaultThrowEase;
            super();
            this.addEventListener(starling.events.Event.ADDED_TO_STAGE, this.scroller_addedToStageHandler);
            this.addEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.scroller_removedFromStageHandler);
            return;
        }

        public function set verticalMouseWheelScrollDirection(arg1:String):void
        {
            this._verticalMouseWheelScrollDirection = arg1;
            return;
        }

        public function get throwEase():Object
        {
            return this._throwEase;
        }

        public function set throwEase(arg1:Object):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (arg1 == null) 
            {
                arg1 = defaultThrowEase;
            }
            this._throwEase = arg1;
            return;
        }

        public function get snapScrollPositionsToPixels():Boolean
        {
            return this._snapScrollPositionsToPixels;
        }

        public override function get isFocusEnabled():Boolean
        {
            return (!(this._maxVerticalScrollPosition == this._minVerticalScrollPosition) || !(this._maxHorizontalScrollPosition == this._minHorizontalScrollPosition)) && super.isFocusEnabled;
        }

        public function set snapScrollPositionsToPixels(arg1:Boolean):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._snapScrollPositionsToPixels === arg1) 
            {
                return;
            }
            this._snapScrollPositionsToPixels = arg1;
            this.invalidate(INVALIDATION_FLAG_SCROLL);
            return;
        }

        public function get isScrolling():Boolean
        {
            return this._isScrolling;
        }

        public function get revealScrollBarsDuration():Number
        {
            return this._revealScrollBarsDuration;
        }

        public function set revealScrollBarsDuration(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            this._revealScrollBarsDuration = arg1;
            return;
        }

        public override function dispose():void
        {
            var loc1:*=this.stage === null ? starling.core.Starling.current : this.stage.starling;
            loc1.nativeStage.removeEventListener(flash.events.MouseEvent.MOUSE_WHEEL, this.nativeStage_mouseWheelHandler);
            loc1.nativeStage.removeEventListener("orientationChange", this.nativeStage_orientationChangeHandler);
            if (this._backgroundSkin && !(this._backgroundSkin.parent === this)) 
            {
                this._backgroundSkin.dispose();
            }
            if (this._backgroundDisabledSkin && !(this._backgroundDisabledSkin.parent === this)) 
            {
                this._backgroundDisabledSkin.dispose();
            }
            super.dispose();
            return;
        }

        public function stopScrolling():void
        {
            if (this._horizontalAutoScrollTween) 
            {
                starling.core.Starling.juggler.remove(this._horizontalAutoScrollTween);
                this._horizontalAutoScrollTween = null;
            }
            if (this._verticalAutoScrollTween) 
            {
                starling.core.Starling.juggler.remove(this._verticalAutoScrollTween);
                this._verticalAutoScrollTween = null;
            }
            this._isScrollingStopped = true;
            this._velocityX = 0;
            this._velocityY = 0;
            this._previousVelocityX.length = 0;
            this._previousVelocityY.length = 0;
            this.hideHorizontalScrollBar();
            this.hideVerticalScrollBar();
            return;
        }

        public function scrollToPosition(arg1:Number, arg2:Number, arg3:Number=NaN):void
        {
            if (arg3 !== arg3) 
            {
                if (this._useFixedThrowDuration) 
                {
                    arg3 = this._fixedThrowDuration;
                }
                else 
                {
                    HELPER_POINT.setTo(arg1 - this._horizontalScrollPosition, arg2 - this._verticalScrollPosition);
                    arg3 = this.calculateDynamicThrowDuration(HELPER_POINT.length * this._logDecelerationRate + MINIMUM_VELOCITY);
                }
            }
            this.hasPendingHorizontalPageIndex = false;
            this.hasPendingVerticalPageIndex = false;
            if (this.pendingHorizontalScrollPosition == arg1 && this.pendingVerticalScrollPosition == arg2 && this.pendingScrollDuration == arg3) 
            {
                return;
            }
            this.pendingHorizontalScrollPosition = arg1;
            this.pendingVerticalScrollPosition = arg2;
            this.pendingScrollDuration = arg3;
            this.invalidate(INVALIDATION_FLAG_PENDING_SCROLL);
            return;
        }

        public function scrollToPageIndex(arg1:int, arg2:int, arg3:Number=NaN):void
        {
            if (arg3 !== arg3) 
            {
                arg3 = this._pageThrowDuration;
            }
            this.pendingHorizontalScrollPosition = NaN;
            this.pendingVerticalScrollPosition = NaN;
            this.hasPendingHorizontalPageIndex = !(this._horizontalPageIndex === arg1);
            this.hasPendingVerticalPageIndex = !(this._verticalPageIndex === arg2);
            if (!this.hasPendingHorizontalPageIndex && !this.hasPendingVerticalPageIndex) 
            {
                return;
            }
            this.pendingHorizontalPageIndex = arg1;
            this.pendingVerticalPageIndex = arg2;
            this.pendingScrollDuration = arg3;
            this.invalidate(INVALIDATION_FLAG_PENDING_SCROLL);
            return;
        }

        public function revealScrollBars():void
        {
            this.isScrollBarRevealPending = true;
            this.invalidate(INVALIDATION_FLAG_PENDING_REVEAL_SCROLL_BARS);
            return;
        }

        public override function hitTest(arg1:flash.geom.Point):starling.display.DisplayObject
        {
            var loc1:*=arg1.x;
            var loc2:*=arg1.y;
            var loc3:*=super.hitTest(arg1);
            if (!loc3) 
            {
                if (!this.visible || !this.touchable) 
                {
                    return null;
                }
                return this._hitArea.contains(loc1, loc2) ? this : null;
            }
            return loc3;
        }

        protected override function draw():void
        {
            var loc1:*=this.isInvalid(INVALIDATION_FLAG_SIZE);
            var loc2:*=this.isInvalid(INVALIDATION_FLAG_DATA);
            var loc3:*=this.isInvalid(INVALIDATION_FLAG_SCROLL);
            var loc4:*=this.isInvalid(INVALIDATION_FLAG_CLIPPING);
            var loc5:*=this.isInvalid(INVALIDATION_FLAG_STYLES);
            var loc6:*=this.isInvalid(INVALIDATION_FLAG_STATE);
            var loc7:*=this.isInvalid(INVALIDATION_FLAG_SCROLL_BAR_RENDERER);
            var loc8:*=this.isInvalid(INVALIDATION_FLAG_PENDING_SCROLL);
            var loc9:*=this.isInvalid(INVALIDATION_FLAG_PENDING_REVEAL_SCROLL_BARS);
            if (loc7) 
            {
                this.createScrollBars();
            }
            if (loc1 || loc5 || loc6) 
            {
                this.refreshBackgroundSkin();
            }
            if (loc7 || loc5) 
            {
                this.refreshScrollBarStyles();
                this.refreshInteractionModeEvents();
            }
            if (loc7 || loc6) 
            {
                this.refreshEnabled();
            }
            if (this.horizontalScrollBar) 
            {
                this.horizontalScrollBar.validate();
            }
            if (this.verticalScrollBar) 
            {
                this.verticalScrollBar.validate();
            }
            var loc10:*=this._maxHorizontalScrollPosition;
            var loc11:*=this._maxVerticalScrollPosition;
            var loc12:*=loc3 && this._viewPort.requiresMeasurementOnScroll || loc2 || loc1 || loc5 || loc7;
            this.refreshViewPort(loc12);
            if (loc10 != this._maxHorizontalScrollPosition) 
            {
                this.refreshHorizontalAutoScrollTweenEndRatio();
                loc3 = true;
            }
            if (loc11 != this._maxVerticalScrollPosition) 
            {
                this.refreshVerticalAutoScrollTweenEndRatio();
                loc3 = true;
            }
            if (loc3) 
            {
                this.dispatchEventWith(starling.events.Event.SCROLL);
            }
            this.showOrHideChildren();
            this.layoutChildren();
            if (loc3 || loc1 || loc5 || loc7) 
            {
                this.refreshScrollBarValues();
            }
            if (loc12 || loc3 || loc4) 
            {
                this.refreshMask();
            }
            this.refreshFocusIndicator();
            if (loc8) 
            {
                this.handlePendingScroll();
            }
            if (loc9) 
            {
                this.handlePendingRevealScrollBars();
            }
            return;
        }

        protected function refreshViewPort(arg1:Boolean):void
        {
            this._viewPort.horizontalScrollPosition = this._horizontalScrollPosition;
            this._viewPort.verticalScrollPosition = this._verticalScrollPosition;
            if (!arg1) 
            {
                this._viewPort.validate();
                this.refreshScrollValues();
                return;
            }
            var loc1:*=0;
            do 
            {
                this._hasViewPortBoundsChanged = false;
                if (this._measureViewPort) 
                {
                    this.calculateViewPortOffsets(true, false);
                    this.refreshViewPortBoundsForMeasurement();
                }
                this.calculateViewPortOffsets(false, false);
                this.autoSizeIfNeeded();
                this.calculateViewPortOffsets(false, true);
                this.refreshViewPortBoundsForLayout();
                this.refreshScrollValues();
                ++loc1;
                if (loc1 >= 10) 
                {
                    throw new Error(flash.utils.getQualifiedClassName(this) + " stuck in an infinite loop during measurement and validation. This may be an issue with the layout or children, such as custom item renderers.");
                }
            }
            while (this._hasViewPortBoundsChanged);
            this._lastViewPortWidth = this._viewPort.width;
            this._lastViewPortHeight = this._viewPort.height;
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
            feathers.utils.skins.resetFluidChildDimensionsForMeasurement(this.currentBackgroundSkin, this._explicitWidth, this._explicitHeight, this._explicitMinWidth, this._explicitMinHeight, this._explicitMaxWidth, this._explicitMaxHeight, this._explicitBackgroundWidth, this._explicitBackgroundHeight, this._explicitBackgroundMinWidth, this._explicitBackgroundMinHeight, this._explicitBackgroundMaxWidth, this._explicitBackgroundMaxHeight);
            var loc5:*=this.currentBackgroundSkin as feathers.core.IMeasureDisplayObject;
            if (this.currentBackgroundSkin is feathers.core.IValidating) 
            {
                feathers.core.IValidating(this.currentBackgroundSkin).validate();
            }
            var loc6:*=this._explicitWidth;
            var loc7:*=this._explicitHeight;
            var loc8:*=this._explicitMinWidth;
            var loc9:*=this._explicitMinHeight;
            if (loc1) 
            {
                if (this._measureViewPort) 
                {
                    loc6 = this._viewPort.visibleWidth;
                }
                else 
                {
                    loc6 = 0;
                }
                loc6 = loc6 + (this._rightViewPortOffset + this._leftViewPortOffset);
                if (!(this.currentBackgroundSkin === null) && this.currentBackgroundSkin.width > loc6) 
                {
                    loc6 = this.currentBackgroundSkin.width;
                }
            }
            if (loc2) 
            {
                if (this._measureViewPort) 
                {
                    loc7 = this._viewPort.visibleHeight;
                }
                else 
                {
                    loc7 = 0;
                }
                loc7 = loc7 + (this._bottomViewPortOffset + this._topViewPortOffset);
                if (!(this.currentBackgroundSkin === null) && this.currentBackgroundSkin.height > loc7) 
                {
                    loc7 = this.currentBackgroundSkin.height;
                }
            }
            if (loc3) 
            {
                if (this._measureViewPort) 
                {
                    loc8 = this._viewPort.minVisibleWidth;
                }
                else 
                {
                    loc8 = 0;
                }
                loc8 = loc8 + (this._rightViewPortOffset + this._leftViewPortOffset);
                if (this.currentBackgroundSkin !== null) 
                {
                    if (loc5 === null) 
                    {
                        if (this._explicitBackgroundMinWidth > loc8) 
                        {
                            loc8 = this._explicitBackgroundMinWidth;
                        }
                    }
                    else if (loc5.minWidth > loc8) 
                    {
                        loc8 = loc5.minWidth;
                    }
                }
            }
            if (loc4) 
            {
                if (this._measureViewPort) 
                {
                    loc9 = this._viewPort.minVisibleHeight;
                }
                else 
                {
                    loc9 = 0;
                }
                loc9 = loc9 + (this._bottomViewPortOffset + this._topViewPortOffset);
                if (this.currentBackgroundSkin !== null) 
                {
                    if (loc5 === null) 
                    {
                        if (this._explicitBackgroundMinHeight > loc9) 
                        {
                            loc9 = this._explicitBackgroundMinHeight;
                        }
                    }
                    else if (loc5.minHeight > loc9) 
                    {
                        loc9 = loc5.minHeight;
                    }
                }
            }
            return this.saveMeasurements(loc6, loc7, loc8, loc9);
        }

        protected function createScrollBars():void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (this.horizontalScrollBar) 
            {
                this.horizontalScrollBar.removeEventListener(feathers.events.FeathersEventType.BEGIN_INTERACTION, this.horizontalScrollBar_beginInteractionHandler);
                this.horizontalScrollBar.removeEventListener(feathers.events.FeathersEventType.END_INTERACTION, this.horizontalScrollBar_endInteractionHandler);
                this.horizontalScrollBar.removeEventListener(starling.events.Event.CHANGE, this.horizontalScrollBar_changeHandler);
                this.removeRawChildInternal(starling.display.DisplayObject(this.horizontalScrollBar), true);
                this.horizontalScrollBar = null;
            }
            if (this.verticalScrollBar) 
            {
                this.verticalScrollBar.removeEventListener(feathers.events.FeathersEventType.BEGIN_INTERACTION, this.verticalScrollBar_beginInteractionHandler);
                this.verticalScrollBar.removeEventListener(feathers.events.FeathersEventType.END_INTERACTION, this.verticalScrollBar_endInteractionHandler);
                this.verticalScrollBar.removeEventListener(starling.events.Event.CHANGE, this.verticalScrollBar_changeHandler);
                this.removeRawChildInternal(starling.display.DisplayObject(this.verticalScrollBar), true);
                this.verticalScrollBar = null;
            }
            if (!(this._scrollBarDisplayMode == feathers.controls.ScrollBarDisplayMode.NONE) && !(this._horizontalScrollPolicy == feathers.controls.ScrollPolicy.OFF) && !(this._horizontalScrollBarFactory == null)) 
            {
                this.horizontalScrollBar = feathers.controls.IScrollBar(this._horizontalScrollBarFactory());
                if (this.horizontalScrollBar is feathers.controls.IDirectionalScrollBar) 
                {
                    feathers.controls.IDirectionalScrollBar(this.horizontalScrollBar).direction = feathers.layout.Direction.HORIZONTAL;
                }
                loc1 = this._customHorizontalScrollBarStyleName == null ? this.horizontalScrollBarStyleName : this._customHorizontalScrollBarStyleName;
                this.horizontalScrollBar.styleNameList.add(loc1);
                this.horizontalScrollBar.addEventListener(starling.events.Event.CHANGE, this.horizontalScrollBar_changeHandler);
                this.horizontalScrollBar.addEventListener(feathers.events.FeathersEventType.BEGIN_INTERACTION, this.horizontalScrollBar_beginInteractionHandler);
                this.horizontalScrollBar.addEventListener(feathers.events.FeathersEventType.END_INTERACTION, this.horizontalScrollBar_endInteractionHandler);
                this.addRawChildInternal(starling.display.DisplayObject(this.horizontalScrollBar));
            }
            if (!(this._scrollBarDisplayMode == feathers.controls.ScrollBarDisplayMode.NONE) && !(this._verticalScrollPolicy == feathers.controls.ScrollPolicy.OFF) && !(this._verticalScrollBarFactory == null)) 
            {
                this.verticalScrollBar = feathers.controls.IScrollBar(this._verticalScrollBarFactory());
                if (this.verticalScrollBar is feathers.controls.IDirectionalScrollBar) 
                {
                    feathers.controls.IDirectionalScrollBar(this.verticalScrollBar).direction = feathers.layout.Direction.VERTICAL;
                }
                loc2 = this._customVerticalScrollBarStyleName == null ? this.verticalScrollBarStyleName : this._customVerticalScrollBarStyleName;
                this.verticalScrollBar.styleNameList.add(loc2);
                this.verticalScrollBar.addEventListener(starling.events.Event.CHANGE, this.verticalScrollBar_changeHandler);
                this.verticalScrollBar.addEventListener(feathers.events.FeathersEventType.BEGIN_INTERACTION, this.verticalScrollBar_beginInteractionHandler);
                this.verticalScrollBar.addEventListener(feathers.events.FeathersEventType.END_INTERACTION, this.verticalScrollBar_endInteractionHandler);
                this.addRawChildInternal(starling.display.DisplayObject(this.verticalScrollBar));
            }
            return;
        }

        protected function refreshBackgroundSkin():void
        {
            var loc2:*=null;
            var loc1:*=this._backgroundSkin;
            if (!this._isEnabled && this._backgroundDisabledSkin) 
            {
                loc1 = this._backgroundDisabledSkin;
            }
            if (this.currentBackgroundSkin != loc1) 
            {
                if (this.currentBackgroundSkin) 
                {
                    this.removeRawChildInternal(this.currentBackgroundSkin);
                }
                this.currentBackgroundSkin = loc1;
                if (this.currentBackgroundSkin !== null) 
                {
                    this.addRawChildAtInternal(this.currentBackgroundSkin, 0);
                    if (this.currentBackgroundSkin is feathers.core.IFeathersControl) 
                    {
                        feathers.core.IFeathersControl(this.currentBackgroundSkin).initializeNow();
                    }
                    if (this.currentBackgroundSkin is feathers.core.IMeasureDisplayObject) 
                    {
                        loc2 = feathers.core.IMeasureDisplayObject(this.currentBackgroundSkin);
                        this._explicitBackgroundWidth = loc2.explicitWidth;
                        this._explicitBackgroundHeight = loc2.explicitHeight;
                        this._explicitBackgroundMinWidth = loc2.explicitMinWidth;
                        this._explicitBackgroundMinHeight = loc2.explicitMinHeight;
                        this._explicitBackgroundMaxWidth = loc2.explicitMaxWidth;
                        this._explicitBackgroundMaxHeight = loc2.explicitMaxHeight;
                    }
                    else 
                    {
                        this._explicitBackgroundWidth = this.currentBackgroundSkin.width;
                        this._explicitBackgroundHeight = this.currentBackgroundSkin.height;
                        this._explicitBackgroundMinWidth = this._explicitBackgroundWidth;
                        this._explicitBackgroundMinHeight = this._explicitBackgroundHeight;
                        this._explicitBackgroundMaxWidth = this._explicitBackgroundWidth;
                        this._explicitBackgroundMaxHeight = this._explicitBackgroundHeight;
                    }
                }
            }
            if (this.currentBackgroundSkin !== null) 
            {
                this.setRawChildIndexInternal(this.currentBackgroundSkin, 0);
            }
            return;
        }

        protected function refreshScrollBarStyles():void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (this.horizontalScrollBar) 
            {
                var loc3:*=0;
                var loc4:*=this._horizontalScrollBarProperties;
                for (loc1 in loc4) 
                {
                    loc2 = this._horizontalScrollBarProperties[loc1];
                    this.horizontalScrollBar[loc1] = loc2;
                }
                if (this._horizontalScrollBarHideTween) 
                {
                    starling.core.Starling.juggler.remove(this._horizontalScrollBarHideTween);
                    this._horizontalScrollBarHideTween = null;
                }
                this.horizontalScrollBar.alpha = this._scrollBarDisplayMode != feathers.controls.ScrollBarDisplayMode.FLOAT ? 1 : 0;
            }
            if (this.verticalScrollBar) 
            {
                loc3 = 0;
                loc4 = this._verticalScrollBarProperties;
                for (loc1 in loc4) 
                {
                    loc2 = this._verticalScrollBarProperties[loc1];
                    this.verticalScrollBar[loc1] = loc2;
                }
                if (this._verticalScrollBarHideTween) 
                {
                    starling.core.Starling.juggler.remove(this._verticalScrollBarHideTween);
                    this._verticalScrollBarHideTween = null;
                }
                this.verticalScrollBar.alpha = this._scrollBarDisplayMode != feathers.controls.ScrollBarDisplayMode.FLOAT ? 1 : 0;
            }
            return;
        }

        protected function refreshEnabled():void
        {
            if (this._viewPort) 
            {
                this._viewPort.isEnabled = this._isEnabled;
            }
            if (this.horizontalScrollBar) 
            {
                this.horizontalScrollBar.isEnabled = this._isEnabled;
            }
            if (this.verticalScrollBar) 
            {
                this.verticalScrollBar.isEnabled = this._isEnabled;
            }
            return;
        }

        protected override function refreshFocusIndicator():void
        {
            if (this._focusIndicatorSkin) 
            {
                if (this._hasFocus && this._showFocus) 
                {
                    if (this._focusIndicatorSkin.parent == this) 
                    {
                        this.setRawChildIndexInternal(this._focusIndicatorSkin, (this.numRawChildrenInternal - 1));
                    }
                    else 
                    {
                        this.addRawChildInternal(this._focusIndicatorSkin);
                    }
                }
                else if (this._focusIndicatorSkin.parent == this) 
                {
                    this.removeRawChildInternal(this._focusIndicatorSkin, false);
                }
                this._focusIndicatorSkin.x = this._focusPaddingLeft;
                this._focusIndicatorSkin.y = this._focusPaddingTop;
                this._focusIndicatorSkin.width = this.actualWidth - this._focusPaddingLeft - this._focusPaddingRight;
                this._focusIndicatorSkin.height = this.actualHeight - this._focusPaddingTop - this._focusPaddingBottom;
            }
            return;
        }

        protected function refreshViewPortBoundsForMeasurement():void
        {
            var loc7:*=NaN;
            var loc8:*=NaN;
            var loc1:*=this._leftViewPortOffset + this._rightViewPortOffset;
            var loc2:*=this._topViewPortOffset + this._bottomViewPortOffset;
            feathers.utils.skins.resetFluidChildDimensionsForMeasurement(this.currentBackgroundSkin, this._explicitWidth, this._explicitHeight, this._explicitMinWidth, this._explicitMinHeight, this._explicitMaxWidth, this._explicitMaxHeight, this._explicitBackgroundWidth, this._explicitBackgroundHeight, this._explicitBackgroundMinWidth, this._explicitBackgroundMinHeight, this._explicitBackgroundMaxWidth, this._explicitBackgroundMaxHeight);
            var loc3:*=this.currentBackgroundSkin as feathers.core.IMeasureDisplayObject;
            if (this.currentBackgroundSkin is feathers.core.IValidating) 
            {
                feathers.core.IValidating(this.currentBackgroundSkin).validate();
            }
            var loc4:*=this._explicitMinWidth;
            if (!(loc4 === loc4) || this._explicitViewPortMinWidth > loc4) 
            {
                loc4 = this._explicitViewPortMinWidth;
            }
            if (!(loc4 === loc4) || this._explicitWidth > loc4) 
            {
                loc4 = this._explicitWidth;
            }
            if (this.currentBackgroundSkin !== null) 
            {
                loc7 = this.currentBackgroundSkin.width;
                if (loc3 !== null) 
                {
                    loc7 = loc3.minWidth;
                }
                if (!(loc4 === loc4) || loc7 > loc4) 
                {
                    loc4 = loc7;
                }
            }
            loc4 = loc4 - loc1;
            var loc5:*=this._explicitMinHeight;
            if (!(loc5 === loc5) || this._explicitViewPortMinHeight > loc5) 
            {
                loc5 = this._explicitViewPortMinHeight;
            }
            if (!(loc5 === loc5) || this._explicitHeight > loc5) 
            {
                loc5 = this._explicitHeight;
            }
            if (this.currentBackgroundSkin !== null) 
            {
                loc8 = this.currentBackgroundSkin.height;
                if (loc3 !== null) 
                {
                    loc8 = loc3.minHeight;
                }
                if (!(loc5 === loc5) || loc8 > loc5) 
                {
                    loc5 = loc8;
                }
            }
            loc5 = loc5 - loc2;
            var loc6:*=this.ignoreViewPortResizing;
            this.ignoreViewPortResizing = true;
            this._viewPort.visibleWidth = this._explicitWidth - loc1;
            this._viewPort.minVisibleWidth = this._explicitMinWidth - loc1;
            this._viewPort.maxVisibleWidth = this._explicitMaxWidth - loc1;
            this._viewPort.minWidth = loc4;
            this._viewPort.visibleHeight = this._explicitHeight - loc2;
            this._viewPort.minVisibleHeight = this._explicitMinHeight - loc2;
            this._viewPort.maxVisibleHeight = this._explicitMaxHeight - loc2;
            this._viewPort.minHeight = loc5;
            this._viewPort.validate();
            this.ignoreViewPortResizing = loc6;
            return;
        }

        protected function refreshViewPortBoundsForLayout():void
        {
            var loc1:*=this._leftViewPortOffset + this._rightViewPortOffset;
            var loc2:*=this._topViewPortOffset + this._bottomViewPortOffset;
            var loc3:*=this.ignoreViewPortResizing;
            this.ignoreViewPortResizing = true;
            var loc4:*=this.actualWidth - loc1;
            if (this._viewPort.visibleWidth !== loc4) 
            {
                this._viewPort.visibleWidth = loc4;
            }
            this._viewPort.minVisibleWidth = this.actualWidth - loc1;
            this._viewPort.maxVisibleWidth = this._explicitMaxWidth - loc1;
            this._viewPort.minWidth = loc4;
            var loc5:*=this.actualHeight - loc2;
            if (this._viewPort.visibleHeight !== loc5) 
            {
                this._viewPort.visibleHeight = loc5;
            }
            this._viewPort.minVisibleHeight = this.actualMinHeight - loc2;
            this._viewPort.maxVisibleHeight = this._explicitMaxHeight - loc2;
            this._viewPort.minHeight = loc5;
            this.ignoreViewPortResizing = loc3;
            this._viewPort.validate();
            return;
        }

        protected function refreshScrollValues():void
        {
            this.refreshScrollSteps();
            var loc1:*=this._maxHorizontalScrollPosition;
            var loc2:*=this._maxVerticalScrollPosition;
            this.refreshMinAndMaxScrollPositions();
            var loc3:*=!(this._maxHorizontalScrollPosition == loc1) || !(this._maxVerticalScrollPosition == loc2);
            if (loc3 && this._touchPointID < 0) 
            {
                this.clampScrollPositions();
            }
            this.refreshPageCount();
            this.refreshPageIndices();
            return;
        }

        protected function clampScrollPositions():void
        {
            var loc1:*=NaN;
            var loc2:*=NaN;
            if (!this._horizontalAutoScrollTween) 
            {
                if (this._snapToPages) 
                {
                    this._horizontalScrollPosition = feathers.utils.math.roundToNearest(this._horizontalScrollPosition, this.actualPageWidth);
                }
                loc1 = this._horizontalScrollPosition;
                if (loc1 < this._minHorizontalScrollPosition) 
                {
                    loc1 = this._minHorizontalScrollPosition;
                }
                else if (loc1 > this._maxHorizontalScrollPosition) 
                {
                    loc1 = this._maxHorizontalScrollPosition;
                }
                this.horizontalScrollPosition = loc1;
            }
            if (!this._verticalAutoScrollTween) 
            {
                if (this._snapToPages) 
                {
                    this._verticalScrollPosition = feathers.utils.math.roundToNearest(this._verticalScrollPosition, this.actualPageHeight);
                }
                loc2 = this._verticalScrollPosition;
                if (loc2 < this._minVerticalScrollPosition) 
                {
                    loc2 = this._minVerticalScrollPosition;
                }
                else if (loc2 > this._maxVerticalScrollPosition) 
                {
                    loc2 = this._maxVerticalScrollPosition;
                }
                this.verticalScrollPosition = loc2;
            }
            return;
        }

        protected function refreshScrollSteps():void
        {
            if (this.explicitHorizontalScrollStep === this.explicitHorizontalScrollStep) 
            {
                this.actualHorizontalScrollStep = this.explicitHorizontalScrollStep;
            }
            else if (this._viewPort) 
            {
                this.actualHorizontalScrollStep = this._viewPort.horizontalScrollStep;
            }
            else 
            {
                this.actualHorizontalScrollStep = 1;
            }
            if (this.explicitVerticalScrollStep === this.explicitVerticalScrollStep) 
            {
                this.actualVerticalScrollStep = this.explicitVerticalScrollStep;
            }
            else if (this._viewPort) 
            {
                this.actualVerticalScrollStep = this._viewPort.verticalScrollStep;
            }
            else 
            {
                this.actualVerticalScrollStep = 1;
            }
            return;
        }

        protected function refreshMinAndMaxScrollPositions():void
        {
            var loc1:*=this.actualWidth - (this._leftViewPortOffset + this._rightViewPortOffset);
            var loc2:*=this.actualHeight - (this._topViewPortOffset + this._bottomViewPortOffset);
            if (this.explicitPageWidth !== this.explicitPageWidth) 
            {
                this.actualPageWidth = loc1;
            }
            if (this.explicitPageHeight !== this.explicitPageHeight) 
            {
                this.actualPageHeight = loc2;
            }
            if (this._viewPort) 
            {
                this._minHorizontalScrollPosition = this._viewPort.contentX;
                if (this._viewPort.width != Number.POSITIVE_INFINITY) 
                {
                    this._maxHorizontalScrollPosition = this._minHorizontalScrollPosition + this._viewPort.width - loc1;
                }
                else 
                {
                    this._maxHorizontalScrollPosition = Number.POSITIVE_INFINITY;
                }
                if (this._maxHorizontalScrollPosition < this._minHorizontalScrollPosition) 
                {
                    this._maxHorizontalScrollPosition = this._minHorizontalScrollPosition;
                }
                this._minVerticalScrollPosition = this._viewPort.contentY;
                if (this._viewPort.height != Number.POSITIVE_INFINITY) 
                {
                    this._maxVerticalScrollPosition = this._minVerticalScrollPosition + this._viewPort.height - loc2;
                }
                else 
                {
                    this._maxVerticalScrollPosition = Number.POSITIVE_INFINITY;
                }
                if (this._maxVerticalScrollPosition < this._minVerticalScrollPosition) 
                {
                    this._maxVerticalScrollPosition = this._minVerticalScrollPosition;
                }
            }
            else 
            {
                this._minHorizontalScrollPosition = 0;
                this._minVerticalScrollPosition = 0;
                this._maxHorizontalScrollPosition = 0;
                this._maxVerticalScrollPosition = 0;
            }
            return;
        }

        protected function refreshPageCount():void
        {
            var loc1:*=NaN;
            var loc2:*=NaN;
            var loc3:*=NaN;
            if (this._snapToPages) 
            {
                loc1 = this._maxHorizontalScrollPosition - this._minHorizontalScrollPosition;
                if (loc1 != Number.POSITIVE_INFINITY) 
                {
                    this._minHorizontalPageIndex = 0;
                    loc3 = feathers.utils.math.roundDownToNearest(loc1, this.actualPageWidth);
                    if (loc1 - loc3 < FUZZY_PAGE_SIZE_PADDING) 
                    {
                        loc1 = loc3;
                    }
                    this._maxHorizontalPageIndex = Math.ceil(loc1 / this.actualPageWidth);
                }
                else 
                {
                    if (this._minHorizontalScrollPosition != Number.NEGATIVE_INFINITY) 
                    {
                        this._minHorizontalPageIndex = 0;
                    }
                    else 
                    {
                        this._minHorizontalPageIndex = int.MIN_VALUE;
                    }
                    this._maxHorizontalPageIndex = int.MAX_VALUE;
                }
                loc2 = this._maxVerticalScrollPosition - this._minVerticalScrollPosition;
                if (loc2 != Number.POSITIVE_INFINITY) 
                {
                    this._minVerticalPageIndex = 0;
                    loc3 = feathers.utils.math.roundDownToNearest(loc2, this.actualPageHeight);
                    if (loc2 - loc3 < FUZZY_PAGE_SIZE_PADDING) 
                    {
                        loc2 = loc3;
                    }
                    this._maxVerticalPageIndex = Math.ceil(loc2 / this.actualPageHeight);
                }
                else 
                {
                    if (this._minVerticalScrollPosition != Number.NEGATIVE_INFINITY) 
                    {
                        this._minVerticalPageIndex = 0;
                    }
                    else 
                    {
                        this._minVerticalPageIndex = int.MIN_VALUE;
                    }
                    this._maxVerticalPageIndex = int.MAX_VALUE;
                }
            }
            else 
            {
                this._maxHorizontalPageIndex = 0;
                this._maxHorizontalPageIndex = 0;
                this._minVerticalPageIndex = 0;
                this._maxVerticalPageIndex = 0;
            }
            return;
        }

        protected function refreshPageIndices():void
        {
            var loc1:*=0;
            var loc2:*=NaN;
            var loc3:*=NaN;
            var loc4:*=NaN;
            if (!this._horizontalAutoScrollTween && !this.hasPendingHorizontalPageIndex) 
            {
                if (this._snapToPages) 
                {
                    if (this._horizontalScrollPosition != this._maxHorizontalScrollPosition) 
                    {
                        if (this._horizontalScrollPosition != this._minHorizontalScrollPosition) 
                        {
                            if (this._minHorizontalScrollPosition == Number.NEGATIVE_INFINITY && this._horizontalScrollPosition < 0) 
                            {
                                loc2 = this._horizontalScrollPosition / this.actualPageWidth;
                            }
                            else if (this._maxHorizontalScrollPosition == Number.POSITIVE_INFINITY && this._horizontalScrollPosition >= 0) 
                            {
                                loc2 = this._horizontalScrollPosition / this.actualPageWidth;
                            }
                            else 
                            {
                                loc3 = this._horizontalScrollPosition - this._minHorizontalScrollPosition;
                                loc2 = loc3 / this.actualPageWidth;
                            }
                            loc1 = Math.round(loc2);
                            if (!(loc2 === loc1) && starling.utils.MathUtil.isEquivalent(loc2, loc1, PAGE_INDEX_EPSILON)) 
                            {
                                this._horizontalPageIndex = loc1;
                            }
                            else 
                            {
                                this._horizontalPageIndex = Math.floor(loc2);
                            }
                        }
                        else 
                        {
                            this._horizontalPageIndex = this._minHorizontalPageIndex;
                        }
                    }
                    else 
                    {
                        this._horizontalPageIndex = this._maxHorizontalPageIndex;
                    }
                }
                else 
                {
                    this._horizontalPageIndex = this._minHorizontalPageIndex;
                }
                if (this._horizontalPageIndex < this._minHorizontalPageIndex) 
                {
                    this._horizontalPageIndex = this._minHorizontalPageIndex;
                }
                if (this._horizontalPageIndex > this._maxHorizontalPageIndex) 
                {
                    this._horizontalPageIndex = this._maxHorizontalPageIndex;
                }
            }
            if (!this._verticalAutoScrollTween && !this.hasPendingVerticalPageIndex) 
            {
                if (this._snapToPages) 
                {
                    if (this._verticalScrollPosition != this._maxVerticalScrollPosition) 
                    {
                        if (this._verticalScrollPosition != this._minVerticalScrollPosition) 
                        {
                            if (this._minVerticalScrollPosition == Number.NEGATIVE_INFINITY && this._verticalScrollPosition < 0) 
                            {
                                loc2 = this._verticalScrollPosition / this.actualPageHeight;
                            }
                            else if (this._maxVerticalScrollPosition == Number.POSITIVE_INFINITY && this._verticalScrollPosition >= 0) 
                            {
                                loc2 = this._verticalScrollPosition / this.actualPageHeight;
                            }
                            else 
                            {
                                loc4 = this._verticalScrollPosition - this._minVerticalScrollPosition;
                                loc2 = loc4 / this.actualPageHeight;
                            }
                            loc1 = Math.round(loc2);
                            if (!(loc2 === loc1) && starling.utils.MathUtil.isEquivalent(loc2, loc1, PAGE_INDEX_EPSILON)) 
                            {
                                this._verticalPageIndex = loc1;
                            }
                            else 
                            {
                                this._verticalPageIndex = Math.floor(loc2);
                            }
                        }
                        else 
                        {
                            this._verticalPageIndex = this._minVerticalPageIndex;
                        }
                    }
                    else 
                    {
                        this._verticalPageIndex = this._maxVerticalPageIndex;
                    }
                }
                else 
                {
                    this._verticalPageIndex = this._minVerticalScrollPosition;
                }
                if (this._verticalPageIndex < this._minVerticalScrollPosition) 
                {
                    this._verticalPageIndex = this._minVerticalScrollPosition;
                }
                if (this._verticalPageIndex > this._maxVerticalPageIndex) 
                {
                    this._verticalPageIndex = this._maxVerticalPageIndex;
                }
            }
            return;
        }

        protected function refreshScrollBarValues():void
        {
            if (this.horizontalScrollBar) 
            {
                this.horizontalScrollBar.minimum = this._minHorizontalScrollPosition;
                this.horizontalScrollBar.maximum = this._maxHorizontalScrollPosition;
                this.horizontalScrollBar.value = this._horizontalScrollPosition;
                this.horizontalScrollBar.page = (this._maxHorizontalScrollPosition - this._minHorizontalScrollPosition) * this.actualPageWidth / this._viewPort.width;
                this.horizontalScrollBar.step = this.actualHorizontalScrollStep;
            }
            if (this.verticalScrollBar) 
            {
                this.verticalScrollBar.minimum = this._minVerticalScrollPosition;
                this.verticalScrollBar.maximum = this._maxVerticalScrollPosition;
                this.verticalScrollBar.value = this._verticalScrollPosition;
                this.verticalScrollBar.page = (this._maxVerticalScrollPosition - this._minVerticalScrollPosition) * this.actualPageHeight / this._viewPort.height;
                this.verticalScrollBar.step = this.actualVerticalScrollStep;
            }
            return;
        }

        protected function showOrHideChildren():void
        {
            var loc1:*=this.numRawChildrenInternal;
            if (!(this._touchBlocker === null) && !(this._touchBlocker.parent === null)) 
            {
                --loc1;
            }
            if (this.verticalScrollBar) 
            {
                this.verticalScrollBar.visible = this._hasVerticalScrollBar;
                this.verticalScrollBar.touchable = this._hasVerticalScrollBar && !(this._interactionMode == feathers.controls.ScrollInteractionMode.TOUCH);
                this.setRawChildIndexInternal(starling.display.DisplayObject(this.verticalScrollBar), (loc1 - 1));
            }
            if (this.horizontalScrollBar) 
            {
                this.horizontalScrollBar.visible = this._hasHorizontalScrollBar;
                this.horizontalScrollBar.touchable = this._hasHorizontalScrollBar && !(this._interactionMode == feathers.controls.ScrollInteractionMode.TOUCH);
                if (this.verticalScrollBar) 
                {
                    this.setRawChildIndexInternal(starling.display.DisplayObject(this.horizontalScrollBar), loc1 - 2);
                }
                else 
                {
                    this.setRawChildIndexInternal(starling.display.DisplayObject(this.horizontalScrollBar), (loc1 - 1));
                }
            }
            if (this.currentBackgroundSkin) 
            {
                if (this._autoHideBackground) 
                {
                    this.currentBackgroundSkin.visible = this._viewPort.width <= this.actualWidth || this._viewPort.height <= this.actualHeight || this._horizontalScrollPosition < 0 || this._horizontalScrollPosition > this._maxHorizontalScrollPosition || this._verticalScrollPosition < 0 || this._verticalScrollPosition > this._maxVerticalScrollPosition;
                }
                else 
                {
                    this.currentBackgroundSkin.visible = true;
                }
            }
            return;
        }

        protected function calculateViewPortOffsetsForFixedHorizontalScrollBar(arg1:Boolean=false, arg2:Boolean=false):void
        {
            var loc1:*=NaN;
            var loc2:*=NaN;
            if (this.horizontalScrollBar && (this._measureViewPort || arg2)) 
            {
                loc1 = arg2 ? this.actualWidth : this._explicitWidth;
                loc2 = this._viewPort.width + this._leftViewPortOffset + this._rightViewPortOffset;
                if (arg1 || this._horizontalScrollPolicy == feathers.controls.ScrollPolicy.ON || (loc2 > loc1 || loc2 > this._explicitMaxWidth) && !(this._horizontalScrollPolicy == feathers.controls.ScrollPolicy.OFF)) 
                {
                    this._hasHorizontalScrollBar = true;
                    if (this._scrollBarDisplayMode == feathers.controls.ScrollBarDisplayMode.FIXED) 
                    {
                        this._bottomViewPortOffset = this._bottomViewPortOffset + this.horizontalScrollBar.height;
                    }
                }
                else 
                {
                    this._hasHorizontalScrollBar = false;
                }
            }
            else 
            {
                this._hasHorizontalScrollBar = false;
            }
            return;
        }

        protected function calculateViewPortOffsetsForFixedVerticalScrollBar(arg1:Boolean=false, arg2:Boolean=false):void
        {
            var loc1:*=NaN;
            var loc2:*=NaN;
            if (this.verticalScrollBar && (this._measureViewPort || arg2)) 
            {
                loc1 = arg2 ? this.actualHeight : this._explicitHeight;
                loc2 = this._viewPort.height + this._topViewPortOffset + this._bottomViewPortOffset;
                if (arg1 || this._verticalScrollPolicy == feathers.controls.ScrollPolicy.ON || (loc2 > loc1 || loc2 > this._explicitMaxHeight) && !(this._verticalScrollPolicy == feathers.controls.ScrollPolicy.OFF)) 
                {
                    this._hasVerticalScrollBar = true;
                    if (this._scrollBarDisplayMode == feathers.controls.ScrollBarDisplayMode.FIXED) 
                    {
                        if (this._verticalScrollBarPosition != feathers.layout.RelativePosition.LEFT) 
                        {
                            this._rightViewPortOffset = this._rightViewPortOffset + this.verticalScrollBar.width;
                        }
                        else 
                        {
                            this._leftViewPortOffset = this._leftViewPortOffset + this.verticalScrollBar.width;
                        }
                    }
                }
                else 
                {
                    this._hasVerticalScrollBar = false;
                }
            }
            else 
            {
                this._hasVerticalScrollBar = false;
            }
            return;
        }

        protected function calculateViewPortOffsets(arg1:Boolean=false, arg2:Boolean=false):void
        {
            this._topViewPortOffset = this._paddingTop;
            this._rightViewPortOffset = this._paddingRight;
            this._bottomViewPortOffset = this._paddingBottom;
            this._leftViewPortOffset = this._paddingLeft;
            this.calculateViewPortOffsetsForFixedHorizontalScrollBar(arg1, arg2);
            this.calculateViewPortOffsetsForFixedVerticalScrollBar(arg1, arg2);
            if (this._scrollBarDisplayMode == feathers.controls.ScrollBarDisplayMode.FIXED && this._hasVerticalScrollBar && !this._hasHorizontalScrollBar) 
            {
                this.calculateViewPortOffsetsForFixedHorizontalScrollBar(arg1, arg2);
            }
            return;
        }

        protected function refreshInteractionModeEvents():void
        {
            if (this._interactionMode == feathers.controls.ScrollInteractionMode.TOUCH || this._interactionMode == feathers.controls.ScrollInteractionMode.TOUCH_AND_SCROLL_BARS) 
            {
                this.addEventListener(starling.events.TouchEvent.TOUCH, this.scroller_touchHandler);
                if (!this._touchBlocker) 
                {
                    this._touchBlocker = new starling.display.Quad(100, 100, 16711935);
                    this._touchBlocker.alpha = 0;
                }
            }
            else 
            {
                this.removeEventListener(starling.events.TouchEvent.TOUCH, this.scroller_touchHandler);
                if (this._touchBlocker) 
                {
                    this.removeRawChildInternal(this._touchBlocker, true);
                    this._touchBlocker = null;
                }
            }
            if ((this._interactionMode == feathers.controls.ScrollInteractionMode.MOUSE || this._interactionMode == feathers.controls.ScrollInteractionMode.TOUCH_AND_SCROLL_BARS) && this._scrollBarDisplayMode == feathers.controls.ScrollBarDisplayMode.FLOAT) 
            {
                if (this.horizontalScrollBar) 
                {
                    this.horizontalScrollBar.addEventListener(starling.events.TouchEvent.TOUCH, this.horizontalScrollBar_touchHandler);
                }
                if (this.verticalScrollBar) 
                {
                    this.verticalScrollBar.addEventListener(starling.events.TouchEvent.TOUCH, this.verticalScrollBar_touchHandler);
                }
            }
            else 
            {
                if (this.horizontalScrollBar) 
                {
                    this.horizontalScrollBar.removeEventListener(starling.events.TouchEvent.TOUCH, this.horizontalScrollBar_touchHandler);
                }
                if (this.verticalScrollBar) 
                {
                    this.verticalScrollBar.removeEventListener(starling.events.TouchEvent.TOUCH, this.verticalScrollBar_touchHandler);
                }
            }
            return;
        }

        protected function layoutChildren():void
        {
            var loc3:*=null;
            var loc4:*=NaN;
            var loc1:*=this.actualWidth - this._leftViewPortOffset - this._rightViewPortOffset;
            var loc2:*=this.actualHeight - this._topViewPortOffset - this._bottomViewPortOffset;
            if (this.currentBackgroundSkin !== null) 
            {
                this.currentBackgroundSkin.width = this.actualWidth;
                this.currentBackgroundSkin.height = this.actualHeight;
            }
            if (this.horizontalScrollBar !== null) 
            {
                this.horizontalScrollBar.validate();
            }
            if (this.verticalScrollBar !== null) 
            {
                this.verticalScrollBar.validate();
            }
            if (this._touchBlocker !== null) 
            {
                this._touchBlocker.x = this._leftViewPortOffset;
                this._touchBlocker.y = this._topViewPortOffset;
                this._touchBlocker.width = loc1;
                this._touchBlocker.height = loc2;
            }
            if (this._snapScrollPositionsToPixels) 
            {
                loc3 = this.stage === null ? starling.core.Starling.current : this.stage.starling;
                loc4 = 1 / loc3.contentScaleFactor;
                this._viewPort.x = Math.round((this._leftViewPortOffset - this._horizontalScrollPosition) / loc4) * loc4;
                this._viewPort.y = Math.round((this._topViewPortOffset - this._verticalScrollPosition) / loc4) * loc4;
            }
            else 
            {
                this._viewPort.x = this._leftViewPortOffset - this._horizontalScrollPosition;
                this._viewPort.y = this._topViewPortOffset - this._verticalScrollPosition;
            }
            if (this.horizontalScrollBar !== null) 
            {
                this.horizontalScrollBar.x = this._leftViewPortOffset;
                this.horizontalScrollBar.y = this._topViewPortOffset + loc2;
                if (this._scrollBarDisplayMode === feathers.controls.ScrollBarDisplayMode.FIXED) 
                {
                    this.horizontalScrollBar.width = loc1;
                }
                else 
                {
                    this.horizontalScrollBar.y = this.horizontalScrollBar.y - this.horizontalScrollBar.height;
                    if ((this._hasVerticalScrollBar || this._verticalScrollBarHideTween) && this.verticalScrollBar) 
                    {
                        this.horizontalScrollBar.width = loc1 - this.verticalScrollBar.width;
                    }
                    else 
                    {
                        this.horizontalScrollBar.width = loc1;
                    }
                }
            }
            if (this.verticalScrollBar !== null) 
            {
                if (this._verticalScrollBarPosition !== feathers.layout.RelativePosition.LEFT) 
                {
                    this.verticalScrollBar.x = this._leftViewPortOffset + loc1;
                }
                else 
                {
                    this.verticalScrollBar.x = this._paddingLeft;
                }
                this.verticalScrollBar.y = this._topViewPortOffset;
                if (this._scrollBarDisplayMode === feathers.controls.ScrollBarDisplayMode.FIXED) 
                {
                    this.verticalScrollBar.height = loc2;
                }
                else 
                {
                    this.verticalScrollBar.x = this.verticalScrollBar.x - this.verticalScrollBar.width;
                    if ((this._hasHorizontalScrollBar || this._horizontalScrollBarHideTween) && this.horizontalScrollBar) 
                    {
                        this.verticalScrollBar.height = loc2 - this.horizontalScrollBar.height;
                    }
                    else 
                    {
                        this.verticalScrollBar.height = loc2;
                    }
                }
            }
            return;
        }

        public function get viewPort():feathers.controls.supportClasses.IViewPort
        {
            return this._viewPort;
        }

        public function set viewPort(arg1:feathers.controls.supportClasses.IViewPort):void
        {
            if (this._viewPort == arg1) 
            {
                return;
            }
            if (this._viewPort !== null) 
            {
                this._viewPort.removeEventListener(feathers.events.FeathersEventType.RESIZE, this.viewPort_resizeHandler);
                this.removeRawChildInternal(starling.display.DisplayObject(this._viewPort));
            }
            this._viewPort = arg1;
            if (this._viewPort !== null) 
            {
                this._viewPort.addEventListener(feathers.events.FeathersEventType.RESIZE, this.viewPort_resizeHandler);
                this.addRawChildAtInternal(starling.display.DisplayObject(this._viewPort), 0);
                if (this._viewPort is feathers.core.IFeathersControl) 
                {
                    feathers.core.IFeathersControl(this._viewPort).initializeNow();
                }
                this._explicitViewPortWidth = this._viewPort.explicitWidth;
                this._explicitViewPortHeight = this._viewPort.explicitHeight;
                this._explicitViewPortMinWidth = this._viewPort.explicitMinWidth;
                this._explicitViewPortMinHeight = this._viewPort.explicitMinHeight;
            }
            this.invalidate(INVALIDATION_FLAG_SIZE);
            return;
        }

        protected function refreshMask():void
        {
            if (!this._clipContent) 
            {
                return;
            }
            var loc1:*=this.actualWidth - this._leftViewPortOffset - this._rightViewPortOffset;
            if (loc1 < 0) 
            {
                loc1 = 0;
            }
            var loc2:*=this.actualHeight - this._topViewPortOffset - this._bottomViewPortOffset;
            if (loc2 < 0) 
            {
                loc2 = 0;
            }
            var loc3:*=this._viewPort.mask as starling.display.Quad;
            if (!loc3) 
            {
                loc3 = new starling.display.Quad(1, 1, 1044735);
                this._viewPort.mask = loc3;
            }
            loc3.x = this._horizontalScrollPosition;
            loc3.y = this._verticalScrollPosition;
            loc3.width = loc1;
            loc3.height = loc2;
            return;
        }

        protected function get numRawChildrenInternal():int
        {
            if (this is feathers.controls.IScrollContainer) 
            {
                return feathers.controls.IScrollContainer(this).numRawChildren;
            }
            return this.numChildren;
        }

        public function get horizontalPageIndex():int
        {
            if (this.hasPendingHorizontalPageIndex) 
            {
                return this.pendingHorizontalPageIndex;
            }
            return this._horizontalPageIndex;
        }

        protected function addRawChildInternal(arg1:starling.display.DisplayObject):starling.display.DisplayObject
        {
            if (this is feathers.controls.IScrollContainer) 
            {
                return feathers.controls.IScrollContainer(this).addRawChild(arg1);
            }
            return this.addChild(arg1);
        }

        protected function addRawChildAtInternal(arg1:starling.display.DisplayObject, arg2:int):starling.display.DisplayObject
        {
            if (this is feathers.controls.IScrollContainer) 
            {
                return feathers.controls.IScrollContainer(this).addRawChildAt(arg1, arg2);
            }
            return this.addChildAt(arg1, arg2);
        }

        public function get measureViewPort():Boolean
        {
            return this._measureViewPort;
        }

        public function set measureViewPort(arg1:Boolean):void
        {
            if (this._measureViewPort == arg1) 
            {
                return;
            }
            this._measureViewPort = arg1;
            this.invalidate(INVALIDATION_FLAG_SIZE);
            return;
        }

        protected function removeRawChildInternal(arg1:starling.display.DisplayObject, arg2:Boolean=false):starling.display.DisplayObject
        {
            if (this is feathers.controls.IScrollContainer) 
            {
                return feathers.controls.IScrollContainer(this).removeRawChild(arg1, arg2);
            }
            return this.removeChild(arg1, arg2);
        }

        public function get snapToPages():Boolean
        {
            return this._snapToPages;
        }

        public function set snapToPages(arg1:Boolean):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._snapToPages === arg1) 
            {
                return;
            }
            this._snapToPages = arg1;
            this.invalidate(INVALIDATION_FLAG_SCROLL);
            return;
        }

        protected function removeRawChildAtInternal(arg1:int, arg2:Boolean=false):starling.display.DisplayObject
        {
            if (this is feathers.controls.IScrollContainer) 
            {
                return feathers.controls.IScrollContainer(this).removeRawChildAt(arg1, arg2);
            }
            return this.removeChildAt(arg1, arg2);
        }

        protected function setRawChildIndexInternal(arg1:starling.display.DisplayObject, arg2:int):void
        {
            if (this is feathers.controls.IScrollContainer) 
            {
                feathers.controls.IScrollContainer(this).setRawChildIndex(arg1, arg2);
                return;
            }
            this.setChildIndex(arg1, arg2);
            return;
        }

        public function get horizontalScrollBarFactory():Function
        {
            return this._horizontalScrollBarFactory;
        }

        public function set horizontalScrollBarFactory(arg1:Function):void
        {
            if (this._horizontalScrollBarFactory == arg1) 
            {
                return;
            }
            this._horizontalScrollBarFactory = arg1;
            this.invalidate(INVALIDATION_FLAG_SCROLL_BAR_RENDERER);
            return;
        }

        protected function updateHorizontalScrollFromTouchPosition(arg1:Number):void
        {
            var loc1:*=this._startTouchX - arg1;
            var loc2:*=this._startHorizontalScrollPosition + loc1;
            if (loc2 < this._minHorizontalScrollPosition) 
            {
                if (this._hasElasticEdges) 
                {
                    loc2 = loc2 - (loc2 - this._minHorizontalScrollPosition) * (1 - this._elasticity);
                }
                else 
                {
                    loc2 = this._minHorizontalScrollPosition;
                }
            }
            else if (loc2 > this._maxHorizontalScrollPosition) 
            {
                if (this._hasElasticEdges) 
                {
                    loc2 = loc2 - (loc2 - this._maxHorizontalScrollPosition) * (1 - this._elasticity);
                }
                else 
                {
                    loc2 = this._maxHorizontalScrollPosition;
                }
            }
            this.horizontalScrollPosition = loc2;
            return;
        }

        public function get customHorizontalScrollBarStyleName():String
        {
            return this._customHorizontalScrollBarStyleName;
        }

        public function set customHorizontalScrollBarStyleName(arg1:String):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._customHorizontalScrollBarStyleName === arg1) 
            {
                return;
            }
            this._customHorizontalScrollBarStyleName = arg1;
            this.invalidate(INVALIDATION_FLAG_SCROLL_BAR_RENDERER);
            return;
        }

        protected function updateVerticalScrollFromTouchPosition(arg1:Number):void
        {
            var loc1:*=this._startTouchY - arg1;
            var loc2:*=this._startVerticalScrollPosition + loc1;
            if (loc2 < this._minVerticalScrollPosition) 
            {
                if (this._hasElasticEdges) 
                {
                    loc2 = loc2 - (loc2 - this._minVerticalScrollPosition) * (1 - this._elasticity);
                }
                else 
                {
                    loc2 = this._minVerticalScrollPosition;
                }
            }
            else if (loc2 > this._maxVerticalScrollPosition) 
            {
                if (this._hasElasticEdges) 
                {
                    loc2 = loc2 - (loc2 - this._maxVerticalScrollPosition) * (1 - this._elasticity);
                }
                else 
                {
                    loc2 = this._maxVerticalScrollPosition;
                }
            }
            this.verticalScrollPosition = loc2;
            return;
        }

        public function get horizontalScrollBarProperties():Object
        {
            if (!this._horizontalScrollBarProperties) 
            {
                this._horizontalScrollBarProperties = new feathers.core.PropertyProxy(this.childProperties_onChange);
            }
            return this._horizontalScrollBarProperties;
        }

        public function set horizontalScrollBarProperties(arg1:Object):void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (this._horizontalScrollBarProperties == arg1) 
            {
                return;
            }
            if (!arg1) 
            {
                arg1 = new feathers.core.PropertyProxy();
            }
            if (!(arg1 is feathers.core.PropertyProxy)) 
            {
                loc1 = new feathers.core.PropertyProxy();
                var loc3:*=0;
                var loc4:*=arg1;
                for (loc2 in loc4) 
                {
                    loc1[loc2] = arg1[loc2];
                }
                arg1 = loc1;
            }
            if (this._horizontalScrollBarProperties) 
            {
                this._horizontalScrollBarProperties.removeOnChangeCallback(this.childProperties_onChange);
            }
            this._horizontalScrollBarProperties = feathers.core.PropertyProxy(arg1);
            if (this._horizontalScrollBarProperties) 
            {
                this._horizontalScrollBarProperties.addOnChangeCallback(this.childProperties_onChange);
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function throwTo(arg1:Number=NaN, arg2:Number=NaN, arg3:Number=0.5):void
        {
            var loc1:*=false;
            if (arg1 === arg1) 
            {
                if (this._snapToPages && arg1 > this._minHorizontalScrollPosition && arg1 < this._maxHorizontalScrollPosition) 
                {
                    arg1 = feathers.utils.math.roundToNearest(arg1, this.actualPageWidth);
                }
                if (this._horizontalAutoScrollTween) 
                {
                    starling.core.Starling.juggler.remove(this._horizontalAutoScrollTween);
                    this._horizontalAutoScrollTween = null;
                }
                if (this._horizontalScrollPosition == arg1) 
                {
                    this.finishScrollingHorizontally();
                }
                else 
                {
                    loc1 = true;
                    this.revealHorizontalScrollBar();
                    this.startScroll();
                    if (arg3 != 0) 
                    {
                        this._startHorizontalScrollPosition = this._horizontalScrollPosition;
                        this._targetHorizontalScrollPosition = arg1;
                        this._horizontalAutoScrollTween = new starling.animation.Tween(this, arg3, this._throwEase);
                        this._horizontalAutoScrollTween.animate("horizontalScrollPosition", arg1);
                        this._horizontalAutoScrollTween.onComplete = this.horizontalAutoScrollTween_onComplete;
                        starling.core.Starling.juggler.add(this._horizontalAutoScrollTween);
                        this.refreshHorizontalAutoScrollTweenEndRatio();
                    }
                    else 
                    {
                        this.horizontalScrollPosition = arg1;
                    }
                }
            }
            if (arg2 === arg2) 
            {
                if (this._snapToPages && arg2 > this._minVerticalScrollPosition && arg2 < this._maxVerticalScrollPosition) 
                {
                    arg2 = feathers.utils.math.roundToNearest(arg2, this.actualPageHeight);
                }
                if (this._verticalAutoScrollTween) 
                {
                    starling.core.Starling.juggler.remove(this._verticalAutoScrollTween);
                    this._verticalAutoScrollTween = null;
                }
                if (this._verticalScrollPosition == arg2) 
                {
                    this.finishScrollingVertically();
                }
                else 
                {
                    loc1 = true;
                    this.revealVerticalScrollBar();
                    this.startScroll();
                    if (arg3 != 0) 
                    {
                        this._startVerticalScrollPosition = this._verticalScrollPosition;
                        this._targetVerticalScrollPosition = arg2;
                        this._verticalAutoScrollTween = new starling.animation.Tween(this, arg3, this._throwEase);
                        this._verticalAutoScrollTween.animate("verticalScrollPosition", arg2);
                        this._verticalAutoScrollTween.onComplete = this.verticalAutoScrollTween_onComplete;
                        starling.core.Starling.juggler.add(this._verticalAutoScrollTween);
                        this.refreshVerticalAutoScrollTweenEndRatio();
                    }
                    else 
                    {
                        this.verticalScrollPosition = arg2;
                    }
                }
            }
            if (loc1 && arg3 == 0) 
            {
                this.completeScroll();
            }
            return;
        }

        public function get verticalScrollBarPosition():String
        {
            return this._verticalScrollBarPosition;
        }

        public function set verticalScrollBarPosition(arg1:String):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._verticalScrollBarPosition === arg1) 
            {
                return;
            }
            this._verticalScrollBarPosition = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function throwToPage(arg1:int, arg2:int, arg3:Number=0.5):void
        {
            var loc1:*=this._horizontalScrollPosition;
            if (arg1 >= this._minHorizontalPageIndex) 
            {
                loc1 = this.actualPageWidth * arg1;
            }
            if (loc1 < this._minHorizontalScrollPosition) 
            {
                loc1 = this._minHorizontalScrollPosition;
            }
            if (loc1 > this._maxHorizontalScrollPosition) 
            {
                loc1 = this._maxHorizontalScrollPosition;
            }
            var loc2:*=this._verticalScrollPosition;
            if (arg2 >= this._minVerticalPageIndex) 
            {
                loc2 = this.actualPageHeight * arg2;
            }
            if (loc2 < this._minVerticalScrollPosition) 
            {
                loc2 = this._minVerticalScrollPosition;
            }
            if (loc2 > this._maxVerticalScrollPosition) 
            {
                loc2 = this._maxVerticalScrollPosition;
            }
            if (arg3 > 0) 
            {
                this.throwTo(loc1, loc2, arg3);
            }
            else 
            {
                this.horizontalScrollPosition = loc1;
                this.verticalScrollPosition = loc2;
            }
            if (arg1 >= this._minHorizontalPageIndex) 
            {
                this._horizontalPageIndex = arg1;
            }
            if (arg2 >= this._minVerticalPageIndex) 
            {
                this._verticalPageIndex = arg2;
            }
            return;
        }

        public function get verticalScrollBarFactory():Function
        {
            return this._verticalScrollBarFactory;
        }

        public function set verticalScrollBarFactory(arg1:Function):void
        {
            if (this._verticalScrollBarFactory == arg1) 
            {
                return;
            }
            this._verticalScrollBarFactory = arg1;
            this.invalidate(INVALIDATION_FLAG_SCROLL_BAR_RENDERER);
            return;
        }

        protected function calculateDynamicThrowDuration(arg1:Number):Number
        {
            return Math.log(MINIMUM_VELOCITY / Math.abs(arg1)) / this._logDecelerationRate / 1000;
        }

        public function get customVerticalScrollBarStyleName():String
        {
            return this._customVerticalScrollBarStyleName;
        }

        public function set customVerticalScrollBarStyleName(arg1:String):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._customVerticalScrollBarStyleName === arg1) 
            {
                return;
            }
            this._customVerticalScrollBarStyleName = arg1;
            this.invalidate(INVALIDATION_FLAG_SCROLL_BAR_RENDERER);
            return;
        }

        protected function calculateThrowDistance(arg1:Number):Number
        {
            return (arg1 - MINIMUM_VELOCITY) / this._logDecelerationRate;
        }

        public function get verticalScrollBarProperties():Object
        {
            if (!this._verticalScrollBarProperties) 
            {
                this._verticalScrollBarProperties = new feathers.core.PropertyProxy(this.childProperties_onChange);
            }
            return this._verticalScrollBarProperties;
        }

        public function set verticalScrollBarProperties(arg1:Object):void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (this._horizontalScrollBarProperties == arg1) 
            {
                return;
            }
            if (!arg1) 
            {
                arg1 = new feathers.core.PropertyProxy();
            }
            if (!(arg1 is feathers.core.PropertyProxy)) 
            {
                loc1 = new feathers.core.PropertyProxy();
                var loc3:*=0;
                var loc4:*=arg1;
                for (loc2 in loc4) 
                {
                    loc1[loc2] = arg1[loc2];
                }
                arg1 = loc1;
            }
            if (this._verticalScrollBarProperties) 
            {
                this._verticalScrollBarProperties.removeOnChangeCallback(this.childProperties_onChange);
            }
            this._verticalScrollBarProperties = feathers.core.PropertyProxy(arg1);
            if (this._verticalScrollBarProperties) 
            {
                this._verticalScrollBarProperties.addOnChangeCallback(this.childProperties_onChange);
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function finishScrollingHorizontally():void
        {
            var loc1:*=NaN;
            if (this._horizontalScrollPosition < this._minHorizontalScrollPosition) 
            {
                loc1 = this._minHorizontalScrollPosition;
            }
            else if (this._horizontalScrollPosition > this._maxHorizontalScrollPosition) 
            {
                loc1 = this._maxHorizontalScrollPosition;
            }
            this._isDraggingHorizontally = false;
            if (loc1 === loc1) 
            {
                if (Math.abs(loc1 - this._horizontalScrollPosition) < 1) 
                {
                    this.horizontalScrollPosition = loc1;
                    this.completeScroll();
                }
                else 
                {
                    this.throwTo(loc1, NaN, this._elasticSnapDuration);
                }
            }
            else 
            {
                this.completeScroll();
            }
            return;
        }

        protected function finishScrollingVertically():void
        {
            var loc1:*=NaN;
            if (this._verticalScrollPosition < this._minVerticalScrollPosition) 
            {
                loc1 = this._minVerticalScrollPosition;
            }
            else if (this._verticalScrollPosition > this._maxVerticalScrollPosition) 
            {
                loc1 = this._maxVerticalScrollPosition;
            }
            this._isDraggingVertically = false;
            if (loc1 === loc1) 
            {
                if (Math.abs(loc1 - this._verticalScrollPosition) < 1) 
                {
                    this.verticalScrollPosition = loc1;
                    this.completeScroll();
                }
                else 
                {
                    this.throwTo(NaN, loc1, this._elasticSnapDuration);
                }
            }
            else 
            {
                this.completeScroll();
            }
            return;
        }

        public function get horizontalScrollStep():Number
        {
            return this.actualHorizontalScrollStep;
        }

        public function set horizontalScrollStep(arg1:Number):void
        {
            if (this.explicitHorizontalScrollStep == arg1) 
            {
                return;
            }
            this.explicitHorizontalScrollStep = arg1;
            this.invalidate(INVALIDATION_FLAG_SCROLL);
            return;
        }

        protected function throwHorizontally(arg1:Number):void
        {
            var loc3:*=null;
            var loc4:*=NaN;
            var loc5:*=NaN;
            var loc6:*=NaN;
            var loc7:*=NaN;
            var loc8:*=NaN;
            var loc9:*=0;
            if (this._snapToPages && !this._snapOnComplete) 
            {
                loc3 = this.stage === null ? starling.core.Starling.current : this.stage.starling;
                loc4 = 1000 * arg1 / (feathers.system.DeviceCapabilities.dpi / loc3.contentScaleFactor);
                if (loc4 > this._minimumPageThrowVelocity) 
                {
                    loc5 = feathers.utils.math.roundDownToNearest(this._horizontalScrollPosition, this.actualPageWidth);
                }
                else if (loc4 < -this._minimumPageThrowVelocity) 
                {
                    loc5 = feathers.utils.math.roundUpToNearest(this._horizontalScrollPosition, this.actualPageWidth);
                }
                else 
                {
                    loc6 = this._maxHorizontalScrollPosition % this.actualPageWidth;
                    loc7 = this._maxHorizontalScrollPosition - loc6;
                    if (loc6 < this.actualPageWidth && this._horizontalScrollPosition >= loc7) 
                    {
                        loc8 = this._horizontalScrollPosition - loc7;
                        if (loc4 > this._minimumPageThrowVelocity) 
                        {
                            loc5 = loc7 + feathers.utils.math.roundDownToNearest(loc8, loc6);
                        }
                        else if (loc4 < -this._minimumPageThrowVelocity) 
                        {
                            loc5 = loc7 + feathers.utils.math.roundUpToNearest(loc8, loc6);
                        }
                        else 
                        {
                            loc5 = loc7 + feathers.utils.math.roundToNearest(loc8, loc6);
                        }
                    }
                    else 
                    {
                        loc5 = feathers.utils.math.roundToNearest(this._horizontalScrollPosition, this.actualPageWidth);
                    }
                }
                if (loc5 < this._minHorizontalScrollPosition) 
                {
                    loc5 = this._minHorizontalScrollPosition;
                }
                else if (loc5 > this._maxHorizontalScrollPosition) 
                {
                    loc5 = this._maxHorizontalScrollPosition;
                }
                if (loc5 != this._maxHorizontalScrollPosition) 
                {
                    if (this._minHorizontalScrollPosition != Number.NEGATIVE_INFINITY) 
                    {
                        loc9 = Math.round((loc5 - this._minHorizontalScrollPosition) / this.actualPageWidth);
                    }
                    else 
                    {
                        loc9 = Math.round(loc5 / this.actualPageWidth);
                    }
                }
                else 
                {
                    loc9 = this._maxHorizontalPageIndex;
                }
                this.throwToPage(loc9, -1, this._pageThrowDuration);
                return;
            }
            var loc1:*=Math.abs(arg1);
            if (!this._snapToPages && loc1 <= MINIMUM_VELOCITY) 
            {
                this.finishScrollingHorizontally();
                return;
            }
            var loc2:*=this._fixedThrowDuration;
            if (!this._useFixedThrowDuration) 
            {
                loc2 = this.calculateDynamicThrowDuration(arg1);
            }
            this.throwTo(this._horizontalScrollPosition + this.calculateThrowDistance(arg1), NaN, loc2);
            return;
        }

        protected function throwVertically(arg1:Number):void
        {
            var loc3:*=null;
            var loc4:*=NaN;
            var loc5:*=NaN;
            var loc6:*=NaN;
            var loc7:*=NaN;
            var loc8:*=NaN;
            var loc9:*=0;
            if (this._snapToPages && !this._snapOnComplete) 
            {
                loc3 = this.stage === null ? starling.core.Starling.current : this.stage.starling;
                loc4 = 1000 * arg1 / (feathers.system.DeviceCapabilities.dpi / loc3.contentScaleFactor);
                if (loc4 > this._minimumPageThrowVelocity) 
                {
                    loc5 = feathers.utils.math.roundDownToNearest(this._verticalScrollPosition, this.actualPageHeight);
                }
                else if (loc4 < -this._minimumPageThrowVelocity) 
                {
                    loc5 = feathers.utils.math.roundUpToNearest(this._verticalScrollPosition, this.actualPageHeight);
                }
                else 
                {
                    loc6 = this._maxVerticalScrollPosition % this.actualPageHeight;
                    loc7 = this._maxVerticalScrollPosition - loc6;
                    if (loc6 < this.actualPageHeight && this._verticalScrollPosition >= loc7) 
                    {
                        loc8 = this._verticalScrollPosition - loc7;
                        if (loc4 > this._minimumPageThrowVelocity) 
                        {
                            loc5 = loc7 + feathers.utils.math.roundDownToNearest(loc8, loc6);
                        }
                        else if (loc4 < -this._minimumPageThrowVelocity) 
                        {
                            loc5 = loc7 + feathers.utils.math.roundUpToNearest(loc8, loc6);
                        }
                        else 
                        {
                            loc5 = loc7 + feathers.utils.math.roundToNearest(loc8, loc6);
                        }
                    }
                    else 
                    {
                        loc5 = feathers.utils.math.roundToNearest(this._verticalScrollPosition, this.actualPageHeight);
                    }
                }
                if (loc5 < this._minVerticalScrollPosition) 
                {
                    loc5 = this._minVerticalScrollPosition;
                }
                else if (loc5 > this._maxVerticalScrollPosition) 
                {
                    loc5 = this._maxVerticalScrollPosition;
                }
                if (loc5 != this._maxVerticalScrollPosition) 
                {
                    if (this._minVerticalScrollPosition != Number.NEGATIVE_INFINITY) 
                    {
                        loc9 = Math.round((loc5 - this._minVerticalScrollPosition) / this.actualPageHeight);
                    }
                    else 
                    {
                        loc9 = Math.round(loc5 / this.actualPageHeight);
                    }
                }
                else 
                {
                    loc9 = this._maxVerticalPageIndex;
                }
                this.throwToPage(-1, loc9, this._pageThrowDuration);
                return;
            }
            var loc1:*=Math.abs(arg1);
            if (!this._snapToPages && loc1 <= MINIMUM_VELOCITY) 
            {
                this.finishScrollingVertically();
                return;
            }
            var loc2:*=this._fixedThrowDuration;
            if (!this._useFixedThrowDuration) 
            {
                loc2 = this.calculateDynamicThrowDuration(arg1);
            }
            this.throwTo(NaN, this._verticalScrollPosition + this.calculateThrowDistance(arg1), loc2);
            return;
        }

        public function get horizontalScrollPosition():Number
        {
            return this._horizontalScrollPosition;
        }

        public function set horizontalScrollPosition(arg1:Number):void
        {
            if (this._horizontalScrollPosition == arg1) 
            {
                return;
            }
            if (arg1 !== arg1) 
            {
                throw new ArgumentError("horizontalScrollPosition cannot be NaN.");
            }
            this._horizontalScrollPosition = arg1;
            this.invalidate(INVALIDATION_FLAG_SCROLL);
            return;
        }

        protected function onHorizontalAutoScrollTweenUpdate():void
        {
            var loc1:*=this._horizontalAutoScrollTween.transitionFunc(this._horizontalAutoScrollTween.currentTime / this._horizontalAutoScrollTween.totalTime);
            if (loc1 >= this._horizontalAutoScrollTweenEndRatio) 
            {
                if (!this._hasElasticEdges) 
                {
                    if (this._horizontalScrollPosition < this._minHorizontalScrollPosition) 
                    {
                        this._horizontalScrollPosition = this._minHorizontalScrollPosition;
                    }
                    else if (this._horizontalScrollPosition > this._maxHorizontalScrollPosition) 
                    {
                        this._horizontalScrollPosition = this._maxHorizontalScrollPosition;
                    }
                }
                starling.core.Starling.juggler.remove(this._horizontalAutoScrollTween);
                this._horizontalAutoScrollTween = null;
                this.finishScrollingHorizontally();
            }
            return;
        }

        public function get minHorizontalScrollPosition():Number
        {
            return this._minHorizontalScrollPosition;
        }

        protected function onVerticalAutoScrollTweenUpdate():void
        {
            var loc1:*=this._verticalAutoScrollTween.transitionFunc(this._verticalAutoScrollTween.currentTime / this._verticalAutoScrollTween.totalTime);
            if (loc1 >= this._verticalAutoScrollTweenEndRatio) 
            {
                if (!this._hasElasticEdges) 
                {
                    if (this._verticalScrollPosition < this._minVerticalScrollPosition) 
                    {
                        this._verticalScrollPosition = this._minVerticalScrollPosition;
                    }
                    else if (this._verticalScrollPosition > this._maxVerticalScrollPosition) 
                    {
                        this._verticalScrollPosition = this._maxVerticalScrollPosition;
                    }
                }
                starling.core.Starling.juggler.remove(this._verticalAutoScrollTween);
                this._verticalAutoScrollTween = null;
                this.finishScrollingVertically();
            }
            return;
        }

        public function get maxHorizontalScrollPosition():Number
        {
            return this._maxHorizontalScrollPosition;
        }

        protected function refreshHorizontalAutoScrollTweenEndRatio():void
        {
            var loc1:*=Math.abs(this._targetHorizontalScrollPosition - this._startHorizontalScrollPosition);
            var loc2:*=0;
            if (this._targetHorizontalScrollPosition > this._maxHorizontalScrollPosition) 
            {
                loc2 = (this._targetHorizontalScrollPosition - this._maxHorizontalScrollPosition) / loc1;
            }
            else if (this._targetHorizontalScrollPosition < this._minHorizontalScrollPosition) 
            {
                loc2 = (this._minHorizontalScrollPosition - this._targetHorizontalScrollPosition) / loc1;
            }
            if (loc2 > 0) 
            {
                if (this._hasElasticEdges) 
                {
                    this._horizontalAutoScrollTweenEndRatio = 1 - loc2 + loc2 * this._throwElasticity;
                }
                else 
                {
                    this._horizontalAutoScrollTweenEndRatio = 1 - loc2;
                }
            }
            else 
            {
                this._horizontalAutoScrollTweenEndRatio = 1;
            }
            if (this._horizontalAutoScrollTween) 
            {
                if (this._horizontalAutoScrollTweenEndRatio < 1) 
                {
                    this._horizontalAutoScrollTween.onUpdate = this.onHorizontalAutoScrollTweenUpdate;
                }
                else 
                {
                    this._horizontalAutoScrollTween.onUpdate = null;
                }
            }
            return;
        }

        protected function refreshVerticalAutoScrollTweenEndRatio():void
        {
            var loc1:*=Math.abs(this._targetVerticalScrollPosition - this._startVerticalScrollPosition);
            var loc2:*=0;
            if (this._targetVerticalScrollPosition > this._maxVerticalScrollPosition) 
            {
                loc2 = (this._targetVerticalScrollPosition - this._maxVerticalScrollPosition) / loc1;
            }
            else if (this._targetVerticalScrollPosition < this._minVerticalScrollPosition) 
            {
                loc2 = (this._minVerticalScrollPosition - this._targetVerticalScrollPosition) / loc1;
            }
            if (loc2 > 0) 
            {
                if (this._hasElasticEdges) 
                {
                    this._verticalAutoScrollTweenEndRatio = 1 - loc2 + loc2 * this._throwElasticity;
                }
                else 
                {
                    this._verticalAutoScrollTweenEndRatio = 1 - loc2;
                }
            }
            else 
            {
                this._verticalAutoScrollTweenEndRatio = 1;
            }
            if (this._verticalAutoScrollTween) 
            {
                if (this._verticalAutoScrollTweenEndRatio < 1) 
                {
                    this._verticalAutoScrollTween.onUpdate = this.onVerticalAutoScrollTweenUpdate;
                }
                else 
                {
                    this._verticalAutoScrollTween.onUpdate = null;
                }
            }
            return;
        }

        protected function hideHorizontalScrollBar(arg1:Number=0):void
        {
            if (!this.horizontalScrollBar || !(this._scrollBarDisplayMode == feathers.controls.ScrollBarDisplayMode.FLOAT) || this._horizontalScrollBarHideTween) 
            {
                return;
            }
            if (this.horizontalScrollBar.alpha == 0) 
            {
                return;
            }
            if (this._hideScrollBarAnimationDuration == 0 && arg1 == 0) 
            {
                this.horizontalScrollBar.alpha = 0;
            }
            else 
            {
                this._horizontalScrollBarHideTween = new starling.animation.Tween(this.horizontalScrollBar, this._hideScrollBarAnimationDuration, this._hideScrollBarAnimationEase);
                this._horizontalScrollBarHideTween.fadeTo(0);
                this._horizontalScrollBarHideTween.delay = arg1;
                this._horizontalScrollBarHideTween.onComplete = this.horizontalScrollBarHideTween_onComplete;
                starling.core.Starling.juggler.add(this._horizontalScrollBarHideTween);
            }
            return;
        }

        public function get minHorizontalPageIndex():int
        {
            return this._minHorizontalPageIndex;
        }

        protected function hideVerticalScrollBar(arg1:Number=0):void
        {
            if (!this.verticalScrollBar || !(this._scrollBarDisplayMode == feathers.controls.ScrollBarDisplayMode.FLOAT) || this._verticalScrollBarHideTween) 
            {
                return;
            }
            if (this.verticalScrollBar.alpha == 0) 
            {
                return;
            }
            if (this._hideScrollBarAnimationDuration == 0 && arg1 == 0) 
            {
                this.verticalScrollBar.alpha = 0;
            }
            else 
            {
                this._verticalScrollBarHideTween = new starling.animation.Tween(this.verticalScrollBar, this._hideScrollBarAnimationDuration, this._hideScrollBarAnimationEase);
                this._verticalScrollBarHideTween.fadeTo(0);
                this._verticalScrollBarHideTween.delay = arg1;
                this._verticalScrollBarHideTween.onComplete = this.verticalScrollBarHideTween_onComplete;
                starling.core.Starling.juggler.add(this._verticalScrollBarHideTween);
            }
            return;
        }

        public function get maxHorizontalPageIndex():int
        {
            return this._maxHorizontalPageIndex;
        }

        public function get horizontalPageCount():int
        {
            if (this._maxHorizontalPageIndex == int.MAX_VALUE || this._minHorizontalPageIndex == int.MIN_VALUE) 
            {
                return int.MAX_VALUE;
            }
            return this._maxHorizontalPageIndex - this._minHorizontalPageIndex + 1;
        }

        protected function revealHorizontalScrollBar():void
        {
            if (!this.horizontalScrollBar || !(this._scrollBarDisplayMode == feathers.controls.ScrollBarDisplayMode.FLOAT)) 
            {
                return;
            }
            if (this._horizontalScrollBarHideTween) 
            {
                starling.core.Starling.juggler.remove(this._horizontalScrollBarHideTween);
                this._horizontalScrollBarHideTween = null;
            }
            this.horizontalScrollBar.alpha = 1;
            return;
        }

        public function get horizontalScrollPolicy():String
        {
            return this._horizontalScrollPolicy;
        }

        public function set horizontalScrollPolicy(arg1:String):void
        {
            if (this._horizontalScrollPolicy == arg1) 
            {
                return;
            }
            this._horizontalScrollPolicy = arg1;
            this.invalidate(INVALIDATION_FLAG_SCROLL);
            this.invalidate(INVALIDATION_FLAG_SCROLL_BAR_RENDERER);
            return;
        }

        protected function revealVerticalScrollBar():void
        {
            if (!this.verticalScrollBar || !(this._scrollBarDisplayMode == feathers.controls.ScrollBarDisplayMode.FLOAT)) 
            {
                return;
            }
            if (this._verticalScrollBarHideTween) 
            {
                starling.core.Starling.juggler.remove(this._verticalScrollBarHideTween);
                this._verticalScrollBarHideTween = null;
            }
            this.verticalScrollBar.alpha = 1;
            return;
        }

        protected function startScroll():void
        {
            if (this._isScrolling) 
            {
                return;
            }
            this._isScrolling = true;
            if (this._touchBlocker) 
            {
                this.addRawChildInternal(this._touchBlocker);
            }
            this.dispatchEventWith(feathers.events.FeathersEventType.SCROLL_START);
            return;
        }

        public function get verticalScrollStep():Number
        {
            return this.actualVerticalScrollStep;
        }

        public function set verticalScrollStep(arg1:Number):void
        {
            if (this.explicitVerticalScrollStep == arg1) 
            {
                return;
            }
            this.explicitVerticalScrollStep = arg1;
            this.invalidate(INVALIDATION_FLAG_SCROLL);
            return;
        }

        protected function completeScroll():void
        {
            if (!this._isScrolling || this._verticalAutoScrollTween || this._horizontalAutoScrollTween || this._isDraggingHorizontally || this._isDraggingVertically || this._horizontalScrollBarIsScrolling || this._verticalScrollBarIsScrolling) 
            {
                return;
            }
            this._isScrolling = false;
            if (this._touchBlocker) 
            {
                this.removeRawChildInternal(this._touchBlocker, false);
            }
            this.hideHorizontalScrollBar();
            this.hideVerticalScrollBar();
            this.validate();
            this.dispatchEventWith(feathers.events.FeathersEventType.SCROLL_COMPLETE);
            return;
        }

        public function get verticalMouseWheelScrollStep():Number
        {
            return this._verticalMouseWheelScrollStep;
        }

        public function set verticalMouseWheelScrollStep(arg1:Number):void
        {
            if (this._verticalMouseWheelScrollStep == arg1) 
            {
                return;
            }
            this._verticalMouseWheelScrollStep = arg1;
            this.invalidate(INVALIDATION_FLAG_SCROLL);
            return;
        }

        protected function handlePendingScroll():void
        {
            if (this.pendingHorizontalScrollPosition === this.pendingHorizontalScrollPosition || this.pendingVerticalScrollPosition === this.pendingVerticalScrollPosition) 
            {
                this.throwTo(this.pendingHorizontalScrollPosition, this.pendingVerticalScrollPosition, this.pendingScrollDuration);
                this.pendingHorizontalScrollPosition = NaN;
                this.pendingVerticalScrollPosition = NaN;
            }
            if (this.hasPendingHorizontalPageIndex && this.hasPendingVerticalPageIndex) 
            {
                this.throwToPage(this.pendingHorizontalPageIndex, this.pendingVerticalPageIndex, this.pendingScrollDuration);
            }
            else if (this.hasPendingHorizontalPageIndex) 
            {
                this.throwToPage(this.pendingHorizontalPageIndex, this._verticalPageIndex, this.pendingScrollDuration);
            }
            else if (this.hasPendingVerticalPageIndex) 
            {
                this.throwToPage(this._horizontalPageIndex, this.pendingVerticalPageIndex, this.pendingScrollDuration);
            }
            this.hasPendingHorizontalPageIndex = false;
            this.hasPendingVerticalPageIndex = false;
            return;
        }

        protected function handlePendingRevealScrollBars():void
        {
            if (!this.isScrollBarRevealPending) 
            {
                return;
            }
            this.isScrollBarRevealPending = false;
            if (this._scrollBarDisplayMode != feathers.controls.ScrollBarDisplayMode.FLOAT) 
            {
                return;
            }
            this.revealHorizontalScrollBar();
            this.revealVerticalScrollBar();
            this.hideHorizontalScrollBar(this._revealScrollBarsDuration);
            this.hideVerticalScrollBar(this._revealScrollBarsDuration);
            return;
        }

        public function get verticalScrollPosition():Number
        {
            return this._verticalScrollPosition;
        }

        public function set verticalScrollPosition(arg1:Number):void
        {
            if (this._verticalScrollPosition == arg1) 
            {
                return;
            }
            if (arg1 !== arg1) 
            {
                throw new ArgumentError("verticalScrollPosition cannot be NaN.");
            }
            this._verticalScrollPosition = arg1;
            this.invalidate(INVALIDATION_FLAG_SCROLL);
            return;
        }

        protected function checkForDrag():void
        {
            var loc4:*=null;
            if (this._isScrollingStopped) 
            {
                return;
            }
            var loc1:*=this.stage === null ? starling.core.Starling.current : this.stage.starling;
            var loc2:*=Math.abs(this._currentTouchX - this._startTouchX) / (feathers.system.DeviceCapabilities.dpi / loc1.contentScaleFactor);
            var loc3:*=Math.abs(this._currentTouchY - this._startTouchY) / (feathers.system.DeviceCapabilities.dpi / loc1.contentScaleFactor);
            if ((this._horizontalScrollPolicy == feathers.controls.ScrollPolicy.ON || this._horizontalScrollPolicy == feathers.controls.ScrollPolicy.AUTO && !(this._minHorizontalScrollPosition == this._maxHorizontalScrollPosition)) && !this._isDraggingHorizontally && loc2 >= this._minimumDragDistance) 
            {
                if (this.horizontalScrollBar) 
                {
                    this.revealHorizontalScrollBar();
                }
                this._startTouchX = this._currentTouchX;
                this._startHorizontalScrollPosition = this._horizontalScrollPosition;
                this._isDraggingHorizontally = true;
                if (!this._isDraggingVertically) 
                {
                    this.dispatchEventWith(feathers.events.FeathersEventType.BEGIN_INTERACTION);
                    loc4 = feathers.events.ExclusiveTouch.forStage(this.stage);
                    loc4.removeEventListener(starling.events.Event.CHANGE, this.exclusiveTouch_changeHandler);
                    loc4.claimTouch(this._touchPointID, this);
                    this.startScroll();
                }
            }
            if ((this._verticalScrollPolicy == feathers.controls.ScrollPolicy.ON || this._verticalScrollPolicy == feathers.controls.ScrollPolicy.AUTO && !(this._minVerticalScrollPosition == this._maxVerticalScrollPosition)) && !this._isDraggingVertically && loc3 >= this._minimumDragDistance) 
            {
                if (this.verticalScrollBar) 
                {
                    this.revealVerticalScrollBar();
                }
                this._startTouchY = this._currentTouchY;
                this._startVerticalScrollPosition = this._verticalScrollPosition;
                this._isDraggingVertically = true;
                if (!this._isDraggingHorizontally) 
                {
                    loc4 = feathers.events.ExclusiveTouch.forStage(this.stage);
                    loc4.removeEventListener(starling.events.Event.CHANGE, this.exclusiveTouch_changeHandler);
                    loc4.claimTouch(this._touchPointID, this);
                    this.dispatchEventWith(feathers.events.FeathersEventType.BEGIN_INTERACTION);
                    this.startScroll();
                }
            }
            if (this._isDraggingHorizontally && !this._horizontalAutoScrollTween) 
            {
                this.updateHorizontalScrollFromTouchPosition(this._currentTouchX);
            }
            if (this._isDraggingVertically && !this._verticalAutoScrollTween) 
            {
                this.updateVerticalScrollFromTouchPosition(this._currentTouchY);
            }
            return;
        }

        public function get minVerticalScrollPosition():Number
        {
            return this._minVerticalScrollPosition;
        }

        protected function saveVelocity():void
        {
            this._pendingVelocityChange = false;
            if (this._isScrollingStopped) 
            {
                return;
            }
            var loc1:*=flash.utils.getTimer();
            var loc2:*=loc1 - this._previousTouchTime;
            if (loc2 > 0) 
            {
                this._previousVelocityX[this._previousVelocityX.length] = this._velocityX;
                if (this._previousVelocityX.length > MAXIMUM_SAVED_VELOCITY_COUNT) 
                {
                    this._previousVelocityX.shift();
                }
                this._previousVelocityY[this._previousVelocityY.length] = this._velocityY;
                if (this._previousVelocityY.length > MAXIMUM_SAVED_VELOCITY_COUNT) 
                {
                    this._previousVelocityY.shift();
                }
                this._velocityX = (this._currentTouchX - this._previousTouchX) / loc2;
                this._velocityY = (this._currentTouchY - this._previousTouchY) / loc2;
                this._previousTouchTime = loc1;
                this._previousTouchX = this._currentTouchX;
                this._previousTouchY = this._currentTouchY;
            }
            return;
        }

        public function get maxVerticalScrollPosition():Number
        {
            return this._maxVerticalScrollPosition;
        }

        protected function viewPort_resizeHandler(arg1:starling.events.Event):void
        {
            if (this.ignoreViewPortResizing || this._viewPort.width === this._lastViewPortWidth && this._viewPort.height === this._lastViewPortHeight) 
            {
                return;
            }
            this._lastViewPortWidth = this._viewPort.width;
            this._lastViewPortHeight = this._viewPort.height;
            if (this._isValidating) 
            {
                this._hasViewPortBoundsChanged = true;
            }
            else 
            {
                this.invalidate(INVALIDATION_FLAG_SIZE);
            }
            return;
        }

        public function get verticalPageIndex():int
        {
            if (this.hasPendingVerticalPageIndex) 
            {
                return this.pendingVerticalPageIndex;
            }
            return this._verticalPageIndex;
        }

        protected function childProperties_onChange(arg1:feathers.core.PropertyProxy, arg2:String):void
        {
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get minVerticalPageIndex():int
        {
            return this._minVerticalPageIndex;
        }

        protected function verticalScrollBar_changeHandler(arg1:starling.events.Event):void
        {
            this.verticalScrollPosition = this.verticalScrollBar.value;
            return;
        }

        public function get maxVerticalPageIndex():int
        {
            return this._maxVerticalPageIndex;
        }

        public function get verticalPageCount():int
        {
            if (this._maxVerticalPageIndex == int.MAX_VALUE || this._minVerticalPageIndex == int.MIN_VALUE) 
            {
                return int.MAX_VALUE;
            }
            return this._maxVerticalPageIndex - this._minVerticalPageIndex + 1;
        }

        protected function horizontalScrollBar_changeHandler(arg1:starling.events.Event):void
        {
            this.horizontalScrollPosition = this.horizontalScrollBar.value;
            return;
        }

        public function get verticalScrollPolicy():String
        {
            return this._verticalScrollPolicy;
        }

        public function set verticalScrollPolicy(arg1:String):void
        {
            if (this._verticalScrollPolicy == arg1) 
            {
                return;
            }
            this._verticalScrollPolicy = arg1;
            this.invalidate(INVALIDATION_FLAG_SCROLL);
            this.invalidate(INVALIDATION_FLAG_SCROLL_BAR_RENDERER);
            return;
        }

        protected function horizontalScrollBar_beginInteractionHandler(arg1:starling.events.Event):void
        {
            if (this._horizontalAutoScrollTween) 
            {
                starling.core.Starling.juggler.remove(this._horizontalAutoScrollTween);
                this._horizontalAutoScrollTween = null;
            }
            this._isDraggingHorizontally = false;
            this._horizontalScrollBarIsScrolling = true;
            this.dispatchEventWith(feathers.events.FeathersEventType.BEGIN_INTERACTION);
            if (!this._isScrolling) 
            {
                this.startScroll();
            }
            return;
        }

        public function get clipContent():Boolean
        {
            return this._clipContent;
        }

        public function set clipContent(arg1:Boolean):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._clipContent === arg1) 
            {
                return;
            }
            this._clipContent = arg1;
            if (!arg1 && this._viewPort) 
            {
                this._viewPort.mask = null;
            }
            this.invalidate(INVALIDATION_FLAG_CLIPPING);
            return;
        }

        protected function horizontalScrollBar_endInteractionHandler(arg1:starling.events.Event):void
        {
            this._horizontalScrollBarIsScrolling = false;
            this.dispatchEventWith(feathers.events.FeathersEventType.END_INTERACTION);
            this.completeScroll();
            return;
        }

        protected function verticalScrollBar_beginInteractionHandler(arg1:starling.events.Event):void
        {
            if (this._verticalAutoScrollTween) 
            {
                starling.core.Starling.juggler.remove(this._verticalAutoScrollTween);
                this._verticalAutoScrollTween = null;
            }
            this._isDraggingVertically = false;
            this._verticalScrollBarIsScrolling = true;
            this.dispatchEventWith(feathers.events.FeathersEventType.BEGIN_INTERACTION);
            if (!this._isScrolling) 
            {
                this.startScroll();
            }
            return;
        }

        public function get pageWidth():Number
        {
            return this.actualPageWidth;
        }

        public function set pageWidth(arg1:Number):void
        {
            if (this.explicitPageWidth == arg1) 
            {
                return;
            }
            var loc1:*=!(arg1 === arg1);
            if (loc1 && !(this.explicitPageWidth === this.explicitPageWidth)) 
            {
                return;
            }
            this.explicitPageWidth = arg1;
            if (loc1) 
            {
                this.actualPageWidth = 0;
            }
            else 
            {
                this.actualPageWidth = this.explicitPageWidth;
            }
            return;
        }

        protected function verticalScrollBar_endInteractionHandler(arg1:starling.events.Event):void
        {
            this._verticalScrollBarIsScrolling = false;
            this.dispatchEventWith(feathers.events.FeathersEventType.END_INTERACTION);
            this.completeScroll();
            return;
        }

        protected function horizontalAutoScrollTween_onComplete():void
        {
            this._horizontalAutoScrollTween = null;
            this.invalidate(INVALIDATION_FLAG_SCROLL);
            this.finishScrollingHorizontally();
            return;
        }

        public function get pageHeight():Number
        {
            return this.actualPageHeight;
        }

        public function set pageHeight(arg1:Number):void
        {
            if (this.explicitPageHeight == arg1) 
            {
                return;
            }
            var loc1:*=!(arg1 === arg1);
            if (loc1 && !(this.explicitPageHeight === this.explicitPageHeight)) 
            {
                return;
            }
            this.explicitPageHeight = arg1;
            if (loc1) 
            {
                this.actualPageHeight = 0;
            }
            else 
            {
                this.actualPageHeight = this.explicitPageHeight;
            }
            return;
        }

        protected function verticalAutoScrollTween_onComplete():void
        {
            this._verticalAutoScrollTween = null;
            this.invalidate(INVALIDATION_FLAG_SCROLL);
            this.finishScrollingVertically();
            return;
        }

        public function get hasElasticEdges():Boolean
        {
            return this._hasElasticEdges;
        }

        public function set hasElasticEdges(arg1:Boolean):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            this._hasElasticEdges = arg1;
            return;
        }

        protected function horizontalScrollBarHideTween_onComplete():void
        {
            this._horizontalScrollBarHideTween = null;
            return;
        }

        public function get elasticity():Number
        {
            return this._elasticity;
        }

        public function set elasticity(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            this._elasticity = arg1;
            return;
        }

        protected function verticalScrollBarHideTween_onComplete():void
        {
            this._verticalScrollBarHideTween = null;
            return;
        }

        public function get throwElasticity():Number
        {
            return this._throwElasticity;
        }

        public function set throwElasticity(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            this._throwElasticity = arg1;
            return;
        }

        protected function scroller_touchHandler(arg1:starling.events.TouchEvent):void
        {
            if (!this._isEnabled) 
            {
                this._touchPointID = -1;
                return;
            }
            if (this._touchPointID >= 0) 
            {
                return;
            }
            var loc1:*=arg1.getTouch(this, starling.events.TouchPhase.BEGAN);
            if (!loc1) 
            {
                return;
            }
            if (this._interactionMode == feathers.controls.ScrollInteractionMode.TOUCH_AND_SCROLL_BARS && (arg1.interactsWith(starling.display.DisplayObject(this.horizontalScrollBar)) || arg1.interactsWith(starling.display.DisplayObject(this.verticalScrollBar)))) 
            {
                return;
            }
            loc1.getLocation(this, HELPER_POINT);
            var loc2:*=HELPER_POINT.x;
            var loc3:*=HELPER_POINT.y;
            if (loc2 < this._leftViewPortOffset || loc3 < this._topViewPortOffset || loc2 >= this.actualWidth - this._rightViewPortOffset || loc3 >= this.actualHeight - this._bottomViewPortOffset) 
            {
                return;
            }
            var loc4:*=feathers.events.ExclusiveTouch.forStage(this.stage);
            if (loc4.getClaim(loc1.id)) 
            {
                return;
            }
            if (this._horizontalAutoScrollTween && !(this._horizontalScrollPolicy == feathers.controls.ScrollPolicy.OFF)) 
            {
                starling.core.Starling.juggler.remove(this._horizontalAutoScrollTween);
                this._horizontalAutoScrollTween = null;
                if (this._isScrolling) 
                {
                    this._isDraggingHorizontally = true;
                }
            }
            if (this._verticalAutoScrollTween && !(this._verticalScrollPolicy == feathers.controls.ScrollPolicy.OFF)) 
            {
                starling.core.Starling.juggler.remove(this._verticalAutoScrollTween);
                this._verticalAutoScrollTween = null;
                if (this._isScrolling) 
                {
                    this._isDraggingVertically = true;
                }
            }
            this._touchPointID = loc1.id;
            this._velocityX = 0;
            this._velocityY = 0;
            this._previousVelocityX.length = 0;
            this._previousVelocityY.length = 0;
            this._previousTouchTime = flash.utils.getTimer();
            var loc5:*;
            this._currentTouchX = loc5 = loc2;
            this._startTouchX = loc5 = loc5;
            this._previousTouchX = loc5;
            this._currentTouchY = loc5 = loc3;
            this._startTouchY = loc5 = loc5;
            this._previousTouchY = loc5;
            this._startHorizontalScrollPosition = this._horizontalScrollPosition;
            this._startVerticalScrollPosition = this._verticalScrollPosition;
            this._isScrollingStopped = false;
            this.addEventListener(starling.events.Event.ENTER_FRAME, this.scroller_enterFrameHandler);
            this.stage.addEventListener(starling.events.TouchEvent.TOUCH, this.stage_touchHandler);
            if (this._isScrolling && (this._isDraggingHorizontally || this._isDraggingVertically)) 
            {
                loc4.claimTouch(this._touchPointID, this);
            }
            else 
            {
                loc4.addEventListener(starling.events.Event.CHANGE, this.exclusiveTouch_changeHandler);
            }
            return;
        }

        public function get scrollBarDisplayMode():String
        {
            return this._scrollBarDisplayMode;
        }

        public function set scrollBarDisplayMode(arg1:String):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._scrollBarDisplayMode === arg1) 
            {
                return;
            }
            this._scrollBarDisplayMode = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function scroller_enterFrameHandler(arg1:starling.events.Event):void
        {
            this.saveVelocity();
            return;
        }

        public function get interactionMode():String
        {
            return this._interactionMode;
        }

        public function set interactionMode(arg1:String):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._interactionMode === arg1) 
            {
                return;
            }
            this._interactionMode = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function stage_touchHandler(arg1:starling.events.TouchEvent):void
        {
            var loc2:*=false;
            var loc3:*=false;
            var loc4:*=NaN;
            var loc5:*=0;
            var loc6:*=NaN;
            var loc7:*=0;
            var loc8:*=NaN;
            if (this._touchPointID < 0) 
            {
                return;
            }
            var loc1:*=arg1.getTouch(this.stage, null, this._touchPointID);
            if (loc1 === null) 
            {
                return;
            }
            if (loc1.phase !== starling.events.TouchPhase.MOVED) 
            {
                if (loc1.phase === starling.events.TouchPhase.ENDED) 
                {
                    if (this._pendingVelocityChange) 
                    {
                        this.saveVelocity();
                    }
                    if (!this._isDraggingHorizontally && !this._isDraggingVertically) 
                    {
                        feathers.events.ExclusiveTouch.forStage(this.stage).removeEventListener(starling.events.Event.CHANGE, this.exclusiveTouch_changeHandler);
                    }
                    this.removeEventListener(starling.events.Event.ENTER_FRAME, this.scroller_enterFrameHandler);
                    this.stage.removeEventListener(starling.events.TouchEvent.TOUCH, this.stage_touchHandler);
                    this._touchPointID = -1;
                    this.dispatchEventWith(feathers.events.FeathersEventType.END_INTERACTION);
                    loc2 = false;
                    loc3 = false;
                    if (this._horizontalScrollPosition < this._minHorizontalScrollPosition || this._horizontalScrollPosition > this._maxHorizontalScrollPosition) 
                    {
                        loc2 = true;
                        this.finishScrollingHorizontally();
                    }
                    if (this._verticalScrollPosition < this._minVerticalScrollPosition || this._verticalScrollPosition > this._maxVerticalScrollPosition) 
                    {
                        loc3 = true;
                        this.finishScrollingVertically();
                    }
                    if (loc2 && loc3) 
                    {
                        return;
                    }
                    if (!loc2 && this._isDraggingHorizontally) 
                    {
                        loc4 = this._velocityX * CURRENT_VELOCITY_WEIGHT;
                        loc5 = this._previousVelocityX.length;
                        loc6 = CURRENT_VELOCITY_WEIGHT;
                        loc7 = 0;
                        while (loc7 < loc5) 
                        {
                            loc8 = VELOCITY_WEIGHTS[loc7];
                            loc4 = loc4 + this._previousVelocityX.shift() * loc8;
                            loc6 = loc6 + loc8;
                            ++loc7;
                        }
                        this.throwHorizontally(loc4 / loc6);
                    }
                    else 
                    {
                        this.hideHorizontalScrollBar();
                    }
                    if (!loc3 && this._isDraggingVertically) 
                    {
                        loc4 = this._velocityY * CURRENT_VELOCITY_WEIGHT;
                        loc5 = this._previousVelocityY.length;
                        loc6 = CURRENT_VELOCITY_WEIGHT;
                        loc7 = 0;
                        while (loc7 < loc5) 
                        {
                            loc8 = VELOCITY_WEIGHTS[loc7];
                            loc4 = loc4 + this._previousVelocityY.shift() * loc8;
                            loc6 = loc6 + loc8;
                            ++loc7;
                        }
                        this.throwVertically(loc4 / loc6);
                    }
                    else 
                    {
                        this.hideVerticalScrollBar();
                    }
                }
            }
            else 
            {
                loc1.getLocation(this, HELPER_POINT);
                this._currentTouchX = HELPER_POINT.x;
                this._currentTouchY = HELPER_POINT.y;
                this.checkForDrag();
                this._pendingVelocityChange = true;
            }
            return;
        }

        protected function exclusiveTouch_changeHandler(arg1:starling.events.Event, arg2:int):void
        {
            if (this._touchPointID < 0 || !(this._touchPointID == arg2) || this._isDraggingHorizontally || this._isDraggingVertically) 
            {
                return;
            }
            var loc1:*=feathers.events.ExclusiveTouch.forStage(this.stage);
            if (loc1.getClaim(arg2) == this) 
            {
                return;
            }
            this._touchPointID = -1;
            this.removeEventListener(starling.events.Event.ENTER_FRAME, this.scroller_enterFrameHandler);
            this.stage.removeEventListener(starling.events.TouchEvent.TOUCH, this.stage_touchHandler);
            loc1.removeEventListener(starling.events.Event.CHANGE, this.exclusiveTouch_changeHandler);
            this.dispatchEventWith(feathers.events.FeathersEventType.END_INTERACTION);
            return;
        }

        protected function nativeStage_mouseWheelHandler(arg1:flash.events.MouseEvent):void
        {
            var loc5:*=NaN;
            var loc6:*=NaN;
            var loc7:*=NaN;
            var loc8:*=NaN;
            var loc9:*=NaN;
            if (!this._isEnabled) 
            {
                this._touchPointID = -1;
                return;
            }
            if (this._verticalMouseWheelScrollDirection === feathers.layout.Direction.VERTICAL && (this._maxVerticalScrollPosition == this._minVerticalScrollPosition || this._verticalScrollPolicy == feathers.controls.ScrollPolicy.OFF) || this._verticalMouseWheelScrollDirection === feathers.layout.Direction.HORIZONTAL && (this._maxHorizontalScrollPosition == this._minHorizontalScrollPosition || this._horizontalScrollPolicy == feathers.controls.ScrollPolicy.OFF)) 
            {
                return;
            }
            var loc1:*=this.stage === null ? starling.core.Starling.current : this.stage.starling;
            var loc2:*=1;
            if (loc1.supportHighResolutions) 
            {
                loc2 = loc1.nativeStage.contentsScaleFactor;
            }
            var loc3:*=loc1.viewPort;
            var loc4:*=loc2 / loc1.contentScaleFactor;
            HELPER_POINT.x = (arg1.stageX - loc3.x) * loc4;
            HELPER_POINT.y = (arg1.stageY - loc3.y) * loc4;
            if (this.contains(this.stage.hitTest(HELPER_POINT))) 
            {
                this.globalToLocal(HELPER_POINT, HELPER_POINT);
                loc5 = HELPER_POINT.x;
                loc6 = HELPER_POINT.y;
                if (loc5 < this._leftViewPortOffset || loc6 < this._topViewPortOffset || loc5 >= this.actualWidth - this._rightViewPortOffset || loc6 >= this.actualHeight - this._bottomViewPortOffset) 
                {
                    return;
                }
                loc7 = this._horizontalScrollPosition;
                loc8 = this._verticalScrollPosition;
                loc9 = this._verticalMouseWheelScrollStep;
                if (this._verticalMouseWheelScrollDirection != feathers.layout.Direction.HORIZONTAL) 
                {
                    if (loc9 !== loc9) 
                    {
                        loc9 = this.actualVerticalScrollStep;
                    }
                    loc8 = loc8 - arg1.delta * loc9;
                    if (loc8 < this._minVerticalScrollPosition) 
                    {
                        loc8 = this._minVerticalScrollPosition;
                    }
                    else if (loc8 > this._maxVerticalScrollPosition) 
                    {
                        loc8 = this._maxVerticalScrollPosition;
                    }
                }
                else 
                {
                    if (loc9 !== loc9) 
                    {
                        loc9 = this.actualHorizontalScrollStep;
                    }
                    loc7 = loc7 - arg1.delta * loc9;
                    if (loc7 < this._minHorizontalScrollPosition) 
                    {
                        loc7 = this._minHorizontalScrollPosition;
                    }
                    else if (loc7 > this._maxHorizontalScrollPosition) 
                    {
                        loc7 = this._maxHorizontalScrollPosition;
                    }
                }
                this.throwTo(loc7, loc8, this._mouseWheelScrollDuration);
            }
            return;
        }

        protected function nativeStage_orientationChangeHandler(arg1:flash.events.Event):void
        {
            if (this._touchPointID < 0) 
            {
                return;
            }
            var loc1:*;
            this._previousTouchX = loc1 = this._currentTouchX;
            this._startTouchX = loc1;
            this._previousTouchY = loc1 = this._currentTouchY;
            this._startTouchY = loc1;
            this._startHorizontalScrollPosition = this._horizontalScrollPosition;
            this._startVerticalScrollPosition = this._verticalScrollPosition;
            return;
        }

        protected function horizontalScrollBar_touchHandler(arg1:starling.events.TouchEvent):void
        {
            var loc2:*=null;
            var loc3:*=false;
            if (!this._isEnabled) 
            {
                this._horizontalScrollBarTouchPointID = -1;
                return;
            }
            var loc1:*=starling.display.DisplayObject(arg1.currentTarget);
            if (this._horizontalScrollBarTouchPointID >= 0) 
            {
                loc2 = arg1.getTouch(loc1, starling.events.TouchPhase.ENDED, this._horizontalScrollBarTouchPointID);
                if (!loc2) 
                {
                    return;
                }
                this._horizontalScrollBarTouchPointID = -1;
                loc2.getLocation(loc1, HELPER_POINT);
                loc3 = !(this.horizontalScrollBar.hitTest(HELPER_POINT) === null);
                if (!loc3) 
                {
                    this.hideHorizontalScrollBar();
                }
            }
            else 
            {
                loc2 = arg1.getTouch(loc1, starling.events.TouchPhase.BEGAN);
                if (loc2) 
                {
                    this._horizontalScrollBarTouchPointID = loc2.id;
                    return;
                }
                if (this._isScrolling) 
                {
                    return;
                }
                loc2 = arg1.getTouch(loc1, starling.events.TouchPhase.HOVER);
                if (loc2) 
                {
                    this.revealHorizontalScrollBar();
                    return;
                }
                this.hideHorizontalScrollBar();
            }
            return;
        }

        protected function verticalScrollBar_touchHandler(arg1:starling.events.TouchEvent):void
        {
            var loc2:*=null;
            var loc3:*=false;
            if (!this._isEnabled) 
            {
                this._verticalScrollBarTouchPointID = -1;
                return;
            }
            var loc1:*=starling.display.DisplayObject(arg1.currentTarget);
            if (this._verticalScrollBarTouchPointID >= 0) 
            {
                loc2 = arg1.getTouch(loc1, starling.events.TouchPhase.ENDED, this._verticalScrollBarTouchPointID);
                if (!loc2) 
                {
                    return;
                }
                this._verticalScrollBarTouchPointID = -1;
                loc2.getLocation(loc1, HELPER_POINT);
                loc3 = !(this.verticalScrollBar.hitTest(HELPER_POINT) === null);
                if (!loc3) 
                {
                    this.hideVerticalScrollBar();
                }
            }
            else 
            {
                loc2 = arg1.getTouch(loc1, starling.events.TouchPhase.BEGAN);
                if (loc2) 
                {
                    this._verticalScrollBarTouchPointID = loc2.id;
                    return;
                }
                if (this._isScrolling) 
                {
                    return;
                }
                loc2 = arg1.getTouch(loc1, starling.events.TouchPhase.HOVER);
                if (loc2) 
                {
                    this.revealVerticalScrollBar();
                    return;
                }
                this.hideVerticalScrollBar();
            }
            return;
        }

        protected function scroller_addedToStageHandler(arg1:starling.events.Event):void
        {
            var loc1:*=this.stage === null ? starling.core.Starling.current : this.stage.starling;
            loc1.nativeStage.addEventListener(flash.events.MouseEvent.MOUSE_WHEEL, this.nativeStage_mouseWheelHandler, false, 0, true);
            loc1.nativeStage.addEventListener("orientationChange", this.nativeStage_orientationChangeHandler, false, 0, true);
            return;
        }

        protected function scroller_removedFromStageHandler(arg1:starling.events.Event):void
        {
            var loc4:*=null;
            var loc1:*=this.stage === null ? starling.core.Starling.current : this.stage.starling;
            loc1.nativeStage.removeEventListener(flash.events.MouseEvent.MOUSE_WHEEL, this.nativeStage_mouseWheelHandler);
            loc1.nativeStage.removeEventListener("orientationChange", this.nativeStage_orientationChangeHandler);
            if (this._touchPointID >= 0) 
            {
                loc4 = feathers.events.ExclusiveTouch.forStage(this.stage);
                loc4.removeEventListener(starling.events.Event.CHANGE, this.exclusiveTouch_changeHandler);
            }
            this._touchPointID = -1;
            this._horizontalScrollBarTouchPointID = -1;
            this._verticalScrollBarTouchPointID = -1;
            this._isDraggingHorizontally = false;
            this._isDraggingVertically = false;
            this._velocityX = 0;
            this._velocityY = 0;
            this._previousVelocityX.length = 0;
            this._previousVelocityY.length = 0;
            this._horizontalScrollBarIsScrolling = false;
            this._verticalScrollBarIsScrolling = false;
            this.removeEventListener(starling.events.Event.ENTER_FRAME, this.scroller_enterFrameHandler);
            this.stage.removeEventListener(starling.events.TouchEvent.TOUCH, this.stage_touchHandler);
            if (this._verticalAutoScrollTween) 
            {
                starling.core.Starling.juggler.remove(this._verticalAutoScrollTween);
                this._verticalAutoScrollTween = null;
            }
            if (this._horizontalAutoScrollTween) 
            {
                starling.core.Starling.juggler.remove(this._horizontalAutoScrollTween);
                this._horizontalAutoScrollTween = null;
            }
            var loc2:*=this._horizontalScrollPosition;
            var loc3:*=this._verticalScrollPosition;
            if (this._horizontalScrollPosition < this._minHorizontalScrollPosition) 
            {
                this._horizontalScrollPosition = this._minHorizontalScrollPosition;
            }
            else if (this._horizontalScrollPosition > this._maxHorizontalScrollPosition) 
            {
                this._horizontalScrollPosition = this._maxHorizontalScrollPosition;
            }
            if (this._verticalScrollPosition < this._minVerticalScrollPosition) 
            {
                this._verticalScrollPosition = this._minVerticalScrollPosition;
            }
            else if (this._verticalScrollPosition > this._maxVerticalScrollPosition) 
            {
                this._verticalScrollPosition = this._maxVerticalScrollPosition;
            }
            if (!(loc2 == this._horizontalScrollPosition) || !(loc3 == this._verticalScrollPosition)) 
            {
                this.dispatchEventWith(starling.events.Event.SCROLL);
            }
            this.completeScroll();
            return;
        }

        public function get backgroundSkin():starling.display.DisplayObject
        {
            return this._backgroundSkin;
        }

        public function set backgroundSkin(arg1:starling.display.DisplayObject):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                if (arg1 !== null) 
                {
                    arg1.dispose();
                }
                return;
            }
            if (this._backgroundSkin === arg1) 
            {
                return;
            }
            if (this._backgroundSkin && this.currentBackgroundSkin == this._backgroundSkin) 
            {
                this.removeRawChildInternal(this._backgroundSkin);
                this.currentBackgroundSkin = null;
            }
            this._backgroundSkin = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected override function focusInHandler(arg1:starling.events.Event):void
        {
            super.focusInHandler(arg1);
            this.stage.addEventListener(starling.events.KeyboardEvent.KEY_DOWN, this.stage_keyDownHandler);
            return;
        }

        public function get backgroundDisabledSkin():starling.display.DisplayObject
        {
            return this._backgroundDisabledSkin;
        }

        public function set backgroundDisabledSkin(arg1:starling.display.DisplayObject):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                if (arg1 !== null) 
                {
                    arg1.dispose();
                }
                return;
            }
            if (this._backgroundDisabledSkin === arg1) 
            {
                return;
            }
            if (this._backgroundDisabledSkin && this.currentBackgroundSkin == this._backgroundDisabledSkin) 
            {
                this.removeRawChildInternal(this._backgroundDisabledSkin);
                this.currentBackgroundSkin = null;
            }
            this._backgroundDisabledSkin = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected override function focusOutHandler(arg1:starling.events.Event):void
        {
            super.focusOutHandler(arg1);
            this.stage.removeEventListener(starling.events.KeyboardEvent.KEY_DOWN, this.stage_keyDownHandler);
            return;
        }

        public function get autoHideBackground():Boolean
        {
            return this._autoHideBackground;
        }

        public function set autoHideBackground(arg1:Boolean):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._autoHideBackground === arg1) 
            {
                return;
            }
            this._autoHideBackground = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function stage_keyDownHandler(arg1:starling.events.KeyboardEvent):void
        {
            if (arg1.keyCode != flash.ui.Keyboard.HOME) 
            {
                if (arg1.keyCode != flash.ui.Keyboard.END) 
                {
                    if (arg1.keyCode != flash.ui.Keyboard.PAGE_UP) 
                    {
                        if (arg1.keyCode != flash.ui.Keyboard.PAGE_DOWN) 
                        {
                            if (arg1.keyCode != flash.ui.Keyboard.UP) 
                            {
                                if (arg1.keyCode != flash.ui.Keyboard.DOWN) 
                                {
                                    if (arg1.keyCode != flash.ui.Keyboard.LEFT) 
                                    {
                                        if (arg1.keyCode == flash.ui.Keyboard.RIGHT) 
                                        {
                                            this.horizontalScrollPosition = Math.min(this._maxHorizontalScrollPosition, this._horizontalScrollPosition + this.horizontalScrollStep);
                                        }
                                    }
                                    else 
                                    {
                                        this.horizontalScrollPosition = Math.max(this._maxHorizontalScrollPosition, this._horizontalScrollPosition - this.horizontalScrollStep);
                                    }
                                }
                                else 
                                {
                                    this.verticalScrollPosition = Math.min(this._maxVerticalScrollPosition, this._verticalScrollPosition + this.verticalScrollStep);
                                }
                            }
                            else 
                            {
                                this.verticalScrollPosition = Math.max(this._minVerticalScrollPosition, this._verticalScrollPosition - this.verticalScrollStep);
                            }
                        }
                        else 
                        {
                            this.verticalScrollPosition = Math.min(this._maxVerticalScrollPosition, this._verticalScrollPosition + this.viewPort.visibleHeight);
                        }
                    }
                    else 
                    {
                        this.verticalScrollPosition = Math.max(this._minVerticalScrollPosition, this._verticalScrollPosition - this.viewPort.visibleHeight);
                    }
                }
                else 
                {
                    this.verticalScrollPosition = this._maxVerticalScrollPosition;
                }
            }
            else 
            {
                this.verticalScrollPosition = this._minVerticalScrollPosition;
            }
            return;
        }

        public function get minimumDragDistance():Number
        {
            return this._minimumDragDistance;
        }

        public function set minimumDragDistance(arg1:Number):void
        {
            this._minimumDragDistance = arg1;
            return;
        }

        protected static function defaultScrollBarFactory():feathers.controls.IScrollBar
        {
            return new feathers.controls.SimpleScrollBar();
        }

        public function get minimumPageThrowVelocity():Number
        {
            return this._minimumPageThrowVelocity;
        }

        public function set minimumPageThrowVelocity(arg1:Number):void
        {
            this._minimumPageThrowVelocity = arg1;
            return;
        }

        public function get padding():Number
        {
            return this._paddingTop;
        }

        public function set padding(arg1:Number):void
        {
            this.paddingTop = arg1;
            this.paddingRight = arg1;
            this.paddingBottom = arg1;
            this.paddingLeft = arg1;
            return;
        }

        protected static function defaultThrowEase(arg1:Number):Number
        {
            --arg1;
            return 1 - arg1 * arg1 * arg1 * arg1;
        }

        public function get paddingTop():Number
        {
            return this._paddingTop;
        }

        public function set paddingTop(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._paddingTop === arg1) 
            {
                return;
            }
            this._paddingTop = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        
        {
            new Vector.<Number>(4)[0] = 1;
            new Vector.<Number>(4)[1] = 1.33;
            new Vector.<Number>(4)[2] = 1.66;
            new Vector.<Number>(4)[3] = 2;
        }

        public function get paddingRight():Number
        {
            return this._paddingRight;
        }

        public function set paddingRight(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._paddingRight === arg1) 
            {
                return;
            }
            this._paddingRight = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get paddingBottom():Number
        {
            return this._paddingBottom;
        }

        public function set paddingBottom(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._paddingBottom === arg1) 
            {
                return;
            }
            this._paddingBottom = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get paddingLeft():Number
        {
            return this._paddingLeft;
        }

        public function set paddingLeft(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._paddingLeft === arg1) 
            {
                return;
            }
            this._paddingLeft = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get hideScrollBarAnimationDuration():Number
        {
            return this._hideScrollBarAnimationDuration;
        }

        public function set hideScrollBarAnimationDuration(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            this._hideScrollBarAnimationDuration = arg1;
            return;
        }

        public function get hideScrollBarAnimationEase():Object
        {
            return this._hideScrollBarAnimationEase;
        }

        public function set hideScrollBarAnimationEase(arg1:Object):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            this._hideScrollBarAnimationEase = arg1;
            return;
        }

        public function get elasticSnapDuration():Number
        {
            return this._elasticSnapDuration;
        }

        public function set elasticSnapDuration(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            this._elasticSnapDuration = arg1;
            return;
        }

        public function get decelerationRate():Number
        {
            return this._decelerationRate;
        }

        public function set decelerationRate(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._decelerationRate === arg1) 
            {
                return;
            }
            this._decelerationRate = arg1;
            this._logDecelerationRate = Math.log(this._decelerationRate);
            this._fixedThrowDuration = -0.1 / Math.log(Math.pow(this._decelerationRate, 1000 / 60));
            return;
        }

        public function get useFixedThrowDuration():Boolean
        {
            return this._useFixedThrowDuration;
        }

        public function set useFixedThrowDuration(arg1:Boolean):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            this._useFixedThrowDuration = arg1;
            return;
        }

        public function get pageThrowDuration():Number
        {
            return this._pageThrowDuration;
        }

        public function set pageThrowDuration(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            this._pageThrowDuration = arg1;
            return;
        }

        public function get mouseWheelScrollDuration():Number
        {
            return this._mouseWheelScrollDuration;
        }

        public function set mouseWheelScrollDuration(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            this._mouseWheelScrollDuration = arg1;
            return;
        }

        public function get verticalMouseWheelScrollDirection():String
        {
            return this._verticalMouseWheelScrollDirection;
        }

        public static const VERTICAL_SCROLL_BAR_POSITION_LEFT:String="left";

        internal static const HELPER_POINT:flash.geom.Point=new flash.geom.Point();

        protected static const INVALIDATION_FLAG_SCROLL_BAR_RENDERER:String="scrollBarRenderer";

        protected static const INVALIDATION_FLAG_PENDING_SCROLL:String="pendingScroll";

        protected static const INVALIDATION_FLAG_PENDING_REVEAL_SCROLL_BARS:String="pendingRevealScrollBars";

        public static const SCROLL_POLICY_AUTO:String="auto";

        public static const SCROLL_POLICY_ON:String="on";

        public static const SCROLL_POLICY_OFF:String="off";

        public static const SCROLL_BAR_DISPLAY_MODE_FLOAT:String="float";

        public static const SCROLL_BAR_DISPLAY_MODE_FIXED:String="fixed";

        public static const SCROLL_BAR_DISPLAY_MODE_FIXED_FLOAT:String="fixedFloat";

        public static const SCROLL_BAR_DISPLAY_MODE_NONE:String="none";

        public static const VERTICAL_SCROLL_BAR_POSITION_RIGHT:String="right";

        public static const INTERACTION_MODE_TOUCH:String="touch";

        public static const INTERACTION_MODE_MOUSE:String="mouse";

        public static const INTERACTION_MODE_TOUCH_AND_SCROLL_BARS:String="touchAndScrollBars";

        public static const MOUSE_WHEEL_SCROLL_DIRECTION_VERTICAL:String="vertical";

        public static const MOUSE_WHEEL_SCROLL_DIRECTION_HORIZONTAL:String="horizontal";

        protected static const INVALIDATION_FLAG_CLIPPING:String="clipping";

        internal static const MINIMUM_VELOCITY:Number=0.02;

        internal static const CURRENT_VELOCITY_WEIGHT:Number=2.33;

        internal static const VELOCITY_WEIGHTS:__AS3__.vec.Vector.<Number>=new Vector.<Number>(4);

        internal static const MAXIMUM_SAVED_VELOCITY_COUNT:int=4;

        public static const DECELERATION_RATE_NORMAL:Number=0.998;

        public static const DECELERATION_RATE_FAST:Number=0.99;

        public static const DEFAULT_CHILD_STYLE_NAME_HORIZONTAL_SCROLL_BAR:String="feathers-scroller-horizontal-scroll-bar";

        public static const DEFAULT_CHILD_STYLE_NAME_VERTICAL_SCROLL_BAR:String="feathers-scroller-vertical-scroll-bar";

        protected static const FUZZY_PAGE_SIZE_PADDING:Number=1e-006;

        protected static const PAGE_INDEX_EPSILON:Number=0.01;

        protected var _hasViewPortBoundsChanged:Boolean=false;

        protected var _horizontalAutoScrollTween:starling.animation.Tween;

        protected var _verticalAutoScrollTween:starling.animation.Tween;

        protected var _isDraggingHorizontally:Boolean=false;

        protected var _isDraggingVertically:Boolean=false;

        protected var ignoreViewPortResizing:Boolean=false;

        protected var _touchBlocker:starling.display.Quad;

        protected var _viewPort:feathers.controls.supportClasses.IViewPort;

        protected var _explicitViewPortWidth:Number;

        protected var _explicitViewPortHeight:Number;

        protected var _explicitViewPortMinHeight:Number;

        protected var _measureViewPort:Boolean=true;

        protected var _snapToPages:Boolean=false;

        protected var _snapOnComplete:Boolean=false;

        protected var _horizontalScrollBarFactory:Function;

        protected var _customHorizontalScrollBarStyleName:String;

        protected var _horizontalScrollBarProperties:feathers.core.PropertyProxy;

        protected var _verticalScrollBarPosition:String="right";

        protected var _verticalScrollBarFactory:Function;

        protected var _customVerticalScrollBarStyleName:String;

        protected var _verticalScrollBarProperties:feathers.core.PropertyProxy;

        protected var actualHorizontalScrollStep:Number=1;

        protected var explicitHorizontalScrollStep:Number=NaN;

        protected var _targetHorizontalScrollPosition:Number;

        protected var _horizontalScrollPosition:Number=0;

        protected var _minHorizontalScrollPosition:Number=0;

        protected var _maxHorizontalScrollPosition:Number=0;

        protected var _horizontalPageIndex:int=0;

        protected var _explicitViewPortMinWidth:Number;

        protected var _minHorizontalPageIndex:int=0;

        protected var _maxHorizontalPageIndex:int=0;

        protected var _horizontalScrollPolicy:String="auto";

        protected var actualVerticalScrollStep:Number=1;

        protected var explicitVerticalScrollStep:Number=NaN;

        protected var _verticalMouseWheelScrollStep:Number=NaN;

        protected var _targetVerticalScrollPosition:Number;

        protected var _verticalScrollPosition:Number=0;

        protected var _minVerticalScrollPosition:Number=0;

        protected var _maxVerticalScrollPosition:Number=0;

        protected var _verticalPageIndex:int=0;

        protected var _minVerticalPageIndex:int=0;

        protected var _maxVerticalPageIndex:int=0;

        protected var _verticalScrollPolicy:String="auto";

        protected var _clipContent:Boolean=true;

        protected var actualPageWidth:Number=0;

        protected var explicitPageWidth:Number=NaN;

        protected var actualPageHeight:Number=0;

        protected var explicitPageHeight:Number=NaN;

        protected var _hasElasticEdges:Boolean=true;

        protected var _elasticity:Number=0.33;

        protected var _throwElasticity:Number=0.05;

        protected var _scrollBarDisplayMode:String="float";

        protected var _interactionMode:String="touch";

        protected var _explicitBackgroundWidth:Number;

        protected var _explicitBackgroundHeight:Number;

        protected var _explicitBackgroundMinWidth:Number;

        protected var _explicitBackgroundMinHeight:Number;

        protected var _explicitBackgroundMaxWidth:Number;

        protected var _explicitBackgroundMaxHeight:Number;

        protected var currentBackgroundSkin:starling.display.DisplayObject;

        protected var _backgroundSkin:starling.display.DisplayObject;

        protected var _backgroundDisabledSkin:starling.display.DisplayObject;

        protected var _autoHideBackground:Boolean=false;

        protected var _minimumDragDistance:Number=0.04;

        protected var _minimumPageThrowVelocity:Number=5;

        protected var _paddingTop:Number=0;

        protected var _paddingRight:Number=0;

        protected var _revealScrollBarsDuration:Number=1;

        protected var _pageThrowDuration:Number=0.5;

        protected var _elasticSnapDuration:Number=0.5;

        protected var _horizontalAutoScrollTweenEndRatio:Number=1;

        protected var _verticalAutoScrollTweenEndRatio:Number=1;

        protected var _hideScrollBarAnimationDuration:Number=0.2;

        protected var _mouseWheelScrollDuration:Number=0.35;

        protected var _paddingBottom:Number=0;

        protected var _logDecelerationRate:Number=-0.00200200267067;

        protected var _verticalMouseWheelScrollDirection:String="vertical";

        protected var _decelerationRate:Number=0.998;

        protected var _paddingLeft:Number=0;

        protected var _throwEase:Object;

        protected var _hideScrollBarAnimationEase:Object="easeOut";

        protected var _fixedThrowDuration:Number=2.996998999;

        protected var _snapScrollPositionsToPixels:Boolean=true;

        protected var _useFixedThrowDuration:Boolean=true;

        protected var _horizontalScrollBarHideTween:starling.animation.Tween;

        protected var _horizontalScrollBarIsScrolling:Boolean=false;

        protected var _verticalScrollBarIsScrolling:Boolean=false;

        protected var _isScrolling:Boolean=false;

        protected var horizontalScrollBarStyleName:String="feathers-scroller-horizontal-scroll-bar";

        protected var _isScrollingStopped:Boolean=false;

        protected var pendingHorizontalScrollPosition:Number=NaN;

        protected var pendingVerticalScrollPosition:Number=NaN;

        protected var hasPendingHorizontalPageIndex:Boolean=false;

        protected var hasPendingVerticalPageIndex:Boolean=false;

        protected var pendingHorizontalPageIndex:int;

        protected var verticalScrollBarStyleName:String="feathers-scroller-vertical-scroll-bar";

        protected var horizontalScrollBar:feathers.controls.IScrollBar;

        protected var verticalScrollBar:feathers.controls.IScrollBar;

        protected var _topViewPortOffset:Number;

        protected var _rightViewPortOffset:Number;

        protected var _bottomViewPortOffset:Number;

        protected var _leftViewPortOffset:Number;

        protected var _hasHorizontalScrollBar:Boolean=false;

        protected var _hasVerticalScrollBar:Boolean=false;

        protected var _horizontalScrollBarTouchPointID:int=-1;

        protected var _verticalScrollBarTouchPointID:int=-1;

        protected var _touchPointID:int=-1;

        protected var _verticalScrollBarHideTween:starling.animation.Tween;

        protected var _startTouchX:Number;

        protected var _startTouchY:Number;

        protected var _startHorizontalScrollPosition:Number;

        protected var _startVerticalScrollPosition:Number;

        protected var _currentTouchX:Number;

        protected var _currentTouchY:Number;

        protected var _previousTouchTime:int;

        protected var _previousTouchX:Number;

        protected var _previousTouchY:Number;

        protected var _velocityX:Number=0;

        protected var _velocityY:Number=0;

        protected var _previousVelocityX:__AS3__.vec.Vector.<Number>;

        protected var _previousVelocityY:__AS3__.vec.Vector.<Number>;

        protected var _pendingVelocityChange:Boolean=false;

        protected var _lastViewPortWidth:Number=0;

        protected var _lastViewPortHeight:Number=0;

        protected var pendingVerticalPageIndex:int;

        protected var pendingScrollDuration:Number;

        protected var isScrollBarRevealPending:Boolean=false;
    }
}


