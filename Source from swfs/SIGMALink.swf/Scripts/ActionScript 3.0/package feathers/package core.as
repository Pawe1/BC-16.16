//package core
//  class Application
package feathers.core 
{
    import feathers.controls.*;
    import feathers.utils.display.*;
    import flash.display.*;
    import flash.errors.*;
    import starling.core.*;
    import starling.events.*;
    
    public class Application extends feathers.controls.LayoutGroup implements feathers.core.IApplication
    {
        public function Application()
        {
            super();
            this.autoSizeMode = feathers.controls.LayoutGroup.AUTO_SIZE_MODE_STAGE;
            this.addEventListener(starling.events.Event.ADDED_TO_STAGE, this.application_addedToStageHandler);
            return;
        }

        public function get theme():Class
        {
            return this._theme;
        }

        public function set theme(arg1:Class):void
        {
            if (this._isInitialized) 
            {
                throw new flash.errors.IllegalOperationError("theme can only be set in MXML before an application has initialized.");
            }
            this._theme = arg1;
            return;
        }

        public function get context3DProfile():String
        {
            if (this._context3DProfile !== null) 
            {
                return this._context3DProfile;
            }
            return starling.core.Starling.current.profile;
        }

        public function set context3DProfile(arg1:String):void
        {
            if (this._isInitialized) 
            {
                throw new flash.errors.IllegalOperationError("context3DProfile can only be set in MXML before an application has initialized.");
            }
            this._context3DProfile = arg1;
            return;
        }

        public function get shareContext():Boolean
        {
            return this._shareContext;
        }

        public function set shareContext(arg1:Boolean):void
        {
            if (this._isInitialized) 
            {
                throw new flash.errors.IllegalOperationError("shareContext can only be set in MXML before an application has initialized.");
            }
            this._shareContext = arg1;
            return;
        }

        public function get skipUnchangedFrames():Boolean
        {
            return this._skipUnchangedFrames;
        }

        public function set skipUnchangedFrames(arg1:Boolean):void
        {
            this._skipUnchangedFrames = arg1;
            var loc1:*=feathers.utils.display.stageToStarling(this.stage);
            if (loc1 !== null) 
            {
                loc1.skipUnchangedFrames = arg1;
            }
            return;
        }

        public function get showStats():Boolean
        {
            return this._showStats;
        }

        public function set showStats(arg1:Boolean):void
        {
            this._showStats = arg1;
            var loc1:*=feathers.utils.display.stageToStarling(this.stage);
            if (loc1 !== null) 
            {
                loc1.showStats = arg1;
            }
            return;
        }

        protected function application_addedToStageHandler(arg1:starling.events.Event):void
        {
            var loc3:*=null;
            var loc1:*=feathers.utils.display.stageToStarling(this.stage);
            var loc2:*=loc1.nativeStage;
            if ("nativeWindow" in loc2) 
            {
                loc3 = loc2["nativeWindow"];
                if (loc3) 
                {
                    loc3.visible = true;
                }
            }
            return;
        }

        protected var _theme:Class;

        protected var _context3DProfile:String;

        protected var _shareContext:Boolean=false;

        protected var _skipUnchangedFrames:Boolean=true;

        protected var _showStats:Boolean=false;
    }
}


