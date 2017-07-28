//class VerticalSpinnerLayout
package feathers.layout 
{
    import __AS3__.vec.*;
    import feathers.core.*;
    import flash.errors.*;
    import flash.geom.*;
    import starling.display.*;
    import starling.events.*;
    
    public class VerticalSpinnerLayout extends starling.events.EventDispatcher implements feathers.layout.ISpinnerLayout, feathers.layout.ITrimmedVirtualLayout
    {
        public function VerticalSpinnerLayout()
        {
            this._discoveredItemsCache = new Vector.<starling.display.DisplayObject>(0);
            super();
            return;
        }

        public function get snapInterval():Number
        {
            if (this._typicalItem === null) 
            {
                return 0;
            }
            return this._typicalItem.height + this._gap;
        }

        public function get requiresLayoutOnScroll():Boolean
        {
            return true;
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

        public function get padding():Number
        {
            return this._paddingLeft;
        }

        public function set padding(arg1:Number):void
        {
            this.paddingRight = arg1;
            this.paddingLeft = arg1;
            return;
        }

        public function get horizontalAlign():String
        {
            return this._horizontalAlign;
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

        public function layout(arg1:__AS3__.vec.Vector.<starling.display.DisplayObject>, arg2:feathers.layout.ViewPortBounds=null, arg3:feathers.layout.LayoutBoundsResult=null):feathers.layout.LayoutBoundsResult
        {
            var loc26:*=NaN;
            var loc27:*=NaN;
            var loc28:*=null;
            var loc29:*=NaN;
            var loc30:*=null;
            var loc31:*=NaN;
            var loc32:*=NaN;
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
                loc26 = this._typicalItem ? this._typicalItem.width : 0;
                loc27 = this._typicalItem ? this._typicalItem.height : 0;
            }
            if (!this._useVirtualLayout || !(this._horizontalAlign == feathers.layout.HorizontalAlign.JUSTIFY) || !(loc9 === loc9)) 
            {
                this.validateItems(arg1, loc9 - this._paddingLeft - this._paddingRight, loc10);
            }
            var loc11:*=this._useVirtualLayout ? loc26 : 0;
            var loc12:*=loc4;
            var loc13:*=this._gap;
            var loc14:*=arg1.length;
            var loc15:*=loc14;
            if (this._useVirtualLayout) 
            {
                loc15 = loc15 + (this._beforeVirtualizedItemCount + this._afterVirtualizedItemCount);
                loc12 = loc12 + this._beforeVirtualizedItemCount * (loc27 + loc13);
            }
            this._discoveredItemsCache.length = 0;
            var loc16:*=0;
            var loc17:*=0;
            while (loc17 < loc14) 
            {
                loc28 = arg1[loc17];
                if (loc28) 
                {
                    if (!(loc28 is feathers.layout.ILayoutDisplayObject && !feathers.layout.ILayoutDisplayObject(loc28).includeInLayout)) 
                    {
                        loc28.y = loc28.pivotY + loc12;
                        loc28.height = loc27;
                        loc29 = loc28.width;
                        if (loc29 > loc11) 
                        {
                            loc11 = loc29;
                        }
                        if (this._useVirtualLayout) 
                        {
                            this._discoveredItemsCache[loc16] = loc28;
                            ++loc16;
                        }
                        loc12 = loc12 + (loc27 + loc13);
                    }
                }
                else 
                {
                    loc12 = loc12 + (loc27 + loc13);
                }
                ++loc17;
            }
            if (this._useVirtualLayout) 
            {
                loc12 = loc12 + this._afterVirtualizedItemCount * (loc27 + loc13);
            }
            var loc18:*=this._useVirtualLayout ? this._discoveredItemsCache : arg1;
            var loc19:*=loc18.length;
            var loc20:*=loc11 + this._paddingLeft + this._paddingRight;
            var loc21:*=loc9;
            if (loc21 !== loc21) 
            {
                loc21 = loc20;
                if (loc21 < loc5) 
                {
                    loc21 = loc5;
                }
                else if (loc21 > loc7) 
                {
                    loc21 = loc7;
                }
            }
            var loc22:*=loc12 - loc13 - loc4;
            var loc23:*=loc10;
            if (loc23 !== loc23) 
            {
                if (this._requestedRowCount > 0) 
                {
                    loc23 = this._requestedRowCount * (loc27 + loc13) - loc13;
                }
                else 
                {
                    loc23 = loc22;
                }
                if (loc23 < loc6) 
                {
                    loc23 = loc6;
                }
                else if (loc23 > loc8) 
                {
                    loc23 = loc8;
                }
            }
            var loc24:*=this._repeatItems && loc22 > loc23;
            if (loc24) 
            {
                loc22 = loc22 + loc13;
            }
            var loc25:*=Math.round((loc23 - loc27) / 2);
            if (!loc24) 
            {
                loc22 = loc22 + 2 * loc25;
            }
            loc17 = 0;
            while (loc17 < loc19) 
            {
                loc28 = loc18[loc17];
                if (!(loc28 is feathers.layout.ILayoutDisplayObject && !feathers.layout.ILayoutDisplayObject(loc28).includeInLayout)) 
                {
                    loc28.y = loc28.y + loc25;
                }
                ++loc17;
            }
            loc17 = 0;
            while (loc17 < loc19) 
            {
                loc28 = loc18[loc17];
                loc30 = loc28 as feathers.layout.ILayoutDisplayObject;
                if (!(loc30 && !loc30.includeInLayout)) 
                {
                    if (loc24) 
                    {
                        loc31 = loc2 - loc25;
                        if (loc31 > 0) 
                        {
                            loc28.y = loc28.y + loc22 * int((loc31 + loc23) / loc22);
                            if (loc28.y >= loc2 + loc23) 
                            {
                                loc28.y = loc28.y - loc22;
                            }
                        }
                        else if (loc31 < 0) 
                        {
                            loc28.y = loc28.y + loc22 * (int(loc31 / loc22) - 1);
                            if (loc28.y + loc28.height < loc2) 
                            {
                                loc28.y = loc28.y + loc22;
                            }
                        }
                    }
                    if (this._horizontalAlign != feathers.layout.HorizontalAlign.JUSTIFY) 
                    {
                        loc32 = loc21;
                        if (loc20 > loc32) 
                        {
                            loc32 = loc20;
                        }
                        var loc33:*=this._horizontalAlign;
                        switch (loc33) 
                        {
                            case feathers.layout.HorizontalAlign.RIGHT:
                            {
                                loc28.x = loc28.pivotX + loc3 + loc32 - this._paddingRight - loc28.width;
                                break;
                            }
                            case feathers.layout.HorizontalAlign.CENTER:
                            {
                                loc28.x = loc28.pivotX + loc3 + this._paddingLeft + Math.round((loc32 - this._paddingLeft - this._paddingRight - loc28.width) / 2);
                                break;
                            }
                            default:
                            {
                                loc28.x = loc28.pivotX + loc3 + this._paddingLeft;
                            }
                        }
                    }
                    else 
                    {
                        loc28.x = loc28.pivotX + loc3 + this._paddingLeft;
                        loc28.width = loc21 - this._paddingLeft - this._paddingRight;
                    }
                }
                ++loc17;
            }
            this._discoveredItemsCache.length = 0;
            if (!arg3) 
            {
                arg3 = new feathers.layout.LayoutBoundsResult();
            }
            arg3.contentX = 0;
            arg3.contentWidth = this._horizontalAlign != feathers.layout.HorizontalAlign.JUSTIFY ? loc20 : loc21;
            if (loc24) 
            {
                arg3.contentY = Number.NEGATIVE_INFINITY;
                arg3.contentHeight = Number.POSITIVE_INFINITY;
            }
            else 
            {
                arg3.contentY = 0;
                arg3.contentHeight = loc22;
            }
            arg3.viewPortWidth = loc21;
            arg3.viewPortHeight = loc23;
            return arg3;
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

        public function measureViewPort(arg1:int, arg2:feathers.layout.ViewPortBounds=null, arg3:flash.geom.Point=null):flash.geom.Point
        {
            var loc14:*=NaN;
            var loc15:*=NaN;
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
            var loc11:*=this._gap;
            var loc12:*=0;
            var loc13:*=loc9;
            loc12 = loc12 + (loc10 + loc11) * arg1;
            loc12 = loc12 - loc11;
            if (loc3) 
            {
                loc14 = loc13 + this._paddingLeft + this._paddingRight;
                if (loc14 < loc5) 
                {
                    loc14 = loc5;
                }
                else if (loc14 > loc7) 
                {
                    loc14 = loc7;
                }
                arg3.x = loc14;
            }
            else 
            {
                arg3.x = loc1;
            }
            if (loc4) 
            {
                if (this._requestedRowCount > 0) 
                {
                    loc15 = (loc10 + loc11) * this._requestedRowCount - loc11;
                }
                else 
                {
                    loc15 = loc12;
                }
                if (loc15 < loc6) 
                {
                    loc15 = loc6;
                }
                else if (loc15 > loc8) 
                {
                    loc15 = loc8;
                }
                arg3.y = loc15;
            }
            else 
            {
                arg3.y = loc2;
            }
            return arg3;
        }

        public function getVisibleIndicesAtScrollPosition(arg1:Number, arg2:Number, arg3:Number, arg4:Number, arg5:int, arg6:__AS3__.vec.Vector.<int>=null):__AS3__.vec.Vector.<int>
        {
            var loc8:*=0;
            var loc9:*=0;
            var loc10:*=0;
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
            var loc1:*=this._typicalItem ? this._typicalItem.height : 0;
            var loc2:*=this._gap;
            var loc3:*=0;
            var loc4:*=Math.ceil(arg4 / (loc1 + loc2)) + 1;
            var loc5:*=arg5 * (loc1 + loc2) - loc2;
            arg2 = arg2 - Math.round((arg4 - loc1) / 2);
            var loc6:*=this._repeatItems && loc5 > arg4;
            if (loc6) 
            {
                loc5 = loc5 + loc2;
                arg2 = arg2 % loc5;
                if (arg2 < 0) 
                {
                    arg2 = arg2 + loc5;
                }
                loc8 = arg2 / (loc1 + loc2);
                loc9 = loc8 + loc4;
            }
            else 
            {
                loc8 = arg2 / (loc1 + loc2);
                if (loc8 < 0) 
                {
                    loc8 = 0;
                }
                loc9 = loc8 + loc4;
                if (loc9 >= arg5) 
                {
                    --loc9;
                }
                loc8 = loc9 - loc4;
                if (loc8 < 0) 
                {
                    loc8 = 0;
                }
            }
            var loc7:*=loc8;
            while (loc7 <= loc9) 
            {
                if (!loc6 || loc7 >= 0 && loc7 < arg5) 
                {
                    arg6[loc3] = loc7;
                }
                else if (loc7 < 0) 
                {
                    arg6[loc3] = arg5 + loc7;
                }
                else if (loc7 >= arg5) 
                {
                    loc10 = loc7 - arg5;
                    if (loc10 === loc8) 
                    {
                        break;
                    }
                    arg6[loc3] = loc10;
                }
                ++loc3;
                ++loc7;
            }
            return arg6;
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

        public function getNearestScrollPositionForIndex(arg1:int, arg2:Number, arg3:Number, arg4:__AS3__.vec.Vector.<starling.display.DisplayObject>, arg5:Number, arg6:Number, arg7:Number, arg8:Number, arg9:flash.geom.Point=null):flash.geom.Point
        {
            return this.getScrollPositionForIndex(arg1, arg4, arg5, arg6, arg7, arg8, arg9);
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

        public function getScrollPositionForIndex(arg1:int, arg2:__AS3__.vec.Vector.<starling.display.DisplayObject>, arg3:Number, arg4:Number, arg5:Number, arg6:Number, arg7:flash.geom.Point=null):flash.geom.Point
        {
            this.prepareTypicalItem(arg5 - this._paddingLeft - this._paddingRight);
            var loc1:*=this._typicalItem ? this._typicalItem.height : 0;
            if (!arg7) 
            {
                arg7 = new flash.geom.Point();
            }
            arg7.x = 0;
            arg7.y = loc1 * arg1;
            return arg7;
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

        protected function validateItems(arg1:__AS3__.vec.Vector.<starling.display.DisplayObject>, arg2:Number, arg3:Number):void
        {
            var loc5:*=null;
            var loc1:*=this._horizontalAlign == feathers.layout.HorizontalAlign.JUSTIFY;
            var loc2:*=loc1 && arg2 === arg2;
            var loc3:*=arg1.length;
            var loc4:*=0;
            while (loc4 < loc3) 
            {
                loc5 = arg1[loc4];
                if (!(!loc5 || loc5 is feathers.layout.ILayoutDisplayObject && !feathers.layout.ILayoutDisplayObject(loc5).includeInLayout)) 
                {
                    if (loc2) 
                    {
                        loc5.width = arg2;
                    }
                    else if (loc1 && loc5 is feathers.core.IFeathersControl) 
                    {
                        loc5.width = NaN;
                    }
                    if (loc5 is feathers.core.IValidating) 
                    {
                        feathers.core.IValidating(loc5).validate();
                    }
                }
                ++loc4;
            }
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

        protected function prepareTypicalItem(arg1:Number):void
        {
            if (!this._typicalItem) 
            {
                return;
            }
            if (this._horizontalAlign == feathers.layout.HorizontalAlign.JUSTIFY && arg1 === arg1) 
            {
                this._typicalItem.width = arg1;
            }
            else if (this._resetTypicalItemDimensionsOnMeasure) 
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

        public function get typicalItemWidth():Number
        {
            return this._typicalItemWidth;
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

        public function get repeatItems():Boolean
        {
            return this._repeatItems;
        }

        public function set repeatItems(arg1:Boolean):void
        {
            if (this._repeatItems == arg1) 
            {
                return;
            }
            this._repeatItems = arg1;
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public static const HORIZONTAL_ALIGN_LEFT:String="left";

        public static const HORIZONTAL_ALIGN_CENTER:String="center";

        public static const HORIZONTAL_ALIGN_RIGHT:String="right";

        public static const HORIZONTAL_ALIGN_JUSTIFY:String="justify";

        protected var _discoveredItemsCache:__AS3__.vec.Vector.<starling.display.DisplayObject>;

        protected var _gap:Number=0;

        protected var _paddingLeft:Number=0;

        protected var _horizontalAlign:String="justify";

        protected var _paddingRight:Number=0;

        protected var _useVirtualLayout:Boolean=true;

        protected var _requestedRowCount:int=0;

        protected var _beforeVirtualizedItemCount:int=0;

        protected var _afterVirtualizedItemCount:int=0;

        protected var _typicalItemHeight:Number=NaN;

        protected var _typicalItemWidth:Number=NaN;

        protected var _typicalItem:starling.display.DisplayObject;

        protected var _repeatItems:Boolean=true;

        protected var _resetTypicalItemDimensionsOnMeasure:Boolean=false;
    }
}


