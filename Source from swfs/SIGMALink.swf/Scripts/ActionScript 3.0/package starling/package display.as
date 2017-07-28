//package display
//  class BlendMode
package starling.display 
{
    import flash.display3D.*;
    import starling.core.*;
    
    public class BlendMode extends Object
    {
        public function BlendMode(arg1:String, arg2:String, arg3:String)
        {
            super();
            this._name = arg1;
            this._sourceFactor = arg2;
            this._destinationFactor = arg3;
            return;
        }

        public function activate():void
        {
            starling.core.Starling.context.setBlendFactors(this._sourceFactor, this._destinationFactor);
            return;
        }

        public function toString():String
        {
            return this._name;
        }

        public function get sourceFactor():String
        {
            return this._sourceFactor;
        }

        public function get destinationFactor():String
        {
            return this._destinationFactor;
        }

        public function get name():String
        {
            return this._name;
        }

        public static function get(arg1:String):starling.display.BlendMode
        {
            if (sBlendModes == null) 
            {
                registerDefaults();
            }
            if (arg1 in sBlendModes) 
            {
                return sBlendModes[arg1];
            }
            throw new ArgumentError("Blend mode not found: " + arg1);
        }

        public static function register(arg1:String, arg2:String, arg3:String):starling.display.BlendMode
        {
            if (sBlendModes == null) 
            {
                registerDefaults();
            }
            var loc1:*=new BlendMode(arg1, arg2, arg3);
            sBlendModes[arg1] = loc1;
            return loc1;
        }

        internal static function registerDefaults():void
        {
            if (sBlendModes) 
            {
                return;
            }
            sBlendModes = {};
            register("none", flash.display3D.Context3DBlendFactor.ONE, flash.display3D.Context3DBlendFactor.ZERO);
            register("normal", flash.display3D.Context3DBlendFactor.ONE, flash.display3D.Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA);
            register("add", flash.display3D.Context3DBlendFactor.ONE, flash.display3D.Context3DBlendFactor.ONE);
            register("multiply", flash.display3D.Context3DBlendFactor.DESTINATION_COLOR, flash.display3D.Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA);
            register("screen", flash.display3D.Context3DBlendFactor.ONE, flash.display3D.Context3DBlendFactor.ONE_MINUS_SOURCE_COLOR);
            register("erase", flash.display3D.Context3DBlendFactor.ZERO, flash.display3D.Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA);
            register("mask", flash.display3D.Context3DBlendFactor.ZERO, flash.display3D.Context3DBlendFactor.SOURCE_ALPHA);
            register("below", flash.display3D.Context3DBlendFactor.ONE_MINUS_DESTINATION_ALPHA, flash.display3D.Context3DBlendFactor.DESTINATION_ALPHA);
            return;
        }

        public static const AUTO:String="auto";

        public static const NONE:String="none";

        public static const NORMAL:String="normal";

        public static const ADD:String="add";

        public static const MULTIPLY:String="multiply";

        public static const SCREEN:String="screen";

        public static const ERASE:String="erase";

        public static const MASK:String="mask";

        public static const BELOW:String="below";

        internal var _name:String;

        internal var _sourceFactor:String;

        internal var _destinationFactor:String;

        internal static var sBlendModes:Object;
    }
}


//  class DisplayObject
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


//  class DisplayObjectContainer
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


