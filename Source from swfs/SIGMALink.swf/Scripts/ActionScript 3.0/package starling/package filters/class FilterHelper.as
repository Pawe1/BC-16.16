//class FilterHelper
package starling.filters 
{
    import __AS3__.vec.*;
    import flash.display3D.*;
    import flash.geom.*;
    import starling.core.*;
    import starling.display.*;
    import starling.textures.*;
    import starling.utils.*;
    
    use namespace starling_internal;
    
    internal class FilterHelper extends Object implements starling.filters.IFilterHelper
    {
        public function FilterHelper(arg1:String="bgra")
        {
            this.sRegion = new flash.geom.Rectangle();
            super();
            this._usePotTextures = starling.core.Starling.current.profile == flash.display3D.Context3DProfile.BASELINE_CONSTRAINED;
            this._preferredScale = starling.core.Starling.contentScaleFactor;
            this._textureFormat = arg1;
            this._sizeStep = 64;
            this._pool = new Vector.<starling.textures.Texture>(0);
            this._projectionMatrix = new flash.geom.Matrix3D();
            this._targetBounds = new flash.geom.Rectangle();
            this.setSize(this._sizeStep, this._sizeStep);
            return;
        }

        public function putTexture(arg1:starling.textures.Texture):void
        {
            if (arg1) 
            {
                if (arg1.root.nativeWidth == this._nativeWidth && arg1.root.nativeHeight == this._nativeHeight) 
                {
                    this._pool.insertAt(this._pool.length, arg1);
                }
                else 
                {
                    arg1.dispose();
                }
            }
            return;
        }

        public function purge():void
        {
            var loc1:*=0;
            var loc2:*=this._pool.length;
            while (loc1 < loc2) 
            {
                this._pool[loc1].dispose();
                ++loc1;
            }
            this._pool.length = 0;
            return;
        }

        internal function setSize(arg1:Number, arg2:Number):void
        {
            var loc1:*=NaN;
            var loc2:*=this._preferredScale;
            var loc3:*=starling.textures.Texture.maxSize;
            var loc4:*=this.getNativeSize(arg1, loc2);
            var loc5:*=this.getNativeSize(arg2, loc2);
            if (loc4 > loc3 || loc5 > loc3) 
            {
                loc1 = loc3 / Math.max(loc4, loc5);
                loc4 = loc4 * loc1;
                loc5 = loc5 * loc1;
                loc2 = loc2 * loc1;
            }
            if (!(this._nativeWidth == loc4) || !(this._nativeHeight == loc5) || !(this._scale == loc2)) 
            {
                this.purge();
                this._scale = loc2;
                this._nativeWidth = loc4;
                this._nativeHeight = loc5;
            }
            this._width = arg1;
            this._height = arg2;
            return;
        }

        internal function getNativeSize(arg1:Number, arg2:Number):int
        {
            var loc1:*=arg1 * arg2;
            if (this._usePotTextures) 
            {
                return loc1 > this._sizeStep ? starling.utils.MathUtil.getNextPowerOfTwo(loc1) : this._sizeStep;
            }
            return Math.ceil(loc1 / this._sizeStep) * this._sizeStep;
        }

        public function get projectionMatrix3D():flash.geom.Matrix3D
        {
            return this._projectionMatrix;
        }

        public function set projectionMatrix3D(arg1:flash.geom.Matrix3D):void
        {
            this._projectionMatrix.copyFrom(arg1);
            return;
        }

        public function get renderTarget():starling.textures.Texture
        {
            return this._renderTarget;
        }

        public function set renderTarget(arg1:starling.textures.Texture):void
        {
            this._renderTarget = arg1;
            return;
        }

        public function get targetBounds():flash.geom.Rectangle
        {
            return this._targetBounds;
        }

        public function set targetBounds(arg1:flash.geom.Rectangle):void
        {
            this._targetBounds.copyFrom(arg1);
            this.setSize(arg1.width, arg1.height);
            return;
        }

        public function get target():starling.display.DisplayObject
        {
            return this._target;
        }

        public function set target(arg1:starling.display.DisplayObject):void
        {
            this._target = arg1;
            return;
        }

        public function get textureScale():Number
        {
            return this._preferredScale;
        }

        public function set textureScale(arg1:Number):void
        {
            this._preferredScale = arg1 > 0 ? arg1 : starling.core.Starling.contentScaleFactor;
            return;
        }

        public function get textureFormat():String
        {
            return this._textureFormat;
        }

        public function set textureFormat(arg1:String):void
        {
            this._textureFormat = arg1;
            return;
        }

        public function dispose():void
        {
            this.purge();
            return;
        }

        public function start(arg1:int, arg2:Boolean):void
        {
            this._numPasses = arg2 ? arg1 : -1;
            return;
        }

        public function getTexture(arg1:Number=1):starling.textures.Texture
        {
            var loc1:*=null;
            var loc2:*=null;
            if (this._numPasses >= 0) 
            {
                var loc3:*;
                var loc4:*=((loc3 = this)._numPasses - 1);
                loc3._numPasses = loc4;
                if ((loc3 = this)._numPasses == 0) 
                {
                    return null;
                }
            }
            if (this._pool.length) 
            {
                loc1 = this._pool.pop();
            }
            else 
            {
                loc1 = starling.textures.Texture.empty(this._nativeWidth / this._scale, this._nativeHeight / this._scale, true, false, true, this._scale, this._textureFormat);
            }
            if (!starling.utils.MathUtil.isEquivalent(loc1.width, this._width, 0.1) || !starling.utils.MathUtil.isEquivalent(loc1.height, this._height, 0.1) || !starling.utils.MathUtil.isEquivalent(loc1.scale, this._scale * arg1)) 
            {
                this.sRegion.setTo(0, 0, this._width * arg1, this._height * arg1);
                loc2 = loc1 as starling.textures.SubTexture;
                if (loc2) 
                {
                    loc2.starling_internal::setTo(loc1.root, this.sRegion, true, null, false, arg1);
                }
                else 
                {
                    loc1 = new starling.textures.SubTexture(loc1.root, this.sRegion, true, null, false, arg1);
                }
            }
            loc1.root.clear();
            return loc1;
        }

        internal var _width:Number;

        internal var _height:Number;

        internal var _nativeWidth:int;

        internal var _nativeHeight:int;

        internal var _pool:__AS3__.vec.Vector.<starling.textures.Texture>;

        internal var _usePotTextures:Boolean;

        internal var _textureFormat:String;

        internal var _preferredScale:Number;

        internal var _scale:Number;

        internal var _sizeStep:int;

        internal var _numPasses:int;

        internal var _projectionMatrix:flash.geom.Matrix3D;

        internal var _renderTarget:starling.textures.Texture;

        internal var _targetBounds:flash.geom.Rectangle;

        internal var _target:starling.display.DisplayObject;

        internal var sRegion:flash.geom.Rectangle;
    }
}


