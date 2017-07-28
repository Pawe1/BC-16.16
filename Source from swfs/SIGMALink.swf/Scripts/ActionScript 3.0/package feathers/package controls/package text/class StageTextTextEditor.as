//class StageTextTextEditor
package feathers.controls.text 
{
    import feathers.core.*;
    import feathers.events.*;
    import feathers.skins.*;
    import feathers.text.*;
    import feathers.utils.display.*;
    import feathers.utils.geom.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.system.*;
    import flash.text.*;
    import flash.text.engine.*;
    import flash.ui.*;
    import flash.utils.*;
    import starling.core.*;
    import starling.display.*;
    import starling.events.*;
    import starling.rendering.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    
    public class StageTextTextEditor extends feathers.core.BaseTextEditor implements feathers.core.IMultilineTextEditor, feathers.core.INativeFocusOwner
    {
        public function StageTextTextEditor()
        {
            super();
            this._stageTextIsTextField = new RegExp("^(Windows|Mac OS|Linux) .*").exec(flash.system.Capabilities.os) || flash.system.Capabilities.playerType === "Desktop" && flash.system.Capabilities.isDebugger;
            this.isQuickHitAreaEnabled = true;
            this.addEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.textEditor_removedFromStageHandler);
            return;
        }

        protected override function get defaultStyleProvider():feathers.skins.IStyleProvider
        {
            return globalStyleProvider;
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
            var loc5:*=starling.utils.Pool.getPoint();
            this.measure(loc5);
            var loc6:*=this.saveMeasurements(loc5.x, loc5.y, loc5.x, loc5.y);
            starling.utils.Pool.putPoint(loc5);
            return loc6;
        }

        public function get nativeFocus():Object
        {
            if (!this._isEditable) 
            {
                return null;
            }
            return this.stageText;
        }

        protected function refreshMeasureProperties():void
        {
            var loc2:*=null;
            this._measureTextField.displayAsPassword = this._displayAsPassword;
            this._measureTextField.maxChars = this._maxChars;
            this._measureTextField.restrict = this._restrict;
            this._measureTextField.multiline = this._multiline;
            this._measureTextField.wordWrap = this._multiline;
            var loc1:*=this._measureTextField.defaultTextFormat;
            if (this._fontStyles !== null) 
            {
                loc2 = this._fontStyles.getTextFormatForTarget(this);
            }
            if (this._fontFamily === null) 
            {
                if (loc2 === null) 
                {
                    loc1.font = null;
                }
                else 
                {
                    loc1.font = loc2.font;
                }
            }
            else 
            {
                loc1.font = this._fontFamily;
            }
            if (this._fontSize > 0) 
            {
                loc1.size = this._fontSize;
            }
            else if (loc2 === null) 
            {
                loc1.size = 12;
            }
            else 
            {
                loc1.size = loc2.size;
            }
            if (this._fontWeight === null) 
            {
                if (loc2 === null) 
                {
                    loc1.bold = false;
                }
                else 
                {
                    loc1.bold = loc2.bold;
                }
            }
            else 
            {
                loc1.bold = this._fontWeight === flash.text.engine.FontWeight.BOLD;
            }
            if (this._fontPosture === null) 
            {
                if (loc2 === null) 
                {
                    loc1.italic = false;
                }
                else 
                {
                    loc1.italic = loc2.italic;
                }
            }
            else 
            {
                loc1.italic = this._fontPosture === flash.text.engine.FontPosture.ITALIC;
            }
            this._measureTextField.defaultTextFormat = loc1;
            this._measureTextField.setTextFormat(loc1);
            if (this._text.length != 0) 
            {
                this._measureTextField.text = this._text;
            }
            else 
            {
                this._measureTextField.text = " ";
            }
            return;
        }

        protected function refreshStageTextProperties():void
        {
            var loc1:*=null;
            if (this.stageText.multiline != this._multiline) 
            {
                if (this.stageText) 
                {
                    this.disposeStageText();
                }
                this.createStageText();
            }
            if (this._fontStyles !== null) 
            {
                loc1 = this._fontStyles.getTextFormatForTarget(this);
            }
            this.stageText.autoCapitalize = this._autoCapitalize;
            this.stageText.autoCorrect = this._autoCorrect;
            if (this._isEnabled) 
            {
                if (this._color !== uint.MAX_VALUE) 
                {
                    this.stageText.color = this._color;
                }
                else if (loc1 === null) 
                {
                    this.stageText.color = 0;
                }
                else 
                {
                    this.stageText.color = loc1.color;
                }
            }
            else if (this._disabledColor !== uint.MAX_VALUE) 
            {
                this.stageText.color = this._disabledColor;
            }
            else if (this._color !== uint.MAX_VALUE) 
            {
                this.stageText.color = this._color;
            }
            else if (loc1 === null) 
            {
                this.stageText.color = 0;
            }
            else 
            {
                this.stageText.color = loc1.color;
            }
            this.stageText.displayAsPassword = this._displayAsPassword;
            var loc2:*=this._fontFamily;
            if (loc2 === null && !(loc1 === null)) 
            {
                loc2 = loc1.font;
            }
            this.stageText.fontFamily = loc2;
            var loc3:*=this._fontPosture;
            if (loc3 === null) 
            {
                if (!(loc1 === null) && loc1.italic) 
                {
                    loc3 = flash.text.engine.FontPosture.ITALIC;
                }
                else 
                {
                    loc3 = flash.text.engine.FontPosture.NORMAL;
                }
            }
            this.stageText.fontPosture = loc3;
            var loc4:*=this._fontWeight;
            if (loc4 === null) 
            {
                if (!(loc1 === null) && loc1.bold) 
                {
                    loc4 = flash.text.engine.FontWeight.BOLD;
                }
                else 
                {
                    loc4 = flash.text.engine.FontWeight.NORMAL;
                }
            }
            this.stageText.fontWeight = loc4;
            this.stageText.locale = this._locale;
            this.stageText.maxChars = this._maxChars;
            this.stageText.restrict = this._restrict;
            this.stageText.returnKeyLabel = this._returnKeyLabel;
            this.stageText.softKeyboardType = this._softKeyboardType;
            var loc5:*=this._textAlign;
            if (loc5 === null) 
            {
                if (!(loc1 === null) && loc1.horizontalAlign) 
                {
                    loc5 = loc1.horizontalAlign;
                }
                else 
                {
                    loc5 = flash.text.TextFormatAlign.START;
                }
            }
            this.stageText.textAlign = loc5;
            return;
        }

        protected function doPendingActions():void
        {
            var loc1:*=0;
            var loc2:*=0;
            if (this._isWaitingToSetFocus) 
            {
                this._isWaitingToSetFocus = false;
                this.setFocus();
            }
            if (this._pendingSelectionBeginIndex >= 0) 
            {
                loc1 = this._pendingSelectionBeginIndex;
                loc2 = this._pendingSelectionEndIndex < 0 ? this._pendingSelectionBeginIndex : this._pendingSelectionEndIndex;
                this._pendingSelectionBeginIndex = -1;
                this._pendingSelectionEndIndex = -1;
                if (!(this.stageText.selectionAnchorIndex == loc1) || !(this.stageText.selectionActiveIndex == loc2)) 
                {
                    this.selectRange(loc1, loc2);
                }
            }
            return;
        }

        protected function texture_onRestore():void
        {
            var loc1:*=this.stage === null ? starling.core.Starling.current : this.stage.starling;
            if (this.textSnapshot.texture.scale == loc1.contentScaleFactor) 
            {
                this.refreshSnapshot();
                if (this.textSnapshot) 
                {
                    this.textSnapshot.visible = !this._stageTextHasFocus;
                    this.textSnapshot.alpha = this._text.length > 0 ? 1 : 0;
                }
                if (!this._stageTextHasFocus) 
                {
                    this.stageText.visible = false;
                }
            }
            else 
            {
                this.invalidate(INVALIDATION_FLAG_SIZE);
            }
            return;
        }

        protected function refreshSnapshot():void
        {
            var starling:starling.core.Starling;
            var viewPort:flash.geom.Rectangle;
            var nativeScaleFactor:Number;
            var newTexture:starling.textures.Texture;
            var matrix:flash.geom.Matrix;
            var globalScaleX:Number;
            var globalScaleY:Number;
            var bitmapData:flash.display.BitmapData;
            var scaleFactor:Number;
            var existingTexture:starling.textures.Texture;

            var loc1:*;
            viewPort = null;
            newTexture = null;
            bitmapData = null;
            scaleFactor = NaN;
            existingTexture = null;
            starling = this.stage === null ? starling.core.Starling.current : this.stage.starling;
            if (!(this.stage === null) && this.stageText.stage === null) 
            {
                this.stageText.stage = starling.nativeStage;
            }
            if (this.stageText.stage === null) 
            {
                this.invalidate(INVALIDATION_FLAG_DATA);
                return;
            }
            viewPort = this.stageText.viewPort;
            if (viewPort.width == 0 || viewPort.height == 0) 
            {
                return;
            }
            nativeScaleFactor = 1;
            if (starling.supportHighResolutions) 
            {
                nativeScaleFactor = starling.nativeStage.contentsScaleFactor;
            }
            try 
            {
                bitmapData = new flash.display.BitmapData(viewPort.width * nativeScaleFactor, viewPort.height * nativeScaleFactor, true, 16711935);
                this.stageText.drawViewPortToBitmapData(bitmapData);
            }
            catch (error:Error)
            {
                bitmapData.dispose();
                bitmapData = new flash.display.BitmapData(viewPort.width, viewPort.height, true, 16711935);
                this.stageText.drawViewPortToBitmapData(bitmapData);
            }
            if (!this.textSnapshot || this._needsNewTexture) 
            {
                scaleFactor = starling.contentScaleFactor;
                newTexture = starling.textures.Texture.empty(bitmapData.width / scaleFactor, bitmapData.height / scaleFactor, true, false, false, scaleFactor);
                newTexture.root.uploadBitmapData(bitmapData);
                newTexture.root.onRestore = this.texture_onRestore;
            }
            if (this.textSnapshot) 
            {
                if (this._needsNewTexture) 
                {
                    this.textSnapshot.texture.dispose();
                    this.textSnapshot.texture = newTexture;
                    this.textSnapshot.readjustSize();
                }
                else 
                {
                    existingTexture = this.textSnapshot.texture;
                    existingTexture.root.uploadBitmapData(bitmapData);
                    this.textSnapshot.setRequiresRedraw();
                }
            }
            else 
            {
                this.textSnapshot = new starling.display.Image(newTexture);
                this.textSnapshot.pixelSnapping = true;
                this.addChild(this.textSnapshot);
            }
            matrix = starling.utils.Pool.getMatrix();
            this.getTransformationMatrix(this.stage, matrix);
            globalScaleX = feathers.utils.geom.matrixToScaleX(matrix);
            globalScaleY = feathers.utils.geom.matrixToScaleY(matrix);
            starling.utils.Pool.putMatrix(matrix);
            if (this._updateSnapshotOnScaleChange) 
            {
                this.textSnapshot.scaleX = 1 / globalScaleX;
                this.textSnapshot.scaleY = 1 / globalScaleY;
                this._lastGlobalScaleX = globalScaleX;
                this._lastGlobalScaleY = globalScaleY;
            }
            else 
            {
                this.textSnapshot.scaleX = 1;
                this.textSnapshot.scaleY = 1;
            }
            if (nativeScaleFactor > 1 && bitmapData.width == viewPort.width) 
            {
                this.textSnapshot.scaleX = this.textSnapshot.scaleX * nativeScaleFactor;
                this.textSnapshot.scaleY = this.textSnapshot.scaleY * nativeScaleFactor;
            }
            bitmapData.dispose();
            this._needsNewTexture = false;
            return;
        }

        protected function refreshViewPortAndFontSize():void
        {
            var loc15:*=NaN;
            var loc16:*=NaN;
            var loc17:*=NaN;
            var loc18:*=null;
            var loc19:*=null;
            var loc20:*=null;
            var loc1:*=starling.utils.Pool.getMatrix();
            var loc2:*=starling.utils.Pool.getPoint();
            var loc3:*=0;
            var loc4:*=0;
            if (this._stageTextIsTextField) 
            {
                loc3 = 2;
                loc4 = 4;
            }
            this.getTransformationMatrix(this.stage, loc1);
            if (this._stageTextHasFocus || this._updateSnapshotOnScaleChange) 
            {
                loc15 = feathers.utils.geom.matrixToScaleX(loc1);
                loc16 = feathers.utils.geom.matrixToScaleY(loc1);
                loc17 = loc15;
                if (loc16 < loc17) 
                {
                    loc17 = loc16;
                }
            }
            else 
            {
                loc15 = 1;
                loc16 = 1;
                loc17 = 1;
            }
            var loc5:*=this.getVerticalAlignmentOffsetY();
            if (this.is3D) 
            {
                loc18 = starling.utils.Pool.getMatrix3D();
                loc19 = starling.utils.Pool.getPoint3D();
                this.getTransformationMatrix3D(this.stage, loc18);
                starling.utils.MatrixUtil.transformCoords3D(loc18, -loc3, -loc3 + loc5, 0, loc19);
                loc2.setTo(loc19.x, loc19.y);
                starling.utils.Pool.putPoint3D(loc19);
                starling.utils.Pool.putMatrix3D(loc18);
            }
            else 
            {
                starling.utils.MatrixUtil.transformCoords(loc1, -loc3, -loc3 + loc5, loc2);
            }
            var loc6:*=this.stage === null ? starling.core.Starling.current : this.stage.starling;
            var loc7:*=1;
            if (loc6.supportHighResolutions) 
            {
                loc7 = loc6.nativeStage.contentsScaleFactor;
            }
            var loc8:*=loc6.contentScaleFactor / loc7;
            var loc9:*=loc6.viewPort;
            var loc10:*=this.stageText.viewPort;
            if (!loc10) 
            {
                loc10 = new flash.geom.Rectangle();
            }
            loc10.x = Math.round(loc9.x + loc2.x * loc8);
            loc10.y = Math.round(loc9.y + loc2.y * loc8);
            var loc11:*=Math.round((this.actualWidth + loc4) * loc8 * loc15);
            if (loc11 < 1 || !(loc11 === loc11)) 
            {
                loc11 = 1;
            }
            var loc12:*=Math.round((this.actualHeight + loc4) * loc8 * loc16);
            if (loc12 < 1 || !(loc12 === loc12)) 
            {
                loc12 = 1;
            }
            loc10.width = loc11;
            loc10.height = loc12;
            this.stageText.viewPort = loc10;
            var loc13:*=12;
            if (this._fontSize > 0) 
            {
                loc13 = this._fontSize;
            }
            else if (this._fontStyles !== null) 
            {
                loc20 = this._fontStyles.getTextFormatForTarget(this);
                if (loc20 !== null) 
                {
                    loc13 = loc20.size;
                }
            }
            var loc14:*=loc13 * loc8 * loc17;
            if (this.stageText.fontSize != loc14) 
            {
                this.stageText.fontSize = loc14;
            }
            starling.utils.Pool.putPoint(loc2);
            starling.utils.Pool.putMatrix(loc1);
            return;
        }

        protected function refreshMeasureTextFieldDimensions():void
        {
            this._measureTextField.width = this.actualWidth + 4;
            this._measureTextField.height = this.actualHeight;
            return;
        }

        protected function positionSnapshot():void
        {
            var loc1:*=starling.utils.Pool.getMatrix();
            this.getTransformationMatrix(this.stage, loc1);
            var loc2:*=0;
            if (this._stageTextIsTextField) 
            {
                loc2 = 2;
            }
            this.textSnapshot.x = Math.round(loc1.tx) - loc1.tx - loc2;
            this.textSnapshot.y = Math.round(loc1.ty) - loc1.ty - loc2 + this.getVerticalAlignmentOffsetY();
            starling.utils.Pool.putMatrix(loc1);
            return;
        }

        public function get selectionBeginIndex():int
        {
            if (this._pendingSelectionBeginIndex >= 0) 
            {
                return this._pendingSelectionBeginIndex;
            }
            if (this.stageText) 
            {
                return this.stageText.selectionAnchorIndex;
            }
            return 0;
        }

        protected function disposeStageText():void
        {
            if (!this.stageText) 
            {
                return;
            }
            this.stageText.removeEventListener(flash.events.Event.CHANGE, this.stageText_changeHandler);
            this.stageText.removeEventListener(flash.events.KeyboardEvent.KEY_DOWN, this.stageText_keyDownHandler);
            this.stageText.removeEventListener(flash.events.KeyboardEvent.KEY_UP, this.stageText_keyUpHandler);
            this.stageText.removeEventListener(flash.events.FocusEvent.FOCUS_IN, this.stageText_focusInHandler);
            this.stageText.removeEventListener(flash.events.FocusEvent.FOCUS_OUT, this.stageText_focusOutHandler);
            this.stageText.removeEventListener(flash.events.Event.COMPLETE, this.stageText_completeHandler);
            this.stageText.removeEventListener(flash.events.SoftKeyboardEvent.SOFT_KEYBOARD_ACTIVATE, this.stageText_softKeyboardActivateHandler);
            this.stageText.removeEventListener(flash.events.SoftKeyboardEvent.SOFT_KEYBOARD_DEACTIVATE, this.stageText_softKeyboardDeactivateHandler);
            this.stageText.stage = null;
            this.stageText.dispose();
            this.stageText = null;
            return;
        }

        public function get selectionEndIndex():int
        {
            if (this._pendingSelectionEndIndex >= 0) 
            {
                return this._pendingSelectionEndIndex;
            }
            if (this.stageText) 
            {
                return this.stageText.selectionActiveIndex;
            }
            return 0;
        }

        protected function createStageText():void
        {
            var StageTextType:Class;
            var initOptions:Object;
            var StageTextInitOptionsType:Class;

            var loc1:*;
            StageTextType = null;
            initOptions = null;
            StageTextInitOptionsType = null;
            this._stageTextIsComplete = false;
            try 
            {
                StageTextType = Class(flash.utils.getDefinitionByName("flash.text.StageText"));
                StageTextInitOptionsType = Class(flash.utils.getDefinitionByName("flash.text.StageTextInitOptions"));
                initOptions = new StageTextInitOptionsType(this._multiline);
            }
            catch (error:Error)
            {
                StageTextType = feathers.text.StageTextField;
                initOptions = {"multiline":this._multiline};
            }
            this.stageText = new StageTextType(initOptions);
            this.stageText.visible = false;
            this.stageText.addEventListener(flash.events.Event.CHANGE, this.stageText_changeHandler);
            this.stageText.addEventListener(flash.events.KeyboardEvent.KEY_DOWN, this.stageText_keyDownHandler);
            this.stageText.addEventListener(flash.events.KeyboardEvent.KEY_UP, this.stageText_keyUpHandler);
            this.stageText.addEventListener(flash.events.FocusEvent.FOCUS_IN, this.stageText_focusInHandler);
            this.stageText.addEventListener(flash.events.FocusEvent.FOCUS_OUT, this.stageText_focusOutHandler);
            this.stageText.addEventListener(flash.events.SoftKeyboardEvent.SOFT_KEYBOARD_ACTIVATE, this.stageText_softKeyboardActivateHandler);
            this.stageText.addEventListener(flash.events.SoftKeyboardEvent.SOFT_KEYBOARD_DEACTIVATE, this.stageText_softKeyboardDeactivateHandler);
            this.stageText.addEventListener(flash.events.Event.COMPLETE, this.stageText_completeHandler);
            this.stageText.addEventListener(flash.events.FocusEvent.MOUSE_FOCUS_CHANGE, this.stageText_mouseFocusChangeHandler);
            this.invalidate();
            return;
        }

        public function get baseline():Number
        {
            if (!this._measureTextField) 
            {
                return 0;
            }
            return this._measureTextField.getLineMetrics(0).ascent;
        }

        protected function getVerticalAlignment():String
        {
            var loc2:*=null;
            var loc1:*=null;
            if (this._fontStyles !== null) 
            {
                loc2 = this._fontStyles.getTextFormatForTarget(this);
                if (loc2 !== null) 
                {
                    loc1 = loc2.verticalAlign;
                }
            }
            if (loc1 === null) 
            {
                loc1 = starling.utils.Align.TOP;
            }
            return loc1;
        }

        public function get autoCapitalize():String
        {
            return this._autoCapitalize;
        }

        public function set autoCapitalize(arg1:String):void
        {
            if (this._autoCapitalize == arg1) 
            {
                return;
            }
            this._autoCapitalize = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function getVerticalAlignmentOffsetY():Number
        {
            var loc1:*=this.getVerticalAlignment();
            if (this._measureTextField.textHeight > this.actualHeight) 
            {
                return 0;
            }
            if (loc1 === starling.utils.Align.BOTTOM) 
            {
                return this.actualHeight - this._measureTextField.textHeight;
            }
            if (loc1 === starling.utils.Align.CENTER) 
            {
                return (this.actualHeight - this._measureTextField.textHeight) / 2;
            }
            return 0;
        }

        public function get autoCorrect():Boolean
        {
            return this._autoCorrect;
        }

        public function set autoCorrect(arg1:Boolean):void
        {
            if (this._autoCorrect == arg1) 
            {
                return;
            }
            this._autoCorrect = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function dispatchKeyFocusChangeEvent(arg1:flash.events.KeyboardEvent):void
        {
            var loc1:*=feathers.utils.display.stageToStarling(this.stage);
            var loc2:*=new flash.events.FocusEvent(flash.events.FocusEvent.KEY_FOCUS_CHANGE, true, false, null, arg1.shiftKey, arg1.keyCode);
            loc1.nativeStage.dispatchEvent(loc2);
            return;
        }

        public function get color():uint
        {
            return this._color;
        }

        public function set color(arg1:uint):void
        {
            if (this._color == arg1) 
            {
                return;
            }
            this._color = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function textEditor_removedFromStageHandler(arg1:starling.events.Event):void
        {
            this.stageText.stage = null;
            return;
        }

        public function get disabledColor():uint
        {
            return this._disabledColor;
        }

        public function set disabledColor(arg1:uint):void
        {
            if (this._disabledColor == arg1) 
            {
                return;
            }
            this._disabledColor = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function stageText_changeHandler(arg1:flash.events.Event):void
        {
            if (this._ignoreStageTextChanges) 
            {
                return;
            }
            this.text = this.stageText.text;
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

        protected function stageText_completeHandler(arg1:flash.events.Event):void
        {
            this.stageText.removeEventListener(flash.events.Event.COMPLETE, this.stageText_completeHandler);
            this.invalidate();
            this._stageTextIsComplete = true;
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

        protected function stageText_focusInHandler(arg1:flash.events.FocusEvent):void
        {
            this._stageTextHasFocus = true;
            if (!this._isEditable) 
            {
                this.stageText.editable = false;
            }
            this.addEventListener(starling.events.Event.ENTER_FRAME, this.hasFocus_enterFrameHandler);
            if (this.textSnapshot) 
            {
                this.textSnapshot.visible = false;
            }
            this.invalidate(INVALIDATION_FLAG_SKIN);
            this.dispatchEventWith(feathers.events.FeathersEventType.FOCUS_IN);
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
            return true;
        }

        protected function stageText_focusOutHandler(arg1:flash.events.FocusEvent):void
        {
            this._stageTextHasFocus = false;
            this.stageText.selectRange(1, 1);
            this.invalidate(INVALIDATION_FLAG_DATA);
            this.invalidate(INVALIDATION_FLAG_SKIN);
            this.dispatchEventWith(feathers.events.FeathersEventType.FOCUS_OUT);
            return;
        }

        public function get fontFamily():String
        {
            return this._fontFamily;
        }

        public function set fontFamily(arg1:String):void
        {
            if (this._fontFamily == arg1) 
            {
                return;
            }
            this._fontFamily = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function hasFocus_enterFrameHandler(arg1:starling.events.Event):void
        {
            var loc1:*=null;
            if (this._stageTextHasFocus) 
            {
                loc1 = this;
                do 
                {
                    if (!loc1.visible) 
                    {
                        this.stageText.stage.focus = null;
                        break;
                    }
                    loc1 = loc1.parent;
                }
                while (loc1);
            }
            else 
            {
                this.removeEventListener(starling.events.Event.ENTER_FRAME, this.hasFocus_enterFrameHandler);
            }
            return;
        }

        public function get fontPosture():String
        {
            return this._fontPosture;
        }

        public function set fontPosture(arg1:String):void
        {
            if (this._fontPosture == arg1) 
            {
                return;
            }
            this._fontPosture = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function stageText_mouseFocusChangeHandler(arg1:flash.events.FocusEvent):void
        {
            if (!this._maintainTouchFocus) 
            {
                return;
            }
            arg1.preventDefault();
            return;
        }

        public function get fontSize():int
        {
            return this._fontSize;
        }

        public function set fontSize(arg1:int):void
        {
            if (this._fontSize == arg1) 
            {
                return;
            }
            this._fontSize = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function stageText_keyDownHandler(arg1:flash.events.KeyboardEvent):void
        {
            var loc1:*=null;
            if (!this._multiline && (arg1.keyCode == flash.ui.Keyboard.ENTER || arg1.keyCode == flash.ui.Keyboard.NEXT)) 
            {
                arg1.preventDefault();
                this.dispatchEventWith(feathers.events.FeathersEventType.ENTER);
            }
            else if (arg1.keyCode == flash.ui.Keyboard.BACK) 
            {
                arg1.preventDefault();
                loc1 = this.stage === null ? starling.core.Starling.current : this.stage.starling;
                loc1.nativeStage.focus = loc1.nativeStage;
            }
            if (arg1.keyCode === flash.ui.Keyboard.TAB && feathers.core.FocusManager.isEnabledForStage(this.stage)) 
            {
                arg1.preventDefault();
                this.dispatchKeyFocusChangeEvent(arg1);
            }
            return;
        }

        public function get fontWeight():String
        {
            return this._fontWeight;
        }

        public function set fontWeight(arg1:String):void
        {
            if (this._fontWeight == arg1) 
            {
                return;
            }
            this._fontWeight = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function stageText_keyUpHandler(arg1:flash.events.KeyboardEvent):void
        {
            if (!this._multiline && (arg1.keyCode == flash.ui.Keyboard.ENTER || arg1.keyCode == flash.ui.Keyboard.NEXT)) 
            {
                arg1.preventDefault();
            }
            if (arg1.keyCode === flash.ui.Keyboard.TAB && feathers.core.FocusManager.isEnabledForStage(this.stage)) 
            {
                arg1.preventDefault();
            }
            return;
        }

        public function get locale():String
        {
            return this._locale;
        }

        public function set locale(arg1:String):void
        {
            if (this._locale == arg1) 
            {
                return;
            }
            this._locale = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function stageText_softKeyboardActivateHandler(arg1:flash.events.SoftKeyboardEvent):void
        {
            this.dispatchEventWith(feathers.events.FeathersEventType.SOFT_KEYBOARD_ACTIVATE, true);
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

        protected function stageText_softKeyboardDeactivateHandler(arg1:flash.events.SoftKeyboardEvent):void
        {
            this.dispatchEventWith(feathers.events.FeathersEventType.SOFT_KEYBOARD_DEACTIVATE, true);
            return;
        }

        public function get multiline():Boolean
        {
            return this._multiline;
        }

        public function set multiline(arg1:Boolean):void
        {
            if (this._multiline == arg1) 
            {
                return;
            }
            this._multiline = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
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

        public function get returnKeyLabel():String
        {
            return this._returnKeyLabel;
        }

        public function set returnKeyLabel(arg1:String):void
        {
            if (this._returnKeyLabel == arg1) 
            {
                return;
            }
            this._returnKeyLabel = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get softKeyboardType():String
        {
            return this._softKeyboardType;
        }

        public function set softKeyboardType(arg1:String):void
        {
            if (this._softKeyboardType == arg1) 
            {
                return;
            }
            this._softKeyboardType = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get textAlign():String
        {
            return this._textAlign;
        }

        public function set textAlign(arg1:String):void
        {
            if (this._textAlign == arg1) 
            {
                return;
            }
            this._textAlign = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get maintainTouchFocus():Boolean
        {
            return this._maintainTouchFocus;
        }

        public function set maintainTouchFocus(arg1:Boolean):void
        {
            this._maintainTouchFocus = arg1;
            return;
        }

        public function get updateSnapshotOnScaleChange():Boolean
        {
            return this._updateSnapshotOnScaleChange;
        }

        public function set updateSnapshotOnScaleChange(arg1:Boolean):void
        {
            if (this._updateSnapshotOnScaleChange == arg1) 
            {
                return;
            }
            this._updateSnapshotOnScaleChange = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        public override function dispose():void
        {
            var loc1:*=null;
            if (this._measureTextField !== null) 
            {
                loc1 = this.stage === null ? starling.core.Starling.current : this.stage.starling;
                loc1.nativeStage.removeChild(this._measureTextField);
                this._measureTextField = null;
            }
            if (this.stageText) 
            {
                this.disposeStageText();
            }
            if (this.textSnapshot) 
            {
                this.textSnapshot.texture.dispose();
                this.removeChild(this.textSnapshot, true);
                this.textSnapshot = null;
            }
            super.dispose();
            return;
        }

        public override function render(arg1:starling.rendering.Painter):void
        {
            var loc1:*=null;
            if (this._stageTextHasFocus) 
            {
                arg1.excludeFromCache(this);
            }
            if (this.textSnapshot && this._updateSnapshotOnScaleChange) 
            {
                loc1 = starling.utils.Pool.getMatrix();
                this.getTransformationMatrix(this.stage, loc1);
                if (!(feathers.utils.geom.matrixToScaleX(loc1) === this._lastGlobalScaleX) || !(feathers.utils.geom.matrixToScaleY(loc1) === this._lastGlobalScaleY)) 
                {
                    this.invalidate(INVALIDATION_FLAG_SIZE);
                    this.validate();
                }
                starling.utils.Pool.putMatrix(loc1);
            }
            if (this.stageText && this.stageText.visible) 
            {
                this.refreshViewPortAndFontSize();
            }
            if (this.textSnapshot) 
            {
                this.positionSnapshot();
            }
            super.render(arg1);
            return;
        }

        public function setFocus(arg1:flash.geom.Point=null):void
        {
            var position:flash.geom.Point=null;
            var starling:starling.core.Starling;
            var positionX:Number;
            var positionY:Number;
            var lineIndex:int;
            var bounds:flash.geom.Rectangle;
            var boundsX:Number;

            var loc1:*;
            starling = null;
            positionX = NaN;
            positionY = NaN;
            lineIndex = 0;
            bounds = null;
            boundsX = NaN;
            position = arg1;
            if (!this._isEditable && starling.utils.SystemUtil.platform === "AND") 
            {
                return;
            }
            if (!this._isEditable && !this._isSelectable) 
            {
                return;
            }
            if (!(this.stage === null) && this.stageText.stage === null) 
            {
                starling = this.stage === null ? starling.core.Starling.current : this.stage.starling;
                this.stageText.stage = starling.nativeStage;
            }
            if (this.stageText && this._stageTextIsComplete) 
            {
                if (position) 
                {
                    positionX = position.x + 2;
                    positionY = position.y + 2;
                    if (positionX < 0) 
                    {
                        var loc2:*;
                        this._pendingSelectionEndIndex = loc2 = 0;
                        this._pendingSelectionBeginIndex = loc2;
                    }
                    else 
                    {
                        this._pendingSelectionBeginIndex = this._measureTextField.getCharIndexAtPoint(positionX, positionY);
                        if (this._pendingSelectionBeginIndex < 0) 
                        {
                            if (this._multiline) 
                            {
                                lineIndex = int(positionY / this._measureTextField.getLineMetrics(0).height);
                                try 
                                {
                                    this._pendingSelectionBeginIndex = this._measureTextField.getLineOffset(lineIndex) + this._measureTextField.getLineLength(lineIndex);
                                    if (this._pendingSelectionBeginIndex != this._text.length) 
                                    {
                                        var loc3:*=((loc2 = this)._pendingSelectionBeginIndex - 1);
                                        loc2._pendingSelectionBeginIndex = loc3;
                                    }
                                }
                                catch (error:Error)
                                {
                                    this._pendingSelectionBeginIndex = this._text.length;
                                }
                            }
                            else 
                            {
                                this._pendingSelectionBeginIndex = this._measureTextField.getCharIndexAtPoint(positionX, this._measureTextField.getLineMetrics(0).ascent / 2);
                                if (this._pendingSelectionBeginIndex < 0) 
                                {
                                    this._pendingSelectionBeginIndex = this._text.length;
                                }
                            }
                        }
                        else 
                        {
                            bounds = this._measureTextField.getCharBoundaries(this._pendingSelectionBeginIndex);
                            boundsX = bounds.x;
                            if (bounds && boundsX + bounds.width - positionX < positionX - boundsX) 
                            {
                                loc3 = ((loc2 = this)._pendingSelectionBeginIndex + 1);
                                loc2._pendingSelectionBeginIndex = loc3;
                            }
                        }
                        this._pendingSelectionEndIndex = this._pendingSelectionBeginIndex;
                    }
                }
                else 
                {
                    this._pendingSelectionEndIndex = loc2 = -1;
                    this._pendingSelectionBeginIndex = loc2;
                }
                this.stageText.visible = true;
                if (!this._isEditable) 
                {
                    this.stageText.editable = true;
                }
                this.stageText.assignFocus();
            }
            else 
            {
                this._isWaitingToSetFocus = true;
            }
            return;
        }

        public function clearFocus():void
        {
            if (!this._stageTextHasFocus) 
            {
                return;
            }
            var loc1:*=this.stage === null ? starling.core.Starling.current : this.stage.starling;
            loc1.nativeStage.focus = null;
            return;
        }

        public function selectRange(arg1:int, arg2:int):void
        {
            if (this._stageTextIsComplete && this.stageText) 
            {
                this._pendingSelectionBeginIndex = -1;
                this._pendingSelectionEndIndex = -1;
                this.stageText.selectRange(arg1, arg2);
            }
            else 
            {
                this._pendingSelectionBeginIndex = arg1;
                this._pendingSelectionEndIndex = arg2;
            }
            return;
        }

        public function measureText(arg1:flash.geom.Point=null):flash.geom.Point
        {
            if (!arg1) 
            {
                arg1 = new flash.geom.Point();
            }
            var loc1:*=!(this._explicitWidth === this._explicitWidth);
            var loc2:*=!(this._explicitHeight === this._explicitHeight);
            if (!loc1 && !loc2) 
            {
                arg1.x = this._explicitWidth;
                arg1.y = this._explicitHeight;
                return arg1;
            }
            if (!this._isInitialized) 
            {
                this.initializeNow();
            }
            var loc3:*=this.isInvalid(INVALIDATION_FLAG_STYLES);
            var loc4:*=this.isInvalid(INVALIDATION_FLAG_DATA);
            if (loc3 || loc4) 
            {
                this.refreshMeasureProperties();
            }
            arg1 = this.measure(arg1);
            return arg1;
        }

        protected override function initialize():void
        {
            var loc1:*=this.stage === null ? starling.core.Starling.current : this.stage.starling;
            if (!(this._measureTextField === null) && this._measureTextField.parent === null) 
            {
                loc1.nativeStage.addChild(this._measureTextField);
            }
            else if (!this._measureTextField) 
            {
                this._measureTextField = new flash.text.TextField();
                this._measureTextField.visible = false;
                var loc2:*;
                this._measureTextField.mouseWheelEnabled = loc2 = false;
                this._measureTextField.mouseEnabled = loc2;
                this._measureTextField.autoSize = flash.text.TextFieldAutoSize.LEFT;
                this._measureTextField.multiline = false;
                this._measureTextField.wordWrap = false;
                this._measureTextField.embedFonts = false;
                this._measureTextField.defaultTextFormat = new flash.text.TextFormat(null, 11, 0, false, false, false);
                loc1.nativeStage.addChild(this._measureTextField);
            }
            this.createStageText();
            return;
        }

        protected override function draw():void
        {
            var loc1:*=this.isInvalid(INVALIDATION_FLAG_SIZE);
            this.commit();
            loc1 = this.autoSizeIfNeeded() || loc1;
            this.layout(loc1);
            return;
        }

        protected function commit():void
        {
            var loc1:*=this.isInvalid(INVALIDATION_FLAG_STATE);
            var loc2:*=this.isInvalid(INVALIDATION_FLAG_STYLES);
            var loc3:*=this.isInvalid(INVALIDATION_FLAG_DATA);
            if (loc2 || loc3) 
            {
                this.refreshMeasureProperties();
            }
            var loc4:*=this._ignoreStageTextChanges;
            this._ignoreStageTextChanges = true;
            if (loc1 || loc2) 
            {
                this.refreshStageTextProperties();
            }
            if (loc3) 
            {
                if (this.stageText.text != this._text) 
                {
                    if (this._pendingSelectionBeginIndex < 0) 
                    {
                        this._pendingSelectionBeginIndex = this.stageText.selectionActiveIndex;
                        this._pendingSelectionEndIndex = this.stageText.selectionAnchorIndex;
                    }
                    this.stageText.text = this._text;
                }
            }
            this._ignoreStageTextChanges = loc4;
            if (loc2 || loc1) 
            {
                this.stageText.editable = this._isEditable && this._isEnabled;
            }
            return;
        }

        protected function measure(arg1:flash.geom.Point=null):flash.geom.Point
        {
            if (!arg1) 
            {
                arg1 = new flash.geom.Point();
            }
            var loc1:*=!(this._explicitWidth === this._explicitWidth);
            var loc2:*=!(this._explicitHeight === this._explicitHeight);
            this._measureTextField.autoSize = flash.text.TextFieldAutoSize.LEFT;
            var loc3:*=this._explicitWidth;
            if (loc1) 
            {
                loc3 = this._measureTextField.textWidth;
                if (loc3 < this._explicitMinWidth) 
                {
                    loc3 = this._explicitMinWidth;
                }
                else if (loc3 > this._explicitMaxWidth) 
                {
                    loc3 = this._explicitMaxWidth;
                }
            }
            this._measureTextField.width = loc3 + 4;
            var loc4:*=this._explicitHeight;
            if (loc2) 
            {
                if (this._stageTextIsTextField) 
                {
                    loc4 = this._measureTextField.textHeight;
                }
                else 
                {
                    loc4 = this._measureTextField.height;
                }
                if (loc4 < this._explicitMinHeight) 
                {
                    loc4 = this._explicitMinHeight;
                }
                else if (loc4 > this._explicitMaxHeight) 
                {
                    loc4 = this._explicitMaxHeight;
                }
            }
            this._measureTextField.autoSize = flash.text.TextFieldAutoSize.NONE;
            this._measureTextField.width = this.actualWidth + 4;
            this._measureTextField.height = this.actualHeight;
            arg1.x = loc3;
            arg1.y = loc4;
            return arg1;
        }

        protected function layout(arg1:Boolean):void
        {
            var loc5:*=null;
            var loc6:*=null;
            var loc7:*=null;
            var loc8:*=false;
            var loc1:*=this.isInvalid(INVALIDATION_FLAG_STATE);
            var loc2:*=this.isInvalid(INVALIDATION_FLAG_STYLES);
            var loc3:*=this.isInvalid(INVALIDATION_FLAG_DATA);
            var loc4:*=this.isInvalid(INVALIDATION_FLAG_SKIN);
            if (arg1 || loc2 || loc4 || loc1) 
            {
                loc5 = this.stage === null ? starling.core.Starling.current : this.stage.starling;
                this.refreshViewPortAndFontSize();
                this.refreshMeasureTextFieldDimensions();
                loc6 = this.stageText.viewPort;
                loc7 = this.textSnapshot ? this.textSnapshot.texture.root : null;
                this._needsNewTexture = this._needsNewTexture || !this.textSnapshot || !(loc7 === null) && (!(loc7.scale === loc5.contentScaleFactor) || !(loc6.width === loc7.nativeWidth) || !(loc6.height === loc7.nativeHeight));
            }
            if (!this._stageTextHasFocus && (loc1 || loc2 || loc3 || arg1 || this._needsNewTexture)) 
            {
                loc8 = this._text.length > 0;
                if (loc8) 
                {
                    this.refreshSnapshot();
                }
                if (this.textSnapshot) 
                {
                    this.textSnapshot.visible = !this._stageTextHasFocus;
                    this.textSnapshot.alpha = loc8 ? 1 : 0;
                }
                this.stageText.visible = false;
            }
            this.doPendingActions();
            return;
        }

        protected var stageText:Object;

        protected var textSnapshot:starling.display.Image;

        protected var _needsNewTexture:Boolean=false;

        protected var _ignoreStageTextChanges:Boolean=false;

        protected var _measureTextField:flash.text.TextField;

        protected var _stageTextIsTextField:Boolean=false;

        protected var _stageTextHasFocus:Boolean=false;

        protected var _isWaitingToSetFocus:Boolean=false;

        protected var _pendingSelectionBeginIndex:int=-1;

        protected var _pendingSelectionEndIndex:int=-1;

        protected var _stageTextIsComplete:Boolean=false;

        protected var _autoCapitalize:String="none";

        protected var _autoCorrect:Boolean=false;

        protected var _color:uint=4294967295;

        protected var _disabledColor:uint=4294967295;

        protected var _displayAsPassword:Boolean=false;

        protected var _isEditable:Boolean=true;

        protected var _isSelectable:Boolean=true;

        protected var _fontFamily:String=null;

        protected var _fontPosture:String;

        protected var _fontSize:int=0;

        protected var _fontWeight:String=null;

        protected var _locale:String="en";

        protected var _maxChars:int=0;

        protected var _multiline:Boolean=false;

        protected var _lastGlobalScaleY:Number=0;

        protected var _updateSnapshotOnScaleChange:Boolean=false;

        protected var _softKeyboardType:String="default";

        protected var _restrict:String;

        protected var _maintainTouchFocus:Boolean=false;

        protected var _returnKeyLabel:String="default";

        protected var _textAlign:String;

        protected var _lastGlobalScaleX:Number=0;

        public static var globalStyleProvider:feathers.skins.IStyleProvider;
    }
}


