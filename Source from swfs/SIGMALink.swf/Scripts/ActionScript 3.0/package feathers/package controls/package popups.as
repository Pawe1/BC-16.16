//package popups
//  class BottomDrawerPopUpContentManager
package feathers.controls.popups 
{
    import __AS3__.vec.*;
    import feathers.controls.*;
    import feathers.core.*;
    import feathers.layout.*;
    import feathers.utils.display.*;
    import flash.errors.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.ui.*;
    import starling.animation.*;
    import starling.core.*;
    import starling.display.*;
    import starling.events.*;
    import starling.utils.*;
    
    public class BottomDrawerPopUpContentManager extends starling.events.EventDispatcher implements feathers.controls.popups.IPersistentPopUpContentManager, feathers.controls.popups.IPopUpContentManagerWithPrompt
    {
        public function BottomDrawerPopUpContentManager()
        {
            super();
            return;
        }

        protected function layout():void
        {
            this.panel.width = this.panel.stage.stageWidth;
            this.panel.x = 0;
            this.panel.maxHeight = this.panel.stage.stageHeight;
            this.panel.validate();
            this.panel.y = this.panel.stage.stageHeight - this.panel.height;
            return;
        }

        protected function cleanup():void
        {
            var loc1:*=starling.core.Starling.current.stage;
            loc1.removeEventListener(starling.events.TouchEvent.TOUCH, this.stage_touchHandler);
            loc1.removeEventListener(starling.events.ResizeEvent.RESIZE, this.stage_resizeHandler);
            starling.core.Starling.current.nativeStage.removeEventListener(flash.events.KeyboardEvent.KEY_DOWN, this.nativeStage_keyDownHandler);
            if (this.panel) 
            {
                this.panel.removeEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.panel_removedFromStageHandler);
                if (this.panel.contains(this.content)) 
                {
                    this.panel.removeChild(this.content, false);
                }
                this.panel.removeFromParent(true);
                this.panel = null;
            }
            this.content = null;
            return;
        }

        protected function openTween_onComplete():void
        {
            this.openTween = null;
            this.panel.touchable = true;
            this.dispatchEventWith(starling.events.Event.OPEN);
            return;
        }

        public function get isOpen():Boolean
        {
            return !(this.content === null);
        }

        protected function closeTween_onComplete():void
        {
            this.isClosing = false;
            this.closeTween = null;
            this.cleanup();
            this.dispatchEventWith(starling.events.Event.CLOSE);
            return;
        }

        protected function closeButton_triggeredHandler(arg1:starling.events.Event):void
        {
            this.close();
            return;
        }

        public function get prompt():String
        {
            return this._prompt;
        }

        public function set prompt(arg1:String):void
        {
            this._prompt = arg1;
            return;
        }

        protected function panel_removedFromStageHandler(arg1:starling.events.Event):void
        {
            this.close();
            return;
        }

        public function get closeButtonLabel():String
        {
            return this._closeButtonLabel;
        }

        public function set closeButtonLabel(arg1:String):void
        {
            this._closeButtonLabel = arg1;
            return;
        }

        protected function nativeStage_keyDownHandler(arg1:flash.events.KeyboardEvent):void
        {
            if (arg1.isDefaultPrevented()) 
            {
                return;
            }
            if (!(arg1.keyCode == flash.ui.Keyboard.BACK) && !(arg1.keyCode == flash.ui.Keyboard.ESCAPE)) 
            {
                return;
            }
            arg1.preventDefault();
            this.close();
            return;
        }

        public function get openOrCloseDuration():Number
        {
            return this._openOrCloseDuration;
        }

        public function set openOrCloseDuration(arg1:Number):void
        {
            this._openOrCloseDuration = arg1;
            return;
        }

        protected function stage_resizeHandler(arg1:starling.events.ResizeEvent):void
        {
            if (this.closeTween) 
            {
                this.closeTween.advanceTime(this.closeTween.totalTime);
                return;
            }
            if (this.openTween) 
            {
                starling.core.Starling.juggler.remove(this.openTween);
                this.openTween = null;
            }
            this.layout();
            return;
        }

        public function get openOrCloseEase():Object
        {
            return this._openOrCloseEase;
        }

        public function set openOrCloseEase(arg1:Object):void
        {
            this._openOrCloseEase = arg1;
            return;
        }

        protected function stage_touchHandler(arg1:starling.events.TouchEvent):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            if (!feathers.core.PopUpManager.isTopLevelPopUp(this.panel)) 
            {
                return;
            }
            var loc1:*=starling.core.Starling.current.stage;
            if (this.touchPointID >= 0) 
            {
                loc2 = arg1.getTouch(loc1, starling.events.TouchPhase.ENDED, this.touchPointID);
                if (!loc2) 
                {
                    return;
                }
                loc3 = starling.utils.Pool.getPoint();
                loc2.getLocation(loc1, loc3);
                loc4 = loc1.hitTest(loc3);
                starling.utils.Pool.putPoint(loc3);
                if (!this.panel.contains(loc4)) 
                {
                    this.touchPointID = -1;
                    this.close();
                }
            }
            else 
            {
                loc2 = arg1.getTouch(loc1, starling.events.TouchPhase.BEGAN);
                if (!loc2) 
                {
                    return;
                }
                loc3 = starling.utils.Pool.getPoint();
                loc2.getLocation(loc1, loc3);
                loc4 = loc1.hitTest(loc3);
                starling.utils.Pool.putPoint(loc3);
                if (this.panel.contains(loc4)) 
                {
                    return;
                }
                this.touchPointID = loc2.id;
            }
            return;
        }

        public function get overlayFactory():Function
        {
            return this._overlayFactory;
        }

        public function set overlayFactory(arg1:Function):void
        {
            this._overlayFactory = arg1;
            return;
        }

        public function open(arg1:starling.display.DisplayObject, arg2:starling.display.DisplayObject):void
        {
            if (this.isOpen) 
            {
                throw new flash.errors.IllegalOperationError("Pop-up content is already open. Close the previous content before opening new content.");
            }
            this.content = arg1;
            var loc1:*=new feathers.layout.VerticalLayout();
            loc1.horizontalAlign = feathers.layout.HorizontalAlign.JUSTIFY;
            this.panel = new feathers.controls.Panel();
            if (this.customPanelStyleName) 
            {
                this.panel.styleNameList.add(this.customPanelStyleName);
            }
            this.panel.title = this._prompt;
            this.panel.layout = loc1;
            this.panel.headerFactory = this.headerFactory;
            this.panel.touchable = false;
            this.panel.addChild(arg1);
            feathers.core.PopUpManager.addPopUp(this.panel, true, false, this._overlayFactory);
            this.layout();
            this.panel.addEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.panel_removedFromStageHandler);
            var loc2:*=starling.core.Starling.current.stage;
            loc2.addEventListener(starling.events.TouchEvent.TOUCH, this.stage_touchHandler);
            loc2.addEventListener(starling.events.ResizeEvent.RESIZE, this.stage_resizeHandler);
            var loc3:*=-feathers.utils.display.getDisplayObjectDepthFromStage(this.panel);
            starling.core.Starling.current.nativeStage.addEventListener(flash.events.KeyboardEvent.KEY_DOWN, this.nativeStage_keyDownHandler, false, loc3, true);
            this.panel.y = this.panel.stage.stageHeight;
            this.openTween = new starling.animation.Tween(this.panel, this.openOrCloseDuration, this.openOrCloseEase);
            this.openTween.moveTo(0, this.panel.stage.stageHeight - this.panel.height);
            this.openTween.onComplete = this.openTween_onComplete;
            starling.core.Starling.juggler.add(this.openTween);
            return;
        }

        public function close():void
        {
            if (!this.isOpen || this.isClosing) 
            {
                return;
            }
            if (this.openTween) 
            {
                starling.core.Starling.juggler.remove(this.openTween);
                this.openTween = null;
            }
            if (this.content.stage) 
            {
                this.isClosing = true;
                this.panel.touchable = false;
                this.closeTween = new starling.animation.Tween(this.panel, this.openOrCloseDuration, this.openOrCloseEase);
                this.closeTween.moveTo(0, this.panel.stage.stageHeight);
                this.closeTween.onComplete = this.closeTween_onComplete;
                starling.core.Starling.juggler.add(this.closeTween);
            }
            else 
            {
                this.cleanup();
                this.dispatchEventWith(starling.events.Event.CLOSE);
            }
            return;
        }

        public function dispose():void
        {
            this.close();
            return;
        }

        protected function headerFactory():feathers.controls.Header
        {
            var loc1:*=new feathers.controls.Header();
            var loc2:*=new feathers.controls.Button();
            loc2.label = this.closeButtonLabel;
            loc2.addEventListener(starling.events.Event.TRIGGERED, this.closeButton_triggeredHandler);
            new Vector.<starling.display.DisplayObject>(1)[0] = loc2;
            loc1.rightItems = new Vector.<starling.display.DisplayObject>(1);
            return loc1;
        }

        protected var panel:feathers.controls.Panel;

        protected var content:starling.display.DisplayObject;

        protected var isClosing:Boolean=false;

        public var customPanelStyleName:String;

        protected var _prompt:String;

        protected var _closeButtonLabel:String="Done";

        protected var _openOrCloseDuration:Number=0.5;

        protected var _openOrCloseEase:Object="easeOut";

        protected var touchPointID:int=-1;

        protected var openTween:starling.animation.Tween;

        protected var closeTween:starling.animation.Tween;

        protected var _overlayFactory:Function=null;
    }
}


