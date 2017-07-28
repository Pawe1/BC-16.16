//class DefaultFocusManager
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