//  class BaseTextEditor
package feathers.core 
{
    import feathers.events.*;
    import feathers.text.*;
    import starling.events.*;
    
    public class BaseTextEditor extends feathers.core.FeathersControl implements feathers.core.IStateObserver
    {
        public function BaseTextEditor()
        {
            super();
            return;
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
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function get stateContext():feathers.core.IStateContext
        {
            return this._stateContext;
        }

        public function set stateContext(arg1:feathers.core.IStateContext):void
        {
            if (this._stateContext === arg1) 
            {
                return;
            }
            if (this._stateContext) 
            {
                this._stateContext.removeEventListener(feathers.events.FeathersEventType.STATE_CHANGE, this.stateContext_stateChangeHandler);
            }
            this._stateContext = arg1;
            if (this._stateContext) 
            {
                this._stateContext.addEventListener(feathers.events.FeathersEventType.STATE_CHANGE, this.stateContext_stateChangeHandler);
            }
            this.invalidate(INVALIDATION_FLAG_STATE);
            return;
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

        public override function dispose():void
        {
            this.stateContext = null;
            this.fontStyles = null;
            super.dispose();
            return;
        }

        protected function stateContext_stateChangeHandler(arg1:starling.events.Event):void
        {
            this.invalidate(INVALIDATION_FLAG_STATE);
            return;
        }

        protected function fontStylesSet_changeHandler(arg1:starling.events.Event):void
        {
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected var _text:String="";

        protected var _stateContext:feathers.core.IStateContext;

        protected var _fontStyles:feathers.text.FontStylesSet;
    }
}


//  class DefaultFocusManager
package feathers.core 
{
    import __AS3__.vec.*;
    import feathers.controls.supportClasses.*;
    import feathers.events.*;
    import feathers.utils.display.*;
    import flash.display.*;
    import flash.errors.*;
    import flash.events.*;
    import flash.ui.*;
    import flash.utils.*;
    import starling.core.*;
    import starling.display.*;
    import starling.events.*;
    
    public class DefaultFocusManager extends Object implements feathers.core.IFocusManager
    {
        public function DefaultFocusManager(arg1:starling.display.DisplayObjectContainer)
        {
            super();
            if (!arg1.stage) 
            {
                throw new ArgumentError("Focus manager root must be added to the stage.");
            }
            this._root = arg1;
            this._starling = feathers.utils.display.stageToStarling(arg1.stage);
            return;
        }

        public function get root():starling.display.DisplayObjectContainer
        {
            return this._root;
        }

        public function get isEnabled():Boolean
        {
            return this._isEnabled;
        }

        public function set isEnabled(arg1:Boolean):void
        {
            var loc1:*=null;
            if (this._isEnabled == arg1) 
            {
                return;
            }
            this._isEnabled = arg1;
            if (this._isEnabled) 
            {
                this._nativeFocusTarget = NATIVE_STAGE_TO_FOCUS_TARGET[this._starling.nativeStage] as NativeFocusTarget;
                if (this._nativeFocusTarget) 
                {
                    var loc2:*;
                    var loc3:*=((loc2 = this._nativeFocusTarget).referenceCount + 1);
                    loc2.referenceCount = loc3;
                }
                else 
                {
                    this._nativeFocusTarget = new NativeFocusTarget();
                    this._starling.nativeStage.addChild(this._nativeFocusTarget);
                }
                this.setFocusManager(this._root);
                this._root.addEventListener(starling.events.Event.ADDED, this.topLevelContainer_addedHandler);
                this._root.addEventListener(starling.events.Event.REMOVED, this.topLevelContainer_removedHandler);
                this._root.addEventListener(starling.events.TouchEvent.TOUCH, this.topLevelContainer_touchHandler);
                this._starling.nativeStage.addEventListener(flash.events.FocusEvent.KEY_FOCUS_CHANGE, this.stage_keyFocusChangeHandler, false, 0, true);
                this._starling.nativeStage.addEventListener(flash.events.FocusEvent.MOUSE_FOCUS_CHANGE, this.stage_mouseFocusChangeHandler, false, 0, true);
                if (this._savedFocus && !this._savedFocus.stage) 
                {
                    this._savedFocus = null;
                }
                this.focus = this._savedFocus;
                this._savedFocus = null;
            }
            else 
            {
                loc3 = ((loc2 = this._nativeFocusTarget).referenceCount - 1);
                loc2.referenceCount = loc3;
                if (this._nativeFocusTarget.referenceCount <= 0) 
                {
                    this._nativeFocusTarget.parent.removeChild(this._nativeFocusTarget);
                    delete NATIVE_STAGE_TO_FOCUS_TARGET[this._starling.nativeStage];
                }
                this._nativeFocusTarget = null;
                this._root.removeEventListener(starling.events.Event.ADDED, this.topLevelContainer_addedHandler);
                this._root.removeEventListener(starling.events.Event.REMOVED, this.topLevelContainer_removedHandler);
                this._root.removeEventListener(starling.events.TouchEvent.TOUCH, this.topLevelContainer_touchHandler);
                this._starling.nativeStage.removeEventListener(flash.events.FocusEvent.KEY_FOCUS_CHANGE, this.stage_keyFocusChangeHandler);
                this._starling.nativeStage.addEventListener(flash.events.FocusEvent.MOUSE_FOCUS_CHANGE, this.stage_mouseFocusChangeHandler);
                loc1 = this.focus;
                this.focus = null;
                this._savedFocus = loc1;
            }
            return;
        }

        public function get focus():feathers.core.IFocusDisplayObject
        {
            return this._focus;
        }

        public function set focus(arg1:feathers.core.IFocusDisplayObject):void
        {
            var loc4:*=null;
            var loc5:*=null;
            if (this._focus === arg1) 
            {
                return;
            }
            var loc1:*=false;
            var loc2:*=this._focus;
            if (this._isEnabled && !(arg1 === null) && arg1.isFocusEnabled && arg1.focusManager === this) 
            {
                this._focus = arg1;
                loc1 = true;
            }
            else 
            {
                this._focus = null;
            }
            var loc3:*=this._starling.nativeStage;
            if (loc2 is feathers.core.INativeFocusOwner) 
            {
                loc4 = feathers.core.INativeFocusOwner(loc2).nativeFocus;
                if (loc4 === null && !(loc3 === null)) 
                {
                    loc4 = loc3.focus;
                }
                if (loc4 is flash.events.IEventDispatcher) 
                {
                    flash.events.IEventDispatcher(loc4).removeEventListener(flash.events.FocusEvent.FOCUS_OUT, this.nativeFocus_focusOutHandler);
                }
            }
            if (loc2 !== null) 
            {
                loc2.dispatchEventWith(feathers.events.FeathersEventType.FOCUS_OUT);
            }
            if (loc1 && !(this._focus === arg1)) 
            {
                return;
            }
            if (this._isEnabled) 
            {
                if (this._focus === null) 
                {
                    loc3.focus = null;
                }
                else 
                {
                    loc4 = null;
                    if (this._focus is feathers.core.INativeFocusOwner) 
                    {
                        loc4 = feathers.core.INativeFocusOwner(this._focus).nativeFocus;
                        if (loc4 is flash.display.InteractiveObject) 
                        {
                            loc3.focus = flash.display.InteractiveObject(loc4);
                        }
                        else if (loc4 !== null) 
                        {
                            if (this._focus is feathers.core.IAdvancedNativeFocusOwner) 
                            {
                                loc5 = feathers.core.IAdvancedNativeFocusOwner(this._focus);
                                if (!loc5.hasFocus) 
                                {
                                    loc5.setFocus();
                                }
                            }
                            else 
                            {
                                throw new flash.errors.IllegalOperationError("If nativeFocus does not return an InteractiveObject, class must implement IAdvancedNativeFocusOwner interface");
                            }
                        }
                    }
                    if (loc4 === null) 
                    {
                        loc4 = this._nativeFocusTarget;
                        loc3.focus = this._nativeFocusTarget;
                    }
                    if (loc4 is flash.events.IEventDispatcher) 
                    {
                        flash.events.IEventDispatcher(loc4).addEventListener(flash.events.FocusEvent.FOCUS_OUT, this.nativeFocus_focusOutHandler, false, 0, true);
                    }
                    this._focus.dispatchEventWith(feathers.events.FeathersEventType.FOCUS_IN);
                }
            }
            else 
            {
                this._savedFocus = arg1;
            }
            return;
        }

        protected function setFocusManager(arg1:starling.display.DisplayObject):void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=0;
            var loc4:*=0;
            var loc5:*=null;
            var loc6:*=null;
            var loc7:*=null;
            if (arg1 is feathers.core.IFocusDisplayObject) 
            {
                loc1 = feathers.core.IFocusDisplayObject(arg1);
                loc1.focusManager = this;
            }
            if (arg1 is starling.display.DisplayObjectContainer && !(arg1 is feathers.core.IFocusDisplayObject) || arg1 is feathers.core.IFocusContainer && feathers.core.IFocusContainer(arg1).isChildFocusEnabled) 
            {
                loc2 = starling.display.DisplayObjectContainer(arg1);
                loc3 = loc2.numChildren;
                loc4 = 0;
                while (loc4 < loc3) 
                {
                    loc5 = loc2.getChildAt(loc4);
                    this.setFocusManager(loc5);
                    ++loc4;
                }
                if (loc2 is feathers.core.IFocusExtras) 
                {
                    loc6 = feathers.core.IFocusExtras(loc2);
                    loc7 = loc6.focusExtrasBefore;
                    if (loc7) 
                    {
                        loc3 = loc7.length;
                        loc4 = 0;
                        while (loc4 < loc3) 
                        {
                            loc5 = loc7[loc4];
                            this.setFocusManager(loc5);
                            ++loc4;
                        }
                    }
                    loc7 = loc6.focusExtrasAfter;
                    if (loc7) 
                    {
                        loc3 = loc7.length;
                        loc4 = 0;
                        while (loc4 < loc3) 
                        {
                            loc5 = loc7[loc4];
                            this.setFocusManager(loc5);
                            ++loc4;
                        }
                    }
                }
            }
            return;
        }

        protected function clearFocusManager(arg1:starling.display.DisplayObject):void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=0;
            var loc4:*=0;
            var loc5:*=null;
            var loc6:*=null;
            var loc7:*=null;
            if (arg1 is feathers.core.IFocusDisplayObject) 
            {
                loc1 = feathers.core.IFocusDisplayObject(arg1);
                if (loc1.focusManager == this) 
                {
                    if (this._focus == loc1) 
                    {
                        this.focus = loc1.focusOwner;
                    }
                    loc1.focusManager = null;
                }
            }
            if (arg1 is starling.display.DisplayObjectContainer) 
            {
                loc2 = starling.display.DisplayObjectContainer(arg1);
                loc3 = loc2.numChildren;
                loc4 = 0;
                while (loc4 < loc3) 
                {
                    loc5 = loc2.getChildAt(loc4);
                    this.clearFocusManager(loc5);
                    ++loc4;
                }
                if (loc2 is feathers.core.IFocusExtras) 
                {
                    loc6 = feathers.core.IFocusExtras(loc2);
                    loc7 = loc6.focusExtrasBefore;
                    if (loc7) 
                    {
                        loc3 = loc7.length;
                        loc4 = 0;
                        while (loc4 < loc3) 
                        {
                            loc5 = loc7[loc4];
                            this.clearFocusManager(loc5);
                            ++loc4;
                        }
                    }
                    loc7 = loc6.focusExtrasAfter;
                    if (loc7) 
                    {
                        loc3 = loc7.length;
                        loc4 = 0;
                        while (loc4 < loc3) 
                        {
                            loc5 = loc7[loc4];
                            this.clearFocusManager(loc5);
                            ++loc4;
                        }
                    }
                }
            }
            return;
        }

        protected function findPreviousContainerFocus(arg1:starling.display.DisplayObjectContainer, arg2:starling.display.DisplayObject, arg3:Boolean):feathers.core.IFocusDisplayObject
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=false;
            var loc5:*=0;
            var loc6:*=0;
            var loc7:*=null;
            var loc8:*=null;
            var loc9:*=null;
            if (arg1 is feathers.controls.supportClasses.LayoutViewPort) 
            {
                arg1 = arg1.parent;
            }
            var loc1:*=arg2 == null;
            if (arg1 is feathers.core.IFocusExtras) 
            {
                loc2 = feathers.core.IFocusExtras(arg1);
                loc3 = loc2.focusExtrasAfter;
                if (loc3) 
                {
                    loc4 = false;
                    if (arg2) 
                    {
                        loc5 = (loc3.indexOf(arg2) - 1);
                        loc1 = loc5 >= -1;
                        loc4 = !loc1;
                    }
                    else 
                    {
                        loc5 = (loc3.length - 1);
                    }
                    if (!loc4) 
                    {
                        loc6 = loc5;
                        while (loc6 >= 0) 
                        {
                            loc7 = loc3[loc6];
                            loc8 = this.findPreviousChildFocus(loc7);
                            if (this.isValidFocus(loc8)) 
                            {
                                return loc8;
                            }
                            --loc6;
                        }
                    }
                }
            }
            if (arg2 && !loc1) 
            {
                loc5 = (arg1.getChildIndex(arg2) - 1);
                loc1 = loc5 >= -1;
            }
            else 
            {
                loc5 = (arg1.numChildren - 1);
            }
            loc6 = loc5;
            while (loc6 >= 0) 
            {
                loc7 = arg1.getChildAt(loc6);
                loc8 = this.findPreviousChildFocus(loc7);
                if (this.isValidFocus(loc8)) 
                {
                    return loc8;
                }
                --loc6;
            }
            if (arg1 is feathers.core.IFocusExtras) 
            {
                loc3 = loc2.focusExtrasBefore;
                if (loc3) 
                {
                    loc4 = false;
                    if (arg2 && !loc1) 
                    {
                        loc5 = (loc3.indexOf(arg2) - 1);
                        loc1 = loc5 >= -1;
                        loc4 = !loc1;
                    }
                    else 
                    {
                        loc5 = (loc3.length - 1);
                    }
                    if (!loc4) 
                    {
                        loc6 = loc5;
                        while (loc6 >= 0) 
                        {
                            loc7 = loc3[loc6];
                            loc8 = this.findPreviousChildFocus(loc7);
                            if (this.isValidFocus(loc8)) 
                            {
                                return loc8;
                            }
                            --loc6;
                        }
                    }
                }
            }
            if (arg3 && !(arg1 == this._root)) 
            {
                if (arg1 is feathers.core.IFocusDisplayObject) 
                {
                    loc9 = feathers.core.IFocusDisplayObject(arg1);
                    if (this.isValidFocus(loc9)) 
                    {
                        return loc9;
                    }
                }
                return this.findPreviousContainerFocus(arg1.parent, arg1, true);
            }
            return null;
        }

        protected function findNextContainerFocus(arg1:starling.display.DisplayObjectContainer, arg2:starling.display.DisplayObject, arg3:Boolean):feathers.core.IFocusDisplayObject
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=false;
            var loc5:*=0;
            var loc6:*=0;
            var loc7:*=0;
            var loc8:*=null;
            var loc9:*=null;
            if (arg1 is feathers.controls.supportClasses.LayoutViewPort) 
            {
                arg1 = arg1.parent;
            }
            var loc1:*=arg2 == null;
            if (arg1 is feathers.core.IFocusExtras) 
            {
                loc2 = feathers.core.IFocusExtras(arg1);
                loc3 = loc2.focusExtrasBefore;
                if (loc3) 
                {
                    loc4 = false;
                    if (arg2) 
                    {
                        loc5 = loc3.indexOf(arg2) + 1;
                        loc1 = loc5 > 0;
                        loc4 = !loc1;
                    }
                    else 
                    {
                        loc5 = 0;
                    }
                    if (!loc4) 
                    {
                        loc6 = loc3.length;
                        loc7 = loc5;
                        while (loc7 < loc6) 
                        {
                            loc8 = loc3[loc7];
                            loc9 = this.findNextChildFocus(loc8);
                            if (this.isValidFocus(loc9)) 
                            {
                                return loc9;
                            }
                            ++loc7;
                        }
                    }
                }
            }
            if (arg2 && !loc1) 
            {
                loc5 = arg1.getChildIndex(arg2) + 1;
                loc1 = loc5 > 0;
            }
            else 
            {
                loc5 = 0;
            }
            loc6 = arg1.numChildren;
            loc7 = loc5;
            while (loc7 < loc6) 
            {
                loc8 = arg1.getChildAt(loc7);
                loc9 = this.findNextChildFocus(loc8);
                if (this.isValidFocus(loc9)) 
                {
                    return loc9;
                }
                ++loc7;
            }
            if (arg1 is feathers.core.IFocusExtras) 
            {
                loc3 = loc2.focusExtrasAfter;
                if (loc3) 
                {
                    loc4 = false;
                    if (arg2 && !loc1) 
                    {
                        loc5 = loc3.indexOf(arg2) + 1;
                        loc1 = loc5 > 0;
                        loc4 = !loc1;
                    }
                    else 
                    {
                        loc5 = 0;
                    }
                    if (!loc4) 
                    {
                        loc6 = loc3.length;
                        loc7 = loc5;
                        while (loc7 < loc6) 
                        {
                            loc8 = loc3[loc7];
                            loc9 = this.findNextChildFocus(loc8);
                            if (this.isValidFocus(loc9)) 
                            {
                                return loc9;
                            }
                            ++loc7;
                        }
                    }
                }
            }
            if (arg3 && !(arg1 == this._root)) 
            {
                return this.findNextContainerFocus(arg1.parent, arg1, true);
            }
            return null;
        }

        protected function findPreviousChildFocus(arg1:starling.display.DisplayObject):feathers.core.IFocusDisplayObject
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            if (arg1 is starling.display.DisplayObjectContainer && !(arg1 is feathers.core.IFocusDisplayObject) || arg1 is feathers.core.IFocusContainer && feathers.core.IFocusContainer(arg1).isChildFocusEnabled) 
            {
                loc1 = starling.display.DisplayObjectContainer(arg1);
                loc2 = this.findPreviousContainerFocus(loc1, null, false);
                if (loc2) 
                {
                    return loc2;
                }
            }
            if (arg1 is feathers.core.IFocusDisplayObject) 
            {
                loc3 = feathers.core.IFocusDisplayObject(arg1);
                if (this.isValidFocus(loc3)) 
                {
                    return loc3;
                }
            }
            return null;
        }

        protected function findNextChildFocus(arg1:starling.display.DisplayObject):feathers.core.IFocusDisplayObject
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            if (arg1 is feathers.core.IFocusDisplayObject) 
            {
                loc1 = feathers.core.IFocusDisplayObject(arg1);
                if (this.isValidFocus(loc1)) 
                {
                    return loc1;
                }
            }
            if (arg1 is starling.display.DisplayObjectContainer && !(arg1 is feathers.core.IFocusDisplayObject) || arg1 is feathers.core.IFocusContainer && feathers.core.IFocusContainer(arg1).isChildFocusEnabled) 
            {
                loc2 = starling.display.DisplayObjectContainer(arg1);
                loc3 = this.findNextContainerFocus(loc2, null, false);
                if (loc3) 
                {
                    return loc3;
                }
            }
            return null;
        }

        protected function isValidFocus(arg1:feathers.core.IFocusDisplayObject):Boolean
        {
            if (!arg1 || !arg1.isFocusEnabled || !(arg1.focusManager == this)) 
            {
                return false;
            }
            var loc1:*=arg1 as feathers.core.IFeathersControl;
            if (loc1 && !loc1.isEnabled) 
            {
                return false;
            }
            return true;
        }

        protected function stage_mouseFocusChangeHandler(arg1:flash.events.FocusEvent):void
        {
            if (arg1.relatedObject) 
            {
                this.focus = null;
                return;
            }
            arg1.preventDefault();
            return;
        }

        protected function stage_keyFocusChangeHandler(arg1:flash.events.FocusEvent):void
        {
            var loc1:*=null;
            if (!(arg1.keyCode == flash.ui.Keyboard.TAB) && !(arg1.keyCode == 0)) 
            {
                return;
            }
            var loc2:*=this._focus;
            if (loc2 && loc2.focusOwner) 
            {
                loc1 = loc2.focusOwner;
            }
            else if (arg1.shiftKey) 
            {
                if (loc2) 
                {
                    if (loc2.previousTabFocus) 
                    {
                        loc1 = loc2.previousTabFocus;
                    }
                    else 
                    {
                        loc1 = this.findPreviousContainerFocus(loc2.parent, starling.display.DisplayObject(loc2), true);
                    }
                }
                if (!loc1) 
                {
                    loc1 = this.findPreviousContainerFocus(this._root, null, false);
                }
            }
            else 
            {
                if (loc2) 
                {
                    if (loc2.nextTabFocus) 
                    {
                        loc1 = loc2.nextTabFocus;
                    }
                    else if (loc2 is feathers.core.IFocusContainer && feathers.core.IFocusContainer(loc2).isChildFocusEnabled) 
                    {
                        loc1 = this.findNextContainerFocus(starling.display.DisplayObjectContainer(loc2), null, true);
                    }
                    else 
                    {
                        loc1 = this.findNextContainerFocus(loc2.parent, starling.display.DisplayObject(loc2), true);
                    }
                }
                if (!loc1) 
                {
                    loc1 = this.findNextContainerFocus(this._root, null, false);
                }
            }
            if (loc1) 
            {
                arg1.preventDefault();
            }
            this.focus = loc1;
            if (this._focus) 
            {
                this._focus.showFocus();
            }
            return;
        }

        protected function topLevelContainer_addedHandler(arg1:starling.events.Event):void
        {
            this.setFocusManager(starling.display.DisplayObject(arg1.target));
            return;
        }

        protected function topLevelContainer_removedHandler(arg1:starling.events.Event):void
        {
            this.clearFocusManager(starling.display.DisplayObject(arg1.target));
            return;
        }

        protected function topLevelContainer_touchHandler(arg1:starling.events.TouchEvent):void
        {
            var loc4:*=null;
            var loc1:*=arg1.getTouch(this._root, starling.events.TouchPhase.BEGAN);
            if (!loc1) 
            {
                return;
            }
            var loc2:*=null;
            var loc3:*=loc1.target;
            do 
            {
                if (loc3 is feathers.core.IFocusDisplayObject) 
                {
                    loc4 = feathers.core.IFocusDisplayObject(loc3);
                    if (this.isValidFocus(loc4)) 
                    {
                        if (!loc2 || !(loc4 is feathers.core.IFocusContainer) || !feathers.core.IFocusContainer(loc4).isChildFocusEnabled) 
                        {
                            loc2 = loc4;
                        }
                    }
                }
                loc3 = loc3.parent;
            }
            while (loc3);
            if (!(this._focus === null) && !(loc2 === null) && this._focus.focusOwner === loc2) 
            {
                return;
            }
            this.focus = loc2;
            return;
        }

        protected function nativeFocus_focusOutHandler(arg1:flash.events.FocusEvent):void
        {
            var loc1:*=arg1.currentTarget;
            var loc2:*=this._starling.nativeStage;
            if (!(loc2.focus === null) && !(loc2.focus === loc1)) 
            {
                if (loc1 is flash.events.IEventDispatcher) 
                {
                    flash.events.IEventDispatcher(loc1).removeEventListener(flash.events.FocusEvent.FOCUS_OUT, this.nativeFocus_focusOutHandler);
                }
            }
            else if (this._focus !== null) 
            {
                if (this._focus is feathers.core.INativeFocusOwner && !(feathers.core.INativeFocusOwner(this._focus).nativeFocus === loc1)) 
                {
                    return;
                }
                if (loc1 is flash.display.InteractiveObject) 
                {
                    loc2.focus = flash.display.InteractiveObject(loc1);
                }
                else 
                {
                    feathers.core.IAdvancedNativeFocusOwner(this._focus).setFocus();
                }
            }
            return;
        }

        
        {
            NATIVE_STAGE_TO_FOCUS_TARGET = new flash.utils.Dictionary(true);
        }

        protected var _starling:starling.core.Starling;

        protected var _nativeFocusTarget:NativeFocusTarget;

        protected var _root:starling.display.DisplayObjectContainer;

        protected var _isEnabled:Boolean=false;

        protected var _savedFocus:feathers.core.IFocusDisplayObject;

        protected var _focus:feathers.core.IFocusDisplayObject;

        protected static var NATIVE_STAGE_TO_FOCUS_TARGET:flash.utils.Dictionary;
    }
}

