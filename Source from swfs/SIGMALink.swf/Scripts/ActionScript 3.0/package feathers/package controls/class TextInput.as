//class TextInput
package feathers.controls 
{
    import feathers.core.*;
    import feathers.events.*;
    import feathers.layout.*;
    import feathers.skins.*;
    import feathers.text.*;
    import feathers.utils.skins.*;
    import flash.geom.*;
    import flash.ui.*;
    import starling.display.*;
    import starling.events.*;
    import starling.text.*;
    import starling.utils.*;
    
    public class TextInput extends feathers.core.FeathersControl implements feathers.core.ITextBaselineControl, feathers.core.IAdvancedNativeFocusOwner, feathers.core.IStateContext
    {
        public function TextInput()
        {
            this._stateToSkin = {};
            this._stateToIcon = {};
            super();
            if (this._fontStylesSet === null) 
            {
                this._fontStylesSet = new feathers.text.FontStylesSet();
                this._fontStylesSet.addEventListener(starling.events.Event.CHANGE, this.fontStyles_changeHandler);
            }
            if (this._promptFontStylesSet === null) 
            {
                this._promptFontStylesSet = new feathers.text.FontStylesSet();
                this._promptFontStylesSet.addEventListener(starling.events.Event.CHANGE, this.fontStyles_changeHandler);
            }
            this.addEventListener(starling.events.TouchEvent.TOUCH, this.textInput_touchHandler);
            this.addEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.textInput_removedFromStageHandler);
            return;
        }

        public override function hitTest(arg1:flash.geom.Point):starling.display.DisplayObject
        {
            if (!this.visible || !this.touchable) 
            {
                return null;
            }
            if (this.mask && !this.hitTestMask(arg1)) 
            {
                return null;
            }
            return this._hitArea.containsPoint(arg1) ? starling.display.DisplayObject(this.textEditor) : null;
        }

        public function setFocus():void
        {
            if (this._textEditorHasFocus || !this.visible || this._touchPointID >= 0) 
            {
                return;
            }
            if (this._isEditable || this._isSelectable) 
            {
                this.selectRange(0, this._text.length);
            }
            if (this.textEditor) 
            {
                this._isWaitingToSetFocus = false;
                this.textEditor.setFocus();
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
            if (!this.textEditor || !this._textEditorHasFocus) 
            {
                return;
            }
            this.textEditor.clearFocus();
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
                throw new RangeError("Expected begin index >= 0. Received " + arg1 + ".");
            }
            if (arg2 > this._text.length) 
            {
                throw new RangeError("Expected end index <= " + this._text.length + ". Received " + arg2 + ".");
            }
            if (this.textEditor && (this._isValidating || !this.isInvalid())) 
            {
                this._pendingSelectionBeginIndex = -1;
                this._pendingSelectionEndIndex = -1;
                this.textEditor.selectRange(arg1, arg2);
            }
            else 
            {
                this._pendingSelectionBeginIndex = arg1;
                this._pendingSelectionEndIndex = arg2;
                this.invalidate(INVALIDATION_FLAG_SELECTED);
            }
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

        public function getPromptFontStylesForState(arg1:String):starling.text.TextFormat
        {
            if (this._promptFontStylesSet === null) 
            {
                return null;
            }
            return this._promptFontStylesSet.getFormatForState(arg1);
        }

        public function setPromptFontStylesForState(arg1:String, arg2:starling.text.TextFormat):void
        {
            var loc1:*="setPromptFontStylesForState--" + arg1;
            if (this.processStyleRestriction(loc1)) 
            {
                return;
            }
            this._promptFontStylesSet.setFormatForState(arg1, arg2);
            return;
        }

        public function getSkinForState(arg1:String):starling.display.DisplayObject
        {
            return this._stateToSkin[arg1] as starling.display.DisplayObject;
        }

        public function get nativeFocus():Object
        {
            if (this.textEditor is feathers.core.INativeFocusOwner) 
            {
                return feathers.core.INativeFocusOwner(this.textEditor).nativeFocus;
            }
            return null;
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

        public function getIconForState(arg1:String):starling.display.DisplayObject
        {
            return this._stateToIcon[arg1] as starling.display.DisplayObject;
        }

        protected override function get defaultStyleProvider():feathers.skins.IStyleProvider
        {
            return feathers.controls.TextInput.globalStyleProvider;
        }

        public function get hasFocus():Boolean
        {
            return this._textEditorHasFocus;
        }

        public override function set isEnabled(arg1:Boolean):void
        {
            super.isEnabled = arg1;
            this.refreshState();
            return;
        }

        public function setIconForState(arg1:String, arg2:starling.display.DisplayObject):void
        {
            var loc1:*="setIconForState--" + arg1;
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
                delete this._stateToIcon[arg1];
            }
            else 
            {
                this._stateToIcon[arg1] = arg2;
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get currentState():String
        {
            return this._currentState;
        }

        public override function dispose():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            if (!(this._backgroundSkin === null) && !(this._backgroundSkin.parent === this)) 
            {
                this._backgroundSkin.dispose();
            }
            var loc4:*=0;
            var loc5:*=this._stateToSkin;
            for (loc1 in loc5) 
            {
                loc2 = this._stateToSkin[loc1] as starling.display.DisplayObject;
                if (!(!(loc2 === null) && !(loc2.parent === this))) 
                {
                    continue;
                }
                loc2.dispose();
            }
            if (!(this._defaultIcon === null) && !(this._defaultIcon.parent === this)) 
            {
                this._defaultIcon.dispose();
            }
            loc4 = 0;
            loc5 = this._stateToIcon;
            for (loc1 in loc5) 
            {
                loc3 = this._stateToIcon[loc1] as starling.display.DisplayObject;
                if (!(!(loc3 === null) && !(loc3.parent === this))) 
                {
                    continue;
                }
                loc3.dispose();
            }
            super.dispose();
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

        public function get baseline():Number
        {
            if (!this.textEditor) 
            {
                return 0;
            }
            return this.textEditor.y + this.textEditor.baseline;
        }

        protected override function draw():void
        {
            var loc9:*=false;
            var loc1:*=this.isInvalid(INVALIDATION_FLAG_STATE);
            var loc2:*=this.isInvalid(INVALIDATION_FLAG_STYLES);
            var loc3:*=this.isInvalid(INVALIDATION_FLAG_DATA);
            var loc4:*=this.isInvalid(INVALIDATION_FLAG_SKIN);
            var loc5:*=this.isInvalid(INVALIDATION_FLAG_SIZE);
            var loc6:*=this.isInvalid(INVALIDATION_FLAG_TEXT_EDITOR);
            var loc7:*=this.isInvalid(INVALIDATION_FLAG_PROMPT_FACTORY);
            var loc8:*=this.isInvalid(INVALIDATION_FLAG_FOCUS);
            if (loc6) 
            {
                this.createTextEditor();
            }
            if (loc7 || !(this._prompt === null) && !this.promptTextRenderer) 
            {
                this.createPrompt();
            }
            if (loc6 || loc2) 
            {
                this.refreshTextEditorProperties();
            }
            if (loc7 || loc2) 
            {
                this.refreshPromptProperties();
            }
            if (loc6 || loc3) 
            {
                loc9 = this._ignoreTextChanges;
                this._ignoreTextChanges = true;
                this.textEditor.text = this._text;
                this._ignoreTextChanges = loc9;
            }
            if (this.promptTextRenderer) 
            {
                if (loc7 || loc3 || loc2) 
                {
                    this.promptTextRenderer.visible = this._prompt && this._text.length == 0;
                }
                if (loc7 || loc1) 
                {
                    this.promptTextRenderer.isEnabled = this._isEnabled;
                }
            }
            if (loc6 || loc1) 
            {
                this.textEditor.isEnabled = this._isEnabled;
                if (!this._isEnabled && flash.ui.Mouse.supportsNativeCursor && this._oldMouseCursor) 
                {
                    flash.ui.Mouse.cursor = this._oldMouseCursor;
                    this._oldMouseCursor = null;
                }
            }
            if (loc1 || loc4) 
            {
                this.refreshBackgroundSkin();
            }
            if (loc1 || loc2) 
            {
                this.refreshIcon();
            }
            loc5 = this.autoSizeIfNeeded() || loc5;
            this.layoutChildren();
            if (loc1 || loc2) 
            {
                this.refreshErrorCallout();
            }
            if (loc5 || loc8) 
            {
                this.refreshFocusIndicator();
            }
            this.doPendingActions();
            return;
        }

        public function get prompt():String
        {
            return this._prompt;
        }

        public function set prompt(arg1:String):void
        {
            if (this._prompt == arg1) 
            {
                return;
            }
            this._prompt = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function autoSizeIfNeeded():Boolean
        {
            var loc13:*=null;
            var loc14:*=NaN;
            var loc15:*=NaN;
            var loc16:*=false;
            var loc17:*=NaN;
            var loc18:*=NaN;
            var loc19:*=NaN;
            var loc1:*=!(this._explicitWidth === this._explicitWidth);
            var loc2:*=!(this._explicitHeight === this._explicitHeight);
            var loc3:*=!(this._explicitMinWidth === this._explicitMinWidth);
            var loc4:*=!(this._explicitMinHeight === this._explicitMinHeight);
            if (!loc1 && !loc2 && !loc3 && !loc4) 
            {
                return false;
            }
            var loc5:*=this.currentBackground as feathers.core.IMeasureDisplayObject;
            feathers.utils.skins.resetFluidChildDimensionsForMeasurement(this.currentBackground, this._explicitWidth, this._explicitHeight, this._explicitMinWidth, this._explicitMinHeight, this._explicitMaxWidth, this._explicitMaxHeight, this._explicitBackgroundWidth, this._explicitBackgroundHeight, this._explicitBackgroundMinWidth, this._explicitBackgroundMinHeight, this._explicitBackgroundMaxWidth, this._explicitBackgroundMaxHeight);
            if (this.currentBackground is feathers.core.IValidating) 
            {
                feathers.core.IValidating(this.currentBackground).validate();
            }
            if (this.currentIcon is feathers.core.IValidating) 
            {
                feathers.core.IValidating(this.currentIcon).validate();
            }
            var loc6:*=0;
            var loc7:*=0;
            if (this._typicalText !== null) 
            {
                loc13 = starling.utils.Pool.getPoint();
                loc14 = this.textEditor.width;
                loc15 = this.textEditor.height;
                loc16 = this._ignoreTextChanges;
                this._ignoreTextChanges = true;
                this.textEditor.setSize(NaN, NaN);
                this.textEditor.text = this._typicalText;
                this.textEditor.measureText(loc13);
                this.textEditor.text = this._text;
                this._ignoreTextChanges = loc16;
                loc6 = loc13.x;
                loc7 = loc13.y;
                starling.utils.Pool.putPoint(loc13);
            }
            if (this._prompt !== null) 
            {
                loc13 = starling.utils.Pool.getPoint();
                this.promptTextRenderer.setSize(NaN, NaN);
                this.promptTextRenderer.measureText(loc13);
                if (loc13.x > loc6) 
                {
                    loc6 = loc13.x;
                }
                if (loc13.y > loc7) 
                {
                    loc7 = loc13.y;
                }
                starling.utils.Pool.putPoint(loc13);
            }
            var loc8:*=this._explicitWidth;
            if (loc1) 
            {
                loc8 = loc6;
                if (this._originalIconWidth === this._originalIconWidth) 
                {
                    loc8 = loc8 + (this._originalIconWidth + this._gap);
                }
                loc8 = loc8 + (this._paddingLeft + this._paddingRight);
                if (!(this.currentBackground === null) && this.currentBackground.width > loc8) 
                {
                    loc8 = this.currentBackground.width;
                }
            }
            var loc9:*=this._explicitHeight;
            if (loc2) 
            {
                loc9 = loc7;
                if (this._originalIconHeight === this._originalIconHeight && this._originalIconHeight > loc9) 
                {
                    loc9 = this._originalIconHeight;
                }
                loc9 = loc9 + (this._paddingTop + this._paddingBottom);
                if (!(this.currentBackground === null) && this.currentBackground.height > loc9) 
                {
                    loc9 = this.currentBackground.height;
                }
            }
            var loc10:*=this._explicitMinWidth;
            if (loc3) 
            {
                loc10 = loc6;
                if (this.currentIcon is feathers.core.IFeathersControl) 
                {
                    loc10 = loc10 + (feathers.core.IFeathersControl(this.currentIcon).minWidth + this._gap);
                }
                else if (this._originalIconWidth === this._originalIconWidth) 
                {
                    loc10 = loc10 + (this._originalIconWidth + this._gap);
                }
                loc10 = loc10 + (this._paddingLeft + this._paddingRight);
                loc17 = 0;
                if (loc5 === null) 
                {
                    if (this.currentBackground !== null) 
                    {
                        loc17 = this._explicitBackgroundMinWidth;
                    }
                }
                else 
                {
                    loc17 = loc5.minWidth;
                }
                if (loc17 > loc10) 
                {
                    loc10 = loc17;
                }
            }
            var loc11:*=this._explicitMinHeight;
            if (loc4) 
            {
                loc11 = loc7;
                if (this.currentIcon is feathers.core.IFeathersControl) 
                {
                    loc19 = feathers.core.IFeathersControl(this.currentIcon).minHeight;
                    if (loc19 > loc11) 
                    {
                        loc11 = loc19;
                    }
                }
                else if (this._originalIconHeight === this._originalIconHeight && this._originalIconHeight > loc11) 
                {
                    loc11 = this._originalIconHeight;
                }
                loc11 = loc11 + (this._paddingTop + this._paddingBottom);
                loc18 = 0;
                if (loc5 === null) 
                {
                    if (this.currentBackground !== null) 
                    {
                        loc18 = this._explicitBackgroundMinHeight;
                    }
                }
                else 
                {
                    loc18 = loc5.minHeight;
                }
                if (loc18 > loc11) 
                {
                    loc11 = loc18;
                }
            }
            var loc12:*=this.textEditor is feathers.core.IMultilineTextEditor && feathers.core.IMultilineTextEditor(this.textEditor).multiline;
            if (!(this._typicalText === null) && (this._verticalAlign == feathers.layout.VerticalAlign.JUSTIFY || loc12)) 
            {
                this.textEditor.width = loc14;
                this.textEditor.height = loc15;
            }
            return this.saveMeasurements(loc8, loc9, loc10, loc11);
        }

        public function get typicalText():String
        {
            return this._typicalText;
        }

        public function set typicalText(arg1:String):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._typicalText === arg1) 
            {
                return;
            }
            this._typicalText = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        protected function createTextEditor():void
        {
            if (this.textEditor) 
            {
                this.removeChild(starling.display.DisplayObject(this.textEditor), true);
                this.textEditor.removeEventListener(starling.events.Event.CHANGE, this.textEditor_changeHandler);
                this.textEditor.removeEventListener(feathers.events.FeathersEventType.ENTER, this.textEditor_enterHandler);
                this.textEditor.removeEventListener(feathers.events.FeathersEventType.FOCUS_IN, this.textEditor_focusInHandler);
                this.textEditor.removeEventListener(feathers.events.FeathersEventType.FOCUS_OUT, this.textEditor_focusOutHandler);
                this.textEditor = null;
            }
            var loc1:*=this._textEditorFactory == null ? feathers.core.FeathersControl.defaultTextEditorFactory : this._textEditorFactory;
            this.textEditor = feathers.core.ITextEditor(loc1());
            var loc2:*=this._customTextEditorStyleName == null ? this.textEditorStyleName : this._customTextEditorStyleName;
            this.textEditor.styleNameList.add(loc2);
            if (this.textEditor is feathers.core.IStateObserver) 
            {
                feathers.core.IStateObserver(this.textEditor).stateContext = this;
            }
            this.textEditor.addEventListener(starling.events.Event.CHANGE, this.textEditor_changeHandler);
            this.textEditor.addEventListener(feathers.events.FeathersEventType.ENTER, this.textEditor_enterHandler);
            this.textEditor.addEventListener(feathers.events.FeathersEventType.FOCUS_IN, this.textEditor_focusInHandler);
            this.textEditor.addEventListener(feathers.events.FeathersEventType.FOCUS_OUT, this.textEditor_focusOutHandler);
            this.addChild(starling.display.DisplayObject(this.textEditor));
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

        protected function createPrompt():void
        {
            if (this.promptTextRenderer) 
            {
                this.removeChild(starling.display.DisplayObject(this.promptTextRenderer), true);
                this.promptTextRenderer = null;
            }
            if (this._prompt === null) 
            {
                return;
            }
            var loc1:*=this._promptFactory == null ? feathers.core.FeathersControl.defaultTextRendererFactory : this._promptFactory;
            this.promptTextRenderer = feathers.core.ITextRenderer(loc1());
            var loc2:*=this._customPromptStyleName == null ? this.promptStyleName : this._customPromptStyleName;
            this.promptTextRenderer.styleNameList.add(loc2);
            this.addChild(starling.display.DisplayObject(this.promptTextRenderer));
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

        protected function doPendingActions():void
        {
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=0;
            if (this._isWaitingToSetFocus) 
            {
                this._isWaitingToSetFocus = false;
                if (!this._textEditorHasFocus) 
                {
                    if ((this._isEditable || this._isSelectable) && this._pendingSelectionBeginIndex < 0) 
                    {
                        this._pendingSelectionBeginIndex = 0;
                        this._pendingSelectionEndIndex = this._text.length;
                    }
                    this.textEditor.setFocus();
                }
            }
            if (this._pendingSelectionBeginIndex >= 0) 
            {
                loc1 = this._pendingSelectionBeginIndex;
                loc2 = this._pendingSelectionEndIndex;
                this._pendingSelectionBeginIndex = -1;
                this._pendingSelectionEndIndex = -1;
                if (loc2 >= 0) 
                {
                    loc3 = this._text.length;
                    if (loc2 > loc3) 
                    {
                        loc2 = loc3;
                    }
                }
                this.selectRange(loc1, loc2);
            }
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
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function refreshTextEditorProperties():void
        {
            var loc1:*=null;
            var loc2:*=null;
            this.textEditor.displayAsPassword = this._displayAsPassword;
            this.textEditor.maxChars = this._maxChars;
            this.textEditor.restrict = this._restrict;
            this.textEditor.isEditable = this._isEditable;
            this.textEditor.isSelectable = this._isSelectable;
            this.textEditor.fontStyles = this._fontStylesSet;
            var loc3:*=0;
            var loc4:*=this._textEditorProperties;
            for (loc1 in loc4) 
            {
                loc2 = this._textEditorProperties[loc1];
                this.textEditor[loc1] = loc2;
            }
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

        protected function refreshPromptProperties():void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (!this.promptTextRenderer) 
            {
                return;
            }
            this.promptTextRenderer.text = this._prompt;
            this.promptTextRenderer.fontStyles = this._promptFontStylesSet;
            var loc3:*=0;
            var loc4:*=this._promptProperties;
            for (loc1 in loc4) 
            {
                loc2 = this._promptProperties[loc1];
                this.promptTextRenderer[loc1] = loc2;
            }
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

        protected function refreshBackgroundSkin():void
        {
            var loc2:*=null;
            var loc1:*=this.currentBackground;
            this.currentBackground = this.getCurrentSkin();
            if (this.currentBackground !== loc1) 
            {
                if (loc1) 
                {
                    if (loc1 is feathers.core.IStateObserver) 
                    {
                        feathers.core.IStateObserver(loc1).stateContext = null;
                    }
                    this.removeChild(loc1, false);
                }
                if (this.currentBackground) 
                {
                    if (this.currentBackground is feathers.core.IStateObserver) 
                    {
                        feathers.core.IStateObserver(this.currentBackground).stateContext = this;
                    }
                    this.addChildAt(this.currentBackground, 0);
                    if (this.currentBackground is feathers.core.IFeathersControl) 
                    {
                        feathers.core.IFeathersControl(this.currentBackground).initializeNow();
                    }
                    if (this.currentBackground is feathers.core.IMeasureDisplayObject) 
                    {
                        loc2 = feathers.core.IMeasureDisplayObject(this.currentBackground);
                        this._explicitBackgroundWidth = loc2.explicitWidth;
                        this._explicitBackgroundHeight = loc2.explicitHeight;
                        this._explicitBackgroundMinWidth = loc2.explicitMinWidth;
                        this._explicitBackgroundMinHeight = loc2.explicitMinHeight;
                        this._explicitBackgroundMaxWidth = loc2.explicitMaxWidth;
                        this._explicitBackgroundMaxHeight = loc2.explicitMaxHeight;
                    }
                    else 
                    {
                        this._explicitBackgroundWidth = this.currentBackground.width;
                        this._explicitBackgroundHeight = this.currentBackground.height;
                        this._explicitBackgroundMinWidth = this._explicitBackgroundWidth;
                        this._explicitBackgroundMinHeight = this._explicitBackgroundHeight;
                        this._explicitBackgroundMaxWidth = this._explicitBackgroundWidth;
                        this._explicitBackgroundMaxHeight = this._explicitBackgroundHeight;
                    }
                }
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

        protected function refreshIcon():void
        {
            var loc2:*=0;
            var loc1:*=this.currentIcon;
            this.currentIcon = this.getCurrentIcon();
            if (this.currentIcon is feathers.core.IFeathersControl) 
            {
                feathers.core.IFeathersControl(this.currentIcon).isEnabled = this._isEnabled;
            }
            if (this.currentIcon !== loc1) 
            {
                if (loc1) 
                {
                    if (loc1 is feathers.core.IStateObserver) 
                    {
                        feathers.core.IStateObserver(loc1).stateContext = null;
                    }
                    this.removeChild(loc1, false);
                }
                if (this.currentIcon) 
                {
                    if (this.currentIcon is feathers.core.IStateObserver) 
                    {
                        feathers.core.IStateObserver(this.currentIcon).stateContext = this;
                    }
                    loc2 = this.getChildIndex(starling.display.DisplayObject(this.textEditor));
                    this.addChildAt(this.currentIcon, loc2);
                }
            }
            if (this.currentIcon && (!(this._originalIconWidth === this._originalIconWidth) || !(this._originalIconHeight === this._originalIconHeight))) 
            {
                if (this.currentIcon is feathers.core.IValidating) 
                {
                    feathers.core.IValidating(this.currentIcon).validate();
                }
                this._originalIconWidth = this.currentIcon.width;
                this._originalIconHeight = this.currentIcon.height;
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

        protected function getCurrentSkin():starling.display.DisplayObject
        {
            if (this._stateToSkinFunction !== null) 
            {
                return starling.display.DisplayObject(this._stateToSkinFunction(this, this._currentState, this.currentBackground));
            }
            var loc1:*=this._stateToSkin[this._currentState] as starling.display.DisplayObject;
            if (loc1 !== null) 
            {
                return loc1;
            }
            return this._backgroundSkin;
        }

        public function get promptFontStyles():starling.text.TextFormat
        {
            return this._promptFontStylesSet.format;
        }

        public function set promptFontStyles(arg1:starling.text.TextFormat):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            this._promptFontStylesSet.format = arg1;
            return;
        }

        public function get promptDisabledFontStyles():starling.text.TextFormat
        {
            return this._promptFontStylesSet.disabledFormat;
        }

        public function set promptDisabledFontStyles(arg1:starling.text.TextFormat):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            this._promptFontStylesSet.disabledFormat = arg1;
            return;
        }

        protected function getCurrentIcon():starling.display.DisplayObject
        {
            if (this._stateToIconFunction !== null) 
            {
                return starling.display.DisplayObject(this._stateToIconFunction(this, this._currentState, this.currentIcon));
            }
            var loc1:*=this._stateToIcon[this._currentState] as starling.display.DisplayObject;
            if (loc1 !== null) 
            {
                return loc1;
            }
            return this._defaultIcon;
        }

        public function get promptFactory():Function
        {
            return this._promptFactory;
        }

        public function set promptFactory(arg1:Function):void
        {
            if (this._promptFactory == arg1) 
            {
                return;
            }
            this._promptFactory = arg1;
            this.invalidate(INVALIDATION_FLAG_PROMPT_FACTORY);
            return;
        }

        protected function layoutChildren():void
        {
            var loc4:*=NaN;
            var loc5:*=NaN;
            if (this.currentBackground !== null) 
            {
                this.currentBackground.visible = true;
                this.currentBackground.touchable = true;
                this.currentBackground.width = this.actualWidth;
                this.currentBackground.height = this.actualHeight;
            }
            if (this.currentIcon is feathers.core.IValidating) 
            {
                feathers.core.IValidating(this.currentIcon).validate();
            }
            if (this.currentIcon === null) 
            {
                this.textEditor.x = this._paddingLeft;
                if (this.promptTextRenderer !== null) 
                {
                    this.promptTextRenderer.x = this._paddingLeft;
                }
            }
            else 
            {
                this.currentIcon.x = this._paddingLeft;
                this.textEditor.x = this.currentIcon.x + this.currentIcon.width + this._gap;
                if (this.promptTextRenderer !== null) 
                {
                    this.promptTextRenderer.x = this.currentIcon.x + this.currentIcon.width + this._gap;
                }
            }
            this.textEditor.width = this.actualWidth - this._paddingRight - this.textEditor.x;
            if (this.promptTextRenderer !== null) 
            {
                this.promptTextRenderer.width = this.actualWidth - this._paddingRight - this.promptTextRenderer.x;
            }
            var loc1:*=this.textEditor is feathers.core.IMultilineTextEditor && feathers.core.IMultilineTextEditor(this.textEditor).multiline;
            if (loc1 || this._verticalAlign === feathers.layout.VerticalAlign.JUSTIFY) 
            {
                this.textEditor.height = this.actualHeight - this._paddingTop - this._paddingBottom;
            }
            else 
            {
                this.textEditor.height = NaN;
            }
            this.textEditor.validate();
            if (this.promptTextRenderer !== null) 
            {
                this.promptTextRenderer.validate();
            }
            var loc2:*=this.textEditor.height;
            var loc3:*=this.textEditor.baseline;
            if (this.promptTextRenderer !== null) 
            {
                loc4 = this.promptTextRenderer.baseline;
                loc5 = this.promptTextRenderer.height;
                if (loc4 > loc3) 
                {
                    loc3 = loc4;
                }
                if (loc5 > loc2) 
                {
                    loc2 = loc5;
                }
            }
            if (loc1) 
            {
                this.textEditor.y = this._paddingTop + loc3 - this.textEditor.baseline;
                if (this.promptTextRenderer !== null) 
                {
                    this.promptTextRenderer.y = this._paddingTop + loc3 - loc4;
                    this.promptTextRenderer.height = this.actualHeight - this.promptTextRenderer.y - this._paddingBottom;
                }
                if (this.currentIcon !== null) 
                {
                    this.currentIcon.y = this._paddingTop;
                }
            }
            else 
            {
                var loc6:*=this._verticalAlign;
                switch (loc6) 
                {
                    case feathers.layout.VerticalAlign.JUSTIFY:
                    {
                        this.textEditor.y = this._paddingTop + loc3 - this.textEditor.baseline;
                        if (this.promptTextRenderer) 
                        {
                            this.promptTextRenderer.y = this._paddingTop + loc3 - loc4;
                            this.promptTextRenderer.height = this.actualHeight - this.promptTextRenderer.y - this._paddingBottom;
                        }
                        if (this.currentIcon) 
                        {
                            this.currentIcon.y = this._paddingTop;
                        }
                        break;
                    }
                    case feathers.layout.VerticalAlign.TOP:
                    {
                        this.textEditor.y = this._paddingTop + loc3 - this.textEditor.baseline;
                        if (this.promptTextRenderer) 
                        {
                            this.promptTextRenderer.y = this._paddingTop + loc3 - loc4;
                        }
                        if (this.currentIcon) 
                        {
                            this.currentIcon.y = this._paddingTop;
                        }
                        break;
                    }
                    case feathers.layout.VerticalAlign.BOTTOM:
                    {
                        this.textEditor.y = this.actualHeight - this._paddingBottom - loc2 + loc3 - this.textEditor.baseline;
                        if (this.promptTextRenderer) 
                        {
                            this.promptTextRenderer.y = this.actualHeight - this._paddingBottom - loc2 + loc3 - loc4;
                        }
                        if (this.currentIcon) 
                        {
                            this.currentIcon.y = this.actualHeight - this._paddingBottom - this.currentIcon.height;
                        }
                        break;
                    }
                    default:
                    {
                        this.textEditor.y = loc3 - this.textEditor.baseline + this._paddingTop + Math.round((this.actualHeight - this._paddingTop - this._paddingBottom - loc2) / 2);
                        if (this.promptTextRenderer) 
                        {
                            this.promptTextRenderer.y = loc3 - loc4 + this._paddingTop + Math.round((this.actualHeight - this._paddingTop - this._paddingBottom - loc2) / 2);
                        }
                        if (this.currentIcon) 
                        {
                            this.currentIcon.y = this._paddingTop + Math.round((this.actualHeight - this._paddingTop - this._paddingBottom - this.currentIcon.height) / 2);
                        }
                    }
                }
            }
            return;
        }

        public function get customPromptStyleName():String
        {
            return this._customPromptStyleName;
        }

        public function set customPromptStyleName(arg1:String):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._customPromptStyleName === arg1) 
            {
                return;
            }
            this._customPromptStyleName = arg1;
            this.invalidate(INVALIDATION_FLAG_TEXT_RENDERER);
            return;
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
            if (loc2 && !this._textEditorHasFocus) 
            {
                this.textEditor.globalToLocal(loc1, loc1);
                this._isWaitingToSetFocus = false;
                this.textEditor.setFocus(loc1);
            }
            starling.utils.Pool.putPoint(loc1);
            return;
        }

        public function get promptProperties():Object
        {
            if (!this._promptProperties) 
            {
                this._promptProperties = new feathers.core.PropertyProxy(this.childProperties_onChange);
            }
            return this._promptProperties;
        }

        public function set promptProperties(arg1:Object):void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (this._promptProperties == arg1) 
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
            if (this._promptProperties) 
            {
                this._promptProperties.removeOnChangeCallback(this.childProperties_onChange);
            }
            this._promptProperties = feathers.core.PropertyProxy(arg1);
            if (this._promptProperties) 
            {
                this._promptProperties.addOnChangeCallback(this.childProperties_onChange);
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function refreshState():void
        {
            if (this._isEnabled) 
            {
                if (this._textEditorHasFocus || this._hasFocus) 
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

        public function get defaultIcon():starling.display.DisplayObject
        {
            return this._defaultIcon;
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

        protected function childProperties_onChange(arg1:feathers.core.PropertyProxy, arg2:Object):void
        {
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function textInput_removedFromStageHandler(arg1:starling.events.Event):void
        {
            if (!this._focusManager && this._textEditorHasFocus) 
            {
                this.clearFocus();
            }
            this._textEditorHasFocus = false;
            this._isWaitingToSetFocus = false;
            this._touchPointID = -1;
            if (flash.ui.Mouse.supportsNativeCursor && this._oldMouseCursor) 
            {
                flash.ui.Mouse.cursor = this._oldMouseCursor;
                this._oldMouseCursor = null;
            }
            return;
        }

        protected function textInput_touchHandler(arg1:starling.events.TouchEvent):void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=false;
            if (!this._isEnabled) 
            {
                this._touchPointID = -1;
                return;
            }
            if (this._touchPointID >= 0) 
            {
                loc1 = arg1.getTouch(this, starling.events.TouchPhase.ENDED, this._touchPointID);
                if (!loc1) 
                {
                    return;
                }
                loc2 = starling.utils.Pool.getPoint();
                loc1.getLocation(this.stage, loc2);
                loc3 = this.contains(this.stage.hitTest(loc2));
                starling.utils.Pool.putPoint(loc2);
                if (!loc3) 
                {
                    if (flash.ui.Mouse.supportsNativeCursor && this._oldMouseCursor) 
                    {
                        flash.ui.Mouse.cursor = this._oldMouseCursor;
                        this._oldMouseCursor = null;
                    }
                }
                this._touchPointID = -1;
                if (this.textEditor.setTouchFocusOnEndedPhase) 
                {
                    this.setFocusOnTextEditorWithTouch(loc1);
                }
            }
            else 
            {
                loc1 = arg1.getTouch(this, starling.events.TouchPhase.BEGAN);
                if (loc1) 
                {
                    this._touchPointID = loc1.id;
                    if (!this.textEditor.setTouchFocusOnEndedPhase) 
                    {
                        this.setFocusOnTextEditorWithTouch(loc1);
                    }
                    return;
                }
                loc1 = arg1.getTouch(this, starling.events.TouchPhase.HOVER);
                if (loc1) 
                {
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

        protected override function focusInHandler(arg1:starling.events.Event):void
        {
            if (!this._focusManager) 
            {
                return;
            }
            super.focusInHandler(arg1);
            this.refreshState();
            this.setFocus();
            return;
        }

        protected override function focusOutHandler(arg1:starling.events.Event):void
        {
            if (!this._focusManager) 
            {
                return;
            }
            super.focusOutHandler(arg1);
            this.refreshState();
            this.textEditor.clearFocus();
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
                return;
            }
            if (this._backgroundSkin === arg1) 
            {
                return;
            }
            this._backgroundSkin = arg1;
            this.invalidate(INVALIDATION_FLAG_SKIN);
            return;
        }

        protected function textEditor_changeHandler(arg1:starling.events.Event):void
        {
            if (this._ignoreTextChanges) 
            {
                return;
            }
            this.text = this.textEditor.text;
            return;
        }

        public function get backgroundEnabledSkin():starling.display.DisplayObject
        {
            return this.getSkinForState(feathers.controls.TextInputState.ENABLED);
        }

        public function set backgroundEnabledSkin(arg1:starling.display.DisplayObject):void
        {
            this.setSkinForState(feathers.controls.TextInputState.ENABLED, arg1);
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

        public function get backgroundDisabledSkin():starling.display.DisplayObject
        {
            return this.getSkinForState(feathers.controls.TextInputState.DISABLED);
        }

        public function set backgroundDisabledSkin(arg1:starling.display.DisplayObject):void
        {
            this.setSkinForState(feathers.controls.TextInputState.DISABLED, arg1);
            return;
        }

        protected function textEditor_enterHandler(arg1:starling.events.Event):void
        {
            this.dispatchEventWith(feathers.events.FeathersEventType.ENTER);
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

        protected function textEditor_focusInHandler(arg1:starling.events.Event):void
        {
            if (!this.visible) 
            {
                this.textEditor.clearFocus();
                return;
            }
            this._textEditorHasFocus = true;
            this.refreshState();
            this.refreshErrorCallout();
            if (!(this._focusManager === null) && this.isFocusEnabled) 
            {
                if (this._focusManager.focus !== this) 
                {
                    this._focusManager.focus = this;
                }
            }
            else 
            {
                this.dispatchEventWith(feathers.events.FeathersEventType.FOCUS_IN);
            }
            return;
        }

        protected function textEditor_focusOutHandler(arg1:starling.events.Event):void
        {
            this._textEditorHasFocus = false;
            this.refreshState();
            this.refreshErrorCallout();
            if (!(this._focusManager === null) && this.isFocusEnabled) 
            {
                if (this._focusManager.focus === this) 
                {
                    this._focusManager.focus = null;
                }
            }
            else 
            {
                this.dispatchEventWith(feathers.events.FeathersEventType.FOCUS_OUT);
            }
            return;
        }

        protected function fontStyles_changeHandler(arg1:starling.events.Event):void
        {
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function set paddingRight(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._paddingRight === arg1) 
            {
                return;
            }
            this._paddingRight = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function set defaultIcon(arg1:starling.display.DisplayObject):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._defaultIcon === arg1) 
            {
                return;
            }
            this._defaultIcon = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get enabledIcon():starling.display.DisplayObject
        {
            return this.getIconForState(feathers.controls.TextInputState.ENABLED);
        }

        public function set enabledIcon(arg1:starling.display.DisplayObject):void
        {
            this.setIconForState(feathers.controls.TextInputState.ENABLED, arg1);
            return;
        }

        public function get disabledIcon():starling.display.DisplayObject
        {
            return this.getIconForState(feathers.controls.TextInputState.DISABLED);
        }

        public function set disabledIcon(arg1:starling.display.DisplayObject):void
        {
            this.setIconForState(feathers.controls.TextInputState.DISABLED, arg1);
            return;
        }

        public function get focusedIcon():starling.display.DisplayObject
        {
            return this.getIconForState(feathers.controls.TextInputState.FOCUSED);
        }

        public function set focusedIcon(arg1:starling.display.DisplayObject):void
        {
            this.setIconForState(feathers.controls.TextInputState.FOCUSED, arg1);
            return;
        }

        public function get errorIcon():starling.display.DisplayObject
        {
            return this.getIconForState(feathers.controls.TextInputState.ERROR);
        }

        public function set errorIcon(arg1:starling.display.DisplayObject):void
        {
            this.setIconForState(feathers.controls.TextInputState.ERROR, arg1);
            return;
        }

        public function get stateToIconFunction():Function
        {
            return this._stateToIconFunction;
        }

        public function set stateToIconFunction(arg1:Function):void
        {
            if (this._stateToIconFunction == arg1) 
            {
                return;
            }
            this._stateToIconFunction = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get gap():Number
        {
            return this._gap;
        }

        public function set gap(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._gap === arg1) 
            {
                return;
            }
            this._gap = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get padding():Number
        {
            return this._paddingTop;
        }

        public function set padding(arg1:Number):void
        {
            this.paddingTop = arg1;
            this.paddingRight = arg1;
            this.paddingBottom = arg1;
            this.paddingLeft = arg1;
            return;
        }

        public function get paddingTop():Number
        {
            return this._paddingTop;
        }

        public function set paddingTop(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._paddingTop === arg1) 
            {
                return;
            }
            this._paddingTop = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get paddingRight():Number
        {
            return this._paddingRight;
        }

        public function get paddingBottom():Number
        {
            return this._paddingBottom;
        }

        public function set paddingBottom(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._paddingBottom === arg1) 
            {
                return;
            }
            this._paddingBottom = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get paddingLeft():Number
        {
            return this._paddingLeft;
        }

        public function set paddingLeft(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._paddingLeft === arg1) 
            {
                return;
            }
            this._paddingLeft = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get verticalAlign():String
        {
            return this._verticalAlign;
        }

        public function set verticalAlign(arg1:String):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._verticalAlign === arg1) 
            {
                return;
            }
            this._verticalAlign = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get textEditorProperties():Object
        {
            if (!this._textEditorProperties) 
            {
                this._textEditorProperties = new feathers.core.PropertyProxy(this.childProperties_onChange);
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
                this._textEditorProperties.removeOnChangeCallback(this.childProperties_onChange);
            }
            this._textEditorProperties = feathers.core.PropertyProxy(arg1);
            if (this._textEditorProperties) 
            {
                this._textEditorProperties.addOnChangeCallback(this.childProperties_onChange);
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get selectionBeginIndex():int
        {
            if (this._pendingSelectionBeginIndex >= 0) 
            {
                return this._pendingSelectionBeginIndex;
            }
            if (this.textEditor) 
            {
                return this.textEditor.selectionBeginIndex;
            }
            return 0;
        }

        public function get selectionEndIndex():int
        {
            if (this._pendingSelectionEndIndex >= 0) 
            {
                return this._pendingSelectionEndIndex;
            }
            if (this.textEditor) 
            {
                return this.textEditor.selectionEndIndex;
            }
            return 0;
        }

        public override function set visible(arg1:Boolean):void
        {
            if (!arg1) 
            {
                this._isWaitingToSetFocus = false;
                if (this._textEditorHasFocus) 
                {
                    this.textEditor.clearFocus();
                }
            }
            super.visible = arg1;
            return;
        }

        public static const DEFAULT_CHILD_STYLE_NAME_TEXT_EDITOR:String="feathers-text-input-text-editor";

        protected static const INVALIDATION_FLAG_PROMPT_FACTORY:String="promptFactory";

        protected static const INVALIDATION_FLAG_ERROR_CALLOUT_FACTORY:String="errorCalloutFactory";

        public static const STATE_ENABLED:String="enabled";

        public static const STATE_DISABLED:String="disabled";

        public static const STATE_FOCUSED:String="focused";

        public static const DEFAULT_CHILD_STYLE_NAME_PROMPT:String="feathers-text-input-prompt";

        public static const DEFAULT_CHILD_STYLE_NAME_ERROR_CALLOUT:String="feathers-text-input-error-callout";

        public static const ALTERNATE_STYLE_NAME_SEARCH_TEXT_INPUT:String="feathers-search-text-input";

        public static const VERTICAL_ALIGN_TOP:String="top";

        public static const VERTICAL_ALIGN_MIDDLE:String="middle";

        public static const VERTICAL_ALIGN_BOTTOM:String="bottom";

        public static const VERTICAL_ALIGN_JUSTIFY:String="justify";

        protected var _prompt:String=null;

        protected var _typicalText:String=null;

        protected var _maxChars:int=0;

        protected var _restrict:String;

        protected var _displayAsPassword:Boolean=false;

        protected var _isEditable:Boolean=true;

        protected var _isSelectable:Boolean=true;

        protected var _errorString:String=null;

        protected var _fontStylesSet:feathers.text.FontStylesSet;

        protected var _textEditorFactory:Function;

        protected var _customTextEditorStyleName:String;

        protected var _promptFontStylesSet:feathers.text.FontStylesSet;

        protected var _promptFactory:Function;

        protected var _customPromptStyleName:String;

        protected var _promptProperties:feathers.core.PropertyProxy;

        protected var _customErrorCalloutStyleName:String;

        protected var _explicitBackgroundHeight:Number;

        protected var _explicitBackgroundMinWidth:Number;

        protected var _explicitBackgroundMinHeight:Number;

        protected var _explicitBackgroundMaxWidth:Number;

        protected var _explicitBackgroundMaxHeight:Number;

        protected var _backgroundSkin:starling.display.DisplayObject;

        protected var _stateToSkin:Object;

        protected var _stateToSkinFunction:Function;

        protected var _originalIconWidth:Number=NaN;

        protected var _originalIconHeight:Number=NaN;

        protected var _defaultIcon:starling.display.DisplayObject;

        protected var _paddingLeft:Number=0;

        protected var _gap:Number=0;

        protected var _paddingRight:Number=0;

        protected var _verticalAlign:String="middle";

        protected var _stateToIcon:Object;

        protected var _explicitBackgroundWidth:Number;

        protected var _isWaitingToSetFocus:Boolean=false;

        protected var _pendingSelectionBeginIndex:int=-1;

        protected var _pendingSelectionEndIndex:int=-1;

        protected var _oldMouseCursor:String=null;

        protected var _textEditorProperties:feathers.core.PropertyProxy;

        protected var textEditor:feathers.core.ITextEditor;

        protected var _paddingTop:Number=0;

        protected var _stateToIconFunction:Function;

        protected var promptTextRenderer:feathers.core.ITextRenderer;

        protected var currentBackground:starling.display.DisplayObject;

        protected var currentIcon:starling.display.DisplayObject;

        protected var callout:feathers.controls.TextCallout;

        protected var textEditorStyleName:String="feathers-text-input-text-editor";

        protected var _paddingBottom:Number=0;

        protected var promptStyleName:String="feathers-text-input-prompt";

        protected var errorCalloutStyleName:String="feathers-text-input-error-callout";

        protected var _textEditorHasFocus:Boolean=false;

        protected var _ignoreTextChanges:Boolean=false;

        protected var _touchPointID:int=-1;

        protected var _currentState:String="enabled";

        protected var _text:String="";

        public static var globalStyleProvider:feathers.skins.IStyleProvider;
    }
}