//  class CalloutPopUpContentManager
package feathers.controls.popups 
{
    import feathers.controls.*;
    import flash.errors.*;
    import starling.display.*;
    import starling.events.*;
    
    public class CalloutPopUpContentManager extends starling.events.EventDispatcher implements feathers.controls.popups.IPopUpContentManager
    {
        public function CalloutPopUpContentManager()
        {
            this.direction = feathers.controls.Callout.DIRECTION_ANY;
            super();
            return;
        }

        public function get overlayFactory():Function
        {
            return this._overlayFactory;
        }

        public function set overlayFactory(arg1:Function):void
        {
            this._overlayFactory = arg1;
            return;
        }

        public function get isOpen():Boolean
        {
            return !(this.content === null);
        }

        public function open(arg1:starling.display.DisplayObject, arg2:starling.display.DisplayObject):void
        {
            if (this.isOpen) 
            {
                throw new flash.errors.IllegalOperationError("Pop-up content is already open. Close the previous content before opening new content.");
            }
            this.content = arg1;
            this.callout = feathers.controls.Callout.show(arg1, arg2, this.direction, this.isModal, this.calloutFactory, this._overlayFactory);
            this.callout.addEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.callout_removedFromStageHandler);
            this.dispatchEventWith(starling.events.Event.OPEN);
            return;
        }

        public function close():void
        {
            if (!this.isOpen) 
            {
                return;
            }
            this.callout.close();
            return;
        }

        public function dispose():void
        {
            this.close();
            return;
        }

        protected function cleanup():void
        {
            this.content = null;
            this.callout.content = null;
            this.callout.removeEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.callout_removedFromStageHandler);
            this.callout = null;
            return;
        }

        protected function callout_removedFromStageHandler(arg1:starling.events.Event):void
        {
            this.cleanup();
            this.dispatchEventWith(starling.events.Event.CLOSE);
            return;
        }

        public var calloutFactory:Function;

        public var direction:String;

        public var isModal:Boolean=true;

        protected var _overlayFactory:Function=null;

        protected var content:starling.display.DisplayObject;

        protected var callout:feathers.controls.Callout;
    }
}


