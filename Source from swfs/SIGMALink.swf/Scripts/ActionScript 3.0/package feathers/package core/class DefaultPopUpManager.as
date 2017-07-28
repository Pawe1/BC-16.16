//class DefaultPopUpManager
package feathers.core 
{
    import __AS3__.vec.*;
    import feathers.events.*;
    import flash.utils.*;
    import starling.display.*;
    import starling.events.*;
    
    public class DefaultPopUpManager extends Object implements feathers.core.IPopUpManager
    {
        public function DefaultPopUpManager(arg1:starling.display.DisplayObjectContainer=null)
        {
            this._popUps = new Vector.<starling.display.DisplayObject>(0);
            this._popUpToOverlay = new flash.utils.Dictionary(true);
            this._popUpToFocusManager = new flash.utils.Dictionary(true);
            this._centeredPopUps = new Vector.<starling.display.DisplayObject>(0);
            this._overlayFactory = defaultOverlayFactory;
            super();
            this.root = arg1;
            return;
        }

        public function get popUpCount():int
        {
            return this._popUps.length;
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

        public function get root():starling.display.DisplayObjectContainer
        {
            return this._root;
        }

        public function set root(arg1:starling.display.DisplayObjectContainer):void
        {
            var loc4:*=null;
            var loc5:*=null;
            if (this._root == arg1) 
            {
                return;
            }
            var loc1:*=this._popUps.length;
            var loc2:*=this._ignoreRemoval;
            this._ignoreRemoval = true;
            var loc3:*=0;
            while (loc3 < loc1) 
            {
                loc4 = this._popUps[loc3];
                loc5 = starling.display.DisplayObject(this._popUpToOverlay[loc4]);
                loc4.removeFromParent(false);
                if (loc5) 
                {
                    loc5.removeFromParent(false);
                }
                ++loc3;
            }
            this._ignoreRemoval = loc2;
            this._root = arg1;
            loc3 = 0;
            while (loc3 < loc1) 
            {
                loc4 = this._popUps[loc3];
                loc5 = starling.display.DisplayObject(this._popUpToOverlay[loc4]);
                if (loc5) 
                {
                    this._root.addChild(loc5);
                }
                this._root.addChild(loc4);
                ++loc3;
            }
            return;
        }

        public function addPopUp(arg1:starling.display.DisplayObject, arg2:Boolean=true, arg3:Boolean=true, arg4:Function=null):starling.display.DisplayObject
        {
            var loc1:*=null;
            if (arg2) 
            {
                if (arg4 == null) 
                {
                    arg4 = this._overlayFactory;
                }
                if (arg4 == null) 
                {
                    arg4 = defaultOverlayFactory;
                }
                loc1 = arg4();
                loc1.width = this._root.stage.stageWidth;
                loc1.height = this._root.stage.stageHeight;
                this._root.addChild(loc1);
                this._popUpToOverlay[arg1] = loc1;
            }
            this._popUps.push(arg1);
            this._root.addChild(arg1);
            arg1.addEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.popUp_removedFromStageHandler);
            if (this._popUps.length == 1) 
            {
                this._root.stage.addEventListener(starling.events.ResizeEvent.RESIZE, this.stage_resizeHandler);
            }
            if (arg2 && feathers.core.FocusManager.isEnabledForStage(this._root.stage) && arg1 is starling.display.DisplayObjectContainer) 
            {
                this._popUpToFocusManager[arg1] = feathers.core.FocusManager.pushFocusManager(starling.display.DisplayObjectContainer(arg1));
            }
            if (arg3) 
            {
                if (arg1 is feathers.core.IFeathersControl) 
                {
                    arg1.addEventListener(feathers.events.FeathersEventType.RESIZE, this.popUp_resizeHandler);
                }
                this._centeredPopUps.push(arg1);
                this.centerPopUp(arg1);
            }
            return arg1;
        }

        public function removePopUp(arg1:starling.display.DisplayObject, arg2:Boolean=false):starling.display.DisplayObject
        {
            var loc1:*=this._popUps.indexOf(arg1);
            if (loc1 < 0) 
            {
                throw new ArgumentError("Display object is not a pop-up.");
            }
            arg1.removeFromParent(arg2);
            return arg1;
        }

        public function removeAllPopUps(arg1:Boolean=false):void
        {
            var loc4:*=null;
            var loc1:*=this._popUps.slice();
            var loc2:*=loc1.length;
            var loc3:*=0;
            while (loc3 < loc2) 
            {
                loc4 = loc1[loc3];
                this.removePopUp(loc4, arg1);
                ++loc3;
            }
            return;
        }

        public function isPopUp(arg1:starling.display.DisplayObject):Boolean
        {
            return this._popUps.indexOf(arg1) >= 0;
        }

        public function isTopLevelPopUp(arg1:starling.display.DisplayObject):Boolean
        {
            var loc3:*=null;
            var loc4:*=null;
            var loc1:*=(this._popUps.length - 1);
            var loc2:*=loc1;
            while (loc2 >= 0) 
            {
                loc3 = this._popUps[loc2];
                if (loc3 == arg1) 
                {
                    return true;
                }
                loc4 = this._popUpToOverlay[loc3] as starling.display.DisplayObject;
                if (loc4) 
                {
                    return false;
                }
                --loc2;
            }
            return false;
        }

        public function centerPopUp(arg1:starling.display.DisplayObject):void
        {
            var loc1:*=this._root.stage;
            if (arg1 is feathers.core.IValidating) 
            {
                feathers.core.IValidating(arg1).validate();
            }
            arg1.x = arg1.pivotX + Math.round((loc1.stageWidth - arg1.width) / 2);
            arg1.y = arg1.pivotY + Math.round((loc1.stageHeight - arg1.height) / 2);
            return;
        }

        protected function popUp_resizeHandler(arg1:starling.events.Event):void
        {
            var loc1:*=starling.display.DisplayObject(arg1.currentTarget);
            var loc2:*=this._centeredPopUps.indexOf(loc1);
            if (loc2 < 0) 
            {
                return;
            }
            this.centerPopUp(loc1);
            return;
        }

        protected function popUp_removedFromStageHandler(arg1:starling.events.Event):void
        {
            if (this._ignoreRemoval) 
            {
                return;
            }
            var loc1:*=starling.display.DisplayObject(arg1.currentTarget);
            loc1.removeEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.popUp_removedFromStageHandler);
            var loc2:*=this._popUps.indexOf(loc1);
            this._popUps.removeAt(loc2);
            var loc3:*=starling.display.DisplayObject(this._popUpToOverlay[loc1]);
            if (loc3) 
            {
                loc3.removeFromParent(true);
                delete this._popUpToOverlay[loc1];
            }
            var loc4:*=this._popUpToFocusManager[loc1] as feathers.core.IFocusManager;
            if (loc4) 
            {
                delete this._popUpToFocusManager[loc1];
                feathers.core.FocusManager.removeFocusManager(loc4);
            }
            loc2 = this._centeredPopUps.indexOf(loc1);
            if (loc2 >= 0) 
            {
                if (loc1 is feathers.core.IFeathersControl) 
                {
                    loc1.removeEventListener(feathers.events.FeathersEventType.RESIZE, this.popUp_resizeHandler);
                }
                this._centeredPopUps.removeAt(loc2);
            }
            if (this._popUps.length == 0) 
            {
                this._root.stage.removeEventListener(starling.events.ResizeEvent.RESIZE, this.stage_resizeHandler);
            }
            return;
        }

        protected function stage_resizeHandler(arg1:starling.events.ResizeEvent):void
        {
            var loc4:*=null;
            var loc5:*=null;
            var loc1:*=this._root.stage;
            var loc2:*=this._popUps.length;
            var loc3:*=0;
            while (loc3 < loc2) 
            {
                loc4 = this._popUps[loc3];
                loc5 = starling.display.DisplayObject(this._popUpToOverlay[loc4]);
                if (loc5) 
                {
                    loc5.width = loc1.stageWidth;
                    loc5.height = loc1.stageHeight;
                }
                ++loc3;
            }
            loc2 = this._centeredPopUps.length;
            loc3 = 0;
            while (loc3 < loc2) 
            {
                loc4 = this._centeredPopUps[loc3];
                this.centerPopUp(loc4);
                ++loc3;
            }
            return;
        }

        public static function defaultOverlayFactory():starling.display.DisplayObject
        {
            var loc1:*=new starling.display.Quad(100, 100, 0);
            loc1.alpha = 0;
            return loc1;
        }

        protected var _popUps:__AS3__.vec.Vector.<starling.display.DisplayObject>;

        protected var _popUpToOverlay:flash.utils.Dictionary;

        protected var _popUpToFocusManager:flash.utils.Dictionary;

        protected var _centeredPopUps:__AS3__.vec.Vector.<starling.display.DisplayObject>;

        protected var _overlayFactory:Function;

        protected var _ignoreRemoval:Boolean=false;

        protected var _root:starling.display.DisplayObjectContainer;
    }
}


