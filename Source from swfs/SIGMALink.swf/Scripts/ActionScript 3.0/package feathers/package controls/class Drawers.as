//class Drawers
package feathers.controls 
{
    import __AS3__.vec.*;
    import feathers.controls.supportClasses.*;
    import feathers.core.*;
    import feathers.events.*;
    import feathers.layout.*;
    import feathers.skins.*;
    import feathers.system.*;
    import feathers.utils.display.*;
    import feathers.utils.math.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.ui.*;
    import flash.utils.*;
    import starling.animation.*;
    import starling.core.*;
    import starling.display.*;
    import starling.events.*;
    
    public class Drawers extends feathers.core.FeathersControl
    {
        public function Drawers(arg1:feathers.core.IFeathersControl=null)
        {
            this._previousVelocityX = new Vector.<Number>(0);
            this._previousVelocityY = new Vector.<Number>(0);
            super();
            this.content = arg1;
            this.addEventListener(starling.events.Event.ADDED_TO_STAGE, this.drawers_addedToStageHandler);
            this.addEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.drawers_removedFromStageHandler);
            this.addEventListener(starling.events.TouchEvent.TOUCH, this.drawers_touchHandler);
            return;
        }

        protected function openOrCloseRightDrawer():void
        {
            if (!this._rightDrawer || this.isRightDrawerDocked) 
            {
                return;
            }
            if (this._openOrCloseTween) 
            {
                this._openOrCloseTween.advanceTime(this._openOrCloseTween.totalTime);
                starling.core.Starling.juggler.remove(this._openOrCloseTween);
                this._openOrCloseTween = null;
            }
            this.prepareRightDrawer();
            if (this._overlaySkin) 
            {
                this._overlaySkin.visible = true;
                if (this._isRightDrawerOpen) 
                {
                    this._overlaySkin.alpha = 0;
                }
                else 
                {
                    this._overlaySkin.alpha = this._overlaySkinOriginalAlpha;
                }
            }
            var loc1:*=0;
            if (this._isRightDrawerOpen) 
            {
                loc1 = -this._rightDrawer.width;
            }
            if (this.isLeftDrawerDocked && this._openMode === feathers.layout.RelativeDepth.BELOW) 
            {
                loc1 = loc1 + this._leftDrawer.width;
                if (this._leftDrawerDivider) 
                {
                    loc1 = loc1 + this._leftDrawerDivider.width;
                }
            }
            var loc2:*=this.pendingToggleDuration;
            if (loc2 !== loc2) 
            {
                loc2 = this._openOrCloseDuration;
            }
            this.pendingToggleDuration = NaN;
            if (this._openMode !== feathers.layout.RelativeDepth.ABOVE) 
            {
                this._openOrCloseTween = new starling.animation.Tween(this._content, loc2, this._openOrCloseEase);
            }
            else 
            {
                this._openOrCloseTween = new starling.animation.Tween(this._rightDrawer, loc2, this._openOrCloseEase);
                loc1 = loc1 + this.actualWidth;
            }
            this._openOrCloseTween.animate("x", loc1);
            this._openOrCloseTween.onUpdate = this.rightDrawerOpenOrCloseTween_onUpdate;
            this._openOrCloseTween.onComplete = this.rightDrawerOpenOrCloseTween_onComplete;
            starling.core.Starling.juggler.add(this._openOrCloseTween);
            return;
        }

        protected override function get defaultStyleProvider():feathers.skins.IStyleProvider
        {
            return Drawers.globalStyleProvider;
        }

        protected function openOrCloseBottomDrawer():void
        {
            if (!this._bottomDrawer || this.isBottomDrawerDocked) 
            {
                return;
            }
            if (this._openOrCloseTween) 
            {
                this._openOrCloseTween.advanceTime(this._openOrCloseTween.totalTime);
                starling.core.Starling.juggler.remove(this._openOrCloseTween);
                this._openOrCloseTween = null;
            }
            this.prepareBottomDrawer();
            if (this._overlaySkin) 
            {
                this._overlaySkin.visible = true;
                if (this._isBottomDrawerOpen) 
                {
                    this._overlaySkin.alpha = 0;
                }
                else 
                {
                    this._overlaySkin.alpha = this._overlaySkinOriginalAlpha;
                }
            }
            var loc1:*=0;
            if (this._isBottomDrawerOpen) 
            {
                loc1 = -this._bottomDrawer.height;
            }
            if (this.isTopDrawerDocked && this._openMode === feathers.layout.RelativeDepth.BELOW) 
            {
                loc1 = loc1 + this._topDrawer.height;
                if (this._topDrawerDivider) 
                {
                    loc1 = loc1 + this._topDrawerDivider.height;
                }
            }
            var loc2:*=this.pendingToggleDuration;
            if (loc2 !== loc2) 
            {
                loc2 = this._openOrCloseDuration;
            }
            this.pendingToggleDuration = NaN;
            if (this._openMode !== feathers.layout.RelativeDepth.ABOVE) 
            {
                this._openOrCloseTween = new starling.animation.Tween(this._content, loc2, this._openOrCloseEase);
            }
            else 
            {
                loc1 = loc1 + this.actualHeight;
                this._openOrCloseTween = new starling.animation.Tween(this._bottomDrawer, loc2, this._openOrCloseEase);
            }
            this._openOrCloseTween.animate("y", loc1);
            this._openOrCloseTween.onUpdate = this.bottomDrawerOpenOrCloseTween_onUpdate;
            this._openOrCloseTween.onComplete = this.bottomDrawerOpenOrCloseTween_onComplete;
            starling.core.Starling.juggler.add(this._openOrCloseTween);
            return;
        }

        protected function openOrCloseLeftDrawer():void
        {
            if (!this._leftDrawer || this.isLeftDrawerDocked) 
            {
                return;
            }
            if (this._openOrCloseTween) 
            {
                this._openOrCloseTween.advanceTime(this._openOrCloseTween.totalTime);
                starling.core.Starling.juggler.remove(this._openOrCloseTween);
                this._openOrCloseTween = null;
            }
            this.prepareLeftDrawer();
            if (this._overlaySkin) 
            {
                this._overlaySkin.visible = true;
                if (this._isLeftDrawerOpen) 
                {
                    this._overlaySkin.alpha = 0;
                }
                else 
                {
                    this._overlaySkin.alpha = this._overlaySkinOriginalAlpha;
                }
            }
            var loc1:*=this._isLeftDrawerOpen ? this._leftDrawer.width : 0;
            var loc2:*=this.pendingToggleDuration;
            if (loc2 !== loc2) 
            {
                loc2 = this._openOrCloseDuration;
            }
            this.pendingToggleDuration = NaN;
            if (this._openMode !== feathers.layout.RelativeDepth.ABOVE) 
            {
                this._openOrCloseTween = new starling.animation.Tween(this._content, loc2, this._openOrCloseEase);
            }
            else 
            {
                loc1 = loc1 !== 0 ? 0 : -this._leftDrawer.width;
                this._openOrCloseTween = new starling.animation.Tween(this._leftDrawer, loc2, this._openOrCloseEase);
            }
            this._openOrCloseTween.animate("x", loc1);
            this._openOrCloseTween.onUpdate = this.leftDrawerOpenOrCloseTween_onUpdate;
            this._openOrCloseTween.onComplete = this.leftDrawerOpenOrCloseTween_onComplete;
            starling.core.Starling.juggler.add(this._openOrCloseTween);
            return;
        }

        protected function prepareTopDrawer():void
        {
            var loc1:*=null;
            this._topDrawer.visible = true;
            if (this._openMode === feathers.layout.RelativeDepth.ABOVE) 
            {
                if (this._overlaySkin) 
                {
                    this.setChildIndex(this._overlaySkin, (this.numChildren - 1));
                }
                this.setChildIndex(starling.display.DisplayObject(this._topDrawer), (this.numChildren - 1));
            }
            if (!this._clipDrawers || !(this._openMode === feathers.layout.RelativeDepth.BELOW)) 
            {
                return;
            }
            if (this._topDrawer.mask === null) 
            {
                loc1 = new starling.display.Quad(1, 1, 16711935);
                loc1.width = this.actualWidth;
                loc1.height = this._content.y;
                this._topDrawer.mask = loc1;
            }
            return;
        }

        public function get content():feathers.core.IFeathersControl
        {
            return this._content;
        }

        public function set content(arg1:feathers.core.IFeathersControl):void
        {
            if (this._content === arg1) 
            {
                return;
            }
            if (this._content) 
            {
                if (this._contentEventDispatcherChangeEventType) 
                {
                    this._content.removeEventListener(this._contentEventDispatcherChangeEventType, this.content_eventDispatcherChangeHandler);
                }
                this._content.removeEventListener(feathers.events.FeathersEventType.RESIZE, this.content_resizeHandler);
                if (this._content.parent === this) 
                {
                    this.removeChild(starling.display.DisplayObject(this._content), false);
                }
            }
            this._content = arg1;
            this._originalContentWidth = NaN;
            this._originalContentHeight = NaN;
            if (this._content) 
            {
                if (this._content is feathers.controls.supportClasses.BaseScreenNavigator) 
                {
                    this.contentEventDispatcherField = SCREEN_NAVIGATOR_CONTENT_EVENT_DISPATCHER_FIELD;
                    this.contentEventDispatcherChangeEventType = starling.events.Event.CHANGE;
                }
                if (this._contentEventDispatcherChangeEventType) 
                {
                    this._content.addEventListener(this._contentEventDispatcherChangeEventType, this.content_eventDispatcherChangeHandler);
                }
                if (this._autoSizeMode === feathers.controls.AutoSizeMode.CONTENT || !this.stage) 
                {
                    this._content.addEventListener(feathers.events.FeathersEventType.RESIZE, this.content_resizeHandler);
                }
                if (this._openMode !== feathers.layout.RelativeDepth.ABOVE) 
                {
                    if (this._overlaySkin) 
                    {
                        this.addChildAt(starling.display.DisplayObject(this._content), this.getChildIndex(this._overlaySkin));
                    }
                    else 
                    {
                        this.addChild(starling.display.DisplayObject(this._content));
                    }
                }
                else 
                {
                    this.addChildAt(starling.display.DisplayObject(this._content), 0);
                }
            }
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        protected function prepareRightDrawer():void
        {
            var loc1:*=null;
            this._rightDrawer.visible = true;
            if (this._openMode === feathers.layout.RelativeDepth.ABOVE) 
            {
                if (this._overlaySkin) 
                {
                    this.setChildIndex(this._overlaySkin, (this.numChildren - 1));
                }
                this.setChildIndex(starling.display.DisplayObject(this._rightDrawer), (this.numChildren - 1));
            }
            if (!this._clipDrawers || !(this._openMode === feathers.layout.RelativeDepth.BELOW)) 
            {
                return;
            }
            if (this._rightDrawer.mask === null) 
            {
                loc1 = new starling.display.Quad(1, 1, 16711935);
                if (this.isLeftDrawerDocked) 
                {
                    loc1.width = -this._leftDrawer.x;
                }
                else 
                {
                    loc1.width = -this._content.x;
                }
                loc1.height = this.actualHeight;
                this._rightDrawer.mask = loc1;
            }
            return;
        }

        protected function prepareBottomDrawer():void
        {
            var loc1:*=null;
            this._bottomDrawer.visible = true;
            if (this._openMode === feathers.layout.RelativeDepth.ABOVE) 
            {
                if (this._overlaySkin) 
                {
                    this.setChildIndex(this._overlaySkin, (this.numChildren - 1));
                }
                this.setChildIndex(starling.display.DisplayObject(this._bottomDrawer), (this.numChildren - 1));
            }
            if (!this._clipDrawers || !(this._openMode === feathers.layout.RelativeDepth.BELOW)) 
            {
                return;
            }
            if (this._bottomDrawer.mask === null) 
            {
                loc1 = new starling.display.Quad(1, 1, 16711935);
                loc1.width = this.actualWidth;
                if (this.isTopDrawerDocked) 
                {
                    loc1.height = -this._topDrawer.y;
                }
                else 
                {
                    loc1.height = -this._content.y;
                }
                this._bottomDrawer.mask = loc1;
            }
            return;
        }

        public function get overlaySkin():starling.display.DisplayObject
        {
            return this._overlaySkin;
        }

        public function set overlaySkin(arg1:starling.display.DisplayObject):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                if (arg1 !== null) 
                {
                    arg1.dispose();
                }
                return;
            }
            if (this._overlaySkin === arg1) 
            {
                return;
            }
            if (this._overlaySkin && this._overlaySkin.parent == this) 
            {
                this.removeChild(this._overlaySkin, false);
            }
            this._overlaySkin = arg1;
            if (this._overlaySkin) 
            {
                this._overlaySkinOriginalAlpha = this._overlaySkin.alpha;
                this._overlaySkin.visible = this.isTopDrawerOpen || this.isRightDrawerOpen || this.isBottomDrawerOpen || this.isLeftDrawerOpen;
                this.addChild(this._overlaySkin);
            }
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        protected function prepareLeftDrawer():void
        {
            var loc1:*=null;
            this._leftDrawer.visible = true;
            if (this._openMode === feathers.layout.RelativeDepth.ABOVE) 
            {
                if (this._overlaySkin) 
                {
                    this.setChildIndex(this._overlaySkin, (this.numChildren - 1));
                }
                this.setChildIndex(starling.display.DisplayObject(this._leftDrawer), (this.numChildren - 1));
            }
            if (!this._clipDrawers || !(this._openMode === feathers.layout.RelativeDepth.BELOW)) 
            {
                return;
            }
            if (this._leftDrawer.mask === null) 
            {
                loc1 = new starling.display.Quad(1, 1, 16711935);
                loc1.width = this._content.x;
                loc1.height = this.actualHeight;
                this._leftDrawer.mask = loc1;
            }
            return;
        }

        protected function contentToContentEventDispatcher():starling.events.EventDispatcher
        {
            if (this._contentEventDispatcherFunction !== null) 
            {
                return this._contentEventDispatcherFunction(this._content) as starling.events.EventDispatcher;
            }
            if (!(this._contentEventDispatcherField === null) && this._content && this._contentEventDispatcherField in this._content) 
            {
                return this._content[this._contentEventDispatcherField] as starling.events.EventDispatcher;
            }
            return this._content as starling.events.EventDispatcher;
        }

        protected function refreshCurrentEventTarget():void
        {
            if (this.contentEventDispatcher) 
            {
                if (this._topDrawerToggleEventType) 
                {
                    this.contentEventDispatcher.removeEventListener(this._topDrawerToggleEventType, this.content_topDrawerToggleEventTypeHandler);
                }
                if (this._rightDrawerToggleEventType) 
                {
                    this.contentEventDispatcher.removeEventListener(this._rightDrawerToggleEventType, this.content_rightDrawerToggleEventTypeHandler);
                }
                if (this._bottomDrawerToggleEventType) 
                {
                    this.contentEventDispatcher.removeEventListener(this._bottomDrawerToggleEventType, this.content_bottomDrawerToggleEventTypeHandler);
                }
                if (this._leftDrawerToggleEventType) 
                {
                    this.contentEventDispatcher.removeEventListener(this._leftDrawerToggleEventType, this.content_leftDrawerToggleEventTypeHandler);
                }
            }
            this.contentEventDispatcher = this.contentToContentEventDispatcher();
            if (this.contentEventDispatcher) 
            {
                if (this._topDrawerToggleEventType) 
                {
                    this.contentEventDispatcher.addEventListener(this._topDrawerToggleEventType, this.content_topDrawerToggleEventTypeHandler);
                }
                if (this._rightDrawerToggleEventType) 
                {
                    this.contentEventDispatcher.addEventListener(this._rightDrawerToggleEventType, this.content_rightDrawerToggleEventTypeHandler);
                }
                if (this._bottomDrawerToggleEventType) 
                {
                    this.contentEventDispatcher.addEventListener(this._bottomDrawerToggleEventType, this.content_bottomDrawerToggleEventTypeHandler);
                }
                if (this._leftDrawerToggleEventType) 
                {
                    this.contentEventDispatcher.addEventListener(this._leftDrawerToggleEventType, this.content_leftDrawerToggleEventTypeHandler);
                }
            }
            return;
        }

        public function get topDrawer():feathers.core.IFeathersControl
        {
            return this._topDrawer;
        }

        public function set topDrawer(arg1:feathers.core.IFeathersControl):void
        {
            if (this._topDrawer === arg1) 
            {
                return;
            }
            if (this.isTopDrawerOpen && arg1 === null) 
            {
                this.isTopDrawerOpen = false;
            }
            if (this._topDrawer && this._topDrawer.parent === this) 
            {
                this.removeChild(starling.display.DisplayObject(this._topDrawer), false);
            }
            this._topDrawer = arg1;
            this._originalTopDrawerWidth = NaN;
            this._originalTopDrawerHeight = NaN;
            if (this._topDrawer) 
            {
                this._topDrawer.visible = false;
                this._topDrawer.addEventListener(feathers.events.FeathersEventType.RESIZE, this.drawer_resizeHandler);
                if (this._openMode !== feathers.layout.RelativeDepth.ABOVE) 
                {
                    this.addChildAt(starling.display.DisplayObject(this._topDrawer), 0);
                }
                else 
                {
                    this.addChild(starling.display.DisplayObject(this._topDrawer));
                }
            }
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        protected function refreshDrawerStates():void
        {
            if (this.isTopDrawerDocked && this._isTopDrawerOpen) 
            {
                this._isTopDrawerOpen = false;
            }
            if (this.isRightDrawerDocked && this._isRightDrawerOpen) 
            {
                this._isRightDrawerOpen = false;
            }
            if (this.isBottomDrawerDocked && this._isBottomDrawerOpen) 
            {
                this._isBottomDrawerOpen = false;
            }
            if (this.isLeftDrawerDocked && this._isLeftDrawerOpen) 
            {
                this._isLeftDrawerOpen = false;
            }
            return;
        }

        public function get topDrawerDivider():starling.display.DisplayObject
        {
            return this._topDrawerDivider;
        }

        public function set topDrawerDivider(arg1:starling.display.DisplayObject):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                if (arg1 !== null) 
                {
                    arg1.dispose();
                }
                return;
            }
            if (this._topDrawerDivider === arg1) 
            {
                return;
            }
            if (this._topDrawerDivider && this._topDrawerDivider.parent == this) 
            {
                this.removeChild(this._topDrawerDivider, false);
            }
            this._topDrawerDivider = arg1;
            if (this._topDrawerDivider) 
            {
                this._topDrawerDivider.visible = false;
                this.addChild(this._topDrawerDivider);
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function refreshOverlayState():void
        {
            if (!this._overlaySkin || this._isDragging) 
            {
                return;
            }
            var loc1:*=this._isTopDrawerOpen && !this.isTopDrawerDocked || this._isRightDrawerOpen && !this.isRightDrawerDocked || this._isBottomDrawerOpen && !this.isBottomDrawerDocked || this._isLeftDrawerOpen && !this.isLeftDrawerDocked;
            if (loc1 !== this._overlaySkin.visible) 
            {
                this._overlaySkin.visible = loc1;
                this._overlaySkin.alpha = loc1 ? this._overlaySkinOriginalAlpha : 0;
            }
            return;
        }

        public function get topDrawerDockMode():String
        {
            return this._topDrawerDockMode;
        }

        public function set topDrawerDockMode(arg1:String):void
        {
            if (this._topDrawerDockMode == arg1) 
            {
                return;
            }
            this._topDrawerDockMode = arg1;
            this.invalidate(INVALIDATION_FLAG_LAYOUT);
            return;
        }

        protected function handleTapToClose(arg1:starling.events.Touch):void
        {
            arg1.getLocation(this.stage, HELPER_POINT);
            if (this !== this.stage.hitTest(HELPER_POINT)) 
            {
                return;
            }
            if (this.isTopDrawerOpen) 
            {
                this._isTopDrawerOpen = false;
                this.openOrCloseTopDrawer();
            }
            else if (this.isRightDrawerOpen) 
            {
                this._isRightDrawerOpen = false;
                this.openOrCloseRightDrawer();
            }
            else if (this.isBottomDrawerOpen) 
            {
                this._isBottomDrawerOpen = false;
                this.openOrCloseBottomDrawer();
            }
            else if (this.isLeftDrawerOpen) 
            {
                this._isLeftDrawerOpen = false;
                this.openOrCloseLeftDrawer();
            }
            return;
        }

        public function get topDrawerToggleEventType():String
        {
            return this._topDrawerToggleEventType;
        }

        public function set topDrawerToggleEventType(arg1:String):void
        {
            if (this._topDrawerToggleEventType == arg1) 
            {
                return;
            }
            if (this.contentEventDispatcher && this._topDrawerToggleEventType) 
            {
                this.contentEventDispatcher.removeEventListener(this._topDrawerToggleEventType, this.content_topDrawerToggleEventTypeHandler);
            }
            this._topDrawerToggleEventType = arg1;
            if (this.contentEventDispatcher && this._topDrawerToggleEventType) 
            {
                this.contentEventDispatcher.addEventListener(this._topDrawerToggleEventType, this.content_topDrawerToggleEventTypeHandler);
            }
            return;
        }

        public function set bottomDrawer(arg1:feathers.core.IFeathersControl):void
        {
            if (this._bottomDrawer === arg1) 
            {
                return;
            }
            if (this.isBottomDrawerOpen && arg1 === null) 
            {
                this.isBottomDrawerOpen = false;
            }
            if (this._bottomDrawer && this._bottomDrawer.parent === this) 
            {
                this.removeChild(starling.display.DisplayObject(this._bottomDrawer), false);
            }
            this._bottomDrawer = arg1;
            this._originalBottomDrawerWidth = NaN;
            this._originalBottomDrawerHeight = NaN;
            if (this._bottomDrawer) 
            {
                this._bottomDrawer.visible = false;
                this._bottomDrawer.addEventListener(feathers.events.FeathersEventType.RESIZE, this.drawer_resizeHandler);
                if (this._openMode !== feathers.layout.RelativeDepth.ABOVE) 
                {
                    this.addChildAt(starling.display.DisplayObject(this._bottomDrawer), 0);
                }
                else 
                {
                    this.addChild(starling.display.DisplayObject(this._bottomDrawer));
                }
            }
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        public function get isTopDrawerOpen():Boolean
        {
            return this._topDrawer && this._isTopDrawerOpen;
        }

        public function set isTopDrawerOpen(arg1:Boolean):void
        {
            if (this.isTopDrawerDocked || this._isTopDrawerOpen == arg1) 
            {
                return;
            }
            if (arg1) 
            {
                this.isRightDrawerOpen = false;
                this.isBottomDrawerOpen = false;
                this.isLeftDrawerOpen = false;
            }
            this._isTopDrawerOpen = arg1;
            this.invalidate(INVALIDATION_FLAG_SELECTED);
            return;
        }

        public function get isTopDrawerDocked():Boolean
        {
            if (!this._topDrawer) 
            {
                return false;
            }
            if (this._topDrawerDockMode === feathers.layout.Orientation.BOTH) 
            {
                return true;
            }
            if (this._topDrawerDockMode === feathers.layout.Orientation.NONE) 
            {
                return false;
            }
            var loc1:*=this.stage;
            if (loc1 === null) 
            {
                loc1 = starling.core.Starling.current.stage;
            }
            if (loc1.stageWidth > loc1.stageHeight) 
            {
                return this._topDrawerDockMode === feathers.layout.Orientation.LANDSCAPE;
            }
            return this._topDrawerDockMode === feathers.layout.Orientation.PORTRAIT;
        }

        protected function handleTouchBegan(arg1:starling.events.Touch):void
        {
            var loc5:*=false;
            var loc6:*=NaN;
            var loc7:*=NaN;
            var loc8:*=NaN;
            var loc9:*=NaN;
            var loc1:*=feathers.events.ExclusiveTouch.forStage(this.stage);
            if (loc1.getClaim(arg1.id)) 
            {
                return;
            }
            var loc2:*=this.stage === null ? starling.core.Starling.current : this.stage.starling;
            arg1.getLocation(this, HELPER_POINT);
            var loc3:*=HELPER_POINT.x;
            var loc4:*=HELPER_POINT.y;
            if (!this.isTopDrawerOpen && !this.isRightDrawerOpen && !this.isBottomDrawerOpen && !this.isLeftDrawerOpen) 
            {
                if (this._openGesture === feathers.controls.DragGesture.NONE) 
                {
                    return;
                }
                if (this._openGesture === feathers.controls.DragGesture.EDGE) 
                {
                    loc5 = false;
                    if (this._topDrawer && !this.isTopDrawerDocked) 
                    {
                        loc6 = loc4 / (feathers.system.DeviceCapabilities.dpi / loc2.contentScaleFactor);
                        if (loc6 >= 0 && loc6 <= this._openGestureEdgeSize) 
                        {
                            loc5 = true;
                        }
                    }
                    if (!loc5) 
                    {
                        if (this._rightDrawer && !this.isRightDrawerDocked) 
                        {
                            loc7 = (this.actualWidth - loc3) / (feathers.system.DeviceCapabilities.dpi / loc2.contentScaleFactor);
                            if (loc7 >= 0 && loc7 <= this._openGestureEdgeSize) 
                            {
                                loc5 = true;
                            }
                        }
                        if (!loc5) 
                        {
                            if (this._bottomDrawer && !this.isBottomDrawerDocked) 
                            {
                                loc8 = (this.actualHeight - loc4) / (feathers.system.DeviceCapabilities.dpi / loc2.contentScaleFactor);
                                if (loc8 >= 0 && loc8 <= this._openGestureEdgeSize) 
                                {
                                    loc5 = true;
                                }
                            }
                            if (!loc5) 
                            {
                                if (this._leftDrawer && !this.isLeftDrawerDocked) 
                                {
                                    loc9 = loc3 / (feathers.system.DeviceCapabilities.dpi / loc2.contentScaleFactor);
                                    if (loc9 >= 0 && loc9 <= this._openGestureEdgeSize) 
                                    {
                                        loc5 = true;
                                    }
                                }
                            }
                        }
                    }
                    if (!loc5) 
                    {
                        return;
                    }
                }
            }
            else if (this._openMode === feathers.layout.RelativeDepth.BELOW && !(arg1.target === this)) 
            {
                return;
            }
            this.touchPointID = arg1.id;
            this._velocityX = 0;
            this._velocityY = 0;
            this._previousVelocityX.length = 0;
            this._previousVelocityY.length = 0;
            this._previousTouchTime = flash.utils.getTimer();
            var loc10:*;
            this._currentTouchX = loc10 = loc3;
            this._startTouchX = loc10 = loc10;
            this._previousTouchX = loc10;
            this._currentTouchY = loc10 = loc4;
            this._startTouchY = loc10 = loc10;
            this._previousTouchY = loc10;
            this._isDragging = false;
            this._isDraggingTopDrawer = false;
            this._isDraggingRightDrawer = false;
            this._isDraggingBottomDrawer = false;
            this._isDraggingLeftDrawer = false;
            loc1.addEventListener(starling.events.Event.CHANGE, this.exclusiveTouch_changeHandler);
            return;
        }

        protected function handleTouchMoved(arg1:starling.events.Touch):void
        {
            arg1.getLocation(this, HELPER_POINT);
            this._currentTouchX = HELPER_POINT.x;
            this._currentTouchY = HELPER_POINT.y;
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

        protected function handleDragEnd():void
        {
            var loc8:*=NaN;
            var loc9:*=NaN;
            var loc1:*=this._velocityX * CURRENT_VELOCITY_WEIGHT;
            var loc2:*=this._previousVelocityX.length;
            var loc3:*=CURRENT_VELOCITY_WEIGHT;
            var loc4:*=0;
            while (loc4 < loc2) 
            {
                loc8 = VELOCITY_WEIGHTS[loc4];
                loc1 = loc1 + this._previousVelocityX.shift() * loc8;
                loc3 = loc3 + loc8;
                ++loc4;
            }
            var loc5:*=this.stage === null ? starling.core.Starling.current : this.stage.starling;
            var loc6:*=1000 * loc1 / loc3 / (feathers.system.DeviceCapabilities.dpi / loc5.contentScaleFactor);
            loc1 = this._velocityY * CURRENT_VELOCITY_WEIGHT;
            loc2 = this._previousVelocityY.length;
            loc3 = CURRENT_VELOCITY_WEIGHT;
            loc4 = 0;
            while (loc4 < loc2) 
            {
                loc8 = VELOCITY_WEIGHTS[loc4];
                loc1 = loc1 + this._previousVelocityY.shift() * loc8;
                loc3 = loc3 + loc8;
                ++loc4;
            }
            var loc7:*=1000 * loc1 / loc3 / (feathers.system.DeviceCapabilities.dpi / loc5.contentScaleFactor);
            this._isDragging = false;
            if (this._isDraggingTopDrawer) 
            {
                this._isDraggingTopDrawer = false;
                if (!this._isTopDrawerOpen && loc7 > this._minimumDrawerThrowVelocity) 
                {
                    this._isTopDrawerOpen = true;
                }
                else if (this._isTopDrawerOpen && loc7 < -this._minimumDrawerThrowVelocity) 
                {
                    this._isTopDrawerOpen = false;
                }
                else if (this._openMode !== feathers.layout.RelativeDepth.ABOVE) 
                {
                    this._isTopDrawerOpen = !(feathers.utils.math.roundToNearest(this._content.y, this._topDrawer.height) == 0);
                }
                else 
                {
                    this._isTopDrawerOpen = feathers.utils.math.roundToNearest(this._topDrawer.y, this._topDrawer.height) == 0;
                }
                this.openOrCloseTopDrawer();
            }
            else if (this._isDraggingRightDrawer) 
            {
                this._isDraggingRightDrawer = false;
                if (!this._isRightDrawerOpen && loc6 < -this._minimumDrawerThrowVelocity) 
                {
                    this._isRightDrawerOpen = true;
                }
                else if (this._isRightDrawerOpen && loc6 > this._minimumDrawerThrowVelocity) 
                {
                    this._isRightDrawerOpen = false;
                }
                else if (this._openMode !== feathers.layout.RelativeDepth.ABOVE) 
                {
                    loc9 = this._content.x;
                    if (this.isLeftDrawerDocked) 
                    {
                        loc9 = loc9 - this._leftDrawer.width;
                    }
                    this._isRightDrawerOpen = !(feathers.utils.math.roundToNearest(loc9, this._rightDrawer.width) == 0);
                }
                else 
                {
                    this._isRightDrawerOpen = !(feathers.utils.math.roundToNearest(this.actualWidth - this._rightDrawer.x, this._rightDrawer.width) == 0);
                }
                this.openOrCloseRightDrawer();
            }
            else if (this._isDraggingBottomDrawer) 
            {
                this._isDraggingBottomDrawer = false;
                if (!this._isBottomDrawerOpen && loc7 < -this._minimumDrawerThrowVelocity) 
                {
                    this._isBottomDrawerOpen = true;
                }
                else if (this._isBottomDrawerOpen && loc7 > this._minimumDrawerThrowVelocity) 
                {
                    this._isBottomDrawerOpen = false;
                }
                else if (this._openMode !== feathers.layout.RelativeDepth.ABOVE) 
                {
                    loc9 = this._content.y;
                    if (this.isTopDrawerDocked) 
                    {
                        loc9 = loc9 - this._topDrawer.height;
                    }
                    this._isBottomDrawerOpen = !(feathers.utils.math.roundToNearest(loc9, this._bottomDrawer.height) == 0);
                }
                else 
                {
                    this._isBottomDrawerOpen = !(feathers.utils.math.roundToNearest(this.actualHeight - this._bottomDrawer.y, this._bottomDrawer.height) == 0);
                }
                this.openOrCloseBottomDrawer();
            }
            else if (this._isDraggingLeftDrawer) 
            {
                this._isDraggingLeftDrawer = false;
                if (!this._isLeftDrawerOpen && loc6 > this._minimumDrawerThrowVelocity) 
                {
                    this._isLeftDrawerOpen = true;
                }
                else if (this._isLeftDrawerOpen && loc6 < -this._minimumDrawerThrowVelocity) 
                {
                    this._isLeftDrawerOpen = false;
                }
                else if (this._openMode !== feathers.layout.RelativeDepth.ABOVE) 
                {
                    this._isLeftDrawerOpen = !(feathers.utils.math.roundToNearest(this._content.x, this._leftDrawer.width) == 0);
                }
                else 
                {
                    this._isLeftDrawerOpen = feathers.utils.math.roundToNearest(this._leftDrawer.x, this._leftDrawer.width) == 0;
                }
                this.openOrCloseLeftDrawer();
            }
            return;
        }

        public function get rightDrawer():feathers.core.IFeathersControl
        {
            return this._rightDrawer;
        }

        public function set rightDrawer(arg1:feathers.core.IFeathersControl):void
        {
            if (this._rightDrawer == arg1) 
            {
                return;
            }
            if (this.isRightDrawerOpen && arg1 === null) 
            {
                this.isRightDrawerOpen = false;
            }
            if (this._rightDrawer && this._rightDrawer.parent == this) 
            {
                this.removeChild(starling.display.DisplayObject(this._rightDrawer), false);
            }
            this._rightDrawer = arg1;
            this._originalRightDrawerWidth = NaN;
            this._originalRightDrawerHeight = NaN;
            if (this._rightDrawer) 
            {
                this._rightDrawer.visible = false;
                this._rightDrawer.addEventListener(feathers.events.FeathersEventType.RESIZE, this.drawer_resizeHandler);
                if (this._openMode !== feathers.layout.RelativeDepth.ABOVE) 
                {
                    this.addChildAt(starling.display.DisplayObject(this._rightDrawer), 0);
                }
                else 
                {
                    this.addChild(starling.display.DisplayObject(this._rightDrawer));
                }
            }
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        protected function handleDragMove():void
        {
            var loc3:*=NaN;
            var loc4:*=NaN;
            var loc5:*=NaN;
            var loc6:*=NaN;
            var loc1:*=0;
            var loc2:*=0;
            if (this.isLeftDrawerDocked) 
            {
                loc1 = this._leftDrawer.width;
                if (this._leftDrawerDivider !== null) 
                {
                    loc1 = loc1 + this._leftDrawerDivider.width;
                }
            }
            if (this.isTopDrawerDocked) 
            {
                loc2 = this._topDrawer.height;
                if (this._topDrawerDivider !== null) 
                {
                    loc2 = loc2 + this._topDrawerDivider.height;
                }
            }
            if (this._isDraggingLeftDrawer) 
            {
                loc3 = this._leftDrawer.width;
                if (this.isLeftDrawerOpen) 
                {
                    loc1 = loc3 + this._currentTouchX - this._startTouchX;
                }
                else 
                {
                    loc1 = this._currentTouchX - this._startTouchX;
                }
                if (loc1 < 0) 
                {
                    loc1 = 0;
                }
                if (loc1 > loc3) 
                {
                    loc1 = loc3;
                }
            }
            else if (this._isDraggingRightDrawer) 
            {
                loc4 = this._rightDrawer.width;
                if (this.isRightDrawerOpen) 
                {
                    loc1 = -loc4 + this._currentTouchX - this._startTouchX;
                }
                else 
                {
                    loc1 = this._currentTouchX - this._startTouchX;
                }
                if (loc1 < -loc4) 
                {
                    loc1 = -loc4;
                }
                if (loc1 > 0) 
                {
                    loc1 = 0;
                }
                if (this.isLeftDrawerDocked && this._openMode === feathers.layout.RelativeDepth.BELOW) 
                {
                    loc1 = loc1 + this._leftDrawer.width;
                    if (this._leftDrawerDivider !== null) 
                    {
                        loc1 = loc1 + this._leftDrawerDivider.width;
                    }
                }
            }
            else if (this._isDraggingTopDrawer) 
            {
                loc5 = this._topDrawer.height;
                if (this.isTopDrawerOpen) 
                {
                    loc2 = loc5 + this._currentTouchY - this._startTouchY;
                }
                else 
                {
                    loc2 = this._currentTouchY - this._startTouchY;
                }
                if (loc2 < 0) 
                {
                    loc2 = 0;
                }
                if (loc2 > loc5) 
                {
                    loc2 = loc5;
                }
            }
            else if (this._isDraggingBottomDrawer) 
            {
                loc6 = this._bottomDrawer.height;
                if (this.isBottomDrawerOpen) 
                {
                    loc2 = -loc6 + this._currentTouchY - this._startTouchY;
                }
                else 
                {
                    loc2 = this._currentTouchY - this._startTouchY;
                }
                if (loc2 < -loc6) 
                {
                    loc2 = -loc6;
                }
                if (loc2 > 0) 
                {
                    loc2 = 0;
                }
                if (this.isTopDrawerDocked && this._openMode === feathers.layout.RelativeDepth.BELOW) 
                {
                    loc2 = loc2 + this._topDrawer.height;
                    if (this._topDrawerDivider !== null) 
                    {
                        loc2 = loc2 + this._topDrawerDivider.height;
                    }
                }
            }
            if (this._openMode !== feathers.layout.RelativeDepth.ABOVE) 
            {
                this._content.x = loc1;
                this._content.y = loc2;
            }
            else if (this._isDraggingTopDrawer) 
            {
                this._topDrawer.y = loc2 - this._topDrawer.height;
            }
            else if (this._isDraggingRightDrawer) 
            {
                this._rightDrawer.x = this.actualWidth + loc1;
            }
            else if (this._isDraggingBottomDrawer) 
            {
                this._bottomDrawer.y = this.actualHeight + loc2;
            }
            else if (this._isDraggingLeftDrawer) 
            {
                this._leftDrawer.x = loc1 - this._leftDrawer.width;
            }
            if (this._isDraggingTopDrawer) 
            {
                this.topDrawerOpenOrCloseTween_onUpdate();
            }
            else if (this._isDraggingRightDrawer) 
            {
                this.rightDrawerOpenOrCloseTween_onUpdate();
            }
            else if (this._isDraggingBottomDrawer) 
            {
                this.bottomDrawerOpenOrCloseTween_onUpdate();
            }
            else if (this._isDraggingLeftDrawer) 
            {
                this.leftDrawerOpenOrCloseTween_onUpdate();
            }
            return;
        }

        public function get rightDrawerDivider():starling.display.DisplayObject
        {
            return this._rightDrawerDivider;
        }

        public function set rightDrawerDivider(arg1:starling.display.DisplayObject):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                if (arg1 !== null) 
                {
                    arg1.dispose();
                }
                return;
            }
            if (this._rightDrawerDivider === arg1) 
            {
                return;
            }
            if (this._rightDrawerDivider && this._rightDrawerDivider.parent == this) 
            {
                this.removeChild(this._rightDrawerDivider, false);
            }
            this._rightDrawerDivider = arg1;
            if (this._rightDrawerDivider) 
            {
                this._rightDrawerDivider.visible = false;
                this.addChild(this._rightDrawerDivider);
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function checkForDragToClose():void
        {
            var loc4:*=null;
            var loc1:*=this.stage === null ? starling.core.Starling.current : this.stage.starling;
            var loc2:*=(this._currentTouchX - this._startTouchX) / (feathers.system.DeviceCapabilities.dpi / loc1.contentScaleFactor);
            var loc3:*=(this._currentTouchY - this._startTouchY) / (feathers.system.DeviceCapabilities.dpi / loc1.contentScaleFactor);
            if (this.isLeftDrawerOpen && loc2 <= -this._minimumDragDistance) 
            {
                this._isDragging = true;
                this._isDraggingLeftDrawer = true;
                this.prepareLeftDrawer();
            }
            else if (this.isRightDrawerOpen && loc2 >= this._minimumDragDistance) 
            {
                this._isDragging = true;
                this._isDraggingRightDrawer = true;
                this.prepareRightDrawer();
            }
            else if (this.isTopDrawerOpen && loc3 <= -this._minimumDragDistance) 
            {
                this._isDragging = true;
                this._isDraggingTopDrawer = true;
                this.prepareTopDrawer();
            }
            else if (this.isBottomDrawerOpen && loc3 >= this._minimumDragDistance) 
            {
                this._isDragging = true;
                this._isDraggingBottomDrawer = true;
                this.prepareBottomDrawer();
            }
            if (this._isDragging) 
            {
                if (this._overlaySkin) 
                {
                    this._overlaySkin.visible = true;
                    this._overlaySkin.alpha = this._overlaySkinOriginalAlpha;
                }
                this._startTouchX = this._currentTouchX;
                this._startTouchY = this._currentTouchY;
                loc4 = feathers.events.ExclusiveTouch.forStage(this.stage);
                loc4.removeEventListener(starling.events.Event.CHANGE, this.exclusiveTouch_changeHandler);
                loc4.claimTouch(this.touchPointID, this);
                this.dispatchEventWith(feathers.events.FeathersEventType.BEGIN_INTERACTION);
            }
            return;
        }

        public function get rightDrawerDockMode():String
        {
            return this._rightDrawerDockMode;
        }

        public function set rightDrawerDockMode(arg1:String):void
        {
            if (this._rightDrawerDockMode == arg1) 
            {
                return;
            }
            this._rightDrawerDockMode = arg1;
            this.invalidate(INVALIDATION_FLAG_LAYOUT);
            return;
        }

        protected function checkForDragToOpen():void
        {
            var loc4:*=null;
            var loc1:*=this.stage === null ? starling.core.Starling.current : this.stage.starling;
            var loc2:*=(this._currentTouchX - this._startTouchX) / (feathers.system.DeviceCapabilities.dpi / loc1.contentScaleFactor);
            var loc3:*=(this._currentTouchY - this._startTouchY) / (feathers.system.DeviceCapabilities.dpi / loc1.contentScaleFactor);
            if (this._leftDrawer && !this.isLeftDrawerDocked && loc2 >= this._minimumDragDistance) 
            {
                this._isDragging = true;
                this._isDraggingLeftDrawer = true;
                this.prepareLeftDrawer();
            }
            else if (this._rightDrawer && !this.isRightDrawerDocked && loc2 <= -this._minimumDragDistance) 
            {
                this._isDragging = true;
                this._isDraggingRightDrawer = true;
                this.prepareRightDrawer();
            }
            else if (this._topDrawer && !this.isTopDrawerDocked && loc3 >= this._minimumDragDistance) 
            {
                this._isDragging = true;
                this._isDraggingTopDrawer = true;
                this.prepareTopDrawer();
            }
            else if (this._bottomDrawer && !this.isBottomDrawerDocked && loc3 <= -this._minimumDragDistance) 
            {
                this._isDragging = true;
                this._isDraggingBottomDrawer = true;
                this.prepareBottomDrawer();
            }
            if (this._isDragging) 
            {
                if (this._overlaySkin) 
                {
                    this._overlaySkin.visible = true;
                    this._overlaySkin.alpha = 0;
                }
                this._startTouchX = this._currentTouchX;
                this._startTouchY = this._currentTouchY;
                loc4 = feathers.events.ExclusiveTouch.forStage(this.stage);
                loc4.claimTouch(this.touchPointID, this);
                loc4.removeEventListener(starling.events.Event.CHANGE, this.exclusiveTouch_changeHandler);
                this.dispatchEventWith(feathers.events.FeathersEventType.BEGIN_INTERACTION);
            }
            return;
        }

        public function get rightDrawerToggleEventType():String
        {
            return this._rightDrawerToggleEventType;
        }

        public function set rightDrawerToggleEventType(arg1:String):void
        {
            if (this._rightDrawerToggleEventType == arg1) 
            {
                return;
            }
            if (this.contentEventDispatcher && this._rightDrawerToggleEventType) 
            {
                this.contentEventDispatcher.removeEventListener(this._rightDrawerToggleEventType, this.content_rightDrawerToggleEventTypeHandler);
            }
            this._rightDrawerToggleEventType = arg1;
            if (this.contentEventDispatcher && this._rightDrawerToggleEventType) 
            {
                this.contentEventDispatcher.addEventListener(this._rightDrawerToggleEventType, this.content_rightDrawerToggleEventTypeHandler);
            }
            return;
        }

        protected function positionOverlaySkin():void
        {
            if (!this._overlaySkin) 
            {
                return;
            }
            if (this.isLeftDrawerDocked) 
            {
                this._overlaySkin.x = this._leftDrawer.x;
            }
            else if (this._openMode === feathers.layout.RelativeDepth.ABOVE && this._leftDrawer) 
            {
                this._overlaySkin.x = this._leftDrawer.x + this._leftDrawer.width;
            }
            else 
            {
                this._overlaySkin.x = this._content.x;
            }
            if (this.isTopDrawerDocked) 
            {
                this._overlaySkin.y = this._topDrawer.y;
            }
            else if (this._openMode === feathers.layout.RelativeDepth.ABOVE && this._topDrawer) 
            {
                this._overlaySkin.y = this._topDrawer.y + this._topDrawer.height;
            }
            else 
            {
                this._overlaySkin.y = this._content.y;
            }
            return;
        }

        public function get isRightDrawerOpen():Boolean
        {
            return this._rightDrawer && this._isRightDrawerOpen;
        }

        public function set isRightDrawerOpen(arg1:Boolean):void
        {
            if (this.isRightDrawerDocked || this._isRightDrawerOpen == arg1) 
            {
                return;
            }
            if (arg1) 
            {
                this.isTopDrawerOpen = false;
                this.isBottomDrawerOpen = false;
                this.isLeftDrawerOpen = false;
            }
            this._isRightDrawerOpen = arg1;
            this.invalidate(INVALIDATION_FLAG_SELECTED);
            return;
        }

        public function get isRightDrawerDocked():Boolean
        {
            if (!this._rightDrawer) 
            {
                return false;
            }
            if (this._rightDrawerDockMode === feathers.layout.Orientation.BOTH) 
            {
                return true;
            }
            if (this._rightDrawerDockMode === feathers.layout.Orientation.NONE) 
            {
                return false;
            }
            var loc1:*=this.stage;
            if (loc1 === null) 
            {
                loc1 = starling.core.Starling.current.stage;
            }
            if (loc1.stageWidth > loc1.stageHeight) 
            {
                return this._rightDrawerDockMode === feathers.layout.Orientation.LANDSCAPE;
            }
            return this._rightDrawerDockMode === feathers.layout.Orientation.PORTRAIT;
        }

        protected function topDrawerOpenOrCloseTween_onUpdate():void
        {
            var loc1:*=NaN;
            if (this._overlaySkin) 
            {
                if (this._openMode !== feathers.layout.RelativeDepth.ABOVE) 
                {
                    loc1 = this._content.y / this._topDrawer.height;
                }
                else 
                {
                    loc1 = 1 + this._topDrawer.y / this._topDrawer.height;
                }
                this._overlaySkin.alpha = this._overlaySkinOriginalAlpha * loc1;
            }
            this.openOrCloseTween_onUpdate();
            return;
        }

        protected function rightDrawerOpenOrCloseTween_onUpdate():void
        {
            var loc1:*=NaN;
            if (this._overlaySkin) 
            {
                if (this._openMode !== feathers.layout.RelativeDepth.ABOVE) 
                {
                    loc1 = (this.actualWidth - this._content.x - this._content.width) / this._rightDrawer.width;
                }
                else 
                {
                    loc1 = (-(this._rightDrawer.x - this.actualWidth)) / this._rightDrawer.width;
                }
                this._overlaySkin.alpha = this._overlaySkinOriginalAlpha * loc1;
            }
            this.openOrCloseTween_onUpdate();
            return;
        }

        protected function bottomDrawerOpenOrCloseTween_onUpdate():void
        {
            var loc1:*=NaN;
            if (this._overlaySkin) 
            {
                if (this._openMode !== feathers.layout.RelativeDepth.ABOVE) 
                {
                    loc1 = (this.actualHeight - this._content.y - this._content.height) / this._bottomDrawer.height;
                }
                else 
                {
                    loc1 = (-(this._bottomDrawer.y - this.actualHeight)) / this._bottomDrawer.height;
                }
                this._overlaySkin.alpha = this._overlaySkinOriginalAlpha * loc1;
            }
            this.openOrCloseTween_onUpdate();
            return;
        }

        public function get bottomDrawer():feathers.core.IFeathersControl
        {
            return this._bottomDrawer;
        }

        protected function leftDrawerOpenOrCloseTween_onUpdate():void
        {
            var loc1:*=NaN;
            if (this._overlaySkin) 
            {
                if (this._openMode !== feathers.layout.RelativeDepth.ABOVE) 
                {
                    loc1 = this._content.x / this._leftDrawer.width;
                }
                else 
                {
                    loc1 = 1 + this._leftDrawer.x / this._leftDrawer.width;
                }
                this._overlaySkin.alpha = this._overlaySkinOriginalAlpha * loc1;
            }
            this.openOrCloseTween_onUpdate();
            return;
        }

        protected function openOrCloseTween_onUpdate():void
        {
            var loc1:*=false;
            var loc2:*=false;
            var loc3:*=false;
            var loc4:*=false;
            var loc5:*=NaN;
            var loc6:*=NaN;
            var loc7:*=NaN;
            var loc8:*=null;
            var loc9:*=NaN;
            var loc10:*=NaN;
            if (this._clipDrawers && this._openMode === feathers.layout.RelativeDepth.BELOW) 
            {
                loc1 = this.isTopDrawerDocked;
                loc2 = this.isRightDrawerDocked;
                loc3 = this.isBottomDrawerDocked;
                loc4 = this.isLeftDrawerDocked;
                loc5 = this._content.x;
                loc6 = this._content.y;
                if (loc1) 
                {
                    if (loc4) 
                    {
                        loc7 = this._leftDrawer.width;
                        if (this._leftDrawerDivider !== null) 
                        {
                            loc7 = loc7 + this._leftDrawerDivider.width;
                        }
                        this._topDrawer.x = loc5 - loc7;
                    }
                    else 
                    {
                        this._topDrawer.x = loc5;
                    }
                    if (this._topDrawerDivider === null) 
                    {
                        this._topDrawer.y = loc6 - this._topDrawer.height;
                    }
                    else 
                    {
                        this._topDrawerDivider.x = this._topDrawer.x;
                        this._topDrawerDivider.y = loc6 - this._topDrawerDivider.height;
                        this._topDrawer.y = this._topDrawerDivider.y - this._topDrawer.height;
                    }
                }
                if (loc2) 
                {
                    if (this._rightDrawerDivider === null) 
                    {
                        this._rightDrawer.x = loc5 + this._content.width;
                    }
                    else 
                    {
                        this._rightDrawerDivider.x = loc5 + this._content.width;
                        this._rightDrawer.x = this._rightDrawerDivider.x + this._rightDrawerDivider.width;
                        this._rightDrawerDivider.y = loc6;
                    }
                    this._rightDrawer.y = loc6;
                }
                if (loc3) 
                {
                    if (loc4) 
                    {
                        loc7 = this._leftDrawer.width;
                        if (this._leftDrawerDivider !== null) 
                        {
                            loc7 = loc7 + this._leftDrawerDivider.width;
                        }
                        this._bottomDrawer.x = loc5 - loc7;
                    }
                    else 
                    {
                        this._bottomDrawer.x = loc5;
                    }
                    if (this._bottomDrawerDivider === null) 
                    {
                        this._bottomDrawer.y = loc6 + this._content.height;
                    }
                    else 
                    {
                        this._bottomDrawerDivider.x = this._bottomDrawer.x;
                        this._bottomDrawerDivider.y = loc6 + this._content.height;
                        this._bottomDrawer.y = this._bottomDrawerDivider.y + this._bottomDrawerDivider.height;
                    }
                }
                if (loc4) 
                {
                    if (this._leftDrawerDivider === null) 
                    {
                        this._leftDrawer.x = loc5 - this._leftDrawer.width;
                    }
                    else 
                    {
                        this._leftDrawerDivider.x = loc5 - this._leftDrawerDivider.width;
                        this._leftDrawer.x = this._leftDrawerDivider.x - this._leftDrawer.width;
                        this._leftDrawerDivider.y = loc6;
                    }
                    this._leftDrawer.y = loc6;
                }
                if (this._topDrawer !== null) 
                {
                    loc8 = this._topDrawer.mask as starling.display.Quad;
                    if (loc8 !== null) 
                    {
                        loc8.height = loc6;
                    }
                }
                if (this._rightDrawer !== null) 
                {
                    loc8 = this._rightDrawer.mask as starling.display.Quad;
                    if (loc8 !== null) 
                    {
                        loc9 = -loc5;
                        if (loc4) 
                        {
                            loc9 = -this._leftDrawer.x;
                        }
                        loc8.x = this._rightDrawer.width - loc9;
                        loc8.width = loc9;
                    }
                }
                if (this._bottomDrawer !== null) 
                {
                    loc8 = this._bottomDrawer.mask as starling.display.Quad;
                    if (loc8 !== null) 
                    {
                        loc10 = -loc6;
                        if (loc1) 
                        {
                            loc10 = -this._topDrawer.y;
                        }
                        loc8.y = this._bottomDrawer.height - loc10;
                        loc8.height = loc10;
                    }
                }
                if (this._leftDrawer !== null) 
                {
                    loc8 = this._leftDrawer.mask as starling.display.Quad;
                    if (loc8 !== null) 
                    {
                        loc8.width = loc5;
                    }
                }
            }
            if (this._overlaySkin !== null) 
            {
                this.positionOverlaySkin();
            }
            return;
        }

        public function get bottomDrawerDivider():starling.display.DisplayObject
        {
            return this._bottomDrawerDivider;
        }

        public function set bottomDrawerDivider(arg1:starling.display.DisplayObject):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                if (arg1 !== null) 
                {
                    arg1.dispose();
                }
                return;
            }
            if (this._bottomDrawerDivider === arg1) 
            {
                return;
            }
            if (this._bottomDrawerDivider && this._bottomDrawerDivider.parent == this) 
            {
                this.removeChild(this._bottomDrawerDivider, false);
            }
            this._bottomDrawerDivider = arg1;
            if (this._bottomDrawerDivider) 
            {
                this._bottomDrawerDivider.visible = false;
                this.addChild(this._bottomDrawerDivider);
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function topDrawerOpenOrCloseTween_onComplete():void
        {
            if (this._overlaySkin) 
            {
                this._overlaySkin.alpha = this._overlaySkinOriginalAlpha;
            }
            this._openOrCloseTween = null;
            this._topDrawer.mask = null;
            var loc1:*=this.isTopDrawerOpen;
            var loc2:*=this.isTopDrawerDocked;
            this._topDrawer.visible = loc1 || loc2;
            if (this._overlaySkin) 
            {
                this._overlaySkin.visible = loc1;
            }
            if (loc1) 
            {
                this.dispatchEventWith(starling.events.Event.OPEN, false, this._topDrawer);
            }
            else 
            {
                this.dispatchEventWith(starling.events.Event.CLOSE, false, this._topDrawer);
            }
            return;
        }

        public function get bottomDrawerDockMode():String
        {
            return this._bottomDrawerDockMode;
        }

        public function set bottomDrawerDockMode(arg1:String):void
        {
            if (this._bottomDrawerDockMode == arg1) 
            {
                return;
            }
            this._bottomDrawerDockMode = arg1;
            this.invalidate(INVALIDATION_FLAG_LAYOUT);
            return;
        }

        protected function rightDrawerOpenOrCloseTween_onComplete():void
        {
            this._openOrCloseTween = null;
            this._rightDrawer.mask = null;
            var loc1:*=this.isRightDrawerOpen;
            var loc2:*=this.isRightDrawerDocked;
            this._rightDrawer.visible = loc1 || loc2;
            if (this._overlaySkin) 
            {
                this._overlaySkin.visible = loc1;
            }
            if (loc1) 
            {
                this.dispatchEventWith(starling.events.Event.OPEN, false, this._rightDrawer);
            }
            else 
            {
                this.dispatchEventWith(starling.events.Event.CLOSE, false, this._rightDrawer);
            }
            return;
        }

        public function get bottomDrawerToggleEventType():String
        {
            return this._bottomDrawerToggleEventType;
        }

        public function set bottomDrawerToggleEventType(arg1:String):void
        {
            if (this._bottomDrawerToggleEventType == arg1) 
            {
                return;
            }
            if (this.contentEventDispatcher && this._bottomDrawerToggleEventType) 
            {
                this.contentEventDispatcher.removeEventListener(this._bottomDrawerToggleEventType, this.content_bottomDrawerToggleEventTypeHandler);
            }
            this._bottomDrawerToggleEventType = arg1;
            if (this.contentEventDispatcher && this._bottomDrawerToggleEventType) 
            {
                this.contentEventDispatcher.addEventListener(this._bottomDrawerToggleEventType, this.content_bottomDrawerToggleEventTypeHandler);
            }
            return;
        }

        protected function bottomDrawerOpenOrCloseTween_onComplete():void
        {
            this._openOrCloseTween = null;
            this._bottomDrawer.mask = null;
            var loc1:*=this.isBottomDrawerOpen;
            var loc2:*=this.isBottomDrawerDocked;
            this._bottomDrawer.visible = loc1 || loc2;
            if (this._overlaySkin) 
            {
                this._overlaySkin.visible = loc1;
            }
            if (loc1) 
            {
                this.dispatchEventWith(starling.events.Event.OPEN, false, this._bottomDrawer);
            }
            else 
            {
                this.dispatchEventWith(starling.events.Event.CLOSE, false, this._bottomDrawer);
            }
            return;
        }

        public function get isBottomDrawerOpen():Boolean
        {
            return this._bottomDrawer && this._isBottomDrawerOpen;
        }

        public function set isBottomDrawerOpen(arg1:Boolean):void
        {
            if (this.isBottomDrawerDocked || this._isBottomDrawerOpen == arg1) 
            {
                return;
            }
            if (arg1) 
            {
                this.isTopDrawerOpen = false;
                this.isRightDrawerOpen = false;
                this.isLeftDrawerOpen = false;
            }
            this._isBottomDrawerOpen = arg1;
            this.invalidate(INVALIDATION_FLAG_SELECTED);
            return;
        }

        public function get isBottomDrawerDocked():Boolean
        {
            if (!this._bottomDrawer) 
            {
                return false;
            }
            if (this._bottomDrawerDockMode === feathers.layout.Orientation.BOTH) 
            {
                return true;
            }
            if (this._bottomDrawerDockMode === feathers.layout.Orientation.NONE) 
            {
                return false;
            }
            var loc1:*=this.stage;
            if (loc1 === null) 
            {
                loc1 = starling.core.Starling.current.stage;
            }
            if (loc1.stageWidth > loc1.stageHeight) 
            {
                return this._bottomDrawerDockMode === feathers.layout.Orientation.LANDSCAPE;
            }
            return this._bottomDrawerDockMode === feathers.layout.Orientation.PORTRAIT;
        }

        protected function leftDrawerOpenOrCloseTween_onComplete():void
        {
            this._openOrCloseTween = null;
            this._leftDrawer.mask = null;
            var loc1:*=this.isLeftDrawerOpen;
            var loc2:*=this.isLeftDrawerDocked;
            this._leftDrawer.visible = loc1 || loc2;
            if (this._overlaySkin) 
            {
                this._overlaySkin.visible = loc1;
            }
            if (loc1) 
            {
                this.dispatchEventWith(starling.events.Event.OPEN, false, this._leftDrawer);
            }
            else 
            {
                this.dispatchEventWith(starling.events.Event.CLOSE, false, this._leftDrawer);
            }
            return;
        }

        protected function content_eventDispatcherChangeHandler(arg1:starling.events.Event):void
        {
            this.refreshCurrentEventTarget();
            return;
        }

        protected function drawers_addedToStageHandler(arg1:starling.events.Event):void
        {
            this.stage.addEventListener(starling.events.ResizeEvent.RESIZE, this.stage_resizeHandler);
            var loc1:*=-feathers.utils.display.getDisplayObjectDepthFromStage(this);
            var loc2:*=this.stage === null ? starling.core.Starling.current : this.stage.starling;
            loc2.nativeStage.addEventListener(flash.events.KeyboardEvent.KEY_DOWN, this.drawers_nativeStage_keyDownHandler, false, loc1, true);
            return;
        }

        public function get leftDrawer():feathers.core.IFeathersControl
        {
            return this._leftDrawer;
        }

        public function set leftDrawer(arg1:feathers.core.IFeathersControl):void
        {
            if (this._leftDrawer === arg1) 
            {
                return;
            }
            if (this.isLeftDrawerOpen && arg1 === null) 
            {
                this.isLeftDrawerOpen = false;
            }
            if (this._leftDrawer && this._leftDrawer.parent === this) 
            {
                this.removeChild(starling.display.DisplayObject(this._leftDrawer), false);
            }
            this._leftDrawer = arg1;
            this._originalLeftDrawerWidth = NaN;
            this._originalLeftDrawerHeight = NaN;
            if (this._leftDrawer) 
            {
                this._leftDrawer.visible = false;
                this._leftDrawer.addEventListener(feathers.events.FeathersEventType.RESIZE, this.drawer_resizeHandler);
                if (this._openMode !== feathers.layout.RelativeDepth.ABOVE) 
                {
                    this.addChildAt(starling.display.DisplayObject(this._leftDrawer), 0);
                }
                else 
                {
                    this.addChild(starling.display.DisplayObject(this._leftDrawer));
                }
            }
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        protected function drawers_removedFromStageHandler(arg1:starling.events.Event):void
        {
            var loc2:*=null;
            if (this.touchPointID >= 0) 
            {
                loc2 = feathers.events.ExclusiveTouch.forStage(this.stage);
                loc2.removeEventListener(starling.events.Event.CHANGE, this.exclusiveTouch_changeHandler);
            }
            this.touchPointID = -1;
            this._isDragging = false;
            this._isDraggingTopDrawer = false;
            this._isDraggingRightDrawer = false;
            this._isDraggingBottomDrawer = false;
            this._isDraggingLeftDrawer = false;
            this.stage.removeEventListener(starling.events.ResizeEvent.RESIZE, this.stage_resizeHandler);
            var loc1:*=this.stage === null ? starling.core.Starling.current : this.stage.starling;
            loc1.nativeStage.removeEventListener(flash.events.KeyboardEvent.KEY_DOWN, this.drawers_nativeStage_keyDownHandler);
            return;
        }

        public function get leftDrawerDivider():starling.display.DisplayObject
        {
            return this._leftDrawerDivider;
        }

        public function set leftDrawerDivider(arg1:starling.display.DisplayObject):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                if (arg1 !== null) 
                {
                    arg1.dispose();
                }
                return;
            }
            if (this._leftDrawerDivider === arg1) 
            {
                return;
            }
            if (this._leftDrawerDivider && this._leftDrawerDivider.parent == this) 
            {
                this.removeChild(this._leftDrawerDivider, false);
            }
            this._leftDrawerDivider = arg1;
            if (this._leftDrawerDivider) 
            {
                this._leftDrawerDivider.visible = false;
                this.addChild(this._leftDrawerDivider);
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function drawers_touchHandler(arg1:starling.events.TouchEvent):void
        {
            var loc1:*=null;
            if (!this._isEnabled || this._openOrCloseTween) 
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
                if (loc1.phase != starling.events.TouchPhase.MOVED) 
                {
                    if (loc1.phase == starling.events.TouchPhase.ENDED) 
                    {
                        this.touchPointID = -1;
                        if (this._isDragging) 
                        {
                            this.handleDragEnd();
                            this.dispatchEventWith(feathers.events.FeathersEventType.END_INTERACTION);
                        }
                        else 
                        {
                            feathers.events.ExclusiveTouch.forStage(this.stage).removeEventListener(starling.events.Event.CHANGE, this.exclusiveTouch_changeHandler);
                            if (this.isTopDrawerOpen || this.isRightDrawerOpen || this.isBottomDrawerOpen || this.isLeftDrawerOpen) 
                            {
                                this.handleTapToClose(loc1);
                            }
                        }
                    }
                }
                else 
                {
                    this.handleTouchMoved(loc1);
                    if (!this._isDragging) 
                    {
                        if (this.isTopDrawerOpen || this.isRightDrawerOpen || this.isBottomDrawerOpen || this.isLeftDrawerOpen) 
                        {
                            this.checkForDragToClose();
                        }
                        else 
                        {
                            this.checkForDragToOpen();
                        }
                    }
                    if (this._isDragging) 
                    {
                        this.handleDragMove();
                    }
                }
            }
            else 
            {
                loc1 = arg1.getTouch(this, starling.events.TouchPhase.BEGAN);
                if (!loc1) 
                {
                    return;
                }
                this.handleTouchBegan(loc1);
            }
            return;
        }

        public function get leftDrawerDockMode():String
        {
            return this._leftDrawerDockMode;
        }

        public function set leftDrawerDockMode(arg1:String):void
        {
            if (this._leftDrawerDockMode == arg1) 
            {
                return;
            }
            this._leftDrawerDockMode = arg1;
            this.invalidate(INVALIDATION_FLAG_LAYOUT);
            return;
        }

        protected function stage_resizeHandler(arg1:starling.events.ResizeEvent):void
        {
            this.invalidate(INVALIDATION_FLAG_SIZE);
            return;
        }

        public function get leftDrawerToggleEventType():String
        {
            return this._leftDrawerToggleEventType;
        }

        public function set leftDrawerToggleEventType(arg1:String):void
        {
            if (this._leftDrawerToggleEventType == arg1) 
            {
                return;
            }
            if (this.contentEventDispatcher && this._leftDrawerToggleEventType) 
            {
                this.contentEventDispatcher.removeEventListener(this._leftDrawerToggleEventType, this.content_leftDrawerToggleEventTypeHandler);
            }
            this._leftDrawerToggleEventType = arg1;
            if (this.contentEventDispatcher && this._leftDrawerToggleEventType) 
            {
                this.contentEventDispatcher.addEventListener(this._leftDrawerToggleEventType, this.content_leftDrawerToggleEventTypeHandler);
            }
            return;
        }

        public function get contentEventDispatcherChangeEventType():String
        {
            return this._contentEventDispatcherChangeEventType;
        }

        public function get isLeftDrawerOpen():Boolean
        {
            return this._leftDrawer && this._isLeftDrawerOpen;
        }

        public function set isLeftDrawerOpen(arg1:Boolean):void
        {
            if (this.isLeftDrawerDocked || this._isLeftDrawerOpen == arg1) 
            {
                return;
            }
            if (arg1) 
            {
                this.isTopDrawerOpen = false;
                this.isRightDrawerOpen = false;
                this.isBottomDrawerOpen = false;
            }
            this._isLeftDrawerOpen = arg1;
            this.invalidate(INVALIDATION_FLAG_SELECTED);
            return;
        }

        public function get isLeftDrawerDocked():Boolean
        {
            if (!this._leftDrawer) 
            {
                return false;
            }
            if (this._leftDrawerDockMode === feathers.layout.Orientation.BOTH) 
            {
                return true;
            }
            if (this._leftDrawerDockMode === feathers.layout.Orientation.NONE) 
            {
                return false;
            }
            var loc1:*=this.stage;
            if (loc1 === null) 
            {
                loc1 = starling.core.Starling.current.stage;
            }
            if (loc1.stageWidth > loc1.stageHeight) 
            {
                return this._leftDrawerDockMode === feathers.layout.Orientation.LANDSCAPE;
            }
            return this._leftDrawerDockMode == feathers.layout.Orientation.PORTRAIT;
        }

        protected function drawers_nativeStage_keyDownHandler(arg1:flash.events.KeyboardEvent):void
        {
            var loc1:*=false;
            if (arg1.isDefaultPrevented()) 
            {
                return;
            }
            if (arg1.keyCode == flash.ui.Keyboard.BACK) 
            {
                loc1 = false;
                if (this.isTopDrawerOpen) 
                {
                    this.toggleTopDrawer();
                    loc1 = true;
                }
                else if (this.isRightDrawerOpen) 
                {
                    this.toggleRightDrawer();
                    loc1 = true;
                }
                else if (this.isBottomDrawerOpen) 
                {
                    this.toggleBottomDrawer();
                    loc1 = true;
                }
                else if (this.isLeftDrawerOpen) 
                {
                    this.toggleLeftDrawer();
                    loc1 = true;
                }
                if (loc1) 
                {
                    arg1.preventDefault();
                }
            }
            return;
        }

        public function get autoSizeMode():String
        {
            return this._autoSizeMode;
        }

        public function set autoSizeMode(arg1:String):void
        {
            if (this._autoSizeMode == arg1) 
            {
                return;
            }
            this._autoSizeMode = arg1;
            if (this._content) 
            {
                if (this._autoSizeMode != feathers.controls.AutoSizeMode.CONTENT) 
                {
                    this._content.removeEventListener(feathers.events.FeathersEventType.RESIZE, this.content_resizeHandler);
                }
                else 
                {
                    this._content.addEventListener(feathers.events.FeathersEventType.RESIZE, this.content_resizeHandler);
                }
            }
            this.invalidate(INVALIDATION_FLAG_SIZE);
            return;
        }

        protected function content_topDrawerToggleEventTypeHandler(arg1:starling.events.Event):void
        {
            if (!this._topDrawer || this.isTopDrawerDocked) 
            {
                return;
            }
            this._isTopDrawerOpen = !this._isTopDrawerOpen;
            this.openOrCloseTopDrawer();
            return;
        }

        public function get clipDrawers():Boolean
        {
            return this._clipDrawers;
        }

        public function set clipDrawers(arg1:Boolean):void
        {
            if (this._clipDrawers == arg1) 
            {
                return;
            }
            this._clipDrawers = arg1;
            this.invalidate(INVALIDATION_FLAG_LAYOUT);
            return;
        }

        protected function content_rightDrawerToggleEventTypeHandler(arg1:starling.events.Event):void
        {
            if (!this._rightDrawer || this.isRightDrawerDocked) 
            {
                return;
            }
            this._isRightDrawerOpen = !this._isRightDrawerOpen;
            this.openOrCloseRightDrawer();
            return;
        }

        public function get openMode():String
        {
            return this._openMode;
        }

        public function set openMode(arg1:String):void
        {
            if (arg1 === OPEN_MODE_ABOVE) 
            {
                arg1 = feathers.layout.RelativeDepth.ABOVE;
            }
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._openMode == arg1) 
            {
                return;
            }
            this._openMode = arg1;
            if (this._content) 
            {
                if (this._openMode !== feathers.layout.RelativeDepth.ABOVE) 
                {
                    if (this._overlaySkin) 
                    {
                        this.setChildIndex(starling.display.DisplayObject(this._content), (this.numChildren - 1));
                        this.setChildIndex(this._overlaySkin, (this.numChildren - 1));
                    }
                    else 
                    {
                        this.setChildIndex(starling.display.DisplayObject(this._content), (this.numChildren - 1));
                    }
                }
                else 
                {
                    this.setChildIndex(starling.display.DisplayObject(this._content), 0);
                }
            }
            this.invalidate(INVALIDATION_FLAG_LAYOUT);
            return;
        }

        protected function content_bottomDrawerToggleEventTypeHandler(arg1:starling.events.Event):void
        {
            if (!this._bottomDrawer || this.isBottomDrawerDocked) 
            {
                return;
            }
            this._isBottomDrawerOpen = !this._isBottomDrawerOpen;
            this.openOrCloseBottomDrawer();
            return;
        }

        public function get openGesture():String
        {
            return this._openGesture;
        }

        public function set openGesture(arg1:String):void
        {
            if (arg1 !== OPEN_GESTURE_DRAG_CONTENT) 
            {
                if (arg1 === OPEN_GESTURE_DRAG_CONTENT_EDGE) 
                {
                    arg1 = feathers.controls.DragGesture.EDGE;
                }
            }
            else 
            {
                arg1 = feathers.controls.DragGesture.CONTENT;
            }
            this._openGesture = arg1;
            return;
        }

        protected function content_leftDrawerToggleEventTypeHandler(arg1:starling.events.Event):void
        {
            if (!this._leftDrawer || this.isLeftDrawerDocked) 
            {
                return;
            }
            this._isLeftDrawerOpen = !this._isLeftDrawerOpen;
            this.openOrCloseLeftDrawer();
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

        protected function content_resizeHandler(arg1:starling.events.Event):void
        {
            if (this._isValidating || !(this._autoSizeMode == feathers.controls.AutoSizeMode.CONTENT)) 
            {
                return;
            }
            this.invalidate(INVALIDATION_FLAG_SIZE);
            return;
        }

        public function get minimumDrawerThrowVelocity():Number
        {
            return this._minimumDrawerThrowVelocity;
        }

        public function set minimumDrawerThrowVelocity(arg1:Number):void
        {
            this._minimumDrawerThrowVelocity = arg1;
            return;
        }

        protected function drawer_resizeHandler(arg1:starling.events.Event):void
        {
            if (this._isValidating) 
            {
                return;
            }
            this.invalidate(INVALIDATION_FLAG_SIZE);
            return;
        }

        public function get openGestureEdgeSize():Number
        {
            return this._openGestureEdgeSize;
        }

        public function set openGestureEdgeSize(arg1:Number):void
        {
            this._openGestureEdgeSize = arg1;
            return;
        }

        
        {
            new Vector.<Number>(4)[0] = 1;
            new Vector.<Number>(4)[1] = 1.33;
            new Vector.<Number>(4)[2] = 1.66;
            new Vector.<Number>(4)[3] = 2;
        }

        protected function exclusiveTouch_changeHandler(arg1:starling.events.Event, arg2:int):void
        {
            if (this.touchPointID < 0 || !(this.touchPointID == arg2) || this._isDragging) 
            {
                return;
            }
            var loc1:*=feathers.events.ExclusiveTouch.forStage(this.stage);
            if (loc1.getClaim(arg2) == this) 
            {
                return;
            }
            this.touchPointID = -1;
            return;
        }

        public function set contentEventDispatcherChangeEventType(arg1:String):void
        {
            if (this._contentEventDispatcherChangeEventType == arg1) 
            {
                return;
            }
            if (this._content && this._contentEventDispatcherChangeEventType) 
            {
                this._content.removeEventListener(this._contentEventDispatcherChangeEventType, this.content_eventDispatcherChangeHandler);
            }
            this._contentEventDispatcherChangeEventType = arg1;
            if (this._content && this._contentEventDispatcherChangeEventType) 
            {
                this._content.addEventListener(this._contentEventDispatcherChangeEventType, this.content_eventDispatcherChangeHandler);
            }
            return;
        }

        public function get contentEventDispatcherField():String
        {
            return this._contentEventDispatcherField;
        }

        public function set contentEventDispatcherField(arg1:String):void
        {
            if (this._contentEventDispatcherField == arg1) 
            {
                return;
            }
            this._contentEventDispatcherField = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        public function get contentEventDispatcherFunction():Function
        {
            return this._contentEventDispatcherFunction;
        }

        public function set contentEventDispatcherFunction(arg1:Function):void
        {
            if (this._contentEventDispatcherFunction == arg1) 
            {
                return;
            }
            this._contentEventDispatcherFunction = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        public function get openOrCloseDuration():Number
        {
            return this._openOrCloseDuration;
        }

        public function set openOrCloseDuration(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            this._openOrCloseDuration = arg1;
            return;
        }

        public function get openOrCloseEase():Object
        {
            return this._openOrCloseEase;
        }

        public function set openOrCloseEase(arg1:Object):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            this._openOrCloseEase = arg1;
            return;
        }

        public override function hitTest(arg1:flash.geom.Point):starling.display.DisplayObject
        {
            var loc1:*=super.hitTest(arg1);
            if (loc1) 
            {
                if (this._isDragging) 
                {
                    return this;
                }
                if (this.isTopDrawerOpen && !(loc1 == this._topDrawer) && !(this._topDrawer is starling.display.DisplayObjectContainer && starling.display.DisplayObjectContainer(this._topDrawer).contains(loc1))) 
                {
                    return this;
                }
                if (this.isRightDrawerOpen && !(loc1 == this._rightDrawer) && !(this._rightDrawer is starling.display.DisplayObjectContainer && starling.display.DisplayObjectContainer(this._rightDrawer).contains(loc1))) 
                {
                    return this;
                }
                if (this.isBottomDrawerOpen && !(loc1 == this._bottomDrawer) && !(this._bottomDrawer is starling.display.DisplayObjectContainer && starling.display.DisplayObjectContainer(this._bottomDrawer).contains(loc1))) 
                {
                    return this;
                }
                if (this.isLeftDrawerOpen && !(loc1 == this._leftDrawer) && !(this._leftDrawer is starling.display.DisplayObjectContainer && starling.display.DisplayObjectContainer(this._leftDrawer).contains(loc1))) 
                {
                    return this;
                }
                return loc1;
            }
            if (!this.visible || !this.touchable) 
            {
                return null;
            }
            return this._hitArea.contains(arg1.x, arg1.y) ? this : null;
        }

        public function toggleTopDrawer(arg1:Number=NaN):void
        {
            if (!this._topDrawer || this.isTopDrawerDocked) 
            {
                return;
            }
            this.pendingToggleDuration = arg1;
            if (this.isToggleTopDrawerPending) 
            {
                return;
            }
            if (!this.isTopDrawerOpen) 
            {
                this.isRightDrawerOpen = false;
                this.isBottomDrawerOpen = false;
                this.isLeftDrawerOpen = false;
            }
            this.isToggleTopDrawerPending = true;
            this.isToggleRightDrawerPending = false;
            this.isToggleBottomDrawerPending = false;
            this.isToggleLeftDrawerPending = false;
            this.invalidate(INVALIDATION_FLAG_SELECTED);
            return;
        }

        public function toggleRightDrawer(arg1:Number=NaN):void
        {
            if (!this._rightDrawer || this.isRightDrawerDocked) 
            {
                return;
            }
            this.pendingToggleDuration = arg1;
            if (this.isToggleRightDrawerPending) 
            {
                return;
            }
            if (!this.isRightDrawerOpen) 
            {
                this.isTopDrawerOpen = false;
                this.isBottomDrawerOpen = false;
                this.isLeftDrawerOpen = false;
            }
            this.isToggleTopDrawerPending = false;
            this.isToggleRightDrawerPending = true;
            this.isToggleBottomDrawerPending = false;
            this.isToggleLeftDrawerPending = false;
            this.invalidate(INVALIDATION_FLAG_SELECTED);
            return;
        }

        public function toggleBottomDrawer(arg1:Number=NaN):void
        {
            if (!this._bottomDrawer || this.isBottomDrawerDocked) 
            {
                return;
            }
            this.pendingToggleDuration = arg1;
            if (this.isToggleBottomDrawerPending) 
            {
                return;
            }
            if (!this.isBottomDrawerOpen) 
            {
                this.isTopDrawerOpen = false;
                this.isRightDrawerOpen = false;
                this.isLeftDrawerOpen = false;
            }
            this.isToggleTopDrawerPending = false;
            this.isToggleRightDrawerPending = false;
            this.isToggleBottomDrawerPending = true;
            this.isToggleLeftDrawerPending = false;
            this.invalidate(INVALIDATION_FLAG_SELECTED);
            return;
        }

        public function toggleLeftDrawer(arg1:Number=NaN):void
        {
            if (!this._leftDrawer || this.isLeftDrawerDocked) 
            {
                return;
            }
            this.pendingToggleDuration = arg1;
            if (this.isToggleLeftDrawerPending) 
            {
                return;
            }
            if (!this.isLeftDrawerOpen) 
            {
                this.isTopDrawerOpen = false;
                this.isRightDrawerOpen = false;
                this.isBottomDrawerOpen = false;
            }
            this.isToggleTopDrawerPending = false;
            this.isToggleRightDrawerPending = false;
            this.isToggleBottomDrawerPending = false;
            this.isToggleLeftDrawerPending = true;
            this.invalidate(INVALIDATION_FLAG_SELECTED);
            return;
        }

        protected override function draw():void
        {
            var loc1:*=this.isInvalid(INVALIDATION_FLAG_SIZE);
            var loc2:*=this.isInvalid(INVALIDATION_FLAG_DATA);
            var loc3:*=this.isInvalid(INVALIDATION_FLAG_LAYOUT);
            var loc4:*=this.isInvalid(INVALIDATION_FLAG_SELECTED);
            if (loc2) 
            {
                this.refreshCurrentEventTarget();
            }
            if (loc1 || loc3) 
            {
                this.refreshDrawerStates();
            }
            if (loc1 || loc3 || loc4) 
            {
                this.refreshOverlayState();
            }
            loc1 = this.autoSizeIfNeeded() || loc1;
            this.layoutChildren();
            this.handlePendingActions();
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
            var loc5:*=this._autoSizeMode === feathers.controls.AutoSizeMode.CONTENT || !this.stage;
            var loc6:*=this.isTopDrawerDocked;
            var loc7:*=this.isRightDrawerDocked;
            var loc8:*=this.isBottomDrawerDocked;
            var loc9:*=this.isLeftDrawerDocked;
            if (loc5) 
            {
                if (this._content) 
                {
                    this._content.validate();
                    if (this._originalContentWidth !== this._originalContentWidth) 
                    {
                        this._originalContentWidth = this._content.width;
                    }
                    if (this._originalContentHeight !== this._originalContentHeight) 
                    {
                        this._originalContentHeight = this._content.height;
                    }
                }
                if (loc6) 
                {
                    this._topDrawer.validate();
                    if (this._originalTopDrawerWidth !== this._originalTopDrawerWidth) 
                    {
                        this._originalTopDrawerWidth = this._topDrawer.width;
                    }
                    if (this._originalTopDrawerHeight !== this._originalTopDrawerHeight) 
                    {
                        this._originalTopDrawerHeight = this._topDrawer.height;
                    }
                }
                if (loc7) 
                {
                    this._rightDrawer.validate();
                    if (this._originalRightDrawerWidth !== this._originalRightDrawerWidth) 
                    {
                        this._originalRightDrawerWidth = this._rightDrawer.width;
                    }
                    if (this._originalRightDrawerHeight !== this._originalRightDrawerHeight) 
                    {
                        this._originalRightDrawerHeight = this._rightDrawer.height;
                    }
                }
                if (loc8) 
                {
                    this._bottomDrawer.validate();
                    if (this._originalBottomDrawerWidth !== this._originalBottomDrawerWidth) 
                    {
                        this._originalBottomDrawerWidth = this._bottomDrawer.width;
                    }
                    if (this._originalBottomDrawerHeight !== this._originalBottomDrawerHeight) 
                    {
                        this._originalBottomDrawerHeight = this._bottomDrawer.height;
                    }
                }
                if (loc9) 
                {
                    this._leftDrawer.validate();
                    if (this._originalLeftDrawerWidth !== this._originalLeftDrawerWidth) 
                    {
                        this._originalLeftDrawerWidth = this._leftDrawer.width;
                    }
                    if (this._originalLeftDrawerHeight !== this._originalLeftDrawerHeight) 
                    {
                        this._originalLeftDrawerHeight = this._leftDrawer.height;
                    }
                }
            }
            var loc10:*=this._explicitWidth;
            if (loc1) 
            {
                if (loc5) 
                {
                    if (this._content) 
                    {
                        loc10 = this._originalContentWidth;
                    }
                    else 
                    {
                        loc10 = 0;
                    }
                    if (loc9) 
                    {
                        loc10 = loc10 + this._originalLeftDrawerWidth;
                    }
                    if (loc7) 
                    {
                        loc10 = loc10 + this._originalRightDrawerWidth;
                    }
                    if (loc6 && this._originalTopDrawerWidth > loc10) 
                    {
                        loc10 = this._originalTopDrawerWidth;
                    }
                    if (loc8 && this._originalBottomDrawerWidth > loc10) 
                    {
                        loc10 = this._originalBottomDrawerWidth;
                    }
                }
                else 
                {
                    loc10 = this.stage.stageWidth;
                }
            }
            var loc11:*=this._explicitHeight;
            if (loc2) 
            {
                if (loc5) 
                {
                    if (this._content) 
                    {
                        loc11 = this._originalContentHeight;
                    }
                    else 
                    {
                        loc11 = 0;
                    }
                    if (loc6) 
                    {
                        loc11 = loc11 + this._originalTopDrawerHeight;
                    }
                    if (loc8) 
                    {
                        loc11 = loc11 + this._originalBottomDrawerHeight;
                    }
                    if (loc9 && this._originalLeftDrawerHeight > loc11) 
                    {
                        loc11 = this._originalLeftDrawerHeight;
                    }
                    if (loc7 && this._originalRightDrawerHeight > loc11) 
                    {
                        loc11 = this._originalRightDrawerHeight;
                    }
                }
                else 
                {
                    loc11 = this.stage.stageHeight;
                }
            }
            var loc12:*=this._explicitMinWidth;
            if (loc3) 
            {
                if (loc5) 
                {
                    loc12 = this._content.minWidth;
                    if (loc9) 
                    {
                        loc12 = loc12 + this._leftDrawer.minWidth;
                    }
                    if (loc7) 
                    {
                        loc12 = loc12 + this._rightDrawer.minWidth;
                    }
                    if (loc6 && this._topDrawer.minWidth > loc12) 
                    {
                        loc12 = this._topDrawer.minWidth;
                    }
                    if (loc8 && this._bottomDrawer.minWidth > loc12) 
                    {
                        loc12 = this._bottomDrawer.minWidth;
                    }
                }
                else 
                {
                    loc12 = this.stage.stageWidth;
                }
            }
            var loc13:*=this._explicitMinHeight;
            if (loc4) 
            {
                if (loc5) 
                {
                    loc13 = this._content.minHeight;
                    if (loc6) 
                    {
                        loc13 = loc13 + this._topDrawer.minHeight;
                    }
                    if (loc8) 
                    {
                        loc13 = loc13 + this._bottomDrawer.minHeight;
                    }
                    if (loc9 && this._leftDrawer.minHeight > loc13) 
                    {
                        loc13 = this._leftDrawer.minHeight;
                    }
                    if (loc7 && this._rightDrawer.minHeight > loc13) 
                    {
                        loc13 = this._rightDrawer.minHeight;
                    }
                }
                else 
                {
                    loc13 = this.stage.stageHeight;
                }
            }
            return this.saveMeasurements(loc10, loc11, loc12, loc13);
        }

        protected function layoutChildren():void
        {
            var loc17:*=NaN;
            var loc18:*=NaN;
            var loc19:*=NaN;
            var loc20:*=NaN;
            var loc21:*=NaN;
            var loc22:*=NaN;
            var loc23:*=NaN;
            var loc24:*=NaN;
            var loc1:*=this.isTopDrawerOpen;
            var loc2:*=this.isRightDrawerOpen;
            var loc3:*=this.isBottomDrawerOpen;
            var loc4:*=this.isLeftDrawerOpen;
            var loc5:*=this.isTopDrawerDocked;
            var loc6:*=this.isRightDrawerDocked;
            var loc7:*=this.isBottomDrawerDocked;
            var loc8:*=this.isLeftDrawerDocked;
            var loc9:*=0;
            var loc10:*=0;
            if (this._topDrawer !== null) 
            {
                this._topDrawer.width = this.actualWidth;
                this._topDrawer.validate();
                loc9 = this._topDrawer.height;
                if (this._topDrawerDivider !== null) 
                {
                    this._topDrawerDivider.width = this._topDrawer.width;
                    if (this._topDrawerDivider is feathers.core.IValidating) 
                    {
                        feathers.core.IValidating(this._topDrawerDivider).validate();
                    }
                }
            }
            if (this._bottomDrawer !== null) 
            {
                this._bottomDrawer.width = this.actualWidth;
                this._bottomDrawer.validate();
                loc10 = this._bottomDrawer.height;
                if (this._bottomDrawerDivider !== null) 
                {
                    this._bottomDrawerDivider.width = this._bottomDrawer.width;
                    if (this._bottomDrawerDivider is feathers.core.IValidating) 
                    {
                        feathers.core.IValidating(this._bottomDrawerDivider).validate();
                    }
                }
            }
            var loc11:*=this.actualHeight;
            if (loc5) 
            {
                loc11 = loc11 - loc9;
                if (this._topDrawerDivider !== null) 
                {
                    loc11 = loc11 - this._topDrawerDivider.height;
                }
            }
            if (loc7) 
            {
                loc11 = loc11 - loc10;
                if (this._bottomDrawerDivider !== null) 
                {
                    loc11 = loc11 - this._bottomDrawerDivider.height;
                }
            }
            if (loc11 < 0) 
            {
                loc11 = 0;
            }
            var loc12:*=0;
            var loc13:*=0;
            if (this._rightDrawer !== null) 
            {
                if (loc6) 
                {
                    this._rightDrawer.height = loc11;
                }
                else 
                {
                    this._rightDrawer.height = this.actualHeight;
                }
                this._rightDrawer.validate();
                loc12 = this._rightDrawer.width;
                if (this._rightDrawerDivider !== null) 
                {
                    this._rightDrawerDivider.height = this._rightDrawer.height;
                    if (this._rightDrawerDivider is feathers.core.IValidating) 
                    {
                        feathers.core.IValidating(this._rightDrawerDivider).validate();
                    }
                }
            }
            if (this._leftDrawer !== null) 
            {
                if (loc8) 
                {
                    this._leftDrawer.height = loc11;
                }
                else 
                {
                    this._leftDrawer.height = this.actualHeight;
                }
                this._leftDrawer.validate();
                loc13 = this._leftDrawer.width;
                if (this._leftDrawerDivider !== null) 
                {
                    this._leftDrawerDivider.height = this._leftDrawer.height;
                    if (this._leftDrawerDivider is feathers.core.IValidating) 
                    {
                        feathers.core.IValidating(this._leftDrawerDivider).validate();
                    }
                }
            }
            var loc14:*=this.actualWidth;
            if (loc8) 
            {
                loc14 = loc14 - loc13;
                if (this._leftDrawerDivider !== null) 
                {
                    loc14 = loc14 - this._leftDrawerDivider.width;
                }
            }
            if (loc6) 
            {
                loc14 = loc14 - loc12;
                if (this._rightDrawerDivider !== null) 
                {
                    loc14 = loc14 - this._rightDrawerDivider.width;
                }
            }
            if (loc14 < 0) 
            {
                loc14 = 0;
            }
            var loc15:*=0;
            if (loc2 && this._openMode === feathers.layout.RelativeDepth.BELOW) 
            {
                loc15 = -loc12;
                if (loc8) 
                {
                    loc15 = loc15 + loc13;
                    if (this._leftDrawerDivider) 
                    {
                        loc15 = loc15 + this._leftDrawerDivider.width;
                    }
                }
            }
            else if (loc4 && this._openMode === feathers.layout.RelativeDepth.BELOW || loc8) 
            {
                loc15 = loc13;
                if (this._leftDrawerDivider && loc8) 
                {
                    loc15 = loc15 + this._leftDrawerDivider.width;
                }
            }
            this._content.x = loc15;
            var loc16:*=0;
            if (loc3 && this._openMode === feathers.layout.RelativeDepth.BELOW) 
            {
                loc16 = -loc10;
                if (loc5) 
                {
                    loc16 = loc16 + loc9;
                    if (this._topDrawerDivider) 
                    {
                        loc16 = loc16 + this._topDrawerDivider.height;
                    }
                }
            }
            else if (loc1 && this._openMode === feathers.layout.RelativeDepth.BELOW || loc5) 
            {
                loc16 = loc9;
                if (this._topDrawerDivider && loc5) 
                {
                    loc16 = loc16 + this._topDrawerDivider.height;
                }
            }
            this._content.y = loc16;
            if (this._autoSizeMode !== feathers.controls.AutoSizeMode.CONTENT) 
            {
                this._content.width = loc14;
                this._content.height = loc11;
                this._content.validate();
            }
            if (this._topDrawer !== null) 
            {
                loc17 = 0;
                loc18 = 0;
                if (loc5) 
                {
                    if (loc3 && this._openMode === feathers.layout.RelativeDepth.BELOW) 
                    {
                        loc18 = loc18 - loc10;
                    }
                    if (!loc8) 
                    {
                        loc17 = this._content.x;
                    }
                }
                else if (this._openMode === feathers.layout.RelativeDepth.ABOVE && !this._isTopDrawerOpen) 
                {
                    loc18 = loc18 - loc9;
                }
                this._topDrawer.x = loc17;
                this._topDrawer.y = loc18;
                this._topDrawer.visible = loc1 || loc5 || this._isDraggingTopDrawer;
                if (this._topDrawerDivider !== null) 
                {
                    this._topDrawerDivider.visible = loc5;
                    this._topDrawerDivider.x = loc17;
                    this._topDrawerDivider.y = loc18 + loc9;
                }
                this._topDrawer.validate();
            }
            if (this._rightDrawer !== null) 
            {
                loc19 = this.actualWidth - loc12;
                loc20 = 0;
                if (loc6) 
                {
                    loc19 = this._content.x + this._content.width;
                    if (this._rightDrawerDivider) 
                    {
                        loc19 = loc19 + this._rightDrawerDivider.width;
                    }
                    loc20 = this._content.y;
                }
                else if (this._openMode === feathers.layout.RelativeDepth.ABOVE && !this._isRightDrawerOpen) 
                {
                    loc19 = loc19 + loc12;
                }
                this._rightDrawer.x = loc19;
                this._rightDrawer.y = loc20;
                this._rightDrawer.visible = loc2 || loc6 || this._isDraggingRightDrawer;
                if (this._rightDrawerDivider !== null) 
                {
                    this._rightDrawerDivider.visible = loc6;
                    this._rightDrawerDivider.x = loc19 - this._rightDrawerDivider.width;
                    this._rightDrawerDivider.y = loc20;
                }
                this._rightDrawer.validate();
            }
            if (this._bottomDrawer !== null) 
            {
                loc21 = 0;
                loc22 = this.actualHeight - loc10;
                if (loc7) 
                {
                    if (!loc8) 
                    {
                        loc21 = this._content.x;
                    }
                    loc22 = this._content.y + this._content.height;
                    if (this._bottomDrawerDivider) 
                    {
                        loc22 = loc22 + this._bottomDrawerDivider.height;
                    }
                }
                else if (this._openMode === feathers.layout.RelativeDepth.ABOVE && !this._isBottomDrawerOpen) 
                {
                    loc22 = loc22 + loc10;
                }
                this._bottomDrawer.x = loc21;
                this._bottomDrawer.y = loc22;
                this._bottomDrawer.visible = loc3 || loc7 || this._isDraggingBottomDrawer;
                if (this._bottomDrawerDivider !== null) 
                {
                    this._bottomDrawerDivider.visible = loc7;
                    this._bottomDrawerDivider.x = loc21;
                    this._bottomDrawerDivider.y = loc22 - this._bottomDrawerDivider.height;
                }
                this._bottomDrawer.validate();
            }
            if (this._leftDrawer !== null) 
            {
                loc23 = 0;
                loc24 = 0;
                if (loc8) 
                {
                    if (loc2 && this._openMode === feathers.layout.RelativeDepth.BELOW) 
                    {
                        loc23 = loc23 - loc12;
                    }
                    loc24 = this._content.y;
                }
                else if (this._openMode === feathers.layout.RelativeDepth.ABOVE && !this._isLeftDrawerOpen) 
                {
                    loc23 = loc23 - loc13;
                }
                this._leftDrawer.x = loc23;
                this._leftDrawer.y = loc24;
                this._leftDrawer.visible = loc4 || loc8 || this._isDraggingLeftDrawer;
                if (this._leftDrawerDivider !== null) 
                {
                    this._leftDrawerDivider.visible = loc8;
                    this._leftDrawerDivider.x = loc23 + loc13;
                    this._leftDrawerDivider.y = loc24;
                }
                this._leftDrawer.validate();
            }
            if (this._overlaySkin !== null) 
            {
                this.positionOverlaySkin();
                this._overlaySkin.width = this.actualWidth;
                this._overlaySkin.height = this.actualHeight;
                if (this._overlaySkin is feathers.core.IValidating) 
                {
                    feathers.core.IValidating(this._overlaySkin).validate();
                }
            }
            return;
        }

        protected function handlePendingActions():void
        {
            if (this.isToggleTopDrawerPending) 
            {
                this._isTopDrawerOpen = !this._isTopDrawerOpen;
                this.isToggleTopDrawerPending = false;
                this.openOrCloseTopDrawer();
            }
            else if (this.isToggleRightDrawerPending) 
            {
                this._isRightDrawerOpen = !this._isRightDrawerOpen;
                this.isToggleRightDrawerPending = false;
                this.openOrCloseRightDrawer();
            }
            else if (this.isToggleBottomDrawerPending) 
            {
                this._isBottomDrawerOpen = !this._isBottomDrawerOpen;
                this.isToggleBottomDrawerPending = false;
                this.openOrCloseBottomDrawer();
            }
            else if (this.isToggleLeftDrawerPending) 
            {
                this._isLeftDrawerOpen = !this._isLeftDrawerOpen;
                this.isToggleLeftDrawerPending = false;
                this.openOrCloseLeftDrawer();
            }
            return;
        }

        protected function openOrCloseTopDrawer():void
        {
            if (!this._topDrawer || this.isTopDrawerDocked) 
            {
                return;
            }
            if (this._openOrCloseTween) 
            {
                this._openOrCloseTween.advanceTime(this._openOrCloseTween.totalTime);
                starling.core.Starling.juggler.remove(this._openOrCloseTween);
                this._openOrCloseTween = null;
            }
            this.prepareTopDrawer();
            if (this._overlaySkin) 
            {
                this._overlaySkin.visible = true;
                if (this._isTopDrawerOpen) 
                {
                    this._overlaySkin.alpha = 0;
                }
                else 
                {
                    this._overlaySkin.alpha = this._overlaySkinOriginalAlpha;
                }
            }
            var loc1:*=this._isTopDrawerOpen ? this._topDrawer.height : 0;
            var loc2:*=this.pendingToggleDuration;
            if (loc2 !== loc2) 
            {
                loc2 = this._openOrCloseDuration;
            }
            this.pendingToggleDuration = NaN;
            if (this._openMode !== feathers.layout.RelativeDepth.ABOVE) 
            {
                this._openOrCloseTween = new starling.animation.Tween(this._content, loc2, this._openOrCloseEase);
            }
            else 
            {
                loc1 = loc1 !== 0 ? 0 : -this._topDrawer.height;
                this._openOrCloseTween = new starling.animation.Tween(this._topDrawer, loc2, this._openOrCloseEase);
            }
            this._openOrCloseTween.animate("y", loc1);
            this._openOrCloseTween.onUpdate = this.topDrawerOpenOrCloseTween_onUpdate;
            this._openOrCloseTween.onComplete = this.topDrawerOpenOrCloseTween_onComplete;
            starling.core.Starling.juggler.add(this._openOrCloseTween);
            return;
        }

        public static const AUTO_SIZE_MODE_STAGE:String="stage";

        public static const DOCK_MODE_PORTRAIT:String="portrait";

        public static const DOCK_MODE_LANDSCAPE:String="landscape";

        public static const DOCK_MODE_BOTH:String="both";

        public static const DOCK_MODE_NONE:String="none";

        public static const OPEN_MODE_ABOVE:String="overlay";

        public static const OPEN_MODE_BELOW:String="below";

        public static const AUTO_SIZE_MODE_CONTENT:String="content";

        public static const OPEN_GESTURE_DRAG_CONTENT_EDGE:String="dragContentEdge";

        public static const OPEN_GESTURE_DRAG_CONTENT:String="dragContent";

        public static const OPEN_GESTURE_NONE:String="none";

        protected static const SCREEN_NAVIGATOR_CONTENT_EVENT_DISPATCHER_FIELD:String="activeScreen";

        internal static const CURRENT_VELOCITY_WEIGHT:Number=2.33;

        internal static const VELOCITY_WEIGHTS:__AS3__.vec.Vector.<Number>=new Vector.<Number>(4);

        internal static const MAXIMUM_SAVED_VELOCITY_COUNT:int=4;

        internal static const HELPER_POINT:flash.geom.Point=new flash.geom.Point();

        protected var _rightDrawerDockMode:String="none";

        protected var _rightDrawerToggleEventType:String;

        protected var _isRightDrawerOpen:Boolean=false;

        protected var _originalBottomDrawerWidth:Number=NaN;

        protected var _originalBottomDrawerHeight:Number=NaN;

        protected var _bottomDrawer:feathers.core.IFeathersControl;

        protected var _isTopDrawerOpen:Boolean=false;

        protected var _bottomDrawerDivider:starling.display.DisplayObject;

        protected var _bottomDrawerDockMode:String="none";

        protected var _bottomDrawerToggleEventType:String;

        protected var _isBottomDrawerOpen:Boolean=false;

        protected var _originalLeftDrawerWidth:Number=NaN;

        protected var _originalLeftDrawerHeight:Number=NaN;

        protected var _leftDrawer:feathers.core.IFeathersControl;

        protected var _leftDrawerDivider:starling.display.DisplayObject;

        protected var _leftDrawerDockMode:String="none";

        protected var _leftDrawerToggleEventType:String;

        protected var _autoSizeMode:String="stage";

        protected var _clipDrawers:Boolean=true;

        protected var _openMode:String="below";

        protected var _openGesture:String="edge";

        protected var _minimumDragDistance:Number=0.04;

        protected var _minimumDrawerThrowVelocity:Number=5;

        protected var _openGestureEdgeSize:Number=0.1;

        protected var _contentEventDispatcherChangeEventType:String;

        protected var _velocityY:Number=0;

        protected var _previousVelocityX:__AS3__.vec.Vector.<Number>;

        protected var _previousVelocityY:__AS3__.vec.Vector.<Number>;

        protected var _contentEventDispatcherField:String;

        protected var _contentEventDispatcherFunction:Function;

        protected var _openOrCloseEase:Object="easeOut";

        protected var _openOrCloseTween:starling.animation.Tween;

        protected var _openOrCloseDuration:Number=0.25;

        protected var isToggleTopDrawerPending:Boolean=false;

        protected var isToggleRightDrawerPending:Boolean=false;

        protected var isToggleBottomDrawerPending:Boolean=false;

        protected var isToggleLeftDrawerPending:Boolean=false;

        protected var pendingToggleDuration:Number;

        protected var touchPointID:int=-1;

        protected var _isDragging:Boolean=false;

        protected var _isDraggingTopDrawer:Boolean=false;

        protected var _isDraggingRightDrawer:Boolean=false;

        protected var _isDraggingBottomDrawer:Boolean=false;

        protected var _isLeftDrawerOpen:Boolean=false;

        protected var _isDraggingLeftDrawer:Boolean=false;

        protected var _startTouchX:Number;

        protected var _startTouchY:Number;

        protected var _currentTouchX:Number;

        protected var _currentTouchY:Number;

        protected var contentEventDispatcher:starling.events.EventDispatcher;

        protected var _previousTouchX:Number;

        protected var _previousTouchY:Number;

        public static var globalStyleProvider:feathers.skins.IStyleProvider;

        protected var _originalContentWidth:Number=NaN;

        protected var _originalContentHeight:Number=NaN;

        protected var _content:feathers.core.IFeathersControl;

        protected var _overlaySkinOriginalAlpha:Number=1;

        protected var _overlaySkin:starling.display.DisplayObject;

        protected var _originalTopDrawerWidth:Number=NaN;

        protected var _previousTouchTime:int;

        protected var _originalTopDrawerHeight:Number=NaN;

        protected var _topDrawer:feathers.core.IFeathersControl;

        protected var _topDrawerDivider:starling.display.DisplayObject;

        protected var _topDrawerDockMode:String="none";

        protected var _topDrawerToggleEventType:String;

        protected var _originalRightDrawerWidth:Number=NaN;

        protected var _originalRightDrawerHeight:Number=NaN;

        protected var _rightDrawer:feathers.core.IFeathersControl;

        protected var _rightDrawerDivider:starling.display.DisplayObject;

        protected var _velocityX:Number=0;
    }
}


