//class BottomDrawerPopUpContentManager
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


