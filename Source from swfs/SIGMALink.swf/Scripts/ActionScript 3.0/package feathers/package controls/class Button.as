//class Button
package feathers.controls 
{
    import feathers.core.*;
    import feathers.events.*;
    import feathers.layout.*;
    import feathers.skins.*;
    import feathers.text.*;
    import feathers.utils.keyboard.*;
    import feathers.utils.skins.*;
    import feathers.utils.touch.*;
    import flash.geom.*;
    import flash.ui.*;
    import starling.display.*;
    import starling.events.*;
    import starling.rendering.*;
    import starling.text.*;
    import starling.utils.*;
    
    public class Button extends feathers.controls.BasicButton implements feathers.core.IFocusDisplayObject, feathers.core.ITextBaselineControl
    {
        public function Button()
        {
            this._stateToLabelProperties = {};
            this._stateToIcon = {};
            super();
            if (this._fontStylesSet === null) 
            {
                this._fontStylesSet = new feathers.text.FontStylesSet();
                this._fontStylesSet.addEventListener(starling.events.Event.CHANGE, this.fontStyles_changeHandler);
            }
            return;
        }

        public function set scaleWhenHovering(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._scaleWhenHovering === arg1) 
            {
                return;
            }
            this._scaleWhenHovering = arg1;
            return;
        }

        public function get baseline():Number
        {
            if (!this.labelTextRenderer) 
            {
                return this.scaledActualHeight;
            }
            return this.scaleY * (this.labelTextRenderer.y + this.labelTextRenderer.baseline);
        }

        public override function render(arg1:starling.rendering.Painter):void
        {
            var loc2:*=null;
            var loc1:*=1;
            if (this._currentState !== feathers.controls.ButtonState.DOWN) 
            {
                if (this._currentState === feathers.controls.ButtonState.HOVER) 
                {
                    loc1 = this._scaleWhenHovering;
                }
            }
            else 
            {
                loc1 = this._scaleWhenDown;
            }
            if (loc1 !== 1) 
            {
                loc2 = starling.utils.Pool.getMatrix();
                loc2.scale(loc1, loc1);
                loc2.translate(Math.round((1 - loc1) / 2 * this.actualWidth), Math.round((1 - loc1) / 2 * this.actualHeight));
                arg1.state.transformModelviewMatrix(loc2);
                starling.utils.Pool.putMatrix(loc2);
            }
            super.render(arg1);
            return;
        }

        public override function dispose():void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (!(this._defaultIcon === null) && !(this._defaultIcon.parent === this)) 
            {
                this._defaultIcon.dispose();
            }
            var loc3:*=0;
            var loc4:*=this._stateToIcon;
            for (loc1 in loc4) 
            {
                loc2 = this._stateToIcon[loc1] as starling.display.DisplayObject;
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

        public function getIconForState(arg1:String):starling.display.DisplayObject
        {
            return this._stateToIcon[arg1] as starling.display.DisplayObject;
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
            var loc2:*=this._stateToIcon[arg1] as starling.display.DisplayObject;
            if (!(loc2 === null) && this.currentIcon === loc2) 
            {
                this.removeCurrentIcon(loc2);
                this.currentIcon = null;
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

        protected override function initialize():void
        {
            super.initialize();
            if (!this.keyToTrigger) 
            {
                this.keyToTrigger = new feathers.utils.keyboard.KeyToTrigger(this);
            }
            if (!this.longPress) 
            {
                this.longPress = new feathers.utils.touch.LongPress(this);
                this.longPress.tapToTrigger = this.tapToTrigger;
            }
            return;
        }

        protected override function get defaultStyleProvider():feathers.skins.IStyleProvider
        {
            return feathers.controls.Button.globalStyleProvider;
        }

        protected override function draw():void
        {
            var loc1:*=this.isInvalid(INVALIDATION_FLAG_DATA);
            var loc2:*=this.isInvalid(INVALIDATION_FLAG_STYLES);
            var loc3:*=this.isInvalid(INVALIDATION_FLAG_SIZE);
            var loc4:*=this.isInvalid(INVALIDATION_FLAG_STATE);
            var loc5:*=this.isInvalid(INVALIDATION_FLAG_TEXT_RENDERER);
            var loc6:*=this.isInvalid(INVALIDATION_FLAG_FOCUS);
            if (loc5) 
            {
                this.createLabel();
            }
            if (loc5 || loc4 || loc1) 
            {
                this.refreshLabel();
            }
            if (loc2 || loc4) 
            {
                this.refreshLongPressEvents();
                this.refreshIcon();
            }
            if (loc5 || loc2 || loc4) 
            {
                this.refreshLabelStyles();
            }
            super.draw();
            if (loc5 || loc2 || loc4 || loc1 || loc3) 
            {
                this.layoutContent();
            }
            if (loc3 || loc6) 
            {
                this.refreshFocusIndicator();
            }
            return;
        }

        protected override function autoSizeIfNeeded():Boolean
        {
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
            var loc5:*=null;
            if (!(this._label === null) && this.labelTextRenderer) 
            {
                loc5 = this.labelTextRenderer;
                this.refreshLabelTextRendererDimensions(true);
                this.labelTextRenderer.measureText(HELPER_POINT);
            }
            var loc6:*=this._gap;
            if (loc6 === Number.POSITIVE_INFINITY) 
            {
                loc6 = this._minGap;
            }
            feathers.utils.skins.resetFluidChildDimensionsForMeasurement(this.currentSkin, this._explicitWidth, this._explicitHeight, this._explicitMinWidth, this._explicitMinHeight, this._explicitMaxWidth, this._explicitMaxHeight, this._explicitSkinWidth, this._explicitSkinHeight, this._explicitSkinMinWidth, this._explicitSkinMinHeight, this._explicitSkinMaxWidth, this._explicitSkinMaxHeight);
            var loc7:*=this.currentSkin as feathers.core.IMeasureDisplayObject;
            if (this.currentIcon is feathers.core.IValidating) 
            {
                feathers.core.IValidating(this.currentIcon).validate();
            }
            if (this.currentSkin is feathers.core.IValidating) 
            {
                feathers.core.IValidating(this.currentSkin).validate();
            }
            var loc8:*=this._explicitMinWidth;
            if (loc3) 
            {
                if (loc5 === null) 
                {
                    loc8 = 0;
                }
                else 
                {
                    loc8 = HELPER_POINT.x;
                }
                if (this.currentIcon !== null) 
                {
                    if (loc5 === null) 
                    {
                        if (this.currentIcon is feathers.core.IFeathersControl) 
                        {
                            loc8 = feathers.core.IFeathersControl(this.currentIcon).minWidth;
                        }
                        else 
                        {
                            loc8 = this.currentIcon.width;
                        }
                    }
                    else if (!(this._iconPosition === feathers.layout.RelativePosition.TOP) && !(this._iconPosition === feathers.layout.RelativePosition.BOTTOM) && !(this._iconPosition === feathers.layout.RelativePosition.MANUAL)) 
                    {
                        loc8 = loc8 + loc6;
                        if (this.currentIcon is feathers.core.IFeathersControl) 
                        {
                            loc8 = loc8 + feathers.core.IFeathersControl(this.currentIcon).minWidth;
                        }
                        else 
                        {
                            loc8 = loc8 + this.currentIcon.width;
                        }
                    }
                    else if (this.currentIcon is feathers.core.IFeathersControl) 
                    {
                        loc12 = feathers.core.IFeathersControl(this.currentIcon).minWidth;
                        if (loc12 > loc8) 
                        {
                            loc8 = loc12;
                        }
                    }
                    else if (this.currentIcon.width > loc8) 
                    {
                        loc8 = this.currentIcon.width;
                    }
                }
                loc8 = loc8 + (this._paddingLeft + this._paddingRight);
                if (this.currentSkin !== null) 
                {
                    if (loc7 === null) 
                    {
                        if (this._explicitSkinMinWidth > loc8) 
                        {
                            loc8 = this._explicitSkinMinWidth;
                        }
                    }
                    else if (loc7.minWidth > loc8) 
                    {
                        loc8 = loc7.minWidth;
                    }
                }
            }
            var loc9:*=this._explicitMinHeight;
            if (loc4) 
            {
                if (loc5 === null) 
                {
                    loc9 = 0;
                }
                else 
                {
                    loc9 = HELPER_POINT.y;
                }
                if (this.currentIcon !== null) 
                {
                    if (loc5 === null) 
                    {
                        if (this.currentIcon is feathers.core.IFeathersControl) 
                        {
                            loc9 = feathers.core.IFeathersControl(this.currentIcon).minHeight;
                        }
                        else 
                        {
                            loc9 = this.currentIcon.height;
                        }
                    }
                    else if (this._iconPosition === feathers.layout.RelativePosition.TOP || this._iconPosition === feathers.layout.RelativePosition.BOTTOM) 
                    {
                        loc9 = loc9 + loc6;
                        if (this.currentIcon is feathers.core.IFeathersControl) 
                        {
                            loc9 = loc9 + feathers.core.IFeathersControl(this.currentIcon).minHeight;
                        }
                        else 
                        {
                            loc9 = loc9 + this.currentIcon.height;
                        }
                    }
                    else if (this.currentIcon is feathers.core.IFeathersControl) 
                    {
                        loc13 = feathers.core.IFeathersControl(this.currentIcon).minHeight;
                        if (loc13 > loc9) 
                        {
                            loc9 = loc13;
                        }
                    }
                    else if (this.currentIcon.height > loc9) 
                    {
                        loc9 = this.currentIcon.height;
                    }
                }
                loc9 = loc9 + (this._paddingTop + this._paddingBottom);
                if (this.currentSkin !== null) 
                {
                    if (loc7 === null) 
                    {
                        if (this._explicitSkinMinHeight > loc9) 
                        {
                            loc9 = this._explicitSkinMinHeight;
                        }
                    }
                    else if (loc7.minHeight > loc9) 
                    {
                        loc9 = loc7.minHeight;
                    }
                }
            }
            var loc10:*=this._explicitWidth;
            if (loc1) 
            {
                if (loc5 === null) 
                {
                    loc10 = 0;
                }
                else 
                {
                    loc10 = HELPER_POINT.x;
                }
                if (this.currentIcon !== null) 
                {
                    if (loc5 === null) 
                    {
                        loc10 = this.currentIcon.width;
                    }
                    else if (!(this._iconPosition === feathers.layout.RelativePosition.TOP) && !(this._iconPosition === feathers.layout.RelativePosition.BOTTOM) && !(this._iconPosition === feathers.layout.RelativePosition.MANUAL)) 
                    {
                        loc10 = loc10 + (loc6 + this.currentIcon.width);
                    }
                    else if (this.currentIcon.width > loc10) 
                    {
                        loc10 = this.currentIcon.width;
                    }
                }
                loc10 = loc10 + (this._paddingLeft + this._paddingRight);
                if (!(this.currentSkin === null) && this.currentSkin.width > loc10) 
                {
                    loc10 = this.currentSkin.width;
                }
            }
            var loc11:*=this._explicitHeight;
            if (loc2) 
            {
                if (loc5 === null) 
                {
                    loc11 = 0;
                }
                else 
                {
                    loc11 = HELPER_POINT.y;
                }
                if (this.currentIcon !== null) 
                {
                    if (loc5 === null) 
                    {
                        loc11 = this.currentIcon.height;
                    }
                    else if (this._iconPosition === feathers.layout.RelativePosition.TOP || this._iconPosition === feathers.layout.RelativePosition.BOTTOM) 
                    {
                        loc11 = loc11 + (loc6 + this.currentIcon.height);
                    }
                    else if (this.currentIcon.height > loc11) 
                    {
                        loc11 = this.currentIcon.height;
                    }
                }
                loc11 = loc11 + (this._paddingTop + this._paddingBottom);
                if (!(this.currentSkin === null) && this.currentSkin.height > loc11) 
                {
                    loc11 = this.currentSkin.height;
                }
            }
            return this.saveMeasurements(loc10, loc11, loc8, loc9);
        }

        protected override function changeState(arg1:String):void
        {
            var loc1:*=this._currentState;
            if (loc1 === arg1) 
            {
                return;
            }
            super.changeState(arg1);
            if (!(this._scaleWhenHovering === 1) && (arg1 === feathers.controls.ButtonState.HOVER || loc1 === feathers.controls.ButtonState.HOVER)) 
            {
                this.setRequiresRedraw();
            }
            else if (!(this._scaleWhenDown === 1) && (arg1 === feathers.controls.ButtonState.DOWN || loc1 === feathers.controls.ButtonState.DOWN)) 
            {
                this.setRequiresRedraw();
            }
            return;
        }

        public function get label():String
        {
            return this._label;
        }

        public function set label(arg1:String):void
        {
            if (this._label == arg1) 
            {
                return;
            }
            this._label = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        protected function createLabel():void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (this.labelTextRenderer) 
            {
                this.removeChild(starling.display.DisplayObject(this.labelTextRenderer), true);
                this.labelTextRenderer = null;
            }
            if (this._hasLabelTextRenderer) 
            {
                loc1 = this._labelFactory == null ? feathers.core.FeathersControl.defaultTextRendererFactory : this._labelFactory;
                this.labelTextRenderer = feathers.core.ITextRenderer(loc1());
                loc2 = this._customLabelStyleName == null ? this.labelStyleName : this._customLabelStyleName;
                this.labelTextRenderer.styleNameList.add(loc2);
                if (this.labelTextRenderer is feathers.core.IStateObserver) 
                {
                    feathers.core.IStateObserver(this.labelTextRenderer).stateContext = this;
                }
                this.addChild(starling.display.DisplayObject(this.labelTextRenderer));
                this._explicitLabelWidth = this.labelTextRenderer.explicitWidth;
                this._explicitLabelHeight = this.labelTextRenderer.explicitHeight;
                this._explicitLabelMinWidth = this.labelTextRenderer.explicitMinWidth;
                this._explicitLabelMinHeight = this.labelTextRenderer.explicitMinHeight;
                this._explicitLabelMaxWidth = this.labelTextRenderer.explicitMaxWidth;
                this._explicitLabelMaxHeight = this.labelTextRenderer.explicitMaxHeight;
            }
            return;
        }

        public function get hasLabelTextRenderer():Boolean
        {
            return this._hasLabelTextRenderer;
        }

        public function set hasLabelTextRenderer(arg1:Boolean):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._hasLabelTextRenderer === arg1) 
            {
                return;
            }
            this._hasLabelTextRenderer = arg1;
            this.invalidate(INVALIDATION_FLAG_TEXT_RENDERER);
            return;
        }

        protected function refreshLabel():void
        {
            if (!this.labelTextRenderer) 
            {
                return;
            }
            this.labelTextRenderer.text = this._label;
            this.labelTextRenderer.visible = !(this._label === null) && this._label.length > 0;
            this.labelTextRenderer.isEnabled = this._isEnabled;
            return;
        }

        public function get iconPosition():String
        {
            return this._iconPosition;
        }

        public function set iconPosition(arg1:String):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._iconPosition === arg1) 
            {
                return;
            }
            this._iconPosition = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
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
                if (loc1 !== null) 
                {
                    this.removeCurrentIcon(loc1);
                }
                if (this.currentIcon !== null) 
                {
                    if (this.currentIcon is feathers.core.IStateObserver) 
                    {
                        feathers.core.IStateObserver(this.currentIcon).stateContext = this;
                    }
                    loc2 = this.numChildren;
                    if (this.labelTextRenderer) 
                    {
                        loc2 = this.getChildIndex(starling.display.DisplayObject(this.labelTextRenderer));
                    }
                    this.addChildAt(this.currentIcon, loc2);
                    if (this.currentIcon is feathers.core.IFeathersControl) 
                    {
                        feathers.core.IFeathersControl(this.currentIcon).addEventListener(feathers.events.FeathersEventType.RESIZE, this.currentIcon_resizeHandler);
                    }
                }
            }
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

        protected function removeCurrentIcon(arg1:starling.display.DisplayObject):void
        {
            if (arg1 === null) 
            {
                return;
            }
            if (arg1 is feathers.core.IFeathersControl) 
            {
                feathers.core.IFeathersControl(arg1).removeEventListener(feathers.events.FeathersEventType.RESIZE, this.currentIcon_resizeHandler);
            }
            if (arg1 is feathers.core.IStateObserver) 
            {
                feathers.core.IStateObserver(arg1).stateContext = null;
            }
            if (arg1.parent === this) 
            {
                this.removeChild(arg1, false);
            }
            return;
        }

        public function get minGap():Number
        {
            return this._minGap;
        }

        public function set minGap(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._minGap === arg1) 
            {
                return;
            }
            this._minGap = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected override function getCurrentSkin():starling.display.DisplayObject
        {
            if (this._stateToSkinFunction !== null) 
            {
                return starling.display.DisplayObject(this._stateToSkinFunction(this, this._currentState, this.currentSkin));
            }
            return super.getCurrentSkin();
        }

        public function get horizontalAlign():String
        {
            return this._horizontalAlign;
        }

        public function set horizontalAlign(arg1:String):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._horizontalAlign === arg1) 
            {
                return;
            }
            this._horizontalAlign = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
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

        protected function refreshLabelStyles():void
        {
            var loc2:*=null;
            var loc3:*=null;
            if (this.labelTextRenderer === null) 
            {
                return;
            }
            this.labelTextRenderer.fontStyles = this._fontStylesSet;
            var loc1:*=this.getCurrentLabelProperties();
            var loc4:*=0;
            var loc5:*=loc1;
            for (loc2 in loc5) 
            {
                loc3 = loc1[loc2];
                this.labelTextRenderer[loc2] = loc3;
            }
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

        protected function getCurrentLabelProperties():Object
        {
            if (this._stateToLabelPropertiesFunction !== null) 
            {
                return this._stateToLabelPropertiesFunction(this, this._currentState);
            }
            var loc1:*=this._stateToLabelProperties[this._currentState];
            if (loc1 !== null) 
            {
                return loc1;
            }
            return this._defaultLabelProperties;
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

        protected override function refreshTriggeredEvents():void
        {
            super.refreshTriggeredEvents();
            this.keyToTrigger.isEnabled = this._isEnabled;
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

        protected function refreshLongPressEvents():void
        {
            this.longPress.isEnabled = this._isEnabled && this._isLongPressEnabled;
            this.longPress.longPressDuration = this._longPressDuration;
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

        protected function layoutContent():void
        {
            this.refreshLabelTextRendererDimensions(false);
            var loc1:*=null;
            if (!(this._label === null) && !(this.labelTextRenderer === null)) 
            {
                loc1 = starling.display.DisplayObject(this.labelTextRenderer);
            }
            var loc2:*=this.currentIcon && !(this._iconPosition == feathers.layout.RelativePosition.MANUAL);
            if (loc1 && loc2) 
            {
                this.positionSingleChild(loc1);
                this.positionLabelAndIcon();
            }
            else if (loc1) 
            {
                this.positionSingleChild(loc1);
            }
            else if (loc2) 
            {
                this.positionSingleChild(this.currentIcon);
            }
            if (this.currentIcon) 
            {
                if (this._iconPosition == feathers.layout.RelativePosition.MANUAL) 
                {
                    this.currentIcon.x = this._paddingLeft;
                    this.currentIcon.y = this._paddingTop;
                }
                this.currentIcon.x = this.currentIcon.x + this._iconOffsetX;
                this.currentIcon.y = this.currentIcon.y + this._iconOffsetY;
            }
            if (loc1) 
            {
                this.labelTextRenderer.x = this.labelTextRenderer.x + this._labelOffsetX;
                this.labelTextRenderer.y = this.labelTextRenderer.y + this._labelOffsetY;
            }
            return;
        }

        public function get labelOffsetX():Number
        {
            return this._labelOffsetX;
        }

        public function set labelOffsetX(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._labelOffsetX === arg1) 
            {
                return;
            }
            this._labelOffsetX = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function refreshLabelTextRendererDimensions(arg1:Boolean):void
        {
            var loc4:*=NaN;
            var loc1:*=this._ignoreIconResizes;
            this._ignoreIconResizes = true;
            if (this.currentIcon is feathers.core.IValidating) 
            {
                feathers.core.IValidating(this.currentIcon).validate();
            }
            this._ignoreIconResizes = loc1;
            if (this._label === null || this.labelTextRenderer === null) 
            {
                return;
            }
            var loc2:*=this.actualWidth;
            var loc3:*=this.actualHeight;
            if (arg1) 
            {
                loc2 = this._explicitWidth;
                if (loc2 !== loc2) 
                {
                    loc2 = this._explicitMaxWidth;
                }
                loc3 = this._explicitHeight;
                if (loc3 !== loc3) 
                {
                    loc3 = this._explicitMaxHeight;
                }
            }
            loc2 = loc2 - (this._paddingLeft + this._paddingRight);
            loc3 = loc3 - (this._paddingTop + this._paddingBottom);
            if (this.currentIcon !== null) 
            {
                loc4 = this._gap;
                if (loc4 == Number.POSITIVE_INFINITY) 
                {
                    loc4 = this._minGap;
                }
                if (this._iconPosition === feathers.layout.RelativePosition.LEFT || this._iconPosition === feathers.layout.RelativePosition.LEFT_BASELINE || this._iconPosition === feathers.layout.RelativePosition.RIGHT || this._iconPosition === feathers.layout.RelativePosition.RIGHT_BASELINE) 
                {
                    loc2 = loc2 - (this.currentIcon.width + loc4);
                }
                if (this._iconPosition === feathers.layout.RelativePosition.TOP || this._iconPosition === feathers.layout.RelativePosition.BOTTOM) 
                {
                    loc3 = loc3 - (this.currentIcon.height + loc4);
                }
            }
            if (loc2 < 0) 
            {
                loc2 = 0;
            }
            if (loc3 < 0) 
            {
                loc3 = 0;
            }
            if (loc2 > this._explicitLabelMaxWidth) 
            {
                loc2 = this._explicitLabelMaxWidth;
            }
            if (loc3 > this._explicitLabelMaxHeight) 
            {
                loc3 = this._explicitLabelMaxHeight;
            }
            if (arg1) 
            {
                this.labelTextRenderer.width = this._explicitLabelWidth;
                this.labelTextRenderer.height = this._explicitLabelHeight;
                this.labelTextRenderer.minWidth = this._explicitLabelMinWidth;
                this.labelTextRenderer.minHeight = this._explicitLabelMinHeight;
                this.labelTextRenderer.maxWidth = loc2;
                this.labelTextRenderer.maxHeight = loc3;
                this.labelTextRenderer.validate();
            }
            else 
            {
                this.labelTextRenderer.maxWidth = loc2;
                this.labelTextRenderer.maxHeight = loc3;
                this.labelTextRenderer.validate();
                loc2 = this.labelTextRenderer.width;
                loc3 = this.labelTextRenderer.height;
                this.labelTextRenderer.width = loc2;
                this.labelTextRenderer.height = loc3;
                this.labelTextRenderer.minWidth = loc2;
                this.labelTextRenderer.minHeight = loc3;
            }
            return;
        }

        public function get labelOffsetY():Number
        {
            return this._labelOffsetY;
        }

        public function set labelOffsetY(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._labelOffsetY === arg1) 
            {
                return;
            }
            this._labelOffsetY = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function positionSingleChild(arg1:starling.display.DisplayObject):void
        {
            if (this._horizontalAlign != feathers.layout.HorizontalAlign.LEFT) 
            {
                if (this._horizontalAlign != feathers.layout.HorizontalAlign.RIGHT) 
                {
                    arg1.x = this._paddingLeft + Math.round((this.actualWidth - this._paddingLeft - this._paddingRight - arg1.width) / 2);
                }
                else 
                {
                    arg1.x = this.actualWidth - this._paddingRight - arg1.width;
                }
            }
            else 
            {
                arg1.x = this._paddingLeft;
            }
            if (this._verticalAlign != feathers.layout.VerticalAlign.TOP) 
            {
                if (this._verticalAlign != feathers.layout.VerticalAlign.BOTTOM) 
                {
                    arg1.y = this._paddingTop + Math.round((this.actualHeight - this._paddingTop - this._paddingBottom - arg1.height) / 2);
                }
                else 
                {
                    arg1.y = this.actualHeight - this._paddingBottom - arg1.height;
                }
            }
            else 
            {
                arg1.y = this._paddingTop;
            }
            return;
        }

        public function get iconOffsetX():Number
        {
            return this._iconOffsetX;
        }

        public function set iconOffsetX(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._iconOffsetX === arg1) 
            {
                return;
            }
            this._iconOffsetX = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function positionLabelAndIcon():void
        {
            if (this._iconPosition != feathers.layout.RelativePosition.TOP) 
            {
                if (this._iconPosition == feathers.layout.RelativePosition.RIGHT || this._iconPosition == feathers.layout.RelativePosition.RIGHT_BASELINE) 
                {
                    if (this._gap != Number.POSITIVE_INFINITY) 
                    {
                        if (this._horizontalAlign != feathers.layout.HorizontalAlign.RIGHT) 
                        {
                            if (this._horizontalAlign == feathers.layout.HorizontalAlign.CENTER) 
                            {
                                this.labelTextRenderer.x = this.labelTextRenderer.x - Math.round((this.currentIcon.width + this._gap) / 2);
                            }
                        }
                        else 
                        {
                            this.labelTextRenderer.x = this.labelTextRenderer.x - (this.currentIcon.width + this._gap);
                        }
                        this.currentIcon.x = this.labelTextRenderer.x + this.labelTextRenderer.width + this._gap;
                    }
                    else 
                    {
                        this.labelTextRenderer.x = this._paddingLeft;
                        this.currentIcon.x = this.actualWidth - this._paddingRight - this.currentIcon.width;
                    }
                }
                else if (this._iconPosition != feathers.layout.RelativePosition.BOTTOM) 
                {
                    if (this._iconPosition == feathers.layout.RelativePosition.LEFT || this._iconPosition == feathers.layout.RelativePosition.LEFT_BASELINE) 
                    {
                        if (this._gap != Number.POSITIVE_INFINITY) 
                        {
                            if (this._horizontalAlign != feathers.layout.HorizontalAlign.LEFT) 
                            {
                                if (this._horizontalAlign == feathers.layout.HorizontalAlign.CENTER) 
                                {
                                    this.labelTextRenderer.x = this.labelTextRenderer.x + Math.round((this._gap + this.currentIcon.width) / 2);
                                }
                            }
                            else 
                            {
                                this.labelTextRenderer.x = this.labelTextRenderer.x + (this._gap + this.currentIcon.width);
                            }
                            this.currentIcon.x = this.labelTextRenderer.x - this._gap - this.currentIcon.width;
                        }
                        else 
                        {
                            this.currentIcon.x = this._paddingLeft;
                            this.labelTextRenderer.x = this.actualWidth - this._paddingRight - this.labelTextRenderer.width;
                        }
                    }
                }
                else if (this._gap != Number.POSITIVE_INFINITY) 
                {
                    if (this._verticalAlign != feathers.layout.VerticalAlign.BOTTOM) 
                    {
                        if (this._verticalAlign == feathers.layout.VerticalAlign.MIDDLE) 
                        {
                            this.labelTextRenderer.y = this.labelTextRenderer.y - Math.round((this.currentIcon.height + this._gap) / 2);
                        }
                    }
                    else 
                    {
                        this.labelTextRenderer.y = this.labelTextRenderer.y - (this.currentIcon.height + this._gap);
                    }
                    this.currentIcon.y = this.labelTextRenderer.y + this.labelTextRenderer.height + this._gap;
                }
                else 
                {
                    this.labelTextRenderer.y = this._paddingTop;
                    this.currentIcon.y = this.actualHeight - this._paddingBottom - this.currentIcon.height;
                }
            }
            else if (this._gap != Number.POSITIVE_INFINITY) 
            {
                if (this._verticalAlign != feathers.layout.VerticalAlign.TOP) 
                {
                    if (this._verticalAlign == feathers.layout.VerticalAlign.MIDDLE) 
                    {
                        this.labelTextRenderer.y = this.labelTextRenderer.y + Math.round((this.currentIcon.height + this._gap) / 2);
                    }
                }
                else 
                {
                    this.labelTextRenderer.y = this.labelTextRenderer.y + (this.currentIcon.height + this._gap);
                }
                this.currentIcon.y = this.labelTextRenderer.y - this.currentIcon.height - this._gap;
            }
            else 
            {
                this.currentIcon.y = this._paddingTop;
                this.labelTextRenderer.y = this.actualHeight - this._paddingBottom - this.labelTextRenderer.height;
            }
            if (this._iconPosition == feathers.layout.RelativePosition.LEFT || this._iconPosition == feathers.layout.RelativePosition.RIGHT) 
            {
                if (this._verticalAlign != feathers.layout.VerticalAlign.TOP) 
                {
                    if (this._verticalAlign != feathers.layout.VerticalAlign.BOTTOM) 
                    {
                        this.currentIcon.y = this._paddingTop + Math.round((this.actualHeight - this._paddingTop - this._paddingBottom - this.currentIcon.height) / 2);
                    }
                    else 
                    {
                        this.currentIcon.y = this.actualHeight - this._paddingBottom - this.currentIcon.height;
                    }
                }
                else 
                {
                    this.currentIcon.y = this._paddingTop;
                }
            }
            else if (this._iconPosition == feathers.layout.RelativePosition.LEFT_BASELINE || this._iconPosition == feathers.layout.RelativePosition.RIGHT_BASELINE) 
            {
                this.currentIcon.y = this.labelTextRenderer.y + this.labelTextRenderer.baseline - this.currentIcon.height;
            }
            else if (this._horizontalAlign != feathers.layout.HorizontalAlign.LEFT) 
            {
                if (this._horizontalAlign != feathers.layout.HorizontalAlign.RIGHT) 
                {
                    this.currentIcon.x = this._paddingLeft + Math.round((this.actualWidth - this._paddingLeft - this._paddingRight - this.currentIcon.width) / 2);
                }
                else 
                {
                    this.currentIcon.x = this.actualWidth - this._paddingRight - this.currentIcon.width;
                }
            }
            else 
            {
                this.currentIcon.x = this._paddingLeft;
            }
            return;
        }

        public function get iconOffsetY():Number
        {
            return this._iconOffsetY;
        }

        public function set iconOffsetY(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._iconOffsetY === arg1) 
            {
                return;
            }
            this._iconOffsetY = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function childProperties_onChange(arg1:feathers.core.PropertyProxy, arg2:Object):void
        {
            this.invalidate(INVALIDATION_FLAG_STYLES);
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

        protected override function focusInHandler(arg1:starling.events.Event):void
        {
            super.focusInHandler(arg1);
            this.stage.addEventListener(starling.events.KeyboardEvent.KEY_DOWN, this.stage_keyDownHandler);
            this.stage.addEventListener(starling.events.KeyboardEvent.KEY_UP, this.stage_keyUpHandler);
            return;
        }

        public function get stateToLabelPropertiesFunction():Function
        {
            return this._stateToLabelPropertiesFunction;
        }

        public function set stateToLabelPropertiesFunction(arg1:Function):void
        {
            if (this._stateToLabelPropertiesFunction == arg1) 
            {
                return;
            }
            this._stateToLabelPropertiesFunction = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function set downLabelProperties(arg1:Object):void
        {
            if (!(arg1 is feathers.core.PropertyProxy)) 
            {
                arg1 = feathers.core.PropertyProxy.fromObject(arg1);
            }
            var loc1:*=feathers.core.PropertyProxy(this._stateToLabelProperties[feathers.controls.ButtonState.DOWN]);
            if (loc1) 
            {
                loc1.removeOnChangeCallback(this.childProperties_onChange);
            }
            this._stateToLabelProperties[feathers.controls.ButtonState.DOWN] = arg1;
            if (arg1) 
            {
                feathers.core.PropertyProxy(arg1).addOnChangeCallback(this.childProperties_onChange);
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
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
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected override function focusOutHandler(arg1:starling.events.Event):void
        {
            super.focusOutHandler(arg1);
            this.stage.removeEventListener(starling.events.KeyboardEvent.KEY_DOWN, this.stage_keyDownHandler);
            this.stage.removeEventListener(starling.events.KeyboardEvent.KEY_UP, this.stage_keyUpHandler);
            if (this.touchPointID >= 0) 
            {
                this.touchPointID = -1;
                if (this._isEnabled) 
                {
                    this.changeState(feathers.controls.ButtonState.UP);
                }
                else 
                {
                    this.changeState(feathers.controls.ButtonState.DISABLED);
                }
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

        protected function stage_keyDownHandler(arg1:starling.events.KeyboardEvent):void
        {
            if (arg1.keyCode === flash.ui.Keyboard.ESCAPE) 
            {
                this.touchPointID = -1;
                this.changeState(feathers.controls.ButtonState.UP);
            }
            if (this.touchPointID >= 0 || !(arg1.keyCode === flash.ui.Keyboard.SPACE)) 
            {
                return;
            }
            this.touchPointID = int.MAX_VALUE;
            this.changeState(feathers.controls.ButtonState.DOWN);
            return;
        }

        public function get labelFactory():Function
        {
            return this._labelFactory;
        }

        public function set labelFactory(arg1:Function):void
        {
            if (this._labelFactory == arg1) 
            {
                return;
            }
            this._labelFactory = arg1;
            this.invalidate(INVALIDATION_FLAG_TEXT_RENDERER);
            return;
        }

        protected function stage_keyUpHandler(arg1:starling.events.KeyboardEvent):void
        {
            if (!(this.touchPointID === int.MAX_VALUE) || !(arg1.keyCode === flash.ui.Keyboard.SPACE)) 
            {
                return;
            }
            this.resetTouchState();
            return;
        }

        public function get customLabelStyleName():String
        {
            return this._customLabelStyleName;
        }

        public function set customLabelStyleName(arg1:String):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._customLabelStyleName === arg1) 
            {
                return;
            }
            this._customLabelStyleName = arg1;
            this.invalidate(INVALIDATION_FLAG_TEXT_RENDERER);
            return;
        }

        protected function currentIcon_resizeHandler():void
        {
            if (this._ignoreIconResizes) 
            {
                return;
            }
            this.invalidate(INVALIDATION_FLAG_SIZE);
            return;
        }

        public function get defaultLabelProperties():Object
        {
            if (this._defaultLabelProperties === null) 
            {
                this._defaultLabelProperties = new feathers.core.PropertyProxy(this.childProperties_onChange);
            }
            return this._defaultLabelProperties;
        }

        public function set defaultLabelProperties(arg1:Object):void
        {
            if (!(arg1 is feathers.core.PropertyProxy)) 
            {
                arg1 = feathers.core.PropertyProxy.fromObject(arg1);
            }
            if (this._defaultLabelProperties !== null) 
            {
                this._defaultLabelProperties.removeOnChangeCallback(this.childProperties_onChange);
            }
            this._defaultLabelProperties = feathers.core.PropertyProxy(arg1);
            if (this._defaultLabelProperties !== null) 
            {
                this._defaultLabelProperties.addOnChangeCallback(this.childProperties_onChange);
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function fontStyles_changeHandler(arg1:starling.events.Event):void
        {
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get upLabelProperties():Object
        {
            var loc1:*=feathers.core.PropertyProxy(this._stateToLabelProperties[feathers.controls.ButtonState.UP]);
            if (!loc1) 
            {
                loc1 = new feathers.core.PropertyProxy(this.childProperties_onChange);
                this._stateToLabelProperties[feathers.controls.ButtonState.UP] = loc1;
            }
            return loc1;
        }

        public function set upLabelProperties(arg1:Object):void
        {
            if (!(arg1 is feathers.core.PropertyProxy)) 
            {
                arg1 = feathers.core.PropertyProxy.fromObject(arg1);
            }
            var loc1:*=feathers.core.PropertyProxy(this._stateToLabelProperties[feathers.controls.ButtonState.UP]);
            if (loc1) 
            {
                loc1.removeOnChangeCallback(this.childProperties_onChange);
            }
            this._stateToLabelProperties[feathers.controls.ButtonState.UP] = arg1;
            if (arg1) 
            {
                feathers.core.PropertyProxy(arg1).addOnChangeCallback(this.childProperties_onChange);
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get downLabelProperties():Object
        {
            var loc1:*=feathers.core.PropertyProxy(this._stateToLabelProperties[feathers.controls.ButtonState.DOWN]);
            if (!loc1) 
            {
                loc1 = new feathers.core.PropertyProxy(this.childProperties_onChange);
                this._stateToLabelProperties[feathers.controls.ButtonState.DOWN] = loc1;
            }
            return loc1;
        }

        public function get isLongPressEnabled():Boolean
        {
            return this._isLongPressEnabled;
        }

        public function get hoverLabelProperties():Object
        {
            var loc1:*=feathers.core.PropertyProxy(this._stateToLabelProperties[feathers.controls.ButtonState.HOVER]);
            if (!loc1) 
            {
                loc1 = new feathers.core.PropertyProxy(this.childProperties_onChange);
                this._stateToLabelProperties[feathers.controls.ButtonState.HOVER] = loc1;
            }
            return loc1;
        }

        public function set hoverLabelProperties(arg1:Object):void
        {
            if (!(arg1 is feathers.core.PropertyProxy)) 
            {
                arg1 = feathers.core.PropertyProxy.fromObject(arg1);
            }
            var loc1:*=feathers.core.PropertyProxy(this._stateToLabelProperties[feathers.controls.ButtonState.HOVER]);
            if (loc1) 
            {
                loc1.removeOnChangeCallback(this.childProperties_onChange);
            }
            this._stateToLabelProperties[feathers.controls.ButtonState.HOVER] = arg1;
            if (arg1) 
            {
                feathers.core.PropertyProxy(arg1).addOnChangeCallback(this.childProperties_onChange);
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get disabledLabelProperties():Object
        {
            var loc1:*=feathers.core.PropertyProxy(this._stateToLabelProperties[feathers.controls.ButtonState.DISABLED]);
            if (!loc1) 
            {
                loc1 = new feathers.core.PropertyProxy(this.childProperties_onChange);
                this._stateToLabelProperties[feathers.controls.ButtonState.DISABLED] = loc1;
            }
            return loc1;
        }

        public function set disabledLabelProperties(arg1:Object):void
        {
            if (!(arg1 is feathers.core.PropertyProxy)) 
            {
                arg1 = feathers.core.PropertyProxy.fromObject(arg1);
            }
            var loc1:*=feathers.core.PropertyProxy(this._stateToLabelProperties[feathers.controls.ButtonState.DISABLED]);
            if (loc1) 
            {
                loc1.removeOnChangeCallback(this.childProperties_onChange);
            }
            this._stateToLabelProperties[feathers.controls.ButtonState.DISABLED] = arg1;
            if (arg1) 
            {
                feathers.core.PropertyProxy(arg1).addOnChangeCallback(this.childProperties_onChange);
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get defaultIcon():starling.display.DisplayObject
        {
            return this._defaultIcon;
        }

        public function set defaultIcon(arg1:starling.display.DisplayObject):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                if (arg1 !== null) 
                {
                    arg1.dispose();
                }
                return;
            }
            if (this._defaultIcon === arg1) 
            {
                return;
            }
            if (!(this._defaultIcon === null) && this.currentIcon === this._defaultIcon) 
            {
                this.removeCurrentIcon(this._defaultIcon);
                this.currentIcon = null;
            }
            this._defaultIcon = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get upIcon():starling.display.DisplayObject
        {
            return this.getIconForState(feathers.controls.ButtonState.UP);
        }

        public function set upIcon(arg1:starling.display.DisplayObject):void
        {
            return this.setIconForState(feathers.controls.ButtonState.UP, arg1);
        }

        public function get downIcon():starling.display.DisplayObject
        {
            return this.getIconForState(feathers.controls.ButtonState.DOWN);
        }

        public function set downIcon(arg1:starling.display.DisplayObject):void
        {
            return this.setIconForState(feathers.controls.ButtonState.DOWN, arg1);
        }

        public function get hoverIcon():starling.display.DisplayObject
        {
            return this.getIconForState(feathers.controls.ButtonState.HOVER);
        }

        public function set hoverIcon(arg1:starling.display.DisplayObject):void
        {
            return this.setIconForState(feathers.controls.ButtonState.HOVER, arg1);
        }

        public function get disabledIcon():starling.display.DisplayObject
        {
            return this.getIconForState(feathers.controls.ButtonState.DISABLED);
        }

        public function set disabledIcon(arg1:starling.display.DisplayObject):void
        {
            return this.setIconForState(feathers.controls.ButtonState.DISABLED, arg1);
        }

        public function get longPressDuration():Number
        {
            return this._longPressDuration;
        }

        public function set longPressDuration(arg1:Number):void
        {
            if (this._longPressDuration === arg1) 
            {
                return;
            }
            this._longPressDuration = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function set isLongPressEnabled(arg1:Boolean):void
        {
            if (this._isLongPressEnabled === arg1) 
            {
                return;
            }
            this._isLongPressEnabled = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get scaleWhenDown():Number
        {
            return this._scaleWhenDown;
        }

        public function set scaleWhenDown(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._scaleWhenDown === arg1) 
            {
                return;
            }
            this._scaleWhenDown = arg1;
            return;
        }

        public function get scaleWhenHovering():Number
        {
            return this._scaleWhenHovering;
        }

        public static const ICON_POSITION_LEFT_BASELINE:String="leftBaseline";

        internal static const HELPER_POINT:flash.geom.Point=new flash.geom.Point();

        public static const DEFAULT_CHILD_STYLE_NAME_LABEL:String="feathers-button-label";

        public static const ALTERNATE_STYLE_NAME_CALL_TO_ACTION_BUTTON:String="feathers-call-to-action-button";

        public static const ALTERNATE_STYLE_NAME_QUIET_BUTTON:String="feathers-quiet-button";

        public static const ALTERNATE_STYLE_NAME_DANGER_BUTTON:String="feathers-danger-button";

        public static const ALTERNATE_STYLE_NAME_BACK_BUTTON:String="feathers-back-button";

        public static const ALTERNATE_STYLE_NAME_FORWARD_BUTTON:String="feathers-forward-button";

        public static const STATE_UP:String="up";

        public static const STATE_DOWN:String="down";

        public static const STATE_HOVER:String="hover";

        public static const STATE_DISABLED:String="disabled";

        public static const ICON_POSITION_TOP:String="top";

        public static const ICON_POSITION_RIGHT:String="right";

        public static const ICON_POSITION_BOTTOM:String="bottom";

        public static const ICON_POSITION_LEFT:String="left";

        public static const ICON_POSITION_MANUAL:String="manual";

        public static const ICON_POSITION_RIGHT_BASELINE:String="rightBaseline";

        public static const HORIZONTAL_ALIGN_LEFT:String="left";

        public static const HORIZONTAL_ALIGN_CENTER:String="center";

        public static const HORIZONTAL_ALIGN_RIGHT:String="right";

        public static const VERTICAL_ALIGN_TOP:String="top";

        public static const VERTICAL_ALIGN_MIDDLE:String="middle";

        public static const VERTICAL_ALIGN_BOTTOM:String="bottom";

        protected var _labelOffsetY:Number=0;

        protected var _iconOffsetX:Number=0;

        protected var _stateToIconFunction:Function;

        protected var _stateToLabelPropertiesFunction:Function;

        protected var _fontStylesSet:feathers.text.FontStylesSet;

        protected var _labelFactory:Function;

        protected var _customLabelStyleName:String;

        protected var _defaultLabelProperties:feathers.core.PropertyProxy;

        protected var _stateToLabelProperties:Object;

        protected var currentIcon:starling.display.DisplayObject;

        protected var _scaleWhenDown:Number=1;

        protected var _defaultIcon:starling.display.DisplayObject;

        protected var _stateToIcon:Object;

        protected var _scaleWhenHovering:Number=1;

        protected var _isLongPressEnabled:Boolean=false;

        protected var _stateToSkinFunction:Function;

        protected var _longPressDuration:Number=0.5;

        protected var _ignoreIconResizes:Boolean=false;

        protected var labelStyleName:String="feathers-button-label";

        protected var labelTextRenderer:feathers.core.ITextRenderer;

        protected var _explicitLabelWidth:Number;

        protected var _explicitLabelHeight:Number;

        protected var _explicitLabelMinWidth:Number;

        protected var _explicitLabelMinHeight:Number;

        protected var _explicitLabelMaxWidth:Number;

        protected var _explicitLabelMaxHeight:Number;

        protected var keyToTrigger:feathers.utils.keyboard.KeyToTrigger;

        protected var longPress:feathers.utils.touch.LongPress;

        protected var _label:String=null;

        protected var _hasLabelTextRenderer:Boolean=true;

        protected var _iconPosition:String="left";

        protected var _gap:Number=0;

        protected var _minGap:Number=0;

        protected var _iconOffsetY:Number=0;

        protected var _horizontalAlign:String="center";

        protected var _verticalAlign:String="middle";

        protected var _paddingTop:Number=0;

        protected var _paddingRight:Number=0;

        protected var _paddingBottom:Number=0;

        protected var _paddingLeft:Number=0;

        protected var _labelOffsetX:Number=0;

        public static var globalStyleProvider:feathers.skins.IStyleProvider;
    }
}