import flash.display.*;


class NativeFocusTarget extends flash.display.Sprite
{
    public function NativeFocusTarget()
    {
        super();
        this.tabEnabled = true;
        this.mouseEnabled = false;
        this.mouseChildren = false;
        this.alpha = 0;
        return;
    }

    public var referenceCount:int=1;
}

//  class DefaultPopUpManager
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


//  class FeathersControl
package feathers.core 
{
    import feathers.controls.text.*;
    import feathers.events.*;
    import feathers.layout.*;
    import feathers.skins.*;
    import feathers.utils.display.*;
    import flash.errors.*;
    import flash.geom.*;
    import flash.utils.*;
    import starling.core.*;
    import starling.display.*;
    import starling.events.*;
    import starling.utils.*;
    
    public class FeathersControl extends starling.display.Sprite implements feathers.core.IFeathersControl, feathers.layout.ILayoutDisplayObject
    {
        public function FeathersControl()
        {
            this._styleNameList = new feathers.core.TokenList();
            this._hitArea = new flash.geom.Rectangle();
            this._invalidationFlags = {};
            this._delayedInvalidationFlags = {};
            super();
            if (Object(this).constructor == feathers.core.FeathersControl) 
            {
                throw new Error(ABSTRACT_CLASS_ERROR);
            }
            this._styleProvider = this.defaultStyleProvider;
            this.addEventListener(starling.events.Event.ADDED_TO_STAGE, this.feathersControl_addedToStageHandler);
            this.addEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.feathersControl_removedFromStageHandler);
            if (this is feathers.core.IFocusDisplayObject) 
            {
                this.addEventListener(feathers.events.FeathersEventType.FOCUS_IN, this.focusInHandler);
                this.addEventListener(feathers.events.FeathersEventType.FOCUS_OUT, this.focusOutHandler);
            }
            return;
        }

        public function set focusPaddingBottom(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._focusPaddingBottom === arg1) 
            {
                return;
            }
            this._focusPaddingBottom = arg1;
            this.invalidate(INVALIDATION_FLAG_FOCUS);
            return;
        }

        public function get focusPaddingLeft():Number
        {
            return this._focusPaddingLeft;
        }

        public function get id():String
        {
            return this._id;
        }

        public function set id(arg1:String):void
        {
            this._id = arg1;
            return;
        }

        public function get styleName():String
        {
            return this._styleNameList.value;
        }

        public function set styleName(arg1:String):void
        {
            this._styleNameList.value = arg1;
            return;
        }

        public function set focusPaddingLeft(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._focusPaddingLeft === arg1) 
            {
                return;
            }
            this._focusPaddingLeft = arg1;
            this.invalidate(INVALIDATION_FLAG_FOCUS);
            return;
        }

        public function get styleNameList():feathers.core.TokenList
        {
            return this._styleNameList;
        }

        public function get isCreated():Boolean
        {
            return this._hasValidated;
        }

        public function get styleProvider():feathers.skins.IStyleProvider
        {
            return this._styleProvider;
        }

        public function set styleProvider(arg1:feathers.skins.IStyleProvider):void
        {
            if (this._styleProvider === arg1) 
            {
                return;
            }
            if (this._applyingStyles) 
            {
                throw new flash.errors.IllegalOperationError("Cannot change styleProvider while the current style provider is applying styles.");
            }
            this._styleProvider = arg1;
            if (!(this._styleProvider === null) && this.isInitialized) 
            {
                this._applyingStyles = true;
                this._styleProvider.applyStyles(this);
                this._applyingStyles = false;
            }
            return;
        }

        protected function get defaultStyleProvider():feathers.skins.IStyleProvider
        {
            return null;
        }

        public function get depth():int
        {
            return this._depth;
        }

        public function get isQuickHitAreaEnabled():Boolean
        {
            return this._isQuickHitAreaEnabled;
        }

        public function set isQuickHitAreaEnabled(arg1:Boolean):void
        {
            this._isQuickHitAreaEnabled = arg1;
            return;
        }

        public override function getBounds(arg1:starling.display.DisplayObject, arg2:flash.geom.Rectangle=null):flash.geom.Rectangle
        {
            var loc5:*=null;
            if (!arg2) 
            {
                arg2 = new flash.geom.Rectangle();
            }
            var loc1:*=Number.MAX_VALUE;
            var loc2:*=-Number.MAX_VALUE;
            var loc3:*=Number.MAX_VALUE;
            var loc4:*=-Number.MAX_VALUE;
            if (arg1 != this) 
            {
                loc5 = starling.utils.Pool.getMatrix();
                this.getTransformationMatrix(arg1, loc5);
                starling.utils.MatrixUtil.transformCoords(loc5, 0, 0, HELPER_POINT);
                loc1 = loc1 < HELPER_POINT.x ? loc1 : HELPER_POINT.x;
                loc2 = loc2 > HELPER_POINT.x ? loc2 : HELPER_POINT.x;
                loc3 = loc3 < HELPER_POINT.y ? loc3 : HELPER_POINT.y;
                loc4 = loc4 > HELPER_POINT.y ? loc4 : HELPER_POINT.y;
                starling.utils.MatrixUtil.transformCoords(loc5, 0, this.actualHeight, HELPER_POINT);
                loc1 = loc1 < HELPER_POINT.x ? loc1 : HELPER_POINT.x;
                loc2 = loc2 > HELPER_POINT.x ? loc2 : HELPER_POINT.x;
                loc3 = loc3 < HELPER_POINT.y ? loc3 : HELPER_POINT.y;
                loc4 = loc4 > HELPER_POINT.y ? loc4 : HELPER_POINT.y;
                starling.utils.MatrixUtil.transformCoords(loc5, this.actualWidth, 0, HELPER_POINT);
                loc1 = loc1 < HELPER_POINT.x ? loc1 : HELPER_POINT.x;
                loc2 = loc2 > HELPER_POINT.x ? loc2 : HELPER_POINT.x;
                loc3 = loc3 < HELPER_POINT.y ? loc3 : HELPER_POINT.y;
                loc4 = loc4 > HELPER_POINT.y ? loc4 : HELPER_POINT.y;
                starling.utils.MatrixUtil.transformCoords(loc5, this.actualWidth, this.actualHeight, HELPER_POINT);
                loc1 = loc1 < HELPER_POINT.x ? loc1 : HELPER_POINT.x;
                loc2 = loc2 > HELPER_POINT.x ? loc2 : HELPER_POINT.x;
                loc3 = loc3 < HELPER_POINT.y ? loc3 : HELPER_POINT.y;
                loc4 = loc4 > HELPER_POINT.y ? loc4 : HELPER_POINT.y;
                starling.utils.Pool.putMatrix(loc5);
            }
            else 
            {
                loc1 = 0;
                loc3 = 0;
                loc2 = this.actualWidth;
                loc4 = this.actualHeight;
            }
            arg2.x = loc1;
            arg2.y = loc3;
            arg2.width = loc2 - loc1;
            arg2.height = loc4 - loc3;
            return arg2;
        }

        public override function hitTest(arg1:flash.geom.Point):starling.display.DisplayObject
        {
            if (this._isQuickHitAreaEnabled) 
            {
                if (!this.visible || !this.touchable) 
                {
                    return null;
                }
                if (this.mask && !this.hitTestMask(arg1)) 
                {
                    return null;
                }
                return this._hitArea.containsPoint(arg1) ? this : null;
            }
            return super.hitTest(arg1);
        }

        public override function dispose():void
        {
            this._isDisposed = true;
            this._validationQueue = null;
            super.dispose();
            return;
        }

        public function get isInitialized():Boolean
        {
            return this._isInitialized;
        }

        public function set focusPaddingRight(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._focusPaddingRight === arg1) 
            {
                return;
            }
            this._focusPaddingRight = arg1;
            this.invalidate(INVALIDATION_FLAG_FOCUS);
            return;
        }

        public function invalidate(arg1:String="all"):void
        {
            var loc3:*=null;
            var loc1:*=this.isInvalid();
            var loc2:*=false;
            if (this._isValidating) 
            {
                var loc4:*=0;
                var loc5:*=this._delayedInvalidationFlags;
                for (loc3 in loc5) 
                {
                    loc2 = true;
                    break;
                }
            }
            if (!arg1 || arg1 == INVALIDATION_FLAG_ALL) 
            {
                if (this._isValidating) 
                {
                    this._delayedInvalidationFlags[INVALIDATION_FLAG_ALL] = true;
                }
                else 
                {
                    this._isAllInvalid = true;
                }
            }
            else if (this._isValidating) 
            {
                this._delayedInvalidationFlags[arg1] = true;
            }
            else if (!(arg1 == INVALIDATION_FLAG_ALL) && !this._invalidationFlags.hasOwnProperty(arg1)) 
            {
                this._invalidationFlags[arg1] = true;
            }
            if (this._validationQueue === null || !this._isInitialized) 
            {
                return;
            }
            if (this._isValidating) 
            {
                if (loc2) 
                {
                    return;
                }
                loc5 = ((loc4 = this)._invalidateCount + 1);
                loc4._invalidateCount = loc5;
                if (this._invalidateCount >= 10) 
                {
                    throw new Error(flash.utils.getQualifiedClassName(this) + " returned to validation queue too many times during validation. This may be an infinite loop. Try to avoid doing anything that calls invalidate() during validation.");
                }
                this._validationQueue.addControl(this);
                return;
            }
            if (loc1) 
            {
                return;
            }
            this._invalidateCount = 0;
            this._validationQueue.addControl(this);
            return;
        }

        public function validate():void
        {
            var loc1:*=null;
            if (this._isDisposed) 
            {
                return;
            }
            if (!this._isInitialized) 
            {
                if (this._isInitializing) 
                {
                    return;
                }
                this.initializeNow();
            }
            if (!this.isInvalid()) 
            {
                return;
            }
            if (this._isValidating) 
            {
                return;
            }
            this._isValidating = true;
            this.draw();
            var loc2:*=0;
            var loc3:*=this._invalidationFlags;
            for (loc1 in loc3) 
            {
                delete this._invalidationFlags[loc1];
            }
            this._isAllInvalid = false;
            loc2 = 0;
            loc3 = this._delayedInvalidationFlags;
            for (loc1 in loc3) 
            {
                if (loc1 != INVALIDATION_FLAG_ALL) 
                {
                    this._invalidationFlags[loc1] = true;
                }
                else 
                {
                    this._isAllInvalid = true;
                }
                delete this._delayedInvalidationFlags[loc1];
            }
            this._isValidating = false;
            if (!this._hasValidated) 
            {
                this._hasValidated = true;
                this.dispatchEventWith(feathers.events.FeathersEventType.CREATION_COMPLETE);
            }
            return;
        }

        public function isInvalid(arg1:String=null):Boolean
        {
            if (this._isAllInvalid) 
            {
                return true;
            }
            if (!arg1) 
            {
                var loc1:*=0;
                var loc2:*=this._invalidationFlags;
                for (arg1 in loc2) 
                {
                    return true;
                }
                return false;
            }
            return this._invalidationFlags[arg1];
        }

        public function setSize(arg1:Number, arg2:Number):void
        {
            var loc3:*=false;
            this._explicitWidth = arg1;
            var loc1:*=!(arg1 === arg1);
            if (loc1) 
            {
                var loc4:*;
                this.scaledActualWidth = loc4 = 0;
                this.actualWidth = loc4;
            }
            this._explicitHeight = arg2;
            var loc2:*=!(arg2 === arg2);
            if (loc2) 
            {
                this.scaledActualHeight = loc4 = 0;
                this.actualHeight = loc4;
            }
            if (loc1 || loc2) 
            {
                this.invalidate(INVALIDATION_FLAG_SIZE);
            }
            else 
            {
                loc3 = this.saveMeasurements(arg1, arg2, this.actualMinWidth, this.actualMinHeight);
                if (loc3) 
                {
                    this.invalidate(INVALIDATION_FLAG_SIZE);
                }
            }
            return;
        }

        public function move(arg1:Number, arg2:Number):void
        {
            this.x = arg1;
            this.y = arg2;
            return;
        }

        public function get isEnabled():Boolean
        {
            return this._isEnabled;
        }

        public function set isEnabled(arg1:Boolean):void
        {
            if (this._isEnabled == arg1) 
            {
                return;
            }
            this._isEnabled = arg1;
            this.invalidate(INVALIDATION_FLAG_STATE);
            return;
        }

        public function resetStyleProvider():void
        {
            this.styleProvider = this.defaultStyleProvider;
            return;
        }

        public function get explicitWidth():Number
        {
            return this._explicitWidth;
        }

        public function showFocus():void
        {
            if (!this._hasFocus || !this._focusIndicatorSkin) 
            {
                return;
            }
            this._showFocus = true;
            this.invalidate(INVALIDATION_FLAG_FOCUS);
            return;
        }

        public function hideFocus():void
        {
            if (!this._hasFocus || !this._focusIndicatorSkin) 
            {
                return;
            }
            this._showFocus = false;
            this.invalidate(INVALIDATION_FLAG_FOCUS);
            return;
        }

        public override function get width():Number
        {
            return this.scaledActualWidth;
        }

        public override function set width(arg1:Number):void
        {
            var loc2:*=false;
            var loc1:*=!(arg1 === arg1);
            if (loc1 && !(this._explicitWidth === this._explicitWidth)) 
            {
                return;
            }
            if (this.scaleX !== 1) 
            {
                arg1 = arg1 / this.scaleX;
            }
            if (this._explicitWidth == arg1) 
            {
                return;
            }
            this._explicitWidth = arg1;
            if (loc1) 
            {
                var loc3:*;
                this.scaledActualWidth = loc3 = 0;
                this.actualWidth = loc3;
                this.invalidate(INVALIDATION_FLAG_SIZE);
            }
            else 
            {
                loc2 = this.saveMeasurements(arg1, this.actualHeight, this.actualMinWidth, this.actualMinHeight);
                if (loc2) 
                {
                    this.invalidate(INVALIDATION_FLAG_SIZE);
                }
            }
            return;
        }

        public function initializeNow():void
        {
            if (this._isInitialized || this._isInitializing) 
            {
                return;
            }
            this._isInitializing = true;
            this.initialize();
            this.invalidate();
            this._isInitializing = false;
            this._isInitialized = true;
            this.dispatchEventWith(feathers.events.FeathersEventType.INITIALIZE);
            if (this._styleProvider !== null) 
            {
                this._applyingStyles = true;
                this._styleProvider.applyStyles(this);
                this._applyingStyles = false;
            }
            this._styleNameList.addEventListener(starling.events.Event.CHANGE, this.styleNameList_changeHandler);
            return;
        }

        public function get explicitHeight():Number
        {
            return this._explicitHeight;
        }

        protected function setSizeInternal(arg1:Number, arg2:Number, arg3:Boolean):Boolean
        {
            var loc1:*=this.saveMeasurements(arg1, arg2, this.actualMinWidth, this.actualMinHeight);
            if (arg3 && loc1) 
            {
                this.invalidate(INVALIDATION_FLAG_SIZE);
            }
            return loc1;
        }

        protected function saveMeasurements(arg1:Number, arg2:Number, arg3:Number=0, arg4:Number=0):Boolean
        {
            if (this._explicitMinWidth === this._explicitMinWidth) 
            {
                arg3 = this._explicitMinWidth;
            }
            if (this._explicitMinHeight === this._explicitMinHeight) 
            {
                arg4 = this._explicitMinHeight;
            }
            if (this._explicitWidth !== this._explicitWidth) 
            {
                if (arg1 < arg3) 
                {
                    arg1 = arg3;
                }
                else if (arg1 > this._explicitMaxWidth) 
                {
                    arg1 = this._explicitMaxWidth;
                }
            }
            else 
            {
                arg1 = this._explicitWidth;
            }
            if (this._explicitHeight !== this._explicitHeight) 
            {
                if (arg2 < arg4) 
                {
                    arg2 = arg4;
                }
                else if (arg2 > this._explicitMaxHeight) 
                {
                    arg2 = this._explicitMaxHeight;
                }
            }
            else 
            {
                arg2 = this._explicitHeight;
            }
            if (arg1 !== arg1) 
            {
                throw new ArgumentError(ILLEGAL_WIDTH_ERROR);
            }
            if (arg2 !== arg2) 
            {
                throw new ArgumentError(ILLEGAL_HEIGHT_ERROR);
            }
            var loc1:*=this.scaleX;
            if (loc1 < 0) 
            {
                loc1 = -loc1;
            }
            var loc2:*=this.scaleY;
            if (loc2 < 0) 
            {
                loc2 = -loc2;
            }
            var loc3:*=false;
            if (this.actualWidth !== arg1) 
            {
                this.actualWidth = arg1;
                this.refreshHitAreaX();
                loc3 = true;
            }
            if (this.actualHeight !== arg2) 
            {
                this.actualHeight = arg2;
                this.refreshHitAreaY();
                loc3 = true;
            }
            if (this.actualMinWidth !== arg3) 
            {
                this.actualMinWidth = arg3;
                loc3 = true;
            }
            if (this.actualMinHeight !== arg4) 
            {
                this.actualMinHeight = arg4;
                loc3 = true;
            }
            arg1 = this.scaledActualWidth;
            arg2 = this.scaledActualHeight;
            this.scaledActualWidth = this.actualWidth * loc1;
            this.scaledActualHeight = this.actualHeight * loc2;
            this.scaledActualMinWidth = this.actualMinWidth * loc1;
            this.scaledActualMinHeight = this.actualMinHeight * loc2;
            if (!(arg1 === this.scaledActualWidth) || !(arg2 === this.scaledActualHeight)) 
            {
                loc3 = true;
                this.dispatchEventWith(starling.events.Event.RESIZE);
            }
            return loc3;
        }

        public override function get height():Number
        {
            return this.scaledActualHeight;
        }

        public override function set height(arg1:Number):void
        {
            var loc2:*=false;
            var loc1:*=!(arg1 === arg1);
            if (loc1 && !(this._explicitHeight === this._explicitHeight)) 
            {
                return;
            }
            if (this.scaleY !== 1) 
            {
                arg1 = arg1 / this.scaleY;
            }
            if (this._explicitHeight == arg1) 
            {
                return;
            }
            this._explicitHeight = arg1;
            if (loc1) 
            {
                var loc3:*;
                this.scaledActualHeight = loc3 = 0;
                this.actualHeight = loc3;
                this.invalidate(INVALIDATION_FLAG_SIZE);
            }
            else 
            {
                loc2 = this.saveMeasurements(this.actualWidth, arg1, this.actualMinWidth, this.actualMinHeight);
                if (loc2) 
                {
                    this.invalidate(INVALIDATION_FLAG_SIZE);
                }
            }
            return;
        }

        protected function initialize():void
        {
            return;
        }

        public function get minTouchWidth():Number
        {
            return this._minTouchWidth;
        }

        public function set minTouchWidth(arg1:Number):void
        {
            if (this._minTouchWidth == arg1) 
            {
                return;
            }
            this._minTouchWidth = arg1;
            this.refreshHitAreaX();
            return;
        }

        protected function draw():void
        {
            return;
        }

        public function get minTouchHeight():Number
        {
            return this._minTouchHeight;
        }

        public function set minTouchHeight(arg1:Number):void
        {
            if (this._minTouchHeight == arg1) 
            {
                return;
            }
            this._minTouchHeight = arg1;
            this.refreshHitAreaY();
            return;
        }

        protected function setInvalidationFlag(arg1:String):void
        {
            if (this._invalidationFlags.hasOwnProperty(arg1)) 
            {
                return;
            }
            this._invalidationFlags[arg1] = true;
            return;
        }

        public function get explicitMinWidth():Number
        {
            return this._explicitMinWidth;
        }

        protected function clearInvalidationFlag(arg1:String):void
        {
            delete this._invalidationFlags[arg1];
            return;
        }

        protected function processStyleRestriction(arg1:Object):Boolean
        {
            if (this._applyingStyles) 
            {
                return !(this._restrictedStyles === null) && arg1 in this._restrictedStyles;
            }
            if (this._restrictedStyles === null) 
            {
                this._restrictedStyles = new flash.utils.Dictionary();
            }
            this._restrictedStyles[arg1] = true;
            return false;
        }

        public function get minWidth():Number
        {
            return this.scaledActualMinWidth;
        }

        public function set minWidth(arg1:Number):void
        {
            var loc1:*=!(arg1 === arg1);
            if (loc1 && !(this._explicitMinWidth === this._explicitMinWidth)) 
            {
                return;
            }
            if (this.scaleX !== 1) 
            {
                arg1 = arg1 / this.scaleX;
            }
            if (this._explicitMinWidth == arg1) 
            {
                return;
            }
            var loc2:*=this._explicitMinWidth;
            this._explicitMinWidth = arg1;
            if (loc1) 
            {
                var loc3:*;
                this.scaledActualMinWidth = loc3 = 0;
                this.actualMinWidth = loc3;
                this.invalidate(INVALIDATION_FLAG_SIZE);
            }
            else 
            {
                this.saveMeasurements(this.actualWidth, this.actualHeight, arg1, this.actualMinHeight);
                if (!(this._explicitWidth === this._explicitWidth) && (this.actualWidth < arg1 || this.actualWidth === loc2)) 
                {
                    this.invalidate(INVALIDATION_FLAG_SIZE);
                }
            }
            return;
        }

        protected function refreshFocusIndicator():void
        {
            if (this._focusIndicatorSkin) 
            {
                if (this._hasFocus && this._showFocus) 
                {
                    if (this._focusIndicatorSkin.parent == this) 
                    {
                        this.setChildIndex(this._focusIndicatorSkin, (this.numChildren - 1));
                    }
                    else 
                    {
                        this.addChild(this._focusIndicatorSkin);
                    }
                }
                else if (this._focusIndicatorSkin.parent) 
                {
                    this._focusIndicatorSkin.removeFromParent(false);
                }
                this._focusIndicatorSkin.x = this._focusPaddingLeft;
                this._focusIndicatorSkin.y = this._focusPaddingTop;
                this._focusIndicatorSkin.width = this.actualWidth - this._focusPaddingLeft - this._focusPaddingRight;
                this._focusIndicatorSkin.height = this.actualHeight - this._focusPaddingTop - this._focusPaddingBottom;
            }
            return;
        }

        public function get explicitMinHeight():Number
        {
            return this._explicitMinHeight;
        }

        protected function refreshHitAreaX():void
        {
            if (this.actualWidth < this._minTouchWidth) 
            {
                this._hitArea.width = this._minTouchWidth;
            }
            else 
            {
                this._hitArea.width = this.actualWidth;
            }
            var loc1:*=(this.actualWidth - this._hitArea.width) / 2;
            if (loc1 === loc1) 
            {
                this._hitArea.x = loc1;
            }
            else 
            {
                this._hitArea.x = 0;
            }
            return;
        }

        protected function refreshHitAreaY():void
        {
            if (this.actualHeight < this._minTouchHeight) 
            {
                this._hitArea.height = this._minTouchHeight;
            }
            else 
            {
                this._hitArea.height = this.actualHeight;
            }
            var loc1:*=(this.actualHeight - this._hitArea.height) / 2;
            if (loc1 === loc1) 
            {
                this._hitArea.y = loc1;
            }
            else 
            {
                this._hitArea.y = 0;
            }
            return;
        }

        public function get minHeight():Number
        {
            return this.scaledActualMinHeight;
        }

        public function set minHeight(arg1:Number):void
        {
            var loc1:*=!(arg1 === arg1);
            if (loc1 && !(this._explicitMinHeight === this._explicitMinHeight)) 
            {
                return;
            }
            if (this.scaleY !== 1) 
            {
                arg1 = arg1 / this.scaleY;
            }
            if (this._explicitMinHeight == arg1) 
            {
                return;
            }
            var loc2:*=this._explicitMinHeight;
            this._explicitMinHeight = arg1;
            if (loc1) 
            {
                var loc3:*;
                this.scaledActualMinHeight = loc3 = 0;
                this.actualMinHeight = loc3;
                this.invalidate(INVALIDATION_FLAG_SIZE);
            }
            else 
            {
                this.saveMeasurements(this.actualWidth, this.actualHeight, this.actualMinWidth, arg1);
                if (!(this._explicitHeight === this._explicitHeight) && (this.actualHeight < arg1 || this.actualHeight === loc2)) 
                {
                    this.invalidate(INVALIDATION_FLAG_SIZE);
                }
            }
            return;
        }

        protected function focusInHandler(arg1:starling.events.Event):void
        {
            this._hasFocus = true;
            this.invalidate(INVALIDATION_FLAG_FOCUS);
            return;
        }

        public function get explicitMaxWidth():Number
        {
            return this._explicitMaxWidth;
        }

        public function get maxWidth():Number
        {
            return this._explicitMaxWidth;
        }

        public function set maxWidth(arg1:Number):void
        {
            if (arg1 < 0) 
            {
                arg1 = 0;
            }
            if (this._explicitMaxWidth == arg1) 
            {
                return;
            }
            if (arg1 !== arg1) 
            {
                throw new ArgumentError("maxWidth cannot be NaN");
            }
            var loc1:*=this._explicitMaxWidth;
            this._explicitMaxWidth = arg1;
            if (!(this._explicitWidth === this._explicitWidth) && (this.actualWidth > arg1 || this.actualWidth === loc1)) 
            {
                this.invalidate(INVALIDATION_FLAG_SIZE);
            }
            return;
        }

        public function set focusOwner(arg1:feathers.core.IFocusDisplayObject):void
        {
            this._focusOwner = arg1;
            return;
        }

        public function get explicitMaxHeight():Number
        {
            return this._explicitMaxHeight;
        }

        public function get maxHeight():Number
        {
            return this._explicitMaxHeight;
        }

        public function set maxHeight(arg1:Number):void
        {
            if (arg1 < 0) 
            {
                arg1 = 0;
            }
            if (this._explicitMaxHeight == arg1) 
            {
                return;
            }
            if (arg1 !== arg1) 
            {
                throw new ArgumentError("maxHeight cannot be NaN");
            }
            var loc1:*=this._explicitMaxHeight;
            this._explicitMaxHeight = arg1;
            if (!(this._explicitHeight === this._explicitHeight) && (this.actualHeight > arg1 || this.actualHeight === loc1)) 
            {
                this.invalidate(INVALIDATION_FLAG_SIZE);
            }
            return;
        }

        public override function set scaleX(arg1:Number):void
        {
            super.scaleX = arg1;
            this.saveMeasurements(this.actualWidth, this.actualHeight, this.actualMinWidth, this.actualMinHeight);
            return;
        }

        public override function set scaleY(arg1:Number):void
        {
            super.scaleY = arg1;
            this.saveMeasurements(this.actualWidth, this.actualHeight, this.actualMinWidth, this.actualMinHeight);
            return;
        }

        protected function focusOutHandler(arg1:starling.events.Event):void
        {
            this._hasFocus = false;
            this._showFocus = false;
            this.invalidate(INVALIDATION_FLAG_FOCUS);
            return;
        }

        public function get includeInLayout():Boolean
        {
            return this._includeInLayout;
        }

        public function set includeInLayout(arg1:Boolean):void
        {
            if (this._includeInLayout == arg1) 
            {
                return;
            }
            this._includeInLayout = arg1;
            this.dispatchEventWith(feathers.events.FeathersEventType.LAYOUT_DATA_CHANGE);
            return;
        }

        protected function feathersControl_addedToStageHandler(arg1:starling.events.Event):void
        {
            this._depth = feathers.utils.display.getDisplayObjectDepthFromStage(this);
            var loc1:*=feathers.utils.display.stageToStarling(this.stage);
            this._validationQueue = feathers.core.ValidationQueue.forStarling(loc1);
            if (!this._isInitialized) 
            {
                this.initializeNow();
            }
            if (this.isInvalid()) 
            {
                this._invalidateCount = 0;
                this._validationQueue.addControl(this);
            }
            return;
        }

        public function get layoutData():feathers.layout.ILayoutData
        {
            return this._layoutData;
        }

        public function set layoutData(arg1:feathers.layout.ILayoutData):void
        {
            if (this._layoutData == arg1) 
            {
                return;
            }
            if (this._layoutData) 
            {
                this._layoutData.removeEventListener(starling.events.Event.CHANGE, this.layoutData_changeHandler);
            }
            this._layoutData = arg1;
            if (this._layoutData) 
            {
                this._layoutData.addEventListener(starling.events.Event.CHANGE, this.layoutData_changeHandler);
            }
            this.dispatchEventWith(feathers.events.FeathersEventType.LAYOUT_DATA_CHANGE);
            return;
        }

        protected function feathersControl_removedFromStageHandler(arg1:starling.events.Event):void
        {
            this._depth = -1;
            this._validationQueue = null;
            return;
        }

        public function get toolTip():String
        {
            return this._toolTip;
        }

        public function set toolTip(arg1:String):void
        {
            this._toolTip = arg1;
            return;
        }

        protected function styleNameList_changeHandler(arg1:starling.events.Event):void
        {
            if (this._styleProvider === null) 
            {
                return;
            }
            if (this._applyingStyles) 
            {
                throw new flash.errors.IllegalOperationError("Cannot change styleNameList while the style provider is applying styles.");
            }
            this._applyingStyles = true;
            this._styleProvider.applyStyles(this);
            this._applyingStyles = false;
            return;
        }

        public function get focusManager():feathers.core.IFocusManager
        {
            return this._focusManager;
        }

        public function set focusManager(arg1:feathers.core.IFocusManager):void
        {
            if (!(this is feathers.core.IFocusDisplayObject)) 
            {
                throw new flash.errors.IllegalOperationError("Cannot pass a focus manager to a component that does not implement feathers.core.IFocusDisplayObject");
            }
            if (this._focusManager == arg1) 
            {
                return;
            }
            this._focusManager = arg1;
            return;
        }

        
        {
            defaultTextRendererFactory = function ():feathers.core.ITextRenderer
            {
                return new feathers.controls.text.BitmapFontTextRenderer();
            }
            defaultTextEditorFactory = function ():feathers.core.ITextEditor
            {
                return new feathers.controls.text.StageTextTextEditor();
            }
        }

        public function get focusOwner():feathers.core.IFocusDisplayObject
        {
            return this._focusOwner;
        }

        protected function layoutData_changeHandler(arg1:starling.events.Event):void
        {
            this.dispatchEventWith(feathers.events.FeathersEventType.LAYOUT_DATA_CHANGE);
            return;
        }

        public function get isFocusEnabled():Boolean
        {
            return this._isEnabled && this._isFocusEnabled;
        }

        public function set isFocusEnabled(arg1:Boolean):void
        {
            if (!(this is feathers.core.IFocusDisplayObject)) 
            {
                throw new flash.errors.IllegalOperationError("Cannot enable focus on a component that does not implement feathers.core.IFocusDisplayObject");
            }
            if (this._isFocusEnabled == arg1) 
            {
                return;
            }
            this._isFocusEnabled = arg1;
            return;
        }

        public function get nextTabFocus():feathers.core.IFocusDisplayObject
        {
            return this._nextTabFocus;
        }

        public function set nextTabFocus(arg1:feathers.core.IFocusDisplayObject):void
        {
            if (!(this is feathers.core.IFocusDisplayObject)) 
            {
                throw new flash.errors.IllegalOperationError("Cannot set next tab focus on a component that does not implement feathers.core.IFocusDisplayObject");
            }
            this._nextTabFocus = arg1;
            return;
        }

        public function get previousTabFocus():feathers.core.IFocusDisplayObject
        {
            return this._previousTabFocus;
        }

        public function set previousTabFocus(arg1:feathers.core.IFocusDisplayObject):void
        {
            if (!(this is feathers.core.IFocusDisplayObject)) 
            {
                throw new flash.errors.IllegalOperationError("Cannot set previous tab focus on a component that does not implement feathers.core.IFocusDisplayObject");
            }
            this._previousTabFocus = arg1;
            return;
        }

        public function get focusIndicatorSkin():starling.display.DisplayObject
        {
            return this._focusIndicatorSkin;
        }

        public function set focusIndicatorSkin(arg1:starling.display.DisplayObject):void
        {
            if (!(this is feathers.core.IFocusDisplayObject)) 
            {
                throw new flash.errors.IllegalOperationError("Cannot set focus indicator skin on a component that does not implement feathers.core.IFocusDisplayObject");
            }
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._focusIndicatorSkin === arg1) 
            {
                return;
            }
            if (this._focusIndicatorSkin) 
            {
                if (this._focusIndicatorSkin.parent == this) 
                {
                    this._focusIndicatorSkin.removeFromParent(false);
                }
                if (this._focusIndicatorSkin is feathers.core.IStateObserver && this is feathers.core.IStateContext) 
                {
                    feathers.core.IStateObserver(this._focusIndicatorSkin).stateContext = null;
                }
            }
            this._focusIndicatorSkin = arg1;
            if (this._focusIndicatorSkin) 
            {
                this._focusIndicatorSkin.touchable = false;
            }
            if (this._focusIndicatorSkin is feathers.core.IStateObserver && this is feathers.core.IStateContext) 
            {
                feathers.core.IStateObserver(this._focusIndicatorSkin).stateContext = feathers.core.IStateContext(this);
            }
            if (this._focusManager && this._focusManager.focus == this) 
            {
                this.invalidate(INVALIDATION_FLAG_STYLES);
            }
            return;
        }

        public function get focusPadding():Number
        {
            return this._focusPaddingTop;
        }

        public function set focusPadding(arg1:Number):void
        {
            this.focusPaddingTop = arg1;
            this.focusPaddingRight = arg1;
            this.focusPaddingBottom = arg1;
            this.focusPaddingLeft = arg1;
            return;
        }

        public function get focusPaddingTop():Number
        {
            return this._focusPaddingTop;
        }

        public function set focusPaddingTop(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._focusPaddingTop === arg1) 
            {
                return;
            }
            this._focusPaddingTop = arg1;
            this.invalidate(INVALIDATION_FLAG_FOCUS);
            return;
        }

        public function get focusPaddingRight():Number
        {
            return this._focusPaddingRight;
        }

        public function get focusPaddingBottom():Number
        {
            return this._focusPaddingBottom;
        }

        public static const INVALIDATION_FLAG_FOCUS:String="focus";

        internal static const HELPER_POINT:flash.geom.Point=new flash.geom.Point();

        public static const INVALIDATION_FLAG_ALL:String="all";

        public static const INVALIDATION_FLAG_STATE:String="state";

        public static const INVALIDATION_FLAG_SIZE:String="size";

        public static const INVALIDATION_FLAG_STYLES:String="styles";

        public static const INVALIDATION_FLAG_SKIN:String="skin";

        public static const INVALIDATION_FLAG_LAYOUT:String="layout";

        public static const INVALIDATION_FLAG_DATA:String="data";

        public static const INVALIDATION_FLAG_SCROLL:String="scroll";

        public static const INVALIDATION_FLAG_SELECTED:String="selected";

        protected static const INVALIDATION_FLAG_TEXT_RENDERER:String="textRenderer";

        protected static const INVALIDATION_FLAG_TEXT_EDITOR:String="textEditor";

        protected static const ILLEGAL_WIDTH_ERROR:String="A component\'s width cannot be NaN.";

        protected static const ILLEGAL_HEIGHT_ERROR:String="A component\'s height cannot be NaN.";

        protected static const ABSTRACT_CLASS_ERROR:String="FeathersControl is an abstract class. For a lightweight Feathers wrapper, use feathers.controls.LayoutGroup.";

        protected var _explicitHeight:Number=NaN;

        protected var actualHeight:Number=0;

        protected var scaledActualHeight:Number=0;

        protected var _minTouchWidth:Number=0;

        protected var _minTouchHeight:Number=0;

        protected var _explicitMinWidth:Number=NaN;

        protected var actualMinWidth:Number=0;

        protected var scaledActualMinWidth:Number=0;

        protected var _explicitMinHeight:Number=NaN;

        protected var actualMinHeight:Number=0;

        protected var scaledActualMinHeight:Number=0;

        protected var _explicitMaxWidth:Number=Infinity;

        protected var _includeInLayout:Boolean=true;

        protected var _layoutData:feathers.layout.ILayoutData;

        protected var _toolTip:String;

        protected var _focusManager:feathers.core.IFocusManager;

        protected var _focusOwner:feathers.core.IFocusDisplayObject;

        protected var _depth:int=-1;

        protected var _restrictedStyles:flash.utils.Dictionary;

        protected var _invalidateCount:int=0;

        protected var _explicitMaxHeight:Number=Infinity;

        protected var _focusPaddingBottom:Number=0;

        protected var _isDisposed:Boolean=false;

        protected var _focusIndicatorSkin:starling.display.DisplayObject;

        protected var _focusPaddingTop:Number=0;

        protected var _focusPaddingLeft:Number=0;

        protected var _previousTabFocus:feathers.core.IFocusDisplayObject;

        protected var _isFocusEnabled:Boolean=true;

        protected var _hasFocus:Boolean=false;

        protected var _showFocus:Boolean=false;

        protected var _isValidating:Boolean=false;

        protected var _applyingStyles:Boolean=false;

        protected var _hasValidated:Boolean=false;

        protected var _validationQueue:feathers.core.ValidationQueue;

        protected var _id:String;

        protected var _styleNameList:feathers.core.TokenList;

        protected var _styleProvider:feathers.skins.IStyleProvider;

        protected var _isQuickHitAreaEnabled:Boolean=false;

        protected var _hitArea:flash.geom.Rectangle;

        protected var _isInitializing:Boolean=false;

        protected var _isInitialized:Boolean=false;

        protected var _isAllInvalid:Boolean=false;

        protected var _invalidationFlags:Object;

        protected var _nextTabFocus:feathers.core.IFocusDisplayObject;

        protected var _delayedInvalidationFlags:Object;

        protected var _isEnabled:Boolean=true;

        protected var _explicitWidth:Number=NaN;

        protected var actualWidth:Number=0;

        protected var scaledActualWidth:Number=0;

        public static var defaultTextRendererFactory:Function;

        public static var defaultTextEditorFactory:Function;

        protected var _focusPaddingRight:Number=0;
    }
}


