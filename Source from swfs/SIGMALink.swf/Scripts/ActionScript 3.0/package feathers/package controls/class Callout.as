//class Callout
package feathers.controls 
{
    import __AS3__.vec.*;
    import feathers.core.*;
    import feathers.events.*;
    import feathers.layout.*;
    import feathers.skins.*;
    import feathers.utils.display.*;
    import feathers.utils.skins.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.ui.*;
    import starling.core.*;
    import starling.display.*;
    import starling.events.*;
    import starling.utils.*;
    
    public class Callout extends feathers.core.FeathersControl
    {
        public function Callout()
        {
            super();
            this.addEventListener(starling.events.Event.ADDED_TO_STAGE, this.callout_addedToStageHandler);
            return;
        }

        public function get bottomArrowGap():Number
        {
            return this._bottomArrowGap;
        }

        public function set bottomArrowGap(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._bottomArrowGap === arg1) 
            {
                return;
            }
            this._bottomArrowGap = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get rightArrowGap():Number
        {
            return this._rightArrowGap;
        }

        public function set rightArrowGap(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._rightArrowGap === arg1) 
            {
                return;
            }
            this._rightArrowGap = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get leftArrowGap():Number
        {
            return this._leftArrowGap;
        }

        public function set leftArrowGap(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._leftArrowGap === arg1) 
            {
                return;
            }
            this._leftArrowGap = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected override function get defaultStyleProvider():feathers.skins.IStyleProvider
        {
            return feathers.controls.Callout.globalStyleProvider;
        }

        public function get arrowOffset():Number
        {
            return this._arrowOffset;
        }

        public override function dispose():void
        {
            this.origin = null;
            var loc1:*=this._content;
            this.content = null;
            if (!(loc1 === null) && this.disposeContent) 
            {
                loc1.dispose();
            }
            super.dispose();
            return;
        }

        public function close(arg1:Boolean=false):void
        {
            if (this.parent) 
            {
                this.removeFromParent(false);
                this.dispatchEventWith(starling.events.Event.CLOSE);
            }
            if (arg1) 
            {
                this.dispose();
            }
            return;
        }

        protected override function initialize():void
        {
            this.addEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.callout_removedFromStageHandler);
            return;
        }

        protected override function draw():void
        {
            var loc1:*=this.isInvalid(INVALIDATION_FLAG_DATA);
            var loc2:*=this.isInvalid(INVALIDATION_FLAG_SIZE);
            var loc3:*=this.isInvalid(INVALIDATION_FLAG_STATE);
            var loc4:*=this.isInvalid(INVALIDATION_FLAG_STYLES);
            var loc5:*=this.isInvalid(INVALIDATION_FLAG_ORIGIN);
            if (loc2) 
            {
                this._lastGlobalBoundsOfOrigin = null;
                loc5 = true;
            }
            if (loc5) 
            {
                this.positionRelativeToOrigin();
            }
            if (loc4 || loc3) 
            {
                this.refreshArrowSkin();
            }
            if (loc3 || loc1) 
            {
                this.refreshEnabled();
            }
            loc2 = this.autoSizeIfNeeded() || loc2;
            this.layoutChildren();
            return;
        }

        protected function autoSizeIfNeeded():Boolean
        {
            return this.measureWithArrowPosition(this._arrowPosition);
        }

        protected function measureWithArrowPosition(arg1:String):Boolean
        {
            var loc18:*=NaN;
            var loc19:*=NaN;
            var loc20:*=NaN;
            var loc21:*=NaN;
            var loc22:*=NaN;
            var loc23:*=NaN;
            var loc24:*=NaN;
            var loc25:*=NaN;
            var loc26:*=NaN;
            var loc27:*=NaN;
            var loc28:*=NaN;
            var loc29:*=NaN;
            var loc30:*=NaN;
            var loc31:*=NaN;
            var loc1:*=!(this._explicitWidth === this._explicitWidth);
            var loc2:*=!(this._explicitHeight === this._explicitHeight);
            var loc3:*=!(this._explicitMinWidth === this._explicitMinWidth);
            var loc4:*=!(this._explicitMinHeight === this._explicitMinHeight);
            if (!loc1 && !loc2 && !loc3 && !loc4) 
            {
                return false;
            }
            if (this._backgroundSkin !== null) 
            {
                loc18 = this._backgroundSkin.width;
                loc19 = this._backgroundSkin.height;
            }
            var loc5:*=this._backgroundSkin as feathers.core.IMeasureDisplayObject;
            feathers.utils.skins.resetFluidChildDimensionsForMeasurement(this._backgroundSkin, this._explicitWidth, this._explicitHeight, this._explicitMinWidth, this._explicitMinHeight, this._explicitMaxWidth, this._explicitMaxHeight, this._explicitBackgroundSkinWidth, this._explicitBackgroundSkinHeight, this._explicitBackgroundSkinMinWidth, this._explicitBackgroundSkinMinHeight, this._explicitBackgroundSkinMaxWidth, this._explicitBackgroundSkinMaxHeight);
            if (this._backgroundSkin is feathers.core.IValidating) 
            {
                feathers.core.IValidating(this._backgroundSkin).validate();
            }
            var loc6:*=0;
            var loc7:*=0;
            if (arg1 === feathers.layout.RelativePosition.LEFT && !(this._leftArrowSkin === null)) 
            {
                loc6 = this._leftArrowSkin.width + this._leftArrowGap;
                loc7 = this._leftArrowSkin.height;
            }
            else if (arg1 === feathers.layout.RelativePosition.RIGHT && !(this._rightArrowSkin === null)) 
            {
                loc6 = this._rightArrowSkin.width + this._rightArrowGap;
                loc7 = this._rightArrowSkin.height;
            }
            var loc8:*=0;
            var loc9:*=0;
            if (arg1 === feathers.layout.RelativePosition.TOP && !(this._topArrowSkin === null)) 
            {
                loc8 = this._topArrowSkin.width;
                loc9 = this._topArrowSkin.height + this._topArrowGap;
            }
            else if (arg1 === feathers.layout.RelativePosition.BOTTOM && !(this._bottomArrowSkin === null)) 
            {
                loc8 = this._bottomArrowSkin.width;
                loc9 = this._bottomArrowSkin.height + this._bottomArrowGap;
            }
            var loc10:*=this._ignoreContentResize;
            this._ignoreContentResize = true;
            var loc11:*=this._content as feathers.core.IMeasureDisplayObject;
            feathers.utils.skins.resetFluidChildDimensionsForMeasurement(this._content, this._explicitWidth - loc6 - this._paddingLeft - this._paddingRight, this._explicitHeight - loc9 - this._paddingTop - this._paddingBottom, this._explicitMinWidth - loc6 - this._paddingLeft - this._paddingRight, this._explicitMinHeight - loc9 - this._paddingTop - this._paddingBottom, this._explicitMaxWidth - loc7 - this._paddingLeft - this._paddingRight, this._explicitMaxHeight - loc9 - this._paddingTop - this._paddingBottom, this._explicitContentWidth, this._explicitContentHeight, this._explicitContentMinWidth, this._explicitContentMinHeight, this._explicitContentMaxWidth, this._explicitContentMaxHeight);
            if (loc11 !== null) 
            {
                loc20 = this._explicitMaxWidth - this._paddingLeft - this._paddingRight;
                if (loc20 < loc11.maxWidth) 
                {
                    loc11.maxWidth = loc20;
                }
                loc21 = this._explicitMaxHeight - this._paddingTop - this._paddingBottom;
                if (loc21 < loc11.maxHeight) 
                {
                    loc11.maxHeight = loc21;
                }
            }
            if (this._content is feathers.core.IValidating) 
            {
                feathers.core.IValidating(this._content).validate();
            }
            this._ignoreContentResize = loc10;
            var loc12:*=this._explicitMaxWidth;
            var loc13:*=this._explicitMaxHeight;
            if (this.stage !== null) 
            {
                loc22 = this.stage.stageWidth - stagePaddingLeft - stagePaddingRight;
                if (loc12 > loc22) 
                {
                    loc12 = loc22;
                }
                loc23 = this.stage.stageHeight - stagePaddingTop - stagePaddingBottom;
                if (loc13 > loc23) 
                {
                    loc13 = loc23;
                }
            }
            var loc14:*=this._explicitWidth;
            if (loc1) 
            {
                loc24 = 0;
                if (this._content !== null) 
                {
                    loc24 = this._content.width;
                }
                if (loc8 > loc24) 
                {
                    loc24 = loc8;
                }
                loc14 = loc24 + this._paddingLeft + this._paddingRight;
                loc25 = 0;
                if (this._backgroundSkin !== null) 
                {
                    loc25 = this._backgroundSkin.width;
                }
                if (loc25 > loc14) 
                {
                    loc14 = loc25;
                }
                loc14 = loc14 + loc6;
                if (loc14 > loc12) 
                {
                    loc14 = loc12;
                }
            }
            var loc15:*=this._explicitHeight;
            if (loc2) 
            {
                loc26 = 0;
                if (this._content !== null) 
                {
                    loc26 = this._content.height;
                }
                if (loc7 > loc24) 
                {
                    loc26 = loc7;
                }
                loc15 = loc26 + this._paddingTop + this._paddingBottom;
                loc27 = 0;
                if (this._backgroundSkin !== null) 
                {
                    loc27 = this._backgroundSkin.height;
                }
                if (loc27 > loc15) 
                {
                    loc15 = loc27;
                }
                loc15 = loc15 + loc9;
                if (loc15 > loc13) 
                {
                    loc15 = loc13;
                }
            }
            var loc16:*=this._explicitMinWidth;
            if (loc3) 
            {
                loc28 = 0;
                if (loc11 === null) 
                {
                    if (this._content !== null) 
                    {
                        loc28 = this._content.width;
                    }
                }
                else 
                {
                    loc28 = loc11.minWidth;
                }
                if (loc8 > loc28) 
                {
                    loc28 = loc8;
                }
                loc16 = loc28 + this._paddingLeft + this._paddingRight;
                loc29 = 0;
                if (loc5 === null) 
                {
                    if (this._backgroundSkin !== null) 
                    {
                        loc29 = this._explicitBackgroundSkinMinWidth;
                    }
                }
                else 
                {
                    loc29 = loc5.minWidth;
                }
                if (loc29 > loc16) 
                {
                    loc16 = loc29;
                }
                loc16 = loc16 + loc6;
                if (loc16 > loc12) 
                {
                    loc16 = loc12;
                }
            }
            var loc17:*=this._explicitHeight;
            if (loc4) 
            {
                loc30 = 0;
                if (loc11 === null) 
                {
                    if (this._content !== null) 
                    {
                        loc30 = this._content.height;
                    }
                }
                else 
                {
                    loc30 = loc11.minHeight;
                }
                if (loc7 > loc30) 
                {
                    loc30 = loc7;
                }
                loc17 = loc30 + this._paddingTop + this._paddingBottom;
                loc31 = 0;
                if (loc5 === null) 
                {
                    if (this._backgroundSkin !== null) 
                    {
                        loc31 = this._explicitBackgroundSkinMinHeight;
                    }
                }
                else 
                {
                    loc31 = loc5.minHeight;
                }
                if (loc31 > loc17) 
                {
                    loc17 = loc31;
                }
                loc17 = loc17 + loc9;
                if (loc17 > loc13) 
                {
                    loc17 = loc13;
                }
            }
            if (this._backgroundSkin !== null) 
            {
                this._backgroundSkin.width = loc18;
                this._backgroundSkin.height = loc19;
            }
            return this.saveMeasurements(loc14, loc15, loc16, loc17);
        }

        protected function refreshArrowSkin():void
        {
            this.currentArrowSkin = null;
            if (this._arrowPosition != feathers.layout.RelativePosition.BOTTOM) 
            {
                if (this._bottomArrowSkin) 
                {
                    this._bottomArrowSkin.visible = false;
                }
            }
            else 
            {
                this.currentArrowSkin = this._bottomArrowSkin;
            }
            if (this._arrowPosition != feathers.layout.RelativePosition.TOP) 
            {
                if (this._topArrowSkin) 
                {
                    this._topArrowSkin.visible = false;
                }
            }
            else 
            {
                this.currentArrowSkin = this._topArrowSkin;
            }
            if (this._arrowPosition != feathers.layout.RelativePosition.LEFT) 
            {
                if (this._leftArrowSkin) 
                {
                    this._leftArrowSkin.visible = false;
                }
            }
            else 
            {
                this.currentArrowSkin = this._leftArrowSkin;
            }
            if (this._arrowPosition != feathers.layout.RelativePosition.RIGHT) 
            {
                if (this._rightArrowSkin) 
                {
                    this._rightArrowSkin.visible = false;
                }
            }
            else 
            {
                this.currentArrowSkin = this._rightArrowSkin;
            }
            if (this.currentArrowSkin) 
            {
                this.currentArrowSkin.visible = true;
            }
            return;
        }

        protected function refreshEnabled():void
        {
            if (this._content is feathers.core.IFeathersControl) 
            {
                feathers.core.IFeathersControl(this._content).isEnabled = this._isEnabled;
            }
            return;
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
            this._lastGlobalBoundsOfOrigin = null;
            this.invalidate(INVALIDATION_FLAG_ORIGIN);
            return;
        }

        protected function layoutChildren():void
        {
            var loc7:*=NaN;
            var loc8:*=NaN;
            var loc9:*=NaN;
            var loc10:*=NaN;
            var loc11:*=NaN;
            var loc12:*=NaN;
            var loc13:*=NaN;
            var loc14:*=NaN;
            var loc15:*=NaN;
            var loc16:*=NaN;
            var loc17:*=NaN;
            var loc18:*=NaN;
            var loc19:*=NaN;
            var loc20:*=NaN;
            var loc21:*=false;
            var loc1:*=0;
            if (!(this._leftArrowSkin === null) && this._arrowPosition === feathers.layout.RelativePosition.LEFT) 
            {
                loc1 = this._leftArrowSkin.width + this._leftArrowGap;
            }
            var loc2:*=0;
            if (!(this._topArrowSkin === null) && this._arrowPosition === feathers.layout.RelativePosition.TOP) 
            {
                loc2 = this._topArrowSkin.height + this._topArrowGap;
            }
            var loc3:*=0;
            if (!(this._rightArrowSkin === null) && this._arrowPosition === feathers.layout.RelativePosition.RIGHT) 
            {
                loc3 = this._rightArrowSkin.width + this._rightArrowGap;
            }
            var loc4:*=0;
            if (!(this._bottomArrowSkin === null) && this._arrowPosition === feathers.layout.RelativePosition.BOTTOM) 
            {
                loc4 = this._bottomArrowSkin.height + this._bottomArrowGap;
            }
            var loc5:*=this.actualWidth - loc1 - loc3;
            var loc6:*=this.actualHeight - loc2 - loc4;
            if (this._backgroundSkin !== null) 
            {
                this._backgroundSkin.x = loc1;
                this._backgroundSkin.y = loc2;
                this._backgroundSkin.width = loc5;
                this._backgroundSkin.height = loc6;
            }
            if (this.currentArrowSkin !== null) 
            {
                loc7 = loc5 - this._paddingLeft - this._paddingRight;
                loc8 = loc6 - this._paddingTop - this._paddingBottom;
                if (this._arrowPosition !== feathers.layout.RelativePosition.LEFT) 
                {
                    if (this._arrowPosition !== feathers.layout.RelativePosition.RIGHT) 
                    {
                        if (this._arrowPosition !== feathers.layout.RelativePosition.BOTTOM) 
                        {
                            loc18 = this._arrowOffset + loc1 + this._paddingLeft;
                            if (this._horizontalAlign !== feathers.layout.HorizontalAlign.CENTER) 
                            {
                                if (this._horizontalAlign === feathers.layout.HorizontalAlign.RIGHT) 
                                {
                                    loc18 = loc18 + (loc7 - this._topArrowSkin.width);
                                }
                            }
                            else 
                            {
                                loc18 = loc18 + Math.round((loc7 - this._topArrowSkin.width) / 2);
                            }
                            loc19 = loc1 + this._paddingLeft;
                            if (loc19 > loc18) 
                            {
                                loc18 = loc19;
                            }
                            else 
                            {
                                loc20 = loc1 + this._paddingLeft + loc7 - this._topArrowSkin.width;
                                if (loc20 < loc18) 
                                {
                                    loc18 = loc20;
                                }
                            }
                            this._topArrowSkin.x = loc18;
                            this._topArrowSkin.y = loc2 - this._topArrowSkin.height - this._topArrowGap;
                        }
                        else 
                        {
                            loc15 = this._arrowOffset + loc1 + this._paddingLeft;
                            if (this._horizontalAlign !== feathers.layout.HorizontalAlign.CENTER) 
                            {
                                if (this._horizontalAlign === feathers.layout.HorizontalAlign.RIGHT) 
                                {
                                    loc15 = loc15 + (loc7 - this._bottomArrowSkin.width);
                                }
                            }
                            else 
                            {
                                loc15 = loc15 + Math.round((loc7 - this._bottomArrowSkin.width) / 2);
                            }
                            loc16 = loc1 + this._paddingLeft;
                            if (loc16 > loc15) 
                            {
                                loc15 = loc16;
                            }
                            else 
                            {
                                loc17 = loc1 + this._paddingLeft + loc7 - this._bottomArrowSkin.width;
                                if (loc17 < loc15) 
                                {
                                    loc15 = loc17;
                                }
                            }
                            this._bottomArrowSkin.x = loc15;
                            this._bottomArrowSkin.y = loc2 + loc6 + this._bottomArrowGap;
                        }
                    }
                    else 
                    {
                        this._rightArrowSkin.x = loc1 + loc5 + this._rightArrowGap;
                        loc12 = this._arrowOffset + loc2 + this._paddingTop;
                        if (this._verticalAlign !== feathers.layout.VerticalAlign.MIDDLE) 
                        {
                            if (this._verticalAlign === feathers.layout.VerticalAlign.BOTTOM) 
                            {
                                loc12 = loc12 + (loc8 - this._rightArrowSkin.height);
                            }
                        }
                        else 
                        {
                            loc12 = loc12 + Math.round((loc8 - this._rightArrowSkin.height) / 2);
                        }
                        loc13 = loc2 + this._paddingTop;
                        if (loc13 > loc12) 
                        {
                            loc12 = loc13;
                        }
                        else 
                        {
                            loc14 = loc2 + this._paddingTop + loc8 - this._rightArrowSkin.height;
                            if (loc14 < loc12) 
                            {
                                loc12 = loc14;
                            }
                        }
                        this._rightArrowSkin.y = loc12;
                    }
                }
                else 
                {
                    this._leftArrowSkin.x = loc1 - this._leftArrowSkin.width - this._leftArrowGap;
                    loc9 = this._arrowOffset + loc2 + this._paddingTop;
                    if (this._verticalAlign !== feathers.layout.VerticalAlign.MIDDLE) 
                    {
                        if (this._verticalAlign === feathers.layout.VerticalAlign.BOTTOM) 
                        {
                            loc9 = loc9 + (loc8 - this._leftArrowSkin.height);
                        }
                    }
                    else 
                    {
                        loc9 = loc9 + Math.round((loc8 - this._leftArrowSkin.height) / 2);
                    }
                    loc10 = loc2 + this._paddingTop;
                    if (loc10 > loc9) 
                    {
                        loc9 = loc10;
                    }
                    else 
                    {
                        loc11 = loc2 + this._paddingTop + loc8 - this._leftArrowSkin.height;
                        if (loc11 < loc9) 
                        {
                            loc9 = loc11;
                        }
                    }
                    this._leftArrowSkin.y = loc9;
                }
            }
            if (this._content !== null) 
            {
                this._content.x = loc1 + this._paddingLeft;
                this._content.y = loc2 + this._paddingTop;
                loc21 = this._ignoreContentResize;
                this._ignoreContentResize = true;
                this._content.width = loc5 - this._paddingLeft - this._paddingRight;
                this._content.height = loc6 - this._paddingTop - this._paddingBottom;
                if (this._content is feathers.core.IValidating) 
                {
                    feathers.core.IValidating(this._content).validate();
                }
                this._ignoreContentResize = loc21;
            }
            return;
        }

        protected function positionRelativeToOrigin():void
        {
            var loc11:*=null;
            if (this._origin === null) 
            {
                return;
            }
            var loc1:*=this.stage === null ? starling.core.Starling.current.stage : this.stage;
            var loc2:*=starling.utils.Pool.getRectangle();
            this._origin.getBounds(loc1, loc2);
            var loc3:*=!(this._lastGlobalBoundsOfOrigin == null);
            if (loc3 && this._lastGlobalBoundsOfOrigin.equals(loc2)) 
            {
                starling.utils.Pool.putRectangle(loc2);
                return;
            }
            if (!loc3) 
            {
                this._lastGlobalBoundsOfOrigin = new flash.geom.Rectangle();
            }
            this._lastGlobalBoundsOfOrigin.x = loc2.x;
            this._lastGlobalBoundsOfOrigin.y = loc2.y;
            this._lastGlobalBoundsOfOrigin.width = loc2.width;
            this._lastGlobalBoundsOfOrigin.height = loc2.height;
            starling.utils.Pool.putRectangle(loc2);
            var loc4:*=this._supportedPositions;
            if (loc4 === null) 
            {
                loc4 = DEFAULT_POSITIONS;
            }
            var loc5:*=-1;
            var loc6:*=-1;
            var loc7:*=-1;
            var loc8:*=-1;
            var loc9:*=loc4.length;
            var loc10:*=0;
            while (loc10 < loc9) 
            {
                loc11 = loc4[loc10];
                var loc12:*=loc11;
                switch (loc12) 
                {
                    case feathers.layout.RelativePosition.TOP:
                    {
                        this.measureWithArrowPosition(feathers.layout.RelativePosition.BOTTOM);
                        loc5 = this._lastGlobalBoundsOfOrigin.y - this.actualHeight;
                        if (loc5 >= stagePaddingTop) 
                        {
                            positionAboveOrigin(this, this._lastGlobalBoundsOfOrigin);
                            return;
                        }
                        if (loc5 < 0) 
                        {
                            loc5 = 0;
                        }
                        break;
                    }
                    case feathers.layout.RelativePosition.RIGHT:
                    {
                        this.measureWithArrowPosition(feathers.layout.RelativePosition.LEFT);
                        loc6 = loc1.stageWidth - actualWidth - (this._lastGlobalBoundsOfOrigin.x + this._lastGlobalBoundsOfOrigin.width);
                        if (loc6 >= stagePaddingRight) 
                        {
                            positionToRightOfOrigin(this, this._lastGlobalBoundsOfOrigin);
                            return;
                        }
                        if (loc6 < 0) 
                        {
                            loc6 = 0;
                        }
                        break;
                    }
                    case feathers.layout.RelativePosition.LEFT:
                    {
                        this.measureWithArrowPosition(feathers.layout.RelativePosition.RIGHT);
                        loc8 = this._lastGlobalBoundsOfOrigin.x - this.actualWidth;
                        if (loc8 >= stagePaddingLeft) 
                        {
                            positionToLeftOfOrigin(this, this._lastGlobalBoundsOfOrigin);
                            return;
                        }
                        if (loc8 < 0) 
                        {
                            loc8 = 0;
                        }
                        break;
                    }
                    default:
                    {
                        this.measureWithArrowPosition(feathers.layout.RelativePosition.TOP);
                        loc7 = loc1.stageHeight - this.actualHeight - (this._lastGlobalBoundsOfOrigin.y + this._lastGlobalBoundsOfOrigin.height);
                        if (loc7 >= stagePaddingBottom) 
                        {
                            positionBelowOrigin(this, this._lastGlobalBoundsOfOrigin);
                            return;
                        }
                        if (loc7 < 0) 
                        {
                            loc7 = 0;
                        }
                    }
                }
                ++loc10;
            }
            if (!(loc7 === -1) && loc7 >= loc5 && loc7 >= loc6 && loc7 >= loc8) 
            {
                positionBelowOrigin(this, this._lastGlobalBoundsOfOrigin);
            }
            else if (!(loc5 === -1) && loc5 >= loc6 && loc5 >= loc8) 
            {
                positionAboveOrigin(this, this._lastGlobalBoundsOfOrigin);
            }
            else if (!(loc6 === -1) && loc6 >= loc8) 
            {
                positionToRightOfOrigin(this, this._lastGlobalBoundsOfOrigin);
            }
            else 
            {
                positionToLeftOfOrigin(this, this._lastGlobalBoundsOfOrigin);
            }
            return;
        }

        protected function callout_addedToStageHandler(arg1:starling.events.Event):void
        {
            var loc1:*=this.stage === null ? starling.core.Starling.current : this.stage.starling;
            var loc2:*=-feathers.utils.display.getDisplayObjectDepthFromStage(this);
            loc1.nativeStage.addEventListener(flash.events.KeyboardEvent.KEY_DOWN, this.callout_nativeStage_keyDownHandler, false, loc2, true);
            this.stage.addEventListener(starling.events.TouchEvent.TOUCH, this.stage_touchHandler);
            this._isReadyToClose = false;
            this.addEventListener(starling.events.EnterFrameEvent.ENTER_FRAME, this.callout_oneEnterFrameHandler);
            return;
        }

        public function get content():starling.display.DisplayObject
        {
            return this._content;
        }

        public function set content(arg1:starling.display.DisplayObject):void
        {
            var loc1:*=null;
            if (this._content == arg1) 
            {
                return;
            }
            if (this._content !== null) 
            {
                if (this._content is feathers.core.IFeathersControl) 
                {
                    feathers.core.IFeathersControl(this._content).removeEventListener(feathers.events.FeathersEventType.RESIZE, this.content_resizeHandler);
                }
                if (this._content.parent === this) 
                {
                    this._content.removeFromParent(false);
                }
            }
            this._content = arg1;
            if (this._content !== null) 
            {
                if (this._content is feathers.core.IFeathersControl) 
                {
                    feathers.core.IFeathersControl(this._content).addEventListener(feathers.events.FeathersEventType.RESIZE, this.content_resizeHandler);
                }
                this.addChild(this._content);
                if (this._content is feathers.core.IFeathersControl) 
                {
                    feathers.core.IFeathersControl(this._content).initializeNow();
                }
                if (this._content is feathers.core.IMeasureDisplayObject) 
                {
                    loc1 = feathers.core.IMeasureDisplayObject(this._content);
                    this._explicitContentWidth = loc1.explicitWidth;
                    this._explicitContentHeight = loc1.explicitHeight;
                    this._explicitContentMinWidth = loc1.explicitMinWidth;
                    this._explicitContentMinHeight = loc1.explicitMinHeight;
                    this._explicitContentMaxWidth = loc1.explicitMaxWidth;
                    this._explicitContentMaxHeight = loc1.explicitMaxHeight;
                }
                else 
                {
                    this._explicitContentWidth = this._content.width;
                    this._explicitContentHeight = this._content.height;
                    this._explicitContentMinWidth = this._explicitContentWidth;
                    this._explicitContentMinHeight = this._explicitContentHeight;
                    this._explicitContentMaxWidth = this._explicitContentWidth;
                    this._explicitContentMaxHeight = this._explicitContentHeight;
                }
            }
            this.invalidate(INVALIDATION_FLAG_SIZE);
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        protected function callout_removedFromStageHandler(arg1:starling.events.Event):void
        {
            this.stage.removeEventListener(starling.events.TouchEvent.TOUCH, this.stage_touchHandler);
            var loc1:*=this.stage === null ? starling.core.Starling.current : this.stage.starling;
            loc1.nativeStage.removeEventListener(flash.events.KeyboardEvent.KEY_DOWN, this.callout_nativeStage_keyDownHandler);
            return;
        }

        public function get origin():starling.display.DisplayObject
        {
            return this._origin;
        }

        public function set origin(arg1:starling.display.DisplayObject):void
        {
            if (this._origin == arg1) 
            {
                return;
            }
            if (arg1 && !arg1.stage) 
            {
                throw new ArgumentError("Callout origin must have access to the stage.");
            }
            if (this._origin) 
            {
                this.removeEventListener(starling.events.EnterFrameEvent.ENTER_FRAME, this.callout_enterFrameHandler);
                this._origin.removeEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.origin_removedFromStageHandler);
            }
            this._origin = arg1;
            this._lastGlobalBoundsOfOrigin = null;
            if (this._origin) 
            {
                this._origin.addEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.origin_removedFromStageHandler);
                this.addEventListener(starling.events.EnterFrameEvent.ENTER_FRAME, this.callout_enterFrameHandler);
            }
            this.invalidate(INVALIDATION_FLAG_ORIGIN);
            return;
        }

        protected function callout_oneEnterFrameHandler(arg1:starling.events.Event):void
        {
            this.removeEventListener(starling.events.EnterFrameEvent.ENTER_FRAME, this.callout_oneEnterFrameHandler);
            this._isReadyToClose = true;
            return;
        }

        public function get supportedDirections():String
        {
            return this._supportedDirections;
        }

        public function set supportedDirections(arg1:String):void
        {
            var loc1:*=null;
            if (arg1 !== DIRECTION_ANY) 
            {
                if (arg1 !== DIRECTION_HORIZONTAL) 
                {
                    if (arg1 !== DIRECTION_VERTICAL) 
                    {
                        if (arg1 !== DIRECTION_UP) 
                        {
                            if (arg1 !== DIRECTION_DOWN) 
                            {
                                if (arg1 !== DIRECTION_RIGHT) 
                                {
                                    if (arg1 === DIRECTION_LEFT) 
                                    {
                                        new Vector.<String>(1)[0] = feathers.layout.RelativePosition.LEFT;
                                        loc1 = new Vector.<String>(1);
                                    }
                                }
                                else 
                                {
                                    new Vector.<String>(1)[0] = feathers.layout.RelativePosition.RIGHT;
                                    loc1 = new Vector.<String>(1);
                                }
                            }
                            else 
                            {
                                new Vector.<String>(1)[0] = feathers.layout.RelativePosition.BOTTOM;
                                loc1 = new Vector.<String>(1);
                            }
                        }
                        else 
                        {
                            new Vector.<String>(1)[0] = feathers.layout.RelativePosition.TOP;
                            loc1 = new Vector.<String>(1);
                        }
                    }
                    else 
                    {
                        new Vector.<String>(2)[0] = feathers.layout.RelativePosition.BOTTOM;
                        new Vector.<String>(2)[1] = feathers.layout.RelativePosition.TOP;
                        loc1 = new Vector.<String>(2);
                    }
                }
                else 
                {
                    new Vector.<String>(2)[0] = feathers.layout.RelativePosition.RIGHT;
                    new Vector.<String>(2)[1] = feathers.layout.RelativePosition.LEFT;
                    loc1 = new Vector.<String>(2);
                }
            }
            else 
            {
                new Vector.<String>(4)[0] = feathers.layout.RelativePosition.BOTTOM;
                new Vector.<String>(4)[1] = feathers.layout.RelativePosition.TOP;
                new Vector.<String>(4)[2] = feathers.layout.RelativePosition.RIGHT;
                new Vector.<String>(4)[3] = feathers.layout.RelativePosition.LEFT;
                loc1 = new Vector.<String>(4);
            }
            this._supportedDirections = arg1;
            this.supportedPositions = loc1;
            return;
        }

        protected function callout_enterFrameHandler(arg1:starling.events.EnterFrameEvent):void
        {
            this.positionRelativeToOrigin();
            return;
        }

        public function get supportedPositions():__AS3__.vec.Vector.<String>
        {
            return this._supportedPositions;
        }

        public function set supportedPositions(arg1:__AS3__.vec.Vector.<String>):void
        {
            this._supportedPositions = arg1;
            return;
        }

        protected function stage_touchHandler(arg1:starling.events.TouchEvent):void
        {
            var loc2:*=null;
            var loc1:*=starling.display.DisplayObject(arg1.target);
            if (!this._isReadyToClose || !this.closeOnTouchEndedOutside && !this.closeOnTouchBeganOutside || this.contains(loc1) || feathers.core.PopUpManager.isPopUp(this) && !feathers.core.PopUpManager.isTopLevelPopUp(this)) 
            {
                return;
            }
            if (this._origin == loc1 || this._origin is starling.display.DisplayObjectContainer && starling.display.DisplayObjectContainer(this._origin).contains(loc1)) 
            {
                return;
            }
            if (this.closeOnTouchBeganOutside) 
            {
                loc2 = arg1.getTouch(this.stage, starling.events.TouchPhase.BEGAN);
                if (loc2) 
                {
                    this.close(this.disposeOnSelfClose);
                    return;
                }
            }
            if (this.closeOnTouchEndedOutside) 
            {
                loc2 = arg1.getTouch(this.stage, starling.events.TouchPhase.ENDED);
                if (loc2) 
                {
                    this.close(this.disposeOnSelfClose);
                    return;
                }
            }
            return;
        }

        public function get horizontalAlign():String
        {
            return this._horizontalAlign;
        }

        protected function callout_nativeStage_keyDownHandler(arg1:flash.events.KeyboardEvent):void
        {
            if (arg1.isDefaultPrevented()) 
            {
                return;
            }
            if (!this.closeOnKeys || this.closeOnKeys.indexOf(arg1.keyCode) < 0) 
            {
                return;
            }
            arg1.preventDefault();
            this.close(this.disposeOnSelfClose);
            return;
        }

        protected function origin_removedFromStageHandler(arg1:starling.events.Event):void
        {
            this.close(this.disposeOnSelfClose);
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
            this._lastGlobalBoundsOfOrigin = null;
            this.invalidate(INVALIDATION_FLAG_ORIGIN);
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

        protected function content_resizeHandler(arg1:starling.events.Event):void
        {
            if (this._ignoreContentResize) 
            {
                return;
            }
            this.invalidate(INVALIDATION_FLAG_SIZE);
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

        
        {
            new Vector.<String>(4)[0] = feathers.layout.RelativePosition.BOTTOM;
            new Vector.<String>(4)[1] = feathers.layout.RelativePosition.TOP;
            new Vector.<String>(4)[2] = feathers.layout.RelativePosition.RIGHT;
            new Vector.<String>(4)[3] = feathers.layout.RelativePosition.LEFT;
            stagePaddingTop = 0;
            stagePaddingRight = 0;
            stagePaddingBottom = 0;
            stagePaddingLeft = 0;
            calloutFactory = defaultCalloutFactory;
            calloutOverlayFactory = feathers.core.PopUpManager.defaultOverlayFactory;
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

        public static function get stagePadding():Number
        {
            return feathers.controls.Callout.stagePaddingTop;
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

        public static function set stagePadding(arg1:Number):void
        {
            feathers.controls.Callout.stagePaddingTop = arg1;
            feathers.controls.Callout.stagePaddingRight = arg1;
            feathers.controls.Callout.stagePaddingBottom = arg1;
            feathers.controls.Callout.stagePaddingLeft = arg1;
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

        public static function show(arg1:starling.display.DisplayObject, arg2:starling.display.DisplayObject, arg3:Object=null, arg4:Boolean=true, arg5:Function=null, arg6:Function=null):feathers.controls.Callout
        {
            if (arg2.stage === null) 
            {
                throw new ArgumentError("Callout origin must be added to the stage.");
            }
            var loc1:*=arg5;
            if (loc1 === null) 
            {
                loc1 = calloutFactory;
                if (loc1 === null) 
                {
                    loc1 = defaultCalloutFactory;
                }
            }
            var loc2:*=Callout(loc1());
            loc2.content = arg1;
            if (arg3 is String) 
            {
                loc2.supportedDirections = arg3 as String;
            }
            else 
            {
                loc2.supportedPositions = arg3 as Vector.<String>;
            }
            loc2.origin = arg2;
            loc1 = arg6;
            if (loc1 === null) 
            {
                loc1 = calloutOverlayFactory;
                if (loc1 === null) 
                {
                    loc1 = feathers.core.PopUpManager.defaultOverlayFactory;
                }
            }
            feathers.core.PopUpManager.addPopUp(loc2, arg4, false, loc1);
            return loc2;
        }

        public function get arrowPosition():String
        {
            return this._arrowPosition;
        }

        public function set arrowPosition(arg1:String):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._arrowPosition === arg1) 
            {
                return;
            }
            this._arrowPosition = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public static function defaultCalloutFactory():feathers.controls.Callout
        {
            var loc1:*=new Callout();
            loc1.closeOnTouchBeganOutside = true;
            loc1.closeOnTouchEndedOutside = true;
            new Vector.<uint>(2)[0] = flash.ui.Keyboard.BACK;
            new Vector.<uint>(2)[1] = flash.ui.Keyboard.ESCAPE;
            loc1.closeOnKeys = new Vector.<uint>(2);
            return loc1;
        }

        public function get backgroundSkin():starling.display.DisplayObject
        {
            return this._backgroundSkin;
        }

        public function set backgroundSkin(arg1:starling.display.DisplayObject):void
        {
            var loc1:*=null;
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
            if (!(this._backgroundSkin === null) && this._backgroundSkin.parent === this) 
            {
                this._backgroundSkin.removeFromParent(false);
            }
            this._backgroundSkin = arg1;
            if (this._backgroundSkin !== null) 
            {
                this.addChildAt(this._backgroundSkin, 0);
                if (this._backgroundSkin is feathers.core.IFeathersControl) 
                {
                    feathers.core.IFeathersControl(this._backgroundSkin).initializeNow();
                }
                if (this._backgroundSkin is feathers.core.IMeasureDisplayObject) 
                {
                    loc1 = feathers.core.IMeasureDisplayObject(this._backgroundSkin);
                    this._explicitBackgroundSkinWidth = loc1.explicitWidth;
                    this._explicitBackgroundSkinHeight = loc1.explicitHeight;
                    this._explicitBackgroundSkinMinWidth = loc1.explicitMinWidth;
                    this._explicitBackgroundSkinMinHeight = loc1.explicitMinHeight;
                    this._explicitBackgroundSkinMaxWidth = loc1.explicitMaxWidth;
                    this._explicitBackgroundSkinMaxHeight = loc1.explicitMaxHeight;
                }
                else 
                {
                    this._explicitBackgroundSkinWidth = this._backgroundSkin.width;
                    this._explicitBackgroundSkinHeight = this._backgroundSkin.height;
                    this._explicitBackgroundSkinMinWidth = this._explicitBackgroundSkinWidth;
                    this._explicitBackgroundSkinMinHeight = this._explicitBackgroundSkinHeight;
                    this._explicitBackgroundSkinMaxWidth = this._explicitBackgroundSkinWidth;
                    this._explicitBackgroundSkinMaxHeight = this._explicitBackgroundSkinHeight;
                }
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected static function positionBelowOrigin(arg1:feathers.controls.Callout, arg2:flash.geom.Rectangle):void
        {
            var loc4:*=null;
            var loc5:*=NaN;
            arg1.measureWithArrowPosition(feathers.layout.RelativePosition.TOP);
            var loc1:*=arg2.x;
            if (arg1._horizontalAlign !== feathers.layout.HorizontalAlign.CENTER) 
            {
                if (arg1._horizontalAlign === feathers.layout.HorizontalAlign.RIGHT) 
                {
                    loc1 = loc1 + (arg2.width - arg1.width);
                }
            }
            else 
            {
                loc1 = loc1 + Math.round((arg2.width - arg1.width) / 2);
            }
            var loc2:*=loc1;
            if (stagePaddingLeft > loc2) 
            {
                loc2 = stagePaddingLeft;
            }
            else 
            {
                loc4 = arg1.stage === null ? starling.core.Starling.current.stage : arg1.stage;
                loc5 = loc4.stageWidth - arg1.width - stagePaddingRight;
                if (loc5 < loc2) 
                {
                    loc2 = loc5;
                }
            }
            var loc3:*=starling.utils.Pool.getPoint(loc2, arg2.y + arg2.height);
            arg1.parent.globalToLocal(loc3, loc3);
            arg1.x = loc3.x;
            arg1.y = loc3.y;
            starling.utils.Pool.putPoint(loc3);
            if (arg1._isValidating) 
            {
                arg1._arrowOffset = loc1 - loc2;
                arg1._arrowPosition = feathers.layout.RelativePosition.TOP;
            }
            else 
            {
                arg1.arrowOffset = loc1 - loc2;
                arg1.arrowPosition = feathers.layout.RelativePosition.TOP;
            }
            return;
        }

        protected static function positionAboveOrigin(arg1:feathers.controls.Callout, arg2:flash.geom.Rectangle):void
        {
            var loc4:*=null;
            var loc5:*=NaN;
            arg1.measureWithArrowPosition(feathers.layout.RelativePosition.BOTTOM);
            var loc1:*=arg2.x;
            if (arg1._horizontalAlign !== feathers.layout.HorizontalAlign.CENTER) 
            {
                if (arg1._horizontalAlign === feathers.layout.HorizontalAlign.RIGHT) 
                {
                    loc1 = loc1 + (arg2.width - arg1.width);
                }
            }
            else 
            {
                loc1 = loc1 + Math.round((arg2.width - arg1.width) / 2);
            }
            var loc2:*=loc1;
            if (stagePaddingLeft > loc2) 
            {
                loc2 = stagePaddingLeft;
            }
            else 
            {
                loc4 = arg1.stage === null ? starling.core.Starling.current.stage : arg1.stage;
                loc5 = loc4.stageWidth - arg1.width - stagePaddingRight;
                if (loc5 < loc2) 
                {
                    loc2 = loc5;
                }
            }
            var loc3:*=starling.utils.Pool.getPoint(loc2, arg2.y - arg1.height);
            arg1.parent.globalToLocal(loc3, loc3);
            arg1.x = loc3.x;
            arg1.y = loc3.y;
            starling.utils.Pool.putPoint(loc3);
            if (arg1._isValidating) 
            {
                arg1._arrowOffset = loc1 - loc2;
                arg1._arrowPosition = feathers.layout.RelativePosition.BOTTOM;
            }
            else 
            {
                arg1.arrowOffset = loc1 - loc2;
                arg1.arrowPosition = feathers.layout.RelativePosition.BOTTOM;
            }
            return;
        }

        public function get topArrowSkin():starling.display.DisplayObject
        {
            return this._topArrowSkin;
        }

        public function set topArrowSkin(arg1:starling.display.DisplayObject):void
        {
            var loc1:*=0;
            if (this.processStyleRestriction(arguments.callee)) 
            {
                if (arg1 !== null) 
                {
                    arg1.dispose();
                }
                return;
            }
            if (this._topArrowSkin === arg1) 
            {
                return;
            }
            if (!(this._topArrowSkin === null) && this._topArrowSkin.parent === this) 
            {
                this._topArrowSkin.removeFromParent(false);
            }
            this._topArrowSkin = arg1;
            if (this._topArrowSkin !== null) 
            {
                this._topArrowSkin.visible = false;
                loc1 = this.getChildIndex(this._content);
                if (loc1 < 0) 
                {
                    this.addChild(this._topArrowSkin);
                }
                else 
                {
                    this.addChildAt(this._topArrowSkin, loc1);
                }
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected static function positionToRightOfOrigin(arg1:feathers.controls.Callout, arg2:flash.geom.Rectangle):void
        {
            var loc4:*=null;
            var loc5:*=NaN;
            arg1.measureWithArrowPosition(feathers.layout.RelativePosition.LEFT);
            var loc1:*=arg2.y;
            if (arg1._verticalAlign !== feathers.layout.VerticalAlign.MIDDLE) 
            {
                if (arg1._verticalAlign === feathers.layout.VerticalAlign.BOTTOM) 
                {
                    loc1 = loc1 + (arg2.height - arg1.height);
                }
            }
            else 
            {
                loc1 = loc1 + Math.round((arg2.height - arg1.height) / 2);
            }
            var loc2:*=loc1;
            if (stagePaddingTop > loc2) 
            {
                loc2 = stagePaddingTop;
            }
            else 
            {
                loc4 = arg1.stage === null ? starling.core.Starling.current.stage : arg1.stage;
                loc5 = loc4.stageHeight - arg1.height - stagePaddingBottom;
                if (loc5 < loc2) 
                {
                    loc2 = loc5;
                }
            }
            var loc3:*=starling.utils.Pool.getPoint(arg2.x + arg2.width, loc2);
            arg1.parent.globalToLocal(loc3, loc3);
            arg1.x = loc3.x;
            arg1.y = loc3.y;
            starling.utils.Pool.putPoint(loc3);
            if (arg1._isValidating) 
            {
                arg1._arrowOffset = loc1 - loc2;
                arg1._arrowPosition = feathers.layout.RelativePosition.LEFT;
            }
            else 
            {
                arg1.arrowOffset = loc1 - loc2;
                arg1.arrowPosition = feathers.layout.RelativePosition.LEFT;
            }
            return;
        }

        public function get rightArrowSkin():starling.display.DisplayObject
        {
            return this._rightArrowSkin;
        }

        public function set rightArrowSkin(arg1:starling.display.DisplayObject):void
        {
            var loc1:*=0;
            if (this.processStyleRestriction(arguments.callee)) 
            {
                if (arg1 !== null) 
                {
                    arg1.dispose();
                }
                return;
            }
            if (this._rightArrowSkin === arg1) 
            {
                return;
            }
            if (!(this._rightArrowSkin === null) && this._rightArrowSkin.parent === this) 
            {
                this._rightArrowSkin.removeFromParent(false);
            }
            this._rightArrowSkin = arg1;
            if (this._rightArrowSkin !== null) 
            {
                this._rightArrowSkin.visible = false;
                loc1 = this.getChildIndex(this._content);
                if (loc1 < 0) 
                {
                    this.addChild(this._rightArrowSkin);
                }
                else 
                {
                    this.addChildAt(this._rightArrowSkin, loc1);
                }
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected static function positionToLeftOfOrigin(arg1:feathers.controls.Callout, arg2:flash.geom.Rectangle):void
        {
            var loc4:*=null;
            var loc5:*=NaN;
            arg1.measureWithArrowPosition(feathers.layout.RelativePosition.RIGHT);
            var loc1:*=arg2.y;
            if (arg1._verticalAlign !== feathers.layout.VerticalAlign.MIDDLE) 
            {
                if (arg1._verticalAlign === feathers.layout.VerticalAlign.BOTTOM) 
                {
                    loc1 = loc1 + (arg2.height - arg1.height);
                }
            }
            else 
            {
                loc1 = loc1 + Math.round((arg2.height - arg1.height) / 2);
            }
            var loc2:*=loc1;
            if (stagePaddingTop > loc2) 
            {
                loc2 = stagePaddingTop;
            }
            else 
            {
                loc4 = arg1.stage === null ? starling.core.Starling.current.stage : arg1.stage;
                loc5 = loc4.stageHeight - arg1.height - stagePaddingBottom;
                if (loc5 < loc2) 
                {
                    loc2 = loc5;
                }
            }
            var loc3:*=starling.utils.Pool.getPoint(arg2.x - arg1.width, loc2);
            arg1.parent.globalToLocal(loc3, loc3);
            arg1.x = loc3.x;
            arg1.y = loc3.y;
            starling.utils.Pool.putPoint(loc3);
            if (arg1._isValidating) 
            {
                arg1._arrowOffset = loc1 - loc2;
                arg1._arrowPosition = feathers.layout.RelativePosition.RIGHT;
            }
            else 
            {
                arg1.arrowOffset = loc1 - loc2;
                arg1.arrowPosition = feathers.layout.RelativePosition.RIGHT;
            }
            return;
        }

        public function get bottomArrowSkin():starling.display.DisplayObject
        {
            return this._bottomArrowSkin;
        }

        public function set bottomArrowSkin(arg1:starling.display.DisplayObject):void
        {
            var loc1:*=0;
            if (this.processStyleRestriction(arguments.callee)) 
            {
                if (arg1 !== null) 
                {
                    arg1.dispose();
                }
                return;
            }
            if (this._bottomArrowSkin === arg1) 
            {
                return;
            }
            if (!(this._bottomArrowSkin === null) && this._bottomArrowSkin.parent === this) 
            {
                this._bottomArrowSkin.removeFromParent(false);
            }
            this._bottomArrowSkin = arg1;
            if (this._bottomArrowSkin !== null) 
            {
                this._bottomArrowSkin.visible = false;
                loc1 = this.getChildIndex(this._content);
                if (loc1 < 0) 
                {
                    this.addChild(this._bottomArrowSkin);
                }
                else 
                {
                    this.addChildAt(this._bottomArrowSkin, loc1);
                }
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function set arrowOffset(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._arrowOffset === arg1) 
            {
                return;
            }
            this._arrowOffset = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get leftArrowSkin():starling.display.DisplayObject
        {
            return this._leftArrowSkin;
        }

        public function set leftArrowSkin(arg1:starling.display.DisplayObject):void
        {
            var loc1:*=0;
            if (this.processStyleRestriction(arguments.callee)) 
            {
                if (arg1 !== null) 
                {
                    arg1.dispose();
                }
                return;
            }
            if (this._leftArrowSkin === arg1) 
            {
                return;
            }
            if (!(this._leftArrowSkin === null) && this._leftArrowSkin.parent === this) 
            {
                this._leftArrowSkin.removeFromParent(false);
            }
            this._leftArrowSkin = arg1;
            if (this._leftArrowSkin !== null) 
            {
                this._leftArrowSkin.visible = false;
                loc1 = this.getChildIndex(this._content);
                if (loc1 < 0) 
                {
                    this.addChild(this._leftArrowSkin);
                }
                else 
                {
                    this.addChildAt(this._leftArrowSkin, loc1);
                }
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get topArrowGap():Number
        {
            return this._topArrowGap;
        }

        public function set topArrowGap(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._topArrowGap === arg1) 
            {
                return;
            }
            this._topArrowGap = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public static const DIRECTION_UP:String="up";

        public static const DEFAULT_POSITIONS:__AS3__.vec.Vector.<String>=new Vector.<String>(4);

        public static const DIRECTION_ANY:String="any";

        public static const DIRECTION_VERTICAL:String="vertical";

        public static const DIRECTION_HORIZONTAL:String="horizontal";

        public static const DIRECTION_DOWN:String="down";

        public static const DIRECTION_LEFT:String="left";

        public static const DIRECTION_RIGHT:String="right";

        public static const ARROW_POSITION_TOP:String="top";

        public static const ARROW_POSITION_RIGHT:String="right";

        public static const ARROW_POSITION_BOTTOM:String="bottom";

        protected static const INVALIDATION_FLAG_ORIGIN:String="origin";

        protected static const FUZZY_CONTENT_DIMENSIONS_PADDING:Number=1e-006;

        public static const ARROW_POSITION_LEFT:String="left";

        protected var _explicitBackgroundSkinHeight:Number;

        protected var _explicitBackgroundSkinMinWidth:Number;

        protected var _explicitBackgroundSkinMaxWidth:Number;

        protected var _explicitBackgroundSkinMaxHeight:Number;

        protected var _content:starling.display.DisplayObject;

        protected var _origin:starling.display.DisplayObject;

        protected var _supportedDirections:String=null;

        protected var _supportedPositions:__AS3__.vec.Vector.<String>=null;

        protected var _horizontalAlign:String="center";

        protected var _explicitBackgroundSkinMinHeight:Number;

        protected var _verticalAlign:String="middle";

        protected var _paddingRight:Number=0;

        protected var _paddingBottom:Number=0;

        protected var _paddingLeft:Number=0;

        protected var _arrowPosition:String="top";

        protected var _backgroundSkin:starling.display.DisplayObject;

        protected var currentArrowSkin:starling.display.DisplayObject;

        protected var _paddingTop:Number=0;

        protected var _rightArrowSkin:starling.display.DisplayObject;

        protected var _bottomArrowSkin:starling.display.DisplayObject;

        public var closeOnTouchBeganOutside:Boolean=false;

        public var closeOnTouchEndedOutside:Boolean=false;

        public var closeOnKeys:__AS3__.vec.Vector.<uint>;

        public var disposeOnSelfClose:Boolean=true;

        protected var _topArrowSkin:starling.display.DisplayObject;

        public var disposeContent:Boolean=true;

        protected var _isReadyToClose:Boolean=false;

        protected var _explicitContentWidth:Number;

        protected var _explicitContentHeight:Number;

        protected var _explicitContentMinWidth:Number;

        protected var _explicitContentMinHeight:Number;

        protected var _topArrowGap:Number=0;

        protected var _explicitContentMaxWidth:Number;

        protected var _explicitContentMaxHeight:Number;

        protected var _explicitBackgroundSkinWidth:Number;

        protected var _bottomArrowGap:Number=0;

        public static var stagePaddingTop:Number=0;

        public static var stagePaddingRight:Number=0;

        public static var stagePaddingBottom:Number=0;

        public static var stagePaddingLeft:Number=0;

        public static var calloutFactory:Function;

        protected var _arrowOffset:Number=0;

        protected var _leftArrowSkin:starling.display.DisplayObject;

        protected var _lastGlobalBoundsOfOrigin:flash.geom.Rectangle;

        protected var _ignoreContentResize:Boolean=false;

        protected var _leftArrowGap:Number=0;

        protected var _rightArrowGap:Number=0;

        public static var globalStyleProvider:feathers.skins.IStyleProvider;

        public static var calloutOverlayFactory:Function;
    }
}