//  class Image
package starling.display 
{
    import __AS3__.vec.*;
    import flash.geom.*;
    import starling.rendering.*;
    import starling.textures.*;
    import starling.utils.*;
    
    public class Image extends starling.display.Quad
    {
        public function Image(arg1:starling.textures.Texture)
        {
            super(100, 100);
            this.texture = arg1;
            readjustSize();
            return;
        }

        public function get scale9Grid():flash.geom.Rectangle
        {
            return this._scale9Grid;
        }

        public function set scale9Grid(arg1:flash.geom.Rectangle):void
        {
            if (arg1) 
            {
                if (this._scale9Grid != null) 
                {
                    this._scale9Grid.copyFrom(arg1);
                }
                else 
                {
                    this._scale9Grid = arg1.clone();
                }
                readjustSize();
                this._tileGrid = null;
            }
            else 
            {
                this._scale9Grid = null;
            }
            this.setupVertices();
            return;
        }

        public function get tileGrid():flash.geom.Rectangle
        {
            return this._tileGrid;
        }

        public function set tileGrid(arg1:flash.geom.Rectangle):void
        {
            if (arg1) 
            {
                if (this._tileGrid != null) 
                {
                    this._tileGrid.copyFrom(arg1);
                }
                else 
                {
                    this._tileGrid = arg1.clone();
                }
                this._scale9Grid = null;
            }
            else 
            {
                this._tileGrid = null;
            }
            this.setupVertices();
            return;
        }

        protected override function setupVertices():void
        {
            if (texture && this._scale9Grid) 
            {
                this.setupScale9Grid();
            }
            else if (texture && this._tileGrid) 
            {
                this.setupTileGrid();
            }
            else 
            {
                super.setupVertices();
            }
            return;
        }

        public override function set scaleX(arg1:Number):void
        {
            super.scaleX = arg1;
            if (texture && (this._scale9Grid || this._tileGrid)) 
            {
                this.setupVertices();
            }
            return;
        }

        public override function set scaleY(arg1:Number):void
        {
            super.scaleY = arg1;
            if (texture && (this._scale9Grid || this._tileGrid)) 
            {
                this.setupVertices();
            }
            return;
        }

        public override function set texture(arg1:starling.textures.Texture):void
        {
            if (arg1 != texture) 
            {
                super.texture = arg1;
                if (this._scale9Grid && arg1) 
                {
                    readjustSize();
                }
            }
            return;
        }

        internal function setupScale9Grid():void
        {
            var loc10:*=0;
            var loc11:*=0;
            var loc12:*=NaN;
            var loc18:*=0;
            var loc19:*=NaN;
            var loc1:*=this.texture;
            var loc2:*=loc1.frame;
            var loc3:*=scaleX > 0 ? scaleX : -scaleX;
            var loc4:*=scaleY > 0 ? scaleY : -scaleY;
            if (starling.utils.MathUtil.isEquivalent(this._scale9Grid.width, loc1.frameWidth)) 
            {
                loc4 = loc4 / loc3;
            }
            else if (starling.utils.MathUtil.isEquivalent(this._scale9Grid.height, loc1.frameHeight)) 
            {
                loc3 = loc3 / loc4;
            }
            var loc5:*=1 / loc3;
            var loc6:*=1 / loc4;
            var loc7:*=this.vertexData;
            var loc8:*=this.indexData;
            var loc9:*=loc7.numVertices;
            var loc13:*=starling.utils.Pool.getRectangle();
            var loc14:*=starling.utils.Pool.getRectangle();
            var loc15:*=starling.utils.Pool.getRectangle();
            var loc16:*=starling.utils.Pool.getRectangle();
            loc13.copyFrom(this._scale9Grid);
            loc14.setTo(0, 0, loc1.frameWidth, loc1.frameHeight);
            if (loc2) 
            {
                loc15.setTo(-loc2.x, -loc2.y, loc1.width, loc1.height);
            }
            else 
            {
                loc15.copyFrom(loc14);
            }
            starling.utils.RectangleUtil.intersect(loc13, loc15, loc16);
            var loc20:*;
            sBasCols[2] = loc20 = 0;
            sBasCols[0] = loc20;
            sBasRows[2] = loc20 = 0;
            sBasRows[0] = loc20;
            sBasCols[1] = loc16.width;
            sBasRows[1] = loc16.height;
            if (loc15.x < loc13.x) 
            {
                sBasCols[0] = loc13.x - loc15.x;
            }
            if (loc15.y < loc13.y) 
            {
                sBasRows[0] = loc13.y - loc15.y;
            }
            if (loc15.right > loc13.right) 
            {
                sBasCols[2] = loc15.right - loc13.right;
            }
            if (loc15.bottom > loc13.bottom) 
            {
                sBasRows[2] = loc15.bottom - loc13.bottom;
            }
            if (loc15.x < loc13.x) 
            {
                sPadding.left = loc15.x * loc5;
            }
            else 
            {
                sPadding.left = loc13.x * loc5 + loc15.x - loc13.x;
            }
            if (loc15.right > loc13.right) 
            {
                sPadding.right = (loc14.width - loc15.right) * loc5;
            }
            else 
            {
                sPadding.right = (loc14.width - loc13.right) * loc5 + loc13.right - loc15.right;
            }
            if (loc15.y < loc13.y) 
            {
                sPadding.top = loc15.y * loc6;
            }
            else 
            {
                sPadding.top = loc13.y * loc6 + loc15.y - loc13.y;
            }
            if (loc15.bottom > loc13.bottom) 
            {
                sPadding.bottom = (loc14.height - loc15.bottom) * loc6;
            }
            else 
            {
                sPadding.bottom = (loc14.height - loc13.bottom) * loc6 + loc13.bottom - loc15.bottom;
            }
            sPosCols[0] = sBasCols[0] * loc5;
            sPosCols[2] = sBasCols[2] * loc5;
            sPosCols[1] = loc14.width - sPadding.left - sPadding.right - sPosCols[0] - sPosCols[2];
            sPosRows[0] = sBasRows[0] * loc6;
            sPosRows[2] = sBasRows[2] * loc6;
            sPosRows[1] = loc14.height - sPadding.top - sPadding.bottom - sPosRows[0] - sPosRows[2];
            if (sPosCols[1] <= 0) 
            {
                loc12 = loc14.width / (loc14.width - loc13.width) * loc3;
                sPadding.left = sPadding.left * loc12;
                sPosCols[0] = sPosCols[0] * loc12;
                sPosCols[1] = 0;
                sPosCols[2] = sPosCols[2] * loc12;
            }
            if (sPosRows[1] <= 0) 
            {
                loc12 = loc14.height / (loc14.height - loc13.height) * loc4;
                sPadding.top = sPadding.top * loc12;
                sPosRows[0] = sPosRows[0] * loc12;
                sPosRows[1] = 0;
                sPosRows[2] = sPosRows[2] * loc12;
            }
            sTexCols[0] = sBasCols[0] / loc15.width;
            sTexCols[2] = sBasCols[2] / loc15.width;
            sTexCols[1] = 1 - sTexCols[0] - sTexCols[2];
            sTexRows[0] = sBasRows[0] / loc15.height;
            sTexRows[2] = sBasRows[2] / loc15.height;
            sTexRows[1] = 1 - sTexRows[0] - sTexRows[2];
            loc10 = this.setupScale9GridAttributes(sPadding.left, sPadding.top, sPosCols, sPosRows, sTexCols, sTexRows);
            loc11 = loc10 / 4;
            loc7.numVertices = loc10;
            loc8.numIndices = 0;
            var loc17:*=0;
            while (loc17 < loc11) 
            {
                loc8.addQuad(loc17 * 4, loc17 * 4 + 1, loc17 * 4 + 2, loc17 * 4 + 3);
                ++loc17;
            }
            if (loc10 != loc9) 
            {
                loc18 = loc9 ? loc7.getColor(0) : 16777215;
                loc19 = loc9 ? loc7.getAlpha(0) : 1;
                loc7.colorize("color", loc18, loc19);
            }
            starling.utils.Pool.putRectangle(loc14);
            starling.utils.Pool.putRectangle(loc15);
            starling.utils.Pool.putRectangle(loc13);
            starling.utils.Pool.putRectangle(loc16);
            setRequiresRedraw();
            return;
        }

        internal function setupScale9GridAttributes(arg1:Number, arg2:Number, arg3:__AS3__.vec.Vector.<Number>, arg4:__AS3__.vec.Vector.<Number>, arg5:__AS3__.vec.Vector.<Number>, arg6:__AS3__.vec.Vector.<Number>):int
        {
            var loc3:*=0;
            var loc4:*=0;
            var loc5:*=NaN;
            var loc6:*=NaN;
            var loc7:*=NaN;
            var loc8:*=NaN;
            var loc1:*="position";
            var loc2:*="texCoords";
            var loc9:*=this.vertexData;
            var loc10:*=this.texture;
            var loc11:*=arg1;
            var loc12:*=arg2;
            var loc13:*=0;
            var loc14:*=0;
            var loc15:*=0;
            loc3 = 0;
            while (loc3 < 3) 
            {
                loc6 = arg4[loc3];
                loc8 = arg6[loc3];
                if (loc6 > 0) 
                {
                    loc4 = 0;
                    while (loc4 < 3) 
                    {
                        loc5 = arg3[loc4];
                        loc7 = arg5[loc4];
                        if (loc5 > 0) 
                        {
                            loc9.setPoint(loc15, loc1, loc11, loc12);
                            loc10.setTexCoords(loc9, loc15, loc2, loc13, loc14);
                            ++loc15;
                            loc9.setPoint(loc15, loc1, loc11 + loc5, loc12);
                            loc10.setTexCoords(loc9, loc15, loc2, loc13 + loc7, loc14);
                            ++loc15;
                            loc9.setPoint(loc15, loc1, loc11, loc12 + loc6);
                            loc10.setTexCoords(loc9, loc15, loc2, loc13, loc14 + loc8);
                            ++loc15;
                            loc9.setPoint(loc15, loc1, loc11 + loc5, loc12 + loc6);
                            loc10.setTexCoords(loc9, loc15, loc2, loc13 + loc7, loc14 + loc8);
                            ++loc15;
                            loc11 = loc11 + loc5;
                        }
                        loc13 = loc13 + loc7;
                        ++loc4;
                    }
                    loc12 = loc12 + loc6;
                }
                loc11 = arg1;
                loc13 = 0;
                loc14 = loc14 + loc8;
                ++loc3;
            }
            return loc15;
        }

        internal function setupTileGrid():void
        {
            var loc21:*=NaN;
            var loc22:*=NaN;
            var loc23:*=NaN;
            var loc24:*=NaN;
            var loc25:*=NaN;
            var loc26:*=NaN;
            var loc27:*=NaN;
            var loc28:*=NaN;
            var loc31:*=NaN;
            var loc1:*=this.texture;
            var loc2:*=loc1.frame;
            var loc3:*=this.vertexData;
            var loc4:*=this.indexData;
            var loc5:*=getBounds(this, sBounds);
            var loc6:*=loc3.numVertices;
            var loc7:*=loc6 ? loc3.getColor(0) : 16777215;
            var loc8:*=loc6 ? loc3.getAlpha(0) : 1;
            var loc9:*=scaleX > 0 ? 1 / scaleX : -1 / scaleX;
            var loc10:*=scaleY > 0 ? 1 / scaleY : -1 / scaleY;
            var loc11:*=this._tileGrid.width > 0 ? this._tileGrid.width : loc1.frameWidth;
            var loc12:*=this._tileGrid.height > 0 ? this._tileGrid.height : loc1.frameHeight;
            loc11 = loc11 * loc9;
            loc12 = loc12 * loc10;
            var loc13:*=loc2 ? (-loc2.x) * loc11 / loc2.width : 0;
            var loc14:*=loc2 ? (-loc2.y) * loc12 / loc2.height : 0;
            var loc15:*=loc1.width * loc11 / loc1.frameWidth;
            var loc16:*=loc1.height * loc12 / loc1.frameHeight;
            var loc17:*=this._tileGrid.x * loc9 % loc11;
            var loc18:*=this._tileGrid.y * loc10 % loc12;
            if (loc17 < 0) 
            {
                loc17 = loc17 + loc11;
            }
            if (loc18 < 0) 
            {
                loc18 = loc18 + loc12;
            }
            var loc19:*=loc17 + loc13;
            var loc20:*=loc18 + loc14;
            if (loc19 > loc11 - loc15) 
            {
                loc19 = loc19 - loc11;
            }
            if (loc20 > loc12 - loc16) 
            {
                loc20 = loc20 - loc12;
            }
            var loc29:*="position";
            var loc30:*="texCoords";
            var loc32:*=loc20;
            var loc33:*=0;
            loc4.numIndices = 0;
            while (loc32 < loc5.height) 
            {
                loc31 = loc19;
                while (loc31 < loc5.width) 
                {
                    loc4.addQuad(loc33, loc33 + 1, loc33 + 2, loc33 + 3);
                    loc21 = loc31 < 0 ? 0 : loc31;
                    loc23 = loc32 < 0 ? 0 : loc32;
                    loc22 = loc31 + loc15 > loc5.width ? loc5.width : loc31 + loc15;
                    loc24 = loc32 + loc16 > loc5.height ? loc5.height : loc32 + loc16;
                    loc3.setPoint(loc33, loc29, loc21, loc23);
                    loc3.setPoint(loc33 + 1, loc29, loc22, loc23);
                    loc3.setPoint(loc33 + 2, loc29, loc21, loc24);
                    loc3.setPoint(loc33 + 3, loc29, loc22, loc24);
                    loc25 = (loc21 - loc31) / loc15;
                    loc27 = (loc23 - loc32) / loc16;
                    loc26 = (loc22 - loc31) / loc15;
                    loc28 = (loc24 - loc32) / loc16;
                    loc1.setTexCoords(loc3, loc33, loc30, loc25, loc27);
                    loc1.setTexCoords(loc3, loc33 + 1, loc30, loc26, loc27);
                    loc1.setTexCoords(loc3, loc33 + 2, loc30, loc25, loc28);
                    loc1.setTexCoords(loc3, loc33 + 3, loc30, loc26, loc28);
                    loc31 = loc31 + loc11;
                    loc33 = loc33 + 4;
                }
                loc32 = loc32 + loc12;
            }
            loc3.numVertices = loc33;
            var loc34:*=loc6;
            while (loc34 < loc33) 
            {
                loc3.setColor(loc34, "color", loc7);
                loc3.setAlpha(loc34, "color", loc8);
                ++loc34;
            }
            setRequiresRedraw();
            return;
        }

        
        {
            sPadding = new starling.utils.Padding();
            sBounds = new flash.geom.Rectangle();
            sBasCols = new Vector.<Number>(3, true);
            sBasRows = new Vector.<Number>(3, true);
            sPosCols = new Vector.<Number>(3, true);
            sPosRows = new Vector.<Number>(3, true);
            sTexCols = new Vector.<Number>(3, true);
            sTexRows = new Vector.<Number>(3, true);
        }

        internal var _scale9Grid:flash.geom.Rectangle;

        internal var _tileGrid:flash.geom.Rectangle;

        internal static var sPadding:starling.utils.Padding;

        internal static var sBounds:flash.geom.Rectangle;

        internal static var sBasCols:__AS3__.vec.Vector.<Number>;

        internal static var sBasRows:__AS3__.vec.Vector.<Number>;

        internal static var sPosCols:__AS3__.vec.Vector.<Number>;

        internal static var sPosRows:__AS3__.vec.Vector.<Number>;

        internal static var sTexCols:__AS3__.vec.Vector.<Number>;

        internal static var sTexRows:__AS3__.vec.Vector.<Number>;
    }
}