//  class FocusManager
package feathers.core 
{
    import __AS3__.vec.*;
    import flash.utils.*;
    import starling.core.*;
    import starling.display.*;
    
    public class FocusManager extends Object
    {
        public function FocusManager()
        {
            super();
            return;
        }

        public function disableAll():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=0;
            var loc6:*=STAGE_TO_STACK;
            for (loc1 in loc6) 
            {
                loc2 = starling.display.Stage(loc1);
                loc3 = STAGE_TO_STACK[loc2];
                while (loc3.length > 0) 
                {
                    loc4 = loc3.pop();
                    loc4.isEnabled = false;
                }
                delete STAGE_TO_STACK[loc2];
            }
            return;
        }

        public static function getFocusManagerForStage(arg1:starling.display.Stage):feathers.core.IFocusManager
        {
            var loc1:*=STAGE_TO_STACK[arg1] as Vector.<feathers.core.IFocusManager>;
            if (!loc1) 
            {
                return null;
            }
            return loc1[(loc1.length - 1)];
        }

        public static function defaultFocusManagerFactory(arg1:starling.display.DisplayObjectContainer):feathers.core.IFocusManager
        {
            return new feathers.core.DefaultFocusManager(arg1);
        }

        public static function isEnabledForStage(arg1:starling.display.Stage):Boolean
        {
            var loc1:*=STAGE_TO_STACK[arg1];
            return !(loc1 == null);
        }

        public static function setEnabledForStage(arg1:starling.display.Stage, arg2:Boolean):void
        {
            var loc2:*=null;
            var loc1:*=STAGE_TO_STACK[arg1];
            if (arg2 && loc1 || !arg2 && !loc1) 
            {
                return;
            }
            if (arg2) 
            {
                STAGE_TO_STACK[arg1] = new Vector.<feathers.core.IFocusManager>(0);
                pushFocusManager(arg1);
            }
            else 
            {
                while (loc1.length > 0) 
                {
                    loc2 = loc1.pop();
                    loc2.isEnabled = false;
                }
                delete STAGE_TO_STACK[arg1];
            }
            return;
        }

        public static function get focus():feathers.core.IFocusDisplayObject
        {
            var loc1:*=getFocusManagerForStage(starling.core.Starling.current.stage);
            if (loc1) 
            {
                return loc1.focus;
            }
            return null;
        }

        public static function set focus(arg1:feathers.core.IFocusDisplayObject):void
        {
            var loc1:*=getFocusManagerForStage(starling.core.Starling.current.stage);
            if (!loc1) 
            {
                throw new Error(FOCUS_MANAGER_NOT_ENABLED_ERROR);
            }
            loc1.focus = arg1;
            return;
        }

        public static function pushFocusManager(arg1:starling.display.DisplayObjectContainer):feathers.core.IFocusManager
        {
            var loc4:*=null;
            var loc1:*=arg1.stage;
            if (!loc1) 
            {
                throw new ArgumentError(FOCUS_MANAGER_ROOT_MUST_BE_ON_STAGE_ERROR);
            }
            var loc2:*=STAGE_TO_STACK[loc1] as Vector.<feathers.core.IFocusManager>;
            if (!loc2) 
            {
                throw new Error(FOCUS_MANAGER_NOT_ENABLED_ERROR);
            }
            var loc3:*=feathers.core.FocusManager.focusManagerFactory(arg1);
            loc3.isEnabled = true;
            if (loc2.length > 0) 
            {
                loc4 = loc2[(loc2.length - 1)];
                loc4.isEnabled = false;
            }
            loc2.push(loc3);
            return loc3;
        }

        public static function removeFocusManager(arg1:feathers.core.IFocusManager):void
        {
            var loc1:*=arg1.root.stage;
            var loc2:*=STAGE_TO_STACK[loc1] as Vector.<feathers.core.IFocusManager>;
            if (!loc2) 
            {
                throw new Error(FOCUS_MANAGER_NOT_ENABLED_ERROR);
            }
            var loc3:*=loc2.indexOf(arg1);
            if (loc3 < 0) 
            {
                return;
            }
            arg1.isEnabled = false;
            loc2.removeAt(loc3);
            if (loc3 > 0 && loc3 == loc2.length) 
            {
                arg1 = loc2[(loc2.length - 1)];
                arg1.isEnabled = true;
            }
            return;
        }

        
        {
            focusManagerFactory = defaultFocusManagerFactory;
        }

        protected static const FOCUS_MANAGER_NOT_ENABLED_ERROR:String="The specified action is not permitted when the focus manager is not enabled.";

        protected static const FOCUS_MANAGER_ROOT_MUST_BE_ON_STAGE_ERROR:String="A focus manager may not be added or removed for a display object that is not on stage.";

        protected static const STAGE_TO_STACK:flash.utils.Dictionary=new flash.utils.Dictionary(true);

        public static var focusManagerFactory:Function;
    }
}


