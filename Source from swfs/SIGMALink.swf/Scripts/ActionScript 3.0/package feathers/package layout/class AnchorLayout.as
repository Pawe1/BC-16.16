//class AnchorLayout
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