//  class Mesh
package starling.display 
{
    import flash.geom.*;
    import starling.core.*;
    import starling.geom.*;
    import starling.rendering.*;
    import starling.styles.*;
    import starling.textures.*;
    import starling.utils.*;
    
    use namespace starling_internal;
    
    public class Mesh extends starling.display.DisplayObject
    {
        public function Mesh(arg1:starling.rendering.VertexData, arg2:starling.rendering.IndexData, arg3:starling.styles.MeshStyle=null)
        {
            super();
            if (arg1 == null) 
            {
                throw new ArgumentError("VertexData must not be null");
            }
            if (arg2 == null) 
            {
                throw new ArgumentError("IndexData must not be null");
            }
            this._vertexData = arg1;
            this._indexData = arg2;
            this.setStyle(arg3, false);
            return;
        }

        public static function get defaultStyleFactory():Function
        {
            return sDefaultStyleFactory;
        }

        public static function set defaultStyleFactory(arg1:Function):void
        {
            sDefaultStyleFactory = arg1;
            return;
        }

        public static function fromPolygon(arg1:starling.geom.Polygon, arg2:starling.styles.MeshStyle=null):starling.display.Mesh
        {
            var loc1:*=new starling.rendering.VertexData(null, arg1.numVertices);
            var loc2:*=new starling.rendering.IndexData(arg1.numTriangles);
            arg1.copyToVertexData(loc1);
            arg1.triangulate(loc2);
            return new Mesh(loc1, loc2, arg2);
        }

        
        {
            sDefaultStyle = starling.styles.MeshStyle;
            sDefaultStyleFactory = null;
        }

        public override function dispose():void
        {
            this._vertexData.clear();
            this._indexData.clear();
            super.dispose();
            return;
        }

        public override function hitTest(arg1:flash.geom.Point):starling.display.DisplayObject
        {
            if (!visible || !touchable || !hitTestMask(arg1)) 
            {
                return null;
            }
            return starling.utils.MeshUtil.containsPoint(this._vertexData, this._indexData, arg1) ? this : null;
        }

        public override function getBounds(arg1:starling.display.DisplayObject, arg2:flash.geom.Rectangle=null):flash.geom.Rectangle
        {
            return starling.utils.MeshUtil.calculateBounds(this._vertexData, this, arg1, arg2);
        }

        public override function render(arg1:starling.rendering.Painter):void
        {
            if (this._pixelSnapping) 
            {
                starling.utils.MatrixUtil.snapToPixels(arg1.state.modelviewMatrix, arg1.pixelSize);
            }
            arg1.batchMesh(this);
            return;
        }

        public function setStyle(arg1:starling.styles.MeshStyle=null, arg2:Boolean=true):void
        {
            if (arg1 != null) 
            {
                if (arg1 == this._style) 
                {
                    return;
                }
                if (arg1.target) 
                {
                    arg1.target.setStyle();
                }
            }
            else 
            {
                arg1 = this.createDefaultMeshStyle();
            }
            if (this._style) 
            {
                if (arg2) 
                {
                    arg1.copyFrom(this._style);
                }
                this._style.starling_internal::setTarget(null);
            }
            this._style = arg1;
            this._style.starling_internal::setTarget(this, this._vertexData, this._indexData);
            return;
        }

        internal function createDefaultMeshStyle():starling.styles.MeshStyle
        {
            var loc1:*=null;
            if (sDefaultStyleFactory != null) 
            {
                if (sDefaultStyleFactory.length != 0) 
                {
                    loc1 = sDefaultStyleFactory(this);
                }
                else 
                {
                    loc1 = sDefaultStyleFactory();
                }
            }
            if (loc1 == null) 
            {
                loc1 = new sDefaultStyle() as starling.styles.MeshStyle;
            }
            return loc1;
        }

        public function setVertexDataChanged():void
        {
            setRequiresRedraw();
            return;
        }

        public function setIndexDataChanged():void
        {
            setRequiresRedraw();
            return;
        }

        public function getVertexPosition(arg1:int, arg2:flash.geom.Point=null):flash.geom.Point
        {
            return this._style.getVertexPosition(arg1, arg2);
        }

        public function setVertexPosition(arg1:int, arg2:Number, arg3:Number):void
        {
            this._style.setVertexPosition(arg1, arg2, arg3);
            return;
        }

        public function getVertexAlpha(arg1:int):Number
        {
            return this._style.getVertexAlpha(arg1);
        }

        public function setVertexAlpha(arg1:int, arg2:Number):void
        {
            this._style.setVertexAlpha(arg1, arg2);
            return;
        }

        public function getVertexColor(arg1:int):uint
        {
            return this._style.getVertexColor(arg1);
        }

        public function setVertexColor(arg1:int, arg2:uint):void
        {
            this._style.setVertexColor(arg1, arg2);
            return;
        }

        public function getTexCoords(arg1:int, arg2:flash.geom.Point=null):flash.geom.Point
        {
            return this._style.getTexCoords(arg1, arg2);
        }

        public function setTexCoords(arg1:int, arg2:Number, arg3:Number):void
        {
            this._style.setTexCoords(arg1, arg2, arg3);
            return;
        }

        protected function get vertexData():starling.rendering.VertexData
        {
            return this._vertexData;
        }

        protected function get indexData():starling.rendering.IndexData
        {
            return this._indexData;
        }

        public function get style():starling.styles.MeshStyle
        {
            return this._style;
        }

        public function set style(arg1:starling.styles.MeshStyle):void
        {
            this.setStyle(arg1);
            return;
        }

        public function get texture():starling.textures.Texture
        {
            return this._style.texture;
        }

        public function set texture(arg1:starling.textures.Texture):void
        {
            this._style.texture = arg1;
            return;
        }

        public function get color():uint
        {
            return this._style.color;
        }

        public function set color(arg1:uint):void
        {
            this._style.color = arg1;
            return;
        }

        public function get textureSmoothing():String
        {
            return this._style.textureSmoothing;
        }

        public function set textureSmoothing(arg1:String):void
        {
            this._style.textureSmoothing = arg1;
            return;
        }

        public function get textureRepeat():Boolean
        {
            return this._style.textureRepeat;
        }

        public function set textureRepeat(arg1:Boolean):void
        {
            this._style.textureRepeat = arg1;
            return;
        }

        public function get pixelSnapping():Boolean
        {
            return this._pixelSnapping;
        }

        public function set pixelSnapping(arg1:Boolean):void
        {
            this._pixelSnapping = arg1;
            return;
        }

        public function get numVertices():int
        {
            return this._vertexData.numVertices;
        }

        public function get numIndices():int
        {
            return this._indexData.numIndices;
        }

        public function get numTriangles():int
        {
            return this._indexData.numTriangles;
        }

        public function get vertexFormat():starling.rendering.VertexDataFormat
        {
            return this._style.vertexFormat;
        }

        public static function get defaultStyle():Class
        {
            return sDefaultStyle;
        }

        public static function set defaultStyle(arg1:Class):void
        {
            sDefaultStyle = arg1;
            return;
        }

        var _style:starling.styles.MeshStyle;

        var _vertexData:starling.rendering.VertexData;

        var _indexData:starling.rendering.IndexData;

        var _pixelSnapping:Boolean;

        internal static var sDefaultStyle:Class;

        internal static var sDefaultStyleFactory:Function=null;
    }
}


