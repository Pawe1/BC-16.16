//class SubTexture
package starling.textures 
{
    import flash.display3D.textures.*;
    import flash.geom.*;
    import starling.core.*;
    
    use namespace starling_internal;
    
    public class SubTexture extends starling.textures.Texture
    {
        public function SubTexture(arg1:starling.textures.Texture, arg2:flash.geom.Rectangle=null, arg3:Boolean=false, arg4:flash.geom.Rectangle=null, arg5:Boolean=false, arg6:Number=1)
        {
            super();
            var loc1:*;
            starling_internal::setTo(arg1, arg2, arg3, arg4, arg5, arg6);
            return;
        }

        starling_internal function setTo(arg1:starling.textures.Texture, arg2:flash.geom.Rectangle=null, arg3:Boolean=false, arg4:flash.geom.Rectangle=null, arg5:Boolean=false, arg6:Number=1):void
        {
            if (this._region == null) 
            {
                this._region = new flash.geom.Rectangle();
            }
            if (arg2) 
            {
                this._region.copyFrom(arg2);
            }
            else 
            {
                this._region.setTo(0, 0, arg1.width, arg1.height);
            }
            if (arg4) 
            {
                if (this._frame) 
                {
                    this._frame.copyFrom(arg4);
                }
                else 
                {
                    this._frame = arg4.clone();
                }
            }
            else 
            {
                this._frame = null;
            }
            this._parent = arg1;
            this._ownsParent = arg3;
            this._rotated = arg5;
            this._width = (arg5 ? this._region.height : this._region.width) / arg6;
            this._height = (arg5 ? this._region.width : this._region.height) / arg6;
            this._scale = this._parent.scale * arg6;
            if (this._frame && (this._frame.x > 0 || this._frame.y > 0 || this._frame.right < this._width || this._frame.bottom < this._height)) 
            {
                trace("[Starling] Warning: frames inside the texture\'s region are unsupported.");
            }
            this.updateMatrices();
            return;
        }

        internal function updateMatrices():void
        {
            if (this._transformationMatrix) 
            {
                this._transformationMatrix.identity();
            }
            else 
            {
                this._transformationMatrix = new flash.geom.Matrix();
            }
            if (this._transformationMatrixToRoot) 
            {
                this._transformationMatrixToRoot.identity();
            }
            else 
            {
                this._transformationMatrixToRoot = new flash.geom.Matrix();
            }
            if (this._rotated) 
            {
                this._transformationMatrix.translate(0, -1);
                this._transformationMatrix.rotate(Math.PI / 2);
            }
            this._transformationMatrix.scale(this._region.width / this._parent.width, this._region.height / this._parent.height);
            this._transformationMatrix.translate(this._region.x / this._parent.width, this._region.y / this._parent.height);
            var loc1:*=this;
            while (loc1) 
            {
                this._transformationMatrixToRoot.concat(loc1._transformationMatrix);
                loc1 = loc1.parent as starling.textures.SubTexture;
            }
            return;
        }

        public override function dispose():void
        {
            if (this._ownsParent) 
            {
                this._parent.dispose();
            }
            super.dispose();
            return;
        }

        public function get parent():starling.textures.Texture
        {
            return this._parent;
        }

        public function get ownsParent():Boolean
        {
            return this._ownsParent;
        }

        public function get rotated():Boolean
        {
            return this._rotated;
        }

        public function get region():flash.geom.Rectangle
        {
            return this._region;
        }

        public override function get transformationMatrix():flash.geom.Matrix
        {
            return this._transformationMatrix;
        }

        public override function get transformationMatrixToRoot():flash.geom.Matrix
        {
            return this._transformationMatrixToRoot;
        }

        public override function get base():flash.display3D.textures.TextureBase
        {
            return this._parent.base;
        }

        public override function get root():starling.textures.ConcreteTexture
        {
            return this._parent.root;
        }

        public override function get format():String
        {
            return this._parent.format;
        }

        public override function get width():Number
        {
            return this._width;
        }

        public override function get height():Number
        {
            return this._height;
        }

        public override function get nativeWidth():Number
        {
            return this._width * this._scale;
        }

        public override function get nativeHeight():Number
        {
            return this._height * this._scale;
        }

        public override function get mipMapping():Boolean
        {
            return this._parent.mipMapping;
        }

        public override function get premultipliedAlpha():Boolean
        {
            return this._parent.premultipliedAlpha;
        }

        public override function get scale():Number
        {
            return this._scale;
        }

        public override function get frame():flash.geom.Rectangle
        {
            return this._frame;
        }

        internal var _parent:starling.textures.Texture;

        internal var _ownsParent:Boolean;

        internal var _region:flash.geom.Rectangle;

        internal var _frame:flash.geom.Rectangle;

        internal var _rotated:Boolean;

        internal var _width:Number;

        internal var _height:Number;

        internal var _scale:Number;

        internal var _transformationMatrix:flash.geom.Matrix;

        internal var _transformationMatrixToRoot:flash.geom.Matrix;
    }
}