//  class IAdvancedNativeFocusOwner
package feathers.core 
{
    public interface IAdvancedNativeFocusOwner extends feathers.core.INativeFocusOwner
    {
        function get hasFocus():Boolean;

        function setFocus():void;
    }
}


//  class IApplication
package feathers.core 
{
    public interface IApplication
    {
        function get theme():Class;

        function set theme(arg1:Class):void;

        function get context3DProfile():String;

        function set context3DProfile(arg1:String):void;

        function get shareContext():Boolean;

        function set shareContext(arg1:Boolean):void;

        function get skipUnchangedFrames():Boolean;

        function set skipUnchangedFrames(arg1:Boolean):void;

        function get showStats():Boolean;

        function set showStats(arg1:Boolean):void;
    }
}


//  class IFeathersControl
package feathers.core 
{
    import feathers.skins.*;
    
    public interface IFeathersControl extends feathers.core.IValidating, feathers.core.IMeasureDisplayObject
    {
        function get isEnabled():Boolean;

        function set isEnabled(arg1:Boolean):void;

        function get isInitialized():Boolean;

        function get isCreated():Boolean;

        function get styleNameList():feathers.core.TokenList;

        function get styleName():String;

        function set styleName(arg1:String):void;

        function get styleProvider():feathers.skins.IStyleProvider;

        function set styleProvider(arg1:feathers.skins.IStyleProvider):void;

        function get toolTip():String;

        function set toolTip(arg1:String):void;

        function setSize(arg1:Number, arg2:Number):void;

        function move(arg1:Number, arg2:Number):void;

        function resetStyleProvider():void;

        function initializeNow():void;
    }
}