//  class MeshBatch
package starling.display 
{
    import flash.geom.*;
    import starling.rendering.*;
    import starling.styles.*;
    import starling.utils.*;
    
    public class MeshBatch extends starling.display.Mesh
    {
        public function MeshBatch()
        {
            var loc1:*=new starling.rendering.VertexData();
            var loc2:*=new starling.rendering.IndexData();
            super(loc1, loc2);
            return;
        }

        public override function dispose():void
        {
            if (this._effect) 
            {
                this._effect.dispose();
            }
            super.dispose();
            return;
        }

        public override function setVertexDataChanged():void
        {
            this._vertexSyncRequired = true;
            super.setVertexDataChanged();
            return;
        }

        public override function setIndexDataChanged():void
        {
            this._indexSyncRequired = true;
            super.setIndexDataChanged();
            return;
        }

        internal function setVertexAndIndexDataChanged():void
        {
            var loc1:*;
            this._indexSyncRequired = loc1 = true;
            this._vertexSyncRequired = loc1;
            return;
        }

        internal function syncVertexBuffer():void
        {
            this._effect.uploadVertexData(_vertexData);
            this._vertexSyncRequired = false;
            return;
        }

        internal function syncIndexBuffer():void
        {
            this._effect.uploadIndexData(_indexData);
            this._indexSyncRequired = false;
            return;
        }

        public function clear():void
        {
            if (_parent) 
            {
                setRequiresRedraw();
            }
            _vertexData.numVertices = 0;
            _indexData.numIndices = 0;
            this._vertexSyncRequired = true;
            this._indexSyncRequired = true;
            return;
        }

        public function addMesh(arg1:starling.display.Mesh, arg2:flash.geom.Matrix=null, arg3:Number=1, arg4:starling.utils.MeshSubset=null, arg5:Boolean=false):void
        {
            if (arg5) 
            {
                arg2 = null;
            }
            else if (arg2 == null) 
            {
                arg2 = arg1.transformationMatrix;
            }
            if (arg4 == null) 
            {
                arg4 = sFullMeshSubset;
            }
            var loc1:*=_vertexData.numVertices;
            var loc2:*=_indexData.numIndices;
            var loc3:*=arg1._style;
            if (loc1 == 0) 
            {
                this.setupFor(arg1);
            }
            loc3.batchVertexData(_style, loc1, arg2, arg4.vertexID, arg4.numVertices);
            loc3.batchIndexData(_style, loc2, loc1 - arg4.vertexID, arg4.indexID, arg4.numIndices);
            if (arg3 != 1) 
            {
                _vertexData.scaleAlphas("color", arg3, loc1, arg4.numVertices);
            }
            if (_parent) 
            {
                setRequiresRedraw();
            }
            var loc4:*;
            this._vertexSyncRequired = loc4 = true;
            this._indexSyncRequired = loc4;
            return;
        }

        public function addMeshAt(arg1:starling.display.Mesh, arg2:int, arg3:int):void
        {
            var loc1:*=arg1.numIndices;
            var loc2:*=arg1.numVertices;
            var loc3:*=arg1.transformationMatrix;
            var loc4:*=arg1._style;
            if (_vertexData.numVertices == 0) 
            {
                this.setupFor(arg1);
            }
            loc4.batchVertexData(_style, arg3, loc3, 0, loc2);
            loc4.batchIndexData(_style, arg2, arg3, 0, loc1);
            if (alpha != 1) 
            {
                _vertexData.scaleAlphas("color", alpha, arg3, loc2);
            }
            if (_parent) 
            {
                setRequiresRedraw();
            }
            var loc5:*;
            this._vertexSyncRequired = loc5 = true;
            this._indexSyncRequired = loc5;
            return;
        }

        internal function setupFor(arg1:starling.display.Mesh):void
        {
            var loc1:*=arg1._style;
            var loc2:*=loc1.type;
            if (_style.type != loc2) 
            {
                this.setStyle(new loc2() as starling.styles.MeshStyle, false);
            }
            _style.copyFrom(loc1);
            return;
        }

        public function canAddMesh(arg1:starling.display.Mesh, arg2:int=-1):Boolean
        {
            var loc1:*=_vertexData.numVertices;
            if (loc1 == 0) 
            {
                return true;
            }
            if (arg2 < 0) 
            {
                arg2 = arg1.numVertices;
            }
            if (arg2 == 0) 
            {
                return true;
            }
            if (arg2 + loc1 > MAX_NUM_VERTICES) 
            {
                return false;
            }
            return _style.canBatchWith(arg1._style);
        }

        public override function render(arg1:starling.rendering.Painter):void
        {
            if (_vertexData.numVertices == 0) 
            {
                return;
            }
            if (_pixelSnapping) 
            {
                starling.utils.MatrixUtil.snapToPixels(arg1.state.modelviewMatrix, arg1.pixelSize);
            }
            if (this._batchable) 
            {
                arg1.batchMesh(this);
            }
            else 
            {
                arg1.finishMeshBatch();
                arg1.drawCount = arg1.drawCount + 1;
                arg1.prepareToDraw();
                arg1.excludeFromCache(this);
                if (this._vertexSyncRequired) 
                {
                    this.syncVertexBuffer();
                }
                if (this._indexSyncRequired) 
                {
                    this.syncIndexBuffer();
                }
                _style.updateEffect(this._effect, arg1.state);
                this._effect.render(0, _indexData.numTriangles);
            }
            return;
        }

        public override function setStyle(arg1:starling.styles.MeshStyle=null, arg2:Boolean=true):void
        {
            super.setStyle(arg1, arg2);
            if (this._effect) 
            {
                this._effect.dispose();
            }
            this._effect = style.createEffect();
            this._effect.onRestore = this.setVertexAndIndexDataChanged;
            return;
        }

        public function set numVertices(arg1:int):void
        {
            if (_vertexData.numVertices != arg1) 
            {
                _vertexData.numVertices = arg1;
                this._vertexSyncRequired = true;
                setRequiresRedraw();
            }
            return;
        }

        public function set numIndices(arg1:int):void
        {
            if (_indexData.numIndices != arg1) 
            {
                _indexData.numIndices = arg1;
                this._indexSyncRequired = true;
                setRequiresRedraw();
            }
            return;
        }

        public function get batchable():Boolean
        {
            return this._batchable;
        }

        public function set batchable(arg1:Boolean):void
        {
            if (this._batchable != arg1) 
            {
                this._batchable = arg1;
                setRequiresRedraw();
            }
            return;
        }

        
        {
            sFullMeshSubset = new starling.utils.MeshSubset();
        }

        public static const MAX_NUM_VERTICES:int=65535;

        internal var _effect:starling.rendering.MeshEffect;

        internal var _batchable:Boolean;

        internal var _vertexSyncRequired:Boolean;

        internal var _indexSyncRequired:Boolean;

        internal static var sFullMeshSubset:starling.utils.MeshSubset;
    }
}


