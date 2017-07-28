//package supportClasses
//  class BaseScreenNavigator
package feathers.controls.supportClasses 
{
    import __AS3__.vec.*;
    import feathers.controls.*;
    import feathers.core.*;
    import feathers.events.*;
    import feathers.utils.skins.*;
    import flash.errors.*;
    import flash.utils.*;
    import starling.display.*;
    import starling.errors.*;
    import starling.events.*;
    
    public class BaseScreenNavigator extends feathers.core.FeathersControl
    {
        public function BaseScreenNavigator()
        {
            this._screens = {};
            super();
            if (Object(this).constructor == feathers.controls.supportClasses.BaseScreenNavigator) 
            {
                throw new Error(feathers.core.FeathersControl.ABSTRACT_CLASS_ERROR);
            }
            if (!SIGNAL_TYPE) 
            {
                try 
                {
                    SIGNAL_TYPE = Class(flash.utils.getDefinitionByName("org.osflash.signals.ISignal"));
                }
                catch (error:Error)
                {
                };
            }
            this.screenContainer = this;
            this.addEventListener(starling.events.Event.ADDED_TO_STAGE, this.screenNavigator_addedToStageHandler);
            this.addEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.screenNavigator_removedFromStageHandler);
            return;
        }

        public function removeAllScreens():void
        {
            var loc1:*=null;
            if (this._isTransitionActive) 
            {
                throw new flash.errors.IllegalOperationError("Cannot remove all screens while a transition is active.");
            }
            if (this._activeScreen) 
            {
                this.clearScreenInternal(null);
                this.dispatchEventWith(feathers.events.FeathersEventType.CLEAR);
            }
            var loc2:*=0;
            var loc3:*=this._screens;
            for (loc1 in loc3) 
            {
                delete this._screens[loc1];
            }
            return;
        }

        public function get activeScreenID():String
        {
            return this._activeScreenID;
        }

        public function hasScreen(arg1:String):Boolean
        {
            return this._screens.hasOwnProperty(arg1);
        }

        public function get activeScreen():starling.display.DisplayObject
        {
            return this._activeScreen;
        }

        public function getScreenIDs(arg1:__AS3__.vec.Vector.<String>=null):__AS3__.vec.Vector.<String>
        {
            var loc2:*=null;
            if (arg1) 
            {
                arg1.length = 0;
            }
            else 
            {
                arg1 = new Vector.<String>(0);
            }
            var loc1:*=0;
            var loc3:*=0;
            var loc4:*=this._screens;
            for (loc2 in loc4) 
            {
                arg1[loc1] = loc2;
                ++loc1;
            }
            return arg1;
        }

        protected override function draw():void
        {
            var loc1:*=this.isInvalid(INVALIDATION_FLAG_SIZE);
            var loc2:*=this.isInvalid(INVALIDATION_FLAG_SELECTED);
            var loc3:*=this.isInvalid(INVALIDATION_FLAG_STYLES);
            loc1 = this.autoSizeIfNeeded() || loc1;
            this.layoutChildren();
            if (loc3 || loc1) 
            {
                this.refreshMask();
            }
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
            var loc5:*=this._autoSizeMode === feathers.controls.AutoSizeMode.CONTENT || this.stage === null;
            var loc6:*=this._activeScreen as feathers.core.IMeasureDisplayObject;
            if (loc5) 
            {
                if (this._activeScreen !== null) 
                {
                    feathers.utils.skins.resetFluidChildDimensionsForMeasurement(this._activeScreen, this._explicitWidth, this._explicitHeight, this._explicitMinWidth, this._explicitMinHeight, this._explicitMaxWidth, this._explicitMaxHeight, this._activeScreenExplicitWidth, this._activeScreenExplicitHeight, this._activeScreenExplicitMinWidth, this._activeScreenExplicitMinHeight, this._activeScreenExplicitMaxWidth, this._activeScreenExplicitMaxHeight);
                    if (this._activeScreen is feathers.core.IValidating) 
                    {
                        feathers.core.IValidating(this._activeScreen).validate();
                    }
                }
            }
            var loc7:*=this._explicitWidth;
            if (loc1) 
            {
                if (loc5) 
                {
                    if (this._activeScreen === null) 
                    {
                        loc7 = 0;
                    }
                    else 
                    {
                        loc7 = this._activeScreen.width;
                    }
                }
                else 
                {
                    loc7 = this.stage.stageWidth;
                }
            }
            var loc8:*=this._explicitHeight;
            if (loc2) 
            {
                if (loc5) 
                {
                    if (this._activeScreen === null) 
                    {
                        loc8 = 0;
                    }
                    else 
                    {
                        loc8 = this._activeScreen.height;
                    }
                }
                else 
                {
                    loc8 = this.stage.stageHeight;
                }
            }
            var loc9:*=this._explicitMinWidth;
            if (loc3) 
            {
                if (loc5) 
                {
                    if (loc6 === null) 
                    {
                        if (this._activeScreen === null) 
                        {
                            loc9 = 0;
                        }
                        else 
                        {
                            loc9 = this._activeScreen.width;
                        }
                    }
                    else 
                    {
                        loc9 = loc6.minWidth;
                    }
                }
                else 
                {
                    loc9 = this.stage.stageWidth;
                }
            }
            var loc10:*=this._explicitMinHeight;
            if (loc4) 
            {
                if (loc5) 
                {
                    if (loc6 === null) 
                    {
                        if (this._activeScreen === null) 
                        {
                            loc10 = 0;
                        }
                        else 
                        {
                            loc10 = this._activeScreen.height;
                        }
                    }
                    else 
                    {
                        loc10 = loc6.minHeight;
                    }
                }
                else 
                {
                    loc10 = this.stage.stageHeight;
                }
            }
            return this.saveMeasurements(loc7, loc8, loc9, loc10);
        }

        protected function addScreenInternal(arg1:String, arg2:feathers.controls.supportClasses.IScreenNavigatorItem):void
        {
            if (this._screens.hasOwnProperty(arg1)) 
            {
                throw new ArgumentError("Screen with id \'" + arg1 + "\' already defined. Cannot add two screens with the same id.");
            }
            this._screens[arg1] = arg2;
            return;
        }

        protected function refreshMask():void
        {
            if (!this._clipContent) 
            {
                return;
            }
            var loc1:*=this.mask as starling.display.Quad;
            if (loc1) 
            {
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

        protected function removeScreenInternal(arg1:String):feathers.controls.supportClasses.IScreenNavigatorItem
        {
            if (!this._screens.hasOwnProperty(arg1)) 
            {
                throw new ArgumentError("Screen \'" + arg1 + "\' cannot be removed because it has not been added.");
            }
            if (this._isTransitionActive && (arg1 == this._previousScreenInTransitionID || arg1 == this._activeScreenID)) 
            {
                throw new flash.errors.IllegalOperationError("Cannot remove a screen while it is transitioning in or out.");
            }
            if (this._activeScreenID == arg1) 
            {
                this.clearScreenInternal(null);
                this.dispatchEventWith(feathers.events.FeathersEventType.CLEAR);
            }
            var loc1:*=feathers.controls.supportClasses.IScreenNavigatorItem(this._screens[arg1]);
            delete this._screens[arg1];
            return loc1;
        }

        protected function showScreenInternal(arg1:String, arg2:Function, arg3:Object=null):starling.display.DisplayObject
        {
            var loc2:*=null;
            var loc5:*=null;
            if (!this.hasScreen(arg1)) 
            {
                throw new ArgumentError("Screen with id \'" + arg1 + "\' cannot be shown because it has not been defined.");
            }
            if (this._isTransitionActive) 
            {
                this._nextScreenID = arg1;
                this._nextScreenTransition = arg2;
                this._clearAfterTransition = false;
                return null;
            }
            this._previousScreenInTransition = this._activeScreen;
            this._previousScreenInTransitionID = this._activeScreenID;
            if (this._activeScreen !== null) 
            {
                this.cleanupActiveScreen();
            }
            this._isTransitionActive = true;
            var loc1:*=feathers.controls.supportClasses.IScreenNavigatorItem(this._screens[arg1]);
            this._activeScreen = loc1.getScreen();
            this._activeScreenID = arg1;
            var loc6:*=0;
            var loc7:*=arg3;
            for (loc2 in loc7) 
            {
                this._activeScreen[loc2] = arg3[loc2];
            }
            if (this._activeScreen is feathers.controls.IScreen) 
            {
                loc5 = feathers.controls.IScreen(this._activeScreen);
                loc5.screenID = this._activeScreenID;
                loc5.owner = this;
            }
            if (this._autoSizeMode === feathers.controls.AutoSizeMode.CONTENT || !this.stage) 
            {
                this._activeScreen.addEventListener(starling.events.Event.RESIZE, this.activeScreen_resizeHandler);
            }
            this.prepareActiveScreen();
            var loc3:*=this._previousScreenInTransition === this._activeScreen;
            this.screenContainer.addChild(this._activeScreen);
            if (this._activeScreen is feathers.core.IFeathersControl) 
            {
                feathers.core.IFeathersControl(this._activeScreen).initializeNow();
            }
            var loc4:*=this._activeScreen as feathers.core.IMeasureDisplayObject;
            if (loc4 === null) 
            {
                this._activeScreenExplicitWidth = this._activeScreen.width;
                this._activeScreenExplicitHeight = this._activeScreen.height;
                this._activeScreenExplicitMinWidth = this._activeScreenExplicitWidth;
                this._activeScreenExplicitMinHeight = this._activeScreenExplicitHeight;
                this._activeScreenExplicitMaxWidth = this._activeScreenExplicitWidth;
                this._activeScreenExplicitMaxHeight = this._activeScreenExplicitHeight;
            }
            else 
            {
                this._activeScreenExplicitWidth = loc4.explicitWidth;
                this._activeScreenExplicitHeight = loc4.explicitHeight;
                this._activeScreenExplicitMinWidth = loc4.explicitMinWidth;
                this._activeScreenExplicitMinHeight = loc4.explicitMinHeight;
                this._activeScreenExplicitMaxWidth = loc4.explicitMaxWidth;
                this._activeScreenExplicitMaxHeight = loc4.explicitMaxHeight;
            }
            this.invalidate(INVALIDATION_FLAG_SELECTED);
            if (this._validationQueue && !this._validationQueue.isValidating) 
            {
                this._validationQueue.advanceTime(0);
            }
            else if (!this._isValidating) 
            {
                this.validate();
            }
            if (loc3) 
            {
                this._previousScreenInTransition = null;
                this._previousScreenInTransitionID = null;
                this._isTransitionActive = false;
            }
            else 
            {
                this.dispatchEventWith(feathers.events.FeathersEventType.TRANSITION_START);
                this._activeScreen.dispatchEventWith(feathers.events.FeathersEventType.TRANSITION_IN_START);
                if (this._previousScreenInTransition !== null) 
                {
                    this._previousScreenInTransition.dispatchEventWith(feathers.events.FeathersEventType.TRANSITION_OUT_START);
                }
                if (!(arg2 === null) && !(arg2 === defaultTransition)) 
                {
                    this._activeScreen.visible = false;
                    this._waitingForTransitionFrameCount = 0;
                    this._waitingTransition = arg2;
                    this.addEventListener(starling.events.Event.ENTER_FRAME, this.waitingForTransition_enterFrameHandler);
                }
                else 
                {
                    defaultTransition(this._previousScreenInTransition, this._activeScreen, this.transitionComplete);
                }
            }
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return this._activeScreen;
        }

        protected function clearScreenInternal(arg1:Function=null):void
        {
            if (this._activeScreen === null) 
            {
                return;
            }
            if (this._isTransitionActive) 
            {
                this._nextScreenID = null;
                this._clearAfterTransition = true;
                this._nextScreenTransition = arg1;
                return;
            }
            this.cleanupActiveScreen();
            this._isTransitionActive = true;
            this._previousScreenInTransition = this._activeScreen;
            this._previousScreenInTransitionID = this._activeScreenID;
            this._activeScreen = null;
            this._activeScreenID = null;
            this.dispatchEventWith(feathers.events.FeathersEventType.TRANSITION_START);
            this._previousScreenInTransition.dispatchEventWith(feathers.events.FeathersEventType.TRANSITION_OUT_START);
            if (arg1 === null) 
            {
                defaultTransition(this._previousScreenInTransition, this._activeScreen, this.transitionComplete);
            }
            else 
            {
                this._waitingForTransitionFrameCount = 0;
                this._waitingTransition = arg1;
                this.addEventListener(starling.events.Event.ENTER_FRAME, this.waitingForTransition_enterFrameHandler);
            }
            this.invalidate(INVALIDATION_FLAG_SELECTED);
            return;
        }

        protected function prepareActiveScreen():void
        {
            throw new starling.errors.AbstractMethodError();
        }

        protected function cleanupActiveScreen():void
        {
            throw new starling.errors.AbstractMethodError();
        }

        protected function layoutChildren():void
        {
            if (this._activeScreen !== null) 
            {
                if (this._activeScreen.width != this.actualWidth) 
                {
                    this._activeScreen.width = this.actualWidth;
                }
                if (this._activeScreen.height != this.actualHeight) 
                {
                    this._activeScreen.height = this.actualHeight;
                }
            }
            return;
        }

        protected function transitionComplete(arg1:Boolean=false):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=null;
            var loc7:*=null;
            var loc8:*=null;
            this._isTransitionActive = this._clearAfterTransition || this._nextScreenID;
            if (arg1) 
            {
                if (this._activeScreen !== null) 
                {
                    loc2 = feathers.controls.supportClasses.IScreenNavigatorItem(this._screens[this._activeScreenID]);
                    this.cleanupActiveScreen();
                    this.screenContainer.removeChild(this._activeScreen, loc2.canDispose);
                    if (!loc2.canDispose) 
                    {
                        this._activeScreen.width = this._activeScreenExplicitWidth;
                        this._activeScreen.height = this._activeScreenExplicitHeight;
                        loc3 = this._activeScreen as feathers.core.IMeasureDisplayObject;
                        if (loc3 !== null) 
                        {
                            loc3.minWidth = this._activeScreenExplicitMinWidth;
                            loc3.minHeight = this._activeScreenExplicitMinHeight;
                        }
                    }
                }
                this._activeScreen = this._previousScreenInTransition;
                this._activeScreenID = this._previousScreenInTransitionID;
                this._previousScreenInTransition = null;
                this._previousScreenInTransitionID = null;
                this.prepareActiveScreen();
                this.dispatchEventWith(feathers.events.FeathersEventType.TRANSITION_CANCEL);
            }
            else 
            {
                loc4 = this._activeScreen;
                loc5 = this._previousScreenInTransition;
                loc6 = this._previousScreenInTransitionID;
                loc2 = feathers.controls.supportClasses.IScreenNavigatorItem(this._screens[loc6]);
                this._previousScreenInTransition = null;
                this._previousScreenInTransitionID = null;
                if (loc5 !== null) 
                {
                    loc5.dispatchEventWith(feathers.events.FeathersEventType.TRANSITION_OUT_COMPLETE);
                }
                if (loc4 !== null) 
                {
                    loc4.dispatchEventWith(feathers.events.FeathersEventType.TRANSITION_IN_COMPLETE);
                }
                this.dispatchEventWith(feathers.events.FeathersEventType.TRANSITION_COMPLETE);
                if (loc5 !== null) 
                {
                    if (loc5 is feathers.controls.IScreen) 
                    {
                        loc7 = feathers.controls.IScreen(loc5);
                        loc7.screenID = null;
                        loc7.owner = null;
                    }
                    loc5.removeEventListener(starling.events.Event.RESIZE, this.activeScreen_resizeHandler);
                    this.screenContainer.removeChild(loc5, loc2.canDispose);
                }
            }
            this._isTransitionActive = false;
            var loc1:*=this._nextScreenTransition;
            this._nextScreenTransition = null;
            if (this._clearAfterTransition) 
            {
                this._clearAfterTransition = false;
                this.clearScreenInternal(loc1);
            }
            else if (this._nextScreenID !== null) 
            {
                loc8 = this._nextScreenID;
                this._nextScreenID = null;
                this.showScreenInternal(loc8, loc1);
            }
            return;
        }

        protected function screenNavigator_addedToStageHandler(arg1:starling.events.Event):void
        {
            if (this._autoSizeMode === feathers.controls.AutoSizeMode.STAGE) 
            {
                this.invalidate(INVALIDATION_FLAG_SIZE);
            }
            this.stage.addEventListener(starling.events.Event.RESIZE, this.stage_resizeHandler);
            return;
        }

        protected function screenNavigator_removedFromStageHandler(arg1:starling.events.Event):void
        {
            this.stage.removeEventListener(starling.events.Event.RESIZE, this.stage_resizeHandler);
            return;
        }

        public function get clipContent():Boolean
        {
            return this._clipContent;
        }

        public function set clipContent(arg1:Boolean):void
        {
            if (this._clipContent == arg1) 
            {
                return;
            }
            this._clipContent = arg1;
            if (!arg1) 
            {
                this.mask = null;
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function stage_resizeHandler(arg1:starling.events.Event):void
        {
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
            if (this._activeScreen) 
            {
                if (this._autoSizeMode != feathers.controls.AutoSizeMode.CONTENT) 
                {
                    this._activeScreen.removeEventListener(starling.events.Event.RESIZE, this.activeScreen_resizeHandler);
                }
                else 
                {
                    this._activeScreen.addEventListener(starling.events.Event.RESIZE, this.activeScreen_resizeHandler);
                }
            }
            this.invalidate(INVALIDATION_FLAG_SIZE);
            return;
        }

        internal function waitingForTransition_enterFrameHandler(arg1:starling.events.Event):void
        {
            if (this._waitingForTransitionFrameCount < 2) 
            {
                var loc2:*;
                var loc3:*=((loc2 = this)._waitingForTransitionFrameCount + 1);
                loc2._waitingForTransitionFrameCount = loc3;
                return;
            }
            this.removeEventListener(starling.events.Event.ENTER_FRAME, this.waitingForTransition_enterFrameHandler);
            if (this._activeScreen) 
            {
                this._activeScreen.visible = true;
            }
            var loc1:*=this._waitingTransition;
            this._waitingTransition = null;
            loc1(this._previousScreenInTransition, this._activeScreen, this.transitionComplete);
            return;
        }

        protected static function defaultTransition(arg1:starling.display.DisplayObject, arg2:starling.display.DisplayObject, arg3:Function):void
        {
            arg3();
            return;
        }

        protected function activeScreen_resizeHandler(arg1:starling.events.Event):void
        {
            if (this._isValidating || !(this._autoSizeMode == feathers.controls.AutoSizeMode.CONTENT)) 
            {
                return;
            }
            this.invalidate(INVALIDATION_FLAG_SIZE);
            return;
        }

        public function get isTransitionActive():Boolean
        {
            return this._isTransitionActive;
        }

        public override function dispose():void
        {
            if (this._activeScreen) 
            {
                this.cleanupActiveScreen();
                this._activeScreen = null;
                this._activeScreenID = null;
            }
            super.dispose();
            return;
        }

        public static const AUTO_SIZE_MODE_STAGE:String="stage";

        public static const AUTO_SIZE_MODE_CONTENT:String="content";

        protected var _activeScreenID:String;

        protected var _activeScreen:starling.display.DisplayObject;

        protected var screenContainer:starling.display.DisplayObjectContainer;

        protected var _activeScreenExplicitHeight:Number;

        protected var _activeScreenExplicitMinWidth:Number;

        protected var _activeScreenExplicitMinHeight:Number;

        protected var _activeScreenExplicitMaxWidth:Number;

        protected var _activeScreenExplicitMaxHeight:Number;

        protected var _screens:Object;

        protected var _previousScreenInTransitionID:String;

        protected var _previousScreenInTransition:starling.display.DisplayObject;

        protected var _nextScreenID:String=null;

        protected var _nextScreenTransition:Function=null;

        protected var _clearAfterTransition:Boolean=false;

        protected var _clipContent:Boolean=false;

        protected var _autoSizeMode:String="stage";

        protected var _waitingTransition:Function;

        internal var _waitingForTransitionFrameCount:int=1;

        protected var _activeScreenExplicitWidth:Number;

        protected static var SIGNAL_TYPE:Class;

        protected var _isTransitionActive:Boolean=false;
    }
}


//  class GroupedListDataViewPort
package feathers.controls.supportClasses 
{
    import __AS3__.vec.*;
    import feathers.controls.*;
    import feathers.controls.renderers.*;
    import feathers.core.*;
    import feathers.data.*;
    import feathers.events.*;
    import feathers.layout.*;
    import flash.errors.*;
    import flash.geom.*;
    import flash.utils.*;
    import starling.display.*;
    import starling.events.*;
    import starling.utils.*;
    
    public class GroupedListDataViewPort extends feathers.core.FeathersControl implements feathers.controls.supportClasses.IViewPort
    {
        public function GroupedListDataViewPort()
        {
            this._viewPortBounds = new feathers.layout.ViewPortBounds();
            this._layoutResult = new feathers.layout.LayoutBoundsResult();
            this._layoutItems = new Vector.<starling.display.DisplayObject>(0);
            this._unrenderedItems = new Vector.<int>(0);
            this._defaultItemRendererStorage = new ItemRendererFactoryStorage();
            this._itemStorageMap = {};
            this._itemRendererMap = new flash.utils.Dictionary(true);
            this._unrenderedHeaders = new Vector.<int>(0);
            this._defaultHeaderRendererStorage = new HeaderRendererFactoryStorage();
            this._headerRendererMap = new flash.utils.Dictionary(true);
            this._unrenderedFooters = new Vector.<int>(0);
            this._defaultFooterRendererStorage = new FooterRendererFactoryStorage();
            this._footerRendererMap = new flash.utils.Dictionary(true);
            this._headerIndices = new Vector.<int>(0);
            this._footerIndices = new Vector.<int>(0);
            super();
            this.addEventListener(starling.events.TouchEvent.TOUCH, this.touchHandler);
            this.addEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.removedFromStageHandler);
            return;
        }

        internal function refreshHeaderRendererStyles():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=0;
            var loc4:*=this._layoutItems;
            for each (loc1 in loc4) 
            {
                loc2 = loc1 as feathers.controls.renderers.IGroupedListHeaderRenderer;
                if (!loc2) 
                {
                    continue;
                }
                this.refreshOneHeaderRendererStyles(loc2);
            }
            return;
        }

        internal function refreshFooterRendererStyles():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=0;
            var loc4:*=this._layoutItems;
            for each (loc1 in loc4) 
            {
                loc2 = loc1 as feathers.controls.renderers.IGroupedListFooterRenderer;
                if (!loc2) 
                {
                    continue;
                }
                this.refreshOneFooterRendererStyles(loc2);
            }
            return;
        }

        internal function refreshOneItemRendererStyles(arg1:feathers.controls.renderers.IGroupedListItemRenderer):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=starling.display.DisplayObject(arg1);
            var loc4:*=0;
            var loc5:*=this._itemRendererProperties;
            for (loc2 in loc5) 
            {
                loc3 = this._itemRendererProperties[loc2];
                loc1[loc2] = loc3;
            }
            return;
        }

        internal function refreshOneHeaderRendererStyles(arg1:feathers.controls.renderers.IGroupedListHeaderRenderer):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=starling.display.DisplayObject(arg1);
            var loc4:*=0;
            var loc5:*=this._headerRendererProperties;
            for (loc2 in loc5) 
            {
                loc3 = this._headerRendererProperties[loc2];
                loc1[loc2] = loc3;
            }
            return;
        }

        internal function refreshOneFooterRendererStyles(arg1:feathers.controls.renderers.IGroupedListFooterRenderer):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=starling.display.DisplayObject(arg1);
            var loc4:*=0;
            var loc5:*=this._footerRendererProperties;
            for (loc2 in loc5) 
            {
                loc3 = this._footerRendererProperties[loc2];
                loc1[loc2] = loc3;
            }
            return;
        }

        public function get minVisibleWidth():Number
        {
            if (this._explicitMinVisibleWidth !== this._explicitMinVisibleWidth) 
            {
                return this._actualMinVisibleWidth;
            }
            return this._explicitMinVisibleWidth;
        }

        public function set minVisibleWidth(arg1:Number):void
        {
            if (this._explicitMinVisibleWidth == arg1) 
            {
                return;
            }
            var loc1:*=!(arg1 === arg1);
            if (loc1 && !(this._explicitMinVisibleWidth === this._explicitMinVisibleWidth)) 
            {
                return;
            }
            var loc2:*=this._explicitMinVisibleWidth;
            this._explicitMinVisibleWidth = arg1;
            if (loc1) 
            {
                this._actualMinVisibleWidth = 0;
                this.invalidate(INVALIDATION_FLAG_SIZE);
            }
            else 
            {
                this._actualMinVisibleWidth = arg1;
                if (!(this._explicitVisibleWidth === this._explicitVisibleWidth) && (this._actualVisibleWidth < arg1 || this._actualVisibleWidth === loc2)) 
                {
                    this.invalidate(INVALIDATION_FLAG_SIZE);
                }
            }
            return;
        }

        internal function refreshSelection():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=0;
            var loc4:*=this._layoutItems;
            for each (loc1 in loc4) 
            {
                loc2 = loc1 as feathers.controls.renderers.IGroupedListItemRenderer;
                if (!loc2) 
                {
                    continue;
                }
                loc2.isSelected = loc2.groupIndex == this._selectedGroupIndex && loc2.itemIndex == this._selectedItemIndex;
            }
            return;
        }

        public function get maxVisibleWidth():Number
        {
            return this._maxVisibleWidth;
        }

        public function set maxVisibleWidth(arg1:Number):void
        {
            if (this._maxVisibleWidth == arg1) 
            {
                return;
            }
            if (arg1 !== arg1) 
            {
                throw new ArgumentError("maxVisibleWidth cannot be NaN");
            }
            var loc1:*=this._maxVisibleWidth;
            this._maxVisibleWidth = arg1;
            if (!(this._explicitVisibleWidth === this._explicitVisibleWidth) && (this._actualVisibleWidth > arg1 || this._actualVisibleWidth === loc1)) 
            {
                this.invalidate(INVALIDATION_FLAG_SIZE);
            }
            return;
        }

        internal function refreshViewPortBounds():void
        {
            var loc1:*=!(this._explicitMinVisibleWidth === this._explicitMinVisibleWidth);
            var loc2:*=!(this._explicitMinVisibleHeight === this._explicitMinVisibleHeight);
            this._viewPortBounds.x = 0;
            this._viewPortBounds.y = 0;
            this._viewPortBounds.scrollX = this._horizontalScrollPosition;
            this._viewPortBounds.scrollY = this._verticalScrollPosition;
            this._viewPortBounds.explicitWidth = this._explicitVisibleWidth;
            this._viewPortBounds.explicitHeight = this._explicitVisibleHeight;
            if (loc1) 
            {
                this._viewPortBounds.minWidth = 0;
            }
            else 
            {
                this._viewPortBounds.minWidth = this._explicitMinVisibleWidth;
            }
            if (loc2) 
            {
                this._viewPortBounds.minHeight = 0;
            }
            else 
            {
                this._viewPortBounds.minHeight = this._explicitMinVisibleHeight;
            }
            this._viewPortBounds.maxWidth = this._maxVisibleWidth;
            this._viewPortBounds.maxHeight = this._maxVisibleHeight;
            return;
        }

        internal function refreshInactiveRenderers(arg1:Boolean):void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            this.refreshInactiveItemRenderers(this._defaultItemRendererStorage, arg1);
            var loc5:*=0;
            var loc6:*=this._itemStorageMap;
            for (loc1 in loc6) 
            {
                loc2 = ItemRendererFactoryStorage(this._itemStorageMap[loc1]);
                this.refreshInactiveItemRenderers(loc2, arg1);
            }
            this.refreshInactiveHeaderRenderers(this._defaultHeaderRendererStorage, arg1);
            loc5 = 0;
            loc6 = this._headerStorageMap;
            for (loc1 in loc6) 
            {
                loc3 = HeaderRendererFactoryStorage(this._headerStorageMap[loc1]);
                this.refreshInactiveHeaderRenderers(loc3, arg1);
            }
            this.refreshInactiveFooterRenderers(this._defaultFooterRendererStorage, arg1);
            loc5 = 0;
            loc6 = this._footerStorageMap;
            for (loc1 in loc6) 
            {
                loc4 = FooterRendererFactoryStorage(this._footerStorageMap[loc1]);
                this.refreshInactiveFooterRenderers(loc4, arg1);
            }
            if (arg1 && this._typicalItemRenderer) 
            {
                if (this._typicalItemIsInDataProvider) 
                {
                    delete this._itemRendererMap[this._typicalItemRenderer.data];
                }
                this.destroyItemRenderer(this._typicalItemRenderer);
                this._typicalItemRenderer = null;
                this._typicalItemIsInDataProvider = false;
            }
            this._headerIndices.length = 0;
            this._footerIndices.length = 0;
            return;
        }

        public function get visibleWidth():Number
        {
            return this._actualVisibleWidth;
        }

        public function set visibleWidth(arg1:Number):void
        {
            if (this._explicitVisibleWidth == arg1 || !(arg1 === arg1) && !(this._explicitVisibleWidth === this._explicitVisibleWidth)) 
            {
                return;
            }
            this._explicitVisibleWidth = arg1;
            if (this._actualVisibleWidth !== arg1) 
            {
                this.invalidate(INVALIDATION_FLAG_SIZE);
            }
            return;
        }

        internal function refreshInactiveItemRenderers(arg1:ItemRendererFactoryStorage, arg2:Boolean):void
        {
            var loc1:*=arg1.inactiveItemRenderers;
            arg1.inactiveItemRenderers = arg1.activeItemRenderers;
            arg1.activeItemRenderers = loc1;
            if (arg1.activeItemRenderers.length > 0) 
            {
                throw new flash.errors.IllegalOperationError("GroupedListDataViewPort: active item renderers should be empty.");
            }
            if (arg2) 
            {
                this.recoverInactiveItemRenderers(arg1);
                this.freeInactiveItemRenderers(arg1, 0);
            }
            return;
        }

        internal function refreshInactiveHeaderRenderers(arg1:HeaderRendererFactoryStorage, arg2:Boolean):void
        {
            var loc1:*=arg1.inactiveHeaderRenderers;
            arg1.inactiveHeaderRenderers = arg1.activeHeaderRenderers;
            arg1.activeHeaderRenderers = loc1;
            if (arg1.activeHeaderRenderers.length > 0) 
            {
                throw new flash.errors.IllegalOperationError("GroupedListDataViewPort: active header renderers should be empty.");
            }
            if (arg2) 
            {
                this.recoverInactiveHeaderRenderers(arg1);
                this.freeInactiveHeaderRenderers(arg1, 0);
            }
            return;
        }

        public function get minVisibleHeight():Number
        {
            if (this._explicitMinVisibleHeight !== this._explicitMinVisibleHeight) 
            {
                return this._actualMinVisibleHeight;
            }
            return this._explicitMinVisibleHeight;
        }

        public function set minVisibleHeight(arg1:Number):void
        {
            if (this._explicitMinVisibleHeight == arg1) 
            {
                return;
            }
            var loc1:*=!(arg1 === arg1);
            if (loc1 && !(this._explicitMinVisibleHeight === this._explicitMinVisibleHeight)) 
            {
                return;
            }
            var loc2:*=this._explicitMinVisibleHeight;
            this._explicitMinVisibleHeight = arg1;
            if (loc1) 
            {
                this._actualMinVisibleHeight = 0;
                this.invalidate(INVALIDATION_FLAG_SIZE);
            }
            else 
            {
                this._actualMinVisibleHeight = arg1;
                if (!(this._explicitVisibleHeight === this._explicitVisibleHeight) && (this._actualVisibleHeight < arg1 || this._actualVisibleHeight === loc2)) 
                {
                    this.invalidate(INVALIDATION_FLAG_SIZE);
                }
            }
            return;
        }

        internal function refreshInactiveFooterRenderers(arg1:FooterRendererFactoryStorage, arg2:Boolean):void
        {
            var loc1:*=arg1.inactiveFooterRenderers;
            arg1.inactiveFooterRenderers = arg1.activeFooterRenderers;
            arg1.activeFooterRenderers = loc1;
            if (arg1.activeFooterRenderers.length > 0) 
            {
                throw new flash.errors.IllegalOperationError("GroupedListDataViewPort: active footer renderers should be empty.");
            }
            if (arg2) 
            {
                this.recoverInactiveFooterRenderers(arg1);
                this.freeInactiveFooterRenderers(arg1, 0);
            }
            return;
        }

        public function get maxVisibleHeight():Number
        {
            return this._maxVisibleHeight;
        }

        public function set maxVisibleHeight(arg1:Number):void
        {
            if (this._maxVisibleHeight == arg1) 
            {
                return;
            }
            if (arg1 !== arg1) 
            {
                throw new ArgumentError("maxVisibleHeight cannot be NaN");
            }
            var loc1:*=this._maxVisibleHeight;
            this._maxVisibleHeight = arg1;
            if (!(this._explicitVisibleHeight === this._explicitVisibleHeight) && (this._actualVisibleHeight > arg1 || this._actualVisibleHeight === loc1)) 
            {
                this.invalidate(INVALIDATION_FLAG_SIZE);
            }
            return;
        }

        internal function refreshRenderers():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=0;
            var loc5:*=0;
            var loc6:*=null;
            var loc7:*=null;
            var loc8:*=null;
            if (this._typicalItemRenderer) 
            {
                if (this._typicalItemIsInDataProvider) 
                {
                    loc1 = this.factoryIDToStorage(this._typicalItemRenderer.factoryID, this._typicalItemRenderer.groupIndex, this._typicalItemRenderer.itemIndex);
                    loc2 = loc1.inactiveItemRenderers;
                    loc3 = loc1.activeItemRenderers;
                    loc4 = loc2.indexOf(this._typicalItemRenderer);
                    if (loc4 >= 0) 
                    {
                        loc2.removeAt(loc4);
                    }
                    loc5 = loc3.length;
                    if (loc5 == 0) 
                    {
                        loc3[loc5] = this._typicalItemRenderer;
                    }
                }
                this.refreshOneItemRendererStyles(this._typicalItemRenderer);
            }
            this.findUnrenderedData();
            this.recoverInactiveItemRenderers(this._defaultItemRendererStorage);
            if (this._itemStorageMap) 
            {
                var loc9:*=0;
                var loc10:*=this._itemStorageMap;
                for (loc6 in loc10) 
                {
                    loc1 = ItemRendererFactoryStorage(this._itemStorageMap[loc6]);
                    this.recoverInactiveItemRenderers(loc1);
                }
            }
            this.recoverInactiveHeaderRenderers(this._defaultHeaderRendererStorage);
            if (this._headerStorageMap) 
            {
                loc9 = 0;
                loc10 = this._headerStorageMap;
                for (loc6 in loc10) 
                {
                    loc7 = HeaderRendererFactoryStorage(this._headerStorageMap[loc6]);
                    this.recoverInactiveHeaderRenderers(loc7);
                }
            }
            this.recoverInactiveFooterRenderers(this._defaultFooterRendererStorage);
            if (this._footerStorageMap) 
            {
                loc9 = 0;
                loc10 = this._footerStorageMap;
                for (loc6 in loc10) 
                {
                    loc8 = FooterRendererFactoryStorage(this._footerStorageMap[loc6]);
                    this.recoverInactiveFooterRenderers(loc8);
                }
            }
            this.renderUnrenderedData();
            this.freeInactiveItemRenderers(this._defaultItemRendererStorage, this._minimumItemCount);
            if (this._itemStorageMap) 
            {
                loc9 = 0;
                loc10 = this._itemStorageMap;
                for (loc6 in loc10) 
                {
                    loc1 = ItemRendererFactoryStorage(this._itemStorageMap[loc6]);
                    this.freeInactiveItemRenderers(loc1, 1);
                }
            }
            this.freeInactiveHeaderRenderers(this._defaultHeaderRendererStorage, this._minimumHeaderCount);
            if (this._headerStorageMap) 
            {
                loc9 = 0;
                loc10 = this._headerStorageMap;
                for (loc6 in loc10) 
                {
                    loc7 = HeaderRendererFactoryStorage(this._headerStorageMap[loc6]);
                    this.freeInactiveHeaderRenderers(loc7, 1);
                }
            }
            this.freeInactiveFooterRenderers(this._defaultFooterRendererStorage, this._minimumFooterCount);
            if (this._footerStorageMap) 
            {
                loc9 = 0;
                loc10 = this._footerStorageMap;
                for (loc6 in loc10) 
                {
                    loc8 = FooterRendererFactoryStorage(this._footerStorageMap[loc6]);
                    this.freeInactiveFooterRenderers(loc8, 1);
                }
            }
            this._updateForDataReset = false;
            return;
        }

        internal function findUnrenderedData():void
        {
            var loc11:*=null;
            var loc12:*=0;
            var loc13:*=null;
            var loc14:*=NaN;
            var loc15:*=NaN;
            var loc16:*=NaN;
            var loc17:*=NaN;
            var loc18:*=null;
            var loc19:*=0;
            var loc20:*=null;
            var loc21:*=null;
            var loc22:*=0;
            var loc1:*=this._dataProvider ? this._dataProvider.getLength() : 0;
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=0;
            var loc5:*=0;
            var loc6:*=0;
            var loc7:*=0;
            while (loc7 < loc1) 
            {
                loc11 = this._dataProvider.getItemAt(loc7);
                if (this._owner.groupToHeaderData(loc11) !== null) 
                {
                    this._headerIndices[loc3] = loc2;
                    ++loc2;
                    ++loc3;
                }
                loc12 = this._dataProvider.getLength(loc7);
                loc2 = loc2 + loc12;
                loc6 = loc6 + loc12;
                if (loc12 == 0) 
                {
                    ++loc5;
                }
                if (this._owner.groupToFooterData(loc11) !== null) 
                {
                    this._footerIndices[loc4] = loc2;
                    ++loc2;
                    ++loc4;
                }
                ++loc7;
            }
            this._layoutItems.length = loc2;
            if (this._layout is feathers.layout.IGroupedLayout) 
            {
                feathers.layout.IGroupedLayout(this._layout).headerIndices = this._headerIndices;
            }
            var loc8:*=this._layout as feathers.layout.IVirtualLayout;
            var loc9:*=loc8 && loc8.useVirtualLayout;
            if (loc9) 
            {
                loc13 = starling.utils.Pool.getPoint();
                loc8.measureViewPort(loc2, this._viewPortBounds, loc13);
                loc14 = loc13.x;
                loc15 = loc13.y;
                starling.utils.Pool.putPoint(loc13);
                loc8.getVisibleIndicesAtScrollPosition(this._horizontalScrollPosition, this._verticalScrollPosition, loc14, loc15, loc2, HELPER_VECTOR);
                loc6 = loc6 / loc1;
                if (this._typicalItemRenderer) 
                {
                    loc16 = this._typicalItemRenderer.height;
                    if (this._typicalItemRenderer.width < loc16) 
                    {
                        loc16 = this._typicalItemRenderer.width;
                    }
                    loc17 = loc14;
                    if (loc15 > loc14) 
                    {
                        loc17 = loc15;
                    }
                    var loc23:*;
                    this._minimumFooterCount = loc23 = Math.ceil(loc17 / (loc16 * loc6));
                    this._minimumHeaderCount = loc23 = loc23;
                    this._minimumSingleItemCount = loc23 = loc23;
                    this._minimumFirstAndLastItemCount = loc23;
                    this._minimumHeaderCount = Math.min(this._minimumHeaderCount, loc3);
                    this._minimumFooterCount = Math.min(this._minimumFooterCount, loc4);
                    this._minimumSingleItemCount = Math.min(this._minimumSingleItemCount, loc5);
                    this._minimumItemCount = Math.ceil(loc17 / loc16) + 1;
                }
                else 
                {
                    this._minimumFirstAndLastItemCount = 1;
                    this._minimumHeaderCount = 1;
                    this._minimumFooterCount = 1;
                    this._minimumSingleItemCount = 1;
                    this._minimumItemCount = 1;
                }
            }
            var loc10:*=0;
            loc7 = 0;
            while (loc7 < loc1) 
            {
                loc11 = this._dataProvider.getItemAt(loc7);
                loc18 = this._owner.groupToHeaderData(loc11);
                if (loc18 !== null) 
                {
                    if (loc9 && HELPER_VECTOR.indexOf(loc10) < 0) 
                    {
                        this._layoutItems[loc10] = null;
                    }
                    else 
                    {
                        this.findRendererForHeader(loc18, loc7, loc10);
                    }
                    ++loc10;
                }
                loc12 = this._dataProvider.getLength(loc7);
                loc19 = 0;
                while (loc19 < loc12) 
                {
                    if (loc9 && HELPER_VECTOR.indexOf(loc10) < 0) 
                    {
                        if (this._typicalItemRenderer && this._typicalItemIsInDataProvider && this._typicalItemRenderer.groupIndex === loc7 && this._typicalItemRenderer.itemIndex === loc19) 
                        {
                            this._typicalItemRenderer.layoutIndex = loc10;
                        }
                        this._layoutItems[loc10] = null;
                    }
                    else 
                    {
                        loc21 = this._dataProvider.getItemAt(loc7, loc19);
                        this.findRendererForItem(loc21, loc7, loc19, loc10);
                    }
                    ++loc10;
                    ++loc19;
                }
                loc20 = this._owner.groupToFooterData(loc11);
                if (loc20 !== null) 
                {
                    if (loc9 && HELPER_VECTOR.indexOf(loc10) < 0) 
                    {
                        this._layoutItems[loc10] = null;
                    }
                    else 
                    {
                        this.findRendererForFooter(loc20, loc7, loc10);
                    }
                    ++loc10;
                }
                ++loc7;
            }
            if (this._typicalItemRenderer) 
            {
                if (loc9 && this._typicalItemIsInDataProvider) 
                {
                    loc22 = HELPER_VECTOR.indexOf(this._typicalItemRenderer.layoutIndex);
                    if (loc22 >= 0) 
                    {
                        this._typicalItemRenderer.visible = true;
                    }
                    else 
                    {
                        this._typicalItemRenderer.visible = false;
                    }
                }
                else 
                {
                    this._typicalItemRenderer.visible = this._typicalItemIsInDataProvider;
                }
            }
            HELPER_VECTOR.length = 0;
            return;
        }

        public function get visibleHeight():Number
        {
            return this._actualVisibleHeight;
        }

        public function set visibleHeight(arg1:Number):void
        {
            if (this._explicitVisibleHeight == arg1 || !(arg1 === arg1) && !(this._explicitVisibleHeight === this._explicitVisibleHeight)) 
            {
                return;
            }
            this._explicitVisibleHeight = arg1;
            if (this._actualVisibleHeight !== arg1) 
            {
                this.invalidate(INVALIDATION_FLAG_SIZE);
            }
            return;
        }

        internal function findRendererForItem(arg1:Object, arg2:int, arg3:int, arg4:int):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=0;
            var loc6:*=0;
            var loc1:*=feathers.controls.renderers.IGroupedListItemRenderer(this._itemRendererMap[arg1]);
            if (loc1) 
            {
                loc1.groupIndex = arg2;
                loc1.itemIndex = arg3;
                loc1.layoutIndex = arg4;
                if (this._updateForDataReset) 
                {
                    loc1.data = null;
                    loc1.data = arg1;
                }
                if (this._typicalItemRenderer != loc1) 
                {
                    loc2 = this.factoryIDToStorage(loc1.factoryID, loc1.groupIndex, loc1.itemIndex);
                    loc3 = loc2.activeItemRenderers;
                    loc4 = loc2.inactiveItemRenderers;
                    loc3[loc3.length] = loc1;
                    loc5 = loc4.indexOf(loc1);
                    if (loc5 >= 0) 
                    {
                        loc4.removeAt(loc5);
                    }
                    else 
                    {
                        throw new flash.errors.IllegalOperationError("GroupedListDataViewPort: renderer map contains bad data. This may be caused by duplicate items in the data provider, which is not allowed.");
                    }
                }
                loc1.visible = true;
                this._layoutItems[arg4] = starling.display.DisplayObject(loc1);
            }
            else 
            {
                loc6 = this._unrenderedItems.length;
                this._unrenderedItems[loc6] = arg2;
                ++loc6;
                this._unrenderedItems[loc6] = arg3;
                ++loc6;
                this._unrenderedItems[loc6] = arg4;
            }
            return;
        }

        public function get contentX():Number
        {
            return this._contentX;
        }

        internal function findRendererForHeader(arg1:Object, arg2:int, arg3:int):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=0;
            var loc1:*=feathers.controls.renderers.IGroupedListHeaderRenderer(this._headerRendererMap[arg1]);
            if (loc1) 
            {
                loc1.groupIndex = arg2;
                loc1.layoutIndex = arg3;
                if (this._updateForDataReset) 
                {
                    loc1.data = null;
                    loc1.data = arg1;
                }
                loc2 = this.headerFactoryIDToStorage(loc1.factoryID);
                loc3 = loc2.activeHeaderRenderers;
                loc4 = loc2.inactiveHeaderRenderers;
                loc3[loc3.length] = loc1;
                loc4.removeAt(loc4.indexOf(loc1));
                loc1.visible = true;
                this._layoutItems[arg3] = starling.display.DisplayObject(loc1);
            }
            else 
            {
                loc5 = this._unrenderedHeaders.length;
                this._unrenderedHeaders[loc5] = arg2;
                ++loc5;
                this._unrenderedHeaders[loc5] = arg3;
            }
            return;
        }

        public function get contentY():Number
        {
            return this._contentY;
        }

        public function get horizontalScrollStep():Number
        {
            if (this._typicalItemRenderer === null) 
            {
                return 0;
            }
            var loc1:*=this._typicalItemRenderer.width;
            var loc2:*=this._typicalItemRenderer.height;
            if (loc1 < loc2) 
            {
                return loc1;
            }
            return loc2;
        }

        public function get verticalScrollStep():Number
        {
            if (this._typicalItemRenderer === null) 
            {
                return 0;
            }
            var loc1:*=this._typicalItemRenderer.width;
            var loc2:*=this._typicalItemRenderer.height;
            if (loc1 < loc2) 
            {
                return loc1;
            }
            return loc2;
        }

        internal function findRendererForFooter(arg1:Object, arg2:int, arg3:int):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=0;
            var loc1:*=feathers.controls.renderers.IGroupedListFooterRenderer(this._footerRendererMap[arg1]);
            if (loc1) 
            {
                loc1.groupIndex = arg2;
                loc1.layoutIndex = arg3;
                if (this._updateForDataReset) 
                {
                    loc1.data = null;
                    loc1.data = arg1;
                }
                loc2 = this.footerFactoryIDToStorage(loc1.factoryID);
                loc3 = loc2.activeFooterRenderers;
                loc4 = loc2.inactiveFooterRenderers;
                loc3[loc3.length] = loc1;
                loc4.removeAt(loc4.indexOf(loc1));
                loc1.visible = true;
                this._layoutItems[arg3] = starling.display.DisplayObject(loc1);
            }
            else 
            {
                loc5 = this._unrenderedFooters.length;
                this._unrenderedFooters[loc5] = arg2;
                ++loc5;
                this._unrenderedFooters[loc5] = arg3;
            }
            return;
        }

        internal function renderUnrenderedData():void
        {
            var loc3:*=0;
            var loc4:*=0;
            var loc5:*=0;
            var loc6:*=null;
            var loc7:*=null;
            var loc8:*=null;
            var loc9:*=null;
            var loc1:*=this._unrenderedItems.length;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                loc3 = this._unrenderedItems.shift();
                loc4 = this._unrenderedItems.shift();
                loc5 = this._unrenderedItems.shift();
                loc6 = this._dataProvider.getItemAt(loc3, loc4);
                loc7 = this.createItemRenderer(loc6, loc3, loc4, loc5, true, false);
                this._layoutItems[loc5] = starling.display.DisplayObject(loc7);
                loc2 = loc2 + 3;
            }
            loc1 = this._unrenderedHeaders.length;
            loc2 = 0;
            while (loc2 < loc1) 
            {
                loc3 = this._unrenderedHeaders.shift();
                loc5 = this._unrenderedHeaders.shift();
                loc6 = this._dataProvider.getItemAt(loc3);
                loc6 = this._owner.groupToHeaderData(loc6);
                loc8 = this.createHeaderRenderer(loc6, loc3, loc5, false);
                this._layoutItems[loc5] = starling.display.DisplayObject(loc8);
                loc2 = loc2 + 2;
            }
            loc1 = this._unrenderedFooters.length;
            loc2 = 0;
            while (loc2 < loc1) 
            {
                loc3 = this._unrenderedFooters.shift();
                loc5 = this._unrenderedFooters.shift();
                loc6 = this._dataProvider.getItemAt(loc3);
                loc6 = this._owner.groupToFooterData(loc6);
                loc9 = this.createFooterRenderer(loc6, loc3, loc5, false);
                this._layoutItems[loc5] = starling.display.DisplayObject(loc9);
                loc2 = loc2 + 2;
            }
            return;
        }

        internal function recoverInactiveItemRenderers(arg1:ItemRendererFactoryStorage):void
        {
            var loc4:*=null;
            var loc1:*=arg1.inactiveItemRenderers;
            var loc2:*=loc1.length;
            var loc3:*=0;
            while (loc3 < loc2) 
            {
                loc4 = loc1[loc3];
                if (!(!loc4 || loc4.groupIndex < 0)) 
                {
                    this._owner.dispatchEventWith(feathers.events.FeathersEventType.RENDERER_REMOVE, false, loc4);
                    delete this._itemRendererMap[loc4.data];
                }
                ++loc3;
            }
            return;
        }

        internal function recoverInactiveHeaderRenderers(arg1:HeaderRendererFactoryStorage):void
        {
            var loc4:*=null;
            var loc1:*=arg1.inactiveHeaderRenderers;
            var loc2:*=loc1.length;
            var loc3:*=0;
            while (loc3 < loc2) 
            {
                loc4 = loc1[loc3];
                if (loc4) 
                {
                    this._owner.dispatchEventWith(feathers.events.FeathersEventType.RENDERER_REMOVE, false, loc4);
                    delete this._headerRendererMap[loc4.data];
                }
                ++loc3;
            }
            return;
        }

        internal function recoverInactiveFooterRenderers(arg1:FooterRendererFactoryStorage):void
        {
            var loc4:*=null;
            var loc1:*=arg1.inactiveFooterRenderers;
            var loc2:*=loc1.length;
            var loc3:*=0;
            while (loc3 < loc2) 
            {
                loc4 = loc1[loc3];
                if (loc4) 
                {
                    this._owner.dispatchEventWith(feathers.events.FeathersEventType.RENDERER_REMOVE, false, loc4);
                    delete this._footerRendererMap[loc4.data];
                }
                ++loc3;
            }
            return;
        }

        internal function freeInactiveItemRenderers(arg1:ItemRendererFactoryStorage, arg2:int):void
        {
            var loc7:*=null;
            var loc1:*=arg1.inactiveItemRenderers;
            var loc2:*=arg1.activeItemRenderers;
            var loc3:*=loc2.length;
            var loc4:*=arg2 - loc3;
            if (loc4 > loc1.length) 
            {
                loc4 = loc1.length;
            }
            var loc5:*=0;
            while (loc5 < loc4) 
            {
                loc7 = loc1.shift();
                loc7.data = null;
                loc7.groupIndex = -1;
                loc7.itemIndex = -1;
                loc7.layoutIndex = -1;
                loc7.visible = false;
                loc2[loc3] = loc7;
                ++loc3;
                ++loc5;
            }
            var loc6:*=loc1.length;
            loc5 = 0;
            while (loc5 < loc6) 
            {
                loc7 = loc1.shift();
                if (loc7) 
                {
                    this.destroyItemRenderer(loc7);
                }
                ++loc5;
            }
            return;
        }

        internal function freeInactiveHeaderRenderers(arg1:HeaderRendererFactoryStorage, arg2:int):void
        {
            var loc7:*=null;
            var loc1:*=arg1.inactiveHeaderRenderers;
            var loc2:*=arg1.activeHeaderRenderers;
            var loc3:*=loc2.length;
            var loc4:*=arg2 - loc3;
            if (loc4 > loc1.length) 
            {
                loc4 = loc1.length;
            }
            var loc5:*=0;
            while (loc5 < loc4) 
            {
                loc7 = loc1.shift();
                loc7.visible = false;
                loc7.data = null;
                loc7.groupIndex = -1;
                loc7.layoutIndex = -1;
                loc2[loc3] = loc7;
                ++loc3;
                ++loc5;
            }
            var loc6:*=loc1.length;
            loc5 = 0;
            while (loc5 < loc6) 
            {
                loc7 = loc1.shift();
                if (loc7) 
                {
                    this.destroyHeaderRenderer(loc7);
                }
                ++loc5;
            }
            return;
        }

        internal function freeInactiveFooterRenderers(arg1:FooterRendererFactoryStorage, arg2:int):void
        {
            var loc7:*=null;
            var loc1:*=arg1.inactiveFooterRenderers;
            var loc2:*=arg1.activeFooterRenderers;
            var loc3:*=loc2.length;
            var loc4:*=arg2 - loc3;
            if (loc4 > loc1.length) 
            {
                loc4 = loc1.length;
            }
            var loc5:*=0;
            while (loc5 < loc4) 
            {
                loc7 = loc1.shift();
                loc7.visible = false;
                loc7.data = null;
                loc7.groupIndex = -1;
                loc7.layoutIndex = -1;
                loc2[loc3] = loc7;
                ++loc3;
                ++loc5;
            }
            var loc6:*=loc1.length;
            loc5 = 0;
            while (loc5 < loc6) 
            {
                loc7 = loc1.shift();
                if (loc7) 
                {
                    this.destroyFooterRenderer(loc7);
                }
                ++loc5;
            }
            return;
        }

        internal function createItemRenderer(arg1:Object, arg2:int, arg3:int, arg4:int, arg5:Boolean, arg6:Boolean):feathers.controls.renderers.IGroupedListItemRenderer
        {
            var loc7:*=null;
            var loc8:*=null;
            var loc9:*=null;
            var loc1:*=this.getFactoryID(arg1, arg2, arg3);
            var loc2:*=this.factoryIDToFactory(loc1, arg2, arg3);
            var loc3:*=this.factoryIDToStorage(loc1, arg2, arg3);
            var loc4:*=this.indexToCustomStyleName(arg2, arg3);
            var loc5:*=loc3.inactiveItemRenderers;
            var loc6:*=loc3.activeItemRenderers;
            if (!arg5 || arg6 || loc5.length === 0) 
            {
                if (loc2 === null) 
                {
                    loc9 = this.indexToItemRendererType(arg2, arg3);
                    loc7 = feathers.controls.renderers.IGroupedListItemRenderer(new loc9());
                }
                else 
                {
                    loc7 = feathers.controls.renderers.IGroupedListItemRenderer(loc2());
                }
                loc8 = feathers.core.IFeathersControl(loc7);
                if (loc4 && loc4.length > 0) 
                {
                    loc8.styleNameList.add(loc4);
                }
                this.addChild(starling.display.DisplayObject(loc7));
            }
            else 
            {
                loc7 = loc5.shift();
            }
            loc7.data = arg1;
            loc7.groupIndex = arg2;
            loc7.itemIndex = arg3;
            loc7.layoutIndex = arg4;
            loc7.owner = this._owner;
            loc7.factoryID = loc1;
            loc7.visible = true;
            if (!arg6) 
            {
                this._itemRendererMap[arg1] = loc7;
                loc6.push(loc7);
                loc7.addEventListener(starling.events.Event.TRIGGERED, this.renderer_triggeredHandler);
                loc7.addEventListener(starling.events.Event.CHANGE, this.renderer_changeHandler);
                loc7.addEventListener(feathers.events.FeathersEventType.RESIZE, this.itemRenderer_resizeHandler);
                this._owner.dispatchEventWith(feathers.events.FeathersEventType.RENDERER_ADD, false, loc7);
            }
            return loc7;
        }

        internal function createHeaderRenderer(arg1:Object, arg2:int, arg3:int, arg4:Boolean=false):feathers.controls.renderers.IGroupedListHeaderRenderer
        {
            var loc6:*=null;
            var loc7:*=null;
            var loc1:*=null;
            if (this._headerFactoryIDFunction !== null) 
            {
                if (this._headerFactoryIDFunction.length !== 1) 
                {
                    loc1 = this._headerFactoryIDFunction(arg1, arg2);
                }
                else 
                {
                    loc1 = this._headerFactoryIDFunction(arg1);
                }
            }
            var loc2:*=this.headerFactoryIDToFactory(loc1);
            var loc3:*=this.headerFactoryIDToStorage(loc1);
            var loc4:*=loc3.inactiveHeaderRenderers;
            var loc5:*=loc3.activeHeaderRenderers;
            if (arg4 || loc4.length === 0) 
            {
                if (loc2 === null) 
                {
                    loc6 = feathers.controls.renderers.IGroupedListHeaderRenderer(new this._headerRendererType());
                }
                else 
                {
                    loc6 = feathers.controls.renderers.IGroupedListHeaderRenderer(loc2());
                }
                loc7 = feathers.core.IFeathersControl(loc6);
                if (this._customHeaderRendererStyleName && this._customHeaderRendererStyleName.length > 0) 
                {
                    loc7.styleNameList.add(this._customHeaderRendererStyleName);
                }
                this.addChild(starling.display.DisplayObject(loc6));
            }
            else 
            {
                loc6 = loc4.shift();
            }
            loc6.data = arg1;
            loc6.groupIndex = arg2;
            loc6.layoutIndex = arg3;
            loc6.owner = this._owner;
            loc6.factoryID = loc1;
            loc6.visible = true;
            if (!arg4) 
            {
                this._headerRendererMap[arg1] = loc6;
                loc5.push(loc6);
                loc6.addEventListener(feathers.events.FeathersEventType.RESIZE, this.headerRenderer_resizeHandler);
                this._owner.dispatchEventWith(feathers.events.FeathersEventType.RENDERER_ADD, false, loc6);
            }
            return loc6;
        }

        internal function createFooterRenderer(arg1:Object, arg2:int, arg3:int, arg4:Boolean=false):feathers.controls.renderers.IGroupedListFooterRenderer
        {
            var loc6:*=null;
            var loc7:*=null;
            var loc1:*=null;
            if (this._footerFactoryIDFunction !== null) 
            {
                if (this._footerFactoryIDFunction.length !== 1) 
                {
                    loc1 = this._footerFactoryIDFunction(arg1, arg2);
                }
                else 
                {
                    loc1 = this._footerFactoryIDFunction(arg1);
                }
            }
            var loc2:*=this.footerFactoryIDToFactory(loc1);
            var loc3:*=this.footerFactoryIDToStorage(loc1);
            var loc4:*=loc3.inactiveFooterRenderers;
            var loc5:*=loc3.activeFooterRenderers;
            if (arg4 || loc4.length === 0) 
            {
                if (loc2 === null) 
                {
                    loc6 = feathers.controls.renderers.IGroupedListFooterRenderer(new this._footerRendererType());
                }
                else 
                {
                    loc6 = feathers.controls.renderers.IGroupedListFooterRenderer(loc2());
                }
                loc7 = feathers.core.IFeathersControl(loc6);
                if (this._customFooterRendererStyleName && this._customFooterRendererStyleName.length > 0) 
                {
                    loc7.styleNameList.add(this._customFooterRendererStyleName);
                }
                this.addChild(starling.display.DisplayObject(loc6));
            }
            else 
            {
                loc6 = loc4.shift();
            }
            loc6.data = arg1;
            loc6.groupIndex = arg2;
            loc6.layoutIndex = arg3;
            loc6.owner = this._owner;
            loc6.factoryID = loc1;
            loc6.visible = true;
            if (!arg4) 
            {
                this._footerRendererMap[arg1] = loc6;
                loc5[loc5.length] = loc6;
                loc6.addEventListener(feathers.events.FeathersEventType.RESIZE, this.footerRenderer_resizeHandler);
                this._owner.dispatchEventWith(feathers.events.FeathersEventType.RENDERER_ADD, false, loc6);
            }
            return loc6;
        }

        internal function destroyItemRenderer(arg1:feathers.controls.renderers.IGroupedListItemRenderer):void
        {
            arg1.removeEventListener(starling.events.Event.TRIGGERED, this.renderer_triggeredHandler);
            arg1.removeEventListener(starling.events.Event.CHANGE, this.renderer_changeHandler);
            arg1.removeEventListener(feathers.events.FeathersEventType.RESIZE, this.itemRenderer_resizeHandler);
            arg1.owner = null;
            arg1.data = null;
            this.removeChild(starling.display.DisplayObject(arg1), true);
            return;
        }

        internal function destroyHeaderRenderer(arg1:feathers.controls.renderers.IGroupedListHeaderRenderer):void
        {
            arg1.removeEventListener(feathers.events.FeathersEventType.RESIZE, this.headerRenderer_resizeHandler);
            arg1.owner = null;
            arg1.data = null;
            this.removeChild(starling.display.DisplayObject(arg1), true);
            return;
        }

        internal function destroyFooterRenderer(arg1:feathers.controls.renderers.IGroupedListFooterRenderer):void
        {
            arg1.removeEventListener(feathers.events.FeathersEventType.RESIZE, this.footerRenderer_resizeHandler);
            arg1.owner = null;
            arg1.data = null;
            this.removeChild(starling.display.DisplayObject(arg1), true);
            return;
        }

        internal function groupToHeaderDisplayIndex(arg1:int):int
        {
            var loc6:*=0;
            var loc7:*=0;
            var loc8:*=null;
            var loc1:*=this._dataProvider.getItemAt(arg1);
            var loc2:*=this._owner.groupToHeaderData(loc1);
            if (!loc2) 
            {
                return -1;
            }
            var loc3:*=0;
            var loc4:*=this._dataProvider.getLength();
            var loc5:*=0;
            while (loc5 < loc4) 
            {
                loc1 = this._dataProvider.getItemAt(loc5);
                loc2 = this._owner.groupToHeaderData(loc1);
                if (loc2) 
                {
                    if (arg1 == loc5) 
                    {
                        return loc3;
                    }
                    ++loc3;
                }
                loc6 = this._dataProvider.getLength(loc5);
                loc7 = 0;
                while (loc7 < loc6) 
                {
                    ++loc3;
                    ++loc7;
                }
                loc8 = this._owner.groupToFooterData(loc1);
                if (loc8) 
                {
                    ++loc3;
                }
                ++loc5;
            }
            return -1;
        }

        internal function groupToFooterDisplayIndex(arg1:int):int
        {
            var loc6:*=null;
            var loc7:*=0;
            var loc8:*=0;
            var loc1:*=this._dataProvider.getItemAt(arg1);
            var loc2:*=this._owner.groupToFooterData(loc1);
            if (!loc2) 
            {
                return -1;
            }
            var loc3:*=0;
            var loc4:*=this._dataProvider.getLength();
            var loc5:*=0;
            while (loc5 < loc4) 
            {
                loc1 = this._dataProvider.getItemAt(loc5);
                loc6 = this._owner.groupToHeaderData(loc1);
                if (loc6) 
                {
                    ++loc3;
                }
                loc7 = this._dataProvider.getLength(loc5);
                loc8 = 0;
                while (loc8 < loc7) 
                {
                    ++loc3;
                    ++loc8;
                }
                loc2 = this._owner.groupToFooterData(loc1);
                if (loc2) 
                {
                    if (arg1 == loc5) 
                    {
                        return loc3;
                    }
                    ++loc3;
                }
                ++loc5;
            }
            return -1;
        }

        internal function locationToDisplayIndex(arg1:int, arg2:int):int
        {
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=0;
            var loc7:*=0;
            var loc8:*=null;
            var loc1:*=0;
            var loc2:*=this._dataProvider.getLength();
            var loc3:*=0;
            while (loc3 < loc2) 
            {
                if (arg2 < 0 && arg1 == loc3) 
                {
                    return loc1;
                }
                loc4 = this._dataProvider.getItemAt(loc3);
                loc5 = this._owner.groupToHeaderData(loc4);
                if (loc5) 
                {
                    ++loc1;
                }
                loc6 = this._dataProvider.getLength(loc3);
                loc7 = 0;
                while (loc7 < loc6) 
                {
                    if (arg1 == loc3 && arg2 == loc7) 
                    {
                        return loc1;
                    }
                    ++loc1;
                    ++loc7;
                }
                loc8 = this._owner.groupToFooterData(loc4);
                if (loc8) 
                {
                    ++loc1;
                }
                ++loc3;
            }
            return -1;
        }

        internal function indexToCustomStyleName(arg1:int, arg2:int):String
        {
            var loc1:*=0;
            if (!(this._dataProvider === null) && this._dataProvider.getLength() > 0) 
            {
                loc1 = this._dataProvider.getLength(arg1);
            }
            if (arg2 === 0) 
            {
                if (!(this._customSingleItemRendererStyleName === null) && loc1 === 1) 
                {
                    return this._customSingleItemRendererStyleName;
                }
                if (this._customFirstItemRendererStyleName !== null) 
                {
                    return this._customFirstItemRendererStyleName;
                }
            }
            if (!(this._customLastItemRendererStyleName === null) && arg2 === (loc1 - 1)) 
            {
                return this._customLastItemRendererStyleName;
            }
            return this._customItemRendererStyleName;
        }

        internal function getFactoryID(arg1:Object, arg2:int, arg3:int):String
        {
            var loc1:*=0;
            if (this._factoryIDFunction === null) 
            {
                loc1 = 0;
                if (!(this._dataProvider === null) && this._dataProvider.getLength() > 0) 
                {
                    loc1 = this._dataProvider.getLength(arg2);
                }
                if (arg3 === 0) 
                {
                    if ((!(this._singleItemRendererType === null) || !(this._singleItemRendererFactory === null) || !(this._customSingleItemRendererStyleName === null)) && loc1 === 1) 
                    {
                        return SINGLE_ITEM_RENDERER_FACTORY_ID;
                    }
                    if (!(this._firstItemRendererType === null) || !(this._firstItemRendererFactory === null) || !(this._customFirstItemRendererStyleName === null)) 
                    {
                        return FIRST_ITEM_RENDERER_FACTORY_ID;
                    }
                }
                if ((!(this._lastItemRendererType === null) || !(this._lastItemRendererFactory === null) || !(this._customLastItemRendererStyleName === null)) && arg3 === (loc1 - 1)) 
                {
                    return LAST_ITEM_RENDERER_FACTORY_ID;
                }
                return null;
            }
            if (this._factoryIDFunction.length === 1) 
            {
                return this._factoryIDFunction(arg1);
            }
            return this._factoryIDFunction(arg1, arg2, arg3);
        }

        public function get owner():feathers.controls.GroupedList
        {
            return this._owner;
        }

        public function set owner(arg1:feathers.controls.GroupedList):void
        {
            if (this._owner == arg1) 
            {
                return;
            }
            if (this._owner) 
            {
                this._owner.removeEventListener(feathers.events.FeathersEventType.SCROLL_START, this.owner_scrollStartHandler);
            }
            this._owner = arg1;
            if (this._owner) 
            {
                this._owner.addEventListener(feathers.events.FeathersEventType.SCROLL_START, this.owner_scrollStartHandler);
            }
            return;
        }

        internal function factoryIDToFactory(arg1:String, arg2:int, arg3:int):Function
        {
            if (arg1 !== null) 
            {
                if (arg1 === FIRST_ITEM_RENDERER_FACTORY_ID) 
                {
                    if (this._firstItemRendererFactory !== null) 
                    {
                        return this._firstItemRendererFactory;
                    }
                    return this._itemRendererFactory;
                }
                if (arg1 === LAST_ITEM_RENDERER_FACTORY_ID) 
                {
                    if (this._lastItemRendererFactory !== null) 
                    {
                        return this._lastItemRendererFactory;
                    }
                    return this._itemRendererFactory;
                }
                if (arg1 === SINGLE_ITEM_RENDERER_FACTORY_ID) 
                {
                    if (this._singleItemRendererFactory !== null) 
                    {
                        return this._singleItemRendererFactory;
                    }
                    return this._itemRendererFactory;
                }
                if (arg1 in this._itemRendererFactories) 
                {
                    return this._itemRendererFactories[arg1] as Function;
                }
                throw new ReferenceError("Cannot find item renderer factory for ID \"" + arg1 + "\".");
            }
            return this._itemRendererFactory;
        }

        internal function factoryIDToStorage(arg1:String, arg2:int, arg3:int):ItemRendererFactoryStorage
        {
            var loc1:*=null;
            if (arg1 !== null) 
            {
                if (arg1 in this._itemStorageMap) 
                {
                    return ItemRendererFactoryStorage(this._itemStorageMap[arg1]);
                }
                loc1 = new ItemRendererFactoryStorage();
                this._itemStorageMap[arg1] = loc1;
                return loc1;
            }
            return this._defaultItemRendererStorage;
        }

        public function get dataProvider():feathers.data.HierarchicalCollection
        {
            return this._dataProvider;
        }

        public function set dataProvider(arg1:feathers.data.HierarchicalCollection):void
        {
            if (this._dataProvider == arg1) 
            {
                return;
            }
            if (this._dataProvider) 
            {
                this._dataProvider.removeEventListener(starling.events.Event.CHANGE, this.dataProvider_changeHandler);
                this._dataProvider.removeEventListener(feathers.events.CollectionEventType.RESET, this.dataProvider_resetHandler);
                this._dataProvider.removeEventListener(feathers.events.CollectionEventType.ADD_ITEM, this.dataProvider_addItemHandler);
                this._dataProvider.removeEventListener(feathers.events.CollectionEventType.REMOVE_ITEM, this.dataProvider_removeItemHandler);
                this._dataProvider.removeEventListener(feathers.events.CollectionEventType.REPLACE_ITEM, this.dataProvider_replaceItemHandler);
                this._dataProvider.removeEventListener(feathers.events.CollectionEventType.UPDATE_ITEM, this.dataProvider_updateItemHandler);
                this._dataProvider.removeEventListener(feathers.events.CollectionEventType.UPDATE_ALL, this.dataProvider_updateAllHandler);
            }
            this._dataProvider = arg1;
            if (this._dataProvider) 
            {
                this._dataProvider.addEventListener(starling.events.Event.CHANGE, this.dataProvider_changeHandler);
                this._dataProvider.addEventListener(feathers.events.CollectionEventType.RESET, this.dataProvider_resetHandler);
                this._dataProvider.addEventListener(feathers.events.CollectionEventType.ADD_ITEM, this.dataProvider_addItemHandler);
                this._dataProvider.addEventListener(feathers.events.CollectionEventType.REMOVE_ITEM, this.dataProvider_removeItemHandler);
                this._dataProvider.addEventListener(feathers.events.CollectionEventType.REPLACE_ITEM, this.dataProvider_replaceItemHandler);
                this._dataProvider.addEventListener(feathers.events.CollectionEventType.UPDATE_ITEM, this.dataProvider_updateItemHandler);
                this._dataProvider.addEventListener(feathers.events.CollectionEventType.UPDATE_ALL, this.dataProvider_updateAllHandler);
            }
            if (this._layout is feathers.layout.IVariableVirtualLayout) 
            {
                feathers.layout.IVariableVirtualLayout(this._layout).resetVariableVirtualCache();
            }
            this._updateForDataReset = true;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        internal function headerFactoryIDToFactory(arg1:String):Function
        {
            if (arg1 !== null) 
            {
                if (arg1 in this._headerRendererFactories) 
                {
                    return this._headerRendererFactories[arg1] as Function;
                }
                throw new ReferenceError("Cannot find header renderer factory for ID \"" + arg1 + "\".");
            }
            return this._headerRendererFactory;
        }

        public function get isSelectable():Boolean
        {
            return this._isSelectable;
        }

        public function set isSelectable(arg1:Boolean):void
        {
            if (this._isSelectable == arg1) 
            {
                return;
            }
            this._isSelectable = arg1;
            if (!this._isSelectable) 
            {
                this.setSelectedLocation(-1, -1);
            }
            this.invalidate(INVALIDATION_FLAG_SELECTED);
            return;
        }

        internal function headerFactoryIDToStorage(arg1:String):HeaderRendererFactoryStorage
        {
            var loc1:*=null;
            if (arg1 !== null) 
            {
                if (arg1 in this._headerStorageMap) 
                {
                    return HeaderRendererFactoryStorage(this._headerStorageMap[arg1]);
                }
                loc1 = new HeaderRendererFactoryStorage();
                this._headerStorageMap[arg1] = loc1;
                return loc1;
            }
            return this._defaultHeaderRendererStorage;
        }

        public function get selectedGroupIndex():int
        {
            return this._selectedGroupIndex;
        }

        internal function footerFactoryIDToFactory(arg1:String):Function
        {
            if (arg1 !== null) 
            {
                if (arg1 in this._footerRendererFactories) 
                {
                    return this._footerRendererFactories[arg1] as Function;
                }
                throw new ReferenceError("Cannot find footer renderer factory for ID \"" + arg1 + "\".");
            }
            return this._footerRendererFactory;
        }

        public function get selectedItemIndex():int
        {
            return this._selectedItemIndex;
        }

        internal function footerFactoryIDToStorage(arg1:String):FooterRendererFactoryStorage
        {
            var loc1:*=null;
            if (arg1 !== null) 
            {
                if (arg1 in this._footerStorageMap) 
                {
                    return FooterRendererFactoryStorage(this._footerStorageMap[arg1]);
                }
                loc1 = new FooterRendererFactoryStorage();
                this._footerStorageMap[arg1] = loc1;
                return loc1;
            }
            return this._defaultFooterRendererStorage;
        }

        public function get itemRendererType():Class
        {
            return this._itemRendererType;
        }

        public function set itemRendererType(arg1:Class):void
        {
            if (this._itemRendererType == arg1) 
            {
                return;
            }
            this._itemRendererType = arg1;
            this.invalidate(INVALIDATION_FLAG_ITEM_RENDERER_FACTORY);
            return;
        }

        internal function childProperties_onChange(arg1:feathers.core.PropertyProxy, arg2:String):void
        {
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get itemRendererFactory():Function
        {
            return this._itemRendererFactory;
        }

        public function set itemRendererFactory(arg1:Function):void
        {
            if (this._itemRendererFactory === arg1) 
            {
                return;
            }
            this._itemRendererFactory = arg1;
            this.invalidate(INVALIDATION_FLAG_ITEM_RENDERER_FACTORY);
            return;
        }

        internal function owner_scrollStartHandler(arg1:starling.events.Event):void
        {
            this._isScrolling = true;
            return;
        }

        public function get itemRendererFactories():Object
        {
            return this._itemRendererFactories;
        }

        public function set itemRendererFactories(arg1:Object):void
        {
            if (this._itemRendererFactories === arg1) 
            {
                return;
            }
            this._itemRendererFactories = arg1;
            this.invalidate(INVALIDATION_FLAG_ITEM_RENDERER_FACTORY);
            return;
        }

        internal function dataProvider_changeHandler(arg1:starling.events.Event):void
        {
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        public function get factoryIDFunction():Function
        {
            return this._factoryIDFunction;
        }

        public function set factoryIDFunction(arg1:Function):void
        {
            if (this._factoryIDFunction === arg1) 
            {
                return;
            }
            this._factoryIDFunction = arg1;
            this.invalidate(INVALIDATION_FLAG_ITEM_RENDERER_FACTORY);
            return;
        }

        internal function dataProvider_addItemHandler(arg1:starling.events.Event, arg2:Array):void
        {
            var loc3:*=0;
            var loc4:*=0;
            var loc5:*=0;
            var loc6:*=0;
            var loc7:*=0;
            var loc8:*=0;
            var loc9:*=0;
            var loc1:*=this._layout as feathers.layout.IVariableVirtualLayout;
            if (!loc1 || !loc1.hasVariableItemDimensions) 
            {
                return;
            }
            var loc2:*=arg2[0] as int;
            if (arg2.length > 1) 
            {
                loc3 = arg2[1] as int;
                loc4 = this.locationToDisplayIndex(loc2, loc3);
                loc1.addToVariableVirtualCacheAtIndex(loc4);
            }
            else 
            {
                loc5 = this.groupToHeaderDisplayIndex(loc2);
                if (loc5 >= 0) 
                {
                    loc1.addToVariableVirtualCacheAtIndex(loc5);
                }
                loc6 = this._dataProvider.getLength(loc2);
                if (loc6 > 0) 
                {
                    loc8 = loc5;
                    if (loc8 < 0) 
                    {
                        loc8 = this.locationToDisplayIndex(loc2, 0);
                    }
                    loc6 = loc6 + loc8;
                    loc9 = loc8;
                    while (loc9 < loc6) 
                    {
                        loc1.addToVariableVirtualCacheAtIndex(loc8);
                        ++loc9;
                    }
                }
                loc7 = this.groupToFooterDisplayIndex(loc2);
                if (loc7 >= 0) 
                {
                    loc1.addToVariableVirtualCacheAtIndex(loc7);
                }
            }
            return;
        }

        public function get customItemRendererStyleName():String
        {
            return this._customItemRendererStyleName;
        }

        public function set customItemRendererStyleName(arg1:String):void
        {
            if (this._customItemRendererStyleName == arg1) 
            {
                return;
            }
            this._customItemRendererStyleName = arg1;
            this.invalidate(INVALIDATION_FLAG_ITEM_RENDERER_FACTORY);
            return;
        }

        internal function dataProvider_removeItemHandler(arg1:starling.events.Event, arg2:Array):void
        {
            var loc3:*=0;
            var loc4:*=0;
            var loc1:*=this._layout as feathers.layout.IVariableVirtualLayout;
            if (!loc1 || !loc1.hasVariableItemDimensions) 
            {
                return;
            }
            var loc2:*=arg2[0] as int;
            if (arg2.length > 1) 
            {
                loc3 = arg2[1] as int;
                loc4 = this.locationToDisplayIndex(loc2, loc3);
                loc1.removeFromVariableVirtualCacheAtIndex(loc4);
            }
            else 
            {
                loc1.resetVariableVirtualCache();
            }
            return;
        }

        public function get typicalItem():Object
        {
            return this._typicalItem;
        }

        public function set typicalItem(arg1:Object):void
        {
            if (this._typicalItem == arg1) 
            {
                return;
            }
            this._typicalItem = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        internal function dataProvider_replaceItemHandler(arg1:starling.events.Event, arg2:Array):void
        {
            var loc3:*=0;
            var loc4:*=0;
            var loc1:*=this._layout as feathers.layout.IVariableVirtualLayout;
            if (!loc1 || !loc1.hasVariableItemDimensions) 
            {
                return;
            }
            var loc2:*=arg2[0] as int;
            if (arg2.length > 1) 
            {
                loc3 = arg2[1] as int;
                loc4 = this.locationToDisplayIndex(loc2, loc3);
                loc1.resetVariableVirtualCacheAtIndex(loc4);
            }
            else 
            {
                loc1.resetVariableVirtualCache();
            }
            return;
        }

        public function get itemRendererProperties():feathers.core.PropertyProxy
        {
            return this._itemRendererProperties;
        }

        public function set itemRendererProperties(arg1:feathers.core.PropertyProxy):void
        {
            if (this._itemRendererProperties == arg1) 
            {
                return;
            }
            if (this._itemRendererProperties) 
            {
                this._itemRendererProperties.removeOnChangeCallback(this.childProperties_onChange);
            }
            this._itemRendererProperties = feathers.core.PropertyProxy(arg1);
            if (this._itemRendererProperties) 
            {
                this._itemRendererProperties.addOnChangeCallback(this.childProperties_onChange);
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        internal function dataProvider_resetHandler(arg1:starling.events.Event):void
        {
            this._updateForDataReset = true;
            var loc1:*=this._layout as feathers.layout.IVariableVirtualLayout;
            if (!loc1 || !loc1.hasVariableItemDimensions) 
            {
                return;
            }
            loc1.resetVariableVirtualCache();
            return;
        }

        public function get firstItemRendererType():Class
        {
            return this._firstItemRendererType;
        }

        public function set firstItemRendererType(arg1:Class):void
        {
            if (this._firstItemRendererType == arg1) 
            {
                return;
            }
            this._firstItemRendererType = arg1;
            this.invalidate(INVALIDATION_FLAG_ITEM_RENDERER_FACTORY);
            return;
        }

        internal function dataProvider_updateItemHandler(arg1:starling.events.Event, arg2:Array):void
        {
            var loc2:*=0;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=0;
            var loc6:*=0;
            var loc7:*=null;
            var loc8:*=null;
            var loc9:*=null;
            var loc10:*=null;
            var loc1:*=arg2[0] as int;
            if (arg2.length > 1) 
            {
                loc2 = arg2[1] as int;
                loc3 = this._dataProvider.getItemAt(loc1, loc2);
                loc4 = feathers.controls.renderers.IGroupedListItemRenderer(this._itemRendererMap[loc3]);
                if (loc4 !== null) 
                {
                    loc4.data = null;
                    loc4.data = loc3;
                    if (!(this._explicitVisibleWidth === this._explicitVisibleWidth) || !(this._explicitVisibleHeight === this._explicitVisibleHeight)) 
                    {
                        this.invalidate(INVALIDATION_FLAG_SIZE);
                        this.invalidateParent(INVALIDATION_FLAG_SIZE);
                    }
                }
            }
            else 
            {
                loc5 = this._dataProvider.getLength(loc1);
                loc6 = 0;
                while (loc6 < loc5) 
                {
                    loc3 = this._dataProvider.getItemAt(loc1, loc6);
                    if (loc3) 
                    {
                        loc4 = feathers.controls.renderers.IGroupedListItemRenderer(this._itemRendererMap[loc3]);
                        if (loc4) 
                        {
                            loc4.data = null;
                            loc4.data = loc3;
                        }
                    }
                    ++loc6;
                }
                loc7 = this._dataProvider.getItemAt(loc1);
                loc3 = this._owner.groupToHeaderData(loc7);
                if (loc3) 
                {
                    loc9 = feathers.controls.renderers.IGroupedListHeaderRenderer(this._headerRendererMap[loc3]);
                    if (loc9) 
                    {
                        loc9.data = null;
                        loc9.data = loc3;
                    }
                }
                loc3 = this._owner.groupToFooterData(loc7);
                if (loc3) 
                {
                    loc10 = feathers.controls.renderers.IGroupedListFooterRenderer(this._footerRendererMap[loc3]);
                    if (loc10) 
                    {
                        loc10.data = null;
                        loc10.data = loc3;
                    }
                }
                this.invalidate(INVALIDATION_FLAG_DATA);
                loc8 = this._layout as feathers.layout.IVariableVirtualLayout;
                if (loc8 === null || !loc8.hasVariableItemDimensions) 
                {
                    return;
                }
                loc8.resetVariableVirtualCache();
            }
            return;
        }

        public function get firstItemRendererFactory():Function
        {
            return this._firstItemRendererFactory;
        }

        public function set firstItemRendererFactory(arg1:Function):void
        {
            if (this._firstItemRendererFactory === arg1) 
            {
                return;
            }
            this._firstItemRendererFactory = arg1;
            this.invalidate(INVALIDATION_FLAG_ITEM_RENDERER_FACTORY);
            return;
        }

        public function get layout():feathers.layout.ILayout
        {
            return this._layout;
        }

        public function get customFirstItemRendererStyleName():String
        {
            return this._customFirstItemRendererStyleName;
        }

        public function set customFirstItemRendererStyleName(arg1:String):void
        {
            if (this._customFirstItemRendererStyleName == arg1) 
            {
                return;
            }
            this._customFirstItemRendererStyleName = arg1;
            this.invalidate(INVALIDATION_FLAG_ITEM_RENDERER_FACTORY);
            return;
        }

        internal function dataProvider_updateAllHandler(arg1:starling.events.Event):void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=null;
            var loc7:*=0;
            var loc8:*=this._itemRendererMap;
            for (loc1 in loc8) 
            {
                loc4 = feathers.controls.renderers.IGroupedListItemRenderer(this._itemRendererMap[loc1]);
                if (loc4 === null) 
                {
                    continue;
                }
                loc4.data = null;
                loc4.data = loc1;
            }
            loc7 = 0;
            loc8 = this._headerRendererMap;
            for (loc2 in loc8) 
            {
                loc5 = feathers.controls.renderers.IGroupedListHeaderRenderer(this._headerRendererMap[loc2]);
                if (loc5 === null) 
                {
                    continue;
                }
                loc5.data = null;
                loc5.data = loc2;
            }
            loc7 = 0;
            loc8 = this._footerRendererMap;
            for (loc3 in loc8) 
            {
                loc6 = feathers.controls.renderers.IGroupedListFooterRenderer(this._footerRendererMap[loc3]);
                if (loc6 === null) 
                {
                    continue;
                }
                loc6.data = null;
                loc6.data = loc3;
            }
            return;
        }

        public function get lastItemRendererType():Class
        {
            return this._lastItemRendererType;
        }

        public function set lastItemRendererType(arg1:Class):void
        {
            if (this._lastItemRendererType == arg1) 
            {
                return;
            }
            this._lastItemRendererType = arg1;
            this.invalidate(INVALIDATION_FLAG_ITEM_RENDERER_FACTORY);
            return;
        }

        internal function layout_changeHandler(arg1:starling.events.Event):void
        {
            if (this._ignoreLayoutChanges) 
            {
                return;
            }
            this.invalidate(INVALIDATION_FLAG_LAYOUT);
            this.invalidateParent(INVALIDATION_FLAG_LAYOUT);
            return;
        }

        public function get lastItemRendererFactory():Function
        {
            return this._lastItemRendererFactory;
        }

        public function set lastItemRendererFactory(arg1:Function):void
        {
            if (this._lastItemRendererFactory === arg1) 
            {
                return;
            }
            this._lastItemRendererFactory = arg1;
            this.invalidate(INVALIDATION_FLAG_ITEM_RENDERER_FACTORY);
            return;
        }

        internal function itemRenderer_resizeHandler(arg1:starling.events.Event):void
        {
            if (this._ignoreRendererResizing) 
            {
                return;
            }
            if (arg1.currentTarget === this._typicalItemRenderer && !this._typicalItemIsInDataProvider) 
            {
                return;
            }
            var loc1:*=feathers.controls.renderers.IGroupedListItemRenderer(arg1.currentTarget);
            if (loc1.layoutIndex < 0) 
            {
                return;
            }
            this.invalidate(INVALIDATION_FLAG_LAYOUT);
            this.invalidateParent(INVALIDATION_FLAG_LAYOUT);
            var loc2:*=this._layout as feathers.layout.IVariableVirtualLayout;
            if (!loc2 || !loc2.hasVariableItemDimensions) 
            {
                return;
            }
            loc2.resetVariableVirtualCacheAtIndex(loc1.layoutIndex, starling.display.DisplayObject(loc1));
            return;
        }

        public function get customLastItemRendererStyleName():String
        {
            return this._customLastItemRendererStyleName;
        }

        public function set customLastItemRendererStyleName(arg1:String):void
        {
            if (this._customLastItemRendererStyleName == arg1) 
            {
                return;
            }
            this._customLastItemRendererStyleName = arg1;
            this.invalidate(INVALIDATION_FLAG_ITEM_RENDERER_FACTORY);
            return;
        }

        internal function headerRenderer_resizeHandler(arg1:starling.events.Event):void
        {
            if (this._ignoreRendererResizing) 
            {
                return;
            }
            var loc1:*=feathers.controls.renderers.IGroupedListHeaderRenderer(arg1.currentTarget);
            if (loc1.layoutIndex < 0) 
            {
                return;
            }
            this.invalidate(INVALIDATION_FLAG_LAYOUT);
            this.invalidateParent(INVALIDATION_FLAG_LAYOUT);
            var loc2:*=this._layout as feathers.layout.IVariableVirtualLayout;
            if (!loc2 || !loc2.hasVariableItemDimensions) 
            {
                return;
            }
            loc2.resetVariableVirtualCacheAtIndex(loc1.layoutIndex, starling.display.DisplayObject(loc1));
            return;
        }

        public function get singleItemRendererType():Class
        {
            return this._singleItemRendererType;
        }

        public function set singleItemRendererType(arg1:Class):void
        {
            if (this._singleItemRendererType == arg1) 
            {
                return;
            }
            this._singleItemRendererType = arg1;
            this.invalidate(INVALIDATION_FLAG_ITEM_RENDERER_FACTORY);
            return;
        }

        internal function footerRenderer_resizeHandler(arg1:starling.events.Event):void
        {
            if (this._ignoreRendererResizing) 
            {
                return;
            }
            var loc1:*=feathers.controls.renderers.IGroupedListFooterRenderer(arg1.currentTarget);
            if (loc1.layoutIndex < 0) 
            {
                return;
            }
            this.invalidate(INVALIDATION_FLAG_LAYOUT);
            this.invalidateParent(INVALIDATION_FLAG_LAYOUT);
            var loc2:*=this._layout as feathers.layout.IVariableVirtualLayout;
            if (!loc2 || !loc2.hasVariableItemDimensions) 
            {
                return;
            }
            loc2.resetVariableVirtualCacheAtIndex(loc1.layoutIndex, starling.display.DisplayObject(loc1));
            return;
        }

        public function get singleItemRendererFactory():Function
        {
            return this._singleItemRendererFactory;
        }

        public function set singleItemRendererFactory(arg1:Function):void
        {
            if (this._singleItemRendererFactory === arg1) 
            {
                return;
            }
            this._singleItemRendererFactory = arg1;
            this.invalidate(INVALIDATION_FLAG_ITEM_RENDERER_FACTORY);
            return;
        }

        internal function renderer_triggeredHandler(arg1:starling.events.Event):void
        {
            var loc1:*=feathers.controls.renderers.IGroupedListItemRenderer(arg1.currentTarget);
            this.parent.dispatchEventWith(starling.events.Event.TRIGGERED, false, loc1.data);
            return;
        }

        public function get customSingleItemRendererStyleName():String
        {
            return this._customSingleItemRendererStyleName;
        }

        public function set customSingleItemRendererStyleName(arg1:String):void
        {
            if (this._customSingleItemRendererStyleName == arg1) 
            {
                return;
            }
            this._customSingleItemRendererStyleName = arg1;
            this.invalidate(INVALIDATION_FLAG_ITEM_RENDERER_FACTORY);
            return;
        }

        internal function renderer_changeHandler(arg1:starling.events.Event):void
        {
            if (this._ignoreSelectionChanges) 
            {
                return;
            }
            var loc1:*=feathers.controls.renderers.IGroupedListItemRenderer(arg1.currentTarget);
            if (!this._isSelectable || this._isScrolling) 
            {
                loc1.isSelected = false;
                return;
            }
            if (loc1.isSelected) 
            {
                this.setSelectedLocation(loc1.groupIndex, loc1.itemIndex);
            }
            else 
            {
                this.setSelectedLocation(-1, -1);
            }
            return;
        }

        public function get headerRendererType():Class
        {
            return this._headerRendererType;
        }

        public function set headerRendererType(arg1:Class):void
        {
            if (this._headerRendererType == arg1) 
            {
                return;
            }
            this._headerRendererType = arg1;
            this.invalidate(INVALIDATION_FLAG_ITEM_RENDERER_FACTORY);
            return;
        }

        internal function removedFromStageHandler(arg1:starling.events.Event):void
        {
            this.touchPointID = -1;
            return;
        }

        public function get headerRendererFactory():Function
        {
            return this._headerRendererFactory;
        }

        public function set headerRendererFactory(arg1:Function):void
        {
            if (this._headerRendererFactory === arg1) 
            {
                return;
            }
            this._headerRendererFactory = arg1;
            this.invalidate(INVALIDATION_FLAG_ITEM_RENDERER_FACTORY);
            return;
        }

        internal function touchHandler(arg1:starling.events.TouchEvent):void
        {
            var loc1:*=null;
            if (!this._isEnabled) 
            {
                this.touchPointID = -1;
                return;
            }
            if (this.touchPointID >= 0) 
            {
                loc1 = arg1.getTouch(this, starling.events.TouchPhase.ENDED, this.touchPointID);
                if (!loc1) 
                {
                    return;
                }
                this.touchPointID = -1;
            }
            else 
            {
                loc1 = arg1.getTouch(this, starling.events.TouchPhase.BEGAN);
                if (!loc1) 
                {
                    return;
                }
                this.touchPointID = loc1.id;
                this._isScrolling = false;
            }
            return;
        }

        public function get headerRendererFactories():Object
        {
            return this._headerRendererFactories;
        }

        public function set headerRendererFactories(arg1:Object):void
        {
            if (this._headerRendererFactories === arg1) 
            {
                return;
            }
            this._headerRendererFactories = arg1;
            if (arg1 !== null) 
            {
                this._headerStorageMap = {};
            }
            this.invalidate(INVALIDATION_FLAG_ITEM_RENDERER_FACTORY);
            return;
        }

        internal function indexToItemRendererType(arg1:int, arg2:int):Class
        {
            var loc1:*=0;
            if (!(this._dataProvider === null) && this._dataProvider.getLength() > 0) 
            {
                loc1 = this._dataProvider.getLength(arg1);
            }
            if (arg2 === 0) 
            {
                if (!(this._singleItemRendererType === null) && loc1 === 1) 
                {
                    return this._singleItemRendererType;
                }
                if (this._firstItemRendererType !== null) 
                {
                    return this._firstItemRendererType;
                }
            }
            if (!(this._lastItemRendererType === null) && arg2 === (loc1 - 1)) 
            {
                return this._lastItemRendererType;
            }
            return this._itemRendererType;
        }

        public function get headerFactoryIDFunction():Function
        {
            return this._headerFactoryIDFunction;
        }

        public function set headerFactoryIDFunction(arg1:Function):void
        {
            if (this._headerFactoryIDFunction === arg1) 
            {
                return;
            }
            this._headerFactoryIDFunction = arg1;
            this.invalidate(INVALIDATION_FLAG_ITEM_RENDERER_FACTORY);
            return;
        }

        public function get customHeaderRendererStyleName():String
        {
            return this._customHeaderRendererStyleName;
        }

        public function set customHeaderRendererStyleName(arg1:String):void
        {
            if (this._customHeaderRendererStyleName == arg1) 
            {
                return;
            }
            this._customHeaderRendererStyleName = arg1;
            this.invalidate(INVALIDATION_FLAG_ITEM_RENDERER_FACTORY);
            return;
        }

        public function get headerRendererProperties():feathers.core.PropertyProxy
        {
            return this._headerRendererProperties;
        }

        public function set headerRendererProperties(arg1:feathers.core.PropertyProxy):void
        {
            if (this._headerRendererProperties == arg1) 
            {
                return;
            }
            if (this._headerRendererProperties) 
            {
                this._headerRendererProperties.removeOnChangeCallback(this.childProperties_onChange);
            }
            this._headerRendererProperties = feathers.core.PropertyProxy(arg1);
            if (this._headerRendererProperties) 
            {
                this._headerRendererProperties.addOnChangeCallback(this.childProperties_onChange);
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get footerRendererType():Class
        {
            return this._footerRendererType;
        }

        public function set footerRendererType(arg1:Class):void
        {
            if (this._footerRendererType == arg1) 
            {
                return;
            }
            this._footerRendererType = arg1;
            this.invalidate(INVALIDATION_FLAG_ITEM_RENDERER_FACTORY);
            return;
        }

        public function get footerRendererFactory():Function
        {
            return this._footerRendererFactory;
        }

        public function set footerRendererFactory(arg1:Function):void
        {
            if (this._footerRendererFactory === arg1) 
            {
                return;
            }
            this._footerRendererFactory = arg1;
            this.invalidate(INVALIDATION_FLAG_ITEM_RENDERER_FACTORY);
            return;
        }

        public function get footerRendererFactories():Object
        {
            return this._footerRendererFactories;
        }

        public function set footerRendererFactories(arg1:Object):void
        {
            if (this._footerRendererFactories === arg1) 
            {
                return;
            }
            this._footerRendererFactories = arg1;
            if (arg1 !== null) 
            {
                this._footerStorageMap = {};
            }
            this.invalidate(INVALIDATION_FLAG_ITEM_RENDERER_FACTORY);
            return;
        }

        public function get footerFactoryIDFunction():Function
        {
            return this._footerFactoryIDFunction;
        }

        public function set footerFactoryIDFunction(arg1:Function):void
        {
            if (this._footerFactoryIDFunction === arg1) 
            {
                return;
            }
            this._footerFactoryIDFunction = arg1;
            this.invalidate(INVALIDATION_FLAG_ITEM_RENDERER_FACTORY);
            return;
        }

        public function get customFooterRendererStyleName():String
        {
            return this._customFooterRendererStyleName;
        }

        public function set customFooterRendererStyleName(arg1:String):void
        {
            if (this._customFooterRendererStyleName == arg1) 
            {
                return;
            }
            this._customFooterRendererStyleName = arg1;
            this.invalidate(INVALIDATION_FLAG_ITEM_RENDERER_FACTORY);
            return;
        }

        public function get footerRendererProperties():feathers.core.PropertyProxy
        {
            return this._footerRendererProperties;
        }

        public function set footerRendererProperties(arg1:feathers.core.PropertyProxy):void
        {
            if (this._footerRendererProperties == arg1) 
            {
                return;
            }
            if (this._footerRendererProperties) 
            {
                this._footerRendererProperties.removeOnChangeCallback(this.childProperties_onChange);
            }
            this._footerRendererProperties = feathers.core.PropertyProxy(arg1);
            if (this._footerRendererProperties) 
            {
                this._footerRendererProperties.addOnChangeCallback(this.childProperties_onChange);
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function set layout(arg1:feathers.layout.ILayout):void
        {
            var loc1:*=null;
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
                if (this._layout is feathers.layout.IVariableVirtualLayout) 
                {
                    loc1 = feathers.layout.IVariableVirtualLayout(this._layout);
                    loc1.hasVariableItemDimensions = true;
                    loc1.resetVariableVirtualCache();
                }
                this._layout.addEventListener(starling.events.Event.CHANGE, this.layout_changeHandler);
            }
            this.invalidate(INVALIDATION_FLAG_LAYOUT);
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
            this._horizontalScrollPosition = arg1;
            this.invalidate(INVALIDATION_FLAG_SCROLL);
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
            this._verticalScrollPosition = arg1;
            this.invalidate(INVALIDATION_FLAG_SCROLL);
            return;
        }

        public function get requiresMeasurementOnScroll():Boolean
        {
            return this._layout.requiresLayoutOnScroll && (!(this._explicitVisibleWidth === this._explicitVisibleWidth) || !(this._explicitVisibleHeight === this._explicitVisibleHeight));
        }

        public function setSelectedLocation(arg1:int, arg2:int):void
        {
            if (this._selectedGroupIndex == arg1 && this._selectedItemIndex == arg2) 
            {
                return;
            }
            if (arg1 < 0 && arg2 >= 0 || arg1 >= 0 && arg2 < 0) 
            {
                throw new ArgumentError("To deselect items, group index and item index must both be < 0.");
            }
            this._selectedGroupIndex = arg1;
            this._selectedItemIndex = arg2;
            this.invalidate(INVALIDATION_FLAG_SELECTED);
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function getScrollPositionForIndex(arg1:int, arg2:int, arg3:flash.geom.Point=null):flash.geom.Point
        {
            if (!arg3) 
            {
                arg3 = new flash.geom.Point();
            }
            var loc1:*=this.locationToDisplayIndex(arg1, arg2);
            return this._layout.getScrollPositionForIndex(loc1, this._layoutItems, 0, 0, this._actualVisibleWidth, this._actualVisibleHeight, arg3);
        }

        public function getNearestScrollPositionForIndex(arg1:int, arg2:int, arg3:flash.geom.Point=null):flash.geom.Point
        {
            if (!arg3) 
            {
                arg3 = new flash.geom.Point();
            }
            var loc1:*=this.locationToDisplayIndex(arg1, arg2);
            return this._layout.getNearestScrollPositionForIndex(loc1, this._horizontalScrollPosition, this._verticalScrollPosition, this._layoutItems, 0, 0, this._actualVisibleWidth, this._actualVisibleHeight, arg3);
        }

        public function itemToItemRenderer(arg1:Object):feathers.controls.renderers.IGroupedListItemRenderer
        {
            return feathers.controls.renderers.IGroupedListItemRenderer(this._itemRendererMap[arg1]);
        }

        public function headerDataToHeaderRenderer(arg1:Object):feathers.controls.renderers.IGroupedListHeaderRenderer
        {
            return feathers.controls.renderers.IGroupedListHeaderRenderer(this._headerRendererMap[arg1]);
        }

        public function footerDataToFooterRenderer(arg1:Object):feathers.controls.renderers.IGroupedListFooterRenderer
        {
            return feathers.controls.renderers.IGroupedListFooterRenderer(this._footerRendererMap[arg1]);
        }

        public override function dispose():void
        {
            this.refreshInactiveRenderers(true);
            this.owner = null;
            this.dataProvider = null;
            this.layout = null;
            super.dispose();
            return;
        }

        protected override function draw():void
        {
            var loc12:*=false;
            var loc1:*=this.isInvalid(INVALIDATION_FLAG_DATA);
            var loc2:*=this.isInvalid(INVALIDATION_FLAG_SCROLL);
            var loc3:*=this.isInvalid(INVALIDATION_FLAG_SIZE);
            var loc4:*=this.isInvalid(INVALIDATION_FLAG_SELECTED);
            var loc5:*=this.isInvalid(INVALIDATION_FLAG_ITEM_RENDERER_FACTORY);
            var loc6:*=this.isInvalid(INVALIDATION_FLAG_STYLES);
            var loc7:*=this.isInvalid(INVALIDATION_FLAG_STATE);
            var loc8:*=this.isInvalid(INVALIDATION_FLAG_LAYOUT);
            if (!loc8 && loc2 && this._layout && this._layout.requiresLayoutOnScroll) 
            {
                loc8 = true;
            }
            var loc9:*=loc3 || loc1 || loc8 || loc5;
            var loc10:*=this._ignoreRendererResizing;
            this._ignoreRendererResizing = true;
            var loc11:*=this._ignoreLayoutChanges;
            this._ignoreLayoutChanges = true;
            if (loc2 || loc3) 
            {
                this.refreshViewPortBounds();
            }
            if (loc9) 
            {
                this.refreshInactiveRenderers(loc5);
            }
            if (loc1 || loc8 || loc5) 
            {
                this.refreshLayoutTypicalItem();
            }
            if (loc9) 
            {
                this.refreshRenderers();
            }
            if (loc6 || loc9) 
            {
                this.refreshHeaderRendererStyles();
                this.refreshFooterRendererStyles();
                this.refreshItemRendererStyles();
            }
            if (loc4 || loc9) 
            {
                loc12 = this._ignoreSelectionChanges;
                this._ignoreSelectionChanges = true;
                this.refreshSelection();
                this._ignoreSelectionChanges = loc12;
            }
            if (loc7 || loc9) 
            {
                this.refreshEnabled();
            }
            this._ignoreLayoutChanges = loc11;
            if (loc7 || loc4 || loc6 || loc9) 
            {
                this._layout.layout(this._layoutItems, this._viewPortBounds, this._layoutResult);
            }
            this._ignoreRendererResizing = loc10;
            this._contentX = this._layoutResult.contentX;
            this._contentY = this._layoutResult.contentY;
            this.saveMeasurements(this._layoutResult.contentWidth, this._layoutResult.contentHeight, this._layoutResult.contentWidth, this._layoutResult.contentHeight);
            this._actualVisibleWidth = this._layoutResult.viewPortWidth;
            this._actualVisibleHeight = this._layoutResult.viewPortHeight;
            this._actualMinVisibleWidth = this._layoutResult.viewPortWidth;
            this._actualMinVisibleHeight = this._layoutResult.viewPortHeight;
            this.validateRenderers();
            return;
        }

        internal function validateRenderers():void
        {
            var loc3:*=null;
            var loc1:*=this._layoutItems.length;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                loc3 = this._layoutItems[loc2] as feathers.core.IValidating;
                if (loc3) 
                {
                    loc3.validate();
                }
                ++loc2;
            }
            return;
        }

        internal function refreshEnabled():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=0;
            var loc4:*=this._layoutItems;
            for each (loc1 in loc4) 
            {
                loc2 = loc1 as feathers.core.IFeathersControl;
                if (!loc2) 
                {
                    continue;
                }
                loc2.isEnabled = this._isEnabled;
            }
            return;
        }

        internal function invalidateParent(arg1:String="all"):void
        {
            feathers.controls.Scroller(this.parent).invalidate(arg1);
            return;
        }

        internal function refreshLayoutTypicalItem():void
        {
            var loc8:*=0;
            var loc9:*=null;
            var loc10:*=false;
            var loc11:*=null;
            var loc1:*=this._layout as feathers.layout.IVirtualLayout;
            if (!loc1 || !loc1.useVirtualLayout) 
            {
                if (!this._typicalItemIsInDataProvider && this._typicalItemRenderer) 
                {
                    this.destroyItemRenderer(this._typicalItemRenderer);
                    this._typicalItemRenderer = null;
                }
                return;
            }
            var loc2:*=false;
            var loc3:*=this._typicalItem;
            var loc4:*=0;
            var loc5:*=0;
            var loc6:*=0;
            var loc7:*=0;
            if (this._dataProvider) 
            {
                if (loc3 === null) 
                {
                    loc4 = this._dataProvider.getLength();
                    if (loc4 > 0) 
                    {
                        loc8 = 0;
                        while (loc8 < loc4) 
                        {
                            loc5 = this._dataProvider.getLength(loc8);
                            if (loc5 > 0) 
                            {
                                loc2 = true;
                                loc6 = loc8;
                                loc3 = this._dataProvider.getItemAt(loc8, 0);
                            }
                            ++loc8;
                        }
                    }
                }
                else 
                {
                    this._dataProvider.getItemLocation(loc3, HELPER_VECTOR);
                    if (HELPER_VECTOR.length > 1) 
                    {
                        loc2 = true;
                        loc6 = HELPER_VECTOR[0];
                        loc7 = HELPER_VECTOR[1];
                    }
                }
            }
            if (loc3 !== null) 
            {
                loc9 = feathers.controls.renderers.IGroupedListItemRenderer(this._itemRendererMap[loc3]);
                if (loc9) 
                {
                    loc9.groupIndex = loc6;
                    loc9.itemIndex = loc7;
                }
                if (!loc9 && this._typicalItemRenderer) 
                {
                    loc10 = !this._typicalItemIsInDataProvider;
                    if (loc10) 
                    {
                        loc11 = this.getFactoryID(loc3, loc6, loc7);
                        if (this._typicalItemRenderer.factoryID !== loc11) 
                        {
                            loc10 = false;
                        }
                    }
                    if (loc10) 
                    {
                        loc9 = this._typicalItemRenderer;
                        loc9.data = loc3;
                        loc9.groupIndex = loc6;
                        loc9.itemIndex = loc7;
                    }
                }
                if (!loc9) 
                {
                    loc9 = this.createItemRenderer(loc3, 0, 0, 0, false, !loc2);
                    if (!this._typicalItemIsInDataProvider && this._typicalItemRenderer) 
                    {
                        this.destroyItemRenderer(this._typicalItemRenderer);
                        this._typicalItemRenderer = null;
                    }
                }
            }
            loc1.typicalItem = starling.display.DisplayObject(loc9);
            this._typicalItemRenderer = loc9;
            this._typicalItemIsInDataProvider = loc2;
            if (this._typicalItemRenderer && !this._typicalItemIsInDataProvider) 
            {
                this._typicalItemRenderer.addEventListener(feathers.events.FeathersEventType.RESIZE, this.itemRenderer_resizeHandler);
            }
            return;
        }

        internal function refreshItemRendererStyles():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=0;
            var loc4:*=this._layoutItems;
            for each (loc1 in loc4) 
            {
                loc2 = loc1 as feathers.controls.renderers.IGroupedListItemRenderer;
                if (!loc2) 
                {
                    continue;
                }
                this.refreshOneItemRendererStyles(loc2);
            }
            return;
        }

        internal static const HELPER_VECTOR:__AS3__.vec.Vector.<int>=new Vector.<int>(0);

        internal static const INVALIDATION_FLAG_ITEM_RENDERER_FACTORY:String="itemRendererFactory";

        internal static const FIRST_ITEM_RENDERER_FACTORY_ID:String="GroupedListDataViewPort-first";

        internal static const SINGLE_ITEM_RENDERER_FACTORY_ID:String="GroupedListDataViewPort-single";

        internal static const LAST_ITEM_RENDERER_FACTORY_ID:String="GroupedListDataViewPort-last";

        internal var _maxVisibleWidth:Number=Infinity;

        internal var _actualVisibleWidth:Number=NaN;

        internal var _explicitVisibleWidth:Number=NaN;

        internal var _actualMinVisibleHeight:Number=0;

        internal var _explicitMinVisibleHeight:Number;

        internal var _maxVisibleHeight:Number=Infinity;

        internal var _actualVisibleHeight:Number;

        internal var _explicitVisibleHeight:Number=NaN;

        protected var _contentX:Number=0;

        protected var _contentY:Number=0;

        internal var _layoutItems:__AS3__.vec.Vector.<starling.display.DisplayObject>;

        internal var _typicalItemIsInDataProvider:Boolean=false;

        internal var _typicalItemRenderer:feathers.controls.renderers.IGroupedListItemRenderer;

        internal var _unrenderedItems:__AS3__.vec.Vector.<int>;

        internal var _defaultItemRendererStorage:ItemRendererFactoryStorage;

        internal var _itemStorageMap:Object;

        internal var _itemRendererMap:flash.utils.Dictionary;

        internal var _unrenderedHeaders:__AS3__.vec.Vector.<int>;

        internal var _defaultHeaderRendererStorage:HeaderRendererFactoryStorage;

        internal var _headerStorageMap:Object;

        internal var _headerRendererMap:flash.utils.Dictionary;

        internal var _unrenderedFooters:__AS3__.vec.Vector.<int>;

        internal var _defaultFooterRendererStorage:FooterRendererFactoryStorage;

        internal var _footerStorageMap:Object;

        internal var _footerRendererMap:flash.utils.Dictionary;

        internal var _headerIndices:__AS3__.vec.Vector.<int>;

        internal var _footerIndices:__AS3__.vec.Vector.<int>;

        internal var _isScrolling:Boolean=false;

        internal var _owner:feathers.controls.GroupedList;

        internal var _updateForDataReset:Boolean=false;

        internal var _dataProvider:feathers.data.HierarchicalCollection;

        internal var _isSelectable:Boolean=true;

        internal var _selectedGroupIndex:int=-1;

        internal var _selectedItemIndex:int=-1;

        internal var _itemRendererType:Class;

        internal var _itemRendererFactory:Function;

        internal var _itemRendererFactories:Object;

        internal var _factoryIDFunction:Function;

        internal var _customItemRendererStyleName:String;

        internal var _typicalItem:Object=null;

        internal var _itemRendererProperties:feathers.core.PropertyProxy;

        internal var _firstItemRendererType:Class;

        internal var _firstItemRendererFactory:Function;

        internal var _lastItemRendererType:Class;

        internal var _lastItemRendererFactory:Function;

        internal var _customLastItemRendererStyleName:String;

        internal var _singleItemRendererType:Class;

        internal var _singleItemRendererFactory:Function;

        internal var _customSingleItemRendererStyleName:String;

        internal var _headerRendererType:Class;

        internal var _headerRendererFactory:Function;

        internal var _headerRendererFactories:Object;

        internal var _customFooterRendererStyleName:String;

        internal var _verticalScrollPosition:Number=0;

        internal var _footerRendererFactories:Object;

        internal var _headerRendererProperties:feathers.core.PropertyProxy;

        internal var _footerRendererProperties:feathers.core.PropertyProxy;

        internal var touchPointID:int=-1;

        internal var _minimumHeaderCount:int;

        internal var _minimumFooterCount:int;

        internal var _minimumFirstAndLastItemCount:int;

        internal var _minimumSingleItemCount:int;

        internal var _ignoreSelectionChanges:Boolean=false;

        internal var _footerRendererFactory:Function;

        internal var _footerFactoryIDFunction:Function;

        internal var _ignoreLayoutChanges:Boolean=false;

        internal var _ignoreRendererResizing:Boolean=false;

        internal var _minimumItemCount:int;

        internal var _customFirstItemRendererStyleName:String;

        internal var _headerFactoryIDFunction:Function;

        internal var _footerRendererType:Class;

        internal var _horizontalScrollPosition:Number=0;

        internal var _customHeaderRendererStyleName:String;

        internal var _viewPortBounds:feathers.layout.ViewPortBounds;

        internal var _layoutResult:feathers.layout.LayoutBoundsResult;

        internal var _actualMinVisibleWidth:Number=0;

        internal var _explicitMinVisibleWidth:Number;

        internal var _layout:feathers.layout.ILayout;
    }
}

import __AS3__.vec.*;
import feathers.controls.renderers.*;


class ItemRendererFactoryStorage extends Object
{
    public function ItemRendererFactoryStorage()
    {
        this.activeItemRenderers = new Vector.<feathers.controls.renderers.IGroupedListItemRenderer>(0);
        this.inactiveItemRenderers = new Vector.<feathers.controls.renderers.IGroupedListItemRenderer>(0);
        super();
        return;
    }

    public var activeItemRenderers:__AS3__.vec.Vector.<feathers.controls.renderers.IGroupedListItemRenderer>;

    public var inactiveItemRenderers:__AS3__.vec.Vector.<feathers.controls.renderers.IGroupedListItemRenderer>;
}

class HeaderRendererFactoryStorage extends Object
{
    public function HeaderRendererFactoryStorage()
    {
        this.activeHeaderRenderers = new Vector.<feathers.controls.renderers.IGroupedListHeaderRenderer>(0);
        this.inactiveHeaderRenderers = new Vector.<feathers.controls.renderers.IGroupedListHeaderRenderer>(0);
        super();
        return;
    }

    public var activeHeaderRenderers:__AS3__.vec.Vector.<feathers.controls.renderers.IGroupedListHeaderRenderer>;

    public var inactiveHeaderRenderers:__AS3__.vec.Vector.<feathers.controls.renderers.IGroupedListHeaderRenderer>;
}

class FooterRendererFactoryStorage extends Object
{
    public function FooterRendererFactoryStorage()
    {
        this.activeFooterRenderers = new Vector.<feathers.controls.renderers.IGroupedListFooterRenderer>(0);
        this.inactiveFooterRenderers = new Vector.<feathers.controls.renderers.IGroupedListFooterRenderer>(0);
        super();
        return;
    }

    public var activeFooterRenderers:__AS3__.vec.Vector.<feathers.controls.renderers.IGroupedListFooterRenderer>;

    public var inactiveFooterRenderers:__AS3__.vec.Vector.<feathers.controls.renderers.IGroupedListFooterRenderer>;
}

//  class IScreenNavigatorItem
package feathers.controls.supportClasses 
{
    import starling.display.*;
    
    public interface IScreenNavigatorItem
    {
        function get canDispose():Boolean;

        function getScreen():starling.display.DisplayObject;
    }
}


//  class IViewPort
package feathers.controls.supportClasses 
{
    import feathers.core.*;
    
    public interface IViewPort extends feathers.core.IFeathersControl
    {
        function get visibleWidth():Number;

        function set visibleWidth(arg1:Number):void;

        function get minVisibleWidth():Number;

        function set minVisibleWidth(arg1:Number):void;

        function get maxVisibleWidth():Number;

        function set maxVisibleWidth(arg1:Number):void;

        function get visibleHeight():Number;

        function set visibleHeight(arg1:Number):void;

        function get minVisibleHeight():Number;

        function set minVisibleHeight(arg1:Number):void;

        function get maxVisibleHeight():Number;

        function set maxVisibleHeight(arg1:Number):void;

        function get contentX():Number;

        function get contentY():Number;

        function get horizontalScrollPosition():Number;

        function set horizontalScrollPosition(arg1:Number):void;

        function get verticalScrollPosition():Number;

        function set verticalScrollPosition(arg1:Number):void;

        function get horizontalScrollStep():Number;

        function get verticalScrollStep():Number;

        function get requiresMeasurementOnScroll():Boolean;
    }
}


//  class LayoutViewPort
package feathers.controls.supportClasses 
{
    import feathers.controls.*;
    import feathers.core.*;
    import feathers.layout.*;
    import starling.display.*;
    
    public class LayoutViewPort extends feathers.controls.LayoutGroup implements feathers.controls.supportClasses.IViewPort
    {
        public function LayoutViewPort()
        {
            super();
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
            this._horizontalScrollPosition = arg1;
            this.invalidate(INVALIDATION_FLAG_SCROLL);
            return;
        }

        public function get minVisibleWidth():Number
        {
            if (this._explicitMinVisibleWidth !== this._explicitMinVisibleWidth) 
            {
                return this._actualMinVisibleWidth;
            }
            return this._explicitMinVisibleWidth;
        }

        public function set minVisibleWidth(arg1:Number):void
        {
            if (this._explicitMinVisibleWidth == arg1) 
            {
                return;
            }
            var loc1:*=!(arg1 === arg1);
            if (loc1 && !(this._explicitMinVisibleWidth === this._explicitMinVisibleWidth)) 
            {
                return;
            }
            var loc2:*=this._explicitMinVisibleWidth;
            this._explicitMinVisibleWidth = arg1;
            if (loc1) 
            {
                this._actualMinVisibleWidth = 0;
                this.invalidate(INVALIDATION_FLAG_SIZE);
            }
            else 
            {
                this._actualMinVisibleWidth = arg1;
                if (!(this._explicitVisibleWidth === this._explicitVisibleWidth) && (this._actualVisibleWidth < arg1 || this._actualVisibleWidth === loc2)) 
                {
                    this.invalidate(INVALIDATION_FLAG_SIZE);
                }
            }
            return;
        }

        public function get verticalScrollPosition():Number
        {
            return this._verticalScrollPosition;
        }

        public function get maxVisibleWidth():Number
        {
            return this._maxVisibleWidth;
        }

        public function set maxVisibleWidth(arg1:Number):void
        {
            if (this._maxVisibleWidth == arg1) 
            {
                return;
            }
            if (arg1 !== arg1) 
            {
                throw new ArgumentError("maxVisibleWidth cannot be NaN");
            }
            var loc1:*=this._maxVisibleWidth;
            this._maxVisibleWidth = arg1;
            if (!(this._explicitVisibleWidth === this._explicitVisibleWidth) && (this._actualVisibleWidth > arg1 || this._actualVisibleWidth === loc1)) 
            {
                this.invalidate(INVALIDATION_FLAG_SIZE);
            }
            return;
        }

        public function set verticalScrollPosition(arg1:Number):void
        {
            if (this._verticalScrollPosition == arg1) 
            {
                return;
            }
            this._verticalScrollPosition = arg1;
            this.invalidate(INVALIDATION_FLAG_SCROLL);
            return;
        }

        public function get requiresMeasurementOnScroll():Boolean
        {
            return !(this._layout === null) && this._layout.requiresLayoutOnScroll && (!(this._explicitVisibleWidth === this._explicitVisibleWidth) || !(this._explicitVisibleHeight === this._explicitVisibleHeight));
        }

        public function get visibleWidth():Number
        {
            if (this._explicitVisibleWidth !== this._explicitVisibleWidth) 
            {
                return this._actualVisibleWidth;
            }
            return this._explicitVisibleWidth;
        }

        public function set visibleWidth(arg1:Number):void
        {
            if (this._explicitVisibleWidth == arg1 || !(arg1 === arg1) && !(this._explicitVisibleWidth === this._explicitVisibleWidth)) 
            {
                return;
            }
            this._explicitVisibleWidth = arg1;
            if (this._actualVisibleWidth !== arg1) 
            {
                this.invalidate(INVALIDATION_FLAG_SIZE);
            }
            return;
        }

        public override function dispose():void
        {
            this.layout = null;
            super.dispose();
            return;
        }

        protected override function refreshViewPortBounds():void
        {
            var loc1:*=!(this._explicitVisibleWidth === this._explicitVisibleWidth);
            var loc2:*=!(this._explicitVisibleHeight === this._explicitVisibleHeight);
            var loc3:*=!(this._explicitMinVisibleWidth === this._explicitMinVisibleWidth);
            var loc4:*=!(this._explicitMinVisibleHeight === this._explicitMinVisibleHeight);
            this.viewPortBounds.x = 0;
            this.viewPortBounds.y = 0;
            this.viewPortBounds.scrollX = this._horizontalScrollPosition;
            this.viewPortBounds.scrollY = this._verticalScrollPosition;
            if (this._autoSizeMode === feathers.controls.AutoSizeMode.STAGE && loc1) 
            {
                this.viewPortBounds.explicitWidth = this.stage.stageWidth;
            }
            else 
            {
                this.viewPortBounds.explicitWidth = this._explicitVisibleWidth;
            }
            if (this._autoSizeMode === feathers.controls.AutoSizeMode.STAGE && loc2) 
            {
                this.viewPortBounds.explicitHeight = this.stage.stageHeight;
            }
            else 
            {
                this.viewPortBounds.explicitHeight = this._explicitVisibleHeight;
            }
            if (loc3) 
            {
                this.viewPortBounds.minWidth = 0;
            }
            else 
            {
                this.viewPortBounds.minWidth = this._explicitMinVisibleWidth;
            }
            if (loc4) 
            {
                this.viewPortBounds.minHeight = 0;
            }
            else 
            {
                this.viewPortBounds.minHeight = this._explicitMinVisibleHeight;
            }
            this.viewPortBounds.maxWidth = this._maxVisibleWidth;
            this.viewPortBounds.maxHeight = this._maxVisibleHeight;
            return;
        }

        public function get minVisibleHeight():Number
        {
            if (this._explicitMinVisibleHeight !== this._explicitMinVisibleHeight) 
            {
                return this._actualMinVisibleHeight;
            }
            return this._explicitMinVisibleHeight;
        }

        public function set minVisibleHeight(arg1:Number):void
        {
            if (this._explicitMinVisibleHeight == arg1) 
            {
                return;
            }
            var loc1:*=!(arg1 === arg1);
            if (loc1 && !(this._explicitMinVisibleHeight === this._explicitMinVisibleHeight)) 
            {
                return;
            }
            var loc2:*=this._explicitMinVisibleHeight;
            this._explicitMinVisibleHeight = arg1;
            if (loc1) 
            {
                this._actualMinVisibleHeight = 0;
                this.invalidate(INVALIDATION_FLAG_SIZE);
            }
            else 
            {
                this._actualMinVisibleHeight = arg1;
                if (!(this._explicitVisibleHeight === this._explicitVisibleHeight) && (this._actualVisibleHeight < arg1 || this._actualVisibleHeight === loc2)) 
                {
                    this.invalidate(INVALIDATION_FLAG_SIZE);
                }
            }
            return;
        }

        protected override function handleLayoutResult():void
        {
            var loc1:*=this._layoutResult.contentWidth;
            var loc2:*=this._layoutResult.contentHeight;
            this.saveMeasurements(loc1, loc2, loc1, loc2);
            this._contentX = this._layoutResult.contentX;
            this._contentY = this._layoutResult.contentY;
            var loc3:*=this._layoutResult.viewPortWidth;
            var loc4:*=this._layoutResult.viewPortHeight;
            this._actualVisibleWidth = loc3;
            this._actualVisibleHeight = loc4;
            this._actualMinVisibleWidth = loc3;
            this._actualMinVisibleHeight = loc4;
            return;
        }

        public function get maxVisibleHeight():Number
        {
            return this._maxVisibleHeight;
        }

        public function set maxVisibleHeight(arg1:Number):void
        {
            if (this._maxVisibleHeight == arg1) 
            {
                return;
            }
            if (arg1 !== arg1) 
            {
                throw new ArgumentError("maxVisibleHeight cannot be NaN");
            }
            var loc1:*=this._maxVisibleHeight;
            this._maxVisibleHeight = arg1;
            if (!(this._explicitVisibleHeight === this._explicitVisibleHeight) && (this._actualVisibleHeight > arg1 || this._actualVisibleHeight === loc1)) 
            {
                this.invalidate(INVALIDATION_FLAG_SIZE);
            }
            return;
        }

        protected override function handleManualLayout():void
        {
            var loc15:*=null;
            var loc16:*=NaN;
            var loc17:*=NaN;
            var loc18:*=NaN;
            var loc19:*=NaN;
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=this.viewPortBounds.explicitWidth;
            var loc4:*=loc3;
            this.doNothing();
            if (loc4 !== loc4) 
            {
                loc4 = 0;
            }
            var loc5:*=this.viewPortBounds.explicitHeight;
            var loc6:*=loc5;
            this.doNothing();
            if (loc6 !== loc6) 
            {
                loc6 = 0;
            }
            this._ignoreChildChanges = true;
            var loc7:*=this.items.length;
            var loc8:*=0;
            while (loc8 < loc7) 
            {
                loc15 = this.items[loc8];
                if (!(loc15 is feathers.layout.ILayoutDisplayObject && !feathers.layout.ILayoutDisplayObject(loc15).includeInLayout)) 
                {
                    if (loc15 is feathers.core.IValidating) 
                    {
                        feathers.core.IValidating(loc15).validate();
                    }
                    loc16 = loc15.x - loc15.pivotX;
                    loc17 = loc15.y - loc15.pivotY;
                    loc18 = loc16 + loc15.width;
                    loc19 = loc17 + loc15.height;
                    if (loc16 === loc16 && loc16 < loc1) 
                    {
                        loc1 = loc16;
                    }
                    if (loc17 === loc17 && loc17 < loc2) 
                    {
                        loc2 = loc17;
                    }
                    if (loc18 === loc18 && loc18 > loc4) 
                    {
                        loc4 = loc18;
                    }
                    if (loc19 === loc19 && loc19 > loc6) 
                    {
                        loc6 = loc19;
                    }
                }
                ++loc8;
            }
            this._contentX = loc1;
            this._contentY = loc2;
            var loc9:*=this.viewPortBounds.minWidth;
            var loc10:*=this.viewPortBounds.maxWidth;
            var loc11:*=this.viewPortBounds.minHeight;
            var loc12:*=this.viewPortBounds.maxHeight;
            var loc13:*=loc4 - loc1;
            if (loc13 < loc9) 
            {
                loc13 = loc9;
            }
            else if (loc13 > loc10) 
            {
                loc13 = loc10;
            }
            var loc14:*=loc6 - loc2;
            if (loc14 < loc11) 
            {
                loc14 = loc11;
            }
            else if (loc14 > loc12) 
            {
                loc14 = loc12;
            }
            this._ignoreChildChanges = false;
            if (loc3 === loc3) 
            {
                this._actualVisibleWidth = loc3;
            }
            else 
            {
                this._actualVisibleWidth = loc13;
            }
            if (loc5 === loc5) 
            {
                this._actualVisibleHeight = loc5;
            }
            else 
            {
                this._actualVisibleHeight = loc14;
            }
            this._layoutResult.contentX = 0;
            this._layoutResult.contentY = 0;
            this._layoutResult.contentWidth = loc13;
            this._layoutResult.contentHeight = loc14;
            this._layoutResult.viewPortWidth = loc13;
            this._layoutResult.viewPortHeight = loc14;
            return;
        }

        protected function doNothing():void
        {
            return;
        }

        public function get visibleHeight():Number
        {
            if (this._explicitVisibleHeight !== this._explicitVisibleHeight) 
            {
                return this._actualVisibleHeight;
            }
            return this._explicitVisibleHeight;
        }

        public function set visibleHeight(arg1:Number):void
        {
            if (this._explicitVisibleHeight == arg1 || !(arg1 === arg1) && !(this._explicitVisibleHeight === this._explicitVisibleHeight)) 
            {
                return;
            }
            this._explicitVisibleHeight = arg1;
            if (this._actualVisibleHeight !== arg1) 
            {
                this.invalidate(INVALIDATION_FLAG_SIZE);
            }
            return;
        }

        public function get contentX():Number
        {
            return this._contentX;
        }

        public function get contentY():Number
        {
            return this._contentY;
        }

        public function get horizontalScrollStep():Number
        {
            if (this.actualWidth < this.actualHeight) 
            {
                return this.actualWidth / 10;
            }
            return this.actualHeight / 10;
        }

        public function get verticalScrollStep():Number
        {
            if (this.actualWidth < this.actualHeight) 
            {
                return this.actualWidth / 10;
            }
            return this.actualHeight / 10;
        }

        internal var _actualMinVisibleWidth:Number=0;

        internal var _explicitMinVisibleWidth:Number;

        internal var _maxVisibleWidth:Number=Infinity;

        internal var _actualVisibleWidth:Number=0;

        internal var _explicitVisibleWidth:Number;

        internal var _actualMinVisibleHeight:Number=0;

        internal var _explicitMinVisibleHeight:Number;

        internal var _maxVisibleHeight:Number=Infinity;

        internal var _actualVisibleHeight:Number=0;

        internal var _verticalScrollPosition:Number=0;

        internal var _horizontalScrollPosition:Number=0;

        internal var _contentY:Number=0;

        internal var _contentX:Number=0;

        internal var _explicitVisibleHeight:Number;
    }
}


//  class ListDataViewPort
package feathers.controls.supportClasses 
{
    import __AS3__.vec.*;
    import feathers.controls.*;
    import feathers.controls.renderers.*;
    import feathers.core.*;
    import feathers.data.*;
    import feathers.events.*;
    import feathers.layout.*;
    import flash.errors.*;
    import flash.geom.*;
    import flash.utils.*;
    import starling.display.*;
    import starling.events.*;
    import starling.utils.*;
    
    public class ListDataViewPort extends feathers.core.FeathersControl implements feathers.controls.supportClasses.IViewPort
    {
        public function ListDataViewPort()
        {
            this._viewPortBounds = new feathers.layout.ViewPortBounds();
            this._layoutResult = new feathers.layout.LayoutBoundsResult();
            this._unrenderedData = [];
            this._layoutItems = new Vector.<starling.display.DisplayObject>(0);
            this._defaultStorage = new ItemRendererFactoryStorage();
            this._rendererMap = new flash.utils.Dictionary(true);
            super();
            this.addEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.removedFromStageHandler);
            this.addEventListener(starling.events.TouchEvent.TOUCH, this.touchHandler);
            return;
        }

        internal function invalidateParent(arg1:String="all"):void
        {
            feathers.controls.Scroller(this.parent).invalidate(arg1);
            return;
        }

        internal function validateItemRenderers():void
        {
            var loc3:*=null;
            var loc1:*=this._layoutItems.length;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                loc3 = this._layoutItems[loc2] as feathers.core.IValidating;
                if (loc3) 
                {
                    loc3.validate();
                }
                ++loc2;
            }
            return;
        }

        internal function refreshLayoutTypicalItem():void
        {
            var loc5:*=null;
            var loc6:*=false;
            var loc7:*=false;
            var loc8:*=null;
            var loc1:*=this._layout as feathers.layout.IVirtualLayout;
            if (!loc1 || !loc1.useVirtualLayout) 
            {
                if (!this._typicalItemIsInDataProvider && this._typicalItemRenderer) 
                {
                    this.destroyRenderer(this._typicalItemRenderer);
                    this._typicalItemRenderer = null;
                }
                return;
            }
            var loc2:*=0;
            var loc3:*=false;
            var loc4:*=this._typicalItem;
            if (loc4 === null) 
            {
                loc3 = true;
                if (this._dataProvider && this._dataProvider.length > 0) 
                {
                    loc4 = this._dataProvider.getItemAt(0);
                }
            }
            else 
            {
                if (this._dataProvider) 
                {
                    loc2 = this._dataProvider.getItemIndex(loc4);
                    loc3 = loc2 >= 0;
                }
                if (loc2 < 0) 
                {
                    loc2 = 0;
                }
            }
            if (loc4 !== null) 
            {
                loc5 = feathers.controls.renderers.IListItemRenderer(this._rendererMap[loc4]);
                if (loc5) 
                {
                    loc5.index = loc2;
                }
                if (!loc5 && this._typicalItemRenderer) 
                {
                    loc6 = !this._typicalItemIsInDataProvider;
                    loc7 = this._typicalItemIsInDataProvider && this._dataProvider && this._dataProvider.getItemIndex(this._typicalItemRenderer.data) < 0;
                    if (!loc6 && loc7) 
                    {
                        loc6 = true;
                    }
                    if (loc6) 
                    {
                        loc8 = null;
                        if (this._factoryIDFunction !== null) 
                        {
                            loc8 = this.getFactoryID(loc4, loc2);
                        }
                        if (this._typicalItemRenderer.factoryID !== loc8) 
                        {
                            loc6 = false;
                        }
                    }
                    if (loc6) 
                    {
                        if (this._typicalItemIsInDataProvider) 
                        {
                            delete this._rendererMap[this._typicalItemRenderer.data];
                        }
                        loc5 = this._typicalItemRenderer;
                        loc5.data = loc4;
                        loc5.index = loc2;
                        if (loc3) 
                        {
                            this._rendererMap[loc4] = loc5;
                        }
                    }
                }
                if (!loc5) 
                {
                    loc5 = this.createRenderer(loc4, loc2, false, !loc3);
                    if (!this._typicalItemIsInDataProvider && this._typicalItemRenderer) 
                    {
                        this.destroyRenderer(this._typicalItemRenderer);
                        this._typicalItemRenderer = null;
                    }
                }
            }
            loc1.typicalItem = starling.display.DisplayObject(loc5);
            this._typicalItemRenderer = loc5;
            this._typicalItemIsInDataProvider = loc3;
            if (this._typicalItemRenderer && !this._typicalItemIsInDataProvider) 
            {
                this._typicalItemRenderer.addEventListener(feathers.events.FeathersEventType.RESIZE, this.renderer_resizeHandler);
            }
            return;
        }

        internal function refreshItemRendererStyles():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=0;
            var loc4:*=this._layoutItems;
            for each (loc1 in loc4) 
            {
                loc2 = loc1 as feathers.controls.renderers.IListItemRenderer;
                if (!loc2) 
                {
                    continue;
                }
                this.refreshOneItemRendererStyles(loc2);
            }
            return;
        }

        internal function refreshOneItemRendererStyles(arg1:feathers.controls.renderers.IListItemRenderer):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=starling.display.DisplayObject(arg1);
            var loc4:*=0;
            var loc5:*=this._itemRendererProperties;
            for (loc2 in loc5) 
            {
                loc3 = this._itemRendererProperties[loc2];
                loc1[loc2] = loc3;
            }
            return;
        }

        public function get minVisibleWidth():Number
        {
            if (this._explicitMinVisibleWidth !== this._explicitMinVisibleWidth) 
            {
                return this._actualMinVisibleWidth;
            }
            return this._explicitMinVisibleWidth;
        }

        public function set minVisibleWidth(arg1:Number):void
        {
            if (this._explicitMinVisibleWidth == arg1) 
            {
                return;
            }
            var loc1:*=!(arg1 === arg1);
            if (loc1 && !(this._explicitMinVisibleWidth === this._explicitMinVisibleWidth)) 
            {
                return;
            }
            var loc2:*=this._explicitMinVisibleWidth;
            this._explicitMinVisibleWidth = arg1;
            if (loc1) 
            {
                this._actualMinVisibleWidth = 0;
                this.invalidate(INVALIDATION_FLAG_SIZE);
            }
            else 
            {
                this._actualMinVisibleWidth = arg1;
                if (!(this.explicitVisibleWidth === this.explicitVisibleWidth) && (this.actualVisibleWidth < arg1 || this.actualVisibleWidth === loc2)) 
                {
                    this.invalidate(INVALIDATION_FLAG_SIZE);
                }
            }
            return;
        }

        internal function refreshSelection():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=0;
            var loc4:*=this._layoutItems;
            for each (loc1 in loc4) 
            {
                loc2 = loc1 as feathers.controls.renderers.IListItemRenderer;
                if (!loc2) 
                {
                    continue;
                }
                loc2.isSelected = this._selectedIndices.getItemIndex(loc2.index) >= 0;
            }
            return;
        }

        public function get maxVisibleWidth():Number
        {
            return this._maxVisibleWidth;
        }

        public function set maxVisibleWidth(arg1:Number):void
        {
            if (this._maxVisibleWidth == arg1) 
            {
                return;
            }
            if (arg1 !== arg1) 
            {
                throw new ArgumentError("maxVisibleWidth cannot be NaN");
            }
            var loc1:*=this._maxVisibleWidth;
            this._maxVisibleWidth = arg1;
            if (!(this.explicitVisibleWidth === this.explicitVisibleWidth) && (this.actualVisibleWidth > arg1 || this.actualVisibleWidth === loc1)) 
            {
                this.invalidate(INVALIDATION_FLAG_SIZE);
            }
            return;
        }

        internal function refreshEnabled():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=0;
            var loc4:*=this._layoutItems;
            for each (loc1 in loc4) 
            {
                loc2 = loc1 as feathers.core.IFeathersControl;
                if (!loc2) 
                {
                    continue;
                }
                loc2.isEnabled = this._isEnabled;
            }
            return;
        }

        internal function refreshViewPortBounds():void
        {
            var loc1:*=!(this._explicitMinVisibleWidth === this._explicitMinVisibleWidth);
            var loc2:*=!(this._explicitMinVisibleHeight === this._explicitMinVisibleHeight);
            this._viewPortBounds.x = 0;
            this._viewPortBounds.y = 0;
            this._viewPortBounds.scrollX = this._horizontalScrollPosition;
            this._viewPortBounds.scrollY = this._verticalScrollPosition;
            this._viewPortBounds.explicitWidth = this.explicitVisibleWidth;
            this._viewPortBounds.explicitHeight = this.explicitVisibleHeight;
            if (loc1) 
            {
                this._viewPortBounds.minWidth = 0;
            }
            else 
            {
                this._viewPortBounds.minWidth = this._explicitMinVisibleWidth;
            }
            if (loc2) 
            {
                this._viewPortBounds.minHeight = 0;
            }
            else 
            {
                this._viewPortBounds.minHeight = this._explicitMinVisibleHeight;
            }
            this._viewPortBounds.maxWidth = this._maxVisibleWidth;
            this._viewPortBounds.maxHeight = this._maxVisibleHeight;
            return;
        }

        public function get visibleWidth():Number
        {
            return this.actualVisibleWidth;
        }

        public function set visibleWidth(arg1:Number):void
        {
            if (this.explicitVisibleWidth == arg1 || !(arg1 === arg1) && !(this.explicitVisibleWidth === this.explicitVisibleWidth)) 
            {
                return;
            }
            this.explicitVisibleWidth = arg1;
            if (this.actualVisibleWidth !== arg1) 
            {
                this.invalidate(INVALIDATION_FLAG_SIZE);
            }
            return;
        }

        internal function refreshInactiveRenderers(arg1:String, arg2:Boolean):void
        {
            var loc2:*=null;
            if (arg1 === null) 
            {
                loc2 = this._defaultStorage;
            }
            else 
            {
                loc2 = ItemRendererFactoryStorage(this._storageMap[arg1]);
            }
            var loc1:*=loc2.inactiveItemRenderers;
            loc2.inactiveItemRenderers = loc2.activeItemRenderers;
            loc2.activeItemRenderers = loc1;
            if (loc2.activeItemRenderers.length > 0) 
            {
                throw new flash.errors.IllegalOperationError("ListDataViewPort: active renderers should be empty.");
            }
            if (arg2) 
            {
                this.recoverInactiveRenderers(loc2);
                this.freeInactiveRenderers(loc2, 0);
                if (this._typicalItemRenderer && this._typicalItemRenderer.factoryID === arg1) 
                {
                    if (this._typicalItemIsInDataProvider) 
                    {
                        delete this._rendererMap[this._typicalItemRenderer.data];
                    }
                    this.destroyRenderer(this._typicalItemRenderer);
                    this._typicalItemRenderer = null;
                    this._typicalItemIsInDataProvider = false;
                }
            }
            this._layoutItems.length = 0;
            return;
        }

        public function set itemRendererProperties(arg1:feathers.core.PropertyProxy):void
        {
            if (this._itemRendererProperties == arg1) 
            {
                return;
            }
            if (this._itemRendererProperties) 
            {
                this._itemRendererProperties.removeOnChangeCallback(this.childProperties_onChange);
            }
            this._itemRendererProperties = feathers.core.PropertyProxy(arg1);
            if (this._itemRendererProperties) 
            {
                this._itemRendererProperties.addOnChangeCallback(this.childProperties_onChange);
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get minVisibleHeight():Number
        {
            if (this._explicitMinVisibleHeight !== this._explicitMinVisibleHeight) 
            {
                return this._actualMinVisibleHeight;
            }
            return this._explicitMinVisibleHeight;
        }

        public function set minVisibleHeight(arg1:Number):void
        {
            if (this._explicitMinVisibleHeight == arg1) 
            {
                return;
            }
            var loc1:*=!(arg1 === arg1);
            if (loc1 && !(this._explicitMinVisibleHeight === this._explicitMinVisibleHeight)) 
            {
                return;
            }
            var loc2:*=this._explicitMinVisibleHeight;
            this._explicitMinVisibleHeight = arg1;
            if (loc1) 
            {
                this._actualMinVisibleHeight = 0;
                this.invalidate(INVALIDATION_FLAG_SIZE);
            }
            else 
            {
                this._actualMinVisibleHeight = arg1;
                if (!(this.explicitVisibleHeight === this.explicitVisibleHeight) && (this.actualVisibleHeight < arg1 || this.actualVisibleHeight === loc2)) 
                {
                    this.invalidate(INVALIDATION_FLAG_SIZE);
                }
            }
            return;
        }

        internal function refreshRenderers():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=0;
            var loc5:*=0;
            var loc6:*=null;
            if (this._typicalItemRenderer) 
            {
                if (this._typicalItemIsInDataProvider) 
                {
                    loc1 = this.factoryIDToStorage(this._typicalItemRenderer.factoryID);
                    loc2 = loc1.inactiveItemRenderers;
                    loc3 = loc1.activeItemRenderers;
                    loc4 = loc2.indexOf(this._typicalItemRenderer);
                    if (loc4 >= 0) 
                    {
                        loc2[loc4] = null;
                    }
                    loc5 = loc3.length;
                    if (loc5 === 0) 
                    {
                        loc3[loc5] = this._typicalItemRenderer;
                    }
                }
                this.refreshOneItemRendererStyles(this._typicalItemRenderer);
            }
            this.findUnrenderedData();
            this.recoverInactiveRenderers(this._defaultStorage);
            if (this._storageMap) 
            {
                var loc7:*=0;
                var loc8:*=this._storageMap;
                for (loc6 in loc8) 
                {
                    loc1 = ItemRendererFactoryStorage(this._storageMap[loc6]);
                    this.recoverInactiveRenderers(loc1);
                }
            }
            this.renderUnrenderedData();
            this.freeInactiveRenderers(this._defaultStorage, this._minimumItemCount);
            if (this._storageMap) 
            {
                loc7 = 0;
                loc8 = this._storageMap;
                for (loc6 in loc8) 
                {
                    loc1 = ItemRendererFactoryStorage(this._storageMap[loc6]);
                    this.freeInactiveRenderers(loc1, 1);
                }
            }
            this._updateForDataReset = false;
            return;
        }

        public function get maxVisibleHeight():Number
        {
            return this._maxVisibleHeight;
        }

        public function set maxVisibleHeight(arg1:Number):void
        {
            if (this._maxVisibleHeight == arg1) 
            {
                return;
            }
            if (arg1 !== arg1) 
            {
                throw new ArgumentError("maxVisibleHeight cannot be NaN");
            }
            var loc1:*=this._maxVisibleHeight;
            this._maxVisibleHeight = arg1;
            if (!(this.explicitVisibleHeight === this.explicitVisibleHeight) && (this.actualVisibleHeight > arg1 || this.actualVisibleHeight === loc1)) 
            {
                this.invalidate(INVALIDATION_FLAG_SIZE);
            }
            return;
        }

        internal function findUnrenderedData():void
        {
            var loc7:*=null;
            var loc8:*=0;
            var loc9:*=0;
            var loc10:*=0;
            var loc11:*=0;
            var loc12:*=0;
            var loc13:*=null;
            var loc14:*=0;
            var loc15:*=null;
            var loc16:*=null;
            var loc17:*=null;
            var loc18:*=null;
            var loc19:*=null;
            var loc20:*=0;
            var loc1:*=this._dataProvider ? this._dataProvider.length : 0;
            var loc2:*=this._layout as feathers.layout.IVirtualLayout;
            var loc3:*=loc2 && loc2.useVirtualLayout;
            if (loc3) 
            {
                loc7 = starling.utils.Pool.getPoint();
                loc2.measureViewPort(loc1, this._viewPortBounds, loc7);
                loc2.getVisibleIndicesAtScrollPosition(this._horizontalScrollPosition, this._verticalScrollPosition, loc7.x, loc7.y, loc1, HELPER_VECTOR);
                starling.utils.Pool.putPoint(loc7);
            }
            var loc4:*=loc3 ? HELPER_VECTOR.length : loc1;
            if (loc3 && this._typicalItemIsInDataProvider && this._typicalItemRenderer && HELPER_VECTOR.indexOf(this._typicalItemRenderer.index) >= 0) 
            {
                this._minimumItemCount = loc4 + 1;
            }
            else 
            {
                this._minimumItemCount = loc4;
            }
            var loc5:*=this._layout is feathers.layout.ITrimmedVirtualLayout && loc3 && (!(this._layout is feathers.layout.IVariableVirtualLayout) || !feathers.layout.IVariableVirtualLayout(this._layout).hasVariableItemDimensions) && loc4 > 0;
            if (loc5) 
            {
                loc8 = HELPER_VECTOR[0];
                loc9 = loc8;
                loc10 = 1;
                while (loc10 < loc4) 
                {
                    loc14 = HELPER_VECTOR[loc10];
                    if (loc14 < loc8) 
                    {
                        loc8 = loc14;
                    }
                    if (loc14 > loc9) 
                    {
                        loc9 = loc14;
                    }
                    ++loc10;
                }
                --loc11;
                if (loc11 < 0) 
                {
                    loc11 = 0;
                }
                loc12 = (loc1 - 1) - loc9;
                loc13 = feathers.layout.ITrimmedVirtualLayout(this._layout);
                loc13.beforeVirtualizedItemCount = loc11;
                loc13.afterVirtualizedItemCount = loc12;
                this._layoutItems.length = loc1 - loc11 - loc12;
                this._layoutIndexOffset = -loc11;
            }
            else 
            {
                this._layoutIndexOffset = 0;
                this._layoutItems.length = loc1;
            }
            var loc6:*=this._unrenderedData.length;
            loc10 = 0;
            while (loc10 < loc4) 
            {
                loc14 = loc3 ? HELPER_VECTOR[loc10] : loc10;
                if (!(loc14 < 0 || loc14 >= loc1)) 
                {
                    loc15 = this._dataProvider.getItemAt(loc14);
                    loc16 = feathers.controls.renderers.IListItemRenderer(this._rendererMap[loc15]);
                    if (loc16) 
                    {
                        loc16.index = loc14;
                        loc16.visible = true;
                        if (this._updateForDataReset) 
                        {
                            loc16.data = null;
                            loc16.data = loc15;
                        }
                        if (this._typicalItemRenderer != loc16) 
                        {
                            loc17 = this.factoryIDToStorage(loc16.factoryID);
                            loc18 = loc17.activeItemRenderers;
                            loc19 = loc17.inactiveItemRenderers;
                            loc18[loc18.length] = loc16;
                            loc20 = loc19.indexOf(loc16);
                            if (loc20 >= 0) 
                            {
                                loc19[loc20] = null;
                            }
                            else 
                            {
                                throw new flash.errors.IllegalOperationError("ListDataViewPort: renderer map contains bad data. This may be caused by duplicate items in the data provider, which is not allowed.");
                            }
                        }
                        this._layoutItems[loc14 + this._layoutIndexOffset] = starling.display.DisplayObject(loc16);
                    }
                    else 
                    {
                        this._unrenderedData[loc6] = loc15;
                        ++loc6;
                    }
                }
                ++loc10;
            }
            if (this._typicalItemRenderer) 
            {
                if (loc3 && this._typicalItemIsInDataProvider) 
                {
                    loc14 = HELPER_VECTOR.indexOf(this._typicalItemRenderer.index);
                    if (loc14 >= 0) 
                    {
                        this._typicalItemRenderer.visible = true;
                    }
                    else 
                    {
                        this._typicalItemRenderer.visible = false;
                    }
                }
                else 
                {
                    this._typicalItemRenderer.visible = this._typicalItemIsInDataProvider;
                }
            }
            HELPER_VECTOR.length = 0;
            return;
        }

        internal function renderUnrenderedData():void
        {
            var loc3:*=null;
            var loc4:*=0;
            var loc5:*=null;
            var loc1:*=this._unrenderedData.length;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                loc3 = this._unrenderedData.shift();
                loc4 = this._dataProvider.getItemIndex(loc3);
                loc5 = this.createRenderer(loc3, loc4, true, false);
                loc5.visible = true;
                this._layoutItems[loc4 + this._layoutIndexOffset] = starling.display.DisplayObject(loc5);
                ++loc2;
            }
            return;
        }

        public function get visibleHeight():Number
        {
            return this.actualVisibleHeight;
        }

        public function set visibleHeight(arg1:Number):void
        {
            if (this.explicitVisibleHeight == arg1 || !(arg1 === arg1) && !(this.explicitVisibleHeight === this.explicitVisibleHeight)) 
            {
                return;
            }
            this.explicitVisibleHeight = arg1;
            if (this.actualVisibleHeight !== arg1) 
            {
                this.invalidate(INVALIDATION_FLAG_SIZE);
            }
            return;
        }

        internal function recoverInactiveRenderers(arg1:ItemRendererFactoryStorage):void
        {
            var loc4:*=null;
            var loc1:*=arg1.inactiveItemRenderers;
            var loc2:*=loc1.length;
            var loc3:*=0;
            while (loc3 < loc2) 
            {
                loc4 = loc1[loc3];
                if (!(!loc4 || loc4.index < 0)) 
                {
                    this._owner.dispatchEventWith(feathers.events.FeathersEventType.RENDERER_REMOVE, false, loc4);
                    delete this._rendererMap[loc4.data];
                }
                ++loc3;
            }
            return;
        }

        public function get contentX():Number
        {
            return this._contentX;
        }

        internal function freeInactiveRenderers(arg1:ItemRendererFactoryStorage, arg2:int):void
        {
            var loc7:*=null;
            var loc1:*=arg1.inactiveItemRenderers;
            var loc2:*=arg1.activeItemRenderers;
            var loc3:*=loc2.length;
            var loc4:*=loc1.length;
            var loc5:*=arg2 - loc3;
            if (loc5 > loc4) 
            {
                loc5 = loc4;
            }
            var loc6:*=0;
            while (loc6 < loc5) 
            {
                loc7 = loc1.shift();
                if (loc7) 
                {
                    loc7.data = null;
                    loc7.index = -1;
                    loc7.visible = false;
                    loc2[loc3] = loc7;
                    ++loc3;
                }
                else 
                {
                    ++loc5;
                    if (loc4 < loc5) 
                    {
                        loc5 = loc4;
                    }
                }
                ++loc6;
            }
            loc4 = loc4 - loc5;
            loc6 = 0;
            while (loc6 < loc4) 
            {
                loc7 = loc1.shift();
                if (loc7) 
                {
                    this.destroyRenderer(loc7);
                }
                ++loc6;
            }
            return;
        }

        public function get contentY():Number
        {
            return this._contentY;
        }

        internal function createRenderer(arg1:Object, arg2:int, arg3:Boolean, arg4:Boolean):feathers.controls.renderers.IListItemRenderer
        {
            var loc6:*=null;
            var loc1:*=null;
            if (this._factoryIDFunction !== null) 
            {
                loc1 = this.getFactoryID(arg1, arg2);
            }
            var loc2:*=this.factoryIDToFactory(loc1);
            var loc3:*=this.factoryIDToStorage(loc1);
            var loc4:*=loc3.inactiveItemRenderers;
            var loc5:*=loc3.activeItemRenderers;
            do 
            {
                if (!arg3 || arg4 || loc4.length === 0) 
                {
                    if (loc2 === null) 
                    {
                        loc6 = feathers.controls.renderers.IListItemRenderer(new this._itemRendererType());
                    }
                    else 
                    {
                        loc6 = feathers.controls.renderers.IListItemRenderer(loc2());
                    }
                    if (this._customItemRendererStyleName && this._customItemRendererStyleName.length > 0) 
                    {
                        loc6.styleNameList.add(this._customItemRendererStyleName);
                    }
                    this.addChild(starling.display.DisplayObject(loc6));
                }
                else 
                {
                    loc6 = loc4.shift();
                }
            }
            while (!loc6);
            loc6.data = arg1;
            loc6.index = arg2;
            loc6.owner = this._owner;
            loc6.factoryID = loc1;
            if (!arg4) 
            {
                this._rendererMap[arg1] = loc6;
                loc5[loc5.length] = loc6;
                loc6.addEventListener(starling.events.Event.TRIGGERED, this.renderer_triggeredHandler);
                loc6.addEventListener(starling.events.Event.CHANGE, this.renderer_changeHandler);
                loc6.addEventListener(feathers.events.FeathersEventType.RESIZE, this.renderer_resizeHandler);
                this._owner.dispatchEventWith(feathers.events.FeathersEventType.RENDERER_ADD, false, loc6);
            }
            return loc6;
        }

        internal function destroyRenderer(arg1:feathers.controls.renderers.IListItemRenderer):void
        {
            arg1.removeEventListener(starling.events.Event.TRIGGERED, this.renderer_triggeredHandler);
            arg1.removeEventListener(starling.events.Event.CHANGE, this.renderer_changeHandler);
            arg1.removeEventListener(feathers.events.FeathersEventType.RESIZE, this.renderer_resizeHandler);
            arg1.owner = null;
            arg1.data = null;
            arg1.factoryID = null;
            this.removeChild(starling.display.DisplayObject(arg1), true);
            return;
        }

        internal function getFactoryID(arg1:Object, arg2:int):String
        {
            if (this._factoryIDFunction === null) 
            {
                return null;
            }
            if (this._factoryIDFunction.length === 1) 
            {
                return this._factoryIDFunction(arg1);
            }
            return this._factoryIDFunction(arg1, arg2);
        }

        internal function factoryIDToFactory(arg1:String):Function
        {
            if (arg1 !== null) 
            {
                if (arg1 in this._itemRendererFactories) 
                {
                    return this._itemRendererFactories[arg1] as Function;
                }
                throw new ReferenceError("Cannot find item renderer factory for ID \"" + arg1 + "\".");
            }
            return this._itemRendererFactory;
        }

        internal function factoryIDToStorage(arg1:String):ItemRendererFactoryStorage
        {
            var loc1:*=null;
            if (arg1 !== null) 
            {
                if (arg1 in this._storageMap) 
                {
                    return ItemRendererFactoryStorage(this._storageMap[arg1]);
                }
                loc1 = new ItemRendererFactoryStorage();
                this._storageMap[arg1] = loc1;
                return loc1;
            }
            return this._defaultStorage;
        }

        internal function childProperties_onChange(arg1:feathers.core.PropertyProxy, arg2:String):void
        {
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        internal function dataProvider_changeHandler(arg1:starling.events.Event):void
        {
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        internal function dataProvider_addItemHandler(arg1:starling.events.Event, arg2:int):void
        {
            var loc1:*=this._layout as feathers.layout.IVariableVirtualLayout;
            if (!loc1 || !loc1.hasVariableItemDimensions) 
            {
                return;
            }
            loc1.addToVariableVirtualCacheAtIndex(arg2);
            return;
        }

        internal function dataProvider_removeItemHandler(arg1:starling.events.Event, arg2:int):void
        {
            var loc1:*=this._layout as feathers.layout.IVariableVirtualLayout;
            if (!loc1 || !loc1.hasVariableItemDimensions) 
            {
                return;
            }
            loc1.removeFromVariableVirtualCacheAtIndex(arg2);
            return;
        }

        internal function dataProvider_replaceItemHandler(arg1:starling.events.Event, arg2:int):void
        {
            var loc1:*=this._layout as feathers.layout.IVariableVirtualLayout;
            if (!loc1 || !loc1.hasVariableItemDimensions) 
            {
                return;
            }
            loc1.resetVariableVirtualCacheAtIndex(arg2);
            return;
        }

        internal function dataProvider_resetHandler(arg1:starling.events.Event):void
        {
            this._updateForDataReset = true;
            var loc1:*=this._layout as feathers.layout.IVariableVirtualLayout;
            if (!loc1 || !loc1.hasVariableItemDimensions) 
            {
                return;
            }
            loc1.resetVariableVirtualCache();
            return;
        }

        public function get owner():feathers.controls.List
        {
            return this._owner;
        }

        public function set owner(arg1:feathers.controls.List):void
        {
            if (this._owner == arg1) 
            {
                return;
            }
            if (this._owner) 
            {
                this._owner.removeEventListener(feathers.events.FeathersEventType.SCROLL_START, this.owner_scrollStartHandler);
            }
            this._owner = arg1;
            if (this._owner) 
            {
                this._owner.addEventListener(feathers.events.FeathersEventType.SCROLL_START, this.owner_scrollStartHandler);
            }
            return;
        }

        internal function dataProvider_updateItemHandler(arg1:starling.events.Event, arg2:int):void
        {
            var loc1:*=this._dataProvider.getItemAt(arg2);
            var loc2:*=feathers.controls.renderers.IListItemRenderer(this._rendererMap[loc1]);
            if (loc2 === null) 
            {
                return;
            }
            loc2.data = null;
            loc2.data = loc1;
            if (!(this.explicitVisibleWidth === this.explicitVisibleWidth) || !(this.explicitVisibleHeight === this.explicitVisibleHeight)) 
            {
                this.invalidate(INVALIDATION_FLAG_SIZE);
                this.invalidateParent(INVALIDATION_FLAG_SIZE);
            }
            return;
        }

        internal function dataProvider_updateAllHandler(arg1:starling.events.Event):void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=0;
            var loc4:*=this._rendererMap;
            for (loc1 in loc4) 
            {
                loc2 = feathers.controls.renderers.IListItemRenderer(this._rendererMap[loc1]);
                if (loc2 === null) 
                {
                    continue;
                }
                loc2.data = null;
                loc2.data = loc1;
            }
            if (!(this.explicitVisibleWidth === this.explicitVisibleWidth) || !(this.explicitVisibleHeight === this.explicitVisibleHeight)) 
            {
                this.invalidate(INVALIDATION_FLAG_SIZE);
                this.invalidateParent(INVALIDATION_FLAG_SIZE);
            }
            return;
        }

        public function get dataProvider():feathers.data.ListCollection
        {
            return this._dataProvider;
        }

        public function set dataProvider(arg1:feathers.data.ListCollection):void
        {
            if (this._dataProvider == arg1) 
            {
                return;
            }
            if (this._dataProvider) 
            {
                this._dataProvider.removeEventListener(starling.events.Event.CHANGE, this.dataProvider_changeHandler);
                this._dataProvider.removeEventListener(feathers.events.CollectionEventType.RESET, this.dataProvider_resetHandler);
                this._dataProvider.removeEventListener(feathers.events.CollectionEventType.ADD_ITEM, this.dataProvider_addItemHandler);
                this._dataProvider.removeEventListener(feathers.events.CollectionEventType.REMOVE_ITEM, this.dataProvider_removeItemHandler);
                this._dataProvider.removeEventListener(feathers.events.CollectionEventType.REPLACE_ITEM, this.dataProvider_replaceItemHandler);
                this._dataProvider.removeEventListener(feathers.events.CollectionEventType.UPDATE_ITEM, this.dataProvider_updateItemHandler);
                this._dataProvider.removeEventListener(feathers.events.CollectionEventType.UPDATE_ALL, this.dataProvider_updateAllHandler);
            }
            this._dataProvider = arg1;
            if (this._dataProvider) 
            {
                this._dataProvider.addEventListener(starling.events.Event.CHANGE, this.dataProvider_changeHandler);
                this._dataProvider.addEventListener(feathers.events.CollectionEventType.RESET, this.dataProvider_resetHandler);
                this._dataProvider.addEventListener(feathers.events.CollectionEventType.ADD_ITEM, this.dataProvider_addItemHandler);
                this._dataProvider.addEventListener(feathers.events.CollectionEventType.REMOVE_ITEM, this.dataProvider_removeItemHandler);
                this._dataProvider.addEventListener(feathers.events.CollectionEventType.REPLACE_ITEM, this.dataProvider_replaceItemHandler);
                this._dataProvider.addEventListener(feathers.events.CollectionEventType.UPDATE_ITEM, this.dataProvider_updateItemHandler);
                this._dataProvider.addEventListener(feathers.events.CollectionEventType.UPDATE_ALL, this.dataProvider_updateAllHandler);
            }
            if (this._layout is feathers.layout.IVariableVirtualLayout) 
            {
                feathers.layout.IVariableVirtualLayout(this._layout).resetVariableVirtualCache();
            }
            this._updateForDataReset = true;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        internal function layout_changeHandler(arg1:starling.events.Event):void
        {
            if (this._ignoreLayoutChanges) 
            {
                return;
            }
            this.invalidate(INVALIDATION_FLAG_LAYOUT);
            this.invalidateParent(INVALIDATION_FLAG_LAYOUT);
            return;
        }

        public function get itemRendererType():Class
        {
            return this._itemRendererType;
        }

        public function set itemRendererType(arg1:Class):void
        {
            if (this._itemRendererType == arg1) 
            {
                return;
            }
            this._itemRendererType = arg1;
            this.invalidate(INVALIDATION_FLAG_ITEM_RENDERER_FACTORY);
            return;
        }

        internal function renderer_resizeHandler(arg1:starling.events.Event):void
        {
            if (this._ignoreRendererResizing) 
            {
                return;
            }
            this.invalidate(INVALIDATION_FLAG_LAYOUT);
            this.invalidateParent(INVALIDATION_FLAG_LAYOUT);
            if (arg1.currentTarget === this._typicalItemRenderer && !this._typicalItemIsInDataProvider) 
            {
                return;
            }
            var loc1:*=this._layout as feathers.layout.IVariableVirtualLayout;
            if (!loc1 || !loc1.hasVariableItemDimensions) 
            {
                return;
            }
            var loc2:*=feathers.controls.renderers.IListItemRenderer(arg1.currentTarget);
            loc1.resetVariableVirtualCacheAtIndex(loc2.index, starling.display.DisplayObject(loc2));
            return;
        }

        public function get itemRendererFactory():Function
        {
            return this._itemRendererFactory;
        }

        public function set itemRendererFactory(arg1:Function):void
        {
            if (this._itemRendererFactory === arg1) 
            {
                return;
            }
            this._itemRendererFactory = arg1;
            this.invalidate(INVALIDATION_FLAG_ITEM_RENDERER_FACTORY);
            return;
        }

        internal function renderer_triggeredHandler(arg1:starling.events.Event):void
        {
            var loc1:*=feathers.controls.renderers.IListItemRenderer(arg1.currentTarget);
            this.parent.dispatchEventWith(starling.events.Event.TRIGGERED, false, loc1.data);
            return;
        }

        public function get itemRendererFactories():Object
        {
            return this._itemRendererFactories;
        }

        public function set itemRendererFactories(arg1:Object):void
        {
            if (this._itemRendererFactories === arg1) 
            {
                return;
            }
            this._itemRendererFactories = arg1;
            if (arg1 !== null) 
            {
                this._storageMap = {};
            }
            this.invalidate(INVALIDATION_FLAG_ITEM_RENDERER_FACTORY);
            return;
        }

        internal function renderer_changeHandler(arg1:starling.events.Event):void
        {
            var loc4:*=0;
            if (this._ignoreSelectionChanges) 
            {
                return;
            }
            var loc1:*=feathers.controls.renderers.IListItemRenderer(arg1.currentTarget);
            if (!this._isSelectable || this._isScrolling) 
            {
                loc1.isSelected = false;
                return;
            }
            var loc2:*=loc1.isSelected;
            var loc3:*=loc1.index;
            if (this._allowMultipleSelection) 
            {
                loc4 = this._selectedIndices.getItemIndex(loc3);
                if (loc2 && loc4 < 0) 
                {
                    this._selectedIndices.addItem(loc3);
                }
                else if (!loc2 && loc4 >= 0) 
                {
                    this._selectedIndices.removeItemAt(loc4);
                }
            }
            else if (loc2) 
            {
                new Vector.<int>(1)[0] = loc3;
                this._selectedIndices.data = new Vector.<int>(1);
            }
            else 
            {
                this._selectedIndices.removeAll();
            }
            return;
        }

        public function get factoryIDFunction():Function
        {
            return this._factoryIDFunction;
        }

        public function set factoryIDFunction(arg1:Function):void
        {
            if (this._factoryIDFunction === arg1) 
            {
                return;
            }
            this._factoryIDFunction = arg1;
            this.invalidate(INVALIDATION_FLAG_ITEM_RENDERER_FACTORY);
            return;
        }

        internal function selectedIndices_changeHandler(arg1:starling.events.Event):void
        {
            this.invalidate(INVALIDATION_FLAG_SELECTED);
            return;
        }

        public function get customItemRendererStyleName():String
        {
            return this._customItemRendererStyleName;
        }

        public function set customItemRendererStyleName(arg1:String):void
        {
            if (this._customItemRendererStyleName == arg1) 
            {
                return;
            }
            this._customItemRendererStyleName = arg1;
            this.invalidate(INVALIDATION_FLAG_ITEM_RENDERER_FACTORY);
            return;
        }

        internal function removedFromStageHandler(arg1:starling.events.Event):void
        {
            this.touchPointID = -1;
            return;
        }

        public function get typicalItem():Object
        {
            return this._typicalItem;
        }

        public function set typicalItem(arg1:Object):void
        {
            if (this._typicalItem == arg1) 
            {
                return;
            }
            this._typicalItem = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        internal function touchHandler(arg1:starling.events.TouchEvent):void
        {
            var loc1:*=null;
            if (!this._isEnabled) 
            {
                this.touchPointID = -1;
                return;
            }
            if (this.touchPointID >= 0) 
            {
                loc1 = arg1.getTouch(this, starling.events.TouchPhase.ENDED, this.touchPointID);
                if (!loc1) 
                {
                    return;
                }
                this.touchPointID = -1;
            }
            else 
            {
                loc1 = arg1.getTouch(this, starling.events.TouchPhase.BEGAN);
                if (!loc1) 
                {
                    return;
                }
                this.touchPointID = loc1.id;
                this._isScrolling = false;
            }
            return;
        }

        public function get itemRendererProperties():feathers.core.PropertyProxy
        {
            return this._itemRendererProperties;
        }

        internal function owner_scrollStartHandler(arg1:starling.events.Event):void
        {
            this._isScrolling = true;
            return;
        }

        public function get layout():feathers.layout.ILayout
        {
            return this._layout;
        }

        public function set layout(arg1:feathers.layout.ILayout):void
        {
            if (this._layout == arg1) 
            {
                return;
            }
            if (this._layout) 
            {
                starling.events.EventDispatcher(this._layout).removeEventListener(starling.events.Event.CHANGE, this.layout_changeHandler);
            }
            this._layout = arg1;
            if (this._layout) 
            {
                if (this._layout is feathers.layout.IVariableVirtualLayout) 
                {
                    feathers.layout.IVariableVirtualLayout(this._layout).resetVariableVirtualCache();
                }
                starling.events.EventDispatcher(this._layout).addEventListener(starling.events.Event.CHANGE, this.layout_changeHandler);
            }
            this.invalidate(INVALIDATION_FLAG_LAYOUT);
            return;
        }

        public function get horizontalScrollStep():Number
        {
            if (this._typicalItemRenderer === null) 
            {
                return 0;
            }
            var loc1:*=this._typicalItemRenderer.width;
            var loc2:*=this._typicalItemRenderer.height;
            if (loc1 < loc2) 
            {
                return loc1;
            }
            return loc2;
        }

        public function get verticalScrollStep():Number
        {
            if (this._typicalItemRenderer === null) 
            {
                return 0;
            }
            var loc1:*=this._typicalItemRenderer.width;
            var loc2:*=this._typicalItemRenderer.height;
            if (loc1 < loc2) 
            {
                return loc1;
            }
            return loc2;
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
            this._horizontalScrollPosition = arg1;
            this.invalidate(INVALIDATION_FLAG_SCROLL);
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
            this._verticalScrollPosition = arg1;
            this.invalidate(INVALIDATION_FLAG_SCROLL);
            return;
        }

        public function get isSelectable():Boolean
        {
            return this._isSelectable;
        }

        public function set isSelectable(arg1:Boolean):void
        {
            if (this._isSelectable == arg1) 
            {
                return;
            }
            this._isSelectable = arg1;
            if (!arg1) 
            {
                this.selectedIndices = null;
            }
            return;
        }

        public function get allowMultipleSelection():Boolean
        {
            return this._allowMultipleSelection;
        }

        public function set allowMultipleSelection(arg1:Boolean):void
        {
            this._allowMultipleSelection = arg1;
            return;
        }

        public function get selectedIndices():feathers.data.ListCollection
        {
            return this._selectedIndices;
        }

        public function set selectedIndices(arg1:feathers.data.ListCollection):void
        {
            if (this._selectedIndices == arg1) 
            {
                return;
            }
            if (this._selectedIndices) 
            {
                this._selectedIndices.removeEventListener(starling.events.Event.CHANGE, this.selectedIndices_changeHandler);
            }
            this._selectedIndices = arg1;
            if (this._selectedIndices) 
            {
                this._selectedIndices.addEventListener(starling.events.Event.CHANGE, this.selectedIndices_changeHandler);
            }
            this.invalidate(INVALIDATION_FLAG_SELECTED);
            return;
        }

        public function get requiresMeasurementOnScroll():Boolean
        {
            return this._layout.requiresLayoutOnScroll && (!(this.explicitVisibleWidth === this.explicitVisibleWidth) || !(this.explicitVisibleHeight === this.explicitVisibleHeight));
        }

        public function getScrollPositionForIndex(arg1:int, arg2:flash.geom.Point=null):flash.geom.Point
        {
            if (!arg2) 
            {
                arg2 = new flash.geom.Point();
            }
            return this._layout.getScrollPositionForIndex(arg1, this._layoutItems, 0, 0, this.actualVisibleWidth, this.actualVisibleHeight, arg2);
        }

        public function getNearestScrollPositionForIndex(arg1:int, arg2:flash.geom.Point=null):flash.geom.Point
        {
            if (!arg2) 
            {
                arg2 = new flash.geom.Point();
            }
            return this._layout.getNearestScrollPositionForIndex(arg1, this._horizontalScrollPosition, this._verticalScrollPosition, this._layoutItems, 0, 0, this.actualVisibleWidth, this.actualVisibleHeight, arg2);
        }

        public function itemToItemRenderer(arg1:Object):feathers.controls.renderers.IListItemRenderer
        {
            return feathers.controls.renderers.IListItemRenderer(this._rendererMap[arg1]);
        }

        public override function dispose():void
        {
            var loc1:*=null;
            this.refreshInactiveRenderers(null, true);
            if (this._storageMap) 
            {
                var loc2:*=0;
                var loc3:*=this._storageMap;
                for (loc1 in loc3) 
                {
                    this.refreshInactiveRenderers(loc1, true);
                }
            }
            this.owner = null;
            this.layout = null;
            this.dataProvider = null;
            super.dispose();
            return;
        }

        protected override function draw():void
        {
            var loc12:*=null;
            var loc13:*=false;
            var loc1:*=this.isInvalid(INVALIDATION_FLAG_DATA);
            var loc2:*=this.isInvalid(INVALIDATION_FLAG_SCROLL);
            var loc3:*=this.isInvalid(INVALIDATION_FLAG_SIZE);
            var loc4:*=this.isInvalid(INVALIDATION_FLAG_SELECTED);
            var loc5:*=this.isInvalid(INVALIDATION_FLAG_ITEM_RENDERER_FACTORY);
            var loc6:*=this.isInvalid(INVALIDATION_FLAG_STYLES);
            var loc7:*=this.isInvalid(INVALIDATION_FLAG_STATE);
            var loc8:*=this.isInvalid(INVALIDATION_FLAG_LAYOUT);
            if (!loc8 && loc2 && this._layout && this._layout.requiresLayoutOnScroll) 
            {
                loc8 = true;
            }
            var loc9:*=loc3 || loc1 || loc8 || loc5;
            var loc10:*=this._ignoreRendererResizing;
            this._ignoreRendererResizing = true;
            var loc11:*=this._ignoreLayoutChanges;
            this._ignoreLayoutChanges = true;
            if (loc2 || loc3) 
            {
                this.refreshViewPortBounds();
            }
            if (loc9) 
            {
                this.refreshInactiveRenderers(null, loc5);
                if (this._storageMap) 
                {
                    var loc14:*=0;
                    var loc15:*=this._storageMap;
                    for (loc12 in loc15) 
                    {
                        this.refreshInactiveRenderers(loc12, loc5);
                    }
                }
            }
            if (loc1 || loc8 || loc5) 
            {
                this.refreshLayoutTypicalItem();
            }
            if (loc9) 
            {
                this.refreshRenderers();
            }
            if (loc6 || loc9) 
            {
                this.refreshItemRendererStyles();
            }
            if (loc4 || loc9) 
            {
                loc13 = this._ignoreSelectionChanges;
                this._ignoreSelectionChanges = true;
                this.refreshSelection();
                this._ignoreSelectionChanges = loc13;
            }
            if (loc7 || loc9) 
            {
                this.refreshEnabled();
            }
            this._ignoreLayoutChanges = loc11;
            if (loc7 || loc4 || loc6 || loc9) 
            {
                this._layout.layout(this._layoutItems, this._viewPortBounds, this._layoutResult);
            }
            this._ignoreRendererResizing = loc10;
            this._contentX = this._layoutResult.contentX;
            this._contentY = this._layoutResult.contentY;
            this.saveMeasurements(this._layoutResult.contentWidth, this._layoutResult.contentHeight, this._layoutResult.contentWidth, this._layoutResult.contentHeight);
            this.actualVisibleWidth = this._layoutResult.viewPortWidth;
            this.actualVisibleHeight = this._layoutResult.viewPortHeight;
            this._actualMinVisibleWidth = this._layoutResult.viewPortWidth;
            this._actualMinVisibleHeight = this._layoutResult.viewPortHeight;
            this.validateItemRenderers();
            return;
        }

        internal static const HELPER_VECTOR:__AS3__.vec.Vector.<int>=new Vector.<int>(0);

        internal static const INVALIDATION_FLAG_ITEM_RENDERER_FACTORY:String="itemRendererFactory";

        internal var _layoutResult:feathers.layout.LayoutBoundsResult;

        internal var _actualMinVisibleWidth:Number=0;

        internal var _explicitMinVisibleWidth:Number;

        internal var _maxVisibleWidth:Number=Infinity;

        internal var actualVisibleWidth:Number=0;

        internal var explicitVisibleWidth:Number=NaN;

        internal var _actualMinVisibleHeight:Number=0;

        internal var _maxVisibleHeight:Number=Infinity;

        internal var actualVisibleHeight:Number=0;

        internal var explicitVisibleHeight:Number=NaN;

        protected var _contentX:Number=0;

        protected var _contentY:Number=0;

        internal var _typicalItemIsInDataProvider:Boolean=false;

        internal var _typicalItemRenderer:feathers.controls.renderers.IListItemRenderer;

        internal var _unrenderedData:Array;

        internal var _layoutItems:__AS3__.vec.Vector.<starling.display.DisplayObject>;

        internal var _defaultStorage:ItemRendererFactoryStorage;

        internal var _storageMap:Object;

        internal var _rendererMap:flash.utils.Dictionary;

        internal var _minimumItemCount:int;

        internal var _layoutIndexOffset:int=0;

        internal var _isScrolling:Boolean=false;

        internal var _owner:feathers.controls.List;

        internal var _updateForDataReset:Boolean=false;

        internal var _dataProvider:feathers.data.ListCollection;

        internal var _itemRendererType:Class;

        internal var _itemRendererFactory:Function;

        internal var _itemRendererFactories:Object;

        internal var _factoryIDFunction:Function;

        internal var _customItemRendererStyleName:String;

        internal var _typicalItem:Object=null;

        internal var _itemRendererProperties:feathers.core.PropertyProxy;

        internal var _allowMultipleSelection:Boolean=false;

        internal var touchPointID:int=-1;

        internal var _ignoreLayoutChanges:Boolean=false;

        internal var _selectedIndices:feathers.data.ListCollection;

        internal var _horizontalScrollPosition:Number=0;

        internal var _explicitMinVisibleHeight:Number;

        internal var _verticalScrollPosition:Number=0;

        internal var _isSelectable:Boolean=true;

        internal var _ignoreRendererResizing:Boolean=false;

        internal var _layout:feathers.layout.ILayout;

        internal var _viewPortBounds:feathers.layout.ViewPortBounds;

        internal var _ignoreSelectionChanges:Boolean=false;
    }
}

import __AS3__.vec.*;
import feathers.controls.renderers.*;


class ItemRendererFactoryStorage extends Object
{
    public function ItemRendererFactoryStorage()
    {
        this.activeItemRenderers = new Vector.<feathers.controls.renderers.IListItemRenderer>(0);
        this.inactiveItemRenderers = new Vector.<feathers.controls.renderers.IListItemRenderer>(0);
        super();
        return;
    }

    public var activeItemRenderers:__AS3__.vec.Vector.<feathers.controls.renderers.IListItemRenderer>;

    public var inactiveItemRenderers:__AS3__.vec.Vector.<feathers.controls.renderers.IListItemRenderer>;
}

//  class TextFieldViewPort
package feathers.controls.supportClasses 
{
    import feathers.core.*;
    import feathers.text.*;
    import feathers.utils.geom.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import starling.core.*;
    import starling.display.*;
    import starling.events.*;
    import starling.rendering.*;
    import starling.text.*;
    import starling.utils.*;
    
    public class TextFieldViewPort extends feathers.core.FeathersControl implements feathers.controls.supportClasses.IViewPort
    {
        public function TextFieldViewPort()
        {
            super();
            this.addEventListener(starling.events.Event.ADDED_TO_STAGE, this.addedToStageHandler);
            this.addEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.removedFromStageHandler);
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
            this._horizontalScrollPosition = arg1;
            this.invalidate(INVALIDATION_FLAG_SCROLL);
            return;
        }

        public function get verticalScrollPosition():Number
        {
            return this._verticalScrollPosition;
        }

        public function get text():String
        {
            return this._text;
        }

        public function set text(arg1:String):void
        {
            if (!arg1) 
            {
                arg1 = "";
            }
            if (this._text == arg1) 
            {
                return;
            }
            this._text = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        public function set verticalScrollPosition(arg1:Number):void
        {
            if (this._verticalScrollPosition == arg1) 
            {
                return;
            }
            this._verticalScrollPosition = arg1;
            this.invalidate(INVALIDATION_FLAG_SCROLL);
            return;
        }

        public function get isHTML():Boolean
        {
            return this._isHTML;
        }

        public function set isHTML(arg1:Boolean):void
        {
            if (this._isHTML == arg1) 
            {
                return;
            }
            this._isHTML = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        public function get requiresMeasurementOnScroll():Boolean
        {
            return false;
        }

        public function get paddingTop():Number
        {
            return this._paddingTop;
        }

        public function get fontStyles():feathers.text.FontStylesSet
        {
            return this._fontStyles;
        }

        public function set fontStyles(arg1:feathers.text.FontStylesSet):void
        {
            if (this._fontStyles === arg1) 
            {
                return;
            }
            if (this._fontStyles !== null) 
            {
                this._fontStyles.removeEventListener(starling.events.Event.CHANGE, this.fontStylesSet_changeHandler);
            }
            this._fontStyles = arg1;
            if (this._fontStyles !== null) 
            {
                this._fontStyles.addEventListener(starling.events.Event.CHANGE, this.fontStylesSet_changeHandler);
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function set paddingTop(arg1:Number):void
        {
            if (this._paddingTop == arg1) 
            {
                return;
            }
            this._paddingTop = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function set antiAliasType(arg1:String):void
        {
            if (this._antiAliasType == arg1) 
            {
                return;
            }
            this._antiAliasType = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get textFormat():flash.text.TextFormat
        {
            return this._textFormat;
        }

        public function set textFormat(arg1:flash.text.TextFormat):void
        {
            if (this._textFormat == arg1) 
            {
                return;
            }
            this._textFormat = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get paddingRight():Number
        {
            return this._paddingRight;
        }

        public function get disabledTextFormat():flash.text.TextFormat
        {
            return this._disabledTextFormat;
        }

        public function set disabledTextFormat(arg1:flash.text.TextFormat):void
        {
            if (this._disabledTextFormat == arg1) 
            {
                return;
            }
            this._disabledTextFormat = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function set paddingRight(arg1:Number):void
        {
            if (this._paddingRight == arg1) 
            {
                return;
            }
            this._paddingRight = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get styleSheet():flash.text.StyleSheet
        {
            return this._styleSheet;
        }

        public function set styleSheet(arg1:flash.text.StyleSheet):void
        {
            if (this._styleSheet == arg1) 
            {
                return;
            }
            this._styleSheet = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function fontStylesSet_changeHandler(arg1:starling.events.Event):void
        {
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get embedFonts():Boolean
        {
            return this._embedFonts;
        }

        public function set embedFonts(arg1:Boolean):void
        {
            if (this._embedFonts == arg1) 
            {
                return;
            }
            this._embedFonts = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function set paddingBottom(arg1:Number):void
        {
            if (this._paddingBottom == arg1) 
            {
                return;
            }
            this._paddingBottom = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get antiAliasType():String
        {
            return this._antiAliasType;
        }

        public function get paddingLeft():Number
        {
            return this._paddingLeft;
        }

        public function set paddingLeft(arg1:Number):void
        {
            if (this._paddingLeft == arg1) 
            {
                return;
            }
            this._paddingLeft = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get background():Boolean
        {
            return this._background;
        }

        public function set background(arg1:Boolean):void
        {
            if (this._background == arg1) 
            {
                return;
            }
            this._background = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public override function render(arg1:starling.rendering.Painter):void
        {
            arg1.excludeFromCache(this);
            var loc1:*=this.stage === null ? starling.core.Starling.current : this.stage.starling;
            var loc2:*=loc1.viewPort;
            var loc3:*=starling.utils.Pool.getMatrix();
            var loc4:*=starling.utils.Pool.getPoint();
            this.parent.getTransformationMatrix(this.stage, loc3);
            starling.utils.MatrixUtil.transformCoords(loc3, 0, 0, loc4);
            var loc5:*=1;
            if (loc1.supportHighResolutions) 
            {
                loc5 = loc1.nativeStage.contentsScaleFactor;
            }
            var loc6:*=loc1.contentScaleFactor / loc5;
            this._textFieldContainer.x = loc2.x + loc4.x * loc6;
            this._textFieldContainer.y = loc2.y + loc4.y * loc6;
            this._textFieldContainer.scaleX = feathers.utils.geom.matrixToScaleX(loc3) * loc6;
            this._textFieldContainer.scaleY = feathers.utils.geom.matrixToScaleY(loc3) * loc6;
            this._textFieldContainer.rotation = feathers.utils.geom.matrixToRotation(loc3) * 180 / Math.PI;
            this._textFieldContainer.alpha = arg1.state.alpha;
            starling.utils.Pool.putPoint(loc4);
            starling.utils.Pool.putMatrix(loc3);
            super.render(arg1);
            return;
        }

        public function get backgroundColor():uint
        {
            return this._backgroundColor;
        }

        public function set backgroundColor(arg1:uint):void
        {
            if (this._backgroundColor == arg1) 
            {
                return;
            }
            this._backgroundColor = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected override function initialize():void
        {
            this._textFieldContainer = new flash.display.Sprite();
            this._textFieldContainer.visible = false;
            this._textField = new flash.text.TextField();
            this._textField.autoSize = flash.text.TextFieldAutoSize.LEFT;
            this._textField.selectable = false;
            this._textField.mouseWheelEnabled = false;
            this._textField.wordWrap = true;
            this._textField.multiline = true;
            this._textField.addEventListener(flash.events.TextEvent.LINK, this.textField_linkHandler);
            this._textFieldContainer.addChild(this._textField);
            return;
        }

        public function get border():Boolean
        {
            return this._border;
        }

        public function set border(arg1:Boolean):void
        {
            if (this._border == arg1) 
            {
                return;
            }
            this._border = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected override function draw():void
        {
            var loc10:*=null;
            var loc1:*=this.isInvalid(INVALIDATION_FLAG_DATA);
            var loc2:*=this.isInvalid(INVALIDATION_FLAG_SIZE);
            var loc3:*=this.isInvalid(INVALIDATION_FLAG_SCROLL);
            var loc4:*=this.isInvalid(INVALIDATION_FLAG_STYLES);
            var loc5:*=this.isInvalid(INVALIDATION_FLAG_STATE);
            if (loc4) 
            {
                this.refreshTextFormat();
                this._textField.antiAliasType = this._antiAliasType;
                this._textField.background = this._background;
                this._textField.backgroundColor = this._backgroundColor;
                this._textField.border = this._border;
                this._textField.borderColor = this._borderColor;
                this._textField.condenseWhite = this._condenseWhite;
                this._textField.displayAsPassword = this._displayAsPassword;
                this._textField.gridFitType = this._gridFitType;
                this._textField.sharpness = this._sharpness;
                this._textField.thickness = this._thickness;
                this._textField.cacheAsBitmap = this._cacheAsBitmap;
                this._textField.x = this._paddingLeft;
                this._textField.y = this._paddingTop;
            }
            var loc6:*=this.stage === null ? starling.core.Starling.current : this.stage.starling;
            if (loc1 || loc4 || loc5) 
            {
                if (this._styleSheet === null) 
                {
                    if (!this._embedFonts && this._currentTextFormat === this._fontStylesTextFormat) 
                    {
                        this._textField.embedFonts = starling.utils.SystemUtil.isEmbeddedFont(this._currentTextFormat.font, this._currentTextFormat.bold, this._currentTextFormat.italic, flash.text.FontType.EMBEDDED);
                    }
                    else 
                    {
                        this._textField.embedFonts = this._embedFonts;
                    }
                    this._textField.styleSheet = null;
                    this._textField.defaultTextFormat = this._currentTextFormat;
                }
                else 
                {
                    this._textField.embedFonts = this._embedFonts;
                    this._textField.styleSheet = this._styleSheet;
                }
                if (this._isHTML) 
                {
                    this._textField.htmlText = this._text;
                }
                else 
                {
                    this._textField.text = this._text;
                }
                this._scrollStep = this._textField.getLineMetrics(0).height * loc6.contentScaleFactor;
            }
            var loc7:*=this._explicitVisibleWidth;
            if (loc7 != loc7) 
            {
                if (this.stage === null) 
                {
                    loc7 = loc6.stage.stageWidth;
                }
                else 
                {
                    loc7 = this.stage.stageWidth;
                }
                if (loc7 < this._explicitMinVisibleWidth) 
                {
                    loc7 = this._explicitMinVisibleWidth;
                }
                else if (loc7 > this._maxVisibleWidth) 
                {
                    loc7 = this._maxVisibleWidth;
                }
            }
            this._textField.width = loc7 - this._paddingLeft - this._paddingRight;
            var loc8:*=this._textField.height + this._paddingTop + this._paddingBottom;
            var loc9:*=this._explicitVisibleHeight;
            if (loc9 != loc9) 
            {
                loc9 = loc8;
                if (loc9 < this._explicitMinVisibleHeight) 
                {
                    loc9 = this._explicitMinVisibleHeight;
                }
                else if (loc9 > this._maxVisibleHeight) 
                {
                    loc9 = this._maxVisibleHeight;
                }
            }
            loc2 = this.saveMeasurements(loc7, loc8, loc7, loc8) || loc2;
            this._actualVisibleWidth = loc7;
            this._actualVisibleHeight = loc9;
            this._actualMinVisibleWidth = loc7;
            this._actualMinVisibleHeight = loc9;
            if (loc2 || loc3) 
            {
                loc10 = this._textFieldContainer.scrollRect;
                if (!loc10) 
                {
                    loc10 = new flash.geom.Rectangle();
                }
                loc10.width = loc7;
                loc10.height = loc9;
                loc10.x = this._horizontalScrollPosition;
                loc10.y = this._verticalScrollPosition;
                this._textFieldContainer.scrollRect = loc10;
            }
            return;
        }

        public function get borderColor():uint
        {
            return this._borderColor;
        }

        public function set borderColor(arg1:uint):void
        {
            if (this._borderColor == arg1) 
            {
                return;
            }
            this._borderColor = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function refreshTextFormat():void
        {
            if (!this._isEnabled && !(this._disabledTextFormat === null)) 
            {
                this._currentTextFormat = this._disabledTextFormat;
            }
            else if (this._textFormat === null) 
            {
                if (this._fontStyles !== null) 
                {
                    this._currentTextFormat = this.getTextFormatFromFontStyles();
                }
            }
            else 
            {
                this._currentTextFormat = this._textFormat;
            }
            return;
        }

        public function get cacheAsBitmap():Boolean
        {
            return this._cacheAsBitmap;
        }

        public function set cacheAsBitmap(arg1:Boolean):void
        {
            if (this._cacheAsBitmap == arg1) 
            {
                return;
            }
            this._cacheAsBitmap = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function getTextFormatFromFontStyles():flash.text.TextFormat
        {
            var loc1:*=null;
            if (this.isInvalid(INVALIDATION_FLAG_STYLES) || this.isInvalid(INVALIDATION_FLAG_STATE)) 
            {
                if (this._fontStyles !== null) 
                {
                    loc1 = this._fontStyles.getTextFormatForTarget(this);
                }
                if (loc1 === null) 
                {
                    if (this._fontStylesTextFormat === null) 
                    {
                        this._fontStylesTextFormat = new flash.text.TextFormat();
                    }
                }
                else 
                {
                    this._fontStylesTextFormat = loc1.toNativeFormat(this._fontStylesTextFormat);
                }
            }
            return this._fontStylesTextFormat;
        }

        public function get condenseWhite():Boolean
        {
            return this._condenseWhite;
        }

        public function set condenseWhite(arg1:Boolean):void
        {
            if (this._condenseWhite == arg1) 
            {
                return;
            }
            this._condenseWhite = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        internal function addedToStageHandler(arg1:starling.events.Event):void
        {
            this.stage.starling.nativeStage.addChild(this._textFieldContainer);
            this.addEventListener(starling.events.Event.ENTER_FRAME, this.enterFrameHandler);
            return;
        }

        public function get displayAsPassword():Boolean
        {
            return this._displayAsPassword;
        }

        public function set displayAsPassword(arg1:Boolean):void
        {
            if (this._displayAsPassword == arg1) 
            {
                return;
            }
            this._displayAsPassword = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        internal function removedFromStageHandler(arg1:starling.events.Event):void
        {
            this.stage.starling.nativeStage.removeChild(this._textFieldContainer);
            this.removeEventListener(starling.events.Event.ENTER_FRAME, this.enterFrameHandler);
            return;
        }

        public function get gridFitType():String
        {
            return this._gridFitType;
        }

        public function set gridFitType(arg1:String):void
        {
            if (this._gridFitType == arg1) 
            {
                return;
            }
            this._gridFitType = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        internal function enterFrameHandler(arg1:starling.events.Event):void
        {
            var loc1:*=this;
            do 
            {
                if (!loc1.visible) 
                {
                    this._textFieldContainer.visible = false;
                    return;
                }
                loc1 = loc1.parent;
            }
            while (loc1);
            this._textFieldContainer.visible = true;
            return;
        }

        public function get sharpness():Number
        {
            return this._sharpness;
        }

        public function set sharpness(arg1:Number):void
        {
            if (this._sharpness == arg1) 
            {
                return;
            }
            this._sharpness = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        protected function textField_linkHandler(arg1:flash.events.TextEvent):void
        {
            this.dispatchEventWith(starling.events.Event.TRIGGERED, false, arg1.text);
            return;
        }

        public function get thickness():Number
        {
            return this._thickness;
        }

        public function set thickness(arg1:Number):void
        {
            if (this._thickness == arg1) 
            {
                return;
            }
            this._thickness = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        public function get minVisibleWidth():Number
        {
            if (this._explicitMinVisibleWidth !== this._explicitMinVisibleWidth) 
            {
                return this._actualMinVisibleWidth;
            }
            return this._explicitMinVisibleWidth;
        }

        public function set minVisibleWidth(arg1:Number):void
        {
            if (this._explicitMinVisibleWidth == arg1) 
            {
                return;
            }
            var loc1:*=!(arg1 === arg1);
            if (loc1 && !(this._explicitMinVisibleWidth === this._explicitMinVisibleWidth)) 
            {
                return;
            }
            var loc2:*=this._explicitMinVisibleWidth;
            this._explicitMinVisibleWidth = arg1;
            if (loc1) 
            {
                this._actualMinVisibleWidth = 0;
                this.invalidate(INVALIDATION_FLAG_SIZE);
            }
            else 
            {
                this._actualMinVisibleWidth = arg1;
                if (!(this._explicitVisibleWidth === this._explicitVisibleWidth) && (this._actualVisibleWidth < arg1 || this._actualVisibleWidth === loc2)) 
                {
                    this.invalidate(INVALIDATION_FLAG_SIZE);
                }
            }
            return;
        }

        public function get maxVisibleWidth():Number
        {
            return this._maxVisibleWidth;
        }

        public function set maxVisibleWidth(arg1:Number):void
        {
            if (this._maxVisibleWidth == arg1) 
            {
                return;
            }
            if (arg1 !== arg1) 
            {
                throw new ArgumentError("maxVisibleWidth cannot be NaN");
            }
            var loc1:*=this._maxVisibleWidth;
            this._maxVisibleWidth = arg1;
            if (!(this._explicitVisibleWidth === this._explicitVisibleWidth) && (this._actualVisibleWidth > arg1 || this._actualVisibleWidth === loc1)) 
            {
                this.invalidate(INVALIDATION_FLAG_SIZE);
            }
            return;
        }

        public function get visibleWidth():Number
        {
            if (this._explicitVisibleWidth !== this._explicitVisibleWidth) 
            {
                return this._actualVisibleWidth;
            }
            return this._explicitVisibleWidth;
        }

        public function set visibleWidth(arg1:Number):void
        {
            if (this._explicitVisibleWidth == arg1 || !(arg1 === arg1) && !(this._explicitVisibleWidth === this._explicitVisibleWidth)) 
            {
                return;
            }
            this._explicitVisibleWidth = arg1;
            if (this._actualVisibleWidth !== arg1) 
            {
                this.invalidate(INVALIDATION_FLAG_SIZE);
            }
            return;
        }

        public function get minVisibleHeight():Number
        {
            if (this._explicitMinVisibleHeight !== this._explicitMinVisibleHeight) 
            {
                return this._actualMinVisibleHeight;
            }
            return this._explicitMinVisibleHeight;
        }

        public function set minVisibleHeight(arg1:Number):void
        {
            if (this._explicitMinVisibleHeight == arg1) 
            {
                return;
            }
            var loc1:*=!(arg1 === arg1);
            if (loc1 && !(this._explicitMinVisibleHeight === this._explicitMinVisibleHeight)) 
            {
                return;
            }
            var loc2:*=this._explicitMinVisibleHeight;
            this._explicitMinVisibleHeight = arg1;
            if (loc1) 
            {
                this._actualMinVisibleHeight = 0;
                this.invalidate(INVALIDATION_FLAG_SIZE);
            }
            else 
            {
                this._actualMinVisibleHeight = arg1;
                if (!(this._explicitVisibleHeight === this._explicitVisibleHeight) && (this._actualVisibleHeight < arg1 || this._actualVisibleHeight === loc2)) 
                {
                    this.invalidate(INVALIDATION_FLAG_SIZE);
                }
            }
            return;
        }

        public function get maxVisibleHeight():Number
        {
            return this._maxVisibleHeight;
        }

        public function set maxVisibleHeight(arg1:Number):void
        {
            if (this._maxVisibleHeight == arg1) 
            {
                return;
            }
            if (arg1 !== arg1) 
            {
                throw new ArgumentError("maxVisibleHeight cannot be NaN");
            }
            var loc1:*=this._maxVisibleHeight;
            this._maxVisibleHeight = arg1;
            if (!(this._explicitVisibleHeight === this._explicitVisibleHeight) && (this._actualVisibleHeight > arg1 || this._actualVisibleHeight === loc1)) 
            {
                this.invalidate(INVALIDATION_FLAG_SIZE);
            }
            return;
        }

        public function get visibleHeight():Number
        {
            if (this._explicitVisibleHeight !== this._explicitVisibleHeight) 
            {
                return this._actualVisibleHeight;
            }
            return this._explicitVisibleHeight;
        }

        public function set visibleHeight(arg1:Number):void
        {
            if (this._explicitVisibleHeight == arg1 || !(arg1 === arg1) && !(this._explicitVisibleHeight === this._explicitVisibleHeight)) 
            {
                return;
            }
            this._explicitVisibleHeight = arg1;
            if (this._actualVisibleHeight !== arg1) 
            {
                this.invalidate(INVALIDATION_FLAG_SIZE);
            }
            return;
        }

        public function get contentX():Number
        {
            return 0;
        }

        public function get contentY():Number
        {
            return 0;
        }

        public function get horizontalScrollStep():Number
        {
            return this._scrollStep;
        }

        public function get verticalScrollStep():Number
        {
            return this._scrollStep;
        }

        public function get paddingBottom():Number
        {
            return this._paddingBottom;
        }

        internal var _textFieldContainer:flash.display.Sprite;

        internal var _textField:flash.text.TextField;

        internal var _text:String="";

        internal var _isHTML:Boolean=false;

        protected var _fontStylesTextFormat:flash.text.TextFormat;

        protected var _fontStyles:feathers.text.FontStylesSet;

        internal var _currentTextFormat:flash.text.TextFormat;

        internal var _disabledTextFormat:flash.text.TextFormat;

        protected var _styleSheet:flash.text.StyleSheet;

        internal var _embedFonts:Boolean=false;

        internal var _antiAliasType:String="advanced";

        internal var _textFormat:flash.text.TextFormat;

        internal var _background:Boolean=false;

        internal var _backgroundColor:uint=16777215;

        internal var _border:Boolean=false;

        internal var _borderColor:uint=0;

        internal var _cacheAsBitmap:Boolean=true;

        internal var _condenseWhite:Boolean=false;

        internal var _displayAsPassword:Boolean=false;

        internal var _gridFitType:String="pixel";

        internal var _sharpness:Number=0;

        internal var _thickness:Number=0;

        internal var _actualVisibleWidth:Number=0;

        internal var _paddingBottom:Number=0;

        internal var _maxVisibleHeight:Number=Infinity;

        internal var _explicitVisibleWidth:Number=NaN;

        internal var _paddingLeft:Number=0;

        internal var _maxVisibleWidth:Number=Infinity;

        internal var _actualVisibleHeight:Number=0;

        internal var _verticalScrollPosition:Number=0;

        internal var _explicitVisibleHeight:Number=NaN;

        internal var _actualMinVisibleWidth:Number=0;

        internal var _actualMinVisibleHeight:Number=0;

        internal var _paddingTop:Number=0;

        internal var _explicitMinVisibleHeight:Number;

        internal var _explicitMinVisibleWidth:Number;

        internal var _paddingRight:Number=0;

        internal var _scrollStep:Number;

        internal var _horizontalScrollPosition:Number=0;
    }
}