//  class IFeathersDisplayObject
package feathers.core 
{
    import flash.geom.*;
    import starling.display.*;
    import starling.filters.*;
    import starling.rendering.*;
    
    public interface IFeathersDisplayObject extends feathers.core.IFeathersEventDispatcher
    {
        function get x():Number;

        function set x(arg1:Number):void;

        function get y():Number;

        function set y(arg1:Number):void;

        function get width():Number;

        function set width(arg1:Number):void;

        function get height():Number;

        function set height(arg1:Number):void;

        function get pivotX():Number;

        function set pivotX(arg1:Number):void;

        function get pivotY():Number;

        function set pivotY(arg1:Number):void;

        function get scaleX():Number;

        function set scaleX(arg1:Number):void;

        function get scaleY():Number;

        function set scaleY(arg1:Number):void;

        function get skewX():Number;

        function set skewX(arg1:Number):void;

        function get skewY():Number;

        function set skewY(arg1:Number):void;

        function get blendMode():String;

        function set blendMode(arg1:String):void;

        function get name():String;

        function set name(arg1:String):void;

        function get touchable():Boolean;

        function set touchable(arg1:Boolean):void;

        function get visible():Boolean;

        function set visible(arg1:Boolean):void;

        function get alpha():Number;

        function set alpha(arg1:Number):void;

        function get rotation():Number;

        function set rotation(arg1:Number):void;

        function get mask():starling.display.DisplayObject;

        function set mask(arg1:starling.display.DisplayObject):void;

        function get parent():starling.display.DisplayObjectContainer;

        function get base():starling.display.DisplayObject;

        function get root():starling.display.DisplayObject;

        function get stage():starling.display.Stage;

        function get transformationMatrix():flash.geom.Matrix;

        function get useHandCursor():Boolean;

        function set useHandCursor(arg1:Boolean):void;

        function get bounds():flash.geom.Rectangle;

        function get filter():starling.filters.FragmentFilter;

        function set filter(arg1:starling.filters.FragmentFilter):void;

        function removeFromParent(arg1:Boolean=false):void;

        function hitTest(arg1:flash.geom.Point):starling.display.DisplayObject;

        function localToGlobal(arg1:flash.geom.Point, arg2:flash.geom.Point=null):flash.geom.Point;

        function globalToLocal(arg1:flash.geom.Point, arg2:flash.geom.Point=null):flash.geom.Point;

        function getTransformationMatrix(arg1:starling.display.DisplayObject, arg2:flash.geom.Matrix=null):flash.geom.Matrix;

        function getBounds(arg1:starling.display.DisplayObject, arg2:flash.geom.Rectangle=null):flash.geom.Rectangle;

        function render(arg1:starling.rendering.Painter):void;

        function dispose():void;
    }
}


//  class IFeathersEventDispatcher
package feathers.core 
{
    import starling.events.*;
    
    public interface IFeathersEventDispatcher
    {
        function addEventListener(arg1:String, arg2:Function):void;

        function removeEventListener(arg1:String, arg2:Function):void;

        function removeEventListeners(arg1:String=null):void;

        function dispatchEvent(arg1:starling.events.Event):void;

        function dispatchEventWith(arg1:String, arg2:Boolean=false, arg3:Object=null):void;

        function hasEventListener(arg1:String, arg2:Function=null):Boolean;
    }
}


//  class IFocusContainer
package feathers.core 
{
    public interface IFocusContainer extends feathers.core.IFocusDisplayObject
    {
        function get isChildFocusEnabled():Boolean;

        function set isChildFocusEnabled(arg1:Boolean):void;
    }
}


//  class IFocusDisplayObject
package feathers.core 
{
    public interface IFocusDisplayObject extends feathers.core.IFeathersDisplayObject
    {
        function get focusManager():feathers.core.IFocusManager;

        function set focusManager(arg1:feathers.core.IFocusManager):void;

        function get isFocusEnabled():Boolean;

        function set isFocusEnabled(arg1:Boolean):void;

        function get nextTabFocus():feathers.core.IFocusDisplayObject;

        function set nextTabFocus(arg1:feathers.core.IFocusDisplayObject):void;

        function get previousTabFocus():feathers.core.IFocusDisplayObject;

        function set previousTabFocus(arg1:feathers.core.IFocusDisplayObject):void;

        function get focusOwner():feathers.core.IFocusDisplayObject;

        function set focusOwner(arg1:feathers.core.IFocusDisplayObject):void;

        function showFocus():void;

        function hideFocus():void;
    }
}


//  class IFocusExtras
package feathers.core 
{
    import __AS3__.vec.*;
    
    public interface IFocusExtras
    {
        function get focusExtrasBefore():__AS3__.vec.Vector.<starling.display.DisplayObject>;

        function get focusExtrasAfter():__AS3__.vec.Vector.<starling.display.DisplayObject>;
    }
}


//  class IFocusManager
package feathers.core 
{
    import starling.display.*;
    
    public interface IFocusManager
    {
        function get isEnabled():Boolean;

        function set isEnabled(arg1:Boolean):void;

        function get focus():feathers.core.IFocusDisplayObject;

        function set focus(arg1:feathers.core.IFocusDisplayObject):void;

        function get root():starling.display.DisplayObjectContainer;
    }
}