//  class MovieClip
package starling.display 
{
    import __AS3__.vec.*;
    import flash.errors.*;
    import flash.media.*;
    import starling.animation.*;
    import starling.events.*;
    import starling.textures.*;
    
    public class MovieClip extends starling.display.Image implements starling.animation.IAnimatable
    {
        public function MovieClip(arg1:__AS3__.vec.Vector.<starling.textures.Texture>, arg2:Number=12)
        {
            if (arg1.length > 0) 
            {
                super(arg1[0]);
                this.init(arg1, arg2);
            }
            else 
            {
                throw new ArgumentError("Empty texture array");
            }
            return;
        }

        public function set muted(arg1:Boolean):void
        {
            this._muted = arg1;
            return;
        }

        public function get soundTransform():flash.media.SoundTransform
        {
            return this._soundTransform;
        }

        public function set soundTransform(arg1:flash.media.SoundTransform):void
        {
            this._soundTransform = arg1;
            return;
        }

        public function get currentFrame():int
        {
            return this._currentFrameID;
        }

        internal function init(arg1:__AS3__.vec.Vector.<starling.textures.Texture>, arg2:Number):void
        {
            if (arg2 <= 0) 
            {
                throw new ArgumentError("Invalid fps: " + arg2);
            }
            var loc1:*=arg1.length;
            this._defaultFrameDuration = 1 / arg2;
            this._loop = true;
            this._playing = true;
            this._currentTime = 0;
            this._currentFrameID = 0;
            this._wasStopped = true;
            this._frames = new Vector.<MovieClipFrame>(0);
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                this._frames[loc2] = new MovieClipFrame(arg1[loc2], this._defaultFrameDuration, this._defaultFrameDuration * loc2);
                ++loc2;
            }
            return;
        }

        public function set currentFrame(arg1:int):void
        {
            if (arg1 < 0 || arg1 >= this.numFrames) 
            {
                throw new ArgumentError("Invalid frame id");
            }
            this.currentTime = this._frames[arg1].startTime;
            return;
        }

        public function get fps():Number
        {
            return 1 / this._defaultFrameDuration;
        }

        public function set fps(arg1:Number):void
        {
            if (arg1 <= 0) 
            {
                throw new ArgumentError("Invalid fps: " + arg1);
            }
            var loc1:*=1 / arg1;
            var loc2:*=loc1 / this._defaultFrameDuration;
            this._currentTime = this._currentTime * loc2;
            this._defaultFrameDuration = loc1;
            var loc3:*=0;
            while (loc3 < this.numFrames) 
            {
                this._frames[loc3].duration = this._frames[loc3].duration * loc2;
                ++loc3;
            }
            this.updateStartTimes();
            return;
        }

        public function get isPlaying():Boolean
        {
            if (this._playing) 
            {
                return this._loop || this._currentTime < this.totalTime;
            }
            return false;
        }

        public function get isComplete():Boolean
        {
            return !this._loop && this._currentTime >= this.totalTime;
        }

        public function addFrame(arg1:starling.textures.Texture, arg2:flash.media.Sound=null, arg3:Number=-1):void
        {
            this.addFrameAt(this.numFrames, arg1, arg2, arg3);
            return;
        }

        public function addFrameAt(arg1:int, arg2:starling.textures.Texture, arg3:flash.media.Sound=null, arg4:Number=-1):void
        {
            var loc2:*=NaN;
            var loc3:*=NaN;
            if (arg1 < 0 || arg1 > this.numFrames) 
            {
                throw new ArgumentError("Invalid frame id");
            }
            if (arg4 < 0) 
            {
                arg4 = this._defaultFrameDuration;
            }
            var loc1:*=new MovieClipFrame(arg2, arg4);
            loc1.sound = arg3;
            this._frames.insertAt(arg1, loc1);
            if (arg1 != this.numFrames) 
            {
                this.updateStartTimes();
            }
            else 
            {
                loc2 = arg1 > 0 ? this._frames[(arg1 - 1)].startTime : 0;
                loc3 = arg1 > 0 ? this._frames[(arg1 - 1)].duration : 0;
                loc1.startTime = loc2 + loc3;
            }
            return;
        }

        public function removeFrameAt(arg1:int):void
        {
            if (arg1 < 0 || arg1 >= this.numFrames) 
            {
                throw new ArgumentError("Invalid frame id");
            }
            if (this.numFrames == 1) 
            {
                throw new flash.errors.IllegalOperationError("Movie clip must not be empty");
            }
            this._frames.removeAt(arg1);
            if (arg1 != this.numFrames) 
            {
                this.updateStartTimes();
            }
            return;
        }

        public function getFrameTexture(arg1:int):starling.textures.Texture
        {
            if (arg1 < 0 || arg1 >= this.numFrames) 
            {
                throw new ArgumentError("Invalid frame id");
            }
            return this._frames[arg1].texture;
        }

        public function setFrameTexture(arg1:int, arg2:starling.textures.Texture):void
        {
            if (arg1 < 0 || arg1 >= this.numFrames) 
            {
                throw new ArgumentError("Invalid frame id");
            }
            this._frames[arg1].texture = arg2;
            return;
        }

        public function getFrameSound(arg1:int):flash.media.Sound
        {
            if (arg1 < 0 || arg1 >= this.numFrames) 
            {
                throw new ArgumentError("Invalid frame id");
            }
            return this._frames[arg1].sound;
        }

        public function setFrameSound(arg1:int, arg2:flash.media.Sound):void
        {
            if (arg1 < 0 || arg1 >= this.numFrames) 
            {
                throw new ArgumentError("Invalid frame id");
            }
            this._frames[arg1].sound = arg2;
            return;
        }

        public function getFrameAction(arg1:int):Function
        {
            if (arg1 < 0 || arg1 >= this.numFrames) 
            {
                throw new ArgumentError("Invalid frame id");
            }
            return this._frames[arg1].action;
        }

        public function setFrameAction(arg1:int, arg2:Function):void
        {
            if (arg1 < 0 || arg1 >= this.numFrames) 
            {
                throw new ArgumentError("Invalid frame id");
            }
            this._frames[arg1].action = arg2;
            return;
        }

        public function getFrameDuration(arg1:int):Number
        {
            if (arg1 < 0 || arg1 >= this.numFrames) 
            {
                throw new ArgumentError("Invalid frame id");
            }
            return this._frames[arg1].duration;
        }

        public function setFrameDuration(arg1:int, arg2:Number):void
        {
            if (arg1 < 0 || arg1 >= this.numFrames) 
            {
                throw new ArgumentError("Invalid frame id");
            }
            this._frames[arg1].duration = arg2;
            this.updateStartTimes();
            return;
        }

        public function reverseFrames():void
        {
            this._frames.reverse();
            this._currentTime = this.totalTime - this._currentTime;
            this._currentFrameID = (this.numFrames - this._currentFrameID - 1);
            this.updateStartTimes();
            return;
        }

        public function play():void
        {
            this._playing = true;
            return;
        }

        public function pause():void
        {
            this._playing = false;
            return;
        }

        public function stop():void
        {
            this._playing = false;
            this._wasStopped = true;
            this.currentFrame = 0;
            return;
        }

        internal function updateStartTimes():void
        {
            var loc1:*=this.numFrames;
            var loc2:*=this._frames[0];
            loc2.startTime = 0;
            var loc3:*=1;
            while (loc3 < loc1) 
            {
                this._frames[loc3].startTime = loc2.startTime + loc2.duration;
                loc2 = this._frames[loc3];
                ++loc3;
            }
            return;
        }

        public function advanceTime(arg1:Number):void
        {
            var loc7:*=false;
            if (!this._playing) 
            {
                return;
            }
            var loc1:*=this._frames[this._currentFrameID];
            if (this._wasStopped) 
            {
                this._wasStopped = false;
                loc1.playSound(this._soundTransform);
                if (loc1.action != null) 
                {
                    loc1.executeAction(this, this._currentFrameID);
                    this.advanceTime(arg1);
                    return;
                }
            }
            if (this._currentTime == this.totalTime) 
            {
                if (this._loop) 
                {
                    this._currentTime = 0;
                    this._currentFrameID = 0;
                    loc1 = this._frames[0];
                    loc1.playSound(this._soundTransform);
                    texture = loc1.texture;
                    if (loc1.action != null) 
                    {
                        loc1.executeAction(this, this._currentFrameID);
                        this.advanceTime(arg1);
                        return;
                    }
                }
                else 
                {
                    return;
                }
            }
            var loc2:*=(this._frames.length - 1);
            var loc3:*=loc1.duration - this._currentTime + loc1.startTime;
            var loc4:*=false;
            var loc5:*=null;
            var loc6:*=this._currentFrameID;
            while (arg1 >= loc3) 
            {
                loc7 = false;
                arg1 = arg1 - loc3;
                this._currentTime = loc1.startTime + loc1.duration;
                if (this._currentFrameID != loc2) 
                {
                    this._currentFrameID = this._currentFrameID + 1;
                    loc7 = true;
                }
                else if (hasEventListener(starling.events.Event.COMPLETE)) 
                {
                    loc4 = true;
                }
                else if (this._loop) 
                {
                    this._currentTime = 0;
                    this._currentFrameID = 0;
                    loc7 = true;
                }
                else 
                {
                    return;
                }
                loc1 = this._frames[this._currentFrameID];
                loc5 = loc1.action;
                if (loc7) 
                {
                    loc1.playSound(this._soundTransform);
                }
                if (loc4) 
                {
                    texture = loc1.texture;
                    dispatchEventWith(starling.events.Event.COMPLETE);
                    this.advanceTime(arg1);
                    return;
                }
                if (loc5 != null) 
                {
                    texture = loc1.texture;
                    loc1.executeAction(this, this._currentFrameID);
                    this.advanceTime(arg1);
                    return;
                }
                loc3 = loc1.duration;
                if (!(arg1 + 0.0001 > loc3 && arg1 - 0.0001 < loc3)) 
                {
                    continue;
                }
                arg1 = loc3;
            }
            if (loc6 != this._currentFrameID) 
            {
                texture = this._frames[this._currentFrameID].texture;
            }
            this._currentTime = this._currentTime + arg1;
            return;
        }

        public function get numFrames():int
        {
            return this._frames.length;
        }

        public function get totalTime():Number
        {
            var loc1:*=this._frames[(this._frames.length - 1)];
            return loc1.startTime + loc1.duration;
        }

        public function get currentTime():Number
        {
            return this._currentTime;
        }

        public function set currentTime(arg1:Number):void
        {
            if (arg1 < 0 || arg1 > this.totalTime) 
            {
                throw new ArgumentError("Invalid time: " + arg1);
            }
            var loc1:*=(this._frames.length - 1);
            this._currentTime = arg1;
            this._currentFrameID = 0;
            while (this._currentFrameID < loc1 && this._frames[this._currentFrameID + 1].startTime <= arg1) 
            {
                var loc3:*;
                var loc4:*=((loc3 = this)._currentFrameID + 1);
                loc3._currentFrameID = loc4;
            }
            var loc2:*=this._frames[this._currentFrameID];
            texture = loc2.texture;
            return;
        }

        public function get loop():Boolean
        {
            return this._loop;
        }

        public function set loop(arg1:Boolean):void
        {
            this._loop = arg1;
            return;
        }

        public function get muted():Boolean
        {
            return this._muted;
        }

        internal var _frames:__AS3__.vec.Vector.<MovieClipFrame>;

        internal var _defaultFrameDuration:Number;

        internal var _currentTime:Number;

        internal var _currentFrameID:int;

        internal var _playing:Boolean;

        internal var _muted:Boolean;

        internal var _wasStopped:Boolean;

        internal var _soundTransform:flash.media.SoundTransform;

        internal var _loop:Boolean;
    }
}

