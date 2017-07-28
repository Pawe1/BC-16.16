//class TextBlockTextEditor
package feathers.controls.text 
{
    import __AS3__.vec.*;
    import feathers.core.*;
    import feathers.events.*;
    import feathers.skins.*;
    import feathers.utils.text.*;
    import flash.desktop.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import flash.text.engine.*;
    import flash.ui.*;
    import starling.core.*;
    import starling.display.*;
    import starling.events.*;
    import starling.rendering.*;
    
    public class TextBlockTextEditor extends feathers.controls.text.TextBlockTextRenderer implements feathers.core.IIMETextEditor, feathers.core.INativeFocusOwner
    {
        public function TextBlockTextEditor()
        {
            super();
            this._text = "";
            this._textElement = new flash.text.engine.TextElement(this._text);
            this._content = this._textElement;
            this.isQuickHitAreaEnabled = true;
            this.truncateToFit = false;
            this.addEventListener(starling.events.TouchEvent.TOUCH, this.textEditor_touchHandler);
            return;
        }

        protected override function get defaultStyleProvider():feathers.skins.IStyleProvider
        {
            return globalStyleProvider;
        }

        protected function getSelectedText():String
        {
            if (this._selectionBeginIndex == this._selectionEndIndex) 
            {
                return null;
            }
            return this._text.substr(this._selectionBeginIndex, this._selectionEndIndex - this._selectionBeginIndex);
        }

        protected function deleteSelectedText():void
        {
            var loc1:*=this._text;
            if (this._displayAsPassword) 
            {
                loc1 = this._unmaskedText;
            }
            this.text = loc1.substr(0, this._selectionBeginIndex) + loc1.substr(this._selectionEndIndex);
            this.validate();
            this.selectRange(this._selectionBeginIndex, this._selectionBeginIndex);
            return;
        }

        protected function replaceSelectedText(arg1:String):void
        {
            var loc1:*=this._text;
            if (this._displayAsPassword) 
            {
                loc1 = this._unmaskedText;
            }
            var loc2:*=loc1.substr(0, this._selectionBeginIndex) + arg1 + loc1.substr(this._selectionEndIndex);
            if (this._maxChars > 0 && loc2.length > this._maxChars) 
            {
                return;
            }
            this.text = loc2;
            this.validate();
            var loc3:*=this._selectionBeginIndex + arg1.length;
            this.selectRange(loc3, loc3);
            return;
        }

        protected function imeClientStartCallback():void
        {
            return;
        }

        public function get selectionSkin():starling.display.DisplayObject
        {
            return this._selectionSkin;
        }

        public function set selectionSkin(arg1:starling.display.DisplayObject):void
        {
            if (this._selectionSkin == arg1) 
            {
                return;
            }
            if (this._selectionSkin && this._selectionSkin.parent == this) 
            {
                this._selectionSkin.removeFromParent();
            }
            this._selectionSkin = arg1;
            if (this._selectionSkin) 
            {
                this._selectionSkin.visible = false;
                this.addChildAt(this._selectionSkin, 0);
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function imeClientUpdateCallback(arg1:String, arg2:__AS3__.vec.Vector.<flash.text.ime.CompositionAttributeRange>, arg3:int, arg4:int):void
        {
            var loc1:*=this._text;
            if (this._displayAsPassword) 
            {
                loc1 = this._unmaskedText;
            }
            this._imeText = loc1.substr(0, this._selectionBeginIndex) + arg1 + loc1.substr(this._selectionEndIndex);
            this._imeCursorIndex = this._selectionBeginIndex + arg3;
            this._cursorSkin.visible = this._hasFocus;
            this._selectionSkin.visible = false;
            this.setInvalidationFlag(INVALIDATION_FLAG_DATA);
            this.validate();
            return;
        }

        public function get cursorSkin():starling.display.DisplayObject
        {
            return this._cursorSkin;
        }

        public function set cursorSkin(arg1:starling.display.DisplayObject):void
        {
            if (this._cursorSkin == arg1) 
            {
                return;
            }
            if (this._cursorSkin && this._cursorSkin.parent == this) 
            {
                this._cursorSkin.removeFromParent();
            }
            this._cursorSkin = arg1;
            if (this._cursorSkin) 
            {
                this._cursorSkin.visible = false;
                this.addChild(this._cursorSkin);
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function imeClientConfirmCallback(arg1:String=null, arg2:Boolean=false):void
        {
            this._ignoreNextTextInputEvent = true;
            return;
        }

        protected function hasFocus_enterFrameHandler(arg1:starling.events.Event):void
        {
            var loc1:*=this;
            do 
            {
                if (!loc1.visible) 
                {
                    this.clearFocus();
                    break;
                }
                loc1 = loc1.parent;
            }
            while (loc1);
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
            if (this._displayAsPassword) 
            {
                this._unmaskedText = this._text;
                this.refreshMaskedText();
            }
            else 
            {
                this._text = this._unmaskedText;
                this._unmaskedText = null;
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function textEditor_touchHandler(arg1:starling.events.TouchEvent):void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=0;
            if (!this._isEnabled || !this._isEditable && !this._isSelectable) 
            {
                this.touchPointID = -1;
                return;
            }
            if (this.touchPointID >= 0) 
            {
                loc1 = arg1.getTouch(this, null, this.touchPointID);
                loc1.getLocation(this, HELPER_POINT);
                HELPER_POINT.x = HELPER_POINT.x + this._textSnapshotScrollX;
                this.selectRange(this._selectionAnchorIndex, this.getSelectionIndexAtPoint(HELPER_POINT.x, HELPER_POINT.y));
                if (loc1.phase == starling.events.TouchPhase.ENDED) 
                {
                    this.touchPointID = -1;
                    if (!feathers.core.FocusManager.isEnabledForStage(this.stage) && this._hasFocus) 
                    {
                        this.stage.addEventListener(starling.events.TouchEvent.TOUCH, this.stage_touchHandler);
                    }
                }
            }
            else 
            {
                loc1 = arg1.getTouch(this, starling.events.TouchPhase.BEGAN);
                if (!loc1) 
                {
                    return;
                }
                if (loc1.tapCount === 2) 
                {
                    loc2 = feathers.utils.text.TextInputNavigation.findCurrentWordStartIndex(this._text, this._selectionBeginIndex);
                    loc3 = feathers.utils.text.TextInputNavigation.findCurrentWordEndIndex(this._text, this._selectionEndIndex);
                    this.selectRange(loc2, loc3);
                    return;
                }
                if (loc1.tapCount > 2) 
                {
                    this.selectRange(0, this._text.length);
                    return;
                }
                this.touchPointID = loc1.id;
                loc1.getLocation(this, HELPER_POINT);
                HELPER_POINT.x = HELPER_POINT.x + this._textSnapshotScrollX;
                if (arg1.shiftKey) 
                {
                    if (this._selectionAnchorIndex < 0) 
                    {
                        this._selectionAnchorIndex = this._selectionBeginIndex;
                    }
                    this.selectRange(this._selectionAnchorIndex, this.getSelectionIndexAtPoint(HELPER_POINT.x, HELPER_POINT.y));
                }
                else 
                {
                    this.setFocus(HELPER_POINT);
                }
            }
            return;
        }

        public function get passwordCharCode():int
        {
            return this._passwordCharCode;
        }

        public function set passwordCharCode(arg1:int):void
        {
            if (this._passwordCharCode == arg1) 
            {
                return;
            }
            this._passwordCharCode = arg1;
            if (this._displayAsPassword) 
            {
                this.refreshMaskedText();
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function stage_touchHandler(arg1:starling.events.TouchEvent):void
        {
            var loc1:*=arg1.getTouch(this.stage, starling.events.TouchPhase.BEGAN);
            if (!loc1) 
            {
                return;
            }
            loc1.getLocation(this.stage, HELPER_POINT);
            var loc2:*=this.contains(this.stage.hitTest(HELPER_POINT));
            if (loc2) 
            {
                return;
            }
            this.clearFocus();
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

        protected function nativeFocus_textInputHandler(arg1:flash.events.TextEvent):void
        {
            if (this._ignoreNextTextInputEvent) 
            {
                this._ignoreNextTextInputEvent = false;
                return;
            }
            if (!this._isEditable || !this._isEnabled) 
            {
                return;
            }
            this._imeText = null;
            this._imeCursorIndex = -1;
            var loc1:*=arg1.text;
            if (loc1 === CARRIAGE_RETURN || loc1 === LINE_FEED) 
            {
                return;
            }
            var loc2:*=loc1.charCodeAt(0);
            if (!this._restrict || this._restrict.isCharacterAllowed(loc2)) 
            {
                this.replaceSelectedText(loc1);
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

        public function get setTouchFocusOnEndedPhase():Boolean
        {
            return false;
        }

        public override function get text():String
        {
            if (this._displayAsPassword) 
            {
                return this._unmaskedText;
            }
            return this._text;
        }

        public override function set text(arg1:String):void
        {
            if (arg1 === null) 
            {
                arg1 = "";
            }
            var loc1:*=this._text;
            if (this._displayAsPassword) 
            {
                loc1 = this._unmaskedText;
            }
            if (loc1 == arg1) 
            {
                return;
            }
            if (this._displayAsPassword) 
            {
                this._unmaskedText = arg1;
                this.refreshMaskedText();
            }
            else 
            {
                super.text = arg1;
            }
            var loc2:*=this._text.length;
            if (this._selectionAnchorIndex > loc2) 
            {
                this._selectionAnchorIndex = loc2;
            }
            if (this._selectionBeginIndex > loc2) 
            {
                this.selectRange(loc2, loc2);
            }
            else if (this._selectionEndIndex > loc2) 
            {
                this.selectRange(this._selectionBeginIndex, loc2);
            }
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        protected function nativeFocus_selectAllHandler(arg1:flash.events.Event):void
        {
            if (!this._isEnabled || !this._isEditable && !this._isSelectable) 
            {
                return;
            }
            this._selectionAnchorIndex = 0;
            this.selectRange(0, this._text.length);
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

        protected override function draw():void
        {
            var loc1:*=this.isInvalid(INVALIDATION_FLAG_DATA);
            var loc2:*=this.isInvalid(INVALIDATION_FLAG_SELECTED);
            super.draw();
            if (loc1 || loc2) 
            {
                this.positionCursorAtCharIndex(this.getCursorIndexFromSelectionRange());
                this.positionSelectionBackground();
            }
            return;
        }

        public function get restrict():String
        {
            if (!this._restrict) 
            {
                return null;
            }
            return this._restrict.restrict;
        }

        public function set restrict(arg1:String):void
        {
            if (this._restrict && this._restrict.restrict === arg1) 
            {
                return;
            }
            if (!this._restrict && arg1 === null) 
            {
                return;
            }
            if (arg1 !== null) 
            {
                if (this._restrict) 
                {
                    this._restrict.restrict = arg1;
                }
                else 
                {
                    this._restrict = new feathers.utils.text.TextInputRestrict(arg1);
                }
            }
            else 
            {
                this._restrict = null;
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function nativeFocus_cutHandler(arg1:flash.events.Event):void
        {
            if (!this._isEnabled || !this._isEditable && !this._isSelectable || this._selectionBeginIndex == this._selectionEndIndex || this._displayAsPassword) 
            {
                return;
            }
            flash.desktop.Clipboard.generalClipboard.setData(flash.desktop.ClipboardFormats.TEXT_FORMAT, this.getSelectedText());
            if (!this._isEditable) 
            {
                return;
            }
            this.deleteSelectedText();
            return;
        }

        public function get selectionBeginIndex():int
        {
            return this._selectionBeginIndex;
        }

        protected function nativeFocus_copyHandler(arg1:flash.events.Event):void
        {
            if (!this._isEnabled || !this._isEditable && !this._isSelectable || this._selectionBeginIndex == this._selectionEndIndex || this._displayAsPassword) 
            {
                return;
            }
            flash.desktop.Clipboard.generalClipboard.setData(flash.desktop.ClipboardFormats.TEXT_FORMAT, this.getSelectedText());
            return;
        }

        public function get selectionEndIndex():int
        {
            return this._selectionEndIndex;
        }

        protected function nativeFocus_pasteHandler(arg1:flash.events.Event):void
        {
            if (!this._isEditable || !this._isEnabled) 
            {
                return;
            }
            var loc1:*=flash.desktop.Clipboard.generalClipboard.getData(flash.desktop.ClipboardFormats.TEXT_FORMAT) as String;
            if (loc1 === null) 
            {
                return;
            }
            if (this._restrict) 
            {
                loc1 = this._restrict.filterText(loc1);
            }
            this.replaceSelectedText(loc1);
            return;
        }

        public function get selectionAnchorIndex():int
        {
            return this._selectionAnchorIndex;
        }

        public function get selectionActiveIndex():int
        {
            if (this._selectionAnchorIndex === this._selectionBeginIndex) 
            {
                return this._selectionEndIndex;
            }
            return this._selectionBeginIndex;
        }

        protected function stage_keyDownHandler(arg1:starling.events.KeyboardEvent):void
        {
            var loc3:*=null;
            var loc4:*=0;
            if (!this._isEnabled || !this._isEditable && !this._isSelectable || this.touchPointID >= 0 || arg1.isDefaultPrevented()) 
            {
                return;
            }
            var loc1:*=arg1.charCode;
            if (arg1.ctrlKey && (loc1 == 97 || loc1 == 99 || loc1 == 118 || loc1 == 120)) 
            {
                return;
            }
            var loc2:*=-1;
            if (!feathers.core.FocusManager.isEnabledForStage(this.stage) && arg1.keyCode == flash.ui.Keyboard.TAB) 
            {
                this.clearFocus();
                return;
            }
            if (arg1.keyCode == flash.ui.Keyboard.HOME || arg1.keyCode == flash.ui.Keyboard.UP) 
            {
                loc2 = 0;
            }
            else if (arg1.keyCode == flash.ui.Keyboard.END || arg1.keyCode == flash.ui.Keyboard.DOWN) 
            {
                loc2 = this._text.length;
            }
            else if (arg1.keyCode != flash.ui.Keyboard.LEFT) 
            {
                if (arg1.keyCode == flash.ui.Keyboard.RIGHT) 
                {
                    if (arg1.shiftKey) 
                    {
                        if (this._selectionAnchorIndex >= 0 && this._selectionAnchorIndex == this._selectionEndIndex && !(this._selectionBeginIndex == this._selectionEndIndex)) 
                        {
                            loc2 = this._selectionBeginIndex + 1;
                            this.selectRange(loc2, this._selectionEndIndex);
                        }
                        else 
                        {
                            loc2 = this._selectionEndIndex + 1;
                            if (loc2 < 0 || loc2 > this._text.length) 
                            {
                                loc2 = this._text.length;
                            }
                            this.selectRange(this._selectionBeginIndex, loc2);
                        }
                        return;
                    }
                    if (this._selectionBeginIndex == this._selectionEndIndex) 
                    {
                        if (arg1.altKey || arg1.ctrlKey) 
                        {
                            loc2 = feathers.utils.text.TextInputNavigation.findNextWordStartIndex(this._text, this._selectionEndIndex);
                        }
                        else 
                        {
                            loc2 = this._selectionEndIndex + 1;
                        }
                        if (loc2 < 0 || loc2 > this._text.length) 
                        {
                            loc2 = this._text.length;
                        }
                    }
                    else 
                    {
                        loc2 = this._selectionEndIndex;
                    }
                }
            }
            else 
            {
                if (arg1.shiftKey) 
                {
                    if (this._selectionAnchorIndex >= 0 && this._selectionAnchorIndex == this._selectionBeginIndex && !(this._selectionBeginIndex == this._selectionEndIndex)) 
                    {
                        loc2 = (this._selectionEndIndex - 1);
                        this.selectRange(this._selectionBeginIndex, loc2);
                    }
                    else 
                    {
                        loc2 = (this._selectionBeginIndex - 1);
                        if (loc2 < 0) 
                        {
                            loc2 = 0;
                        }
                        this.selectRange(loc2, this._selectionEndIndex);
                    }
                    return;
                }
                if (this._selectionBeginIndex == this._selectionEndIndex) 
                {
                    if (arg1.altKey || arg1.ctrlKey) 
                    {
                        loc2 = feathers.utils.text.TextInputNavigation.findPreviousWordStartIndex(this._text, this._selectionBeginIndex);
                    }
                    else 
                    {
                        loc2 = (this._selectionBeginIndex - 1);
                    }
                    if (loc2 < 0) 
                    {
                        loc2 = 0;
                    }
                }
                else 
                {
                    loc2 = this._selectionBeginIndex;
                }
            }
            if (loc2 < 0) 
            {
                if (arg1.keyCode == flash.ui.Keyboard.ENTER) 
                {
                    this.dispatchEventWith(feathers.events.FeathersEventType.ENTER);
                    return;
                }
                if (!this._isEditable) 
                {
                    return;
                }
                loc3 = this._text;
                if (this._displayAsPassword) 
                {
                    loc3 = this._unmaskedText;
                }
                if (arg1.keyCode != flash.ui.Keyboard.DELETE) 
                {
                    if (arg1.keyCode == flash.ui.Keyboard.BACKSPACE) 
                    {
                        if (arg1.altKey || arg1.ctrlKey) 
                        {
                            loc2 = feathers.utils.text.TextInputNavigation.findPreviousWordStartIndex(this._text, this._selectionBeginIndex);
                            this.text = loc3.substr(0, loc2) + loc3.substr(this._selectionEndIndex);
                        }
                        else if (this._selectionBeginIndex == this._selectionEndIndex) 
                        {
                            if (this._selectionBeginIndex > 0) 
                            {
                                loc2 = (this._selectionBeginIndex - 1);
                                this.text = loc3.substr(0, (this._selectionBeginIndex - 1)) + loc3.substr(this._selectionEndIndex);
                            }
                        }
                        else 
                        {
                            this.deleteSelectedText();
                        }
                    }
                }
                else if (arg1.altKey || arg1.ctrlKey) 
                {
                    loc4 = feathers.utils.text.TextInputNavigation.findNextWordStartIndex(this._text, this._selectionEndIndex);
                    this.text = loc3.substr(0, this._selectionBeginIndex) + loc3.substr(loc4);
                }
                else if (this._selectionBeginIndex == this._selectionEndIndex) 
                {
                    if (this._selectionEndIndex < loc3.length) 
                    {
                        this.text = loc3.substr(0, this._selectionBeginIndex) + loc3.substr(this._selectionEndIndex + 1);
                    }
                }
                else 
                {
                    this.deleteSelectedText();
                }
            }
            if (loc2 >= 0) 
            {
                this.validate();
                this.selectRange(loc2, loc2);
            }
            return;
        }

        public function get nativeFocus():Object
        {
            return this._nativeFocus;
        }

        public function setFocus(arg1:flash.geom.Point=null):void
        {
            var loc1:*=0;
            var loc2:*=null;
            if (this._hasFocus && !arg1) 
            {
                return;
            }
            if (this._nativeFocus === null) 
            {
                this._isWaitingToSetFocus = true;
            }
            else 
            {
                if (this._nativeFocus.parent === null) 
                {
                    loc2 = this.stage === null ? starling.core.Starling.current : this.stage.starling;
                    loc2.nativeStage.addChild(this._nativeFocus);
                }
                loc1 = -1;
                if (arg1 !== null) 
                {
                    loc1 = this.getSelectionIndexAtPoint(arg1.x, arg1.y);
                }
                if (loc1 >= 0) 
                {
                    this.selectRange(loc1, loc1);
                }
                this.focusIn();
            }
            return;
        }

        public function clearFocus():void
        {
            if (!this._hasFocus) 
            {
                return;
            }
            this._hasFocus = false;
            this._cursorSkin.visible = false;
            this._selectionSkin.visible = false;
            this.stage.removeEventListener(starling.events.TouchEvent.TOUCH, this.stage_touchHandler);
            this.stage.removeEventListener(starling.events.KeyboardEvent.KEY_DOWN, this.stage_keyDownHandler);
            this.removeEventListener(starling.events.Event.ENTER_FRAME, this.hasFocus_enterFrameHandler);
            var loc1:*=this.stage === null ? starling.core.Starling.current : this.stage.starling;
            var loc2:*=loc1.nativeStage;
            if (loc2.focus === this._nativeFocus) 
            {
                loc2.focus = null;
            }
            this.dispatchEventWith(feathers.events.FeathersEventType.FOCUS_OUT);
            return;
        }

        public function selectRange(arg1:int, arg2:int):void
        {
            var loc1:*=0;
            if (!this._isEditable && !this._isSelectable) 
            {
                return;
            }
            if (arg2 < arg1) 
            {
                loc1 = arg2;
                arg2 = arg1;
                arg1 = loc1;
            }
            this._selectionBeginIndex = arg1;
            this._selectionEndIndex = arg2;
            if (arg1 !== arg2) 
            {
                this._cursorSkin.visible = false;
                this._selectionSkin.visible = true;
            }
            else 
            {
                this._selectionAnchorIndex = arg1;
                if (arg1 < 0) 
                {
                    this._cursorSkin.visible = false;
                }
                else 
                {
                    this._cursorSkin.visible = this._hasFocus && this._isEditable;
                }
                this._selectionSkin.visible = false;
            }
            this.invalidate(INVALIDATION_FLAG_SELECTED);
            return;
        }

        public override function dispose():void
        {
            if (this._nativeFocus && this._nativeFocus.parent) 
            {
                this._nativeFocus.parent.removeChild(this._nativeFocus);
            }
            this._nativeFocus = null;
            super.dispose();
            return;
        }

        public override function render(arg1:starling.rendering.Painter):void
        {
            var loc1:*=this._textSnapshotOffsetX;
            var loc2:*=this._cursorSkin.x;
            this._cursorSkin.x = this._cursorSkin.x - this._textSnapshotScrollX;
            super.render(arg1);
            this._textSnapshotOffsetX = loc1;
            this._cursorSkin.x = loc2;
            return;
        }

        protected override function initialize():void
        {
            if (!this._nativeFocus) 
            {
                this._nativeFocus = new feathers.utils.text.TextEditorIMEClient(this, this.imeClientStartCallback, this.imeClientUpdateCallback, this.imeClientConfirmCallback);
                this._nativeFocus.tabEnabled = false;
                this._nativeFocus.tabChildren = false;
                this._nativeFocus.mouseEnabled = false;
                this._nativeFocus.mouseChildren = false;
                this._nativeFocus.needsSoftKeyboard = true;
            }
            this._nativeFocus.addEventListener(flash.events.Event.CUT, this.nativeFocus_cutHandler, false, 0, true);
            this._nativeFocus.addEventListener(flash.events.Event.COPY, this.nativeFocus_copyHandler, false, 0, true);
            this._nativeFocus.addEventListener(flash.events.Event.PASTE, this.nativeFocus_pasteHandler, false, 0, true);
            this._nativeFocus.addEventListener(flash.events.Event.SELECT_ALL, this.nativeFocus_selectAllHandler, false, 0, true);
            this._nativeFocus.addEventListener(flash.events.TextEvent.TEXT_INPUT, this.nativeFocus_textInputHandler, false, 0, true);
            if (!this._cursorSkin) 
            {
                this.cursorSkin = new starling.display.Quad(1, 1, 0);
            }
            if (!this._selectionSkin) 
            {
                this.selectionSkin = new starling.display.Quad(1, 1, 0);
            }
            super.initialize();
            return;
        }

        protected override function refreshTextElementText():void
        {
            if (this._textElement === null) 
            {
                return;
            }
            var loc1:*=this._text;
            if (this._imeText !== null) 
            {
                loc1 = this._imeText;
            }
            if (loc1) 
            {
                this._textElement.text = loc1;
                if (!(loc1 === null) && loc1.charAt((loc1.length - 1)) == " ") 
                {
                    this._textElement.text = this._textElement.text + String.fromCharCode(3);
                }
            }
            else 
            {
                this._textElement.text = String.fromCharCode(3);
            }
            return;
        }

        protected override function refreshTextLines(arg1:__AS3__.vec.Vector.<flash.text.engine.TextLine>, arg2:flash.display.DisplayObjectContainer, arg3:Number, arg4:Number, arg5:feathers.controls.text.MeasureTextResult=null):feathers.controls.text.MeasureTextResult
        {
            arg5 = super.refreshTextLines(arg1, arg2, arg3, arg4, arg5);
            if (!(arg1 === this._measurementTextLines) && arg2.width > arg3) 
            {
                this.alignTextLines(arg1, arg3, flash.text.TextFormatAlign.LEFT);
            }
            return arg5;
        }

        protected function refreshMaskedText():void
        {
            var loc1:*="";
            var loc2:*=this._unmaskedText.length;
            var loc3:*=String.fromCharCode(this._passwordCharCode);
            var loc4:*=0;
            while (loc4 < loc2) 
            {
                loc1 = loc1 + loc3;
                ++loc4;
            }
            super.text = loc1;
            return;
        }

        protected function focusIn():void
        {
            var loc3:*=null;
            var loc1:*=(this._isEditable || this._isSelectable) && this._selectionBeginIndex >= 0 && !(this._selectionBeginIndex === this._selectionEndIndex);
            var loc2:*=this._isEditable && this._selectionBeginIndex >= 0 && this._selectionBeginIndex === this._selectionEndIndex;
            this._cursorSkin.visible = loc2;
            this._selectionSkin.visible = loc1;
            if (!feathers.core.FocusManager.isEnabledForStage(this.stage)) 
            {
                loc3 = this.stage === null ? starling.core.Starling.current : this.stage.starling;
                loc3.nativeStage.focus = this._nativeFocus;
            }
            this._nativeFocus.requestSoftKeyboard();
            if (this._hasFocus) 
            {
                return;
            }
            this._hasFocus = true;
            this.stage.addEventListener(starling.events.KeyboardEvent.KEY_DOWN, this.stage_keyDownHandler);
            this.addEventListener(starling.events.Event.ENTER_FRAME, this.hasFocus_enterFrameHandler);
            this.dispatchEventWith(feathers.events.FeathersEventType.FOCUS_IN);
            return;
        }

        protected function getSelectionIndexAtPoint(arg1:Number, arg2:Number):int
        {
            if (!this._text || this._textLines.length == 0) 
            {
                return 0;
            }
            var loc1:*=this._textLines[0];
            if (arg1 - loc1.x <= 0) 
            {
                return 0;
            }
            if (arg1 - loc1.x >= loc1.width) 
            {
                return this._text.length;
            }
            var loc2:*=loc1.getAtomIndexAtPoint(arg1, arg2);
            if (loc2 < 0) 
            {
                loc2 = loc1.getAtomIndexAtPoint(arg1, loc1.ascent / 2);
            }
            if (loc2 < 0) 
            {
                return this._text.length;
            }
            if (loc2 > this._text.length) 
            {
                loc2 = this._text.length;
            }
            var loc3:*=loc1.getAtomBounds(loc2);
            if (arg1 - loc1.x - loc3.x > loc3.width / 2) 
            {
                return loc2 + 1;
            }
            return loc2;
        }

        protected function getXPositionOfCharIndex(arg1:int):Number
        {
            var loc1:*=this._text;
            if (this._imeText !== null) 
            {
                loc1 = this._imeText;
            }
            if (!loc1 || this._textLines.length == 0) 
            {
                if (this._textAlign == flash.text.TextFormatAlign.CENTER) 
                {
                    return Math.round(this.actualWidth / 2);
                }
                if (this._textAlign == flash.text.TextFormatAlign.RIGHT) 
                {
                    return this.actualWidth;
                }
                return 0;
            }
            var loc2:*=this._textLines[0];
            if (arg1 == loc1.length) 
            {
                return loc2.x + loc2.width;
            }
            var loc3:*=loc2.getAtomIndexAtCharIndex(arg1);
            return loc2.x + loc2.getAtomBounds(loc3).x;
        }

        protected function positionCursorAtCharIndex(arg1:int):void
        {
            var loc6:*=null;
            if (arg1 < 0) 
            {
                arg1 = 0;
            }
            var loc1:*=this.getXPositionOfCharIndex(arg1);
            loc1 = int(loc1 - this._cursorSkin.width / 2);
            this._cursorSkin.x = loc1;
            this._cursorSkin.y = this._verticalAlignOffsetY;
            if (this._textLines.length > 0) 
            {
                loc6 = this._textLines[0];
                this._cursorSkin.height = this.calculateLineAscent(loc6) + loc6.totalDescent;
            }
            else 
            {
                this._cursorSkin.height = this.currentElementFormat.fontSize;
            }
            var loc2:*=loc1 + this._cursorSkin.width - this.actualWidth;
            var loc3:*=this._text;
            if (this._imeText !== null) 
            {
                loc3 = this._imeText;
            }
            var loc4:*=this.getXPositionOfCharIndex(loc3.length) - this.actualWidth;
            if (loc4 < 0) 
            {
                loc4 = 0;
            }
            var loc5:*=this._textSnapshotScrollX;
            if (this._textSnapshotScrollX < loc2) 
            {
                this._textSnapshotScrollX = loc2;
            }
            else if (this._textSnapshotScrollX > loc1) 
            {
                this._textSnapshotScrollX = loc1;
            }
            if (this._textSnapshotScrollX > loc4) 
            {
                this._textSnapshotScrollX = loc4;
            }
            if (this._textSnapshotScrollX != loc5) 
            {
                this.invalidate(INVALIDATION_FLAG_DATA);
            }
            return;
        }

        protected function getCursorIndexFromSelectionRange():int
        {
            if (this._imeCursorIndex >= 0) 
            {
                return this._imeCursorIndex;
            }
            var loc1:*=this._selectionEndIndex;
            if (this.touchPointID >= 0 && this._selectionAnchorIndex >= 0 && this._selectionAnchorIndex == this._selectionEndIndex) 
            {
                loc1 = this._selectionBeginIndex;
            }
            return loc1;
        }

        protected function positionSelectionBackground():void
        {
            var loc6:*=null;
            var loc1:*=this._text;
            if (this._imeText !== null) 
            {
                loc1 = this._imeText;
            }
            var loc2:*=this._selectionBeginIndex;
            if (loc2 > loc1.length) 
            {
                loc2 = loc1.length;
            }
            var loc3:*=this.getXPositionOfCharIndex(loc2) - this._textSnapshotScrollX;
            if (loc3 < 0) 
            {
                loc3 = 0;
            }
            var loc4:*=this._selectionEndIndex;
            if (loc4 > loc1.length) 
            {
                loc4 = loc1.length;
            }
            var loc5:*=this.getXPositionOfCharIndex(loc4) - this._textSnapshotScrollX;
            if (loc5 < 0) 
            {
                loc5 = 0;
            }
            else if (loc5 > this.actualWidth) 
            {
                loc5 = this.actualWidth;
            }
            this._selectionSkin.x = loc3;
            this._selectionSkin.width = loc5 - loc3;
            this._selectionSkin.y = this._verticalAlignOffsetY;
            if (this._textLines.length > 0) 
            {
                loc6 = this._textLines[0];
                this._selectionSkin.height = this.calculateLineAscent(loc6) + loc6.totalDescent;
            }
            else 
            {
                this._selectionSkin.height = this.currentElementFormat.fontSize;
            }
            return;
        }

        internal static const HELPER_POINT:flash.geom.Point=new flash.geom.Point();

        public static const TEXT_ALIGN_LEFT:String="left";

        public static const TEXT_ALIGN_CENTER:String="center";

        public static const TEXT_ALIGN_RIGHT:String="right";

        protected var _ignoreNextTextInputEvent:Boolean=false;

        protected var _imeText:String;

        protected var _imeCursorIndex:int=-1;

        protected var _selectionSkin:starling.display.DisplayObject;

        protected var _cursorSkin:starling.display.DisplayObject;

        protected var _unmaskedText:String;

        protected var _displayAsPassword:Boolean=false;

        protected var _passwordCharCode:int=42;

        protected var _isEditable:Boolean=true;

        protected var _isSelectable:Boolean=true;

        protected var _maxChars:int=0;

        protected var _selectionBeginIndex:int=0;

        protected var _selectionEndIndex:int=0;

        protected var _selectionAnchorIndex:int=0;

        protected var _isWaitingToSetFocus:Boolean=false;

        protected var touchPointID:int=-1;

        protected var _restrict:feathers.utils.text.TextInputRestrict;

        protected var _nativeFocus:flash.display.Sprite;

        public static var globalStyleProvider:feathers.skins.IStyleProvider;
    }
}


