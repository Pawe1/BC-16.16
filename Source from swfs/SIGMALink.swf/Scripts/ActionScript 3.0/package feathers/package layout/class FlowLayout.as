//class FlowLayout
package feathers.layout 
{
    import __AS3__.vec.*;
    import feathers.core.*;
    import flash.errors.*;
    import flash.geom.*;
    import starling.display.*;
    import starling.events.*;
    
    public class FlowLayout extends starling.events.EventDispatcher implements feathers.layout.IVariableVirtualLayout
    {
        public function FlowLayout()
        {
            this._rowItems = new Vector.<starling.display.DisplayObject>(0);
            this._widthCache = [];
            this._heightCache = [];
            super();
            return;
        }

        public function removeFromVariableVirtualCacheAtIndex(arg1:int):void
        {
            this._widthCache.removeAt(arg1);
            this._heightCache.removeAt(arg1);
            return;
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

        public function layout(arg1:__AS3__.vec.Vector.<starling.display.DisplayObject>, arg2:feathers.layout.ViewPortBounds=null, arg3:feathers.layout.LayoutBoundsResult=null):feathers.layout.LayoutBoundsResult
        {
            var loc23:*=NaN;
            var loc24:*=NaN;
            var loc25:*=NaN;
            var loc26:*=0;
            var loc27:*=NaN;
            var loc28:*=NaN;
            var loc29:*=null;
            var loc30:*=NaN;
            var loc31:*=NaN;
            var loc32:*=NaN;
            var loc33:*=NaN;
            var loc34:*=0;
            var loc35:*=NaN;
            var loc36:*=0;
            var loc37:*=null;
            var loc38:*=NaN;
            var loc39:*=NaN;
            var loc1:*=arg2 ? arg2.x : 0;
            var loc2:*=arg2 ? arg2.y : 0;
            var loc3:*=arg2 ? arg2.minWidth : 0;
            var loc4:*=arg2 ? arg2.minHeight : 0;
            var loc5:*=arg2 ? arg2.maxWidth : Number.POSITIVE_INFINITY;
            var loc6:*=arg2 ? arg2.maxHeight : Number.POSITIVE_INFINITY;
            var loc7:*=arg2 ? arg2.explicitWidth : NaN;
            var loc8:*=arg2 ? arg2.explicitHeight : NaN;
            var loc9:*=!(loc7 === loc7);
            var loc10:*=true;
            var loc11:*=loc7;
            if (loc9) 
            {
                loc11 = loc5;
                if (loc11 === Number.POSITIVE_INFINITY) 
                {
                    loc10 = false;
                }
            }
            if (this._useVirtualLayout) 
            {
                if (this._typicalItem is feathers.core.IValidating) 
                {
                    feathers.core.IValidating(this._typicalItem).validate();
                }
                loc23 = this._typicalItem ? this._typicalItem.width : 0;
                loc24 = this._typicalItem ? this._typicalItem.height : 0;
            }
            var loc12:*=0;
            var loc13:*=arg1.length;
            var loc14:*=loc2 + this._paddingTop;
            var loc15:*=0;
            var loc16:*=0;
            var loc17:*=this._verticalGap;
            var loc18:*=this._firstHorizontalGap === this._firstHorizontalGap;
            var loc19:*=this._lastHorizontalGap === this._lastHorizontalGap;
            var loc20:*=loc13 - 2;
            do 
            {
                if (loc12 > 0) 
                {
                    loc14 = loc14 + (loc16 + loc17);
                }
                loc16 = this._useVirtualLayout ? loc24 : 0;
                loc25 = loc1 + this._paddingLeft;
                this._rowItems.length = 0;
                loc26 = 0;
                loc27 = 0;
                while (loc12 < loc13) 
                {
                    loc29 = arg1[loc12];
                    loc27 = this._horizontalGap;
                    if (loc18 && loc12 === 0) 
                    {
                        loc27 = this._firstHorizontalGap;
                    }
                    else if (loc19 && loc12 > 0 && loc12 == loc20) 
                    {
                        loc27 = this._lastHorizontalGap;
                    }
                    if (this._useVirtualLayout && this._hasVariableItemDimensions) 
                    {
                        loc30 = this._widthCache[loc12];
                        loc31 = this._heightCache[loc12];
                    }
                    if (this._useVirtualLayout && !loc29) 
                    {
                        if (this._hasVariableItemDimensions) 
                        {
                            if (loc30 === loc30) 
                            {
                                loc32 = loc30;
                            }
                            else 
                            {
                                loc32 = loc23;
                            }
                            if (loc31 === loc31) 
                            {
                                loc33 = loc31;
                            }
                            else 
                            {
                                loc33 = loc24;
                            }
                        }
                        else 
                        {
                            loc32 = loc23;
                            loc33 = loc24;
                        }
                        if (loc10 && loc26 > 0 && loc25 + loc32 > loc11 - this._paddingRight) 
                        {
                            --loc34;
                            loc27 = this._horizontalGap;
                            if (loc18 && loc34 === 0) 
                            {
                                loc27 = this._firstHorizontalGap;
                            }
                            else if (loc19 && loc34 > 0 && loc34 == loc20) 
                            {
                                loc27 = this._lastHorizontalGap;
                            }
                            break;
                        }
                        if (loc29) 
                        {
                            this._rowItems[this._rowItems.length] = loc29;
                            loc29.x = loc29.pivotX + loc25;
                        }
                        loc25 = loc25 + (loc32 + loc27);
                        if (loc33 > loc16) 
                        {
                            loc16 = loc33;
                        }
                        ++loc26;
                    }
                    else if (!(loc29 is feathers.layout.ILayoutDisplayObject && !feathers.layout.ILayoutDisplayObject(loc29).includeInLayout)) 
                    {
                        if (loc29 is feathers.core.IValidating) 
                        {
                            feathers.core.IValidating(loc29).validate();
                        }
                        loc32 = loc29.width;
                        loc33 = loc29.height;
                        if (this._useVirtualLayout) 
                        {
                            if (this._hasVariableItemDimensions) 
                            {
                                if (loc32 != loc30) 
                                {
                                    this._widthCache[loc12] = loc32;
                                    this.dispatchEventWith(starling.events.Event.CHANGE);
                                }
                                if (loc33 != loc31) 
                                {
                                    this._heightCache[loc12] = loc33;
                                    this.dispatchEventWith(starling.events.Event.CHANGE);
                                }
                            }
                            else 
                            {
                                if (loc23 >= 0) 
                                {
                                    var loc40:*;
                                    loc32 = loc40 = loc23;
                                    loc29.width = loc40;
                                }
                                if (loc24 >= 0) 
                                {
                                    loc33 = loc40 = loc24;
                                    loc29.height = loc40;
                                }
                            }
                        }
                        if (loc10 && loc26 > 0 && loc25 + loc32 > loc11 - this._paddingRight) 
                        {
                            --loc34;
                            loc27 = this._horizontalGap;
                            if (loc18 && loc34 === 0) 
                            {
                                loc27 = this._firstHorizontalGap;
                            }
                            else if (loc19 && loc34 > 0 && loc34 == loc20) 
                            {
                                loc27 = this._lastHorizontalGap;
                            }
                            break;
                        }
                        if (loc29) 
                        {
                            this._rowItems[this._rowItems.length] = loc29;
                            loc29.x = loc29.pivotX + loc25;
                        }
                        loc25 = loc25 + (loc32 + loc27);
                        if (loc33 > loc16) 
                        {
                            loc16 = loc33;
                        }
                        ++loc26;
                    }
                    ++loc12;
                }
                loc28 = loc25 - loc27 + this._paddingRight - loc1;
                if (loc28 > loc15) 
                {
                    loc15 = loc28;
                }
                loc26 = this._rowItems.length;
                if (loc10) 
                {
                    loc35 = 0;
                    if (this._horizontalAlign !== feathers.layout.HorizontalAlign.RIGHT) 
                    {
                        if (this._horizontalAlign === feathers.layout.HorizontalAlign.CENTER) 
                        {
                            loc35 = Math.round((loc11 - loc28) / 2);
                        }
                    }
                    else 
                    {
                        loc35 = loc11 - loc28;
                    }
                    if (loc35 !== 0) 
                    {
                        loc36 = 0;
                        while (loc36 < loc26) 
                        {
                            loc29 = this._rowItems[loc36];
                            if (!(loc29 is feathers.layout.ILayoutDisplayObject && !feathers.layout.ILayoutDisplayObject(loc29).includeInLayout)) 
                            {
                                loc29.x = loc29.x + loc35;
                            }
                            ++loc36;
                        }
                    }
                }
                loc36 = 0;
                while (loc36 < loc26) 
                {
                    loc29 = this._rowItems[loc36];
                    loc37 = loc29 as feathers.layout.ILayoutDisplayObject;
                    if (!(loc37 && !loc37.includeInLayout)) 
                    {
                        loc40 = this._rowVerticalAlign;
                        switch (loc40) 
                        {
                            case feathers.layout.VerticalAlign.BOTTOM:
                            {
                                loc29.y = loc29.pivotY + loc14 + loc16 - loc29.height;
                                break;
                            }
                            case feathers.layout.VerticalAlign.MIDDLE:
                            {
                                loc29.y = loc29.pivotY + loc14 + Math.round((loc16 - loc29.height) / 2);
                                break;
                            }
                            default:
                            {
                                loc29.y = loc29.pivotY + loc14;
                            }
                        }
                    }
                    ++loc36;
                }
            }
            while (loc12 < loc13);
            this._rowItems.length = 0;
            if (loc10 && (loc9 || loc7 < loc15)) 
            {
                loc38 = loc15;
                if (loc38 < loc3) 
                {
                    loc38 = loc3;
                }
                else if (loc38 > loc5) 
                {
                    loc38 = loc5;
                }
                loc35 = 0;
                if (this._horizontalAlign !== feathers.layout.HorizontalAlign.RIGHT) 
                {
                    if (this._horizontalAlign === feathers.layout.HorizontalAlign.CENTER) 
                    {
                        loc35 = Math.round((loc11 - loc38) / 2);
                    }
                }
                else 
                {
                    loc35 = loc11 - loc38;
                }
                if (loc35 !== 0) 
                {
                    loc12 = 0;
                    while (loc12 < loc13) 
                    {
                        loc29 = arg1[loc12];
                        if (!(!loc29 || loc29 is feathers.layout.ILayoutDisplayObject && !feathers.layout.ILayoutDisplayObject(loc29).includeInLayout)) 
                        {
                            loc29.x = loc29.x - loc35;
                        }
                        ++loc12;
                    }
                }
            }
            else 
            {
                loc38 = loc15;
            }
            if (loc9) 
            {
                loc11 = loc38;
            }
            var loc21:*=loc14 + loc16 + this._paddingBottom;
            var loc22:*=loc8;
            if (loc22 !== loc22) 
            {
                loc22 = loc21;
                if (loc22 < loc4) 
                {
                    loc22 = loc4;
                }
                else if (loc22 > loc6) 
                {
                    loc22 = loc6;
                }
            }
            if (loc21 < loc22 && !(this._verticalAlign == feathers.layout.VerticalAlign.TOP)) 
            {
                loc39 = loc22 - loc21;
                if (this._verticalAlign === feathers.layout.VerticalAlign.MIDDLE) 
                {
                    loc39 = loc39 / 2;
                }
                loc12 = 0;
                while (loc12 < loc13) 
                {
                    loc29 = arg1[loc12];
                    if (!(!loc29 || loc29 is feathers.layout.ILayoutDisplayObject && !feathers.layout.ILayoutDisplayObject(loc29).includeInLayout)) 
                    {
                        loc29.y = loc29.y + loc39;
                    }
                    ++loc12;
                }
            }
            if (!arg3) 
            {
                arg3 = new feathers.layout.LayoutBoundsResult();
            }
            arg3.contentX = 0;
            arg3.contentWidth = loc15;
            arg3.contentY = 0;
            arg3.contentHeight = loc21;
            arg3.viewPortWidth = loc11;
            arg3.viewPortHeight = loc22;
            return arg3;
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

        public function measureViewPort(arg1:int, arg2:feathers.layout.ViewPortBounds=null, arg3:flash.geom.Point=null):flash.geom.Point
        {
            var loc23:*=NaN;
            var loc24:*=0;
            var loc25:*=NaN;
            var loc26:*=NaN;
            var loc27:*=NaN;
            var loc28:*=NaN;
            var loc29:*=NaN;
            var loc30:*=NaN;
            if (!arg3) 
            {
                arg3 = new flash.geom.Point();
            }
            if (!this._useVirtualLayout) 
            {
                throw new flash.errors.IllegalOperationError("measureViewPort() may be called only if useVirtualLayout is true.");
            }
            var loc1:*=arg2 ? arg2.x : 0;
            var loc2:*=arg2 ? arg2.y : 0;
            var loc3:*=arg2 ? arg2.minWidth : 0;
            var loc4:*=arg2 ? arg2.minHeight : 0;
            var loc5:*=arg2 ? arg2.maxWidth : Number.POSITIVE_INFINITY;
            var loc6:*=arg2 ? arg2.maxHeight : Number.POSITIVE_INFINITY;
            var loc7:*=arg2 ? arg2.explicitWidth : NaN;
            var loc8:*=arg2 ? arg2.explicitHeight : NaN;
            var loc9:*=true;
            var loc10:*=loc7;
            if (loc10 !== loc10) 
            {
                loc10 = loc5;
                if (loc10 === Number.POSITIVE_INFINITY) 
                {
                    loc9 = false;
                }
            }
            if (this._typicalItem is feathers.core.IValidating) 
            {
                feathers.core.IValidating(this._typicalItem).validate();
            }
            var loc11:*=this._typicalItem ? this._typicalItem.width : 0;
            var loc12:*=this._typicalItem ? this._typicalItem.height : 0;
            var loc13:*=0;
            var loc14:*=loc2 + this._paddingTop;
            var loc15:*=0;
            var loc16:*=0;
            var loc17:*=this._verticalGap;
            var loc18:*=this._firstHorizontalGap === this._firstHorizontalGap;
            var loc19:*=this._lastHorizontalGap === this._lastHorizontalGap;
            var loc20:*=arg1 - 2;
            do 
            {
                if (loc13 > 0) 
                {
                    loc14 = loc14 + (loc16 + loc17);
                }
                loc16 = this._useVirtualLayout ? loc12 : 0;
                loc23 = loc1 + this._paddingLeft;
                loc24 = 0;
                loc25 = 0;
                while (loc13 < arg1) 
                {
                    loc25 = this._horizontalGap;
                    if (loc18 && loc13 === 0) 
                    {
                        loc25 = this._firstHorizontalGap;
                    }
                    else if (loc19 && loc13 > 0 && loc13 == loc20) 
                    {
                        loc25 = this._lastHorizontalGap;
                    }
                    if (this._hasVariableItemDimensions) 
                    {
                        loc27 = this._widthCache[loc13];
                        loc28 = this._heightCache[loc13];
                        if (loc27 === loc27) 
                        {
                            loc29 = loc27;
                        }
                        else 
                        {
                            loc29 = loc11;
                        }
                        if (loc28 === loc28) 
                        {
                            loc30 = loc28;
                        }
                        else 
                        {
                            loc30 = loc12;
                        }
                    }
                    else 
                    {
                        loc29 = loc11;
                        loc30 = loc12;
                    }
                    if (loc9 && loc24 > 0 && loc23 + loc29 > loc10 - this._paddingRight) 
                    {
                        break;
                    }
                    loc23 = loc23 + (loc29 + loc25);
                    if (loc30 > loc16) 
                    {
                        loc16 = loc30;
                    }
                    ++loc24;
                    ++loc13;
                }
                loc26 = loc23 - loc25 + this._paddingRight - loc1;
                if (loc26 > loc15) 
                {
                    loc15 = loc26;
                }
            }
            while (loc13 < arg1);
            if (loc9) 
            {
                if (loc7 !== loc7) 
                {
                    loc10 = loc15;
                    if (loc10 < loc3) 
                    {
                        loc10 = loc3;
                    }
                    else if (loc10 > loc5) 
                    {
                        loc10 = loc5;
                    }
                }
            }
            else 
            {
                loc10 = loc15;
            }
            var loc21:*=loc14 + loc16 + this._paddingBottom;
            var loc22:*=loc8;
            if (loc22 !== loc22) 
            {
                loc22 = loc21;
                if (loc22 < loc4) 
                {
                    loc22 = loc4;
                }
                else if (loc22 > loc6) 
                {
                    loc22 = loc6;
                }
            }
            arg3.x = loc10;
            arg3.y = loc22;
            return arg3;
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

        public function getNearestScrollPositionForIndex(arg1:int, arg2:Number, arg3:Number, arg4:__AS3__.vec.Vector.<starling.display.DisplayObject>, arg5:Number, arg6:Number, arg7:Number, arg8:Number, arg9:flash.geom.Point=null):flash.geom.Point
        {
            var loc4:*=NaN;
            var loc5:*=NaN;
            arg9 = this.calculateMaxScrollYAndRowHeightOfIndex(arg1, arg4, arg5, arg6, arg7, arg8, arg9);
            var loc1:*=arg9.x;
            var loc2:*=arg9.y;
            arg9.x = 0;
            var loc3:*=loc1 - (arg8 - loc2);
            if (arg3 >= loc3 && arg3 <= loc1) 
            {
                arg9.y = arg3;
            }
            else 
            {
                loc4 = Math.abs(loc1 - arg3);
                loc5 = Math.abs(loc3 - arg3);
                if (loc5 < loc4) 
                {
                    arg9.y = loc3;
                }
                else 
                {
                    arg9.y = loc1;
                }
            }
            return arg9;
        }

        public function get firstHorizontalGap():Number
        {
            return this._firstHorizontalGap;
        }

        public function set firstHorizontalGap(arg1:Number):void
        {
            if (this._firstHorizontalGap == arg1) 
            {
                return;
            }
            this._firstHorizontalGap = arg1;
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function getScrollPositionForIndex(arg1:int, arg2:__AS3__.vec.Vector.<starling.display.DisplayObject>, arg3:Number, arg4:Number, arg5:Number, arg6:Number, arg7:flash.geom.Point=null):flash.geom.Point
        {
            var loc3:*=NaN;
            arg7 = this.calculateMaxScrollYAndRowHeightOfIndex(arg1, arg2, arg3, arg4, arg5, arg6, arg7);
            var loc1:*=arg7.x;
            var loc2:*=arg7.y;
            if (this._useVirtualLayout) 
            {
                if (this._hasVariableItemDimensions) 
                {
                    loc3 = this._heightCache[arg1];
                    if (loc3 !== loc3) 
                    {
                        loc3 = this._typicalItem.height;
                    }
                }
                else 
                {
                    loc3 = this._typicalItem.height;
                }
            }
            else 
            {
                loc3 = arg2[arg1].height;
            }
            if (!arg7) 
            {
                arg7 = new flash.geom.Point();
            }
            arg7.x = 0;
            arg7.y = loc1 - Math.round((arg6 - loc3) / 2);
            return arg7;
        }

        public function get lastHorizontalGap():Number
        {
            return this._lastHorizontalGap;
        }

        public function set lastHorizontalGap(arg1:Number):void
        {
            if (this._lastHorizontalGap == arg1) 
            {
                return;
            }
            this._lastHorizontalGap = arg1;
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

        public function resetVariableVirtualCache():void
        {
            this._widthCache.length = 0;
            this._heightCache.length = 0;
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

        public function resetVariableVirtualCacheAtIndex(arg1:int, arg2:starling.display.DisplayObject=null):void
        {
            delete this._widthCache[arg1];
            delete this._heightCache[arg1];
            if (arg2) 
            {
                this._widthCache[arg1] = arg2.width;
                this._heightCache[arg1] = arg2.height;
                this.dispatchEventWith(starling.events.Event.CHANGE);
            }
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

        public function addToVariableVirtualCacheAtIndex(arg1:int, arg2:starling.display.DisplayObject=null):void
        {
            var loc1:*=arg2 ? arg2.width : undefined;
            var loc2:*=arg2 ? arg2.height : undefined;
            this._widthCache.insertAt(arg1, loc1);
            this._heightCache.insertAt(arg1, loc2);
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
            var loc14:*=NaN;
            var loc15:*=NaN;
            var loc16:*=NaN;
            var loc17:*=NaN;
            var loc18:*=NaN;
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
            if (this._typicalItem is feathers.core.IValidating) 
            {
                feathers.core.IValidating(this._typicalItem).validate();
            }
            var loc1:*=this._typicalItem ? this._typicalItem.width : 0;
            var loc2:*=this._typicalItem ? this._typicalItem.height : 0;
            var loc3:*=0;
            var loc4:*=0;
            var loc5:*=this._paddingTop;
            var loc6:*=0;
            var loc7:*=this._verticalGap;
            var loc8:*=arg2 + arg4;
            var loc9:*=this._firstHorizontalGap === this._firstHorizontalGap;
            var loc10:*=this._lastHorizontalGap === this._lastHorizontalGap;
            var loc11:*=arg5 - 2;
            do 
            {
                if (loc4 > 0) 
                {
                    loc5 = loc5 + (loc6 + loc7);
                    if (loc5 >= loc8) 
                    {
                        break;
                    }
                }
                loc6 = loc2;
                loc12 = this._paddingLeft;
                loc13 = 0;
                while (loc4 < arg5) 
                {
                    loc14 = this._horizontalGap;
                    if (loc9 && loc4 === 0) 
                    {
                        loc14 = this._firstHorizontalGap;
                    }
                    else if (loc10 && loc4 > 0 && loc4 == loc11) 
                    {
                        loc14 = this._lastHorizontalGap;
                    }
                    if (this._hasVariableItemDimensions) 
                    {
                        loc15 = this._widthCache[loc4];
                        loc16 = this._heightCache[loc4];
                    }
                    if (this._hasVariableItemDimensions) 
                    {
                        if (loc15 === loc15) 
                        {
                            loc17 = loc15;
                        }
                        else 
                        {
                            loc17 = loc1;
                        }
                        if (loc16 === loc16) 
                        {
                            loc18 = loc16;
                        }
                        else 
                        {
                            loc18 = loc2;
                        }
                    }
                    else 
                    {
                        loc17 = loc1;
                        loc18 = loc2;
                    }
                    if (loc13 > 0 && loc12 + loc17 > arg3 - this._paddingRight) 
                    {
                        break;
                    }
                    if (loc5 + loc18 > arg2) 
                    {
                        arg6[loc3] = loc4;
                        ++loc3;
                    }
                    loc12 = loc12 + (loc17 + loc14);
                    if (loc18 > loc6) 
                    {
                        loc6 = loc18;
                    }
                    ++loc13;
                    ++loc4;
                }
            }
            while (loc4 < arg5);
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

        protected function calculateMaxScrollYAndRowHeightOfIndex(arg1:int, arg2:__AS3__.vec.Vector.<starling.display.DisplayObject>, arg3:Number, arg4:Number, arg5:Number, arg6:Number, arg7:flash.geom.Point=null):flash.geom.Point
        {
            var loc8:*=NaN;
            var loc9:*=NaN;
            var loc10:*=NaN;
            var loc11:*=0;
            var loc12:*=null;
            var loc13:*=NaN;
            var loc14:*=NaN;
            var loc15:*=NaN;
            var loc16:*=NaN;
            if (!arg7) 
            {
                arg7 = new flash.geom.Point();
            }
            if (this._useVirtualLayout) 
            {
                if (this._typicalItem is feathers.core.IValidating) 
                {
                    feathers.core.IValidating(this._typicalItem).validate();
                }
                loc8 = this._typicalItem ? this._typicalItem.width : 0;
                loc9 = this._typicalItem ? this._typicalItem.height : 0;
            }
            var loc1:*=this._horizontalGap;
            var loc2:*=this._verticalGap;
            var loc3:*=0;
            var loc4:*=arg4 + this._paddingTop;
            var loc5:*=0;
            var loc6:*=arg2.length;
            var loc7:*=false;
            do 
            {
                if (loc7) 
                {
                    break;
                }
                if (loc5 > 0) 
                {
                    loc4 = loc4 + (loc3 + loc2);
                }
                loc3 = this._useVirtualLayout ? loc9 : 0;
                loc10 = arg3 + this._paddingLeft;
                loc11 = 0;
                while (loc5 < loc6) 
                {
                    loc12 = arg2[loc5];
                    if (this._useVirtualLayout && this._hasVariableItemDimensions) 
                    {
                        loc13 = this._widthCache[loc5];
                        loc14 = this._heightCache[loc5];
                    }
                    if (this._useVirtualLayout && !loc12) 
                    {
                        if (this._hasVariableItemDimensions) 
                        {
                            if (loc13 === loc13) 
                            {
                                loc15 = loc13;
                            }
                            else 
                            {
                                loc15 = loc8;
                            }
                            if (loc14 === loc14) 
                            {
                                loc16 = loc14;
                            }
                            else 
                            {
                                loc16 = loc9;
                            }
                        }
                        else 
                        {
                            loc15 = loc8;
                            loc16 = loc9;
                        }
                        if (loc11 > 0 && loc10 + loc15 > arg5 - this._paddingRight) 
                        {
                            break;
                        }
                        if (loc5 === arg1) 
                        {
                            loc7 = true;
                        }
                        if (loc16 > loc3) 
                        {
                            loc3 = loc16;
                        }
                        loc10 = loc10 + (loc15 + loc1);
                        ++loc11;
                    }
                    else if (!(loc12 is feathers.layout.ILayoutDisplayObject && !feathers.layout.ILayoutDisplayObject(loc12).includeInLayout)) 
                    {
                        if (loc12 is feathers.core.IValidating) 
                        {
                            feathers.core.IValidating(loc12).validate();
                        }
                        loc15 = loc12.width;
                        loc16 = loc12.height;
                        if (this._useVirtualLayout && this._hasVariableItemDimensions) 
                        {
                            if (this._hasVariableItemDimensions) 
                            {
                                if (loc15 != loc13) 
                                {
                                    this._widthCache[loc5] = loc15;
                                    this.dispatchEventWith(starling.events.Event.CHANGE);
                                }
                                if (loc16 != loc14) 
                                {
                                    this._heightCache[loc5] = loc16;
                                    this.dispatchEventWith(starling.events.Event.CHANGE);
                                }
                            }
                            else 
                            {
                                if (loc8 >= 0) 
                                {
                                    loc15 = loc8;
                                }
                                if (loc9 >= 0) 
                                {
                                    loc16 = loc9;
                                }
                            }
                        }
                        if (loc11 > 0 && loc10 + loc15 > arg5 - this._paddingRight) 
                        {
                            break;
                        }
                        if (loc5 === arg1) 
                        {
                            loc7 = true;
                        }
                        if (loc16 > loc3) 
                        {
                            loc3 = loc16;
                        }
                        loc10 = loc10 + (loc15 + loc1);
                        ++loc11;
                    }
                    ++loc5;
                }
            }
            while (loc5 < loc6);
            arg7.setTo(loc4, loc3);
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

        public function get rowVerticalAlign():String
        {
            return this._rowVerticalAlign;
        }

        public function set rowVerticalAlign(arg1:String):void
        {
            if (this._rowVerticalAlign == arg1) 
            {
                return;
            }
            this._rowVerticalAlign = arg1;
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function get useVirtualLayout():Boolean
        {
            return this._useVirtualLayout;
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

        public function get requiresLayoutOnScroll():Boolean
        {
            return this._useVirtualLayout;
        }

        public static const HORIZONTAL_ALIGN_RIGHT:String="right";

        public static const VERTICAL_ALIGN_TOP:String="top";

        public static const VERTICAL_ALIGN_MIDDLE:String="middle";

        public static const VERTICAL_ALIGN_BOTTOM:String="bottom";

        public static const HORIZONTAL_ALIGN_LEFT:String="left";

        public static const HORIZONTAL_ALIGN_CENTER:String="center";

        protected var _rowItems:__AS3__.vec.Vector.<starling.display.DisplayObject>;

        protected var _horizontalGap:Number=0;

        protected var _verticalGap:Number=0;

        protected var _firstHorizontalGap:Number=NaN;

        protected var _lastHorizontalGap:Number=NaN;

        protected var _paddingTop:Number=0;

        protected var _paddingRight:Number=0;

        protected var _paddingBottom:Number=0;

        protected var _paddingLeft:Number=0;

        protected var _horizontalAlign:String="left";

        protected var _useVirtualLayout:Boolean=true;

        protected var _widthCache:Array;

        protected var _rowVerticalAlign:String="top";

        protected var _hasVariableItemDimensions:Boolean=true;

        protected var _verticalAlign:String="top";

        protected var _typicalItem:starling.display.DisplayObject;

        protected var _heightCache:Array;
    }
}