import flash.media.*;
import starling.textures.*;


class MovieClipFrame extends Object
{
    public function MovieClipFrame(arg1:starling.textures.Texture, arg2:Number=0.1, arg3:Number=0)
    {
        super();
        this.texture = arg1;
        this.duration = arg2;
        this.startTime = arg3;
        return;
    }

    public function playSound(arg1:flash.media.SoundTransform):void
    {
        if (this.sound) 
        {
            this.sound.play(0, 0, arg1);
        }
        return;
    }

    public function executeAction(arg1:starling.display.MovieClip, arg2:int):void
    {
        var loc1:*=0;
        if (this.action != null) 
        {
            loc1 = this.action.length;
            if (loc1 != 0) 
            {
                if (loc1 != 1) 
                {
                    if (loc1 != 2) 
                    {
                        throw new Error("Frame actions support zero, one or two parameters: " + "movie:MovieClip, frameID:int");
                    }
                    else 
                    {
                        this.action(arg1, arg2);
                    }
                }
                else 
                {
                    this.action(arg1);
                }
            }
            else 
            {
                this.action();
            }
        }
        return;
    }

    public var texture:starling.textures.Texture;

    public var sound:flash.media.Sound;

    public var duration:Number;

    public var startTime:Number;

    public var action:Function;
}

