//class TiledRowsLayout
package feathers.layout 
{
    import __AS3__.vec.*;
    import feathers.core.*;
    import flash.errors.*;
    import flash.geom.*;
    import starling.display.*;
    import starling.events.*;
    
    public class TiledRowsLayout extends starling.events.EventDispatcher implements feathers.layout.IVirtualLayout
    {
        public function TiledRowsLayout()
        {
            this._discoveredItemsCache = new Vector.<starling.display.DisplayObject>(0);
            super();
            return;
        }

        public function get useSquareTiles():Boolean
        {
            return this._useSquareTiles;
        }

        public function get gap():Number
        {
            return this._horizontalGap;
        }

        public function set gap(arg1:Number):void
        {
            this.horizontalGap = arg1;
            this.verticalGap = arg1;
            return;
        }

        public function get tileVerticalAlign():String
        {
            return this._tileVerticalAlign;
        }

        public function get horizontalGap():Number
        {
            return this._horizontalGap;
        }

        public function set horizontalGap(arg1:Number):void
        {
            if (this._horizontalGap == arg1) 
            {
                return;
            }
            this._horizontalGap = arg1;
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function set tileVerticalAlign(arg1:String):void
        {
            if (this._tileVerticalAlign == arg1) 
            {
                return;
            }
            this._tileVerticalAlign = arg1;
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function get verticalGap():Number
        {
            return this._verticalGap;
        }

        public function set verticalGap(arg1:Number):void
        {
            if (this._verticalGap == arg1) 
            {
                return;
            }
            this._verticalGap = arg1;
            this.dispatchEventWith(starling.events.Event.CHANGE);
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

        protected function calculateVerticalTileCount(arg1:Number, arg2:Number, arg3:Number, arg4:Number, arg5:Number, arg6:int, arg7:int, arg8:int, arg9:Boolean):int
        {
            var loc2:*=0;
            var loc1:*=Math.ceil(arg7 / arg8);
            if (arg9) 
            {
                if (arg6 > 0 && loc1 > arg6) 
                {
                    return arg6;
                }
                return loc1;
            }
            if (arg2 === arg2) 
            {
                loc2 = (arg2 - arg4 + arg5) / (arg1 + arg5);
                if (arg6 > 0 && loc2 > arg6) 
                {
                    return arg6;
                }
                if (loc2 > loc1) 
                {
                    loc2 = loc1;
                }
                if (loc2 < 1) 
                {
                    loc2 = 1;
                }
                return loc2;
            }
            if (arg6 > 0) 
            {
                loc2 = arg6;
            }
            else 
            {
                loc2 = loc1;
            }
            var loc3:*=int.MAX_VALUE;
            if (arg3 === arg3 && arg3 < Number.POSITIVE_INFINITY) 
            {
                loc3 = (arg3 - arg4 + arg5) / (arg1 + arg5);
                if (loc3 < 1) 
                {
                    loc3 = 1;
                }
            }
            if (loc2 > loc3) 
            {
                loc2 = loc3;
            }
            if (loc2 < 1) 
            {
                loc2 = 1;
            }
            return loc2;
        }

        public function get paddingTop():Number
        {
            return this._paddingTop;
        }

        public function set paddingTop(arg1:Number):void
        {
            if (this._paddingTop == arg1) 
            {
                return;
            }
            this._paddingTop = arg1;
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function set useSquareTiles(arg1:Boolean):void
        {
            if (this._useSquareTiles == arg1) 
            {
                return;
            }
            this._useSquareTiles = arg1;
            this.dispatchEventWith(starling.events.Event.CHANGE);
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
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function get tileHorizontalAlign():String
        {
            return this._tileHorizontalAlign;
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
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function set tileHorizontalAlign(arg1:String):void
        {
            if (this._tileHorizontalAlign == arg1) 
            {
                return;
            }
            this._tileHorizontalAlign = arg1;
            this.dispatchEventWith(starling.events.Event.CHANGE);
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
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function set distributeWidths(arg1:Boolean):void
        {
            if (this._distributeWidths === arg1) 
            {
                return;
            }
            this._distributeWidths = arg1;
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function get requestedColumnCount():int
        {
            return this._requestedColumnCount;
        }

        public function set requestedColumnCount(arg1:int):void
        {
            if (arg1 < 0) 
            {
                throw RangeError("requestedColumnCount requires a value >= 0");
            }
            if (this._requestedColumnCount == arg1) 
            {
                return;
            }
            this._requestedColumnCount = arg1;
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function get paging():String
        {
            return this._paging;
        }

        public function get requestedRowCount():int
        {
            return this._requestedRowCount;
        }

        public function set requestedRowCount(arg1:int):void
        {
            if (arg1 < 0) 
            {
                throw RangeError("requestedRowCount requires a value >= 0");
            }
            if (this._requestedRowCount == arg1) 
            {
                return;
            }
            this._requestedRowCount = arg1;
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function set paging(arg1:String):void
        {
            if (this._paging == arg1) 
            {
                return;
            }
            this._paging = arg1;
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function get verticalAlign():String
        {
            return this._verticalAlign;
        }

        public function set verticalAlign(arg1:String):void
        {
            if (this._verticalAlign == arg1) 
            {
                return;
            }
            this._verticalAlign = arg1;
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function get distributeWidths():Boolean
        {
            return this._distributeWidths;
        }

        public function get horizontalAlign():String
        {
            return this._horizontalAlign;
        }

        public function set horizontalAlign(arg1:String):void
        {
            if (this._horizontalAlign == arg1) 
            {
                return;
            }
            this._horizontalAlign = arg1;
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function get distributeHeights():Boolean
        {
            return this._distributeHeights;
        }

        public function set distributeHeights(arg1:Boolean):void
        {
            if (this._distributeHeights === arg1) 
            {
                return;
            }
            this._distributeHeights = arg1;
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function get useVirtualLayout():Boolean
        {
            return this._useVirtualLayout;
        }

        public function set useVirtualLayout(arg1:Boolean):void
        {
            if (this._useVirtualLayout == arg1) 
            {
                return;
            }
            this._useVirtualLayout = arg1;
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function get typicalItem():starling.display.DisplayObject
        {
            return this._typicalItem;
        }

        public function set typicalItem(arg1:starling.display.DisplayObject):void
        {
            if (this._typicalItem == arg1) 
            {
                return;
            }
            this._typicalItem = arg1;
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function get resetTypicalItemDimensionsOnMeasure():Boolean
        {
            return this._resetTypicalItemDimensionsOnMeasure;
        }

        public function set resetTypicalItemDimensionsOnMeasure(arg1:Boolean):void
        {
            if (this._resetTypicalItemDimensionsOnMeasure == arg1) 
            {
                return;
            }
            this._resetTypicalItemDimensionsOnMeasure = arg1;
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function get typicalItemWidth():Number
        {
            return this._typicalItemWidth;
        }

        public function set typicalItemWidth(arg1:Number):void
        {
            if (this._typicalItemWidth == arg1) 
            {
                return;
            }
            this._typicalItemWidth = arg1;
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function get typicalItemHeight():Number
        {
            return this._typicalItemHeight;
        }

        public function set typicalItemHeight(arg1:Number):void
        {
            if (this._typicalItemHeight == arg1) 
            {
                return;
            }
            this._typicalItemHeight = arg1;
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function get requiresLayoutOnScroll():Boolean
        {
            return this._useVirtualLayout;
        }

        public function layout(arg1:__AS3__.vec.Vector.<starling.display.DisplayObject>, arg2:feathers.layout.ViewPortBounds=null, arg3:feathers.layout.LayoutBoundsResult=null):feathers.layout.LayoutBoundsResult
        {
            var loc28:*=NaN;
            var loc29:*=NaN;
            var loc30:*=0;
            var loc31:*=null;
            var loc32:*=NaN;
            var loc33:*=NaN;
            var loc34:*=NaN;
            var loc35:*=NaN;
            var loc36:*=null;
            var loc37:*=0;
            var loc38:*=0;
            var loc39:*=NaN;
            var loc40:*=NaN;
            if (!arg3) 
            {
                arg3 = new feathers.layout.LayoutBoundsResult();
            }
            if (arg1.length === 0) 
            {
                arg3.contentX = 0;
                arg3.contentY = 0;
                arg3.contentWidth = this._paddingLeft + this._paddingRight;
                arg3.contentHeight = this._paddingTop + this._paddingBottom;
                arg3.viewPortWidth = arg3.contentWidth;
                arg3.viewPortHeight = arg3.contentHeight;
                return arg3;
            }
            var loc1:*=arg2 ? arg2.scrollX : 0;
            var loc2:*=arg2 ? arg2.scrollY : 0;
            var loc3:*=arg2 ? arg2.x : 0;
            var loc4:*=arg2 ? arg2.y : 0;
            var loc5:*=arg2 ? arg2.minWidth : 0;
            var loc6:*=arg2 ? arg2.minHeight : 0;
            var loc7:*=arg2 ? arg2.maxWidth : Number.POSITIVE_INFINITY;
            var loc8:*=arg2 ? arg2.maxHeight : Number.POSITIVE_INFINITY;
            var loc9:*=arg2 ? arg2.explicitWidth : NaN;
            var loc10:*=arg2 ? arg2.explicitHeight : NaN;
            if (this._useVirtualLayout) 
            {
                this.prepareTypicalItem();
                loc28 = this._typicalItem ? this._typicalItem.width : 0;
                loc29 = this._typicalItem ? this._typicalItem.height : 0;
            }
            this.validateItems(arg1);
            this._discoveredItemsCache.length = 0;
            var loc11:*=arg1.length;
            var loc12:*=0;
            var loc13:*=0;
            if (this._useVirtualLayout) 
            {
                loc12 = loc28;
                loc13 = loc29;
            }
            else 
            {
                loc30 = 0;
                while (loc30 < loc11) 
                {
                    loc31 = arg1[loc30];
                    if (loc31) 
                    {
                        if (!(loc31 is feathers.layout.ILayoutDisplayObject && !feathers.layout.ILayoutDisplayObject(loc31).includeInLayout)) 
                        {
                            loc32 = loc31.width;
                            loc33 = loc31.height;
                            if (loc32 > loc12) 
                            {
                                loc12 = loc32;
                            }
                            if (loc33 > loc13) 
                            {
                                loc13 = loc33;
                            }
                        }
                    }
                    ++loc30;
                }
            }
            if (loc12 < 0) 
            {
                loc12 = 0;
            }
            if (loc13 < 0) 
            {
                loc13 = 0;
            }
            if (this._useSquareTiles) 
            {
                if (loc12 > loc13) 
                {
                    loc13 = loc12;
                }
                else if (loc13 > loc12) 
                {
                    loc12 = loc13;
                }
            }
            var loc14:*=this.calculateHorizontalTileCount(loc12, loc9, loc7, this._paddingLeft + this._paddingRight, this._horizontalGap, this._requestedColumnCount, loc11);
            if (loc9 !== loc9) 
            {
                loc34 = this._paddingLeft + this._paddingRight + (loc12 + this._horizontalGap) * loc14 - this._horizontalGap;
                if (loc34 < loc5) 
                {
                    loc34 = loc5;
                }
                else if (loc34 > loc7) 
                {
                    loc34 = loc7;
                }
            }
            else 
            {
                loc34 = loc9;
            }
            if (this._distributeWidths) 
            {
                loc12 = (loc34 - this._paddingLeft - this._paddingRight - loc14 * this._horizontalGap + this._horizontalGap) / loc14;
                if (this._useSquareTiles) 
                {
                    loc13 = loc12;
                }
            }
            var loc15:*=this.calculateVerticalTileCount(loc13, loc10, loc8, this._paddingTop + this._paddingBottom, this._verticalGap, this._requestedRowCount, loc11, loc14, this._distributeHeights && !this._useSquareTiles);
            if (loc10 !== loc10) 
            {
                loc35 = this._paddingTop + this._paddingBottom + (loc13 + this._verticalGap) * loc15 - this._verticalGap;
                if (loc35 < loc6) 
                {
                    loc35 = loc6;
                }
                else if (loc35 > loc8) 
                {
                    loc35 = loc8;
                }
            }
            else 
            {
                loc35 = loc10;
            }
            if (this._distributeHeights && !this._useSquareTiles) 
            {
                loc13 = (loc35 - this._paddingTop - this._paddingBottom - loc15 * this._verticalGap + this._verticalGap) / loc15;
            }
            var loc16:*=loc14 * (loc12 + this._horizontalGap) - this._horizontalGap + this._paddingLeft + this._paddingRight;
            var loc17:*=loc15 * (loc13 + this._verticalGap) - this._verticalGap + this._paddingTop + this._paddingBottom;
            var loc18:*=loc3 + this._paddingLeft;
            var loc19:*=loc4 + this._paddingTop;
            var loc20:*=loc14 * loc15;
            var loc21:*=0;
            var loc22:*=loc20;
            var loc23:*=loc18;
            var loc24:*=loc18;
            var loc25:*=loc19;
            var loc26:*=0;
            var loc27:*=0;
            loc30 = 0;
            while (loc30 < loc11) 
            {
                loc31 = arg1[loc30];
                if (!(loc31 is feathers.layout.ILayoutDisplayObject && !feathers.layout.ILayoutDisplayObject(loc31).includeInLayout)) 
                {
                    if (!(loc26 == 0) && loc26 % loc14 == 0) 
                    {
                        loc24 = loc23;
                        loc25 = loc25 + (loc13 + this._verticalGap);
                    }
                    if (loc26 == loc22) 
                    {
                        if (this._paging !== PAGING_NONE) 
                        {
                            loc36 = this._useVirtualLayout ? this._discoveredItemsCache : arg1;
                            loc37 = this._useVirtualLayout ? 0 : loc26 - loc20;
                            loc38 = this._useVirtualLayout ? (this._discoveredItemsCache.length - 1) : (loc26 - 1);
                            this.applyHorizontalAlign(loc36, loc37, loc38, loc16, loc34);
                            this.applyVerticalAlign(loc36, loc37, loc38, loc17, loc35);
                            this._discoveredItemsCache.length = 0;
                            loc27 = 0;
                        }
                        ++loc21;
                        loc22 = loc22 + loc20;
                        if (this._paging !== PAGING_HORIZONTAL) 
                        {
                            if (this._paging === PAGING_VERTICAL) 
                            {
                                loc25 = loc19 + loc35 * loc21;
                            }
                        }
                        else 
                        {
                            var loc41:*;
                            loc23 = loc41 = loc18 + loc34 * loc21;
                            loc24 = loc41;
                            loc25 = loc19;
                        }
                    }
                    if (loc31) 
                    {
                        loc41 = this._tileHorizontalAlign;
                        switch (loc41) 
                        {
                            case feathers.layout.HorizontalAlign.JUSTIFY:
                            {
                                loc31.x = loc31.pivotX + loc24;
                                loc31.width = loc12;
                                break;
                            }
                            case feathers.layout.HorizontalAlign.LEFT:
                            {
                                loc31.x = loc31.pivotX + loc24;
                                break;
                            }
                            case feathers.layout.HorizontalAlign.RIGHT:
                            {
                                loc31.x = loc31.pivotX + loc24 + loc12 - loc31.width;
                                break;
                            }
                            default:
                            {
                                loc31.x = loc31.pivotX + loc24 + Math.round((loc12 - loc31.width) / 2);
                            }
                        }
                        loc41 = this._tileVerticalAlign;
                        switch (loc41) 
                        {
                            case feathers.layout.VerticalAlign.JUSTIFY:
                            {
                                loc31.y = loc31.pivotY + loc25;
                                loc31.height = loc13;
                                break;
                            }
                            case feathers.layout.VerticalAlign.TOP:
                            {
                                loc31.y = loc31.pivotY + loc25;
                                break;
                            }
                            case feathers.layout.VerticalAlign.BOTTOM:
                            {
                                loc31.y = loc31.pivotY + loc25 + loc13 - loc31.height;
                                break;
                            }
                            default:
                            {
                                loc31.y = loc31.pivotY + loc25 + Math.round((loc13 - loc31.height) / 2);
                            }
                        }
                        if (this._useVirtualLayout) 
                        {
                            this._discoveredItemsCache[loc27] = loc31;
                            ++loc27;
                        }
                    }
                    loc24 = loc24 + (loc12 + this._horizontalGap);
                    ++loc26;
                }
                ++loc30;
            }
            if (this._paging !== PAGING_NONE) 
            {
                loc36 = this._useVirtualLayout ? this._discoveredItemsCache : arg1;
                loc37 = this._useVirtualLayout ? 0 : loc22 - loc20;
                loc38 = this._useVirtualLayout ? (loc36.length - 1) : (loc30 - 1);
                this.applyHorizontalAlign(loc36, loc37, loc38, loc16, loc34);
                this.applyVerticalAlign(loc36, loc37, loc38, loc17, loc35);
            }
            if (this._paging !== PAGING_HORIZONTAL) 
            {
                loc39 = loc16;
            }
            else 
            {
                loc39 = Math.ceil(loc11 / loc20) * loc34;
            }
            if (this._paging !== PAGING_HORIZONTAL) 
            {
                if (this._paging !== PAGING_VERTICAL) 
                {
                    loc40 = loc25 + loc13 + this._paddingBottom;
                    if (loc40 < loc17) 
                    {
                        loc40 = loc17;
                    }
                }
                else 
                {
                    loc40 = Math.ceil(loc11 / loc20) * loc35;
                }
            }
            else 
            {
                loc40 = loc35;
            }
            if (this._paging === PAGING_NONE) 
            {
                loc36 = this._useVirtualLayout ? this._discoveredItemsCache : arg1;
                loc38 = (loc36.length - 1);
                this.applyHorizontalAlign(loc36, 0, loc38, loc39, loc34);
                this.applyVerticalAlign(loc36, 0, loc38, loc40, loc35);
            }
            this._discoveredItemsCache.length = 0;
            arg3.contentX = 0;
            arg3.contentY = 0;
            arg3.contentWidth = loc39;
            arg3.contentHeight = loc40;
            arg3.viewPortWidth = loc34;
            arg3.viewPortHeight = loc35;
            return arg3;
        }

        public function measureViewPort(arg1:int, arg2:feathers.layout.ViewPortBounds=null, arg3:flash.geom.Point=null):flash.geom.Point
        {
            var loc28:*=NaN;
            var loc29:*=NaN;
            var loc30:*=NaN;
            var loc31:*=NaN;
            var loc32:*=NaN;
            var loc33:*=NaN;
            if (!arg3) 
            {
                arg3 = new flash.geom.Point();
            }
            if (!this._useVirtualLayout) 
            {
                throw new flash.errors.IllegalOperationError("measureViewPort() may be called only if useVirtualLayout is true.");
            }
            var loc1:*=arg2 ? arg2.explicitWidth : NaN;
            var loc2:*=arg2 ? arg2.explicitHeight : NaN;
            var loc3:*=!(loc1 === loc1);
            var loc4:*=!(loc2 === loc2);
            if (!loc3 && !loc4) 
            {
                arg3.x = loc1;
                arg3.y = loc2;
                return arg3;
            }
            var loc5:*=arg2 ? arg2.x : 0;
            var loc6:*=arg2 ? arg2.y : 0;
            var loc7:*=arg2 ? arg2.minWidth : 0;
            var loc8:*=arg2 ? arg2.minHeight : 0;
            var loc9:*=arg2 ? arg2.maxWidth : Number.POSITIVE_INFINITY;
            var loc10:*=arg2 ? arg2.maxHeight : Number.POSITIVE_INFINITY;
            this.prepareTypicalItem();
            var loc11:*=this._typicalItem ? this._typicalItem.width : 0;
            var loc12:*=this._typicalItem ? this._typicalItem.height : 0;
            var loc13:*=loc11;
            var loc14:*=loc12;
            if (loc13 < 0) 
            {
                loc13 = 0;
            }
            if (loc14 < 0) 
            {
                loc14 = 0;
            }
            if (this._useSquareTiles) 
            {
                if (loc13 > loc14) 
                {
                    loc14 = loc13;
                }
                else if (loc14 > loc13) 
                {
                    loc13 = loc14;
                }
            }
            var loc15:*=this.calculateHorizontalTileCount(loc13, loc1, loc9, this._paddingLeft + this._paddingRight, this._horizontalGap, this._requestedColumnCount, arg1);
            var loc16:*=this.calculateVerticalTileCount(loc14, loc2, loc10, this._paddingTop + this._paddingBottom, this._verticalGap, this._requestedRowCount, arg1, loc15, this._distributeHeights && !this._useSquareTiles);
            if (loc1 !== loc1) 
            {
                loc28 = this._paddingLeft + this._paddingRight + (loc13 + this._horizontalGap) * loc15 - this._horizontalGap;
                if (loc28 < loc7) 
                {
                    loc28 = loc7;
                }
                else if (loc28 > loc9) 
                {
                    loc28 = loc9;
                }
            }
            else 
            {
                loc28 = loc1;
            }
            if (loc2 !== loc2) 
            {
                loc29 = this._paddingTop + this._paddingBottom + (loc14 + this._verticalGap) * loc16 - this._verticalGap;
                if (loc29 < loc8) 
                {
                    loc29 = loc8;
                }
                else if (loc29 > loc10) 
                {
                    loc29 = loc10;
                }
            }
            else 
            {
                loc29 = loc2;
            }
            var loc17:*=loc15 * (loc13 + this._horizontalGap) - this._horizontalGap + this._paddingLeft + this._paddingRight;
            var loc18:*=loc16 * (loc14 + this._verticalGap) - this._verticalGap + this._paddingTop + this._paddingBottom;
            var loc19:*=loc5 + this._paddingLeft;
            var loc20:*=loc6 + this._paddingTop;
            var loc21:*=loc15 * loc16;
            var loc22:*=0;
            var loc23:*=loc21;
            var loc24:*=loc19;
            var loc25:*=loc19;
            var loc26:*=loc20;
            var loc27:*=0;
            while (loc27 < arg1) 
            {
                if (!(loc27 == 0) && loc27 % loc15 == 0) 
                {
                    loc25 = loc24;
                    loc26 = loc26 + (loc14 + this._verticalGap);
                }
                if (loc27 == loc23) 
                {
                    ++loc22;
                    loc23 = loc23 + loc21;
                    if (this._paging !== PAGING_HORIZONTAL) 
                    {
                        if (this._paging === PAGING_VERTICAL) 
                        {
                            loc26 = loc20 + loc29 * loc22;
                        }
                    }
                    else 
                    {
                        var loc34:*;
                        loc24 = loc34 = loc19 + loc28 * loc22;
                        loc25 = loc34;
                        loc26 = loc20;
                    }
                }
                ++loc27;
            }
            if (this._paging !== PAGING_HORIZONTAL) 
            {
                loc30 = loc17;
            }
            else 
            {
                loc30 = Math.ceil(arg1 / loc21) * loc28;
            }
            if (this._paging !== PAGING_HORIZONTAL) 
            {
                if (this._paging !== PAGING_VERTICAL) 
                {
                    loc31 = loc26 + loc14 + this._paddingBottom;
                    if (loc31 < loc18) 
                    {
                        loc31 = loc18;
                    }
                }
                else 
                {
                    loc31 = Math.ceil(arg1 / loc21) * loc29;
                }
            }
            else 
            {
                loc31 = loc29;
            }
            if (loc3) 
            {
                loc32 = loc30;
                if (loc32 < loc7) 
                {
                    loc32 = loc7;
                }
                else if (loc32 > loc9) 
                {
                    loc32 = loc9;
                }
                arg3.x = loc32;
            }
            else 
            {
                arg3.x = loc1;
            }
            if (loc4) 
            {
                loc33 = loc31;
                if (loc33 < loc8) 
                {
                    loc33 = loc8;
                }
                else if (loc33 > loc10) 
                {
                    loc33 = loc10;
                }
                arg3.y = loc33;
            }
            else 
            {
                arg3.y = loc2;
            }
            return arg3;
        }

        public function getVisibleIndicesAtScrollPosition(arg1:Number, arg2:Number, arg3:Number, arg4:Number, arg5:int, arg6:__AS3__.vec.Vector.<int>=null):__AS3__.vec.Vector.<int>
        {
            if (arg6) 
            {
                arg6.length = 0;
            }
            else 
            {
                arg6 = new Vector.<int>(0);
            }
            if (!this._useVirtualLayout) 
            {
                throw new flash.errors.IllegalOperationError("getVisibleIndicesAtScrollPosition() may be called only if useVirtualLayout is true.");
            }
            if (this._paging !== PAGING_HORIZONTAL) 
            {
                if (this._paging !== PAGING_VERTICAL) 
                {
                    this.getVisibleIndicesAtScrollPositionWithoutPaging(arg1, arg2, arg3, arg4, arg5, arg6);
                }
                else 
                {
                    this.getVisibleIndicesAtScrollPositionWithVerticalPaging(arg1, arg2, arg3, arg4, arg5, arg6);
                }
            }
            else 
            {
                this.getVisibleIndicesAtScrollPositionWithHorizontalPaging(arg1, arg2, arg3, arg4, arg5, arg6);
            }
            return arg6;
        }

        public function getNearestScrollPositionForIndex(arg1:int, arg2:Number, arg3:Number, arg4:__AS3__.vec.Vector.<starling.display.DisplayObject>, arg5:Number, arg6:Number, arg7:Number, arg8:Number, arg9:flash.geom.Point=null):flash.geom.Point
        {
            return this.calculateScrollPositionForIndex(arg1, arg4, arg5, arg6, arg7, arg8, arg9, true, arg2, arg3);
        }

        public function getScrollPositionForIndex(arg1:int, arg2:__AS3__.vec.Vector.<starling.display.DisplayObject>, arg3:Number, arg4:Number, arg5:Number, arg6:Number, arg7:flash.geom.Point=null):flash.geom.Point
        {
            return this.calculateScrollPositionForIndex(arg1, arg2, arg3, arg4, arg5, arg6, arg7, false);
        }

        protected function applyHorizontalAlign(arg1:__AS3__.vec.Vector.<starling.display.DisplayObject>, arg2:int, arg3:int, arg4:Number, arg5:Number):void
        {
            var loc2:*=0;
            var loc3:*=null;
            if (arg4 >= arg5) 
            {
                return;
            }
            var loc1:*=0;
            if (this._horizontalAlign !== feathers.layout.HorizontalAlign.RIGHT) 
            {
                if (this._horizontalAlign !== feathers.layout.HorizontalAlign.LEFT) 
                {
                    loc1 = Math.round((arg5 - arg4) / 2);
                }
            }
            else 
            {
                loc1 = arg5 - arg4;
            }
            if (loc1 !== 0) 
            {
                loc2 = arg2;
                while (loc2 <= arg3) 
                {
                    loc3 = arg1[loc2];
                    if (!(loc3 is feathers.layout.ILayoutDisplayObject && !feathers.layout.ILayoutDisplayObject(loc3).includeInLayout)) 
                    {
                        loc3.x = loc3.x + loc1;
                    }
                    ++loc2;
                }
            }
            return;
        }

        protected function applyVerticalAlign(arg1:__AS3__.vec.Vector.<starling.display.DisplayObject>, arg2:int, arg3:int, arg4:Number, arg5:Number):void
        {
            var loc2:*=0;
            var loc3:*=null;
            if (arg4 >= arg5) 
            {
                return;
            }
            var loc1:*=0;
            if (this._verticalAlign !== feathers.layout.VerticalAlign.BOTTOM) 
            {
                if (this._verticalAlign === feathers.layout.VerticalAlign.MIDDLE) 
                {
                    loc1 = Math.round((arg5 - arg4) / 2);
                }
            }
            else 
            {
                loc1 = arg5 - arg4;
            }
            if (loc1 !== 0) 
            {
                loc2 = arg2;
                while (loc2 <= arg3) 
                {
                    loc3 = arg1[loc2];
                    if (!(loc3 is feathers.layout.ILayoutDisplayObject && !feathers.layout.ILayoutDisplayObject(loc3).includeInLayout)) 
                    {
                        loc3.y = loc3.y + loc1;
                    }
                    ++loc2;
                }
            }
            return;
        }

        protected function getVisibleIndicesAtScrollPositionWithHorizontalPaging(arg1:Number, arg2:Number, arg3:Number, arg4:Number, arg5:int, arg6:__AS3__.vec.Vector.<int>):void
        {
            var loc17:*=0;
            var loc18:*=0;
            var loc19:*=0;
            var loc20:*=0;
            var loc21:*=0;
            var loc22:*=0;
            this.prepareTypicalItem();
            var loc1:*=this._typicalItem ? this._typicalItem.width : 0;
            var loc2:*=this._typicalItem ? this._typicalItem.height : 0;
            var loc3:*=loc1;
            var loc4:*=loc2;
            if (loc3 < 0) 
            {
                loc3 = 0;
            }
            if (loc4 < 0) 
            {
                loc4 = 0;
            }
            if (this._useSquareTiles) 
            {
                if (loc3 > loc4) 
                {
                    loc4 = loc3;
                }
                else if (loc4 > loc3) 
                {
                    loc3 = loc4;
                }
            }
            var loc5:*=this.calculateHorizontalTileCount(loc3, arg3, arg3, this._paddingLeft + this._paddingRight, this._horizontalGap, this._requestedColumnCount, arg5);
            if (this._distributeWidths) 
            {
                loc3 = (arg3 - this._paddingLeft - this._paddingRight - loc5 * this._horizontalGap + this._horizontalGap) / loc5;
                if (this._useSquareTiles) 
                {
                    loc4 = loc3;
                }
            }
            var loc6:*=this.calculateVerticalTileCount(loc4, arg4, arg4, this._paddingTop + this._paddingBottom, this._verticalGap, this._requestedRowCount, arg5, loc5, this._distributeHeights && !this._useSquareTiles);
            if (this._distributeHeights && !this._useSquareTiles) 
            {
                loc4 = (arg4 - this._paddingTop - this._paddingBottom - loc6 * this._verticalGap + this._verticalGap) / loc6;
            }
            var loc7:*=loc5 * loc6;
            var loc8:*=loc7 + 2 * loc6;
            if (loc8 > arg5) 
            {
                loc8 = arg5;
            }
            var loc9:*=Math.round(arg1 / arg3);
            var loc10:*=loc9 * loc7;
            var loc11:*=loc5 * (loc3 + this._horizontalGap) - this._horizontalGap;
            var loc12:*=0;
            var loc13:*=0;
            if (loc11 < arg3) 
            {
                if (this._horizontalAlign !== feathers.layout.HorizontalAlign.RIGHT) 
                {
                    if (this._horizontalAlign !== feathers.layout.HorizontalAlign.CENTER) 
                    {
                        loc12 = 0;
                        loc13 = arg3 - this._paddingLeft - this._paddingRight - loc11;
                    }
                    else 
                    {
                        var loc23:*;
                        loc13 = loc23 = Math.round((arg3 - this._paddingLeft - this._paddingRight - loc11) / 2);
                        loc12 = loc23;
                    }
                }
                else 
                {
                    loc12 = arg3 - this._paddingLeft - this._paddingRight - loc11;
                    loc13 = 0;
                }
            }
            var loc14:*=0;
            var loc15:*=loc9 * arg3;
            var loc16:*=arg1 - loc15;
            if (loc16 < 0) 
            {
                loc16 = -loc16 - this._paddingRight - loc13;
                if (loc16 < 0) 
                {
                    loc16 = 0;
                }
                loc14 = (-Math.floor(loc16 / (loc3 + this._horizontalGap)) - 1);
                loc10 = loc10 + (-loc7 + loc5 + loc14);
            }
            else if (loc16 > 0) 
            {
                loc16 = loc16 - this._paddingLeft - loc12;
                if (loc16 < 0) 
                {
                    loc16 = 0;
                }
                loc14 = Math.floor(loc16 / (loc3 + this._horizontalGap));
                loc10 = loc10 + loc14;
            }
            if (loc10 < 0) 
            {
                loc10 = 0;
                loc14 = 0;
            }
            if (loc10 + loc8 >= arg5) 
            {
                loc17 = arg6.length;
                loc10 = arg5 - loc8;
                loc18 = loc10;
                while (loc18 < arg5) 
                {
                    arg6[loc17] = loc18;
                    ++loc17;
                    ++loc18;
                }
            }
            else 
            {
                loc19 = 0;
                loc20 = (loc5 + loc14) % loc5;
                loc21 = int(loc10 / loc7) * loc7;
                loc18 = loc10;
                loc22 = 0;
                do 
                {
                    if (loc18 < arg5) 
                    {
                        arg6[loc22] = loc18;
                        ++loc22;
                    }
                    ++loc19;
                    if (loc19 === loc6) 
                    {
                        loc19 = 0;
                        ++loc20;
                        if (loc20 === loc5) 
                        {
                            loc20 = 0;
                            loc21 = loc21 + loc7;
                        }
                        loc18 = loc21 + loc20 - loc5;
                    }
                    loc18 = loc18 + loc5;
                }
                while (loc22 < loc8 && loc21 < arg5);
            }
            return;
        }

        protected function getVisibleIndicesAtScrollPositionWithVerticalPaging(arg1:Number, arg2:Number, arg3:Number, arg4:Number, arg5:int, arg6:__AS3__.vec.Vector.<int>):void
        {
            this.prepareTypicalItem();
            var loc1:*=this._typicalItem ? this._typicalItem.width : 0;
            var loc2:*=this._typicalItem ? this._typicalItem.height : 0;
            var loc3:*=loc1;
            var loc4:*=loc2;
            if (loc3 < 0) 
            {
                loc3 = 0;
            }
            if (loc4 < 0) 
            {
                loc4 = 0;
            }
            if (this._useSquareTiles) 
            {
                if (loc3 > loc4) 
                {
                    loc4 = loc3;
                }
                else if (loc4 > loc3) 
                {
                    loc3 = loc4;
                }
            }
            var loc5:*=this.calculateHorizontalTileCount(loc3, arg3, arg3, this._paddingLeft + this._paddingRight, this._horizontalGap, this._requestedColumnCount, arg5);
            if (this._distributeWidths) 
            {
                loc3 = (arg3 - this._paddingLeft - this._paddingRight - loc5 * this._horizontalGap + this._horizontalGap) / loc5;
                if (this._useSquareTiles) 
                {
                    loc4 = loc3;
                }
            }
            var loc6:*=this.calculateVerticalTileCount(loc4, arg4, arg4, this._paddingTop + this._paddingBottom, this._verticalGap, this._requestedRowCount, arg5, loc5, this._distributeHeights && !this._useSquareTiles);
            if (this._distributeHeights && !this._useSquareTiles) 
            {
                loc4 = (arg4 - this._paddingTop - this._paddingBottom - loc6 * this._verticalGap + this._verticalGap) / loc6;
            }
            var loc7:*=loc5 * loc6;
            var loc8:*=loc7 + 2 * loc5;
            if (loc8 > arg5) 
            {
                loc8 = arg5;
            }
            var loc9:*=Math.round(arg2 / arg4);
            var loc10:*=loc9 * loc7;
            var loc11:*=loc6 * (loc4 + this._verticalGap) - this._verticalGap;
            var loc12:*=0;
            var loc13:*=0;
            if (loc11 < arg4) 
            {
                if (this._verticalAlign !== feathers.layout.VerticalAlign.BOTTOM) 
                {
                    if (this._verticalAlign !== feathers.layout.VerticalAlign.MIDDLE) 
                    {
                        loc12 = 0;
                        loc13 = arg4 - this._paddingTop - this._paddingBottom - loc11;
                    }
                    else 
                    {
                        var loc20:*;
                        loc13 = loc20 = Math.round((arg4 - this._paddingTop - this._paddingBottom - loc11) / 2);
                        loc12 = loc20;
                    }
                }
                else 
                {
                    loc12 = arg4 - this._paddingTop - this._paddingBottom - loc11;
                    loc13 = 0;
                }
            }
            var loc14:*=0;
            var loc15:*=loc9 * arg4;
            var loc16:*=arg2 - loc15;
            if (loc16 < 0) 
            {
                loc16 = -loc16 - this._paddingBottom - loc13;
                if (loc16 < 0) 
                {
                    loc16 = 0;
                }
                loc14 = (-Math.floor(loc16 / (loc4 + this._verticalGap)) - 1);
                loc10 = loc10 + loc5 * loc14;
            }
            else if (loc16 > 0) 
            {
                loc16 = loc16 - this._paddingTop - loc12;
                if (loc16 < 0) 
                {
                    loc16 = 0;
                }
                loc14 = Math.floor(loc16 / (loc4 + this._verticalGap));
                loc10 = loc10 + loc5 * loc14;
            }
            if (loc10 < 0) 
            {
                loc10 = 0;
                loc14 = 0;
            }
            var loc17:*=loc10 + loc8;
            if (loc17 > arg5) 
            {
                loc17 = arg5;
            }
            loc10 = loc17 - loc8;
            var loc18:*=arg6.length;
            var loc19:*=loc10;
            while (loc19 < loc17) 
            {
                arg6[loc18] = loc19;
                ++loc18;
                ++loc19;
            }
            return;
        }

        protected function getVisibleIndicesAtScrollPositionWithoutPaging(arg1:Number, arg2:Number, arg3:Number, arg4:Number, arg5:int, arg6:__AS3__.vec.Vector.<int>):void
        {
            var loc14:*=0;
            this.prepareTypicalItem();
            var loc1:*=this._typicalItem ? this._typicalItem.width : 0;
            var loc2:*=this._typicalItem ? this._typicalItem.height : 0;
            var loc3:*=loc1;
            var loc4:*=loc2;
            if (loc3 < 0) 
            {
                loc3 = 0;
            }
            if (loc4 < 0) 
            {
                loc4 = 0;
            }
            if (this._useSquareTiles) 
            {
                if (loc3 > loc4) 
                {
                    loc4 = loc3;
                }
                else if (loc4 > loc3) 
                {
                    loc3 = loc4;
                }
            }
            var loc5:*=this.calculateHorizontalTileCount(loc3, arg3, arg3, this._paddingLeft + this._paddingRight, this._horizontalGap, this._requestedColumnCount, arg5);
            if (this._distributeWidths) 
            {
                loc3 = (arg3 - this._paddingLeft - this._paddingRight - loc5 * this._horizontalGap + this._horizontalGap) / loc5;
                if (this._useSquareTiles) 
                {
                    loc4 = loc3;
                }
            }
            if (this._distributeHeights && !this._useSquareTiles) 
            {
                loc14 = this.calculateVerticalTileCount(loc4, arg4, arg4, this._paddingTop + this._paddingBottom, this._verticalGap, this._requestedRowCount, arg5, loc5, this._distributeHeights && !this._useSquareTiles);
                loc4 = (arg4 - this._paddingTop - this._paddingBottom - loc14 * this._verticalGap + this._verticalGap) / loc14;
            }
            loc14 = Math.ceil((arg4 + this._verticalGap) / (loc4 + this._verticalGap)) + 1;
            var loc6:*=loc14 * loc5;
            if (loc6 > arg5) 
            {
                loc6 = arg5;
            }
            var loc7:*=0;
            var loc8:*=Math.ceil(arg5 / loc5) * (loc4 + this._verticalGap) - this._verticalGap;
            if (loc8 < arg4) 
            {
                if (this._verticalAlign !== feathers.layout.VerticalAlign.BOTTOM) 
                {
                    if (this._verticalAlign === feathers.layout.VerticalAlign.MIDDLE) 
                    {
                        loc7 = Math.ceil((arg4 - loc8) / (loc4 + this._verticalGap) / 2);
                    }
                }
                else 
                {
                    loc7 = Math.ceil((arg4 - loc8) / (loc4 + this._verticalGap));
                }
            }
            var loc9:*=-loc7 + Math.floor((arg2 - this._paddingTop + this._verticalGap) / (loc4 + this._verticalGap));
            var loc10:*=loc9 * loc5;
            if (loc10 < 0) 
            {
                loc10 = 0;
            }
            var loc11:*=loc10 + loc6;
            if (loc11 > arg5) 
            {
                loc11 = arg5;
            }
            loc10 = loc11 - loc6;
            var loc12:*=arg6.length;
            var loc13:*=loc10;
            while (loc13 < loc11) 
            {
                arg6[loc12] = loc13;
                ++loc12;
                ++loc13;
            }
            return;
        }

        protected function validateItems(arg1:__AS3__.vec.Vector.<starling.display.DisplayObject>):void
        {
            var loc3:*=null;
            var loc1:*=arg1.length;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                loc3 = arg1[loc2];
                if (!(loc3 is feathers.layout.ILayoutDisplayObject && !feathers.layout.ILayoutDisplayObject(loc3).includeInLayout)) 
                {
                    if (loc3 is feathers.core.IValidating) 
                    {
                        feathers.core.IValidating(loc3).validate();
                    }
                }
                ++loc2;
            }
            return;
        }

        protected function prepareTypicalItem():void
        {
            if (!this._typicalItem) 
            {
                return;
            }
            if (this._resetTypicalItemDimensionsOnMeasure) 
            {
                this._typicalItem.width = this._typicalItemWidth;
                this._typicalItem.height = this._typicalItemHeight;
            }
            if (this._typicalItem is feathers.core.IValidating) 
            {
                feathers.core.IValidating(this._typicalItem).validate();
            }
            return;
        }

        public function calculateScrollPositionForIndex(arg1:int, arg2:__AS3__.vec.Vector.<starling.display.DisplayObject>, arg3:Number, arg4:Number, arg5:Number, arg6:Number, arg7:flash.geom.Point=null, arg8:Boolean=false, arg9:Number=0, arg10:Number=0):flash.geom.Point
        {
            var loc5:*=NaN;
            var loc6:*=NaN;
            var loc7:*=0;
            var loc8:*=null;
            var loc9:*=NaN;
            var loc10:*=NaN;
            var loc11:*=0;
            var loc12:*=NaN;
            var loc13:*=0;
            var loc14:*=NaN;
            var loc15:*=NaN;
            var loc16:*=NaN;
            var loc17:*=NaN;
            if (!arg7) 
            {
                arg7 = new flash.geom.Point();
            }
            if (this._useVirtualLayout) 
            {
                this.prepareTypicalItem();
                loc5 = this._typicalItem ? this._typicalItem.width : 0;
                loc6 = this._typicalItem ? this._typicalItem.height : 0;
            }
            var loc1:*=arg2.length;
            var loc2:*=this._useVirtualLayout ? loc5 : 0;
            var loc3:*=this._useVirtualLayout ? loc6 : 0;
            if (!this._useVirtualLayout) 
            {
                loc7 = 0;
                while (loc7 < loc1) 
                {
                    loc8 = arg2[loc7];
                    if (loc8) 
                    {
                        if (!(loc8 is feathers.layout.ILayoutDisplayObject && !feathers.layout.ILayoutDisplayObject(loc8).includeInLayout)) 
                        {
                            loc9 = loc8.width;
                            loc10 = loc8.height;
                            if (loc9 > loc2) 
                            {
                                loc2 = loc9;
                            }
                            if (loc10 > loc3) 
                            {
                                loc3 = loc10;
                            }
                        }
                    }
                    ++loc7;
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
            if (this._useSquareTiles) 
            {
                if (loc2 > loc3) 
                {
                    loc3 = loc2;
                }
                else if (loc3 > loc2) 
                {
                    loc2 = loc3;
                }
            }
            var loc4:*=(arg5 - this._paddingLeft - this._paddingRight + this._horizontalGap) / (loc2 + this._horizontalGap);
            if (loc4 < 1) 
            {
                loc4 = 1;
            }
            else if (this._requestedColumnCount > 0 && loc4 > this._requestedColumnCount) 
            {
                loc4 = this._requestedColumnCount;
            }
            if (this._paging === PAGING_NONE) 
            {
                loc14 = this._paddingTop + (loc3 + this._verticalGap) * int(arg1 / loc4);
                if (arg8) 
                {
                    loc15 = loc14 - (arg6 - loc3);
                    if (arg10 >= loc15 && arg10 <= loc14) 
                    {
                        loc14 = arg10;
                    }
                    else 
                    {
                        loc16 = Math.abs(loc14 - arg10);
                        loc17 = Math.abs(loc15 - arg10);
                        if (loc17 < loc16) 
                        {
                            loc14 = loc15;
                        }
                    }
                }
                else 
                {
                    loc14 = loc14 - Math.round((arg6 - loc3) / 2);
                }
                arg7.x = 0;
                arg7.y = loc14;
            }
            else 
            {
                loc11 = (arg6 - this._paddingTop - this._paddingBottom + this._verticalGap) / (loc3 + this._verticalGap);
                if (loc11 < 1) 
                {
                    loc11 = 1;
                }
                loc12 = loc4 * loc11;
                loc13 = arg1 / loc12;
                if (this._paging !== PAGING_HORIZONTAL) 
                {
                    arg7.x = 0;
                    arg7.y = loc13 * arg6;
                }
                else 
                {
                    arg7.x = loc13 * arg5;
                    arg7.y = 0;
                }
            }
            return arg7;
        }

        protected function calculateHorizontalTileCount(arg1:Number, arg2:Number, arg3:Number, arg4:Number, arg5:Number, arg6:int, arg7:int):int
        {
            var loc1:*=0;
            if (arg6 > 0 && this._distributeWidths) 
            {
                return arg6;
            }
            if (arg2 === arg2) 
            {
                loc1 = (arg2 - arg4 + arg5) / (arg1 + arg5);
                if (arg6 > 0 && loc1 > arg6) 
                {
                    return arg6;
                }
                if (loc1 > arg7) 
                {
                    loc1 = arg7;
                }
                if (loc1 < 1) 
                {
                    loc1 = 1;
                }
                return loc1;
            }
            if (arg6 > 0) 
            {
                loc1 = arg6;
            }
            else 
            {
                loc1 = arg7;
            }
            var loc2:*=int.MAX_VALUE;
            if (arg3 === arg3 && arg3 < Number.POSITIVE_INFINITY) 
            {
                loc2 = (arg3 - arg4 + arg5) / (arg1 + arg5);
                if (loc2 < 1) 
                {
                    loc2 = 1;
                }
            }
            if (loc1 > loc2) 
            {
                loc1 = loc2;
            }
            if (loc1 < 1) 
            {
                loc1 = 1;
            }
            return loc1;
        }

        public static const HORIZONTAL_ALIGN_CENTER:String="center";

        public static const VERTICAL_ALIGN_TOP:String="top";

        public static const VERTICAL_ALIGN_MIDDLE:String="middle";

        public static const VERTICAL_ALIGN_BOTTOM:String="bottom";

        public static const HORIZONTAL_ALIGN_LEFT:String="left";

        public static const HORIZONTAL_ALIGN_RIGHT:String="right";

        public static const TILE_VERTICAL_ALIGN_TOP:String="top";

        public static const TILE_VERTICAL_ALIGN_MIDDLE:String="middle";

        public static const TILE_VERTICAL_ALIGN_BOTTOM:String="bottom";

        public static const TILE_VERTICAL_ALIGN_JUSTIFY:String="justify";

        public static const TILE_HORIZONTAL_ALIGN_LEFT:String="left";

        public static const TILE_HORIZONTAL_ALIGN_CENTER:String="center";

        public static const TILE_HORIZONTAL_ALIGN_RIGHT:String="right";

        public static const TILE_HORIZONTAL_ALIGN_JUSTIFY:String="justify";

        public static const PAGING_HORIZONTAL:String="horizontal";

        public static const PAGING_VERTICAL:String="vertical";

        public static const PAGING_NONE:String="none";

        protected var _paddingLeft:Number=0;

        protected var _resetTypicalItemDimensionsOnMeasure:Boolean=false;

        protected var _requestedColumnCount:int=0;

        protected var _requestedRowCount:int=0;

        protected var _typicalItemWidth:Number=NaN;

        protected var _verticalAlign:String="top";

        protected var _horizontalAlign:String="center";

        protected var _typicalItemHeight:Number=NaN;

        protected var _tileVerticalAlign:String="middle";

        protected var _distributeHeights:Boolean=false;

        protected var _tileHorizontalAlign:String="center";

        protected var _paging:String="none";

        protected var _useSquareTiles:Boolean=true;

        protected var _distributeWidths:Boolean=false;

        protected var _paddingTop:Number=0;

        protected var _discoveredItemsCache:__AS3__.vec.Vector.<starling.display.DisplayObject>;

        protected var _horizontalGap:Number=0;

        protected var _useVirtualLayout:Boolean=true;

        protected var _verticalGap:Number=0;

        protected var _paddingRight:Number=0;

        protected var _typicalItem:starling.display.DisplayObject;

        protected var _paddingBottom:Number=0;
    }
}


