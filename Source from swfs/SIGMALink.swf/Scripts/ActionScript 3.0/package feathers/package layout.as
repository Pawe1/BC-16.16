//package layout
//  class AnchorLayout
package feathers.layout 
{
    import __AS3__.vec.*;
    import feathers.core.*;
    import flash.errors.*;
    import flash.geom.*;
    import starling.display.*;
    import starling.events.*;
    
    public class AnchorLayout extends starling.events.EventDispatcher implements feathers.layout.ILayout
    {
        public function AnchorLayout()
        {
            this._helperVector1 = new Vector.<starling.display.DisplayObject>(0);
            this._helperVector2 = new Vector.<starling.display.DisplayObject>(0);
            super();
            return;
        }

        public function get requiresLayoutOnScroll():Boolean
        {
            return false;
        }

        public function layout(arg1:__AS3__.vec.Vector.<starling.display.DisplayObject>, arg2:feathers.layout.ViewPortBounds=null, arg3:feathers.layout.LayoutBoundsResult=null):feathers.layout.LayoutBoundsResult
        {
            var loc1:*=arg2 ? arg2.x : 0;
            var loc2:*=arg2 ? arg2.y : 0;
            var loc3:*=arg2 ? arg2.minWidth : 0;
            var loc4:*=arg2 ? arg2.minHeight : 0;
            var loc5:*=arg2 ? arg2.maxWidth : Number.POSITIVE_INFINITY;
            var loc6:*=arg2 ? arg2.maxHeight : Number.POSITIVE_INFINITY;
            var loc7:*=arg2 ? arg2.explicitWidth : NaN;
            var loc8:*=arg2 ? arg2.explicitHeight : NaN;
            var loc9:*=loc7;
            var loc10:*=loc8;
            var loc11:*=!(loc7 === loc7);
            var loc12:*=!(loc8 === loc8);
            if (loc11 || loc12) 
            {
                this.validateItems(arg1, loc7, loc8, loc5, loc6, true);
                this.measureViewPort(arg1, loc9, loc10, HELPER_POINT);
                if (loc11) 
                {
                    loc9 = HELPER_POINT.x;
                    if (loc9 < loc3) 
                    {
                        loc9 = loc3;
                    }
                    else if (loc9 > loc5) 
                    {
                        loc9 = loc5;
                    }
                }
                if (loc12) 
                {
                    loc10 = HELPER_POINT.y;
                    if (loc10 < loc4) 
                    {
                        loc10 = loc4;
                    }
                    else if (loc10 > loc6) 
                    {
                        loc10 = loc6;
                    }
                }
            }
            else 
            {
                this.validateItems(arg1, loc7, loc8, loc5, loc6, false);
            }
            this.layoutWithBounds(arg1, loc1, loc2, loc9, loc10);
            this.measureContent(arg1, loc9, loc10, HELPER_POINT);
            if (!arg3) 
            {
                arg3 = new feathers.layout.LayoutBoundsResult();
            }
            arg3.contentWidth = HELPER_POINT.x;
            arg3.contentHeight = HELPER_POINT.y;
            arg3.viewPortWidth = loc9;
            arg3.viewPortHeight = loc10;
            return arg3;
        }

        public function getNearestScrollPositionForIndex(arg1:int, arg2:Number, arg3:Number, arg4:__AS3__.vec.Vector.<starling.display.DisplayObject>, arg5:Number, arg6:Number, arg7:Number, arg8:Number, arg9:flash.geom.Point=null):flash.geom.Point
        {
            return this.getScrollPositionForIndex(arg1, arg4, arg5, arg6, arg7, arg8, arg9);
        }

        public function getScrollPositionForIndex(arg1:int, arg2:__AS3__.vec.Vector.<starling.display.DisplayObject>, arg3:Number, arg4:Number, arg5:Number, arg6:Number, arg7:flash.geom.Point=null):flash.geom.Point
        {
            if (!arg7) 
            {
                arg7 = new flash.geom.Point();
            }
            arg7.x = 0;
            arg7.y = 0;
            return arg7;
        }

        protected function measureViewPort(arg1:__AS3__.vec.Vector.<starling.display.DisplayObject>, arg2:Number, arg3:Number, arg4:flash.geom.Point=null):flash.geom.Point
        {
            var loc4:*=NaN;
            this._helperVector1.length = 0;
            this._helperVector2.length = 0;
            HELPER_POINT.x = 0;
            HELPER_POINT.y = 0;
            var loc1:*=arg1;
            var loc2:*=this._helperVector1;
            this.measureVector(arg1, loc2, HELPER_POINT);
            var loc3:*=loc2.length;
            while (loc3 > 0) 
            {
                if (loc2 != this._helperVector1) 
                {
                    loc1 = this._helperVector2;
                    loc2 = this._helperVector1;
                }
                else 
                {
                    loc1 = this._helperVector1;
                    loc2 = this._helperVector2;
                }
                this.measureVector(loc1, loc2, HELPER_POINT);
                loc4 = loc3;
                loc3 = loc2.length;
                if (loc4 != loc3) 
                {
                    continue;
                }
                this._helperVector1.length = 0;
                this._helperVector2.length = 0;
                throw new flash.errors.IllegalOperationError(CIRCULAR_REFERENCE_ERROR);
            }
            this._helperVector1.length = 0;
            this._helperVector2.length = 0;
            if (!arg4) 
            {
                arg4 = HELPER_POINT.clone();
            }
            return arg4;
        }

        protected function measureVector(arg1:__AS3__.vec.Vector.<starling.display.DisplayObject>, arg2:__AS3__.vec.Vector.<starling.display.DisplayObject>, arg3:flash.geom.Point=null):flash.geom.Point
        {
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=false;
            var loc7:*=null;
            if (!arg3) 
            {
                arg3 = new flash.geom.Point();
            }
            arg2.length = 0;
            var loc1:*=arg1.length;
            var loc2:*=0;
            var loc3:*=0;
            while (loc3 < loc1) 
            {
                loc4 = arg1[loc3];
                if (loc4 is feathers.layout.ILayoutDisplayObject) 
                {
                    loc7 = feathers.layout.ILayoutDisplayObject(loc4);
                    if (loc7.includeInLayout) 
                    {
                        loc5 = loc7.layoutData as feathers.layout.AnchorLayoutData;
                        loc6 = !loc5 || this.isReadyForLayout(loc5, loc3, arg1, arg2);
                        if (loc6) 
                        {
                            this.measureItem(loc4, arg3);
                        }
                        else 
                        {
                            arg2[loc2] = loc4;
                            ++loc2;
                        }
                    }
                }
                else 
                {
                    loc6 = !loc5 || this.isReadyForLayout(loc5, loc3, arg1, arg2);
                    if (loc6) 
                    {
                        this.measureItem(loc4, arg3);
                    }
                    else 
                    {
                        arg2[loc2] = loc4;
                        ++loc2;
                    }
                }
                ++loc3;
            }
            return arg3;
        }

        protected function measureItem(arg1:starling.display.DisplayObject, arg2:flash.geom.Point):void
        {
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=NaN;
            var loc1:*=arg2.x;
            var loc2:*=arg2.y;
            var loc3:*=false;
            if (arg1 is feathers.layout.ILayoutDisplayObject) 
            {
                loc4 = feathers.layout.ILayoutDisplayObject(arg1);
                loc5 = loc4.layoutData as feathers.layout.AnchorLayoutData;
                if (loc5) 
                {
                    loc6 = this.measureItemHorizontally(loc4, loc5);
                    if (loc6 > loc1) 
                    {
                        loc1 = loc6;
                    }
                    loc6 = this.measureItemVertically(loc4, loc5);
                    if (loc6 > loc2) 
                    {
                        loc2 = loc6;
                    }
                    loc3 = true;
                }
            }
            if (!loc3) 
            {
                loc6 = arg1.x - arg1.pivotX + arg1.width;
                if (loc6 > loc1) 
                {
                    loc1 = loc6;
                }
                loc6 = arg1.y - arg1.pivotY + arg1.height;
                if (loc6 > loc2) 
                {
                    loc2 = loc6;
                }
            }
            arg2.x = loc1;
            arg2.y = loc2;
            return;
        }

        protected function measureItemHorizontally(arg1:feathers.layout.ILayoutDisplayObject, arg2:feathers.layout.AnchorLayoutData):Number
        {
            var loc1:*=arg1.width;
            var loc2:*=starling.display.DisplayObject(arg1);
            var loc3:*=this.getLeftOffset(loc2);
            var loc4:*=this.getRightOffset(loc2);
            return loc1 + loc3 + loc4;
        }

        protected function measureItemVertically(arg1:feathers.layout.ILayoutDisplayObject, arg2:feathers.layout.AnchorLayoutData):Number
        {
            var loc5:*=NaN;
            var loc1:*=arg1.height;
            if (arg2 && arg1 is feathers.core.IFeathersControl) 
            {
                loc5 = arg2.percentHeight;
                this.doNothing();
                if (loc5 === loc5) 
                {
                    loc1 = feathers.core.IFeathersControl(arg1).minHeight;
                }
            }
            var loc2:*=starling.display.DisplayObject(arg1);
            var loc3:*=this.getTopOffset(loc2);
            var loc4:*=this.getBottomOffset(loc2);
            return loc1 + loc3 + loc4;
        }

        protected function doNothing():void
        {
            return;
        }

        protected function getTopOffset(arg1:starling.display.DisplayObject):Number
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=NaN;
            var loc4:*=false;
            var loc5:*=NaN;
            var loc6:*=false;
            var loc7:*=NaN;
            var loc8:*=false;
            var loc9:*=null;
            var loc10:*=null;
            var loc11:*=null;
            var loc12:*=NaN;
            if (arg1 is feathers.layout.ILayoutDisplayObject) 
            {
                loc1 = feathers.layout.ILayoutDisplayObject(arg1);
                loc2 = loc1.layoutData as feathers.layout.AnchorLayoutData;
                if (loc2) 
                {
                    loc3 = loc2.top;
                    loc4 = loc3 === loc3;
                    if (loc4) 
                    {
                        loc9 = loc2.topAnchorDisplayObject;
                        if (loc9) 
                        {
                            loc3 = loc3 + (loc9.height + this.getTopOffset(loc9));
                        }
                        else 
                        {
                            return loc3;
                        }
                    }
                    else 
                    {
                        loc3 = 0;
                    }
                    loc5 = loc2.bottom;
                    loc6 = loc5 === loc5;
                    if (loc6) 
                    {
                        loc10 = loc2.bottomAnchorDisplayObject;
                        if (loc10) 
                        {
                            loc3 = Math.max(loc3, -loc10.height - loc5 + this.getTopOffset(loc10));
                        }
                    }
                    loc7 = loc2.verticalCenter;
                    loc8 = loc7 === loc7;
                    if (loc8) 
                    {
                        loc11 = loc2.verticalCenterAnchorDisplayObject;
                        if (loc11) 
                        {
                            loc12 = loc7 - Math.round((arg1.height - loc11.height) / 2);
                            loc3 = Math.max(loc3, loc12 + this.getTopOffset(loc11));
                        }
                        else if (loc7 > 0) 
                        {
                            return loc7 * 2;
                        }
                    }
                    return loc3;
                }
            }
            return 0;
        }

        protected function getRightOffset(arg1:starling.display.DisplayObject):Number
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=NaN;
            var loc4:*=false;
            var loc5:*=NaN;
            var loc6:*=false;
            var loc7:*=NaN;
            var loc8:*=false;
            var loc9:*=null;
            var loc10:*=null;
            var loc11:*=null;
            var loc12:*=NaN;
            if (arg1 is feathers.layout.ILayoutDisplayObject) 
            {
                loc1 = feathers.layout.ILayoutDisplayObject(arg1);
                loc2 = loc1.layoutData as feathers.layout.AnchorLayoutData;
                if (loc2) 
                {
                    loc3 = loc2.right;
                    loc4 = loc3 === loc3;
                    if (loc4) 
                    {
                        loc9 = loc2.rightAnchorDisplayObject;
                        if (loc9) 
                        {
                            loc3 = loc3 + (loc9.width + this.getRightOffset(loc9));
                        }
                        else 
                        {
                            return loc3;
                        }
                    }
                    else 
                    {
                        loc3 = 0;
                    }
                    loc5 = loc2.left;
                    loc6 = loc5 === loc5;
                    if (loc6) 
                    {
                        loc10 = loc2.leftAnchorDisplayObject;
                        if (loc10) 
                        {
                            loc3 = Math.max(loc3, -loc10.width - loc5 + this.getRightOffset(loc10));
                        }
                    }
                    loc7 = loc2.horizontalCenter;
                    loc8 = loc7 === loc7;
                    if (loc8) 
                    {
                        loc11 = loc2.horizontalCenterAnchorDisplayObject;
                        if (loc11) 
                        {
                            loc12 = -loc7 - Math.round((arg1.width - loc11.width) / 2);
                            loc3 = Math.max(loc3, loc12 + this.getRightOffset(loc11));
                        }
                        else if (loc7 < 0) 
                        {
                            return (-loc7) * 2;
                        }
                    }
                    return loc3;
                }
            }
            return 0;
        }

        protected function getBottomOffset(arg1:starling.display.DisplayObject):Number
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=NaN;
            var loc4:*=false;
            var loc5:*=NaN;
            var loc6:*=false;
            var loc7:*=NaN;
            var loc8:*=false;
            var loc9:*=null;
            var loc10:*=null;
            var loc11:*=null;
            var loc12:*=NaN;
            if (arg1 is feathers.layout.ILayoutDisplayObject) 
            {
                loc1 = feathers.layout.ILayoutDisplayObject(arg1);
                loc2 = loc1.layoutData as feathers.layout.AnchorLayoutData;
                if (loc2) 
                {
                    loc3 = loc2.bottom;
                    loc4 = loc3 === loc3;
                    if (loc4) 
                    {
                        loc9 = loc2.bottomAnchorDisplayObject;
                        if (loc9) 
                        {
                            loc3 = loc3 + (loc9.height + this.getBottomOffset(loc9));
                        }
                        else 
                        {
                            return loc3;
                        }
                    }
                    else 
                    {
                        loc3 = 0;
                    }
                    loc5 = loc2.top;
                    loc6 = loc5 === loc5;
                    if (loc6) 
                    {
                        loc10 = loc2.topAnchorDisplayObject;
                        if (loc10) 
                        {
                            loc3 = Math.max(loc3, -loc10.height - loc5 + this.getBottomOffset(loc10));
                        }
                    }
                    loc7 = loc2.verticalCenter;
                    loc8 = loc7 === loc7;
                    if (loc8) 
                    {
                        loc11 = loc2.verticalCenterAnchorDisplayObject;
                        if (loc11) 
                        {
                            loc12 = -loc7 - Math.round((arg1.height - loc11.height) / 2);
                            loc3 = Math.max(loc3, loc12 + this.getBottomOffset(loc11));
                        }
                        else if (loc7 < 0) 
                        {
                            return (-loc7) * 2;
                        }
                    }
                    return loc3;
                }
            }
            return 0;
        }

        protected function getLeftOffset(arg1:starling.display.DisplayObject):Number
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=NaN;
            var loc4:*=false;
            var loc5:*=NaN;
            var loc6:*=false;
            var loc7:*=NaN;
            var loc8:*=false;
            var loc9:*=null;
            var loc10:*=null;
            var loc11:*=null;
            var loc12:*=NaN;
            if (arg1 is feathers.layout.ILayoutDisplayObject) 
            {
                loc1 = feathers.layout.ILayoutDisplayObject(arg1);
                loc2 = loc1.layoutData as feathers.layout.AnchorLayoutData;
                if (loc2) 
                {
                    loc3 = loc2.left;
                    loc4 = loc3 === loc3;
                    if (loc4) 
                    {
                        loc9 = loc2.leftAnchorDisplayObject;
                        if (loc9) 
                        {
                            loc3 = loc3 + (loc9.width + this.getLeftOffset(loc9));
                        }
                        else 
                        {
                            return loc3;
                        }
                    }
                    else 
                    {
                        loc3 = 0;
                    }
                    loc5 = loc2.right;
                    loc6 = loc5 === loc5;
                    if (loc6) 
                    {
                        loc10 = loc2.rightAnchorDisplayObject;
                        if (loc10) 
                        {
                            loc3 = Math.max(loc3, -loc10.width - loc5 + this.getLeftOffset(loc10));
                        }
                    }
                    loc7 = loc2.horizontalCenter;
                    loc8 = loc7 === loc7;
                    if (loc8) 
                    {
                        loc11 = loc2.horizontalCenterAnchorDisplayObject;
                        if (loc11) 
                        {
                            loc12 = loc7 - Math.round((arg1.width - loc11.width) / 2);
                            loc3 = Math.max(loc3, loc12 + this.getLeftOffset(loc11));
                        }
                        else if (loc7 > 0) 
                        {
                            return loc7 * 2;
                        }
                    }
                    return loc3;
                }
            }
            return 0;
        }

        protected function layoutWithBounds(arg1:__AS3__.vec.Vector.<starling.display.DisplayObject>, arg2:Number, arg3:Number, arg4:Number, arg5:Number):void
        {
            var loc4:*=NaN;
            this._helperVector1.length = 0;
            this._helperVector2.length = 0;
            var loc1:*=arg1;
            var loc2:*=this._helperVector1;
            this.layoutVector(arg1, loc2, arg2, arg3, arg4, arg5);
            var loc3:*=loc2.length;
            while (loc3 > 0) 
            {
                if (loc2 != this._helperVector1) 
                {
                    loc1 = this._helperVector2;
                    loc2 = this._helperVector1;
                }
                else 
                {
                    loc1 = this._helperVector1;
                    loc2 = this._helperVector2;
                }
                this.layoutVector(loc1, loc2, arg2, arg3, arg4, arg5);
                loc4 = loc3;
                loc3 = loc2.length;
                if (loc4 != loc3) 
                {
                    continue;
                }
                this._helperVector1.length = 0;
                this._helperVector2.length = 0;
                throw new flash.errors.IllegalOperationError(CIRCULAR_REFERENCE_ERROR);
            }
            this._helperVector1.length = 0;
            this._helperVector2.length = 0;
            return;
        }

        protected function layoutVector(arg1:__AS3__.vec.Vector.<starling.display.DisplayObject>, arg2:__AS3__.vec.Vector.<starling.display.DisplayObject>, arg3:Number, arg4:Number, arg5:Number, arg6:Number):void
        {
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=null;
            var loc7:*=false;
            arg2.length = 0;
            var loc1:*=arg1.length;
            var loc2:*=0;
            var loc3:*=0;
            while (loc3 < loc1) 
            {
                loc4 = arg1[loc3];
                loc5 = loc4 as feathers.layout.ILayoutDisplayObject;
                if (!(!loc5 || !loc5.includeInLayout)) 
                {
                    loc6 = loc5.layoutData as feathers.layout.AnchorLayoutData;
                    if (loc6) 
                    {
                        loc7 = this.isReadyForLayout(loc6, loc3, arg1, arg2);
                        if (loc7) 
                        {
                            this.positionHorizontally(loc5, loc6, arg3, arg4, arg5, arg6);
                            this.positionVertically(loc5, loc6, arg3, arg4, arg5, arg6);
                        }
                        else 
                        {
                            arg2[loc2] = loc4;
                            ++loc2;
                        }
                    }
                }
                ++loc3;
            }
            return;
        }

        protected function positionHorizontally(arg1:feathers.layout.ILayoutDisplayObject, arg2:feathers.layout.AnchorLayoutData, arg3:Number, arg4:Number, arg5:Number, arg6:Number):void
        {
            var loc9:*=NaN;
            var loc10:*=NaN;
            var loc11:*=NaN;
            var loc12:*=null;
            var loc13:*=null;
            var loc14:*=NaN;
            var loc15:*=null;
            var loc16:*=NaN;
            var loc17:*=NaN;
            var loc1:*=arg1 as feathers.core.IFeathersControl;
            var loc2:*=arg2.percentWidth;
            if (loc2 === loc2) 
            {
                if (loc2 < 0) 
                {
                    loc2 = 0;
                }
                else if (loc2 > 100) 
                {
                    loc2 = 100;
                }
                loc9 = loc2 * 0.01 * arg5;
                if (loc1 !== null) 
                {
                    loc10 = loc1.explicitMinWidth;
                    loc11 = loc1.explicitMaxWidth;
                    if (loc9 < loc10) 
                    {
                        loc9 = loc10;
                    }
                    else if (loc9 > loc11) 
                    {
                        loc9 = loc11;
                    }
                }
                if (loc9 > arg5) 
                {
                    loc9 = arg5;
                }
                arg1.width = loc9;
            }
            var loc3:*=arg2.left;
            var loc4:*=loc3 === loc3;
            if (loc4) 
            {
                loc12 = arg2.leftAnchorDisplayObject;
                if (loc12) 
                {
                    arg1.x = arg1.pivotX + loc12.x - loc12.pivotX + loc12.width + loc3;
                }
                else 
                {
                    arg1.x = arg1.pivotX + arg3 + loc3;
                }
            }
            var loc5:*=arg2.horizontalCenter;
            var loc6:*=loc5 === loc5;
            var loc7:*=arg2.right;
            var loc8:*=loc7 === loc7;
            if (loc8) 
            {
                loc13 = arg2.rightAnchorDisplayObject;
                if (loc4) 
                {
                    loc14 = arg5;
                    if (loc13) 
                    {
                        loc14 = loc13.x - loc13.pivotX;
                    }
                    if (loc12) 
                    {
                        loc14 = loc14 - (loc12.x - loc12.pivotX + loc12.width);
                    }
                    arg1.width = loc14 - loc7 - loc3;
                }
                else if (loc6) 
                {
                    loc15 = arg2.horizontalCenterAnchorDisplayObject;
                    if (loc15) 
                    {
                        loc16 = loc15.x - loc15.pivotX + Math.round(loc15.width / 2) + loc5;
                    }
                    else 
                    {
                        loc16 = Math.round(arg5 / 2) + loc5;
                    }
                    if (loc13) 
                    {
                        loc17 = loc13.x - loc13.pivotX - loc7;
                    }
                    else 
                    {
                        loc17 = arg5 - loc7;
                    }
                    arg1.width = 2 * (loc17 - loc16);
                    arg1.x = arg1.pivotX + arg5 - loc7 - arg1.width;
                }
                else if (loc13) 
                {
                    arg1.x = arg1.pivotX + loc13.x - loc13.pivotX - arg1.width - loc7;
                }
                else 
                {
                    arg1.x = arg1.pivotX + arg3 + arg5 - loc7 - arg1.width;
                }
            }
            else if (loc6) 
            {
                loc15 = arg2.horizontalCenterAnchorDisplayObject;
                if (loc15) 
                {
                    loc16 = loc15.x - loc15.pivotX + Math.round(loc15.width / 2) + loc5;
                }
                else 
                {
                    loc16 = Math.round(arg5 / 2) + loc5;
                }
                if (loc4) 
                {
                    arg1.width = 2 * (loc16 - arg1.x + arg1.pivotX);
                }
                else 
                {
                    arg1.x = arg1.pivotX + loc16 - Math.round(arg1.width / 2);
                }
            }
            return;
        }

        protected function positionVertically(arg1:feathers.layout.ILayoutDisplayObject, arg2:feathers.layout.AnchorLayoutData, arg3:Number, arg4:Number, arg5:Number, arg6:Number):void
        {
            var loc9:*=NaN;
            var loc10:*=NaN;
            var loc11:*=NaN;
            var loc12:*=null;
            var loc13:*=null;
            var loc14:*=NaN;
            var loc15:*=null;
            var loc16:*=NaN;
            var loc17:*=NaN;
            var loc1:*=arg1 as feathers.core.IFeathersControl;
            var loc2:*=arg2.percentHeight;
            if (loc2 === loc2) 
            {
                if (loc2 < 0) 
                {
                    loc2 = 0;
                }
                else if (loc2 > 100) 
                {
                    loc2 = 100;
                }
                loc9 = loc2 * 0.01 * arg6;
                if (loc1 !== null) 
                {
                    loc10 = loc1.explicitMinHeight;
                    loc11 = loc1.explicitMaxHeight;
                    if (loc9 < loc10) 
                    {
                        loc9 = loc10;
                    }
                    else if (loc9 > loc11) 
                    {
                        loc9 = loc11;
                    }
                }
                if (loc9 > arg6) 
                {
                    loc9 = arg6;
                }
                arg1.height = loc9;
            }
            var loc3:*=arg2.top;
            var loc4:*=loc3 === loc3;
            if (loc4) 
            {
                loc12 = arg2.topAnchorDisplayObject;
                if (loc12) 
                {
                    arg1.y = arg1.pivotY + loc12.y - loc12.pivotY + loc12.height + loc3;
                }
                else 
                {
                    arg1.y = arg1.pivotY + arg4 + loc3;
                }
            }
            var loc5:*=arg2.verticalCenter;
            var loc6:*=loc5 === loc5;
            var loc7:*=arg2.bottom;
            var loc8:*=loc7 === loc7;
            if (loc8) 
            {
                loc13 = arg2.bottomAnchorDisplayObject;
                if (loc4) 
                {
                    loc14 = arg6;
                    if (loc13) 
                    {
                        loc14 = loc13.y - loc13.pivotY;
                    }
                    if (loc12) 
                    {
                        loc14 = loc14 - (loc12.y - loc12.pivotY + loc12.height);
                    }
                    arg1.height = loc14 - loc7 - loc3;
                }
                else if (loc6) 
                {
                    loc15 = arg2.verticalCenterAnchorDisplayObject;
                    if (loc15) 
                    {
                        loc16 = loc15.y - loc15.pivotY + Math.round(loc15.height / 2) + loc5;
                    }
                    else 
                    {
                        loc16 = Math.round(arg6 / 2) + loc5;
                    }
                    if (loc13) 
                    {
                        loc17 = loc13.y - loc13.pivotY - loc7;
                    }
                    else 
                    {
                        loc17 = arg6 - loc7;
                    }
                    arg1.height = 2 * (loc17 - loc16);
                    arg1.y = arg1.pivotY + arg6 - loc7 - arg1.height;
                }
                else if (loc13) 
                {
                    arg1.y = arg1.pivotY + loc13.y - loc13.pivotY - arg1.height - loc7;
                }
                else 
                {
                    arg1.y = arg1.pivotY + arg4 + arg6 - loc7 - arg1.height;
                }
            }
            else if (loc6) 
            {
                loc15 = arg2.verticalCenterAnchorDisplayObject;
                if (loc15) 
                {
                    loc16 = loc15.y - loc15.pivotY + Math.round(loc15.height / 2) + loc5;
                }
                else 
                {
                    loc16 = Math.round(arg6 / 2) + loc5;
                }
                if (loc4) 
                {
                    arg1.height = 2 * (loc16 - arg1.y + arg1.pivotY);
                }
                else 
                {
                    arg1.y = arg1.pivotY + loc16 - Math.round(arg1.height / 2);
                }
            }
            return;
        }

        protected function measureContent(arg1:__AS3__.vec.Vector.<starling.display.DisplayObject>, arg2:Number, arg3:Number, arg4:flash.geom.Point=null):flash.geom.Point
        {
            var loc5:*=null;
            var loc6:*=NaN;
            var loc7:*=NaN;
            var loc1:*=arg2;
            var loc2:*=arg3;
            var loc3:*=arg1.length;
            var loc4:*=0;
            while (loc4 < loc3) 
            {
                loc5 = arg1[loc4];
                loc6 = loc5.x - loc5.pivotX + loc5.width;
                loc7 = loc5.y - loc5.pivotY + loc5.height;
                if (loc6 === loc6 && loc6 > loc1) 
                {
                    loc1 = loc6;
                }
                if (loc7 === loc7 && loc7 > loc2) 
                {
                    loc2 = loc7;
                }
                ++loc4;
            }
            arg4.x = loc1;
            arg4.y = loc2;
            return arg4;
        }

        protected function isReadyForLayout(arg1:feathers.layout.AnchorLayoutData, arg2:int, arg3:__AS3__.vec.Vector.<starling.display.DisplayObject>, arg4:__AS3__.vec.Vector.<starling.display.DisplayObject>):Boolean
        {
            var loc1:*=arg2 + 1;
            var loc2:*=arg1.leftAnchorDisplayObject;
            if (loc2 && (arg3.indexOf(loc2, loc1) >= loc1 || arg4.indexOf(loc2) >= 0)) 
            {
                return false;
            }
            var loc3:*=arg1.rightAnchorDisplayObject;
            if (loc3 && (arg3.indexOf(loc3, loc1) >= loc1 || arg4.indexOf(loc3) >= 0)) 
            {
                return false;
            }
            var loc4:*=arg1.topAnchorDisplayObject;
            if (loc4 && (arg3.indexOf(loc4, loc1) >= loc1 || arg4.indexOf(loc4) >= 0)) 
            {
                return false;
            }
            var loc5:*=arg1.bottomAnchorDisplayObject;
            if (loc5 && (arg3.indexOf(loc5, loc1) >= loc1 || arg4.indexOf(loc5) >= 0)) 
            {
                return false;
            }
            var loc6:*=arg1.horizontalCenterAnchorDisplayObject;
            if (loc6 && (arg3.indexOf(loc6, loc1) >= loc1 || arg4.indexOf(loc6) >= 0)) 
            {
                return false;
            }
            var loc7:*=arg1.verticalCenterAnchorDisplayObject;
            if (loc7 && (arg3.indexOf(loc7, loc1) >= loc1 || arg4.indexOf(loc7) >= 0)) 
            {
                return false;
            }
            return true;
        }

        protected function isReferenced(arg1:starling.display.DisplayObject, arg2:__AS3__.vec.Vector.<starling.display.DisplayObject>):Boolean
        {
            var loc3:*=null;
            var loc4:*=null;
            var loc1:*=arg2.length;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                loc3 = arg2[loc2] as feathers.layout.ILayoutDisplayObject;
                if (!(!loc3 || loc3 == arg1)) 
                {
                    loc4 = loc3.layoutData as feathers.layout.AnchorLayoutData;
                    if (loc4) 
                    {
                        if (loc4.leftAnchorDisplayObject == arg1 || loc4.horizontalCenterAnchorDisplayObject == arg1 || loc4.rightAnchorDisplayObject == arg1 || loc4.topAnchorDisplayObject == arg1 || loc4.verticalCenterAnchorDisplayObject == arg1 || loc4.bottomAnchorDisplayObject == arg1) 
                        {
                            return true;
                        }
                    }
                }
                ++loc2;
            }
            return false;
        }

        protected function validateItems(arg1:__AS3__.vec.Vector.<starling.display.DisplayObject>, arg2:Number, arg3:Number, arg4:Number, arg5:Number, arg6:Boolean):void
        {
            var loc7:*=null;
            var loc8:*=null;
            var loc9:*=null;
            var loc10:*=NaN;
            var loc11:*=false;
            var loc12:*=null;
            var loc13:*=NaN;
            var loc14:*=null;
            var loc15:*=false;
            var loc16:*=NaN;
            var loc17:*=false;
            var loc18:*=NaN;
            var loc19:*=false;
            var loc20:*=NaN;
            var loc21:*=false;
            var loc22:*=null;
            var loc23:*=NaN;
            var loc24:*=false;
            var loc25:*=null;
            var loc26:*=NaN;
            var loc27:*=false;
            var loc28:*=NaN;
            var loc29:*=false;
            var loc30:*=null;
            var loc1:*=!(arg2 === arg2);
            var loc2:*=!(arg3 === arg3);
            var loc3:*=arg2;
            if (loc1 && arg4 < Number.POSITIVE_INFINITY) 
            {
                loc3 = arg4;
            }
            var loc4:*=arg3;
            if (loc2 && arg5 < Number.POSITIVE_INFINITY) 
            {
                loc4 = arg5;
            }
            var loc5:*=arg1.length;
            var loc6:*=0;
            while (loc6 < loc5) 
            {
                loc7 = arg1[loc6];
                if (loc7 is feathers.layout.ILayoutDisplayObject) 
                {
                    loc8 = feathers.layout.ILayoutDisplayObject(loc7);
                    if (loc8.includeInLayout) 
                    {
                        loc9 = loc8.layoutData as feathers.layout.AnchorLayoutData;
                        if (loc9 === null) 
                        {
                            if (arg6 || this.isReferenced(loc7, arg1)) 
                            {
                                if (loc7 is feathers.core.IValidating) 
                                {
                                    feathers.core.IValidating(loc7).validate();
                                }
                            }
                        }
                        else 
                        {
                            loc10 = loc9.left;
                            loc11 = loc10 === loc10;
                            loc12 = loc9.leftAnchorDisplayObject;
                            loc13 = loc9.right;
                            loc14 = loc9.rightAnchorDisplayObject;
                            loc15 = loc13 === loc13;
                            loc16 = loc9.percentWidth;
                            loc17 = loc16 === loc16;
                            if (loc1) 
                            {
                                loc30 = feathers.core.IMeasureDisplayObject(loc7);
                                if (loc11 && loc12 === null && loc15 && loc14 === null) 
                                {
                                    loc30.width = NaN;
                                    loc30.maxWidth = arg4 - loc10 - loc13;
                                }
                                else if (loc17) 
                                {
                                    if (loc16 < 0) 
                                    {
                                        loc16 = 0;
                                    }
                                    else if (loc16 > 100) 
                                    {
                                        loc16 = 100;
                                    }
                                    loc30.width = NaN;
                                    loc30.maxWidth = loc16 * 0.01 * arg4;
                                }
                            }
                            else if (loc11 && loc12 === null && loc15 && loc14 === null) 
                            {
                                loc7.width = loc3 - loc10 - loc13;
                            }
                            else if (loc17) 
                            {
                                if (loc16 < 0) 
                                {
                                    loc16 = 0;
                                }
                                else if (loc16 > 100) 
                                {
                                    loc16 = 100;
                                }
                                loc7.width = loc16 * 0.01 * loc3;
                            }
                            loc18 = loc9.horizontalCenter;
                            loc19 = loc18 === loc18;
                            loc20 = loc9.top;
                            loc21 = loc20 === loc20;
                            loc22 = loc9.topAnchorDisplayObject;
                            loc23 = loc9.bottom;
                            loc24 = loc23 === loc23;
                            loc25 = loc9.bottomAnchorDisplayObject;
                            loc26 = loc9.percentHeight;
                            loc27 = loc26 === loc26;
                            if (!loc2) 
                            {
                                if (loc21 && loc22 === null && loc24 && loc25 === null) 
                                {
                                    loc7.height = loc4 - loc20 - loc23;
                                }
                                else if (loc27) 
                                {
                                    if (loc26 < 0) 
                                    {
                                        loc26 = 0;
                                    }
                                    else if (loc26 > 100) 
                                    {
                                        loc26 = 100;
                                    }
                                    loc7.height = loc26 * 0.01 * loc4;
                                }
                            }
                            loc28 = loc9.verticalCenter;
                            loc29 = loc28 === loc28;
                            if (loc15 && !loc11 && !loc19 || loc19) 
                            {
                                if (loc7 is feathers.core.IValidating) 
                                {
                                    feathers.core.IValidating(loc7).validate();
                                }
                            }
                            else if (loc24 && !loc21 && !loc29 || loc29) 
                            {
                                if (loc7 is feathers.core.IValidating) 
                                {
                                    feathers.core.IValidating(loc7).validate();
                                }
                            }
                            else if (arg6 || this.isReferenced(loc7, arg1)) 
                            {
                                if (loc7 is feathers.core.IValidating) 
                                {
                                    feathers.core.IValidating(loc7).validate();
                                }
                            }
                        }
                    }
                }
                else if (arg6 || this.isReferenced(loc7, arg1)) 
                {
                    if (loc7 is feathers.core.IValidating) 
                    {
                        feathers.core.IValidating(loc7).validate();
                    }
                }
                ++loc6;
            }
            return;
        }

        protected static const CIRCULAR_REFERENCE_ERROR:String="It is impossible to create this layout due to a circular reference in the AnchorLayoutData.";

        internal static const HELPER_POINT:flash.geom.Point=new flash.geom.Point();

        protected var _helperVector1:__AS3__.vec.Vector.<starling.display.DisplayObject>;

        protected var _helperVector2:__AS3__.vec.Vector.<starling.display.DisplayObject>;
    }
}


