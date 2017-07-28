//class LayoutGroup
package feathers.controls 
{
    import __AS3__.vec.*;
    import feathers.core.*;
    import feathers.events.*;
    import feathers.layout.*;
    import feathers.skins.*;
    import feathers.utils.display.*;
    import feathers.utils.skins.*;
    import flash.geom.*;
    import starling.core.*;
    import starling.display.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.rendering.*;
    
    public class LayoutGroup extends feathers.core.FeathersControl
    {
        public function LayoutGroup()
        {
            this.items = new Vector.<starling.display.DisplayObject>(0);
            this.viewPortBounds = new feathers.layout.ViewPortBounds();
            this._layoutResult = new feathers.layout.LayoutBoundsResult();
            super();
            this.addEventListener(starling.events.Event.ADDED_TO_STAGE, this.layoutGroup_addedToStageHandler);
            this.addEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.layoutGroup_removedFromStageHandler);
            return;
        }

        public function readjustLayout():void
        {
            this.invalidate(INVALIDATION_FLAG_LAYOUT);
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

        protected override function draw():void
        {
            var loc8:*=false;
            var loc1:*=this.isInvalid(INVALIDATION_FLAG_LAYOUT);
            var loc2:*=this.isInvalid(INVALIDATION_FLAG_SIZE);
            var loc3:*=this.isInvalid(INVALIDATION_FLAG_CLIPPING);
            var loc4:*=this.isInvalid(INVALIDATION_FLAG_SCROLL);
            var loc5:*=this.isInvalid(INVALIDATION_FLAG_SKIN);
            var loc6:*=this.isInvalid(INVALIDATION_FLAG_STATE);
            var loc7:*=this.isInvalid(INVALIDATION_FLAG_MXML_CONTENT);
            if (loc7) 
            {
                this.refreshMXMLContent();
            }
            if (!loc1 && loc4 && this._layout && this._layout.requiresLayoutOnScroll) 
            {
                loc1 = true;
            }
            if (loc5 || loc6) 
            {
                this.refreshBackgroundSkin();
            }
            if (loc2 || loc1 || loc5 || loc6) 
            {
                this.refreshViewPortBounds();
                if (this._layout) 
                {
                    loc8 = this._ignoreChildChanges;
                    this._ignoreChildChanges = true;
                    this._layout.layout(this.items, this.viewPortBounds, this._layoutResult);
                    this._ignoreChildChanges = loc8;
                }
                else 
                {
                    this.handleManualLayout();
                }
                this.handleLayoutResult();
                this.refreshBackgroundLayout();
                this.validateChildren();
            }
            if (loc2 || loc3) 
            {
                this.refreshClipRect();
            }
            return;
        }

        protected override function get defaultStyleProvider():feathers.skins.IStyleProvider
        {
            return feathers.controls.LayoutGroup.globalStyleProvider;
        }

        protected function refreshBackgroundSkin():void
        {
            var loc2:*=null;
            var loc1:*=this.currentBackgroundSkin;
            this.currentBackgroundSkin = this.getCurrentBackgroundSkin();
            if (this.currentBackgroundSkin !== loc1) 
            {
                this.setRequiresRedraw();
                if (loc1 !== null) 
                {
                    var loc3:*;
                    (loc3 = loc1).starling_internal::setParent(null);
                }
                if (this.currentBackgroundSkin !== null) 
                {
                    (loc3 = this.currentBackgroundSkin).starling_internal::setParent(this);
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
            if (this._layout == arg1) 
            {
                return;
            }
            if (this._layout) 
            {
                this._layout.removeEventListener(starling.events.Event.CHANGE, this.layout_changeHandler);
            }
            this._layout = arg1;
            if (this._layout) 
            {
                if (this._layout is feathers.layout.IVirtualLayout) 
                {
                    feathers.layout.IVirtualLayout(this._layout).useVirtualLayout = false;
                }
                this._layout.addEventListener(starling.events.Event.CHANGE, this.layout_changeHandler);
                this.invalidate(INVALIDATION_FLAG_LAYOUT);
            }
            this.invalidate(INVALIDATION_FLAG_LAYOUT);
            return;
        }

        public override function addChildAt(arg1:starling.display.DisplayObject, arg2:int):starling.display.DisplayObject
        {
            if (arg1 is feathers.core.IFeathersControl) 
            {
                arg1.addEventListener(feathers.events.FeathersEventType.RESIZE, this.child_resizeHandler);
            }
            if (arg1 is feathers.layout.ILayoutDisplayObject) 
            {
                arg1.addEventListener(feathers.events.FeathersEventType.LAYOUT_DATA_CHANGE, this.child_layoutDataChangeHandler);
            }
            var loc1:*=this.items.indexOf(arg1);
            if (loc1 == arg2) 
            {
                return arg1;
            }
            if (loc1 >= 0) 
            {
                this.items.removeAt(loc1);
            }
            this.items.insertAt(arg2, arg1);
            this.invalidate(INVALIDATION_FLAG_LAYOUT);
            return super.addChildAt(arg1, arg2);
        }

        protected function getCurrentBackgroundSkin():starling.display.DisplayObject
        {
            if (!this._isEnabled && !(this._backgroundDisabledSkin === null)) 
            {
                return this._backgroundDisabledSkin;
            }
            return this._backgroundSkin;
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

        protected function refreshBackgroundLayout():void
        {
            if (this.currentBackgroundSkin === null) 
            {
                return;
            }
            if (!(this.currentBackgroundSkin.width === this.actualWidth) || !(this.currentBackgroundSkin.height === this.actualHeight)) 
            {
                this.currentBackgroundSkin.width = this.actualWidth;
                this.currentBackgroundSkin.height = this.actualHeight;
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
            if (!arg1) 
            {
                this.mask = null;
            }
            this.invalidate(INVALIDATION_FLAG_CLIPPING);
            return;
        }

        protected function refreshViewPortBounds():void
        {
            var loc1:*=!(this._explicitWidth === this._explicitWidth);
            var loc2:*=!(this._explicitHeight === this._explicitHeight);
            var loc3:*=!(this._explicitMinWidth === this._explicitMinWidth);
            var loc4:*=!(this._explicitMinHeight === this._explicitMinHeight);
            feathers.utils.skins.resetFluidChildDimensionsForMeasurement(this.currentBackgroundSkin, this._explicitWidth, this._explicitHeight, this._explicitMinWidth, this._explicitMinHeight, this._explicitMaxWidth, this._explicitMaxHeight, this._explicitBackgroundWidth, this._explicitBackgroundHeight, this._explicitBackgroundMinWidth, this._explicitBackgroundMinHeight, this._explicitBackgroundMaxWidth, this._explicitBackgroundMaxHeight);
            this.viewPortBounds.x = 0;
            this.viewPortBounds.y = 0;
            this.viewPortBounds.scrollX = 0;
            this.viewPortBounds.scrollY = 0;
            if (loc1 && this._autoSizeMode === feathers.controls.AutoSizeMode.STAGE && !(this.stage === null)) 
            {
                this.viewPortBounds.explicitWidth = this.stage.stageWidth;
            }
            else 
            {
                this.viewPortBounds.explicitWidth = this._explicitWidth;
            }
            if (loc2 && this._autoSizeMode === feathers.controls.AutoSizeMode.STAGE && !(this.stage === null)) 
            {
                this.viewPortBounds.explicitHeight = this.stage.stageHeight;
            }
            else 
            {
                this.viewPortBounds.explicitHeight = this._explicitHeight;
            }
            var loc5:*=this._explicitMinWidth;
            if (loc3) 
            {
                loc5 = 0;
            }
            var loc6:*=this._explicitMinHeight;
            if (loc4) 
            {
                loc6 = 0;
            }
            if (this.currentBackgroundSkin !== null) 
            {
                if (this.currentBackgroundSkin.width > loc5) 
                {
                    loc5 = this.currentBackgroundSkin.width;
                }
                if (this.currentBackgroundSkin.height > loc6) 
                {
                    loc6 = this.currentBackgroundSkin.height;
                }
            }
            this.viewPortBounds.minWidth = loc5;
            this.viewPortBounds.minHeight = loc6;
            this.viewPortBounds.maxWidth = this._explicitMaxWidth;
            this.viewPortBounds.maxHeight = this._explicitMaxHeight;
            return;
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

        protected function handleLayoutResult():void
        {
            var loc1:*=this._layoutResult.viewPortWidth;
            var loc2:*=this._layoutResult.viewPortHeight;
            this.saveMeasurements(loc1, loc2, loc1, loc2);
            return;
        }

        protected function handleManualLayout():void
        {
            var loc10:*=null;
            var loc11:*=NaN;
            var loc12:*=NaN;
            var loc1:*=this.viewPortBounds.explicitWidth;
            if (loc1 !== loc1) 
            {
                loc1 = 0;
            }
            var loc2:*=this.viewPortBounds.explicitHeight;
            if (loc2 !== loc2) 
            {
                loc2 = 0;
            }
            var loc3:*=this._ignoreChildChanges;
            this._ignoreChildChanges = true;
            var loc4:*=this.items.length;
            var loc5:*=0;
            while (loc5 < loc4) 
            {
                loc10 = this.items[loc5];
                if (!(loc10 is feathers.layout.ILayoutDisplayObject && !feathers.layout.ILayoutDisplayObject(loc10).includeInLayout)) 
                {
                    if (loc10 is feathers.core.IValidating) 
                    {
                        feathers.core.IValidating(loc10).validate();
                    }
                    loc11 = loc10.x - loc10.pivotX + loc10.width;
                    loc12 = loc10.y - loc10.pivotY + loc10.height;
                    if (loc11 === loc11 && loc11 > loc1) 
                    {
                        loc1 = loc11;
                    }
                    if (loc12 === loc12 && loc12 > loc2) 
                    {
                        loc2 = loc12;
                    }
                }
                ++loc5;
            }
            this._ignoreChildChanges = loc3;
            this._layoutResult.contentX = 0;
            this._layoutResult.contentY = 0;
            this._layoutResult.contentWidth = loc1;
            this._layoutResult.contentHeight = loc2;
            var loc6:*=this.viewPortBounds.minWidth;
            var loc7:*=this.viewPortBounds.minHeight;
            if (loc1 < loc6) 
            {
                loc1 = loc6;
            }
            if (loc2 < loc7) 
            {
                loc2 = loc7;
            }
            var loc8:*=this.viewPortBounds.maxWidth;
            var loc9:*=this.viewPortBounds.maxHeight;
            if (loc1 > loc8) 
            {
                loc1 = loc8;
            }
            if (loc2 > loc9) 
            {
                loc2 = loc9;
            }
            this._layoutResult.viewPortWidth = loc1;
            this._layoutResult.viewPortHeight = loc2;
            return;
        }

        protected function validateChildren():void
        {
            var loc3:*=null;
            if (this.currentBackgroundSkin is feathers.core.IValidating) 
            {
                feathers.core.IValidating(this.currentBackgroundSkin).validate();
            }
            var loc1:*=this.items.length;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                loc3 = this.items[loc2];
                if (loc3 is feathers.core.IValidating) 
                {
                    feathers.core.IValidating(loc3).validate();
                }
                ++loc2;
            }
            return;
        }

        protected function refreshClipRect():void
        {
            if (!this._clipContent) 
            {
                return;
            }
            var loc1:*=this.mask as starling.display.Quad;
            if (loc1) 
            {
                loc1.x = 0;
                loc1.y = 0;
                loc1.width = this.actualWidth;
                loc1.height = this.actualHeight;
            }
            else 
            {
                loc1 = new starling.display.Quad(1, 1, 16711935);
                loc1.width = this.actualWidth;
                loc1.height = this.actualHeight;
                this.mask = loc1;
            }
            return;
        }

        protected function layoutGroup_addedToStageHandler(arg1:starling.events.Event):void
        {
            if (this._autoSizeMode === feathers.controls.AutoSizeMode.STAGE) 
            {
                this.invalidate(INVALIDATION_FLAG_SIZE);
                this.stage.addEventListener(starling.events.Event.RESIZE, this.stage_resizeHandler);
            }
            return;
        }

        protected function layoutGroup_removedFromStageHandler(arg1:starling.events.Event):void
        {
            this.stage.removeEventListener(starling.events.Event.RESIZE, this.stage_resizeHandler);
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
            if (!(arg1 === null) && !(arg1.parent === null)) 
            {
                arg1.removeFromParent();
            }
            this._backgroundSkin = arg1;
            this.invalidate(INVALIDATION_FLAG_SKIN);
            return;
        }

        protected function layout_changeHandler(arg1:starling.events.Event):void
        {
            this.invalidate(INVALIDATION_FLAG_LAYOUT);
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
            if (!(arg1 === null) && !(arg1.parent === null)) 
            {
                arg1.removeFromParent();
            }
            this._backgroundDisabledSkin = arg1;
            this.invalidate(INVALIDATION_FLAG_SKIN);
            return;
        }

        protected function child_layoutDataChangeHandler(arg1:starling.events.Event):void
        {
            if (this._ignoreChildChanges) 
            {
                return;
            }
            this.invalidate(INVALIDATION_FLAG_LAYOUT);
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
            this.invalidate(INVALIDATION_FLAG_LAYOUT);
            return;
        }

        protected function child_resizeHandler(arg1:starling.events.Event):void
        {
            if (this._ignoreChildChanges) 
            {
                return;
            }
            this.invalidate(INVALIDATION_FLAG_LAYOUT);
            return;
        }

        public override function removeChildAt(arg1:int, arg2:Boolean=false):starling.display.DisplayObject
        {
            if (arg1 >= 0 && arg1 < this.items.length) 
            {
                this.items.removeAt(arg1);
            }
            var loc1:*=super.removeChildAt(arg1, arg2);
            if (loc1 is feathers.core.IFeathersControl) 
            {
                loc1.removeEventListener(feathers.events.FeathersEventType.RESIZE, this.child_resizeHandler);
            }
            if (loc1 is feathers.layout.ILayoutDisplayObject) 
            {
                loc1.removeEventListener(feathers.events.FeathersEventType.LAYOUT_DATA_CHANGE, this.child_layoutDataChangeHandler);
            }
            this.invalidate(INVALIDATION_FLAG_LAYOUT);
            return loc1;
        }

        public override function setChildIndex(arg1:starling.display.DisplayObject, arg2:int):void
        {
            super.setChildIndex(arg1, arg2);
            var loc1:*=this.items.indexOf(arg1);
            if (loc1 === arg2) 
            {
                return;
            }
            this.items.removeAt(loc1);
            this.items.insertAt(arg2, arg1);
            this.invalidate(INVALIDATION_FLAG_LAYOUT);
            return;
        }

        public override function swapChildrenAt(arg1:int, arg2:int):void
        {
            super.swapChildrenAt(arg1, arg2);
            var loc1:*=this.items[arg1];
            var loc2:*=this.items[arg2];
            this.items[arg1] = loc2;
            this.items[arg2] = loc1;
            this.invalidate(INVALIDATION_FLAG_LAYOUT);
            return;
        }

        public override function sortChildren(arg1:Function):void
        {
            super.sortChildren(arg1);
            this.items.sort(arg1);
            this.invalidate(INVALIDATION_FLAG_LAYOUT);
            return;
        }

        public override function hitTest(arg1:flash.geom.Point):starling.display.DisplayObject
        {
            var loc1:*=arg1.x;
            var loc2:*=arg1.y;
            var loc3:*=super.hitTest(arg1);
            if (loc3) 
            {
                if (!this._isEnabled) 
                {
                    return this;
                }
                return loc3;
            }
            if (!this.visible || !this.touchable) 
            {
                return null;
            }
            if (this.currentBackgroundSkin && this._hitArea.contains(loc1, loc2)) 
            {
                return this;
            }
            return null;
        }

        public override function render(arg1:starling.rendering.Painter):void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (!(this.currentBackgroundSkin === null) && this.currentBackgroundSkin.visible && this.currentBackgroundSkin.alpha > 0) 
            {
                this.currentBackgroundSkin.setRequiresRedraw();
                loc1 = this.currentBackgroundSkin.mask;
                loc2 = this.currentBackgroundSkin.filter;
                arg1.pushState();
                arg1.setStateTo(this.currentBackgroundSkin.transformationMatrix, this.currentBackgroundSkin.alpha, this.currentBackgroundSkin.blendMode);
                if (loc1 !== null) 
                {
                    arg1.drawMask(loc1);
                }
                if (loc2 === null) 
                {
                    this.currentBackgroundSkin.render(arg1);
                }
                else 
                {
                    loc2.render(arg1);
                }
                if (loc1 !== null) 
                {
                    arg1.eraseMask(loc1);
                }
                arg1.popState();
            }
            super.render(arg1);
            return;
        }

        public override function dispose():void
        {
            if (this.currentBackgroundSkin !== null) 
            {
                var loc1:*;
                (loc1 = this.currentBackgroundSkin).starling_internal::setParent(null);
            }
            if (this._backgroundSkin && !(this._backgroundSkin.parent === this)) 
            {
                this._backgroundSkin.dispose();
            }
            if (this._backgroundDisabledSkin && !(this._backgroundDisabledSkin.parent === this)) 
            {
                this._backgroundDisabledSkin.dispose();
            }
            this.layout = null;
            super.dispose();
            return;
        }

        protected static const INVALIDATION_FLAG_MXML_CONTENT:String="mxmlContent";

        protected static const INVALIDATION_FLAG_CLIPPING:String="clipping";

        public static const AUTO_SIZE_MODE_STAGE:String="stage";

        public static const AUTO_SIZE_MODE_CONTENT:String="content";

        public static const ALTERNATE_STYLE_NAME_TOOLBAR:String="feathers-toolbar-layout-group";

        protected var items:__AS3__.vec.Vector.<starling.display.DisplayObject>;

        protected var viewPortBounds:feathers.layout.ViewPortBounds;

        protected var _layoutResult:feathers.layout.LayoutBoundsResult;

        protected var _layout:feathers.layout.ILayout;

        protected var _mxmlContent:Array;

        protected var _clipContent:Boolean=false;

        protected var _explicitBackgroundWidth:Number;

        protected var _explicitBackgroundHeight:Number;

        protected var _explicitBackgroundMinWidth:Number;

        protected var _explicitBackgroundMinHeight:Number;

        protected var _explicitBackgroundMaxWidth:Number;

        protected var _explicitBackgroundMaxHeight:Number;

        protected var currentBackgroundSkin:starling.display.DisplayObject;

        protected var _backgroundSkin:starling.display.DisplayObject;

        protected var _backgroundDisabledSkin:starling.display.DisplayObject;

        protected var _autoSizeMode:String="content";

        protected var _ignoreChildChanges:Boolean=false;

        protected var _mxmlContentIsReady:Boolean=false;

        public static var globalStyleProvider:feathers.skins.IStyleProvider;
    }
}


