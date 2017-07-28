//class TextFieldTextEditorViewPort
package feathers.controls.text 
{
    import feathers.controls.*;
    import feathers.skins.*;
    import feathers.utils.geom.*;
    import feathers.utils.math.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import starling.core.*;
    import starling.utils.*;
    
    public class TextFieldTextEditorViewPort extends feathers.controls.text.TextFieldTextEditor implements feathers.controls.text.ITextEditorViewPort
    {
        public function TextFieldTextEditorViewPort()
        {
            super();
            this.multiline = true;
            this.wordWrap = true;
            this.resetScrollOnFocusOut = false;
            return;
        }

        protected override function get defaultStyleProvider():feathers.skins.IStyleProvider
        {
            return globalStyleProvider;
        }

        protected override function measure(arg1:flash.geom.Point=null):flash.geom.Point
        {
            if (!arg1) 
            {
                arg1 = new flash.geom.Point();
            }
            var loc1:*=!(this._visibleWidth === this._visibleWidth);
            this.commitStylesAndData(this.measureTextField);
            var loc2:*=4;
            if (this._useGutter) 
            {
                loc2 = 0;
            }
            var loc3:*=this._visibleWidth;
            this.measureTextField.width = loc3 - this._paddingLeft - this._paddingRight + loc2;
            if (loc1) 
            {
                loc3 = this.measureTextField.width + this._paddingLeft + this._paddingRight - loc2;
                if (loc3 < this._minVisibleWidth) 
                {
                    loc3 = this._minVisibleWidth;
                }
                else if (loc3 > this._maxVisibleWidth) 
                {
                    loc3 = this._maxVisibleWidth;
                }
            }
            var loc4:*=this.measureTextField.height + this._paddingTop + this._paddingBottom - loc2;
            if (this._useGutter) 
            {
                loc4 = loc4 + 4;
            }
            if (this._visibleHeight !== this._visibleHeight) 
            {
                if (loc4 < this._minVisibleHeight) 
                {
                    loc4 = this._minVisibleHeight;
                }
            }
            else if (loc4 < this._visibleHeight) 
            {
                loc4 = this._visibleHeight;
            }
            arg1.x = loc3;
            arg1.y = loc4;
            return arg1;
        }

        protected override function refreshSnapshotParameters():void
        {
            var loc7:*=null;
            var loc1:*=this._visibleWidth - this._paddingLeft - this._paddingRight;
            if (loc1 !== loc1) 
            {
                if (this._maxVisibleWidth < Number.POSITIVE_INFINITY) 
                {
                    loc1 = this._maxVisibleWidth - this._paddingLeft - this._paddingRight;
                }
                else 
                {
                    loc1 = this._minVisibleWidth - this._paddingLeft - this._paddingRight;
                }
            }
            var loc2:*=this._visibleHeight - this._paddingTop - this._paddingBottom;
            if (loc2 !== loc2) 
            {
                if (this._maxVisibleHeight < Number.POSITIVE_INFINITY) 
                {
                    loc2 = this._maxVisibleHeight - this._paddingTop - this._paddingBottom;
                }
                else 
                {
                    loc2 = this._minVisibleHeight - this._paddingTop - this._paddingBottom;
                }
            }
            this._textFieldOffsetX = 0;
            this._textFieldOffsetY = 0;
            this._textFieldSnapshotClipRect.x = 0;
            this._textFieldSnapshotClipRect.y = 0;
            var loc3:*=this.stage === null ? starling.core.Starling.current : this.stage.starling;
            var loc4:*=loc3.contentScaleFactor;
            var loc5:*=loc1 * loc4;
            if (this._updateSnapshotOnScaleChange) 
            {
                loc7 = starling.utils.Pool.getMatrix();
                this.getTransformationMatrix(this.stage, loc7);
                loc5 = loc5 * feathers.utils.geom.matrixToScaleX(loc7);
            }
            if (loc5 < 0) 
            {
                loc5 = 0;
            }
            var loc6:*=loc2 * loc4;
            if (this._updateSnapshotOnScaleChange) 
            {
                loc6 = loc6 * feathers.utils.geom.matrixToScaleY(loc7);
                starling.utils.Pool.putMatrix(loc7);
            }
            if (loc6 < 0) 
            {
                loc6 = 0;
            }
            this._textFieldSnapshotClipRect.width = loc5;
            this._textFieldSnapshotClipRect.height = loc6;
            return;
        }

        public function get minVisibleWidth():Number
        {
            return this._minVisibleWidth;
        }

        public function set minVisibleWidth(arg1:Number):void
        {
            if (this._minVisibleWidth == arg1) 
            {
                return;
            }
            if (arg1 !== arg1) 
            {
                throw new ArgumentError("minVisibleWidth cannot be NaN");
            }
            this._minVisibleWidth = arg1;
            this.invalidate(INVALIDATION_FLAG_SIZE);
            return;
        }

        protected override function refreshTextFieldSize():void
        {
            var loc1:*=this._ignoreScrolling;
            var loc2:*=4;
            if (this._useGutter) 
            {
                loc2 = 0;
            }
            this._ignoreScrolling = true;
            this.textField.width = this._visibleWidth - this._paddingLeft - this._paddingRight + loc2;
            var loc3:*=this._visibleHeight - this._paddingTop - this._paddingBottom + loc2;
            if (this.textField.height != loc3) 
            {
                this.textField.height = loc3;
            }
            var loc4:*=feathers.controls.Scroller(this.parent);
            this.textField.scrollV = Math.round(1 + (this.textField.maxScrollV - 1) * this._verticalScrollPosition / loc4.maxVerticalScrollPosition);
            this._ignoreScrolling = loc1;
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
            this._maxVisibleWidth = arg1;
            this.invalidate(INVALIDATION_FLAG_SIZE);
            return;
        }

        protected override function transformTextField():void
        {
            var loc1:*=this.stage === null ? starling.core.Starling.current : this.stage.starling;
            var loc2:*=1;
            if (loc1.supportHighResolutions) 
            {
                loc2 = loc1.nativeStage.contentsScaleFactor;
            }
            var loc3:*=loc1.contentScaleFactor / loc2;
            var loc4:*=starling.utils.Pool.getMatrix();
            var loc5:*=starling.utils.Pool.getPoint();
            this.getTransformationMatrix(this.stage, loc4);
            starling.utils.MatrixUtil.transformCoords(loc4, 0, 0, loc5);
            var loc6:*=feathers.utils.geom.matrixToScaleX(loc4) * loc3;
            var loc7:*=feathers.utils.geom.matrixToScaleY(loc4) * loc3;
            var loc8:*=Math.round(this._paddingLeft * loc6);
            var loc9:*=Math.round((this._paddingTop + this._verticalScrollPosition) * loc7);
            var loc10:*=loc1.viewPort;
            var loc11:*=2;
            if (this._useGutter) 
            {
                loc11 = 0;
            }
            this.textField.x = loc8 + Math.round(loc10.x + loc5.x * loc3 - loc11 * loc6);
            this.textField.y = loc9 + Math.round(loc10.y + loc5.y * loc3 - loc11 * loc7);
            this.textField.rotation = feathers.utils.geom.matrixToRotation(loc4) * 180 / Math.PI;
            this.textField.scaleX = loc6;
            this.textField.scaleY = loc7;
            starling.utils.Pool.putPoint(loc5);
            starling.utils.Pool.putMatrix(loc4);
            return;
        }

        public function get visibleWidth():Number
        {
            return this._visibleWidth;
        }

        public function set visibleWidth(arg1:Number):void
        {
            if (this._visibleWidth == arg1 || !(arg1 === arg1) && !(this._visibleWidth === this._visibleWidth)) 
            {
                return;
            }
            this._visibleWidth = arg1;
            this.invalidate(INVALIDATION_FLAG_SIZE);
            return;
        }

        protected override function positionSnapshot():void
        {
            if (!this.textSnapshot) 
            {
                return;
            }
            var loc1:*=starling.utils.Pool.getMatrix();
            this.getTransformationMatrix(this.stage, loc1);
            this.textSnapshot.x = this._paddingLeft + Math.round(loc1.tx) - loc1.tx;
            this.textSnapshot.y = this._paddingTop + this._verticalScrollPosition + Math.round(loc1.ty) - loc1.ty;
            starling.utils.Pool.putMatrix(loc1);
            return;
        }

        public function get minVisibleHeight():Number
        {
            return this._minVisibleHeight;
        }

        public function set minVisibleHeight(arg1:Number):void
        {
            if (this._minVisibleHeight == arg1) 
            {
                return;
            }
            if (arg1 !== arg1) 
            {
                throw new ArgumentError("minVisibleHeight cannot be NaN");
            }
            this._minVisibleHeight = arg1;
            this.invalidate(INVALIDATION_FLAG_SIZE);
            return;
        }

        protected override function checkIfNewSnapshotIsNeeded():void
        {
            super.checkIfNewSnapshotIsNeeded();
            this._needsNewTexture = this._needsNewTexture || this.isInvalid(INVALIDATION_FLAG_SCROLL);
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
            this._maxVisibleHeight = arg1;
            this.invalidate(INVALIDATION_FLAG_SIZE);
            return;
        }

        protected override function textField_focusInHandler(arg1:flash.events.FocusEvent):void
        {
            this.textField.addEventListener(flash.events.Event.SCROLL, this.textField_scrollHandler);
            super.textField_focusInHandler(arg1);
            this.invalidate(INVALIDATION_FLAG_SIZE);
            return;
        }

        public function get visibleHeight():Number
        {
            return this._visibleHeight;
        }

        public function set visibleHeight(arg1:Number):void
        {
            if (this._visibleHeight == arg1 || !(arg1 === arg1) && !(this._visibleHeight === this._visibleHeight)) 
            {
                return;
            }
            this._visibleHeight = arg1;
            this.invalidate(INVALIDATION_FLAG_SIZE);
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

        public function get verticalScrollPosition():Number
        {
            return this._verticalScrollPosition;
        }

        public function get horizontalScrollStep():Number
        {
            return this._scrollStep;
        }

        public function get verticalScrollStep():Number
        {
            return this._scrollStep;
        }

        protected override function textField_focusOutHandler(arg1:flash.events.FocusEvent):void
        {
            this.textField.removeEventListener(flash.events.Event.SCROLL, this.textField_scrollHandler);
            super.textField_focusOutHandler(arg1);
            this.invalidate(INVALIDATION_FLAG_SIZE);
            return;
        }

        public function get horizontalScrollPosition():Number
        {
            return this._horizontalScrollPosition;
        }

        public function set horizontalScrollPosition(arg1:Number):void
        {
            this._horizontalScrollPosition = arg1;
            return;
        }

        protected function textField_scrollHandler(arg1:flash.events.Event):void
        {
            var loc4:*=NaN;
            var loc1:*=this.textField.scrollH;
            var loc2:*=this.textField.scrollV;
            if (this._ignoreScrolling) 
            {
                return;
            }
            var loc3:*=feathers.controls.Scroller(this.parent);
            if (loc3.maxVerticalScrollPosition > 0 && this.textField.maxScrollV > 1) 
            {
                loc4 = loc3.maxVerticalScrollPosition * (loc2 - 1) / (this.textField.maxScrollV - 1);
                loc3.verticalScrollPosition = feathers.utils.math.roundToNearest(loc4, this._scrollStep);
            }
            return;
        }

        public function get paddingTop():Number
        {
            return this._paddingTop;
        }

        public function set verticalScrollPosition(arg1:Number):void
        {
            if (this._verticalScrollPosition == arg1) 
            {
                return;
            }
            this._verticalScrollPosition = arg1;
            this.invalidate(INVALIDATION_FLAG_SCROLL);
            this.invalidate(INVALIDATION_FLAG_SIZE);
            return;
        }

        public function get requiresMeasurementOnScroll():Boolean
        {
            return false;
        }

        public override function get baseline():Number
        {
            return super.baseline + this._paddingTop + this._verticalScrollPosition;
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

        public function get paddingRight():Number
        {
            return this._paddingRight;
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

        public function get paddingBottom():Number
        {
            return this._paddingBottom;
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

        protected override function commitStylesAndData(arg1:flash.text.TextField):void
        {
            super.commitStylesAndData(arg1);
            if (arg1 == this.textField) 
            {
                this._scrollStep = arg1.getLineMetrics(0).height;
            }
            return;
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

        public override function setFocus(arg1:flash.geom.Point=null):void
        {
            if (arg1 !== null) 
            {
                arg1.x = arg1.x - this._paddingLeft;
                arg1.y = arg1.y - this._paddingTop;
            }
            super.setFocus(arg1);
            return;
        }

        internal var _ignoreScrolling:Boolean=false;

        internal var _minVisibleWidth:Number=0;

        internal var _maxVisibleWidth:Number=Infinity;

        internal var _visibleWidth:Number=NaN;

        internal var _minVisibleHeight:Number=0;

        internal var _maxVisibleHeight:Number=Infinity;

        internal var _visibleHeight:Number=NaN;

        internal var _horizontalScrollPosition:Number=0;

        internal var _verticalScrollPosition:Number=0;

        protected var _paddingTop:Number=0;

        protected var _paddingBottom:Number=0;

        protected var _paddingRight:Number=0;

        protected var _paddingLeft:Number=0;

        protected var _scrollStep:int=0;

        public static var globalStyleProvider:feathers.skins.IStyleProvider;
    }
}


