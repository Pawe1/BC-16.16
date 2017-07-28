//class BaseScreenNavigator
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


