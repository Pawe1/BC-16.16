//class ScrollContainer
package feathers.controls 
{
    import feathers.controls.supportClasses.*;
    import feathers.core.*;
    import feathers.events.*;
    import feathers.layout.*;
    import feathers.skins.*;
    import feathers.utils.display.*;
    import starling.core.*;
    import starling.display.*;
    import starling.events.*;
    
    public class ScrollContainer extends feathers.controls.Scroller implements feathers.controls.IScrollContainer, feathers.core.IFocusContainer
    {
        public function ScrollContainer()
        {
            super();
            this.layoutViewPort = new feathers.controls.supportClasses.LayoutViewPort();
            this.viewPort = this.layoutViewPort;
            this.addEventListener(starling.events.Event.ADDED_TO_STAGE, this.scrollContainer_addedToStageHandler);
            this.addEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.scrollContainer_removedFromStageHandler);
            return;
        }

        protected override function draw():void
        {
            var loc1:*=this.isInvalid(INVALIDATION_FLAG_LAYOUT);
            var loc2:*=this.isInvalid(INVALIDATION_FLAG_MXML_CONTENT);
            if (loc2) 
            {
                this.refreshMXMLContent();
            }
            if (loc1) 
            {
                if (this._layout is feathers.layout.IVirtualLayout) 
                {
                    feathers.layout.IVirtualLayout(this._layout).useVirtualLayout = false;
                }
                this.layoutViewPort.layout = this._layout;
            }
            var loc3:*=this._ignoreChildChanges;
            this._ignoreChildChanges = true;
            super.draw();
            this._ignoreChildChanges = loc3;
            return;
        }

        protected override function autoSizeIfNeeded():Boolean
        {
            var loc5:*=NaN;
            var loc6:*=NaN;
            var loc1:*=!(this._explicitWidth === this._explicitWidth);
            var loc2:*=!(this._explicitHeight === this._explicitHeight);
            var loc3:*=!(this._explicitMinWidth === this._explicitMinWidth);
            var loc4:*=!(this._explicitMinHeight === this._explicitMinHeight);
            if (!loc1 && !loc2 && !loc3 && !loc4) 
            {
                return false;
            }
            if (this._autoSizeMode === feathers.controls.AutoSizeMode.STAGE && !(this.stage === null)) 
            {
                loc5 = this.stage.stageWidth;
                loc6 = this.stage.stageHeight;
                return this.saveMeasurements(loc5, loc6, loc5, loc6);
            }
            return super.autoSizeIfNeeded();
        }

        protected override function get defaultStyleProvider():feathers.skins.IStyleProvider
        {
            return feathers.controls.ScrollContainer.globalStyleProvider;
        }

        protected function refreshMXMLContent():void
        {
            var loc3:*=null;
            if (!this._mxmlContent || this._mxmlContentIsReady) 
            {
                return;
            }
            var loc1:*=this._mxmlContent.length;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                loc3 = starling.display.DisplayObject(this._mxmlContent[loc2]);
                this.addChild(loc3);
                ++loc2;
            }
            this._mxmlContentIsReady = true;
            return;
        }

        public function get isChildFocusEnabled():Boolean
        {
            return this._isEnabled && this._isChildFocusEnabled;
        }

        public function set isChildFocusEnabled(arg1:Boolean):void
        {
            this._isChildFocusEnabled = arg1;
            return;
        }

        protected function scrollContainer_addedToStageHandler(arg1:starling.events.Event):void
        {
            if (this._autoSizeMode === feathers.controls.AutoSizeMode.STAGE) 
            {
                this.invalidate(INVALIDATION_FLAG_SIZE);
                this.stage.addEventListener(starling.events.Event.RESIZE, this.stage_resizeHandler);
            }
            return;
        }

        public function get layout():feathers.layout.ILayout
        {
            return this._layout;
        }

        public function set layout(arg1:feathers.layout.ILayout):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._layout === arg1) 
            {
                return;
            }
            this._layout = arg1;
            this.invalidate(INVALIDATION_FLAG_LAYOUT);
            return;
        }

        protected function scrollContainer_removedFromStageHandler(arg1:starling.events.Event):void
        {
            this.stage.removeEventListener(starling.events.Event.RESIZE, this.stage_resizeHandler);
            return;
        }

        protected function child_resizeHandler(arg1:starling.events.Event):void
        {
            if (this._ignoreChildChanges) 
            {
                return;
            }
            this.invalidate(INVALIDATION_FLAG_SIZE);
            return;
        }

        public function get mxmlContent():Array
        {
            return this._mxmlContent;
        }

        public function set mxmlContent(arg1:Array):void
        {
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=null;
            if (this._mxmlContent == arg1) 
            {
                return;
            }
            if (this._mxmlContent && this._mxmlContentIsReady) 
            {
                loc1 = this._mxmlContent.length;
                loc2 = 0;
                while (loc2 < loc1) 
                {
                    loc3 = starling.display.DisplayObject(this._mxmlContent[loc2]);
                    this.removeChild(loc3, true);
                    ++loc2;
                }
            }
            this._mxmlContent = arg1;
            this._mxmlContentIsReady = false;
            this.invalidate(INVALIDATION_FLAG_MXML_CONTENT);
            return;
        }

        protected function child_layoutDataChangeHandler(arg1:starling.events.Event):void
        {
            if (this._ignoreChildChanges) 
            {
                return;
            }
            this.invalidate(INVALIDATION_FLAG_SIZE);
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
            this._measureViewPort = !(this._autoSizeMode == feathers.controls.AutoSizeMode.STAGE);
            if (this.stage !== null) 
            {
                if (this._autoSizeMode !== feathers.controls.AutoSizeMode.STAGE) 
                {
                    this.stage.removeEventListener(starling.events.Event.RESIZE, this.stage_resizeHandler);
                }
                else 
                {
                    this.stage.addEventListener(starling.events.Event.RESIZE, this.stage_resizeHandler);
                }
            }
            this.invalidate(INVALIDATION_FLAG_SIZE);
            return;
        }

        protected function stage_resizeHandler(arg1:starling.events.Event):void
        {
            this.invalidate(INVALIDATION_FLAG_SIZE);
            return;
        }

        public override function get numChildren():int
        {
            if (!this.displayListBypassEnabled) 
            {
                return super.numChildren;
            }
            return starling.display.DisplayObjectContainer(this.viewPort).numChildren;
        }

        public function get numRawChildren():int
        {
            var loc1:*=this.displayListBypassEnabled;
            this.displayListBypassEnabled = false;
            var loc2:*=super.numChildren;
            this.displayListBypassEnabled = loc1;
            return loc2;
        }

        public override function getChildByName(arg1:String):starling.display.DisplayObject
        {
            if (!this.displayListBypassEnabled) 
            {
                return super.getChildByName(arg1);
            }
            return starling.display.DisplayObjectContainer(this.viewPort).getChildByName(arg1);
        }

        public function getRawChildByName(arg1:String):starling.display.DisplayObject
        {
            var loc1:*=this.displayListBypassEnabled;
            this.displayListBypassEnabled = false;
            var loc2:*=super.getChildByName(arg1);
            this.displayListBypassEnabled = loc1;
            return loc2;
        }

        public override function getChildAt(arg1:int):starling.display.DisplayObject
        {
            if (!this.displayListBypassEnabled) 
            {
                return super.getChildAt(arg1);
            }
            return starling.display.DisplayObjectContainer(this.viewPort).getChildAt(arg1);
        }

        public function getRawChildAt(arg1:int):starling.display.DisplayObject
        {
            var loc1:*=this.displayListBypassEnabled;
            this.displayListBypassEnabled = false;
            var loc2:*=super.getChildAt(arg1);
            this.displayListBypassEnabled = loc1;
            return loc2;
        }

        public function addRawChild(arg1:starling.display.DisplayObject):starling.display.DisplayObject
        {
            var loc1:*=this.displayListBypassEnabled;
            this.displayListBypassEnabled = false;
            if (arg1.parent != this) 
            {
                arg1 = super.addChildAt(arg1, super.numChildren);
            }
            else 
            {
                super.setChildIndex(arg1, super.numChildren);
            }
            this.displayListBypassEnabled = loc1;
            return arg1;
        }

        public override function addChild(arg1:starling.display.DisplayObject):starling.display.DisplayObject
        {
            return this.addChildAt(arg1, this.numChildren);
        }

        public override function addChildAt(arg1:starling.display.DisplayObject, arg2:int):starling.display.DisplayObject
        {
            if (!this.displayListBypassEnabled) 
            {
                return super.addChildAt(arg1, arg2);
            }
            var loc1:*=starling.display.DisplayObjectContainer(this.viewPort).addChildAt(arg1, arg2);
            if (loc1 is feathers.core.IFeathersControl) 
            {
                loc1.addEventListener(starling.events.Event.RESIZE, this.child_resizeHandler);
            }
            if (loc1 is feathers.layout.ILayoutDisplayObject) 
            {
                loc1.addEventListener(feathers.events.FeathersEventType.LAYOUT_DATA_CHANGE, this.child_layoutDataChangeHandler);
            }
            this.invalidate(INVALIDATION_FLAG_SIZE);
            return loc1;
        }

        public function addRawChildAt(arg1:starling.display.DisplayObject, arg2:int):starling.display.DisplayObject
        {
            var loc1:*=this.displayListBypassEnabled;
            this.displayListBypassEnabled = false;
            arg1 = super.addChildAt(arg1, arg2);
            this.displayListBypassEnabled = loc1;
            return arg1;
        }

        public function removeRawChild(arg1:starling.display.DisplayObject, arg2:Boolean=false):starling.display.DisplayObject
        {
            var loc1:*=this.displayListBypassEnabled;
            this.displayListBypassEnabled = false;
            var loc2:*=super.getChildIndex(arg1);
            if (loc2 >= 0) 
            {
                super.removeChildAt(loc2, arg2);
            }
            this.displayListBypassEnabled = loc1;
            return arg1;
        }

        public override function removeChildAt(arg1:int, arg2:Boolean=false):starling.display.DisplayObject
        {
            if (!this.displayListBypassEnabled) 
            {
                return super.removeChildAt(arg1, arg2);
            }
            var loc1:*=starling.display.DisplayObjectContainer(this.viewPort).removeChildAt(arg1, arg2);
            if (loc1 is feathers.core.IFeathersControl) 
            {
                loc1.removeEventListener(starling.events.Event.RESIZE, this.child_resizeHandler);
            }
            if (loc1 is feathers.layout.ILayoutDisplayObject) 
            {
                loc1.removeEventListener(feathers.events.FeathersEventType.LAYOUT_DATA_CHANGE, this.child_layoutDataChangeHandler);
            }
            this.invalidate(INVALIDATION_FLAG_SIZE);
            return loc1;
        }

        public function removeRawChildAt(arg1:int, arg2:Boolean=false):starling.display.DisplayObject
        {
            var loc1:*=this.displayListBypassEnabled;
            this.displayListBypassEnabled = false;
            var loc2:*=super.removeChildAt(arg1, arg2);
            this.displayListBypassEnabled = loc1;
            return loc2;
        }

        public override function getChildIndex(arg1:starling.display.DisplayObject):int
        {
            if (!this.displayListBypassEnabled) 
            {
                return super.getChildIndex(arg1);
            }
            return starling.display.DisplayObjectContainer(this.viewPort).getChildIndex(arg1);
        }

        public function getRawChildIndex(arg1:starling.display.DisplayObject):int
        {
            var loc1:*=this.displayListBypassEnabled;
            this.displayListBypassEnabled = false;
            var loc2:*=super.getChildIndex(arg1);
            this.displayListBypassEnabled = loc1;
            return loc2;
        }

        public override function setChildIndex(arg1:starling.display.DisplayObject, arg2:int):void
        {
            if (!this.displayListBypassEnabled) 
            {
                super.setChildIndex(arg1, arg2);
                return;
            }
            starling.display.DisplayObjectContainer(this.viewPort).setChildIndex(arg1, arg2);
            return;
        }

        public function setRawChildIndex(arg1:starling.display.DisplayObject, arg2:int):void
        {
            var loc1:*=this.displayListBypassEnabled;
            this.displayListBypassEnabled = false;
            super.setChildIndex(arg1, arg2);
            this.displayListBypassEnabled = loc1;
            return;
        }

        public function swapRawChildren(arg1:starling.display.DisplayObject, arg2:starling.display.DisplayObject):void
        {
            var loc1:*=this.getRawChildIndex(arg1);
            var loc2:*=this.getRawChildIndex(arg2);
            if (loc1 < 0 || loc2 < 0) 
            {
                throw new ArgumentError("Not a child of this container");
            }
            var loc3:*=this.displayListBypassEnabled;
            this.displayListBypassEnabled = false;
            this.swapRawChildrenAt(loc1, loc2);
            this.displayListBypassEnabled = loc3;
            return;
        }

        public override function swapChildrenAt(arg1:int, arg2:int):void
        {
            if (!this.displayListBypassEnabled) 
            {
                super.swapChildrenAt(arg1, arg2);
                return;
            }
            starling.display.DisplayObjectContainer(this.viewPort).swapChildrenAt(arg1, arg2);
            return;
        }

        public function swapRawChildrenAt(arg1:int, arg2:int):void
        {
            var loc1:*=this.displayListBypassEnabled;
            this.displayListBypassEnabled = false;
            super.swapChildrenAt(arg1, arg2);
            this.displayListBypassEnabled = loc1;
            return;
        }

        public override function sortChildren(arg1:Function):void
        {
            if (!this.displayListBypassEnabled) 
            {
                super.sortChildren(arg1);
                return;
            }
            starling.display.DisplayObjectContainer(this.viewPort).sortChildren(arg1);
            return;
        }

        public function sortRawChildren(arg1:Function):void
        {
            var loc1:*=this.displayListBypassEnabled;
            this.displayListBypassEnabled = false;
            super.sortChildren(arg1);
            this.displayListBypassEnabled = loc1;
            return;
        }

        public function readjustLayout():void
        {
            this.layoutViewPort.readjustLayout();
            this.invalidate(INVALIDATION_FLAG_SIZE);
            return;
        }

        protected override function initialize():void
        {
            var loc1:*=null;
            if (this.stage !== null) 
            {
                loc1 = feathers.utils.display.stageToStarling(this.stage);
                if (loc1.root === this) 
                {
                    this.autoSizeMode = feathers.controls.AutoSizeMode.STAGE;
                }
            }
            super.initialize();
            this.refreshMXMLContent();
            return;
        }

        protected static const INVALIDATION_FLAG_MXML_CONTENT:String="mxmlContent";

        public static const ALTERNATE_STYLE_NAME_TOOLBAR:String="feathers-toolbar-scroll-container";

        public static const SCROLL_POLICY_AUTO:String="auto";

        public static const SCROLL_POLICY_ON:String="on";

        public static const SCROLL_POLICY_OFF:String="off";

        public static const SCROLL_BAR_DISPLAY_MODE_FLOAT:String="float";

        public static const SCROLL_BAR_DISPLAY_MODE_FIXED:String="fixed";

        public static const SCROLL_BAR_DISPLAY_MODE_FIXED_FLOAT:String="fixedFloat";

        public static const SCROLL_BAR_DISPLAY_MODE_NONE:String="none";

        public static const VERTICAL_SCROLL_BAR_POSITION_RIGHT:String="right";

        public static const VERTICAL_SCROLL_BAR_POSITION_LEFT:String="left";

        public static const INTERACTION_MODE_TOUCH:String="touch";

        public static const INTERACTION_MODE_MOUSE:String="mouse";

        public static const INTERACTION_MODE_TOUCH_AND_SCROLL_BARS:String="touchAndScrollBars";

        public static const MOUSE_WHEEL_SCROLL_DIRECTION_VERTICAL:String="vertical";

        public static const MOUSE_WHEEL_SCROLL_DIRECTION_HORIZONTAL:String="horizontal";

        public static const DECELERATION_RATE_NORMAL:Number=0.998;

        public static const DECELERATION_RATE_FAST:Number=0.99;

        public static const AUTO_SIZE_MODE_STAGE:String="stage";

        public static const AUTO_SIZE_MODE_CONTENT:String="content";

        protected var displayListBypassEnabled:Boolean=true;

        protected var layoutViewPort:feathers.controls.supportClasses.LayoutViewPort;

        protected var _isChildFocusEnabled:Boolean=true;

        protected var _layout:feathers.layout.ILayout;

        protected var _mxmlContentIsReady:Boolean=false;

        protected var _mxmlContent:Array;

        protected var _autoSizeMode:String="content";

        protected var _ignoreChildChanges:Boolean=false;

        public static var globalStyleProvider:feathers.skins.IStyleProvider;
    }
}


