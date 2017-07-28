//class DisplayObject
package starling.display 
{
    import __AS3__.vec.*;
    import flash.errors.*;
    import flash.geom.*;
    import flash.system.*;
    import flash.ui.*;
    import flash.utils.*;
    import starling.core.*;
    import starling.errors.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.rendering.*;
    import starling.utils.*;
    
    use namespace starling_internal;
    
    public class DisplayObject extends starling.events.EventDispatcher
    {
        public function DisplayObject()
        {
            this._pushToken = new starling.rendering.BatchToken();
            this._popToken = new starling.rendering.BatchToken();
            super();
            if (flash.system.Capabilities.isDebugger && flash.utils.getQualifiedClassName(this) == "starling.display::DisplayObject") 
            {
                throw new starling.errors.AbstractClassError();
            }
            var loc1:*;
            this._skewY = loc1 = 0;
            this._skewX = loc1 = loc1;
            this._rotation = loc1 = loc1;
            this._pivotY = loc1 = loc1;
            this._pivotX = loc1 = loc1;
            this._y = loc1 = loc1;
            this._x = loc1;
            this._alpha = loc1 = 1;
            this._scaleY = loc1 = loc1;
            this._scaleX = loc1;
            this._hasVisibleArea = loc1 = true;
            this._touchable = loc1 = loc1;
            this._visible = loc1;
            this._blendMode = starling.display.BlendMode.AUTO;
            this._transformationMatrix = new flash.geom.Matrix();
            return;
        }

        public function get scale():Number
        {
            return this.scaleX;
        }

        public function set scale(arg1:Number):void
        {
            var loc1:*;
            this.scaleY = loc1 = arg1;
            this.scaleX = loc1;
            return;
        }

        public function get skewX():Number
        {
            return this._skewX;
        }

        public function set skewX(arg1:Number):void
        {
            arg1 = starling.utils.MathUtil.normalizeAngle(arg1);
            if (this._skewX != arg1) 
            {
                this._skewX = arg1;
                this.setOrientationChanged();
            }
            return;
        }

        public function get skewY():Number
        {
            return this._skewY;
        }

        public function set skewY(arg1:Number):void
        {
            arg1 = starling.utils.MathUtil.normalizeAngle(arg1);
            if (this._skewY != arg1) 
            {
                this._skewY = arg1;
                this.setOrientationChanged();
            }
            return;
        }

        public function get rotation():Number
        {
            return this._rotation;
        }

        public function set rotation(arg1:Number):void
        {
            arg1 = starling.utils.MathUtil.normalizeAngle(arg1);
            if (this._rotation != arg1) 
            {
                this._rotation = arg1;
                this.setOrientationChanged();
            }
            return;
        }

        function get isRotated():Boolean
        {
            return !(this._rotation == 0) || !(this._skewX == 0) || !(this._skewY == 0);
        }

        public function get alpha():Number
        {
            return this._alpha;
        }

        public function set alpha(arg1:Number):void
        {
            if (arg1 != this._alpha) 
            {
                this._alpha = arg1 < 0 ? 0 : arg1 > 1 ? 1 : arg1;
                this.setRequiresRedraw();
            }
            return;
        }

        public function get visible():Boolean
        {
            return this._visible;
        }

        public function set visible(arg1:Boolean):void
        {
            if (arg1 != this._visible) 
            {
                this._visible = arg1;
                this.setRequiresRedraw();
            }
            return;
        }

        public function get is3D():Boolean
        {
            return this._is3D;
        }

        public function get touchable():Boolean
        {
            return this._touchable;
        }

        public function set touchable(arg1:Boolean):void
        {
            this._touchable = arg1;
            return;
        }

        public function get blendMode():String
        {
            return this._blendMode;
        }

        public function set blendMode(arg1:String):void
        {
            if (arg1 != this._blendMode) 
            {
                this._blendMode = arg1;
                this.setRequiresRedraw();
            }
            return;
        }

        public function get name():String
        {
            return this._name;
        }

        public function set name(arg1:String):void
        {
            this._name = arg1;
            return;
        }

        public function get filter():starling.filters.FragmentFilter
        {
            return this._filter;
        }

        public function set filter(arg1:starling.filters.FragmentFilter):void
        {
            if (arg1 != this._filter) 
            {
                if (this._filter) 
                {
                    this._filter.starling_internal::setTarget(null);
                }
                if (arg1) 
                {
                    arg1.starling_internal::setTarget(this);
                }
                this._filter = arg1;
                this.setRequiresRedraw();
            }
            return;
        }

        public function get mask():starling.display.DisplayObject
        {
            return this._mask;
        }

        public function set mask(arg1:starling.display.DisplayObject):void
        {
            if (this._mask != arg1) 
            {
                if (this._mask) 
                {
                    this._mask._maskee = null;
                }
                if (arg1) 
                {
                    arg1._maskee = this;
                    arg1._hasVisibleArea = false;
                }
                this._mask = arg1;
                this.setRequiresRedraw();
            }
            return;
        }

        public function get base():starling.display.DisplayObject
        {
            var loc1:*=this;
            while (loc1._parent) 
            {
                loc1 = loc1._parent;
            }
            return loc1;
        }

        public function get root():starling.display.DisplayObject
        {
            var loc1:*=this;
            while (loc1._parent) 
            {
                if (loc1._parent is starling.display.Stage) 
                {
                    return loc1;
                }
                loc1 = loc1.parent;
            }
            return null;
        }

        public function get stage():starling.display.Stage
        {
            return this.base as starling.display.Stage;
        }

        internal static function findCommonParent(arg1:starling.display.DisplayObject, arg2:starling.display.DisplayObject):starling.display.DisplayObject
        {
            var loc1:*=arg1;
            while (loc1) 
            {
                sAncestors[sAncestors.length] = loc1;
                loc1 = loc1._parent;
            }
            loc1 = arg2;
            while (loc1 && sAncestors.indexOf(loc1) == -1) 
            {
                loc1 = loc1._parent;
            }
            sAncestors.length = 0;
            if (loc1) 
            {
                return loc1;
            }
            throw new ArgumentError("Object not connected to target");
        }

        
        {
            sAncestors = new Vector.<>(0);
            sHelperPoint = new flash.geom.Point();
            sHelperPoint3D = new flash.geom.Vector3D();
            sHelperPointAlt3D = new flash.geom.Vector3D();
            sHelperRect = new flash.geom.Rectangle();
            sHelperMatrix = new flash.geom.Matrix();
            sHelperMatrixAlt = new flash.geom.Matrix();
            sHelperMatrix3D = new flash.geom.Matrix3D();
            sHelperMatrixAlt3D = new flash.geom.Matrix3D();
        }

        public function dispose():void
        {
            if (this._filter) 
            {
                this._filter.dispose();
            }
            if (this._mask) 
            {
                this._mask.dispose();
            }
            this.removeEventListeners();
            this.mask = null;
            return;
        }

        public function removeFromParent(arg1:Boolean=false):void
        {
            if (this._parent) 
            {
                this._parent.removeChild(this, arg1);
            }
            else if (arg1) 
            {
                this.dispose();
            }
            return;
        }

        public function getTransformationMatrix(arg1:starling.display.DisplayObject, arg2:flash.geom.Matrix=null):flash.geom.Matrix
        {
            var loc1:*=null;
            var loc2:*=null;
            if (arg2) 
            {
                arg2.identity();
            }
            else 
            {
                arg2 = new flash.geom.Matrix();
            }
            if (arg1 == this) 
            {
                return arg2;
            }
            if (arg1 == this._parent || arg1 == null && this._parent == null) 
            {
                arg2.copyFrom(this.transformationMatrix);
                return arg2;
            }
            if (arg1 == null || arg1 == this.base) 
            {
                loc2 = this;
                while (loc2 != arg1) 
                {
                    arg2.concat(loc2.transformationMatrix);
                    loc2 = loc2._parent;
                }
                return arg2;
            }
            if (arg1._parent == this) 
            {
                arg1.getTransformationMatrix(this, arg2);
                arg2.invert();
                return arg2;
            }
            loc1 = findCommonParent(this, arg1);
            loc2 = this;
            while (loc2 != loc1) 
            {
                arg2.concat(loc2.transformationMatrix);
                loc2 = loc2._parent;
            }
            if (loc1 == arg1) 
            {
                return arg2;
            }
            sHelperMatrix.identity();
            loc2 = arg1;
            while (loc2 != loc1) 
            {
                sHelperMatrix.concat(loc2.transformationMatrix);
                loc2 = loc2._parent;
            }
            sHelperMatrix.invert();
            arg2.concat(sHelperMatrix);
            return arg2;
        }

        public function getBounds(arg1:starling.display.DisplayObject, arg2:flash.geom.Rectangle=null):flash.geom.Rectangle
        {
            throw new starling.errors.AbstractMethodError();
        }

        public function hitTest(arg1:flash.geom.Point):starling.display.DisplayObject
        {
            if (!this._visible || !this._touchable) 
            {
                return null;
            }
            if (this._mask && !this.hitTestMask(arg1)) 
            {
                return null;
            }
            if (this.getBounds(this, sHelperRect).containsPoint(arg1)) 
            {
                return this;
            }
            return null;
        }

        public function hitTestMask(arg1:flash.geom.Point):Boolean
        {
            var loc1:*=null;
            if (this._mask) 
            {
                if (this._mask.stage) 
                {
                    this.getTransformationMatrix(this._mask, sHelperMatrixAlt);
                }
                else 
                {
                    sHelperMatrixAlt.copyFrom(this._mask.transformationMatrix);
                    sHelperMatrixAlt.invert();
                }
                loc1 = arg1 != sHelperPoint ? sHelperPoint : new flash.geom.Point();
                starling.utils.MatrixUtil.transformPoint(sHelperMatrixAlt, arg1, loc1);
                return !(this._mask.hitTest(loc1) == null);
            }
            return true;
        }

        public function localToGlobal(arg1:flash.geom.Point, arg2:flash.geom.Point=null):flash.geom.Point
        {
            if (this.is3D) 
            {
                sHelperPoint3D.setTo(arg1.x, arg1.y, 0);
                return this.local3DToGlobal(sHelperPoint3D, arg2);
            }
            this.getTransformationMatrix(this.base, sHelperMatrixAlt);
            return starling.utils.MatrixUtil.transformPoint(sHelperMatrixAlt, arg1, arg2);
        }

        public function globalToLocal(arg1:flash.geom.Point, arg2:flash.geom.Point=null):flash.geom.Point
        {
            if (this.is3D) 
            {
                this.globalToLocal3D(arg1, sHelperPoint3D);
                this.stage.getCameraPosition(this, sHelperPointAlt3D);
                return starling.utils.MathUtil.intersectLineWithXYPlane(sHelperPointAlt3D, sHelperPoint3D, arg2);
            }
            this.getTransformationMatrix(this.base, sHelperMatrixAlt);
            sHelperMatrixAlt.invert();
            return starling.utils.MatrixUtil.transformPoint(sHelperMatrixAlt, arg1, arg2);
        }

        public function render(arg1:starling.rendering.Painter):void
        {
            throw new starling.errors.AbstractMethodError();
        }

        public function alignPivot(arg1:String="center", arg2:String="center"):void
        {
            var loc1:*=this.getBounds(this, sHelperRect);
            this.setOrientationChanged();
            if (arg1 != starling.utils.Align.LEFT) 
            {
                if (arg1 != starling.utils.Align.CENTER) 
                {
                    if (arg1 != starling.utils.Align.RIGHT) 
                    {
                        throw new ArgumentError("Invalid horizontal alignment: " + arg1);
                    }
                    else 
                    {
                        this._pivotX = loc1.x + loc1.width;
                    }
                }
                else 
                {
                    this._pivotX = loc1.x + loc1.width / 2;
                }
            }
            else 
            {
                this._pivotX = loc1.x;
            }
            if (arg2 != starling.utils.Align.TOP) 
            {
                if (arg2 != starling.utils.Align.CENTER) 
                {
                    if (arg2 != starling.utils.Align.BOTTOM) 
                    {
                        throw new ArgumentError("Invalid vertical alignment: " + arg2);
                    }
                    else 
                    {
                        this._pivotY = loc1.y + loc1.height;
                    }
                }
                else 
                {
                    this._pivotY = loc1.y + loc1.height / 2;
                }
            }
            else 
            {
                this._pivotY = loc1.y;
            }
            return;
        }

        public function getTransformationMatrix3D(arg1:starling.display.DisplayObject, arg2:flash.geom.Matrix3D=null):flash.geom.Matrix3D
        {
            var loc1:*=null;
            var loc2:*=null;
            if (arg2) 
            {
                arg2.identity();
            }
            else 
            {
                arg2 = new flash.geom.Matrix3D();
            }
            if (arg1 == this) 
            {
                return arg2;
            }
            if (arg1 == this._parent || arg1 == null && this._parent == null) 
            {
                arg2.copyFrom(this.transformationMatrix3D);
                return arg2;
            }
            if (arg1 == null || arg1 == this.base) 
            {
                loc2 = this;
                while (loc2 != arg1) 
                {
                    arg2.append(loc2.transformationMatrix3D);
                    loc2 = loc2._parent;
                }
                return arg2;
            }
            if (arg1._parent == this) 
            {
                arg1.getTransformationMatrix3D(this, arg2);
                arg2.invert();
                return arg2;
            }
            loc1 = findCommonParent(this, arg1);
            loc2 = this;
            while (loc2 != loc1) 
            {
                arg2.append(loc2.transformationMatrix3D);
                loc2 = loc2._parent;
            }
            if (loc1 == arg1) 
            {
                return arg2;
            }
            sHelperMatrix3D.identity();
            loc2 = arg1;
            while (loc2 != loc1) 
            {
                sHelperMatrix3D.append(loc2.transformationMatrix3D);
                loc2 = loc2._parent;
            }
            sHelperMatrix3D.invert();
            arg2.append(sHelperMatrix3D);
            return arg2;
        }

        public function local3DToGlobal(arg1:flash.geom.Vector3D, arg2:flash.geom.Point=null):flash.geom.Point
        {
            var loc1:*=this.stage;
            if (loc1 == null) 
            {
                throw new flash.errors.IllegalOperationError("Object not connected to stage");
            }
            this.getTransformationMatrix3D(loc1, sHelperMatrixAlt3D);
            starling.utils.MatrixUtil.transformPoint3D(sHelperMatrixAlt3D, arg1, sHelperPoint3D);
            return starling.utils.MathUtil.intersectLineWithXYPlane(loc1.cameraPosition, sHelperPoint3D, arg2);
        }

        public function globalToLocal3D(arg1:flash.geom.Point, arg2:flash.geom.Vector3D=null):flash.geom.Vector3D
        {
            var loc1:*=this.stage;
            if (loc1 == null) 
            {
                throw new flash.errors.IllegalOperationError("Object not connected to stage");
            }
            this.getTransformationMatrix3D(loc1, sHelperMatrixAlt3D);
            sHelperMatrixAlt3D.invert();
            return starling.utils.MatrixUtil.transformCoords3D(sHelperMatrixAlt3D, arg1.x, arg1.y, 0, arg2);
        }

        starling_internal function setParent(arg1:starling.display.DisplayObjectContainer):void
        {
            var loc1:*=arg1;
            while (!(loc1 == this) && !(loc1 == null)) 
            {
                loc1 = loc1._parent;
            }
            if (loc1 == this) 
            {
                throw new ArgumentError("An object cannot be added as a child to itself or one " + "of its children (or children\'s children, etc.)");
            }
            this._parent = arg1;
            return;
        }

        function setIs3D(arg1:Boolean):void
        {
            this._is3D = arg1;
            return;
        }

        function get isMask():Boolean
        {
            return !(this._maskee == null);
        }

        public function setRequiresRedraw():void
        {
            var loc1:*=this._parent || this._maskee;
            var loc2:*=starling.core.Starling.frameID;
            this._lastParentOrSelfChangeFrameID = loc2;
            this._hasVisibleArea = !(this._alpha == 0) && this._visible && this._maskee == null && !(this._scaleX == 0) && !(this._scaleY == 0);
            while (loc1 && !(loc1._lastChildChangeFrameID == loc2)) 
            {
                loc1._lastChildChangeFrameID = loc2;
                loc1 = loc1._parent || loc1._maskee;
            }
            return;
        }

        public function get requiresRedraw():Boolean
        {
            var loc1:*=starling.core.Starling.frameID;
            return this._lastParentOrSelfChangeFrameID == loc1 || this._lastChildChangeFrameID == loc1;
        }

        starling_internal function excludeFromCache():void
        {
            var loc1:*=this;
            var loc2:*=4294967295;
            while (loc1 && !(loc1._tokenFrameID == loc2)) 
            {
                loc1._tokenFrameID = loc2;
                loc1 = loc1._parent;
            }
            return;
        }

        internal function setOrientationChanged():void
        {
            this._orientationChanged = true;
            this.setRequiresRedraw();
            return;
        }

        public override function dispatchEvent(arg1:starling.events.Event):void
        {
            if (arg1.type == starling.events.Event.REMOVED_FROM_STAGE && this.stage == null) 
            {
                return;
            }
            super.dispatchEvent(arg1);
            return;
        }

        public override function addEventListener(arg1:String, arg2:Function):void
        {
            if (arg1 == starling.events.Event.ENTER_FRAME && !hasEventListener(arg1)) 
            {
                this.addEventListener(starling.events.Event.ADDED_TO_STAGE, this.addEnterFrameListenerToStage);
                this.addEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.removeEnterFrameListenerFromStage);
                if (this.stage) 
                {
                    this.addEnterFrameListenerToStage();
                }
            }
            super.addEventListener(arg1, arg2);
            return;
        }

        public override function removeEventListener(arg1:String, arg2:Function):void
        {
            super.removeEventListener(arg1, arg2);
            if (arg1 == starling.events.Event.ENTER_FRAME && !hasEventListener(arg1)) 
            {
                this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, this.addEnterFrameListenerToStage);
                this.removeEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.removeEnterFrameListenerFromStage);
                this.removeEnterFrameListenerFromStage();
            }
            return;
        }

        public override function removeEventListeners(arg1:String=null):void
        {
            if ((arg1 == null || arg1 == starling.events.Event.ENTER_FRAME) && hasEventListener(starling.events.Event.ENTER_FRAME)) 
            {
                this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, this.addEnterFrameListenerToStage);
                this.removeEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.removeEnterFrameListenerFromStage);
                this.removeEnterFrameListenerFromStage();
            }
            super.removeEventListeners(arg1);
            return;
        }

        internal function addEnterFrameListenerToStage():void
        {
            starling.core.Starling.current.stage.addEnterFrameListener(this);
            return;
        }

        internal function removeEnterFrameListenerFromStage():void
        {
            starling.core.Starling.current.stage.removeEnterFrameListener(this);
            return;
        }

        public function get transformationMatrix():flash.geom.Matrix
        {
            var loc1:*=NaN;
            var loc2:*=NaN;
            var loc3:*=NaN;
            var loc4:*=NaN;
            var loc5:*=NaN;
            var loc6:*=NaN;
            var loc7:*=NaN;
            var loc8:*=NaN;
            if (this._orientationChanged) 
            {
                this._orientationChanged = false;
                if (this._skewX == 0 && this._skewY == 0) 
                {
                    if (this._rotation != 0) 
                    {
                        loc1 = Math.cos(this._rotation);
                        loc2 = Math.sin(this._rotation);
                        loc3 = this._scaleX * loc1;
                        loc4 = this._scaleX * loc2;
                        loc5 = this._scaleY * (-loc2);
                        loc6 = this._scaleY * loc1;
                        loc7 = this._x - this._pivotX * loc3 - this._pivotY * loc5;
                        loc8 = this._y - this._pivotX * loc4 - this._pivotY * loc6;
                        this._transformationMatrix.setTo(loc3, loc4, loc5, loc6, loc7, loc8);
                    }
                    else 
                    {
                        this._transformationMatrix.setTo(this._scaleX, 0, 0, this._scaleY, this._x - this._pivotX * this._scaleX, this._y - this._pivotY * this._scaleY);
                    }
                }
                else 
                {
                    this._transformationMatrix.identity();
                    this._transformationMatrix.scale(this._scaleX, this._scaleY);
                    starling.utils.MatrixUtil.skew(this._transformationMatrix, this._skewX, this._skewY);
                    this._transformationMatrix.rotate(this._rotation);
                    this._transformationMatrix.translate(this._x, this._y);
                    if (!(this._pivotX == 0) || !(this._pivotY == 0)) 
                    {
                        this._transformationMatrix.tx = this._x - this._transformationMatrix.a * this._pivotX - this._transformationMatrix.c * this._pivotY;
                        this._transformationMatrix.ty = this._y - this._transformationMatrix.b * this._pivotX - this._transformationMatrix.d * this._pivotY;
                    }
                }
            }
            return this._transformationMatrix;
        }

        public function set transformationMatrix(arg1:flash.geom.Matrix):void
        {
            var loc1:*=Math.PI / 4;
            this.setRequiresRedraw();
            this._orientationChanged = false;
            this._transformationMatrix.copyFrom(arg1);
            var loc2:*;
            this._pivotY = loc2 = 0;
            this._pivotX = loc2;
            this._x = arg1.tx;
            this._y = arg1.ty;
            this._skewX = Math.atan((-arg1.c) / arg1.d);
            this._skewY = Math.atan(arg1.b / arg1.a);
            if (this._skewX != this._skewX) 
            {
                this._skewX = 0;
            }
            if (this._skewY != this._skewY) 
            {
                this._skewY = 0;
            }
            this._scaleY = this._skewX > -loc1 && this._skewX < loc1 ? arg1.d / Math.cos(this._skewX) : (-arg1.c) / Math.sin(this._skewX);
            this._scaleX = this._skewY > -loc1 && this._skewY < loc1 ? arg1.a / Math.cos(this._skewY) : arg1.b / Math.sin(this._skewY);
            if (starling.utils.MathUtil.isEquivalent(this._skewX, this._skewY)) 
            {
                this._rotation = this._skewX;
                this._skewY = loc2 = 0;
                this._skewX = loc2;
            }
            else 
            {
                this._rotation = 0;
            }
            return;
        }

        public function get transformationMatrix3D():flash.geom.Matrix3D
        {
            if (this._transformationMatrix3D == null) 
            {
                this._transformationMatrix3D = new flash.geom.Matrix3D();
            }
            return starling.utils.MatrixUtil.convertTo3D(this.transformationMatrix, this._transformationMatrix3D);
        }

        public function get parent():starling.display.DisplayObjectContainer
        {
            return this._parent;
        }

        public function get useHandCursor():Boolean
        {
            return this._useHandCursor;
        }

        public function set useHandCursor(arg1:Boolean):void
        {
            if (arg1 == this._useHandCursor) 
            {
                return;
            }
            this._useHandCursor = arg1;
            if (this._useHandCursor) 
            {
                this.addEventListener(starling.events.TouchEvent.TOUCH, this.onTouch);
            }
            else 
            {
                this.removeEventListener(starling.events.TouchEvent.TOUCH, this.onTouch);
            }
            return;
        }

        internal function onTouch(arg1:starling.events.TouchEvent):void
        {
            flash.ui.Mouse.cursor = arg1.interactsWith(this) ? flash.ui.MouseCursor.BUTTON : flash.ui.MouseCursor.AUTO;
            return;
        }

        public function get bounds():flash.geom.Rectangle
        {
            return this.getBounds(this._parent);
        }

        public function get width():Number
        {
            return this.getBounds(this._parent, sHelperRect).width;
        }

        public function set width(arg1:Number):void
        {
            var loc1:*=NaN;
            var loc2:*=!(this._scaleX == this._scaleX);
            if (this._scaleX == 0 || loc2) 
            {
                this.scaleX = 1;
                loc1 = this.width;
            }
            else 
            {
                loc1 = Math.abs(this.width / this._scaleX);
            }
            if (loc1) 
            {
                this.scaleX = arg1 / loc1;
            }
            return;
        }

        public function get height():Number
        {
            return this.getBounds(this._parent, sHelperRect).height;
        }

        public function set height(arg1:Number):void
        {
            var loc1:*=NaN;
            var loc2:*=!(this._scaleY == this._scaleY);
            if (this._scaleY == 0 || loc2) 
            {
                this.scaleY = 1;
                loc1 = this.height;
            }
            else 
            {
                loc1 = Math.abs(this.height / this._scaleY);
            }
            if (loc1) 
            {
                this.scaleY = arg1 / loc1;
            }
            return;
        }

        public function get x():Number
        {
            return this._x;
        }

        public function set x(arg1:Number):void
        {
            if (this._x != arg1) 
            {
                this._x = arg1;
                this.setOrientationChanged();
            }
            return;
        }

        public function get y():Number
        {
            return this._y;
        }

        public function set y(arg1:Number):void
        {
            if (this._y != arg1) 
            {
                this._y = arg1;
                this.setOrientationChanged();
            }
            return;
        }

        public function get pivotX():Number
        {
            return this._pivotX;
        }

        public function set pivotX(arg1:Number):void
        {
            if (this._pivotX != arg1) 
            {
                this._pivotX = arg1;
                this.setOrientationChanged();
            }
            return;
        }

        public function get pivotY():Number
        {
            return this._pivotY;
        }

        public function set pivotY(arg1:Number):void
        {
            if (this._pivotY != arg1) 
            {
                this._pivotY = arg1;
                this.setOrientationChanged();
            }
            return;
        }

        public function get scaleX():Number
        {
            return this._scaleX;
        }

        public function set scaleX(arg1:Number):void
        {
            if (this._scaleX != arg1) 
            {
                this._scaleX = arg1;
                this.setOrientationChanged();
            }
            return;
        }

        public function get scaleY():Number
        {
            return this._scaleY;
        }

        public function set scaleY(arg1:Number):void
        {
            if (this._scaleY != arg1) 
            {
                this._scaleY = arg1;
                this.setOrientationChanged();
            }
            return;
        }

        internal var _x:Number;

        internal var _y:Number;

        internal var _pivotX:Number;

        internal var _pivotY:Number;

        internal var _scaleX:Number;

        internal var _scaleY:Number;

        internal var _skewX:Number;

        internal var _skewY:Number;

        internal var _rotation:Number;

        internal var _alpha:Number;

        internal var _visible:Boolean;

        internal var _touchable:Boolean;

        internal var _blendMode:String;

        internal var _useHandCursor:Boolean;

        internal var _transformationMatrix:flash.geom.Matrix;

        internal var _transformationMatrix3D:flash.geom.Matrix3D;

        internal var _orientationChanged:Boolean;

        internal var _is3D:Boolean;

        internal var _maskee:starling.display.DisplayObject;

        var _parent:starling.display.DisplayObjectContainer;

        var _lastParentOrSelfChangeFrameID:uint;

        var _lastChildChangeFrameID:uint;

        var _tokenFrameID:uint;

        var _pushToken:starling.rendering.BatchToken;

        var _popToken:starling.rendering.BatchToken;

        var _hasVisibleArea:Boolean;

        var _filter:starling.filters.FragmentFilter;

        var _mask:starling.display.DisplayObject;

        internal static var sHelperPoint:flash.geom.Point;

        internal static var sHelperPoint3D:flash.geom.Vector3D;

        internal static var sHelperPointAlt3D:flash.geom.Vector3D;

        internal static var sHelperRect:flash.geom.Rectangle;

        internal static var sHelperMatrix:flash.geom.Matrix;

        internal static var sHelperMatrixAlt:flash.geom.Matrix;

        internal static var sHelperMatrix3D:flash.geom.Matrix3D;

        internal static var sHelperMatrixAlt3D:flash.geom.Matrix3D;

        internal var _name:String;

        internal static var sAncestors:__AS3__.vec.Vector.<starling.display.DisplayObject>;
    }
}


