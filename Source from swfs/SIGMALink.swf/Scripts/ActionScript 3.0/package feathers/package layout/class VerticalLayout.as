//class VerticalLayout
package feathers.layout 
{
    import __AS3__.vec.*;
    import feathers.core.*;
    import flash.errors.*;
    import flash.geom.*;
    import starling.display.*;
    import starling.events.*;
    import starling.utils.*;
    
    public class VerticalLayout extends starling.events.EventDispatcher implements feathers.layout.IVariableVirtualLayout, feathers.layout.ITrimmedVirtualLayout, feathers.layout.IGroupedLayout
    {
        public function VerticalLayout()
        {
            this._heightCache = [];
            this._discoveredItemsCache = new Vector.<starling.display.DisplayObject>(0);
            super();
            return;
        }

        public function set scrollPositionVerticalAlign(arg1:String):void
        {
            this._scrollPositionVerticalAlign = arg1;
            return;
        }

        public function get requiresLayoutOnScroll():Boolean
        {
            return this._useVirtualLayout || this._headerIndices && this._stickyHeader;
        }

        public function layout(arg1:__AS3__.vec.Vector.<starling.display.DisplayObject>, arg2:feathers.layout.ViewPortBounds=null, arg3:feathers.layout.LayoutBoundsResult=null):feathers.layout.LayoutBoundsResult
        {
            var loc13:*=NaN;
            var loc40:*=NaN;
            var loc41:*=NaN;
            var loc42:*=null;
            var loc43:*=0;
            var loc44:*=NaN;
            var loc45:*=null;
            var loc46:*=NaN;
            var loc47:*=NaN;
            var loc48:*=null;
            var loc49:*=NaN;
            var loc50:*=NaN;
            var loc51:*=null;
            var loc52:*=NaN;
            var loc53:*=null;
            var loc54:*=NaN;
            var loc55:*=NaN;
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
                this.prepareTypicalItem(loc9 - this._paddingLeft - this._paddingRight);
                loc40 = this._typicalItem ? this._typicalItem.width : 0;
                loc41 = this._typicalItem ? this._typicalItem.height : 0;
            }
            var loc11:*=!(loc9 === loc9);
            var loc12:*=!(loc10 === loc10);
            if (!loc12 && this._distributeHeights) 
            {
                loc13 = this.calculateDistributedHeight(arg1, loc10, loc6, loc8, false);
                if (this._useVirtualLayout) 
                {
                    loc41 = loc13;
                }
            }
            if (!this._useVirtualLayout || this._hasVariableItemDimensions || this._distributeHeights || !(this._horizontalAlign == feathers.layout.HorizontalAlign.JUSTIFY) || loc11) 
            {
                this.validateItems(arg1, loc9 - this._paddingLeft - this._paddingRight, loc5 - this._paddingLeft - this._paddingRight, loc7 - this._paddingLeft - this._paddingRight, loc10 - this._paddingTop - this._paddingBottom, loc6 - this._paddingTop - this._paddingBottom, loc8 - this._paddingTop - this._paddingBottom, loc13);
            }
            if (loc12 && this._distributeHeights) 
            {
                loc13 = this.calculateDistributedHeight(arg1, loc10, loc6, loc8, true);
            }
            var loc14:*=loc13 === loc13;
            if (!this._useVirtualLayout) 
            {
                this.applyPercentHeights(arg1, loc10, loc6, loc8);
            }
            var loc15:*=this._firstGap === this._firstGap;
            var loc16:*=this._lastGap === this._lastGap;
            var loc17:*=this._useVirtualLayout ? loc40 : 0;
            var loc18:*=loc4 + this._paddingTop;
            var loc19:*=loc18;
            var loc20:*=0;
            var loc21:*=arg1.length;
            var loc22:*=loc21;
            var loc23:*=0;
            var loc24:*=Number.POSITIVE_INFINITY;
            if (this._useVirtualLayout && !this._hasVariableItemDimensions) 
            {
                loc22 = loc22 + (this._beforeVirtualizedItemCount + this._afterVirtualizedItemCount);
                loc20 = this._beforeVirtualizedItemCount;
                loc19 = loc19 + this._beforeVirtualizedItemCount * (loc41 + this._gap);
                if (loc15 && this._beforeVirtualizedItemCount > 0) 
                {
                    loc19 = loc19 - this._gap + this._firstGap;
                }
            }
            var loc25:*=loc22 - 2;
            this._discoveredItemsCache.length = 0;
            var loc26:*=0;
            var loc27:*=0;
            var loc28:*=-1;
            var loc29:*=-1;
            var loc30:*=0;
            var loc31:*=Number.POSITIVE_INFINITY;
            if (this._headerIndices && this._stickyHeader) 
            {
                loc30 = this._headerIndices.length;
                if (loc30 > 0) 
                {
                    loc28 = 0;
                    loc29 = this._headerIndices[loc28];
                }
            }
            var loc32:*=0;
            while (loc32 < loc21) 
            {
                if (!this._useVirtualLayout) 
                {
                    if (this._maxRowCount > 0 && this._maxRowCount === loc32) 
                    {
                        loc24 = loc19;
                    }
                    if (this._requestedRowCount > 0 && this._requestedRowCount === loc32) 
                    {
                        loc23 = loc19;
                    }
                }
                loc42 = arg1[loc32];
                loc43 = loc32 + loc20;
                if (loc29 === loc43) 
                {
                    if (loc19 - loc18 < loc2) 
                    {
                        ++loc28;
                        if (loc28 < loc30) 
                        {
                            loc29 = this._headerIndices[loc28];
                        }
                    }
                    else 
                    {
                        --loc28;
                        if (loc28 >= 0) 
                        {
                            loc29 = this._headerIndices[loc28];
                            loc31 = loc19;
                        }
                    }
                }
                loc27 = this._gap;
                if (loc15 && loc43 == 0) 
                {
                    loc27 = this._firstGap;
                }
                else if (loc16 && loc43 > 0 && loc43 == loc25) 
                {
                    loc27 = this._lastGap;
                }
                if (this._useVirtualLayout && this._hasVariableItemDimensions) 
                {
                    loc44 = this._heightCache[loc43];
                }
                if (this._useVirtualLayout && !loc42) 
                {
                    if (!this._hasVariableItemDimensions || !(loc44 === loc44)) 
                    {
                        loc19 = loc19 + (loc41 + loc27);
                    }
                    else 
                    {
                        loc19 = loc19 + (loc44 + loc27);
                    }
                }
                else 
                {
                    loc45 = loc42 as feathers.layout.ILayoutDisplayObject;
                    if (!(!(loc45 === null) && !loc45.includeInLayout)) 
                    {
                        loc42.y = loc42.pivotY + loc19;
                        loc46 = loc42.width;
                        if (loc14) 
                        {
                            var loc56:*;
                            loc47 = loc56 = loc13;
                            loc42.height = loc56;
                        }
                        else 
                        {
                            loc47 = loc42.height;
                        }
                        if (this._useVirtualLayout) 
                        {
                            if (this._hasVariableItemDimensions) 
                            {
                                if (loc47 != loc44) 
                                {
                                    this._heightCache[loc43] = loc47;
                                    if (loc19 < loc2 && !(loc44 === loc44) && !(loc47 == loc41)) 
                                    {
                                        this.dispatchEventWith(starling.events.Event.SCROLL, false, new flash.geom.Point(0, loc47 - loc41));
                                    }
                                    this.dispatchEventWith(starling.events.Event.CHANGE);
                                }
                            }
                            else if (loc41 >= 0) 
                            {
                                loc47 = loc56 = loc41;
                                loc42.height = loc56;
                            }
                        }
                        loc19 = loc19 + (loc47 + loc27);
                        if (loc46 > loc17) 
                        {
                            loc17 = loc46;
                        }
                        if (this._useVirtualLayout) 
                        {
                            this._discoveredItemsCache[loc26] = loc42;
                            ++loc26;
                        }
                    }
                }
                ++loc32;
            }
            if (this._useVirtualLayout && !this._hasVariableItemDimensions) 
            {
                loc19 = loc19 + this._afterVirtualizedItemCount * (loc41 + this._gap);
                if (loc16 && this._afterVirtualizedItemCount > 0) 
                {
                    loc19 = loc19 - this._gap + this._lastGap;
                }
            }
            if (loc29 >= 0) 
            {
                loc48 = arg1[loc29];
                this.positionStickyHeader(loc48, loc2, loc31);
            }
            if (!this._useVirtualLayout && this._requestedRowCount > loc21) 
            {
                if (loc21 > 0) 
                {
                    loc23 = this._requestedRowCount * loc19 / loc21;
                }
                else 
                {
                    loc23 = 0;
                }
            }
            var loc33:*=this._useVirtualLayout ? this._discoveredItemsCache : arg1;
            var loc34:*=loc33.length;
            var loc35:*=loc17 + this._paddingLeft + this._paddingRight;
            var loc36:*=loc9;
            if (loc36 !== loc36) 
            {
                loc36 = loc35;
                if (loc36 < loc5) 
                {
                    loc36 = loc5;
                }
                else if (loc36 > loc7) 
                {
                    loc36 = loc7;
                }
            }
            var loc37:*=loc19 - loc27 + this._paddingBottom - loc4;
            var loc38:*=loc10;
            if (loc38 !== loc38) 
            {
                loc38 = loc37;
                if (this._requestedRowCount > 0) 
                {
                    if (this._useVirtualLayout) 
                    {
                        loc38 = this._requestedRowCount * (loc41 + this._gap) - this._gap + this._paddingTop + this._paddingBottom;
                    }
                    else 
                    {
                        loc38 = loc23;
                    }
                }
                else 
                {
                    loc38 = loc37;
                    if (this._maxRowCount > 0) 
                    {
                        if (this._useVirtualLayout) 
                        {
                            loc24 = this._maxRowCount * (loc41 + this._gap) - this._gap + this._paddingTop + this._paddingBottom;
                        }
                        if (loc24 < loc38) 
                        {
                            loc38 = loc24;
                        }
                    }
                }
                if (loc38 < loc6) 
                {
                    loc38 = loc6;
                }
                else if (loc38 > loc8) 
                {
                    loc38 = loc8;
                }
            }
            if (loc37 < loc38) 
            {
                loc49 = 0;
                if (this._verticalAlign != feathers.layout.VerticalAlign.BOTTOM) 
                {
                    if (this._verticalAlign == feathers.layout.VerticalAlign.MIDDLE) 
                    {
                        loc49 = Math.round((loc38 - loc37) / 2);
                    }
                }
                else 
                {
                    loc49 = loc38 - loc37;
                }
                if (loc49 != 0) 
                {
                    loc32 = 0;
                    while (loc32 < loc34) 
                    {
                        loc42 = loc33[loc32];
                        if (!(loc42 is feathers.layout.ILayoutDisplayObject && !feathers.layout.ILayoutDisplayObject(loc42).includeInLayout)) 
                        {
                            loc42.y = loc42.y + loc49;
                        }
                        ++loc32;
                    }
                }
            }
            var loc39:*=loc36 - this._paddingLeft - this._paddingRight;
            loc32 = 0;
            while (loc32 < loc34) 
            {
                loc42 = loc33[loc32];
                loc45 = loc42 as feathers.layout.ILayoutDisplayObject;
                if (!(!(loc45 === null) && !loc45.includeInLayout)) 
                {
                    if (this._horizontalAlign != feathers.layout.HorizontalAlign.JUSTIFY) 
                    {
                        if (loc45 !== null) 
                        {
                            loc51 = loc45.layoutData as feathers.layout.VerticalLayoutData;
                            if (loc51 !== null) 
                            {
                                loc52 = loc51.percentWidth;
                                if (loc52 === loc52) 
                                {
                                    if (loc52 < 0) 
                                    {
                                        loc52 = 0;
                                    }
                                    if (loc52 > 100) 
                                    {
                                        loc52 = 100;
                                    }
                                    loc46 = loc52 * loc39 / 100;
                                    if (loc42 is feathers.core.IFeathersControl) 
                                    {
                                        loc53 = feathers.core.IFeathersControl(loc42);
                                        loc54 = loc53.explicitMinWidth;
                                        if (loc54 > loc39) 
                                        {
                                            loc54 = loc39;
                                        }
                                        if (loc46 < loc54) 
                                        {
                                            loc46 = loc54;
                                        }
                                        else 
                                        {
                                            loc55 = loc53.explicitMaxWidth;
                                            if (loc46 > loc55) 
                                            {
                                                loc46 = loc55;
                                            }
                                        }
                                    }
                                    loc42.width = loc46;
                                }
                            }
                        }
                        loc50 = loc36;
                        if (loc35 > loc50) 
                        {
                            loc50 = loc35;
                        }
                        loc56 = this._horizontalAlign;
                        switch (loc56) 
                        {
                            case feathers.layout.HorizontalAlign.RIGHT:
                            {
                                loc42.x = loc42.pivotX + loc3 + loc50 - this._paddingRight - loc42.width;
                                break;
                            }
                            case feathers.layout.HorizontalAlign.CENTER:
                            {
                                loc42.x = loc42.pivotX + loc3 + this._paddingLeft + Math.round((loc50 - this._paddingLeft - this._paddingRight - loc42.width) / 2);
                                break;
                            }
                            default:
                            {
                                loc42.x = loc42.pivotX + loc3 + this._paddingLeft;
                            }
                        }
                    }
                    else 
                    {
                        loc42.x = loc42.pivotX + loc3 + this._paddingLeft;
                        loc42.width = loc39;
                    }
                }
                ++loc32;
            }
            this._discoveredItemsCache.length = 0;
            if (!arg3) 
            {
                arg3 = new feathers.layout.LayoutBoundsResult();
            }
            arg3.contentX = 0;
            arg3.contentWidth = this._horizontalAlign != feathers.layout.HorizontalAlign.JUSTIFY ? loc35 : loc36;
            arg3.contentY = 0;
            arg3.contentHeight = loc37;
            arg3.viewPortWidth = loc36;
            arg3.viewPortHeight = loc38;
            return arg3;
        }

        public function get gap():Number
        {
            return this._gap;
        }

        public function set gap(arg1:Number):void
        {
            if (this._gap == arg1) 
            {
                return;
            }
            this._gap = arg1;
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function measureViewPort(arg1:int, arg2:feathers.layout.ViewPortBounds=null, arg3:flash.geom.Point=null):flash.geom.Point
        {
            var loc13:*=NaN;
            var loc14:*=NaN;
            var loc15:*=0;
            var loc16:*=NaN;
            var loc17:*=NaN;
            var loc18:*=NaN;
            var loc19:*=NaN;
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
            var loc5:*=arg2 ? arg2.minWidth : 0;
            var loc6:*=arg2 ? arg2.minHeight : 0;
            var loc7:*=arg2 ? arg2.maxWidth : Number.POSITIVE_INFINITY;
            var loc8:*=arg2 ? arg2.maxHeight : Number.POSITIVE_INFINITY;
            this.prepareTypicalItem(loc1 - this._paddingLeft - this._paddingRight);
            var loc9:*=this._typicalItem ? this._typicalItem.width : 0;
            var loc10:*=this._typicalItem ? this._typicalItem.height : 0;
            var loc11:*=this._firstGap === this._firstGap;
            var loc12:*=this._lastGap === this._lastGap;
            if (this._distributeHeights) 
            {
                loc13 = (loc10 + this._gap) * arg1;
            }
            else 
            {
                loc13 = 0;
                loc14 = loc9;
                if (this._hasVariableItemDimensions) 
                {
                    loc15 = 0;
                    while (loc15 < arg1) 
                    {
                        loc16 = this._heightCache[loc15];
                        if (loc16 === loc16) 
                        {
                            loc13 = loc13 + (loc16 + this._gap);
                        }
                        else 
                        {
                            loc13 = loc13 + (loc10 + this._gap);
                        }
                        ++loc15;
                    }
                }
                else 
                {
                    loc13 = loc13 + (loc10 + this._gap) * arg1;
                }
            }
            loc13 = loc13 - this._gap;
            if (loc11 && arg1 > 1) 
            {
                loc13 = loc13 - this._gap + this._firstGap;
            }
            if (loc12 && arg1 > 2) 
            {
                loc13 = loc13 - this._gap + this._lastGap;
            }
            if (loc3) 
            {
                loc17 = loc14 + this._paddingLeft + this._paddingRight;
                if (loc17 < loc5) 
                {
                    loc17 = loc5;
                }
                else if (loc17 > loc7) 
                {
                    loc17 = loc7;
                }
                arg3.x = loc17;
            }
            else 
            {
                arg3.x = loc1;
            }
            if (loc4) 
            {
                if (this._requestedRowCount > 0) 
                {
                    loc18 = (loc10 + this._gap) * this._requestedRowCount - this._gap;
                }
                else 
                {
                    loc18 = loc13;
                    if (this._maxRowCount > 0) 
                    {
                        loc19 = (loc10 + this._gap) * this._maxRowCount - this._gap;
                        if (loc19 < loc18) 
                        {
                            loc18 = loc19;
                        }
                    }
                }
                loc18 = loc18 + (this._paddingTop + this._paddingBottom);
                if (loc18 < loc6) 
                {
                    loc18 = loc6;
                }
                else if (loc18 > loc8) 
                {
                    loc18 = loc8;
                }
                arg3.y = loc18;
            }
            else 
            {
                arg3.y = loc2;
            }
            return arg3;
        }

        public function get firstGap():Number
        {
            return this._firstGap;
        }

        public function set firstGap(arg1:Number):void
        {
            if (this._firstGap == arg1) 
            {
                return;
            }
            this._firstGap = arg1;
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function resetVariableVirtualCache():void
        {
            this._heightCache.length = 0;
            return;
        }

        public function get lastGap():Number
        {
            return this._lastGap;
        }

        public function set lastGap(arg1:Number):void
        {
            if (this._lastGap == arg1) 
            {
                return;
            }
            this._lastGap = arg1;
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

        public function resetVariableVirtualCacheAtIndex(arg1:int, arg2:starling.display.DisplayObject=null):void
        {
            delete this._heightCache[arg1];
            if (arg2) 
            {
                this._heightCache[arg1] = arg2.height;
                this.dispatchEventWith(starling.events.Event.CHANGE);
            }
            return;
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

        public function addToVariableVirtualCacheAtIndex(arg1:int, arg2:starling.display.DisplayObject=null):void
        {
            var loc1:*=arg2 ? arg2.height : undefined;
            this._heightCache.insertAt(arg1, loc1);
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

        public function removeFromVariableVirtualCacheAtIndex(arg1:int):void
        {
            this._heightCache.removeAt(arg1);
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
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function getVisibleIndicesAtScrollPosition(arg1:Number, arg2:Number, arg3:Number, arg4:Number, arg5:int, arg6:__AS3__.vec.Vector.<int>=null):__AS3__.vec.Vector.<int>
        {
            var loc17:*=NaN;
            var loc18:*=0;
            var loc19:*=0;
            var loc20:*=0;
            var loc21:*=0;
            var loc22:*=NaN;
            var loc23:*=NaN;
            var loc24:*=NaN;
            var loc25:*=NaN;
            var loc26:*=false;
            var loc27:*=0;
            var loc28:*=0;
            var loc29:*=0;
            var loc30:*=0;
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
            this.prepareTypicalItem(arg3 - this._paddingLeft - this._paddingRight);
            var loc1:*=this._typicalItem ? this._typicalItem.width : 0;
            var loc2:*=this._typicalItem ? this._typicalItem.height : 0;
            var loc3:*=this._firstGap === this._firstGap;
            var loc4:*=this._lastGap === this._lastGap;
            var loc5:*=0;
            var loc6:*=Math.ceil(arg4 / (loc2 + this._gap)) + 1;
            if (!this._hasVariableItemDimensions) 
            {
                loc17 = arg5 * (loc2 + this._gap) - this._gap;
                if (loc3 && arg5 > 1) 
                {
                    loc17 = loc17 - this._gap + this._firstGap;
                }
                if (loc4 && arg5 > 2) 
                {
                    loc17 = loc17 - this._gap + this._lastGap;
                }
                loc18 = 0;
                if (loc17 < arg4) 
                {
                    if (this._verticalAlign != feathers.layout.VerticalAlign.BOTTOM) 
                    {
                        if (this._verticalAlign == feathers.layout.VerticalAlign.MIDDLE) 
                        {
                            loc18 = Math.ceil((arg4 - loc17) / (loc2 + this._gap) / 2);
                        }
                    }
                    else 
                    {
                        loc18 = Math.ceil((arg4 - loc17) / (loc2 + this._gap));
                    }
                }
                loc19 = (arg2 - this._paddingTop) / (loc2 + this._gap);
                if (loc19 < 0) 
                {
                    loc19 = 0;
                }
                loc19 = loc19 - loc18;
                loc20 = loc19 + loc6;
                if (loc20 >= arg5) 
                {
                    --loc20;
                }
                loc19 = loc20 - loc6;
                if (loc19 < 0) 
                {
                    loc19 = 0;
                }
                loc21 = loc19;
                while (loc21 <= loc20) 
                {
                    if (loc21 >= 0 && loc21 < arg5) 
                    {
                        arg6[loc5] = loc21;
                    }
                    else if (loc21 < 0) 
                    {
                        arg6[loc5] = arg5 + loc21;
                    }
                    else if (loc21 >= arg5) 
                    {
                        arg6[loc5] = loc21 - arg5;
                    }
                    ++loc5;
                    ++loc21;
                }
                return arg6;
            }
            var loc7:*=-1;
            var loc8:*=-1;
            var loc9:*=0;
            if (this._headerIndices && this._stickyHeader) 
            {
                loc9 = this._headerIndices.length;
                if (loc9 > 0) 
                {
                    loc7 = 0;
                    loc8 = this._headerIndices[loc7];
                }
            }
            var loc10:*=arg5 - 2;
            var loc11:*=arg2 + arg4;
            var loc12:*=this._paddingTop;
            var loc13:*=false;
            var loc14:*=loc12;
            loc21 = 0;
            while (loc21 < arg5) 
            {
                if (loc8 === loc21) 
                {
                    if (loc14 - loc12 < arg2) 
                    {
                        ++loc7;
                        if (loc7 < loc9) 
                        {
                            loc8 = this._headerIndices[loc7];
                        }
                    }
                    else 
                    {
                        --loc7;
                        if (loc7 >= 0) 
                        {
                            loc8 = this._headerIndices[loc7];
                            loc13 = true;
                        }
                    }
                }
                loc22 = this._gap;
                if (loc3 && loc21 == 0) 
                {
                    loc22 = this._firstGap;
                }
                else if (loc4 && loc21 > 0 && loc21 == loc10) 
                {
                    loc22 = this._lastGap;
                }
                loc23 = this._heightCache[loc21];
                if (loc23 === loc23) 
                {
                    loc25 = loc23;
                }
                else 
                {
                    loc25 = loc2;
                }
                loc24 = loc14;
                loc14 = loc14 + (loc25 + loc22);
                if (loc14 > arg2 && loc24 < loc11) 
                {
                    arg6[loc5] = loc21;
                    ++loc5;
                }
                if (loc14 >= loc11) 
                {
                    if (!loc13) 
                    {
                        --loc7;
                        if (loc7 >= 0) 
                        {
                            loc8 = this._headerIndices[loc7];
                        }
                    }
                    break;
                }
                ++loc21;
            }
            if (loc8 >= 0 && arg6.indexOf(loc8) < 0) 
            {
                loc26 = false;
                loc21 = 0;
                while (loc21 < loc5) 
                {
                    if (loc8 <= arg6[loc21]) 
                    {
                        arg6.insertAt(loc21, loc8);
                        loc26 = true;
                        break;
                    }
                    ++loc21;
                }
                if (!loc26) 
                {
                    arg6[loc5] = loc8;
                }
                ++loc5;
            }
            var loc15:*=arg6.length;
            var loc16:*=loc6 - loc15;
            if (loc16 > 0 && loc15 > 0) 
            {
                loc27 = arg6[0];
                loc28 = loc27 - loc16;
                if (loc28 < 0) 
                {
                    loc28 = 0;
                }
                --loc21;
                while (loc21 >= loc28) 
                {
                    if (loc21 !== loc8) 
                    {
                        arg6.insertAt(0, loc21);
                    }
                    --loc21;
                }
            }
            loc15 = arg6.length;
            loc16 = loc6 - loc15;
            loc5 = loc15;
            if (loc16 > 0) 
            {
                loc29 = loc15 > 0 ? arg6[(loc15 - 1)] + 1 : 0;
                loc30 = loc29 + loc16;
                if (loc30 > arg5) 
                {
                    loc30 = arg5;
                }
                loc21 = loc29;
                while (loc21 < loc30) 
                {
                    if (loc21 !== loc8) 
                    {
                        arg6[loc5] = loc21;
                        ++loc5;
                    }
                    ++loc21;
                }
            }
            return arg6;
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

        public function getNearestScrollPositionForIndex(arg1:int, arg2:Number, arg3:Number, arg4:__AS3__.vec.Vector.<starling.display.DisplayObject>, arg5:Number, arg6:Number, arg7:Number, arg8:Number, arg9:flash.geom.Point=null):flash.geom.Point
        {
            var loc6:*=NaN;
            var loc7:*=NaN;
            var loc8:*=NaN;
            var loc1:*=starling.utils.Pool.getPoint();
            this.calculateScrollRangeOfIndex(arg1, arg4, arg5, arg6, arg7, arg8, loc1);
            var loc2:*=loc1.x;
            var loc3:*=loc1.y;
            var loc4:*=loc3 - loc2;
            starling.utils.Pool.putPoint(loc1);
            if (this._useVirtualLayout) 
            {
                if (this._hasVariableItemDimensions) 
                {
                    loc6 = this._heightCache[arg1];
                    if (loc6 !== loc6) 
                    {
                        loc6 = this._typicalItem.height;
                    }
                }
                else 
                {
                    loc6 = this._typicalItem.height;
                }
            }
            else 
            {
                loc6 = arg4[arg1].height;
            }
            if (!arg9) 
            {
                arg9 = new flash.geom.Point();
            }
            arg9.x = 0;
            var loc5:*=loc3 - (loc4 - loc6);
            if (arg3 >= loc5 && arg3 <= loc3) 
            {
                arg9.y = arg3;
            }
            else 
            {
                loc7 = Math.abs(loc3 - arg3);
                loc8 = Math.abs(loc5 - arg3);
                if (loc8 < loc7) 
                {
                    arg9.y = loc5;
                }
                else 
                {
                    arg9.y = loc3;
                }
            }
            return arg9;
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

        public function getScrollPositionForIndex(arg1:int, arg2:__AS3__.vec.Vector.<starling.display.DisplayObject>, arg3:Number, arg4:Number, arg5:Number, arg6:Number, arg7:flash.geom.Point=null):flash.geom.Point
        {
            var loc5:*=NaN;
            var loc1:*=starling.utils.Pool.getPoint();
            this.calculateScrollRangeOfIndex(arg1, arg2, arg3, arg4, arg5, arg6, loc1);
            var loc2:*=loc1.x;
            var loc3:*=loc1.y;
            var loc4:*=loc3 - loc2;
            starling.utils.Pool.putPoint(loc1);
            if (this._useVirtualLayout) 
            {
                if (this._hasVariableItemDimensions) 
                {
                    loc5 = this._heightCache[arg1];
                    if (loc5 !== loc5) 
                    {
                        loc5 = this._typicalItem.height;
                    }
                }
                else 
                {
                    loc5 = this._typicalItem.height;
                }
            }
            else 
            {
                loc5 = arg2[arg1].height;
            }
            if (!arg7) 
            {
                arg7 = new flash.geom.Point();
            }
            arg7.x = 0;
            if (this._scrollPositionVerticalAlign != feathers.layout.VerticalAlign.MIDDLE) 
            {
                if (this._scrollPositionVerticalAlign == feathers.layout.VerticalAlign.BOTTOM) 
                {
                    loc3 = loc3 - (loc4 - loc5);
                }
            }
            else 
            {
                loc3 = loc3 - Math.round((loc4 - loc5) / 2);
            }
            arg7.y = loc3;
            return arg7;
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

        protected function validateItems(arg1:__AS3__.vec.Vector.<starling.display.DisplayObject>, arg2:Number, arg3:Number, arg4:Number, arg5:Number, arg6:Number, arg7:Number, arg8:Number):void
        {
            var loc6:*=null;
            var loc7:*=null;
            var loc8:*=null;
            var loc9:*=null;
            var loc10:*=NaN;
            var loc11:*=NaN;
            var loc12:*=NaN;
            var loc13:*=null;
            var loc14:*=NaN;
            var loc15:*=NaN;
            var loc16:*=NaN;
            var loc1:*=!(arg5 === arg5);
            var loc2:*=arg5;
            if (loc1) 
            {
                loc2 = arg6;
            }
            var loc3:*=this._horizontalAlign == feathers.layout.HorizontalAlign.JUSTIFY;
            var loc4:*=arg1.length;
            var loc5:*=0;
            while (loc5 < loc4) 
            {
                loc6 = arg1[loc5];
                if (!(!loc6 || loc6 is feathers.layout.ILayoutDisplayObject && !feathers.layout.ILayoutDisplayObject(loc6).includeInLayout)) 
                {
                    if (loc3) 
                    {
                        loc6.width = arg2;
                        if (loc6 is feathers.core.IFeathersControl) 
                        {
                            loc7 = feathers.core.IFeathersControl(loc6);
                            loc7.minWidth = arg3;
                            loc7.maxWidth = arg4;
                        }
                    }
                    else if (loc6 is feathers.layout.ILayoutDisplayObject) 
                    {
                        loc8 = feathers.layout.ILayoutDisplayObject(loc6);
                        loc9 = loc8.layoutData as feathers.layout.VerticalLayoutData;
                        if (loc9 !== null) 
                        {
                            loc10 = loc9.percentWidth;
                            loc11 = loc9.percentHeight;
                            if (loc10 === loc10) 
                            {
                                if (loc10 < 0) 
                                {
                                    loc10 = 0;
                                }
                                if (loc10 > 100) 
                                {
                                    loc10 = 100;
                                }
                                loc12 = arg2 * loc10 / 100;
                                loc13 = feathers.core.IMeasureDisplayObject(loc6);
                                loc14 = loc13.explicitMinWidth;
                                if (loc13.explicitMinWidth === loc13.explicitMinWidth && loc12 < loc14) 
                                {
                                    loc12 = loc14;
                                }
                                if (loc12 > arg4) 
                                {
                                    loc12 = arg4;
                                }
                                loc6.width = loc12;
                                if (!(loc13.explicitWidth === loc13.explicitWidth) && loc13.maxWidth > arg4) 
                                {
                                    loc13.maxWidth = arg4;
                                }
                            }
                            if (loc11 === loc11) 
                            {
                                loc15 = loc2 * loc11 / 100;
                                loc13 = feathers.core.IMeasureDisplayObject(loc6);
                                loc16 = loc13.explicitMinHeight;
                                if (loc13.explicitMinHeight === loc13.explicitMinHeight && loc15 < loc16) 
                                {
                                    loc15 = loc16;
                                }
                                loc13.maxHeight = loc15;
                                loc6.height = NaN;
                            }
                        }
                    }
                    if (this._distributeHeights) 
                    {
                        loc6.height = arg8;
                    }
                    if (loc6 is feathers.core.IValidating) 
                    {
                        feathers.core.IValidating(loc6).validate();
                    }
                }
                ++loc5;
            }
            return;
        }

        public function get stickyHeader():Boolean
        {
            return this._stickyHeader;
        }

        public function set stickyHeader(arg1:Boolean):void
        {
            if (this._stickyHeader == arg1) 
            {
                return;
            }
            this._stickyHeader = arg1;
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        protected function prepareTypicalItem(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=NaN;
            if (!this._typicalItem) 
            {
                return;
            }
            var loc1:*=false;
            if (this._horizontalAlign == feathers.layout.HorizontalAlign.JUSTIFY && arg1 === arg1) 
            {
                loc1 = true;
                this._typicalItem.width = arg1;
            }
            else if (this._typicalItem is feathers.layout.ILayoutDisplayObject) 
            {
                loc2 = feathers.layout.ILayoutDisplayObject(this._typicalItem);
                loc3 = loc2.layoutData as feathers.layout.VerticalLayoutData;
                if (loc3 !== null) 
                {
                    loc4 = loc3.percentWidth;
                    if (loc4 === loc4) 
                    {
                        if (loc4 < 0) 
                        {
                            loc4 = 0;
                        }
                        if (loc4 > 100) 
                        {
                            loc4 = 100;
                        }
                        loc1 = true;
                        this._typicalItem.width = arg1 * loc4 / 100;
                    }
                }
            }
            if (!loc1 && this._resetTypicalItemDimensionsOnMeasure) 
            {
                this._typicalItem.width = this._typicalItemWidth;
            }
            if (this._resetTypicalItemDimensionsOnMeasure) 
            {
                this._typicalItem.height = this._typicalItemHeight;
            }
            if (this._typicalItem is feathers.core.IValidating) 
            {
                feathers.core.IValidating(this._typicalItem).validate();
            }
            return;
        }

        public function get headerIndices():__AS3__.vec.Vector.<int>
        {
            return this._headerIndices;
        }

        public function set headerIndices(arg1:__AS3__.vec.Vector.<int>):void
        {
            if (this._headerIndices == arg1) 
            {
                return;
            }
            this._headerIndices = arg1;
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        protected function calculateDistributedHeight(arg1:__AS3__.vec.Vector.<starling.display.DisplayObject>, arg2:Number, arg3:Number, arg4:Number, arg5:Boolean):Number
        {
            var loc4:*=NaN;
            var loc5:*=0;
            var loc6:*=false;
            var loc7:*=null;
            var loc8:*=NaN;
            var loc1:*=!(arg2 === arg2);
            var loc2:*=arg1.length;
            if (arg5 && loc1) 
            {
                loc4 = 0;
                loc5 = 0;
                while (loc5 < loc2) 
                {
                    loc7 = arg1[loc5];
                    loc8 = loc7.height;
                    if (loc8 > loc4) 
                    {
                        loc4 = loc8;
                    }
                    ++loc5;
                }
                arg2 = loc4 * loc2 + this._paddingTop + this._paddingBottom + this._gap * (loc2 - 1);
                loc6 = false;
                if (arg2 > arg4) 
                {
                    arg2 = arg4;
                    loc6 = true;
                }
                else if (arg2 < arg3) 
                {
                    arg2 = arg3;
                    loc6 = true;
                }
                if (!loc6) 
                {
                    return loc4;
                }
            }
            var loc3:*=arg2;
            if (loc1 && arg4 < Number.POSITIVE_INFINITY) 
            {
                loc3 = arg4;
            }
            loc3 = loc3 - this._paddingTop - this._paddingBottom - this._gap * (loc2 - 1);
            if (loc2 > 1 && this._firstGap === this._firstGap) 
            {
                loc3 = loc3 + (this._gap - this._firstGap);
            }
            if (loc2 > 2 && this._lastGap === this._lastGap) 
            {
                loc3 = loc3 + (this._gap - this._lastGap);
            }
            return loc3 / loc2;
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

        protected function applyPercentHeights(arg1:__AS3__.vec.Vector.<starling.display.DisplayObject>, arg2:Number, arg3:Number, arg4:Number):void
        {
            var loc8:*=null;
            var loc9:*=null;
            var loc10:*=null;
            var loc11:*=NaN;
            var loc12:*=null;
            var loc13:*=false;
            var loc14:*=NaN;
            var loc15:*=NaN;
            var loc16:*=NaN;
            var loc1:*=arg2;
            this._discoveredItemsCache.length = 0;
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=0;
            var loc5:*=arg1.length;
            var loc6:*=0;
            var loc7:*=0;
            while (loc7 < loc5) 
            {
                loc8 = arg1[loc7];
                if (loc8 is feathers.layout.ILayoutDisplayObject) 
                {
                    loc9 = feathers.layout.ILayoutDisplayObject(loc8);
                    if (loc9.includeInLayout) 
                    {
                        loc10 = loc9.layoutData as feathers.layout.VerticalLayoutData;
                        if (loc10) 
                        {
                            loc11 = loc10.percentHeight;
                            if (loc11 !== loc11) 
                            {
                                loc2 = loc2 + loc8.height;
                            }
                            else 
                            {
                                if (loc11 < 0) 
                                {
                                    loc11 = 0;
                                }
                                if (loc9 is feathers.core.IFeathersControl) 
                                {
                                    loc12 = feathers.core.IFeathersControl(loc9);
                                    loc3 = loc3 + loc12.minHeight;
                                }
                                loc4 = loc4 + loc11;
                                this._discoveredItemsCache[loc6] = loc8;
                                ++loc6;
                            }
                        }
                        else 
                        {
                            loc2 = loc2 + loc8.height;
                        }
                    }
                }
                else 
                {
                    loc2 = loc2 + loc8.height;
                }
                ++loc7;
            }
            loc2 = loc2 + this._gap * (loc5 - 1);
            if (this._firstGap === this._firstGap && loc5 > 1) 
            {
                loc2 = loc2 + (this._firstGap - this._gap);
            }
            else if (this._lastGap === this._lastGap && loc5 > 2) 
            {
                loc2 = loc2 + (this._lastGap - this._gap);
            }
            loc2 = loc2 + (this._paddingTop + this._paddingBottom);
            if (loc4 < 100) 
            {
                loc4 = 100;
            }
            if (loc1 !== loc1) 
            {
                loc1 = loc2 + loc3;
                if (loc1 < arg3) 
                {
                    loc1 = arg3;
                }
                else if (loc1 > arg4) 
                {
                    loc1 = arg4;
                }
            }
            loc1 = loc1 - loc2;
            if (loc1 < 0) 
            {
                loc1 = 0;
            }
            do 
            {
                loc13 = false;
                loc14 = loc1 / loc4;
                loc7 = 0;
                while (loc7 < loc6) 
                {
                    loc9 = feathers.layout.ILayoutDisplayObject(this._discoveredItemsCache[loc7]);
                    if (loc9) 
                    {
                        loc10 = feathers.layout.VerticalLayoutData(loc9.layoutData);
                        loc11 = loc10.percentHeight;
                        if (loc11 < 0) 
                        {
                            loc11 = 0;
                        }
                        loc15 = loc14 * loc11;
                        if (loc9 is feathers.core.IFeathersControl) 
                        {
                            loc12 = feathers.core.IFeathersControl(loc9);
                            loc16 = loc12.explicitMinHeight;
                            if (loc16 > loc1) 
                            {
                                loc16 = loc1;
                            }
                            if (loc15 < loc16) 
                            {
                                loc15 = loc16;
                                loc1 = loc1 - loc15;
                                loc4 = loc4 - loc11;
                                this._discoveredItemsCache[loc7] = null;
                                loc13 = true;
                            }
                        }
                        loc9.height = loc15;
                        if (loc9 is feathers.core.IValidating) 
                        {
                            feathers.core.IValidating(loc9).validate();
                        }
                    }
                    ++loc7;
                }
            }
            while (loc13);
            this._discoveredItemsCache.length = 0;
            return;
        }

        public function get hasVariableItemDimensions():Boolean
        {
            return this._hasVariableItemDimensions;
        }

        public function set hasVariableItemDimensions(arg1:Boolean):void
        {
            if (this._hasVariableItemDimensions == arg1) 
            {
                return;
            }
            this._hasVariableItemDimensions = arg1;
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        protected function calculateScrollRangeOfIndex(arg1:int, arg2:__AS3__.vec.Vector.<starling.display.DisplayObject>, arg3:Number, arg4:Number, arg5:Number, arg6:Number, arg7:flash.geom.Point):void
        {
            var loc16:*=NaN;
            var loc17:*=NaN;
            var loc18:*=null;
            var loc19:*=0;
            var loc20:*=NaN;
            var loc21:*=NaN;
            if (this._useVirtualLayout) 
            {
                this.prepareTypicalItem(arg5 - this._paddingLeft - this._paddingRight);
                loc16 = this._typicalItem ? this._typicalItem.width : 0;
                loc17 = this._typicalItem ? this._typicalItem.height : 0;
            }
            var loc1:*=-1;
            var loc2:*=-1;
            var loc3:*=0;
            var loc4:*=0;
            if (this._headerIndices && this._stickyHeader) 
            {
                loc3 = this._headerIndices.length;
                if (loc3 > 0) 
                {
                    loc1 = 0;
                    loc2 = this._headerIndices[loc1];
                }
            }
            var loc5:*=this._firstGap === this._firstGap;
            var loc6:*=this._lastGap === this._lastGap;
            var loc7:*=arg4 + this._paddingTop;
            var loc8:*=0;
            var loc9:*=this._gap;
            var loc10:*=0;
            var loc11:*=0;
            var loc12:*=arg2.length;
            var loc13:*=loc12;
            if (this._useVirtualLayout && !this._hasVariableItemDimensions) 
            {
                loc13 = loc13 + (this._beforeVirtualizedItemCount + this._afterVirtualizedItemCount);
                if (arg1 < this._beforeVirtualizedItemCount) 
                {
                    loc10 = arg1 + 1;
                    loc8 = loc17;
                    loc9 = this._gap;
                }
                else 
                {
                    loc10 = this._beforeVirtualizedItemCount;
                    loc11 = arg1 - arg2.length - this._beforeVirtualizedItemCount + 1;
                    if (loc11 < 0) 
                    {
                        loc11 = 0;
                    }
                    loc7 = loc7 + loc11 * (loc17 + this._gap);
                }
                loc7 = loc7 + loc10 * (loc17 + this._gap);
            }
            arg1 = arg1 - (loc10 + loc11);
            var loc14:*=loc13 - 2;
            var loc15:*=0;
            while (loc15 <= arg1) 
            {
                loc18 = arg2[loc15];
                loc19 = loc15 + loc10;
                if (loc5 && loc19 == 0) 
                {
                    loc9 = this._firstGap;
                }
                else if (loc6 && loc19 > 0 && loc19 == loc14) 
                {
                    loc9 = this._lastGap;
                }
                else 
                {
                    loc9 = this._gap;
                }
                if (this._useVirtualLayout && this._hasVariableItemDimensions) 
                {
                    loc20 = this._heightCache[loc19];
                }
                if (this._useVirtualLayout && !loc18) 
                {
                    if (!this._hasVariableItemDimensions || !(loc20 === loc20)) 
                    {
                        loc8 = loc17;
                    }
                    else 
                    {
                        loc8 = loc20;
                    }
                }
                else 
                {
                    loc21 = loc18.height;
                    if (this._useVirtualLayout) 
                    {
                        if (this._hasVariableItemDimensions) 
                        {
                            if (loc21 != loc20) 
                            {
                                this._heightCache[loc19] = loc21;
                                this.dispatchEventWith(starling.events.Event.CHANGE);
                            }
                        }
                        else if (loc17 >= 0) 
                        {
                            var loc22:*;
                            loc21 = loc22 = loc17;
                            loc18.height = loc22;
                        }
                    }
                    loc8 = loc21;
                }
                loc7 = loc7 + (loc8 + loc9);
                if (loc2 === loc19) 
                {
                    loc4 = loc8;
                    ++loc1;
                    if (loc1 < loc3) 
                    {
                        loc2 = this._headerIndices[loc1];
                    }
                }
                ++loc15;
            }
            loc7 = loc7 - (loc8 + loc9);
            arg7.x = loc7 - arg6;
            if (this._stickyHeader) 
            {
                loc7 = loc7 - loc4;
            }
            arg7.y = loc7;
            return;
        }

        public function get distributeHeights():Boolean
        {
            return this._distributeHeights;
        }

        public function set distributeHeights(arg1:Boolean):void
        {
            if (this._distributeHeights == arg1) 
            {
                return;
            }
            this._distributeHeights = arg1;
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        protected function positionStickyHeader(arg1:starling.display.DisplayObject, arg2:Number, arg3:Number):void
        {
            if (!arg1 || arg1.y >= arg2) 
            {
                return;
            }
            if (arg1 is feathers.core.IValidating) 
            {
                feathers.core.IValidating(arg1).validate();
            }
            arg3 = arg3 - arg1.height;
            if (arg3 > arg2) 
            {
                arg3 = arg2;
            }
            arg1.y = arg3;
            var loc1:*=arg1.parent;
            if (loc1) 
            {
                loc1.setChildIndex(arg1, (loc1.numChildren - 1));
            }
            return;
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

        public function get maxRowCount():int
        {
            return this._maxRowCount;
        }

        public function set maxRowCount(arg1:int):void
        {
            if (arg1 < 0) 
            {
                throw RangeError("maxRowCount requires a value >= 0");
            }
            if (this._maxRowCount == arg1) 
            {
                return;
            }
            this._maxRowCount = arg1;
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function get beforeVirtualizedItemCount():int
        {
            return this._beforeVirtualizedItemCount;
        }

        public function set beforeVirtualizedItemCount(arg1:int):void
        {
            if (this._beforeVirtualizedItemCount == arg1) 
            {
                return;
            }
            this._beforeVirtualizedItemCount = arg1;
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function get afterVirtualizedItemCount():int
        {
            return this._afterVirtualizedItemCount;
        }

        public function set afterVirtualizedItemCount(arg1:int):void
        {
            if (this._afterVirtualizedItemCount == arg1) 
            {
                return;
            }
            this._afterVirtualizedItemCount = arg1;
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

        public function get scrollPositionVerticalAlign():String
        {
            return this._scrollPositionVerticalAlign;
        }

        public static const VERTICAL_ALIGN_TOP:String="top";

        public static const VERTICAL_ALIGN_MIDDLE:String="middle";

        public static const VERTICAL_ALIGN_BOTTOM:String="bottom";

        public static const HORIZONTAL_ALIGN_LEFT:String="left";

        public static const HORIZONTAL_ALIGN_CENTER:String="center";

        public static const HORIZONTAL_ALIGN_RIGHT:String="right";

        public static const HORIZONTAL_ALIGN_JUSTIFY:String="justify";

        protected var _heightCache:Array;

        protected var _discoveredItemsCache:__AS3__.vec.Vector.<starling.display.DisplayObject>;

        protected var _gap:Number=0;

        protected var _firstGap:Number=NaN;

        protected var _lastGap:Number=NaN;

        protected var _paddingTop:Number=0;

        protected var _paddingRight:Number=0;

        protected var _paddingBottom:Number=0;

        protected var _paddingLeft:Number=0;

        protected var _verticalAlign:String="top";

        protected var _horizontalAlign:String="left";

        protected var _stickyHeader:Boolean=false;

        protected var _headerIndices:__AS3__.vec.Vector.<int>;

        protected var _useVirtualLayout:Boolean=true;

        protected var _hasVariableItemDimensions:Boolean=false;

        protected var _distributeHeights:Boolean=false;

        protected var _requestedRowCount:int=0;

        protected var _afterVirtualizedItemCount:int=0;

        protected var _maxRowCount:int=0;

        protected var _typicalItemHeight:Number=NaN;

        protected var _resetTypicalItemDimensionsOnMeasure:Boolean=false;

        protected var _beforeVirtualizedItemCount:int=0;

        protected var _scrollPositionVerticalAlign:String="middle";

        protected var _typicalItem:starling.display.DisplayObject;

        protected var _typicalItemWidth:Number=NaN;
    }
}