//  class IGroupedToggle
package feathers.core 
{
    public interface IGroupedToggle extends feathers.core.IToggle
    {
        function get toggleGroup():feathers.core.ToggleGroup;

        function set toggleGroup(arg1:feathers.core.ToggleGroup):void;
    }
}


//  class IIMETextEditor
package feathers.core 
{
    public interface IIMETextEditor extends feathers.core.ITextEditor
    {
        function get selectionAnchorIndex():int;

        function get selectionActiveIndex():int;
    }
}


//  class IMeasureDisplayObject
package feathers.core 
{
    public interface IMeasureDisplayObject extends feathers.core.IFeathersDisplayObject
    {
        function get explicitWidth():Number;

        function get explicitMinWidth():Number;

        function get minWidth():Number;

        function set minWidth(arg1:Number):void;

        function get explicitMaxWidth():Number;

        function get maxWidth():Number;

        function set maxWidth(arg1:Number):void;

        function get explicitHeight():Number;

        function get explicitMinHeight():Number;

        function get minHeight():Number;

        function set minHeight(arg1:Number):void;

        function get explicitMaxHeight():Number;

        function get maxHeight():Number;

        function set maxHeight(arg1:Number):void;
    }
}


//  class IMultilineTextEditor
package feathers.core 
{
    public interface IMultilineTextEditor extends feathers.core.ITextEditor
    {
        function get multiline():Boolean;

        function set multiline(arg1:Boolean):void;
    }
}


//  class INativeFocusOwner
package feathers.core 
{
    public interface INativeFocusOwner extends feathers.core.IFocusDisplayObject
    {
        function get nativeFocus():Object;
    }
}


//  class IPopUpManager
package feathers.core 
{
    import starling.display.*;
    
    public interface IPopUpManager
    {
        function get overlayFactory():Function;

        function set overlayFactory(arg1:Function):void;

        function get root():starling.display.DisplayObjectContainer;

        function set root(arg1:starling.display.DisplayObjectContainer):void;

        function get popUpCount():int;

        function addPopUp(arg1:starling.display.DisplayObject, arg2:Boolean=true, arg3:Boolean=true, arg4:Function=null):starling.display.DisplayObject;

        function removePopUp(arg1:starling.display.DisplayObject, arg2:Boolean=false):starling.display.DisplayObject;

        function removeAllPopUps(arg1:Boolean=false):void;

        function isPopUp(arg1:starling.display.DisplayObject):Boolean;

        function isTopLevelPopUp(arg1:starling.display.DisplayObject):Boolean;

        function centerPopUp(arg1:starling.display.DisplayObject):void;
    }
}


//  class IStateContext
package feathers.core 
{
    public interface IStateContext extends feathers.core.IFeathersEventDispatcher
    {
        function get currentState():String;
    }
}


//  class IStateObserver
package feathers.core 
{
    public interface IStateObserver
    {
        function get stateContext():feathers.core.IStateContext;

        function set stateContext(arg1:feathers.core.IStateContext):void;
    }
}


//  class ITextBaselineControl
package feathers.core 
{
    public interface ITextBaselineControl extends feathers.core.IFeathersControl
    {
        function get baseline():Number;
    }
}


//  class ITextEditor
package feathers.core 
{
    import feathers.text.*;
    import flash.geom.*;
    
    public interface ITextEditor extends feathers.core.IFeathersControl, feathers.core.ITextBaselineControl
    {
        function get text():String;

        function set text(arg1:String):void;

        function get displayAsPassword():Boolean;

        function set displayAsPassword(arg1:Boolean):void;

        function get maxChars():int;

        function set maxChars(arg1:int):void;

        function get restrict():String;

        function set restrict(arg1:String):void;

        function get isEditable():Boolean;

        function set isEditable(arg1:Boolean):void;

        function get isSelectable():Boolean;

        function set isSelectable(arg1:Boolean):void;

        function get setTouchFocusOnEndedPhase():Boolean;

        function get selectionBeginIndex():int;

        function get selectionEndIndex():int;

        function get fontStyles():feathers.text.FontStylesSet;

        function set fontStyles(arg1:feathers.text.FontStylesSet):void;

        function setFocus(arg1:flash.geom.Point=null):void;

        function clearFocus():void;

        function selectRange(arg1:int, arg2:int):void;

        function measureText(arg1:flash.geom.Point=null):flash.geom.Point;
    }
}


//  class ITextRenderer
package feathers.core 
{
    import feathers.text.*;
    import flash.geom.*;
    
    public interface ITextRenderer extends feathers.core.IStateObserver, feathers.core.IFeathersControl, feathers.core.ITextBaselineControl
    {
        function get text():String;

        function set text(arg1:String):void;

        function get wordWrap():Boolean;

        function set wordWrap(arg1:Boolean):void;

        function get numLines():int;

        function get fontStyles():feathers.text.FontStylesSet;

        function set fontStyles(arg1:feathers.text.FontStylesSet):void;

        function measureText(arg1:flash.geom.Point=null):flash.geom.Point;
    }
}


//  class IToggle
package feathers.core 
{
    public interface IToggle extends feathers.core.IFeathersControl
    {
        function get isSelected():Boolean;

        function set isSelected(arg1:Boolean):void;
    }
}


//  class IToolTip
package feathers.core 
{
    public interface IToolTip extends feathers.core.IFeathersControl
    {
        function get text():String;

        function set text(arg1:String):void;
    }
}


//  class IValidating
package feathers.core 
{
    public interface IValidating extends feathers.core.IFeathersDisplayObject
    {
        function get depth():int;

        function validate():void;
    }
}


//  class PopUpManager
package feathers.core 
{
    import flash.utils.*;
    import starling.core.*;
    import starling.display.*;
    
    public class PopUpManager extends Object
    {
        public function PopUpManager()
        {
            super();
            return;
        }

        public static function defaultPopUpManagerFactory():feathers.core.IPopUpManager
        {
            return new feathers.core.DefaultPopUpManager();
        }

        public static function forStarling(arg1:starling.core.Starling):feathers.core.IPopUpManager
        {
            var loc2:*=null;
            if (!arg1) 
            {
                throw new ArgumentError("PopUpManager not found. Starling cannot be null.");
            }
            var loc1:*=_starlingToPopUpManager[arg1];
            if (!loc1) 
            {
                loc2 = feathers.core.PopUpManager.popUpManagerFactory;
                if (loc2 === null) 
                {
                    loc2 = feathers.core.PopUpManager.defaultPopUpManagerFactory;
                }
                loc1 = loc2();
                if (!loc1.root || !arg1.stage.contains(loc1.root)) 
                {
                    loc1.root = starling.core.Starling.current.stage;
                }
                feathers.core.PopUpManager._starlingToPopUpManager[arg1] = loc1;
            }
            return loc1;
        }

        public static function get overlayFactory():Function
        {
            return feathers.core.PopUpManager.forStarling(starling.core.Starling.current).overlayFactory;
        }

        public static function set overlayFactory(arg1:Function):void
        {
            feathers.core.PopUpManager.forStarling(starling.core.Starling.current).overlayFactory = arg1;
            return;
        }

        public static function defaultOverlayFactory():starling.display.DisplayObject
        {
            return feathers.core.DefaultPopUpManager.defaultOverlayFactory();
        }

        public static function get root():starling.display.DisplayObjectContainer
        {
            return feathers.core.PopUpManager.forStarling(starling.core.Starling.current).root;
        }

        public static function set root(arg1:starling.display.DisplayObjectContainer):void
        {
            feathers.core.PopUpManager.forStarling(starling.core.Starling.current).root = arg1;
            return;
        }

        public static function get popUpCount():int
        {
            return feathers.core.PopUpManager.forStarling(starling.core.Starling.current).popUpCount;
        }

        public static function addPopUp(arg1:starling.display.DisplayObject, arg2:Boolean=true, arg3:Boolean=true, arg4:Function=null):starling.display.DisplayObject
        {
            return feathers.core.PopUpManager.forStarling(starling.core.Starling.current).addPopUp(arg1, arg2, arg3, arg4);
        }

        public static function removePopUp(arg1:starling.display.DisplayObject, arg2:Boolean=false):starling.display.DisplayObject
        {
            return feathers.core.PopUpManager.forStarling(starling.core.Starling.current).removePopUp(arg1, arg2);
        }

        public static function removeAllPopUps(arg1:Boolean=false):void
        {
            feathers.core.PopUpManager.forStarling(starling.core.Starling.current).removeAllPopUps(arg1);
            return;
        }

        public static function isPopUp(arg1:starling.display.DisplayObject):Boolean
        {
            return feathers.core.PopUpManager.forStarling(starling.core.Starling.current).isPopUp(arg1);
        }

        public static function isTopLevelPopUp(arg1:starling.display.DisplayObject):Boolean
        {
            return feathers.core.PopUpManager.forStarling(starling.core.Starling.current).isTopLevelPopUp(arg1);
        }

        public static function centerPopUp(arg1:starling.display.DisplayObject):void
        {
            feathers.core.PopUpManager.forStarling(starling.core.Starling.current).centerPopUp(arg1);
            return;
        }

        
        {
            popUpManagerFactory = defaultPopUpManagerFactory;
        }

        protected static const _starlingToPopUpManager:flash.utils.Dictionary=new flash.utils.Dictionary(true);

        public static var popUpManagerFactory:Function;
    }
}


//  class PropertyProxy
package feathers.core 
{
    import __AS3__.vec.*;
    import flash.utils.*;
    
    use namespace flash_proxy;
    
    public final dynamic class PropertyProxy extends flash.utils.Proxy
    {
        public function PropertyProxy(arg1:Function=null)
        {
            this._onChangeCallbacks = new Vector.<Function>(0);
            this._names = [];
            this._storage = {};
            super();
            if (arg1 != null) 
            {
                this._onChangeCallbacks[this._onChangeCallbacks.length] = arg1;
            }
            return;
        }

        flash_proxy override function hasProperty(arg1:*):Boolean
        {
            return this._storage.hasOwnProperty(arg1);
        }

        flash_proxy override function getProperty(arg1:*):*
        {
            var loc1:*=null;
            var loc2:*=null;
            if (this.flash_proxy::isAttribute(arg1)) 
            {
                loc1 = arg1 is QName ? QName(arg1).localName : arg1.toString();
                if (!this._storage.hasOwnProperty(loc1)) 
                {
                    loc2 = new feathers.core.PropertyProxy(this.subProxy_onChange);
                    loc2._subProxyName = loc1;
                    this._storage[loc1] = loc2;
                    this._names[this._names.length] = loc1;
                    this.fireOnChangeCallback(loc1);
                }
                return this._storage[loc1];
            }
            return this._storage[arg1];
        }

        flash_proxy override function setProperty(arg1:*, arg2:*):void
        {
            var loc1:*=arg1 is QName ? QName(arg1).localName : arg1.toString();
            this._storage[loc1] = arg2;
            if (this._names.indexOf(loc1) < 0) 
            {
                this._names[this._names.length] = loc1;
            }
            this.fireOnChangeCallback(loc1);
            return;
        }

        flash_proxy override function deleteProperty(arg1:*):Boolean
        {
            var loc1:*=arg1 is QName ? QName(arg1).localName : arg1.toString();
            var loc2:*=this._names.indexOf(loc1);
            if (loc2 >= 0) 
            {
                this._names.removeAt(loc2);
            }
            var loc3:*=delete this._storage[loc1];
            if (loc3) 
            {
                this.fireOnChangeCallback(loc1);
            }
            return loc3;
        }

        flash_proxy override function nextNameIndex(arg1:int):int
        {
            if (arg1 < this._names.length) 
            {
                return arg1 + 1;
            }
            return 0;
        }

        flash_proxy override function nextName(arg1:int):String
        {
            return this._names[(arg1 - 1)];
        }

        flash_proxy override function nextValue(arg1:int):*
        {
            var loc1:*=this._names[(arg1 - 1)];
            return this._storage[loc1];
        }

        public function addOnChangeCallback(arg1:Function):void
        {
            this._onChangeCallbacks[this._onChangeCallbacks.length] = arg1;
            return;
        }

        public function removeOnChangeCallback(arg1:Function):void
        {
            var loc1:*=this._onChangeCallbacks.indexOf(arg1);
            if (loc1 < 0) 
            {
                return;
            }
            if (loc1 == 0) 
            {
                this._onChangeCallbacks.shift();
                return;
            }
            var loc2:*=(this._onChangeCallbacks.length - 1);
            if (loc1 == loc2) 
            {
                this._onChangeCallbacks.pop();
                return;
            }
            this._onChangeCallbacks.removeAt(loc1);
            return;
        }

        public function toString():String
        {
            var loc2:*=null;
            var loc1:*="[object PropertyProxy";
            var loc3:*=0;
            var loc4:*=this;
            for (loc2 in loc4) 
            {
                loc1 = loc1 + (" " + loc2);
            }
            return loc1 + "]";
        }

        internal function fireOnChangeCallback(arg1:String):void
        {
            var loc3:*=null;
            var loc1:*=this._onChangeCallbacks.length;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                loc3 = this._onChangeCallbacks[loc2] as Function;
                loc3(this, arg1);
                ++loc2;
            }
            return;
        }

        internal function subProxy_onChange(arg1:feathers.core.PropertyProxy, arg2:String):void
        {
            this.fireOnChangeCallback(arg1._subProxyName);
            return;
        }

        public static function fromObject(arg1:Object, arg2:Function=null):feathers.core.PropertyProxy
        {
            var loc2:*=null;
            var loc1:*=new PropertyProxy(arg2);
            var loc3:*=0;
            var loc4:*=arg1;
            for (loc2 in loc4) 
            {
                loc1[loc2] = arg1[loc2];
            }
            return loc1;
        }

        internal var _subProxyName:String;

        internal var _onChangeCallbacks:__AS3__.vec.Vector.<Function>;

        internal var _names:Array;

        internal var _storage:Object;
    }
}