//  class DropDownPopUpContentManager
package feathers.controls.popups 
{
    import feathers.core.*;
    import feathers.display.*;
    import feathers.events.*;
    import feathers.layout.*;
    import feathers.utils.display.*;
    import flash.errors.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.ui.*;
    import starling.animation.*;
    import starling.core.*;
    import starling.display.*;
    import starling.events.*;
    import starling.utils.*;
    
    public class DropDownPopUpContentManager extends starling.events.EventDispatcher implements feathers.controls.popups.IPopUpContentManager
    {
        public function DropDownPopUpContentManager()
        {
            super();
            return;
        }

        protected function calculateXPosition(arg1:flash.geom.Rectangle):Number
        {
            var loc1:*=arg1.x;
            var loc2:*=loc1 + arg1.width - this.content.width;
            var loc3:*=this.source.stage.stageWidth - this.content.width;
            var loc4:*=loc1;
            if (loc4 > loc3) 
            {
                if (loc2 >= 0) 
                {
                    loc4 = loc2;
                }
                else 
                {
                    loc4 = loc3;
                }
            }
            if (loc4 < 0) 
            {
                loc4 = 0;
            }
            return loc4;
        }

        protected function openCloseTween_onUpdate():void
        {
            var loc1:*=this._delegate.mask;
            if (this._actualDirection !== feathers.layout.RelativePosition.TOP) 
            {
                loc1.height = this._openCloseTweenTarget.height - (this._openCloseTweenTarget.y - this._delegate.y);
                loc1.y = this._openCloseTweenTarget.height - loc1.height;
            }
            else 
            {
                loc1.height = this._openCloseTweenTarget.height - (this._delegate.y - this._openCloseTweenTarget.y);
                loc1.y = 0;
            }
            return;
        }

        protected function openCloseTween_onComplete():void
        {
            this._openCloseTween = null;
            this._delegate.removeFromParent(true);
            this._delegate = null;
            return;
        }

        protected function openTween_onComplete():void
        {
            this.openCloseTween_onComplete();
            this.content.visible = true;
            return;
        }

        protected function closeTween_onComplete():void
        {
            this.openCloseTween_onComplete();
            this.dispatchEventWith(starling.events.Event.CLOSE);
            return;
        }

        public function get isOpen():Boolean
        {
            return !(this.content === null);
        }

        protected function content_resizeHandler(arg1:starling.events.Event):void
        {
            this.layout();
            return;
        }

        public function get isModal():Boolean
        {
            return this._isModal;
        }

        public function set isModal(arg1:Boolean):void
        {
            this._isModal = arg1;
            return;
        }

        protected function stage_enterFrameHandler(arg1:starling.events.Event):void
        {
            var loc1:*=starling.utils.Pool.getRectangle();
            this.source.getBounds(this.source.stage, loc1);
            if (!(loc1.x === this._lastGlobalX) || !(loc1.y === this._lastGlobalY)) 
            {
                this.layout();
            }
            starling.utils.Pool.putRectangle(loc1);
            return;
        }

        public function get overlayFactory():Function
        {
            return this._overlayFactory;
        }

        public function set overlayFactory(arg1:Function):void
        {
            this._overlayFactory = arg1;
            return;
        }

        protected function content_removedFromStageHandler(arg1:starling.events.Event):void
        {
            this.close();
            return;
        }

        public function get gap():Number
        {
            return this._gap;
        }

        public function set gap(arg1:Number):void
        {
            this._gap = arg1;
            return;
        }

        protected function nativeStage_keyDownHandler(arg1:flash.events.KeyboardEvent):void
        {
            if (arg1.isDefaultPrevented()) 
            {
                return;
            }
            if (!(arg1.keyCode == flash.ui.Keyboard.BACK) && !(arg1.keyCode == flash.ui.Keyboard.ESCAPE)) 
            {
                return;
            }
            arg1.preventDefault();
            this.close();
            return;
        }

        public function get openCloseDuration():Number
        {
            return this._openCloseDuration;
        }

        public function set openCloseDuration(arg1:Number):void
        {
            this._openCloseDuration = arg1;
            return;
        }

        public function set primaryDirection(arg1:String):void
        {
            if (arg1 !== PRIMARY_DIRECTION_UP) 
            {
                if (arg1 === PRIMARY_DIRECTION_DOWN) 
                {
                    arg1 = feathers.layout.RelativePosition.BOTTOM;
                }
            }
            else 
            {
                arg1 = feathers.layout.RelativePosition.TOP;
            }
            this._primaryDirection = arg1;
            return;
        }

        public function get openCloseEase():Object
        {
            return this._openCloseEase;
        }

        public function set openCloseEase(arg1:Object):void
        {
            this._openCloseEase = arg1;
            return;
        }

        protected function stage_resizeHandler(arg1:starling.events.ResizeEvent):void
        {
            this.layout();
            return;
        }

        protected function stage_touchHandler(arg1:starling.events.TouchEvent):void
        {
            var loc1:*=starling.display.DisplayObject(arg1.target);
            if (this.content == loc1 || this.content is starling.display.DisplayObjectContainer && starling.display.DisplayObjectContainer(this.content).contains(loc1)) 
            {
                return;
            }
            if (this.source == loc1 || this.source is starling.display.DisplayObjectContainer && starling.display.DisplayObjectContainer(this.source).contains(loc1)) 
            {
                return;
            }
            if (!feathers.core.PopUpManager.isTopLevelPopUp(this.content)) 
            {
                return;
            }
            var loc2:*=starling.display.Stage(arg1.currentTarget);
            var loc3:*=arg1.getTouch(loc2, starling.events.TouchPhase.BEGAN);
            if (!loc3) 
            {
                return;
            }
            this.close();
            return;
        }

        public function get primaryDirection():String
        {
            return this._primaryDirection;
        }

        public function open(arg1:starling.display.DisplayObject, arg2:starling.display.DisplayObject):void
        {
            var loc3:*=null;
            if (this.isOpen) 
            {
                throw new flash.errors.IllegalOperationError("Pop-up content is already open. Close the previous content before opening new content.");
            }
            this.content = arg1;
            this.source = arg2;
            feathers.core.PopUpManager.addPopUp(arg1, this._isModal, false, this._overlayFactory);
            if (arg1 is feathers.core.IFeathersControl) 
            {
                arg1.addEventListener(feathers.events.FeathersEventType.RESIZE, this.content_resizeHandler);
            }
            arg1.addEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.content_removedFromStageHandler);
            this.layout();
            if (this._openCloseTween !== null) 
            {
                this._openCloseTween.advanceTime(this._openCloseTween.totalTime);
            }
            if (this._openCloseDuration > 0) 
            {
                this._delegate = new feathers.display.RenderDelegate(arg1);
                arg1.visible = false;
                feathers.core.PopUpManager.addPopUp(this._delegate, false, false);
                this._delegate.x = arg1.x;
                if (this._actualDirection !== feathers.layout.RelativePosition.TOP) 
                {
                    this._delegate.y = arg1.y - arg1.height;
                }
                else 
                {
                    this._delegate.y = arg1.y + arg1.height;
                }
                loc3 = new starling.display.Quad(arg1.width, arg1.height, 16711935);
                this._delegate.mask = loc3;
                loc3.height = 0;
                this._openCloseTween = new starling.animation.Tween(this._delegate, this._openCloseDuration, this._openCloseEase);
                this._openCloseTweenTarget = arg1;
                this._openCloseTween.animate("y", arg1.y);
                this._openCloseTween.onUpdate = this.openCloseTween_onUpdate;
                this._openCloseTween.onComplete = this.openTween_onComplete;
                starling.core.Starling.juggler.add(this._openCloseTween);
            }
            var loc1:*=this.source.stage;
            loc1.addEventListener(starling.events.TouchEvent.TOUCH, this.stage_touchHandler);
            loc1.addEventListener(starling.events.ResizeEvent.RESIZE, this.stage_resizeHandler);
            loc1.addEventListener(starling.events.Event.ENTER_FRAME, this.stage_enterFrameHandler);
            var loc2:*=-feathers.utils.display.getDisplayObjectDepthFromStage(this.content);
            starling.core.Starling.current.nativeStage.addEventListener(flash.events.KeyboardEvent.KEY_DOWN, this.nativeStage_keyDownHandler, false, loc2, true);
            this.dispatchEventWith(starling.events.Event.OPEN);
            return;
        }

        public function get fitContentMinWidthToOrigin():Boolean
        {
            return this._fitContentMinWidthToOrigin;
        }

        public function set fitContentMinWidthToOrigin(arg1:Boolean):void
        {
            this._fitContentMinWidthToOrigin = arg1;
            return;
        }

        public function close():void
        {
            var loc4:*=null;
            if (!this.isOpen) 
            {
                return;
            }
            if (this._openCloseTween !== null) 
            {
                this._openCloseTween.advanceTime(this._openCloseTween.totalTime);
            }
            var loc1:*=this.content;
            this.source = null;
            this.content = null;
            var loc2:*=loc1.stage;
            loc2.removeEventListener(starling.events.TouchEvent.TOUCH, this.stage_touchHandler);
            loc2.removeEventListener(starling.events.ResizeEvent.RESIZE, this.stage_resizeHandler);
            loc2.removeEventListener(starling.events.Event.ENTER_FRAME, this.stage_enterFrameHandler);
            var loc3:*=feathers.utils.display.stageToStarling(loc2);
            loc3.nativeStage.removeEventListener(flash.events.KeyboardEvent.KEY_DOWN, this.nativeStage_keyDownHandler);
            if (loc1 is feathers.core.IFeathersControl) 
            {
                loc1.removeEventListener(feathers.events.FeathersEventType.RESIZE, this.content_resizeHandler);
            }
            loc1.removeEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.content_removedFromStageHandler);
            if (loc1.parent) 
            {
                loc1.removeFromParent(false);
            }
            if (this._openCloseDuration > 0) 
            {
                this._delegate = new feathers.display.RenderDelegate(loc1);
                feathers.core.PopUpManager.addPopUp(this._delegate, false, false);
                this._delegate.x = loc1.x;
                this._delegate.y = loc1.y;
                loc4 = new starling.display.Quad(1, 1, 16711935);
                loc4.width = loc1.width;
                loc4.height = loc1.height;
                this._delegate.mask = loc4;
                this._openCloseTween = new starling.animation.Tween(this._delegate, this._openCloseDuration, this._openCloseEase);
                this._openCloseTweenTarget = loc1;
                if (this._actualDirection !== feathers.layout.RelativePosition.TOP) 
                {
                    this._openCloseTween.animate("y", loc1.y - loc1.height);
                }
                else 
                {
                    this._openCloseTween.animate("y", loc1.y + loc1.height);
                }
                this._openCloseTween.onUpdate = this.openCloseTween_onUpdate;
                this._openCloseTween.onComplete = this.closeTween_onComplete;
                starling.core.Starling.juggler.add(this._openCloseTween);
            }
            else 
            {
                this.dispatchEventWith(starling.events.Event.CLOSE);
            }
            return;
        }

        public function dispose():void
        {
            this.openCloseDuration = 0;
            this.close();
            return;
        }

        protected function layout():void
        {
            if (this.source is feathers.core.IValidating) 
            {
                feathers.core.IValidating(this.source).validate();
                if (!this.isOpen) 
                {
                    return;
                }
            }
            var loc1:*=this.source.width;
            var loc2:*=false;
            var loc3:*=this.content as feathers.core.IFeathersControl;
            if (this._fitContentMinWidthToOrigin && loc3 && loc3.minWidth < loc1) 
            {
                loc3.minWidth = loc1;
                loc2 = true;
            }
            if (this.content is feathers.core.IValidating) 
            {
                loc3.validate();
            }
            if (!loc2 && this._fitContentMinWidthToOrigin && this.content.width < loc1) 
            {
                this.content.width = loc1;
            }
            var loc4:*=this.source.stage;
            var loc5:*=feathers.utils.display.stageToStarling(loc4);
            var loc6:*=feathers.core.ValidationQueue.forStarling(loc5);
            if (loc6 && !loc6.isValidating) 
            {
                loc6.advanceTime(0);
            }
            var loc7:*=this.source.getBounds(loc4);
            this._lastGlobalX = loc7.x;
            this._lastGlobalY = loc7.y;
            var loc8:*=loc4.stageHeight - this.content.height - (loc7.y + loc7.height + this._gap);
            if (this._primaryDirection == feathers.layout.RelativePosition.BOTTOM && loc8 >= 0) 
            {
                this.layoutBelow(loc7);
                return;
            }
            var loc9:*=loc7.y - this._gap - this.content.height;
            if (loc9 >= 0) 
            {
                this.layoutAbove(loc7);
                return;
            }
            if (this._primaryDirection == feathers.layout.RelativePosition.TOP && loc8 >= 0) 
            {
                this.layoutBelow(loc7);
                return;
            }
            if (loc9 >= loc8) 
            {
                this.layoutAbove(loc7);
            }
            else 
            {
                this.layoutBelow(loc7);
            }
            var loc10:*=loc4.stageHeight - (loc7.y + loc7.height);
            if (loc3) 
            {
                if (loc3.maxHeight > loc10) 
                {
                    loc3.maxHeight = loc10;
                }
            }
            else if (this.content.height > loc10) 
            {
                this.content.height = loc10;
            }
            return;
        }

        protected function layoutAbove(arg1:flash.geom.Rectangle):void
        {
            this._actualDirection = feathers.layout.RelativePosition.TOP;
            this.content.x = this.calculateXPosition(arg1);
            this.content.y = arg1.y - this.content.height - this._gap;
            return;
        }

        protected function layoutBelow(arg1:flash.geom.Rectangle):void
        {
            this._actualDirection = feathers.layout.RelativePosition.BOTTOM;
            this.content.x = this.calculateXPosition(arg1);
            this.content.y = arg1.y + arg1.height + this._gap;
            return;
        }

        public static const PRIMARY_DIRECTION_DOWN:String="down";

        public static const PRIMARY_DIRECTION_UP:String="up";

        protected var content:starling.display.DisplayObject;

        protected var source:starling.display.DisplayObject;

        protected var _delegate:feathers.display.RenderDelegate;

        protected var _openCloseTweenTarget:starling.display.DisplayObject;

        protected var _openCloseTween:starling.animation.Tween;

        protected var _isModal:Boolean=false;

        protected var _overlayFactory:Function;

        protected var _gap:Number=0;

        protected var _openCloseDuration:Number=0.2;

        protected var _actualDirection:String;

        protected var _primaryDirection:String="bottom";

        protected var _fitContentMinWidthToOrigin:Boolean=true;

        protected var _lastGlobalX:Number;

        protected var _lastGlobalY:Number;

        protected var _openCloseEase:Object="easeOut";
    }
}