//  class Quad
package starling.display 
{
    import flash.geom.*;
    import starling.rendering.*;
    import starling.styles.*;
    import starling.textures.*;
    import starling.utils.*;
    
    public class Quad extends starling.display.Mesh
    {
        public function Quad(arg1:Number, arg2:Number, arg3:uint=16777215)
        {
            this._bounds = new flash.geom.Rectangle(0, 0, arg1, arg2);
            var loc1:*=new starling.rendering.VertexData(starling.styles.MeshStyle.VERTEX_FORMAT, 4);
            var loc2:*=new starling.rendering.IndexData(6);
            super(loc1, loc2);
            if (arg1 == 0 || arg2 == 0) 
            {
                throw new ArgumentError("Invalid size: width and height must not be zero");
            }
            this.setupVertices();
            this.color = arg3;
            return;
        }

        protected function setupVertices():void
        {
            var loc1:*="position";
            var loc2:*="texCoords";
            var loc3:*=style.texture;
            var loc4:*=this.vertexData;
            var loc5:*=this.indexData;
            loc5.numIndices = 0;
            loc5.addQuad(0, 1, 2, 3);
            if (loc4.numVertices != 4) 
            {
                loc4.numVertices = 4;
                loc4.trim();
            }
            if (loc3) 
            {
                loc3.setupVertexPositions(loc4, 0, "position", this._bounds);
                loc3.setupTextureCoordinates(loc4, 0, loc2);
            }
            else 
            {
                loc4.setPoint(0, loc1, this._bounds.left, this._bounds.top);
                loc4.setPoint(1, loc1, this._bounds.right, this._bounds.top);
                loc4.setPoint(2, loc1, this._bounds.left, this._bounds.bottom);
                loc4.setPoint(3, loc1, this._bounds.right, this._bounds.bottom);
                loc4.setPoint(0, loc2, 0, 0);
                loc4.setPoint(1, loc2, 1, 0);
                loc4.setPoint(2, loc2, 0, 1);
                loc4.setPoint(3, loc2, 1, 1);
            }
            setRequiresRedraw();
            return;
        }

        public override function getBounds(arg1:starling.display.DisplayObject, arg2:flash.geom.Rectangle=null):flash.geom.Rectangle
        {
            var loc1:*=NaN;
            var loc2:*=NaN;
            if (arg2 == null) 
            {
                arg2 = new flash.geom.Rectangle();
            }
            if (arg1 != this) 
            {
                if (arg1 == parent && !isRotated) 
                {
                    loc1 = this.scaleX;
                    loc2 = this.scaleY;
                    arg2.setTo(x - pivotX * loc1, y - pivotY * loc2, this._bounds.width * loc1, this._bounds.height * loc2);
                    if (loc1 < 0) 
                    {
                        arg2.width = arg2.width * -1;
                        arg2.x = arg2.x - arg2.width;
                    }
                    if (loc2 < 0) 
                    {
                        arg2.height = arg2.height * -1;
                        arg2.y = arg2.y - arg2.height;
                    }
                }
                else if (is3D && stage) 
                {
                    stage.getCameraPosition(arg1, sPoint3D);
                    getTransformationMatrix3D(arg1, sMatrix3D);
                    starling.utils.RectangleUtil.getBoundsProjected(this._bounds, sMatrix3D, sPoint3D, arg2);
                }
                else 
                {
                    getTransformationMatrix(arg1, sMatrix);
                    starling.utils.RectangleUtil.getBounds(this._bounds, sMatrix, arg2);
                }
            }
            else 
            {
                arg2.copyFrom(this._bounds);
            }
            return arg2;
        }

        public override function hitTest(arg1:flash.geom.Point):starling.display.DisplayObject
        {
            if (!visible || !touchable || !hitTestMask(arg1)) 
            {
                return null;
            }
            if (this._bounds.containsPoint(arg1)) 
            {
                return this;
            }
            return null;
        }

        public function readjustSize(arg1:Number=-1, arg2:Number=-1):void
        {
            if (arg1 <= 0) 
            {
                arg1 = texture ? texture.frameWidth : this._bounds.width;
            }
            if (arg2 <= 0) 
            {
                arg2 = texture ? texture.frameHeight : this._bounds.height;
            }
            if (!(arg1 == this._bounds.width) || !(arg2 == this._bounds.height)) 
            {
                this._bounds.setTo(0, 0, arg1, arg2);
                this.setupVertices();
            }
            return;
        }

        public override function set texture(arg1:starling.textures.Texture):void
        {
            if (arg1 != texture) 
            {
                super.texture = arg1;
                this.setupVertices();
            }
            return;
        }

        public static function fromTexture(arg1:starling.textures.Texture):starling.display.Quad
        {
            var loc1:*=new Quad(100, 100);
            loc1.texture = arg1;
            loc1.readjustSize();
            return loc1;
        }

        
        {
            sPoint3D = new flash.geom.Vector3D();
            sMatrix = new flash.geom.Matrix();
            sMatrix3D = new flash.geom.Matrix3D();
        }

        internal var _bounds:flash.geom.Rectangle;

        internal static var sPoint3D:flash.geom.Vector3D;

        internal static var sMatrix:flash.geom.Matrix;

        internal static var sMatrix3D:flash.geom.Matrix3D;
    }
}


//  class Sprite
package starling.display 
{
    public class Sprite extends starling.display.DisplayObjectContainer
    {
        public function Sprite()
        {
            super();
            return;
        }
    }
}


