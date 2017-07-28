//class LayoutViewPort
package feathers.controls.supportClasses 
{
    import feathers.controls.*;
    import feathers.core.*;
    import feathers.layout.*;
    import starling.display.*;
    
    public class LayoutViewPort extends feathers.controls.LayoutGroup implements feathers.controls.supportClasses.IViewPort
    {
        public function LayoutViewPort()
        {
            super();
            return;
        }

        public function get horizontalScrollPosition():Number
        {
            return this._horizontalScrollPosition;
        }

        public function set horizontalScrollPosition(arg1:Number):void
        {
            if (this._horizontalScrollPosition == arg1) 
            {
                return;
            }
            this._horizontalScrollPosition = arg1;
            this.invalidate(INVALIDATION_FLAG_SCROLL);
            return;
        }

        public function get minVisibleWidth():Number
        {
            if (this._explicitMinVisibleWidth !== this._explicitMinVisibleWidth) 
            {
                return this._actualMinVisibleWidth;
            }
            return this._explicitMinVisibleWidth;
        }

        public function set minVisibleWidth(arg1:Number):void
        {
            if (this._explicitMinVisibleWidth == arg1) 
            {
                return;
            }
            var loc1:*=!(arg1 === arg1);
            if (loc1 && !(this._explicitMinVisibleWidth === this._explicitMinVisibleWidth)) 
            {
                return;
            }
            var loc2:*=this._explicitMinVisibleWidth;
            this._explicitMinVisibleWidth = arg1;
            if (loc1) 
            {
                this._actualMinVisibleWidth = 0;
                this.invalidate(INVALIDATION_FLAG_SIZE);
            }
            else 
            {
                this._actualMinVisibleWidth = arg1;
                if (!(this._explicitVisibleWidth === this._explicitVisibleWidth) && (this._actualVisibleWidth < arg1 || this._actualVisibleWidth === loc2)) 
                {
                    this.invalidate(INVALIDATION_FLAG_SIZE);
                }
            }
            return;
        }

        public function get verticalScrollPosition():Number
        {
            return this._verticalScrollPosition;
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
            var loc1:*=this._maxVisibleWidth;
            this._maxVisibleWidth = arg1;
            if (!(this._explicitVisibleWidth === this._explicitVisibleWidth) && (this._actualVisibleWidth > arg1 || this._actualVisibleWidth === loc1)) 
            {
                this.invalidate(INVALIDATION_FLAG_SIZE);
            }
            return;
        }

        public function set verticalScrollPosition(arg1:Number):void
        {
            if (this._verticalScrollPosition == arg1) 
            {
                return;
            }
            this._verticalScrollPosition = arg1;
            this.invalidate(INVALIDATION_FLAG_SCROLL);
            return;
        }

        public function get requiresMeasurementOnScroll():Boolean
        {
            return !(this._layout === null) && this._layout.requiresLayoutOnScroll && (!(this._explicitVisibleWidth === this._explicitVisibleWidth) || !(this._explicitVisibleHeight === this._explicitVisibleHeight));
        }

        public function get visibleWidth():Number
        {
            if (this._explicitVisibleWidth !== this._explicitVisibleWidth) 
            {
                return this._actualVisibleWidth;
            }
            return this._explicitVisibleWidth;
        }

        public function set visibleWidth(arg1:Number):void
        {
            if (this._explicitVisibleWidth == arg1 || !(arg1 === arg1) && !(this._explicitVisibleWidth === this._explicitVisibleWidth)) 
            {
                return;
            }
            this._explicitVisibleWidth = arg1;
            if (this._actualVisibleWidth !== arg1) 
            {
                this.invalidate(INVALIDATION_FLAG_SIZE);
            }
            return;
        }

        public override function dispose():void
        {
            this.layout = null;
            super.dispose();
            return;
        }

        protected override function refreshViewPortBounds():void
        {
            var loc1:*=!(this._explicitVisibleWidth === this._explicitVisibleWidth);
            var loc2:*=!(this._explicitVisibleHeight === this._explicitVisibleHeight);
            var loc3:*=!(this._explicitMinVisibleWidth === this._explicitMinVisibleWidth);
            var loc4:*=!(this._explicitMinVisibleHeight === this._explicitMinVisibleHeight);
            this.viewPortBounds.x = 0;
            this.viewPortBounds.y = 0;
            this.viewPortBounds.scrollX = this._horizontalScrollPosition;
            this.viewPortBounds.scrollY = this._verticalScrollPosition;
            if (this._autoSizeMode === feathers.controls.AutoSizeMode.STAGE && loc1) 
            {
                this.viewPortBounds.explicitWidth = this.stage.stageWidth;
            }
            else 
            {
                this.viewPortBounds.explicitWidth = this._explicitVisibleWidth;
            }
            if (this._autoSizeMode === feathers.controls.AutoSizeMode.STAGE && loc2) 
            {
                this.viewPortBounds.explicitHeight = this.stage.stageHeight;
            }
            else 
            {
                this.viewPortBounds.explicitHeight = this._explicitVisibleHeight;
            }
            if (loc3) 
            {
                this.viewPortBounds.minWidth = 0;
            }
            else 
            {
                this.viewPortBounds.minWidth = this._explicitMinVisibleWidth;
            }
            if (loc4) 
            {
                this.viewPortBounds.minHeight = 0;
            }
            else 
            {
                this.viewPortBounds.minHeight = this._explicitMinVisibleHeight;
            }
            this.viewPortBounds.maxWidth = this._maxVisibleWidth;
            this.viewPortBounds.maxHeight = this._maxVisibleHeight;
            return;
        }

        public function get minVisibleHeight():Number
        {
            if (this._explicitMinVisibleHeight !== this._explicitMinVisibleHeight) 
            {
                return this._actualMinVisibleHeight;
            }
            return this._explicitMinVisibleHeight;
        }

        public function set minVisibleHeight(arg1:Number):void
        {
            if (this._explicitMinVisibleHeight == arg1) 
            {
                return;
            }
            var loc1:*=!(arg1 === arg1);
            if (loc1 && !(this._explicitMinVisibleHeight === this._explicitMinVisibleHeight)) 
            {
                return;
            }
            var loc2:*=this._explicitMinVisibleHeight;
            this._explicitMinVisibleHeight = arg1;
            if (loc1) 
            {
                this._actualMinVisibleHeight = 0;
                this.invalidate(INVALIDATION_FLAG_SIZE);
            }
            else 
            {
                this._actualMinVisibleHeight = arg1;
                if (!(this._explicitVisibleHeight === this._explicitVisibleHeight) && (this._actualVisibleHeight < arg1 || this._actualVisibleHeight === loc2)) 
                {
                    this.invalidate(INVALIDATION_FLAG_SIZE);
                }
            }
            return;
        }

        protected override function handleLayoutResult():void
        {
            var loc1:*=this._layoutResult.contentWidth;
            var loc2:*=this._layoutResult.contentHeight;
            this.saveMeasurements(loc1, loc2, loc1, loc2);
            this._contentX = this._layoutResult.contentX;
            this._contentY = this._layoutResult.contentY;
            var loc3:*=this._layoutResult.viewPortWidth;
            var loc4:*=this._layoutResult.viewPortHeight;
            this._actualVisibleWidth = loc3;
            this._actualVisibleHeight = loc4;
            this._actualMinVisibleWidth = loc3;
            this._actualMinVisibleHeight = loc4;
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
            var loc1:*=this._maxVisibleHeight;
            this._maxVisibleHeight = arg1;
            if (!(this._explicitVisibleHeight === this._explicitVisibleHeight) && (this._actualVisibleHeight > arg1 || this._actualVisibleHeight === loc1)) 
            {
                this.invalidate(INVALIDATION_FLAG_SIZE);
            }
            return;
        }

        protected override function handleManualLayout():void
        {
            var loc15:*=null;
            var loc16:*=NaN;
            var loc17:*=NaN;
            var loc18:*=NaN;
            var loc19:*=NaN;
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=this.viewPortBounds.explicitWidth;
            var loc4:*=loc3;
            this.doNothing();
            if (loc4 !== loc4) 
            {
                loc4 = 0;
            }
            var loc5:*=this.viewPortBounds.explicitHeight;
            var loc6:*=loc5;
            this.doNothing();
            if (loc6 !== loc6) 
            {
                loc6 = 0;
            }
            this._ignoreChildChanges = true;
            var loc7:*=this.items.length;
            var loc8:*=0;
            while (loc8 < loc7) 
            {
                loc15 = this.items[loc8];
                if (!(loc15 is feathers.layout.ILayoutDisplayObject && !feathers.layout.ILayoutDisplayObject(loc15).includeInLayout)) 
                {
                    if (loc15 is feathers.core.IValidating) 
                    {
                        feathers.core.IValidating(loc15).validate();
                    }
                    loc16 = loc15.x - loc15.pivotX;
                    loc17 = loc15.y - loc15.pivotY;
                    loc18 = loc16 + loc15.width;
                    loc19 = loc17 + loc15.height;
                    if (loc16 === loc16 && loc16 < loc1) 
                    {
                        loc1 = loc16;
                    }
                    if (loc17 === loc17 && loc17 < loc2) 
                    {
                        loc2 = loc17;
                    }
                    if (loc18 === loc18 && loc18 > loc4) 
                    {
                        loc4 = loc18;
                    }
                    if (loc19 === loc19 && loc19 > loc6) 
                    {
                        loc6 = loc19;
                    }
                }
                ++loc8;
            }
            this._contentX = loc1;
            this._contentY = loc2;
            var loc9:*=this.viewPortBounds.minWidth;
            var loc10:*=this.viewPortBounds.maxWidth;
            var loc11:*=this.viewPortBounds.minHeight;
            var loc12:*=this.viewPortBounds.maxHeight;
            var loc13:*=loc4 - loc1;
            if (loc13 < loc9) 
            {
                loc13 = loc9;
            }
            else if (loc13 > loc10) 
            {
                loc13 = loc10;
            }
            var loc14:*=loc6 - loc2;
            if (loc14 < loc11) 
            {
                loc14 = loc11;
            }
            else if (loc14 > loc12) 
            {
                loc14 = loc12;
            }
            this._ignoreChildChanges = false;
            if (loc3 === loc3) 
            {
                this._actualVisibleWidth = loc3;
            }
            else 
            {
                this._actualVisibleWidth = loc13;
            }
            if (loc5 === loc5) 
            {
                this._actualVisibleHeight = loc5;
            }
            else 
            {
                this._actualVisibleHeight = loc14;
            }
            this._layoutResult.contentX = 0;
            this._layoutResult.contentY = 0;
            this._layoutResult.contentWidth = loc13;
            this._layoutResult.contentHeight = loc14;
            this._layoutResult.viewPortWidth = loc13;
            this._layoutResult.viewPortHeight = loc14;
            return;
        }

        protected function doNothing():void
        {
            return;
        }

        public function get visibleHeight():Number
        {
            if (this._explicitVisibleHeight !== this._explicitVisibleHeight) 
            {
                return this._actualVisibleHeight;
            }
            return this._explicitVisibleHeight;
        }

        public function set visibleHeight(arg1:Number):void
        {
            if (this._explicitVisibleHeight == arg1 || !(arg1 === arg1) && !(this._explicitVisibleHeight === this._explicitVisibleHeight)) 
            {
                return;
            }
            this._explicitVisibleHeight = arg1;
            if (this._actualVisibleHeight !== arg1) 
            {
                this.invalidate(INVALIDATION_FLAG_SIZE);
            }
            return;
        }

        public function get contentX():Number
        {
            return this._contentX;
        }

        public function get contentY():Number
        {
            return this._contentY;
        }

        public function get horizontalScrollStep():Number
        {
            if (this.actualWidth < this.actualHeight) 
            {
                return this.actualWidth / 10;
            }
            return this.actualHeight / 10;
        }

        public function get verticalScrollStep():Number
        {
            if (this.actualWidth < this.actualHeight) 
            {
                return this.actualWidth / 10;
            }
            return this.actualHeight / 10;
        }

        internal var _actualMinVisibleWidth:Number=0;

        internal var _explicitMinVisibleWidth:Number;

        internal var _maxVisibleWidth:Number=Infinity;

        internal var _actualVisibleWidth:Number=0;

        internal var _explicitVisibleWidth:Number;

        internal var _actualMinVisibleHeight:Number=0;

        internal var _explicitMinVisibleHeight:Number;

        internal var _maxVisibleHeight:Number=Infinity;

        internal var _actualVisibleHeight:Number=0;

        internal var _verticalScrollPosition:Number=0;

        internal var _horizontalScrollPosition:Number=0;

        internal var _contentY:Number=0;

        internal var _contentX:Number=0;

        internal var _explicitVisibleHeight:Number;
    }
}


