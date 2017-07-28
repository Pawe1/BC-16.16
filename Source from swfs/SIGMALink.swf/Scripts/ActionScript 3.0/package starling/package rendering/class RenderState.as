//class RenderState
package starling.rendering 
{
    import __AS3__.vec.*;
    import flash.display3D.*;
    import flash.display3D.textures.*;
    import flash.geom.*;
    import starling.display.*;
    import starling.textures.*;
    import starling.utils.*;
    
    public class RenderState extends Object
    {
        public function RenderState()
        {
            super();
            this.reset();
            return;
        }

        function get renderTargetBase():flash.display3D.textures.TextureBase
        {
            return this._renderTarget ? this._renderTarget.base : null;
        }

        public function get culling():String
        {
            var loc1:*=(this._miscOptions & 3840) >> 8;
            return CULLING_VALUES[loc1];
        }

        public function set culling(arg1:String):void
        {
            var loc1:*=0;
            if (this.culling != arg1) 
            {
                if (this._onDrawRequired != null) 
                {
                    this._onDrawRequired();
                }
                loc1 = CULLING_VALUES.indexOf(arg1);
                if (loc1 == -1) 
                {
                    throw new ArgumentError("Invalid culling mode");
                }
                this._miscOptions = this._miscOptions & 4294963455 | loc1 << 8;
            }
            return;
        }

        public function get clipRect():flash.geom.Rectangle
        {
            return this._clipRect;
        }

        public function get projectionMatrix3D():flash.geom.Matrix3D
        {
            return this._projectionMatrix3D;
        }

        public function set clipRect(arg1:flash.geom.Rectangle):void
        {
            if (!starling.utils.RectangleUtil.compare(this._clipRect, arg1)) 
            {
                if (this._onDrawRequired != null) 
                {
                    this._onDrawRequired();
                }
                if (arg1) 
                {
                    if (this._clipRect == null) 
                    {
                        this._clipRect = starling.utils.Pool.getRectangle();
                    }
                    this._clipRect.copyFrom(arg1);
                }
                else if (this._clipRect) 
                {
                    starling.utils.Pool.putRectangle(this._clipRect);
                    this._clipRect = null;
                }
            }
            return;
        }

        public function get renderTargetAntiAlias():int
        {
            return this._miscOptions & 15;
        }

        public function get renderTargetSupportsDepthAndStencil():Boolean
        {
            return !((this._miscOptions & 240) == 0);
        }

        public function get is3D():Boolean
        {
            return !(this._modelviewMatrix3D == null);
        }

        function set onDrawRequired(arg1:Function):void
        {
            this._onDrawRequired = arg1;
            return;
        }

        
        {
            new Vector.<String>(4)[0] = flash.display3D.Context3DTriangleFace.NONE;
            new Vector.<String>(4)[1] = flash.display3D.Context3DTriangleFace.FRONT;
            new Vector.<String>(4)[2] = flash.display3D.Context3DTriangleFace.BACK;
            new Vector.<String>(4)[3] = flash.display3D.Context3DTriangleFace.FRONT_AND_BACK;
            sMatrix3D = new flash.geom.Matrix3D();
            sProjectionMatrix3DRev = 0;
        }

        public function copyFrom(arg1:starling.rendering.RenderState):void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=false;
            var loc4:*=false;
            if (this._onDrawRequired != null) 
            {
                loc1 = this._renderTarget ? this._renderTarget.base : null;
                loc2 = arg1._renderTarget ? arg1._renderTarget.base : null;
                loc3 = !((this._miscOptions & 3840) == (arg1._miscOptions & 3840));
                loc4 = this._clipRect || arg1._clipRect ? !starling.utils.RectangleUtil.compare(this._clipRect, arg1._clipRect) : false;
                if (!(this._blendMode == arg1._blendMode) || !(loc1 == loc2) || loc4 || loc3) 
                {
                    this._onDrawRequired();
                }
            }
            this._alpha = arg1._alpha;
            this._blendMode = arg1._blendMode;
            this._renderTarget = arg1._renderTarget;
            this._miscOptions = arg1._miscOptions;
            this._modelviewMatrix.copyFrom(arg1._modelviewMatrix);
            if (this._projectionMatrix3DRev != arg1._projectionMatrix3DRev) 
            {
                this._projectionMatrix3DRev = arg1._projectionMatrix3DRev;
                this._projectionMatrix3D.copyFrom(arg1._projectionMatrix3D);
            }
            if (this._modelviewMatrix3D || arg1._modelviewMatrix3D) 
            {
                this.modelviewMatrix3D = arg1._modelviewMatrix3D;
            }
            if (this._clipRect || arg1._clipRect) 
            {
                this.clipRect = arg1._clipRect;
            }
            return;
        }

        public function reset():void
        {
            this.alpha = 1;
            this.blendMode = starling.display.BlendMode.NORMAL;
            this.culling = flash.display3D.Context3DTriangleFace.NONE;
            this.modelviewMatrix3D = null;
            this.renderTarget = null;
            this.clipRect = null;
            this._projectionMatrix3DRev = 0;
            if (this._modelviewMatrix) 
            {
                this._modelviewMatrix.identity();
            }
            else 
            {
                this._modelviewMatrix = new flash.geom.Matrix();
            }
            if (this._projectionMatrix3D) 
            {
                this._projectionMatrix3D.identity();
            }
            else 
            {
                this._projectionMatrix3D = new flash.geom.Matrix3D();
            }
            if (this._mvpMatrix3D == null) 
            {
                this._mvpMatrix3D = new flash.geom.Matrix3D();
            }
            return;
        }

        public function transformModelviewMatrix(arg1:flash.geom.Matrix):void
        {
            starling.utils.MatrixUtil.prependMatrix(this._modelviewMatrix, arg1);
            return;
        }

        public function transformModelviewMatrix3D(arg1:flash.geom.Matrix3D):void
        {
            if (this._modelviewMatrix3D == null) 
            {
                this._modelviewMatrix3D = starling.utils.Pool.getMatrix3D();
            }
            this._modelviewMatrix3D.prepend(starling.utils.MatrixUtil.convertTo3D(this._modelviewMatrix, sMatrix3D));
            this._modelviewMatrix3D.prepend(arg1);
            this._modelviewMatrix.identity();
            return;
        }

        public function setProjectionMatrix(arg1:Number, arg2:Number, arg3:Number, arg4:Number, arg5:Number=0, arg6:Number=0, arg7:flash.geom.Vector3D=null):void
        {
            var loc1:*;
            var loc2:*;
            this._projectionMatrix3DRev = ++sProjectionMatrix3DRev;
            starling.utils.MatrixUtil.createPerspectiveProjectionMatrix(arg1, arg2, arg3, arg4, arg5, arg6, arg7, this._projectionMatrix3D);
            return;
        }

        public function setProjectionMatrixChanged():void
        {
            var loc1:*;
            var loc2:*;
            this._projectionMatrix3DRev = ++sProjectionMatrix3DRev;
            return;
        }

        public function setModelviewMatricesToIdentity():void
        {
            this._modelviewMatrix.identity();
            if (this._modelviewMatrix3D) 
            {
                this._modelviewMatrix3D.identity();
            }
            return;
        }

        public function get modelviewMatrix():flash.geom.Matrix
        {
            return this._modelviewMatrix;
        }

        public function set modelviewMatrix(arg1:flash.geom.Matrix):void
        {
            this._modelviewMatrix.copyFrom(arg1);
            return;
        }

        public function get modelviewMatrix3D():flash.geom.Matrix3D
        {
            return this._modelviewMatrix3D;
        }

        public function set modelviewMatrix3D(arg1:flash.geom.Matrix3D):void
        {
            if (arg1) 
            {
                if (this._modelviewMatrix3D == null) 
                {
                    this._modelviewMatrix3D = starling.utils.Pool.getMatrix3D(false);
                }
                this._modelviewMatrix3D.copyFrom(arg1);
            }
            else if (this._modelviewMatrix3D) 
            {
                starling.utils.Pool.putMatrix3D(this._modelviewMatrix3D);
                this._modelviewMatrix3D = null;
            }
            return;
        }

        function get onDrawRequired():Function
        {
            return this._onDrawRequired;
        }

        public function set projectionMatrix3D(arg1:flash.geom.Matrix3D):void
        {
            this.setProjectionMatrixChanged();
            this._projectionMatrix3D.copyFrom(arg1);
            return;
        }

        public function get mvpMatrix3D():flash.geom.Matrix3D
        {
            this._mvpMatrix3D.copyFrom(this._projectionMatrix3D);
            if (this._modelviewMatrix3D) 
            {
                this._mvpMatrix3D.prepend(this._modelviewMatrix3D);
            }
            this._mvpMatrix3D.prepend(starling.utils.MatrixUtil.convertTo3D(this._modelviewMatrix, sMatrix3D));
            return this._mvpMatrix3D;
        }

        public function setRenderTarget(arg1:starling.textures.Texture, arg2:Boolean=true, arg3:int=0):void
        {
            var loc1:*=this._renderTarget ? this._renderTarget.base : null;
            var loc2:*=arg1 ? arg1.base : null;
            var loc3:*=starling.utils.MathUtil.min(arg3, 16) | uint(arg2) << 4;
            var loc4:*=!(loc3 == (this._miscOptions & 255));
            if (!(loc1 == loc2) || loc4) 
            {
                if (this._onDrawRequired != null) 
                {
                    this._onDrawRequired();
                }
                this._renderTarget = arg1;
                this._miscOptions = this._miscOptions & 4294967040 | loc3;
            }
            return;
        }

        public function get alpha():Number
        {
            return this._alpha;
        }

        public function set alpha(arg1:Number):void
        {
            this._alpha = arg1;
            return;
        }

        public function get blendMode():String
        {
            return this._blendMode;
        }

        public function set blendMode(arg1:String):void
        {
            if (!(arg1 == starling.display.BlendMode.AUTO) && !(this._blendMode == arg1)) 
            {
                if (this._onDrawRequired != null) 
                {
                    this._onDrawRequired();
                }
                this._blendMode = arg1;
            }
            return;
        }

        public function get renderTarget():starling.textures.Texture
        {
            return this._renderTarget;
        }

        public function set renderTarget(arg1:starling.textures.Texture):void
        {
            this.setRenderTarget(arg1);
            return;
        }

        internal static const CULLING_VALUES:__AS3__.vec.Vector.<String>=new Vector.<String>(4);

        var _alpha:Number;

        var _blendMode:String;

        var _modelviewMatrix:flash.geom.Matrix;

        internal var _miscOptions:uint;

        internal var _renderTarget:starling.textures.Texture;

        internal var _onDrawRequired:Function;

        internal var _modelviewMatrix3D:flash.geom.Matrix3D;

        internal var _projectionMatrix3D:flash.geom.Matrix3D;

        internal var _projectionMatrix3DRev:uint;

        internal var _mvpMatrix3D:flash.geom.Matrix3D;

        internal static var sMatrix3D:flash.geom.Matrix3D;

        internal static var sProjectionMatrix3DRev:uint=0;

        internal var _clipRect:flash.geom.Rectangle;
    }
}