//  class IPersistentPopUpContentManager
package feathers.controls.popups 
{
    public interface IPersistentPopUpContentManager extends feathers.controls.popups.IPopUpContentManager
    {
    }
}


//  class IPopUpContentManager
package feathers.controls.popups 
{
    import starling.display.*;
    
    public interface IPopUpContentManager
    {
        function get isOpen():Boolean;

        function open(arg1:starling.display.DisplayObject, arg2:starling.display.DisplayObject):void;

        function close():void;

        function dispose():void;
    }
}


//  class IPopUpContentManagerWithPrompt
package feathers.controls.popups 
{
    public interface IPopUpContentManagerWithPrompt extends feathers.controls.popups.IPopUpContentManager
    {
        function get prompt():String;

        function set prompt(arg1:String):void;
    }
}


//  class VerticalCenteredPopUpContentManager
package feathers.controls.popups 
{
    import feathers.core.*;
    import feathers.events.*;
    import feathers.utils.display.*;
    import flash.errors.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.ui.*;
    import starling.core.*;
    import starling.display.*;
    import starling.events.*;
    import starling.utils.*;
    
    public class VerticalCenteredPopUpContentManager extends starling.events.EventDispatcher implements feathers.controls.popups.IPopUpContentManager
    {
        public function VerticalCenteredPopUpContentManager()
        {
            super();
            return;
        }

        public function get margin():Number
        {
            return this.marginTop;
        }

        public function set margin(arg1:Number):void
        {
            this.marginTop = 0;
            this.marginRight = 0;
            this.marginBottom = 0;
            this.marginLeft = 0;
            return;
        }

        public function get overlayFactory():Function
        {
            return this._overlayFactory;
        }

        public function set overlayFactory(arg1:Function):void
        {
            this._overlayFactory = arg1;
            return;
        }

        public function get isOpen():Boolean
        {
            return !(this.content === null);
        }

        public function open(arg1:starling.display.DisplayObject, arg2:starling.display.DisplayObject):void
        {
            if (this.isOpen) 
            {
                throw new flash.errors.IllegalOperationError("Pop-up content is already open. Close the previous content before opening new content.");
            }
            this.content = arg1;
            feathers.core.PopUpManager.addPopUp(this.content, true, false, this._overlayFactory);
            if (this.content is feathers.core.IFeathersControl) 
            {
                this.content.addEventListener(feathers.events.FeathersEventType.RESIZE, this.content_resizeHandler);
            }
            this.content.addEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.content_removedFromStageHandler);
            this.layout();
            var loc1:*=starling.core.Starling.current.stage;
            loc1.addEventListener(starling.events.TouchEvent.TOUCH, this.stage_touchHandler);
            loc1.addEventListener(starling.events.ResizeEvent.RESIZE, this.stage_resizeHandler);
            var loc2:*=-feathers.utils.display.getDisplayObjectDepthFromStage(this.content);
            starling.core.Starling.current.nativeStage.addEventListener(flash.events.KeyboardEvent.KEY_DOWN, this.nativeStage_keyDownHandler, false, loc2, true);
            this.dispatchEventWith(starling.events.Event.OPEN);
            return;
        }

        public function close():void
        {
            if (!this.isOpen) 
            {
                return;
            }
            var loc1:*=this.content;
            this.content = null;
            var loc2:*=starling.core.Starling.current.stage;
            loc2.removeEventListener(starling.events.TouchEvent.TOUCH, this.stage_touchHandler);
            loc2.removeEventListener(starling.events.ResizeEvent.RESIZE, this.stage_resizeHandler);
            starling.core.Starling.current.nativeStage.removeEventListener(flash.events.KeyboardEvent.KEY_DOWN, this.nativeStage_keyDownHandler);
            if (loc1 is feathers.core.IFeathersControl) 
            {
                loc1.removeEventListener(feathers.events.FeathersEventType.RESIZE, this.content_resizeHandler);
            }
            loc1.removeEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.content_removedFromStageHandler);
            if (loc1.parent) 
            {
                loc1.removeFromParent(false);
            }
            this.dispatchEventWith(starling.events.Event.CLOSE);
            return;
        }

        public function dispose():void
        {
            this.close();
            return;
        }

        protected function layout():void
        {
            var loc5:*=null;
            var loc1:*=starling.core.Starling.current.stage;
            var loc2:*=loc1.stageWidth;
            if (loc2 > loc1.stageHeight) 
            {
                loc2 = loc1.stageHeight;
            }
            loc2 = loc2 - (this.marginLeft + this.marginRight);
            var loc3:*=loc1.stageHeight - this.marginTop - this.marginBottom;
            var loc4:*=false;
            if (this.content is feathers.core.IFeathersControl) 
            {
                loc5 = feathers.core.IFeathersControl(this.content);
                loc5.minWidth = loc2;
                loc5.maxWidth = loc2;
                loc5.maxHeight = loc3;
                loc4 = true;
            }
            if (this.content is feathers.core.IValidating) 
            {
                feathers.core.IValidating(this.content).validate();
            }
            if (!loc4) 
            {
                if (this.content.width > loc2) 
                {
                    this.content.width = loc2;
                }
                if (this.content.height > loc3) 
                {
                    this.content.height = loc3;
                }
            }
            this.content.x = Math.round((loc1.stageWidth - this.content.width) / 2);
            this.content.y = Math.round((loc1.stageHeight - this.content.height) / 2);
            return;
        }

        protected function content_resizeHandler(arg1:starling.events.Event):void
        {
            this.layout();
            return;
        }

        protected function content_removedFromStageHandler(arg1:starling.events.Event):void
        {
            this.close();
            return;
        }

        protected function nativeStage_keyDownHandler(arg1:flash.events.KeyboardEvent):void
        {
            if (arg1.isDefaultPrevented()) 
            {
                return;
            }
            if (!(arg1.keyCode == flash.ui.Keyboard.BACK) && !(arg1.keyCode == flash.ui.Keyboard.ESCAPE)) 
            {
                return;
            }
            arg1.preventDefault();
            this.close();
            return;
        }

        protected function stage_resizeHandler(arg1:starling.events.ResizeEvent):void
        {
            this.layout();
            return;
        }

        protected function stage_touchHandler(arg1:starling.events.TouchEvent):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=false;
            if (!feathers.core.PopUpManager.isTopLevelPopUp(this.content)) 
            {
                return;
            }
            var loc1:*=starling.core.Starling.current.stage;
            if (this.touchPointID >= 0) 
            {
                loc2 = arg1.getTouch(loc1, starling.events.TouchPhase.ENDED, this.touchPointID);
                if (!loc2) 
                {
                    return;
                }
                loc3 = starling.utils.Pool.getPoint();
                loc2.getLocation(loc1, loc3);
                loc4 = loc1.hitTest(loc3);
                starling.utils.Pool.putPoint(loc3);
                loc5 = false;
                if (this.content is starling.display.DisplayObjectContainer) 
                {
                    loc5 = starling.display.DisplayObjectContainer(this.content).contains(loc4);
                }
                else 
                {
                    loc5 = this.content == loc4;
                }
                if (!loc5) 
                {
                    this.touchPointID = -1;
                    this.close();
                }
            }
            else 
            {
                loc2 = arg1.getTouch(loc1, starling.events.TouchPhase.BEGAN);
                if (!loc2) 
                {
                    return;
                }
                loc3 = starling.utils.Pool.getPoint();
                loc2.getLocation(loc1, loc3);
                loc4 = loc1.hitTest(loc3);
                starling.utils.Pool.putPoint(loc3);
                loc5 = false;
                if (this.content is starling.display.DisplayObjectContainer) 
                {
                    loc5 = starling.display.DisplayObjectContainer(this.content).contains(loc4);
                }
                else 
                {
                    loc5 = this.content == loc4;
                }
                if (loc5) 
                {
                    return;
                }
                this.touchPointID = loc2.id;
            }
            return;
        }

        public var marginTop:Number=0;

        public var marginRight:Number=0;

        public var marginBottom:Number=0;

        public var marginLeft:Number=0;

        protected var _overlayFactory:Function=null;

        protected var content:starling.display.DisplayObject;

        protected var touchPointID:int=-1;
    }
}


