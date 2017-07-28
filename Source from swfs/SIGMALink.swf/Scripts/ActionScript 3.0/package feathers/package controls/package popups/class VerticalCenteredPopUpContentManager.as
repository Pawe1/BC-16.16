//class VerticalCenteredPopUpContentManager
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


