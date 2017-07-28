//class TextFieldTextEditor
package feathers.controls.text 
{
    import feathers.core.*;
    import feathers.events.*;
    import feathers.skins.*;
    import feathers.utils.geom.*;
    import flash.display.*;
    import flash.display3D.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import flash.ui.*;
    import starling.core.*;
    import starling.display.*;
    import starling.events.*;
    import starling.rendering.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    
    public class TextFieldTextEditor extends feathers.core.BaseTextEditor implements feathers.core.ITextEditor, feathers.core.INativeFocusOwner
    {
        public function TextFieldTextEditor()
        {
            this._textFieldSnapshotClipRect = new flash.geom.Rectangle();
            super();
            this.isQuickHitAreaEnabled = true;
            this.addEventListener(starling.events.Event.ADDED_TO_STAGE, this.textEditor_addedToStageHandler);
            this.addEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.textEditor_removedFromStageHandler);
            return;
        }

        protected override function get defaultStyleProvider():feathers.skins.IStyleProvider
        {
            return globalStyleProvider;
        }

        protected override function draw():void
        {
            var loc1:*=this.isInvalid(INVALIDATION_FLAG_SIZE);
            this.commit();
            loc1 = this.autoSizeIfNeeded() || loc1;
            this.layout(loc1);
            return;
        }

        public function get nativeFocus():Object
        {
            return this.textField;
        }

        protected function commit():void
        {
            var loc1:*=this.isInvalid(INVALIDATION_FLAG_STYLES);
            var loc2:*=this.isInvalid(INVALIDATION_FLAG_DATA);
            var loc3:*=this.isInvalid(INVALIDATION_FLAG_STATE);
            if (loc2 || loc1 || loc3) 
            {
                this.refreshTextFormat();
                this.commitStylesAndData(this.textField);
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
            var loc5:*=starling.utils.Pool.getPoint();
            this.measure(loc5);
            var loc6:*=this.saveMeasurements(loc5.x, loc5.y, loc5.x, loc5.y);
            starling.utils.Pool.putPoint(loc5);
            return loc6;
        }

        protected function measure(arg1:flash.geom.Point=null):flash.geom.Point
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
            this.commitStylesAndData(this.measureTextField);
            var loc3:*=4;
            if (this._useGutter) 
            {
                loc3 = 0;
            }
            var loc4:*=this._explicitWidth;
            if (loc1) 
            {
                this.measureTextField.wordWrap = false;
                loc4 = this.measureTextField.width - loc3;
                if (loc4 < this._explicitMinWidth) 
                {
                    loc4 = this._explicitMinWidth;
                }
                else if (loc4 > this._explicitMaxWidth) 
                {
                    loc4 = this._explicitMaxWidth;
                }
            }
            var loc5:*=this._explicitHeight;
            if (loc2) 
            {
                this.measureTextField.wordWrap = this._wordWrap;
                this.measureTextField.width = loc4 + loc3;
                loc5 = this.measureTextField.height - loc3;
                if (this._useGutter) 
                {
                    loc5 = loc5 + 4;
                }
                if (loc5 < this._explicitMinHeight) 
                {
                    loc5 = this._explicitMinHeight;
                }
                else if (loc5 > this._explicitMaxHeight) 
                {
                    loc5 = this._explicitMaxHeight;
                }
            }
            arg1.x = loc4;
            arg1.y = loc5;
            return arg1;
        }

        protected function commitStylesAndData(arg1:flash.text.TextField):void
        {
            var loc1:*=false;
            arg1.antiAliasType = this._antiAliasType;
            arg1.background = this._background;
            arg1.backgroundColor = this._backgroundColor;
            arg1.border = this._border;
            arg1.borderColor = this._borderColor;
            arg1.gridFitType = this._gridFitType;
            arg1.sharpness = this._sharpness;
            arg1.thickness = this._thickness;
            arg1.maxChars = this._maxChars;
            arg1.restrict = this._restrict;
            arg1.alwaysShowSelection = this._alwaysShowSelection;
            arg1.displayAsPassword = this._displayAsPassword;
            arg1.wordWrap = this._wordWrap;
            arg1.multiline = this._multiline;
            if (!this._embedFonts && this._currentTextFormat === this._fontStylesTextFormat) 
            {
                this.textField.embedFonts = starling.utils.SystemUtil.isEmbeddedFont(this._currentTextFormat.font, this._currentTextFormat.bold, this._currentTextFormat.italic, flash.text.FontType.EMBEDDED);
            }
            else 
            {
                this.textField.embedFonts = this._embedFonts;
            }
            arg1.type = this._isEditable ? flash.text.TextFieldType.INPUT : flash.text.TextFieldType.DYNAMIC;
            arg1.selectable = this._isEnabled && (this._isEditable || this._isSelectable);
            if (arg1 === this.textField) 
            {
                loc1 = !(this._previousTextFormat == this._currentTextFormat);
                this._previousTextFormat = this._currentTextFormat;
            }
            arg1.defaultTextFormat = this._currentTextFormat;
            if (this._isHTML) 
            {
                if (loc1 || !(arg1.htmlText == this._text)) 
                {
                    if (arg1 == this.textField && this._pendingSelectionBeginIndex < 0) 
                    {
                        this._pendingSelectionBeginIndex = this.textField.selectionBeginIndex;
                        this._pendingSelectionEndIndex = this.textField.selectionEndIndex;
                    }
                    arg1.htmlText = this._text;
                }
            }
            else if (loc1 || !(arg1.text == this._text)) 
            {
                if (arg1 == this.textField && this._pendingSelectionBeginIndex < 0) 
                {
                    this._pendingSelectionBeginIndex = this.textField.selectionBeginIndex;
                    this._pendingSelectionEndIndex = this.textField.selectionEndIndex;
                }
                arg1.text = this._text;
            }
            return;
        }

        protected function refreshTextFormat():void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (this._stateContext === null) 
            {
                if (!this._isEnabled && !(this._disabledTextFormat === null)) 
                {
                    loc1 = this._disabledTextFormat;
                }
            }
            else 
            {
                if (this._textFormatForState !== null) 
                {
                    loc2 = this._stateContext.currentState;
                    if (loc2 in this._textFormatForState) 
                    {
                        loc1 = flash.text.TextFormat(this._textFormatForState[loc2]);
                    }
                }
                if (loc1 === null && !(this._disabledTextFormat === null) && this._stateContext is feathers.core.IFeathersControl && !feathers.core.IFeathersControl(this._stateContext).isEnabled) 
                {
                    loc1 = this._disabledTextFormat;
                }
            }
            if (loc1 === null) 
            {
                loc1 = this._textFormat;
            }
            if (loc1 === null) 
            {
                loc1 = this.getTextFormatFromFontStyles();
            }
            this._currentTextFormat = loc1;
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

        protected function getVerticalAlignmentOffsetY():Number
        {
            var loc1:*=this.getVerticalAlignment();
            var loc2:*=this.textField.textHeight;
            if (loc2 > this.actualHeight) 
            {
                return 0;
            }
            if (loc1 === starling.utils.Align.BOTTOM) 
            {
                return this.actualHeight - loc2;
            }
            if (loc1 === starling.utils.Align.CENTER) 
            {
                return (this.actualHeight - loc2) / 2;
            }
            return 0;
        }

        protected function layout(arg1:Boolean):void
        {
            var loc1:*=this.isInvalid(INVALIDATION_FLAG_STYLES);
            var loc2:*=this.isInvalid(INVALIDATION_FLAG_DATA);
            var loc3:*=this.isInvalid(INVALIDATION_FLAG_STATE);
            if (arg1) 
            {
                this.refreshSnapshotParameters();
                this.refreshTextFieldSize();
                this.transformTextField();
                this.positionSnapshot();
            }
            this.checkIfNewSnapshotIsNeeded();
            if (!this._textFieldHasFocus && (arg1 || loc1 || loc2 || loc3 || this._needsNewTexture)) 
            {
                if (this._useSnapshotDelayWorkaround) 
                {
                    this.addEventListener(starling.events.Event.ENTER_FRAME, this.refreshSnapshot_enterFrameHandler);
                }
                else 
                {
                    this.refreshSnapshot();
                }
            }
            this.doPendingActions();
            return;
        }

        protected function getSelectionIndexAtPoint(arg1:Number, arg2:Number):int
        {
            return this.textField.getCharIndexAtPoint(arg1, arg2);
        }

        public function get baseline():Number
        {
            if (!this.textField) 
            {
                return 0;
            }
            var loc1:*=0;
            if (this._useGutter) 
            {
                loc1 = 2;
            }
            return loc1 + this.textField.getLineMetrics(0).ascent;
        }

        protected function refreshTextFieldSize():void
        {
            var loc1:*=4;
            if (this._useGutter) 
            {
                loc1 = 0;
            }
            this.textField.width = this.actualWidth + loc1;
            this.textField.height = this.actualHeight + loc1;
            return;
        }

        protected function refreshSnapshotParameters():void
        {
            var loc5:*=null;
            this._textFieldOffsetX = 0;
            this._textFieldOffsetY = 0;
            this._textFieldSnapshotClipRect.x = 0;
            this._textFieldSnapshotClipRect.y = 0;
            var loc1:*=this.stage === null ? starling.core.Starling.current : this.stage.starling;
            var loc2:*=loc1.contentScaleFactor;
            var loc3:*=this.actualWidth * loc2;
            if (this._updateSnapshotOnScaleChange) 
            {
                loc5 = starling.utils.Pool.getMatrix();
                this.getTransformationMatrix(this.stage, loc5);
                loc3 = loc3 * feathers.utils.geom.matrixToScaleX(loc5);
            }
            if (loc3 < 0) 
            {
                loc3 = 0;
            }
            var loc4:*=this.actualHeight * loc2;
            if (this._updateSnapshotOnScaleChange) 
            {
                loc4 = loc4 * feathers.utils.geom.matrixToScaleY(loc5);
                starling.utils.Pool.putMatrix(loc5);
            }
            if (loc4 < 0) 
            {
                loc4 = 0;
            }
            this._textFieldSnapshotClipRect.width = loc3;
            this._textFieldSnapshotClipRect.height = loc4;
            return;
        }

        public function get currentTextFormat():flash.text.TextFormat
        {
            return this._currentTextFormat;
        }

        protected function transformTextField():void
        {
            var loc12:*=null;
            var loc13:*=null;
            var loc1:*=starling.utils.Pool.getMatrix();
            var loc2:*=starling.utils.Pool.getPoint();
            this.getTransformationMatrix(this.stage, loc1);
            var loc3:*=feathers.utils.geom.matrixToScaleX(loc1);
            var loc4:*=feathers.utils.geom.matrixToScaleY(loc1);
            var loc5:*=loc3;
            if (loc4 < loc5) 
            {
                loc5 = loc4;
            }
            var loc6:*=this.stage === null ? starling.core.Starling.current : this.stage.starling;
            var loc7:*=1;
            if (loc6.supportHighResolutions) 
            {
                loc7 = loc6.nativeStage.contentsScaleFactor;
            }
            var loc8:*=loc6.contentScaleFactor / loc7;
            var loc9:*=0;
            if (!this._useGutter) 
            {
                loc9 = 2 * loc5;
            }
            var loc10:*=this.getVerticalAlignmentOffsetY();
            if (this.is3D) 
            {
                loc12 = starling.utils.Pool.getMatrix3D();
                loc13 = starling.utils.Pool.getPoint3D();
                this.getTransformationMatrix3D(this.stage, loc12);
                starling.utils.MatrixUtil.transformCoords3D(loc12, -loc9, -loc9 + loc10, 0, loc13);
                loc2.setTo(loc13.x, loc13.y);
                starling.utils.Pool.putPoint3D(loc13);
                starling.utils.Pool.putMatrix3D(loc12);
            }
            else 
            {
                starling.utils.MatrixUtil.transformCoords(loc1, -loc9, -loc9 + loc10, loc2);
            }
            var loc11:*=loc6.viewPort;
            this.textField.x = Math.round(loc11.x + loc2.x * loc8);
            this.textField.y = Math.round(loc11.y + loc2.y * loc8);
            this.textField.rotation = feathers.utils.geom.matrixToRotation(loc1) * 180 / Math.PI;
            this.textField.scaleX = feathers.utils.geom.matrixToScaleX(loc1) * loc8;
            this.textField.scaleY = feathers.utils.geom.matrixToScaleY(loc1) * loc8;
            starling.utils.Pool.putPoint(loc2);
            starling.utils.Pool.putMatrix(loc1);
            return;
        }

        protected function positionSnapshot():void
        {
            if (!this.textSnapshot) 
            {
                return;
            }
            var loc1:*=starling.utils.Pool.getMatrix();
            this.getTransformationMatrix(this.stage, loc1);
            this.textSnapshot.x = Math.round(loc1.tx) - loc1.tx;
            this.textSnapshot.y = Math.round(loc1.ty) - loc1.ty;
            this.textSnapshot.y = this.textSnapshot.y + this.getVerticalAlignmentOffsetY();
            starling.utils.Pool.putMatrix(loc1);
            return;
        }

        protected function checkIfNewSnapshotIsNeeded():void
        {
            var loc1:*=this.stage === null ? starling.core.Starling.current : this.stage.starling;
            var loc2:*=!(loc1.profile === flash.display3D.Context3DProfile.BASELINE_CONSTRAINED);
            if (loc2) 
            {
                this._snapshotWidth = this._textFieldSnapshotClipRect.width;
                this._snapshotHeight = this._textFieldSnapshotClipRect.height;
            }
            else 
            {
                this._snapshotWidth = starling.utils.MathUtil.getNextPowerOfTwo(this._textFieldSnapshotClipRect.width);
                this._snapshotHeight = starling.utils.MathUtil.getNextPowerOfTwo(this._textFieldSnapshotClipRect.height);
            }
            var loc3:*=this.textSnapshot ? this.textSnapshot.texture.root : null;
            this._needsNewTexture = this._needsNewTexture || !this.textSnapshot || !(loc3 === null) && (!(loc3.scale === loc1.contentScaleFactor) || !(this._snapshotWidth === loc3.nativeWidth) || !(this._snapshotHeight === loc3.nativeHeight));
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
            this._previousTextFormat = null;
            this.invalidate(INVALIDATION_FLAG_STYLES);
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
                loc2 = this._pendingSelectionEndIndex;
                this._pendingSelectionBeginIndex = -1;
                this._pendingSelectionEndIndex = -1;
                this.selectRange(loc1, loc2);
            }
            return;
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

        protected function texture_onRestore():void
        {
            var loc1:*=this.stage === null ? starling.core.Starling.current : this.stage.starling;
            if (this.textSnapshot && this.textSnapshot.texture && !(this.textSnapshot.texture.scale == loc1.contentScaleFactor)) 
            {
                this.invalidate(INVALIDATION_FLAG_SIZE);
            }
            else 
            {
                this.refreshSnapshot();
            }
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

        protected function refreshSnapshot():void
        {
            var loc6:*=null;
            var loc7:*=NaN;
            var loc8:*=NaN;
            var loc9:*=null;
            if (this._snapshotWidth <= 0 || this._snapshotHeight <= 0) 
            {
                return;
            }
            var loc1:*=2;
            if (this._useGutter) 
            {
                loc1 = 0;
            }
            var loc2:*=this.stage === null ? starling.core.Starling.current : this.stage.starling;
            var loc3:*=loc2.contentScaleFactor;
            var loc4:*=starling.utils.Pool.getMatrix();
            if (this._updateSnapshotOnScaleChange) 
            {
                this.getTransformationMatrix(this.stage, loc4);
                loc7 = feathers.utils.geom.matrixToScaleX(loc4);
                loc8 = feathers.utils.geom.matrixToScaleY(loc4);
            }
            loc4.identity();
            loc4.translate(this._textFieldOffsetX - loc1, this._textFieldOffsetY - loc1);
            loc4.scale(loc3, loc3);
            if (this._updateSnapshotOnScaleChange) 
            {
                loc4.scale(loc7, loc8);
            }
            var loc5:*=new flash.display.BitmapData(this._snapshotWidth, this._snapshotHeight, true, 16711935);
            loc5.draw(this.textField, loc4, null, null, this._textFieldSnapshotClipRect);
            starling.utils.Pool.putMatrix(loc4);
            if (!this.textSnapshot || this._needsNewTexture) 
            {
                loc6 = starling.textures.Texture.empty(loc5.width / loc3, loc5.height / loc3, true, false, false, loc3);
                loc6.root.uploadBitmapData(loc5);
                loc6.root.onRestore = this.texture_onRestore;
            }
            if (this.textSnapshot) 
            {
                if (this._needsNewTexture) 
                {
                    this.textSnapshot.texture.dispose();
                    this.textSnapshot.texture = loc6;
                    this.textSnapshot.readjustSize();
                }
                else 
                {
                    loc9 = this.textSnapshot.texture;
                    loc9.root.uploadBitmapData(loc5);
                    this.textSnapshot.setRequiresRedraw();
                }
            }
            else 
            {
                this.textSnapshot = new starling.display.Image(loc6);
                this.textSnapshot.pixelSnapping = true;
                this.addChild(this.textSnapshot);
            }
            if (this._updateSnapshotOnScaleChange) 
            {
                this.textSnapshot.scaleX = 1 / loc7;
                this.textSnapshot.scaleY = 1 / loc8;
                this._lastGlobalScaleX = loc7;
                this._lastGlobalScaleY = loc8;
            }
            this.textSnapshot.alpha = this._text.length > 0 ? 1 : 0;
            loc5.dispose();
            this._needsNewTexture = false;
            return;
        }

        public function get wordWrap():Boolean
        {
            return this._wordWrap;
        }

        public function set wordWrap(arg1:Boolean):void
        {
            if (this._wordWrap == arg1) 
            {
                return;
            }
            this._wordWrap = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function textEditor_addedToStageHandler(arg1:starling.events.Event):void
        {
            var loc1:*=null;
            if (this.textField.parent === null) 
            {
                loc1 = this.stage === null ? starling.core.Starling.current : this.stage.starling;
                loc1.nativeStage.addChild(this.textField);
            }
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

        protected function textEditor_removedFromStageHandler(arg1:starling.events.Event):void
        {
            if (this.textField.parent) 
            {
                this.textField.parent.removeChild(this.textField);
            }
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

        protected function hasFocus_enterFrameHandler(arg1:starling.events.Event):void
        {
            var loc1:*=null;
            if (this.textSnapshot) 
            {
                this.textSnapshot.visible = !this._textFieldHasFocus;
            }
            this.textField.visible = this._textFieldHasFocus;
            if (this._textFieldHasFocus) 
            {
                loc1 = this;
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
            }
            else 
            {
                this.removeEventListener(starling.events.Event.ENTER_FRAME, this.hasFocus_enterFrameHandler);
            }
            return;
        }

        public function get alwaysShowSelection():Boolean
        {
            return this._alwaysShowSelection;
        }

        public function set alwaysShowSelection(arg1:Boolean):void
        {
            if (this._alwaysShowSelection == arg1) 
            {
                return;
            }
            this._alwaysShowSelection = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function refreshSnapshot_enterFrameHandler(arg1:starling.events.Event):void
        {
            this.removeEventListener(starling.events.Event.ENTER_FRAME, this.refreshSnapshot_enterFrameHandler);
            this.refreshSnapshot();
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

        protected function stage_touchHandler(arg1:starling.events.TouchEvent):void
        {
            if (this._maintainTouchFocus) 
            {
                return;
            }
            var loc1:*=arg1.getTouch(this.stage, starling.events.TouchPhase.BEGAN);
            if (!loc1) 
            {
                return;
            }
            var loc2:*=starling.utils.Pool.getPoint();
            loc1.getLocation(this.stage, loc2);
            var loc3:*=this.contains(this.stage.hitTest(loc2));
            starling.utils.Pool.putPoint(loc2);
            if (loc3) 
            {
                return;
            }
            this.clearFocus();
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

        protected function textField_changeHandler(arg1:flash.events.Event):void
        {
            if (this._isHTML) 
            {
                this.text = this.textField.htmlText;
            }
            else 
            {
                this.text = this.textField.text;
            }
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

        protected function textField_focusInHandler(arg1:flash.events.FocusEvent):void
        {
            this._textFieldHasFocus = true;
            this.stage.addEventListener(starling.events.TouchEvent.TOUCH, this.stage_touchHandler);
            this.addEventListener(starling.events.Event.ENTER_FRAME, this.hasFocus_enterFrameHandler);
            this.dispatchEventWith(feathers.events.FeathersEventType.FOCUS_IN);
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

        protected function textField_focusOutHandler(arg1:flash.events.FocusEvent):void
        {
            this._textFieldHasFocus = false;
            this.stage.removeEventListener(starling.events.TouchEvent.TOUCH, this.stage_touchHandler);
            if (this.resetScrollOnFocusOut) 
            {
                var loc1:*;
                this.textField.scrollV = loc1 = 0;
                this.textField.scrollH = loc1;
            }
            this.invalidate(INVALIDATION_FLAG_DATA);
            this.dispatchEventWith(feathers.events.FeathersEventType.FOCUS_OUT);
            return;
        }

        public function get antiAliasType():String
        {
            return this._antiAliasType;
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

        protected function textField_mouseFocusChangeHandler(arg1:flash.events.FocusEvent):void
        {
            if (!this._maintainTouchFocus) 
            {
                return;
            }
            arg1.preventDefault();
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

        protected function textField_keyDownHandler(arg1:flash.events.KeyboardEvent):void
        {
            if (arg1.keyCode != flash.ui.Keyboard.ENTER) 
            {
                if (!feathers.core.FocusManager.isEnabledForStage(this.stage) && arg1.keyCode == flash.ui.Keyboard.TAB) 
                {
                    this.clearFocus();
                }
            }
            else 
            {
                this.dispatchEventWith(feathers.events.FeathersEventType.ENTER);
            }
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

        protected function textField_softKeyboardActivateHandler(arg1:flash.events.SoftKeyboardEvent):void
        {
            this.dispatchEventWith(feathers.events.FeathersEventType.SOFT_KEYBOARD_ACTIVATE, true);
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

        protected function textField_softKeyboardDeactivateHandler(arg1:flash.events.SoftKeyboardEvent):void
        {
            this.dispatchEventWith(feathers.events.FeathersEventType.SOFT_KEYBOARD_DEACTIVATE, true);
            return;
        }

        public function get background():Boolean
        {
            return this._background;
        }

        public function get selectionBeginIndex():int
        {
            if (this._pendingSelectionBeginIndex >= 0) 
            {
                return this._pendingSelectionBeginIndex;
            }
            if (this.textField) 
            {
                return this.textField.selectionBeginIndex;
            }
            return 0;
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

        public function get useGutter():Boolean
        {
            return this._useGutter;
        }

        public function set useGutter(arg1:Boolean):void
        {
            if (this._useGutter == arg1) 
            {
                return;
            }
            this._useGutter = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get setTouchFocusOnEndedPhase():Boolean
        {
            return false;
        }

        public function get selectionEndIndex():int
        {
            if (this._pendingSelectionEndIndex >= 0) 
            {
                return this._pendingSelectionEndIndex;
            }
            if (this.textField) 
            {
                return this.textField.selectionEndIndex;
            }
            return 0;
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

        public function get useSnapshotDelayWorkaround():Boolean
        {
            return this._useSnapshotDelayWorkaround;
        }

        public function set useSnapshotDelayWorkaround(arg1:Boolean):void
        {
            if (this._useSnapshotDelayWorkaround == arg1) 
            {
                return;
            }
            this._useSnapshotDelayWorkaround = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        public override function dispose():void
        {
            if (this.textSnapshot) 
            {
                this.textSnapshot.texture.dispose();
                this.removeChild(this.textSnapshot, true);
                this.textSnapshot = null;
            }
            if (this.textField) 
            {
                if (this.textField.parent) 
                {
                    this.textField.parent.removeChild(this.textField);
                }
                this.textField.removeEventListener(flash.events.Event.CHANGE, this.textField_changeHandler);
                this.textField.removeEventListener(flash.events.FocusEvent.FOCUS_IN, this.textField_focusInHandler);
                this.textField.removeEventListener(flash.events.FocusEvent.FOCUS_OUT, this.textField_focusOutHandler);
                this.textField.removeEventListener(flash.events.KeyboardEvent.KEY_DOWN, this.textField_keyDownHandler);
                this.textField.removeEventListener(flash.events.SoftKeyboardEvent.SOFT_KEYBOARD_ACTIVATE, this.textField_softKeyboardActivateHandler);
                this.textField.removeEventListener(flash.events.SoftKeyboardEvent.SOFT_KEYBOARD_DEACTIVATE, this.textField_softKeyboardDeactivateHandler);
            }
            this.textField = null;
            this.measureTextField = null;
            this.stateContext = null;
            super.dispose();
            return;
        }

        public override function render(arg1:starling.rendering.Painter):void
        {
            var loc1:*=null;
            if (this.textSnapshot) 
            {
                if (this._updateSnapshotOnScaleChange) 
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
                this.positionSnapshot();
            }
            if (this.textField && this.textField.visible) 
            {
                this.transformTextField();
            }
            super.render(arg1);
            return;
        }

        public function setFocus(arg1:flash.geom.Point=null):void
        {
            var position:flash.geom.Point=null;
            var starling:starling.core.Starling;
            var nativeScaleFactor:Number;
            var scaleFactor:Number;
            var scaleX:Number;
            var scaleY:Number;
            var gutterPositionOffset:Number;
            var positionX:Number;
            var positionY:Number;
            var maxPositionX:Number;
            var maxPositionY:Number;
            var lineIndex:int;
            var bounds:flash.geom.Rectangle;
            var boundsX:Number;

            var loc1:*;
            starling = null;
            nativeScaleFactor = NaN;
            scaleFactor = NaN;
            scaleX = NaN;
            scaleY = NaN;
            gutterPositionOffset = NaN;
            positionX = NaN;
            positionY = NaN;
            maxPositionX = NaN;
            maxPositionY = NaN;
            lineIndex = 0;
            bounds = null;
            boundsX = NaN;
            position = arg1;
            if (this.textField === null) 
            {
                this._isWaitingToSetFocus = true;
            }
            else 
            {
                starling = this.stage === null ? starling.core.Starling.current : this.stage.starling;
                if (this.textField.parent === null) 
                {
                    starling.nativeStage.addChild(this.textField);
                }
                if (position === null) 
                {
                    this._pendingSelectionEndIndex = loc2 = -1;
                    this._pendingSelectionBeginIndex = loc2;
                }
                else 
                {
                    nativeScaleFactor = 1;
                    if (starling.supportHighResolutions) 
                    {
                        nativeScaleFactor = starling.nativeStage.contentsScaleFactor;
                    }
                    scaleFactor = starling.contentScaleFactor / nativeScaleFactor;
                    scaleX = this.textField.scaleX;
                    scaleY = this.textField.scaleY;
                    gutterPositionOffset = 2;
                    if (this._useGutter) 
                    {
                        gutterPositionOffset = 0;
                    }
                    positionX = position.x + gutterPositionOffset;
                    positionY = position.y + gutterPositionOffset;
                    if (positionX < gutterPositionOffset) 
                    {
                        positionX = gutterPositionOffset;
                    }
                    else 
                    {
                        maxPositionX = this.textField.width / scaleX - gutterPositionOffset;
                        if (positionX > maxPositionX) 
                        {
                            positionX = maxPositionX;
                        }
                    }
                    if (positionY < gutterPositionOffset) 
                    {
                        positionY = gutterPositionOffset;
                    }
                    else 
                    {
                        maxPositionY = this.textField.height / scaleY - gutterPositionOffset;
                        if (positionY > maxPositionY) 
                        {
                            positionY = maxPositionY;
                        }
                    }
                    this._pendingSelectionBeginIndex = this.getSelectionIndexAtPoint(positionX, positionY);
                    if (this._pendingSelectionBeginIndex < 0) 
                    {
                        if (this._multiline) 
                        {
                            lineIndex = this.textField.getLineIndexAtPoint(this.textField.width / 2 / scaleX, positionY);
                            try 
                            {
                                this._pendingSelectionBeginIndex = this.textField.getLineOffset(lineIndex) + this.textField.getLineLength(lineIndex);
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
                            this._pendingSelectionBeginIndex = this.getSelectionIndexAtPoint(positionX, this.textField.getLineMetrics(0).ascent / 2);
                            if (this._pendingSelectionBeginIndex < 0) 
                            {
                                this._pendingSelectionBeginIndex = this._text.length;
                            }
                        }
                    }
                    else 
                    {
                        bounds = this.textField.getCharBoundaries(this._pendingSelectionBeginIndex);
                        if (bounds) 
                        {
                            boundsX = bounds.x;
                            if (bounds && boundsX + bounds.width - positionX < positionX - boundsX) 
                            {
                                loc3 = ((loc2 = this)._pendingSelectionBeginIndex + 1);
                                loc2._pendingSelectionBeginIndex = loc3;
                            }
                        }
                    }
                    this._pendingSelectionEndIndex = this._pendingSelectionBeginIndex;
                }
                if (!feathers.core.FocusManager.isEnabledForStage(this.stage)) 
                {
                    starling.nativeStage.focus = this.textField;
                }
                this.textField.requestSoftKeyboard();
                if (this._textFieldHasFocus) 
                {
                    this.invalidate(INVALIDATION_FLAG_SELECTED);
                }
            }
            return;
        }

        public function clearFocus():void
        {
            if (!this._textFieldHasFocus) 
            {
                return;
            }
            var loc1:*=this.stage === null ? starling.core.Starling.current : this.stage.starling;
            var loc2:*=loc1.nativeStage;
            if (loc2.focus === this.textField) 
            {
                loc2.focus = null;
            }
            return;
        }

        public function selectRange(arg1:int, arg2:int):void
        {
            if (!this._isEditable && !this._isSelectable) 
            {
                return;
            }
            if (this.textField) 
            {
                if (!this._isValidating) 
                {
                    this.validate();
                }
                this.textField.setSelection(arg1, arg2);
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
            this.commit();
            arg1 = this.measure(arg1);
            return arg1;
        }

        public function getTextFormatForState(arg1:String):flash.text.TextFormat
        {
            if (this._textFormatForState === null) 
            {
                return null;
            }
            return flash.text.TextFormat(this._textFormatForState[arg1]);
        }

        public function setTextFormatForState(arg1:String, arg2:flash.text.TextFormat):void
        {
            if (arg2) 
            {
                if (!this._textFormatForState) 
                {
                    this._textFormatForState = {};
                }
                this._textFormatForState[arg1] = arg2;
            }
            else 
            {
                delete this._textFormatForState[arg1];
            }
            if (this._stateContext && this._stateContext.currentState === arg1) 
            {
                this.invalidate(INVALIDATION_FLAG_STATE);
            }
            return;
        }

        protected override function initialize():void
        {
            this.textField = new flash.text.TextField();
            this.textField.tabEnabled = false;
            this.textField.visible = false;
            this.textField.needsSoftKeyboard = true;
            this.textField.addEventListener(flash.events.Event.CHANGE, this.textField_changeHandler);
            this.textField.addEventListener(flash.events.FocusEvent.FOCUS_IN, this.textField_focusInHandler);
            this.textField.addEventListener(flash.events.FocusEvent.FOCUS_OUT, this.textField_focusOutHandler);
            this.textField.addEventListener(flash.events.FocusEvent.MOUSE_FOCUS_CHANGE, this.textField_mouseFocusChangeHandler);
            this.textField.addEventListener(flash.events.KeyboardEvent.KEY_DOWN, this.textField_keyDownHandler);
            this.textField.addEventListener(flash.events.SoftKeyboardEvent.SOFT_KEYBOARD_ACTIVATE, this.textField_softKeyboardActivateHandler);
            this.textField.addEventListener(flash.events.SoftKeyboardEvent.SOFT_KEYBOARD_DEACTIVATE, this.textField_softKeyboardDeactivateHandler);
            this.measureTextField = new flash.text.TextField();
            this.measureTextField.autoSize = flash.text.TextFieldAutoSize.LEFT;
            this.measureTextField.selectable = false;
            this.measureTextField.tabEnabled = false;
            this.measureTextField.mouseWheelEnabled = false;
            this.measureTextField.mouseEnabled = false;
            return;
        }

        protected var textField:flash.text.TextField;

        protected var textSnapshot:starling.display.Image;

        protected var measureTextField:flash.text.TextField;

        protected var _snapshotWidth:int=0;

        protected var _snapshotHeight:int=0;

        protected var _textFieldSnapshotClipRect:flash.geom.Rectangle;

        protected var _textFieldOffsetX:Number=0;

        protected var _textFieldOffsetY:Number=0;

        protected var _lastGlobalScaleX:Number=0;

        protected var _lastGlobalScaleY:Number=0;

        protected var _needsNewTexture:Boolean=false;

        protected var _previousTextFormat:flash.text.TextFormat;

        protected var _currentTextFormat:flash.text.TextFormat;

        protected var _textFormatForState:Object;

        protected var _fontStylesTextFormat:flash.text.TextFormat;

        protected var _textFormat:flash.text.TextFormat;

        protected var _disabledTextFormat:flash.text.TextFormat;

        protected var _embedFonts:Boolean=false;

        protected var _wordWrap:Boolean=false;

        protected var _multiline:Boolean=false;

        protected var _isHTML:Boolean=false;

        protected var _alwaysShowSelection:Boolean=false;

        protected var _displayAsPassword:Boolean=false;

        protected var _maxChars:int=0;

        protected var _restrict:String;

        protected var _isEditable:Boolean=true;

        internal var _antiAliasType:String="advanced";

        internal var _gridFitType:String="pixel";

        internal var _sharpness:Number=0;

        internal var _thickness:Number=0;

        internal var _background:Boolean=false;

        protected var _pendingSelectionEndIndex:int=-1;

        protected var _useGutter:Boolean=false;

        protected var _maintainTouchFocus:Boolean=false;

        internal var _borderColor:uint=0;

        internal var _backgroundColor:uint=16777215;

        protected var _updateSnapshotOnScaleChange:Boolean=false;

        internal var _border:Boolean=false;

        protected var _textFieldHasFocus:Boolean=false;

        protected var _useSnapshotDelayWorkaround:Boolean=false;

        protected var _isWaitingToSetFocus:Boolean=false;

        protected var _pendingSelectionBeginIndex:int=-1;

        protected var resetScrollOnFocusOut:Boolean=true;

        protected var _isSelectable:Boolean=true;

        public static var globalStyleProvider:feathers.skins.IStyleProvider;
    }
}