//  class Stage
package starling.display 
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.display3D.*;
    import flash.errors.*;
    import flash.geom.*;
    import starling.core.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.rendering.*;
    import starling.utils.*;
    
    use namespace starling_internal;
    
    public class Stage extends starling.display.DisplayObjectContainer
    {
        public function Stage(arg1:int, arg2:int, arg3:uint=0)
        {
            super();
            this._width = arg1;
            this._height = arg2;
            this._color = arg3;
            this._fieldOfView = 1;
            this._projectionOffset = new flash.geom.Point();
            this._cameraPosition = new flash.geom.Vector3D();
            this._enterFrameEvent = new starling.events.EnterFrameEvent(starling.events.Event.ENTER_FRAME, 0);
            this._enterFrameListeners = new Vector.<starling.display.DisplayObject>(0);
            return;
        }

        public function get focalLength():Number
        {
            return this._width / (2 * Math.tan(this._fieldOfView / 2));
        }

        public function set focalLength(arg1:Number):void
        {
            this._fieldOfView = 2 * Math.atan(this.stageWidth / (2 * arg1));
            return;
        }

        public function get fieldOfView():Number
        {
            return this._fieldOfView;
        }

        public function set fieldOfView(arg1:Number):void
        {
            this._fieldOfView = arg1;
            return;
        }

        public override function hitTest(arg1:flash.geom.Point):starling.display.DisplayObject
        {
            if (!visible || !touchable) 
            {
                return null;
            }
            if (arg1.x < 0 || arg1.x > this._width || arg1.y < 0 || arg1.y > this._height) 
            {
                return null;
            }
            var loc1:*=super.hitTest(arg1);
            return loc1 ? loc1 : this;
        }

        public function get projectionOffset():flash.geom.Point
        {
            return this._projectionOffset;
        }

        public function set projectionOffset(arg1:flash.geom.Point):void
        {
            this._projectionOffset.setTo(arg1.x, arg1.y);
            return;
        }

        public function get cameraPosition():flash.geom.Vector3D
        {
            return this.getCameraPosition(null, this._cameraPosition);
        }

        public function advanceTime(arg1:Number):void
        {
            this._enterFrameEvent.starling_internal::reset(starling.events.Event.ENTER_FRAME, false, arg1);
            broadcastEvent(this._enterFrameEvent);
            return;
        }

        
        {
            sMatrix = new flash.geom.Matrix();
            sMatrix3D = new flash.geom.Matrix3D();
        }

        public function drawToBitmapData(arg1:flash.display.BitmapData=null, arg2:Boolean=true):flash.display.BitmapData
        {
            var loc4:*=0;
            var loc5:*=0;
            var loc1:*=starling.core.Starling.painter;
            var loc2:*=loc1.state;
            var loc3:*=loc1.context;
            if (arg1 == null) 
            {
                loc4 = loc3.backBufferWidth;
                loc5 = loc3.backBufferHeight;
                arg1 = new flash.display.BitmapData(loc4, loc5, arg2);
            }
            loc1.pushState();
            loc2.renderTarget = null;
            loc2.setProjectionMatrix(0, 0, this._width, this._height, this._width, this._height, this.cameraPosition);
            if (arg2) 
            {
                loc1.clear();
            }
            else 
            {
                loc1.clear(this._color, 1);
            }
            render(loc1);
            loc1.finishMeshBatch();
            loc3.drawToBitmapData(arg1);
            loc3.present();
            loc1.popState();
            return arg1;
        }

        public function getStageBounds(arg1:starling.display.DisplayObject, arg2:flash.geom.Rectangle=null):flash.geom.Rectangle
        {
            if (arg2 == null) 
            {
                arg2 = new flash.geom.Rectangle();
            }
            arg2.setTo(0, 0, this._width, this._height);
            getTransformationMatrix(arg1, sMatrix);
            return starling.utils.RectangleUtil.getBounds(arg2, sMatrix, arg2);
        }

        public function getCameraPosition(arg1:starling.display.DisplayObject=null, arg2:flash.geom.Vector3D=null):flash.geom.Vector3D
        {
            getTransformationMatrix3D(arg1, sMatrix3D);
            return starling.utils.MatrixUtil.transformCoords3D(sMatrix3D, this._width / 2 + this._projectionOffset.x, this._height / 2 + this._projectionOffset.y, -this.focalLength, arg2);
        }

        function addEnterFrameListener(arg1:starling.display.DisplayObject):void
        {
            var loc1:*=this._enterFrameListeners.indexOf(arg1);
            if (loc1 < 0) 
            {
                this._enterFrameListeners[this._enterFrameListeners.length] = arg1;
            }
            return;
        }

        function removeEnterFrameListener(arg1:starling.display.DisplayObject):void
        {
            var loc1:*=this._enterFrameListeners.indexOf(arg1);
            if (loc1 >= 0) 
            {
                this._enterFrameListeners.removeAt(loc1);
            }
            return;
        }

        override function getChildEventListeners(arg1:starling.display.DisplayObject, arg2:String, arg3:__AS3__.vec.Vector.<starling.display.DisplayObject>):void
        {
            var loc1:*=0;
            var loc2:*=0;
            if (arg2 == starling.events.Event.ENTER_FRAME && arg1 == this) 
            {
                loc1 = 0;
                loc2 = this._enterFrameListeners.length;
                while (loc1 < loc2) 
                {
                    arg3[arg3.length] = this._enterFrameListeners[loc1];
                    ++loc1;
                }
            }
            else 
            {
                super.getChildEventListeners(arg1, arg2, arg3);
            }
            return;
        }

        public override function set width(arg1:Number):void
        {
            throw new flash.errors.IllegalOperationError("Cannot set width of stage");
        }

        public override function set height(arg1:Number):void
        {
            throw new flash.errors.IllegalOperationError("Cannot set height of stage");
        }

        public override function set x(arg1:Number):void
        {
            throw new flash.errors.IllegalOperationError("Cannot set x-coordinate of stage");
        }

        public override function set y(arg1:Number):void
        {
            throw new flash.errors.IllegalOperationError("Cannot set y-coordinate of stage");
        }

        public override function set scaleX(arg1:Number):void
        {
            throw new flash.errors.IllegalOperationError("Cannot scale stage");
        }

        public override function set scaleY(arg1:Number):void
        {
            throw new flash.errors.IllegalOperationError("Cannot scale stage");
        }

        public override function set rotation(arg1:Number):void
        {
            throw new flash.errors.IllegalOperationError("Cannot rotate stage");
        }

        public override function set skewX(arg1:Number):void
        {
            throw new flash.errors.IllegalOperationError("Cannot skew stage");
        }

        public override function set skewY(arg1:Number):void
        {
            throw new flash.errors.IllegalOperationError("Cannot skew stage");
        }

        public override function set filter(arg1:starling.filters.FragmentFilter):void
        {
            throw new flash.errors.IllegalOperationError("Cannot add filter to stage. Add it to \'root\' instead!");
        }

        public function get color():uint
        {
            return this._color;
        }

        public function set color(arg1:uint):void
        {
            this._color = arg1;
            return;
        }

        public function get stageWidth():int
        {
            return this._width;
        }

        public function set stageWidth(arg1:int):void
        {
            this._width = arg1;
            return;
        }

        public function get stageHeight():int
        {
            return this._height;
        }

        public function set stageHeight(arg1:int):void
        {
            this._height = arg1;
            return;
        }

        public function get starling():starling.core.Starling
        {
            var loc1:*=starling.core.Starling.all;
            var loc2:*=loc1.length;
            var loc3:*=0;
            while (loc3 < loc2) 
            {
                if (loc1[loc3].stage == this) 
                {
                    return loc1[loc3];
                }
                ++loc3;
            }
            return null;
        }

        internal var _width:int;

        internal var _height:int;

        internal var _color:uint;

        internal var _fieldOfView:Number;

        internal var _cameraPosition:flash.geom.Vector3D;

        internal var _enterFrameEvent:starling.events.EnterFrameEvent;

        internal var _enterFrameListeners:__AS3__.vec.Vector.<starling.display.DisplayObject>;

        internal var _projectionOffset:flash.geom.Point;

        internal static var sMatrix3D:flash.geom.Matrix3D;

        internal static var sMatrix:flash.geom.Matrix;
    }
}


