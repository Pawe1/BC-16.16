//class DisplayObjectContainer
package starling.display 
{
    import __AS3__.vec.*;
    import flash.geom.*;
    import flash.system.*;
    import flash.utils.*;
    import starling.core.*;
    import starling.errors.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.rendering.*;
    import starling.utils.*;
    
    use namespace starling_internal;
    
    public class DisplayObjectContainer extends starling.display.DisplayObject
    {
        public function DisplayObjectContainer()
        {
            super();
            if (flash.system.Capabilities.isDebugger && flash.utils.getQualifiedClassName(this) == "starling.display::DisplayObjectContainer") 
            {
                throw new starling.errors.AbstractClassError();
            }
            this._children = new Vector.<starling.display.DisplayObject>(0);
            return;
        }

        internal static function mergeSort(arg1:__AS3__.vec.Vector.<starling.display.DisplayObject>, arg2:Function, arg3:int, arg4:int, arg5:__AS3__.vec.Vector.<starling.display.DisplayObject>):void
        {
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=0;
            var loc5:*=0;
            if (arg4 > 1) 
            {
                loc2 = arg3 + arg4;
                loc3 = arg4 / 2;
                loc4 = arg3;
                loc5 = arg3 + loc3;
                mergeSort(arg1, arg2, arg3, loc3, arg5);
                mergeSort(arg1, arg2, arg3 + loc3, arg4 - loc3, arg5);
                loc1 = 0;
                while (loc1 < arg4) 
                {
                    if (loc4 < arg3 + loc3 && (loc5 == loc2 || arg2(arg1[loc4], arg1[loc5]) <= 0)) 
                    {
                        arg5[loc1] = arg1[loc4];
                        ++loc4;
                    }
                    else 
                    {
                        arg5[loc1] = arg1[loc5];
                        ++loc5;
                    }
                    ++loc1;
                }
                loc1 = arg3;
                while (loc1 < loc2) 
                {
                    arg1[loc1] = arg5[int(loc1 - arg3)];
                    ++loc1;
                }
            }
            return;
        }

        
        {
            sHelperMatrix = new flash.geom.Matrix();
            sHelperPoint = new flash.geom.Point();
            sBroadcastListeners = new Vector.<starling.display.DisplayObject>(0);
            sSortBuffer = new Vector.<starling.display.DisplayObject>(0);
            sCacheToken = new starling.rendering.BatchToken();
        }

        public override function dispose():void
        {
            var loc1:*=(this._children.length - 1);
            while (loc1 >= 0) 
            {
                this._children[loc1].dispose();
                --loc1;
            }
            super.dispose();
            return;
        }

        public function addChild(arg1:starling.display.DisplayObject):starling.display.DisplayObject
        {
            return this.addChildAt(arg1, this._children.length);
        }

        public function addChildAt(arg1:starling.display.DisplayObject, arg2:int):starling.display.DisplayObject
        {
            var loc2:*=null;
            var loc1:*=this._children.length;
            if (arg2 >= 0 && arg2 <= loc1) 
            {
                setRequiresRedraw();
                if (arg1.parent != this) 
                {
                    this._children.insertAt(arg2, arg1);
                    arg1.removeFromParent();
                    arg1.starling_internal::setParent(this);
                    arg1.dispatchEventWith(starling.events.Event.ADDED, true);
                    if (stage) 
                    {
                        loc2 = arg1 as starling.display.DisplayObjectContainer;
                        if (loc2) 
                        {
                            loc2.broadcastEventWith(starling.events.Event.ADDED_TO_STAGE);
                        }
                        else 
                        {
                            arg1.dispatchEventWith(starling.events.Event.ADDED_TO_STAGE);
                        }
                    }
                }
                else 
                {
                    this.setChildIndex(arg1, arg2);
                }
                return arg1;
            }
            throw new RangeError("Invalid child index");
        }

        public function removeChild(arg1:starling.display.DisplayObject, arg2:Boolean=false):starling.display.DisplayObject
        {
            var loc1:*=this.getChildIndex(arg1);
            if (loc1 != -1) 
            {
                return this.removeChildAt(loc1, arg2);
            }
            return null;
        }

        public function removeChildAt(arg1:int, arg2:Boolean=false):starling.display.DisplayObject
        {
            var loc1:*=null;
            var loc2:*=null;
            if (arg1 >= 0 && arg1 < this._children.length) 
            {
                setRequiresRedraw();
                loc1 = this._children[arg1];
                loc1.dispatchEventWith(starling.events.Event.REMOVED, true);
                if (stage) 
                {
                    loc2 = loc1 as starling.display.DisplayObjectContainer;
                    if (loc2) 
                    {
                        loc2.broadcastEventWith(starling.events.Event.REMOVED_FROM_STAGE);
                    }
                    else 
                    {
                        loc1.dispatchEventWith(starling.events.Event.REMOVED_FROM_STAGE);
                    }
                }
                loc1.starling_internal::setParent(null);
                arg1 = this._children.indexOf(loc1);
                if (arg1 >= 0) 
                {
                    this._children.removeAt(arg1);
                }
                if (arg2) 
                {
                    loc1.dispose();
                }
                return loc1;
            }
            throw new RangeError("Invalid child index");
        }

        public function removeChildren(arg1:int=0, arg2:int=-1, arg3:Boolean=false):void
        {
            if (arg2 < 0 || arg2 >= this.numChildren) 
            {
                arg2 = (this.numChildren - 1);
            }
            var loc1:*=arg1;
            while (loc1 <= arg2) 
            {
                this.removeChildAt(arg1, arg3);
                ++loc1;
            }
            return;
        }

        public function getChildAt(arg1:int):starling.display.DisplayObject
        {
            var loc1:*=this._children.length;
            if (arg1 < 0) 
            {
                arg1 = loc1 + arg1;
            }
            if (arg1 >= 0 && arg1 < loc1) 
            {
                return this._children[arg1];
            }
            throw new RangeError("Invalid child index");
        }

        public function getChildByName(arg1:String):starling.display.DisplayObject
        {
            var loc1:*=this._children.length;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                if (this._children[loc2].name == arg1) 
                {
                    return this._children[loc2];
                }
                ++loc2;
            }
            return null;
        }

        public function getChildIndex(arg1:starling.display.DisplayObject):int
        {
            return this._children.indexOf(arg1);
        }

        public function setChildIndex(arg1:starling.display.DisplayObject, arg2:int):void
        {
            var loc1:*=this.getChildIndex(arg1);
            if (loc1 == arg2) 
            {
                return;
            }
            if (loc1 == -1) 
            {
                throw new ArgumentError("Not a child of this container");
            }
            this._children.removeAt(loc1);
            this._children.insertAt(arg2, arg1);
            setRequiresRedraw();
            return;
        }

        public function swapChildren(arg1:starling.display.DisplayObject, arg2:starling.display.DisplayObject):void
        {
            var loc1:*=this.getChildIndex(arg1);
            var loc2:*=this.getChildIndex(arg2);
            if (loc1 == -1 || loc2 == -1) 
            {
                throw new ArgumentError("Not a child of this container");
            }
            this.swapChildrenAt(loc1, loc2);
            return;
        }

        public function swapChildrenAt(arg1:int, arg2:int):void
        {
            var loc1:*=this.getChildAt(arg1);
            var loc2:*=this.getChildAt(arg2);
            this._children[arg1] = loc2;
            this._children[arg2] = loc1;
            setRequiresRedraw();
            return;
        }

        public function sortChildren(arg1:Function):void
        {
            sSortBuffer.length = this._children.length;
            mergeSort(this._children, arg1, 0, this._children.length, sSortBuffer);
            sSortBuffer.length = 0;
            setRequiresRedraw();
            return;
        }

        public function contains(arg1:starling.display.DisplayObject):Boolean
        {
            while (arg1) 
            {
                if (arg1 == this) 
                {
                    return true;
                }
                arg1 = arg1.parent;
            }
            return false;
        }

        public override function getBounds(arg1:starling.display.DisplayObject, arg2:flash.geom.Rectangle=null):flash.geom.Rectangle
        {
            var loc2:*=NaN;
            var loc3:*=NaN;
            var loc4:*=NaN;
            var loc5:*=NaN;
            var loc6:*=0;
            if (arg2 == null) 
            {
                arg2 = new flash.geom.Rectangle();
            }
            var loc1:*=this._children.length;
            if (loc1 != 0) 
            {
                if (loc1 != 1) 
                {
                    loc2 = Number.MAX_VALUE;
                    loc3 = -Number.MAX_VALUE;
                    loc4 = Number.MAX_VALUE;
                    loc5 = -Number.MAX_VALUE;
                    loc6 = 0;
                    while (loc6 < loc1) 
                    {
                        this._children[loc6].getBounds(arg1, arg2);
                        if (loc2 > arg2.x) 
                        {
                            loc2 = arg2.x;
                        }
                        if (loc3 < arg2.right) 
                        {
                            loc3 = arg2.right;
                        }
                        if (loc4 > arg2.y) 
                        {
                            loc4 = arg2.y;
                        }
                        if (loc5 < arg2.bottom) 
                        {
                            loc5 = arg2.bottom;
                        }
                        ++loc6;
                    }
                    arg2.setTo(loc2, loc4, loc3 - loc2, loc5 - loc4);
                }
                else 
                {
                    this._children[0].getBounds(arg1, arg2);
                }
            }
            else 
            {
                getTransformationMatrix(arg1, sHelperMatrix);
                starling.utils.MatrixUtil.transformCoords(sHelperMatrix, 0, 0, sHelperPoint);
                arg2.setTo(sHelperPoint.x, sHelperPoint.y, 0, 0);
            }
            return arg2;
        }

        public override function hitTest(arg1:flash.geom.Point):starling.display.DisplayObject
        {
            var loc6:*=null;
            if (!visible || !touchable || !hitTestMask(arg1)) 
            {
                return null;
            }
            var loc1:*=null;
            var loc2:*=arg1.x;
            var loc3:*=arg1.y;
            var loc4:*=this._children.length;
            var loc5:*;
            --loc5;
            while (loc5 >= 0) 
            {
                loc6 = this._children[loc5];
                if (!loc6.isMask) 
                {
                    sHelperMatrix.copyFrom(loc6.transformationMatrix);
                    sHelperMatrix.invert();
                    starling.utils.MatrixUtil.transformCoords(sHelperMatrix, loc2, loc3, sHelperPoint);
                    loc1 = loc6.hitTest(sHelperPoint);
                    if (loc1) 
                    {
                        return this._touchGroup ? this : loc1;
                    }
                }
                --loc5;
            }
            return null;
        }

        public override function render(arg1:starling.rendering.Painter):void
        {
            var loc6:*=null;
            var loc7:*=null;
            var loc8:*=null;
            var loc9:*=null;
            var loc10:*=null;
            var loc1:*=this._children.length;
            var loc2:*=arg1.frameID;
            var loc3:*=!(loc2 == 0);
            var loc4:*=_lastParentOrSelfChangeFrameID == loc2;
            var loc5:*=0;
            while (loc5 < loc1) 
            {
                loc6 = this._children[loc5];
                if (loc6._hasVisibleArea) 
                {
                    if (loc4) 
                    {
                        loc6._lastParentOrSelfChangeFrameID = loc2;
                    }
                    if (!(loc6._lastParentOrSelfChangeFrameID == loc2) && !(loc6._lastChildChangeFrameID == loc2) && loc6._tokenFrameID == (loc2 - 1) && loc3) 
                    {
                        arg1.pushState(sCacheToken);
                        arg1.drawFromCache(loc6._pushToken, loc6._popToken);
                        arg1.popState(loc6._popToken);
                        loc6._pushToken.copyFrom(sCacheToken);
                    }
                    else 
                    {
                        loc7 = loc3 ? loc6._pushToken : null;
                        loc8 = loc3 ? loc6._popToken : null;
                        loc9 = loc6._filter;
                        loc10 = loc6._mask;
                        arg1.pushState(loc7);
                        arg1.setStateTo(loc6.transformationMatrix, loc6.alpha, loc6.blendMode);
                        if (loc10) 
                        {
                            arg1.drawMask(loc10, loc6);
                        }
                        if (loc9) 
                        {
                            loc9.render(arg1);
                        }
                        else 
                        {
                            loc6.render(arg1);
                        }
                        if (loc10) 
                        {
                            arg1.eraseMask(loc10, loc6);
                        }
                        arg1.popState(loc8);
                    }
                    if (loc3) 
                    {
                        loc6._tokenFrameID = loc2;
                    }
                }
                ++loc5;
            }
            return;
        }

        public function broadcastEvent(arg1:starling.events.Event):void
        {
            if (arg1.bubbles) 
            {
                throw new ArgumentError("Broadcast of bubbling events is prohibited");
            }
            var loc1:*=sBroadcastListeners.length;
            this.getChildEventListeners(this, arg1.type, sBroadcastListeners);
            var loc2:*=sBroadcastListeners.length;
            var loc3:*=loc1;
            while (loc3 < loc2) 
            {
                sBroadcastListeners[loc3].dispatchEvent(arg1);
                ++loc3;
            }
            sBroadcastListeners.length = loc1;
            return;
        }

        public function broadcastEventWith(arg1:String, arg2:Object=null):void
        {
            var loc1:*=starling.events.Event.starling_internal::fromPool(arg1, false, arg2);
            this.broadcastEvent(loc1);
            starling.events.Event.starling_internal::toPool(loc1);
            return;
        }

        public function get numChildren():int
        {
            return this._children.length;
        }

        public function get touchGroup():Boolean
        {
            return this._touchGroup;
        }

        public function set touchGroup(arg1:Boolean):void
        {
            this._touchGroup = arg1;
            return;
        }

        function getChildEventListeners(arg1:starling.display.DisplayObject, arg2:String, arg3:__AS3__.vec.Vector.<starling.display.DisplayObject>):void
        {
            var loc2:*=null;
            var loc3:*=0;
            var loc4:*=0;
            var loc1:*=arg1 as starling.display.DisplayObjectContainer;
            if (arg1.hasEventListener(arg2)) 
            {
                arg3[arg3.length] = arg1;
            }
            if (loc1) 
            {
                loc2 = loc1._children;
                loc3 = loc2.length;
                loc4 = 0;
                while (loc4 < loc3) 
                {
                    this.getChildEventListeners(loc2[loc4], arg2, arg3);
                    ++loc4;
                }
            }
            return;
        }

        internal var _children:__AS3__.vec.Vector.<starling.display.DisplayObject>;

        internal var _touchGroup:Boolean;

        internal static var sBroadcastListeners:__AS3__.vec.Vector.<starling.display.DisplayObject>;

        internal static var sSortBuffer:__AS3__.vec.Vector.<starling.display.DisplayObject>;

        internal static var sCacheToken:starling.rendering.BatchToken;

        internal static var sHelperMatrix:flash.geom.Matrix;

        internal static var sHelperPoint:flash.geom.Point;
    }
}


