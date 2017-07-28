//class ProgressBar
package feathers.controls 
{
    import feathers.core.*;
    import feathers.layout.*;
    import feathers.skins.*;
    import feathers.utils.math.*;
    import feathers.utils.skins.*;
    import starling.display.*;
    
    public class ProgressBar extends feathers.core.FeathersControl
    {
        public function ProgressBar()
        {
            super();
            return;
        }

        protected override function get defaultStyleProvider():feathers.skins.IStyleProvider
        {
            return ProgressBar.globalStyleProvider;
        }

        public function set fillDisabledSkin(arg1:starling.display.DisplayObject):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                if (arg1 !== null) 
                {
                    arg1.dispose();
                }
                return;
            }
            if (this._fillDisabledSkin === arg1) 
            {
                return;
            }
            if (this._fillDisabledSkin && !(this._fillDisabledSkin == this._fillSkin)) 
            {
                this.removeChild(this._fillDisabledSkin);
            }
            this._fillDisabledSkin = arg1;
            if (this._fillDisabledSkin && !(this._fillDisabledSkin.parent == this)) 
            {
                this._fillDisabledSkin.visible = false;
                this.addChild(this._fillDisabledSkin);
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get direction():String
        {
            return this._direction;
        }

        public function set direction(arg1:String):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._direction === arg1) 
            {
                return;
            }
            this._direction = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        public function set padding(arg1:Number):void
        {
            this.paddingTop = arg1;
            this.paddingRight = arg1;
            this.paddingBottom = arg1;
            this.paddingLeft = arg1;
            return;
        }

        public function get value():Number
        {
            return this._value;
        }

        public function set value(arg1:Number):void
        {
            arg1 = feathers.utils.math.clamp(arg1, this._minimum, this._maximum);
            if (this._value == arg1) 
            {
                return;
            }
            this._value = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        public function get paddingTop():Number
        {
            return this._paddingTop;
        }

        public function get minimum():Number
        {
            return this._minimum;
        }

        public function set minimum(arg1:Number):void
        {
            if (this._minimum == arg1) 
            {
                return;
            }
            this._minimum = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
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

        public function get maximum():Number
        {
            return this._maximum;
        }

        public function set maximum(arg1:Number):void
        {
            if (this._maximum == arg1) 
            {
                return;
            }
            this._maximum = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        public function get paddingRight():Number
        {
            return this._paddingRight;
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

        protected override function draw():void
        {
            var loc1:*=this.isInvalid(INVALIDATION_FLAG_STYLES);
            var loc2:*=this.isInvalid(INVALIDATION_FLAG_STATE);
            var loc3:*=this.isInvalid(INVALIDATION_FLAG_SIZE);
            if (loc1 || loc2) 
            {
                this.refreshBackground();
                this.refreshFill();
            }
            this.autoSizeIfNeeded();
            this.layoutChildren();
            if (this.currentBackground is feathers.core.IValidating) 
            {
                feathers.core.IValidating(this.currentBackground).validate();
            }
            if (this.currentFill is feathers.core.IValidating) 
            {
                feathers.core.IValidating(this.currentFill).validate();
            }
            return;
        }

        protected function autoSizeIfNeeded():Boolean
        {
            var loc10:*=NaN;
            var loc11:*=NaN;
            var loc12:*=NaN;
            var loc13:*=NaN;
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
            if (this.currentFill is feathers.core.IValidating) 
            {
                feathers.core.IValidating(this.currentFill).validate();
            }
            var loc6:*=this._explicitMinWidth;
            if (loc3) 
            {
                if (loc5 === null) 
                {
                    if (this.currentBackground === null) 
                    {
                        loc6 = 0;
                    }
                    else 
                    {
                        loc6 = this._explicitBackgroundMinWidth;
                    }
                }
                else 
                {
                    loc6 = loc5.minWidth;
                }
                loc10 = this._originalFillWidth;
                if (this.currentFill is feathers.core.IFeathersControl) 
                {
                    loc10 = feathers.core.IFeathersControl(this.currentFill).minWidth;
                }
                loc10 = loc10 + (this._paddingLeft + this._paddingRight);
                if (loc10 > loc6) 
                {
                    loc6 = loc10;
                }
            }
            var loc7:*=this._explicitMinHeight;
            if (loc4) 
            {
                if (loc5 === null) 
                {
                    if (this.currentBackground === null) 
                    {
                        loc7 = 0;
                    }
                    else 
                    {
                        loc7 = this._explicitBackgroundMinHeight;
                    }
                }
                else 
                {
                    loc7 = loc5.minHeight;
                }
                loc11 = this._originalFillHeight;
                if (this.currentFill is feathers.core.IFeathersControl) 
                {
                    loc11 = feathers.core.IFeathersControl(this.currentFill).minHeight;
                }
                loc11 = loc11 + (this._paddingTop + this._paddingBottom);
                if (loc11 > loc7) 
                {
                    loc7 = loc11;
                }
            }
            var loc8:*=this._explicitWidth;
            if (loc1) 
            {
                if (this.currentBackground === null) 
                {
                    loc8 = 0;
                }
                else 
                {
                    loc8 = this.currentBackground.width;
                }
                loc12 = this._originalFillWidth + this._paddingLeft + this._paddingRight;
                if (loc12 > loc8) 
                {
                    loc8 = loc12;
                }
            }
            var loc9:*=this._explicitHeight;
            if (loc2) 
            {
                if (this.currentBackground === null) 
                {
                    loc9 = 0;
                }
                else 
                {
                    loc9 = this.currentBackground.height;
                }
                loc13 = this._originalFillHeight + this._paddingTop + this._paddingBottom;
                if (loc13 > loc9) 
                {
                    loc9 = loc13;
                }
            }
            return this.saveMeasurements(loc8, loc9, loc6, loc7);
        }

        public function get backgroundSkin():starling.display.DisplayObject
        {
            return this._backgroundSkin;
        }

        public function set backgroundSkin(arg1:starling.display.DisplayObject):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                if (arg1 !== null) 
                {
                    arg1.dispose();
                }
                return;
            }
            if (this._backgroundSkin === arg1) 
            {
                return;
            }
            if (this._backgroundSkin && !(this._backgroundSkin == this._backgroundDisabledSkin)) 
            {
                this.removeChild(this._backgroundSkin);
            }
            this._backgroundSkin = arg1;
            if (this._backgroundSkin && !(this._backgroundSkin.parent == this)) 
            {
                this._backgroundSkin.visible = false;
                this.addChildAt(this._backgroundSkin, 0);
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function refreshBackground():void
        {
            var loc1:*=null;
            this.currentBackground = this._backgroundSkin;
            if (this._backgroundDisabledSkin !== null) 
            {
                if (this._isEnabled) 
                {
                    this._backgroundDisabledSkin.visible = false;
                }
                else 
                {
                    this.currentBackground = this._backgroundDisabledSkin;
                    if (this._backgroundSkin !== null) 
                    {
                        this._backgroundSkin.visible = false;
                    }
                }
            }
            if (this.currentBackground !== null) 
            {
                this.currentBackground.visible = true;
                if (this.currentBackground is feathers.core.IFeathersControl) 
                {
                    feathers.core.IFeathersControl(this.currentBackground).initializeNow();
                }
                if (this.currentBackground is feathers.core.IMeasureDisplayObject) 
                {
                    loc1 = feathers.core.IMeasureDisplayObject(this.currentBackground);
                    this._explicitBackgroundWidth = loc1.explicitWidth;
                    this._explicitBackgroundHeight = loc1.explicitHeight;
                    this._explicitBackgroundMinWidth = loc1.explicitMinWidth;
                    this._explicitBackgroundMinHeight = loc1.explicitMinHeight;
                    this._explicitBackgroundMaxWidth = loc1.explicitMaxWidth;
                    this._explicitBackgroundMaxHeight = loc1.explicitMaxHeight;
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
            return;
        }

        public function get backgroundDisabledSkin():starling.display.DisplayObject
        {
            return this._backgroundDisabledSkin;
        }

        public function set backgroundDisabledSkin(arg1:starling.display.DisplayObject):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                if (arg1 !== null) 
                {
                    arg1.dispose();
                }
                return;
            }
            if (this._backgroundDisabledSkin === arg1) 
            {
                return;
            }
            if (this._backgroundDisabledSkin && !(this._backgroundDisabledSkin == this._backgroundSkin)) 
            {
                this.removeChild(this._backgroundDisabledSkin);
            }
            this._backgroundDisabledSkin = arg1;
            if (this._backgroundDisabledSkin && !(this._backgroundDisabledSkin.parent == this)) 
            {
                this._backgroundDisabledSkin.visible = false;
                this.addChildAt(this._backgroundDisabledSkin, 0);
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function refreshFill():void
        {
            this.currentFill = this._fillSkin;
            if (this._fillDisabledSkin) 
            {
                if (this._isEnabled) 
                {
                    this._fillDisabledSkin.visible = false;
                }
                else 
                {
                    this.currentFill = this._fillDisabledSkin;
                    if (this._backgroundSkin) 
                    {
                        this._fillSkin.visible = false;
                    }
                }
            }
            if (this.currentFill) 
            {
                if (this.currentFill is feathers.core.IValidating) 
                {
                    feathers.core.IValidating(this.currentFill).validate();
                }
                if (this._originalFillWidth !== this._originalFillWidth) 
                {
                    this._originalFillWidth = this.currentFill.width;
                }
                if (this._originalFillHeight !== this._originalFillHeight) 
                {
                    this._originalFillHeight = this.currentFill.height;
                }
                this.currentFill.visible = true;
            }
            return;
        }

        protected function layoutChildren():void
        {
            var loc1:*=NaN;
            if (this.currentBackground) 
            {
                this.currentBackground.width = this.actualWidth;
                this.currentBackground.height = this.actualHeight;
            }
            if (this._minimum !== this._maximum) 
            {
                loc1 = (this._value - this._minimum) / (this._maximum - this._minimum);
                if (loc1 < 0) 
                {
                    loc1 = 0;
                }
                else if (loc1 > 1) 
                {
                    loc1 = 1;
                }
            }
            else 
            {
                loc1 = 1;
            }
            if (this._direction !== feathers.layout.Direction.VERTICAL) 
            {
                this.currentFill.width = Math.round(this._originalFillWidth + loc1 * (this.actualWidth - this._paddingLeft - this._paddingRight - this._originalFillWidth));
                this.currentFill.height = this.actualHeight - this._paddingTop - this._paddingBottom;
                this.currentFill.x = this._paddingLeft;
                this.currentFill.y = this._paddingTop;
            }
            else 
            {
                this.currentFill.width = this.actualWidth - this._paddingLeft - this._paddingRight;
                this.currentFill.height = Math.round(this._originalFillHeight + loc1 * (this.actualHeight - this._paddingTop - this._paddingBottom - this._originalFillHeight));
                this.currentFill.x = this._paddingLeft;
                this.currentFill.y = this.actualHeight - this._paddingBottom - this.currentFill.height;
            }
            return;
        }

        public function get padding():Number
        {
            return this._paddingTop;
        }

        public function get fillSkin():starling.display.DisplayObject
        {
            return this._fillSkin;
        }

        public function set fillSkin(arg1:starling.display.DisplayObject):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                if (arg1 !== null) 
                {
                    arg1.dispose();
                }
                return;
            }
            if (this._fillSkin === arg1) 
            {
                return;
            }
            if (this._fillSkin && !(this._fillSkin == this._fillDisabledSkin)) 
            {
                this.removeChild(this._fillSkin);
            }
            this._fillSkin = arg1;
            if (this._fillSkin && !(this._fillSkin.parent == this)) 
            {
                this._fillSkin.visible = false;
                this.addChild(this._fillSkin);
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get fillDisabledSkin():starling.display.DisplayObject
        {
            return this._fillDisabledSkin;
        }

        public static const DIRECTION_HORIZONTAL:String="horizontal";

        public static const DIRECTION_VERTICAL:String="vertical";

        protected var _direction:String="horizontal";

        protected var _value:Number=0;

        protected var _minimum:Number=0;

        protected var _maximum:Number=1;

        protected var _explicitBackgroundWidth:Number;

        protected var _explicitBackgroundHeight:Number;

        protected var _explicitBackgroundMinWidth:Number;

        protected var _explicitBackgroundMinHeight:Number;

        protected var _explicitBackgroundMaxWidth:Number;

        protected var _explicitBackgroundMaxHeight:Number;

        protected var currentBackground:starling.display.DisplayObject;

        protected var _backgroundSkin:starling.display.DisplayObject;

        protected var _backgroundDisabledSkin:starling.display.DisplayObject;

        protected var _originalFillWidth:Number=NaN;

        protected var _originalFillHeight:Number=NaN;

        protected var _paddingRight:Number=0;

        protected var _fillSkin:starling.display.DisplayObject;

        protected var _paddingTop:Number=0;

        protected var _paddingBottom:Number=0;

        protected var _fillDisabledSkin:starling.display.DisplayObject;

        protected var currentFill:starling.display.DisplayObject;

        protected var _paddingLeft:Number=0;

        public static var globalStyleProvider:feathers.skins.IStyleProvider;
    }
}


