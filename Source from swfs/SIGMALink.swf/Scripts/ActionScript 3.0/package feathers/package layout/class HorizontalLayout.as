//class HorizontalLayout
package feathers.layout 
{
    import __AS3__.vec.*;
    import feathers.core.*;
    import flash.errors.*;
    import flash.geom.*;
    import starling.display.*;
    import starling.events.*;
    
    public class HorizontalLayout extends starling.events.EventDispatcher implements feathers.layout.IVariableVirtualLayout, feathers.layout.ITrimmedVirtualLayout
    {
        public function HorizontalLayout()
        {
            this._widthCache = [];
            this._discoveredItemsCache = new Vector.<starling.display.DisplayObject>(0);
            super();
            return;
        }

        public function set scrollPositionHorizontalAlign(arg1:String):void
        {
            this._scrollPositionHorizontalAlign = arg1;
            return;
        }

        public function get requiresLayoutOnScroll():Boolean
        {
            return this._useVirtualLayout;
        }

        public function layout(arg1:__AS3__.vec.Vector.<starling.display.DisplayObject>, arg2:feathers.layout.ViewPortBounds=null, arg3:feathers.layout.LayoutBoundsResult=null):feathers.layout.LayoutBoundsResult
        {
            var loc13:*=NaN;
            var loc34:*=NaN;
            var loc35:*=NaN;
            var loc36:*=null;
            var loc37:*=0;
            var loc38:*=NaN;
            var loc39:*=null;
            var loc40:*=NaN;
            var loc41:*=NaN;
            var loc42:*=NaN;
            var loc43:*=NaN;
            var loc44:*=null;
            var loc45:*=NaN;
            var loc46:*=null;
            var loc47:*=NaN;
            var loc48:*=NaN;
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
                this.prepareTypicalItem(loc10 - this._paddingTop - this._paddingBottom);
                loc34 = this._typicalItem ? this._typicalItem.width : 0;
                loc35 = this._typicalItem ? this._typicalItem.height : 0;
            }
            var loc11:*=!(loc9 === loc9);
            var loc12:*=!(loc10 === loc10);
            if (!loc11 && this._distributeWidths) 
            {
                loc13 = this.calculateDistributedWidth(arg1, loc9, loc5, loc7, false);
                if (this._useVirtualLayout) 
                {
                    loc34 = loc13;
                }
            }
            if (!this._useVirtualLayout || this._hasVariableItemDimensions || this._distributeWidths || !(this._verticalAlign == feathers.layout.VerticalAlign.JUSTIFY) || loc12) 
            {
                this.validateItems(arg1, loc10 - this._paddingTop - this._paddingBottom, loc6 - this._paddingTop - this._paddingBottom, loc8 - this._paddingTop - this._paddingBottom, loc9 - this._paddingLeft - this._paddingRight, loc5 - this._paddingLeft - this._paddingRight, loc7 - this._paddingLeft - this._paddingRight, loc13);
            }
            if (loc11 && this._distributeWidths) 
            {
                loc13 = this.calculateDistributedWidth(arg1, loc9, loc5, loc7, false);
            }
            var loc14:*=loc13 === loc13;
            if (!this._useVirtualLayout) 
            {
                this.applyPercentWidths(arg1, loc9, loc5, loc7);
            }
            var loc15:*=this._firstGap === this._firstGap;
            var loc16:*=this._lastGap === this._lastGap;
            var loc17:*=this._useVirtualLayout ? loc35 : 0;
            var loc18:*=loc3 + this._paddingLeft;
            var loc19:*=arg1.length;
            var loc20:*=loc19;
            var loc21:*=0;
            var loc22:*=Number.POSITIVE_INFINITY;
            if (this._useVirtualLayout && !this._hasVariableItemDimensions) 
            {
                loc20 = loc20 + (this._beforeVirtualizedItemCount + this._afterVirtualizedItemCount);
                loc18 = loc18 + this._beforeVirtualizedItemCount * (loc34 + this._gap);
                if (loc15 && this._beforeVirtualizedItemCount > 0) 
                {
                    loc18 = loc18 - this._gap + this._firstGap;
                }
            }
            var loc23:*=loc20 - 2;
            this._discoveredItemsCache.length = 0;
            var loc24:*=0;
            var loc25:*=0;
            var loc26:*=0;
            while (loc26 < loc19) 
            {
                if (!this._useVirtualLayout) 
                {
                    if (this._maxColumnCount > 0 && this._maxColumnCount === loc26) 
                    {
                        loc22 = loc18;
                    }
                    if (this._requestedColumnCount > 0 && this._requestedColumnCount === loc26) 
                    {
                        loc21 = loc18;
                    }
                }
                loc36 = arg1[loc26];
                loc37 = loc26 + this._beforeVirtualizedItemCount;
                loc25 = this._gap;
                if (loc15 && loc37 == 0) 
                {
                    loc25 = this._firstGap;
                }
                else if (loc16 && loc37 > 0 && loc37 == loc23) 
                {
                    loc25 = this._lastGap;
                }
                if (this._useVirtualLayout && this._hasVariableItemDimensions) 
                {
                    loc38 = this._widthCache[loc37];
                }
                if (this._useVirtualLayout && !loc36) 
                {
                    if (!this._hasVariableItemDimensions || !(loc38 === loc38)) 
                    {
                        loc18 = loc18 + (loc34 + loc25);
                    }
                    else 
                    {
                        loc18 = loc18 + (loc38 + loc25);
                    }
                }
                else 
                {
                    loc39 = loc36 as feathers.layout.ILayoutDisplayObject;
                    if (!(!(loc39 === null) && !loc39.includeInLayout)) 
                    {
                        loc36.x = loc36.pivotX + loc18;
                        if (loc14) 
                        {
                            var loc49:*;
                            loc40 = loc49 = loc13;
                            loc36.width = loc49;
                        }
                        else 
                        {
                            loc40 = loc36.width;
                        }
                        loc41 = loc36.height;
                        if (this._useVirtualLayout) 
                        {
                            if (this._hasVariableItemDimensions) 
                            {
                                if (loc40 != loc38) 
                                {
                                    this._widthCache[loc37] = loc40;
                                    if (loc18 < loc1 && !(loc38 === loc38) && !(loc40 == loc34)) 
                                    {
                                        this.dispatchEventWith(starling.events.Event.SCROLL, false, new flash.geom.Point(loc40 - loc34, 0));
                                    }
                                    this.dispatchEventWith(starling.events.Event.CHANGE);
                                }
                            }
                            else if (loc34 >= 0) 
                            {
                                loc40 = loc49 = loc34;
                                loc36.width = loc49;
                            }
                        }
                        loc18 = loc18 + (loc40 + loc25);
                        if (loc41 > loc17) 
                        {
                            loc17 = loc41;
                        }
                        if (this._useVirtualLayout) 
                        {
                            this._discoveredItemsCache[loc24] = loc36;
                            ++loc24;
                        }
                    }
                }
                ++loc26;
            }
            if (this._useVirtualLayout && !this._hasVariableItemDimensions) 
            {
                loc18 = loc18 + this._afterVirtualizedItemCount * (loc34 + this._gap);
                if (loc16 && this._afterVirtualizedItemCount > 0) 
                {
                    loc18 = loc18 - this._gap + this._lastGap;
                }
            }
            if (!this._useVirtualLayout && this._requestedColumnCount > loc19) 
            {
                if (loc19 > 0) 
                {
                    loc21 = this._requestedColumnCount * loc18 / loc19;
                }
                else 
                {
                    loc21 = 0;
                }
            }
            var loc27:*=this._useVirtualLayout ? this._discoveredItemsCache : arg1;
            var loc28:*=loc27.length;
            var loc29:*=loc17 + this._paddingTop + this._paddingBottom;
            var loc30:*=loc10;
            if (loc30 !== loc30) 
            {
                loc30 = loc29;
                if (loc30 < loc6) 
                {
                    loc30 = loc6;
                }
                else if (loc30 > loc8) 
                {
                    loc30 = loc8;
                }
            }
            var loc31:*=loc18 - loc25 + this._paddingRight - loc3;
            var loc32:*=loc9;
            if (loc32 !== loc32) 
            {
                if (this._requestedColumnCount > 0) 
                {
                    if (this._useVirtualLayout) 
                    {
                        loc32 = (loc34 + this._gap) * this._requestedColumnCount - this._gap + this._paddingLeft + this._paddingRight;
                    }
                    else 
                    {
                        loc32 = loc21;
                    }
                }
                else 
                {
                    loc32 = loc31;
                    if (this._maxColumnCount > 0) 
                    {
                        if (this._useVirtualLayout) 
                        {
                            loc22 = (loc34 + this._gap) * this._maxColumnCount - this._gap + this._paddingLeft + this._paddingRight;
                        }
                        if (loc22 < loc32) 
                        {
                            loc32 = loc22;
                        }
                    }
                }
                if (loc32 < loc5) 
                {
                    loc32 = loc5;
                }
                else if (loc32 > loc7) 
                {
                    loc32 = loc7;
                }
            }
            if (loc31 < loc32) 
            {
                loc42 = 0;
                if (this._horizontalAlign != feathers.layout.HorizontalAlign.RIGHT) 
                {
                    if (this._horizontalAlign == feathers.layout.HorizontalAlign.CENTER) 
                    {
                        loc42 = Math.round((loc32 - loc31) / 2);
                    }
                }
                else 
                {
                    loc42 = loc32 - loc31;
                }
                if (loc42 != 0) 
                {
                    loc26 = 0;
                    while (loc26 < loc28) 
                    {
                        loc36 = loc27[loc26];
                        if (!(loc36 is feathers.layout.ILayoutDisplayObject && !feathers.layout.ILayoutDisplayObject(loc36).includeInLayout)) 
                        {
                            loc36.x = loc36.x + loc42;
                        }
                        ++loc26;
                    }
                }
            }
            var loc33:*=loc30 - this._paddingTop - this._paddingBottom;
            loc26 = 0;
            while (loc26 < loc28) 
            {
                loc36 = loc27[loc26];
                loc39 = loc36 as feathers.layout.ILayoutDisplayObject;
                if (!(!(loc39 === null) && !loc39.includeInLayout)) 
                {
                    if (this._verticalAlign != feathers.layout.VerticalAlign.JUSTIFY) 
                    {
                        if (loc39 !== null) 
                        {
                            loc44 = loc39.layoutData as feathers.layout.HorizontalLayoutData;
                            if (loc44 !== null) 
                            {
                                loc45 = loc44.percentHeight;
                                if (loc45 === loc45) 
                                {
                                    if (loc45 < 0) 
                                    {
                                        loc45 = 0;
                                    }
                                    if (loc45 > 100) 
                                    {
                                        loc45 = 100;
                                    }
                                    loc41 = loc45 * loc33 / 100;
                                    if (loc36 is feathers.core.IFeathersControl) 
                                    {
                                        loc46 = feathers.core.IFeathersControl(loc36);
                                        loc47 = loc46.explicitMinHeight;
                                        if (loc47 > loc33) 
                                        {
                                            loc47 = loc33;
                                        }
                                        if (loc41 < loc47) 
                                        {
                                            loc41 = loc47;
                                        }
                                        else 
                                        {
                                            loc48 = loc46.explicitMaxHeight;
                                            if (loc41 > loc48) 
                                            {
                                                loc41 = loc48;
                                            }
                                        }
                                    }
                                    loc36.height = loc41;
                                }
                            }
                        }
                        loc43 = loc30;
                        if (loc29 > loc43) 
                        {
                            loc43 = loc29;
                        }
                        loc49 = this._verticalAlign;
                        switch (loc49) 
                        {
                            case feathers.layout.VerticalAlign.BOTTOM:
                            {
                                loc36.y = loc36.pivotY + loc4 + loc43 - this._paddingBottom - loc36.height;
                                break;
                            }
                            case feathers.layout.VerticalAlign.MIDDLE:
                            {
                                loc36.y = loc36.pivotY + loc4 + this._paddingTop + Math.round((loc43 - this._paddingTop - this._paddingBottom - loc36.height) / 2);
                                break;
                            }
                            default:
                            {
                                loc36.y = loc36.pivotY + loc4 + this._paddingTop;
                            }
                        }
                    }
                    else 
                    {
                        loc36.y = loc36.pivotY + loc4 + this._paddingTop;
                        loc36.height = loc33;
                    }
                }
                ++loc26;
            }
            this._discoveredItemsCache.length = 0;
            if (!arg3) 
            {
                arg3 = new feathers.layout.LayoutBoundsResult();
            }
            arg3.contentX = 0;
            arg3.contentWidth = loc31;
            arg3.contentY = 0;
            arg3.contentHeight = this._verticalAlign != feathers.layout.VerticalAlign.JUSTIFY ? loc29 : loc30;
            arg3.viewPortWidth = loc32;
            arg3.viewPortHeight = loc30;
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
            this.prepareTypicalItem(loc2 - this._paddingTop - this._paddingBottom);
            var loc9:*=this._typicalItem ? this._typicalItem.width : 0;
            var loc10:*=this._typicalItem ? this._typicalItem.height : 0;
            var loc11:*=this._firstGap === this._firstGap;
            var loc12:*=this._lastGap === this._lastGap;
            if (this._distributeWidths) 
            {
                loc13 = (loc9 + this._gap) * arg1;
            }
            else 
            {
                loc13 = 0;
                loc14 = loc10;
                if (this._hasVariableItemDimensions) 
                {
                    loc15 = 0;
                    while (loc15 < arg1) 
                    {
                        loc16 = this._widthCache[loc15];
                        if (loc16 === loc16) 
                        {
                            loc13 = loc13 + (loc16 + this._gap);
                        }
                        else 
                        {
                            loc13 = loc13 + (loc9 + this._gap);
                        }
                        ++loc15;
                    }
                }
                else 
                {
                    loc13 = loc13 + (loc9 + this._gap) * arg1;
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
                if (this._requestedColumnCount > 0) 
                {
                    loc17 = (loc9 + this._gap) * this._requestedColumnCount - this._gap + this._paddingLeft + this._paddingRight;
                }
                else 
                {
                    loc17 = loc13 + this._paddingLeft + this._paddingRight;
                    if (this._maxColumnCount > 0) 
                    {
                        loc18 = (loc9 + this._gap) * this._maxColumnCount - this._gap + this._paddingLeft + this._paddingRight;
                        if (loc18 < loc17) 
                        {
                            loc17 = loc18;
                        }
                    }
                }
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
                loc19 = loc14 + this._paddingTop + this._paddingBottom;
                if (loc19 < loc6) 
                {
                    loc19 = loc6;
                }
                else if (loc19 > loc8) 
                {
                    loc19 = loc8;
                }
                arg3.y = loc19;
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
            this._widthCache.length = 0;
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
            delete this._widthCache[arg1];
            if (arg2) 
            {
                this._widthCache[arg1] = arg2.width;
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
            var loc1:*=arg2 ? arg2.width : undefined;
            this._widthCache.insertAt(arg1, loc1);
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
            this._widthCache.removeAt(arg1);
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
            var loc12:*=NaN;
            var loc13:*=0;
            var loc14:*=0;
            var loc15:*=0;
            var loc16:*=0;
            var loc17:*=NaN;
            var loc18:*=NaN;
            var loc19:*=NaN;
            var loc20:*=NaN;
            var loc21:*=0;
            var loc22:*=0;
            var loc23:*=0;
            var loc24:*=0;
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
            this.prepareTypicalItem(arg4 - this._paddingTop - this._paddingBottom);
            var loc1:*=this._typicalItem ? this._typicalItem.width : 0;
            var loc2:*=this._typicalItem ? this._typicalItem.height : 0;
            var loc3:*=this._firstGap === this._firstGap;
            var loc4:*=this._lastGap === this._lastGap;
            var loc5:*=0;
            var loc6:*=Math.ceil(arg3 / (loc1 + this._gap)) + 1;
            if (!this._hasVariableItemDimensions) 
            {
                loc12 = arg5 * (loc1 + this._gap) - this._gap;
                if (loc3 && arg5 > 1) 
                {
                    loc12 = loc12 - this._gap + this._firstGap;
                }
                if (loc4 && arg5 > 2) 
                {
                    loc12 = loc12 - this._gap + this._lastGap;
                }
                loc13 = 0;
                if (loc12 < arg3) 
                {
                    if (this._horizontalAlign != feathers.layout.HorizontalAlign.RIGHT) 
                    {
                        if (this._horizontalAlign == feathers.layout.HorizontalAlign.CENTER) 
                        {
                            loc13 = Math.ceil((arg3 - loc12) / (loc1 + this._gap) / 2);
                        }
                    }
                    else 
                    {
                        loc13 = Math.ceil((arg3 - loc12) / (loc1 + this._gap));
                    }
                }
                loc14 = (arg1 - this._paddingLeft) / (loc1 + this._gap);
                if (loc14 < 0) 
                {
                    loc14 = 0;
                }
                loc14 = loc14 - loc13;
                loc15 = loc14 + loc6;
                if (loc15 >= arg5) 
                {
                    --loc15;
                }
                loc14 = loc15 - loc6;
                if (loc14 < 0) 
                {
                    loc14 = 0;
                }
                loc16 = loc14;
                while (loc16 <= loc15) 
                {
                    if (loc16 >= 0 && loc16 < arg5) 
                    {
                        arg6[loc5] = loc16;
                    }
                    else if (loc16 < 0) 
                    {
                        arg6[loc5] = arg5 + loc16;
                    }
                    else if (loc16 >= arg5) 
                    {
                        arg6[loc5] = loc16 - arg5;
                    }
                    ++loc5;
                    ++loc16;
                }
                return arg6;
            }
            var loc7:*=arg5 - 2;
            var loc8:*=arg1 + arg3;
            var loc9:*=this._paddingLeft;
            loc16 = 0;
            while (loc16 < arg5) 
            {
                loc17 = this._gap;
                if (loc3 && loc16 == 0) 
                {
                    loc17 = this._firstGap;
                }
                else if (loc4 && loc16 > 0 && loc16 == loc7) 
                {
                    loc17 = this._lastGap;
                }
                loc18 = this._widthCache[loc16];
                if (loc18 === loc18) 
                {
                    loc20 = loc18;
                }
                else 
                {
                    loc20 = loc1;
                }
                loc19 = loc9;
                loc9 = loc9 + (loc20 + loc17);
                if (loc9 > arg1 && loc19 < loc8) 
                {
                    arg6[loc5] = loc16;
                    ++loc5;
                }
                if (loc9 >= loc8) 
                {
                    break;
                }
                ++loc16;
            }
            var loc10:*=arg6.length;
            var loc11:*=loc6 - loc10;
            if (loc11 > 0 && loc10 > 0) 
            {
                loc21 = arg6[0];
                loc22 = loc21 - loc11;
                if (loc22 < 0) 
                {
                    loc22 = 0;
                }
                --loc16;
                while (loc16 >= loc22) 
                {
                    arg6.insertAt(0, loc16);
                    --loc16;
                }
            }
            loc10 = arg6.length;
            loc5 = loc10;
            loc11 = loc6 - loc10;
            if (loc11 > 0) 
            {
                loc23 = loc10 > 0 ? arg6[(loc10 - 1)] + 1 : 0;
                loc24 = loc23 + loc11;
                if (loc24 > arg5) 
                {
                    loc24 = arg5;
                }
                loc16 = loc23;
                while (loc16 < loc24) 
                {
                    arg6[loc5] = loc16;
                    ++loc5;
                    ++loc16;
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
            var loc3:*=NaN;
            var loc4:*=NaN;
            var loc5:*=NaN;
            var loc1:*=this.calculateMaxScrollXOfIndex(arg1, arg4, arg5, arg6, arg7, arg8);
            if (this._useVirtualLayout) 
            {
                if (this._hasVariableItemDimensions) 
                {
                    loc3 = this._widthCache[arg1];
                    if (loc3 !== loc3) 
                    {
                        loc3 = this._typicalItem.width;
                    }
                }
                else 
                {
                    loc3 = this._typicalItem.width;
                }
            }
            else 
            {
                loc3 = arg4[arg1].width;
            }
            if (!arg9) 
            {
                arg9 = new flash.geom.Point();
            }
            var loc2:*=loc1 - (arg7 - loc3);
            if (arg2 >= loc2 && arg2 <= loc1) 
            {
                arg9.x = arg2;
            }
            else 
            {
                loc4 = Math.abs(loc1 - arg2);
                loc5 = Math.abs(loc2 - arg2);
                if (loc5 < loc4) 
                {
                    arg9.x = loc2;
                }
                else 
                {
                    arg9.x = loc1;
                }
            }
            arg9.y = 0;
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
            var loc2:*=NaN;
            var loc1:*=this.calculateMaxScrollXOfIndex(arg1, arg2, arg3, arg4, arg5, arg6);
            if (this._useVirtualLayout) 
            {
                if (this._hasVariableItemDimensions) 
                {
                    loc2 = this._widthCache[arg1];
                    if (loc2 !== loc2) 
                    {
                        loc2 = this._typicalItem.width;
                    }
                }
                else 
                {
                    loc2 = this._typicalItem.width;
                }
            }
            else 
            {
                loc2 = arg2[arg1].width;
            }
            if (this._scrollPositionHorizontalAlign != feathers.layout.HorizontalAlign.CENTER) 
            {
                if (this._scrollPositionHorizontalAlign == feathers.layout.HorizontalAlign.RIGHT) 
                {
                    loc1 = loc1 - (arg5 - loc2);
                }
            }
            else 
            {
                loc1 = loc1 - Math.round((arg5 - loc2) / 2);
            }
            arg7.x = loc1;
            arg7.y = 0;
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
            var loc7:*=null;
            var loc8:*=null;
            var loc9:*=null;
            var loc10:*=null;
            var loc11:*=NaN;
            var loc12:*=NaN;
            var loc13:*=NaN;
            var loc14:*=null;
            var loc15:*=NaN;
            var loc16:*=NaN;
            var loc17:*=NaN;
            var loc1:*=!(arg5 === arg5);
            var loc2:*=!(arg2 === arg2);
            var loc3:*=arg5;
            if (loc1) 
            {
                loc3 = arg6;
            }
            var loc4:*=this._verticalAlign == feathers.layout.VerticalAlign.JUSTIFY;
            var loc5:*=arg1.length;
            var loc6:*=0;
            while (loc6 < loc5) 
            {
                loc7 = arg1[loc6];
                if (!(!loc7 || loc7 is feathers.layout.ILayoutDisplayObject && !feathers.layout.ILayoutDisplayObject(loc7).includeInLayout)) 
                {
                    if (this._distributeWidths) 
                    {
                        loc7.width = arg8;
                    }
                    if (loc4) 
                    {
                        loc7.height = arg2;
                        if (loc7 is feathers.core.IFeathersControl) 
                        {
                            loc8 = feathers.core.IFeathersControl(loc7);
                            loc8.minHeight = arg3;
                            loc8.maxHeight = arg4;
                        }
                    }
                    else if (loc7 is feathers.layout.ILayoutDisplayObject) 
                    {
                        loc9 = feathers.layout.ILayoutDisplayObject(loc7);
                        loc10 = loc9.layoutData as feathers.layout.HorizontalLayoutData;
                        if (loc10 !== null) 
                        {
                            loc11 = loc10.percentWidth;
                            loc12 = loc10.percentHeight;
                            if (loc11 === loc11) 
                            {
                                if (loc11 < 0) 
                                {
                                    loc11 = 0;
                                }
                                if (loc11 > 100) 
                                {
                                    loc11 = 100;
                                }
                                loc13 = loc3 * loc11 / 100;
                                loc14 = feathers.core.IMeasureDisplayObject(loc7);
                                loc15 = loc14.explicitMinWidth;
                                if (loc14.explicitMinWidth === loc14.explicitMinWidth && loc13 < loc15) 
                                {
                                    loc13 = loc15;
                                }
                                loc14.maxWidth = loc13;
                                loc7.width = NaN;
                            }
                            if (loc12 === loc12) 
                            {
                                if (loc12 < 0) 
                                {
                                    loc12 = 0;
                                }
                                if (loc12 > 100) 
                                {
                                    loc12 = 100;
                                }
                                loc16 = arg2 * loc12 / 100;
                                loc14 = feathers.core.IMeasureDisplayObject(loc7);
                                loc17 = loc14.explicitMinHeight;
                                if (loc14.explicitMinHeight === loc14.explicitMinHeight && loc16 < loc17) 
                                {
                                    loc16 = loc17;
                                }
                                if (loc16 > arg4) 
                                {
                                    loc16 = arg4;
                                }
                                loc7.height = loc16;
                                if (!(loc14.explicitHeight === loc14.explicitHeight) && loc14.maxHeight > arg4) 
                                {
                                    loc14.maxHeight = arg4;
                                }
                            }
                        }
                    }
                    if (loc7 is feathers.core.IValidating) 
                    {
                        feathers.core.IValidating(loc7).validate();
                    }
                }
                ++loc6;
            }
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

        protected function prepareTypicalItem(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=NaN;
            if (!this._typicalItem) 
            {
                return;
            }
            if (this._resetTypicalItemDimensionsOnMeasure) 
            {
                this._typicalItem.width = this._typicalItemWidth;
            }
            var loc1:*=false;
            if (this._verticalAlign == feathers.layout.VerticalAlign.JUSTIFY && arg1 === arg1) 
            {
                loc1 = true;
                this._typicalItem.height = arg1;
            }
            else if (this._typicalItem is feathers.layout.ILayoutDisplayObject) 
            {
                loc2 = feathers.layout.ILayoutDisplayObject(this._typicalItem);
                loc3 = loc2.layoutData as feathers.layout.VerticalLayoutData;
                if (loc3 !== null) 
                {
                    loc4 = loc3.percentHeight;
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
                        this._typicalItem.height = arg1 * loc4 / 100;
                    }
                }
            }
            if (!loc1 && this._resetTypicalItemDimensionsOnMeasure) 
            {
                this._typicalItem.height = this._typicalItemHeight;
            }
            if (this._typicalItem is feathers.core.IValidating) 
            {
                feathers.core.IValidating(this._typicalItem).validate();
            }
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

        protected function calculateDistributedWidth(arg1:__AS3__.vec.Vector.<starling.display.DisplayObject>, arg2:Number, arg3:Number, arg4:Number, arg5:Boolean):Number
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
                    loc8 = loc7.width;
                    if (loc8 > loc4) 
                    {
                        loc4 = loc8;
                    }
                    ++loc5;
                }
                arg2 = loc4 * loc2 + this._paddingLeft + this._paddingRight + this._gap * (loc2 - 1);
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
            loc3 = loc3 - this._paddingLeft - this._paddingRight - this._gap * (loc2 - 1);
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

        protected function applyPercentWidths(arg1:__AS3__.vec.Vector.<starling.display.DisplayObject>, arg2:Number, arg3:Number, arg4:Number):void
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
                        loc10 = loc9.layoutData as feathers.layout.HorizontalLayoutData;
                        if (loc10) 
                        {
                            loc11 = loc10.percentWidth;
                            if (loc11 !== loc11) 
                            {
                                loc2 = loc2 + loc8.width;
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
                                    loc3 = loc3 + loc12.minWidth;
                                }
                                loc4 = loc4 + loc11;
                                this._discoveredItemsCache[loc6] = loc8;
                                ++loc6;
                            }
                        }
                        else 
                        {
                            loc2 = loc2 + loc8.width;
                        }
                    }
                }
                else 
                {
                    loc2 = loc2 + loc8.width;
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
            loc2 = loc2 + (this._paddingLeft + this._paddingRight);
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
                        loc10 = feathers.layout.HorizontalLayoutData(loc9.layoutData);
                        loc11 = loc10.percentWidth;
                        if (loc11 < 0) 
                        {
                            loc11 = 0;
                        }
                        loc15 = loc14 * loc11;
                        if (loc9 is feathers.core.IFeathersControl) 
                        {
                            loc12 = feathers.core.IFeathersControl(loc9);
                            loc16 = loc12.explicitMinWidth;
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
                        loc9.width = loc15;
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

        public function get maxColumnCount():int
        {
            return this._maxColumnCount;
        }

        public function set maxColumnCount(arg1:int):void
        {
            if (arg1 < 0) 
            {
                throw RangeError("maxColumnCount requires a value >= 0");
            }
            if (this._maxColumnCount === arg1) 
            {
                return;
            }
            this._maxColumnCount = arg1;
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        protected function calculateMaxScrollXOfIndex(arg1:int, arg2:__AS3__.vec.Vector.<starling.display.DisplayObject>, arg3:Number, arg4:Number, arg5:Number, arg6:Number):Number
        {
            var loc12:*=NaN;
            var loc13:*=NaN;
            var loc14:*=null;
            var loc15:*=0;
            var loc16:*=NaN;
            var loc17:*=NaN;
            if (this._useVirtualLayout) 
            {
                this.prepareTypicalItem(arg6 - this._paddingTop - this._paddingBottom);
                loc12 = this._typicalItem ? this._typicalItem.width : 0;
                loc13 = this._typicalItem ? this._typicalItem.height : 0;
            }
            var loc1:*=this._firstGap === this._firstGap;
            var loc2:*=this._lastGap === this._lastGap;
            var loc3:*=arg3 + this._paddingLeft;
            var loc4:*=0;
            var loc5:*=this._gap;
            var loc6:*=0;
            var loc7:*=0;
            var loc8:*=arg2.length;
            var loc9:*=loc8;
            if (this._useVirtualLayout && !this._hasVariableItemDimensions) 
            {
                loc9 = loc9 + (this._beforeVirtualizedItemCount + this._afterVirtualizedItemCount);
                if (arg1 < this._beforeVirtualizedItemCount) 
                {
                    loc6 = arg1 + 1;
                    loc4 = loc12;
                    loc5 = this._gap;
                }
                else 
                {
                    loc6 = this._beforeVirtualizedItemCount;
                    loc7 = arg1 - arg2.length - this._beforeVirtualizedItemCount + 1;
                    if (loc7 < 0) 
                    {
                        loc7 = 0;
                    }
                    loc3 = loc3 + loc7 * (loc12 + this._gap);
                }
                loc3 = loc3 + loc6 * (loc12 + this._gap);
            }
            arg1 = arg1 - (loc6 + loc7);
            var loc10:*=loc9 - 2;
            var loc11:*=0;
            while (loc11 <= arg1) 
            {
                loc14 = arg2[loc11];
                loc15 = loc11 + loc6;
                if (loc1 && loc15 == 0) 
                {
                    loc5 = this._firstGap;
                }
                else if (loc2 && loc15 > 0 && loc15 == loc10) 
                {
                    loc5 = this._lastGap;
                }
                else 
                {
                    loc5 = this._gap;
                }
                if (this._useVirtualLayout && this._hasVariableItemDimensions) 
                {
                    loc16 = this._widthCache[loc15];
                }
                if (this._useVirtualLayout && !loc14) 
                {
                    if (!this._hasVariableItemDimensions || !(loc16 === loc16)) 
                    {
                        loc4 = loc12;
                    }
                    else 
                    {
                        loc4 = loc16;
                    }
                }
                else 
                {
                    loc17 = loc14.width;
                    if (this._useVirtualLayout) 
                    {
                        if (this._hasVariableItemDimensions) 
                        {
                            if (loc17 != loc16) 
                            {
                                this._widthCache[loc15] = loc17;
                                this.dispatchEventWith(starling.events.Event.CHANGE);
                            }
                        }
                        else if (loc12 >= 0) 
                        {
                            var loc18:*;
                            loc17 = loc18 = loc12;
                            loc14.width = loc18;
                        }
                    }
                    loc4 = loc17;
                }
                loc3 = loc3 + (loc4 + loc5);
                ++loc11;
            }
            loc3 = loc3 - (loc4 + loc5);
            return loc3;
        }

        public function get distributeWidths():Boolean
        {
            return this._distributeWidths;
        }

        public function set distributeWidths(arg1:Boolean):void
        {
            if (this._distributeWidths == arg1) 
            {
                return;
            }
            this._distributeWidths = arg1;
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

        public function get scrollPositionHorizontalAlign():String
        {
            return this._scrollPositionHorizontalAlign;
        }

        public static const VERTICAL_ALIGN_TOP:String="top";

        public static const VERTICAL_ALIGN_MIDDLE:String="middle";

        public static const VERTICAL_ALIGN_BOTTOM:String="bottom";

        public static const VERTICAL_ALIGN_JUSTIFY:String="justify";

        public static const HORIZONTAL_ALIGN_LEFT:String="left";

        public static const HORIZONTAL_ALIGN_CENTER:String="center";

        public static const HORIZONTAL_ALIGN_RIGHT:String="right";

        protected var _widthCache:Array;

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

        protected var _useVirtualLayout:Boolean=true;

        protected var _hasVariableItemDimensions:Boolean=false;

        protected var _requestedColumnCount:int=0;

        protected var _maxColumnCount:int=0;

        protected var _distributeWidths:Boolean=false;

        protected var _typicalItemHeight:Number=NaN;

        protected var _typicalItem:starling.display.DisplayObject;

        protected var _beforeVirtualizedItemCount:int=0;

        protected var _scrollPositionHorizontalAlign:String="center";

        protected var _typicalItemWidth:Number=NaN;

        protected var _afterVirtualizedItemCount:int=0;

        protected var _resetTypicalItemDimensionsOnMeasure:Boolean=false;
    }
}