//  class AnchorLayoutData
package feathers.layout 
{
    import starling.display.*;
    import starling.events.*;
    
    public class AnchorLayoutData extends starling.events.EventDispatcher implements feathers.layout.ILayoutData
    {
        public function AnchorLayoutData(arg1:Number=NaN, arg2:Number=NaN, arg3:Number=NaN, arg4:Number=NaN, arg5:Number=NaN, arg6:Number=NaN)
        {
            super();
            this.top = arg1;
            this.right = arg2;
            this.bottom = arg3;
            this.left = arg4;
            this.horizontalCenter = arg5;
            this.verticalCenter = arg6;
            return;
        }

        public function get horizontalCenter():Number
        {
            return this._horizontalCenter;
        }

        public function get percentWidth():Number
        {
            return this._percentWidth;
        }

        public function set percentWidth(arg1:Number):void
        {
            if (this._percentWidth == arg1) 
            {
                return;
            }
            this._percentWidth = arg1;
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function set horizontalCenter(arg1:Number):void
        {
            if (this._horizontalCenter == arg1) 
            {
                return;
            }
            this._horizontalCenter = arg1;
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function get percentHeight():Number
        {
            return this._percentHeight;
        }

        public function set percentHeight(arg1:Number):void
        {
            if (this._percentHeight == arg1) 
            {
                return;
            }
            this._percentHeight = arg1;
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function set verticalCenter(arg1:Number):void
        {
            if (this._verticalCenter == arg1) 
            {
                return;
            }
            this._verticalCenter = arg1;
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function get topAnchorDisplayObject():starling.display.DisplayObject
        {
            return this._topAnchorDisplayObject;
        }

        public function set topAnchorDisplayObject(arg1:starling.display.DisplayObject):void
        {
            if (this._topAnchorDisplayObject == arg1) 
            {
                return;
            }
            this._topAnchorDisplayObject = arg1;
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function get verticalCenterAnchorDisplayObject():starling.display.DisplayObject
        {
            return this._verticalCenterAnchorDisplayObject;
        }

        public function get top():Number
        {
            return this._top;
        }

        public function set top(arg1:Number):void
        {
            if (this._top == arg1) 
            {
                return;
            }
            this._top = arg1;
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function set verticalCenterAnchorDisplayObject(arg1:starling.display.DisplayObject):void
        {
            if (this._verticalCenterAnchorDisplayObject == arg1) 
            {
                return;
            }
            this._verticalCenterAnchorDisplayObject = arg1;
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function get rightAnchorDisplayObject():starling.display.DisplayObject
        {
            return this._rightAnchorDisplayObject;
        }

        public function set rightAnchorDisplayObject(arg1:starling.display.DisplayObject):void
        {
            if (this._rightAnchorDisplayObject == arg1) 
            {
                return;
            }
            this._rightAnchorDisplayObject = arg1;
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function set bottomAnchorDisplayObject(arg1:starling.display.DisplayObject):void
        {
            if (this._bottomAnchorDisplayObject == arg1) 
            {
                return;
            }
            this._bottomAnchorDisplayObject = arg1;
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function get right():Number
        {
            return this._right;
        }

        public function set right(arg1:Number):void
        {
            if (this._right == arg1) 
            {
                return;
            }
            this._right = arg1;
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function get verticalCenter():Number
        {
            return this._verticalCenter;
        }

        public function get bottomAnchorDisplayObject():starling.display.DisplayObject
        {
            return this._bottomAnchorDisplayObject;
        }

        public function get leftAnchorDisplayObject():starling.display.DisplayObject
        {
            return this._leftAnchorDisplayObject;
        }

        public function get bottom():Number
        {
            return this._bottom;
        }

        public function set bottom(arg1:Number):void
        {
            if (this._bottom == arg1) 
            {
                return;
            }
            this._bottom = arg1;
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function set leftAnchorDisplayObject(arg1:starling.display.DisplayObject):void
        {
            if (this._leftAnchorDisplayObject == arg1) 
            {
                return;
            }
            this._leftAnchorDisplayObject = arg1;
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function get left():Number
        {
            return this._left;
        }

        public function set left(arg1:Number):void
        {
            if (this._left == arg1) 
            {
                return;
            }
            this._left = arg1;
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function get horizontalCenterAnchorDisplayObject():starling.display.DisplayObject
        {
            return this._horizontalCenterAnchorDisplayObject;
        }

        public function set horizontalCenterAnchorDisplayObject(arg1:starling.display.DisplayObject):void
        {
            if (this._horizontalCenterAnchorDisplayObject == arg1) 
            {
                return;
            }
            this._horizontalCenterAnchorDisplayObject = arg1;
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        protected var _percentWidth:Number=NaN;

        protected var _percentHeight:Number=NaN;

        protected var _topAnchorDisplayObject:starling.display.DisplayObject;

        protected var _top:Number=NaN;

        protected var _rightAnchorDisplayObject:starling.display.DisplayObject;

        protected var _bottomAnchorDisplayObject:starling.display.DisplayObject;

        protected var _leftAnchorDisplayObject:starling.display.DisplayObject;

        protected var _right:Number=NaN;

        protected var _horizontalCenterAnchorDisplayObject:starling.display.DisplayObject;

        protected var _bottom:Number=NaN;

        protected var _left:Number=NaN;

        protected var _verticalCenter:Number=NaN;

        protected var _horizontalCenter:Number=NaN;

        protected var _verticalCenterAnchorDisplayObject:starling.display.DisplayObject;
    }
}


//  class Direction
package feathers.layout 
{
    public class Direction extends Object
    {
        public function Direction()
        {
            super();
            return;
        }

        public static const VERTICAL:String="vertical";

        public static const HORIZONTAL:String="horizontal";
    }
}


//  class FlowLayout
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


//  class HorizontalAlign
package feathers.layout 
{
    public class HorizontalAlign extends Object
    {
        public function HorizontalAlign()
        {
            super();
            return;
        }

        public static const LEFT:String="left";

        public static const CENTER:String="center";

        public static const RIGHT:String="right";

        public static const JUSTIFY:String="justify";
    }
}


//  class HorizontalLayout
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


//  class HorizontalLayoutData
package feathers.layout 
{
    import starling.events.*;
    
    public class HorizontalLayoutData extends starling.events.EventDispatcher implements feathers.layout.ILayoutData
    {
        public function HorizontalLayoutData(arg1:Number=NaN, arg2:Number=NaN)
        {
            super();
            this._percentWidth = arg1;
            this._percentHeight = arg2;
            return;
        }

        public function get percentWidth():Number
        {
            return this._percentWidth;
        }

        public function set percentWidth(arg1:Number):void
        {
            if (this._percentWidth == arg1) 
            {
                return;
            }
            this._percentWidth = arg1;
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function get percentHeight():Number
        {
            return this._percentHeight;
        }

        public function set percentHeight(arg1:Number):void
        {
            if (this._percentHeight == arg1) 
            {
                return;
            }
            this._percentHeight = arg1;
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        protected var _percentWidth:Number;

        protected var _percentHeight:Number;
    }
}


//  class IGroupedLayout
package feathers.layout 
{
    import __AS3__.vec.*;
    
    public interface IGroupedLayout extends feathers.layout.ILayout
    {
        function get headerIndices():__AS3__.vec.Vector.<int>;

        function set headerIndices(arg1:__AS3__.vec.Vector.<int>):void;
    }
}


//  class ILayout
package feathers.layout 
{
    import __AS3__.vec.*;
    import feathers.core.*;
    import flash.geom.*;
    
    public interface ILayout extends feathers.core.IFeathersEventDispatcher
    {
        function get requiresLayoutOnScroll():Boolean;

        function layout(arg1:__AS3__.vec.Vector.<starling.display.DisplayObject>, arg2:feathers.layout.ViewPortBounds=null, arg3:feathers.layout.LayoutBoundsResult=null):feathers.layout.LayoutBoundsResult;

        function getScrollPositionForIndex(arg1:int, arg2:__AS3__.vec.Vector.<starling.display.DisplayObject>, arg3:Number, arg4:Number, arg5:Number, arg6:Number, arg7:flash.geom.Point=null):flash.geom.Point;

        function getNearestScrollPositionForIndex(arg1:int, arg2:Number, arg3:Number, arg4:__AS3__.vec.Vector.<starling.display.DisplayObject>, arg5:Number, arg6:Number, arg7:Number, arg8:Number, arg9:flash.geom.Point=null):flash.geom.Point;
    }
}


//  class ILayoutData
package feathers.layout 
{
    import feathers.core.*;
    
    public interface ILayoutData extends feathers.core.IFeathersEventDispatcher
    {
    }
}


//  class ILayoutDisplayObject
package feathers.layout 
{
    import feathers.core.*;
    
    public interface ILayoutDisplayObject extends feathers.core.IFeathersDisplayObject
    {
        function get layoutData():feathers.layout.ILayoutData;

        function set layoutData(arg1:feathers.layout.ILayoutData):void;

        function get includeInLayout():Boolean;

        function set includeInLayout(arg1:Boolean):void;
    }
}


//  class ISpinnerLayout
package feathers.layout 
{
    public interface ISpinnerLayout extends feathers.layout.ILayout
    {
        function get snapInterval():Number;
    }
}


//  class ITrimmedVirtualLayout
package feathers.layout 
{
    public interface ITrimmedVirtualLayout extends feathers.layout.IVirtualLayout
    {
        function get beforeVirtualizedItemCount():int;

        function set beforeVirtualizedItemCount(arg1:int):void;

        function get afterVirtualizedItemCount():int;

        function set afterVirtualizedItemCount(arg1:int):void;
    }
}


//  class IVariableVirtualLayout
package feathers.layout 
{
    import starling.display.*;
    
    public interface IVariableVirtualLayout extends feathers.layout.IVirtualLayout
    {
        function get hasVariableItemDimensions():Boolean;

        function set hasVariableItemDimensions(arg1:Boolean):void;

        function resetVariableVirtualCache():void;

        function resetVariableVirtualCacheAtIndex(arg1:int, arg2:starling.display.DisplayObject=null):void;

        function addToVariableVirtualCacheAtIndex(arg1:int, arg2:starling.display.DisplayObject=null):void;

        function removeFromVariableVirtualCacheAtIndex(arg1:int):void;
    }
}


//  class IVirtualLayout
package feathers.layout 
{
    import __AS3__.vec.*;
    import flash.geom.*;
    import starling.display.*;
    
    public interface IVirtualLayout extends feathers.layout.ILayout
    {
        function get useVirtualLayout():Boolean;

        function set useVirtualLayout(arg1:Boolean):void;

        function get typicalItem():starling.display.DisplayObject;

        function set typicalItem(arg1:starling.display.DisplayObject):void;

        function measureViewPort(arg1:int, arg2:feathers.layout.ViewPortBounds=null, arg3:flash.geom.Point=null):flash.geom.Point;

        function getVisibleIndicesAtScrollPosition(arg1:Number, arg2:Number, arg3:Number, arg4:Number, arg5:int, arg6:__AS3__.vec.Vector.<int>=null):__AS3__.vec.Vector.<int>;
    }
}


//  class LayoutBoundsResult
package feathers.layout 
{
    public class LayoutBoundsResult extends Object
    {
        public function LayoutBoundsResult()
        {
            super();
            return;
        }

        public var contentX:Number=0;

        public var contentY:Number=0;

        public var viewPortWidth:Number;

        public var viewPortHeight:Number;

        public var contentWidth:Number;

        public var contentHeight:Number;
    }
}


//  class Orientation
package feathers.layout 
{
    public class Orientation extends Object
    {
        public function Orientation()
        {
            super();
            return;
        }

        public static const LANDSCAPE:String="landscape";

        public static const PORTRAIT:String="portrait";

        public static const NONE:String="none";

        public static const BOTH:String="both";
    }
}


//  class RelativeDepth
package feathers.layout 
{
    public class RelativeDepth extends Object
    {
        public function RelativeDepth()
        {
            super();
            return;
        }

        public static const ABOVE:String="above";

        public static const BELOW:String="below";
    }
}


//  class RelativePosition
package feathers.layout 
{
    public class RelativePosition extends Object
    {
        public function RelativePosition()
        {
            super();
            return;
        }

        public static const TOP:String="top";

        public static const RIGHT:String="right";

        public static const BOTTOM:String="bottom";

        public static const LEFT:String="left";

        public static const MANUAL:String="manual";

        public static const LEFT_BASELINE:String="leftBaseline";

        public static const RIGHT_BASELINE:String="rightBaseline";
    }
}


//  class TiledRowsLayout
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


//  class VerticalAlign
package feathers.layout 
{
    public class VerticalAlign extends Object
    {
        public function VerticalAlign()
        {
            super();
            return;
        }

        public static const TOP:String="top";

        public static const MIDDLE:String="middle";

        public static const BOTTOM:String="bottom";

        public static const JUSTIFY:String="justify";
    }
}


//  class VerticalLayout
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


//  class VerticalLayoutData
package feathers.layout 
{
    import starling.events.*;
    
    public class VerticalLayoutData extends starling.events.EventDispatcher implements feathers.layout.ILayoutData
    {
        public function VerticalLayoutData(arg1:Number=NaN, arg2:Number=NaN)
        {
            super();
            this._percentWidth = arg1;
            this._percentHeight = arg2;
            return;
        }

        public function get percentWidth():Number
        {
            return this._percentWidth;
        }

        public function set percentWidth(arg1:Number):void
        {
            if (this._percentWidth == arg1) 
            {
                return;
            }
            this._percentWidth = arg1;
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function get percentHeight():Number
        {
            return this._percentHeight;
        }

        public function set percentHeight(arg1:Number):void
        {
            if (this._percentHeight == arg1) 
            {
                return;
            }
            this._percentHeight = arg1;
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        protected var _percentWidth:Number;

        protected var _percentHeight:Number;
    }
}


//  class VerticalSpinnerLayout
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


//  class ViewPortBounds
package feathers.layout 
{
    public class ViewPortBounds extends Object
    {
        public function ViewPortBounds()
        {
            super();
            return;
        }

        public var x:Number=0;

        public var y:Number=0;

        public var scrollX:Number=0;

        public var scrollY:Number=0;

        public var explicitWidth:Number=NaN;

        public var explicitHeight:Number=NaN;

        public var minWidth:Number=0;

        public var minHeight:Number=0;

        public var maxWidth:Number=Infinity;

        public var maxHeight:Number=Infinity;
    }
}