//  class ToggleGroup
package feathers.core 
{
    import __AS3__.vec.*;
    import flash.errors.*;
    import starling.events.*;
    
    public class ToggleGroup extends starling.events.EventDispatcher
    {
        public function ToggleGroup()
        {
            this._items = new Vector.<feathers.core.IToggle>();
            super();
            return;
        }

        public function get isSelectionRequired():Boolean
        {
            return this._isSelectionRequired;
        }

        public function set isSelectionRequired(arg1:Boolean):void
        {
            if (this._isSelectionRequired == arg1) 
            {
                return;
            }
            this._isSelectionRequired = arg1;
            if (this._isSelectionRequired && this._selectedIndex < 0 && this._items.length > 0) 
            {
                this.selectedIndex = 0;
            }
            return;
        }

        public function get selectedItem():feathers.core.IToggle
        {
            if (this._selectedIndex < 0) 
            {
                return null;
            }
            return this._items[this._selectedIndex];
        }

        public function set selectedItem(arg1:feathers.core.IToggle):void
        {
            this.selectedIndex = this._items.indexOf(arg1);
            return;
        }

        public function get selectedIndex():int
        {
            return this._selectedIndex;
        }

        public function set selectedIndex(arg1:int):void
        {
            var loc4:*=null;
            var loc1:*=this._items.length;
            if (arg1 < -1 || arg1 >= loc1) 
            {
                throw new RangeError("Index " + arg1 + " is out of range " + loc1 + " for ToggleGroup.");
            }
            var loc2:*=!(this._selectedIndex == arg1);
            this._selectedIndex = arg1;
            this._ignoreChanges = true;
            var loc3:*=0;
            while (loc3 < loc1) 
            {
                loc4 = this._items[loc3];
                loc4.isSelected = loc3 == arg1;
                ++loc3;
            }
            this._ignoreChanges = false;
            if (loc2) 
            {
                this.dispatchEventWith(starling.events.Event.CHANGE);
            }
            return;
        }

        public function get numItems():int
        {
            return this._items.length;
        }

        public function addItem(arg1:feathers.core.IToggle):void
        {
            if (!arg1) 
            {
                throw new ArgumentError("IToggle passed to ToggleGroup addItem() must not be null.");
            }
            var loc1:*=this._items.indexOf(arg1);
            if (loc1 >= 0) 
            {
                throw new flash.errors.IllegalOperationError("Cannot add an item to a ToggleGroup more than once.");
            }
            this._items.push(arg1);
            if (this._selectedIndex < 0 && this._isSelectionRequired) 
            {
                this.selectedItem = arg1;
            }
            else 
            {
                arg1.isSelected = false;
            }
            arg1.addEventListener(starling.events.Event.CHANGE, this.item_changeHandler);
            if (arg1 is feathers.core.IGroupedToggle) 
            {
                feathers.core.IGroupedToggle(arg1).toggleGroup = this;
            }
            return;
        }

        public function removeItem(arg1:feathers.core.IToggle):void
        {
            var loc2:*=0;
            var loc1:*=this._items.indexOf(arg1);
            if (loc1 < 0) 
            {
                return;
            }
            this._items.removeAt(loc1);
            arg1.removeEventListener(starling.events.Event.CHANGE, this.item_changeHandler);
            if (arg1 is feathers.core.IGroupedToggle) 
            {
                feathers.core.IGroupedToggle(arg1).toggleGroup = null;
            }
            if (this._selectedIndex > loc1) 
            {
                --this.selectedIndex;
            }
            else if (this._selectedIndex == loc1) 
            {
                if (this._isSelectionRequired) 
                {
                    loc2 = (this._items.length - 1);
                    if (this._selectedIndex > loc2) 
                    {
                        this.selectedIndex = loc2;
                    }
                    else 
                    {
                        this.dispatchEventWith(starling.events.Event.CHANGE);
                    }
                }
                else 
                {
                    this.selectedIndex = -1;
                }
            }
            return;
        }

        public function removeAllItems():void
        {
            var loc3:*=null;
            var loc1:*=this._items.length;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                loc3 = this._items.shift();
                loc3.removeEventListener(starling.events.Event.CHANGE, this.item_changeHandler);
                if (loc3 is feathers.core.IGroupedToggle) 
                {
                    feathers.core.IGroupedToggle(loc3).toggleGroup = null;
                }
                ++loc2;
            }
            this.selectedIndex = -1;
            return;
        }

        public function hasItem(arg1:feathers.core.IToggle):Boolean
        {
            var loc1:*=this._items.indexOf(arg1);
            return loc1 >= 0;
        }

        public function getItemAt(arg1:int):feathers.core.IToggle
        {
            return this._items[arg1];
        }

        public function getItemIndex(arg1:feathers.core.IToggle):int
        {
            return this._items.indexOf(arg1);
        }

        public function setItemIndex(arg1:feathers.core.IToggle, arg2:int):void
        {
            var loc1:*=this._items.indexOf(arg1);
            if (loc1 < 0) 
            {
                throw new ArgumentError("Attempting to set index of an item that has not been added to this ToggleGroup.");
            }
            if (loc1 === arg2) 
            {
                return;
            }
            this._items.removeAt(loc1);
            this._items.insertAt(arg2, arg1);
            if (this._selectedIndex >= 0) 
            {
                if (this._selectedIndex != loc1) 
                {
                    if (loc1 < this._selectedIndex && arg2 > this._selectedIndex) 
                    {
                        var loc2:*;
                        var loc3:*=((loc2 = this).selectedIndex - 1);
                        loc2.selectedIndex = loc3;
                    }
                    else if (loc1 > this._selectedIndex && arg2 < this._selectedIndex) 
                    {
                        loc3 = ((loc2 = this).selectedIndex + 1);
                        loc2.selectedIndex = loc3;
                    }
                }
                else 
                {
                    this.selectedIndex = arg2;
                }
            }
            return;
        }

        protected function item_changeHandler(arg1:starling.events.Event):void
        {
            if (this._ignoreChanges) 
            {
                return;
            }
            var loc1:*=feathers.core.IToggle(arg1.currentTarget);
            var loc2:*=this._items.indexOf(loc1);
            if (loc1.isSelected || this._isSelectionRequired && this._selectedIndex == loc2) 
            {
                this.selectedIndex = loc2;
            }
            else if (!loc1.isSelected) 
            {
                this.selectedIndex = -1;
            }
            return;
        }

        protected var _items:__AS3__.vec.Vector.<feathers.core.IToggle>;

        protected var _ignoreChanges:Boolean=false;

        protected var _isSelectionRequired:Boolean=true;

        protected var _selectedIndex:int=-1;
    }
}


//  class TokenList
package feathers.core 
{
    import __AS3__.vec.*;
    import starling.events.*;
    
    public class TokenList extends starling.events.EventDispatcher
    {
        public function TokenList()
        {
            this.names = new Vector.<String>(0);
            super();
            return;
        }

        public function get value():String
        {
            if (this._joinedNames === null) 
            {
                this._joinedNames = this.names.join(" ");
            }
            return this._joinedNames;
        }

        public function set value(arg1:String):void
        {
            if (this.value == arg1) 
            {
                return;
            }
            this._joinedNames = arg1;
            this.names.length = 0;
            this.names = Vector.<String>(arg1.split(" "));
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function get length():int
        {
            return this.names.length;
        }

        public function item(arg1:int):String
        {
            if (arg1 < 0 || arg1 >= this.names.length) 
            {
                return null;
            }
            return this.names[arg1];
        }

        public function add(arg1:String):void
        {
            var loc1:*=this.names.indexOf(arg1);
            if (loc1 >= 0) 
            {
                return;
            }
            if (this._joinedNames !== null) 
            {
                this._joinedNames = this._joinedNames + (" " + arg1);
            }
            this.names[this.names.length] = arg1;
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function remove(arg1:String):void
        {
            var loc1:*=this.names.indexOf(arg1);
            this.removeAt(loc1);
            return;
        }

        public function toggle(arg1:String):void
        {
            var loc1:*=this.names.indexOf(arg1);
            if (loc1 < 0) 
            {
                if (this._joinedNames !== null) 
                {
                    this._joinedNames = this._joinedNames + (" " + arg1);
                }
                this.names[this.names.length] = arg1;
                this.dispatchEventWith(starling.events.Event.CHANGE);
            }
            else 
            {
                this.removeAt(loc1);
            }
            return;
        }

        public function contains(arg1:String):Boolean
        {
            return this.names.indexOf(arg1) >= 0;
        }

        protected function removeAt(arg1:int):void
        {
            if (arg1 < 0) 
            {
                return;
            }
            this._joinedNames = null;
            this.names.removeAt(arg1);
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        protected var _joinedNames:String=null;

        protected var names:__AS3__.vec.Vector.<String>;
    }
}


//  class ValidationQueue
package feathers.core 
{
    import __AS3__.vec.*;
    import flash.utils.*;
    import starling.animation.*;
    import starling.core.*;
    
    public final class ValidationQueue extends Object implements starling.animation.IAnimatable
    {
        public function ValidationQueue(arg1:starling.core.Starling)
        {
            this._queue = new Vector.<feathers.core.IValidating>(0);
            super();
            this._starling = arg1;
            return;
        }

        public function get isValidating():Boolean
        {
            return this._isValidating;
        }

        public function dispose():void
        {
            if (this._starling) 
            {
                this._starling.juggler.remove(this);
                this._starling = null;
            }
            return;
        }

        public function addControl(arg1:feathers.core.IValidating):void
        {
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=null;
            var loc5:*=0;
            if (!this._starling.juggler.contains(this)) 
            {
                this._starling.juggler.add(this);
            }
            if (this._queue.indexOf(arg1) >= 0) 
            {
                return;
            }
            var loc1:*=this._queue.length;
            if (this._isValidating) 
            {
                loc2 = arg1.depth;
                --loc3;
                while (loc3 >= 0) 
                {
                    loc4 = feathers.core.IValidating(this._queue[loc3]);
                    loc5 = loc4.depth;
                    if (loc2 >= loc5) 
                    {
                        break;
                    }
                    --loc3;
                }
                ++loc3;
                this._queue.insertAt(loc3, arg1);
            }
            else 
            {
                this._queue[loc1] = arg1;
            }
            return;
        }

        public function advanceTime(arg1:Number):void
        {
            var loc2:*=null;
            if (this._isValidating || !this._starling.contextValid) 
            {
                return;
            }
            var loc1:*=this._queue.length;
            if (loc1 === 0) 
            {
                return;
            }
            this._isValidating = true;
            if (loc1 > 1) 
            {
                this._queue = this._queue.sort(this.queueSortFunction);
            }
            while (this._queue.length > 0) 
            {
                loc2 = this._queue.shift();
                if (loc2.depth < 0) 
                {
                    continue;
                }
                loc2.validate();
            }
            this._isValidating = false;
            return;
        }

        protected function queueSortFunction(arg1:feathers.core.IValidating, arg2:feathers.core.IValidating):int
        {
            var loc1:*=arg2.depth - arg1.depth;
            if (loc1 > 0) 
            {
                return -1;
            }
            if (loc1 < 0) 
            {
                return 1;
            }
            return 0;
        }

        public static function forStarling(arg1:starling.core.Starling):feathers.core.ValidationQueue
        {
            if (!arg1) 
            {
                return null;
            }
            var loc1:*=STARLING_TO_VALIDATION_QUEUE[arg1];
            if (!loc1) 
            {
                var loc2:*;
                loc1 = loc2 = new ValidationQueue(arg1);
                STARLING_TO_VALIDATION_QUEUE[arg1] = loc2;
            }
            return loc1;
        }

        internal static const STARLING_TO_VALIDATION_QUEUE:flash.utils.Dictionary=new flash.utils.Dictionary(true);

        internal var _starling:starling.core.Starling;

        internal var _isValidating:Boolean=false;

        internal var _queue:__AS3__.vec.Vector.<feathers.core.IValidating>;
    }
}


