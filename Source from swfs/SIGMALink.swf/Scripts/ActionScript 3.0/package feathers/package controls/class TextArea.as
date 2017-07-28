//class TextArea
package feathers.controls 
{
    import feathers.controls.text.*;
    import feathers.core.*;
    import feathers.events.*;
    import feathers.skins.*;
    import feathers.text.*;
    import flash.geom.*;
    import flash.ui.*;
    import starling.display.*;
    import starling.events.*;
    import starling.text.*;
    import starling.utils.*;
    
    public class TextArea extends feathers.controls.Scroller implements feathers.core.IAdvancedNativeFocusOwner, feathers.core.IStateContext
    {
        public function TextArea()
        {
            this._stateToSkin = {};
            super();
            if (this._fontStylesSet === null) 
            {
                this._fontStylesSet = new feathers.text.FontStylesSet();
                this._fontStylesSet.addEventListener(starling.events.Event.CHANGE, this.fontStyles_changeHandler);
            }
            this._measureViewPort = false;
            this.addEventListener(starling.events.TouchEvent.TOUCH, this.textArea_touchHandler);
            this.addEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.textArea_removedFromStageHandler);
            return;
        }

        public function getSkinForState(arg1:String):starling.display.DisplayObject
        {
            return this._stateToSkin[arg1] as starling.display.DisplayObject;
        }

        public function setSkinForState(arg1:String, arg2:starling.display.DisplayObject):void
        {
            var loc1:*="setSkinForState--" + arg1;
            if (this.processStyleRestriction(loc1)) 
            {
                if (arg2 !== null) 
                {
                    arg2.dispose();
                }
                return;
            }
            if (arg2 === null) 
            {
                delete this._stateToSkin[arg1];
            }
            else 
            {
                this._stateToSkin[arg1] = arg2;
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected override function draw():void
        {
            var loc5:*=false;
            var loc1:*=this.isInvalid(INVALIDATION_FLAG_TEXT_EDITOR);
            var loc2:*=this.isInvalid(INVALIDATION_FLAG_DATA);
            var loc3:*=this.isInvalid(INVALIDATION_FLAG_STYLES);
            var loc4:*=this.isInvalid(INVALIDATION_FLAG_STATE);
            if (loc1) 
            {
                this.createTextEditor();
            }
            if (loc1 || loc3) 
            {
                this.refreshTextEditorProperties();
            }
            if (loc1 || loc2) 
            {
                loc5 = this._ignoreTextChanges;
                this._ignoreTextChanges = true;
                this.textEditorViewPort.text = this._text;
                this._ignoreTextChanges = loc5;
            }
            if (loc1 || loc4) 
            {
                this.textEditorViewPort.isEnabled = this._isEnabled;
                if (!this._isEnabled && flash.ui.Mouse.supportsNativeCursor && this._oldMouseCursor) 
                {
                    flash.ui.Mouse.cursor = this._oldMouseCursor;
                    this._oldMouseCursor = null;
                }
            }
            super.draw();
            if (loc4 || loc3) 
            {
                this.refreshErrorCallout();
            }
            this.doPendingActions();
            return;
        }

        protected function createTextEditor():void
        {
            if (this.textEditorViewPort) 
            {
                this.textEditorViewPort.removeEventListener(starling.events.Event.CHANGE, this.textEditor_changeHandler);
                this.textEditorViewPort.removeEventListener(feathers.events.FeathersEventType.FOCUS_IN, this.textEditor_focusInHandler);
                this.textEditorViewPort.removeEventListener(feathers.events.FeathersEventType.FOCUS_OUT, this.textEditor_focusOutHandler);
                this.textEditorViewPort = null;
            }
            if (this._textEditorFactory == null) 
            {
                this.textEditorViewPort = new feathers.controls.text.TextFieldTextEditorViewPort();
            }
            else 
            {
                this.textEditorViewPort = feathers.controls.text.ITextEditorViewPort(this._textEditorFactory());
            }
            var loc1:*=this._customTextEditorStyleName == null ? this.textEditorStyleName : this._customTextEditorStyleName;
            this.textEditorViewPort.styleNameList.add(loc1);
            if (this.textEditorViewPort is feathers.core.IStateObserver) 
            {
                feathers.core.IStateObserver(this.textEditorViewPort).stateContext = this;
            }
            this.textEditorViewPort.addEventListener(starling.events.Event.CHANGE, this.textEditor_changeHandler);
            this.textEditorViewPort.addEventListener(feathers.events.FeathersEventType.FOCUS_IN, this.textEditor_focusInHandler);
            this.textEditorViewPort.addEventListener(feathers.events.FeathersEventType.FOCUS_OUT, this.textEditor_focusOutHandler);
            var loc2:*=feathers.controls.text.ITextEditorViewPort(this._viewPort);
            this.viewPort = this.textEditorViewPort;
            if (loc2) 
            {
                loc2.dispose();
            }
            return;
        }

        protected function createErrorCallout():void
        {
            if (this.callout !== null) 
            {
                this.callout.removeFromParent(true);
                this.callout = null;
            }
            if (this._errorString === null) 
            {
                return;
            }
            this.callout = new feathers.controls.TextCallout();
            var loc1:*=this._customErrorCalloutStyleName == null ? this.errorCalloutStyleName : this._customErrorCalloutStyleName;
            this.callout.styleNameList.add(loc1);
            this.callout.closeOnKeys = null;
            this.callout.closeOnTouchBeganOutside = false;
            this.callout.closeOnTouchEndedOutside = false;
            this.callout.touchable = false;
            this.callout.origin = this;
            feathers.core.PopUpManager.addPopUp(this.callout, false, false);
            return;
        }

        public function get nativeFocus():Object
        {
            if (this.textEditorViewPort is feathers.core.INativeFocusOwner) 
            {
                return feathers.core.INativeFocusOwner(this.textEditorViewPort).nativeFocus;
            }
            return null;
        }

        protected function changeState(arg1:String):void
        {
            if (this._currentState === arg1) 
            {
                return;
            }
            this._currentState = arg1;
            this.invalidate(INVALIDATION_FLAG_STATE);
            this.dispatchEventWith(feathers.events.FeathersEventType.STATE_CHANGE);
            return;
        }

        protected function doPendingActions():void
        {
            var loc1:*=0;
            var loc2:*=0;
            if (this._isWaitingToSetFocus || this._focusManager && this._focusManager.focus == this) 
            {
                this._isWaitingToSetFocus = false;
                if (!this._textEditorHasFocus) 
                {
                    this.textEditorViewPort.setFocus();
                }
            }
            if (this._pendingSelectionBeginIndex >= 0) 
            {
                loc1 = this._pendingSelectionBeginIndex;
                loc2 = this._pendingSelectionEndIndex;
                this._pendingSelectionBeginIndex = -1;
                this._pendingSelectionEndIndex = -1;
                this.selectRange(loc1, loc2);
            }
            return;
        }

        protected function refreshTextEditorProperties():void
        {
            var loc1:*=null;
            var loc2:*=null;
            this.textEditorViewPort.fontStyles = this._fontStylesSet;
            this.textEditorViewPort.maxChars = this._maxChars;
            this.textEditorViewPort.restrict = this._restrict;
            this.textEditorViewPort.isEditable = this._isEditable;
            var loc3:*=0;
            var loc4:*=this._textEditorProperties;
            for (loc1 in loc4) 
            {
                loc2 = this._textEditorProperties[loc1];
                this.textEditorViewPort[loc1] = loc2;
            }
            return;
        }

        protected override function refreshBackgroundSkin():void
        {
            var loc2:*=null;
            var loc1:*=this.currentBackgroundSkin;
            this.currentBackgroundSkin = this.getCurrentSkin();
            if (loc1 !== this.currentBackgroundSkin) 
            {
                if (loc1 !== null) 
                {
                    if (loc1 is feathers.core.IStateObserver) 
                    {
                        feathers.core.IStateObserver(loc1).stateContext = null;
                    }
                    this.removeChild(loc1, false);
                }
                if (this.currentBackgroundSkin !== null) 
                {
                    if (this.currentBackgroundSkin is feathers.core.IStateObserver) 
                    {
                        feathers.core.IStateObserver(this.currentBackgroundSkin).stateContext = this;
                    }
                    this.addChildAt(this.currentBackgroundSkin, 0);
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
                    }
                    else 
                    {
                        this._explicitBackgroundWidth = this.currentBackgroundSkin.width;
                        this._explicitBackgroundHeight = this.currentBackgroundSkin.height;
                        this._explicitBackgroundMinWidth = this._explicitBackgroundWidth;
                        this._explicitBackgroundMinHeight = this._explicitBackgroundHeight;
                    }
                }
            }
            return;
        }

        protected function getCurrentSkin():starling.display.DisplayObject
        {
            if (this._stateToSkinFunction != null) 
            {
                return starling.display.DisplayObject(this._stateToSkinFunction(this, this._currentState, this.currentBackgroundSkin));
            }
            var loc1:*=this._stateToSkin[this._currentState] as starling.display.DisplayObject;
            if (loc1 !== null) 
            {
                return loc1;
            }
            return this._backgroundSkin;
        }

        protected function refreshState():void
        {
            if (this._isEnabled) 
            {
                if (this._textEditorHasFocus) 
                {
                    this.changeState(feathers.controls.TextInputState.FOCUSED);
                }
                else if (this._errorString === null) 
                {
                    this.changeState(feathers.controls.TextInputState.ENABLED);
                }
                else 
                {
                    this.changeState(feathers.controls.TextInputState.ERROR);
                }
            }
            else 
            {
                this.changeState(feathers.controls.TextInputState.DISABLED);
            }
            return;
        }

        protected override function get defaultStyleProvider():feathers.skins.IStyleProvider
        {
            return TextArea.globalStyleProvider;
        }

        public override function get isFocusEnabled():Boolean
        {
            if (this._isEditable) 
            {
                return this._isEnabled && this._isFocusEnabled;
            }
            return super.isFocusEnabled;
        }

        public function get hasFocus():Boolean
        {
            if (!this._focusManager) 
            {
                return this._textEditorHasFocus;
            }
            return this._hasFocus;
        }

        public override function set isEnabled(arg1:Boolean):void
        {
            super.isEnabled = arg1;
            this.refreshState();
            return;
        }

        protected function refreshErrorCallout():void
        {
            if (this._textEditorHasFocus && this.callout === null && !(this._errorString === null) && this._errorString.length > 0) 
            {
                this.createErrorCallout();
            }
            else if (!(this.callout === null) && (!this._textEditorHasFocus || this._errorString === null || this._errorString.length === 0)) 
            {
                this.callout.removeFromParent(true);
                this.callout = null;
            }
            if (this.callout !== null) 
            {
                this.callout.text = this._errorString;
            }
            return;
        }

        public function get currentState():String
        {
            return this._currentState;
        }

        protected function setFocusOnTextEditorWithTouch(arg1:starling.events.Touch):void
        {
            if (!this.isFocusEnabled) 
            {
                return;
            }
            var loc1:*=starling.utils.Pool.getPoint();
            arg1.getLocation(this.stage, loc1);
            var loc2:*=this.contains(this.stage.hitTest(loc1));
            if (!this._textEditorHasFocus && loc2) 
            {
                this.globalToLocal(loc1, loc1);
                loc1.x = loc1.x - this._paddingLeft;
                loc1.y = loc1.y - this._paddingTop;
                this._isWaitingToSetFocus = false;
                this.textEditorViewPort.setFocus(loc1);
            }
            starling.utils.Pool.putPoint(loc1);
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

        protected function textArea_touchHandler(arg1:starling.events.TouchEvent):void
        {
            var loc3:*=null;
            if (!this._isEnabled) 
            {
                this._textAreaTouchPointID = -1;
                return;
            }
            var loc1:*=starling.display.DisplayObject(this.horizontalScrollBar);
            var loc2:*=starling.display.DisplayObject(this.verticalScrollBar);
            if (this._textAreaTouchPointID >= 0) 
            {
                loc3 = arg1.getTouch(this, starling.events.TouchPhase.ENDED, this._textAreaTouchPointID);
                if (!loc3 || loc3.isTouching(loc2) || loc3.isTouching(loc1)) 
                {
                    return;
                }
                this.removeEventListener(starling.events.Event.SCROLL, this.textArea_scrollHandler);
                this._textAreaTouchPointID = -1;
                if (this.textEditorViewPort.setTouchFocusOnEndedPhase) 
                {
                    this.setFocusOnTextEditorWithTouch(loc3);
                }
            }
            else 
            {
                loc3 = arg1.getTouch(this, starling.events.TouchPhase.BEGAN);
                if (loc3) 
                {
                    if (loc3.isTouching(loc2) || loc3.isTouching(loc1)) 
                    {
                        return;
                    }
                    this._textAreaTouchPointID = loc3.id;
                    if (!this.textEditorViewPort.setTouchFocusOnEndedPhase) 
                    {
                        this.setFocusOnTextEditorWithTouch(loc3);
                    }
                    this.addEventListener(starling.events.Event.SCROLL, this.textArea_scrollHandler);
                    return;
                }
                loc3 = arg1.getTouch(this, starling.events.TouchPhase.HOVER);
                if (loc3) 
                {
                    if (loc3.isTouching(loc2) || loc3.isTouching(loc1)) 
                    {
                        return;
                    }
                    if (flash.ui.Mouse.supportsNativeCursor && !this._oldMouseCursor) 
                    {
                        this._oldMouseCursor = flash.ui.Mouse.cursor;
                        flash.ui.Mouse.cursor = flash.ui.MouseCursor.IBEAM;
                    }
                    return;
                }
                if (flash.ui.Mouse.supportsNativeCursor && this._oldMouseCursor) 
                {
                    flash.ui.Mouse.cursor = this._oldMouseCursor;
                    this._oldMouseCursor = null;
                }
            }
            return;
        }

        public function get maxChars():int
        {
            return this._maxChars;
        }

        public function set maxChars(arg1:int):void
        {
            if (this._maxChars == arg1) 
            {
                return;
            }
            this._maxChars = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function textArea_scrollHandler(arg1:starling.events.Event):void
        {
            this.removeEventListener(starling.events.Event.SCROLL, this.textArea_scrollHandler);
            this._textAreaTouchPointID = -1;
            return;
        }

        public function get restrict():String
        {
            return this._restrict;
        }

        public function set restrict(arg1:String):void
        {
            if (this._restrict == arg1) 
            {
                return;
            }
            this._restrict = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function textArea_removedFromStageHandler(arg1:starling.events.Event):void
        {
            if (!this._focusManager && this._textEditorHasFocus) 
            {
                this.clearFocus();
            }
            this._isWaitingToSetFocus = false;
            this._textEditorHasFocus = false;
            this._textAreaTouchPointID = -1;
            this.removeEventListener(starling.events.Event.SCROLL, this.textArea_scrollHandler);
            if (flash.ui.Mouse.supportsNativeCursor && this._oldMouseCursor) 
            {
                flash.ui.Mouse.cursor = this._oldMouseCursor;
                this._oldMouseCursor = null;
            }
            return;
        }

        public function get isEditable():Boolean
        {
            return this._isEditable;
        }

        public function set isEditable(arg1:Boolean):void
        {
            if (this._isEditable == arg1) 
            {
                return;
            }
            this._isEditable = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected override function focusInHandler(arg1:starling.events.Event):void
        {
            if (!this._focusManager) 
            {
                return;
            }
            super.focusInHandler(arg1);
            this.setFocus();
            return;
        }

        public function get errorString():String
        {
            return this._errorString;
        }

        public function set errorString(arg1:String):void
        {
            if (this._errorString === arg1) 
            {
                return;
            }
            this._errorString = arg1;
            this.refreshState();
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected override function focusOutHandler(arg1:starling.events.Event):void
        {
            if (!this._focusManager) 
            {
                return;
            }
            super.focusOutHandler(arg1);
            this.textEditorViewPort.clearFocus();
            this.invalidate(INVALIDATION_FLAG_STATE);
            return;
        }

        public override function get backgroundDisabledSkin():starling.display.DisplayObject
        {
            return this.getSkinForState(feathers.controls.TextInputState.DISABLED);
        }

        public override function set backgroundDisabledSkin(arg1:starling.display.DisplayObject):void
        {
            this.setSkinForState(feathers.controls.TextInputState.DISABLED, arg1);
            return;
        }

        public function get backgroundFocusedSkin():starling.display.DisplayObject
        {
            return this.getSkinForState(feathers.controls.TextInputState.FOCUSED);
        }

        public function set backgroundFocusedSkin(arg1:starling.display.DisplayObject):void
        {
            this.setSkinForState(feathers.controls.TextInputState.FOCUSED, arg1);
            return;
        }

        public function get backgroundErrorSkin():starling.display.DisplayObject
        {
            return this.getSkinForState(feathers.controls.TextInputState.ERROR);
        }

        public function set backgroundErrorSkin(arg1:starling.display.DisplayObject):void
        {
            this.setSkinForState(feathers.controls.TextInputState.ERROR, arg1);
            return;
        }

        protected override function stage_keyDownHandler(arg1:starling.events.KeyboardEvent):void
        {
            if (this._isEditable) 
            {
                return;
            }
            super.stage_keyDownHandler(arg1);
            return;
        }

        public function get stateToSkinFunction():Function
        {
            return this._stateToSkinFunction;
        }

        public function set stateToSkinFunction(arg1:Function):void
        {
            if (this._stateToSkinFunction == arg1) 
            {
                return;
            }
            this._stateToSkinFunction = arg1;
            this.invalidate(INVALIDATION_FLAG_SKIN);
            return;
        }

        protected function textEditor_changeHandler(arg1:starling.events.Event):void
        {
            if (this._ignoreTextChanges) 
            {
                return;
            }
            this.text = this.textEditorViewPort.text;
            return;
        }

        public function get fontStyles():starling.text.TextFormat
        {
            return this._fontStylesSet.format;
        }

        public function set fontStyles(arg1:starling.text.TextFormat):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            this._fontStylesSet.format = arg1;
            return;
        }

        public function get disabledFontStyles():starling.text.TextFormat
        {
            return this._fontStylesSet.disabledFormat;
        }

        public function set disabledFontStyles(arg1:starling.text.TextFormat):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            this._fontStylesSet.disabledFormat = arg1;
            return;
        }

        protected function textEditor_focusInHandler(arg1:starling.events.Event):void
        {
            this._textEditorHasFocus = true;
            this.refreshState();
            this.refreshErrorCallout();
            this._touchPointID = -1;
            this.invalidate(INVALIDATION_FLAG_STATE);
            if (this._focusManager && this.isFocusEnabled && !(this._focusManager.focus === this)) 
            {
                this._focusManager.focus = this;
            }
            else if (!this._focusManager) 
            {
                this.dispatchEventWith(feathers.events.FeathersEventType.FOCUS_IN);
            }
            return;
        }

        public function get textEditorFactory():Function
        {
            return this._textEditorFactory;
        }

        public function set textEditorFactory(arg1:Function):void
        {
            if (this._textEditorFactory == arg1) 
            {
                return;
            }
            this._textEditorFactory = arg1;
            this.invalidate(INVALIDATION_FLAG_TEXT_EDITOR);
            return;
        }

        protected function textEditor_focusOutHandler(arg1:starling.events.Event):void
        {
            this._textEditorHasFocus = false;
            this.refreshState();
            this.refreshErrorCallout();
            this.invalidate(INVALIDATION_FLAG_STATE);
            if (this._focusManager && this._focusManager.focus === this) 
            {
                this._focusManager.focus = null;
            }
            else if (!this._focusManager) 
            {
                this.dispatchEventWith(feathers.events.FeathersEventType.FOCUS_OUT);
            }
            return;
        }

        public function get customTextEditorStyleName():String
        {
            return this._customTextEditorStyleName;
        }

        public function set customTextEditorStyleName(arg1:String):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._customTextEditorStyleName === arg1) 
            {
                return;
            }
            this._customTextEditorStyleName = arg1;
            this.invalidate(INVALIDATION_FLAG_TEXT_RENDERER);
            return;
        }

        protected function fontStyles_changeHandler(arg1:starling.events.Event):void
        {
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get textEditorProperties():Object
        {
            if (!this._textEditorProperties) 
            {
                this._textEditorProperties = new feathers.core.PropertyProxy(childProperties_onChange);
            }
            return this._textEditorProperties;
        }

        public function set textEditorProperties(arg1:Object):void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (this._textEditorProperties == arg1) 
            {
                return;
            }
            if (!arg1) 
            {
                arg1 = new feathers.core.PropertyProxy();
            }
            if (!(arg1 is feathers.core.PropertyProxy)) 
            {
                loc1 = new feathers.core.PropertyProxy();
                var loc3:*=0;
                var loc4:*=arg1;
                for (loc2 in loc4) 
                {
                    loc1[loc2] = arg1[loc2];
                }
                arg1 = loc1;
            }
            if (this._textEditorProperties) 
            {
                this._textEditorProperties.removeOnChangeCallback(childProperties_onChange);
            }
            this._textEditorProperties = feathers.core.PropertyProxy(arg1);
            if (this._textEditorProperties) 
            {
                this._textEditorProperties.addOnChangeCallback(childProperties_onChange);
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get customErrorCalloutStyleName():String
        {
            return this._customErrorCalloutStyleName;
        }

        public function set customErrorCalloutStyleName(arg1:String):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._customErrorCalloutStyleName === arg1) 
            {
                return;
            }
            this._customErrorCalloutStyleName = arg1;
            this.invalidate(INVALIDATION_FLAG_ERROR_CALLOUT_FACTORY);
            return;
        }

        public function get selectionBeginIndex():int
        {
            if (this._pendingSelectionBeginIndex >= 0) 
            {
                return this._pendingSelectionBeginIndex;
            }
            if (this.textEditorViewPort) 
            {
                return this.textEditorViewPort.selectionBeginIndex;
            }
            return 0;
        }

        public function get selectionEndIndex():int
        {
            if (this._pendingSelectionEndIndex >= 0) 
            {
                return this._pendingSelectionEndIndex;
            }
            if (this.textEditorViewPort) 
            {
                return this.textEditorViewPort.selectionEndIndex;
            }
            return 0;
        }

        public function setFocus():void
        {
            if (this._textEditorHasFocus) 
            {
                return;
            }
            if (this.textEditorViewPort) 
            {
                this._isWaitingToSetFocus = false;
                this.textEditorViewPort.setFocus();
            }
            else 
            {
                this._isWaitingToSetFocus = true;
                this.invalidate(INVALIDATION_FLAG_SELECTED);
            }
            return;
        }

        public function clearFocus():void
        {
            this._isWaitingToSetFocus = false;
            if (!this.textEditorViewPort || !this._textEditorHasFocus) 
            {
                return;
            }
            this.textEditorViewPort.clearFocus();
            return;
        }

        public function selectRange(arg1:int, arg2:int=-1):void
        {
            if (arg2 < 0) 
            {
                arg2 = arg1;
            }
            if (arg1 < 0) 
            {
                throw new RangeError("Expected begin index greater than or equal to 0. Received " + arg1 + ".");
            }
            if (arg2 > this._text.length) 
            {
                throw new RangeError("Expected begin index less than " + this._text.length + ". Received " + arg2 + ".");
            }
            if (!(this.textEditorViewPort === null) && (this._isValidating || !this.isInvalid())) 
            {
                this._pendingSelectionBeginIndex = -1;
                this._pendingSelectionEndIndex = -1;
                this.textEditorViewPort.selectRange(arg1, arg2);
            }
            else 
            {
                this._pendingSelectionBeginIndex = arg1;
                this._pendingSelectionEndIndex = arg2;
                this.invalidate(INVALIDATION_FLAG_SELECTED);
            }
            return;
        }

        public override function dispose():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=0;
            var loc4:*=this._stateToSkin;
            for (loc1 in loc4) 
            {
                loc2 = this._stateToSkin[loc1] as starling.display.DisplayObject;
                if (!(!(loc2 === null) && !(loc2.parent === this))) 
                {
                    continue;
                }
                loc2.dispose();
            }
            super.dispose();
            return;
        }

        public function getFontStylesForState(arg1:String):starling.text.TextFormat
        {
            if (this._fontStylesSet === null) 
            {
                return null;
            }
            return this._fontStylesSet.getFormatForState(arg1);
        }

        public function setFontStylesForState(arg1:String, arg2:starling.text.TextFormat):void
        {
            var loc1:*="setFontStylesForState--" + arg1;
            if (this.processStyleRestriction(loc1)) 
            {
                return;
            }
            this._fontStylesSet.setFormatForState(arg1, arg2);
            return;
        }

        public static const SCROLL_BAR_DISPLAY_MODE_FIXED:String="fixed";

        public static const STATE_DISABLED:String="disabled";

        public static const SCROLL_POLICY_AUTO:String="auto";

        public static const SCROLL_POLICY_ON:String="on";

        public static const SCROLL_POLICY_OFF:String="off";

        public static const SCROLL_BAR_DISPLAY_MODE_FLOAT:String="float";

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

        public static const STATE_ENABLED:String="enabled";

        public static const STATE_FOCUSED:String="focused";

        public static const DEFAULT_CHILD_STYLE_NAME_TEXT_EDITOR:String="feathers-text-area-text-editor";

        public static const DEFAULT_CHILD_STYLE_NAME_ERROR_CALLOUT:String="feathers-text-area-error-callout";

        protected static const INVALIDATION_FLAG_ERROR_CALLOUT_FACTORY:String="errorCalloutFactory";

        protected var _textEditorProperties:feathers.core.PropertyProxy;

        protected var _isWaitingToSetFocus:Boolean=false;

        protected var textEditorViewPort:feathers.controls.text.ITextEditorViewPort;

        protected var callout:feathers.controls.TextCallout;

        protected var textEditorStyleName:String="feathers-text-area-text-editor";

        protected var errorCalloutStyleName:String="feathers-text-area-error-callout";

        protected var _customErrorCalloutStyleName:String;

        protected var _textEditorHasFocus:Boolean=false;

        protected var _pendingSelectionBeginIndex:int=-1;

        protected var _pendingSelectionEndIndex:int=-1;

        protected var _textAreaTouchPointID:int=-1;

        protected var _oldMouseCursor:String=null;

        protected var _ignoreTextChanges:Boolean=false;

        protected var _currentState:String="enabled";

        protected var _text:String="";

        protected var _maxChars:int=0;

        protected var _restrict:String;

        protected var _isEditable:Boolean=true;

        protected var _errorString:String=null;

        protected var _stateToSkinFunction:Function;

        protected var _stateToSkin:Object;

        protected var _fontStylesSet:feathers.text.FontStylesSet;

        protected var _textEditorFactory:Function;

        protected var _customTextEditorStyleName:String;

        public static var globalStyleProvider:feathers.skins.IStyleProvider;
    }
}


